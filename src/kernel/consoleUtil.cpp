//
// Created by os on 5/29/22.
//

#include "../../h/kernel/consoleUtil.hpp"
#include "../../h/user/printing.hpp"
#include "../../h/kernel/scb.hpp"

uint64 ConsoleUtil::inputHead = 0;
uint64 ConsoleUtil::inputTail = 0;
uint64 ConsoleUtil::outputHead = 0;
uint64 ConsoleUtil::outputTail = 0;

uint64 ConsoleUtil::pendingGetc = 0;
uint64 ConsoleUtil::pendingPutc = 0;

SCB* ConsoleUtil::outputSem = nullptr;
SCB* ConsoleUtil::inputSem = nullptr;

char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;
//char ConsoleUtil::inputBuffer[8192];
//char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    inputSem = new SCB(0);
    outputSem = new SCB(0);
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
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
    pendingPutc++;

    if((outputTail+1)%bufferSize == outputHead)
        return;

    outputBuffer[outputTail] = c;

    outputTail = (outputTail+1)%bufferSize;

    pendingPutc--;

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

void ConsoleUtil::printString(const char *string) {
    while (*string != '\0')
    {
        ConsoleUtil::putOutput(*string);
        string++;
    }
}

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    }

    i = 0;
    do{
        buf[i++] = digits[x % base];
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';

    while(--i >= 0)
        ConsoleUtil::putOutput(buf[i]);

}

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    ConsoleUtil::printString(string);
    ConsoleUtil::printInt(xx, base);
    ConsoleUtil::printString(sep);
}

char ConsoleUtil::putcUtilSyscall()
{
    asm("li a0, 0x43");

    asm("ecall");

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));

    return (char)status;
}
