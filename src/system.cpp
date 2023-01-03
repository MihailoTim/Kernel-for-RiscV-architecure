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
#include "../h/slabAllocator.hpp"
#include "../h/slab.hpp"

bool System::initialized = false;

struct Test{
    uint64 a,b,c,d,e,f;
};

System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
        initialized = true;

        //initialize the machine
        RiscV::initialize();

        kmem_cache_t* cache1 = kmem_cache_create("Cache 1", sizeof(Test), nullptr, nullptr);

        const int size = 200;

        void* mem[size];

        for(int i = 0; i<size; i++)
            mem[i] = kmem_cache_alloc(cache1);

        kmem_cache_info(cache1);

        for(int i=0;i<size;i++)
            kmem_cache_free(cache1, mem[i]);


        kmem_cache_destroy(cache1);


        for(int i=0; i<BUCKET_SIZE;i++)
            SlabAllocator::deleteCache(SlabAllocator::sizeN[i]);

        Buddy::printList();

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