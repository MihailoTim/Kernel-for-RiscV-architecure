//
// Created by os on 5/18/22.
//

#include "../h/tcb.hpp"

TCB* TCB::running = nullptr;

TCB::TCB(Body body){

    this->body = body;

    this->stack = (body == nullptr) ? nullptr : (uint64*)MemoryAllocator::kmalloc(DEFAULT_STACK_SIZE);

    this->finished = false;

    this->context = {(body == nullptr) ? 0 : (uint64)&stack[DEFAULT_STACK_SIZE],
                     (uint64)body };

    if(body!=nullptr)
        Scheduler::put(this);
}

TCB::~TCB(){
    MemoryAllocator::kfree(stack);
}

void TCB::yield() {
    RiscV::pushRegisters();

    dispatch();

    RiscV::popRegisters();
}

void TCB::dispatch() {
    TCB* old = running;

    if(!old->finished)
        Scheduler::put(old);

    running = Scheduler::get();
    if(running){
        contextSwitch(&old->context, &running->context);
    }
}

TCB* TCB::createThread(Body body) {
    return new TCB(body);
}

void* TCB::operator new(size_t size){
    return MemoryAllocator::kmalloc(size);
}

void TCB::operator delete(void *addr){
    MemoryAllocator::kfree(addr);
}