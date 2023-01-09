//
// Created by os on 12/24/22.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_BUDDYALLOCATOR_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_BUDDYALLOCATOR_HPP

#include "../lib/hw.h"
#include "../h/utility.hpp"

class SlabAllocator;

class Buddy{
public:
    static void initialize(void* addr, uint64 block_num);

    static void* alloc(uint64 num);

    static void free(void *addr, uint64 size);

    typedef struct Block{
        Block *next;
    }Bucket;

    static void printList();

    static inline bool canAllocate(uint64 size){
        return head[size] != nullptr;
    };

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

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
        while(num>1){
            num/=2;
            deg++;
        }
        return deg;
    }

    static void split(Block* block, int currentBucket, int startBucket);

    static void insert(void* addr, uint64 size);
    static void compress(uint64 size);

    friend class SlabAllocator;
    friend class RiscV;
};

#endif //KERNEL_FOR_RISCV_ARCHITECURE_BUDDYALLOCATOR_HPP
