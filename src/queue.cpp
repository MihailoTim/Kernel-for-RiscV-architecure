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
        Node *tmp = head;
        head = head->next;
        MemoryAllocator::kfree(tmp);
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