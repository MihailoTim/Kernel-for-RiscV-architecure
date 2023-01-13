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
#include "../../src/user/tests/userMain.hpp"

bool System::initialized = false;


System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
        initialized = true;

        //initialize the machine
        RiscV::initialize();

        Cache *tmp1 = kmem_cache_create("TMP1", 1<<17, nullptr, nullptr);
//        Cache *tmp2 = kmem_cache_create("TMP2", 2048, nullptr, nullptr);
        void* ret1 = kmem_cache_alloc(tmp1);
        void* ret2 = kmem_cache_alloc(tmp1);
        void* ret3 = kmem_cache_alloc(tmp1);
        if(ret1 && ret2 && ret3){
            SlabAllocator::printSlab(tmp1->partialHead);
            kmem_cache_free(tmp1, ret3);
            SlabAllocator::printSlab(tmp1->partialHead);
            kmem_cache_free(tmp1, ret2);
            kmem_cache_free(tmp1, ret1);
            kmem_cache_info(tmp1);
            Buddy::printList();
            int ret = kmem_cache_shrink(tmp1);
            Buddy::printList();
            ConsoleUtil::print("",ret,"\n",10);
            kmem_cache_info(tmp1);
            kmem_cache_alloc(tmp1);
            SlabAllocator::printSlab(tmp1->partialHead);
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