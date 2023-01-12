//
// Created by os on 1/10/23.
//

#ifndef KERNEL_FOR_RISCV_ARCHITECURE_USERWRAPPERS_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_USERWRAPPERS_HPP

#endif //KERNEL_FOR_RISCV_ARCHITECURE_USERWRAPPERS_HPP

void bodyWrapper(void (*body)(void*), void* args);
void userMainWrapper(void* args);