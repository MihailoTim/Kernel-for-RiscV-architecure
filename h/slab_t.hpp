//
// Created by os on 1/2/23.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAB_T_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAB_T_HPP
#include "../lib/hw.h"

typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    Slab *prev, *next;
    uint64 numOfFreeSlots;
    uint64 totalNumOfSlots;
    char allocated[1024];
    void* objectOffset;
    Cache* parent;
}kmem_slab_t;

#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAB_T_HPP
