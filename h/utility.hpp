//
// Created by os on 4/28/22.
//

#ifndef UTILITY_HPP
#define UTILITY_HPP

#include "../lib/hw.h"

#define asm __asm__ volatile
#define MEM_BLOCK_OFFS 6


class Utility {
public:
    static void printString(const char*);

    static void printInt(int, int);

    static void printMemTrace();

    static void* memset(void*, char, uint64);

    static void* memcpy(void*, void*, uint64);

    static uint64 memcmp(void*, void*, uint64);
};


#endif //UTILITY_HPP
