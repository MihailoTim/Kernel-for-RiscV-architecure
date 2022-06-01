//
// Created by os on 4/28/22.
//

#ifndef OS1_KERNEL_RISCV_HPP
#define OS1_KERNEL_RISCV_HPP
#include "../lib/hw.h"

class RiscV{
    static bool userMainFinished;

    static uint64 globalTime;

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

    static void executeThreadAttachBodySyscall();

    static void executeThreadStartSyscall();

    static void executeSemOpenSyscall();

    static void executeSemCloseSyscall();

    static void executeSemWaitSyscall();

    static void executeSemSignalSyscall();

    static void executeTimeSleepSyscall();

    static void executeGetcSyscall();

    static void executePutcSyscall();

    static void executePutcUtilSyscall();

    static void putcWrapper(void *arg);

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

    static void ms_sie(uint64 mask);

    static void mc_sie(uint64 mask);

    static void jumpToUserMode();

    static void popSppSpie();

    static void supervisorTrap();      //supervisorTrap defined in /src/supervisorTrap.S

    static void handleSupervisorTrap();

    static bool canFinish();

    static void enableInterrupts();

    static void disableInterrupts();

    static void enableHardwareInterrupts();

    static void disableHardwareInterrupts();

    static void enableTimerInterrupts();

    static void disableTimerInterrupts();

    static void initialize();

    static void finalize();

    friend class TCB;

    friend class Utility;

    friend class System;

    friend class Scheduler;

    friend class ConsoleUtil;
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

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
}

inline void RiscV::enableInterrupts() {
    enableTimerInterrupts();
    enableHardwareInterrupts();
}

inline void RiscV::disableInterrupts() {
    enableTimerInterrupts();
    enableHardwareInterrupts();
}

inline void RiscV::enableHardwareInterrupts() {
    RiscV::mc_sie(SIP_SSIE);
    RiscV::ms_sstatus(SSTATUS_SIE);
    RiscV::ms_sie(SIP_SEIE);
}

inline void RiscV::disableHardwareInterrupts(){
    RiscV::mc_sie(SIP_SEIE);
}

inline void RiscV::enableTimerInterrupts() {
    RiscV::ms_sstatus(SSTATUS_SIE);
    RiscV::ms_sie(SIP_SSIE);
}

inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}
#endif //OS1_KERNEL_RISCV_HPP
