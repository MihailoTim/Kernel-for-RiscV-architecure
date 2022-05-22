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

    bool isFinished(){ return this->status == Status::FINISHED;}

private:

    using Body = void(*)(void*);

    struct Context{
        uint64 sp, ra;
    };

    enum Status{RUNNING, READY, FINISHED};

    TCB();

    TCB(Body body, void* args, uint64* stack);

    ~TCB();

    static void wrapper(void* args);

    void* operator new(size_t size);

    void operator delete(void* addr);

    void setFinished(bool finished){this->status = Status::FINISHED;}

    void free();

    static void yield();

    static void dispatch();

    static void initialize();

    static void contextSwitch(Context *oldContext, Context *runningContext);

    Context context;
    Status status;

    Body body;
    void *args;
    uint64 *stack;

    static TCB *running;

    friend class Scheduler;
    friend class RiscV;
};


#endif //OS1_KERNEL_TCB_HPP
