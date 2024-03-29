//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_TCB_HPP
#define OS1_KERNEL_TCB_HPP

#include "../lib/hw.h"
#include "./riscv.hpp"

class SCB;

class TCB {
    using Body = void(*)(void*);

    struct Context{
        uint64 sp, ra;
    };

    enum Status{RUNNING, READY, FINISHED, BLOCKED};

    enum Mode{USER, SUPERVISOR};

    TCB();

    TCB(Body body, void* args, uint64* stack, uint64 timeSlice);

    ~TCB();

    static void wrapper(void* args);

    void* operator new(size_t size);

    void operator delete(void* addr);

    void free();

    static void dispatch();

    static void initialize();

    static uint64 currentSP;

    static uint64 currentPC;

    static void contextSwitch(Context *oldContext, Context *runningContext);

    static int thread_free(void* addr);

    Context context;
    Status status;
    Mode mode;

    Body body;
    void *args;
    uint64 *stack;

    uint64 timeSlice;

    uint64 sepc;

    uint64 sstatus;

    TCB* next;

    uint64 sleepTime = 0;
    uint64 wakeTime = 0;

    SCB* semError = nullptr;

    uint64 a0Location;

    static TCB *running;

    static TCB *putcThread;

    static uint64 timeSliceCounter;

    friend class Scheduler;
    friend class RiscV;
    friend class ConsoleUtil;
    friend class SCB;
    friend class System;
    friend class _thread;
};

#endif //OS1_KERNEL_TCB_HPP
