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
    while((tmp = (TCB*)blocked->pop())){
        Scheduler::put(tmp);
    }
    delete blocked;
}

void SCB::block() {
    blocked->push(TCB::running);
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
    if(--val<0)
        block();
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