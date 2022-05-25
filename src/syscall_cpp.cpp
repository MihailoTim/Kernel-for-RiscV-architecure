//
// Created by os on 4/28/22.
//

#include "../h/syscall_cpp.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"

void* operator new(size_t sz){
    return mem_alloc(sz);
}

void* operator new[](size_t sz){
    return mem_alloc(sz);
}

void operator delete(void *ptr){
    mem_free(ptr);
}

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore(){
    sem_close(myHandle);
};

int Semaphore::wait(){
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    Thread* thr = (Thread*)arg;
    thr->run();
}

Thread::Thread() {
    thread_attach_body(&myHandle, &Thread::wrapper, this);
}

int Thread::sleep(time_t time) {
    return time_sleep(time);
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    delete (uint64*)myHandle;
}

PeriodicThread::PeriodicThread(time_t period) : Thread(){
    this->period = period;
    this->start();
}

void PeriodicThread::run() {
    while(true){
        this->periodicActivation();
        sleep(period);
    }
}

char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}
