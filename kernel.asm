
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	88813103          	ld	sp,-1912(sp) # 8000b888 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	024060ef          	jal	ra,80006040 <start>

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
    800010a8:	6ec020ef          	jal	ra,80003794 <_ZN5RiscV20handleSupervisorTrapEv>

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
    800014a8:	3b47b783          	ld	a5,948(a5) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x18>
    800014ac:	0007b783          	ld	a5,0(a5)
    800014b0:	00c7d793          	srli	a5,a5,0xc
    800014b4:	00278713          	addi	a4,a5,2
    800014b8:	00c71713          	slli	a4,a4,0xc
    800014bc:	0000a697          	auipc	a3,0xa
    800014c0:	47468693          	addi	a3,a3,1140 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
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
    800014e8:	3747b783          	ld	a5,884(a5) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x18>
    800014ec:	0007b783          	ld	a5,0(a5)
    800014f0:	00c7d793          	srli	a5,a5,0xc
    800014f4:	00278713          	addi	a4,a5,2
    800014f8:	00c71713          	slli	a4,a4,0xc
    800014fc:	0000a697          	auipc	a3,0xa
    80001500:	43468693          	addi	a3,a3,1076 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001504:	00e6b023          	sd	a4,0(a3)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001508:	00178793          	addi	a5,a5,1
    8000150c:	00c79793          	slli	a5,a5,0xc
    80001510:	00f6b423          	sd	a5,8(a3)
    Buddy::BLOCKS_AVAILABLE = BUDDY_NUMBER_OF_BLOCKS;
    80001514:	000017b7          	lui	a5,0x1
    80001518:	0000a617          	auipc	a2,0xa
    8000151c:	18f63c23          	sd	a5,408(a2) # 8000b6b0 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    head[BUCKET_SIZE-1] = tail[BUCKET_SIZE-1] = (Block*)BUDDY_START_ADDR;
    80001520:	06e6b823          	sd	a4,112(a3)
    80001524:	0ce6bc23          	sd	a4,216(a3)
    head[BUCKET_SIZE-1]->next = tail[BUCKET_SIZE-1]->next = nullptr;
    80001528:	00073023          	sd	zero,0(a4)
    8000152c:	0d86b783          	ld	a5,216(a3)
    80001530:	0007b023          	sd	zero,0(a5) # 1000 <_entry-0x7ffff000>
    for(int i=0;i<BUCKET_SIZE-1;i++)
    80001534:	00000713          	li	a4,0
    80001538:	00b00793          	li	a5,11
    8000153c:	02e7c263          	blt	a5,a4,80001560 <_ZN5Buddy10initializeEv+0x88>
        head[i] = tail[i] = nullptr;
    80001540:	00371693          	slli	a3,a4,0x3
    80001544:	0000a797          	auipc	a5,0xa
    80001548:	3ec78793          	addi	a5,a5,1004 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000154c:	00d787b3          	add	a5,a5,a3
    80001550:	0007b823          	sd	zero,16(a5)
    80001554:	0607bc23          	sd	zero,120(a5)
    for(int i=0;i<BUCKET_SIZE-1;i++)
    80001558:	0017071b          	addiw	a4,a4,1
    8000155c:	fddff06f          	j	80001538 <_ZN5Buddy10initializeEv+0x60>
}
    80001560:	00813403          	ld	s0,8(sp)
    80001564:	01010113          	addi	sp,sp,16
    80001568:	00008067          	ret

000000008000156c <_ZN5Buddy8compressEm>:
void Buddy::compress(uint64 size) {
    8000156c:	fe010113          	addi	sp,sp,-32
    80001570:	00113c23          	sd	ra,24(sp)
    80001574:	00813823          	sd	s0,16(sp)
    80001578:	00913423          	sd	s1,8(sp)
    8000157c:	01213023          	sd	s2,0(sp)
    80001580:	02010413          	addi	s0,sp,32
    80001584:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Compress: ");
    80001588:	00008517          	auipc	a0,0x8
    8000158c:	a9850513          	addi	a0,a0,-1384 # 80009020 <CONSOLE_STATUS+0x10>
    80001590:	00003097          	auipc	ra,0x3
    80001594:	ad4080e7          	jalr	-1324(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(size);
    80001598:	00000613          	li	a2,0
    8000159c:	00a00593          	li	a1,10
    800015a0:	0009051b          	sext.w	a0,s2
    800015a4:	00003097          	auipc	ra,0x3
    800015a8:	b04080e7          	jalr	-1276(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString("\n");
    800015ac:	00008517          	auipc	a0,0x8
    800015b0:	b1c50513          	addi	a0,a0,-1252 # 800090c8 <CONSOLE_STATUS+0xb8>
    800015b4:	00003097          	auipc	ra,0x3
    800015b8:	ab0080e7          	jalr	-1360(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    if(size == BUCKET_SIZE-1)
    800015bc:	00c00793          	li	a5,12
    800015c0:	0af90263          	beq	s2,a5,80001664 <_ZN5Buddy8compressEm+0xf8>
    Block *curr = head[size];
    800015c4:	00391713          	slli	a4,s2,0x3
    800015c8:	0000a797          	auipc	a5,0xa
    800015cc:	36878793          	addi	a5,a5,872 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    800015d0:	00e787b3          	add	a5,a5,a4
    800015d4:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    800015d8:	00000513          	li	a0,0
    800015dc:	0140006f          	j	800015f0 <_ZN5Buddy8compressEm+0x84>
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    800015e0:	40d70733          	sub	a4,a4,a3
        if(blkNoNext == pair){
    800015e4:	04f70463          	beq	a4,a5,8000162c <_ZN5Buddy8compressEm+0xc0>
        prev = curr;
    800015e8:	00048513          	mv	a0,s1
        curr = curr->next;
    800015ec:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    800015f0:	06048a63          	beqz	s1,80001664 <_ZN5Buddy8compressEm+0xf8>
    800015f4:	0004b603          	ld	a2,0(s1)
    800015f8:	06060663          	beqz	a2,80001664 <_ZN5Buddy8compressEm+0xf8>
        uint64 blkNoCurr = ((uint64)(curr)- (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    800015fc:	0000a797          	auipc	a5,0xa
    80001600:	3347b783          	ld	a5,820(a5) # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001604:	40f48733          	sub	a4,s1,a5
    80001608:	00c75713          	srli	a4,a4,0xc
        uint64 blkNoNext = ((uint64)(curr->next)- (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    8000160c:	40f607b3          	sub	a5,a2,a5
    80001610:	00c7d793          	srli	a5,a5,0xc
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80001614:	00100693          	li	a3,1
    80001618:	012696bb          	sllw	a3,a3,s2
    8000161c:	02d775b3          	remu	a1,a4,a3
    80001620:	fc0590e3          	bnez	a1,800015e0 <_ZN5Buddy8compressEm+0x74>
    80001624:	00e68733          	add	a4,a3,a4
    80001628:	fbdff06f          	j	800015e4 <_ZN5Buddy8compressEm+0x78>
            if(prev){
    8000162c:	00050e63          	beqz	a0,80001648 <_ZN5Buddy8compressEm+0xdc>
                prev->next = blk->next;
    80001630:	00c53023          	sd	a2,0(a0)
            insert(blk, size+1);
    80001634:	00190593          	addi	a1,s2,1
    80001638:	00048513          	mv	a0,s1
    8000163c:	00000097          	auipc	ra,0x0
    80001640:	040080e7          	jalr	64(ra) # 8000167c <_ZN5Buddy6insertEPvm>
    80001644:	fa5ff06f          	j	800015e8 <_ZN5Buddy8compressEm+0x7c>
                head[size] = blk->next->next;
    80001648:	00063703          	ld	a4,0(a2)
    8000164c:	00391693          	slli	a3,s2,0x3
    80001650:	0000a797          	auipc	a5,0xa
    80001654:	2e078793          	addi	a5,a5,736 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001658:	00d787b3          	add	a5,a5,a3
    8000165c:	06e7bc23          	sd	a4,120(a5)
    80001660:	fd5ff06f          	j	80001634 <_ZN5Buddy8compressEm+0xc8>
}
    80001664:	01813083          	ld	ra,24(sp)
    80001668:	01013403          	ld	s0,16(sp)
    8000166c:	00813483          	ld	s1,8(sp)
    80001670:	00013903          	ld	s2,0(sp)
    80001674:	02010113          	addi	sp,sp,32
    80001678:	00008067          	ret

000000008000167c <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    8000167c:	fe010113          	addi	sp,sp,-32
    80001680:	00113c23          	sd	ra,24(sp)
    80001684:	00813823          	sd	s0,16(sp)
    80001688:	00913423          	sd	s1,8(sp)
    8000168c:	01213023          	sd	s2,0(sp)
    80001690:	02010413          	addi	s0,sp,32
    80001694:	00050913          	mv	s2,a0
    80001698:	00058493          	mv	s1,a1
    ConsoleUtil::printString("Insert: ");
    8000169c:	00008517          	auipc	a0,0x8
    800016a0:	99450513          	addi	a0,a0,-1644 # 80009030 <CONSOLE_STATUS+0x20>
    800016a4:	00003097          	auipc	ra,0x3
    800016a8:	9c0080e7          	jalr	-1600(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(size);
    800016ac:	00000613          	li	a2,0
    800016b0:	00a00593          	li	a1,10
    800016b4:	0004851b          	sext.w	a0,s1
    800016b8:	00003097          	auipc	ra,0x3
    800016bc:	9f0080e7          	jalr	-1552(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString("\n");
    800016c0:	00008517          	auipc	a0,0x8
    800016c4:	a0850513          	addi	a0,a0,-1528 # 800090c8 <CONSOLE_STATUS+0xb8>
    800016c8:	00003097          	auipc	ra,0x3
    800016cc:	99c080e7          	jalr	-1636(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    if(!head[size]){
    800016d0:	00349713          	slli	a4,s1,0x3
    800016d4:	0000a797          	auipc	a5,0xa
    800016d8:	25c78793          	addi	a5,a5,604 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    800016dc:	00e787b3          	add	a5,a5,a4
    800016e0:	0787b783          	ld	a5,120(a5)
    800016e4:	00078e63          	beqz	a5,80001700 <_ZN5Buddy6insertEPvm+0x84>
        if((uint64)addr < (uint64)head[size]){
    800016e8:	00090713          	mv	a4,s2
    800016ec:	04f96663          	bltu	s2,a5,80001738 <_ZN5Buddy6insertEPvm+0xbc>
            while(iter != nullptr){
    800016f0:	02078863          	beqz	a5,80001720 <_ZN5Buddy6insertEPvm+0xa4>
                if((uint64)addr < (uint64)iter) {
    800016f4:	06f76663          	bltu	a4,a5,80001760 <_ZN5Buddy6insertEPvm+0xe4>
                    iter = iter->next;
    800016f8:	0007b783          	ld	a5,0(a5)
            while(iter != nullptr){
    800016fc:	ff5ff06f          	j	800016f0 <_ZN5Buddy6insertEPvm+0x74>
        head[size] = tail[size] = (Block*)addr;
    80001700:	0000a797          	auipc	a5,0xa
    80001704:	23078793          	addi	a5,a5,560 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001708:	00e784b3          	add	s1,a5,a4
    8000170c:	0124b823          	sd	s2,16(s1)
    80001710:	0724bc23          	sd	s2,120(s1)
        head[size]->next = tail[size]->next = nullptr;
    80001714:	00093023          	sd	zero,0(s2)
    80001718:	0784b783          	ld	a5,120(s1)
    8000171c:	0007b023          	sd	zero,0(a5)
}
    80001720:	01813083          	ld	ra,24(sp)
    80001724:	01013403          	ld	s0,16(sp)
    80001728:	00813483          	ld	s1,8(sp)
    8000172c:	00013903          	ld	s2,0(sp)
    80001730:	02010113          	addi	sp,sp,32
    80001734:	00008067          	ret
            newHead->next = head[size];
    80001738:	00f93023          	sd	a5,0(s2)
            head[size] = newHead;
    8000173c:	00349713          	slli	a4,s1,0x3
    80001740:	0000a797          	auipc	a5,0xa
    80001744:	1f078793          	addi	a5,a5,496 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001748:	00e787b3          	add	a5,a5,a4
    8000174c:	0727bc23          	sd	s2,120(a5)
            compress(size);
    80001750:	00048513          	mv	a0,s1
    80001754:	00000097          	auipc	ra,0x0
    80001758:	e18080e7          	jalr	-488(ra) # 8000156c <_ZN5Buddy8compressEm>
    8000175c:	fc5ff06f          	j	80001720 <_ZN5Buddy6insertEPvm+0xa4>
                    newBlock->next = iter;
    80001760:	00f93023          	sd	a5,0(s2)
                    prev->next = newBlock;
    80001764:	01203023          	sd	s2,0(zero) # 0 <_entry-0x80000000>
                    compress(size);
    80001768:	00048513          	mv	a0,s1
    8000176c:	00000097          	auipc	ra,0x0
    80001770:	e00080e7          	jalr	-512(ra) # 8000156c <_ZN5Buddy8compressEm>
                    break;
    80001774:	fadff06f          	j	80001720 <_ZN5Buddy6insertEPvm+0xa4>

0000000080001778 <_ZN5Buddy4freeEPvm>:
void Buddy::free(void *addr, uint64 size) {
    80001778:	ff010113          	addi	sp,sp,-16
    8000177c:	00113423          	sd	ra,8(sp)
    80001780:	00813023          	sd	s0,0(sp)
    80001784:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80001788:	00000097          	auipc	ra,0x0
    8000178c:	ef4080e7          	jalr	-268(ra) # 8000167c <_ZN5Buddy6insertEPvm>
}
    80001790:	00813083          	ld	ra,8(sp)
    80001794:	00013403          	ld	s0,0(sp)
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret

00000000800017a0 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800017a0:	ff010113          	addi	sp,sp,-16
    800017a4:	00813423          	sd	s0,8(sp)
    800017a8:	01010413          	addi	s0,sp,16
    800017ac:	03c0006f          	j	800017e8 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800017b0:	00b5859b          	addiw	a1,a1,11
    800017b4:	00100713          	li	a4,1
    800017b8:	00b715bb          	sllw	a1,a4,a1
    800017bc:	00b505b3          	add	a1,a0,a1
    800017c0:	00379693          	slli	a3,a5,0x3
    800017c4:	0000a717          	auipc	a4,0xa
    800017c8:	16c70713          	addi	a4,a4,364 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    800017cc:	00d70733          	add	a4,a4,a3
    800017d0:	00b73823          	sd	a1,16(a4)
    800017d4:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    800017d8:	0005b023          	sd	zero,0(a1)
    800017dc:	07873703          	ld	a4,120(a4)
    800017e0:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800017e4:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    800017e8:	fff5879b          	addiw	a5,a1,-1
    800017ec:	04c7c863          	blt	a5,a2,8000183c <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    800017f0:	00379693          	slli	a3,a5,0x3
    800017f4:	0000a717          	auipc	a4,0xa
    800017f8:	13c70713          	addi	a4,a4,316 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    800017fc:	00d70733          	add	a4,a4,a3
    80001800:	01073683          	ld	a3,16(a4)
    80001804:	fa0686e3          	beqz	a3,800017b0 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001808:	00b5859b          	addiw	a1,a1,11
    8000180c:	00100713          	li	a4,1
    80001810:	00b715bb          	sllw	a1,a4,a1
    80001814:	00b505b3          	add	a1,a0,a1
    80001818:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    8000181c:	00379693          	slli	a3,a5,0x3
    80001820:	0000a717          	auipc	a4,0xa
    80001824:	11070713          	addi	a4,a4,272 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001828:	00d70733          	add	a4,a4,a3
    8000182c:	01073683          	ld	a3,16(a4)
    80001830:	0006b683          	ld	a3,0(a3)
    80001834:	00d73823          	sd	a3,16(a4)
    80001838:	fadff06f          	j	800017e4 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    8000183c:	00813403          	ld	s0,8(sp)
    80001840:	01010113          	addi	sp,sp,16
    80001844:	00008067          	ret

0000000080001848 <_ZN5Buddy5allocEm>:
    if(size<0 || size>=BUCKET_SIZE)
    80001848:	00c00793          	li	a5,12
    8000184c:	08a7ee63          	bltu	a5,a0,800018e8 <_ZN5Buddy5allocEm+0xa0>
void* Buddy::alloc(uint64 size) {
    80001850:	fd010113          	addi	sp,sp,-48
    80001854:	02113423          	sd	ra,40(sp)
    80001858:	02813023          	sd	s0,32(sp)
    8000185c:	00913c23          	sd	s1,24(sp)
    80001860:	01213823          	sd	s2,16(sp)
    80001864:	01313423          	sd	s3,8(sp)
    80001868:	03010413          	addi	s0,sp,48
    for(int i=size;i<BUCKET_SIZE;i++){
    8000186c:	0005099b          	sext.w	s3,a0
    80001870:	00098493          	mv	s1,s3
    Block* blk = nullptr;
    80001874:	00000513          	li	a0,0
    80001878:	0300006f          	j	800018a8 <_ZN5Buddy5allocEm+0x60>
                tail[i] = nullptr;
    8000187c:	0000a797          	auipc	a5,0xa
    80001880:	0b478793          	addi	a5,a5,180 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001884:	00d787b3          	add	a5,a5,a3
    80001888:	0007b823          	sd	zero,16(a5)
            split(blk, i, size);
    8000188c:	00098613          	mv	a2,s3
    80001890:	00048593          	mv	a1,s1
    80001894:	00090513          	mv	a0,s2
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	f08080e7          	jalr	-248(ra) # 800017a0 <_ZN5Buddy5splitEPNS_5BlockEii>
            blk = head[i];
    800018a0:	00090513          	mv	a0,s2
    for(int i=size;i<BUCKET_SIZE;i++){
    800018a4:	0014849b          	addiw	s1,s1,1
    800018a8:	00c00793          	li	a5,12
    800018ac:	0497c263          	blt	a5,s1,800018f0 <_ZN5Buddy5allocEm+0xa8>
        if(head[i] != nullptr){
    800018b0:	00349713          	slli	a4,s1,0x3
    800018b4:	0000a797          	auipc	a5,0xa
    800018b8:	07c78793          	addi	a5,a5,124 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    800018bc:	00e787b3          	add	a5,a5,a4
    800018c0:	0787b903          	ld	s2,120(a5)
    800018c4:	fe0900e3          	beqz	s2,800018a4 <_ZN5Buddy5allocEm+0x5c>
            head[i] = head[i]->next;
    800018c8:	00093703          	ld	a4,0(s2)
    800018cc:	00349693          	slli	a3,s1,0x3
    800018d0:	0000a797          	auipc	a5,0xa
    800018d4:	06078793          	addi	a5,a5,96 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    800018d8:	00d787b3          	add	a5,a5,a3
    800018dc:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    800018e0:	fa0716e3          	bnez	a4,8000188c <_ZN5Buddy5allocEm+0x44>
    800018e4:	f99ff06f          	j	8000187c <_ZN5Buddy5allocEm+0x34>
        return nullptr;
    800018e8:	00000513          	li	a0,0
}
    800018ec:	00008067          	ret
    800018f0:	02813083          	ld	ra,40(sp)
    800018f4:	02013403          	ld	s0,32(sp)
    800018f8:	01813483          	ld	s1,24(sp)
    800018fc:	01013903          	ld	s2,16(sp)
    80001900:	00813983          	ld	s3,8(sp)
    80001904:	03010113          	addi	sp,sp,48
    80001908:	00008067          	ret

000000008000190c <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    8000190c:	fe010113          	addi	sp,sp,-32
    80001910:	00113c23          	sd	ra,24(sp)
    80001914:	00813823          	sd	s0,16(sp)
    80001918:	00913423          	sd	s1,8(sp)
    8000191c:	01213023          	sd	s2,0(sp)
    80001920:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80001924:	00000913          	li	s2,0
    80001928:	0180006f          	j	80001940 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    8000192c:	00007517          	auipc	a0,0x7
    80001930:	79c50513          	addi	a0,a0,1948 # 800090c8 <CONSOLE_STATUS+0xb8>
    80001934:	00002097          	auipc	ra,0x2
    80001938:	730080e7          	jalr	1840(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    8000193c:	0019091b          	addiw	s2,s2,1
    80001940:	00c00793          	li	a5,12
    80001944:	0727c663          	blt	a5,s2,800019b0 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80001948:	00000613          	li	a2,0
    8000194c:	00a00593          	li	a1,10
    80001950:	00090513          	mv	a0,s2
    80001954:	00002097          	auipc	ra,0x2
    80001958:	754080e7          	jalr	1876(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    8000195c:	00007517          	auipc	a0,0x7
    80001960:	6cc50513          	addi	a0,a0,1740 # 80009028 <CONSOLE_STATUS+0x18>
    80001964:	00002097          	auipc	ra,0x2
    80001968:	700080e7          	jalr	1792(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    8000196c:	00391713          	slli	a4,s2,0x3
    80001970:	0000a797          	auipc	a5,0xa
    80001974:	fc078793          	addi	a5,a5,-64 # 8000b930 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001978:	00e787b3          	add	a5,a5,a4
    8000197c:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80001980:	fa0486e3          	beqz	s1,8000192c <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    80001984:	00000613          	li	a2,0
    80001988:	00a00593          	li	a1,10
    8000198c:	0004851b          	sext.w	a0,s1
    80001990:	00002097          	auipc	ra,0x2
    80001994:	718080e7          	jalr	1816(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80001998:	00007517          	auipc	a0,0x7
    8000199c:	6a850513          	addi	a0,a0,1704 # 80009040 <CONSOLE_STATUS+0x30>
    800019a0:	00002097          	auipc	ra,0x2
    800019a4:	6c4080e7          	jalr	1732(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    800019a8:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    800019ac:	fd5ff06f          	j	80001980 <_ZN5Buddy9printListEv+0x74>
    800019b0:	01813083          	ld	ra,24(sp)
    800019b4:	01013403          	ld	s0,16(sp)
    800019b8:	00813483          	ld	s1,8(sp)
    800019bc:	00013903          	ld	s2,0(sp)
    800019c0:	02010113          	addi	sp,sp,32
    800019c4:	00008067          	ret

00000000800019c8 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    800019c8:	ff010113          	addi	sp,sp,-16
    800019cc:	00113423          	sd	ra,8(sp)
    800019d0:	00813023          	sd	s0,0(sp)
    800019d4:	01010413          	addi	s0,sp,16
    800019d8:	000105b7          	lui	a1,0x10
    800019dc:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800019e0:	00100513          	li	a0,1
    800019e4:	00000097          	auipc	ra,0x0
    800019e8:	a94080e7          	jalr	-1388(ra) # 80001478 <_Z41__static_initialization_and_destruction_0ii>
    800019ec:	00813083          	ld	ra,8(sp)
    800019f0:	00013403          	ld	s0,0(sp)
    800019f4:	01010113          	addi	sp,sp,16
    800019f8:	00008067          	ret

00000000800019fc <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    800019fc:	ff010113          	addi	sp,sp,-16
    80001a00:	00113423          	sd	ra,8(sp)
    80001a04:	00813023          	sd	s0,0(sp)
    80001a08:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80001a0c:	00000097          	auipc	ra,0x0
    80001a10:	948080e7          	jalr	-1720(ra) # 80001354 <_Z9sem_closeP10_semaphore>
}
    80001a14:	00813083          	ld	ra,8(sp)
    80001a18:	00013403          	ld	s0,0(sp)
    80001a1c:	01010113          	addi	sp,sp,16
    80001a20:	00008067          	ret

0000000080001a24 <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    80001a24:	ff010113          	addi	sp,sp,-16
    80001a28:	00113423          	sd	ra,8(sp)
    80001a2c:	00813023          	sd	s0,0(sp)
    80001a30:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    80001a34:	00001097          	auipc	ra,0x1
    80001a38:	8fc080e7          	jalr	-1796(ra) # 80002330 <_ZN3TCB11thread_freeEPv>
    80001a3c:	00813083          	ld	ra,8(sp)
    80001a40:	00013403          	ld	s0,0(sp)
    80001a44:	01010113          	addi	sp,sp,16
    80001a48:	00008067          	ret

0000000080001a4c <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80001a4c:	ff010113          	addi	sp,sp,-16
    80001a50:	00813423          	sd	s0,8(sp)
    80001a54:	01010413          	addi	s0,sp,16
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
//    userMain();
    80001a58:	00813403          	ld	s0,8(sp)
    80001a5c:	01010113          	addi	sp,sp,16
    80001a60:	00008067          	ret

0000000080001a64 <_ZN6SystemC1Ev>:
    if (!initialized) {
    80001a64:	0000a797          	auipc	a5,0xa
    80001a68:	fac7c783          	lbu	a5,-84(a5) # 8000ba10 <_ZN6System11initializedE>
    80001a6c:	00078463          	beqz	a5,80001a74 <_ZN6SystemC1Ev+0x10>
    80001a70:	00008067          	ret
System::System() {
    80001a74:	fd010113          	addi	sp,sp,-48
    80001a78:	02113423          	sd	ra,40(sp)
    80001a7c:	02813023          	sd	s0,32(sp)
    80001a80:	00913c23          	sd	s1,24(sp)
    80001a84:	01213823          	sd	s2,16(sp)
    80001a88:	03010413          	addi	s0,sp,48
        initialized = true;
    80001a8c:	00100793          	li	a5,1
    80001a90:	0000a717          	auipc	a4,0xa
    80001a94:	f8f70023          	sb	a5,-128(a4) # 8000ba10 <_ZN6System11initializedE>
        RiscV::initialize();
    80001a98:	00001097          	auipc	ra,0x1
    80001a9c:	234080e7          	jalr	564(ra) # 80002ccc <_ZN5RiscV10initializeEv>
        Buddy::printList();
    80001aa0:	00000097          	auipc	ra,0x0
    80001aa4:	e6c080e7          	jalr	-404(ra) # 8000190c <_ZN5Buddy9printListEv>
        void* alloc11 = Buddy::alloc(11);
    80001aa8:	00b00513          	li	a0,11
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	d9c080e7          	jalr	-612(ra) # 80001848 <_ZN5Buddy5allocEm>
    80001ab4:	00050913          	mv	s2,a0
        void* alloc1 = Buddy::alloc(1);
    80001ab8:	00100513          	li	a0,1
    80001abc:	00000097          	auipc	ra,0x0
    80001ac0:	d8c080e7          	jalr	-628(ra) # 80001848 <_ZN5Buddy5allocEm>
    80001ac4:	00050493          	mv	s1,a0
        Buddy::printList();
    80001ac8:	00000097          	auipc	ra,0x0
    80001acc:	e44080e7          	jalr	-444(ra) # 8000190c <_ZN5Buddy9printListEv>
        ConsoleUtil::printInt((uint64)alloc1);
    80001ad0:	00000613          	li	a2,0
    80001ad4:	00a00593          	li	a1,10
    80001ad8:	0004851b          	sext.w	a0,s1
    80001adc:	00002097          	auipc	ra,0x2
    80001ae0:	5cc080e7          	jalr	1484(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80001ae4:	00007517          	auipc	a0,0x7
    80001ae8:	5e450513          	addi	a0,a0,1508 # 800090c8 <CONSOLE_STATUS+0xb8>
    80001aec:	00002097          	auipc	ra,0x2
    80001af0:	578080e7          	jalr	1400(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        Buddy::free(alloc1, 1);
    80001af4:	00100593          	li	a1,1
    80001af8:	00048513          	mv	a0,s1
    80001afc:	00000097          	auipc	ra,0x0
    80001b00:	c7c080e7          	jalr	-900(ra) # 80001778 <_ZN5Buddy4freeEPvm>
        Buddy::free(alloc11, 11);
    80001b04:	00b00593          	li	a1,11
    80001b08:	00090513          	mv	a0,s2
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	c6c080e7          	jalr	-916(ra) # 80001778 <_ZN5Buddy4freeEPvm>
        Buddy::printList();
    80001b14:	00000097          	auipc	ra,0x0
    80001b18:	df8080e7          	jalr	-520(ra) # 8000190c <_ZN5Buddy9printListEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80001b1c:	00000613          	li	a2,0
    80001b20:	00000597          	auipc	a1,0x0
    80001b24:	f2c58593          	addi	a1,a1,-212 # 80001a4c <_ZN6System15userMainWrapperEPv>
    80001b28:	fd840513          	addi	a0,s0,-40
    80001b2c:	fffff097          	auipc	ra,0xfffff
    80001b30:	684080e7          	jalr	1668(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001b34:	fd843783          	ld	a5,-40(s0)
    80001b38:	0107a703          	lw	a4,16(a5)
    80001b3c:	00200793          	li	a5,2
    80001b40:	00f70863          	beq	a4,a5,80001b50 <_ZN6SystemC1Ev+0xec>
            thread_dispatch();
    80001b44:	fffff097          	auipc	ra,0xfffff
    80001b48:	710080e7          	jalr	1808(ra) # 80001254 <_Z15thread_dispatchv>
    80001b4c:	fe9ff06f          	j	80001b34 <_ZN6SystemC1Ev+0xd0>
        RiscV::finalize();
    80001b50:	00001097          	auipc	ra,0x1
    80001b54:	35c080e7          	jalr	860(ra) # 80002eac <_ZN5RiscV8finalizeEv>
}
    80001b58:	02813083          	ld	ra,40(sp)
    80001b5c:	02013403          	ld	s0,32(sp)
    80001b60:	01813483          	ld	s1,24(sp)
    80001b64:	01013903          	ld	s2,16(sp)
    80001b68:	03010113          	addi	sp,sp,48
    80001b6c:	00008067          	ret

0000000080001b70 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001b70:	fe010113          	addi	sp,sp,-32
    80001b74:	00113c23          	sd	ra,24(sp)
    80001b78:	00813823          	sd	s0,16(sp)
    80001b7c:	00913423          	sd	s1,8(sp)
    80001b80:	02010413          	addi	s0,sp,32
    80001b84:	00050493          	mv	s1,a0
    LOCK();
    80001b88:	00100613          	li	a2,1
    80001b8c:	00000593          	li	a1,0
    80001b90:	0000a517          	auipc	a0,0xa
    80001b94:	e8850513          	addi	a0,a0,-376 # 8000ba18 <lockPrint>
    80001b98:	fffff097          	auipc	ra,0xfffff
    80001b9c:	468080e7          	jalr	1128(ra) # 80001000 <copy_and_swap>
    80001ba0:	fe0514e3          	bnez	a0,80001b88 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001ba4:	0004c503          	lbu	a0,0(s1)
    80001ba8:	00050a63          	beqz	a0,80001bbc <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	880080e7          	jalr	-1920(ra) # 8000142c <_Z4putcc>
        string++;
    80001bb4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001bb8:	fedff06f          	j	80001ba4 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80001bbc:	00000613          	li	a2,0
    80001bc0:	00100593          	li	a1,1
    80001bc4:	0000a517          	auipc	a0,0xa
    80001bc8:	e5450513          	addi	a0,a0,-428 # 8000ba18 <lockPrint>
    80001bcc:	fffff097          	auipc	ra,0xfffff
    80001bd0:	434080e7          	jalr	1076(ra) # 80001000 <copy_and_swap>
    80001bd4:	fe0514e3          	bnez	a0,80001bbc <_Z11printStringPKc+0x4c>
}
    80001bd8:	01813083          	ld	ra,24(sp)
    80001bdc:	01013403          	ld	s0,16(sp)
    80001be0:	00813483          	ld	s1,8(sp)
    80001be4:	02010113          	addi	sp,sp,32
    80001be8:	00008067          	ret

0000000080001bec <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001bec:	fd010113          	addi	sp,sp,-48
    80001bf0:	02113423          	sd	ra,40(sp)
    80001bf4:	02813023          	sd	s0,32(sp)
    80001bf8:	00913c23          	sd	s1,24(sp)
    80001bfc:	01213823          	sd	s2,16(sp)
    80001c00:	01313423          	sd	s3,8(sp)
    80001c04:	01413023          	sd	s4,0(sp)
    80001c08:	03010413          	addi	s0,sp,48
    80001c0c:	00050993          	mv	s3,a0
    80001c10:	00058a13          	mv	s4,a1
    LOCK();
    80001c14:	00100613          	li	a2,1
    80001c18:	00000593          	li	a1,0
    80001c1c:	0000a517          	auipc	a0,0xa
    80001c20:	dfc50513          	addi	a0,a0,-516 # 8000ba18 <lockPrint>
    80001c24:	fffff097          	auipc	ra,0xfffff
    80001c28:	3dc080e7          	jalr	988(ra) # 80001000 <copy_and_swap>
    80001c2c:	fe0514e3          	bnez	a0,80001c14 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001c30:	00000913          	li	s2,0
    80001c34:	00090493          	mv	s1,s2
    80001c38:	0019091b          	addiw	s2,s2,1
    80001c3c:	03495a63          	bge	s2,s4,80001c70 <_Z9getStringPci+0x84>
        cc = getc();
    80001c40:	fffff097          	auipc	ra,0xfffff
    80001c44:	7c4080e7          	jalr	1988(ra) # 80001404 <_Z4getcv>
        if(cc < 1)
    80001c48:	02050463          	beqz	a0,80001c70 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80001c4c:	009984b3          	add	s1,s3,s1
    80001c50:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001c54:	00a00793          	li	a5,10
    80001c58:	00f50a63          	beq	a0,a5,80001c6c <_Z9getStringPci+0x80>
    80001c5c:	00d00793          	li	a5,13
    80001c60:	fcf51ae3          	bne	a0,a5,80001c34 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80001c64:	00090493          	mv	s1,s2
    80001c68:	0080006f          	j	80001c70 <_Z9getStringPci+0x84>
    80001c6c:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001c70:	009984b3          	add	s1,s3,s1
    80001c74:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80001c78:	00000613          	li	a2,0
    80001c7c:	00100593          	li	a1,1
    80001c80:	0000a517          	auipc	a0,0xa
    80001c84:	d9850513          	addi	a0,a0,-616 # 8000ba18 <lockPrint>
    80001c88:	fffff097          	auipc	ra,0xfffff
    80001c8c:	378080e7          	jalr	888(ra) # 80001000 <copy_and_swap>
    80001c90:	fe0514e3          	bnez	a0,80001c78 <_Z9getStringPci+0x8c>
    return buf;
}
    80001c94:	00098513          	mv	a0,s3
    80001c98:	02813083          	ld	ra,40(sp)
    80001c9c:	02013403          	ld	s0,32(sp)
    80001ca0:	01813483          	ld	s1,24(sp)
    80001ca4:	01013903          	ld	s2,16(sp)
    80001ca8:	00813983          	ld	s3,8(sp)
    80001cac:	00013a03          	ld	s4,0(sp)
    80001cb0:	03010113          	addi	sp,sp,48
    80001cb4:	00008067          	ret

0000000080001cb8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80001cb8:	ff010113          	addi	sp,sp,-16
    80001cbc:	00813423          	sd	s0,8(sp)
    80001cc0:	01010413          	addi	s0,sp,16
    80001cc4:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80001cc8:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80001ccc:	0006c603          	lbu	a2,0(a3)
    80001cd0:	fd06071b          	addiw	a4,a2,-48
    80001cd4:	0ff77713          	andi	a4,a4,255
    80001cd8:	00900793          	li	a5,9
    80001cdc:	02e7e063          	bltu	a5,a4,80001cfc <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80001ce0:	0025179b          	slliw	a5,a0,0x2
    80001ce4:	00a787bb          	addw	a5,a5,a0
    80001ce8:	0017979b          	slliw	a5,a5,0x1
    80001cec:	00168693          	addi	a3,a3,1
    80001cf0:	00c787bb          	addw	a5,a5,a2
    80001cf4:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80001cf8:	fd5ff06f          	j	80001ccc <_Z11stringToIntPKc+0x14>
    return n;
}
    80001cfc:	00813403          	ld	s0,8(sp)
    80001d00:	01010113          	addi	sp,sp,16
    80001d04:	00008067          	ret

0000000080001d08 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80001d08:	fc010113          	addi	sp,sp,-64
    80001d0c:	02113c23          	sd	ra,56(sp)
    80001d10:	02813823          	sd	s0,48(sp)
    80001d14:	02913423          	sd	s1,40(sp)
    80001d18:	03213023          	sd	s2,32(sp)
    80001d1c:	01313c23          	sd	s3,24(sp)
    80001d20:	04010413          	addi	s0,sp,64
    80001d24:	00050493          	mv	s1,a0
    80001d28:	00058913          	mv	s2,a1
    80001d2c:	00060993          	mv	s3,a2
    LOCK();
    80001d30:	00100613          	li	a2,1
    80001d34:	00000593          	li	a1,0
    80001d38:	0000a517          	auipc	a0,0xa
    80001d3c:	ce050513          	addi	a0,a0,-800 # 8000ba18 <lockPrint>
    80001d40:	fffff097          	auipc	ra,0xfffff
    80001d44:	2c0080e7          	jalr	704(ra) # 80001000 <copy_and_swap>
    80001d48:	fe0514e3          	bnez	a0,80001d30 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001d4c:	00098463          	beqz	s3,80001d54 <_Z8printIntiii+0x4c>
    80001d50:	0804c463          	bltz	s1,80001dd8 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001d54:	0004851b          	sext.w	a0,s1
    neg = 0;
    80001d58:	00000593          	li	a1,0
    }

    i = 0;
    80001d5c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001d60:	0009079b          	sext.w	a5,s2
    80001d64:	0325773b          	remuw	a4,a0,s2
    80001d68:	00048613          	mv	a2,s1
    80001d6c:	0014849b          	addiw	s1,s1,1
    80001d70:	02071693          	slli	a3,a4,0x20
    80001d74:	0206d693          	srli	a3,a3,0x20
    80001d78:	0000a717          	auipc	a4,0xa
    80001d7c:	94070713          	addi	a4,a4,-1728 # 8000b6b8 <digits>
    80001d80:	00d70733          	add	a4,a4,a3
    80001d84:	00074683          	lbu	a3,0(a4)
    80001d88:	fd040713          	addi	a4,s0,-48
    80001d8c:	00c70733          	add	a4,a4,a2
    80001d90:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001d94:	0005071b          	sext.w	a4,a0
    80001d98:	0325553b          	divuw	a0,a0,s2
    80001d9c:	fcf772e3          	bgeu	a4,a5,80001d60 <_Z8printIntiii+0x58>
    if(neg)
    80001da0:	00058c63          	beqz	a1,80001db8 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80001da4:	fd040793          	addi	a5,s0,-48
    80001da8:	009784b3          	add	s1,a5,s1
    80001dac:	02d00793          	li	a5,45
    80001db0:	fef48823          	sb	a5,-16(s1)
    80001db4:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001db8:	fff4849b          	addiw	s1,s1,-1
    80001dbc:	0204c463          	bltz	s1,80001de4 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80001dc0:	fd040793          	addi	a5,s0,-48
    80001dc4:	009787b3          	add	a5,a5,s1
    80001dc8:	ff07c503          	lbu	a0,-16(a5)
    80001dcc:	fffff097          	auipc	ra,0xfffff
    80001dd0:	660080e7          	jalr	1632(ra) # 8000142c <_Z4putcc>
    80001dd4:	fe5ff06f          	j	80001db8 <_Z8printIntiii+0xb0>
        x = -xx;
    80001dd8:	4090053b          	negw	a0,s1
        neg = 1;
    80001ddc:	00100593          	li	a1,1
        x = -xx;
    80001de0:	f7dff06f          	j	80001d5c <_Z8printIntiii+0x54>

    UNLOCK();
    80001de4:	00000613          	li	a2,0
    80001de8:	00100593          	li	a1,1
    80001dec:	0000a517          	auipc	a0,0xa
    80001df0:	c2c50513          	addi	a0,a0,-980 # 8000ba18 <lockPrint>
    80001df4:	fffff097          	auipc	ra,0xfffff
    80001df8:	20c080e7          	jalr	524(ra) # 80001000 <copy_and_swap>
    80001dfc:	fe0514e3          	bnez	a0,80001de4 <_Z8printIntiii+0xdc>
    80001e00:	03813083          	ld	ra,56(sp)
    80001e04:	03013403          	ld	s0,48(sp)
    80001e08:	02813483          	ld	s1,40(sp)
    80001e0c:	02013903          	ld	s2,32(sp)
    80001e10:	01813983          	ld	s3,24(sp)
    80001e14:	04010113          	addi	sp,sp,64
    80001e18:	00008067          	ret

0000000080001e1c <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00813423          	sd	s0,8(sp)
    80001e24:	01010413          	addi	s0,sp,16
    val = init;
    80001e28:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80001e2c:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    80001e30:	00053823          	sd	zero,16(a0)
}
    80001e34:	00813403          	ld	s0,8(sp)
    80001e38:	01010113          	addi	sp,sp,16
    80001e3c:	00008067          	ret

0000000080001e40 <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    80001e40:	fe010113          	addi	sp,sp,-32
    80001e44:	00113c23          	sd	ra,24(sp)
    80001e48:	00813823          	sd	s0,16(sp)
    80001e4c:	00913423          	sd	s1,8(sp)
    80001e50:	01213023          	sd	s2,0(sp)
    80001e54:	02010413          	addi	s0,sp,32
    80001e58:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80001e5c:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80001e60:	02050063          	beqz	a0,80001e80 <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    80001e64:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80001e68:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80001e6c:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80001e70:	00002097          	auipc	ra,0x2
    80001e74:	d70080e7          	jalr	-656(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80001e78:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80001e7c:	fe5ff06f          	j	80001e60 <_ZN3SCBD1Ev+0x20>
    }
}
    80001e80:	01813083          	ld	ra,24(sp)
    80001e84:	01013403          	ld	s0,16(sp)
    80001e88:	00813483          	ld	s1,8(sp)
    80001e8c:	00013903          	ld	s2,0(sp)
    80001e90:	02010113          	addi	sp,sp,32
    80001e94:	00008067          	ret

0000000080001e98 <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00113423          	sd	ra,8(sp)
    80001ea0:	00813023          	sd	s0,0(sp)
    80001ea4:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001ea8:	00853783          	ld	a5,8(a0)
    80001eac:	04078063          	beqz	a5,80001eec <_ZN3SCB5blockEv+0x54>
    80001eb0:	01053703          	ld	a4,16(a0)
    80001eb4:	0000a797          	auipc	a5,0xa
    80001eb8:	a147b783          	ld	a5,-1516(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001ebc:	0007b783          	ld	a5,0(a5)
    80001ec0:	04f73423          	sd	a5,72(a4)
    80001ec4:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80001ec8:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80001ecc:	00300713          	li	a4,3
    80001ed0:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80001ed4:	00000097          	auipc	ra,0x0
    80001ed8:	2c0080e7          	jalr	704(ra) # 80002194 <_ZN3TCB8dispatchEv>
}
    80001edc:	00813083          	ld	ra,8(sp)
    80001ee0:	00013403          	ld	s0,0(sp)
    80001ee4:	01010113          	addi	sp,sp,16
    80001ee8:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80001eec:	0000a797          	auipc	a5,0xa
    80001ef0:	9dc7b783          	ld	a5,-1572(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001ef4:	0007b783          	ld	a5,0(a5)
    80001ef8:	00f53423          	sd	a5,8(a0)
    80001efc:	fc9ff06f          	j	80001ec4 <_ZN3SCB5blockEv+0x2c>

0000000080001f00 <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80001f00:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80001f04:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80001f08:	04853703          	ld	a4,72(a0)
    80001f0c:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80001f10:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80001f14:	02050a63          	beqz	a0,80001f48 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80001f18:	ff010113          	addi	sp,sp,-16
    80001f1c:	00113423          	sd	ra,8(sp)
    80001f20:	00813023          	sd	s0,0(sp)
    80001f24:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80001f28:	00100793          	li	a5,1
    80001f2c:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80001f30:	00002097          	auipc	ra,0x2
    80001f34:	cb0080e7          	jalr	-848(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
    }
}
    80001f38:	00813083          	ld	ra,8(sp)
    80001f3c:	00013403          	ld	s0,0(sp)
    80001f40:	01010113          	addi	sp,sp,16
    80001f44:	00008067          	ret
    80001f48:	00008067          	ret

0000000080001f4c <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80001f4c:	0000a797          	auipc	a5,0xa
    80001f50:	97c7b783          	ld	a5,-1668(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80001f54:	0007b783          	ld	a5,0(a5)
    80001f58:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80001f5c:	00052783          	lw	a5,0(a0)
    80001f60:	fff7879b          	addiw	a5,a5,-1
    80001f64:	00f52023          	sw	a5,0(a0)
    80001f68:	02079713          	slli	a4,a5,0x20
    80001f6c:	00074463          	bltz	a4,80001f74 <_ZN3SCB4waitEv+0x28>
    80001f70:	00008067          	ret
void SCB::wait() {
    80001f74:	ff010113          	addi	sp,sp,-16
    80001f78:	00113423          	sd	ra,8(sp)
    80001f7c:	00813023          	sd	s0,0(sp)
    80001f80:	01010413          	addi	s0,sp,16
        block();
    80001f84:	00000097          	auipc	ra,0x0
    80001f88:	f14080e7          	jalr	-236(ra) # 80001e98 <_ZN3SCB5blockEv>
}
    80001f8c:	00813083          	ld	ra,8(sp)
    80001f90:	00013403          	ld	s0,0(sp)
    80001f94:	01010113          	addi	sp,sp,16
    80001f98:	00008067          	ret

0000000080001f9c <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80001f9c:	00052783          	lw	a5,0(a0)
    80001fa0:	0017871b          	addiw	a4,a5,1
    80001fa4:	00e52023          	sw	a4,0(a0)
    80001fa8:	0007c463          	bltz	a5,80001fb0 <_ZN3SCB6signalEv+0x14>
    80001fac:	00008067          	ret
void SCB::signal(){
    80001fb0:	ff010113          	addi	sp,sp,-16
    80001fb4:	00113423          	sd	ra,8(sp)
    80001fb8:	00813023          	sd	s0,0(sp)
    80001fbc:	01010413          	addi	s0,sp,16
        deblock();
    80001fc0:	00000097          	auipc	ra,0x0
    80001fc4:	f40080e7          	jalr	-192(ra) # 80001f00 <_ZN3SCB7deblockEv>
}
    80001fc8:	00813083          	ld	ra,8(sp)
    80001fcc:	00013403          	ld	s0,0(sp)
    80001fd0:	01010113          	addi	sp,sp,16
    80001fd4:	00008067          	ret

0000000080001fd8 <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    80001fd8:	ff010113          	addi	sp,sp,-16
    80001fdc:	00113423          	sd	ra,8(sp)
    80001fe0:	00813023          	sd	s0,0(sp)
    80001fe4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80001fe8:	00000097          	auipc	ra,0x0
    80001fec:	3f4080e7          	jalr	1012(ra) # 800023dc <_ZN15MemoryAllocator7kmallocEm>
}
    80001ff0:	00813083          	ld	ra,8(sp)
    80001ff4:	00013403          	ld	s0,0(sp)
    80001ff8:	01010113          	addi	sp,sp,16
    80001ffc:	00008067          	ret

0000000080002000 <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    80002000:	ff010113          	addi	sp,sp,-16
    80002004:	00113423          	sd	ra,8(sp)
    80002008:	00813023          	sd	s0,0(sp)
    8000200c:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002010:	00000097          	auipc	ra,0x0
    80002014:	5f4080e7          	jalr	1524(ra) # 80002604 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002018:	00813083          	ld	ra,8(sp)
    8000201c:	00013403          	ld	s0,0(sp)
    80002020:	01010113          	addi	sp,sp,16
    80002024:	00008067          	ret

0000000080002028 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002028:	ff010113          	addi	sp,sp,-16
    8000202c:	00813423          	sd	s0,8(sp)
    80002030:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002034:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002038:	05200513          	li	a0,82
    asm("ecall");
    8000203c:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80002040:	00050513          	mv	a0,a0
    return status;
}
    80002044:	0005051b          	sext.w	a0,a0
    80002048:	00813403          	ld	s0,8(sp)
    8000204c:	01010113          	addi	sp,sp,16
    80002050:	00008067          	ret

0000000080002054 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002054:	fe010113          	addi	sp,sp,-32
    80002058:	00113c23          	sd	ra,24(sp)
    8000205c:	00813823          	sd	s0,16(sp)
    80002060:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002064:	fe840513          	addi	a0,s0,-24
    80002068:	00000097          	auipc	ra,0x0
    8000206c:	9fc080e7          	jalr	-1540(ra) # 80001a64 <_ZN6SystemC1Ev>

    return 0;
    80002070:	00000513          	li	a0,0
    80002074:	01813083          	ld	ra,24(sp)
    80002078:	01013403          	ld	s0,16(sp)
    8000207c:	02010113          	addi	sp,sp,32
    80002080:	00008067          	ret

0000000080002084 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002084:	ff010113          	addi	sp,sp,-16
    80002088:	00113423          	sd	ra,8(sp)
    8000208c:	00813023          	sd	s0,0(sp)
    80002090:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002094:	00001097          	auipc	ra,0x1
    80002098:	ca0080e7          	jalr	-864(ra) # 80002d34 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    8000209c:	0000a797          	auipc	a5,0xa
    800020a0:	9847b783          	ld	a5,-1660(a5) # 8000ba20 <_ZN3TCB7runningE>
    800020a4:	0187b703          	ld	a4,24(a5)
    800020a8:	0207b503          	ld	a0,32(a5)
    800020ac:	000700e7          	jalr	a4

    thread_exit();
    800020b0:	fffff097          	auipc	ra,0xfffff
    800020b4:	17c080e7          	jalr	380(ra) # 8000122c <_Z11thread_exitv>
}
    800020b8:	00813083          	ld	ra,8(sp)
    800020bc:	00013403          	ld	s0,0(sp)
    800020c0:	01010113          	addi	sp,sp,16
    800020c4:	00008067          	ret

00000000800020c8 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    800020c8:	ff010113          	addi	sp,sp,-16
    800020cc:	00813423          	sd	s0,8(sp)
    800020d0:	01010413          	addi	s0,sp,16
    800020d4:	04053823          	sd	zero,80(a0)
    800020d8:	04053c23          	sd	zero,88(a0)
    800020dc:	06053023          	sd	zero,96(a0)
    this->body = body;
    800020e0:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    800020e4:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    800020e8:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    800020ec:	04058263          	beqz	a1,80002130 <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    800020f0:	00068793          	mv	a5,a3
    800020f4:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    800020f8:	00100793          	li	a5,1
    800020fc:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    80002100:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002104:	02058a63          	beqz	a1,80002138 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    80002108:	000017b7          	lui	a5,0x1
    8000210c:	00f686b3          	add	a3,a3,a5
    80002110:	00d53023          	sd	a3,0(a0)
    80002114:	00000797          	auipc	a5,0x0
    80002118:	f7078793          	addi	a5,a5,-144 # 80002084 <_ZN3TCB7wrapperEPv>
    8000211c:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002120:	00052a23          	sw	zero,20(a0)
}
    80002124:	00813403          	ld	s0,8(sp)
    80002128:	01010113          	addi	sp,sp,16
    8000212c:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002130:	00000793          	li	a5,0
    80002134:	fc1ff06f          	j	800020f4 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002138:	00000693          	li	a3,0
    8000213c:	fd5ff06f          	j	80002110 <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

0000000080002140 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002140:	ff010113          	addi	sp,sp,-16
    80002144:	00113423          	sd	ra,8(sp)
    80002148:	00813023          	sd	s0,0(sp)
    8000214c:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    80002150:	02853503          	ld	a0,40(a0)
    80002154:	00000097          	auipc	ra,0x0
    80002158:	4b0080e7          	jalr	1200(ra) # 80002604 <_ZN15MemoryAllocator5kfreeEPv>
}
    8000215c:	00813083          	ld	ra,8(sp)
    80002160:	00013403          	ld	s0,0(sp)
    80002164:	01010113          	addi	sp,sp,16
    80002168:	00008067          	ret

000000008000216c <_ZN3TCBD1Ev>:
TCB::~TCB(){
    8000216c:	ff010113          	addi	sp,sp,-16
    80002170:	00113423          	sd	ra,8(sp)
    80002174:	00813023          	sd	s0,0(sp)
    80002178:	01010413          	addi	s0,sp,16
    free();
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	fc4080e7          	jalr	-60(ra) # 80002140 <_ZN3TCB4freeEv>
}
    80002184:	00813083          	ld	ra,8(sp)
    80002188:	00013403          	ld	s0,0(sp)
    8000218c:	01010113          	addi	sp,sp,16
    80002190:	00008067          	ret

0000000080002194 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002194:	fe010113          	addi	sp,sp,-32
    80002198:	00113c23          	sd	ra,24(sp)
    8000219c:	00813823          	sd	s0,16(sp)
    800021a0:	00913423          	sd	s1,8(sp)
    800021a4:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800021a8:	0000a497          	auipc	s1,0xa
    800021ac:	8784b483          	ld	s1,-1928(s1) # 8000ba20 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800021b0:	0104a703          	lw	a4,16(s1)
    800021b4:	00100793          	li	a5,1
    800021b8:	04e7f663          	bgeu	a5,a4,80002204 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800021bc:	00002097          	auipc	ra,0x2
    800021c0:	a6c080e7          	jalr	-1428(ra) # 80003c28 <_ZN9Scheduler3getEv>
    800021c4:	0000a797          	auipc	a5,0xa
    800021c8:	84a7be23          	sd	a0,-1956(a5) # 8000ba20 <_ZN3TCB7runningE>
    if(running) {
    800021cc:	02050263          	beqz	a0,800021f0 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800021d0:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800021d4:	00001097          	auipc	ra,0x1
    800021d8:	c94080e7          	jalr	-876(ra) # 80002e68 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    800021dc:	0000a597          	auipc	a1,0xa
    800021e0:	8445b583          	ld	a1,-1980(a1) # 8000ba20 <_ZN3TCB7runningE>
    800021e4:	00048513          	mv	a0,s1
    800021e8:	fffff097          	auipc	ra,0xfffff
    800021ec:	f58080e7          	jalr	-168(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    800021f0:	01813083          	ld	ra,24(sp)
    800021f4:	01013403          	ld	s0,16(sp)
    800021f8:	00813483          	ld	s1,8(sp)
    800021fc:	02010113          	addi	sp,sp,32
    80002200:	00008067          	ret
        Scheduler::put(old);
    80002204:	00048513          	mv	a0,s1
    80002208:	00002097          	auipc	ra,0x2
    8000220c:	9d8080e7          	jalr	-1576(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
    80002210:	fadff06f          	j	800021bc <_ZN3TCB8dispatchEv+0x28>

0000000080002214 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002214:	ff010113          	addi	sp,sp,-16
    80002218:	00113423          	sd	ra,8(sp)
    8000221c:	00813023          	sd	s0,0(sp)
    80002220:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002224:	00000097          	auipc	ra,0x0
    80002228:	1b8080e7          	jalr	440(ra) # 800023dc <_ZN15MemoryAllocator7kmallocEm>
}
    8000222c:	00813083          	ld	ra,8(sp)
    80002230:	00013403          	ld	s0,0(sp)
    80002234:	01010113          	addi	sp,sp,16
    80002238:	00008067          	ret

000000008000223c <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    8000223c:	fd010113          	addi	sp,sp,-48
    80002240:	02113423          	sd	ra,40(sp)
    80002244:	02813023          	sd	s0,32(sp)
    80002248:	00913c23          	sd	s1,24(sp)
    8000224c:	01213823          	sd	s2,16(sp)
    80002250:	01313423          	sd	s3,8(sp)
    80002254:	01413023          	sd	s4,0(sp)
    80002258:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    8000225c:	07000513          	li	a0,112
    80002260:	00000097          	auipc	ra,0x0
    80002264:	fb4080e7          	jalr	-76(ra) # 80002214 <_ZN3TCBnwEm>
    80002268:	00050493          	mv	s1,a0
    8000226c:	00200713          	li	a4,2
    80002270:	00000693          	li	a3,0
    80002274:	00000613          	li	a2,0
    80002278:	00000593          	li	a1,0
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	e4c080e7          	jalr	-436(ra) # 800020c8 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002284:	00009a17          	auipc	s4,0x9
    80002288:	79ca0a13          	addi	s4,s4,1948 # 8000ba20 <_ZN3TCB7runningE>
    8000228c:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    80002290:	00100993          	li	s3,1
    80002294:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002298:	04000513          	li	a0,64
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	140080e7          	jalr	320(ra) # 800023dc <_ZN15MemoryAllocator7kmallocEm>
    800022a4:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    800022a8:	07000513          	li	a0,112
    800022ac:	00000097          	auipc	ra,0x0
    800022b0:	f68080e7          	jalr	-152(ra) # 80002214 <_ZN3TCBnwEm>
    800022b4:	00050493          	mv	s1,a0
    800022b8:	00200713          	li	a4,2
    800022bc:	00090693          	mv	a3,s2
    800022c0:	00000613          	li	a2,0
    800022c4:	00009597          	auipc	a1,0x9
    800022c8:	5a45b583          	ld	a1,1444(a1) # 8000b868 <_GLOBAL_OFFSET_TABLE_+0x28>
    800022cc:	00000097          	auipc	ra,0x0
    800022d0:	dfc080e7          	jalr	-516(ra) # 800020c8 <_ZN3TCBC1EPFvPvES0_Pmm>
    800022d4:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    800022d8:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    800022dc:	00048513          	mv	a0,s1
    800022e0:	00002097          	auipc	ra,0x2
    800022e4:	900080e7          	jalr	-1792(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
}
    800022e8:	02813083          	ld	ra,40(sp)
    800022ec:	02013403          	ld	s0,32(sp)
    800022f0:	01813483          	ld	s1,24(sp)
    800022f4:	01013903          	ld	s2,16(sp)
    800022f8:	00813983          	ld	s3,8(sp)
    800022fc:	00013a03          	ld	s4,0(sp)
    80002300:	03010113          	addi	sp,sp,48
    80002304:	00008067          	ret

0000000080002308 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    80002308:	ff010113          	addi	sp,sp,-16
    8000230c:	00113423          	sd	ra,8(sp)
    80002310:	00813023          	sd	s0,0(sp)
    80002314:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002318:	00000097          	auipc	ra,0x0
    8000231c:	2ec080e7          	jalr	748(ra) # 80002604 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002320:	00813083          	ld	ra,8(sp)
    80002324:	00013403          	ld	s0,0(sp)
    80002328:	01010113          	addi	sp,sp,16
    8000232c:	00008067          	ret

0000000080002330 <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80002330:	ff010113          	addi	sp,sp,-16
    80002334:	00813423          	sd	s0,8(sp)
    80002338:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    8000233c:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002340:	05100513          	li	a0,81
    asm("ecall");
    80002344:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002348:	00050513          	mv	a0,a0
    return status;
    8000234c:	0005051b          	sext.w	a0,a0
    80002350:	00813403          	ld	s0,8(sp)
    80002354:	01010113          	addi	sp,sp,16
    80002358:	00008067          	ret

000000008000235c <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    8000235c:	ff010113          	addi	sp,sp,-16
    80002360:	00813423          	sd	s0,8(sp)
    80002364:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002368:	00009797          	auipc	a5,0x9
    8000236c:	4f07b783          	ld	a5,1264(a5) # 8000b858 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002370:	0007b603          	ld	a2,0(a5)
    80002374:	00c65793          	srli	a5,a2,0xc
    80002378:	00278793          	addi	a5,a5,2
    8000237c:	00c79793          	slli	a5,a5,0xc
    80002380:	01000737          	lui	a4,0x1000
    80002384:	00e787b3          	add	a5,a5,a4
    80002388:	00009717          	auipc	a4,0x9
    8000238c:	6c070713          	addi	a4,a4,1728 # 8000ba48 <_ZN15MemoryAllocator11freeMemTailE>
    80002390:	00f73023          	sd	a5,0(a4)
    80002394:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002398:	0007b823          	sd	zero,16(a5)
    8000239c:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    800023a0:	00073823          	sd	zero,16(a4)
    800023a4:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    800023a8:	00009697          	auipc	a3,0x9
    800023ac:	5306b683          	ld	a3,1328(a3) # 8000b8d8 <_GLOBAL_OFFSET_TABLE_+0x98>
    800023b0:	0006b683          	ld	a3,0(a3)
    800023b4:	40c686b3          	sub	a3,a3,a2
    800023b8:	fe868693          	addi	a3,a3,-24
    800023bc:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800023c0:	00873783          	ld	a5,8(a4)
    800023c4:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800023c8:	00100793          	li	a5,1
    800023cc:	02f70023          	sb	a5,32(a4)
}
    800023d0:	00813403          	ld	s0,8(sp)
    800023d4:	01010113          	addi	sp,sp,16
    800023d8:	00008067          	ret

00000000800023dc <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800023dc:	ff010113          	addi	sp,sp,-16
    800023e0:	00813423          	sd	s0,8(sp)
    800023e4:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    800023e8:	14050263          	beqz	a0,8000252c <_ZN15MemoryAllocator7kmallocEm+0x150>
    800023ec:	00050793          	mv	a5,a0
    800023f0:	00009517          	auipc	a0,0x9
    800023f4:	66053503          	ld	a0,1632(a0) # 8000ba50 <_ZN15MemoryAllocator11freeMemHeadE>
    800023f8:	0a050a63          	beqz	a0,800024ac <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800023fc:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002400:	00000613          	li	a2,0
    80002404:	00c0006f          	j	80002410 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002408:	00050613          	mv	a2,a0
    8000240c:	01053503          	ld	a0,16(a0)
    80002410:	00050863          	beqz	a0,80002420 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002414:	00053683          	ld	a3,0(a0)
    80002418:	01878713          	addi	a4,a5,24
    8000241c:	fee6e6e3          	bltu	a3,a4,80002408 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002420:	08050663          	beqz	a0,800024ac <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80002424:	00053683          	ld	a3,0(a0)
    80002428:	01868713          	addi	a4,a3,24
    8000242c:	00e50733          	add	a4,a0,a4
    80002430:	00009597          	auipc	a1,0x9
    80002434:	4a85b583          	ld	a1,1192(a1) # 8000b8d8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002438:	0005b583          	ld	a1,0(a1)
    8000243c:	00b76463          	bltu	a4,a1,80002444 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002440:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002444:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002448:	05700593          	li	a1,87
    8000244c:	08d5f063          	bgeu	a1,a3,800024cc <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80002450:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002454:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002458:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    8000245c:	01053583          	ld	a1,16(a0)
    80002460:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002464:	00853583          	ld	a1,8(a0)
    80002468:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    8000246c:	fe868693          	addi	a3,a3,-24
    80002470:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002474:	04060263          	beqz	a2,800024b8 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    80002478:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    8000247c:	00009797          	auipc	a5,0x9
    80002480:	5e47b783          	ld	a5,1508(a5) # 8000ba60 <_ZN15MemoryAllocator12allocMemHeadE>
    80002484:	06078463          	beqz	a5,800024ec <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002488:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    8000248c:	08070063          	beqz	a4,8000250c <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80002490:	00873783          	ld	a5,8(a4)
    80002494:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002498:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    8000249c:	00873783          	ld	a5,8(a4)
    800024a0:	06078063          	beqz	a5,80002500 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    800024a4:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    800024a8:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    800024ac:	00813403          	ld	s0,8(sp)
    800024b0:	01010113          	addi	sp,sp,16
    800024b4:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800024b8:	00009697          	auipc	a3,0x9
    800024bc:	59068693          	addi	a3,a3,1424 # 8000ba48 <_ZN15MemoryAllocator11freeMemTailE>
    800024c0:	00f6b023          	sd	a5,0(a3)
    800024c4:	00f6b423          	sd	a5,8(a3)
    800024c8:	fb5ff06f          	j	8000247c <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    800024cc:	00060863          	beqz	a2,800024dc <_ZN15MemoryAllocator7kmallocEm+0x100>
    800024d0:	01053783          	ld	a5,16(a0)
    800024d4:	00f63823          	sd	a5,16(a2)
    800024d8:	fa5ff06f          	j	8000247c <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    800024dc:	01053783          	ld	a5,16(a0)
    800024e0:	00009697          	auipc	a3,0x9
    800024e4:	56f6b823          	sd	a5,1392(a3) # 8000ba50 <_ZN15MemoryAllocator11freeMemHeadE>
    800024e8:	f95ff06f          	j	8000247c <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    800024ec:	00009797          	auipc	a5,0x9
    800024f0:	55c78793          	addi	a5,a5,1372 # 8000ba48 <_ZN15MemoryAllocator11freeMemTailE>
    800024f4:	00a7b823          	sd	a0,16(a5)
    800024f8:	00a7bc23          	sd	a0,24(a5)
    800024fc:	fadff06f          	j	800024a8 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    80002500:	00009797          	auipc	a5,0x9
    80002504:	56a7b023          	sd	a0,1376(a5) # 8000ba60 <_ZN15MemoryAllocator12allocMemHeadE>
    80002508:	fa1ff06f          	j	800024a8 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    8000250c:	00009797          	auipc	a5,0x9
    80002510:	53c78793          	addi	a5,a5,1340 # 8000ba48 <_ZN15MemoryAllocator11freeMemTailE>
    80002514:	0107b703          	ld	a4,16(a5)
    80002518:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    8000251c:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002520:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002524:	00a7b823          	sd	a0,16(a5)
    80002528:	f81ff06f          	j	800024a8 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    8000252c:	00000513          	li	a0,0
    80002530:	f7dff06f          	j	800024ac <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080002534 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002534:	ff010113          	addi	sp,sp,-16
    80002538:	00813423          	sd	s0,8(sp)
    8000253c:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002540:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002544:	00000713          	li	a4,0
    80002548:	00078a63          	beqz	a5,8000255c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    8000254c:	00a7f863          	bgeu	a5,a0,8000255c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002550:	00078713          	mv	a4,a5
    80002554:	0107b783          	ld	a5,16(a5)
    80002558:	ff1ff06f          	j	80002548 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    8000255c:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002560:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002564:	00078463          	beqz	a5,8000256c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002568:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    8000256c:	02070263          	beqz	a4,80002590 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002570:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002574:	0005b703          	ld	a4,0(a1)
    80002578:	00009797          	auipc	a5,0x9
    8000257c:	4d87b783          	ld	a5,1240(a5) # 8000ba50 <_ZN15MemoryAllocator11freeMemHeadE>
    80002580:	00f70c63          	beq	a4,a5,80002598 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002584:	00813403          	ld	s0,8(sp)
    80002588:	01010113          	addi	sp,sp,16
    8000258c:	00008067          	ret
        *head = blk;
    80002590:	00a5b023          	sd	a0,0(a1)
    80002594:	fe1ff06f          	j	80002574 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002598:	01053783          	ld	a5,16(a0)
    8000259c:	00078a63          	beqz	a5,800025b0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    800025a0:	00053683          	ld	a3,0(a0)
    800025a4:	00d50733          	add	a4,a0,a3
    800025a8:	01870713          	addi	a4,a4,24
    800025ac:	02f70e63          	beq	a4,a5,800025e8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    800025b0:	00853783          	ld	a5,8(a0)
    800025b4:	fc0788e3          	beqz	a5,80002584 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800025b8:	0007b683          	ld	a3,0(a5)
    800025bc:	00d78733          	add	a4,a5,a3
    800025c0:	01870713          	addi	a4,a4,24
    800025c4:	fca710e3          	bne	a4,a0,80002584 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800025c8:	00053703          	ld	a4,0(a0)
    800025cc:	00e68733          	add	a4,a3,a4
    800025d0:	01870713          	addi	a4,a4,24
    800025d4:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800025d8:	00853783          	ld	a5,8(a0)
    800025dc:	01053703          	ld	a4,16(a0)
    800025e0:	00e7b823          	sd	a4,16(a5)
}
    800025e4:	fa1ff06f          	j	80002584 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800025e8:	0007b703          	ld	a4,0(a5)
    800025ec:	00e68733          	add	a4,a3,a4
    800025f0:	01870713          	addi	a4,a4,24
    800025f4:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800025f8:	0107b783          	ld	a5,16(a5)
    800025fc:	00f53823          	sd	a5,16(a0)
    80002600:	fb1ff06f          	j	800025b0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002604 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002604:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002608:	00009697          	auipc	a3,0x9
    8000260c:	4586b683          	ld	a3,1112(a3) # 8000ba60 <_ZN15MemoryAllocator12allocMemHeadE>
    80002610:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002614:	00050a63          	beqz	a0,80002628 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002618:	fe870793          	addi	a5,a4,-24
    8000261c:	00a78663          	beq	a5,a0,80002628 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002620:	01053503          	ld	a0,16(a0)
    80002624:	ff1ff06f          	j	80002614 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002628:	08050463          	beqz	a0,800026b0 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    8000262c:	ff010113          	addi	sp,sp,-16
    80002630:	00113423          	sd	ra,8(sp)
    80002634:	00813023          	sd	s0,0(sp)
    80002638:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    8000263c:	00009797          	auipc	a5,0x9
    80002640:	41c7b783          	ld	a5,1052(a5) # 8000ba58 <_ZN15MemoryAllocator12allocMemTailE>
    80002644:	04a78663          	beq	a5,a0,80002690 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002648:	04d50c63          	beq	a0,a3,800026a0 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    8000264c:	01053783          	ld	a5,16(a0)
    80002650:	00078663          	beqz	a5,8000265c <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002654:	00853703          	ld	a4,8(a0)
    80002658:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    8000265c:	00853783          	ld	a5,8(a0)
    80002660:	00078663          	beqz	a5,8000266c <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002664:	01053703          	ld	a4,16(a0)
    80002668:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    8000266c:	00009597          	auipc	a1,0x9
    80002670:	3e458593          	addi	a1,a1,996 # 8000ba50 <_ZN15MemoryAllocator11freeMemHeadE>
    80002674:	00000097          	auipc	ra,0x0
    80002678:	ec0080e7          	jalr	-320(ra) # 80002534 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    8000267c:	00000513          	li	a0,0
}
    80002680:	00813083          	ld	ra,8(sp)
    80002684:	00013403          	ld	s0,0(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret
            allocMemTail = blk->prev;
    80002690:	00853783          	ld	a5,8(a0)
    80002694:	00009717          	auipc	a4,0x9
    80002698:	3cf73223          	sd	a5,964(a4) # 8000ba58 <_ZN15MemoryAllocator12allocMemTailE>
    8000269c:	fadff06f          	j	80002648 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    800026a0:	01053783          	ld	a5,16(a0)
    800026a4:	00009717          	auipc	a4,0x9
    800026a8:	3af73e23          	sd	a5,956(a4) # 8000ba60 <_ZN15MemoryAllocator12allocMemHeadE>
    800026ac:	fa1ff06f          	j	8000264c <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    800026b0:	fff00513          	li	a0,-1
}
    800026b4:	00008067          	ret

00000000800026b8 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800026b8:	fe010113          	addi	sp,sp,-32
    800026bc:	00113c23          	sd	ra,24(sp)
    800026c0:	00813823          	sd	s0,16(sp)
    800026c4:	00913423          	sd	s1,8(sp)
    800026c8:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800026cc:	00009497          	auipc	s1,0x9
    800026d0:	3944b483          	ld	s1,916(s1) # 8000ba60 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800026d4:	00007517          	auipc	a0,0x7
    800026d8:	97450513          	addi	a0,a0,-1676 # 80009048 <CONSOLE_STATUS+0x38>
    800026dc:	fffff097          	auipc	ra,0xfffff
    800026e0:	494080e7          	jalr	1172(ra) # 80001b70 <_Z11printStringPKc>
    while(iter!=nullptr){
    800026e4:	04048663          	beqz	s1,80002730 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800026e8:	00000613          	li	a2,0
    800026ec:	00a00593          	li	a1,10
    800026f0:	0004851b          	sext.w	a0,s1
    800026f4:	fffff097          	auipc	ra,0xfffff
    800026f8:	614080e7          	jalr	1556(ra) # 80001d08 <_Z8printIntiii>
        putc(' ');
    800026fc:	02000513          	li	a0,32
    80002700:	fffff097          	auipc	ra,0xfffff
    80002704:	d2c080e7          	jalr	-724(ra) # 8000142c <_Z4putcc>
        printInt(iter->size);
    80002708:	00000613          	li	a2,0
    8000270c:	00a00593          	li	a1,10
    80002710:	0004a503          	lw	a0,0(s1)
    80002714:	fffff097          	auipc	ra,0xfffff
    80002718:	5f4080e7          	jalr	1524(ra) # 80001d08 <_Z8printIntiii>
        putc('\n');
    8000271c:	00a00513          	li	a0,10
    80002720:	fffff097          	auipc	ra,0xfffff
    80002724:	d0c080e7          	jalr	-756(ra) # 8000142c <_Z4putcc>
        iter=iter->next;
    80002728:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    8000272c:	fb9ff06f          	j	800026e4 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002730:	00007517          	auipc	a0,0x7
    80002734:	93850513          	addi	a0,a0,-1736 # 80009068 <CONSOLE_STATUS+0x58>
    80002738:	fffff097          	auipc	ra,0xfffff
    8000273c:	438080e7          	jalr	1080(ra) # 80001b70 <_Z11printStringPKc>
    iter = freeMemHead;
    80002740:	00009497          	auipc	s1,0x9
    80002744:	3104b483          	ld	s1,784(s1) # 8000ba50 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002748:	04048663          	beqz	s1,80002794 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    8000274c:	00000613          	li	a2,0
    80002750:	00a00593          	li	a1,10
    80002754:	0004851b          	sext.w	a0,s1
    80002758:	fffff097          	auipc	ra,0xfffff
    8000275c:	5b0080e7          	jalr	1456(ra) # 80001d08 <_Z8printIntiii>
        putc(' ');
    80002760:	02000513          	li	a0,32
    80002764:	fffff097          	auipc	ra,0xfffff
    80002768:	cc8080e7          	jalr	-824(ra) # 8000142c <_Z4putcc>
        printInt(iter->size);
    8000276c:	00000613          	li	a2,0
    80002770:	00a00593          	li	a1,10
    80002774:	0004a503          	lw	a0,0(s1)
    80002778:	fffff097          	auipc	ra,0xfffff
    8000277c:	590080e7          	jalr	1424(ra) # 80001d08 <_Z8printIntiii>
        putc('\n');
    80002780:	00a00513          	li	a0,10
    80002784:	fffff097          	auipc	ra,0xfffff
    80002788:	ca8080e7          	jalr	-856(ra) # 8000142c <_Z4putcc>
        iter=iter->next;
    8000278c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002790:	fb9ff06f          	j	80002748 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002794:	00007517          	auipc	a0,0x7
    80002798:	8f450513          	addi	a0,a0,-1804 # 80009088 <CONSOLE_STATUS+0x78>
    8000279c:	fffff097          	auipc	ra,0xfffff
    800027a0:	3d4080e7          	jalr	980(ra) # 80001b70 <_Z11printStringPKc>
}
    800027a4:	01813083          	ld	ra,24(sp)
    800027a8:	01013403          	ld	s0,16(sp)
    800027ac:	00813483          	ld	s1,8(sp)
    800027b0:	02010113          	addi	sp,sp,32
    800027b4:	00008067          	ret

00000000800027b8 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800027b8:	ff010113          	addi	sp,sp,-16
    800027bc:	00813423          	sd	s0,8(sp)
    800027c0:	01010413          	addi	s0,sp,16
    800027c4:	00050813          	mv	a6,a0
    800027c8:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800027cc:	00000793          	li	a5,0
    800027d0:	00c7fe63          	bgeu	a5,a2,800027ec <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800027d4:	00f50733          	add	a4,a0,a5
    800027d8:	00f806b3          	add	a3,a6,a5
    800027dc:	0006c683          	lbu	a3,0(a3)
    800027e0:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800027e4:	00178793          	addi	a5,a5,1
    800027e8:	fe9ff06f          	j	800027d0 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800027ec:	00813403          	ld	s0,8(sp)
    800027f0:	01010113          	addi	sp,sp,16
    800027f4:	00008067          	ret

00000000800027f8 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    800027f8:	ff010113          	addi	sp,sp,-16
    800027fc:	00113423          	sd	ra,8(sp)
    80002800:	00813023          	sd	s0,0(sp)
    80002804:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80002808:	00053783          	ld	a5,0(a0)
    8000280c:	0107b783          	ld	a5,16(a5)
    80002810:	000780e7          	jalr	a5
}
    80002814:	00813083          	ld	ra,8(sp)
    80002818:	00013403          	ld	s0,0(sp)
    8000281c:	01010113          	addi	sp,sp,16
    80002820:	00008067          	ret

0000000080002824 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80002824:	ff010113          	addi	sp,sp,-16
    80002828:	00113423          	sd	ra,8(sp)
    8000282c:	00813023          	sd	s0,0(sp)
    80002830:	01010413          	addi	s0,sp,16
    80002834:	00009797          	auipc	a5,0x9
    80002838:	ee478793          	addi	a5,a5,-284 # 8000b718 <_ZTV9Semaphore+0x10>
    8000283c:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002840:	00853503          	ld	a0,8(a0)
    80002844:	fffff097          	auipc	ra,0xfffff
    80002848:	b10080e7          	jalr	-1264(ra) # 80001354 <_Z9sem_closeP10_semaphore>
};
    8000284c:	00813083          	ld	ra,8(sp)
    80002850:	00013403          	ld	s0,0(sp)
    80002854:	01010113          	addi	sp,sp,16
    80002858:	00008067          	ret

000000008000285c <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    8000285c:	00009797          	auipc	a5,0x9
    80002860:	edc78793          	addi	a5,a5,-292 # 8000b738 <_ZTV6Thread+0x10>
    80002864:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002868:	00853503          	ld	a0,8(a0)
    8000286c:	02050663          	beqz	a0,80002898 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80002870:	ff010113          	addi	sp,sp,-16
    80002874:	00113423          	sd	ra,8(sp)
    80002878:	00813023          	sd	s0,0(sp)
    8000287c:	01010413          	addi	s0,sp,16
    delete myHandle;
    80002880:	fffff097          	auipc	ra,0xfffff
    80002884:	1a4080e7          	jalr	420(ra) # 80001a24 <_ZN7_threaddlEPv>
}
    80002888:	00813083          	ld	ra,8(sp)
    8000288c:	00013403          	ld	s0,0(sp)
    80002890:	01010113          	addi	sp,sp,16
    80002894:	00008067          	ret
    80002898:	00008067          	ret

000000008000289c <_Znwm>:
void* operator new(size_t sz){
    8000289c:	ff010113          	addi	sp,sp,-16
    800028a0:	00113423          	sd	ra,8(sp)
    800028a4:	00813023          	sd	s0,0(sp)
    800028a8:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800028ac:	fffff097          	auipc	ra,0xfffff
    800028b0:	8a8080e7          	jalr	-1880(ra) # 80001154 <_Z9mem_allocm>
}
    800028b4:	00813083          	ld	ra,8(sp)
    800028b8:	00013403          	ld	s0,0(sp)
    800028bc:	01010113          	addi	sp,sp,16
    800028c0:	00008067          	ret

00000000800028c4 <_Znam>:
void* operator new[](size_t sz){
    800028c4:	ff010113          	addi	sp,sp,-16
    800028c8:	00113423          	sd	ra,8(sp)
    800028cc:	00813023          	sd	s0,0(sp)
    800028d0:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800028d4:	fffff097          	auipc	ra,0xfffff
    800028d8:	880080e7          	jalr	-1920(ra) # 80001154 <_Z9mem_allocm>
}
    800028dc:	00813083          	ld	ra,8(sp)
    800028e0:	00013403          	ld	s0,0(sp)
    800028e4:	01010113          	addi	sp,sp,16
    800028e8:	00008067          	ret

00000000800028ec <_ZdlPv>:
void operator delete(void *ptr){
    800028ec:	ff010113          	addi	sp,sp,-16
    800028f0:	00113423          	sd	ra,8(sp)
    800028f4:	00813023          	sd	s0,0(sp)
    800028f8:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800028fc:	fffff097          	auipc	ra,0xfffff
    80002900:	888080e7          	jalr	-1912(ra) # 80001184 <_Z8mem_freePv>
}
    80002904:	00813083          	ld	ra,8(sp)
    80002908:	00013403          	ld	s0,0(sp)
    8000290c:	01010113          	addi	sp,sp,16
    80002910:	00008067          	ret

0000000080002914 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80002914:	fe010113          	addi	sp,sp,-32
    80002918:	00113c23          	sd	ra,24(sp)
    8000291c:	00813823          	sd	s0,16(sp)
    80002920:	00913423          	sd	s1,8(sp)
    80002924:	02010413          	addi	s0,sp,32
    80002928:	00050493          	mv	s1,a0
};
    8000292c:	00000097          	auipc	ra,0x0
    80002930:	ef8080e7          	jalr	-264(ra) # 80002824 <_ZN9SemaphoreD1Ev>
    80002934:	00048513          	mv	a0,s1
    80002938:	00000097          	auipc	ra,0x0
    8000293c:	fb4080e7          	jalr	-76(ra) # 800028ec <_ZdlPv>
    80002940:	01813083          	ld	ra,24(sp)
    80002944:	01013403          	ld	s0,16(sp)
    80002948:	00813483          	ld	s1,8(sp)
    8000294c:	02010113          	addi	sp,sp,32
    80002950:	00008067          	ret

0000000080002954 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002954:	fe010113          	addi	sp,sp,-32
    80002958:	00113c23          	sd	ra,24(sp)
    8000295c:	00813823          	sd	s0,16(sp)
    80002960:	00913423          	sd	s1,8(sp)
    80002964:	02010413          	addi	s0,sp,32
    80002968:	00050493          	mv	s1,a0
}
    8000296c:	00000097          	auipc	ra,0x0
    80002970:	ef0080e7          	jalr	-272(ra) # 8000285c <_ZN6ThreadD1Ev>
    80002974:	00048513          	mv	a0,s1
    80002978:	00000097          	auipc	ra,0x0
    8000297c:	f74080e7          	jalr	-140(ra) # 800028ec <_ZdlPv>
    80002980:	01813083          	ld	ra,24(sp)
    80002984:	01013403          	ld	s0,16(sp)
    80002988:	00813483          	ld	s1,8(sp)
    8000298c:	02010113          	addi	sp,sp,32
    80002990:	00008067          	ret

0000000080002994 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002994:	ff010113          	addi	sp,sp,-16
    80002998:	00113423          	sd	ra,8(sp)
    8000299c:	00813023          	sd	s0,0(sp)
    800029a0:	01010413          	addi	s0,sp,16
    800029a4:	00009797          	auipc	a5,0x9
    800029a8:	d7478793          	addi	a5,a5,-652 # 8000b718 <_ZTV9Semaphore+0x10>
    800029ac:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    800029b0:	00850513          	addi	a0,a0,8
    800029b4:	fffff097          	auipc	ra,0xfffff
    800029b8:	968080e7          	jalr	-1688(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
}
    800029bc:	00813083          	ld	ra,8(sp)
    800029c0:	00013403          	ld	s0,0(sp)
    800029c4:	01010113          	addi	sp,sp,16
    800029c8:	00008067          	ret

00000000800029cc <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    800029cc:	ff010113          	addi	sp,sp,-16
    800029d0:	00113423          	sd	ra,8(sp)
    800029d4:	00813023          	sd	s0,0(sp)
    800029d8:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800029dc:	00853503          	ld	a0,8(a0)
    800029e0:	fffff097          	auipc	ra,0xfffff
    800029e4:	9a0080e7          	jalr	-1632(ra) # 80001380 <_Z8sem_waitP10_semaphore>
}
    800029e8:	00813083          	ld	ra,8(sp)
    800029ec:	00013403          	ld	s0,0(sp)
    800029f0:	01010113          	addi	sp,sp,16
    800029f4:	00008067          	ret

00000000800029f8 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800029f8:	ff010113          	addi	sp,sp,-16
    800029fc:	00113423          	sd	ra,8(sp)
    80002a00:	00813023          	sd	s0,0(sp)
    80002a04:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002a08:	00853503          	ld	a0,8(a0)
    80002a0c:	fffff097          	auipc	ra,0xfffff
    80002a10:	9a0080e7          	jalr	-1632(ra) # 800013ac <_Z10sem_signalP10_semaphore>
}
    80002a14:	00813083          	ld	ra,8(sp)
    80002a18:	00013403          	ld	s0,0(sp)
    80002a1c:	01010113          	addi	sp,sp,16
    80002a20:	00008067          	ret

0000000080002a24 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80002a24:	ff010113          	addi	sp,sp,-16
    80002a28:	00113423          	sd	ra,8(sp)
    80002a2c:	00813023          	sd	s0,0(sp)
    80002a30:	01010413          	addi	s0,sp,16
    80002a34:	00009797          	auipc	a5,0x9
    80002a38:	d0478793          	addi	a5,a5,-764 # 8000b738 <_ZTV6Thread+0x10>
    80002a3c:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80002a40:	00850513          	addi	a0,a0,8
    80002a44:	fffff097          	auipc	ra,0xfffff
    80002a48:	830080e7          	jalr	-2000(ra) # 80001274 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002a4c:	00813083          	ld	ra,8(sp)
    80002a50:	00013403          	ld	s0,0(sp)
    80002a54:	01010113          	addi	sp,sp,16
    80002a58:	00008067          	ret

0000000080002a5c <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002a5c:	ff010113          	addi	sp,sp,-16
    80002a60:	00113423          	sd	ra,8(sp)
    80002a64:	00813023          	sd	s0,0(sp)
    80002a68:	01010413          	addi	s0,sp,16
    80002a6c:	00009797          	auipc	a5,0x9
    80002a70:	ccc78793          	addi	a5,a5,-820 # 8000b738 <_ZTV6Thread+0x10>
    80002a74:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    80002a78:	00050613          	mv	a2,a0
    80002a7c:	00000597          	auipc	a1,0x0
    80002a80:	d7c58593          	addi	a1,a1,-644 # 800027f8 <_ZN6Thread7wrapperEPv>
    80002a84:	00850513          	addi	a0,a0,8
    80002a88:	ffffe097          	auipc	ra,0xffffe
    80002a8c:	7ec080e7          	jalr	2028(ra) # 80001274 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002a90:	00813083          	ld	ra,8(sp)
    80002a94:	00013403          	ld	s0,0(sp)
    80002a98:	01010113          	addi	sp,sp,16
    80002a9c:	00008067          	ret

0000000080002aa0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002aa0:	ff010113          	addi	sp,sp,-16
    80002aa4:	00113423          	sd	ra,8(sp)
    80002aa8:	00813023          	sd	s0,0(sp)
    80002aac:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002ab0:	fffff097          	auipc	ra,0xfffff
    80002ab4:	928080e7          	jalr	-1752(ra) # 800013d8 <_Z10time_sleepm>
}
    80002ab8:	00813083          	ld	ra,8(sp)
    80002abc:	00013403          	ld	s0,0(sp)
    80002ac0:	01010113          	addi	sp,sp,16
    80002ac4:	00008067          	ret

0000000080002ac8 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80002ac8:	fe010113          	addi	sp,sp,-32
    80002acc:	00113c23          	sd	ra,24(sp)
    80002ad0:	00813823          	sd	s0,16(sp)
    80002ad4:	00913423          	sd	s1,8(sp)
    80002ad8:	01213023          	sd	s2,0(sp)
    80002adc:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80002ae0:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80002ae4:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80002ae8:	0004b783          	ld	a5,0(s1)
    80002aec:	0187b783          	ld	a5,24(a5)
    80002af0:	00048513          	mv	a0,s1
    80002af4:	000780e7          	jalr	a5
        pt->sleep(time);
    80002af8:	00090513          	mv	a0,s2
    80002afc:	00000097          	auipc	ra,0x0
    80002b00:	fa4080e7          	jalr	-92(ra) # 80002aa0 <_ZN6Thread5sleepEm>
    while(true){
    80002b04:	fe5ff06f          	j	80002ae8 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080002b08 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002b08:	ff010113          	addi	sp,sp,-16
    80002b0c:	00113423          	sd	ra,8(sp)
    80002b10:	00813023          	sd	s0,0(sp)
    80002b14:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002b18:	ffffe097          	auipc	ra,0xffffe
    80002b1c:	73c080e7          	jalr	1852(ra) # 80001254 <_Z15thread_dispatchv>
}
    80002b20:	00813083          	ld	ra,8(sp)
    80002b24:	00013403          	ld	s0,0(sp)
    80002b28:	01010113          	addi	sp,sp,16
    80002b2c:	00008067          	ret

0000000080002b30 <_ZN6Thread5startEv>:
int Thread::start() {
    80002b30:	ff010113          	addi	sp,sp,-16
    80002b34:	00113423          	sd	ra,8(sp)
    80002b38:	00813023          	sd	s0,0(sp)
    80002b3c:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80002b40:	00853503          	ld	a0,8(a0)
    80002b44:	ffffe097          	auipc	ra,0xffffe
    80002b48:	7ac080e7          	jalr	1964(ra) # 800012f0 <_Z12thread_startP7_thread>
}
    80002b4c:	00813083          	ld	ra,8(sp)
    80002b50:	00013403          	ld	s0,0(sp)
    80002b54:	01010113          	addi	sp,sp,16
    80002b58:	00008067          	ret

0000000080002b5c <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80002b5c:	fe010113          	addi	sp,sp,-32
    80002b60:	00113c23          	sd	ra,24(sp)
    80002b64:	00813823          	sd	s0,16(sp)
    80002b68:	00913423          	sd	s1,8(sp)
    80002b6c:	01213023          	sd	s2,0(sp)
    80002b70:	02010413          	addi	s0,sp,32
    80002b74:	00050493          	mv	s1,a0
    80002b78:	00058913          	mv	s2,a1
    80002b7c:	01000513          	li	a0,16
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	d1c080e7          	jalr	-740(ra) # 8000289c <_Znwm>
    80002b88:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80002b8c:	00953023          	sd	s1,0(a0)
    80002b90:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80002b94:	00000597          	auipc	a1,0x0
    80002b98:	f3458593          	addi	a1,a1,-204 # 80002ac8 <_ZN14PeriodicThread7wrapperEPv>
    80002b9c:	00048513          	mv	a0,s1
    80002ba0:	00000097          	auipc	ra,0x0
    80002ba4:	e84080e7          	jalr	-380(ra) # 80002a24 <_ZN6ThreadC1EPFvPvES0_>
    80002ba8:	00009797          	auipc	a5,0x9
    80002bac:	b4078793          	addi	a5,a5,-1216 # 8000b6e8 <_ZTV14PeriodicThread+0x10>
    80002bb0:	00f4b023          	sd	a5,0(s1)
    80002bb4:	01813083          	ld	ra,24(sp)
    80002bb8:	01013403          	ld	s0,16(sp)
    80002bbc:	00813483          	ld	s1,8(sp)
    80002bc0:	00013903          	ld	s2,0(sp)
    80002bc4:	02010113          	addi	sp,sp,32
    80002bc8:	00008067          	ret

0000000080002bcc <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80002bcc:	ff010113          	addi	sp,sp,-16
    80002bd0:	00113423          	sd	ra,8(sp)
    80002bd4:	00813023          	sd	s0,0(sp)
    80002bd8:	01010413          	addi	s0,sp,16
    return ::getc();
    80002bdc:	fffff097          	auipc	ra,0xfffff
    80002be0:	828080e7          	jalr	-2008(ra) # 80001404 <_Z4getcv>
}
    80002be4:	00813083          	ld	ra,8(sp)
    80002be8:	00013403          	ld	s0,0(sp)
    80002bec:	01010113          	addi	sp,sp,16
    80002bf0:	00008067          	ret

0000000080002bf4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80002bf4:	ff010113          	addi	sp,sp,-16
    80002bf8:	00113423          	sd	ra,8(sp)
    80002bfc:	00813023          	sd	s0,0(sp)
    80002c00:	01010413          	addi	s0,sp,16
    ::putc(c);
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	828080e7          	jalr	-2008(ra) # 8000142c <_Z4putcc>
}
    80002c0c:	00813083          	ld	ra,8(sp)
    80002c10:	00013403          	ld	s0,0(sp)
    80002c14:	01010113          	addi	sp,sp,16
    80002c18:	00008067          	ret

0000000080002c1c <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80002c1c:	ff010113          	addi	sp,sp,-16
    80002c20:	00813423          	sd	s0,8(sp)
    80002c24:	01010413          	addi	s0,sp,16
    80002c28:	00813403          	ld	s0,8(sp)
    80002c2c:	01010113          	addi	sp,sp,16
    80002c30:	00008067          	ret

0000000080002c34 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80002c34:	ff010113          	addi	sp,sp,-16
    80002c38:	00813423          	sd	s0,8(sp)
    80002c3c:	01010413          	addi	s0,sp,16
    80002c40:	00813403          	ld	s0,8(sp)
    80002c44:	01010113          	addi	sp,sp,16
    80002c48:	00008067          	ret

0000000080002c4c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80002c4c:	ff010113          	addi	sp,sp,-16
    80002c50:	00113423          	sd	ra,8(sp)
    80002c54:	00813023          	sd	s0,0(sp)
    80002c58:	01010413          	addi	s0,sp,16
    80002c5c:	00009797          	auipc	a5,0x9
    80002c60:	a8c78793          	addi	a5,a5,-1396 # 8000b6e8 <_ZTV14PeriodicThread+0x10>
    80002c64:	00f53023          	sd	a5,0(a0)
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	bf4080e7          	jalr	-1036(ra) # 8000285c <_ZN6ThreadD1Ev>
    80002c70:	00813083          	ld	ra,8(sp)
    80002c74:	00013403          	ld	s0,0(sp)
    80002c78:	01010113          	addi	sp,sp,16
    80002c7c:	00008067          	ret

0000000080002c80 <_ZN14PeriodicThreadD0Ev>:
    80002c80:	fe010113          	addi	sp,sp,-32
    80002c84:	00113c23          	sd	ra,24(sp)
    80002c88:	00813823          	sd	s0,16(sp)
    80002c8c:	00913423          	sd	s1,8(sp)
    80002c90:	02010413          	addi	s0,sp,32
    80002c94:	00050493          	mv	s1,a0
    80002c98:	00009797          	auipc	a5,0x9
    80002c9c:	a5078793          	addi	a5,a5,-1456 # 8000b6e8 <_ZTV14PeriodicThread+0x10>
    80002ca0:	00f53023          	sd	a5,0(a0)
    80002ca4:	00000097          	auipc	ra,0x0
    80002ca8:	bb8080e7          	jalr	-1096(ra) # 8000285c <_ZN6ThreadD1Ev>
    80002cac:	00048513          	mv	a0,s1
    80002cb0:	00000097          	auipc	ra,0x0
    80002cb4:	c3c080e7          	jalr	-964(ra) # 800028ec <_ZdlPv>
    80002cb8:	01813083          	ld	ra,24(sp)
    80002cbc:	01013403          	ld	s0,16(sp)
    80002cc0:	00813483          	ld	s1,8(sp)
    80002cc4:	02010113          	addi	sp,sp,32
    80002cc8:	00008067          	ret

0000000080002ccc <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80002ccc:	ff010113          	addi	sp,sp,-16
    80002cd0:	00113423          	sd	ra,8(sp)
    80002cd4:	00813023          	sd	s0,0(sp)
    80002cd8:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80002cdc:	00009797          	auipc	a5,0x9
    80002ce0:	bcc7b783          	ld	a5,-1076(a5) # 8000b8a8 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80002ce4:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    80002ce8:	fffff097          	auipc	ra,0xfffff
    80002cec:	674080e7          	jalr	1652(ra) # 8000235c <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80002cf0:	00001097          	auipc	ra,0x1
    80002cf4:	ed8080e7          	jalr	-296(ra) # 80003bc8 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80002cf8:	fffff097          	auipc	ra,0xfffff
    80002cfc:	544080e7          	jalr	1348(ra) # 8000223c <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    80002d00:	00001097          	auipc	ra,0x1
    80002d04:	0dc080e7          	jalr	220(ra) # 80003ddc <_ZN11ConsoleUtil10initializeEv>
    Buddy::initialize();
    80002d08:	ffffe097          	auipc	ra,0xffffe
    80002d0c:	7d0080e7          	jalr	2000(ra) # 800014d8 <_ZN5Buddy10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80002d10:	00200793          	li	a5,2
    80002d14:	1047a073          	csrs	sie,a5
    80002d18:	20000713          	li	a4,512
    80002d1c:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002d20:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80002d24:	00813083          	ld	ra,8(sp)
    80002d28:	00013403          	ld	s0,0(sp)
    80002d2c:	01010113          	addi	sp,sp,16
    80002d30:	00008067          	ret

0000000080002d34 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80002d34:	ff010113          	addi	sp,sp,-16
    80002d38:	00813423          	sd	s0,8(sp)
    80002d3c:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80002d40:	14109073          	csrw	sepc,ra
    asm("sret");
    80002d44:	10200073          	sret
}
    80002d48:	00813403          	ld	s0,8(sp)
    80002d4c:	01010113          	addi	sp,sp,16
    80002d50:	00008067          	ret

0000000080002d54 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80002d54:	ff010113          	addi	sp,sp,-16
    80002d58:	00113423          	sd	ra,8(sp)
    80002d5c:	00813023          	sd	s0,0(sp)
    80002d60:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80002d64:	00009797          	auipc	a5,0x9
    80002d68:	b647b783          	ld	a5,-1180(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002d6c:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80002d70:	00100713          	li	a4,1
    80002d74:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002d78:	fffff097          	auipc	ra,0xfffff
    80002d7c:	41c080e7          	jalr	1052(ra) # 80002194 <_ZN3TCB8dispatchEv>
}
    80002d80:	00813083          	ld	ra,8(sp)
    80002d84:	00013403          	ld	s0,0(sp)
    80002d88:	01010113          	addi	sp,sp,16
    80002d8c:	00008067          	ret

0000000080002d90 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80002d90:	ff010113          	addi	sp,sp,-16
    80002d94:	00113423          	sd	ra,8(sp)
    80002d98:	00813023          	sd	s0,0(sp)
    80002d9c:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80002da0:	00009797          	auipc	a5,0x9
    80002da4:	cd07c783          	lbu	a5,-816(a5) # 8000ba70 <_ZN5RiscV16userMainFinishedE>
    80002da8:	00079c63          	bnez	a5,80002dc0 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80002dac:	00009717          	auipc	a4,0x9
    80002db0:	b1473703          	ld	a4,-1260(a4) # 8000b8c0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002db4:	00073783          	ld	a5,0(a4)
    80002db8:	00178793          	addi	a5,a5,1
    80002dbc:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80002dc0:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80002dc4:	0ff57513          	andi	a0,a0,255
    80002dc8:	00001097          	auipc	ra,0x1
    80002dcc:	1a4080e7          	jalr	420(ra) # 80003f6c <_ZN11ConsoleUtil9putOutputEc>
}
    80002dd0:	00813083          	ld	ra,8(sp)
    80002dd4:	00013403          	ld	s0,0(sp)
    80002dd8:	01010113          	addi	sp,sp,16
    80002ddc:	00008067          	ret

0000000080002de0 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80002de0:	fe010113          	addi	sp,sp,-32
    80002de4:	00113c23          	sd	ra,24(sp)
    80002de8:	00813823          	sd	s0,16(sp)
    80002dec:	02010413          	addi	s0,sp,32
    80002df0:	00c0006f          	j	80002dfc <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80002df4:	ffffe097          	auipc	ra,0xffffe
    80002df8:	460080e7          	jalr	1120(ra) # 80001254 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80002dfc:	00009797          	auipc	a5,0x9
    80002e00:	a547b783          	ld	a5,-1452(a5) # 8000b850 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002e04:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80002e08:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80002e0c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80002e10:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80002e14:	0207f793          	andi	a5,a5,32
    80002e18:	fc078ee3          	beqz	a5,80002df4 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80002e1c:	00001097          	auipc	ra,0x1
    80002e20:	368080e7          	jalr	872(ra) # 80004184 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80002e24:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80002e28:	00009797          	auipc	a5,0x9
    80002e2c:	a207b783          	ld	a5,-1504(a5) # 8000b848 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002e30:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80002e34:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80002e38:	fef44783          	lbu	a5,-17(s0)
    80002e3c:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80002e40:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80002e44:	00009797          	auipc	a5,0x9
    80002e48:	a7c7b783          	ld	a5,-1412(a5) # 8000b8c0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002e4c:	0007b783          	ld	a5,0(a5)
    80002e50:	fa0786e3          	beqz	a5,80002dfc <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80002e54:	fff78793          	addi	a5,a5,-1
    80002e58:	00009717          	auipc	a4,0x9
    80002e5c:	a6873703          	ld	a4,-1432(a4) # 8000b8c0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002e60:	00f73023          	sd	a5,0(a4)
    80002e64:	f99ff06f          	j	80002dfc <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080002e68 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80002e68:	ff010113          	addi	sp,sp,-16
    80002e6c:	00813423          	sd	s0,8(sp)
    80002e70:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80002e74:	00009797          	auipc	a5,0x9
    80002e78:	a547b783          	ld	a5,-1452(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002e7c:	0007b783          	ld	a5,0(a5)
    80002e80:	0147a703          	lw	a4,20(a5)
    80002e84:	00100793          	li	a5,1
    80002e88:	00f70c63          	beq	a4,a5,80002ea0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80002e8c:	10000793          	li	a5,256
    80002e90:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80002e94:	00813403          	ld	s0,8(sp)
    80002e98:	01010113          	addi	sp,sp,16
    80002e9c:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80002ea0:	10000793          	li	a5,256
    80002ea4:	1007a073          	csrs	sstatus,a5
}
    80002ea8:	fedff06f          	j	80002e94 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080002eac <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80002eac:	ff010113          	addi	sp,sp,-16
    80002eb0:	00113423          	sd	ra,8(sp)
    80002eb4:	00813023          	sd	s0,0(sp)
    80002eb8:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80002ebc:	00100793          	li	a5,1
    80002ec0:	00009717          	auipc	a4,0x9
    80002ec4:	baf70823          	sb	a5,-1104(a4) # 8000ba70 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80002ec8:	00009797          	auipc	a5,0x9
    80002ecc:	9f87b783          	ld	a5,-1544(a5) # 8000b8c0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002ed0:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80002ed4:	00009797          	auipc	a5,0x9
    80002ed8:	9a47b783          	ld	a5,-1628(a5) # 8000b878 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002edc:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80002ee0:	00200793          	li	a5,2
    80002ee4:	1047b073          	csrc	sie,a5
    80002ee8:	20000793          	li	a5,512
    80002eec:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80002ef0:	00009797          	auipc	a5,0x9
    80002ef4:	9a87b783          	ld	a5,-1624(a5) # 8000b898 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002ef8:	0007b783          	ld	a5,0(a5)
    80002efc:	00078c63          	beqz	a5,80002f14 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80002f00:	0487b703          	ld	a4,72(a5)
    80002f04:	00009797          	auipc	a5,0x9
    80002f08:	9947b783          	ld	a5,-1644(a5) # 8000b898 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002f0c:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80002f10:	fe1ff06f          	j	80002ef0 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80002f14:	00009797          	auipc	a5,0x9
    80002f18:	98c7b783          	ld	a5,-1652(a5) # 8000b8a0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002f1c:	0007b503          	ld	a0,0(a5)
    80002f20:	00001097          	auipc	ra,0x1
    80002f24:	cc0080e7          	jalr	-832(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002f28:	00009797          	auipc	a5,0x9
    80002f2c:	9887b783          	ld	a5,-1656(a5) # 8000b8b0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002f30:	0007b703          	ld	a4,0(a5)
    80002f34:	00009797          	auipc	a5,0x9
    80002f38:	9847b783          	ld	a5,-1660(a5) # 8000b8b8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002f3c:	0007b783          	ld	a5,0(a5)
    80002f40:	00f70863          	beq	a4,a5,80002f50 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80002f44:	ffffe097          	auipc	ra,0xffffe
    80002f48:	310080e7          	jalr	784(ra) # 80001254 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80002f4c:	fddff06f          	j	80002f28 <_ZN5RiscV8finalizeEv+0x7c>
}
    80002f50:	00813083          	ld	ra,8(sp)
    80002f54:	00013403          	ld	s0,0(sp)
    80002f58:	01010113          	addi	sp,sp,16
    80002f5c:	00008067          	ret

0000000080002f60 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00813423          	sd	s0,8(sp)
    80002f68:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80002f6c:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80002f70:	00009717          	auipc	a4,0x9
    80002f74:	95873703          	ld	a4,-1704(a4) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002f78:	00073703          	ld	a4,0(a4)
    80002f7c:	06873703          	ld	a4,104(a4)
    80002f80:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80002f84:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80002f88:	00078593          	mv	a1,a5
}
    80002f8c:	00813403          	ld	s0,8(sp)
    80002f90:	01010113          	addi	sp,sp,16
    80002f94:	00008067          	ret

0000000080002f98 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80002f98:	ff010113          	addi	sp,sp,-16
    80002f9c:	00113423          	sd	ra,8(sp)
    80002fa0:	00813023          	sd	s0,0(sp)
    80002fa4:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80002fa8:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80002fac:	fffff097          	auipc	ra,0xfffff
    80002fb0:	430080e7          	jalr	1072(ra) # 800023dc <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80002fb4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002fb8:	00000097          	auipc	ra,0x0
    80002fbc:	fa8080e7          	jalr	-88(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80002fc0:	00813083          	ld	ra,8(sp)
    80002fc4:	00013403          	ld	s0,0(sp)
    80002fc8:	01010113          	addi	sp,sp,16
    80002fcc:	00008067          	ret

0000000080002fd0 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80002fd0:	ff010113          	addi	sp,sp,-16
    80002fd4:	00113423          	sd	ra,8(sp)
    80002fd8:	00813023          	sd	s0,0(sp)
    80002fdc:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80002fe0:	00009797          	auipc	a5,0x9
    80002fe4:	8f07b783          	ld	a5,-1808(a5) # 8000b8d0 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002fe8:	0007c783          	lbu	a5,0(a5)
    80002fec:	02079263          	bnez	a5,80003010 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80002ff0:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80002ff4:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80002ff8:	00000097          	auipc	ra,0x0
    80002ffc:	f68080e7          	jalr	-152(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003000:	00813083          	ld	ra,8(sp)
    80003004:	00013403          	ld	s0,0(sp)
    80003008:	01010113          	addi	sp,sp,16
    8000300c:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003010:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	5f0080e7          	jalr	1520(ra) # 80002604 <_ZN15MemoryAllocator5kfreeEPv>
    8000301c:	fd9ff06f          	j	80002ff4 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003020 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003020:	fc010113          	addi	sp,sp,-64
    80003024:	02113c23          	sd	ra,56(sp)
    80003028:	02813823          	sd	s0,48(sp)
    8000302c:	02913423          	sd	s1,40(sp)
    80003030:	03213023          	sd	s2,32(sp)
    80003034:	01313c23          	sd	s3,24(sp)
    80003038:	01413823          	sd	s4,16(sp)
    8000303c:	01513423          	sd	s5,8(sp)
    80003040:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003044:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003048:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000304c:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003050:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003054:	07000513          	li	a0,112
    80003058:	fffff097          	auipc	ra,0xfffff
    8000305c:	1bc080e7          	jalr	444(ra) # 80002214 <_ZN3TCBnwEm>
    80003060:	00050493          	mv	s1,a0
    80003064:	00200713          	li	a4,2
    80003068:	000a0693          	mv	a3,s4
    8000306c:	00098613          	mv	a2,s3
    80003070:	00090593          	mv	a1,s2
    80003074:	fffff097          	auipc	ra,0xfffff
    80003078:	054080e7          	jalr	84(ra) # 800020c8 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000307c:	04048863          	beqz	s1,800030cc <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003080:	0184b783          	ld	a5,24(s1)
    80003084:	00078863          	beqz	a5,80003094 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003088:	00048513          	mv	a0,s1
    8000308c:	00001097          	auipc	ra,0x1
    80003090:	b54080e7          	jalr	-1196(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003094:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003098:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000309c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800030a0:	00000097          	auipc	ra,0x0
    800030a4:	ec0080e7          	jalr	-320(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    800030a8:	03813083          	ld	ra,56(sp)
    800030ac:	03013403          	ld	s0,48(sp)
    800030b0:	02813483          	ld	s1,40(sp)
    800030b4:	02013903          	ld	s2,32(sp)
    800030b8:	01813983          	ld	s3,24(sp)
    800030bc:	01013a03          	ld	s4,16(sp)
    800030c0:	00813a83          	ld	s5,8(sp)
    800030c4:	04010113          	addi	sp,sp,64
    800030c8:	00008067          	ret
        status = -1;
    800030cc:	fff00793          	li	a5,-1
    800030d0:	fcdff06f          	j	8000309c <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    800030d4:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800030d8:	00048513          	mv	a0,s1
    800030dc:	fffff097          	auipc	ra,0xfffff
    800030e0:	22c080e7          	jalr	556(ra) # 80002308 <_ZN3TCBdlEPv>
    800030e4:	00090513          	mv	a0,s2
    800030e8:	0000e097          	auipc	ra,0xe
    800030ec:	ae0080e7          	jalr	-1312(ra) # 80010bc8 <_Unwind_Resume>

00000000800030f0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    800030f0:	fc010113          	addi	sp,sp,-64
    800030f4:	02113c23          	sd	ra,56(sp)
    800030f8:	02813823          	sd	s0,48(sp)
    800030fc:	02913423          	sd	s1,40(sp)
    80003100:	03213023          	sd	s2,32(sp)
    80003104:	01313c23          	sd	s3,24(sp)
    80003108:	01413823          	sd	s4,16(sp)
    8000310c:	01513423          	sd	s5,8(sp)
    80003110:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003114:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003118:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000311c:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003120:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003124:	07000513          	li	a0,112
    80003128:	fffff097          	auipc	ra,0xfffff
    8000312c:	0ec080e7          	jalr	236(ra) # 80002214 <_ZN3TCBnwEm>
    80003130:	00050493          	mv	s1,a0
    80003134:	00200713          	li	a4,2
    80003138:	00090693          	mv	a3,s2
    8000313c:	00098613          	mv	a2,s3
    80003140:	000a0593          	mv	a1,s4
    80003144:	fffff097          	auipc	ra,0xfffff
    80003148:	f84080e7          	jalr	-124(ra) # 800020c8 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000314c:	04048263          	beqz	s1,80003190 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003150:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003154:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003158:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    8000315c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003160:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003164:	00000097          	auipc	ra,0x0
    80003168:	dfc080e7          	jalr	-516(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000316c:	03813083          	ld	ra,56(sp)
    80003170:	03013403          	ld	s0,48(sp)
    80003174:	02813483          	ld	s1,40(sp)
    80003178:	02013903          	ld	s2,32(sp)
    8000317c:	01813983          	ld	s3,24(sp)
    80003180:	01013a03          	ld	s4,16(sp)
    80003184:	00813a83          	ld	s5,8(sp)
    80003188:	04010113          	addi	sp,sp,64
    8000318c:	00008067          	ret
        status = -1;
    80003190:	fff00793          	li	a5,-1
    80003194:	fcdff06f          	j	80003160 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003198:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000319c:	00048513          	mv	a0,s1
    800031a0:	fffff097          	auipc	ra,0xfffff
    800031a4:	168080e7          	jalr	360(ra) # 80002308 <_ZN3TCBdlEPv>
    800031a8:	00090513          	mv	a0,s2
    800031ac:	0000e097          	auipc	ra,0xe
    800031b0:	a1c080e7          	jalr	-1508(ra) # 80010bc8 <_Unwind_Resume>

00000000800031b4 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800031b4:	ff010113          	addi	sp,sp,-16
    800031b8:	00113423          	sd	ra,8(sp)
    800031bc:	00813023          	sd	s0,0(sp)
    800031c0:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800031c4:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    800031c8:	02051263          	bnez	a0,800031ec <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    800031cc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800031d0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800031d4:	00000097          	auipc	ra,0x0
    800031d8:	d8c080e7          	jalr	-628(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    800031dc:	00813083          	ld	ra,8(sp)
    800031e0:	00013403          	ld	s0,0(sp)
    800031e4:	01010113          	addi	sp,sp,16
    800031e8:	00008067          	ret
        tcb->status = TCB::Status::READY;
    800031ec:	00100793          	li	a5,1
    800031f0:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    800031f4:	00001097          	auipc	ra,0x1
    800031f8:	9ec080e7          	jalr	-1556(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    800031fc:	fffff097          	auipc	ra,0xfffff
    80003200:	f98080e7          	jalr	-104(ra) # 80002194 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003204:	00000793          	li	a5,0
    80003208:	fc9ff06f          	j	800031d0 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

000000008000320c <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    8000320c:	ff010113          	addi	sp,sp,-16
    80003210:	00113423          	sd	ra,8(sp)
    80003214:	00813023          	sd	s0,0(sp)
    80003218:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000321c:	00008797          	auipc	a5,0x8
    80003220:	6ac7b783          	ld	a5,1708(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003224:	0007b783          	ld	a5,0(a5)
    80003228:	02078a63          	beqz	a5,8000325c <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    8000322c:	00200713          	li	a4,2
    80003230:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003234:	fffff097          	auipc	ra,0xfffff
    80003238:	f60080e7          	jalr	-160(ra) # 80002194 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000323c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003240:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003244:	00000097          	auipc	ra,0x0
    80003248:	d1c080e7          	jalr	-740(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000324c:	00813083          	ld	ra,8(sp)
    80003250:	00013403          	ld	s0,0(sp)
    80003254:	01010113          	addi	sp,sp,16
    80003258:	00008067          	ret
        status = -1;
    8000325c:	fff00793          	li	a5,-1
    80003260:	fe1ff06f          	j	80003240 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003264 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003264:	fd010113          	addi	sp,sp,-48
    80003268:	02113423          	sd	ra,40(sp)
    8000326c:	02813023          	sd	s0,32(sp)
    80003270:	00913c23          	sd	s1,24(sp)
    80003274:	01213823          	sd	s2,16(sp)
    80003278:	01313423          	sd	s3,8(sp)
    8000327c:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003280:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003284:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003288:	01800513          	li	a0,24
    8000328c:	fffff097          	auipc	ra,0xfffff
    80003290:	d4c080e7          	jalr	-692(ra) # 80001fd8 <_ZN3SCBnwEm>
    80003294:	00050493          	mv	s1,a0
    80003298:	00090593          	mv	a1,s2
    8000329c:	fffff097          	auipc	ra,0xfffff
    800032a0:	b80080e7          	jalr	-1152(ra) # 80001e1c <_ZN3SCBC1Em>
    if(scb == nullptr){
    800032a4:	02048a63          	beqz	s1,800032d8 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    800032a8:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    800032ac:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800032b0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800032b4:	00000097          	auipc	ra,0x0
    800032b8:	cac080e7          	jalr	-852(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    800032bc:	02813083          	ld	ra,40(sp)
    800032c0:	02013403          	ld	s0,32(sp)
    800032c4:	01813483          	ld	s1,24(sp)
    800032c8:	01013903          	ld	s2,16(sp)
    800032cc:	00813983          	ld	s3,8(sp)
    800032d0:	03010113          	addi	sp,sp,48
    800032d4:	00008067          	ret
        status = -1;
    800032d8:	fff00793          	li	a5,-1
    800032dc:	fd5ff06f          	j	800032b0 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    800032e0:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    800032e4:	00048513          	mv	a0,s1
    800032e8:	fffff097          	auipc	ra,0xfffff
    800032ec:	d18080e7          	jalr	-744(ra) # 80002000 <_ZN3SCBdlEPv>
    800032f0:	00090513          	mv	a0,s2
    800032f4:	0000e097          	auipc	ra,0xe
    800032f8:	8d4080e7          	jalr	-1836(ra) # 80010bc8 <_Unwind_Resume>

00000000800032fc <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    800032fc:	fe010113          	addi	sp,sp,-32
    80003300:	00113c23          	sd	ra,24(sp)
    80003304:	00813823          	sd	s0,16(sp)
    80003308:	00913423          	sd	s1,8(sp)
    8000330c:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003310:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003314:	02049463          	bnez	s1,8000333c <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003318:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000331c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003320:	00000097          	auipc	ra,0x0
    80003324:	c40080e7          	jalr	-960(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003328:	01813083          	ld	ra,24(sp)
    8000332c:	01013403          	ld	s0,16(sp)
    80003330:	00813483          	ld	s1,8(sp)
    80003334:	02010113          	addi	sp,sp,32
    80003338:	00008067          	ret
        delete (SCB*)ihandle;
    8000333c:	00048513          	mv	a0,s1
    80003340:	fffff097          	auipc	ra,0xfffff
    80003344:	b00080e7          	jalr	-1280(ra) # 80001e40 <_ZN3SCBD1Ev>
    80003348:	00048513          	mv	a0,s1
    8000334c:	fffff097          	auipc	ra,0xfffff
    80003350:	cb4080e7          	jalr	-844(ra) # 80002000 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003354:	00000793          	li	a5,0
    80003358:	fc5ff06f          	j	8000331c <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

000000008000335c <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    8000335c:	ff010113          	addi	sp,sp,-16
    80003360:	00113423          	sd	ra,8(sp)
    80003364:	00813023          	sd	s0,0(sp)
    80003368:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000336c:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003370:	02051c63          	bnez	a0,800033a8 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003374:	00008797          	auipc	a5,0x8
    80003378:	5547b783          	ld	a5,1364(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000337c:	0007b783          	ld	a5,0(a5)
    80003380:	0607b783          	ld	a5,96(a5)
    80003384:	02078863          	beqz	a5,800033b4 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003388:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000338c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003390:	00000097          	auipc	ra,0x0
    80003394:	bd0080e7          	jalr	-1072(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003398:	00813083          	ld	ra,8(sp)
    8000339c:	00013403          	ld	s0,0(sp)
    800033a0:	01010113          	addi	sp,sp,16
    800033a4:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800033a8:	fffff097          	auipc	ra,0xfffff
    800033ac:	ba4080e7          	jalr	-1116(ra) # 80001f4c <_ZN3SCB4waitEv>
    800033b0:	fc5ff06f          	j	80003374 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800033b4:	00000793          	li	a5,0
    800033b8:	fd5ff06f          	j	8000338c <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800033bc <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800033bc:	ff010113          	addi	sp,sp,-16
    800033c0:	00113423          	sd	ra,8(sp)
    800033c4:	00813023          	sd	s0,0(sp)
    800033c8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800033cc:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800033d0:	02051263          	bnez	a0,800033f4 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800033d4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800033d8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800033dc:	00000097          	auipc	ra,0x0
    800033e0:	b84080e7          	jalr	-1148(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    800033e4:	00813083          	ld	ra,8(sp)
    800033e8:	00013403          	ld	s0,0(sp)
    800033ec:	01010113          	addi	sp,sp,16
    800033f0:	00008067          	ret
        ((SCB*)ihandle)->signal();
    800033f4:	fffff097          	auipc	ra,0xfffff
    800033f8:	ba8080e7          	jalr	-1112(ra) # 80001f9c <_ZN3SCB6signalEv>
    uint64 status = 0;
    800033fc:	00000793          	li	a5,0
    80003400:	fd9ff06f          	j	800033d8 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003404 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003404:	fe010113          	addi	sp,sp,-32
    80003408:	00113c23          	sd	ra,24(sp)
    8000340c:	00813823          	sd	s0,16(sp)
    80003410:	00913423          	sd	s1,8(sp)
    80003414:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003418:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000341c:	00008797          	auipc	a5,0x8
    80003420:	4ac7b783          	ld	a5,1196(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003424:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003428:	00008797          	auipc	a5,0x8
    8000342c:	6507b783          	ld	a5,1616(a5) # 8000ba78 <_ZN5RiscV10globalTimeE>
    80003430:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003434:	00e787b3          	add	a5,a5,a4
    80003438:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    8000343c:	00048513          	mv	a0,s1
    80003440:	00001097          	auipc	ra,0x1
    80003444:	81c080e7          	jalr	-2020(ra) # 80003c5c <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003448:	00300793          	li	a5,3
    8000344c:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003450:	fffff097          	auipc	ra,0xfffff
    80003454:	d44080e7          	jalr	-700(ra) # 80002194 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003458:	00000793          	li	a5,0
    8000345c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003460:	00000097          	auipc	ra,0x0
    80003464:	b00080e7          	jalr	-1280(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003468:	01813083          	ld	ra,24(sp)
    8000346c:	01013403          	ld	s0,16(sp)
    80003470:	00813483          	ld	s1,8(sp)
    80003474:	02010113          	addi	sp,sp,32
    80003478:	00008067          	ret

000000008000347c <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    8000347c:	fe010113          	addi	sp,sp,-32
    80003480:	00113c23          	sd	ra,24(sp)
    80003484:	00813823          	sd	s0,16(sp)
    80003488:	00913423          	sd	s1,8(sp)
    8000348c:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003490:	00008797          	auipc	a5,0x8
    80003494:	5e07c783          	lbu	a5,1504(a5) # 8000ba70 <_ZN5RiscV16userMainFinishedE>
    80003498:	00079c63          	bnez	a5,800034b0 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    8000349c:	00008717          	auipc	a4,0x8
    800034a0:	3dc73703          	ld	a4,988(a4) # 8000b878 <_GLOBAL_OFFSET_TABLE_+0x38>
    800034a4:	00073783          	ld	a5,0(a4)
    800034a8:	00178793          	addi	a5,a5,1
    800034ac:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800034b0:	00001097          	auipc	ra,0x1
    800034b4:	a44080e7          	jalr	-1468(ra) # 80003ef4 <_ZN11ConsoleUtil8getInputEv>
    800034b8:	00050493          	mv	s1,a0
    if(c==13) {
    800034bc:	00d00793          	li	a5,13
    800034c0:	02f50663          	beq	a0,a5,800034ec <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800034c4:	01b00793          	li	a5,27
    800034c8:	04f51063          	bne	a0,a5,80003508 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800034cc:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800034d0:	00000097          	auipc	ra,0x0
    800034d4:	a90080e7          	jalr	-1392(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    800034d8:	01813083          	ld	ra,24(sp)
    800034dc:	01013403          	ld	s0,16(sp)
    800034e0:	00813483          	ld	s1,8(sp)
    800034e4:	02010113          	addi	sp,sp,32
    800034e8:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800034ec:	00d00513          	li	a0,13
    800034f0:	00001097          	auipc	ra,0x1
    800034f4:	a7c080e7          	jalr	-1412(ra) # 80003f6c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    800034f8:	00a00513          	li	a0,10
    800034fc:	00001097          	auipc	ra,0x1
    80003500:	a70080e7          	jalr	-1424(ra) # 80003f6c <_ZN11ConsoleUtil9putOutputEc>
    80003504:	fc9ff06f          	j	800034cc <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003508:	00001097          	auipc	ra,0x1
    8000350c:	a64080e7          	jalr	-1436(ra) # 80003f6c <_ZN11ConsoleUtil9putOutputEc>
    80003510:	fbdff06f          	j	800034cc <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003514 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003514:	ff010113          	addi	sp,sp,-16
    80003518:	00113423          	sd	ra,8(sp)
    8000351c:	00813023          	sd	s0,0(sp)
    80003520:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003524:	00001097          	auipc	ra,0x1
    80003528:	ac8080e7          	jalr	-1336(ra) # 80003fec <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    8000352c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003530:	00000097          	auipc	ra,0x0
    80003534:	a30080e7          	jalr	-1488(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003538:	00813083          	ld	ra,8(sp)
    8000353c:	00013403          	ld	s0,0(sp)
    80003540:	01010113          	addi	sp,sp,16
    80003544:	00008067          	ret

0000000080003548 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003548:	fe010113          	addi	sp,sp,-32
    8000354c:	00113c23          	sd	ra,24(sp)
    80003550:	00813823          	sd	s0,16(sp)
    80003554:	00913423          	sd	s1,8(sp)
    80003558:	01213023          	sd	s2,0(sp)
    8000355c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003560:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003564:	02049663          	bnez	s1,80003590 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    80003568:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000356c:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    80003570:	00000097          	auipc	ra,0x0
    80003574:	9f0080e7          	jalr	-1552(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003578:	01813083          	ld	ra,24(sp)
    8000357c:	01013403          	ld	s0,16(sp)
    80003580:	00813483          	ld	s1,8(sp)
    80003584:	00013903          	ld	s2,0(sp)
    80003588:	02010113          	addi	sp,sp,32
    8000358c:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    80003590:	0284b503          	ld	a0,40(s1)
    80003594:	fffff097          	auipc	ra,0xfffff
    80003598:	070080e7          	jalr	112(ra) # 80002604 <_ZN15MemoryAllocator5kfreeEPv>
    8000359c:	00050913          	mv	s2,a0
        delete thr;
    800035a0:	00048513          	mv	a0,s1
    800035a4:	fffff097          	auipc	ra,0xfffff
    800035a8:	bc8080e7          	jalr	-1080(ra) # 8000216c <_ZN3TCBD1Ev>
    800035ac:	00048513          	mv	a0,s1
    800035b0:	fffff097          	auipc	ra,0xfffff
    800035b4:	d58080e7          	jalr	-680(ra) # 80002308 <_ZN3TCBdlEPv>
    800035b8:	fb5ff06f          	j	8000356c <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

00000000800035bc <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800035bc:	fe010113          	addi	sp,sp,-32
    800035c0:	00113c23          	sd	ra,24(sp)
    800035c4:	00813823          	sd	s0,16(sp)
    800035c8:	00913423          	sd	s1,8(sp)
    800035cc:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800035d0:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    800035d4:	02049463          	bnez	s1,800035fc <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800035d8:	fff00793          	li	a5,-1
    800035dc:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	980080e7          	jalr	-1664(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>
}
    800035e8:	01813083          	ld	ra,24(sp)
    800035ec:	01013403          	ld	s0,16(sp)
    800035f0:	00813483          	ld	s1,8(sp)
    800035f4:	02010113          	addi	sp,sp,32
    800035f8:	00008067          	ret
        delete scb;
    800035fc:	00048513          	mv	a0,s1
    80003600:	fffff097          	auipc	ra,0xfffff
    80003604:	840080e7          	jalr	-1984(ra) # 80001e40 <_ZN3SCBD1Ev>
    80003608:	00048513          	mv	a0,s1
    8000360c:	fffff097          	auipc	ra,0xfffff
    80003610:	9f4080e7          	jalr	-1548(ra) # 80002000 <_ZN3SCBdlEPv>
    80003614:	fc5ff06f          	j	800035d8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003618 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003618:	fe010113          	addi	sp,sp,-32
    8000361c:	00113c23          	sd	ra,24(sp)
    80003620:	00813823          	sd	s0,16(sp)
    80003624:	00913423          	sd	s1,8(sp)
    80003628:	01213023          	sd	s2,0(sp)
    8000362c:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003630:	04000513          	li	a0,64
    80003634:	fffff097          	auipc	ra,0xfffff
    80003638:	da8080e7          	jalr	-600(ra) # 800023dc <_ZN15MemoryAllocator7kmallocEm>
    8000363c:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003640:	00008797          	auipc	a5,0x8
    80003644:	2887b783          	ld	a5,648(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003648:	0007b783          	ld	a5,0(a5)
    8000364c:	00001637          	lui	a2,0x1
    80003650:	00050593          	mv	a1,a0
    80003654:	0287b503          	ld	a0,40(a5)
    80003658:	fffff097          	auipc	ra,0xfffff
    8000365c:	160080e7          	jalr	352(ra) # 800027b8 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003660:	07000513          	li	a0,112
    80003664:	fffff097          	auipc	ra,0xfffff
    80003668:	bb0080e7          	jalr	-1104(ra) # 80002214 <_ZN3TCBnwEm>
    8000366c:	00050493          	mv	s1,a0
    80003670:	00200713          	li	a4,2
    80003674:	00090693          	mv	a3,s2
    80003678:	00000613          	li	a2,0
    8000367c:	00000593          	li	a1,0
    80003680:	fffff097          	auipc	ra,0xfffff
    80003684:	a48080e7          	jalr	-1464(ra) # 800020c8 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003688:	0a048e63          	beqz	s1,80003744 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    8000368c:	00008797          	auipc	a5,0x8
    80003690:	2047b783          	ld	a5,516(a5) # 8000b890 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003694:	0007b783          	ld	a5,0(a5)
    80003698:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    8000369c:	00008797          	auipc	a5,0x8
    800036a0:	1e47b783          	ld	a5,484(a5) # 8000b880 <_GLOBAL_OFFSET_TABLE_+0x40>
    800036a4:	0007b783          	ld	a5,0(a5)
    800036a8:	00f907b3          	add	a5,s2,a5
    800036ac:	00008717          	auipc	a4,0x8
    800036b0:	21c73703          	ld	a4,540(a4) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800036b4:	00073683          	ld	a3,0(a4)
    800036b8:	0286b683          	ld	a3,40(a3)
    800036bc:	40d787b3          	sub	a5,a5,a3
    800036c0:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800036c4:	00073783          	ld	a5,0(a4)
    800036c8:	0687b503          	ld	a0,104(a5)
    800036cc:	0287b783          	ld	a5,40(a5)
    800036d0:	40f50533          	sub	a0,a0,a5
    800036d4:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    800036d8:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800036dc:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800036e0:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800036e4:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800036e8:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800036ec:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800036f0:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800036f4:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800036f8:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800036fc:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003700:	00073783          	ld	a5,0(a4)
    80003704:	0387b703          	ld	a4,56(a5)
    80003708:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    8000370c:	0407b783          	ld	a5,64(a5)
    80003710:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003714:	00048513          	mv	a0,s1
    80003718:	00000097          	auipc	ra,0x0
    8000371c:	4c8080e7          	jalr	1224(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003720:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003724:	00000097          	auipc	ra,0x0
    80003728:	83c080e7          	jalr	-1988(ra) # 80002f60 <_ZN5RiscV16saveA0toSscratchEv>

}
    8000372c:	01813083          	ld	ra,24(sp)
    80003730:	01013403          	ld	s0,16(sp)
    80003734:	00813483          	ld	s1,8(sp)
    80003738:	00013903          	ld	s2,0(sp)
    8000373c:	02010113          	addi	sp,sp,32
    80003740:	00008067          	ret
        status = -1;
    80003744:	fff00493          	li	s1,-1
    80003748:	fd9ff06f          	j	80003720 <_ZN5RiscV18executeForkSyscallEv+0x108>
    8000374c:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003750:	00048513          	mv	a0,s1
    80003754:	fffff097          	auipc	ra,0xfffff
    80003758:	bb4080e7          	jalr	-1100(ra) # 80002308 <_ZN3TCBdlEPv>
    8000375c:	00090513          	mv	a0,s2
    80003760:	0000d097          	auipc	ra,0xd
    80003764:	468080e7          	jalr	1128(ra) # 80010bc8 <_Unwind_Resume>

0000000080003768 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003768:	ff010113          	addi	sp,sp,-16
    8000376c:	00813423          	sd	s0,8(sp)
    80003770:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003774:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003778:	00878793          	addi	a5,a5,8
    8000377c:	00008717          	auipc	a4,0x8
    80003780:	11473703          	ld	a4,276(a4) # 8000b890 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003784:	00f73023          	sd	a5,0(a4)
}
    80003788:	00813403          	ld	s0,8(sp)
    8000378c:	01010113          	addi	sp,sp,16
    80003790:	00008067          	ret

0000000080003794 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003794:	fa010113          	addi	sp,sp,-96
    80003798:	04113c23          	sd	ra,88(sp)
    8000379c:	04813823          	sd	s0,80(sp)
    800037a0:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800037a4:	142027f3          	csrr	a5,scause
    800037a8:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    800037ac:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    800037b0:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800037b4:	00008797          	auipc	a5,0x8
    800037b8:	1147b783          	ld	a5,276(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800037bc:	0007b783          	ld	a5,0(a5)
    800037c0:	14002773          	csrr	a4,sscratch
    800037c4:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800037c8:	fe843703          	ld	a4,-24(s0)
    800037cc:	00900793          	li	a5,9
    800037d0:	0ef70663          	beq	a4,a5,800038bc <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    800037d4:	fe843703          	ld	a4,-24(s0)
    800037d8:	00800793          	li	a5,8
    800037dc:	0ef70063          	beq	a4,a5,800038bc <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    800037e0:	fe843703          	ld	a4,-24(s0)
    800037e4:	fff00793          	li	a5,-1
    800037e8:	03f79793          	slli	a5,a5,0x3f
    800037ec:	00178793          	addi	a5,a5,1
    800037f0:	24f70263          	beq	a4,a5,80003a34 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    800037f4:	fe843703          	ld	a4,-24(s0)
    800037f8:	fff00793          	li	a5,-1
    800037fc:	03f79793          	slli	a5,a5,0x3f
    80003800:	00978793          	addi	a5,a5,9
    80003804:	2cf70063          	beq	a4,a5,80003ac4 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80003808:	fe843703          	ld	a4,-24(s0)
    8000380c:	00200793          	li	a5,2
    80003810:	34f70863          	beq	a4,a5,80003b60 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80003814:	00006517          	auipc	a0,0x6
    80003818:	8ec50513          	addi	a0,a0,-1812 # 80009100 <CONSOLE_STATUS+0xf0>
    8000381c:	00001097          	auipc	ra,0x1
    80003820:	848080e7          	jalr	-1976(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003824:	00006517          	auipc	a0,0x6
    80003828:	8ec50513          	addi	a0,a0,-1812 # 80009110 <CONSOLE_STATUS+0x100>
    8000382c:	00001097          	auipc	ra,0x1
    80003830:	838080e7          	jalr	-1992(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003834:	142027f3          	csrr	a5,scause
    80003838:	fef43023          	sd	a5,-32(s0)
    return scause;
    8000383c:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80003840:	00000613          	li	a2,0
    80003844:	00a00593          	li	a1,10
    80003848:	0005051b          	sext.w	a0,a0
    8000384c:	00001097          	auipc	ra,0x1
    80003850:	85c080e7          	jalr	-1956(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003854:	00006517          	auipc	a0,0x6
    80003858:	87c50513          	addi	a0,a0,-1924 # 800090d0 <CONSOLE_STATUS+0xc0>
    8000385c:	00001097          	auipc	ra,0x1
    80003860:	808080e7          	jalr	-2040(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003864:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003868:	00000613          	li	a2,0
    8000386c:	01000593          	li	a1,16
    80003870:	0005051b          	sext.w	a0,a0
    80003874:	00001097          	auipc	ra,0x1
    80003878:	834080e7          	jalr	-1996(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000387c:	00006517          	auipc	a0,0x6
    80003880:	84c50513          	addi	a0,a0,-1972 # 800090c8 <CONSOLE_STATUS+0xb8>
    80003884:	00000097          	auipc	ra,0x0
    80003888:	7e0080e7          	jalr	2016(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    8000388c:	00008797          	auipc	a5,0x8
    80003890:	03c7b783          	ld	a5,60(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003894:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003898:	00200713          	li	a4,2
    8000389c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    800038a0:	00006517          	auipc	a0,0x6
    800038a4:	88050513          	addi	a0,a0,-1920 # 80009120 <CONSOLE_STATUS+0x110>
    800038a8:	00000097          	auipc	ra,0x0
    800038ac:	7bc080e7          	jalr	1980(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800038b0:	fffff097          	auipc	ra,0xfffff
    800038b4:	8e4080e7          	jalr	-1820(ra) # 80002194 <_ZN3TCB8dispatchEv>
    800038b8:	0800006f          	j	80003938 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800038bc:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800038c0:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800038c4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800038c8:	00478793          	addi	a5,a5,4
    800038cc:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    800038d0:	00008797          	auipc	a5,0x8
    800038d4:	ff87b783          	ld	a5,-8(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800038d8:	0007b783          	ld	a5,0(a5)
    800038dc:	fb043703          	ld	a4,-80(s0)
    800038e0:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800038e4:	fa843703          	ld	a4,-88(s0)
    800038e8:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800038ec:	00050793          	mv	a5,a0
        switch(syscallID){
    800038f0:	06100713          	li	a4,97
    800038f4:	02f76463          	bltu	a4,a5,8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    800038f8:	00279793          	slli	a5,a5,0x2
    800038fc:	00006717          	auipc	a4,0x6
    80003900:	83870713          	addi	a4,a4,-1992 # 80009134 <CONSOLE_STATUS+0x124>
    80003904:	00e787b3          	add	a5,a5,a4
    80003908:	0007a783          	lw	a5,0(a5)
    8000390c:	00e787b3          	add	a5,a5,a4
    80003910:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003914:	fffff097          	auipc	ra,0xfffff
    80003918:	684080e7          	jalr	1668(ra) # 80002f98 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    8000391c:	00008797          	auipc	a5,0x8
    80003920:	fac7b783          	ld	a5,-84(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003924:	0007b783          	ld	a5,0(a5)
    80003928:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000392c:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003930:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003934:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003938:	fffff097          	auipc	ra,0xfffff
    8000393c:	530080e7          	jalr	1328(ra) # 80002e68 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003940:	05813083          	ld	ra,88(sp)
    80003944:	05013403          	ld	s0,80(sp)
    80003948:	06010113          	addi	sp,sp,96
    8000394c:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003950:	fffff097          	auipc	ra,0xfffff
    80003954:	680080e7          	jalr	1664(ra) # 80002fd0 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003958:	fc5ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    8000395c:	fffff097          	auipc	ra,0xfffff
    80003960:	6c4080e7          	jalr	1732(ra) # 80003020 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003964:	fb9ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80003968:	00000097          	auipc	ra,0x0
    8000396c:	8a4080e7          	jalr	-1884(ra) # 8000320c <_ZN5RiscV24executeThreadExitSyscallEv>
    80003970:	fadff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003974:	fffff097          	auipc	ra,0xfffff
    80003978:	3e0080e7          	jalr	992(ra) # 80002d54 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    8000397c:	fa1ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003980:	fffff097          	auipc	ra,0xfffff
    80003984:	770080e7          	jalr	1904(ra) # 800030f0 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003988:	f95ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    8000398c:	00000097          	auipc	ra,0x0
    80003990:	828080e7          	jalr	-2008(ra) # 800031b4 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003994:	f89ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80003998:	00000097          	auipc	ra,0x0
    8000399c:	8cc080e7          	jalr	-1844(ra) # 80003264 <_ZN5RiscV21executeSemOpenSyscallEv>
    800039a0:	f7dff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    800039a4:	00000097          	auipc	ra,0x0
    800039a8:	958080e7          	jalr	-1704(ra) # 800032fc <_ZN5RiscV22executeSemCloseSyscallEv>
    800039ac:	f71ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    800039b0:	00000097          	auipc	ra,0x0
    800039b4:	9ac080e7          	jalr	-1620(ra) # 8000335c <_ZN5RiscV21executeSemWaitSyscallEv>
    800039b8:	f65ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    800039bc:	00000097          	auipc	ra,0x0
    800039c0:	a00080e7          	jalr	-1536(ra) # 800033bc <_ZN5RiscV23executeSemSignalSyscallEv>
    800039c4:	f59ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    800039c8:	00000097          	auipc	ra,0x0
    800039cc:	a3c080e7          	jalr	-1476(ra) # 80003404 <_ZN5RiscV23executeTimeSleepSyscallEv>
    800039d0:	f4dff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    800039d4:	00000097          	auipc	ra,0x0
    800039d8:	aa8080e7          	jalr	-1368(ra) # 8000347c <_ZN5RiscV18executeGetcSyscallEv>
    800039dc:	f41ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    800039e0:	fffff097          	auipc	ra,0xfffff
    800039e4:	3b0080e7          	jalr	944(ra) # 80002d90 <_ZN5RiscV18executePutcSyscallEv>
    800039e8:	f35ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    800039ec:	00000097          	auipc	ra,0x0
    800039f0:	b28080e7          	jalr	-1240(ra) # 80003514 <_ZN5RiscV22executePutcUtilSyscallEv>
    800039f4:	f29ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    800039f8:	00000097          	auipc	ra,0x0
    800039fc:	b50080e7          	jalr	-1200(ra) # 80003548 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003a00:	f1dff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80003a04:	00000097          	auipc	ra,0x0
    80003a08:	bb8080e7          	jalr	-1096(ra) # 800035bc <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003a0c:	f11ff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003a10:	00010793          	mv	a5,sp
    80003a14:	00008717          	auipc	a4,0x8
    80003a18:	e6c73703          	ld	a4,-404(a4) # 8000b880 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003a1c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	d48080e7          	jalr	-696(ra) # 80003768 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003a28:	00000097          	auipc	ra,0x0
    80003a2c:	bf0080e7          	jalr	-1040(ra) # 80003618 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003a30:	eedff06f          	j	8000391c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003a34:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003a38:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003a3c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003a40:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003a44:	00200793          	li	a5,2
    80003a48:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003a4c:	00008717          	auipc	a4,0x8
    80003a50:	02470713          	addi	a4,a4,36 # 8000ba70 <_ZN5RiscV16userMainFinishedE>
    80003a54:	00873783          	ld	a5,8(a4)
    80003a58:	00178793          	addi	a5,a5,1
    80003a5c:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80003a60:	00000097          	auipc	ra,0x0
    80003a64:	254080e7          	jalr	596(ra) # 80003cb4 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003a68:	00008717          	auipc	a4,0x8
    80003a6c:	df873703          	ld	a4,-520(a4) # 8000b860 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003a70:	00073783          	ld	a5,0(a4)
    80003a74:	00178793          	addi	a5,a5,1
    80003a78:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003a7c:	00008717          	auipc	a4,0x8
    80003a80:	e4c73703          	ld	a4,-436(a4) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003a84:	00073703          	ld	a4,0(a4)
    80003a88:	03073683          	ld	a3,48(a4)
    80003a8c:	00d7fc63          	bgeu	a5,a3,80003aa4 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80003a90:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003a94:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003a98:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003a9c:	14179073          	csrw	sepc,a5
}
    80003aa0:	e99ff06f          	j	80003938 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80003aa4:	00008797          	auipc	a5,0x8
    80003aa8:	dbc7b783          	ld	a5,-580(a5) # 8000b860 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003aac:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003ab0:	00100793          	li	a5,1
    80003ab4:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003ab8:	ffffe097          	auipc	ra,0xffffe
    80003abc:	6dc080e7          	jalr	1756(ra) # 80002194 <_ZN3TCB8dispatchEv>
    80003ac0:	fd1ff06f          	j	80003a90 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003ac4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003ac8:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003acc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003ad0:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80003ad4:	00008797          	auipc	a5,0x8
    80003ad8:	d7c7b783          	ld	a5,-644(a5) # 8000b850 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003adc:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003ae0:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003ae4:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003ae8:	00058793          	mv	a5,a1
        if(status & 1UL)
    80003aec:	0017f793          	andi	a5,a5,1
    80003af0:	02078863          	beqz	a5,80003b20 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80003af4:	00008797          	auipc	a5,0x8
    80003af8:	d7c7b783          	ld	a5,-644(a5) # 8000b870 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003afc:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80003b00:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80003b04:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80003b08:	00058513          	mv	a0,a1
    80003b0c:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80003b10:	00008797          	auipc	a5,0x8
    80003b14:	d687b783          	ld	a5,-664(a5) # 8000b878 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003b18:	0007b783          	ld	a5,0(a5)
    80003b1c:	02079463          	bnez	a5,80003b44 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80003b20:	00003097          	auipc	ra,0x3
    80003b24:	d74080e7          	jalr	-652(ra) # 80006894 <plic_claim>
    80003b28:	00003097          	auipc	ra,0x3
    80003b2c:	da4080e7          	jalr	-604(ra) # 800068cc <plic_complete>
        RiscV::w_sstatus(sstatus);
    80003b30:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003b34:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003b38:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003b3c:	14179073          	csrw	sepc,a5
}
    80003b40:	df9ff06f          	j	80003938 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80003b44:	fff78793          	addi	a5,a5,-1
    80003b48:	00008717          	auipc	a4,0x8
    80003b4c:	d3073703          	ld	a4,-720(a4) # 8000b878 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003b50:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80003b54:	00000097          	auipc	ra,0x0
    80003b58:	338080e7          	jalr	824(ra) # 80003e8c <_ZN11ConsoleUtil8putInputEc>
    80003b5c:	fc5ff06f          	j	80003b20 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80003b60:	00008797          	auipc	a5,0x8
    80003b64:	d687b783          	ld	a5,-664(a5) # 8000b8c8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b68:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003b6c:	00200713          	li	a4,2
    80003b70:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80003b74:	00005517          	auipc	a0,0x5
    80003b78:	55c50513          	addi	a0,a0,1372 # 800090d0 <CONSOLE_STATUS+0xc0>
    80003b7c:	00000097          	auipc	ra,0x0
    80003b80:	4e8080e7          	jalr	1256(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003b84:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003b88:	00000613          	li	a2,0
    80003b8c:	01000593          	li	a1,16
    80003b90:	0005051b          	sext.w	a0,a0
    80003b94:	00000097          	auipc	ra,0x0
    80003b98:	514080e7          	jalr	1300(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003b9c:	00005517          	auipc	a0,0x5
    80003ba0:	52c50513          	addi	a0,a0,1324 # 800090c8 <CONSOLE_STATUS+0xb8>
    80003ba4:	00000097          	auipc	ra,0x0
    80003ba8:	4c0080e7          	jalr	1216(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003bac:	00005517          	auipc	a0,0x5
    80003bb0:	52c50513          	addi	a0,a0,1324 # 800090d8 <CONSOLE_STATUS+0xc8>
    80003bb4:	00000097          	auipc	ra,0x0
    80003bb8:	4b0080e7          	jalr	1200(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003bbc:	ffffe097          	auipc	ra,0xffffe
    80003bc0:	5d8080e7          	jalr	1496(ra) # 80002194 <_ZN3TCB8dispatchEv>
    80003bc4:	d75ff06f          	j	80003938 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

0000000080003bc8 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80003bc8:	ff010113          	addi	sp,sp,-16
    80003bcc:	00813423          	sd	s0,8(sp)
    80003bd0:	01010413          	addi	s0,sp,16
}
    80003bd4:	00813403          	ld	s0,8(sp)
    80003bd8:	01010113          	addi	sp,sp,16
    80003bdc:	00008067          	ret

0000000080003be0 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80003be0:	ff010113          	addi	sp,sp,-16
    80003be4:	00813423          	sd	s0,8(sp)
    80003be8:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80003bec:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80003bf0:	00008797          	auipc	a5,0x8
    80003bf4:	e907b783          	ld	a5,-368(a5) # 8000ba80 <_ZN9Scheduler9readyHeadE>
    80003bf8:	02078263          	beqz	a5,80003c1c <_ZN9Scheduler3putEP3TCB+0x3c>
    80003bfc:	00008797          	auipc	a5,0x8
    80003c00:	e8c7b783          	ld	a5,-372(a5) # 8000ba88 <_ZN9Scheduler9readyTailE>
    80003c04:	04a7b423          	sd	a0,72(a5)
    80003c08:	00008797          	auipc	a5,0x8
    80003c0c:	e8a7b023          	sd	a0,-384(a5) # 8000ba88 <_ZN9Scheduler9readyTailE>
}
    80003c10:	00813403          	ld	s0,8(sp)
    80003c14:	01010113          	addi	sp,sp,16
    80003c18:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80003c1c:	00008797          	auipc	a5,0x8
    80003c20:	e6a7b223          	sd	a0,-412(a5) # 8000ba80 <_ZN9Scheduler9readyHeadE>
    80003c24:	fe5ff06f          	j	80003c08 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080003c28 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80003c28:	ff010113          	addi	sp,sp,-16
    80003c2c:	00813423          	sd	s0,8(sp)
    80003c30:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80003c34:	00008517          	auipc	a0,0x8
    80003c38:	e4c53503          	ld	a0,-436(a0) # 8000ba80 <_ZN9Scheduler9readyHeadE>
    80003c3c:	00050a63          	beqz	a0,80003c50 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80003c40:	04853783          	ld	a5,72(a0)
    80003c44:	00008717          	auipc	a4,0x8
    80003c48:	e2f73e23          	sd	a5,-452(a4) # 8000ba80 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80003c4c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80003c50:	00813403          	ld	s0,8(sp)
    80003c54:	01010113          	addi	sp,sp,16
    80003c58:	00008067          	ret

0000000080003c5c <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80003c5c:	ff010113          	addi	sp,sp,-16
    80003c60:	00813423          	sd	s0,8(sp)
    80003c64:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80003c68:	00008797          	auipc	a5,0x8
    80003c6c:	e287b783          	ld	a5,-472(a5) # 8000ba90 <_ZN9Scheduler12sleepingHeadE>
    80003c70:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80003c74:	00078e63          	beqz	a5,80003c90 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80003c78:	0587b683          	ld	a3,88(a5)
    80003c7c:	05853703          	ld	a4,88(a0)
    80003c80:	00d76863          	bltu	a4,a3,80003c90 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80003c84:	00078613          	mv	a2,a5
    80003c88:	0487b783          	ld	a5,72(a5)
    80003c8c:	fe9ff06f          	j	80003c74 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80003c90:	04f53423          	sd	a5,72(a0)
    if(prev)
    80003c94:	00060a63          	beqz	a2,80003ca8 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80003c98:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80003c9c:	00813403          	ld	s0,8(sp)
    80003ca0:	01010113          	addi	sp,sp,16
    80003ca4:	00008067          	ret
        sleepingHead = t;
    80003ca8:	00008797          	auipc	a5,0x8
    80003cac:	dea7b423          	sd	a0,-536(a5) # 8000ba90 <_ZN9Scheduler12sleepingHeadE>
}
    80003cb0:	fedff06f          	j	80003c9c <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080003cb4 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80003cb4:	fe010113          	addi	sp,sp,-32
    80003cb8:	00113c23          	sd	ra,24(sp)
    80003cbc:	00813823          	sd	s0,16(sp)
    80003cc0:	00913423          	sd	s1,8(sp)
    80003cc4:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80003cc8:	00008497          	auipc	s1,0x8
    80003ccc:	dc84b483          	ld	s1,-568(s1) # 8000ba90 <_ZN9Scheduler12sleepingHeadE>
    80003cd0:	02048c63          	beqz	s1,80003d08 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80003cd4:	0584b703          	ld	a4,88(s1)
    80003cd8:	00008797          	auipc	a5,0x8
    80003cdc:	c087b783          	ld	a5,-1016(a5) # 8000b8e0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80003ce0:	0007b783          	ld	a5,0(a5)
    80003ce4:	02e7e263          	bltu	a5,a4,80003d08 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80003ce8:	0484b783          	ld	a5,72(s1)
    80003cec:	00008717          	auipc	a4,0x8
    80003cf0:	daf73223          	sd	a5,-604(a4) # 8000ba90 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80003cf4:	00048513          	mv	a0,s1
    80003cf8:	00000097          	auipc	ra,0x0
    80003cfc:	ee8080e7          	jalr	-280(ra) # 80003be0 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80003d00:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80003d04:	fc5ff06f          	j	80003cc8 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80003d08:	01813083          	ld	ra,24(sp)
    80003d0c:	01013403          	ld	s0,16(sp)
    80003d10:	00813483          	ld	s1,8(sp)
    80003d14:	02010113          	addi	sp,sp,32
    80003d18:	00008067          	ret

0000000080003d1c <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80003d1c:	fe010113          	addi	sp,sp,-32
    80003d20:	00113c23          	sd	ra,24(sp)
    80003d24:	00813823          	sd	s0,16(sp)
    80003d28:	00913423          	sd	s1,8(sp)
    80003d2c:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80003d30:	00008497          	auipc	s1,0x8
    80003d34:	d504b483          	ld	s1,-688(s1) # 8000ba80 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80003d38:	02048863          	beqz	s1,80003d68 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80003d3c:	00000613          	li	a2,0
    80003d40:	01000593          	li	a1,16
    80003d44:	0004851b          	sext.w	a0,s1
    80003d48:	00000097          	auipc	ra,0x0
    80003d4c:	360080e7          	jalr	864(ra) # 800040a8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003d50:	00005517          	auipc	a0,0x5
    80003d54:	37850513          	addi	a0,a0,888 # 800090c8 <CONSOLE_STATUS+0xb8>
    80003d58:	00000097          	auipc	ra,0x0
    80003d5c:	30c080e7          	jalr	780(ra) # 80004064 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80003d60:	0484b483          	ld	s1,72(s1)
    while(iter){
    80003d64:	fd5ff06f          	j	80003d38 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80003d68:	01813083          	ld	ra,24(sp)
    80003d6c:	01013403          	ld	s0,16(sp)
    80003d70:	00813483          	ld	s1,8(sp)
    80003d74:	02010113          	addi	sp,sp,32
    80003d78:	00008067          	ret

0000000080003d7c <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80003d7c:	fe010113          	addi	sp,sp,-32
    80003d80:	00113c23          	sd	ra,24(sp)
    80003d84:	00813823          	sd	s0,16(sp)
    80003d88:	00913423          	sd	s1,8(sp)
    80003d8c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80003d90:	00008497          	auipc	s1,0x8
    80003d94:	d004b483          	ld	s1,-768(s1) # 8000ba90 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80003d98:	02048863          	beqz	s1,80003dc8 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80003d9c:	00000613          	li	a2,0
    80003da0:	01000593          	li	a1,16
    80003da4:	0004851b          	sext.w	a0,s1
    80003da8:	ffffe097          	auipc	ra,0xffffe
    80003dac:	f60080e7          	jalr	-160(ra) # 80001d08 <_Z8printIntiii>
        printString("\n");
    80003db0:	00005517          	auipc	a0,0x5
    80003db4:	31850513          	addi	a0,a0,792 # 800090c8 <CONSOLE_STATUS+0xb8>
    80003db8:	ffffe097          	auipc	ra,0xffffe
    80003dbc:	db8080e7          	jalr	-584(ra) # 80001b70 <_Z11printStringPKc>
        iter = iter->next;
    80003dc0:	0484b483          	ld	s1,72(s1)
    while(iter){
    80003dc4:	fd5ff06f          	j	80003d98 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80003dc8:	01813083          	ld	ra,24(sp)
    80003dcc:	01013403          	ld	s0,16(sp)
    80003dd0:	00813483          	ld	s1,8(sp)
    80003dd4:	02010113          	addi	sp,sp,32
    80003dd8:	00008067          	ret

0000000080003ddc <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    80003ddc:	fe010113          	addi	sp,sp,-32
    80003de0:	00113c23          	sd	ra,24(sp)
    80003de4:	00813823          	sd	s0,16(sp)
    80003de8:	00913423          	sd	s1,8(sp)
    80003dec:	01213023          	sd	s2,0(sp)
    80003df0:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80003df4:	01800513          	li	a0,24
    80003df8:	ffffe097          	auipc	ra,0xffffe
    80003dfc:	1e0080e7          	jalr	480(ra) # 80001fd8 <_ZN3SCBnwEm>
    80003e00:	00050493          	mv	s1,a0
    80003e04:	00000593          	li	a1,0
    80003e08:	ffffe097          	auipc	ra,0xffffe
    80003e0c:	014080e7          	jalr	20(ra) # 80001e1c <_ZN3SCBC1Em>
    80003e10:	00008797          	auipc	a5,0x8
    80003e14:	c897b423          	sd	s1,-888(a5) # 8000ba98 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80003e18:	01800513          	li	a0,24
    80003e1c:	ffffe097          	auipc	ra,0xffffe
    80003e20:	1bc080e7          	jalr	444(ra) # 80001fd8 <_ZN3SCBnwEm>
    80003e24:	00050493          	mv	s1,a0
    80003e28:	00000593          	li	a1,0
    80003e2c:	ffffe097          	auipc	ra,0xffffe
    80003e30:	ff0080e7          	jalr	-16(ra) # 80001e1c <_ZN3SCBC1Em>
    80003e34:	00008797          	auipc	a5,0x8
    80003e38:	c697b623          	sd	s1,-916(a5) # 8000baa0 <_ZN11ConsoleUtil9outputSemE>
}
    80003e3c:	01813083          	ld	ra,24(sp)
    80003e40:	01013403          	ld	s0,16(sp)
    80003e44:	00813483          	ld	s1,8(sp)
    80003e48:	00013903          	ld	s2,0(sp)
    80003e4c:	02010113          	addi	sp,sp,32
    80003e50:	00008067          	ret
    80003e54:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80003e58:	00048513          	mv	a0,s1
    80003e5c:	ffffe097          	auipc	ra,0xffffe
    80003e60:	1a4080e7          	jalr	420(ra) # 80002000 <_ZN3SCBdlEPv>
    80003e64:	00090513          	mv	a0,s2
    80003e68:	0000d097          	auipc	ra,0xd
    80003e6c:	d60080e7          	jalr	-672(ra) # 80010bc8 <_Unwind_Resume>
    80003e70:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80003e74:	00048513          	mv	a0,s1
    80003e78:	ffffe097          	auipc	ra,0xffffe
    80003e7c:	188080e7          	jalr	392(ra) # 80002000 <_ZN3SCBdlEPv>
    80003e80:	00090513          	mv	a0,s2
    80003e84:	0000d097          	auipc	ra,0xd
    80003e88:	d44080e7          	jalr	-700(ra) # 80010bc8 <_Unwind_Resume>

0000000080003e8c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80003e8c:	00008697          	auipc	a3,0x8
    80003e90:	c0c68693          	addi	a3,a3,-1012 # 8000ba98 <_ZN11ConsoleUtil8inputSemE>
    80003e94:	0106b603          	ld	a2,16(a3)
    80003e98:	00160793          	addi	a5,a2,1
    80003e9c:	00002737          	lui	a4,0x2
    80003ea0:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80003ea4:	00e7f7b3          	and	a5,a5,a4
    80003ea8:	0186b703          	ld	a4,24(a3)
    80003eac:	04e78263          	beq	a5,a4,80003ef0 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80003eb0:	ff010113          	addi	sp,sp,-16
    80003eb4:	00113423          	sd	ra,8(sp)
    80003eb8:	00813023          	sd	s0,0(sp)
    80003ebc:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80003ec0:	0000a717          	auipc	a4,0xa
    80003ec4:	c1070713          	addi	a4,a4,-1008 # 8000dad0 <_ZN11ConsoleUtil11inputBufferE>
    80003ec8:	00c70633          	add	a2,a4,a2
    80003ecc:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80003ed0:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    80003ed4:	0006b503          	ld	a0,0(a3)
    80003ed8:	ffffe097          	auipc	ra,0xffffe
    80003edc:	0c4080e7          	jalr	196(ra) # 80001f9c <_ZN3SCB6signalEv>
}
    80003ee0:	00813083          	ld	ra,8(sp)
    80003ee4:	00013403          	ld	s0,0(sp)
    80003ee8:	01010113          	addi	sp,sp,16
    80003eec:	00008067          	ret
    80003ef0:	00008067          	ret

0000000080003ef4 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80003ef4:	fe010113          	addi	sp,sp,-32
    80003ef8:	00113c23          	sd	ra,24(sp)
    80003efc:	00813823          	sd	s0,16(sp)
    80003f00:	00913423          	sd	s1,8(sp)
    80003f04:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80003f08:	00008497          	auipc	s1,0x8
    80003f0c:	b9048493          	addi	s1,s1,-1136 # 8000ba98 <_ZN11ConsoleUtil8inputSemE>
    80003f10:	0004b503          	ld	a0,0(s1)
    80003f14:	ffffe097          	auipc	ra,0xffffe
    80003f18:	038080e7          	jalr	56(ra) # 80001f4c <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80003f1c:	0184b783          	ld	a5,24(s1)
    80003f20:	0104b703          	ld	a4,16(s1)
    80003f24:	04e78063          	beq	a5,a4,80003f64 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80003f28:	0000a717          	auipc	a4,0xa
    80003f2c:	ba870713          	addi	a4,a4,-1112 # 8000dad0 <_ZN11ConsoleUtil11inputBufferE>
    80003f30:	00f70733          	add	a4,a4,a5
    80003f34:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80003f38:	00178793          	addi	a5,a5,1
    80003f3c:	00002737          	lui	a4,0x2
    80003f40:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80003f44:	00e7f7b3          	and	a5,a5,a4
    80003f48:	00008717          	auipc	a4,0x8
    80003f4c:	b6f73423          	sd	a5,-1176(a4) # 8000bab0 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80003f50:	01813083          	ld	ra,24(sp)
    80003f54:	01013403          	ld	s0,16(sp)
    80003f58:	00813483          	ld	s1,8(sp)
    80003f5c:	02010113          	addi	sp,sp,32
    80003f60:	00008067          	ret
        return -1;
    80003f64:	0ff00513          	li	a0,255
    80003f68:	fe9ff06f          	j	80003f50 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080003f6c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80003f6c:	00008797          	auipc	a5,0x8
    80003f70:	b2c78793          	addi	a5,a5,-1236 # 8000ba98 <_ZN11ConsoleUtil8inputSemE>
    80003f74:	0207b603          	ld	a2,32(a5)
    80003f78:	00160713          	addi	a4,a2,1
    80003f7c:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80003f80:	0287b583          	ld	a1,40(a5)
    80003f84:	00158713          	addi	a4,a1,1
    80003f88:	000026b7          	lui	a3,0x2
    80003f8c:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80003f90:	00d77733          	and	a4,a4,a3
    80003f94:	0307b783          	ld	a5,48(a5)
    80003f98:	04f70863          	beq	a4,a5,80003fe8 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80003f9c:	ff010113          	addi	sp,sp,-16
    80003fa0:	00113423          	sd	ra,8(sp)
    80003fa4:	00813023          	sd	s0,0(sp)
    80003fa8:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80003fac:	00008797          	auipc	a5,0x8
    80003fb0:	b2478793          	addi	a5,a5,-1244 # 8000bad0 <_ZN11ConsoleUtil12outputBufferE>
    80003fb4:	00b785b3          	add	a1,a5,a1
    80003fb8:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    80003fbc:	00008797          	auipc	a5,0x8
    80003fc0:	adc78793          	addi	a5,a5,-1316 # 8000ba98 <_ZN11ConsoleUtil8inputSemE>
    80003fc4:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80003fc8:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    80003fcc:	0087b503          	ld	a0,8(a5)
    80003fd0:	ffffe097          	auipc	ra,0xffffe
    80003fd4:	fcc080e7          	jalr	-52(ra) # 80001f9c <_ZN3SCB6signalEv>
}
    80003fd8:	00813083          	ld	ra,8(sp)
    80003fdc:	00013403          	ld	s0,0(sp)
    80003fe0:	01010113          	addi	sp,sp,16
    80003fe4:	00008067          	ret
    80003fe8:	00008067          	ret

0000000080003fec <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80003fec:	fe010113          	addi	sp,sp,-32
    80003ff0:	00113c23          	sd	ra,24(sp)
    80003ff4:	00813823          	sd	s0,16(sp)
    80003ff8:	00913423          	sd	s1,8(sp)
    80003ffc:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004000:	00008497          	auipc	s1,0x8
    80004004:	a9848493          	addi	s1,s1,-1384 # 8000ba98 <_ZN11ConsoleUtil8inputSemE>
    80004008:	0084b503          	ld	a0,8(s1)
    8000400c:	ffffe097          	auipc	ra,0xffffe
    80004010:	f40080e7          	jalr	-192(ra) # 80001f4c <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004014:	0304b783          	ld	a5,48(s1)
    80004018:	0284b703          	ld	a4,40(s1)
    8000401c:	04e78063          	beq	a5,a4,8000405c <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004020:	00008717          	auipc	a4,0x8
    80004024:	ab070713          	addi	a4,a4,-1360 # 8000bad0 <_ZN11ConsoleUtil12outputBufferE>
    80004028:	00f70733          	add	a4,a4,a5
    8000402c:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004030:	00178793          	addi	a5,a5,1
    80004034:	00002737          	lui	a4,0x2
    80004038:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    8000403c:	00e7f7b3          	and	a5,a5,a4
    80004040:	00008717          	auipc	a4,0x8
    80004044:	a8f73423          	sd	a5,-1400(a4) # 8000bac8 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004048:	01813083          	ld	ra,24(sp)
    8000404c:	01013403          	ld	s0,16(sp)
    80004050:	00813483          	ld	s1,8(sp)
    80004054:	02010113          	addi	sp,sp,32
    80004058:	00008067          	ret
        return -1;
    8000405c:	0ff00513          	li	a0,255
    80004060:	fe9ff06f          	j	80004048 <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004064 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004064:	fe010113          	addi	sp,sp,-32
    80004068:	00113c23          	sd	ra,24(sp)
    8000406c:	00813823          	sd	s0,16(sp)
    80004070:	00913423          	sd	s1,8(sp)
    80004074:	02010413          	addi	s0,sp,32
    80004078:	00050493          	mv	s1,a0
    while (*string != '\0')
    8000407c:	0004c503          	lbu	a0,0(s1)
    80004080:	00050a63          	beqz	a0,80004094 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004084:	00000097          	auipc	ra,0x0
    80004088:	ee8080e7          	jalr	-280(ra) # 80003f6c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    8000408c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004090:	fedff06f          	j	8000407c <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004094:	01813083          	ld	ra,24(sp)
    80004098:	01013403          	ld	s0,16(sp)
    8000409c:	00813483          	ld	s1,8(sp)
    800040a0:	02010113          	addi	sp,sp,32
    800040a4:	00008067          	ret

00000000800040a8 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800040a8:	fb010113          	addi	sp,sp,-80
    800040ac:	04113423          	sd	ra,72(sp)
    800040b0:	04813023          	sd	s0,64(sp)
    800040b4:	02913c23          	sd	s1,56(sp)
    800040b8:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800040bc:	00005797          	auipc	a5,0x5
    800040c0:	20478793          	addi	a5,a5,516 # 800092c0 <CONSOLE_STATUS+0x2b0>
    800040c4:	0007b703          	ld	a4,0(a5)
    800040c8:	fce43423          	sd	a4,-56(s0)
    800040cc:	0087b703          	ld	a4,8(a5)
    800040d0:	fce43823          	sd	a4,-48(s0)
    800040d4:	0107c783          	lbu	a5,16(a5)
    800040d8:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800040dc:	00060463          	beqz	a2,800040e4 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    800040e0:	08054263          	bltz	a0,80004164 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800040e4:	0005051b          	sext.w	a0,a0
    neg = 0;
    800040e8:	00000813          	li	a6,0
    }

    i = 0;
    800040ec:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800040f0:	0005871b          	sext.w	a4,a1
    800040f4:	02b577bb          	remuw	a5,a0,a1
    800040f8:	00048693          	mv	a3,s1
    800040fc:	0014849b          	addiw	s1,s1,1
    80004100:	02079793          	slli	a5,a5,0x20
    80004104:	0207d793          	srli	a5,a5,0x20
    80004108:	fe040613          	addi	a2,s0,-32
    8000410c:	00f607b3          	add	a5,a2,a5
    80004110:	fe87c603          	lbu	a2,-24(a5)
    80004114:	fe040793          	addi	a5,s0,-32
    80004118:	00d787b3          	add	a5,a5,a3
    8000411c:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004120:	0005061b          	sext.w	a2,a0
    80004124:	02b5553b          	divuw	a0,a0,a1
    80004128:	fce674e3          	bgeu	a2,a4,800040f0 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    8000412c:	00080c63          	beqz	a6,80004144 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004130:	fe040793          	addi	a5,s0,-32
    80004134:	009784b3          	add	s1,a5,s1
    80004138:	02d00793          	li	a5,45
    8000413c:	fcf48c23          	sb	a5,-40(s1)
    80004140:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004144:	fff4849b          	addiw	s1,s1,-1
    80004148:	0204c463          	bltz	s1,80004170 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    8000414c:	fe040793          	addi	a5,s0,-32
    80004150:	009787b3          	add	a5,a5,s1
    80004154:	fd87c503          	lbu	a0,-40(a5)
    80004158:	00000097          	auipc	ra,0x0
    8000415c:	e14080e7          	jalr	-492(ra) # 80003f6c <_ZN11ConsoleUtil9putOutputEc>
    80004160:	fe5ff06f          	j	80004144 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004164:	40a0053b          	negw	a0,a0
        neg = 1;
    80004168:	00100813          	li	a6,1
        x = -xx;
    8000416c:	f81ff06f          	j	800040ec <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004170:	04813083          	ld	ra,72(sp)
    80004174:	04013403          	ld	s0,64(sp)
    80004178:	03813483          	ld	s1,56(sp)
    8000417c:	05010113          	addi	sp,sp,80
    80004180:	00008067          	ret

0000000080004184 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004184:	ff010113          	addi	sp,sp,-16
    80004188:	00813423          	sd	s0,8(sp)
    8000418c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004190:	04300513          	li	a0,67

    asm("ecall");
    80004194:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004198:	00050513          	mv	a0,a0

    return (char)status;
}
    8000419c:	0ff57513          	andi	a0,a0,255
    800041a0:	00813403          	ld	s0,8(sp)
    800041a4:	01010113          	addi	sp,sp,16
    800041a8:	00008067          	ret

00000000800041ac <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800041ac:	fd010113          	addi	sp,sp,-48
    800041b0:	02113423          	sd	ra,40(sp)
    800041b4:	02813023          	sd	s0,32(sp)
    800041b8:	00913c23          	sd	s1,24(sp)
    800041bc:	01213823          	sd	s2,16(sp)
    800041c0:	01313423          	sd	s3,8(sp)
    800041c4:	03010413          	addi	s0,sp,48
    800041c8:	00050493          	mv	s1,a0
    800041cc:	00058913          	mv	s2,a1
    800041d0:	0015879b          	addiw	a5,a1,1
    800041d4:	0007851b          	sext.w	a0,a5
    800041d8:	00f4a023          	sw	a5,0(s1)
    800041dc:	0004a823          	sw	zero,16(s1)
    800041e0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800041e4:	00251513          	slli	a0,a0,0x2
    800041e8:	ffffd097          	auipc	ra,0xffffd
    800041ec:	f6c080e7          	jalr	-148(ra) # 80001154 <_Z9mem_allocm>
    800041f0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800041f4:	01000513          	li	a0,16
    800041f8:	ffffe097          	auipc	ra,0xffffe
    800041fc:	6a4080e7          	jalr	1700(ra) # 8000289c <_Znwm>
    80004200:	00050993          	mv	s3,a0
    80004204:	00000593          	li	a1,0
    80004208:	ffffe097          	auipc	ra,0xffffe
    8000420c:	78c080e7          	jalr	1932(ra) # 80002994 <_ZN9SemaphoreC1Ej>
    80004210:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004214:	01000513          	li	a0,16
    80004218:	ffffe097          	auipc	ra,0xffffe
    8000421c:	684080e7          	jalr	1668(ra) # 8000289c <_Znwm>
    80004220:	00050993          	mv	s3,a0
    80004224:	00090593          	mv	a1,s2
    80004228:	ffffe097          	auipc	ra,0xffffe
    8000422c:	76c080e7          	jalr	1900(ra) # 80002994 <_ZN9SemaphoreC1Ej>
    80004230:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004234:	01000513          	li	a0,16
    80004238:	ffffe097          	auipc	ra,0xffffe
    8000423c:	664080e7          	jalr	1636(ra) # 8000289c <_Znwm>
    80004240:	00050913          	mv	s2,a0
    80004244:	00100593          	li	a1,1
    80004248:	ffffe097          	auipc	ra,0xffffe
    8000424c:	74c080e7          	jalr	1868(ra) # 80002994 <_ZN9SemaphoreC1Ej>
    80004250:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004254:	01000513          	li	a0,16
    80004258:	ffffe097          	auipc	ra,0xffffe
    8000425c:	644080e7          	jalr	1604(ra) # 8000289c <_Znwm>
    80004260:	00050913          	mv	s2,a0
    80004264:	00100593          	li	a1,1
    80004268:	ffffe097          	auipc	ra,0xffffe
    8000426c:	72c080e7          	jalr	1836(ra) # 80002994 <_ZN9SemaphoreC1Ej>
    80004270:	0324b823          	sd	s2,48(s1)
}
    80004274:	02813083          	ld	ra,40(sp)
    80004278:	02013403          	ld	s0,32(sp)
    8000427c:	01813483          	ld	s1,24(sp)
    80004280:	01013903          	ld	s2,16(sp)
    80004284:	00813983          	ld	s3,8(sp)
    80004288:	03010113          	addi	sp,sp,48
    8000428c:	00008067          	ret
    80004290:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004294:	00098513          	mv	a0,s3
    80004298:	ffffe097          	auipc	ra,0xffffe
    8000429c:	654080e7          	jalr	1620(ra) # 800028ec <_ZdlPv>
    800042a0:	00048513          	mv	a0,s1
    800042a4:	0000d097          	auipc	ra,0xd
    800042a8:	924080e7          	jalr	-1756(ra) # 80010bc8 <_Unwind_Resume>
    800042ac:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800042b0:	00098513          	mv	a0,s3
    800042b4:	ffffe097          	auipc	ra,0xffffe
    800042b8:	638080e7          	jalr	1592(ra) # 800028ec <_ZdlPv>
    800042bc:	00048513          	mv	a0,s1
    800042c0:	0000d097          	auipc	ra,0xd
    800042c4:	908080e7          	jalr	-1784(ra) # 80010bc8 <_Unwind_Resume>
    800042c8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800042cc:	00090513          	mv	a0,s2
    800042d0:	ffffe097          	auipc	ra,0xffffe
    800042d4:	61c080e7          	jalr	1564(ra) # 800028ec <_ZdlPv>
    800042d8:	00048513          	mv	a0,s1
    800042dc:	0000d097          	auipc	ra,0xd
    800042e0:	8ec080e7          	jalr	-1812(ra) # 80010bc8 <_Unwind_Resume>
    800042e4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800042e8:	00090513          	mv	a0,s2
    800042ec:	ffffe097          	auipc	ra,0xffffe
    800042f0:	600080e7          	jalr	1536(ra) # 800028ec <_ZdlPv>
    800042f4:	00048513          	mv	a0,s1
    800042f8:	0000d097          	auipc	ra,0xd
    800042fc:	8d0080e7          	jalr	-1840(ra) # 80010bc8 <_Unwind_Resume>

0000000080004300 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004300:	fe010113          	addi	sp,sp,-32
    80004304:	00113c23          	sd	ra,24(sp)
    80004308:	00813823          	sd	s0,16(sp)
    8000430c:	00913423          	sd	s1,8(sp)
    80004310:	01213023          	sd	s2,0(sp)
    80004314:	02010413          	addi	s0,sp,32
    80004318:	00050493          	mv	s1,a0
    8000431c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004320:	01853503          	ld	a0,24(a0)
    80004324:	ffffe097          	auipc	ra,0xffffe
    80004328:	6a8080e7          	jalr	1704(ra) # 800029cc <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000432c:	0304b503          	ld	a0,48(s1)
    80004330:	ffffe097          	auipc	ra,0xffffe
    80004334:	69c080e7          	jalr	1692(ra) # 800029cc <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004338:	0084b783          	ld	a5,8(s1)
    8000433c:	0144a703          	lw	a4,20(s1)
    80004340:	00271713          	slli	a4,a4,0x2
    80004344:	00e787b3          	add	a5,a5,a4
    80004348:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000434c:	0144a783          	lw	a5,20(s1)
    80004350:	0017879b          	addiw	a5,a5,1
    80004354:	0004a703          	lw	a4,0(s1)
    80004358:	02e7e7bb          	remw	a5,a5,a4
    8000435c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004360:	0304b503          	ld	a0,48(s1)
    80004364:	ffffe097          	auipc	ra,0xffffe
    80004368:	694080e7          	jalr	1684(ra) # 800029f8 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000436c:	0204b503          	ld	a0,32(s1)
    80004370:	ffffe097          	auipc	ra,0xffffe
    80004374:	688080e7          	jalr	1672(ra) # 800029f8 <_ZN9Semaphore6signalEv>

}
    80004378:	01813083          	ld	ra,24(sp)
    8000437c:	01013403          	ld	s0,16(sp)
    80004380:	00813483          	ld	s1,8(sp)
    80004384:	00013903          	ld	s2,0(sp)
    80004388:	02010113          	addi	sp,sp,32
    8000438c:	00008067          	ret

0000000080004390 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004390:	fe010113          	addi	sp,sp,-32
    80004394:	00113c23          	sd	ra,24(sp)
    80004398:	00813823          	sd	s0,16(sp)
    8000439c:	00913423          	sd	s1,8(sp)
    800043a0:	01213023          	sd	s2,0(sp)
    800043a4:	02010413          	addi	s0,sp,32
    800043a8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800043ac:	02053503          	ld	a0,32(a0)
    800043b0:	ffffe097          	auipc	ra,0xffffe
    800043b4:	61c080e7          	jalr	1564(ra) # 800029cc <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800043b8:	0284b503          	ld	a0,40(s1)
    800043bc:	ffffe097          	auipc	ra,0xffffe
    800043c0:	610080e7          	jalr	1552(ra) # 800029cc <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800043c4:	0084b703          	ld	a4,8(s1)
    800043c8:	0104a783          	lw	a5,16(s1)
    800043cc:	00279693          	slli	a3,a5,0x2
    800043d0:	00d70733          	add	a4,a4,a3
    800043d4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800043d8:	0017879b          	addiw	a5,a5,1
    800043dc:	0004a703          	lw	a4,0(s1)
    800043e0:	02e7e7bb          	remw	a5,a5,a4
    800043e4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800043e8:	0284b503          	ld	a0,40(s1)
    800043ec:	ffffe097          	auipc	ra,0xffffe
    800043f0:	60c080e7          	jalr	1548(ra) # 800029f8 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800043f4:	0184b503          	ld	a0,24(s1)
    800043f8:	ffffe097          	auipc	ra,0xffffe
    800043fc:	600080e7          	jalr	1536(ra) # 800029f8 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004400:	00090513          	mv	a0,s2
    80004404:	01813083          	ld	ra,24(sp)
    80004408:	01013403          	ld	s0,16(sp)
    8000440c:	00813483          	ld	s1,8(sp)
    80004410:	00013903          	ld	s2,0(sp)
    80004414:	02010113          	addi	sp,sp,32
    80004418:	00008067          	ret

000000008000441c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000441c:	fe010113          	addi	sp,sp,-32
    80004420:	00113c23          	sd	ra,24(sp)
    80004424:	00813823          	sd	s0,16(sp)
    80004428:	00913423          	sd	s1,8(sp)
    8000442c:	01213023          	sd	s2,0(sp)
    80004430:	02010413          	addi	s0,sp,32
    80004434:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004438:	02853503          	ld	a0,40(a0)
    8000443c:	ffffe097          	auipc	ra,0xffffe
    80004440:	590080e7          	jalr	1424(ra) # 800029cc <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004444:	0304b503          	ld	a0,48(s1)
    80004448:	ffffe097          	auipc	ra,0xffffe
    8000444c:	584080e7          	jalr	1412(ra) # 800029cc <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004450:	0144a783          	lw	a5,20(s1)
    80004454:	0104a903          	lw	s2,16(s1)
    80004458:	0327ce63          	blt	a5,s2,80004494 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000445c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004460:	0304b503          	ld	a0,48(s1)
    80004464:	ffffe097          	auipc	ra,0xffffe
    80004468:	594080e7          	jalr	1428(ra) # 800029f8 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000446c:	0284b503          	ld	a0,40(s1)
    80004470:	ffffe097          	auipc	ra,0xffffe
    80004474:	588080e7          	jalr	1416(ra) # 800029f8 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004478:	00090513          	mv	a0,s2
    8000447c:	01813083          	ld	ra,24(sp)
    80004480:	01013403          	ld	s0,16(sp)
    80004484:	00813483          	ld	s1,8(sp)
    80004488:	00013903          	ld	s2,0(sp)
    8000448c:	02010113          	addi	sp,sp,32
    80004490:	00008067          	ret
        ret = cap - head + tail;
    80004494:	0004a703          	lw	a4,0(s1)
    80004498:	4127093b          	subw	s2,a4,s2
    8000449c:	00f9093b          	addw	s2,s2,a5
    800044a0:	fc1ff06f          	j	80004460 <_ZN9BufferCPP6getCntEv+0x44>

00000000800044a4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800044a4:	fe010113          	addi	sp,sp,-32
    800044a8:	00113c23          	sd	ra,24(sp)
    800044ac:	00813823          	sd	s0,16(sp)
    800044b0:	00913423          	sd	s1,8(sp)
    800044b4:	02010413          	addi	s0,sp,32
    800044b8:	00050493          	mv	s1,a0
    Console::putc('\n');
    800044bc:	00a00513          	li	a0,10
    800044c0:	ffffe097          	auipc	ra,0xffffe
    800044c4:	734080e7          	jalr	1844(ra) # 80002bf4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800044c8:	00005517          	auipc	a0,0x5
    800044cc:	e1050513          	addi	a0,a0,-496 # 800092d8 <CONSOLE_STATUS+0x2c8>
    800044d0:	ffffd097          	auipc	ra,0xffffd
    800044d4:	6a0080e7          	jalr	1696(ra) # 80001b70 <_Z11printStringPKc>
    while (getCnt()) {
    800044d8:	00048513          	mv	a0,s1
    800044dc:	00000097          	auipc	ra,0x0
    800044e0:	f40080e7          	jalr	-192(ra) # 8000441c <_ZN9BufferCPP6getCntEv>
    800044e4:	02050c63          	beqz	a0,8000451c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800044e8:	0084b783          	ld	a5,8(s1)
    800044ec:	0104a703          	lw	a4,16(s1)
    800044f0:	00271713          	slli	a4,a4,0x2
    800044f4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800044f8:	0007c503          	lbu	a0,0(a5)
    800044fc:	ffffe097          	auipc	ra,0xffffe
    80004500:	6f8080e7          	jalr	1784(ra) # 80002bf4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004504:	0104a783          	lw	a5,16(s1)
    80004508:	0017879b          	addiw	a5,a5,1
    8000450c:	0004a703          	lw	a4,0(s1)
    80004510:	02e7e7bb          	remw	a5,a5,a4
    80004514:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004518:	fc1ff06f          	j	800044d8 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000451c:	02100513          	li	a0,33
    80004520:	ffffe097          	auipc	ra,0xffffe
    80004524:	6d4080e7          	jalr	1748(ra) # 80002bf4 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004528:	00a00513          	li	a0,10
    8000452c:	ffffe097          	auipc	ra,0xffffe
    80004530:	6c8080e7          	jalr	1736(ra) # 80002bf4 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004534:	0084b503          	ld	a0,8(s1)
    80004538:	ffffd097          	auipc	ra,0xffffd
    8000453c:	c4c080e7          	jalr	-948(ra) # 80001184 <_Z8mem_freePv>
    delete itemAvailable;
    80004540:	0204b503          	ld	a0,32(s1)
    80004544:	00050863          	beqz	a0,80004554 <_ZN9BufferCPPD1Ev+0xb0>
    80004548:	00053783          	ld	a5,0(a0)
    8000454c:	0087b783          	ld	a5,8(a5)
    80004550:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004554:	0184b503          	ld	a0,24(s1)
    80004558:	00050863          	beqz	a0,80004568 <_ZN9BufferCPPD1Ev+0xc4>
    8000455c:	00053783          	ld	a5,0(a0)
    80004560:	0087b783          	ld	a5,8(a5)
    80004564:	000780e7          	jalr	a5
    delete mutexTail;
    80004568:	0304b503          	ld	a0,48(s1)
    8000456c:	00050863          	beqz	a0,8000457c <_ZN9BufferCPPD1Ev+0xd8>
    80004570:	00053783          	ld	a5,0(a0)
    80004574:	0087b783          	ld	a5,8(a5)
    80004578:	000780e7          	jalr	a5
    delete mutexHead;
    8000457c:	0284b503          	ld	a0,40(s1)
    80004580:	00050863          	beqz	a0,80004590 <_ZN9BufferCPPD1Ev+0xec>
    80004584:	00053783          	ld	a5,0(a0)
    80004588:	0087b783          	ld	a5,8(a5)
    8000458c:	000780e7          	jalr	a5
}
    80004590:	01813083          	ld	ra,24(sp)
    80004594:	01013403          	ld	s0,16(sp)
    80004598:	00813483          	ld	s1,8(sp)
    8000459c:	02010113          	addi	sp,sp,32
    800045a0:	00008067          	ret

00000000800045a4 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    800045a4:	fe010113          	addi	sp,sp,-32
    800045a8:	00113c23          	sd	ra,24(sp)
    800045ac:	00813823          	sd	s0,16(sp)
    800045b0:	00913423          	sd	s1,8(sp)
    800045b4:	01213023          	sd	s2,0(sp)
    800045b8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800045bc:	00000913          	li	s2,0
    800045c0:	0380006f          	j	800045f8 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800045c4:	ffffd097          	auipc	ra,0xffffd
    800045c8:	c90080e7          	jalr	-880(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800045cc:	00148493          	addi	s1,s1,1
    800045d0:	000027b7          	lui	a5,0x2
    800045d4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800045d8:	0097ee63          	bltu	a5,s1,800045f4 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800045dc:	00000713          	li	a4,0
    800045e0:	000077b7          	lui	a5,0x7
    800045e4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800045e8:	fce7eee3          	bltu	a5,a4,800045c4 <_Z11workerBodyAPv+0x20>
    800045ec:	00170713          	addi	a4,a4,1
    800045f0:	ff1ff06f          	j	800045e0 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800045f4:	00190913          	addi	s2,s2,1
    800045f8:	00900793          	li	a5,9
    800045fc:	0527e063          	bltu	a5,s2,8000463c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004600:	00005517          	auipc	a0,0x5
    80004604:	cf050513          	addi	a0,a0,-784 # 800092f0 <CONSOLE_STATUS+0x2e0>
    80004608:	ffffd097          	auipc	ra,0xffffd
    8000460c:	568080e7          	jalr	1384(ra) # 80001b70 <_Z11printStringPKc>
    80004610:	00000613          	li	a2,0
    80004614:	00a00593          	li	a1,10
    80004618:	0009051b          	sext.w	a0,s2
    8000461c:	ffffd097          	auipc	ra,0xffffd
    80004620:	6ec080e7          	jalr	1772(ra) # 80001d08 <_Z8printIntiii>
    80004624:	00005517          	auipc	a0,0x5
    80004628:	aa450513          	addi	a0,a0,-1372 # 800090c8 <CONSOLE_STATUS+0xb8>
    8000462c:	ffffd097          	auipc	ra,0xffffd
    80004630:	544080e7          	jalr	1348(ra) # 80001b70 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004634:	00000493          	li	s1,0
    80004638:	f99ff06f          	j	800045d0 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000463c:	00005517          	auipc	a0,0x5
    80004640:	cbc50513          	addi	a0,a0,-836 # 800092f8 <CONSOLE_STATUS+0x2e8>
    80004644:	ffffd097          	auipc	ra,0xffffd
    80004648:	52c080e7          	jalr	1324(ra) # 80001b70 <_Z11printStringPKc>
    finishedA = true;
    8000464c:	00100793          	li	a5,1
    80004650:	0000b717          	auipc	a4,0xb
    80004654:	48f70423          	sb	a5,1160(a4) # 8000fad8 <finishedA>
}
    80004658:	01813083          	ld	ra,24(sp)
    8000465c:	01013403          	ld	s0,16(sp)
    80004660:	00813483          	ld	s1,8(sp)
    80004664:	00013903          	ld	s2,0(sp)
    80004668:	02010113          	addi	sp,sp,32
    8000466c:	00008067          	ret

0000000080004670 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80004670:	fe010113          	addi	sp,sp,-32
    80004674:	00113c23          	sd	ra,24(sp)
    80004678:	00813823          	sd	s0,16(sp)
    8000467c:	00913423          	sd	s1,8(sp)
    80004680:	01213023          	sd	s2,0(sp)
    80004684:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004688:	00000913          	li	s2,0
    8000468c:	0380006f          	j	800046c4 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004690:	ffffd097          	auipc	ra,0xffffd
    80004694:	bc4080e7          	jalr	-1084(ra) # 80001254 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004698:	00148493          	addi	s1,s1,1
    8000469c:	000027b7          	lui	a5,0x2
    800046a0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800046a4:	0097ee63          	bltu	a5,s1,800046c0 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800046a8:	00000713          	li	a4,0
    800046ac:	000077b7          	lui	a5,0x7
    800046b0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800046b4:	fce7eee3          	bltu	a5,a4,80004690 <_Z11workerBodyBPv+0x20>
    800046b8:	00170713          	addi	a4,a4,1
    800046bc:	ff1ff06f          	j	800046ac <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800046c0:	00190913          	addi	s2,s2,1
    800046c4:	00f00793          	li	a5,15
    800046c8:	0527e063          	bltu	a5,s2,80004708 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800046cc:	00005517          	auipc	a0,0x5
    800046d0:	c3c50513          	addi	a0,a0,-964 # 80009308 <CONSOLE_STATUS+0x2f8>
    800046d4:	ffffd097          	auipc	ra,0xffffd
    800046d8:	49c080e7          	jalr	1180(ra) # 80001b70 <_Z11printStringPKc>
    800046dc:	00000613          	li	a2,0
    800046e0:	00a00593          	li	a1,10
    800046e4:	0009051b          	sext.w	a0,s2
    800046e8:	ffffd097          	auipc	ra,0xffffd
    800046ec:	620080e7          	jalr	1568(ra) # 80001d08 <_Z8printIntiii>
    800046f0:	00005517          	auipc	a0,0x5
    800046f4:	9d850513          	addi	a0,a0,-1576 # 800090c8 <CONSOLE_STATUS+0xb8>
    800046f8:	ffffd097          	auipc	ra,0xffffd
    800046fc:	478080e7          	jalr	1144(ra) # 80001b70 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004700:	00000493          	li	s1,0
    80004704:	f99ff06f          	j	8000469c <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004708:	00005517          	auipc	a0,0x5
    8000470c:	c0850513          	addi	a0,a0,-1016 # 80009310 <CONSOLE_STATUS+0x300>
    80004710:	ffffd097          	auipc	ra,0xffffd
    80004714:	460080e7          	jalr	1120(ra) # 80001b70 <_Z11printStringPKc>
    finishedB = true;
    80004718:	00100793          	li	a5,1
    8000471c:	0000b717          	auipc	a4,0xb
    80004720:	3af70ea3          	sb	a5,957(a4) # 8000fad9 <finishedB>
    thread_dispatch();
    80004724:	ffffd097          	auipc	ra,0xffffd
    80004728:	b30080e7          	jalr	-1232(ra) # 80001254 <_Z15thread_dispatchv>
}
    8000472c:	01813083          	ld	ra,24(sp)
    80004730:	01013403          	ld	s0,16(sp)
    80004734:	00813483          	ld	s1,8(sp)
    80004738:	00013903          	ld	s2,0(sp)
    8000473c:	02010113          	addi	sp,sp,32
    80004740:	00008067          	ret

0000000080004744 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80004744:	fe010113          	addi	sp,sp,-32
    80004748:	00113c23          	sd	ra,24(sp)
    8000474c:	00813823          	sd	s0,16(sp)
    80004750:	00913423          	sd	s1,8(sp)
    80004754:	01213023          	sd	s2,0(sp)
    80004758:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    8000475c:	00053903          	ld	s2,0(a0)
    int i = 6;
    80004760:	00600493          	li	s1,6
    while (--i > 0) {
    80004764:	fff4849b          	addiw	s1,s1,-1
    80004768:	04905463          	blez	s1,800047b0 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    8000476c:	00005517          	auipc	a0,0x5
    80004770:	bb450513          	addi	a0,a0,-1100 # 80009320 <CONSOLE_STATUS+0x310>
    80004774:	ffffd097          	auipc	ra,0xffffd
    80004778:	3fc080e7          	jalr	1020(ra) # 80001b70 <_Z11printStringPKc>
        printInt(sleep_time);
    8000477c:	00000613          	li	a2,0
    80004780:	00a00593          	li	a1,10
    80004784:	0009051b          	sext.w	a0,s2
    80004788:	ffffd097          	auipc	ra,0xffffd
    8000478c:	580080e7          	jalr	1408(ra) # 80001d08 <_Z8printIntiii>
        printString(" !\n");
    80004790:	00005517          	auipc	a0,0x5
    80004794:	b9850513          	addi	a0,a0,-1128 # 80009328 <CONSOLE_STATUS+0x318>
    80004798:	ffffd097          	auipc	ra,0xffffd
    8000479c:	3d8080e7          	jalr	984(ra) # 80001b70 <_Z11printStringPKc>
        time_sleep(sleep_time);
    800047a0:	00090513          	mv	a0,s2
    800047a4:	ffffd097          	auipc	ra,0xffffd
    800047a8:	c34080e7          	jalr	-972(ra) # 800013d8 <_Z10time_sleepm>
    while (--i > 0) {
    800047ac:	fb9ff06f          	j	80004764 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800047b0:	00a00793          	li	a5,10
    800047b4:	02f95933          	divu	s2,s2,a5
    800047b8:	fff90913          	addi	s2,s2,-1
    800047bc:	0000b797          	auipc	a5,0xb
    800047c0:	31c78793          	addi	a5,a5,796 # 8000fad8 <finishedA>
    800047c4:	01278933          	add	s2,a5,s2
    800047c8:	00100793          	li	a5,1
    800047cc:	00f90423          	sb	a5,8(s2)
}
    800047d0:	01813083          	ld	ra,24(sp)
    800047d4:	01013403          	ld	s0,16(sp)
    800047d8:	00813483          	ld	s1,8(sp)
    800047dc:	00013903          	ld	s2,0(sp)
    800047e0:	02010113          	addi	sp,sp,32
    800047e4:	00008067          	ret

00000000800047e8 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    800047e8:	fe010113          	addi	sp,sp,-32
    800047ec:	00113c23          	sd	ra,24(sp)
    800047f0:	00813823          	sd	s0,16(sp)
    800047f4:	00913423          	sd	s1,8(sp)
    800047f8:	01213023          	sd	s2,0(sp)
    800047fc:	02010413          	addi	s0,sp,32
    80004800:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004804:	00100793          	li	a5,1
    80004808:	02a7f863          	bgeu	a5,a0,80004838 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000480c:	00a00793          	li	a5,10
    80004810:	02f577b3          	remu	a5,a0,a5
    80004814:	02078e63          	beqz	a5,80004850 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004818:	fff48513          	addi	a0,s1,-1
    8000481c:	00000097          	auipc	ra,0x0
    80004820:	fcc080e7          	jalr	-52(ra) # 800047e8 <_Z9fibonaccim>
    80004824:	00050913          	mv	s2,a0
    80004828:	ffe48513          	addi	a0,s1,-2
    8000482c:	00000097          	auipc	ra,0x0
    80004830:	fbc080e7          	jalr	-68(ra) # 800047e8 <_Z9fibonaccim>
    80004834:	00a90533          	add	a0,s2,a0
}
    80004838:	01813083          	ld	ra,24(sp)
    8000483c:	01013403          	ld	s0,16(sp)
    80004840:	00813483          	ld	s1,8(sp)
    80004844:	00013903          	ld	s2,0(sp)
    80004848:	02010113          	addi	sp,sp,32
    8000484c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004850:	ffffd097          	auipc	ra,0xffffd
    80004854:	a04080e7          	jalr	-1532(ra) # 80001254 <_Z15thread_dispatchv>
    80004858:	fc1ff06f          	j	80004818 <_Z9fibonaccim+0x30>

000000008000485c <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    8000485c:	fe010113          	addi	sp,sp,-32
    80004860:	00113c23          	sd	ra,24(sp)
    80004864:	00813823          	sd	s0,16(sp)
    80004868:	00913423          	sd	s1,8(sp)
    8000486c:	01213023          	sd	s2,0(sp)
    80004870:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004874:	00000493          	li	s1,0
    80004878:	0400006f          	j	800048b8 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000487c:	00005517          	auipc	a0,0x5
    80004880:	ab450513          	addi	a0,a0,-1356 # 80009330 <CONSOLE_STATUS+0x320>
    80004884:	ffffd097          	auipc	ra,0xffffd
    80004888:	2ec080e7          	jalr	748(ra) # 80001b70 <_Z11printStringPKc>
    8000488c:	00000613          	li	a2,0
    80004890:	00a00593          	li	a1,10
    80004894:	00048513          	mv	a0,s1
    80004898:	ffffd097          	auipc	ra,0xffffd
    8000489c:	470080e7          	jalr	1136(ra) # 80001d08 <_Z8printIntiii>
    800048a0:	00005517          	auipc	a0,0x5
    800048a4:	82850513          	addi	a0,a0,-2008 # 800090c8 <CONSOLE_STATUS+0xb8>
    800048a8:	ffffd097          	auipc	ra,0xffffd
    800048ac:	2c8080e7          	jalr	712(ra) # 80001b70 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800048b0:	0014849b          	addiw	s1,s1,1
    800048b4:	0ff4f493          	andi	s1,s1,255
    800048b8:	00200793          	li	a5,2
    800048bc:	fc97f0e3          	bgeu	a5,s1,8000487c <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    800048c0:	00005517          	auipc	a0,0x5
    800048c4:	a7850513          	addi	a0,a0,-1416 # 80009338 <CONSOLE_STATUS+0x328>
    800048c8:	ffffd097          	auipc	ra,0xffffd
    800048cc:	2a8080e7          	jalr	680(ra) # 80001b70 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800048d0:	00700313          	li	t1,7
    thread_dispatch();
    800048d4:	ffffd097          	auipc	ra,0xffffd
    800048d8:	980080e7          	jalr	-1664(ra) # 80001254 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800048dc:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800048e0:	00005517          	auipc	a0,0x5
    800048e4:	a6850513          	addi	a0,a0,-1432 # 80009348 <CONSOLE_STATUS+0x338>
    800048e8:	ffffd097          	auipc	ra,0xffffd
    800048ec:	288080e7          	jalr	648(ra) # 80001b70 <_Z11printStringPKc>
    800048f0:	00000613          	li	a2,0
    800048f4:	00a00593          	li	a1,10
    800048f8:	0009051b          	sext.w	a0,s2
    800048fc:	ffffd097          	auipc	ra,0xffffd
    80004900:	40c080e7          	jalr	1036(ra) # 80001d08 <_Z8printIntiii>
    80004904:	00004517          	auipc	a0,0x4
    80004908:	7c450513          	addi	a0,a0,1988 # 800090c8 <CONSOLE_STATUS+0xb8>
    8000490c:	ffffd097          	auipc	ra,0xffffd
    80004910:	264080e7          	jalr	612(ra) # 80001b70 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004914:	00c00513          	li	a0,12
    80004918:	00000097          	auipc	ra,0x0
    8000491c:	ed0080e7          	jalr	-304(ra) # 800047e8 <_Z9fibonaccim>
    80004920:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004924:	00005517          	auipc	a0,0x5
    80004928:	a2c50513          	addi	a0,a0,-1492 # 80009350 <CONSOLE_STATUS+0x340>
    8000492c:	ffffd097          	auipc	ra,0xffffd
    80004930:	244080e7          	jalr	580(ra) # 80001b70 <_Z11printStringPKc>
    80004934:	00000613          	li	a2,0
    80004938:	00a00593          	li	a1,10
    8000493c:	0009051b          	sext.w	a0,s2
    80004940:	ffffd097          	auipc	ra,0xffffd
    80004944:	3c8080e7          	jalr	968(ra) # 80001d08 <_Z8printIntiii>
    80004948:	00004517          	auipc	a0,0x4
    8000494c:	78050513          	addi	a0,a0,1920 # 800090c8 <CONSOLE_STATUS+0xb8>
    80004950:	ffffd097          	auipc	ra,0xffffd
    80004954:	220080e7          	jalr	544(ra) # 80001b70 <_Z11printStringPKc>
    80004958:	0400006f          	j	80004998 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000495c:	00005517          	auipc	a0,0x5
    80004960:	9d450513          	addi	a0,a0,-1580 # 80009330 <CONSOLE_STATUS+0x320>
    80004964:	ffffd097          	auipc	ra,0xffffd
    80004968:	20c080e7          	jalr	524(ra) # 80001b70 <_Z11printStringPKc>
    8000496c:	00000613          	li	a2,0
    80004970:	00a00593          	li	a1,10
    80004974:	00048513          	mv	a0,s1
    80004978:	ffffd097          	auipc	ra,0xffffd
    8000497c:	390080e7          	jalr	912(ra) # 80001d08 <_Z8printIntiii>
    80004980:	00004517          	auipc	a0,0x4
    80004984:	74850513          	addi	a0,a0,1864 # 800090c8 <CONSOLE_STATUS+0xb8>
    80004988:	ffffd097          	auipc	ra,0xffffd
    8000498c:	1e8080e7          	jalr	488(ra) # 80001b70 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004990:	0014849b          	addiw	s1,s1,1
    80004994:	0ff4f493          	andi	s1,s1,255
    80004998:	00500793          	li	a5,5
    8000499c:	fc97f0e3          	bgeu	a5,s1,8000495c <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    800049a0:	00005517          	auipc	a0,0x5
    800049a4:	95850513          	addi	a0,a0,-1704 # 800092f8 <CONSOLE_STATUS+0x2e8>
    800049a8:	ffffd097          	auipc	ra,0xffffd
    800049ac:	1c8080e7          	jalr	456(ra) # 80001b70 <_Z11printStringPKc>
    finishedC = true;
    800049b0:	00100793          	li	a5,1
    800049b4:	0000b717          	auipc	a4,0xb
    800049b8:	12f70723          	sb	a5,302(a4) # 8000fae2 <finishedC>
    thread_dispatch();
    800049bc:	ffffd097          	auipc	ra,0xffffd
    800049c0:	898080e7          	jalr	-1896(ra) # 80001254 <_Z15thread_dispatchv>
}
    800049c4:	01813083          	ld	ra,24(sp)
    800049c8:	01013403          	ld	s0,16(sp)
    800049cc:	00813483          	ld	s1,8(sp)
    800049d0:	00013903          	ld	s2,0(sp)
    800049d4:	02010113          	addi	sp,sp,32
    800049d8:	00008067          	ret

00000000800049dc <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    800049dc:	fe010113          	addi	sp,sp,-32
    800049e0:	00113c23          	sd	ra,24(sp)
    800049e4:	00813823          	sd	s0,16(sp)
    800049e8:	00913423          	sd	s1,8(sp)
    800049ec:	01213023          	sd	s2,0(sp)
    800049f0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800049f4:	00a00493          	li	s1,10
    800049f8:	0400006f          	j	80004a38 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800049fc:	00005517          	auipc	a0,0x5
    80004a00:	96450513          	addi	a0,a0,-1692 # 80009360 <CONSOLE_STATUS+0x350>
    80004a04:	ffffd097          	auipc	ra,0xffffd
    80004a08:	16c080e7          	jalr	364(ra) # 80001b70 <_Z11printStringPKc>
    80004a0c:	00000613          	li	a2,0
    80004a10:	00a00593          	li	a1,10
    80004a14:	00048513          	mv	a0,s1
    80004a18:	ffffd097          	auipc	ra,0xffffd
    80004a1c:	2f0080e7          	jalr	752(ra) # 80001d08 <_Z8printIntiii>
    80004a20:	00004517          	auipc	a0,0x4
    80004a24:	6a850513          	addi	a0,a0,1704 # 800090c8 <CONSOLE_STATUS+0xb8>
    80004a28:	ffffd097          	auipc	ra,0xffffd
    80004a2c:	148080e7          	jalr	328(ra) # 80001b70 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004a30:	0014849b          	addiw	s1,s1,1
    80004a34:	0ff4f493          	andi	s1,s1,255
    80004a38:	00c00793          	li	a5,12
    80004a3c:	fc97f0e3          	bgeu	a5,s1,800049fc <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004a40:	00005517          	auipc	a0,0x5
    80004a44:	92850513          	addi	a0,a0,-1752 # 80009368 <CONSOLE_STATUS+0x358>
    80004a48:	ffffd097          	auipc	ra,0xffffd
    80004a4c:	128080e7          	jalr	296(ra) # 80001b70 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004a50:	00500313          	li	t1,5
    thread_dispatch();
    80004a54:	ffffd097          	auipc	ra,0xffffd
    80004a58:	800080e7          	jalr	-2048(ra) # 80001254 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004a5c:	01000513          	li	a0,16
    80004a60:	00000097          	auipc	ra,0x0
    80004a64:	d88080e7          	jalr	-632(ra) # 800047e8 <_Z9fibonaccim>
    80004a68:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004a6c:	00005517          	auipc	a0,0x5
    80004a70:	90c50513          	addi	a0,a0,-1780 # 80009378 <CONSOLE_STATUS+0x368>
    80004a74:	ffffd097          	auipc	ra,0xffffd
    80004a78:	0fc080e7          	jalr	252(ra) # 80001b70 <_Z11printStringPKc>
    80004a7c:	00000613          	li	a2,0
    80004a80:	00a00593          	li	a1,10
    80004a84:	0009051b          	sext.w	a0,s2
    80004a88:	ffffd097          	auipc	ra,0xffffd
    80004a8c:	280080e7          	jalr	640(ra) # 80001d08 <_Z8printIntiii>
    80004a90:	00004517          	auipc	a0,0x4
    80004a94:	63850513          	addi	a0,a0,1592 # 800090c8 <CONSOLE_STATUS+0xb8>
    80004a98:	ffffd097          	auipc	ra,0xffffd
    80004a9c:	0d8080e7          	jalr	216(ra) # 80001b70 <_Z11printStringPKc>
    80004aa0:	0400006f          	j	80004ae0 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004aa4:	00005517          	auipc	a0,0x5
    80004aa8:	8bc50513          	addi	a0,a0,-1860 # 80009360 <CONSOLE_STATUS+0x350>
    80004aac:	ffffd097          	auipc	ra,0xffffd
    80004ab0:	0c4080e7          	jalr	196(ra) # 80001b70 <_Z11printStringPKc>
    80004ab4:	00000613          	li	a2,0
    80004ab8:	00a00593          	li	a1,10
    80004abc:	00048513          	mv	a0,s1
    80004ac0:	ffffd097          	auipc	ra,0xffffd
    80004ac4:	248080e7          	jalr	584(ra) # 80001d08 <_Z8printIntiii>
    80004ac8:	00004517          	auipc	a0,0x4
    80004acc:	60050513          	addi	a0,a0,1536 # 800090c8 <CONSOLE_STATUS+0xb8>
    80004ad0:	ffffd097          	auipc	ra,0xffffd
    80004ad4:	0a0080e7          	jalr	160(ra) # 80001b70 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004ad8:	0014849b          	addiw	s1,s1,1
    80004adc:	0ff4f493          	andi	s1,s1,255
    80004ae0:	00f00793          	li	a5,15
    80004ae4:	fc97f0e3          	bgeu	a5,s1,80004aa4 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004ae8:	00005517          	auipc	a0,0x5
    80004aec:	8a050513          	addi	a0,a0,-1888 # 80009388 <CONSOLE_STATUS+0x378>
    80004af0:	ffffd097          	auipc	ra,0xffffd
    80004af4:	080080e7          	jalr	128(ra) # 80001b70 <_Z11printStringPKc>
    finishedD = true;
    80004af8:	00100793          	li	a5,1
    80004afc:	0000b717          	auipc	a4,0xb
    80004b00:	fef703a3          	sb	a5,-25(a4) # 8000fae3 <finishedD>
    thread_dispatch();
    80004b04:	ffffc097          	auipc	ra,0xffffc
    80004b08:	750080e7          	jalr	1872(ra) # 80001254 <_Z15thread_dispatchv>
}
    80004b0c:	01813083          	ld	ra,24(sp)
    80004b10:	01013403          	ld	s0,16(sp)
    80004b14:	00813483          	ld	s1,8(sp)
    80004b18:	00013903          	ld	s2,0(sp)
    80004b1c:	02010113          	addi	sp,sp,32
    80004b20:	00008067          	ret

0000000080004b24 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80004b24:	fc010113          	addi	sp,sp,-64
    80004b28:	02113c23          	sd	ra,56(sp)
    80004b2c:	02813823          	sd	s0,48(sp)
    80004b30:	02913423          	sd	s1,40(sp)
    80004b34:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004b38:	00000613          	li	a2,0
    80004b3c:	00000597          	auipc	a1,0x0
    80004b40:	a6858593          	addi	a1,a1,-1432 # 800045a4 <_Z11workerBodyAPv>
    80004b44:	fc040513          	addi	a0,s0,-64
    80004b48:	ffffc097          	auipc	ra,0xffffc
    80004b4c:	668080e7          	jalr	1640(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80004b50:	00005517          	auipc	a0,0x5
    80004b54:	84850513          	addi	a0,a0,-1976 # 80009398 <CONSOLE_STATUS+0x388>
    80004b58:	ffffd097          	auipc	ra,0xffffd
    80004b5c:	018080e7          	jalr	24(ra) # 80001b70 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004b60:	00000613          	li	a2,0
    80004b64:	00000597          	auipc	a1,0x0
    80004b68:	b0c58593          	addi	a1,a1,-1268 # 80004670 <_Z11workerBodyBPv>
    80004b6c:	fc840513          	addi	a0,s0,-56
    80004b70:	ffffc097          	auipc	ra,0xffffc
    80004b74:	640080e7          	jalr	1600(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004b78:	00005517          	auipc	a0,0x5
    80004b7c:	83850513          	addi	a0,a0,-1992 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80004b80:	ffffd097          	auipc	ra,0xffffd
    80004b84:	ff0080e7          	jalr	-16(ra) # 80001b70 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004b88:	00000613          	li	a2,0
    80004b8c:	00000597          	auipc	a1,0x0
    80004b90:	cd058593          	addi	a1,a1,-816 # 8000485c <_Z11workerBodyCPv>
    80004b94:	fd040513          	addi	a0,s0,-48
    80004b98:	ffffc097          	auipc	ra,0xffffc
    80004b9c:	618080e7          	jalr	1560(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80004ba0:	00005517          	auipc	a0,0x5
    80004ba4:	82850513          	addi	a0,a0,-2008 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80004ba8:	ffffd097          	auipc	ra,0xffffd
    80004bac:	fc8080e7          	jalr	-56(ra) # 80001b70 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80004bb0:	00000613          	li	a2,0
    80004bb4:	00000597          	auipc	a1,0x0
    80004bb8:	e2858593          	addi	a1,a1,-472 # 800049dc <_Z11workerBodyDPv>
    80004bbc:	fd840513          	addi	a0,s0,-40
    80004bc0:	ffffc097          	auipc	ra,0xffffc
    80004bc4:	5f0080e7          	jalr	1520(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004bc8:	00005517          	auipc	a0,0x5
    80004bcc:	81850513          	addi	a0,a0,-2024 # 800093e0 <CONSOLE_STATUS+0x3d0>
    80004bd0:	ffffd097          	auipc	ra,0xffffd
    80004bd4:	fa0080e7          	jalr	-96(ra) # 80001b70 <_Z11printStringPKc>
    80004bd8:	00c0006f          	j	80004be4 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004bdc:	ffffc097          	auipc	ra,0xffffc
    80004be0:	678080e7          	jalr	1656(ra) # 80001254 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004be4:	0000b797          	auipc	a5,0xb
    80004be8:	ef47c783          	lbu	a5,-268(a5) # 8000fad8 <finishedA>
    80004bec:	fe0788e3          	beqz	a5,80004bdc <_Z18Threads_C_API_testv+0xb8>
    80004bf0:	0000b797          	auipc	a5,0xb
    80004bf4:	ee97c783          	lbu	a5,-279(a5) # 8000fad9 <finishedB>
    80004bf8:	fe0782e3          	beqz	a5,80004bdc <_Z18Threads_C_API_testv+0xb8>
    80004bfc:	0000b797          	auipc	a5,0xb
    80004c00:	ee67c783          	lbu	a5,-282(a5) # 8000fae2 <finishedC>
    80004c04:	fc078ce3          	beqz	a5,80004bdc <_Z18Threads_C_API_testv+0xb8>
    80004c08:	0000b797          	auipc	a5,0xb
    80004c0c:	edb7c783          	lbu	a5,-293(a5) # 8000fae3 <finishedD>
    80004c10:	fc0786e3          	beqz	a5,80004bdc <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80004c14:	fc040493          	addi	s1,s0,-64
    80004c18:	0080006f          	j	80004c20 <_Z18Threads_C_API_testv+0xfc>
    80004c1c:	00848493          	addi	s1,s1,8
    80004c20:	fe040793          	addi	a5,s0,-32
    80004c24:	00f48c63          	beq	s1,a5,80004c3c <_Z18Threads_C_API_testv+0x118>
    80004c28:	0004b503          	ld	a0,0(s1)
    80004c2c:	fe0508e3          	beqz	a0,80004c1c <_Z18Threads_C_API_testv+0xf8>
    80004c30:	ffffd097          	auipc	ra,0xffffd
    80004c34:	df4080e7          	jalr	-524(ra) # 80001a24 <_ZN7_threaddlEPv>
    80004c38:	fe5ff06f          	j	80004c1c <_Z18Threads_C_API_testv+0xf8>
}
    80004c3c:	03813083          	ld	ra,56(sp)
    80004c40:	03013403          	ld	s0,48(sp)
    80004c44:	02813483          	ld	s1,40(sp)
    80004c48:	04010113          	addi	sp,sp,64
    80004c4c:	00008067          	ret

0000000080004c50 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80004c50:	fd010113          	addi	sp,sp,-48
    80004c54:	02113423          	sd	ra,40(sp)
    80004c58:	02813023          	sd	s0,32(sp)
    80004c5c:	00913c23          	sd	s1,24(sp)
    80004c60:	01213823          	sd	s2,16(sp)
    80004c64:	01313423          	sd	s3,8(sp)
    80004c68:	03010413          	addi	s0,sp,48
    80004c6c:	00050993          	mv	s3,a0
    80004c70:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80004c74:	00000913          	li	s2,0
    80004c78:	00c0006f          	j	80004c84 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80004c7c:	ffffe097          	auipc	ra,0xffffe
    80004c80:	e8c080e7          	jalr	-372(ra) # 80002b08 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80004c84:	ffffc097          	auipc	ra,0xffffc
    80004c88:	780080e7          	jalr	1920(ra) # 80001404 <_Z4getcv>
    80004c8c:	0005059b          	sext.w	a1,a0
    80004c90:	01b00793          	li	a5,27
    80004c94:	02f58a63          	beq	a1,a5,80004cc8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80004c98:	0084b503          	ld	a0,8(s1)
    80004c9c:	fffff097          	auipc	ra,0xfffff
    80004ca0:	664080e7          	jalr	1636(ra) # 80004300 <_ZN9BufferCPP3putEi>
        i++;
    80004ca4:	0019071b          	addiw	a4,s2,1
    80004ca8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004cac:	0004a683          	lw	a3,0(s1)
    80004cb0:	0026979b          	slliw	a5,a3,0x2
    80004cb4:	00d787bb          	addw	a5,a5,a3
    80004cb8:	0017979b          	slliw	a5,a5,0x1
    80004cbc:	02f767bb          	remw	a5,a4,a5
    80004cc0:	fc0792e3          	bnez	a5,80004c84 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80004cc4:	fb9ff06f          	j	80004c7c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80004cc8:	00100793          	li	a5,1
    80004ccc:	0000b717          	auipc	a4,0xb
    80004cd0:	e0f72c23          	sw	a5,-488(a4) # 8000fae4 <threadEnd>
    td->buffer->put('!');
    80004cd4:	0109b783          	ld	a5,16(s3)
    80004cd8:	02100593          	li	a1,33
    80004cdc:	0087b503          	ld	a0,8(a5)
    80004ce0:	fffff097          	auipc	ra,0xfffff
    80004ce4:	620080e7          	jalr	1568(ra) # 80004300 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80004ce8:	0104b503          	ld	a0,16(s1)
    80004cec:	ffffe097          	auipc	ra,0xffffe
    80004cf0:	d0c080e7          	jalr	-756(ra) # 800029f8 <_ZN9Semaphore6signalEv>
}
    80004cf4:	02813083          	ld	ra,40(sp)
    80004cf8:	02013403          	ld	s0,32(sp)
    80004cfc:	01813483          	ld	s1,24(sp)
    80004d00:	01013903          	ld	s2,16(sp)
    80004d04:	00813983          	ld	s3,8(sp)
    80004d08:	03010113          	addi	sp,sp,48
    80004d0c:	00008067          	ret

0000000080004d10 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    80004d10:	fe010113          	addi	sp,sp,-32
    80004d14:	00113c23          	sd	ra,24(sp)
    80004d18:	00813823          	sd	s0,16(sp)
    80004d1c:	00913423          	sd	s1,8(sp)
    80004d20:	01213023          	sd	s2,0(sp)
    80004d24:	02010413          	addi	s0,sp,32
    80004d28:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004d2c:	00000913          	li	s2,0
    80004d30:	00c0006f          	j	80004d3c <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80004d34:	ffffe097          	auipc	ra,0xffffe
    80004d38:	dd4080e7          	jalr	-556(ra) # 80002b08 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80004d3c:	0000b797          	auipc	a5,0xb
    80004d40:	da87a783          	lw	a5,-600(a5) # 8000fae4 <threadEnd>
    80004d44:	02079e63          	bnez	a5,80004d80 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80004d48:	0004a583          	lw	a1,0(s1)
    80004d4c:	0305859b          	addiw	a1,a1,48
    80004d50:	0084b503          	ld	a0,8(s1)
    80004d54:	fffff097          	auipc	ra,0xfffff
    80004d58:	5ac080e7          	jalr	1452(ra) # 80004300 <_ZN9BufferCPP3putEi>
        i++;
    80004d5c:	0019071b          	addiw	a4,s2,1
    80004d60:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004d64:	0004a683          	lw	a3,0(s1)
    80004d68:	0026979b          	slliw	a5,a3,0x2
    80004d6c:	00d787bb          	addw	a5,a5,a3
    80004d70:	0017979b          	slliw	a5,a5,0x1
    80004d74:	02f767bb          	remw	a5,a4,a5
    80004d78:	fc0792e3          	bnez	a5,80004d3c <_ZN8Producer8producerEPv+0x2c>
    80004d7c:	fb9ff06f          	j	80004d34 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80004d80:	0104b503          	ld	a0,16(s1)
    80004d84:	ffffe097          	auipc	ra,0xffffe
    80004d88:	c74080e7          	jalr	-908(ra) # 800029f8 <_ZN9Semaphore6signalEv>
}
    80004d8c:	01813083          	ld	ra,24(sp)
    80004d90:	01013403          	ld	s0,16(sp)
    80004d94:	00813483          	ld	s1,8(sp)
    80004d98:	00013903          	ld	s2,0(sp)
    80004d9c:	02010113          	addi	sp,sp,32
    80004da0:	00008067          	ret

0000000080004da4 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    80004da4:	fd010113          	addi	sp,sp,-48
    80004da8:	02113423          	sd	ra,40(sp)
    80004dac:	02813023          	sd	s0,32(sp)
    80004db0:	00913c23          	sd	s1,24(sp)
    80004db4:	01213823          	sd	s2,16(sp)
    80004db8:	01313423          	sd	s3,8(sp)
    80004dbc:	01413023          	sd	s4,0(sp)
    80004dc0:	03010413          	addi	s0,sp,48
    80004dc4:	00050993          	mv	s3,a0
    80004dc8:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80004dcc:	00000a13          	li	s4,0
    80004dd0:	01c0006f          	j	80004dec <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80004dd4:	ffffe097          	auipc	ra,0xffffe
    80004dd8:	d34080e7          	jalr	-716(ra) # 80002b08 <_ZN6Thread8dispatchEv>
    80004ddc:	0500006f          	j	80004e2c <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80004de0:	00a00513          	li	a0,10
    80004de4:	ffffc097          	auipc	ra,0xffffc
    80004de8:	648080e7          	jalr	1608(ra) # 8000142c <_Z4putcc>
    while (!threadEnd) {
    80004dec:	0000b797          	auipc	a5,0xb
    80004df0:	cf87a783          	lw	a5,-776(a5) # 8000fae4 <threadEnd>
    80004df4:	06079263          	bnez	a5,80004e58 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80004df8:	00893503          	ld	a0,8(s2)
    80004dfc:	fffff097          	auipc	ra,0xfffff
    80004e00:	594080e7          	jalr	1428(ra) # 80004390 <_ZN9BufferCPP3getEv>
        i++;
    80004e04:	001a049b          	addiw	s1,s4,1
    80004e08:	00048a1b          	sext.w	s4,s1
        putc(key);
    80004e0c:	0ff57513          	andi	a0,a0,255
    80004e10:	ffffc097          	auipc	ra,0xffffc
    80004e14:	61c080e7          	jalr	1564(ra) # 8000142c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80004e18:	00092703          	lw	a4,0(s2)
    80004e1c:	0027179b          	slliw	a5,a4,0x2
    80004e20:	00e787bb          	addw	a5,a5,a4
    80004e24:	02f4e7bb          	remw	a5,s1,a5
    80004e28:	fa0786e3          	beqz	a5,80004dd4 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    80004e2c:	05000793          	li	a5,80
    80004e30:	02f4e4bb          	remw	s1,s1,a5
    80004e34:	fa049ce3          	bnez	s1,80004dec <_ZN8Consumer8consumerEPv+0x48>
    80004e38:	fa9ff06f          	j	80004de0 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80004e3c:	0109b783          	ld	a5,16(s3)
    80004e40:	0087b503          	ld	a0,8(a5)
    80004e44:	fffff097          	auipc	ra,0xfffff
    80004e48:	54c080e7          	jalr	1356(ra) # 80004390 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80004e4c:	0ff57513          	andi	a0,a0,255
    80004e50:	ffffe097          	auipc	ra,0xffffe
    80004e54:	da4080e7          	jalr	-604(ra) # 80002bf4 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80004e58:	0109b783          	ld	a5,16(s3)
    80004e5c:	0087b503          	ld	a0,8(a5)
    80004e60:	fffff097          	auipc	ra,0xfffff
    80004e64:	5bc080e7          	jalr	1468(ra) # 8000441c <_ZN9BufferCPP6getCntEv>
    80004e68:	fca04ae3          	bgtz	a0,80004e3c <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    80004e6c:	01093503          	ld	a0,16(s2)
    80004e70:	ffffe097          	auipc	ra,0xffffe
    80004e74:	b88080e7          	jalr	-1144(ra) # 800029f8 <_ZN9Semaphore6signalEv>
}
    80004e78:	02813083          	ld	ra,40(sp)
    80004e7c:	02013403          	ld	s0,32(sp)
    80004e80:	01813483          	ld	s1,24(sp)
    80004e84:	01013903          	ld	s2,16(sp)
    80004e88:	00813983          	ld	s3,8(sp)
    80004e8c:	00013a03          	ld	s4,0(sp)
    80004e90:	03010113          	addi	sp,sp,48
    80004e94:	00008067          	ret

0000000080004e98 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80004e98:	f8010113          	addi	sp,sp,-128
    80004e9c:	06113c23          	sd	ra,120(sp)
    80004ea0:	06813823          	sd	s0,112(sp)
    80004ea4:	06913423          	sd	s1,104(sp)
    80004ea8:	07213023          	sd	s2,96(sp)
    80004eac:	05313c23          	sd	s3,88(sp)
    80004eb0:	05413823          	sd	s4,80(sp)
    80004eb4:	05513423          	sd	s5,72(sp)
    80004eb8:	05613023          	sd	s6,64(sp)
    80004ebc:	03713c23          	sd	s7,56(sp)
    80004ec0:	03813823          	sd	s8,48(sp)
    80004ec4:	03913423          	sd	s9,40(sp)
    80004ec8:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80004ecc:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80004ed0:	00004517          	auipc	a0,0x4
    80004ed4:	52850513          	addi	a0,a0,1320 # 800093f8 <CONSOLE_STATUS+0x3e8>
    80004ed8:	ffffd097          	auipc	ra,0xffffd
    80004edc:	c98080e7          	jalr	-872(ra) # 80001b70 <_Z11printStringPKc>
    getString(input, 30);
    80004ee0:	01e00593          	li	a1,30
    80004ee4:	f8040493          	addi	s1,s0,-128
    80004ee8:	00048513          	mv	a0,s1
    80004eec:	ffffd097          	auipc	ra,0xffffd
    80004ef0:	d00080e7          	jalr	-768(ra) # 80001bec <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004ef4:	00048513          	mv	a0,s1
    80004ef8:	ffffd097          	auipc	ra,0xffffd
    80004efc:	dc0080e7          	jalr	-576(ra) # 80001cb8 <_Z11stringToIntPKc>
    80004f00:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80004f04:	00004517          	auipc	a0,0x4
    80004f08:	51450513          	addi	a0,a0,1300 # 80009418 <CONSOLE_STATUS+0x408>
    80004f0c:	ffffd097          	auipc	ra,0xffffd
    80004f10:	c64080e7          	jalr	-924(ra) # 80001b70 <_Z11printStringPKc>
    getString(input, 30);
    80004f14:	01e00593          	li	a1,30
    80004f18:	00048513          	mv	a0,s1
    80004f1c:	ffffd097          	auipc	ra,0xffffd
    80004f20:	cd0080e7          	jalr	-816(ra) # 80001bec <_Z9getStringPci>
    n = stringToInt(input);
    80004f24:	00048513          	mv	a0,s1
    80004f28:	ffffd097          	auipc	ra,0xffffd
    80004f2c:	d90080e7          	jalr	-624(ra) # 80001cb8 <_Z11stringToIntPKc>
    80004f30:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80004f34:	00004517          	auipc	a0,0x4
    80004f38:	50450513          	addi	a0,a0,1284 # 80009438 <CONSOLE_STATUS+0x428>
    80004f3c:	ffffd097          	auipc	ra,0xffffd
    80004f40:	c34080e7          	jalr	-972(ra) # 80001b70 <_Z11printStringPKc>
    80004f44:	00000613          	li	a2,0
    80004f48:	00a00593          	li	a1,10
    80004f4c:	00090513          	mv	a0,s2
    80004f50:	ffffd097          	auipc	ra,0xffffd
    80004f54:	db8080e7          	jalr	-584(ra) # 80001d08 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004f58:	00004517          	auipc	a0,0x4
    80004f5c:	4f850513          	addi	a0,a0,1272 # 80009450 <CONSOLE_STATUS+0x440>
    80004f60:	ffffd097          	auipc	ra,0xffffd
    80004f64:	c10080e7          	jalr	-1008(ra) # 80001b70 <_Z11printStringPKc>
    80004f68:	00000613          	li	a2,0
    80004f6c:	00a00593          	li	a1,10
    80004f70:	00048513          	mv	a0,s1
    80004f74:	ffffd097          	auipc	ra,0xffffd
    80004f78:	d94080e7          	jalr	-620(ra) # 80001d08 <_Z8printIntiii>
    printString(".\n");
    80004f7c:	00004517          	auipc	a0,0x4
    80004f80:	1b450513          	addi	a0,a0,436 # 80009130 <CONSOLE_STATUS+0x120>
    80004f84:	ffffd097          	auipc	ra,0xffffd
    80004f88:	bec080e7          	jalr	-1044(ra) # 80001b70 <_Z11printStringPKc>
    if(threadNum > n) {
    80004f8c:	0324c463          	blt	s1,s2,80004fb4 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80004f90:	03205c63          	blez	s2,80004fc8 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80004f94:	03800513          	li	a0,56
    80004f98:	ffffe097          	auipc	ra,0xffffe
    80004f9c:	904080e7          	jalr	-1788(ra) # 8000289c <_Znwm>
    80004fa0:	00050a93          	mv	s5,a0
    80004fa4:	00048593          	mv	a1,s1
    80004fa8:	fffff097          	auipc	ra,0xfffff
    80004fac:	204080e7          	jalr	516(ra) # 800041ac <_ZN9BufferCPPC1Ei>
    80004fb0:	0300006f          	j	80004fe0 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004fb4:	00004517          	auipc	a0,0x4
    80004fb8:	4b450513          	addi	a0,a0,1204 # 80009468 <CONSOLE_STATUS+0x458>
    80004fbc:	ffffd097          	auipc	ra,0xffffd
    80004fc0:	bb4080e7          	jalr	-1100(ra) # 80001b70 <_Z11printStringPKc>
        return;
    80004fc4:	0140006f          	j	80004fd8 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004fc8:	00004517          	auipc	a0,0x4
    80004fcc:	4e050513          	addi	a0,a0,1248 # 800094a8 <CONSOLE_STATUS+0x498>
    80004fd0:	ffffd097          	auipc	ra,0xffffd
    80004fd4:	ba0080e7          	jalr	-1120(ra) # 80001b70 <_Z11printStringPKc>
        return;
    80004fd8:	000b8113          	mv	sp,s7
    80004fdc:	2400006f          	j	8000521c <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    80004fe0:	01000513          	li	a0,16
    80004fe4:	ffffe097          	auipc	ra,0xffffe
    80004fe8:	8b8080e7          	jalr	-1864(ra) # 8000289c <_Znwm>
    80004fec:	00050493          	mv	s1,a0
    80004ff0:	00000593          	li	a1,0
    80004ff4:	ffffe097          	auipc	ra,0xffffe
    80004ff8:	9a0080e7          	jalr	-1632(ra) # 80002994 <_ZN9SemaphoreC1Ej>
    80004ffc:	0000b717          	auipc	a4,0xb
    80005000:	adc70713          	addi	a4,a4,-1316 # 8000fad8 <finishedA>
    80005004:	00973823          	sd	s1,16(a4)
    Thread* threads[threadNum];
    80005008:	00391793          	slli	a5,s2,0x3
    8000500c:	00f78793          	addi	a5,a5,15
    80005010:	ff07f793          	andi	a5,a5,-16
    80005014:	40f10133          	sub	sp,sp,a5
    80005018:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    8000501c:	0019069b          	addiw	a3,s2,1
    80005020:	00169793          	slli	a5,a3,0x1
    80005024:	00d787b3          	add	a5,a5,a3
    80005028:	00379793          	slli	a5,a5,0x3
    8000502c:	00f78793          	addi	a5,a5,15
    80005030:	ff07f793          	andi	a5,a5,-16
    80005034:	40f10133          	sub	sp,sp,a5
    80005038:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000503c:	00191493          	slli	s1,s2,0x1
    80005040:	012487b3          	add	a5,s1,s2
    80005044:	00379793          	slli	a5,a5,0x3
    80005048:	00fa07b3          	add	a5,s4,a5
    8000504c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005050:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005054:	01073703          	ld	a4,16(a4)
    80005058:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    8000505c:	01800513          	li	a0,24
    80005060:	ffffe097          	auipc	ra,0xffffe
    80005064:	83c080e7          	jalr	-1988(ra) # 8000289c <_Znwm>
    80005068:	00050b13          	mv	s6,a0
    8000506c:	012484b3          	add	s1,s1,s2
    80005070:	00349493          	slli	s1,s1,0x3
    80005074:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    80005078:	ffffe097          	auipc	ra,0xffffe
    8000507c:	9e4080e7          	jalr	-1564(ra) # 80002a5c <_ZN6ThreadC1Ev>
    80005080:	00006797          	auipc	a5,0x6
    80005084:	73078793          	addi	a5,a5,1840 # 8000b7b0 <_ZTV8Consumer+0x10>
    80005088:	00fb3023          	sd	a5,0(s6)
    8000508c:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    80005090:	000b0513          	mv	a0,s6
    80005094:	ffffe097          	auipc	ra,0xffffe
    80005098:	a9c080e7          	jalr	-1380(ra) # 80002b30 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    8000509c:	00000493          	li	s1,0
    800050a0:	0380006f          	j	800050d8 <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    800050a4:	00006797          	auipc	a5,0x6
    800050a8:	6e478793          	addi	a5,a5,1764 # 8000b788 <_ZTV8Producer+0x10>
    800050ac:	00fcb023          	sd	a5,0(s9)
    800050b0:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    800050b4:	00349793          	slli	a5,s1,0x3
    800050b8:	00f987b3          	add	a5,s3,a5
    800050bc:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800050c0:	00349793          	slli	a5,s1,0x3
    800050c4:	00f987b3          	add	a5,s3,a5
    800050c8:	0007b503          	ld	a0,0(a5)
    800050cc:	ffffe097          	auipc	ra,0xffffe
    800050d0:	a64080e7          	jalr	-1436(ra) # 80002b30 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800050d4:	0014849b          	addiw	s1,s1,1
    800050d8:	0b24d063          	bge	s1,s2,80005178 <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    800050dc:	00149793          	slli	a5,s1,0x1
    800050e0:	009787b3          	add	a5,a5,s1
    800050e4:	00379793          	slli	a5,a5,0x3
    800050e8:	00fa07b3          	add	a5,s4,a5
    800050ec:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800050f0:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800050f4:	0000b717          	auipc	a4,0xb
    800050f8:	9f473703          	ld	a4,-1548(a4) # 8000fae8 <waitForAll>
    800050fc:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80005100:	02905863          	blez	s1,80005130 <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    80005104:	01800513          	li	a0,24
    80005108:	ffffd097          	auipc	ra,0xffffd
    8000510c:	794080e7          	jalr	1940(ra) # 8000289c <_Znwm>
    80005110:	00050c93          	mv	s9,a0
    80005114:	00149c13          	slli	s8,s1,0x1
    80005118:	009c0c33          	add	s8,s8,s1
    8000511c:	003c1c13          	slli	s8,s8,0x3
    80005120:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005124:	ffffe097          	auipc	ra,0xffffe
    80005128:	938080e7          	jalr	-1736(ra) # 80002a5c <_ZN6ThreadC1Ev>
    8000512c:	f79ff06f          	j	800050a4 <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    80005130:	01800513          	li	a0,24
    80005134:	ffffd097          	auipc	ra,0xffffd
    80005138:	768080e7          	jalr	1896(ra) # 8000289c <_Znwm>
    8000513c:	00050c93          	mv	s9,a0
    80005140:	00149c13          	slli	s8,s1,0x1
    80005144:	009c0c33          	add	s8,s8,s1
    80005148:	003c1c13          	slli	s8,s8,0x3
    8000514c:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005150:	ffffe097          	auipc	ra,0xffffe
    80005154:	90c080e7          	jalr	-1780(ra) # 80002a5c <_ZN6ThreadC1Ev>
    80005158:	00006797          	auipc	a5,0x6
    8000515c:	60878793          	addi	a5,a5,1544 # 8000b760 <_ZTV16ProducerKeyboard+0x10>
    80005160:	00fcb023          	sd	a5,0(s9)
    80005164:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005168:	00349793          	slli	a5,s1,0x3
    8000516c:	00f987b3          	add	a5,s3,a5
    80005170:	0197b023          	sd	s9,0(a5)
    80005174:	f4dff06f          	j	800050c0 <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    80005178:	ffffe097          	auipc	ra,0xffffe
    8000517c:	990080e7          	jalr	-1648(ra) # 80002b08 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005180:	00000493          	li	s1,0
    80005184:	00994e63          	blt	s2,s1,800051a0 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    80005188:	0000b517          	auipc	a0,0xb
    8000518c:	96053503          	ld	a0,-1696(a0) # 8000fae8 <waitForAll>
    80005190:	ffffe097          	auipc	ra,0xffffe
    80005194:	83c080e7          	jalr	-1988(ra) # 800029cc <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80005198:	0014849b          	addiw	s1,s1,1
    8000519c:	fe9ff06f          	j	80005184 <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    800051a0:	00000493          	li	s1,0
    800051a4:	0080006f          	j	800051ac <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    800051a8:	0014849b          	addiw	s1,s1,1
    800051ac:	0324d263          	bge	s1,s2,800051d0 <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    800051b0:	00349793          	slli	a5,s1,0x3
    800051b4:	00f987b3          	add	a5,s3,a5
    800051b8:	0007b503          	ld	a0,0(a5)
    800051bc:	fe0506e3          	beqz	a0,800051a8 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    800051c0:	00053783          	ld	a5,0(a0)
    800051c4:	0087b783          	ld	a5,8(a5)
    800051c8:	000780e7          	jalr	a5
    800051cc:	fddff06f          	j	800051a8 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    800051d0:	000b0a63          	beqz	s6,800051e4 <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    800051d4:	000b3783          	ld	a5,0(s6)
    800051d8:	0087b783          	ld	a5,8(a5)
    800051dc:	000b0513          	mv	a0,s6
    800051e0:	000780e7          	jalr	a5
    delete waitForAll;
    800051e4:	0000b517          	auipc	a0,0xb
    800051e8:	90453503          	ld	a0,-1788(a0) # 8000fae8 <waitForAll>
    800051ec:	00050863          	beqz	a0,800051fc <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    800051f0:	00053783          	ld	a5,0(a0)
    800051f4:	0087b783          	ld	a5,8(a5)
    800051f8:	000780e7          	jalr	a5
    delete buffer;
    800051fc:	000a8e63          	beqz	s5,80005218 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    80005200:	000a8513          	mv	a0,s5
    80005204:	fffff097          	auipc	ra,0xfffff
    80005208:	2a0080e7          	jalr	672(ra) # 800044a4 <_ZN9BufferCPPD1Ev>
    8000520c:	000a8513          	mv	a0,s5
    80005210:	ffffd097          	auipc	ra,0xffffd
    80005214:	6dc080e7          	jalr	1756(ra) # 800028ec <_ZdlPv>
    80005218:	000b8113          	mv	sp,s7

}
    8000521c:	f8040113          	addi	sp,s0,-128
    80005220:	07813083          	ld	ra,120(sp)
    80005224:	07013403          	ld	s0,112(sp)
    80005228:	06813483          	ld	s1,104(sp)
    8000522c:	06013903          	ld	s2,96(sp)
    80005230:	05813983          	ld	s3,88(sp)
    80005234:	05013a03          	ld	s4,80(sp)
    80005238:	04813a83          	ld	s5,72(sp)
    8000523c:	04013b03          	ld	s6,64(sp)
    80005240:	03813b83          	ld	s7,56(sp)
    80005244:	03013c03          	ld	s8,48(sp)
    80005248:	02813c83          	ld	s9,40(sp)
    8000524c:	08010113          	addi	sp,sp,128
    80005250:	00008067          	ret
    80005254:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005258:	000a8513          	mv	a0,s5
    8000525c:	ffffd097          	auipc	ra,0xffffd
    80005260:	690080e7          	jalr	1680(ra) # 800028ec <_ZdlPv>
    80005264:	00048513          	mv	a0,s1
    80005268:	0000c097          	auipc	ra,0xc
    8000526c:	960080e7          	jalr	-1696(ra) # 80010bc8 <_Unwind_Resume>
    80005270:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80005274:	00048513          	mv	a0,s1
    80005278:	ffffd097          	auipc	ra,0xffffd
    8000527c:	674080e7          	jalr	1652(ra) # 800028ec <_ZdlPv>
    80005280:	00090513          	mv	a0,s2
    80005284:	0000c097          	auipc	ra,0xc
    80005288:	944080e7          	jalr	-1724(ra) # 80010bc8 <_Unwind_Resume>
    8000528c:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    80005290:	000b0513          	mv	a0,s6
    80005294:	ffffd097          	auipc	ra,0xffffd
    80005298:	658080e7          	jalr	1624(ra) # 800028ec <_ZdlPv>
    8000529c:	00048513          	mv	a0,s1
    800052a0:	0000c097          	auipc	ra,0xc
    800052a4:	928080e7          	jalr	-1752(ra) # 80010bc8 <_Unwind_Resume>
    800052a8:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    800052ac:	000c8513          	mv	a0,s9
    800052b0:	ffffd097          	auipc	ra,0xffffd
    800052b4:	63c080e7          	jalr	1596(ra) # 800028ec <_ZdlPv>
    800052b8:	00048513          	mv	a0,s1
    800052bc:	0000c097          	auipc	ra,0xc
    800052c0:	90c080e7          	jalr	-1780(ra) # 80010bc8 <_Unwind_Resume>
    800052c4:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    800052c8:	000c8513          	mv	a0,s9
    800052cc:	ffffd097          	auipc	ra,0xffffd
    800052d0:	620080e7          	jalr	1568(ra) # 800028ec <_ZdlPv>
    800052d4:	00048513          	mv	a0,s1
    800052d8:	0000c097          	auipc	ra,0xc
    800052dc:	8f0080e7          	jalr	-1808(ra) # 80010bc8 <_Unwind_Resume>

00000000800052e0 <_Z12testSleepingv>:

void testSleeping() {
    800052e0:	fc010113          	addi	sp,sp,-64
    800052e4:	02113c23          	sd	ra,56(sp)
    800052e8:	02813823          	sd	s0,48(sp)
    800052ec:	02913423          	sd	s1,40(sp)
    800052f0:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800052f4:	00a00793          	li	a5,10
    800052f8:	fcf43823          	sd	a5,-48(s0)
    800052fc:	01400793          	li	a5,20
    80005300:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005304:	00000493          	li	s1,0
    80005308:	02c0006f          	j	80005334 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000530c:	00349793          	slli	a5,s1,0x3
    80005310:	fd040613          	addi	a2,s0,-48
    80005314:	00f60633          	add	a2,a2,a5
    80005318:	fffff597          	auipc	a1,0xfffff
    8000531c:	42c58593          	addi	a1,a1,1068 # 80004744 <_Z9sleepyRunPv>
    80005320:	fc040513          	addi	a0,s0,-64
    80005324:	00f50533          	add	a0,a0,a5
    80005328:	ffffc097          	auipc	ra,0xffffc
    8000532c:	e88080e7          	jalr	-376(ra) # 800011b0 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005330:	0014849b          	addiw	s1,s1,1
    80005334:	00100793          	li	a5,1
    80005338:	fc97dae3          	bge	a5,s1,8000530c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    8000533c:	0000a797          	auipc	a5,0xa
    80005340:	7a47c783          	lbu	a5,1956(a5) # 8000fae0 <finished>
    80005344:	fe078ce3          	beqz	a5,8000533c <_Z12testSleepingv+0x5c>
    80005348:	0000a797          	auipc	a5,0xa
    8000534c:	7997c783          	lbu	a5,1945(a5) # 8000fae1 <finished+0x1>
    80005350:	fe0786e3          	beqz	a5,8000533c <_Z12testSleepingv+0x5c>
}
    80005354:	03813083          	ld	ra,56(sp)
    80005358:	03013403          	ld	s0,48(sp)
    8000535c:	02813483          	ld	s1,40(sp)
    80005360:	04010113          	addi	sp,sp,64
    80005364:	00008067          	ret

0000000080005368 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005368:	f8010113          	addi	sp,sp,-128
    8000536c:	06113c23          	sd	ra,120(sp)
    80005370:	06813823          	sd	s0,112(sp)
    80005374:	06913423          	sd	s1,104(sp)
    80005378:	07213023          	sd	s2,96(sp)
    8000537c:	05313c23          	sd	s3,88(sp)
    80005380:	05413823          	sd	s4,80(sp)
    80005384:	05513423          	sd	s5,72(sp)
    80005388:	05613023          	sd	s6,64(sp)
    8000538c:	03713c23          	sd	s7,56(sp)
    80005390:	03813823          	sd	s8,48(sp)
    80005394:	03913423          	sd	s9,40(sp)
    80005398:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000539c:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    800053a0:	00004517          	auipc	a0,0x4
    800053a4:	05850513          	addi	a0,a0,88 # 800093f8 <CONSOLE_STATUS+0x3e8>
    800053a8:	ffffc097          	auipc	ra,0xffffc
    800053ac:	7c8080e7          	jalr	1992(ra) # 80001b70 <_Z11printStringPKc>
        getString(input, 30);
    800053b0:	01e00593          	li	a1,30
    800053b4:	f8040493          	addi	s1,s0,-128
    800053b8:	00048513          	mv	a0,s1
    800053bc:	ffffd097          	auipc	ra,0xffffd
    800053c0:	830080e7          	jalr	-2000(ra) # 80001bec <_Z9getStringPci>
        threadNum = stringToInt(input);
    800053c4:	00048513          	mv	a0,s1
    800053c8:	ffffd097          	auipc	ra,0xffffd
    800053cc:	8f0080e7          	jalr	-1808(ra) # 80001cb8 <_Z11stringToIntPKc>
    800053d0:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    800053d4:	00004517          	auipc	a0,0x4
    800053d8:	04450513          	addi	a0,a0,68 # 80009418 <CONSOLE_STATUS+0x408>
    800053dc:	ffffc097          	auipc	ra,0xffffc
    800053e0:	794080e7          	jalr	1940(ra) # 80001b70 <_Z11printStringPKc>
        getString(input, 30);
    800053e4:	01e00593          	li	a1,30
    800053e8:	00048513          	mv	a0,s1
    800053ec:	ffffd097          	auipc	ra,0xffffd
    800053f0:	800080e7          	jalr	-2048(ra) # 80001bec <_Z9getStringPci>
        n = stringToInt(input);
    800053f4:	00048513          	mv	a0,s1
    800053f8:	ffffd097          	auipc	ra,0xffffd
    800053fc:	8c0080e7          	jalr	-1856(ra) # 80001cb8 <_Z11stringToIntPKc>
    80005400:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80005404:	00004517          	auipc	a0,0x4
    80005408:	03450513          	addi	a0,a0,52 # 80009438 <CONSOLE_STATUS+0x428>
    8000540c:	ffffc097          	auipc	ra,0xffffc
    80005410:	764080e7          	jalr	1892(ra) # 80001b70 <_Z11printStringPKc>
    80005414:	00000613          	li	a2,0
    80005418:	00a00593          	li	a1,10
    8000541c:	00098513          	mv	a0,s3
    80005420:	ffffd097          	auipc	ra,0xffffd
    80005424:	8e8080e7          	jalr	-1816(ra) # 80001d08 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005428:	00004517          	auipc	a0,0x4
    8000542c:	02850513          	addi	a0,a0,40 # 80009450 <CONSOLE_STATUS+0x440>
    80005430:	ffffc097          	auipc	ra,0xffffc
    80005434:	740080e7          	jalr	1856(ra) # 80001b70 <_Z11printStringPKc>
    80005438:	00000613          	li	a2,0
    8000543c:	00a00593          	li	a1,10
    80005440:	00048513          	mv	a0,s1
    80005444:	ffffd097          	auipc	ra,0xffffd
    80005448:	8c4080e7          	jalr	-1852(ra) # 80001d08 <_Z8printIntiii>
        printString(".\n");
    8000544c:	00004517          	auipc	a0,0x4
    80005450:	ce450513          	addi	a0,a0,-796 # 80009130 <CONSOLE_STATUS+0x120>
    80005454:	ffffc097          	auipc	ra,0xffffc
    80005458:	71c080e7          	jalr	1820(ra) # 80001b70 <_Z11printStringPKc>
        if(threadNum > n) {
    8000545c:	0334c463          	blt	s1,s3,80005484 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005460:	03305c63          	blez	s3,80005498 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005464:	03800513          	li	a0,56
    80005468:	ffffd097          	auipc	ra,0xffffd
    8000546c:	434080e7          	jalr	1076(ra) # 8000289c <_Znwm>
    80005470:	00050a93          	mv	s5,a0
    80005474:	00048593          	mv	a1,s1
    80005478:	fffff097          	auipc	ra,0xfffff
    8000547c:	d34080e7          	jalr	-716(ra) # 800041ac <_ZN9BufferCPPC1Ei>
    80005480:	0300006f          	j	800054b0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005484:	00004517          	auipc	a0,0x4
    80005488:	fe450513          	addi	a0,a0,-28 # 80009468 <CONSOLE_STATUS+0x458>
    8000548c:	ffffc097          	auipc	ra,0xffffc
    80005490:	6e4080e7          	jalr	1764(ra) # 80001b70 <_Z11printStringPKc>
            return;
    80005494:	0140006f          	j	800054a8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005498:	00004517          	auipc	a0,0x4
    8000549c:	01050513          	addi	a0,a0,16 # 800094a8 <CONSOLE_STATUS+0x498>
    800054a0:	ffffc097          	auipc	ra,0xffffc
    800054a4:	6d0080e7          	jalr	1744(ra) # 80001b70 <_Z11printStringPKc>
            return;
    800054a8:	000c0113          	mv	sp,s8
    800054ac:	21c0006f          	j	800056c8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    800054b0:	01000513          	li	a0,16
    800054b4:	ffffd097          	auipc	ra,0xffffd
    800054b8:	3e8080e7          	jalr	1000(ra) # 8000289c <_Znwm>
    800054bc:	00050493          	mv	s1,a0
    800054c0:	00000593          	li	a1,0
    800054c4:	ffffd097          	auipc	ra,0xffffd
    800054c8:	4d0080e7          	jalr	1232(ra) # 80002994 <_ZN9SemaphoreC1Ej>
    800054cc:	0000a717          	auipc	a4,0xa
    800054d0:	60c70713          	addi	a4,a4,1548 # 8000fad8 <finishedA>
    800054d4:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    800054d8:	00399793          	slli	a5,s3,0x3
    800054dc:	00f78793          	addi	a5,a5,15
    800054e0:	ff07f793          	andi	a5,a5,-16
    800054e4:	40f10133          	sub	sp,sp,a5
    800054e8:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    800054ec:	0019869b          	addiw	a3,s3,1
    800054f0:	00169793          	slli	a5,a3,0x1
    800054f4:	00d787b3          	add	a5,a5,a3
    800054f8:	00379793          	slli	a5,a5,0x3
    800054fc:	00f78793          	addi	a5,a5,15
    80005500:	ff07f793          	andi	a5,a5,-16
    80005504:	40f10133          	sub	sp,sp,a5
    80005508:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    8000550c:	00199493          	slli	s1,s3,0x1
    80005510:	013484b3          	add	s1,s1,s3
    80005514:	00349493          	slli	s1,s1,0x3
    80005518:	009b04b3          	add	s1,s6,s1
    8000551c:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005520:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005524:	01873783          	ld	a5,24(a4)
    80005528:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000552c:	01800513          	li	a0,24
    80005530:	ffffd097          	auipc	ra,0xffffd
    80005534:	36c080e7          	jalr	876(ra) # 8000289c <_Znwm>
    80005538:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000553c:	ffffd097          	auipc	ra,0xffffd
    80005540:	520080e7          	jalr	1312(ra) # 80002a5c <_ZN6ThreadC1Ev>
    80005544:	00006797          	auipc	a5,0x6
    80005548:	2e478793          	addi	a5,a5,740 # 8000b828 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000554c:	00fbb023          	sd	a5,0(s7)
    80005550:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005554:	000b8513          	mv	a0,s7
    80005558:	ffffd097          	auipc	ra,0xffffd
    8000555c:	5d8080e7          	jalr	1496(ra) # 80002b30 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005560:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005564:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005568:	0000a797          	auipc	a5,0xa
    8000556c:	5887b783          	ld	a5,1416(a5) # 8000faf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005570:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005574:	01800513          	li	a0,24
    80005578:	ffffd097          	auipc	ra,0xffffd
    8000557c:	324080e7          	jalr	804(ra) # 8000289c <_Znwm>
    80005580:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005584:	ffffd097          	auipc	ra,0xffffd
    80005588:	4d8080e7          	jalr	1240(ra) # 80002a5c <_ZN6ThreadC1Ev>
    8000558c:	00006797          	auipc	a5,0x6
    80005590:	24c78793          	addi	a5,a5,588 # 8000b7d8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005594:	00f4b023          	sd	a5,0(s1)
    80005598:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000559c:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    800055a0:	00048513          	mv	a0,s1
    800055a4:	ffffd097          	auipc	ra,0xffffd
    800055a8:	58c080e7          	jalr	1420(ra) # 80002b30 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800055ac:	00100913          	li	s2,1
    800055b0:	0300006f          	j	800055e0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800055b4:	00006797          	auipc	a5,0x6
    800055b8:	24c78793          	addi	a5,a5,588 # 8000b800 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800055bc:	00fcb023          	sd	a5,0(s9)
    800055c0:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    800055c4:	00391793          	slli	a5,s2,0x3
    800055c8:	00fa07b3          	add	a5,s4,a5
    800055cc:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    800055d0:	000c8513          	mv	a0,s9
    800055d4:	ffffd097          	auipc	ra,0xffffd
    800055d8:	55c080e7          	jalr	1372(ra) # 80002b30 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800055dc:	0019091b          	addiw	s2,s2,1
    800055e0:	05395263          	bge	s2,s3,80005624 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    800055e4:	00191493          	slli	s1,s2,0x1
    800055e8:	012484b3          	add	s1,s1,s2
    800055ec:	00349493          	slli	s1,s1,0x3
    800055f0:	009b04b3          	add	s1,s6,s1
    800055f4:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    800055f8:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    800055fc:	0000a797          	auipc	a5,0xa
    80005600:	4f47b783          	ld	a5,1268(a5) # 8000faf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005604:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80005608:	01800513          	li	a0,24
    8000560c:	ffffd097          	auipc	ra,0xffffd
    80005610:	290080e7          	jalr	656(ra) # 8000289c <_Znwm>
    80005614:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005618:	ffffd097          	auipc	ra,0xffffd
    8000561c:	444080e7          	jalr	1092(ra) # 80002a5c <_ZN6ThreadC1Ev>
    80005620:	f95ff06f          	j	800055b4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80005624:	ffffd097          	auipc	ra,0xffffd
    80005628:	4e4080e7          	jalr	1252(ra) # 80002b08 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000562c:	00000493          	li	s1,0
    80005630:	0099ce63          	blt	s3,s1,8000564c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80005634:	0000a517          	auipc	a0,0xa
    80005638:	4bc53503          	ld	a0,1212(a0) # 8000faf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000563c:	ffffd097          	auipc	ra,0xffffd
    80005640:	390080e7          	jalr	912(ra) # 800029cc <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80005644:	0014849b          	addiw	s1,s1,1
    80005648:	fe9ff06f          	j	80005630 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    8000564c:	0000a517          	auipc	a0,0xa
    80005650:	4a453503          	ld	a0,1188(a0) # 8000faf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005654:	00050863          	beqz	a0,80005664 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80005658:	00053783          	ld	a5,0(a0)
    8000565c:	0087b783          	ld	a5,8(a5)
    80005660:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80005664:	00000493          	li	s1,0
    80005668:	0080006f          	j	80005670 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    8000566c:	0014849b          	addiw	s1,s1,1
    80005670:	0334d263          	bge	s1,s3,80005694 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80005674:	00349793          	slli	a5,s1,0x3
    80005678:	00fa07b3          	add	a5,s4,a5
    8000567c:	0007b503          	ld	a0,0(a5)
    80005680:	fe0506e3          	beqz	a0,8000566c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80005684:	00053783          	ld	a5,0(a0)
    80005688:	0087b783          	ld	a5,8(a5)
    8000568c:	000780e7          	jalr	a5
    80005690:	fddff06f          	j	8000566c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    80005694:	000b8a63          	beqz	s7,800056a8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    80005698:	000bb783          	ld	a5,0(s7)
    8000569c:	0087b783          	ld	a5,8(a5)
    800056a0:	000b8513          	mv	a0,s7
    800056a4:	000780e7          	jalr	a5
        delete buffer;
    800056a8:	000a8e63          	beqz	s5,800056c4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    800056ac:	000a8513          	mv	a0,s5
    800056b0:	fffff097          	auipc	ra,0xfffff
    800056b4:	df4080e7          	jalr	-524(ra) # 800044a4 <_ZN9BufferCPPD1Ev>
    800056b8:	000a8513          	mv	a0,s5
    800056bc:	ffffd097          	auipc	ra,0xffffd
    800056c0:	230080e7          	jalr	560(ra) # 800028ec <_ZdlPv>
    800056c4:	000c0113          	mv	sp,s8
    }
    800056c8:	f8040113          	addi	sp,s0,-128
    800056cc:	07813083          	ld	ra,120(sp)
    800056d0:	07013403          	ld	s0,112(sp)
    800056d4:	06813483          	ld	s1,104(sp)
    800056d8:	06013903          	ld	s2,96(sp)
    800056dc:	05813983          	ld	s3,88(sp)
    800056e0:	05013a03          	ld	s4,80(sp)
    800056e4:	04813a83          	ld	s5,72(sp)
    800056e8:	04013b03          	ld	s6,64(sp)
    800056ec:	03813b83          	ld	s7,56(sp)
    800056f0:	03013c03          	ld	s8,48(sp)
    800056f4:	02813c83          	ld	s9,40(sp)
    800056f8:	08010113          	addi	sp,sp,128
    800056fc:	00008067          	ret
    80005700:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80005704:	000a8513          	mv	a0,s5
    80005708:	ffffd097          	auipc	ra,0xffffd
    8000570c:	1e4080e7          	jalr	484(ra) # 800028ec <_ZdlPv>
    80005710:	00048513          	mv	a0,s1
    80005714:	0000b097          	auipc	ra,0xb
    80005718:	4b4080e7          	jalr	1204(ra) # 80010bc8 <_Unwind_Resume>
    8000571c:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80005720:	00048513          	mv	a0,s1
    80005724:	ffffd097          	auipc	ra,0xffffd
    80005728:	1c8080e7          	jalr	456(ra) # 800028ec <_ZdlPv>
    8000572c:	00090513          	mv	a0,s2
    80005730:	0000b097          	auipc	ra,0xb
    80005734:	498080e7          	jalr	1176(ra) # 80010bc8 <_Unwind_Resume>
    80005738:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000573c:	000b8513          	mv	a0,s7
    80005740:	ffffd097          	auipc	ra,0xffffd
    80005744:	1ac080e7          	jalr	428(ra) # 800028ec <_ZdlPv>
    80005748:	00048513          	mv	a0,s1
    8000574c:	0000b097          	auipc	ra,0xb
    80005750:	47c080e7          	jalr	1148(ra) # 80010bc8 <_Unwind_Resume>
    80005754:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005758:	00048513          	mv	a0,s1
    8000575c:	ffffd097          	auipc	ra,0xffffd
    80005760:	190080e7          	jalr	400(ra) # 800028ec <_ZdlPv>
    80005764:	00090513          	mv	a0,s2
    80005768:	0000b097          	auipc	ra,0xb
    8000576c:	460080e7          	jalr	1120(ra) # 80010bc8 <_Unwind_Resume>
    80005770:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80005774:	000c8513          	mv	a0,s9
    80005778:	ffffd097          	auipc	ra,0xffffd
    8000577c:	174080e7          	jalr	372(ra) # 800028ec <_ZdlPv>
    80005780:	00048513          	mv	a0,s1
    80005784:	0000b097          	auipc	ra,0xb
    80005788:	444080e7          	jalr	1092(ra) # 80010bc8 <_Unwind_Resume>

000000008000578c <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    8000578c:	ff010113          	addi	sp,sp,-16
    80005790:	00113423          	sd	ra,8(sp)
    80005794:	00813023          	sd	s0,0(sp)
    80005798:	01010413          	addi	s0,sp,16
    Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    8000579c:	fffff097          	auipc	ra,0xfffff
    800057a0:	388080e7          	jalr	904(ra) # 80004b24 <_Z18Threads_C_API_testv>
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    800057a4:	00813083          	ld	ra,8(sp)
    800057a8:	00013403          	ld	s0,0(sp)
    800057ac:	01010113          	addi	sp,sp,16
    800057b0:	00008067          	ret

00000000800057b4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    800057b4:	fe010113          	addi	sp,sp,-32
    800057b8:	00113c23          	sd	ra,24(sp)
    800057bc:	00813823          	sd	s0,16(sp)
    800057c0:	00913423          	sd	s1,8(sp)
    800057c4:	02010413          	addi	s0,sp,32
    800057c8:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    800057cc:	ffffc097          	auipc	ra,0xffffc
    800057d0:	c38080e7          	jalr	-968(ra) # 80001404 <_Z4getcv>
    800057d4:	0005059b          	sext.w	a1,a0
    800057d8:	01b00793          	li	a5,27
    800057dc:	00f58c63          	beq	a1,a5,800057f4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    800057e0:	0104b783          	ld	a5,16(s1)
    800057e4:	0087b503          	ld	a0,8(a5)
    800057e8:	fffff097          	auipc	ra,0xfffff
    800057ec:	b18080e7          	jalr	-1256(ra) # 80004300 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    800057f0:	fddff06f          	j	800057cc <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    800057f4:	00100793          	li	a5,1
    800057f8:	0000a717          	auipc	a4,0xa
    800057fc:	2ef72223          	sw	a5,740(a4) # 8000fadc <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80005800:	0104b783          	ld	a5,16(s1)
    80005804:	02100593          	li	a1,33
    80005808:	0087b503          	ld	a0,8(a5)
    8000580c:	fffff097          	auipc	ra,0xfffff
    80005810:	af4080e7          	jalr	-1292(ra) # 80004300 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80005814:	0104b783          	ld	a5,16(s1)
    80005818:	0107b503          	ld	a0,16(a5)
    8000581c:	ffffd097          	auipc	ra,0xffffd
    80005820:	1dc080e7          	jalr	476(ra) # 800029f8 <_ZN9Semaphore6signalEv>
        }
    80005824:	01813083          	ld	ra,24(sp)
    80005828:	01013403          	ld	s0,16(sp)
    8000582c:	00813483          	ld	s1,8(sp)
    80005830:	02010113          	addi	sp,sp,32
    80005834:	00008067          	ret

0000000080005838 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80005838:	fd010113          	addi	sp,sp,-48
    8000583c:	02113423          	sd	ra,40(sp)
    80005840:	02813023          	sd	s0,32(sp)
    80005844:	00913c23          	sd	s1,24(sp)
    80005848:	01213823          	sd	s2,16(sp)
    8000584c:	01313423          	sd	s3,8(sp)
    80005850:	03010413          	addi	s0,sp,48
    80005854:	00050913          	mv	s2,a0
            int i = 0;
    80005858:	00000993          	li	s3,0
    8000585c:	0100006f          	j	8000586c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80005860:	00a00513          	li	a0,10
    80005864:	ffffd097          	auipc	ra,0xffffd
    80005868:	390080e7          	jalr	912(ra) # 80002bf4 <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000586c:	0000a797          	auipc	a5,0xa
    80005870:	2707a783          	lw	a5,624(a5) # 8000fadc <_ZN19ConsumerProducerCPP9threadEndE>
    80005874:	04079a63          	bnez	a5,800058c8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80005878:	01093783          	ld	a5,16(s2)
    8000587c:	0087b503          	ld	a0,8(a5)
    80005880:	fffff097          	auipc	ra,0xfffff
    80005884:	b10080e7          	jalr	-1264(ra) # 80004390 <_ZN9BufferCPP3getEv>
                i++;
    80005888:	0019849b          	addiw	s1,s3,1
    8000588c:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80005890:	0ff57513          	andi	a0,a0,255
    80005894:	ffffd097          	auipc	ra,0xffffd
    80005898:	360080e7          	jalr	864(ra) # 80002bf4 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    8000589c:	05000793          	li	a5,80
    800058a0:	02f4e4bb          	remw	s1,s1,a5
    800058a4:	fc0494e3          	bnez	s1,8000586c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800058a8:	fb9ff06f          	j	80005860 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    800058ac:	01093783          	ld	a5,16(s2)
    800058b0:	0087b503          	ld	a0,8(a5)
    800058b4:	fffff097          	auipc	ra,0xfffff
    800058b8:	adc080e7          	jalr	-1316(ra) # 80004390 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    800058bc:	0ff57513          	andi	a0,a0,255
    800058c0:	ffffd097          	auipc	ra,0xffffd
    800058c4:	334080e7          	jalr	820(ra) # 80002bf4 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    800058c8:	01093783          	ld	a5,16(s2)
    800058cc:	0087b503          	ld	a0,8(a5)
    800058d0:	fffff097          	auipc	ra,0xfffff
    800058d4:	b4c080e7          	jalr	-1204(ra) # 8000441c <_ZN9BufferCPP6getCntEv>
    800058d8:	fca04ae3          	bgtz	a0,800058ac <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    800058dc:	01093783          	ld	a5,16(s2)
    800058e0:	0107b503          	ld	a0,16(a5)
    800058e4:	ffffd097          	auipc	ra,0xffffd
    800058e8:	114080e7          	jalr	276(ra) # 800029f8 <_ZN9Semaphore6signalEv>
        }
    800058ec:	02813083          	ld	ra,40(sp)
    800058f0:	02013403          	ld	s0,32(sp)
    800058f4:	01813483          	ld	s1,24(sp)
    800058f8:	01013903          	ld	s2,16(sp)
    800058fc:	00813983          	ld	s3,8(sp)
    80005900:	03010113          	addi	sp,sp,48
    80005904:	00008067          	ret

0000000080005908 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    80005908:	ff010113          	addi	sp,sp,-16
    8000590c:	00113423          	sd	ra,8(sp)
    80005910:	00813023          	sd	s0,0(sp)
    80005914:	01010413          	addi	s0,sp,16
    80005918:	00006797          	auipc	a5,0x6
    8000591c:	e9878793          	addi	a5,a5,-360 # 8000b7b0 <_ZTV8Consumer+0x10>
    80005920:	00f53023          	sd	a5,0(a0)
    80005924:	ffffd097          	auipc	ra,0xffffd
    80005928:	f38080e7          	jalr	-200(ra) # 8000285c <_ZN6ThreadD1Ev>
    8000592c:	00813083          	ld	ra,8(sp)
    80005930:	00013403          	ld	s0,0(sp)
    80005934:	01010113          	addi	sp,sp,16
    80005938:	00008067          	ret

000000008000593c <_ZN8ConsumerD0Ev>:
    8000593c:	fe010113          	addi	sp,sp,-32
    80005940:	00113c23          	sd	ra,24(sp)
    80005944:	00813823          	sd	s0,16(sp)
    80005948:	00913423          	sd	s1,8(sp)
    8000594c:	02010413          	addi	s0,sp,32
    80005950:	00050493          	mv	s1,a0
    80005954:	00006797          	auipc	a5,0x6
    80005958:	e5c78793          	addi	a5,a5,-420 # 8000b7b0 <_ZTV8Consumer+0x10>
    8000595c:	00f53023          	sd	a5,0(a0)
    80005960:	ffffd097          	auipc	ra,0xffffd
    80005964:	efc080e7          	jalr	-260(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005968:	00048513          	mv	a0,s1
    8000596c:	ffffd097          	auipc	ra,0xffffd
    80005970:	f80080e7          	jalr	-128(ra) # 800028ec <_ZdlPv>
    80005974:	01813083          	ld	ra,24(sp)
    80005978:	01013403          	ld	s0,16(sp)
    8000597c:	00813483          	ld	s1,8(sp)
    80005980:	02010113          	addi	sp,sp,32
    80005984:	00008067          	ret

0000000080005988 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80005988:	ff010113          	addi	sp,sp,-16
    8000598c:	00113423          	sd	ra,8(sp)
    80005990:	00813023          	sd	s0,0(sp)
    80005994:	01010413          	addi	s0,sp,16
    80005998:	00006797          	auipc	a5,0x6
    8000599c:	df078793          	addi	a5,a5,-528 # 8000b788 <_ZTV8Producer+0x10>
    800059a0:	00f53023          	sd	a5,0(a0)
    800059a4:	ffffd097          	auipc	ra,0xffffd
    800059a8:	eb8080e7          	jalr	-328(ra) # 8000285c <_ZN6ThreadD1Ev>
    800059ac:	00813083          	ld	ra,8(sp)
    800059b0:	00013403          	ld	s0,0(sp)
    800059b4:	01010113          	addi	sp,sp,16
    800059b8:	00008067          	ret

00000000800059bc <_ZN8ProducerD0Ev>:
    800059bc:	fe010113          	addi	sp,sp,-32
    800059c0:	00113c23          	sd	ra,24(sp)
    800059c4:	00813823          	sd	s0,16(sp)
    800059c8:	00913423          	sd	s1,8(sp)
    800059cc:	02010413          	addi	s0,sp,32
    800059d0:	00050493          	mv	s1,a0
    800059d4:	00006797          	auipc	a5,0x6
    800059d8:	db478793          	addi	a5,a5,-588 # 8000b788 <_ZTV8Producer+0x10>
    800059dc:	00f53023          	sd	a5,0(a0)
    800059e0:	ffffd097          	auipc	ra,0xffffd
    800059e4:	e7c080e7          	jalr	-388(ra) # 8000285c <_ZN6ThreadD1Ev>
    800059e8:	00048513          	mv	a0,s1
    800059ec:	ffffd097          	auipc	ra,0xffffd
    800059f0:	f00080e7          	jalr	-256(ra) # 800028ec <_ZdlPv>
    800059f4:	01813083          	ld	ra,24(sp)
    800059f8:	01013403          	ld	s0,16(sp)
    800059fc:	00813483          	ld	s1,8(sp)
    80005a00:	02010113          	addi	sp,sp,32
    80005a04:	00008067          	ret

0000000080005a08 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80005a08:	ff010113          	addi	sp,sp,-16
    80005a0c:	00113423          	sd	ra,8(sp)
    80005a10:	00813023          	sd	s0,0(sp)
    80005a14:	01010413          	addi	s0,sp,16
    80005a18:	00006797          	auipc	a5,0x6
    80005a1c:	d4878793          	addi	a5,a5,-696 # 8000b760 <_ZTV16ProducerKeyboard+0x10>
    80005a20:	00f53023          	sd	a5,0(a0)
    80005a24:	ffffd097          	auipc	ra,0xffffd
    80005a28:	e38080e7          	jalr	-456(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005a2c:	00813083          	ld	ra,8(sp)
    80005a30:	00013403          	ld	s0,0(sp)
    80005a34:	01010113          	addi	sp,sp,16
    80005a38:	00008067          	ret

0000000080005a3c <_ZN16ProducerKeyboardD0Ev>:
    80005a3c:	fe010113          	addi	sp,sp,-32
    80005a40:	00113c23          	sd	ra,24(sp)
    80005a44:	00813823          	sd	s0,16(sp)
    80005a48:	00913423          	sd	s1,8(sp)
    80005a4c:	02010413          	addi	s0,sp,32
    80005a50:	00050493          	mv	s1,a0
    80005a54:	00006797          	auipc	a5,0x6
    80005a58:	d0c78793          	addi	a5,a5,-756 # 8000b760 <_ZTV16ProducerKeyboard+0x10>
    80005a5c:	00f53023          	sd	a5,0(a0)
    80005a60:	ffffd097          	auipc	ra,0xffffd
    80005a64:	dfc080e7          	jalr	-516(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005a68:	00048513          	mv	a0,s1
    80005a6c:	ffffd097          	auipc	ra,0xffffd
    80005a70:	e80080e7          	jalr	-384(ra) # 800028ec <_ZdlPv>
    80005a74:	01813083          	ld	ra,24(sp)
    80005a78:	01013403          	ld	s0,16(sp)
    80005a7c:	00813483          	ld	s1,8(sp)
    80005a80:	02010113          	addi	sp,sp,32
    80005a84:	00008067          	ret

0000000080005a88 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80005a88:	ff010113          	addi	sp,sp,-16
    80005a8c:	00113423          	sd	ra,8(sp)
    80005a90:	00813023          	sd	s0,0(sp)
    80005a94:	01010413          	addi	s0,sp,16
    80005a98:	00006797          	auipc	a5,0x6
    80005a9c:	d9078793          	addi	a5,a5,-624 # 8000b828 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005aa0:	00f53023          	sd	a5,0(a0)
    80005aa4:	ffffd097          	auipc	ra,0xffffd
    80005aa8:	db8080e7          	jalr	-584(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005aac:	00813083          	ld	ra,8(sp)
    80005ab0:	00013403          	ld	s0,0(sp)
    80005ab4:	01010113          	addi	sp,sp,16
    80005ab8:	00008067          	ret

0000000080005abc <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80005abc:	fe010113          	addi	sp,sp,-32
    80005ac0:	00113c23          	sd	ra,24(sp)
    80005ac4:	00813823          	sd	s0,16(sp)
    80005ac8:	00913423          	sd	s1,8(sp)
    80005acc:	02010413          	addi	s0,sp,32
    80005ad0:	00050493          	mv	s1,a0
    80005ad4:	00006797          	auipc	a5,0x6
    80005ad8:	d5478793          	addi	a5,a5,-684 # 8000b828 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005adc:	00f53023          	sd	a5,0(a0)
    80005ae0:	ffffd097          	auipc	ra,0xffffd
    80005ae4:	d7c080e7          	jalr	-644(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005ae8:	00048513          	mv	a0,s1
    80005aec:	ffffd097          	auipc	ra,0xffffd
    80005af0:	e00080e7          	jalr	-512(ra) # 800028ec <_ZdlPv>
    80005af4:	01813083          	ld	ra,24(sp)
    80005af8:	01013403          	ld	s0,16(sp)
    80005afc:	00813483          	ld	s1,8(sp)
    80005b00:	02010113          	addi	sp,sp,32
    80005b04:	00008067          	ret

0000000080005b08 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80005b08:	ff010113          	addi	sp,sp,-16
    80005b0c:	00113423          	sd	ra,8(sp)
    80005b10:	00813023          	sd	s0,0(sp)
    80005b14:	01010413          	addi	s0,sp,16
    80005b18:	00006797          	auipc	a5,0x6
    80005b1c:	cc078793          	addi	a5,a5,-832 # 8000b7d8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005b20:	00f53023          	sd	a5,0(a0)
    80005b24:	ffffd097          	auipc	ra,0xffffd
    80005b28:	d38080e7          	jalr	-712(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005b2c:	00813083          	ld	ra,8(sp)
    80005b30:	00013403          	ld	s0,0(sp)
    80005b34:	01010113          	addi	sp,sp,16
    80005b38:	00008067          	ret

0000000080005b3c <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80005b3c:	fe010113          	addi	sp,sp,-32
    80005b40:	00113c23          	sd	ra,24(sp)
    80005b44:	00813823          	sd	s0,16(sp)
    80005b48:	00913423          	sd	s1,8(sp)
    80005b4c:	02010413          	addi	s0,sp,32
    80005b50:	00050493          	mv	s1,a0
    80005b54:	00006797          	auipc	a5,0x6
    80005b58:	c8478793          	addi	a5,a5,-892 # 8000b7d8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005b5c:	00f53023          	sd	a5,0(a0)
    80005b60:	ffffd097          	auipc	ra,0xffffd
    80005b64:	cfc080e7          	jalr	-772(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005b68:	00048513          	mv	a0,s1
    80005b6c:	ffffd097          	auipc	ra,0xffffd
    80005b70:	d80080e7          	jalr	-640(ra) # 800028ec <_ZdlPv>
    80005b74:	01813083          	ld	ra,24(sp)
    80005b78:	01013403          	ld	s0,16(sp)
    80005b7c:	00813483          	ld	s1,8(sp)
    80005b80:	02010113          	addi	sp,sp,32
    80005b84:	00008067          	ret

0000000080005b88 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80005b88:	ff010113          	addi	sp,sp,-16
    80005b8c:	00113423          	sd	ra,8(sp)
    80005b90:	00813023          	sd	s0,0(sp)
    80005b94:	01010413          	addi	s0,sp,16
    80005b98:	00006797          	auipc	a5,0x6
    80005b9c:	c6878793          	addi	a5,a5,-920 # 8000b800 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005ba0:	00f53023          	sd	a5,0(a0)
    80005ba4:	ffffd097          	auipc	ra,0xffffd
    80005ba8:	cb8080e7          	jalr	-840(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005bac:	00813083          	ld	ra,8(sp)
    80005bb0:	00013403          	ld	s0,0(sp)
    80005bb4:	01010113          	addi	sp,sp,16
    80005bb8:	00008067          	ret

0000000080005bbc <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80005bbc:	fe010113          	addi	sp,sp,-32
    80005bc0:	00113c23          	sd	ra,24(sp)
    80005bc4:	00813823          	sd	s0,16(sp)
    80005bc8:	00913423          	sd	s1,8(sp)
    80005bcc:	02010413          	addi	s0,sp,32
    80005bd0:	00050493          	mv	s1,a0
    80005bd4:	00006797          	auipc	a5,0x6
    80005bd8:	c2c78793          	addi	a5,a5,-980 # 8000b800 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005bdc:	00f53023          	sd	a5,0(a0)
    80005be0:	ffffd097          	auipc	ra,0xffffd
    80005be4:	c7c080e7          	jalr	-900(ra) # 8000285c <_ZN6ThreadD1Ev>
    80005be8:	00048513          	mv	a0,s1
    80005bec:	ffffd097          	auipc	ra,0xffffd
    80005bf0:	d00080e7          	jalr	-768(ra) # 800028ec <_ZdlPv>
    80005bf4:	01813083          	ld	ra,24(sp)
    80005bf8:	01013403          	ld	s0,16(sp)
    80005bfc:	00813483          	ld	s1,8(sp)
    80005c00:	02010113          	addi	sp,sp,32
    80005c04:	00008067          	ret

0000000080005c08 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80005c08:	fe010113          	addi	sp,sp,-32
    80005c0c:	00113c23          	sd	ra,24(sp)
    80005c10:	00813823          	sd	s0,16(sp)
    80005c14:	00913423          	sd	s1,8(sp)
    80005c18:	01213023          	sd	s2,0(sp)
    80005c1c:	02010413          	addi	s0,sp,32
    80005c20:	00050493          	mv	s1,a0
            int i = 0;
    80005c24:	00000913          	li	s2,0
            while (!threadEnd) {
    80005c28:	0000a797          	auipc	a5,0xa
    80005c2c:	eb47a783          	lw	a5,-332(a5) # 8000fadc <_ZN19ConsumerProducerCPP9threadEndE>
    80005c30:	04079263          	bnez	a5,80005c74 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80005c34:	0104b783          	ld	a5,16(s1)
    80005c38:	0007a583          	lw	a1,0(a5)
    80005c3c:	0305859b          	addiw	a1,a1,48
    80005c40:	0087b503          	ld	a0,8(a5)
    80005c44:	ffffe097          	auipc	ra,0xffffe
    80005c48:	6bc080e7          	jalr	1724(ra) # 80004300 <_ZN9BufferCPP3putEi>
                i++;
    80005c4c:	0019071b          	addiw	a4,s2,1
    80005c50:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80005c54:	0104b783          	ld	a5,16(s1)
    80005c58:	0007a783          	lw	a5,0(a5)
    80005c5c:	00e787bb          	addw	a5,a5,a4
    80005c60:	00500513          	li	a0,5
    80005c64:	02a7e53b          	remw	a0,a5,a0
    80005c68:	ffffd097          	auipc	ra,0xffffd
    80005c6c:	e38080e7          	jalr	-456(ra) # 80002aa0 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80005c70:	fb9ff06f          	j	80005c28 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80005c74:	0104b783          	ld	a5,16(s1)
    80005c78:	0107b503          	ld	a0,16(a5)
    80005c7c:	ffffd097          	auipc	ra,0xffffd
    80005c80:	d7c080e7          	jalr	-644(ra) # 800029f8 <_ZN9Semaphore6signalEv>
        }
    80005c84:	01813083          	ld	ra,24(sp)
    80005c88:	01013403          	ld	s0,16(sp)
    80005c8c:	00813483          	ld	s1,8(sp)
    80005c90:	00013903          	ld	s2,0(sp)
    80005c94:	02010113          	addi	sp,sp,32
    80005c98:	00008067          	ret

0000000080005c9c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80005c9c:	ff010113          	addi	sp,sp,-16
    80005ca0:	00113423          	sd	ra,8(sp)
    80005ca4:	00813023          	sd	s0,0(sp)
    80005ca8:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80005cac:	01053583          	ld	a1,16(a0)
    80005cb0:	fffff097          	auipc	ra,0xfffff
    80005cb4:	fa0080e7          	jalr	-96(ra) # 80004c50 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80005cb8:	00813083          	ld	ra,8(sp)
    80005cbc:	00013403          	ld	s0,0(sp)
    80005cc0:	01010113          	addi	sp,sp,16
    80005cc4:	00008067          	ret

0000000080005cc8 <_ZN8Producer3runEv>:
    void run() override {
    80005cc8:	ff010113          	addi	sp,sp,-16
    80005ccc:	00113423          	sd	ra,8(sp)
    80005cd0:	00813023          	sd	s0,0(sp)
    80005cd4:	01010413          	addi	s0,sp,16
        producer(td);
    80005cd8:	01053583          	ld	a1,16(a0)
    80005cdc:	fffff097          	auipc	ra,0xfffff
    80005ce0:	034080e7          	jalr	52(ra) # 80004d10 <_ZN8Producer8producerEPv>
    }
    80005ce4:	00813083          	ld	ra,8(sp)
    80005ce8:	00013403          	ld	s0,0(sp)
    80005cec:	01010113          	addi	sp,sp,16
    80005cf0:	00008067          	ret

0000000080005cf4 <_ZN8Consumer3runEv>:
    void run() override {
    80005cf4:	ff010113          	addi	sp,sp,-16
    80005cf8:	00113423          	sd	ra,8(sp)
    80005cfc:	00813023          	sd	s0,0(sp)
    80005d00:	01010413          	addi	s0,sp,16
        consumer(td);
    80005d04:	01053583          	ld	a1,16(a0)
    80005d08:	fffff097          	auipc	ra,0xfffff
    80005d0c:	09c080e7          	jalr	156(ra) # 80004da4 <_ZN8Consumer8consumerEPv>
    }
    80005d10:	00813083          	ld	ra,8(sp)
    80005d14:	00013403          	ld	s0,0(sp)
    80005d18:	01010113          	addi	sp,sp,16
    80005d1c:	00008067          	ret

0000000080005d20 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005d20:	fe010113          	addi	sp,sp,-32
    80005d24:	00113c23          	sd	ra,24(sp)
    80005d28:	00813823          	sd	s0,16(sp)
    80005d2c:	00913423          	sd	s1,8(sp)
    80005d30:	01213023          	sd	s2,0(sp)
    80005d34:	02010413          	addi	s0,sp,32
    80005d38:	00050493          	mv	s1,a0
    80005d3c:	00058913          	mv	s2,a1
    80005d40:	0015879b          	addiw	a5,a1,1
    80005d44:	0007851b          	sext.w	a0,a5
    80005d48:	00f4a023          	sw	a5,0(s1)
    80005d4c:	0004a823          	sw	zero,16(s1)
    80005d50:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005d54:	00251513          	slli	a0,a0,0x2
    80005d58:	ffffb097          	auipc	ra,0xffffb
    80005d5c:	3fc080e7          	jalr	1020(ra) # 80001154 <_Z9mem_allocm>
    80005d60:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80005d64:	00000593          	li	a1,0
    80005d68:	02048513          	addi	a0,s1,32
    80005d6c:	ffffb097          	auipc	ra,0xffffb
    80005d70:	5b0080e7          	jalr	1456(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80005d74:	00090593          	mv	a1,s2
    80005d78:	01848513          	addi	a0,s1,24
    80005d7c:	ffffb097          	auipc	ra,0xffffb
    80005d80:	5a0080e7          	jalr	1440(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80005d84:	00100593          	li	a1,1
    80005d88:	02848513          	addi	a0,s1,40
    80005d8c:	ffffb097          	auipc	ra,0xffffb
    80005d90:	590080e7          	jalr	1424(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80005d94:	00100593          	li	a1,1
    80005d98:	03048513          	addi	a0,s1,48
    80005d9c:	ffffb097          	auipc	ra,0xffffb
    80005da0:	580080e7          	jalr	1408(ra) # 8000131c <_Z8sem_openPP10_semaphorej>
}
    80005da4:	01813083          	ld	ra,24(sp)
    80005da8:	01013403          	ld	s0,16(sp)
    80005dac:	00813483          	ld	s1,8(sp)
    80005db0:	00013903          	ld	s2,0(sp)
    80005db4:	02010113          	addi	sp,sp,32
    80005db8:	00008067          	ret

0000000080005dbc <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80005dbc:	fe010113          	addi	sp,sp,-32
    80005dc0:	00113c23          	sd	ra,24(sp)
    80005dc4:	00813823          	sd	s0,16(sp)
    80005dc8:	00913423          	sd	s1,8(sp)
    80005dcc:	01213023          	sd	s2,0(sp)
    80005dd0:	02010413          	addi	s0,sp,32
    80005dd4:	00050493          	mv	s1,a0
    80005dd8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80005ddc:	01853503          	ld	a0,24(a0)
    80005de0:	ffffb097          	auipc	ra,0xffffb
    80005de4:	5a0080e7          	jalr	1440(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80005de8:	0304b503          	ld	a0,48(s1)
    80005dec:	ffffb097          	auipc	ra,0xffffb
    80005df0:	594080e7          	jalr	1428(ra) # 80001380 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80005df4:	0084b783          	ld	a5,8(s1)
    80005df8:	0144a703          	lw	a4,20(s1)
    80005dfc:	00271713          	slli	a4,a4,0x2
    80005e00:	00e787b3          	add	a5,a5,a4
    80005e04:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005e08:	0144a783          	lw	a5,20(s1)
    80005e0c:	0017879b          	addiw	a5,a5,1
    80005e10:	0004a703          	lw	a4,0(s1)
    80005e14:	02e7e7bb          	remw	a5,a5,a4
    80005e18:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80005e1c:	0304b503          	ld	a0,48(s1)
    80005e20:	ffffb097          	auipc	ra,0xffffb
    80005e24:	58c080e7          	jalr	1420(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80005e28:	0204b503          	ld	a0,32(s1)
    80005e2c:	ffffb097          	auipc	ra,0xffffb
    80005e30:	580080e7          	jalr	1408(ra) # 800013ac <_Z10sem_signalP10_semaphore>

}
    80005e34:	01813083          	ld	ra,24(sp)
    80005e38:	01013403          	ld	s0,16(sp)
    80005e3c:	00813483          	ld	s1,8(sp)
    80005e40:	00013903          	ld	s2,0(sp)
    80005e44:	02010113          	addi	sp,sp,32
    80005e48:	00008067          	ret

0000000080005e4c <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005e4c:	fe010113          	addi	sp,sp,-32
    80005e50:	00113c23          	sd	ra,24(sp)
    80005e54:	00813823          	sd	s0,16(sp)
    80005e58:	00913423          	sd	s1,8(sp)
    80005e5c:	01213023          	sd	s2,0(sp)
    80005e60:	02010413          	addi	s0,sp,32
    80005e64:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005e68:	02053503          	ld	a0,32(a0)
    80005e6c:	ffffb097          	auipc	ra,0xffffb
    80005e70:	514080e7          	jalr	1300(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80005e74:	0284b503          	ld	a0,40(s1)
    80005e78:	ffffb097          	auipc	ra,0xffffb
    80005e7c:	508080e7          	jalr	1288(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80005e80:	0084b703          	ld	a4,8(s1)
    80005e84:	0104a783          	lw	a5,16(s1)
    80005e88:	00279693          	slli	a3,a5,0x2
    80005e8c:	00d70733          	add	a4,a4,a3
    80005e90:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005e94:	0017879b          	addiw	a5,a5,1
    80005e98:	0004a703          	lw	a4,0(s1)
    80005e9c:	02e7e7bb          	remw	a5,a5,a4
    80005ea0:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005ea4:	0284b503          	ld	a0,40(s1)
    80005ea8:	ffffb097          	auipc	ra,0xffffb
    80005eac:	504080e7          	jalr	1284(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80005eb0:	0184b503          	ld	a0,24(s1)
    80005eb4:	ffffb097          	auipc	ra,0xffffb
    80005eb8:	4f8080e7          	jalr	1272(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80005ebc:	00090513          	mv	a0,s2
    80005ec0:	01813083          	ld	ra,24(sp)
    80005ec4:	01013403          	ld	s0,16(sp)
    80005ec8:	00813483          	ld	s1,8(sp)
    80005ecc:	00013903          	ld	s2,0(sp)
    80005ed0:	02010113          	addi	sp,sp,32
    80005ed4:	00008067          	ret

0000000080005ed8 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80005ed8:	fe010113          	addi	sp,sp,-32
    80005edc:	00113c23          	sd	ra,24(sp)
    80005ee0:	00813823          	sd	s0,16(sp)
    80005ee4:	00913423          	sd	s1,8(sp)
    80005ee8:	01213023          	sd	s2,0(sp)
    80005eec:	02010413          	addi	s0,sp,32
    80005ef0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80005ef4:	02853503          	ld	a0,40(a0)
    80005ef8:	ffffb097          	auipc	ra,0xffffb
    80005efc:	488080e7          	jalr	1160(ra) # 80001380 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80005f00:	0304b503          	ld	a0,48(s1)
    80005f04:	ffffb097          	auipc	ra,0xffffb
    80005f08:	47c080e7          	jalr	1148(ra) # 80001380 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80005f0c:	0144a783          	lw	a5,20(s1)
    80005f10:	0104a903          	lw	s2,16(s1)
    80005f14:	0327ce63          	blt	a5,s2,80005f50 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80005f18:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80005f1c:	0304b503          	ld	a0,48(s1)
    80005f20:	ffffb097          	auipc	ra,0xffffb
    80005f24:	48c080e7          	jalr	1164(ra) # 800013ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80005f28:	0284b503          	ld	a0,40(s1)
    80005f2c:	ffffb097          	auipc	ra,0xffffb
    80005f30:	480080e7          	jalr	1152(ra) # 800013ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80005f34:	00090513          	mv	a0,s2
    80005f38:	01813083          	ld	ra,24(sp)
    80005f3c:	01013403          	ld	s0,16(sp)
    80005f40:	00813483          	ld	s1,8(sp)
    80005f44:	00013903          	ld	s2,0(sp)
    80005f48:	02010113          	addi	sp,sp,32
    80005f4c:	00008067          	ret
        ret = cap - head + tail;
    80005f50:	0004a703          	lw	a4,0(s1)
    80005f54:	4127093b          	subw	s2,a4,s2
    80005f58:	00f9093b          	addw	s2,s2,a5
    80005f5c:	fc1ff06f          	j	80005f1c <_ZN6Buffer6getCntEv+0x44>

0000000080005f60 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005f60:	fe010113          	addi	sp,sp,-32
    80005f64:	00113c23          	sd	ra,24(sp)
    80005f68:	00813823          	sd	s0,16(sp)
    80005f6c:	00913423          	sd	s1,8(sp)
    80005f70:	02010413          	addi	s0,sp,32
    80005f74:	00050493          	mv	s1,a0
    putc('\n');
    80005f78:	00a00513          	li	a0,10
    80005f7c:	ffffb097          	auipc	ra,0xffffb
    80005f80:	4b0080e7          	jalr	1200(ra) # 8000142c <_Z4putcc>
    printString("Buffer deleted!\n");
    80005f84:	00003517          	auipc	a0,0x3
    80005f88:	35450513          	addi	a0,a0,852 # 800092d8 <CONSOLE_STATUS+0x2c8>
    80005f8c:	ffffc097          	auipc	ra,0xffffc
    80005f90:	be4080e7          	jalr	-1052(ra) # 80001b70 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005f94:	00048513          	mv	a0,s1
    80005f98:	00000097          	auipc	ra,0x0
    80005f9c:	f40080e7          	jalr	-192(ra) # 80005ed8 <_ZN6Buffer6getCntEv>
    80005fa0:	02a05c63          	blez	a0,80005fd8 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005fa4:	0084b783          	ld	a5,8(s1)
    80005fa8:	0104a703          	lw	a4,16(s1)
    80005fac:	00271713          	slli	a4,a4,0x2
    80005fb0:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005fb4:	0007c503          	lbu	a0,0(a5)
    80005fb8:	ffffb097          	auipc	ra,0xffffb
    80005fbc:	474080e7          	jalr	1140(ra) # 8000142c <_Z4putcc>
        head = (head + 1) % cap;
    80005fc0:	0104a783          	lw	a5,16(s1)
    80005fc4:	0017879b          	addiw	a5,a5,1
    80005fc8:	0004a703          	lw	a4,0(s1)
    80005fcc:	02e7e7bb          	remw	a5,a5,a4
    80005fd0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005fd4:	fc1ff06f          	j	80005f94 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005fd8:	02100513          	li	a0,33
    80005fdc:	ffffb097          	auipc	ra,0xffffb
    80005fe0:	450080e7          	jalr	1104(ra) # 8000142c <_Z4putcc>
    putc('\n');
    80005fe4:	00a00513          	li	a0,10
    80005fe8:	ffffb097          	auipc	ra,0xffffb
    80005fec:	444080e7          	jalr	1092(ra) # 8000142c <_Z4putcc>
    mem_free(buffer);
    80005ff0:	0084b503          	ld	a0,8(s1)
    80005ff4:	ffffb097          	auipc	ra,0xffffb
    80005ff8:	190080e7          	jalr	400(ra) # 80001184 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80005ffc:	0204b503          	ld	a0,32(s1)
    80006000:	ffffb097          	auipc	ra,0xffffb
    80006004:	354080e7          	jalr	852(ra) # 80001354 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006008:	0184b503          	ld	a0,24(s1)
    8000600c:	ffffb097          	auipc	ra,0xffffb
    80006010:	348080e7          	jalr	840(ra) # 80001354 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80006014:	0304b503          	ld	a0,48(s1)
    80006018:	ffffb097          	auipc	ra,0xffffb
    8000601c:	33c080e7          	jalr	828(ra) # 80001354 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006020:	0284b503          	ld	a0,40(s1)
    80006024:	ffffb097          	auipc	ra,0xffffb
    80006028:	330080e7          	jalr	816(ra) # 80001354 <_Z9sem_closeP10_semaphore>
}
    8000602c:	01813083          	ld	ra,24(sp)
    80006030:	01013403          	ld	s0,16(sp)
    80006034:	00813483          	ld	s1,8(sp)
    80006038:	02010113          	addi	sp,sp,32
    8000603c:	00008067          	ret

0000000080006040 <start>:
    80006040:	ff010113          	addi	sp,sp,-16
    80006044:	00813423          	sd	s0,8(sp)
    80006048:	01010413          	addi	s0,sp,16
    8000604c:	300027f3          	csrr	a5,mstatus
    80006050:	ffffe737          	lui	a4,0xffffe
    80006054:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffeda9f>
    80006058:	00e7f7b3          	and	a5,a5,a4
    8000605c:	00001737          	lui	a4,0x1
    80006060:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006064:	00e7e7b3          	or	a5,a5,a4
    80006068:	30079073          	csrw	mstatus,a5
    8000606c:	00000797          	auipc	a5,0x0
    80006070:	16078793          	addi	a5,a5,352 # 800061cc <system_main>
    80006074:	34179073          	csrw	mepc,a5
    80006078:	00000793          	li	a5,0
    8000607c:	18079073          	csrw	satp,a5
    80006080:	000107b7          	lui	a5,0x10
    80006084:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006088:	30279073          	csrw	medeleg,a5
    8000608c:	30379073          	csrw	mideleg,a5
    80006090:	104027f3          	csrr	a5,sie
    80006094:	2227e793          	ori	a5,a5,546
    80006098:	10479073          	csrw	sie,a5
    8000609c:	fff00793          	li	a5,-1
    800060a0:	00a7d793          	srli	a5,a5,0xa
    800060a4:	3b079073          	csrw	pmpaddr0,a5
    800060a8:	00f00793          	li	a5,15
    800060ac:	3a079073          	csrw	pmpcfg0,a5
    800060b0:	f14027f3          	csrr	a5,mhartid
    800060b4:	0200c737          	lui	a4,0x200c
    800060b8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800060bc:	0007869b          	sext.w	a3,a5
    800060c0:	00269713          	slli	a4,a3,0x2
    800060c4:	000f4637          	lui	a2,0xf4
    800060c8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800060cc:	00d70733          	add	a4,a4,a3
    800060d0:	0037979b          	slliw	a5,a5,0x3
    800060d4:	020046b7          	lui	a3,0x2004
    800060d8:	00d787b3          	add	a5,a5,a3
    800060dc:	00c585b3          	add	a1,a1,a2
    800060e0:	00371693          	slli	a3,a4,0x3
    800060e4:	0000a717          	auipc	a4,0xa
    800060e8:	a1c70713          	addi	a4,a4,-1508 # 8000fb00 <timer_scratch>
    800060ec:	00b7b023          	sd	a1,0(a5)
    800060f0:	00d70733          	add	a4,a4,a3
    800060f4:	00f73c23          	sd	a5,24(a4)
    800060f8:	02c73023          	sd	a2,32(a4)
    800060fc:	34071073          	csrw	mscratch,a4
    80006100:	00000797          	auipc	a5,0x0
    80006104:	6e078793          	addi	a5,a5,1760 # 800067e0 <timervec>
    80006108:	30579073          	csrw	mtvec,a5
    8000610c:	300027f3          	csrr	a5,mstatus
    80006110:	0087e793          	ori	a5,a5,8
    80006114:	30079073          	csrw	mstatus,a5
    80006118:	304027f3          	csrr	a5,mie
    8000611c:	0807e793          	ori	a5,a5,128
    80006120:	30479073          	csrw	mie,a5
    80006124:	f14027f3          	csrr	a5,mhartid
    80006128:	0007879b          	sext.w	a5,a5
    8000612c:	00078213          	mv	tp,a5
    80006130:	30200073          	mret
    80006134:	00813403          	ld	s0,8(sp)
    80006138:	01010113          	addi	sp,sp,16
    8000613c:	00008067          	ret

0000000080006140 <timerinit>:
    80006140:	ff010113          	addi	sp,sp,-16
    80006144:	00813423          	sd	s0,8(sp)
    80006148:	01010413          	addi	s0,sp,16
    8000614c:	f14027f3          	csrr	a5,mhartid
    80006150:	0200c737          	lui	a4,0x200c
    80006154:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006158:	0007869b          	sext.w	a3,a5
    8000615c:	00269713          	slli	a4,a3,0x2
    80006160:	000f4637          	lui	a2,0xf4
    80006164:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006168:	00d70733          	add	a4,a4,a3
    8000616c:	0037979b          	slliw	a5,a5,0x3
    80006170:	020046b7          	lui	a3,0x2004
    80006174:	00d787b3          	add	a5,a5,a3
    80006178:	00c585b3          	add	a1,a1,a2
    8000617c:	00371693          	slli	a3,a4,0x3
    80006180:	0000a717          	auipc	a4,0xa
    80006184:	98070713          	addi	a4,a4,-1664 # 8000fb00 <timer_scratch>
    80006188:	00b7b023          	sd	a1,0(a5)
    8000618c:	00d70733          	add	a4,a4,a3
    80006190:	00f73c23          	sd	a5,24(a4)
    80006194:	02c73023          	sd	a2,32(a4)
    80006198:	34071073          	csrw	mscratch,a4
    8000619c:	00000797          	auipc	a5,0x0
    800061a0:	64478793          	addi	a5,a5,1604 # 800067e0 <timervec>
    800061a4:	30579073          	csrw	mtvec,a5
    800061a8:	300027f3          	csrr	a5,mstatus
    800061ac:	0087e793          	ori	a5,a5,8
    800061b0:	30079073          	csrw	mstatus,a5
    800061b4:	304027f3          	csrr	a5,mie
    800061b8:	0807e793          	ori	a5,a5,128
    800061bc:	30479073          	csrw	mie,a5
    800061c0:	00813403          	ld	s0,8(sp)
    800061c4:	01010113          	addi	sp,sp,16
    800061c8:	00008067          	ret

00000000800061cc <system_main>:
    800061cc:	fe010113          	addi	sp,sp,-32
    800061d0:	00813823          	sd	s0,16(sp)
    800061d4:	00913423          	sd	s1,8(sp)
    800061d8:	00113c23          	sd	ra,24(sp)
    800061dc:	02010413          	addi	s0,sp,32
    800061e0:	00000097          	auipc	ra,0x0
    800061e4:	0c4080e7          	jalr	196(ra) # 800062a4 <cpuid>
    800061e8:	00005497          	auipc	s1,0x5
    800061ec:	71848493          	addi	s1,s1,1816 # 8000b900 <started>
    800061f0:	02050263          	beqz	a0,80006214 <system_main+0x48>
    800061f4:	0004a783          	lw	a5,0(s1)
    800061f8:	0007879b          	sext.w	a5,a5
    800061fc:	fe078ce3          	beqz	a5,800061f4 <system_main+0x28>
    80006200:	0ff0000f          	fence
    80006204:	00003517          	auipc	a0,0x3
    80006208:	30450513          	addi	a0,a0,772 # 80009508 <CONSOLE_STATUS+0x4f8>
    8000620c:	00001097          	auipc	ra,0x1
    80006210:	a70080e7          	jalr	-1424(ra) # 80006c7c <panic>
    80006214:	00001097          	auipc	ra,0x1
    80006218:	9c4080e7          	jalr	-1596(ra) # 80006bd8 <consoleinit>
    8000621c:	00001097          	auipc	ra,0x1
    80006220:	150080e7          	jalr	336(ra) # 8000736c <printfinit>
    80006224:	00003517          	auipc	a0,0x3
    80006228:	ea450513          	addi	a0,a0,-348 # 800090c8 <CONSOLE_STATUS+0xb8>
    8000622c:	00001097          	auipc	ra,0x1
    80006230:	aac080e7          	jalr	-1364(ra) # 80006cd8 <__printf>
    80006234:	00003517          	auipc	a0,0x3
    80006238:	2a450513          	addi	a0,a0,676 # 800094d8 <CONSOLE_STATUS+0x4c8>
    8000623c:	00001097          	auipc	ra,0x1
    80006240:	a9c080e7          	jalr	-1380(ra) # 80006cd8 <__printf>
    80006244:	00003517          	auipc	a0,0x3
    80006248:	e8450513          	addi	a0,a0,-380 # 800090c8 <CONSOLE_STATUS+0xb8>
    8000624c:	00001097          	auipc	ra,0x1
    80006250:	a8c080e7          	jalr	-1396(ra) # 80006cd8 <__printf>
    80006254:	00001097          	auipc	ra,0x1
    80006258:	4a4080e7          	jalr	1188(ra) # 800076f8 <kinit>
    8000625c:	00000097          	auipc	ra,0x0
    80006260:	148080e7          	jalr	328(ra) # 800063a4 <trapinit>
    80006264:	00000097          	auipc	ra,0x0
    80006268:	16c080e7          	jalr	364(ra) # 800063d0 <trapinithart>
    8000626c:	00000097          	auipc	ra,0x0
    80006270:	5b4080e7          	jalr	1460(ra) # 80006820 <plicinit>
    80006274:	00000097          	auipc	ra,0x0
    80006278:	5d4080e7          	jalr	1492(ra) # 80006848 <plicinithart>
    8000627c:	00000097          	auipc	ra,0x0
    80006280:	078080e7          	jalr	120(ra) # 800062f4 <userinit>
    80006284:	0ff0000f          	fence
    80006288:	00100793          	li	a5,1
    8000628c:	00003517          	auipc	a0,0x3
    80006290:	26450513          	addi	a0,a0,612 # 800094f0 <CONSOLE_STATUS+0x4e0>
    80006294:	00f4a023          	sw	a5,0(s1)
    80006298:	00001097          	auipc	ra,0x1
    8000629c:	a40080e7          	jalr	-1472(ra) # 80006cd8 <__printf>
    800062a0:	0000006f          	j	800062a0 <system_main+0xd4>

00000000800062a4 <cpuid>:
    800062a4:	ff010113          	addi	sp,sp,-16
    800062a8:	00813423          	sd	s0,8(sp)
    800062ac:	01010413          	addi	s0,sp,16
    800062b0:	00020513          	mv	a0,tp
    800062b4:	00813403          	ld	s0,8(sp)
    800062b8:	0005051b          	sext.w	a0,a0
    800062bc:	01010113          	addi	sp,sp,16
    800062c0:	00008067          	ret

00000000800062c4 <mycpu>:
    800062c4:	ff010113          	addi	sp,sp,-16
    800062c8:	00813423          	sd	s0,8(sp)
    800062cc:	01010413          	addi	s0,sp,16
    800062d0:	00020793          	mv	a5,tp
    800062d4:	00813403          	ld	s0,8(sp)
    800062d8:	0007879b          	sext.w	a5,a5
    800062dc:	00779793          	slli	a5,a5,0x7
    800062e0:	0000b517          	auipc	a0,0xb
    800062e4:	85050513          	addi	a0,a0,-1968 # 80010b30 <cpus>
    800062e8:	00f50533          	add	a0,a0,a5
    800062ec:	01010113          	addi	sp,sp,16
    800062f0:	00008067          	ret

00000000800062f4 <userinit>:
    800062f4:	ff010113          	addi	sp,sp,-16
    800062f8:	00813423          	sd	s0,8(sp)
    800062fc:	01010413          	addi	s0,sp,16
    80006300:	00813403          	ld	s0,8(sp)
    80006304:	01010113          	addi	sp,sp,16
    80006308:	ffffc317          	auipc	t1,0xffffc
    8000630c:	d4c30067          	jr	-692(t1) # 80002054 <main>

0000000080006310 <either_copyout>:
    80006310:	ff010113          	addi	sp,sp,-16
    80006314:	00813023          	sd	s0,0(sp)
    80006318:	00113423          	sd	ra,8(sp)
    8000631c:	01010413          	addi	s0,sp,16
    80006320:	02051663          	bnez	a0,8000634c <either_copyout+0x3c>
    80006324:	00058513          	mv	a0,a1
    80006328:	00060593          	mv	a1,a2
    8000632c:	0006861b          	sext.w	a2,a3
    80006330:	00002097          	auipc	ra,0x2
    80006334:	c54080e7          	jalr	-940(ra) # 80007f84 <__memmove>
    80006338:	00813083          	ld	ra,8(sp)
    8000633c:	00013403          	ld	s0,0(sp)
    80006340:	00000513          	li	a0,0
    80006344:	01010113          	addi	sp,sp,16
    80006348:	00008067          	ret
    8000634c:	00003517          	auipc	a0,0x3
    80006350:	1e450513          	addi	a0,a0,484 # 80009530 <CONSOLE_STATUS+0x520>
    80006354:	00001097          	auipc	ra,0x1
    80006358:	928080e7          	jalr	-1752(ra) # 80006c7c <panic>

000000008000635c <either_copyin>:
    8000635c:	ff010113          	addi	sp,sp,-16
    80006360:	00813023          	sd	s0,0(sp)
    80006364:	00113423          	sd	ra,8(sp)
    80006368:	01010413          	addi	s0,sp,16
    8000636c:	02059463          	bnez	a1,80006394 <either_copyin+0x38>
    80006370:	00060593          	mv	a1,a2
    80006374:	0006861b          	sext.w	a2,a3
    80006378:	00002097          	auipc	ra,0x2
    8000637c:	c0c080e7          	jalr	-1012(ra) # 80007f84 <__memmove>
    80006380:	00813083          	ld	ra,8(sp)
    80006384:	00013403          	ld	s0,0(sp)
    80006388:	00000513          	li	a0,0
    8000638c:	01010113          	addi	sp,sp,16
    80006390:	00008067          	ret
    80006394:	00003517          	auipc	a0,0x3
    80006398:	1c450513          	addi	a0,a0,452 # 80009558 <CONSOLE_STATUS+0x548>
    8000639c:	00001097          	auipc	ra,0x1
    800063a0:	8e0080e7          	jalr	-1824(ra) # 80006c7c <panic>

00000000800063a4 <trapinit>:
    800063a4:	ff010113          	addi	sp,sp,-16
    800063a8:	00813423          	sd	s0,8(sp)
    800063ac:	01010413          	addi	s0,sp,16
    800063b0:	00813403          	ld	s0,8(sp)
    800063b4:	00003597          	auipc	a1,0x3
    800063b8:	1cc58593          	addi	a1,a1,460 # 80009580 <CONSOLE_STATUS+0x570>
    800063bc:	0000a517          	auipc	a0,0xa
    800063c0:	7f450513          	addi	a0,a0,2036 # 80010bb0 <tickslock>
    800063c4:	01010113          	addi	sp,sp,16
    800063c8:	00001317          	auipc	t1,0x1
    800063cc:	5c030067          	jr	1472(t1) # 80007988 <initlock>

00000000800063d0 <trapinithart>:
    800063d0:	ff010113          	addi	sp,sp,-16
    800063d4:	00813423          	sd	s0,8(sp)
    800063d8:	01010413          	addi	s0,sp,16
    800063dc:	00000797          	auipc	a5,0x0
    800063e0:	2f478793          	addi	a5,a5,756 # 800066d0 <kernelvec>
    800063e4:	10579073          	csrw	stvec,a5
    800063e8:	00813403          	ld	s0,8(sp)
    800063ec:	01010113          	addi	sp,sp,16
    800063f0:	00008067          	ret

00000000800063f4 <usertrap>:
    800063f4:	ff010113          	addi	sp,sp,-16
    800063f8:	00813423          	sd	s0,8(sp)
    800063fc:	01010413          	addi	s0,sp,16
    80006400:	00813403          	ld	s0,8(sp)
    80006404:	01010113          	addi	sp,sp,16
    80006408:	00008067          	ret

000000008000640c <usertrapret>:
    8000640c:	ff010113          	addi	sp,sp,-16
    80006410:	00813423          	sd	s0,8(sp)
    80006414:	01010413          	addi	s0,sp,16
    80006418:	00813403          	ld	s0,8(sp)
    8000641c:	01010113          	addi	sp,sp,16
    80006420:	00008067          	ret

0000000080006424 <kerneltrap>:
    80006424:	fe010113          	addi	sp,sp,-32
    80006428:	00813823          	sd	s0,16(sp)
    8000642c:	00113c23          	sd	ra,24(sp)
    80006430:	00913423          	sd	s1,8(sp)
    80006434:	02010413          	addi	s0,sp,32
    80006438:	142025f3          	csrr	a1,scause
    8000643c:	100027f3          	csrr	a5,sstatus
    80006440:	0027f793          	andi	a5,a5,2
    80006444:	10079c63          	bnez	a5,8000655c <kerneltrap+0x138>
    80006448:	142027f3          	csrr	a5,scause
    8000644c:	0207ce63          	bltz	a5,80006488 <kerneltrap+0x64>
    80006450:	00003517          	auipc	a0,0x3
    80006454:	17850513          	addi	a0,a0,376 # 800095c8 <CONSOLE_STATUS+0x5b8>
    80006458:	00001097          	auipc	ra,0x1
    8000645c:	880080e7          	jalr	-1920(ra) # 80006cd8 <__printf>
    80006460:	141025f3          	csrr	a1,sepc
    80006464:	14302673          	csrr	a2,stval
    80006468:	00003517          	auipc	a0,0x3
    8000646c:	17050513          	addi	a0,a0,368 # 800095d8 <CONSOLE_STATUS+0x5c8>
    80006470:	00001097          	auipc	ra,0x1
    80006474:	868080e7          	jalr	-1944(ra) # 80006cd8 <__printf>
    80006478:	00003517          	auipc	a0,0x3
    8000647c:	17850513          	addi	a0,a0,376 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80006480:	00000097          	auipc	ra,0x0
    80006484:	7fc080e7          	jalr	2044(ra) # 80006c7c <panic>
    80006488:	0ff7f713          	andi	a4,a5,255
    8000648c:	00900693          	li	a3,9
    80006490:	04d70063          	beq	a4,a3,800064d0 <kerneltrap+0xac>
    80006494:	fff00713          	li	a4,-1
    80006498:	03f71713          	slli	a4,a4,0x3f
    8000649c:	00170713          	addi	a4,a4,1
    800064a0:	fae798e3          	bne	a5,a4,80006450 <kerneltrap+0x2c>
    800064a4:	00000097          	auipc	ra,0x0
    800064a8:	e00080e7          	jalr	-512(ra) # 800062a4 <cpuid>
    800064ac:	06050663          	beqz	a0,80006518 <kerneltrap+0xf4>
    800064b0:	144027f3          	csrr	a5,sip
    800064b4:	ffd7f793          	andi	a5,a5,-3
    800064b8:	14479073          	csrw	sip,a5
    800064bc:	01813083          	ld	ra,24(sp)
    800064c0:	01013403          	ld	s0,16(sp)
    800064c4:	00813483          	ld	s1,8(sp)
    800064c8:	02010113          	addi	sp,sp,32
    800064cc:	00008067          	ret
    800064d0:	00000097          	auipc	ra,0x0
    800064d4:	3c4080e7          	jalr	964(ra) # 80006894 <plic_claim>
    800064d8:	00a00793          	li	a5,10
    800064dc:	00050493          	mv	s1,a0
    800064e0:	06f50863          	beq	a0,a5,80006550 <kerneltrap+0x12c>
    800064e4:	fc050ce3          	beqz	a0,800064bc <kerneltrap+0x98>
    800064e8:	00050593          	mv	a1,a0
    800064ec:	00003517          	auipc	a0,0x3
    800064f0:	0bc50513          	addi	a0,a0,188 # 800095a8 <CONSOLE_STATUS+0x598>
    800064f4:	00000097          	auipc	ra,0x0
    800064f8:	7e4080e7          	jalr	2020(ra) # 80006cd8 <__printf>
    800064fc:	01013403          	ld	s0,16(sp)
    80006500:	01813083          	ld	ra,24(sp)
    80006504:	00048513          	mv	a0,s1
    80006508:	00813483          	ld	s1,8(sp)
    8000650c:	02010113          	addi	sp,sp,32
    80006510:	00000317          	auipc	t1,0x0
    80006514:	3bc30067          	jr	956(t1) # 800068cc <plic_complete>
    80006518:	0000a517          	auipc	a0,0xa
    8000651c:	69850513          	addi	a0,a0,1688 # 80010bb0 <tickslock>
    80006520:	00001097          	auipc	ra,0x1
    80006524:	48c080e7          	jalr	1164(ra) # 800079ac <acquire>
    80006528:	00005717          	auipc	a4,0x5
    8000652c:	3dc70713          	addi	a4,a4,988 # 8000b904 <ticks>
    80006530:	00072783          	lw	a5,0(a4)
    80006534:	0000a517          	auipc	a0,0xa
    80006538:	67c50513          	addi	a0,a0,1660 # 80010bb0 <tickslock>
    8000653c:	0017879b          	addiw	a5,a5,1
    80006540:	00f72023          	sw	a5,0(a4)
    80006544:	00001097          	auipc	ra,0x1
    80006548:	534080e7          	jalr	1332(ra) # 80007a78 <release>
    8000654c:	f65ff06f          	j	800064b0 <kerneltrap+0x8c>
    80006550:	00001097          	auipc	ra,0x1
    80006554:	090080e7          	jalr	144(ra) # 800075e0 <uartintr>
    80006558:	fa5ff06f          	j	800064fc <kerneltrap+0xd8>
    8000655c:	00003517          	auipc	a0,0x3
    80006560:	02c50513          	addi	a0,a0,44 # 80009588 <CONSOLE_STATUS+0x578>
    80006564:	00000097          	auipc	ra,0x0
    80006568:	718080e7          	jalr	1816(ra) # 80006c7c <panic>

000000008000656c <clockintr>:
    8000656c:	fe010113          	addi	sp,sp,-32
    80006570:	00813823          	sd	s0,16(sp)
    80006574:	00913423          	sd	s1,8(sp)
    80006578:	00113c23          	sd	ra,24(sp)
    8000657c:	02010413          	addi	s0,sp,32
    80006580:	0000a497          	auipc	s1,0xa
    80006584:	63048493          	addi	s1,s1,1584 # 80010bb0 <tickslock>
    80006588:	00048513          	mv	a0,s1
    8000658c:	00001097          	auipc	ra,0x1
    80006590:	420080e7          	jalr	1056(ra) # 800079ac <acquire>
    80006594:	00005717          	auipc	a4,0x5
    80006598:	37070713          	addi	a4,a4,880 # 8000b904 <ticks>
    8000659c:	00072783          	lw	a5,0(a4)
    800065a0:	01013403          	ld	s0,16(sp)
    800065a4:	01813083          	ld	ra,24(sp)
    800065a8:	00048513          	mv	a0,s1
    800065ac:	0017879b          	addiw	a5,a5,1
    800065b0:	00813483          	ld	s1,8(sp)
    800065b4:	00f72023          	sw	a5,0(a4)
    800065b8:	02010113          	addi	sp,sp,32
    800065bc:	00001317          	auipc	t1,0x1
    800065c0:	4bc30067          	jr	1212(t1) # 80007a78 <release>

00000000800065c4 <devintr>:
    800065c4:	142027f3          	csrr	a5,scause
    800065c8:	00000513          	li	a0,0
    800065cc:	0007c463          	bltz	a5,800065d4 <devintr+0x10>
    800065d0:	00008067          	ret
    800065d4:	fe010113          	addi	sp,sp,-32
    800065d8:	00813823          	sd	s0,16(sp)
    800065dc:	00113c23          	sd	ra,24(sp)
    800065e0:	00913423          	sd	s1,8(sp)
    800065e4:	02010413          	addi	s0,sp,32
    800065e8:	0ff7f713          	andi	a4,a5,255
    800065ec:	00900693          	li	a3,9
    800065f0:	04d70c63          	beq	a4,a3,80006648 <devintr+0x84>
    800065f4:	fff00713          	li	a4,-1
    800065f8:	03f71713          	slli	a4,a4,0x3f
    800065fc:	00170713          	addi	a4,a4,1
    80006600:	00e78c63          	beq	a5,a4,80006618 <devintr+0x54>
    80006604:	01813083          	ld	ra,24(sp)
    80006608:	01013403          	ld	s0,16(sp)
    8000660c:	00813483          	ld	s1,8(sp)
    80006610:	02010113          	addi	sp,sp,32
    80006614:	00008067          	ret
    80006618:	00000097          	auipc	ra,0x0
    8000661c:	c8c080e7          	jalr	-884(ra) # 800062a4 <cpuid>
    80006620:	06050663          	beqz	a0,8000668c <devintr+0xc8>
    80006624:	144027f3          	csrr	a5,sip
    80006628:	ffd7f793          	andi	a5,a5,-3
    8000662c:	14479073          	csrw	sip,a5
    80006630:	01813083          	ld	ra,24(sp)
    80006634:	01013403          	ld	s0,16(sp)
    80006638:	00813483          	ld	s1,8(sp)
    8000663c:	00200513          	li	a0,2
    80006640:	02010113          	addi	sp,sp,32
    80006644:	00008067          	ret
    80006648:	00000097          	auipc	ra,0x0
    8000664c:	24c080e7          	jalr	588(ra) # 80006894 <plic_claim>
    80006650:	00a00793          	li	a5,10
    80006654:	00050493          	mv	s1,a0
    80006658:	06f50663          	beq	a0,a5,800066c4 <devintr+0x100>
    8000665c:	00100513          	li	a0,1
    80006660:	fa0482e3          	beqz	s1,80006604 <devintr+0x40>
    80006664:	00048593          	mv	a1,s1
    80006668:	00003517          	auipc	a0,0x3
    8000666c:	f4050513          	addi	a0,a0,-192 # 800095a8 <CONSOLE_STATUS+0x598>
    80006670:	00000097          	auipc	ra,0x0
    80006674:	668080e7          	jalr	1640(ra) # 80006cd8 <__printf>
    80006678:	00048513          	mv	a0,s1
    8000667c:	00000097          	auipc	ra,0x0
    80006680:	250080e7          	jalr	592(ra) # 800068cc <plic_complete>
    80006684:	00100513          	li	a0,1
    80006688:	f7dff06f          	j	80006604 <devintr+0x40>
    8000668c:	0000a517          	auipc	a0,0xa
    80006690:	52450513          	addi	a0,a0,1316 # 80010bb0 <tickslock>
    80006694:	00001097          	auipc	ra,0x1
    80006698:	318080e7          	jalr	792(ra) # 800079ac <acquire>
    8000669c:	00005717          	auipc	a4,0x5
    800066a0:	26870713          	addi	a4,a4,616 # 8000b904 <ticks>
    800066a4:	00072783          	lw	a5,0(a4)
    800066a8:	0000a517          	auipc	a0,0xa
    800066ac:	50850513          	addi	a0,a0,1288 # 80010bb0 <tickslock>
    800066b0:	0017879b          	addiw	a5,a5,1
    800066b4:	00f72023          	sw	a5,0(a4)
    800066b8:	00001097          	auipc	ra,0x1
    800066bc:	3c0080e7          	jalr	960(ra) # 80007a78 <release>
    800066c0:	f65ff06f          	j	80006624 <devintr+0x60>
    800066c4:	00001097          	auipc	ra,0x1
    800066c8:	f1c080e7          	jalr	-228(ra) # 800075e0 <uartintr>
    800066cc:	fadff06f          	j	80006678 <devintr+0xb4>

00000000800066d0 <kernelvec>:
    800066d0:	f0010113          	addi	sp,sp,-256
    800066d4:	00113023          	sd	ra,0(sp)
    800066d8:	00213423          	sd	sp,8(sp)
    800066dc:	00313823          	sd	gp,16(sp)
    800066e0:	00413c23          	sd	tp,24(sp)
    800066e4:	02513023          	sd	t0,32(sp)
    800066e8:	02613423          	sd	t1,40(sp)
    800066ec:	02713823          	sd	t2,48(sp)
    800066f0:	02813c23          	sd	s0,56(sp)
    800066f4:	04913023          	sd	s1,64(sp)
    800066f8:	04a13423          	sd	a0,72(sp)
    800066fc:	04b13823          	sd	a1,80(sp)
    80006700:	04c13c23          	sd	a2,88(sp)
    80006704:	06d13023          	sd	a3,96(sp)
    80006708:	06e13423          	sd	a4,104(sp)
    8000670c:	06f13823          	sd	a5,112(sp)
    80006710:	07013c23          	sd	a6,120(sp)
    80006714:	09113023          	sd	a7,128(sp)
    80006718:	09213423          	sd	s2,136(sp)
    8000671c:	09313823          	sd	s3,144(sp)
    80006720:	09413c23          	sd	s4,152(sp)
    80006724:	0b513023          	sd	s5,160(sp)
    80006728:	0b613423          	sd	s6,168(sp)
    8000672c:	0b713823          	sd	s7,176(sp)
    80006730:	0b813c23          	sd	s8,184(sp)
    80006734:	0d913023          	sd	s9,192(sp)
    80006738:	0da13423          	sd	s10,200(sp)
    8000673c:	0db13823          	sd	s11,208(sp)
    80006740:	0dc13c23          	sd	t3,216(sp)
    80006744:	0fd13023          	sd	t4,224(sp)
    80006748:	0fe13423          	sd	t5,232(sp)
    8000674c:	0ff13823          	sd	t6,240(sp)
    80006750:	cd5ff0ef          	jal	ra,80006424 <kerneltrap>
    80006754:	00013083          	ld	ra,0(sp)
    80006758:	00813103          	ld	sp,8(sp)
    8000675c:	01013183          	ld	gp,16(sp)
    80006760:	02013283          	ld	t0,32(sp)
    80006764:	02813303          	ld	t1,40(sp)
    80006768:	03013383          	ld	t2,48(sp)
    8000676c:	03813403          	ld	s0,56(sp)
    80006770:	04013483          	ld	s1,64(sp)
    80006774:	04813503          	ld	a0,72(sp)
    80006778:	05013583          	ld	a1,80(sp)
    8000677c:	05813603          	ld	a2,88(sp)
    80006780:	06013683          	ld	a3,96(sp)
    80006784:	06813703          	ld	a4,104(sp)
    80006788:	07013783          	ld	a5,112(sp)
    8000678c:	07813803          	ld	a6,120(sp)
    80006790:	08013883          	ld	a7,128(sp)
    80006794:	08813903          	ld	s2,136(sp)
    80006798:	09013983          	ld	s3,144(sp)
    8000679c:	09813a03          	ld	s4,152(sp)
    800067a0:	0a013a83          	ld	s5,160(sp)
    800067a4:	0a813b03          	ld	s6,168(sp)
    800067a8:	0b013b83          	ld	s7,176(sp)
    800067ac:	0b813c03          	ld	s8,184(sp)
    800067b0:	0c013c83          	ld	s9,192(sp)
    800067b4:	0c813d03          	ld	s10,200(sp)
    800067b8:	0d013d83          	ld	s11,208(sp)
    800067bc:	0d813e03          	ld	t3,216(sp)
    800067c0:	0e013e83          	ld	t4,224(sp)
    800067c4:	0e813f03          	ld	t5,232(sp)
    800067c8:	0f013f83          	ld	t6,240(sp)
    800067cc:	10010113          	addi	sp,sp,256
    800067d0:	10200073          	sret
    800067d4:	00000013          	nop
    800067d8:	00000013          	nop
    800067dc:	00000013          	nop

00000000800067e0 <timervec>:
    800067e0:	34051573          	csrrw	a0,mscratch,a0
    800067e4:	00b53023          	sd	a1,0(a0)
    800067e8:	00c53423          	sd	a2,8(a0)
    800067ec:	00d53823          	sd	a3,16(a0)
    800067f0:	01853583          	ld	a1,24(a0)
    800067f4:	02053603          	ld	a2,32(a0)
    800067f8:	0005b683          	ld	a3,0(a1)
    800067fc:	00c686b3          	add	a3,a3,a2
    80006800:	00d5b023          	sd	a3,0(a1)
    80006804:	00200593          	li	a1,2
    80006808:	14459073          	csrw	sip,a1
    8000680c:	01053683          	ld	a3,16(a0)
    80006810:	00853603          	ld	a2,8(a0)
    80006814:	00053583          	ld	a1,0(a0)
    80006818:	34051573          	csrrw	a0,mscratch,a0
    8000681c:	30200073          	mret

0000000080006820 <plicinit>:
    80006820:	ff010113          	addi	sp,sp,-16
    80006824:	00813423          	sd	s0,8(sp)
    80006828:	01010413          	addi	s0,sp,16
    8000682c:	00813403          	ld	s0,8(sp)
    80006830:	0c0007b7          	lui	a5,0xc000
    80006834:	00100713          	li	a4,1
    80006838:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000683c:	00e7a223          	sw	a4,4(a5)
    80006840:	01010113          	addi	sp,sp,16
    80006844:	00008067          	ret

0000000080006848 <plicinithart>:
    80006848:	ff010113          	addi	sp,sp,-16
    8000684c:	00813023          	sd	s0,0(sp)
    80006850:	00113423          	sd	ra,8(sp)
    80006854:	01010413          	addi	s0,sp,16
    80006858:	00000097          	auipc	ra,0x0
    8000685c:	a4c080e7          	jalr	-1460(ra) # 800062a4 <cpuid>
    80006860:	0085171b          	slliw	a4,a0,0x8
    80006864:	0c0027b7          	lui	a5,0xc002
    80006868:	00e787b3          	add	a5,a5,a4
    8000686c:	40200713          	li	a4,1026
    80006870:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006874:	00813083          	ld	ra,8(sp)
    80006878:	00013403          	ld	s0,0(sp)
    8000687c:	00d5151b          	slliw	a0,a0,0xd
    80006880:	0c2017b7          	lui	a5,0xc201
    80006884:	00a78533          	add	a0,a5,a0
    80006888:	00052023          	sw	zero,0(a0)
    8000688c:	01010113          	addi	sp,sp,16
    80006890:	00008067          	ret

0000000080006894 <plic_claim>:
    80006894:	ff010113          	addi	sp,sp,-16
    80006898:	00813023          	sd	s0,0(sp)
    8000689c:	00113423          	sd	ra,8(sp)
    800068a0:	01010413          	addi	s0,sp,16
    800068a4:	00000097          	auipc	ra,0x0
    800068a8:	a00080e7          	jalr	-1536(ra) # 800062a4 <cpuid>
    800068ac:	00813083          	ld	ra,8(sp)
    800068b0:	00013403          	ld	s0,0(sp)
    800068b4:	00d5151b          	slliw	a0,a0,0xd
    800068b8:	0c2017b7          	lui	a5,0xc201
    800068bc:	00a78533          	add	a0,a5,a0
    800068c0:	00452503          	lw	a0,4(a0)
    800068c4:	01010113          	addi	sp,sp,16
    800068c8:	00008067          	ret

00000000800068cc <plic_complete>:
    800068cc:	fe010113          	addi	sp,sp,-32
    800068d0:	00813823          	sd	s0,16(sp)
    800068d4:	00913423          	sd	s1,8(sp)
    800068d8:	00113c23          	sd	ra,24(sp)
    800068dc:	02010413          	addi	s0,sp,32
    800068e0:	00050493          	mv	s1,a0
    800068e4:	00000097          	auipc	ra,0x0
    800068e8:	9c0080e7          	jalr	-1600(ra) # 800062a4 <cpuid>
    800068ec:	01813083          	ld	ra,24(sp)
    800068f0:	01013403          	ld	s0,16(sp)
    800068f4:	00d5179b          	slliw	a5,a0,0xd
    800068f8:	0c201737          	lui	a4,0xc201
    800068fc:	00f707b3          	add	a5,a4,a5
    80006900:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006904:	00813483          	ld	s1,8(sp)
    80006908:	02010113          	addi	sp,sp,32
    8000690c:	00008067          	ret

0000000080006910 <consolewrite>:
    80006910:	fb010113          	addi	sp,sp,-80
    80006914:	04813023          	sd	s0,64(sp)
    80006918:	04113423          	sd	ra,72(sp)
    8000691c:	02913c23          	sd	s1,56(sp)
    80006920:	03213823          	sd	s2,48(sp)
    80006924:	03313423          	sd	s3,40(sp)
    80006928:	03413023          	sd	s4,32(sp)
    8000692c:	01513c23          	sd	s5,24(sp)
    80006930:	05010413          	addi	s0,sp,80
    80006934:	06c05c63          	blez	a2,800069ac <consolewrite+0x9c>
    80006938:	00060993          	mv	s3,a2
    8000693c:	00050a13          	mv	s4,a0
    80006940:	00058493          	mv	s1,a1
    80006944:	00000913          	li	s2,0
    80006948:	fff00a93          	li	s5,-1
    8000694c:	01c0006f          	j	80006968 <consolewrite+0x58>
    80006950:	fbf44503          	lbu	a0,-65(s0)
    80006954:	0019091b          	addiw	s2,s2,1
    80006958:	00148493          	addi	s1,s1,1
    8000695c:	00001097          	auipc	ra,0x1
    80006960:	a9c080e7          	jalr	-1380(ra) # 800073f8 <uartputc>
    80006964:	03298063          	beq	s3,s2,80006984 <consolewrite+0x74>
    80006968:	00048613          	mv	a2,s1
    8000696c:	00100693          	li	a3,1
    80006970:	000a0593          	mv	a1,s4
    80006974:	fbf40513          	addi	a0,s0,-65
    80006978:	00000097          	auipc	ra,0x0
    8000697c:	9e4080e7          	jalr	-1564(ra) # 8000635c <either_copyin>
    80006980:	fd5518e3          	bne	a0,s5,80006950 <consolewrite+0x40>
    80006984:	04813083          	ld	ra,72(sp)
    80006988:	04013403          	ld	s0,64(sp)
    8000698c:	03813483          	ld	s1,56(sp)
    80006990:	02813983          	ld	s3,40(sp)
    80006994:	02013a03          	ld	s4,32(sp)
    80006998:	01813a83          	ld	s5,24(sp)
    8000699c:	00090513          	mv	a0,s2
    800069a0:	03013903          	ld	s2,48(sp)
    800069a4:	05010113          	addi	sp,sp,80
    800069a8:	00008067          	ret
    800069ac:	00000913          	li	s2,0
    800069b0:	fd5ff06f          	j	80006984 <consolewrite+0x74>

00000000800069b4 <consoleread>:
    800069b4:	f9010113          	addi	sp,sp,-112
    800069b8:	06813023          	sd	s0,96(sp)
    800069bc:	04913c23          	sd	s1,88(sp)
    800069c0:	05213823          	sd	s2,80(sp)
    800069c4:	05313423          	sd	s3,72(sp)
    800069c8:	05413023          	sd	s4,64(sp)
    800069cc:	03513c23          	sd	s5,56(sp)
    800069d0:	03613823          	sd	s6,48(sp)
    800069d4:	03713423          	sd	s7,40(sp)
    800069d8:	03813023          	sd	s8,32(sp)
    800069dc:	06113423          	sd	ra,104(sp)
    800069e0:	01913c23          	sd	s9,24(sp)
    800069e4:	07010413          	addi	s0,sp,112
    800069e8:	00060b93          	mv	s7,a2
    800069ec:	00050913          	mv	s2,a0
    800069f0:	00058c13          	mv	s8,a1
    800069f4:	00060b1b          	sext.w	s6,a2
    800069f8:	0000a497          	auipc	s1,0xa
    800069fc:	1e048493          	addi	s1,s1,480 # 80010bd8 <cons>
    80006a00:	00400993          	li	s3,4
    80006a04:	fff00a13          	li	s4,-1
    80006a08:	00a00a93          	li	s5,10
    80006a0c:	05705e63          	blez	s7,80006a68 <consoleread+0xb4>
    80006a10:	09c4a703          	lw	a4,156(s1)
    80006a14:	0984a783          	lw	a5,152(s1)
    80006a18:	0007071b          	sext.w	a4,a4
    80006a1c:	08e78463          	beq	a5,a4,80006aa4 <consoleread+0xf0>
    80006a20:	07f7f713          	andi	a4,a5,127
    80006a24:	00e48733          	add	a4,s1,a4
    80006a28:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006a2c:	0017869b          	addiw	a3,a5,1
    80006a30:	08d4ac23          	sw	a3,152(s1)
    80006a34:	00070c9b          	sext.w	s9,a4
    80006a38:	0b370663          	beq	a4,s3,80006ae4 <consoleread+0x130>
    80006a3c:	00100693          	li	a3,1
    80006a40:	f9f40613          	addi	a2,s0,-97
    80006a44:	000c0593          	mv	a1,s8
    80006a48:	00090513          	mv	a0,s2
    80006a4c:	f8e40fa3          	sb	a4,-97(s0)
    80006a50:	00000097          	auipc	ra,0x0
    80006a54:	8c0080e7          	jalr	-1856(ra) # 80006310 <either_copyout>
    80006a58:	01450863          	beq	a0,s4,80006a68 <consoleread+0xb4>
    80006a5c:	001c0c13          	addi	s8,s8,1
    80006a60:	fffb8b9b          	addiw	s7,s7,-1
    80006a64:	fb5c94e3          	bne	s9,s5,80006a0c <consoleread+0x58>
    80006a68:	000b851b          	sext.w	a0,s7
    80006a6c:	06813083          	ld	ra,104(sp)
    80006a70:	06013403          	ld	s0,96(sp)
    80006a74:	05813483          	ld	s1,88(sp)
    80006a78:	05013903          	ld	s2,80(sp)
    80006a7c:	04813983          	ld	s3,72(sp)
    80006a80:	04013a03          	ld	s4,64(sp)
    80006a84:	03813a83          	ld	s5,56(sp)
    80006a88:	02813b83          	ld	s7,40(sp)
    80006a8c:	02013c03          	ld	s8,32(sp)
    80006a90:	01813c83          	ld	s9,24(sp)
    80006a94:	40ab053b          	subw	a0,s6,a0
    80006a98:	03013b03          	ld	s6,48(sp)
    80006a9c:	07010113          	addi	sp,sp,112
    80006aa0:	00008067          	ret
    80006aa4:	00001097          	auipc	ra,0x1
    80006aa8:	1d8080e7          	jalr	472(ra) # 80007c7c <push_on>
    80006aac:	0984a703          	lw	a4,152(s1)
    80006ab0:	09c4a783          	lw	a5,156(s1)
    80006ab4:	0007879b          	sext.w	a5,a5
    80006ab8:	fef70ce3          	beq	a4,a5,80006ab0 <consoleread+0xfc>
    80006abc:	00001097          	auipc	ra,0x1
    80006ac0:	234080e7          	jalr	564(ra) # 80007cf0 <pop_on>
    80006ac4:	0984a783          	lw	a5,152(s1)
    80006ac8:	07f7f713          	andi	a4,a5,127
    80006acc:	00e48733          	add	a4,s1,a4
    80006ad0:	01874703          	lbu	a4,24(a4)
    80006ad4:	0017869b          	addiw	a3,a5,1
    80006ad8:	08d4ac23          	sw	a3,152(s1)
    80006adc:	00070c9b          	sext.w	s9,a4
    80006ae0:	f5371ee3          	bne	a4,s3,80006a3c <consoleread+0x88>
    80006ae4:	000b851b          	sext.w	a0,s7
    80006ae8:	f96bf2e3          	bgeu	s7,s6,80006a6c <consoleread+0xb8>
    80006aec:	08f4ac23          	sw	a5,152(s1)
    80006af0:	f7dff06f          	j	80006a6c <consoleread+0xb8>

0000000080006af4 <consputc>:
    80006af4:	10000793          	li	a5,256
    80006af8:	00f50663          	beq	a0,a5,80006b04 <consputc+0x10>
    80006afc:	00001317          	auipc	t1,0x1
    80006b00:	9f430067          	jr	-1548(t1) # 800074f0 <uartputc_sync>
    80006b04:	ff010113          	addi	sp,sp,-16
    80006b08:	00113423          	sd	ra,8(sp)
    80006b0c:	00813023          	sd	s0,0(sp)
    80006b10:	01010413          	addi	s0,sp,16
    80006b14:	00800513          	li	a0,8
    80006b18:	00001097          	auipc	ra,0x1
    80006b1c:	9d8080e7          	jalr	-1576(ra) # 800074f0 <uartputc_sync>
    80006b20:	02000513          	li	a0,32
    80006b24:	00001097          	auipc	ra,0x1
    80006b28:	9cc080e7          	jalr	-1588(ra) # 800074f0 <uartputc_sync>
    80006b2c:	00013403          	ld	s0,0(sp)
    80006b30:	00813083          	ld	ra,8(sp)
    80006b34:	00800513          	li	a0,8
    80006b38:	01010113          	addi	sp,sp,16
    80006b3c:	00001317          	auipc	t1,0x1
    80006b40:	9b430067          	jr	-1612(t1) # 800074f0 <uartputc_sync>

0000000080006b44 <consoleintr>:
    80006b44:	fe010113          	addi	sp,sp,-32
    80006b48:	00813823          	sd	s0,16(sp)
    80006b4c:	00913423          	sd	s1,8(sp)
    80006b50:	01213023          	sd	s2,0(sp)
    80006b54:	00113c23          	sd	ra,24(sp)
    80006b58:	02010413          	addi	s0,sp,32
    80006b5c:	0000a917          	auipc	s2,0xa
    80006b60:	07c90913          	addi	s2,s2,124 # 80010bd8 <cons>
    80006b64:	00050493          	mv	s1,a0
    80006b68:	00090513          	mv	a0,s2
    80006b6c:	00001097          	auipc	ra,0x1
    80006b70:	e40080e7          	jalr	-448(ra) # 800079ac <acquire>
    80006b74:	02048c63          	beqz	s1,80006bac <consoleintr+0x68>
    80006b78:	0a092783          	lw	a5,160(s2)
    80006b7c:	09892703          	lw	a4,152(s2)
    80006b80:	07f00693          	li	a3,127
    80006b84:	40e7873b          	subw	a4,a5,a4
    80006b88:	02e6e263          	bltu	a3,a4,80006bac <consoleintr+0x68>
    80006b8c:	00d00713          	li	a4,13
    80006b90:	04e48063          	beq	s1,a4,80006bd0 <consoleintr+0x8c>
    80006b94:	07f7f713          	andi	a4,a5,127
    80006b98:	00e90733          	add	a4,s2,a4
    80006b9c:	0017879b          	addiw	a5,a5,1
    80006ba0:	0af92023          	sw	a5,160(s2)
    80006ba4:	00970c23          	sb	s1,24(a4)
    80006ba8:	08f92e23          	sw	a5,156(s2)
    80006bac:	01013403          	ld	s0,16(sp)
    80006bb0:	01813083          	ld	ra,24(sp)
    80006bb4:	00813483          	ld	s1,8(sp)
    80006bb8:	00013903          	ld	s2,0(sp)
    80006bbc:	0000a517          	auipc	a0,0xa
    80006bc0:	01c50513          	addi	a0,a0,28 # 80010bd8 <cons>
    80006bc4:	02010113          	addi	sp,sp,32
    80006bc8:	00001317          	auipc	t1,0x1
    80006bcc:	eb030067          	jr	-336(t1) # 80007a78 <release>
    80006bd0:	00a00493          	li	s1,10
    80006bd4:	fc1ff06f          	j	80006b94 <consoleintr+0x50>

0000000080006bd8 <consoleinit>:
    80006bd8:	fe010113          	addi	sp,sp,-32
    80006bdc:	00113c23          	sd	ra,24(sp)
    80006be0:	00813823          	sd	s0,16(sp)
    80006be4:	00913423          	sd	s1,8(sp)
    80006be8:	02010413          	addi	s0,sp,32
    80006bec:	0000a497          	auipc	s1,0xa
    80006bf0:	fec48493          	addi	s1,s1,-20 # 80010bd8 <cons>
    80006bf4:	00048513          	mv	a0,s1
    80006bf8:	00003597          	auipc	a1,0x3
    80006bfc:	a0858593          	addi	a1,a1,-1528 # 80009600 <CONSOLE_STATUS+0x5f0>
    80006c00:	00001097          	auipc	ra,0x1
    80006c04:	d88080e7          	jalr	-632(ra) # 80007988 <initlock>
    80006c08:	00000097          	auipc	ra,0x0
    80006c0c:	7ac080e7          	jalr	1964(ra) # 800073b4 <uartinit>
    80006c10:	01813083          	ld	ra,24(sp)
    80006c14:	01013403          	ld	s0,16(sp)
    80006c18:	00000797          	auipc	a5,0x0
    80006c1c:	d9c78793          	addi	a5,a5,-612 # 800069b4 <consoleread>
    80006c20:	0af4bc23          	sd	a5,184(s1)
    80006c24:	00000797          	auipc	a5,0x0
    80006c28:	cec78793          	addi	a5,a5,-788 # 80006910 <consolewrite>
    80006c2c:	0cf4b023          	sd	a5,192(s1)
    80006c30:	00813483          	ld	s1,8(sp)
    80006c34:	02010113          	addi	sp,sp,32
    80006c38:	00008067          	ret

0000000080006c3c <console_read>:
    80006c3c:	ff010113          	addi	sp,sp,-16
    80006c40:	00813423          	sd	s0,8(sp)
    80006c44:	01010413          	addi	s0,sp,16
    80006c48:	00813403          	ld	s0,8(sp)
    80006c4c:	0000a317          	auipc	t1,0xa
    80006c50:	04433303          	ld	t1,68(t1) # 80010c90 <devsw+0x10>
    80006c54:	01010113          	addi	sp,sp,16
    80006c58:	00030067          	jr	t1

0000000080006c5c <console_write>:
    80006c5c:	ff010113          	addi	sp,sp,-16
    80006c60:	00813423          	sd	s0,8(sp)
    80006c64:	01010413          	addi	s0,sp,16
    80006c68:	00813403          	ld	s0,8(sp)
    80006c6c:	0000a317          	auipc	t1,0xa
    80006c70:	02c33303          	ld	t1,44(t1) # 80010c98 <devsw+0x18>
    80006c74:	01010113          	addi	sp,sp,16
    80006c78:	00030067          	jr	t1

0000000080006c7c <panic>:
    80006c7c:	fe010113          	addi	sp,sp,-32
    80006c80:	00113c23          	sd	ra,24(sp)
    80006c84:	00813823          	sd	s0,16(sp)
    80006c88:	00913423          	sd	s1,8(sp)
    80006c8c:	02010413          	addi	s0,sp,32
    80006c90:	00050493          	mv	s1,a0
    80006c94:	00003517          	auipc	a0,0x3
    80006c98:	97450513          	addi	a0,a0,-1676 # 80009608 <CONSOLE_STATUS+0x5f8>
    80006c9c:	0000a797          	auipc	a5,0xa
    80006ca0:	0807ae23          	sw	zero,156(a5) # 80010d38 <pr+0x18>
    80006ca4:	00000097          	auipc	ra,0x0
    80006ca8:	034080e7          	jalr	52(ra) # 80006cd8 <__printf>
    80006cac:	00048513          	mv	a0,s1
    80006cb0:	00000097          	auipc	ra,0x0
    80006cb4:	028080e7          	jalr	40(ra) # 80006cd8 <__printf>
    80006cb8:	00002517          	auipc	a0,0x2
    80006cbc:	41050513          	addi	a0,a0,1040 # 800090c8 <CONSOLE_STATUS+0xb8>
    80006cc0:	00000097          	auipc	ra,0x0
    80006cc4:	018080e7          	jalr	24(ra) # 80006cd8 <__printf>
    80006cc8:	00100793          	li	a5,1
    80006ccc:	00005717          	auipc	a4,0x5
    80006cd0:	c2f72e23          	sw	a5,-964(a4) # 8000b908 <panicked>
    80006cd4:	0000006f          	j	80006cd4 <panic+0x58>

0000000080006cd8 <__printf>:
    80006cd8:	f3010113          	addi	sp,sp,-208
    80006cdc:	08813023          	sd	s0,128(sp)
    80006ce0:	07313423          	sd	s3,104(sp)
    80006ce4:	09010413          	addi	s0,sp,144
    80006ce8:	05813023          	sd	s8,64(sp)
    80006cec:	08113423          	sd	ra,136(sp)
    80006cf0:	06913c23          	sd	s1,120(sp)
    80006cf4:	07213823          	sd	s2,112(sp)
    80006cf8:	07413023          	sd	s4,96(sp)
    80006cfc:	05513c23          	sd	s5,88(sp)
    80006d00:	05613823          	sd	s6,80(sp)
    80006d04:	05713423          	sd	s7,72(sp)
    80006d08:	03913c23          	sd	s9,56(sp)
    80006d0c:	03a13823          	sd	s10,48(sp)
    80006d10:	03b13423          	sd	s11,40(sp)
    80006d14:	0000a317          	auipc	t1,0xa
    80006d18:	00c30313          	addi	t1,t1,12 # 80010d20 <pr>
    80006d1c:	01832c03          	lw	s8,24(t1)
    80006d20:	00b43423          	sd	a1,8(s0)
    80006d24:	00c43823          	sd	a2,16(s0)
    80006d28:	00d43c23          	sd	a3,24(s0)
    80006d2c:	02e43023          	sd	a4,32(s0)
    80006d30:	02f43423          	sd	a5,40(s0)
    80006d34:	03043823          	sd	a6,48(s0)
    80006d38:	03143c23          	sd	a7,56(s0)
    80006d3c:	00050993          	mv	s3,a0
    80006d40:	4a0c1663          	bnez	s8,800071ec <__printf+0x514>
    80006d44:	60098c63          	beqz	s3,8000735c <__printf+0x684>
    80006d48:	0009c503          	lbu	a0,0(s3)
    80006d4c:	00840793          	addi	a5,s0,8
    80006d50:	f6f43c23          	sd	a5,-136(s0)
    80006d54:	00000493          	li	s1,0
    80006d58:	22050063          	beqz	a0,80006f78 <__printf+0x2a0>
    80006d5c:	00002a37          	lui	s4,0x2
    80006d60:	00018ab7          	lui	s5,0x18
    80006d64:	000f4b37          	lui	s6,0xf4
    80006d68:	00989bb7          	lui	s7,0x989
    80006d6c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006d70:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006d74:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006d78:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80006d7c:	00148c9b          	addiw	s9,s1,1
    80006d80:	02500793          	li	a5,37
    80006d84:	01998933          	add	s2,s3,s9
    80006d88:	38f51263          	bne	a0,a5,8000710c <__printf+0x434>
    80006d8c:	00094783          	lbu	a5,0(s2)
    80006d90:	00078c9b          	sext.w	s9,a5
    80006d94:	1e078263          	beqz	a5,80006f78 <__printf+0x2a0>
    80006d98:	0024849b          	addiw	s1,s1,2
    80006d9c:	07000713          	li	a4,112
    80006da0:	00998933          	add	s2,s3,s1
    80006da4:	38e78a63          	beq	a5,a4,80007138 <__printf+0x460>
    80006da8:	20f76863          	bltu	a4,a5,80006fb8 <__printf+0x2e0>
    80006dac:	42a78863          	beq	a5,a0,800071dc <__printf+0x504>
    80006db0:	06400713          	li	a4,100
    80006db4:	40e79663          	bne	a5,a4,800071c0 <__printf+0x4e8>
    80006db8:	f7843783          	ld	a5,-136(s0)
    80006dbc:	0007a603          	lw	a2,0(a5)
    80006dc0:	00878793          	addi	a5,a5,8
    80006dc4:	f6f43c23          	sd	a5,-136(s0)
    80006dc8:	42064a63          	bltz	a2,800071fc <__printf+0x524>
    80006dcc:	00a00713          	li	a4,10
    80006dd0:	02e677bb          	remuw	a5,a2,a4
    80006dd4:	00003d97          	auipc	s11,0x3
    80006dd8:	85cd8d93          	addi	s11,s11,-1956 # 80009630 <digits>
    80006ddc:	00900593          	li	a1,9
    80006de0:	0006051b          	sext.w	a0,a2
    80006de4:	00000c93          	li	s9,0
    80006de8:	02079793          	slli	a5,a5,0x20
    80006dec:	0207d793          	srli	a5,a5,0x20
    80006df0:	00fd87b3          	add	a5,s11,a5
    80006df4:	0007c783          	lbu	a5,0(a5)
    80006df8:	02e656bb          	divuw	a3,a2,a4
    80006dfc:	f8f40023          	sb	a5,-128(s0)
    80006e00:	14c5d863          	bge	a1,a2,80006f50 <__printf+0x278>
    80006e04:	06300593          	li	a1,99
    80006e08:	00100c93          	li	s9,1
    80006e0c:	02e6f7bb          	remuw	a5,a3,a4
    80006e10:	02079793          	slli	a5,a5,0x20
    80006e14:	0207d793          	srli	a5,a5,0x20
    80006e18:	00fd87b3          	add	a5,s11,a5
    80006e1c:	0007c783          	lbu	a5,0(a5)
    80006e20:	02e6d73b          	divuw	a4,a3,a4
    80006e24:	f8f400a3          	sb	a5,-127(s0)
    80006e28:	12a5f463          	bgeu	a1,a0,80006f50 <__printf+0x278>
    80006e2c:	00a00693          	li	a3,10
    80006e30:	00900593          	li	a1,9
    80006e34:	02d777bb          	remuw	a5,a4,a3
    80006e38:	02079793          	slli	a5,a5,0x20
    80006e3c:	0207d793          	srli	a5,a5,0x20
    80006e40:	00fd87b3          	add	a5,s11,a5
    80006e44:	0007c503          	lbu	a0,0(a5)
    80006e48:	02d757bb          	divuw	a5,a4,a3
    80006e4c:	f8a40123          	sb	a0,-126(s0)
    80006e50:	48e5f263          	bgeu	a1,a4,800072d4 <__printf+0x5fc>
    80006e54:	06300513          	li	a0,99
    80006e58:	02d7f5bb          	remuw	a1,a5,a3
    80006e5c:	02059593          	slli	a1,a1,0x20
    80006e60:	0205d593          	srli	a1,a1,0x20
    80006e64:	00bd85b3          	add	a1,s11,a1
    80006e68:	0005c583          	lbu	a1,0(a1)
    80006e6c:	02d7d7bb          	divuw	a5,a5,a3
    80006e70:	f8b401a3          	sb	a1,-125(s0)
    80006e74:	48e57263          	bgeu	a0,a4,800072f8 <__printf+0x620>
    80006e78:	3e700513          	li	a0,999
    80006e7c:	02d7f5bb          	remuw	a1,a5,a3
    80006e80:	02059593          	slli	a1,a1,0x20
    80006e84:	0205d593          	srli	a1,a1,0x20
    80006e88:	00bd85b3          	add	a1,s11,a1
    80006e8c:	0005c583          	lbu	a1,0(a1)
    80006e90:	02d7d7bb          	divuw	a5,a5,a3
    80006e94:	f8b40223          	sb	a1,-124(s0)
    80006e98:	46e57663          	bgeu	a0,a4,80007304 <__printf+0x62c>
    80006e9c:	02d7f5bb          	remuw	a1,a5,a3
    80006ea0:	02059593          	slli	a1,a1,0x20
    80006ea4:	0205d593          	srli	a1,a1,0x20
    80006ea8:	00bd85b3          	add	a1,s11,a1
    80006eac:	0005c583          	lbu	a1,0(a1)
    80006eb0:	02d7d7bb          	divuw	a5,a5,a3
    80006eb4:	f8b402a3          	sb	a1,-123(s0)
    80006eb8:	46ea7863          	bgeu	s4,a4,80007328 <__printf+0x650>
    80006ebc:	02d7f5bb          	remuw	a1,a5,a3
    80006ec0:	02059593          	slli	a1,a1,0x20
    80006ec4:	0205d593          	srli	a1,a1,0x20
    80006ec8:	00bd85b3          	add	a1,s11,a1
    80006ecc:	0005c583          	lbu	a1,0(a1)
    80006ed0:	02d7d7bb          	divuw	a5,a5,a3
    80006ed4:	f8b40323          	sb	a1,-122(s0)
    80006ed8:	3eeaf863          	bgeu	s5,a4,800072c8 <__printf+0x5f0>
    80006edc:	02d7f5bb          	remuw	a1,a5,a3
    80006ee0:	02059593          	slli	a1,a1,0x20
    80006ee4:	0205d593          	srli	a1,a1,0x20
    80006ee8:	00bd85b3          	add	a1,s11,a1
    80006eec:	0005c583          	lbu	a1,0(a1)
    80006ef0:	02d7d7bb          	divuw	a5,a5,a3
    80006ef4:	f8b403a3          	sb	a1,-121(s0)
    80006ef8:	42eb7e63          	bgeu	s6,a4,80007334 <__printf+0x65c>
    80006efc:	02d7f5bb          	remuw	a1,a5,a3
    80006f00:	02059593          	slli	a1,a1,0x20
    80006f04:	0205d593          	srli	a1,a1,0x20
    80006f08:	00bd85b3          	add	a1,s11,a1
    80006f0c:	0005c583          	lbu	a1,0(a1)
    80006f10:	02d7d7bb          	divuw	a5,a5,a3
    80006f14:	f8b40423          	sb	a1,-120(s0)
    80006f18:	42ebfc63          	bgeu	s7,a4,80007350 <__printf+0x678>
    80006f1c:	02079793          	slli	a5,a5,0x20
    80006f20:	0207d793          	srli	a5,a5,0x20
    80006f24:	00fd8db3          	add	s11,s11,a5
    80006f28:	000dc703          	lbu	a4,0(s11)
    80006f2c:	00a00793          	li	a5,10
    80006f30:	00900c93          	li	s9,9
    80006f34:	f8e404a3          	sb	a4,-119(s0)
    80006f38:	00065c63          	bgez	a2,80006f50 <__printf+0x278>
    80006f3c:	f9040713          	addi	a4,s0,-112
    80006f40:	00f70733          	add	a4,a4,a5
    80006f44:	02d00693          	li	a3,45
    80006f48:	fed70823          	sb	a3,-16(a4)
    80006f4c:	00078c93          	mv	s9,a5
    80006f50:	f8040793          	addi	a5,s0,-128
    80006f54:	01978cb3          	add	s9,a5,s9
    80006f58:	f7f40d13          	addi	s10,s0,-129
    80006f5c:	000cc503          	lbu	a0,0(s9)
    80006f60:	fffc8c93          	addi	s9,s9,-1
    80006f64:	00000097          	auipc	ra,0x0
    80006f68:	b90080e7          	jalr	-1136(ra) # 80006af4 <consputc>
    80006f6c:	ffac98e3          	bne	s9,s10,80006f5c <__printf+0x284>
    80006f70:	00094503          	lbu	a0,0(s2)
    80006f74:	e00514e3          	bnez	a0,80006d7c <__printf+0xa4>
    80006f78:	1a0c1663          	bnez	s8,80007124 <__printf+0x44c>
    80006f7c:	08813083          	ld	ra,136(sp)
    80006f80:	08013403          	ld	s0,128(sp)
    80006f84:	07813483          	ld	s1,120(sp)
    80006f88:	07013903          	ld	s2,112(sp)
    80006f8c:	06813983          	ld	s3,104(sp)
    80006f90:	06013a03          	ld	s4,96(sp)
    80006f94:	05813a83          	ld	s5,88(sp)
    80006f98:	05013b03          	ld	s6,80(sp)
    80006f9c:	04813b83          	ld	s7,72(sp)
    80006fa0:	04013c03          	ld	s8,64(sp)
    80006fa4:	03813c83          	ld	s9,56(sp)
    80006fa8:	03013d03          	ld	s10,48(sp)
    80006fac:	02813d83          	ld	s11,40(sp)
    80006fb0:	0d010113          	addi	sp,sp,208
    80006fb4:	00008067          	ret
    80006fb8:	07300713          	li	a4,115
    80006fbc:	1ce78a63          	beq	a5,a4,80007190 <__printf+0x4b8>
    80006fc0:	07800713          	li	a4,120
    80006fc4:	1ee79e63          	bne	a5,a4,800071c0 <__printf+0x4e8>
    80006fc8:	f7843783          	ld	a5,-136(s0)
    80006fcc:	0007a703          	lw	a4,0(a5)
    80006fd0:	00878793          	addi	a5,a5,8
    80006fd4:	f6f43c23          	sd	a5,-136(s0)
    80006fd8:	28074263          	bltz	a4,8000725c <__printf+0x584>
    80006fdc:	00002d97          	auipc	s11,0x2
    80006fe0:	654d8d93          	addi	s11,s11,1620 # 80009630 <digits>
    80006fe4:	00f77793          	andi	a5,a4,15
    80006fe8:	00fd87b3          	add	a5,s11,a5
    80006fec:	0007c683          	lbu	a3,0(a5)
    80006ff0:	00f00613          	li	a2,15
    80006ff4:	0007079b          	sext.w	a5,a4
    80006ff8:	f8d40023          	sb	a3,-128(s0)
    80006ffc:	0047559b          	srliw	a1,a4,0x4
    80007000:	0047569b          	srliw	a3,a4,0x4
    80007004:	00000c93          	li	s9,0
    80007008:	0ee65063          	bge	a2,a4,800070e8 <__printf+0x410>
    8000700c:	00f6f693          	andi	a3,a3,15
    80007010:	00dd86b3          	add	a3,s11,a3
    80007014:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007018:	0087d79b          	srliw	a5,a5,0x8
    8000701c:	00100c93          	li	s9,1
    80007020:	f8d400a3          	sb	a3,-127(s0)
    80007024:	0cb67263          	bgeu	a2,a1,800070e8 <__printf+0x410>
    80007028:	00f7f693          	andi	a3,a5,15
    8000702c:	00dd86b3          	add	a3,s11,a3
    80007030:	0006c583          	lbu	a1,0(a3)
    80007034:	00f00613          	li	a2,15
    80007038:	0047d69b          	srliw	a3,a5,0x4
    8000703c:	f8b40123          	sb	a1,-126(s0)
    80007040:	0047d593          	srli	a1,a5,0x4
    80007044:	28f67e63          	bgeu	a2,a5,800072e0 <__printf+0x608>
    80007048:	00f6f693          	andi	a3,a3,15
    8000704c:	00dd86b3          	add	a3,s11,a3
    80007050:	0006c503          	lbu	a0,0(a3)
    80007054:	0087d813          	srli	a6,a5,0x8
    80007058:	0087d69b          	srliw	a3,a5,0x8
    8000705c:	f8a401a3          	sb	a0,-125(s0)
    80007060:	28b67663          	bgeu	a2,a1,800072ec <__printf+0x614>
    80007064:	00f6f693          	andi	a3,a3,15
    80007068:	00dd86b3          	add	a3,s11,a3
    8000706c:	0006c583          	lbu	a1,0(a3)
    80007070:	00c7d513          	srli	a0,a5,0xc
    80007074:	00c7d69b          	srliw	a3,a5,0xc
    80007078:	f8b40223          	sb	a1,-124(s0)
    8000707c:	29067a63          	bgeu	a2,a6,80007310 <__printf+0x638>
    80007080:	00f6f693          	andi	a3,a3,15
    80007084:	00dd86b3          	add	a3,s11,a3
    80007088:	0006c583          	lbu	a1,0(a3)
    8000708c:	0107d813          	srli	a6,a5,0x10
    80007090:	0107d69b          	srliw	a3,a5,0x10
    80007094:	f8b402a3          	sb	a1,-123(s0)
    80007098:	28a67263          	bgeu	a2,a0,8000731c <__printf+0x644>
    8000709c:	00f6f693          	andi	a3,a3,15
    800070a0:	00dd86b3          	add	a3,s11,a3
    800070a4:	0006c683          	lbu	a3,0(a3)
    800070a8:	0147d79b          	srliw	a5,a5,0x14
    800070ac:	f8d40323          	sb	a3,-122(s0)
    800070b0:	21067663          	bgeu	a2,a6,800072bc <__printf+0x5e4>
    800070b4:	02079793          	slli	a5,a5,0x20
    800070b8:	0207d793          	srli	a5,a5,0x20
    800070bc:	00fd8db3          	add	s11,s11,a5
    800070c0:	000dc683          	lbu	a3,0(s11)
    800070c4:	00800793          	li	a5,8
    800070c8:	00700c93          	li	s9,7
    800070cc:	f8d403a3          	sb	a3,-121(s0)
    800070d0:	00075c63          	bgez	a4,800070e8 <__printf+0x410>
    800070d4:	f9040713          	addi	a4,s0,-112
    800070d8:	00f70733          	add	a4,a4,a5
    800070dc:	02d00693          	li	a3,45
    800070e0:	fed70823          	sb	a3,-16(a4)
    800070e4:	00078c93          	mv	s9,a5
    800070e8:	f8040793          	addi	a5,s0,-128
    800070ec:	01978cb3          	add	s9,a5,s9
    800070f0:	f7f40d13          	addi	s10,s0,-129
    800070f4:	000cc503          	lbu	a0,0(s9)
    800070f8:	fffc8c93          	addi	s9,s9,-1
    800070fc:	00000097          	auipc	ra,0x0
    80007100:	9f8080e7          	jalr	-1544(ra) # 80006af4 <consputc>
    80007104:	ff9d18e3          	bne	s10,s9,800070f4 <__printf+0x41c>
    80007108:	0100006f          	j	80007118 <__printf+0x440>
    8000710c:	00000097          	auipc	ra,0x0
    80007110:	9e8080e7          	jalr	-1560(ra) # 80006af4 <consputc>
    80007114:	000c8493          	mv	s1,s9
    80007118:	00094503          	lbu	a0,0(s2)
    8000711c:	c60510e3          	bnez	a0,80006d7c <__printf+0xa4>
    80007120:	e40c0ee3          	beqz	s8,80006f7c <__printf+0x2a4>
    80007124:	0000a517          	auipc	a0,0xa
    80007128:	bfc50513          	addi	a0,a0,-1028 # 80010d20 <pr>
    8000712c:	00001097          	auipc	ra,0x1
    80007130:	94c080e7          	jalr	-1716(ra) # 80007a78 <release>
    80007134:	e49ff06f          	j	80006f7c <__printf+0x2a4>
    80007138:	f7843783          	ld	a5,-136(s0)
    8000713c:	03000513          	li	a0,48
    80007140:	01000d13          	li	s10,16
    80007144:	00878713          	addi	a4,a5,8
    80007148:	0007bc83          	ld	s9,0(a5)
    8000714c:	f6e43c23          	sd	a4,-136(s0)
    80007150:	00000097          	auipc	ra,0x0
    80007154:	9a4080e7          	jalr	-1628(ra) # 80006af4 <consputc>
    80007158:	07800513          	li	a0,120
    8000715c:	00000097          	auipc	ra,0x0
    80007160:	998080e7          	jalr	-1640(ra) # 80006af4 <consputc>
    80007164:	00002d97          	auipc	s11,0x2
    80007168:	4ccd8d93          	addi	s11,s11,1228 # 80009630 <digits>
    8000716c:	03ccd793          	srli	a5,s9,0x3c
    80007170:	00fd87b3          	add	a5,s11,a5
    80007174:	0007c503          	lbu	a0,0(a5)
    80007178:	fffd0d1b          	addiw	s10,s10,-1
    8000717c:	004c9c93          	slli	s9,s9,0x4
    80007180:	00000097          	auipc	ra,0x0
    80007184:	974080e7          	jalr	-1676(ra) # 80006af4 <consputc>
    80007188:	fe0d12e3          	bnez	s10,8000716c <__printf+0x494>
    8000718c:	f8dff06f          	j	80007118 <__printf+0x440>
    80007190:	f7843783          	ld	a5,-136(s0)
    80007194:	0007bc83          	ld	s9,0(a5)
    80007198:	00878793          	addi	a5,a5,8
    8000719c:	f6f43c23          	sd	a5,-136(s0)
    800071a0:	000c9a63          	bnez	s9,800071b4 <__printf+0x4dc>
    800071a4:	1080006f          	j	800072ac <__printf+0x5d4>
    800071a8:	001c8c93          	addi	s9,s9,1
    800071ac:	00000097          	auipc	ra,0x0
    800071b0:	948080e7          	jalr	-1720(ra) # 80006af4 <consputc>
    800071b4:	000cc503          	lbu	a0,0(s9)
    800071b8:	fe0518e3          	bnez	a0,800071a8 <__printf+0x4d0>
    800071bc:	f5dff06f          	j	80007118 <__printf+0x440>
    800071c0:	02500513          	li	a0,37
    800071c4:	00000097          	auipc	ra,0x0
    800071c8:	930080e7          	jalr	-1744(ra) # 80006af4 <consputc>
    800071cc:	000c8513          	mv	a0,s9
    800071d0:	00000097          	auipc	ra,0x0
    800071d4:	924080e7          	jalr	-1756(ra) # 80006af4 <consputc>
    800071d8:	f41ff06f          	j	80007118 <__printf+0x440>
    800071dc:	02500513          	li	a0,37
    800071e0:	00000097          	auipc	ra,0x0
    800071e4:	914080e7          	jalr	-1772(ra) # 80006af4 <consputc>
    800071e8:	f31ff06f          	j	80007118 <__printf+0x440>
    800071ec:	00030513          	mv	a0,t1
    800071f0:	00000097          	auipc	ra,0x0
    800071f4:	7bc080e7          	jalr	1980(ra) # 800079ac <acquire>
    800071f8:	b4dff06f          	j	80006d44 <__printf+0x6c>
    800071fc:	40c0053b          	negw	a0,a2
    80007200:	00a00713          	li	a4,10
    80007204:	02e576bb          	remuw	a3,a0,a4
    80007208:	00002d97          	auipc	s11,0x2
    8000720c:	428d8d93          	addi	s11,s11,1064 # 80009630 <digits>
    80007210:	ff700593          	li	a1,-9
    80007214:	02069693          	slli	a3,a3,0x20
    80007218:	0206d693          	srli	a3,a3,0x20
    8000721c:	00dd86b3          	add	a3,s11,a3
    80007220:	0006c683          	lbu	a3,0(a3)
    80007224:	02e557bb          	divuw	a5,a0,a4
    80007228:	f8d40023          	sb	a3,-128(s0)
    8000722c:	10b65e63          	bge	a2,a1,80007348 <__printf+0x670>
    80007230:	06300593          	li	a1,99
    80007234:	02e7f6bb          	remuw	a3,a5,a4
    80007238:	02069693          	slli	a3,a3,0x20
    8000723c:	0206d693          	srli	a3,a3,0x20
    80007240:	00dd86b3          	add	a3,s11,a3
    80007244:	0006c683          	lbu	a3,0(a3)
    80007248:	02e7d73b          	divuw	a4,a5,a4
    8000724c:	00200793          	li	a5,2
    80007250:	f8d400a3          	sb	a3,-127(s0)
    80007254:	bca5ece3          	bltu	a1,a0,80006e2c <__printf+0x154>
    80007258:	ce5ff06f          	j	80006f3c <__printf+0x264>
    8000725c:	40e007bb          	negw	a5,a4
    80007260:	00002d97          	auipc	s11,0x2
    80007264:	3d0d8d93          	addi	s11,s11,976 # 80009630 <digits>
    80007268:	00f7f693          	andi	a3,a5,15
    8000726c:	00dd86b3          	add	a3,s11,a3
    80007270:	0006c583          	lbu	a1,0(a3)
    80007274:	ff100613          	li	a2,-15
    80007278:	0047d69b          	srliw	a3,a5,0x4
    8000727c:	f8b40023          	sb	a1,-128(s0)
    80007280:	0047d59b          	srliw	a1,a5,0x4
    80007284:	0ac75e63          	bge	a4,a2,80007340 <__printf+0x668>
    80007288:	00f6f693          	andi	a3,a3,15
    8000728c:	00dd86b3          	add	a3,s11,a3
    80007290:	0006c603          	lbu	a2,0(a3)
    80007294:	00f00693          	li	a3,15
    80007298:	0087d79b          	srliw	a5,a5,0x8
    8000729c:	f8c400a3          	sb	a2,-127(s0)
    800072a0:	d8b6e4e3          	bltu	a3,a1,80007028 <__printf+0x350>
    800072a4:	00200793          	li	a5,2
    800072a8:	e2dff06f          	j	800070d4 <__printf+0x3fc>
    800072ac:	00002c97          	auipc	s9,0x2
    800072b0:	364c8c93          	addi	s9,s9,868 # 80009610 <CONSOLE_STATUS+0x600>
    800072b4:	02800513          	li	a0,40
    800072b8:	ef1ff06f          	j	800071a8 <__printf+0x4d0>
    800072bc:	00700793          	li	a5,7
    800072c0:	00600c93          	li	s9,6
    800072c4:	e0dff06f          	j	800070d0 <__printf+0x3f8>
    800072c8:	00700793          	li	a5,7
    800072cc:	00600c93          	li	s9,6
    800072d0:	c69ff06f          	j	80006f38 <__printf+0x260>
    800072d4:	00300793          	li	a5,3
    800072d8:	00200c93          	li	s9,2
    800072dc:	c5dff06f          	j	80006f38 <__printf+0x260>
    800072e0:	00300793          	li	a5,3
    800072e4:	00200c93          	li	s9,2
    800072e8:	de9ff06f          	j	800070d0 <__printf+0x3f8>
    800072ec:	00400793          	li	a5,4
    800072f0:	00300c93          	li	s9,3
    800072f4:	dddff06f          	j	800070d0 <__printf+0x3f8>
    800072f8:	00400793          	li	a5,4
    800072fc:	00300c93          	li	s9,3
    80007300:	c39ff06f          	j	80006f38 <__printf+0x260>
    80007304:	00500793          	li	a5,5
    80007308:	00400c93          	li	s9,4
    8000730c:	c2dff06f          	j	80006f38 <__printf+0x260>
    80007310:	00500793          	li	a5,5
    80007314:	00400c93          	li	s9,4
    80007318:	db9ff06f          	j	800070d0 <__printf+0x3f8>
    8000731c:	00600793          	li	a5,6
    80007320:	00500c93          	li	s9,5
    80007324:	dadff06f          	j	800070d0 <__printf+0x3f8>
    80007328:	00600793          	li	a5,6
    8000732c:	00500c93          	li	s9,5
    80007330:	c09ff06f          	j	80006f38 <__printf+0x260>
    80007334:	00800793          	li	a5,8
    80007338:	00700c93          	li	s9,7
    8000733c:	bfdff06f          	j	80006f38 <__printf+0x260>
    80007340:	00100793          	li	a5,1
    80007344:	d91ff06f          	j	800070d4 <__printf+0x3fc>
    80007348:	00100793          	li	a5,1
    8000734c:	bf1ff06f          	j	80006f3c <__printf+0x264>
    80007350:	00900793          	li	a5,9
    80007354:	00800c93          	li	s9,8
    80007358:	be1ff06f          	j	80006f38 <__printf+0x260>
    8000735c:	00002517          	auipc	a0,0x2
    80007360:	2bc50513          	addi	a0,a0,700 # 80009618 <CONSOLE_STATUS+0x608>
    80007364:	00000097          	auipc	ra,0x0
    80007368:	918080e7          	jalr	-1768(ra) # 80006c7c <panic>

000000008000736c <printfinit>:
    8000736c:	fe010113          	addi	sp,sp,-32
    80007370:	00813823          	sd	s0,16(sp)
    80007374:	00913423          	sd	s1,8(sp)
    80007378:	00113c23          	sd	ra,24(sp)
    8000737c:	02010413          	addi	s0,sp,32
    80007380:	0000a497          	auipc	s1,0xa
    80007384:	9a048493          	addi	s1,s1,-1632 # 80010d20 <pr>
    80007388:	00048513          	mv	a0,s1
    8000738c:	00002597          	auipc	a1,0x2
    80007390:	29c58593          	addi	a1,a1,668 # 80009628 <CONSOLE_STATUS+0x618>
    80007394:	00000097          	auipc	ra,0x0
    80007398:	5f4080e7          	jalr	1524(ra) # 80007988 <initlock>
    8000739c:	01813083          	ld	ra,24(sp)
    800073a0:	01013403          	ld	s0,16(sp)
    800073a4:	0004ac23          	sw	zero,24(s1)
    800073a8:	00813483          	ld	s1,8(sp)
    800073ac:	02010113          	addi	sp,sp,32
    800073b0:	00008067          	ret

00000000800073b4 <uartinit>:
    800073b4:	ff010113          	addi	sp,sp,-16
    800073b8:	00813423          	sd	s0,8(sp)
    800073bc:	01010413          	addi	s0,sp,16
    800073c0:	100007b7          	lui	a5,0x10000
    800073c4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800073c8:	f8000713          	li	a4,-128
    800073cc:	00e781a3          	sb	a4,3(a5)
    800073d0:	00300713          	li	a4,3
    800073d4:	00e78023          	sb	a4,0(a5)
    800073d8:	000780a3          	sb	zero,1(a5)
    800073dc:	00e781a3          	sb	a4,3(a5)
    800073e0:	00700693          	li	a3,7
    800073e4:	00d78123          	sb	a3,2(a5)
    800073e8:	00e780a3          	sb	a4,1(a5)
    800073ec:	00813403          	ld	s0,8(sp)
    800073f0:	01010113          	addi	sp,sp,16
    800073f4:	00008067          	ret

00000000800073f8 <uartputc>:
    800073f8:	00004797          	auipc	a5,0x4
    800073fc:	5107a783          	lw	a5,1296(a5) # 8000b908 <panicked>
    80007400:	00078463          	beqz	a5,80007408 <uartputc+0x10>
    80007404:	0000006f          	j	80007404 <uartputc+0xc>
    80007408:	fd010113          	addi	sp,sp,-48
    8000740c:	02813023          	sd	s0,32(sp)
    80007410:	00913c23          	sd	s1,24(sp)
    80007414:	01213823          	sd	s2,16(sp)
    80007418:	01313423          	sd	s3,8(sp)
    8000741c:	02113423          	sd	ra,40(sp)
    80007420:	03010413          	addi	s0,sp,48
    80007424:	00004917          	auipc	s2,0x4
    80007428:	4ec90913          	addi	s2,s2,1260 # 8000b910 <uart_tx_r>
    8000742c:	00093783          	ld	a5,0(s2)
    80007430:	00004497          	auipc	s1,0x4
    80007434:	4e848493          	addi	s1,s1,1256 # 8000b918 <uart_tx_w>
    80007438:	0004b703          	ld	a4,0(s1)
    8000743c:	02078693          	addi	a3,a5,32
    80007440:	00050993          	mv	s3,a0
    80007444:	02e69c63          	bne	a3,a4,8000747c <uartputc+0x84>
    80007448:	00001097          	auipc	ra,0x1
    8000744c:	834080e7          	jalr	-1996(ra) # 80007c7c <push_on>
    80007450:	00093783          	ld	a5,0(s2)
    80007454:	0004b703          	ld	a4,0(s1)
    80007458:	02078793          	addi	a5,a5,32
    8000745c:	00e79463          	bne	a5,a4,80007464 <uartputc+0x6c>
    80007460:	0000006f          	j	80007460 <uartputc+0x68>
    80007464:	00001097          	auipc	ra,0x1
    80007468:	88c080e7          	jalr	-1908(ra) # 80007cf0 <pop_on>
    8000746c:	00093783          	ld	a5,0(s2)
    80007470:	0004b703          	ld	a4,0(s1)
    80007474:	02078693          	addi	a3,a5,32
    80007478:	fce688e3          	beq	a3,a4,80007448 <uartputc+0x50>
    8000747c:	01f77693          	andi	a3,a4,31
    80007480:	0000a597          	auipc	a1,0xa
    80007484:	8c058593          	addi	a1,a1,-1856 # 80010d40 <uart_tx_buf>
    80007488:	00d586b3          	add	a3,a1,a3
    8000748c:	00170713          	addi	a4,a4,1
    80007490:	01368023          	sb	s3,0(a3)
    80007494:	00e4b023          	sd	a4,0(s1)
    80007498:	10000637          	lui	a2,0x10000
    8000749c:	02f71063          	bne	a4,a5,800074bc <uartputc+0xc4>
    800074a0:	0340006f          	j	800074d4 <uartputc+0xdc>
    800074a4:	00074703          	lbu	a4,0(a4)
    800074a8:	00f93023          	sd	a5,0(s2)
    800074ac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800074b0:	00093783          	ld	a5,0(s2)
    800074b4:	0004b703          	ld	a4,0(s1)
    800074b8:	00f70e63          	beq	a4,a5,800074d4 <uartputc+0xdc>
    800074bc:	00564683          	lbu	a3,5(a2)
    800074c0:	01f7f713          	andi	a4,a5,31
    800074c4:	00e58733          	add	a4,a1,a4
    800074c8:	0206f693          	andi	a3,a3,32
    800074cc:	00178793          	addi	a5,a5,1
    800074d0:	fc069ae3          	bnez	a3,800074a4 <uartputc+0xac>
    800074d4:	02813083          	ld	ra,40(sp)
    800074d8:	02013403          	ld	s0,32(sp)
    800074dc:	01813483          	ld	s1,24(sp)
    800074e0:	01013903          	ld	s2,16(sp)
    800074e4:	00813983          	ld	s3,8(sp)
    800074e8:	03010113          	addi	sp,sp,48
    800074ec:	00008067          	ret

00000000800074f0 <uartputc_sync>:
    800074f0:	ff010113          	addi	sp,sp,-16
    800074f4:	00813423          	sd	s0,8(sp)
    800074f8:	01010413          	addi	s0,sp,16
    800074fc:	00004717          	auipc	a4,0x4
    80007500:	40c72703          	lw	a4,1036(a4) # 8000b908 <panicked>
    80007504:	02071663          	bnez	a4,80007530 <uartputc_sync+0x40>
    80007508:	00050793          	mv	a5,a0
    8000750c:	100006b7          	lui	a3,0x10000
    80007510:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007514:	02077713          	andi	a4,a4,32
    80007518:	fe070ce3          	beqz	a4,80007510 <uartputc_sync+0x20>
    8000751c:	0ff7f793          	andi	a5,a5,255
    80007520:	00f68023          	sb	a5,0(a3)
    80007524:	00813403          	ld	s0,8(sp)
    80007528:	01010113          	addi	sp,sp,16
    8000752c:	00008067          	ret
    80007530:	0000006f          	j	80007530 <uartputc_sync+0x40>

0000000080007534 <uartstart>:
    80007534:	ff010113          	addi	sp,sp,-16
    80007538:	00813423          	sd	s0,8(sp)
    8000753c:	01010413          	addi	s0,sp,16
    80007540:	00004617          	auipc	a2,0x4
    80007544:	3d060613          	addi	a2,a2,976 # 8000b910 <uart_tx_r>
    80007548:	00004517          	auipc	a0,0x4
    8000754c:	3d050513          	addi	a0,a0,976 # 8000b918 <uart_tx_w>
    80007550:	00063783          	ld	a5,0(a2)
    80007554:	00053703          	ld	a4,0(a0)
    80007558:	04f70263          	beq	a4,a5,8000759c <uartstart+0x68>
    8000755c:	100005b7          	lui	a1,0x10000
    80007560:	00009817          	auipc	a6,0x9
    80007564:	7e080813          	addi	a6,a6,2016 # 80010d40 <uart_tx_buf>
    80007568:	01c0006f          	j	80007584 <uartstart+0x50>
    8000756c:	0006c703          	lbu	a4,0(a3)
    80007570:	00f63023          	sd	a5,0(a2)
    80007574:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007578:	00063783          	ld	a5,0(a2)
    8000757c:	00053703          	ld	a4,0(a0)
    80007580:	00f70e63          	beq	a4,a5,8000759c <uartstart+0x68>
    80007584:	01f7f713          	andi	a4,a5,31
    80007588:	00e806b3          	add	a3,a6,a4
    8000758c:	0055c703          	lbu	a4,5(a1)
    80007590:	00178793          	addi	a5,a5,1
    80007594:	02077713          	andi	a4,a4,32
    80007598:	fc071ae3          	bnez	a4,8000756c <uartstart+0x38>
    8000759c:	00813403          	ld	s0,8(sp)
    800075a0:	01010113          	addi	sp,sp,16
    800075a4:	00008067          	ret

00000000800075a8 <uartgetc>:
    800075a8:	ff010113          	addi	sp,sp,-16
    800075ac:	00813423          	sd	s0,8(sp)
    800075b0:	01010413          	addi	s0,sp,16
    800075b4:	10000737          	lui	a4,0x10000
    800075b8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800075bc:	0017f793          	andi	a5,a5,1
    800075c0:	00078c63          	beqz	a5,800075d8 <uartgetc+0x30>
    800075c4:	00074503          	lbu	a0,0(a4)
    800075c8:	0ff57513          	andi	a0,a0,255
    800075cc:	00813403          	ld	s0,8(sp)
    800075d0:	01010113          	addi	sp,sp,16
    800075d4:	00008067          	ret
    800075d8:	fff00513          	li	a0,-1
    800075dc:	ff1ff06f          	j	800075cc <uartgetc+0x24>

00000000800075e0 <uartintr>:
    800075e0:	100007b7          	lui	a5,0x10000
    800075e4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800075e8:	0017f793          	andi	a5,a5,1
    800075ec:	0a078463          	beqz	a5,80007694 <uartintr+0xb4>
    800075f0:	fe010113          	addi	sp,sp,-32
    800075f4:	00813823          	sd	s0,16(sp)
    800075f8:	00913423          	sd	s1,8(sp)
    800075fc:	00113c23          	sd	ra,24(sp)
    80007600:	02010413          	addi	s0,sp,32
    80007604:	100004b7          	lui	s1,0x10000
    80007608:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000760c:	0ff57513          	andi	a0,a0,255
    80007610:	fffff097          	auipc	ra,0xfffff
    80007614:	534080e7          	jalr	1332(ra) # 80006b44 <consoleintr>
    80007618:	0054c783          	lbu	a5,5(s1)
    8000761c:	0017f793          	andi	a5,a5,1
    80007620:	fe0794e3          	bnez	a5,80007608 <uartintr+0x28>
    80007624:	00004617          	auipc	a2,0x4
    80007628:	2ec60613          	addi	a2,a2,748 # 8000b910 <uart_tx_r>
    8000762c:	00004517          	auipc	a0,0x4
    80007630:	2ec50513          	addi	a0,a0,748 # 8000b918 <uart_tx_w>
    80007634:	00063783          	ld	a5,0(a2)
    80007638:	00053703          	ld	a4,0(a0)
    8000763c:	04f70263          	beq	a4,a5,80007680 <uartintr+0xa0>
    80007640:	100005b7          	lui	a1,0x10000
    80007644:	00009817          	auipc	a6,0x9
    80007648:	6fc80813          	addi	a6,a6,1788 # 80010d40 <uart_tx_buf>
    8000764c:	01c0006f          	j	80007668 <uartintr+0x88>
    80007650:	0006c703          	lbu	a4,0(a3)
    80007654:	00f63023          	sd	a5,0(a2)
    80007658:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000765c:	00063783          	ld	a5,0(a2)
    80007660:	00053703          	ld	a4,0(a0)
    80007664:	00f70e63          	beq	a4,a5,80007680 <uartintr+0xa0>
    80007668:	01f7f713          	andi	a4,a5,31
    8000766c:	00e806b3          	add	a3,a6,a4
    80007670:	0055c703          	lbu	a4,5(a1)
    80007674:	00178793          	addi	a5,a5,1
    80007678:	02077713          	andi	a4,a4,32
    8000767c:	fc071ae3          	bnez	a4,80007650 <uartintr+0x70>
    80007680:	01813083          	ld	ra,24(sp)
    80007684:	01013403          	ld	s0,16(sp)
    80007688:	00813483          	ld	s1,8(sp)
    8000768c:	02010113          	addi	sp,sp,32
    80007690:	00008067          	ret
    80007694:	00004617          	auipc	a2,0x4
    80007698:	27c60613          	addi	a2,a2,636 # 8000b910 <uart_tx_r>
    8000769c:	00004517          	auipc	a0,0x4
    800076a0:	27c50513          	addi	a0,a0,636 # 8000b918 <uart_tx_w>
    800076a4:	00063783          	ld	a5,0(a2)
    800076a8:	00053703          	ld	a4,0(a0)
    800076ac:	04f70263          	beq	a4,a5,800076f0 <uartintr+0x110>
    800076b0:	100005b7          	lui	a1,0x10000
    800076b4:	00009817          	auipc	a6,0x9
    800076b8:	68c80813          	addi	a6,a6,1676 # 80010d40 <uart_tx_buf>
    800076bc:	01c0006f          	j	800076d8 <uartintr+0xf8>
    800076c0:	0006c703          	lbu	a4,0(a3)
    800076c4:	00f63023          	sd	a5,0(a2)
    800076c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800076cc:	00063783          	ld	a5,0(a2)
    800076d0:	00053703          	ld	a4,0(a0)
    800076d4:	02f70063          	beq	a4,a5,800076f4 <uartintr+0x114>
    800076d8:	01f7f713          	andi	a4,a5,31
    800076dc:	00e806b3          	add	a3,a6,a4
    800076e0:	0055c703          	lbu	a4,5(a1)
    800076e4:	00178793          	addi	a5,a5,1
    800076e8:	02077713          	andi	a4,a4,32
    800076ec:	fc071ae3          	bnez	a4,800076c0 <uartintr+0xe0>
    800076f0:	00008067          	ret
    800076f4:	00008067          	ret

00000000800076f8 <kinit>:
    800076f8:	fc010113          	addi	sp,sp,-64
    800076fc:	02913423          	sd	s1,40(sp)
    80007700:	fffff7b7          	lui	a5,0xfffff
    80007704:	0000a497          	auipc	s1,0xa
    80007708:	65b48493          	addi	s1,s1,1627 # 80011d5f <end+0xfff>
    8000770c:	02813823          	sd	s0,48(sp)
    80007710:	01313c23          	sd	s3,24(sp)
    80007714:	00f4f4b3          	and	s1,s1,a5
    80007718:	02113c23          	sd	ra,56(sp)
    8000771c:	03213023          	sd	s2,32(sp)
    80007720:	01413823          	sd	s4,16(sp)
    80007724:	01513423          	sd	s5,8(sp)
    80007728:	04010413          	addi	s0,sp,64
    8000772c:	000017b7          	lui	a5,0x1
    80007730:	01100993          	li	s3,17
    80007734:	00f487b3          	add	a5,s1,a5
    80007738:	01b99993          	slli	s3,s3,0x1b
    8000773c:	06f9e063          	bltu	s3,a5,8000779c <kinit+0xa4>
    80007740:	00009a97          	auipc	s5,0x9
    80007744:	620a8a93          	addi	s5,s5,1568 # 80010d60 <end>
    80007748:	0754ec63          	bltu	s1,s5,800077c0 <kinit+0xc8>
    8000774c:	0734fa63          	bgeu	s1,s3,800077c0 <kinit+0xc8>
    80007750:	00088a37          	lui	s4,0x88
    80007754:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007758:	00004917          	auipc	s2,0x4
    8000775c:	1c890913          	addi	s2,s2,456 # 8000b920 <kmem>
    80007760:	00ca1a13          	slli	s4,s4,0xc
    80007764:	0140006f          	j	80007778 <kinit+0x80>
    80007768:	000017b7          	lui	a5,0x1
    8000776c:	00f484b3          	add	s1,s1,a5
    80007770:	0554e863          	bltu	s1,s5,800077c0 <kinit+0xc8>
    80007774:	0534f663          	bgeu	s1,s3,800077c0 <kinit+0xc8>
    80007778:	00001637          	lui	a2,0x1
    8000777c:	00100593          	li	a1,1
    80007780:	00048513          	mv	a0,s1
    80007784:	00000097          	auipc	ra,0x0
    80007788:	5e4080e7          	jalr	1508(ra) # 80007d68 <__memset>
    8000778c:	00093783          	ld	a5,0(s2)
    80007790:	00f4b023          	sd	a5,0(s1)
    80007794:	00993023          	sd	s1,0(s2)
    80007798:	fd4498e3          	bne	s1,s4,80007768 <kinit+0x70>
    8000779c:	03813083          	ld	ra,56(sp)
    800077a0:	03013403          	ld	s0,48(sp)
    800077a4:	02813483          	ld	s1,40(sp)
    800077a8:	02013903          	ld	s2,32(sp)
    800077ac:	01813983          	ld	s3,24(sp)
    800077b0:	01013a03          	ld	s4,16(sp)
    800077b4:	00813a83          	ld	s5,8(sp)
    800077b8:	04010113          	addi	sp,sp,64
    800077bc:	00008067          	ret
    800077c0:	00002517          	auipc	a0,0x2
    800077c4:	e8850513          	addi	a0,a0,-376 # 80009648 <digits+0x18>
    800077c8:	fffff097          	auipc	ra,0xfffff
    800077cc:	4b4080e7          	jalr	1204(ra) # 80006c7c <panic>

00000000800077d0 <freerange>:
    800077d0:	fc010113          	addi	sp,sp,-64
    800077d4:	000017b7          	lui	a5,0x1
    800077d8:	02913423          	sd	s1,40(sp)
    800077dc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800077e0:	009504b3          	add	s1,a0,s1
    800077e4:	fffff537          	lui	a0,0xfffff
    800077e8:	02813823          	sd	s0,48(sp)
    800077ec:	02113c23          	sd	ra,56(sp)
    800077f0:	03213023          	sd	s2,32(sp)
    800077f4:	01313c23          	sd	s3,24(sp)
    800077f8:	01413823          	sd	s4,16(sp)
    800077fc:	01513423          	sd	s5,8(sp)
    80007800:	01613023          	sd	s6,0(sp)
    80007804:	04010413          	addi	s0,sp,64
    80007808:	00a4f4b3          	and	s1,s1,a0
    8000780c:	00f487b3          	add	a5,s1,a5
    80007810:	06f5e463          	bltu	a1,a5,80007878 <freerange+0xa8>
    80007814:	00009a97          	auipc	s5,0x9
    80007818:	54ca8a93          	addi	s5,s5,1356 # 80010d60 <end>
    8000781c:	0954e263          	bltu	s1,s5,800078a0 <freerange+0xd0>
    80007820:	01100993          	li	s3,17
    80007824:	01b99993          	slli	s3,s3,0x1b
    80007828:	0734fc63          	bgeu	s1,s3,800078a0 <freerange+0xd0>
    8000782c:	00058a13          	mv	s4,a1
    80007830:	00004917          	auipc	s2,0x4
    80007834:	0f090913          	addi	s2,s2,240 # 8000b920 <kmem>
    80007838:	00002b37          	lui	s6,0x2
    8000783c:	0140006f          	j	80007850 <freerange+0x80>
    80007840:	000017b7          	lui	a5,0x1
    80007844:	00f484b3          	add	s1,s1,a5
    80007848:	0554ec63          	bltu	s1,s5,800078a0 <freerange+0xd0>
    8000784c:	0534fa63          	bgeu	s1,s3,800078a0 <freerange+0xd0>
    80007850:	00001637          	lui	a2,0x1
    80007854:	00100593          	li	a1,1
    80007858:	00048513          	mv	a0,s1
    8000785c:	00000097          	auipc	ra,0x0
    80007860:	50c080e7          	jalr	1292(ra) # 80007d68 <__memset>
    80007864:	00093703          	ld	a4,0(s2)
    80007868:	016487b3          	add	a5,s1,s6
    8000786c:	00e4b023          	sd	a4,0(s1)
    80007870:	00993023          	sd	s1,0(s2)
    80007874:	fcfa76e3          	bgeu	s4,a5,80007840 <freerange+0x70>
    80007878:	03813083          	ld	ra,56(sp)
    8000787c:	03013403          	ld	s0,48(sp)
    80007880:	02813483          	ld	s1,40(sp)
    80007884:	02013903          	ld	s2,32(sp)
    80007888:	01813983          	ld	s3,24(sp)
    8000788c:	01013a03          	ld	s4,16(sp)
    80007890:	00813a83          	ld	s5,8(sp)
    80007894:	00013b03          	ld	s6,0(sp)
    80007898:	04010113          	addi	sp,sp,64
    8000789c:	00008067          	ret
    800078a0:	00002517          	auipc	a0,0x2
    800078a4:	da850513          	addi	a0,a0,-600 # 80009648 <digits+0x18>
    800078a8:	fffff097          	auipc	ra,0xfffff
    800078ac:	3d4080e7          	jalr	980(ra) # 80006c7c <panic>

00000000800078b0 <kfree>:
    800078b0:	fe010113          	addi	sp,sp,-32
    800078b4:	00813823          	sd	s0,16(sp)
    800078b8:	00113c23          	sd	ra,24(sp)
    800078bc:	00913423          	sd	s1,8(sp)
    800078c0:	02010413          	addi	s0,sp,32
    800078c4:	03451793          	slli	a5,a0,0x34
    800078c8:	04079c63          	bnez	a5,80007920 <kfree+0x70>
    800078cc:	00009797          	auipc	a5,0x9
    800078d0:	49478793          	addi	a5,a5,1172 # 80010d60 <end>
    800078d4:	00050493          	mv	s1,a0
    800078d8:	04f56463          	bltu	a0,a5,80007920 <kfree+0x70>
    800078dc:	01100793          	li	a5,17
    800078e0:	01b79793          	slli	a5,a5,0x1b
    800078e4:	02f57e63          	bgeu	a0,a5,80007920 <kfree+0x70>
    800078e8:	00001637          	lui	a2,0x1
    800078ec:	00100593          	li	a1,1
    800078f0:	00000097          	auipc	ra,0x0
    800078f4:	478080e7          	jalr	1144(ra) # 80007d68 <__memset>
    800078f8:	00004797          	auipc	a5,0x4
    800078fc:	02878793          	addi	a5,a5,40 # 8000b920 <kmem>
    80007900:	0007b703          	ld	a4,0(a5)
    80007904:	01813083          	ld	ra,24(sp)
    80007908:	01013403          	ld	s0,16(sp)
    8000790c:	00e4b023          	sd	a4,0(s1)
    80007910:	0097b023          	sd	s1,0(a5)
    80007914:	00813483          	ld	s1,8(sp)
    80007918:	02010113          	addi	sp,sp,32
    8000791c:	00008067          	ret
    80007920:	00002517          	auipc	a0,0x2
    80007924:	d2850513          	addi	a0,a0,-728 # 80009648 <digits+0x18>
    80007928:	fffff097          	auipc	ra,0xfffff
    8000792c:	354080e7          	jalr	852(ra) # 80006c7c <panic>

0000000080007930 <kalloc>:
    80007930:	fe010113          	addi	sp,sp,-32
    80007934:	00813823          	sd	s0,16(sp)
    80007938:	00913423          	sd	s1,8(sp)
    8000793c:	00113c23          	sd	ra,24(sp)
    80007940:	02010413          	addi	s0,sp,32
    80007944:	00004797          	auipc	a5,0x4
    80007948:	fdc78793          	addi	a5,a5,-36 # 8000b920 <kmem>
    8000794c:	0007b483          	ld	s1,0(a5)
    80007950:	02048063          	beqz	s1,80007970 <kalloc+0x40>
    80007954:	0004b703          	ld	a4,0(s1)
    80007958:	00001637          	lui	a2,0x1
    8000795c:	00500593          	li	a1,5
    80007960:	00048513          	mv	a0,s1
    80007964:	00e7b023          	sd	a4,0(a5)
    80007968:	00000097          	auipc	ra,0x0
    8000796c:	400080e7          	jalr	1024(ra) # 80007d68 <__memset>
    80007970:	01813083          	ld	ra,24(sp)
    80007974:	01013403          	ld	s0,16(sp)
    80007978:	00048513          	mv	a0,s1
    8000797c:	00813483          	ld	s1,8(sp)
    80007980:	02010113          	addi	sp,sp,32
    80007984:	00008067          	ret

0000000080007988 <initlock>:
    80007988:	ff010113          	addi	sp,sp,-16
    8000798c:	00813423          	sd	s0,8(sp)
    80007990:	01010413          	addi	s0,sp,16
    80007994:	00813403          	ld	s0,8(sp)
    80007998:	00b53423          	sd	a1,8(a0)
    8000799c:	00052023          	sw	zero,0(a0)
    800079a0:	00053823          	sd	zero,16(a0)
    800079a4:	01010113          	addi	sp,sp,16
    800079a8:	00008067          	ret

00000000800079ac <acquire>:
    800079ac:	fe010113          	addi	sp,sp,-32
    800079b0:	00813823          	sd	s0,16(sp)
    800079b4:	00913423          	sd	s1,8(sp)
    800079b8:	00113c23          	sd	ra,24(sp)
    800079bc:	01213023          	sd	s2,0(sp)
    800079c0:	02010413          	addi	s0,sp,32
    800079c4:	00050493          	mv	s1,a0
    800079c8:	10002973          	csrr	s2,sstatus
    800079cc:	100027f3          	csrr	a5,sstatus
    800079d0:	ffd7f793          	andi	a5,a5,-3
    800079d4:	10079073          	csrw	sstatus,a5
    800079d8:	fffff097          	auipc	ra,0xfffff
    800079dc:	8ec080e7          	jalr	-1812(ra) # 800062c4 <mycpu>
    800079e0:	07852783          	lw	a5,120(a0)
    800079e4:	06078e63          	beqz	a5,80007a60 <acquire+0xb4>
    800079e8:	fffff097          	auipc	ra,0xfffff
    800079ec:	8dc080e7          	jalr	-1828(ra) # 800062c4 <mycpu>
    800079f0:	07852783          	lw	a5,120(a0)
    800079f4:	0004a703          	lw	a4,0(s1)
    800079f8:	0017879b          	addiw	a5,a5,1
    800079fc:	06f52c23          	sw	a5,120(a0)
    80007a00:	04071063          	bnez	a4,80007a40 <acquire+0x94>
    80007a04:	00100713          	li	a4,1
    80007a08:	00070793          	mv	a5,a4
    80007a0c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007a10:	0007879b          	sext.w	a5,a5
    80007a14:	fe079ae3          	bnez	a5,80007a08 <acquire+0x5c>
    80007a18:	0ff0000f          	fence
    80007a1c:	fffff097          	auipc	ra,0xfffff
    80007a20:	8a8080e7          	jalr	-1880(ra) # 800062c4 <mycpu>
    80007a24:	01813083          	ld	ra,24(sp)
    80007a28:	01013403          	ld	s0,16(sp)
    80007a2c:	00a4b823          	sd	a0,16(s1)
    80007a30:	00013903          	ld	s2,0(sp)
    80007a34:	00813483          	ld	s1,8(sp)
    80007a38:	02010113          	addi	sp,sp,32
    80007a3c:	00008067          	ret
    80007a40:	0104b903          	ld	s2,16(s1)
    80007a44:	fffff097          	auipc	ra,0xfffff
    80007a48:	880080e7          	jalr	-1920(ra) # 800062c4 <mycpu>
    80007a4c:	faa91ce3          	bne	s2,a0,80007a04 <acquire+0x58>
    80007a50:	00002517          	auipc	a0,0x2
    80007a54:	c0050513          	addi	a0,a0,-1024 # 80009650 <digits+0x20>
    80007a58:	fffff097          	auipc	ra,0xfffff
    80007a5c:	224080e7          	jalr	548(ra) # 80006c7c <panic>
    80007a60:	00195913          	srli	s2,s2,0x1
    80007a64:	fffff097          	auipc	ra,0xfffff
    80007a68:	860080e7          	jalr	-1952(ra) # 800062c4 <mycpu>
    80007a6c:	00197913          	andi	s2,s2,1
    80007a70:	07252e23          	sw	s2,124(a0)
    80007a74:	f75ff06f          	j	800079e8 <acquire+0x3c>

0000000080007a78 <release>:
    80007a78:	fe010113          	addi	sp,sp,-32
    80007a7c:	00813823          	sd	s0,16(sp)
    80007a80:	00113c23          	sd	ra,24(sp)
    80007a84:	00913423          	sd	s1,8(sp)
    80007a88:	01213023          	sd	s2,0(sp)
    80007a8c:	02010413          	addi	s0,sp,32
    80007a90:	00052783          	lw	a5,0(a0)
    80007a94:	00079a63          	bnez	a5,80007aa8 <release+0x30>
    80007a98:	00002517          	auipc	a0,0x2
    80007a9c:	bc050513          	addi	a0,a0,-1088 # 80009658 <digits+0x28>
    80007aa0:	fffff097          	auipc	ra,0xfffff
    80007aa4:	1dc080e7          	jalr	476(ra) # 80006c7c <panic>
    80007aa8:	01053903          	ld	s2,16(a0)
    80007aac:	00050493          	mv	s1,a0
    80007ab0:	fffff097          	auipc	ra,0xfffff
    80007ab4:	814080e7          	jalr	-2028(ra) # 800062c4 <mycpu>
    80007ab8:	fea910e3          	bne	s2,a0,80007a98 <release+0x20>
    80007abc:	0004b823          	sd	zero,16(s1)
    80007ac0:	0ff0000f          	fence
    80007ac4:	0f50000f          	fence	iorw,ow
    80007ac8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007acc:	ffffe097          	auipc	ra,0xffffe
    80007ad0:	7f8080e7          	jalr	2040(ra) # 800062c4 <mycpu>
    80007ad4:	100027f3          	csrr	a5,sstatus
    80007ad8:	0027f793          	andi	a5,a5,2
    80007adc:	04079a63          	bnez	a5,80007b30 <release+0xb8>
    80007ae0:	07852783          	lw	a5,120(a0)
    80007ae4:	02f05e63          	blez	a5,80007b20 <release+0xa8>
    80007ae8:	fff7871b          	addiw	a4,a5,-1
    80007aec:	06e52c23          	sw	a4,120(a0)
    80007af0:	00071c63          	bnez	a4,80007b08 <release+0x90>
    80007af4:	07c52783          	lw	a5,124(a0)
    80007af8:	00078863          	beqz	a5,80007b08 <release+0x90>
    80007afc:	100027f3          	csrr	a5,sstatus
    80007b00:	0027e793          	ori	a5,a5,2
    80007b04:	10079073          	csrw	sstatus,a5
    80007b08:	01813083          	ld	ra,24(sp)
    80007b0c:	01013403          	ld	s0,16(sp)
    80007b10:	00813483          	ld	s1,8(sp)
    80007b14:	00013903          	ld	s2,0(sp)
    80007b18:	02010113          	addi	sp,sp,32
    80007b1c:	00008067          	ret
    80007b20:	00002517          	auipc	a0,0x2
    80007b24:	b5850513          	addi	a0,a0,-1192 # 80009678 <digits+0x48>
    80007b28:	fffff097          	auipc	ra,0xfffff
    80007b2c:	154080e7          	jalr	340(ra) # 80006c7c <panic>
    80007b30:	00002517          	auipc	a0,0x2
    80007b34:	b3050513          	addi	a0,a0,-1232 # 80009660 <digits+0x30>
    80007b38:	fffff097          	auipc	ra,0xfffff
    80007b3c:	144080e7          	jalr	324(ra) # 80006c7c <panic>

0000000080007b40 <holding>:
    80007b40:	00052783          	lw	a5,0(a0)
    80007b44:	00079663          	bnez	a5,80007b50 <holding+0x10>
    80007b48:	00000513          	li	a0,0
    80007b4c:	00008067          	ret
    80007b50:	fe010113          	addi	sp,sp,-32
    80007b54:	00813823          	sd	s0,16(sp)
    80007b58:	00913423          	sd	s1,8(sp)
    80007b5c:	00113c23          	sd	ra,24(sp)
    80007b60:	02010413          	addi	s0,sp,32
    80007b64:	01053483          	ld	s1,16(a0)
    80007b68:	ffffe097          	auipc	ra,0xffffe
    80007b6c:	75c080e7          	jalr	1884(ra) # 800062c4 <mycpu>
    80007b70:	01813083          	ld	ra,24(sp)
    80007b74:	01013403          	ld	s0,16(sp)
    80007b78:	40a48533          	sub	a0,s1,a0
    80007b7c:	00153513          	seqz	a0,a0
    80007b80:	00813483          	ld	s1,8(sp)
    80007b84:	02010113          	addi	sp,sp,32
    80007b88:	00008067          	ret

0000000080007b8c <push_off>:
    80007b8c:	fe010113          	addi	sp,sp,-32
    80007b90:	00813823          	sd	s0,16(sp)
    80007b94:	00113c23          	sd	ra,24(sp)
    80007b98:	00913423          	sd	s1,8(sp)
    80007b9c:	02010413          	addi	s0,sp,32
    80007ba0:	100024f3          	csrr	s1,sstatus
    80007ba4:	100027f3          	csrr	a5,sstatus
    80007ba8:	ffd7f793          	andi	a5,a5,-3
    80007bac:	10079073          	csrw	sstatus,a5
    80007bb0:	ffffe097          	auipc	ra,0xffffe
    80007bb4:	714080e7          	jalr	1812(ra) # 800062c4 <mycpu>
    80007bb8:	07852783          	lw	a5,120(a0)
    80007bbc:	02078663          	beqz	a5,80007be8 <push_off+0x5c>
    80007bc0:	ffffe097          	auipc	ra,0xffffe
    80007bc4:	704080e7          	jalr	1796(ra) # 800062c4 <mycpu>
    80007bc8:	07852783          	lw	a5,120(a0)
    80007bcc:	01813083          	ld	ra,24(sp)
    80007bd0:	01013403          	ld	s0,16(sp)
    80007bd4:	0017879b          	addiw	a5,a5,1
    80007bd8:	06f52c23          	sw	a5,120(a0)
    80007bdc:	00813483          	ld	s1,8(sp)
    80007be0:	02010113          	addi	sp,sp,32
    80007be4:	00008067          	ret
    80007be8:	0014d493          	srli	s1,s1,0x1
    80007bec:	ffffe097          	auipc	ra,0xffffe
    80007bf0:	6d8080e7          	jalr	1752(ra) # 800062c4 <mycpu>
    80007bf4:	0014f493          	andi	s1,s1,1
    80007bf8:	06952e23          	sw	s1,124(a0)
    80007bfc:	fc5ff06f          	j	80007bc0 <push_off+0x34>

0000000080007c00 <pop_off>:
    80007c00:	ff010113          	addi	sp,sp,-16
    80007c04:	00813023          	sd	s0,0(sp)
    80007c08:	00113423          	sd	ra,8(sp)
    80007c0c:	01010413          	addi	s0,sp,16
    80007c10:	ffffe097          	auipc	ra,0xffffe
    80007c14:	6b4080e7          	jalr	1716(ra) # 800062c4 <mycpu>
    80007c18:	100027f3          	csrr	a5,sstatus
    80007c1c:	0027f793          	andi	a5,a5,2
    80007c20:	04079663          	bnez	a5,80007c6c <pop_off+0x6c>
    80007c24:	07852783          	lw	a5,120(a0)
    80007c28:	02f05a63          	blez	a5,80007c5c <pop_off+0x5c>
    80007c2c:	fff7871b          	addiw	a4,a5,-1
    80007c30:	06e52c23          	sw	a4,120(a0)
    80007c34:	00071c63          	bnez	a4,80007c4c <pop_off+0x4c>
    80007c38:	07c52783          	lw	a5,124(a0)
    80007c3c:	00078863          	beqz	a5,80007c4c <pop_off+0x4c>
    80007c40:	100027f3          	csrr	a5,sstatus
    80007c44:	0027e793          	ori	a5,a5,2
    80007c48:	10079073          	csrw	sstatus,a5
    80007c4c:	00813083          	ld	ra,8(sp)
    80007c50:	00013403          	ld	s0,0(sp)
    80007c54:	01010113          	addi	sp,sp,16
    80007c58:	00008067          	ret
    80007c5c:	00002517          	auipc	a0,0x2
    80007c60:	a1c50513          	addi	a0,a0,-1508 # 80009678 <digits+0x48>
    80007c64:	fffff097          	auipc	ra,0xfffff
    80007c68:	018080e7          	jalr	24(ra) # 80006c7c <panic>
    80007c6c:	00002517          	auipc	a0,0x2
    80007c70:	9f450513          	addi	a0,a0,-1548 # 80009660 <digits+0x30>
    80007c74:	fffff097          	auipc	ra,0xfffff
    80007c78:	008080e7          	jalr	8(ra) # 80006c7c <panic>

0000000080007c7c <push_on>:
    80007c7c:	fe010113          	addi	sp,sp,-32
    80007c80:	00813823          	sd	s0,16(sp)
    80007c84:	00113c23          	sd	ra,24(sp)
    80007c88:	00913423          	sd	s1,8(sp)
    80007c8c:	02010413          	addi	s0,sp,32
    80007c90:	100024f3          	csrr	s1,sstatus
    80007c94:	100027f3          	csrr	a5,sstatus
    80007c98:	0027e793          	ori	a5,a5,2
    80007c9c:	10079073          	csrw	sstatus,a5
    80007ca0:	ffffe097          	auipc	ra,0xffffe
    80007ca4:	624080e7          	jalr	1572(ra) # 800062c4 <mycpu>
    80007ca8:	07852783          	lw	a5,120(a0)
    80007cac:	02078663          	beqz	a5,80007cd8 <push_on+0x5c>
    80007cb0:	ffffe097          	auipc	ra,0xffffe
    80007cb4:	614080e7          	jalr	1556(ra) # 800062c4 <mycpu>
    80007cb8:	07852783          	lw	a5,120(a0)
    80007cbc:	01813083          	ld	ra,24(sp)
    80007cc0:	01013403          	ld	s0,16(sp)
    80007cc4:	0017879b          	addiw	a5,a5,1
    80007cc8:	06f52c23          	sw	a5,120(a0)
    80007ccc:	00813483          	ld	s1,8(sp)
    80007cd0:	02010113          	addi	sp,sp,32
    80007cd4:	00008067          	ret
    80007cd8:	0014d493          	srli	s1,s1,0x1
    80007cdc:	ffffe097          	auipc	ra,0xffffe
    80007ce0:	5e8080e7          	jalr	1512(ra) # 800062c4 <mycpu>
    80007ce4:	0014f493          	andi	s1,s1,1
    80007ce8:	06952e23          	sw	s1,124(a0)
    80007cec:	fc5ff06f          	j	80007cb0 <push_on+0x34>

0000000080007cf0 <pop_on>:
    80007cf0:	ff010113          	addi	sp,sp,-16
    80007cf4:	00813023          	sd	s0,0(sp)
    80007cf8:	00113423          	sd	ra,8(sp)
    80007cfc:	01010413          	addi	s0,sp,16
    80007d00:	ffffe097          	auipc	ra,0xffffe
    80007d04:	5c4080e7          	jalr	1476(ra) # 800062c4 <mycpu>
    80007d08:	100027f3          	csrr	a5,sstatus
    80007d0c:	0027f793          	andi	a5,a5,2
    80007d10:	04078463          	beqz	a5,80007d58 <pop_on+0x68>
    80007d14:	07852783          	lw	a5,120(a0)
    80007d18:	02f05863          	blez	a5,80007d48 <pop_on+0x58>
    80007d1c:	fff7879b          	addiw	a5,a5,-1
    80007d20:	06f52c23          	sw	a5,120(a0)
    80007d24:	07853783          	ld	a5,120(a0)
    80007d28:	00079863          	bnez	a5,80007d38 <pop_on+0x48>
    80007d2c:	100027f3          	csrr	a5,sstatus
    80007d30:	ffd7f793          	andi	a5,a5,-3
    80007d34:	10079073          	csrw	sstatus,a5
    80007d38:	00813083          	ld	ra,8(sp)
    80007d3c:	00013403          	ld	s0,0(sp)
    80007d40:	01010113          	addi	sp,sp,16
    80007d44:	00008067          	ret
    80007d48:	00002517          	auipc	a0,0x2
    80007d4c:	95850513          	addi	a0,a0,-1704 # 800096a0 <digits+0x70>
    80007d50:	fffff097          	auipc	ra,0xfffff
    80007d54:	f2c080e7          	jalr	-212(ra) # 80006c7c <panic>
    80007d58:	00002517          	auipc	a0,0x2
    80007d5c:	92850513          	addi	a0,a0,-1752 # 80009680 <digits+0x50>
    80007d60:	fffff097          	auipc	ra,0xfffff
    80007d64:	f1c080e7          	jalr	-228(ra) # 80006c7c <panic>

0000000080007d68 <__memset>:
    80007d68:	ff010113          	addi	sp,sp,-16
    80007d6c:	00813423          	sd	s0,8(sp)
    80007d70:	01010413          	addi	s0,sp,16
    80007d74:	1a060e63          	beqz	a2,80007f30 <__memset+0x1c8>
    80007d78:	40a007b3          	neg	a5,a0
    80007d7c:	0077f793          	andi	a5,a5,7
    80007d80:	00778693          	addi	a3,a5,7
    80007d84:	00b00813          	li	a6,11
    80007d88:	0ff5f593          	andi	a1,a1,255
    80007d8c:	fff6071b          	addiw	a4,a2,-1
    80007d90:	1b06e663          	bltu	a3,a6,80007f3c <__memset+0x1d4>
    80007d94:	1cd76463          	bltu	a4,a3,80007f5c <__memset+0x1f4>
    80007d98:	1a078e63          	beqz	a5,80007f54 <__memset+0x1ec>
    80007d9c:	00b50023          	sb	a1,0(a0)
    80007da0:	00100713          	li	a4,1
    80007da4:	1ae78463          	beq	a5,a4,80007f4c <__memset+0x1e4>
    80007da8:	00b500a3          	sb	a1,1(a0)
    80007dac:	00200713          	li	a4,2
    80007db0:	1ae78a63          	beq	a5,a4,80007f64 <__memset+0x1fc>
    80007db4:	00b50123          	sb	a1,2(a0)
    80007db8:	00300713          	li	a4,3
    80007dbc:	18e78463          	beq	a5,a4,80007f44 <__memset+0x1dc>
    80007dc0:	00b501a3          	sb	a1,3(a0)
    80007dc4:	00400713          	li	a4,4
    80007dc8:	1ae78263          	beq	a5,a4,80007f6c <__memset+0x204>
    80007dcc:	00b50223          	sb	a1,4(a0)
    80007dd0:	00500713          	li	a4,5
    80007dd4:	1ae78063          	beq	a5,a4,80007f74 <__memset+0x20c>
    80007dd8:	00b502a3          	sb	a1,5(a0)
    80007ddc:	00700713          	li	a4,7
    80007de0:	18e79e63          	bne	a5,a4,80007f7c <__memset+0x214>
    80007de4:	00b50323          	sb	a1,6(a0)
    80007de8:	00700e93          	li	t4,7
    80007dec:	00859713          	slli	a4,a1,0x8
    80007df0:	00e5e733          	or	a4,a1,a4
    80007df4:	01059e13          	slli	t3,a1,0x10
    80007df8:	01c76e33          	or	t3,a4,t3
    80007dfc:	01859313          	slli	t1,a1,0x18
    80007e00:	006e6333          	or	t1,t3,t1
    80007e04:	02059893          	slli	a7,a1,0x20
    80007e08:	40f60e3b          	subw	t3,a2,a5
    80007e0c:	011368b3          	or	a7,t1,a7
    80007e10:	02859813          	slli	a6,a1,0x28
    80007e14:	0108e833          	or	a6,a7,a6
    80007e18:	03059693          	slli	a3,a1,0x30
    80007e1c:	003e589b          	srliw	a7,t3,0x3
    80007e20:	00d866b3          	or	a3,a6,a3
    80007e24:	03859713          	slli	a4,a1,0x38
    80007e28:	00389813          	slli	a6,a7,0x3
    80007e2c:	00f507b3          	add	a5,a0,a5
    80007e30:	00e6e733          	or	a4,a3,a4
    80007e34:	000e089b          	sext.w	a7,t3
    80007e38:	00f806b3          	add	a3,a6,a5
    80007e3c:	00e7b023          	sd	a4,0(a5)
    80007e40:	00878793          	addi	a5,a5,8
    80007e44:	fed79ce3          	bne	a5,a3,80007e3c <__memset+0xd4>
    80007e48:	ff8e7793          	andi	a5,t3,-8
    80007e4c:	0007871b          	sext.w	a4,a5
    80007e50:	01d787bb          	addw	a5,a5,t4
    80007e54:	0ce88e63          	beq	a7,a4,80007f30 <__memset+0x1c8>
    80007e58:	00f50733          	add	a4,a0,a5
    80007e5c:	00b70023          	sb	a1,0(a4)
    80007e60:	0017871b          	addiw	a4,a5,1
    80007e64:	0cc77663          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007e68:	00e50733          	add	a4,a0,a4
    80007e6c:	00b70023          	sb	a1,0(a4)
    80007e70:	0027871b          	addiw	a4,a5,2
    80007e74:	0ac77e63          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007e78:	00e50733          	add	a4,a0,a4
    80007e7c:	00b70023          	sb	a1,0(a4)
    80007e80:	0037871b          	addiw	a4,a5,3
    80007e84:	0ac77663          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007e88:	00e50733          	add	a4,a0,a4
    80007e8c:	00b70023          	sb	a1,0(a4)
    80007e90:	0047871b          	addiw	a4,a5,4
    80007e94:	08c77e63          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007e98:	00e50733          	add	a4,a0,a4
    80007e9c:	00b70023          	sb	a1,0(a4)
    80007ea0:	0057871b          	addiw	a4,a5,5
    80007ea4:	08c77663          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007ea8:	00e50733          	add	a4,a0,a4
    80007eac:	00b70023          	sb	a1,0(a4)
    80007eb0:	0067871b          	addiw	a4,a5,6
    80007eb4:	06c77e63          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007eb8:	00e50733          	add	a4,a0,a4
    80007ebc:	00b70023          	sb	a1,0(a4)
    80007ec0:	0077871b          	addiw	a4,a5,7
    80007ec4:	06c77663          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007ec8:	00e50733          	add	a4,a0,a4
    80007ecc:	00b70023          	sb	a1,0(a4)
    80007ed0:	0087871b          	addiw	a4,a5,8
    80007ed4:	04c77e63          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007ed8:	00e50733          	add	a4,a0,a4
    80007edc:	00b70023          	sb	a1,0(a4)
    80007ee0:	0097871b          	addiw	a4,a5,9
    80007ee4:	04c77663          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007ee8:	00e50733          	add	a4,a0,a4
    80007eec:	00b70023          	sb	a1,0(a4)
    80007ef0:	00a7871b          	addiw	a4,a5,10
    80007ef4:	02c77e63          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007ef8:	00e50733          	add	a4,a0,a4
    80007efc:	00b70023          	sb	a1,0(a4)
    80007f00:	00b7871b          	addiw	a4,a5,11
    80007f04:	02c77663          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007f08:	00e50733          	add	a4,a0,a4
    80007f0c:	00b70023          	sb	a1,0(a4)
    80007f10:	00c7871b          	addiw	a4,a5,12
    80007f14:	00c77e63          	bgeu	a4,a2,80007f30 <__memset+0x1c8>
    80007f18:	00e50733          	add	a4,a0,a4
    80007f1c:	00b70023          	sb	a1,0(a4)
    80007f20:	00d7879b          	addiw	a5,a5,13
    80007f24:	00c7f663          	bgeu	a5,a2,80007f30 <__memset+0x1c8>
    80007f28:	00f507b3          	add	a5,a0,a5
    80007f2c:	00b78023          	sb	a1,0(a5)
    80007f30:	00813403          	ld	s0,8(sp)
    80007f34:	01010113          	addi	sp,sp,16
    80007f38:	00008067          	ret
    80007f3c:	00b00693          	li	a3,11
    80007f40:	e55ff06f          	j	80007d94 <__memset+0x2c>
    80007f44:	00300e93          	li	t4,3
    80007f48:	ea5ff06f          	j	80007dec <__memset+0x84>
    80007f4c:	00100e93          	li	t4,1
    80007f50:	e9dff06f          	j	80007dec <__memset+0x84>
    80007f54:	00000e93          	li	t4,0
    80007f58:	e95ff06f          	j	80007dec <__memset+0x84>
    80007f5c:	00000793          	li	a5,0
    80007f60:	ef9ff06f          	j	80007e58 <__memset+0xf0>
    80007f64:	00200e93          	li	t4,2
    80007f68:	e85ff06f          	j	80007dec <__memset+0x84>
    80007f6c:	00400e93          	li	t4,4
    80007f70:	e7dff06f          	j	80007dec <__memset+0x84>
    80007f74:	00500e93          	li	t4,5
    80007f78:	e75ff06f          	j	80007dec <__memset+0x84>
    80007f7c:	00600e93          	li	t4,6
    80007f80:	e6dff06f          	j	80007dec <__memset+0x84>

0000000080007f84 <__memmove>:
    80007f84:	ff010113          	addi	sp,sp,-16
    80007f88:	00813423          	sd	s0,8(sp)
    80007f8c:	01010413          	addi	s0,sp,16
    80007f90:	0e060863          	beqz	a2,80008080 <__memmove+0xfc>
    80007f94:	fff6069b          	addiw	a3,a2,-1
    80007f98:	0006881b          	sext.w	a6,a3
    80007f9c:	0ea5e863          	bltu	a1,a0,8000808c <__memmove+0x108>
    80007fa0:	00758713          	addi	a4,a1,7
    80007fa4:	00a5e7b3          	or	a5,a1,a0
    80007fa8:	40a70733          	sub	a4,a4,a0
    80007fac:	0077f793          	andi	a5,a5,7
    80007fb0:	00f73713          	sltiu	a4,a4,15
    80007fb4:	00174713          	xori	a4,a4,1
    80007fb8:	0017b793          	seqz	a5,a5
    80007fbc:	00e7f7b3          	and	a5,a5,a4
    80007fc0:	10078863          	beqz	a5,800080d0 <__memmove+0x14c>
    80007fc4:	00900793          	li	a5,9
    80007fc8:	1107f463          	bgeu	a5,a6,800080d0 <__memmove+0x14c>
    80007fcc:	0036581b          	srliw	a6,a2,0x3
    80007fd0:	fff8081b          	addiw	a6,a6,-1
    80007fd4:	02081813          	slli	a6,a6,0x20
    80007fd8:	01d85893          	srli	a7,a6,0x1d
    80007fdc:	00858813          	addi	a6,a1,8
    80007fe0:	00058793          	mv	a5,a1
    80007fe4:	00050713          	mv	a4,a0
    80007fe8:	01088833          	add	a6,a7,a6
    80007fec:	0007b883          	ld	a7,0(a5)
    80007ff0:	00878793          	addi	a5,a5,8
    80007ff4:	00870713          	addi	a4,a4,8
    80007ff8:	ff173c23          	sd	a7,-8(a4)
    80007ffc:	ff0798e3          	bne	a5,a6,80007fec <__memmove+0x68>
    80008000:	ff867713          	andi	a4,a2,-8
    80008004:	02071793          	slli	a5,a4,0x20
    80008008:	0207d793          	srli	a5,a5,0x20
    8000800c:	00f585b3          	add	a1,a1,a5
    80008010:	40e686bb          	subw	a3,a3,a4
    80008014:	00f507b3          	add	a5,a0,a5
    80008018:	06e60463          	beq	a2,a4,80008080 <__memmove+0xfc>
    8000801c:	0005c703          	lbu	a4,0(a1)
    80008020:	00e78023          	sb	a4,0(a5)
    80008024:	04068e63          	beqz	a3,80008080 <__memmove+0xfc>
    80008028:	0015c603          	lbu	a2,1(a1)
    8000802c:	00100713          	li	a4,1
    80008030:	00c780a3          	sb	a2,1(a5)
    80008034:	04e68663          	beq	a3,a4,80008080 <__memmove+0xfc>
    80008038:	0025c603          	lbu	a2,2(a1)
    8000803c:	00200713          	li	a4,2
    80008040:	00c78123          	sb	a2,2(a5)
    80008044:	02e68e63          	beq	a3,a4,80008080 <__memmove+0xfc>
    80008048:	0035c603          	lbu	a2,3(a1)
    8000804c:	00300713          	li	a4,3
    80008050:	00c781a3          	sb	a2,3(a5)
    80008054:	02e68663          	beq	a3,a4,80008080 <__memmove+0xfc>
    80008058:	0045c603          	lbu	a2,4(a1)
    8000805c:	00400713          	li	a4,4
    80008060:	00c78223          	sb	a2,4(a5)
    80008064:	00e68e63          	beq	a3,a4,80008080 <__memmove+0xfc>
    80008068:	0055c603          	lbu	a2,5(a1)
    8000806c:	00500713          	li	a4,5
    80008070:	00c782a3          	sb	a2,5(a5)
    80008074:	00e68663          	beq	a3,a4,80008080 <__memmove+0xfc>
    80008078:	0065c703          	lbu	a4,6(a1)
    8000807c:	00e78323          	sb	a4,6(a5)
    80008080:	00813403          	ld	s0,8(sp)
    80008084:	01010113          	addi	sp,sp,16
    80008088:	00008067          	ret
    8000808c:	02061713          	slli	a4,a2,0x20
    80008090:	02075713          	srli	a4,a4,0x20
    80008094:	00e587b3          	add	a5,a1,a4
    80008098:	f0f574e3          	bgeu	a0,a5,80007fa0 <__memmove+0x1c>
    8000809c:	02069613          	slli	a2,a3,0x20
    800080a0:	02065613          	srli	a2,a2,0x20
    800080a4:	fff64613          	not	a2,a2
    800080a8:	00e50733          	add	a4,a0,a4
    800080ac:	00c78633          	add	a2,a5,a2
    800080b0:	fff7c683          	lbu	a3,-1(a5)
    800080b4:	fff78793          	addi	a5,a5,-1
    800080b8:	fff70713          	addi	a4,a4,-1
    800080bc:	00d70023          	sb	a3,0(a4)
    800080c0:	fec798e3          	bne	a5,a2,800080b0 <__memmove+0x12c>
    800080c4:	00813403          	ld	s0,8(sp)
    800080c8:	01010113          	addi	sp,sp,16
    800080cc:	00008067          	ret
    800080d0:	02069713          	slli	a4,a3,0x20
    800080d4:	02075713          	srli	a4,a4,0x20
    800080d8:	00170713          	addi	a4,a4,1
    800080dc:	00e50733          	add	a4,a0,a4
    800080e0:	00050793          	mv	a5,a0
    800080e4:	0005c683          	lbu	a3,0(a1)
    800080e8:	00178793          	addi	a5,a5,1
    800080ec:	00158593          	addi	a1,a1,1
    800080f0:	fed78fa3          	sb	a3,-1(a5)
    800080f4:	fee798e3          	bne	a5,a4,800080e4 <__memmove+0x160>
    800080f8:	f89ff06f          	j	80008080 <__memmove+0xfc>
	...
