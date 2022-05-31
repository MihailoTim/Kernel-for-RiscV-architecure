//
// Created by os on 5/31/22.
//

#include "../h/system.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../tests/userMain.hpp"
#include "../h/tcb.hpp"

bool System::initialized = false;

System::System(){
    if(isRunnable()) {
        initialized = true;

        RiscV::initialize();

        thread_t mainThread;
        thread_create(&mainThread, userMainWrapper, nullptr);

        while (!RiscV::userMainFinished || !RiscV::canFinish()) {
            thread_dispatch();
        }

        RiscV::finalize();
    }
}

void System::userMainWrapper(void *arg){
    userMain();
    RiscV::userMainFinished = true;
}

bool System::isRunnable() {
    return !initialized;
}