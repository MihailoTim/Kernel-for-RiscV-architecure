//
// Created by os on 4/29/22.
//

#include "../h/syscall_c.h"
#include "../lib/console.h"
#include "../lib/hw.h"

#define MEM_BLOCK_OFFS 6

#ifdef __cplusplus
extern "C" {
#endif

void *mem_alloc(size_t size){
    size_t sz = (size + MEM_BLOCK_SIZE -1) >> MEM_BLOCK_OFFS;

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    asm("li a0, 0x01");  //put number of syscall in a0
    asm("ecall");

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));

    return (void*)addr;
}

int mem_free(void *ptr){
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    asm("li a0, 0x02");  //put number of syscall in a0
    asm("ecall");

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

#ifdef __cplusplus
}
#endif
