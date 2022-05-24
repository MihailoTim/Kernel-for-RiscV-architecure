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
#include "../tests/userMain.hpp"

char buffer[10];
int head = 0;
int tail = 0;
sem_t spaceAvailable, itemAvailable;
char string[11] = "this is ni";


void consumerA(void *arg){
    while(head!=10){
        sem_wait(itemAvailable);
        __putc(buffer[head++]);
        sem_signal(spaceAvailable);
    }
}

void producerA(void *arg){
    while(tail!=10) {
        sem_wait(spaceAvailable);
        buffer[tail] = string[tail];
        tail++;
        sem_signal(itemAvailable);
    }
}

int main() {

    RiscV::initialize();

    RiscV::enableInterrupts();

    userMain();

//    printString("\nEnd of main\n");



    RiscV::disableInterrupts();

    return 0;
}