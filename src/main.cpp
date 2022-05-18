//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/tests.hpp"
#include "../h/queue.hpp"
#include "../h/tcb.hpp"
#include "../h/workers.hpp"


int main() {

    RiscV::initialize();

    mallocEverything();

    TCB *thread[3];

    thread[0] = TCB::createThread(nullptr);

    TCB::running = thread[0];

    thread[1] = TCB::createThread(workerBodyA);

    thread[2] = TCB::createThread(workerBodyB);


    Utility::printString("Threads created\n");

    while(!thread[1]->isFinished() || !thread[2]->isFinished()){
        TCB::yield();
    }

    Utility::printString("Threads finished\n");

    delete thread[0];

    delete thread[1];

    return 0;
}