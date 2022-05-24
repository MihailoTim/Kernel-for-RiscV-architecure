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
    if(tcb->node){
        queue->push(tcb->node);
    }
    else{
        Queue::Node *node = (Queue::Node*)MemoryAllocator::kmalloc(sizeof(Queue::Node));
        node->tcb = tcb;
        tcb->node = queue->push((void *) node);
    }
}

TCB* Scheduler::get(){
    return (TCB*)queue->pop();
}