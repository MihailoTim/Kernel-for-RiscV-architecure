//
// Created by os on 5/18/22.
//
#include "../h/workers.hpp"
#include "../lib/console.h"

static uint64 fibonacci(int n){
    if(n==1 || n==0) return n;
    if(n%4==0) TCB::yield();
    return fibonacci(n-1)+ fibonacci(n-2);
}

void workerBodyA(){
    uint8 i=0;

    for(;i<3;i++){
        Utility::printString("A: i=");
        Utility::printInt(i,10);
        __putc('\n');
    }

    Utility::printString("A: yield\n");
    asm("li t1, 7");
    TCB::yield();

    uint64 t1=0;

    asm("mv %[t1], t1" : [t1] "=r"(t1));

    Utility::printString("A: t1=");
    Utility::printInt(t1,10);
    __putc('\n');

    uint64 result = fibonacci(20);
    Utility::printString("A: fibonacci=");
    Utility::printInt(result,10);
    __putc('\n');

    for(;i<6;i++){
        Utility::printString("A: i=");
        Utility::printInt(i,10);
        __putc('\n');
    }

    TCB::running->setFinished(true);
    TCB::yield();

}

void workerBodyB(){
    uint8 i=10;

    for(;i<13;i++){
        Utility::printString("B: i=");
        Utility::printInt(i,10);
        __putc('\n');
    }

    Utility::printString("B: yield\n");
    asm("li t1, 5");
    TCB::yield();

    uint64 result = fibonacci(23);
    Utility::printString("A: fibonacci=");
    Utility::printInt(result,10);
    __putc('\n');

    for(;i<16;i++){
        Utility::printString("B: i=");
        Utility::printInt(i,10);
        __putc('\n');
    }

    TCB::running->setFinished(true);
    TCB::yield();

}