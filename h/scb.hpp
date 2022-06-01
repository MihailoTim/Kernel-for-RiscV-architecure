//
// Created by os on 5/23/22.
//

#ifndef OS1_KERNEL_SCB_HPP
#define OS1_KERNEL_SCB_HPP

#include "tcb.hpp"
//semaphore control block

class SCB
{
public:
    SCB(int val = 0);
    ~SCB();

    uint64 wait();
    uint64 signal();

    TCB* headBlocked;
    TCB* tailBlocked;

    void* operator new(size_t size);
    void operator delete(void *p);

    static const uint64 SEM_OPEN = 0x21;
    static const uint64 SEM_CLOSE = 0x22;
    static const uint64 SEM_WAIT = 0x23;
    static const uint64 SEM_SIGNAL = 0x24;


private:
    int val, beginVal;

    void block();
    void unblock();

    TCB* getFirstBlocked();
    void removeFirstBlocked();
    void addToBlocked(TCB* pcb);
};


#endif //OS1_KERNEL_SCB_HPP
