//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_QUEUE_HPP
#define OS1_KERNEL_QUEUE_HPP

#include "../h/memoryAllocator.hpp"
#include "../h/utility.hpp"

class TCB;

class Queue {
protected:
    struct Node{
        void *tcb;
        Node *next;
    };

    void empty();

    uint64 size;

    Node *head, *tail;


public:
    //copy and move constructors are not needed as this will only be used in Scheduler
    Queue(){
        head = tail =nullptr;
        size = 0;
    }

    ~Queue(){
        empty();
    }

    void* push(void *tcb);

    void* appendTail(void* t);

    void* pop();

    void* operator new(size_t size);

    void operator delete(void* addr);

    friend class Scheduler;

    friend class SCB;
};


#endif //OS1_KERNEL_QUEUE_HPP
