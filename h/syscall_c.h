//
// Created by os on 4/29/22.
//

#ifndef SYSCALL_C_H
#define SYSCALL_C_H

#include "../lib/hw.h"

#ifdef __cplusplus
extern "C" {
#endif

void *mem_alloc(size_t size);

int mem_free(void* ptr);

#ifdef __cplusplus
}
#endif

#endif //TM200047_SYSCALL_C_H
