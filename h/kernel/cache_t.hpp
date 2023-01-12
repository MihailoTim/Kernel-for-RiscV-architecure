//
// Created by os on 1/2/23.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_CACHE_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_CACHE_HPP

#include "../../lib/hw.h"
#include "utility.hpp"
#include "slab_t.hpp"

typedef class Cache{
public:
    char name[CACHE_MAX_NAME_LENGTH];
    uint64 objectSize;
    uint64 slabSize;
    uint64 errCode;
    void (*ctor)(void*);
    void (*dtor)(void*);

    Slab *emptyHead;
    Slab *partialHead;
    Slab* fullHead;
} kmem_cache_t;

#endif //KERNEL_FOR_RISCV_ARCHITECURE_CACHE_HPP
