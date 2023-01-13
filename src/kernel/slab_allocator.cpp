//
// Created by os on 12/25/22.
//
#include "../../h/kernel/slab_allocator.hpp"
#include "../../h/kernel/utility.hpp"
#include "../../h/kernel/riscv.hpp"

Cache* SlabAllocator::cache = nullptr;
Cache* SlabAllocator::largeSlabCache = nullptr;
Cache* SlabAllocator::sizeN[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};
const char* SlabAllocator::names[13] = {"Buffer Cache No. 5", "Buffer Cache No. 6", "Buffer Cache No. 7", "Buffer Cache No. 8", "Buffer Cache No. 9", "Buffer Cache No. 10", "Buffer Cache No. 11", "Buffer Cache No. 12", "Buffer Cache No. 13", "Buffer Cache No. 14", "Buffer Cache No. 15", "Buffer Cache No. 16", "Buffer Cache No. 17"};

void SlabAllocator::initialize(void* space, uint64 blockNum) {
    Buddy::initialize(space, blockNum);
    cache = (Cache*)SLAB_META_ADDR_CONST;
    cache->ctor = nullptr;
    cache->dtor = nullptr;
    cache->emptyHead = nullptr;
    cache->partialHead = nullptr;
    cache->fullHead = nullptr;
    cache->objectSize = sizeof(Cache);
    cache->slabSize = DEFAULT_SLAB_SIZE;
    cache->errCode = 0;
    strcpy("Main Cache", cache->name);

    largeSlabCache = (Cache*)BUDDY_META_ADDR_CONST;
    largeSlabCache->ctor = nullptr;
    largeSlabCache->dtor = nullptr;
    largeSlabCache->emptyHead = nullptr;
    largeSlabCache->partialHead = nullptr;
    largeSlabCache->fullHead = nullptr;
    largeSlabCache->objectSize = sizeof(Slab);
    largeSlabCache->slabSize = SLAB_HEADER_DEFAULT_SLAB_SIZE;
    cache->errCode = 0;
    strcpy("Large Slab Cache", cache->name);


    for(int i=0;i<BUCKET_SIZE;i++){
        sizeN[i] = SlabAllocator::createCache(names[i], 1<<(i+CACHE_LOWER_BOUND), nullptr, nullptr);
    }
}

bool SlabAllocator::allocateSlab(Cache *cache) {
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    if(!slab) {
        cache->errCode = 2;
        return false;
    }
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
        slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab));
    slab->parent = cache;
    for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
        slab->allocated[i] = 0;

    if(cache->ctor) {
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
        }
    }
    return true;
}

void* SlabAllocator::allocateSlot(Slab *slab) {
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
        if(!(slab->allocated[i>>3] & (1<<(7 - (i&7))))){
            slab->allocated[i>>3] |= (1<<(7 - (i&7)));
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
            slab->numOfFreeSlots--;
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;

            if(headTo != headFrom)
                SlabAllocator::move(headFrom, headTo, slab);

            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
        }
    }
    slab->parent->errCode = 1;
    return nullptr;
}

void* SlabAllocator::allocateObject(Cache *cache) {
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    if(ret){
        return ret;
    }
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    if(ret){
        return ret;
    }
    if(cache->objectSize <= sizeof(Slab)) {
        if (!SlabAllocator::allocateSlab(cache))
            return nullptr;

        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    }
    else{
        Slab* slab = (Slab*)SlabAllocator::allocateObject(largeSlabCache);
        slab->totalNumOfSlots = slab->numOfFreeSlots = (((1<<cache->slabSize) << BLOCK_SIZE_BITS)) / cache->objectSize;
        if(slab->totalNumOfSlots > MAX_NUMBER_OF_SLOTS)
            slab->totalNumOfSlots = slab->numOfFreeSlots = MAX_NUMBER_OF_SLOTS;
        void* slabOffset = Buddy::alloc(cache->slabSize);
        slab->objectOffset = slabOffset;
        slab->parent = cache;
        slab->next = nullptr;
        for(uint64 i=0;i<(slab->totalNumOfSlots+7)>>3;i++)
            slab->allocated[i] = 0;

        if(cache->ctor) {
            for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
                cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
            }
        }

        SlabAllocator::insertIntoList(cache->emptyHead, slab);
        ret = SlabAllocator::allocateSlot(cache->emptyHead);
    }

    return ret;
}

void* SlabAllocator::allocateBuffer(size_t size) {
    uint64 level = Buddy::getDeg(Buddy::ceil(size));
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
        return nullptr;
    else
        level -= CACHE_LOWER_BOUND;
    return SlabAllocator::allocateObject(sizeN[level]);
}

void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    if(slab->allocated[index>>3] & (1<<(7 - (index&7)))) {
        slab->allocated[index>>3] &= ~(1<<(7 - (index&7)));
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
        slab->numOfFreeSlots++;
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;

//        if(slab->isEmpty()) {
//            SlabAllocator::removeFromList(headFrom, slab);
//            if(slab->parent->objectSize <= sizeof(Slab)) {
//                Buddy::free(slab, slab->parent->slabSize);
//            }
//            else{
//                Buddy::free(slab->objectOffset, slab->parent->slabSize);
//                SlabAllocator::freeObject(largeSlabCache, slab);
//            }
//        }
//        else
            if (headTo != headFrom)
                SlabAllocator::move(headFrom, headTo, slab);
    }
}

bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    if(cache->dtor)
        cache->dtor((void*)addr);
    if(cache->ctor)
        cache->ctor((void*)addr);

    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    if(deleted)
        return deleted;

    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);

    return deleted;
}

void SlabAllocator::freeBuffer(const void *addr) {
    for(int i=0;i<BUCKET_SIZE;i++)
        if(SlabAllocator::freeObject(sizeN[i], addr))
            return;
}

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    if(ret == nullptr)
        return nullptr;
    strcpy(name, ret->name);
    ret->ctor = ctor;
    ret->dtor = dtor;
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    ret->objectSize = size;
    ret->errCode = 0;
    if(size <= sizeof(Slab))
        ret->slabSize = SMALL_CACHE_DEFAULT_SLAB_SIZE;
    else
        ret->slabSize = Buddy::getDeg(Buddy::ceil(size))-10;
    return ret;
}

void SlabAllocator::deleteCache(Cache* &cache) {
    deleteList(cache->fullHead);
    deleteList(cache->partialHead);
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    int ret = 0;
    while(cache->emptyHead){
        ret += (1<<cache->slabSize);
        if(cache->objectSize <= sizeof(Slab)) {
            Buddy::free(cache->emptyHead, cache->slabSize);
        }
        else{
            Buddy::free(cache->emptyHead->objectOffset, cache->slabSize);
            SlabAllocator::freeObject(largeSlabCache, cache->emptyHead);
        }
        cache->emptyHead = cache->emptyHead->next;
    }
    return ret;
}

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
        ConsoleUtil::printString("\nNOW SHOWING SLAB INFO\n");
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n",10);
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n",10);
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n",10);
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
        ConsoleUtil::printString("Allocated status array: ");
        for (uint64 i = 0; i < (slab->totalNumOfSlots+7)>>3; i++) {
            ConsoleUtil::print("", slab->allocated[i], " ");
        }
        ConsoleUtil::printString("\n");
    }
}

void SlabAllocator::printCache(Cache *cache) {
    if(cache) {
        ConsoleUtil::printString("\nNOW SHOWING CACHE INFO\n");
        ConsoleUtil::printString("Cache name: ");
        ConsoleUtil::printString(cache->name);
        ConsoleUtil::printString("\n");
        ConsoleUtil::print("Cache address: ", (uint64) cache, "\n");
        ConsoleUtil::print("Cache slab size: ", (uint64) cache->slabSize, "\n", 10);
        ConsoleUtil::print("Cache object size: ", (uint64) cache->objectSize, "\n", 10);
        ConsoleUtil::print("Empty head: ", (uint64) cache->emptyHead, "\n");

        Slab *iter = cache->emptyHead;
        while (iter) {
            ConsoleUtil::print("", (uint64) iter, " ");
            iter = iter->next;
        }
        ConsoleUtil::printString("\n");

        ConsoleUtil::print("Partial head: ", (uint64) cache->partialHead, "\n");

        iter = cache->partialHead;
        while (iter) {
            ConsoleUtil::print("", (uint64) iter, " ");
            iter = iter->next;
        }
        ConsoleUtil::printString("\n");

        ConsoleUtil::print("Full head: ", (uint64) cache->fullHead, "\n");

        iter = cache->fullHead;
        while (iter) {
            ConsoleUtil::print("", (uint64) iter, " ");
            iter = iter->next;
        }
        ConsoleUtil::printString("\n");
    }
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

int SlabAllocator::cacheErrorHandler(Cache *cache) {
    switch(cache->errCode){
        case 0: ConsoleUtil::printString("No errors\n");break;
        case 1: ConsoleUtil::printString("No available slots\n");break;
        case 2: ConsoleUtil::printString("Couldn't allocate slab\n");break;
    }
    return cache->errCode;
}