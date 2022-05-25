//
// Created by os on 4/28/22.
//

#ifndef SYSCALL_CPP_HPP
#define SYSCALL_CPP_HPP

#include "../lib/hw.h"
#include "../h/syscall_c.h"

void* operator new (size_t sz);

void* operator new[](size_t sz);

void operator delete (void *ptr);

class Semaphore{

public:
    Semaphore(unsigned init = 1);
    virtual ~Semaphore();

    int wait();

    int signal();

private:
    sem_t myHandle;
};

class Thread{

public:

    Thread(void(*body)(void*), void*arg);
    virtual ~Thread();

    int start();

    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}

private:
    thread_t myHandle;
    using Body = void(*)(void*);
    Body body;
    void* args;
    static void wrapper(void *arg);
};

class PeriodicThread : public Thread{
    time_t period;
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    void run();
};

class Console{
public:
    static char getc();
    static void putc(char);
};

#endif //SYSCALL_CPP_HPP
