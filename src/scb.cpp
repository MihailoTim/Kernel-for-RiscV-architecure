//
// Created by os on 5/23/22.
//

#include "../h/scb.hpp"
#include "../h/scheduler.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"

SCB::SCB(int val)
{
    this->val = this->beginVal = val;
    headBlocked = tailBlocked = 0;
}

uint64 SCB::wait() {
    if(--val < 0)
        block();

    return 0;
}

uint64 SCB::signal() {
    if(++val <= 0)
        unblock();

    return 0;
}

SCB::~SCB()
{
    while(getFirstBlocked() != 0)
    {
        TCB* pcb = getFirstBlocked();
        removeFirstBlocked();
        Scheduler::put(pcb);
    }
}

void SCB::addToBlocked(TCB* pcb)
{
    pcb->next = 0;
    if(headBlocked == 0)
    {
        headBlocked = tailBlocked = pcb;
    }
    else
    {
        tailBlocked->next = pcb;
        tailBlocked = pcb;
    }
}

void SCB::block()
{
    TCB::running->status = TCB::BLOCKED;
    addToBlocked(TCB::running);
    TCB::dispatch();
}

TCB* SCB::getFirstBlocked()
{
    return headBlocked;
}

void SCB::removeFirstBlocked()
{
    if(headBlocked == 0)
        return;
    TCB* first = headBlocked;
    headBlocked = headBlocked->next;
    first->next = 0;
    if(headBlocked == 0)
        tailBlocked =0;
}

void SCB::unblock() {
    TCB* fr = getFirstBlocked();
    removeFirstBlocked();
    if(fr != 0)
    {
        //Riscv::printString("Unblocked thread\n");
        Scheduler::put(fr);
    }
}
void *SCB::operator new(size_t size) {
    return MemoryAllocator::kmalloc((size + MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
}

void SCB::operator delete(void *p)
{
    MemoryAllocator::kfree(p);
}