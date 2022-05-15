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
    asm("li a0, 0x01");
    asm("mv a1, %[sz]" : : [sz] "r" (sz));
    asm("ecall");
    return (void*)HEAP_START_ADDR;
}


#ifdef __cplusplus
}
#endif
