//
// Created by os on 5/23/22.
//

#include "../h/scb.hpp"

SCB::SCB(uint64 init){
    blocked = new Queue();
    val = init;
}

SCB::~SCB(){
    TCB* tmp;
    while((tmp = (TCB*)blocked->pop())) {
        Scheduler::put(tmp);
    }
}

void SCB::block() {
    TCB* tcb = TCB::running;
    if(tcb->node){
        blocked->push(tcb->node);
    }
    else{
        Queue::Node *node = (Queue::Node*)MemoryAllocator::kmalloc(sizeof(Queue::Node));
        node->tcb = tcb;
        tcb->node = blocked->push((void *) node);
    }
    TCB::running->status = TCB::BLOCKED;
    TCB::dispatch();
}

void SCB::deblock(){
    TCB *tcb = (TCB*)blocked->pop();
    if(tcb) {
        tcb->status = TCB::READY;
        Scheduler::put(tcb);
    }
}

void SCB::wait(){
    if(--val<0) {
        printString("blocked\n");
        block();
    }
}

void SCB::signal(){
    if(val++<0)
        deblock();
}

void* SCB::operator new(size_t size){
    return MemoryAllocator::kmalloc(size);
}

void SCB::operator delete(void *addr){
    MemoryAllocator::kfree(addr);
}