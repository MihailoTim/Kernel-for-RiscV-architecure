//
// Created by os on 1/2/23.
//
#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP

#include "../h/slabAllocator.hpp"

void kmem_init(void* space, int block_num);
kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*));

#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP