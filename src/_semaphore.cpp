//
// Created by os on 6/3/22.
//

#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

void _semaphore::operator delete(void *addr){
    printString("deleting sem_t\n");
}