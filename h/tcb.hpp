//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_TCB_HPP
#define OS1_KERNEL_TCB_HPP

#include "../lib/hw.h"
#include "../h/scheduler.hpp"
#include "../h/riscv.hpp"

class TCB {
public:
    using Body = void(*)(void*);

    static TCB *running;

    TCB();

    TCB(Body body, void* args);

    ~TCB();

    static void yield();

    void* operator new(size_t size);

    void operator delete(void* addr);

    void setFinished(bool finished){this->status = Status::FINISHED;}

    bool isFinished(){ return this->status == Status::FINISHED;}

    void free();

private:
    struct Context{
        uint64 sp, ra;
    };

    enum Status{RUNNING, READY, FINISHED};

    static void dispatch();

    static void contextSwitch(Context *oldContext, Context *runningContext);

    Context context;
    Status status;

    Body body;
    void *args;
    uint64 *stack;

    friend class Scheduler;
    friend class RiscV;
};


#endif //OS1_KERNEL_TCB_HPP
