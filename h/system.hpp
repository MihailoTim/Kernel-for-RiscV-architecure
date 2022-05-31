//
// Created by os on 5/31/22.
//

#ifndef OS1_KERNEL_SYSTEM_HPP
#define OS1_KERNEL_SYSTEM_HPP


class System {

    static void userMainWrapper(void* arg);

    static bool initialized;

public:
    System();
};


#endif //OS1_KERNEL_SYSTEM_HPP
