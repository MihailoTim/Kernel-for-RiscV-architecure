//
// Created by os on 1/8/23.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_TCBWRAPPERUTIL_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_TCBWRAPPERUTIL_HPP

#include "../h/tcb.hpp"
class TCBWrapper {
public:
    static void tcbWrap(void (*body)(void*), void* args);
    static void userMainWrapper(void* args);
};
#endif //KERNEL_FOR_RISCV_ARCHITECURE_TCBWRAPPERUTIL_HPP
