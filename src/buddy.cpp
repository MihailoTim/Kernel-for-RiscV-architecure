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
    for(int i=0;i<BUCKET_SIZE-1;i++)
        head[i] = tail[i] = nullptr;
}

void* Buddy::alloc(uint64 size) {

    if(size<0 || size>=BUCKET_SIZE)
        return nullptr;

    Block* blk = nullptr;

    for(int i=size;i<BUCKET_SIZE;i++){
        if(head[i] != nullptr){
            blk = head[i];
            head[i] = head[i]->next;
            if(!head[i])
                tail[i] = nullptr;
            split(blk, i, size);
        }
    }
    return blk;
}

void Buddy::free(void *addr, uint64 size) {
    insert(addr,size);
}

void Buddy::insert(void *addr, uint64 size) {
    ConsoleUtil::printString("Insert: ");
    ConsoleUtil::printInt(size);
    ConsoleUtil::printString("\n");
    if(!head[size]){
        head[size] = tail[size] = (Block*)addr;
        head[size]->next = tail[size]->next = nullptr;
    }
    else
        if((uint64)addr < (uint64)head[size]){
            Bucket* newHead = (Bucket*)addr;
            newHead->next = head[size];
            head[size] = newHead;
            compress(size);
        }
        else{
            Block* prev = nullptr, *iter = head[size];
            while(iter != nullptr){
                if((uint64)addr < (uint64)iter) {
                    Block *newBlock = (Block *) addr;
                    newBlock->next = iter;
                    prev->next = newBlock;
                    compress(size);
                    break;
                }
                else
                    iter = iter->next;
            }
    }

}

void Buddy::compress(uint64 size) {
    ConsoleUtil::printString("Compress: ");
    ConsoleUtil::printInt(size);
    ConsoleUtil::printString("\n");
    if(size == BUCKET_SIZE-1)
        return;
    Block *curr = head[size];
    Block *prev = nullptr;
    while(curr && curr->next != nullptr){
        uint64 blkNoCurr = ((uint64)(curr)- (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
        uint64 blkNoNext = ((uint64)(curr->next)- (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
        if(blkNoNext == pair){
            Block *blk = curr;
            if(prev){
                prev->next = blk->next;
            }
            else{
                head[size] = blk->next->next;
            }
            insert(blk, size+1);
        }
        prev = curr;
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