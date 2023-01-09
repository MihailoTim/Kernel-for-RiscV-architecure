//
// Created by os on 1/8/23.
//
#include "../../h/tcbWrapperUtil.hpp"
#include "../../h/syscall_c.h"
#include "../../src/user/tests/testUser.hpp"
#include "../../src/user/tests/userMain.hpp"

void TCBWrapper::tcbWrap(void (*body)(void*), void* args)
{
    body(args);
    thread_exit();
}

void TCBWrapper::userMainWrapper(void* args) {
    userMain();
//    testUser();
}
