//
// Created by os on 4/28/22.
//

#include "../h/utility.hpp"
#include "../lib/console.h"

void Utility::printString(char *string) {
    while(*string){
        __putc(*string++);
    }
}