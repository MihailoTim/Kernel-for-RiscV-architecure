//
// Created by os on 5/18/22.
//

#include "../h/tcb.hpp"

TCB* TCB::running = nullptr;

TCB::TCB(Body body, void* args, uint64* stack){

    this->body = body;

    this->args = args;

    this->stack = (body == nullptr) ? nullptr : stack;
//    this->stack = (body == nullptr) ? nullptr : (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)>>6);
//    this->stack = (body == nullptr) ? nullptr : new uint64[DEFAULT_STACK_SIZE];

    this->status = Status::READY;

    this->context = {(body == nullptr) ? 0 : (uint64)&stack[DEFAULT_STACK_SIZE],
                     (uint64)body };

    if(body!=nullptr)
        Scheduler::put(this);
}

void TCB::free(){
    status = Status::FINISHED;
    MemoryAllocator::kfree(stack);
}

TCB::~TCB(){
    free();
}

void TCB::yield() {
    RiscV::pushRegisters();

    dispatch();

    RiscV::popRegisters();
}

void TCB::dispatch() {
    TCB* old = running;

    if(old->status != Status::FINISHED)
        Scheduler::put(old);

    running = Scheduler::get();
    if(running) {
        running->status = Status::RUNNING;
        contextSwitch(&old->context, &running->context);
    }
}

void* TCB::operator new(size_t size){
    return MemoryAllocator::kmalloc(size);
}

void TCB::operator delete(void *addr){
    MemoryAllocator::kfree(addr);
}