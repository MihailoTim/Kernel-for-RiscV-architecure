//
// Created by os on 5/18/22.
//

#include "../h/queue.hpp"

void* Queue::operator new(size_t size) {
    return MemoryAllocator::kmalloc((size+MEM_BLOCK_SIZE-1)>>MEM_BLOCK_OFFS);
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

void* Queue::push(void *tcb) {
    tail = (!head ? head : tail->next) = (Node*) MemoryAllocator::kmalloc(sizeof(Node));
    tail->tcb = tcb;
    tail->next = nullptr;
    size++;

    return tail;
}

void* Queue::appendTail(void *t) {
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