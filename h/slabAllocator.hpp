//
// Created by os on 12/25/22.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP

#include "../h/utility.hpp"
#include "../h/buddyAllocator.hpp"
#include "../h/consoleUtil.hpp"

class SlabAllocator{
public:
    typedef class Slab{
    public:
        inline bool isFull(){return numOfFreeSlots == 0;}
        inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
        Slab *prev, *next;
        uint64 numOfFreeSlots;
        uint64 totalNumOfSlots;
        uint64 objectSize;
        bool *allocated;
        void* objectOffset;
    }kmem_slab_t;

    typedef class Cache{
    public:
        char name[CACHE_MAX_NAME_LENGTH];
        uint64 objectSize;
        uint64 slabSize;
        void (*ctor)(void*);
        void (*dtor)(void*);

        Slab *emptyHead;
        Slab *partialHead;
        Slab* fullHead;
    } kmem_cache_t;

    static void initialize(void* space, uint64 blockNum);

    static Cache* createCache(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*));

    static void allocateSlab(Cache *cache);

    static void* allocateSlot(Slab* slab);

    static void printSlab(Slab *slab);

    static void printCache(Cache *cache);

    static Cache *sizeN[13];
    static Cache *cache;
    static void* startAddr;
    static uint64 blocksResponsibleFor;

private:
    static void insertIntoList(Slab** head, Slab* slab);
    static void removeFromList(Slab** head, Slab* slab);
};

#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAN_HPP
