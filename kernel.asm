
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	88013103          	ld	sp,-1920(sp) # 80006880 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1e0030ef          	jal	ra,800031fc <start>

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

0000000080001020 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001020:	ff010113          	addi	sp,sp,-16
    80001024:	00813423          	sd	s0,8(sp)
    80001028:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    8000102c:	03f50513          	addi	a0,a0,63 # 103f <_entry-0x7fffefc1>
    80001030:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001034:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001038:	00100513          	li	a0,1
    asm("ecall");
    8000103c:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001040:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001044:	00813403          	ld	s0,8(sp)
    80001048:	01010113          	addi	sp,sp,16
    8000104c:	00008067          	ret

0000000080001050 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001050:	ff010113          	addi	sp,sp,-16
    80001054:	00813423          	sd	s0,8(sp)
    80001058:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    8000105c:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001060:	00200513          	li	a0,2
    asm("ecall");
    80001064:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001068:	00050513          	mv	a0,a0
    return status;
}
    8000106c:	0005051b          	sext.w	a0,a0
    80001070:	00813403          	ld	s0,8(sp)
    80001074:	01010113          	addi	sp,sp,16
    80001078:	00008067          	ret

000000008000107c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    8000107c:	fd010113          	addi	sp,sp,-48
    80001080:	02113423          	sd	ra,40(sp)
    80001084:	02813023          	sd	s0,32(sp)
    80001088:	00913c23          	sd	s1,24(sp)
    8000108c:	01213823          	sd	s2,16(sp)
    80001090:	01313423          	sd	s3,8(sp)
    80001094:	03010413          	addi	s0,sp,48
    80001098:	00050913          	mv	s2,a0
    8000109c:	00058493          	mv	s1,a1
    800010a0:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    800010a4:	04058e63          	beqz	a1,80001100 <_Z13thread_createPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800010a8:	00001537          	lui	a0,0x1
    800010ac:	00000097          	auipc	ra,0x0
    800010b0:	f74080e7          	jalr	-140(ra) # 80001020 <_Z9mem_allocm>
        if(istack == 0) {
    800010b4:	04050063          	beqz	a0,800010f4 <_Z13thread_createPP7_threadPFvPvES2_+0x78>
            *handle = nullptr;
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800010b8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800010bc:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800010c0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800010c4:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    800010c8:	01100513          	li	a0,17

    asm("ecall");
    800010cc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800010d0:	00050513          	mv	a0,a0

    return status;
    800010d4:	0005051b          	sext.w	a0,a0
}
    800010d8:	02813083          	ld	ra,40(sp)
    800010dc:	02013403          	ld	s0,32(sp)
    800010e0:	01813483          	ld	s1,24(sp)
    800010e4:	01013903          	ld	s2,16(sp)
    800010e8:	00813983          	ld	s3,8(sp)
    800010ec:	03010113          	addi	sp,sp,48
    800010f0:	00008067          	ret
            *handle = nullptr;
    800010f4:	00093023          	sd	zero,0(s2)
            return -1;
    800010f8:	fff00513          	li	a0,-1
    800010fc:	fddff06f          	j	800010d8 <_Z13thread_createPP7_threadPFvPvES2_+0x5c>
    uint64 istack = 0;
    80001100:	00000513          	li	a0,0
    80001104:	fb5ff06f          	j	800010b8 <_Z13thread_createPP7_threadPFvPvES2_+0x3c>

0000000080001108 <_Z11thread_exitv>:

int thread_exit(){
    80001108:	ff010113          	addi	sp,sp,-16
    8000110c:	00813423          	sd	s0,8(sp)
    80001110:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001114:	01200513          	li	a0,18

    asm("ecall");
    80001118:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000111c:	00050513          	mv	a0,a0

    return status;
}
    80001120:	0005051b          	sext.w	a0,a0
    80001124:	00813403          	ld	s0,8(sp)
    80001128:	01010113          	addi	sp,sp,16
    8000112c:	00008067          	ret

0000000080001130 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001130:	ff010113          	addi	sp,sp,-16
    80001134:	00813423          	sd	s0,8(sp)
    80001138:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    8000113c:	01300513          	li	a0,19

    asm("ecall");
    80001140:	00000073          	ecall
}
    80001144:	00813403          	ld	s0,8(sp)
    80001148:	01010113          	addi	sp,sp,16
    8000114c:	00008067          	ret

0000000080001150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001150:	fd010113          	addi	sp,sp,-48
    80001154:	02113423          	sd	ra,40(sp)
    80001158:	02813023          	sd	s0,32(sp)
    8000115c:	00913c23          	sd	s1,24(sp)
    80001160:	01213823          	sd	s2,16(sp)
    80001164:	01313423          	sd	s3,8(sp)
    80001168:	03010413          	addi	s0,sp,48
    8000116c:	00050493          	mv	s1,a0
    80001170:	00058913          	mv	s2,a1
    80001174:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(handle && start_routine) {
    80001178:	04050a63          	beqz	a0,800011cc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x7c>
    8000117c:	04058c63          	beqz	a1,800011d4 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001180:	00001537          	lui	a0,0x1
    80001184:	00000097          	auipc	ra,0x0
    80001188:	e9c080e7          	jalr	-356(ra) # 80001020 <_Z9mem_allocm>
        if(istack == 0) {
    8000118c:	04050863          	beqz	a0,800011dc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x8c>
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001190:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001194:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001198:	00090613          	mv	a2,s2
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000119c:	00048593          	mv	a1,s1
    asm("li a0, 0x14");
    800011a0:	01400513          	li	a0,20

    asm("ecall");
    800011a4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800011a8:	00050513          	mv	a0,a0

    return status;
    800011ac:	0005051b          	sext.w	a0,a0
}
    800011b0:	02813083          	ld	ra,40(sp)
    800011b4:	02013403          	ld	s0,32(sp)
    800011b8:	01813483          	ld	s1,24(sp)
    800011bc:	01013903          	ld	s2,16(sp)
    800011c0:	00813983          	ld	s3,8(sp)
    800011c4:	03010113          	addi	sp,sp,48
    800011c8:	00008067          	ret
    uint64 istack = 0;
    800011cc:	00000513          	li	a0,0
    800011d0:	fc1ff06f          	j	80001190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
    800011d4:	00000513          	li	a0,0
    800011d8:	fb9ff06f          	j	80001190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
            return -1;
    800011dc:	fff00513          	li	a0,-1
    800011e0:	fd1ff06f          	j	800011b0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x60>

00000000800011e4 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    800011e4:	ff010113          	addi	sp,sp,-16
    800011e8:	00813423          	sd	s0,8(sp)
    800011ec:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;
    if(handle == nullptr)
    800011f0:	02050263          	beqz	a0,80001214 <_Z12thread_startP7_thread+0x30>
        return -1;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800011f4:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    800011f8:	01500513          	li	a0,21

    asm("ecall");
    800011fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001200:	00050513          	mv	a0,a0

    return status;
    80001204:	0005051b          	sext.w	a0,a0
}
    80001208:	00813403          	ld	s0,8(sp)
    8000120c:	01010113          	addi	sp,sp,16
    80001210:	00008067          	ret
        return -1;
    80001214:	fff00513          	li	a0,-1
    80001218:	ff1ff06f          	j	80001208 <_Z12thread_startP7_thread+0x24>

000000008000121c <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    8000121c:	ff010113          	addi	sp,sp,-16
    80001220:	00813423          	sd	s0,8(sp)
    80001224:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001228:	02059593          	slli	a1,a1,0x20
    8000122c:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001230:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001234:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001238:	02100513          	li	a0,33


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

0000000080001254 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001254:	ff010113          	addi	sp,sp,-16
    80001258:	00813423          	sd	s0,8(sp)
    8000125c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001260:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001264:	02200513          	li	a0,34


    asm("ecall");
    80001268:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000126c:	00050513          	mv	a0,a0

    return status;
}
    80001270:	0005051b          	sext.w	a0,a0
    80001274:	00813403          	ld	s0,8(sp)
    80001278:	01010113          	addi	sp,sp,16
    8000127c:	00008067          	ret

0000000080001280 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000128c:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001290:	02300513          	li	a0,35


    asm("ecall");
    80001294:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001298:	00050513          	mv	a0,a0

    return status;
}
    8000129c:	0005051b          	sext.w	a0,a0
    800012a0:	00813403          	ld	s0,8(sp)
    800012a4:	01010113          	addi	sp,sp,16
    800012a8:	00008067          	ret

00000000800012ac <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    800012ac:	ff010113          	addi	sp,sp,-16
    800012b0:	00813423          	sd	s0,8(sp)
    800012b4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800012b8:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    800012bc:	02400513          	li	a0,36


    asm("ecall");
    800012c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800012c4:	00050513          	mv	a0,a0

    return status;
}
    800012c8:	0005051b          	sext.w	a0,a0
    800012cc:	00813403          	ld	s0,8(sp)
    800012d0:	01010113          	addi	sp,sp,16
    800012d4:	00008067          	ret

00000000800012d8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    800012d8:	ff010113          	addi	sp,sp,-16
    800012dc:	00813423          	sd	s0,8(sp)
    800012e0:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    800012e4:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    800012e8:	03100513          	li	a0,49


    asm("ecall");
    800012ec:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800012f0:	00050513          	mv	a0,a0

    return status;
}
    800012f4:	0005051b          	sext.w	a0,a0
    800012f8:	00813403          	ld	s0,8(sp)
    800012fc:	01010113          	addi	sp,sp,16
    80001300:	00008067          	ret

0000000080001304 <_Z4getcv>:

char getc(){
    80001304:	ff010113          	addi	sp,sp,-16
    80001308:	00813423          	sd	s0,8(sp)
    8000130c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80001310:	04100513          	li	a0,65

    asm("ecall");
    80001314:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80001318:	00050513          	mv	a0,a0

    return c;
}
    8000131c:	0ff57513          	andi	a0,a0,255
    80001320:	00813403          	ld	s0,8(sp)
    80001324:	01010113          	addi	sp,sp,16
    80001328:	00008067          	ret

000000008000132c <_Z4putcc>:

void putc(char c){
    8000132c:	ff010113          	addi	sp,sp,-16
    80001330:	00813423          	sd	s0,8(sp)
    80001334:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80001338:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    8000133c:	04200513          	li	a0,66

    asm("ecall");
    80001340:	00000073          	ecall
}
    80001344:	00813403          	ld	s0,8(sp)
    80001348:	01010113          	addi	sp,sp,16
    8000134c:	00008067          	ret

0000000080001350 <_Z4forkv>:


int fork(){
    80001350:	ff010113          	addi	sp,sp,-16
    80001354:	00813423          	sd	s0,8(sp)
    80001358:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    8000135c:	06100513          	li	a0,97

    asm("ecall");
    80001360:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001364:	00050513          	mv	a0,a0

    return status;
}
    80001368:	0005051b          	sext.w	a0,a0
    8000136c:	00813403          	ld	s0,8(sp)
    80001370:	01010113          	addi	sp,sp,16
    80001374:	00008067          	ret

0000000080001378 <_ZN10_semaphoredlEPv>:
#include "../../h/_semaphore.hpp"
#include "../../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80001378:	ff010113          	addi	sp,sp,-16
    8000137c:	00113423          	sd	ra,8(sp)
    80001380:	00813023          	sd	s0,0(sp)
    80001384:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80001388:	00000097          	auipc	ra,0x0
    8000138c:	ecc080e7          	jalr	-308(ra) # 80001254 <_Z9sem_closeP10_semaphore>
}
    80001390:	00813083          	ld	ra,8(sp)
    80001394:	00013403          	ld	s0,0(sp)
    80001398:	01010113          	addi	sp,sp,16
    8000139c:	00008067          	ret

00000000800013a0 <_ZN7_threaddlEPv>:

#include "../../h/_thread.hpp"
#include "../../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    800013a0:	ff010113          	addi	sp,sp,-16
    800013a4:	00113423          	sd	ra,8(sp)
    800013a8:	00813023          	sd	s0,0(sp)
    800013ac:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    800013b0:	0000a097          	auipc	ra,0xa
    800013b4:	a1c080e7          	jalr	-1508(ra) # 8000adcc <_ZN3TCB11thread_freeEPv>
    800013b8:	00813083          	ld	ra,8(sp)
    800013bc:	00013403          	ld	s0,0(sp)
    800013c0:	01010113          	addi	sp,sp,16
    800013c4:	00008067          	ret

00000000800013c8 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800013c8:	fe010113          	addi	sp,sp,-32
    800013cc:	00113c23          	sd	ra,24(sp)
    800013d0:	00813823          	sd	s0,16(sp)
    800013d4:	00913423          	sd	s1,8(sp)
    800013d8:	02010413          	addi	s0,sp,32
    800013dc:	00050493          	mv	s1,a0
    LOCK();
    800013e0:	00100613          	li	a2,1
    800013e4:	00000593          	li	a1,0
    800013e8:	00005517          	auipc	a0,0x5
    800013ec:	55850513          	addi	a0,a0,1368 # 80006940 <lockPrint>
    800013f0:	00000097          	auipc	ra,0x0
    800013f4:	c10080e7          	jalr	-1008(ra) # 80001000 <copy_and_swap>
    800013f8:	fe0514e3          	bnez	a0,800013e0 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800013fc:	0004c503          	lbu	a0,0(s1)
    80001400:	00050a63          	beqz	a0,80001414 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80001404:	00000097          	auipc	ra,0x0
    80001408:	f28080e7          	jalr	-216(ra) # 8000132c <_Z4putcc>
        string++;
    8000140c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001410:	fedff06f          	j	800013fc <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80001414:	00000613          	li	a2,0
    80001418:	00100593          	li	a1,1
    8000141c:	00005517          	auipc	a0,0x5
    80001420:	52450513          	addi	a0,a0,1316 # 80006940 <lockPrint>
    80001424:	00000097          	auipc	ra,0x0
    80001428:	bdc080e7          	jalr	-1060(ra) # 80001000 <copy_and_swap>
    8000142c:	fe0514e3          	bnez	a0,80001414 <_Z11printStringPKc+0x4c>
}
    80001430:	01813083          	ld	ra,24(sp)
    80001434:	01013403          	ld	s0,16(sp)
    80001438:	00813483          	ld	s1,8(sp)
    8000143c:	02010113          	addi	sp,sp,32
    80001440:	00008067          	ret

0000000080001444 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001444:	fd010113          	addi	sp,sp,-48
    80001448:	02113423          	sd	ra,40(sp)
    8000144c:	02813023          	sd	s0,32(sp)
    80001450:	00913c23          	sd	s1,24(sp)
    80001454:	01213823          	sd	s2,16(sp)
    80001458:	01313423          	sd	s3,8(sp)
    8000145c:	01413023          	sd	s4,0(sp)
    80001460:	03010413          	addi	s0,sp,48
    80001464:	00050993          	mv	s3,a0
    80001468:	00058a13          	mv	s4,a1
    LOCK();
    8000146c:	00100613          	li	a2,1
    80001470:	00000593          	li	a1,0
    80001474:	00005517          	auipc	a0,0x5
    80001478:	4cc50513          	addi	a0,a0,1228 # 80006940 <lockPrint>
    8000147c:	00000097          	auipc	ra,0x0
    80001480:	b84080e7          	jalr	-1148(ra) # 80001000 <copy_and_swap>
    80001484:	fe0514e3          	bnez	a0,8000146c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001488:	00000913          	li	s2,0
    8000148c:	00090493          	mv	s1,s2
    80001490:	0019091b          	addiw	s2,s2,1
    80001494:	03495a63          	bge	s2,s4,800014c8 <_Z9getStringPci+0x84>
        cc = getc();
    80001498:	00000097          	auipc	ra,0x0
    8000149c:	e6c080e7          	jalr	-404(ra) # 80001304 <_Z4getcv>
        if(cc < 1)
    800014a0:	02050463          	beqz	a0,800014c8 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    800014a4:	009984b3          	add	s1,s3,s1
    800014a8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800014ac:	00a00793          	li	a5,10
    800014b0:	00f50a63          	beq	a0,a5,800014c4 <_Z9getStringPci+0x80>
    800014b4:	00d00793          	li	a5,13
    800014b8:	fcf51ae3          	bne	a0,a5,8000148c <_Z9getStringPci+0x48>
        buf[i++] = c;
    800014bc:	00090493          	mv	s1,s2
    800014c0:	0080006f          	j	800014c8 <_Z9getStringPci+0x84>
    800014c4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800014c8:	009984b3          	add	s1,s3,s1
    800014cc:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800014d0:	00000613          	li	a2,0
    800014d4:	00100593          	li	a1,1
    800014d8:	00005517          	auipc	a0,0x5
    800014dc:	46850513          	addi	a0,a0,1128 # 80006940 <lockPrint>
    800014e0:	00000097          	auipc	ra,0x0
    800014e4:	b20080e7          	jalr	-1248(ra) # 80001000 <copy_and_swap>
    800014e8:	fe0514e3          	bnez	a0,800014d0 <_Z9getStringPci+0x8c>
    return buf;
}
    800014ec:	00098513          	mv	a0,s3
    800014f0:	02813083          	ld	ra,40(sp)
    800014f4:	02013403          	ld	s0,32(sp)
    800014f8:	01813483          	ld	s1,24(sp)
    800014fc:	01013903          	ld	s2,16(sp)
    80001500:	00813983          	ld	s3,8(sp)
    80001504:	00013a03          	ld	s4,0(sp)
    80001508:	03010113          	addi	sp,sp,48
    8000150c:	00008067          	ret

0000000080001510 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80001510:	ff010113          	addi	sp,sp,-16
    80001514:	00813423          	sd	s0,8(sp)
    80001518:	01010413          	addi	s0,sp,16
    8000151c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80001520:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80001524:	0006c603          	lbu	a2,0(a3)
    80001528:	fd06071b          	addiw	a4,a2,-48
    8000152c:	0ff77713          	andi	a4,a4,255
    80001530:	00900793          	li	a5,9
    80001534:	02e7e063          	bltu	a5,a4,80001554 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80001538:	0025179b          	slliw	a5,a0,0x2
    8000153c:	00a787bb          	addw	a5,a5,a0
    80001540:	0017979b          	slliw	a5,a5,0x1
    80001544:	00168693          	addi	a3,a3,1
    80001548:	00c787bb          	addw	a5,a5,a2
    8000154c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80001550:	fd5ff06f          	j	80001524 <_Z11stringToIntPKc+0x14>
    return n;
}
    80001554:	00813403          	ld	s0,8(sp)
    80001558:	01010113          	addi	sp,sp,16
    8000155c:	00008067          	ret

0000000080001560 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80001560:	fc010113          	addi	sp,sp,-64
    80001564:	02113c23          	sd	ra,56(sp)
    80001568:	02813823          	sd	s0,48(sp)
    8000156c:	02913423          	sd	s1,40(sp)
    80001570:	03213023          	sd	s2,32(sp)
    80001574:	01313c23          	sd	s3,24(sp)
    80001578:	04010413          	addi	s0,sp,64
    8000157c:	00050493          	mv	s1,a0
    80001580:	00058913          	mv	s2,a1
    80001584:	00060993          	mv	s3,a2
    LOCK();
    80001588:	00100613          	li	a2,1
    8000158c:	00000593          	li	a1,0
    80001590:	00005517          	auipc	a0,0x5
    80001594:	3b050513          	addi	a0,a0,944 # 80006940 <lockPrint>
    80001598:	00000097          	auipc	ra,0x0
    8000159c:	a68080e7          	jalr	-1432(ra) # 80001000 <copy_and_swap>
    800015a0:	fe0514e3          	bnez	a0,80001588 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800015a4:	00098463          	beqz	s3,800015ac <_Z8printIntiii+0x4c>
    800015a8:	0804c463          	bltz	s1,80001630 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800015ac:	0004851b          	sext.w	a0,s1
    neg = 0;
    800015b0:	00000593          	li	a1,0
    }

    i = 0;
    800015b4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800015b8:	0009079b          	sext.w	a5,s2
    800015bc:	0325773b          	remuw	a4,a0,s2
    800015c0:	00048613          	mv	a2,s1
    800015c4:	0014849b          	addiw	s1,s1,1
    800015c8:	02071693          	slli	a3,a4,0x20
    800015cc:	0206d693          	srli	a3,a3,0x20
    800015d0:	00005717          	auipc	a4,0x5
    800015d4:	14070713          	addi	a4,a4,320 # 80006710 <digits>
    800015d8:	00d70733          	add	a4,a4,a3
    800015dc:	00074683          	lbu	a3,0(a4)
    800015e0:	fd040713          	addi	a4,s0,-48
    800015e4:	00c70733          	add	a4,a4,a2
    800015e8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800015ec:	0005071b          	sext.w	a4,a0
    800015f0:	0325553b          	divuw	a0,a0,s2
    800015f4:	fcf772e3          	bgeu	a4,a5,800015b8 <_Z8printIntiii+0x58>
    if(neg)
    800015f8:	00058c63          	beqz	a1,80001610 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800015fc:	fd040793          	addi	a5,s0,-48
    80001600:	009784b3          	add	s1,a5,s1
    80001604:	02d00793          	li	a5,45
    80001608:	fef48823          	sb	a5,-16(s1)
    8000160c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001610:	fff4849b          	addiw	s1,s1,-1
    80001614:	0204c463          	bltz	s1,8000163c <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80001618:	fd040793          	addi	a5,s0,-48
    8000161c:	009787b3          	add	a5,a5,s1
    80001620:	ff07c503          	lbu	a0,-16(a5)
    80001624:	00000097          	auipc	ra,0x0
    80001628:	d08080e7          	jalr	-760(ra) # 8000132c <_Z4putcc>
    8000162c:	fe5ff06f          	j	80001610 <_Z8printIntiii+0xb0>
        x = -xx;
    80001630:	4090053b          	negw	a0,s1
        neg = 1;
    80001634:	00100593          	li	a1,1
        x = -xx;
    80001638:	f7dff06f          	j	800015b4 <_Z8printIntiii+0x54>

    UNLOCK();
    8000163c:	00000613          	li	a2,0
    80001640:	00100593          	li	a1,1
    80001644:	00005517          	auipc	a0,0x5
    80001648:	2fc50513          	addi	a0,a0,764 # 80006940 <lockPrint>
    8000164c:	00000097          	auipc	ra,0x0
    80001650:	9b4080e7          	jalr	-1612(ra) # 80001000 <copy_and_swap>
    80001654:	fe0514e3          	bnez	a0,8000163c <_Z8printIntiii+0xdc>
    80001658:	03813083          	ld	ra,56(sp)
    8000165c:	03013403          	ld	s0,48(sp)
    80001660:	02813483          	ld	s1,40(sp)
    80001664:	02013903          	ld	s2,32(sp)
    80001668:	01813983          	ld	s3,24(sp)
    8000166c:	04010113          	addi	sp,sp,64
    80001670:	00008067          	ret

0000000080001674 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    80001674:	ff010113          	addi	sp,sp,-16
    80001678:	00113423          	sd	ra,8(sp)
    8000167c:	00813023          	sd	s0,0(sp)
    80001680:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80001684:	00053783          	ld	a5,0(a0)
    80001688:	0107b783          	ld	a5,16(a5)
    8000168c:	000780e7          	jalr	a5
}
    80001690:	00813083          	ld	ra,8(sp)
    80001694:	00013403          	ld	s0,0(sp)
    80001698:	01010113          	addi	sp,sp,16
    8000169c:	00008067          	ret

00000000800016a0 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    800016a0:	ff010113          	addi	sp,sp,-16
    800016a4:	00113423          	sd	ra,8(sp)
    800016a8:	00813023          	sd	s0,0(sp)
    800016ac:	01010413          	addi	s0,sp,16
    800016b0:	00005797          	auipc	a5,0x5
    800016b4:	0b878793          	addi	a5,a5,184 # 80006768 <_ZTV9Semaphore+0x10>
    800016b8:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800016bc:	00853503          	ld	a0,8(a0)
    800016c0:	00000097          	auipc	ra,0x0
    800016c4:	b94080e7          	jalr	-1132(ra) # 80001254 <_Z9sem_closeP10_semaphore>
};
    800016c8:	00813083          	ld	ra,8(sp)
    800016cc:	00013403          	ld	s0,0(sp)
    800016d0:	01010113          	addi	sp,sp,16
    800016d4:	00008067          	ret

00000000800016d8 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    800016d8:	00005797          	auipc	a5,0x5
    800016dc:	0b078793          	addi	a5,a5,176 # 80006788 <_ZTV6Thread+0x10>
    800016e0:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800016e4:	00853503          	ld	a0,8(a0)
    800016e8:	02050663          	beqz	a0,80001714 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    800016ec:	ff010113          	addi	sp,sp,-16
    800016f0:	00113423          	sd	ra,8(sp)
    800016f4:	00813023          	sd	s0,0(sp)
    800016f8:	01010413          	addi	s0,sp,16
    delete myHandle;
    800016fc:	00000097          	auipc	ra,0x0
    80001700:	ca4080e7          	jalr	-860(ra) # 800013a0 <_ZN7_threaddlEPv>
}
    80001704:	00813083          	ld	ra,8(sp)
    80001708:	00013403          	ld	s0,0(sp)
    8000170c:	01010113          	addi	sp,sp,16
    80001710:	00008067          	ret
    80001714:	00008067          	ret

0000000080001718 <_Znwm>:
void* operator new(size_t sz){
    80001718:	ff010113          	addi	sp,sp,-16
    8000171c:	00113423          	sd	ra,8(sp)
    80001720:	00813023          	sd	s0,0(sp)
    80001724:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80001728:	00000097          	auipc	ra,0x0
    8000172c:	8f8080e7          	jalr	-1800(ra) # 80001020 <_Z9mem_allocm>
}
    80001730:	00813083          	ld	ra,8(sp)
    80001734:	00013403          	ld	s0,0(sp)
    80001738:	01010113          	addi	sp,sp,16
    8000173c:	00008067          	ret

0000000080001740 <_Znam>:
void* operator new[](size_t sz){
    80001740:	ff010113          	addi	sp,sp,-16
    80001744:	00113423          	sd	ra,8(sp)
    80001748:	00813023          	sd	s0,0(sp)
    8000174c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80001750:	00000097          	auipc	ra,0x0
    80001754:	8d0080e7          	jalr	-1840(ra) # 80001020 <_Z9mem_allocm>
}
    80001758:	00813083          	ld	ra,8(sp)
    8000175c:	00013403          	ld	s0,0(sp)
    80001760:	01010113          	addi	sp,sp,16
    80001764:	00008067          	ret

0000000080001768 <_ZdlPv>:
void operator delete(void *ptr){
    80001768:	ff010113          	addi	sp,sp,-16
    8000176c:	00113423          	sd	ra,8(sp)
    80001770:	00813023          	sd	s0,0(sp)
    80001774:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80001778:	00000097          	auipc	ra,0x0
    8000177c:	8d8080e7          	jalr	-1832(ra) # 80001050 <_Z8mem_freePv>
}
    80001780:	00813083          	ld	ra,8(sp)
    80001784:	00013403          	ld	s0,0(sp)
    80001788:	01010113          	addi	sp,sp,16
    8000178c:	00008067          	ret

0000000080001790 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80001790:	fe010113          	addi	sp,sp,-32
    80001794:	00113c23          	sd	ra,24(sp)
    80001798:	00813823          	sd	s0,16(sp)
    8000179c:	00913423          	sd	s1,8(sp)
    800017a0:	02010413          	addi	s0,sp,32
    800017a4:	00050493          	mv	s1,a0
};
    800017a8:	00000097          	auipc	ra,0x0
    800017ac:	ef8080e7          	jalr	-264(ra) # 800016a0 <_ZN9SemaphoreD1Ev>
    800017b0:	00048513          	mv	a0,s1
    800017b4:	00000097          	auipc	ra,0x0
    800017b8:	fb4080e7          	jalr	-76(ra) # 80001768 <_ZdlPv>
    800017bc:	01813083          	ld	ra,24(sp)
    800017c0:	01013403          	ld	s0,16(sp)
    800017c4:	00813483          	ld	s1,8(sp)
    800017c8:	02010113          	addi	sp,sp,32
    800017cc:	00008067          	ret

00000000800017d0 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800017d0:	fe010113          	addi	sp,sp,-32
    800017d4:	00113c23          	sd	ra,24(sp)
    800017d8:	00813823          	sd	s0,16(sp)
    800017dc:	00913423          	sd	s1,8(sp)
    800017e0:	02010413          	addi	s0,sp,32
    800017e4:	00050493          	mv	s1,a0
}
    800017e8:	00000097          	auipc	ra,0x0
    800017ec:	ef0080e7          	jalr	-272(ra) # 800016d8 <_ZN6ThreadD1Ev>
    800017f0:	00048513          	mv	a0,s1
    800017f4:	00000097          	auipc	ra,0x0
    800017f8:	f74080e7          	jalr	-140(ra) # 80001768 <_ZdlPv>
    800017fc:	01813083          	ld	ra,24(sp)
    80001800:	01013403          	ld	s0,16(sp)
    80001804:	00813483          	ld	s1,8(sp)
    80001808:	02010113          	addi	sp,sp,32
    8000180c:	00008067          	ret

0000000080001810 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001810:	ff010113          	addi	sp,sp,-16
    80001814:	00113423          	sd	ra,8(sp)
    80001818:	00813023          	sd	s0,0(sp)
    8000181c:	01010413          	addi	s0,sp,16
    80001820:	00005797          	auipc	a5,0x5
    80001824:	f4878793          	addi	a5,a5,-184 # 80006768 <_ZTV9Semaphore+0x10>
    80001828:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000182c:	00850513          	addi	a0,a0,8
    80001830:	00000097          	auipc	ra,0x0
    80001834:	9ec080e7          	jalr	-1556(ra) # 8000121c <_Z8sem_openPP10_semaphorej>
}
    80001838:	00813083          	ld	ra,8(sp)
    8000183c:	00013403          	ld	s0,0(sp)
    80001840:	01010113          	addi	sp,sp,16
    80001844:	00008067          	ret

0000000080001848 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00113423          	sd	ra,8(sp)
    80001850:	00813023          	sd	s0,0(sp)
    80001854:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001858:	00853503          	ld	a0,8(a0)
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	a24080e7          	jalr	-1500(ra) # 80001280 <_Z8sem_waitP10_semaphore>
}
    80001864:	00813083          	ld	ra,8(sp)
    80001868:	00013403          	ld	s0,0(sp)
    8000186c:	01010113          	addi	sp,sp,16
    80001870:	00008067          	ret

0000000080001874 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001874:	ff010113          	addi	sp,sp,-16
    80001878:	00113423          	sd	ra,8(sp)
    8000187c:	00813023          	sd	s0,0(sp)
    80001880:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001884:	00853503          	ld	a0,8(a0)
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	a24080e7          	jalr	-1500(ra) # 800012ac <_Z10sem_signalP10_semaphore>
}
    80001890:	00813083          	ld	ra,8(sp)
    80001894:	00013403          	ld	s0,0(sp)
    80001898:	01010113          	addi	sp,sp,16
    8000189c:	00008067          	ret

00000000800018a0 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    800018a0:	fe010113          	addi	sp,sp,-32
    800018a4:	00113c23          	sd	ra,24(sp)
    800018a8:	00813823          	sd	s0,16(sp)
    800018ac:	00913423          	sd	s1,8(sp)
    800018b0:	02010413          	addi	s0,sp,32
    800018b4:	00050493          	mv	s1,a0
    800018b8:	00005797          	auipc	a5,0x5
    800018bc:	ed078793          	addi	a5,a5,-304 # 80006788 <_ZTV6Thread+0x10>
    800018c0:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    800018c4:	00850513          	addi	a0,a0,8
    800018c8:	00000097          	auipc	ra,0x0
    800018cc:	888080e7          	jalr	-1912(ra) # 80001150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    800018d0:	fff00793          	li	a5,-1
    800018d4:	00f50c63          	beq	a0,a5,800018ec <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    800018d8:	01813083          	ld	ra,24(sp)
    800018dc:	01013403          	ld	s0,16(sp)
    800018e0:	00813483          	ld	s1,8(sp)
    800018e4:	02010113          	addi	sp,sp,32
    800018e8:	00008067          	ret
        myHandle = nullptr;
    800018ec:	0004b423          	sd	zero,8(s1)
}
    800018f0:	fe9ff06f          	j	800018d8 <_ZN6ThreadC1EPFvPvES0_+0x38>

00000000800018f4 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800018f4:	fe010113          	addi	sp,sp,-32
    800018f8:	00113c23          	sd	ra,24(sp)
    800018fc:	00813823          	sd	s0,16(sp)
    80001900:	00913423          	sd	s1,8(sp)
    80001904:	02010413          	addi	s0,sp,32
    80001908:	00050493          	mv	s1,a0
    8000190c:	00005797          	auipc	a5,0x5
    80001910:	e7c78793          	addi	a5,a5,-388 # 80006788 <_ZTV6Thread+0x10>
    80001914:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80001918:	00050613          	mv	a2,a0
    8000191c:	00000597          	auipc	a1,0x0
    80001920:	d5858593          	addi	a1,a1,-680 # 80001674 <_ZN6Thread7wrapperEPv>
    80001924:	00850513          	addi	a0,a0,8
    80001928:	00000097          	auipc	ra,0x0
    8000192c:	828080e7          	jalr	-2008(ra) # 80001150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80001930:	fff00793          	li	a5,-1
    80001934:	00f50c63          	beq	a0,a5,8000194c <_ZN6ThreadC1Ev+0x58>
}
    80001938:	01813083          	ld	ra,24(sp)
    8000193c:	01013403          	ld	s0,16(sp)
    80001940:	00813483          	ld	s1,8(sp)
    80001944:	02010113          	addi	sp,sp,32
    80001948:	00008067          	ret
        myHandle = nullptr;
    8000194c:	0004b423          	sd	zero,8(s1)
}
    80001950:	fe9ff06f          	j	80001938 <_ZN6ThreadC1Ev+0x44>

0000000080001954 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80001954:	ff010113          	addi	sp,sp,-16
    80001958:	00113423          	sd	ra,8(sp)
    8000195c:	00813023          	sd	s0,0(sp)
    80001960:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80001964:	00000097          	auipc	ra,0x0
    80001968:	974080e7          	jalr	-1676(ra) # 800012d8 <_Z10time_sleepm>
}
    8000196c:	00813083          	ld	ra,8(sp)
    80001970:	00013403          	ld	s0,0(sp)
    80001974:	01010113          	addi	sp,sp,16
    80001978:	00008067          	ret

000000008000197c <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000197c:	fe010113          	addi	sp,sp,-32
    80001980:	00113c23          	sd	ra,24(sp)
    80001984:	00813823          	sd	s0,16(sp)
    80001988:	00913423          	sd	s1,8(sp)
    8000198c:	01213023          	sd	s2,0(sp)
    80001990:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80001994:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80001998:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000199c:	0004b783          	ld	a5,0(s1)
    800019a0:	0187b783          	ld	a5,24(a5)
    800019a4:	00048513          	mv	a0,s1
    800019a8:	000780e7          	jalr	a5
        pt->sleep(time);
    800019ac:	00090513          	mv	a0,s2
    800019b0:	00000097          	auipc	ra,0x0
    800019b4:	fa4080e7          	jalr	-92(ra) # 80001954 <_ZN6Thread5sleepEm>
    while(true){
    800019b8:	fe5ff06f          	j	8000199c <_ZN14PeriodicThread7wrapperEPv+0x20>

00000000800019bc <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800019bc:	ff010113          	addi	sp,sp,-16
    800019c0:	00113423          	sd	ra,8(sp)
    800019c4:	00813023          	sd	s0,0(sp)
    800019c8:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800019cc:	fffff097          	auipc	ra,0xfffff
    800019d0:	764080e7          	jalr	1892(ra) # 80001130 <_Z15thread_dispatchv>
}
    800019d4:	00813083          	ld	ra,8(sp)
    800019d8:	00013403          	ld	s0,0(sp)
    800019dc:	01010113          	addi	sp,sp,16
    800019e0:	00008067          	ret

00000000800019e4 <_ZN6Thread5startEv>:
int Thread::start() {
    800019e4:	ff010113          	addi	sp,sp,-16
    800019e8:	00113423          	sd	ra,8(sp)
    800019ec:	00813023          	sd	s0,0(sp)
    800019f0:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    800019f4:	00853503          	ld	a0,8(a0)
    800019f8:	fffff097          	auipc	ra,0xfffff
    800019fc:	7ec080e7          	jalr	2028(ra) # 800011e4 <_Z12thread_startP7_thread>
}
    80001a00:	00813083          	ld	ra,8(sp)
    80001a04:	00013403          	ld	s0,0(sp)
    80001a08:	01010113          	addi	sp,sp,16
    80001a0c:	00008067          	ret

0000000080001a10 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80001a10:	fe010113          	addi	sp,sp,-32
    80001a14:	00113c23          	sd	ra,24(sp)
    80001a18:	00813823          	sd	s0,16(sp)
    80001a1c:	00913423          	sd	s1,8(sp)
    80001a20:	01213023          	sd	s2,0(sp)
    80001a24:	02010413          	addi	s0,sp,32
    80001a28:	00050493          	mv	s1,a0
    80001a2c:	00058913          	mv	s2,a1
    80001a30:	01000513          	li	a0,16
    80001a34:	00000097          	auipc	ra,0x0
    80001a38:	ce4080e7          	jalr	-796(ra) # 80001718 <_Znwm>
    80001a3c:	00050613          	mv	a2,a0
    80001a40:	00050663          	beqz	a0,80001a4c <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80001a44:	00953023          	sd	s1,0(a0)
    80001a48:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80001a4c:	00000597          	auipc	a1,0x0
    80001a50:	f3058593          	addi	a1,a1,-208 # 8000197c <_ZN14PeriodicThread7wrapperEPv>
    80001a54:	00048513          	mv	a0,s1
    80001a58:	00000097          	auipc	ra,0x0
    80001a5c:	e48080e7          	jalr	-440(ra) # 800018a0 <_ZN6ThreadC1EPFvPvES0_>
    80001a60:	00005797          	auipc	a5,0x5
    80001a64:	cd878793          	addi	a5,a5,-808 # 80006738 <_ZTV14PeriodicThread+0x10>
    80001a68:	00f4b023          	sd	a5,0(s1)
    80001a6c:	01813083          	ld	ra,24(sp)
    80001a70:	01013403          	ld	s0,16(sp)
    80001a74:	00813483          	ld	s1,8(sp)
    80001a78:	00013903          	ld	s2,0(sp)
    80001a7c:	02010113          	addi	sp,sp,32
    80001a80:	00008067          	ret

0000000080001a84 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80001a84:	ff010113          	addi	sp,sp,-16
    80001a88:	00113423          	sd	ra,8(sp)
    80001a8c:	00813023          	sd	s0,0(sp)
    80001a90:	01010413          	addi	s0,sp,16
    return ::getc();
    80001a94:	00000097          	auipc	ra,0x0
    80001a98:	870080e7          	jalr	-1936(ra) # 80001304 <_Z4getcv>
}
    80001a9c:	00813083          	ld	ra,8(sp)
    80001aa0:	00013403          	ld	s0,0(sp)
    80001aa4:	01010113          	addi	sp,sp,16
    80001aa8:	00008067          	ret

0000000080001aac <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80001aac:	ff010113          	addi	sp,sp,-16
    80001ab0:	00113423          	sd	ra,8(sp)
    80001ab4:	00813023          	sd	s0,0(sp)
    80001ab8:	01010413          	addi	s0,sp,16
    ::putc(c);
    80001abc:	00000097          	auipc	ra,0x0
    80001ac0:	870080e7          	jalr	-1936(ra) # 8000132c <_Z4putcc>
}
    80001ac4:	00813083          	ld	ra,8(sp)
    80001ac8:	00013403          	ld	s0,0(sp)
    80001acc:	01010113          	addi	sp,sp,16
    80001ad0:	00008067          	ret

0000000080001ad4 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80001ad4:	ff010113          	addi	sp,sp,-16
    80001ad8:	00813423          	sd	s0,8(sp)
    80001adc:	01010413          	addi	s0,sp,16
    80001ae0:	00813403          	ld	s0,8(sp)
    80001ae4:	01010113          	addi	sp,sp,16
    80001ae8:	00008067          	ret

0000000080001aec <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80001aec:	ff010113          	addi	sp,sp,-16
    80001af0:	00813423          	sd	s0,8(sp)
    80001af4:	01010413          	addi	s0,sp,16
    80001af8:	00813403          	ld	s0,8(sp)
    80001afc:	01010113          	addi	sp,sp,16
    80001b00:	00008067          	ret

0000000080001b04 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80001b04:	ff010113          	addi	sp,sp,-16
    80001b08:	00113423          	sd	ra,8(sp)
    80001b0c:	00813023          	sd	s0,0(sp)
    80001b10:	01010413          	addi	s0,sp,16
    80001b14:	00005797          	auipc	a5,0x5
    80001b18:	c2478793          	addi	a5,a5,-988 # 80006738 <_ZTV14PeriodicThread+0x10>
    80001b1c:	00f53023          	sd	a5,0(a0)
    80001b20:	00000097          	auipc	ra,0x0
    80001b24:	bb8080e7          	jalr	-1096(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80001b28:	00813083          	ld	ra,8(sp)
    80001b2c:	00013403          	ld	s0,0(sp)
    80001b30:	01010113          	addi	sp,sp,16
    80001b34:	00008067          	ret

0000000080001b38 <_ZN14PeriodicThreadD0Ev>:
    80001b38:	fe010113          	addi	sp,sp,-32
    80001b3c:	00113c23          	sd	ra,24(sp)
    80001b40:	00813823          	sd	s0,16(sp)
    80001b44:	00913423          	sd	s1,8(sp)
    80001b48:	02010413          	addi	s0,sp,32
    80001b4c:	00050493          	mv	s1,a0
    80001b50:	00005797          	auipc	a5,0x5
    80001b54:	be878793          	addi	a5,a5,-1048 # 80006738 <_ZTV14PeriodicThread+0x10>
    80001b58:	00f53023          	sd	a5,0(a0)
    80001b5c:	00000097          	auipc	ra,0x0
    80001b60:	b7c080e7          	jalr	-1156(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80001b64:	00048513          	mv	a0,s1
    80001b68:	00000097          	auipc	ra,0x0
    80001b6c:	c00080e7          	jalr	-1024(ra) # 80001768 <_ZdlPv>
    80001b70:	01813083          	ld	ra,24(sp)
    80001b74:	01013403          	ld	s0,16(sp)
    80001b78:	00813483          	ld	s1,8(sp)
    80001b7c:	02010113          	addi	sp,sp,32
    80001b80:	00008067          	ret

0000000080001b84 <_ZN10TCBWrapper7tcbWrapEP3TCB>:
//
#include "../../h/tcbWrapperUtil.hpp"
#include "../../h/syscall_c.h"

void TCBWrapper::tcbWrap(TCB* tcb)
{
    80001b84:	ff010113          	addi	sp,sp,-16
    80001b88:	00113423          	sd	ra,8(sp)
    80001b8c:	00813023          	sd	s0,0(sp)
    80001b90:	01010413          	addi	s0,sp,16
    tcb->body(tcb->args);
    80001b94:	01853783          	ld	a5,24(a0)
    80001b98:	02053503          	ld	a0,32(a0)
    80001b9c:	000780e7          	jalr	a5
    thread_exit();
    80001ba0:	fffff097          	auipc	ra,0xfffff
    80001ba4:	568080e7          	jalr	1384(ra) # 80001108 <_Z11thread_exitv>
}
    80001ba8:	00813083          	ld	ra,8(sp)
    80001bac:	00013403          	ld	s0,0(sp)
    80001bb0:	01010113          	addi	sp,sp,16
    80001bb4:	00008067          	ret

0000000080001bb8 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80001bb8:	fd010113          	addi	sp,sp,-48
    80001bbc:	02113423          	sd	ra,40(sp)
    80001bc0:	02813023          	sd	s0,32(sp)
    80001bc4:	00913c23          	sd	s1,24(sp)
    80001bc8:	01213823          	sd	s2,16(sp)
    80001bcc:	01313423          	sd	s3,8(sp)
    80001bd0:	03010413          	addi	s0,sp,48
    80001bd4:	00050493          	mv	s1,a0
    80001bd8:	00058993          	mv	s3,a1
    80001bdc:	0015879b          	addiw	a5,a1,1
    80001be0:	0007851b          	sext.w	a0,a5
    80001be4:	00f4a023          	sw	a5,0(s1)
    80001be8:	0004a823          	sw	zero,16(s1)
    80001bec:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80001bf0:	00251513          	slli	a0,a0,0x2
    80001bf4:	fffff097          	auipc	ra,0xfffff
    80001bf8:	42c080e7          	jalr	1068(ra) # 80001020 <_Z9mem_allocm>
    80001bfc:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80001c00:	01000513          	li	a0,16
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	b14080e7          	jalr	-1260(ra) # 80001718 <_Znwm>
    80001c0c:	00050913          	mv	s2,a0
    80001c10:	00050863          	beqz	a0,80001c20 <_ZN9BufferCPPC1Ei+0x68>
    80001c14:	00000593          	li	a1,0
    80001c18:	00000097          	auipc	ra,0x0
    80001c1c:	bf8080e7          	jalr	-1032(ra) # 80001810 <_ZN9SemaphoreC1Ej>
    80001c20:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80001c24:	01000513          	li	a0,16
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	af0080e7          	jalr	-1296(ra) # 80001718 <_Znwm>
    80001c30:	00050913          	mv	s2,a0
    80001c34:	00050863          	beqz	a0,80001c44 <_ZN9BufferCPPC1Ei+0x8c>
    80001c38:	00098593          	mv	a1,s3
    80001c3c:	00000097          	auipc	ra,0x0
    80001c40:	bd4080e7          	jalr	-1068(ra) # 80001810 <_ZN9SemaphoreC1Ej>
    80001c44:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80001c48:	01000513          	li	a0,16
    80001c4c:	00000097          	auipc	ra,0x0
    80001c50:	acc080e7          	jalr	-1332(ra) # 80001718 <_Znwm>
    80001c54:	00050913          	mv	s2,a0
    80001c58:	00050863          	beqz	a0,80001c68 <_ZN9BufferCPPC1Ei+0xb0>
    80001c5c:	00100593          	li	a1,1
    80001c60:	00000097          	auipc	ra,0x0
    80001c64:	bb0080e7          	jalr	-1104(ra) # 80001810 <_ZN9SemaphoreC1Ej>
    80001c68:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80001c6c:	01000513          	li	a0,16
    80001c70:	00000097          	auipc	ra,0x0
    80001c74:	aa8080e7          	jalr	-1368(ra) # 80001718 <_Znwm>
    80001c78:	00050913          	mv	s2,a0
    80001c7c:	00050863          	beqz	a0,80001c8c <_ZN9BufferCPPC1Ei+0xd4>
    80001c80:	00100593          	li	a1,1
    80001c84:	00000097          	auipc	ra,0x0
    80001c88:	b8c080e7          	jalr	-1140(ra) # 80001810 <_ZN9SemaphoreC1Ej>
    80001c8c:	0324b823          	sd	s2,48(s1)
}
    80001c90:	02813083          	ld	ra,40(sp)
    80001c94:	02013403          	ld	s0,32(sp)
    80001c98:	01813483          	ld	s1,24(sp)
    80001c9c:	01013903          	ld	s2,16(sp)
    80001ca0:	00813983          	ld	s3,8(sp)
    80001ca4:	03010113          	addi	sp,sp,48
    80001ca8:	00008067          	ret
    80001cac:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80001cb0:	00090513          	mv	a0,s2
    80001cb4:	00000097          	auipc	ra,0x0
    80001cb8:	ab4080e7          	jalr	-1356(ra) # 80001768 <_ZdlPv>
    80001cbc:	00048513          	mv	a0,s1
    80001cc0:	00006097          	auipc	ra,0x6
    80001cc4:	d78080e7          	jalr	-648(ra) # 80007a38 <_Unwind_Resume>
    80001cc8:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80001ccc:	00090513          	mv	a0,s2
    80001cd0:	00000097          	auipc	ra,0x0
    80001cd4:	a98080e7          	jalr	-1384(ra) # 80001768 <_ZdlPv>
    80001cd8:	00048513          	mv	a0,s1
    80001cdc:	00006097          	auipc	ra,0x6
    80001ce0:	d5c080e7          	jalr	-676(ra) # 80007a38 <_Unwind_Resume>
    80001ce4:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80001ce8:	00090513          	mv	a0,s2
    80001cec:	00000097          	auipc	ra,0x0
    80001cf0:	a7c080e7          	jalr	-1412(ra) # 80001768 <_ZdlPv>
    80001cf4:	00048513          	mv	a0,s1
    80001cf8:	00006097          	auipc	ra,0x6
    80001cfc:	d40080e7          	jalr	-704(ra) # 80007a38 <_Unwind_Resume>
    80001d00:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80001d04:	00090513          	mv	a0,s2
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	a60080e7          	jalr	-1440(ra) # 80001768 <_ZdlPv>
    80001d10:	00048513          	mv	a0,s1
    80001d14:	00006097          	auipc	ra,0x6
    80001d18:	d24080e7          	jalr	-732(ra) # 80007a38 <_Unwind_Resume>

0000000080001d1c <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80001d1c:	fe010113          	addi	sp,sp,-32
    80001d20:	00113c23          	sd	ra,24(sp)
    80001d24:	00813823          	sd	s0,16(sp)
    80001d28:	00913423          	sd	s1,8(sp)
    80001d2c:	01213023          	sd	s2,0(sp)
    80001d30:	02010413          	addi	s0,sp,32
    80001d34:	00050493          	mv	s1,a0
    80001d38:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80001d3c:	01853503          	ld	a0,24(a0)
    80001d40:	00000097          	auipc	ra,0x0
    80001d44:	b08080e7          	jalr	-1272(ra) # 80001848 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80001d48:	0304b503          	ld	a0,48(s1)
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	afc080e7          	jalr	-1284(ra) # 80001848 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80001d54:	0084b783          	ld	a5,8(s1)
    80001d58:	0144a703          	lw	a4,20(s1)
    80001d5c:	00271713          	slli	a4,a4,0x2
    80001d60:	00e787b3          	add	a5,a5,a4
    80001d64:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80001d68:	0144a783          	lw	a5,20(s1)
    80001d6c:	0017879b          	addiw	a5,a5,1
    80001d70:	0004a703          	lw	a4,0(s1)
    80001d74:	02e7e7bb          	remw	a5,a5,a4
    80001d78:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80001d7c:	0304b503          	ld	a0,48(s1)
    80001d80:	00000097          	auipc	ra,0x0
    80001d84:	af4080e7          	jalr	-1292(ra) # 80001874 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80001d88:	0204b503          	ld	a0,32(s1)
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	ae8080e7          	jalr	-1304(ra) # 80001874 <_ZN9Semaphore6signalEv>

}
    80001d94:	01813083          	ld	ra,24(sp)
    80001d98:	01013403          	ld	s0,16(sp)
    80001d9c:	00813483          	ld	s1,8(sp)
    80001da0:	00013903          	ld	s2,0(sp)
    80001da4:	02010113          	addi	sp,sp,32
    80001da8:	00008067          	ret

0000000080001dac <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80001dac:	fe010113          	addi	sp,sp,-32
    80001db0:	00113c23          	sd	ra,24(sp)
    80001db4:	00813823          	sd	s0,16(sp)
    80001db8:	00913423          	sd	s1,8(sp)
    80001dbc:	01213023          	sd	s2,0(sp)
    80001dc0:	02010413          	addi	s0,sp,32
    80001dc4:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80001dc8:	02053503          	ld	a0,32(a0)
    80001dcc:	00000097          	auipc	ra,0x0
    80001dd0:	a7c080e7          	jalr	-1412(ra) # 80001848 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80001dd4:	0284b503          	ld	a0,40(s1)
    80001dd8:	00000097          	auipc	ra,0x0
    80001ddc:	a70080e7          	jalr	-1424(ra) # 80001848 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80001de0:	0084b703          	ld	a4,8(s1)
    80001de4:	0104a783          	lw	a5,16(s1)
    80001de8:	00279693          	slli	a3,a5,0x2
    80001dec:	00d70733          	add	a4,a4,a3
    80001df0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80001df4:	0017879b          	addiw	a5,a5,1
    80001df8:	0004a703          	lw	a4,0(s1)
    80001dfc:	02e7e7bb          	remw	a5,a5,a4
    80001e00:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80001e04:	0284b503          	ld	a0,40(s1)
    80001e08:	00000097          	auipc	ra,0x0
    80001e0c:	a6c080e7          	jalr	-1428(ra) # 80001874 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80001e10:	0184b503          	ld	a0,24(s1)
    80001e14:	00000097          	auipc	ra,0x0
    80001e18:	a60080e7          	jalr	-1440(ra) # 80001874 <_ZN9Semaphore6signalEv>

    return ret;
}
    80001e1c:	00090513          	mv	a0,s2
    80001e20:	01813083          	ld	ra,24(sp)
    80001e24:	01013403          	ld	s0,16(sp)
    80001e28:	00813483          	ld	s1,8(sp)
    80001e2c:	00013903          	ld	s2,0(sp)
    80001e30:	02010113          	addi	sp,sp,32
    80001e34:	00008067          	ret

0000000080001e38 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80001e38:	fe010113          	addi	sp,sp,-32
    80001e3c:	00113c23          	sd	ra,24(sp)
    80001e40:	00813823          	sd	s0,16(sp)
    80001e44:	00913423          	sd	s1,8(sp)
    80001e48:	01213023          	sd	s2,0(sp)
    80001e4c:	02010413          	addi	s0,sp,32
    80001e50:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80001e54:	02853503          	ld	a0,40(a0)
    80001e58:	00000097          	auipc	ra,0x0
    80001e5c:	9f0080e7          	jalr	-1552(ra) # 80001848 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80001e60:	0304b503          	ld	a0,48(s1)
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	9e4080e7          	jalr	-1564(ra) # 80001848 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80001e6c:	0144a783          	lw	a5,20(s1)
    80001e70:	0104a903          	lw	s2,16(s1)
    80001e74:	0327ce63          	blt	a5,s2,80001eb0 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80001e78:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80001e7c:	0304b503          	ld	a0,48(s1)
    80001e80:	00000097          	auipc	ra,0x0
    80001e84:	9f4080e7          	jalr	-1548(ra) # 80001874 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80001e88:	0284b503          	ld	a0,40(s1)
    80001e8c:	00000097          	auipc	ra,0x0
    80001e90:	9e8080e7          	jalr	-1560(ra) # 80001874 <_ZN9Semaphore6signalEv>

    return ret;
}
    80001e94:	00090513          	mv	a0,s2
    80001e98:	01813083          	ld	ra,24(sp)
    80001e9c:	01013403          	ld	s0,16(sp)
    80001ea0:	00813483          	ld	s1,8(sp)
    80001ea4:	00013903          	ld	s2,0(sp)
    80001ea8:	02010113          	addi	sp,sp,32
    80001eac:	00008067          	ret
        ret = cap - head + tail;
    80001eb0:	0004a703          	lw	a4,0(s1)
    80001eb4:	4127093b          	subw	s2,a4,s2
    80001eb8:	00f9093b          	addw	s2,s2,a5
    80001ebc:	fc1ff06f          	j	80001e7c <_ZN9BufferCPP6getCntEv+0x44>

0000000080001ec0 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80001ec0:	fe010113          	addi	sp,sp,-32
    80001ec4:	00113c23          	sd	ra,24(sp)
    80001ec8:	00813823          	sd	s0,16(sp)
    80001ecc:	00913423          	sd	s1,8(sp)
    80001ed0:	02010413          	addi	s0,sp,32
    80001ed4:	00050493          	mv	s1,a0
    Console::putc('\n');
    80001ed8:	00a00513          	li	a0,10
    80001edc:	00000097          	auipc	ra,0x0
    80001ee0:	bd0080e7          	jalr	-1072(ra) # 80001aac <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80001ee4:	00004517          	auipc	a0,0x4
    80001ee8:	13c50513          	addi	a0,a0,316 # 80006020 <CONSOLE_STATUS+0x10>
    80001eec:	fffff097          	auipc	ra,0xfffff
    80001ef0:	4dc080e7          	jalr	1244(ra) # 800013c8 <_Z11printStringPKc>
    while (getCnt()) {
    80001ef4:	00048513          	mv	a0,s1
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	f40080e7          	jalr	-192(ra) # 80001e38 <_ZN9BufferCPP6getCntEv>
    80001f00:	02050c63          	beqz	a0,80001f38 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80001f04:	0084b783          	ld	a5,8(s1)
    80001f08:	0104a703          	lw	a4,16(s1)
    80001f0c:	00271713          	slli	a4,a4,0x2
    80001f10:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80001f14:	0007c503          	lbu	a0,0(a5)
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	b94080e7          	jalr	-1132(ra) # 80001aac <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80001f20:	0104a783          	lw	a5,16(s1)
    80001f24:	0017879b          	addiw	a5,a5,1
    80001f28:	0004a703          	lw	a4,0(s1)
    80001f2c:	02e7e7bb          	remw	a5,a5,a4
    80001f30:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80001f34:	fc1ff06f          	j	80001ef4 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80001f38:	02100513          	li	a0,33
    80001f3c:	00000097          	auipc	ra,0x0
    80001f40:	b70080e7          	jalr	-1168(ra) # 80001aac <_ZN7Console4putcEc>
    Console::putc('\n');
    80001f44:	00a00513          	li	a0,10
    80001f48:	00000097          	auipc	ra,0x0
    80001f4c:	b64080e7          	jalr	-1180(ra) # 80001aac <_ZN7Console4putcEc>
    mem_free(buffer);
    80001f50:	0084b503          	ld	a0,8(s1)
    80001f54:	fffff097          	auipc	ra,0xfffff
    80001f58:	0fc080e7          	jalr	252(ra) # 80001050 <_Z8mem_freePv>
    delete itemAvailable;
    80001f5c:	0204b503          	ld	a0,32(s1)
    80001f60:	00050863          	beqz	a0,80001f70 <_ZN9BufferCPPD1Ev+0xb0>
    80001f64:	00053783          	ld	a5,0(a0)
    80001f68:	0087b783          	ld	a5,8(a5)
    80001f6c:	000780e7          	jalr	a5
    delete spaceAvailable;
    80001f70:	0184b503          	ld	a0,24(s1)
    80001f74:	00050863          	beqz	a0,80001f84 <_ZN9BufferCPPD1Ev+0xc4>
    80001f78:	00053783          	ld	a5,0(a0)
    80001f7c:	0087b783          	ld	a5,8(a5)
    80001f80:	000780e7          	jalr	a5
    delete mutexTail;
    80001f84:	0304b503          	ld	a0,48(s1)
    80001f88:	00050863          	beqz	a0,80001f98 <_ZN9BufferCPPD1Ev+0xd8>
    80001f8c:	00053783          	ld	a5,0(a0)
    80001f90:	0087b783          	ld	a5,8(a5)
    80001f94:	000780e7          	jalr	a5
    delete mutexHead;
    80001f98:	0284b503          	ld	a0,40(s1)
    80001f9c:	00050863          	beqz	a0,80001fac <_ZN9BufferCPPD1Ev+0xec>
    80001fa0:	00053783          	ld	a5,0(a0)
    80001fa4:	0087b783          	ld	a5,8(a5)
    80001fa8:	000780e7          	jalr	a5
}
    80001fac:	01813083          	ld	ra,24(sp)
    80001fb0:	01013403          	ld	s0,16(sp)
    80001fb4:	00813483          	ld	s1,8(sp)
    80001fb8:	02010113          	addi	sp,sp,32
    80001fbc:	00008067          	ret

0000000080001fc0 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80001fc0:	fe010113          	addi	sp,sp,-32
    80001fc4:	00113c23          	sd	ra,24(sp)
    80001fc8:	00813823          	sd	s0,16(sp)
    80001fcc:	00913423          	sd	s1,8(sp)
    80001fd0:	01213023          	sd	s2,0(sp)
    80001fd4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001fd8:	00000913          	li	s2,0
    80001fdc:	0380006f          	j	80002014 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001fe0:	fffff097          	auipc	ra,0xfffff
    80001fe4:	150080e7          	jalr	336(ra) # 80001130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001fe8:	00148493          	addi	s1,s1,1
    80001fec:	000027b7          	lui	a5,0x2
    80001ff0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001ff4:	0097ee63          	bltu	a5,s1,80002010 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001ff8:	00000713          	li	a4,0
    80001ffc:	000077b7          	lui	a5,0x7
    80002000:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002004:	fce7eee3          	bltu	a5,a4,80001fe0 <_Z11workerBodyAPv+0x20>
    80002008:	00170713          	addi	a4,a4,1
    8000200c:	ff1ff06f          	j	80001ffc <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002010:	00190913          	addi	s2,s2,1
    80002014:	00900793          	li	a5,9
    80002018:	0527e063          	bltu	a5,s2,80002058 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000201c:	00004517          	auipc	a0,0x4
    80002020:	01c50513          	addi	a0,a0,28 # 80006038 <CONSOLE_STATUS+0x28>
    80002024:	fffff097          	auipc	ra,0xfffff
    80002028:	3a4080e7          	jalr	932(ra) # 800013c8 <_Z11printStringPKc>
    8000202c:	00000613          	li	a2,0
    80002030:	00a00593          	li	a1,10
    80002034:	0009051b          	sext.w	a0,s2
    80002038:	fffff097          	auipc	ra,0xfffff
    8000203c:	528080e7          	jalr	1320(ra) # 80001560 <_Z8printIntiii>
    80002040:	00004517          	auipc	a0,0x4
    80002044:	13850513          	addi	a0,a0,312 # 80006178 <CONSOLE_STATUS+0x168>
    80002048:	fffff097          	auipc	ra,0xfffff
    8000204c:	380080e7          	jalr	896(ra) # 800013c8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002050:	00000493          	li	s1,0
    80002054:	f99ff06f          	j	80001fec <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80002058:	00004517          	auipc	a0,0x4
    8000205c:	fe850513          	addi	a0,a0,-24 # 80006040 <CONSOLE_STATUS+0x30>
    80002060:	fffff097          	auipc	ra,0xfffff
    80002064:	368080e7          	jalr	872(ra) # 800013c8 <_Z11printStringPKc>
    finishedA = true;
    80002068:	00100793          	li	a5,1
    8000206c:	00005717          	auipc	a4,0x5
    80002070:	8cf70e23          	sb	a5,-1828(a4) # 80006948 <finishedA>
}
    80002074:	01813083          	ld	ra,24(sp)
    80002078:	01013403          	ld	s0,16(sp)
    8000207c:	00813483          	ld	s1,8(sp)
    80002080:	00013903          	ld	s2,0(sp)
    80002084:	02010113          	addi	sp,sp,32
    80002088:	00008067          	ret

000000008000208c <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    8000208c:	fe010113          	addi	sp,sp,-32
    80002090:	00113c23          	sd	ra,24(sp)
    80002094:	00813823          	sd	s0,16(sp)
    80002098:	00913423          	sd	s1,8(sp)
    8000209c:	01213023          	sd	s2,0(sp)
    800020a0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800020a4:	00000913          	li	s2,0
    800020a8:	0380006f          	j	800020e0 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800020ac:	fffff097          	auipc	ra,0xfffff
    800020b0:	084080e7          	jalr	132(ra) # 80001130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800020b4:	00148493          	addi	s1,s1,1
    800020b8:	000027b7          	lui	a5,0x2
    800020bc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800020c0:	0097ee63          	bltu	a5,s1,800020dc <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800020c4:	00000713          	li	a4,0
    800020c8:	000077b7          	lui	a5,0x7
    800020cc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800020d0:	fce7eee3          	bltu	a5,a4,800020ac <_Z11workerBodyBPv+0x20>
    800020d4:	00170713          	addi	a4,a4,1
    800020d8:	ff1ff06f          	j	800020c8 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800020dc:	00190913          	addi	s2,s2,1
    800020e0:	00f00793          	li	a5,15
    800020e4:	0527e063          	bltu	a5,s2,80002124 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800020e8:	00004517          	auipc	a0,0x4
    800020ec:	f6850513          	addi	a0,a0,-152 # 80006050 <CONSOLE_STATUS+0x40>
    800020f0:	fffff097          	auipc	ra,0xfffff
    800020f4:	2d8080e7          	jalr	728(ra) # 800013c8 <_Z11printStringPKc>
    800020f8:	00000613          	li	a2,0
    800020fc:	00a00593          	li	a1,10
    80002100:	0009051b          	sext.w	a0,s2
    80002104:	fffff097          	auipc	ra,0xfffff
    80002108:	45c080e7          	jalr	1116(ra) # 80001560 <_Z8printIntiii>
    8000210c:	00004517          	auipc	a0,0x4
    80002110:	06c50513          	addi	a0,a0,108 # 80006178 <CONSOLE_STATUS+0x168>
    80002114:	fffff097          	auipc	ra,0xfffff
    80002118:	2b4080e7          	jalr	692(ra) # 800013c8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000211c:	00000493          	li	s1,0
    80002120:	f99ff06f          	j	800020b8 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80002124:	00004517          	auipc	a0,0x4
    80002128:	f3450513          	addi	a0,a0,-204 # 80006058 <CONSOLE_STATUS+0x48>
    8000212c:	fffff097          	auipc	ra,0xfffff
    80002130:	29c080e7          	jalr	668(ra) # 800013c8 <_Z11printStringPKc>
    finishedB = true;
    80002134:	00100793          	li	a5,1
    80002138:	00005717          	auipc	a4,0x5
    8000213c:	80f708a3          	sb	a5,-2031(a4) # 80006949 <finishedB>
    thread_dispatch();
    80002140:	fffff097          	auipc	ra,0xfffff
    80002144:	ff0080e7          	jalr	-16(ra) # 80001130 <_Z15thread_dispatchv>
}
    80002148:	01813083          	ld	ra,24(sp)
    8000214c:	01013403          	ld	s0,16(sp)
    80002150:	00813483          	ld	s1,8(sp)
    80002154:	00013903          	ld	s2,0(sp)
    80002158:	02010113          	addi	sp,sp,32
    8000215c:	00008067          	ret

0000000080002160 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80002160:	fe010113          	addi	sp,sp,-32
    80002164:	00113c23          	sd	ra,24(sp)
    80002168:	00813823          	sd	s0,16(sp)
    8000216c:	00913423          	sd	s1,8(sp)
    80002170:	01213023          	sd	s2,0(sp)
    80002174:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80002178:	00053903          	ld	s2,0(a0)
    int i = 6;
    8000217c:	00600493          	li	s1,6
    while (--i > 0) {
    80002180:	fff4849b          	addiw	s1,s1,-1
    80002184:	04905463          	blez	s1,800021cc <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80002188:	00004517          	auipc	a0,0x4
    8000218c:	ee050513          	addi	a0,a0,-288 # 80006068 <CONSOLE_STATUS+0x58>
    80002190:	fffff097          	auipc	ra,0xfffff
    80002194:	238080e7          	jalr	568(ra) # 800013c8 <_Z11printStringPKc>
        printInt(sleep_time);
    80002198:	00000613          	li	a2,0
    8000219c:	00a00593          	li	a1,10
    800021a0:	0009051b          	sext.w	a0,s2
    800021a4:	fffff097          	auipc	ra,0xfffff
    800021a8:	3bc080e7          	jalr	956(ra) # 80001560 <_Z8printIntiii>
        printString(" !\n");
    800021ac:	00004517          	auipc	a0,0x4
    800021b0:	ec450513          	addi	a0,a0,-316 # 80006070 <CONSOLE_STATUS+0x60>
    800021b4:	fffff097          	auipc	ra,0xfffff
    800021b8:	214080e7          	jalr	532(ra) # 800013c8 <_Z11printStringPKc>
        time_sleep(sleep_time);
    800021bc:	00090513          	mv	a0,s2
    800021c0:	fffff097          	auipc	ra,0xfffff
    800021c4:	118080e7          	jalr	280(ra) # 800012d8 <_Z10time_sleepm>
    while (--i > 0) {
    800021c8:	fb9ff06f          	j	80002180 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800021cc:	00a00793          	li	a5,10
    800021d0:	02f95933          	divu	s2,s2,a5
    800021d4:	fff90913          	addi	s2,s2,-1
    800021d8:	00004797          	auipc	a5,0x4
    800021dc:	77078793          	addi	a5,a5,1904 # 80006948 <finishedA>
    800021e0:	01278933          	add	s2,a5,s2
    800021e4:	00100793          	li	a5,1
    800021e8:	00f90423          	sb	a5,8(s2)
}
    800021ec:	01813083          	ld	ra,24(sp)
    800021f0:	01013403          	ld	s0,16(sp)
    800021f4:	00813483          	ld	s1,8(sp)
    800021f8:	00013903          	ld	s2,0(sp)
    800021fc:	02010113          	addi	sp,sp,32
    80002200:	00008067          	ret

0000000080002204 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80002204:	fe010113          	addi	sp,sp,-32
    80002208:	00113c23          	sd	ra,24(sp)
    8000220c:	00813823          	sd	s0,16(sp)
    80002210:	00913423          	sd	s1,8(sp)
    80002214:	01213023          	sd	s2,0(sp)
    80002218:	02010413          	addi	s0,sp,32
    8000221c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002220:	00100793          	li	a5,1
    80002224:	02a7f863          	bgeu	a5,a0,80002254 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002228:	00a00793          	li	a5,10
    8000222c:	02f577b3          	remu	a5,a0,a5
    80002230:	02078e63          	beqz	a5,8000226c <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002234:	fff48513          	addi	a0,s1,-1
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	fcc080e7          	jalr	-52(ra) # 80002204 <_Z9fibonaccim>
    80002240:	00050913          	mv	s2,a0
    80002244:	ffe48513          	addi	a0,s1,-2
    80002248:	00000097          	auipc	ra,0x0
    8000224c:	fbc080e7          	jalr	-68(ra) # 80002204 <_Z9fibonaccim>
    80002250:	00a90533          	add	a0,s2,a0
}
    80002254:	01813083          	ld	ra,24(sp)
    80002258:	01013403          	ld	s0,16(sp)
    8000225c:	00813483          	ld	s1,8(sp)
    80002260:	00013903          	ld	s2,0(sp)
    80002264:	02010113          	addi	sp,sp,32
    80002268:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000226c:	fffff097          	auipc	ra,0xfffff
    80002270:	ec4080e7          	jalr	-316(ra) # 80001130 <_Z15thread_dispatchv>
    80002274:	fc1ff06f          	j	80002234 <_Z9fibonaccim+0x30>

0000000080002278 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80002278:	fe010113          	addi	sp,sp,-32
    8000227c:	00113c23          	sd	ra,24(sp)
    80002280:	00813823          	sd	s0,16(sp)
    80002284:	00913423          	sd	s1,8(sp)
    80002288:	01213023          	sd	s2,0(sp)
    8000228c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002290:	00000493          	li	s1,0
    80002294:	0400006f          	j	800022d4 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002298:	00004517          	auipc	a0,0x4
    8000229c:	de050513          	addi	a0,a0,-544 # 80006078 <CONSOLE_STATUS+0x68>
    800022a0:	fffff097          	auipc	ra,0xfffff
    800022a4:	128080e7          	jalr	296(ra) # 800013c8 <_Z11printStringPKc>
    800022a8:	00000613          	li	a2,0
    800022ac:	00a00593          	li	a1,10
    800022b0:	00048513          	mv	a0,s1
    800022b4:	fffff097          	auipc	ra,0xfffff
    800022b8:	2ac080e7          	jalr	684(ra) # 80001560 <_Z8printIntiii>
    800022bc:	00004517          	auipc	a0,0x4
    800022c0:	ebc50513          	addi	a0,a0,-324 # 80006178 <CONSOLE_STATUS+0x168>
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	104080e7          	jalr	260(ra) # 800013c8 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800022cc:	0014849b          	addiw	s1,s1,1
    800022d0:	0ff4f493          	andi	s1,s1,255
    800022d4:	00200793          	li	a5,2
    800022d8:	fc97f0e3          	bgeu	a5,s1,80002298 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    800022dc:	00004517          	auipc	a0,0x4
    800022e0:	da450513          	addi	a0,a0,-604 # 80006080 <CONSOLE_STATUS+0x70>
    800022e4:	fffff097          	auipc	ra,0xfffff
    800022e8:	0e4080e7          	jalr	228(ra) # 800013c8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800022ec:	00700313          	li	t1,7
    thread_dispatch();
    800022f0:	fffff097          	auipc	ra,0xfffff
    800022f4:	e40080e7          	jalr	-448(ra) # 80001130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800022f8:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800022fc:	00004517          	auipc	a0,0x4
    80002300:	d9450513          	addi	a0,a0,-620 # 80006090 <CONSOLE_STATUS+0x80>
    80002304:	fffff097          	auipc	ra,0xfffff
    80002308:	0c4080e7          	jalr	196(ra) # 800013c8 <_Z11printStringPKc>
    8000230c:	00000613          	li	a2,0
    80002310:	00a00593          	li	a1,10
    80002314:	0009051b          	sext.w	a0,s2
    80002318:	fffff097          	auipc	ra,0xfffff
    8000231c:	248080e7          	jalr	584(ra) # 80001560 <_Z8printIntiii>
    80002320:	00004517          	auipc	a0,0x4
    80002324:	e5850513          	addi	a0,a0,-424 # 80006178 <CONSOLE_STATUS+0x168>
    80002328:	fffff097          	auipc	ra,0xfffff
    8000232c:	0a0080e7          	jalr	160(ra) # 800013c8 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80002330:	00c00513          	li	a0,12
    80002334:	00000097          	auipc	ra,0x0
    80002338:	ed0080e7          	jalr	-304(ra) # 80002204 <_Z9fibonaccim>
    8000233c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002340:	00004517          	auipc	a0,0x4
    80002344:	d5850513          	addi	a0,a0,-680 # 80006098 <CONSOLE_STATUS+0x88>
    80002348:	fffff097          	auipc	ra,0xfffff
    8000234c:	080080e7          	jalr	128(ra) # 800013c8 <_Z11printStringPKc>
    80002350:	00000613          	li	a2,0
    80002354:	00a00593          	li	a1,10
    80002358:	0009051b          	sext.w	a0,s2
    8000235c:	fffff097          	auipc	ra,0xfffff
    80002360:	204080e7          	jalr	516(ra) # 80001560 <_Z8printIntiii>
    80002364:	00004517          	auipc	a0,0x4
    80002368:	e1450513          	addi	a0,a0,-492 # 80006178 <CONSOLE_STATUS+0x168>
    8000236c:	fffff097          	auipc	ra,0xfffff
    80002370:	05c080e7          	jalr	92(ra) # 800013c8 <_Z11printStringPKc>
    80002374:	0400006f          	j	800023b4 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002378:	00004517          	auipc	a0,0x4
    8000237c:	d0050513          	addi	a0,a0,-768 # 80006078 <CONSOLE_STATUS+0x68>
    80002380:	fffff097          	auipc	ra,0xfffff
    80002384:	048080e7          	jalr	72(ra) # 800013c8 <_Z11printStringPKc>
    80002388:	00000613          	li	a2,0
    8000238c:	00a00593          	li	a1,10
    80002390:	00048513          	mv	a0,s1
    80002394:	fffff097          	auipc	ra,0xfffff
    80002398:	1cc080e7          	jalr	460(ra) # 80001560 <_Z8printIntiii>
    8000239c:	00004517          	auipc	a0,0x4
    800023a0:	ddc50513          	addi	a0,a0,-548 # 80006178 <CONSOLE_STATUS+0x168>
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	024080e7          	jalr	36(ra) # 800013c8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800023ac:	0014849b          	addiw	s1,s1,1
    800023b0:	0ff4f493          	andi	s1,s1,255
    800023b4:	00500793          	li	a5,5
    800023b8:	fc97f0e3          	bgeu	a5,s1,80002378 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    800023bc:	00004517          	auipc	a0,0x4
    800023c0:	c8450513          	addi	a0,a0,-892 # 80006040 <CONSOLE_STATUS+0x30>
    800023c4:	fffff097          	auipc	ra,0xfffff
    800023c8:	004080e7          	jalr	4(ra) # 800013c8 <_Z11printStringPKc>
    finishedC = true;
    800023cc:	00100793          	li	a5,1
    800023d0:	00004717          	auipc	a4,0x4
    800023d4:	58f70423          	sb	a5,1416(a4) # 80006958 <finishedC>
    thread_dispatch();
    800023d8:	fffff097          	auipc	ra,0xfffff
    800023dc:	d58080e7          	jalr	-680(ra) # 80001130 <_Z15thread_dispatchv>
}
    800023e0:	01813083          	ld	ra,24(sp)
    800023e4:	01013403          	ld	s0,16(sp)
    800023e8:	00813483          	ld	s1,8(sp)
    800023ec:	00013903          	ld	s2,0(sp)
    800023f0:	02010113          	addi	sp,sp,32
    800023f4:	00008067          	ret

00000000800023f8 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    800023f8:	fe010113          	addi	sp,sp,-32
    800023fc:	00113c23          	sd	ra,24(sp)
    80002400:	00813823          	sd	s0,16(sp)
    80002404:	00913423          	sd	s1,8(sp)
    80002408:	01213023          	sd	s2,0(sp)
    8000240c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002410:	00a00493          	li	s1,10
    80002414:	0400006f          	j	80002454 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002418:	00004517          	auipc	a0,0x4
    8000241c:	c9050513          	addi	a0,a0,-880 # 800060a8 <CONSOLE_STATUS+0x98>
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	fa8080e7          	jalr	-88(ra) # 800013c8 <_Z11printStringPKc>
    80002428:	00000613          	li	a2,0
    8000242c:	00a00593          	li	a1,10
    80002430:	00048513          	mv	a0,s1
    80002434:	fffff097          	auipc	ra,0xfffff
    80002438:	12c080e7          	jalr	300(ra) # 80001560 <_Z8printIntiii>
    8000243c:	00004517          	auipc	a0,0x4
    80002440:	d3c50513          	addi	a0,a0,-708 # 80006178 <CONSOLE_STATUS+0x168>
    80002444:	fffff097          	auipc	ra,0xfffff
    80002448:	f84080e7          	jalr	-124(ra) # 800013c8 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000244c:	0014849b          	addiw	s1,s1,1
    80002450:	0ff4f493          	andi	s1,s1,255
    80002454:	00c00793          	li	a5,12
    80002458:	fc97f0e3          	bgeu	a5,s1,80002418 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000245c:	00004517          	auipc	a0,0x4
    80002460:	c5450513          	addi	a0,a0,-940 # 800060b0 <CONSOLE_STATUS+0xa0>
    80002464:	fffff097          	auipc	ra,0xfffff
    80002468:	f64080e7          	jalr	-156(ra) # 800013c8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000246c:	00500313          	li	t1,5
    thread_dispatch();
    80002470:	fffff097          	auipc	ra,0xfffff
    80002474:	cc0080e7          	jalr	-832(ra) # 80001130 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002478:	01000513          	li	a0,16
    8000247c:	00000097          	auipc	ra,0x0
    80002480:	d88080e7          	jalr	-632(ra) # 80002204 <_Z9fibonaccim>
    80002484:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002488:	00004517          	auipc	a0,0x4
    8000248c:	c3850513          	addi	a0,a0,-968 # 800060c0 <CONSOLE_STATUS+0xb0>
    80002490:	fffff097          	auipc	ra,0xfffff
    80002494:	f38080e7          	jalr	-200(ra) # 800013c8 <_Z11printStringPKc>
    80002498:	00000613          	li	a2,0
    8000249c:	00a00593          	li	a1,10
    800024a0:	0009051b          	sext.w	a0,s2
    800024a4:	fffff097          	auipc	ra,0xfffff
    800024a8:	0bc080e7          	jalr	188(ra) # 80001560 <_Z8printIntiii>
    800024ac:	00004517          	auipc	a0,0x4
    800024b0:	ccc50513          	addi	a0,a0,-820 # 80006178 <CONSOLE_STATUS+0x168>
    800024b4:	fffff097          	auipc	ra,0xfffff
    800024b8:	f14080e7          	jalr	-236(ra) # 800013c8 <_Z11printStringPKc>
    800024bc:	0400006f          	j	800024fc <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800024c0:	00004517          	auipc	a0,0x4
    800024c4:	be850513          	addi	a0,a0,-1048 # 800060a8 <CONSOLE_STATUS+0x98>
    800024c8:	fffff097          	auipc	ra,0xfffff
    800024cc:	f00080e7          	jalr	-256(ra) # 800013c8 <_Z11printStringPKc>
    800024d0:	00000613          	li	a2,0
    800024d4:	00a00593          	li	a1,10
    800024d8:	00048513          	mv	a0,s1
    800024dc:	fffff097          	auipc	ra,0xfffff
    800024e0:	084080e7          	jalr	132(ra) # 80001560 <_Z8printIntiii>
    800024e4:	00004517          	auipc	a0,0x4
    800024e8:	c9450513          	addi	a0,a0,-876 # 80006178 <CONSOLE_STATUS+0x168>
    800024ec:	fffff097          	auipc	ra,0xfffff
    800024f0:	edc080e7          	jalr	-292(ra) # 800013c8 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800024f4:	0014849b          	addiw	s1,s1,1
    800024f8:	0ff4f493          	andi	s1,s1,255
    800024fc:	00f00793          	li	a5,15
    80002500:	fc97f0e3          	bgeu	a5,s1,800024c0 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002504:	00004517          	auipc	a0,0x4
    80002508:	bcc50513          	addi	a0,a0,-1076 # 800060d0 <CONSOLE_STATUS+0xc0>
    8000250c:	fffff097          	auipc	ra,0xfffff
    80002510:	ebc080e7          	jalr	-324(ra) # 800013c8 <_Z11printStringPKc>
    finishedD = true;
    80002514:	00100793          	li	a5,1
    80002518:	00004717          	auipc	a4,0x4
    8000251c:	44f700a3          	sb	a5,1089(a4) # 80006959 <finishedD>
    thread_dispatch();
    80002520:	fffff097          	auipc	ra,0xfffff
    80002524:	c10080e7          	jalr	-1008(ra) # 80001130 <_Z15thread_dispatchv>
}
    80002528:	01813083          	ld	ra,24(sp)
    8000252c:	01013403          	ld	s0,16(sp)
    80002530:	00813483          	ld	s1,8(sp)
    80002534:	00013903          	ld	s2,0(sp)
    80002538:	02010113          	addi	sp,sp,32
    8000253c:	00008067          	ret

0000000080002540 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80002540:	fc010113          	addi	sp,sp,-64
    80002544:	02113c23          	sd	ra,56(sp)
    80002548:	02813823          	sd	s0,48(sp)
    8000254c:	02913423          	sd	s1,40(sp)
    80002550:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80002554:	00000613          	li	a2,0
    80002558:	00000597          	auipc	a1,0x0
    8000255c:	a6858593          	addi	a1,a1,-1432 # 80001fc0 <_Z11workerBodyAPv>
    80002560:	fc040513          	addi	a0,s0,-64
    80002564:	fffff097          	auipc	ra,0xfffff
    80002568:	b18080e7          	jalr	-1256(ra) # 8000107c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000256c:	00004517          	auipc	a0,0x4
    80002570:	b7450513          	addi	a0,a0,-1164 # 800060e0 <CONSOLE_STATUS+0xd0>
    80002574:	fffff097          	auipc	ra,0xfffff
    80002578:	e54080e7          	jalr	-428(ra) # 800013c8 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000257c:	00000613          	li	a2,0
    80002580:	00000597          	auipc	a1,0x0
    80002584:	b0c58593          	addi	a1,a1,-1268 # 8000208c <_Z11workerBodyBPv>
    80002588:	fc840513          	addi	a0,s0,-56
    8000258c:	fffff097          	auipc	ra,0xfffff
    80002590:	af0080e7          	jalr	-1296(ra) # 8000107c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80002594:	00004517          	auipc	a0,0x4
    80002598:	b6450513          	addi	a0,a0,-1180 # 800060f8 <CONSOLE_STATUS+0xe8>
    8000259c:	fffff097          	auipc	ra,0xfffff
    800025a0:	e2c080e7          	jalr	-468(ra) # 800013c8 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800025a4:	00000613          	li	a2,0
    800025a8:	00000597          	auipc	a1,0x0
    800025ac:	cd058593          	addi	a1,a1,-816 # 80002278 <_Z11workerBodyCPv>
    800025b0:	fd040513          	addi	a0,s0,-48
    800025b4:	fffff097          	auipc	ra,0xfffff
    800025b8:	ac8080e7          	jalr	-1336(ra) # 8000107c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    800025bc:	00004517          	auipc	a0,0x4
    800025c0:	b5450513          	addi	a0,a0,-1196 # 80006110 <CONSOLE_STATUS+0x100>
    800025c4:	fffff097          	auipc	ra,0xfffff
    800025c8:	e04080e7          	jalr	-508(ra) # 800013c8 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800025cc:	00000613          	li	a2,0
    800025d0:	00000597          	auipc	a1,0x0
    800025d4:	e2858593          	addi	a1,a1,-472 # 800023f8 <_Z11workerBodyDPv>
    800025d8:	fd840513          	addi	a0,s0,-40
    800025dc:	fffff097          	auipc	ra,0xfffff
    800025e0:	aa0080e7          	jalr	-1376(ra) # 8000107c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800025e4:	00004517          	auipc	a0,0x4
    800025e8:	b4450513          	addi	a0,a0,-1212 # 80006128 <CONSOLE_STATUS+0x118>
    800025ec:	fffff097          	auipc	ra,0xfffff
    800025f0:	ddc080e7          	jalr	-548(ra) # 800013c8 <_Z11printStringPKc>
    800025f4:	00c0006f          	j	80002600 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800025f8:	fffff097          	auipc	ra,0xfffff
    800025fc:	b38080e7          	jalr	-1224(ra) # 80001130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002600:	00004797          	auipc	a5,0x4
    80002604:	3487c783          	lbu	a5,840(a5) # 80006948 <finishedA>
    80002608:	fe0788e3          	beqz	a5,800025f8 <_Z18Threads_C_API_testv+0xb8>
    8000260c:	00004797          	auipc	a5,0x4
    80002610:	33d7c783          	lbu	a5,829(a5) # 80006949 <finishedB>
    80002614:	fe0782e3          	beqz	a5,800025f8 <_Z18Threads_C_API_testv+0xb8>
    80002618:	00004797          	auipc	a5,0x4
    8000261c:	3407c783          	lbu	a5,832(a5) # 80006958 <finishedC>
    80002620:	fc078ce3          	beqz	a5,800025f8 <_Z18Threads_C_API_testv+0xb8>
    80002624:	00004797          	auipc	a5,0x4
    80002628:	3357c783          	lbu	a5,821(a5) # 80006959 <finishedD>
    8000262c:	fc0786e3          	beqz	a5,800025f8 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80002630:	fc040493          	addi	s1,s0,-64
    80002634:	0080006f          	j	8000263c <_Z18Threads_C_API_testv+0xfc>
    80002638:	00848493          	addi	s1,s1,8
    8000263c:	fe040793          	addi	a5,s0,-32
    80002640:	00f48c63          	beq	s1,a5,80002658 <_Z18Threads_C_API_testv+0x118>
    80002644:	0004b503          	ld	a0,0(s1)
    80002648:	fe0508e3          	beqz	a0,80002638 <_Z18Threads_C_API_testv+0xf8>
    8000264c:	fffff097          	auipc	ra,0xfffff
    80002650:	d54080e7          	jalr	-684(ra) # 800013a0 <_ZN7_threaddlEPv>
    80002654:	fe5ff06f          	j	80002638 <_Z18Threads_C_API_testv+0xf8>
}
    80002658:	03813083          	ld	ra,56(sp)
    8000265c:	03013403          	ld	s0,48(sp)
    80002660:	02813483          	ld	s1,40(sp)
    80002664:	04010113          	addi	sp,sp,64
    80002668:	00008067          	ret

000000008000266c <_Z12testSleepingv>:

void testSleeping() {
    8000266c:	fc010113          	addi	sp,sp,-64
    80002670:	02113c23          	sd	ra,56(sp)
    80002674:	02813823          	sd	s0,48(sp)
    80002678:	02913423          	sd	s1,40(sp)
    8000267c:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80002680:	00a00793          	li	a5,10
    80002684:	fcf43823          	sd	a5,-48(s0)
    80002688:	01400793          	li	a5,20
    8000268c:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80002690:	00000493          	li	s1,0
    80002694:	02c0006f          	j	800026c0 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80002698:	00349793          	slli	a5,s1,0x3
    8000269c:	fd040613          	addi	a2,s0,-48
    800026a0:	00f60633          	add	a2,a2,a5
    800026a4:	00000597          	auipc	a1,0x0
    800026a8:	abc58593          	addi	a1,a1,-1348 # 80002160 <_Z9sleepyRunPv>
    800026ac:	fc040513          	addi	a0,s0,-64
    800026b0:	00f50533          	add	a0,a0,a5
    800026b4:	fffff097          	auipc	ra,0xfffff
    800026b8:	9c8080e7          	jalr	-1592(ra) # 8000107c <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800026bc:	0014849b          	addiw	s1,s1,1
    800026c0:	00100793          	li	a5,1
    800026c4:	fc97dae3          	bge	a5,s1,80002698 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800026c8:	00004797          	auipc	a5,0x4
    800026cc:	2887c783          	lbu	a5,648(a5) # 80006950 <finished>
    800026d0:	fe078ce3          	beqz	a5,800026c8 <_Z12testSleepingv+0x5c>
    800026d4:	00004797          	auipc	a5,0x4
    800026d8:	27d7c783          	lbu	a5,637(a5) # 80006951 <finished+0x1>
    800026dc:	fe0786e3          	beqz	a5,800026c8 <_Z12testSleepingv+0x5c>
}
    800026e0:	03813083          	ld	ra,56(sp)
    800026e4:	03013403          	ld	s0,48(sp)
    800026e8:	02813483          	ld	s1,40(sp)
    800026ec:	04010113          	addi	sp,sp,64
    800026f0:	00008067          	ret

00000000800026f4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    800026f4:	f8010113          	addi	sp,sp,-128
    800026f8:	06113c23          	sd	ra,120(sp)
    800026fc:	06813823          	sd	s0,112(sp)
    80002700:	06913423          	sd	s1,104(sp)
    80002704:	07213023          	sd	s2,96(sp)
    80002708:	05313c23          	sd	s3,88(sp)
    8000270c:	05413823          	sd	s4,80(sp)
    80002710:	05513423          	sd	s5,72(sp)
    80002714:	05613023          	sd	s6,64(sp)
    80002718:	03713c23          	sd	s7,56(sp)
    8000271c:	03813823          	sd	s8,48(sp)
    80002720:	03913423          	sd	s9,40(sp)
    80002724:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80002728:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    8000272c:	00004517          	auipc	a0,0x4
    80002730:	a1450513          	addi	a0,a0,-1516 # 80006140 <CONSOLE_STATUS+0x130>
    80002734:	fffff097          	auipc	ra,0xfffff
    80002738:	c94080e7          	jalr	-876(ra) # 800013c8 <_Z11printStringPKc>
        getString(input, 30);
    8000273c:	01e00593          	li	a1,30
    80002740:	f8040493          	addi	s1,s0,-128
    80002744:	00048513          	mv	a0,s1
    80002748:	fffff097          	auipc	ra,0xfffff
    8000274c:	cfc080e7          	jalr	-772(ra) # 80001444 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80002750:	00048513          	mv	a0,s1
    80002754:	fffff097          	auipc	ra,0xfffff
    80002758:	dbc080e7          	jalr	-580(ra) # 80001510 <_Z11stringToIntPKc>
    8000275c:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    80002760:	00004517          	auipc	a0,0x4
    80002764:	a0050513          	addi	a0,a0,-1536 # 80006160 <CONSOLE_STATUS+0x150>
    80002768:	fffff097          	auipc	ra,0xfffff
    8000276c:	c60080e7          	jalr	-928(ra) # 800013c8 <_Z11printStringPKc>
        getString(input, 30);
    80002770:	01e00593          	li	a1,30
    80002774:	00048513          	mv	a0,s1
    80002778:	fffff097          	auipc	ra,0xfffff
    8000277c:	ccc080e7          	jalr	-820(ra) # 80001444 <_Z9getStringPci>
        n = stringToInt(input);
    80002780:	00048513          	mv	a0,s1
    80002784:	fffff097          	auipc	ra,0xfffff
    80002788:	d8c080e7          	jalr	-628(ra) # 80001510 <_Z11stringToIntPKc>
    8000278c:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80002790:	00004517          	auipc	a0,0x4
    80002794:	9f050513          	addi	a0,a0,-1552 # 80006180 <CONSOLE_STATUS+0x170>
    80002798:	fffff097          	auipc	ra,0xfffff
    8000279c:	c30080e7          	jalr	-976(ra) # 800013c8 <_Z11printStringPKc>
    800027a0:	00000613          	li	a2,0
    800027a4:	00a00593          	li	a1,10
    800027a8:	00090513          	mv	a0,s2
    800027ac:	fffff097          	auipc	ra,0xfffff
    800027b0:	db4080e7          	jalr	-588(ra) # 80001560 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    800027b4:	00004517          	auipc	a0,0x4
    800027b8:	9e450513          	addi	a0,a0,-1564 # 80006198 <CONSOLE_STATUS+0x188>
    800027bc:	fffff097          	auipc	ra,0xfffff
    800027c0:	c0c080e7          	jalr	-1012(ra) # 800013c8 <_Z11printStringPKc>
    800027c4:	00000613          	li	a2,0
    800027c8:	00a00593          	li	a1,10
    800027cc:	00048513          	mv	a0,s1
    800027d0:	fffff097          	auipc	ra,0xfffff
    800027d4:	d90080e7          	jalr	-624(ra) # 80001560 <_Z8printIntiii>
        printString(".\n");
    800027d8:	00004517          	auipc	a0,0x4
    800027dc:	9d850513          	addi	a0,a0,-1576 # 800061b0 <CONSOLE_STATUS+0x1a0>
    800027e0:	fffff097          	auipc	ra,0xfffff
    800027e4:	be8080e7          	jalr	-1048(ra) # 800013c8 <_Z11printStringPKc>
        if(threadNum > n) {
    800027e8:	0324c663          	blt	s1,s2,80002814 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    800027ec:	03205e63          	blez	s2,80002828 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    800027f0:	03800513          	li	a0,56
    800027f4:	fffff097          	auipc	ra,0xfffff
    800027f8:	f24080e7          	jalr	-220(ra) # 80001718 <_Znwm>
    800027fc:	00050a93          	mv	s5,a0
    80002800:	04050063          	beqz	a0,80002840 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    80002804:	00048593          	mv	a1,s1
    80002808:	fffff097          	auipc	ra,0xfffff
    8000280c:	3b0080e7          	jalr	944(ra) # 80001bb8 <_ZN9BufferCPPC1Ei>
    80002810:	0300006f          	j	80002840 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002814:	00004517          	auipc	a0,0x4
    80002818:	9a450513          	addi	a0,a0,-1628 # 800061b8 <CONSOLE_STATUS+0x1a8>
    8000281c:	fffff097          	auipc	ra,0xfffff
    80002820:	bac080e7          	jalr	-1108(ra) # 800013c8 <_Z11printStringPKc>
            return;
    80002824:	0140006f          	j	80002838 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002828:	00004517          	auipc	a0,0x4
    8000282c:	9d050513          	addi	a0,a0,-1584 # 800061f8 <CONSOLE_STATUS+0x1e8>
    80002830:	fffff097          	auipc	ra,0xfffff
    80002834:	b98080e7          	jalr	-1128(ra) # 800013c8 <_Z11printStringPKc>
            return;
    80002838:	000b8113          	mv	sp,s7
    8000283c:	24c0006f          	j	80002a88 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    80002840:	01000513          	li	a0,16
    80002844:	fffff097          	auipc	ra,0xfffff
    80002848:	ed4080e7          	jalr	-300(ra) # 80001718 <_Znwm>
    8000284c:	00050493          	mv	s1,a0
    80002850:	00050863          	beqz	a0,80002860 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    80002854:	00000593          	li	a1,0
    80002858:	fffff097          	auipc	ra,0xfffff
    8000285c:	fb8080e7          	jalr	-72(ra) # 80001810 <_ZN9SemaphoreC1Ej>
    80002860:	00004717          	auipc	a4,0x4
    80002864:	0e870713          	addi	a4,a4,232 # 80006948 <finishedA>
    80002868:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    8000286c:	00391793          	slli	a5,s2,0x3
    80002870:	00f78793          	addi	a5,a5,15
    80002874:	ff07f793          	andi	a5,a5,-16
    80002878:	40f10133          	sub	sp,sp,a5
    8000287c:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80002880:	0019069b          	addiw	a3,s2,1
    80002884:	00169793          	slli	a5,a3,0x1
    80002888:	00d787b3          	add	a5,a5,a3
    8000288c:	00379793          	slli	a5,a5,0x3
    80002890:	00f78793          	addi	a5,a5,15
    80002894:	ff07f793          	andi	a5,a5,-16
    80002898:	40f10133          	sub	sp,sp,a5
    8000289c:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    800028a0:	00191793          	slli	a5,s2,0x1
    800028a4:	012787b3          	add	a5,a5,s2
    800028a8:	00379793          	slli	a5,a5,0x3
    800028ac:	00f987b3          	add	a5,s3,a5
    800028b0:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    800028b4:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    800028b8:	01873703          	ld	a4,24(a4)
    800028bc:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800028c0:	01800513          	li	a0,24
    800028c4:	fffff097          	auipc	ra,0xfffff
    800028c8:	e54080e7          	jalr	-428(ra) # 80001718 <_Znwm>
    800028cc:	00050b13          	mv	s6,a0
    800028d0:	02050663          	beqz	a0,800028fc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    800028d4:	00191493          	slli	s1,s2,0x1
    800028d8:	012484b3          	add	s1,s1,s2
    800028dc:	00349493          	slli	s1,s1,0x3
    800028e0:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    800028e4:	fffff097          	auipc	ra,0xfffff
    800028e8:	010080e7          	jalr	16(ra) # 800018f4 <_ZN6ThreadC1Ev>
    800028ec:	00004797          	auipc	a5,0x4
    800028f0:	f1478793          	addi	a5,a5,-236 # 80006800 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800028f4:	00fb3023          	sd	a5,0(s6)
    800028f8:	009b3823          	sd	s1,16(s6)
        consumer->start();
    800028fc:	000b0513          	mv	a0,s6
    80002900:	fffff097          	auipc	ra,0xfffff
    80002904:	0e4080e7          	jalr	228(ra) # 800019e4 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80002908:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    8000290c:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    80002910:	00004797          	auipc	a5,0x4
    80002914:	0507b783          	ld	a5,80(a5) # 80006960 <_ZN19ConsumerProducerCPP10waitForAllE>
    80002918:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000291c:	01800513          	li	a0,24
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	df8080e7          	jalr	-520(ra) # 80001718 <_Znwm>
    80002928:	00050493          	mv	s1,a0
    8000292c:	00050e63          	beqz	a0,80002948 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80002930:	fffff097          	auipc	ra,0xfffff
    80002934:	fc4080e7          	jalr	-60(ra) # 800018f4 <_ZN6ThreadC1Ev>
    80002938:	00004797          	auipc	a5,0x4
    8000293c:	e7878793          	addi	a5,a5,-392 # 800067b0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80002940:	00f4b023          	sd	a5,0(s1)
    80002944:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80002948:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    8000294c:	00048513          	mv	a0,s1
    80002950:	fffff097          	auipc	ra,0xfffff
    80002954:	094080e7          	jalr	148(ra) # 800019e4 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80002958:	00100493          	li	s1,1
    8000295c:	0300006f          	j	8000298c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80002960:	00004797          	auipc	a5,0x4
    80002964:	e7878793          	addi	a5,a5,-392 # 800067d8 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80002968:	00fc3023          	sd	a5,0(s8)
    8000296c:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    80002970:	00349793          	slli	a5,s1,0x3
    80002974:	00fa07b3          	add	a5,s4,a5
    80002978:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    8000297c:	000c0513          	mv	a0,s8
    80002980:	fffff097          	auipc	ra,0xfffff
    80002984:	064080e7          	jalr	100(ra) # 800019e4 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80002988:	0014849b          	addiw	s1,s1,1
    8000298c:	0524dc63          	bge	s1,s2,800029e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    80002990:	00149793          	slli	a5,s1,0x1
    80002994:	009787b3          	add	a5,a5,s1
    80002998:	00379793          	slli	a5,a5,0x3
    8000299c:	00f987b3          	add	a5,s3,a5
    800029a0:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    800029a4:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    800029a8:	00004717          	auipc	a4,0x4
    800029ac:	fb873703          	ld	a4,-72(a4) # 80006960 <_ZN19ConsumerProducerCPP10waitForAllE>
    800029b0:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    800029b4:	01800513          	li	a0,24
    800029b8:	fffff097          	auipc	ra,0xfffff
    800029bc:	d60080e7          	jalr	-672(ra) # 80001718 <_Znwm>
    800029c0:	00050c13          	mv	s8,a0
    800029c4:	fa0506e3          	beqz	a0,80002970 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    800029c8:	00149c93          	slli	s9,s1,0x1
    800029cc:	009c8cb3          	add	s9,s9,s1
    800029d0:	003c9c93          	slli	s9,s9,0x3
    800029d4:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800029d8:	fffff097          	auipc	ra,0xfffff
    800029dc:	f1c080e7          	jalr	-228(ra) # 800018f4 <_ZN6ThreadC1Ev>
    800029e0:	f81ff06f          	j	80002960 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    800029e4:	fffff097          	auipc	ra,0xfffff
    800029e8:	fd8080e7          	jalr	-40(ra) # 800019bc <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    800029ec:	00000493          	li	s1,0
    800029f0:	00994e63          	blt	s2,s1,80002a0c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    800029f4:	00004517          	auipc	a0,0x4
    800029f8:	f6c53503          	ld	a0,-148(a0) # 80006960 <_ZN19ConsumerProducerCPP10waitForAllE>
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	e4c080e7          	jalr	-436(ra) # 80001848 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80002a04:	0014849b          	addiw	s1,s1,1
    80002a08:	fe9ff06f          	j	800029f0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    80002a0c:	00004517          	auipc	a0,0x4
    80002a10:	f5453503          	ld	a0,-172(a0) # 80006960 <_ZN19ConsumerProducerCPP10waitForAllE>
    80002a14:	00050863          	beqz	a0,80002a24 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    80002a18:	00053783          	ld	a5,0(a0)
    80002a1c:	0087b783          	ld	a5,8(a5)
    80002a20:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80002a24:	00000493          	li	s1,0
    80002a28:	0080006f          	j	80002a30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    80002a2c:	0014849b          	addiw	s1,s1,1
    80002a30:	0324d263          	bge	s1,s2,80002a54 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    80002a34:	00349793          	slli	a5,s1,0x3
    80002a38:	00fa07b3          	add	a5,s4,a5
    80002a3c:	0007b503          	ld	a0,0(a5)
    80002a40:	fe0506e3          	beqz	a0,80002a2c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    80002a44:	00053783          	ld	a5,0(a0)
    80002a48:	0087b783          	ld	a5,8(a5)
    80002a4c:	000780e7          	jalr	a5
    80002a50:	fddff06f          	j	80002a2c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    80002a54:	000b0a63          	beqz	s6,80002a68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    80002a58:	000b3783          	ld	a5,0(s6)
    80002a5c:	0087b783          	ld	a5,8(a5)
    80002a60:	000b0513          	mv	a0,s6
    80002a64:	000780e7          	jalr	a5
        delete buffer;
    80002a68:	000a8e63          	beqz	s5,80002a84 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    80002a6c:	000a8513          	mv	a0,s5
    80002a70:	fffff097          	auipc	ra,0xfffff
    80002a74:	450080e7          	jalr	1104(ra) # 80001ec0 <_ZN9BufferCPPD1Ev>
    80002a78:	000a8513          	mv	a0,s5
    80002a7c:	fffff097          	auipc	ra,0xfffff
    80002a80:	cec080e7          	jalr	-788(ra) # 80001768 <_ZdlPv>
    80002a84:	000b8113          	mv	sp,s7
    }
    80002a88:	f8040113          	addi	sp,s0,-128
    80002a8c:	07813083          	ld	ra,120(sp)
    80002a90:	07013403          	ld	s0,112(sp)
    80002a94:	06813483          	ld	s1,104(sp)
    80002a98:	06013903          	ld	s2,96(sp)
    80002a9c:	05813983          	ld	s3,88(sp)
    80002aa0:	05013a03          	ld	s4,80(sp)
    80002aa4:	04813a83          	ld	s5,72(sp)
    80002aa8:	04013b03          	ld	s6,64(sp)
    80002aac:	03813b83          	ld	s7,56(sp)
    80002ab0:	03013c03          	ld	s8,48(sp)
    80002ab4:	02813c83          	ld	s9,40(sp)
    80002ab8:	08010113          	addi	sp,sp,128
    80002abc:	00008067          	ret
    80002ac0:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80002ac4:	000a8513          	mv	a0,s5
    80002ac8:	fffff097          	auipc	ra,0xfffff
    80002acc:	ca0080e7          	jalr	-864(ra) # 80001768 <_ZdlPv>
    80002ad0:	00048513          	mv	a0,s1
    80002ad4:	00005097          	auipc	ra,0x5
    80002ad8:	f64080e7          	jalr	-156(ra) # 80007a38 <_Unwind_Resume>
    80002adc:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80002ae0:	00048513          	mv	a0,s1
    80002ae4:	fffff097          	auipc	ra,0xfffff
    80002ae8:	c84080e7          	jalr	-892(ra) # 80001768 <_ZdlPv>
    80002aec:	00090513          	mv	a0,s2
    80002af0:	00005097          	auipc	ra,0x5
    80002af4:	f48080e7          	jalr	-184(ra) # 80007a38 <_Unwind_Resume>
    80002af8:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80002afc:	000b0513          	mv	a0,s6
    80002b00:	fffff097          	auipc	ra,0xfffff
    80002b04:	c68080e7          	jalr	-920(ra) # 80001768 <_ZdlPv>
    80002b08:	00048513          	mv	a0,s1
    80002b0c:	00005097          	auipc	ra,0x5
    80002b10:	f2c080e7          	jalr	-212(ra) # 80007a38 <_Unwind_Resume>
    80002b14:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80002b18:	00048513          	mv	a0,s1
    80002b1c:	fffff097          	auipc	ra,0xfffff
    80002b20:	c4c080e7          	jalr	-948(ra) # 80001768 <_ZdlPv>
    80002b24:	00090513          	mv	a0,s2
    80002b28:	00005097          	auipc	ra,0x5
    80002b2c:	f10080e7          	jalr	-240(ra) # 80007a38 <_Unwind_Resume>
    80002b30:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80002b34:	000c0513          	mv	a0,s8
    80002b38:	fffff097          	auipc	ra,0xfffff
    80002b3c:	c30080e7          	jalr	-976(ra) # 80001768 <_ZdlPv>
    80002b40:	00048513          	mv	a0,s1
    80002b44:	00005097          	auipc	ra,0x5
    80002b48:	ef4080e7          	jalr	-268(ra) # 80007a38 <_Unwind_Resume>

0000000080002b4c <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80002b4c:	ff010113          	addi	sp,sp,-16
    80002b50:	00113423          	sd	ra,8(sp)
    80002b54:	00813023          	sd	s0,0(sp)
    80002b58:	01010413          	addi	s0,sp,16
    Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    80002b5c:	00000097          	auipc	ra,0x0
    80002b60:	9e4080e7          	jalr	-1564(ra) # 80002540 <_Z18Threads_C_API_testv>
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    80002b64:	00813083          	ld	ra,8(sp)
    80002b68:	00013403          	ld	s0,0(sp)
    80002b6c:	01010113          	addi	sp,sp,16
    80002b70:	00008067          	ret

0000000080002b74 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80002b74:	fd010113          	addi	sp,sp,-48
    80002b78:	02113423          	sd	ra,40(sp)
    80002b7c:	02813023          	sd	s0,32(sp)
    80002b80:	00913c23          	sd	s1,24(sp)
    80002b84:	01213823          	sd	s2,16(sp)
    80002b88:	01313423          	sd	s3,8(sp)
    80002b8c:	03010413          	addi	s0,sp,48
    80002b90:	00050913          	mv	s2,a0
            int i = 0;
    80002b94:	00000993          	li	s3,0
    80002b98:	0100006f          	j	80002ba8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80002b9c:	00a00513          	li	a0,10
    80002ba0:	fffff097          	auipc	ra,0xfffff
    80002ba4:	f0c080e7          	jalr	-244(ra) # 80001aac <_ZN7Console4putcEc>
            while (!threadEnd) {
    80002ba8:	00004797          	auipc	a5,0x4
    80002bac:	dac7a783          	lw	a5,-596(a5) # 80006954 <_ZN19ConsumerProducerCPP9threadEndE>
    80002bb0:	04079a63          	bnez	a5,80002c04 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80002bb4:	01093783          	ld	a5,16(s2)
    80002bb8:	0087b503          	ld	a0,8(a5)
    80002bbc:	fffff097          	auipc	ra,0xfffff
    80002bc0:	1f0080e7          	jalr	496(ra) # 80001dac <_ZN9BufferCPP3getEv>
                i++;
    80002bc4:	0019849b          	addiw	s1,s3,1
    80002bc8:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80002bcc:	0ff57513          	andi	a0,a0,255
    80002bd0:	fffff097          	auipc	ra,0xfffff
    80002bd4:	edc080e7          	jalr	-292(ra) # 80001aac <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80002bd8:	05000793          	li	a5,80
    80002bdc:	02f4e4bb          	remw	s1,s1,a5
    80002be0:	fc0494e3          	bnez	s1,80002ba8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80002be4:	fb9ff06f          	j	80002b9c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80002be8:	01093783          	ld	a5,16(s2)
    80002bec:	0087b503          	ld	a0,8(a5)
    80002bf0:	fffff097          	auipc	ra,0xfffff
    80002bf4:	1bc080e7          	jalr	444(ra) # 80001dac <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80002bf8:	0ff57513          	andi	a0,a0,255
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	eb0080e7          	jalr	-336(ra) # 80001aac <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80002c04:	01093783          	ld	a5,16(s2)
    80002c08:	0087b503          	ld	a0,8(a5)
    80002c0c:	fffff097          	auipc	ra,0xfffff
    80002c10:	22c080e7          	jalr	556(ra) # 80001e38 <_ZN9BufferCPP6getCntEv>
    80002c14:	fca04ae3          	bgtz	a0,80002be8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80002c18:	01093783          	ld	a5,16(s2)
    80002c1c:	0107b503          	ld	a0,16(a5)
    80002c20:	fffff097          	auipc	ra,0xfffff
    80002c24:	c54080e7          	jalr	-940(ra) # 80001874 <_ZN9Semaphore6signalEv>
        }
    80002c28:	02813083          	ld	ra,40(sp)
    80002c2c:	02013403          	ld	s0,32(sp)
    80002c30:	01813483          	ld	s1,24(sp)
    80002c34:	01013903          	ld	s2,16(sp)
    80002c38:	00813983          	ld	s3,8(sp)
    80002c3c:	03010113          	addi	sp,sp,48
    80002c40:	00008067          	ret

0000000080002c44 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80002c44:	ff010113          	addi	sp,sp,-16
    80002c48:	00113423          	sd	ra,8(sp)
    80002c4c:	00813023          	sd	s0,0(sp)
    80002c50:	01010413          	addi	s0,sp,16
    80002c54:	00004797          	auipc	a5,0x4
    80002c58:	bac78793          	addi	a5,a5,-1108 # 80006800 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80002c5c:	00f53023          	sd	a5,0(a0)
    80002c60:	fffff097          	auipc	ra,0xfffff
    80002c64:	a78080e7          	jalr	-1416(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80002c68:	00813083          	ld	ra,8(sp)
    80002c6c:	00013403          	ld	s0,0(sp)
    80002c70:	01010113          	addi	sp,sp,16
    80002c74:	00008067          	ret

0000000080002c78 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80002c78:	fe010113          	addi	sp,sp,-32
    80002c7c:	00113c23          	sd	ra,24(sp)
    80002c80:	00813823          	sd	s0,16(sp)
    80002c84:	00913423          	sd	s1,8(sp)
    80002c88:	02010413          	addi	s0,sp,32
    80002c8c:	00050493          	mv	s1,a0
    80002c90:	00004797          	auipc	a5,0x4
    80002c94:	b7078793          	addi	a5,a5,-1168 # 80006800 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80002c98:	00f53023          	sd	a5,0(a0)
    80002c9c:	fffff097          	auipc	ra,0xfffff
    80002ca0:	a3c080e7          	jalr	-1476(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80002ca4:	00048513          	mv	a0,s1
    80002ca8:	fffff097          	auipc	ra,0xfffff
    80002cac:	ac0080e7          	jalr	-1344(ra) # 80001768 <_ZdlPv>
    80002cb0:	01813083          	ld	ra,24(sp)
    80002cb4:	01013403          	ld	s0,16(sp)
    80002cb8:	00813483          	ld	s1,8(sp)
    80002cbc:	02010113          	addi	sp,sp,32
    80002cc0:	00008067          	ret

0000000080002cc4 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80002cc4:	ff010113          	addi	sp,sp,-16
    80002cc8:	00113423          	sd	ra,8(sp)
    80002ccc:	00813023          	sd	s0,0(sp)
    80002cd0:	01010413          	addi	s0,sp,16
    80002cd4:	00004797          	auipc	a5,0x4
    80002cd8:	adc78793          	addi	a5,a5,-1316 # 800067b0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80002cdc:	00f53023          	sd	a5,0(a0)
    80002ce0:	fffff097          	auipc	ra,0xfffff
    80002ce4:	9f8080e7          	jalr	-1544(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80002ce8:	00813083          	ld	ra,8(sp)
    80002cec:	00013403          	ld	s0,0(sp)
    80002cf0:	01010113          	addi	sp,sp,16
    80002cf4:	00008067          	ret

0000000080002cf8 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80002cf8:	fe010113          	addi	sp,sp,-32
    80002cfc:	00113c23          	sd	ra,24(sp)
    80002d00:	00813823          	sd	s0,16(sp)
    80002d04:	00913423          	sd	s1,8(sp)
    80002d08:	02010413          	addi	s0,sp,32
    80002d0c:	00050493          	mv	s1,a0
    80002d10:	00004797          	auipc	a5,0x4
    80002d14:	aa078793          	addi	a5,a5,-1376 # 800067b0 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80002d18:	00f53023          	sd	a5,0(a0)
    80002d1c:	fffff097          	auipc	ra,0xfffff
    80002d20:	9bc080e7          	jalr	-1604(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80002d24:	00048513          	mv	a0,s1
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	a40080e7          	jalr	-1472(ra) # 80001768 <_ZdlPv>
    80002d30:	01813083          	ld	ra,24(sp)
    80002d34:	01013403          	ld	s0,16(sp)
    80002d38:	00813483          	ld	s1,8(sp)
    80002d3c:	02010113          	addi	sp,sp,32
    80002d40:	00008067          	ret

0000000080002d44 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80002d44:	ff010113          	addi	sp,sp,-16
    80002d48:	00113423          	sd	ra,8(sp)
    80002d4c:	00813023          	sd	s0,0(sp)
    80002d50:	01010413          	addi	s0,sp,16
    80002d54:	00004797          	auipc	a5,0x4
    80002d58:	a8478793          	addi	a5,a5,-1404 # 800067d8 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80002d5c:	00f53023          	sd	a5,0(a0)
    80002d60:	fffff097          	auipc	ra,0xfffff
    80002d64:	978080e7          	jalr	-1672(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80002d68:	00813083          	ld	ra,8(sp)
    80002d6c:	00013403          	ld	s0,0(sp)
    80002d70:	01010113          	addi	sp,sp,16
    80002d74:	00008067          	ret

0000000080002d78 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80002d78:	fe010113          	addi	sp,sp,-32
    80002d7c:	00113c23          	sd	ra,24(sp)
    80002d80:	00813823          	sd	s0,16(sp)
    80002d84:	00913423          	sd	s1,8(sp)
    80002d88:	02010413          	addi	s0,sp,32
    80002d8c:	00050493          	mv	s1,a0
    80002d90:	00004797          	auipc	a5,0x4
    80002d94:	a4878793          	addi	a5,a5,-1464 # 800067d8 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80002d98:	00f53023          	sd	a5,0(a0)
    80002d9c:	fffff097          	auipc	ra,0xfffff
    80002da0:	93c080e7          	jalr	-1732(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80002da4:	00048513          	mv	a0,s1
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	9c0080e7          	jalr	-1600(ra) # 80001768 <_ZdlPv>
    80002db0:	01813083          	ld	ra,24(sp)
    80002db4:	01013403          	ld	s0,16(sp)
    80002db8:	00813483          	ld	s1,8(sp)
    80002dbc:	02010113          	addi	sp,sp,32
    80002dc0:	00008067          	ret

0000000080002dc4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80002dc4:	fe010113          	addi	sp,sp,-32
    80002dc8:	00113c23          	sd	ra,24(sp)
    80002dcc:	00813823          	sd	s0,16(sp)
    80002dd0:	00913423          	sd	s1,8(sp)
    80002dd4:	02010413          	addi	s0,sp,32
    80002dd8:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80002ddc:	ffffe097          	auipc	ra,0xffffe
    80002de0:	528080e7          	jalr	1320(ra) # 80001304 <_Z4getcv>
    80002de4:	0005059b          	sext.w	a1,a0
    80002de8:	01b00793          	li	a5,27
    80002dec:	00f58c63          	beq	a1,a5,80002e04 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80002df0:	0104b783          	ld	a5,16(s1)
    80002df4:	0087b503          	ld	a0,8(a5)
    80002df8:	fffff097          	auipc	ra,0xfffff
    80002dfc:	f24080e7          	jalr	-220(ra) # 80001d1c <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80002e00:	fddff06f          	j	80002ddc <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80002e04:	00100793          	li	a5,1
    80002e08:	00004717          	auipc	a4,0x4
    80002e0c:	b4f72623          	sw	a5,-1204(a4) # 80006954 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80002e10:	0104b783          	ld	a5,16(s1)
    80002e14:	02100593          	li	a1,33
    80002e18:	0087b503          	ld	a0,8(a5)
    80002e1c:	fffff097          	auipc	ra,0xfffff
    80002e20:	f00080e7          	jalr	-256(ra) # 80001d1c <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80002e24:	0104b783          	ld	a5,16(s1)
    80002e28:	0107b503          	ld	a0,16(a5)
    80002e2c:	fffff097          	auipc	ra,0xfffff
    80002e30:	a48080e7          	jalr	-1464(ra) # 80001874 <_ZN9Semaphore6signalEv>
        }
    80002e34:	01813083          	ld	ra,24(sp)
    80002e38:	01013403          	ld	s0,16(sp)
    80002e3c:	00813483          	ld	s1,8(sp)
    80002e40:	02010113          	addi	sp,sp,32
    80002e44:	00008067          	ret

0000000080002e48 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80002e48:	fe010113          	addi	sp,sp,-32
    80002e4c:	00113c23          	sd	ra,24(sp)
    80002e50:	00813823          	sd	s0,16(sp)
    80002e54:	00913423          	sd	s1,8(sp)
    80002e58:	01213023          	sd	s2,0(sp)
    80002e5c:	02010413          	addi	s0,sp,32
    80002e60:	00050493          	mv	s1,a0
            int i = 0;
    80002e64:	00000913          	li	s2,0
            while (!threadEnd) {
    80002e68:	00004797          	auipc	a5,0x4
    80002e6c:	aec7a783          	lw	a5,-1300(a5) # 80006954 <_ZN19ConsumerProducerCPP9threadEndE>
    80002e70:	04079263          	bnez	a5,80002eb4 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80002e74:	0104b783          	ld	a5,16(s1)
    80002e78:	0007a583          	lw	a1,0(a5)
    80002e7c:	0305859b          	addiw	a1,a1,48
    80002e80:	0087b503          	ld	a0,8(a5)
    80002e84:	fffff097          	auipc	ra,0xfffff
    80002e88:	e98080e7          	jalr	-360(ra) # 80001d1c <_ZN9BufferCPP3putEi>
                i++;
    80002e8c:	0019071b          	addiw	a4,s2,1
    80002e90:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80002e94:	0104b783          	ld	a5,16(s1)
    80002e98:	0007a783          	lw	a5,0(a5)
    80002e9c:	00e787bb          	addw	a5,a5,a4
    80002ea0:	00500513          	li	a0,5
    80002ea4:	02a7e53b          	remw	a0,a5,a0
    80002ea8:	fffff097          	auipc	ra,0xfffff
    80002eac:	aac080e7          	jalr	-1364(ra) # 80001954 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80002eb0:	fb9ff06f          	j	80002e68 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80002eb4:	0104b783          	ld	a5,16(s1)
    80002eb8:	0107b503          	ld	a0,16(a5)
    80002ebc:	fffff097          	auipc	ra,0xfffff
    80002ec0:	9b8080e7          	jalr	-1608(ra) # 80001874 <_ZN9Semaphore6signalEv>
        }
    80002ec4:	01813083          	ld	ra,24(sp)
    80002ec8:	01013403          	ld	s0,16(sp)
    80002ecc:	00813483          	ld	s1,8(sp)
    80002ed0:	00013903          	ld	s2,0(sp)
    80002ed4:	02010113          	addi	sp,sp,32
    80002ed8:	00008067          	ret

0000000080002edc <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80002edc:	fe010113          	addi	sp,sp,-32
    80002ee0:	00113c23          	sd	ra,24(sp)
    80002ee4:	00813823          	sd	s0,16(sp)
    80002ee8:	00913423          	sd	s1,8(sp)
    80002eec:	01213023          	sd	s2,0(sp)
    80002ef0:	02010413          	addi	s0,sp,32
    80002ef4:	00050493          	mv	s1,a0
    80002ef8:	00058913          	mv	s2,a1
    80002efc:	0015879b          	addiw	a5,a1,1
    80002f00:	0007851b          	sext.w	a0,a5
    80002f04:	00f4a023          	sw	a5,0(s1)
    80002f08:	0004a823          	sw	zero,16(s1)
    80002f0c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80002f10:	00251513          	slli	a0,a0,0x2
    80002f14:	ffffe097          	auipc	ra,0xffffe
    80002f18:	10c080e7          	jalr	268(ra) # 80001020 <_Z9mem_allocm>
    80002f1c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80002f20:	00000593          	li	a1,0
    80002f24:	02048513          	addi	a0,s1,32
    80002f28:	ffffe097          	auipc	ra,0xffffe
    80002f2c:	2f4080e7          	jalr	756(ra) # 8000121c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80002f30:	00090593          	mv	a1,s2
    80002f34:	01848513          	addi	a0,s1,24
    80002f38:	ffffe097          	auipc	ra,0xffffe
    80002f3c:	2e4080e7          	jalr	740(ra) # 8000121c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80002f40:	00100593          	li	a1,1
    80002f44:	02848513          	addi	a0,s1,40
    80002f48:	ffffe097          	auipc	ra,0xffffe
    80002f4c:	2d4080e7          	jalr	724(ra) # 8000121c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80002f50:	00100593          	li	a1,1
    80002f54:	03048513          	addi	a0,s1,48
    80002f58:	ffffe097          	auipc	ra,0xffffe
    80002f5c:	2c4080e7          	jalr	708(ra) # 8000121c <_Z8sem_openPP10_semaphorej>
}
    80002f60:	01813083          	ld	ra,24(sp)
    80002f64:	01013403          	ld	s0,16(sp)
    80002f68:	00813483          	ld	s1,8(sp)
    80002f6c:	00013903          	ld	s2,0(sp)
    80002f70:	02010113          	addi	sp,sp,32
    80002f74:	00008067          	ret

0000000080002f78 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80002f78:	fe010113          	addi	sp,sp,-32
    80002f7c:	00113c23          	sd	ra,24(sp)
    80002f80:	00813823          	sd	s0,16(sp)
    80002f84:	00913423          	sd	s1,8(sp)
    80002f88:	01213023          	sd	s2,0(sp)
    80002f8c:	02010413          	addi	s0,sp,32
    80002f90:	00050493          	mv	s1,a0
    80002f94:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80002f98:	01853503          	ld	a0,24(a0)
    80002f9c:	ffffe097          	auipc	ra,0xffffe
    80002fa0:	2e4080e7          	jalr	740(ra) # 80001280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80002fa4:	0304b503          	ld	a0,48(s1)
    80002fa8:	ffffe097          	auipc	ra,0xffffe
    80002fac:	2d8080e7          	jalr	728(ra) # 80001280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80002fb0:	0084b783          	ld	a5,8(s1)
    80002fb4:	0144a703          	lw	a4,20(s1)
    80002fb8:	00271713          	slli	a4,a4,0x2
    80002fbc:	00e787b3          	add	a5,a5,a4
    80002fc0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80002fc4:	0144a783          	lw	a5,20(s1)
    80002fc8:	0017879b          	addiw	a5,a5,1
    80002fcc:	0004a703          	lw	a4,0(s1)
    80002fd0:	02e7e7bb          	remw	a5,a5,a4
    80002fd4:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80002fd8:	0304b503          	ld	a0,48(s1)
    80002fdc:	ffffe097          	auipc	ra,0xffffe
    80002fe0:	2d0080e7          	jalr	720(ra) # 800012ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80002fe4:	0204b503          	ld	a0,32(s1)
    80002fe8:	ffffe097          	auipc	ra,0xffffe
    80002fec:	2c4080e7          	jalr	708(ra) # 800012ac <_Z10sem_signalP10_semaphore>

}
    80002ff0:	01813083          	ld	ra,24(sp)
    80002ff4:	01013403          	ld	s0,16(sp)
    80002ff8:	00813483          	ld	s1,8(sp)
    80002ffc:	00013903          	ld	s2,0(sp)
    80003000:	02010113          	addi	sp,sp,32
    80003004:	00008067          	ret

0000000080003008 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003008:	fe010113          	addi	sp,sp,-32
    8000300c:	00113c23          	sd	ra,24(sp)
    80003010:	00813823          	sd	s0,16(sp)
    80003014:	00913423          	sd	s1,8(sp)
    80003018:	01213023          	sd	s2,0(sp)
    8000301c:	02010413          	addi	s0,sp,32
    80003020:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003024:	02053503          	ld	a0,32(a0)
    80003028:	ffffe097          	auipc	ra,0xffffe
    8000302c:	258080e7          	jalr	600(ra) # 80001280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80003030:	0284b503          	ld	a0,40(s1)
    80003034:	ffffe097          	auipc	ra,0xffffe
    80003038:	24c080e7          	jalr	588(ra) # 80001280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000303c:	0084b703          	ld	a4,8(s1)
    80003040:	0104a783          	lw	a5,16(s1)
    80003044:	00279693          	slli	a3,a5,0x2
    80003048:	00d70733          	add	a4,a4,a3
    8000304c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80003050:	0017879b          	addiw	a5,a5,1
    80003054:	0004a703          	lw	a4,0(s1)
    80003058:	02e7e7bb          	remw	a5,a5,a4
    8000305c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80003060:	0284b503          	ld	a0,40(s1)
    80003064:	ffffe097          	auipc	ra,0xffffe
    80003068:	248080e7          	jalr	584(ra) # 800012ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    8000306c:	0184b503          	ld	a0,24(s1)
    80003070:	ffffe097          	auipc	ra,0xffffe
    80003074:	23c080e7          	jalr	572(ra) # 800012ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80003078:	00090513          	mv	a0,s2
    8000307c:	01813083          	ld	ra,24(sp)
    80003080:	01013403          	ld	s0,16(sp)
    80003084:	00813483          	ld	s1,8(sp)
    80003088:	00013903          	ld	s2,0(sp)
    8000308c:	02010113          	addi	sp,sp,32
    80003090:	00008067          	ret

0000000080003094 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003094:	fe010113          	addi	sp,sp,-32
    80003098:	00113c23          	sd	ra,24(sp)
    8000309c:	00813823          	sd	s0,16(sp)
    800030a0:	00913423          	sd	s1,8(sp)
    800030a4:	01213023          	sd	s2,0(sp)
    800030a8:	02010413          	addi	s0,sp,32
    800030ac:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800030b0:	02853503          	ld	a0,40(a0)
    800030b4:	ffffe097          	auipc	ra,0xffffe
    800030b8:	1cc080e7          	jalr	460(ra) # 80001280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800030bc:	0304b503          	ld	a0,48(s1)
    800030c0:	ffffe097          	auipc	ra,0xffffe
    800030c4:	1c0080e7          	jalr	448(ra) # 80001280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    800030c8:	0144a783          	lw	a5,20(s1)
    800030cc:	0104a903          	lw	s2,16(s1)
    800030d0:	0327ce63          	blt	a5,s2,8000310c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800030d4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800030d8:	0304b503          	ld	a0,48(s1)
    800030dc:	ffffe097          	auipc	ra,0xffffe
    800030e0:	1d0080e7          	jalr	464(ra) # 800012ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    800030e4:	0284b503          	ld	a0,40(s1)
    800030e8:	ffffe097          	auipc	ra,0xffffe
    800030ec:	1c4080e7          	jalr	452(ra) # 800012ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    800030f0:	00090513          	mv	a0,s2
    800030f4:	01813083          	ld	ra,24(sp)
    800030f8:	01013403          	ld	s0,16(sp)
    800030fc:	00813483          	ld	s1,8(sp)
    80003100:	00013903          	ld	s2,0(sp)
    80003104:	02010113          	addi	sp,sp,32
    80003108:	00008067          	ret
        ret = cap - head + tail;
    8000310c:	0004a703          	lw	a4,0(s1)
    80003110:	4127093b          	subw	s2,a4,s2
    80003114:	00f9093b          	addw	s2,s2,a5
    80003118:	fc1ff06f          	j	800030d8 <_ZN6Buffer6getCntEv+0x44>

000000008000311c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000311c:	fe010113          	addi	sp,sp,-32
    80003120:	00113c23          	sd	ra,24(sp)
    80003124:	00813823          	sd	s0,16(sp)
    80003128:	00913423          	sd	s1,8(sp)
    8000312c:	02010413          	addi	s0,sp,32
    80003130:	00050493          	mv	s1,a0
    putc('\n');
    80003134:	00a00513          	li	a0,10
    80003138:	ffffe097          	auipc	ra,0xffffe
    8000313c:	1f4080e7          	jalr	500(ra) # 8000132c <_Z4putcc>
    printString("Buffer deleted!\n");
    80003140:	00003517          	auipc	a0,0x3
    80003144:	ee050513          	addi	a0,a0,-288 # 80006020 <CONSOLE_STATUS+0x10>
    80003148:	ffffe097          	auipc	ra,0xffffe
    8000314c:	280080e7          	jalr	640(ra) # 800013c8 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003150:	00048513          	mv	a0,s1
    80003154:	00000097          	auipc	ra,0x0
    80003158:	f40080e7          	jalr	-192(ra) # 80003094 <_ZN6Buffer6getCntEv>
    8000315c:	02a05c63          	blez	a0,80003194 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003160:	0084b783          	ld	a5,8(s1)
    80003164:	0104a703          	lw	a4,16(s1)
    80003168:	00271713          	slli	a4,a4,0x2
    8000316c:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80003170:	0007c503          	lbu	a0,0(a5)
    80003174:	ffffe097          	auipc	ra,0xffffe
    80003178:	1b8080e7          	jalr	440(ra) # 8000132c <_Z4putcc>
        head = (head + 1) % cap;
    8000317c:	0104a783          	lw	a5,16(s1)
    80003180:	0017879b          	addiw	a5,a5,1
    80003184:	0004a703          	lw	a4,0(s1)
    80003188:	02e7e7bb          	remw	a5,a5,a4
    8000318c:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003190:	fc1ff06f          	j	80003150 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80003194:	02100513          	li	a0,33
    80003198:	ffffe097          	auipc	ra,0xffffe
    8000319c:	194080e7          	jalr	404(ra) # 8000132c <_Z4putcc>
    putc('\n');
    800031a0:	00a00513          	li	a0,10
    800031a4:	ffffe097          	auipc	ra,0xffffe
    800031a8:	188080e7          	jalr	392(ra) # 8000132c <_Z4putcc>
    mem_free(buffer);
    800031ac:	0084b503          	ld	a0,8(s1)
    800031b0:	ffffe097          	auipc	ra,0xffffe
    800031b4:	ea0080e7          	jalr	-352(ra) # 80001050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800031b8:	0204b503          	ld	a0,32(s1)
    800031bc:	ffffe097          	auipc	ra,0xffffe
    800031c0:	098080e7          	jalr	152(ra) # 80001254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    800031c4:	0184b503          	ld	a0,24(s1)
    800031c8:	ffffe097          	auipc	ra,0xffffe
    800031cc:	08c080e7          	jalr	140(ra) # 80001254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    800031d0:	0304b503          	ld	a0,48(s1)
    800031d4:	ffffe097          	auipc	ra,0xffffe
    800031d8:	080080e7          	jalr	128(ra) # 80001254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    800031dc:	0284b503          	ld	a0,40(s1)
    800031e0:	ffffe097          	auipc	ra,0xffffe
    800031e4:	074080e7          	jalr	116(ra) # 80001254 <_Z9sem_closeP10_semaphore>
}
    800031e8:	01813083          	ld	ra,24(sp)
    800031ec:	01013403          	ld	s0,16(sp)
    800031f0:	00813483          	ld	s1,8(sp)
    800031f4:	02010113          	addi	sp,sp,32
    800031f8:	00008067          	ret

00000000800031fc <start>:
    800031fc:	ff010113          	addi	sp,sp,-16
    80003200:	00813423          	sd	s0,8(sp)
    80003204:	01010413          	addi	s0,sp,16
    80003208:	300027f3          	csrr	a5,mstatus
    8000320c:	ffffe737          	lui	a4,0xffffe
    80003210:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffefaff>
    80003214:	00e7f7b3          	and	a5,a5,a4
    80003218:	00001737          	lui	a4,0x1
    8000321c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003220:	00e7e7b3          	or	a5,a5,a4
    80003224:	30079073          	csrw	mstatus,a5
    80003228:	00000797          	auipc	a5,0x0
    8000322c:	16078793          	addi	a5,a5,352 # 80003388 <system_main>
    80003230:	34179073          	csrw	mepc,a5
    80003234:	00000793          	li	a5,0
    80003238:	18079073          	csrw	satp,a5
    8000323c:	000107b7          	lui	a5,0x10
    80003240:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003244:	30279073          	csrw	medeleg,a5
    80003248:	30379073          	csrw	mideleg,a5
    8000324c:	104027f3          	csrr	a5,sie
    80003250:	2227e793          	ori	a5,a5,546
    80003254:	10479073          	csrw	sie,a5
    80003258:	fff00793          	li	a5,-1
    8000325c:	00a7d793          	srli	a5,a5,0xa
    80003260:	3b079073          	csrw	pmpaddr0,a5
    80003264:	00f00793          	li	a5,15
    80003268:	3a079073          	csrw	pmpcfg0,a5
    8000326c:	f14027f3          	csrr	a5,mhartid
    80003270:	0200c737          	lui	a4,0x200c
    80003274:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003278:	0007869b          	sext.w	a3,a5
    8000327c:	00269713          	slli	a4,a3,0x2
    80003280:	000f4637          	lui	a2,0xf4
    80003284:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003288:	00d70733          	add	a4,a4,a3
    8000328c:	0037979b          	slliw	a5,a5,0x3
    80003290:	020046b7          	lui	a3,0x2004
    80003294:	00d787b3          	add	a5,a5,a3
    80003298:	00c585b3          	add	a1,a1,a2
    8000329c:	00371693          	slli	a3,a4,0x3
    800032a0:	00003717          	auipc	a4,0x3
    800032a4:	6d070713          	addi	a4,a4,1744 # 80006970 <timer_scratch>
    800032a8:	00b7b023          	sd	a1,0(a5)
    800032ac:	00d70733          	add	a4,a4,a3
    800032b0:	00f73c23          	sd	a5,24(a4)
    800032b4:	02c73023          	sd	a2,32(a4)
    800032b8:	34071073          	csrw	mscratch,a4
    800032bc:	00000797          	auipc	a5,0x0
    800032c0:	6e478793          	addi	a5,a5,1764 # 800039a0 <timervec>
    800032c4:	30579073          	csrw	mtvec,a5
    800032c8:	300027f3          	csrr	a5,mstatus
    800032cc:	0087e793          	ori	a5,a5,8
    800032d0:	30079073          	csrw	mstatus,a5
    800032d4:	304027f3          	csrr	a5,mie
    800032d8:	0807e793          	ori	a5,a5,128
    800032dc:	30479073          	csrw	mie,a5
    800032e0:	f14027f3          	csrr	a5,mhartid
    800032e4:	0007879b          	sext.w	a5,a5
    800032e8:	00078213          	mv	tp,a5
    800032ec:	30200073          	mret
    800032f0:	00813403          	ld	s0,8(sp)
    800032f4:	01010113          	addi	sp,sp,16
    800032f8:	00008067          	ret

00000000800032fc <timerinit>:
    800032fc:	ff010113          	addi	sp,sp,-16
    80003300:	00813423          	sd	s0,8(sp)
    80003304:	01010413          	addi	s0,sp,16
    80003308:	f14027f3          	csrr	a5,mhartid
    8000330c:	0200c737          	lui	a4,0x200c
    80003310:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003314:	0007869b          	sext.w	a3,a5
    80003318:	00269713          	slli	a4,a3,0x2
    8000331c:	000f4637          	lui	a2,0xf4
    80003320:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003324:	00d70733          	add	a4,a4,a3
    80003328:	0037979b          	slliw	a5,a5,0x3
    8000332c:	020046b7          	lui	a3,0x2004
    80003330:	00d787b3          	add	a5,a5,a3
    80003334:	00c585b3          	add	a1,a1,a2
    80003338:	00371693          	slli	a3,a4,0x3
    8000333c:	00003717          	auipc	a4,0x3
    80003340:	63470713          	addi	a4,a4,1588 # 80006970 <timer_scratch>
    80003344:	00b7b023          	sd	a1,0(a5)
    80003348:	00d70733          	add	a4,a4,a3
    8000334c:	00f73c23          	sd	a5,24(a4)
    80003350:	02c73023          	sd	a2,32(a4)
    80003354:	34071073          	csrw	mscratch,a4
    80003358:	00000797          	auipc	a5,0x0
    8000335c:	64878793          	addi	a5,a5,1608 # 800039a0 <timervec>
    80003360:	30579073          	csrw	mtvec,a5
    80003364:	300027f3          	csrr	a5,mstatus
    80003368:	0087e793          	ori	a5,a5,8
    8000336c:	30079073          	csrw	mstatus,a5
    80003370:	304027f3          	csrr	a5,mie
    80003374:	0807e793          	ori	a5,a5,128
    80003378:	30479073          	csrw	mie,a5
    8000337c:	00813403          	ld	s0,8(sp)
    80003380:	01010113          	addi	sp,sp,16
    80003384:	00008067          	ret

0000000080003388 <system_main>:
    80003388:	fe010113          	addi	sp,sp,-32
    8000338c:	00813823          	sd	s0,16(sp)
    80003390:	00913423          	sd	s1,8(sp)
    80003394:	00113c23          	sd	ra,24(sp)
    80003398:	02010413          	addi	s0,sp,32
    8000339c:	00000097          	auipc	ra,0x0
    800033a0:	0c4080e7          	jalr	196(ra) # 80003460 <cpuid>
    800033a4:	00003497          	auipc	s1,0x3
    800033a8:	56c48493          	addi	s1,s1,1388 # 80006910 <started>
    800033ac:	02050263          	beqz	a0,800033d0 <system_main+0x48>
    800033b0:	0004a783          	lw	a5,0(s1)
    800033b4:	0007879b          	sext.w	a5,a5
    800033b8:	fe078ce3          	beqz	a5,800033b0 <system_main+0x28>
    800033bc:	0ff0000f          	fence
    800033c0:	00003517          	auipc	a0,0x3
    800033c4:	e9850513          	addi	a0,a0,-360 # 80006258 <CONSOLE_STATUS+0x248>
    800033c8:	00001097          	auipc	ra,0x1
    800033cc:	a74080e7          	jalr	-1420(ra) # 80003e3c <panic>
    800033d0:	00001097          	auipc	ra,0x1
    800033d4:	9c8080e7          	jalr	-1592(ra) # 80003d98 <consoleinit>
    800033d8:	00001097          	auipc	ra,0x1
    800033dc:	154080e7          	jalr	340(ra) # 8000452c <printfinit>
    800033e0:	00003517          	auipc	a0,0x3
    800033e4:	d9850513          	addi	a0,a0,-616 # 80006178 <CONSOLE_STATUS+0x168>
    800033e8:	00001097          	auipc	ra,0x1
    800033ec:	ab0080e7          	jalr	-1360(ra) # 80003e98 <__printf>
    800033f0:	00003517          	auipc	a0,0x3
    800033f4:	e3850513          	addi	a0,a0,-456 # 80006228 <CONSOLE_STATUS+0x218>
    800033f8:	00001097          	auipc	ra,0x1
    800033fc:	aa0080e7          	jalr	-1376(ra) # 80003e98 <__printf>
    80003400:	00003517          	auipc	a0,0x3
    80003404:	d7850513          	addi	a0,a0,-648 # 80006178 <CONSOLE_STATUS+0x168>
    80003408:	00001097          	auipc	ra,0x1
    8000340c:	a90080e7          	jalr	-1392(ra) # 80003e98 <__printf>
    80003410:	00001097          	auipc	ra,0x1
    80003414:	4a8080e7          	jalr	1192(ra) # 800048b8 <kinit>
    80003418:	00000097          	auipc	ra,0x0
    8000341c:	148080e7          	jalr	328(ra) # 80003560 <trapinit>
    80003420:	00000097          	auipc	ra,0x0
    80003424:	16c080e7          	jalr	364(ra) # 8000358c <trapinithart>
    80003428:	00000097          	auipc	ra,0x0
    8000342c:	5b8080e7          	jalr	1464(ra) # 800039e0 <plicinit>
    80003430:	00000097          	auipc	ra,0x0
    80003434:	5d8080e7          	jalr	1496(ra) # 80003a08 <plicinithart>
    80003438:	00000097          	auipc	ra,0x0
    8000343c:	078080e7          	jalr	120(ra) # 800034b0 <userinit>
    80003440:	0ff0000f          	fence
    80003444:	00100793          	li	a5,1
    80003448:	00003517          	auipc	a0,0x3
    8000344c:	df850513          	addi	a0,a0,-520 # 80006240 <CONSOLE_STATUS+0x230>
    80003450:	00f4a023          	sw	a5,0(s1)
    80003454:	00001097          	auipc	ra,0x1
    80003458:	a44080e7          	jalr	-1468(ra) # 80003e98 <__printf>
    8000345c:	0000006f          	j	8000345c <system_main+0xd4>

0000000080003460 <cpuid>:
    80003460:	ff010113          	addi	sp,sp,-16
    80003464:	00813423          	sd	s0,8(sp)
    80003468:	01010413          	addi	s0,sp,16
    8000346c:	00020513          	mv	a0,tp
    80003470:	00813403          	ld	s0,8(sp)
    80003474:	0005051b          	sext.w	a0,a0
    80003478:	01010113          	addi	sp,sp,16
    8000347c:	00008067          	ret

0000000080003480 <mycpu>:
    80003480:	ff010113          	addi	sp,sp,-16
    80003484:	00813423          	sd	s0,8(sp)
    80003488:	01010413          	addi	s0,sp,16
    8000348c:	00020793          	mv	a5,tp
    80003490:	00813403          	ld	s0,8(sp)
    80003494:	0007879b          	sext.w	a5,a5
    80003498:	00779793          	slli	a5,a5,0x7
    8000349c:	00004517          	auipc	a0,0x4
    800034a0:	50450513          	addi	a0,a0,1284 # 800079a0 <cpus>
    800034a4:	00f50533          	add	a0,a0,a5
    800034a8:	01010113          	addi	sp,sp,16
    800034ac:	00008067          	ret

00000000800034b0 <userinit>:
    800034b0:	ff010113          	addi	sp,sp,-16
    800034b4:	00813423          	sd	s0,8(sp)
    800034b8:	01010413          	addi	s0,sp,16
    800034bc:	00813403          	ld	s0,8(sp)
    800034c0:	01010113          	addi	sp,sp,16
    800034c4:	00007317          	auipc	t1,0x7
    800034c8:	5bc30067          	jr	1468(t1) # 8000aa80 <main>

00000000800034cc <either_copyout>:
    800034cc:	ff010113          	addi	sp,sp,-16
    800034d0:	00813023          	sd	s0,0(sp)
    800034d4:	00113423          	sd	ra,8(sp)
    800034d8:	01010413          	addi	s0,sp,16
    800034dc:	02051663          	bnez	a0,80003508 <either_copyout+0x3c>
    800034e0:	00058513          	mv	a0,a1
    800034e4:	00060593          	mv	a1,a2
    800034e8:	0006861b          	sext.w	a2,a3
    800034ec:	00002097          	auipc	ra,0x2
    800034f0:	c58080e7          	jalr	-936(ra) # 80005144 <__memmove>
    800034f4:	00813083          	ld	ra,8(sp)
    800034f8:	00013403          	ld	s0,0(sp)
    800034fc:	00000513          	li	a0,0
    80003500:	01010113          	addi	sp,sp,16
    80003504:	00008067          	ret
    80003508:	00003517          	auipc	a0,0x3
    8000350c:	d7850513          	addi	a0,a0,-648 # 80006280 <CONSOLE_STATUS+0x270>
    80003510:	00001097          	auipc	ra,0x1
    80003514:	92c080e7          	jalr	-1748(ra) # 80003e3c <panic>

0000000080003518 <either_copyin>:
    80003518:	ff010113          	addi	sp,sp,-16
    8000351c:	00813023          	sd	s0,0(sp)
    80003520:	00113423          	sd	ra,8(sp)
    80003524:	01010413          	addi	s0,sp,16
    80003528:	02059463          	bnez	a1,80003550 <either_copyin+0x38>
    8000352c:	00060593          	mv	a1,a2
    80003530:	0006861b          	sext.w	a2,a3
    80003534:	00002097          	auipc	ra,0x2
    80003538:	c10080e7          	jalr	-1008(ra) # 80005144 <__memmove>
    8000353c:	00813083          	ld	ra,8(sp)
    80003540:	00013403          	ld	s0,0(sp)
    80003544:	00000513          	li	a0,0
    80003548:	01010113          	addi	sp,sp,16
    8000354c:	00008067          	ret
    80003550:	00003517          	auipc	a0,0x3
    80003554:	d5850513          	addi	a0,a0,-680 # 800062a8 <CONSOLE_STATUS+0x298>
    80003558:	00001097          	auipc	ra,0x1
    8000355c:	8e4080e7          	jalr	-1820(ra) # 80003e3c <panic>

0000000080003560 <trapinit>:
    80003560:	ff010113          	addi	sp,sp,-16
    80003564:	00813423          	sd	s0,8(sp)
    80003568:	01010413          	addi	s0,sp,16
    8000356c:	00813403          	ld	s0,8(sp)
    80003570:	00003597          	auipc	a1,0x3
    80003574:	d6058593          	addi	a1,a1,-672 # 800062d0 <CONSOLE_STATUS+0x2c0>
    80003578:	00004517          	auipc	a0,0x4
    8000357c:	4a850513          	addi	a0,a0,1192 # 80007a20 <tickslock>
    80003580:	01010113          	addi	sp,sp,16
    80003584:	00001317          	auipc	t1,0x1
    80003588:	5c430067          	jr	1476(t1) # 80004b48 <initlock>

000000008000358c <trapinithart>:
    8000358c:	ff010113          	addi	sp,sp,-16
    80003590:	00813423          	sd	s0,8(sp)
    80003594:	01010413          	addi	s0,sp,16
    80003598:	00000797          	auipc	a5,0x0
    8000359c:	2f878793          	addi	a5,a5,760 # 80003890 <kernelvec>
    800035a0:	10579073          	csrw	stvec,a5
    800035a4:	00813403          	ld	s0,8(sp)
    800035a8:	01010113          	addi	sp,sp,16
    800035ac:	00008067          	ret

00000000800035b0 <usertrap>:
    800035b0:	ff010113          	addi	sp,sp,-16
    800035b4:	00813423          	sd	s0,8(sp)
    800035b8:	01010413          	addi	s0,sp,16
    800035bc:	00813403          	ld	s0,8(sp)
    800035c0:	01010113          	addi	sp,sp,16
    800035c4:	00008067          	ret

00000000800035c8 <usertrapret>:
    800035c8:	ff010113          	addi	sp,sp,-16
    800035cc:	00813423          	sd	s0,8(sp)
    800035d0:	01010413          	addi	s0,sp,16
    800035d4:	00813403          	ld	s0,8(sp)
    800035d8:	01010113          	addi	sp,sp,16
    800035dc:	00008067          	ret

00000000800035e0 <kerneltrap>:
    800035e0:	fe010113          	addi	sp,sp,-32
    800035e4:	00813823          	sd	s0,16(sp)
    800035e8:	00113c23          	sd	ra,24(sp)
    800035ec:	00913423          	sd	s1,8(sp)
    800035f0:	02010413          	addi	s0,sp,32
    800035f4:	142025f3          	csrr	a1,scause
    800035f8:	100027f3          	csrr	a5,sstatus
    800035fc:	0027f793          	andi	a5,a5,2
    80003600:	10079c63          	bnez	a5,80003718 <kerneltrap+0x138>
    80003604:	142027f3          	csrr	a5,scause
    80003608:	0207ce63          	bltz	a5,80003644 <kerneltrap+0x64>
    8000360c:	00003517          	auipc	a0,0x3
    80003610:	d0c50513          	addi	a0,a0,-756 # 80006318 <CONSOLE_STATUS+0x308>
    80003614:	00001097          	auipc	ra,0x1
    80003618:	884080e7          	jalr	-1916(ra) # 80003e98 <__printf>
    8000361c:	141025f3          	csrr	a1,sepc
    80003620:	14302673          	csrr	a2,stval
    80003624:	00003517          	auipc	a0,0x3
    80003628:	d0450513          	addi	a0,a0,-764 # 80006328 <CONSOLE_STATUS+0x318>
    8000362c:	00001097          	auipc	ra,0x1
    80003630:	86c080e7          	jalr	-1940(ra) # 80003e98 <__printf>
    80003634:	00003517          	auipc	a0,0x3
    80003638:	d0c50513          	addi	a0,a0,-756 # 80006340 <CONSOLE_STATUS+0x330>
    8000363c:	00001097          	auipc	ra,0x1
    80003640:	800080e7          	jalr	-2048(ra) # 80003e3c <panic>
    80003644:	0ff7f713          	andi	a4,a5,255
    80003648:	00900693          	li	a3,9
    8000364c:	04d70063          	beq	a4,a3,8000368c <kerneltrap+0xac>
    80003650:	fff00713          	li	a4,-1
    80003654:	03f71713          	slli	a4,a4,0x3f
    80003658:	00170713          	addi	a4,a4,1
    8000365c:	fae798e3          	bne	a5,a4,8000360c <kerneltrap+0x2c>
    80003660:	00000097          	auipc	ra,0x0
    80003664:	e00080e7          	jalr	-512(ra) # 80003460 <cpuid>
    80003668:	06050663          	beqz	a0,800036d4 <kerneltrap+0xf4>
    8000366c:	144027f3          	csrr	a5,sip
    80003670:	ffd7f793          	andi	a5,a5,-3
    80003674:	14479073          	csrw	sip,a5
    80003678:	01813083          	ld	ra,24(sp)
    8000367c:	01013403          	ld	s0,16(sp)
    80003680:	00813483          	ld	s1,8(sp)
    80003684:	02010113          	addi	sp,sp,32
    80003688:	00008067          	ret
    8000368c:	00000097          	auipc	ra,0x0
    80003690:	3c8080e7          	jalr	968(ra) # 80003a54 <plic_claim>
    80003694:	00a00793          	li	a5,10
    80003698:	00050493          	mv	s1,a0
    8000369c:	06f50863          	beq	a0,a5,8000370c <kerneltrap+0x12c>
    800036a0:	fc050ce3          	beqz	a0,80003678 <kerneltrap+0x98>
    800036a4:	00050593          	mv	a1,a0
    800036a8:	00003517          	auipc	a0,0x3
    800036ac:	c5050513          	addi	a0,a0,-944 # 800062f8 <CONSOLE_STATUS+0x2e8>
    800036b0:	00000097          	auipc	ra,0x0
    800036b4:	7e8080e7          	jalr	2024(ra) # 80003e98 <__printf>
    800036b8:	01013403          	ld	s0,16(sp)
    800036bc:	01813083          	ld	ra,24(sp)
    800036c0:	00048513          	mv	a0,s1
    800036c4:	00813483          	ld	s1,8(sp)
    800036c8:	02010113          	addi	sp,sp,32
    800036cc:	00000317          	auipc	t1,0x0
    800036d0:	3c030067          	jr	960(t1) # 80003a8c <plic_complete>
    800036d4:	00004517          	auipc	a0,0x4
    800036d8:	34c50513          	addi	a0,a0,844 # 80007a20 <tickslock>
    800036dc:	00001097          	auipc	ra,0x1
    800036e0:	490080e7          	jalr	1168(ra) # 80004b6c <acquire>
    800036e4:	00003717          	auipc	a4,0x3
    800036e8:	23070713          	addi	a4,a4,560 # 80006914 <ticks>
    800036ec:	00072783          	lw	a5,0(a4)
    800036f0:	00004517          	auipc	a0,0x4
    800036f4:	33050513          	addi	a0,a0,816 # 80007a20 <tickslock>
    800036f8:	0017879b          	addiw	a5,a5,1
    800036fc:	00f72023          	sw	a5,0(a4)
    80003700:	00001097          	auipc	ra,0x1
    80003704:	538080e7          	jalr	1336(ra) # 80004c38 <release>
    80003708:	f65ff06f          	j	8000366c <kerneltrap+0x8c>
    8000370c:	00001097          	auipc	ra,0x1
    80003710:	094080e7          	jalr	148(ra) # 800047a0 <uartintr>
    80003714:	fa5ff06f          	j	800036b8 <kerneltrap+0xd8>
    80003718:	00003517          	auipc	a0,0x3
    8000371c:	bc050513          	addi	a0,a0,-1088 # 800062d8 <CONSOLE_STATUS+0x2c8>
    80003720:	00000097          	auipc	ra,0x0
    80003724:	71c080e7          	jalr	1820(ra) # 80003e3c <panic>

0000000080003728 <clockintr>:
    80003728:	fe010113          	addi	sp,sp,-32
    8000372c:	00813823          	sd	s0,16(sp)
    80003730:	00913423          	sd	s1,8(sp)
    80003734:	00113c23          	sd	ra,24(sp)
    80003738:	02010413          	addi	s0,sp,32
    8000373c:	00004497          	auipc	s1,0x4
    80003740:	2e448493          	addi	s1,s1,740 # 80007a20 <tickslock>
    80003744:	00048513          	mv	a0,s1
    80003748:	00001097          	auipc	ra,0x1
    8000374c:	424080e7          	jalr	1060(ra) # 80004b6c <acquire>
    80003750:	00003717          	auipc	a4,0x3
    80003754:	1c470713          	addi	a4,a4,452 # 80006914 <ticks>
    80003758:	00072783          	lw	a5,0(a4)
    8000375c:	01013403          	ld	s0,16(sp)
    80003760:	01813083          	ld	ra,24(sp)
    80003764:	00048513          	mv	a0,s1
    80003768:	0017879b          	addiw	a5,a5,1
    8000376c:	00813483          	ld	s1,8(sp)
    80003770:	00f72023          	sw	a5,0(a4)
    80003774:	02010113          	addi	sp,sp,32
    80003778:	00001317          	auipc	t1,0x1
    8000377c:	4c030067          	jr	1216(t1) # 80004c38 <release>

0000000080003780 <devintr>:
    80003780:	142027f3          	csrr	a5,scause
    80003784:	00000513          	li	a0,0
    80003788:	0007c463          	bltz	a5,80003790 <devintr+0x10>
    8000378c:	00008067          	ret
    80003790:	fe010113          	addi	sp,sp,-32
    80003794:	00813823          	sd	s0,16(sp)
    80003798:	00113c23          	sd	ra,24(sp)
    8000379c:	00913423          	sd	s1,8(sp)
    800037a0:	02010413          	addi	s0,sp,32
    800037a4:	0ff7f713          	andi	a4,a5,255
    800037a8:	00900693          	li	a3,9
    800037ac:	04d70c63          	beq	a4,a3,80003804 <devintr+0x84>
    800037b0:	fff00713          	li	a4,-1
    800037b4:	03f71713          	slli	a4,a4,0x3f
    800037b8:	00170713          	addi	a4,a4,1
    800037bc:	00e78c63          	beq	a5,a4,800037d4 <devintr+0x54>
    800037c0:	01813083          	ld	ra,24(sp)
    800037c4:	01013403          	ld	s0,16(sp)
    800037c8:	00813483          	ld	s1,8(sp)
    800037cc:	02010113          	addi	sp,sp,32
    800037d0:	00008067          	ret
    800037d4:	00000097          	auipc	ra,0x0
    800037d8:	c8c080e7          	jalr	-884(ra) # 80003460 <cpuid>
    800037dc:	06050663          	beqz	a0,80003848 <devintr+0xc8>
    800037e0:	144027f3          	csrr	a5,sip
    800037e4:	ffd7f793          	andi	a5,a5,-3
    800037e8:	14479073          	csrw	sip,a5
    800037ec:	01813083          	ld	ra,24(sp)
    800037f0:	01013403          	ld	s0,16(sp)
    800037f4:	00813483          	ld	s1,8(sp)
    800037f8:	00200513          	li	a0,2
    800037fc:	02010113          	addi	sp,sp,32
    80003800:	00008067          	ret
    80003804:	00000097          	auipc	ra,0x0
    80003808:	250080e7          	jalr	592(ra) # 80003a54 <plic_claim>
    8000380c:	00a00793          	li	a5,10
    80003810:	00050493          	mv	s1,a0
    80003814:	06f50663          	beq	a0,a5,80003880 <devintr+0x100>
    80003818:	00100513          	li	a0,1
    8000381c:	fa0482e3          	beqz	s1,800037c0 <devintr+0x40>
    80003820:	00048593          	mv	a1,s1
    80003824:	00003517          	auipc	a0,0x3
    80003828:	ad450513          	addi	a0,a0,-1324 # 800062f8 <CONSOLE_STATUS+0x2e8>
    8000382c:	00000097          	auipc	ra,0x0
    80003830:	66c080e7          	jalr	1644(ra) # 80003e98 <__printf>
    80003834:	00048513          	mv	a0,s1
    80003838:	00000097          	auipc	ra,0x0
    8000383c:	254080e7          	jalr	596(ra) # 80003a8c <plic_complete>
    80003840:	00100513          	li	a0,1
    80003844:	f7dff06f          	j	800037c0 <devintr+0x40>
    80003848:	00004517          	auipc	a0,0x4
    8000384c:	1d850513          	addi	a0,a0,472 # 80007a20 <tickslock>
    80003850:	00001097          	auipc	ra,0x1
    80003854:	31c080e7          	jalr	796(ra) # 80004b6c <acquire>
    80003858:	00003717          	auipc	a4,0x3
    8000385c:	0bc70713          	addi	a4,a4,188 # 80006914 <ticks>
    80003860:	00072783          	lw	a5,0(a4)
    80003864:	00004517          	auipc	a0,0x4
    80003868:	1bc50513          	addi	a0,a0,444 # 80007a20 <tickslock>
    8000386c:	0017879b          	addiw	a5,a5,1
    80003870:	00f72023          	sw	a5,0(a4)
    80003874:	00001097          	auipc	ra,0x1
    80003878:	3c4080e7          	jalr	964(ra) # 80004c38 <release>
    8000387c:	f65ff06f          	j	800037e0 <devintr+0x60>
    80003880:	00001097          	auipc	ra,0x1
    80003884:	f20080e7          	jalr	-224(ra) # 800047a0 <uartintr>
    80003888:	fadff06f          	j	80003834 <devintr+0xb4>
    8000388c:	0000                	unimp
	...

0000000080003890 <kernelvec>:
    80003890:	f0010113          	addi	sp,sp,-256
    80003894:	00113023          	sd	ra,0(sp)
    80003898:	00213423          	sd	sp,8(sp)
    8000389c:	00313823          	sd	gp,16(sp)
    800038a0:	00413c23          	sd	tp,24(sp)
    800038a4:	02513023          	sd	t0,32(sp)
    800038a8:	02613423          	sd	t1,40(sp)
    800038ac:	02713823          	sd	t2,48(sp)
    800038b0:	02813c23          	sd	s0,56(sp)
    800038b4:	04913023          	sd	s1,64(sp)
    800038b8:	04a13423          	sd	a0,72(sp)
    800038bc:	04b13823          	sd	a1,80(sp)
    800038c0:	04c13c23          	sd	a2,88(sp)
    800038c4:	06d13023          	sd	a3,96(sp)
    800038c8:	06e13423          	sd	a4,104(sp)
    800038cc:	06f13823          	sd	a5,112(sp)
    800038d0:	07013c23          	sd	a6,120(sp)
    800038d4:	09113023          	sd	a7,128(sp)
    800038d8:	09213423          	sd	s2,136(sp)
    800038dc:	09313823          	sd	s3,144(sp)
    800038e0:	09413c23          	sd	s4,152(sp)
    800038e4:	0b513023          	sd	s5,160(sp)
    800038e8:	0b613423          	sd	s6,168(sp)
    800038ec:	0b713823          	sd	s7,176(sp)
    800038f0:	0b813c23          	sd	s8,184(sp)
    800038f4:	0d913023          	sd	s9,192(sp)
    800038f8:	0da13423          	sd	s10,200(sp)
    800038fc:	0db13823          	sd	s11,208(sp)
    80003900:	0dc13c23          	sd	t3,216(sp)
    80003904:	0fd13023          	sd	t4,224(sp)
    80003908:	0fe13423          	sd	t5,232(sp)
    8000390c:	0ff13823          	sd	t6,240(sp)
    80003910:	cd1ff0ef          	jal	ra,800035e0 <kerneltrap>
    80003914:	00013083          	ld	ra,0(sp)
    80003918:	00813103          	ld	sp,8(sp)
    8000391c:	01013183          	ld	gp,16(sp)
    80003920:	02013283          	ld	t0,32(sp)
    80003924:	02813303          	ld	t1,40(sp)
    80003928:	03013383          	ld	t2,48(sp)
    8000392c:	03813403          	ld	s0,56(sp)
    80003930:	04013483          	ld	s1,64(sp)
    80003934:	04813503          	ld	a0,72(sp)
    80003938:	05013583          	ld	a1,80(sp)
    8000393c:	05813603          	ld	a2,88(sp)
    80003940:	06013683          	ld	a3,96(sp)
    80003944:	06813703          	ld	a4,104(sp)
    80003948:	07013783          	ld	a5,112(sp)
    8000394c:	07813803          	ld	a6,120(sp)
    80003950:	08013883          	ld	a7,128(sp)
    80003954:	08813903          	ld	s2,136(sp)
    80003958:	09013983          	ld	s3,144(sp)
    8000395c:	09813a03          	ld	s4,152(sp)
    80003960:	0a013a83          	ld	s5,160(sp)
    80003964:	0a813b03          	ld	s6,168(sp)
    80003968:	0b013b83          	ld	s7,176(sp)
    8000396c:	0b813c03          	ld	s8,184(sp)
    80003970:	0c013c83          	ld	s9,192(sp)
    80003974:	0c813d03          	ld	s10,200(sp)
    80003978:	0d013d83          	ld	s11,208(sp)
    8000397c:	0d813e03          	ld	t3,216(sp)
    80003980:	0e013e83          	ld	t4,224(sp)
    80003984:	0e813f03          	ld	t5,232(sp)
    80003988:	0f013f83          	ld	t6,240(sp)
    8000398c:	10010113          	addi	sp,sp,256
    80003990:	10200073          	sret
    80003994:	00000013          	nop
    80003998:	00000013          	nop
    8000399c:	00000013          	nop

00000000800039a0 <timervec>:
    800039a0:	34051573          	csrrw	a0,mscratch,a0
    800039a4:	00b53023          	sd	a1,0(a0)
    800039a8:	00c53423          	sd	a2,8(a0)
    800039ac:	00d53823          	sd	a3,16(a0)
    800039b0:	01853583          	ld	a1,24(a0)
    800039b4:	02053603          	ld	a2,32(a0)
    800039b8:	0005b683          	ld	a3,0(a1)
    800039bc:	00c686b3          	add	a3,a3,a2
    800039c0:	00d5b023          	sd	a3,0(a1)
    800039c4:	00200593          	li	a1,2
    800039c8:	14459073          	csrw	sip,a1
    800039cc:	01053683          	ld	a3,16(a0)
    800039d0:	00853603          	ld	a2,8(a0)
    800039d4:	00053583          	ld	a1,0(a0)
    800039d8:	34051573          	csrrw	a0,mscratch,a0
    800039dc:	30200073          	mret

00000000800039e0 <plicinit>:
    800039e0:	ff010113          	addi	sp,sp,-16
    800039e4:	00813423          	sd	s0,8(sp)
    800039e8:	01010413          	addi	s0,sp,16
    800039ec:	00813403          	ld	s0,8(sp)
    800039f0:	0c0007b7          	lui	a5,0xc000
    800039f4:	00100713          	li	a4,1
    800039f8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800039fc:	00e7a223          	sw	a4,4(a5)
    80003a00:	01010113          	addi	sp,sp,16
    80003a04:	00008067          	ret

0000000080003a08 <plicinithart>:
    80003a08:	ff010113          	addi	sp,sp,-16
    80003a0c:	00813023          	sd	s0,0(sp)
    80003a10:	00113423          	sd	ra,8(sp)
    80003a14:	01010413          	addi	s0,sp,16
    80003a18:	00000097          	auipc	ra,0x0
    80003a1c:	a48080e7          	jalr	-1464(ra) # 80003460 <cpuid>
    80003a20:	0085171b          	slliw	a4,a0,0x8
    80003a24:	0c0027b7          	lui	a5,0xc002
    80003a28:	00e787b3          	add	a5,a5,a4
    80003a2c:	40200713          	li	a4,1026
    80003a30:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003a34:	00813083          	ld	ra,8(sp)
    80003a38:	00013403          	ld	s0,0(sp)
    80003a3c:	00d5151b          	slliw	a0,a0,0xd
    80003a40:	0c2017b7          	lui	a5,0xc201
    80003a44:	00a78533          	add	a0,a5,a0
    80003a48:	00052023          	sw	zero,0(a0)
    80003a4c:	01010113          	addi	sp,sp,16
    80003a50:	00008067          	ret

0000000080003a54 <plic_claim>:
    80003a54:	ff010113          	addi	sp,sp,-16
    80003a58:	00813023          	sd	s0,0(sp)
    80003a5c:	00113423          	sd	ra,8(sp)
    80003a60:	01010413          	addi	s0,sp,16
    80003a64:	00000097          	auipc	ra,0x0
    80003a68:	9fc080e7          	jalr	-1540(ra) # 80003460 <cpuid>
    80003a6c:	00813083          	ld	ra,8(sp)
    80003a70:	00013403          	ld	s0,0(sp)
    80003a74:	00d5151b          	slliw	a0,a0,0xd
    80003a78:	0c2017b7          	lui	a5,0xc201
    80003a7c:	00a78533          	add	a0,a5,a0
    80003a80:	00452503          	lw	a0,4(a0)
    80003a84:	01010113          	addi	sp,sp,16
    80003a88:	00008067          	ret

0000000080003a8c <plic_complete>:
    80003a8c:	fe010113          	addi	sp,sp,-32
    80003a90:	00813823          	sd	s0,16(sp)
    80003a94:	00913423          	sd	s1,8(sp)
    80003a98:	00113c23          	sd	ra,24(sp)
    80003a9c:	02010413          	addi	s0,sp,32
    80003aa0:	00050493          	mv	s1,a0
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	9bc080e7          	jalr	-1604(ra) # 80003460 <cpuid>
    80003aac:	01813083          	ld	ra,24(sp)
    80003ab0:	01013403          	ld	s0,16(sp)
    80003ab4:	00d5179b          	slliw	a5,a0,0xd
    80003ab8:	0c201737          	lui	a4,0xc201
    80003abc:	00f707b3          	add	a5,a4,a5
    80003ac0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003ac4:	00813483          	ld	s1,8(sp)
    80003ac8:	02010113          	addi	sp,sp,32
    80003acc:	00008067          	ret

0000000080003ad0 <consolewrite>:
    80003ad0:	fb010113          	addi	sp,sp,-80
    80003ad4:	04813023          	sd	s0,64(sp)
    80003ad8:	04113423          	sd	ra,72(sp)
    80003adc:	02913c23          	sd	s1,56(sp)
    80003ae0:	03213823          	sd	s2,48(sp)
    80003ae4:	03313423          	sd	s3,40(sp)
    80003ae8:	03413023          	sd	s4,32(sp)
    80003aec:	01513c23          	sd	s5,24(sp)
    80003af0:	05010413          	addi	s0,sp,80
    80003af4:	06c05c63          	blez	a2,80003b6c <consolewrite+0x9c>
    80003af8:	00060993          	mv	s3,a2
    80003afc:	00050a13          	mv	s4,a0
    80003b00:	00058493          	mv	s1,a1
    80003b04:	00000913          	li	s2,0
    80003b08:	fff00a93          	li	s5,-1
    80003b0c:	01c0006f          	j	80003b28 <consolewrite+0x58>
    80003b10:	fbf44503          	lbu	a0,-65(s0)
    80003b14:	0019091b          	addiw	s2,s2,1
    80003b18:	00148493          	addi	s1,s1,1
    80003b1c:	00001097          	auipc	ra,0x1
    80003b20:	a9c080e7          	jalr	-1380(ra) # 800045b8 <uartputc>
    80003b24:	03298063          	beq	s3,s2,80003b44 <consolewrite+0x74>
    80003b28:	00048613          	mv	a2,s1
    80003b2c:	00100693          	li	a3,1
    80003b30:	000a0593          	mv	a1,s4
    80003b34:	fbf40513          	addi	a0,s0,-65
    80003b38:	00000097          	auipc	ra,0x0
    80003b3c:	9e0080e7          	jalr	-1568(ra) # 80003518 <either_copyin>
    80003b40:	fd5518e3          	bne	a0,s5,80003b10 <consolewrite+0x40>
    80003b44:	04813083          	ld	ra,72(sp)
    80003b48:	04013403          	ld	s0,64(sp)
    80003b4c:	03813483          	ld	s1,56(sp)
    80003b50:	02813983          	ld	s3,40(sp)
    80003b54:	02013a03          	ld	s4,32(sp)
    80003b58:	01813a83          	ld	s5,24(sp)
    80003b5c:	00090513          	mv	a0,s2
    80003b60:	03013903          	ld	s2,48(sp)
    80003b64:	05010113          	addi	sp,sp,80
    80003b68:	00008067          	ret
    80003b6c:	00000913          	li	s2,0
    80003b70:	fd5ff06f          	j	80003b44 <consolewrite+0x74>

0000000080003b74 <consoleread>:
    80003b74:	f9010113          	addi	sp,sp,-112
    80003b78:	06813023          	sd	s0,96(sp)
    80003b7c:	04913c23          	sd	s1,88(sp)
    80003b80:	05213823          	sd	s2,80(sp)
    80003b84:	05313423          	sd	s3,72(sp)
    80003b88:	05413023          	sd	s4,64(sp)
    80003b8c:	03513c23          	sd	s5,56(sp)
    80003b90:	03613823          	sd	s6,48(sp)
    80003b94:	03713423          	sd	s7,40(sp)
    80003b98:	03813023          	sd	s8,32(sp)
    80003b9c:	06113423          	sd	ra,104(sp)
    80003ba0:	01913c23          	sd	s9,24(sp)
    80003ba4:	07010413          	addi	s0,sp,112
    80003ba8:	00060b93          	mv	s7,a2
    80003bac:	00050913          	mv	s2,a0
    80003bb0:	00058c13          	mv	s8,a1
    80003bb4:	00060b1b          	sext.w	s6,a2
    80003bb8:	00004497          	auipc	s1,0x4
    80003bbc:	e9048493          	addi	s1,s1,-368 # 80007a48 <cons>
    80003bc0:	00400993          	li	s3,4
    80003bc4:	fff00a13          	li	s4,-1
    80003bc8:	00a00a93          	li	s5,10
    80003bcc:	05705e63          	blez	s7,80003c28 <consoleread+0xb4>
    80003bd0:	09c4a703          	lw	a4,156(s1)
    80003bd4:	0984a783          	lw	a5,152(s1)
    80003bd8:	0007071b          	sext.w	a4,a4
    80003bdc:	08e78463          	beq	a5,a4,80003c64 <consoleread+0xf0>
    80003be0:	07f7f713          	andi	a4,a5,127
    80003be4:	00e48733          	add	a4,s1,a4
    80003be8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80003bec:	0017869b          	addiw	a3,a5,1
    80003bf0:	08d4ac23          	sw	a3,152(s1)
    80003bf4:	00070c9b          	sext.w	s9,a4
    80003bf8:	0b370663          	beq	a4,s3,80003ca4 <consoleread+0x130>
    80003bfc:	00100693          	li	a3,1
    80003c00:	f9f40613          	addi	a2,s0,-97
    80003c04:	000c0593          	mv	a1,s8
    80003c08:	00090513          	mv	a0,s2
    80003c0c:	f8e40fa3          	sb	a4,-97(s0)
    80003c10:	00000097          	auipc	ra,0x0
    80003c14:	8bc080e7          	jalr	-1860(ra) # 800034cc <either_copyout>
    80003c18:	01450863          	beq	a0,s4,80003c28 <consoleread+0xb4>
    80003c1c:	001c0c13          	addi	s8,s8,1
    80003c20:	fffb8b9b          	addiw	s7,s7,-1
    80003c24:	fb5c94e3          	bne	s9,s5,80003bcc <consoleread+0x58>
    80003c28:	000b851b          	sext.w	a0,s7
    80003c2c:	06813083          	ld	ra,104(sp)
    80003c30:	06013403          	ld	s0,96(sp)
    80003c34:	05813483          	ld	s1,88(sp)
    80003c38:	05013903          	ld	s2,80(sp)
    80003c3c:	04813983          	ld	s3,72(sp)
    80003c40:	04013a03          	ld	s4,64(sp)
    80003c44:	03813a83          	ld	s5,56(sp)
    80003c48:	02813b83          	ld	s7,40(sp)
    80003c4c:	02013c03          	ld	s8,32(sp)
    80003c50:	01813c83          	ld	s9,24(sp)
    80003c54:	40ab053b          	subw	a0,s6,a0
    80003c58:	03013b03          	ld	s6,48(sp)
    80003c5c:	07010113          	addi	sp,sp,112
    80003c60:	00008067          	ret
    80003c64:	00001097          	auipc	ra,0x1
    80003c68:	1d8080e7          	jalr	472(ra) # 80004e3c <push_on>
    80003c6c:	0984a703          	lw	a4,152(s1)
    80003c70:	09c4a783          	lw	a5,156(s1)
    80003c74:	0007879b          	sext.w	a5,a5
    80003c78:	fef70ce3          	beq	a4,a5,80003c70 <consoleread+0xfc>
    80003c7c:	00001097          	auipc	ra,0x1
    80003c80:	234080e7          	jalr	564(ra) # 80004eb0 <pop_on>
    80003c84:	0984a783          	lw	a5,152(s1)
    80003c88:	07f7f713          	andi	a4,a5,127
    80003c8c:	00e48733          	add	a4,s1,a4
    80003c90:	01874703          	lbu	a4,24(a4)
    80003c94:	0017869b          	addiw	a3,a5,1
    80003c98:	08d4ac23          	sw	a3,152(s1)
    80003c9c:	00070c9b          	sext.w	s9,a4
    80003ca0:	f5371ee3          	bne	a4,s3,80003bfc <consoleread+0x88>
    80003ca4:	000b851b          	sext.w	a0,s7
    80003ca8:	f96bf2e3          	bgeu	s7,s6,80003c2c <consoleread+0xb8>
    80003cac:	08f4ac23          	sw	a5,152(s1)
    80003cb0:	f7dff06f          	j	80003c2c <consoleread+0xb8>

0000000080003cb4 <consputc>:
    80003cb4:	10000793          	li	a5,256
    80003cb8:	00f50663          	beq	a0,a5,80003cc4 <consputc+0x10>
    80003cbc:	00001317          	auipc	t1,0x1
    80003cc0:	9f430067          	jr	-1548(t1) # 800046b0 <uartputc_sync>
    80003cc4:	ff010113          	addi	sp,sp,-16
    80003cc8:	00113423          	sd	ra,8(sp)
    80003ccc:	00813023          	sd	s0,0(sp)
    80003cd0:	01010413          	addi	s0,sp,16
    80003cd4:	00800513          	li	a0,8
    80003cd8:	00001097          	auipc	ra,0x1
    80003cdc:	9d8080e7          	jalr	-1576(ra) # 800046b0 <uartputc_sync>
    80003ce0:	02000513          	li	a0,32
    80003ce4:	00001097          	auipc	ra,0x1
    80003ce8:	9cc080e7          	jalr	-1588(ra) # 800046b0 <uartputc_sync>
    80003cec:	00013403          	ld	s0,0(sp)
    80003cf0:	00813083          	ld	ra,8(sp)
    80003cf4:	00800513          	li	a0,8
    80003cf8:	01010113          	addi	sp,sp,16
    80003cfc:	00001317          	auipc	t1,0x1
    80003d00:	9b430067          	jr	-1612(t1) # 800046b0 <uartputc_sync>

0000000080003d04 <consoleintr>:
    80003d04:	fe010113          	addi	sp,sp,-32
    80003d08:	00813823          	sd	s0,16(sp)
    80003d0c:	00913423          	sd	s1,8(sp)
    80003d10:	01213023          	sd	s2,0(sp)
    80003d14:	00113c23          	sd	ra,24(sp)
    80003d18:	02010413          	addi	s0,sp,32
    80003d1c:	00004917          	auipc	s2,0x4
    80003d20:	d2c90913          	addi	s2,s2,-724 # 80007a48 <cons>
    80003d24:	00050493          	mv	s1,a0
    80003d28:	00090513          	mv	a0,s2
    80003d2c:	00001097          	auipc	ra,0x1
    80003d30:	e40080e7          	jalr	-448(ra) # 80004b6c <acquire>
    80003d34:	02048c63          	beqz	s1,80003d6c <consoleintr+0x68>
    80003d38:	0a092783          	lw	a5,160(s2)
    80003d3c:	09892703          	lw	a4,152(s2)
    80003d40:	07f00693          	li	a3,127
    80003d44:	40e7873b          	subw	a4,a5,a4
    80003d48:	02e6e263          	bltu	a3,a4,80003d6c <consoleintr+0x68>
    80003d4c:	00d00713          	li	a4,13
    80003d50:	04e48063          	beq	s1,a4,80003d90 <consoleintr+0x8c>
    80003d54:	07f7f713          	andi	a4,a5,127
    80003d58:	00e90733          	add	a4,s2,a4
    80003d5c:	0017879b          	addiw	a5,a5,1
    80003d60:	0af92023          	sw	a5,160(s2)
    80003d64:	00970c23          	sb	s1,24(a4)
    80003d68:	08f92e23          	sw	a5,156(s2)
    80003d6c:	01013403          	ld	s0,16(sp)
    80003d70:	01813083          	ld	ra,24(sp)
    80003d74:	00813483          	ld	s1,8(sp)
    80003d78:	00013903          	ld	s2,0(sp)
    80003d7c:	00004517          	auipc	a0,0x4
    80003d80:	ccc50513          	addi	a0,a0,-820 # 80007a48 <cons>
    80003d84:	02010113          	addi	sp,sp,32
    80003d88:	00001317          	auipc	t1,0x1
    80003d8c:	eb030067          	jr	-336(t1) # 80004c38 <release>
    80003d90:	00a00493          	li	s1,10
    80003d94:	fc1ff06f          	j	80003d54 <consoleintr+0x50>

0000000080003d98 <consoleinit>:
    80003d98:	fe010113          	addi	sp,sp,-32
    80003d9c:	00113c23          	sd	ra,24(sp)
    80003da0:	00813823          	sd	s0,16(sp)
    80003da4:	00913423          	sd	s1,8(sp)
    80003da8:	02010413          	addi	s0,sp,32
    80003dac:	00004497          	auipc	s1,0x4
    80003db0:	c9c48493          	addi	s1,s1,-868 # 80007a48 <cons>
    80003db4:	00048513          	mv	a0,s1
    80003db8:	00002597          	auipc	a1,0x2
    80003dbc:	59858593          	addi	a1,a1,1432 # 80006350 <CONSOLE_STATUS+0x340>
    80003dc0:	00001097          	auipc	ra,0x1
    80003dc4:	d88080e7          	jalr	-632(ra) # 80004b48 <initlock>
    80003dc8:	00000097          	auipc	ra,0x0
    80003dcc:	7ac080e7          	jalr	1964(ra) # 80004574 <uartinit>
    80003dd0:	01813083          	ld	ra,24(sp)
    80003dd4:	01013403          	ld	s0,16(sp)
    80003dd8:	00000797          	auipc	a5,0x0
    80003ddc:	d9c78793          	addi	a5,a5,-612 # 80003b74 <consoleread>
    80003de0:	0af4bc23          	sd	a5,184(s1)
    80003de4:	00000797          	auipc	a5,0x0
    80003de8:	cec78793          	addi	a5,a5,-788 # 80003ad0 <consolewrite>
    80003dec:	0cf4b023          	sd	a5,192(s1)
    80003df0:	00813483          	ld	s1,8(sp)
    80003df4:	02010113          	addi	sp,sp,32
    80003df8:	00008067          	ret

0000000080003dfc <console_read>:
    80003dfc:	ff010113          	addi	sp,sp,-16
    80003e00:	00813423          	sd	s0,8(sp)
    80003e04:	01010413          	addi	s0,sp,16
    80003e08:	00813403          	ld	s0,8(sp)
    80003e0c:	00004317          	auipc	t1,0x4
    80003e10:	cf433303          	ld	t1,-780(t1) # 80007b00 <devsw+0x10>
    80003e14:	01010113          	addi	sp,sp,16
    80003e18:	00030067          	jr	t1

0000000080003e1c <console_write>:
    80003e1c:	ff010113          	addi	sp,sp,-16
    80003e20:	00813423          	sd	s0,8(sp)
    80003e24:	01010413          	addi	s0,sp,16
    80003e28:	00813403          	ld	s0,8(sp)
    80003e2c:	00004317          	auipc	t1,0x4
    80003e30:	cdc33303          	ld	t1,-804(t1) # 80007b08 <devsw+0x18>
    80003e34:	01010113          	addi	sp,sp,16
    80003e38:	00030067          	jr	t1

0000000080003e3c <panic>:
    80003e3c:	fe010113          	addi	sp,sp,-32
    80003e40:	00113c23          	sd	ra,24(sp)
    80003e44:	00813823          	sd	s0,16(sp)
    80003e48:	00913423          	sd	s1,8(sp)
    80003e4c:	02010413          	addi	s0,sp,32
    80003e50:	00050493          	mv	s1,a0
    80003e54:	00002517          	auipc	a0,0x2
    80003e58:	50450513          	addi	a0,a0,1284 # 80006358 <CONSOLE_STATUS+0x348>
    80003e5c:	00004797          	auipc	a5,0x4
    80003e60:	d407a623          	sw	zero,-692(a5) # 80007ba8 <pr+0x18>
    80003e64:	00000097          	auipc	ra,0x0
    80003e68:	034080e7          	jalr	52(ra) # 80003e98 <__printf>
    80003e6c:	00048513          	mv	a0,s1
    80003e70:	00000097          	auipc	ra,0x0
    80003e74:	028080e7          	jalr	40(ra) # 80003e98 <__printf>
    80003e78:	00002517          	auipc	a0,0x2
    80003e7c:	30050513          	addi	a0,a0,768 # 80006178 <CONSOLE_STATUS+0x168>
    80003e80:	00000097          	auipc	ra,0x0
    80003e84:	018080e7          	jalr	24(ra) # 80003e98 <__printf>
    80003e88:	00100793          	li	a5,1
    80003e8c:	00003717          	auipc	a4,0x3
    80003e90:	a8f72623          	sw	a5,-1396(a4) # 80006918 <panicked>
    80003e94:	0000006f          	j	80003e94 <panic+0x58>

0000000080003e98 <__printf>:
    80003e98:	f3010113          	addi	sp,sp,-208
    80003e9c:	08813023          	sd	s0,128(sp)
    80003ea0:	07313423          	sd	s3,104(sp)
    80003ea4:	09010413          	addi	s0,sp,144
    80003ea8:	05813023          	sd	s8,64(sp)
    80003eac:	08113423          	sd	ra,136(sp)
    80003eb0:	06913c23          	sd	s1,120(sp)
    80003eb4:	07213823          	sd	s2,112(sp)
    80003eb8:	07413023          	sd	s4,96(sp)
    80003ebc:	05513c23          	sd	s5,88(sp)
    80003ec0:	05613823          	sd	s6,80(sp)
    80003ec4:	05713423          	sd	s7,72(sp)
    80003ec8:	03913c23          	sd	s9,56(sp)
    80003ecc:	03a13823          	sd	s10,48(sp)
    80003ed0:	03b13423          	sd	s11,40(sp)
    80003ed4:	00004317          	auipc	t1,0x4
    80003ed8:	cbc30313          	addi	t1,t1,-836 # 80007b90 <pr>
    80003edc:	01832c03          	lw	s8,24(t1)
    80003ee0:	00b43423          	sd	a1,8(s0)
    80003ee4:	00c43823          	sd	a2,16(s0)
    80003ee8:	00d43c23          	sd	a3,24(s0)
    80003eec:	02e43023          	sd	a4,32(s0)
    80003ef0:	02f43423          	sd	a5,40(s0)
    80003ef4:	03043823          	sd	a6,48(s0)
    80003ef8:	03143c23          	sd	a7,56(s0)
    80003efc:	00050993          	mv	s3,a0
    80003f00:	4a0c1663          	bnez	s8,800043ac <__printf+0x514>
    80003f04:	60098c63          	beqz	s3,8000451c <__printf+0x684>
    80003f08:	0009c503          	lbu	a0,0(s3)
    80003f0c:	00840793          	addi	a5,s0,8
    80003f10:	f6f43c23          	sd	a5,-136(s0)
    80003f14:	00000493          	li	s1,0
    80003f18:	22050063          	beqz	a0,80004138 <__printf+0x2a0>
    80003f1c:	00002a37          	lui	s4,0x2
    80003f20:	00018ab7          	lui	s5,0x18
    80003f24:	000f4b37          	lui	s6,0xf4
    80003f28:	00989bb7          	lui	s7,0x989
    80003f2c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003f30:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003f34:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003f38:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80003f3c:	00148c9b          	addiw	s9,s1,1
    80003f40:	02500793          	li	a5,37
    80003f44:	01998933          	add	s2,s3,s9
    80003f48:	38f51263          	bne	a0,a5,800042cc <__printf+0x434>
    80003f4c:	00094783          	lbu	a5,0(s2)
    80003f50:	00078c9b          	sext.w	s9,a5
    80003f54:	1e078263          	beqz	a5,80004138 <__printf+0x2a0>
    80003f58:	0024849b          	addiw	s1,s1,2
    80003f5c:	07000713          	li	a4,112
    80003f60:	00998933          	add	s2,s3,s1
    80003f64:	38e78a63          	beq	a5,a4,800042f8 <__printf+0x460>
    80003f68:	20f76863          	bltu	a4,a5,80004178 <__printf+0x2e0>
    80003f6c:	42a78863          	beq	a5,a0,8000439c <__printf+0x504>
    80003f70:	06400713          	li	a4,100
    80003f74:	40e79663          	bne	a5,a4,80004380 <__printf+0x4e8>
    80003f78:	f7843783          	ld	a5,-136(s0)
    80003f7c:	0007a603          	lw	a2,0(a5)
    80003f80:	00878793          	addi	a5,a5,8
    80003f84:	f6f43c23          	sd	a5,-136(s0)
    80003f88:	42064a63          	bltz	a2,800043bc <__printf+0x524>
    80003f8c:	00a00713          	li	a4,10
    80003f90:	02e677bb          	remuw	a5,a2,a4
    80003f94:	00002d97          	auipc	s11,0x2
    80003f98:	3ecd8d93          	addi	s11,s11,1004 # 80006380 <digits>
    80003f9c:	00900593          	li	a1,9
    80003fa0:	0006051b          	sext.w	a0,a2
    80003fa4:	00000c93          	li	s9,0
    80003fa8:	02079793          	slli	a5,a5,0x20
    80003fac:	0207d793          	srli	a5,a5,0x20
    80003fb0:	00fd87b3          	add	a5,s11,a5
    80003fb4:	0007c783          	lbu	a5,0(a5)
    80003fb8:	02e656bb          	divuw	a3,a2,a4
    80003fbc:	f8f40023          	sb	a5,-128(s0)
    80003fc0:	14c5d863          	bge	a1,a2,80004110 <__printf+0x278>
    80003fc4:	06300593          	li	a1,99
    80003fc8:	00100c93          	li	s9,1
    80003fcc:	02e6f7bb          	remuw	a5,a3,a4
    80003fd0:	02079793          	slli	a5,a5,0x20
    80003fd4:	0207d793          	srli	a5,a5,0x20
    80003fd8:	00fd87b3          	add	a5,s11,a5
    80003fdc:	0007c783          	lbu	a5,0(a5)
    80003fe0:	02e6d73b          	divuw	a4,a3,a4
    80003fe4:	f8f400a3          	sb	a5,-127(s0)
    80003fe8:	12a5f463          	bgeu	a1,a0,80004110 <__printf+0x278>
    80003fec:	00a00693          	li	a3,10
    80003ff0:	00900593          	li	a1,9
    80003ff4:	02d777bb          	remuw	a5,a4,a3
    80003ff8:	02079793          	slli	a5,a5,0x20
    80003ffc:	0207d793          	srli	a5,a5,0x20
    80004000:	00fd87b3          	add	a5,s11,a5
    80004004:	0007c503          	lbu	a0,0(a5)
    80004008:	02d757bb          	divuw	a5,a4,a3
    8000400c:	f8a40123          	sb	a0,-126(s0)
    80004010:	48e5f263          	bgeu	a1,a4,80004494 <__printf+0x5fc>
    80004014:	06300513          	li	a0,99
    80004018:	02d7f5bb          	remuw	a1,a5,a3
    8000401c:	02059593          	slli	a1,a1,0x20
    80004020:	0205d593          	srli	a1,a1,0x20
    80004024:	00bd85b3          	add	a1,s11,a1
    80004028:	0005c583          	lbu	a1,0(a1)
    8000402c:	02d7d7bb          	divuw	a5,a5,a3
    80004030:	f8b401a3          	sb	a1,-125(s0)
    80004034:	48e57263          	bgeu	a0,a4,800044b8 <__printf+0x620>
    80004038:	3e700513          	li	a0,999
    8000403c:	02d7f5bb          	remuw	a1,a5,a3
    80004040:	02059593          	slli	a1,a1,0x20
    80004044:	0205d593          	srli	a1,a1,0x20
    80004048:	00bd85b3          	add	a1,s11,a1
    8000404c:	0005c583          	lbu	a1,0(a1)
    80004050:	02d7d7bb          	divuw	a5,a5,a3
    80004054:	f8b40223          	sb	a1,-124(s0)
    80004058:	46e57663          	bgeu	a0,a4,800044c4 <__printf+0x62c>
    8000405c:	02d7f5bb          	remuw	a1,a5,a3
    80004060:	02059593          	slli	a1,a1,0x20
    80004064:	0205d593          	srli	a1,a1,0x20
    80004068:	00bd85b3          	add	a1,s11,a1
    8000406c:	0005c583          	lbu	a1,0(a1)
    80004070:	02d7d7bb          	divuw	a5,a5,a3
    80004074:	f8b402a3          	sb	a1,-123(s0)
    80004078:	46ea7863          	bgeu	s4,a4,800044e8 <__printf+0x650>
    8000407c:	02d7f5bb          	remuw	a1,a5,a3
    80004080:	02059593          	slli	a1,a1,0x20
    80004084:	0205d593          	srli	a1,a1,0x20
    80004088:	00bd85b3          	add	a1,s11,a1
    8000408c:	0005c583          	lbu	a1,0(a1)
    80004090:	02d7d7bb          	divuw	a5,a5,a3
    80004094:	f8b40323          	sb	a1,-122(s0)
    80004098:	3eeaf863          	bgeu	s5,a4,80004488 <__printf+0x5f0>
    8000409c:	02d7f5bb          	remuw	a1,a5,a3
    800040a0:	02059593          	slli	a1,a1,0x20
    800040a4:	0205d593          	srli	a1,a1,0x20
    800040a8:	00bd85b3          	add	a1,s11,a1
    800040ac:	0005c583          	lbu	a1,0(a1)
    800040b0:	02d7d7bb          	divuw	a5,a5,a3
    800040b4:	f8b403a3          	sb	a1,-121(s0)
    800040b8:	42eb7e63          	bgeu	s6,a4,800044f4 <__printf+0x65c>
    800040bc:	02d7f5bb          	remuw	a1,a5,a3
    800040c0:	02059593          	slli	a1,a1,0x20
    800040c4:	0205d593          	srli	a1,a1,0x20
    800040c8:	00bd85b3          	add	a1,s11,a1
    800040cc:	0005c583          	lbu	a1,0(a1)
    800040d0:	02d7d7bb          	divuw	a5,a5,a3
    800040d4:	f8b40423          	sb	a1,-120(s0)
    800040d8:	42ebfc63          	bgeu	s7,a4,80004510 <__printf+0x678>
    800040dc:	02079793          	slli	a5,a5,0x20
    800040e0:	0207d793          	srli	a5,a5,0x20
    800040e4:	00fd8db3          	add	s11,s11,a5
    800040e8:	000dc703          	lbu	a4,0(s11)
    800040ec:	00a00793          	li	a5,10
    800040f0:	00900c93          	li	s9,9
    800040f4:	f8e404a3          	sb	a4,-119(s0)
    800040f8:	00065c63          	bgez	a2,80004110 <__printf+0x278>
    800040fc:	f9040713          	addi	a4,s0,-112
    80004100:	00f70733          	add	a4,a4,a5
    80004104:	02d00693          	li	a3,45
    80004108:	fed70823          	sb	a3,-16(a4)
    8000410c:	00078c93          	mv	s9,a5
    80004110:	f8040793          	addi	a5,s0,-128
    80004114:	01978cb3          	add	s9,a5,s9
    80004118:	f7f40d13          	addi	s10,s0,-129
    8000411c:	000cc503          	lbu	a0,0(s9)
    80004120:	fffc8c93          	addi	s9,s9,-1
    80004124:	00000097          	auipc	ra,0x0
    80004128:	b90080e7          	jalr	-1136(ra) # 80003cb4 <consputc>
    8000412c:	ffac98e3          	bne	s9,s10,8000411c <__printf+0x284>
    80004130:	00094503          	lbu	a0,0(s2)
    80004134:	e00514e3          	bnez	a0,80003f3c <__printf+0xa4>
    80004138:	1a0c1663          	bnez	s8,800042e4 <__printf+0x44c>
    8000413c:	08813083          	ld	ra,136(sp)
    80004140:	08013403          	ld	s0,128(sp)
    80004144:	07813483          	ld	s1,120(sp)
    80004148:	07013903          	ld	s2,112(sp)
    8000414c:	06813983          	ld	s3,104(sp)
    80004150:	06013a03          	ld	s4,96(sp)
    80004154:	05813a83          	ld	s5,88(sp)
    80004158:	05013b03          	ld	s6,80(sp)
    8000415c:	04813b83          	ld	s7,72(sp)
    80004160:	04013c03          	ld	s8,64(sp)
    80004164:	03813c83          	ld	s9,56(sp)
    80004168:	03013d03          	ld	s10,48(sp)
    8000416c:	02813d83          	ld	s11,40(sp)
    80004170:	0d010113          	addi	sp,sp,208
    80004174:	00008067          	ret
    80004178:	07300713          	li	a4,115
    8000417c:	1ce78a63          	beq	a5,a4,80004350 <__printf+0x4b8>
    80004180:	07800713          	li	a4,120
    80004184:	1ee79e63          	bne	a5,a4,80004380 <__printf+0x4e8>
    80004188:	f7843783          	ld	a5,-136(s0)
    8000418c:	0007a703          	lw	a4,0(a5)
    80004190:	00878793          	addi	a5,a5,8
    80004194:	f6f43c23          	sd	a5,-136(s0)
    80004198:	28074263          	bltz	a4,8000441c <__printf+0x584>
    8000419c:	00002d97          	auipc	s11,0x2
    800041a0:	1e4d8d93          	addi	s11,s11,484 # 80006380 <digits>
    800041a4:	00f77793          	andi	a5,a4,15
    800041a8:	00fd87b3          	add	a5,s11,a5
    800041ac:	0007c683          	lbu	a3,0(a5)
    800041b0:	00f00613          	li	a2,15
    800041b4:	0007079b          	sext.w	a5,a4
    800041b8:	f8d40023          	sb	a3,-128(s0)
    800041bc:	0047559b          	srliw	a1,a4,0x4
    800041c0:	0047569b          	srliw	a3,a4,0x4
    800041c4:	00000c93          	li	s9,0
    800041c8:	0ee65063          	bge	a2,a4,800042a8 <__printf+0x410>
    800041cc:	00f6f693          	andi	a3,a3,15
    800041d0:	00dd86b3          	add	a3,s11,a3
    800041d4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800041d8:	0087d79b          	srliw	a5,a5,0x8
    800041dc:	00100c93          	li	s9,1
    800041e0:	f8d400a3          	sb	a3,-127(s0)
    800041e4:	0cb67263          	bgeu	a2,a1,800042a8 <__printf+0x410>
    800041e8:	00f7f693          	andi	a3,a5,15
    800041ec:	00dd86b3          	add	a3,s11,a3
    800041f0:	0006c583          	lbu	a1,0(a3)
    800041f4:	00f00613          	li	a2,15
    800041f8:	0047d69b          	srliw	a3,a5,0x4
    800041fc:	f8b40123          	sb	a1,-126(s0)
    80004200:	0047d593          	srli	a1,a5,0x4
    80004204:	28f67e63          	bgeu	a2,a5,800044a0 <__printf+0x608>
    80004208:	00f6f693          	andi	a3,a3,15
    8000420c:	00dd86b3          	add	a3,s11,a3
    80004210:	0006c503          	lbu	a0,0(a3)
    80004214:	0087d813          	srli	a6,a5,0x8
    80004218:	0087d69b          	srliw	a3,a5,0x8
    8000421c:	f8a401a3          	sb	a0,-125(s0)
    80004220:	28b67663          	bgeu	a2,a1,800044ac <__printf+0x614>
    80004224:	00f6f693          	andi	a3,a3,15
    80004228:	00dd86b3          	add	a3,s11,a3
    8000422c:	0006c583          	lbu	a1,0(a3)
    80004230:	00c7d513          	srli	a0,a5,0xc
    80004234:	00c7d69b          	srliw	a3,a5,0xc
    80004238:	f8b40223          	sb	a1,-124(s0)
    8000423c:	29067a63          	bgeu	a2,a6,800044d0 <__printf+0x638>
    80004240:	00f6f693          	andi	a3,a3,15
    80004244:	00dd86b3          	add	a3,s11,a3
    80004248:	0006c583          	lbu	a1,0(a3)
    8000424c:	0107d813          	srli	a6,a5,0x10
    80004250:	0107d69b          	srliw	a3,a5,0x10
    80004254:	f8b402a3          	sb	a1,-123(s0)
    80004258:	28a67263          	bgeu	a2,a0,800044dc <__printf+0x644>
    8000425c:	00f6f693          	andi	a3,a3,15
    80004260:	00dd86b3          	add	a3,s11,a3
    80004264:	0006c683          	lbu	a3,0(a3)
    80004268:	0147d79b          	srliw	a5,a5,0x14
    8000426c:	f8d40323          	sb	a3,-122(s0)
    80004270:	21067663          	bgeu	a2,a6,8000447c <__printf+0x5e4>
    80004274:	02079793          	slli	a5,a5,0x20
    80004278:	0207d793          	srli	a5,a5,0x20
    8000427c:	00fd8db3          	add	s11,s11,a5
    80004280:	000dc683          	lbu	a3,0(s11)
    80004284:	00800793          	li	a5,8
    80004288:	00700c93          	li	s9,7
    8000428c:	f8d403a3          	sb	a3,-121(s0)
    80004290:	00075c63          	bgez	a4,800042a8 <__printf+0x410>
    80004294:	f9040713          	addi	a4,s0,-112
    80004298:	00f70733          	add	a4,a4,a5
    8000429c:	02d00693          	li	a3,45
    800042a0:	fed70823          	sb	a3,-16(a4)
    800042a4:	00078c93          	mv	s9,a5
    800042a8:	f8040793          	addi	a5,s0,-128
    800042ac:	01978cb3          	add	s9,a5,s9
    800042b0:	f7f40d13          	addi	s10,s0,-129
    800042b4:	000cc503          	lbu	a0,0(s9)
    800042b8:	fffc8c93          	addi	s9,s9,-1
    800042bc:	00000097          	auipc	ra,0x0
    800042c0:	9f8080e7          	jalr	-1544(ra) # 80003cb4 <consputc>
    800042c4:	ff9d18e3          	bne	s10,s9,800042b4 <__printf+0x41c>
    800042c8:	0100006f          	j	800042d8 <__printf+0x440>
    800042cc:	00000097          	auipc	ra,0x0
    800042d0:	9e8080e7          	jalr	-1560(ra) # 80003cb4 <consputc>
    800042d4:	000c8493          	mv	s1,s9
    800042d8:	00094503          	lbu	a0,0(s2)
    800042dc:	c60510e3          	bnez	a0,80003f3c <__printf+0xa4>
    800042e0:	e40c0ee3          	beqz	s8,8000413c <__printf+0x2a4>
    800042e4:	00004517          	auipc	a0,0x4
    800042e8:	8ac50513          	addi	a0,a0,-1876 # 80007b90 <pr>
    800042ec:	00001097          	auipc	ra,0x1
    800042f0:	94c080e7          	jalr	-1716(ra) # 80004c38 <release>
    800042f4:	e49ff06f          	j	8000413c <__printf+0x2a4>
    800042f8:	f7843783          	ld	a5,-136(s0)
    800042fc:	03000513          	li	a0,48
    80004300:	01000d13          	li	s10,16
    80004304:	00878713          	addi	a4,a5,8
    80004308:	0007bc83          	ld	s9,0(a5)
    8000430c:	f6e43c23          	sd	a4,-136(s0)
    80004310:	00000097          	auipc	ra,0x0
    80004314:	9a4080e7          	jalr	-1628(ra) # 80003cb4 <consputc>
    80004318:	07800513          	li	a0,120
    8000431c:	00000097          	auipc	ra,0x0
    80004320:	998080e7          	jalr	-1640(ra) # 80003cb4 <consputc>
    80004324:	00002d97          	auipc	s11,0x2
    80004328:	05cd8d93          	addi	s11,s11,92 # 80006380 <digits>
    8000432c:	03ccd793          	srli	a5,s9,0x3c
    80004330:	00fd87b3          	add	a5,s11,a5
    80004334:	0007c503          	lbu	a0,0(a5)
    80004338:	fffd0d1b          	addiw	s10,s10,-1
    8000433c:	004c9c93          	slli	s9,s9,0x4
    80004340:	00000097          	auipc	ra,0x0
    80004344:	974080e7          	jalr	-1676(ra) # 80003cb4 <consputc>
    80004348:	fe0d12e3          	bnez	s10,8000432c <__printf+0x494>
    8000434c:	f8dff06f          	j	800042d8 <__printf+0x440>
    80004350:	f7843783          	ld	a5,-136(s0)
    80004354:	0007bc83          	ld	s9,0(a5)
    80004358:	00878793          	addi	a5,a5,8
    8000435c:	f6f43c23          	sd	a5,-136(s0)
    80004360:	000c9a63          	bnez	s9,80004374 <__printf+0x4dc>
    80004364:	1080006f          	j	8000446c <__printf+0x5d4>
    80004368:	001c8c93          	addi	s9,s9,1
    8000436c:	00000097          	auipc	ra,0x0
    80004370:	948080e7          	jalr	-1720(ra) # 80003cb4 <consputc>
    80004374:	000cc503          	lbu	a0,0(s9)
    80004378:	fe0518e3          	bnez	a0,80004368 <__printf+0x4d0>
    8000437c:	f5dff06f          	j	800042d8 <__printf+0x440>
    80004380:	02500513          	li	a0,37
    80004384:	00000097          	auipc	ra,0x0
    80004388:	930080e7          	jalr	-1744(ra) # 80003cb4 <consputc>
    8000438c:	000c8513          	mv	a0,s9
    80004390:	00000097          	auipc	ra,0x0
    80004394:	924080e7          	jalr	-1756(ra) # 80003cb4 <consputc>
    80004398:	f41ff06f          	j	800042d8 <__printf+0x440>
    8000439c:	02500513          	li	a0,37
    800043a0:	00000097          	auipc	ra,0x0
    800043a4:	914080e7          	jalr	-1772(ra) # 80003cb4 <consputc>
    800043a8:	f31ff06f          	j	800042d8 <__printf+0x440>
    800043ac:	00030513          	mv	a0,t1
    800043b0:	00000097          	auipc	ra,0x0
    800043b4:	7bc080e7          	jalr	1980(ra) # 80004b6c <acquire>
    800043b8:	b4dff06f          	j	80003f04 <__printf+0x6c>
    800043bc:	40c0053b          	negw	a0,a2
    800043c0:	00a00713          	li	a4,10
    800043c4:	02e576bb          	remuw	a3,a0,a4
    800043c8:	00002d97          	auipc	s11,0x2
    800043cc:	fb8d8d93          	addi	s11,s11,-72 # 80006380 <digits>
    800043d0:	ff700593          	li	a1,-9
    800043d4:	02069693          	slli	a3,a3,0x20
    800043d8:	0206d693          	srli	a3,a3,0x20
    800043dc:	00dd86b3          	add	a3,s11,a3
    800043e0:	0006c683          	lbu	a3,0(a3)
    800043e4:	02e557bb          	divuw	a5,a0,a4
    800043e8:	f8d40023          	sb	a3,-128(s0)
    800043ec:	10b65e63          	bge	a2,a1,80004508 <__printf+0x670>
    800043f0:	06300593          	li	a1,99
    800043f4:	02e7f6bb          	remuw	a3,a5,a4
    800043f8:	02069693          	slli	a3,a3,0x20
    800043fc:	0206d693          	srli	a3,a3,0x20
    80004400:	00dd86b3          	add	a3,s11,a3
    80004404:	0006c683          	lbu	a3,0(a3)
    80004408:	02e7d73b          	divuw	a4,a5,a4
    8000440c:	00200793          	li	a5,2
    80004410:	f8d400a3          	sb	a3,-127(s0)
    80004414:	bca5ece3          	bltu	a1,a0,80003fec <__printf+0x154>
    80004418:	ce5ff06f          	j	800040fc <__printf+0x264>
    8000441c:	40e007bb          	negw	a5,a4
    80004420:	00002d97          	auipc	s11,0x2
    80004424:	f60d8d93          	addi	s11,s11,-160 # 80006380 <digits>
    80004428:	00f7f693          	andi	a3,a5,15
    8000442c:	00dd86b3          	add	a3,s11,a3
    80004430:	0006c583          	lbu	a1,0(a3)
    80004434:	ff100613          	li	a2,-15
    80004438:	0047d69b          	srliw	a3,a5,0x4
    8000443c:	f8b40023          	sb	a1,-128(s0)
    80004440:	0047d59b          	srliw	a1,a5,0x4
    80004444:	0ac75e63          	bge	a4,a2,80004500 <__printf+0x668>
    80004448:	00f6f693          	andi	a3,a3,15
    8000444c:	00dd86b3          	add	a3,s11,a3
    80004450:	0006c603          	lbu	a2,0(a3)
    80004454:	00f00693          	li	a3,15
    80004458:	0087d79b          	srliw	a5,a5,0x8
    8000445c:	f8c400a3          	sb	a2,-127(s0)
    80004460:	d8b6e4e3          	bltu	a3,a1,800041e8 <__printf+0x350>
    80004464:	00200793          	li	a5,2
    80004468:	e2dff06f          	j	80004294 <__printf+0x3fc>
    8000446c:	00002c97          	auipc	s9,0x2
    80004470:	ef4c8c93          	addi	s9,s9,-268 # 80006360 <CONSOLE_STATUS+0x350>
    80004474:	02800513          	li	a0,40
    80004478:	ef1ff06f          	j	80004368 <__printf+0x4d0>
    8000447c:	00700793          	li	a5,7
    80004480:	00600c93          	li	s9,6
    80004484:	e0dff06f          	j	80004290 <__printf+0x3f8>
    80004488:	00700793          	li	a5,7
    8000448c:	00600c93          	li	s9,6
    80004490:	c69ff06f          	j	800040f8 <__printf+0x260>
    80004494:	00300793          	li	a5,3
    80004498:	00200c93          	li	s9,2
    8000449c:	c5dff06f          	j	800040f8 <__printf+0x260>
    800044a0:	00300793          	li	a5,3
    800044a4:	00200c93          	li	s9,2
    800044a8:	de9ff06f          	j	80004290 <__printf+0x3f8>
    800044ac:	00400793          	li	a5,4
    800044b0:	00300c93          	li	s9,3
    800044b4:	dddff06f          	j	80004290 <__printf+0x3f8>
    800044b8:	00400793          	li	a5,4
    800044bc:	00300c93          	li	s9,3
    800044c0:	c39ff06f          	j	800040f8 <__printf+0x260>
    800044c4:	00500793          	li	a5,5
    800044c8:	00400c93          	li	s9,4
    800044cc:	c2dff06f          	j	800040f8 <__printf+0x260>
    800044d0:	00500793          	li	a5,5
    800044d4:	00400c93          	li	s9,4
    800044d8:	db9ff06f          	j	80004290 <__printf+0x3f8>
    800044dc:	00600793          	li	a5,6
    800044e0:	00500c93          	li	s9,5
    800044e4:	dadff06f          	j	80004290 <__printf+0x3f8>
    800044e8:	00600793          	li	a5,6
    800044ec:	00500c93          	li	s9,5
    800044f0:	c09ff06f          	j	800040f8 <__printf+0x260>
    800044f4:	00800793          	li	a5,8
    800044f8:	00700c93          	li	s9,7
    800044fc:	bfdff06f          	j	800040f8 <__printf+0x260>
    80004500:	00100793          	li	a5,1
    80004504:	d91ff06f          	j	80004294 <__printf+0x3fc>
    80004508:	00100793          	li	a5,1
    8000450c:	bf1ff06f          	j	800040fc <__printf+0x264>
    80004510:	00900793          	li	a5,9
    80004514:	00800c93          	li	s9,8
    80004518:	be1ff06f          	j	800040f8 <__printf+0x260>
    8000451c:	00002517          	auipc	a0,0x2
    80004520:	e4c50513          	addi	a0,a0,-436 # 80006368 <CONSOLE_STATUS+0x358>
    80004524:	00000097          	auipc	ra,0x0
    80004528:	918080e7          	jalr	-1768(ra) # 80003e3c <panic>

000000008000452c <printfinit>:
    8000452c:	fe010113          	addi	sp,sp,-32
    80004530:	00813823          	sd	s0,16(sp)
    80004534:	00913423          	sd	s1,8(sp)
    80004538:	00113c23          	sd	ra,24(sp)
    8000453c:	02010413          	addi	s0,sp,32
    80004540:	00003497          	auipc	s1,0x3
    80004544:	65048493          	addi	s1,s1,1616 # 80007b90 <pr>
    80004548:	00048513          	mv	a0,s1
    8000454c:	00002597          	auipc	a1,0x2
    80004550:	e2c58593          	addi	a1,a1,-468 # 80006378 <CONSOLE_STATUS+0x368>
    80004554:	00000097          	auipc	ra,0x0
    80004558:	5f4080e7          	jalr	1524(ra) # 80004b48 <initlock>
    8000455c:	01813083          	ld	ra,24(sp)
    80004560:	01013403          	ld	s0,16(sp)
    80004564:	0004ac23          	sw	zero,24(s1)
    80004568:	00813483          	ld	s1,8(sp)
    8000456c:	02010113          	addi	sp,sp,32
    80004570:	00008067          	ret

0000000080004574 <uartinit>:
    80004574:	ff010113          	addi	sp,sp,-16
    80004578:	00813423          	sd	s0,8(sp)
    8000457c:	01010413          	addi	s0,sp,16
    80004580:	100007b7          	lui	a5,0x10000
    80004584:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004588:	f8000713          	li	a4,-128
    8000458c:	00e781a3          	sb	a4,3(a5)
    80004590:	00300713          	li	a4,3
    80004594:	00e78023          	sb	a4,0(a5)
    80004598:	000780a3          	sb	zero,1(a5)
    8000459c:	00e781a3          	sb	a4,3(a5)
    800045a0:	00700693          	li	a3,7
    800045a4:	00d78123          	sb	a3,2(a5)
    800045a8:	00e780a3          	sb	a4,1(a5)
    800045ac:	00813403          	ld	s0,8(sp)
    800045b0:	01010113          	addi	sp,sp,16
    800045b4:	00008067          	ret

00000000800045b8 <uartputc>:
    800045b8:	00002797          	auipc	a5,0x2
    800045bc:	3607a783          	lw	a5,864(a5) # 80006918 <panicked>
    800045c0:	00078463          	beqz	a5,800045c8 <uartputc+0x10>
    800045c4:	0000006f          	j	800045c4 <uartputc+0xc>
    800045c8:	fd010113          	addi	sp,sp,-48
    800045cc:	02813023          	sd	s0,32(sp)
    800045d0:	00913c23          	sd	s1,24(sp)
    800045d4:	01213823          	sd	s2,16(sp)
    800045d8:	01313423          	sd	s3,8(sp)
    800045dc:	02113423          	sd	ra,40(sp)
    800045e0:	03010413          	addi	s0,sp,48
    800045e4:	00002917          	auipc	s2,0x2
    800045e8:	33c90913          	addi	s2,s2,828 # 80006920 <uart_tx_r>
    800045ec:	00093783          	ld	a5,0(s2)
    800045f0:	00002497          	auipc	s1,0x2
    800045f4:	33848493          	addi	s1,s1,824 # 80006928 <uart_tx_w>
    800045f8:	0004b703          	ld	a4,0(s1)
    800045fc:	02078693          	addi	a3,a5,32
    80004600:	00050993          	mv	s3,a0
    80004604:	02e69c63          	bne	a3,a4,8000463c <uartputc+0x84>
    80004608:	00001097          	auipc	ra,0x1
    8000460c:	834080e7          	jalr	-1996(ra) # 80004e3c <push_on>
    80004610:	00093783          	ld	a5,0(s2)
    80004614:	0004b703          	ld	a4,0(s1)
    80004618:	02078793          	addi	a5,a5,32
    8000461c:	00e79463          	bne	a5,a4,80004624 <uartputc+0x6c>
    80004620:	0000006f          	j	80004620 <uartputc+0x68>
    80004624:	00001097          	auipc	ra,0x1
    80004628:	88c080e7          	jalr	-1908(ra) # 80004eb0 <pop_on>
    8000462c:	00093783          	ld	a5,0(s2)
    80004630:	0004b703          	ld	a4,0(s1)
    80004634:	02078693          	addi	a3,a5,32
    80004638:	fce688e3          	beq	a3,a4,80004608 <uartputc+0x50>
    8000463c:	01f77693          	andi	a3,a4,31
    80004640:	00003597          	auipc	a1,0x3
    80004644:	57058593          	addi	a1,a1,1392 # 80007bb0 <uart_tx_buf>
    80004648:	00d586b3          	add	a3,a1,a3
    8000464c:	00170713          	addi	a4,a4,1
    80004650:	01368023          	sb	s3,0(a3)
    80004654:	00e4b023          	sd	a4,0(s1)
    80004658:	10000637          	lui	a2,0x10000
    8000465c:	02f71063          	bne	a4,a5,8000467c <uartputc+0xc4>
    80004660:	0340006f          	j	80004694 <uartputc+0xdc>
    80004664:	00074703          	lbu	a4,0(a4)
    80004668:	00f93023          	sd	a5,0(s2)
    8000466c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004670:	00093783          	ld	a5,0(s2)
    80004674:	0004b703          	ld	a4,0(s1)
    80004678:	00f70e63          	beq	a4,a5,80004694 <uartputc+0xdc>
    8000467c:	00564683          	lbu	a3,5(a2)
    80004680:	01f7f713          	andi	a4,a5,31
    80004684:	00e58733          	add	a4,a1,a4
    80004688:	0206f693          	andi	a3,a3,32
    8000468c:	00178793          	addi	a5,a5,1
    80004690:	fc069ae3          	bnez	a3,80004664 <uartputc+0xac>
    80004694:	02813083          	ld	ra,40(sp)
    80004698:	02013403          	ld	s0,32(sp)
    8000469c:	01813483          	ld	s1,24(sp)
    800046a0:	01013903          	ld	s2,16(sp)
    800046a4:	00813983          	ld	s3,8(sp)
    800046a8:	03010113          	addi	sp,sp,48
    800046ac:	00008067          	ret

00000000800046b0 <uartputc_sync>:
    800046b0:	ff010113          	addi	sp,sp,-16
    800046b4:	00813423          	sd	s0,8(sp)
    800046b8:	01010413          	addi	s0,sp,16
    800046bc:	00002717          	auipc	a4,0x2
    800046c0:	25c72703          	lw	a4,604(a4) # 80006918 <panicked>
    800046c4:	02071663          	bnez	a4,800046f0 <uartputc_sync+0x40>
    800046c8:	00050793          	mv	a5,a0
    800046cc:	100006b7          	lui	a3,0x10000
    800046d0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800046d4:	02077713          	andi	a4,a4,32
    800046d8:	fe070ce3          	beqz	a4,800046d0 <uartputc_sync+0x20>
    800046dc:	0ff7f793          	andi	a5,a5,255
    800046e0:	00f68023          	sb	a5,0(a3)
    800046e4:	00813403          	ld	s0,8(sp)
    800046e8:	01010113          	addi	sp,sp,16
    800046ec:	00008067          	ret
    800046f0:	0000006f          	j	800046f0 <uartputc_sync+0x40>

00000000800046f4 <uartstart>:
    800046f4:	ff010113          	addi	sp,sp,-16
    800046f8:	00813423          	sd	s0,8(sp)
    800046fc:	01010413          	addi	s0,sp,16
    80004700:	00002617          	auipc	a2,0x2
    80004704:	22060613          	addi	a2,a2,544 # 80006920 <uart_tx_r>
    80004708:	00002517          	auipc	a0,0x2
    8000470c:	22050513          	addi	a0,a0,544 # 80006928 <uart_tx_w>
    80004710:	00063783          	ld	a5,0(a2)
    80004714:	00053703          	ld	a4,0(a0)
    80004718:	04f70263          	beq	a4,a5,8000475c <uartstart+0x68>
    8000471c:	100005b7          	lui	a1,0x10000
    80004720:	00003817          	auipc	a6,0x3
    80004724:	49080813          	addi	a6,a6,1168 # 80007bb0 <uart_tx_buf>
    80004728:	01c0006f          	j	80004744 <uartstart+0x50>
    8000472c:	0006c703          	lbu	a4,0(a3)
    80004730:	00f63023          	sd	a5,0(a2)
    80004734:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004738:	00063783          	ld	a5,0(a2)
    8000473c:	00053703          	ld	a4,0(a0)
    80004740:	00f70e63          	beq	a4,a5,8000475c <uartstart+0x68>
    80004744:	01f7f713          	andi	a4,a5,31
    80004748:	00e806b3          	add	a3,a6,a4
    8000474c:	0055c703          	lbu	a4,5(a1)
    80004750:	00178793          	addi	a5,a5,1
    80004754:	02077713          	andi	a4,a4,32
    80004758:	fc071ae3          	bnez	a4,8000472c <uartstart+0x38>
    8000475c:	00813403          	ld	s0,8(sp)
    80004760:	01010113          	addi	sp,sp,16
    80004764:	00008067          	ret

0000000080004768 <uartgetc>:
    80004768:	ff010113          	addi	sp,sp,-16
    8000476c:	00813423          	sd	s0,8(sp)
    80004770:	01010413          	addi	s0,sp,16
    80004774:	10000737          	lui	a4,0x10000
    80004778:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000477c:	0017f793          	andi	a5,a5,1
    80004780:	00078c63          	beqz	a5,80004798 <uartgetc+0x30>
    80004784:	00074503          	lbu	a0,0(a4)
    80004788:	0ff57513          	andi	a0,a0,255
    8000478c:	00813403          	ld	s0,8(sp)
    80004790:	01010113          	addi	sp,sp,16
    80004794:	00008067          	ret
    80004798:	fff00513          	li	a0,-1
    8000479c:	ff1ff06f          	j	8000478c <uartgetc+0x24>

00000000800047a0 <uartintr>:
    800047a0:	100007b7          	lui	a5,0x10000
    800047a4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800047a8:	0017f793          	andi	a5,a5,1
    800047ac:	0a078463          	beqz	a5,80004854 <uartintr+0xb4>
    800047b0:	fe010113          	addi	sp,sp,-32
    800047b4:	00813823          	sd	s0,16(sp)
    800047b8:	00913423          	sd	s1,8(sp)
    800047bc:	00113c23          	sd	ra,24(sp)
    800047c0:	02010413          	addi	s0,sp,32
    800047c4:	100004b7          	lui	s1,0x10000
    800047c8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800047cc:	0ff57513          	andi	a0,a0,255
    800047d0:	fffff097          	auipc	ra,0xfffff
    800047d4:	534080e7          	jalr	1332(ra) # 80003d04 <consoleintr>
    800047d8:	0054c783          	lbu	a5,5(s1)
    800047dc:	0017f793          	andi	a5,a5,1
    800047e0:	fe0794e3          	bnez	a5,800047c8 <uartintr+0x28>
    800047e4:	00002617          	auipc	a2,0x2
    800047e8:	13c60613          	addi	a2,a2,316 # 80006920 <uart_tx_r>
    800047ec:	00002517          	auipc	a0,0x2
    800047f0:	13c50513          	addi	a0,a0,316 # 80006928 <uart_tx_w>
    800047f4:	00063783          	ld	a5,0(a2)
    800047f8:	00053703          	ld	a4,0(a0)
    800047fc:	04f70263          	beq	a4,a5,80004840 <uartintr+0xa0>
    80004800:	100005b7          	lui	a1,0x10000
    80004804:	00003817          	auipc	a6,0x3
    80004808:	3ac80813          	addi	a6,a6,940 # 80007bb0 <uart_tx_buf>
    8000480c:	01c0006f          	j	80004828 <uartintr+0x88>
    80004810:	0006c703          	lbu	a4,0(a3)
    80004814:	00f63023          	sd	a5,0(a2)
    80004818:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000481c:	00063783          	ld	a5,0(a2)
    80004820:	00053703          	ld	a4,0(a0)
    80004824:	00f70e63          	beq	a4,a5,80004840 <uartintr+0xa0>
    80004828:	01f7f713          	andi	a4,a5,31
    8000482c:	00e806b3          	add	a3,a6,a4
    80004830:	0055c703          	lbu	a4,5(a1)
    80004834:	00178793          	addi	a5,a5,1
    80004838:	02077713          	andi	a4,a4,32
    8000483c:	fc071ae3          	bnez	a4,80004810 <uartintr+0x70>
    80004840:	01813083          	ld	ra,24(sp)
    80004844:	01013403          	ld	s0,16(sp)
    80004848:	00813483          	ld	s1,8(sp)
    8000484c:	02010113          	addi	sp,sp,32
    80004850:	00008067          	ret
    80004854:	00002617          	auipc	a2,0x2
    80004858:	0cc60613          	addi	a2,a2,204 # 80006920 <uart_tx_r>
    8000485c:	00002517          	auipc	a0,0x2
    80004860:	0cc50513          	addi	a0,a0,204 # 80006928 <uart_tx_w>
    80004864:	00063783          	ld	a5,0(a2)
    80004868:	00053703          	ld	a4,0(a0)
    8000486c:	04f70263          	beq	a4,a5,800048b0 <uartintr+0x110>
    80004870:	100005b7          	lui	a1,0x10000
    80004874:	00003817          	auipc	a6,0x3
    80004878:	33c80813          	addi	a6,a6,828 # 80007bb0 <uart_tx_buf>
    8000487c:	01c0006f          	j	80004898 <uartintr+0xf8>
    80004880:	0006c703          	lbu	a4,0(a3)
    80004884:	00f63023          	sd	a5,0(a2)
    80004888:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000488c:	00063783          	ld	a5,0(a2)
    80004890:	00053703          	ld	a4,0(a0)
    80004894:	02f70063          	beq	a4,a5,800048b4 <uartintr+0x114>
    80004898:	01f7f713          	andi	a4,a5,31
    8000489c:	00e806b3          	add	a3,a6,a4
    800048a0:	0055c703          	lbu	a4,5(a1)
    800048a4:	00178793          	addi	a5,a5,1
    800048a8:	02077713          	andi	a4,a4,32
    800048ac:	fc071ae3          	bnez	a4,80004880 <uartintr+0xe0>
    800048b0:	00008067          	ret
    800048b4:	00008067          	ret

00000000800048b8 <kinit>:
    800048b8:	fc010113          	addi	sp,sp,-64
    800048bc:	02913423          	sd	s1,40(sp)
    800048c0:	fffff7b7          	lui	a5,0xfffff
    800048c4:	0000b497          	auipc	s1,0xb
    800048c8:	43b48493          	addi	s1,s1,1083 # 8000fcff <end+0xfff>
    800048cc:	02813823          	sd	s0,48(sp)
    800048d0:	01313c23          	sd	s3,24(sp)
    800048d4:	00f4f4b3          	and	s1,s1,a5
    800048d8:	02113c23          	sd	ra,56(sp)
    800048dc:	03213023          	sd	s2,32(sp)
    800048e0:	01413823          	sd	s4,16(sp)
    800048e4:	01513423          	sd	s5,8(sp)
    800048e8:	04010413          	addi	s0,sp,64
    800048ec:	000017b7          	lui	a5,0x1
    800048f0:	01100993          	li	s3,17
    800048f4:	00f487b3          	add	a5,s1,a5
    800048f8:	01b99993          	slli	s3,s3,0x1b
    800048fc:	06f9e063          	bltu	s3,a5,8000495c <kinit+0xa4>
    80004900:	0000aa97          	auipc	s5,0xa
    80004904:	400a8a93          	addi	s5,s5,1024 # 8000ed00 <end>
    80004908:	0754ec63          	bltu	s1,s5,80004980 <kinit+0xc8>
    8000490c:	0734fa63          	bgeu	s1,s3,80004980 <kinit+0xc8>
    80004910:	00088a37          	lui	s4,0x88
    80004914:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004918:	00002917          	auipc	s2,0x2
    8000491c:	01890913          	addi	s2,s2,24 # 80006930 <kmem>
    80004920:	00ca1a13          	slli	s4,s4,0xc
    80004924:	0140006f          	j	80004938 <kinit+0x80>
    80004928:	000017b7          	lui	a5,0x1
    8000492c:	00f484b3          	add	s1,s1,a5
    80004930:	0554e863          	bltu	s1,s5,80004980 <kinit+0xc8>
    80004934:	0534f663          	bgeu	s1,s3,80004980 <kinit+0xc8>
    80004938:	00001637          	lui	a2,0x1
    8000493c:	00100593          	li	a1,1
    80004940:	00048513          	mv	a0,s1
    80004944:	00000097          	auipc	ra,0x0
    80004948:	5e4080e7          	jalr	1508(ra) # 80004f28 <__memset>
    8000494c:	00093783          	ld	a5,0(s2)
    80004950:	00f4b023          	sd	a5,0(s1)
    80004954:	00993023          	sd	s1,0(s2)
    80004958:	fd4498e3          	bne	s1,s4,80004928 <kinit+0x70>
    8000495c:	03813083          	ld	ra,56(sp)
    80004960:	03013403          	ld	s0,48(sp)
    80004964:	02813483          	ld	s1,40(sp)
    80004968:	02013903          	ld	s2,32(sp)
    8000496c:	01813983          	ld	s3,24(sp)
    80004970:	01013a03          	ld	s4,16(sp)
    80004974:	00813a83          	ld	s5,8(sp)
    80004978:	04010113          	addi	sp,sp,64
    8000497c:	00008067          	ret
    80004980:	00002517          	auipc	a0,0x2
    80004984:	a1850513          	addi	a0,a0,-1512 # 80006398 <digits+0x18>
    80004988:	fffff097          	auipc	ra,0xfffff
    8000498c:	4b4080e7          	jalr	1204(ra) # 80003e3c <panic>

0000000080004990 <freerange>:
    80004990:	fc010113          	addi	sp,sp,-64
    80004994:	000017b7          	lui	a5,0x1
    80004998:	02913423          	sd	s1,40(sp)
    8000499c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800049a0:	009504b3          	add	s1,a0,s1
    800049a4:	fffff537          	lui	a0,0xfffff
    800049a8:	02813823          	sd	s0,48(sp)
    800049ac:	02113c23          	sd	ra,56(sp)
    800049b0:	03213023          	sd	s2,32(sp)
    800049b4:	01313c23          	sd	s3,24(sp)
    800049b8:	01413823          	sd	s4,16(sp)
    800049bc:	01513423          	sd	s5,8(sp)
    800049c0:	01613023          	sd	s6,0(sp)
    800049c4:	04010413          	addi	s0,sp,64
    800049c8:	00a4f4b3          	and	s1,s1,a0
    800049cc:	00f487b3          	add	a5,s1,a5
    800049d0:	06f5e463          	bltu	a1,a5,80004a38 <freerange+0xa8>
    800049d4:	0000aa97          	auipc	s5,0xa
    800049d8:	32ca8a93          	addi	s5,s5,812 # 8000ed00 <end>
    800049dc:	0954e263          	bltu	s1,s5,80004a60 <freerange+0xd0>
    800049e0:	01100993          	li	s3,17
    800049e4:	01b99993          	slli	s3,s3,0x1b
    800049e8:	0734fc63          	bgeu	s1,s3,80004a60 <freerange+0xd0>
    800049ec:	00058a13          	mv	s4,a1
    800049f0:	00002917          	auipc	s2,0x2
    800049f4:	f4090913          	addi	s2,s2,-192 # 80006930 <kmem>
    800049f8:	00002b37          	lui	s6,0x2
    800049fc:	0140006f          	j	80004a10 <freerange+0x80>
    80004a00:	000017b7          	lui	a5,0x1
    80004a04:	00f484b3          	add	s1,s1,a5
    80004a08:	0554ec63          	bltu	s1,s5,80004a60 <freerange+0xd0>
    80004a0c:	0534fa63          	bgeu	s1,s3,80004a60 <freerange+0xd0>
    80004a10:	00001637          	lui	a2,0x1
    80004a14:	00100593          	li	a1,1
    80004a18:	00048513          	mv	a0,s1
    80004a1c:	00000097          	auipc	ra,0x0
    80004a20:	50c080e7          	jalr	1292(ra) # 80004f28 <__memset>
    80004a24:	00093703          	ld	a4,0(s2)
    80004a28:	016487b3          	add	a5,s1,s6
    80004a2c:	00e4b023          	sd	a4,0(s1)
    80004a30:	00993023          	sd	s1,0(s2)
    80004a34:	fcfa76e3          	bgeu	s4,a5,80004a00 <freerange+0x70>
    80004a38:	03813083          	ld	ra,56(sp)
    80004a3c:	03013403          	ld	s0,48(sp)
    80004a40:	02813483          	ld	s1,40(sp)
    80004a44:	02013903          	ld	s2,32(sp)
    80004a48:	01813983          	ld	s3,24(sp)
    80004a4c:	01013a03          	ld	s4,16(sp)
    80004a50:	00813a83          	ld	s5,8(sp)
    80004a54:	00013b03          	ld	s6,0(sp)
    80004a58:	04010113          	addi	sp,sp,64
    80004a5c:	00008067          	ret
    80004a60:	00002517          	auipc	a0,0x2
    80004a64:	93850513          	addi	a0,a0,-1736 # 80006398 <digits+0x18>
    80004a68:	fffff097          	auipc	ra,0xfffff
    80004a6c:	3d4080e7          	jalr	980(ra) # 80003e3c <panic>

0000000080004a70 <kfree>:
    80004a70:	fe010113          	addi	sp,sp,-32
    80004a74:	00813823          	sd	s0,16(sp)
    80004a78:	00113c23          	sd	ra,24(sp)
    80004a7c:	00913423          	sd	s1,8(sp)
    80004a80:	02010413          	addi	s0,sp,32
    80004a84:	03451793          	slli	a5,a0,0x34
    80004a88:	04079c63          	bnez	a5,80004ae0 <kfree+0x70>
    80004a8c:	0000a797          	auipc	a5,0xa
    80004a90:	27478793          	addi	a5,a5,628 # 8000ed00 <end>
    80004a94:	00050493          	mv	s1,a0
    80004a98:	04f56463          	bltu	a0,a5,80004ae0 <kfree+0x70>
    80004a9c:	01100793          	li	a5,17
    80004aa0:	01b79793          	slli	a5,a5,0x1b
    80004aa4:	02f57e63          	bgeu	a0,a5,80004ae0 <kfree+0x70>
    80004aa8:	00001637          	lui	a2,0x1
    80004aac:	00100593          	li	a1,1
    80004ab0:	00000097          	auipc	ra,0x0
    80004ab4:	478080e7          	jalr	1144(ra) # 80004f28 <__memset>
    80004ab8:	00002797          	auipc	a5,0x2
    80004abc:	e7878793          	addi	a5,a5,-392 # 80006930 <kmem>
    80004ac0:	0007b703          	ld	a4,0(a5)
    80004ac4:	01813083          	ld	ra,24(sp)
    80004ac8:	01013403          	ld	s0,16(sp)
    80004acc:	00e4b023          	sd	a4,0(s1)
    80004ad0:	0097b023          	sd	s1,0(a5)
    80004ad4:	00813483          	ld	s1,8(sp)
    80004ad8:	02010113          	addi	sp,sp,32
    80004adc:	00008067          	ret
    80004ae0:	00002517          	auipc	a0,0x2
    80004ae4:	8b850513          	addi	a0,a0,-1864 # 80006398 <digits+0x18>
    80004ae8:	fffff097          	auipc	ra,0xfffff
    80004aec:	354080e7          	jalr	852(ra) # 80003e3c <panic>

0000000080004af0 <kalloc>:
    80004af0:	fe010113          	addi	sp,sp,-32
    80004af4:	00813823          	sd	s0,16(sp)
    80004af8:	00913423          	sd	s1,8(sp)
    80004afc:	00113c23          	sd	ra,24(sp)
    80004b00:	02010413          	addi	s0,sp,32
    80004b04:	00002797          	auipc	a5,0x2
    80004b08:	e2c78793          	addi	a5,a5,-468 # 80006930 <kmem>
    80004b0c:	0007b483          	ld	s1,0(a5)
    80004b10:	02048063          	beqz	s1,80004b30 <kalloc+0x40>
    80004b14:	0004b703          	ld	a4,0(s1)
    80004b18:	00001637          	lui	a2,0x1
    80004b1c:	00500593          	li	a1,5
    80004b20:	00048513          	mv	a0,s1
    80004b24:	00e7b023          	sd	a4,0(a5)
    80004b28:	00000097          	auipc	ra,0x0
    80004b2c:	400080e7          	jalr	1024(ra) # 80004f28 <__memset>
    80004b30:	01813083          	ld	ra,24(sp)
    80004b34:	01013403          	ld	s0,16(sp)
    80004b38:	00048513          	mv	a0,s1
    80004b3c:	00813483          	ld	s1,8(sp)
    80004b40:	02010113          	addi	sp,sp,32
    80004b44:	00008067          	ret

0000000080004b48 <initlock>:
    80004b48:	ff010113          	addi	sp,sp,-16
    80004b4c:	00813423          	sd	s0,8(sp)
    80004b50:	01010413          	addi	s0,sp,16
    80004b54:	00813403          	ld	s0,8(sp)
    80004b58:	00b53423          	sd	a1,8(a0)
    80004b5c:	00052023          	sw	zero,0(a0)
    80004b60:	00053823          	sd	zero,16(a0)
    80004b64:	01010113          	addi	sp,sp,16
    80004b68:	00008067          	ret

0000000080004b6c <acquire>:
    80004b6c:	fe010113          	addi	sp,sp,-32
    80004b70:	00813823          	sd	s0,16(sp)
    80004b74:	00913423          	sd	s1,8(sp)
    80004b78:	00113c23          	sd	ra,24(sp)
    80004b7c:	01213023          	sd	s2,0(sp)
    80004b80:	02010413          	addi	s0,sp,32
    80004b84:	00050493          	mv	s1,a0
    80004b88:	10002973          	csrr	s2,sstatus
    80004b8c:	100027f3          	csrr	a5,sstatus
    80004b90:	ffd7f793          	andi	a5,a5,-3
    80004b94:	10079073          	csrw	sstatus,a5
    80004b98:	fffff097          	auipc	ra,0xfffff
    80004b9c:	8e8080e7          	jalr	-1816(ra) # 80003480 <mycpu>
    80004ba0:	07852783          	lw	a5,120(a0)
    80004ba4:	06078e63          	beqz	a5,80004c20 <acquire+0xb4>
    80004ba8:	fffff097          	auipc	ra,0xfffff
    80004bac:	8d8080e7          	jalr	-1832(ra) # 80003480 <mycpu>
    80004bb0:	07852783          	lw	a5,120(a0)
    80004bb4:	0004a703          	lw	a4,0(s1)
    80004bb8:	0017879b          	addiw	a5,a5,1
    80004bbc:	06f52c23          	sw	a5,120(a0)
    80004bc0:	04071063          	bnez	a4,80004c00 <acquire+0x94>
    80004bc4:	00100713          	li	a4,1
    80004bc8:	00070793          	mv	a5,a4
    80004bcc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004bd0:	0007879b          	sext.w	a5,a5
    80004bd4:	fe079ae3          	bnez	a5,80004bc8 <acquire+0x5c>
    80004bd8:	0ff0000f          	fence
    80004bdc:	fffff097          	auipc	ra,0xfffff
    80004be0:	8a4080e7          	jalr	-1884(ra) # 80003480 <mycpu>
    80004be4:	01813083          	ld	ra,24(sp)
    80004be8:	01013403          	ld	s0,16(sp)
    80004bec:	00a4b823          	sd	a0,16(s1)
    80004bf0:	00013903          	ld	s2,0(sp)
    80004bf4:	00813483          	ld	s1,8(sp)
    80004bf8:	02010113          	addi	sp,sp,32
    80004bfc:	00008067          	ret
    80004c00:	0104b903          	ld	s2,16(s1)
    80004c04:	fffff097          	auipc	ra,0xfffff
    80004c08:	87c080e7          	jalr	-1924(ra) # 80003480 <mycpu>
    80004c0c:	faa91ce3          	bne	s2,a0,80004bc4 <acquire+0x58>
    80004c10:	00001517          	auipc	a0,0x1
    80004c14:	79050513          	addi	a0,a0,1936 # 800063a0 <digits+0x20>
    80004c18:	fffff097          	auipc	ra,0xfffff
    80004c1c:	224080e7          	jalr	548(ra) # 80003e3c <panic>
    80004c20:	00195913          	srli	s2,s2,0x1
    80004c24:	fffff097          	auipc	ra,0xfffff
    80004c28:	85c080e7          	jalr	-1956(ra) # 80003480 <mycpu>
    80004c2c:	00197913          	andi	s2,s2,1
    80004c30:	07252e23          	sw	s2,124(a0)
    80004c34:	f75ff06f          	j	80004ba8 <acquire+0x3c>

0000000080004c38 <release>:
    80004c38:	fe010113          	addi	sp,sp,-32
    80004c3c:	00813823          	sd	s0,16(sp)
    80004c40:	00113c23          	sd	ra,24(sp)
    80004c44:	00913423          	sd	s1,8(sp)
    80004c48:	01213023          	sd	s2,0(sp)
    80004c4c:	02010413          	addi	s0,sp,32
    80004c50:	00052783          	lw	a5,0(a0)
    80004c54:	00079a63          	bnez	a5,80004c68 <release+0x30>
    80004c58:	00001517          	auipc	a0,0x1
    80004c5c:	75050513          	addi	a0,a0,1872 # 800063a8 <digits+0x28>
    80004c60:	fffff097          	auipc	ra,0xfffff
    80004c64:	1dc080e7          	jalr	476(ra) # 80003e3c <panic>
    80004c68:	01053903          	ld	s2,16(a0)
    80004c6c:	00050493          	mv	s1,a0
    80004c70:	fffff097          	auipc	ra,0xfffff
    80004c74:	810080e7          	jalr	-2032(ra) # 80003480 <mycpu>
    80004c78:	fea910e3          	bne	s2,a0,80004c58 <release+0x20>
    80004c7c:	0004b823          	sd	zero,16(s1)
    80004c80:	0ff0000f          	fence
    80004c84:	0f50000f          	fence	iorw,ow
    80004c88:	0804a02f          	amoswap.w	zero,zero,(s1)
    80004c8c:	ffffe097          	auipc	ra,0xffffe
    80004c90:	7f4080e7          	jalr	2036(ra) # 80003480 <mycpu>
    80004c94:	100027f3          	csrr	a5,sstatus
    80004c98:	0027f793          	andi	a5,a5,2
    80004c9c:	04079a63          	bnez	a5,80004cf0 <release+0xb8>
    80004ca0:	07852783          	lw	a5,120(a0)
    80004ca4:	02f05e63          	blez	a5,80004ce0 <release+0xa8>
    80004ca8:	fff7871b          	addiw	a4,a5,-1
    80004cac:	06e52c23          	sw	a4,120(a0)
    80004cb0:	00071c63          	bnez	a4,80004cc8 <release+0x90>
    80004cb4:	07c52783          	lw	a5,124(a0)
    80004cb8:	00078863          	beqz	a5,80004cc8 <release+0x90>
    80004cbc:	100027f3          	csrr	a5,sstatus
    80004cc0:	0027e793          	ori	a5,a5,2
    80004cc4:	10079073          	csrw	sstatus,a5
    80004cc8:	01813083          	ld	ra,24(sp)
    80004ccc:	01013403          	ld	s0,16(sp)
    80004cd0:	00813483          	ld	s1,8(sp)
    80004cd4:	00013903          	ld	s2,0(sp)
    80004cd8:	02010113          	addi	sp,sp,32
    80004cdc:	00008067          	ret
    80004ce0:	00001517          	auipc	a0,0x1
    80004ce4:	6e850513          	addi	a0,a0,1768 # 800063c8 <digits+0x48>
    80004ce8:	fffff097          	auipc	ra,0xfffff
    80004cec:	154080e7          	jalr	340(ra) # 80003e3c <panic>
    80004cf0:	00001517          	auipc	a0,0x1
    80004cf4:	6c050513          	addi	a0,a0,1728 # 800063b0 <digits+0x30>
    80004cf8:	fffff097          	auipc	ra,0xfffff
    80004cfc:	144080e7          	jalr	324(ra) # 80003e3c <panic>

0000000080004d00 <holding>:
    80004d00:	00052783          	lw	a5,0(a0)
    80004d04:	00079663          	bnez	a5,80004d10 <holding+0x10>
    80004d08:	00000513          	li	a0,0
    80004d0c:	00008067          	ret
    80004d10:	fe010113          	addi	sp,sp,-32
    80004d14:	00813823          	sd	s0,16(sp)
    80004d18:	00913423          	sd	s1,8(sp)
    80004d1c:	00113c23          	sd	ra,24(sp)
    80004d20:	02010413          	addi	s0,sp,32
    80004d24:	01053483          	ld	s1,16(a0)
    80004d28:	ffffe097          	auipc	ra,0xffffe
    80004d2c:	758080e7          	jalr	1880(ra) # 80003480 <mycpu>
    80004d30:	01813083          	ld	ra,24(sp)
    80004d34:	01013403          	ld	s0,16(sp)
    80004d38:	40a48533          	sub	a0,s1,a0
    80004d3c:	00153513          	seqz	a0,a0
    80004d40:	00813483          	ld	s1,8(sp)
    80004d44:	02010113          	addi	sp,sp,32
    80004d48:	00008067          	ret

0000000080004d4c <push_off>:
    80004d4c:	fe010113          	addi	sp,sp,-32
    80004d50:	00813823          	sd	s0,16(sp)
    80004d54:	00113c23          	sd	ra,24(sp)
    80004d58:	00913423          	sd	s1,8(sp)
    80004d5c:	02010413          	addi	s0,sp,32
    80004d60:	100024f3          	csrr	s1,sstatus
    80004d64:	100027f3          	csrr	a5,sstatus
    80004d68:	ffd7f793          	andi	a5,a5,-3
    80004d6c:	10079073          	csrw	sstatus,a5
    80004d70:	ffffe097          	auipc	ra,0xffffe
    80004d74:	710080e7          	jalr	1808(ra) # 80003480 <mycpu>
    80004d78:	07852783          	lw	a5,120(a0)
    80004d7c:	02078663          	beqz	a5,80004da8 <push_off+0x5c>
    80004d80:	ffffe097          	auipc	ra,0xffffe
    80004d84:	700080e7          	jalr	1792(ra) # 80003480 <mycpu>
    80004d88:	07852783          	lw	a5,120(a0)
    80004d8c:	01813083          	ld	ra,24(sp)
    80004d90:	01013403          	ld	s0,16(sp)
    80004d94:	0017879b          	addiw	a5,a5,1
    80004d98:	06f52c23          	sw	a5,120(a0)
    80004d9c:	00813483          	ld	s1,8(sp)
    80004da0:	02010113          	addi	sp,sp,32
    80004da4:	00008067          	ret
    80004da8:	0014d493          	srli	s1,s1,0x1
    80004dac:	ffffe097          	auipc	ra,0xffffe
    80004db0:	6d4080e7          	jalr	1748(ra) # 80003480 <mycpu>
    80004db4:	0014f493          	andi	s1,s1,1
    80004db8:	06952e23          	sw	s1,124(a0)
    80004dbc:	fc5ff06f          	j	80004d80 <push_off+0x34>

0000000080004dc0 <pop_off>:
    80004dc0:	ff010113          	addi	sp,sp,-16
    80004dc4:	00813023          	sd	s0,0(sp)
    80004dc8:	00113423          	sd	ra,8(sp)
    80004dcc:	01010413          	addi	s0,sp,16
    80004dd0:	ffffe097          	auipc	ra,0xffffe
    80004dd4:	6b0080e7          	jalr	1712(ra) # 80003480 <mycpu>
    80004dd8:	100027f3          	csrr	a5,sstatus
    80004ddc:	0027f793          	andi	a5,a5,2
    80004de0:	04079663          	bnez	a5,80004e2c <pop_off+0x6c>
    80004de4:	07852783          	lw	a5,120(a0)
    80004de8:	02f05a63          	blez	a5,80004e1c <pop_off+0x5c>
    80004dec:	fff7871b          	addiw	a4,a5,-1
    80004df0:	06e52c23          	sw	a4,120(a0)
    80004df4:	00071c63          	bnez	a4,80004e0c <pop_off+0x4c>
    80004df8:	07c52783          	lw	a5,124(a0)
    80004dfc:	00078863          	beqz	a5,80004e0c <pop_off+0x4c>
    80004e00:	100027f3          	csrr	a5,sstatus
    80004e04:	0027e793          	ori	a5,a5,2
    80004e08:	10079073          	csrw	sstatus,a5
    80004e0c:	00813083          	ld	ra,8(sp)
    80004e10:	00013403          	ld	s0,0(sp)
    80004e14:	01010113          	addi	sp,sp,16
    80004e18:	00008067          	ret
    80004e1c:	00001517          	auipc	a0,0x1
    80004e20:	5ac50513          	addi	a0,a0,1452 # 800063c8 <digits+0x48>
    80004e24:	fffff097          	auipc	ra,0xfffff
    80004e28:	018080e7          	jalr	24(ra) # 80003e3c <panic>
    80004e2c:	00001517          	auipc	a0,0x1
    80004e30:	58450513          	addi	a0,a0,1412 # 800063b0 <digits+0x30>
    80004e34:	fffff097          	auipc	ra,0xfffff
    80004e38:	008080e7          	jalr	8(ra) # 80003e3c <panic>

0000000080004e3c <push_on>:
    80004e3c:	fe010113          	addi	sp,sp,-32
    80004e40:	00813823          	sd	s0,16(sp)
    80004e44:	00113c23          	sd	ra,24(sp)
    80004e48:	00913423          	sd	s1,8(sp)
    80004e4c:	02010413          	addi	s0,sp,32
    80004e50:	100024f3          	csrr	s1,sstatus
    80004e54:	100027f3          	csrr	a5,sstatus
    80004e58:	0027e793          	ori	a5,a5,2
    80004e5c:	10079073          	csrw	sstatus,a5
    80004e60:	ffffe097          	auipc	ra,0xffffe
    80004e64:	620080e7          	jalr	1568(ra) # 80003480 <mycpu>
    80004e68:	07852783          	lw	a5,120(a0)
    80004e6c:	02078663          	beqz	a5,80004e98 <push_on+0x5c>
    80004e70:	ffffe097          	auipc	ra,0xffffe
    80004e74:	610080e7          	jalr	1552(ra) # 80003480 <mycpu>
    80004e78:	07852783          	lw	a5,120(a0)
    80004e7c:	01813083          	ld	ra,24(sp)
    80004e80:	01013403          	ld	s0,16(sp)
    80004e84:	0017879b          	addiw	a5,a5,1
    80004e88:	06f52c23          	sw	a5,120(a0)
    80004e8c:	00813483          	ld	s1,8(sp)
    80004e90:	02010113          	addi	sp,sp,32
    80004e94:	00008067          	ret
    80004e98:	0014d493          	srli	s1,s1,0x1
    80004e9c:	ffffe097          	auipc	ra,0xffffe
    80004ea0:	5e4080e7          	jalr	1508(ra) # 80003480 <mycpu>
    80004ea4:	0014f493          	andi	s1,s1,1
    80004ea8:	06952e23          	sw	s1,124(a0)
    80004eac:	fc5ff06f          	j	80004e70 <push_on+0x34>

0000000080004eb0 <pop_on>:
    80004eb0:	ff010113          	addi	sp,sp,-16
    80004eb4:	00813023          	sd	s0,0(sp)
    80004eb8:	00113423          	sd	ra,8(sp)
    80004ebc:	01010413          	addi	s0,sp,16
    80004ec0:	ffffe097          	auipc	ra,0xffffe
    80004ec4:	5c0080e7          	jalr	1472(ra) # 80003480 <mycpu>
    80004ec8:	100027f3          	csrr	a5,sstatus
    80004ecc:	0027f793          	andi	a5,a5,2
    80004ed0:	04078463          	beqz	a5,80004f18 <pop_on+0x68>
    80004ed4:	07852783          	lw	a5,120(a0)
    80004ed8:	02f05863          	blez	a5,80004f08 <pop_on+0x58>
    80004edc:	fff7879b          	addiw	a5,a5,-1
    80004ee0:	06f52c23          	sw	a5,120(a0)
    80004ee4:	07853783          	ld	a5,120(a0)
    80004ee8:	00079863          	bnez	a5,80004ef8 <pop_on+0x48>
    80004eec:	100027f3          	csrr	a5,sstatus
    80004ef0:	ffd7f793          	andi	a5,a5,-3
    80004ef4:	10079073          	csrw	sstatus,a5
    80004ef8:	00813083          	ld	ra,8(sp)
    80004efc:	00013403          	ld	s0,0(sp)
    80004f00:	01010113          	addi	sp,sp,16
    80004f04:	00008067          	ret
    80004f08:	00001517          	auipc	a0,0x1
    80004f0c:	4e850513          	addi	a0,a0,1256 # 800063f0 <digits+0x70>
    80004f10:	fffff097          	auipc	ra,0xfffff
    80004f14:	f2c080e7          	jalr	-212(ra) # 80003e3c <panic>
    80004f18:	00001517          	auipc	a0,0x1
    80004f1c:	4b850513          	addi	a0,a0,1208 # 800063d0 <digits+0x50>
    80004f20:	fffff097          	auipc	ra,0xfffff
    80004f24:	f1c080e7          	jalr	-228(ra) # 80003e3c <panic>

0000000080004f28 <__memset>:
    80004f28:	ff010113          	addi	sp,sp,-16
    80004f2c:	00813423          	sd	s0,8(sp)
    80004f30:	01010413          	addi	s0,sp,16
    80004f34:	1a060e63          	beqz	a2,800050f0 <__memset+0x1c8>
    80004f38:	40a007b3          	neg	a5,a0
    80004f3c:	0077f793          	andi	a5,a5,7
    80004f40:	00778693          	addi	a3,a5,7
    80004f44:	00b00813          	li	a6,11
    80004f48:	0ff5f593          	andi	a1,a1,255
    80004f4c:	fff6071b          	addiw	a4,a2,-1
    80004f50:	1b06e663          	bltu	a3,a6,800050fc <__memset+0x1d4>
    80004f54:	1cd76463          	bltu	a4,a3,8000511c <__memset+0x1f4>
    80004f58:	1a078e63          	beqz	a5,80005114 <__memset+0x1ec>
    80004f5c:	00b50023          	sb	a1,0(a0)
    80004f60:	00100713          	li	a4,1
    80004f64:	1ae78463          	beq	a5,a4,8000510c <__memset+0x1e4>
    80004f68:	00b500a3          	sb	a1,1(a0)
    80004f6c:	00200713          	li	a4,2
    80004f70:	1ae78a63          	beq	a5,a4,80005124 <__memset+0x1fc>
    80004f74:	00b50123          	sb	a1,2(a0)
    80004f78:	00300713          	li	a4,3
    80004f7c:	18e78463          	beq	a5,a4,80005104 <__memset+0x1dc>
    80004f80:	00b501a3          	sb	a1,3(a0)
    80004f84:	00400713          	li	a4,4
    80004f88:	1ae78263          	beq	a5,a4,8000512c <__memset+0x204>
    80004f8c:	00b50223          	sb	a1,4(a0)
    80004f90:	00500713          	li	a4,5
    80004f94:	1ae78063          	beq	a5,a4,80005134 <__memset+0x20c>
    80004f98:	00b502a3          	sb	a1,5(a0)
    80004f9c:	00700713          	li	a4,7
    80004fa0:	18e79e63          	bne	a5,a4,8000513c <__memset+0x214>
    80004fa4:	00b50323          	sb	a1,6(a0)
    80004fa8:	00700e93          	li	t4,7
    80004fac:	00859713          	slli	a4,a1,0x8
    80004fb0:	00e5e733          	or	a4,a1,a4
    80004fb4:	01059e13          	slli	t3,a1,0x10
    80004fb8:	01c76e33          	or	t3,a4,t3
    80004fbc:	01859313          	slli	t1,a1,0x18
    80004fc0:	006e6333          	or	t1,t3,t1
    80004fc4:	02059893          	slli	a7,a1,0x20
    80004fc8:	40f60e3b          	subw	t3,a2,a5
    80004fcc:	011368b3          	or	a7,t1,a7
    80004fd0:	02859813          	slli	a6,a1,0x28
    80004fd4:	0108e833          	or	a6,a7,a6
    80004fd8:	03059693          	slli	a3,a1,0x30
    80004fdc:	003e589b          	srliw	a7,t3,0x3
    80004fe0:	00d866b3          	or	a3,a6,a3
    80004fe4:	03859713          	slli	a4,a1,0x38
    80004fe8:	00389813          	slli	a6,a7,0x3
    80004fec:	00f507b3          	add	a5,a0,a5
    80004ff0:	00e6e733          	or	a4,a3,a4
    80004ff4:	000e089b          	sext.w	a7,t3
    80004ff8:	00f806b3          	add	a3,a6,a5
    80004ffc:	00e7b023          	sd	a4,0(a5)
    80005000:	00878793          	addi	a5,a5,8
    80005004:	fed79ce3          	bne	a5,a3,80004ffc <__memset+0xd4>
    80005008:	ff8e7793          	andi	a5,t3,-8
    8000500c:	0007871b          	sext.w	a4,a5
    80005010:	01d787bb          	addw	a5,a5,t4
    80005014:	0ce88e63          	beq	a7,a4,800050f0 <__memset+0x1c8>
    80005018:	00f50733          	add	a4,a0,a5
    8000501c:	00b70023          	sb	a1,0(a4)
    80005020:	0017871b          	addiw	a4,a5,1
    80005024:	0cc77663          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005028:	00e50733          	add	a4,a0,a4
    8000502c:	00b70023          	sb	a1,0(a4)
    80005030:	0027871b          	addiw	a4,a5,2
    80005034:	0ac77e63          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005038:	00e50733          	add	a4,a0,a4
    8000503c:	00b70023          	sb	a1,0(a4)
    80005040:	0037871b          	addiw	a4,a5,3
    80005044:	0ac77663          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005048:	00e50733          	add	a4,a0,a4
    8000504c:	00b70023          	sb	a1,0(a4)
    80005050:	0047871b          	addiw	a4,a5,4
    80005054:	08c77e63          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005058:	00e50733          	add	a4,a0,a4
    8000505c:	00b70023          	sb	a1,0(a4)
    80005060:	0057871b          	addiw	a4,a5,5
    80005064:	08c77663          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005068:	00e50733          	add	a4,a0,a4
    8000506c:	00b70023          	sb	a1,0(a4)
    80005070:	0067871b          	addiw	a4,a5,6
    80005074:	06c77e63          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005078:	00e50733          	add	a4,a0,a4
    8000507c:	00b70023          	sb	a1,0(a4)
    80005080:	0077871b          	addiw	a4,a5,7
    80005084:	06c77663          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005088:	00e50733          	add	a4,a0,a4
    8000508c:	00b70023          	sb	a1,0(a4)
    80005090:	0087871b          	addiw	a4,a5,8
    80005094:	04c77e63          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    80005098:	00e50733          	add	a4,a0,a4
    8000509c:	00b70023          	sb	a1,0(a4)
    800050a0:	0097871b          	addiw	a4,a5,9
    800050a4:	04c77663          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    800050a8:	00e50733          	add	a4,a0,a4
    800050ac:	00b70023          	sb	a1,0(a4)
    800050b0:	00a7871b          	addiw	a4,a5,10
    800050b4:	02c77e63          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    800050b8:	00e50733          	add	a4,a0,a4
    800050bc:	00b70023          	sb	a1,0(a4)
    800050c0:	00b7871b          	addiw	a4,a5,11
    800050c4:	02c77663          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    800050c8:	00e50733          	add	a4,a0,a4
    800050cc:	00b70023          	sb	a1,0(a4)
    800050d0:	00c7871b          	addiw	a4,a5,12
    800050d4:	00c77e63          	bgeu	a4,a2,800050f0 <__memset+0x1c8>
    800050d8:	00e50733          	add	a4,a0,a4
    800050dc:	00b70023          	sb	a1,0(a4)
    800050e0:	00d7879b          	addiw	a5,a5,13
    800050e4:	00c7f663          	bgeu	a5,a2,800050f0 <__memset+0x1c8>
    800050e8:	00f507b3          	add	a5,a0,a5
    800050ec:	00b78023          	sb	a1,0(a5)
    800050f0:	00813403          	ld	s0,8(sp)
    800050f4:	01010113          	addi	sp,sp,16
    800050f8:	00008067          	ret
    800050fc:	00b00693          	li	a3,11
    80005100:	e55ff06f          	j	80004f54 <__memset+0x2c>
    80005104:	00300e93          	li	t4,3
    80005108:	ea5ff06f          	j	80004fac <__memset+0x84>
    8000510c:	00100e93          	li	t4,1
    80005110:	e9dff06f          	j	80004fac <__memset+0x84>
    80005114:	00000e93          	li	t4,0
    80005118:	e95ff06f          	j	80004fac <__memset+0x84>
    8000511c:	00000793          	li	a5,0
    80005120:	ef9ff06f          	j	80005018 <__memset+0xf0>
    80005124:	00200e93          	li	t4,2
    80005128:	e85ff06f          	j	80004fac <__memset+0x84>
    8000512c:	00400e93          	li	t4,4
    80005130:	e7dff06f          	j	80004fac <__memset+0x84>
    80005134:	00500e93          	li	t4,5
    80005138:	e75ff06f          	j	80004fac <__memset+0x84>
    8000513c:	00600e93          	li	t4,6
    80005140:	e6dff06f          	j	80004fac <__memset+0x84>

0000000080005144 <__memmove>:
    80005144:	ff010113          	addi	sp,sp,-16
    80005148:	00813423          	sd	s0,8(sp)
    8000514c:	01010413          	addi	s0,sp,16
    80005150:	0e060863          	beqz	a2,80005240 <__memmove+0xfc>
    80005154:	fff6069b          	addiw	a3,a2,-1
    80005158:	0006881b          	sext.w	a6,a3
    8000515c:	0ea5e863          	bltu	a1,a0,8000524c <__memmove+0x108>
    80005160:	00758713          	addi	a4,a1,7
    80005164:	00a5e7b3          	or	a5,a1,a0
    80005168:	40a70733          	sub	a4,a4,a0
    8000516c:	0077f793          	andi	a5,a5,7
    80005170:	00f73713          	sltiu	a4,a4,15
    80005174:	00174713          	xori	a4,a4,1
    80005178:	0017b793          	seqz	a5,a5
    8000517c:	00e7f7b3          	and	a5,a5,a4
    80005180:	10078863          	beqz	a5,80005290 <__memmove+0x14c>
    80005184:	00900793          	li	a5,9
    80005188:	1107f463          	bgeu	a5,a6,80005290 <__memmove+0x14c>
    8000518c:	0036581b          	srliw	a6,a2,0x3
    80005190:	fff8081b          	addiw	a6,a6,-1
    80005194:	02081813          	slli	a6,a6,0x20
    80005198:	01d85893          	srli	a7,a6,0x1d
    8000519c:	00858813          	addi	a6,a1,8
    800051a0:	00058793          	mv	a5,a1
    800051a4:	00050713          	mv	a4,a0
    800051a8:	01088833          	add	a6,a7,a6
    800051ac:	0007b883          	ld	a7,0(a5)
    800051b0:	00878793          	addi	a5,a5,8
    800051b4:	00870713          	addi	a4,a4,8
    800051b8:	ff173c23          	sd	a7,-8(a4)
    800051bc:	ff0798e3          	bne	a5,a6,800051ac <__memmove+0x68>
    800051c0:	ff867713          	andi	a4,a2,-8
    800051c4:	02071793          	slli	a5,a4,0x20
    800051c8:	0207d793          	srli	a5,a5,0x20
    800051cc:	00f585b3          	add	a1,a1,a5
    800051d0:	40e686bb          	subw	a3,a3,a4
    800051d4:	00f507b3          	add	a5,a0,a5
    800051d8:	06e60463          	beq	a2,a4,80005240 <__memmove+0xfc>
    800051dc:	0005c703          	lbu	a4,0(a1)
    800051e0:	00e78023          	sb	a4,0(a5)
    800051e4:	04068e63          	beqz	a3,80005240 <__memmove+0xfc>
    800051e8:	0015c603          	lbu	a2,1(a1)
    800051ec:	00100713          	li	a4,1
    800051f0:	00c780a3          	sb	a2,1(a5)
    800051f4:	04e68663          	beq	a3,a4,80005240 <__memmove+0xfc>
    800051f8:	0025c603          	lbu	a2,2(a1)
    800051fc:	00200713          	li	a4,2
    80005200:	00c78123          	sb	a2,2(a5)
    80005204:	02e68e63          	beq	a3,a4,80005240 <__memmove+0xfc>
    80005208:	0035c603          	lbu	a2,3(a1)
    8000520c:	00300713          	li	a4,3
    80005210:	00c781a3          	sb	a2,3(a5)
    80005214:	02e68663          	beq	a3,a4,80005240 <__memmove+0xfc>
    80005218:	0045c603          	lbu	a2,4(a1)
    8000521c:	00400713          	li	a4,4
    80005220:	00c78223          	sb	a2,4(a5)
    80005224:	00e68e63          	beq	a3,a4,80005240 <__memmove+0xfc>
    80005228:	0055c603          	lbu	a2,5(a1)
    8000522c:	00500713          	li	a4,5
    80005230:	00c782a3          	sb	a2,5(a5)
    80005234:	00e68663          	beq	a3,a4,80005240 <__memmove+0xfc>
    80005238:	0065c703          	lbu	a4,6(a1)
    8000523c:	00e78323          	sb	a4,6(a5)
    80005240:	00813403          	ld	s0,8(sp)
    80005244:	01010113          	addi	sp,sp,16
    80005248:	00008067          	ret
    8000524c:	02061713          	slli	a4,a2,0x20
    80005250:	02075713          	srli	a4,a4,0x20
    80005254:	00e587b3          	add	a5,a1,a4
    80005258:	f0f574e3          	bgeu	a0,a5,80005160 <__memmove+0x1c>
    8000525c:	02069613          	slli	a2,a3,0x20
    80005260:	02065613          	srli	a2,a2,0x20
    80005264:	fff64613          	not	a2,a2
    80005268:	00e50733          	add	a4,a0,a4
    8000526c:	00c78633          	add	a2,a5,a2
    80005270:	fff7c683          	lbu	a3,-1(a5)
    80005274:	fff78793          	addi	a5,a5,-1
    80005278:	fff70713          	addi	a4,a4,-1
    8000527c:	00d70023          	sb	a3,0(a4)
    80005280:	fec798e3          	bne	a5,a2,80005270 <__memmove+0x12c>
    80005284:	00813403          	ld	s0,8(sp)
    80005288:	01010113          	addi	sp,sp,16
    8000528c:	00008067          	ret
    80005290:	02069713          	slli	a4,a3,0x20
    80005294:	02075713          	srli	a4,a4,0x20
    80005298:	00170713          	addi	a4,a4,1
    8000529c:	00e50733          	add	a4,a0,a4
    800052a0:	00050793          	mv	a5,a0
    800052a4:	0005c683          	lbu	a3,0(a1)
    800052a8:	00178793          	addi	a5,a5,1
    800052ac:	00158593          	addi	a1,a1,1
    800052b0:	fed78fa3          	sb	a3,-1(a5)
    800052b4:	fee798e3          	bne	a5,a4,800052a4 <__memmove+0x160>
    800052b8:	f89ff06f          	j	80005240 <__memmove+0xfc>
	...

Disassembly of section .kernel:

0000000080008900 <_ZN5RiscV14supervisorTrapEv-0x700>:
	...

0000000080009000 <_ZN5RiscV14supervisorTrapEv>:
.global _ZN5RiscV14supervisorTrapEv
_ZN5RiscV14supervisorTrapEv:

    #push all registers to stack

    addi sp, sp, -256
    80009000:	f0010113          	addi	sp,sp,-256
    csrw sscratch, sp
    80009004:	14011073          	csrw	sscratch,sp
    .irp index 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 //ommit x10 as it is reserved for return values from function
    sd x\index, \index * 8(sp)
    .endr
    80009008:	00013023          	sd	zero,0(sp)
    8000900c:	00113423          	sd	ra,8(sp)
    80009010:	00213823          	sd	sp,16(sp)
    80009014:	00313c23          	sd	gp,24(sp)
    80009018:	02413023          	sd	tp,32(sp)
    8000901c:	02513423          	sd	t0,40(sp)
    80009020:	02613823          	sd	t1,48(sp)
    80009024:	02713c23          	sd	t2,56(sp)
    80009028:	04813023          	sd	s0,64(sp)
    8000902c:	04913423          	sd	s1,72(sp)
    80009030:	04a13823          	sd	a0,80(sp)
    80009034:	04b13c23          	sd	a1,88(sp)
    80009038:	06c13023          	sd	a2,96(sp)
    8000903c:	06d13423          	sd	a3,104(sp)
    80009040:	06e13823          	sd	a4,112(sp)
    80009044:	06f13c23          	sd	a5,120(sp)
    80009048:	09013023          	sd	a6,128(sp)
    8000904c:	09113423          	sd	a7,136(sp)
    80009050:	09213823          	sd	s2,144(sp)
    80009054:	09313c23          	sd	s3,152(sp)
    80009058:	0b413023          	sd	s4,160(sp)
    8000905c:	0b513423          	sd	s5,168(sp)
    80009060:	0b613823          	sd	s6,176(sp)
    80009064:	0b713c23          	sd	s7,184(sp)
    80009068:	0d813023          	sd	s8,192(sp)
    8000906c:	0d913423          	sd	s9,200(sp)
    80009070:	0da13823          	sd	s10,208(sp)
    80009074:	0db13c23          	sd	s11,216(sp)
    80009078:	0fc13023          	sd	t3,224(sp)
    8000907c:	0fd13423          	sd	t4,232(sp)
    80009080:	0fe13823          	sd	t5,240(sp)
    80009084:	0ff13c23          	sd	t6,248(sp)

    #call trap handler
    call _ZN5RiscV20handleSupervisorTrapEv // call handleSupervisorTrap()
    80009088:	138030ef          	jal	ra,8000c1c0 <_ZN5RiscV20handleSupervisorTrapEv>

    #pop all registers from stack

    .irp index 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    8000908c:	00013003          	ld	zero,0(sp)
    80009090:	00813083          	ld	ra,8(sp)
    80009094:	01013103          	ld	sp,16(sp)
    80009098:	01813183          	ld	gp,24(sp)
    8000909c:	02013203          	ld	tp,32(sp)
    800090a0:	02813283          	ld	t0,40(sp)
    800090a4:	03013303          	ld	t1,48(sp)
    800090a8:	03813383          	ld	t2,56(sp)
    800090ac:	04013403          	ld	s0,64(sp)
    800090b0:	04813483          	ld	s1,72(sp)
    800090b4:	05013503          	ld	a0,80(sp)
    800090b8:	05813583          	ld	a1,88(sp)
    800090bc:	06013603          	ld	a2,96(sp)
    800090c0:	06813683          	ld	a3,104(sp)
    800090c4:	07013703          	ld	a4,112(sp)
    800090c8:	07813783          	ld	a5,120(sp)
    800090cc:	08013803          	ld	a6,128(sp)
    800090d0:	08813883          	ld	a7,136(sp)
    800090d4:	09013903          	ld	s2,144(sp)
    800090d8:	09813983          	ld	s3,152(sp)
    800090dc:	0a013a03          	ld	s4,160(sp)
    800090e0:	0a813a83          	ld	s5,168(sp)
    800090e4:	0b013b03          	ld	s6,176(sp)
    800090e8:	0b813b83          	ld	s7,184(sp)
    800090ec:	0c013c03          	ld	s8,192(sp)
    800090f0:	0c813c83          	ld	s9,200(sp)
    800090f4:	0d013d03          	ld	s10,208(sp)
    800090f8:	0d813d83          	ld	s11,216(sp)
    800090fc:	0e013e03          	ld	t3,224(sp)
    80009100:	0e813e83          	ld	t4,232(sp)
    80009104:	0f013f03          	ld	t5,240(sp)
    80009108:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000910c:	10010113          	addi	sp,sp,256

    80009110:	10200073          	sret
	...

0000000080009120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function

_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd sp, 0*8(a0)
    80009120:	00253023          	sd	sp,0(a0)
    sd ra, 1*8(a0)
    80009124:	00153423          	sd	ra,8(a0)

    ld sp, 0*8(a1)
    80009128:	0005b103          	ld	sp,0(a1)
    ld ra, 1*8(a1)
    8000912c:	0085b083          	ld	ra,8(a1)

    80009130:	00008067          	ret

0000000080009134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    80009134:	fe010113          	addi	sp,sp,-32
    80009138:	00113c23          	sd	ra,24(sp)
    8000913c:	00813823          	sd	s0,16(sp)
    80009140:	00913423          	sd	s1,8(sp)
    80009144:	01213023          	sd	s2,0(sp)
    80009148:	02010413          	addi	s0,sp,32
    8000914c:	00050493          	mv	s1,a0
    int ret = 0;
    80009150:	00000913          	li	s2,0
    while(cache->emptyHead){
    80009154:	0604b503          	ld	a0,96(s1)
    80009158:	02050463          	beqz	a0,80009180 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x4c>
        Buddy::free(cache->emptyHead, cache->slabSize);
    8000915c:	0484b583          	ld	a1,72(s1)
    80009160:	00001097          	auipc	ra,0x1
    80009164:	3d4080e7          	jalr	980(ra) # 8000a534 <_ZN5Buddy4freeEPvm>
        ret += cache->emptyHead->totalNumOfSlots;
    80009168:	0604b783          	ld	a5,96(s1)
    8000916c:	0187b703          	ld	a4,24(a5)
    80009170:	0127093b          	addw	s2,a4,s2
        cache->emptyHead = cache->emptyHead->next;
    80009174:	0087b783          	ld	a5,8(a5)
    80009178:	06f4b023          	sd	a5,96(s1)
    while(cache->emptyHead){
    8000917c:	fd9ff06f          	j	80009154 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x20>
    }
    return ret;
}
    80009180:	00090513          	mv	a0,s2
    80009184:	01813083          	ld	ra,24(sp)
    80009188:	01013403          	ld	s0,16(sp)
    8000918c:	00813483          	ld	s1,8(sp)
    80009190:	00013903          	ld	s2,0(sp)
    80009194:	02010113          	addi	sp,sp,32
    80009198:	00008067          	ret

000000008000919c <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    8000919c:	14050e63          	beqz	a0,800092f8 <_ZN13SlabAllocator9printSlabEP4Slab+0x15c>
void SlabAllocator::printSlab(Slab *slab) {
    800091a0:	fe010113          	addi	sp,sp,-32
    800091a4:	00113c23          	sd	ra,24(sp)
    800091a8:	00813823          	sd	s0,16(sp)
    800091ac:	00913423          	sd	s1,8(sp)
    800091b0:	01213023          	sd	s2,0(sp)
    800091b4:	02010413          	addi	s0,sp,32
    800091b8:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800091bc:	01000693          	li	a3,16
    800091c0:	00004617          	auipc	a2,0x4
    800091c4:	05060613          	addi	a2,a2,80 # 8000d210 <kernelDataStart+0x37c>
    800091c8:	0005059b          	sext.w	a1,a0
    800091cc:	00004517          	auipc	a0,0x4
    800091d0:	ccc50513          	addi	a0,a0,-820 # 8000ce98 <kernelDataStart+0x4>
    800091d4:	00004097          	auipc	ra,0x4
    800091d8:	abc080e7          	jalr	-1348(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800091dc:	01000693          	li	a3,16
    800091e0:	00004617          	auipc	a2,0x4
    800091e4:	03060613          	addi	a2,a2,48 # 8000d210 <kernelDataStart+0x37c>
    800091e8:	01892583          	lw	a1,24(s2)
    800091ec:	00004517          	auipc	a0,0x4
    800091f0:	cbc50513          	addi	a0,a0,-836 # 8000cea8 <kernelDataStart+0x14>
    800091f4:	00004097          	auipc	ra,0x4
    800091f8:	a9c080e7          	jalr	-1380(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    800091fc:	01000693          	li	a3,16
    80009200:	00004617          	auipc	a2,0x4
    80009204:	01060613          	addi	a2,a2,16 # 8000d210 <kernelDataStart+0x37c>
    80009208:	01092583          	lw	a1,16(s2)
    8000920c:	00004517          	auipc	a0,0x4
    80009210:	cb450513          	addi	a0,a0,-844 # 8000cec0 <kernelDataStart+0x2c>
    80009214:	00004097          	auipc	ra,0x4
    80009218:	a7c080e7          	jalr	-1412(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000921c:	01000693          	li	a3,16
    80009220:	00004617          	auipc	a2,0x4
    80009224:	ff060613          	addi	a2,a2,-16 # 8000d210 <kernelDataStart+0x37c>
    80009228:	03800593          	li	a1,56
    8000922c:	00004517          	auipc	a0,0x4
    80009230:	cac50513          	addi	a0,a0,-852 # 8000ced8 <kernelDataStart+0x44>
    80009234:	00004097          	auipc	ra,0x4
    80009238:	a5c080e7          	jalr	-1444(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000923c:	01000693          	li	a3,16
    80009240:	00004617          	auipc	a2,0x4
    80009244:	fd060613          	addi	a2,a2,-48 # 8000d210 <kernelDataStart+0x37c>
    80009248:	02892583          	lw	a1,40(s2)
    8000924c:	00004517          	auipc	a0,0x4
    80009250:	ca450513          	addi	a0,a0,-860 # 8000cef0 <kernelDataStart+0x5c>
    80009254:	00004097          	auipc	ra,0x4
    80009258:	a3c080e7          	jalr	-1476(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000925c:	01000693          	li	a3,16
    80009260:	00004617          	auipc	a2,0x4
    80009264:	fb060613          	addi	a2,a2,-80 # 8000d210 <kernelDataStart+0x37c>
    80009268:	02092583          	lw	a1,32(s2)
    8000926c:	00004517          	auipc	a0,0x4
    80009270:	c9450513          	addi	a0,a0,-876 # 8000cf00 <kernelDataStart+0x6c>
    80009274:	00004097          	auipc	ra,0x4
    80009278:	a1c080e7          	jalr	-1508(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000927c:	00004517          	auipc	a0,0x4
    80009280:	ca450513          	addi	a0,a0,-860 # 8000cf20 <kernelDataStart+0x8c>
    80009284:	00004097          	auipc	ra,0x4
    80009288:	8ec080e7          	jalr	-1812(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    8000928c:	00000493          	li	s1,0
    80009290:	0300006f          	j	800092c0 <_ZN13SlabAllocator9printSlabEP4Slab+0x124>
            ConsoleUtil::print("", slab->allocated[i], " ");
    80009294:	02093783          	ld	a5,32(s2)
    80009298:	009787b3          	add	a5,a5,s1
    8000929c:	01000693          	li	a3,16
    800092a0:	00004617          	auipc	a2,0x4
    800092a4:	cc060613          	addi	a2,a2,-832 # 8000cf60 <kernelDataStart+0xcc>
    800092a8:	0007c583          	lbu	a1,0(a5)
    800092ac:	00004517          	auipc	a0,0x4
    800092b0:	fc450513          	addi	a0,a0,-60 # 8000d270 <kernelDataStart+0x3dc>
    800092b4:	00004097          	auipc	ra,0x4
    800092b8:	9dc080e7          	jalr	-1572(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800092bc:	00148493          	addi	s1,s1,1
    800092c0:	01893783          	ld	a5,24(s2)
    800092c4:	0037d793          	srli	a5,a5,0x3
    800092c8:	00178793          	addi	a5,a5,1
    800092cc:	fcf4e4e3          	bltu	s1,a5,80009294 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800092d0:	00004517          	auipc	a0,0x4
    800092d4:	f4050513          	addi	a0,a0,-192 # 8000d210 <kernelDataStart+0x37c>
    800092d8:	00004097          	auipc	ra,0x4
    800092dc:	898080e7          	jalr	-1896(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800092e0:	01813083          	ld	ra,24(sp)
    800092e4:	01013403          	ld	s0,16(sp)
    800092e8:	00813483          	ld	s1,8(sp)
    800092ec:	00013903          	ld	s2,0(sp)
    800092f0:	02010113          	addi	sp,sp,32
    800092f4:	00008067          	ret
    800092f8:	00008067          	ret

00000000800092fc <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800092fc:	fe010113          	addi	sp,sp,-32
    80009300:	00113c23          	sd	ra,24(sp)
    80009304:	00813823          	sd	s0,16(sp)
    80009308:	00913423          	sd	s1,8(sp)
    8000930c:	01213023          	sd	s2,0(sp)
    80009310:	02010413          	addi	s0,sp,32
    80009314:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    80009318:	00004517          	auipc	a0,0x4
    8000931c:	c2850513          	addi	a0,a0,-984 # 8000cf40 <kernelDataStart+0xac>
    80009320:	00004097          	auipc	ra,0x4
    80009324:	850080e7          	jalr	-1968(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80009328:	00090513          	mv	a0,s2
    8000932c:	00004097          	auipc	ra,0x4
    80009330:	844080e7          	jalr	-1980(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80009334:	00004517          	auipc	a0,0x4
    80009338:	edc50513          	addi	a0,a0,-292 # 8000d210 <kernelDataStart+0x37c>
    8000933c:	00004097          	auipc	ra,0x4
    80009340:	834080e7          	jalr	-1996(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80009344:	01000693          	li	a3,16
    80009348:	00004617          	auipc	a2,0x4
    8000934c:	ec860613          	addi	a2,a2,-312 # 8000d210 <kernelDataStart+0x37c>
    80009350:	ffffd797          	auipc	a5,0xffffd
    80009354:	4e07b783          	ld	a5,1248(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    80009358:	0007a583          	lw	a1,0(a5)
    8000935c:	00004517          	auipc	a0,0x4
    80009360:	bf450513          	addi	a0,a0,-1036 # 8000cf50 <kernelDataStart+0xbc>
    80009364:	00004097          	auipc	ra,0x4
    80009368:	92c080e7          	jalr	-1748(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000936c:	01000693          	li	a3,16
    80009370:	00004617          	auipc	a2,0x4
    80009374:	ea060613          	addi	a2,a2,-352 # 8000d210 <kernelDataStart+0x37c>
    80009378:	0009059b          	sext.w	a1,s2
    8000937c:	00004517          	auipc	a0,0x4
    80009380:	bec50513          	addi	a0,a0,-1044 # 8000cf68 <kernelDataStart+0xd4>
    80009384:	00004097          	auipc	ra,0x4
    80009388:	90c080e7          	jalr	-1780(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    8000938c:	01000693          	li	a3,16
    80009390:	00004617          	auipc	a2,0x4
    80009394:	e8060613          	addi	a2,a2,-384 # 8000d210 <kernelDataStart+0x37c>
    80009398:	04892583          	lw	a1,72(s2)
    8000939c:	00004517          	auipc	a0,0x4
    800093a0:	bdc50513          	addi	a0,a0,-1060 # 8000cf78 <kernelDataStart+0xe4>
    800093a4:	00004097          	auipc	ra,0x4
    800093a8:	8ec080e7          	jalr	-1812(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800093ac:	01000693          	li	a3,16
    800093b0:	00004617          	auipc	a2,0x4
    800093b4:	e6060613          	addi	a2,a2,-416 # 8000d210 <kernelDataStart+0x37c>
    800093b8:	04092583          	lw	a1,64(s2)
    800093bc:	00004517          	auipc	a0,0x4
    800093c0:	bd450513          	addi	a0,a0,-1068 # 8000cf90 <kernelDataStart+0xfc>
    800093c4:	00004097          	auipc	ra,0x4
    800093c8:	8cc080e7          	jalr	-1844(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800093cc:	01000693          	li	a3,16
    800093d0:	00004617          	auipc	a2,0x4
    800093d4:	e4060613          	addi	a2,a2,-448 # 8000d210 <kernelDataStart+0x37c>
    800093d8:	06092583          	lw	a1,96(s2)
    800093dc:	00004517          	auipc	a0,0x4
    800093e0:	bcc50513          	addi	a0,a0,-1076 # 8000cfa8 <kernelDataStart+0x114>
    800093e4:	00004097          	auipc	ra,0x4
    800093e8:	8ac080e7          	jalr	-1876(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    800093ec:	06093483          	ld	s1,96(s2)
    while(iter){
    800093f0:	02048663          	beqz	s1,8000941c <_ZN13SlabAllocator10printCacheEP5Cache+0x120>
        ConsoleUtil::print("", (uint64)iter, " ");
    800093f4:	01000693          	li	a3,16
    800093f8:	00004617          	auipc	a2,0x4
    800093fc:	b6860613          	addi	a2,a2,-1176 # 8000cf60 <kernelDataStart+0xcc>
    80009400:	0004859b          	sext.w	a1,s1
    80009404:	00004517          	auipc	a0,0x4
    80009408:	e6c50513          	addi	a0,a0,-404 # 8000d270 <kernelDataStart+0x3dc>
    8000940c:	00004097          	auipc	ra,0x4
    80009410:	884080e7          	jalr	-1916(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80009414:	0084b483          	ld	s1,8(s1)
    while(iter){
    80009418:	fd9ff06f          	j	800093f0 <_ZN13SlabAllocator10printCacheEP5Cache+0xf4>
    }
    ConsoleUtil::printString("\n");
    8000941c:	00004517          	auipc	a0,0x4
    80009420:	df450513          	addi	a0,a0,-524 # 8000d210 <kernelDataStart+0x37c>
    80009424:	00003097          	auipc	ra,0x3
    80009428:	74c080e7          	jalr	1868(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    8000942c:	01000693          	li	a3,16
    80009430:	00004617          	auipc	a2,0x4
    80009434:	de060613          	addi	a2,a2,-544 # 8000d210 <kernelDataStart+0x37c>
    80009438:	06892583          	lw	a1,104(s2)
    8000943c:	00004517          	auipc	a0,0x4
    80009440:	b7c50513          	addi	a0,a0,-1156 # 8000cfb8 <kernelDataStart+0x124>
    80009444:	00004097          	auipc	ra,0x4
    80009448:	84c080e7          	jalr	-1972(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    8000944c:	06893483          	ld	s1,104(s2)
    while(iter){
    80009450:	02048663          	beqz	s1,8000947c <_ZN13SlabAllocator10printCacheEP5Cache+0x180>
        ConsoleUtil::print("", (uint64)iter, " ");
    80009454:	01000693          	li	a3,16
    80009458:	00004617          	auipc	a2,0x4
    8000945c:	b0860613          	addi	a2,a2,-1272 # 8000cf60 <kernelDataStart+0xcc>
    80009460:	0004859b          	sext.w	a1,s1
    80009464:	00004517          	auipc	a0,0x4
    80009468:	e0c50513          	addi	a0,a0,-500 # 8000d270 <kernelDataStart+0x3dc>
    8000946c:	00004097          	auipc	ra,0x4
    80009470:	824080e7          	jalr	-2012(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80009474:	0084b483          	ld	s1,8(s1)
    while(iter){
    80009478:	fd9ff06f          	j	80009450 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
    }
    ConsoleUtil::printString("\n");
    8000947c:	00004517          	auipc	a0,0x4
    80009480:	d9450513          	addi	a0,a0,-620 # 8000d210 <kernelDataStart+0x37c>
    80009484:	00003097          	auipc	ra,0x3
    80009488:	6ec080e7          	jalr	1772(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    8000948c:	01000693          	li	a3,16
    80009490:	00004617          	auipc	a2,0x4
    80009494:	d8060613          	addi	a2,a2,-640 # 8000d210 <kernelDataStart+0x37c>
    80009498:	07092583          	lw	a1,112(s2)
    8000949c:	00004517          	auipc	a0,0x4
    800094a0:	b2c50513          	addi	a0,a0,-1236 # 8000cfc8 <kernelDataStart+0x134>
    800094a4:	00003097          	auipc	ra,0x3
    800094a8:	7ec080e7          	jalr	2028(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    800094ac:	07093483          	ld	s1,112(s2)
    while(iter){
    800094b0:	02048663          	beqz	s1,800094dc <_ZN13SlabAllocator10printCacheEP5Cache+0x1e0>
        ConsoleUtil::print("", (uint64)iter, " ");
    800094b4:	01000693          	li	a3,16
    800094b8:	00004617          	auipc	a2,0x4
    800094bc:	aa860613          	addi	a2,a2,-1368 # 8000cf60 <kernelDataStart+0xcc>
    800094c0:	0004859b          	sext.w	a1,s1
    800094c4:	00004517          	auipc	a0,0x4
    800094c8:	dac50513          	addi	a0,a0,-596 # 8000d270 <kernelDataStart+0x3dc>
    800094cc:	00003097          	auipc	ra,0x3
    800094d0:	7c4080e7          	jalr	1988(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800094d4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800094d8:	fd9ff06f          	j	800094b0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b4>
    }
    ConsoleUtil::printString("\n");
    800094dc:	00004517          	auipc	a0,0x4
    800094e0:	d3450513          	addi	a0,a0,-716 # 8000d210 <kernelDataStart+0x37c>
    800094e4:	00003097          	auipc	ra,0x3
    800094e8:	68c080e7          	jalr	1676(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
}
    800094ec:	01813083          	ld	ra,24(sp)
    800094f0:	01013403          	ld	s0,16(sp)
    800094f4:	00813483          	ld	s1,8(sp)
    800094f8:	00013903          	ld	s2,0(sp)
    800094fc:	02010113          	addi	sp,sp,32
    80009500:	00008067          	ret

0000000080009504 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    80009504:	ff010113          	addi	sp,sp,-16
    80009508:	00813423          	sd	s0,8(sp)
    8000950c:	01010413          	addi	s0,sp,16
    slab->next = head;
    80009510:	00053783          	ld	a5,0(a0)
    80009514:	00f5b423          	sd	a5,8(a1)
    if(head)
    80009518:	00078463          	beqz	a5,80009520 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    8000951c:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80009520:	0005b023          	sd	zero,0(a1)
    head = slab;
    80009524:	00b53023          	sd	a1,0(a0)
}
    80009528:	00813403          	ld	s0,8(sp)
    8000952c:	01010113          	addi	sp,sp,16
    80009530:	00008067          	ret

0000000080009534 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80009534:	fd010113          	addi	sp,sp,-48
    80009538:	02113423          	sd	ra,40(sp)
    8000953c:	02813023          	sd	s0,32(sp)
    80009540:	00913c23          	sd	s1,24(sp)
    80009544:	01213823          	sd	s2,16(sp)
    80009548:	01313423          	sd	s3,8(sp)
    8000954c:	03010413          	addi	s0,sp,48
    80009550:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80009554:	04853503          	ld	a0,72(a0)
    80009558:	00001097          	auipc	ra,0x1
    8000955c:	0b4080e7          	jalr	180(ra) # 8000a60c <_ZN5Buddy5allocEm>
    if(!slab)
    80009560:	0a050863          	beqz	a0,80009610 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xdc>
    80009564:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80009568:	00050593          	mv	a1,a0
    8000956c:	06098513          	addi	a0,s3,96
    80009570:	00000097          	auipc	ra,0x0
    80009574:	f94080e7          	jalr	-108(ra) # 80009504 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80009578:	0489b783          	ld	a5,72(s3)
    8000957c:	00c79793          	slli	a5,a5,0xc
    80009580:	fc878793          	addi	a5,a5,-56
    80009584:	0409b703          	ld	a4,64(s3)
    80009588:	02e7d7b3          	divu	a5,a5,a4
    8000958c:	00f4b823          	sd	a5,16(s1)
    80009590:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + slab->totalNumOfSlots/8 + 1);
    80009594:	0037d793          	srli	a5,a5,0x3
    80009598:	009787b3          	add	a5,a5,s1
    8000959c:	03978793          	addi	a5,a5,57
    800095a0:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (char*)((uint64)slab + sizeof(Slab));
    800095a4:	03848793          	addi	a5,s1,56
    800095a8:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    800095ac:	0334b823          	sd	s3,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800095b0:	00000713          	li	a4,0
    800095b4:	0184b783          	ld	a5,24(s1)
    800095b8:	0037d793          	srli	a5,a5,0x3
    800095bc:	00178793          	addi	a5,a5,1
    800095c0:	00f77c63          	bgeu	a4,a5,800095d8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
        slab->allocated[i] = 0;
    800095c4:	0204b783          	ld	a5,32(s1)
    800095c8:	00e787b3          	add	a5,a5,a4
    800095cc:	00078023          	sb	zero,0(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800095d0:	00170713          	addi	a4,a4,1
    800095d4:	fe1ff06f          	j	800095b4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x80>
    if(cache->ctor) {
    800095d8:	0509b783          	ld	a5,80(s3)
    800095dc:	02078e63          	beqz	a5,80009618 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800095e0:	00000913          	li	s2,0
    800095e4:	0184b783          	ld	a5,24(s1)
    800095e8:	02f97c63          	bgeu	s2,a5,80009620 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800095ec:	0509b703          	ld	a4,80(s3)
    800095f0:	0284b503          	ld	a0,40(s1)
    800095f4:	0304b783          	ld	a5,48(s1)
    800095f8:	0407b783          	ld	a5,64(a5)
    800095fc:	032787b3          	mul	a5,a5,s2
    80009600:	00f50533          	add	a0,a0,a5
    80009604:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80009608:	00190913          	addi	s2,s2,1
    8000960c:	fd9ff06f          	j	800095e4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb0>
        return false;
    80009610:	00000513          	li	a0,0
    80009614:	0100006f          	j	80009624 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    return true;
    80009618:	00100513          	li	a0,1
    8000961c:	0080006f          	j	80009624 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    80009620:	00100513          	li	a0,1
}
    80009624:	02813083          	ld	ra,40(sp)
    80009628:	02013403          	ld	s0,32(sp)
    8000962c:	01813483          	ld	s1,24(sp)
    80009630:	01013903          	ld	s2,16(sp)
    80009634:	00813983          	ld	s3,8(sp)
    80009638:	03010113          	addi	sp,sp,48
    8000963c:	00008067          	ret

0000000080009640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80009640:	ff010113          	addi	sp,sp,-16
    80009644:	00813423          	sd	s0,8(sp)
    80009648:	01010413          	addi	s0,sp,16
    if(slab == head)
    8000964c:	00053783          	ld	a5,0(a0)
    80009650:	02b78c63          	beq	a5,a1,80009688 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80009654:	0085b783          	ld	a5,8(a1)
    80009658:	00078663          	beqz	a5,80009664 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    8000965c:	0005b703          	ld	a4,0(a1)
    80009660:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80009664:	0005b783          	ld	a5,0(a1)
    80009668:	00078663          	beqz	a5,80009674 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    8000966c:	0085b703          	ld	a4,8(a1)
    80009670:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80009674:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80009678:	0005b423          	sd	zero,8(a1)
}
    8000967c:	00813403          	ld	s0,8(sp)
    80009680:	01010113          	addi	sp,sp,16
    80009684:	00008067          	ret
        head = slab->next;
    80009688:	0085b783          	ld	a5,8(a1)
    8000968c:	00f53023          	sd	a5,0(a0)
    80009690:	fc5ff06f          	j	80009654 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080009694 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80009694:	fe010113          	addi	sp,sp,-32
    80009698:	00113c23          	sd	ra,24(sp)
    8000969c:	00813823          	sd	s0,16(sp)
    800096a0:	00913423          	sd	s1,8(sp)
    800096a4:	01213023          	sd	s2,0(sp)
    800096a8:	02010413          	addi	s0,sp,32
    800096ac:	00058913          	mv	s2,a1
    800096b0:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800096b4:	00060593          	mv	a1,a2
    800096b8:	00000097          	auipc	ra,0x0
    800096bc:	f88080e7          	jalr	-120(ra) # 80009640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    800096c0:	00048593          	mv	a1,s1
    800096c4:	00090513          	mv	a0,s2
    800096c8:	00000097          	auipc	ra,0x0
    800096cc:	e3c080e7          	jalr	-452(ra) # 80009504 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800096d0:	01813083          	ld	ra,24(sp)
    800096d4:	01013403          	ld	s0,16(sp)
    800096d8:	00813483          	ld	s1,8(sp)
    800096dc:	00013903          	ld	s2,0(sp)
    800096e0:	02010113          	addi	sp,sp,32
    800096e4:	00008067          	ret

00000000800096e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    800096e8:	fe010113          	addi	sp,sp,-32
    800096ec:	00113c23          	sd	ra,24(sp)
    800096f0:	00813823          	sd	s0,16(sp)
    800096f4:	00913423          	sd	s1,8(sp)
    800096f8:	01213023          	sd	s2,0(sp)
    800096fc:	02010413          	addi	s0,sp,32
    80009700:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80009704:	00000493          	li	s1,0
    80009708:	01893783          	ld	a5,24(s2)
    8000970c:	0af4f863          	bgeu	s1,a5,800097bc <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80009710:	02093783          	ld	a5,32(s2)
    80009714:	0034d713          	srli	a4,s1,0x3
    80009718:	00e787b3          	add	a5,a5,a4
    8000971c:	0007c603          	lbu	a2,0(a5)
    80009720:	fff4c713          	not	a4,s1
    80009724:	00777713          	andi	a4,a4,7
    80009728:	40e656bb          	sraw	a3,a2,a4
    8000972c:	0016f693          	andi	a3,a3,1
    80009730:	00068663          	beqz	a3,8000973c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x54>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80009734:	00148493          	addi	s1,s1,1
    80009738:	fd1ff06f          	j	80009708 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    8000973c:	00100693          	li	a3,1
    80009740:	00e6973b          	sllw	a4,a3,a4
    80009744:	00e66633          	or	a2,a2,a4
    80009748:	00c78023          	sb	a2,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    8000974c:	01093783          	ld	a5,16(s2)
    80009750:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80009754:	04f70863          	beq	a4,a5,800097a4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
    80009758:	03093503          	ld	a0,48(s2)
    8000975c:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80009760:	fff78793          	addi	a5,a5,-1
    80009764:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80009768:	04079463          	bnez	a5,800097b0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    8000976c:	03093583          	ld	a1,48(s2)
    80009770:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80009774:	0005b703          	ld	a4,0(a1)
    80009778:	00053783          	ld	a5,0(a0)
    8000977c:	00f70863          	beq	a4,a5,8000978c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa4>
                SlabAllocator::move(headFrom, headTo, slab);
    80009780:	00090613          	mv	a2,s2
    80009784:	00000097          	auipc	ra,0x0
    80009788:	f10080e7          	jalr	-240(ra) # 80009694 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    8000978c:	02893503          	ld	a0,40(s2)
    80009790:	03093783          	ld	a5,48(s2)
    80009794:	0407b783          	ld	a5,64(a5)
    80009798:	029784b3          	mul	s1,a5,s1
    8000979c:	00950533          	add	a0,a0,s1
    800097a0:	0200006f          	j	800097c0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd8>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800097a4:	03093503          	ld	a0,48(s2)
    800097a8:	06050513          	addi	a0,a0,96
    800097ac:	fb5ff06f          	j	80009760 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x78>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800097b0:	03093583          	ld	a1,48(s2)
    800097b4:	06858593          	addi	a1,a1,104
    800097b8:	fbdff06f          	j	80009774 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x8c>
    return nullptr;
    800097bc:	00000513          	li	a0,0
}
    800097c0:	01813083          	ld	ra,24(sp)
    800097c4:	01013403          	ld	s0,16(sp)
    800097c8:	00813483          	ld	s1,8(sp)
    800097cc:	00013903          	ld	s2,0(sp)
    800097d0:	02010113          	addi	sp,sp,32
    800097d4:	00008067          	ret

00000000800097d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800097d8:	fe010113          	addi	sp,sp,-32
    800097dc:	00113c23          	sd	ra,24(sp)
    800097e0:	00813823          	sd	s0,16(sp)
    800097e4:	00913423          	sd	s1,8(sp)
    800097e8:	01213023          	sd	s2,0(sp)
    800097ec:	02010413          	addi	s0,sp,32
    800097f0:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800097f4:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800097f8:	00048c63          	beqz	s1,80009810 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    800097fc:	00048513          	mv	a0,s1
    80009800:	00000097          	auipc	ra,0x0
    80009804:	ee8080e7          	jalr	-280(ra) # 800096e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80009808:	fe0508e3          	beqz	a0,800097f8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    8000980c:	00050493          	mv	s1,a0
    if(ret){
    80009810:	02048063          	beqz	s1,80009830 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    80009814:	00048513          	mv	a0,s1
    80009818:	01813083          	ld	ra,24(sp)
    8000981c:	01013403          	ld	s0,16(sp)
    80009820:	00813483          	ld	s1,8(sp)
    80009824:	00013903          	ld	s2,0(sp)
    80009828:	02010113          	addi	sp,sp,32
    8000982c:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80009830:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80009834:	00048c63          	beqz	s1,8000984c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80009838:	00048513          	mv	a0,s1
    8000983c:	00000097          	auipc	ra,0x0
    80009840:	eac080e7          	jalr	-340(ra) # 800096e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80009844:	fe0508e3          	beqz	a0,80009834 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80009848:	00050493          	mv	s1,a0
    if(ret){
    8000984c:	fc0494e3          	bnez	s1,80009814 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80009850:	00090513          	mv	a0,s2
    80009854:	00000097          	auipc	ra,0x0
    80009858:	ce0080e7          	jalr	-800(ra) # 80009534 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    8000985c:	fa050ce3          	beqz	a0,80009814 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80009860:	06093503          	ld	a0,96(s2)
    80009864:	00000097          	auipc	ra,0x0
    80009868:	e84080e7          	jalr	-380(ra) # 800096e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    8000986c:	00050493          	mv	s1,a0
    return ret;
    80009870:	fa5ff06f          	j	80009814 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

0000000080009874 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80009874:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80009878:	0017d513          	srli	a0,a5,0x1
    8000987c:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80009880:	0027d713          	srli	a4,a5,0x2
    80009884:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80009888:	0047d713          	srli	a4,a5,0x4
    8000988c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80009890:	0087d713          	srli	a4,a5,0x8
    80009894:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80009898:	0107d713          	srli	a4,a5,0x10
    8000989c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    800098a0:	0207d713          	srli	a4,a5,0x20
    800098a4:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    800098a8:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800098ac:	00000713          	li	a4,0
        while(num>1){
    800098b0:	00100693          	li	a3,1
    800098b4:	00f6f863          	bgeu	a3,a5,800098c4 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    800098b8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800098bc:	00170713          	addi	a4,a4,1
        while(num>1){
    800098c0:	ff1ff06f          	j	800098b0 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800098c4:	ffb70713          	addi	a4,a4,-5
    800098c8:	00c00793          	li	a5,12
    800098cc:	04e7e063          	bltu	a5,a4,8000990c <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    800098d0:	ff010113          	addi	sp,sp,-16
    800098d4:	00113423          	sd	ra,8(sp)
    800098d8:	00813023          	sd	s0,0(sp)
    800098dc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    800098e0:	00371713          	slli	a4,a4,0x3
    800098e4:	00004797          	auipc	a5,0x4
    800098e8:	c0478793          	addi	a5,a5,-1020 # 8000d4e8 <_ZN13SlabAllocator5sizeNE>
    800098ec:	00e78733          	add	a4,a5,a4
    800098f0:	00073503          	ld	a0,0(a4)
    800098f4:	00000097          	auipc	ra,0x0
    800098f8:	ee4080e7          	jalr	-284(ra) # 800097d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800098fc:	00813083          	ld	ra,8(sp)
    80009900:	00013403          	ld	s0,0(sp)
    80009904:	01010113          	addi	sp,sp,16
    80009908:	00008067          	ret
        return nullptr;
    8000990c:	00000513          	li	a0,0
}
    80009910:	00008067          	ret

0000000080009914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80009914:	fc010113          	addi	sp,sp,-64
    80009918:	02113c23          	sd	ra,56(sp)
    8000991c:	02813823          	sd	s0,48(sp)
    80009920:	02913423          	sd	s1,40(sp)
    80009924:	03213023          	sd	s2,32(sp)
    80009928:	01313c23          	sd	s3,24(sp)
    8000992c:	01413823          	sd	s4,16(sp)
    80009930:	01513423          	sd	s5,8(sp)
    80009934:	04010413          	addi	s0,sp,64
    80009938:	00050913          	mv	s2,a0
    8000993c:	00058993          	mv	s3,a1
    80009940:	00060a93          	mv	s5,a2
    80009944:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80009948:	00004517          	auipc	a0,0x4
    8000994c:	c0853503          	ld	a0,-1016(a0) # 8000d550 <_ZN13SlabAllocator5cacheE>
    80009950:	00000097          	auipc	ra,0x0
    80009954:	e88080e7          	jalr	-376(ra) # 800097d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80009958:	00050493          	mv	s1,a0
    if(ret == nullptr)
    8000995c:	02050a63          	beqz	a0,80009990 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x7c>
    ret->ctor = ctor;
    80009960:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80009964:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80009968:	06053823          	sd	zero,112(a0)
    8000996c:	06053423          	sd	zero,104(a0)
    80009970:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80009974:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    80009978:	00200793          	li	a5,2
    8000997c:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    80009980:	00050593          	mv	a1,a0
    80009984:	00090513          	mv	a0,s2
    80009988:	00003097          	auipc	ra,0x3
    8000998c:	c6c080e7          	jalr	-916(ra) # 8000c5f4 <_Z6strcpyPKcPc>
}
    80009990:	00048513          	mv	a0,s1
    80009994:	03813083          	ld	ra,56(sp)
    80009998:	03013403          	ld	s0,48(sp)
    8000999c:	02813483          	ld	s1,40(sp)
    800099a0:	02013903          	ld	s2,32(sp)
    800099a4:	01813983          	ld	s3,24(sp)
    800099a8:	01013a03          	ld	s4,16(sp)
    800099ac:	00813a83          	ld	s5,8(sp)
    800099b0:	04010113          	addi	sp,sp,64
    800099b4:	00008067          	ret

00000000800099b8 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800099b8:	fe010113          	addi	sp,sp,-32
    800099bc:	00113c23          	sd	ra,24(sp)
    800099c0:	00813823          	sd	s0,16(sp)
    800099c4:	00913423          	sd	s1,8(sp)
    800099c8:	01213023          	sd	s2,0(sp)
    800099cc:	02010413          	addi	s0,sp,32
    800099d0:	00050913          	mv	s2,a0
    800099d4:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    800099d8:	00001097          	auipc	ra,0x1
    800099dc:	864080e7          	jalr	-1948(ra) # 8000a23c <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    800099e0:	00004797          	auipc	a5,0x4
    800099e4:	b0878793          	addi	a5,a5,-1272 # 8000d4e8 <_ZN13SlabAllocator5sizeNE>
    800099e8:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800099ec:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800099f0:	ffffd717          	auipc	a4,0xffffd
    800099f4:	e4073703          	ld	a4,-448(a4) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    800099f8:	00073583          	ld	a1,0(a4)
    800099fc:	00c5d593          	srli	a1,a1,0xc
    80009a00:	00158593          	addi	a1,a1,1
    80009a04:	00c59593          	slli	a1,a1,0xc
    80009a08:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    80009a0c:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80009a10:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80009a14:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80009a18:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80009a1c:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80009a20:	07800793          	li	a5,120
    80009a24:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80009a28:	00200793          	li	a5,2
    80009a2c:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80009a30:	00003517          	auipc	a0,0x3
    80009a34:	5a850513          	addi	a0,a0,1448 # 8000cfd8 <kernelDataStart+0x144>
    80009a38:	00003097          	auipc	ra,0x3
    80009a3c:	bbc080e7          	jalr	-1092(ra) # 8000c5f4 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80009a40:	00000493          	li	s1,0
    80009a44:	0440006f          	j	80009a88 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80009a48:	00349913          	slli	s2,s1,0x3
    80009a4c:	00004797          	auipc	a5,0x4
    80009a50:	9f478793          	addi	a5,a5,-1548 # 8000d440 <_ZN13SlabAllocator5namesE>
    80009a54:	012787b3          	add	a5,a5,s2
    80009a58:	00000693          	li	a3,0
    80009a5c:	00000613          	li	a2,0
    80009a60:	00200593          	li	a1,2
    80009a64:	009595bb          	sllw	a1,a1,s1
    80009a68:	0007b503          	ld	a0,0(a5)
    80009a6c:	00000097          	auipc	ra,0x0
    80009a70:	ea8080e7          	jalr	-344(ra) # 80009914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80009a74:	00004797          	auipc	a5,0x4
    80009a78:	a7478793          	addi	a5,a5,-1420 # 8000d4e8 <_ZN13SlabAllocator5sizeNE>
    80009a7c:	012787b3          	add	a5,a5,s2
    80009a80:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80009a84:	0014849b          	addiw	s1,s1,1
    80009a88:	00c00793          	li	a5,12
    80009a8c:	fa97dee3          	bge	a5,s1,80009a48 <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80009a90:	01813083          	ld	ra,24(sp)
    80009a94:	01013403          	ld	s0,16(sp)
    80009a98:	00813483          	ld	s1,8(sp)
    80009a9c:	00013903          	ld	s2,0(sp)
    80009aa0:	02010113          	addi	sp,sp,32
    80009aa4:	00008067          	ret

0000000080009aa8 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80009aa8:	02053783          	ld	a5,32(a0)
    80009aac:	0035d713          	srli	a4,a1,0x3
    80009ab0:	00e787b3          	add	a5,a5,a4
    80009ab4:	0007c683          	lbu	a3,0(a5)
    80009ab8:	fff5c593          	not	a1,a1
    80009abc:	0075f593          	andi	a1,a1,7
    80009ac0:	40b6d73b          	sraw	a4,a3,a1
    80009ac4:	00177713          	andi	a4,a4,1
    80009ac8:	0c070263          	beqz	a4,80009b8c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80009acc:	fe010113          	addi	sp,sp,-32
    80009ad0:	00113c23          	sd	ra,24(sp)
    80009ad4:	00813823          	sd	s0,16(sp)
    80009ad8:	00913423          	sd	s1,8(sp)
    80009adc:	02010413          	addi	s0,sp,32
    80009ae0:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80009ae4:	00100713          	li	a4,1
    80009ae8:	00b715bb          	sllw	a1,a4,a1
    80009aec:	fff5c593          	not	a1,a1
    80009af0:	00d5f5b3          	and	a1,a1,a3
    80009af4:	00b78023          	sb	a1,0(a5)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80009af8:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80009afc:	04079a63          	bnez	a5,80009b50 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80009b00:	03053503          	ld	a0,48(a0)
    80009b04:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80009b08:	00178793          	addi	a5,a5,1
    80009b0c:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80009b10:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80009b14:	04e78463          	beq	a5,a4,80009b5c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80009b18:	0304b583          	ld	a1,48(s1)
    80009b1c:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80009b20:	04e78463          	beq	a5,a4,80009b68 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80009b24:	0005b703          	ld	a4,0(a1)
    80009b28:	00053783          	ld	a5,0(a0)
    80009b2c:	00f70863          	beq	a4,a5,80009b3c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80009b30:	00048613          	mv	a2,s1
    80009b34:	00000097          	auipc	ra,0x0
    80009b38:	b60080e7          	jalr	-1184(ra) # 80009694 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80009b3c:	01813083          	ld	ra,24(sp)
    80009b40:	01013403          	ld	s0,16(sp)
    80009b44:	00813483          	ld	s1,8(sp)
    80009b48:	02010113          	addi	sp,sp,32
    80009b4c:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80009b50:	03053503          	ld	a0,48(a0)
    80009b54:	06850513          	addi	a0,a0,104
    80009b58:	fb1ff06f          	j	80009b08 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80009b5c:	0304b583          	ld	a1,48(s1)
    80009b60:	06058593          	addi	a1,a1,96
    80009b64:	fbdff06f          	j	80009b20 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80009b68:	00048593          	mv	a1,s1
    80009b6c:	00000097          	auipc	ra,0x0
    80009b70:	ad4080e7          	jalr	-1324(ra) # 80009640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80009b74:	0304b783          	ld	a5,48(s1)
    80009b78:	0487b583          	ld	a1,72(a5)
    80009b7c:	00048513          	mv	a0,s1
    80009b80:	00001097          	auipc	ra,0x1
    80009b84:	9b4080e7          	jalr	-1612(ra) # 8000a534 <_ZN5Buddy4freeEPvm>
    80009b88:	fb5ff06f          	j	80009b3c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80009b8c:	00008067          	ret

0000000080009b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80009b90:	fe010113          	addi	sp,sp,-32
    80009b94:	00113c23          	sd	ra,24(sp)
    80009b98:	00813823          	sd	s0,16(sp)
    80009b9c:	00913423          	sd	s1,8(sp)
    80009ba0:	01213023          	sd	s2,0(sp)
    80009ba4:	02010413          	addi	s0,sp,32
    80009ba8:	00050913          	mv	s2,a0
    80009bac:	00058493          	mv	s1,a1
    if(cache->dtor)
    80009bb0:	05853783          	ld	a5,88(a0)
    80009bb4:	00078663          	beqz	a5,80009bc0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80009bb8:	00058513          	mv	a0,a1
    80009bbc:	000780e7          	jalr	a5
    if(cache->ctor)
    80009bc0:	05093783          	ld	a5,80(s2)
    80009bc4:	00078663          	beqz	a5,80009bd0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80009bc8:	00048513          	mv	a0,s1
    80009bcc:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80009bd0:	07093503          	ld	a0,112(s2)
    80009bd4:	0080006f          	j	80009bdc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80009bd8:	00853503          	ld	a0,8(a0)
        while(head){
    80009bdc:	02050e63          	beqz	a0,80009c18 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80009be0:	02853703          	ld	a4,40(a0)
    80009be4:	01853783          	ld	a5,24(a0)
    80009be8:	03053683          	ld	a3,48(a0)
    80009bec:	0406b583          	ld	a1,64(a3)
    80009bf0:	02b787b3          	mul	a5,a5,a1
    80009bf4:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80009bf8:	fef4f0e3          	bgeu	s1,a5,80009bd8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80009bfc:	fce4eee3          	bltu	s1,a4,80009bd8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80009c00:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80009c04:	02b755b3          	divu	a1,a4,a1
    80009c08:	00000097          	auipc	ra,0x0
    80009c0c:	ea0080e7          	jalr	-352(ra) # 80009aa8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80009c10:	00100513          	li	a0,1
    80009c14:	0080006f          	j	80009c1c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80009c18:	00000513          	li	a0,0
    if(deleted)
    80009c1c:	00050e63          	beqz	a0,80009c38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80009c20:	01813083          	ld	ra,24(sp)
    80009c24:	01013403          	ld	s0,16(sp)
    80009c28:	00813483          	ld	s1,8(sp)
    80009c2c:	00013903          	ld	s2,0(sp)
    80009c30:	02010113          	addi	sp,sp,32
    80009c34:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80009c38:	06893783          	ld	a5,104(s2)
    80009c3c:	0080006f          	j	80009c44 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80009c40:	0087b783          	ld	a5,8(a5)
        while(head){
    80009c44:	fc078ee3          	beqz	a5,80009c20 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80009c48:	0287b683          	ld	a3,40(a5)
    80009c4c:	0187b703          	ld	a4,24(a5)
    80009c50:	0307b603          	ld	a2,48(a5)
    80009c54:	04063583          	ld	a1,64(a2)
    80009c58:	02b70733          	mul	a4,a4,a1
    80009c5c:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80009c60:	fee4f0e3          	bgeu	s1,a4,80009c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80009c64:	fcd4eee3          	bltu	s1,a3,80009c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80009c68:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80009c6c:	02b6d5b3          	divu	a1,a3,a1
    80009c70:	00078513          	mv	a0,a5
    80009c74:	00000097          	auipc	ra,0x0
    80009c78:	e34080e7          	jalr	-460(ra) # 80009aa8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80009c7c:	00100513          	li	a0,1
    80009c80:	fa1ff06f          	j	80009c20 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080009c84 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80009c84:	fe010113          	addi	sp,sp,-32
    80009c88:	00113c23          	sd	ra,24(sp)
    80009c8c:	00813823          	sd	s0,16(sp)
    80009c90:	00913423          	sd	s1,8(sp)
    80009c94:	01213023          	sd	s2,0(sp)
    80009c98:	02010413          	addi	s0,sp,32
    80009c9c:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80009ca0:	00000493          	li	s1,0
    80009ca4:	00c00793          	li	a5,12
    80009ca8:	0297c863          	blt	a5,s1,80009cd8 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80009cac:	00349713          	slli	a4,s1,0x3
    80009cb0:	00004797          	auipc	a5,0x4
    80009cb4:	83878793          	addi	a5,a5,-1992 # 8000d4e8 <_ZN13SlabAllocator5sizeNE>
    80009cb8:	00e787b3          	add	a5,a5,a4
    80009cbc:	00090593          	mv	a1,s2
    80009cc0:	0007b503          	ld	a0,0(a5)
    80009cc4:	00000097          	auipc	ra,0x0
    80009cc8:	ecc080e7          	jalr	-308(ra) # 80009b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80009ccc:	00051663          	bnez	a0,80009cd8 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80009cd0:	0014849b          	addiw	s1,s1,1
    80009cd4:	fd1ff06f          	j	80009ca4 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80009cd8:	01813083          	ld	ra,24(sp)
    80009cdc:	01013403          	ld	s0,16(sp)
    80009ce0:	00813483          	ld	s1,8(sp)
    80009ce4:	00013903          	ld	s2,0(sp)
    80009ce8:	02010113          	addi	sp,sp,32
    80009cec:	00008067          	ret

0000000080009cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80009cf0:	fe010113          	addi	sp,sp,-32
    80009cf4:	00113c23          	sd	ra,24(sp)
    80009cf8:	00813823          	sd	s0,16(sp)
    80009cfc:	00913423          	sd	s1,8(sp)
    80009d00:	01213023          	sd	s2,0(sp)
    80009d04:	02010413          	addi	s0,sp,32
    80009d08:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80009d0c:	00053903          	ld	s2,0(a0)
    80009d10:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80009d14:	00093503          	ld	a0,0(s2)
    80009d18:	02050263          	beqz	a0,80009d3c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80009d1c:	03053783          	ld	a5,48(a0)
    80009d20:	0487b583          	ld	a1,72(a5)
    80009d24:	00001097          	auipc	ra,0x1
    80009d28:	810080e7          	jalr	-2032(ra) # 8000a534 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80009d2c:	00093783          	ld	a5,0(s2)
    80009d30:	0087b783          	ld	a5,8(a5)
    80009d34:	00f93023          	sd	a5,0(s2)
        while(head){
    80009d38:	fddff06f          	j	80009d14 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80009d3c:	0004b903          	ld	s2,0(s1)
    80009d40:	06890913          	addi	s2,s2,104
    80009d44:	00093503          	ld	a0,0(s2)
    80009d48:	02050263          	beqz	a0,80009d6c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80009d4c:	03053783          	ld	a5,48(a0)
    80009d50:	0487b583          	ld	a1,72(a5)
    80009d54:	00000097          	auipc	ra,0x0
    80009d58:	7e0080e7          	jalr	2016(ra) # 8000a534 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80009d5c:	00093783          	ld	a5,0(s2)
    80009d60:	0087b783          	ld	a5,8(a5)
    80009d64:	00f93023          	sd	a5,0(s2)
        while(head){
    80009d68:	fddff06f          	j	80009d44 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80009d6c:	0004b903          	ld	s2,0(s1)
    80009d70:	06090913          	addi	s2,s2,96
    80009d74:	00093503          	ld	a0,0(s2)
    80009d78:	02050263          	beqz	a0,80009d9c <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80009d7c:	03053783          	ld	a5,48(a0)
    80009d80:	0487b583          	ld	a1,72(a5)
    80009d84:	00000097          	auipc	ra,0x0
    80009d88:	7b0080e7          	jalr	1968(ra) # 8000a534 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80009d8c:	00093783          	ld	a5,0(s2)
    80009d90:	0087b783          	ld	a5,8(a5)
    80009d94:	00f93023          	sd	a5,0(s2)
        while(head){
    80009d98:	fddff06f          	j	80009d74 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80009d9c:	0004b583          	ld	a1,0(s1)
    80009da0:	00003517          	auipc	a0,0x3
    80009da4:	7b053503          	ld	a0,1968(a0) # 8000d550 <_ZN13SlabAllocator5cacheE>
    80009da8:	00000097          	auipc	ra,0x0
    80009dac:	de8080e7          	jalr	-536(ra) # 80009b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80009db0:	0004b023          	sd	zero,0(s1)
}
    80009db4:	01813083          	ld	ra,24(sp)
    80009db8:	01013403          	ld	s0,16(sp)
    80009dbc:	00813483          	ld	s1,8(sp)
    80009dc0:	00013903          	ld	s2,0(sp)
    80009dc4:	02010113          	addi	sp,sp,32
    80009dc8:	00008067          	ret

0000000080009dcc <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    80009dcc:	fc010113          	addi	sp,sp,-64
    80009dd0:	02113c23          	sd	ra,56(sp)
    80009dd4:	02813823          	sd	s0,48(sp)
    80009dd8:	02913423          	sd	s1,40(sp)
    80009ddc:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80009de0:	fc040493          	addi	s1,s0,-64
    80009de4:	00048513          	mv	a0,s1
    80009de8:	ffff8097          	auipc	ra,0xffff8
    80009dec:	b0c080e7          	jalr	-1268(ra) # 800018f4 <_ZN6ThreadC1Ev>
    80009df0:	00003797          	auipc	a5,0x3
    80009df4:	6c878793          	addi	a5,a5,1736 # 8000d4b8 <_ZTV10ForkThread+0x10>
    80009df8:	fcf43023          	sd	a5,-64(s0)
    80009dfc:	00100793          	li	a5,1
    80009e00:	fcf43823          	sd	a5,-48(s0)
    80009e04:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    80009e08:	00048513          	mv	a0,s1
    80009e0c:	ffff8097          	auipc	ra,0xffff8
    80009e10:	bd8080e7          	jalr	-1064(ra) # 800019e4 <_ZN6Thread5startEv>
        return finished;
    80009e14:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    80009e18:	00079863          	bnez	a5,80009e28 <_Z8testUserv+0x5c>
        thread_dispatch();
    80009e1c:	ffff7097          	auipc	ra,0xffff7
    80009e20:	314080e7          	jalr	788(ra) # 80001130 <_Z15thread_dispatchv>
    80009e24:	ff1ff06f          	j	80009e14 <_Z8testUserv+0x48>
    }

    ConsoleUtil::printString("User main finished\n");
    80009e28:	00003517          	auipc	a0,0x3
    80009e2c:	32850513          	addi	a0,a0,808 # 8000d150 <kernelDataStart+0x2bc>
    80009e30:	00003097          	auipc	ra,0x3
    80009e34:	d40080e7          	jalr	-704(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
class ForkThread : public Thread {
    80009e38:	00003797          	auipc	a5,0x3
    80009e3c:	68078793          	addi	a5,a5,1664 # 8000d4b8 <_ZTV10ForkThread+0x10>
    80009e40:	fcf43023          	sd	a5,-64(s0)
    80009e44:	fc040513          	addi	a0,s0,-64
    80009e48:	ffff8097          	auipc	ra,0xffff8
    80009e4c:	890080e7          	jalr	-1904(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80009e50:	03813083          	ld	ra,56(sp)
    80009e54:	03013403          	ld	s0,48(sp)
    80009e58:	02813483          	ld	s1,40(sp)
    80009e5c:	04010113          	addi	sp,sp,64
    80009e60:	00008067          	ret
    80009e64:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    80009e68:	00003797          	auipc	a5,0x3
    80009e6c:	65078793          	addi	a5,a5,1616 # 8000d4b8 <_ZTV10ForkThread+0x10>
    80009e70:	fcf43023          	sd	a5,-64(s0)
    80009e74:	fc040513          	addi	a0,s0,-64
    80009e78:	ffff8097          	auipc	ra,0xffff8
    80009e7c:	860080e7          	jalr	-1952(ra) # 800016d8 <_ZN6ThreadD1Ev>
    80009e80:	00048513          	mv	a0,s1
    80009e84:	ffffe097          	auipc	ra,0xffffe
    80009e88:	bb4080e7          	jalr	-1100(ra) # 80007a38 <_Unwind_Resume>

0000000080009e8c <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80009e8c:	ff010113          	addi	sp,sp,-16
    80009e90:	00113423          	sd	ra,8(sp)
    80009e94:	00813023          	sd	s0,0(sp)
    80009e98:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    testUser();
    80009e9c:	00000097          	auipc	ra,0x0
    80009ea0:	f30080e7          	jalr	-208(ra) # 80009dcc <_Z8testUserv>
    80009ea4:	00813083          	ld	ra,8(sp)
    80009ea8:	00013403          	ld	s0,0(sp)
    80009eac:	01010113          	addi	sp,sp,16
    80009eb0:	00008067          	ret

0000000080009eb4 <_Z4ctorPv>:
void ctor(void* tst){
    80009eb4:	ff010113          	addi	sp,sp,-16
    80009eb8:	00813423          	sd	s0,8(sp)
    80009ebc:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    80009ec0:	01100793          	li	a5,17
    80009ec4:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    80009ec8:	02000793          	li	a5,32
    80009ecc:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    80009ed0:	00d00793          	li	a5,13
    80009ed4:	00f53823          	sd	a5,16(a0)
}
    80009ed8:	00813403          	ld	s0,8(sp)
    80009edc:	01010113          	addi	sp,sp,16
    80009ee0:	00008067          	ret

0000000080009ee4 <_ZN6SystemC1Ev>:
    if (!initialized) {
    80009ee4:	00003797          	auipc	a5,0x3
    80009ee8:	6847c783          	lbu	a5,1668(a5) # 8000d568 <_ZN6System11initializedE>
    80009eec:	00078463          	beqz	a5,80009ef4 <_ZN6SystemC1Ev+0x10>
    80009ef0:	00008067          	ret
System::System() {
    80009ef4:	fe010113          	addi	sp,sp,-32
    80009ef8:	00113c23          	sd	ra,24(sp)
    80009efc:	00813823          	sd	s0,16(sp)
    80009f00:	02010413          	addi	s0,sp,32
        initialized = true;
    80009f04:	00100793          	li	a5,1
    80009f08:	00003717          	auipc	a4,0x3
    80009f0c:	66f70023          	sb	a5,1632(a4) # 8000d568 <_ZN6System11initializedE>
        RiscV::initialize();
    80009f10:	00001097          	auipc	ra,0x1
    80009f14:	4c8080e7          	jalr	1224(ra) # 8000b3d8 <_ZN5RiscV10initializeEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80009f18:	00000613          	li	a2,0
    80009f1c:	00000597          	auipc	a1,0x0
    80009f20:	f7058593          	addi	a1,a1,-144 # 80009e8c <_ZN6System15userMainWrapperEPv>
    80009f24:	fe840513          	addi	a0,s0,-24
    80009f28:	ffff7097          	auipc	ra,0xffff7
    80009f2c:	154080e7          	jalr	340(ra) # 8000107c <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80009f30:	fe843783          	ld	a5,-24(s0)
    80009f34:	0107a703          	lw	a4,16(a5)
    80009f38:	00200793          	li	a5,2
    80009f3c:	00f70863          	beq	a4,a5,80009f4c <_ZN6SystemC1Ev+0x68>
            thread_dispatch();
    80009f40:	ffff7097          	auipc	ra,0xffff7
    80009f44:	1f0080e7          	jalr	496(ra) # 80001130 <_Z15thread_dispatchv>
    80009f48:	fe9ff06f          	j	80009f30 <_ZN6SystemC1Ev+0x4c>
        RiscV::finalize();
    80009f4c:	00002097          	auipc	ra,0x2
    80009f50:	988080e7          	jalr	-1656(ra) # 8000b8d4 <_ZN5RiscV8finalizeEv>
}
    80009f54:	01813083          	ld	ra,24(sp)
    80009f58:	01013403          	ld	s0,16(sp)
    80009f5c:	02010113          	addi	sp,sp,32
    80009f60:	00008067          	ret

0000000080009f64 <_ZN10ForkThread3runEv>:
    virtual void run() {
    80009f64:	fc010113          	addi	sp,sp,-64
    80009f68:	02113c23          	sd	ra,56(sp)
    80009f6c:	02813823          	sd	s0,48(sp)
    80009f70:	02913423          	sd	s1,40(sp)
    80009f74:	03213023          	sd	s2,32(sp)
    80009f78:	01313c23          	sd	s3,24(sp)
    80009f7c:	01413823          	sd	s4,16(sp)
    80009f80:	01513423          	sd	s5,8(sp)
    80009f84:	01613023          	sd	s6,0(sp)
    80009f88:	04010413          	addi	s0,sp,64
    80009f8c:	00050a13          	mv	s4,a0
        ConsoleUtil::print("Started thread id:",id,"\n");
    80009f90:	01000693          	li	a3,16
    80009f94:	00003617          	auipc	a2,0x3
    80009f98:	27c60613          	addi	a2,a2,636 # 8000d210 <kernelDataStart+0x37c>
    80009f9c:	01052583          	lw	a1,16(a0)
    80009fa0:	00003517          	auipc	a0,0x3
    80009fa4:	18050513          	addi	a0,a0,384 # 8000d120 <kernelDataStart+0x28c>
    80009fa8:	00003097          	auipc	ra,0x3
    80009fac:	ce8080e7          	jalr	-792(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        ForkThread* thread = new ForkThread(id + 1);
    80009fb0:	02000513          	li	a0,32
    80009fb4:	ffff7097          	auipc	ra,0xffff7
    80009fb8:	764080e7          	jalr	1892(ra) # 80001718 <_Znwm>
    80009fbc:	00050993          	mv	s3,a0
    80009fc0:	02050463          	beqz	a0,80009fe8 <_ZN10ForkThread3runEv+0x84>
    80009fc4:	010a3483          	ld	s1,16(s4)
    80009fc8:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80009fcc:	ffff8097          	auipc	ra,0xffff8
    80009fd0:	928080e7          	jalr	-1752(ra) # 800018f4 <_ZN6ThreadC1Ev>
    80009fd4:	00003797          	auipc	a5,0x3
    80009fd8:	4e478793          	addi	a5,a5,1252 # 8000d4b8 <_ZTV10ForkThread+0x10>
    80009fdc:	00f9b023          	sd	a5,0(s3)
    80009fe0:	0099b823          	sd	s1,16(s3)
    80009fe4:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80009fe8:	010a3503          	ld	a0,16(s4)
    80009fec:	00351513          	slli	a0,a0,0x3
    80009ff0:	ffff7097          	auipc	ra,0xffff7
    80009ff4:	030080e7          	jalr	48(ra) # 80001020 <_Z9mem_allocm>
    80009ff8:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    80009ffc:	10050863          	beqz	a0,8000a10c <_ZN10ForkThread3runEv+0x1a8>
            for (long i = 0; i < id; i++) {
    8000a000:	00000913          	li	s2,0
    8000a004:	0140006f          	j	8000a018 <_ZN10ForkThread3runEv+0xb4>
                threads[i] = new ForkThread(id);
    8000a008:	00391793          	slli	a5,s2,0x3
    8000a00c:	00fa87b3          	add	a5,s5,a5
    8000a010:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000a014:	00190913          	addi	s2,s2,1
    8000a018:	010a3783          	ld	a5,16(s4)
    8000a01c:	02f95e63          	bge	s2,a5,8000a058 <_ZN10ForkThread3runEv+0xf4>
                threads[i] = new ForkThread(id);
    8000a020:	02000513          	li	a0,32
    8000a024:	ffff7097          	auipc	ra,0xffff7
    8000a028:	6f4080e7          	jalr	1780(ra) # 80001718 <_Znwm>
    8000a02c:	00050493          	mv	s1,a0
    8000a030:	fc050ce3          	beqz	a0,8000a008 <_ZN10ForkThread3runEv+0xa4>
    8000a034:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000a038:	ffff8097          	auipc	ra,0xffff8
    8000a03c:	8bc080e7          	jalr	-1860(ra) # 800018f4 <_ZN6ThreadC1Ev>
    8000a040:	00003797          	auipc	a5,0x3
    8000a044:	47878793          	addi	a5,a5,1144 # 8000d4b8 <_ZTV10ForkThread+0x10>
    8000a048:	00f4b023          	sd	a5,0(s1)
    8000a04c:	0164b823          	sd	s6,16(s1)
    8000a050:	00048c23          	sb	zero,24(s1)
    8000a054:	fb5ff06f          	j	8000a008 <_ZN10ForkThread3runEv+0xa4>
            if (thread != nullptr) {
    8000a058:	06098a63          	beqz	s3,8000a0cc <_ZN10ForkThread3runEv+0x168>
                if (thread->start() == 0) {
    8000a05c:	00098513          	mv	a0,s3
    8000a060:	ffff8097          	auipc	ra,0xffff8
    8000a064:	984080e7          	jalr	-1660(ra) # 800019e4 <_ZN6Thread5startEv>
    8000a068:	00050913          	mv	s2,a0
    8000a06c:	04051863          	bnez	a0,8000a0bc <_ZN10ForkThread3runEv+0x158>
                    for (int i = 0; i < 5000; i++) {
    8000a070:	00050493          	mv	s1,a0
    8000a074:	0100006f          	j	8000a084 <_ZN10ForkThread3runEv+0x120>
                        thread_dispatch();
    8000a078:	ffff7097          	auipc	ra,0xffff7
    8000a07c:	0b8080e7          	jalr	184(ra) # 80001130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8000a080:	0014849b          	addiw	s1,s1,1
    8000a084:	000017b7          	lui	a5,0x1
    8000a088:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000a08c:	0097ce63          	blt	a5,s1,8000a0a8 <_ZN10ForkThread3runEv+0x144>
                        for (int j = 0; j < 5000; j++) {
    8000a090:	00090713          	mv	a4,s2
    8000a094:	000017b7          	lui	a5,0x1
    8000a098:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    8000a09c:	fce7cee3          	blt	a5,a4,8000a078 <_ZN10ForkThread3runEv+0x114>
    8000a0a0:	0017071b          	addiw	a4,a4,1
    8000a0a4:	ff1ff06f          	j	8000a094 <_ZN10ForkThread3runEv+0x130>
        return finished;
    8000a0a8:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    8000a0ac:	00079863          	bnez	a5,8000a0bc <_ZN10ForkThread3runEv+0x158>
                        thread_dispatch();
    8000a0b0:	ffff7097          	auipc	ra,0xffff7
    8000a0b4:	080080e7          	jalr	128(ra) # 80001130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8000a0b8:	ff1ff06f          	j	8000a0a8 <_ZN10ForkThread3runEv+0x144>
                delete thread;
    8000a0bc:	0009b783          	ld	a5,0(s3)
    8000a0c0:	0087b783          	ld	a5,8(a5)
    8000a0c4:	00098513          	mv	a0,s3
    8000a0c8:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    8000a0cc:	00000493          	li	s1,0
    8000a0d0:	0080006f          	j	8000a0d8 <_ZN10ForkThread3runEv+0x174>
            for (long i = 0; i < id; i++) {
    8000a0d4:	00148493          	addi	s1,s1,1
    8000a0d8:	010a3783          	ld	a5,16(s4)
    8000a0dc:	02f4d263          	bge	s1,a5,8000a100 <_ZN10ForkThread3runEv+0x19c>
                delete threads[i];
    8000a0e0:	00349793          	slli	a5,s1,0x3
    8000a0e4:	00fa87b3          	add	a5,s5,a5
    8000a0e8:	0007b503          	ld	a0,0(a5)
    8000a0ec:	fe0504e3          	beqz	a0,8000a0d4 <_ZN10ForkThread3runEv+0x170>
    8000a0f0:	00053783          	ld	a5,0(a0)
    8000a0f4:	0087b783          	ld	a5,8(a5)
    8000a0f8:	000780e7          	jalr	a5
    8000a0fc:	fd9ff06f          	j	8000a0d4 <_ZN10ForkThread3runEv+0x170>
            mem_free(threads);
    8000a100:	000a8513          	mv	a0,s5
    8000a104:	ffff7097          	auipc	ra,0xffff7
    8000a108:	f4c080e7          	jalr	-180(ra) # 80001050 <_Z8mem_freePv>
        ConsoleUtil::print("Finished thread id:",id,"\n");
    8000a10c:	01000693          	li	a3,16
    8000a110:	00003617          	auipc	a2,0x3
    8000a114:	10060613          	addi	a2,a2,256 # 8000d210 <kernelDataStart+0x37c>
    8000a118:	010a2583          	lw	a1,16(s4)
    8000a11c:	00003517          	auipc	a0,0x3
    8000a120:	01c50513          	addi	a0,a0,28 # 8000d138 <kernelDataStart+0x2a4>
    8000a124:	00003097          	auipc	ra,0x3
    8000a128:	b6c080e7          	jalr	-1172(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
        finished = true;
    8000a12c:	00100793          	li	a5,1
    8000a130:	00fa0c23          	sb	a5,24(s4)
    }
    8000a134:	03813083          	ld	ra,56(sp)
    8000a138:	03013403          	ld	s0,48(sp)
    8000a13c:	02813483          	ld	s1,40(sp)
    8000a140:	02013903          	ld	s2,32(sp)
    8000a144:	01813983          	ld	s3,24(sp)
    8000a148:	01013a03          	ld	s4,16(sp)
    8000a14c:	00813a83          	ld	s5,8(sp)
    8000a150:	00013b03          	ld	s6,0(sp)
    8000a154:	04010113          	addi	sp,sp,64
    8000a158:	00008067          	ret

000000008000a15c <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    8000a15c:	ff010113          	addi	sp,sp,-16
    8000a160:	00113423          	sd	ra,8(sp)
    8000a164:	00813023          	sd	s0,0(sp)
    8000a168:	01010413          	addi	s0,sp,16
    8000a16c:	00003797          	auipc	a5,0x3
    8000a170:	34c78793          	addi	a5,a5,844 # 8000d4b8 <_ZTV10ForkThread+0x10>
    8000a174:	00f53023          	sd	a5,0(a0)
    8000a178:	ffff7097          	auipc	ra,0xffff7
    8000a17c:	560080e7          	jalr	1376(ra) # 800016d8 <_ZN6ThreadD1Ev>
    8000a180:	00813083          	ld	ra,8(sp)
    8000a184:	00013403          	ld	s0,0(sp)
    8000a188:	01010113          	addi	sp,sp,16
    8000a18c:	00008067          	ret

000000008000a190 <_ZN10ForkThreadD0Ev>:
    8000a190:	fe010113          	addi	sp,sp,-32
    8000a194:	00113c23          	sd	ra,24(sp)
    8000a198:	00813823          	sd	s0,16(sp)
    8000a19c:	00913423          	sd	s1,8(sp)
    8000a1a0:	02010413          	addi	s0,sp,32
    8000a1a4:	00050493          	mv	s1,a0
    8000a1a8:	00003797          	auipc	a5,0x3
    8000a1ac:	31078793          	addi	a5,a5,784 # 8000d4b8 <_ZTV10ForkThread+0x10>
    8000a1b0:	00f53023          	sd	a5,0(a0)
    8000a1b4:	ffff7097          	auipc	ra,0xffff7
    8000a1b8:	524080e7          	jalr	1316(ra) # 800016d8 <_ZN6ThreadD1Ev>
    8000a1bc:	00048513          	mv	a0,s1
    8000a1c0:	ffff7097          	auipc	ra,0xffff7
    8000a1c4:	5a8080e7          	jalr	1448(ra) # 80001768 <_ZdlPv>
    8000a1c8:	01813083          	ld	ra,24(sp)
    8000a1cc:	01013403          	ld	s0,16(sp)
    8000a1d0:	00813483          	ld	s1,8(sp)
    8000a1d4:	02010113          	addi	sp,sp,32
    8000a1d8:	00008067          	ret

000000008000a1dc <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    8000a1dc:	ff010113          	addi	sp,sp,-16
    8000a1e0:	00813423          	sd	s0,8(sp)
    8000a1e4:	01010413          	addi	s0,sp,16
    8000a1e8:	00100793          	li	a5,1
    8000a1ec:	00f50863          	beq	a0,a5,8000a1fc <_Z41__static_initialization_and_destruction_0ii+0x20>
    8000a1f0:	00813403          	ld	s0,8(sp)
    8000a1f4:	01010113          	addi	sp,sp,16
    8000a1f8:	00008067          	ret
    8000a1fc:	000107b7          	lui	a5,0x10
    8000a200:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000a204:	fef596e3          	bne	a1,a5,8000a1f0 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    8000a208:	ffffc797          	auipc	a5,0xffffc
    8000a20c:	6287b783          	ld	a5,1576(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000a210:	0007b703          	ld	a4,0(a5)
    8000a214:	00c75793          	srli	a5,a4,0xc
    8000a218:	00278793          	addi	a5,a5,2
    8000a21c:	00c79793          	slli	a5,a5,0xc
    8000a220:	00003697          	auipc	a3,0x3
    8000a224:	35068693          	addi	a3,a3,848 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a228:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    8000a22c:	fffff7b7          	lui	a5,0xfffff
    8000a230:	00f77733          	and	a4,a4,a5
    8000a234:	00e6b423          	sd	a4,8(a3)
    8000a238:	fb9ff06f          	j	8000a1f0 <_Z41__static_initialization_and_destruction_0ii+0x14>

000000008000a23c <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    8000a23c:	ff010113          	addi	sp,sp,-16
    8000a240:	00813423          	sd	s0,8(sp)
    8000a244:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    8000a248:	00003717          	auipc	a4,0x3
    8000a24c:	32870713          	addi	a4,a4,808 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a250:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    8000a254:	ffffc797          	auipc	a5,0xffffc
    8000a258:	5dc7b783          	ld	a5,1500(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000a25c:	0007b783          	ld	a5,0(a5)
    8000a260:	fffff6b7          	lui	a3,0xfffff
    8000a264:	00d7f7b3          	and	a5,a5,a3
    8000a268:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    8000a26c:	00003797          	auipc	a5,0x3
    8000a270:	26b7b623          	sd	a1,620(a5) # 8000d4d8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    8000a274:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    8000a278:	00000713          	li	a4,0
        while(num>1){
    8000a27c:	00100693          	li	a3,1
    8000a280:	00f6f863          	bgeu	a3,a5,8000a290 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    8000a284:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000a288:	00170713          	addi	a4,a4,1
        while(num>1){
    8000a28c:	ff1ff06f          	j	8000a27c <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    8000a290:	00371713          	slli	a4,a4,0x3
    8000a294:	00003797          	auipc	a5,0x3
    8000a298:	2dc78793          	addi	a5,a5,732 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a29c:	00e78733          	add	a4,a5,a4
    8000a2a0:	00a73823          	sd	a0,16(a4)
    8000a2a4:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000a2a8:	00000713          	li	a4,0
        while(num>1){
    8000a2ac:	00100693          	li	a3,1
    8000a2b0:	00f6f863          	bgeu	a3,a5,8000a2c0 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    8000a2b4:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000a2b8:	00170713          	addi	a4,a4,1
        while(num>1){
    8000a2bc:	ff1ff06f          	j	8000a2ac <_ZN5Buddy10initializeEPvm+0x70>
    8000a2c0:	00371713          	slli	a4,a4,0x3
    8000a2c4:	00003797          	auipc	a5,0x3
    8000a2c8:	2ac78793          	addi	a5,a5,684 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a2cc:	00e78733          	add	a4,a5,a4
    8000a2d0:	06a73c23          	sd	a0,120(a4)
    8000a2d4:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000a2d8:	00000713          	li	a4,0
        while(num>1){
    8000a2dc:	00100693          	li	a3,1
    8000a2e0:	00f6f863          	bgeu	a3,a5,8000a2f0 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    8000a2e4:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000a2e8:	00170713          	addi	a4,a4,1
        while(num>1){
    8000a2ec:	ff1ff06f          	j	8000a2dc <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    8000a2f0:	00371713          	slli	a4,a4,0x3
    8000a2f4:	00003797          	auipc	a5,0x3
    8000a2f8:	27c78793          	addi	a5,a5,636 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a2fc:	00e78733          	add	a4,a5,a4
    8000a300:	01073783          	ld	a5,16(a4)
    8000a304:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    8000a308:	00000793          	li	a5,0
    8000a30c:	00c0006f          	j	8000a318 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    8000a310:	0015d593          	srli	a1,a1,0x1
            deg++;
    8000a314:	00178793          	addi	a5,a5,1
        while(num>1){
    8000a318:	00100713          	li	a4,1
    8000a31c:	feb76ae3          	bltu	a4,a1,8000a310 <_ZN5Buddy10initializeEPvm+0xd4>
    8000a320:	00379793          	slli	a5,a5,0x3
    8000a324:	00003717          	auipc	a4,0x3
    8000a328:	24c70713          	addi	a4,a4,588 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a32c:	00f707b3          	add	a5,a4,a5
    8000a330:	0787b783          	ld	a5,120(a5)
    8000a334:	0007b023          	sd	zero,0(a5)
}
    8000a338:	00813403          	ld	s0,8(sp)
    8000a33c:	01010113          	addi	sp,sp,16
    8000a340:	00008067          	ret

000000008000a344 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    8000a344:	00c00793          	li	a5,12
    8000a348:	10f50063          	beq	a0,a5,8000a448 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    8000a34c:	fd010113          	addi	sp,sp,-48
    8000a350:	02113423          	sd	ra,40(sp)
    8000a354:	02813023          	sd	s0,32(sp)
    8000a358:	00913c23          	sd	s1,24(sp)
    8000a35c:	01213823          	sd	s2,16(sp)
    8000a360:	01313423          	sd	s3,8(sp)
    8000a364:	03010413          	addi	s0,sp,48
    8000a368:	00050913          	mv	s2,a0
    Block *curr = head[size];
    8000a36c:	00351713          	slli	a4,a0,0x3
    8000a370:	00003797          	auipc	a5,0x3
    8000a374:	20078793          	addi	a5,a5,512 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a378:	00e787b3          	add	a5,a5,a4
    8000a37c:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    8000a380:	00000993          	li	s3,0
    8000a384:	0180006f          	j	8000a39c <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    8000a388:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    8000a38c:	04f70463          	beq	a4,a5,8000a3d4 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    8000a390:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    8000a394:	08f70063          	beq	a4,a5,8000a414 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    8000a398:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    8000a39c:	08048863          	beqz	s1,8000a42c <_ZN5Buddy8compressEm+0xe8>
    8000a3a0:	0004b683          	ld	a3,0(s1)
    8000a3a4:	08068463          	beqz	a3,8000a42c <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    8000a3a8:	00003797          	auipc	a5,0x3
    8000a3ac:	1c87b783          	ld	a5,456(a5) # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a3b0:	40f48733          	sub	a4,s1,a5
    8000a3b4:	00c9061b          	addiw	a2,s2,12
    8000a3b8:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    8000a3bc:	40f687b3          	sub	a5,a3,a5
    8000a3c0:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    8000a3c4:	00177613          	andi	a2,a4,1
    8000a3c8:	fc0610e3          	bnez	a2,8000a388 <_ZN5Buddy8compressEm+0x44>
    8000a3cc:	00170713          	addi	a4,a4,1
    8000a3d0:	fbdff06f          	j	8000a38c <_ZN5Buddy8compressEm+0x48>
            if(prev){
    8000a3d4:	00098863          	beqz	s3,8000a3e4 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    8000a3d8:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7fff0300>
    8000a3dc:	00d9b023          	sd	a3,0(s3)
    8000a3e0:	fb5ff06f          	j	8000a394 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    8000a3e4:	0006b603          	ld	a2,0(a3)
    8000a3e8:	00391593          	slli	a1,s2,0x3
    8000a3ec:	00003697          	auipc	a3,0x3
    8000a3f0:	18468693          	addi	a3,a3,388 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a3f4:	00b686b3          	add	a3,a3,a1
    8000a3f8:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    8000a3fc:	f8061ce3          	bnez	a2,8000a394 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    8000a400:	00003697          	auipc	a3,0x3
    8000a404:	17068693          	addi	a3,a3,368 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a408:	00b686b3          	add	a3,a3,a1
    8000a40c:	0006b823          	sd	zero,16(a3)
    8000a410:	f85ff06f          	j	8000a394 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    8000a414:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    8000a418:	00190593          	addi	a1,s2,1
    8000a41c:	00048513          	mv	a0,s1
    8000a420:	00000097          	auipc	ra,0x0
    8000a424:	02c080e7          	jalr	44(ra) # 8000a44c <_ZN5Buddy6insertEPvm>
    8000a428:	f71ff06f          	j	8000a398 <_ZN5Buddy8compressEm+0x54>
}
    8000a42c:	02813083          	ld	ra,40(sp)
    8000a430:	02013403          	ld	s0,32(sp)
    8000a434:	01813483          	ld	s1,24(sp)
    8000a438:	01013903          	ld	s2,16(sp)
    8000a43c:	00813983          	ld	s3,8(sp)
    8000a440:	03010113          	addi	sp,sp,48
    8000a444:	00008067          	ret
    8000a448:	00008067          	ret

000000008000a44c <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    8000a44c:	00050693          	mv	a3,a0
    if(!head[size]){
    8000a450:	00359713          	slli	a4,a1,0x3
    8000a454:	00003797          	auipc	a5,0x3
    8000a458:	11c78793          	addi	a5,a5,284 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a45c:	00e787b3          	add	a5,a5,a4
    8000a460:	0787b783          	ld	a5,120(a5)
    8000a464:	02078c63          	beqz	a5,8000a49c <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    8000a468:	ff010113          	addi	sp,sp,-16
    8000a46c:	00113423          	sd	ra,8(sp)
    8000a470:	00813023          	sd	s0,0(sp)
    8000a474:	01010413          	addi	s0,sp,16
    8000a478:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    8000a47c:	00068713          	mv	a4,a3
    8000a480:	04f6e063          	bltu	a3,a5,8000a4c0 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    8000a484:	00000613          	li	a2,0
            while (iter != nullptr) {
    8000a488:	06078863          	beqz	a5,8000a4f8 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    8000a48c:	04f76c63          	bltu	a4,a5,8000a4e4 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    8000a490:	00078613          	mv	a2,a5
                    iter = iter->next;
    8000a494:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    8000a498:	ff1ff06f          	j	8000a488 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    8000a49c:	00003797          	auipc	a5,0x3
    8000a4a0:	0d478793          	addi	a5,a5,212 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a4a4:	00e78533          	add	a0,a5,a4
    8000a4a8:	00d53823          	sd	a3,16(a0)
    8000a4ac:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    8000a4b0:	0006b023          	sd	zero,0(a3)
    8000a4b4:	07853783          	ld	a5,120(a0)
    8000a4b8:	0007b023          	sd	zero,0(a5)
        return;
    8000a4bc:	00008067          	ret
            newHead->next = head[size];
    8000a4c0:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    8000a4c4:	00359713          	slli	a4,a1,0x3
    8000a4c8:	00003797          	auipc	a5,0x3
    8000a4cc:	0a878793          	addi	a5,a5,168 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a4d0:	00e787b3          	add	a5,a5,a4
    8000a4d4:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    8000a4d8:	00000097          	auipc	ra,0x0
    8000a4dc:	e6c080e7          	jalr	-404(ra) # 8000a344 <_ZN5Buddy8compressEm>
            return;
    8000a4e0:	0440006f          	j	8000a524 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    8000a4e4:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    8000a4e8:	00d63023          	sd	a3,0(a2)
                    compress(size);
    8000a4ec:	00000097          	auipc	ra,0x0
    8000a4f0:	e58080e7          	jalr	-424(ra) # 8000a344 <_ZN5Buddy8compressEm>
                    return;
    8000a4f4:	0300006f          	j	8000a524 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    8000a4f8:	00351713          	slli	a4,a0,0x3
    8000a4fc:	00003797          	auipc	a5,0x3
    8000a500:	07478793          	addi	a5,a5,116 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a504:	00e787b3          	add	a5,a5,a4
    8000a508:	0107b703          	ld	a4,16(a5)
    8000a50c:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    8000a510:	0107b703          	ld	a4,16(a5)
    8000a514:	00073703          	ld	a4,0(a4)
    8000a518:	00e7b823          	sd	a4,16(a5)
    compress(size);
    8000a51c:	00000097          	auipc	ra,0x0
    8000a520:	e28080e7          	jalr	-472(ra) # 8000a344 <_ZN5Buddy8compressEm>
}
    8000a524:	00813083          	ld	ra,8(sp)
    8000a528:	00013403          	ld	s0,0(sp)
    8000a52c:	01010113          	addi	sp,sp,16
    8000a530:	00008067          	ret

000000008000a534 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    8000a534:	02050663          	beqz	a0,8000a560 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    8000a538:	ff010113          	addi	sp,sp,-16
    8000a53c:	00113423          	sd	ra,8(sp)
    8000a540:	00813023          	sd	s0,0(sp)
    8000a544:	01010413          	addi	s0,sp,16
    insert(addr,size);
    8000a548:	00000097          	auipc	ra,0x0
    8000a54c:	f04080e7          	jalr	-252(ra) # 8000a44c <_ZN5Buddy6insertEPvm>
}
    8000a550:	00813083          	ld	ra,8(sp)
    8000a554:	00013403          	ld	s0,0(sp)
    8000a558:	01010113          	addi	sp,sp,16
    8000a55c:	00008067          	ret
    8000a560:	00008067          	ret

000000008000a564 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000a564:	ff010113          	addi	sp,sp,-16
    8000a568:	00813423          	sd	s0,8(sp)
    8000a56c:	01010413          	addi	s0,sp,16
    8000a570:	03c0006f          	j	8000a5ac <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000a574:	00b5859b          	addiw	a1,a1,11
    8000a578:	00100713          	li	a4,1
    8000a57c:	00b715bb          	sllw	a1,a4,a1
    8000a580:	00b505b3          	add	a1,a0,a1
    8000a584:	00379693          	slli	a3,a5,0x3
    8000a588:	00003717          	auipc	a4,0x3
    8000a58c:	fe870713          	addi	a4,a4,-24 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a590:	00d70733          	add	a4,a4,a3
    8000a594:	00b73823          	sd	a1,16(a4)
    8000a598:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    8000a59c:	0005b023          	sd	zero,0(a1)
    8000a5a0:	07873703          	ld	a4,120(a4)
    8000a5a4:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000a5a8:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    8000a5ac:	fff5879b          	addiw	a5,a1,-1
    8000a5b0:	04c7c863          	blt	a5,a2,8000a600 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    8000a5b4:	00379693          	slli	a3,a5,0x3
    8000a5b8:	00003717          	auipc	a4,0x3
    8000a5bc:	fb870713          	addi	a4,a4,-72 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a5c0:	00d70733          	add	a4,a4,a3
    8000a5c4:	01073683          	ld	a3,16(a4)
    8000a5c8:	fa0686e3          	beqz	a3,8000a574 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000a5cc:	00b5859b          	addiw	a1,a1,11
    8000a5d0:	00100713          	li	a4,1
    8000a5d4:	00b715bb          	sllw	a1,a4,a1
    8000a5d8:	00b505b3          	add	a1,a0,a1
    8000a5dc:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    8000a5e0:	00379693          	slli	a3,a5,0x3
    8000a5e4:	00003717          	auipc	a4,0x3
    8000a5e8:	f8c70713          	addi	a4,a4,-116 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a5ec:	00d70733          	add	a4,a4,a3
    8000a5f0:	01073683          	ld	a3,16(a4)
    8000a5f4:	0006b683          	ld	a3,0(a3)
    8000a5f8:	00d73823          	sd	a3,16(a4)
    8000a5fc:	fadff06f          	j	8000a5a8 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    8000a600:	00813403          	ld	s0,8(sp)
    8000a604:	01010113          	addi	sp,sp,16
    8000a608:	00008067          	ret

000000008000a60c <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    8000a60c:	fe010113          	addi	sp,sp,-32
    8000a610:	00113c23          	sd	ra,24(sp)
    8000a614:	00813823          	sd	s0,16(sp)
    8000a618:	00913423          	sd	s1,8(sp)
    8000a61c:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    8000a620:	00c00793          	li	a5,12
    8000a624:	06a7ec63          	bltu	a5,a0,8000a69c <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    8000a628:	00050593          	mv	a1,a0
    8000a62c:	00c00793          	li	a5,12
    8000a630:	06b7ea63          	bltu	a5,a1,8000a6a4 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    8000a634:	00359713          	slli	a4,a1,0x3
    8000a638:	00003797          	auipc	a5,0x3
    8000a63c:	f3878793          	addi	a5,a5,-200 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a640:	00e787b3          	add	a5,a5,a4
    8000a644:	0787b483          	ld	s1,120(a5)
    8000a648:	00049663          	bnez	s1,8000a654 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    8000a64c:	00158593          	addi	a1,a1,1
    8000a650:	fddff06f          	j	8000a62c <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    8000a654:	0004b703          	ld	a4,0(s1)
    8000a658:	00359693          	slli	a3,a1,0x3
    8000a65c:	00003797          	auipc	a5,0x3
    8000a660:	f1478793          	addi	a5,a5,-236 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a664:	00d787b3          	add	a5,a5,a3
    8000a668:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    8000a66c:	00070e63          	beqz	a4,8000a688 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    8000a670:	0005061b          	sext.w	a2,a0
    8000a674:	0005859b          	sext.w	a1,a1
    8000a678:	00048513          	mv	a0,s1
    8000a67c:	00000097          	auipc	ra,0x0
    8000a680:	ee8080e7          	jalr	-280(ra) # 8000a564 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    8000a684:	0240006f          	j	8000a6a8 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    8000a688:	00003797          	auipc	a5,0x3
    8000a68c:	ee878793          	addi	a5,a5,-280 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a690:	00d787b3          	add	a5,a5,a3
    8000a694:	0007b823          	sd	zero,16(a5)
    8000a698:	fd9ff06f          	j	8000a670 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    8000a69c:	00000493          	li	s1,0
    8000a6a0:	0080006f          	j	8000a6a8 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    8000a6a4:	00000493          	li	s1,0
}
    8000a6a8:	00048513          	mv	a0,s1
    8000a6ac:	01813083          	ld	ra,24(sp)
    8000a6b0:	01013403          	ld	s0,16(sp)
    8000a6b4:	00813483          	ld	s1,8(sp)
    8000a6b8:	02010113          	addi	sp,sp,32
    8000a6bc:	00008067          	ret

000000008000a6c0 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    8000a6c0:	fe010113          	addi	sp,sp,-32
    8000a6c4:	00113c23          	sd	ra,24(sp)
    8000a6c8:	00813823          	sd	s0,16(sp)
    8000a6cc:	00913423          	sd	s1,8(sp)
    8000a6d0:	01213023          	sd	s2,0(sp)
    8000a6d4:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    8000a6d8:	00000913          	li	s2,0
    8000a6dc:	0180006f          	j	8000a6f4 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    8000a6e0:	00003517          	auipc	a0,0x3
    8000a6e4:	b3050513          	addi	a0,a0,-1232 # 8000d210 <kernelDataStart+0x37c>
    8000a6e8:	00002097          	auipc	ra,0x2
    8000a6ec:	488080e7          	jalr	1160(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    8000a6f0:	0019091b          	addiw	s2,s2,1
    8000a6f4:	00c00793          	li	a5,12
    8000a6f8:	0727c663          	blt	a5,s2,8000a764 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    8000a6fc:	00000613          	li	a2,0
    8000a700:	00a00593          	li	a1,10
    8000a704:	00090513          	mv	a0,s2
    8000a708:	00002097          	auipc	ra,0x2
    8000a70c:	4ac080e7          	jalr	1196(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    8000a710:	00003517          	auipc	a0,0x3
    8000a714:	a5850513          	addi	a0,a0,-1448 # 8000d168 <kernelDataStart+0x2d4>
    8000a718:	00002097          	auipc	ra,0x2
    8000a71c:	458080e7          	jalr	1112(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    8000a720:	00391713          	slli	a4,s2,0x3
    8000a724:	00003797          	auipc	a5,0x3
    8000a728:	e4c78793          	addi	a5,a5,-436 # 8000d570 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000a72c:	00e787b3          	add	a5,a5,a4
    8000a730:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    8000a734:	fa0486e3          	beqz	s1,8000a6e0 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    8000a738:	00000613          	li	a2,0
    8000a73c:	01000593          	li	a1,16
    8000a740:	0004851b          	sext.w	a0,s1
    8000a744:	00002097          	auipc	ra,0x2
    8000a748:	470080e7          	jalr	1136(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    8000a74c:	00003517          	auipc	a0,0x3
    8000a750:	81450513          	addi	a0,a0,-2028 # 8000cf60 <kernelDataStart+0xcc>
    8000a754:	00002097          	auipc	ra,0x2
    8000a758:	41c080e7          	jalr	1052(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    8000a75c:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    8000a760:	fd5ff06f          	j	8000a734 <_ZN5Buddy9printListEv+0x74>
    8000a764:	01813083          	ld	ra,24(sp)
    8000a768:	01013403          	ld	s0,16(sp)
    8000a76c:	00813483          	ld	s1,8(sp)
    8000a770:	00013903          	ld	s2,0(sp)
    8000a774:	02010113          	addi	sp,sp,32
    8000a778:	00008067          	ret

000000008000a77c <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    8000a77c:	ff010113          	addi	sp,sp,-16
    8000a780:	00113423          	sd	ra,8(sp)
    8000a784:	00813023          	sd	s0,0(sp)
    8000a788:	01010413          	addi	s0,sp,16
    8000a78c:	000105b7          	lui	a1,0x10
    8000a790:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000a794:	00100513          	li	a0,1
    8000a798:	00000097          	auipc	ra,0x0
    8000a79c:	a44080e7          	jalr	-1468(ra) # 8000a1dc <_Z41__static_initialization_and_destruction_0ii>
    8000a7a0:	00813083          	ld	ra,8(sp)
    8000a7a4:	00013403          	ld	s0,0(sp)
    8000a7a8:	01010113          	addi	sp,sp,16
    8000a7ac:	00008067          	ret

000000008000a7b0 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    8000a7b0:	ff010113          	addi	sp,sp,-16
    8000a7b4:	00813423          	sd	s0,8(sp)
    8000a7b8:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    8000a7bc:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    8000a7c0:	00053823          	sd	zero,16(a0)
}
    8000a7c4:	00813403          	ld	s0,8(sp)
    8000a7c8:	01010113          	addi	sp,sp,16
    8000a7cc:	00008067          	ret

000000008000a7d0 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    8000a7d0:	ff010113          	addi	sp,sp,-16
    8000a7d4:	00813423          	sd	s0,8(sp)
    8000a7d8:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    8000a7dc:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    8000a7e0:	00053823          	sd	zero,16(a0)
    8000a7e4:	00813403          	ld	s0,8(sp)
    8000a7e8:	01010113          	addi	sp,sp,16
    8000a7ec:	00008067          	ret

000000008000a7f0 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    8000a7f0:	ff010113          	addi	sp,sp,-16
    8000a7f4:	00113423          	sd	ra,8(sp)
    8000a7f8:	00813023          	sd	s0,0(sp)
    8000a7fc:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    8000a800:	00000697          	auipc	a3,0x0
    8000a804:	fd068693          	addi	a3,a3,-48 # 8000a7d0 <_ZN3SCB4dtorEPv>
    8000a808:	00000617          	auipc	a2,0x0
    8000a80c:	fa860613          	addi	a2,a2,-88 # 8000a7b0 <_ZN3SCB4ctorEPv>
    8000a810:	01800593          	li	a1,24
    8000a814:	00003517          	auipc	a0,0x3
    8000a818:	95c50513          	addi	a0,a0,-1700 # 8000d170 <kernelDataStart+0x2dc>
    8000a81c:	00002097          	auipc	ra,0x2
    8000a820:	530080e7          	jalr	1328(ra) # 8000cd4c <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000a824:	00003797          	auipc	a5,0x3
    8000a828:	e2a7b623          	sd	a0,-468(a5) # 8000d650 <_ZN3SCB8scbCacheE>
}
    8000a82c:	00813083          	ld	ra,8(sp)
    8000a830:	00013403          	ld	s0,0(sp)
    8000a834:	01010113          	addi	sp,sp,16
    8000a838:	00008067          	ret

000000008000a83c <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    8000a83c:	ff010113          	addi	sp,sp,-16
    8000a840:	00813423          	sd	s0,8(sp)
    8000a844:	01010413          	addi	s0,sp,16
    val = init;
    8000a848:	00b52023          	sw	a1,0(a0)
}
    8000a84c:	00813403          	ld	s0,8(sp)
    8000a850:	01010113          	addi	sp,sp,16
    8000a854:	00008067          	ret

000000008000a858 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    8000a858:	fe010113          	addi	sp,sp,-32
    8000a85c:	00113c23          	sd	ra,24(sp)
    8000a860:	00813823          	sd	s0,16(sp)
    8000a864:	00913423          	sd	s1,8(sp)
    8000a868:	01213023          	sd	s2,0(sp)
    8000a86c:	02010413          	addi	s0,sp,32
    8000a870:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    8000a874:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    8000a878:	02050063          	beqz	a0,8000a898 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    8000a87c:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    8000a880:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    8000a884:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    8000a888:	00002097          	auipc	ra,0x2
    8000a88c:	e10080e7          	jalr	-496(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    8000a890:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    8000a894:	fe5ff06f          	j	8000a878 <_ZN3SCBD1Ev+0x20>
}
    8000a898:	01813083          	ld	ra,24(sp)
    8000a89c:	01013403          	ld	s0,16(sp)
    8000a8a0:	00813483          	ld	s1,8(sp)
    8000a8a4:	00013903          	ld	s2,0(sp)
    8000a8a8:	02010113          	addi	sp,sp,32
    8000a8ac:	00008067          	ret

000000008000a8b0 <_ZN3SCB5blockEv>:
void SCB::block() {
    8000a8b0:	ff010113          	addi	sp,sp,-16
    8000a8b4:	00113423          	sd	ra,8(sp)
    8000a8b8:	00813023          	sd	s0,0(sp)
    8000a8bc:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    8000a8c0:	00853783          	ld	a5,8(a0)
    8000a8c4:	04078063          	beqz	a5,8000a904 <_ZN3SCB5blockEv+0x54>
    8000a8c8:	01053703          	ld	a4,16(a0)
    8000a8cc:	ffffc797          	auipc	a5,0xffffc
    8000a8d0:	0047b783          	ld	a5,4(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000a8d4:	0007b783          	ld	a5,0(a5)
    8000a8d8:	04f73423          	sd	a5,72(a4)
    8000a8dc:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    8000a8e0:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    8000a8e4:	00300713          	li	a4,3
    8000a8e8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    8000a8ec:	00000097          	auipc	ra,0x0
    8000a8f0:	308080e7          	jalr	776(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
}
    8000a8f4:	00813083          	ld	ra,8(sp)
    8000a8f8:	00013403          	ld	s0,0(sp)
    8000a8fc:	01010113          	addi	sp,sp,16
    8000a900:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    8000a904:	ffffc797          	auipc	a5,0xffffc
    8000a908:	fcc7b783          	ld	a5,-52(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000a90c:	0007b783          	ld	a5,0(a5)
    8000a910:	00f53423          	sd	a5,8(a0)
    8000a914:	fc9ff06f          	j	8000a8dc <_ZN3SCB5blockEv+0x2c>

000000008000a918 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    8000a918:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    8000a91c:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    8000a920:	04853703          	ld	a4,72(a0)
    8000a924:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    8000a928:	04053423          	sd	zero,72(a0)
    if(tcb) {
    8000a92c:	02050a63          	beqz	a0,8000a960 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    8000a930:	ff010113          	addi	sp,sp,-16
    8000a934:	00113423          	sd	ra,8(sp)
    8000a938:	00813023          	sd	s0,0(sp)
    8000a93c:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    8000a940:	00100793          	li	a5,1
    8000a944:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    8000a948:	00002097          	auipc	ra,0x2
    8000a94c:	d50080e7          	jalr	-688(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
}
    8000a950:	00813083          	ld	ra,8(sp)
    8000a954:	00013403          	ld	s0,0(sp)
    8000a958:	01010113          	addi	sp,sp,16
    8000a95c:	00008067          	ret
    8000a960:	00008067          	ret

000000008000a964 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    8000a964:	ffffc797          	auipc	a5,0xffffc
    8000a968:	f6c7b783          	ld	a5,-148(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000a96c:	0007b783          	ld	a5,0(a5)
    8000a970:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    8000a974:	00052783          	lw	a5,0(a0)
    8000a978:	fff7879b          	addiw	a5,a5,-1
    8000a97c:	00f52023          	sw	a5,0(a0)
    8000a980:	02079713          	slli	a4,a5,0x20
    8000a984:	00074463          	bltz	a4,8000a98c <_ZN3SCB4waitEv+0x28>
    8000a988:	00008067          	ret
void SCB::wait() {
    8000a98c:	ff010113          	addi	sp,sp,-16
    8000a990:	00113423          	sd	ra,8(sp)
    8000a994:	00813023          	sd	s0,0(sp)
    8000a998:	01010413          	addi	s0,sp,16
        block();
    8000a99c:	00000097          	auipc	ra,0x0
    8000a9a0:	f14080e7          	jalr	-236(ra) # 8000a8b0 <_ZN3SCB5blockEv>
}
    8000a9a4:	00813083          	ld	ra,8(sp)
    8000a9a8:	00013403          	ld	s0,0(sp)
    8000a9ac:	01010113          	addi	sp,sp,16
    8000a9b0:	00008067          	ret

000000008000a9b4 <_ZN3SCB6signalEv>:
    if(val++<0)
    8000a9b4:	00052783          	lw	a5,0(a0)
    8000a9b8:	0017871b          	addiw	a4,a5,1
    8000a9bc:	00e52023          	sw	a4,0(a0)
    8000a9c0:	0007c463          	bltz	a5,8000a9c8 <_ZN3SCB6signalEv+0x14>
    8000a9c4:	00008067          	ret
void SCB::signal(){
    8000a9c8:	ff010113          	addi	sp,sp,-16
    8000a9cc:	00113423          	sd	ra,8(sp)
    8000a9d0:	00813023          	sd	s0,0(sp)
    8000a9d4:	01010413          	addi	s0,sp,16
        deblock();
    8000a9d8:	00000097          	auipc	ra,0x0
    8000a9dc:	f40080e7          	jalr	-192(ra) # 8000a918 <_ZN3SCB7deblockEv>
}
    8000a9e0:	00813083          	ld	ra,8(sp)
    8000a9e4:	00013403          	ld	s0,0(sp)
    8000a9e8:	01010113          	addi	sp,sp,16
    8000a9ec:	00008067          	ret

000000008000a9f0 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    8000a9f0:	ff010113          	addi	sp,sp,-16
    8000a9f4:	00113423          	sd	ra,8(sp)
    8000a9f8:	00813023          	sd	s0,0(sp)
    8000a9fc:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    8000aa00:	00003517          	auipc	a0,0x3
    8000aa04:	c5053503          	ld	a0,-944(a0) # 8000d650 <_ZN3SCB8scbCacheE>
    8000aa08:	00002097          	auipc	ra,0x2
    8000aa0c:	36c080e7          	jalr	876(ra) # 8000cd74 <_Z16kmem_cache_allocP5Cache>
}
    8000aa10:	00813083          	ld	ra,8(sp)
    8000aa14:	00013403          	ld	s0,0(sp)
    8000aa18:	01010113          	addi	sp,sp,16
    8000aa1c:	00008067          	ret

000000008000aa20 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    8000aa20:	ff010113          	addi	sp,sp,-16
    8000aa24:	00113423          	sd	ra,8(sp)
    8000aa28:	00813023          	sd	s0,0(sp)
    8000aa2c:	01010413          	addi	s0,sp,16
    8000aa30:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    8000aa34:	00003517          	auipc	a0,0x3
    8000aa38:	c1c53503          	ld	a0,-996(a0) # 8000d650 <_ZN3SCB8scbCacheE>
    8000aa3c:	00002097          	auipc	ra,0x2
    8000aa40:	360080e7          	jalr	864(ra) # 8000cd9c <_Z15kmem_cache_freeP5CachePv>
}
    8000aa44:	00813083          	ld	ra,8(sp)
    8000aa48:	00013403          	ld	s0,0(sp)
    8000aa4c:	01010113          	addi	sp,sp,16
    8000aa50:	00008067          	ret

000000008000aa54 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    8000aa54:	ff010113          	addi	sp,sp,-16
    8000aa58:	00813423          	sd	s0,8(sp)
    8000aa5c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    8000aa60:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    8000aa64:	05200513          	li	a0,82
    asm("ecall");
    8000aa68:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000aa6c:	00050513          	mv	a0,a0
}
    8000aa70:	0005051b          	sext.w	a0,a0
    8000aa74:	00813403          	ld	s0,8(sp)
    8000aa78:	01010113          	addi	sp,sp,16
    8000aa7c:	00008067          	ret

000000008000aa80 <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/system.hpp"

int main() {
    8000aa80:	fe010113          	addi	sp,sp,-32
    8000aa84:	00113c23          	sd	ra,24(sp)
    8000aa88:	00813823          	sd	s0,16(sp)
    8000aa8c:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    8000aa90:	fe840513          	addi	a0,s0,-24
    8000aa94:	fffff097          	auipc	ra,0xfffff
    8000aa98:	450080e7          	jalr	1104(ra) # 80009ee4 <_ZN6SystemC1Ev>

    return 0;
    8000aa9c:	00000513          	li	a0,0
    8000aaa0:	01813083          	ld	ra,24(sp)
    8000aaa4:	01013403          	ld	s0,16(sp)
    8000aaa8:	02010113          	addi	sp,sp,32
    8000aaac:	00008067          	ret

000000008000aab0 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    8000aab0:	ff010113          	addi	sp,sp,-16
    8000aab4:	00813423          	sd	s0,8(sp)
    8000aab8:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    8000aabc:	00100793          	li	a5,1
    8000aac0:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    8000aac4:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    8000aac8:	00052a23          	sw	zero,20(a0)
}
    8000aacc:	00813403          	ld	s0,8(sp)
    8000aad0:	01010113          	addi	sp,sp,16
    8000aad4:	00008067          	ret

000000008000aad8 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    8000aad8:	ff010113          	addi	sp,sp,-16
    8000aadc:	00813423          	sd	s0,8(sp)
    8000aae0:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    8000aae4:	00100793          	li	a5,1
    8000aae8:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    8000aaec:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    8000aaf0:	00052a23          	sw	zero,20(a0)
    8000aaf4:	00813403          	ld	s0,8(sp)
    8000aaf8:	01010113          	addi	sp,sp,16
    8000aafc:	00008067          	ret

000000008000ab00 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    8000ab00:	ff010113          	addi	sp,sp,-16
    8000ab04:	00113423          	sd	ra,8(sp)
    8000ab08:	00813023          	sd	s0,0(sp)
    8000ab0c:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    8000ab10:	00001097          	auipc	ra,0x1
    8000ab14:	c04080e7          	jalr	-1020(ra) # 8000b714 <_ZN5RiscV10popSppSpieEv>
    TCBWrapper::tcbWrap(running);
    8000ab18:	00003517          	auipc	a0,0x3
    8000ab1c:	b4053503          	ld	a0,-1216(a0) # 8000d658 <_ZN3TCB7runningE>
    8000ab20:	ffff7097          	auipc	ra,0xffff7
    8000ab24:	064080e7          	jalr	100(ra) # 80001b84 <_ZN10TCBWrapper7tcbWrapEP3TCB>
}
    8000ab28:	00813083          	ld	ra,8(sp)
    8000ab2c:	00013403          	ld	s0,0(sp)
    8000ab30:	01010113          	addi	sp,sp,16
    8000ab34:	00008067          	ret

000000008000ab38 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    8000ab38:	ff010113          	addi	sp,sp,-16
    8000ab3c:	00813423          	sd	s0,8(sp)
    8000ab40:	01010413          	addi	s0,sp,16
    8000ab44:	04053823          	sd	zero,80(a0)
    8000ab48:	04053c23          	sd	zero,88(a0)
    8000ab4c:	06053023          	sd	zero,96(a0)
    this->body = body;
    8000ab50:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    8000ab54:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    8000ab58:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    8000ab5c:	02058a63          	beqz	a1,8000ab90 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    8000ab60:	00068793          	mv	a5,a3
    8000ab64:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    8000ab68:	02058863          	beqz	a1,8000ab98 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    8000ab6c:	000017b7          	lui	a5,0x1
    8000ab70:	00f686b3          	add	a3,a3,a5
    8000ab74:	00d53023          	sd	a3,0(a0)
    8000ab78:	00000797          	auipc	a5,0x0
    8000ab7c:	f8878793          	addi	a5,a5,-120 # 8000ab00 <_ZN3TCB7wrapperEPv>
    8000ab80:	00f53423          	sd	a5,8(a0)
}
    8000ab84:	00813403          	ld	s0,8(sp)
    8000ab88:	01010113          	addi	sp,sp,16
    8000ab8c:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    8000ab90:	00000793          	li	a5,0
    8000ab94:	fd1ff06f          	j	8000ab64 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    8000ab98:	00000693          	li	a3,0
    8000ab9c:	fd9ff06f          	j	8000ab74 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

000000008000aba0 <_ZN3TCB4freeEv>:
void TCB::free(){
    8000aba0:	ff010113          	addi	sp,sp,-16
    8000aba4:	00113423          	sd	ra,8(sp)
    8000aba8:	00813023          	sd	s0,0(sp)
    8000abac:	01010413          	addi	s0,sp,16
    kfree(stack);
    8000abb0:	02853503          	ld	a0,40(a0)
    8000abb4:	00002097          	auipc	ra,0x2
    8000abb8:	2b8080e7          	jalr	696(ra) # 8000ce6c <_Z5kfreePKv>
}
    8000abbc:	00813083          	ld	ra,8(sp)
    8000abc0:	00013403          	ld	s0,0(sp)
    8000abc4:	01010113          	addi	sp,sp,16
    8000abc8:	00008067          	ret

000000008000abcc <_ZN3TCBD1Ev>:
TCB::~TCB(){
    8000abcc:	ff010113          	addi	sp,sp,-16
    8000abd0:	00113423          	sd	ra,8(sp)
    8000abd4:	00813023          	sd	s0,0(sp)
    8000abd8:	01010413          	addi	s0,sp,16
    free();
    8000abdc:	00000097          	auipc	ra,0x0
    8000abe0:	fc4080e7          	jalr	-60(ra) # 8000aba0 <_ZN3TCB4freeEv>
}
    8000abe4:	00813083          	ld	ra,8(sp)
    8000abe8:	00013403          	ld	s0,0(sp)
    8000abec:	01010113          	addi	sp,sp,16
    8000abf0:	00008067          	ret

000000008000abf4 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    8000abf4:	fe010113          	addi	sp,sp,-32
    8000abf8:	00113c23          	sd	ra,24(sp)
    8000abfc:	00813823          	sd	s0,16(sp)
    8000ac00:	00913423          	sd	s1,8(sp)
    8000ac04:	02010413          	addi	s0,sp,32
    TCB* old = running;
    8000ac08:	00003497          	auipc	s1,0x3
    8000ac0c:	a504b483          	ld	s1,-1456(s1) # 8000d658 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    8000ac10:	0104a703          	lw	a4,16(s1)
    8000ac14:	00100793          	li	a5,1
    8000ac18:	04e7f663          	bgeu	a5,a4,8000ac64 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    8000ac1c:	00002097          	auipc	ra,0x2
    8000ac20:	ac4080e7          	jalr	-1340(ra) # 8000c6e0 <_ZN9Scheduler3getEv>
    8000ac24:	00003797          	auipc	a5,0x3
    8000ac28:	a2a7ba23          	sd	a0,-1484(a5) # 8000d658 <_ZN3TCB7runningE>
    if(running) {
    8000ac2c:	02050263          	beqz	a0,8000ac50 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    8000ac30:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    8000ac34:	00001097          	auipc	ra,0x1
    8000ac38:	c5c080e7          	jalr	-932(ra) # 8000b890 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    8000ac3c:	00003597          	auipc	a1,0x3
    8000ac40:	a1c5b583          	ld	a1,-1508(a1) # 8000d658 <_ZN3TCB7runningE>
    8000ac44:	00048513          	mv	a0,s1
    8000ac48:	ffffe097          	auipc	ra,0xffffe
    8000ac4c:	4d8080e7          	jalr	1240(ra) # 80009120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000ac50:	01813083          	ld	ra,24(sp)
    8000ac54:	01013403          	ld	s0,16(sp)
    8000ac58:	00813483          	ld	s1,8(sp)
    8000ac5c:	02010113          	addi	sp,sp,32
    8000ac60:	00008067          	ret
        Scheduler::put(old);
    8000ac64:	00048513          	mv	a0,s1
    8000ac68:	00002097          	auipc	ra,0x2
    8000ac6c:	a30080e7          	jalr	-1488(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
    8000ac70:	fadff06f          	j	8000ac1c <_ZN3TCB8dispatchEv+0x28>

000000008000ac74 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    8000ac74:	ff010113          	addi	sp,sp,-16
    8000ac78:	00113423          	sd	ra,8(sp)
    8000ac7c:	00813023          	sd	s0,0(sp)
    8000ac80:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    8000ac84:	00003517          	auipc	a0,0x3
    8000ac88:	9dc53503          	ld	a0,-1572(a0) # 8000d660 <_ZN3TCB8tcbCacheE>
    8000ac8c:	00002097          	auipc	ra,0x2
    8000ac90:	0e8080e7          	jalr	232(ra) # 8000cd74 <_Z16kmem_cache_allocP5Cache>
}
    8000ac94:	00813083          	ld	ra,8(sp)
    8000ac98:	00013403          	ld	s0,0(sp)
    8000ac9c:	01010113          	addi	sp,sp,16
    8000aca0:	00008067          	ret

000000008000aca4 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    8000aca4:	fe010113          	addi	sp,sp,-32
    8000aca8:	00113c23          	sd	ra,24(sp)
    8000acac:	00813823          	sd	s0,16(sp)
    8000acb0:	00913423          	sd	s1,8(sp)
    8000acb4:	01213023          	sd	s2,0(sp)
    8000acb8:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    8000acbc:	00000697          	auipc	a3,0x0
    8000acc0:	e1c68693          	addi	a3,a3,-484 # 8000aad8 <_ZN3TCB4dtorEPv>
    8000acc4:	00000617          	auipc	a2,0x0
    8000acc8:	dec60613          	addi	a2,a2,-532 # 8000aab0 <_ZN3TCB4ctorEPv>
    8000accc:	07000593          	li	a1,112
    8000acd0:	00002517          	auipc	a0,0x2
    8000acd4:	4b050513          	addi	a0,a0,1200 # 8000d180 <kernelDataStart+0x2ec>
    8000acd8:	00002097          	auipc	ra,0x2
    8000acdc:	074080e7          	jalr	116(ra) # 8000cd4c <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000ace0:	00003797          	auipc	a5,0x3
    8000ace4:	98a7b023          	sd	a0,-1664(a5) # 8000d660 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    8000ace8:	07000513          	li	a0,112
    8000acec:	00000097          	auipc	ra,0x0
    8000acf0:	f88080e7          	jalr	-120(ra) # 8000ac74 <_ZN3TCBnwEm>
    8000acf4:	00050493          	mv	s1,a0
    8000acf8:	00050e63          	beqz	a0,8000ad14 <_ZN3TCB10initializeEv+0x70>
    8000acfc:	00200713          	li	a4,2
    8000ad00:	00000693          	li	a3,0
    8000ad04:	00000613          	li	a2,0
    8000ad08:	00000593          	li	a1,0
    8000ad0c:	00000097          	auipc	ra,0x0
    8000ad10:	e2c080e7          	jalr	-468(ra) # 8000ab38 <_ZN3TCBC1EPFvPvES0_Pmm>
    8000ad14:	00003797          	auipc	a5,0x3
    8000ad18:	9497b223          	sd	s1,-1724(a5) # 8000d658 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    8000ad1c:	00100793          	li	a5,1
    8000ad20:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    8000ad24:	00001537          	lui	a0,0x1
    8000ad28:	00002097          	auipc	ra,0x2
    8000ad2c:	11c080e7          	jalr	284(ra) # 8000ce44 <_Z7kmallocm>
    8000ad30:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    8000ad34:	07000513          	li	a0,112
    8000ad38:	00000097          	auipc	ra,0x0
    8000ad3c:	f3c080e7          	jalr	-196(ra) # 8000ac74 <_ZN3TCBnwEm>
    8000ad40:	00050493          	mv	s1,a0
    8000ad44:	02050063          	beqz	a0,8000ad64 <_ZN3TCB10initializeEv+0xc0>
    8000ad48:	00200713          	li	a4,2
    8000ad4c:	00090693          	mv	a3,s2
    8000ad50:	00000613          	li	a2,0
    8000ad54:	ffffc597          	auipc	a1,0xffffc
    8000ad58:	b045b583          	ld	a1,-1276(a1) # 80006858 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000ad5c:	00000097          	auipc	ra,0x0
    8000ad60:	ddc080e7          	jalr	-548(ra) # 8000ab38 <_ZN3TCBC1EPFvPvES0_Pmm>
    8000ad64:	00003797          	auipc	a5,0x3
    8000ad68:	9097b223          	sd	s1,-1788(a5) # 8000d668 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    8000ad6c:	00100793          	li	a5,1
    8000ad70:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    8000ad74:	00048513          	mv	a0,s1
    8000ad78:	00002097          	auipc	ra,0x2
    8000ad7c:	920080e7          	jalr	-1760(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
}
    8000ad80:	01813083          	ld	ra,24(sp)
    8000ad84:	01013403          	ld	s0,16(sp)
    8000ad88:	00813483          	ld	s1,8(sp)
    8000ad8c:	00013903          	ld	s2,0(sp)
    8000ad90:	02010113          	addi	sp,sp,32
    8000ad94:	00008067          	ret

000000008000ad98 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    8000ad98:	ff010113          	addi	sp,sp,-16
    8000ad9c:	00113423          	sd	ra,8(sp)
    8000ada0:	00813023          	sd	s0,0(sp)
    8000ada4:	01010413          	addi	s0,sp,16
    8000ada8:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    8000adac:	00003517          	auipc	a0,0x3
    8000adb0:	8b453503          	ld	a0,-1868(a0) # 8000d660 <_ZN3TCB8tcbCacheE>
    8000adb4:	00002097          	auipc	ra,0x2
    8000adb8:	fe8080e7          	jalr	-24(ra) # 8000cd9c <_Z15kmem_cache_freeP5CachePv>
}
    8000adbc:	00813083          	ld	ra,8(sp)
    8000adc0:	00013403          	ld	s0,0(sp)
    8000adc4:	01010113          	addi	sp,sp,16
    8000adc8:	00008067          	ret

000000008000adcc <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    8000adcc:	ff010113          	addi	sp,sp,-16
    8000add0:	00813423          	sd	s0,8(sp)
    8000add4:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    8000add8:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    8000addc:	05100513          	li	a0,81
    asm("ecall");
    8000ade0:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000ade4:	00050513          	mv	a0,a0
}
    8000ade8:	0005051b          	sext.w	a0,a0
    8000adec:	00813403          	ld	s0,8(sp)
    8000adf0:	01010113          	addi	sp,sp,16
    8000adf4:	00008067          	ret

000000008000adf8 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    8000adf8:	ff010113          	addi	sp,sp,-16
    8000adfc:	00813423          	sd	s0,8(sp)
    8000ae00:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    8000ae04:	ffffc797          	auipc	a5,0xffffc
    8000ae08:	a2c7b783          	ld	a5,-1492(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000ae0c:	0007b783          	ld	a5,0(a5)
    8000ae10:	00c7d793          	srli	a5,a5,0xc
    8000ae14:	00278793          	addi	a5,a5,2
    8000ae18:	00c79793          	slli	a5,a5,0xc
    8000ae1c:	01000737          	lui	a4,0x1000
    8000ae20:	00e787b3          	add	a5,a5,a4
    8000ae24:	00003717          	auipc	a4,0x3
    8000ae28:	86470713          	addi	a4,a4,-1948 # 8000d688 <_ZN15MemoryAllocator11freeMemTailE>
    8000ae2c:	00f73023          	sd	a5,0(a4)
    8000ae30:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    8000ae34:	0007b823          	sd	zero,16(a5)
    8000ae38:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    8000ae3c:	00073823          	sd	zero,16(a4)
    8000ae40:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    8000ae44:	ffffc697          	auipc	a3,0xffffc
    8000ae48:	aa46b683          	ld	a3,-1372(a3) # 800068e8 <_GLOBAL_OFFSET_TABLE_+0xd0>
    8000ae4c:	0006b683          	ld	a3,0(a3)
    8000ae50:	40f686b3          	sub	a3,a3,a5
    8000ae54:	fe868693          	addi	a3,a3,-24
    8000ae58:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    8000ae5c:	00873783          	ld	a5,8(a4)
    8000ae60:	0007b823          	sd	zero,16(a5)

    initialized = true;
    8000ae64:	00100793          	li	a5,1
    8000ae68:	02f70023          	sb	a5,32(a4)
}
    8000ae6c:	00813403          	ld	s0,8(sp)
    8000ae70:	01010113          	addi	sp,sp,16
    8000ae74:	00008067          	ret

000000008000ae78 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    8000ae78:	ff010113          	addi	sp,sp,-16
    8000ae7c:	00813423          	sd	s0,8(sp)
    8000ae80:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    8000ae84:	14050663          	beqz	a0,8000afd0 <_ZN15MemoryAllocator7kmallocEm+0x158>
    8000ae88:	00050793          	mv	a5,a0
    8000ae8c:	00003517          	auipc	a0,0x3
    8000ae90:	80453503          	ld	a0,-2044(a0) # 8000d690 <_ZN15MemoryAllocator11freeMemHeadE>
    8000ae94:	0a050e63          	beqz	a0,8000af50 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    8000ae98:	00053703          	ld	a4,0(a0)
    8000ae9c:	12f76e63          	bltu	a4,a5,8000afd8 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    8000aea0:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    8000aea4:	00000613          	li	a2,0
    8000aea8:	00c0006f          	j	8000aeb4 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    8000aeac:	00050613          	mv	a2,a0
    8000aeb0:	01053503          	ld	a0,16(a0)
    8000aeb4:	00050863          	beqz	a0,8000aec4 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    8000aeb8:	00053683          	ld	a3,0(a0)
    8000aebc:	01878713          	addi	a4,a5,24
    8000aec0:	fee6e6e3          	bltu	a3,a4,8000aeac <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    8000aec4:	08050663          	beqz	a0,8000af50 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    8000aec8:	00053683          	ld	a3,0(a0)
    8000aecc:	01868713          	addi	a4,a3,24
    8000aed0:	00e50733          	add	a4,a0,a4
    8000aed4:	ffffc597          	auipc	a1,0xffffc
    8000aed8:	a145b583          	ld	a1,-1516(a1) # 800068e8 <_GLOBAL_OFFSET_TABLE_+0xd0>
    8000aedc:	0005b583          	ld	a1,0(a1)
    8000aee0:	00b76463          	bltu	a4,a1,8000aee8 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    8000aee4:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    8000aee8:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    8000aeec:	05700593          	li	a1,87
    8000aef0:	08d5f063          	bgeu	a1,a3,8000af70 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    8000aef4:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    8000aef8:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    8000aefc:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    8000af00:	01053583          	ld	a1,16(a0)
    8000af04:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    8000af08:	00853583          	ld	a1,8(a0)
    8000af0c:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    8000af10:	fe868693          	addi	a3,a3,-24
    8000af14:	00d7b023          	sd	a3,0(a5)

            if(prev)
    8000af18:	04060263          	beqz	a2,8000af5c <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    8000af1c:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    8000af20:	00002797          	auipc	a5,0x2
    8000af24:	7807b783          	ld	a5,1920(a5) # 8000d6a0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000af28:	06078463          	beqz	a5,8000af90 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    8000af2c:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    8000af30:	08070063          	beqz	a4,8000afb0 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    8000af34:	00873783          	ld	a5,8(a4)
    8000af38:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    8000af3c:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    8000af40:	00873783          	ld	a5,8(a4)
    8000af44:	06078063          	beqz	a5,8000afa4 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    8000af48:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    8000af4c:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    8000af50:	00813403          	ld	s0,8(sp)
    8000af54:	01010113          	addi	sp,sp,16
    8000af58:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    8000af5c:	00002697          	auipc	a3,0x2
    8000af60:	72c68693          	addi	a3,a3,1836 # 8000d688 <_ZN15MemoryAllocator11freeMemTailE>
    8000af64:	00f6b023          	sd	a5,0(a3)
    8000af68:	00f6b423          	sd	a5,8(a3)
    8000af6c:	fb5ff06f          	j	8000af20 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    8000af70:	00060863          	beqz	a2,8000af80 <_ZN15MemoryAllocator7kmallocEm+0x108>
    8000af74:	01053783          	ld	a5,16(a0)
    8000af78:	00f63823          	sd	a5,16(a2)
    8000af7c:	fa5ff06f          	j	8000af20 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    8000af80:	01053783          	ld	a5,16(a0)
    8000af84:	00002697          	auipc	a3,0x2
    8000af88:	70f6b623          	sd	a5,1804(a3) # 8000d690 <_ZN15MemoryAllocator11freeMemHeadE>
    8000af8c:	f95ff06f          	j	8000af20 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    8000af90:	00002797          	auipc	a5,0x2
    8000af94:	6f878793          	addi	a5,a5,1784 # 8000d688 <_ZN15MemoryAllocator11freeMemTailE>
    8000af98:	00a7b823          	sd	a0,16(a5)
    8000af9c:	00a7bc23          	sd	a0,24(a5)
    8000afa0:	fadff06f          	j	8000af4c <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    8000afa4:	00002797          	auipc	a5,0x2
    8000afa8:	6ea7be23          	sd	a0,1788(a5) # 8000d6a0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000afac:	fa1ff06f          	j	8000af4c <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    8000afb0:	00002797          	auipc	a5,0x2
    8000afb4:	6d878793          	addi	a5,a5,1752 # 8000d688 <_ZN15MemoryAllocator11freeMemTailE>
    8000afb8:	0107b703          	ld	a4,16(a5)
    8000afbc:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    8000afc0:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    8000afc4:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    8000afc8:	00a7b823          	sd	a0,16(a5)
    8000afcc:	f81ff06f          	j	8000af4c <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    8000afd0:	00000513          	li	a0,0
    8000afd4:	f7dff06f          	j	8000af50 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    8000afd8:	00000513          	li	a0,0
    8000afdc:	f75ff06f          	j	8000af50 <_ZN15MemoryAllocator7kmallocEm+0xd8>

000000008000afe0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    8000afe0:	ff010113          	addi	sp,sp,-16
    8000afe4:	00813423          	sd	s0,8(sp)
    8000afe8:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    8000afec:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    8000aff0:	00000713          	li	a4,0
    8000aff4:	00078a63          	beqz	a5,8000b008 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    8000aff8:	00a7f863          	bgeu	a5,a0,8000b008 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    8000affc:	00078713          	mv	a4,a5
    8000b000:	0107b783          	ld	a5,16(a5)
    8000b004:	ff1ff06f          	j	8000aff4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    8000b008:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    8000b00c:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    8000b010:	00078463          	beqz	a5,8000b018 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    8000b014:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    8000b018:	02070263          	beqz	a4,8000b03c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    8000b01c:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    8000b020:	0005b703          	ld	a4,0(a1)
    8000b024:	00002797          	auipc	a5,0x2
    8000b028:	66c7b783          	ld	a5,1644(a5) # 8000d690 <_ZN15MemoryAllocator11freeMemHeadE>
    8000b02c:	00f70c63          	beq	a4,a5,8000b044 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    8000b030:	00813403          	ld	s0,8(sp)
    8000b034:	01010113          	addi	sp,sp,16
    8000b038:	00008067          	ret
        *head = blk;
    8000b03c:	00a5b023          	sd	a0,0(a1)
    8000b040:	fe1ff06f          	j	8000b020 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    8000b044:	01053783          	ld	a5,16(a0)
    8000b048:	00078a63          	beqz	a5,8000b05c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    8000b04c:	00053683          	ld	a3,0(a0)
    8000b050:	00d50733          	add	a4,a0,a3
    8000b054:	01870713          	addi	a4,a4,24
    8000b058:	02f70e63          	beq	a4,a5,8000b094 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    8000b05c:	00853783          	ld	a5,8(a0)
    8000b060:	fc0788e3          	beqz	a5,8000b030 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    8000b064:	0007b683          	ld	a3,0(a5)
    8000b068:	00d78733          	add	a4,a5,a3
    8000b06c:	01870713          	addi	a4,a4,24
    8000b070:	fca710e3          	bne	a4,a0,8000b030 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    8000b074:	00053703          	ld	a4,0(a0)
    8000b078:	00e68733          	add	a4,a3,a4
    8000b07c:	01870713          	addi	a4,a4,24
    8000b080:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    8000b084:	00853783          	ld	a5,8(a0)
    8000b088:	01053703          	ld	a4,16(a0)
    8000b08c:	00e7b823          	sd	a4,16(a5)
}
    8000b090:	fa1ff06f          	j	8000b030 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    8000b094:	0007b703          	ld	a4,0(a5)
    8000b098:	00e68733          	add	a4,a3,a4
    8000b09c:	01870713          	addi	a4,a4,24
    8000b0a0:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    8000b0a4:	0107b783          	ld	a5,16(a5)
    8000b0a8:	00f53823          	sd	a5,16(a0)
    8000b0ac:	fb1ff06f          	j	8000b05c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

000000008000b0b0 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    8000b0b0:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    8000b0b4:	00002697          	auipc	a3,0x2
    8000b0b8:	5ec6b683          	ld	a3,1516(a3) # 8000d6a0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000b0bc:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    8000b0c0:	00050a63          	beqz	a0,8000b0d4 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    8000b0c4:	fe870793          	addi	a5,a4,-24
    8000b0c8:	00a78663          	beq	a5,a0,8000b0d4 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    8000b0cc:	01053503          	ld	a0,16(a0)
    8000b0d0:	ff1ff06f          	j	8000b0c0 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    8000b0d4:	08050463          	beqz	a0,8000b15c <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    8000b0d8:	ff010113          	addi	sp,sp,-16
    8000b0dc:	00113423          	sd	ra,8(sp)
    8000b0e0:	00813023          	sd	s0,0(sp)
    8000b0e4:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    8000b0e8:	00002797          	auipc	a5,0x2
    8000b0ec:	5b07b783          	ld	a5,1456(a5) # 8000d698 <_ZN15MemoryAllocator12allocMemTailE>
    8000b0f0:	04a78663          	beq	a5,a0,8000b13c <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    8000b0f4:	04d50c63          	beq	a0,a3,8000b14c <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    8000b0f8:	01053783          	ld	a5,16(a0)
    8000b0fc:	00078663          	beqz	a5,8000b108 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    8000b100:	00853703          	ld	a4,8(a0)
    8000b104:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    8000b108:	00853783          	ld	a5,8(a0)
    8000b10c:	00078663          	beqz	a5,8000b118 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    8000b110:	01053703          	ld	a4,16(a0)
    8000b114:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    8000b118:	00002597          	auipc	a1,0x2
    8000b11c:	57858593          	addi	a1,a1,1400 # 8000d690 <_ZN15MemoryAllocator11freeMemHeadE>
    8000b120:	00000097          	auipc	ra,0x0
    8000b124:	ec0080e7          	jalr	-320(ra) # 8000afe0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    8000b128:	00000513          	li	a0,0
}
    8000b12c:	00813083          	ld	ra,8(sp)
    8000b130:	00013403          	ld	s0,0(sp)
    8000b134:	01010113          	addi	sp,sp,16
    8000b138:	00008067          	ret
            allocMemTail = blk->prev;
    8000b13c:	00853783          	ld	a5,8(a0)
    8000b140:	00002717          	auipc	a4,0x2
    8000b144:	54f73c23          	sd	a5,1368(a4) # 8000d698 <_ZN15MemoryAllocator12allocMemTailE>
    8000b148:	fadff06f          	j	8000b0f4 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    8000b14c:	01053783          	ld	a5,16(a0)
    8000b150:	00002717          	auipc	a4,0x2
    8000b154:	54f73823          	sd	a5,1360(a4) # 8000d6a0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000b158:	fa1ff06f          	j	8000b0f8 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    8000b15c:	fff00513          	li	a0,-1
}
    8000b160:	00008067          	ret

000000008000b164 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    8000b164:	fe010113          	addi	sp,sp,-32
    8000b168:	00113c23          	sd	ra,24(sp)
    8000b16c:	00813823          	sd	s0,16(sp)
    8000b170:	00913423          	sd	s1,8(sp)
    8000b174:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    8000b178:	00002497          	auipc	s1,0x2
    8000b17c:	5284b483          	ld	s1,1320(s1) # 8000d6a0 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    8000b180:	00002517          	auipc	a0,0x2
    8000b184:	01050513          	addi	a0,a0,16 # 8000d190 <kernelDataStart+0x2fc>
    8000b188:	ffff6097          	auipc	ra,0xffff6
    8000b18c:	240080e7          	jalr	576(ra) # 800013c8 <_Z11printStringPKc>
    while(iter!=nullptr){
    8000b190:	04048663          	beqz	s1,8000b1dc <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    8000b194:	00000613          	li	a2,0
    8000b198:	00a00593          	li	a1,10
    8000b19c:	0004851b          	sext.w	a0,s1
    8000b1a0:	ffff6097          	auipc	ra,0xffff6
    8000b1a4:	3c0080e7          	jalr	960(ra) # 80001560 <_Z8printIntiii>
        putc(' ');
    8000b1a8:	02000513          	li	a0,32
    8000b1ac:	ffff6097          	auipc	ra,0xffff6
    8000b1b0:	180080e7          	jalr	384(ra) # 8000132c <_Z4putcc>
        printInt(iter->size);
    8000b1b4:	00000613          	li	a2,0
    8000b1b8:	00a00593          	li	a1,10
    8000b1bc:	0004a503          	lw	a0,0(s1)
    8000b1c0:	ffff6097          	auipc	ra,0xffff6
    8000b1c4:	3a0080e7          	jalr	928(ra) # 80001560 <_Z8printIntiii>
        putc('\n');
    8000b1c8:	00a00513          	li	a0,10
    8000b1cc:	ffff6097          	auipc	ra,0xffff6
    8000b1d0:	160080e7          	jalr	352(ra) # 8000132c <_Z4putcc>
        iter=iter->next;
    8000b1d4:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    8000b1d8:	fb9ff06f          	j	8000b190 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    8000b1dc:	00002517          	auipc	a0,0x2
    8000b1e0:	fd450513          	addi	a0,a0,-44 # 8000d1b0 <kernelDataStart+0x31c>
    8000b1e4:	ffff6097          	auipc	ra,0xffff6
    8000b1e8:	1e4080e7          	jalr	484(ra) # 800013c8 <_Z11printStringPKc>
    iter = freeMemHead;
    8000b1ec:	00002497          	auipc	s1,0x2
    8000b1f0:	4a44b483          	ld	s1,1188(s1) # 8000d690 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    8000b1f4:	04048663          	beqz	s1,8000b240 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    8000b1f8:	00000613          	li	a2,0
    8000b1fc:	00a00593          	li	a1,10
    8000b200:	0004851b          	sext.w	a0,s1
    8000b204:	ffff6097          	auipc	ra,0xffff6
    8000b208:	35c080e7          	jalr	860(ra) # 80001560 <_Z8printIntiii>
        putc(' ');
    8000b20c:	02000513          	li	a0,32
    8000b210:	ffff6097          	auipc	ra,0xffff6
    8000b214:	11c080e7          	jalr	284(ra) # 8000132c <_Z4putcc>
        printInt(iter->size);
    8000b218:	00000613          	li	a2,0
    8000b21c:	00a00593          	li	a1,10
    8000b220:	0004a503          	lw	a0,0(s1)
    8000b224:	ffff6097          	auipc	ra,0xffff6
    8000b228:	33c080e7          	jalr	828(ra) # 80001560 <_Z8printIntiii>
        putc('\n');
    8000b22c:	00a00513          	li	a0,10
    8000b230:	ffff6097          	auipc	ra,0xffff6
    8000b234:	0fc080e7          	jalr	252(ra) # 8000132c <_Z4putcc>
        iter=iter->next;
    8000b238:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    8000b23c:	fb9ff06f          	j	8000b1f4 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    8000b240:	00002517          	auipc	a0,0x2
    8000b244:	f9050513          	addi	a0,a0,-112 # 8000d1d0 <kernelDataStart+0x33c>
    8000b248:	ffff6097          	auipc	ra,0xffff6
    8000b24c:	180080e7          	jalr	384(ra) # 800013c8 <_Z11printStringPKc>
}
    8000b250:	01813083          	ld	ra,24(sp)
    8000b254:	01013403          	ld	s0,16(sp)
    8000b258:	00813483          	ld	s1,8(sp)
    8000b25c:	02010113          	addi	sp,sp,32
    8000b260:	00008067          	ret

000000008000b264 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    8000b264:	ff010113          	addi	sp,sp,-16
    8000b268:	00813423          	sd	s0,8(sp)
    8000b26c:	01010413          	addi	s0,sp,16
    8000b270:	00050813          	mv	a6,a0
    8000b274:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    8000b278:	00000793          	li	a5,0
    8000b27c:	00c7fe63          	bgeu	a5,a2,8000b298 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    8000b280:	00f50733          	add	a4,a0,a5
    8000b284:	00f806b3          	add	a3,a6,a5
    8000b288:	0006c683          	lbu	a3,0(a3)
    8000b28c:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    8000b290:	00178793          	addi	a5,a5,1
    8000b294:	fe9ff06f          	j	8000b27c <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    8000b298:	00813403          	ld	s0,8(sp)
    8000b29c:	01010113          	addi	sp,sp,16
    8000b2a0:	00008067          	ret

000000008000b2a4 <_ZN5RiscV6getPMTEv>:
extern char *kernelTextStart;
extern char *kernelDataStart;
extern char *userTextStart;
extern char *etext;

void* RiscV::getPMT(){
    8000b2a4:	ff010113          	addi	sp,sp,-16
    8000b2a8:	00113423          	sd	ra,8(sp)
    8000b2ac:	00813023          	sd	s0,0(sp)
    8000b2b0:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    8000b2b4:	00100513          	li	a0,1
    8000b2b8:	fffff097          	auipc	ra,0xfffff
    8000b2bc:	354080e7          	jalr	852(ra) # 8000a60c <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    8000b2c0:	00000793          	li	a5,0
    8000b2c4:	1ff00713          	li	a4,511
    8000b2c8:	00f74c63          	blt	a4,a5,8000b2e0 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    8000b2cc:	00379713          	slli	a4,a5,0x3
    8000b2d0:	00e50733          	add	a4,a0,a4
    8000b2d4:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    8000b2d8:	0017879b          	addiw	a5,a5,1
    8000b2dc:	fe9ff06f          	j	8000b2c4 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    8000b2e0:	00813083          	ld	ra,8(sp)
    8000b2e4:	00013403          	ld	s0,0(sp)
    8000b2e8:	01010113          	addi	sp,sp,16
    8000b2ec:	00008067          	ret

000000008000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    8000b2f0:	fc010113          	addi	sp,sp,-64
    8000b2f4:	02113c23          	sd	ra,56(sp)
    8000b2f8:	02813823          	sd	s0,48(sp)
    8000b2fc:	02913423          	sd	s1,40(sp)
    8000b300:	03213023          	sd	s2,32(sp)
    8000b304:	01313c23          	sd	s3,24(sp)
    8000b308:	01413823          	sd	s4,16(sp)
    8000b30c:	01513423          	sd	s5,8(sp)
    8000b310:	04010413          	addi	s0,sp,64
    8000b314:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    8000b318:	01e5d793          	srli	a5,a1,0x1e
    8000b31c:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    8000b320:	0155d913          	srli	s2,a1,0x15
    8000b324:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    8000b328:	00c5d493          	srli	s1,a1,0xc
    8000b32c:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    8000b330:	00379793          	slli	a5,a5,0x3
    8000b334:	00f50ab3          	add	s5,a0,a5
    8000b338:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    8000b33c:	06078263          	beqz	a5,8000b3a0 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    8000b340:	00a7d513          	srli	a0,a5,0xa
    8000b344:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    8000b348:	00391913          	slli	s2,s2,0x3
    8000b34c:	01250933          	add	s2,a0,s2
    8000b350:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    8000b354:	06050463          	beqz	a0,8000b3bc <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    8000b358:	00a55513          	srli	a0,a0,0xa
    8000b35c:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    8000b360:	003a1a13          	slli	s4,s4,0x3
    8000b364:	01450533          	add	a0,a0,s4
    8000b368:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0)
    8000b36c:	00079863          	bnez	a5,8000b37c <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64*)pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    8000b370:	00a49493          	slli	s1,s1,0xa
    8000b374:	0134e9b3          	or	s3,s1,s3
    8000b378:	01353023          	sd	s3,0(a0)
}
    8000b37c:	03813083          	ld	ra,56(sp)
    8000b380:	03013403          	ld	s0,48(sp)
    8000b384:	02813483          	ld	s1,40(sp)
    8000b388:	02013903          	ld	s2,32(sp)
    8000b38c:	01813983          	ld	s3,24(sp)
    8000b390:	01013a03          	ld	s4,16(sp)
    8000b394:	00813a83          	ld	s5,8(sp)
    8000b398:	04010113          	addi	sp,sp,64
    8000b39c:	00008067          	ret
        pmt1 = RiscV::getPMT();
    8000b3a0:	00000097          	auipc	ra,0x0
    8000b3a4:	f04080e7          	jalr	-252(ra) # 8000b2a4 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    8000b3a8:	00c55793          	srli	a5,a0,0xc
    8000b3ac:	00a79793          	slli	a5,a5,0xa
    8000b3b0:	0017e793          	ori	a5,a5,1
    8000b3b4:	00fab023          	sd	a5,0(s5)
    8000b3b8:	f91ff06f          	j	8000b348 <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    8000b3bc:	00000097          	auipc	ra,0x0
    8000b3c0:	ee8080e7          	jalr	-280(ra) # 8000b2a4 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    8000b3c4:	00c55793          	srli	a5,a0,0xc
    8000b3c8:	00a79793          	slli	a5,a5,0xa
    8000b3cc:	0017e793          	ori	a5,a5,1
    8000b3d0:	00f93023          	sd	a5,0(s2)
    8000b3d4:	f8dff06f          	j	8000b360 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

000000008000b3d8 <_ZN5RiscV10initializeEv>:
//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    8000b3d8:	fc010113          	addi	sp,sp,-64
    8000b3dc:	02113c23          	sd	ra,56(sp)
    8000b3e0:	02813823          	sd	s0,48(sp)
    8000b3e4:	02913423          	sd	s1,40(sp)
    8000b3e8:	03213023          	sd	s2,32(sp)
    8000b3ec:	01313c23          	sd	s3,24(sp)
    8000b3f0:	01413823          	sd	s4,16(sp)
    8000b3f4:	01513423          	sd	s5,8(sp)
    8000b3f8:	04010413          	addi	s0,sp,64
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    8000b3fc:	ffffb797          	auipc	a5,0xffffb
    8000b400:	4ac7b783          	ld	a5,1196(a5) # 800068a8 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    8000b404:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    8000b408:	ffffb797          	auipc	a5,0xffffb
    8000b40c:	4287b783          	ld	a5,1064(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000b410:	0007b503          	ld	a0,0(a5)
    8000b414:	00c55513          	srli	a0,a0,0xc
    8000b418:	00250513          	addi	a0,a0,2
    8000b41c:	000015b7          	lui	a1,0x1
    8000b420:	00c51513          	slli	a0,a0,0xc
    8000b424:	00002097          	auipc	ra,0x2
    8000b428:	900080e7          	jalr	-1792(ra) # 8000cd24 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    8000b42c:	00000097          	auipc	ra,0x0
    8000b430:	9cc080e7          	jalr	-1588(ra) # 8000adf8 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    8000b434:	00001097          	auipc	ra,0x1
    8000b438:	24c080e7          	jalr	588(ra) # 8000c680 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000b43c:	00000097          	auipc	ra,0x0
    8000b440:	868080e7          	jalr	-1944(ra) # 8000aca4 <_ZN3TCB10initializeEv>
    SCB::initialize();
    8000b444:	fffff097          	auipc	ra,0xfffff
    8000b448:	3ac080e7          	jalr	940(ra) # 8000a7f0 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    8000b44c:	00001097          	auipc	ra,0x1
    8000b450:	448080e7          	jalr	1096(ra) # 8000c894 <_ZN11ConsoleUtil10initializeEv>
    RiscV::kPMT = RiscV::getPMT();
    8000b454:	00000097          	auipc	ra,0x0
    8000b458:	e50080e7          	jalr	-432(ra) # 8000b2a4 <_ZN5RiscV6getPMTEv>
    8000b45c:	00002797          	auipc	a5,0x2
    8000b460:	24a7ba23          	sd	a0,596(a5) # 8000d6b0 <_ZN5RiscV4kPMTE>
    uint64 uTextStart = (uint64)(&userTextStart);
    8000b464:	ffffb917          	auipc	s2,0xffffb
    8000b468:	47493903          	ld	s2,1140(s2) # 800068d8 <_GLOBAL_OFFSET_TABLE_+0xc0>
    uint64 eText = (uint64)(&etext);
    8000b46c:	ffffb497          	auipc	s1,0xffffb
    8000b470:	4244b483          	ld	s1,1060(s1) # 80006890 <_GLOBAL_OFFSET_TABLE_+0x78>
    uint64 kTextStart = (uint64)(&kernelTextStart);
    8000b474:	ffffba97          	auipc	s5,0xffffb
    8000b478:	3c4aba83          	ld	s5,964(s5) # 80006838 <_GLOBAL_OFFSET_TABLE_+0x20>
    uint64 kDataStart = (uint64)(&kernelDataStart);
    8000b47c:	ffffba17          	auipc	s4,0xffffb
    8000b480:	3d4a3a03          	ld	s4,980(s4) # 80006850 <_GLOBAL_OFFSET_TABLE_+0x38>

    for(uint64 i=0x80000000;i< uTextStart;i+=4096) {
    8000b484:	00100993          	li	s3,1
    8000b488:	01f99993          	slli	s3,s3,0x1f
    8000b48c:	0329f463          	bgeu	s3,s2,8000b4b4 <_ZN5RiscV10initializeEv+0xdc>
        handlePageFault(kPMT,i, 0xb);
    8000b490:	00b00613          	li	a2,11
    8000b494:	00098593          	mv	a1,s3
    8000b498:	00002517          	auipc	a0,0x2
    8000b49c:	21853503          	ld	a0,536(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b4a0:	00000097          	auipc	ra,0x0
    8000b4a4:	e50080e7          	jalr	-432(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=0x80000000;i< uTextStart;i+=4096) {
    8000b4a8:	000017b7          	lui	a5,0x1
    8000b4ac:	00f989b3          	add	s3,s3,a5
    8000b4b0:	fddff06f          	j	8000b48c <_ZN5RiscV10initializeEv+0xb4>
    }

    for(uint64 i=uTextStart;i<eText;i+=4096) {
    8000b4b4:	02997463          	bgeu	s2,s1,8000b4dc <_ZN5RiscV10initializeEv+0x104>
        handlePageFault(kPMT,i, 0x1b);
    8000b4b8:	01b00613          	li	a2,27
    8000b4bc:	00090593          	mv	a1,s2
    8000b4c0:	00002517          	auipc	a0,0x2
    8000b4c4:	1f053503          	ld	a0,496(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b4c8:	00000097          	auipc	ra,0x0
    8000b4cc:	e28080e7          	jalr	-472(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=uTextStart;i<eText;i+=4096) {
    8000b4d0:	000017b7          	lui	a5,0x1
    8000b4d4:	00f90933          	add	s2,s2,a5
    8000b4d8:	fddff06f          	j	8000b4b4 <_ZN5RiscV10initializeEv+0xdc>
    }

    for(uint64 i = (uint64)(&etext); i<kTextStart;i+=4096){
    8000b4dc:	0354f463          	bgeu	s1,s5,8000b504 <_ZN5RiscV10initializeEv+0x12c>
        handlePageFault(kPMT,i, 0x17);
    8000b4e0:	01700613          	li	a2,23
    8000b4e4:	00048593          	mv	a1,s1
    8000b4e8:	00002517          	auipc	a0,0x2
    8000b4ec:	1c853503          	ld	a0,456(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b4f0:	00000097          	auipc	ra,0x0
    8000b4f4:	e00080e7          	jalr	-512(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i = (uint64)(&etext); i<kTextStart;i+=4096){
    8000b4f8:	000017b7          	lui	a5,0x1
    8000b4fc:	00f484b3          	add	s1,s1,a5
    8000b500:	fddff06f          	j	8000b4dc <_ZN5RiscV10initializeEv+0x104>
    }

    for(uint64 i=(uint64)(&kernelTextStart);i<kDataStart;i+=4096) {
    8000b504:	000a8493          	mv	s1,s5
    8000b508:	0344f463          	bgeu	s1,s4,8000b530 <_ZN5RiscV10initializeEv+0x158>
        handlePageFault(kPMT,i, 0xb);
    8000b50c:	00b00613          	li	a2,11
    8000b510:	00048593          	mv	a1,s1
    8000b514:	00002517          	auipc	a0,0x2
    8000b518:	19c53503          	ld	a0,412(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b51c:	00000097          	auipc	ra,0x0
    8000b520:	dd4080e7          	jalr	-556(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=(uint64)(&kernelTextStart);i<kDataStart;i+=4096) {
    8000b524:	000017b7          	lui	a5,0x1
    8000b528:	00f484b3          	add	s1,s1,a5
    8000b52c:	fddff06f          	j	8000b508 <_ZN5RiscV10initializeEv+0x130>
    }

    for(uint64 i=(uint64)&kernelDataStart;i<(uint64)HEAP_START_ADDR;i+=4096) {
    8000b530:	000a0493          	mv	s1,s4
    8000b534:	ffffb797          	auipc	a5,0xffffb
    8000b538:	2fc7b783          	ld	a5,764(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000b53c:	0007b903          	ld	s2,0(a5)
    8000b540:	0324f463          	bgeu	s1,s2,8000b568 <_ZN5RiscV10initializeEv+0x190>
        handlePageFault(kPMT,i, 0x7);
    8000b544:	00700613          	li	a2,7
    8000b548:	00048593          	mv	a1,s1
    8000b54c:	00002517          	auipc	a0,0x2
    8000b550:	16453503          	ld	a0,356(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b554:	00000097          	auipc	ra,0x0
    8000b558:	d9c080e7          	jalr	-612(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=(uint64)&kernelDataStart;i<(uint64)HEAP_START_ADDR;i+=4096) {
    8000b55c:	000017b7          	lui	a5,0x1
    8000b560:	00f484b3          	add	s1,s1,a5
    8000b564:	fd1ff06f          	j	8000b534 <_ZN5RiscV10initializeEv+0x15c>
    }

    for(uint64 i=(uint64)HEAP_START_ADDR;i<(uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12);i+=4096) {
    8000b568:	ffffb797          	auipc	a5,0xffffb
    8000b56c:	2e07b783          	ld	a5,736(a5) # 80006848 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000b570:	0007b483          	ld	s1,0(a5)
    8000b574:	00c49793          	slli	a5,s1,0xc
    8000b578:	ffffb717          	auipc	a4,0xffffb
    8000b57c:	2e873703          	ld	a4,744(a4) # 80006860 <_GLOBAL_OFFSET_TABLE_+0x48>
    8000b580:	00073483          	ld	s1,0(a4)
    8000b584:	00f484b3          	add	s1,s1,a5
    8000b588:	04997463          	bgeu	s2,s1,8000b5d0 <_ZN5RiscV10initializeEv+0x1f8>
        handlePageFault(kPMT,i, 0x7);
    8000b58c:	00700613          	li	a2,7
    8000b590:	00090593          	mv	a1,s2
    8000b594:	00002517          	auipc	a0,0x2
    8000b598:	11c53503          	ld	a0,284(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b59c:	00000097          	auipc	ra,0x0
    8000b5a0:	d54080e7          	jalr	-684(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=(uint64)HEAP_START_ADDR;i<(uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12);i+=4096) {
    8000b5a4:	000017b7          	lui	a5,0x1
    8000b5a8:	00f90933          	add	s2,s2,a5
    8000b5ac:	fbdff06f          	j	8000b568 <_ZN5RiscV10initializeEv+0x190>
    }

    for(uint64 i = (uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12);i<(uint64)HEAP_END_ADDR;i+=4096){
        handlePageFault(kPMT,i, 0x17);
    8000b5b0:	01700613          	li	a2,23
    8000b5b4:	00048593          	mv	a1,s1
    8000b5b8:	00002517          	auipc	a0,0x2
    8000b5bc:	0f853503          	ld	a0,248(a0) # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b5c0:	00000097          	auipc	ra,0x0
    8000b5c4:	d30080e7          	jalr	-720(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i = (uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12);i<(uint64)HEAP_END_ADDR;i+=4096){
    8000b5c8:	000017b7          	lui	a5,0x1
    8000b5cc:	00f484b3          	add	s1,s1,a5
    8000b5d0:	ffffb797          	auipc	a5,0xffffb
    8000b5d4:	3187b783          	ld	a5,792(a5) # 800068e8 <_GLOBAL_OFFSET_TABLE_+0xd0>
    8000b5d8:	0007b783          	ld	a5,0(a5)
    8000b5dc:	fcf4eae3          	bltu	s1,a5,8000b5b0 <_ZN5RiscV10initializeEv+0x1d8>
}

inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    8000b5e0:	000407b7          	lui	a5,0x40
    8000b5e4:	1007a073          	csrs	sstatus,a5
    }


    RiscV::ms_sstatus(1<<18);
    handlePageFault(kPMT, (uint64)CONSOLE_RX_DATA,0xf);
    8000b5e8:	00002497          	auipc	s1,0x2
    8000b5ec:	0c848493          	addi	s1,s1,200 # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000b5f0:	00f00613          	li	a2,15
    8000b5f4:	ffffb797          	auipc	a5,0xffffb
    8000b5f8:	22c7b783          	ld	a5,556(a5) # 80006820 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000b5fc:	0007b583          	ld	a1,0(a5)
    8000b600:	0004b503          	ld	a0,0(s1)
    8000b604:	00000097          	auipc	ra,0x0
    8000b608:	cec080e7          	jalr	-788(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)CONSOLE_TX_DATA,0xf);
    8000b60c:	00f00613          	li	a2,15
    8000b610:	ffffb797          	auipc	a5,0xffffb
    8000b614:	2587b783          	ld	a5,600(a5) # 80006868 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000b618:	0007b583          	ld	a1,0(a5)
    8000b61c:	0004b503          	ld	a0,0(s1)
    8000b620:	00000097          	auipc	ra,0x0
    8000b624:	cd0080e7          	jalr	-816(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)CONSOLE_STATUS,0xf);
    8000b628:	00f00613          	li	a2,15
    8000b62c:	ffffb797          	auipc	a5,0xffffb
    8000b630:	1fc7b783          	ld	a5,508(a5) # 80006828 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000b634:	0007b583          	ld	a1,0(a5)
    8000b638:	0004b503          	ld	a0,0(s1)
    8000b63c:	00000097          	auipc	ra,0x0
    8000b640:	cb4080e7          	jalr	-844(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)0xc201004,0xf);
    8000b644:	00f00613          	li	a2,15
    8000b648:	0c2015b7          	lui	a1,0xc201
    8000b64c:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    8000b650:	0004b503          	ld	a0,0(s1)
    8000b654:	00000097          	auipc	ra,0x0
    8000b658:	c9c080e7          	jalr	-868(ra) # 8000b2f0 <_ZN5RiscV15handlePageFaultEPvmm>

    ConsoleUtil::print("kTextStart", kTextStart, "\n");
    8000b65c:	01000693          	li	a3,16
    8000b660:	00002617          	auipc	a2,0x2
    8000b664:	bb060613          	addi	a2,a2,-1104 # 8000d210 <kernelDataStart+0x37c>
    8000b668:	000a859b          	sext.w	a1,s5
    8000b66c:	00002517          	auipc	a0,0x2
    8000b670:	bac50513          	addi	a0,a0,-1108 # 8000d218 <kernelDataStart+0x384>
    8000b674:	00001097          	auipc	ra,0x1
    8000b678:	61c080e7          	jalr	1564(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("kDataStart", kDataStart, "\n");
    8000b67c:	01000693          	li	a3,16
    8000b680:	00002617          	auipc	a2,0x2
    8000b684:	b9060613          	addi	a2,a2,-1136 # 8000d210 <kernelDataStart+0x37c>
    8000b688:	000a059b          	sext.w	a1,s4
    8000b68c:	00002517          	auipc	a0,0x2
    8000b690:	b9c50513          	addi	a0,a0,-1124 # 8000d228 <kernelDataStart+0x394>
    8000b694:	00001097          	auipc	ra,0x1
    8000b698:	5fc080e7          	jalr	1532(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("kTextStart", (uint64)HEAP_START_ADDR, "\n");
    8000b69c:	01000693          	li	a3,16
    8000b6a0:	00002617          	auipc	a2,0x2
    8000b6a4:	b7060613          	addi	a2,a2,-1168 # 8000d210 <kernelDataStart+0x37c>
    8000b6a8:	ffffb797          	auipc	a5,0xffffb
    8000b6ac:	1887b783          	ld	a5,392(a5) # 80006830 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000b6b0:	0007a583          	lw	a1,0(a5)
    8000b6b4:	00002517          	auipc	a0,0x2
    8000b6b8:	b6450513          	addi	a0,a0,-1180 # 8000d218 <kernelDataStart+0x384>
    8000b6bc:	00001097          	auipc	ra,0x1
    8000b6c0:	5d4080e7          	jalr	1492(ra) # 8000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>

    uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::kPMT)>>12);
    8000b6c4:	0004b783          	ld	a5,0(s1)
    8000b6c8:	00c7d793          	srli	a5,a5,0xc
    8000b6cc:	fff00713          	li	a4,-1
    8000b6d0:	03f71713          	slli	a4,a4,0x3f
    8000b6d4:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    8000b6d8:	18079073          	csrw	satp,a5
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    8000b6dc:	00200793          	li	a5,2
    8000b6e0:	1047a073          	csrs	sie,a5
    8000b6e4:	20000713          	li	a4,512
    8000b6e8:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    8000b6ec:	1007a073          	csrs	sstatus,a5

    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    8000b6f0:	03813083          	ld	ra,56(sp)
    8000b6f4:	03013403          	ld	s0,48(sp)
    8000b6f8:	02813483          	ld	s1,40(sp)
    8000b6fc:	02013903          	ld	s2,32(sp)
    8000b700:	01813983          	ld	s3,24(sp)
    8000b704:	01013a03          	ld	s4,16(sp)
    8000b708:	00813a83          	ld	s5,8(sp)
    8000b70c:	04010113          	addi	sp,sp,64
    8000b710:	00008067          	ret

000000008000b714 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    8000b714:	ff010113          	addi	sp,sp,-16
    8000b718:	00813423          	sd	s0,8(sp)
    8000b71c:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    8000b720:	14109073          	csrw	sepc,ra
    asm("sret");
    8000b724:	10200073          	sret
}
    8000b728:	00813403          	ld	s0,8(sp)
    8000b72c:	01010113          	addi	sp,sp,16
    8000b730:	00008067          	ret

000000008000b734 <_ZN5RiscV11popSppSpie2Ev>:

void RiscV::popSppSpie2() {
    8000b734:	ff010113          	addi	sp,sp,-16
    8000b738:	00813423          	sd	s0,8(sp)
    8000b73c:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    8000b740:	ffffb797          	auipc	a5,0xffffb
    8000b744:	1907b783          	ld	a5,400(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000b748:	0007b783          	ld	a5,0(a5)
    8000b74c:	0147a703          	lw	a4,20(a5)
    8000b750:	00100793          	li	a5,1
    8000b754:	02f70063          	beq	a4,a5,8000b774 <_ZN5RiscV11popSppSpie2Ev+0x40>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)TCBWrapper::tcbWrap;
    8000b758:	ffffb797          	auipc	a5,0xffffb
    8000b75c:	1587b783          	ld	a5,344(a5) # 800068b0 <_GLOBAL_OFFSET_TABLE_+0x98>
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    8000b760:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    8000b764:	10200073          	sret
}
    8000b768:	00813403          	ld	s0,8(sp)
    8000b76c:	01010113          	addi	sp,sp,16
    8000b770:	00008067          	ret
        asm("csrw sepc, ra");
    8000b774:	14109073          	csrw	sepc,ra
    8000b778:	fedff06f          	j	8000b764 <_ZN5RiscV11popSppSpie2Ev+0x30>

000000008000b77c <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    8000b77c:	ff010113          	addi	sp,sp,-16
    8000b780:	00113423          	sd	ra,8(sp)
    8000b784:	00813023          	sd	s0,0(sp)
    8000b788:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    8000b78c:	ffffb797          	auipc	a5,0xffffb
    8000b790:	1447b783          	ld	a5,324(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000b794:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    8000b798:	00100713          	li	a4,1
    8000b79c:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    8000b7a0:	fffff097          	auipc	ra,0xfffff
    8000b7a4:	454080e7          	jalr	1108(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
}
    8000b7a8:	00813083          	ld	ra,8(sp)
    8000b7ac:	00013403          	ld	s0,0(sp)
    8000b7b0:	01010113          	addi	sp,sp,16
    8000b7b4:	00008067          	ret

000000008000b7b8 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    8000b7b8:	ff010113          	addi	sp,sp,-16
    8000b7bc:	00113423          	sd	ra,8(sp)
    8000b7c0:	00813023          	sd	s0,0(sp)
    8000b7c4:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    8000b7c8:	00002797          	auipc	a5,0x2
    8000b7cc:	ef07c783          	lbu	a5,-272(a5) # 8000d6b8 <_ZN5RiscV16userMainFinishedE>
    8000b7d0:	00079c63          	bnez	a5,8000b7e8 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    8000b7d4:	ffffb717          	auipc	a4,0xffffb
    8000b7d8:	0f473703          	ld	a4,244(a4) # 800068c8 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000b7dc:	00073783          	ld	a5,0(a4)
    8000b7e0:	00178793          	addi	a5,a5,1
    8000b7e4:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    8000b7e8:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    8000b7ec:	0ff57513          	andi	a0,a0,255
    8000b7f0:	00001097          	auipc	ra,0x1
    8000b7f4:	278080e7          	jalr	632(ra) # 8000ca68 <_ZN11ConsoleUtil9putOutputEc>
}
    8000b7f8:	00813083          	ld	ra,8(sp)
    8000b7fc:	00013403          	ld	s0,0(sp)
    8000b800:	01010113          	addi	sp,sp,16
    8000b804:	00008067          	ret

000000008000b808 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    8000b808:	fe010113          	addi	sp,sp,-32
    8000b80c:	00113c23          	sd	ra,24(sp)
    8000b810:	00813823          	sd	s0,16(sp)
    8000b814:	02010413          	addi	s0,sp,32
    8000b818:	00c0006f          	j	8000b824 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    8000b81c:	ffff6097          	auipc	ra,0xffff6
    8000b820:	914080e7          	jalr	-1772(ra) # 80001130 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    8000b824:	ffffb797          	auipc	a5,0xffffb
    8000b828:	0047b783          	ld	a5,4(a5) # 80006828 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000b82c:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    8000b830:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000b834:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    8000b838:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    8000b83c:	0207f793          	andi	a5,a5,32
    8000b840:	fc078ee3          	beqz	a5,8000b81c <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    8000b844:	00001097          	auipc	ra,0x1
    8000b848:	4b8080e7          	jalr	1208(ra) # 8000ccfc <_ZN11ConsoleUtil15putcUtilSyscallEv>
    8000b84c:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    8000b850:	ffffb797          	auipc	a5,0xffffb
    8000b854:	fd07b783          	ld	a5,-48(a5) # 80006820 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000b858:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    8000b85c:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    8000b860:	fef44783          	lbu	a5,-17(s0)
    8000b864:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    8000b868:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    8000b86c:	ffffb797          	auipc	a5,0xffffb
    8000b870:	05c7b783          	ld	a5,92(a5) # 800068c8 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000b874:	0007b783          	ld	a5,0(a5)
    8000b878:	fa0786e3          	beqz	a5,8000b824 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    8000b87c:	fff78793          	addi	a5,a5,-1
    8000b880:	ffffb717          	auipc	a4,0xffffb
    8000b884:	04873703          	ld	a4,72(a4) # 800068c8 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000b888:	00f73023          	sd	a5,0(a4)
    8000b88c:	f99ff06f          	j	8000b824 <_ZN5RiscV11putcWrapperEPv+0x1c>

000000008000b890 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    8000b890:	ff010113          	addi	sp,sp,-16
    8000b894:	00813423          	sd	s0,8(sp)
    8000b898:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    8000b89c:	ffffb797          	auipc	a5,0xffffb
    8000b8a0:	0347b783          	ld	a5,52(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000b8a4:	0007b783          	ld	a5,0(a5)
    8000b8a8:	0147a703          	lw	a4,20(a5)
    8000b8ac:	00100793          	li	a5,1
    8000b8b0:	00f70c63          	beq	a4,a5,8000b8c8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    8000b8b4:	10000793          	li	a5,256
    8000b8b8:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    8000b8bc:	00813403          	ld	s0,8(sp)
    8000b8c0:	01010113          	addi	sp,sp,16
    8000b8c4:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    8000b8c8:	10000793          	li	a5,256
    8000b8cc:	1007a073          	csrs	sstatus,a5
}
    8000b8d0:	fedff06f          	j	8000b8bc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

000000008000b8d4 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    8000b8d4:	ff010113          	addi	sp,sp,-16
    8000b8d8:	00113423          	sd	ra,8(sp)
    8000b8dc:	00813023          	sd	s0,0(sp)
    8000b8e0:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    8000b8e4:	00100793          	li	a5,1
    8000b8e8:	00002717          	auipc	a4,0x2
    8000b8ec:	dcf70823          	sb	a5,-560(a4) # 8000d6b8 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    8000b8f0:	ffffb797          	auipc	a5,0xffffb
    8000b8f4:	fd87b783          	ld	a5,-40(a5) # 800068c8 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000b8f8:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    8000b8fc:	ffffb797          	auipc	a5,0xffffb
    8000b900:	f747b783          	ld	a5,-140(a5) # 80006870 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000b904:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    8000b908:	00200793          	li	a5,2
    8000b90c:	1047b073          	csrc	sie,a5
    8000b910:	20000793          	li	a5,512
    8000b914:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    8000b918:	ffffb797          	auipc	a5,0xffffb
    8000b91c:	f807b783          	ld	a5,-128(a5) # 80006898 <_GLOBAL_OFFSET_TABLE_+0x80>
    8000b920:	0007b783          	ld	a5,0(a5)
    8000b924:	00078c63          	beqz	a5,8000b93c <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    8000b928:	0487b703          	ld	a4,72(a5)
    8000b92c:	ffffb797          	auipc	a5,0xffffb
    8000b930:	f6c7b783          	ld	a5,-148(a5) # 80006898 <_GLOBAL_OFFSET_TABLE_+0x80>
    8000b934:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    8000b938:	fe1ff06f          	j	8000b918 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    8000b93c:	ffffb797          	auipc	a5,0xffffb
    8000b940:	f647b783          	ld	a5,-156(a5) # 800068a0 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000b944:	0007b503          	ld	a0,0(a5)
    8000b948:	00001097          	auipc	ra,0x1
    8000b94c:	d50080e7          	jalr	-688(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000b950:	ffffb797          	auipc	a5,0xffffb
    8000b954:	f687b783          	ld	a5,-152(a5) # 800068b8 <_GLOBAL_OFFSET_TABLE_+0xa0>
    8000b958:	0007b703          	ld	a4,0(a5)
    8000b95c:	ffffb797          	auipc	a5,0xffffb
    8000b960:	f647b783          	ld	a5,-156(a5) # 800068c0 <_GLOBAL_OFFSET_TABLE_+0xa8>
    8000b964:	0007b783          	ld	a5,0(a5)
    8000b968:	00f70863          	beq	a4,a5,8000b978 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    8000b96c:	ffff5097          	auipc	ra,0xffff5
    8000b970:	7c4080e7          	jalr	1988(ra) # 80001130 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000b974:	fddff06f          	j	8000b950 <_ZN5RiscV8finalizeEv+0x7c>
}
    8000b978:	00813083          	ld	ra,8(sp)
    8000b97c:	00013403          	ld	s0,0(sp)
    8000b980:	01010113          	addi	sp,sp,16
    8000b984:	00008067          	ret

000000008000b988 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    8000b988:	ff010113          	addi	sp,sp,-16
    8000b98c:	00813423          	sd	s0,8(sp)
    8000b990:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    8000b994:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    8000b998:	ffffb717          	auipc	a4,0xffffb
    8000b99c:	f3873703          	ld	a4,-200(a4) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000b9a0:	00073703          	ld	a4,0(a4)
    8000b9a4:	06873703          	ld	a4,104(a4)
    8000b9a8:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    8000b9ac:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000b9b0:	00078593          	mv	a1,a5
}
    8000b9b4:	00813403          	ld	s0,8(sp)
    8000b9b8:	01010113          	addi	sp,sp,16
    8000b9bc:	00008067          	ret

000000008000b9c0 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    8000b9c0:	ff010113          	addi	sp,sp,-16
    8000b9c4:	00113423          	sd	ra,8(sp)
    8000b9c8:	00813023          	sd	s0,0(sp)
    8000b9cc:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    8000b9d0:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    8000b9d4:	fffff097          	auipc	ra,0xfffff
    8000b9d8:	4a4080e7          	jalr	1188(ra) # 8000ae78 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    8000b9dc:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000b9e0:	00000097          	auipc	ra,0x0
    8000b9e4:	fa8080e7          	jalr	-88(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000b9e8:	00813083          	ld	ra,8(sp)
    8000b9ec:	00013403          	ld	s0,0(sp)
    8000b9f0:	01010113          	addi	sp,sp,16
    8000b9f4:	00008067          	ret

000000008000b9f8 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    8000b9f8:	ff010113          	addi	sp,sp,-16
    8000b9fc:	00113423          	sd	ra,8(sp)
    8000ba00:	00813023          	sd	s0,0(sp)
    8000ba04:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    8000ba08:	ffffb797          	auipc	a5,0xffffb
    8000ba0c:	ed87b783          	ld	a5,-296(a5) # 800068e0 <_GLOBAL_OFFSET_TABLE_+0xc8>
    8000ba10:	0007c783          	lbu	a5,0(a5)
    8000ba14:	02079263          	bnez	a5,8000ba38 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    8000ba18:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000ba1c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000ba20:	00000097          	auipc	ra,0x0
    8000ba24:	f68080e7          	jalr	-152(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000ba28:	00813083          	ld	ra,8(sp)
    8000ba2c:	00013403          	ld	s0,0(sp)
    8000ba30:	01010113          	addi	sp,sp,16
    8000ba34:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000ba38:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    8000ba3c:	fffff097          	auipc	ra,0xfffff
    8000ba40:	674080e7          	jalr	1652(ra) # 8000b0b0 <_ZN15MemoryAllocator5kfreeEPv>
    8000ba44:	fd9ff06f          	j	8000ba1c <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

000000008000ba48 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    8000ba48:	fc010113          	addi	sp,sp,-64
    8000ba4c:	02113c23          	sd	ra,56(sp)
    8000ba50:	02813823          	sd	s0,48(sp)
    8000ba54:	02913423          	sd	s1,40(sp)
    8000ba58:	03213023          	sd	s2,32(sp)
    8000ba5c:	01313c23          	sd	s3,24(sp)
    8000ba60:	01413823          	sd	s4,16(sp)
    8000ba64:	01513423          	sd	s5,8(sp)
    8000ba68:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000ba6c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000ba70:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000ba74:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    8000ba78:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000ba7c:	07000513          	li	a0,112
    8000ba80:	fffff097          	auipc	ra,0xfffff
    8000ba84:	1f4080e7          	jalr	500(ra) # 8000ac74 <_ZN3TCBnwEm>
    8000ba88:	00050493          	mv	s1,a0
    8000ba8c:	00050e63          	beqz	a0,8000baa8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    8000ba90:	00200713          	li	a4,2
    8000ba94:	000a8693          	mv	a3,s5
    8000ba98:	000a0613          	mv	a2,s4
    8000ba9c:	00098593          	mv	a1,s3
    8000baa0:	fffff097          	auipc	ra,0xfffff
    8000baa4:	098080e7          	jalr	152(ra) # 8000ab38 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000baa8:	04048863          	beqz	s1,8000baf8 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    8000baac:	0184b783          	ld	a5,24(s1)
    8000bab0:	00078863          	beqz	a5,8000bac0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    8000bab4:	00048513          	mv	a0,s1
    8000bab8:	00001097          	auipc	ra,0x1
    8000babc:	be0080e7          	jalr	-1056(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    8000bac0:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    8000bac4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bac8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bacc:	00000097          	auipc	ra,0x0
    8000bad0:	ebc080e7          	jalr	-324(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bad4:	03813083          	ld	ra,56(sp)
    8000bad8:	03013403          	ld	s0,48(sp)
    8000badc:	02813483          	ld	s1,40(sp)
    8000bae0:	02013903          	ld	s2,32(sp)
    8000bae4:	01813983          	ld	s3,24(sp)
    8000bae8:	01013a03          	ld	s4,16(sp)
    8000baec:	00813a83          	ld	s5,8(sp)
    8000baf0:	04010113          	addi	sp,sp,64
    8000baf4:	00008067          	ret
        status = -1;
    8000baf8:	fff00793          	li	a5,-1
    8000bafc:	fcdff06f          	j	8000bac8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    8000bb00:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000bb04:	00048513          	mv	a0,s1
    8000bb08:	fffff097          	auipc	ra,0xfffff
    8000bb0c:	290080e7          	jalr	656(ra) # 8000ad98 <_ZN3TCBdlEPv>
    8000bb10:	00090513          	mv	a0,s2
    8000bb14:	ffffc097          	auipc	ra,0xffffc
    8000bb18:	f24080e7          	jalr	-220(ra) # 80007a38 <_Unwind_Resume>

000000008000bb1c <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    8000bb1c:	fc010113          	addi	sp,sp,-64
    8000bb20:	02113c23          	sd	ra,56(sp)
    8000bb24:	02813823          	sd	s0,48(sp)
    8000bb28:	02913423          	sd	s1,40(sp)
    8000bb2c:	03213023          	sd	s2,32(sp)
    8000bb30:	01313c23          	sd	s3,24(sp)
    8000bb34:	01413823          	sd	s4,16(sp)
    8000bb38:	01513423          	sd	s5,8(sp)
    8000bb3c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000bb40:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000bb44:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000bb48:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    8000bb4c:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000bb50:	07000513          	li	a0,112
    8000bb54:	fffff097          	auipc	ra,0xfffff
    8000bb58:	120080e7          	jalr	288(ra) # 8000ac74 <_ZN3TCBnwEm>
    8000bb5c:	00050493          	mv	s1,a0
    8000bb60:	00050e63          	beqz	a0,8000bb7c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    8000bb64:	00200713          	li	a4,2
    8000bb68:	000a8693          	mv	a3,s5
    8000bb6c:	00090613          	mv	a2,s2
    8000bb70:	00098593          	mv	a1,s3
    8000bb74:	fffff097          	auipc	ra,0xfffff
    8000bb78:	fc4080e7          	jalr	-60(ra) # 8000ab38 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000bb7c:	04048263          	beqz	s1,8000bbc0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    8000bb80:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    8000bb84:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    8000bb88:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    8000bb8c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bb90:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bb94:	00000097          	auipc	ra,0x0
    8000bb98:	df4080e7          	jalr	-524(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bb9c:	03813083          	ld	ra,56(sp)
    8000bba0:	03013403          	ld	s0,48(sp)
    8000bba4:	02813483          	ld	s1,40(sp)
    8000bba8:	02013903          	ld	s2,32(sp)
    8000bbac:	01813983          	ld	s3,24(sp)
    8000bbb0:	01013a03          	ld	s4,16(sp)
    8000bbb4:	00813a83          	ld	s5,8(sp)
    8000bbb8:	04010113          	addi	sp,sp,64
    8000bbbc:	00008067          	ret
        status = -1;
    8000bbc0:	fff00793          	li	a5,-1
    8000bbc4:	fcdff06f          	j	8000bb90 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    8000bbc8:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000bbcc:	00048513          	mv	a0,s1
    8000bbd0:	fffff097          	auipc	ra,0xfffff
    8000bbd4:	1c8080e7          	jalr	456(ra) # 8000ad98 <_ZN3TCBdlEPv>
    8000bbd8:	00090513          	mv	a0,s2
    8000bbdc:	ffffc097          	auipc	ra,0xffffc
    8000bbe0:	e5c080e7          	jalr	-420(ra) # 80007a38 <_Unwind_Resume>

000000008000bbe4 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    8000bbe4:	ff010113          	addi	sp,sp,-16
    8000bbe8:	00113423          	sd	ra,8(sp)
    8000bbec:	00813023          	sd	s0,0(sp)
    8000bbf0:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000bbf4:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    8000bbf8:	02051263          	bnez	a0,8000bc1c <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    8000bbfc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bc00:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bc04:	00000097          	auipc	ra,0x0
    8000bc08:	d84080e7          	jalr	-636(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bc0c:	00813083          	ld	ra,8(sp)
    8000bc10:	00013403          	ld	s0,0(sp)
    8000bc14:	01010113          	addi	sp,sp,16
    8000bc18:	00008067          	ret
        tcb->status = TCB::Status::READY;
    8000bc1c:	00100793          	li	a5,1
    8000bc20:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    8000bc24:	00001097          	auipc	ra,0x1
    8000bc28:	a74080e7          	jalr	-1420(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    8000bc2c:	fffff097          	auipc	ra,0xfffff
    8000bc30:	fc8080e7          	jalr	-56(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000bc34:	00000793          	li	a5,0
    8000bc38:	fc9ff06f          	j	8000bc00 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

000000008000bc3c <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    8000bc3c:	ff010113          	addi	sp,sp,-16
    8000bc40:	00113423          	sd	ra,8(sp)
    8000bc44:	00813023          	sd	s0,0(sp)
    8000bc48:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000bc4c:	ffffb797          	auipc	a5,0xffffb
    8000bc50:	c847b783          	ld	a5,-892(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000bc54:	0007b783          	ld	a5,0(a5)
    8000bc58:	02078a63          	beqz	a5,8000bc8c <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    8000bc5c:	00200713          	li	a4,2
    8000bc60:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    8000bc64:	fffff097          	auipc	ra,0xfffff
    8000bc68:	f90080e7          	jalr	-112(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000bc6c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bc70:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bc74:	00000097          	auipc	ra,0x0
    8000bc78:	d14080e7          	jalr	-748(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bc7c:	00813083          	ld	ra,8(sp)
    8000bc80:	00013403          	ld	s0,0(sp)
    8000bc84:	01010113          	addi	sp,sp,16
    8000bc88:	00008067          	ret
        status = -1;
    8000bc8c:	fff00793          	li	a5,-1
    8000bc90:	fe1ff06f          	j	8000bc70 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

000000008000bc94 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    8000bc94:	fd010113          	addi	sp,sp,-48
    8000bc98:	02113423          	sd	ra,40(sp)
    8000bc9c:	02813023          	sd	s0,32(sp)
    8000bca0:	00913c23          	sd	s1,24(sp)
    8000bca4:	01213823          	sd	s2,16(sp)
    8000bca8:	01313423          	sd	s3,8(sp)
    8000bcac:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000bcb0:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    8000bcb4:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    8000bcb8:	01800513          	li	a0,24
    8000bcbc:	fffff097          	auipc	ra,0xfffff
    8000bcc0:	d34080e7          	jalr	-716(ra) # 8000a9f0 <_ZN3SCBnwEm>
    8000bcc4:	00050493          	mv	s1,a0
    8000bcc8:	00050863          	beqz	a0,8000bcd8 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    8000bccc:	00098593          	mv	a1,s3
    8000bcd0:	fffff097          	auipc	ra,0xfffff
    8000bcd4:	b6c080e7          	jalr	-1172(ra) # 8000a83c <_ZN3SCBC1Em>
    if(scb == nullptr){
    8000bcd8:	02048a63          	beqz	s1,8000bd0c <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    8000bcdc:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    8000bce0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bce4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bce8:	00000097          	auipc	ra,0x0
    8000bcec:	ca0080e7          	jalr	-864(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bcf0:	02813083          	ld	ra,40(sp)
    8000bcf4:	02013403          	ld	s0,32(sp)
    8000bcf8:	01813483          	ld	s1,24(sp)
    8000bcfc:	01013903          	ld	s2,16(sp)
    8000bd00:	00813983          	ld	s3,8(sp)
    8000bd04:	03010113          	addi	sp,sp,48
    8000bd08:	00008067          	ret
        status = -1;
    8000bd0c:	fff00793          	li	a5,-1
    8000bd10:	fd5ff06f          	j	8000bce4 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    8000bd14:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    8000bd18:	00048513          	mv	a0,s1
    8000bd1c:	fffff097          	auipc	ra,0xfffff
    8000bd20:	d04080e7          	jalr	-764(ra) # 8000aa20 <_ZN3SCBdlEPv>
    8000bd24:	00090513          	mv	a0,s2
    8000bd28:	ffffc097          	auipc	ra,0xffffc
    8000bd2c:	d10080e7          	jalr	-752(ra) # 80007a38 <_Unwind_Resume>

000000008000bd30 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    8000bd30:	fe010113          	addi	sp,sp,-32
    8000bd34:	00113c23          	sd	ra,24(sp)
    8000bd38:	00813823          	sd	s0,16(sp)
    8000bd3c:	00913423          	sd	s1,8(sp)
    8000bd40:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000bd44:	00058493          	mv	s1,a1
    if(scb == nullptr){
    8000bd48:	02049463          	bnez	s1,8000bd70 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    8000bd4c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bd50:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bd54:	00000097          	auipc	ra,0x0
    8000bd58:	c34080e7          	jalr	-972(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bd5c:	01813083          	ld	ra,24(sp)
    8000bd60:	01013403          	ld	s0,16(sp)
    8000bd64:	00813483          	ld	s1,8(sp)
    8000bd68:	02010113          	addi	sp,sp,32
    8000bd6c:	00008067          	ret
        delete (SCB*)ihandle;
    8000bd70:	00048513          	mv	a0,s1
    8000bd74:	fffff097          	auipc	ra,0xfffff
    8000bd78:	ae4080e7          	jalr	-1308(ra) # 8000a858 <_ZN3SCBD1Ev>
    8000bd7c:	00048513          	mv	a0,s1
    8000bd80:	fffff097          	auipc	ra,0xfffff
    8000bd84:	ca0080e7          	jalr	-864(ra) # 8000aa20 <_ZN3SCBdlEPv>
    uint64 status = 0;
    8000bd88:	00000793          	li	a5,0
    8000bd8c:	fc5ff06f          	j	8000bd50 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

000000008000bd90 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    8000bd90:	ff010113          	addi	sp,sp,-16
    8000bd94:	00113423          	sd	ra,8(sp)
    8000bd98:	00813023          	sd	s0,0(sp)
    8000bd9c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000bda0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    8000bda4:	02051c63          	bnez	a0,8000bddc <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    8000bda8:	ffffb797          	auipc	a5,0xffffb
    8000bdac:	b287b783          	ld	a5,-1240(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000bdb0:	0007b783          	ld	a5,0(a5)
    8000bdb4:	0607b783          	ld	a5,96(a5)
    8000bdb8:	02078863          	beqz	a5,8000bde8 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    8000bdbc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bdc0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000bdc4:	00000097          	auipc	ra,0x0
    8000bdc8:	bc4080e7          	jalr	-1084(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bdcc:	00813083          	ld	ra,8(sp)
    8000bdd0:	00013403          	ld	s0,0(sp)
    8000bdd4:	01010113          	addi	sp,sp,16
    8000bdd8:	00008067          	ret
        ((SCB*)ihandle)->wait();
    8000bddc:	fffff097          	auipc	ra,0xfffff
    8000bde0:	b88080e7          	jalr	-1144(ra) # 8000a964 <_ZN3SCB4waitEv>
    8000bde4:	fc5ff06f          	j	8000bda8 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    8000bde8:	00000793          	li	a5,0
    8000bdec:	fd5ff06f          	j	8000bdc0 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

000000008000bdf0 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    8000bdf0:	ff010113          	addi	sp,sp,-16
    8000bdf4:	00113423          	sd	ra,8(sp)
    8000bdf8:	00813023          	sd	s0,0(sp)
    8000bdfc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000be00:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    8000be04:	02051263          	bnez	a0,8000be28 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    8000be08:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000be0c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000be10:	00000097          	auipc	ra,0x0
    8000be14:	b78080e7          	jalr	-1160(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000be18:	00813083          	ld	ra,8(sp)
    8000be1c:	00013403          	ld	s0,0(sp)
    8000be20:	01010113          	addi	sp,sp,16
    8000be24:	00008067          	ret
        ((SCB*)ihandle)->signal();
    8000be28:	fffff097          	auipc	ra,0xfffff
    8000be2c:	b8c080e7          	jalr	-1140(ra) # 8000a9b4 <_ZN3SCB6signalEv>
    uint64 status = 0;
    8000be30:	00000793          	li	a5,0
    8000be34:	fd9ff06f          	j	8000be0c <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

000000008000be38 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    8000be38:	fe010113          	addi	sp,sp,-32
    8000be3c:	00113c23          	sd	ra,24(sp)
    8000be40:	00813823          	sd	s0,16(sp)
    8000be44:	00913423          	sd	s1,8(sp)
    8000be48:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    8000be4c:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000be50:	ffffb797          	auipc	a5,0xffffb
    8000be54:	a807b783          	ld	a5,-1408(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000be58:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    8000be5c:	00002797          	auipc	a5,0x2
    8000be60:	8647b783          	ld	a5,-1948(a5) # 8000d6c0 <_ZN5RiscV10globalTimeE>
    8000be64:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    8000be68:	00e787b3          	add	a5,a5,a4
    8000be6c:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    8000be70:	00048513          	mv	a0,s1
    8000be74:	00001097          	auipc	ra,0x1
    8000be78:	8a0080e7          	jalr	-1888(ra) # 8000c714 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    8000be7c:	00300793          	li	a5,3
    8000be80:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    8000be84:	fffff097          	auipc	ra,0xfffff
    8000be88:	d70080e7          	jalr	-656(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000be8c:	00000793          	li	a5,0
    8000be90:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000be94:	00000097          	auipc	ra,0x0
    8000be98:	af4080e7          	jalr	-1292(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000be9c:	01813083          	ld	ra,24(sp)
    8000bea0:	01013403          	ld	s0,16(sp)
    8000bea4:	00813483          	ld	s1,8(sp)
    8000bea8:	02010113          	addi	sp,sp,32
    8000beac:	00008067          	ret

000000008000beb0 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    8000beb0:	fe010113          	addi	sp,sp,-32
    8000beb4:	00113c23          	sd	ra,24(sp)
    8000beb8:	00813823          	sd	s0,16(sp)
    8000bebc:	00913423          	sd	s1,8(sp)
    8000bec0:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    8000bec4:	00001797          	auipc	a5,0x1
    8000bec8:	7f47c783          	lbu	a5,2036(a5) # 8000d6b8 <_ZN5RiscV16userMainFinishedE>
    8000becc:	00079c63          	bnez	a5,8000bee4 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    8000bed0:	ffffb717          	auipc	a4,0xffffb
    8000bed4:	9a073703          	ld	a4,-1632(a4) # 80006870 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000bed8:	00073783          	ld	a5,0(a4)
    8000bedc:	00178793          	addi	a5,a5,1
    8000bee0:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    8000bee4:	00001097          	auipc	ra,0x1
    8000bee8:	b14080e7          	jalr	-1260(ra) # 8000c9f8 <_ZN11ConsoleUtil8getInputEv>
    8000beec:	00050493          	mv	s1,a0
    if(c==13) {
    8000bef0:	00d00793          	li	a5,13
    8000bef4:	02f50663          	beq	a0,a5,8000bf20 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    8000bef8:	01b00793          	li	a5,27
    8000befc:	04f51063          	bne	a0,a5,8000bf3c <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    8000bf00:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    8000bf04:	00000097          	auipc	ra,0x0
    8000bf08:	a84080e7          	jalr	-1404(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bf0c:	01813083          	ld	ra,24(sp)
    8000bf10:	01013403          	ld	s0,16(sp)
    8000bf14:	00813483          	ld	s1,8(sp)
    8000bf18:	02010113          	addi	sp,sp,32
    8000bf1c:	00008067          	ret
        ConsoleUtil::putOutput(13);
    8000bf20:	00d00513          	li	a0,13
    8000bf24:	00001097          	auipc	ra,0x1
    8000bf28:	b44080e7          	jalr	-1212(ra) # 8000ca68 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    8000bf2c:	00a00513          	li	a0,10
    8000bf30:	00001097          	auipc	ra,0x1
    8000bf34:	b38080e7          	jalr	-1224(ra) # 8000ca68 <_ZN11ConsoleUtil9putOutputEc>
    8000bf38:	fc9ff06f          	j	8000bf00 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    8000bf3c:	00001097          	auipc	ra,0x1
    8000bf40:	b2c080e7          	jalr	-1236(ra) # 8000ca68 <_ZN11ConsoleUtil9putOutputEc>
    8000bf44:	fbdff06f          	j	8000bf00 <_ZN5RiscV18executeGetcSyscallEv+0x50>

000000008000bf48 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    8000bf48:	ff010113          	addi	sp,sp,-16
    8000bf4c:	00113423          	sd	ra,8(sp)
    8000bf50:	00813023          	sd	s0,0(sp)
    8000bf54:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    8000bf58:	00001097          	auipc	ra,0x1
    8000bf5c:	ba8080e7          	jalr	-1112(ra) # 8000cb00 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    8000bf60:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000bf64:	00000097          	auipc	ra,0x0
    8000bf68:	a24080e7          	jalr	-1500(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bf6c:	00813083          	ld	ra,8(sp)
    8000bf70:	00013403          	ld	s0,0(sp)
    8000bf74:	01010113          	addi	sp,sp,16
    8000bf78:	00008067          	ret

000000008000bf7c <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    8000bf7c:	fe010113          	addi	sp,sp,-32
    8000bf80:	00113c23          	sd	ra,24(sp)
    8000bf84:	00813823          	sd	s0,16(sp)
    8000bf88:	00913423          	sd	s1,8(sp)
    8000bf8c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000bf90:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    8000bf94:	02049463          	bnez	s1,8000bfbc <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000bf98:	fff00793          	li	a5,-1
    8000bf9c:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    8000bfa0:	00000097          	auipc	ra,0x0
    8000bfa4:	9e8080e7          	jalr	-1560(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000bfa8:	01813083          	ld	ra,24(sp)
    8000bfac:	01013403          	ld	s0,16(sp)
    8000bfb0:	00813483          	ld	s1,8(sp)
    8000bfb4:	02010113          	addi	sp,sp,32
    8000bfb8:	00008067          	ret
        kfree(thr->stack);
    8000bfbc:	0284b503          	ld	a0,40(s1)
    8000bfc0:	00001097          	auipc	ra,0x1
    8000bfc4:	eac080e7          	jalr	-340(ra) # 8000ce6c <_Z5kfreePKv>
        delete thr;
    8000bfc8:	00048513          	mv	a0,s1
    8000bfcc:	fffff097          	auipc	ra,0xfffff
    8000bfd0:	c00080e7          	jalr	-1024(ra) # 8000abcc <_ZN3TCBD1Ev>
    8000bfd4:	00048513          	mv	a0,s1
    8000bfd8:	fffff097          	auipc	ra,0xfffff
    8000bfdc:	dc0080e7          	jalr	-576(ra) # 8000ad98 <_ZN3TCBdlEPv>
    8000bfe0:	fb9ff06f          	j	8000bf98 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

000000008000bfe4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    8000bfe4:	fe010113          	addi	sp,sp,-32
    8000bfe8:	00113c23          	sd	ra,24(sp)
    8000bfec:	00813823          	sd	s0,16(sp)
    8000bff0:	00913423          	sd	s1,8(sp)
    8000bff4:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000bff8:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    8000bffc:	02049463          	bnez	s1,8000c024 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000c000:	fff00793          	li	a5,-1
    8000c004:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    8000c008:	00000097          	auipc	ra,0x0
    8000c00c:	980080e7          	jalr	-1664(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000c010:	01813083          	ld	ra,24(sp)
    8000c014:	01013403          	ld	s0,16(sp)
    8000c018:	00813483          	ld	s1,8(sp)
    8000c01c:	02010113          	addi	sp,sp,32
    8000c020:	00008067          	ret
        delete scb;
    8000c024:	00048513          	mv	a0,s1
    8000c028:	fffff097          	auipc	ra,0xfffff
    8000c02c:	830080e7          	jalr	-2000(ra) # 8000a858 <_ZN3SCBD1Ev>
    8000c030:	00048513          	mv	a0,s1
    8000c034:	fffff097          	auipc	ra,0xfffff
    8000c038:	9ec080e7          	jalr	-1556(ra) # 8000aa20 <_ZN3SCBdlEPv>
    8000c03c:	fc5ff06f          	j	8000c000 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

000000008000c040 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    8000c040:	fe010113          	addi	sp,sp,-32
    8000c044:	00113c23          	sd	ra,24(sp)
    8000c048:	00813823          	sd	s0,16(sp)
    8000c04c:	00913423          	sd	s1,8(sp)
    8000c050:	01213023          	sd	s2,0(sp)
    8000c054:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    8000c058:	00001537          	lui	a0,0x1
    8000c05c:	00001097          	auipc	ra,0x1
    8000c060:	de8080e7          	jalr	-536(ra) # 8000ce44 <_Z7kmallocm>
    8000c064:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    8000c068:	ffffb797          	auipc	a5,0xffffb
    8000c06c:	8687b783          	ld	a5,-1944(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c070:	0007b783          	ld	a5,0(a5)
    8000c074:	00001637          	lui	a2,0x1
    8000c078:	00050593          	mv	a1,a0
    8000c07c:	0287b503          	ld	a0,40(a5)
    8000c080:	fffff097          	auipc	ra,0xfffff
    8000c084:	1e4080e7          	jalr	484(ra) # 8000b264 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000c088:	07000513          	li	a0,112
    8000c08c:	fffff097          	auipc	ra,0xfffff
    8000c090:	be8080e7          	jalr	-1048(ra) # 8000ac74 <_ZN3TCBnwEm>
    8000c094:	00050493          	mv	s1,a0
    8000c098:	00050e63          	beqz	a0,8000c0b4 <_ZN5RiscV18executeForkSyscallEv+0x74>
    8000c09c:	00200713          	li	a4,2
    8000c0a0:	00090693          	mv	a3,s2
    8000c0a4:	00000613          	li	a2,0
    8000c0a8:	00000593          	li	a1,0
    8000c0ac:	fffff097          	auipc	ra,0xfffff
    8000c0b0:	a8c080e7          	jalr	-1396(ra) # 8000ab38 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    8000c0b4:	0a048e63          	beqz	s1,8000c170 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    8000c0b8:	ffffa797          	auipc	a5,0xffffa
    8000c0bc:	7d07b783          	ld	a5,2000(a5) # 80006888 <_GLOBAL_OFFSET_TABLE_+0x70>
    8000c0c0:	0007b783          	ld	a5,0(a5)
    8000c0c4:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    8000c0c8:	ffffa797          	auipc	a5,0xffffa
    8000c0cc:	7b07b783          	ld	a5,1968(a5) # 80006878 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000c0d0:	0007b783          	ld	a5,0(a5)
    8000c0d4:	00f907b3          	add	a5,s2,a5
    8000c0d8:	ffffa717          	auipc	a4,0xffffa
    8000c0dc:	7f873703          	ld	a4,2040(a4) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c0e0:	00073683          	ld	a3,0(a4)
    8000c0e4:	0286b683          	ld	a3,40(a3)
    8000c0e8:	40d787b3          	sub	a5,a5,a3
    8000c0ec:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    8000c0f0:	00073783          	ld	a5,0(a4)
    8000c0f4:	0687b503          	ld	a0,104(a5)
    8000c0f8:	0287b783          	ld	a5,40(a5)
    8000c0fc:	40f50533          	sub	a0,a0,a5
    8000c100:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    8000c104:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    8000c108:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    8000c10c:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    8000c110:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    8000c114:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    8000c118:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    8000c11c:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    8000c120:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000c124:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    8000c128:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    8000c12c:	00073783          	ld	a5,0(a4)
    8000c130:	0387b703          	ld	a4,56(a5)
    8000c134:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    8000c138:	0407b783          	ld	a5,64(a5)
    8000c13c:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    8000c140:	00048513          	mv	a0,s1
    8000c144:	00000097          	auipc	ra,0x0
    8000c148:	554080e7          	jalr	1364(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    8000c14c:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    8000c150:	00000097          	auipc	ra,0x0
    8000c154:	838080e7          	jalr	-1992(ra) # 8000b988 <_ZN5RiscV16saveA0toSscratchEv>

}
    8000c158:	01813083          	ld	ra,24(sp)
    8000c15c:	01013403          	ld	s0,16(sp)
    8000c160:	00813483          	ld	s1,8(sp)
    8000c164:	00013903          	ld	s2,0(sp)
    8000c168:	02010113          	addi	sp,sp,32
    8000c16c:	00008067          	ret
        status = -1;
    8000c170:	fff00493          	li	s1,-1
    8000c174:	fd9ff06f          	j	8000c14c <_ZN5RiscV18executeForkSyscallEv+0x10c>
    8000c178:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000c17c:	00048513          	mv	a0,s1
    8000c180:	fffff097          	auipc	ra,0xfffff
    8000c184:	c18080e7          	jalr	-1000(ra) # 8000ad98 <_ZN3TCBdlEPv>
    8000c188:	00090513          	mv	a0,s2
    8000c18c:	ffffc097          	auipc	ra,0xffffc
    8000c190:	8ac080e7          	jalr	-1876(ra) # 80007a38 <_Unwind_Resume>

000000008000c194 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    8000c194:	ff010113          	addi	sp,sp,-16
    8000c198:	00813423          	sd	s0,8(sp)
    8000c19c:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    8000c1a0:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    8000c1a4:	00878793          	addi	a5,a5,8
    8000c1a8:	ffffa717          	auipc	a4,0xffffa
    8000c1ac:	6e073703          	ld	a4,1760(a4) # 80006888 <_GLOBAL_OFFSET_TABLE_+0x70>
    8000c1b0:	00f73023          	sd	a5,0(a4)
}
    8000c1b4:	00813403          	ld	s0,8(sp)
    8000c1b8:	01010113          	addi	sp,sp,16
    8000c1bc:	00008067          	ret

000000008000c1c0 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    8000c1c0:	fa010113          	addi	sp,sp,-96
    8000c1c4:	04113c23          	sd	ra,88(sp)
    8000c1c8:	04813823          	sd	s0,80(sp)
    8000c1cc:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    8000c1d0:	142027f3          	csrr	a5,scause
    8000c1d4:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    8000c1d8:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    8000c1dc:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    8000c1e0:	ffffa797          	auipc	a5,0xffffa
    8000c1e4:	6f07b783          	ld	a5,1776(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c1e8:	0007b783          	ld	a5,0(a5)
    8000c1ec:	14002773          	csrr	a4,sscratch
    8000c1f0:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    8000c1f4:	fe843703          	ld	a4,-24(s0)
    8000c1f8:	00900793          	li	a5,9
    8000c1fc:	0ef70663          	beq	a4,a5,8000c2e8 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    8000c200:	fe843703          	ld	a4,-24(s0)
    8000c204:	00800793          	li	a5,8
    8000c208:	0ef70063          	beq	a4,a5,8000c2e8 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    8000c20c:	fe843703          	ld	a4,-24(s0)
    8000c210:	fff00793          	li	a5,-1
    8000c214:	03f79793          	slli	a5,a5,0x3f
    8000c218:	00178793          	addi	a5,a5,1
    8000c21c:	24f70263          	beq	a4,a5,8000c460 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    8000c220:	fe843703          	ld	a4,-24(s0)
    8000c224:	fff00793          	li	a5,-1
    8000c228:	03f79793          	slli	a5,a5,0x3f
    8000c22c:	00978793          	addi	a5,a5,9
    8000c230:	2cf70063          	beq	a4,a5,8000c4f0 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    8000c234:	fe843703          	ld	a4,-24(s0)
    8000c238:	00200793          	li	a5,2
    8000c23c:	34f70863          	beq	a4,a5,8000c58c <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    8000c240:	00001517          	auipc	a0,0x1
    8000c244:	02850513          	addi	a0,a0,40 # 8000d268 <kernelDataStart+0x3d4>
    8000c248:	00001097          	auipc	ra,0x1
    8000c24c:	928080e7          	jalr	-1752(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    8000c250:	00001517          	auipc	a0,0x1
    8000c254:	02850513          	addi	a0,a0,40 # 8000d278 <kernelDataStart+0x3e4>
    8000c258:	00001097          	auipc	ra,0x1
    8000c25c:	918080e7          	jalr	-1768(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    8000c260:	142027f3          	csrr	a5,scause
    8000c264:	fef43023          	sd	a5,-32(s0)
    return scause;
    8000c268:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    8000c26c:	00000613          	li	a2,0
    8000c270:	00a00593          	li	a1,10
    8000c274:	0005051b          	sext.w	a0,a0
    8000c278:	00001097          	auipc	ra,0x1
    8000c27c:	93c080e7          	jalr	-1732(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    8000c280:	00001517          	auipc	a0,0x1
    8000c284:	fb850513          	addi	a0,a0,-72 # 8000d238 <kernelDataStart+0x3a4>
    8000c288:	00001097          	auipc	ra,0x1
    8000c28c:	8e8080e7          	jalr	-1816(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000c290:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    8000c294:	00000613          	li	a2,0
    8000c298:	01000593          	li	a1,16
    8000c29c:	0005051b          	sext.w	a0,a0
    8000c2a0:	00001097          	auipc	ra,0x1
    8000c2a4:	914080e7          	jalr	-1772(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000c2a8:	00001517          	auipc	a0,0x1
    8000c2ac:	f6850513          	addi	a0,a0,-152 # 8000d210 <kernelDataStart+0x37c>
    8000c2b0:	00001097          	auipc	ra,0x1
    8000c2b4:	8c0080e7          	jalr	-1856(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    8000c2b8:	ffffa797          	auipc	a5,0xffffa
    8000c2bc:	6187b783          	ld	a5,1560(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c2c0:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000c2c4:	00200713          	li	a4,2
    8000c2c8:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    8000c2cc:	00001517          	auipc	a0,0x1
    8000c2d0:	fbc50513          	addi	a0,a0,-68 # 8000d288 <kernelDataStart+0x3f4>
    8000c2d4:	00001097          	auipc	ra,0x1
    8000c2d8:	89c080e7          	jalr	-1892(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    8000c2dc:	fffff097          	auipc	ra,0xfffff
    8000c2e0:	918080e7          	jalr	-1768(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
    8000c2e4:	0800006f          	j	8000c364 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    8000c2e8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000c2ec:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000c2f0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    8000c2f4:	00478793          	addi	a5,a5,4
    8000c2f8:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    8000c2fc:	ffffa797          	auipc	a5,0xffffa
    8000c300:	5d47b783          	ld	a5,1492(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c304:	0007b783          	ld	a5,0(a5)
    8000c308:	fb043703          	ld	a4,-80(s0)
    8000c30c:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    8000c310:	fa843703          	ld	a4,-88(s0)
    8000c314:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    8000c318:	00050793          	mv	a5,a0
        switch(syscallID){
    8000c31c:	06100713          	li	a4,97
    8000c320:	02f76463          	bltu	a4,a5,8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    8000c324:	00279793          	slli	a5,a5,0x2
    8000c328:	00001717          	auipc	a4,0x1
    8000c32c:	f7470713          	addi	a4,a4,-140 # 8000d29c <kernelDataStart+0x408>
    8000c330:	00e787b3          	add	a5,a5,a4
    8000c334:	0007a783          	lw	a5,0(a5)
    8000c338:	00e787b3          	add	a5,a5,a4
    8000c33c:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    8000c340:	fffff097          	auipc	ra,0xfffff
    8000c344:	680080e7          	jalr	1664(ra) # 8000b9c0 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    8000c348:	ffffa797          	auipc	a5,0xffffa
    8000c34c:	5887b783          	ld	a5,1416(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c350:	0007b783          	ld	a5,0(a5)
    8000c354:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000c358:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    8000c35c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000c360:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    8000c364:	fffff097          	auipc	ra,0xfffff
    8000c368:	52c080e7          	jalr	1324(ra) # 8000b890 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    8000c36c:	05813083          	ld	ra,88(sp)
    8000c370:	05013403          	ld	s0,80(sp)
    8000c374:	06010113          	addi	sp,sp,96
    8000c378:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    8000c37c:	fffff097          	auipc	ra,0xfffff
    8000c380:	67c080e7          	jalr	1660(ra) # 8000b9f8 <_ZN5RiscV21executeMemFreeSyscallEv>
    8000c384:	fc5ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    8000c388:	fffff097          	auipc	ra,0xfffff
    8000c38c:	6c0080e7          	jalr	1728(ra) # 8000ba48 <_ZN5RiscV26executeThreadCreateSyscallEv>
    8000c390:	fb9ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    8000c394:	00000097          	auipc	ra,0x0
    8000c398:	8a8080e7          	jalr	-1880(ra) # 8000bc3c <_ZN5RiscV24executeThreadExitSyscallEv>
    8000c39c:	fadff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    8000c3a0:	fffff097          	auipc	ra,0xfffff
    8000c3a4:	3dc080e7          	jalr	988(ra) # 8000b77c <_ZN5RiscV28executeThreadDispatchSyscallEv>
    8000c3a8:	fa1ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    8000c3ac:	fffff097          	auipc	ra,0xfffff
    8000c3b0:	770080e7          	jalr	1904(ra) # 8000bb1c <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    8000c3b4:	f95ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    8000c3b8:	00000097          	auipc	ra,0x0
    8000c3bc:	82c080e7          	jalr	-2004(ra) # 8000bbe4 <_ZN5RiscV25executeThreadStartSyscallEv>
    8000c3c0:	f89ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    8000c3c4:	00000097          	auipc	ra,0x0
    8000c3c8:	8d0080e7          	jalr	-1840(ra) # 8000bc94 <_ZN5RiscV21executeSemOpenSyscallEv>
    8000c3cc:	f7dff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    8000c3d0:	00000097          	auipc	ra,0x0
    8000c3d4:	960080e7          	jalr	-1696(ra) # 8000bd30 <_ZN5RiscV22executeSemCloseSyscallEv>
    8000c3d8:	f71ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    8000c3dc:	00000097          	auipc	ra,0x0
    8000c3e0:	9b4080e7          	jalr	-1612(ra) # 8000bd90 <_ZN5RiscV21executeSemWaitSyscallEv>
    8000c3e4:	f65ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    8000c3e8:	00000097          	auipc	ra,0x0
    8000c3ec:	a08080e7          	jalr	-1528(ra) # 8000bdf0 <_ZN5RiscV23executeSemSignalSyscallEv>
    8000c3f0:	f59ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    8000c3f4:	00000097          	auipc	ra,0x0
    8000c3f8:	a44080e7          	jalr	-1468(ra) # 8000be38 <_ZN5RiscV23executeTimeSleepSyscallEv>
    8000c3fc:	f4dff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    8000c400:	00000097          	auipc	ra,0x0
    8000c404:	ab0080e7          	jalr	-1360(ra) # 8000beb0 <_ZN5RiscV18executeGetcSyscallEv>
    8000c408:	f41ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    8000c40c:	fffff097          	auipc	ra,0xfffff
    8000c410:	3ac080e7          	jalr	940(ra) # 8000b7b8 <_ZN5RiscV18executePutcSyscallEv>
    8000c414:	f35ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    8000c418:	00000097          	auipc	ra,0x0
    8000c41c:	b30080e7          	jalr	-1232(ra) # 8000bf48 <_ZN5RiscV22executePutcUtilSyscallEv>
    8000c420:	f29ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    8000c424:	00000097          	auipc	ra,0x0
    8000c428:	b58080e7          	jalr	-1192(ra) # 8000bf7c <_ZN5RiscV24executeThreadFreeSyscallEv>
    8000c42c:	f1dff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    8000c430:	00000097          	auipc	ra,0x0
    8000c434:	bb4080e7          	jalr	-1100(ra) # 8000bfe4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    8000c438:	f11ff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    8000c43c:	00010793          	mv	a5,sp
    8000c440:	ffffa717          	auipc	a4,0xffffa
    8000c444:	43873703          	ld	a4,1080(a4) # 80006878 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000c448:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    8000c44c:	00000097          	auipc	ra,0x0
    8000c450:	d48080e7          	jalr	-696(ra) # 8000c194 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    8000c454:	00000097          	auipc	ra,0x0
    8000c458:	bec080e7          	jalr	-1044(ra) # 8000c040 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    8000c45c:	eedff06f          	j	8000c348 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    8000c460:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000c464:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000c468:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    8000c46c:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    8000c470:	00200793          	li	a5,2
    8000c474:	1447b073          	csrc	sip,a5
        globalTime += 1;
    8000c478:	00001717          	auipc	a4,0x1
    8000c47c:	23870713          	addi	a4,a4,568 # 8000d6b0 <_ZN5RiscV4kPMTE>
    8000c480:	01073783          	ld	a5,16(a4)
    8000c484:	00178793          	addi	a5,a5,1
    8000c488:	00f73823          	sd	a5,16(a4)
        Scheduler::awake();
    8000c48c:	00000097          	auipc	ra,0x0
    8000c490:	2e0080e7          	jalr	736(ra) # 8000c76c <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    8000c494:	ffffa717          	auipc	a4,0xffffa
    8000c498:	3ac73703          	ld	a4,940(a4) # 80006840 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000c49c:	00073783          	ld	a5,0(a4)
    8000c4a0:	00178793          	addi	a5,a5,1
    8000c4a4:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    8000c4a8:	ffffa717          	auipc	a4,0xffffa
    8000c4ac:	42873703          	ld	a4,1064(a4) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c4b0:	00073703          	ld	a4,0(a4)
    8000c4b4:	03073683          	ld	a3,48(a4)
    8000c4b8:	00d7fc63          	bgeu	a5,a3,8000c4d0 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    8000c4bc:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000c4c0:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    8000c4c4:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000c4c8:	14179073          	csrw	sepc,a5
}
    8000c4cc:	e99ff06f          	j	8000c364 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    8000c4d0:	ffffa797          	auipc	a5,0xffffa
    8000c4d4:	3707b783          	ld	a5,880(a5) # 80006840 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000c4d8:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    8000c4dc:	00100793          	li	a5,1
    8000c4e0:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    8000c4e4:	ffffe097          	auipc	ra,0xffffe
    8000c4e8:	710080e7          	jalr	1808(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
    8000c4ec:	fd1ff06f          	j	8000c4bc <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    8000c4f0:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000c4f4:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000c4f8:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    8000c4fc:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    8000c500:	ffffa797          	auipc	a5,0xffffa
    8000c504:	3287b783          	ld	a5,808(a5) # 80006828 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000c508:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    8000c50c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000c510:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    8000c514:	00058793          	mv	a5,a1
        if(status & 1UL)
    8000c518:	0017f793          	andi	a5,a5,1
    8000c51c:	02078863          	beqz	a5,8000c54c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    8000c520:	ffffa797          	auipc	a5,0xffffa
    8000c524:	3487b783          	ld	a5,840(a5) # 80006868 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000c528:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    8000c52c:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    8000c530:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    8000c534:	00058513          	mv	a0,a1
    8000c538:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    8000c53c:	ffffa797          	auipc	a5,0xffffa
    8000c540:	3347b783          	ld	a5,820(a5) # 80006870 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000c544:	0007b783          	ld	a5,0(a5)
    8000c548:	02079463          	bnez	a5,8000c570 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    8000c54c:	ffff7097          	auipc	ra,0xffff7
    8000c550:	508080e7          	jalr	1288(ra) # 80003a54 <plic_claim>
    8000c554:	ffff7097          	auipc	ra,0xffff7
    8000c558:	538080e7          	jalr	1336(ra) # 80003a8c <plic_complete>
        RiscV::w_sstatus(sstatus);
    8000c55c:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000c560:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    8000c564:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000c568:	14179073          	csrw	sepc,a5
}
    8000c56c:	df9ff06f          	j	8000c364 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    8000c570:	fff78793          	addi	a5,a5,-1
    8000c574:	ffffa717          	auipc	a4,0xffffa
    8000c578:	2fc73703          	ld	a4,764(a4) # 80006870 <_GLOBAL_OFFSET_TABLE_+0x58>
    8000c57c:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    8000c580:	00000097          	auipc	ra,0x0
    8000c584:	3f8080e7          	jalr	1016(ra) # 8000c978 <_ZN11ConsoleUtil8putInputEc>
    8000c588:	fc5ff06f          	j	8000c54c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    8000c58c:	ffffa797          	auipc	a5,0xffffa
    8000c590:	3447b783          	ld	a5,836(a5) # 800068d0 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000c594:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000c598:	00200713          	li	a4,2
    8000c59c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    8000c5a0:	00001517          	auipc	a0,0x1
    8000c5a4:	c9850513          	addi	a0,a0,-872 # 8000d238 <kernelDataStart+0x3a4>
    8000c5a8:	00000097          	auipc	ra,0x0
    8000c5ac:	5c8080e7          	jalr	1480(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000c5b0:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    8000c5b4:	00000613          	li	a2,0
    8000c5b8:	01000593          	li	a1,16
    8000c5bc:	0005051b          	sext.w	a0,a0
    8000c5c0:	00000097          	auipc	ra,0x0
    8000c5c4:	5f4080e7          	jalr	1524(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000c5c8:	00001517          	auipc	a0,0x1
    8000c5cc:	c4850513          	addi	a0,a0,-952 # 8000d210 <kernelDataStart+0x37c>
    8000c5d0:	00000097          	auipc	ra,0x0
    8000c5d4:	5a0080e7          	jalr	1440(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    8000c5d8:	00001517          	auipc	a0,0x1
    8000c5dc:	c6850513          	addi	a0,a0,-920 # 8000d240 <kernelDataStart+0x3ac>
    8000c5e0:	00000097          	auipc	ra,0x0
    8000c5e4:	590080e7          	jalr	1424(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    8000c5e8:	ffffe097          	auipc	ra,0xffffe
    8000c5ec:	60c080e7          	jalr	1548(ra) # 8000abf4 <_ZN3TCB8dispatchEv>
    8000c5f0:	d75ff06f          	j	8000c364 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

000000008000c5f4 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    8000c5f4:	ff010113          	addi	sp,sp,-16
    8000c5f8:	00813423          	sd	s0,8(sp)
    8000c5fc:	01010413          	addi	s0,sp,16
    8000c600:	00050793          	mv	a5,a0
    8000c604:	00058513          	mv	a0,a1
    while(*src != '\0')
    8000c608:	0007c703          	lbu	a4,0(a5)
    8000c60c:	00070a63          	beqz	a4,8000c620 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    8000c610:	00178793          	addi	a5,a5,1
    8000c614:	00e50023          	sb	a4,0(a0)
    8000c618:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    8000c61c:	fedff06f          	j	8000c608 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    8000c620:	00e50023          	sb	a4,0(a0)
    return dst;
}
    8000c624:	00813403          	ld	s0,8(sp)
    8000c628:	01010113          	addi	sp,sp,16
    8000c62c:	00008067          	ret

000000008000c630 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    8000c630:	fe010113          	addi	sp,sp,-32
    8000c634:	00113c23          	sd	ra,24(sp)
    8000c638:	00813823          	sd	s0,16(sp)
    8000c63c:	00913423          	sd	s1,8(sp)
    8000c640:	02010413          	addi	s0,sp,32
    8000c644:	00050493          	mv	s1,a0
    8000c648:	00058513          	mv	a0,a1
    char *dest = dst;
    8000c64c:	00048593          	mv	a1,s1
    while(*dest != '\0')
    8000c650:	0005c783          	lbu	a5,0(a1)
    8000c654:	00078663          	beqz	a5,8000c660 <_Z6strcatPcPKc+0x30>
        dest++;
    8000c658:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    8000c65c:	ff5ff06f          	j	8000c650 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    8000c660:	00000097          	auipc	ra,0x0
    8000c664:	f94080e7          	jalr	-108(ra) # 8000c5f4 <_Z6strcpyPKcPc>
    return dst;
    8000c668:	00048513          	mv	a0,s1
    8000c66c:	01813083          	ld	ra,24(sp)
    8000c670:	01013403          	ld	s0,16(sp)
    8000c674:	00813483          	ld	s1,8(sp)
    8000c678:	02010113          	addi	sp,sp,32
    8000c67c:	00008067          	ret

000000008000c680 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    8000c680:	ff010113          	addi	sp,sp,-16
    8000c684:	00813423          	sd	s0,8(sp)
    8000c688:	01010413          	addi	s0,sp,16
}
    8000c68c:	00813403          	ld	s0,8(sp)
    8000c690:	01010113          	addi	sp,sp,16
    8000c694:	00008067          	ret

000000008000c698 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    8000c698:	ff010113          	addi	sp,sp,-16
    8000c69c:	00813423          	sd	s0,8(sp)
    8000c6a0:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    8000c6a4:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    8000c6a8:	00001797          	auipc	a5,0x1
    8000c6ac:	0287b783          	ld	a5,40(a5) # 8000d6d0 <_ZN9Scheduler9readyHeadE>
    8000c6b0:	02078263          	beqz	a5,8000c6d4 <_ZN9Scheduler3putEP3TCB+0x3c>
    8000c6b4:	00001797          	auipc	a5,0x1
    8000c6b8:	0247b783          	ld	a5,36(a5) # 8000d6d8 <_ZN9Scheduler9readyTailE>
    8000c6bc:	04a7b423          	sd	a0,72(a5)
    8000c6c0:	00001797          	auipc	a5,0x1
    8000c6c4:	00a7bc23          	sd	a0,24(a5) # 8000d6d8 <_ZN9Scheduler9readyTailE>
}
    8000c6c8:	00813403          	ld	s0,8(sp)
    8000c6cc:	01010113          	addi	sp,sp,16
    8000c6d0:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    8000c6d4:	00001797          	auipc	a5,0x1
    8000c6d8:	fea7be23          	sd	a0,-4(a5) # 8000d6d0 <_ZN9Scheduler9readyHeadE>
    8000c6dc:	fe5ff06f          	j	8000c6c0 <_ZN9Scheduler3putEP3TCB+0x28>

000000008000c6e0 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    8000c6e0:	ff010113          	addi	sp,sp,-16
    8000c6e4:	00813423          	sd	s0,8(sp)
    8000c6e8:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    8000c6ec:	00001517          	auipc	a0,0x1
    8000c6f0:	fe453503          	ld	a0,-28(a0) # 8000d6d0 <_ZN9Scheduler9readyHeadE>
    8000c6f4:	00050a63          	beqz	a0,8000c708 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    8000c6f8:	04853783          	ld	a5,72(a0)
    8000c6fc:	00001717          	auipc	a4,0x1
    8000c700:	fcf73a23          	sd	a5,-44(a4) # 8000d6d0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    8000c704:	04053423          	sd	zero,72(a0)
    return tmp;
}
    8000c708:	00813403          	ld	s0,8(sp)
    8000c70c:	01010113          	addi	sp,sp,16
    8000c710:	00008067          	ret

000000008000c714 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    8000c714:	ff010113          	addi	sp,sp,-16
    8000c718:	00813423          	sd	s0,8(sp)
    8000c71c:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    8000c720:	00001797          	auipc	a5,0x1
    8000c724:	fc07b783          	ld	a5,-64(a5) # 8000d6e0 <_ZN9Scheduler12sleepingHeadE>
    8000c728:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    8000c72c:	00078e63          	beqz	a5,8000c748 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    8000c730:	0587b683          	ld	a3,88(a5)
    8000c734:	05853703          	ld	a4,88(a0)
    8000c738:	00d76863          	bltu	a4,a3,8000c748 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    8000c73c:	00078613          	mv	a2,a5
    8000c740:	0487b783          	ld	a5,72(a5)
    8000c744:	fe9ff06f          	j	8000c72c <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    8000c748:	04f53423          	sd	a5,72(a0)
    if(prev)
    8000c74c:	00060a63          	beqz	a2,8000c760 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    8000c750:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    8000c754:	00813403          	ld	s0,8(sp)
    8000c758:	01010113          	addi	sp,sp,16
    8000c75c:	00008067          	ret
        sleepingHead = t;
    8000c760:	00001797          	auipc	a5,0x1
    8000c764:	f8a7b023          	sd	a0,-128(a5) # 8000d6e0 <_ZN9Scheduler12sleepingHeadE>
}
    8000c768:	fedff06f          	j	8000c754 <_ZN9Scheduler5sleepEP3TCB+0x40>

000000008000c76c <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    8000c76c:	fe010113          	addi	sp,sp,-32
    8000c770:	00113c23          	sd	ra,24(sp)
    8000c774:	00813823          	sd	s0,16(sp)
    8000c778:	00913423          	sd	s1,8(sp)
    8000c77c:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    8000c780:	00001497          	auipc	s1,0x1
    8000c784:	f604b483          	ld	s1,-160(s1) # 8000d6e0 <_ZN9Scheduler12sleepingHeadE>
    8000c788:	02048c63          	beqz	s1,8000c7c0 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    8000c78c:	0584b703          	ld	a4,88(s1)
    8000c790:	ffffa797          	auipc	a5,0xffffa
    8000c794:	1607b783          	ld	a5,352(a5) # 800068f0 <_GLOBAL_OFFSET_TABLE_+0xd8>
    8000c798:	0007b783          	ld	a5,0(a5)
    8000c79c:	02e7e263          	bltu	a5,a4,8000c7c0 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    8000c7a0:	0484b783          	ld	a5,72(s1)
    8000c7a4:	00001717          	auipc	a4,0x1
    8000c7a8:	f2f73e23          	sd	a5,-196(a4) # 8000d6e0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    8000c7ac:	00048513          	mv	a0,s1
    8000c7b0:	00000097          	auipc	ra,0x0
    8000c7b4:	ee8080e7          	jalr	-280(ra) # 8000c698 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    8000c7b8:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    8000c7bc:	fc5ff06f          	j	8000c780 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    8000c7c0:	01813083          	ld	ra,24(sp)
    8000c7c4:	01013403          	ld	s0,16(sp)
    8000c7c8:	00813483          	ld	s1,8(sp)
    8000c7cc:	02010113          	addi	sp,sp,32
    8000c7d0:	00008067          	ret

000000008000c7d4 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    8000c7d4:	fe010113          	addi	sp,sp,-32
    8000c7d8:	00113c23          	sd	ra,24(sp)
    8000c7dc:	00813823          	sd	s0,16(sp)
    8000c7e0:	00913423          	sd	s1,8(sp)
    8000c7e4:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    8000c7e8:	00001497          	auipc	s1,0x1
    8000c7ec:	ee84b483          	ld	s1,-280(s1) # 8000d6d0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    8000c7f0:	02048863          	beqz	s1,8000c820 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    8000c7f4:	00000613          	li	a2,0
    8000c7f8:	01000593          	li	a1,16
    8000c7fc:	0004851b          	sext.w	a0,s1
    8000c800:	00000097          	auipc	ra,0x0
    8000c804:	3b4080e7          	jalr	948(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000c808:	00001517          	auipc	a0,0x1
    8000c80c:	a0850513          	addi	a0,a0,-1528 # 8000d210 <kernelDataStart+0x37c>
    8000c810:	00000097          	auipc	ra,0x0
    8000c814:	360080e7          	jalr	864(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    8000c818:	0484b483          	ld	s1,72(s1)
    while(iter){
    8000c81c:	fd5ff06f          	j	8000c7f0 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    8000c820:	01813083          	ld	ra,24(sp)
    8000c824:	01013403          	ld	s0,16(sp)
    8000c828:	00813483          	ld	s1,8(sp)
    8000c82c:	02010113          	addi	sp,sp,32
    8000c830:	00008067          	ret

000000008000c834 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    8000c834:	fe010113          	addi	sp,sp,-32
    8000c838:	00113c23          	sd	ra,24(sp)
    8000c83c:	00813823          	sd	s0,16(sp)
    8000c840:	00913423          	sd	s1,8(sp)
    8000c844:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    8000c848:	00001497          	auipc	s1,0x1
    8000c84c:	e984b483          	ld	s1,-360(s1) # 8000d6e0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    8000c850:	02048863          	beqz	s1,8000c880 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    8000c854:	00000613          	li	a2,0
    8000c858:	01000593          	li	a1,16
    8000c85c:	0004851b          	sext.w	a0,s1
    8000c860:	ffff5097          	auipc	ra,0xffff5
    8000c864:	d00080e7          	jalr	-768(ra) # 80001560 <_Z8printIntiii>
        printString("\n");
    8000c868:	00001517          	auipc	a0,0x1
    8000c86c:	9a850513          	addi	a0,a0,-1624 # 8000d210 <kernelDataStart+0x37c>
    8000c870:	ffff5097          	auipc	ra,0xffff5
    8000c874:	b58080e7          	jalr	-1192(ra) # 800013c8 <_Z11printStringPKc>
        iter = iter->next;
    8000c878:	0484b483          	ld	s1,72(s1)
    while(iter){
    8000c87c:	fd5ff06f          	j	8000c850 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    8000c880:	01813083          	ld	ra,24(sp)
    8000c884:	01013403          	ld	s0,16(sp)
    8000c888:	00813483          	ld	s1,8(sp)
    8000c88c:	02010113          	addi	sp,sp,32
    8000c890:	00008067          	ret

000000008000c894 <_ZN11ConsoleUtil10initializeEv>:
char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    8000c894:	fe010113          	addi	sp,sp,-32
    8000c898:	00113c23          	sd	ra,24(sp)
    8000c89c:	00813823          	sd	s0,16(sp)
    8000c8a0:	00913423          	sd	s1,8(sp)
    8000c8a4:	01213023          	sd	s2,0(sp)
    8000c8a8:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    8000c8ac:	01800513          	li	a0,24
    8000c8b0:	ffffe097          	auipc	ra,0xffffe
    8000c8b4:	140080e7          	jalr	320(ra) # 8000a9f0 <_ZN3SCBnwEm>
    8000c8b8:	00050493          	mv	s1,a0
    8000c8bc:	00050863          	beqz	a0,8000c8cc <_ZN11ConsoleUtil10initializeEv+0x38>
    8000c8c0:	00000593          	li	a1,0
    8000c8c4:	ffffe097          	auipc	ra,0xffffe
    8000c8c8:	f78080e7          	jalr	-136(ra) # 8000a83c <_ZN3SCBC1Em>
    8000c8cc:	00001797          	auipc	a5,0x1
    8000c8d0:	e097be23          	sd	s1,-484(a5) # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    8000c8d4:	01800513          	li	a0,24
    8000c8d8:	ffffe097          	auipc	ra,0xffffe
    8000c8dc:	118080e7          	jalr	280(ra) # 8000a9f0 <_ZN3SCBnwEm>
    8000c8e0:	00050493          	mv	s1,a0
    8000c8e4:	00050863          	beqz	a0,8000c8f4 <_ZN11ConsoleUtil10initializeEv+0x60>
    8000c8e8:	00000593          	li	a1,0
    8000c8ec:	ffffe097          	auipc	ra,0xffffe
    8000c8f0:	f50080e7          	jalr	-176(ra) # 8000a83c <_ZN3SCBC1Em>
    8000c8f4:	00001917          	auipc	s2,0x1
    8000c8f8:	df490913          	addi	s2,s2,-524 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000c8fc:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    8000c900:	00001497          	auipc	s1,0x1
    8000c904:	be048493          	addi	s1,s1,-1056 # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000c908:	0004b503          	ld	a0,0(s1)
    8000c90c:	00000097          	auipc	ra,0x0
    8000c910:	538080e7          	jalr	1336(ra) # 8000ce44 <_Z7kmallocm>
    8000c914:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    8000c918:	0004b503          	ld	a0,0(s1)
    8000c91c:	00000097          	auipc	ra,0x0
    8000c920:	528080e7          	jalr	1320(ra) # 8000ce44 <_Z7kmallocm>
    8000c924:	00a93c23          	sd	a0,24(s2)
}
    8000c928:	01813083          	ld	ra,24(sp)
    8000c92c:	01013403          	ld	s0,16(sp)
    8000c930:	00813483          	ld	s1,8(sp)
    8000c934:	00013903          	ld	s2,0(sp)
    8000c938:	02010113          	addi	sp,sp,32
    8000c93c:	00008067          	ret
    8000c940:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    8000c944:	00048513          	mv	a0,s1
    8000c948:	ffffe097          	auipc	ra,0xffffe
    8000c94c:	0d8080e7          	jalr	216(ra) # 8000aa20 <_ZN3SCBdlEPv>
    8000c950:	00090513          	mv	a0,s2
    8000c954:	ffffb097          	auipc	ra,0xffffb
    8000c958:	0e4080e7          	jalr	228(ra) # 80007a38 <_Unwind_Resume>
    8000c95c:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    8000c960:	00048513          	mv	a0,s1
    8000c964:	ffffe097          	auipc	ra,0xffffe
    8000c968:	0bc080e7          	jalr	188(ra) # 8000aa20 <_ZN3SCBdlEPv>
    8000c96c:	00090513          	mv	a0,s2
    8000c970:	ffffb097          	auipc	ra,0xffffb
    8000c974:	0c8080e7          	jalr	200(ra) # 80007a38 <_Unwind_Resume>

000000008000c978 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    8000c978:	00001717          	auipc	a4,0x1
    8000c97c:	d7070713          	addi	a4,a4,-656 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000c980:	02073683          	ld	a3,32(a4)
    8000c984:	00168793          	addi	a5,a3,1
    8000c988:	00001617          	auipc	a2,0x1
    8000c98c:	b5863603          	ld	a2,-1192(a2) # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000c990:	02c7f7b3          	remu	a5,a5,a2
    8000c994:	02873703          	ld	a4,40(a4)
    8000c998:	04e78e63          	beq	a5,a4,8000c9f4 <_ZN11ConsoleUtil8putInputEc+0x7c>
void ConsoleUtil::putInput(char c) {
    8000c99c:	ff010113          	addi	sp,sp,-16
    8000c9a0:	00113423          	sd	ra,8(sp)
    8000c9a4:	00813023          	sd	s0,0(sp)
    8000c9a8:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    8000c9ac:	00001717          	auipc	a4,0x1
    8000c9b0:	d3c70713          	addi	a4,a4,-708 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000c9b4:	01073783          	ld	a5,16(a4)
    8000c9b8:	00d786b3          	add	a3,a5,a3
    8000c9bc:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    8000c9c0:	02073783          	ld	a5,32(a4)
    8000c9c4:	00178793          	addi	a5,a5,1
    8000c9c8:	00001697          	auipc	a3,0x1
    8000c9cc:	b186b683          	ld	a3,-1256(a3) # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000c9d0:	02d7f7b3          	remu	a5,a5,a3
    8000c9d4:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    8000c9d8:	00073503          	ld	a0,0(a4)
    8000c9dc:	ffffe097          	auipc	ra,0xffffe
    8000c9e0:	fd8080e7          	jalr	-40(ra) # 8000a9b4 <_ZN3SCB6signalEv>
}
    8000c9e4:	00813083          	ld	ra,8(sp)
    8000c9e8:	00013403          	ld	s0,0(sp)
    8000c9ec:	01010113          	addi	sp,sp,16
    8000c9f0:	00008067          	ret
    8000c9f4:	00008067          	ret

000000008000c9f8 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    8000c9f8:	fe010113          	addi	sp,sp,-32
    8000c9fc:	00113c23          	sd	ra,24(sp)
    8000ca00:	00813823          	sd	s0,16(sp)
    8000ca04:	00913423          	sd	s1,8(sp)
    8000ca08:	02010413          	addi	s0,sp,32
    inputSem->wait();
    8000ca0c:	00001497          	auipc	s1,0x1
    8000ca10:	cdc48493          	addi	s1,s1,-804 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000ca14:	0004b503          	ld	a0,0(s1)
    8000ca18:	ffffe097          	auipc	ra,0xffffe
    8000ca1c:	f4c080e7          	jalr	-180(ra) # 8000a964 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    8000ca20:	0284b783          	ld	a5,40(s1)
    8000ca24:	0204b703          	ld	a4,32(s1)
    8000ca28:	02e78c63          	beq	a5,a4,8000ca60 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    8000ca2c:	0104b703          	ld	a4,16(s1)
    8000ca30:	00f70733          	add	a4,a4,a5
    8000ca34:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    8000ca38:	00178793          	addi	a5,a5,1
    8000ca3c:	00001717          	auipc	a4,0x1
    8000ca40:	aa473703          	ld	a4,-1372(a4) # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000ca44:	02e7f7b3          	remu	a5,a5,a4
    8000ca48:	02f4b423          	sd	a5,40(s1)

    return c;
}
    8000ca4c:	01813083          	ld	ra,24(sp)
    8000ca50:	01013403          	ld	s0,16(sp)
    8000ca54:	00813483          	ld	s1,8(sp)
    8000ca58:	02010113          	addi	sp,sp,32
    8000ca5c:	00008067          	ret
        return -1;
    8000ca60:	0ff00513          	li	a0,255
    8000ca64:	fe9ff06f          	j	8000ca4c <_ZN11ConsoleUtil8getInputEv+0x54>

000000008000ca68 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    8000ca68:	00001797          	auipc	a5,0x1
    8000ca6c:	c8078793          	addi	a5,a5,-896 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000ca70:	0307b703          	ld	a4,48(a5)
    8000ca74:	00170713          	addi	a4,a4,1
    8000ca78:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    8000ca7c:	0387b683          	ld	a3,56(a5)
    8000ca80:	00168713          	addi	a4,a3,1
    8000ca84:	00001617          	auipc	a2,0x1
    8000ca88:	a5c63603          	ld	a2,-1444(a2) # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000ca8c:	02c77733          	remu	a4,a4,a2
    8000ca90:	0407b783          	ld	a5,64(a5)
    8000ca94:	06f70463          	beq	a4,a5,8000cafc <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    8000ca98:	ff010113          	addi	sp,sp,-16
    8000ca9c:	00113423          	sd	ra,8(sp)
    8000caa0:	00813023          	sd	s0,0(sp)
    8000caa4:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    8000caa8:	00001797          	auipc	a5,0x1
    8000caac:	c4078793          	addi	a5,a5,-960 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000cab0:	0187b703          	ld	a4,24(a5)
    8000cab4:	00d706b3          	add	a3,a4,a3
    8000cab8:	00a68023          	sb	a0,0(a3)

    outputTail = (outputTail+1)%bufferSize;
    8000cabc:	0387b703          	ld	a4,56(a5)
    8000cac0:	00170713          	addi	a4,a4,1
    8000cac4:	00001697          	auipc	a3,0x1
    8000cac8:	a1c6b683          	ld	a3,-1508(a3) # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000cacc:	02d77733          	remu	a4,a4,a3
    8000cad0:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    8000cad4:	0307b703          	ld	a4,48(a5)
    8000cad8:	fff70713          	addi	a4,a4,-1
    8000cadc:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    8000cae0:	0087b503          	ld	a0,8(a5)
    8000cae4:	ffffe097          	auipc	ra,0xffffe
    8000cae8:	ed0080e7          	jalr	-304(ra) # 8000a9b4 <_ZN3SCB6signalEv>
}
    8000caec:	00813083          	ld	ra,8(sp)
    8000caf0:	00013403          	ld	s0,0(sp)
    8000caf4:	01010113          	addi	sp,sp,16
    8000caf8:	00008067          	ret
    8000cafc:	00008067          	ret

000000008000cb00 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    8000cb00:	fe010113          	addi	sp,sp,-32
    8000cb04:	00113c23          	sd	ra,24(sp)
    8000cb08:	00813823          	sd	s0,16(sp)
    8000cb0c:	00913423          	sd	s1,8(sp)
    8000cb10:	02010413          	addi	s0,sp,32
    outputSem->wait();
    8000cb14:	00001497          	auipc	s1,0x1
    8000cb18:	bd448493          	addi	s1,s1,-1068 # 8000d6e8 <_ZN11ConsoleUtil8inputSemE>
    8000cb1c:	0084b503          	ld	a0,8(s1)
    8000cb20:	ffffe097          	auipc	ra,0xffffe
    8000cb24:	e44080e7          	jalr	-444(ra) # 8000a964 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000cb28:	0404b783          	ld	a5,64(s1)
    8000cb2c:	0384b703          	ld	a4,56(s1)
    8000cb30:	02e78c63          	beq	a5,a4,8000cb68 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    8000cb34:	0184b703          	ld	a4,24(s1)
    8000cb38:	00f70733          	add	a4,a4,a5
    8000cb3c:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    8000cb40:	00178793          	addi	a5,a5,1
    8000cb44:	00001717          	auipc	a4,0x1
    8000cb48:	99c73703          	ld	a4,-1636(a4) # 8000d4e0 <_ZN11ConsoleUtil10bufferSizeE>
    8000cb4c:	02e7f7b3          	remu	a5,a5,a4
    8000cb50:	04f4b023          	sd	a5,64(s1)

    return c;
}
    8000cb54:	01813083          	ld	ra,24(sp)
    8000cb58:	01013403          	ld	s0,16(sp)
    8000cb5c:	00813483          	ld	s1,8(sp)
    8000cb60:	02010113          	addi	sp,sp,32
    8000cb64:	00008067          	ret
        return -1;
    8000cb68:	0ff00513          	li	a0,255
    8000cb6c:	fe9ff06f          	j	8000cb54 <_ZN11ConsoleUtil9getOutputEv+0x54>

000000008000cb70 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    8000cb70:	fe010113          	addi	sp,sp,-32
    8000cb74:	00113c23          	sd	ra,24(sp)
    8000cb78:	00813823          	sd	s0,16(sp)
    8000cb7c:	00913423          	sd	s1,8(sp)
    8000cb80:	02010413          	addi	s0,sp,32
    8000cb84:	00050493          	mv	s1,a0
    while (*string != '\0')
    8000cb88:	0004c503          	lbu	a0,0(s1)
    8000cb8c:	00050a63          	beqz	a0,8000cba0 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    8000cb90:	00000097          	auipc	ra,0x0
    8000cb94:	ed8080e7          	jalr	-296(ra) # 8000ca68 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    8000cb98:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000cb9c:	fedff06f          	j	8000cb88 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    8000cba0:	01813083          	ld	ra,24(sp)
    8000cba4:	01013403          	ld	s0,16(sp)
    8000cba8:	00813483          	ld	s1,8(sp)
    8000cbac:	02010113          	addi	sp,sp,32
    8000cbb0:	00008067          	ret

000000008000cbb4 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    8000cbb4:	fb010113          	addi	sp,sp,-80
    8000cbb8:	04113423          	sd	ra,72(sp)
    8000cbbc:	04813023          	sd	s0,64(sp)
    8000cbc0:	02913c23          	sd	s1,56(sp)
    8000cbc4:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    8000cbc8:	00001797          	auipc	a5,0x1
    8000cbcc:	86078793          	addi	a5,a5,-1952 # 8000d428 <kernelDataStart+0x594>
    8000cbd0:	0007b703          	ld	a4,0(a5)
    8000cbd4:	fce43423          	sd	a4,-56(s0)
    8000cbd8:	0087b703          	ld	a4,8(a5)
    8000cbdc:	fce43823          	sd	a4,-48(s0)
    8000cbe0:	0107c783          	lbu	a5,16(a5)
    8000cbe4:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000cbe8:	00060463          	beqz	a2,8000cbf0 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    8000cbec:	08054263          	bltz	a0,8000cc70 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000cbf0:	0005051b          	sext.w	a0,a0
    neg = 0;
    8000cbf4:	00000813          	li	a6,0
    }

    i = 0;
    8000cbf8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000cbfc:	0005871b          	sext.w	a4,a1
    8000cc00:	02b577bb          	remuw	a5,a0,a1
    8000cc04:	00048693          	mv	a3,s1
    8000cc08:	0014849b          	addiw	s1,s1,1
    8000cc0c:	02079793          	slli	a5,a5,0x20
    8000cc10:	0207d793          	srli	a5,a5,0x20
    8000cc14:	fe040613          	addi	a2,s0,-32
    8000cc18:	00f607b3          	add	a5,a2,a5
    8000cc1c:	fe87c603          	lbu	a2,-24(a5)
    8000cc20:	fe040793          	addi	a5,s0,-32
    8000cc24:	00d787b3          	add	a5,a5,a3
    8000cc28:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    8000cc2c:	0005061b          	sext.w	a2,a0
    8000cc30:	02b5553b          	divuw	a0,a0,a1
    8000cc34:	fce674e3          	bgeu	a2,a4,8000cbfc <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    8000cc38:	00080c63          	beqz	a6,8000cc50 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    8000cc3c:	fe040793          	addi	a5,s0,-32
    8000cc40:	009784b3          	add	s1,a5,s1
    8000cc44:	02d00793          	li	a5,45
    8000cc48:	fcf48c23          	sb	a5,-40(s1)
    8000cc4c:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000cc50:	fff4849b          	addiw	s1,s1,-1
    8000cc54:	0204c463          	bltz	s1,8000cc7c <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    8000cc58:	fe040793          	addi	a5,s0,-32
    8000cc5c:	009787b3          	add	a5,a5,s1
    8000cc60:	fd87c503          	lbu	a0,-40(a5)
    8000cc64:	00000097          	auipc	ra,0x0
    8000cc68:	e04080e7          	jalr	-508(ra) # 8000ca68 <_ZN11ConsoleUtil9putOutputEc>
    8000cc6c:	fe5ff06f          	j	8000cc50 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    8000cc70:	40a0053b          	negw	a0,a0
        neg = 1;
    8000cc74:	00100813          	li	a6,1
        x = -xx;
    8000cc78:	f81ff06f          	j	8000cbf8 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    8000cc7c:	04813083          	ld	ra,72(sp)
    8000cc80:	04013403          	ld	s0,64(sp)
    8000cc84:	03813483          	ld	s1,56(sp)
    8000cc88:	05010113          	addi	sp,sp,80
    8000cc8c:	00008067          	ret

000000008000cc90 <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    8000cc90:	fd010113          	addi	sp,sp,-48
    8000cc94:	02113423          	sd	ra,40(sp)
    8000cc98:	02813023          	sd	s0,32(sp)
    8000cc9c:	00913c23          	sd	s1,24(sp)
    8000cca0:	01213823          	sd	s2,16(sp)
    8000cca4:	01313423          	sd	s3,8(sp)
    8000cca8:	03010413          	addi	s0,sp,48
    8000ccac:	00058913          	mv	s2,a1
    8000ccb0:	00060493          	mv	s1,a2
    8000ccb4:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    8000ccb8:	00000097          	auipc	ra,0x0
    8000ccbc:	eb8080e7          	jalr	-328(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    8000ccc0:	00000613          	li	a2,0
    8000ccc4:	00098593          	mv	a1,s3
    8000ccc8:	00090513          	mv	a0,s2
    8000cccc:	00000097          	auipc	ra,0x0
    8000ccd0:	ee8080e7          	jalr	-280(ra) # 8000cbb4 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    8000ccd4:	00048513          	mv	a0,s1
    8000ccd8:	00000097          	auipc	ra,0x0
    8000ccdc:	e98080e7          	jalr	-360(ra) # 8000cb70 <_ZN11ConsoleUtil11printStringEPKc>
}
    8000cce0:	02813083          	ld	ra,40(sp)
    8000cce4:	02013403          	ld	s0,32(sp)
    8000cce8:	01813483          	ld	s1,24(sp)
    8000ccec:	01013903          	ld	s2,16(sp)
    8000ccf0:	00813983          	ld	s3,8(sp)
    8000ccf4:	03010113          	addi	sp,sp,48
    8000ccf8:	00008067          	ret

000000008000ccfc <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    8000ccfc:	ff010113          	addi	sp,sp,-16
    8000cd00:	00813423          	sd	s0,8(sp)
    8000cd04:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    8000cd08:	04300513          	li	a0,67

    asm("ecall");
    8000cd0c:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    8000cd10:	00050513          	mv	a0,a0

    return (char)status;
}
    8000cd14:	0ff57513          	andi	a0,a0,255
    8000cd18:	00813403          	ld	s0,8(sp)
    8000cd1c:	01010113          	addi	sp,sp,16
    8000cd20:	00008067          	ret

000000008000cd24 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/slab.hpp"

void kmem_init(void* space, int block_num){
    8000cd24:	ff010113          	addi	sp,sp,-16
    8000cd28:	00113423          	sd	ra,8(sp)
    8000cd2c:	00813023          	sd	s0,0(sp)
    8000cd30:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    8000cd34:	ffffd097          	auipc	ra,0xffffd
    8000cd38:	c84080e7          	jalr	-892(ra) # 800099b8 <_ZN13SlabAllocator10initializeEPvm>
}
    8000cd3c:	00813083          	ld	ra,8(sp)
    8000cd40:	00013403          	ld	s0,0(sp)
    8000cd44:	01010113          	addi	sp,sp,16
    8000cd48:	00008067          	ret

000000008000cd4c <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    8000cd4c:	ff010113          	addi	sp,sp,-16
    8000cd50:	00113423          	sd	ra,8(sp)
    8000cd54:	00813023          	sd	s0,0(sp)
    8000cd58:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    8000cd5c:	ffffd097          	auipc	ra,0xffffd
    8000cd60:	bb8080e7          	jalr	-1096(ra) # 80009914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    8000cd64:	00813083          	ld	ra,8(sp)
    8000cd68:	00013403          	ld	s0,0(sp)
    8000cd6c:	01010113          	addi	sp,sp,16
    8000cd70:	00008067          	ret

000000008000cd74 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    8000cd74:	ff010113          	addi	sp,sp,-16
    8000cd78:	00113423          	sd	ra,8(sp)
    8000cd7c:	00813023          	sd	s0,0(sp)
    8000cd80:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    8000cd84:	ffffd097          	auipc	ra,0xffffd
    8000cd88:	a54080e7          	jalr	-1452(ra) # 800097d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    8000cd8c:	00813083          	ld	ra,8(sp)
    8000cd90:	00013403          	ld	s0,0(sp)
    8000cd94:	01010113          	addi	sp,sp,16
    8000cd98:	00008067          	ret

000000008000cd9c <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    8000cd9c:	ff010113          	addi	sp,sp,-16
    8000cda0:	00113423          	sd	ra,8(sp)
    8000cda4:	00813023          	sd	s0,0(sp)
    8000cda8:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    8000cdac:	ffffd097          	auipc	ra,0xffffd
    8000cdb0:	de4080e7          	jalr	-540(ra) # 80009b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    8000cdb4:	00813083          	ld	ra,8(sp)
    8000cdb8:	00013403          	ld	s0,0(sp)
    8000cdbc:	01010113          	addi	sp,sp,16
    8000cdc0:	00008067          	ret

000000008000cdc4 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    8000cdc4:	fe010113          	addi	sp,sp,-32
    8000cdc8:	00113c23          	sd	ra,24(sp)
    8000cdcc:	00813823          	sd	s0,16(sp)
    8000cdd0:	02010413          	addi	s0,sp,32
    8000cdd4:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    8000cdd8:	fe840513          	addi	a0,s0,-24
    8000cddc:	ffffd097          	auipc	ra,0xffffd
    8000cde0:	f14080e7          	jalr	-236(ra) # 80009cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    8000cde4:	01813083          	ld	ra,24(sp)
    8000cde8:	01013403          	ld	s0,16(sp)
    8000cdec:	02010113          	addi	sp,sp,32
    8000cdf0:	00008067          	ret

000000008000cdf4 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    8000cdf4:	ff010113          	addi	sp,sp,-16
    8000cdf8:	00113423          	sd	ra,8(sp)
    8000cdfc:	00813023          	sd	s0,0(sp)
    8000ce00:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    8000ce04:	ffffc097          	auipc	ra,0xffffc
    8000ce08:	4f8080e7          	jalr	1272(ra) # 800092fc <_ZN13SlabAllocator10printCacheEP5Cache>
}
    8000ce0c:	00813083          	ld	ra,8(sp)
    8000ce10:	00013403          	ld	s0,0(sp)
    8000ce14:	01010113          	addi	sp,sp,16
    8000ce18:	00008067          	ret

000000008000ce1c <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    8000ce1c:	ff010113          	addi	sp,sp,-16
    8000ce20:	00113423          	sd	ra,8(sp)
    8000ce24:	00813023          	sd	s0,0(sp)
    8000ce28:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    8000ce2c:	ffffc097          	auipc	ra,0xffffc
    8000ce30:	308080e7          	jalr	776(ra) # 80009134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    8000ce34:	00813083          	ld	ra,8(sp)
    8000ce38:	00013403          	ld	s0,0(sp)
    8000ce3c:	01010113          	addi	sp,sp,16
    8000ce40:	00008067          	ret

000000008000ce44 <_Z7kmallocm>:
void* kmalloc(size_t size){
    8000ce44:	ff010113          	addi	sp,sp,-16
    8000ce48:	00113423          	sd	ra,8(sp)
    8000ce4c:	00813023          	sd	s0,0(sp)
    8000ce50:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    8000ce54:	ffffd097          	auipc	ra,0xffffd
    8000ce58:	a20080e7          	jalr	-1504(ra) # 80009874 <_ZN13SlabAllocator14allocateBufferEm>
}
    8000ce5c:	00813083          	ld	ra,8(sp)
    8000ce60:	00013403          	ld	s0,0(sp)
    8000ce64:	01010113          	addi	sp,sp,16
    8000ce68:	00008067          	ret

000000008000ce6c <_Z5kfreePKv>:

void kfree(const void* objp){
    8000ce6c:	ff010113          	addi	sp,sp,-16
    8000ce70:	00113423          	sd	ra,8(sp)
    8000ce74:	00813023          	sd	s0,0(sp)
    8000ce78:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    8000ce7c:	ffffd097          	auipc	ra,0xffffd
    8000ce80:	e08080e7          	jalr	-504(ra) # 80009c84 <_ZN13SlabAllocator10freeBufferEPKv>
    8000ce84:	00813083          	ld	ra,8(sp)
    8000ce88:	00013403          	ld	s0,0(sp)
    8000ce8c:	01010113          	addi	sp,sp,16
    8000ce90:	00008067          	ret

000000008000ce94 <kernelDataStart>:
    8000ce94:	0000                	unimp
    8000ce96:	0000                	unimp
    8000ce98:	62616c53          	0x62616c53
    8000ce9c:	6120                	ld	s0,64(a0)
    8000ce9e:	6464                	ld	s1,200(s0)
    8000cea0:	6572                	ld	a0,280(sp)
    8000cea2:	003a7373          	csrrci	t1,fcsr,20
    8000cea6:	0000                	unimp
    8000cea8:	754e                	ld	a0,240(sp)
    8000ceaa:	626d                	lui	tp,0x1b
    8000ceac:	7265                	lui	tp,0xffff9
    8000ceae:	6f20                	ld	s0,88(a4)
    8000ceb0:	2066                	fld	ft0,88(sp)
    8000ceb2:	746f6c73          	csrrsi	s8,0x746,30
    8000ceb6:	00003a73          	csrrc	s4,ustatus,zero
    8000ceba:	0000                	unimp
    8000cebc:	0000                	unimp
    8000cebe:	0000                	unimp
    8000cec0:	754e                	ld	a0,240(sp)
    8000cec2:	626d                	lui	tp,0x1b
    8000cec4:	7265                	lui	tp,0xffff9
    8000cec6:	6f20                	ld	s0,88(a4)
    8000cec8:	2066                	fld	ft0,88(sp)
    8000ceca:	7266                	ld	tp,120(sp)
    8000cecc:	6565                	lui	a0,0x19
    8000cece:	7320                	ld	s0,96(a4)
    8000ced0:	6f6c                	ld	a1,216(a4)
    8000ced2:	7374                	ld	a3,224(a4)
    8000ced4:	003a                	c.slli	zero,0xe
    8000ced6:	0000                	unimp
    8000ced8:	62616c53          	0x62616c53
    8000cedc:	6f20                	ld	s0,88(a4)
    8000cede:	6a62                	ld	s4,24(sp)
    8000cee0:	6365                	lui	t1,0x19
    8000cee2:	2074                	fld	fa3,192(s0)
    8000cee4:	657a6973          	csrrsi	s2,0x657,20
    8000cee8:	003a                	c.slli	zero,0xe
    8000ceea:	0000                	unimp
    8000ceec:	0000                	unimp
    8000ceee:	0000                	unimp
    8000cef0:	656a624f          	0x656a624f
    8000cef4:	6f207463          	bgeu	zero,s2,8000d5dc <_ZN5Buddy4tailE+0x5c>
    8000cef8:	6666                	ld	a2,88(sp)
    8000cefa:	3a746573          	csrrsi	a0,0x3a7,8
    8000cefe:	0000                	unimp
    8000cf00:	62616c53          	0x62616c53
    8000cf04:	6120                	ld	s0,64(a0)
    8000cf06:	6c6c                	ld	a1,216(s0)
    8000cf08:	7461636f          	jal	t1,8002364e <end+0x1494e>
    8000cf0c:	6465                	lui	s0,0x19
    8000cf0e:	6120                	ld	s0,64(a0)
    8000cf10:	7272                	ld	tp,312(sp)
    8000cf12:	7961                	lui	s2,0xffff8
    8000cf14:	6120                	ld	s0,64(a0)
    8000cf16:	6464                	ld	s1,200(s0)
    8000cf18:	6572                	ld	a0,280(sp)
    8000cf1a:	003a7373          	csrrci	t1,fcsr,20
    8000cf1e:	0000                	unimp
    8000cf20:	6c41                	lui	s8,0x10
    8000cf22:	6f6c                	ld	a1,216(a4)
    8000cf24:	65746163          	bltu	s0,s7,8000d566 <_ZN13SlabAllocator20blocksResponsibleForE+0x6>
    8000cf28:	2064                	fld	fs1,192(s0)
    8000cf2a:	74617473          	csrrci	s0,0x746,2
    8000cf2e:	7375                	lui	t1,0xffffd
    8000cf30:	6120                	ld	s0,64(a0)
    8000cf32:	7272                	ld	tp,312(sp)
    8000cf34:	7961                	lui	s2,0xffff8
    8000cf36:	0a3a                	slli	s4,s4,0xe
	...
    8000cf40:	68636143          	fmadd.s	ft2,ft6,ft6,fa3,unknown
    8000cf44:	2065                	0x2065
    8000cf46:	616e                	ld	sp,216(sp)
    8000cf48:	656d                	lui	a0,0x1b
    8000cf4a:	203a                	fld	ft0,392(sp)
    8000cf4c:	0000                	unimp
    8000cf4e:	0000                	unimp
    8000cf50:	4548                	lw	a0,12(a0)
    8000cf52:	5041                	c.li	zero,-16
    8000cf54:	535f 4154 5452      	0x54524154535f
    8000cf5a:	415f 4444 3a52      	0x3a524444415f
    8000cf60:	0020                	addi	s0,sp,8
    8000cf62:	0000                	unimp
    8000cf64:	0000                	unimp
    8000cf66:	0000                	unimp
    8000cf68:	68636143          	fmadd.s	ft2,ft6,ft6,fa3,unknown
    8000cf6c:	2065                	0x2065
    8000cf6e:	6461                	lui	s0,0x18
    8000cf70:	7264                	ld	s1,224(a2)
    8000cf72:	7365                	lui	t1,0xffff9
    8000cf74:	00203a73          	csrrc	s4,frm,zero
    8000cf78:	68636143          	fmadd.s	ft2,ft6,ft6,fa3,unknown
    8000cf7c:	2065                	0x2065
    8000cf7e:	62616c73          	csrrsi	s8,0x626,2
    8000cf82:	7320                	ld	s0,96(a4)
    8000cf84:	7a69                	lui	s4,0xffffa
    8000cf86:	3a65                	addiw	s4,s4,-7
    8000cf88:	0020                	addi	s0,sp,8
    8000cf8a:	0000                	unimp
    8000cf8c:	0000                	unimp
    8000cf8e:	0000                	unimp
    8000cf90:	68636143          	fmadd.s	ft2,ft6,ft6,fa3,unknown
    8000cf94:	2065                	0x2065
    8000cf96:	656a626f          	jal	tp,800b35ec <end+0xa48ec>
    8000cf9a:	73207463          	bgeu	zero,s2,8000d6c2 <_ZN5RiscV10globalTimeE+0x2>
    8000cf9e:	7a69                	lui	s4,0xffffa
    8000cfa0:	3a65                	addiw	s4,s4,-7
    8000cfa2:	0020                	addi	s0,sp,8
    8000cfa4:	0000                	unimp
    8000cfa6:	0000                	unimp
    8000cfa8:	6d45                	lui	s10,0x11
    8000cfaa:	7470                	ld	a2,232(s0)
    8000cfac:	2079                	0x2079
    8000cfae:	6568                	ld	a0,200(a0)
    8000cfb0:	6461                	lui	s0,0x18
    8000cfb2:	203a                	fld	ft0,392(sp)
    8000cfb4:	0000                	unimp
    8000cfb6:	0000                	unimp
    8000cfb8:	6150                	ld	a2,128(a0)
    8000cfba:	7472                	ld	s0,312(sp)
    8000cfbc:	6169                	addi	sp,sp,208
    8000cfbe:	206c                	fld	fa1,192(s0)
    8000cfc0:	6568                	ld	a0,200(a0)
    8000cfc2:	6461                	lui	s0,0x18
    8000cfc4:	203a                	fld	ft0,392(sp)
    8000cfc6:	0000                	unimp
    8000cfc8:	7546                	ld	a0,112(sp)
    8000cfca:	6c6c                	ld	a1,216(s0)
    8000cfcc:	6820                	ld	s0,80(s0)
    8000cfce:	6165                	addi	sp,sp,112
    8000cfd0:	3a64                	fld	fs1,240(a2)
    8000cfd2:	0020                	addi	s0,sp,8
    8000cfd4:	0000                	unimp
    8000cfd6:	0000                	unimp
    8000cfd8:	614d                	addi	sp,sp,176
    8000cfda:	6e69                	lui	t3,0x1a
    8000cfdc:	4320                	lw	s0,64(a4)
    8000cfde:	6361                	lui	t1,0x18
    8000cfe0:	6568                	ld	a0,200(a0)
    8000cfe2:	0000                	unimp
    8000cfe4:	0000                	unimp
    8000cfe6:	0000                	unimp
    8000cfe8:	7542                	ld	a0,48(sp)
    8000cfea:	6666                	ld	a2,88(sp)
    8000cfec:	7265                	lui	tp,0xffff9
    8000cfee:	4320                	lw	s0,64(a4)
    8000cff0:	6361                	lui	t1,0x18
    8000cff2:	6568                	ld	a0,200(a0)
    8000cff4:	4e20                	lw	s0,88(a2)
    8000cff6:	30202e6f          	jal	t3,8000f2f8 <end+0x5f8>
    8000cffa:	0000                	unimp
    8000cffc:	0000                	unimp
    8000cffe:	0000                	unimp
    8000d000:	7542                	ld	a0,48(sp)
    8000d002:	6666                	ld	a2,88(sp)
    8000d004:	7265                	lui	tp,0xffff9
    8000d006:	4320                	lw	s0,64(a4)
    8000d008:	6361                	lui	t1,0x18
    8000d00a:	6568                	ld	a0,200(a0)
    8000d00c:	4e20                	lw	s0,88(a2)
    8000d00e:	31202e6f          	jal	t3,8000f320 <end+0x620>
    8000d012:	0000                	unimp
    8000d014:	0000                	unimp
    8000d016:	0000                	unimp
    8000d018:	7542                	ld	a0,48(sp)
    8000d01a:	6666                	ld	a2,88(sp)
    8000d01c:	7265                	lui	tp,0xffff9
    8000d01e:	4320                	lw	s0,64(a4)
    8000d020:	6361                	lui	t1,0x18
    8000d022:	6568                	ld	a0,200(a0)
    8000d024:	4e20                	lw	s0,88(a2)
    8000d026:	32202e6f          	jal	t3,8000f348 <end+0x648>
    8000d02a:	0000                	unimp
    8000d02c:	0000                	unimp
    8000d02e:	0000                	unimp
    8000d030:	7542                	ld	a0,48(sp)
    8000d032:	6666                	ld	a2,88(sp)
    8000d034:	7265                	lui	tp,0xffff9
    8000d036:	4320                	lw	s0,64(a4)
    8000d038:	6361                	lui	t1,0x18
    8000d03a:	6568                	ld	a0,200(a0)
    8000d03c:	4e20                	lw	s0,88(a2)
    8000d03e:	33202e6f          	jal	t3,8000f370 <end+0x670>
    8000d042:	0000                	unimp
    8000d044:	0000                	unimp
    8000d046:	0000                	unimp
    8000d048:	7542                	ld	a0,48(sp)
    8000d04a:	6666                	ld	a2,88(sp)
    8000d04c:	7265                	lui	tp,0xffff9
    8000d04e:	4320                	lw	s0,64(a4)
    8000d050:	6361                	lui	t1,0x18
    8000d052:	6568                	ld	a0,200(a0)
    8000d054:	4e20                	lw	s0,88(a2)
    8000d056:	34202e6f          	jal	t3,8000f398 <end+0x698>
    8000d05a:	0000                	unimp
    8000d05c:	0000                	unimp
    8000d05e:	0000                	unimp
    8000d060:	7542                	ld	a0,48(sp)
    8000d062:	6666                	ld	a2,88(sp)
    8000d064:	7265                	lui	tp,0xffff9
    8000d066:	4320                	lw	s0,64(a4)
    8000d068:	6361                	lui	t1,0x18
    8000d06a:	6568                	ld	a0,200(a0)
    8000d06c:	4e20                	lw	s0,88(a2)
    8000d06e:	35202e6f          	jal	t3,8000f3c0 <end+0x6c0>
    8000d072:	0000                	unimp
    8000d074:	0000                	unimp
    8000d076:	0000                	unimp
    8000d078:	7542                	ld	a0,48(sp)
    8000d07a:	6666                	ld	a2,88(sp)
    8000d07c:	7265                	lui	tp,0xffff9
    8000d07e:	4320                	lw	s0,64(a4)
    8000d080:	6361                	lui	t1,0x18
    8000d082:	6568                	ld	a0,200(a0)
    8000d084:	4e20                	lw	s0,88(a2)
    8000d086:	36202e6f          	jal	t3,8000f3e8 <end+0x6e8>
    8000d08a:	0000                	unimp
    8000d08c:	0000                	unimp
    8000d08e:	0000                	unimp
    8000d090:	7542                	ld	a0,48(sp)
    8000d092:	6666                	ld	a2,88(sp)
    8000d094:	7265                	lui	tp,0xffff9
    8000d096:	4320                	lw	s0,64(a4)
    8000d098:	6361                	lui	t1,0x18
    8000d09a:	6568                	ld	a0,200(a0)
    8000d09c:	4e20                	lw	s0,88(a2)
    8000d09e:	37202e6f          	jal	t3,8000f410 <end+0x710>
    8000d0a2:	0000                	unimp
    8000d0a4:	0000                	unimp
    8000d0a6:	0000                	unimp
    8000d0a8:	7542                	ld	a0,48(sp)
    8000d0aa:	6666                	ld	a2,88(sp)
    8000d0ac:	7265                	lui	tp,0xffff9
    8000d0ae:	4320                	lw	s0,64(a4)
    8000d0b0:	6361                	lui	t1,0x18
    8000d0b2:	6568                	ld	a0,200(a0)
    8000d0b4:	4e20                	lw	s0,88(a2)
    8000d0b6:	38202e6f          	jal	t3,8000f438 <end+0x738>
    8000d0ba:	0000                	unimp
    8000d0bc:	0000                	unimp
    8000d0be:	0000                	unimp
    8000d0c0:	7542                	ld	a0,48(sp)
    8000d0c2:	6666                	ld	a2,88(sp)
    8000d0c4:	7265                	lui	tp,0xffff9
    8000d0c6:	4320                	lw	s0,64(a4)
    8000d0c8:	6361                	lui	t1,0x18
    8000d0ca:	6568                	ld	a0,200(a0)
    8000d0cc:	4e20                	lw	s0,88(a2)
    8000d0ce:	39202e6f          	jal	t3,8000f460 <end+0x760>
    8000d0d2:	0000                	unimp
    8000d0d4:	0000                	unimp
    8000d0d6:	0000                	unimp
    8000d0d8:	7542                	ld	a0,48(sp)
    8000d0da:	6666                	ld	a2,88(sp)
    8000d0dc:	7265                	lui	tp,0xffff9
    8000d0de:	4320                	lw	s0,64(a4)
    8000d0e0:	6361                	lui	t1,0x18
    8000d0e2:	6568                	ld	a0,200(a0)
    8000d0e4:	4e20                	lw	s0,88(a2)
    8000d0e6:	31202e6f          	jal	t3,8000f3f8 <end+0x6f8>
    8000d0ea:	0030                	addi	a2,sp,8
    8000d0ec:	0000                	unimp
    8000d0ee:	0000                	unimp
    8000d0f0:	7542                	ld	a0,48(sp)
    8000d0f2:	6666                	ld	a2,88(sp)
    8000d0f4:	7265                	lui	tp,0xffff9
    8000d0f6:	4320                	lw	s0,64(a4)
    8000d0f8:	6361                	lui	t1,0x18
    8000d0fa:	6568                	ld	a0,200(a0)
    8000d0fc:	4e20                	lw	s0,88(a2)
    8000d0fe:	31202e6f          	jal	t3,8000f410 <end+0x710>
    8000d102:	0031                	c.nop	12
    8000d104:	0000                	unimp
    8000d106:	0000                	unimp
    8000d108:	7542                	ld	a0,48(sp)
    8000d10a:	6666                	ld	a2,88(sp)
    8000d10c:	7265                	lui	tp,0xffff9
    8000d10e:	4320                	lw	s0,64(a4)
    8000d110:	6361                	lui	t1,0x18
    8000d112:	6568                	ld	a0,200(a0)
    8000d114:	4e20                	lw	s0,88(a2)
    8000d116:	31202e6f          	jal	t3,8000f428 <end+0x728>
    8000d11a:	0032                	c.slli	zero,0xc
    8000d11c:	0000                	unimp
    8000d11e:	0000                	unimp
    8000d120:	72617453          	0x72617453
    8000d124:	6574                	ld	a3,200(a0)
    8000d126:	2064                	fld	fs1,192(s0)
    8000d128:	6874                	ld	a3,208(s0)
    8000d12a:	6572                	ld	a0,280(sp)
    8000d12c:	6461                	lui	s0,0x18
    8000d12e:	6920                	ld	s0,80(a0)
    8000d130:	3a64                	fld	fs1,240(a2)
    8000d132:	0000                	unimp
    8000d134:	0000                	unimp
    8000d136:	0000                	unimp
    8000d138:	6946                	ld	s2,80(sp)
    8000d13a:	696e                	ld	s2,216(sp)
    8000d13c:	64656873          	csrrsi	a6,0x646,10
    8000d140:	7420                	ld	s0,104(s0)
    8000d142:	7268                	ld	a0,224(a2)
    8000d144:	6165                	addi	sp,sp,112
    8000d146:	2064                	fld	fs1,192(s0)
    8000d148:	6469                	lui	s0,0x1a
    8000d14a:	003a                	c.slli	zero,0xe
    8000d14c:	0000                	unimp
    8000d14e:	0000                	unimp
    8000d150:	7355                	lui	t1,0xffff5
    8000d152:	7265                	lui	tp,0xffff9
    8000d154:	6d20                	ld	s0,88(a0)
    8000d156:	6961                	lui	s2,0x18
    8000d158:	206e                	fld	ft0,216(sp)
    8000d15a:	6966                	ld	s2,88(sp)
    8000d15c:	696e                	ld	s2,216(sp)
    8000d15e:	64656873          	csrrsi	a6,0x646,10
    8000d162:	000a                	c.slli	zero,0x2
    8000d164:	0000                	unimp
    8000d166:	0000                	unimp
    8000d168:	203a                	fld	ft0,392(sp)
    8000d16a:	0000                	unimp
    8000d16c:	0000                	unimp
    8000d16e:	0000                	unimp
    8000d170:	20424353          	0x20424353
    8000d174:	68636143          	fmadd.s	ft2,ft6,ft6,fa3,unknown
    8000d178:	0065                	c.nop	25
    8000d17a:	0000                	unimp
    8000d17c:	0000                	unimp
    8000d17e:	0000                	unimp
    8000d180:	4354                	lw	a3,4(a4)
    8000d182:	2042                	fld	ft0,16(sp)
    8000d184:	68636143          	fmadd.s	ft2,ft6,ft6,fa3,unknown
    8000d188:	0065                	c.nop	25
    8000d18a:	0000                	unimp
    8000d18c:	0000                	unimp
    8000d18e:	0000                	unimp
    8000d190:	4f4e                	lw	t5,208(sp)
    8000d192:	48532057          	0x48532057
    8000d196:	4e49574f          	fnmadd.q	fa4,fs2,ft4,fs1,unknown
    8000d19a:	4c412047          	0x4c412047
    8000d19e:	4f4c                	lw	a1,28(a4)
    8000d1a0:	45544143          	0x45544143
    8000d1a4:	2044                	fld	fs1,128(s0)
    8000d1a6:	454d                	li	a0,19
    8000d1a8:	4f4d                	li	t5,19
    8000d1aa:	5952                	lw	s2,52(sp)
    8000d1ac:	000a                	c.slli	zero,0x2
    8000d1ae:	0000                	unimp
    8000d1b0:	4f4e                	lw	t5,208(sp)
    8000d1b2:	48532057          	0x48532057
    8000d1b6:	4e49574f          	fnmadd.q	fa4,fs2,ft4,fs1,unknown
    8000d1ba:	52462047          	fmsub.d	ft0,fa2,ft4,fa0,rdn
    8000d1be:	4545                	li	a0,17
    8000d1c0:	4d20                	lw	s0,88(a0)
    8000d1c2:	4d45                	li	s10,17
    8000d1c4:	0a59524f          	fnmadd.d	ft4,fs2,ft5,ft1,unknown
	...
    8000d1d0:	3d3d                	addiw	s10,s10,-17
    8000d1d2:	3d3d                	addiw	s10,s10,-17
    8000d1d4:	3d3d                	addiw	s10,s10,-17
    8000d1d6:	3d3d                	addiw	s10,s10,-17
    8000d1d8:	3d3d                	addiw	s10,s10,-17
    8000d1da:	3d3d                	addiw	s10,s10,-17
    8000d1dc:	3d3d                	addiw	s10,s10,-17
    8000d1de:	3d3d                	addiw	s10,s10,-17
    8000d1e0:	3d3d                	addiw	s10,s10,-17
    8000d1e2:	3d3d                	addiw	s10,s10,-17
    8000d1e4:	3d3d                	addiw	s10,s10,-17
    8000d1e6:	3d3d                	addiw	s10,s10,-17
    8000d1e8:	3d3d                	addiw	s10,s10,-17
    8000d1ea:	3d3d                	addiw	s10,s10,-17
    8000d1ec:	3d3d                	addiw	s10,s10,-17
    8000d1ee:	3d3d                	addiw	s10,s10,-17
    8000d1f0:	3d3d                	addiw	s10,s10,-17
    8000d1f2:	3d3d                	addiw	s10,s10,-17
    8000d1f4:	3d3d                	addiw	s10,s10,-17
    8000d1f6:	3d3d                	addiw	s10,s10,-17
    8000d1f8:	3d3d                	addiw	s10,s10,-17
    8000d1fa:	3d3d                	addiw	s10,s10,-17
    8000d1fc:	3d3d                	addiw	s10,s10,-17
    8000d1fe:	3d3d                	addiw	s10,s10,-17
    8000d200:	3d3d                	addiw	s10,s10,-17
    8000d202:	3d3d                	addiw	s10,s10,-17
    8000d204:	3d3d                	addiw	s10,s10,-17
    8000d206:	3d3d                	addiw	s10,s10,-17
    8000d208:	3d3d                	addiw	s10,s10,-17
    8000d20a:	3d3d                	addiw	s10,s10,-17
    8000d20c:	3d3d                	addiw	s10,s10,-17
    8000d20e:	3d3d                	addiw	s10,s10,-17
    8000d210:	000a                	c.slli	zero,0x2
    8000d212:	0000                	unimp
    8000d214:	0000                	unimp
    8000d216:	0000                	unimp
    8000d218:	7865546b          	0x7865546b
    8000d21c:	5374                	lw	a3,100(a4)
    8000d21e:	6174                	ld	a3,192(a0)
    8000d220:	7472                	ld	s0,312(sp)
    8000d222:	0000                	unimp
    8000d224:	0000                	unimp
    8000d226:	0000                	unimp
    8000d228:	7461446b          	0x7461446b
    8000d22c:	5361                	li	t1,-8
    8000d22e:	6174                	ld	a3,192(a0)
    8000d230:	7472                	ld	s0,312(sp)
    8000d232:	0000                	unimp
    8000d234:	0000                	unimp
    8000d236:	0000                	unimp
    8000d238:	63706573          	csrrsi	a0,0x637,0
    8000d23c:	203a                	fld	ft0,392(sp)
    8000d23e:	0000                	unimp
    8000d240:	6c49                	lui	s8,0x12
    8000d242:	656c                	ld	a1,200(a0)
    8000d244:	206c6167          	0x206c6167
    8000d248:	6e69                	lui	t3,0x1a
    8000d24a:	75727473          	csrrci	s0,0x757,4
    8000d24e:	6f697463          	bgeu	s2,s6,8000d936 <_ZN11ConsoleUtil11pendingGetcE+0x206>
    8000d252:	0a6e                	slli	s4,s4,0x1b
    8000d254:	7845                	lui	a6,0xffff1
    8000d256:	7469                	lui	s0,0xffffa
    8000d258:	6e69                	lui	t3,0x1a
    8000d25a:	68742067          	0x68742067
    8000d25e:	6572                	ld	a0,280(sp)
    8000d260:	6461                	lui	s0,0x18
    8000d262:	2e2e                	fld	ft8,200(sp)
    8000d264:	0a2e                	slli	s4,s4,0xb
    8000d266:	0000                	unimp
    8000d268:	7245                	lui	tp,0xffff1
    8000d26a:	6f72                	ld	t5,280(sp)
    8000d26c:	3a72                	fld	fs4,312(sp)
    8000d26e:	0a20                	addi	s0,sp,280
	...
    8000d278:	75616373          	csrrsi	t1,0x756,2
    8000d27c:	203a6573          	csrrsi	a0,hideleg,20
	...
    8000d288:	7845                	lui	a6,0xffff1
    8000d28a:	7469                	lui	s0,0xffffa
    8000d28c:	6e69                	lui	t3,0x1a
    8000d28e:	68742067          	0x68742067
    8000d292:	6572                	ld	a0,280(sp)
    8000d294:	6461                	lui	s0,0x18
    8000d296:	2e2e                	fld	ft8,200(sp)
    8000d298:	0a2e                	slli	s4,s4,0xb
    8000d29a:	0000                	unimp
    8000d29c:	f0ac                	sd	a1,96(s1)
    8000d29e:	ffff                	0xffff
    8000d2a0:	f0a4                	sd	s1,96(s1)
    8000d2a2:	ffff                	0xffff
    8000d2a4:	f0e0                	sd	s0,224(s1)
    8000d2a6:	ffff                	0xffff
    8000d2a8:	f0ac                	sd	a1,96(s1)
    8000d2aa:	ffff                	0xffff
    8000d2ac:	f0ac                	sd	a1,96(s1)
    8000d2ae:	ffff                	0xffff
    8000d2b0:	f0ac                	sd	a1,96(s1)
    8000d2b2:	ffff                	0xffff
    8000d2b4:	f0ac                	sd	a1,96(s1)
    8000d2b6:	ffff                	0xffff
    8000d2b8:	f0ac                	sd	a1,96(s1)
    8000d2ba:	ffff                	0xffff
    8000d2bc:	f0ac                	sd	a1,96(s1)
    8000d2be:	ffff                	0xffff
    8000d2c0:	f0ac                	sd	a1,96(s1)
    8000d2c2:	ffff                	0xffff
    8000d2c4:	f0ac                	sd	a1,96(s1)
    8000d2c6:	ffff                	0xffff
    8000d2c8:	f0ac                	sd	a1,96(s1)
    8000d2ca:	ffff                	0xffff
    8000d2cc:	f0ac                	sd	a1,96(s1)
    8000d2ce:	ffff                	0xffff
    8000d2d0:	f0ac                	sd	a1,96(s1)
    8000d2d2:	ffff                	0xffff
    8000d2d4:	f0ac                	sd	a1,96(s1)
    8000d2d6:	ffff                	0xffff
    8000d2d8:	f0ac                	sd	a1,96(s1)
    8000d2da:	ffff                	0xffff
    8000d2dc:	f0ac                	sd	a1,96(s1)
    8000d2de:	ffff                	0xffff
    8000d2e0:	f0ec                	sd	a1,224(s1)
    8000d2e2:	ffff                	0xffff
    8000d2e4:	f0f8                	sd	a4,224(s1)
    8000d2e6:	ffff                	0xffff
    8000d2e8:	f104                	sd	s1,32(a0)
    8000d2ea:	ffff                	0xffff
    8000d2ec:	f110                	sd	a2,32(a0)
    8000d2ee:	ffff                	0xffff
    8000d2f0:	f11c                	sd	a5,32(a0)
    8000d2f2:	ffff                	0xffff
    8000d2f4:	f0ac                	sd	a1,96(s1)
    8000d2f6:	ffff                	0xffff
    8000d2f8:	f0ac                	sd	a1,96(s1)
    8000d2fa:	ffff                	0xffff
    8000d2fc:	f0ac                	sd	a1,96(s1)
    8000d2fe:	ffff                	0xffff
    8000d300:	f0ac                	sd	a1,96(s1)
    8000d302:	ffff                	0xffff
    8000d304:	f0ac                	sd	a1,96(s1)
    8000d306:	ffff                	0xffff
    8000d308:	f0ac                	sd	a1,96(s1)
    8000d30a:	ffff                	0xffff
    8000d30c:	f0ac                	sd	a1,96(s1)
    8000d30e:	ffff                	0xffff
    8000d310:	f0ac                	sd	a1,96(s1)
    8000d312:	ffff                	0xffff
    8000d314:	f0ac                	sd	a1,96(s1)
    8000d316:	ffff                	0xffff
    8000d318:	f0ac                	sd	a1,96(s1)
    8000d31a:	ffff                	0xffff
    8000d31c:	f0ac                	sd	a1,96(s1)
    8000d31e:	ffff                	0xffff
    8000d320:	f128                	sd	a0,96(a0)
    8000d322:	ffff                	0xffff
    8000d324:	f134                	sd	a3,96(a0)
    8000d326:	ffff                	0xffff
    8000d328:	f140                	sd	s0,160(a0)
    8000d32a:	ffff                	0xffff
    8000d32c:	f14c                	sd	a1,160(a0)
    8000d32e:	ffff                	0xffff
    8000d330:	f0ac                	sd	a1,96(s1)
    8000d332:	ffff                	0xffff
    8000d334:	f0ac                	sd	a1,96(s1)
    8000d336:	ffff                	0xffff
    8000d338:	f0ac                	sd	a1,96(s1)
    8000d33a:	ffff                	0xffff
    8000d33c:	f0ac                	sd	a1,96(s1)
    8000d33e:	ffff                	0xffff
    8000d340:	f0ac                	sd	a1,96(s1)
    8000d342:	ffff                	0xffff
    8000d344:	f0ac                	sd	a1,96(s1)
    8000d346:	ffff                	0xffff
    8000d348:	f0ac                	sd	a1,96(s1)
    8000d34a:	ffff                	0xffff
    8000d34c:	f0ac                	sd	a1,96(s1)
    8000d34e:	ffff                	0xffff
    8000d350:	f0ac                	sd	a1,96(s1)
    8000d352:	ffff                	0xffff
    8000d354:	f0ac                	sd	a1,96(s1)
    8000d356:	ffff                	0xffff
    8000d358:	f0ac                	sd	a1,96(s1)
    8000d35a:	ffff                	0xffff
    8000d35c:	f0ac                	sd	a1,96(s1)
    8000d35e:	ffff                	0xffff
    8000d360:	f158                	sd	a4,160(a0)
    8000d362:	ffff                	0xffff
    8000d364:	f0ac                	sd	a1,96(s1)
    8000d366:	ffff                	0xffff
    8000d368:	f0ac                	sd	a1,96(s1)
    8000d36a:	ffff                	0xffff
    8000d36c:	f0ac                	sd	a1,96(s1)
    8000d36e:	ffff                	0xffff
    8000d370:	f0ac                	sd	a1,96(s1)
    8000d372:	ffff                	0xffff
    8000d374:	f0ac                	sd	a1,96(s1)
    8000d376:	ffff                	0xffff
    8000d378:	f0ac                	sd	a1,96(s1)
    8000d37a:	ffff                	0xffff
    8000d37c:	f0ac                	sd	a1,96(s1)
    8000d37e:	ffff                	0xffff
    8000d380:	f0ac                	sd	a1,96(s1)
    8000d382:	ffff                	0xffff
    8000d384:	f0ac                	sd	a1,96(s1)
    8000d386:	ffff                	0xffff
    8000d388:	f0ac                	sd	a1,96(s1)
    8000d38a:	ffff                	0xffff
    8000d38c:	f0ac                	sd	a1,96(s1)
    8000d38e:	ffff                	0xffff
    8000d390:	f0ac                	sd	a1,96(s1)
    8000d392:	ffff                	0xffff
    8000d394:	f0ac                	sd	a1,96(s1)
    8000d396:	ffff                	0xffff
    8000d398:	f0ac                	sd	a1,96(s1)
    8000d39a:	ffff                	0xffff
    8000d39c:	f0ac                	sd	a1,96(s1)
    8000d39e:	ffff                	0xffff
    8000d3a0:	f164                	sd	s1,224(a0)
    8000d3a2:	ffff                	0xffff
    8000d3a4:	f170                	sd	a2,224(a0)
    8000d3a6:	ffff                	0xffff
    8000d3a8:	f17c                	sd	a5,224(a0)
    8000d3aa:	ffff                	0xffff
    8000d3ac:	f0ac                	sd	a1,96(s1)
    8000d3ae:	ffff                	0xffff
    8000d3b0:	f0ac                	sd	a1,96(s1)
    8000d3b2:	ffff                	0xffff
    8000d3b4:	f0ac                	sd	a1,96(s1)
    8000d3b6:	ffff                	0xffff
    8000d3b8:	f0ac                	sd	a1,96(s1)
    8000d3ba:	ffff                	0xffff
    8000d3bc:	f0ac                	sd	a1,96(s1)
    8000d3be:	ffff                	0xffff
    8000d3c0:	f0ac                	sd	a1,96(s1)
    8000d3c2:	ffff                	0xffff
    8000d3c4:	f0ac                	sd	a1,96(s1)
    8000d3c6:	ffff                	0xffff
    8000d3c8:	f0ac                	sd	a1,96(s1)
    8000d3ca:	ffff                	0xffff
    8000d3cc:	f0ac                	sd	a1,96(s1)
    8000d3ce:	ffff                	0xffff
    8000d3d0:	f0ac                	sd	a1,96(s1)
    8000d3d2:	ffff                	0xffff
    8000d3d4:	f0ac                	sd	a1,96(s1)
    8000d3d6:	ffff                	0xffff
    8000d3d8:	f0ac                	sd	a1,96(s1)
    8000d3da:	ffff                	0xffff
    8000d3dc:	f0ac                	sd	a1,96(s1)
    8000d3de:	ffff                	0xffff
    8000d3e0:	f188                	sd	a0,32(a1)
    8000d3e2:	ffff                	0xffff
    8000d3e4:	f194                	sd	a3,32(a1)
    8000d3e6:	ffff                	0xffff
    8000d3e8:	f0ac                	sd	a1,96(s1)
    8000d3ea:	ffff                	0xffff
    8000d3ec:	f0ac                	sd	a1,96(s1)
    8000d3ee:	ffff                	0xffff
    8000d3f0:	f0ac                	sd	a1,96(s1)
    8000d3f2:	ffff                	0xffff
    8000d3f4:	f0ac                	sd	a1,96(s1)
    8000d3f6:	ffff                	0xffff
    8000d3f8:	f0ac                	sd	a1,96(s1)
    8000d3fa:	ffff                	0xffff
    8000d3fc:	f0ac                	sd	a1,96(s1)
    8000d3fe:	ffff                	0xffff
    8000d400:	f0ac                	sd	a1,96(s1)
    8000d402:	ffff                	0xffff
    8000d404:	f0ac                	sd	a1,96(s1)
    8000d406:	ffff                	0xffff
    8000d408:	f0ac                	sd	a1,96(s1)
    8000d40a:	ffff                	0xffff
    8000d40c:	f0ac                	sd	a1,96(s1)
    8000d40e:	ffff                	0xffff
    8000d410:	f0ac                	sd	a1,96(s1)
    8000d412:	ffff                	0xffff
    8000d414:	f0ac                	sd	a1,96(s1)
    8000d416:	ffff                	0xffff
    8000d418:	f0ac                	sd	a1,96(s1)
    8000d41a:	ffff                	0xffff
    8000d41c:	f0ac                	sd	a1,96(s1)
    8000d41e:	ffff                	0xffff
    8000d420:	f1a0                	sd	s0,96(a1)
    8000d422:	ffff                	0xffff
    8000d424:	0000                	unimp
    8000d426:	0000                	unimp
    8000d428:	3130                	fld	fa2,96(a0)
    8000d42a:	3332                	fld	ft6,296(sp)
    8000d42c:	3534                	fld	fa3,104(a0)
    8000d42e:	3736                	fld	fa4,360(sp)
    8000d430:	3938                	fld	fa4,112(a0)
    8000d432:	4241                	li	tp,16
    8000d434:	46454443          	fmadd.q	fs0,fa0,ft4,fs0,rmm
	...

000000008000d440 <_ZN13SlabAllocator5namesE>:
    8000d440:	8000cfe8 00000000 8000d000 00000000     ................
    8000d450:	8000d018 00000000 8000d030 00000000     ........0.......
    8000d460:	8000d048 00000000 8000d060 00000000     H.......`.......
    8000d470:	8000d078 00000000 8000d090 00000000     x...............
    8000d480:	8000d0a8 00000000 8000d0c0 00000000     ................
    8000d490:	8000d0d8 00000000 8000d0f0 00000000     ................
    8000d4a0:	8000d108 00000000                       ........

000000008000d4a8 <_ZTV10ForkThread>:
	...
    8000d4b8:	8000a15c 00000000 8000a190 00000000     \...............
    8000d4c8:	80009f64 00000000                       d.......

000000008000d4d0 <DW.ref.__gxx_personality_v0>:
    8000d4d0:	80007a40 00000000                       @z......

000000008000d4d8 <_ZN5Buddy16BLOCKS_AVAILABLEE>:
    8000d4d8:	00001000 00000000                       ........

000000008000d4e0 <_ZN11ConsoleUtil10bufferSizeE>:
    8000d4e0:	00002000 00000000                       . ......

000000008000d4e8 <_ZN13SlabAllocator5sizeNE>:
	...

000000008000d550 <_ZN13SlabAllocator5cacheE>:
	...

000000008000d558 <_ZN13SlabAllocator9startAddrE>:
	...

000000008000d560 <_ZN13SlabAllocator20blocksResponsibleForE>:
	...

000000008000d568 <_ZN6System11initializedE>:
	...

000000008000d570 <_ZN5Buddy16BUDDY_START_ADDRE>:
	...

000000008000d578 <_ZN5Buddy20BUDDY_META_DATA_ADDRE>:
	...

000000008000d580 <_ZN5Buddy4tailE>:
	...

000000008000d5e8 <_ZN5Buddy4headE>:
	...

000000008000d650 <_ZN3SCB8scbCacheE>:
	...

000000008000d658 <_ZN3TCB7runningE>:
	...

000000008000d660 <_ZN3TCB8tcbCacheE>:
	...

000000008000d668 <_ZN3TCB10putcThreadE>:
	...

000000008000d670 <_ZN3TCB16timeSliceCounterE>:
	...

000000008000d678 <_ZN3TCB9currentSPE>:
	...

000000008000d680 <_ZN3TCB9currentPCE>:
	...

000000008000d688 <_ZN15MemoryAllocator11freeMemTailE>:
	...

000000008000d690 <_ZN15MemoryAllocator11freeMemHeadE>:
	...

000000008000d698 <_ZN15MemoryAllocator12allocMemTailE>:
	...

000000008000d6a0 <_ZN15MemoryAllocator12allocMemHeadE>:
	...

000000008000d6a8 <_ZN15MemoryAllocator11initializedE>:
	...

000000008000d6b0 <_ZN5RiscV4kPMTE>:
	...

000000008000d6b8 <_ZN5RiscV16userMainFinishedE>:
	...

000000008000d6c0 <_ZN5RiscV10globalTimeE>:
	...

000000008000d6c8 <_ZN5RiscV4uPMTE>:
	...

000000008000d6d0 <_ZN9Scheduler9readyHeadE>:
	...

000000008000d6d8 <_ZN9Scheduler9readyTailE>:
	...

000000008000d6e0 <_ZN9Scheduler12sleepingHeadE>:
	...

000000008000d6e8 <_ZN11ConsoleUtil8inputSemE>:
	...

000000008000d6f0 <_ZN11ConsoleUtil9outputSemE>:
	...

000000008000d6f8 <_ZN11ConsoleUtil11inputBufferE>:
	...

000000008000d700 <_ZN11ConsoleUtil12outputBufferE>:
	...

000000008000d708 <_ZN11ConsoleUtil9inputTailE>:
	...

000000008000d710 <_ZN11ConsoleUtil9inputHeadE>:
	...

000000008000d718 <_ZN11ConsoleUtil11pendingPutcE>:
	...

000000008000d720 <_ZN11ConsoleUtil10outputTailE>:
	...

000000008000d728 <_ZN11ConsoleUtil10outputHeadE>:
	...

000000008000d730 <_ZN11ConsoleUtil11pendingGetcE>:
	...
    8000d738:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000d748:	00020d1b 0000002c 00000018 ffffb9e0     ....,...........
    8000d758:	00000068 000e4400 00000000 92000000     h....D..........
    8000d768:	080c4408 00000000 20020c00 d244c944     .D......... D.D.
    8000d778:	00000e44 00000030 00000048 ffffba18     D...0...H.......
    8000d788:	00000160 000e4800 00000000 92000000     `....H..........
    8000d798:	080c4408 002c0300 0c000000 c9442002     .D....,...... D.
    8000d7a8:	0e44d244 00000000 00000030 0000007c     D.D.....0...|...
    8000d7b8:	ffffbb44 00000208 000e4400 00000000     D........D......
    8000d7c8:	92000000 080c4408 00dc0300 0c000000     .....D..........
    8000d7d8:	c9442002 0e44d244 00000000 00000020     . D.D.D..... ...
    8000d7e8:	000000b0 ffffbd18 00000030 100e4400     ........0....D..
    8000d7f8:	44028844 0000000c 10020c00 00000e44     D..D........D...
    8000d808:	00000030 000000d4 ffffbd24 0000010c     0.......$.......
    8000d818:	000e4400 00000000 00000000 440a9300     .D.............D
    8000d828:	0200080c 00000000 4430020c 44d244c9     ..........0D.D.D
    8000d838:	000e44d3 00000024 00000108 ffffbdfc     .D..$...........
    8000d848:	00000054 100e4400 44028844 0000000c     T....D..D..D....
    8000d858:	020c0000 000e4410 00000b44 0000002c     .....D..D...,...
    8000d868:	00000130 ffffbe28 00000054 000e4400     0...(...T....D..
    8000d878:	00000000 92000000 080c4408 00000000     .........D......
    8000d888:	20020c00 d244c944 00000e44 0000002c     ... D.D.D...,...
    8000d898:	00000160 ffffbe4c 000000f0 000e4400     `...L........D..
    8000d8a8:	00000000 92000000 080c4408 00000200     .........D......
    8000d8b8:	020c0000 44c94420 000e44d2 00000030     .... D.D.D..0...
    8000d8c8:	00000190 ffffbf0c 0000009c 000e4400     .............D..
    8000d8d8:	00000000 92000000 000c4408 00000000     .........D......
    8000d8e8:	020c0000 44c94420 000e44d2 00000b44     .... D.D.D..D...
    8000d8f8:	00000024 000001c4 ffffbf74 000000a0     $.......t.......
    8000d908:	0e600200 00000000 0c440488 00000008     ..`.......D.....
    8000d918:	020c0000 000e4410 00000038 000001ec     .....D..8.......
    8000d928:	ffffbfec 000000a4 000e4400 00000000     .........D......
	...
    8000d940:	440e9500 0200080c 00000000 4440020c     ...D..........@D
    8000d950:	44d244c9 44d444d3 000e44d5 0000002c     .D.D.D.D.D..,...
    8000d960:	00000228 ffffc054 000000f0 000e4400     (...T........D..
    8000d970:	00000000 92000000 080c4408 00000200     .........D......
    8000d980:	020c0000 44c94420 000e44d2 00000034     .... D.D.D..4...
    8000d990:	00000258 ffffc114 000000e8 000e6800     X............h..
    8000d9a0:	00000000 44068900 0000080c 00000000     .......D........
    8000d9b0:	20020c00 0e44c944 00004400 00000000     ... D.D..D......
    8000d9c0:	000000c9 00000030 00000290 ffffc1c4     ....0...........
    8000d9d0:	000000f4 000e4400 00000000 92000000     .....D..........
    8000d9e0:	080c4408 00000000 0c000000 c9442002     .D........... D.
    8000d9f0:	0e44d244 000b4400 0000002c 000002c4     D.D..D..,.......
    8000da00:	ffffc284 0000006c 000e4400 00000000     ....l....D......
    8000da10:	92000000 080c4408 00000200 020c0000     .....D..........
    8000da20:	44c94420 000e44d2 0000002c 000002f4      D.D.D..,.......
    8000da30:	ffffc2c0 000000dc 000e4400 00000000     .........D......
    8000da40:	92000000 080c4408 00000200 020c0000     .....D..........
    8000da50:	44c94420 000e44d2 00000018 00000000      D.D.D..........
    8000da60:	4c507a03 7c010052 659b0701 1bfffffa     .zPLR..|...e....
    8000da70:	00020d1b 00000044 00000020 ffffc4e8     ....D... .......
    8000da80:	000001f8 ff897204 000e44ff 00000000     .....r...D......
	...
    8000da98:	96000000 080c4410 00ac0300 0c000000     .....D..........
    8000daa8:	c9444002 d344d244 d544d444 0e44d644     .@D.D.D.D.D.D.D.
    8000dab8:	00000000 00000010 00000000 00527a03     .............zR.
    8000dac8:	01017c01 00020d1b 00000024 00000018     .|......$.......
    8000dad8:	ffffc684 00000034 000e4400 88000000     ....4....D......
    8000dae8:	080c4404 00000000 10020c00 00000e44     .D..........D...
    8000daf8:	00000028 00000040 ffffc690 0000004c     (...@.......L...
    8000db08:	000e4400 00000000 44068900 0000080c     .D.........D....
    8000db18:	0c000000 c9442002 00000e44 00000030     ..... D.D...0...
    8000db28:	000000d0 ffffc2a0 000000c0 ff88ed04     ................
    8000db38:	000e44ff 00000000 44068900 0000080c     .D.........D....
    8000db48:	00000000 40020c00 0e44c944 000b4400     .......@D.D..D..
    8000db58:	00000024 000000a0 ffffc32c 00000028     $.......,...(...
    8000db68:	000e4400 88000000 080c4404 00000000     .D.......D......
    8000db78:	10020c00 00000e44 00000020 000000c8     ....D... .......
    8000db88:	ffffc32c 00000030 100e4400 44028844     ,...0....D..D..D
    8000db98:	0000000c 10020c00 00000e44 00000028     ........D...(...
    8000dba8:	000000ec ffffc338 00000080 000e5400     ....8........T..
    8000dbb8:	88000000 080c4404 00000200 020c0000     .....D..........
    8000dbc8:	000e4420 00000000 00000010 00000000      D..............
    8000dbd8:	00527a03 01017c01 00020d1b 00000024     .zR..|......$...
    8000dbe8:	00000018 ffffc5f0 00000060 100e4400     ........`....D..
    8000dbf8:	44028844 0000000c 020c0000 000e4410     D..D.........D..
    8000dc08:	00000b44 00000020 00000040 ffffc628     D... ...@...(...
    8000dc18:	00000108 100e4400 44028844 0000080c     .....D..D..D....
    8000dc28:	020c0000 000e4410 00000030 00000064     .....D..0...d...
    8000dc38:	ffffc70c 00000108 000e4c00 00000000     .........L......
    8000dc48:	00000000 440a9300 0200080c 00000000     .......D........
    8000dc58:	4430020c 44d244c9 000e44d3 00000030     ..0D.D.D.D..0...
    8000dc68:	00000098 ffffc7e0 000000e8 000e6000     .............`..
    8000dc78:	88000000 080c4404 00000000 00000000     .....D..........
    8000dc88:	88000000 00000204 020c0000 000e4410     .............D..
    8000dc98:	00000024 000000cc ffffc894 00000030     $...........0...
    8000dca8:	000e4800 88000000 080c4404 00000000     .H.......D......
    8000dcb8:	10020c00 00000e44 00000020 000000f4     ....D... .......
    8000dcc8:	ffffc89c 000000a8 100e4400 44028844     .........D..D..D
    8000dcd8:	0000080c 020c0000 000e4410 00000028     .........D..(...
    8000dce8:	00000118 ffffc920 000000b4 000e4400     .... ........D..
    8000dcf8:	00000000 44068900 0200080c 00000000     .......D........
    8000dd08:	4420020c 000e44c9 0000002c 00000144     .. D.D..,...D...
    8000dd18:	ffffc9a8 000000bc 000e4400 00000000     .........D......
    8000dd28:	92000000 080c4408 00000200 020c0000     .....D..........
    8000dd38:	44c94420 000e44d2 00000024 00000174      D.D.D..$...t...
    8000dd48:	ffffca34 00000034 000e4400 88000000     4...4....D......
    8000dd58:	080c4404 00000000 10020c00 00000e44     .D..........D...
    8000dd68:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000dd78:	00020d1b 00000020 00000018 ffffca2c     .... .......,...
    8000dd88:	00000020 100e4400 44028844 0000000c      ....D..D..D....
    8000dd98:	10020c00 00000e44 00000020 0000003c     ....D... ...<...
    8000dda8:	ffffca28 00000020 100e4400 44028844     (... ....D..D..D
    8000ddb8:	0000000c 10020c00 00000e44 00000024     ........D...$...
    8000ddc8:	00000060 ffffca24 0000004c 000e4400     `...$...L....D..
    8000ddd8:	88000000 080c4404 00000000 10020c00     .....D..........
    8000dde8:	00000e44 00000020 00000088 ffffca48     D... .......H...
    8000ddf8:	0000001c 100e4400 44028844 0000000c     .....D..D..D....
    8000de08:	10020c00 00000e44 00000018 00000000     ....D...........
    8000de18:	4c507a03 7c010052 ad9b0701 1bfffff6     .zPLR..|........
    8000de28:	00020d1b 00000030 00000020 ffffca24     ....0... ...$...
    8000de38:	00000058 ff860304 000e44ff 00000000     X........D......
    8000de48:	92000000 080c4408 00000000 20020c00     .....D......... 
    8000de58:	d244c944 00000e44 00000028 000000fc     D.D.D...(.......
    8000de68:	ffffca48 00000068 000e4400 88000000     H...h....D......
    8000de78:	000c4404 00000000 020c0000 000e4410     .D...........D..
    8000de88:	00000b44 00000024 00000128 ffffca84     D...$...(.......
    8000de98:	0000004c 000e5c00 88000000 080c4404     L....\.......D..
    8000dea8:	00000000 10020c00 00000e44 00000024     ........D...$...
    8000deb8:	00000150 ffffcaa8 00000050 000e6c00     P.......P....l..
    8000dec8:	88000000 080c4404 00000000 10020c00     .....D..........
    8000ded8:	00000e44 00000024 00000178 ffffcad0     D...$...x.......
    8000dee8:	0000003c 000e5800 88000000 080c4404     <....X.......D..
    8000def8:	00000000 10020c00 00000e44 00000024     ........D...$...
    8000df08:	000001a0 ffffcae4 00000030 000e4400     ........0....D..
    8000df18:	88000000 080c4404 00000000 10020c00     .....D..........
    8000df28:	00000e44 00000024 000001c8 ffffcaec     D...$...........
    8000df38:	00000034 000e4400 88000000 080c4404     4....D.......D..
    8000df48:	00000000 10020c00 00000e44 00000020     ........D... ...
    8000df58:	000001f0 ffffcaf8 0000002c 100e4400     ........,....D..
    8000df68:	44028844 0000000c 10020c00 00000e44     D..D........D...
    8000df78:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000df88:	00020d1b 00000028 00000018 ffffcaec     ....(...........
    8000df98:	00000030 000e4400 88000000 080c4404     0....D.......D..
    8000dfa8:	00000000 20020c00 00000e44 00000000     ....... D.......
    8000dfb8:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000dfc8:	00020d1b 00000020 00000018 ffffcadc     .... ...........
    8000dfd8:	00000028 100e4400 44028844 0000000c     (....D..D..D....
    8000dfe8:	10020c00 00000e44 00000020 0000003c     ....D... ...<...
    8000dff8:	ffffcae0 00000028 100e4400 44028844     ....(....D..D..D
    8000e008:	0000000c 10020c00 00000e44 00000024     ........D...$...
    8000e018:	00000060 ffffcae4 00000038 000e4400     `.......8....D..
    8000e028:	88000000 080c4404 00000000 10020c00     .....D..........
    8000e038:	00000e44 00000024 00000088 ffffcaf4     D...$...........
    8000e048:	00000068 100e4400 44028844 0000080c     h....D..D..D....
    8000e058:	0c000000 0e441002 000b4400 00000024     ......D..D..$...
    8000e068:	000000b0 ffffcb34 0000002c 000e4400     ....4...,....D..
    8000e078:	88000000 080c4404 00000000 10020c00     .....D..........
    8000e088:	00000e44 00000018 00000000 4c507a03     D............zPL
    8000e098:	7c010052 319b0701 1bfffff4 00020d1b     R..|...1........
    8000e0a8:	00000028 00000020 ffffcb1c 00000028     (... .......(...
    8000e0b8:	ff838b04 000e44ff 88000000 080c4404     .....D.......D..
    8000e0c8:	00000000 10020c00 00000e44 0000002c     ........D...,...
    8000e0d8:	00000120 ffffcb18 00000080 000e4400      ............D..
    8000e0e8:	00000000 44068900 0000080c 00000000     .......D........
    8000e0f8:	20020c00 0e44c944 000b4400 00000024     ... D.D..D..$...
    8000e108:	00000150 ffffcb68 00000030 000e4400     P...h...0....D..
    8000e118:	88000000 080c4404 00000000 10020c00     .....D..........
    8000e128:	00000e44 0000002c 00000178 ffffcb70     D...,...x...p...
    8000e138:	000000f4 000e4400 00000000 92000000     .....D..........
    8000e148:	080c4408 00000200 020c0000 44c94420     .D.......... D.D
    8000e158:	000e44d2 00000024 000001a8 ffffcc34     .D..$.......4...
    8000e168:	00000034 000e4400 88000000 080c4404     4....D.......D..
    8000e178:	00000000 10020c00 00000e44 00000020     ........D... ...
    8000e188:	000001d0 ffffcc40 0000002c 100e4400     ....@...,....D..
    8000e198:	44028844 0000000c 10020c00 00000e44     D..D........D...
    8000e1a8:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000e1b8:	00020d1b 00000020 00000018 ffffcc34     .... .......4...
    8000e1c8:	00000080 100e4400 44028844 0000080c     .....D..D..D....
    8000e1d8:	020c0000 000e4410 00000024 0000003c     .....D..$...<...
    8000e1e8:	ffffcc90 00000168 100e4400 44028844     ....h....D..D..D
    8000e1f8:	0000080c 0c000000 0e441002 000b4400     ..........D..D..
    8000e208:	00000024 00000064 ffffcdd0 000000d0     $...d...........
    8000e218:	100e4400 44028844 0000080c 0c000000     .D..D..D........
    8000e228:	0e441002 000b4400 0000002c 0000008c     ..D..D..,.......
    8000e238:	ffffce78 000000b4 000e6c00 88000000     x........l......
    8000e248:	080c4404 00000000 0c000000 0e441002     .D............D.
    8000e258:	00004400 c8000000 00000028 000000bc     .D......(.......
    8000e268:	ffffcefc 00000100 000e4400 00000000     .........D......
    8000e278:	44068900 0200080c 00000000 4420020c     ...D.......... D
    8000e288:	000e44c9 00000020 000000e8 ffffcfd0     .D.. ...........
    8000e298:	00000040 100e4400 44028844 0000000c     @....D..D..D....
    8000e2a8:	10020c00 00000e44 00000010 00000000     ....D...........
    8000e2b8:	00527a03 01017c01 00020d1b 00000024     .zR..|......$...
    8000e2c8:	00000018 ffffcfd8 0000004c 000e4400     ........L....D..
    8000e2d8:	88000000 080c4404 00000000 10020c00     .....D..........
    8000e2e8:	00000e44 0000003c 00000040 ffffcffc     D...<...@.......
    8000e2f8:	000000e8 000e4400 00000000 00000000     .....D..........
    8000e308:	00000000 440e9500 0000080c 00000000     .......D........
    8000e318:	40020c00 d244c944 d444d344 0e44d544     ...@D.D.D.D.D.D.
    8000e328:	000b4400 0000003c 00000080 ffffd0a4     .D..<...........
    8000e338:	0000033c 000e4400 00000000 00000000     <....D..........
    8000e348:	00000000 440e9500 0300080c 000000f8     .......D........
    8000e358:	40020c00 d244c944 d444d344 0e44d544     ...@D.D.D.D.D.D.
    8000e368:	00000000 00000020 000000c0 ffffd3a0     .... ...........
    8000e378:	00000020 100e4400 44028844 0000000c      ....D..D..D....
    8000e388:	10020c00 00000e44 00000024 000000e4     ....D...$.......
    8000e398:	ffffd39c 00000048 100e4400 44028844     ....H....D..D..D
    8000e3a8:	0000000c 020c0000 000e4410 00000b44     .........D..D...
    8000e3b8:	00000024 0000010c ffffd3bc 0000003c     $...........<...
    8000e3c8:	000e4400 88000000 080c4404 00000000     .D.......D......
    8000e3d8:	10020c00 00000e44 00000024 00000134     ....D...$...4...
    8000e3e8:	ffffd3d0 00000050 000e4400 88000000     ....P....D......
    8000e3f8:	080c4404 00000000 10020c00 00000e44     .D..........D...
    8000e408:	0000001c 0000015c ffffd3f8 00000088     ....\...........
    8000e418:	000e4400 88000000 080c4404 00000000     .D.......D......
    8000e428:	00000024 0000017c ffffd460 00000044     $...|...`...D...
    8000e438:	100e4400 44028844 0000000c 020c0000     .D..D..D........
    8000e448:	000e4410 00000b44 00000024 000001a4     .D..D...$.......
    8000e458:	ffffd47c 000000b4 000e4400 88000000     |........D......
    8000e468:	080c4404 00000200 020c0000 000e4410     .D...........D..
    8000e478:	00000020 000001cc ffffd508 00000038      ...........8...
    8000e488:	100e4400 44028844 0000000c 10020c00     .D..D..D........
    8000e498:	00000e44 00000024 000001f0 ffffd51c     D...$...........
    8000e4a8:	00000038 000e4400 88000000 080c4404     8....D.......D..
    8000e4b8:	00000000 10020c00 00000e44 00000028     ........D...(...
    8000e4c8:	00000218 ffffd52c 00000050 000e4400     ....,...P....D..
    8000e4d8:	88000000 000c4404 00000000 020c0000     .....D..........
    8000e4e8:	000e4410 00000b44 00000018 00000000     .D..D...........
    8000e4f8:	4c507a03 7c010052 cd9b0701 1bffffef     .zPLR..|........
    8000e508:	00020d1b 00000040 00000020 ffffd534     ....@... ...4...
    8000e518:	000000d4 ff7f2b04 000e44ff 00000000     .....+...D......
	...
    8000e530:	440e9500 0000080c 00000000 40020c00     ...D...........@
    8000e540:	d244c944 d444d344 0e44d544 000b4400     D.D.D.D.D.D..D..
    8000e550:	00000040 00000064 ffffd5c4 000000c8     @...d...........
    8000e560:	ff7f1f04 000e44ff 00000000 00000000     .....D..........
    8000e570:	00000000 440e9500 0000080c 00000000     .......D........
    8000e580:	40020c00 d244c944 d444d344 0e44d544     ...@D.D.D.D.D.D.
    8000e590:	000b4400 00000028 000002e8 ffffd648     .D..(.......H...
    8000e5a0:	00000058 000e4400 88000000 000c4404     X....D.......D..
    8000e5b0:	00000000 020c0000 000e4410 00000b44     .........D..D...
    8000e5c0:	00000028 00000314 ffffd674 00000058     (.......t...X...
    8000e5d0:	000e4400 88000000 000c4404 00000000     .D.......D......
    8000e5e0:	020c0000 000e4410 00000b44 00000038     .....D..D...8...
    8000e5f0:	00000100 ffffd6a0 0000009c ff7eae04     ..............~.
    8000e600:	000e44ff 00000000 00000000 440a9300     .D.............D
    8000e610:	0000080c 00000000 30020c00 d244c944     ...........0D.D.
    8000e620:	0e44d344 000b4400 0000002c 0000037c     D.D..D..,...|...
    8000e630:	ffffd700 00000060 000e4400 00000000     ....`....D......
    8000e640:	44068900 0000000c 00000000 4420020c     ...D.......... D
    8000e650:	000e44c9 00000b44 00000028 000003ac     .D..D...(.......
    8000e660:	ffffd730 00000060 000e4400 88000000     0...`....D......
    8000e670:	000c4404 00000000 020c0000 000e4410     .D...........D..
    8000e680:	00000b44 00000028 000003d8 ffffd764     D...(.......d...
    8000e690:	00000048 000e4400 88000000 000c4404     H....D.......D..
    8000e6a0:	00000000 020c0000 000e4410 00000b44     .........D..D...
    8000e6b0:	00000028 00000404 ffffd780 00000078     (...........x...
    8000e6c0:	000e4400 00000000 44068900 0200080c     .D.........D....
    8000e6d0:	00000000 4420020c 000e44c9 0000002c     ...... D.D..,...
    8000e6e0:	00000430 ffffd7cc 00000098 000e4400     0............D..
    8000e6f0:	00000000 44068900 0000080c 00000000     .......D........
    8000e700:	20020c00 0e44c944 000b4400 00000024     ... D.D..D..$...
    8000e710:	00000460 ffffd834 00000034 000e4400     `...4...4....D..
    8000e720:	88000000 080c4404 00000000 10020c00     .....D..........
    8000e730:	00000e44 0000002c 00000488 ffffd840     D...,.......@...
    8000e740:	00000068 000e4400 00000000 44068900     h....D.........D
    8000e750:	0000000c 00000000 4420020c 000e44c9     .......... D.D..
    8000e760:	00000b44 0000002c 000004b8 ffffd878     D...,.......x...
    8000e770:	0000005c 000e4400 00000000 44068900     \....D.........D
    8000e780:	0000000c 00000000 4420020c 000e44c9     .......... D.D..
    8000e790:	00000b44 00000034 000002a8 ffffd8a4     D...4...........
    8000e7a0:	00000154 ff7d3104 000e44ff 00000000     T....1}..D......
    8000e7b0:	92000000 080c4408 00000000 00000000     .....D..........
    8000e7c0:	4420020c 44d244c9 0b44000e 00000020     .. D.D.D..D. ...
    8000e7d0:	00000520 ffffd9c0 0000002c 100e4400      .......,....D..
    8000e7e0:	44028844 0000000c 10020c00 00000e44     D..D........D...
    8000e7f0:	0000002c 00000544 ffffd9c8 00000434     ,...D.......4...
    8000e800:	000e4400 88000000 080c4404 00000000     .D.......D......
    8000e810:	00000000 4460020c 0b44000e 00000000     ......`D..D.....
    8000e820:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000e830:	00020d1b 00000020 00000018 ffffddb8     .... ...........
    8000e840:	0000003c 100e4400 44028844 0000000c     <....D..D..D....
    8000e850:	10020c00 00000e44 0000002c 0000003c     ....D...,...<...
    8000e860:	ffffddd0 00000050 000e4400 00000000     ....P....D......
    8000e870:	44068900 0000080c 0c000000 c9442002     ...D......... D.
    8000e880:	00000e44 00000000 00000010 00000000     D...............
    8000e890:	00527a03 01017c01 00020d1b 00000020     .zR..|...... ...
    8000e8a0:	00000018 ffffdddc 00000018 100e4400     .............D..
    8000e8b0:	44028844 0000000c 10020c00 00000e44     D..D........D...
    8000e8c0:	00000024 0000003c ffffddd0 00000048     $...<.......H...
    8000e8d0:	100e4400 44028844 0000000c 020c0000     .D..D..D........
    8000e8e0:	000e4410 00000b44 00000020 00000064     .D..D... ...d...
    8000e8f0:	ffffddf0 00000034 100e4400 44028844     ....4....D..D..D
    8000e900:	0000000c 10020c00 00000e44 00000024     ........D...$...
    8000e910:	00000088 ffffde00 00000058 100e4400     ........X....D..
    8000e920:	44028844 0000000c 020c0000 000e4410     D..D.........D..
    8000e930:	00000b44 00000028 000000b0 ffffde30     D...(.......0...
    8000e940:	00000068 000e4400 00000000 44068900     h....D.........D
    8000e950:	0200080c 00000000 4420020c 000e44c9     .......... D.D..
    8000e960:	00000028 000000dc ffffde6c 00000060     (.......l...`...
    8000e970:	000e4400 00000000 44068900 0000080c     .D.........D....
    8000e980:	0c000000 c9442002 00000e44 00000028     ..... D.D...(...
    8000e990:	00000108 ffffdea0 00000060 000e4400     ........`....D..
    8000e9a0:	00000000 44068900 0000080c 0c000000     .......D........
    8000e9b0:	c9442002 00000e44 00000018 00000000     . D.D...........
    8000e9c0:	4c507a03 7c010052 059b0701 1bffffeb     .zPLR..|........
    8000e9d0:	00020d1b 00000034 00000020 ffffdeb8     ....4... .......
    8000e9e0:	000000e4 ff7b2904 000e44ff 00000000     .....){..D......
    8000e9f0:	92000000 080c4408 00000000 0c000000     .....D..........
    8000ea00:	c9442002 0e44d244 000b4400 00000010     . D.D.D..D......
    8000ea10:	00000000 00527a03 01017c01 00020d1b     .....zR..|......
    8000ea20:	00000024 00000018 ffffdf50 00000080     $.......P.......
    8000ea30:	000e6800 88000000 080c4404 00000000     .h.......D......
    8000ea40:	10020c00 00000e44 0000002c 00000040     ....D...,...@...
    8000ea50:	ffffdfa8 00000070 000e4400 00000000     ....p....D......
    8000ea60:	44068900 0000080c 00000000 20020c00     ...D........... 
    8000ea70:	0e44c944 000b4400 00000024 00000070     D.D..D..$...p...
    8000ea80:	ffffdfe8 00000098 000e7400 88000000     .........t......
    8000ea90:	080c4404 00000200 020c0000 000e4410     .D...........D..
    8000eaa0:	0000002c 00000098 ffffe058 00000070     ,.......X...p...
    8000eab0:	000e4400 00000000 44068900 0000080c     .D.........D....
    8000eac0:	00000000 20020c00 0e44c944 000b4400     ....... D.D..D..
    8000ead0:	00000028 000000c8 ffffe098 00000044     (...........D...
    8000eae0:	000e4400 00000000 44068900 0000080c     .D.........D....
    8000eaf0:	0c000000 c9442002 00000e44 00000028     ..... D.D...(...
    8000eb00:	000000f4 ffffe0b0 000000dc 000e4400     .............D..
    8000eb10:	00000000 44068900 0200080c 00000000     .......D........
    8000eb20:	4450020c 000e44c9 00000030 00000120     ..PD.D..0... ...
    8000eb30:	ffffe160 0000006c 000e4400 00000000     `...l....D......
    8000eb40:	00000000 440a9300 0000080c 0c000000     .......D........
    8000eb50:	c9443002 d344d244 00000e44 00000020     .0D.D.D.D... ...
    8000eb60:	00000154 ffffe198 00000028 100e4400     T.......(....D..
    8000eb70:	44028844 0000000c 10020c00 00000e44     D..D........D...
    8000eb80:	00000010 00000000 00527a03 01017c01     .........zR..|..
    8000eb90:	00020d1b 00000024 00000018 ffffe188     ....$...........
    8000eba0:	00000028 000e4400 88000000 080c4404     (....D.......D..
    8000ebb0:	00000000 10020c00 00000e44 00000024     ........D...$...
    8000ebc0:	00000040 ffffe188 00000028 000e4400     @.......(....D..
    8000ebd0:	88000000 080c4404 00000000 10020c00     .....D..........
    8000ebe0:	00000e44 00000024 00000068 ffffe188     D...$...h.......
    8000ebf0:	00000028 000e4400 88000000 080c4404     (....D.......D..
    8000ec00:	00000000 10020c00 00000e44 00000024     ........D...$...
    8000ec10:	00000090 ffffe188 00000028 000e4400     ........(....D..
    8000ec20:	88000000 080c4404 00000000 10020c00     .....D..........
    8000ec30:	00000e44 00000024 000000b8 ffffe188     D...$...........
    8000ec40:	00000030 000e4400 88000000 080c4404     0....D.......D..
    8000ec50:	00000000 20020c00 00000e44 00000024     ....... D...$...
    8000ec60:	000000e0 ffffe190 00000028 000e4400     ........(....D..
    8000ec70:	88000000 080c4404 00000000 10020c00     .....D..........
    8000ec80:	00000e44 00000024 00000108 ffffe190     D...$...........
    8000ec90:	00000028 000e4400 88000000 080c4404     (....D.......D..
    8000eca0:	00000000 10020c00 00000e44 00000024     ........D...$...
    8000ecb0:	00000130 ffffe190 00000028 000e4400     0.......(....D..
    8000ecc0:	88000000 080c4404 00000000 10020c00     .....D..........
    8000ecd0:	00000e44 00000028 00000158 ffffe190     D...(...X.......
    8000ece0:	00000028 000e4400 88000000 080c4404     (....D.......D..
    8000ecf0:	00000000 10020c00 00000e44 00000000     ........D.......
