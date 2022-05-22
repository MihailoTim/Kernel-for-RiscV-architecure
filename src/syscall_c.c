//
// Created by os on 4/29/22.
//

#include "../h/syscall_c.h"
#include "../lib/console.h"
#include "../lib/hw.h"
#include "../lib/mem.h"

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

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    asm("li a0, 0x11");

    asm("ecall");

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

    return status;
}

int thread_exit(){
    asm("li a0, 0x12");

    asm("ecall");

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

    return status;
}

void thread_dispatch(){
    asm("li a0, 0x13");

    asm("ecall");
}

char getc(){
    return __getc();
}

void putc(char c){
    __putc(c);
}


#ifdef __cplusplus
}
#endif
