//
// Created by os on 5/31/22.
//

#include "../h/system.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../tests/userMain.hpp"
#include "../h/printing.hpp"
#include "../h/tcb.hpp"
#include "../h/scheduler.hpp"
#include "../h/consoleUtil.hpp"
#include "../h/buddy.hpp"

bool System::initialized = false;

System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
        initialized = true;

        //initialize the machine
        RiscV::initialize();

        Buddy::printList();

        void* alloc11 = Buddy::alloc(11);
        void* alloc1 = Buddy::alloc(1);

        Buddy::printList();


        ConsoleUtil::printInt((uint64)alloc1);
        ConsoleUtil::printString("\n");
        Buddy::free(alloc1, 1);
        Buddy::free(alloc11, 11);


        Buddy::printList();

//        ConsoleUtil::printInt((uint64)Buddy::BUDDY_START_ADDR, 10);

        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        thread_create(&userMainThread, userMainWrapper, nullptr);

        //return control to user code until it reaches the end
        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
            thread_dispatch();
        }

        //finalize the machine
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
//    int ret = fork();
//
//    if(ret == 0){
//        printString("dete\n");
//    }
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
//    userMain();
}