//
// Created by os on 4/28/22.
//

#include "../h/syscall_cpp.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"

void* operator new(size_t sz){
    asm("mv a1, %[sz]" : : [sz] "r" (sz));
    asm("li a0, 0x01");
    asm("ecall");
    uint64 addr;
    asm("mv %[addr], a0" : [addr] "=r" (addr));
    void *alloc= (void*)HEAP_START_ADDR;
    return alloc;
}

void operator delete(void *ptr){

}

