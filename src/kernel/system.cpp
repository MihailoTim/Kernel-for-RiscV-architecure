//
// Created by os on 5/31/22.
//

#include "../../h/kernel/system.hpp"
#include "../../h/kernel/riscv.hpp"
#include "../../h/user/syscall_c.h"
#include "../../src/user/tests/userMain.hpp"
#include "../../src/kernel/tests/test2.hpp"
#include "../../h/user/printing.hpp"
#include "../../h/kernel/tcb.hpp"
#include "../../h/kernel/scheduler.hpp"
#include "../../h/user/userWrappers.hpp"

bool System::initialized = false;

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    ((Test*)tst)->a = 17;
    ((Test*)tst)->b = 32;
    ((Test*)tst)->c = 13;

}


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
        initialized = true;

        //initialize the machine
        RiscV::initialize();

        kmem_cache_t* cache1 = kmem_cache_create("Cache 1", 512, nullptr, nullptr);
        kmem_cache_t* cache2 = kmem_cache_create("Cache 1", 1<<15, nullptr, nullptr);
        kmem_cache_alloc(cache1);
        kmem_cache_alloc(cache2);
        kmem_cache_alloc(cache2);
        kmem_cache_alloc(cache2);
        void *ret = kmem_cache_alloc(cache2);

        SlabAllocator::printSlab(cache2->fullHead);

        kmem_cache_free(cache2, ret);

        SlabAllocator::printSlab(cache2->partialHead);

        kmem_cache_info(cache1);
        kmem_cache_info(cache2);
        void* ret1 = kmalloc(1<<17);
        if(ret1 == nullptr){
            ConsoleUtil::printString("ERROR\n");
        }
        else{
            ConsoleUtil::print("",(uint64)ret1,"\n");
        };
        void* ret2 = kmalloc(1<<17);
        if(ret2 == nullptr){
            ConsoleUtil::printString("ERROR\n");
        }
        else{
            ConsoleUtil::print("",(uint64)ret2,"\n");
        };
        for(int i=0;i<BUCKET_SIZE;i++){
            kmem_cache_info(SlabAllocator::sizeN[i]);
        }
        test2();
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
            RiscV::threadDispatchUtil();
        }

        //finalize the machine
        RiscV::finalize();
    }
}