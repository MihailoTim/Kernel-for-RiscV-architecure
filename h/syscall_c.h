//
// Created by os on 4/29/22.
//

#ifndef SYSCALL_C_H
#define SYSCALL_C_H

#include "../lib/hw.h"

#define MEM_BLOCK_OFFS 6

typedef void* thread_t;
typedef void* sem_t;

#ifdef __cplusplus
extern "C" {
#endif

void *mem_alloc(size_t size);

int mem_free(void* ptr);

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg);

int thread_exit();

void thread_dispatch();

int thread_attach_body(thread_t handle, void(*start_routine)(void*), void *arg);

int thread_initialize(thread_t* handle);

int thread_start(thread_t handle);

int sem_open(sem_t *handle, unsigned init);

int sem_close(sem_t handle);

int sem_wait(sem_t handle);

int sem_signal(sem_t handle);

int time_sleep(time_t time);

char getc();

void putc(char c);

#ifdef __cplusplus
}
#endif

#endif //TM200047_SYSCALL_C_H
