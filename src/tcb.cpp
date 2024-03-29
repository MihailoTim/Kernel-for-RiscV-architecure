//
// Created by os on 5/18/22.
//

#include "../h/tcb.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/scheduler.hpp"
#include "../h/syscall_c.h"
#include "../h/printing.hpp"

TCB* TCB::running = nullptr;

TCB* TCB::putcThread = nullptr;

uint64 TCB::currentPC = 0;

uint64 TCB::currentSP = 0;

uint64 TCB::timeSliceCounter = 0;


//create a thread for kernel main and a separate thread for console output execution
void TCB::initialize() {
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);

    TCB::running->mode = Mode::SUPERVISOR;

    //stack for thread that will be running console output
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);

    //console output thread
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);

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

    //initial context for thread
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
                     (uint64)&wrapper };

    //by default run it in user mode
    this->mode = Mode::USER;
}

//deallocate memory for thread stack
void TCB::free(){
    MemoryAllocator::kfree(stack);
}

TCB::~TCB(){
    free();
}

//if currently running thread is not finished, asleep or blocked, put it in scheduler
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

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    return MemoryAllocator::kmalloc(size);
}

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    MemoryAllocator::kfree(addr);
}

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    asm("li a0, 0x51");
    asm("ecall");

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}