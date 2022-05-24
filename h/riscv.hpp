//
// Created by os on 4/28/22.
//

#ifndef OS1_KERNEL_RISCV_HPP
#define OS1_KERNEL_RISCV_HPP

#include "../h/memoryAllocator.hpp"
#include "../lib/console.h"
#include "../h/scheduler.hpp"
#include "../h/scb.hpp"
#include "./printing.hpp"

class RiscV{
    enum BitMaskSstatus{
        SSTATUS_SIE = (1<<1),
        SSTATUS_SPIE = (1<<5),
        SSTATUS_SPP = (1<<8),
    };

    enum BitMaskSip{
        SIP_SSIE = (1<<1),
        SIP_STIE = (1<<5),
        SIP_SEIE = (1<<9),
    };

    static void executeMemAllocSyscall();   //wrapper function for moving parameters and calling MemoryAllocator

    static void executeMemFreeSyscall();    //wrapper function for moving parameters and calling MemoryAllocator

    static void executeThreadCreateSyscall();

    static void executeThreadExitSyscall();

    static void executeThreadDispatchSyscall();

    static void executeSemOpenSyscall();

    static void executeSemCloseSyscall();

    static void executeSemWaitSyscall();

    static void executeSemSignalSyscall();

    static void executeTimeSleepSyscall();

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

    static void ms_sstatus(uint64 mask);

    static void mc_sstatus(uint64 mask);

    static void ms_sip(uint64 mask);

    static void mc_sip(uint64 mask);

    static void popSppSpie();

    static void supervisorTrap();      //supervisorTrap defined in /src/supervisorTrap.S

    static void handleSupervisorTrap();

    friend class TCB;

    friend class Utility;
public:

    static void enableInterrupts();

    static void disableInterrupts();

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

inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sip(uint64 mask) {
    asm("csrs sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void RiscV::enableInterrupts() {
    RiscV::ms_sstatus(SSTATUS_SIE);
}

inline void RiscV::disableInterrupts() {
    RiscV::mc_sstatus(SSTATUS_SIE);
}
#endif //OS1_KERNEL_RISCV_HPP
