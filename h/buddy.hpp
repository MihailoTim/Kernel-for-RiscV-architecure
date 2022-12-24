//
// Created by os on 12/24/22.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_BUDDY_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_BUDDY_HPP

#include "../lib/hw.h"
#include "../h/constants.hpp"

class Buddy{
public:
    static void initialize();

    static void* alloc(uint64 num);

    static void free(void *addr, uint64 size);

    typedef struct Block{
        Block *next;
    }Bucket;

    static void printList();

private:
    static void* BUDDY_META_DATA_ADDR;
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
        num |= num>>1;
        num |= num>>2;
        num |= num>>4;
        num |= num>>8;
        num |= num>>16;
        num |= num>>32;
        return ++num;
    }

    static void split(Block* block, int currentBucket, int startBucket);

    static void insert(void* addr, uint64 size);
    static void compress(uint64 size);
};

#endif //KERNEL_FOR_RISCV_ARCHITECURE_BUDDY_HPP
