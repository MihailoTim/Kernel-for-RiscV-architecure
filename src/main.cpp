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
#include "../tests/Threads_C_API_test.hpp"
#include "../h/workers.hpp"

void wrapper1(void *arg){
    workerBodyX(nullptr);
}

void wrapper2(void *arg){
    workerBodyY(nullptr);
}

int main() {

    RiscV::initialize();

    thread_t threads[2];
    thread_create(&threads[0], wrapper1, nullptr);
    printString("ThreadA created\n");

    thread_create(&threads[1], wrapper2, nullptr);
    printString("ThreadB created\n");

    while(!((TCB*)threads[0])->isFinished() || !((TCB*)threads[1])->isFinished())
        thread_dispatch();

//    RiscV::enableInterrupts();

//    Threads_C_API_test();

//    RiscV::disableInterrupts();

    return 0;
}