//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/tests.hpp"

int main()
{
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);

    mallocTest();

    return 0;
}