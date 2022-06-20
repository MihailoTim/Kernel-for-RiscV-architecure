//
// Created by os on 6/3/22.
//

#ifndef OS1_KERNEL__THREAD_HPP
#define OS1_KERNEL__THREAD_HPP


//wrapper class to represent thread_t
//forbid any type of creation of instance of class
//allow it only to be deleted
//class is needed so that when calling delete on thread_t, all memory is deallocated, including stack space, and not just the handle
class _thread {
    _thread(){}
    _thread(_thread &t){}
public:
    void operator delete(void *addr);
};

typedef _thread *thread_t;


#endif //OS1_KERNEL__THREAD_HPP
