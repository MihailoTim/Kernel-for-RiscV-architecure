//
// Created by os on 5/18/22.
//

#include "../../h/scheduler.hpp"
#include "../../h/printing.hpp"
#include "../../h/consoleUtil.hpp"
#include "../../h/riscv.hpp"

TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
}

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    tcb->next = nullptr;
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
}


//get new TCB from scheduler
TCB* Scheduler::get(){
    if(readyHead == nullptr)
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    tmp->next = nullptr;
    return tmp;
}

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    TCB* iter = sleepingHead, *prev = nullptr;
    for(; iter!= nullptr; prev = iter, iter=iter->next)
        if(iter->wakeTime>t->wakeTime)
            break;
    t->next = iter;
    if(prev)
        prev->next = t;
    else
        sleepingHead = t;
}

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    while(sleepingHead){
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
            sleepingHead = sleepingHead->next;
            put(tmp);
            tmp->next = nullptr;
        }
        else{
            break;
        }
    }
}

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    TCB* iter = readyHead;
    while(iter){
        ConsoleUtil::printInt((uint64)iter, 16);
        ConsoleUtil::printString("\n");
        iter = iter->next;
    }
}

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    TCB* iter = sleepingHead;
    while(iter){
        printInt((uint64)iter, 16);
        printString("\n");
        iter = iter->next;
    }
}