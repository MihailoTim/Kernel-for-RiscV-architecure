//
// Created by os on 1/2/23.
//
#include "../../h/slab.hpp"

void kmem_init(void* space, int block_num){
    SlabAllocator::initialize(space, block_num);
}

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    return SlabAllocator::createCache(name, size, ctor, dtor);
}

void* kmem_cache_alloc(kmem_cache_t* cachep){
    return SlabAllocator::allocateObject(cachep);
}

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    SlabAllocator::freeObject(cachep, objp);
}

void kmem_cache_destroy(kmem_cache_t* cachep){
    SlabAllocator::deleteCache(cachep);
}

void kmem_cache_info(kmem_cache_t* cachep){
    SlabAllocator::printCache(cachep);
}

int kmem_cache_shrink(kmem_cache_t* cachep){
    return SlabAllocator::shrinkCache(cachep);
}
void* kmalloc(size_t size){
    return SlabAllocator::allocateBuffer(size);
}

void kfree(const void* objp){
    SlabAllocator::freeBuffer(objp);
}