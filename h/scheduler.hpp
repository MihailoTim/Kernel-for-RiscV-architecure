//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_SCHEDULER_HPP
#define OS1_KERNEL_SCHEDULER_HPP

#include "../h/queue.hpp"
#include "../h/tcb.hpp"

class Scheduler {
    static Queue* queue;

    static void put(TCB *t);

    static TCB* get();

    static void initialize();

    friend class RiscV;

    friend class SCB;

    friend class TCB;
};


#endif //OS1_KERNEL_SCHEDULER_HPP

