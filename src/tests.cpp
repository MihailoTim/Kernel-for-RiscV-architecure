//
// Created by os on 5/17/22.
//

#include "../h/tests.hpp"

void mallocTest(){
    object* o = new object;
    o->a = 3;
    void* m1 = mem_alloc(10);
    void* m2 = mem_alloc(100);
    void* m3 = mem_alloc(1000);
    void* m4 = mem_alloc(10000);
    void* m5 = mem_alloc(1);

    if(m1 || m2 || m3 || m4 || m5);

    delete (uint64*)m1;
    delete (uint64*)m3;
    delete (uint64*)m4;

    MemoryAllocator::BlockHeader *iter = MemoryAllocator::allocMemHead;
    while(iter) {
        Utility::printInt(iter->size,10);
        __putc('\n');
        iter = iter->next;
    }

    __putc('\n');
    __putc('\n');

    iter = MemoryAllocator::freeMemHead;

    while(iter){
        Utility::printInt(iter->size,10);
        __putc('\n');
        iter = iter->next;
    }
}
