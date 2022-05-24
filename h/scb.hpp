//
// Created by os on 5/23/22.
//

#ifndef OS1_KERNEL_SCB_HPP
#define OS1_KERNEL_SCB_HPP

#include "riscv.hpp"
//semaphore control block

class SCB {

    int val;

    Queue *blocked;

    SCB(uint64 init);

    ~SCB();

    void wait();

    void signal();

    void block();

    void deblock();

    void* operator new(size_t size);

    void operator delete(void* addr);

    friend class RiscV;

};


#endif //OS1_KERNEL_SCB_HPP
