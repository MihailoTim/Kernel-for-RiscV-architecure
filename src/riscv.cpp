//
// Created by os on 4/28/22.
//

#include "../h/riscv.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/scheduler.hpp"
#include "../h/printing.hpp"

int timer = 0;

void RiscV::initialize() {
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    MemoryAllocator::initialize();
    Scheduler::initialize();
    TCB::initialize();
}

void RiscV::popSppSpie() {
    asm("csrw sepc, ra");
    asm("sret");
}

void RiscV::handleSupervisorTrap() {

    uint64 volatile scause = RiscV::r_scause();
    //interrupt from ecall
    if(scause == 0x09) {
        uint64 volatile sstatus = RiscV::r_sstatus();
        uint64 volatile sepc = RiscV::r_sepc()+4;

        uint64 syscallID; //get the syscall arguments from registers a0-a7

        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));

        switch(syscallID){
            case 0x01 : executeMemAllocSyscall();break;
            case 0x02 : executeMemFreeSyscall();break;
            case 0x11 : executeThreadCreateSyscall();break;
            case 0x12 : executeThreadExitSyscall();break;
            case 0x13 : executeThreadDispatchSyscall();break;
            case 0x21 : executeSemOpenSyscall();break;
            case 0x22 : executeSemCloseSyscall();break;
            case 0x23 : executeSemWaitSyscall();break;
            case 0x24 : executeSemSignalSyscall();break;
            case 0x31 : executeTimeSleepSyscall();break;
        }

        RiscV::w_sstatus(sstatus);
        RiscV::w_sepc(sepc);
    }

    //timer interrupt
    if(scause == (0x01UL<<63 | 0x1)){

        uint64 volatile sstatus = RiscV::r_sstatus();
        uint64 volatile sepc = RiscV::r_sepc();
        mc_sip(SIP_SSIE);

        TCB::timeSliceCounter++;
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {

            TCB::timeSliceCounter = 0;

            TCB* old = TCB::running;

            old->status = TCB::Status::READY;

            TCB::dispatch();
        }

        RiscV::w_sstatus(sstatus);
        RiscV::w_sepc(sepc);
    }

    if(scause == (0x01UL<<63 | 0x9)){
        console_handler();
        //Utility::printString("Hardware interrupt");
    }
}

void RiscV::executeMemAllocSyscall(){
    uint64 size;
    asm("mv %[size], a1" : [size] "=r" (size));

    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);

    asm("mv a0, %[addr]" : : [addr] "r" (addr));
}

void RiscV::executeMemFreeSyscall() {
    uint64 iaddr, status;
    if(MemoryAllocator::initialized) {
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
        status = MemoryAllocator::kfree((void *) iaddr);;
    }
    else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
}

void RiscV::executeThreadCreateSyscall(){
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
        *((TCB**)ihandle) = tcb;
    }

    asm("mv a0, %[status]" : : [status] "r" (status));
}

void RiscV::executeThreadExitSyscall() {
    uint64 status = 0;

    if(TCB::running == nullptr){
        status = -1;
    }
    else{
        TCB* old = TCB::running;
        old->status = TCB::Status::FINISHED;
        TCB::dispatch();
    }

    asm("mv a0, %[status]" : : [status] "r" (status));
}

void RiscV::executeThreadDispatchSyscall(){
    TCB* old = TCB::running;
    old->status = TCB::Status::READY;
    TCB::dispatch();
}

void RiscV::executeSemOpenSyscall() {

    uint64 ihandle, iinit;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));

    SCB *scb = new SCB(iinit);

    uint64 status;

    if(scb == nullptr){
        status = -1;
    }
    else{
        *((SCB**)ihandle) = scb;
    }

    asm("mv a0, %[status]" : : [status] "r" (status));

}

void RiscV::executeSemCloseSyscall() {
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    delete (SCB*)ihandle;
}

void RiscV::executeSemWaitSyscall() {
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    ((SCB*)ihandle)->wait();

    uint64 status = 0;

    asm("mv a0, %[status]" : : [status] "r" (status));

}

void RiscV::executeSemSignalSyscall() {
    uint64 ihandle;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));

    ((SCB*)ihandle)->signal();

    uint64 status = 0;

    asm("mv a0, %[status]" : : [status] "r" (status));
}

void RiscV::executeTimeSleepSyscall() {
    uint64 itime;

    asm("mv %[itime], a1" : [itime] "=r"(itime));

    printInt(itime);

    TCB::running->sleepTime = itime;


//    Scheduler::putToSleep(TCB::running);

    TCB::dispatch();

    uint64 status = 0;

    asm("mv a0, %[status]" : : [status] "r" (status));
}