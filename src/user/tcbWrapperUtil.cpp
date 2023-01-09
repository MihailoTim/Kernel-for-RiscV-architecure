//
// Created by os on 1/8/23.
//
#include "../../h/tcbWrapperUtil.hpp"
#include "../../h/syscall_c.h"

void TCBWrapper::tcbWrap(TCB* tcb)
{
    tcb->body(tcb->args);
    thread_exit();
}

