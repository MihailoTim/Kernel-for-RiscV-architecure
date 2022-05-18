//
// Created by os on 5/18/22.
//

#include "../h/queue.hpp"

void Queue::empty() {
    while(head){
        Node *tmp = head;
        head = head->next;
        MemoryAllocator::kfree(tmp);
    }
}

Queue& Queue::push(TCB *tcb){
    tail = (!head ? head : tail->next) = (Node*)MemoryAllocator::kmalloc(sizeof(Node));
    tail->tcb = tcb;
    tail->next =nullptr;
    size++;

    return *this;
}

TCB* Queue::pop() {
    if(head){
        TCB* tcb = head->tcb;
        head = head->next;
        size--;
        return tcb;
    }
    else
        return nullptr;
}

TCB* Queue::peek() {
    if(head)
        return head->tcb;
    else
        return nullptr;
}