//
// Created by os on 5/15/22.
//
#include "../h/memoryAllocator.hpp"
#include "../lib/console.h"
#include "../h/utility.hpp"

MemoryAllocator::BlockHeader* MemoryAllocator::freeMemHead = nullptr;

MemoryAllocator::BlockHeader* MemoryAllocator::allocMemHead = nullptr;

bool MemoryAllocator::initialized = false;


void MemoryAllocator::initialize() {
    freeMemHead = (BlockHeader*)HEAP_START_ADDR;

    allocMemHead = nullptr;

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);

    freeMemHead->next = nullptr;

    initialized = true;
}

void* MemoryAllocator::kmalloc(size_t size){
    if(size<=0 || freeMemHead == nullptr)
        return nullptr;

    size_t byteSize = size<<MEM_BLOCK_OFFS; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested

    BlockHeader* blk = freeMemHead, *prev = nullptr;

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
        if (blk->size >= byteSize + sizeof(BlockHeader))
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
        size_t remainingSize = blk->size - byteSize;

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain

            blk->size = byteSize;
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
            BlockHeader* newBlk = (BlockHeader*)((char*)blk + offset);
            newBlk->next = blk->next;
            newBlk->size = remainingSize - sizeof(BlockHeader);

            if(prev)
                prev->next = newBlk;
            else
                freeMemHead = newBlk;
        }
        else{
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        //insert the blk chunk in list of allocated memory
        Utility::memset((char*)blk+sizeof(BlockHeader), 17, blk->size); //FOR TESTING PURPOSES ONLY: fill acquired space with 1s
        insertAndMerge(blk, &allocMemHead);

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    }

    return nullptr;
}

uint64 MemoryAllocator::kfree(void* ptr){
    BlockHeader *blk = allocMemHead;

    for(; blk != nullptr;blk = blk->next)
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;

    if(blk == nullptr)
        return -1;
    else{
        if(blk->next)
            blk->next->prev = blk->prev;
        if(blk->prev)
            blk->prev->next = blk->next;
        else
            allocMemHead = blk->next;

        //insert blk chunk in list of free memory and try to merge with an already existing block
        Utility::memset((char*)blk+sizeof(BlockHeader), 34, blk->size); //FOR TESTING PURPOSES ONLY: fill acquired space with 1s
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