//
// Created by os on 12/25/22.
//
#include "../h/slabAllocator.hpp"

Cache* SlabAllocator::cache = nullptr;
Cache* SlabAllocator::sizeN[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};
void* SlabAllocator::startAddr = nullptr;
uint64 SlabAllocator::blocksResponsibleFor = 0;

void SlabAllocator::initialize(void* space, uint64 blockNum) {
    Buddy::initialize(space, blockNum);
    startAddr = space;
    blocksResponsibleFor = blockNum;
    cache = (Cache*)SLAB_META_ADDR_CONST;
    cache->ctor = nullptr;
    cache->dtor = nullptr;
    cache->emptyHead = nullptr;
    cache->partialHead = nullptr;
    cache->fullHead = nullptr;
    cache->objectSize = sizeof(Cache);
    cache->slabSize = DEFAULT_SLAB_SIZE;
}

bool SlabAllocator::allocateSlab(Cache *cache) {
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    if(!slab)
        return false;
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + (slab->totalNumOfSlots>>3) + 1);
    slab->allocated = (bool*)((uint64)slab + sizeof(Slab));
    slab->parent = cache;
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
        slab->allocated[i] = false;
    return true;
}

void* SlabAllocator::allocateSlot(Slab *slab) {
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
        if(!slab->allocated[i]){
            slab->allocated[i] = true;
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
            slab->numOfFreeSlots--;
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;

            if(headTo != headFrom)
                SlabAllocator::move(headFrom, headTo, slab);

            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
        }
    }
    return nullptr;
}

void* SlabAllocator::allocateObject(Cache *cache) {
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    if(ret)
        return ret;
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    if(ret)
        return ret;

    if(!SlabAllocator::allocateSlab(cache))
        return nullptr;

    ret = SlabAllocator::allocateSlot(cache->emptyHead);

    return ret;
}

void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    if(slab->allocated[index]) {
        slab->allocated[index] = false;
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
        slab->numOfFreeSlots++;
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;

        if(slab->isEmpty()) {
            SlabAllocator::removeFromList(headFrom, slab);
            Buddy::free(slab, slab->parent->slabSize);
        }
        else
            if (headTo != headFrom)
                SlabAllocator::move(headFrom, headTo, slab);
    }
}

void SlabAllocator::freeObject(Cache* cache, void *addr) {

    bool deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    if(deleted)
        return;

    deleted = SlabAllocator::freeFromList(cache->fullHead, addr);

}

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    return nullptr;
}

void SlabAllocator::printSlab(Slab *slab) {
    ConsoleUtil::print("Slab address:", (uint64)slab, "\n");
    ConsoleUtil::print("Number of slots:", (uint64)slab->totalNumOfSlots, "\n");
    ConsoleUtil::print("Slab object size:", (uint64)sizeof(Slab), "\n");
    ConsoleUtil::print("Object offset:", (uint64)slab->objectOffset, "\n");
    ConsoleUtil::print("Slab allocated array address:", (uint64)slab->allocated, "\n");
    ConsoleUtil::printString("Allocated status array:\n");
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
        ConsoleUtil::print("", (uint8)slab->allocated[i], " ");
    }
    ConsoleUtil::printString("\n");
}

void SlabAllocator::printCache(Cache *cache) {
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");

    Slab* iter = cache->emptyHead;
    while(iter){
        ConsoleUtil::print("", (uint64)iter, " ");
        iter = iter->next;
    }
    ConsoleUtil::printString("\n");

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");

    iter = cache->partialHead;
    while(iter){
        ConsoleUtil::print("", (uint64)iter, " ");
        iter = iter->next;
    }
    ConsoleUtil::printString("\n");

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");

    iter = cache->fullHead;
    while(iter){
        ConsoleUtil::print("", (uint64)iter, " ");
        iter = iter->next;
    }
    ConsoleUtil::printString("\n");

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
}

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    slab->next = head;
    if(head)
        head->prev = slab;
    slab->prev = nullptr;
    head = slab;
}

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    if(slab == head)
        head = slab->next;
    if(slab->next)
        slab->next->prev = slab->prev;
    if(slab->prev)
        slab->prev->next = slab->next;
    slab->prev = nullptr;
    slab->next = nullptr;
}

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    SlabAllocator::removeFromList(headFrom, slab);
    SlabAllocator::insertIntoList(headTo, slab);
}