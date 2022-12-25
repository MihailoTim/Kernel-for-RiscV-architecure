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


        bool error = false;

        void *mem[2048];
        for(int i=0;i<2048;i++){
            mem[i] = Buddy::alloc(0);
            if(!mem[i]){
                error = true;
                break;
            }
        }

        if(error)
            ConsoleUtil::printString("ERROR\n");
        else
            ConsoleUtil::printString("ALL OK\n");

        error = false;

        for(int i=1;i<2048;i++){
            if((uint64)mem[i] - (uint64)mem[i-1] != 4096) {
                error = true;
                break;
            }
        }

        if(error)
            ConsoleUtil::printString("ERROR\n");
        else
            ConsoleUtil::printString("ALL OK\n");

        error = false;

        for(int i=0;i<2048;i++){
            Buddy::free(mem[i],0);
        }

        if(!Buddy::canAllocate(12))
            ConsoleUtil::printString("ERROR\n");
        else
            ConsoleUtil::printString("ALL OK\n");


        Buddy::alloc(11);
        Buddy::alloc(11);

        void *check = Buddy::alloc(0);

        if(check != nullptr)
            ConsoleUtil::printString("ERROR\n");
        else
            ConsoleUtil::printString("ALL OK\n");


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
    userMain();
}