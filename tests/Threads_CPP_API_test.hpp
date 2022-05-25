#ifndef XV6_THREADS_CPP_API_TEST_HPP
#define XV6_THREADS_CPP_API_TEST_HPP

#include "../h/syscall_cpp.hpp"

#include "../h/printing.hpp"

uint64 fibonacci(uint64 n);

class WorkerA: public Thread {
    void workerBodyA(void* arg);
public:
    WorkerA():Thread() {}

    void run() override {
        workerBodyA(nullptr);
    }
};

class WorkerB: public Thread {
    void workerBodyB(void* arg);
public:
    WorkerB():Thread() {}

    void run() override {
        workerBodyB(nullptr);
    }
};

class WorkerC: public Thread {
    void workerBodyC(void* arg);
public:
    WorkerC():Thread() {}

    void run() override {
        workerBodyC(nullptr);
    }
};

class WorkerD: public Thread {
    void workerBodyD(void* arg);
public:
    WorkerD():Thread() {}

    void run() override {
        workerBodyD(nullptr);
    }
};
void Threads_CPP_API_test();
#endif //XV6_THREADS_CPP_API_TEST_HPP
