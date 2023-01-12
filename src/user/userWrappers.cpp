//
// Created by os on 1/10/23.
//
#include "../../h/user/userWrappers.hpp"
#include "../../h/user/syscall_c.h"
#include "tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    body(args);
    thread_exit();
}

void userMainWrapper(void* args) {
    userMain();
}