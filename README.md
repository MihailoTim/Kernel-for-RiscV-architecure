# OS1-kernel
A minimalistic kernel for RiscV architecture with support for some basic kenel functions (ie. time-sharing, multi-threading, semaphores, etc..)

<br/>

## About the project
This project was part of the course Operating Systems 1 on the second year at School Of Electrical Engineering, University of Belgrade. As part of the
course, students were tasked with building a small but functional kernel, that supports threads with time-sharing.

Scope of the project also includes implementing memory allocation, thread managment, semaphores and both synchronus and asynchronus context switch, as well
as preemption on interrupt from keyboard or timer.
  
Kernel is running a single user application that is statically linked and preloaded into operative memory. For the purpose of testing this user program 
is represented as userMain() function.

<br/>

## Kernel interface and system architecture
Kernel and user application are compiled and linked into a single .exe file. This file will be run in an already set-up environment of host system - xv6 educational system.  
More about xv6 system for RiscV architecure can be found here: https://pdos.csail.mit.edu/6.828/2021/xv6/book-riscv-rev2.pdf  
More about RiscV architecture can be found here: https://riscv.org/technical/specifications/

### Host system
For the purpose of this project, host system was significantly modified, removing many functionalities (context switch, task scheduling, memory allocation, file subsystem...).
Host system will boot on its own, initialize the targeted hardware, create a single process whose virtual space that takes up all availible memory, load .exe file into memory
and run it. Host system will also provide basic hardware functionalities - interrupts from timer and console.

<br/>

### Kernel interface
Implementation of this kernel is layered into multiple levels of abstraction:  

* C++ API layer is object-oriented API that allows object-oriented use of concepts that kernel supports. It is implemented as simple wrapper functions around C API layer.
* C API layer is a procedural interface of system calls. It is implemented as one or more calls to system calls from ABI layer
* ABI layer is a binary interface of system calls that are executed using a software interrupt of RiscV architecture ( "ecall" instruction). This layer ensures argument passsing through registers, switch to privileged mode and transition to kernel layer

<br/>

### C API
| SyscallID        | Declaration                     | Explanation  |
| ---------------- |----------------------------------------------------------------------------------| -----|
| 0x01             |  <p><pre> void* mem_alloc (size_t size); </pre></p> | Allocates at least _size_ bytes, rounded up and aligned to blocks size of MEM_BLOCK_SIZE. Return pointer to allocated memory or _null_ if failed|
| 0x02             |  <p><pre> int mem_free (void*);  </pre></p> | Frees memory previously allocated by _mem_alloc_. Returns 0 if successful, negative value otherwise. Argument must be pointer previously allocated by _mem_alloc_, otherwise an error code is returned. |
| 0x11             |  <p><pre> int thread_create ( thread_t* handle,<br/>                     void(*start_routine)(void*),<br/>                     void* arg ); </pre></p>| Creates a thread with bode _start_routine_ and body argument _arg_. If successful writes address of created thread in \*handle and return 0. Othrewise, return negative value and _null_ is written into \*handle  |  
| 0x12             |  <p><pre> int thread_exit ();  </pre></p> | Exits currently running thread. If not successful return negative value |
| 0x13             |  <p><pre> void thread_dispatch (); </pre></p> | Executes synchronus context switch and possibly gives processor time to another thread |
| 0x21             |  <p><pre> int sem_open ( sem_t* handle, unsigned init );  </pre></p> | Creates a semaphore with initial value _init_. If successful writes address of semaphore into \*handle and returns 0. Othrewise, return negative value and _null_ is written into \*handle  |
| 0x22             |  <p><pre> int sem_close (sem_t handle);</pre></p> | Frees semaphore with given handle. If there are any threads currently blocked on that semaphore, they are released and their _wait_ syscall returns negative value. If successful returns 0, otherwise returns negative value |
| 0x23             |  <p><pre> int sem_wait (sem_t id);  </pre></p> | Operation wait on semaphore with given handle. If successful returns 0, otherwise returns nwgative value |
| 0x24             |  <p><pre> int sem_signal (sem_t id);  </pre></p>| Operation signal on semaphore with given handle. If successful returns 0, otherwise returns negative value |
| 0x31             |  <p><pre> int time_sleep (time_t time);  </pre></p>| Puts currently running thread to sleep for _time_t_ periods of timer ticks (timer ticks every 100ms). Returns 0 if successful, negative value otherwise |
| 0x41             |  <p><pre> char getc ();  </pre></p>| Returns one character from input buffer. If buffer is empty, blocks caller thread until there is a character. If successful returns character, otherwise return const EOF|
| 0x42             |  <p><pre> void putc (char);  </pre></p>| Prints given character to console|

_Notes:_  
Thread is created with stack size of _DEFAULT_STACK_SIZE_ and time slice the size of _DEFAULT_TIME_SLICE_.  
Memory availible for allocation starts at _HEAP_START_ADDR_ and ends at _HEAP_END_ADDR-1_.  
All constants are declared in _hw.h_ file

<br/>

### ABI
Syscalls in this layers are executed with software interrupt ( on RiscV architecture "ecall" instruction). Arguments are passed through registers of the processor:
* a0: syscall ID, equivalent to the one from C API table of syscalls
* a1, a2, a3... : arguments of syscalls
* a0: return value

All system call signatures are equivalent to the ones from C API table with the exception of:  
* mem_alloc: argument size should represent size of memory in blocks rather than bytes
* thread_create: contains additional argument with the pointer to stack space allocated for thread that is being created

<br/>

### C++ API
Classes of this layer are implemented in syscall_cpp.hpp file. Interfaces of these classes are given below:  
<pre>
#ifndef _syscall_cpp 
#define _syscall_cpp 

#include "syscall_c.h" 

void* ::operator new (size_t); 

void ::operator delete (void*); 

class Thread { 
public: 
      Thread (void (*body)(void*), void* arg); 
      virtual ~Thread (); 
      int start (); 
      static void dispatch (); 
      static int sleep (time_t); 
protected: 
      Thread (); 
      virtual void run () {} 
private: 
      thread_t myHandle; 
}; 

class Semaphore { 
public: 
      Semaphore (unsigned init = 1); 
      virtual ~Semaphore (); 
      int wait (); 
      int signal (); 
private: 
      sem_t myHandle; 
}; 

class PeriodicThread : public Thread { 
protected: 
      PeriodicThread (time_t period); 
      virtual void periodicActivation () {} 
}; 

class Console { 
public: 
      static char getc (); 
      static void putc (char); 
}; 
#endif 
</pre>

<br/>

## How to run this system?

### Running the system in a designated virtual machine
An xv6 environment with all prerequisites is already set-up in a virtual machine that can be found here: https://drive.google.com/file/d/1edGYFcvdnV0pbKws_1G1vePtEec0qC0G/view  
Once you load the image, password for user is _os_  
  
When virtual machine is booted you can either open the project in any code editor or run the code from terminal. This virtual machine comes with already preinstalled CLion environment.  
To run from terminal, navigate to project folder (folder where _Makefile_ script is) and run following commands:  
<pre>
make clean
make all
make qemu
</pre>

System already comes with a user program that is used to test the system. This program can be found in /tests/userMain.hpp. Program is called from /src/system.cpp.  
To run your own program you can either change the code in /tests/userMain.cpp or write code directly in wrapper function in /src/system.cpp (not recommended).

### Running the system on a Debian based Linux distribution
First of all this is not a thouroughly tested method so there is a possibility that system will not compile or that system execution will show unexpected behaviour.  
To get all the packages required run the following command from terminal:
<pre>sudo apt install git build-essential qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu gdb-multiarch g++-riscv64-linux-gnu</pre>

Once all the packages are installed, from terminal run the following commands:  
<pre>
make clean
make all
make qemu
</pre>

