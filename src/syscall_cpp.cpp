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
    this->body = body;
    this->args = arg;
}

void Thread::wrapper(void *arg) {
    Thread* thr = (Thread*)arg;
    if(thr->body)
        thr->body(thr->args);
    else
        thr->run();
}

Thread::Thread() {
    this->body = nullptr;
    this->args = nullptr;
}

int Thread::sleep(time_t time) {
    return 0;
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::start() {
    return thread_create(&myHandle, &Thread::wrapper, this);
}

Thread::~Thread() {
    delete (uint64*)myHandle;
}

char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}
