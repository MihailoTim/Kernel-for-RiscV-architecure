//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_SCHEDULER_HPP
#define OS1_KERNEL_SCHEDULER_HPP

#include "../h/queue.hpp"
#include "../h/tcb.hpp"

class Scheduler {

    static TCB *readyHead, *readyTail;

    static TCB *sleepingHead, *sleepingTail;

    static void put(TCB *t);

    static TCB* get();

    static void initialize();

    friend class RiscV;

    friend class SCB;

    friend class TCB;

public:
    static void showScheduler();
};


#endif //OS1_KERNEL_SCHEDULER_HPP

