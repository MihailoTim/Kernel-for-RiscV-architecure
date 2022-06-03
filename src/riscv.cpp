//
// Created by os on 4/28/22.
//

#include "../h/riscv.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../h/scheduler.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"

uint64 RiscV::globalTime = 0;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    MemoryAllocator::initialize();
    Scheduler::initialize();
    TCB::initialize();
    ConsoleUtil::initialize();
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    asm("csrw sepc, ra");
    asm("sret");
}

//handler function for traps
void RiscV::handleSupervisorTrap() {

    //read scause
    uint64 volatile scause = RiscV::r_scause();

    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));

    //interrupt from ecall (both user and supervisor mode)
    if(scause == 0x09 || scause == 0x08) {

        //save sstatus and sepc
        //sepc should be increased by 4, since this is an ecall trap
        uint64 volatile sstatus = RiscV::r_sstatus();
        uint64 volatile sepc = RiscV::r_sepc()+4;

        //get the syscall ID from a0
        uint64 syscallID;
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));

        switch(syscallID){
            case 0x01 : executeMemAllocSyscall();break;
            case 0x02 : executeMemFreeSyscall();break;
            case 0x11 : executeThreadCreateSyscall();break;
            case 0x12 : executeThreadExitSyscall();break;
            case 0x13 : executeThreadDispatchSyscall();break;
            case 0x14 : executeThreadAttachBodySyscall();break;
            case 0x15 : executeThreadStartSyscall();break;
            case 0x21 : executeSemOpenSyscall();break;
            case 0x22 : executeSemCloseSyscall();break;
            case 0x23 : executeSemWaitSyscall();break;
            case 0x24 : executeSemSignalSyscall();break;
            case 0x31 : executeTimeSleepSyscall();break;
            case 0x41 : executeGetcSyscall();break;
            case 0x42 : executePutcSyscall();break;
            case 0x43 : executePutcUtilSyscall();break;
        }

        //write previously save sstatus and incremented sepc
        RiscV::w_sstatus(sstatus);
        RiscV::w_sepc(sepc);
    }

    //timer interrupt (in this system's implementation, timer tick is manifested as software interrupt)
    else if(scause == (0x01UL<<63 | 0x1)){

        //save sstatus and sepc
        //this time sepc remains the same
        uint64 volatile sstatus = RiscV::r_sstatus();
        uint64 volatile sepc = RiscV::r_sepc();

        //clear the SIP bit for software interrupt
        mc_sip(SIP_SSIE);


        //increase global time and try to awake threads that are asleep
        globalTime += 1;
        Scheduler::awake();

        //check whether time slice has run out for running thread
        //if so, dispatch
        TCB::timeSliceCounter++;
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {

            TCB::timeSliceCounter = 0;

            TCB* old = TCB::running;

            old->status = TCB::Status::READY;

            TCB::dispatch();
        }

        //write previously save sstatus and sepc
        RiscV::w_sstatus(sstatus);
        RiscV::w_sepc(sepc);
    }

    //hardware interrupt, from console (note that here we only check for keyboard interrupts, handler for output interrupt is ran in a separate thread)
    else if(scause == (0x01UL<<63 | 0x9)){
        //save sstatus and sepc
        //this time sepc remains the same
        uint64 volatile sstatus = RiscV::r_sstatus();
        uint64 volatile sepc = RiscV::r_sepc();

        //get the console status register location, and console status reg value
        uint64 status = CONSOLE_STATUS;
        asm("mv a0, %[status]" : : [status] "r" (status));
        asm("lb a1, 0(a0)");
        asm("mv %[status], a1" : [status] "=r" (status));

        //if keyboard is ready to send data
        if(status & 1UL)
        {
            //fetch the character from CONSOLE_TX_DATA register
            uint64 data;
            char c;
            data = CONSOLE_TX_DATA;
            asm("mv a0, %[data]" : : [data] "r" (data));
            asm("lb a1, 0(a0)");
            asm("mv %[c], a1" : [c] "=r" (c));

            //if there was a getc request put the character into the input buffer, othrewise ignore it
            if(ConsoleUtil::pendingGetc!=0) {
                ConsoleUtil::pendingGetc--;
                ConsoleUtil::putInput(c);
            }
        }
        plic_complete(plic_claim());

        RiscV::w_sstatus(sstatus);
        RiscV::w_sepc(sepc);
    }

    //illegal instruction, exit running thread
    else if(scause == 0x02){
        TCB* old = TCB::running;
        old->status = TCB::Status::FINISHED;
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
        TCB::dispatch();
    }

    else{
        printString("Error: \n");
        printString("scause: ");
        printInt(scause);
        printString("sepc: ");
        uint64 volatile sepc = RiscV::r_sepc();
        printInt(sepc);
        TCB* old = TCB::running;
        old->status = TCB::Status::FINISHED;
        ConsoleUtil::printString("Exiting thread...\n");
        TCB::dispatch();
    }

    RiscV::jumpToDesignatedPrivilegeMode();
}

void RiscV::executeMemAllocSyscall(){

    //fetch the arguments from a0-a7 registers
    uint64 size;
    asm("mv %[size], a1" : [size] "=r" (size));

    //call internal allocator and return the address in a0
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);

    asm("mv a0, %[addr]" : : [addr] "r" (addr));

    RiscV::saveA0toSscratch();
}

void RiscV::executeMemFreeSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 iaddr, status;


    if(MemoryAllocator::initialized) {
        //call internal allocator and free memory which iaddr points to
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
        status = MemoryAllocator::kfree((void *) iaddr);;
    }
    else
        status = -1;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadCreateSyscall(){

    //fetch the arguments from a0-a7 registers
    uint64 iroutine, iargs, ihandle, istack;

    asm("mv %[istack], a7" : [istack] "=r"(istack));
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));

    //call constructor for Thread Control Block and if not null, write thread address into ihandle
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);

    uint64 status = 0;

    if(tcb == nullptr){
        status = -1;
    }
    else{
        if(tcb->body)
            Scheduler::put(tcb);
        *((TCB**)ihandle) = tcb;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadAttachBodySyscall(){

    //fetch the arguments from a0-a7 registers
    uint64 iroutine, iargs, ihandle, istack;


    asm("mv %[istack], a7" : [istack] "=r"(istack));
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));

    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);

    uint64 status = 0;

    if(tcb == nullptr){
        status = -1;
    }
    else{
        tcb->body = (TCB::Body)iroutine;
        tcb->args = (void*)iargs;
        *((TCB**)ihandle) = tcb;
    }

    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadStartSyscall(){

    //fetch the arguments from a0-a7 registers
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    //get the handle and put tcb in scheduler if not null
    TCB* tcb =(TCB*)ihandle;

    uint64 status = 0;

    if(tcb == nullptr){
        status = -1;
    }
    else{
        tcb->status = TCB::Status::READY;
        Scheduler::put(tcb);
        TCB::dispatch();
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadExitSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 status = 0;

    //if thread not null, set status to finished and dispatch
    if(TCB::running == nullptr){
        status = -1;
    }
    else{
        TCB* old = TCB::running;
        old->status = TCB::Status::FINISHED;
        TCB::dispatch();
    }

    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){

    //dispatch current running thread
    TCB* old = TCB::running;
    old->status = TCB::Status::READY;
    TCB::dispatch();
}

void RiscV::executeSemOpenSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 ihandle, iinit;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));

    //create new Semaphore Control Block and write it into ihandle if not null
    SCB *scb = new SCB(iinit);

    uint64 status = 0;

    if(scb == nullptr){
        status = -1;
    }
    else{
        *((SCB**)ihandle) = scb;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();

}

void RiscV::executeSemCloseSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    //delete scb if not null
    SCB *scb = (SCB*)ihandle;
    uint64 status = 0;

    if(scb == nullptr){
        status = -1;
    }
    else
        delete (SCB*)ihandle;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeSemWaitSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    uint64 status = 0;
    //call wait method on ihandle scb

    if(((SCB*)ihandle) != nullptr)
        ((SCB*)ihandle)->wait();
    else
        status = -1;

    if(TCB::running->semError != nullptr)
        status = -1;
    else
        status = 0;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();

}

void RiscV::executeSemSignalSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    //call signal method on ihandle scb

    uint64 status = 0;

    if(((SCB*)ihandle) != nullptr)
        ((SCB*)ihandle)->signal();
    else
        status = -1;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeTimeSleepSyscall() {

    //fetch the arguments from a0-a7 registers
    uint64 itime;

    asm("mv %[itime], a1" : [itime] "=r"(itime));

    //calculate wake time for running thread and put it to sleep
    //fetch new running with dispatch
    TCB* tcb = TCB::running;
    tcb->sleepTime = globalTime;
    tcb->wakeTime = globalTime + itime;

    Scheduler::sleep(tcb);

    tcb->status = TCB::Status::BLOCKED;

    TCB::dispatch();

    uint64 status = 0;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeGetcSyscall() {

    //register a pending getc call
    ConsoleUtil::pendingGetc++;

    //get character from input buffer
    char c = ConsoleUtil::getInput();

    //if char == \n echo it as LF and CR
    if(c==13) {
        ConsoleUtil::putOutput(13);
        ConsoleUtil::putOutput(10);
    }
    //if not ESC character, echo it to console
    else if(c!=0x01b)
        ConsoleUtil::putOutput(c);

    //return character
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {

    //register a pending putc call
    ConsoleUtil::pendingPutc++;

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));

    //put character in output buffer
    ConsoleUtil::putOutput(c);
}

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    while(true)
    {
        //read console status from status register
        uint64 status = CONSOLE_STATUS;
        asm("mv a0, %[status]" : : [status] "r" (status));
        asm("lb a1, 0(a0)");
        asm("mv %[status], a1" : [status] "=r" (status));

        //if console ready..
        if(status & 1UL<<5){

            //get character from output buffer with possible block if nothing in buffer
                char volatile c = ConsoleUtil::putcUtilSyscall();
                uint64 data = CONSOLE_RX_DATA;
                asm("mv a0, %[data]" : : [data] "r"(data));
                asm("mv a1, %[c]" : : [c] "r"(c));
                asm("sb a1,0(a0)");

            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    }
}

void RiscV::executePutcUtilSyscall() {
    char c = ConsoleUtil::getOutput();
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );

    RiscV::saveA0toSscratch();
}

void RiscV::jumpToDesignatedPrivilegeMode() {
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}

void RiscV::finalize() {

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail);

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
        Scheduler::readyHead = Scheduler::readyHead->next;
}


void RiscV::saveA0toSscratch()
{
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    asm("sd a0, 80(a1)");
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
}