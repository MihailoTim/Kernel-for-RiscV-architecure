//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_SCHEDULER_HPP
#define OS1_KERNEL_SCHEDULER_HPP

#include "../h/queue.hpp"
#include "../h/utility.hpp"
#include "../h/tcb.hpp"

class Scheduler {
    static Queue* queue;
public:

    static void put(TCB *t);

    static TCB* get();

    static void initialize();
};


#endif //OS1_KERNEL_SCHEDULER_HPP

