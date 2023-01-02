//
// Created by os on 1/2/23.
//
#ifndef KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP
#define KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP

#include "../h/slabAllocator.hpp"

void kmem_init(void* space, int block_num);

#endif //KERNEL_FOR_RISCV_ARCHITECURE_SLAB_HPP