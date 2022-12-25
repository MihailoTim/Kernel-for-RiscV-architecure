
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	86813103          	ld	sp,-1944(sp) # 8000b868 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	104060ef          	jal	ra,80006120 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5RiscV14supervisorTrapEv>:
.global _ZN5RiscV14supervisorTrapEv
_ZN5RiscV14supervisorTrapEv:

    #push all registers to stack

    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    csrw sscratch, sp
    80001024:	14011073          	csrw	sscratch,sp
    .irp index 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 //ommit x10 as it is reserved for return values from function
    sd x\index, \index * 8(sp)
    .endr
    80001028:	00013023          	sd	zero,0(sp)
    8000102c:	00113423          	sd	ra,8(sp)
    80001030:	00213823          	sd	sp,16(sp)
    80001034:	00313c23          	sd	gp,24(sp)
    80001038:	02413023          	sd	tp,32(sp)
    8000103c:	02513423          	sd	t0,40(sp)
    80001040:	02613823          	sd	t1,48(sp)
    80001044:	02713c23          	sd	t2,56(sp)
    80001048:	04813023          	sd	s0,64(sp)
    8000104c:	04913423          	sd	s1,72(sp)
    80001050:	04a13823          	sd	a0,80(sp)
    80001054:	04b13c23          	sd	a1,88(sp)
    80001058:	06c13023          	sd	a2,96(sp)
    8000105c:	06d13423          	sd	a3,104(sp)
    80001060:	06e13823          	sd	a4,112(sp)
    80001064:	06f13c23          	sd	a5,120(sp)
    80001068:	09013023          	sd	a6,128(sp)
    8000106c:	09113423          	sd	a7,136(sp)
    80001070:	09213823          	sd	s2,144(sp)
    80001074:	09313c23          	sd	s3,152(sp)
    80001078:	0b413023          	sd	s4,160(sp)
    8000107c:	0b513423          	sd	s5,168(sp)
    80001080:	0b613823          	sd	s6,176(sp)
    80001084:	0b713c23          	sd	s7,184(sp)
    80001088:	0d813023          	sd	s8,192(sp)
    8000108c:	0d913423          	sd	s9,200(sp)
    80001090:	0da13823          	sd	s10,208(sp)
    80001094:	0db13c23          	sd	s11,216(sp)
    80001098:	0fc13023          	sd	t3,224(sp)
    8000109c:	0fd13423          	sd	t4,232(sp)
    800010a0:	0fe13823          	sd	t5,240(sp)
    800010a4:	0ff13c23          	sd	t6,248(sp)

    #call trap handler
    call _ZN5RiscV20handleSupervisorTrapEv // call handleSupervisorTrap()
    800010a8:	7dc020ef          	jal	ra,80003884 <_ZN5RiscV20handleSupervisorTrapEv>

    #pop all registers from stack

    .irp index 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010ac:	00013003          	ld	zero,0(sp)
    800010b0:	00813083          	ld	ra,8(sp)
    800010b4:	01013103          	ld	sp,16(sp)
    800010b8:	01813183          	ld	gp,24(sp)
    800010bc:	02013203          	ld	tp,32(sp)
    800010c0:	02813283          	ld	t0,40(sp)
    800010c4:	03013303          	ld	t1,48(sp)
    800010c8:	03813383          	ld	t2,56(sp)
    800010cc:	04013403          	ld	s0,64(sp)
    800010d0:	04813483          	ld	s1,72(sp)
    800010d4:	05013503          	ld	a0,80(sp)
    800010d8:	05813583          	ld	a1,88(sp)
    800010dc:	06013603          	ld	a2,96(sp)
    800010e0:	06813683          	ld	a3,104(sp)
    800010e4:	07013703          	ld	a4,112(sp)
    800010e8:	07813783          	ld	a5,120(sp)
    800010ec:	08013803          	ld	a6,128(sp)
    800010f0:	08813883          	ld	a7,136(sp)
    800010f4:	09013903          	ld	s2,144(sp)
    800010f8:	09813983          	ld	s3,152(sp)
    800010fc:	0a013a03          	ld	s4,160(sp)
    80001100:	0a813a83          	ld	s5,168(sp)
    80001104:	0b013b03          	ld	s6,176(sp)
    80001108:	0b813b83          	ld	s7,184(sp)
    8000110c:	0c013c03          	ld	s8,192(sp)
    80001110:	0c813c83          	ld	s9,200(sp)
    80001114:	0d013d03          	ld	s10,208(sp)
    80001118:	0d813d83          	ld	s11,216(sp)
    8000111c:	0e013e03          	ld	t3,224(sp)
    80001120:	0e813e83          	ld	t4,232(sp)
    80001124:	0f013f03          	ld	t5,240(sp)
    80001128:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000112c:	10010113          	addi	sp,sp,256

    80001130:	10200073          	sret
	...

0000000080001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd sp, 0*8(a0)
    80001140:	00253023          	sd	sp,0(a0) # 1000 <_entry-0x7ffff000>
    sd ra, 1*8(a0)
    80001144:	00153423          	sd	ra,8(a0)

    ld sp, 0*8(a1)
    80001148:	0005b103          	ld	sp,0(a1)
    ld ra, 1*8(a1)
    8000114c:	0085b083          	ld	ra,8(a1)

    80001150:	00008067          	ret

0000000080001154 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001154:	ff010113          	addi	sp,sp,-16
    80001158:	00813423          	sd	s0,8(sp)
    8000115c:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001160:	03f50513          	addi	a0,a0,63
    80001164:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001168:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    8000116c:	00100513          	li	a0,1
    asm("ecall");
    80001170:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001174:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001178:	00813403          	ld	s0,8(sp)
    8000117c:	01010113          	addi	sp,sp,16
    80001180:	00008067          	ret

0000000080001184 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001184:	ff010113          	addi	sp,sp,-16
    80001188:	00813423          	sd	s0,8(sp)
    8000118c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001190:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001194:	00200513          	li	a0,2
    asm("ecall");
    80001198:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    8000119c:	00050513          	mv	a0,a0
    return status;
}
    800011a0:	0005051b          	sext.w	a0,a0
    800011a4:	00813403          	ld	s0,8(sp)
    800011a8:	01010113          	addi	sp,sp,16
    800011ac:	00008067          	ret

00000000800011b0 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    800011b0:	fd010113          	addi	sp,sp,-48
    800011b4:	02113423          	sd	ra,40(sp)
    800011b8:	02813023          	sd	s0,32(sp)
    800011bc:	00913c23          	sd	s1,24(sp)
    800011c0:	01213823          	sd	s2,16(sp)
    800011c4:	01313423          	sd	s3,8(sp)
    800011c8:	03010413          	addi	s0,sp,48
    800011cc:	00050913          	mv	s2,a0
    800011d0:	00058493          	mv	s1,a1
    800011d4:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    800011d8:	04058663          	beqz	a1,80001224 <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800011dc:	00001537          	lui	a0,0x1
    800011e0:	00000097          	auipc	ra,0x0
    800011e4:	f74080e7          	jalr	-140(ra) # 80001154 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800011e8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800011ec:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800011f0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800011f4:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    800011f8:	01100513          	li	a0,17

    asm("ecall");
    800011fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001200:	00050513          	mv	a0,a0

    return status;
}
    80001204:	0005051b          	sext.w	a0,a0
    80001208:	02813083          	ld	ra,40(sp)
    8000120c:	02013403          	ld	s0,32(sp)
    80001210:	01813483          	ld	s1,24(sp)
    80001214:	01013903          	ld	s2,16(sp)
    80001218:	00813983          	ld	s3,8(sp)
    8000121c:	03010113          	addi	sp,sp,48
    80001220:	00008067          	ret
    uint64 istack = 0;
    80001224:	00000513          	li	a0,0
    80001228:	fc1ff06f          	j	800011e8 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

000000008000122c <_Z11thread_exitv>:

int thread_exit(){
    8000122c:	ff010113          	addi	sp,sp,-16
    80001230:	00813423          	sd	s0,8(sp)
    80001234:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001238:	01200513          	li	a0,18

    asm("ecall");
    8000123c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001240:	00050513          	mv	a0,a0

    return status;
}
    80001244:	0005051b          	sext.w	a0,a0
    80001248:	00813403          	ld	s0,8(sp)
    8000124c:	01010113          	addi	sp,sp,16
    80001250:	00008067          	ret

0000000080001254 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001254:	ff010113          	addi	sp,sp,-16
    80001258:	00813423          	sd	s0,8(sp)
    8000125c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001260:	01300513          	li	a0,19

    asm("ecall");
    80001264:	00000073          	ecall
}
    80001268:	00813403          	ld	s0,8(sp)
    8000126c:	01010113          	addi	sp,sp,16
    80001270:	00008067          	ret

0000000080001274 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001274:	fd010113          	addi	sp,sp,-48
    80001278:	02113423          	sd	ra,40(sp)
    8000127c:	02813023          	sd	s0,32(sp)
    80001280:	00913c23          	sd	s1,24(sp)
    80001284:	01213823          	sd	s2,16(sp)
    80001288:	01313423          	sd	s3,8(sp)
    8000128c:	03010413          	addi	s0,sp,48
    80001290:	00050913          	mv	s2,a0
    80001294:	00058493          	mv	s1,a1
    80001298:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    8000129c:	04058663          	beqz	a1,800012e8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800012a0:	00001537          	lui	a0,0x1
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	eb0080e7          	jalr	-336(ra) # 80001154 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800012ac:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800012b0:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800012b4:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800012b8:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    800012bc:	01400513          	li	a0,20

    asm("ecall");
    800012c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800012c4:	00050513          	mv	a0,a0

    return status;
}
    800012c8:	0005051b          	sext.w	a0,a0
    800012cc:	02813083          	ld	ra,40(sp)
    800012d0:	02013403          	ld	s0,32(sp)
    800012d4:	01813483          	ld	s1,24(sp)
    800012d8:	01013903          	ld	s2,16(sp)
    800012dc:	00813983          	ld	s3,8(sp)
    800012e0:	03010113          	addi	sp,sp,48
    800012e4:	00008067          	ret
    uint64 istack = 0;
    800012e8:	00000513          	li	a0,0
    800012ec:	fc1ff06f          	j	800012ac <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

00000000800012f0 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    800012f0:	ff010113          	addi	sp,sp,-16
    800012f4:	00813423          	sd	s0,8(sp)
    800012f8:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800012fc:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001300:	01500513          	li	a0,21

    asm("ecall");
    80001304:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001308:	00050513          	mv	a0,a0

    return status;
}
    8000130c:	0005051b          	sext.w	a0,a0
    80001310:	00813403          	ld	s0,8(sp)
    80001314:	01010113          	addi	sp,sp,16
    80001318:	00008067          	ret

000000008000131c <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    8000131c:	ff010113          	addi	sp,sp,-16
    80001320:	00813423          	sd	s0,8(sp)
    80001324:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001328:	02059593          	slli	a1,a1,0x20
    8000132c:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001330:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001334:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001338:	02100513          	li	a0,33


    asm("ecall");
    8000133c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001340:	00050513          	mv	a0,a0

    return status;

}
    80001344:	0005051b          	sext.w	a0,a0
    80001348:	00813403          	ld	s0,8(sp)
    8000134c:	01010113          	addi	sp,sp,16
    80001350:	00008067          	ret

0000000080001354 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001354:	ff010113          	addi	sp,sp,-16
    80001358:	00813423          	sd	s0,8(sp)
    8000135c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001360:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001364:	02200513          	li	a0,34


    asm("ecall");
    80001368:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000136c:	00050513          	mv	a0,a0

    return status;
}
    80001370:	0005051b          	sext.w	a0,a0
    80001374:	00813403          	ld	s0,8(sp)
    80001378:	01010113          	addi	sp,sp,16
    8000137c:	00008067          	ret

0000000080001380 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001380:	ff010113          	addi	sp,sp,-16
    80001384:	00813423          	sd	s0,8(sp)
    80001388:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000138c:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001390:	02300513          	li	a0,35


    asm("ecall");
    80001394:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001398:	00050513          	mv	a0,a0

    return status;
}
    8000139c:	0005051b          	sext.w	a0,a0
    800013a0:	00813403          	ld	s0,8(sp)
    800013a4:	01010113          	addi	sp,sp,16
    800013a8:	00008067          	ret

00000000800013ac <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    800013ac:	ff010113          	addi	sp,sp,-16
    800013b0:	00813423          	sd	s0,8(sp)
    800013b4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800013b8:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    800013bc:	02400513          	li	a0,36


    asm("ecall");
    800013c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800013c4:	00050513          	mv	a0,a0

    return status;
}
    800013c8:	0005051b          	sext.w	a0,a0
    800013cc:	00813403          	ld	s0,8(sp)
    800013d0:	01010113          	addi	sp,sp,16
    800013d4:	00008067          	ret

00000000800013d8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    800013d8:	ff010113          	addi	sp,sp,-16
    800013dc:	00813423          	sd	s0,8(sp)
    800013e0:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    800013e4:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    800013e8:	03100513          	li	a0,49


    asm("ecall");
    800013ec:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800013f0:	00050513          	mv	a0,a0

    return status;
}
    800013f4:	0005051b          	sext.w	a0,a0
    800013f8:	00813403          	ld	s0,8(sp)
    800013fc:	01010113          	addi	sp,sp,16
    80001400:	00008067          	ret

0000000080001404 <_Z4getcv>:

char getc(){
    80001404:	ff010113          	addi	sp,sp,-16
    80001408:	00813423          	sd	s0,8(sp)
    8000140c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80001410:	04100513          	li	a0,65

    asm("ecall");
    80001414:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80001418:	00050513          	mv	a0,a0

    return c;
}
    8000141c:	0ff57513          	andi	a0,a0,255
    80001420:	00813403          	ld	s0,8(sp)
    80001424:	01010113          	addi	sp,sp,16
    80001428:	00008067          	ret

000000008000142c <_Z4putcc>:

void putc(char c){
    8000142c:	ff010113          	addi	sp,sp,-16
    80001430:	00813423          	sd	s0,8(sp)
    80001434:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80001438:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    8000143c:	04200513          	li	a0,66

    asm("ecall");
    80001440:	00000073          	ecall
}
    80001444:	00813403          	ld	s0,8(sp)
    80001448:	01010113          	addi	sp,sp,16
    8000144c:	00008067          	ret

0000000080001450 <_Z4forkv>:


int fork(){
    80001450:	ff010113          	addi	sp,sp,-16
    80001454:	00813423          	sd	s0,8(sp)
    80001458:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    8000145c:	06100513          	li	a0,97

    asm("ecall");
    80001460:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001464:	00050513          	mv	a0,a0

    return status;
}
    80001468:	0005051b          	sext.w	a0,a0
    8000146c:	00813403          	ld	s0,8(sp)
    80001470:	01010113          	addi	sp,sp,16
    80001474:	00008067          	ret

0000000080001478 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001478:	ff010113          	addi	sp,sp,-16
    8000147c:	00813423          	sd	s0,8(sp)
    80001480:	01010413          	addi	s0,sp,16
    80001484:	00100793          	li	a5,1
    80001488:	00f50863          	beq	a0,a5,80001498 <_Z41__static_initialization_and_destruction_0ii+0x20>
    8000148c:	00813403          	ld	s0,8(sp)
    80001490:	01010113          	addi	sp,sp,16
    80001494:	00008067          	ret
    80001498:	000107b7          	lui	a5,0x10
    8000149c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800014a0:	fef596e3          	bne	a1,a5,8000148c <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800014a4:	0000a797          	auipc	a5,0xa
    800014a8:	3947b783          	ld	a5,916(a5) # 8000b838 <_GLOBAL_OFFSET_TABLE_+0x18>
    800014ac:	0007b783          	ld	a5,0(a5)
    800014b0:	00c7d793          	srli	a5,a5,0xc
    800014b4:	00278713          	addi	a4,a5,2
    800014b8:	00c71713          	slli	a4,a4,0xc
    800014bc:	0000a697          	auipc	a3,0xa
    800014c0:	46468693          	addi	a3,a3,1124 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800014c4:	00e6b023          	sd	a4,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800014c8:	00178793          	addi	a5,a5,1
    800014cc:	00c79793          	slli	a5,a5,0xc
    800014d0:	00f6b423          	sd	a5,8(a3)
    800014d4:	fb9ff06f          	j	8000148c <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800014d8 <_ZN5Buddy10initializeEv>:
void Buddy::initialize(){
    800014d8:	ff010113          	addi	sp,sp,-16
    800014dc:	00813423          	sd	s0,8(sp)
    800014e0:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800014e4:	0000a797          	auipc	a5,0xa
    800014e8:	3547b783          	ld	a5,852(a5) # 8000b838 <_GLOBAL_OFFSET_TABLE_+0x18>
    800014ec:	0007b783          	ld	a5,0(a5)
    800014f0:	00c7d793          	srli	a5,a5,0xc
    800014f4:	00278713          	addi	a4,a5,2
    800014f8:	00c71713          	slli	a4,a4,0xc
    800014fc:	0000a697          	auipc	a3,0xa
    80001500:	42468693          	addi	a3,a3,1060 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001504:	00e6b023          	sd	a4,0(a3)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001508:	00178793          	addi	a5,a5,1
    8000150c:	00c79793          	slli	a5,a5,0xc
    80001510:	00f6b423          	sd	a5,8(a3)
    Buddy::BLOCKS_AVAILABLE = BUDDY_NUMBER_OF_BLOCKS;
    80001514:	000017b7          	lui	a5,0x1
    80001518:	0000a617          	auipc	a2,0xa
    8000151c:	16f63c23          	sd	a5,376(a2) # 8000b690 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    head[BUCKET_SIZE-1] = tail[BUCKET_SIZE-1] = (Block*)BUDDY_START_ADDR;
    80001520:	06e6b823          	sd	a4,112(a3)
    80001524:	0ce6bc23          	sd	a4,216(a3)
    head[BUCKET_SIZE-1]->next = tail[BUCKET_SIZE-1]->next = nullptr;
    80001528:	00073023          	sd	zero,0(a4)
    8000152c:	0d86b783          	ld	a5,216(a3)
    80001530:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
}
    80001534:	00813403          	ld	s0,8(sp)
    80001538:	01010113          	addi	sp,sp,16
    8000153c:	00008067          	ret

0000000080001540 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001540:	00c00793          	li	a5,12
    80001544:	0ef50863          	beq	a0,a5,80001634 <_ZN5Buddy8compressEm+0xf4>
void Buddy::compress(uint64 size) {
    80001548:	fd010113          	addi	sp,sp,-48
    8000154c:	02113423          	sd	ra,40(sp)
    80001550:	02813023          	sd	s0,32(sp)
    80001554:	00913c23          	sd	s1,24(sp)
    80001558:	01213823          	sd	s2,16(sp)
    8000155c:	01313423          	sd	s3,8(sp)
    80001560:	03010413          	addi	s0,sp,48
    80001564:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001568:	00351713          	slli	a4,a0,0x3
    8000156c:	0000a797          	auipc	a5,0xa
    80001570:	3b478793          	addi	a5,a5,948 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001574:	00e787b3          	add	a5,a5,a4
    80001578:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    8000157c:	00000993          	li	s3,0
    80001580:	0180006f          	j	80001598 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80001584:	40d70733          	sub	a4,a4,a3
        if(blkNoNext == pair){
    80001588:	04f70663          	beq	a4,a5,800015d4 <_ZN5Buddy8compressEm+0x94>
            prev = curr;
    8000158c:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80001590:	06f70863          	beq	a4,a5,80001600 <_ZN5Buddy8compressEm+0xc0>
        curr = curr->next;
    80001594:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80001598:	08048063          	beqz	s1,80001618 <_ZN5Buddy8compressEm+0xd8>
    8000159c:	0004b603          	ld	a2,0(s1)
    800015a0:	06060c63          	beqz	a2,80001618 <_ZN5Buddy8compressEm+0xd8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    800015a4:	0000a797          	auipc	a5,0xa
    800015a8:	37c7b783          	ld	a5,892(a5) # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800015ac:	40f48733          	sub	a4,s1,a5
    800015b0:	00c75713          	srli	a4,a4,0xc
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    800015b4:	40f607b3          	sub	a5,a2,a5
    800015b8:	00c7d793          	srli	a5,a5,0xc
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    800015bc:	00100693          	li	a3,1
    800015c0:	012696bb          	sllw	a3,a3,s2
    800015c4:	02d775b3          	remu	a1,a4,a3
    800015c8:	fa059ee3          	bnez	a1,80001584 <_ZN5Buddy8compressEm+0x44>
    800015cc:	00e68733          	add	a4,a3,a4
    800015d0:	fb9ff06f          	j	80001588 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    800015d4:	00098863          	beqz	s3,800015e4 <_ZN5Buddy8compressEm+0xa4>
                prev->next = curr->next->next;
    800015d8:	00063683          	ld	a3,0(a2)
    800015dc:	00d9b023          	sd	a3,0(s3)
    800015e0:	fb1ff06f          	j	80001590 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    800015e4:	00063603          	ld	a2,0(a2)
    800015e8:	00391593          	slli	a1,s2,0x3
    800015ec:	0000a697          	auipc	a3,0xa
    800015f0:	33468693          	addi	a3,a3,820 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800015f4:	00b686b3          	add	a3,a3,a1
    800015f8:	06c6bc23          	sd	a2,120(a3)
    800015fc:	f95ff06f          	j	80001590 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80001600:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80001604:	00190593          	addi	a1,s2,1
    80001608:	00048513          	mv	a0,s1
    8000160c:	00000097          	auipc	ra,0x0
    80001610:	02c080e7          	jalr	44(ra) # 80001638 <_ZN5Buddy6insertEPvm>
    80001614:	f81ff06f          	j	80001594 <_ZN5Buddy8compressEm+0x54>
}
    80001618:	02813083          	ld	ra,40(sp)
    8000161c:	02013403          	ld	s0,32(sp)
    80001620:	01813483          	ld	s1,24(sp)
    80001624:	01013903          	ld	s2,16(sp)
    80001628:	00813983          	ld	s3,8(sp)
    8000162c:	03010113          	addi	sp,sp,48
    80001630:	00008067          	ret
    80001634:	00008067          	ret

0000000080001638 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80001638:	00050693          	mv	a3,a0
    if(!head[size]){
    8000163c:	00359713          	slli	a4,a1,0x3
    80001640:	0000a797          	auipc	a5,0xa
    80001644:	2e078793          	addi	a5,a5,736 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001648:	00e787b3          	add	a5,a5,a4
    8000164c:	0787b783          	ld	a5,120(a5)
    80001650:	02078863          	beqz	a5,80001680 <_ZN5Buddy6insertEPvm+0x48>
void Buddy::insert(void *addr, uint64 size) {
    80001654:	ff010113          	addi	sp,sp,-16
    80001658:	00113423          	sd	ra,8(sp)
    8000165c:	00813023          	sd	s0,0(sp)
    80001660:	01010413          	addi	s0,sp,16
    80001664:	00058513          	mv	a0,a1
        if((uint64)addr < (uint64)head[size]){
    80001668:	00068713          	mv	a4,a3
    8000166c:	02f6ec63          	bltu	a3,a5,800016a4 <_ZN5Buddy6insertEPvm+0x6c>
            while(iter != nullptr){
    80001670:	06078663          	beqz	a5,800016dc <_ZN5Buddy6insertEPvm+0xa4>
                if((uint64)addr < (uint64)iter) {
    80001674:	04f76a63          	bltu	a4,a5,800016c8 <_ZN5Buddy6insertEPvm+0x90>
                    iter = iter->next;
    80001678:	0007b783          	ld	a5,0(a5)
            while(iter != nullptr){
    8000167c:	ff5ff06f          	j	80001670 <_ZN5Buddy6insertEPvm+0x38>
        head[size] = tail[size] = (Block*)addr;
    80001680:	0000a797          	auipc	a5,0xa
    80001684:	2a078793          	addi	a5,a5,672 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001688:	00e78533          	add	a0,a5,a4
    8000168c:	00d53823          	sd	a3,16(a0) # 1010 <_entry-0x7fffeff0>
    80001690:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80001694:	0006b023          	sd	zero,0(a3)
    80001698:	07853783          	ld	a5,120(a0)
    8000169c:	0007b023          	sd	zero,0(a5)
        return;
    800016a0:	00008067          	ret
            newHead->next = head[size];
    800016a4:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800016a8:	00359713          	slli	a4,a1,0x3
    800016ac:	0000a797          	auipc	a5,0xa
    800016b0:	27478793          	addi	a5,a5,628 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800016b4:	00e787b3          	add	a5,a5,a4
    800016b8:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	e84080e7          	jalr	-380(ra) # 80001540 <_ZN5Buddy8compressEm>
            return;
    800016c4:	0440006f          	j	80001708 <_ZN5Buddy6insertEPvm+0xd0>
                    newBlock->next = iter;
    800016c8:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800016cc:	00d03023          	sd	a3,0(zero) # 0 <_entry-0x80000000>
                    compress(size);
    800016d0:	00000097          	auipc	ra,0x0
    800016d4:	e70080e7          	jalr	-400(ra) # 80001540 <_ZN5Buddy8compressEm>
                    return;
    800016d8:	0300006f          	j	80001708 <_ZN5Buddy6insertEPvm+0xd0>
    tail[size]->next = (Block*)addr;
    800016dc:	00351713          	slli	a4,a0,0x3
    800016e0:	0000a797          	auipc	a5,0xa
    800016e4:	24078793          	addi	a5,a5,576 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800016e8:	00e787b3          	add	a5,a5,a4
    800016ec:	0107b703          	ld	a4,16(a5)
    800016f0:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800016f4:	0107b703          	ld	a4,16(a5)
    800016f8:	00073703          	ld	a4,0(a4)
    800016fc:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80001700:	00000097          	auipc	ra,0x0
    80001704:	e40080e7          	jalr	-448(ra) # 80001540 <_ZN5Buddy8compressEm>
}
    80001708:	00813083          	ld	ra,8(sp)
    8000170c:	00013403          	ld	s0,0(sp)
    80001710:	01010113          	addi	sp,sp,16
    80001714:	00008067          	ret

0000000080001718 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80001718:	02050663          	beqz	a0,80001744 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    8000171c:	ff010113          	addi	sp,sp,-16
    80001720:	00113423          	sd	ra,8(sp)
    80001724:	00813023          	sd	s0,0(sp)
    80001728:	01010413          	addi	s0,sp,16
    insert(addr,size);
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	f0c080e7          	jalr	-244(ra) # 80001638 <_ZN5Buddy6insertEPvm>
}
    80001734:	00813083          	ld	ra,8(sp)
    80001738:	00013403          	ld	s0,0(sp)
    8000173c:	01010113          	addi	sp,sp,16
    80001740:	00008067          	ret
    80001744:	00008067          	ret

0000000080001748 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001748:	ff010113          	addi	sp,sp,-16
    8000174c:	00813423          	sd	s0,8(sp)
    80001750:	01010413          	addi	s0,sp,16
    80001754:	03c0006f          	j	80001790 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001758:	00b5859b          	addiw	a1,a1,11
    8000175c:	00100713          	li	a4,1
    80001760:	00b715bb          	sllw	a1,a4,a1
    80001764:	00b505b3          	add	a1,a0,a1
    80001768:	00379693          	slli	a3,a5,0x3
    8000176c:	0000a717          	auipc	a4,0xa
    80001770:	1b470713          	addi	a4,a4,436 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001774:	00d70733          	add	a4,a4,a3
    80001778:	00b73823          	sd	a1,16(a4)
    8000177c:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80001780:	0005b023          	sd	zero,0(a1)
    80001784:	07873703          	ld	a4,120(a4)
    80001788:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000178c:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80001790:	fff5879b          	addiw	a5,a1,-1
    80001794:	04c7c863          	blt	a5,a2,800017e4 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80001798:	00379693          	slli	a3,a5,0x3
    8000179c:	0000a717          	auipc	a4,0xa
    800017a0:	18470713          	addi	a4,a4,388 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800017a4:	00d70733          	add	a4,a4,a3
    800017a8:	01073683          	ld	a3,16(a4)
    800017ac:	fa0686e3          	beqz	a3,80001758 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800017b0:	00b5859b          	addiw	a1,a1,11
    800017b4:	00100713          	li	a4,1
    800017b8:	00b715bb          	sllw	a1,a4,a1
    800017bc:	00b505b3          	add	a1,a0,a1
    800017c0:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800017c4:	00379693          	slli	a3,a5,0x3
    800017c8:	0000a717          	auipc	a4,0xa
    800017cc:	15870713          	addi	a4,a4,344 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    800017d0:	00d70733          	add	a4,a4,a3
    800017d4:	01073683          	ld	a3,16(a4)
    800017d8:	0006b683          	ld	a3,0(a3)
    800017dc:	00d73823          	sd	a3,16(a4)
    800017e0:	fadff06f          	j	8000178c <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800017e4:	00813403          	ld	s0,8(sp)
    800017e8:	01010113          	addi	sp,sp,16
    800017ec:	00008067          	ret

00000000800017f0 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800017f0:	fe010113          	addi	sp,sp,-32
    800017f4:	00113c23          	sd	ra,24(sp)
    800017f8:	00813823          	sd	s0,16(sp)
    800017fc:	00913423          	sd	s1,8(sp)
    80001800:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80001804:	00c00793          	li	a5,12
    80001808:	06a7ec63          	bltu	a5,a0,80001880 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    8000180c:	00050593          	mv	a1,a0
    80001810:	00c00793          	li	a5,12
    80001814:	06b7ea63          	bltu	a5,a1,80001888 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80001818:	00359713          	slli	a4,a1,0x3
    8000181c:	0000a797          	auipc	a5,0xa
    80001820:	10478793          	addi	a5,a5,260 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001824:	00e787b3          	add	a5,a5,a4
    80001828:	0787b483          	ld	s1,120(a5)
    8000182c:	00049663          	bnez	s1,80001838 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001830:	00158593          	addi	a1,a1,1
    80001834:	fddff06f          	j	80001810 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80001838:	0004b703          	ld	a4,0(s1)
    8000183c:	00359693          	slli	a3,a1,0x3
    80001840:	0000a797          	auipc	a5,0xa
    80001844:	0e078793          	addi	a5,a5,224 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001848:	00d787b3          	add	a5,a5,a3
    8000184c:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80001850:	00070e63          	beqz	a4,8000186c <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80001854:	0005061b          	sext.w	a2,a0
    80001858:	0005859b          	sext.w	a1,a1
    8000185c:	00048513          	mv	a0,s1
    80001860:	00000097          	auipc	ra,0x0
    80001864:	ee8080e7          	jalr	-280(ra) # 80001748 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80001868:	0240006f          	j	8000188c <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    8000186c:	0000a797          	auipc	a5,0xa
    80001870:	0b478793          	addi	a5,a5,180 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001874:	00d787b3          	add	a5,a5,a3
    80001878:	0007b823          	sd	zero,16(a5)
    8000187c:	fd9ff06f          	j	80001854 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80001880:	00000493          	li	s1,0
    80001884:	0080006f          	j	8000188c <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80001888:	00000493          	li	s1,0
}
    8000188c:	00048513          	mv	a0,s1
    80001890:	01813083          	ld	ra,24(sp)
    80001894:	01013403          	ld	s0,16(sp)
    80001898:	00813483          	ld	s1,8(sp)
    8000189c:	02010113          	addi	sp,sp,32
    800018a0:	00008067          	ret

00000000800018a4 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    800018a4:	fe010113          	addi	sp,sp,-32
    800018a8:	00113c23          	sd	ra,24(sp)
    800018ac:	00813823          	sd	s0,16(sp)
    800018b0:	00913423          	sd	s1,8(sp)
    800018b4:	01213023          	sd	s2,0(sp)
    800018b8:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    800018bc:	00000913          	li	s2,0
    800018c0:	0180006f          	j	800018d8 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800018c4:	00007517          	auipc	a0,0x7
    800018c8:	7fc50513          	addi	a0,a0,2044 # 800090c0 <CONSOLE_STATUS+0xb0>
    800018cc:	00003097          	auipc	ra,0x3
    800018d0:	888080e7          	jalr	-1912(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800018d4:	0019091b          	addiw	s2,s2,1
    800018d8:	00c00793          	li	a5,12
    800018dc:	0727c663          	blt	a5,s2,80001948 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800018e0:	00000613          	li	a2,0
    800018e4:	00a00593          	li	a1,10
    800018e8:	00090513          	mv	a0,s2
    800018ec:	00003097          	auipc	ra,0x3
    800018f0:	8ac080e7          	jalr	-1876(ra) # 80004198 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800018f4:	00007517          	auipc	a0,0x7
    800018f8:	72c50513          	addi	a0,a0,1836 # 80009020 <CONSOLE_STATUS+0x10>
    800018fc:	00003097          	auipc	ra,0x3
    80001900:	858080e7          	jalr	-1960(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80001904:	00391713          	slli	a4,s2,0x3
    80001908:	0000a797          	auipc	a5,0xa
    8000190c:	01878793          	addi	a5,a5,24 # 8000b920 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001910:	00e787b3          	add	a5,a5,a4
    80001914:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80001918:	fa0486e3          	beqz	s1,800018c4 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    8000191c:	00000613          	li	a2,0
    80001920:	00a00593          	li	a1,10
    80001924:	0004851b          	sext.w	a0,s1
    80001928:	00003097          	auipc	ra,0x3
    8000192c:	870080e7          	jalr	-1936(ra) # 80004198 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80001930:	00007517          	auipc	a0,0x7
    80001934:	6f850513          	addi	a0,a0,1784 # 80009028 <CONSOLE_STATUS+0x18>
    80001938:	00003097          	auipc	ra,0x3
    8000193c:	81c080e7          	jalr	-2020(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80001940:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80001944:	fd5ff06f          	j	80001918 <_ZN5Buddy9printListEv+0x74>
    80001948:	01813083          	ld	ra,24(sp)
    8000194c:	01013403          	ld	s0,16(sp)
    80001950:	00813483          	ld	s1,8(sp)
    80001954:	00013903          	ld	s2,0(sp)
    80001958:	02010113          	addi	sp,sp,32
    8000195c:	00008067          	ret

0000000080001960 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80001960:	ff010113          	addi	sp,sp,-16
    80001964:	00113423          	sd	ra,8(sp)
    80001968:	00813023          	sd	s0,0(sp)
    8000196c:	01010413          	addi	s0,sp,16
    80001970:	000105b7          	lui	a1,0x10
    80001974:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001978:	00100513          	li	a0,1
    8000197c:	00000097          	auipc	ra,0x0
    80001980:	afc080e7          	jalr	-1284(ra) # 80001478 <_Z41__static_initialization_and_destruction_0ii>
    80001984:	00813083          	ld	ra,8(sp)
    80001988:	00013403          	ld	s0,0(sp)
    8000198c:	01010113          	addi	sp,sp,16
    80001990:	00008067          	ret

0000000080001994 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80001994:	ff010113          	addi	sp,sp,-16
    80001998:	00113423          	sd	ra,8(sp)
    8000199c:	00813023          	sd	s0,0(sp)
    800019a0:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    800019a4:	00000097          	auipc	ra,0x0
    800019a8:	9b0080e7          	jalr	-1616(ra) # 80001354 <_Z9sem_closeP10_semaphore>
}
    800019ac:	00813083          	ld	ra,8(sp)
    800019b0:	00013403          	ld	s0,0(sp)
    800019b4:	01010113          	addi	sp,sp,16
    800019b8:	00008067          	ret

00000000800019bc <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    800019bc:	ff010113          	addi	sp,sp,-16
    800019c0:	00113423          	sd	ra,8(sp)
    800019c4:	00813023          	sd	s0,0(sp)
    800019c8:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    800019cc:	00001097          	auipc	ra,0x1
    800019d0:	a54080e7          	jalr	-1452(ra) # 80002420 <_ZN3TCB11thread_freeEPv>
    800019d4:	00813083          	ld	ra,8(sp)
    800019d8:	00013403          	ld	s0,0(sp)
    800019dc:	01010113          	addi	sp,sp,16
    800019e0:	00008067          	ret

00000000800019e4 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    800019e4:	ff010113          	addi	sp,sp,-16
    800019e8:	00113423          	sd	ra,8(sp)
    800019ec:	00813023          	sd	s0,0(sp)
    800019f0:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    800019f4:	00004097          	auipc	ra,0x4
    800019f8:	e88080e7          	jalr	-376(ra) # 8000587c <_Z8userMainv>
    800019fc:	00813083          	ld	ra,8(sp)
    80001a00:	00013403          	ld	s0,0(sp)
    80001a04:	01010113          	addi	sp,sp,16
    80001a08:	00008067          	ret

0000000080001a0c <_ZN6SystemC1Ev>:
System::System() {
    80001a0c:	fd010113          	addi	sp,sp,-48
    80001a10:	02113423          	sd	ra,40(sp)
    80001a14:	02813023          	sd	s0,32(sp)
    80001a18:	00913c23          	sd	s1,24(sp)
    80001a1c:	01213823          	sd	s2,16(sp)
    80001a20:	03010413          	addi	s0,sp,48
    80001a24:	ffffc2b7          	lui	t0,0xffffc
    80001a28:	00510133          	add	sp,sp,t0
    if (!initialized) {
    80001a2c:	0000a497          	auipc	s1,0xa
    80001a30:	fd44c483          	lbu	s1,-44(s1) # 8000ba00 <_ZN6System11initializedE>
    80001a34:	02048263          	beqz	s1,80001a58 <_ZN6SystemC1Ev+0x4c>
}
    80001a38:	000042b7          	lui	t0,0x4
    80001a3c:	00510133          	add	sp,sp,t0
    80001a40:	02813083          	ld	ra,40(sp)
    80001a44:	02013403          	ld	s0,32(sp)
    80001a48:	01813483          	ld	s1,24(sp)
    80001a4c:	01013903          	ld	s2,16(sp)
    80001a50:	03010113          	addi	sp,sp,48
    80001a54:	00008067          	ret
        initialized = true;
    80001a58:	00100793          	li	a5,1
    80001a5c:	0000a717          	auipc	a4,0xa
    80001a60:	faf70223          	sb	a5,-92(a4) # 8000ba00 <_ZN6System11initializedE>
        RiscV::initialize();
    80001a64:	00001097          	auipc	ra,0x1
    80001a68:	358080e7          	jalr	856(ra) # 80002dbc <_ZN5RiscV10initializeEv>
        for(int i=0;i<2048;i++){
    80001a6c:	00000913          	li	s2,0
    80001a70:	7ff00793          	li	a5,2047
    80001a74:	0327ca63          	blt	a5,s2,80001aa8 <_ZN6SystemC1Ev+0x9c>
            mem[i] = Buddy::alloc(0);
    80001a78:	00000513          	li	a0,0
    80001a7c:	00000097          	auipc	ra,0x0
    80001a80:	d74080e7          	jalr	-652(ra) # 800017f0 <_ZN5Buddy5allocEm>
    80001a84:	ffffc737          	lui	a4,0xffffc
    80001a88:	00391793          	slli	a5,s2,0x3
    80001a8c:	fe040693          	addi	a3,s0,-32
    80001a90:	00e68733          	add	a4,a3,a4
    80001a94:	00f707b3          	add	a5,a4,a5
    80001a98:	00a7b023          	sd	a0,0(a5)
            if(!mem[i]){
    80001a9c:	00050a63          	beqz	a0,80001ab0 <_ZN6SystemC1Ev+0xa4>
        for(int i=0;i<2048;i++){
    80001aa0:	0019091b          	addiw	s2,s2,1
    80001aa4:	fcdff06f          	j	80001a70 <_ZN6SystemC1Ev+0x64>
        bool error = false;
    80001aa8:	00048793          	mv	a5,s1
    80001aac:	0080006f          	j	80001ab4 <_ZN6SystemC1Ev+0xa8>
                error = true;
    80001ab0:	00100793          	li	a5,1
        if(error)
    80001ab4:	04078e63          	beqz	a5,80001b10 <_ZN6SystemC1Ev+0x104>
            ConsoleUtil::printString("ERROR\n");
    80001ab8:	00007517          	auipc	a0,0x7
    80001abc:	57850513          	addi	a0,a0,1400 # 80009030 <CONSOLE_STATUS+0x20>
    80001ac0:	00002097          	auipc	ra,0x2
    80001ac4:	694080e7          	jalr	1684(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        for(int i=1;i<2048;i++){
    80001ac8:	00100713          	li	a4,1
    80001acc:	7ff00793          	li	a5,2047
    80001ad0:	04e7cc63          	blt	a5,a4,80001b28 <_ZN6SystemC1Ev+0x11c>
            if((uint64)mem[i] - (uint64)mem[i-1] != 4096) {
    80001ad4:	ffffc7b7          	lui	a5,0xffffc
    80001ad8:	fe040693          	addi	a3,s0,-32
    80001adc:	00f687b3          	add	a5,a3,a5
    80001ae0:	00371693          	slli	a3,a4,0x3
    80001ae4:	00d786b3          	add	a3,a5,a3
    80001ae8:	0006b683          	ld	a3,0(a3)
    80001aec:	fff7061b          	addiw	a2,a4,-1
    80001af0:	00361613          	slli	a2,a2,0x3
    80001af4:	00c787b3          	add	a5,a5,a2
    80001af8:	0007b783          	ld	a5,0(a5) # ffffffffffffc000 <end+0xffffffff7ffeb2b0>
    80001afc:	40f687b3          	sub	a5,a3,a5
    80001b00:	000016b7          	lui	a3,0x1
    80001b04:	02d79063          	bne	a5,a3,80001b24 <_ZN6SystemC1Ev+0x118>
        for(int i=1;i<2048;i++){
    80001b08:	0017071b          	addiw	a4,a4,1
    80001b0c:	fc1ff06f          	j	80001acc <_ZN6SystemC1Ev+0xc0>
            ConsoleUtil::printString("ALL OK\n");
    80001b10:	00007517          	auipc	a0,0x7
    80001b14:	52850513          	addi	a0,a0,1320 # 80009038 <CONSOLE_STATUS+0x28>
    80001b18:	00002097          	auipc	ra,0x2
    80001b1c:	63c080e7          	jalr	1596(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    80001b20:	fa9ff06f          	j	80001ac8 <_ZN6SystemC1Ev+0xbc>
                error = true;
    80001b24:	00100493          	li	s1,1
        if(error)
    80001b28:	04048663          	beqz	s1,80001b74 <_ZN6SystemC1Ev+0x168>
            ConsoleUtil::printString("ERROR\n");
    80001b2c:	00007517          	auipc	a0,0x7
    80001b30:	50450513          	addi	a0,a0,1284 # 80009030 <CONSOLE_STATUS+0x20>
    80001b34:	00002097          	auipc	ra,0x2
    80001b38:	620080e7          	jalr	1568(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
                error = true;
    80001b3c:	00000493          	li	s1,0
        for(int i=0;i<2048;i++){
    80001b40:	7ff00793          	li	a5,2047
    80001b44:	0497c263          	blt	a5,s1,80001b88 <_ZN6SystemC1Ev+0x17c>
            Buddy::free(mem[i],0);
    80001b48:	ffffc7b7          	lui	a5,0xffffc
    80001b4c:	00349713          	slli	a4,s1,0x3
    80001b50:	fe040693          	addi	a3,s0,-32
    80001b54:	00f687b3          	add	a5,a3,a5
    80001b58:	00e787b3          	add	a5,a5,a4
    80001b5c:	00000593          	li	a1,0
    80001b60:	0007b503          	ld	a0,0(a5) # ffffffffffffc000 <end+0xffffffff7ffeb2b0>
    80001b64:	00000097          	auipc	ra,0x0
    80001b68:	bb4080e7          	jalr	-1100(ra) # 80001718 <_ZN5Buddy4freeEPvm>
        for(int i=0;i<2048;i++){
    80001b6c:	0014849b          	addiw	s1,s1,1
    80001b70:	fd1ff06f          	j	80001b40 <_ZN6SystemC1Ev+0x134>
            ConsoleUtil::printString("ALL OK\n");
    80001b74:	00007517          	auipc	a0,0x7
    80001b78:	4c450513          	addi	a0,a0,1220 # 80009038 <CONSOLE_STATUS+0x28>
    80001b7c:	00002097          	auipc	ra,0x2
    80001b80:	5d8080e7          	jalr	1496(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    80001b84:	fb9ff06f          	j	80001b3c <_ZN6SystemC1Ev+0x130>
    }Bucket;

    static void printList();

    static inline bool canAllocate(uint64 size){
        return head[size] != nullptr;
    80001b88:	0000a797          	auipc	a5,0xa
    80001b8c:	d387b783          	ld	a5,-712(a5) # 8000b8c0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80001b90:	0607b783          	ld	a5,96(a5)
        if(!Buddy::canAllocate(12))
    80001b94:	08078c63          	beqz	a5,80001c2c <_ZN6SystemC1Ev+0x220>
            ConsoleUtil::printString("ALL OK\n");
    80001b98:	00007517          	auipc	a0,0x7
    80001b9c:	4a050513          	addi	a0,a0,1184 # 80009038 <CONSOLE_STATUS+0x28>
    80001ba0:	00002097          	auipc	ra,0x2
    80001ba4:	5b4080e7          	jalr	1460(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        Buddy::alloc(11);
    80001ba8:	00b00513          	li	a0,11
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	c44080e7          	jalr	-956(ra) # 800017f0 <_ZN5Buddy5allocEm>
        Buddy::alloc(11);
    80001bb4:	00b00513          	li	a0,11
    80001bb8:	00000097          	auipc	ra,0x0
    80001bbc:	c38080e7          	jalr	-968(ra) # 800017f0 <_ZN5Buddy5allocEm>
        void *check = Buddy::alloc(0);
    80001bc0:	00000513          	li	a0,0
    80001bc4:	00000097          	auipc	ra,0x0
    80001bc8:	c2c080e7          	jalr	-980(ra) # 800017f0 <_ZN5Buddy5allocEm>
        if(check != nullptr)
    80001bcc:	06050a63          	beqz	a0,80001c40 <_ZN6SystemC1Ev+0x234>
            ConsoleUtil::printString("ERROR\n");
    80001bd0:	00007517          	auipc	a0,0x7
    80001bd4:	46050513          	addi	a0,a0,1120 # 80009030 <CONSOLE_STATUS+0x20>
    80001bd8:	00002097          	auipc	ra,0x2
    80001bdc:	57c080e7          	jalr	1404(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80001be0:	00000613          	li	a2,0
    80001be4:	00000597          	auipc	a1,0x0
    80001be8:	e0058593          	addi	a1,a1,-512 # 800019e4 <_ZN6System15userMainWrapperEPv>
    80001bec:	ffffc537          	lui	a0,0xffffc
    80001bf0:	ff850513          	addi	a0,a0,-8 # ffffffffffffbff8 <end+0xffffffff7ffeb2a8>
    80001bf4:	fe040793          	addi	a5,s0,-32
    80001bf8:	00a78533          	add	a0,a5,a0
    80001bfc:	fffff097          	auipc	ra,0xfffff
    80001c00:	5b4080e7          	jalr	1460(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001c04:	ffffc7b7          	lui	a5,0xffffc
    80001c08:	fe040713          	addi	a4,s0,-32
    80001c0c:	00f707b3          	add	a5,a4,a5
    80001c10:	ff87b783          	ld	a5,-8(a5) # ffffffffffffbff8 <end+0xffffffff7ffeb2a8>
    80001c14:	0107a703          	lw	a4,16(a5)
    80001c18:	00200793          	li	a5,2
    80001c1c:	02f70c63          	beq	a4,a5,80001c54 <_ZN6SystemC1Ev+0x248>
            thread_dispatch();
    80001c20:	fffff097          	auipc	ra,0xfffff
    80001c24:	634080e7          	jalr	1588(ra) # 80001254 <_Z15thread_dispatchv>
    80001c28:	fddff06f          	j	80001c04 <_ZN6SystemC1Ev+0x1f8>
            ConsoleUtil::printString("ERROR\n");
    80001c2c:	00007517          	auipc	a0,0x7
    80001c30:	40450513          	addi	a0,a0,1028 # 80009030 <CONSOLE_STATUS+0x20>
    80001c34:	00002097          	auipc	ra,0x2
    80001c38:	520080e7          	jalr	1312(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    80001c3c:	f6dff06f          	j	80001ba8 <_ZN6SystemC1Ev+0x19c>
            ConsoleUtil::printString("ALL OK\n");
    80001c40:	00007517          	auipc	a0,0x7
    80001c44:	3f850513          	addi	a0,a0,1016 # 80009038 <CONSOLE_STATUS+0x28>
    80001c48:	00002097          	auipc	ra,0x2
    80001c4c:	50c080e7          	jalr	1292(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    80001c50:	f91ff06f          	j	80001be0 <_ZN6SystemC1Ev+0x1d4>
        RiscV::finalize();
    80001c54:	00001097          	auipc	ra,0x1
    80001c58:	348080e7          	jalr	840(ra) # 80002f9c <_ZN5RiscV8finalizeEv>
}
    80001c5c:	dddff06f          	j	80001a38 <_ZN6SystemC1Ev+0x2c>

0000000080001c60 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001c60:	fe010113          	addi	sp,sp,-32
    80001c64:	00113c23          	sd	ra,24(sp)
    80001c68:	00813823          	sd	s0,16(sp)
    80001c6c:	00913423          	sd	s1,8(sp)
    80001c70:	02010413          	addi	s0,sp,32
    80001c74:	00050493          	mv	s1,a0
    LOCK();
    80001c78:	00100613          	li	a2,1
    80001c7c:	00000593          	li	a1,0
    80001c80:	0000a517          	auipc	a0,0xa
    80001c84:	d8850513          	addi	a0,a0,-632 # 8000ba08 <lockPrint>
    80001c88:	fffff097          	auipc	ra,0xfffff
    80001c8c:	378080e7          	jalr	888(ra) # 80001000 <copy_and_swap>
    80001c90:	fe0514e3          	bnez	a0,80001c78 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001c94:	0004c503          	lbu	a0,0(s1)
    80001c98:	00050a63          	beqz	a0,80001cac <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	790080e7          	jalr	1936(ra) # 8000142c <_Z4putcc>
        string++;
    80001ca4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001ca8:	fedff06f          	j	80001c94 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80001cac:	00000613          	li	a2,0
    80001cb0:	00100593          	li	a1,1
    80001cb4:	0000a517          	auipc	a0,0xa
    80001cb8:	d5450513          	addi	a0,a0,-684 # 8000ba08 <lockPrint>
    80001cbc:	fffff097          	auipc	ra,0xfffff
    80001cc0:	344080e7          	jalr	836(ra) # 80001000 <copy_and_swap>
    80001cc4:	fe0514e3          	bnez	a0,80001cac <_Z11printStringPKc+0x4c>
}
    80001cc8:	01813083          	ld	ra,24(sp)
    80001ccc:	01013403          	ld	s0,16(sp)
    80001cd0:	00813483          	ld	s1,8(sp)
    80001cd4:	02010113          	addi	sp,sp,32
    80001cd8:	00008067          	ret

0000000080001cdc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001cdc:	fd010113          	addi	sp,sp,-48
    80001ce0:	02113423          	sd	ra,40(sp)
    80001ce4:	02813023          	sd	s0,32(sp)
    80001ce8:	00913c23          	sd	s1,24(sp)
    80001cec:	01213823          	sd	s2,16(sp)
    80001cf0:	01313423          	sd	s3,8(sp)
    80001cf4:	01413023          	sd	s4,0(sp)
    80001cf8:	03010413          	addi	s0,sp,48
    80001cfc:	00050993          	mv	s3,a0
    80001d00:	00058a13          	mv	s4,a1
    LOCK();
    80001d04:	00100613          	li	a2,1
    80001d08:	00000593          	li	a1,0
    80001d0c:	0000a517          	auipc	a0,0xa
    80001d10:	cfc50513          	addi	a0,a0,-772 # 8000ba08 <lockPrint>
    80001d14:	fffff097          	auipc	ra,0xfffff
    80001d18:	2ec080e7          	jalr	748(ra) # 80001000 <copy_and_swap>
    80001d1c:	fe0514e3          	bnez	a0,80001d04 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001d20:	00000913          	li	s2,0
    80001d24:	00090493          	mv	s1,s2
    80001d28:	0019091b          	addiw	s2,s2,1
    80001d2c:	03495a63          	bge	s2,s4,80001d60 <_Z9getStringPci+0x84>
        cc = getc();
    80001d30:	fffff097          	auipc	ra,0xfffff
    80001d34:	6d4080e7          	jalr	1748(ra) # 80001404 <_Z4getcv>
        if(cc < 1)
    80001d38:	02050463          	beqz	a0,80001d60 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80001d3c:	009984b3          	add	s1,s3,s1
    80001d40:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001d44:	00a00793          	li	a5,10
    80001d48:	00f50a63          	beq	a0,a5,80001d5c <_Z9getStringPci+0x80>
    80001d4c:	00d00793          	li	a5,13
    80001d50:	fcf51ae3          	bne	a0,a5,80001d24 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80001d54:	00090493          	mv	s1,s2
    80001d58:	0080006f          	j	80001d60 <_Z9getStringPci+0x84>
    80001d5c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001d60:	009984b3          	add	s1,s3,s1
    80001d64:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80001d68:	00000613          	li	a2,0
    80001d6c:	00100593          	li	a1,1
    80001d70:	0000a517          	auipc	a0,0xa
    80001d74:	c9850513          	addi	a0,a0,-872 # 8000ba08 <lockPrint>
    80001d78:	fffff097          	auipc	ra,0xfffff
    80001d7c:	288080e7          	jalr	648(ra) # 80001000 <copy_and_swap>
    80001d80:	fe0514e3          	bnez	a0,80001d68 <_Z9getStringPci+0x8c>
    return buf;
}
    80001d84:	00098513          	mv	a0,s3
    80001d88:	02813083          	ld	ra,40(sp)
    80001d8c:	02013403          	ld	s0,32(sp)
    80001d90:	01813483          	ld	s1,24(sp)
    80001d94:	01013903          	ld	s2,16(sp)
    80001d98:	00813983          	ld	s3,8(sp)
    80001d9c:	00013a03          	ld	s4,0(sp)
    80001da0:	03010113          	addi	sp,sp,48
    80001da4:	00008067          	ret

0000000080001da8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80001da8:	ff010113          	addi	sp,sp,-16
    80001dac:	00813423          	sd	s0,8(sp)
    80001db0:	01010413          	addi	s0,sp,16
    80001db4:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80001db8:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80001dbc:	0006c603          	lbu	a2,0(a3) # 1000 <_entry-0x7ffff000>
    80001dc0:	fd06071b          	addiw	a4,a2,-48
    80001dc4:	0ff77713          	andi	a4,a4,255
    80001dc8:	00900793          	li	a5,9
    80001dcc:	02e7e063          	bltu	a5,a4,80001dec <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80001dd0:	0025179b          	slliw	a5,a0,0x2
    80001dd4:	00a787bb          	addw	a5,a5,a0
    80001dd8:	0017979b          	slliw	a5,a5,0x1
    80001ddc:	00168693          	addi	a3,a3,1
    80001de0:	00c787bb          	addw	a5,a5,a2
    80001de4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80001de8:	fd5ff06f          	j	80001dbc <_Z11stringToIntPKc+0x14>
    return n;
}
    80001dec:	00813403          	ld	s0,8(sp)
    80001df0:	01010113          	addi	sp,sp,16
    80001df4:	00008067          	ret

0000000080001df8 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80001df8:	fc010113          	addi	sp,sp,-64
    80001dfc:	02113c23          	sd	ra,56(sp)
    80001e00:	02813823          	sd	s0,48(sp)
    80001e04:	02913423          	sd	s1,40(sp)
    80001e08:	03213023          	sd	s2,32(sp)
    80001e0c:	01313c23          	sd	s3,24(sp)
    80001e10:	04010413          	addi	s0,sp,64
    80001e14:	00050493          	mv	s1,a0
    80001e18:	00058913          	mv	s2,a1
    80001e1c:	00060993          	mv	s3,a2
    LOCK();
    80001e20:	00100613          	li	a2,1
    80001e24:	00000593          	li	a1,0
    80001e28:	0000a517          	auipc	a0,0xa
    80001e2c:	be050513          	addi	a0,a0,-1056 # 8000ba08 <lockPrint>
    80001e30:	fffff097          	auipc	ra,0xfffff
    80001e34:	1d0080e7          	jalr	464(ra) # 80001000 <copy_and_swap>
    80001e38:	fe0514e3          	bnez	a0,80001e20 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001e3c:	00098463          	beqz	s3,80001e44 <_Z8printIntiii+0x4c>
    80001e40:	0804c463          	bltz	s1,80001ec8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001e44:	0004851b          	sext.w	a0,s1
    neg = 0;
    80001e48:	00000593          	li	a1,0
    }

    i = 0;
    80001e4c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001e50:	0009079b          	sext.w	a5,s2
    80001e54:	0325773b          	remuw	a4,a0,s2
    80001e58:	00048613          	mv	a2,s1
    80001e5c:	0014849b          	addiw	s1,s1,1
    80001e60:	02071693          	slli	a3,a4,0x20
    80001e64:	0206d693          	srli	a3,a3,0x20
    80001e68:	0000a717          	auipc	a4,0xa
    80001e6c:	83070713          	addi	a4,a4,-2000 # 8000b698 <digits>
    80001e70:	00d70733          	add	a4,a4,a3
    80001e74:	00074683          	lbu	a3,0(a4)
    80001e78:	fd040713          	addi	a4,s0,-48
    80001e7c:	00c70733          	add	a4,a4,a2
    80001e80:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001e84:	0005071b          	sext.w	a4,a0
    80001e88:	0325553b          	divuw	a0,a0,s2
    80001e8c:	fcf772e3          	bgeu	a4,a5,80001e50 <_Z8printIntiii+0x58>
    if(neg)
    80001e90:	00058c63          	beqz	a1,80001ea8 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80001e94:	fd040793          	addi	a5,s0,-48
    80001e98:	009784b3          	add	s1,a5,s1
    80001e9c:	02d00793          	li	a5,45
    80001ea0:	fef48823          	sb	a5,-16(s1)
    80001ea4:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001ea8:	fff4849b          	addiw	s1,s1,-1
    80001eac:	0204c463          	bltz	s1,80001ed4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80001eb0:	fd040793          	addi	a5,s0,-48
    80001eb4:	009787b3          	add	a5,a5,s1
    80001eb8:	ff07c503          	lbu	a0,-16(a5)
    80001ebc:	fffff097          	auipc	ra,0xfffff
    80001ec0:	570080e7          	jalr	1392(ra) # 8000142c <_Z4putcc>
    80001ec4:	fe5ff06f          	j	80001ea8 <_Z8printIntiii+0xb0>
        x = -xx;
    80001ec8:	4090053b          	negw	a0,s1
        neg = 1;
    80001ecc:	00100593          	li	a1,1
        x = -xx;
    80001ed0:	f7dff06f          	j	80001e4c <_Z8printIntiii+0x54>

    UNLOCK();
    80001ed4:	00000613          	li	a2,0
    80001ed8:	00100593          	li	a1,1
    80001edc:	0000a517          	auipc	a0,0xa
    80001ee0:	b2c50513          	addi	a0,a0,-1236 # 8000ba08 <lockPrint>
    80001ee4:	fffff097          	auipc	ra,0xfffff
    80001ee8:	11c080e7          	jalr	284(ra) # 80001000 <copy_and_swap>
    80001eec:	fe0514e3          	bnez	a0,80001ed4 <_Z8printIntiii+0xdc>
    80001ef0:	03813083          	ld	ra,56(sp)
    80001ef4:	03013403          	ld	s0,48(sp)
    80001ef8:	02813483          	ld	s1,40(sp)
    80001efc:	02013903          	ld	s2,32(sp)
    80001f00:	01813983          	ld	s3,24(sp)
    80001f04:	04010113          	addi	sp,sp,64
    80001f08:	00008067          	ret

0000000080001f0c <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80001f0c:	ff010113          	addi	sp,sp,-16
    80001f10:	00813423          	sd	s0,8(sp)
    80001f14:	01010413          	addi	s0,sp,16
    val = init;
    80001f18:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80001f1c:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    80001f20:	00053823          	sd	zero,16(a0)
}
    80001f24:	00813403          	ld	s0,8(sp)
    80001f28:	01010113          	addi	sp,sp,16
    80001f2c:	00008067          	ret

0000000080001f30 <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    80001f30:	fe010113          	addi	sp,sp,-32
    80001f34:	00113c23          	sd	ra,24(sp)
    80001f38:	00813823          	sd	s0,16(sp)
    80001f3c:	00913423          	sd	s1,8(sp)
    80001f40:	01213023          	sd	s2,0(sp)
    80001f44:	02010413          	addi	s0,sp,32
    80001f48:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80001f4c:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80001f50:	02050063          	beqz	a0,80001f70 <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    80001f54:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80001f58:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80001f5c:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80001f60:	00002097          	auipc	ra,0x2
    80001f64:	d70080e7          	jalr	-656(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80001f68:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80001f6c:	fe5ff06f          	j	80001f50 <_ZN3SCBD1Ev+0x20>
    }
}
    80001f70:	01813083          	ld	ra,24(sp)
    80001f74:	01013403          	ld	s0,16(sp)
    80001f78:	00813483          	ld	s1,8(sp)
    80001f7c:	00013903          	ld	s2,0(sp)
    80001f80:	02010113          	addi	sp,sp,32
    80001f84:	00008067          	ret

0000000080001f88 <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    80001f88:	ff010113          	addi	sp,sp,-16
    80001f8c:	00113423          	sd	ra,8(sp)
    80001f90:	00813023          	sd	s0,0(sp)
    80001f94:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001f98:	00853783          	ld	a5,8(a0)
    80001f9c:	04078063          	beqz	a5,80001fdc <_ZN3SCB5blockEv+0x54>
    80001fa0:	01053703          	ld	a4,16(a0)
    80001fa4:	0000a797          	auipc	a5,0xa
    80001fa8:	9047b783          	ld	a5,-1788(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001fac:	0007b783          	ld	a5,0(a5)
    80001fb0:	04f73423          	sd	a5,72(a4)
    80001fb4:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80001fb8:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80001fbc:	00300713          	li	a4,3
    80001fc0:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80001fc4:	00000097          	auipc	ra,0x0
    80001fc8:	2c0080e7          	jalr	704(ra) # 80002284 <_ZN3TCB8dispatchEv>
}
    80001fcc:	00813083          	ld	ra,8(sp)
    80001fd0:	00013403          	ld	s0,0(sp)
    80001fd4:	01010113          	addi	sp,sp,16
    80001fd8:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001fdc:	0000a797          	auipc	a5,0xa
    80001fe0:	8cc7b783          	ld	a5,-1844(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001fe4:	0007b783          	ld	a5,0(a5)
    80001fe8:	00f53423          	sd	a5,8(a0)
    80001fec:	fc9ff06f          	j	80001fb4 <_ZN3SCB5blockEv+0x2c>

0000000080001ff0 <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80001ff0:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80001ff4:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80001ff8:	04853703          	ld	a4,72(a0)
    80001ffc:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002000:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002004:	02050a63          	beqz	a0,80002038 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002008:	ff010113          	addi	sp,sp,-16
    8000200c:	00113423          	sd	ra,8(sp)
    80002010:	00813023          	sd	s0,0(sp)
    80002014:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002018:	00100793          	li	a5,1
    8000201c:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002020:	00002097          	auipc	ra,0x2
    80002024:	cb0080e7          	jalr	-848(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
    }
}
    80002028:	00813083          	ld	ra,8(sp)
    8000202c:	00013403          	ld	s0,0(sp)
    80002030:	01010113          	addi	sp,sp,16
    80002034:	00008067          	ret
    80002038:	00008067          	ret

000000008000203c <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    8000203c:	0000a797          	auipc	a5,0xa
    80002040:	86c7b783          	ld	a5,-1940(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002044:	0007b783          	ld	a5,0(a5)
    80002048:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    8000204c:	00052783          	lw	a5,0(a0)
    80002050:	fff7879b          	addiw	a5,a5,-1
    80002054:	00f52023          	sw	a5,0(a0)
    80002058:	02079713          	slli	a4,a5,0x20
    8000205c:	00074463          	bltz	a4,80002064 <_ZN3SCB4waitEv+0x28>
    80002060:	00008067          	ret
void SCB::wait() {
    80002064:	ff010113          	addi	sp,sp,-16
    80002068:	00113423          	sd	ra,8(sp)
    8000206c:	00813023          	sd	s0,0(sp)
    80002070:	01010413          	addi	s0,sp,16
        block();
    80002074:	00000097          	auipc	ra,0x0
    80002078:	f14080e7          	jalr	-236(ra) # 80001f88 <_ZN3SCB5blockEv>
}
    8000207c:	00813083          	ld	ra,8(sp)
    80002080:	00013403          	ld	s0,0(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    8000208c:	00052783          	lw	a5,0(a0)
    80002090:	0017871b          	addiw	a4,a5,1
    80002094:	00e52023          	sw	a4,0(a0)
    80002098:	0007c463          	bltz	a5,800020a0 <_ZN3SCB6signalEv+0x14>
    8000209c:	00008067          	ret
void SCB::signal(){
    800020a0:	ff010113          	addi	sp,sp,-16
    800020a4:	00113423          	sd	ra,8(sp)
    800020a8:	00813023          	sd	s0,0(sp)
    800020ac:	01010413          	addi	s0,sp,16
        deblock();
    800020b0:	00000097          	auipc	ra,0x0
    800020b4:	f40080e7          	jalr	-192(ra) # 80001ff0 <_ZN3SCB7deblockEv>
}
    800020b8:	00813083          	ld	ra,8(sp)
    800020bc:	00013403          	ld	s0,0(sp)
    800020c0:	01010113          	addi	sp,sp,16
    800020c4:	00008067          	ret

00000000800020c8 <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    800020c8:	ff010113          	addi	sp,sp,-16
    800020cc:	00113423          	sd	ra,8(sp)
    800020d0:	00813023          	sd	s0,0(sp)
    800020d4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	3f4080e7          	jalr	1012(ra) # 800024cc <_ZN15MemoryAllocator7kmallocEm>
}
    800020e0:	00813083          	ld	ra,8(sp)
    800020e4:	00013403          	ld	s0,0(sp)
    800020e8:	01010113          	addi	sp,sp,16
    800020ec:	00008067          	ret

00000000800020f0 <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    800020f0:	ff010113          	addi	sp,sp,-16
    800020f4:	00113423          	sd	ra,8(sp)
    800020f8:	00813023          	sd	s0,0(sp)
    800020fc:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002100:	00000097          	auipc	ra,0x0
    80002104:	5f4080e7          	jalr	1524(ra) # 800026f4 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002108:	00813083          	ld	ra,8(sp)
    8000210c:	00013403          	ld	s0,0(sp)
    80002110:	01010113          	addi	sp,sp,16
    80002114:	00008067          	ret

0000000080002118 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002118:	ff010113          	addi	sp,sp,-16
    8000211c:	00813423          	sd	s0,8(sp)
    80002120:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002124:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002128:	05200513          	li	a0,82
    asm("ecall");
    8000212c:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80002130:	00050513          	mv	a0,a0
    return status;
}
    80002134:	0005051b          	sext.w	a0,a0
    80002138:	00813403          	ld	s0,8(sp)
    8000213c:	01010113          	addi	sp,sp,16
    80002140:	00008067          	ret

0000000080002144 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002144:	fe010113          	addi	sp,sp,-32
    80002148:	00113c23          	sd	ra,24(sp)
    8000214c:	00813823          	sd	s0,16(sp)
    80002150:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002154:	fe840513          	addi	a0,s0,-24
    80002158:	00000097          	auipc	ra,0x0
    8000215c:	8b4080e7          	jalr	-1868(ra) # 80001a0c <_ZN6SystemC1Ev>

    return 0;
    80002160:	00000513          	li	a0,0
    80002164:	01813083          	ld	ra,24(sp)
    80002168:	01013403          	ld	s0,16(sp)
    8000216c:	02010113          	addi	sp,sp,32
    80002170:	00008067          	ret

0000000080002174 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002174:	ff010113          	addi	sp,sp,-16
    80002178:	00113423          	sd	ra,8(sp)
    8000217c:	00813023          	sd	s0,0(sp)
    80002180:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002184:	00001097          	auipc	ra,0x1
    80002188:	ca0080e7          	jalr	-864(ra) # 80002e24 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    8000218c:	0000a797          	auipc	a5,0xa
    80002190:	8847b783          	ld	a5,-1916(a5) # 8000ba10 <_ZN3TCB7runningE>
    80002194:	0187b703          	ld	a4,24(a5)
    80002198:	0207b503          	ld	a0,32(a5)
    8000219c:	000700e7          	jalr	a4

    thread_exit();
    800021a0:	fffff097          	auipc	ra,0xfffff
    800021a4:	08c080e7          	jalr	140(ra) # 8000122c <_Z11thread_exitv>
}
    800021a8:	00813083          	ld	ra,8(sp)
    800021ac:	00013403          	ld	s0,0(sp)
    800021b0:	01010113          	addi	sp,sp,16
    800021b4:	00008067          	ret

00000000800021b8 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    800021b8:	ff010113          	addi	sp,sp,-16
    800021bc:	00813423          	sd	s0,8(sp)
    800021c0:	01010413          	addi	s0,sp,16
    800021c4:	04053823          	sd	zero,80(a0)
    800021c8:	04053c23          	sd	zero,88(a0)
    800021cc:	06053023          	sd	zero,96(a0)
    this->body = body;
    800021d0:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    800021d4:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    800021d8:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    800021dc:	04058263          	beqz	a1,80002220 <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    800021e0:	00068793          	mv	a5,a3
    800021e4:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    800021e8:	00100793          	li	a5,1
    800021ec:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    800021f0:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    800021f4:	02058a63          	beqz	a1,80002228 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    800021f8:	000017b7          	lui	a5,0x1
    800021fc:	00f686b3          	add	a3,a3,a5
    80002200:	00d53023          	sd	a3,0(a0)
    80002204:	00000797          	auipc	a5,0x0
    80002208:	f7078793          	addi	a5,a5,-144 # 80002174 <_ZN3TCB7wrapperEPv>
    8000220c:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002210:	00052a23          	sw	zero,20(a0)
}
    80002214:	00813403          	ld	s0,8(sp)
    80002218:	01010113          	addi	sp,sp,16
    8000221c:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002220:	00000793          	li	a5,0
    80002224:	fc1ff06f          	j	800021e4 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002228:	00000693          	li	a3,0
    8000222c:	fd5ff06f          	j	80002200 <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

0000000080002230 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002230:	ff010113          	addi	sp,sp,-16
    80002234:	00113423          	sd	ra,8(sp)
    80002238:	00813023          	sd	s0,0(sp)
    8000223c:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    80002240:	02853503          	ld	a0,40(a0)
    80002244:	00000097          	auipc	ra,0x0
    80002248:	4b0080e7          	jalr	1200(ra) # 800026f4 <_ZN15MemoryAllocator5kfreeEPv>
}
    8000224c:	00813083          	ld	ra,8(sp)
    80002250:	00013403          	ld	s0,0(sp)
    80002254:	01010113          	addi	sp,sp,16
    80002258:	00008067          	ret

000000008000225c <_ZN3TCBD1Ev>:
TCB::~TCB(){
    8000225c:	ff010113          	addi	sp,sp,-16
    80002260:	00113423          	sd	ra,8(sp)
    80002264:	00813023          	sd	s0,0(sp)
    80002268:	01010413          	addi	s0,sp,16
    free();
    8000226c:	00000097          	auipc	ra,0x0
    80002270:	fc4080e7          	jalr	-60(ra) # 80002230 <_ZN3TCB4freeEv>
}
    80002274:	00813083          	ld	ra,8(sp)
    80002278:	00013403          	ld	s0,0(sp)
    8000227c:	01010113          	addi	sp,sp,16
    80002280:	00008067          	ret

0000000080002284 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002284:	fe010113          	addi	sp,sp,-32
    80002288:	00113c23          	sd	ra,24(sp)
    8000228c:	00813823          	sd	s0,16(sp)
    80002290:	00913423          	sd	s1,8(sp)
    80002294:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002298:	00009497          	auipc	s1,0x9
    8000229c:	7784b483          	ld	s1,1912(s1) # 8000ba10 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800022a0:	0104a703          	lw	a4,16(s1)
    800022a4:	00100793          	li	a5,1
    800022a8:	04e7f663          	bgeu	a5,a4,800022f4 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800022ac:	00002097          	auipc	ra,0x2
    800022b0:	a6c080e7          	jalr	-1428(ra) # 80003d18 <_ZN9Scheduler3getEv>
    800022b4:	00009797          	auipc	a5,0x9
    800022b8:	74a7be23          	sd	a0,1884(a5) # 8000ba10 <_ZN3TCB7runningE>
    if(running) {
    800022bc:	02050263          	beqz	a0,800022e0 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800022c0:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800022c4:	00001097          	auipc	ra,0x1
    800022c8:	c94080e7          	jalr	-876(ra) # 80002f58 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    800022cc:	00009597          	auipc	a1,0x9
    800022d0:	7445b583          	ld	a1,1860(a1) # 8000ba10 <_ZN3TCB7runningE>
    800022d4:	00048513          	mv	a0,s1
    800022d8:	fffff097          	auipc	ra,0xfffff
    800022dc:	e68080e7          	jalr	-408(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    800022e0:	01813083          	ld	ra,24(sp)
    800022e4:	01013403          	ld	s0,16(sp)
    800022e8:	00813483          	ld	s1,8(sp)
    800022ec:	02010113          	addi	sp,sp,32
    800022f0:	00008067          	ret
        Scheduler::put(old);
    800022f4:	00048513          	mv	a0,s1
    800022f8:	00002097          	auipc	ra,0x2
    800022fc:	9d8080e7          	jalr	-1576(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
    80002300:	fadff06f          	j	800022ac <_ZN3TCB8dispatchEv+0x28>

0000000080002304 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002304:	ff010113          	addi	sp,sp,-16
    80002308:	00113423          	sd	ra,8(sp)
    8000230c:	00813023          	sd	s0,0(sp)
    80002310:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002314:	00000097          	auipc	ra,0x0
    80002318:	1b8080e7          	jalr	440(ra) # 800024cc <_ZN15MemoryAllocator7kmallocEm>
}
    8000231c:	00813083          	ld	ra,8(sp)
    80002320:	00013403          	ld	s0,0(sp)
    80002324:	01010113          	addi	sp,sp,16
    80002328:	00008067          	ret

000000008000232c <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    8000232c:	fd010113          	addi	sp,sp,-48
    80002330:	02113423          	sd	ra,40(sp)
    80002334:	02813023          	sd	s0,32(sp)
    80002338:	00913c23          	sd	s1,24(sp)
    8000233c:	01213823          	sd	s2,16(sp)
    80002340:	01313423          	sd	s3,8(sp)
    80002344:	01413023          	sd	s4,0(sp)
    80002348:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    8000234c:	07000513          	li	a0,112
    80002350:	00000097          	auipc	ra,0x0
    80002354:	fb4080e7          	jalr	-76(ra) # 80002304 <_ZN3TCBnwEm>
    80002358:	00050493          	mv	s1,a0
    8000235c:	00200713          	li	a4,2
    80002360:	00000693          	li	a3,0
    80002364:	00000613          	li	a2,0
    80002368:	00000593          	li	a1,0
    8000236c:	00000097          	auipc	ra,0x0
    80002370:	e4c080e7          	jalr	-436(ra) # 800021b8 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002374:	00009a17          	auipc	s4,0x9
    80002378:	69ca0a13          	addi	s4,s4,1692 # 8000ba10 <_ZN3TCB7runningE>
    8000237c:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    80002380:	00100993          	li	s3,1
    80002384:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002388:	04000513          	li	a0,64
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	140080e7          	jalr	320(ra) # 800024cc <_ZN15MemoryAllocator7kmallocEm>
    80002394:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002398:	07000513          	li	a0,112
    8000239c:	00000097          	auipc	ra,0x0
    800023a0:	f68080e7          	jalr	-152(ra) # 80002304 <_ZN3TCBnwEm>
    800023a4:	00050493          	mv	s1,a0
    800023a8:	00200713          	li	a4,2
    800023ac:	00090693          	mv	a3,s2
    800023b0:	00000613          	li	a2,0
    800023b4:	00009597          	auipc	a1,0x9
    800023b8:	4945b583          	ld	a1,1172(a1) # 8000b848 <_GLOBAL_OFFSET_TABLE_+0x28>
    800023bc:	00000097          	auipc	ra,0x0
    800023c0:	dfc080e7          	jalr	-516(ra) # 800021b8 <_ZN3TCBC1EPFvPvES0_Pmm>
    800023c4:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    800023c8:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    800023cc:	00048513          	mv	a0,s1
    800023d0:	00002097          	auipc	ra,0x2
    800023d4:	900080e7          	jalr	-1792(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
}
    800023d8:	02813083          	ld	ra,40(sp)
    800023dc:	02013403          	ld	s0,32(sp)
    800023e0:	01813483          	ld	s1,24(sp)
    800023e4:	01013903          	ld	s2,16(sp)
    800023e8:	00813983          	ld	s3,8(sp)
    800023ec:	00013a03          	ld	s4,0(sp)
    800023f0:	03010113          	addi	sp,sp,48
    800023f4:	00008067          	ret

00000000800023f8 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    800023f8:	ff010113          	addi	sp,sp,-16
    800023fc:	00113423          	sd	ra,8(sp)
    80002400:	00813023          	sd	s0,0(sp)
    80002404:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002408:	00000097          	auipc	ra,0x0
    8000240c:	2ec080e7          	jalr	748(ra) # 800026f4 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002410:	00813083          	ld	ra,8(sp)
    80002414:	00013403          	ld	s0,0(sp)
    80002418:	01010113          	addi	sp,sp,16
    8000241c:	00008067          	ret

0000000080002420 <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80002420:	ff010113          	addi	sp,sp,-16
    80002424:	00813423          	sd	s0,8(sp)
    80002428:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    8000242c:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002430:	05100513          	li	a0,81
    asm("ecall");
    80002434:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002438:	00050513          	mv	a0,a0
    return status;
    8000243c:	0005051b          	sext.w	a0,a0
    80002440:	00813403          	ld	s0,8(sp)
    80002444:	01010113          	addi	sp,sp,16
    80002448:	00008067          	ret

000000008000244c <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    8000244c:	ff010113          	addi	sp,sp,-16
    80002450:	00813423          	sd	s0,8(sp)
    80002454:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002458:	00009797          	auipc	a5,0x9
    8000245c:	3e07b783          	ld	a5,992(a5) # 8000b838 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002460:	0007b603          	ld	a2,0(a5)
    80002464:	00c65793          	srli	a5,a2,0xc
    80002468:	00278793          	addi	a5,a5,2
    8000246c:	00c79793          	slli	a5,a5,0xc
    80002470:	01000737          	lui	a4,0x1000
    80002474:	00e787b3          	add	a5,a5,a4
    80002478:	00009717          	auipc	a4,0x9
    8000247c:	5c070713          	addi	a4,a4,1472 # 8000ba38 <_ZN15MemoryAllocator11freeMemTailE>
    80002480:	00f73023          	sd	a5,0(a4)
    80002484:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002488:	0007b823          	sd	zero,16(a5)
    8000248c:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002490:	00073823          	sd	zero,16(a4)
    80002494:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    80002498:	00009697          	auipc	a3,0x9
    8000249c:	4206b683          	ld	a3,1056(a3) # 8000b8b8 <_GLOBAL_OFFSET_TABLE_+0x98>
    800024a0:	0006b683          	ld	a3,0(a3)
    800024a4:	40c686b3          	sub	a3,a3,a2
    800024a8:	fe868693          	addi	a3,a3,-24
    800024ac:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800024b0:	00873783          	ld	a5,8(a4)
    800024b4:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800024b8:	00100793          	li	a5,1
    800024bc:	02f70023          	sb	a5,32(a4)
}
    800024c0:	00813403          	ld	s0,8(sp)
    800024c4:	01010113          	addi	sp,sp,16
    800024c8:	00008067          	ret

00000000800024cc <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800024cc:	ff010113          	addi	sp,sp,-16
    800024d0:	00813423          	sd	s0,8(sp)
    800024d4:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    800024d8:	14050263          	beqz	a0,8000261c <_ZN15MemoryAllocator7kmallocEm+0x150>
    800024dc:	00050793          	mv	a5,a0
    800024e0:	00009517          	auipc	a0,0x9
    800024e4:	56053503          	ld	a0,1376(a0) # 8000ba40 <_ZN15MemoryAllocator11freeMemHeadE>
    800024e8:	0a050a63          	beqz	a0,8000259c <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800024ec:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    800024f0:	00000613          	li	a2,0
    800024f4:	00c0006f          	j	80002500 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800024f8:	00050613          	mv	a2,a0
    800024fc:	01053503          	ld	a0,16(a0)
    80002500:	00050863          	beqz	a0,80002510 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002504:	00053683          	ld	a3,0(a0)
    80002508:	01878713          	addi	a4,a5,24
    8000250c:	fee6e6e3          	bltu	a3,a4,800024f8 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002510:	08050663          	beqz	a0,8000259c <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80002514:	00053683          	ld	a3,0(a0)
    80002518:	01868713          	addi	a4,a3,24
    8000251c:	00e50733          	add	a4,a0,a4
    80002520:	00009597          	auipc	a1,0x9
    80002524:	3985b583          	ld	a1,920(a1) # 8000b8b8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002528:	0005b583          	ld	a1,0(a1)
    8000252c:	00b76463          	bltu	a4,a1,80002534 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002530:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002534:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002538:	05700593          	li	a1,87
    8000253c:	08d5f063          	bgeu	a1,a3,800025bc <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80002540:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002544:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002548:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    8000254c:	01053583          	ld	a1,16(a0)
    80002550:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002554:	00853583          	ld	a1,8(a0)
    80002558:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    8000255c:	fe868693          	addi	a3,a3,-24
    80002560:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002564:	04060263          	beqz	a2,800025a8 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    80002568:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    8000256c:	00009797          	auipc	a5,0x9
    80002570:	4e47b783          	ld	a5,1252(a5) # 8000ba50 <_ZN15MemoryAllocator12allocMemHeadE>
    80002574:	06078463          	beqz	a5,800025dc <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002578:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    8000257c:	08070063          	beqz	a4,800025fc <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80002580:	00873783          	ld	a5,8(a4)
    80002584:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002588:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    8000258c:	00873783          	ld	a5,8(a4)
    80002590:	06078063          	beqz	a5,800025f0 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    80002594:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80002598:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    8000259c:	00813403          	ld	s0,8(sp)
    800025a0:	01010113          	addi	sp,sp,16
    800025a4:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800025a8:	00009697          	auipc	a3,0x9
    800025ac:	49068693          	addi	a3,a3,1168 # 8000ba38 <_ZN15MemoryAllocator11freeMemTailE>
    800025b0:	00f6b023          	sd	a5,0(a3)
    800025b4:	00f6b423          	sd	a5,8(a3)
    800025b8:	fb5ff06f          	j	8000256c <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    800025bc:	00060863          	beqz	a2,800025cc <_ZN15MemoryAllocator7kmallocEm+0x100>
    800025c0:	01053783          	ld	a5,16(a0)
    800025c4:	00f63823          	sd	a5,16(a2)
    800025c8:	fa5ff06f          	j	8000256c <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    800025cc:	01053783          	ld	a5,16(a0)
    800025d0:	00009697          	auipc	a3,0x9
    800025d4:	46f6b823          	sd	a5,1136(a3) # 8000ba40 <_ZN15MemoryAllocator11freeMemHeadE>
    800025d8:	f95ff06f          	j	8000256c <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    800025dc:	00009797          	auipc	a5,0x9
    800025e0:	45c78793          	addi	a5,a5,1116 # 8000ba38 <_ZN15MemoryAllocator11freeMemTailE>
    800025e4:	00a7b823          	sd	a0,16(a5)
    800025e8:	00a7bc23          	sd	a0,24(a5)
    800025ec:	fadff06f          	j	80002598 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    800025f0:	00009797          	auipc	a5,0x9
    800025f4:	46a7b023          	sd	a0,1120(a5) # 8000ba50 <_ZN15MemoryAllocator12allocMemHeadE>
    800025f8:	fa1ff06f          	j	80002598 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    800025fc:	00009797          	auipc	a5,0x9
    80002600:	43c78793          	addi	a5,a5,1084 # 8000ba38 <_ZN15MemoryAllocator11freeMemTailE>
    80002604:	0107b703          	ld	a4,16(a5)
    80002608:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    8000260c:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002610:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002614:	00a7b823          	sd	a0,16(a5)
    80002618:	f81ff06f          	j	80002598 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    8000261c:	00000513          	li	a0,0
    80002620:	f7dff06f          	j	8000259c <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080002624 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002624:	ff010113          	addi	sp,sp,-16
    80002628:	00813423          	sd	s0,8(sp)
    8000262c:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002630:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002634:	00000713          	li	a4,0
    80002638:	00078a63          	beqz	a5,8000264c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    8000263c:	00a7f863          	bgeu	a5,a0,8000264c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002640:	00078713          	mv	a4,a5
    80002644:	0107b783          	ld	a5,16(a5)
    80002648:	ff1ff06f          	j	80002638 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    8000264c:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002650:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002654:	00078463          	beqz	a5,8000265c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002658:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    8000265c:	02070263          	beqz	a4,80002680 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002660:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002664:	0005b703          	ld	a4,0(a1)
    80002668:	00009797          	auipc	a5,0x9
    8000266c:	3d87b783          	ld	a5,984(a5) # 8000ba40 <_ZN15MemoryAllocator11freeMemHeadE>
    80002670:	00f70c63          	beq	a4,a5,80002688 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002674:	00813403          	ld	s0,8(sp)
    80002678:	01010113          	addi	sp,sp,16
    8000267c:	00008067          	ret
        *head = blk;
    80002680:	00a5b023          	sd	a0,0(a1)
    80002684:	fe1ff06f          	j	80002664 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002688:	01053783          	ld	a5,16(a0)
    8000268c:	00078a63          	beqz	a5,800026a0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002690:	00053683          	ld	a3,0(a0)
    80002694:	00d50733          	add	a4,a0,a3
    80002698:	01870713          	addi	a4,a4,24
    8000269c:	02f70e63          	beq	a4,a5,800026d8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    800026a0:	00853783          	ld	a5,8(a0)
    800026a4:	fc0788e3          	beqz	a5,80002674 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800026a8:	0007b683          	ld	a3,0(a5)
    800026ac:	00d78733          	add	a4,a5,a3
    800026b0:	01870713          	addi	a4,a4,24
    800026b4:	fca710e3          	bne	a4,a0,80002674 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800026b8:	00053703          	ld	a4,0(a0)
    800026bc:	00e68733          	add	a4,a3,a4
    800026c0:	01870713          	addi	a4,a4,24
    800026c4:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800026c8:	00853783          	ld	a5,8(a0)
    800026cc:	01053703          	ld	a4,16(a0)
    800026d0:	00e7b823          	sd	a4,16(a5)
}
    800026d4:	fa1ff06f          	j	80002674 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800026d8:	0007b703          	ld	a4,0(a5)
    800026dc:	00e68733          	add	a4,a3,a4
    800026e0:	01870713          	addi	a4,a4,24
    800026e4:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800026e8:	0107b783          	ld	a5,16(a5)
    800026ec:	00f53823          	sd	a5,16(a0)
    800026f0:	fb1ff06f          	j	800026a0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800026f4 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800026f4:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800026f8:	00009697          	auipc	a3,0x9
    800026fc:	3586b683          	ld	a3,856(a3) # 8000ba50 <_ZN15MemoryAllocator12allocMemHeadE>
    80002700:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002704:	00050a63          	beqz	a0,80002718 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002708:	fe870793          	addi	a5,a4,-24
    8000270c:	00a78663          	beq	a5,a0,80002718 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002710:	01053503          	ld	a0,16(a0)
    80002714:	ff1ff06f          	j	80002704 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002718:	08050463          	beqz	a0,800027a0 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    8000271c:	ff010113          	addi	sp,sp,-16
    80002720:	00113423          	sd	ra,8(sp)
    80002724:	00813023          	sd	s0,0(sp)
    80002728:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    8000272c:	00009797          	auipc	a5,0x9
    80002730:	31c7b783          	ld	a5,796(a5) # 8000ba48 <_ZN15MemoryAllocator12allocMemTailE>
    80002734:	04a78663          	beq	a5,a0,80002780 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002738:	04d50c63          	beq	a0,a3,80002790 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    8000273c:	01053783          	ld	a5,16(a0)
    80002740:	00078663          	beqz	a5,8000274c <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002744:	00853703          	ld	a4,8(a0)
    80002748:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    8000274c:	00853783          	ld	a5,8(a0)
    80002750:	00078663          	beqz	a5,8000275c <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002754:	01053703          	ld	a4,16(a0)
    80002758:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    8000275c:	00009597          	auipc	a1,0x9
    80002760:	2e458593          	addi	a1,a1,740 # 8000ba40 <_ZN15MemoryAllocator11freeMemHeadE>
    80002764:	00000097          	auipc	ra,0x0
    80002768:	ec0080e7          	jalr	-320(ra) # 80002624 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    8000276c:	00000513          	li	a0,0
}
    80002770:	00813083          	ld	ra,8(sp)
    80002774:	00013403          	ld	s0,0(sp)
    80002778:	01010113          	addi	sp,sp,16
    8000277c:	00008067          	ret
            allocMemTail = blk->prev;
    80002780:	00853783          	ld	a5,8(a0)
    80002784:	00009717          	auipc	a4,0x9
    80002788:	2cf73223          	sd	a5,708(a4) # 8000ba48 <_ZN15MemoryAllocator12allocMemTailE>
    8000278c:	fadff06f          	j	80002738 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002790:	01053783          	ld	a5,16(a0)
    80002794:	00009717          	auipc	a4,0x9
    80002798:	2af73e23          	sd	a5,700(a4) # 8000ba50 <_ZN15MemoryAllocator12allocMemHeadE>
    8000279c:	fa1ff06f          	j	8000273c <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    800027a0:	fff00513          	li	a0,-1
}
    800027a4:	00008067          	ret

00000000800027a8 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800027a8:	fe010113          	addi	sp,sp,-32
    800027ac:	00113c23          	sd	ra,24(sp)
    800027b0:	00813823          	sd	s0,16(sp)
    800027b4:	00913423          	sd	s1,8(sp)
    800027b8:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800027bc:	00009497          	auipc	s1,0x9
    800027c0:	2944b483          	ld	s1,660(s1) # 8000ba50 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800027c4:	00007517          	auipc	a0,0x7
    800027c8:	87c50513          	addi	a0,a0,-1924 # 80009040 <CONSOLE_STATUS+0x30>
    800027cc:	fffff097          	auipc	ra,0xfffff
    800027d0:	494080e7          	jalr	1172(ra) # 80001c60 <_Z11printStringPKc>
    while(iter!=nullptr){
    800027d4:	04048663          	beqz	s1,80002820 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800027d8:	00000613          	li	a2,0
    800027dc:	00a00593          	li	a1,10
    800027e0:	0004851b          	sext.w	a0,s1
    800027e4:	fffff097          	auipc	ra,0xfffff
    800027e8:	614080e7          	jalr	1556(ra) # 80001df8 <_Z8printIntiii>
        putc(' ');
    800027ec:	02000513          	li	a0,32
    800027f0:	fffff097          	auipc	ra,0xfffff
    800027f4:	c3c080e7          	jalr	-964(ra) # 8000142c <_Z4putcc>
        printInt(iter->size);
    800027f8:	00000613          	li	a2,0
    800027fc:	00a00593          	li	a1,10
    80002800:	0004a503          	lw	a0,0(s1)
    80002804:	fffff097          	auipc	ra,0xfffff
    80002808:	5f4080e7          	jalr	1524(ra) # 80001df8 <_Z8printIntiii>
        putc('\n');
    8000280c:	00a00513          	li	a0,10
    80002810:	fffff097          	auipc	ra,0xfffff
    80002814:	c1c080e7          	jalr	-996(ra) # 8000142c <_Z4putcc>
        iter=iter->next;
    80002818:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    8000281c:	fb9ff06f          	j	800027d4 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002820:	00007517          	auipc	a0,0x7
    80002824:	84050513          	addi	a0,a0,-1984 # 80009060 <CONSOLE_STATUS+0x50>
    80002828:	fffff097          	auipc	ra,0xfffff
    8000282c:	438080e7          	jalr	1080(ra) # 80001c60 <_Z11printStringPKc>
    iter = freeMemHead;
    80002830:	00009497          	auipc	s1,0x9
    80002834:	2104b483          	ld	s1,528(s1) # 8000ba40 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002838:	04048663          	beqz	s1,80002884 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    8000283c:	00000613          	li	a2,0
    80002840:	00a00593          	li	a1,10
    80002844:	0004851b          	sext.w	a0,s1
    80002848:	fffff097          	auipc	ra,0xfffff
    8000284c:	5b0080e7          	jalr	1456(ra) # 80001df8 <_Z8printIntiii>
        putc(' ');
    80002850:	02000513          	li	a0,32
    80002854:	fffff097          	auipc	ra,0xfffff
    80002858:	bd8080e7          	jalr	-1064(ra) # 8000142c <_Z4putcc>
        printInt(iter->size);
    8000285c:	00000613          	li	a2,0
    80002860:	00a00593          	li	a1,10
    80002864:	0004a503          	lw	a0,0(s1)
    80002868:	fffff097          	auipc	ra,0xfffff
    8000286c:	590080e7          	jalr	1424(ra) # 80001df8 <_Z8printIntiii>
        putc('\n');
    80002870:	00a00513          	li	a0,10
    80002874:	fffff097          	auipc	ra,0xfffff
    80002878:	bb8080e7          	jalr	-1096(ra) # 8000142c <_Z4putcc>
        iter=iter->next;
    8000287c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002880:	fb9ff06f          	j	80002838 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002884:	00006517          	auipc	a0,0x6
    80002888:	7fc50513          	addi	a0,a0,2044 # 80009080 <CONSOLE_STATUS+0x70>
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	3d4080e7          	jalr	980(ra) # 80001c60 <_Z11printStringPKc>
}
    80002894:	01813083          	ld	ra,24(sp)
    80002898:	01013403          	ld	s0,16(sp)
    8000289c:	00813483          	ld	s1,8(sp)
    800028a0:	02010113          	addi	sp,sp,32
    800028a4:	00008067          	ret

00000000800028a8 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800028a8:	ff010113          	addi	sp,sp,-16
    800028ac:	00813423          	sd	s0,8(sp)
    800028b0:	01010413          	addi	s0,sp,16
    800028b4:	00050813          	mv	a6,a0
    800028b8:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800028bc:	00000793          	li	a5,0
    800028c0:	00c7fe63          	bgeu	a5,a2,800028dc <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800028c4:	00f50733          	add	a4,a0,a5
    800028c8:	00f806b3          	add	a3,a6,a5
    800028cc:	0006c683          	lbu	a3,0(a3)
    800028d0:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800028d4:	00178793          	addi	a5,a5,1
    800028d8:	fe9ff06f          	j	800028c0 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800028dc:	00813403          	ld	s0,8(sp)
    800028e0:	01010113          	addi	sp,sp,16
    800028e4:	00008067          	ret

00000000800028e8 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    800028e8:	ff010113          	addi	sp,sp,-16
    800028ec:	00113423          	sd	ra,8(sp)
    800028f0:	00813023          	sd	s0,0(sp)
    800028f4:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800028f8:	00053783          	ld	a5,0(a0)
    800028fc:	0107b783          	ld	a5,16(a5)
    80002900:	000780e7          	jalr	a5
}
    80002904:	00813083          	ld	ra,8(sp)
    80002908:	00013403          	ld	s0,0(sp)
    8000290c:	01010113          	addi	sp,sp,16
    80002910:	00008067          	ret

0000000080002914 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80002914:	ff010113          	addi	sp,sp,-16
    80002918:	00113423          	sd	ra,8(sp)
    8000291c:	00813023          	sd	s0,0(sp)
    80002920:	01010413          	addi	s0,sp,16
    80002924:	00009797          	auipc	a5,0x9
    80002928:	dd478793          	addi	a5,a5,-556 # 8000b6f8 <_ZTV9Semaphore+0x10>
    8000292c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002930:	00853503          	ld	a0,8(a0)
    80002934:	fffff097          	auipc	ra,0xfffff
    80002938:	a20080e7          	jalr	-1504(ra) # 80001354 <_Z9sem_closeP10_semaphore>
};
    8000293c:	00813083          	ld	ra,8(sp)
    80002940:	00013403          	ld	s0,0(sp)
    80002944:	01010113          	addi	sp,sp,16
    80002948:	00008067          	ret

000000008000294c <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000294c:	00009797          	auipc	a5,0x9
    80002950:	dcc78793          	addi	a5,a5,-564 # 8000b718 <_ZTV6Thread+0x10>
    80002954:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002958:	00853503          	ld	a0,8(a0)
    8000295c:	02050663          	beqz	a0,80002988 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80002960:	ff010113          	addi	sp,sp,-16
    80002964:	00113423          	sd	ra,8(sp)
    80002968:	00813023          	sd	s0,0(sp)
    8000296c:	01010413          	addi	s0,sp,16
    delete myHandle;
    80002970:	fffff097          	auipc	ra,0xfffff
    80002974:	04c080e7          	jalr	76(ra) # 800019bc <_ZN7_threaddlEPv>
}
    80002978:	00813083          	ld	ra,8(sp)
    8000297c:	00013403          	ld	s0,0(sp)
    80002980:	01010113          	addi	sp,sp,16
    80002984:	00008067          	ret
    80002988:	00008067          	ret

000000008000298c <_Znwm>:
void* operator new(size_t sz){
    8000298c:	ff010113          	addi	sp,sp,-16
    80002990:	00113423          	sd	ra,8(sp)
    80002994:	00813023          	sd	s0,0(sp)
    80002998:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000299c:	ffffe097          	auipc	ra,0xffffe
    800029a0:	7b8080e7          	jalr	1976(ra) # 80001154 <_Z9mem_allocm>
}
    800029a4:	00813083          	ld	ra,8(sp)
    800029a8:	00013403          	ld	s0,0(sp)
    800029ac:	01010113          	addi	sp,sp,16
    800029b0:	00008067          	ret

00000000800029b4 <_Znam>:
void* operator new[](size_t sz){
    800029b4:	ff010113          	addi	sp,sp,-16
    800029b8:	00113423          	sd	ra,8(sp)
    800029bc:	00813023          	sd	s0,0(sp)
    800029c0:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800029c4:	ffffe097          	auipc	ra,0xffffe
    800029c8:	790080e7          	jalr	1936(ra) # 80001154 <_Z9mem_allocm>
}
    800029cc:	00813083          	ld	ra,8(sp)
    800029d0:	00013403          	ld	s0,0(sp)
    800029d4:	01010113          	addi	sp,sp,16
    800029d8:	00008067          	ret

00000000800029dc <_ZdlPv>:
void operator delete(void *ptr){
    800029dc:	ff010113          	addi	sp,sp,-16
    800029e0:	00113423          	sd	ra,8(sp)
    800029e4:	00813023          	sd	s0,0(sp)
    800029e8:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800029ec:	ffffe097          	auipc	ra,0xffffe
    800029f0:	798080e7          	jalr	1944(ra) # 80001184 <_Z8mem_freePv>
}
    800029f4:	00813083          	ld	ra,8(sp)
    800029f8:	00013403          	ld	s0,0(sp)
    800029fc:	01010113          	addi	sp,sp,16
    80002a00:	00008067          	ret

0000000080002a04 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80002a04:	fe010113          	addi	sp,sp,-32
    80002a08:	00113c23          	sd	ra,24(sp)
    80002a0c:	00813823          	sd	s0,16(sp)
    80002a10:	00913423          	sd	s1,8(sp)
    80002a14:	02010413          	addi	s0,sp,32
    80002a18:	00050493          	mv	s1,a0
};
    80002a1c:	00000097          	auipc	ra,0x0
    80002a20:	ef8080e7          	jalr	-264(ra) # 80002914 <_ZN9SemaphoreD1Ev>
    80002a24:	00048513          	mv	a0,s1
    80002a28:	00000097          	auipc	ra,0x0
    80002a2c:	fb4080e7          	jalr	-76(ra) # 800029dc <_ZdlPv>
    80002a30:	01813083          	ld	ra,24(sp)
    80002a34:	01013403          	ld	s0,16(sp)
    80002a38:	00813483          	ld	s1,8(sp)
    80002a3c:	02010113          	addi	sp,sp,32
    80002a40:	00008067          	ret

0000000080002a44 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002a44:	fe010113          	addi	sp,sp,-32
    80002a48:	00113c23          	sd	ra,24(sp)
    80002a4c:	00813823          	sd	s0,16(sp)
    80002a50:	00913423          	sd	s1,8(sp)
    80002a54:	02010413          	addi	s0,sp,32
    80002a58:	00050493          	mv	s1,a0
}
    80002a5c:	00000097          	auipc	ra,0x0
    80002a60:	ef0080e7          	jalr	-272(ra) # 8000294c <_ZN6ThreadD1Ev>
    80002a64:	00048513          	mv	a0,s1
    80002a68:	00000097          	auipc	ra,0x0
    80002a6c:	f74080e7          	jalr	-140(ra) # 800029dc <_ZdlPv>
    80002a70:	01813083          	ld	ra,24(sp)
    80002a74:	01013403          	ld	s0,16(sp)
    80002a78:	00813483          	ld	s1,8(sp)
    80002a7c:	02010113          	addi	sp,sp,32
    80002a80:	00008067          	ret

0000000080002a84 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002a84:	ff010113          	addi	sp,sp,-16
    80002a88:	00113423          	sd	ra,8(sp)
    80002a8c:	00813023          	sd	s0,0(sp)
    80002a90:	01010413          	addi	s0,sp,16
    80002a94:	00009797          	auipc	a5,0x9
    80002a98:	c6478793          	addi	a5,a5,-924 # 8000b6f8 <_ZTV9Semaphore+0x10>
    80002a9c:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80002aa0:	00850513          	addi	a0,a0,8
    80002aa4:	fffff097          	auipc	ra,0xfffff
    80002aa8:	878080e7          	jalr	-1928(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
}
    80002aac:	00813083          	ld	ra,8(sp)
    80002ab0:	00013403          	ld	s0,0(sp)
    80002ab4:	01010113          	addi	sp,sp,16
    80002ab8:	00008067          	ret

0000000080002abc <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80002abc:	ff010113          	addi	sp,sp,-16
    80002ac0:	00113423          	sd	ra,8(sp)
    80002ac4:	00813023          	sd	s0,0(sp)
    80002ac8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002acc:	00853503          	ld	a0,8(a0)
    80002ad0:	fffff097          	auipc	ra,0xfffff
    80002ad4:	8b0080e7          	jalr	-1872(ra) # 80001380 <_Z8sem_waitP10_semaphore>
}
    80002ad8:	00813083          	ld	ra,8(sp)
    80002adc:	00013403          	ld	s0,0(sp)
    80002ae0:	01010113          	addi	sp,sp,16
    80002ae4:	00008067          	ret

0000000080002ae8 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002ae8:	ff010113          	addi	sp,sp,-16
    80002aec:	00113423          	sd	ra,8(sp)
    80002af0:	00813023          	sd	s0,0(sp)
    80002af4:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002af8:	00853503          	ld	a0,8(a0)
    80002afc:	fffff097          	auipc	ra,0xfffff
    80002b00:	8b0080e7          	jalr	-1872(ra) # 800013ac <_Z10sem_signalP10_semaphore>
}
    80002b04:	00813083          	ld	ra,8(sp)
    80002b08:	00013403          	ld	s0,0(sp)
    80002b0c:	01010113          	addi	sp,sp,16
    80002b10:	00008067          	ret

0000000080002b14 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80002b14:	ff010113          	addi	sp,sp,-16
    80002b18:	00113423          	sd	ra,8(sp)
    80002b1c:	00813023          	sd	s0,0(sp)
    80002b20:	01010413          	addi	s0,sp,16
    80002b24:	00009797          	auipc	a5,0x9
    80002b28:	bf478793          	addi	a5,a5,-1036 # 8000b718 <_ZTV6Thread+0x10>
    80002b2c:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80002b30:	00850513          	addi	a0,a0,8
    80002b34:	ffffe097          	auipc	ra,0xffffe
    80002b38:	740080e7          	jalr	1856(ra) # 80001274 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002b3c:	00813083          	ld	ra,8(sp)
    80002b40:	00013403          	ld	s0,0(sp)
    80002b44:	01010113          	addi	sp,sp,16
    80002b48:	00008067          	ret

0000000080002b4c <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002b4c:	ff010113          	addi	sp,sp,-16
    80002b50:	00113423          	sd	ra,8(sp)
    80002b54:	00813023          	sd	s0,0(sp)
    80002b58:	01010413          	addi	s0,sp,16
    80002b5c:	00009797          	auipc	a5,0x9
    80002b60:	bbc78793          	addi	a5,a5,-1092 # 8000b718 <_ZTV6Thread+0x10>
    80002b64:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    80002b68:	00050613          	mv	a2,a0
    80002b6c:	00000597          	auipc	a1,0x0
    80002b70:	d7c58593          	addi	a1,a1,-644 # 800028e8 <_ZN6Thread7wrapperEPv>
    80002b74:	00850513          	addi	a0,a0,8
    80002b78:	ffffe097          	auipc	ra,0xffffe
    80002b7c:	6fc080e7          	jalr	1788(ra) # 80001274 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002b80:	00813083          	ld	ra,8(sp)
    80002b84:	00013403          	ld	s0,0(sp)
    80002b88:	01010113          	addi	sp,sp,16
    80002b8c:	00008067          	ret

0000000080002b90 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002b90:	ff010113          	addi	sp,sp,-16
    80002b94:	00113423          	sd	ra,8(sp)
    80002b98:	00813023          	sd	s0,0(sp)
    80002b9c:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002ba0:	fffff097          	auipc	ra,0xfffff
    80002ba4:	838080e7          	jalr	-1992(ra) # 800013d8 <_Z10time_sleepm>
}
    80002ba8:	00813083          	ld	ra,8(sp)
    80002bac:	00013403          	ld	s0,0(sp)
    80002bb0:	01010113          	addi	sp,sp,16
    80002bb4:	00008067          	ret

0000000080002bb8 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80002bb8:	fe010113          	addi	sp,sp,-32
    80002bbc:	00113c23          	sd	ra,24(sp)
    80002bc0:	00813823          	sd	s0,16(sp)
    80002bc4:	00913423          	sd	s1,8(sp)
    80002bc8:	01213023          	sd	s2,0(sp)
    80002bcc:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80002bd0:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80002bd4:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80002bd8:	0004b783          	ld	a5,0(s1)
    80002bdc:	0187b783          	ld	a5,24(a5)
    80002be0:	00048513          	mv	a0,s1
    80002be4:	000780e7          	jalr	a5
        pt->sleep(time);
    80002be8:	00090513          	mv	a0,s2
    80002bec:	00000097          	auipc	ra,0x0
    80002bf0:	fa4080e7          	jalr	-92(ra) # 80002b90 <_ZN6Thread5sleepEm>
    while(true){
    80002bf4:	fe5ff06f          	j	80002bd8 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080002bf8 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002bf8:	ff010113          	addi	sp,sp,-16
    80002bfc:	00113423          	sd	ra,8(sp)
    80002c00:	00813023          	sd	s0,0(sp)
    80002c04:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002c08:	ffffe097          	auipc	ra,0xffffe
    80002c0c:	64c080e7          	jalr	1612(ra) # 80001254 <_Z15thread_dispatchv>
}
    80002c10:	00813083          	ld	ra,8(sp)
    80002c14:	00013403          	ld	s0,0(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	00008067          	ret

0000000080002c20 <_ZN6Thread5startEv>:
int Thread::start() {
    80002c20:	ff010113          	addi	sp,sp,-16
    80002c24:	00113423          	sd	ra,8(sp)
    80002c28:	00813023          	sd	s0,0(sp)
    80002c2c:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80002c30:	00853503          	ld	a0,8(a0)
    80002c34:	ffffe097          	auipc	ra,0xffffe
    80002c38:	6bc080e7          	jalr	1724(ra) # 800012f0 <_Z12thread_startP7_thread>
}
    80002c3c:	00813083          	ld	ra,8(sp)
    80002c40:	00013403          	ld	s0,0(sp)
    80002c44:	01010113          	addi	sp,sp,16
    80002c48:	00008067          	ret

0000000080002c4c <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80002c4c:	fe010113          	addi	sp,sp,-32
    80002c50:	00113c23          	sd	ra,24(sp)
    80002c54:	00813823          	sd	s0,16(sp)
    80002c58:	00913423          	sd	s1,8(sp)
    80002c5c:	01213023          	sd	s2,0(sp)
    80002c60:	02010413          	addi	s0,sp,32
    80002c64:	00050493          	mv	s1,a0
    80002c68:	00058913          	mv	s2,a1
    80002c6c:	01000513          	li	a0,16
    80002c70:	00000097          	auipc	ra,0x0
    80002c74:	d1c080e7          	jalr	-740(ra) # 8000298c <_Znwm>
    80002c78:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80002c7c:	00953023          	sd	s1,0(a0)
    80002c80:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80002c84:	00000597          	auipc	a1,0x0
    80002c88:	f3458593          	addi	a1,a1,-204 # 80002bb8 <_ZN14PeriodicThread7wrapperEPv>
    80002c8c:	00048513          	mv	a0,s1
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	e84080e7          	jalr	-380(ra) # 80002b14 <_ZN6ThreadC1EPFvPvES0_>
    80002c98:	00009797          	auipc	a5,0x9
    80002c9c:	a3078793          	addi	a5,a5,-1488 # 8000b6c8 <_ZTV14PeriodicThread+0x10>
    80002ca0:	00f4b023          	sd	a5,0(s1)
    80002ca4:	01813083          	ld	ra,24(sp)
    80002ca8:	01013403          	ld	s0,16(sp)
    80002cac:	00813483          	ld	s1,8(sp)
    80002cb0:	00013903          	ld	s2,0(sp)
    80002cb4:	02010113          	addi	sp,sp,32
    80002cb8:	00008067          	ret

0000000080002cbc <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80002cbc:	ff010113          	addi	sp,sp,-16
    80002cc0:	00113423          	sd	ra,8(sp)
    80002cc4:	00813023          	sd	s0,0(sp)
    80002cc8:	01010413          	addi	s0,sp,16
    return ::getc();
    80002ccc:	ffffe097          	auipc	ra,0xffffe
    80002cd0:	738080e7          	jalr	1848(ra) # 80001404 <_Z4getcv>
}
    80002cd4:	00813083          	ld	ra,8(sp)
    80002cd8:	00013403          	ld	s0,0(sp)
    80002cdc:	01010113          	addi	sp,sp,16
    80002ce0:	00008067          	ret

0000000080002ce4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002ce4:	ff010113          	addi	sp,sp,-16
    80002ce8:	00113423          	sd	ra,8(sp)
    80002cec:	00813023          	sd	s0,0(sp)
    80002cf0:	01010413          	addi	s0,sp,16
    ::putc(c);
    80002cf4:	ffffe097          	auipc	ra,0xffffe
    80002cf8:	738080e7          	jalr	1848(ra) # 8000142c <_Z4putcc>
}
    80002cfc:	00813083          	ld	ra,8(sp)
    80002d00:	00013403          	ld	s0,0(sp)
    80002d04:	01010113          	addi	sp,sp,16
    80002d08:	00008067          	ret

0000000080002d0c <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80002d0c:	ff010113          	addi	sp,sp,-16
    80002d10:	00813423          	sd	s0,8(sp)
    80002d14:	01010413          	addi	s0,sp,16
    80002d18:	00813403          	ld	s0,8(sp)
    80002d1c:	01010113          	addi	sp,sp,16
    80002d20:	00008067          	ret

0000000080002d24 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80002d24:	ff010113          	addi	sp,sp,-16
    80002d28:	00813423          	sd	s0,8(sp)
    80002d2c:	01010413          	addi	s0,sp,16
    80002d30:	00813403          	ld	s0,8(sp)
    80002d34:	01010113          	addi	sp,sp,16
    80002d38:	00008067          	ret

0000000080002d3c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80002d3c:	ff010113          	addi	sp,sp,-16
    80002d40:	00113423          	sd	ra,8(sp)
    80002d44:	00813023          	sd	s0,0(sp)
    80002d48:	01010413          	addi	s0,sp,16
    80002d4c:	00009797          	auipc	a5,0x9
    80002d50:	97c78793          	addi	a5,a5,-1668 # 8000b6c8 <_ZTV14PeriodicThread+0x10>
    80002d54:	00f53023          	sd	a5,0(a0)
    80002d58:	00000097          	auipc	ra,0x0
    80002d5c:	bf4080e7          	jalr	-1036(ra) # 8000294c <_ZN6ThreadD1Ev>
    80002d60:	00813083          	ld	ra,8(sp)
    80002d64:	00013403          	ld	s0,0(sp)
    80002d68:	01010113          	addi	sp,sp,16
    80002d6c:	00008067          	ret

0000000080002d70 <_ZN14PeriodicThreadD0Ev>:
    80002d70:	fe010113          	addi	sp,sp,-32
    80002d74:	00113c23          	sd	ra,24(sp)
    80002d78:	00813823          	sd	s0,16(sp)
    80002d7c:	00913423          	sd	s1,8(sp)
    80002d80:	02010413          	addi	s0,sp,32
    80002d84:	00050493          	mv	s1,a0
    80002d88:	00009797          	auipc	a5,0x9
    80002d8c:	94078793          	addi	a5,a5,-1728 # 8000b6c8 <_ZTV14PeriodicThread+0x10>
    80002d90:	00f53023          	sd	a5,0(a0)
    80002d94:	00000097          	auipc	ra,0x0
    80002d98:	bb8080e7          	jalr	-1096(ra) # 8000294c <_ZN6ThreadD1Ev>
    80002d9c:	00048513          	mv	a0,s1
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	c3c080e7          	jalr	-964(ra) # 800029dc <_ZdlPv>
    80002da8:	01813083          	ld	ra,24(sp)
    80002dac:	01013403          	ld	s0,16(sp)
    80002db0:	00813483          	ld	s1,8(sp)
    80002db4:	02010113          	addi	sp,sp,32
    80002db8:	00008067          	ret

0000000080002dbc <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80002dbc:	ff010113          	addi	sp,sp,-16
    80002dc0:	00113423          	sd	ra,8(sp)
    80002dc4:	00813023          	sd	s0,0(sp)
    80002dc8:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80002dcc:	00009797          	auipc	a5,0x9
    80002dd0:	abc7b783          	ld	a5,-1348(a5) # 8000b888 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80002dd4:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    80002dd8:	fffff097          	auipc	ra,0xfffff
    80002ddc:	674080e7          	jalr	1652(ra) # 8000244c <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80002de0:	00001097          	auipc	ra,0x1
    80002de4:	ed8080e7          	jalr	-296(ra) # 80003cb8 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	544080e7          	jalr	1348(ra) # 8000232c <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    80002df0:	00001097          	auipc	ra,0x1
    80002df4:	0dc080e7          	jalr	220(ra) # 80003ecc <_ZN11ConsoleUtil10initializeEv>
    Buddy::initialize();
    80002df8:	ffffe097          	auipc	ra,0xffffe
    80002dfc:	6e0080e7          	jalr	1760(ra) # 800014d8 <_ZN5Buddy10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80002e00:	00200793          	li	a5,2
    80002e04:	1047a073          	csrs	sie,a5
    80002e08:	20000713          	li	a4,512
    80002e0c:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002e10:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80002e14:	00813083          	ld	ra,8(sp)
    80002e18:	00013403          	ld	s0,0(sp)
    80002e1c:	01010113          	addi	sp,sp,16
    80002e20:	00008067          	ret

0000000080002e24 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80002e24:	ff010113          	addi	sp,sp,-16
    80002e28:	00813423          	sd	s0,8(sp)
    80002e2c:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80002e30:	14109073          	csrw	sepc,ra
    asm("sret");
    80002e34:	10200073          	sret
}
    80002e38:	00813403          	ld	s0,8(sp)
    80002e3c:	01010113          	addi	sp,sp,16
    80002e40:	00008067          	ret

0000000080002e44 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80002e44:	ff010113          	addi	sp,sp,-16
    80002e48:	00113423          	sd	ra,8(sp)
    80002e4c:	00813023          	sd	s0,0(sp)
    80002e50:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80002e54:	00009797          	auipc	a5,0x9
    80002e58:	a547b783          	ld	a5,-1452(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002e5c:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80002e60:	00100713          	li	a4,1
    80002e64:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002e68:	fffff097          	auipc	ra,0xfffff
    80002e6c:	41c080e7          	jalr	1052(ra) # 80002284 <_ZN3TCB8dispatchEv>
}
    80002e70:	00813083          	ld	ra,8(sp)
    80002e74:	00013403          	ld	s0,0(sp)
    80002e78:	01010113          	addi	sp,sp,16
    80002e7c:	00008067          	ret

0000000080002e80 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80002e80:	ff010113          	addi	sp,sp,-16
    80002e84:	00113423          	sd	ra,8(sp)
    80002e88:	00813023          	sd	s0,0(sp)
    80002e8c:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80002e90:	00009797          	auipc	a5,0x9
    80002e94:	bd07c783          	lbu	a5,-1072(a5) # 8000ba60 <_ZN5RiscV16userMainFinishedE>
    80002e98:	00079c63          	bnez	a5,80002eb0 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80002e9c:	00009717          	auipc	a4,0x9
    80002ea0:	a0473703          	ld	a4,-1532(a4) # 8000b8a0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002ea4:	00073783          	ld	a5,0(a4)
    80002ea8:	00178793          	addi	a5,a5,1
    80002eac:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80002eb0:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80002eb4:	0ff57513          	andi	a0,a0,255
    80002eb8:	00001097          	auipc	ra,0x1
    80002ebc:	1a4080e7          	jalr	420(ra) # 8000405c <_ZN11ConsoleUtil9putOutputEc>
}
    80002ec0:	00813083          	ld	ra,8(sp)
    80002ec4:	00013403          	ld	s0,0(sp)
    80002ec8:	01010113          	addi	sp,sp,16
    80002ecc:	00008067          	ret

0000000080002ed0 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80002ed0:	fe010113          	addi	sp,sp,-32
    80002ed4:	00113c23          	sd	ra,24(sp)
    80002ed8:	00813823          	sd	s0,16(sp)
    80002edc:	02010413          	addi	s0,sp,32
    80002ee0:	00c0006f          	j	80002eec <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80002ee4:	ffffe097          	auipc	ra,0xffffe
    80002ee8:	370080e7          	jalr	880(ra) # 80001254 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80002eec:	00009797          	auipc	a5,0x9
    80002ef0:	9447b783          	ld	a5,-1724(a5) # 8000b830 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002ef4:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80002ef8:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80002efc:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80002f00:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80002f04:	0207f793          	andi	a5,a5,32
    80002f08:	fc078ee3          	beqz	a5,80002ee4 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80002f0c:	00001097          	auipc	ra,0x1
    80002f10:	368080e7          	jalr	872(ra) # 80004274 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80002f14:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80002f18:	00009797          	auipc	a5,0x9
    80002f1c:	9107b783          	ld	a5,-1776(a5) # 8000b828 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002f20:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80002f24:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80002f28:	fef44783          	lbu	a5,-17(s0)
    80002f2c:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80002f30:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80002f34:	00009797          	auipc	a5,0x9
    80002f38:	96c7b783          	ld	a5,-1684(a5) # 8000b8a0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002f3c:	0007b783          	ld	a5,0(a5)
    80002f40:	fa0786e3          	beqz	a5,80002eec <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80002f44:	fff78793          	addi	a5,a5,-1
    80002f48:	00009717          	auipc	a4,0x9
    80002f4c:	95873703          	ld	a4,-1704(a4) # 8000b8a0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002f50:	00f73023          	sd	a5,0(a4)
    80002f54:	f99ff06f          	j	80002eec <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080002f58 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80002f58:	ff010113          	addi	sp,sp,-16
    80002f5c:	00813423          	sd	s0,8(sp)
    80002f60:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80002f64:	00009797          	auipc	a5,0x9
    80002f68:	9447b783          	ld	a5,-1724(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002f6c:	0007b783          	ld	a5,0(a5)
    80002f70:	0147a703          	lw	a4,20(a5)
    80002f74:	00100793          	li	a5,1
    80002f78:	00f70c63          	beq	a4,a5,80002f90 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80002f7c:	10000793          	li	a5,256
    80002f80:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80002f84:	00813403          	ld	s0,8(sp)
    80002f88:	01010113          	addi	sp,sp,16
    80002f8c:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002f90:	10000793          	li	a5,256
    80002f94:	1007a073          	csrs	sstatus,a5
}
    80002f98:	fedff06f          	j	80002f84 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080002f9c <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80002f9c:	ff010113          	addi	sp,sp,-16
    80002fa0:	00113423          	sd	ra,8(sp)
    80002fa4:	00813023          	sd	s0,0(sp)
    80002fa8:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80002fac:	00100793          	li	a5,1
    80002fb0:	00009717          	auipc	a4,0x9
    80002fb4:	aaf70823          	sb	a5,-1360(a4) # 8000ba60 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80002fb8:	00009797          	auipc	a5,0x9
    80002fbc:	8e87b783          	ld	a5,-1816(a5) # 8000b8a0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002fc0:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80002fc4:	00009797          	auipc	a5,0x9
    80002fc8:	8947b783          	ld	a5,-1900(a5) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002fcc:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80002fd0:	00200793          	li	a5,2
    80002fd4:	1047b073          	csrc	sie,a5
    80002fd8:	20000793          	li	a5,512
    80002fdc:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80002fe0:	00009797          	auipc	a5,0x9
    80002fe4:	8987b783          	ld	a5,-1896(a5) # 8000b878 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002fe8:	0007b783          	ld	a5,0(a5)
    80002fec:	00078c63          	beqz	a5,80003004 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80002ff0:	0487b703          	ld	a4,72(a5)
    80002ff4:	00009797          	auipc	a5,0x9
    80002ff8:	8847b783          	ld	a5,-1916(a5) # 8000b878 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002ffc:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003000:	fe1ff06f          	j	80002fe0 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003004:	00009797          	auipc	a5,0x9
    80003008:	87c7b783          	ld	a5,-1924(a5) # 8000b880 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000300c:	0007b503          	ld	a0,0(a5)
    80003010:	00001097          	auipc	ra,0x1
    80003014:	cc0080e7          	jalr	-832(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003018:	00009797          	auipc	a5,0x9
    8000301c:	8787b783          	ld	a5,-1928(a5) # 8000b890 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003020:	0007b703          	ld	a4,0(a5)
    80003024:	00009797          	auipc	a5,0x9
    80003028:	8747b783          	ld	a5,-1932(a5) # 8000b898 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000302c:	0007b783          	ld	a5,0(a5)
    80003030:	00f70863          	beq	a4,a5,80003040 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003034:	ffffe097          	auipc	ra,0xffffe
    80003038:	220080e7          	jalr	544(ra) # 80001254 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000303c:	fddff06f          	j	80003018 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003040:	00813083          	ld	ra,8(sp)
    80003044:	00013403          	ld	s0,0(sp)
    80003048:	01010113          	addi	sp,sp,16
    8000304c:	00008067          	ret

0000000080003050 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003050:	ff010113          	addi	sp,sp,-16
    80003054:	00813423          	sd	s0,8(sp)
    80003058:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    8000305c:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003060:	00009717          	auipc	a4,0x9
    80003064:	84873703          	ld	a4,-1976(a4) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003068:	00073703          	ld	a4,0(a4)
    8000306c:	06873703          	ld	a4,104(a4)
    80003070:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003074:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003078:	00078593          	mv	a1,a5
}
    8000307c:	00813403          	ld	s0,8(sp)
    80003080:	01010113          	addi	sp,sp,16
    80003084:	00008067          	ret

0000000080003088 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003088:	ff010113          	addi	sp,sp,-16
    8000308c:	00113423          	sd	ra,8(sp)
    80003090:	00813023          	sd	s0,0(sp)
    80003094:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003098:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    8000309c:	fffff097          	auipc	ra,0xfffff
    800030a0:	430080e7          	jalr	1072(ra) # 800024cc <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800030a4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800030a8:	00000097          	auipc	ra,0x0
    800030ac:	fa8080e7          	jalr	-88(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800030b0:	00813083          	ld	ra,8(sp)
    800030b4:	00013403          	ld	s0,0(sp)
    800030b8:	01010113          	addi	sp,sp,16
    800030bc:	00008067          	ret

00000000800030c0 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    800030c0:	ff010113          	addi	sp,sp,-16
    800030c4:	00113423          	sd	ra,8(sp)
    800030c8:	00813023          	sd	s0,0(sp)
    800030cc:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    800030d0:	00008797          	auipc	a5,0x8
    800030d4:	7e07b783          	ld	a5,2016(a5) # 8000b8b0 <_GLOBAL_OFFSET_TABLE_+0x90>
    800030d8:	0007c783          	lbu	a5,0(a5)
    800030dc:	02079263          	bnez	a5,80003100 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    800030e0:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800030e4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800030e8:	00000097          	auipc	ra,0x0
    800030ec:	f68080e7          	jalr	-152(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800030f0:	00813083          	ld	ra,8(sp)
    800030f4:	00013403          	ld	s0,0(sp)
    800030f8:	01010113          	addi	sp,sp,16
    800030fc:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003100:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003104:	fffff097          	auipc	ra,0xfffff
    80003108:	5f0080e7          	jalr	1520(ra) # 800026f4 <_ZN15MemoryAllocator5kfreeEPv>
    8000310c:	fd9ff06f          	j	800030e4 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003110 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003110:	fc010113          	addi	sp,sp,-64
    80003114:	02113c23          	sd	ra,56(sp)
    80003118:	02813823          	sd	s0,48(sp)
    8000311c:	02913423          	sd	s1,40(sp)
    80003120:	03213023          	sd	s2,32(sp)
    80003124:	01313c23          	sd	s3,24(sp)
    80003128:	01413823          	sd	s4,16(sp)
    8000312c:	01513423          	sd	s5,8(sp)
    80003130:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003134:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003138:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000313c:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003140:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003144:	07000513          	li	a0,112
    80003148:	fffff097          	auipc	ra,0xfffff
    8000314c:	1bc080e7          	jalr	444(ra) # 80002304 <_ZN3TCBnwEm>
    80003150:	00050493          	mv	s1,a0
    80003154:	00200713          	li	a4,2
    80003158:	000a0693          	mv	a3,s4
    8000315c:	00098613          	mv	a2,s3
    80003160:	00090593          	mv	a1,s2
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	054080e7          	jalr	84(ra) # 800021b8 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000316c:	04048863          	beqz	s1,800031bc <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003170:	0184b783          	ld	a5,24(s1)
    80003174:	00078863          	beqz	a5,80003184 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003178:	00048513          	mv	a0,s1
    8000317c:	00001097          	auipc	ra,0x1
    80003180:	b54080e7          	jalr	-1196(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003184:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003188:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000318c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003190:	00000097          	auipc	ra,0x0
    80003194:	ec0080e7          	jalr	-320(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003198:	03813083          	ld	ra,56(sp)
    8000319c:	03013403          	ld	s0,48(sp)
    800031a0:	02813483          	ld	s1,40(sp)
    800031a4:	02013903          	ld	s2,32(sp)
    800031a8:	01813983          	ld	s3,24(sp)
    800031ac:	01013a03          	ld	s4,16(sp)
    800031b0:	00813a83          	ld	s5,8(sp)
    800031b4:	04010113          	addi	sp,sp,64
    800031b8:	00008067          	ret
        status = -1;
    800031bc:	fff00793          	li	a5,-1
    800031c0:	fcdff06f          	j	8000318c <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    800031c4:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800031c8:	00048513          	mv	a0,s1
    800031cc:	fffff097          	auipc	ra,0xfffff
    800031d0:	22c080e7          	jalr	556(ra) # 800023f8 <_ZN3TCBdlEPv>
    800031d4:	00090513          	mv	a0,s2
    800031d8:	0000e097          	auipc	ra,0xe
    800031dc:	9e0080e7          	jalr	-1568(ra) # 80010bb8 <_Unwind_Resume>

00000000800031e0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    800031e0:	fc010113          	addi	sp,sp,-64
    800031e4:	02113c23          	sd	ra,56(sp)
    800031e8:	02813823          	sd	s0,48(sp)
    800031ec:	02913423          	sd	s1,40(sp)
    800031f0:	03213023          	sd	s2,32(sp)
    800031f4:	01313c23          	sd	s3,24(sp)
    800031f8:	01413823          	sd	s4,16(sp)
    800031fc:	01513423          	sd	s5,8(sp)
    80003200:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003204:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003208:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000320c:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003210:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003214:	07000513          	li	a0,112
    80003218:	fffff097          	auipc	ra,0xfffff
    8000321c:	0ec080e7          	jalr	236(ra) # 80002304 <_ZN3TCBnwEm>
    80003220:	00050493          	mv	s1,a0
    80003224:	00200713          	li	a4,2
    80003228:	00090693          	mv	a3,s2
    8000322c:	00098613          	mv	a2,s3
    80003230:	000a0593          	mv	a1,s4
    80003234:	fffff097          	auipc	ra,0xfffff
    80003238:	f84080e7          	jalr	-124(ra) # 800021b8 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000323c:	04048263          	beqz	s1,80003280 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003240:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003244:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003248:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    8000324c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003250:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003254:	00000097          	auipc	ra,0x0
    80003258:	dfc080e7          	jalr	-516(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000325c:	03813083          	ld	ra,56(sp)
    80003260:	03013403          	ld	s0,48(sp)
    80003264:	02813483          	ld	s1,40(sp)
    80003268:	02013903          	ld	s2,32(sp)
    8000326c:	01813983          	ld	s3,24(sp)
    80003270:	01013a03          	ld	s4,16(sp)
    80003274:	00813a83          	ld	s5,8(sp)
    80003278:	04010113          	addi	sp,sp,64
    8000327c:	00008067          	ret
        status = -1;
    80003280:	fff00793          	li	a5,-1
    80003284:	fcdff06f          	j	80003250 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003288:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000328c:	00048513          	mv	a0,s1
    80003290:	fffff097          	auipc	ra,0xfffff
    80003294:	168080e7          	jalr	360(ra) # 800023f8 <_ZN3TCBdlEPv>
    80003298:	00090513          	mv	a0,s2
    8000329c:	0000e097          	auipc	ra,0xe
    800032a0:	91c080e7          	jalr	-1764(ra) # 80010bb8 <_Unwind_Resume>

00000000800032a4 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800032a4:	ff010113          	addi	sp,sp,-16
    800032a8:	00113423          	sd	ra,8(sp)
    800032ac:	00813023          	sd	s0,0(sp)
    800032b0:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800032b4:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    800032b8:	02051263          	bnez	a0,800032dc <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    800032bc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800032c0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800032c4:	00000097          	auipc	ra,0x0
    800032c8:	d8c080e7          	jalr	-628(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800032cc:	00813083          	ld	ra,8(sp)
    800032d0:	00013403          	ld	s0,0(sp)
    800032d4:	01010113          	addi	sp,sp,16
    800032d8:	00008067          	ret
        tcb->status = TCB::Status::READY;
    800032dc:	00100793          	li	a5,1
    800032e0:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    800032e4:	00001097          	auipc	ra,0x1
    800032e8:	9ec080e7          	jalr	-1556(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    800032ec:	fffff097          	auipc	ra,0xfffff
    800032f0:	f98080e7          	jalr	-104(ra) # 80002284 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    800032f4:	00000793          	li	a5,0
    800032f8:	fc9ff06f          	j	800032c0 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

00000000800032fc <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    800032fc:	ff010113          	addi	sp,sp,-16
    80003300:	00113423          	sd	ra,8(sp)
    80003304:	00813023          	sd	s0,0(sp)
    80003308:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000330c:	00008797          	auipc	a5,0x8
    80003310:	59c7b783          	ld	a5,1436(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003314:	0007b783          	ld	a5,0(a5)
    80003318:	02078a63          	beqz	a5,8000334c <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    8000331c:	00200713          	li	a4,2
    80003320:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003324:	fffff097          	auipc	ra,0xfffff
    80003328:	f60080e7          	jalr	-160(ra) # 80002284 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000332c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003330:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003334:	00000097          	auipc	ra,0x0
    80003338:	d1c080e7          	jalr	-740(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000333c:	00813083          	ld	ra,8(sp)
    80003340:	00013403          	ld	s0,0(sp)
    80003344:	01010113          	addi	sp,sp,16
    80003348:	00008067          	ret
        status = -1;
    8000334c:	fff00793          	li	a5,-1
    80003350:	fe1ff06f          	j	80003330 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003354 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003354:	fd010113          	addi	sp,sp,-48
    80003358:	02113423          	sd	ra,40(sp)
    8000335c:	02813023          	sd	s0,32(sp)
    80003360:	00913c23          	sd	s1,24(sp)
    80003364:	01213823          	sd	s2,16(sp)
    80003368:	01313423          	sd	s3,8(sp)
    8000336c:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003370:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003374:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003378:	01800513          	li	a0,24
    8000337c:	fffff097          	auipc	ra,0xfffff
    80003380:	d4c080e7          	jalr	-692(ra) # 800020c8 <_ZN3SCBnwEm>
    80003384:	00050493          	mv	s1,a0
    80003388:	00090593          	mv	a1,s2
    8000338c:	fffff097          	auipc	ra,0xfffff
    80003390:	b80080e7          	jalr	-1152(ra) # 80001f0c <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003394:	02048a63          	beqz	s1,800033c8 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    80003398:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    8000339c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800033a0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800033a4:	00000097          	auipc	ra,0x0
    800033a8:	cac080e7          	jalr	-852(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800033ac:	02813083          	ld	ra,40(sp)
    800033b0:	02013403          	ld	s0,32(sp)
    800033b4:	01813483          	ld	s1,24(sp)
    800033b8:	01013903          	ld	s2,16(sp)
    800033bc:	00813983          	ld	s3,8(sp)
    800033c0:	03010113          	addi	sp,sp,48
    800033c4:	00008067          	ret
        status = -1;
    800033c8:	fff00793          	li	a5,-1
    800033cc:	fd5ff06f          	j	800033a0 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    800033d0:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    800033d4:	00048513          	mv	a0,s1
    800033d8:	fffff097          	auipc	ra,0xfffff
    800033dc:	d18080e7          	jalr	-744(ra) # 800020f0 <_ZN3SCBdlEPv>
    800033e0:	00090513          	mv	a0,s2
    800033e4:	0000d097          	auipc	ra,0xd
    800033e8:	7d4080e7          	jalr	2004(ra) # 80010bb8 <_Unwind_Resume>

00000000800033ec <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    800033ec:	fe010113          	addi	sp,sp,-32
    800033f0:	00113c23          	sd	ra,24(sp)
    800033f4:	00813823          	sd	s0,16(sp)
    800033f8:	00913423          	sd	s1,8(sp)
    800033fc:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003400:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003404:	02049463          	bnez	s1,8000342c <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003408:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000340c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003410:	00000097          	auipc	ra,0x0
    80003414:	c40080e7          	jalr	-960(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003418:	01813083          	ld	ra,24(sp)
    8000341c:	01013403          	ld	s0,16(sp)
    80003420:	00813483          	ld	s1,8(sp)
    80003424:	02010113          	addi	sp,sp,32
    80003428:	00008067          	ret
        delete (SCB*)ihandle;
    8000342c:	00048513          	mv	a0,s1
    80003430:	fffff097          	auipc	ra,0xfffff
    80003434:	b00080e7          	jalr	-1280(ra) # 80001f30 <_ZN3SCBD1Ev>
    80003438:	00048513          	mv	a0,s1
    8000343c:	fffff097          	auipc	ra,0xfffff
    80003440:	cb4080e7          	jalr	-844(ra) # 800020f0 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003444:	00000793          	li	a5,0
    80003448:	fc5ff06f          	j	8000340c <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

000000008000344c <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    8000344c:	ff010113          	addi	sp,sp,-16
    80003450:	00113423          	sd	ra,8(sp)
    80003454:	00813023          	sd	s0,0(sp)
    80003458:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000345c:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003460:	02051c63          	bnez	a0,80003498 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003464:	00008797          	auipc	a5,0x8
    80003468:	4447b783          	ld	a5,1092(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000346c:	0007b783          	ld	a5,0(a5)
    80003470:	0607b783          	ld	a5,96(a5)
    80003474:	02078863          	beqz	a5,800034a4 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003478:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000347c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003480:	00000097          	auipc	ra,0x0
    80003484:	bd0080e7          	jalr	-1072(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003488:	00813083          	ld	ra,8(sp)
    8000348c:	00013403          	ld	s0,0(sp)
    80003490:	01010113          	addi	sp,sp,16
    80003494:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003498:	fffff097          	auipc	ra,0xfffff
    8000349c:	ba4080e7          	jalr	-1116(ra) # 8000203c <_ZN3SCB4waitEv>
    800034a0:	fc5ff06f          	j	80003464 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800034a4:	00000793          	li	a5,0
    800034a8:	fd5ff06f          	j	8000347c <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800034ac <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800034ac:	ff010113          	addi	sp,sp,-16
    800034b0:	00113423          	sd	ra,8(sp)
    800034b4:	00813023          	sd	s0,0(sp)
    800034b8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800034bc:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800034c0:	02051263          	bnez	a0,800034e4 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800034c4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800034c8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800034cc:	00000097          	auipc	ra,0x0
    800034d0:	b84080e7          	jalr	-1148(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800034d4:	00813083          	ld	ra,8(sp)
    800034d8:	00013403          	ld	s0,0(sp)
    800034dc:	01010113          	addi	sp,sp,16
    800034e0:	00008067          	ret
        ((SCB*)ihandle)->signal();
    800034e4:	fffff097          	auipc	ra,0xfffff
    800034e8:	ba8080e7          	jalr	-1112(ra) # 8000208c <_ZN3SCB6signalEv>
    uint64 status = 0;
    800034ec:	00000793          	li	a5,0
    800034f0:	fd9ff06f          	j	800034c8 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

00000000800034f4 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    800034f4:	fe010113          	addi	sp,sp,-32
    800034f8:	00113c23          	sd	ra,24(sp)
    800034fc:	00813823          	sd	s0,16(sp)
    80003500:	00913423          	sd	s1,8(sp)
    80003504:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003508:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000350c:	00008797          	auipc	a5,0x8
    80003510:	39c7b783          	ld	a5,924(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003514:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003518:	00008797          	auipc	a5,0x8
    8000351c:	5507b783          	ld	a5,1360(a5) # 8000ba68 <_ZN5RiscV10globalTimeE>
    80003520:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003524:	00e787b3          	add	a5,a5,a4
    80003528:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    8000352c:	00048513          	mv	a0,s1
    80003530:	00001097          	auipc	ra,0x1
    80003534:	81c080e7          	jalr	-2020(ra) # 80003d4c <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003538:	00300793          	li	a5,3
    8000353c:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003540:	fffff097          	auipc	ra,0xfffff
    80003544:	d44080e7          	jalr	-700(ra) # 80002284 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003548:	00000793          	li	a5,0
    8000354c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003550:	00000097          	auipc	ra,0x0
    80003554:	b00080e7          	jalr	-1280(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003558:	01813083          	ld	ra,24(sp)
    8000355c:	01013403          	ld	s0,16(sp)
    80003560:	00813483          	ld	s1,8(sp)
    80003564:	02010113          	addi	sp,sp,32
    80003568:	00008067          	ret

000000008000356c <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    8000356c:	fe010113          	addi	sp,sp,-32
    80003570:	00113c23          	sd	ra,24(sp)
    80003574:	00813823          	sd	s0,16(sp)
    80003578:	00913423          	sd	s1,8(sp)
    8000357c:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003580:	00008797          	auipc	a5,0x8
    80003584:	4e07c783          	lbu	a5,1248(a5) # 8000ba60 <_ZN5RiscV16userMainFinishedE>
    80003588:	00079c63          	bnez	a5,800035a0 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    8000358c:	00008717          	auipc	a4,0x8
    80003590:	2cc73703          	ld	a4,716(a4) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003594:	00073783          	ld	a5,0(a4)
    80003598:	00178793          	addi	a5,a5,1
    8000359c:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800035a0:	00001097          	auipc	ra,0x1
    800035a4:	a44080e7          	jalr	-1468(ra) # 80003fe4 <_ZN11ConsoleUtil8getInputEv>
    800035a8:	00050493          	mv	s1,a0
    if(c==13) {
    800035ac:	00d00793          	li	a5,13
    800035b0:	02f50663          	beq	a0,a5,800035dc <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800035b4:	01b00793          	li	a5,27
    800035b8:	04f51063          	bne	a0,a5,800035f8 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800035bc:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800035c0:	00000097          	auipc	ra,0x0
    800035c4:	a90080e7          	jalr	-1392(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800035c8:	01813083          	ld	ra,24(sp)
    800035cc:	01013403          	ld	s0,16(sp)
    800035d0:	00813483          	ld	s1,8(sp)
    800035d4:	02010113          	addi	sp,sp,32
    800035d8:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800035dc:	00d00513          	li	a0,13
    800035e0:	00001097          	auipc	ra,0x1
    800035e4:	a7c080e7          	jalr	-1412(ra) # 8000405c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    800035e8:	00a00513          	li	a0,10
    800035ec:	00001097          	auipc	ra,0x1
    800035f0:	a70080e7          	jalr	-1424(ra) # 8000405c <_ZN11ConsoleUtil9putOutputEc>
    800035f4:	fc9ff06f          	j	800035bc <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    800035f8:	00001097          	auipc	ra,0x1
    800035fc:	a64080e7          	jalr	-1436(ra) # 8000405c <_ZN11ConsoleUtil9putOutputEc>
    80003600:	fbdff06f          	j	800035bc <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003604 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003604:	ff010113          	addi	sp,sp,-16
    80003608:	00113423          	sd	ra,8(sp)
    8000360c:	00813023          	sd	s0,0(sp)
    80003610:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003614:	00001097          	auipc	ra,0x1
    80003618:	ac8080e7          	jalr	-1336(ra) # 800040dc <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    8000361c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003620:	00000097          	auipc	ra,0x0
    80003624:	a30080e7          	jalr	-1488(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003628:	00813083          	ld	ra,8(sp)
    8000362c:	00013403          	ld	s0,0(sp)
    80003630:	01010113          	addi	sp,sp,16
    80003634:	00008067          	ret

0000000080003638 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003638:	fe010113          	addi	sp,sp,-32
    8000363c:	00113c23          	sd	ra,24(sp)
    80003640:	00813823          	sd	s0,16(sp)
    80003644:	00913423          	sd	s1,8(sp)
    80003648:	01213023          	sd	s2,0(sp)
    8000364c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003650:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003654:	02049663          	bnez	s1,80003680 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    80003658:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000365c:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    80003660:	00000097          	auipc	ra,0x0
    80003664:	9f0080e7          	jalr	-1552(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003668:	01813083          	ld	ra,24(sp)
    8000366c:	01013403          	ld	s0,16(sp)
    80003670:	00813483          	ld	s1,8(sp)
    80003674:	00013903          	ld	s2,0(sp)
    80003678:	02010113          	addi	sp,sp,32
    8000367c:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    80003680:	0284b503          	ld	a0,40(s1)
    80003684:	fffff097          	auipc	ra,0xfffff
    80003688:	070080e7          	jalr	112(ra) # 800026f4 <_ZN15MemoryAllocator5kfreeEPv>
    8000368c:	00050913          	mv	s2,a0
        delete thr;
    80003690:	00048513          	mv	a0,s1
    80003694:	fffff097          	auipc	ra,0xfffff
    80003698:	bc8080e7          	jalr	-1080(ra) # 8000225c <_ZN3TCBD1Ev>
    8000369c:	00048513          	mv	a0,s1
    800036a0:	fffff097          	auipc	ra,0xfffff
    800036a4:	d58080e7          	jalr	-680(ra) # 800023f8 <_ZN3TCBdlEPv>
    800036a8:	fb5ff06f          	j	8000365c <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

00000000800036ac <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800036ac:	fe010113          	addi	sp,sp,-32
    800036b0:	00113c23          	sd	ra,24(sp)
    800036b4:	00813823          	sd	s0,16(sp)
    800036b8:	00913423          	sd	s1,8(sp)
    800036bc:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800036c0:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    800036c4:	02049463          	bnez	s1,800036ec <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800036c8:	fff00793          	li	a5,-1
    800036cc:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800036d0:	00000097          	auipc	ra,0x0
    800036d4:	980080e7          	jalr	-1664(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>
}
    800036d8:	01813083          	ld	ra,24(sp)
    800036dc:	01013403          	ld	s0,16(sp)
    800036e0:	00813483          	ld	s1,8(sp)
    800036e4:	02010113          	addi	sp,sp,32
    800036e8:	00008067          	ret
        delete scb;
    800036ec:	00048513          	mv	a0,s1
    800036f0:	fffff097          	auipc	ra,0xfffff
    800036f4:	840080e7          	jalr	-1984(ra) # 80001f30 <_ZN3SCBD1Ev>
    800036f8:	00048513          	mv	a0,s1
    800036fc:	fffff097          	auipc	ra,0xfffff
    80003700:	9f4080e7          	jalr	-1548(ra) # 800020f0 <_ZN3SCBdlEPv>
    80003704:	fc5ff06f          	j	800036c8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003708 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003708:	fe010113          	addi	sp,sp,-32
    8000370c:	00113c23          	sd	ra,24(sp)
    80003710:	00813823          	sd	s0,16(sp)
    80003714:	00913423          	sd	s1,8(sp)
    80003718:	01213023          	sd	s2,0(sp)
    8000371c:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003720:	04000513          	li	a0,64
    80003724:	fffff097          	auipc	ra,0xfffff
    80003728:	da8080e7          	jalr	-600(ra) # 800024cc <_ZN15MemoryAllocator7kmallocEm>
    8000372c:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003730:	00008797          	auipc	a5,0x8
    80003734:	1787b783          	ld	a5,376(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003738:	0007b783          	ld	a5,0(a5)
    8000373c:	00001637          	lui	a2,0x1
    80003740:	00050593          	mv	a1,a0
    80003744:	0287b503          	ld	a0,40(a5)
    80003748:	fffff097          	auipc	ra,0xfffff
    8000374c:	160080e7          	jalr	352(ra) # 800028a8 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003750:	07000513          	li	a0,112
    80003754:	fffff097          	auipc	ra,0xfffff
    80003758:	bb0080e7          	jalr	-1104(ra) # 80002304 <_ZN3TCBnwEm>
    8000375c:	00050493          	mv	s1,a0
    80003760:	00200713          	li	a4,2
    80003764:	00090693          	mv	a3,s2
    80003768:	00000613          	li	a2,0
    8000376c:	00000593          	li	a1,0
    80003770:	fffff097          	auipc	ra,0xfffff
    80003774:	a48080e7          	jalr	-1464(ra) # 800021b8 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003778:	0a048e63          	beqz	s1,80003834 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    8000377c:	00008797          	auipc	a5,0x8
    80003780:	0f47b783          	ld	a5,244(a5) # 8000b870 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003784:	0007b783          	ld	a5,0(a5)
    80003788:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    8000378c:	00008797          	auipc	a5,0x8
    80003790:	0d47b783          	ld	a5,212(a5) # 8000b860 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003794:	0007b783          	ld	a5,0(a5)
    80003798:	00f907b3          	add	a5,s2,a5
    8000379c:	00008717          	auipc	a4,0x8
    800037a0:	10c73703          	ld	a4,268(a4) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800037a4:	00073683          	ld	a3,0(a4)
    800037a8:	0286b683          	ld	a3,40(a3)
    800037ac:	40d787b3          	sub	a5,a5,a3
    800037b0:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800037b4:	00073783          	ld	a5,0(a4)
    800037b8:	0687b503          	ld	a0,104(a5)
    800037bc:	0287b783          	ld	a5,40(a5)
    800037c0:	40f50533          	sub	a0,a0,a5
    800037c4:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    800037c8:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800037cc:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800037d0:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800037d4:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800037d8:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800037dc:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800037e0:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800037e4:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800037e8:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800037ec:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    800037f0:	00073783          	ld	a5,0(a4)
    800037f4:	0387b703          	ld	a4,56(a5)
    800037f8:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    800037fc:	0407b783          	ld	a5,64(a5)
    80003800:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003804:	00048513          	mv	a0,s1
    80003808:	00000097          	auipc	ra,0x0
    8000380c:	4c8080e7          	jalr	1224(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003810:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003814:	00000097          	auipc	ra,0x0
    80003818:	83c080e7          	jalr	-1988(ra) # 80003050 <_ZN5RiscV16saveA0toSscratchEv>

}
    8000381c:	01813083          	ld	ra,24(sp)
    80003820:	01013403          	ld	s0,16(sp)
    80003824:	00813483          	ld	s1,8(sp)
    80003828:	00013903          	ld	s2,0(sp)
    8000382c:	02010113          	addi	sp,sp,32
    80003830:	00008067          	ret
        status = -1;
    80003834:	fff00493          	li	s1,-1
    80003838:	fd9ff06f          	j	80003810 <_ZN5RiscV18executeForkSyscallEv+0x108>
    8000383c:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003840:	00048513          	mv	a0,s1
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	bb4080e7          	jalr	-1100(ra) # 800023f8 <_ZN3TCBdlEPv>
    8000384c:	00090513          	mv	a0,s2
    80003850:	0000d097          	auipc	ra,0xd
    80003854:	368080e7          	jalr	872(ra) # 80010bb8 <_Unwind_Resume>

0000000080003858 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003858:	ff010113          	addi	sp,sp,-16
    8000385c:	00813423          	sd	s0,8(sp)
    80003860:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003864:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003868:	00878793          	addi	a5,a5,8
    8000386c:	00008717          	auipc	a4,0x8
    80003870:	00473703          	ld	a4,4(a4) # 8000b870 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003874:	00f73023          	sd	a5,0(a4)
}
    80003878:	00813403          	ld	s0,8(sp)
    8000387c:	01010113          	addi	sp,sp,16
    80003880:	00008067          	ret

0000000080003884 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003884:	fa010113          	addi	sp,sp,-96
    80003888:	04113c23          	sd	ra,88(sp)
    8000388c:	04813823          	sd	s0,80(sp)
    80003890:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003894:	142027f3          	csrr	a5,scause
    80003898:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    8000389c:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    800038a0:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800038a4:	00008797          	auipc	a5,0x8
    800038a8:	0047b783          	ld	a5,4(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800038ac:	0007b783          	ld	a5,0(a5)
    800038b0:	14002773          	csrr	a4,sscratch
    800038b4:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800038b8:	fe843703          	ld	a4,-24(s0)
    800038bc:	00900793          	li	a5,9
    800038c0:	0ef70663          	beq	a4,a5,800039ac <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    800038c4:	fe843703          	ld	a4,-24(s0)
    800038c8:	00800793          	li	a5,8
    800038cc:	0ef70063          	beq	a4,a5,800039ac <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    800038d0:	fe843703          	ld	a4,-24(s0)
    800038d4:	fff00793          	li	a5,-1
    800038d8:	03f79793          	slli	a5,a5,0x3f
    800038dc:	00178793          	addi	a5,a5,1
    800038e0:	24f70263          	beq	a4,a5,80003b24 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    800038e4:	fe843703          	ld	a4,-24(s0)
    800038e8:	fff00793          	li	a5,-1
    800038ec:	03f79793          	slli	a5,a5,0x3f
    800038f0:	00978793          	addi	a5,a5,9
    800038f4:	2cf70063          	beq	a4,a5,80003bb4 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    800038f8:	fe843703          	ld	a4,-24(s0)
    800038fc:	00200793          	li	a5,2
    80003900:	34f70863          	beq	a4,a5,80003c50 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80003904:	00005517          	auipc	a0,0x5
    80003908:	7f450513          	addi	a0,a0,2036 # 800090f8 <CONSOLE_STATUS+0xe8>
    8000390c:	00001097          	auipc	ra,0x1
    80003910:	848080e7          	jalr	-1976(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003914:	00005517          	auipc	a0,0x5
    80003918:	7f450513          	addi	a0,a0,2036 # 80009108 <CONSOLE_STATUS+0xf8>
    8000391c:	00001097          	auipc	ra,0x1
    80003920:	838080e7          	jalr	-1992(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003924:	142027f3          	csrr	a5,scause
    80003928:	fef43023          	sd	a5,-32(s0)
    return scause;
    8000392c:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80003930:	00000613          	li	a2,0
    80003934:	00a00593          	li	a1,10
    80003938:	0005051b          	sext.w	a0,a0
    8000393c:	00001097          	auipc	ra,0x1
    80003940:	85c080e7          	jalr	-1956(ra) # 80004198 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003944:	00005517          	auipc	a0,0x5
    80003948:	78450513          	addi	a0,a0,1924 # 800090c8 <CONSOLE_STATUS+0xb8>
    8000394c:	00001097          	auipc	ra,0x1
    80003950:	808080e7          	jalr	-2040(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003954:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003958:	00000613          	li	a2,0
    8000395c:	01000593          	li	a1,16
    80003960:	0005051b          	sext.w	a0,a0
    80003964:	00001097          	auipc	ra,0x1
    80003968:	834080e7          	jalr	-1996(ra) # 80004198 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000396c:	00005517          	auipc	a0,0x5
    80003970:	75450513          	addi	a0,a0,1876 # 800090c0 <CONSOLE_STATUS+0xb0>
    80003974:	00000097          	auipc	ra,0x0
    80003978:	7e0080e7          	jalr	2016(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    8000397c:	00008797          	auipc	a5,0x8
    80003980:	f2c7b783          	ld	a5,-212(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003984:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003988:	00200713          	li	a4,2
    8000398c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003990:	00005517          	auipc	a0,0x5
    80003994:	78850513          	addi	a0,a0,1928 # 80009118 <CONSOLE_STATUS+0x108>
    80003998:	00000097          	auipc	ra,0x0
    8000399c:	7bc080e7          	jalr	1980(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800039a0:	fffff097          	auipc	ra,0xfffff
    800039a4:	8e4080e7          	jalr	-1820(ra) # 80002284 <_ZN3TCB8dispatchEv>
    800039a8:	0800006f          	j	80003a28 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800039ac:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800039b0:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800039b4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800039b8:	00478793          	addi	a5,a5,4
    800039bc:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    800039c0:	00008797          	auipc	a5,0x8
    800039c4:	ee87b783          	ld	a5,-280(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800039c8:	0007b783          	ld	a5,0(a5)
    800039cc:	fb043703          	ld	a4,-80(s0)
    800039d0:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800039d4:	fa843703          	ld	a4,-88(s0)
    800039d8:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800039dc:	00050793          	mv	a5,a0
        switch(syscallID){
    800039e0:	06100713          	li	a4,97
    800039e4:	02f76463          	bltu	a4,a5,80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    800039e8:	00279793          	slli	a5,a5,0x2
    800039ec:	00005717          	auipc	a4,0x5
    800039f0:	74070713          	addi	a4,a4,1856 # 8000912c <CONSOLE_STATUS+0x11c>
    800039f4:	00e787b3          	add	a5,a5,a4
    800039f8:	0007a783          	lw	a5,0(a5)
    800039fc:	00e787b3          	add	a5,a5,a4
    80003a00:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003a04:	fffff097          	auipc	ra,0xfffff
    80003a08:	684080e7          	jalr	1668(ra) # 80003088 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003a0c:	00008797          	auipc	a5,0x8
    80003a10:	e9c7b783          	ld	a5,-356(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003a14:	0007b783          	ld	a5,0(a5)
    80003a18:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003a1c:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003a20:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003a24:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003a28:	fffff097          	auipc	ra,0xfffff
    80003a2c:	530080e7          	jalr	1328(ra) # 80002f58 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003a30:	05813083          	ld	ra,88(sp)
    80003a34:	05013403          	ld	s0,80(sp)
    80003a38:	06010113          	addi	sp,sp,96
    80003a3c:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003a40:	fffff097          	auipc	ra,0xfffff
    80003a44:	680080e7          	jalr	1664(ra) # 800030c0 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003a48:	fc5ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80003a4c:	fffff097          	auipc	ra,0xfffff
    80003a50:	6c4080e7          	jalr	1732(ra) # 80003110 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003a54:	fb9ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80003a58:	00000097          	auipc	ra,0x0
    80003a5c:	8a4080e7          	jalr	-1884(ra) # 800032fc <_ZN5RiscV24executeThreadExitSyscallEv>
    80003a60:	fadff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003a64:	fffff097          	auipc	ra,0xfffff
    80003a68:	3e0080e7          	jalr	992(ra) # 80002e44 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003a6c:	fa1ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003a70:	fffff097          	auipc	ra,0xfffff
    80003a74:	770080e7          	jalr	1904(ra) # 800031e0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003a78:	f95ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80003a7c:	00000097          	auipc	ra,0x0
    80003a80:	828080e7          	jalr	-2008(ra) # 800032a4 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003a84:	f89ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80003a88:	00000097          	auipc	ra,0x0
    80003a8c:	8cc080e7          	jalr	-1844(ra) # 80003354 <_ZN5RiscV21executeSemOpenSyscallEv>
    80003a90:	f7dff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80003a94:	00000097          	auipc	ra,0x0
    80003a98:	958080e7          	jalr	-1704(ra) # 800033ec <_ZN5RiscV22executeSemCloseSyscallEv>
    80003a9c:	f71ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80003aa0:	00000097          	auipc	ra,0x0
    80003aa4:	9ac080e7          	jalr	-1620(ra) # 8000344c <_ZN5RiscV21executeSemWaitSyscallEv>
    80003aa8:	f65ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80003aac:	00000097          	auipc	ra,0x0
    80003ab0:	a00080e7          	jalr	-1536(ra) # 800034ac <_ZN5RiscV23executeSemSignalSyscallEv>
    80003ab4:	f59ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    80003ab8:	00000097          	auipc	ra,0x0
    80003abc:	a3c080e7          	jalr	-1476(ra) # 800034f4 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80003ac0:	f4dff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80003ac4:	00000097          	auipc	ra,0x0
    80003ac8:	aa8080e7          	jalr	-1368(ra) # 8000356c <_ZN5RiscV18executeGetcSyscallEv>
    80003acc:	f41ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80003ad0:	fffff097          	auipc	ra,0xfffff
    80003ad4:	3b0080e7          	jalr	944(ra) # 80002e80 <_ZN5RiscV18executePutcSyscallEv>
    80003ad8:	f35ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80003adc:	00000097          	auipc	ra,0x0
    80003ae0:	b28080e7          	jalr	-1240(ra) # 80003604 <_ZN5RiscV22executePutcUtilSyscallEv>
    80003ae4:	f29ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    80003ae8:	00000097          	auipc	ra,0x0
    80003aec:	b50080e7          	jalr	-1200(ra) # 80003638 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003af0:	f1dff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80003af4:	00000097          	auipc	ra,0x0
    80003af8:	bb8080e7          	jalr	-1096(ra) # 800036ac <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003afc:	f11ff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003b00:	00010793          	mv	a5,sp
    80003b04:	00008717          	auipc	a4,0x8
    80003b08:	d5c73703          	ld	a4,-676(a4) # 8000b860 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003b0c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	d48080e7          	jalr	-696(ra) # 80003858 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003b18:	00000097          	auipc	ra,0x0
    80003b1c:	bf0080e7          	jalr	-1040(ra) # 80003708 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003b20:	eedff06f          	j	80003a0c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003b24:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003b28:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003b2c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003b30:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003b34:	00200793          	li	a5,2
    80003b38:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003b3c:	00008717          	auipc	a4,0x8
    80003b40:	f2470713          	addi	a4,a4,-220 # 8000ba60 <_ZN5RiscV16userMainFinishedE>
    80003b44:	00873783          	ld	a5,8(a4)
    80003b48:	00178793          	addi	a5,a5,1
    80003b4c:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80003b50:	00000097          	auipc	ra,0x0
    80003b54:	254080e7          	jalr	596(ra) # 80003da4 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003b58:	00008717          	auipc	a4,0x8
    80003b5c:	ce873703          	ld	a4,-792(a4) # 8000b840 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003b60:	00073783          	ld	a5,0(a4)
    80003b64:	00178793          	addi	a5,a5,1
    80003b68:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003b6c:	00008717          	auipc	a4,0x8
    80003b70:	d3c73703          	ld	a4,-708(a4) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b74:	00073703          	ld	a4,0(a4)
    80003b78:	03073683          	ld	a3,48(a4)
    80003b7c:	00d7fc63          	bgeu	a5,a3,80003b94 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80003b80:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003b84:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003b88:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003b8c:	14179073          	csrw	sepc,a5
}
    80003b90:	e99ff06f          	j	80003a28 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80003b94:	00008797          	auipc	a5,0x8
    80003b98:	cac7b783          	ld	a5,-852(a5) # 8000b840 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003b9c:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003ba0:	00100793          	li	a5,1
    80003ba4:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003ba8:	ffffe097          	auipc	ra,0xffffe
    80003bac:	6dc080e7          	jalr	1756(ra) # 80002284 <_ZN3TCB8dispatchEv>
    80003bb0:	fd1ff06f          	j	80003b80 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003bb4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003bb8:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003bbc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003bc0:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80003bc4:	00008797          	auipc	a5,0x8
    80003bc8:	c6c7b783          	ld	a5,-916(a5) # 8000b830 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003bcc:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003bd0:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003bd4:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003bd8:	00058793          	mv	a5,a1
        if(status & 1UL)
    80003bdc:	0017f793          	andi	a5,a5,1
    80003be0:	02078863          	beqz	a5,80003c10 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80003be4:	00008797          	auipc	a5,0x8
    80003be8:	c6c7b783          	ld	a5,-916(a5) # 8000b850 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003bec:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80003bf0:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80003bf4:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80003bf8:	00058513          	mv	a0,a1
    80003bfc:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80003c00:	00008797          	auipc	a5,0x8
    80003c04:	c587b783          	ld	a5,-936(a5) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003c08:	0007b783          	ld	a5,0(a5)
    80003c0c:	02079463          	bnez	a5,80003c34 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80003c10:	00003097          	auipc	ra,0x3
    80003c14:	d64080e7          	jalr	-668(ra) # 80006974 <plic_claim>
    80003c18:	00003097          	auipc	ra,0x3
    80003c1c:	d94080e7          	jalr	-620(ra) # 800069ac <plic_complete>
        RiscV::w_sstatus(sstatus);
    80003c20:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003c24:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003c28:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003c2c:	14179073          	csrw	sepc,a5
}
    80003c30:	df9ff06f          	j	80003a28 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80003c34:	fff78793          	addi	a5,a5,-1
    80003c38:	00008717          	auipc	a4,0x8
    80003c3c:	c2073703          	ld	a4,-992(a4) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003c40:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80003c44:	00000097          	auipc	ra,0x0
    80003c48:	338080e7          	jalr	824(ra) # 80003f7c <_ZN11ConsoleUtil8putInputEc>
    80003c4c:	fc5ff06f          	j	80003c10 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80003c50:	00008797          	auipc	a5,0x8
    80003c54:	c587b783          	ld	a5,-936(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003c58:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003c5c:	00200713          	li	a4,2
    80003c60:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80003c64:	00005517          	auipc	a0,0x5
    80003c68:	46450513          	addi	a0,a0,1124 # 800090c8 <CONSOLE_STATUS+0xb8>
    80003c6c:	00000097          	auipc	ra,0x0
    80003c70:	4e8080e7          	jalr	1256(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003c74:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003c78:	00000613          	li	a2,0
    80003c7c:	01000593          	li	a1,16
    80003c80:	0005051b          	sext.w	a0,a0
    80003c84:	00000097          	auipc	ra,0x0
    80003c88:	514080e7          	jalr	1300(ra) # 80004198 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003c8c:	00005517          	auipc	a0,0x5
    80003c90:	43450513          	addi	a0,a0,1076 # 800090c0 <CONSOLE_STATUS+0xb0>
    80003c94:	00000097          	auipc	ra,0x0
    80003c98:	4c0080e7          	jalr	1216(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003c9c:	00005517          	auipc	a0,0x5
    80003ca0:	43450513          	addi	a0,a0,1076 # 800090d0 <CONSOLE_STATUS+0xc0>
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	4b0080e7          	jalr	1200(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003cac:	ffffe097          	auipc	ra,0xffffe
    80003cb0:	5d8080e7          	jalr	1496(ra) # 80002284 <_ZN3TCB8dispatchEv>
    80003cb4:	d75ff06f          	j	80003a28 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

0000000080003cb8 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80003cb8:	ff010113          	addi	sp,sp,-16
    80003cbc:	00813423          	sd	s0,8(sp)
    80003cc0:	01010413          	addi	s0,sp,16
}
    80003cc4:	00813403          	ld	s0,8(sp)
    80003cc8:	01010113          	addi	sp,sp,16
    80003ccc:	00008067          	ret

0000000080003cd0 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80003cd0:	ff010113          	addi	sp,sp,-16
    80003cd4:	00813423          	sd	s0,8(sp)
    80003cd8:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80003cdc:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80003ce0:	00008797          	auipc	a5,0x8
    80003ce4:	d907b783          	ld	a5,-624(a5) # 8000ba70 <_ZN9Scheduler9readyHeadE>
    80003ce8:	02078263          	beqz	a5,80003d0c <_ZN9Scheduler3putEP3TCB+0x3c>
    80003cec:	00008797          	auipc	a5,0x8
    80003cf0:	d8c7b783          	ld	a5,-628(a5) # 8000ba78 <_ZN9Scheduler9readyTailE>
    80003cf4:	04a7b423          	sd	a0,72(a5)
    80003cf8:	00008797          	auipc	a5,0x8
    80003cfc:	d8a7b023          	sd	a0,-640(a5) # 8000ba78 <_ZN9Scheduler9readyTailE>
}
    80003d00:	00813403          	ld	s0,8(sp)
    80003d04:	01010113          	addi	sp,sp,16
    80003d08:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80003d0c:	00008797          	auipc	a5,0x8
    80003d10:	d6a7b223          	sd	a0,-668(a5) # 8000ba70 <_ZN9Scheduler9readyHeadE>
    80003d14:	fe5ff06f          	j	80003cf8 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080003d18 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80003d18:	ff010113          	addi	sp,sp,-16
    80003d1c:	00813423          	sd	s0,8(sp)
    80003d20:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80003d24:	00008517          	auipc	a0,0x8
    80003d28:	d4c53503          	ld	a0,-692(a0) # 8000ba70 <_ZN9Scheduler9readyHeadE>
    80003d2c:	00050a63          	beqz	a0,80003d40 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80003d30:	04853783          	ld	a5,72(a0)
    80003d34:	00008717          	auipc	a4,0x8
    80003d38:	d2f73e23          	sd	a5,-708(a4) # 8000ba70 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80003d3c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80003d40:	00813403          	ld	s0,8(sp)
    80003d44:	01010113          	addi	sp,sp,16
    80003d48:	00008067          	ret

0000000080003d4c <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80003d4c:	ff010113          	addi	sp,sp,-16
    80003d50:	00813423          	sd	s0,8(sp)
    80003d54:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80003d58:	00008797          	auipc	a5,0x8
    80003d5c:	d287b783          	ld	a5,-728(a5) # 8000ba80 <_ZN9Scheduler12sleepingHeadE>
    80003d60:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80003d64:	00078e63          	beqz	a5,80003d80 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80003d68:	0587b683          	ld	a3,88(a5)
    80003d6c:	05853703          	ld	a4,88(a0)
    80003d70:	00d76863          	bltu	a4,a3,80003d80 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80003d74:	00078613          	mv	a2,a5
    80003d78:	0487b783          	ld	a5,72(a5)
    80003d7c:	fe9ff06f          	j	80003d64 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80003d80:	04f53423          	sd	a5,72(a0)
    if(prev)
    80003d84:	00060a63          	beqz	a2,80003d98 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80003d88:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80003d8c:	00813403          	ld	s0,8(sp)
    80003d90:	01010113          	addi	sp,sp,16
    80003d94:	00008067          	ret
        sleepingHead = t;
    80003d98:	00008797          	auipc	a5,0x8
    80003d9c:	cea7b423          	sd	a0,-792(a5) # 8000ba80 <_ZN9Scheduler12sleepingHeadE>
}
    80003da0:	fedff06f          	j	80003d8c <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080003da4 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80003da4:	fe010113          	addi	sp,sp,-32
    80003da8:	00113c23          	sd	ra,24(sp)
    80003dac:	00813823          	sd	s0,16(sp)
    80003db0:	00913423          	sd	s1,8(sp)
    80003db4:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80003db8:	00008497          	auipc	s1,0x8
    80003dbc:	cc84b483          	ld	s1,-824(s1) # 8000ba80 <_ZN9Scheduler12sleepingHeadE>
    80003dc0:	02048c63          	beqz	s1,80003df8 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80003dc4:	0584b703          	ld	a4,88(s1)
    80003dc8:	00008797          	auipc	a5,0x8
    80003dcc:	b007b783          	ld	a5,-1280(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003dd0:	0007b783          	ld	a5,0(a5)
    80003dd4:	02e7e263          	bltu	a5,a4,80003df8 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80003dd8:	0484b783          	ld	a5,72(s1)
    80003ddc:	00008717          	auipc	a4,0x8
    80003de0:	caf73223          	sd	a5,-860(a4) # 8000ba80 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80003de4:	00048513          	mv	a0,s1
    80003de8:	00000097          	auipc	ra,0x0
    80003dec:	ee8080e7          	jalr	-280(ra) # 80003cd0 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80003df0:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80003df4:	fc5ff06f          	j	80003db8 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80003df8:	01813083          	ld	ra,24(sp)
    80003dfc:	01013403          	ld	s0,16(sp)
    80003e00:	00813483          	ld	s1,8(sp)
    80003e04:	02010113          	addi	sp,sp,32
    80003e08:	00008067          	ret

0000000080003e0c <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80003e0c:	fe010113          	addi	sp,sp,-32
    80003e10:	00113c23          	sd	ra,24(sp)
    80003e14:	00813823          	sd	s0,16(sp)
    80003e18:	00913423          	sd	s1,8(sp)
    80003e1c:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80003e20:	00008497          	auipc	s1,0x8
    80003e24:	c504b483          	ld	s1,-944(s1) # 8000ba70 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80003e28:	02048863          	beqz	s1,80003e58 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80003e2c:	00000613          	li	a2,0
    80003e30:	01000593          	li	a1,16
    80003e34:	0004851b          	sext.w	a0,s1
    80003e38:	00000097          	auipc	ra,0x0
    80003e3c:	360080e7          	jalr	864(ra) # 80004198 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003e40:	00005517          	auipc	a0,0x5
    80003e44:	28050513          	addi	a0,a0,640 # 800090c0 <CONSOLE_STATUS+0xb0>
    80003e48:	00000097          	auipc	ra,0x0
    80003e4c:	30c080e7          	jalr	780(ra) # 80004154 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80003e50:	0484b483          	ld	s1,72(s1)
    while(iter){
    80003e54:	fd5ff06f          	j	80003e28 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80003e58:	01813083          	ld	ra,24(sp)
    80003e5c:	01013403          	ld	s0,16(sp)
    80003e60:	00813483          	ld	s1,8(sp)
    80003e64:	02010113          	addi	sp,sp,32
    80003e68:	00008067          	ret

0000000080003e6c <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80003e6c:	fe010113          	addi	sp,sp,-32
    80003e70:	00113c23          	sd	ra,24(sp)
    80003e74:	00813823          	sd	s0,16(sp)
    80003e78:	00913423          	sd	s1,8(sp)
    80003e7c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80003e80:	00008497          	auipc	s1,0x8
    80003e84:	c004b483          	ld	s1,-1024(s1) # 8000ba80 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80003e88:	02048863          	beqz	s1,80003eb8 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80003e8c:	00000613          	li	a2,0
    80003e90:	01000593          	li	a1,16
    80003e94:	0004851b          	sext.w	a0,s1
    80003e98:	ffffe097          	auipc	ra,0xffffe
    80003e9c:	f60080e7          	jalr	-160(ra) # 80001df8 <_Z8printIntiii>
        printString("\n");
    80003ea0:	00005517          	auipc	a0,0x5
    80003ea4:	22050513          	addi	a0,a0,544 # 800090c0 <CONSOLE_STATUS+0xb0>
    80003ea8:	ffffe097          	auipc	ra,0xffffe
    80003eac:	db8080e7          	jalr	-584(ra) # 80001c60 <_Z11printStringPKc>
        iter = iter->next;
    80003eb0:	0484b483          	ld	s1,72(s1)
    while(iter){
    80003eb4:	fd5ff06f          	j	80003e88 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80003eb8:	01813083          	ld	ra,24(sp)
    80003ebc:	01013403          	ld	s0,16(sp)
    80003ec0:	00813483          	ld	s1,8(sp)
    80003ec4:	02010113          	addi	sp,sp,32
    80003ec8:	00008067          	ret

0000000080003ecc <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    80003ecc:	fe010113          	addi	sp,sp,-32
    80003ed0:	00113c23          	sd	ra,24(sp)
    80003ed4:	00813823          	sd	s0,16(sp)
    80003ed8:	00913423          	sd	s1,8(sp)
    80003edc:	01213023          	sd	s2,0(sp)
    80003ee0:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80003ee4:	01800513          	li	a0,24
    80003ee8:	ffffe097          	auipc	ra,0xffffe
    80003eec:	1e0080e7          	jalr	480(ra) # 800020c8 <_ZN3SCBnwEm>
    80003ef0:	00050493          	mv	s1,a0
    80003ef4:	00000593          	li	a1,0
    80003ef8:	ffffe097          	auipc	ra,0xffffe
    80003efc:	014080e7          	jalr	20(ra) # 80001f0c <_ZN3SCBC1Em>
    80003f00:	00008797          	auipc	a5,0x8
    80003f04:	b897b423          	sd	s1,-1144(a5) # 8000ba88 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80003f08:	01800513          	li	a0,24
    80003f0c:	ffffe097          	auipc	ra,0xffffe
    80003f10:	1bc080e7          	jalr	444(ra) # 800020c8 <_ZN3SCBnwEm>
    80003f14:	00050493          	mv	s1,a0
    80003f18:	00000593          	li	a1,0
    80003f1c:	ffffe097          	auipc	ra,0xffffe
    80003f20:	ff0080e7          	jalr	-16(ra) # 80001f0c <_ZN3SCBC1Em>
    80003f24:	00008797          	auipc	a5,0x8
    80003f28:	b697b623          	sd	s1,-1172(a5) # 8000ba90 <_ZN11ConsoleUtil9outputSemE>
}
    80003f2c:	01813083          	ld	ra,24(sp)
    80003f30:	01013403          	ld	s0,16(sp)
    80003f34:	00813483          	ld	s1,8(sp)
    80003f38:	00013903          	ld	s2,0(sp)
    80003f3c:	02010113          	addi	sp,sp,32
    80003f40:	00008067          	ret
    80003f44:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80003f48:	00048513          	mv	a0,s1
    80003f4c:	ffffe097          	auipc	ra,0xffffe
    80003f50:	1a4080e7          	jalr	420(ra) # 800020f0 <_ZN3SCBdlEPv>
    80003f54:	00090513          	mv	a0,s2
    80003f58:	0000d097          	auipc	ra,0xd
    80003f5c:	c60080e7          	jalr	-928(ra) # 80010bb8 <_Unwind_Resume>
    80003f60:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80003f64:	00048513          	mv	a0,s1
    80003f68:	ffffe097          	auipc	ra,0xffffe
    80003f6c:	188080e7          	jalr	392(ra) # 800020f0 <_ZN3SCBdlEPv>
    80003f70:	00090513          	mv	a0,s2
    80003f74:	0000d097          	auipc	ra,0xd
    80003f78:	c44080e7          	jalr	-956(ra) # 80010bb8 <_Unwind_Resume>

0000000080003f7c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80003f7c:	00008697          	auipc	a3,0x8
    80003f80:	b0c68693          	addi	a3,a3,-1268 # 8000ba88 <_ZN11ConsoleUtil8inputSemE>
    80003f84:	0106b603          	ld	a2,16(a3)
    80003f88:	00160793          	addi	a5,a2,1
    80003f8c:	00002737          	lui	a4,0x2
    80003f90:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80003f94:	00e7f7b3          	and	a5,a5,a4
    80003f98:	0186b703          	ld	a4,24(a3)
    80003f9c:	04e78263          	beq	a5,a4,80003fe0 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80003fa0:	ff010113          	addi	sp,sp,-16
    80003fa4:	00113423          	sd	ra,8(sp)
    80003fa8:	00813023          	sd	s0,0(sp)
    80003fac:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80003fb0:	0000a717          	auipc	a4,0xa
    80003fb4:	b1070713          	addi	a4,a4,-1264 # 8000dac0 <_ZN11ConsoleUtil11inputBufferE>
    80003fb8:	00c70633          	add	a2,a4,a2
    80003fbc:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80003fc0:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    80003fc4:	0006b503          	ld	a0,0(a3)
    80003fc8:	ffffe097          	auipc	ra,0xffffe
    80003fcc:	0c4080e7          	jalr	196(ra) # 8000208c <_ZN3SCB6signalEv>
}
    80003fd0:	00813083          	ld	ra,8(sp)
    80003fd4:	00013403          	ld	s0,0(sp)
    80003fd8:	01010113          	addi	sp,sp,16
    80003fdc:	00008067          	ret
    80003fe0:	00008067          	ret

0000000080003fe4 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80003fe4:	fe010113          	addi	sp,sp,-32
    80003fe8:	00113c23          	sd	ra,24(sp)
    80003fec:	00813823          	sd	s0,16(sp)
    80003ff0:	00913423          	sd	s1,8(sp)
    80003ff4:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80003ff8:	00008497          	auipc	s1,0x8
    80003ffc:	a9048493          	addi	s1,s1,-1392 # 8000ba88 <_ZN11ConsoleUtil8inputSemE>
    80004000:	0004b503          	ld	a0,0(s1)
    80004004:	ffffe097          	auipc	ra,0xffffe
    80004008:	038080e7          	jalr	56(ra) # 8000203c <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    8000400c:	0184b783          	ld	a5,24(s1)
    80004010:	0104b703          	ld	a4,16(s1)
    80004014:	04e78063          	beq	a5,a4,80004054 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004018:	0000a717          	auipc	a4,0xa
    8000401c:	aa870713          	addi	a4,a4,-1368 # 8000dac0 <_ZN11ConsoleUtil11inputBufferE>
    80004020:	00f70733          	add	a4,a4,a5
    80004024:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004028:	00178793          	addi	a5,a5,1
    8000402c:	00002737          	lui	a4,0x2
    80004030:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004034:	00e7f7b3          	and	a5,a5,a4
    80004038:	00008717          	auipc	a4,0x8
    8000403c:	a6f73423          	sd	a5,-1432(a4) # 8000baa0 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004040:	01813083          	ld	ra,24(sp)
    80004044:	01013403          	ld	s0,16(sp)
    80004048:	00813483          	ld	s1,8(sp)
    8000404c:	02010113          	addi	sp,sp,32
    80004050:	00008067          	ret
        return -1;
    80004054:	0ff00513          	li	a0,255
    80004058:	fe9ff06f          	j	80004040 <_ZN11ConsoleUtil8getInputEv+0x5c>

000000008000405c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    8000405c:	00008797          	auipc	a5,0x8
    80004060:	a2c78793          	addi	a5,a5,-1492 # 8000ba88 <_ZN11ConsoleUtil8inputSemE>
    80004064:	0207b603          	ld	a2,32(a5)
    80004068:	00160713          	addi	a4,a2,1
    8000406c:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004070:	0287b583          	ld	a1,40(a5)
    80004074:	00158713          	addi	a4,a1,1
    80004078:	000026b7          	lui	a3,0x2
    8000407c:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004080:	00d77733          	and	a4,a4,a3
    80004084:	0307b783          	ld	a5,48(a5)
    80004088:	04f70863          	beq	a4,a5,800040d8 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    8000408c:	ff010113          	addi	sp,sp,-16
    80004090:	00113423          	sd	ra,8(sp)
    80004094:	00813023          	sd	s0,0(sp)
    80004098:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    8000409c:	00008797          	auipc	a5,0x8
    800040a0:	a2478793          	addi	a5,a5,-1500 # 8000bac0 <_ZN11ConsoleUtil12outputBufferE>
    800040a4:	00b785b3          	add	a1,a5,a1
    800040a8:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    800040ac:	00008797          	auipc	a5,0x8
    800040b0:	9dc78793          	addi	a5,a5,-1572 # 8000ba88 <_ZN11ConsoleUtil8inputSemE>
    800040b4:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    800040b8:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    800040bc:	0087b503          	ld	a0,8(a5)
    800040c0:	ffffe097          	auipc	ra,0xffffe
    800040c4:	fcc080e7          	jalr	-52(ra) # 8000208c <_ZN3SCB6signalEv>
}
    800040c8:	00813083          	ld	ra,8(sp)
    800040cc:	00013403          	ld	s0,0(sp)
    800040d0:	01010113          	addi	sp,sp,16
    800040d4:	00008067          	ret
    800040d8:	00008067          	ret

00000000800040dc <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    800040dc:	fe010113          	addi	sp,sp,-32
    800040e0:	00113c23          	sd	ra,24(sp)
    800040e4:	00813823          	sd	s0,16(sp)
    800040e8:	00913423          	sd	s1,8(sp)
    800040ec:	02010413          	addi	s0,sp,32
    outputSem->wait();
    800040f0:	00008497          	auipc	s1,0x8
    800040f4:	99848493          	addi	s1,s1,-1640 # 8000ba88 <_ZN11ConsoleUtil8inputSemE>
    800040f8:	0084b503          	ld	a0,8(s1)
    800040fc:	ffffe097          	auipc	ra,0xffffe
    80004100:	f40080e7          	jalr	-192(ra) # 8000203c <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004104:	0304b783          	ld	a5,48(s1)
    80004108:	0284b703          	ld	a4,40(s1)
    8000410c:	04e78063          	beq	a5,a4,8000414c <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004110:	00008717          	auipc	a4,0x8
    80004114:	9b070713          	addi	a4,a4,-1616 # 8000bac0 <_ZN11ConsoleUtil12outputBufferE>
    80004118:	00f70733          	add	a4,a4,a5
    8000411c:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004120:	00178793          	addi	a5,a5,1
    80004124:	00002737          	lui	a4,0x2
    80004128:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    8000412c:	00e7f7b3          	and	a5,a5,a4
    80004130:	00008717          	auipc	a4,0x8
    80004134:	98f73423          	sd	a5,-1656(a4) # 8000bab8 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004138:	01813083          	ld	ra,24(sp)
    8000413c:	01013403          	ld	s0,16(sp)
    80004140:	00813483          	ld	s1,8(sp)
    80004144:	02010113          	addi	sp,sp,32
    80004148:	00008067          	ret
        return -1;
    8000414c:	0ff00513          	li	a0,255
    80004150:	fe9ff06f          	j	80004138 <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004154 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004154:	fe010113          	addi	sp,sp,-32
    80004158:	00113c23          	sd	ra,24(sp)
    8000415c:	00813823          	sd	s0,16(sp)
    80004160:	00913423          	sd	s1,8(sp)
    80004164:	02010413          	addi	s0,sp,32
    80004168:	00050493          	mv	s1,a0
    while (*string != '\0')
    8000416c:	0004c503          	lbu	a0,0(s1)
    80004170:	00050a63          	beqz	a0,80004184 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004174:	00000097          	auipc	ra,0x0
    80004178:	ee8080e7          	jalr	-280(ra) # 8000405c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    8000417c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004180:	fedff06f          	j	8000416c <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004184:	01813083          	ld	ra,24(sp)
    80004188:	01013403          	ld	s0,16(sp)
    8000418c:	00813483          	ld	s1,8(sp)
    80004190:	02010113          	addi	sp,sp,32
    80004194:	00008067          	ret

0000000080004198 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004198:	fb010113          	addi	sp,sp,-80
    8000419c:	04113423          	sd	ra,72(sp)
    800041a0:	04813023          	sd	s0,64(sp)
    800041a4:	02913c23          	sd	s1,56(sp)
    800041a8:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800041ac:	00005797          	auipc	a5,0x5
    800041b0:	10c78793          	addi	a5,a5,268 # 800092b8 <CONSOLE_STATUS+0x2a8>
    800041b4:	0007b703          	ld	a4,0(a5)
    800041b8:	fce43423          	sd	a4,-56(s0)
    800041bc:	0087b703          	ld	a4,8(a5)
    800041c0:	fce43823          	sd	a4,-48(s0)
    800041c4:	0107c783          	lbu	a5,16(a5)
    800041c8:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800041cc:	00060463          	beqz	a2,800041d4 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    800041d0:	08054263          	bltz	a0,80004254 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800041d4:	0005051b          	sext.w	a0,a0
    neg = 0;
    800041d8:	00000813          	li	a6,0
    }

    i = 0;
    800041dc:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800041e0:	0005871b          	sext.w	a4,a1
    800041e4:	02b577bb          	remuw	a5,a0,a1
    800041e8:	00048693          	mv	a3,s1
    800041ec:	0014849b          	addiw	s1,s1,1
    800041f0:	02079793          	slli	a5,a5,0x20
    800041f4:	0207d793          	srli	a5,a5,0x20
    800041f8:	fe040613          	addi	a2,s0,-32
    800041fc:	00f607b3          	add	a5,a2,a5
    80004200:	fe87c603          	lbu	a2,-24(a5)
    80004204:	fe040793          	addi	a5,s0,-32
    80004208:	00d787b3          	add	a5,a5,a3
    8000420c:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004210:	0005061b          	sext.w	a2,a0
    80004214:	02b5553b          	divuw	a0,a0,a1
    80004218:	fce674e3          	bgeu	a2,a4,800041e0 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    8000421c:	00080c63          	beqz	a6,80004234 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004220:	fe040793          	addi	a5,s0,-32
    80004224:	009784b3          	add	s1,a5,s1
    80004228:	02d00793          	li	a5,45
    8000422c:	fcf48c23          	sb	a5,-40(s1)
    80004230:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004234:	fff4849b          	addiw	s1,s1,-1
    80004238:	0204c463          	bltz	s1,80004260 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    8000423c:	fe040793          	addi	a5,s0,-32
    80004240:	009787b3          	add	a5,a5,s1
    80004244:	fd87c503          	lbu	a0,-40(a5)
    80004248:	00000097          	auipc	ra,0x0
    8000424c:	e14080e7          	jalr	-492(ra) # 8000405c <_ZN11ConsoleUtil9putOutputEc>
    80004250:	fe5ff06f          	j	80004234 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004254:	40a0053b          	negw	a0,a0
        neg = 1;
    80004258:	00100813          	li	a6,1
        x = -xx;
    8000425c:	f81ff06f          	j	800041dc <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004260:	04813083          	ld	ra,72(sp)
    80004264:	04013403          	ld	s0,64(sp)
    80004268:	03813483          	ld	s1,56(sp)
    8000426c:	05010113          	addi	sp,sp,80
    80004270:	00008067          	ret

0000000080004274 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004274:	ff010113          	addi	sp,sp,-16
    80004278:	00813423          	sd	s0,8(sp)
    8000427c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004280:	04300513          	li	a0,67

    asm("ecall");
    80004284:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004288:	00050513          	mv	a0,a0

    return (char)status;
}
    8000428c:	0ff57513          	andi	a0,a0,255
    80004290:	00813403          	ld	s0,8(sp)
    80004294:	01010113          	addi	sp,sp,16
    80004298:	00008067          	ret

000000008000429c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000429c:	fd010113          	addi	sp,sp,-48
    800042a0:	02113423          	sd	ra,40(sp)
    800042a4:	02813023          	sd	s0,32(sp)
    800042a8:	00913c23          	sd	s1,24(sp)
    800042ac:	01213823          	sd	s2,16(sp)
    800042b0:	01313423          	sd	s3,8(sp)
    800042b4:	03010413          	addi	s0,sp,48
    800042b8:	00050493          	mv	s1,a0
    800042bc:	00058913          	mv	s2,a1
    800042c0:	0015879b          	addiw	a5,a1,1
    800042c4:	0007851b          	sext.w	a0,a5
    800042c8:	00f4a023          	sw	a5,0(s1)
    800042cc:	0004a823          	sw	zero,16(s1)
    800042d0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800042d4:	00251513          	slli	a0,a0,0x2
    800042d8:	ffffd097          	auipc	ra,0xffffd
    800042dc:	e7c080e7          	jalr	-388(ra) # 80001154 <_Z9mem_allocm>
    800042e0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800042e4:	01000513          	li	a0,16
    800042e8:	ffffe097          	auipc	ra,0xffffe
    800042ec:	6a4080e7          	jalr	1700(ra) # 8000298c <_Znwm>
    800042f0:	00050993          	mv	s3,a0
    800042f4:	00000593          	li	a1,0
    800042f8:	ffffe097          	auipc	ra,0xffffe
    800042fc:	78c080e7          	jalr	1932(ra) # 80002a84 <_ZN9SemaphoreC1Ej>
    80004300:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004304:	01000513          	li	a0,16
    80004308:	ffffe097          	auipc	ra,0xffffe
    8000430c:	684080e7          	jalr	1668(ra) # 8000298c <_Znwm>
    80004310:	00050993          	mv	s3,a0
    80004314:	00090593          	mv	a1,s2
    80004318:	ffffe097          	auipc	ra,0xffffe
    8000431c:	76c080e7          	jalr	1900(ra) # 80002a84 <_ZN9SemaphoreC1Ej>
    80004320:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004324:	01000513          	li	a0,16
    80004328:	ffffe097          	auipc	ra,0xffffe
    8000432c:	664080e7          	jalr	1636(ra) # 8000298c <_Znwm>
    80004330:	00050913          	mv	s2,a0
    80004334:	00100593          	li	a1,1
    80004338:	ffffe097          	auipc	ra,0xffffe
    8000433c:	74c080e7          	jalr	1868(ra) # 80002a84 <_ZN9SemaphoreC1Ej>
    80004340:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004344:	01000513          	li	a0,16
    80004348:	ffffe097          	auipc	ra,0xffffe
    8000434c:	644080e7          	jalr	1604(ra) # 8000298c <_Znwm>
    80004350:	00050913          	mv	s2,a0
    80004354:	00100593          	li	a1,1
    80004358:	ffffe097          	auipc	ra,0xffffe
    8000435c:	72c080e7          	jalr	1836(ra) # 80002a84 <_ZN9SemaphoreC1Ej>
    80004360:	0324b823          	sd	s2,48(s1)
}
    80004364:	02813083          	ld	ra,40(sp)
    80004368:	02013403          	ld	s0,32(sp)
    8000436c:	01813483          	ld	s1,24(sp)
    80004370:	01013903          	ld	s2,16(sp)
    80004374:	00813983          	ld	s3,8(sp)
    80004378:	03010113          	addi	sp,sp,48
    8000437c:	00008067          	ret
    80004380:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004384:	00098513          	mv	a0,s3
    80004388:	ffffe097          	auipc	ra,0xffffe
    8000438c:	654080e7          	jalr	1620(ra) # 800029dc <_ZdlPv>
    80004390:	00048513          	mv	a0,s1
    80004394:	0000d097          	auipc	ra,0xd
    80004398:	824080e7          	jalr	-2012(ra) # 80010bb8 <_Unwind_Resume>
    8000439c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800043a0:	00098513          	mv	a0,s3
    800043a4:	ffffe097          	auipc	ra,0xffffe
    800043a8:	638080e7          	jalr	1592(ra) # 800029dc <_ZdlPv>
    800043ac:	00048513          	mv	a0,s1
    800043b0:	0000d097          	auipc	ra,0xd
    800043b4:	808080e7          	jalr	-2040(ra) # 80010bb8 <_Unwind_Resume>
    800043b8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800043bc:	00090513          	mv	a0,s2
    800043c0:	ffffe097          	auipc	ra,0xffffe
    800043c4:	61c080e7          	jalr	1564(ra) # 800029dc <_ZdlPv>
    800043c8:	00048513          	mv	a0,s1
    800043cc:	0000c097          	auipc	ra,0xc
    800043d0:	7ec080e7          	jalr	2028(ra) # 80010bb8 <_Unwind_Resume>
    800043d4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800043d8:	00090513          	mv	a0,s2
    800043dc:	ffffe097          	auipc	ra,0xffffe
    800043e0:	600080e7          	jalr	1536(ra) # 800029dc <_ZdlPv>
    800043e4:	00048513          	mv	a0,s1
    800043e8:	0000c097          	auipc	ra,0xc
    800043ec:	7d0080e7          	jalr	2000(ra) # 80010bb8 <_Unwind_Resume>

00000000800043f0 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800043f0:	fe010113          	addi	sp,sp,-32
    800043f4:	00113c23          	sd	ra,24(sp)
    800043f8:	00813823          	sd	s0,16(sp)
    800043fc:	00913423          	sd	s1,8(sp)
    80004400:	01213023          	sd	s2,0(sp)
    80004404:	02010413          	addi	s0,sp,32
    80004408:	00050493          	mv	s1,a0
    8000440c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004410:	01853503          	ld	a0,24(a0)
    80004414:	ffffe097          	auipc	ra,0xffffe
    80004418:	6a8080e7          	jalr	1704(ra) # 80002abc <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000441c:	0304b503          	ld	a0,48(s1)
    80004420:	ffffe097          	auipc	ra,0xffffe
    80004424:	69c080e7          	jalr	1692(ra) # 80002abc <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004428:	0084b783          	ld	a5,8(s1)
    8000442c:	0144a703          	lw	a4,20(s1)
    80004430:	00271713          	slli	a4,a4,0x2
    80004434:	00e787b3          	add	a5,a5,a4
    80004438:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000443c:	0144a783          	lw	a5,20(s1)
    80004440:	0017879b          	addiw	a5,a5,1
    80004444:	0004a703          	lw	a4,0(s1)
    80004448:	02e7e7bb          	remw	a5,a5,a4
    8000444c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004450:	0304b503          	ld	a0,48(s1)
    80004454:	ffffe097          	auipc	ra,0xffffe
    80004458:	694080e7          	jalr	1684(ra) # 80002ae8 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000445c:	0204b503          	ld	a0,32(s1)
    80004460:	ffffe097          	auipc	ra,0xffffe
    80004464:	688080e7          	jalr	1672(ra) # 80002ae8 <_ZN9Semaphore6signalEv>

}
    80004468:	01813083          	ld	ra,24(sp)
    8000446c:	01013403          	ld	s0,16(sp)
    80004470:	00813483          	ld	s1,8(sp)
    80004474:	00013903          	ld	s2,0(sp)
    80004478:	02010113          	addi	sp,sp,32
    8000447c:	00008067          	ret

0000000080004480 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004480:	fe010113          	addi	sp,sp,-32
    80004484:	00113c23          	sd	ra,24(sp)
    80004488:	00813823          	sd	s0,16(sp)
    8000448c:	00913423          	sd	s1,8(sp)
    80004490:	01213023          	sd	s2,0(sp)
    80004494:	02010413          	addi	s0,sp,32
    80004498:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000449c:	02053503          	ld	a0,32(a0)
    800044a0:	ffffe097          	auipc	ra,0xffffe
    800044a4:	61c080e7          	jalr	1564(ra) # 80002abc <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800044a8:	0284b503          	ld	a0,40(s1)
    800044ac:	ffffe097          	auipc	ra,0xffffe
    800044b0:	610080e7          	jalr	1552(ra) # 80002abc <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800044b4:	0084b703          	ld	a4,8(s1)
    800044b8:	0104a783          	lw	a5,16(s1)
    800044bc:	00279693          	slli	a3,a5,0x2
    800044c0:	00d70733          	add	a4,a4,a3
    800044c4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800044c8:	0017879b          	addiw	a5,a5,1
    800044cc:	0004a703          	lw	a4,0(s1)
    800044d0:	02e7e7bb          	remw	a5,a5,a4
    800044d4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800044d8:	0284b503          	ld	a0,40(s1)
    800044dc:	ffffe097          	auipc	ra,0xffffe
    800044e0:	60c080e7          	jalr	1548(ra) # 80002ae8 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800044e4:	0184b503          	ld	a0,24(s1)
    800044e8:	ffffe097          	auipc	ra,0xffffe
    800044ec:	600080e7          	jalr	1536(ra) # 80002ae8 <_ZN9Semaphore6signalEv>

    return ret;
}
    800044f0:	00090513          	mv	a0,s2
    800044f4:	01813083          	ld	ra,24(sp)
    800044f8:	01013403          	ld	s0,16(sp)
    800044fc:	00813483          	ld	s1,8(sp)
    80004500:	00013903          	ld	s2,0(sp)
    80004504:	02010113          	addi	sp,sp,32
    80004508:	00008067          	ret

000000008000450c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000450c:	fe010113          	addi	sp,sp,-32
    80004510:	00113c23          	sd	ra,24(sp)
    80004514:	00813823          	sd	s0,16(sp)
    80004518:	00913423          	sd	s1,8(sp)
    8000451c:	01213023          	sd	s2,0(sp)
    80004520:	02010413          	addi	s0,sp,32
    80004524:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004528:	02853503          	ld	a0,40(a0)
    8000452c:	ffffe097          	auipc	ra,0xffffe
    80004530:	590080e7          	jalr	1424(ra) # 80002abc <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004534:	0304b503          	ld	a0,48(s1)
    80004538:	ffffe097          	auipc	ra,0xffffe
    8000453c:	584080e7          	jalr	1412(ra) # 80002abc <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004540:	0144a783          	lw	a5,20(s1)
    80004544:	0104a903          	lw	s2,16(s1)
    80004548:	0327ce63          	blt	a5,s2,80004584 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000454c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004550:	0304b503          	ld	a0,48(s1)
    80004554:	ffffe097          	auipc	ra,0xffffe
    80004558:	594080e7          	jalr	1428(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000455c:	0284b503          	ld	a0,40(s1)
    80004560:	ffffe097          	auipc	ra,0xffffe
    80004564:	588080e7          	jalr	1416(ra) # 80002ae8 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004568:	00090513          	mv	a0,s2
    8000456c:	01813083          	ld	ra,24(sp)
    80004570:	01013403          	ld	s0,16(sp)
    80004574:	00813483          	ld	s1,8(sp)
    80004578:	00013903          	ld	s2,0(sp)
    8000457c:	02010113          	addi	sp,sp,32
    80004580:	00008067          	ret
        ret = cap - head + tail;
    80004584:	0004a703          	lw	a4,0(s1)
    80004588:	4127093b          	subw	s2,a4,s2
    8000458c:	00f9093b          	addw	s2,s2,a5
    80004590:	fc1ff06f          	j	80004550 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004594 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004594:	fe010113          	addi	sp,sp,-32
    80004598:	00113c23          	sd	ra,24(sp)
    8000459c:	00813823          	sd	s0,16(sp)
    800045a0:	00913423          	sd	s1,8(sp)
    800045a4:	02010413          	addi	s0,sp,32
    800045a8:	00050493          	mv	s1,a0
    Console::putc('\n');
    800045ac:	00a00513          	li	a0,10
    800045b0:	ffffe097          	auipc	ra,0xffffe
    800045b4:	734080e7          	jalr	1844(ra) # 80002ce4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800045b8:	00005517          	auipc	a0,0x5
    800045bc:	d1850513          	addi	a0,a0,-744 # 800092d0 <CONSOLE_STATUS+0x2c0>
    800045c0:	ffffd097          	auipc	ra,0xffffd
    800045c4:	6a0080e7          	jalr	1696(ra) # 80001c60 <_Z11printStringPKc>
    while (getCnt()) {
    800045c8:	00048513          	mv	a0,s1
    800045cc:	00000097          	auipc	ra,0x0
    800045d0:	f40080e7          	jalr	-192(ra) # 8000450c <_ZN9BufferCPP6getCntEv>
    800045d4:	02050c63          	beqz	a0,8000460c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800045d8:	0084b783          	ld	a5,8(s1)
    800045dc:	0104a703          	lw	a4,16(s1)
    800045e0:	00271713          	slli	a4,a4,0x2
    800045e4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800045e8:	0007c503          	lbu	a0,0(a5)
    800045ec:	ffffe097          	auipc	ra,0xffffe
    800045f0:	6f8080e7          	jalr	1784(ra) # 80002ce4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800045f4:	0104a783          	lw	a5,16(s1)
    800045f8:	0017879b          	addiw	a5,a5,1
    800045fc:	0004a703          	lw	a4,0(s1)
    80004600:	02e7e7bb          	remw	a5,a5,a4
    80004604:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004608:	fc1ff06f          	j	800045c8 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000460c:	02100513          	li	a0,33
    80004610:	ffffe097          	auipc	ra,0xffffe
    80004614:	6d4080e7          	jalr	1748(ra) # 80002ce4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004618:	00a00513          	li	a0,10
    8000461c:	ffffe097          	auipc	ra,0xffffe
    80004620:	6c8080e7          	jalr	1736(ra) # 80002ce4 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004624:	0084b503          	ld	a0,8(s1)
    80004628:	ffffd097          	auipc	ra,0xffffd
    8000462c:	b5c080e7          	jalr	-1188(ra) # 80001184 <_Z8mem_freePv>
    delete itemAvailable;
    80004630:	0204b503          	ld	a0,32(s1)
    80004634:	00050863          	beqz	a0,80004644 <_ZN9BufferCPPD1Ev+0xb0>
    80004638:	00053783          	ld	a5,0(a0)
    8000463c:	0087b783          	ld	a5,8(a5)
    80004640:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004644:	0184b503          	ld	a0,24(s1)
    80004648:	00050863          	beqz	a0,80004658 <_ZN9BufferCPPD1Ev+0xc4>
    8000464c:	00053783          	ld	a5,0(a0)
    80004650:	0087b783          	ld	a5,8(a5)
    80004654:	000780e7          	jalr	a5
    delete mutexTail;
    80004658:	0304b503          	ld	a0,48(s1)
    8000465c:	00050863          	beqz	a0,8000466c <_ZN9BufferCPPD1Ev+0xd8>
    80004660:	00053783          	ld	a5,0(a0)
    80004664:	0087b783          	ld	a5,8(a5)
    80004668:	000780e7          	jalr	a5
    delete mutexHead;
    8000466c:	0284b503          	ld	a0,40(s1)
    80004670:	00050863          	beqz	a0,80004680 <_ZN9BufferCPPD1Ev+0xec>
    80004674:	00053783          	ld	a5,0(a0)
    80004678:	0087b783          	ld	a5,8(a5)
    8000467c:	000780e7          	jalr	a5
}
    80004680:	01813083          	ld	ra,24(sp)
    80004684:	01013403          	ld	s0,16(sp)
    80004688:	00813483          	ld	s1,8(sp)
    8000468c:	02010113          	addi	sp,sp,32
    80004690:	00008067          	ret

0000000080004694 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80004694:	fe010113          	addi	sp,sp,-32
    80004698:	00113c23          	sd	ra,24(sp)
    8000469c:	00813823          	sd	s0,16(sp)
    800046a0:	00913423          	sd	s1,8(sp)
    800046a4:	01213023          	sd	s2,0(sp)
    800046a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800046ac:	00000913          	li	s2,0
    800046b0:	0380006f          	j	800046e8 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800046b4:	ffffd097          	auipc	ra,0xffffd
    800046b8:	ba0080e7          	jalr	-1120(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800046bc:	00148493          	addi	s1,s1,1
    800046c0:	000027b7          	lui	a5,0x2
    800046c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800046c8:	0097ee63          	bltu	a5,s1,800046e4 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800046cc:	00000713          	li	a4,0
    800046d0:	000077b7          	lui	a5,0x7
    800046d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800046d8:	fce7eee3          	bltu	a5,a4,800046b4 <_Z11workerBodyAPv+0x20>
    800046dc:	00170713          	addi	a4,a4,1
    800046e0:	ff1ff06f          	j	800046d0 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800046e4:	00190913          	addi	s2,s2,1
    800046e8:	00900793          	li	a5,9
    800046ec:	0527e063          	bltu	a5,s2,8000472c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800046f0:	00005517          	auipc	a0,0x5
    800046f4:	bf850513          	addi	a0,a0,-1032 # 800092e8 <CONSOLE_STATUS+0x2d8>
    800046f8:	ffffd097          	auipc	ra,0xffffd
    800046fc:	568080e7          	jalr	1384(ra) # 80001c60 <_Z11printStringPKc>
    80004700:	00000613          	li	a2,0
    80004704:	00a00593          	li	a1,10
    80004708:	0009051b          	sext.w	a0,s2
    8000470c:	ffffd097          	auipc	ra,0xffffd
    80004710:	6ec080e7          	jalr	1772(ra) # 80001df8 <_Z8printIntiii>
    80004714:	00005517          	auipc	a0,0x5
    80004718:	9ac50513          	addi	a0,a0,-1620 # 800090c0 <CONSOLE_STATUS+0xb0>
    8000471c:	ffffd097          	auipc	ra,0xffffd
    80004720:	544080e7          	jalr	1348(ra) # 80001c60 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004724:	00000493          	li	s1,0
    80004728:	f99ff06f          	j	800046c0 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000472c:	00005517          	auipc	a0,0x5
    80004730:	bc450513          	addi	a0,a0,-1084 # 800092f0 <CONSOLE_STATUS+0x2e0>
    80004734:	ffffd097          	auipc	ra,0xffffd
    80004738:	52c080e7          	jalr	1324(ra) # 80001c60 <_Z11printStringPKc>
    finishedA = true;
    8000473c:	00100793          	li	a5,1
    80004740:	0000b717          	auipc	a4,0xb
    80004744:	38f70423          	sb	a5,904(a4) # 8000fac8 <finishedA>
}
    80004748:	01813083          	ld	ra,24(sp)
    8000474c:	01013403          	ld	s0,16(sp)
    80004750:	00813483          	ld	s1,8(sp)
    80004754:	00013903          	ld	s2,0(sp)
    80004758:	02010113          	addi	sp,sp,32
    8000475c:	00008067          	ret

0000000080004760 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80004760:	fe010113          	addi	sp,sp,-32
    80004764:	00113c23          	sd	ra,24(sp)
    80004768:	00813823          	sd	s0,16(sp)
    8000476c:	00913423          	sd	s1,8(sp)
    80004770:	01213023          	sd	s2,0(sp)
    80004774:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004778:	00000913          	li	s2,0
    8000477c:	0380006f          	j	800047b4 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004780:	ffffd097          	auipc	ra,0xffffd
    80004784:	ad4080e7          	jalr	-1324(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004788:	00148493          	addi	s1,s1,1
    8000478c:	000027b7          	lui	a5,0x2
    80004790:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004794:	0097ee63          	bltu	a5,s1,800047b0 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004798:	00000713          	li	a4,0
    8000479c:	000077b7          	lui	a5,0x7
    800047a0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800047a4:	fce7eee3          	bltu	a5,a4,80004780 <_Z11workerBodyBPv+0x20>
    800047a8:	00170713          	addi	a4,a4,1
    800047ac:	ff1ff06f          	j	8000479c <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800047b0:	00190913          	addi	s2,s2,1
    800047b4:	00f00793          	li	a5,15
    800047b8:	0527e063          	bltu	a5,s2,800047f8 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800047bc:	00005517          	auipc	a0,0x5
    800047c0:	b4450513          	addi	a0,a0,-1212 # 80009300 <CONSOLE_STATUS+0x2f0>
    800047c4:	ffffd097          	auipc	ra,0xffffd
    800047c8:	49c080e7          	jalr	1180(ra) # 80001c60 <_Z11printStringPKc>
    800047cc:	00000613          	li	a2,0
    800047d0:	00a00593          	li	a1,10
    800047d4:	0009051b          	sext.w	a0,s2
    800047d8:	ffffd097          	auipc	ra,0xffffd
    800047dc:	620080e7          	jalr	1568(ra) # 80001df8 <_Z8printIntiii>
    800047e0:	00005517          	auipc	a0,0x5
    800047e4:	8e050513          	addi	a0,a0,-1824 # 800090c0 <CONSOLE_STATUS+0xb0>
    800047e8:	ffffd097          	auipc	ra,0xffffd
    800047ec:	478080e7          	jalr	1144(ra) # 80001c60 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800047f0:	00000493          	li	s1,0
    800047f4:	f99ff06f          	j	8000478c <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    800047f8:	00005517          	auipc	a0,0x5
    800047fc:	b1050513          	addi	a0,a0,-1264 # 80009308 <CONSOLE_STATUS+0x2f8>
    80004800:	ffffd097          	auipc	ra,0xffffd
    80004804:	460080e7          	jalr	1120(ra) # 80001c60 <_Z11printStringPKc>
    finishedB = true;
    80004808:	00100793          	li	a5,1
    8000480c:	0000b717          	auipc	a4,0xb
    80004810:	2af70ea3          	sb	a5,701(a4) # 8000fac9 <finishedB>
    thread_dispatch();
    80004814:	ffffd097          	auipc	ra,0xffffd
    80004818:	a40080e7          	jalr	-1472(ra) # 80001254 <_Z15thread_dispatchv>
}
    8000481c:	01813083          	ld	ra,24(sp)
    80004820:	01013403          	ld	s0,16(sp)
    80004824:	00813483          	ld	s1,8(sp)
    80004828:	00013903          	ld	s2,0(sp)
    8000482c:	02010113          	addi	sp,sp,32
    80004830:	00008067          	ret

0000000080004834 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80004834:	fe010113          	addi	sp,sp,-32
    80004838:	00113c23          	sd	ra,24(sp)
    8000483c:	00813823          	sd	s0,16(sp)
    80004840:	00913423          	sd	s1,8(sp)
    80004844:	01213023          	sd	s2,0(sp)
    80004848:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    8000484c:	00053903          	ld	s2,0(a0)
    int i = 6;
    80004850:	00600493          	li	s1,6
    while (--i > 0) {
    80004854:	fff4849b          	addiw	s1,s1,-1
    80004858:	04905463          	blez	s1,800048a0 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    8000485c:	00005517          	auipc	a0,0x5
    80004860:	abc50513          	addi	a0,a0,-1348 # 80009318 <CONSOLE_STATUS+0x308>
    80004864:	ffffd097          	auipc	ra,0xffffd
    80004868:	3fc080e7          	jalr	1020(ra) # 80001c60 <_Z11printStringPKc>
        printInt(sleep_time);
    8000486c:	00000613          	li	a2,0
    80004870:	00a00593          	li	a1,10
    80004874:	0009051b          	sext.w	a0,s2
    80004878:	ffffd097          	auipc	ra,0xffffd
    8000487c:	580080e7          	jalr	1408(ra) # 80001df8 <_Z8printIntiii>
        printString(" !\n");
    80004880:	00005517          	auipc	a0,0x5
    80004884:	aa050513          	addi	a0,a0,-1376 # 80009320 <CONSOLE_STATUS+0x310>
    80004888:	ffffd097          	auipc	ra,0xffffd
    8000488c:	3d8080e7          	jalr	984(ra) # 80001c60 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80004890:	00090513          	mv	a0,s2
    80004894:	ffffd097          	auipc	ra,0xffffd
    80004898:	b44080e7          	jalr	-1212(ra) # 800013d8 <_Z10time_sleepm>
    while (--i > 0) {
    8000489c:	fb9ff06f          	j	80004854 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800048a0:	00a00793          	li	a5,10
    800048a4:	02f95933          	divu	s2,s2,a5
    800048a8:	fff90913          	addi	s2,s2,-1
    800048ac:	0000b797          	auipc	a5,0xb
    800048b0:	21c78793          	addi	a5,a5,540 # 8000fac8 <finishedA>
    800048b4:	01278933          	add	s2,a5,s2
    800048b8:	00100793          	li	a5,1
    800048bc:	00f90423          	sb	a5,8(s2)
}
    800048c0:	01813083          	ld	ra,24(sp)
    800048c4:	01013403          	ld	s0,16(sp)
    800048c8:	00813483          	ld	s1,8(sp)
    800048cc:	00013903          	ld	s2,0(sp)
    800048d0:	02010113          	addi	sp,sp,32
    800048d4:	00008067          	ret

00000000800048d8 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    800048d8:	fe010113          	addi	sp,sp,-32
    800048dc:	00113c23          	sd	ra,24(sp)
    800048e0:	00813823          	sd	s0,16(sp)
    800048e4:	00913423          	sd	s1,8(sp)
    800048e8:	01213023          	sd	s2,0(sp)
    800048ec:	02010413          	addi	s0,sp,32
    800048f0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800048f4:	00100793          	li	a5,1
    800048f8:	02a7f863          	bgeu	a5,a0,80004928 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800048fc:	00a00793          	li	a5,10
    80004900:	02f577b3          	remu	a5,a0,a5
    80004904:	02078e63          	beqz	a5,80004940 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004908:	fff48513          	addi	a0,s1,-1
    8000490c:	00000097          	auipc	ra,0x0
    80004910:	fcc080e7          	jalr	-52(ra) # 800048d8 <_Z9fibonaccim>
    80004914:	00050913          	mv	s2,a0
    80004918:	ffe48513          	addi	a0,s1,-2
    8000491c:	00000097          	auipc	ra,0x0
    80004920:	fbc080e7          	jalr	-68(ra) # 800048d8 <_Z9fibonaccim>
    80004924:	00a90533          	add	a0,s2,a0
}
    80004928:	01813083          	ld	ra,24(sp)
    8000492c:	01013403          	ld	s0,16(sp)
    80004930:	00813483          	ld	s1,8(sp)
    80004934:	00013903          	ld	s2,0(sp)
    80004938:	02010113          	addi	sp,sp,32
    8000493c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004940:	ffffd097          	auipc	ra,0xffffd
    80004944:	914080e7          	jalr	-1772(ra) # 80001254 <_Z15thread_dispatchv>
    80004948:	fc1ff06f          	j	80004908 <_Z9fibonaccim+0x30>

000000008000494c <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    8000494c:	fe010113          	addi	sp,sp,-32
    80004950:	00113c23          	sd	ra,24(sp)
    80004954:	00813823          	sd	s0,16(sp)
    80004958:	00913423          	sd	s1,8(sp)
    8000495c:	01213023          	sd	s2,0(sp)
    80004960:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004964:	00000493          	li	s1,0
    80004968:	0400006f          	j	800049a8 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000496c:	00005517          	auipc	a0,0x5
    80004970:	9bc50513          	addi	a0,a0,-1604 # 80009328 <CONSOLE_STATUS+0x318>
    80004974:	ffffd097          	auipc	ra,0xffffd
    80004978:	2ec080e7          	jalr	748(ra) # 80001c60 <_Z11printStringPKc>
    8000497c:	00000613          	li	a2,0
    80004980:	00a00593          	li	a1,10
    80004984:	00048513          	mv	a0,s1
    80004988:	ffffd097          	auipc	ra,0xffffd
    8000498c:	470080e7          	jalr	1136(ra) # 80001df8 <_Z8printIntiii>
    80004990:	00004517          	auipc	a0,0x4
    80004994:	73050513          	addi	a0,a0,1840 # 800090c0 <CONSOLE_STATUS+0xb0>
    80004998:	ffffd097          	auipc	ra,0xffffd
    8000499c:	2c8080e7          	jalr	712(ra) # 80001c60 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800049a0:	0014849b          	addiw	s1,s1,1
    800049a4:	0ff4f493          	andi	s1,s1,255
    800049a8:	00200793          	li	a5,2
    800049ac:	fc97f0e3          	bgeu	a5,s1,8000496c <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    800049b0:	00005517          	auipc	a0,0x5
    800049b4:	98050513          	addi	a0,a0,-1664 # 80009330 <CONSOLE_STATUS+0x320>
    800049b8:	ffffd097          	auipc	ra,0xffffd
    800049bc:	2a8080e7          	jalr	680(ra) # 80001c60 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800049c0:	00700313          	li	t1,7
    thread_dispatch();
    800049c4:	ffffd097          	auipc	ra,0xffffd
    800049c8:	890080e7          	jalr	-1904(ra) # 80001254 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800049cc:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800049d0:	00005517          	auipc	a0,0x5
    800049d4:	97050513          	addi	a0,a0,-1680 # 80009340 <CONSOLE_STATUS+0x330>
    800049d8:	ffffd097          	auipc	ra,0xffffd
    800049dc:	288080e7          	jalr	648(ra) # 80001c60 <_Z11printStringPKc>
    800049e0:	00000613          	li	a2,0
    800049e4:	00a00593          	li	a1,10
    800049e8:	0009051b          	sext.w	a0,s2
    800049ec:	ffffd097          	auipc	ra,0xffffd
    800049f0:	40c080e7          	jalr	1036(ra) # 80001df8 <_Z8printIntiii>
    800049f4:	00004517          	auipc	a0,0x4
    800049f8:	6cc50513          	addi	a0,a0,1740 # 800090c0 <CONSOLE_STATUS+0xb0>
    800049fc:	ffffd097          	auipc	ra,0xffffd
    80004a00:	264080e7          	jalr	612(ra) # 80001c60 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004a04:	00c00513          	li	a0,12
    80004a08:	00000097          	auipc	ra,0x0
    80004a0c:	ed0080e7          	jalr	-304(ra) # 800048d8 <_Z9fibonaccim>
    80004a10:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004a14:	00005517          	auipc	a0,0x5
    80004a18:	93450513          	addi	a0,a0,-1740 # 80009348 <CONSOLE_STATUS+0x338>
    80004a1c:	ffffd097          	auipc	ra,0xffffd
    80004a20:	244080e7          	jalr	580(ra) # 80001c60 <_Z11printStringPKc>
    80004a24:	00000613          	li	a2,0
    80004a28:	00a00593          	li	a1,10
    80004a2c:	0009051b          	sext.w	a0,s2
    80004a30:	ffffd097          	auipc	ra,0xffffd
    80004a34:	3c8080e7          	jalr	968(ra) # 80001df8 <_Z8printIntiii>
    80004a38:	00004517          	auipc	a0,0x4
    80004a3c:	68850513          	addi	a0,a0,1672 # 800090c0 <CONSOLE_STATUS+0xb0>
    80004a40:	ffffd097          	auipc	ra,0xffffd
    80004a44:	220080e7          	jalr	544(ra) # 80001c60 <_Z11printStringPKc>
    80004a48:	0400006f          	j	80004a88 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004a4c:	00005517          	auipc	a0,0x5
    80004a50:	8dc50513          	addi	a0,a0,-1828 # 80009328 <CONSOLE_STATUS+0x318>
    80004a54:	ffffd097          	auipc	ra,0xffffd
    80004a58:	20c080e7          	jalr	524(ra) # 80001c60 <_Z11printStringPKc>
    80004a5c:	00000613          	li	a2,0
    80004a60:	00a00593          	li	a1,10
    80004a64:	00048513          	mv	a0,s1
    80004a68:	ffffd097          	auipc	ra,0xffffd
    80004a6c:	390080e7          	jalr	912(ra) # 80001df8 <_Z8printIntiii>
    80004a70:	00004517          	auipc	a0,0x4
    80004a74:	65050513          	addi	a0,a0,1616 # 800090c0 <CONSOLE_STATUS+0xb0>
    80004a78:	ffffd097          	auipc	ra,0xffffd
    80004a7c:	1e8080e7          	jalr	488(ra) # 80001c60 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004a80:	0014849b          	addiw	s1,s1,1
    80004a84:	0ff4f493          	andi	s1,s1,255
    80004a88:	00500793          	li	a5,5
    80004a8c:	fc97f0e3          	bgeu	a5,s1,80004a4c <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80004a90:	00005517          	auipc	a0,0x5
    80004a94:	86050513          	addi	a0,a0,-1952 # 800092f0 <CONSOLE_STATUS+0x2e0>
    80004a98:	ffffd097          	auipc	ra,0xffffd
    80004a9c:	1c8080e7          	jalr	456(ra) # 80001c60 <_Z11printStringPKc>
    finishedC = true;
    80004aa0:	00100793          	li	a5,1
    80004aa4:	0000b717          	auipc	a4,0xb
    80004aa8:	02f70723          	sb	a5,46(a4) # 8000fad2 <finishedC>
    thread_dispatch();
    80004aac:	ffffc097          	auipc	ra,0xffffc
    80004ab0:	7a8080e7          	jalr	1960(ra) # 80001254 <_Z15thread_dispatchv>
}
    80004ab4:	01813083          	ld	ra,24(sp)
    80004ab8:	01013403          	ld	s0,16(sp)
    80004abc:	00813483          	ld	s1,8(sp)
    80004ac0:	00013903          	ld	s2,0(sp)
    80004ac4:	02010113          	addi	sp,sp,32
    80004ac8:	00008067          	ret

0000000080004acc <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80004acc:	fe010113          	addi	sp,sp,-32
    80004ad0:	00113c23          	sd	ra,24(sp)
    80004ad4:	00813823          	sd	s0,16(sp)
    80004ad8:	00913423          	sd	s1,8(sp)
    80004adc:	01213023          	sd	s2,0(sp)
    80004ae0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004ae4:	00a00493          	li	s1,10
    80004ae8:	0400006f          	j	80004b28 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004aec:	00005517          	auipc	a0,0x5
    80004af0:	86c50513          	addi	a0,a0,-1940 # 80009358 <CONSOLE_STATUS+0x348>
    80004af4:	ffffd097          	auipc	ra,0xffffd
    80004af8:	16c080e7          	jalr	364(ra) # 80001c60 <_Z11printStringPKc>
    80004afc:	00000613          	li	a2,0
    80004b00:	00a00593          	li	a1,10
    80004b04:	00048513          	mv	a0,s1
    80004b08:	ffffd097          	auipc	ra,0xffffd
    80004b0c:	2f0080e7          	jalr	752(ra) # 80001df8 <_Z8printIntiii>
    80004b10:	00004517          	auipc	a0,0x4
    80004b14:	5b050513          	addi	a0,a0,1456 # 800090c0 <CONSOLE_STATUS+0xb0>
    80004b18:	ffffd097          	auipc	ra,0xffffd
    80004b1c:	148080e7          	jalr	328(ra) # 80001c60 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004b20:	0014849b          	addiw	s1,s1,1
    80004b24:	0ff4f493          	andi	s1,s1,255
    80004b28:	00c00793          	li	a5,12
    80004b2c:	fc97f0e3          	bgeu	a5,s1,80004aec <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004b30:	00005517          	auipc	a0,0x5
    80004b34:	83050513          	addi	a0,a0,-2000 # 80009360 <CONSOLE_STATUS+0x350>
    80004b38:	ffffd097          	auipc	ra,0xffffd
    80004b3c:	128080e7          	jalr	296(ra) # 80001c60 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004b40:	00500313          	li	t1,5
    thread_dispatch();
    80004b44:	ffffc097          	auipc	ra,0xffffc
    80004b48:	710080e7          	jalr	1808(ra) # 80001254 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004b4c:	01000513          	li	a0,16
    80004b50:	00000097          	auipc	ra,0x0
    80004b54:	d88080e7          	jalr	-632(ra) # 800048d8 <_Z9fibonaccim>
    80004b58:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004b5c:	00005517          	auipc	a0,0x5
    80004b60:	81450513          	addi	a0,a0,-2028 # 80009370 <CONSOLE_STATUS+0x360>
    80004b64:	ffffd097          	auipc	ra,0xffffd
    80004b68:	0fc080e7          	jalr	252(ra) # 80001c60 <_Z11printStringPKc>
    80004b6c:	00000613          	li	a2,0
    80004b70:	00a00593          	li	a1,10
    80004b74:	0009051b          	sext.w	a0,s2
    80004b78:	ffffd097          	auipc	ra,0xffffd
    80004b7c:	280080e7          	jalr	640(ra) # 80001df8 <_Z8printIntiii>
    80004b80:	00004517          	auipc	a0,0x4
    80004b84:	54050513          	addi	a0,a0,1344 # 800090c0 <CONSOLE_STATUS+0xb0>
    80004b88:	ffffd097          	auipc	ra,0xffffd
    80004b8c:	0d8080e7          	jalr	216(ra) # 80001c60 <_Z11printStringPKc>
    80004b90:	0400006f          	j	80004bd0 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004b94:	00004517          	auipc	a0,0x4
    80004b98:	7c450513          	addi	a0,a0,1988 # 80009358 <CONSOLE_STATUS+0x348>
    80004b9c:	ffffd097          	auipc	ra,0xffffd
    80004ba0:	0c4080e7          	jalr	196(ra) # 80001c60 <_Z11printStringPKc>
    80004ba4:	00000613          	li	a2,0
    80004ba8:	00a00593          	li	a1,10
    80004bac:	00048513          	mv	a0,s1
    80004bb0:	ffffd097          	auipc	ra,0xffffd
    80004bb4:	248080e7          	jalr	584(ra) # 80001df8 <_Z8printIntiii>
    80004bb8:	00004517          	auipc	a0,0x4
    80004bbc:	50850513          	addi	a0,a0,1288 # 800090c0 <CONSOLE_STATUS+0xb0>
    80004bc0:	ffffd097          	auipc	ra,0xffffd
    80004bc4:	0a0080e7          	jalr	160(ra) # 80001c60 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004bc8:	0014849b          	addiw	s1,s1,1
    80004bcc:	0ff4f493          	andi	s1,s1,255
    80004bd0:	00f00793          	li	a5,15
    80004bd4:	fc97f0e3          	bgeu	a5,s1,80004b94 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004bd8:	00004517          	auipc	a0,0x4
    80004bdc:	7a850513          	addi	a0,a0,1960 # 80009380 <CONSOLE_STATUS+0x370>
    80004be0:	ffffd097          	auipc	ra,0xffffd
    80004be4:	080080e7          	jalr	128(ra) # 80001c60 <_Z11printStringPKc>
    finishedD = true;
    80004be8:	00100793          	li	a5,1
    80004bec:	0000b717          	auipc	a4,0xb
    80004bf0:	eef703a3          	sb	a5,-281(a4) # 8000fad3 <finishedD>
    thread_dispatch();
    80004bf4:	ffffc097          	auipc	ra,0xffffc
    80004bf8:	660080e7          	jalr	1632(ra) # 80001254 <_Z15thread_dispatchv>
}
    80004bfc:	01813083          	ld	ra,24(sp)
    80004c00:	01013403          	ld	s0,16(sp)
    80004c04:	00813483          	ld	s1,8(sp)
    80004c08:	00013903          	ld	s2,0(sp)
    80004c0c:	02010113          	addi	sp,sp,32
    80004c10:	00008067          	ret

0000000080004c14 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80004c14:	fc010113          	addi	sp,sp,-64
    80004c18:	02113c23          	sd	ra,56(sp)
    80004c1c:	02813823          	sd	s0,48(sp)
    80004c20:	02913423          	sd	s1,40(sp)
    80004c24:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004c28:	00000613          	li	a2,0
    80004c2c:	00000597          	auipc	a1,0x0
    80004c30:	a6858593          	addi	a1,a1,-1432 # 80004694 <_Z11workerBodyAPv>
    80004c34:	fc040513          	addi	a0,s0,-64
    80004c38:	ffffc097          	auipc	ra,0xffffc
    80004c3c:	578080e7          	jalr	1400(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80004c40:	00004517          	auipc	a0,0x4
    80004c44:	75050513          	addi	a0,a0,1872 # 80009390 <CONSOLE_STATUS+0x380>
    80004c48:	ffffd097          	auipc	ra,0xffffd
    80004c4c:	018080e7          	jalr	24(ra) # 80001c60 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004c50:	00000613          	li	a2,0
    80004c54:	00000597          	auipc	a1,0x0
    80004c58:	b0c58593          	addi	a1,a1,-1268 # 80004760 <_Z11workerBodyBPv>
    80004c5c:	fc840513          	addi	a0,s0,-56
    80004c60:	ffffc097          	auipc	ra,0xffffc
    80004c64:	550080e7          	jalr	1360(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004c68:	00004517          	auipc	a0,0x4
    80004c6c:	74050513          	addi	a0,a0,1856 # 800093a8 <CONSOLE_STATUS+0x398>
    80004c70:	ffffd097          	auipc	ra,0xffffd
    80004c74:	ff0080e7          	jalr	-16(ra) # 80001c60 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004c78:	00000613          	li	a2,0
    80004c7c:	00000597          	auipc	a1,0x0
    80004c80:	cd058593          	addi	a1,a1,-816 # 8000494c <_Z11workerBodyCPv>
    80004c84:	fd040513          	addi	a0,s0,-48
    80004c88:	ffffc097          	auipc	ra,0xffffc
    80004c8c:	528080e7          	jalr	1320(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80004c90:	00004517          	auipc	a0,0x4
    80004c94:	73050513          	addi	a0,a0,1840 # 800093c0 <CONSOLE_STATUS+0x3b0>
    80004c98:	ffffd097          	auipc	ra,0xffffd
    80004c9c:	fc8080e7          	jalr	-56(ra) # 80001c60 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80004ca0:	00000613          	li	a2,0
    80004ca4:	00000597          	auipc	a1,0x0
    80004ca8:	e2858593          	addi	a1,a1,-472 # 80004acc <_Z11workerBodyDPv>
    80004cac:	fd840513          	addi	a0,s0,-40
    80004cb0:	ffffc097          	auipc	ra,0xffffc
    80004cb4:	500080e7          	jalr	1280(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004cb8:	00004517          	auipc	a0,0x4
    80004cbc:	72050513          	addi	a0,a0,1824 # 800093d8 <CONSOLE_STATUS+0x3c8>
    80004cc0:	ffffd097          	auipc	ra,0xffffd
    80004cc4:	fa0080e7          	jalr	-96(ra) # 80001c60 <_Z11printStringPKc>
    80004cc8:	00c0006f          	j	80004cd4 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004ccc:	ffffc097          	auipc	ra,0xffffc
    80004cd0:	588080e7          	jalr	1416(ra) # 80001254 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004cd4:	0000b797          	auipc	a5,0xb
    80004cd8:	df47c783          	lbu	a5,-524(a5) # 8000fac8 <finishedA>
    80004cdc:	fe0788e3          	beqz	a5,80004ccc <_Z18Threads_C_API_testv+0xb8>
    80004ce0:	0000b797          	auipc	a5,0xb
    80004ce4:	de97c783          	lbu	a5,-535(a5) # 8000fac9 <finishedB>
    80004ce8:	fe0782e3          	beqz	a5,80004ccc <_Z18Threads_C_API_testv+0xb8>
    80004cec:	0000b797          	auipc	a5,0xb
    80004cf0:	de67c783          	lbu	a5,-538(a5) # 8000fad2 <finishedC>
    80004cf4:	fc078ce3          	beqz	a5,80004ccc <_Z18Threads_C_API_testv+0xb8>
    80004cf8:	0000b797          	auipc	a5,0xb
    80004cfc:	ddb7c783          	lbu	a5,-549(a5) # 8000fad3 <finishedD>
    80004d00:	fc0786e3          	beqz	a5,80004ccc <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80004d04:	fc040493          	addi	s1,s0,-64
    80004d08:	0080006f          	j	80004d10 <_Z18Threads_C_API_testv+0xfc>
    80004d0c:	00848493          	addi	s1,s1,8
    80004d10:	fe040793          	addi	a5,s0,-32
    80004d14:	00f48c63          	beq	s1,a5,80004d2c <_Z18Threads_C_API_testv+0x118>
    80004d18:	0004b503          	ld	a0,0(s1)
    80004d1c:	fe0508e3          	beqz	a0,80004d0c <_Z18Threads_C_API_testv+0xf8>
    80004d20:	ffffd097          	auipc	ra,0xffffd
    80004d24:	c9c080e7          	jalr	-868(ra) # 800019bc <_ZN7_threaddlEPv>
    80004d28:	fe5ff06f          	j	80004d0c <_Z18Threads_C_API_testv+0xf8>
}
    80004d2c:	03813083          	ld	ra,56(sp)
    80004d30:	03013403          	ld	s0,48(sp)
    80004d34:	02813483          	ld	s1,40(sp)
    80004d38:	04010113          	addi	sp,sp,64
    80004d3c:	00008067          	ret

0000000080004d40 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80004d40:	fd010113          	addi	sp,sp,-48
    80004d44:	02113423          	sd	ra,40(sp)
    80004d48:	02813023          	sd	s0,32(sp)
    80004d4c:	00913c23          	sd	s1,24(sp)
    80004d50:	01213823          	sd	s2,16(sp)
    80004d54:	01313423          	sd	s3,8(sp)
    80004d58:	03010413          	addi	s0,sp,48
    80004d5c:	00050993          	mv	s3,a0
    80004d60:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80004d64:	00000913          	li	s2,0
    80004d68:	00c0006f          	j	80004d74 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80004d6c:	ffffe097          	auipc	ra,0xffffe
    80004d70:	e8c080e7          	jalr	-372(ra) # 80002bf8 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80004d74:	ffffc097          	auipc	ra,0xffffc
    80004d78:	690080e7          	jalr	1680(ra) # 80001404 <_Z4getcv>
    80004d7c:	0005059b          	sext.w	a1,a0
    80004d80:	01b00793          	li	a5,27
    80004d84:	02f58a63          	beq	a1,a5,80004db8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80004d88:	0084b503          	ld	a0,8(s1)
    80004d8c:	fffff097          	auipc	ra,0xfffff
    80004d90:	664080e7          	jalr	1636(ra) # 800043f0 <_ZN9BufferCPP3putEi>
        i++;
    80004d94:	0019071b          	addiw	a4,s2,1
    80004d98:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004d9c:	0004a683          	lw	a3,0(s1)
    80004da0:	0026979b          	slliw	a5,a3,0x2
    80004da4:	00d787bb          	addw	a5,a5,a3
    80004da8:	0017979b          	slliw	a5,a5,0x1
    80004dac:	02f767bb          	remw	a5,a4,a5
    80004db0:	fc0792e3          	bnez	a5,80004d74 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80004db4:	fb9ff06f          	j	80004d6c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80004db8:	00100793          	li	a5,1
    80004dbc:	0000b717          	auipc	a4,0xb
    80004dc0:	d0f72c23          	sw	a5,-744(a4) # 8000fad4 <threadEnd>
    td->buffer->put('!');
    80004dc4:	0109b783          	ld	a5,16(s3)
    80004dc8:	02100593          	li	a1,33
    80004dcc:	0087b503          	ld	a0,8(a5)
    80004dd0:	fffff097          	auipc	ra,0xfffff
    80004dd4:	620080e7          	jalr	1568(ra) # 800043f0 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80004dd8:	0104b503          	ld	a0,16(s1)
    80004ddc:	ffffe097          	auipc	ra,0xffffe
    80004de0:	d0c080e7          	jalr	-756(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
}
    80004de4:	02813083          	ld	ra,40(sp)
    80004de8:	02013403          	ld	s0,32(sp)
    80004dec:	01813483          	ld	s1,24(sp)
    80004df0:	01013903          	ld	s2,16(sp)
    80004df4:	00813983          	ld	s3,8(sp)
    80004df8:	03010113          	addi	sp,sp,48
    80004dfc:	00008067          	ret

0000000080004e00 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    80004e00:	fe010113          	addi	sp,sp,-32
    80004e04:	00113c23          	sd	ra,24(sp)
    80004e08:	00813823          	sd	s0,16(sp)
    80004e0c:	00913423          	sd	s1,8(sp)
    80004e10:	01213023          	sd	s2,0(sp)
    80004e14:	02010413          	addi	s0,sp,32
    80004e18:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004e1c:	00000913          	li	s2,0
    80004e20:	00c0006f          	j	80004e2c <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80004e24:	ffffe097          	auipc	ra,0xffffe
    80004e28:	dd4080e7          	jalr	-556(ra) # 80002bf8 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80004e2c:	0000b797          	auipc	a5,0xb
    80004e30:	ca87a783          	lw	a5,-856(a5) # 8000fad4 <threadEnd>
    80004e34:	02079e63          	bnez	a5,80004e70 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80004e38:	0004a583          	lw	a1,0(s1)
    80004e3c:	0305859b          	addiw	a1,a1,48
    80004e40:	0084b503          	ld	a0,8(s1)
    80004e44:	fffff097          	auipc	ra,0xfffff
    80004e48:	5ac080e7          	jalr	1452(ra) # 800043f0 <_ZN9BufferCPP3putEi>
        i++;
    80004e4c:	0019071b          	addiw	a4,s2,1
    80004e50:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004e54:	0004a683          	lw	a3,0(s1)
    80004e58:	0026979b          	slliw	a5,a3,0x2
    80004e5c:	00d787bb          	addw	a5,a5,a3
    80004e60:	0017979b          	slliw	a5,a5,0x1
    80004e64:	02f767bb          	remw	a5,a4,a5
    80004e68:	fc0792e3          	bnez	a5,80004e2c <_ZN8Producer8producerEPv+0x2c>
    80004e6c:	fb9ff06f          	j	80004e24 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80004e70:	0104b503          	ld	a0,16(s1)
    80004e74:	ffffe097          	auipc	ra,0xffffe
    80004e78:	c74080e7          	jalr	-908(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
}
    80004e7c:	01813083          	ld	ra,24(sp)
    80004e80:	01013403          	ld	s0,16(sp)
    80004e84:	00813483          	ld	s1,8(sp)
    80004e88:	00013903          	ld	s2,0(sp)
    80004e8c:	02010113          	addi	sp,sp,32
    80004e90:	00008067          	ret

0000000080004e94 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    80004e94:	fd010113          	addi	sp,sp,-48
    80004e98:	02113423          	sd	ra,40(sp)
    80004e9c:	02813023          	sd	s0,32(sp)
    80004ea0:	00913c23          	sd	s1,24(sp)
    80004ea4:	01213823          	sd	s2,16(sp)
    80004ea8:	01313423          	sd	s3,8(sp)
    80004eac:	01413023          	sd	s4,0(sp)
    80004eb0:	03010413          	addi	s0,sp,48
    80004eb4:	00050993          	mv	s3,a0
    80004eb8:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004ebc:	00000a13          	li	s4,0
    80004ec0:	01c0006f          	j	80004edc <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80004ec4:	ffffe097          	auipc	ra,0xffffe
    80004ec8:	d34080e7          	jalr	-716(ra) # 80002bf8 <_ZN6Thread8dispatchEv>
    80004ecc:	0500006f          	j	80004f1c <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80004ed0:	00a00513          	li	a0,10
    80004ed4:	ffffc097          	auipc	ra,0xffffc
    80004ed8:	558080e7          	jalr	1368(ra) # 8000142c <_Z4putcc>
    while (!threadEnd) {
    80004edc:	0000b797          	auipc	a5,0xb
    80004ee0:	bf87a783          	lw	a5,-1032(a5) # 8000fad4 <threadEnd>
    80004ee4:	06079263          	bnez	a5,80004f48 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80004ee8:	00893503          	ld	a0,8(s2)
    80004eec:	fffff097          	auipc	ra,0xfffff
    80004ef0:	594080e7          	jalr	1428(ra) # 80004480 <_ZN9BufferCPP3getEv>
        i++;
    80004ef4:	001a049b          	addiw	s1,s4,1
    80004ef8:	00048a1b          	sext.w	s4,s1
        putc(key);
    80004efc:	0ff57513          	andi	a0,a0,255
    80004f00:	ffffc097          	auipc	ra,0xffffc
    80004f04:	52c080e7          	jalr	1324(ra) # 8000142c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80004f08:	00092703          	lw	a4,0(s2)
    80004f0c:	0027179b          	slliw	a5,a4,0x2
    80004f10:	00e787bb          	addw	a5,a5,a4
    80004f14:	02f4e7bb          	remw	a5,s1,a5
    80004f18:	fa0786e3          	beqz	a5,80004ec4 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    80004f1c:	05000793          	li	a5,80
    80004f20:	02f4e4bb          	remw	s1,s1,a5
    80004f24:	fa049ce3          	bnez	s1,80004edc <_ZN8Consumer8consumerEPv+0x48>
    80004f28:	fa9ff06f          	j	80004ed0 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80004f2c:	0109b783          	ld	a5,16(s3)
    80004f30:	0087b503          	ld	a0,8(a5)
    80004f34:	fffff097          	auipc	ra,0xfffff
    80004f38:	54c080e7          	jalr	1356(ra) # 80004480 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80004f3c:	0ff57513          	andi	a0,a0,255
    80004f40:	ffffe097          	auipc	ra,0xffffe
    80004f44:	da4080e7          	jalr	-604(ra) # 80002ce4 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80004f48:	0109b783          	ld	a5,16(s3)
    80004f4c:	0087b503          	ld	a0,8(a5)
    80004f50:	fffff097          	auipc	ra,0xfffff
    80004f54:	5bc080e7          	jalr	1468(ra) # 8000450c <_ZN9BufferCPP6getCntEv>
    80004f58:	fca04ae3          	bgtz	a0,80004f2c <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    80004f5c:	01093503          	ld	a0,16(s2)
    80004f60:	ffffe097          	auipc	ra,0xffffe
    80004f64:	b88080e7          	jalr	-1144(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
}
    80004f68:	02813083          	ld	ra,40(sp)
    80004f6c:	02013403          	ld	s0,32(sp)
    80004f70:	01813483          	ld	s1,24(sp)
    80004f74:	01013903          	ld	s2,16(sp)
    80004f78:	00813983          	ld	s3,8(sp)
    80004f7c:	00013a03          	ld	s4,0(sp)
    80004f80:	03010113          	addi	sp,sp,48
    80004f84:	00008067          	ret

0000000080004f88 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80004f88:	f8010113          	addi	sp,sp,-128
    80004f8c:	06113c23          	sd	ra,120(sp)
    80004f90:	06813823          	sd	s0,112(sp)
    80004f94:	06913423          	sd	s1,104(sp)
    80004f98:	07213023          	sd	s2,96(sp)
    80004f9c:	05313c23          	sd	s3,88(sp)
    80004fa0:	05413823          	sd	s4,80(sp)
    80004fa4:	05513423          	sd	s5,72(sp)
    80004fa8:	05613023          	sd	s6,64(sp)
    80004fac:	03713c23          	sd	s7,56(sp)
    80004fb0:	03813823          	sd	s8,48(sp)
    80004fb4:	03913423          	sd	s9,40(sp)
    80004fb8:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80004fbc:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80004fc0:	00004517          	auipc	a0,0x4
    80004fc4:	43050513          	addi	a0,a0,1072 # 800093f0 <CONSOLE_STATUS+0x3e0>
    80004fc8:	ffffd097          	auipc	ra,0xffffd
    80004fcc:	c98080e7          	jalr	-872(ra) # 80001c60 <_Z11printStringPKc>
    getString(input, 30);
    80004fd0:	01e00593          	li	a1,30
    80004fd4:	f8040493          	addi	s1,s0,-128
    80004fd8:	00048513          	mv	a0,s1
    80004fdc:	ffffd097          	auipc	ra,0xffffd
    80004fe0:	d00080e7          	jalr	-768(ra) # 80001cdc <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004fe4:	00048513          	mv	a0,s1
    80004fe8:	ffffd097          	auipc	ra,0xffffd
    80004fec:	dc0080e7          	jalr	-576(ra) # 80001da8 <_Z11stringToIntPKc>
    80004ff0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80004ff4:	00004517          	auipc	a0,0x4
    80004ff8:	41c50513          	addi	a0,a0,1052 # 80009410 <CONSOLE_STATUS+0x400>
    80004ffc:	ffffd097          	auipc	ra,0xffffd
    80005000:	c64080e7          	jalr	-924(ra) # 80001c60 <_Z11printStringPKc>
    getString(input, 30);
    80005004:	01e00593          	li	a1,30
    80005008:	00048513          	mv	a0,s1
    8000500c:	ffffd097          	auipc	ra,0xffffd
    80005010:	cd0080e7          	jalr	-816(ra) # 80001cdc <_Z9getStringPci>
    n = stringToInt(input);
    80005014:	00048513          	mv	a0,s1
    80005018:	ffffd097          	auipc	ra,0xffffd
    8000501c:	d90080e7          	jalr	-624(ra) # 80001da8 <_Z11stringToIntPKc>
    80005020:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005024:	00004517          	auipc	a0,0x4
    80005028:	40c50513          	addi	a0,a0,1036 # 80009430 <CONSOLE_STATUS+0x420>
    8000502c:	ffffd097          	auipc	ra,0xffffd
    80005030:	c34080e7          	jalr	-972(ra) # 80001c60 <_Z11printStringPKc>
    80005034:	00000613          	li	a2,0
    80005038:	00a00593          	li	a1,10
    8000503c:	00090513          	mv	a0,s2
    80005040:	ffffd097          	auipc	ra,0xffffd
    80005044:	db8080e7          	jalr	-584(ra) # 80001df8 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005048:	00004517          	auipc	a0,0x4
    8000504c:	40050513          	addi	a0,a0,1024 # 80009448 <CONSOLE_STATUS+0x438>
    80005050:	ffffd097          	auipc	ra,0xffffd
    80005054:	c10080e7          	jalr	-1008(ra) # 80001c60 <_Z11printStringPKc>
    80005058:	00000613          	li	a2,0
    8000505c:	00a00593          	li	a1,10
    80005060:	00048513          	mv	a0,s1
    80005064:	ffffd097          	auipc	ra,0xffffd
    80005068:	d94080e7          	jalr	-620(ra) # 80001df8 <_Z8printIntiii>
    printString(".\n");
    8000506c:	00004517          	auipc	a0,0x4
    80005070:	0bc50513          	addi	a0,a0,188 # 80009128 <CONSOLE_STATUS+0x118>
    80005074:	ffffd097          	auipc	ra,0xffffd
    80005078:	bec080e7          	jalr	-1044(ra) # 80001c60 <_Z11printStringPKc>
    if(threadNum > n) {
    8000507c:	0324c463          	blt	s1,s2,800050a4 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005080:	03205c63          	blez	s2,800050b8 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80005084:	03800513          	li	a0,56
    80005088:	ffffe097          	auipc	ra,0xffffe
    8000508c:	904080e7          	jalr	-1788(ra) # 8000298c <_Znwm>
    80005090:	00050a93          	mv	s5,a0
    80005094:	00048593          	mv	a1,s1
    80005098:	fffff097          	auipc	ra,0xfffff
    8000509c:	204080e7          	jalr	516(ra) # 8000429c <_ZN9BufferCPPC1Ei>
    800050a0:	0300006f          	j	800050d0 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800050a4:	00004517          	auipc	a0,0x4
    800050a8:	3bc50513          	addi	a0,a0,956 # 80009460 <CONSOLE_STATUS+0x450>
    800050ac:	ffffd097          	auipc	ra,0xffffd
    800050b0:	bb4080e7          	jalr	-1100(ra) # 80001c60 <_Z11printStringPKc>
        return;
    800050b4:	0140006f          	j	800050c8 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800050b8:	00004517          	auipc	a0,0x4
    800050bc:	3e850513          	addi	a0,a0,1000 # 800094a0 <CONSOLE_STATUS+0x490>
    800050c0:	ffffd097          	auipc	ra,0xffffd
    800050c4:	ba0080e7          	jalr	-1120(ra) # 80001c60 <_Z11printStringPKc>
        return;
    800050c8:	000b8113          	mv	sp,s7
    800050cc:	2400006f          	j	8000530c <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    800050d0:	01000513          	li	a0,16
    800050d4:	ffffe097          	auipc	ra,0xffffe
    800050d8:	8b8080e7          	jalr	-1864(ra) # 8000298c <_Znwm>
    800050dc:	00050493          	mv	s1,a0
    800050e0:	00000593          	li	a1,0
    800050e4:	ffffe097          	auipc	ra,0xffffe
    800050e8:	9a0080e7          	jalr	-1632(ra) # 80002a84 <_ZN9SemaphoreC1Ej>
    800050ec:	0000b717          	auipc	a4,0xb
    800050f0:	9dc70713          	addi	a4,a4,-1572 # 8000fac8 <finishedA>
    800050f4:	00973823          	sd	s1,16(a4)
    Thread* threads[threadNum];
    800050f8:	00391793          	slli	a5,s2,0x3
    800050fc:	00f78793          	addi	a5,a5,15
    80005100:	ff07f793          	andi	a5,a5,-16
    80005104:	40f10133          	sub	sp,sp,a5
    80005108:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    8000510c:	0019069b          	addiw	a3,s2,1
    80005110:	00169793          	slli	a5,a3,0x1
    80005114:	00d787b3          	add	a5,a5,a3
    80005118:	00379793          	slli	a5,a5,0x3
    8000511c:	00f78793          	addi	a5,a5,15
    80005120:	ff07f793          	andi	a5,a5,-16
    80005124:	40f10133          	sub	sp,sp,a5
    80005128:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000512c:	00191493          	slli	s1,s2,0x1
    80005130:	012487b3          	add	a5,s1,s2
    80005134:	00379793          	slli	a5,a5,0x3
    80005138:	00fa07b3          	add	a5,s4,a5
    8000513c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005140:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005144:	01073703          	ld	a4,16(a4)
    80005148:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    8000514c:	01800513          	li	a0,24
    80005150:	ffffe097          	auipc	ra,0xffffe
    80005154:	83c080e7          	jalr	-1988(ra) # 8000298c <_Znwm>
    80005158:	00050b13          	mv	s6,a0
    8000515c:	012484b3          	add	s1,s1,s2
    80005160:	00349493          	slli	s1,s1,0x3
    80005164:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    80005168:	ffffe097          	auipc	ra,0xffffe
    8000516c:	9e4080e7          	jalr	-1564(ra) # 80002b4c <_ZN6ThreadC1Ev>
    80005170:	00006797          	auipc	a5,0x6
    80005174:	62078793          	addi	a5,a5,1568 # 8000b790 <_ZTV8Consumer+0x10>
    80005178:	00fb3023          	sd	a5,0(s6)
    8000517c:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    80005180:	000b0513          	mv	a0,s6
    80005184:	ffffe097          	auipc	ra,0xffffe
    80005188:	a9c080e7          	jalr	-1380(ra) # 80002c20 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    8000518c:	00000493          	li	s1,0
    80005190:	0380006f          	j	800051c8 <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005194:	00006797          	auipc	a5,0x6
    80005198:	5d478793          	addi	a5,a5,1492 # 8000b768 <_ZTV8Producer+0x10>
    8000519c:	00fcb023          	sd	a5,0(s9)
    800051a0:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    800051a4:	00349793          	slli	a5,s1,0x3
    800051a8:	00f987b3          	add	a5,s3,a5
    800051ac:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800051b0:	00349793          	slli	a5,s1,0x3
    800051b4:	00f987b3          	add	a5,s3,a5
    800051b8:	0007b503          	ld	a0,0(a5)
    800051bc:	ffffe097          	auipc	ra,0xffffe
    800051c0:	a64080e7          	jalr	-1436(ra) # 80002c20 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800051c4:	0014849b          	addiw	s1,s1,1
    800051c8:	0b24d063          	bge	s1,s2,80005268 <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    800051cc:	00149793          	slli	a5,s1,0x1
    800051d0:	009787b3          	add	a5,a5,s1
    800051d4:	00379793          	slli	a5,a5,0x3
    800051d8:	00fa07b3          	add	a5,s4,a5
    800051dc:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800051e0:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800051e4:	0000b717          	auipc	a4,0xb
    800051e8:	8f473703          	ld	a4,-1804(a4) # 8000fad8 <waitForAll>
    800051ec:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800051f0:	02905863          	blez	s1,80005220 <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    800051f4:	01800513          	li	a0,24
    800051f8:	ffffd097          	auipc	ra,0xffffd
    800051fc:	794080e7          	jalr	1940(ra) # 8000298c <_Znwm>
    80005200:	00050c93          	mv	s9,a0
    80005204:	00149c13          	slli	s8,s1,0x1
    80005208:	009c0c33          	add	s8,s8,s1
    8000520c:	003c1c13          	slli	s8,s8,0x3
    80005210:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005214:	ffffe097          	auipc	ra,0xffffe
    80005218:	938080e7          	jalr	-1736(ra) # 80002b4c <_ZN6ThreadC1Ev>
    8000521c:	f79ff06f          	j	80005194 <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    80005220:	01800513          	li	a0,24
    80005224:	ffffd097          	auipc	ra,0xffffd
    80005228:	768080e7          	jalr	1896(ra) # 8000298c <_Znwm>
    8000522c:	00050c93          	mv	s9,a0
    80005230:	00149c13          	slli	s8,s1,0x1
    80005234:	009c0c33          	add	s8,s8,s1
    80005238:	003c1c13          	slli	s8,s8,0x3
    8000523c:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005240:	ffffe097          	auipc	ra,0xffffe
    80005244:	90c080e7          	jalr	-1780(ra) # 80002b4c <_ZN6ThreadC1Ev>
    80005248:	00006797          	auipc	a5,0x6
    8000524c:	4f878793          	addi	a5,a5,1272 # 8000b740 <_ZTV16ProducerKeyboard+0x10>
    80005250:	00fcb023          	sd	a5,0(s9)
    80005254:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005258:	00349793          	slli	a5,s1,0x3
    8000525c:	00f987b3          	add	a5,s3,a5
    80005260:	0197b023          	sd	s9,0(a5)
    80005264:	f4dff06f          	j	800051b0 <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    80005268:	ffffe097          	auipc	ra,0xffffe
    8000526c:	990080e7          	jalr	-1648(ra) # 80002bf8 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005270:	00000493          	li	s1,0
    80005274:	00994e63          	blt	s2,s1,80005290 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    80005278:	0000b517          	auipc	a0,0xb
    8000527c:	86053503          	ld	a0,-1952(a0) # 8000fad8 <waitForAll>
    80005280:	ffffe097          	auipc	ra,0xffffe
    80005284:	83c080e7          	jalr	-1988(ra) # 80002abc <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80005288:	0014849b          	addiw	s1,s1,1
    8000528c:	fe9ff06f          	j	80005274 <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    80005290:	00000493          	li	s1,0
    80005294:	0080006f          	j	8000529c <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    80005298:	0014849b          	addiw	s1,s1,1
    8000529c:	0324d263          	bge	s1,s2,800052c0 <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    800052a0:	00349793          	slli	a5,s1,0x3
    800052a4:	00f987b3          	add	a5,s3,a5
    800052a8:	0007b503          	ld	a0,0(a5)
    800052ac:	fe0506e3          	beqz	a0,80005298 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    800052b0:	00053783          	ld	a5,0(a0)
    800052b4:	0087b783          	ld	a5,8(a5)
    800052b8:	000780e7          	jalr	a5
    800052bc:	fddff06f          	j	80005298 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    800052c0:	000b0a63          	beqz	s6,800052d4 <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    800052c4:	000b3783          	ld	a5,0(s6)
    800052c8:	0087b783          	ld	a5,8(a5)
    800052cc:	000b0513          	mv	a0,s6
    800052d0:	000780e7          	jalr	a5
    delete waitForAll;
    800052d4:	0000b517          	auipc	a0,0xb
    800052d8:	80453503          	ld	a0,-2044(a0) # 8000fad8 <waitForAll>
    800052dc:	00050863          	beqz	a0,800052ec <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    800052e0:	00053783          	ld	a5,0(a0)
    800052e4:	0087b783          	ld	a5,8(a5)
    800052e8:	000780e7          	jalr	a5
    delete buffer;
    800052ec:	000a8e63          	beqz	s5,80005308 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    800052f0:	000a8513          	mv	a0,s5
    800052f4:	fffff097          	auipc	ra,0xfffff
    800052f8:	2a0080e7          	jalr	672(ra) # 80004594 <_ZN9BufferCPPD1Ev>
    800052fc:	000a8513          	mv	a0,s5
    80005300:	ffffd097          	auipc	ra,0xffffd
    80005304:	6dc080e7          	jalr	1756(ra) # 800029dc <_ZdlPv>
    80005308:	000b8113          	mv	sp,s7

}
    8000530c:	f8040113          	addi	sp,s0,-128
    80005310:	07813083          	ld	ra,120(sp)
    80005314:	07013403          	ld	s0,112(sp)
    80005318:	06813483          	ld	s1,104(sp)
    8000531c:	06013903          	ld	s2,96(sp)
    80005320:	05813983          	ld	s3,88(sp)
    80005324:	05013a03          	ld	s4,80(sp)
    80005328:	04813a83          	ld	s5,72(sp)
    8000532c:	04013b03          	ld	s6,64(sp)
    80005330:	03813b83          	ld	s7,56(sp)
    80005334:	03013c03          	ld	s8,48(sp)
    80005338:	02813c83          	ld	s9,40(sp)
    8000533c:	08010113          	addi	sp,sp,128
    80005340:	00008067          	ret
    80005344:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005348:	000a8513          	mv	a0,s5
    8000534c:	ffffd097          	auipc	ra,0xffffd
    80005350:	690080e7          	jalr	1680(ra) # 800029dc <_ZdlPv>
    80005354:	00048513          	mv	a0,s1
    80005358:	0000c097          	auipc	ra,0xc
    8000535c:	860080e7          	jalr	-1952(ra) # 80010bb8 <_Unwind_Resume>
    80005360:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80005364:	00048513          	mv	a0,s1
    80005368:	ffffd097          	auipc	ra,0xffffd
    8000536c:	674080e7          	jalr	1652(ra) # 800029dc <_ZdlPv>
    80005370:	00090513          	mv	a0,s2
    80005374:	0000c097          	auipc	ra,0xc
    80005378:	844080e7          	jalr	-1980(ra) # 80010bb8 <_Unwind_Resume>
    8000537c:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    80005380:	000b0513          	mv	a0,s6
    80005384:	ffffd097          	auipc	ra,0xffffd
    80005388:	658080e7          	jalr	1624(ra) # 800029dc <_ZdlPv>
    8000538c:	00048513          	mv	a0,s1
    80005390:	0000c097          	auipc	ra,0xc
    80005394:	828080e7          	jalr	-2008(ra) # 80010bb8 <_Unwind_Resume>
    80005398:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    8000539c:	000c8513          	mv	a0,s9
    800053a0:	ffffd097          	auipc	ra,0xffffd
    800053a4:	63c080e7          	jalr	1596(ra) # 800029dc <_ZdlPv>
    800053a8:	00048513          	mv	a0,s1
    800053ac:	0000c097          	auipc	ra,0xc
    800053b0:	80c080e7          	jalr	-2036(ra) # 80010bb8 <_Unwind_Resume>
    800053b4:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    800053b8:	000c8513          	mv	a0,s9
    800053bc:	ffffd097          	auipc	ra,0xffffd
    800053c0:	620080e7          	jalr	1568(ra) # 800029dc <_ZdlPv>
    800053c4:	00048513          	mv	a0,s1
    800053c8:	0000b097          	auipc	ra,0xb
    800053cc:	7f0080e7          	jalr	2032(ra) # 80010bb8 <_Unwind_Resume>

00000000800053d0 <_Z12testSleepingv>:

void testSleeping() {
    800053d0:	fc010113          	addi	sp,sp,-64
    800053d4:	02113c23          	sd	ra,56(sp)
    800053d8:	02813823          	sd	s0,48(sp)
    800053dc:	02913423          	sd	s1,40(sp)
    800053e0:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800053e4:	00a00793          	li	a5,10
    800053e8:	fcf43823          	sd	a5,-48(s0)
    800053ec:	01400793          	li	a5,20
    800053f0:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    800053f4:	00000493          	li	s1,0
    800053f8:	02c0006f          	j	80005424 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    800053fc:	00349793          	slli	a5,s1,0x3
    80005400:	fd040613          	addi	a2,s0,-48
    80005404:	00f60633          	add	a2,a2,a5
    80005408:	fffff597          	auipc	a1,0xfffff
    8000540c:	42c58593          	addi	a1,a1,1068 # 80004834 <_Z9sleepyRunPv>
    80005410:	fc040513          	addi	a0,s0,-64
    80005414:	00f50533          	add	a0,a0,a5
    80005418:	ffffc097          	auipc	ra,0xffffc
    8000541c:	d98080e7          	jalr	-616(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005420:	0014849b          	addiw	s1,s1,1
    80005424:	00100793          	li	a5,1
    80005428:	fc97dae3          	bge	a5,s1,800053fc <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    8000542c:	0000a797          	auipc	a5,0xa
    80005430:	6a47c783          	lbu	a5,1700(a5) # 8000fad0 <finished>
    80005434:	fe078ce3          	beqz	a5,8000542c <_Z12testSleepingv+0x5c>
    80005438:	0000a797          	auipc	a5,0xa
    8000543c:	6997c783          	lbu	a5,1689(a5) # 8000fad1 <finished+0x1>
    80005440:	fe0786e3          	beqz	a5,8000542c <_Z12testSleepingv+0x5c>
}
    80005444:	03813083          	ld	ra,56(sp)
    80005448:	03013403          	ld	s0,48(sp)
    8000544c:	02813483          	ld	s1,40(sp)
    80005450:	04010113          	addi	sp,sp,64
    80005454:	00008067          	ret

0000000080005458 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005458:	f8010113          	addi	sp,sp,-128
    8000545c:	06113c23          	sd	ra,120(sp)
    80005460:	06813823          	sd	s0,112(sp)
    80005464:	06913423          	sd	s1,104(sp)
    80005468:	07213023          	sd	s2,96(sp)
    8000546c:	05313c23          	sd	s3,88(sp)
    80005470:	05413823          	sd	s4,80(sp)
    80005474:	05513423          	sd	s5,72(sp)
    80005478:	05613023          	sd	s6,64(sp)
    8000547c:	03713c23          	sd	s7,56(sp)
    80005480:	03813823          	sd	s8,48(sp)
    80005484:	03913423          	sd	s9,40(sp)
    80005488:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000548c:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    80005490:	00004517          	auipc	a0,0x4
    80005494:	f6050513          	addi	a0,a0,-160 # 800093f0 <CONSOLE_STATUS+0x3e0>
    80005498:	ffffc097          	auipc	ra,0xffffc
    8000549c:	7c8080e7          	jalr	1992(ra) # 80001c60 <_Z11printStringPKc>
        getString(input, 30);
    800054a0:	01e00593          	li	a1,30
    800054a4:	f8040493          	addi	s1,s0,-128
    800054a8:	00048513          	mv	a0,s1
    800054ac:	ffffd097          	auipc	ra,0xffffd
    800054b0:	830080e7          	jalr	-2000(ra) # 80001cdc <_Z9getStringPci>
        threadNum = stringToInt(input);
    800054b4:	00048513          	mv	a0,s1
    800054b8:	ffffd097          	auipc	ra,0xffffd
    800054bc:	8f0080e7          	jalr	-1808(ra) # 80001da8 <_Z11stringToIntPKc>
    800054c0:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    800054c4:	00004517          	auipc	a0,0x4
    800054c8:	f4c50513          	addi	a0,a0,-180 # 80009410 <CONSOLE_STATUS+0x400>
    800054cc:	ffffc097          	auipc	ra,0xffffc
    800054d0:	794080e7          	jalr	1940(ra) # 80001c60 <_Z11printStringPKc>
        getString(input, 30);
    800054d4:	01e00593          	li	a1,30
    800054d8:	00048513          	mv	a0,s1
    800054dc:	ffffd097          	auipc	ra,0xffffd
    800054e0:	800080e7          	jalr	-2048(ra) # 80001cdc <_Z9getStringPci>
        n = stringToInt(input);
    800054e4:	00048513          	mv	a0,s1
    800054e8:	ffffd097          	auipc	ra,0xffffd
    800054ec:	8c0080e7          	jalr	-1856(ra) # 80001da8 <_Z11stringToIntPKc>
    800054f0:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    800054f4:	00004517          	auipc	a0,0x4
    800054f8:	f3c50513          	addi	a0,a0,-196 # 80009430 <CONSOLE_STATUS+0x420>
    800054fc:	ffffc097          	auipc	ra,0xffffc
    80005500:	764080e7          	jalr	1892(ra) # 80001c60 <_Z11printStringPKc>
    80005504:	00000613          	li	a2,0
    80005508:	00a00593          	li	a1,10
    8000550c:	00098513          	mv	a0,s3
    80005510:	ffffd097          	auipc	ra,0xffffd
    80005514:	8e8080e7          	jalr	-1816(ra) # 80001df8 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005518:	00004517          	auipc	a0,0x4
    8000551c:	f3050513          	addi	a0,a0,-208 # 80009448 <CONSOLE_STATUS+0x438>
    80005520:	ffffc097          	auipc	ra,0xffffc
    80005524:	740080e7          	jalr	1856(ra) # 80001c60 <_Z11printStringPKc>
    80005528:	00000613          	li	a2,0
    8000552c:	00a00593          	li	a1,10
    80005530:	00048513          	mv	a0,s1
    80005534:	ffffd097          	auipc	ra,0xffffd
    80005538:	8c4080e7          	jalr	-1852(ra) # 80001df8 <_Z8printIntiii>
        printString(".\n");
    8000553c:	00004517          	auipc	a0,0x4
    80005540:	bec50513          	addi	a0,a0,-1044 # 80009128 <CONSOLE_STATUS+0x118>
    80005544:	ffffc097          	auipc	ra,0xffffc
    80005548:	71c080e7          	jalr	1820(ra) # 80001c60 <_Z11printStringPKc>
        if(threadNum > n) {
    8000554c:	0334c463          	blt	s1,s3,80005574 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005550:	03305c63          	blez	s3,80005588 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005554:	03800513          	li	a0,56
    80005558:	ffffd097          	auipc	ra,0xffffd
    8000555c:	434080e7          	jalr	1076(ra) # 8000298c <_Znwm>
    80005560:	00050a93          	mv	s5,a0
    80005564:	00048593          	mv	a1,s1
    80005568:	fffff097          	auipc	ra,0xfffff
    8000556c:	d34080e7          	jalr	-716(ra) # 8000429c <_ZN9BufferCPPC1Ei>
    80005570:	0300006f          	j	800055a0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005574:	00004517          	auipc	a0,0x4
    80005578:	eec50513          	addi	a0,a0,-276 # 80009460 <CONSOLE_STATUS+0x450>
    8000557c:	ffffc097          	auipc	ra,0xffffc
    80005580:	6e4080e7          	jalr	1764(ra) # 80001c60 <_Z11printStringPKc>
            return;
    80005584:	0140006f          	j	80005598 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005588:	00004517          	auipc	a0,0x4
    8000558c:	f1850513          	addi	a0,a0,-232 # 800094a0 <CONSOLE_STATUS+0x490>
    80005590:	ffffc097          	auipc	ra,0xffffc
    80005594:	6d0080e7          	jalr	1744(ra) # 80001c60 <_Z11printStringPKc>
            return;
    80005598:	000c0113          	mv	sp,s8
    8000559c:	21c0006f          	j	800057b8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    800055a0:	01000513          	li	a0,16
    800055a4:	ffffd097          	auipc	ra,0xffffd
    800055a8:	3e8080e7          	jalr	1000(ra) # 8000298c <_Znwm>
    800055ac:	00050493          	mv	s1,a0
    800055b0:	00000593          	li	a1,0
    800055b4:	ffffd097          	auipc	ra,0xffffd
    800055b8:	4d0080e7          	jalr	1232(ra) # 80002a84 <_ZN9SemaphoreC1Ej>
    800055bc:	0000a717          	auipc	a4,0xa
    800055c0:	50c70713          	addi	a4,a4,1292 # 8000fac8 <finishedA>
    800055c4:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    800055c8:	00399793          	slli	a5,s3,0x3
    800055cc:	00f78793          	addi	a5,a5,15
    800055d0:	ff07f793          	andi	a5,a5,-16
    800055d4:	40f10133          	sub	sp,sp,a5
    800055d8:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    800055dc:	0019869b          	addiw	a3,s3,1
    800055e0:	00169793          	slli	a5,a3,0x1
    800055e4:	00d787b3          	add	a5,a5,a3
    800055e8:	00379793          	slli	a5,a5,0x3
    800055ec:	00f78793          	addi	a5,a5,15
    800055f0:	ff07f793          	andi	a5,a5,-16
    800055f4:	40f10133          	sub	sp,sp,a5
    800055f8:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    800055fc:	00199493          	slli	s1,s3,0x1
    80005600:	013484b3          	add	s1,s1,s3
    80005604:	00349493          	slli	s1,s1,0x3
    80005608:	009b04b3          	add	s1,s6,s1
    8000560c:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005610:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005614:	01873783          	ld	a5,24(a4)
    80005618:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000561c:	01800513          	li	a0,24
    80005620:	ffffd097          	auipc	ra,0xffffd
    80005624:	36c080e7          	jalr	876(ra) # 8000298c <_Znwm>
    80005628:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000562c:	ffffd097          	auipc	ra,0xffffd
    80005630:	520080e7          	jalr	1312(ra) # 80002b4c <_ZN6ThreadC1Ev>
    80005634:	00006797          	auipc	a5,0x6
    80005638:	1d478793          	addi	a5,a5,468 # 8000b808 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000563c:	00fbb023          	sd	a5,0(s7)
    80005640:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005644:	000b8513          	mv	a0,s7
    80005648:	ffffd097          	auipc	ra,0xffffd
    8000564c:	5d8080e7          	jalr	1496(ra) # 80002c20 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005650:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005654:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005658:	0000a797          	auipc	a5,0xa
    8000565c:	4887b783          	ld	a5,1160(a5) # 8000fae0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005660:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005664:	01800513          	li	a0,24
    80005668:	ffffd097          	auipc	ra,0xffffd
    8000566c:	324080e7          	jalr	804(ra) # 8000298c <_Znwm>
    80005670:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005674:	ffffd097          	auipc	ra,0xffffd
    80005678:	4d8080e7          	jalr	1240(ra) # 80002b4c <_ZN6ThreadC1Ev>
    8000567c:	00006797          	auipc	a5,0x6
    80005680:	13c78793          	addi	a5,a5,316 # 8000b7b8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005684:	00f4b023          	sd	a5,0(s1)
    80005688:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000568c:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80005690:	00048513          	mv	a0,s1
    80005694:	ffffd097          	auipc	ra,0xffffd
    80005698:	58c080e7          	jalr	1420(ra) # 80002c20 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000569c:	00100913          	li	s2,1
    800056a0:	0300006f          	j	800056d0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800056a4:	00006797          	auipc	a5,0x6
    800056a8:	13c78793          	addi	a5,a5,316 # 8000b7e0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800056ac:	00fcb023          	sd	a5,0(s9)
    800056b0:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    800056b4:	00391793          	slli	a5,s2,0x3
    800056b8:	00fa07b3          	add	a5,s4,a5
    800056bc:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    800056c0:	000c8513          	mv	a0,s9
    800056c4:	ffffd097          	auipc	ra,0xffffd
    800056c8:	55c080e7          	jalr	1372(ra) # 80002c20 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800056cc:	0019091b          	addiw	s2,s2,1
    800056d0:	05395263          	bge	s2,s3,80005714 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    800056d4:	00191493          	slli	s1,s2,0x1
    800056d8:	012484b3          	add	s1,s1,s2
    800056dc:	00349493          	slli	s1,s1,0x3
    800056e0:	009b04b3          	add	s1,s6,s1
    800056e4:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    800056e8:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    800056ec:	0000a797          	auipc	a5,0xa
    800056f0:	3f47b783          	ld	a5,1012(a5) # 8000fae0 <_ZN19ConsumerProducerCPP10waitForAllE>
    800056f4:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    800056f8:	01800513          	li	a0,24
    800056fc:	ffffd097          	auipc	ra,0xffffd
    80005700:	290080e7          	jalr	656(ra) # 8000298c <_Znwm>
    80005704:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005708:	ffffd097          	auipc	ra,0xffffd
    8000570c:	444080e7          	jalr	1092(ra) # 80002b4c <_ZN6ThreadC1Ev>
    80005710:	f95ff06f          	j	800056a4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80005714:	ffffd097          	auipc	ra,0xffffd
    80005718:	4e4080e7          	jalr	1252(ra) # 80002bf8 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000571c:	00000493          	li	s1,0
    80005720:	0099ce63          	blt	s3,s1,8000573c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80005724:	0000a517          	auipc	a0,0xa
    80005728:	3bc53503          	ld	a0,956(a0) # 8000fae0 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000572c:	ffffd097          	auipc	ra,0xffffd
    80005730:	390080e7          	jalr	912(ra) # 80002abc <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80005734:	0014849b          	addiw	s1,s1,1
    80005738:	fe9ff06f          	j	80005720 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    8000573c:	0000a517          	auipc	a0,0xa
    80005740:	3a453503          	ld	a0,932(a0) # 8000fae0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005744:	00050863          	beqz	a0,80005754 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80005748:	00053783          	ld	a5,0(a0)
    8000574c:	0087b783          	ld	a5,8(a5)
    80005750:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80005754:	00000493          	li	s1,0
    80005758:	0080006f          	j	80005760 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    8000575c:	0014849b          	addiw	s1,s1,1
    80005760:	0334d263          	bge	s1,s3,80005784 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80005764:	00349793          	slli	a5,s1,0x3
    80005768:	00fa07b3          	add	a5,s4,a5
    8000576c:	0007b503          	ld	a0,0(a5)
    80005770:	fe0506e3          	beqz	a0,8000575c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80005774:	00053783          	ld	a5,0(a0)
    80005778:	0087b783          	ld	a5,8(a5)
    8000577c:	000780e7          	jalr	a5
    80005780:	fddff06f          	j	8000575c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    80005784:	000b8a63          	beqz	s7,80005798 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    80005788:	000bb783          	ld	a5,0(s7)
    8000578c:	0087b783          	ld	a5,8(a5)
    80005790:	000b8513          	mv	a0,s7
    80005794:	000780e7          	jalr	a5
        delete buffer;
    80005798:	000a8e63          	beqz	s5,800057b4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    8000579c:	000a8513          	mv	a0,s5
    800057a0:	fffff097          	auipc	ra,0xfffff
    800057a4:	df4080e7          	jalr	-524(ra) # 80004594 <_ZN9BufferCPPD1Ev>
    800057a8:	000a8513          	mv	a0,s5
    800057ac:	ffffd097          	auipc	ra,0xffffd
    800057b0:	230080e7          	jalr	560(ra) # 800029dc <_ZdlPv>
    800057b4:	000c0113          	mv	sp,s8
    }
    800057b8:	f8040113          	addi	sp,s0,-128
    800057bc:	07813083          	ld	ra,120(sp)
    800057c0:	07013403          	ld	s0,112(sp)
    800057c4:	06813483          	ld	s1,104(sp)
    800057c8:	06013903          	ld	s2,96(sp)
    800057cc:	05813983          	ld	s3,88(sp)
    800057d0:	05013a03          	ld	s4,80(sp)
    800057d4:	04813a83          	ld	s5,72(sp)
    800057d8:	04013b03          	ld	s6,64(sp)
    800057dc:	03813b83          	ld	s7,56(sp)
    800057e0:	03013c03          	ld	s8,48(sp)
    800057e4:	02813c83          	ld	s9,40(sp)
    800057e8:	08010113          	addi	sp,sp,128
    800057ec:	00008067          	ret
    800057f0:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    800057f4:	000a8513          	mv	a0,s5
    800057f8:	ffffd097          	auipc	ra,0xffffd
    800057fc:	1e4080e7          	jalr	484(ra) # 800029dc <_ZdlPv>
    80005800:	00048513          	mv	a0,s1
    80005804:	0000b097          	auipc	ra,0xb
    80005808:	3b4080e7          	jalr	948(ra) # 80010bb8 <_Unwind_Resume>
    8000580c:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80005810:	00048513          	mv	a0,s1
    80005814:	ffffd097          	auipc	ra,0xffffd
    80005818:	1c8080e7          	jalr	456(ra) # 800029dc <_ZdlPv>
    8000581c:	00090513          	mv	a0,s2
    80005820:	0000b097          	auipc	ra,0xb
    80005824:	398080e7          	jalr	920(ra) # 80010bb8 <_Unwind_Resume>
    80005828:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000582c:	000b8513          	mv	a0,s7
    80005830:	ffffd097          	auipc	ra,0xffffd
    80005834:	1ac080e7          	jalr	428(ra) # 800029dc <_ZdlPv>
    80005838:	00048513          	mv	a0,s1
    8000583c:	0000b097          	auipc	ra,0xb
    80005840:	37c080e7          	jalr	892(ra) # 80010bb8 <_Unwind_Resume>
    80005844:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005848:	00048513          	mv	a0,s1
    8000584c:	ffffd097          	auipc	ra,0xffffd
    80005850:	190080e7          	jalr	400(ra) # 800029dc <_ZdlPv>
    80005854:	00090513          	mv	a0,s2
    80005858:	0000b097          	auipc	ra,0xb
    8000585c:	360080e7          	jalr	864(ra) # 80010bb8 <_Unwind_Resume>
    80005860:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80005864:	000c8513          	mv	a0,s9
    80005868:	ffffd097          	auipc	ra,0xffffd
    8000586c:	174080e7          	jalr	372(ra) # 800029dc <_ZdlPv>
    80005870:	00048513          	mv	a0,s1
    80005874:	0000b097          	auipc	ra,0xb
    80005878:	344080e7          	jalr	836(ra) # 80010bb8 <_Unwind_Resume>

000000008000587c <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    8000587c:	ff010113          	addi	sp,sp,-16
    80005880:	00813423          	sd	s0,8(sp)
    80005884:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    80005888:	00813403          	ld	s0,8(sp)
    8000588c:	01010113          	addi	sp,sp,16
    80005890:	00008067          	ret

0000000080005894 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80005894:	fe010113          	addi	sp,sp,-32
    80005898:	00113c23          	sd	ra,24(sp)
    8000589c:	00813823          	sd	s0,16(sp)
    800058a0:	00913423          	sd	s1,8(sp)
    800058a4:	02010413          	addi	s0,sp,32
    800058a8:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    800058ac:	ffffc097          	auipc	ra,0xffffc
    800058b0:	b58080e7          	jalr	-1192(ra) # 80001404 <_Z4getcv>
    800058b4:	0005059b          	sext.w	a1,a0
    800058b8:	01b00793          	li	a5,27
    800058bc:	00f58c63          	beq	a1,a5,800058d4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    800058c0:	0104b783          	ld	a5,16(s1)
    800058c4:	0087b503          	ld	a0,8(a5)
    800058c8:	fffff097          	auipc	ra,0xfffff
    800058cc:	b28080e7          	jalr	-1240(ra) # 800043f0 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    800058d0:	fddff06f          	j	800058ac <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    800058d4:	00100793          	li	a5,1
    800058d8:	0000a717          	auipc	a4,0xa
    800058dc:	1ef72a23          	sw	a5,500(a4) # 8000facc <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    800058e0:	0104b783          	ld	a5,16(s1)
    800058e4:	02100593          	li	a1,33
    800058e8:	0087b503          	ld	a0,8(a5)
    800058ec:	fffff097          	auipc	ra,0xfffff
    800058f0:	b04080e7          	jalr	-1276(ra) # 800043f0 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    800058f4:	0104b783          	ld	a5,16(s1)
    800058f8:	0107b503          	ld	a0,16(a5)
    800058fc:	ffffd097          	auipc	ra,0xffffd
    80005900:	1ec080e7          	jalr	492(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
        }
    80005904:	01813083          	ld	ra,24(sp)
    80005908:	01013403          	ld	s0,16(sp)
    8000590c:	00813483          	ld	s1,8(sp)
    80005910:	02010113          	addi	sp,sp,32
    80005914:	00008067          	ret

0000000080005918 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80005918:	fd010113          	addi	sp,sp,-48
    8000591c:	02113423          	sd	ra,40(sp)
    80005920:	02813023          	sd	s0,32(sp)
    80005924:	00913c23          	sd	s1,24(sp)
    80005928:	01213823          	sd	s2,16(sp)
    8000592c:	01313423          	sd	s3,8(sp)
    80005930:	03010413          	addi	s0,sp,48
    80005934:	00050913          	mv	s2,a0
            int i = 0;
    80005938:	00000993          	li	s3,0
    8000593c:	0100006f          	j	8000594c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80005940:	00a00513          	li	a0,10
    80005944:	ffffd097          	auipc	ra,0xffffd
    80005948:	3a0080e7          	jalr	928(ra) # 80002ce4 <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000594c:	0000a797          	auipc	a5,0xa
    80005950:	1807a783          	lw	a5,384(a5) # 8000facc <_ZN19ConsumerProducerCPP9threadEndE>
    80005954:	04079a63          	bnez	a5,800059a8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80005958:	01093783          	ld	a5,16(s2)
    8000595c:	0087b503          	ld	a0,8(a5)
    80005960:	fffff097          	auipc	ra,0xfffff
    80005964:	b20080e7          	jalr	-1248(ra) # 80004480 <_ZN9BufferCPP3getEv>
                i++;
    80005968:	0019849b          	addiw	s1,s3,1
    8000596c:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80005970:	0ff57513          	andi	a0,a0,255
    80005974:	ffffd097          	auipc	ra,0xffffd
    80005978:	370080e7          	jalr	880(ra) # 80002ce4 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000597c:	05000793          	li	a5,80
    80005980:	02f4e4bb          	remw	s1,s1,a5
    80005984:	fc0494e3          	bnez	s1,8000594c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80005988:	fb9ff06f          	j	80005940 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    8000598c:	01093783          	ld	a5,16(s2)
    80005990:	0087b503          	ld	a0,8(a5)
    80005994:	fffff097          	auipc	ra,0xfffff
    80005998:	aec080e7          	jalr	-1300(ra) # 80004480 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    8000599c:	0ff57513          	andi	a0,a0,255
    800059a0:	ffffd097          	auipc	ra,0xffffd
    800059a4:	344080e7          	jalr	836(ra) # 80002ce4 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    800059a8:	01093783          	ld	a5,16(s2)
    800059ac:	0087b503          	ld	a0,8(a5)
    800059b0:	fffff097          	auipc	ra,0xfffff
    800059b4:	b5c080e7          	jalr	-1188(ra) # 8000450c <_ZN9BufferCPP6getCntEv>
    800059b8:	fca04ae3          	bgtz	a0,8000598c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    800059bc:	01093783          	ld	a5,16(s2)
    800059c0:	0107b503          	ld	a0,16(a5)
    800059c4:	ffffd097          	auipc	ra,0xffffd
    800059c8:	124080e7          	jalr	292(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
        }
    800059cc:	02813083          	ld	ra,40(sp)
    800059d0:	02013403          	ld	s0,32(sp)
    800059d4:	01813483          	ld	s1,24(sp)
    800059d8:	01013903          	ld	s2,16(sp)
    800059dc:	00813983          	ld	s3,8(sp)
    800059e0:	03010113          	addi	sp,sp,48
    800059e4:	00008067          	ret

00000000800059e8 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    800059e8:	ff010113          	addi	sp,sp,-16
    800059ec:	00113423          	sd	ra,8(sp)
    800059f0:	00813023          	sd	s0,0(sp)
    800059f4:	01010413          	addi	s0,sp,16
    800059f8:	00006797          	auipc	a5,0x6
    800059fc:	d9878793          	addi	a5,a5,-616 # 8000b790 <_ZTV8Consumer+0x10>
    80005a00:	00f53023          	sd	a5,0(a0)
    80005a04:	ffffd097          	auipc	ra,0xffffd
    80005a08:	f48080e7          	jalr	-184(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005a0c:	00813083          	ld	ra,8(sp)
    80005a10:	00013403          	ld	s0,0(sp)
    80005a14:	01010113          	addi	sp,sp,16
    80005a18:	00008067          	ret

0000000080005a1c <_ZN8ConsumerD0Ev>:
    80005a1c:	fe010113          	addi	sp,sp,-32
    80005a20:	00113c23          	sd	ra,24(sp)
    80005a24:	00813823          	sd	s0,16(sp)
    80005a28:	00913423          	sd	s1,8(sp)
    80005a2c:	02010413          	addi	s0,sp,32
    80005a30:	00050493          	mv	s1,a0
    80005a34:	00006797          	auipc	a5,0x6
    80005a38:	d5c78793          	addi	a5,a5,-676 # 8000b790 <_ZTV8Consumer+0x10>
    80005a3c:	00f53023          	sd	a5,0(a0)
    80005a40:	ffffd097          	auipc	ra,0xffffd
    80005a44:	f0c080e7          	jalr	-244(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005a48:	00048513          	mv	a0,s1
    80005a4c:	ffffd097          	auipc	ra,0xffffd
    80005a50:	f90080e7          	jalr	-112(ra) # 800029dc <_ZdlPv>
    80005a54:	01813083          	ld	ra,24(sp)
    80005a58:	01013403          	ld	s0,16(sp)
    80005a5c:	00813483          	ld	s1,8(sp)
    80005a60:	02010113          	addi	sp,sp,32
    80005a64:	00008067          	ret

0000000080005a68 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80005a68:	ff010113          	addi	sp,sp,-16
    80005a6c:	00113423          	sd	ra,8(sp)
    80005a70:	00813023          	sd	s0,0(sp)
    80005a74:	01010413          	addi	s0,sp,16
    80005a78:	00006797          	auipc	a5,0x6
    80005a7c:	cf078793          	addi	a5,a5,-784 # 8000b768 <_ZTV8Producer+0x10>
    80005a80:	00f53023          	sd	a5,0(a0)
    80005a84:	ffffd097          	auipc	ra,0xffffd
    80005a88:	ec8080e7          	jalr	-312(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005a8c:	00813083          	ld	ra,8(sp)
    80005a90:	00013403          	ld	s0,0(sp)
    80005a94:	01010113          	addi	sp,sp,16
    80005a98:	00008067          	ret

0000000080005a9c <_ZN8ProducerD0Ev>:
    80005a9c:	fe010113          	addi	sp,sp,-32
    80005aa0:	00113c23          	sd	ra,24(sp)
    80005aa4:	00813823          	sd	s0,16(sp)
    80005aa8:	00913423          	sd	s1,8(sp)
    80005aac:	02010413          	addi	s0,sp,32
    80005ab0:	00050493          	mv	s1,a0
    80005ab4:	00006797          	auipc	a5,0x6
    80005ab8:	cb478793          	addi	a5,a5,-844 # 8000b768 <_ZTV8Producer+0x10>
    80005abc:	00f53023          	sd	a5,0(a0)
    80005ac0:	ffffd097          	auipc	ra,0xffffd
    80005ac4:	e8c080e7          	jalr	-372(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005ac8:	00048513          	mv	a0,s1
    80005acc:	ffffd097          	auipc	ra,0xffffd
    80005ad0:	f10080e7          	jalr	-240(ra) # 800029dc <_ZdlPv>
    80005ad4:	01813083          	ld	ra,24(sp)
    80005ad8:	01013403          	ld	s0,16(sp)
    80005adc:	00813483          	ld	s1,8(sp)
    80005ae0:	02010113          	addi	sp,sp,32
    80005ae4:	00008067          	ret

0000000080005ae8 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80005ae8:	ff010113          	addi	sp,sp,-16
    80005aec:	00113423          	sd	ra,8(sp)
    80005af0:	00813023          	sd	s0,0(sp)
    80005af4:	01010413          	addi	s0,sp,16
    80005af8:	00006797          	auipc	a5,0x6
    80005afc:	c4878793          	addi	a5,a5,-952 # 8000b740 <_ZTV16ProducerKeyboard+0x10>
    80005b00:	00f53023          	sd	a5,0(a0)
    80005b04:	ffffd097          	auipc	ra,0xffffd
    80005b08:	e48080e7          	jalr	-440(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005b0c:	00813083          	ld	ra,8(sp)
    80005b10:	00013403          	ld	s0,0(sp)
    80005b14:	01010113          	addi	sp,sp,16
    80005b18:	00008067          	ret

0000000080005b1c <_ZN16ProducerKeyboardD0Ev>:
    80005b1c:	fe010113          	addi	sp,sp,-32
    80005b20:	00113c23          	sd	ra,24(sp)
    80005b24:	00813823          	sd	s0,16(sp)
    80005b28:	00913423          	sd	s1,8(sp)
    80005b2c:	02010413          	addi	s0,sp,32
    80005b30:	00050493          	mv	s1,a0
    80005b34:	00006797          	auipc	a5,0x6
    80005b38:	c0c78793          	addi	a5,a5,-1012 # 8000b740 <_ZTV16ProducerKeyboard+0x10>
    80005b3c:	00f53023          	sd	a5,0(a0)
    80005b40:	ffffd097          	auipc	ra,0xffffd
    80005b44:	e0c080e7          	jalr	-500(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005b48:	00048513          	mv	a0,s1
    80005b4c:	ffffd097          	auipc	ra,0xffffd
    80005b50:	e90080e7          	jalr	-368(ra) # 800029dc <_ZdlPv>
    80005b54:	01813083          	ld	ra,24(sp)
    80005b58:	01013403          	ld	s0,16(sp)
    80005b5c:	00813483          	ld	s1,8(sp)
    80005b60:	02010113          	addi	sp,sp,32
    80005b64:	00008067          	ret

0000000080005b68 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80005b68:	ff010113          	addi	sp,sp,-16
    80005b6c:	00113423          	sd	ra,8(sp)
    80005b70:	00813023          	sd	s0,0(sp)
    80005b74:	01010413          	addi	s0,sp,16
    80005b78:	00006797          	auipc	a5,0x6
    80005b7c:	c9078793          	addi	a5,a5,-880 # 8000b808 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005b80:	00f53023          	sd	a5,0(a0)
    80005b84:	ffffd097          	auipc	ra,0xffffd
    80005b88:	dc8080e7          	jalr	-568(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005b8c:	00813083          	ld	ra,8(sp)
    80005b90:	00013403          	ld	s0,0(sp)
    80005b94:	01010113          	addi	sp,sp,16
    80005b98:	00008067          	ret

0000000080005b9c <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80005b9c:	fe010113          	addi	sp,sp,-32
    80005ba0:	00113c23          	sd	ra,24(sp)
    80005ba4:	00813823          	sd	s0,16(sp)
    80005ba8:	00913423          	sd	s1,8(sp)
    80005bac:	02010413          	addi	s0,sp,32
    80005bb0:	00050493          	mv	s1,a0
    80005bb4:	00006797          	auipc	a5,0x6
    80005bb8:	c5478793          	addi	a5,a5,-940 # 8000b808 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005bbc:	00f53023          	sd	a5,0(a0)
    80005bc0:	ffffd097          	auipc	ra,0xffffd
    80005bc4:	d8c080e7          	jalr	-628(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005bc8:	00048513          	mv	a0,s1
    80005bcc:	ffffd097          	auipc	ra,0xffffd
    80005bd0:	e10080e7          	jalr	-496(ra) # 800029dc <_ZdlPv>
    80005bd4:	01813083          	ld	ra,24(sp)
    80005bd8:	01013403          	ld	s0,16(sp)
    80005bdc:	00813483          	ld	s1,8(sp)
    80005be0:	02010113          	addi	sp,sp,32
    80005be4:	00008067          	ret

0000000080005be8 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80005be8:	ff010113          	addi	sp,sp,-16
    80005bec:	00113423          	sd	ra,8(sp)
    80005bf0:	00813023          	sd	s0,0(sp)
    80005bf4:	01010413          	addi	s0,sp,16
    80005bf8:	00006797          	auipc	a5,0x6
    80005bfc:	bc078793          	addi	a5,a5,-1088 # 8000b7b8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005c00:	00f53023          	sd	a5,0(a0)
    80005c04:	ffffd097          	auipc	ra,0xffffd
    80005c08:	d48080e7          	jalr	-696(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005c0c:	00813083          	ld	ra,8(sp)
    80005c10:	00013403          	ld	s0,0(sp)
    80005c14:	01010113          	addi	sp,sp,16
    80005c18:	00008067          	ret

0000000080005c1c <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80005c1c:	fe010113          	addi	sp,sp,-32
    80005c20:	00113c23          	sd	ra,24(sp)
    80005c24:	00813823          	sd	s0,16(sp)
    80005c28:	00913423          	sd	s1,8(sp)
    80005c2c:	02010413          	addi	s0,sp,32
    80005c30:	00050493          	mv	s1,a0
    80005c34:	00006797          	auipc	a5,0x6
    80005c38:	b8478793          	addi	a5,a5,-1148 # 8000b7b8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005c3c:	00f53023          	sd	a5,0(a0)
    80005c40:	ffffd097          	auipc	ra,0xffffd
    80005c44:	d0c080e7          	jalr	-756(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005c48:	00048513          	mv	a0,s1
    80005c4c:	ffffd097          	auipc	ra,0xffffd
    80005c50:	d90080e7          	jalr	-624(ra) # 800029dc <_ZdlPv>
    80005c54:	01813083          	ld	ra,24(sp)
    80005c58:	01013403          	ld	s0,16(sp)
    80005c5c:	00813483          	ld	s1,8(sp)
    80005c60:	02010113          	addi	sp,sp,32
    80005c64:	00008067          	ret

0000000080005c68 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80005c68:	ff010113          	addi	sp,sp,-16
    80005c6c:	00113423          	sd	ra,8(sp)
    80005c70:	00813023          	sd	s0,0(sp)
    80005c74:	01010413          	addi	s0,sp,16
    80005c78:	00006797          	auipc	a5,0x6
    80005c7c:	b6878793          	addi	a5,a5,-1176 # 8000b7e0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005c80:	00f53023          	sd	a5,0(a0)
    80005c84:	ffffd097          	auipc	ra,0xffffd
    80005c88:	cc8080e7          	jalr	-824(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005c8c:	00813083          	ld	ra,8(sp)
    80005c90:	00013403          	ld	s0,0(sp)
    80005c94:	01010113          	addi	sp,sp,16
    80005c98:	00008067          	ret

0000000080005c9c <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80005c9c:	fe010113          	addi	sp,sp,-32
    80005ca0:	00113c23          	sd	ra,24(sp)
    80005ca4:	00813823          	sd	s0,16(sp)
    80005ca8:	00913423          	sd	s1,8(sp)
    80005cac:	02010413          	addi	s0,sp,32
    80005cb0:	00050493          	mv	s1,a0
    80005cb4:	00006797          	auipc	a5,0x6
    80005cb8:	b2c78793          	addi	a5,a5,-1236 # 8000b7e0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005cbc:	00f53023          	sd	a5,0(a0)
    80005cc0:	ffffd097          	auipc	ra,0xffffd
    80005cc4:	c8c080e7          	jalr	-884(ra) # 8000294c <_ZN6ThreadD1Ev>
    80005cc8:	00048513          	mv	a0,s1
    80005ccc:	ffffd097          	auipc	ra,0xffffd
    80005cd0:	d10080e7          	jalr	-752(ra) # 800029dc <_ZdlPv>
    80005cd4:	01813083          	ld	ra,24(sp)
    80005cd8:	01013403          	ld	s0,16(sp)
    80005cdc:	00813483          	ld	s1,8(sp)
    80005ce0:	02010113          	addi	sp,sp,32
    80005ce4:	00008067          	ret

0000000080005ce8 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80005ce8:	fe010113          	addi	sp,sp,-32
    80005cec:	00113c23          	sd	ra,24(sp)
    80005cf0:	00813823          	sd	s0,16(sp)
    80005cf4:	00913423          	sd	s1,8(sp)
    80005cf8:	01213023          	sd	s2,0(sp)
    80005cfc:	02010413          	addi	s0,sp,32
    80005d00:	00050493          	mv	s1,a0
            int i = 0;
    80005d04:	00000913          	li	s2,0
            while (!threadEnd) {
    80005d08:	0000a797          	auipc	a5,0xa
    80005d0c:	dc47a783          	lw	a5,-572(a5) # 8000facc <_ZN19ConsumerProducerCPP9threadEndE>
    80005d10:	04079263          	bnez	a5,80005d54 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80005d14:	0104b783          	ld	a5,16(s1)
    80005d18:	0007a583          	lw	a1,0(a5)
    80005d1c:	0305859b          	addiw	a1,a1,48
    80005d20:	0087b503          	ld	a0,8(a5)
    80005d24:	ffffe097          	auipc	ra,0xffffe
    80005d28:	6cc080e7          	jalr	1740(ra) # 800043f0 <_ZN9BufferCPP3putEi>
                i++;
    80005d2c:	0019071b          	addiw	a4,s2,1
    80005d30:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80005d34:	0104b783          	ld	a5,16(s1)
    80005d38:	0007a783          	lw	a5,0(a5)
    80005d3c:	00e787bb          	addw	a5,a5,a4
    80005d40:	00500513          	li	a0,5
    80005d44:	02a7e53b          	remw	a0,a5,a0
    80005d48:	ffffd097          	auipc	ra,0xffffd
    80005d4c:	e48080e7          	jalr	-440(ra) # 80002b90 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80005d50:	fb9ff06f          	j	80005d08 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80005d54:	0104b783          	ld	a5,16(s1)
    80005d58:	0107b503          	ld	a0,16(a5)
    80005d5c:	ffffd097          	auipc	ra,0xffffd
    80005d60:	d8c080e7          	jalr	-628(ra) # 80002ae8 <_ZN9Semaphore6signalEv>
        }
    80005d64:	01813083          	ld	ra,24(sp)
    80005d68:	01013403          	ld	s0,16(sp)
    80005d6c:	00813483          	ld	s1,8(sp)
    80005d70:	00013903          	ld	s2,0(sp)
    80005d74:	02010113          	addi	sp,sp,32
    80005d78:	00008067          	ret

0000000080005d7c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80005d7c:	ff010113          	addi	sp,sp,-16
    80005d80:	00113423          	sd	ra,8(sp)
    80005d84:	00813023          	sd	s0,0(sp)
    80005d88:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80005d8c:	01053583          	ld	a1,16(a0)
    80005d90:	fffff097          	auipc	ra,0xfffff
    80005d94:	fb0080e7          	jalr	-80(ra) # 80004d40 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80005d98:	00813083          	ld	ra,8(sp)
    80005d9c:	00013403          	ld	s0,0(sp)
    80005da0:	01010113          	addi	sp,sp,16
    80005da4:	00008067          	ret

0000000080005da8 <_ZN8Producer3runEv>:
    void run() override {
    80005da8:	ff010113          	addi	sp,sp,-16
    80005dac:	00113423          	sd	ra,8(sp)
    80005db0:	00813023          	sd	s0,0(sp)
    80005db4:	01010413          	addi	s0,sp,16
        producer(td);
    80005db8:	01053583          	ld	a1,16(a0)
    80005dbc:	fffff097          	auipc	ra,0xfffff
    80005dc0:	044080e7          	jalr	68(ra) # 80004e00 <_ZN8Producer8producerEPv>
    }
    80005dc4:	00813083          	ld	ra,8(sp)
    80005dc8:	00013403          	ld	s0,0(sp)
    80005dcc:	01010113          	addi	sp,sp,16
    80005dd0:	00008067          	ret

0000000080005dd4 <_ZN8Consumer3runEv>:
    void run() override {
    80005dd4:	ff010113          	addi	sp,sp,-16
    80005dd8:	00113423          	sd	ra,8(sp)
    80005ddc:	00813023          	sd	s0,0(sp)
    80005de0:	01010413          	addi	s0,sp,16
        consumer(td);
    80005de4:	01053583          	ld	a1,16(a0)
    80005de8:	fffff097          	auipc	ra,0xfffff
    80005dec:	0ac080e7          	jalr	172(ra) # 80004e94 <_ZN8Consumer8consumerEPv>
    }
    80005df0:	00813083          	ld	ra,8(sp)
    80005df4:	00013403          	ld	s0,0(sp)
    80005df8:	01010113          	addi	sp,sp,16
    80005dfc:	00008067          	ret

0000000080005e00 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005e00:	fe010113          	addi	sp,sp,-32
    80005e04:	00113c23          	sd	ra,24(sp)
    80005e08:	00813823          	sd	s0,16(sp)
    80005e0c:	00913423          	sd	s1,8(sp)
    80005e10:	01213023          	sd	s2,0(sp)
    80005e14:	02010413          	addi	s0,sp,32
    80005e18:	00050493          	mv	s1,a0
    80005e1c:	00058913          	mv	s2,a1
    80005e20:	0015879b          	addiw	a5,a1,1
    80005e24:	0007851b          	sext.w	a0,a5
    80005e28:	00f4a023          	sw	a5,0(s1)
    80005e2c:	0004a823          	sw	zero,16(s1)
    80005e30:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005e34:	00251513          	slli	a0,a0,0x2
    80005e38:	ffffb097          	auipc	ra,0xffffb
    80005e3c:	31c080e7          	jalr	796(ra) # 80001154 <_Z9mem_allocm>
    80005e40:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80005e44:	00000593          	li	a1,0
    80005e48:	02048513          	addi	a0,s1,32
    80005e4c:	ffffb097          	auipc	ra,0xffffb
    80005e50:	4d0080e7          	jalr	1232(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80005e54:	00090593          	mv	a1,s2
    80005e58:	01848513          	addi	a0,s1,24
    80005e5c:	ffffb097          	auipc	ra,0xffffb
    80005e60:	4c0080e7          	jalr	1216(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80005e64:	00100593          	li	a1,1
    80005e68:	02848513          	addi	a0,s1,40
    80005e6c:	ffffb097          	auipc	ra,0xffffb
    80005e70:	4b0080e7          	jalr	1200(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80005e74:	00100593          	li	a1,1
    80005e78:	03048513          	addi	a0,s1,48
    80005e7c:	ffffb097          	auipc	ra,0xffffb
    80005e80:	4a0080e7          	jalr	1184(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
}
    80005e84:	01813083          	ld	ra,24(sp)
    80005e88:	01013403          	ld	s0,16(sp)
    80005e8c:	00813483          	ld	s1,8(sp)
    80005e90:	00013903          	ld	s2,0(sp)
    80005e94:	02010113          	addi	sp,sp,32
    80005e98:	00008067          	ret

0000000080005e9c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80005e9c:	fe010113          	addi	sp,sp,-32
    80005ea0:	00113c23          	sd	ra,24(sp)
    80005ea4:	00813823          	sd	s0,16(sp)
    80005ea8:	00913423          	sd	s1,8(sp)
    80005eac:	01213023          	sd	s2,0(sp)
    80005eb0:	02010413          	addi	s0,sp,32
    80005eb4:	00050493          	mv	s1,a0
    80005eb8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80005ebc:	01853503          	ld	a0,24(a0)
    80005ec0:	ffffb097          	auipc	ra,0xffffb
    80005ec4:	4c0080e7          	jalr	1216(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80005ec8:	0304b503          	ld	a0,48(s1)
    80005ecc:	ffffb097          	auipc	ra,0xffffb
    80005ed0:	4b4080e7          	jalr	1204(ra) # 80001380 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80005ed4:	0084b783          	ld	a5,8(s1)
    80005ed8:	0144a703          	lw	a4,20(s1)
    80005edc:	00271713          	slli	a4,a4,0x2
    80005ee0:	00e787b3          	add	a5,a5,a4
    80005ee4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005ee8:	0144a783          	lw	a5,20(s1)
    80005eec:	0017879b          	addiw	a5,a5,1
    80005ef0:	0004a703          	lw	a4,0(s1)
    80005ef4:	02e7e7bb          	remw	a5,a5,a4
    80005ef8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80005efc:	0304b503          	ld	a0,48(s1)
    80005f00:	ffffb097          	auipc	ra,0xffffb
    80005f04:	4ac080e7          	jalr	1196(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80005f08:	0204b503          	ld	a0,32(s1)
    80005f0c:	ffffb097          	auipc	ra,0xffffb
    80005f10:	4a0080e7          	jalr	1184(ra) # 800013ac <_Z10sem_signalP10_semaphore>

}
    80005f14:	01813083          	ld	ra,24(sp)
    80005f18:	01013403          	ld	s0,16(sp)
    80005f1c:	00813483          	ld	s1,8(sp)
    80005f20:	00013903          	ld	s2,0(sp)
    80005f24:	02010113          	addi	sp,sp,32
    80005f28:	00008067          	ret

0000000080005f2c <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005f2c:	fe010113          	addi	sp,sp,-32
    80005f30:	00113c23          	sd	ra,24(sp)
    80005f34:	00813823          	sd	s0,16(sp)
    80005f38:	00913423          	sd	s1,8(sp)
    80005f3c:	01213023          	sd	s2,0(sp)
    80005f40:	02010413          	addi	s0,sp,32
    80005f44:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005f48:	02053503          	ld	a0,32(a0)
    80005f4c:	ffffb097          	auipc	ra,0xffffb
    80005f50:	434080e7          	jalr	1076(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80005f54:	0284b503          	ld	a0,40(s1)
    80005f58:	ffffb097          	auipc	ra,0xffffb
    80005f5c:	428080e7          	jalr	1064(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80005f60:	0084b703          	ld	a4,8(s1)
    80005f64:	0104a783          	lw	a5,16(s1)
    80005f68:	00279693          	slli	a3,a5,0x2
    80005f6c:	00d70733          	add	a4,a4,a3
    80005f70:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005f74:	0017879b          	addiw	a5,a5,1
    80005f78:	0004a703          	lw	a4,0(s1)
    80005f7c:	02e7e7bb          	remw	a5,a5,a4
    80005f80:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005f84:	0284b503          	ld	a0,40(s1)
    80005f88:	ffffb097          	auipc	ra,0xffffb
    80005f8c:	424080e7          	jalr	1060(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80005f90:	0184b503          	ld	a0,24(s1)
    80005f94:	ffffb097          	auipc	ra,0xffffb
    80005f98:	418080e7          	jalr	1048(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80005f9c:	00090513          	mv	a0,s2
    80005fa0:	01813083          	ld	ra,24(sp)
    80005fa4:	01013403          	ld	s0,16(sp)
    80005fa8:	00813483          	ld	s1,8(sp)
    80005fac:	00013903          	ld	s2,0(sp)
    80005fb0:	02010113          	addi	sp,sp,32
    80005fb4:	00008067          	ret

0000000080005fb8 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80005fb8:	fe010113          	addi	sp,sp,-32
    80005fbc:	00113c23          	sd	ra,24(sp)
    80005fc0:	00813823          	sd	s0,16(sp)
    80005fc4:	00913423          	sd	s1,8(sp)
    80005fc8:	01213023          	sd	s2,0(sp)
    80005fcc:	02010413          	addi	s0,sp,32
    80005fd0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80005fd4:	02853503          	ld	a0,40(a0)
    80005fd8:	ffffb097          	auipc	ra,0xffffb
    80005fdc:	3a8080e7          	jalr	936(ra) # 80001380 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80005fe0:	0304b503          	ld	a0,48(s1)
    80005fe4:	ffffb097          	auipc	ra,0xffffb
    80005fe8:	39c080e7          	jalr	924(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80005fec:	0144a783          	lw	a5,20(s1)
    80005ff0:	0104a903          	lw	s2,16(s1)
    80005ff4:	0327ce63          	blt	a5,s2,80006030 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80005ff8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80005ffc:	0304b503          	ld	a0,48(s1)
    80006000:	ffffb097          	auipc	ra,0xffffb
    80006004:	3ac080e7          	jalr	940(ra) # 800013ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006008:	0284b503          	ld	a0,40(s1)
    8000600c:	ffffb097          	auipc	ra,0xffffb
    80006010:	3a0080e7          	jalr	928(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006014:	00090513          	mv	a0,s2
    80006018:	01813083          	ld	ra,24(sp)
    8000601c:	01013403          	ld	s0,16(sp)
    80006020:	00813483          	ld	s1,8(sp)
    80006024:	00013903          	ld	s2,0(sp)
    80006028:	02010113          	addi	sp,sp,32
    8000602c:	00008067          	ret
        ret = cap - head + tail;
    80006030:	0004a703          	lw	a4,0(s1)
    80006034:	4127093b          	subw	s2,a4,s2
    80006038:	00f9093b          	addw	s2,s2,a5
    8000603c:	fc1ff06f          	j	80005ffc <_ZN6Buffer6getCntEv+0x44>

0000000080006040 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006040:	fe010113          	addi	sp,sp,-32
    80006044:	00113c23          	sd	ra,24(sp)
    80006048:	00813823          	sd	s0,16(sp)
    8000604c:	00913423          	sd	s1,8(sp)
    80006050:	02010413          	addi	s0,sp,32
    80006054:	00050493          	mv	s1,a0
    putc('\n');
    80006058:	00a00513          	li	a0,10
    8000605c:	ffffb097          	auipc	ra,0xffffb
    80006060:	3d0080e7          	jalr	976(ra) # 8000142c <_Z4putcc>
    printString("Buffer deleted!\n");
    80006064:	00003517          	auipc	a0,0x3
    80006068:	26c50513          	addi	a0,a0,620 # 800092d0 <CONSOLE_STATUS+0x2c0>
    8000606c:	ffffc097          	auipc	ra,0xffffc
    80006070:	bf4080e7          	jalr	-1036(ra) # 80001c60 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006074:	00048513          	mv	a0,s1
    80006078:	00000097          	auipc	ra,0x0
    8000607c:	f40080e7          	jalr	-192(ra) # 80005fb8 <_ZN6Buffer6getCntEv>
    80006080:	02a05c63          	blez	a0,800060b8 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006084:	0084b783          	ld	a5,8(s1)
    80006088:	0104a703          	lw	a4,16(s1)
    8000608c:	00271713          	slli	a4,a4,0x2
    80006090:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006094:	0007c503          	lbu	a0,0(a5)
    80006098:	ffffb097          	auipc	ra,0xffffb
    8000609c:	394080e7          	jalr	916(ra) # 8000142c <_Z4putcc>
        head = (head + 1) % cap;
    800060a0:	0104a783          	lw	a5,16(s1)
    800060a4:	0017879b          	addiw	a5,a5,1
    800060a8:	0004a703          	lw	a4,0(s1)
    800060ac:	02e7e7bb          	remw	a5,a5,a4
    800060b0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800060b4:	fc1ff06f          	j	80006074 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800060b8:	02100513          	li	a0,33
    800060bc:	ffffb097          	auipc	ra,0xffffb
    800060c0:	370080e7          	jalr	880(ra) # 8000142c <_Z4putcc>
    putc('\n');
    800060c4:	00a00513          	li	a0,10
    800060c8:	ffffb097          	auipc	ra,0xffffb
    800060cc:	364080e7          	jalr	868(ra) # 8000142c <_Z4putcc>
    mem_free(buffer);
    800060d0:	0084b503          	ld	a0,8(s1)
    800060d4:	ffffb097          	auipc	ra,0xffffb
    800060d8:	0b0080e7          	jalr	176(ra) # 80001184 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800060dc:	0204b503          	ld	a0,32(s1)
    800060e0:	ffffb097          	auipc	ra,0xffffb
    800060e4:	274080e7          	jalr	628(ra) # 80001354 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    800060e8:	0184b503          	ld	a0,24(s1)
    800060ec:	ffffb097          	auipc	ra,0xffffb
    800060f0:	268080e7          	jalr	616(ra) # 80001354 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    800060f4:	0304b503          	ld	a0,48(s1)
    800060f8:	ffffb097          	auipc	ra,0xffffb
    800060fc:	25c080e7          	jalr	604(ra) # 80001354 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006100:	0284b503          	ld	a0,40(s1)
    80006104:	ffffb097          	auipc	ra,0xffffb
    80006108:	250080e7          	jalr	592(ra) # 80001354 <_Z9sem_closeP10_semaphore>
}
    8000610c:	01813083          	ld	ra,24(sp)
    80006110:	01013403          	ld	s0,16(sp)
    80006114:	00813483          	ld	s1,8(sp)
    80006118:	02010113          	addi	sp,sp,32
    8000611c:	00008067          	ret

0000000080006120 <start>:
    80006120:	ff010113          	addi	sp,sp,-16
    80006124:	00813423          	sd	s0,8(sp)
    80006128:	01010413          	addi	s0,sp,16
    8000612c:	300027f3          	csrr	a5,mstatus
    80006130:	ffffe737          	lui	a4,0xffffe
    80006134:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffedaaf>
    80006138:	00e7f7b3          	and	a5,a5,a4
    8000613c:	00001737          	lui	a4,0x1
    80006140:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006144:	00e7e7b3          	or	a5,a5,a4
    80006148:	30079073          	csrw	mstatus,a5
    8000614c:	00000797          	auipc	a5,0x0
    80006150:	16078793          	addi	a5,a5,352 # 800062ac <system_main>
    80006154:	34179073          	csrw	mepc,a5
    80006158:	00000793          	li	a5,0
    8000615c:	18079073          	csrw	satp,a5
    80006160:	000107b7          	lui	a5,0x10
    80006164:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006168:	30279073          	csrw	medeleg,a5
    8000616c:	30379073          	csrw	mideleg,a5
    80006170:	104027f3          	csrr	a5,sie
    80006174:	2227e793          	ori	a5,a5,546
    80006178:	10479073          	csrw	sie,a5
    8000617c:	fff00793          	li	a5,-1
    80006180:	00a7d793          	srli	a5,a5,0xa
    80006184:	3b079073          	csrw	pmpaddr0,a5
    80006188:	00f00793          	li	a5,15
    8000618c:	3a079073          	csrw	pmpcfg0,a5
    80006190:	f14027f3          	csrr	a5,mhartid
    80006194:	0200c737          	lui	a4,0x200c
    80006198:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000619c:	0007869b          	sext.w	a3,a5
    800061a0:	00269713          	slli	a4,a3,0x2
    800061a4:	000f4637          	lui	a2,0xf4
    800061a8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800061ac:	00d70733          	add	a4,a4,a3
    800061b0:	0037979b          	slliw	a5,a5,0x3
    800061b4:	020046b7          	lui	a3,0x2004
    800061b8:	00d787b3          	add	a5,a5,a3
    800061bc:	00c585b3          	add	a1,a1,a2
    800061c0:	00371693          	slli	a3,a4,0x3
    800061c4:	0000a717          	auipc	a4,0xa
    800061c8:	92c70713          	addi	a4,a4,-1748 # 8000faf0 <timer_scratch>
    800061cc:	00b7b023          	sd	a1,0(a5)
    800061d0:	00d70733          	add	a4,a4,a3
    800061d4:	00f73c23          	sd	a5,24(a4)
    800061d8:	02c73023          	sd	a2,32(a4)
    800061dc:	34071073          	csrw	mscratch,a4
    800061e0:	00000797          	auipc	a5,0x0
    800061e4:	6e078793          	addi	a5,a5,1760 # 800068c0 <timervec>
    800061e8:	30579073          	csrw	mtvec,a5
    800061ec:	300027f3          	csrr	a5,mstatus
    800061f0:	0087e793          	ori	a5,a5,8
    800061f4:	30079073          	csrw	mstatus,a5
    800061f8:	304027f3          	csrr	a5,mie
    800061fc:	0807e793          	ori	a5,a5,128
    80006200:	30479073          	csrw	mie,a5
    80006204:	f14027f3          	csrr	a5,mhartid
    80006208:	0007879b          	sext.w	a5,a5
    8000620c:	00078213          	mv	tp,a5
    80006210:	30200073          	mret
    80006214:	00813403          	ld	s0,8(sp)
    80006218:	01010113          	addi	sp,sp,16
    8000621c:	00008067          	ret

0000000080006220 <timerinit>:
    80006220:	ff010113          	addi	sp,sp,-16
    80006224:	00813423          	sd	s0,8(sp)
    80006228:	01010413          	addi	s0,sp,16
    8000622c:	f14027f3          	csrr	a5,mhartid
    80006230:	0200c737          	lui	a4,0x200c
    80006234:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006238:	0007869b          	sext.w	a3,a5
    8000623c:	00269713          	slli	a4,a3,0x2
    80006240:	000f4637          	lui	a2,0xf4
    80006244:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006248:	00d70733          	add	a4,a4,a3
    8000624c:	0037979b          	slliw	a5,a5,0x3
    80006250:	020046b7          	lui	a3,0x2004
    80006254:	00d787b3          	add	a5,a5,a3
    80006258:	00c585b3          	add	a1,a1,a2
    8000625c:	00371693          	slli	a3,a4,0x3
    80006260:	0000a717          	auipc	a4,0xa
    80006264:	89070713          	addi	a4,a4,-1904 # 8000faf0 <timer_scratch>
    80006268:	00b7b023          	sd	a1,0(a5)
    8000626c:	00d70733          	add	a4,a4,a3
    80006270:	00f73c23          	sd	a5,24(a4)
    80006274:	02c73023          	sd	a2,32(a4)
    80006278:	34071073          	csrw	mscratch,a4
    8000627c:	00000797          	auipc	a5,0x0
    80006280:	64478793          	addi	a5,a5,1604 # 800068c0 <timervec>
    80006284:	30579073          	csrw	mtvec,a5
    80006288:	300027f3          	csrr	a5,mstatus
    8000628c:	0087e793          	ori	a5,a5,8
    80006290:	30079073          	csrw	mstatus,a5
    80006294:	304027f3          	csrr	a5,mie
    80006298:	0807e793          	ori	a5,a5,128
    8000629c:	30479073          	csrw	mie,a5
    800062a0:	00813403          	ld	s0,8(sp)
    800062a4:	01010113          	addi	sp,sp,16
    800062a8:	00008067          	ret

00000000800062ac <system_main>:
    800062ac:	fe010113          	addi	sp,sp,-32
    800062b0:	00813823          	sd	s0,16(sp)
    800062b4:	00913423          	sd	s1,8(sp)
    800062b8:	00113c23          	sd	ra,24(sp)
    800062bc:	02010413          	addi	s0,sp,32
    800062c0:	00000097          	auipc	ra,0x0
    800062c4:	0c4080e7          	jalr	196(ra) # 80006384 <cpuid>
    800062c8:	00005497          	auipc	s1,0x5
    800062cc:	62848493          	addi	s1,s1,1576 # 8000b8f0 <started>
    800062d0:	02050263          	beqz	a0,800062f4 <system_main+0x48>
    800062d4:	0004a783          	lw	a5,0(s1)
    800062d8:	0007879b          	sext.w	a5,a5
    800062dc:	fe078ce3          	beqz	a5,800062d4 <system_main+0x28>
    800062e0:	0ff0000f          	fence
    800062e4:	00003517          	auipc	a0,0x3
    800062e8:	21c50513          	addi	a0,a0,540 # 80009500 <CONSOLE_STATUS+0x4f0>
    800062ec:	00001097          	auipc	ra,0x1
    800062f0:	a70080e7          	jalr	-1424(ra) # 80006d5c <panic>
    800062f4:	00001097          	auipc	ra,0x1
    800062f8:	9c4080e7          	jalr	-1596(ra) # 80006cb8 <consoleinit>
    800062fc:	00001097          	auipc	ra,0x1
    80006300:	150080e7          	jalr	336(ra) # 8000744c <printfinit>
    80006304:	00003517          	auipc	a0,0x3
    80006308:	dbc50513          	addi	a0,a0,-580 # 800090c0 <CONSOLE_STATUS+0xb0>
    8000630c:	00001097          	auipc	ra,0x1
    80006310:	aac080e7          	jalr	-1364(ra) # 80006db8 <__printf>
    80006314:	00003517          	auipc	a0,0x3
    80006318:	1bc50513          	addi	a0,a0,444 # 800094d0 <CONSOLE_STATUS+0x4c0>
    8000631c:	00001097          	auipc	ra,0x1
    80006320:	a9c080e7          	jalr	-1380(ra) # 80006db8 <__printf>
    80006324:	00003517          	auipc	a0,0x3
    80006328:	d9c50513          	addi	a0,a0,-612 # 800090c0 <CONSOLE_STATUS+0xb0>
    8000632c:	00001097          	auipc	ra,0x1
    80006330:	a8c080e7          	jalr	-1396(ra) # 80006db8 <__printf>
    80006334:	00001097          	auipc	ra,0x1
    80006338:	4a4080e7          	jalr	1188(ra) # 800077d8 <kinit>
    8000633c:	00000097          	auipc	ra,0x0
    80006340:	148080e7          	jalr	328(ra) # 80006484 <trapinit>
    80006344:	00000097          	auipc	ra,0x0
    80006348:	16c080e7          	jalr	364(ra) # 800064b0 <trapinithart>
    8000634c:	00000097          	auipc	ra,0x0
    80006350:	5b4080e7          	jalr	1460(ra) # 80006900 <plicinit>
    80006354:	00000097          	auipc	ra,0x0
    80006358:	5d4080e7          	jalr	1492(ra) # 80006928 <plicinithart>
    8000635c:	00000097          	auipc	ra,0x0
    80006360:	078080e7          	jalr	120(ra) # 800063d4 <userinit>
    80006364:	0ff0000f          	fence
    80006368:	00100793          	li	a5,1
    8000636c:	00003517          	auipc	a0,0x3
    80006370:	17c50513          	addi	a0,a0,380 # 800094e8 <CONSOLE_STATUS+0x4d8>
    80006374:	00f4a023          	sw	a5,0(s1)
    80006378:	00001097          	auipc	ra,0x1
    8000637c:	a40080e7          	jalr	-1472(ra) # 80006db8 <__printf>
    80006380:	0000006f          	j	80006380 <system_main+0xd4>

0000000080006384 <cpuid>:
    80006384:	ff010113          	addi	sp,sp,-16
    80006388:	00813423          	sd	s0,8(sp)
    8000638c:	01010413          	addi	s0,sp,16
    80006390:	00020513          	mv	a0,tp
    80006394:	00813403          	ld	s0,8(sp)
    80006398:	0005051b          	sext.w	a0,a0
    8000639c:	01010113          	addi	sp,sp,16
    800063a0:	00008067          	ret

00000000800063a4 <mycpu>:
    800063a4:	ff010113          	addi	sp,sp,-16
    800063a8:	00813423          	sd	s0,8(sp)
    800063ac:	01010413          	addi	s0,sp,16
    800063b0:	00020793          	mv	a5,tp
    800063b4:	00813403          	ld	s0,8(sp)
    800063b8:	0007879b          	sext.w	a5,a5
    800063bc:	00779793          	slli	a5,a5,0x7
    800063c0:	0000a517          	auipc	a0,0xa
    800063c4:	76050513          	addi	a0,a0,1888 # 80010b20 <cpus>
    800063c8:	00f50533          	add	a0,a0,a5
    800063cc:	01010113          	addi	sp,sp,16
    800063d0:	00008067          	ret

00000000800063d4 <userinit>:
    800063d4:	ff010113          	addi	sp,sp,-16
    800063d8:	00813423          	sd	s0,8(sp)
    800063dc:	01010413          	addi	s0,sp,16
    800063e0:	00813403          	ld	s0,8(sp)
    800063e4:	01010113          	addi	sp,sp,16
    800063e8:	ffffc317          	auipc	t1,0xffffc
    800063ec:	d5c30067          	jr	-676(t1) # 80002144 <main>

00000000800063f0 <either_copyout>:
    800063f0:	ff010113          	addi	sp,sp,-16
    800063f4:	00813023          	sd	s0,0(sp)
    800063f8:	00113423          	sd	ra,8(sp)
    800063fc:	01010413          	addi	s0,sp,16
    80006400:	02051663          	bnez	a0,8000642c <either_copyout+0x3c>
    80006404:	00058513          	mv	a0,a1
    80006408:	00060593          	mv	a1,a2
    8000640c:	0006861b          	sext.w	a2,a3
    80006410:	00002097          	auipc	ra,0x2
    80006414:	c54080e7          	jalr	-940(ra) # 80008064 <__memmove>
    80006418:	00813083          	ld	ra,8(sp)
    8000641c:	00013403          	ld	s0,0(sp)
    80006420:	00000513          	li	a0,0
    80006424:	01010113          	addi	sp,sp,16
    80006428:	00008067          	ret
    8000642c:	00003517          	auipc	a0,0x3
    80006430:	0fc50513          	addi	a0,a0,252 # 80009528 <CONSOLE_STATUS+0x518>
    80006434:	00001097          	auipc	ra,0x1
    80006438:	928080e7          	jalr	-1752(ra) # 80006d5c <panic>

000000008000643c <either_copyin>:
    8000643c:	ff010113          	addi	sp,sp,-16
    80006440:	00813023          	sd	s0,0(sp)
    80006444:	00113423          	sd	ra,8(sp)
    80006448:	01010413          	addi	s0,sp,16
    8000644c:	02059463          	bnez	a1,80006474 <either_copyin+0x38>
    80006450:	00060593          	mv	a1,a2
    80006454:	0006861b          	sext.w	a2,a3
    80006458:	00002097          	auipc	ra,0x2
    8000645c:	c0c080e7          	jalr	-1012(ra) # 80008064 <__memmove>
    80006460:	00813083          	ld	ra,8(sp)
    80006464:	00013403          	ld	s0,0(sp)
    80006468:	00000513          	li	a0,0
    8000646c:	01010113          	addi	sp,sp,16
    80006470:	00008067          	ret
    80006474:	00003517          	auipc	a0,0x3
    80006478:	0dc50513          	addi	a0,a0,220 # 80009550 <CONSOLE_STATUS+0x540>
    8000647c:	00001097          	auipc	ra,0x1
    80006480:	8e0080e7          	jalr	-1824(ra) # 80006d5c <panic>

0000000080006484 <trapinit>:
    80006484:	ff010113          	addi	sp,sp,-16
    80006488:	00813423          	sd	s0,8(sp)
    8000648c:	01010413          	addi	s0,sp,16
    80006490:	00813403          	ld	s0,8(sp)
    80006494:	00003597          	auipc	a1,0x3
    80006498:	0e458593          	addi	a1,a1,228 # 80009578 <CONSOLE_STATUS+0x568>
    8000649c:	0000a517          	auipc	a0,0xa
    800064a0:	70450513          	addi	a0,a0,1796 # 80010ba0 <tickslock>
    800064a4:	01010113          	addi	sp,sp,16
    800064a8:	00001317          	auipc	t1,0x1
    800064ac:	5c030067          	jr	1472(t1) # 80007a68 <initlock>

00000000800064b0 <trapinithart>:
    800064b0:	ff010113          	addi	sp,sp,-16
    800064b4:	00813423          	sd	s0,8(sp)
    800064b8:	01010413          	addi	s0,sp,16
    800064bc:	00000797          	auipc	a5,0x0
    800064c0:	2f478793          	addi	a5,a5,756 # 800067b0 <kernelvec>
    800064c4:	10579073          	csrw	stvec,a5
    800064c8:	00813403          	ld	s0,8(sp)
    800064cc:	01010113          	addi	sp,sp,16
    800064d0:	00008067          	ret

00000000800064d4 <usertrap>:
    800064d4:	ff010113          	addi	sp,sp,-16
    800064d8:	00813423          	sd	s0,8(sp)
    800064dc:	01010413          	addi	s0,sp,16
    800064e0:	00813403          	ld	s0,8(sp)
    800064e4:	01010113          	addi	sp,sp,16
    800064e8:	00008067          	ret

00000000800064ec <usertrapret>:
    800064ec:	ff010113          	addi	sp,sp,-16
    800064f0:	00813423          	sd	s0,8(sp)
    800064f4:	01010413          	addi	s0,sp,16
    800064f8:	00813403          	ld	s0,8(sp)
    800064fc:	01010113          	addi	sp,sp,16
    80006500:	00008067          	ret

0000000080006504 <kerneltrap>:
    80006504:	fe010113          	addi	sp,sp,-32
    80006508:	00813823          	sd	s0,16(sp)
    8000650c:	00113c23          	sd	ra,24(sp)
    80006510:	00913423          	sd	s1,8(sp)
    80006514:	02010413          	addi	s0,sp,32
    80006518:	142025f3          	csrr	a1,scause
    8000651c:	100027f3          	csrr	a5,sstatus
    80006520:	0027f793          	andi	a5,a5,2
    80006524:	10079c63          	bnez	a5,8000663c <kerneltrap+0x138>
    80006528:	142027f3          	csrr	a5,scause
    8000652c:	0207ce63          	bltz	a5,80006568 <kerneltrap+0x64>
    80006530:	00003517          	auipc	a0,0x3
    80006534:	09050513          	addi	a0,a0,144 # 800095c0 <CONSOLE_STATUS+0x5b0>
    80006538:	00001097          	auipc	ra,0x1
    8000653c:	880080e7          	jalr	-1920(ra) # 80006db8 <__printf>
    80006540:	141025f3          	csrr	a1,sepc
    80006544:	14302673          	csrr	a2,stval
    80006548:	00003517          	auipc	a0,0x3
    8000654c:	08850513          	addi	a0,a0,136 # 800095d0 <CONSOLE_STATUS+0x5c0>
    80006550:	00001097          	auipc	ra,0x1
    80006554:	868080e7          	jalr	-1944(ra) # 80006db8 <__printf>
    80006558:	00003517          	auipc	a0,0x3
    8000655c:	09050513          	addi	a0,a0,144 # 800095e8 <CONSOLE_STATUS+0x5d8>
    80006560:	00000097          	auipc	ra,0x0
    80006564:	7fc080e7          	jalr	2044(ra) # 80006d5c <panic>
    80006568:	0ff7f713          	andi	a4,a5,255
    8000656c:	00900693          	li	a3,9
    80006570:	04d70063          	beq	a4,a3,800065b0 <kerneltrap+0xac>
    80006574:	fff00713          	li	a4,-1
    80006578:	03f71713          	slli	a4,a4,0x3f
    8000657c:	00170713          	addi	a4,a4,1
    80006580:	fae798e3          	bne	a5,a4,80006530 <kerneltrap+0x2c>
    80006584:	00000097          	auipc	ra,0x0
    80006588:	e00080e7          	jalr	-512(ra) # 80006384 <cpuid>
    8000658c:	06050663          	beqz	a0,800065f8 <kerneltrap+0xf4>
    80006590:	144027f3          	csrr	a5,sip
    80006594:	ffd7f793          	andi	a5,a5,-3
    80006598:	14479073          	csrw	sip,a5
    8000659c:	01813083          	ld	ra,24(sp)
    800065a0:	01013403          	ld	s0,16(sp)
    800065a4:	00813483          	ld	s1,8(sp)
    800065a8:	02010113          	addi	sp,sp,32
    800065ac:	00008067          	ret
    800065b0:	00000097          	auipc	ra,0x0
    800065b4:	3c4080e7          	jalr	964(ra) # 80006974 <plic_claim>
    800065b8:	00a00793          	li	a5,10
    800065bc:	00050493          	mv	s1,a0
    800065c0:	06f50863          	beq	a0,a5,80006630 <kerneltrap+0x12c>
    800065c4:	fc050ce3          	beqz	a0,8000659c <kerneltrap+0x98>
    800065c8:	00050593          	mv	a1,a0
    800065cc:	00003517          	auipc	a0,0x3
    800065d0:	fd450513          	addi	a0,a0,-44 # 800095a0 <CONSOLE_STATUS+0x590>
    800065d4:	00000097          	auipc	ra,0x0
    800065d8:	7e4080e7          	jalr	2020(ra) # 80006db8 <__printf>
    800065dc:	01013403          	ld	s0,16(sp)
    800065e0:	01813083          	ld	ra,24(sp)
    800065e4:	00048513          	mv	a0,s1
    800065e8:	00813483          	ld	s1,8(sp)
    800065ec:	02010113          	addi	sp,sp,32
    800065f0:	00000317          	auipc	t1,0x0
    800065f4:	3bc30067          	jr	956(t1) # 800069ac <plic_complete>
    800065f8:	0000a517          	auipc	a0,0xa
    800065fc:	5a850513          	addi	a0,a0,1448 # 80010ba0 <tickslock>
    80006600:	00001097          	auipc	ra,0x1
    80006604:	48c080e7          	jalr	1164(ra) # 80007a8c <acquire>
    80006608:	00005717          	auipc	a4,0x5
    8000660c:	2ec70713          	addi	a4,a4,748 # 8000b8f4 <ticks>
    80006610:	00072783          	lw	a5,0(a4)
    80006614:	0000a517          	auipc	a0,0xa
    80006618:	58c50513          	addi	a0,a0,1420 # 80010ba0 <tickslock>
    8000661c:	0017879b          	addiw	a5,a5,1
    80006620:	00f72023          	sw	a5,0(a4)
    80006624:	00001097          	auipc	ra,0x1
    80006628:	534080e7          	jalr	1332(ra) # 80007b58 <release>
    8000662c:	f65ff06f          	j	80006590 <kerneltrap+0x8c>
    80006630:	00001097          	auipc	ra,0x1
    80006634:	090080e7          	jalr	144(ra) # 800076c0 <uartintr>
    80006638:	fa5ff06f          	j	800065dc <kerneltrap+0xd8>
    8000663c:	00003517          	auipc	a0,0x3
    80006640:	f4450513          	addi	a0,a0,-188 # 80009580 <CONSOLE_STATUS+0x570>
    80006644:	00000097          	auipc	ra,0x0
    80006648:	718080e7          	jalr	1816(ra) # 80006d5c <panic>

000000008000664c <clockintr>:
    8000664c:	fe010113          	addi	sp,sp,-32
    80006650:	00813823          	sd	s0,16(sp)
    80006654:	00913423          	sd	s1,8(sp)
    80006658:	00113c23          	sd	ra,24(sp)
    8000665c:	02010413          	addi	s0,sp,32
    80006660:	0000a497          	auipc	s1,0xa
    80006664:	54048493          	addi	s1,s1,1344 # 80010ba0 <tickslock>
    80006668:	00048513          	mv	a0,s1
    8000666c:	00001097          	auipc	ra,0x1
    80006670:	420080e7          	jalr	1056(ra) # 80007a8c <acquire>
    80006674:	00005717          	auipc	a4,0x5
    80006678:	28070713          	addi	a4,a4,640 # 8000b8f4 <ticks>
    8000667c:	00072783          	lw	a5,0(a4)
    80006680:	01013403          	ld	s0,16(sp)
    80006684:	01813083          	ld	ra,24(sp)
    80006688:	00048513          	mv	a0,s1
    8000668c:	0017879b          	addiw	a5,a5,1
    80006690:	00813483          	ld	s1,8(sp)
    80006694:	00f72023          	sw	a5,0(a4)
    80006698:	02010113          	addi	sp,sp,32
    8000669c:	00001317          	auipc	t1,0x1
    800066a0:	4bc30067          	jr	1212(t1) # 80007b58 <release>

00000000800066a4 <devintr>:
    800066a4:	142027f3          	csrr	a5,scause
    800066a8:	00000513          	li	a0,0
    800066ac:	0007c463          	bltz	a5,800066b4 <devintr+0x10>
    800066b0:	00008067          	ret
    800066b4:	fe010113          	addi	sp,sp,-32
    800066b8:	00813823          	sd	s0,16(sp)
    800066bc:	00113c23          	sd	ra,24(sp)
    800066c0:	00913423          	sd	s1,8(sp)
    800066c4:	02010413          	addi	s0,sp,32
    800066c8:	0ff7f713          	andi	a4,a5,255
    800066cc:	00900693          	li	a3,9
    800066d0:	04d70c63          	beq	a4,a3,80006728 <devintr+0x84>
    800066d4:	fff00713          	li	a4,-1
    800066d8:	03f71713          	slli	a4,a4,0x3f
    800066dc:	00170713          	addi	a4,a4,1
    800066e0:	00e78c63          	beq	a5,a4,800066f8 <devintr+0x54>
    800066e4:	01813083          	ld	ra,24(sp)
    800066e8:	01013403          	ld	s0,16(sp)
    800066ec:	00813483          	ld	s1,8(sp)
    800066f0:	02010113          	addi	sp,sp,32
    800066f4:	00008067          	ret
    800066f8:	00000097          	auipc	ra,0x0
    800066fc:	c8c080e7          	jalr	-884(ra) # 80006384 <cpuid>
    80006700:	06050663          	beqz	a0,8000676c <devintr+0xc8>
    80006704:	144027f3          	csrr	a5,sip
    80006708:	ffd7f793          	andi	a5,a5,-3
    8000670c:	14479073          	csrw	sip,a5
    80006710:	01813083          	ld	ra,24(sp)
    80006714:	01013403          	ld	s0,16(sp)
    80006718:	00813483          	ld	s1,8(sp)
    8000671c:	00200513          	li	a0,2
    80006720:	02010113          	addi	sp,sp,32
    80006724:	00008067          	ret
    80006728:	00000097          	auipc	ra,0x0
    8000672c:	24c080e7          	jalr	588(ra) # 80006974 <plic_claim>
    80006730:	00a00793          	li	a5,10
    80006734:	00050493          	mv	s1,a0
    80006738:	06f50663          	beq	a0,a5,800067a4 <devintr+0x100>
    8000673c:	00100513          	li	a0,1
    80006740:	fa0482e3          	beqz	s1,800066e4 <devintr+0x40>
    80006744:	00048593          	mv	a1,s1
    80006748:	00003517          	auipc	a0,0x3
    8000674c:	e5850513          	addi	a0,a0,-424 # 800095a0 <CONSOLE_STATUS+0x590>
    80006750:	00000097          	auipc	ra,0x0
    80006754:	668080e7          	jalr	1640(ra) # 80006db8 <__printf>
    80006758:	00048513          	mv	a0,s1
    8000675c:	00000097          	auipc	ra,0x0
    80006760:	250080e7          	jalr	592(ra) # 800069ac <plic_complete>
    80006764:	00100513          	li	a0,1
    80006768:	f7dff06f          	j	800066e4 <devintr+0x40>
    8000676c:	0000a517          	auipc	a0,0xa
    80006770:	43450513          	addi	a0,a0,1076 # 80010ba0 <tickslock>
    80006774:	00001097          	auipc	ra,0x1
    80006778:	318080e7          	jalr	792(ra) # 80007a8c <acquire>
    8000677c:	00005717          	auipc	a4,0x5
    80006780:	17870713          	addi	a4,a4,376 # 8000b8f4 <ticks>
    80006784:	00072783          	lw	a5,0(a4)
    80006788:	0000a517          	auipc	a0,0xa
    8000678c:	41850513          	addi	a0,a0,1048 # 80010ba0 <tickslock>
    80006790:	0017879b          	addiw	a5,a5,1
    80006794:	00f72023          	sw	a5,0(a4)
    80006798:	00001097          	auipc	ra,0x1
    8000679c:	3c0080e7          	jalr	960(ra) # 80007b58 <release>
    800067a0:	f65ff06f          	j	80006704 <devintr+0x60>
    800067a4:	00001097          	auipc	ra,0x1
    800067a8:	f1c080e7          	jalr	-228(ra) # 800076c0 <uartintr>
    800067ac:	fadff06f          	j	80006758 <devintr+0xb4>

00000000800067b0 <kernelvec>:
    800067b0:	f0010113          	addi	sp,sp,-256
    800067b4:	00113023          	sd	ra,0(sp)
    800067b8:	00213423          	sd	sp,8(sp)
    800067bc:	00313823          	sd	gp,16(sp)
    800067c0:	00413c23          	sd	tp,24(sp)
    800067c4:	02513023          	sd	t0,32(sp)
    800067c8:	02613423          	sd	t1,40(sp)
    800067cc:	02713823          	sd	t2,48(sp)
    800067d0:	02813c23          	sd	s0,56(sp)
    800067d4:	04913023          	sd	s1,64(sp)
    800067d8:	04a13423          	sd	a0,72(sp)
    800067dc:	04b13823          	sd	a1,80(sp)
    800067e0:	04c13c23          	sd	a2,88(sp)
    800067e4:	06d13023          	sd	a3,96(sp)
    800067e8:	06e13423          	sd	a4,104(sp)
    800067ec:	06f13823          	sd	a5,112(sp)
    800067f0:	07013c23          	sd	a6,120(sp)
    800067f4:	09113023          	sd	a7,128(sp)
    800067f8:	09213423          	sd	s2,136(sp)
    800067fc:	09313823          	sd	s3,144(sp)
    80006800:	09413c23          	sd	s4,152(sp)
    80006804:	0b513023          	sd	s5,160(sp)
    80006808:	0b613423          	sd	s6,168(sp)
    8000680c:	0b713823          	sd	s7,176(sp)
    80006810:	0b813c23          	sd	s8,184(sp)
    80006814:	0d913023          	sd	s9,192(sp)
    80006818:	0da13423          	sd	s10,200(sp)
    8000681c:	0db13823          	sd	s11,208(sp)
    80006820:	0dc13c23          	sd	t3,216(sp)
    80006824:	0fd13023          	sd	t4,224(sp)
    80006828:	0fe13423          	sd	t5,232(sp)
    8000682c:	0ff13823          	sd	t6,240(sp)
    80006830:	cd5ff0ef          	jal	ra,80006504 <kerneltrap>
    80006834:	00013083          	ld	ra,0(sp)
    80006838:	00813103          	ld	sp,8(sp)
    8000683c:	01013183          	ld	gp,16(sp)
    80006840:	02013283          	ld	t0,32(sp)
    80006844:	02813303          	ld	t1,40(sp)
    80006848:	03013383          	ld	t2,48(sp)
    8000684c:	03813403          	ld	s0,56(sp)
    80006850:	04013483          	ld	s1,64(sp)
    80006854:	04813503          	ld	a0,72(sp)
    80006858:	05013583          	ld	a1,80(sp)
    8000685c:	05813603          	ld	a2,88(sp)
    80006860:	06013683          	ld	a3,96(sp)
    80006864:	06813703          	ld	a4,104(sp)
    80006868:	07013783          	ld	a5,112(sp)
    8000686c:	07813803          	ld	a6,120(sp)
    80006870:	08013883          	ld	a7,128(sp)
    80006874:	08813903          	ld	s2,136(sp)
    80006878:	09013983          	ld	s3,144(sp)
    8000687c:	09813a03          	ld	s4,152(sp)
    80006880:	0a013a83          	ld	s5,160(sp)
    80006884:	0a813b03          	ld	s6,168(sp)
    80006888:	0b013b83          	ld	s7,176(sp)
    8000688c:	0b813c03          	ld	s8,184(sp)
    80006890:	0c013c83          	ld	s9,192(sp)
    80006894:	0c813d03          	ld	s10,200(sp)
    80006898:	0d013d83          	ld	s11,208(sp)
    8000689c:	0d813e03          	ld	t3,216(sp)
    800068a0:	0e013e83          	ld	t4,224(sp)
    800068a4:	0e813f03          	ld	t5,232(sp)
    800068a8:	0f013f83          	ld	t6,240(sp)
    800068ac:	10010113          	addi	sp,sp,256
    800068b0:	10200073          	sret
    800068b4:	00000013          	nop
    800068b8:	00000013          	nop
    800068bc:	00000013          	nop

00000000800068c0 <timervec>:
    800068c0:	34051573          	csrrw	a0,mscratch,a0
    800068c4:	00b53023          	sd	a1,0(a0)
    800068c8:	00c53423          	sd	a2,8(a0)
    800068cc:	00d53823          	sd	a3,16(a0)
    800068d0:	01853583          	ld	a1,24(a0)
    800068d4:	02053603          	ld	a2,32(a0)
    800068d8:	0005b683          	ld	a3,0(a1)
    800068dc:	00c686b3          	add	a3,a3,a2
    800068e0:	00d5b023          	sd	a3,0(a1)
    800068e4:	00200593          	li	a1,2
    800068e8:	14459073          	csrw	sip,a1
    800068ec:	01053683          	ld	a3,16(a0)
    800068f0:	00853603          	ld	a2,8(a0)
    800068f4:	00053583          	ld	a1,0(a0)
    800068f8:	34051573          	csrrw	a0,mscratch,a0
    800068fc:	30200073          	mret

0000000080006900 <plicinit>:
    80006900:	ff010113          	addi	sp,sp,-16
    80006904:	00813423          	sd	s0,8(sp)
    80006908:	01010413          	addi	s0,sp,16
    8000690c:	00813403          	ld	s0,8(sp)
    80006910:	0c0007b7          	lui	a5,0xc000
    80006914:	00100713          	li	a4,1
    80006918:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000691c:	00e7a223          	sw	a4,4(a5)
    80006920:	01010113          	addi	sp,sp,16
    80006924:	00008067          	ret

0000000080006928 <plicinithart>:
    80006928:	ff010113          	addi	sp,sp,-16
    8000692c:	00813023          	sd	s0,0(sp)
    80006930:	00113423          	sd	ra,8(sp)
    80006934:	01010413          	addi	s0,sp,16
    80006938:	00000097          	auipc	ra,0x0
    8000693c:	a4c080e7          	jalr	-1460(ra) # 80006384 <cpuid>
    80006940:	0085171b          	slliw	a4,a0,0x8
    80006944:	0c0027b7          	lui	a5,0xc002
    80006948:	00e787b3          	add	a5,a5,a4
    8000694c:	40200713          	li	a4,1026
    80006950:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006954:	00813083          	ld	ra,8(sp)
    80006958:	00013403          	ld	s0,0(sp)
    8000695c:	00d5151b          	slliw	a0,a0,0xd
    80006960:	0c2017b7          	lui	a5,0xc201
    80006964:	00a78533          	add	a0,a5,a0
    80006968:	00052023          	sw	zero,0(a0)
    8000696c:	01010113          	addi	sp,sp,16
    80006970:	00008067          	ret

0000000080006974 <plic_claim>:
    80006974:	ff010113          	addi	sp,sp,-16
    80006978:	00813023          	sd	s0,0(sp)
    8000697c:	00113423          	sd	ra,8(sp)
    80006980:	01010413          	addi	s0,sp,16
    80006984:	00000097          	auipc	ra,0x0
    80006988:	a00080e7          	jalr	-1536(ra) # 80006384 <cpuid>
    8000698c:	00813083          	ld	ra,8(sp)
    80006990:	00013403          	ld	s0,0(sp)
    80006994:	00d5151b          	slliw	a0,a0,0xd
    80006998:	0c2017b7          	lui	a5,0xc201
    8000699c:	00a78533          	add	a0,a5,a0
    800069a0:	00452503          	lw	a0,4(a0)
    800069a4:	01010113          	addi	sp,sp,16
    800069a8:	00008067          	ret

00000000800069ac <plic_complete>:
    800069ac:	fe010113          	addi	sp,sp,-32
    800069b0:	00813823          	sd	s0,16(sp)
    800069b4:	00913423          	sd	s1,8(sp)
    800069b8:	00113c23          	sd	ra,24(sp)
    800069bc:	02010413          	addi	s0,sp,32
    800069c0:	00050493          	mv	s1,a0
    800069c4:	00000097          	auipc	ra,0x0
    800069c8:	9c0080e7          	jalr	-1600(ra) # 80006384 <cpuid>
    800069cc:	01813083          	ld	ra,24(sp)
    800069d0:	01013403          	ld	s0,16(sp)
    800069d4:	00d5179b          	slliw	a5,a0,0xd
    800069d8:	0c201737          	lui	a4,0xc201
    800069dc:	00f707b3          	add	a5,a4,a5
    800069e0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800069e4:	00813483          	ld	s1,8(sp)
    800069e8:	02010113          	addi	sp,sp,32
    800069ec:	00008067          	ret

00000000800069f0 <consolewrite>:
    800069f0:	fb010113          	addi	sp,sp,-80
    800069f4:	04813023          	sd	s0,64(sp)
    800069f8:	04113423          	sd	ra,72(sp)
    800069fc:	02913c23          	sd	s1,56(sp)
    80006a00:	03213823          	sd	s2,48(sp)
    80006a04:	03313423          	sd	s3,40(sp)
    80006a08:	03413023          	sd	s4,32(sp)
    80006a0c:	01513c23          	sd	s5,24(sp)
    80006a10:	05010413          	addi	s0,sp,80
    80006a14:	06c05c63          	blez	a2,80006a8c <consolewrite+0x9c>
    80006a18:	00060993          	mv	s3,a2
    80006a1c:	00050a13          	mv	s4,a0
    80006a20:	00058493          	mv	s1,a1
    80006a24:	00000913          	li	s2,0
    80006a28:	fff00a93          	li	s5,-1
    80006a2c:	01c0006f          	j	80006a48 <consolewrite+0x58>
    80006a30:	fbf44503          	lbu	a0,-65(s0)
    80006a34:	0019091b          	addiw	s2,s2,1
    80006a38:	00148493          	addi	s1,s1,1
    80006a3c:	00001097          	auipc	ra,0x1
    80006a40:	a9c080e7          	jalr	-1380(ra) # 800074d8 <uartputc>
    80006a44:	03298063          	beq	s3,s2,80006a64 <consolewrite+0x74>
    80006a48:	00048613          	mv	a2,s1
    80006a4c:	00100693          	li	a3,1
    80006a50:	000a0593          	mv	a1,s4
    80006a54:	fbf40513          	addi	a0,s0,-65
    80006a58:	00000097          	auipc	ra,0x0
    80006a5c:	9e4080e7          	jalr	-1564(ra) # 8000643c <either_copyin>
    80006a60:	fd5518e3          	bne	a0,s5,80006a30 <consolewrite+0x40>
    80006a64:	04813083          	ld	ra,72(sp)
    80006a68:	04013403          	ld	s0,64(sp)
    80006a6c:	03813483          	ld	s1,56(sp)
    80006a70:	02813983          	ld	s3,40(sp)
    80006a74:	02013a03          	ld	s4,32(sp)
    80006a78:	01813a83          	ld	s5,24(sp)
    80006a7c:	00090513          	mv	a0,s2
    80006a80:	03013903          	ld	s2,48(sp)
    80006a84:	05010113          	addi	sp,sp,80
    80006a88:	00008067          	ret
    80006a8c:	00000913          	li	s2,0
    80006a90:	fd5ff06f          	j	80006a64 <consolewrite+0x74>

0000000080006a94 <consoleread>:
    80006a94:	f9010113          	addi	sp,sp,-112
    80006a98:	06813023          	sd	s0,96(sp)
    80006a9c:	04913c23          	sd	s1,88(sp)
    80006aa0:	05213823          	sd	s2,80(sp)
    80006aa4:	05313423          	sd	s3,72(sp)
    80006aa8:	05413023          	sd	s4,64(sp)
    80006aac:	03513c23          	sd	s5,56(sp)
    80006ab0:	03613823          	sd	s6,48(sp)
    80006ab4:	03713423          	sd	s7,40(sp)
    80006ab8:	03813023          	sd	s8,32(sp)
    80006abc:	06113423          	sd	ra,104(sp)
    80006ac0:	01913c23          	sd	s9,24(sp)
    80006ac4:	07010413          	addi	s0,sp,112
    80006ac8:	00060b93          	mv	s7,a2
    80006acc:	00050913          	mv	s2,a0
    80006ad0:	00058c13          	mv	s8,a1
    80006ad4:	00060b1b          	sext.w	s6,a2
    80006ad8:	0000a497          	auipc	s1,0xa
    80006adc:	0f048493          	addi	s1,s1,240 # 80010bc8 <cons>
    80006ae0:	00400993          	li	s3,4
    80006ae4:	fff00a13          	li	s4,-1
    80006ae8:	00a00a93          	li	s5,10
    80006aec:	05705e63          	blez	s7,80006b48 <consoleread+0xb4>
    80006af0:	09c4a703          	lw	a4,156(s1)
    80006af4:	0984a783          	lw	a5,152(s1)
    80006af8:	0007071b          	sext.w	a4,a4
    80006afc:	08e78463          	beq	a5,a4,80006b84 <consoleread+0xf0>
    80006b00:	07f7f713          	andi	a4,a5,127
    80006b04:	00e48733          	add	a4,s1,a4
    80006b08:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006b0c:	0017869b          	addiw	a3,a5,1
    80006b10:	08d4ac23          	sw	a3,152(s1)
    80006b14:	00070c9b          	sext.w	s9,a4
    80006b18:	0b370663          	beq	a4,s3,80006bc4 <consoleread+0x130>
    80006b1c:	00100693          	li	a3,1
    80006b20:	f9f40613          	addi	a2,s0,-97
    80006b24:	000c0593          	mv	a1,s8
    80006b28:	00090513          	mv	a0,s2
    80006b2c:	f8e40fa3          	sb	a4,-97(s0)
    80006b30:	00000097          	auipc	ra,0x0
    80006b34:	8c0080e7          	jalr	-1856(ra) # 800063f0 <either_copyout>
    80006b38:	01450863          	beq	a0,s4,80006b48 <consoleread+0xb4>
    80006b3c:	001c0c13          	addi	s8,s8,1
    80006b40:	fffb8b9b          	addiw	s7,s7,-1
    80006b44:	fb5c94e3          	bne	s9,s5,80006aec <consoleread+0x58>
    80006b48:	000b851b          	sext.w	a0,s7
    80006b4c:	06813083          	ld	ra,104(sp)
    80006b50:	06013403          	ld	s0,96(sp)
    80006b54:	05813483          	ld	s1,88(sp)
    80006b58:	05013903          	ld	s2,80(sp)
    80006b5c:	04813983          	ld	s3,72(sp)
    80006b60:	04013a03          	ld	s4,64(sp)
    80006b64:	03813a83          	ld	s5,56(sp)
    80006b68:	02813b83          	ld	s7,40(sp)
    80006b6c:	02013c03          	ld	s8,32(sp)
    80006b70:	01813c83          	ld	s9,24(sp)
    80006b74:	40ab053b          	subw	a0,s6,a0
    80006b78:	03013b03          	ld	s6,48(sp)
    80006b7c:	07010113          	addi	sp,sp,112
    80006b80:	00008067          	ret
    80006b84:	00001097          	auipc	ra,0x1
    80006b88:	1d8080e7          	jalr	472(ra) # 80007d5c <push_on>
    80006b8c:	0984a703          	lw	a4,152(s1)
    80006b90:	09c4a783          	lw	a5,156(s1)
    80006b94:	0007879b          	sext.w	a5,a5
    80006b98:	fef70ce3          	beq	a4,a5,80006b90 <consoleread+0xfc>
    80006b9c:	00001097          	auipc	ra,0x1
    80006ba0:	234080e7          	jalr	564(ra) # 80007dd0 <pop_on>
    80006ba4:	0984a783          	lw	a5,152(s1)
    80006ba8:	07f7f713          	andi	a4,a5,127
    80006bac:	00e48733          	add	a4,s1,a4
    80006bb0:	01874703          	lbu	a4,24(a4)
    80006bb4:	0017869b          	addiw	a3,a5,1
    80006bb8:	08d4ac23          	sw	a3,152(s1)
    80006bbc:	00070c9b          	sext.w	s9,a4
    80006bc0:	f5371ee3          	bne	a4,s3,80006b1c <consoleread+0x88>
    80006bc4:	000b851b          	sext.w	a0,s7
    80006bc8:	f96bf2e3          	bgeu	s7,s6,80006b4c <consoleread+0xb8>
    80006bcc:	08f4ac23          	sw	a5,152(s1)
    80006bd0:	f7dff06f          	j	80006b4c <consoleread+0xb8>

0000000080006bd4 <consputc>:
    80006bd4:	10000793          	li	a5,256
    80006bd8:	00f50663          	beq	a0,a5,80006be4 <consputc+0x10>
    80006bdc:	00001317          	auipc	t1,0x1
    80006be0:	9f430067          	jr	-1548(t1) # 800075d0 <uartputc_sync>
    80006be4:	ff010113          	addi	sp,sp,-16
    80006be8:	00113423          	sd	ra,8(sp)
    80006bec:	00813023          	sd	s0,0(sp)
    80006bf0:	01010413          	addi	s0,sp,16
    80006bf4:	00800513          	li	a0,8
    80006bf8:	00001097          	auipc	ra,0x1
    80006bfc:	9d8080e7          	jalr	-1576(ra) # 800075d0 <uartputc_sync>
    80006c00:	02000513          	li	a0,32
    80006c04:	00001097          	auipc	ra,0x1
    80006c08:	9cc080e7          	jalr	-1588(ra) # 800075d0 <uartputc_sync>
    80006c0c:	00013403          	ld	s0,0(sp)
    80006c10:	00813083          	ld	ra,8(sp)
    80006c14:	00800513          	li	a0,8
    80006c18:	01010113          	addi	sp,sp,16
    80006c1c:	00001317          	auipc	t1,0x1
    80006c20:	9b430067          	jr	-1612(t1) # 800075d0 <uartputc_sync>

0000000080006c24 <consoleintr>:
    80006c24:	fe010113          	addi	sp,sp,-32
    80006c28:	00813823          	sd	s0,16(sp)
    80006c2c:	00913423          	sd	s1,8(sp)
    80006c30:	01213023          	sd	s2,0(sp)
    80006c34:	00113c23          	sd	ra,24(sp)
    80006c38:	02010413          	addi	s0,sp,32
    80006c3c:	0000a917          	auipc	s2,0xa
    80006c40:	f8c90913          	addi	s2,s2,-116 # 80010bc8 <cons>
    80006c44:	00050493          	mv	s1,a0
    80006c48:	00090513          	mv	a0,s2
    80006c4c:	00001097          	auipc	ra,0x1
    80006c50:	e40080e7          	jalr	-448(ra) # 80007a8c <acquire>
    80006c54:	02048c63          	beqz	s1,80006c8c <consoleintr+0x68>
    80006c58:	0a092783          	lw	a5,160(s2)
    80006c5c:	09892703          	lw	a4,152(s2)
    80006c60:	07f00693          	li	a3,127
    80006c64:	40e7873b          	subw	a4,a5,a4
    80006c68:	02e6e263          	bltu	a3,a4,80006c8c <consoleintr+0x68>
    80006c6c:	00d00713          	li	a4,13
    80006c70:	04e48063          	beq	s1,a4,80006cb0 <consoleintr+0x8c>
    80006c74:	07f7f713          	andi	a4,a5,127
    80006c78:	00e90733          	add	a4,s2,a4
    80006c7c:	0017879b          	addiw	a5,a5,1
    80006c80:	0af92023          	sw	a5,160(s2)
    80006c84:	00970c23          	sb	s1,24(a4)
    80006c88:	08f92e23          	sw	a5,156(s2)
    80006c8c:	01013403          	ld	s0,16(sp)
    80006c90:	01813083          	ld	ra,24(sp)
    80006c94:	00813483          	ld	s1,8(sp)
    80006c98:	00013903          	ld	s2,0(sp)
    80006c9c:	0000a517          	auipc	a0,0xa
    80006ca0:	f2c50513          	addi	a0,a0,-212 # 80010bc8 <cons>
    80006ca4:	02010113          	addi	sp,sp,32
    80006ca8:	00001317          	auipc	t1,0x1
    80006cac:	eb030067          	jr	-336(t1) # 80007b58 <release>
    80006cb0:	00a00493          	li	s1,10
    80006cb4:	fc1ff06f          	j	80006c74 <consoleintr+0x50>

0000000080006cb8 <consoleinit>:
    80006cb8:	fe010113          	addi	sp,sp,-32
    80006cbc:	00113c23          	sd	ra,24(sp)
    80006cc0:	00813823          	sd	s0,16(sp)
    80006cc4:	00913423          	sd	s1,8(sp)
    80006cc8:	02010413          	addi	s0,sp,32
    80006ccc:	0000a497          	auipc	s1,0xa
    80006cd0:	efc48493          	addi	s1,s1,-260 # 80010bc8 <cons>
    80006cd4:	00048513          	mv	a0,s1
    80006cd8:	00003597          	auipc	a1,0x3
    80006cdc:	92058593          	addi	a1,a1,-1760 # 800095f8 <CONSOLE_STATUS+0x5e8>
    80006ce0:	00001097          	auipc	ra,0x1
    80006ce4:	d88080e7          	jalr	-632(ra) # 80007a68 <initlock>
    80006ce8:	00000097          	auipc	ra,0x0
    80006cec:	7ac080e7          	jalr	1964(ra) # 80007494 <uartinit>
    80006cf0:	01813083          	ld	ra,24(sp)
    80006cf4:	01013403          	ld	s0,16(sp)
    80006cf8:	00000797          	auipc	a5,0x0
    80006cfc:	d9c78793          	addi	a5,a5,-612 # 80006a94 <consoleread>
    80006d00:	0af4bc23          	sd	a5,184(s1)
    80006d04:	00000797          	auipc	a5,0x0
    80006d08:	cec78793          	addi	a5,a5,-788 # 800069f0 <consolewrite>
    80006d0c:	0cf4b023          	sd	a5,192(s1)
    80006d10:	00813483          	ld	s1,8(sp)
    80006d14:	02010113          	addi	sp,sp,32
    80006d18:	00008067          	ret

0000000080006d1c <console_read>:
    80006d1c:	ff010113          	addi	sp,sp,-16
    80006d20:	00813423          	sd	s0,8(sp)
    80006d24:	01010413          	addi	s0,sp,16
    80006d28:	00813403          	ld	s0,8(sp)
    80006d2c:	0000a317          	auipc	t1,0xa
    80006d30:	f5433303          	ld	t1,-172(t1) # 80010c80 <devsw+0x10>
    80006d34:	01010113          	addi	sp,sp,16
    80006d38:	00030067          	jr	t1

0000000080006d3c <console_write>:
    80006d3c:	ff010113          	addi	sp,sp,-16
    80006d40:	00813423          	sd	s0,8(sp)
    80006d44:	01010413          	addi	s0,sp,16
    80006d48:	00813403          	ld	s0,8(sp)
    80006d4c:	0000a317          	auipc	t1,0xa
    80006d50:	f3c33303          	ld	t1,-196(t1) # 80010c88 <devsw+0x18>
    80006d54:	01010113          	addi	sp,sp,16
    80006d58:	00030067          	jr	t1

0000000080006d5c <panic>:
    80006d5c:	fe010113          	addi	sp,sp,-32
    80006d60:	00113c23          	sd	ra,24(sp)
    80006d64:	00813823          	sd	s0,16(sp)
    80006d68:	00913423          	sd	s1,8(sp)
    80006d6c:	02010413          	addi	s0,sp,32
    80006d70:	00050493          	mv	s1,a0
    80006d74:	00003517          	auipc	a0,0x3
    80006d78:	88c50513          	addi	a0,a0,-1908 # 80009600 <CONSOLE_STATUS+0x5f0>
    80006d7c:	0000a797          	auipc	a5,0xa
    80006d80:	fa07a623          	sw	zero,-84(a5) # 80010d28 <pr+0x18>
    80006d84:	00000097          	auipc	ra,0x0
    80006d88:	034080e7          	jalr	52(ra) # 80006db8 <__printf>
    80006d8c:	00048513          	mv	a0,s1
    80006d90:	00000097          	auipc	ra,0x0
    80006d94:	028080e7          	jalr	40(ra) # 80006db8 <__printf>
    80006d98:	00002517          	auipc	a0,0x2
    80006d9c:	32850513          	addi	a0,a0,808 # 800090c0 <CONSOLE_STATUS+0xb0>
    80006da0:	00000097          	auipc	ra,0x0
    80006da4:	018080e7          	jalr	24(ra) # 80006db8 <__printf>
    80006da8:	00100793          	li	a5,1
    80006dac:	00005717          	auipc	a4,0x5
    80006db0:	b4f72623          	sw	a5,-1204(a4) # 8000b8f8 <panicked>
    80006db4:	0000006f          	j	80006db4 <panic+0x58>

0000000080006db8 <__printf>:
    80006db8:	f3010113          	addi	sp,sp,-208
    80006dbc:	08813023          	sd	s0,128(sp)
    80006dc0:	07313423          	sd	s3,104(sp)
    80006dc4:	09010413          	addi	s0,sp,144
    80006dc8:	05813023          	sd	s8,64(sp)
    80006dcc:	08113423          	sd	ra,136(sp)
    80006dd0:	06913c23          	sd	s1,120(sp)
    80006dd4:	07213823          	sd	s2,112(sp)
    80006dd8:	07413023          	sd	s4,96(sp)
    80006ddc:	05513c23          	sd	s5,88(sp)
    80006de0:	05613823          	sd	s6,80(sp)
    80006de4:	05713423          	sd	s7,72(sp)
    80006de8:	03913c23          	sd	s9,56(sp)
    80006dec:	03a13823          	sd	s10,48(sp)
    80006df0:	03b13423          	sd	s11,40(sp)
    80006df4:	0000a317          	auipc	t1,0xa
    80006df8:	f1c30313          	addi	t1,t1,-228 # 80010d10 <pr>
    80006dfc:	01832c03          	lw	s8,24(t1)
    80006e00:	00b43423          	sd	a1,8(s0)
    80006e04:	00c43823          	sd	a2,16(s0)
    80006e08:	00d43c23          	sd	a3,24(s0)
    80006e0c:	02e43023          	sd	a4,32(s0)
    80006e10:	02f43423          	sd	a5,40(s0)
    80006e14:	03043823          	sd	a6,48(s0)
    80006e18:	03143c23          	sd	a7,56(s0)
    80006e1c:	00050993          	mv	s3,a0
    80006e20:	4a0c1663          	bnez	s8,800072cc <__printf+0x514>
    80006e24:	60098c63          	beqz	s3,8000743c <__printf+0x684>
    80006e28:	0009c503          	lbu	a0,0(s3)
    80006e2c:	00840793          	addi	a5,s0,8
    80006e30:	f6f43c23          	sd	a5,-136(s0)
    80006e34:	00000493          	li	s1,0
    80006e38:	22050063          	beqz	a0,80007058 <__printf+0x2a0>
    80006e3c:	00002a37          	lui	s4,0x2
    80006e40:	00018ab7          	lui	s5,0x18
    80006e44:	000f4b37          	lui	s6,0xf4
    80006e48:	00989bb7          	lui	s7,0x989
    80006e4c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006e50:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006e54:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006e58:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80006e5c:	00148c9b          	addiw	s9,s1,1
    80006e60:	02500793          	li	a5,37
    80006e64:	01998933          	add	s2,s3,s9
    80006e68:	38f51263          	bne	a0,a5,800071ec <__printf+0x434>
    80006e6c:	00094783          	lbu	a5,0(s2)
    80006e70:	00078c9b          	sext.w	s9,a5
    80006e74:	1e078263          	beqz	a5,80007058 <__printf+0x2a0>
    80006e78:	0024849b          	addiw	s1,s1,2
    80006e7c:	07000713          	li	a4,112
    80006e80:	00998933          	add	s2,s3,s1
    80006e84:	38e78a63          	beq	a5,a4,80007218 <__printf+0x460>
    80006e88:	20f76863          	bltu	a4,a5,80007098 <__printf+0x2e0>
    80006e8c:	42a78863          	beq	a5,a0,800072bc <__printf+0x504>
    80006e90:	06400713          	li	a4,100
    80006e94:	40e79663          	bne	a5,a4,800072a0 <__printf+0x4e8>
    80006e98:	f7843783          	ld	a5,-136(s0)
    80006e9c:	0007a603          	lw	a2,0(a5)
    80006ea0:	00878793          	addi	a5,a5,8
    80006ea4:	f6f43c23          	sd	a5,-136(s0)
    80006ea8:	42064a63          	bltz	a2,800072dc <__printf+0x524>
    80006eac:	00a00713          	li	a4,10
    80006eb0:	02e677bb          	remuw	a5,a2,a4
    80006eb4:	00002d97          	auipc	s11,0x2
    80006eb8:	774d8d93          	addi	s11,s11,1908 # 80009628 <digits>
    80006ebc:	00900593          	li	a1,9
    80006ec0:	0006051b          	sext.w	a0,a2
    80006ec4:	00000c93          	li	s9,0
    80006ec8:	02079793          	slli	a5,a5,0x20
    80006ecc:	0207d793          	srli	a5,a5,0x20
    80006ed0:	00fd87b3          	add	a5,s11,a5
    80006ed4:	0007c783          	lbu	a5,0(a5)
    80006ed8:	02e656bb          	divuw	a3,a2,a4
    80006edc:	f8f40023          	sb	a5,-128(s0)
    80006ee0:	14c5d863          	bge	a1,a2,80007030 <__printf+0x278>
    80006ee4:	06300593          	li	a1,99
    80006ee8:	00100c93          	li	s9,1
    80006eec:	02e6f7bb          	remuw	a5,a3,a4
    80006ef0:	02079793          	slli	a5,a5,0x20
    80006ef4:	0207d793          	srli	a5,a5,0x20
    80006ef8:	00fd87b3          	add	a5,s11,a5
    80006efc:	0007c783          	lbu	a5,0(a5)
    80006f00:	02e6d73b          	divuw	a4,a3,a4
    80006f04:	f8f400a3          	sb	a5,-127(s0)
    80006f08:	12a5f463          	bgeu	a1,a0,80007030 <__printf+0x278>
    80006f0c:	00a00693          	li	a3,10
    80006f10:	00900593          	li	a1,9
    80006f14:	02d777bb          	remuw	a5,a4,a3
    80006f18:	02079793          	slli	a5,a5,0x20
    80006f1c:	0207d793          	srli	a5,a5,0x20
    80006f20:	00fd87b3          	add	a5,s11,a5
    80006f24:	0007c503          	lbu	a0,0(a5)
    80006f28:	02d757bb          	divuw	a5,a4,a3
    80006f2c:	f8a40123          	sb	a0,-126(s0)
    80006f30:	48e5f263          	bgeu	a1,a4,800073b4 <__printf+0x5fc>
    80006f34:	06300513          	li	a0,99
    80006f38:	02d7f5bb          	remuw	a1,a5,a3
    80006f3c:	02059593          	slli	a1,a1,0x20
    80006f40:	0205d593          	srli	a1,a1,0x20
    80006f44:	00bd85b3          	add	a1,s11,a1
    80006f48:	0005c583          	lbu	a1,0(a1)
    80006f4c:	02d7d7bb          	divuw	a5,a5,a3
    80006f50:	f8b401a3          	sb	a1,-125(s0)
    80006f54:	48e57263          	bgeu	a0,a4,800073d8 <__printf+0x620>
    80006f58:	3e700513          	li	a0,999
    80006f5c:	02d7f5bb          	remuw	a1,a5,a3
    80006f60:	02059593          	slli	a1,a1,0x20
    80006f64:	0205d593          	srli	a1,a1,0x20
    80006f68:	00bd85b3          	add	a1,s11,a1
    80006f6c:	0005c583          	lbu	a1,0(a1)
    80006f70:	02d7d7bb          	divuw	a5,a5,a3
    80006f74:	f8b40223          	sb	a1,-124(s0)
    80006f78:	46e57663          	bgeu	a0,a4,800073e4 <__printf+0x62c>
    80006f7c:	02d7f5bb          	remuw	a1,a5,a3
    80006f80:	02059593          	slli	a1,a1,0x20
    80006f84:	0205d593          	srli	a1,a1,0x20
    80006f88:	00bd85b3          	add	a1,s11,a1
    80006f8c:	0005c583          	lbu	a1,0(a1)
    80006f90:	02d7d7bb          	divuw	a5,a5,a3
    80006f94:	f8b402a3          	sb	a1,-123(s0)
    80006f98:	46ea7863          	bgeu	s4,a4,80007408 <__printf+0x650>
    80006f9c:	02d7f5bb          	remuw	a1,a5,a3
    80006fa0:	02059593          	slli	a1,a1,0x20
    80006fa4:	0205d593          	srli	a1,a1,0x20
    80006fa8:	00bd85b3          	add	a1,s11,a1
    80006fac:	0005c583          	lbu	a1,0(a1)
    80006fb0:	02d7d7bb          	divuw	a5,a5,a3
    80006fb4:	f8b40323          	sb	a1,-122(s0)
    80006fb8:	3eeaf863          	bgeu	s5,a4,800073a8 <__printf+0x5f0>
    80006fbc:	02d7f5bb          	remuw	a1,a5,a3
    80006fc0:	02059593          	slli	a1,a1,0x20
    80006fc4:	0205d593          	srli	a1,a1,0x20
    80006fc8:	00bd85b3          	add	a1,s11,a1
    80006fcc:	0005c583          	lbu	a1,0(a1)
    80006fd0:	02d7d7bb          	divuw	a5,a5,a3
    80006fd4:	f8b403a3          	sb	a1,-121(s0)
    80006fd8:	42eb7e63          	bgeu	s6,a4,80007414 <__printf+0x65c>
    80006fdc:	02d7f5bb          	remuw	a1,a5,a3
    80006fe0:	02059593          	slli	a1,a1,0x20
    80006fe4:	0205d593          	srli	a1,a1,0x20
    80006fe8:	00bd85b3          	add	a1,s11,a1
    80006fec:	0005c583          	lbu	a1,0(a1)
    80006ff0:	02d7d7bb          	divuw	a5,a5,a3
    80006ff4:	f8b40423          	sb	a1,-120(s0)
    80006ff8:	42ebfc63          	bgeu	s7,a4,80007430 <__printf+0x678>
    80006ffc:	02079793          	slli	a5,a5,0x20
    80007000:	0207d793          	srli	a5,a5,0x20
    80007004:	00fd8db3          	add	s11,s11,a5
    80007008:	000dc703          	lbu	a4,0(s11)
    8000700c:	00a00793          	li	a5,10
    80007010:	00900c93          	li	s9,9
    80007014:	f8e404a3          	sb	a4,-119(s0)
    80007018:	00065c63          	bgez	a2,80007030 <__printf+0x278>
    8000701c:	f9040713          	addi	a4,s0,-112
    80007020:	00f70733          	add	a4,a4,a5
    80007024:	02d00693          	li	a3,45
    80007028:	fed70823          	sb	a3,-16(a4)
    8000702c:	00078c93          	mv	s9,a5
    80007030:	f8040793          	addi	a5,s0,-128
    80007034:	01978cb3          	add	s9,a5,s9
    80007038:	f7f40d13          	addi	s10,s0,-129
    8000703c:	000cc503          	lbu	a0,0(s9)
    80007040:	fffc8c93          	addi	s9,s9,-1
    80007044:	00000097          	auipc	ra,0x0
    80007048:	b90080e7          	jalr	-1136(ra) # 80006bd4 <consputc>
    8000704c:	ffac98e3          	bne	s9,s10,8000703c <__printf+0x284>
    80007050:	00094503          	lbu	a0,0(s2)
    80007054:	e00514e3          	bnez	a0,80006e5c <__printf+0xa4>
    80007058:	1a0c1663          	bnez	s8,80007204 <__printf+0x44c>
    8000705c:	08813083          	ld	ra,136(sp)
    80007060:	08013403          	ld	s0,128(sp)
    80007064:	07813483          	ld	s1,120(sp)
    80007068:	07013903          	ld	s2,112(sp)
    8000706c:	06813983          	ld	s3,104(sp)
    80007070:	06013a03          	ld	s4,96(sp)
    80007074:	05813a83          	ld	s5,88(sp)
    80007078:	05013b03          	ld	s6,80(sp)
    8000707c:	04813b83          	ld	s7,72(sp)
    80007080:	04013c03          	ld	s8,64(sp)
    80007084:	03813c83          	ld	s9,56(sp)
    80007088:	03013d03          	ld	s10,48(sp)
    8000708c:	02813d83          	ld	s11,40(sp)
    80007090:	0d010113          	addi	sp,sp,208
    80007094:	00008067          	ret
    80007098:	07300713          	li	a4,115
    8000709c:	1ce78a63          	beq	a5,a4,80007270 <__printf+0x4b8>
    800070a0:	07800713          	li	a4,120
    800070a4:	1ee79e63          	bne	a5,a4,800072a0 <__printf+0x4e8>
    800070a8:	f7843783          	ld	a5,-136(s0)
    800070ac:	0007a703          	lw	a4,0(a5)
    800070b0:	00878793          	addi	a5,a5,8
    800070b4:	f6f43c23          	sd	a5,-136(s0)
    800070b8:	28074263          	bltz	a4,8000733c <__printf+0x584>
    800070bc:	00002d97          	auipc	s11,0x2
    800070c0:	56cd8d93          	addi	s11,s11,1388 # 80009628 <digits>
    800070c4:	00f77793          	andi	a5,a4,15
    800070c8:	00fd87b3          	add	a5,s11,a5
    800070cc:	0007c683          	lbu	a3,0(a5)
    800070d0:	00f00613          	li	a2,15
    800070d4:	0007079b          	sext.w	a5,a4
    800070d8:	f8d40023          	sb	a3,-128(s0)
    800070dc:	0047559b          	srliw	a1,a4,0x4
    800070e0:	0047569b          	srliw	a3,a4,0x4
    800070e4:	00000c93          	li	s9,0
    800070e8:	0ee65063          	bge	a2,a4,800071c8 <__printf+0x410>
    800070ec:	00f6f693          	andi	a3,a3,15
    800070f0:	00dd86b3          	add	a3,s11,a3
    800070f4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800070f8:	0087d79b          	srliw	a5,a5,0x8
    800070fc:	00100c93          	li	s9,1
    80007100:	f8d400a3          	sb	a3,-127(s0)
    80007104:	0cb67263          	bgeu	a2,a1,800071c8 <__printf+0x410>
    80007108:	00f7f693          	andi	a3,a5,15
    8000710c:	00dd86b3          	add	a3,s11,a3
    80007110:	0006c583          	lbu	a1,0(a3)
    80007114:	00f00613          	li	a2,15
    80007118:	0047d69b          	srliw	a3,a5,0x4
    8000711c:	f8b40123          	sb	a1,-126(s0)
    80007120:	0047d593          	srli	a1,a5,0x4
    80007124:	28f67e63          	bgeu	a2,a5,800073c0 <__printf+0x608>
    80007128:	00f6f693          	andi	a3,a3,15
    8000712c:	00dd86b3          	add	a3,s11,a3
    80007130:	0006c503          	lbu	a0,0(a3)
    80007134:	0087d813          	srli	a6,a5,0x8
    80007138:	0087d69b          	srliw	a3,a5,0x8
    8000713c:	f8a401a3          	sb	a0,-125(s0)
    80007140:	28b67663          	bgeu	a2,a1,800073cc <__printf+0x614>
    80007144:	00f6f693          	andi	a3,a3,15
    80007148:	00dd86b3          	add	a3,s11,a3
    8000714c:	0006c583          	lbu	a1,0(a3)
    80007150:	00c7d513          	srli	a0,a5,0xc
    80007154:	00c7d69b          	srliw	a3,a5,0xc
    80007158:	f8b40223          	sb	a1,-124(s0)
    8000715c:	29067a63          	bgeu	a2,a6,800073f0 <__printf+0x638>
    80007160:	00f6f693          	andi	a3,a3,15
    80007164:	00dd86b3          	add	a3,s11,a3
    80007168:	0006c583          	lbu	a1,0(a3)
    8000716c:	0107d813          	srli	a6,a5,0x10
    80007170:	0107d69b          	srliw	a3,a5,0x10
    80007174:	f8b402a3          	sb	a1,-123(s0)
    80007178:	28a67263          	bgeu	a2,a0,800073fc <__printf+0x644>
    8000717c:	00f6f693          	andi	a3,a3,15
    80007180:	00dd86b3          	add	a3,s11,a3
    80007184:	0006c683          	lbu	a3,0(a3)
    80007188:	0147d79b          	srliw	a5,a5,0x14
    8000718c:	f8d40323          	sb	a3,-122(s0)
    80007190:	21067663          	bgeu	a2,a6,8000739c <__printf+0x5e4>
    80007194:	02079793          	slli	a5,a5,0x20
    80007198:	0207d793          	srli	a5,a5,0x20
    8000719c:	00fd8db3          	add	s11,s11,a5
    800071a0:	000dc683          	lbu	a3,0(s11)
    800071a4:	00800793          	li	a5,8
    800071a8:	00700c93          	li	s9,7
    800071ac:	f8d403a3          	sb	a3,-121(s0)
    800071b0:	00075c63          	bgez	a4,800071c8 <__printf+0x410>
    800071b4:	f9040713          	addi	a4,s0,-112
    800071b8:	00f70733          	add	a4,a4,a5
    800071bc:	02d00693          	li	a3,45
    800071c0:	fed70823          	sb	a3,-16(a4)
    800071c4:	00078c93          	mv	s9,a5
    800071c8:	f8040793          	addi	a5,s0,-128
    800071cc:	01978cb3          	add	s9,a5,s9
    800071d0:	f7f40d13          	addi	s10,s0,-129
    800071d4:	000cc503          	lbu	a0,0(s9)
    800071d8:	fffc8c93          	addi	s9,s9,-1
    800071dc:	00000097          	auipc	ra,0x0
    800071e0:	9f8080e7          	jalr	-1544(ra) # 80006bd4 <consputc>
    800071e4:	ff9d18e3          	bne	s10,s9,800071d4 <__printf+0x41c>
    800071e8:	0100006f          	j	800071f8 <__printf+0x440>
    800071ec:	00000097          	auipc	ra,0x0
    800071f0:	9e8080e7          	jalr	-1560(ra) # 80006bd4 <consputc>
    800071f4:	000c8493          	mv	s1,s9
    800071f8:	00094503          	lbu	a0,0(s2)
    800071fc:	c60510e3          	bnez	a0,80006e5c <__printf+0xa4>
    80007200:	e40c0ee3          	beqz	s8,8000705c <__printf+0x2a4>
    80007204:	0000a517          	auipc	a0,0xa
    80007208:	b0c50513          	addi	a0,a0,-1268 # 80010d10 <pr>
    8000720c:	00001097          	auipc	ra,0x1
    80007210:	94c080e7          	jalr	-1716(ra) # 80007b58 <release>
    80007214:	e49ff06f          	j	8000705c <__printf+0x2a4>
    80007218:	f7843783          	ld	a5,-136(s0)
    8000721c:	03000513          	li	a0,48
    80007220:	01000d13          	li	s10,16
    80007224:	00878713          	addi	a4,a5,8
    80007228:	0007bc83          	ld	s9,0(a5)
    8000722c:	f6e43c23          	sd	a4,-136(s0)
    80007230:	00000097          	auipc	ra,0x0
    80007234:	9a4080e7          	jalr	-1628(ra) # 80006bd4 <consputc>
    80007238:	07800513          	li	a0,120
    8000723c:	00000097          	auipc	ra,0x0
    80007240:	998080e7          	jalr	-1640(ra) # 80006bd4 <consputc>
    80007244:	00002d97          	auipc	s11,0x2
    80007248:	3e4d8d93          	addi	s11,s11,996 # 80009628 <digits>
    8000724c:	03ccd793          	srli	a5,s9,0x3c
    80007250:	00fd87b3          	add	a5,s11,a5
    80007254:	0007c503          	lbu	a0,0(a5)
    80007258:	fffd0d1b          	addiw	s10,s10,-1
    8000725c:	004c9c93          	slli	s9,s9,0x4
    80007260:	00000097          	auipc	ra,0x0
    80007264:	974080e7          	jalr	-1676(ra) # 80006bd4 <consputc>
    80007268:	fe0d12e3          	bnez	s10,8000724c <__printf+0x494>
    8000726c:	f8dff06f          	j	800071f8 <__printf+0x440>
    80007270:	f7843783          	ld	a5,-136(s0)
    80007274:	0007bc83          	ld	s9,0(a5)
    80007278:	00878793          	addi	a5,a5,8
    8000727c:	f6f43c23          	sd	a5,-136(s0)
    80007280:	000c9a63          	bnez	s9,80007294 <__printf+0x4dc>
    80007284:	1080006f          	j	8000738c <__printf+0x5d4>
    80007288:	001c8c93          	addi	s9,s9,1
    8000728c:	00000097          	auipc	ra,0x0
    80007290:	948080e7          	jalr	-1720(ra) # 80006bd4 <consputc>
    80007294:	000cc503          	lbu	a0,0(s9)
    80007298:	fe0518e3          	bnez	a0,80007288 <__printf+0x4d0>
    8000729c:	f5dff06f          	j	800071f8 <__printf+0x440>
    800072a0:	02500513          	li	a0,37
    800072a4:	00000097          	auipc	ra,0x0
    800072a8:	930080e7          	jalr	-1744(ra) # 80006bd4 <consputc>
    800072ac:	000c8513          	mv	a0,s9
    800072b0:	00000097          	auipc	ra,0x0
    800072b4:	924080e7          	jalr	-1756(ra) # 80006bd4 <consputc>
    800072b8:	f41ff06f          	j	800071f8 <__printf+0x440>
    800072bc:	02500513          	li	a0,37
    800072c0:	00000097          	auipc	ra,0x0
    800072c4:	914080e7          	jalr	-1772(ra) # 80006bd4 <consputc>
    800072c8:	f31ff06f          	j	800071f8 <__printf+0x440>
    800072cc:	00030513          	mv	a0,t1
    800072d0:	00000097          	auipc	ra,0x0
    800072d4:	7bc080e7          	jalr	1980(ra) # 80007a8c <acquire>
    800072d8:	b4dff06f          	j	80006e24 <__printf+0x6c>
    800072dc:	40c0053b          	negw	a0,a2
    800072e0:	00a00713          	li	a4,10
    800072e4:	02e576bb          	remuw	a3,a0,a4
    800072e8:	00002d97          	auipc	s11,0x2
    800072ec:	340d8d93          	addi	s11,s11,832 # 80009628 <digits>
    800072f0:	ff700593          	li	a1,-9
    800072f4:	02069693          	slli	a3,a3,0x20
    800072f8:	0206d693          	srli	a3,a3,0x20
    800072fc:	00dd86b3          	add	a3,s11,a3
    80007300:	0006c683          	lbu	a3,0(a3)
    80007304:	02e557bb          	divuw	a5,a0,a4
    80007308:	f8d40023          	sb	a3,-128(s0)
    8000730c:	10b65e63          	bge	a2,a1,80007428 <__printf+0x670>
    80007310:	06300593          	li	a1,99
    80007314:	02e7f6bb          	remuw	a3,a5,a4
    80007318:	02069693          	slli	a3,a3,0x20
    8000731c:	0206d693          	srli	a3,a3,0x20
    80007320:	00dd86b3          	add	a3,s11,a3
    80007324:	0006c683          	lbu	a3,0(a3)
    80007328:	02e7d73b          	divuw	a4,a5,a4
    8000732c:	00200793          	li	a5,2
    80007330:	f8d400a3          	sb	a3,-127(s0)
    80007334:	bca5ece3          	bltu	a1,a0,80006f0c <__printf+0x154>
    80007338:	ce5ff06f          	j	8000701c <__printf+0x264>
    8000733c:	40e007bb          	negw	a5,a4
    80007340:	00002d97          	auipc	s11,0x2
    80007344:	2e8d8d93          	addi	s11,s11,744 # 80009628 <digits>
    80007348:	00f7f693          	andi	a3,a5,15
    8000734c:	00dd86b3          	add	a3,s11,a3
    80007350:	0006c583          	lbu	a1,0(a3)
    80007354:	ff100613          	li	a2,-15
    80007358:	0047d69b          	srliw	a3,a5,0x4
    8000735c:	f8b40023          	sb	a1,-128(s0)
    80007360:	0047d59b          	srliw	a1,a5,0x4
    80007364:	0ac75e63          	bge	a4,a2,80007420 <__printf+0x668>
    80007368:	00f6f693          	andi	a3,a3,15
    8000736c:	00dd86b3          	add	a3,s11,a3
    80007370:	0006c603          	lbu	a2,0(a3)
    80007374:	00f00693          	li	a3,15
    80007378:	0087d79b          	srliw	a5,a5,0x8
    8000737c:	f8c400a3          	sb	a2,-127(s0)
    80007380:	d8b6e4e3          	bltu	a3,a1,80007108 <__printf+0x350>
    80007384:	00200793          	li	a5,2
    80007388:	e2dff06f          	j	800071b4 <__printf+0x3fc>
    8000738c:	00002c97          	auipc	s9,0x2
    80007390:	27cc8c93          	addi	s9,s9,636 # 80009608 <CONSOLE_STATUS+0x5f8>
    80007394:	02800513          	li	a0,40
    80007398:	ef1ff06f          	j	80007288 <__printf+0x4d0>
    8000739c:	00700793          	li	a5,7
    800073a0:	00600c93          	li	s9,6
    800073a4:	e0dff06f          	j	800071b0 <__printf+0x3f8>
    800073a8:	00700793          	li	a5,7
    800073ac:	00600c93          	li	s9,6
    800073b0:	c69ff06f          	j	80007018 <__printf+0x260>
    800073b4:	00300793          	li	a5,3
    800073b8:	00200c93          	li	s9,2
    800073bc:	c5dff06f          	j	80007018 <__printf+0x260>
    800073c0:	00300793          	li	a5,3
    800073c4:	00200c93          	li	s9,2
    800073c8:	de9ff06f          	j	800071b0 <__printf+0x3f8>
    800073cc:	00400793          	li	a5,4
    800073d0:	00300c93          	li	s9,3
    800073d4:	dddff06f          	j	800071b0 <__printf+0x3f8>
    800073d8:	00400793          	li	a5,4
    800073dc:	00300c93          	li	s9,3
    800073e0:	c39ff06f          	j	80007018 <__printf+0x260>
    800073e4:	00500793          	li	a5,5
    800073e8:	00400c93          	li	s9,4
    800073ec:	c2dff06f          	j	80007018 <__printf+0x260>
    800073f0:	00500793          	li	a5,5
    800073f4:	00400c93          	li	s9,4
    800073f8:	db9ff06f          	j	800071b0 <__printf+0x3f8>
    800073fc:	00600793          	li	a5,6
    80007400:	00500c93          	li	s9,5
    80007404:	dadff06f          	j	800071b0 <__printf+0x3f8>
    80007408:	00600793          	li	a5,6
    8000740c:	00500c93          	li	s9,5
    80007410:	c09ff06f          	j	80007018 <__printf+0x260>
    80007414:	00800793          	li	a5,8
    80007418:	00700c93          	li	s9,7
    8000741c:	bfdff06f          	j	80007018 <__printf+0x260>
    80007420:	00100793          	li	a5,1
    80007424:	d91ff06f          	j	800071b4 <__printf+0x3fc>
    80007428:	00100793          	li	a5,1
    8000742c:	bf1ff06f          	j	8000701c <__printf+0x264>
    80007430:	00900793          	li	a5,9
    80007434:	00800c93          	li	s9,8
    80007438:	be1ff06f          	j	80007018 <__printf+0x260>
    8000743c:	00002517          	auipc	a0,0x2
    80007440:	1d450513          	addi	a0,a0,468 # 80009610 <CONSOLE_STATUS+0x600>
    80007444:	00000097          	auipc	ra,0x0
    80007448:	918080e7          	jalr	-1768(ra) # 80006d5c <panic>

000000008000744c <printfinit>:
    8000744c:	fe010113          	addi	sp,sp,-32
    80007450:	00813823          	sd	s0,16(sp)
    80007454:	00913423          	sd	s1,8(sp)
    80007458:	00113c23          	sd	ra,24(sp)
    8000745c:	02010413          	addi	s0,sp,32
    80007460:	0000a497          	auipc	s1,0xa
    80007464:	8b048493          	addi	s1,s1,-1872 # 80010d10 <pr>
    80007468:	00048513          	mv	a0,s1
    8000746c:	00002597          	auipc	a1,0x2
    80007470:	1b458593          	addi	a1,a1,436 # 80009620 <CONSOLE_STATUS+0x610>
    80007474:	00000097          	auipc	ra,0x0
    80007478:	5f4080e7          	jalr	1524(ra) # 80007a68 <initlock>
    8000747c:	01813083          	ld	ra,24(sp)
    80007480:	01013403          	ld	s0,16(sp)
    80007484:	0004ac23          	sw	zero,24(s1)
    80007488:	00813483          	ld	s1,8(sp)
    8000748c:	02010113          	addi	sp,sp,32
    80007490:	00008067          	ret

0000000080007494 <uartinit>:
    80007494:	ff010113          	addi	sp,sp,-16
    80007498:	00813423          	sd	s0,8(sp)
    8000749c:	01010413          	addi	s0,sp,16
    800074a0:	100007b7          	lui	a5,0x10000
    800074a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800074a8:	f8000713          	li	a4,-128
    800074ac:	00e781a3          	sb	a4,3(a5)
    800074b0:	00300713          	li	a4,3
    800074b4:	00e78023          	sb	a4,0(a5)
    800074b8:	000780a3          	sb	zero,1(a5)
    800074bc:	00e781a3          	sb	a4,3(a5)
    800074c0:	00700693          	li	a3,7
    800074c4:	00d78123          	sb	a3,2(a5)
    800074c8:	00e780a3          	sb	a4,1(a5)
    800074cc:	00813403          	ld	s0,8(sp)
    800074d0:	01010113          	addi	sp,sp,16
    800074d4:	00008067          	ret

00000000800074d8 <uartputc>:
    800074d8:	00004797          	auipc	a5,0x4
    800074dc:	4207a783          	lw	a5,1056(a5) # 8000b8f8 <panicked>
    800074e0:	00078463          	beqz	a5,800074e8 <uartputc+0x10>
    800074e4:	0000006f          	j	800074e4 <uartputc+0xc>
    800074e8:	fd010113          	addi	sp,sp,-48
    800074ec:	02813023          	sd	s0,32(sp)
    800074f0:	00913c23          	sd	s1,24(sp)
    800074f4:	01213823          	sd	s2,16(sp)
    800074f8:	01313423          	sd	s3,8(sp)
    800074fc:	02113423          	sd	ra,40(sp)
    80007500:	03010413          	addi	s0,sp,48
    80007504:	00004917          	auipc	s2,0x4
    80007508:	3fc90913          	addi	s2,s2,1020 # 8000b900 <uart_tx_r>
    8000750c:	00093783          	ld	a5,0(s2)
    80007510:	00004497          	auipc	s1,0x4
    80007514:	3f848493          	addi	s1,s1,1016 # 8000b908 <uart_tx_w>
    80007518:	0004b703          	ld	a4,0(s1)
    8000751c:	02078693          	addi	a3,a5,32
    80007520:	00050993          	mv	s3,a0
    80007524:	02e69c63          	bne	a3,a4,8000755c <uartputc+0x84>
    80007528:	00001097          	auipc	ra,0x1
    8000752c:	834080e7          	jalr	-1996(ra) # 80007d5c <push_on>
    80007530:	00093783          	ld	a5,0(s2)
    80007534:	0004b703          	ld	a4,0(s1)
    80007538:	02078793          	addi	a5,a5,32
    8000753c:	00e79463          	bne	a5,a4,80007544 <uartputc+0x6c>
    80007540:	0000006f          	j	80007540 <uartputc+0x68>
    80007544:	00001097          	auipc	ra,0x1
    80007548:	88c080e7          	jalr	-1908(ra) # 80007dd0 <pop_on>
    8000754c:	00093783          	ld	a5,0(s2)
    80007550:	0004b703          	ld	a4,0(s1)
    80007554:	02078693          	addi	a3,a5,32
    80007558:	fce688e3          	beq	a3,a4,80007528 <uartputc+0x50>
    8000755c:	01f77693          	andi	a3,a4,31
    80007560:	00009597          	auipc	a1,0x9
    80007564:	7d058593          	addi	a1,a1,2000 # 80010d30 <uart_tx_buf>
    80007568:	00d586b3          	add	a3,a1,a3
    8000756c:	00170713          	addi	a4,a4,1
    80007570:	01368023          	sb	s3,0(a3)
    80007574:	00e4b023          	sd	a4,0(s1)
    80007578:	10000637          	lui	a2,0x10000
    8000757c:	02f71063          	bne	a4,a5,8000759c <uartputc+0xc4>
    80007580:	0340006f          	j	800075b4 <uartputc+0xdc>
    80007584:	00074703          	lbu	a4,0(a4)
    80007588:	00f93023          	sd	a5,0(s2)
    8000758c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007590:	00093783          	ld	a5,0(s2)
    80007594:	0004b703          	ld	a4,0(s1)
    80007598:	00f70e63          	beq	a4,a5,800075b4 <uartputc+0xdc>
    8000759c:	00564683          	lbu	a3,5(a2)
    800075a0:	01f7f713          	andi	a4,a5,31
    800075a4:	00e58733          	add	a4,a1,a4
    800075a8:	0206f693          	andi	a3,a3,32
    800075ac:	00178793          	addi	a5,a5,1
    800075b0:	fc069ae3          	bnez	a3,80007584 <uartputc+0xac>
    800075b4:	02813083          	ld	ra,40(sp)
    800075b8:	02013403          	ld	s0,32(sp)
    800075bc:	01813483          	ld	s1,24(sp)
    800075c0:	01013903          	ld	s2,16(sp)
    800075c4:	00813983          	ld	s3,8(sp)
    800075c8:	03010113          	addi	sp,sp,48
    800075cc:	00008067          	ret

00000000800075d0 <uartputc_sync>:
    800075d0:	ff010113          	addi	sp,sp,-16
    800075d4:	00813423          	sd	s0,8(sp)
    800075d8:	01010413          	addi	s0,sp,16
    800075dc:	00004717          	auipc	a4,0x4
    800075e0:	31c72703          	lw	a4,796(a4) # 8000b8f8 <panicked>
    800075e4:	02071663          	bnez	a4,80007610 <uartputc_sync+0x40>
    800075e8:	00050793          	mv	a5,a0
    800075ec:	100006b7          	lui	a3,0x10000
    800075f0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800075f4:	02077713          	andi	a4,a4,32
    800075f8:	fe070ce3          	beqz	a4,800075f0 <uartputc_sync+0x20>
    800075fc:	0ff7f793          	andi	a5,a5,255
    80007600:	00f68023          	sb	a5,0(a3)
    80007604:	00813403          	ld	s0,8(sp)
    80007608:	01010113          	addi	sp,sp,16
    8000760c:	00008067          	ret
    80007610:	0000006f          	j	80007610 <uartputc_sync+0x40>

0000000080007614 <uartstart>:
    80007614:	ff010113          	addi	sp,sp,-16
    80007618:	00813423          	sd	s0,8(sp)
    8000761c:	01010413          	addi	s0,sp,16
    80007620:	00004617          	auipc	a2,0x4
    80007624:	2e060613          	addi	a2,a2,736 # 8000b900 <uart_tx_r>
    80007628:	00004517          	auipc	a0,0x4
    8000762c:	2e050513          	addi	a0,a0,736 # 8000b908 <uart_tx_w>
    80007630:	00063783          	ld	a5,0(a2)
    80007634:	00053703          	ld	a4,0(a0)
    80007638:	04f70263          	beq	a4,a5,8000767c <uartstart+0x68>
    8000763c:	100005b7          	lui	a1,0x10000
    80007640:	00009817          	auipc	a6,0x9
    80007644:	6f080813          	addi	a6,a6,1776 # 80010d30 <uart_tx_buf>
    80007648:	01c0006f          	j	80007664 <uartstart+0x50>
    8000764c:	0006c703          	lbu	a4,0(a3)
    80007650:	00f63023          	sd	a5,0(a2)
    80007654:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007658:	00063783          	ld	a5,0(a2)
    8000765c:	00053703          	ld	a4,0(a0)
    80007660:	00f70e63          	beq	a4,a5,8000767c <uartstart+0x68>
    80007664:	01f7f713          	andi	a4,a5,31
    80007668:	00e806b3          	add	a3,a6,a4
    8000766c:	0055c703          	lbu	a4,5(a1)
    80007670:	00178793          	addi	a5,a5,1
    80007674:	02077713          	andi	a4,a4,32
    80007678:	fc071ae3          	bnez	a4,8000764c <uartstart+0x38>
    8000767c:	00813403          	ld	s0,8(sp)
    80007680:	01010113          	addi	sp,sp,16
    80007684:	00008067          	ret

0000000080007688 <uartgetc>:
    80007688:	ff010113          	addi	sp,sp,-16
    8000768c:	00813423          	sd	s0,8(sp)
    80007690:	01010413          	addi	s0,sp,16
    80007694:	10000737          	lui	a4,0x10000
    80007698:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000769c:	0017f793          	andi	a5,a5,1
    800076a0:	00078c63          	beqz	a5,800076b8 <uartgetc+0x30>
    800076a4:	00074503          	lbu	a0,0(a4)
    800076a8:	0ff57513          	andi	a0,a0,255
    800076ac:	00813403          	ld	s0,8(sp)
    800076b0:	01010113          	addi	sp,sp,16
    800076b4:	00008067          	ret
    800076b8:	fff00513          	li	a0,-1
    800076bc:	ff1ff06f          	j	800076ac <uartgetc+0x24>

00000000800076c0 <uartintr>:
    800076c0:	100007b7          	lui	a5,0x10000
    800076c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800076c8:	0017f793          	andi	a5,a5,1
    800076cc:	0a078463          	beqz	a5,80007774 <uartintr+0xb4>
    800076d0:	fe010113          	addi	sp,sp,-32
    800076d4:	00813823          	sd	s0,16(sp)
    800076d8:	00913423          	sd	s1,8(sp)
    800076dc:	00113c23          	sd	ra,24(sp)
    800076e0:	02010413          	addi	s0,sp,32
    800076e4:	100004b7          	lui	s1,0x10000
    800076e8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800076ec:	0ff57513          	andi	a0,a0,255
    800076f0:	fffff097          	auipc	ra,0xfffff
    800076f4:	534080e7          	jalr	1332(ra) # 80006c24 <consoleintr>
    800076f8:	0054c783          	lbu	a5,5(s1)
    800076fc:	0017f793          	andi	a5,a5,1
    80007700:	fe0794e3          	bnez	a5,800076e8 <uartintr+0x28>
    80007704:	00004617          	auipc	a2,0x4
    80007708:	1fc60613          	addi	a2,a2,508 # 8000b900 <uart_tx_r>
    8000770c:	00004517          	auipc	a0,0x4
    80007710:	1fc50513          	addi	a0,a0,508 # 8000b908 <uart_tx_w>
    80007714:	00063783          	ld	a5,0(a2)
    80007718:	00053703          	ld	a4,0(a0)
    8000771c:	04f70263          	beq	a4,a5,80007760 <uartintr+0xa0>
    80007720:	100005b7          	lui	a1,0x10000
    80007724:	00009817          	auipc	a6,0x9
    80007728:	60c80813          	addi	a6,a6,1548 # 80010d30 <uart_tx_buf>
    8000772c:	01c0006f          	j	80007748 <uartintr+0x88>
    80007730:	0006c703          	lbu	a4,0(a3)
    80007734:	00f63023          	sd	a5,0(a2)
    80007738:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000773c:	00063783          	ld	a5,0(a2)
    80007740:	00053703          	ld	a4,0(a0)
    80007744:	00f70e63          	beq	a4,a5,80007760 <uartintr+0xa0>
    80007748:	01f7f713          	andi	a4,a5,31
    8000774c:	00e806b3          	add	a3,a6,a4
    80007750:	0055c703          	lbu	a4,5(a1)
    80007754:	00178793          	addi	a5,a5,1
    80007758:	02077713          	andi	a4,a4,32
    8000775c:	fc071ae3          	bnez	a4,80007730 <uartintr+0x70>
    80007760:	01813083          	ld	ra,24(sp)
    80007764:	01013403          	ld	s0,16(sp)
    80007768:	00813483          	ld	s1,8(sp)
    8000776c:	02010113          	addi	sp,sp,32
    80007770:	00008067          	ret
    80007774:	00004617          	auipc	a2,0x4
    80007778:	18c60613          	addi	a2,a2,396 # 8000b900 <uart_tx_r>
    8000777c:	00004517          	auipc	a0,0x4
    80007780:	18c50513          	addi	a0,a0,396 # 8000b908 <uart_tx_w>
    80007784:	00063783          	ld	a5,0(a2)
    80007788:	00053703          	ld	a4,0(a0)
    8000778c:	04f70263          	beq	a4,a5,800077d0 <uartintr+0x110>
    80007790:	100005b7          	lui	a1,0x10000
    80007794:	00009817          	auipc	a6,0x9
    80007798:	59c80813          	addi	a6,a6,1436 # 80010d30 <uart_tx_buf>
    8000779c:	01c0006f          	j	800077b8 <uartintr+0xf8>
    800077a0:	0006c703          	lbu	a4,0(a3)
    800077a4:	00f63023          	sd	a5,0(a2)
    800077a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800077ac:	00063783          	ld	a5,0(a2)
    800077b0:	00053703          	ld	a4,0(a0)
    800077b4:	02f70063          	beq	a4,a5,800077d4 <uartintr+0x114>
    800077b8:	01f7f713          	andi	a4,a5,31
    800077bc:	00e806b3          	add	a3,a6,a4
    800077c0:	0055c703          	lbu	a4,5(a1)
    800077c4:	00178793          	addi	a5,a5,1
    800077c8:	02077713          	andi	a4,a4,32
    800077cc:	fc071ae3          	bnez	a4,800077a0 <uartintr+0xe0>
    800077d0:	00008067          	ret
    800077d4:	00008067          	ret

00000000800077d8 <kinit>:
    800077d8:	fc010113          	addi	sp,sp,-64
    800077dc:	02913423          	sd	s1,40(sp)
    800077e0:	fffff7b7          	lui	a5,0xfffff
    800077e4:	0000a497          	auipc	s1,0xa
    800077e8:	56b48493          	addi	s1,s1,1387 # 80011d4f <end+0xfff>
    800077ec:	02813823          	sd	s0,48(sp)
    800077f0:	01313c23          	sd	s3,24(sp)
    800077f4:	00f4f4b3          	and	s1,s1,a5
    800077f8:	02113c23          	sd	ra,56(sp)
    800077fc:	03213023          	sd	s2,32(sp)
    80007800:	01413823          	sd	s4,16(sp)
    80007804:	01513423          	sd	s5,8(sp)
    80007808:	04010413          	addi	s0,sp,64
    8000780c:	000017b7          	lui	a5,0x1
    80007810:	01100993          	li	s3,17
    80007814:	00f487b3          	add	a5,s1,a5
    80007818:	01b99993          	slli	s3,s3,0x1b
    8000781c:	06f9e063          	bltu	s3,a5,8000787c <kinit+0xa4>
    80007820:	00009a97          	auipc	s5,0x9
    80007824:	530a8a93          	addi	s5,s5,1328 # 80010d50 <end>
    80007828:	0754ec63          	bltu	s1,s5,800078a0 <kinit+0xc8>
    8000782c:	0734fa63          	bgeu	s1,s3,800078a0 <kinit+0xc8>
    80007830:	00088a37          	lui	s4,0x88
    80007834:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007838:	00004917          	auipc	s2,0x4
    8000783c:	0d890913          	addi	s2,s2,216 # 8000b910 <kmem>
    80007840:	00ca1a13          	slli	s4,s4,0xc
    80007844:	0140006f          	j	80007858 <kinit+0x80>
    80007848:	000017b7          	lui	a5,0x1
    8000784c:	00f484b3          	add	s1,s1,a5
    80007850:	0554e863          	bltu	s1,s5,800078a0 <kinit+0xc8>
    80007854:	0534f663          	bgeu	s1,s3,800078a0 <kinit+0xc8>
    80007858:	00001637          	lui	a2,0x1
    8000785c:	00100593          	li	a1,1
    80007860:	00048513          	mv	a0,s1
    80007864:	00000097          	auipc	ra,0x0
    80007868:	5e4080e7          	jalr	1508(ra) # 80007e48 <__memset>
    8000786c:	00093783          	ld	a5,0(s2)
    80007870:	00f4b023          	sd	a5,0(s1)
    80007874:	00993023          	sd	s1,0(s2)
    80007878:	fd4498e3          	bne	s1,s4,80007848 <kinit+0x70>
    8000787c:	03813083          	ld	ra,56(sp)
    80007880:	03013403          	ld	s0,48(sp)
    80007884:	02813483          	ld	s1,40(sp)
    80007888:	02013903          	ld	s2,32(sp)
    8000788c:	01813983          	ld	s3,24(sp)
    80007890:	01013a03          	ld	s4,16(sp)
    80007894:	00813a83          	ld	s5,8(sp)
    80007898:	04010113          	addi	sp,sp,64
    8000789c:	00008067          	ret
    800078a0:	00002517          	auipc	a0,0x2
    800078a4:	da050513          	addi	a0,a0,-608 # 80009640 <digits+0x18>
    800078a8:	fffff097          	auipc	ra,0xfffff
    800078ac:	4b4080e7          	jalr	1204(ra) # 80006d5c <panic>

00000000800078b0 <freerange>:
    800078b0:	fc010113          	addi	sp,sp,-64
    800078b4:	000017b7          	lui	a5,0x1
    800078b8:	02913423          	sd	s1,40(sp)
    800078bc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800078c0:	009504b3          	add	s1,a0,s1
    800078c4:	fffff537          	lui	a0,0xfffff
    800078c8:	02813823          	sd	s0,48(sp)
    800078cc:	02113c23          	sd	ra,56(sp)
    800078d0:	03213023          	sd	s2,32(sp)
    800078d4:	01313c23          	sd	s3,24(sp)
    800078d8:	01413823          	sd	s4,16(sp)
    800078dc:	01513423          	sd	s5,8(sp)
    800078e0:	01613023          	sd	s6,0(sp)
    800078e4:	04010413          	addi	s0,sp,64
    800078e8:	00a4f4b3          	and	s1,s1,a0
    800078ec:	00f487b3          	add	a5,s1,a5
    800078f0:	06f5e463          	bltu	a1,a5,80007958 <freerange+0xa8>
    800078f4:	00009a97          	auipc	s5,0x9
    800078f8:	45ca8a93          	addi	s5,s5,1116 # 80010d50 <end>
    800078fc:	0954e263          	bltu	s1,s5,80007980 <freerange+0xd0>
    80007900:	01100993          	li	s3,17
    80007904:	01b99993          	slli	s3,s3,0x1b
    80007908:	0734fc63          	bgeu	s1,s3,80007980 <freerange+0xd0>
    8000790c:	00058a13          	mv	s4,a1
    80007910:	00004917          	auipc	s2,0x4
    80007914:	00090913          	mv	s2,s2
    80007918:	00002b37          	lui	s6,0x2
    8000791c:	0140006f          	j	80007930 <freerange+0x80>
    80007920:	000017b7          	lui	a5,0x1
    80007924:	00f484b3          	add	s1,s1,a5
    80007928:	0554ec63          	bltu	s1,s5,80007980 <freerange+0xd0>
    8000792c:	0534fa63          	bgeu	s1,s3,80007980 <freerange+0xd0>
    80007930:	00001637          	lui	a2,0x1
    80007934:	00100593          	li	a1,1
    80007938:	00048513          	mv	a0,s1
    8000793c:	00000097          	auipc	ra,0x0
    80007940:	50c080e7          	jalr	1292(ra) # 80007e48 <__memset>
    80007944:	00093703          	ld	a4,0(s2) # 8000b910 <kmem>
    80007948:	016487b3          	add	a5,s1,s6
    8000794c:	00e4b023          	sd	a4,0(s1)
    80007950:	00993023          	sd	s1,0(s2)
    80007954:	fcfa76e3          	bgeu	s4,a5,80007920 <freerange+0x70>
    80007958:	03813083          	ld	ra,56(sp)
    8000795c:	03013403          	ld	s0,48(sp)
    80007960:	02813483          	ld	s1,40(sp)
    80007964:	02013903          	ld	s2,32(sp)
    80007968:	01813983          	ld	s3,24(sp)
    8000796c:	01013a03          	ld	s4,16(sp)
    80007970:	00813a83          	ld	s5,8(sp)
    80007974:	00013b03          	ld	s6,0(sp)
    80007978:	04010113          	addi	sp,sp,64
    8000797c:	00008067          	ret
    80007980:	00002517          	auipc	a0,0x2
    80007984:	cc050513          	addi	a0,a0,-832 # 80009640 <digits+0x18>
    80007988:	fffff097          	auipc	ra,0xfffff
    8000798c:	3d4080e7          	jalr	980(ra) # 80006d5c <panic>

0000000080007990 <kfree>:
    80007990:	fe010113          	addi	sp,sp,-32
    80007994:	00813823          	sd	s0,16(sp)
    80007998:	00113c23          	sd	ra,24(sp)
    8000799c:	00913423          	sd	s1,8(sp)
    800079a0:	02010413          	addi	s0,sp,32
    800079a4:	03451793          	slli	a5,a0,0x34
    800079a8:	04079c63          	bnez	a5,80007a00 <kfree+0x70>
    800079ac:	00009797          	auipc	a5,0x9
    800079b0:	3a478793          	addi	a5,a5,932 # 80010d50 <end>
    800079b4:	00050493          	mv	s1,a0
    800079b8:	04f56463          	bltu	a0,a5,80007a00 <kfree+0x70>
    800079bc:	01100793          	li	a5,17
    800079c0:	01b79793          	slli	a5,a5,0x1b
    800079c4:	02f57e63          	bgeu	a0,a5,80007a00 <kfree+0x70>
    800079c8:	00001637          	lui	a2,0x1
    800079cc:	00100593          	li	a1,1
    800079d0:	00000097          	auipc	ra,0x0
    800079d4:	478080e7          	jalr	1144(ra) # 80007e48 <__memset>
    800079d8:	00004797          	auipc	a5,0x4
    800079dc:	f3878793          	addi	a5,a5,-200 # 8000b910 <kmem>
    800079e0:	0007b703          	ld	a4,0(a5)
    800079e4:	01813083          	ld	ra,24(sp)
    800079e8:	01013403          	ld	s0,16(sp)
    800079ec:	00e4b023          	sd	a4,0(s1)
    800079f0:	0097b023          	sd	s1,0(a5)
    800079f4:	00813483          	ld	s1,8(sp)
    800079f8:	02010113          	addi	sp,sp,32
    800079fc:	00008067          	ret
    80007a00:	00002517          	auipc	a0,0x2
    80007a04:	c4050513          	addi	a0,a0,-960 # 80009640 <digits+0x18>
    80007a08:	fffff097          	auipc	ra,0xfffff
    80007a0c:	354080e7          	jalr	852(ra) # 80006d5c <panic>

0000000080007a10 <kalloc>:
    80007a10:	fe010113          	addi	sp,sp,-32
    80007a14:	00813823          	sd	s0,16(sp)
    80007a18:	00913423          	sd	s1,8(sp)
    80007a1c:	00113c23          	sd	ra,24(sp)
    80007a20:	02010413          	addi	s0,sp,32
    80007a24:	00004797          	auipc	a5,0x4
    80007a28:	eec78793          	addi	a5,a5,-276 # 8000b910 <kmem>
    80007a2c:	0007b483          	ld	s1,0(a5)
    80007a30:	02048063          	beqz	s1,80007a50 <kalloc+0x40>
    80007a34:	0004b703          	ld	a4,0(s1)
    80007a38:	00001637          	lui	a2,0x1
    80007a3c:	00500593          	li	a1,5
    80007a40:	00048513          	mv	a0,s1
    80007a44:	00e7b023          	sd	a4,0(a5)
    80007a48:	00000097          	auipc	ra,0x0
    80007a4c:	400080e7          	jalr	1024(ra) # 80007e48 <__memset>
    80007a50:	01813083          	ld	ra,24(sp)
    80007a54:	01013403          	ld	s0,16(sp)
    80007a58:	00048513          	mv	a0,s1
    80007a5c:	00813483          	ld	s1,8(sp)
    80007a60:	02010113          	addi	sp,sp,32
    80007a64:	00008067          	ret

0000000080007a68 <initlock>:
    80007a68:	ff010113          	addi	sp,sp,-16
    80007a6c:	00813423          	sd	s0,8(sp)
    80007a70:	01010413          	addi	s0,sp,16
    80007a74:	00813403          	ld	s0,8(sp)
    80007a78:	00b53423          	sd	a1,8(a0)
    80007a7c:	00052023          	sw	zero,0(a0)
    80007a80:	00053823          	sd	zero,16(a0)
    80007a84:	01010113          	addi	sp,sp,16
    80007a88:	00008067          	ret

0000000080007a8c <acquire>:
    80007a8c:	fe010113          	addi	sp,sp,-32
    80007a90:	00813823          	sd	s0,16(sp)
    80007a94:	00913423          	sd	s1,8(sp)
    80007a98:	00113c23          	sd	ra,24(sp)
    80007a9c:	01213023          	sd	s2,0(sp)
    80007aa0:	02010413          	addi	s0,sp,32
    80007aa4:	00050493          	mv	s1,a0
    80007aa8:	10002973          	csrr	s2,sstatus
    80007aac:	100027f3          	csrr	a5,sstatus
    80007ab0:	ffd7f793          	andi	a5,a5,-3
    80007ab4:	10079073          	csrw	sstatus,a5
    80007ab8:	fffff097          	auipc	ra,0xfffff
    80007abc:	8ec080e7          	jalr	-1812(ra) # 800063a4 <mycpu>
    80007ac0:	07852783          	lw	a5,120(a0)
    80007ac4:	06078e63          	beqz	a5,80007b40 <acquire+0xb4>
    80007ac8:	fffff097          	auipc	ra,0xfffff
    80007acc:	8dc080e7          	jalr	-1828(ra) # 800063a4 <mycpu>
    80007ad0:	07852783          	lw	a5,120(a0)
    80007ad4:	0004a703          	lw	a4,0(s1)
    80007ad8:	0017879b          	addiw	a5,a5,1
    80007adc:	06f52c23          	sw	a5,120(a0)
    80007ae0:	04071063          	bnez	a4,80007b20 <acquire+0x94>
    80007ae4:	00100713          	li	a4,1
    80007ae8:	00070793          	mv	a5,a4
    80007aec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007af0:	0007879b          	sext.w	a5,a5
    80007af4:	fe079ae3          	bnez	a5,80007ae8 <acquire+0x5c>
    80007af8:	0ff0000f          	fence
    80007afc:	fffff097          	auipc	ra,0xfffff
    80007b00:	8a8080e7          	jalr	-1880(ra) # 800063a4 <mycpu>
    80007b04:	01813083          	ld	ra,24(sp)
    80007b08:	01013403          	ld	s0,16(sp)
    80007b0c:	00a4b823          	sd	a0,16(s1)
    80007b10:	00013903          	ld	s2,0(sp)
    80007b14:	00813483          	ld	s1,8(sp)
    80007b18:	02010113          	addi	sp,sp,32
    80007b1c:	00008067          	ret
    80007b20:	0104b903          	ld	s2,16(s1)
    80007b24:	fffff097          	auipc	ra,0xfffff
    80007b28:	880080e7          	jalr	-1920(ra) # 800063a4 <mycpu>
    80007b2c:	faa91ce3          	bne	s2,a0,80007ae4 <acquire+0x58>
    80007b30:	00002517          	auipc	a0,0x2
    80007b34:	b1850513          	addi	a0,a0,-1256 # 80009648 <digits+0x20>
    80007b38:	fffff097          	auipc	ra,0xfffff
    80007b3c:	224080e7          	jalr	548(ra) # 80006d5c <panic>
    80007b40:	00195913          	srli	s2,s2,0x1
    80007b44:	fffff097          	auipc	ra,0xfffff
    80007b48:	860080e7          	jalr	-1952(ra) # 800063a4 <mycpu>
    80007b4c:	00197913          	andi	s2,s2,1
    80007b50:	07252e23          	sw	s2,124(a0)
    80007b54:	f75ff06f          	j	80007ac8 <acquire+0x3c>

0000000080007b58 <release>:
    80007b58:	fe010113          	addi	sp,sp,-32
    80007b5c:	00813823          	sd	s0,16(sp)
    80007b60:	00113c23          	sd	ra,24(sp)
    80007b64:	00913423          	sd	s1,8(sp)
    80007b68:	01213023          	sd	s2,0(sp)
    80007b6c:	02010413          	addi	s0,sp,32
    80007b70:	00052783          	lw	a5,0(a0)
    80007b74:	00079a63          	bnez	a5,80007b88 <release+0x30>
    80007b78:	00002517          	auipc	a0,0x2
    80007b7c:	ad850513          	addi	a0,a0,-1320 # 80009650 <digits+0x28>
    80007b80:	fffff097          	auipc	ra,0xfffff
    80007b84:	1dc080e7          	jalr	476(ra) # 80006d5c <panic>
    80007b88:	01053903          	ld	s2,16(a0)
    80007b8c:	00050493          	mv	s1,a0
    80007b90:	fffff097          	auipc	ra,0xfffff
    80007b94:	814080e7          	jalr	-2028(ra) # 800063a4 <mycpu>
    80007b98:	fea910e3          	bne	s2,a0,80007b78 <release+0x20>
    80007b9c:	0004b823          	sd	zero,16(s1)
    80007ba0:	0ff0000f          	fence
    80007ba4:	0f50000f          	fence	iorw,ow
    80007ba8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007bac:	ffffe097          	auipc	ra,0xffffe
    80007bb0:	7f8080e7          	jalr	2040(ra) # 800063a4 <mycpu>
    80007bb4:	100027f3          	csrr	a5,sstatus
    80007bb8:	0027f793          	andi	a5,a5,2
    80007bbc:	04079a63          	bnez	a5,80007c10 <release+0xb8>
    80007bc0:	07852783          	lw	a5,120(a0)
    80007bc4:	02f05e63          	blez	a5,80007c00 <release+0xa8>
    80007bc8:	fff7871b          	addiw	a4,a5,-1
    80007bcc:	06e52c23          	sw	a4,120(a0)
    80007bd0:	00071c63          	bnez	a4,80007be8 <release+0x90>
    80007bd4:	07c52783          	lw	a5,124(a0)
    80007bd8:	00078863          	beqz	a5,80007be8 <release+0x90>
    80007bdc:	100027f3          	csrr	a5,sstatus
    80007be0:	0027e793          	ori	a5,a5,2
    80007be4:	10079073          	csrw	sstatus,a5
    80007be8:	01813083          	ld	ra,24(sp)
    80007bec:	01013403          	ld	s0,16(sp)
    80007bf0:	00813483          	ld	s1,8(sp)
    80007bf4:	00013903          	ld	s2,0(sp)
    80007bf8:	02010113          	addi	sp,sp,32
    80007bfc:	00008067          	ret
    80007c00:	00002517          	auipc	a0,0x2
    80007c04:	a7050513          	addi	a0,a0,-1424 # 80009670 <digits+0x48>
    80007c08:	fffff097          	auipc	ra,0xfffff
    80007c0c:	154080e7          	jalr	340(ra) # 80006d5c <panic>
    80007c10:	00002517          	auipc	a0,0x2
    80007c14:	a4850513          	addi	a0,a0,-1464 # 80009658 <digits+0x30>
    80007c18:	fffff097          	auipc	ra,0xfffff
    80007c1c:	144080e7          	jalr	324(ra) # 80006d5c <panic>

0000000080007c20 <holding>:
    80007c20:	00052783          	lw	a5,0(a0)
    80007c24:	00079663          	bnez	a5,80007c30 <holding+0x10>
    80007c28:	00000513          	li	a0,0
    80007c2c:	00008067          	ret
    80007c30:	fe010113          	addi	sp,sp,-32
    80007c34:	00813823          	sd	s0,16(sp)
    80007c38:	00913423          	sd	s1,8(sp)
    80007c3c:	00113c23          	sd	ra,24(sp)
    80007c40:	02010413          	addi	s0,sp,32
    80007c44:	01053483          	ld	s1,16(a0)
    80007c48:	ffffe097          	auipc	ra,0xffffe
    80007c4c:	75c080e7          	jalr	1884(ra) # 800063a4 <mycpu>
    80007c50:	01813083          	ld	ra,24(sp)
    80007c54:	01013403          	ld	s0,16(sp)
    80007c58:	40a48533          	sub	a0,s1,a0
    80007c5c:	00153513          	seqz	a0,a0
    80007c60:	00813483          	ld	s1,8(sp)
    80007c64:	02010113          	addi	sp,sp,32
    80007c68:	00008067          	ret

0000000080007c6c <push_off>:
    80007c6c:	fe010113          	addi	sp,sp,-32
    80007c70:	00813823          	sd	s0,16(sp)
    80007c74:	00113c23          	sd	ra,24(sp)
    80007c78:	00913423          	sd	s1,8(sp)
    80007c7c:	02010413          	addi	s0,sp,32
    80007c80:	100024f3          	csrr	s1,sstatus
    80007c84:	100027f3          	csrr	a5,sstatus
    80007c88:	ffd7f793          	andi	a5,a5,-3
    80007c8c:	10079073          	csrw	sstatus,a5
    80007c90:	ffffe097          	auipc	ra,0xffffe
    80007c94:	714080e7          	jalr	1812(ra) # 800063a4 <mycpu>
    80007c98:	07852783          	lw	a5,120(a0)
    80007c9c:	02078663          	beqz	a5,80007cc8 <push_off+0x5c>
    80007ca0:	ffffe097          	auipc	ra,0xffffe
    80007ca4:	704080e7          	jalr	1796(ra) # 800063a4 <mycpu>
    80007ca8:	07852783          	lw	a5,120(a0)
    80007cac:	01813083          	ld	ra,24(sp)
    80007cb0:	01013403          	ld	s0,16(sp)
    80007cb4:	0017879b          	addiw	a5,a5,1
    80007cb8:	06f52c23          	sw	a5,120(a0)
    80007cbc:	00813483          	ld	s1,8(sp)
    80007cc0:	02010113          	addi	sp,sp,32
    80007cc4:	00008067          	ret
    80007cc8:	0014d493          	srli	s1,s1,0x1
    80007ccc:	ffffe097          	auipc	ra,0xffffe
    80007cd0:	6d8080e7          	jalr	1752(ra) # 800063a4 <mycpu>
    80007cd4:	0014f493          	andi	s1,s1,1
    80007cd8:	06952e23          	sw	s1,124(a0)
    80007cdc:	fc5ff06f          	j	80007ca0 <push_off+0x34>

0000000080007ce0 <pop_off>:
    80007ce0:	ff010113          	addi	sp,sp,-16
    80007ce4:	00813023          	sd	s0,0(sp)
    80007ce8:	00113423          	sd	ra,8(sp)
    80007cec:	01010413          	addi	s0,sp,16
    80007cf0:	ffffe097          	auipc	ra,0xffffe
    80007cf4:	6b4080e7          	jalr	1716(ra) # 800063a4 <mycpu>
    80007cf8:	100027f3          	csrr	a5,sstatus
    80007cfc:	0027f793          	andi	a5,a5,2
    80007d00:	04079663          	bnez	a5,80007d4c <pop_off+0x6c>
    80007d04:	07852783          	lw	a5,120(a0)
    80007d08:	02f05a63          	blez	a5,80007d3c <pop_off+0x5c>
    80007d0c:	fff7871b          	addiw	a4,a5,-1
    80007d10:	06e52c23          	sw	a4,120(a0)
    80007d14:	00071c63          	bnez	a4,80007d2c <pop_off+0x4c>
    80007d18:	07c52783          	lw	a5,124(a0)
    80007d1c:	00078863          	beqz	a5,80007d2c <pop_off+0x4c>
    80007d20:	100027f3          	csrr	a5,sstatus
    80007d24:	0027e793          	ori	a5,a5,2
    80007d28:	10079073          	csrw	sstatus,a5
    80007d2c:	00813083          	ld	ra,8(sp)
    80007d30:	00013403          	ld	s0,0(sp)
    80007d34:	01010113          	addi	sp,sp,16
    80007d38:	00008067          	ret
    80007d3c:	00002517          	auipc	a0,0x2
    80007d40:	93450513          	addi	a0,a0,-1740 # 80009670 <digits+0x48>
    80007d44:	fffff097          	auipc	ra,0xfffff
    80007d48:	018080e7          	jalr	24(ra) # 80006d5c <panic>
    80007d4c:	00002517          	auipc	a0,0x2
    80007d50:	90c50513          	addi	a0,a0,-1780 # 80009658 <digits+0x30>
    80007d54:	fffff097          	auipc	ra,0xfffff
    80007d58:	008080e7          	jalr	8(ra) # 80006d5c <panic>

0000000080007d5c <push_on>:
    80007d5c:	fe010113          	addi	sp,sp,-32
    80007d60:	00813823          	sd	s0,16(sp)
    80007d64:	00113c23          	sd	ra,24(sp)
    80007d68:	00913423          	sd	s1,8(sp)
    80007d6c:	02010413          	addi	s0,sp,32
    80007d70:	100024f3          	csrr	s1,sstatus
    80007d74:	100027f3          	csrr	a5,sstatus
    80007d78:	0027e793          	ori	a5,a5,2
    80007d7c:	10079073          	csrw	sstatus,a5
    80007d80:	ffffe097          	auipc	ra,0xffffe
    80007d84:	624080e7          	jalr	1572(ra) # 800063a4 <mycpu>
    80007d88:	07852783          	lw	a5,120(a0)
    80007d8c:	02078663          	beqz	a5,80007db8 <push_on+0x5c>
    80007d90:	ffffe097          	auipc	ra,0xffffe
    80007d94:	614080e7          	jalr	1556(ra) # 800063a4 <mycpu>
    80007d98:	07852783          	lw	a5,120(a0)
    80007d9c:	01813083          	ld	ra,24(sp)
    80007da0:	01013403          	ld	s0,16(sp)
    80007da4:	0017879b          	addiw	a5,a5,1
    80007da8:	06f52c23          	sw	a5,120(a0)
    80007dac:	00813483          	ld	s1,8(sp)
    80007db0:	02010113          	addi	sp,sp,32
    80007db4:	00008067          	ret
    80007db8:	0014d493          	srli	s1,s1,0x1
    80007dbc:	ffffe097          	auipc	ra,0xffffe
    80007dc0:	5e8080e7          	jalr	1512(ra) # 800063a4 <mycpu>
    80007dc4:	0014f493          	andi	s1,s1,1
    80007dc8:	06952e23          	sw	s1,124(a0)
    80007dcc:	fc5ff06f          	j	80007d90 <push_on+0x34>

0000000080007dd0 <pop_on>:
    80007dd0:	ff010113          	addi	sp,sp,-16
    80007dd4:	00813023          	sd	s0,0(sp)
    80007dd8:	00113423          	sd	ra,8(sp)
    80007ddc:	01010413          	addi	s0,sp,16
    80007de0:	ffffe097          	auipc	ra,0xffffe
    80007de4:	5c4080e7          	jalr	1476(ra) # 800063a4 <mycpu>
    80007de8:	100027f3          	csrr	a5,sstatus
    80007dec:	0027f793          	andi	a5,a5,2
    80007df0:	04078463          	beqz	a5,80007e38 <pop_on+0x68>
    80007df4:	07852783          	lw	a5,120(a0)
    80007df8:	02f05863          	blez	a5,80007e28 <pop_on+0x58>
    80007dfc:	fff7879b          	addiw	a5,a5,-1
    80007e00:	06f52c23          	sw	a5,120(a0)
    80007e04:	07853783          	ld	a5,120(a0)
    80007e08:	00079863          	bnez	a5,80007e18 <pop_on+0x48>
    80007e0c:	100027f3          	csrr	a5,sstatus
    80007e10:	ffd7f793          	andi	a5,a5,-3
    80007e14:	10079073          	csrw	sstatus,a5
    80007e18:	00813083          	ld	ra,8(sp)
    80007e1c:	00013403          	ld	s0,0(sp)
    80007e20:	01010113          	addi	sp,sp,16
    80007e24:	00008067          	ret
    80007e28:	00002517          	auipc	a0,0x2
    80007e2c:	87050513          	addi	a0,a0,-1936 # 80009698 <digits+0x70>
    80007e30:	fffff097          	auipc	ra,0xfffff
    80007e34:	f2c080e7          	jalr	-212(ra) # 80006d5c <panic>
    80007e38:	00002517          	auipc	a0,0x2
    80007e3c:	84050513          	addi	a0,a0,-1984 # 80009678 <digits+0x50>
    80007e40:	fffff097          	auipc	ra,0xfffff
    80007e44:	f1c080e7          	jalr	-228(ra) # 80006d5c <panic>

0000000080007e48 <__memset>:
    80007e48:	ff010113          	addi	sp,sp,-16
    80007e4c:	00813423          	sd	s0,8(sp)
    80007e50:	01010413          	addi	s0,sp,16
    80007e54:	1a060e63          	beqz	a2,80008010 <__memset+0x1c8>
    80007e58:	40a007b3          	neg	a5,a0
    80007e5c:	0077f793          	andi	a5,a5,7
    80007e60:	00778693          	addi	a3,a5,7
    80007e64:	00b00813          	li	a6,11
    80007e68:	0ff5f593          	andi	a1,a1,255
    80007e6c:	fff6071b          	addiw	a4,a2,-1
    80007e70:	1b06e663          	bltu	a3,a6,8000801c <__memset+0x1d4>
    80007e74:	1cd76463          	bltu	a4,a3,8000803c <__memset+0x1f4>
    80007e78:	1a078e63          	beqz	a5,80008034 <__memset+0x1ec>
    80007e7c:	00b50023          	sb	a1,0(a0)
    80007e80:	00100713          	li	a4,1
    80007e84:	1ae78463          	beq	a5,a4,8000802c <__memset+0x1e4>
    80007e88:	00b500a3          	sb	a1,1(a0)
    80007e8c:	00200713          	li	a4,2
    80007e90:	1ae78a63          	beq	a5,a4,80008044 <__memset+0x1fc>
    80007e94:	00b50123          	sb	a1,2(a0)
    80007e98:	00300713          	li	a4,3
    80007e9c:	18e78463          	beq	a5,a4,80008024 <__memset+0x1dc>
    80007ea0:	00b501a3          	sb	a1,3(a0)
    80007ea4:	00400713          	li	a4,4
    80007ea8:	1ae78263          	beq	a5,a4,8000804c <__memset+0x204>
    80007eac:	00b50223          	sb	a1,4(a0)
    80007eb0:	00500713          	li	a4,5
    80007eb4:	1ae78063          	beq	a5,a4,80008054 <__memset+0x20c>
    80007eb8:	00b502a3          	sb	a1,5(a0)
    80007ebc:	00700713          	li	a4,7
    80007ec0:	18e79e63          	bne	a5,a4,8000805c <__memset+0x214>
    80007ec4:	00b50323          	sb	a1,6(a0)
    80007ec8:	00700e93          	li	t4,7
    80007ecc:	00859713          	slli	a4,a1,0x8
    80007ed0:	00e5e733          	or	a4,a1,a4
    80007ed4:	01059e13          	slli	t3,a1,0x10
    80007ed8:	01c76e33          	or	t3,a4,t3
    80007edc:	01859313          	slli	t1,a1,0x18
    80007ee0:	006e6333          	or	t1,t3,t1
    80007ee4:	02059893          	slli	a7,a1,0x20
    80007ee8:	40f60e3b          	subw	t3,a2,a5
    80007eec:	011368b3          	or	a7,t1,a7
    80007ef0:	02859813          	slli	a6,a1,0x28
    80007ef4:	0108e833          	or	a6,a7,a6
    80007ef8:	03059693          	slli	a3,a1,0x30
    80007efc:	003e589b          	srliw	a7,t3,0x3
    80007f00:	00d866b3          	or	a3,a6,a3
    80007f04:	03859713          	slli	a4,a1,0x38
    80007f08:	00389813          	slli	a6,a7,0x3
    80007f0c:	00f507b3          	add	a5,a0,a5
    80007f10:	00e6e733          	or	a4,a3,a4
    80007f14:	000e089b          	sext.w	a7,t3
    80007f18:	00f806b3          	add	a3,a6,a5
    80007f1c:	00e7b023          	sd	a4,0(a5)
    80007f20:	00878793          	addi	a5,a5,8
    80007f24:	fed79ce3          	bne	a5,a3,80007f1c <__memset+0xd4>
    80007f28:	ff8e7793          	andi	a5,t3,-8
    80007f2c:	0007871b          	sext.w	a4,a5
    80007f30:	01d787bb          	addw	a5,a5,t4
    80007f34:	0ce88e63          	beq	a7,a4,80008010 <__memset+0x1c8>
    80007f38:	00f50733          	add	a4,a0,a5
    80007f3c:	00b70023          	sb	a1,0(a4)
    80007f40:	0017871b          	addiw	a4,a5,1
    80007f44:	0cc77663          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007f48:	00e50733          	add	a4,a0,a4
    80007f4c:	00b70023          	sb	a1,0(a4)
    80007f50:	0027871b          	addiw	a4,a5,2
    80007f54:	0ac77e63          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007f58:	00e50733          	add	a4,a0,a4
    80007f5c:	00b70023          	sb	a1,0(a4)
    80007f60:	0037871b          	addiw	a4,a5,3
    80007f64:	0ac77663          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007f68:	00e50733          	add	a4,a0,a4
    80007f6c:	00b70023          	sb	a1,0(a4)
    80007f70:	0047871b          	addiw	a4,a5,4
    80007f74:	08c77e63          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007f78:	00e50733          	add	a4,a0,a4
    80007f7c:	00b70023          	sb	a1,0(a4)
    80007f80:	0057871b          	addiw	a4,a5,5
    80007f84:	08c77663          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007f88:	00e50733          	add	a4,a0,a4
    80007f8c:	00b70023          	sb	a1,0(a4)
    80007f90:	0067871b          	addiw	a4,a5,6
    80007f94:	06c77e63          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007f98:	00e50733          	add	a4,a0,a4
    80007f9c:	00b70023          	sb	a1,0(a4)
    80007fa0:	0077871b          	addiw	a4,a5,7
    80007fa4:	06c77663          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007fa8:	00e50733          	add	a4,a0,a4
    80007fac:	00b70023          	sb	a1,0(a4)
    80007fb0:	0087871b          	addiw	a4,a5,8
    80007fb4:	04c77e63          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007fb8:	00e50733          	add	a4,a0,a4
    80007fbc:	00b70023          	sb	a1,0(a4)
    80007fc0:	0097871b          	addiw	a4,a5,9
    80007fc4:	04c77663          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007fc8:	00e50733          	add	a4,a0,a4
    80007fcc:	00b70023          	sb	a1,0(a4)
    80007fd0:	00a7871b          	addiw	a4,a5,10
    80007fd4:	02c77e63          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007fd8:	00e50733          	add	a4,a0,a4
    80007fdc:	00b70023          	sb	a1,0(a4)
    80007fe0:	00b7871b          	addiw	a4,a5,11
    80007fe4:	02c77663          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007fe8:	00e50733          	add	a4,a0,a4
    80007fec:	00b70023          	sb	a1,0(a4)
    80007ff0:	00c7871b          	addiw	a4,a5,12
    80007ff4:	00c77e63          	bgeu	a4,a2,80008010 <__memset+0x1c8>
    80007ff8:	00e50733          	add	a4,a0,a4
    80007ffc:	00b70023          	sb	a1,0(a4)
    80008000:	00d7879b          	addiw	a5,a5,13
    80008004:	00c7f663          	bgeu	a5,a2,80008010 <__memset+0x1c8>
    80008008:	00f507b3          	add	a5,a0,a5
    8000800c:	00b78023          	sb	a1,0(a5)
    80008010:	00813403          	ld	s0,8(sp)
    80008014:	01010113          	addi	sp,sp,16
    80008018:	00008067          	ret
    8000801c:	00b00693          	li	a3,11
    80008020:	e55ff06f          	j	80007e74 <__memset+0x2c>
    80008024:	00300e93          	li	t4,3
    80008028:	ea5ff06f          	j	80007ecc <__memset+0x84>
    8000802c:	00100e93          	li	t4,1
    80008030:	e9dff06f          	j	80007ecc <__memset+0x84>
    80008034:	00000e93          	li	t4,0
    80008038:	e95ff06f          	j	80007ecc <__memset+0x84>
    8000803c:	00000793          	li	a5,0
    80008040:	ef9ff06f          	j	80007f38 <__memset+0xf0>
    80008044:	00200e93          	li	t4,2
    80008048:	e85ff06f          	j	80007ecc <__memset+0x84>
    8000804c:	00400e93          	li	t4,4
    80008050:	e7dff06f          	j	80007ecc <__memset+0x84>
    80008054:	00500e93          	li	t4,5
    80008058:	e75ff06f          	j	80007ecc <__memset+0x84>
    8000805c:	00600e93          	li	t4,6
    80008060:	e6dff06f          	j	80007ecc <__memset+0x84>

0000000080008064 <__memmove>:
    80008064:	ff010113          	addi	sp,sp,-16
    80008068:	00813423          	sd	s0,8(sp)
    8000806c:	01010413          	addi	s0,sp,16
    80008070:	0e060863          	beqz	a2,80008160 <__memmove+0xfc>
    80008074:	fff6069b          	addiw	a3,a2,-1
    80008078:	0006881b          	sext.w	a6,a3
    8000807c:	0ea5e863          	bltu	a1,a0,8000816c <__memmove+0x108>
    80008080:	00758713          	addi	a4,a1,7
    80008084:	00a5e7b3          	or	a5,a1,a0
    80008088:	40a70733          	sub	a4,a4,a0
    8000808c:	0077f793          	andi	a5,a5,7
    80008090:	00f73713          	sltiu	a4,a4,15
    80008094:	00174713          	xori	a4,a4,1
    80008098:	0017b793          	seqz	a5,a5
    8000809c:	00e7f7b3          	and	a5,a5,a4
    800080a0:	10078863          	beqz	a5,800081b0 <__memmove+0x14c>
    800080a4:	00900793          	li	a5,9
    800080a8:	1107f463          	bgeu	a5,a6,800081b0 <__memmove+0x14c>
    800080ac:	0036581b          	srliw	a6,a2,0x3
    800080b0:	fff8081b          	addiw	a6,a6,-1
    800080b4:	02081813          	slli	a6,a6,0x20
    800080b8:	01d85893          	srli	a7,a6,0x1d
    800080bc:	00858813          	addi	a6,a1,8
    800080c0:	00058793          	mv	a5,a1
    800080c4:	00050713          	mv	a4,a0
    800080c8:	01088833          	add	a6,a7,a6
    800080cc:	0007b883          	ld	a7,0(a5)
    800080d0:	00878793          	addi	a5,a5,8
    800080d4:	00870713          	addi	a4,a4,8
    800080d8:	ff173c23          	sd	a7,-8(a4)
    800080dc:	ff0798e3          	bne	a5,a6,800080cc <__memmove+0x68>
    800080e0:	ff867713          	andi	a4,a2,-8
    800080e4:	02071793          	slli	a5,a4,0x20
    800080e8:	0207d793          	srli	a5,a5,0x20
    800080ec:	00f585b3          	add	a1,a1,a5
    800080f0:	40e686bb          	subw	a3,a3,a4
    800080f4:	00f507b3          	add	a5,a0,a5
    800080f8:	06e60463          	beq	a2,a4,80008160 <__memmove+0xfc>
    800080fc:	0005c703          	lbu	a4,0(a1)
    80008100:	00e78023          	sb	a4,0(a5)
    80008104:	04068e63          	beqz	a3,80008160 <__memmove+0xfc>
    80008108:	0015c603          	lbu	a2,1(a1)
    8000810c:	00100713          	li	a4,1
    80008110:	00c780a3          	sb	a2,1(a5)
    80008114:	04e68663          	beq	a3,a4,80008160 <__memmove+0xfc>
    80008118:	0025c603          	lbu	a2,2(a1)
    8000811c:	00200713          	li	a4,2
    80008120:	00c78123          	sb	a2,2(a5)
    80008124:	02e68e63          	beq	a3,a4,80008160 <__memmove+0xfc>
    80008128:	0035c603          	lbu	a2,3(a1)
    8000812c:	00300713          	li	a4,3
    80008130:	00c781a3          	sb	a2,3(a5)
    80008134:	02e68663          	beq	a3,a4,80008160 <__memmove+0xfc>
    80008138:	0045c603          	lbu	a2,4(a1)
    8000813c:	00400713          	li	a4,4
    80008140:	00c78223          	sb	a2,4(a5)
    80008144:	00e68e63          	beq	a3,a4,80008160 <__memmove+0xfc>
    80008148:	0055c603          	lbu	a2,5(a1)
    8000814c:	00500713          	li	a4,5
    80008150:	00c782a3          	sb	a2,5(a5)
    80008154:	00e68663          	beq	a3,a4,80008160 <__memmove+0xfc>
    80008158:	0065c703          	lbu	a4,6(a1)
    8000815c:	00e78323          	sb	a4,6(a5)
    80008160:	00813403          	ld	s0,8(sp)
    80008164:	01010113          	addi	sp,sp,16
    80008168:	00008067          	ret
    8000816c:	02061713          	slli	a4,a2,0x20
    80008170:	02075713          	srli	a4,a4,0x20
    80008174:	00e587b3          	add	a5,a1,a4
    80008178:	f0f574e3          	bgeu	a0,a5,80008080 <__memmove+0x1c>
    8000817c:	02069613          	slli	a2,a3,0x20
    80008180:	02065613          	srli	a2,a2,0x20
    80008184:	fff64613          	not	a2,a2
    80008188:	00e50733          	add	a4,a0,a4
    8000818c:	00c78633          	add	a2,a5,a2
    80008190:	fff7c683          	lbu	a3,-1(a5)
    80008194:	fff78793          	addi	a5,a5,-1
    80008198:	fff70713          	addi	a4,a4,-1
    8000819c:	00d70023          	sb	a3,0(a4)
    800081a0:	fec798e3          	bne	a5,a2,80008190 <__memmove+0x12c>
    800081a4:	00813403          	ld	s0,8(sp)
    800081a8:	01010113          	addi	sp,sp,16
    800081ac:	00008067          	ret
    800081b0:	02069713          	slli	a4,a3,0x20
    800081b4:	02075713          	srli	a4,a4,0x20
    800081b8:	00170713          	addi	a4,a4,1
    800081bc:	00e50733          	add	a4,a0,a4
    800081c0:	00050793          	mv	a5,a0
    800081c4:	0005c683          	lbu	a3,0(a1)
    800081c8:	00178793          	addi	a5,a5,1
    800081cc:	00158593          	addi	a1,a1,1
    800081d0:	fed78fa3          	sb	a3,-1(a5)
    800081d4:	fee798e3          	bne	a5,a4,800081c4 <__memmove+0x160>
    800081d8:	f89ff06f          	j	80008160 <__memmove+0xfc>
	...
