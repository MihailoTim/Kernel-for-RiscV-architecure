//
// Created by os on 6/3/22.
//

#ifndef OS1_KERNEL__SEMAPHORE_HPP
#define OS1_KERNEL__SEMAPHORE_HPP


//wrapper class to represent sem_t
//forbid any type of creation of instance of class
//allow it only to be deleted
//class is needed so that when calling delete on sem_t before sem_close, all threads that are blocked are released

class _semaphore {
    _semaphore(){}
    _semaphore(_semaphore &s){}
public:
    void operator delete(void *addr);
};
typedef _semaphore *sem_t;

#endif //OS1_KERNEL__SEMAPHORE_HPP
