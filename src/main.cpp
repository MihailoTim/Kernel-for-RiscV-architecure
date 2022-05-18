//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/tests.hpp"

int main() {

    RiscV::initialize();

    mallocTest();

    mallocGapFillTest();

    mallocEverything();

    badFree();

    return 0;
}