//
// Created by os on 4/28/22.
//

#ifndef SYSCALL_CPP_HPP
#define SYSCALL_CPP_HPP

#include "../lib/hw.h"
#include "../h/syscall_c.h"

void* operator new (size_t sz);

void* operator new[](size_t sz);

void operator delete (void *ptr);


#endif //SYSCALL_CPP_HPP
