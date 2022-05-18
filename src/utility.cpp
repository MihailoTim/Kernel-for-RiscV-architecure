//
// Created by os on 4/28/22.
//

#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"
#include "../h/memoryAllocator.hpp"

void Utility::printString(const char *string) {
    while(*string){
        __putc(*string++);
    }
}

void Utility::printInt(int x, int base=10)
{
    int sign = 0;
    const char digits[] = "0123456789abcdef";
    char buf[16];
    int i;

    if(sign && (sign = x < 0))
        x = -x;
    else
        x = x;

    i = 0;
    do {
        buf[i++] = digits[x % base];
    } while((x /= base) != 0);

    if(sign)
        buf[i++] = '-';

    while(--i >= 0)
        __putc(buf[i]);

    __putc('\n');
}

void Utility::printMemTrace() {
    printString("allocated memory list\n");

    MemoryAllocator::BlockHeader *iter = MemoryAllocator::allocMemHead;

    while(iter) {
        Utility::printInt(iter->size,10);
        iter = iter->next;
    }

    __putc('\n');
    __putc('\n');

    iter = MemoryAllocator::freeMemHead;

    printString("free memory list\n");

    while(iter){
        Utility::printInt(iter->size,10);
        iter = iter->next;
    }

    __putc('\n');
    __putc('\n');
}

void* Utility::memset(void *dst, char c, uint64 len) {
    char *cdst = (char*)dst;
    for(uint64 i = 0; i < len; i++){
        cdst[i] = c;
    }
    return dst;
}

void* Utility::memcpy(void *src, void *dst, uint64 len) {
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
        cdst[i] = csrc[i];

    return dst;
}

uint64 Utility::memcmp(void *src, void *dst, uint64 len){
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
        if(csrc[i]<cdst[i])
            return -1;
        else
            if(csrc[i]>cdst[i])
                return 1;

    return 0;
}