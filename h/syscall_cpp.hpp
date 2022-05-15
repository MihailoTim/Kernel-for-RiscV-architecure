//
// Created by os on 4/28/22.
//

#ifndef TM200047_SYSCALL_CPP_HPP
#define TM200047_SYSCALL_CPP_HPP

#include "../lib/hw.h"
#include "../h/syscall_c.h"

void* f(size_t sz);

void* operator new (size_t sz);

void operator delete (void *ptr);


#endif //TM200047_SYSCALL_CPP_HPP
