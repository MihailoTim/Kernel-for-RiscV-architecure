//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_TCB_HPP
#define OS1_KERNEL_TCB_HPP

#include "../lib/hw.h"
#include "./riscv.hpp"

class TCB {

    using Body = void(*)(void*);

    struct Context{
        uint64 sp, ra;
    };

    enum Status{RUNNING, READY, FINISHED, BLOCKED};

    TCB();

    TCB(Body body, void* args, uint64* stack, uint64 timeSlice);

    ~TCB();

    static void wrapper(void* args);

    void* operator new(size_t size);

    void operator delete(void* addr);

    void setFinished(bool finished){this->status = Status::FINISHED;}

    void free();

    static void dispatch();

    static void initialize();

    static void contextSwitch(Context *oldContext, Context *runningContext);

    Context context;
    Status status;

    Body body;
    void *args;
    uint64 *stack;

    uint64 timeSlice;

    TCB* next;

    uint64 sleepTime = 0;
    uint64 wakeTime = 0;

    static TCB *running;

    static uint64 timeSliceCounter;

    friend class Scheduler;
    friend class RiscV;
    friend class ConsoleUtil;
    friend class SCB;
};


#endif //OS1_KERNEL_TCB_HPP
