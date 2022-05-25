//
// Created by os on 5/18/22.
//

#include "../h/scheduler.hpp"
#include "../lib/console.h"

TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;


void Scheduler::initialize(){
}

void Scheduler::put(TCB *tcb) {
    tcb->next = nullptr;
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
}


TCB* Scheduler::get(){
    if(readyTail == nullptr)
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    tmp->next = nullptr;
    return tmp;
}

void Scheduler::showScheduler() {
    TCB* iter = readyHead;
    while(iter){
        printInt((uint64)iter, 16);
        iter = iter->next;
    }
}