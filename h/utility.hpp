//
// Created by os on 12/24/22.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_UTILITY_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_UTILITY_HPP

#include "../lib/hw.h"

#define BUDDY_BLOCK_BITS 12
#define BUDDY_BLOCK_SIZE 4096
#define BUDDY_NUMBER_OF_BLOCKS 4096
#define BUDDY_META_ADDR_CONST (void*)(((uint64)HEAP_START_ADDR >> BUDDY_BLOCK_BITS) << BUDDY_BLOCK_BITS)
#define SLAB_META_ADDR_CONST (void*)((((uint64)HEAP_START_ADDR >> BUDDY_BLOCK_BITS) + 1) << BUDDY_BLOCK_BITS)
#define BUDDY_START_ADDR_CONST (void*)((((uint64)HEAP_START_ADDR >> BUDDY_BLOCK_BITS) + 2) << BUDDY_BLOCK_BITS)
#define FREE_MEMORY_START_CONST (void*)((uint64)BUDDY_START_ADDR_CONST + (BUDDY_NUMBER_OF_BLOCKS << BUDDY_BLOCK_BITS))
#define BUCKET_SIZE 13
#define CACHE_LOWER_BOUND 5
#define CACHE_UPPER_BOUND 17
#define NUMBER_OF_CACHES 13
#define CACHE_MAX_NAME_LENGTH 64
#define DEFAULT_SLAB_SIZE 2
#define BLOCK_SIZE 4096
#define BLOCK_SIZE_BITS 12

extern const char *numbers[13];
extern char *userTextStart;
extern char *userDataStart;
extern char *userDataEnd;
extern char *kernelTextEnd;

#define OS_ENTRY 0x80000000
#define KERNEL_TEXT_END ((uint64)(&kernelTextEnd))
#define USER_TEXT_START ((uint64)(&userTextStart))
#define USER_DATA_START ((uint64)(&userDataStart))
#define USER_DATA_END ((uint64)(&userDataEnd))
#define HEAP_START (uint64)HEAP_START_ADDR
#define HEAP_END (uint64)HEAP_END_ADDR

char* strcpy(const char* src, char* dst);
char* strcat(char* dst, const char* src);

#endif //KERNEL_FOR_RISCV_ARCHITECURE_UTILITY_HPP
