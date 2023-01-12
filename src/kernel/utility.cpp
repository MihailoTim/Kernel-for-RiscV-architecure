//
// Created by os on 1/8/23.
//
#include "../../h/kernel/utility.hpp"

char* strcpy(const char* src, char* dst){
    while(*src != '\0')
        *dst++ = *src++;
    *dst = *src;
    return dst;
}

char* strcat(char* dst, const char* src){
    char *dest = dst;
    while(*dest != '\0')
        dest++;
    strcpy(src, dest);
    return dst;
}