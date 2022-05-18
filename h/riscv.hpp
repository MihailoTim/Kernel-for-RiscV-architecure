//
// Created by os on 4/28/22.
//

#ifndef OS1_KERNEL_RISCV_HPP
#define OS1_KERNEL_RISCV_HPP


#include "../h/riscv.hpp"
#include "../h/memoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"
#include "../h/scheduler.hpp"

class RiscV{
    static void executeMemAllocSyscall();   //wrapper function for moving parameters and calling MemoryAllocator

    static void executeMemFreeSyscall();    //wrapper function for moving parameters and calling MemoryAllocator

    static void executeThreadCreateSyscall();

    static void executeThreadExitSyscall();

    static void executeThreadDispatch();
public:
    static void pushRegisters();

    static void popRegisters();

    static uint64 r_scause();

    static void w_scause(uint64 scause);

    static uint64 r_sepc();

    static void w_sepc(uint64 sepc);

    static uint64 r_stvec();

    static void w_stvec(uint64 stvec);

    static uint64 r_sstatus();

    static void w_sstatus(uint64 sstatus);

    static void supervisorTrap();      //supervisorTrap defined in /src/supervisorTrap.S

    static void handleSupervisorTrap();

    static void initialize();
};

inline uint64 RiscV::r_scause(){
    uint64 volatile scause;
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    return scause;
}

inline void RiscV::w_scause(uint64 scause){
    asm("csrw scause, %[scause]" : : [scause] "r" (scause));
}

inline uint64 RiscV::r_sepc(){
    uint64 sepc;
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    return sepc;
}

inline void RiscV::w_sepc(uint64 sepc){
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
}

inline uint64 RiscV::r_stvec(){
    uint64 stvec;
    asm("csrr %[stvec], stvec" : [stvec] "=r" (stvec));
    return stvec;
}

inline void RiscV::w_sstatus(uint64 sstatus){
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
}

inline uint64 RiscV::r_sstatus(){
    uint64 sstatus;
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
}

inline void RiscV::initialize() {
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    MemoryAllocator::initialize();
    Scheduler::initialize();
}

#endif //OS1_KERNEL_RISCV_HPP
