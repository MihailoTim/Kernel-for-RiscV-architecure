//
// Created by os on 5/15/22.
//

#ifndef OS1_KERNEL_MEMORYALLOCATOR_HPP
#define OS1_KERNEL_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

class MemoryAllocator {
    struct BlockHeader{
        size_t size;  //size of allocated chunk in bytes
        BlockHeader *prev, *next;  //pointers to previous and next block
    };

    static BlockHeader* freeMemHead;    //head of free memory list
    static BlockHeader* allocMemHead;   //head of allocated memory list

    static bool initialized;

    static void* kmalloc(size_t size);

    static uint64 kfree(void* addr);

    static void insertAndMerge(void* addr, BlockHeader **head);

    static void initialize();

    friend class RiscV;

    friend class Utility;

    friend class TCB;

    friend class SCB;

    friend class Scheduler;

};


#endif //OS1_KERNEL_MEMORYALLOCATOR_HPP
