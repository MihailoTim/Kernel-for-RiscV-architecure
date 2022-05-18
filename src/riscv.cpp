//
// Created by os on 4/28/22.
//

#include "../h/riscv.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/scheduler.hpp"

int timer = 0;

void RiscV::handleSupervisorTrap() {

    uint64 volatile scause = RiscV::r_scause();
    uint64 volatile sepc = RiscV::r_sepc()+4;

    //interrupt from ecall
    if(scause == 0x09) {

        uint64 syscallID; //get the syscall arguments from registers a0-a7

        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));

        switch(syscallID){
            case 0x01 : executeMemAllocSyscall();break;
            case 0x02 : executeMemFreeSyscall();break;
            case 0x11 : executeThreadCreateSyscall();break;
            case 0x12 : executeThreadExitSyscall();break;
            case 0x13 : executeThreadDispatch();break;
        }
    }

    //timer interrupt
    if(scause == (0x01UL<<63 | 0x1)){
        timer++;
        if(timer==5) {
        __putc('t');
        __putc('i');
        __putc('m');
        __putc('e');
        __putc('r');
        timer=0;
        }
        asm("csrc sip, 0x02");
    }

    RiscV::w_sepc(sepc);
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
    uint64 volatile iroutine, iargs, ihandle, istack;

    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    asm("mv %[istack], a7" : [istack] "=r"(istack));


    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs);

    uint64 status;

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
        TCB::yield();
        old->free();
    }

    asm("mv a0, %[status]" : : [status] "r" (status));
}

void RiscV::executeThreadDispatch(){
    TCB* old = TCB::running;
    old->status = TCB::Status::READY;
    TCB::yield();
}