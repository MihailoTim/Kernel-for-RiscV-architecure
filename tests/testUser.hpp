#include "../h/syscall_c.h"
#include "../h/syscall_cpp.hpp"


struct thread_data {
    int id;
};

class ForkThread : public Thread {
public:
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    virtual void run() {
        ConsoleUtil::print("Started thread id:",id,"\n");

        ForkThread* thread = new ForkThread(id + 1);
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);

        if (threads != nullptr) {
            for (long i = 0; i < id; i++) {
                threads[i] = new ForkThread(id);
            }

            if (thread != nullptr) {
                if (thread->start() == 0) {

                    for (int i = 0; i < 5000; i++) {
                        for (int j = 0; j < 5000; j++) {

                        }
                        thread_dispatch();
                    }

                    while (!thread->isFinished()) {
                        thread_dispatch();
                    }
                }
                delete thread;
            }

            for (long i = 0; i < id; i++) {
                delete threads[i];
            }

            mem_free(threads);
        }

//        ConsoleUtil::print("Finished thread id:",id,"\n");

        finished = true;
    }

    bool isFinished() const {
        return finished;
    }

private:
    long id;
    bool finished;
};


void userMain() {
    ForkThread thread(1);

    thread.start();

    while (!thread.isFinished()) {
        thread_dispatch();
    }

    ConsoleUtil::printString("User main finished\n");
}