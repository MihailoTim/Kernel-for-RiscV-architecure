//
// Created by os on 6/3/22.
//

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

void _thread::operator delete(void *addr){
    TCB::thread_free(addr);
}