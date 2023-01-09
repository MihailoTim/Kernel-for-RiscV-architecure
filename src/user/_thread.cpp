//
// Created by os on 6/3/22.
//

#include "../../h/_thread.hpp"
#include "../../h/tcb.hpp"
#include "../../h/syscall_c.h"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    tcb_free(addr);
}