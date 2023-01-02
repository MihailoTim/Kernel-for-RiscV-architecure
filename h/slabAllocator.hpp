//
// Created by os on 12/25/22.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP

#include "../h/utility.hpp"
#include "../h/buddyAllocator.hpp"
#include "../h/consoleUtil.hpp"
#include "../h/cache_t.hpp"

class SlabAllocator{
public:

    static void initialize(void* space, uint64 blockNum);

    static Cache* createCache(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*));

    static bool allocateSlab(Cache *cache);

    static void* allocateSlot(Slab* slab);

    static void* allocateObject(Cache *cache);

    static void freeSlot(Slab* slab, uint64 index);

    static void freeObject(Cache* cache, void* addr);

    static void printSlab(Slab *slab);

    static void printCache(Cache *cache);

    static Cache *sizeN[13];
    static Cache *cache;
    static void* startAddr;
    static uint64 blocksResponsibleFor;

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

    static inline bool freeFromList(Slab* head, void* addr){
        while(head){
            uint64 upperBound = SlabAllocator::getUpperBound(head);
            uint64 lowerBound = SlabAllocator::getLowerBound(head);
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
        }
        return false;
    }

};

#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP
