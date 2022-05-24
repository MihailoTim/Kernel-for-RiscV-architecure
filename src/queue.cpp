//
// Created by os on 5/18/22.
//

#include "../h/queue.hpp"

void* Queue::operator new(size_t size) {
    return MemoryAllocator::kmalloc((size+MEM_BLOCK_SIZE-1)>>6);
}

void Queue::operator delete(void *addr){
    MemoryAllocator::kfree(addr);
}

void Queue::empty() {
    while(head){
        Node *tmp = head;
        head = head->next;
        MemoryAllocator::kfree(tmp);
    }
}

void* Queue::push(void *t) {
    tail = (!head ? head : tail->next) = (Node*)t;

    return (void*)tail;
}

void* Queue::pop() {
    if(head){
        void* tcb = head->tcb;
//        Node *tmp = head;
        head = head->next;
//        MemoryAllocator::kfree(tmp);
        size--;

        return tcb;
    }
    else
        return nullptr;
}