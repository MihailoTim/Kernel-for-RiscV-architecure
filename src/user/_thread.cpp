//
// Created by os on 6/3/22.
//

#include "../../h/_thread.hpp"
#include "../../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    TCB::thread_free(addr);
}