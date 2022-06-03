//
// Created by os on 6/3/22.
//

#ifndef OS1_KERNEL__SEMAPHORE_HPP
#define OS1_KERNEL__SEMAPHORE_HPP


class _semaphore {
public:
    void operator delete(void *addr);
};

typedef _semaphore *sem_t;

#endif //OS1_KERNEL__SEMAPHORE_HPP
