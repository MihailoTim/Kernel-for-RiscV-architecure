//
// Created by os on 5/18/22.
//

#include "../h/scheduler.hpp"
#include "../lib/console.h"

TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
}

void Scheduler::put(TCB *tcb) {
    tcb->next = nullptr;
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
}


TCB* Scheduler::get(){

    awake();

    if(readyTail == nullptr)
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    tmp->next = nullptr;
    return tmp;
}

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

void Scheduler::showScheduler() {
    TCB* iter = readyHead;
    while(iter){
        printInt((uint64)iter, 16);
        iter = iter->next;
    }
}

void Scheduler::showSleeping(){
    TCB* iter = sleepingHead;
    while(iter){
        printInt((uint64)iter, 16);
        printString("\n");
        iter = iter->next;
    }
}