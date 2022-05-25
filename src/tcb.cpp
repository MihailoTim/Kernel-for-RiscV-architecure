//
// Created by os on 5/18/22.
//

#include "../h/tcb.hpp"

TCB* TCB::running = nullptr;

uint64 TCB::timeSliceCounter = 0;

void TCB::initialize() {
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
}

TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){

    this->body = body;

    this->args = args;

    this->timeSlice = timeSlice;

    this->stack = (body == nullptr) ? nullptr : stack;

    this->status = Status::READY;

    this->next = nullptr;

    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
                     (uint64)&wrapper };

    if(this->body)
        Scheduler::put(this);
}

void TCB::free(){
    MemoryAllocator::kfree(stack);
}

TCB::~TCB(){
    free();
}

void TCB::dispatch() {
    TCB* old = running;

    if(old->status == Status::READY || old->status == Status::RUNNING) {
        Scheduler::put(old);
    }

    running = Scheduler::get();
    if(running) {
        running->status = Status::RUNNING;
        contextSwitch(&old->context, &running->context);
    }
}

void TCB::wrapper(void *args) {
    RiscV::popSppSpie();

    running->body(running->args);

    thread_exit();
}

void* TCB::operator new(size_t size){
    return MemoryAllocator::kmalloc(size);
}

void TCB::operator delete(void *addr){
    MemoryAllocator::kfree(addr);
}