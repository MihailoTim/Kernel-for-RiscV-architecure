//
// Created by os on 5/15/22.
//

#ifndef OS1_KERNEL_MEMORYALLOCATOR_HPP
#define OS1_KERNEL_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"
#include "../h/constants.hpp"


class MemoryAllocator {
    struct BlockHeader{
        size_t size;  //size of allocated chunk in bytes
        BlockHeader *prev, *next;  //pointers to previous and next block
    };

    static BlockHeader* freeMemHead, *freeMemTail;    //head of free memory list
    static BlockHeader* allocMemHead, *allocMemTail;   //head of allocated memory list

    static bool initialized;

    static void* kmalloc(size_t size);

    static uint64 kfree(void* addr);

    static void insertAndMerge(void* addr, BlockHeader **head);

    static void initialize();

    static void showMemory();

    static void* memcpy(void *src, void* dst, uint64 len);

    friend class RiscV;

    friend class Utility;

    friend class TCB;

    friend class SCB;

    friend class Scheduler;

    friend class System;

};


#endif //OS1_KERNEL_MEMORYALLOCATOR_HPP
