//
// Created by os on 4/28/22.
//
#include "../h/riscv.hpp"
#include "../h/utility.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"

struct object{
    int a,b,c,d,e,f,g,h,i,j,k;
};
struct node{
    object o1, o2, o3;
    char id;
    node *next, *prev;
};

int main()
{
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    char *l = new char;
    *l = 3;
    int* newInt = new int;
    *newInt = 64;

    node* a= new node;
    node* b= new node;
    node* c= new node;
    node* d= new node;

    a->id = 'a';
    b->id = 'b';
    c->id = 'c';
    d->id = 'd';
    a->next = b;
    b->next = c;
    c->next = d;
    d->next = nullptr;
    d->prev = c;
    c->prev = b;
    b->prev = a;
    a->prev = nullptr;

    node *tmp = a;
    while(tmp!=nullptr) {
        __putc(tmp->id);
        tmp = tmp->next;
    }
    delete a;
    return 0;
}