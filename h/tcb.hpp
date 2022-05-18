//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_TCB_HPP
#define OS1_KERNEL_TCB_HPP

#include "../lib/hw.h"
#include "../h/riscv.hpp"

class TCB {
public:
    static TCB *running;

    using Body = void(*)();

    TCB();

    ~TCB();

    static void yield();

    static TCB *createThread(Body body);

    void* operator new(size_t size);

    void operator delete(void* addr);

    bool isFinished(){return finished;}

    void setFinished(bool finished){this->finished = finished;}

private:
    struct Context{
        uint64 sp, ra;
    };

    TCB(Body body);

    static void dispatch();

    static void contextSwitch(Context *oldContext, Context *runningContext);

    Context context;
    Body body;
    uint64 *stack;
    bool finished;

    friend class Scheduler;

};


#endif //OS1_KERNEL_TCB_HPP
