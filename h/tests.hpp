//
// Created by os on 5/17/22.
//

#ifndef OS1_KERNEL_TESTS_HPP
#define OS1_KERNEL_TESTS_HPP

#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/tests.hpp"

struct object{
    int a,b,c,d,e,f,g,h,i,j,k;
};
struct node{
    object o1, o2, o3;
    char id;
    node *next, *prev;
};
class Test
{
public:
    uint64 a;
};

void mallocTest();

void mallocGapFillTest();

void mallocEverything();

void badFree();

#endif //OS1_KERNEL_TESTS_HPP
