//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/tests.hpp"
#include "../h/queue.hpp"
#include "../h/tcb.hpp"
#include "../h/workers.hpp"

void wrapperA(void *args){
    workerBodyA();
}

void wrapperB(void *args){
    workerBodyB();
}


int main() {

    RiscV::initialize();

    thread_t thrMain, thrA, thrB;

    thread_create(&thrMain,nullptr, nullptr);

    thread_create(&thrA, wrapperA, nullptr);

    thread_create(&thrB, wrapperB, nullptr);

    TCB::running =(TCB*)thrMain;

    while(!((TCB*)thrA)->isFinished() || !((TCB*)thrB)->isFinished()){
        TCB::yield();
    }

    Utility::printString("Threads finished\n");

    return 0;
}