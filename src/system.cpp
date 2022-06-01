//
// Created by os on 5/31/22.
//

#include "../h/system.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../tests/userMain.hpp"
#include "../h/tcb.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"
#include "../h/tcb.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/scheduler.hpp"

bool System::initialized = false;

System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
        initialized = true;

        //initialize the machine
        RiscV::initialize();

        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)
//        thread_t mainThread;
//        thread_create(&mainThread, userMainWrapper, nullptr);

        uint64 *stack = (uint64*)MemoryAllocator::kmalloc(DEFAULT_STACK_SIZE);
        TCB* mainThread = new TCB(userMainWrapper, nullptr, stack, DEFAULT_TIME_SLICE);
        Scheduler::put(mainThread);

        TCB::userAddr = (void*)mainThread;

        RiscV::enableInterrupts();

        //return control to user code until it reaches the end
        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (!RiscV::userMainFinished || !RiscV::canFinish()) {
            //printString("dispatchuje se kernel main...\n");
            thread_dispatch();
            //printString("vratio se kernel main\n");
        }
        printString("Zavrsio se kernel main\n");
        Scheduler::showScheduler();

        //finalize the machine
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    userMain();
    RiscV::userMainFinished = true;
}