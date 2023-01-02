//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

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
