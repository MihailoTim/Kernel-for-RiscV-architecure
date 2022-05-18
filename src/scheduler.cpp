//
// Created by os on 5/18/22.
//

#include "../h/scheduler.hpp"
#include "../lib/console.h"

Queue* Scheduler::queue = nullptr;

void Scheduler::initialize(){
    queue = new Queue();
}

void Scheduler::put(TCB *tcb) {
    queue->push(tcb);
}

TCB* Scheduler::get(){
    return queue->pop();
}