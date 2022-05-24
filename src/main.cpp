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
    printString("consumer A now sleeping\n");
    time_sleep(500);
    while(true);
//    while(head!=10){
//        sem_wait(itemAvailable);
//        __putc(buffer[head++]);
//        sem_signal(spaceAvailable);
//    }
//    printString("\nconsumer done\n");
}

void producerA(void *arg){
    printString("producer A now sleeping\n");
    time_sleep(1000);
    while(true);
//    while(tail!=10) {
//        sem_wait(spaceAvailable);
//        buffer[tail] = string[tail];
//        tail++;
//        sem_signal(itemAvailable);
//    }
//    printString("\nproducer done\n");
}

void producerB(void *arg){
    printString("producer B now sleeping\n");
    time_sleep(800);
    while(true);
//    while(tail!=10) {
//        sem_wait(spaceAvailable);
//        buffer[tail] = string[tail];
//        tail++;
//        sem_signal(itemAvailable);
//    }
//    printString("\nproducer done\n");
}

int main() {

    RiscV::initialize();

    RiscV::enableInterrupts();
//
    userMain();

//    sem_open(&spaceAvailable, 10);
//
//    sem_open(&itemAvailable, 0);
//
//    thread_t threadA, threadB;
//    thread_create(&threadA, consumerA, nullptr);
//
//    thread_create(&threadB, producerA, nullptr);
//
//    time_sleep(100);
//
//
//    while(!((TCB*)threadA)->isFinished() || !((TCB*)threadA)->isFinished())
//        thread_dispatch();

    printString("\nEnd of main\n");

    RiscV::disableInterrupts();

    return 0;
}