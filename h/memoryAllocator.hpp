//
// Created by os on 5/15/22.
//

#ifndef OS1_KERNEL_MEMORYALLOCATOR_HPP
#define OS1_KERNEL_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"
#include "../h/list.hpp"

class MemoryAllocator {
    struct BlockHeader{
        size_t size;  //size of allocated chunk in bytes
        BlockHeader *prev, *next;  //pointers to previous and next block
    };

    static BlockHeader* freeMemHead;
    static bool initialized;

    static void* kfree(void* addr);

    static void* memset(void* dest, char c, uint64 len);

    friend class RiscV;
public:
    static void initialize();
    static void* kmalloc(size_t size);
};


#endif //OS1_KERNEL_MEMORYALLOCATOR_HPP
