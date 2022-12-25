#include "../h/buddy.hpp"
#include "../h/consoleUtil.hpp"

void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
uint64 Buddy::BLOCKS_AVAILABLE = BUDDY_NUMBER_OF_BLOCKS;
Buddy::Bucket* Buddy::head[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};
Buddy::Bucket* Buddy::tail[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};

void Buddy::initialize(){
    Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    Buddy::BLOCKS_AVAILABLE = BUDDY_NUMBER_OF_BLOCKS;
    head[BUCKET_SIZE-1] = tail[BUCKET_SIZE-1] = (Block*)BUDDY_START_ADDR;
    head[BUCKET_SIZE-1]->next = tail[BUCKET_SIZE-1]->next = nullptr;
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
//    ConsoleUtil::printString("INSERT: ");
//    ConsoleUtil::printInt(size);
//    ConsoleUtil::printString("\n");
    if(!head[size]){
        head[size] = tail[size] = (Block*)addr;
        head[size]->next = tail[size]->next = nullptr;
        return;
    }
    else
        if((uint64)addr < (uint64)head[size]){
            Bucket* newHead = (Bucket*)addr;
            newHead->next = head[size];
            head[size] = newHead;
            compress(size);
            return;
        }
        else{
            Block* prev = nullptr, *iter = head[size];
            while(iter != nullptr){
                if((uint64)addr < (uint64)iter) {
                    Block *newBlock = (Block *) addr;
                    newBlock->next = iter;
                    prev->next = newBlock;
                    compress(size);
                    return;
                }
                else
                    iter = iter->next;
            }
    }
    tail[size]->next = (Block*)addr;
    tail[size] = tail[size]->next;
    compress(size);
}

void Buddy::compress(uint64 size) {
//    ConsoleUtil::printString("COMPRESS: ");
//    ConsoleUtil::printInt(size);
//    ConsoleUtil::printString("\n");
//    ConsoleUtil::printString("BEFORE COMPRESSION: \n");
//    printList();
    if(size == BUCKET_SIZE-1)
        return;
    Block *curr = head[size];
    Block *prev = nullptr;
    while(curr && curr->next != nullptr){
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
        Block *blk = curr;
        if(blkNoNext == pair){
            if(prev){
                prev->next = curr->next->next;
            }
            else{
                head[size] = curr->next->next;
            }
        }
        else
            prev = curr;
//        ConsoleUtil::printString("BEFORE INSERTION: \n");
//        printList();
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
            ConsoleUtil::printInt((uint64)tmp,10);
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
}