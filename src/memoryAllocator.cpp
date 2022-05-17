//
// Created by os on 5/15/22.
//
#include "../h/memoryAllocator.hpp"
#include "../lib/console.h"
#include "../h/utility.hpp"

MemoryAllocator::BlockHeader* MemoryAllocator::freeMemHead = nullptr;
bool MemoryAllocator::initialized = false;


void MemoryAllocator::initialize() {
    freeMemHead = (BlockHeader*)HEAP_START_ADDR;
    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR;
    freeMemHead->next = nullptr;

    initialized = true;
}

void* MemoryAllocator::kmalloc(size_t size){
    if(size<=0)
        return nullptr;

    size_t byteSize = size<<6; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested

    BlockHeader* blk = freeMemHead, *prev = nullptr;

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
        size_t sz = blk->size;
        if (sz >= byteSize)
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk==nullptr)
        __putc('?');

    if(blk != nullptr){
        size_t  remainingSize = blk->size - byteSize;

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain

            memset((char*)blk+sizeof(BlockHeader), 17, byteSize); //FOR TESTING PURPOSES ONLY: fill acquired space with 1s

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

        blk->prev = nullptr;    //temporary
        blk->next = nullptr;    //temporary

        return (char*)blk + sizeof(BlockHeader);
    }

    return nullptr;
}

void* MemoryAllocator::memset(void *dest, char c, uint64 len) {
    char *mem = (char*)dest;
    for(uint64 i = 0; i < len; i++){
        mem[i] = c;
    }
    return dest;
}

#include "../h/memoryAllocator.hpp"
