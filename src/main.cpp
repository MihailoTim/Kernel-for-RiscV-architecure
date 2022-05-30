//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../tests/userMain.hpp"
#include "../h/tcb.hpp"


bool userMainFinished = false;

void mainWrapper(void *arg){
    userMain();
    userMainFinished = true;
}

int main() {

    RiscV::initialize();

//    RiscV::enableInterrupts();

    thread_t mainThread;
    thread_create(&mainThread, mainWrapper, nullptr);

    while(!userMainFinished || !RiscV::canFinish()) {
        thread_dispatch();
    }

    RiscV::disableInterrupts();

    return 0;
}