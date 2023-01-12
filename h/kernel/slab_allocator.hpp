//
// Created by os on 12/25/22.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP

#include "utility.hpp"
#include "buddy_allocator.hpp"
#include "console_util.hpp"
#include "cache_t.hpp"

class SlabAllocator{
public:

    static void initialize(void* space, uint64 blockNum);

    static Cache* createCache(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*));

    static void deleteCache(Cache* &cache);

    static bool allocateSlab(Cache *cache);

    static int shrinkCache(Cache* cache);

    static void* allocateSlot(Slab* slab);

    static void* allocateObject(Cache *cache);

    static void* allocateBuffer(size_t size);

    static void freeSlot(Slab* slab, uint64 index);

    static bool freeObject(Cache* cache,const void* addr);

    static void freeBuffer(const void* addr);

    static void printSlab(Slab *slab);

    static void printCache(Cache *cache);

    static Cache *sizeN[13];
    static Cache *cache;
    static Cache *largeSlabCache;

private:
    static void insertIntoList(Slab* &head, Slab* slab);
    static void removeFromList(Slab* &head, Slab* slab);
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
            void* ret = allocateSlot(head);
            if(ret != nullptr)
                return ret;
        }
        return nullptr;
    }

    static inline bool freeFromList(Slab* head,const void* addr){
        while(head){
            uint64 upperBound = SlabAllocator::getUpperBound(head);
            uint64 lowerBound = SlabAllocator::getLowerBound(head);
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
        }
        return false;
    }

    static inline void deleteList(Slab* &head){
        while(head){
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
            head = head->next;
        }
    }

    static const char* names[13];
};

#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP
