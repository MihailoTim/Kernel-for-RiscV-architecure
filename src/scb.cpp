//
// Created by os on 5/23/22.
//

#include "../h/scb.hpp"
#include "../h/scheduler.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"

#include "../h/scb.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/riscv.hpp"
#include "../h/scheduler.hpp"

SCB::SCB(uint64 init){
    val = init;
    blockedHead = nullptr;
    blockedTail = nullptr;
}

SCB::~SCB(){
    TCB* iter = blockedHead;
    while(iter !=nullptr) {
        TCB* tmp = iter;
        iter = iter->next;
        tmp->next = 0;
        tmp->semError = this;
        Scheduler::put(tmp);
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
    TCB::running->semError = nullptr;
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

int SCB::semaphore_free(void *addr) {
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    asm("li a0, 0x52");  //put number of syscall in a0
    asm("ecall");

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}
