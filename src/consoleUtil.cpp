//
// Created by os on 5/29/22.
//

#include "../h/consoleUtil.hpp"
#include "../h/printing.hpp"

uint64 ConsoleUtil::inputHead = 0;
uint64 ConsoleUtil::inputTail = 0;
uint64 ConsoleUtil::outputHead = 0;
uint64 ConsoleUtil::outputTail = 0;

uint64 ConsoleUtil::pendingGetc = 0;
uint64 ConsoleUtil::pendingPutc = 0;

SCB* ConsoleUtil::outputSem = nullptr;
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    inputSem = new SCB(0);
    outputSem = new SCB(0);
}

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
        return;
    inputBuffer[inputTail] = c;
    inputTail = (inputTail+1)%bufferSize;
    inputSem->signal();
}

char ConsoleUtil::getInput() {
    inputSem->wait();
    if(inputHead == inputTail)
        return -1;
    char c = inputBuffer[inputHead];

    inputHead = (inputHead+1)%bufferSize;

    return c;
}

void ConsoleUtil::putOutput(char c) {
    if((outputTail+1)%bufferSize == outputHead)
        return;
    outputBuffer[outputTail] = c;
    outputTail = (outputTail+1)%bufferSize;
    outputSem->signal();
}

char ConsoleUtil::getOutput() {
    outputSem->wait();
    if(outputHead == outputTail)
        return -1;

    char c = outputBuffer[outputHead];

    outputHead = (outputHead+1)%bufferSize;

    return c;
}

