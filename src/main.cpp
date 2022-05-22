//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/tests.hpp"
#include "../h/queue.hpp"
#include "../h/tcb.hpp"
#include "../tests/Threads_C_API_test.hpp"
#include "../h/workers.hpp"

int main() {

    RiscV::initialize();

    Threads_C_API_test();

    return 0;
}