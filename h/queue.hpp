//
// Created by os on 5/18/22.
//

#ifndef OS1_KERNEL_QUEUE_HPP
#define OS1_KERNEL_QUEUE_HPP

#include "../h/memoryAllocator.hpp"
#include "../h/utility.hpp"

class TCB;

class Queue {
    struct Node{
        TCB *tcb;
        Node *next, *prev;
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

    Queue& push(TCB *tcb);

    TCB* pop();

    TCB* peek();
};


#endif //OS1_KERNEL_QUEUE_HPP