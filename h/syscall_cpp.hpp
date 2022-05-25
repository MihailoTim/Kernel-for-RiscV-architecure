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


#endif //SYSCALL_CPP_HPP
