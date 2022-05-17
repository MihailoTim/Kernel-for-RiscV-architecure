//
// Created by os on 4/28/22.
//

#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"

void Utility::printString(char *string) {
    while(*string){
        __putc(*string++);
    }
}

void Utility::printInt(int xx)
{
    int base = 10;
    int sign = (xx<0)? 1: 0;
    const char digits[] = "0123456789abcdef";
    char buf[16];
    int i;
    uint64 x;

    if(sign && (sign = xx < 0))
        x = -xx;
    else
        x = xx;

    i = 0;
    do {
        buf[i++] = digits[x % base];
    } while((x /= base) != 0);

    if(sign)
        buf[i++] = '-';

    while(--i >= 0)
        __putc(buf[i]);
}