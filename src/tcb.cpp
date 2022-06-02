//
// Created by os on 5/18/22.
//

#include "../h/tcb.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/scheduler.hpp"
#include "../h/syscall_c.h"

TCB* TCB::running = nullptr;

uint64 TCB::timeSliceCounter = 0;


//create a thread for kernel main and a separate thread for console output execution
void TCB::initialize() {
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);

    TCB::running->mode = Mode::SUPERVISOR;

    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);

    TCB* putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);

    putcThread->mode = Mode::SUPERVISOR;

    Scheduler::put(putcThread);
}

//tcb constructor
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){

    this->body = body;

    this->args = args;

    this->timeSlice = timeSlice;

    this->stack = (body == nullptr) ? nullptr : stack;

    this->status = Status::READY;

    this->next = nullptr;

    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
                     (uint64)&wrapper };

    this->mode = Mode::USER;
}

//deallocate memory for thread stack
void TCB::free(){
    MemoryAllocator::kfree(stack);
}

TCB::~TCB(){
    free();
}

//if currently running thread is not finished, asleep or blocked put it in scheduler
//get new thread from scheduler and switch context
void TCB::dispatch() {
    TCB* old = running;

    if(old->status == Status::READY || old->status == Status::RUNNING) {
        Scheduler::put(old);
    }

    running = Scheduler::get();
    if(running) {
        running->status = Status::RUNNING;
        RiscV::jumpToDesignatedPrivilegeMode();
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
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