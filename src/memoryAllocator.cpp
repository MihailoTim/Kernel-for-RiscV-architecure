//
// Created by os on 5/15/22.
//
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/buddyAllocator.hpp"

MemoryAllocator::BlockHeader* MemoryAllocator::freeMemHead = nullptr;

MemoryAllocator::BlockHeader* MemoryAllocator::allocMemHead = nullptr;

MemoryAllocator::BlockHeader* MemoryAllocator::freeMemTail = nullptr;

MemoryAllocator::BlockHeader* MemoryAllocator::allocMemTail = nullptr;

bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;

    allocMemHead = allocMemTail = nullptr;

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);

    freeMemHead->next = nullptr;

    initialized = true;
}

void* MemoryAllocator::kmalloc(size_t size){
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested

    BlockHeader* blk = freeMemHead, *prev = nullptr;

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
        if (blk->size >= byteSize + sizeof(BlockHeader))
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;

        size_t remainingSize = blk->size - byteSize;

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain

            blk->size = byteSize;
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
            newBlk = (BlockHeader*)((char*)blk + offset);
            newBlk->next = blk->next;
            newBlk->prev = blk->prev;
            newBlk->size = remainingSize - sizeof(BlockHeader);

            if(prev)
                prev->next = newBlk;
            else {
                freeMemHead = freeMemTail = newBlk;
            }
        }
        else{
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;

            if(nextAllocated){
                blk->prev = nextAllocated->prev;
                blk->prev->next = blk;
                if(nextAllocated->prev)
                    nextAllocated->prev = blk;
                else
                    allocMemHead = blk;
            }
            else{
                allocMemTail->next = blk;
                blk->prev = allocMemTail;
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    }

    return nullptr;
}

//uint64 MemoryAllocator::kfree(void* ptr){
//    BlockHeader *blk = allocMemHead;
//
//    for(; blk != nullptr;blk = blk->next)
//        if((char*)ptr - sizeof(BlockHeader) == (char*)blk) break;
//
//    if(blk == nullptr)
//        return -1;
//    else{
//
//        BlockHeader *iter = blk;
//
//        while((char*)iter+iter->size+sizeof(BlockHeader) == (char*)(iter->next))
//            iter=iter->next;
//
//        BlockHeader *nextFree;
//
//        if((char*)iter + iter->size + sizeof(BlockHeader) < HEAP_END_ADDR)
//            nextFree = (BlockHeader*)((char*)iter + iter->size + sizeof(BlockHeader));
//        else
//            nextFree = nullptr;
//
//        if(blk->prev)
//            blk->prev->next = blk->next;
//        else
//            allocMemHead = blk->next;
//
//        if(blk->next)
//            blk->next->prev = blk->prev;
//        else
//            allocMemTail = blk->prev;
//
//        blk->next = nextFree;
//
//        if(nextFree->prev) {
//            blk->prev = nextFree->prev;
//            nextFree->prev->next = blk;
//        }
//        else {
//            freeMemHead = blk;
//            blk->prev = nullptr;
//        }
//
//        nextFree->prev = blk;
//    }
//    return 0;
//}

uint64 MemoryAllocator::kfree(void* ptr){
    BlockHeader *blk = allocMemHead;

    for(; blk != nullptr;blk = blk->next)
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;

    if(blk == nullptr)
        return -1;
    else{
        if(blk == allocMemTail)
            allocMemTail = blk->prev;
        if(blk == allocMemHead)
            allocMemHead = blk->next;

        if(blk->next)
            blk->next->prev = blk->prev;
        if(blk->prev)
            blk->prev->next = blk->next;

        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
        if((uint64)iter >= (uint64)blk) break;

    blk->next = iter;
    blk->prev = prev;

    if(iter != nullptr)
        iter->prev = blk;

    if(prev == nullptr)
        *head = blk;
    else
        prev->next = blk;

    if(*head == freeMemHead){
        if(blk->next)   //try to merge with next
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
                blk->next = blk->next->next;
            }
        if(blk->prev)   //try to merge with previous
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}

void MemoryAllocator::showMemory() {
    BlockHeader *iter = allocMemHead;
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    while(iter!=nullptr){
        printInt((uint64)iter);
        putc(' ');
        printInt(iter->size);
        putc('\n');
        iter=iter->next;
    }

    printString("NOW SHOWING FREE MEMORY\n");
    iter = freeMemHead;
    while(iter!=nullptr){
        printInt((uint64)iter);
        putc(' ');
        printInt(iter->size);
        putc('\n');
        iter=iter->next;
    }
    printString("================================================================\n");
}


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
        cdst[i] = csrc[i];

    return dst;
}