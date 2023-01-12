//
// Created by os on 5/23/22.
//

#ifndef OS1_KERNEL_SCB_HPP
#define OS1_KERNEL_SCB_HPP

#include "tcb.hpp"
//semaphore control block

class SCB {
    static kmem_cache_t* scbCache;

    int val;

    TCB *blockedHead, *blockedTail;

    SCB(uint64 init);

    ~SCB();

    void wait();

    void signal();

    void block();

    void deblock();

    static int semaphore_free(void *addr);

    static void initialize();

    static void ctor(void*);

    static void dtor(void*);

    void* operator new(size_t size);

    void operator delete(void* addr);

    friend class RiscV;

    friend class ConsoleUtil;

    friend class _semaphore;

};

#endif //OS1_KERNEL_SCB_HPP
