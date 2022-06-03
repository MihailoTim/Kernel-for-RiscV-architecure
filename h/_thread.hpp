//
// Created by os on 6/3/22.
//

#ifndef OS1_KERNEL__THREAD_HPP
#define OS1_KERNEL__THREAD_HPP

class _thread {
public:
    void operator delete(void *addr);
};

typedef _thread *thread_t;


#endif //OS1_KERNEL__THREAD_HPP
