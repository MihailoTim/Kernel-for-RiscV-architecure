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
    sem_wait(myHandle);
}

int Semaphore::signal() {
    sem_signal(myHandle);
}
