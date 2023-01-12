//
// Created by os on 1/2/23.
//
#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP

#include "slab_allocator.hpp"

void kmem_init(void* space, int block_num);
kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*));
void* kmem_cache_alloc(kmem_cache_t* cachep);
void kmem_cache_free(kmem_cache_t* cachep, void *objp);
void kmem_cache_destroy(kmem_cache_t* cachep);
void kmem_cache_info(kmem_cache_t* cachep);
int kmem_cache_shrink(kmem_cache_t* cachep);
void* kmalloc(size_t size);
void kfree(const void* objp);
int kmem_cache_error(kmem_cache_t* cachep);


#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP