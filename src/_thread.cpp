//
// Created by os on 6/3/22.
//

#include "../h/_thread.hpp"
#include "../h/printing.hpp"

void _thread::operator delete(void *addr){
    printString("deleting thread_t\n");
}

