//
// Created by os on 4/17/22.
//

#ifndef XV6_CONSUMERPRODUCER_C_API_TEST_H
#define XV6_CONSUMERPRODUCER_C_API_TEST_H

#include "../h/syscall_c.h"

#include "buffer.hpp"

#include "../h/scheduler.hpp"
#include "../h/scb.hpp"

sem_t waitForAll;

struct thread_data {
    int id;
    Buffer *buffer;
    sem_t wait;
};

volatile int threadEnd = 0;

void producerKeyboard(void *arg) {
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
        }
    }

    threadEnd = 1;

    delete data->buffer;

    sem_signal(data->wait);

    printString("ending keyboard\n");

    printString("showing scheduler:\n");

    Scheduler::showScheduler();
}

void producer(void *arg) {
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
        }
    }
    printString("showing scheduler:\n");

    Scheduler::showScheduler();

    sem_signal(data->wait);

    printString("ending producer\n");

    printString("showing scheduler:\n");

    Scheduler::showScheduler();
}

void consumer(void *arg) {
    struct thread_data *data = (struct thread_data *) arg;


    int i = 0;
    while (!threadEnd) {
        int key = data->buffer->get();
        i++;
        if(key < 0)
            printString("pedjo sisaj ga\n");
        //putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
        }

        if (i % 80 == 0) {
            //putc('\n');
        }
    }

    printString("showing scheduler:\n");

    Scheduler::showScheduler();

    sem_signal(data->wait);

    printString("ending consumer\n");

    printString("showing scheduler:\n");

    Scheduler::showScheduler();
}

void producerConsumer_C_API() {
    char input[30];
    int n, threadNum;

    printString("Unesite broj proizvodjaca?\n");
    getString(input, 30);
    threadNum = stringToInt(input);

    printString("Unesite velicinu bafera?\n");
    getString(input, 30);
    n = stringToInt(input);

    printString("Broj proizvodjaca "); printInt(threadNum);
    printString(" i velicina bafera "); printInt(n);
    printString(".\n");

    Buffer *buffer = new Buffer(n);

    sem_open(&waitForAll, 0);

    thread_t threads[threadNum];
    thread_t consumerThread;

    struct thread_data data[threadNum + 1];

    data[threadNum].id = threadNum;
    data[threadNum].buffer = buffer;
    data[threadNum].wait = waitForAll;
    thread_create(&consumerThread, consumer, data + threadNum);

    for (int i = 0; i < threadNum; i++) {
        data[i].id = i;
        data[i].buffer = buffer;
        data[i].wait = waitForAll;

        thread_create(threads + i,
                      i > 0 ? producer : producerKeyboard,
                      data + i);
    }

    thread_dispatch();

    for (int i = 0; i <= threadNum; i++) {
        printString("otiso sam da cekam...\n");
        sem_wait(waitForAll);
        printString("Vratio sam se...\n");
    }
    printString("ending user main\n");
    sem_close(waitForAll);
}

#endif //XV6_CONSUMERPRODUCER_C_API_TEST_H
