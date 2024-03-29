//
// Created by os on 5/29/22.
//

#ifndef OS1_KERNEL_CONSOLEUTIL_HPP
#define OS1_KERNEL_CONSOLEUTIL_HPP

#include "../lib/hw.h"
#include "scb.hpp"

//Console class for utility functions

class ConsoleUtil {
    static uint64 pendingGetc;
    static uint64 pendingPutc;

    static SCB* outputSem;
    static SCB* inputSem;

    //Buffer size should be dynamically allocated, for now leaving it as is
    static const uint64 bufferSize = 8192;
    static char inputBuffer[bufferSize];
    static char outputBuffer[bufferSize];

    static uint64 inputHead, inputTail, outputHead, outputTail;

    static void putInput(char c);

    static char getInput();

    static void putOutput(char c);

    static char getOutput();

    static void initialize();

    static char putcUtilSyscall();

    friend class RiscV;

    friend class MemoryAllocator;

public:
    static void printInt(int xx, int base=10, int sgn=0);
    static void printString(const char *string);
};


#endif //OS1_KERNEL_CONSOLEUTIL_HPP
