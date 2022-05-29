//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../tests/userMain.hpp"
#include "../lib/console.h"

char buffer[10];
int head = 0;
int tail = 0;
sem_t spaceAvailable, itemAvailable;
char string[11] = "this is ni";


void consumerA(void *arg){
    while(head!=10){
        sem_wait(itemAvailable);
        putc(buffer[head++]);
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

void wrapperA(void* arg){
    printInt(RiscV::globalTime);
    time_sleep(30);
    printInt(RiscV::globalTime);
}

void wrapperB(void* arg){
    printString("Hello world\n");
}

class Periodic : public PeriodicThread{
public:
    Periodic(time_t period) : PeriodicThread(period){}

    void periodicActivation() override{
        printString("Hello world\n");
    }
};

bool userMainFinished = false;
void mainWrapper(void *arg){
    printString("now in userMain\n");
//    while(true);
//    time_sleep(30);
//    printString("sleep ended\n");
    userMain();
//    char c = 0;
//    char string[10];
//    int i=0;
//    while((c = getc()) != 'q')
//        string[i++] = c;
//    for(int i = 0;i<10;i++)
//        putc(string[i]);
//    putc(c);
//    c++;
//    userMain();
    userMainFinished = true;
}

int main() {

    RiscV::initialize();

    RiscV::enableInterrupts();

//    Periodic *thread = new Periodic(1);
//
//    thread->start();
//
//    if(thread);
//
//    while(true)
//        thread_dispatch();

    thread_t mainThread;
    thread_create(&mainThread, mainWrapper, nullptr);
    while(!userMainFinished || !RiscV::canFinish()) {
        thread_dispatch();
    }
//    userMain();
//
//    thread_t thrA;
//    thread_create(&thrA, wrapperA, nullptr);
//
//    thread_t thrB;
//    thread_create(&thrB, wrapperB, nullptr);
//
//    while(!(((TCB*)thrA)->isFinished())) {
//        thread_dispatch();
//    }

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