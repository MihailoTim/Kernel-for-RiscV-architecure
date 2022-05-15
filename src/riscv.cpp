//
// Created by os on 4/28/22.
//

#include "../h/riscv.hpp"
#include "../lib/console.h"

int timer = 0;

void RiscV::handleSupervisorTrap() {
    uint64 scause = RiscV::r_scause();
    //interrupt from ecal
    if(scause == 0x09) {
        uint64 sepc = RiscV::r_sepc()+4;
        uint64 a0;
        asm("mv %[a0], a0" : [a0] "=r" (a0));
        if(a0==0x01){
            __putc('X');
        }
        uint64 addr = (uint64)HEAP_START_ADDR;
        asm("mv a0, %[addr]" : : [addr] "r" (addr));
        RiscV::w_sepc(sepc);
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
    }
    asm("csrc sip, 0x02");
}