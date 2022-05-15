//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"

struct object{
    int a,b,c,d,e,f,g;
};

int main()
{
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    char *string = (char*)"this is a string\n\0";
    Utility::printString(string);
    void *l = new object;
    if(l!=nullptr)
        __putc('L');
    return 0;
}