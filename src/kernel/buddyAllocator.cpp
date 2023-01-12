#include "../../h/kernel/buddyAllocator.hpp"
#include "../../h/kernel/consoleUtil.hpp"

void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
uint64 Buddy::BLOCKS_AVAILABLE = BUDDY_NUMBER_OF_BLOCKS;
Buddy::Bucket* Buddy::head[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};
Buddy::Bucket* Buddy::tail[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};

void Buddy::initialize(void* addr, uint64 block_num){
    Buddy::BUDDY_START_ADDR = addr;
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    Buddy::BLOCKS_AVAILABLE = block_num;
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
}

void* Buddy::alloc(uint64 size) {

    if(size<0 || size>=BUCKET_SIZE)
        return nullptr;

    Block* blk = nullptr;

    for(uint64 i=size;i<BUCKET_SIZE;i++){
        if(head[i] != nullptr){
            blk = head[i];
            head[i] = head[i]->next;
            if(!head[i])
                tail[i] = nullptr;
            split(blk, i, size);
            break;
        }
    }
    return blk;
}

void Buddy::free(void *addr, uint64 size) {
    if(addr == nullptr)
        return;
    insert(addr,size);
}

void Buddy::insert(void *addr, uint64 size) {
    if(!head[size]){
        head[size] = tail[size] = (Block*)addr;
        head[size]->next = tail[size]->next = nullptr;
        return;
    }
    else {
        if ((uint64) addr < (uint64) head[size]) {
            Bucket *newHead = (Bucket *) addr;
            newHead->next = head[size];
            head[size] = newHead;
            compress(size);
            return;
        } else {
            Block *prev = nullptr, *iter = head[size];
            while (iter != nullptr) {
                if ((uint64) addr < (uint64) iter) {
                    Block *newBlock = (Block *) addr;
                    newBlock->next = iter;
                    prev->next = newBlock;
                    compress(size);
                    return;
                } else {
                    prev = iter;
                    iter = iter->next;
                }
            }
        }
    }
    tail[size]->next = (Block*)addr;
    tail[size] = tail[size]->next;
    compress(size);
}

void Buddy::compress(uint64 size) {
    if(size == BUCKET_SIZE-1)
        return;
    Block *curr = head[size];
    Block *prev = nullptr;
    while(curr && curr->next != nullptr){
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
        Block *blk = curr;
        if(blkNoNext == pair){
            if(prev){
                prev->next = curr->next->next;
            }
            else{
                head[size] = curr->next->next;
                if(!head[size])
                    tail[size] = nullptr;
            }
        }
        else
            prev = curr;
        if(blkNoNext == pair){
            blk->next = nullptr;
            insert(blk, size+1);
        }
        curr = curr->next;
    }
}

void Buddy::split(Block *block, int currentBucket, int startBucket) {
    while(--currentBucket>=startBucket){
        if(tail[currentBucket]) {
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
            tail[currentBucket] = tail[currentBucket]->next;
        }
        else{
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
        }
    }
}

void Buddy::printList() {
    for(int i=0;i<BUCKET_SIZE;i++){
        ConsoleUtil::printInt(i,10);
        ConsoleUtil::printString(": ");
        Bucket *tmp = head[i];
        while(tmp != nullptr){
            ConsoleUtil::printInt((uint64)tmp,16);
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
}