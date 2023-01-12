//
// Created by os on 4/28/22.
//

#ifndef OS1_KERNEL_RISCV_HPP
#define OS1_KERNEL_RISCV_HPP
#include "../../lib/hw.h"
class TCB;
class SlabAllocator;

class RiscV{

    static uint64 globalTime;

    static void* kPMT;
    static void* uPMT;

    static bool initialized;

    static bool userMainFinished;

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

    static void executeThreadFreeSyscall();

    static void executeSemaphoreFreeSyscall();

    static void executeForkSyscall();

    static void putcWrapper(void *arg);

    static void threadCreateUtil(TCB** handle, void(*start_routine)(void*), void *arg);

    static void threadExitUtil();

    static void threadDispatchUtil();

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

    static uint64 getPMT2Entry(uint64 addr);

    static uint64 getPMT1Entry(uint64 addr);

    static uint64 getPMT0Entry(uint64 addr);

    static void startVirtualMemory(void *PMT);
    static void shutVirtualMemory();

    static void saveA0toSscratch();

    static void jumpToDesignatedPrivilegeMode();

    static void popSppSpie();

    static void popSppSpie2();

    static void getPC();

    static void supervisorTrap();      //supervisorTrap defined in /src/supervisorTrap.S

    static void handleSupervisorTrap();

    static void enableInterrupts();

    static void disableInterrupts();

    static void enableHardwareInterrupts();

    static void disableHardwareInterrupts();

    static void enableTimerInterrupts();

    static void disableTimerInterrupts();

    static void handlePageFault(void* PMT,uint64 addr, uint64 mask);

    static void initialize();

    static void finalize();

    static void* getPMT();

    static void buildSection(void* PMT, uint64 start, uint64 end, uint64 mask);

    static void buildKernelPMT();

    static void buildUserPMT();

    static void mapConsoleRegisters(void *PMT);

    friend class TCB;

    friend class System;

    friend class Scheduler;

    friend class ConsoleUtil;

    friend class SlabAllocator;
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
    RiscV::ms_sie(SIP_SSIE);
    RiscV::ms_sie(SIP_SEIE);
    RiscV::ms_sstatus(SSTATUS_SIE);
}

inline void RiscV::disableInterrupts() {
    disableTimerInterrupts();
    disableHardwareInterrupts();
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
    RiscV::mc_sie(SIP_SEIE);
    RiscV::ms_sstatus(SSTATUS_SIE);
    RiscV::ms_sie(SIP_SSIE);
}

inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
}

inline void RiscV::shutVirtualMemory() {
    uint64 satp = 0;
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
}

inline uint64 RiscV::getPMT2Entry(uint64 addr) {
    return (addr >> 30) & (0x1ff);
}

inline uint64 RiscV::getPMT1Entry(uint64 addr) {
    return (addr >> 21) & (0x1ff);
}

inline uint64 RiscV::getPMT0Entry(uint64 addr) {
    return (addr >> 12) & (0x1ff);
}
#endif //OS1_KERNEL_RISCV_HPP