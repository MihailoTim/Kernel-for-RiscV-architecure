//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../tests/userMain.hpp"
#include "../h/tcb.hpp"


bool userMainFinished = false;

void mainWrapper(void *arg){
    userMain();
    userMainFinished = true;
}

void wrapperA(void *arg){
    while(char c = getc())
        c++;
    userMainFinished = true;
}

void wrapperB(void* arg){
    for(int i=0;i<50;i++)
        putc('b');
}

int main() {

    RiscV::initialize();

    RiscV::enableInterrupts();

    thread_t mainThread;
    thread_create(&mainThread, mainWrapper, nullptr);

//    thread_t threadA;
//    thread_create(&threadA, wrapperA, nullptr);
//    thread_t threadB;
//    thread_create(&threadB, wrapperB, nullptr);

    while(!userMainFinished || !RiscV::canFinish()) {
        thread_dispatch();
    }

    RiscV::disableInterrupts();

    return 0;
}