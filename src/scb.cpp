//
// Created by os on 5/23/22.
//

#include "../h/scb.hpp"
#include "../h/scheduler.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"

SCB::SCB(uint64 init){
    val = init;
    blockedHead = nullptr;
    blockedTail = nullptr;
}

SCB::~SCB(){
    TCB* iter = blockedHead;
    while(iter !=nullptr) {
        TCB* tmp = iter;
        Scheduler::put(iter);
        iter = iter->next;
        tmp->next = nullptr;
    }
}

void SCB::block() {
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    TCB::running->next = nullptr;
    TCB::running->status = TCB::BLOCKED;
    TCB::dispatch();
}

void SCB::deblock(){
    TCB* tcb = blockedHead;
    blockedHead = blockedHead->next;
    tcb->next = nullptr;
    if(tcb) {
        tcb->status = TCB::READY;
        Scheduler::put(tcb);
    }
}

void SCB::wait() {
    if (--val < 0)
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