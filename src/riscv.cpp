//
// Created by os on 4/28/22.
//

#include "../h/riscv.hpp"
#include "../lib/console.h"

int timer = 0;

void RiscV::handleSupervisorTrap() {

    uint64 scause = RiscV::r_scause();
    uint64 volatile sepc = RiscV::r_sepc()+4;
    //interrupt from ecall
    if(scause == 0x09) {

        uint64 syscallID; //get the syscall arguments from registers a0-a7
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));

        switch(syscallID){
            case 0x01 : executeMemAllocSyscall();break;
            case 0x02 : executeMemFreeSyscall();break;
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