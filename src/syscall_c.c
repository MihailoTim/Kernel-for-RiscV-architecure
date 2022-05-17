//
// Created by os on 4/29/22.
//

#include "../h/syscall_c.h"
#include "../lib/console.h"
#include "../lib/hw.h"

#ifdef __cplusplus
extern "C" {
#endif

void *mem_alloc(size_t size){
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    asm("li a0, 0x01");  //put number of syscall in a0
    asm("ecall"); //call trap routine
    uint64 addr = 0;
    asm("mv %[addr], a0" : [addr] "=r" (addr));
    return (void*)addr;
}

int mem_free(void *ptr){
    asm("mv a1, %[ptr]" : : [ptr] "r" (ptr));  //put number of blocks required in a1
    asm("li a0, 0x02");  //put number of syscall in a0
    asm("ecall"); //call trap routine
    uint64 status = 0;
    asm("mv %[status], a0" : [status] "=r" (status));
    return 0;
}

#ifdef __cplusplus
}
#endif
