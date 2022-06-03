//
// Created by os on 5/31/22.
//

#include "../h/system.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../tests/userMain.hpp"
#include "../h/printing.hpp"
#include "../h/tcb.hpp"

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
//    for(int i=0;i<2000000;i++) {
//        void* x = mem_alloc(1);
//        if(x==nullptr){
//            printString("alloc\n");
//            break;
//        }
//        int status = mem_free(x);
//        if(status == -1){
//            printString("free\n");
//            break;
//        }
//    }
//    for(int i=0;i<100000;i++){
//        void *x = mem_alloc(1);
//        void *y = mem_alloc(1);
//        if(x == nullptr){
//            printString("alloc\n");
//            printInt(i);
//            break;
//        }
//        int status = mem_free(x);
//        if(status == -1){
//            printString("free\n");
//            printInt(i);
//            break;
//        }
//        if(i%10000==0){
//            printInt(i);
//            putc('\n');
//        }
//        if(y);
//    }

    userMain();
}