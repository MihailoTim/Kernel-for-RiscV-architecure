//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_SCHEDULER_HPP
#define OS1_KERNEL_SCHEDULER_HPP

#include "tcb.hpp"

class Scheduler {

    static TCB *readyHead, *readyTail;

    static TCB *sleepingHead;

    static void put(TCB *t);

    static TCB* get();

    static void sleep(TCB *t);

    static void awake();

    static void initialize();

    friend class RiscV;

    friend class SCB;

    friend class TCB;

    friend class System;

public:

    static void showScheduler();

    static void showSleeping();
};


#endif //OS1_KERNEL_SCHEDULER_HPP

