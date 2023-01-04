//
// Created by os on 4/28/22.
//

#include "../h/syscall_cpp.hpp"

//CPP API for Threads, Semaphores, and others that rely on C API layer
//CPP API is implemented in this way, as the task was to not change given interface or add any non-static members or functions to any class in CPP layer
//Solution is to add only one static wrapper function and then add syscalls where needed to manipulate with handles in similar fashion as with additional members

struct Args{
    void* pt;
    uint64 time;
    Args(void *p, uint64 t) : pt(p), time(t){}
};

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
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    Thread* thr = (Thread*)arg;
    thr->run();
}

Thread::Thread() {
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    if(status == -1)
        myHandle = nullptr;
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
    delete myHandle;
}

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    uint64 time = ((Args*)arg)->time;

    while(true){
        pt->periodicActivation();
        pt->sleep(time);
    }
}

char Console::getc() {
    return ::getc();
}

void Console::putc(char c) {
    ::putc(c);
}
