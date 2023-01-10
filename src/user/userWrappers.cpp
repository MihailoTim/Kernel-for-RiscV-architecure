//
// Created by os on 1/10/23.
//
#include "../../h/userWrappers.hpp"
#include "../../h/syscall_c.h"
#include "../../src/user/tests/testUser.hpp"
#include "../../src/user/tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    body(args);
    thread_exit();
}

void userMainWrapper(void* args) {
    userMain();
}