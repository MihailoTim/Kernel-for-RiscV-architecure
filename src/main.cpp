//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../tests/userMain.hpp"
#include "../h/syscall_cpp.hpp"

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
    printString("\nconsumer done\n");
}

void producerA(void *arg){
    while(tail!=10) {
        sem_wait(spaceAvailable);
        buffer[tail] = string[tail];
        tail++;
        sem_signal(itemAvailable);
    }
    printString("\nproducer done\n");
}

void wrapper(void* arg){
    printInt(RiscV::globalTime);
    time_sleep(1000);
    printInt(RiscV::globalTime);
}

class Periodic : PeriodicThread{
public:
    Periodic(time_t period) : PeriodicThread(period){}

    void periodicActivation() override{
        printString("Hello world\n");
    }
};

int main() {

    RiscV::initialize();

    RiscV::enableInterrupts();

//    Periodic *thread = new Periodic(1000);
//
//    if(thread);
//
//    while(true)
//        thread_dispatch();

    userMain();
//
//    thread_t thr;
//    thread_create(&thr, wrapper, nullptr);
//
//    while(!(((TCB*)thr)->isFinished())) {
//        thread_dispatch();
//    }
//
//    sem_open(&spaceAvailable, 10);
//
//    sem_open(&itemAvailable, 0);
//
//    thread_t threadA, threadB;
//    int status = thread_create(&threadA, consumerA, nullptr);
//
//    if(status == -1)
//        printString("Thread create fault\n");
//
//    status = thread_create(&threadB, producerA, nullptr);
//
//    if(status == -1)
//        printString("Thread create fault\n");
//
//    while( !((TCB*)threadA)->isFinished() || !((TCB*)threadB)->isFinished() )
//        thread_dispatch();

    printString("\nEnd of main\n");


    RiscV::disableInterrupts();

    return 0;
}