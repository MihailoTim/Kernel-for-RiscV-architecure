//
// Created by os on 4/17/22.
//

#ifndef XV6_CONSUMERPRODUCER_C_API_TEST_H
#define XV6_CONSUMERPRODUCER_C_API_TEST_H

#include "../h/syscall_c.h"

#include "buffer.hpp"

struct thread_data;

void producerKeyboard(void *arg);

void producer(void *arg);

void consumer(void *arg);

void producerConsumer_C_API();
#endif //XV6_CONSUMERPRODUCER_C_API_TEST_H
