
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	ad813103          	ld	sp,-1320(sp) # 8000bad8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5c4060ef          	jal	ra,800065e0 <start>

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
    800010a8:	415020ef          	jal	ra,80003cbc <_ZN5RiscV20handleSupervisorTrapEv>

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

0000000080001154 <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE>:
    slab->allocated = (bool*)((uint64)slab + sizeof(Slab));
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
        slab->allocated[i] = false;
}

void* SlabAllocator::allocateSlot(Slab *slab) {
    80001154:	ff010113          	addi	sp,sp,-16
    80001158:	00813423          	sd	s0,8(sp)
    8000115c:	01010413          	addi	s0,sp,16
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001160:	00000793          	li	a5,0
    80001164:	01853703          	ld	a4,24(a0)
    80001168:	04e7f263          	bgeu	a5,a4,800011ac <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE+0x58>
        if(!slab->allocated[i]){
    8000116c:	02853703          	ld	a4,40(a0)
    80001170:	00f70733          	add	a4,a4,a5
    80001174:	00074683          	lbu	a3,0(a4)
    80001178:	00068663          	beqz	a3,80001184 <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE+0x30>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    8000117c:	00178793          	addi	a5,a5,1
    80001180:	fe5ff06f          	j	80001164 <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE+0x10>
            slab->allocated[i] = true;
    80001184:	00100693          	li	a3,1
    80001188:	00d70023          	sb	a3,0(a4)
            slab->numOfFreeSlots--;
    8000118c:	01053703          	ld	a4,16(a0)
    80001190:	fff70713          	addi	a4,a4,-1
    80001194:	00e53823          	sd	a4,16(a0)
            return (void*)((uint64)slab->objectOffset + i*slab->objectSize);
    80001198:	03053703          	ld	a4,48(a0)
    8000119c:	02053503          	ld	a0,32(a0)
    800011a0:	02f507b3          	mul	a5,a0,a5
    800011a4:	00f70533          	add	a0,a4,a5
    800011a8:	0080006f          	j	800011b0 <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE+0x5c>
        }
    }
    return nullptr;
    800011ac:	00000513          	li	a0,0
}
    800011b0:	00813403          	ld	s0,8(sp)
    800011b4:	01010113          	addi	sp,sp,16
    800011b8:	00008067          	ret

00000000800011bc <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

SlabAllocator::Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800011bc:	ff010113          	addi	sp,sp,-16
    800011c0:	00813423          	sd	s0,8(sp)
    800011c4:	01010413          	addi	s0,sp,16
    return nullptr;
}
    800011c8:	00000513          	li	a0,0
    800011cc:	00813403          	ld	s0,8(sp)
    800011d0:	01010113          	addi	sp,sp,16
    800011d4:	00008067          	ret

00000000800011d8 <_ZN13SlabAllocator9printSlabEPNS_4SlabE>:

void SlabAllocator::printSlab(Slab *slab) {
    800011d8:	fe010113          	addi	sp,sp,-32
    800011dc:	00113c23          	sd	ra,24(sp)
    800011e0:	00813823          	sd	s0,16(sp)
    800011e4:	00913423          	sd	s1,8(sp)
    800011e8:	01213023          	sd	s2,0(sp)
    800011ec:	02010413          	addi	s0,sp,32
    800011f0:	00050913          	mv	s2,a0
    ConsoleUtil::print("Slab address:", (uint64)slab, "\n");
    800011f4:	00008617          	auipc	a2,0x8
    800011f8:	fac60613          	addi	a2,a2,-84 # 800091a0 <CONSOLE_STATUS+0x190>
    800011fc:	0005059b          	sext.w	a1,a0
    80001200:	00008517          	auipc	a0,0x8
    80001204:	e2050513          	addi	a0,a0,-480 # 80009020 <CONSOLE_STATUS+0x10>
    80001208:	00003097          	auipc	ra,0x3
    8000120c:	4a4080e7          	jalr	1188(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Number of slots:", (uint64)slab->totalNumOfSlots, "\n");
    80001210:	00008617          	auipc	a2,0x8
    80001214:	f9060613          	addi	a2,a2,-112 # 800091a0 <CONSOLE_STATUS+0x190>
    80001218:	01892583          	lw	a1,24(s2)
    8000121c:	00008517          	auipc	a0,0x8
    80001220:	e1450513          	addi	a0,a0,-492 # 80009030 <CONSOLE_STATUS+0x20>
    80001224:	00003097          	auipc	ra,0x3
    80001228:	488080e7          	jalr	1160(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab object size:", (uint64)sizeof(Slab), "\n");
    8000122c:	00008617          	auipc	a2,0x8
    80001230:	f7460613          	addi	a2,a2,-140 # 800091a0 <CONSOLE_STATUS+0x190>
    80001234:	03800593          	li	a1,56
    80001238:	00008517          	auipc	a0,0x8
    8000123c:	e1050513          	addi	a0,a0,-496 # 80009048 <CONSOLE_STATUS+0x38>
    80001240:	00003097          	auipc	ra,0x3
    80001244:	46c080e7          	jalr	1132(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Object offset:", (uint64)slab->objectOffset, "\n");
    80001248:	00008617          	auipc	a2,0x8
    8000124c:	f5860613          	addi	a2,a2,-168 # 800091a0 <CONSOLE_STATUS+0x190>
    80001250:	03092583          	lw	a1,48(s2)
    80001254:	00008517          	auipc	a0,0x8
    80001258:	e0c50513          	addi	a0,a0,-500 # 80009060 <CONSOLE_STATUS+0x50>
    8000125c:	00003097          	auipc	ra,0x3
    80001260:	450080e7          	jalr	1104(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab allocated array address:", (uint64)slab->allocated, "\n");
    80001264:	00008617          	auipc	a2,0x8
    80001268:	f3c60613          	addi	a2,a2,-196 # 800091a0 <CONSOLE_STATUS+0x190>
    8000126c:	02892583          	lw	a1,40(s2)
    80001270:	00008517          	auipc	a0,0x8
    80001274:	e0050513          	addi	a0,a0,-512 # 80009070 <CONSOLE_STATUS+0x60>
    80001278:	00003097          	auipc	ra,0x3
    8000127c:	434080e7          	jalr	1076(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::printString("Allocated status array:\n");
    80001280:	00008517          	auipc	a0,0x8
    80001284:	e1050513          	addi	a0,a0,-496 # 80009090 <CONSOLE_STATUS+0x80>
    80001288:	00003097          	auipc	ra,0x3
    8000128c:	304080e7          	jalr	772(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    80001290:	00000493          	li	s1,0
    80001294:	01893783          	ld	a5,24(s2)
    80001298:	02f4f863          	bgeu	s1,a5,800012c8 <_ZN13SlabAllocator9printSlabEPNS_4SlabE+0xf0>
        ConsoleUtil::print("", (uint8)slab->allocated[i], " ");
    8000129c:	02893783          	ld	a5,40(s2)
    800012a0:	009787b3          	add	a5,a5,s1
    800012a4:	00008617          	auipc	a2,0x8
    800012a8:	e1c60613          	addi	a2,a2,-484 # 800090c0 <CONSOLE_STATUS+0xb0>
    800012ac:	0007c583          	lbu	a1,0(a5)
    800012b0:	00008517          	auipc	a0,0x8
    800012b4:	f3050513          	addi	a0,a0,-208 # 800091e0 <CONSOLE_STATUS+0x1d0>
    800012b8:	00003097          	auipc	ra,0x3
    800012bc:	3f4080e7          	jalr	1012(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    800012c0:	00148493          	addi	s1,s1,1
    800012c4:	fd1ff06f          	j	80001294 <_ZN13SlabAllocator9printSlabEPNS_4SlabE+0xbc>
    }
    ConsoleUtil::printString("\n");
    800012c8:	00008517          	auipc	a0,0x8
    800012cc:	ed850513          	addi	a0,a0,-296 # 800091a0 <CONSOLE_STATUS+0x190>
    800012d0:	00003097          	auipc	ra,0x3
    800012d4:	2bc080e7          	jalr	700(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
}
    800012d8:	01813083          	ld	ra,24(sp)
    800012dc:	01013403          	ld	s0,16(sp)
    800012e0:	00813483          	ld	s1,8(sp)
    800012e4:	00013903          	ld	s2,0(sp)
    800012e8:	02010113          	addi	sp,sp,32
    800012ec:	00008067          	ret

00000000800012f0 <_ZN13SlabAllocator10printCacheEPNS_5CacheE>:

void SlabAllocator::printCache(Cache *cache) {
    800012f0:	fe010113          	addi	sp,sp,-32
    800012f4:	00113c23          	sd	ra,24(sp)
    800012f8:	00813823          	sd	s0,16(sp)
    800012fc:	00913423          	sd	s1,8(sp)
    80001300:	01213023          	sd	s2,0(sp)
    80001304:	02010413          	addi	s0,sp,32
    80001308:	00050913          	mv	s2,a0
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    8000130c:	00008617          	auipc	a2,0x8
    80001310:	e9460613          	addi	a2,a2,-364 # 800091a0 <CONSOLE_STATUS+0x190>
    80001314:	0000a797          	auipc	a5,0xa
    80001318:	7947b783          	ld	a5,1940(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000131c:	0007a583          	lw	a1,0(a5)
    80001320:	00008517          	auipc	a0,0x8
    80001324:	d9050513          	addi	a0,a0,-624 # 800090b0 <CONSOLE_STATUS+0xa0>
    80001328:	00003097          	auipc	ra,0x3
    8000132c:	384080e7          	jalr	900(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001330:	00008617          	auipc	a2,0x8
    80001334:	e7060613          	addi	a2,a2,-400 # 800091a0 <CONSOLE_STATUS+0x190>
    80001338:	0009059b          	sext.w	a1,s2
    8000133c:	00008517          	auipc	a0,0x8
    80001340:	d8c50513          	addi	a0,a0,-628 # 800090c8 <CONSOLE_STATUS+0xb8>
    80001344:	00003097          	auipc	ra,0x3
    80001348:	368080e7          	jalr	872(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    8000134c:	00008617          	auipc	a2,0x8
    80001350:	e5460613          	addi	a2,a2,-428 # 800091a0 <CONSOLE_STATUS+0x190>
    80001354:	06092583          	lw	a1,96(s2)
    80001358:	00008517          	auipc	a0,0x8
    8000135c:	d8050513          	addi	a0,a0,-640 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001360:	00003097          	auipc	ra,0x3
    80001364:	34c080e7          	jalr	844(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    80001368:	06093483          	ld	s1,96(s2)
    while(iter){
    8000136c:	02048463          	beqz	s1,80001394 <_ZN13SlabAllocator10printCacheEPNS_5CacheE+0xa4>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001370:	00008617          	auipc	a2,0x8
    80001374:	d5060613          	addi	a2,a2,-688 # 800090c0 <CONSOLE_STATUS+0xb0>
    80001378:	0004859b          	sext.w	a1,s1
    8000137c:	00008517          	auipc	a0,0x8
    80001380:	e6450513          	addi	a0,a0,-412 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001384:	00003097          	auipc	ra,0x3
    80001388:	328080e7          	jalr	808(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    8000138c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001390:	fddff06f          	j	8000136c <_ZN13SlabAllocator10printCacheEPNS_5CacheE+0x7c>
    }
    ConsoleUtil::printString("\n");
    80001394:	00008517          	auipc	a0,0x8
    80001398:	e0c50513          	addi	a0,a0,-500 # 800091a0 <CONSOLE_STATUS+0x190>
    8000139c:	00003097          	auipc	ra,0x3
    800013a0:	1f0080e7          	jalr	496(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    800013a4:	00008617          	auipc	a2,0x8
    800013a8:	dfc60613          	addi	a2,a2,-516 # 800091a0 <CONSOLE_STATUS+0x190>
    800013ac:	06892583          	lw	a1,104(s2)
    800013b0:	00008517          	auipc	a0,0x8
    800013b4:	d3850513          	addi	a0,a0,-712 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013b8:	00003097          	auipc	ra,0x3
    800013bc:	2f4080e7          	jalr	756(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    800013c0:	06893483          	ld	s1,104(s2)
    while(iter){
    800013c4:	02048463          	beqz	s1,800013ec <_ZN13SlabAllocator10printCacheEPNS_5CacheE+0xfc>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013c8:	00008617          	auipc	a2,0x8
    800013cc:	cf860613          	addi	a2,a2,-776 # 800090c0 <CONSOLE_STATUS+0xb0>
    800013d0:	0004859b          	sext.w	a1,s1
    800013d4:	00008517          	auipc	a0,0x8
    800013d8:	e0c50513          	addi	a0,a0,-500 # 800091e0 <CONSOLE_STATUS+0x1d0>
    800013dc:	00003097          	auipc	ra,0x3
    800013e0:	2d0080e7          	jalr	720(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800013e4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013e8:	fddff06f          	j	800013c4 <_ZN13SlabAllocator10printCacheEPNS_5CacheE+0xd4>
    }
    ConsoleUtil::printString("\n");
    800013ec:	00008517          	auipc	a0,0x8
    800013f0:	db450513          	addi	a0,a0,-588 # 800091a0 <CONSOLE_STATUS+0x190>
    800013f4:	00003097          	auipc	ra,0x3
    800013f8:	198080e7          	jalr	408(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    800013fc:	00008617          	auipc	a2,0x8
    80001400:	da460613          	addi	a2,a2,-604 # 800091a0 <CONSOLE_STATUS+0x190>
    80001404:	07092583          	lw	a1,112(s2)
    80001408:	00008517          	auipc	a0,0x8
    8000140c:	cf050513          	addi	a0,a0,-784 # 800090f8 <CONSOLE_STATUS+0xe8>
    80001410:	00003097          	auipc	ra,0x3
    80001414:	29c080e7          	jalr	668(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    80001418:	07093483          	ld	s1,112(s2)
    while(iter){
    8000141c:	02048463          	beqz	s1,80001444 <_ZN13SlabAllocator10printCacheEPNS_5CacheE+0x154>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001420:	00008617          	auipc	a2,0x8
    80001424:	ca060613          	addi	a2,a2,-864 # 800090c0 <CONSOLE_STATUS+0xb0>
    80001428:	0004859b          	sext.w	a1,s1
    8000142c:	00008517          	auipc	a0,0x8
    80001430:	db450513          	addi	a0,a0,-588 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001434:	00003097          	auipc	ra,0x3
    80001438:	278080e7          	jalr	632(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    8000143c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001440:	fddff06f          	j	8000141c <_ZN13SlabAllocator10printCacheEPNS_5CacheE+0x12c>
    }
    ConsoleUtil::printString("\n");
    80001444:	00008517          	auipc	a0,0x8
    80001448:	d5c50513          	addi	a0,a0,-676 # 800091a0 <CONSOLE_STATUS+0x190>
    8000144c:	00003097          	auipc	ra,0x3
    80001450:	140080e7          	jalr	320(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    80001454:	00008617          	auipc	a2,0x8
    80001458:	d4c60613          	addi	a2,a2,-692 # 800091a0 <CONSOLE_STATUS+0x190>
    8000145c:	04092583          	lw	a1,64(s2)
    80001460:	00008517          	auipc	a0,0x8
    80001464:	ca850513          	addi	a0,a0,-856 # 80009108 <CONSOLE_STATUS+0xf8>
    80001468:	00003097          	auipc	ra,0x3
    8000146c:	244080e7          	jalr	580(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
}
    80001470:	01813083          	ld	ra,24(sp)
    80001474:	01013403          	ld	s0,16(sp)
    80001478:	00813483          	ld	s1,8(sp)
    8000147c:	00013903          	ld	s2,0(sp)
    80001480:	02010113          	addi	sp,sp,32
    80001484:	00008067          	ret

0000000080001488 <_ZN13SlabAllocator14insertIntoListEPPNS_4SlabES1_>:

void SlabAllocator::insertIntoList(Slab **head, Slab *slab) {
    80001488:	ff010113          	addi	sp,sp,-16
    8000148c:	00813423          	sd	s0,8(sp)
    80001490:	01010413          	addi	s0,sp,16
    slab->next = *head;
    80001494:	00053783          	ld	a5,0(a0)
    80001498:	00f5b423          	sd	a5,8(a1)
    if(*head)
    8000149c:	00078463          	beqz	a5,800014a4 <_ZN13SlabAllocator14insertIntoListEPPNS_4SlabES1_+0x1c>
        (*head)->prev = slab;
    800014a0:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800014a4:	0005b023          	sd	zero,0(a1)
    *head = slab;
    800014a8:	00b53023          	sd	a1,0(a0)
    800014ac:	00813403          	ld	s0,8(sp)
    800014b0:	01010113          	addi	sp,sp,16
    800014b4:	00008067          	ret

00000000800014b8 <_ZN13SlabAllocator12allocateSlabEPNS_5CacheE>:
void SlabAllocator::allocateSlab(Cache *cache) {
    800014b8:	fe010113          	addi	sp,sp,-32
    800014bc:	00113c23          	sd	ra,24(sp)
    800014c0:	00813823          	sd	s0,16(sp)
    800014c4:	00913423          	sd	s1,8(sp)
    800014c8:	01213023          	sd	s2,0(sp)
    800014cc:	02010413          	addi	s0,sp,32
    800014d0:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    800014d4:	04853503          	ld	a0,72(a0)
    800014d8:	00001097          	auipc	ra,0x1
    800014dc:	a00080e7          	jalr	-1536(ra) # 80001ed8 <_ZN5Buddy5allocEm>
    800014e0:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(&cache->emptyHead, slab);
    800014e4:	00050593          	mv	a1,a0
    800014e8:	06090513          	addi	a0,s2,96
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	f9c080e7          	jalr	-100(ra) # 80001488 <_ZN13SlabAllocator14insertIntoListEPPNS_4SlabES1_>
    slab->objectSize = cache->objectSize;
    800014f4:	04093703          	ld	a4,64(s2)
    800014f8:	02e4b023          	sd	a4,32(s1)
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    800014fc:	04893783          	ld	a5,72(s2)
    80001500:	00c79793          	slli	a5,a5,0xc
    80001504:	fc878793          	addi	a5,a5,-56
    80001508:	02e7d7b3          	divu	a5,a5,a4
    8000150c:	00f4b823          	sd	a5,16(s1)
    80001510:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + (slab->totalNumOfSlots>>3) + 1);
    80001514:	0037d793          	srli	a5,a5,0x3
    80001518:	009787b3          	add	a5,a5,s1
    8000151c:	03978793          	addi	a5,a5,57
    80001520:	02f4b823          	sd	a5,48(s1)
    slab->allocated = (bool*)((uint64)slab + sizeof(Slab));
    80001524:	03848793          	addi	a5,s1,56
    80001528:	02f4b423          	sd	a5,40(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    8000152c:	00000793          	li	a5,0
    80001530:	0184b703          	ld	a4,24(s1)
    80001534:	00e7fc63          	bgeu	a5,a4,8000154c <_ZN13SlabAllocator12allocateSlabEPNS_5CacheE+0x94>
        slab->allocated[i] = false;
    80001538:	0284b703          	ld	a4,40(s1)
    8000153c:	00f70733          	add	a4,a4,a5
    80001540:	00070023          	sb	zero,0(a4)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001544:	00178793          	addi	a5,a5,1
    80001548:	fe9ff06f          	j	80001530 <_ZN13SlabAllocator12allocateSlabEPNS_5CacheE+0x78>
}
    8000154c:	01813083          	ld	ra,24(sp)
    80001550:	01013403          	ld	s0,16(sp)
    80001554:	00813483          	ld	s1,8(sp)
    80001558:	00013903          	ld	s2,0(sp)
    8000155c:	02010113          	addi	sp,sp,32
    80001560:	00008067          	ret

0000000080001564 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80001564:	fe010113          	addi	sp,sp,-32
    80001568:	00113c23          	sd	ra,24(sp)
    8000156c:	00813823          	sd	s0,16(sp)
    80001570:	00913423          	sd	s1,8(sp)
    80001574:	01213023          	sd	s2,0(sp)
    80001578:	02010413          	addi	s0,sp,32
    8000157c:	00050913          	mv	s2,a0
    80001580:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    80001584:	00000097          	auipc	ra,0x0
    80001588:	59c080e7          	jalr	1436(ra) # 80001b20 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    8000158c:	0000a797          	auipc	a5,0xa
    80001590:	60478793          	addi	a5,a5,1540 # 8000bb90 <_ZN13SlabAllocator9startAddrE>
    80001594:	0127b023          	sd	s2,0(a5)
    blocksResponsibleFor = blockNum;
    80001598:	0097b423          	sd	s1,8(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    8000159c:	0000a717          	auipc	a4,0xa
    800015a0:	50c73703          	ld	a4,1292(a4) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800015a4:	00073503          	ld	a0,0(a4)
    800015a8:	00c55513          	srli	a0,a0,0xc
    800015ac:	00150513          	addi	a0,a0,1
    800015b0:	00c51513          	slli	a0,a0,0xc
    800015b4:	00a7b823          	sd	a0,16(a5)
    cache->ctor = nullptr;
    800015b8:	04053823          	sd	zero,80(a0)
    cache->dtor = nullptr;
    800015bc:	04053c23          	sd	zero,88(a0)
    cache->emptyHead = nullptr;
    800015c0:	06053023          	sd	zero,96(a0)
    cache->partialHead = nullptr;
    800015c4:	06053423          	sd	zero,104(a0)
    cache->fullHead = nullptr;
    800015c8:	06053823          	sd	zero,112(a0)
    cache->objectSize = sizeof(Cache);
    800015cc:	07800793          	li	a5,120
    800015d0:	04f53023          	sd	a5,64(a0)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    800015d4:	00200793          	li	a5,2
    800015d8:	04f53423          	sd	a5,72(a0)
    allocateSlab(cache);
    800015dc:	00000097          	auipc	ra,0x0
    800015e0:	edc080e7          	jalr	-292(ra) # 800014b8 <_ZN13SlabAllocator12allocateSlabEPNS_5CacheE>
}
    800015e4:	01813083          	ld	ra,24(sp)
    800015e8:	01013403          	ld	s0,16(sp)
    800015ec:	00813483          	ld	s1,8(sp)
    800015f0:	00013903          	ld	s2,0(sp)
    800015f4:	02010113          	addi	sp,sp,32
    800015f8:	00008067          	ret

00000000800015fc <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    800015fc:	ff010113          	addi	sp,sp,-16
    80001600:	00813423          	sd	s0,8(sp)
    80001604:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001608:	03f50513          	addi	a0,a0,63
    8000160c:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001610:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001614:	00100513          	li	a0,1
    asm("ecall");
    80001618:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    8000161c:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001620:	00813403          	ld	s0,8(sp)
    80001624:	01010113          	addi	sp,sp,16
    80001628:	00008067          	ret

000000008000162c <_Z8mem_freePv>:

int mem_free(void *ptr){
    8000162c:	ff010113          	addi	sp,sp,-16
    80001630:	00813423          	sd	s0,8(sp)
    80001634:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001638:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    8000163c:	00200513          	li	a0,2
    asm("ecall");
    80001640:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001644:	00050513          	mv	a0,a0
    return status;
}
    80001648:	0005051b          	sext.w	a0,a0
    8000164c:	00813403          	ld	s0,8(sp)
    80001650:	01010113          	addi	sp,sp,16
    80001654:	00008067          	ret

0000000080001658 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001658:	fd010113          	addi	sp,sp,-48
    8000165c:	02113423          	sd	ra,40(sp)
    80001660:	02813023          	sd	s0,32(sp)
    80001664:	00913c23          	sd	s1,24(sp)
    80001668:	01213823          	sd	s2,16(sp)
    8000166c:	01313423          	sd	s3,8(sp)
    80001670:	03010413          	addi	s0,sp,48
    80001674:	00050913          	mv	s2,a0
    80001678:	00058493          	mv	s1,a1
    8000167c:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001680:	04058663          	beqz	a1,800016cc <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001684:	00001537          	lui	a0,0x1
    80001688:	00000097          	auipc	ra,0x0
    8000168c:	f74080e7          	jalr	-140(ra) # 800015fc <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001690:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001694:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001698:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000169c:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    800016a0:	01100513          	li	a0,17

    asm("ecall");
    800016a4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800016a8:	00050513          	mv	a0,a0

    return status;
}
    800016ac:	0005051b          	sext.w	a0,a0
    800016b0:	02813083          	ld	ra,40(sp)
    800016b4:	02013403          	ld	s0,32(sp)
    800016b8:	01813483          	ld	s1,24(sp)
    800016bc:	01013903          	ld	s2,16(sp)
    800016c0:	00813983          	ld	s3,8(sp)
    800016c4:	03010113          	addi	sp,sp,48
    800016c8:	00008067          	ret
    uint64 istack = 0;
    800016cc:	00000513          	li	a0,0
    800016d0:	fc1ff06f          	j	80001690 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

00000000800016d4 <_Z11thread_exitv>:

int thread_exit(){
    800016d4:	ff010113          	addi	sp,sp,-16
    800016d8:	00813423          	sd	s0,8(sp)
    800016dc:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    800016e0:	01200513          	li	a0,18

    asm("ecall");
    800016e4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800016e8:	00050513          	mv	a0,a0

    return status;
}
    800016ec:	0005051b          	sext.w	a0,a0
    800016f0:	00813403          	ld	s0,8(sp)
    800016f4:	01010113          	addi	sp,sp,16
    800016f8:	00008067          	ret

00000000800016fc <_Z15thread_dispatchv>:

void thread_dispatch(){
    800016fc:	ff010113          	addi	sp,sp,-16
    80001700:	00813423          	sd	s0,8(sp)
    80001704:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001708:	01300513          	li	a0,19

    asm("ecall");
    8000170c:	00000073          	ecall
}
    80001710:	00813403          	ld	s0,8(sp)
    80001714:	01010113          	addi	sp,sp,16
    80001718:	00008067          	ret

000000008000171c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    8000171c:	fd010113          	addi	sp,sp,-48
    80001720:	02113423          	sd	ra,40(sp)
    80001724:	02813023          	sd	s0,32(sp)
    80001728:	00913c23          	sd	s1,24(sp)
    8000172c:	01213823          	sd	s2,16(sp)
    80001730:	01313423          	sd	s3,8(sp)
    80001734:	03010413          	addi	s0,sp,48
    80001738:	00050913          	mv	s2,a0
    8000173c:	00058493          	mv	s1,a1
    80001740:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001744:	04058663          	beqz	a1,80001790 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001748:	00001537          	lui	a0,0x1
    8000174c:	00000097          	auipc	ra,0x0
    80001750:	eb0080e7          	jalr	-336(ra) # 800015fc <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001754:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001758:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    8000175c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001760:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    80001764:	01400513          	li	a0,20

    asm("ecall");
    80001768:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000176c:	00050513          	mv	a0,a0

    return status;
}
    80001770:	0005051b          	sext.w	a0,a0
    80001774:	02813083          	ld	ra,40(sp)
    80001778:	02013403          	ld	s0,32(sp)
    8000177c:	01813483          	ld	s1,24(sp)
    80001780:	01013903          	ld	s2,16(sp)
    80001784:	00813983          	ld	s3,8(sp)
    80001788:	03010113          	addi	sp,sp,48
    8000178c:	00008067          	ret
    uint64 istack = 0;
    80001790:	00000513          	li	a0,0
    80001794:	fc1ff06f          	j	80001754 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

0000000080001798 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001798:	ff010113          	addi	sp,sp,-16
    8000179c:	00813423          	sd	s0,8(sp)
    800017a0:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800017a4:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    800017a8:	01500513          	li	a0,21

    asm("ecall");
    800017ac:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800017b0:	00050513          	mv	a0,a0

    return status;
}
    800017b4:	0005051b          	sext.w	a0,a0
    800017b8:	00813403          	ld	s0,8(sp)
    800017bc:	01010113          	addi	sp,sp,16
    800017c0:	00008067          	ret

00000000800017c4 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    800017c4:	ff010113          	addi	sp,sp,-16
    800017c8:	00813423          	sd	s0,8(sp)
    800017cc:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    800017d0:	02059593          	slli	a1,a1,0x20
    800017d4:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    800017d8:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800017dc:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    800017e0:	02100513          	li	a0,33


    asm("ecall");
    800017e4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800017e8:	00050513          	mv	a0,a0

    return status;

}
    800017ec:	0005051b          	sext.w	a0,a0
    800017f0:	00813403          	ld	s0,8(sp)
    800017f4:	01010113          	addi	sp,sp,16
    800017f8:	00008067          	ret

00000000800017fc <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    800017fc:	ff010113          	addi	sp,sp,-16
    80001800:	00813423          	sd	s0,8(sp)
    80001804:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001808:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    8000180c:	02200513          	li	a0,34


    asm("ecall");
    80001810:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001814:	00050513          	mv	a0,a0

    return status;
}
    80001818:	0005051b          	sext.w	a0,a0
    8000181c:	00813403          	ld	s0,8(sp)
    80001820:	01010113          	addi	sp,sp,16
    80001824:	00008067          	ret

0000000080001828 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001828:	ff010113          	addi	sp,sp,-16
    8000182c:	00813423          	sd	s0,8(sp)
    80001830:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001834:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001838:	02300513          	li	a0,35


    asm("ecall");
    8000183c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001840:	00050513          	mv	a0,a0

    return status;
}
    80001844:	0005051b          	sext.w	a0,a0
    80001848:	00813403          	ld	s0,8(sp)
    8000184c:	01010113          	addi	sp,sp,16
    80001850:	00008067          	ret

0000000080001854 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80001854:	ff010113          	addi	sp,sp,-16
    80001858:	00813423          	sd	s0,8(sp)
    8000185c:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001860:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80001864:	02400513          	li	a0,36


    asm("ecall");
    80001868:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000186c:	00050513          	mv	a0,a0

    return status;
}
    80001870:	0005051b          	sext.w	a0,a0
    80001874:	00813403          	ld	s0,8(sp)
    80001878:	01010113          	addi	sp,sp,16
    8000187c:	00008067          	ret

0000000080001880 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00813423          	sd	s0,8(sp)
    80001888:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    8000188c:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80001890:	03100513          	li	a0,49


    asm("ecall");
    80001894:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001898:	00050513          	mv	a0,a0

    return status;
}
    8000189c:	0005051b          	sext.w	a0,a0
    800018a0:	00813403          	ld	s0,8(sp)
    800018a4:	01010113          	addi	sp,sp,16
    800018a8:	00008067          	ret

00000000800018ac <_Z4getcv>:

char getc(){
    800018ac:	ff010113          	addi	sp,sp,-16
    800018b0:	00813423          	sd	s0,8(sp)
    800018b4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    800018b8:	04100513          	li	a0,65

    asm("ecall");
    800018bc:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    800018c0:	00050513          	mv	a0,a0

    return c;
}
    800018c4:	0ff57513          	andi	a0,a0,255
    800018c8:	00813403          	ld	s0,8(sp)
    800018cc:	01010113          	addi	sp,sp,16
    800018d0:	00008067          	ret

00000000800018d4 <_Z4putcc>:

void putc(char c){
    800018d4:	ff010113          	addi	sp,sp,-16
    800018d8:	00813423          	sd	s0,8(sp)
    800018dc:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    800018e0:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    800018e4:	04200513          	li	a0,66

    asm("ecall");
    800018e8:	00000073          	ecall
}
    800018ec:	00813403          	ld	s0,8(sp)
    800018f0:	01010113          	addi	sp,sp,16
    800018f4:	00008067          	ret

00000000800018f8 <_Z4forkv>:


int fork(){
    800018f8:	ff010113          	addi	sp,sp,-16
    800018fc:	00813423          	sd	s0,8(sp)
    80001900:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    80001904:	06100513          	li	a0,97

    asm("ecall");
    80001908:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000190c:	00050513          	mv	a0,a0

    return status;
}
    80001910:	0005051b          	sext.w	a0,a0
    80001914:	00813403          	ld	s0,8(sp)
    80001918:	01010113          	addi	sp,sp,16
    8000191c:	00008067          	ret

0000000080001920 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80001920:	ff010113          	addi	sp,sp,-16
    80001924:	00113423          	sd	ra,8(sp)
    80001928:	00813023          	sd	s0,0(sp)
    8000192c:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80001930:	00000097          	auipc	ra,0x0
    80001934:	ecc080e7          	jalr	-308(ra) # 800017fc <_Z9sem_closeP10_semaphore>
}
    80001938:	00813083          	ld	ra,8(sp)
    8000193c:	00013403          	ld	s0,0(sp)
    80001940:	01010113          	addi	sp,sp,16
    80001944:	00008067          	ret

0000000080001948 <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    80001948:	ff010113          	addi	sp,sp,-16
    8000194c:	00113423          	sd	ra,8(sp)
    80001950:	00813023          	sd	s0,0(sp)
    80001954:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    80001958:	00001097          	auipc	ra,0x1
    8000195c:	ee4080e7          	jalr	-284(ra) # 8000283c <_ZN3TCB11thread_freeEPv>
    80001960:	00813083          	ld	ra,8(sp)
    80001964:	00013403          	ld	s0,0(sp)
    80001968:	01010113          	addi	sp,sp,16
    8000196c:	00008067          	ret

0000000080001970 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80001970:	ff010113          	addi	sp,sp,-16
    80001974:	00113423          	sd	ra,8(sp)
    80001978:	00813023          	sd	s0,0(sp)
    8000197c:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80001980:	00004097          	auipc	ra,0x4
    80001984:	3bc080e7          	jalr	956(ra) # 80005d3c <_Z8userMainv>
    80001988:	00813083          	ld	ra,8(sp)
    8000198c:	00013403          	ld	s0,0(sp)
    80001990:	01010113          	addi	sp,sp,16
    80001994:	00008067          	ret

0000000080001998 <_ZN6SystemC1Ev>:
    if (!initialized) {
    80001998:	0000a797          	auipc	a5,0xa
    8000199c:	2787c783          	lbu	a5,632(a5) # 8000bc10 <_ZN6System11initializedE>
    800019a0:	00078463          	beqz	a5,800019a8 <_ZN6SystemC1Ev+0x10>
    800019a4:	00008067          	ret
System::System() {
    800019a8:	fc010113          	addi	sp,sp,-64
    800019ac:	02113c23          	sd	ra,56(sp)
    800019b0:	02813823          	sd	s0,48(sp)
    800019b4:	02913423          	sd	s1,40(sp)
    800019b8:	03213023          	sd	s2,32(sp)
    800019bc:	01313c23          	sd	s3,24(sp)
    800019c0:	04010413          	addi	s0,sp,64
        initialized = true;
    800019c4:	00100793          	li	a5,1
    800019c8:	0000a717          	auipc	a4,0xa
    800019cc:	24f70423          	sb	a5,584(a4) # 8000bc10 <_ZN6System11initializedE>
        RiscV::initialize();
    800019d0:	00002097          	auipc	ra,0x2
    800019d4:	808080e7          	jalr	-2040(ra) # 800031d8 <_ZN5RiscV10initializeEv>
        SlabAllocator::Cache *cache = SlabAllocator::cache;
    800019d8:	0000a497          	auipc	s1,0xa
    800019dc:	1084b483          	ld	s1,264(s1) # 8000bae0 <_GLOBAL_OFFSET_TABLE_+0x50>
    800019e0:	0004b903          	ld	s2,0(s1)
        SlabAllocator::printCache(cache);
    800019e4:	00090513          	mv	a0,s2
    800019e8:	00000097          	auipc	ra,0x0
    800019ec:	908080e7          	jalr	-1784(ra) # 800012f0 <_ZN13SlabAllocator10printCacheEPNS_5CacheE>
        SlabAllocator::Slab *slab = cache->emptyHead;
    800019f0:	06093983          	ld	s3,96(s2)
        SlabAllocator::printSlab(SlabAllocator::cache->emptyHead);
    800019f4:	0004b783          	ld	a5,0(s1)
    800019f8:	0607b503          	ld	a0,96(a5)
    800019fc:	fffff097          	auipc	ra,0xfffff
    80001a00:	7dc080e7          	jalr	2012(ra) # 800011d8 <_ZN13SlabAllocator9printSlabEPNS_4SlabE>
        void* all1 = SlabAllocator::allocateSlot(slab);
    80001a04:	00098513          	mv	a0,s3
    80001a08:	fffff097          	auipc	ra,0xfffff
    80001a0c:	74c080e7          	jalr	1868(ra) # 80001154 <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE>
    80001a10:	00050913          	mv	s2,a0
        void* all2 = SlabAllocator::allocateSlot(slab);
    80001a14:	00098513          	mv	a0,s3
    80001a18:	fffff097          	auipc	ra,0xfffff
    80001a1c:	73c080e7          	jalr	1852(ra) # 80001154 <_ZN13SlabAllocator12allocateSlotEPNS_4SlabE>
    80001a20:	00050493          	mv	s1,a0
        SlabAllocator::printSlab(slab);
    80001a24:	00098513          	mv	a0,s3
    80001a28:	fffff097          	auipc	ra,0xfffff
    80001a2c:	7b0080e7          	jalr	1968(ra) # 800011d8 <_ZN13SlabAllocator9printSlabEPNS_4SlabE>
        ConsoleUtil::print("",(uint64)all1,"\n");
    80001a30:	00007617          	auipc	a2,0x7
    80001a34:	77060613          	addi	a2,a2,1904 # 800091a0 <CONSOLE_STATUS+0x190>
    80001a38:	0009059b          	sext.w	a1,s2
    80001a3c:	00007517          	auipc	a0,0x7
    80001a40:	7a450513          	addi	a0,a0,1956 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001a44:	00003097          	auipc	ra,0x3
    80001a48:	c68080e7          	jalr	-920(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("",(uint64)all2,"\n");
    80001a4c:	00007617          	auipc	a2,0x7
    80001a50:	75460613          	addi	a2,a2,1876 # 800091a0 <CONSOLE_STATUS+0x190>
    80001a54:	0004859b          	sext.w	a1,s1
    80001a58:	00007517          	auipc	a0,0x7
    80001a5c:	78850513          	addi	a0,a0,1928 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001a60:	00003097          	auipc	ra,0x3
    80001a64:	c4c080e7          	jalr	-948(ra) # 800046ac <_ZN11ConsoleUtil5printEPKciS1_>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80001a68:	00000613          	li	a2,0
    80001a6c:	00000597          	auipc	a1,0x0
    80001a70:	f0458593          	addi	a1,a1,-252 # 80001970 <_ZN6System15userMainWrapperEPv>
    80001a74:	fc840513          	addi	a0,s0,-56
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	be0080e7          	jalr	-1056(ra) # 80001658 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001a80:	fc843783          	ld	a5,-56(s0)
    80001a84:	0107a703          	lw	a4,16(a5)
    80001a88:	00200793          	li	a5,2
    80001a8c:	00f70863          	beq	a4,a5,80001a9c <_ZN6SystemC1Ev+0x104>
            thread_dispatch();
    80001a90:	00000097          	auipc	ra,0x0
    80001a94:	c6c080e7          	jalr	-916(ra) # 800016fc <_Z15thread_dispatchv>
    80001a98:	fe9ff06f          	j	80001a80 <_ZN6SystemC1Ev+0xe8>
        RiscV::finalize();
    80001a9c:	00002097          	auipc	ra,0x2
    80001aa0:	938080e7          	jalr	-1736(ra) # 800033d4 <_ZN5RiscV8finalizeEv>
}
    80001aa4:	03813083          	ld	ra,56(sp)
    80001aa8:	03013403          	ld	s0,48(sp)
    80001aac:	02813483          	ld	s1,40(sp)
    80001ab0:	02013903          	ld	s2,32(sp)
    80001ab4:	01813983          	ld	s3,24(sp)
    80001ab8:	04010113          	addi	sp,sp,64
    80001abc:	00008067          	ret

0000000080001ac0 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001ac0:	ff010113          	addi	sp,sp,-16
    80001ac4:	00813423          	sd	s0,8(sp)
    80001ac8:	01010413          	addi	s0,sp,16
    80001acc:	00100793          	li	a5,1
    80001ad0:	00f50863          	beq	a0,a5,80001ae0 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001ad4:	00813403          	ld	s0,8(sp)
    80001ad8:	01010113          	addi	sp,sp,16
    80001adc:	00008067          	ret
    80001ae0:	000107b7          	lui	a5,0x10
    80001ae4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001ae8:	fef596e3          	bne	a1,a5,80001ad4 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80001aec:	0000a797          	auipc	a5,0xa
    80001af0:	fbc7b783          	ld	a5,-68(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001af4:	0007b703          	ld	a4,0(a5)
    80001af8:	00c75793          	srli	a5,a4,0xc
    80001afc:	00278793          	addi	a5,a5,2
    80001b00:	00c79793          	slli	a5,a5,0xc
    80001b04:	0000a697          	auipc	a3,0xa
    80001b08:	11468693          	addi	a3,a3,276 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b0c:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001b10:	fffff7b7          	lui	a5,0xfffff
    80001b14:	00f77733          	and	a4,a4,a5
    80001b18:	00e6b423          	sd	a4,8(a3)
    80001b1c:	fb9ff06f          	j	80001ad4 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001b20 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80001b20:	ff010113          	addi	sp,sp,-16
    80001b24:	00813423          	sd	s0,8(sp)
    80001b28:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80001b2c:	0000a717          	auipc	a4,0xa
    80001b30:	0ec70713          	addi	a4,a4,236 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b34:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001b38:	0000a797          	auipc	a5,0xa
    80001b3c:	f707b783          	ld	a5,-144(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001b40:	0007b783          	ld	a5,0(a5)
    80001b44:	fffff6b7          	lui	a3,0xfffff
    80001b48:	00d7f7b3          	and	a5,a5,a3
    80001b4c:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80001b50:	0000a797          	auipc	a5,0xa
    80001b54:	dab7b823          	sd	a1,-592(a5) # 8000b900 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80001b58:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001b5c:	00000713          	li	a4,0
        while(num>1){
    80001b60:	00100693          	li	a3,1
    80001b64:	00f6f863          	bgeu	a3,a5,80001b74 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80001b68:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001b6c:	00170713          	addi	a4,a4,1
        while(num>1){
    80001b70:	ff1ff06f          	j	80001b60 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001b74:	00371713          	slli	a4,a4,0x3
    80001b78:	0000a797          	auipc	a5,0xa
    80001b7c:	0a078793          	addi	a5,a5,160 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b80:	00e78733          	add	a4,a5,a4
    80001b84:	00a73823          	sd	a0,16(a4)
    80001b88:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001b8c:	00000713          	li	a4,0
        while(num>1){
    80001b90:	00100693          	li	a3,1
    80001b94:	00f6f863          	bgeu	a3,a5,80001ba4 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001b98:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001b9c:	00170713          	addi	a4,a4,1
        while(num>1){
    80001ba0:	ff1ff06f          	j	80001b90 <_ZN5Buddy10initializeEPvm+0x70>
    80001ba4:	00371713          	slli	a4,a4,0x3
    80001ba8:	0000a797          	auipc	a5,0xa
    80001bac:	07078793          	addi	a5,a5,112 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001bb0:	00e78733          	add	a4,a5,a4
    80001bb4:	06a73c23          	sd	a0,120(a4)
    80001bb8:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001bbc:	00000713          	li	a4,0
        while(num>1){
    80001bc0:	00100693          	li	a3,1
    80001bc4:	00f6f863          	bgeu	a3,a5,80001bd4 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001bc8:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001bcc:	00170713          	addi	a4,a4,1
        while(num>1){
    80001bd0:	ff1ff06f          	j	80001bc0 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001bd4:	00371713          	slli	a4,a4,0x3
    80001bd8:	0000a797          	auipc	a5,0xa
    80001bdc:	04078793          	addi	a5,a5,64 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001be0:	00e78733          	add	a4,a5,a4
    80001be4:	01073783          	ld	a5,16(a4)
    80001be8:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001bec:	00000793          	li	a5,0
    80001bf0:	00c0006f          	j	80001bfc <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001bf4:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001bf8:	00178793          	addi	a5,a5,1
        while(num>1){
    80001bfc:	00100713          	li	a4,1
    80001c00:	feb76ae3          	bltu	a4,a1,80001bf4 <_ZN5Buddy10initializeEPvm+0xd4>
    80001c04:	00379793          	slli	a5,a5,0x3
    80001c08:	0000a717          	auipc	a4,0xa
    80001c0c:	01070713          	addi	a4,a4,16 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c10:	00f707b3          	add	a5,a4,a5
    80001c14:	0787b783          	ld	a5,120(a5)
    80001c18:	0007b023          	sd	zero,0(a5)
}
    80001c1c:	00813403          	ld	s0,8(sp)
    80001c20:	01010113          	addi	sp,sp,16
    80001c24:	00008067          	ret

0000000080001c28 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001c28:	00c00793          	li	a5,12
    80001c2c:	0ef50863          	beq	a0,a5,80001d1c <_ZN5Buddy8compressEm+0xf4>
void Buddy::compress(uint64 size) {
    80001c30:	fd010113          	addi	sp,sp,-48
    80001c34:	02113423          	sd	ra,40(sp)
    80001c38:	02813023          	sd	s0,32(sp)
    80001c3c:	00913c23          	sd	s1,24(sp)
    80001c40:	01213823          	sd	s2,16(sp)
    80001c44:	01313423          	sd	s3,8(sp)
    80001c48:	03010413          	addi	s0,sp,48
    80001c4c:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001c50:	00351713          	slli	a4,a0,0x3
    80001c54:	0000a797          	auipc	a5,0xa
    80001c58:	fc478793          	addi	a5,a5,-60 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c5c:	00e787b3          	add	a5,a5,a4
    80001c60:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80001c64:	00000993          	li	s3,0
    80001c68:	0180006f          	j	80001c80 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80001c6c:	40d70733          	sub	a4,a4,a3
        if(blkNoNext == pair){
    80001c70:	04f70663          	beq	a4,a5,80001cbc <_ZN5Buddy8compressEm+0x94>
            prev = curr;
    80001c74:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80001c78:	06f70863          	beq	a4,a5,80001ce8 <_ZN5Buddy8compressEm+0xc0>
        curr = curr->next;
    80001c7c:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80001c80:	08048063          	beqz	s1,80001d00 <_ZN5Buddy8compressEm+0xd8>
    80001c84:	0004b603          	ld	a2,0(s1)
    80001c88:	06060c63          	beqz	a2,80001d00 <_ZN5Buddy8compressEm+0xd8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    80001c8c:	0000a797          	auipc	a5,0xa
    80001c90:	f8c7b783          	ld	a5,-116(a5) # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c94:	40f48733          	sub	a4,s1,a5
    80001c98:	00c75713          	srli	a4,a4,0xc
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    80001c9c:	40f607b3          	sub	a5,a2,a5
    80001ca0:	00c7d793          	srli	a5,a5,0xc
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80001ca4:	00100693          	li	a3,1
    80001ca8:	012696bb          	sllw	a3,a3,s2
    80001cac:	02d775b3          	remu	a1,a4,a3
    80001cb0:	fa059ee3          	bnez	a1,80001c6c <_ZN5Buddy8compressEm+0x44>
    80001cb4:	00e68733          	add	a4,a3,a4
    80001cb8:	fb9ff06f          	j	80001c70 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80001cbc:	00098863          	beqz	s3,80001ccc <_ZN5Buddy8compressEm+0xa4>
                prev->next = curr->next->next;
    80001cc0:	00063683          	ld	a3,0(a2)
    80001cc4:	00d9b023          	sd	a3,0(s3)
    80001cc8:	fb1ff06f          	j	80001c78 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80001ccc:	00063603          	ld	a2,0(a2)
    80001cd0:	00391593          	slli	a1,s2,0x3
    80001cd4:	0000a697          	auipc	a3,0xa
    80001cd8:	f4468693          	addi	a3,a3,-188 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001cdc:	00b686b3          	add	a3,a3,a1
    80001ce0:	06c6bc23          	sd	a2,120(a3)
    80001ce4:	f95ff06f          	j	80001c78 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80001ce8:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80001cec:	00190593          	addi	a1,s2,1
    80001cf0:	00048513          	mv	a0,s1
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	02c080e7          	jalr	44(ra) # 80001d20 <_ZN5Buddy6insertEPvm>
    80001cfc:	f81ff06f          	j	80001c7c <_ZN5Buddy8compressEm+0x54>
}
    80001d00:	02813083          	ld	ra,40(sp)
    80001d04:	02013403          	ld	s0,32(sp)
    80001d08:	01813483          	ld	s1,24(sp)
    80001d0c:	01013903          	ld	s2,16(sp)
    80001d10:	00813983          	ld	s3,8(sp)
    80001d14:	03010113          	addi	sp,sp,48
    80001d18:	00008067          	ret
    80001d1c:	00008067          	ret

0000000080001d20 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80001d20:	00050693          	mv	a3,a0
    if(!head[size]){
    80001d24:	00359713          	slli	a4,a1,0x3
    80001d28:	0000a797          	auipc	a5,0xa
    80001d2c:	ef078793          	addi	a5,a5,-272 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d30:	00e787b3          	add	a5,a5,a4
    80001d34:	0787b783          	ld	a5,120(a5)
    80001d38:	02078863          	beqz	a5,80001d68 <_ZN5Buddy6insertEPvm+0x48>
void Buddy::insert(void *addr, uint64 size) {
    80001d3c:	ff010113          	addi	sp,sp,-16
    80001d40:	00113423          	sd	ra,8(sp)
    80001d44:	00813023          	sd	s0,0(sp)
    80001d48:	01010413          	addi	s0,sp,16
    80001d4c:	00058513          	mv	a0,a1
        if((uint64)addr < (uint64)head[size]){
    80001d50:	00068713          	mv	a4,a3
    80001d54:	02f6ec63          	bltu	a3,a5,80001d8c <_ZN5Buddy6insertEPvm+0x6c>
            while(iter != nullptr){
    80001d58:	06078663          	beqz	a5,80001dc4 <_ZN5Buddy6insertEPvm+0xa4>
                if((uint64)addr < (uint64)iter) {
    80001d5c:	04f76a63          	bltu	a4,a5,80001db0 <_ZN5Buddy6insertEPvm+0x90>
                    iter = iter->next;
    80001d60:	0007b783          	ld	a5,0(a5)
            while(iter != nullptr){
    80001d64:	ff5ff06f          	j	80001d58 <_ZN5Buddy6insertEPvm+0x38>
        head[size] = tail[size] = (Block*)addr;
    80001d68:	0000a797          	auipc	a5,0xa
    80001d6c:	eb078793          	addi	a5,a5,-336 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d70:	00e78533          	add	a0,a5,a4
    80001d74:	00d53823          	sd	a3,16(a0)
    80001d78:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80001d7c:	0006b023          	sd	zero,0(a3)
    80001d80:	07853783          	ld	a5,120(a0)
    80001d84:	0007b023          	sd	zero,0(a5)
        return;
    80001d88:	00008067          	ret
            newHead->next = head[size];
    80001d8c:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80001d90:	00359713          	slli	a4,a1,0x3
    80001d94:	0000a797          	auipc	a5,0xa
    80001d98:	e8478793          	addi	a5,a5,-380 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d9c:	00e787b3          	add	a5,a5,a4
    80001da0:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80001da4:	00000097          	auipc	ra,0x0
    80001da8:	e84080e7          	jalr	-380(ra) # 80001c28 <_ZN5Buddy8compressEm>
            return;
    80001dac:	0440006f          	j	80001df0 <_ZN5Buddy6insertEPvm+0xd0>
                    newBlock->next = iter;
    80001db0:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80001db4:	00d03023          	sd	a3,0(zero) # 0 <_entry-0x80000000>
                    compress(size);
    80001db8:	00000097          	auipc	ra,0x0
    80001dbc:	e70080e7          	jalr	-400(ra) # 80001c28 <_ZN5Buddy8compressEm>
                    return;
    80001dc0:	0300006f          	j	80001df0 <_ZN5Buddy6insertEPvm+0xd0>
    tail[size]->next = (Block*)addr;
    80001dc4:	00351713          	slli	a4,a0,0x3
    80001dc8:	0000a797          	auipc	a5,0xa
    80001dcc:	e5078793          	addi	a5,a5,-432 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001dd0:	00e787b3          	add	a5,a5,a4
    80001dd4:	0107b703          	ld	a4,16(a5)
    80001dd8:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80001ddc:	0107b703          	ld	a4,16(a5)
    80001de0:	00073703          	ld	a4,0(a4)
    80001de4:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	e40080e7          	jalr	-448(ra) # 80001c28 <_ZN5Buddy8compressEm>
}
    80001df0:	00813083          	ld	ra,8(sp)
    80001df4:	00013403          	ld	s0,0(sp)
    80001df8:	01010113          	addi	sp,sp,16
    80001dfc:	00008067          	ret

0000000080001e00 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80001e00:	02050663          	beqz	a0,80001e2c <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80001e04:	ff010113          	addi	sp,sp,-16
    80001e08:	00113423          	sd	ra,8(sp)
    80001e0c:	00813023          	sd	s0,0(sp)
    80001e10:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80001e14:	00000097          	auipc	ra,0x0
    80001e18:	f0c080e7          	jalr	-244(ra) # 80001d20 <_ZN5Buddy6insertEPvm>
}
    80001e1c:	00813083          	ld	ra,8(sp)
    80001e20:	00013403          	ld	s0,0(sp)
    80001e24:	01010113          	addi	sp,sp,16
    80001e28:	00008067          	ret
    80001e2c:	00008067          	ret

0000000080001e30 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001e30:	ff010113          	addi	sp,sp,-16
    80001e34:	00813423          	sd	s0,8(sp)
    80001e38:	01010413          	addi	s0,sp,16
    80001e3c:	03c0006f          	j	80001e78 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001e40:	00b5859b          	addiw	a1,a1,11
    80001e44:	00100713          	li	a4,1
    80001e48:	00b715bb          	sllw	a1,a4,a1
    80001e4c:	00b505b3          	add	a1,a0,a1
    80001e50:	00379693          	slli	a3,a5,0x3
    80001e54:	0000a717          	auipc	a4,0xa
    80001e58:	dc470713          	addi	a4,a4,-572 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001e5c:	00d70733          	add	a4,a4,a3
    80001e60:	00b73823          	sd	a1,16(a4)
    80001e64:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80001e68:	0005b023          	sd	zero,0(a1)
    80001e6c:	07873703          	ld	a4,120(a4)
    80001e70:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001e74:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80001e78:	fff5879b          	addiw	a5,a1,-1
    80001e7c:	04c7c863          	blt	a5,a2,80001ecc <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80001e80:	00379693          	slli	a3,a5,0x3
    80001e84:	0000a717          	auipc	a4,0xa
    80001e88:	d9470713          	addi	a4,a4,-620 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001e8c:	00d70733          	add	a4,a4,a3
    80001e90:	01073683          	ld	a3,16(a4)
    80001e94:	fa0686e3          	beqz	a3,80001e40 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001e98:	00b5859b          	addiw	a1,a1,11
    80001e9c:	00100713          	li	a4,1
    80001ea0:	00b715bb          	sllw	a1,a4,a1
    80001ea4:	00b505b3          	add	a1,a0,a1
    80001ea8:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80001eac:	00379693          	slli	a3,a5,0x3
    80001eb0:	0000a717          	auipc	a4,0xa
    80001eb4:	d6870713          	addi	a4,a4,-664 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001eb8:	00d70733          	add	a4,a4,a3
    80001ebc:	01073683          	ld	a3,16(a4)
    80001ec0:	0006b683          	ld	a3,0(a3)
    80001ec4:	00d73823          	sd	a3,16(a4)
    80001ec8:	fadff06f          	j	80001e74 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80001ecc:	00813403          	ld	s0,8(sp)
    80001ed0:	01010113          	addi	sp,sp,16
    80001ed4:	00008067          	ret

0000000080001ed8 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80001ed8:	fe010113          	addi	sp,sp,-32
    80001edc:	00113c23          	sd	ra,24(sp)
    80001ee0:	00813823          	sd	s0,16(sp)
    80001ee4:	00913423          	sd	s1,8(sp)
    80001ee8:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80001eec:	00c00793          	li	a5,12
    80001ef0:	06a7ec63          	bltu	a5,a0,80001f68 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001ef4:	00050593          	mv	a1,a0
    80001ef8:	00c00793          	li	a5,12
    80001efc:	06b7ea63          	bltu	a5,a1,80001f70 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80001f00:	00359713          	slli	a4,a1,0x3
    80001f04:	0000a797          	auipc	a5,0xa
    80001f08:	d1478793          	addi	a5,a5,-748 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f0c:	00e787b3          	add	a5,a5,a4
    80001f10:	0787b483          	ld	s1,120(a5)
    80001f14:	00049663          	bnez	s1,80001f20 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001f18:	00158593          	addi	a1,a1,1
    80001f1c:	fddff06f          	j	80001ef8 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80001f20:	0004b703          	ld	a4,0(s1)
    80001f24:	00359693          	slli	a3,a1,0x3
    80001f28:	0000a797          	auipc	a5,0xa
    80001f2c:	cf078793          	addi	a5,a5,-784 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f30:	00d787b3          	add	a5,a5,a3
    80001f34:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80001f38:	00070e63          	beqz	a4,80001f54 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80001f3c:	0005061b          	sext.w	a2,a0
    80001f40:	0005859b          	sext.w	a1,a1
    80001f44:	00048513          	mv	a0,s1
    80001f48:	00000097          	auipc	ra,0x0
    80001f4c:	ee8080e7          	jalr	-280(ra) # 80001e30 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80001f50:	0240006f          	j	80001f74 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80001f54:	0000a797          	auipc	a5,0xa
    80001f58:	cc478793          	addi	a5,a5,-828 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f5c:	00d787b3          	add	a5,a5,a3
    80001f60:	0007b823          	sd	zero,16(a5)
    80001f64:	fd9ff06f          	j	80001f3c <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80001f68:	00000493          	li	s1,0
    80001f6c:	0080006f          	j	80001f74 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80001f70:	00000493          	li	s1,0
}
    80001f74:	00048513          	mv	a0,s1
    80001f78:	01813083          	ld	ra,24(sp)
    80001f7c:	01013403          	ld	s0,16(sp)
    80001f80:	00813483          	ld	s1,8(sp)
    80001f84:	02010113          	addi	sp,sp,32
    80001f88:	00008067          	ret

0000000080001f8c <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80001f8c:	fe010113          	addi	sp,sp,-32
    80001f90:	00113c23          	sd	ra,24(sp)
    80001f94:	00813823          	sd	s0,16(sp)
    80001f98:	00913423          	sd	s1,8(sp)
    80001f9c:	01213023          	sd	s2,0(sp)
    80001fa0:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80001fa4:	00000913          	li	s2,0
    80001fa8:	0180006f          	j	80001fc0 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80001fac:	00007517          	auipc	a0,0x7
    80001fb0:	1f450513          	addi	a0,a0,500 # 800091a0 <CONSOLE_STATUS+0x190>
    80001fb4:	00002097          	auipc	ra,0x2
    80001fb8:	5d8080e7          	jalr	1496(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001fbc:	0019091b          	addiw	s2,s2,1
    80001fc0:	00c00793          	li	a5,12
    80001fc4:	0727c663          	blt	a5,s2,80002030 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80001fc8:	00000613          	li	a2,0
    80001fcc:	00a00593          	li	a1,10
    80001fd0:	00090513          	mv	a0,s2
    80001fd4:	00002097          	auipc	ra,0x2
    80001fd8:	5fc080e7          	jalr	1532(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80001fdc:	00007517          	auipc	a0,0x7
    80001fe0:	13c50513          	addi	a0,a0,316 # 80009118 <CONSOLE_STATUS+0x108>
    80001fe4:	00002097          	auipc	ra,0x2
    80001fe8:	5a8080e7          	jalr	1448(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80001fec:	00391713          	slli	a4,s2,0x3
    80001ff0:	0000a797          	auipc	a5,0xa
    80001ff4:	c2878793          	addi	a5,a5,-984 # 8000bc18 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ff8:	00e787b3          	add	a5,a5,a4
    80001ffc:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002000:	fa0486e3          	beqz	s1,80001fac <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    80002004:	00000613          	li	a2,0
    80002008:	00a00593          	li	a1,10
    8000200c:	0004851b          	sext.w	a0,s1
    80002010:	00002097          	auipc	ra,0x2
    80002014:	5c0080e7          	jalr	1472(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002018:	00007517          	auipc	a0,0x7
    8000201c:	0a850513          	addi	a0,a0,168 # 800090c0 <CONSOLE_STATUS+0xb0>
    80002020:	00002097          	auipc	ra,0x2
    80002024:	56c080e7          	jalr	1388(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002028:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    8000202c:	fd5ff06f          	j	80002000 <_ZN5Buddy9printListEv+0x74>
    80002030:	01813083          	ld	ra,24(sp)
    80002034:	01013403          	ld	s0,16(sp)
    80002038:	00813483          	ld	s1,8(sp)
    8000203c:	00013903          	ld	s2,0(sp)
    80002040:	02010113          	addi	sp,sp,32
    80002044:	00008067          	ret

0000000080002048 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002048:	ff010113          	addi	sp,sp,-16
    8000204c:	00113423          	sd	ra,8(sp)
    80002050:	00813023          	sd	s0,0(sp)
    80002054:	01010413          	addi	s0,sp,16
    80002058:	000105b7          	lui	a1,0x10
    8000205c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002060:	00100513          	li	a0,1
    80002064:	00000097          	auipc	ra,0x0
    80002068:	a5c080e7          	jalr	-1444(ra) # 80001ac0 <_Z41__static_initialization_and_destruction_0ii>
    8000206c:	00813083          	ld	ra,8(sp)
    80002070:	00013403          	ld	s0,0(sp)
    80002074:	01010113          	addi	sp,sp,16
    80002078:	00008067          	ret

000000008000207c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    8000207c:	fe010113          	addi	sp,sp,-32
    80002080:	00113c23          	sd	ra,24(sp)
    80002084:	00813823          	sd	s0,16(sp)
    80002088:	00913423          	sd	s1,8(sp)
    8000208c:	02010413          	addi	s0,sp,32
    80002090:	00050493          	mv	s1,a0
    LOCK();
    80002094:	00100613          	li	a2,1
    80002098:	00000593          	li	a1,0
    8000209c:	0000a517          	auipc	a0,0xa
    800020a0:	c5c50513          	addi	a0,a0,-932 # 8000bcf8 <lockPrint>
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	f5c080e7          	jalr	-164(ra) # 80001000 <copy_and_swap>
    800020ac:	fe0514e3          	bnez	a0,80002094 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800020b0:	0004c503          	lbu	a0,0(s1)
    800020b4:	00050a63          	beqz	a0,800020c8 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	81c080e7          	jalr	-2020(ra) # 800018d4 <_Z4putcc>
        string++;
    800020c0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800020c4:	fedff06f          	j	800020b0 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800020c8:	00000613          	li	a2,0
    800020cc:	00100593          	li	a1,1
    800020d0:	0000a517          	auipc	a0,0xa
    800020d4:	c2850513          	addi	a0,a0,-984 # 8000bcf8 <lockPrint>
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	f28080e7          	jalr	-216(ra) # 80001000 <copy_and_swap>
    800020e0:	fe0514e3          	bnez	a0,800020c8 <_Z11printStringPKc+0x4c>
}
    800020e4:	01813083          	ld	ra,24(sp)
    800020e8:	01013403          	ld	s0,16(sp)
    800020ec:	00813483          	ld	s1,8(sp)
    800020f0:	02010113          	addi	sp,sp,32
    800020f4:	00008067          	ret

00000000800020f8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800020f8:	fd010113          	addi	sp,sp,-48
    800020fc:	02113423          	sd	ra,40(sp)
    80002100:	02813023          	sd	s0,32(sp)
    80002104:	00913c23          	sd	s1,24(sp)
    80002108:	01213823          	sd	s2,16(sp)
    8000210c:	01313423          	sd	s3,8(sp)
    80002110:	01413023          	sd	s4,0(sp)
    80002114:	03010413          	addi	s0,sp,48
    80002118:	00050993          	mv	s3,a0
    8000211c:	00058a13          	mv	s4,a1
    LOCK();
    80002120:	00100613          	li	a2,1
    80002124:	00000593          	li	a1,0
    80002128:	0000a517          	auipc	a0,0xa
    8000212c:	bd050513          	addi	a0,a0,-1072 # 8000bcf8 <lockPrint>
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	ed0080e7          	jalr	-304(ra) # 80001000 <copy_and_swap>
    80002138:	fe0514e3          	bnez	a0,80002120 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000213c:	00000913          	li	s2,0
    80002140:	00090493          	mv	s1,s2
    80002144:	0019091b          	addiw	s2,s2,1
    80002148:	03495a63          	bge	s2,s4,8000217c <_Z9getStringPci+0x84>
        cc = getc();
    8000214c:	fffff097          	auipc	ra,0xfffff
    80002150:	760080e7          	jalr	1888(ra) # 800018ac <_Z4getcv>
        if(cc < 1)
    80002154:	02050463          	beqz	a0,8000217c <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002158:	009984b3          	add	s1,s3,s1
    8000215c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002160:	00a00793          	li	a5,10
    80002164:	00f50a63          	beq	a0,a5,80002178 <_Z9getStringPci+0x80>
    80002168:	00d00793          	li	a5,13
    8000216c:	fcf51ae3          	bne	a0,a5,80002140 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002170:	00090493          	mv	s1,s2
    80002174:	0080006f          	j	8000217c <_Z9getStringPci+0x84>
    80002178:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    8000217c:	009984b3          	add	s1,s3,s1
    80002180:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002184:	00000613          	li	a2,0
    80002188:	00100593          	li	a1,1
    8000218c:	0000a517          	auipc	a0,0xa
    80002190:	b6c50513          	addi	a0,a0,-1172 # 8000bcf8 <lockPrint>
    80002194:	fffff097          	auipc	ra,0xfffff
    80002198:	e6c080e7          	jalr	-404(ra) # 80001000 <copy_and_swap>
    8000219c:	fe0514e3          	bnez	a0,80002184 <_Z9getStringPci+0x8c>
    return buf;
}
    800021a0:	00098513          	mv	a0,s3
    800021a4:	02813083          	ld	ra,40(sp)
    800021a8:	02013403          	ld	s0,32(sp)
    800021ac:	01813483          	ld	s1,24(sp)
    800021b0:	01013903          	ld	s2,16(sp)
    800021b4:	00813983          	ld	s3,8(sp)
    800021b8:	00013a03          	ld	s4,0(sp)
    800021bc:	03010113          	addi	sp,sp,48
    800021c0:	00008067          	ret

00000000800021c4 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800021c4:	ff010113          	addi	sp,sp,-16
    800021c8:	00813423          	sd	s0,8(sp)
    800021cc:	01010413          	addi	s0,sp,16
    800021d0:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800021d4:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800021d8:	0006c603          	lbu	a2,0(a3)
    800021dc:	fd06071b          	addiw	a4,a2,-48
    800021e0:	0ff77713          	andi	a4,a4,255
    800021e4:	00900793          	li	a5,9
    800021e8:	02e7e063          	bltu	a5,a4,80002208 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800021ec:	0025179b          	slliw	a5,a0,0x2
    800021f0:	00a787bb          	addw	a5,a5,a0
    800021f4:	0017979b          	slliw	a5,a5,0x1
    800021f8:	00168693          	addi	a3,a3,1
    800021fc:	00c787bb          	addw	a5,a5,a2
    80002200:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002204:	fd5ff06f          	j	800021d8 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002208:	00813403          	ld	s0,8(sp)
    8000220c:	01010113          	addi	sp,sp,16
    80002210:	00008067          	ret

0000000080002214 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002214:	fc010113          	addi	sp,sp,-64
    80002218:	02113c23          	sd	ra,56(sp)
    8000221c:	02813823          	sd	s0,48(sp)
    80002220:	02913423          	sd	s1,40(sp)
    80002224:	03213023          	sd	s2,32(sp)
    80002228:	01313c23          	sd	s3,24(sp)
    8000222c:	04010413          	addi	s0,sp,64
    80002230:	00050493          	mv	s1,a0
    80002234:	00058913          	mv	s2,a1
    80002238:	00060993          	mv	s3,a2
    LOCK();
    8000223c:	00100613          	li	a2,1
    80002240:	00000593          	li	a1,0
    80002244:	0000a517          	auipc	a0,0xa
    80002248:	ab450513          	addi	a0,a0,-1356 # 8000bcf8 <lockPrint>
    8000224c:	fffff097          	auipc	ra,0xfffff
    80002250:	db4080e7          	jalr	-588(ra) # 80001000 <copy_and_swap>
    80002254:	fe0514e3          	bnez	a0,8000223c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002258:	00098463          	beqz	s3,80002260 <_Z8printIntiii+0x4c>
    8000225c:	0804c463          	bltz	s1,800022e4 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002260:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002264:	00000593          	li	a1,0
    }

    i = 0;
    80002268:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    8000226c:	0009079b          	sext.w	a5,s2
    80002270:	0325773b          	remuw	a4,a0,s2
    80002274:	00048613          	mv	a2,s1
    80002278:	0014849b          	addiw	s1,s1,1
    8000227c:	02071693          	slli	a3,a4,0x20
    80002280:	0206d693          	srli	a3,a3,0x20
    80002284:	00009717          	auipc	a4,0x9
    80002288:	68470713          	addi	a4,a4,1668 # 8000b908 <digits>
    8000228c:	00d70733          	add	a4,a4,a3
    80002290:	00074683          	lbu	a3,0(a4)
    80002294:	fd040713          	addi	a4,s0,-48
    80002298:	00c70733          	add	a4,a4,a2
    8000229c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800022a0:	0005071b          	sext.w	a4,a0
    800022a4:	0325553b          	divuw	a0,a0,s2
    800022a8:	fcf772e3          	bgeu	a4,a5,8000226c <_Z8printIntiii+0x58>
    if(neg)
    800022ac:	00058c63          	beqz	a1,800022c4 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800022b0:	fd040793          	addi	a5,s0,-48
    800022b4:	009784b3          	add	s1,a5,s1
    800022b8:	02d00793          	li	a5,45
    800022bc:	fef48823          	sb	a5,-16(s1)
    800022c0:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800022c4:	fff4849b          	addiw	s1,s1,-1
    800022c8:	0204c463          	bltz	s1,800022f0 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    800022cc:	fd040793          	addi	a5,s0,-48
    800022d0:	009787b3          	add	a5,a5,s1
    800022d4:	ff07c503          	lbu	a0,-16(a5)
    800022d8:	fffff097          	auipc	ra,0xfffff
    800022dc:	5fc080e7          	jalr	1532(ra) # 800018d4 <_Z4putcc>
    800022e0:	fe5ff06f          	j	800022c4 <_Z8printIntiii+0xb0>
        x = -xx;
    800022e4:	4090053b          	negw	a0,s1
        neg = 1;
    800022e8:	00100593          	li	a1,1
        x = -xx;
    800022ec:	f7dff06f          	j	80002268 <_Z8printIntiii+0x54>

    UNLOCK();
    800022f0:	00000613          	li	a2,0
    800022f4:	00100593          	li	a1,1
    800022f8:	0000a517          	auipc	a0,0xa
    800022fc:	a0050513          	addi	a0,a0,-1536 # 8000bcf8 <lockPrint>
    80002300:	fffff097          	auipc	ra,0xfffff
    80002304:	d00080e7          	jalr	-768(ra) # 80001000 <copy_and_swap>
    80002308:	fe0514e3          	bnez	a0,800022f0 <_Z8printIntiii+0xdc>
    8000230c:	03813083          	ld	ra,56(sp)
    80002310:	03013403          	ld	s0,48(sp)
    80002314:	02813483          	ld	s1,40(sp)
    80002318:	02013903          	ld	s2,32(sp)
    8000231c:	01813983          	ld	s3,24(sp)
    80002320:	04010113          	addi	sp,sp,64
    80002324:	00008067          	ret

0000000080002328 <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80002328:	ff010113          	addi	sp,sp,-16
    8000232c:	00813423          	sd	s0,8(sp)
    80002330:	01010413          	addi	s0,sp,16
    val = init;
    80002334:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80002338:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    8000233c:	00053823          	sd	zero,16(a0)
}
    80002340:	00813403          	ld	s0,8(sp)
    80002344:	01010113          	addi	sp,sp,16
    80002348:	00008067          	ret

000000008000234c <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    8000234c:	fe010113          	addi	sp,sp,-32
    80002350:	00113c23          	sd	ra,24(sp)
    80002354:	00813823          	sd	s0,16(sp)
    80002358:	00913423          	sd	s1,8(sp)
    8000235c:	01213023          	sd	s2,0(sp)
    80002360:	02010413          	addi	s0,sp,32
    80002364:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002368:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    8000236c:	02050063          	beqz	a0,8000238c <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    80002370:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002374:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002378:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    8000237c:	00002097          	auipc	ra,0x2
    80002380:	d8c080e7          	jalr	-628(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002384:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002388:	fe5ff06f          	j	8000236c <_ZN3SCBD1Ev+0x20>
    }
}
    8000238c:	01813083          	ld	ra,24(sp)
    80002390:	01013403          	ld	s0,16(sp)
    80002394:	00813483          	ld	s1,8(sp)
    80002398:	00013903          	ld	s2,0(sp)
    8000239c:	02010113          	addi	sp,sp,32
    800023a0:	00008067          	ret

00000000800023a4 <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    800023a4:	ff010113          	addi	sp,sp,-16
    800023a8:	00113423          	sd	ra,8(sp)
    800023ac:	00813023          	sd	s0,0(sp)
    800023b0:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800023b4:	00853783          	ld	a5,8(a0)
    800023b8:	04078063          	beqz	a5,800023f8 <_ZN3SCB5blockEv+0x54>
    800023bc:	01053703          	ld	a4,16(a0)
    800023c0:	00009797          	auipc	a5,0x9
    800023c4:	7607b783          	ld	a5,1888(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    800023c8:	0007b783          	ld	a5,0(a5)
    800023cc:	04f73423          	sd	a5,72(a4)
    800023d0:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    800023d4:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    800023d8:	00300713          	li	a4,3
    800023dc:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800023e0:	00000097          	auipc	ra,0x0
    800023e4:	2c0080e7          	jalr	704(ra) # 800026a0 <_ZN3TCB8dispatchEv>
}
    800023e8:	00813083          	ld	ra,8(sp)
    800023ec:	00013403          	ld	s0,0(sp)
    800023f0:	01010113          	addi	sp,sp,16
    800023f4:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800023f8:	00009797          	auipc	a5,0x9
    800023fc:	7287b783          	ld	a5,1832(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002400:	0007b783          	ld	a5,0(a5)
    80002404:	00f53423          	sd	a5,8(a0)
    80002408:	fc9ff06f          	j	800023d0 <_ZN3SCB5blockEv+0x2c>

000000008000240c <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    8000240c:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002410:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002414:	04853703          	ld	a4,72(a0)
    80002418:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    8000241c:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002420:	02050a63          	beqz	a0,80002454 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002424:	ff010113          	addi	sp,sp,-16
    80002428:	00113423          	sd	ra,8(sp)
    8000242c:	00813023          	sd	s0,0(sp)
    80002430:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002434:	00100793          	li	a5,1
    80002438:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    8000243c:	00002097          	auipc	ra,0x2
    80002440:	ccc080e7          	jalr	-820(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
    }
}
    80002444:	00813083          	ld	ra,8(sp)
    80002448:	00013403          	ld	s0,0(sp)
    8000244c:	01010113          	addi	sp,sp,16
    80002450:	00008067          	ret
    80002454:	00008067          	ret

0000000080002458 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80002458:	00009797          	auipc	a5,0x9
    8000245c:	6c87b783          	ld	a5,1736(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002460:	0007b783          	ld	a5,0(a5)
    80002464:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002468:	00052783          	lw	a5,0(a0)
    8000246c:	fff7879b          	addiw	a5,a5,-1
    80002470:	00f52023          	sw	a5,0(a0)
    80002474:	02079713          	slli	a4,a5,0x20
    80002478:	00074463          	bltz	a4,80002480 <_ZN3SCB4waitEv+0x28>
    8000247c:	00008067          	ret
void SCB::wait() {
    80002480:	ff010113          	addi	sp,sp,-16
    80002484:	00113423          	sd	ra,8(sp)
    80002488:	00813023          	sd	s0,0(sp)
    8000248c:	01010413          	addi	s0,sp,16
        block();
    80002490:	00000097          	auipc	ra,0x0
    80002494:	f14080e7          	jalr	-236(ra) # 800023a4 <_ZN3SCB5blockEv>
}
    80002498:	00813083          	ld	ra,8(sp)
    8000249c:	00013403          	ld	s0,0(sp)
    800024a0:	01010113          	addi	sp,sp,16
    800024a4:	00008067          	ret

00000000800024a8 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    800024a8:	00052783          	lw	a5,0(a0)
    800024ac:	0017871b          	addiw	a4,a5,1
    800024b0:	00e52023          	sw	a4,0(a0)
    800024b4:	0007c463          	bltz	a5,800024bc <_ZN3SCB6signalEv+0x14>
    800024b8:	00008067          	ret
void SCB::signal(){
    800024bc:	ff010113          	addi	sp,sp,-16
    800024c0:	00113423          	sd	ra,8(sp)
    800024c4:	00813023          	sd	s0,0(sp)
    800024c8:	01010413          	addi	s0,sp,16
        deblock();
    800024cc:	00000097          	auipc	ra,0x0
    800024d0:	f40080e7          	jalr	-192(ra) # 8000240c <_ZN3SCB7deblockEv>
}
    800024d4:	00813083          	ld	ra,8(sp)
    800024d8:	00013403          	ld	s0,0(sp)
    800024dc:	01010113          	addi	sp,sp,16
    800024e0:	00008067          	ret

00000000800024e4 <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    800024e4:	ff010113          	addi	sp,sp,-16
    800024e8:	00113423          	sd	ra,8(sp)
    800024ec:	00813023          	sd	s0,0(sp)
    800024f0:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    800024f4:	00000097          	auipc	ra,0x0
    800024f8:	3f4080e7          	jalr	1012(ra) # 800028e8 <_ZN15MemoryAllocator7kmallocEm>
}
    800024fc:	00813083          	ld	ra,8(sp)
    80002500:	00013403          	ld	s0,0(sp)
    80002504:	01010113          	addi	sp,sp,16
    80002508:	00008067          	ret

000000008000250c <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    8000250c:	ff010113          	addi	sp,sp,-16
    80002510:	00113423          	sd	ra,8(sp)
    80002514:	00813023          	sd	s0,0(sp)
    80002518:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    8000251c:	00000097          	auipc	ra,0x0
    80002520:	5f4080e7          	jalr	1524(ra) # 80002b10 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002524:	00813083          	ld	ra,8(sp)
    80002528:	00013403          	ld	s0,0(sp)
    8000252c:	01010113          	addi	sp,sp,16
    80002530:	00008067          	ret

0000000080002534 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002534:	ff010113          	addi	sp,sp,-16
    80002538:	00813423          	sd	s0,8(sp)
    8000253c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002540:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002544:	05200513          	li	a0,82
    asm("ecall");
    80002548:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    8000254c:	00050513          	mv	a0,a0
    return status;
}
    80002550:	0005051b          	sext.w	a0,a0
    80002554:	00813403          	ld	s0,8(sp)
    80002558:	01010113          	addi	sp,sp,16
    8000255c:	00008067          	ret

0000000080002560 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002560:	fe010113          	addi	sp,sp,-32
    80002564:	00113c23          	sd	ra,24(sp)
    80002568:	00813823          	sd	s0,16(sp)
    8000256c:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002570:	fe840513          	addi	a0,s0,-24
    80002574:	fffff097          	auipc	ra,0xfffff
    80002578:	424080e7          	jalr	1060(ra) # 80001998 <_ZN6SystemC1Ev>

    return 0;
    8000257c:	00000513          	li	a0,0
    80002580:	01813083          	ld	ra,24(sp)
    80002584:	01013403          	ld	s0,16(sp)
    80002588:	02010113          	addi	sp,sp,32
    8000258c:	00008067          	ret

0000000080002590 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002590:	ff010113          	addi	sp,sp,-16
    80002594:	00113423          	sd	ra,8(sp)
    80002598:	00813023          	sd	s0,0(sp)
    8000259c:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    800025a0:	00001097          	auipc	ra,0x1
    800025a4:	cbc080e7          	jalr	-836(ra) # 8000325c <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    800025a8:	00009797          	auipc	a5,0x9
    800025ac:	7587b783          	ld	a5,1880(a5) # 8000bd00 <_ZN3TCB7runningE>
    800025b0:	0187b703          	ld	a4,24(a5)
    800025b4:	0207b503          	ld	a0,32(a5)
    800025b8:	000700e7          	jalr	a4

    thread_exit();
    800025bc:	fffff097          	auipc	ra,0xfffff
    800025c0:	118080e7          	jalr	280(ra) # 800016d4 <_Z11thread_exitv>
}
    800025c4:	00813083          	ld	ra,8(sp)
    800025c8:	00013403          	ld	s0,0(sp)
    800025cc:	01010113          	addi	sp,sp,16
    800025d0:	00008067          	ret

00000000800025d4 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    800025d4:	ff010113          	addi	sp,sp,-16
    800025d8:	00813423          	sd	s0,8(sp)
    800025dc:	01010413          	addi	s0,sp,16
    800025e0:	04053823          	sd	zero,80(a0)
    800025e4:	04053c23          	sd	zero,88(a0)
    800025e8:	06053023          	sd	zero,96(a0)
    this->body = body;
    800025ec:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    800025f0:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    800025f4:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    800025f8:	04058263          	beqz	a1,8000263c <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    800025fc:	00068793          	mv	a5,a3
    80002600:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    80002604:	00100793          	li	a5,1
    80002608:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    8000260c:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002610:	02058a63          	beqz	a1,80002644 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    80002614:	000017b7          	lui	a5,0x1
    80002618:	00f686b3          	add	a3,a3,a5
    8000261c:	00d53023          	sd	a3,0(a0)
    80002620:	00000797          	auipc	a5,0x0
    80002624:	f7078793          	addi	a5,a5,-144 # 80002590 <_ZN3TCB7wrapperEPv>
    80002628:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    8000262c:	00052a23          	sw	zero,20(a0)
}
    80002630:	00813403          	ld	s0,8(sp)
    80002634:	01010113          	addi	sp,sp,16
    80002638:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    8000263c:	00000793          	li	a5,0
    80002640:	fc1ff06f          	j	80002600 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002644:	00000693          	li	a3,0
    80002648:	fd5ff06f          	j	8000261c <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

000000008000264c <_ZN3TCB4freeEv>:
void TCB::free(){
    8000264c:	ff010113          	addi	sp,sp,-16
    80002650:	00113423          	sd	ra,8(sp)
    80002654:	00813023          	sd	s0,0(sp)
    80002658:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    8000265c:	02853503          	ld	a0,40(a0)
    80002660:	00000097          	auipc	ra,0x0
    80002664:	4b0080e7          	jalr	1200(ra) # 80002b10 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002668:	00813083          	ld	ra,8(sp)
    8000266c:	00013403          	ld	s0,0(sp)
    80002670:	01010113          	addi	sp,sp,16
    80002674:	00008067          	ret

0000000080002678 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002678:	ff010113          	addi	sp,sp,-16
    8000267c:	00113423          	sd	ra,8(sp)
    80002680:	00813023          	sd	s0,0(sp)
    80002684:	01010413          	addi	s0,sp,16
    free();
    80002688:	00000097          	auipc	ra,0x0
    8000268c:	fc4080e7          	jalr	-60(ra) # 8000264c <_ZN3TCB4freeEv>
}
    80002690:	00813083          	ld	ra,8(sp)
    80002694:	00013403          	ld	s0,0(sp)
    80002698:	01010113          	addi	sp,sp,16
    8000269c:	00008067          	ret

00000000800026a0 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800026a0:	fe010113          	addi	sp,sp,-32
    800026a4:	00113c23          	sd	ra,24(sp)
    800026a8:	00813823          	sd	s0,16(sp)
    800026ac:	00913423          	sd	s1,8(sp)
    800026b0:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800026b4:	00009497          	auipc	s1,0x9
    800026b8:	64c4b483          	ld	s1,1612(s1) # 8000bd00 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800026bc:	0104a703          	lw	a4,16(s1)
    800026c0:	00100793          	li	a5,1
    800026c4:	04e7f663          	bgeu	a5,a4,80002710 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800026c8:	00002097          	auipc	ra,0x2
    800026cc:	a88080e7          	jalr	-1400(ra) # 80004150 <_ZN9Scheduler3getEv>
    800026d0:	00009797          	auipc	a5,0x9
    800026d4:	62a7b823          	sd	a0,1584(a5) # 8000bd00 <_ZN3TCB7runningE>
    if(running) {
    800026d8:	02050263          	beqz	a0,800026fc <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800026dc:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800026e0:	00001097          	auipc	ra,0x1
    800026e4:	cb0080e7          	jalr	-848(ra) # 80003390 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    800026e8:	00009597          	auipc	a1,0x9
    800026ec:	6185b583          	ld	a1,1560(a1) # 8000bd00 <_ZN3TCB7runningE>
    800026f0:	00048513          	mv	a0,s1
    800026f4:	fffff097          	auipc	ra,0xfffff
    800026f8:	a4c080e7          	jalr	-1460(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    800026fc:	01813083          	ld	ra,24(sp)
    80002700:	01013403          	ld	s0,16(sp)
    80002704:	00813483          	ld	s1,8(sp)
    80002708:	02010113          	addi	sp,sp,32
    8000270c:	00008067          	ret
        Scheduler::put(old);
    80002710:	00048513          	mv	a0,s1
    80002714:	00002097          	auipc	ra,0x2
    80002718:	9f4080e7          	jalr	-1548(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
    8000271c:	fadff06f          	j	800026c8 <_ZN3TCB8dispatchEv+0x28>

0000000080002720 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002720:	ff010113          	addi	sp,sp,-16
    80002724:	00113423          	sd	ra,8(sp)
    80002728:	00813023          	sd	s0,0(sp)
    8000272c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002730:	00000097          	auipc	ra,0x0
    80002734:	1b8080e7          	jalr	440(ra) # 800028e8 <_ZN15MemoryAllocator7kmallocEm>
}
    80002738:	00813083          	ld	ra,8(sp)
    8000273c:	00013403          	ld	s0,0(sp)
    80002740:	01010113          	addi	sp,sp,16
    80002744:	00008067          	ret

0000000080002748 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002748:	fd010113          	addi	sp,sp,-48
    8000274c:	02113423          	sd	ra,40(sp)
    80002750:	02813023          	sd	s0,32(sp)
    80002754:	00913c23          	sd	s1,24(sp)
    80002758:	01213823          	sd	s2,16(sp)
    8000275c:	01313423          	sd	s3,8(sp)
    80002760:	01413023          	sd	s4,0(sp)
    80002764:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002768:	07000513          	li	a0,112
    8000276c:	00000097          	auipc	ra,0x0
    80002770:	fb4080e7          	jalr	-76(ra) # 80002720 <_ZN3TCBnwEm>
    80002774:	00050493          	mv	s1,a0
    80002778:	00200713          	li	a4,2
    8000277c:	00000693          	li	a3,0
    80002780:	00000613          	li	a2,0
    80002784:	00000593          	li	a1,0
    80002788:	00000097          	auipc	ra,0x0
    8000278c:	e4c080e7          	jalr	-436(ra) # 800025d4 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002790:	00009a17          	auipc	s4,0x9
    80002794:	570a0a13          	addi	s4,s4,1392 # 8000bd00 <_ZN3TCB7runningE>
    80002798:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    8000279c:	00100993          	li	s3,1
    800027a0:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800027a4:	04000513          	li	a0,64
    800027a8:	00000097          	auipc	ra,0x0
    800027ac:	140080e7          	jalr	320(ra) # 800028e8 <_ZN15MemoryAllocator7kmallocEm>
    800027b0:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    800027b4:	07000513          	li	a0,112
    800027b8:	00000097          	auipc	ra,0x0
    800027bc:	f68080e7          	jalr	-152(ra) # 80002720 <_ZN3TCBnwEm>
    800027c0:	00050493          	mv	s1,a0
    800027c4:	00200713          	li	a4,2
    800027c8:	00090693          	mv	a3,s2
    800027cc:	00000613          	li	a2,0
    800027d0:	00009597          	auipc	a1,0x9
    800027d4:	2e85b583          	ld	a1,744(a1) # 8000bab8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	dfc080e7          	jalr	-516(ra) # 800025d4 <_ZN3TCBC1EPFvPvES0_Pmm>
    800027e0:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    800027e4:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    800027e8:	00048513          	mv	a0,s1
    800027ec:	00002097          	auipc	ra,0x2
    800027f0:	91c080e7          	jalr	-1764(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
}
    800027f4:	02813083          	ld	ra,40(sp)
    800027f8:	02013403          	ld	s0,32(sp)
    800027fc:	01813483          	ld	s1,24(sp)
    80002800:	01013903          	ld	s2,16(sp)
    80002804:	00813983          	ld	s3,8(sp)
    80002808:	00013a03          	ld	s4,0(sp)
    8000280c:	03010113          	addi	sp,sp,48
    80002810:	00008067          	ret

0000000080002814 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    80002814:	ff010113          	addi	sp,sp,-16
    80002818:	00113423          	sd	ra,8(sp)
    8000281c:	00813023          	sd	s0,0(sp)
    80002820:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002824:	00000097          	auipc	ra,0x0
    80002828:	2ec080e7          	jalr	748(ra) # 80002b10 <_ZN15MemoryAllocator5kfreeEPv>
}
    8000282c:	00813083          	ld	ra,8(sp)
    80002830:	00013403          	ld	s0,0(sp)
    80002834:	01010113          	addi	sp,sp,16
    80002838:	00008067          	ret

000000008000283c <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    8000283c:	ff010113          	addi	sp,sp,-16
    80002840:	00813423          	sd	s0,8(sp)
    80002844:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002848:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    8000284c:	05100513          	li	a0,81
    asm("ecall");
    80002850:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002854:	00050513          	mv	a0,a0
    return status;
    80002858:	0005051b          	sext.w	a0,a0
    8000285c:	00813403          	ld	s0,8(sp)
    80002860:	01010113          	addi	sp,sp,16
    80002864:	00008067          	ret

0000000080002868 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002868:	ff010113          	addi	sp,sp,-16
    8000286c:	00813423          	sd	s0,8(sp)
    80002870:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002874:	00009797          	auipc	a5,0x9
    80002878:	2347b783          	ld	a5,564(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000287c:	0007b603          	ld	a2,0(a5)
    80002880:	00c65793          	srli	a5,a2,0xc
    80002884:	00278793          	addi	a5,a5,2
    80002888:	00c79793          	slli	a5,a5,0xc
    8000288c:	01000737          	lui	a4,0x1000
    80002890:	00e787b3          	add	a5,a5,a4
    80002894:	00009717          	auipc	a4,0x9
    80002898:	49470713          	addi	a4,a4,1172 # 8000bd28 <_ZN15MemoryAllocator11freeMemTailE>
    8000289c:	00f73023          	sd	a5,0(a4)
    800028a0:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    800028a4:	0007b823          	sd	zero,16(a5)
    800028a8:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    800028ac:	00073823          	sd	zero,16(a4)
    800028b0:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    800028b4:	00009697          	auipc	a3,0x9
    800028b8:	27c6b683          	ld	a3,636(a3) # 8000bb30 <_GLOBAL_OFFSET_TABLE_+0xa0>
    800028bc:	0006b683          	ld	a3,0(a3)
    800028c0:	40c686b3          	sub	a3,a3,a2
    800028c4:	fe868693          	addi	a3,a3,-24
    800028c8:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800028cc:	00873783          	ld	a5,8(a4)
    800028d0:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800028d4:	00100793          	li	a5,1
    800028d8:	02f70023          	sb	a5,32(a4)
}
    800028dc:	00813403          	ld	s0,8(sp)
    800028e0:	01010113          	addi	sp,sp,16
    800028e4:	00008067          	ret

00000000800028e8 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800028e8:	ff010113          	addi	sp,sp,-16
    800028ec:	00813423          	sd	s0,8(sp)
    800028f0:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    800028f4:	14050263          	beqz	a0,80002a38 <_ZN15MemoryAllocator7kmallocEm+0x150>
    800028f8:	00050793          	mv	a5,a0
    800028fc:	00009517          	auipc	a0,0x9
    80002900:	43453503          	ld	a0,1076(a0) # 8000bd30 <_ZN15MemoryAllocator11freeMemHeadE>
    80002904:	0a050a63          	beqz	a0,800029b8 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002908:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    8000290c:	00000613          	li	a2,0
    80002910:	00c0006f          	j	8000291c <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002914:	00050613          	mv	a2,a0
    80002918:	01053503          	ld	a0,16(a0)
    8000291c:	00050863          	beqz	a0,8000292c <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002920:	00053683          	ld	a3,0(a0)
    80002924:	01878713          	addi	a4,a5,24
    80002928:	fee6e6e3          	bltu	a3,a4,80002914 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    8000292c:	08050663          	beqz	a0,800029b8 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80002930:	00053683          	ld	a3,0(a0)
    80002934:	01868713          	addi	a4,a3,24
    80002938:	00e50733          	add	a4,a0,a4
    8000293c:	00009597          	auipc	a1,0x9
    80002940:	1f45b583          	ld	a1,500(a1) # 8000bb30 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002944:	0005b583          	ld	a1,0(a1)
    80002948:	00b76463          	bltu	a4,a1,80002950 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    8000294c:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002950:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002954:	05700593          	li	a1,87
    80002958:	08d5f063          	bgeu	a1,a3,800029d8 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    8000295c:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002960:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002964:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002968:	01053583          	ld	a1,16(a0)
    8000296c:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002970:	00853583          	ld	a1,8(a0)
    80002974:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80002978:	fe868693          	addi	a3,a3,-24
    8000297c:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002980:	04060263          	beqz	a2,800029c4 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    80002984:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80002988:	00009797          	auipc	a5,0x9
    8000298c:	3b87b783          	ld	a5,952(a5) # 8000bd40 <_ZN15MemoryAllocator12allocMemHeadE>
    80002990:	06078463          	beqz	a5,800029f8 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002994:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80002998:	08070063          	beqz	a4,80002a18 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    8000299c:	00873783          	ld	a5,8(a4)
    800029a0:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    800029a4:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    800029a8:	00873783          	ld	a5,8(a4)
    800029ac:	06078063          	beqz	a5,80002a0c <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    800029b0:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    800029b4:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    800029b8:	00813403          	ld	s0,8(sp)
    800029bc:	01010113          	addi	sp,sp,16
    800029c0:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800029c4:	00009697          	auipc	a3,0x9
    800029c8:	36468693          	addi	a3,a3,868 # 8000bd28 <_ZN15MemoryAllocator11freeMemTailE>
    800029cc:	00f6b023          	sd	a5,0(a3)
    800029d0:	00f6b423          	sd	a5,8(a3)
    800029d4:	fb5ff06f          	j	80002988 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    800029d8:	00060863          	beqz	a2,800029e8 <_ZN15MemoryAllocator7kmallocEm+0x100>
    800029dc:	01053783          	ld	a5,16(a0)
    800029e0:	00f63823          	sd	a5,16(a2)
    800029e4:	fa5ff06f          	j	80002988 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    800029e8:	01053783          	ld	a5,16(a0)
    800029ec:	00009697          	auipc	a3,0x9
    800029f0:	34f6b223          	sd	a5,836(a3) # 8000bd30 <_ZN15MemoryAllocator11freeMemHeadE>
    800029f4:	f95ff06f          	j	80002988 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    800029f8:	00009797          	auipc	a5,0x9
    800029fc:	33078793          	addi	a5,a5,816 # 8000bd28 <_ZN15MemoryAllocator11freeMemTailE>
    80002a00:	00a7b823          	sd	a0,16(a5)
    80002a04:	00a7bc23          	sd	a0,24(a5)
    80002a08:	fadff06f          	j	800029b4 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    80002a0c:	00009797          	auipc	a5,0x9
    80002a10:	32a7ba23          	sd	a0,820(a5) # 8000bd40 <_ZN15MemoryAllocator12allocMemHeadE>
    80002a14:	fa1ff06f          	j	800029b4 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    80002a18:	00009797          	auipc	a5,0x9
    80002a1c:	31078793          	addi	a5,a5,784 # 8000bd28 <_ZN15MemoryAllocator11freeMemTailE>
    80002a20:	0107b703          	ld	a4,16(a5)
    80002a24:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002a28:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002a2c:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002a30:	00a7b823          	sd	a0,16(a5)
    80002a34:	f81ff06f          	j	800029b4 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80002a38:	00000513          	li	a0,0
    80002a3c:	f7dff06f          	j	800029b8 <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080002a40 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002a40:	ff010113          	addi	sp,sp,-16
    80002a44:	00813423          	sd	s0,8(sp)
    80002a48:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002a4c:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002a50:	00000713          	li	a4,0
    80002a54:	00078a63          	beqz	a5,80002a68 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002a58:	00a7f863          	bgeu	a5,a0,80002a68 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002a5c:	00078713          	mv	a4,a5
    80002a60:	0107b783          	ld	a5,16(a5)
    80002a64:	ff1ff06f          	j	80002a54 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80002a68:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002a6c:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002a70:	00078463          	beqz	a5,80002a78 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002a74:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80002a78:	02070263          	beqz	a4,80002a9c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002a7c:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002a80:	0005b703          	ld	a4,0(a1)
    80002a84:	00009797          	auipc	a5,0x9
    80002a88:	2ac7b783          	ld	a5,684(a5) # 8000bd30 <_ZN15MemoryAllocator11freeMemHeadE>
    80002a8c:	00f70c63          	beq	a4,a5,80002aa4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002a90:	00813403          	ld	s0,8(sp)
    80002a94:	01010113          	addi	sp,sp,16
    80002a98:	00008067          	ret
        *head = blk;
    80002a9c:	00a5b023          	sd	a0,0(a1)
    80002aa0:	fe1ff06f          	j	80002a80 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002aa4:	01053783          	ld	a5,16(a0)
    80002aa8:	00078a63          	beqz	a5,80002abc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002aac:	00053683          	ld	a3,0(a0)
    80002ab0:	00d50733          	add	a4,a0,a3
    80002ab4:	01870713          	addi	a4,a4,24
    80002ab8:	02f70e63          	beq	a4,a5,80002af4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80002abc:	00853783          	ld	a5,8(a0)
    80002ac0:	fc0788e3          	beqz	a5,80002a90 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002ac4:	0007b683          	ld	a3,0(a5)
    80002ac8:	00d78733          	add	a4,a5,a3
    80002acc:	01870713          	addi	a4,a4,24
    80002ad0:	fca710e3          	bne	a4,a0,80002a90 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002ad4:	00053703          	ld	a4,0(a0)
    80002ad8:	00e68733          	add	a4,a3,a4
    80002adc:	01870713          	addi	a4,a4,24
    80002ae0:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002ae4:	00853783          	ld	a5,8(a0)
    80002ae8:	01053703          	ld	a4,16(a0)
    80002aec:	00e7b823          	sd	a4,16(a5)
}
    80002af0:	fa1ff06f          	j	80002a90 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80002af4:	0007b703          	ld	a4,0(a5)
    80002af8:	00e68733          	add	a4,a3,a4
    80002afc:	01870713          	addi	a4,a4,24
    80002b00:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80002b04:	0107b783          	ld	a5,16(a5)
    80002b08:	00f53823          	sd	a5,16(a0)
    80002b0c:	fb1ff06f          	j	80002abc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002b10 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002b10:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002b14:	00009697          	auipc	a3,0x9
    80002b18:	22c6b683          	ld	a3,556(a3) # 8000bd40 <_ZN15MemoryAllocator12allocMemHeadE>
    80002b1c:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002b20:	00050a63          	beqz	a0,80002b34 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002b24:	fe870793          	addi	a5,a4,-24
    80002b28:	00a78663          	beq	a5,a0,80002b34 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002b2c:	01053503          	ld	a0,16(a0)
    80002b30:	ff1ff06f          	j	80002b20 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002b34:	08050463          	beqz	a0,80002bbc <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80002b38:	ff010113          	addi	sp,sp,-16
    80002b3c:	00113423          	sd	ra,8(sp)
    80002b40:	00813023          	sd	s0,0(sp)
    80002b44:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80002b48:	00009797          	auipc	a5,0x9
    80002b4c:	1f07b783          	ld	a5,496(a5) # 8000bd38 <_ZN15MemoryAllocator12allocMemTailE>
    80002b50:	04a78663          	beq	a5,a0,80002b9c <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002b54:	04d50c63          	beq	a0,a3,80002bac <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002b58:	01053783          	ld	a5,16(a0)
    80002b5c:	00078663          	beqz	a5,80002b68 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002b60:	00853703          	ld	a4,8(a0)
    80002b64:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80002b68:	00853783          	ld	a5,8(a0)
    80002b6c:	00078663          	beqz	a5,80002b78 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002b70:	01053703          	ld	a4,16(a0)
    80002b74:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80002b78:	00009597          	auipc	a1,0x9
    80002b7c:	1b858593          	addi	a1,a1,440 # 8000bd30 <_ZN15MemoryAllocator11freeMemHeadE>
    80002b80:	00000097          	auipc	ra,0x0
    80002b84:	ec0080e7          	jalr	-320(ra) # 80002a40 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80002b88:	00000513          	li	a0,0
}
    80002b8c:	00813083          	ld	ra,8(sp)
    80002b90:	00013403          	ld	s0,0(sp)
    80002b94:	01010113          	addi	sp,sp,16
    80002b98:	00008067          	ret
            allocMemTail = blk->prev;
    80002b9c:	00853783          	ld	a5,8(a0)
    80002ba0:	00009717          	auipc	a4,0x9
    80002ba4:	18f73c23          	sd	a5,408(a4) # 8000bd38 <_ZN15MemoryAllocator12allocMemTailE>
    80002ba8:	fadff06f          	j	80002b54 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002bac:	01053783          	ld	a5,16(a0)
    80002bb0:	00009717          	auipc	a4,0x9
    80002bb4:	18f73823          	sd	a5,400(a4) # 8000bd40 <_ZN15MemoryAllocator12allocMemHeadE>
    80002bb8:	fa1ff06f          	j	80002b58 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80002bbc:	fff00513          	li	a0,-1
}
    80002bc0:	00008067          	ret

0000000080002bc4 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002bc4:	fe010113          	addi	sp,sp,-32
    80002bc8:	00113c23          	sd	ra,24(sp)
    80002bcc:	00813823          	sd	s0,16(sp)
    80002bd0:	00913423          	sd	s1,8(sp)
    80002bd4:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002bd8:	00009497          	auipc	s1,0x9
    80002bdc:	1684b483          	ld	s1,360(s1) # 8000bd40 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002be0:	00006517          	auipc	a0,0x6
    80002be4:	54050513          	addi	a0,a0,1344 # 80009120 <CONSOLE_STATUS+0x110>
    80002be8:	fffff097          	auipc	ra,0xfffff
    80002bec:	494080e7          	jalr	1172(ra) # 8000207c <_Z11printStringPKc>
    while(iter!=nullptr){
    80002bf0:	04048663          	beqz	s1,80002c3c <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002bf4:	00000613          	li	a2,0
    80002bf8:	00a00593          	li	a1,10
    80002bfc:	0004851b          	sext.w	a0,s1
    80002c00:	fffff097          	auipc	ra,0xfffff
    80002c04:	614080e7          	jalr	1556(ra) # 80002214 <_Z8printIntiii>
        putc(' ');
    80002c08:	02000513          	li	a0,32
    80002c0c:	fffff097          	auipc	ra,0xfffff
    80002c10:	cc8080e7          	jalr	-824(ra) # 800018d4 <_Z4putcc>
        printInt(iter->size);
    80002c14:	00000613          	li	a2,0
    80002c18:	00a00593          	li	a1,10
    80002c1c:	0004a503          	lw	a0,0(s1)
    80002c20:	fffff097          	auipc	ra,0xfffff
    80002c24:	5f4080e7          	jalr	1524(ra) # 80002214 <_Z8printIntiii>
        putc('\n');
    80002c28:	00a00513          	li	a0,10
    80002c2c:	fffff097          	auipc	ra,0xfffff
    80002c30:	ca8080e7          	jalr	-856(ra) # 800018d4 <_Z4putcc>
        iter=iter->next;
    80002c34:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002c38:	fb9ff06f          	j	80002bf0 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002c3c:	00006517          	auipc	a0,0x6
    80002c40:	50450513          	addi	a0,a0,1284 # 80009140 <CONSOLE_STATUS+0x130>
    80002c44:	fffff097          	auipc	ra,0xfffff
    80002c48:	438080e7          	jalr	1080(ra) # 8000207c <_Z11printStringPKc>
    iter = freeMemHead;
    80002c4c:	00009497          	auipc	s1,0x9
    80002c50:	0e44b483          	ld	s1,228(s1) # 8000bd30 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002c54:	04048663          	beqz	s1,80002ca0 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002c58:	00000613          	li	a2,0
    80002c5c:	00a00593          	li	a1,10
    80002c60:	0004851b          	sext.w	a0,s1
    80002c64:	fffff097          	auipc	ra,0xfffff
    80002c68:	5b0080e7          	jalr	1456(ra) # 80002214 <_Z8printIntiii>
        putc(' ');
    80002c6c:	02000513          	li	a0,32
    80002c70:	fffff097          	auipc	ra,0xfffff
    80002c74:	c64080e7          	jalr	-924(ra) # 800018d4 <_Z4putcc>
        printInt(iter->size);
    80002c78:	00000613          	li	a2,0
    80002c7c:	00a00593          	li	a1,10
    80002c80:	0004a503          	lw	a0,0(s1)
    80002c84:	fffff097          	auipc	ra,0xfffff
    80002c88:	590080e7          	jalr	1424(ra) # 80002214 <_Z8printIntiii>
        putc('\n');
    80002c8c:	00a00513          	li	a0,10
    80002c90:	fffff097          	auipc	ra,0xfffff
    80002c94:	c44080e7          	jalr	-956(ra) # 800018d4 <_Z4putcc>
        iter=iter->next;
    80002c98:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002c9c:	fb9ff06f          	j	80002c54 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002ca0:	00006517          	auipc	a0,0x6
    80002ca4:	4c050513          	addi	a0,a0,1216 # 80009160 <CONSOLE_STATUS+0x150>
    80002ca8:	fffff097          	auipc	ra,0xfffff
    80002cac:	3d4080e7          	jalr	980(ra) # 8000207c <_Z11printStringPKc>
}
    80002cb0:	01813083          	ld	ra,24(sp)
    80002cb4:	01013403          	ld	s0,16(sp)
    80002cb8:	00813483          	ld	s1,8(sp)
    80002cbc:	02010113          	addi	sp,sp,32
    80002cc0:	00008067          	ret

0000000080002cc4 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80002cc4:	ff010113          	addi	sp,sp,-16
    80002cc8:	00813423          	sd	s0,8(sp)
    80002ccc:	01010413          	addi	s0,sp,16
    80002cd0:	00050813          	mv	a6,a0
    80002cd4:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002cd8:	00000793          	li	a5,0
    80002cdc:	00c7fe63          	bgeu	a5,a2,80002cf8 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80002ce0:	00f50733          	add	a4,a0,a5
    80002ce4:	00f806b3          	add	a3,a6,a5
    80002ce8:	0006c683          	lbu	a3,0(a3)
    80002cec:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80002cf0:	00178793          	addi	a5,a5,1
    80002cf4:	fe9ff06f          	j	80002cdc <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80002cf8:	00813403          	ld	s0,8(sp)
    80002cfc:	01010113          	addi	sp,sp,16
    80002d00:	00008067          	ret

0000000080002d04 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    80002d04:	ff010113          	addi	sp,sp,-16
    80002d08:	00113423          	sd	ra,8(sp)
    80002d0c:	00813023          	sd	s0,0(sp)
    80002d10:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80002d14:	00053783          	ld	a5,0(a0)
    80002d18:	0107b783          	ld	a5,16(a5)
    80002d1c:	000780e7          	jalr	a5
}
    80002d20:	00813083          	ld	ra,8(sp)
    80002d24:	00013403          	ld	s0,0(sp)
    80002d28:	01010113          	addi	sp,sp,16
    80002d2c:	00008067          	ret

0000000080002d30 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80002d30:	ff010113          	addi	sp,sp,-16
    80002d34:	00113423          	sd	ra,8(sp)
    80002d38:	00813023          	sd	s0,0(sp)
    80002d3c:	01010413          	addi	s0,sp,16
    80002d40:	00009797          	auipc	a5,0x9
    80002d44:	c2878793          	addi	a5,a5,-984 # 8000b968 <_ZTV9Semaphore+0x10>
    80002d48:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002d4c:	00853503          	ld	a0,8(a0)
    80002d50:	fffff097          	auipc	ra,0xfffff
    80002d54:	aac080e7          	jalr	-1364(ra) # 800017fc <_Z9sem_closeP10_semaphore>
};
    80002d58:	00813083          	ld	ra,8(sp)
    80002d5c:	00013403          	ld	s0,0(sp)
    80002d60:	01010113          	addi	sp,sp,16
    80002d64:	00008067          	ret

0000000080002d68 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80002d68:	00009797          	auipc	a5,0x9
    80002d6c:	c2078793          	addi	a5,a5,-992 # 8000b988 <_ZTV6Thread+0x10>
    80002d70:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002d74:	00853503          	ld	a0,8(a0)
    80002d78:	02050663          	beqz	a0,80002da4 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80002d7c:	ff010113          	addi	sp,sp,-16
    80002d80:	00113423          	sd	ra,8(sp)
    80002d84:	00813023          	sd	s0,0(sp)
    80002d88:	01010413          	addi	s0,sp,16
    delete myHandle;
    80002d8c:	fffff097          	auipc	ra,0xfffff
    80002d90:	bbc080e7          	jalr	-1092(ra) # 80001948 <_ZN7_threaddlEPv>
}
    80002d94:	00813083          	ld	ra,8(sp)
    80002d98:	00013403          	ld	s0,0(sp)
    80002d9c:	01010113          	addi	sp,sp,16
    80002da0:	00008067          	ret
    80002da4:	00008067          	ret

0000000080002da8 <_Znwm>:
void* operator new(size_t sz){
    80002da8:	ff010113          	addi	sp,sp,-16
    80002dac:	00113423          	sd	ra,8(sp)
    80002db0:	00813023          	sd	s0,0(sp)
    80002db4:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80002db8:	fffff097          	auipc	ra,0xfffff
    80002dbc:	844080e7          	jalr	-1980(ra) # 800015fc <_Z9mem_allocm>
}
    80002dc0:	00813083          	ld	ra,8(sp)
    80002dc4:	00013403          	ld	s0,0(sp)
    80002dc8:	01010113          	addi	sp,sp,16
    80002dcc:	00008067          	ret

0000000080002dd0 <_Znam>:
void* operator new[](size_t sz){
    80002dd0:	ff010113          	addi	sp,sp,-16
    80002dd4:	00113423          	sd	ra,8(sp)
    80002dd8:	00813023          	sd	s0,0(sp)
    80002ddc:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80002de0:	fffff097          	auipc	ra,0xfffff
    80002de4:	81c080e7          	jalr	-2020(ra) # 800015fc <_Z9mem_allocm>
}
    80002de8:	00813083          	ld	ra,8(sp)
    80002dec:	00013403          	ld	s0,0(sp)
    80002df0:	01010113          	addi	sp,sp,16
    80002df4:	00008067          	ret

0000000080002df8 <_ZdlPv>:
void operator delete(void *ptr){
    80002df8:	ff010113          	addi	sp,sp,-16
    80002dfc:	00113423          	sd	ra,8(sp)
    80002e00:	00813023          	sd	s0,0(sp)
    80002e04:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002e08:	fffff097          	auipc	ra,0xfffff
    80002e0c:	824080e7          	jalr	-2012(ra) # 8000162c <_Z8mem_freePv>
}
    80002e10:	00813083          	ld	ra,8(sp)
    80002e14:	00013403          	ld	s0,0(sp)
    80002e18:	01010113          	addi	sp,sp,16
    80002e1c:	00008067          	ret

0000000080002e20 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80002e20:	fe010113          	addi	sp,sp,-32
    80002e24:	00113c23          	sd	ra,24(sp)
    80002e28:	00813823          	sd	s0,16(sp)
    80002e2c:	00913423          	sd	s1,8(sp)
    80002e30:	02010413          	addi	s0,sp,32
    80002e34:	00050493          	mv	s1,a0
};
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	ef8080e7          	jalr	-264(ra) # 80002d30 <_ZN9SemaphoreD1Ev>
    80002e40:	00048513          	mv	a0,s1
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	fb4080e7          	jalr	-76(ra) # 80002df8 <_ZdlPv>
    80002e4c:	01813083          	ld	ra,24(sp)
    80002e50:	01013403          	ld	s0,16(sp)
    80002e54:	00813483          	ld	s1,8(sp)
    80002e58:	02010113          	addi	sp,sp,32
    80002e5c:	00008067          	ret

0000000080002e60 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002e60:	fe010113          	addi	sp,sp,-32
    80002e64:	00113c23          	sd	ra,24(sp)
    80002e68:	00813823          	sd	s0,16(sp)
    80002e6c:	00913423          	sd	s1,8(sp)
    80002e70:	02010413          	addi	s0,sp,32
    80002e74:	00050493          	mv	s1,a0
}
    80002e78:	00000097          	auipc	ra,0x0
    80002e7c:	ef0080e7          	jalr	-272(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80002e80:	00048513          	mv	a0,s1
    80002e84:	00000097          	auipc	ra,0x0
    80002e88:	f74080e7          	jalr	-140(ra) # 80002df8 <_ZdlPv>
    80002e8c:	01813083          	ld	ra,24(sp)
    80002e90:	01013403          	ld	s0,16(sp)
    80002e94:	00813483          	ld	s1,8(sp)
    80002e98:	02010113          	addi	sp,sp,32
    80002e9c:	00008067          	ret

0000000080002ea0 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002ea0:	ff010113          	addi	sp,sp,-16
    80002ea4:	00113423          	sd	ra,8(sp)
    80002ea8:	00813023          	sd	s0,0(sp)
    80002eac:	01010413          	addi	s0,sp,16
    80002eb0:	00009797          	auipc	a5,0x9
    80002eb4:	ab878793          	addi	a5,a5,-1352 # 8000b968 <_ZTV9Semaphore+0x10>
    80002eb8:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80002ebc:	00850513          	addi	a0,a0,8
    80002ec0:	fffff097          	auipc	ra,0xfffff
    80002ec4:	904080e7          	jalr	-1788(ra) # 800017c4 <_Z8sem_openPP10_semaphorej>
}
    80002ec8:	00813083          	ld	ra,8(sp)
    80002ecc:	00013403          	ld	s0,0(sp)
    80002ed0:	01010113          	addi	sp,sp,16
    80002ed4:	00008067          	ret

0000000080002ed8 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80002ed8:	ff010113          	addi	sp,sp,-16
    80002edc:	00113423          	sd	ra,8(sp)
    80002ee0:	00813023          	sd	s0,0(sp)
    80002ee4:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002ee8:	00853503          	ld	a0,8(a0)
    80002eec:	fffff097          	auipc	ra,0xfffff
    80002ef0:	93c080e7          	jalr	-1732(ra) # 80001828 <_Z8sem_waitP10_semaphore>
}
    80002ef4:	00813083          	ld	ra,8(sp)
    80002ef8:	00013403          	ld	s0,0(sp)
    80002efc:	01010113          	addi	sp,sp,16
    80002f00:	00008067          	ret

0000000080002f04 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002f04:	ff010113          	addi	sp,sp,-16
    80002f08:	00113423          	sd	ra,8(sp)
    80002f0c:	00813023          	sd	s0,0(sp)
    80002f10:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002f14:	00853503          	ld	a0,8(a0)
    80002f18:	fffff097          	auipc	ra,0xfffff
    80002f1c:	93c080e7          	jalr	-1732(ra) # 80001854 <_Z10sem_signalP10_semaphore>
}
    80002f20:	00813083          	ld	ra,8(sp)
    80002f24:	00013403          	ld	s0,0(sp)
    80002f28:	01010113          	addi	sp,sp,16
    80002f2c:	00008067          	ret

0000000080002f30 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80002f30:	ff010113          	addi	sp,sp,-16
    80002f34:	00113423          	sd	ra,8(sp)
    80002f38:	00813023          	sd	s0,0(sp)
    80002f3c:	01010413          	addi	s0,sp,16
    80002f40:	00009797          	auipc	a5,0x9
    80002f44:	a4878793          	addi	a5,a5,-1464 # 8000b988 <_ZTV6Thread+0x10>
    80002f48:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80002f4c:	00850513          	addi	a0,a0,8
    80002f50:	ffffe097          	auipc	ra,0xffffe
    80002f54:	7cc080e7          	jalr	1996(ra) # 8000171c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002f58:	00813083          	ld	ra,8(sp)
    80002f5c:	00013403          	ld	s0,0(sp)
    80002f60:	01010113          	addi	sp,sp,16
    80002f64:	00008067          	ret

0000000080002f68 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002f68:	ff010113          	addi	sp,sp,-16
    80002f6c:	00113423          	sd	ra,8(sp)
    80002f70:	00813023          	sd	s0,0(sp)
    80002f74:	01010413          	addi	s0,sp,16
    80002f78:	00009797          	auipc	a5,0x9
    80002f7c:	a1078793          	addi	a5,a5,-1520 # 8000b988 <_ZTV6Thread+0x10>
    80002f80:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    80002f84:	00050613          	mv	a2,a0
    80002f88:	00000597          	auipc	a1,0x0
    80002f8c:	d7c58593          	addi	a1,a1,-644 # 80002d04 <_ZN6Thread7wrapperEPv>
    80002f90:	00850513          	addi	a0,a0,8
    80002f94:	ffffe097          	auipc	ra,0xffffe
    80002f98:	788080e7          	jalr	1928(ra) # 8000171c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002f9c:	00813083          	ld	ra,8(sp)
    80002fa0:	00013403          	ld	s0,0(sp)
    80002fa4:	01010113          	addi	sp,sp,16
    80002fa8:	00008067          	ret

0000000080002fac <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80002fac:	ff010113          	addi	sp,sp,-16
    80002fb0:	00113423          	sd	ra,8(sp)
    80002fb4:	00813023          	sd	s0,0(sp)
    80002fb8:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80002fbc:	fffff097          	auipc	ra,0xfffff
    80002fc0:	8c4080e7          	jalr	-1852(ra) # 80001880 <_Z10time_sleepm>
}
    80002fc4:	00813083          	ld	ra,8(sp)
    80002fc8:	00013403          	ld	s0,0(sp)
    80002fcc:	01010113          	addi	sp,sp,16
    80002fd0:	00008067          	ret

0000000080002fd4 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80002fd4:	fe010113          	addi	sp,sp,-32
    80002fd8:	00113c23          	sd	ra,24(sp)
    80002fdc:	00813823          	sd	s0,16(sp)
    80002fe0:	00913423          	sd	s1,8(sp)
    80002fe4:	01213023          	sd	s2,0(sp)
    80002fe8:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80002fec:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80002ff0:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80002ff4:	0004b783          	ld	a5,0(s1)
    80002ff8:	0187b783          	ld	a5,24(a5)
    80002ffc:	00048513          	mv	a0,s1
    80003000:	000780e7          	jalr	a5
        pt->sleep(time);
    80003004:	00090513          	mv	a0,s2
    80003008:	00000097          	auipc	ra,0x0
    8000300c:	fa4080e7          	jalr	-92(ra) # 80002fac <_ZN6Thread5sleepEm>
    while(true){
    80003010:	fe5ff06f          	j	80002ff4 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080003014 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003014:	ff010113          	addi	sp,sp,-16
    80003018:	00113423          	sd	ra,8(sp)
    8000301c:	00813023          	sd	s0,0(sp)
    80003020:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003024:	ffffe097          	auipc	ra,0xffffe
    80003028:	6d8080e7          	jalr	1752(ra) # 800016fc <_Z15thread_dispatchv>
}
    8000302c:	00813083          	ld	ra,8(sp)
    80003030:	00013403          	ld	s0,0(sp)
    80003034:	01010113          	addi	sp,sp,16
    80003038:	00008067          	ret

000000008000303c <_ZN6Thread5startEv>:
int Thread::start() {
    8000303c:	ff010113          	addi	sp,sp,-16
    80003040:	00113423          	sd	ra,8(sp)
    80003044:	00813023          	sd	s0,0(sp)
    80003048:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000304c:	00853503          	ld	a0,8(a0)
    80003050:	ffffe097          	auipc	ra,0xffffe
    80003054:	748080e7          	jalr	1864(ra) # 80001798 <_Z12thread_startP7_thread>
}
    80003058:	00813083          	ld	ra,8(sp)
    8000305c:	00013403          	ld	s0,0(sp)
    80003060:	01010113          	addi	sp,sp,16
    80003064:	00008067          	ret

0000000080003068 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003068:	fe010113          	addi	sp,sp,-32
    8000306c:	00113c23          	sd	ra,24(sp)
    80003070:	00813823          	sd	s0,16(sp)
    80003074:	00913423          	sd	s1,8(sp)
    80003078:	01213023          	sd	s2,0(sp)
    8000307c:	02010413          	addi	s0,sp,32
    80003080:	00050493          	mv	s1,a0
    80003084:	00058913          	mv	s2,a1
    80003088:	01000513          	li	a0,16
    8000308c:	00000097          	auipc	ra,0x0
    80003090:	d1c080e7          	jalr	-740(ra) # 80002da8 <_Znwm>
    80003094:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003098:	00953023          	sd	s1,0(a0)
    8000309c:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800030a0:	00000597          	auipc	a1,0x0
    800030a4:	f3458593          	addi	a1,a1,-204 # 80002fd4 <_ZN14PeriodicThread7wrapperEPv>
    800030a8:	00048513          	mv	a0,s1
    800030ac:	00000097          	auipc	ra,0x0
    800030b0:	e84080e7          	jalr	-380(ra) # 80002f30 <_ZN6ThreadC1EPFvPvES0_>
    800030b4:	00009797          	auipc	a5,0x9
    800030b8:	88478793          	addi	a5,a5,-1916 # 8000b938 <_ZTV14PeriodicThread+0x10>
    800030bc:	00f4b023          	sd	a5,0(s1)
    800030c0:	01813083          	ld	ra,24(sp)
    800030c4:	01013403          	ld	s0,16(sp)
    800030c8:	00813483          	ld	s1,8(sp)
    800030cc:	00013903          	ld	s2,0(sp)
    800030d0:	02010113          	addi	sp,sp,32
    800030d4:	00008067          	ret

00000000800030d8 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    800030d8:	ff010113          	addi	sp,sp,-16
    800030dc:	00113423          	sd	ra,8(sp)
    800030e0:	00813023          	sd	s0,0(sp)
    800030e4:	01010413          	addi	s0,sp,16
    return ::getc();
    800030e8:	ffffe097          	auipc	ra,0xffffe
    800030ec:	7c4080e7          	jalr	1988(ra) # 800018ac <_Z4getcv>
}
    800030f0:	00813083          	ld	ra,8(sp)
    800030f4:	00013403          	ld	s0,0(sp)
    800030f8:	01010113          	addi	sp,sp,16
    800030fc:	00008067          	ret

0000000080003100 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003100:	ff010113          	addi	sp,sp,-16
    80003104:	00113423          	sd	ra,8(sp)
    80003108:	00813023          	sd	s0,0(sp)
    8000310c:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003110:	ffffe097          	auipc	ra,0xffffe
    80003114:	7c4080e7          	jalr	1988(ra) # 800018d4 <_Z4putcc>
}
    80003118:	00813083          	ld	ra,8(sp)
    8000311c:	00013403          	ld	s0,0(sp)
    80003120:	01010113          	addi	sp,sp,16
    80003124:	00008067          	ret

0000000080003128 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003128:	ff010113          	addi	sp,sp,-16
    8000312c:	00813423          	sd	s0,8(sp)
    80003130:	01010413          	addi	s0,sp,16
    80003134:	00813403          	ld	s0,8(sp)
    80003138:	01010113          	addi	sp,sp,16
    8000313c:	00008067          	ret

0000000080003140 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00813423          	sd	s0,8(sp)
    80003148:	01010413          	addi	s0,sp,16
    8000314c:	00813403          	ld	s0,8(sp)
    80003150:	01010113          	addi	sp,sp,16
    80003154:	00008067          	ret

0000000080003158 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003158:	ff010113          	addi	sp,sp,-16
    8000315c:	00113423          	sd	ra,8(sp)
    80003160:	00813023          	sd	s0,0(sp)
    80003164:	01010413          	addi	s0,sp,16
    80003168:	00008797          	auipc	a5,0x8
    8000316c:	7d078793          	addi	a5,a5,2000 # 8000b938 <_ZTV14PeriodicThread+0x10>
    80003170:	00f53023          	sd	a5,0(a0)
    80003174:	00000097          	auipc	ra,0x0
    80003178:	bf4080e7          	jalr	-1036(ra) # 80002d68 <_ZN6ThreadD1Ev>
    8000317c:	00813083          	ld	ra,8(sp)
    80003180:	00013403          	ld	s0,0(sp)
    80003184:	01010113          	addi	sp,sp,16
    80003188:	00008067          	ret

000000008000318c <_ZN14PeriodicThreadD0Ev>:
    8000318c:	fe010113          	addi	sp,sp,-32
    80003190:	00113c23          	sd	ra,24(sp)
    80003194:	00813823          	sd	s0,16(sp)
    80003198:	00913423          	sd	s1,8(sp)
    8000319c:	02010413          	addi	s0,sp,32
    800031a0:	00050493          	mv	s1,a0
    800031a4:	00008797          	auipc	a5,0x8
    800031a8:	79478793          	addi	a5,a5,1940 # 8000b938 <_ZTV14PeriodicThread+0x10>
    800031ac:	00f53023          	sd	a5,0(a0)
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	bb8080e7          	jalr	-1096(ra) # 80002d68 <_ZN6ThreadD1Ev>
    800031b8:	00048513          	mv	a0,s1
    800031bc:	00000097          	auipc	ra,0x0
    800031c0:	c3c080e7          	jalr	-964(ra) # 80002df8 <_ZdlPv>
    800031c4:	01813083          	ld	ra,24(sp)
    800031c8:	01013403          	ld	s0,16(sp)
    800031cc:	00813483          	ld	s1,8(sp)
    800031d0:	02010113          	addi	sp,sp,32
    800031d4:	00008067          	ret

00000000800031d8 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    800031d8:	ff010113          	addi	sp,sp,-16
    800031dc:	00113423          	sd	ra,8(sp)
    800031e0:	00813023          	sd	s0,0(sp)
    800031e4:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    800031e8:	00009797          	auipc	a5,0x9
    800031ec:	9187b783          	ld	a5,-1768(a5) # 8000bb00 <_GLOBAL_OFFSET_TABLE_+0x70>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    800031f0:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    800031f4:	fffff097          	auipc	ra,0xfffff
    800031f8:	674080e7          	jalr	1652(ra) # 80002868 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    800031fc:	00001097          	auipc	ra,0x1
    80003200:	ef4080e7          	jalr	-268(ra) # 800040f0 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003204:	fffff097          	auipc	ra,0xfffff
    80003208:	544080e7          	jalr	1348(ra) # 80002748 <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    8000320c:	00001097          	auipc	ra,0x1
    80003210:	0f8080e7          	jalr	248(ra) # 80004304 <_ZN11ConsoleUtil10initializeEv>
    SlabAllocator::initialize(BUDDY_START_ADDR_CONST, 4096);
    80003214:	00009797          	auipc	a5,0x9
    80003218:	8947b783          	ld	a5,-1900(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000321c:	0007b503          	ld	a0,0(a5)
    80003220:	00c55513          	srli	a0,a0,0xc
    80003224:	00250513          	addi	a0,a0,2
    80003228:	000015b7          	lui	a1,0x1
    8000322c:	00c51513          	slli	a0,a0,0xc
    80003230:	ffffe097          	auipc	ra,0xffffe
    80003234:	334080e7          	jalr	820(ra) # 80001564 <_ZN13SlabAllocator10initializeEPvm>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003238:	00200793          	li	a5,2
    8000323c:	1047a073          	csrs	sie,a5
    80003240:	20000713          	li	a4,512
    80003244:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003248:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    8000324c:	00813083          	ld	ra,8(sp)
    80003250:	00013403          	ld	s0,0(sp)
    80003254:	01010113          	addi	sp,sp,16
    80003258:	00008067          	ret

000000008000325c <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    8000325c:	ff010113          	addi	sp,sp,-16
    80003260:	00813423          	sd	s0,8(sp)
    80003264:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003268:	14109073          	csrw	sepc,ra
    asm("sret");
    8000326c:	10200073          	sret
}
    80003270:	00813403          	ld	s0,8(sp)
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00008067          	ret

000000008000327c <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    8000327c:	ff010113          	addi	sp,sp,-16
    80003280:	00113423          	sd	ra,8(sp)
    80003284:	00813023          	sd	s0,0(sp)
    80003288:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    8000328c:	00009797          	auipc	a5,0x9
    80003290:	8947b783          	ld	a5,-1900(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003294:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003298:	00100713          	li	a4,1
    8000329c:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800032a0:	fffff097          	auipc	ra,0xfffff
    800032a4:	400080e7          	jalr	1024(ra) # 800026a0 <_ZN3TCB8dispatchEv>
}
    800032a8:	00813083          	ld	ra,8(sp)
    800032ac:	00013403          	ld	s0,0(sp)
    800032b0:	01010113          	addi	sp,sp,16
    800032b4:	00008067          	ret

00000000800032b8 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    800032b8:	ff010113          	addi	sp,sp,-16
    800032bc:	00113423          	sd	ra,8(sp)
    800032c0:	00813023          	sd	s0,0(sp)
    800032c4:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    800032c8:	00009797          	auipc	a5,0x9
    800032cc:	a887c783          	lbu	a5,-1400(a5) # 8000bd50 <_ZN5RiscV16userMainFinishedE>
    800032d0:	00079c63          	bnez	a5,800032e8 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    800032d4:	00009717          	auipc	a4,0x9
    800032d8:	84473703          	ld	a4,-1980(a4) # 8000bb18 <_GLOBAL_OFFSET_TABLE_+0x88>
    800032dc:	00073783          	ld	a5,0(a4)
    800032e0:	00178793          	addi	a5,a5,1
    800032e4:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    800032e8:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    800032ec:	0ff57513          	andi	a0,a0,255
    800032f0:	00001097          	auipc	ra,0x1
    800032f4:	1a4080e7          	jalr	420(ra) # 80004494 <_ZN11ConsoleUtil9putOutputEc>
}
    800032f8:	00813083          	ld	ra,8(sp)
    800032fc:	00013403          	ld	s0,0(sp)
    80003300:	01010113          	addi	sp,sp,16
    80003304:	00008067          	ret

0000000080003308 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003308:	fe010113          	addi	sp,sp,-32
    8000330c:	00113c23          	sd	ra,24(sp)
    80003310:	00813823          	sd	s0,16(sp)
    80003314:	02010413          	addi	s0,sp,32
    80003318:	00c0006f          	j	80003324 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    8000331c:	ffffe097          	auipc	ra,0xffffe
    80003320:	3e0080e7          	jalr	992(ra) # 800016fc <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003324:	00008797          	auipc	a5,0x8
    80003328:	77c7b783          	ld	a5,1916(a5) # 8000baa0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000332c:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003330:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003334:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003338:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    8000333c:	0207f793          	andi	a5,a5,32
    80003340:	fc078ee3          	beqz	a5,8000331c <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003344:	00001097          	auipc	ra,0x1
    80003348:	3c8080e7          	jalr	968(ra) # 8000470c <_ZN11ConsoleUtil15putcUtilSyscallEv>
    8000334c:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003350:	00008797          	auipc	a5,0x8
    80003354:	7487b783          	ld	a5,1864(a5) # 8000ba98 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003358:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    8000335c:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003360:	fef44783          	lbu	a5,-17(s0)
    80003364:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003368:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    8000336c:	00008797          	auipc	a5,0x8
    80003370:	7ac7b783          	ld	a5,1964(a5) # 8000bb18 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003374:	0007b783          	ld	a5,0(a5)
    80003378:	fa0786e3          	beqz	a5,80003324 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    8000337c:	fff78793          	addi	a5,a5,-1
    80003380:	00008717          	auipc	a4,0x8
    80003384:	79873703          	ld	a4,1944(a4) # 8000bb18 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003388:	00f73023          	sd	a5,0(a4)
    8000338c:	f99ff06f          	j	80003324 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003390 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003390:	ff010113          	addi	sp,sp,-16
    80003394:	00813423          	sd	s0,8(sp)
    80003398:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    8000339c:	00008797          	auipc	a5,0x8
    800033a0:	7847b783          	ld	a5,1924(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    800033a4:	0007b783          	ld	a5,0(a5)
    800033a8:	0147a703          	lw	a4,20(a5)
    800033ac:	00100793          	li	a5,1
    800033b0:	00f70c63          	beq	a4,a5,800033c8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    800033b4:	10000793          	li	a5,256
    800033b8:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    800033bc:	00813403          	ld	s0,8(sp)
    800033c0:	01010113          	addi	sp,sp,16
    800033c4:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800033c8:	10000793          	li	a5,256
    800033cc:	1007a073          	csrs	sstatus,a5
}
    800033d0:	fedff06f          	j	800033bc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

00000000800033d4 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    800033d4:	ff010113          	addi	sp,sp,-16
    800033d8:	00113423          	sd	ra,8(sp)
    800033dc:	00813023          	sd	s0,0(sp)
    800033e0:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    800033e4:	00100793          	li	a5,1
    800033e8:	00009717          	auipc	a4,0x9
    800033ec:	96f70423          	sb	a5,-1688(a4) # 8000bd50 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    800033f0:	00008797          	auipc	a5,0x8
    800033f4:	7287b783          	ld	a5,1832(a5) # 8000bb18 <_GLOBAL_OFFSET_TABLE_+0x88>
    800033f8:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    800033fc:	00008797          	auipc	a5,0x8
    80003400:	6cc7b783          	ld	a5,1740(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003404:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003408:	00200793          	li	a5,2
    8000340c:	1047b073          	csrc	sie,a5
    80003410:	20000793          	li	a5,512
    80003414:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003418:	00008797          	auipc	a5,0x8
    8000341c:	6d87b783          	ld	a5,1752(a5) # 8000baf0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003420:	0007b783          	ld	a5,0(a5)
    80003424:	00078c63          	beqz	a5,8000343c <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003428:	0487b703          	ld	a4,72(a5)
    8000342c:	00008797          	auipc	a5,0x8
    80003430:	6c47b783          	ld	a5,1732(a5) # 8000baf0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003434:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003438:	fe1ff06f          	j	80003418 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    8000343c:	00008797          	auipc	a5,0x8
    80003440:	6bc7b783          	ld	a5,1724(a5) # 8000baf8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003444:	0007b503          	ld	a0,0(a5)
    80003448:	00001097          	auipc	ra,0x1
    8000344c:	cc0080e7          	jalr	-832(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003450:	00008797          	auipc	a5,0x8
    80003454:	6b87b783          	ld	a5,1720(a5) # 8000bb08 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003458:	0007b703          	ld	a4,0(a5)
    8000345c:	00008797          	auipc	a5,0x8
    80003460:	6b47b783          	ld	a5,1716(a5) # 8000bb10 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003464:	0007b783          	ld	a5,0(a5)
    80003468:	00f70863          	beq	a4,a5,80003478 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    8000346c:	ffffe097          	auipc	ra,0xffffe
    80003470:	290080e7          	jalr	656(ra) # 800016fc <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003474:	fddff06f          	j	80003450 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003478:	00813083          	ld	ra,8(sp)
    8000347c:	00013403          	ld	s0,0(sp)
    80003480:	01010113          	addi	sp,sp,16
    80003484:	00008067          	ret

0000000080003488 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003488:	ff010113          	addi	sp,sp,-16
    8000348c:	00813423          	sd	s0,8(sp)
    80003490:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003494:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003498:	00008717          	auipc	a4,0x8
    8000349c:	68873703          	ld	a4,1672(a4) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    800034a0:	00073703          	ld	a4,0(a4)
    800034a4:	06873703          	ld	a4,104(a4)
    800034a8:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800034ac:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800034b0:	00078593          	mv	a1,a5
}
    800034b4:	00813403          	ld	s0,8(sp)
    800034b8:	01010113          	addi	sp,sp,16
    800034bc:	00008067          	ret

00000000800034c0 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800034c0:	ff010113          	addi	sp,sp,-16
    800034c4:	00113423          	sd	ra,8(sp)
    800034c8:	00813023          	sd	s0,0(sp)
    800034cc:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800034d0:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800034d4:	fffff097          	auipc	ra,0xfffff
    800034d8:	414080e7          	jalr	1044(ra) # 800028e8 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800034dc:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800034e0:	00000097          	auipc	ra,0x0
    800034e4:	fa8080e7          	jalr	-88(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    800034e8:	00813083          	ld	ra,8(sp)
    800034ec:	00013403          	ld	s0,0(sp)
    800034f0:	01010113          	addi	sp,sp,16
    800034f4:	00008067          	ret

00000000800034f8 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    800034f8:	ff010113          	addi	sp,sp,-16
    800034fc:	00113423          	sd	ra,8(sp)
    80003500:	00813023          	sd	s0,0(sp)
    80003504:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003508:	00008797          	auipc	a5,0x8
    8000350c:	6207b783          	ld	a5,1568(a5) # 8000bb28 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003510:	0007c783          	lbu	a5,0(a5)
    80003514:	02079263          	bnez	a5,80003538 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003518:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000351c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003520:	00000097          	auipc	ra,0x0
    80003524:	f68080e7          	jalr	-152(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003528:	00813083          	ld	ra,8(sp)
    8000352c:	00013403          	ld	s0,0(sp)
    80003530:	01010113          	addi	sp,sp,16
    80003534:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003538:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    8000353c:	fffff097          	auipc	ra,0xfffff
    80003540:	5d4080e7          	jalr	1492(ra) # 80002b10 <_ZN15MemoryAllocator5kfreeEPv>
    80003544:	fd9ff06f          	j	8000351c <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003548 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003548:	fc010113          	addi	sp,sp,-64
    8000354c:	02113c23          	sd	ra,56(sp)
    80003550:	02813823          	sd	s0,48(sp)
    80003554:	02913423          	sd	s1,40(sp)
    80003558:	03213023          	sd	s2,32(sp)
    8000355c:	01313c23          	sd	s3,24(sp)
    80003560:	01413823          	sd	s4,16(sp)
    80003564:	01513423          	sd	s5,8(sp)
    80003568:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000356c:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003570:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003574:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003578:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000357c:	07000513          	li	a0,112
    80003580:	fffff097          	auipc	ra,0xfffff
    80003584:	1a0080e7          	jalr	416(ra) # 80002720 <_ZN3TCBnwEm>
    80003588:	00050493          	mv	s1,a0
    8000358c:	00200713          	li	a4,2
    80003590:	000a0693          	mv	a3,s4
    80003594:	00098613          	mv	a2,s3
    80003598:	00090593          	mv	a1,s2
    8000359c:	fffff097          	auipc	ra,0xfffff
    800035a0:	038080e7          	jalr	56(ra) # 800025d4 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800035a4:	04048863          	beqz	s1,800035f4 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    800035a8:	0184b783          	ld	a5,24(s1)
    800035ac:	00078863          	beqz	a5,800035bc <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    800035b0:	00048513          	mv	a0,s1
    800035b4:	00001097          	auipc	ra,0x1
    800035b8:	b54080e7          	jalr	-1196(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800035bc:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    800035c0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800035c4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800035c8:	00000097          	auipc	ra,0x0
    800035cc:	ec0080e7          	jalr	-320(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    800035d0:	03813083          	ld	ra,56(sp)
    800035d4:	03013403          	ld	s0,48(sp)
    800035d8:	02813483          	ld	s1,40(sp)
    800035dc:	02013903          	ld	s2,32(sp)
    800035e0:	01813983          	ld	s3,24(sp)
    800035e4:	01013a03          	ld	s4,16(sp)
    800035e8:	00813a83          	ld	s5,8(sp)
    800035ec:	04010113          	addi	sp,sp,64
    800035f0:	00008067          	ret
        status = -1;
    800035f4:	fff00793          	li	a5,-1
    800035f8:	fcdff06f          	j	800035c4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    800035fc:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003600:	00048513          	mv	a0,s1
    80003604:	fffff097          	auipc	ra,0xfffff
    80003608:	210080e7          	jalr	528(ra) # 80002814 <_ZN3TCBdlEPv>
    8000360c:	00090513          	mv	a0,s2
    80003610:	0000e097          	auipc	ra,0xe
    80003614:	898080e7          	jalr	-1896(ra) # 80010ea8 <_Unwind_Resume>

0000000080003618 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003618:	fc010113          	addi	sp,sp,-64
    8000361c:	02113c23          	sd	ra,56(sp)
    80003620:	02813823          	sd	s0,48(sp)
    80003624:	02913423          	sd	s1,40(sp)
    80003628:	03213023          	sd	s2,32(sp)
    8000362c:	01313c23          	sd	s3,24(sp)
    80003630:	01413823          	sd	s4,16(sp)
    80003634:	01513423          	sd	s5,8(sp)
    80003638:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000363c:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003640:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003644:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003648:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000364c:	07000513          	li	a0,112
    80003650:	fffff097          	auipc	ra,0xfffff
    80003654:	0d0080e7          	jalr	208(ra) # 80002720 <_ZN3TCBnwEm>
    80003658:	00050493          	mv	s1,a0
    8000365c:	00200713          	li	a4,2
    80003660:	00090693          	mv	a3,s2
    80003664:	00098613          	mv	a2,s3
    80003668:	000a0593          	mv	a1,s4
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	f68080e7          	jalr	-152(ra) # 800025d4 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003674:	04048263          	beqz	s1,800036b8 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003678:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    8000367c:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003680:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003684:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003688:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000368c:	00000097          	auipc	ra,0x0
    80003690:	dfc080e7          	jalr	-516(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003694:	03813083          	ld	ra,56(sp)
    80003698:	03013403          	ld	s0,48(sp)
    8000369c:	02813483          	ld	s1,40(sp)
    800036a0:	02013903          	ld	s2,32(sp)
    800036a4:	01813983          	ld	s3,24(sp)
    800036a8:	01013a03          	ld	s4,16(sp)
    800036ac:	00813a83          	ld	s5,8(sp)
    800036b0:	04010113          	addi	sp,sp,64
    800036b4:	00008067          	ret
        status = -1;
    800036b8:	fff00793          	li	a5,-1
    800036bc:	fcdff06f          	j	80003688 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    800036c0:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800036c4:	00048513          	mv	a0,s1
    800036c8:	fffff097          	auipc	ra,0xfffff
    800036cc:	14c080e7          	jalr	332(ra) # 80002814 <_ZN3TCBdlEPv>
    800036d0:	00090513          	mv	a0,s2
    800036d4:	0000d097          	auipc	ra,0xd
    800036d8:	7d4080e7          	jalr	2004(ra) # 80010ea8 <_Unwind_Resume>

00000000800036dc <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800036dc:	ff010113          	addi	sp,sp,-16
    800036e0:	00113423          	sd	ra,8(sp)
    800036e4:	00813023          	sd	s0,0(sp)
    800036e8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800036ec:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    800036f0:	02051263          	bnez	a0,80003714 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    800036f4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800036f8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800036fc:	00000097          	auipc	ra,0x0
    80003700:	d8c080e7          	jalr	-628(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003704:	00813083          	ld	ra,8(sp)
    80003708:	00013403          	ld	s0,0(sp)
    8000370c:	01010113          	addi	sp,sp,16
    80003710:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003714:	00100793          	li	a5,1
    80003718:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    8000371c:	00001097          	auipc	ra,0x1
    80003720:	9ec080e7          	jalr	-1556(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003724:	fffff097          	auipc	ra,0xfffff
    80003728:	f7c080e7          	jalr	-132(ra) # 800026a0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000372c:	00000793          	li	a5,0
    80003730:	fc9ff06f          	j	800036f8 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003734 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003734:	ff010113          	addi	sp,sp,-16
    80003738:	00113423          	sd	ra,8(sp)
    8000373c:	00813023          	sd	s0,0(sp)
    80003740:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003744:	00008797          	auipc	a5,0x8
    80003748:	3dc7b783          	ld	a5,988(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000374c:	0007b783          	ld	a5,0(a5)
    80003750:	02078a63          	beqz	a5,80003784 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003754:	00200713          	li	a4,2
    80003758:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    8000375c:	fffff097          	auipc	ra,0xfffff
    80003760:	f44080e7          	jalr	-188(ra) # 800026a0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003764:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003768:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000376c:	00000097          	auipc	ra,0x0
    80003770:	d1c080e7          	jalr	-740(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003774:	00813083          	ld	ra,8(sp)
    80003778:	00013403          	ld	s0,0(sp)
    8000377c:	01010113          	addi	sp,sp,16
    80003780:	00008067          	ret
        status = -1;
    80003784:	fff00793          	li	a5,-1
    80003788:	fe1ff06f          	j	80003768 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

000000008000378c <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    8000378c:	fd010113          	addi	sp,sp,-48
    80003790:	02113423          	sd	ra,40(sp)
    80003794:	02813023          	sd	s0,32(sp)
    80003798:	00913c23          	sd	s1,24(sp)
    8000379c:	01213823          	sd	s2,16(sp)
    800037a0:	01313423          	sd	s3,8(sp)
    800037a4:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800037a8:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800037ac:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    800037b0:	01800513          	li	a0,24
    800037b4:	fffff097          	auipc	ra,0xfffff
    800037b8:	d30080e7          	jalr	-720(ra) # 800024e4 <_ZN3SCBnwEm>
    800037bc:	00050493          	mv	s1,a0
    800037c0:	00090593          	mv	a1,s2
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	b64080e7          	jalr	-1180(ra) # 80002328 <_ZN3SCBC1Em>
    if(scb == nullptr){
    800037cc:	02048a63          	beqz	s1,80003800 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    800037d0:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    800037d4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800037d8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800037dc:	00000097          	auipc	ra,0x0
    800037e0:	cac080e7          	jalr	-852(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    800037e4:	02813083          	ld	ra,40(sp)
    800037e8:	02013403          	ld	s0,32(sp)
    800037ec:	01813483          	ld	s1,24(sp)
    800037f0:	01013903          	ld	s2,16(sp)
    800037f4:	00813983          	ld	s3,8(sp)
    800037f8:	03010113          	addi	sp,sp,48
    800037fc:	00008067          	ret
        status = -1;
    80003800:	fff00793          	li	a5,-1
    80003804:	fd5ff06f          	j	800037d8 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80003808:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    8000380c:	00048513          	mv	a0,s1
    80003810:	fffff097          	auipc	ra,0xfffff
    80003814:	cfc080e7          	jalr	-772(ra) # 8000250c <_ZN3SCBdlEPv>
    80003818:	00090513          	mv	a0,s2
    8000381c:	0000d097          	auipc	ra,0xd
    80003820:	68c080e7          	jalr	1676(ra) # 80010ea8 <_Unwind_Resume>

0000000080003824 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003824:	fe010113          	addi	sp,sp,-32
    80003828:	00113c23          	sd	ra,24(sp)
    8000382c:	00813823          	sd	s0,16(sp)
    80003830:	00913423          	sd	s1,8(sp)
    80003834:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003838:	00058493          	mv	s1,a1
    if(scb == nullptr){
    8000383c:	02049463          	bnez	s1,80003864 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003840:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003844:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003848:	00000097          	auipc	ra,0x0
    8000384c:	c40080e7          	jalr	-960(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003850:	01813083          	ld	ra,24(sp)
    80003854:	01013403          	ld	s0,16(sp)
    80003858:	00813483          	ld	s1,8(sp)
    8000385c:	02010113          	addi	sp,sp,32
    80003860:	00008067          	ret
        delete (SCB*)ihandle;
    80003864:	00048513          	mv	a0,s1
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	ae4080e7          	jalr	-1308(ra) # 8000234c <_ZN3SCBD1Ev>
    80003870:	00048513          	mv	a0,s1
    80003874:	fffff097          	auipc	ra,0xfffff
    80003878:	c98080e7          	jalr	-872(ra) # 8000250c <_ZN3SCBdlEPv>
    uint64 status = 0;
    8000387c:	00000793          	li	a5,0
    80003880:	fc5ff06f          	j	80003844 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003884 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003884:	ff010113          	addi	sp,sp,-16
    80003888:	00113423          	sd	ra,8(sp)
    8000388c:	00813023          	sd	s0,0(sp)
    80003890:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003894:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003898:	02051c63          	bnez	a0,800038d0 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    8000389c:	00008797          	auipc	a5,0x8
    800038a0:	2847b783          	ld	a5,644(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    800038a4:	0007b783          	ld	a5,0(a5)
    800038a8:	0607b783          	ld	a5,96(a5)
    800038ac:	02078863          	beqz	a5,800038dc <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800038b0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800038b4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800038b8:	00000097          	auipc	ra,0x0
    800038bc:	bd0080e7          	jalr	-1072(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    800038c0:	00813083          	ld	ra,8(sp)
    800038c4:	00013403          	ld	s0,0(sp)
    800038c8:	01010113          	addi	sp,sp,16
    800038cc:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800038d0:	fffff097          	auipc	ra,0xfffff
    800038d4:	b88080e7          	jalr	-1144(ra) # 80002458 <_ZN3SCB4waitEv>
    800038d8:	fc5ff06f          	j	8000389c <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800038dc:	00000793          	li	a5,0
    800038e0:	fd5ff06f          	j	800038b4 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800038e4 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800038e4:	ff010113          	addi	sp,sp,-16
    800038e8:	00113423          	sd	ra,8(sp)
    800038ec:	00813023          	sd	s0,0(sp)
    800038f0:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800038f4:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800038f8:	02051263          	bnez	a0,8000391c <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800038fc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003900:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003904:	00000097          	auipc	ra,0x0
    80003908:	b84080e7          	jalr	-1148(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000390c:	00813083          	ld	ra,8(sp)
    80003910:	00013403          	ld	s0,0(sp)
    80003914:	01010113          	addi	sp,sp,16
    80003918:	00008067          	ret
        ((SCB*)ihandle)->signal();
    8000391c:	fffff097          	auipc	ra,0xfffff
    80003920:	b8c080e7          	jalr	-1140(ra) # 800024a8 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003924:	00000793          	li	a5,0
    80003928:	fd9ff06f          	j	80003900 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

000000008000392c <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    8000392c:	fe010113          	addi	sp,sp,-32
    80003930:	00113c23          	sd	ra,24(sp)
    80003934:	00813823          	sd	s0,16(sp)
    80003938:	00913423          	sd	s1,8(sp)
    8000393c:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003940:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003944:	00008797          	auipc	a5,0x8
    80003948:	1dc7b783          	ld	a5,476(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000394c:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003950:	00008797          	auipc	a5,0x8
    80003954:	4087b783          	ld	a5,1032(a5) # 8000bd58 <_ZN5RiscV10globalTimeE>
    80003958:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    8000395c:	00e787b3          	add	a5,a5,a4
    80003960:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003964:	00048513          	mv	a0,s1
    80003968:	00001097          	auipc	ra,0x1
    8000396c:	81c080e7          	jalr	-2020(ra) # 80004184 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003970:	00300793          	li	a5,3
    80003974:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003978:	fffff097          	auipc	ra,0xfffff
    8000397c:	d28080e7          	jalr	-728(ra) # 800026a0 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003980:	00000793          	li	a5,0
    80003984:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003988:	00000097          	auipc	ra,0x0
    8000398c:	b00080e7          	jalr	-1280(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003990:	01813083          	ld	ra,24(sp)
    80003994:	01013403          	ld	s0,16(sp)
    80003998:	00813483          	ld	s1,8(sp)
    8000399c:	02010113          	addi	sp,sp,32
    800039a0:	00008067          	ret

00000000800039a4 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    800039a4:	fe010113          	addi	sp,sp,-32
    800039a8:	00113c23          	sd	ra,24(sp)
    800039ac:	00813823          	sd	s0,16(sp)
    800039b0:	00913423          	sd	s1,8(sp)
    800039b4:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    800039b8:	00008797          	auipc	a5,0x8
    800039bc:	3987c783          	lbu	a5,920(a5) # 8000bd50 <_ZN5RiscV16userMainFinishedE>
    800039c0:	00079c63          	bnez	a5,800039d8 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800039c4:	00008717          	auipc	a4,0x8
    800039c8:	10473703          	ld	a4,260(a4) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800039cc:	00073783          	ld	a5,0(a4)
    800039d0:	00178793          	addi	a5,a5,1
    800039d4:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800039d8:	00001097          	auipc	ra,0x1
    800039dc:	a44080e7          	jalr	-1468(ra) # 8000441c <_ZN11ConsoleUtil8getInputEv>
    800039e0:	00050493          	mv	s1,a0
    if(c==13) {
    800039e4:	00d00793          	li	a5,13
    800039e8:	02f50663          	beq	a0,a5,80003a14 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800039ec:	01b00793          	li	a5,27
    800039f0:	04f51063          	bne	a0,a5,80003a30 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800039f4:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800039f8:	00000097          	auipc	ra,0x0
    800039fc:	a90080e7          	jalr	-1392(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a00:	01813083          	ld	ra,24(sp)
    80003a04:	01013403          	ld	s0,16(sp)
    80003a08:	00813483          	ld	s1,8(sp)
    80003a0c:	02010113          	addi	sp,sp,32
    80003a10:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003a14:	00d00513          	li	a0,13
    80003a18:	00001097          	auipc	ra,0x1
    80003a1c:	a7c080e7          	jalr	-1412(ra) # 80004494 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003a20:	00a00513          	li	a0,10
    80003a24:	00001097          	auipc	ra,0x1
    80003a28:	a70080e7          	jalr	-1424(ra) # 80004494 <_ZN11ConsoleUtil9putOutputEc>
    80003a2c:	fc9ff06f          	j	800039f4 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003a30:	00001097          	auipc	ra,0x1
    80003a34:	a64080e7          	jalr	-1436(ra) # 80004494 <_ZN11ConsoleUtil9putOutputEc>
    80003a38:	fbdff06f          	j	800039f4 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003a3c <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003a3c:	ff010113          	addi	sp,sp,-16
    80003a40:	00113423          	sd	ra,8(sp)
    80003a44:	00813023          	sd	s0,0(sp)
    80003a48:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003a4c:	00001097          	auipc	ra,0x1
    80003a50:	ac8080e7          	jalr	-1336(ra) # 80004514 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003a54:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003a58:	00000097          	auipc	ra,0x0
    80003a5c:	a30080e7          	jalr	-1488(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a60:	00813083          	ld	ra,8(sp)
    80003a64:	00013403          	ld	s0,0(sp)
    80003a68:	01010113          	addi	sp,sp,16
    80003a6c:	00008067          	ret

0000000080003a70 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003a70:	fe010113          	addi	sp,sp,-32
    80003a74:	00113c23          	sd	ra,24(sp)
    80003a78:	00813823          	sd	s0,16(sp)
    80003a7c:	00913423          	sd	s1,8(sp)
    80003a80:	01213023          	sd	s2,0(sp)
    80003a84:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003a88:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003a8c:	02049663          	bnez	s1,80003ab8 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    80003a90:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a94:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    80003a98:	00000097          	auipc	ra,0x0
    80003a9c:	9f0080e7          	jalr	-1552(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003aa0:	01813083          	ld	ra,24(sp)
    80003aa4:	01013403          	ld	s0,16(sp)
    80003aa8:	00813483          	ld	s1,8(sp)
    80003aac:	00013903          	ld	s2,0(sp)
    80003ab0:	02010113          	addi	sp,sp,32
    80003ab4:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    80003ab8:	0284b503          	ld	a0,40(s1)
    80003abc:	fffff097          	auipc	ra,0xfffff
    80003ac0:	054080e7          	jalr	84(ra) # 80002b10 <_ZN15MemoryAllocator5kfreeEPv>
    80003ac4:	00050913          	mv	s2,a0
        delete thr;
    80003ac8:	00048513          	mv	a0,s1
    80003acc:	fffff097          	auipc	ra,0xfffff
    80003ad0:	bac080e7          	jalr	-1108(ra) # 80002678 <_ZN3TCBD1Ev>
    80003ad4:	00048513          	mv	a0,s1
    80003ad8:	fffff097          	auipc	ra,0xfffff
    80003adc:	d3c080e7          	jalr	-708(ra) # 80002814 <_ZN3TCBdlEPv>
    80003ae0:	fb5ff06f          	j	80003a94 <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

0000000080003ae4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003ae4:	fe010113          	addi	sp,sp,-32
    80003ae8:	00113c23          	sd	ra,24(sp)
    80003aec:	00813823          	sd	s0,16(sp)
    80003af0:	00913423          	sd	s1,8(sp)
    80003af4:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003af8:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003afc:	02049463          	bnez	s1,80003b24 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b00:	fff00793          	li	a5,-1
    80003b04:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003b08:	00000097          	auipc	ra,0x0
    80003b0c:	980080e7          	jalr	-1664(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b10:	01813083          	ld	ra,24(sp)
    80003b14:	01013403          	ld	s0,16(sp)
    80003b18:	00813483          	ld	s1,8(sp)
    80003b1c:	02010113          	addi	sp,sp,32
    80003b20:	00008067          	ret
        delete scb;
    80003b24:	00048513          	mv	a0,s1
    80003b28:	fffff097          	auipc	ra,0xfffff
    80003b2c:	824080e7          	jalr	-2012(ra) # 8000234c <_ZN3SCBD1Ev>
    80003b30:	00048513          	mv	a0,s1
    80003b34:	fffff097          	auipc	ra,0xfffff
    80003b38:	9d8080e7          	jalr	-1576(ra) # 8000250c <_ZN3SCBdlEPv>
    80003b3c:	fc5ff06f          	j	80003b00 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003b40 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003b40:	fe010113          	addi	sp,sp,-32
    80003b44:	00113c23          	sd	ra,24(sp)
    80003b48:	00813823          	sd	s0,16(sp)
    80003b4c:	00913423          	sd	s1,8(sp)
    80003b50:	01213023          	sd	s2,0(sp)
    80003b54:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003b58:	04000513          	li	a0,64
    80003b5c:	fffff097          	auipc	ra,0xfffff
    80003b60:	d8c080e7          	jalr	-628(ra) # 800028e8 <_ZN15MemoryAllocator7kmallocEm>
    80003b64:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003b68:	00008797          	auipc	a5,0x8
    80003b6c:	fb87b783          	ld	a5,-72(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003b70:	0007b783          	ld	a5,0(a5)
    80003b74:	00001637          	lui	a2,0x1
    80003b78:	00050593          	mv	a1,a0
    80003b7c:	0287b503          	ld	a0,40(a5)
    80003b80:	fffff097          	auipc	ra,0xfffff
    80003b84:	144080e7          	jalr	324(ra) # 80002cc4 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003b88:	07000513          	li	a0,112
    80003b8c:	fffff097          	auipc	ra,0xfffff
    80003b90:	b94080e7          	jalr	-1132(ra) # 80002720 <_ZN3TCBnwEm>
    80003b94:	00050493          	mv	s1,a0
    80003b98:	00200713          	li	a4,2
    80003b9c:	00090693          	mv	a3,s2
    80003ba0:	00000613          	li	a2,0
    80003ba4:	00000593          	li	a1,0
    80003ba8:	fffff097          	auipc	ra,0xfffff
    80003bac:	a2c080e7          	jalr	-1492(ra) # 800025d4 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003bb0:	0a048e63          	beqz	s1,80003c6c <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003bb4:	00008797          	auipc	a5,0x8
    80003bb8:	f347b783          	ld	a5,-204(a5) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003bbc:	0007b783          	ld	a5,0(a5)
    80003bc0:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003bc4:	00008797          	auipc	a5,0x8
    80003bc8:	f0c7b783          	ld	a5,-244(a5) # 8000bad0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003bcc:	0007b783          	ld	a5,0(a5)
    80003bd0:	00f907b3          	add	a5,s2,a5
    80003bd4:	00008717          	auipc	a4,0x8
    80003bd8:	f4c73703          	ld	a4,-180(a4) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003bdc:	00073683          	ld	a3,0(a4)
    80003be0:	0286b683          	ld	a3,40(a3)
    80003be4:	40d787b3          	sub	a5,a5,a3
    80003be8:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003bec:	00073783          	ld	a5,0(a4)
    80003bf0:	0687b503          	ld	a0,104(a5)
    80003bf4:	0287b783          	ld	a5,40(a5)
    80003bf8:	40f50533          	sub	a0,a0,a5
    80003bfc:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003c00:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003c04:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003c08:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003c0c:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003c10:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003c14:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003c18:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003c1c:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003c20:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003c24:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003c28:	00073783          	ld	a5,0(a4)
    80003c2c:	0387b703          	ld	a4,56(a5)
    80003c30:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003c34:	0407b783          	ld	a5,64(a5)
    80003c38:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003c3c:	00048513          	mv	a0,s1
    80003c40:	00000097          	auipc	ra,0x0
    80003c44:	4c8080e7          	jalr	1224(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c48:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003c4c:	00000097          	auipc	ra,0x0
    80003c50:	83c080e7          	jalr	-1988(ra) # 80003488 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003c54:	01813083          	ld	ra,24(sp)
    80003c58:	01013403          	ld	s0,16(sp)
    80003c5c:	00813483          	ld	s1,8(sp)
    80003c60:	00013903          	ld	s2,0(sp)
    80003c64:	02010113          	addi	sp,sp,32
    80003c68:	00008067          	ret
        status = -1;
    80003c6c:	fff00493          	li	s1,-1
    80003c70:	fd9ff06f          	j	80003c48 <_ZN5RiscV18executeForkSyscallEv+0x108>
    80003c74:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003c78:	00048513          	mv	a0,s1
    80003c7c:	fffff097          	auipc	ra,0xfffff
    80003c80:	b98080e7          	jalr	-1128(ra) # 80002814 <_ZN3TCBdlEPv>
    80003c84:	00090513          	mv	a0,s2
    80003c88:	0000d097          	auipc	ra,0xd
    80003c8c:	220080e7          	jalr	544(ra) # 80010ea8 <_Unwind_Resume>

0000000080003c90 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003c90:	ff010113          	addi	sp,sp,-16
    80003c94:	00813423          	sd	s0,8(sp)
    80003c98:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003c9c:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003ca0:	00878793          	addi	a5,a5,8
    80003ca4:	00008717          	auipc	a4,0x8
    80003ca8:	e4473703          	ld	a4,-444(a4) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003cac:	00f73023          	sd	a5,0(a4)
}
    80003cb0:	00813403          	ld	s0,8(sp)
    80003cb4:	01010113          	addi	sp,sp,16
    80003cb8:	00008067          	ret

0000000080003cbc <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003cbc:	fa010113          	addi	sp,sp,-96
    80003cc0:	04113c23          	sd	ra,88(sp)
    80003cc4:	04813823          	sd	s0,80(sp)
    80003cc8:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003ccc:	142027f3          	csrr	a5,scause
    80003cd0:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80003cd4:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003cd8:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003cdc:	00008797          	auipc	a5,0x8
    80003ce0:	e447b783          	ld	a5,-444(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003ce4:	0007b783          	ld	a5,0(a5)
    80003ce8:	14002773          	csrr	a4,sscratch
    80003cec:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80003cf0:	fe843703          	ld	a4,-24(s0)
    80003cf4:	00900793          	li	a5,9
    80003cf8:	0ef70663          	beq	a4,a5,80003de4 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    80003cfc:	fe843703          	ld	a4,-24(s0)
    80003d00:	00800793          	li	a5,8
    80003d04:	0ef70063          	beq	a4,a5,80003de4 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003d08:	fe843703          	ld	a4,-24(s0)
    80003d0c:	fff00793          	li	a5,-1
    80003d10:	03f79793          	slli	a5,a5,0x3f
    80003d14:	00178793          	addi	a5,a5,1
    80003d18:	24f70263          	beq	a4,a5,80003f5c <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003d1c:	fe843703          	ld	a4,-24(s0)
    80003d20:	fff00793          	li	a5,-1
    80003d24:	03f79793          	slli	a5,a5,0x3f
    80003d28:	00978793          	addi	a5,a5,9
    80003d2c:	2cf70063          	beq	a4,a5,80003fec <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80003d30:	fe843703          	ld	a4,-24(s0)
    80003d34:	00200793          	li	a5,2
    80003d38:	34f70863          	beq	a4,a5,80004088 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80003d3c:	00005517          	auipc	a0,0x5
    80003d40:	49c50513          	addi	a0,a0,1180 # 800091d8 <CONSOLE_STATUS+0x1c8>
    80003d44:	00001097          	auipc	ra,0x1
    80003d48:	848080e7          	jalr	-1976(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003d4c:	00005517          	auipc	a0,0x5
    80003d50:	49c50513          	addi	a0,a0,1180 # 800091e8 <CONSOLE_STATUS+0x1d8>
    80003d54:	00001097          	auipc	ra,0x1
    80003d58:	838080e7          	jalr	-1992(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003d5c:	142027f3          	csrr	a5,scause
    80003d60:	fef43023          	sd	a5,-32(s0)
    return scause;
    80003d64:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80003d68:	00000613          	li	a2,0
    80003d6c:	00a00593          	li	a1,10
    80003d70:	0005051b          	sext.w	a0,a0
    80003d74:	00001097          	auipc	ra,0x1
    80003d78:	85c080e7          	jalr	-1956(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003d7c:	00005517          	auipc	a0,0x5
    80003d80:	42c50513          	addi	a0,a0,1068 # 800091a8 <CONSOLE_STATUS+0x198>
    80003d84:	00001097          	auipc	ra,0x1
    80003d88:	808080e7          	jalr	-2040(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003d8c:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003d90:	00000613          	li	a2,0
    80003d94:	01000593          	li	a1,16
    80003d98:	0005051b          	sext.w	a0,a0
    80003d9c:	00001097          	auipc	ra,0x1
    80003da0:	834080e7          	jalr	-1996(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003da4:	00005517          	auipc	a0,0x5
    80003da8:	3fc50513          	addi	a0,a0,1020 # 800091a0 <CONSOLE_STATUS+0x190>
    80003dac:	00000097          	auipc	ra,0x0
    80003db0:	7e0080e7          	jalr	2016(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80003db4:	00008797          	auipc	a5,0x8
    80003db8:	d6c7b783          	ld	a5,-660(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003dbc:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003dc0:	00200713          	li	a4,2
    80003dc4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003dc8:	00005517          	auipc	a0,0x5
    80003dcc:	43050513          	addi	a0,a0,1072 # 800091f8 <CONSOLE_STATUS+0x1e8>
    80003dd0:	00000097          	auipc	ra,0x0
    80003dd4:	7bc080e7          	jalr	1980(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003dd8:	fffff097          	auipc	ra,0xfffff
    80003ddc:	8c8080e7          	jalr	-1848(ra) # 800026a0 <_ZN3TCB8dispatchEv>
    80003de0:	0800006f          	j	80003e60 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003de4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003de8:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003dec:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003df0:	00478793          	addi	a5,a5,4
    80003df4:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80003df8:	00008797          	auipc	a5,0x8
    80003dfc:	d287b783          	ld	a5,-728(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003e00:	0007b783          	ld	a5,0(a5)
    80003e04:	fb043703          	ld	a4,-80(s0)
    80003e08:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003e0c:	fa843703          	ld	a4,-88(s0)
    80003e10:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003e14:	00050793          	mv	a5,a0
        switch(syscallID){
    80003e18:	06100713          	li	a4,97
    80003e1c:	02f76463          	bltu	a4,a5,80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    80003e20:	00279793          	slli	a5,a5,0x2
    80003e24:	00005717          	auipc	a4,0x5
    80003e28:	3e870713          	addi	a4,a4,1000 # 8000920c <CONSOLE_STATUS+0x1fc>
    80003e2c:	00e787b3          	add	a5,a5,a4
    80003e30:	0007a783          	lw	a5,0(a5)
    80003e34:	00e787b3          	add	a5,a5,a4
    80003e38:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003e3c:	fffff097          	auipc	ra,0xfffff
    80003e40:	684080e7          	jalr	1668(ra) # 800034c0 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003e44:	00008797          	auipc	a5,0x8
    80003e48:	cdc7b783          	ld	a5,-804(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003e4c:	0007b783          	ld	a5,0(a5)
    80003e50:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003e54:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003e58:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003e5c:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003e60:	fffff097          	auipc	ra,0xfffff
    80003e64:	530080e7          	jalr	1328(ra) # 80003390 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003e68:	05813083          	ld	ra,88(sp)
    80003e6c:	05013403          	ld	s0,80(sp)
    80003e70:	06010113          	addi	sp,sp,96
    80003e74:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003e78:	fffff097          	auipc	ra,0xfffff
    80003e7c:	680080e7          	jalr	1664(ra) # 800034f8 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003e80:	fc5ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80003e84:	fffff097          	auipc	ra,0xfffff
    80003e88:	6c4080e7          	jalr	1732(ra) # 80003548 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003e8c:	fb9ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80003e90:	00000097          	auipc	ra,0x0
    80003e94:	8a4080e7          	jalr	-1884(ra) # 80003734 <_ZN5RiscV24executeThreadExitSyscallEv>
    80003e98:	fadff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003e9c:	fffff097          	auipc	ra,0xfffff
    80003ea0:	3e0080e7          	jalr	992(ra) # 8000327c <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003ea4:	fa1ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003ea8:	fffff097          	auipc	ra,0xfffff
    80003eac:	770080e7          	jalr	1904(ra) # 80003618 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003eb0:	f95ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80003eb4:	00000097          	auipc	ra,0x0
    80003eb8:	828080e7          	jalr	-2008(ra) # 800036dc <_ZN5RiscV25executeThreadStartSyscallEv>
    80003ebc:	f89ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80003ec0:	00000097          	auipc	ra,0x0
    80003ec4:	8cc080e7          	jalr	-1844(ra) # 8000378c <_ZN5RiscV21executeSemOpenSyscallEv>
    80003ec8:	f7dff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80003ecc:	00000097          	auipc	ra,0x0
    80003ed0:	958080e7          	jalr	-1704(ra) # 80003824 <_ZN5RiscV22executeSemCloseSyscallEv>
    80003ed4:	f71ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80003ed8:	00000097          	auipc	ra,0x0
    80003edc:	9ac080e7          	jalr	-1620(ra) # 80003884 <_ZN5RiscV21executeSemWaitSyscallEv>
    80003ee0:	f65ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80003ee4:	00000097          	auipc	ra,0x0
    80003ee8:	a00080e7          	jalr	-1536(ra) # 800038e4 <_ZN5RiscV23executeSemSignalSyscallEv>
    80003eec:	f59ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    80003ef0:	00000097          	auipc	ra,0x0
    80003ef4:	a3c080e7          	jalr	-1476(ra) # 8000392c <_ZN5RiscV23executeTimeSleepSyscallEv>
    80003ef8:	f4dff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80003efc:	00000097          	auipc	ra,0x0
    80003f00:	aa8080e7          	jalr	-1368(ra) # 800039a4 <_ZN5RiscV18executeGetcSyscallEv>
    80003f04:	f41ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80003f08:	fffff097          	auipc	ra,0xfffff
    80003f0c:	3b0080e7          	jalr	944(ra) # 800032b8 <_ZN5RiscV18executePutcSyscallEv>
    80003f10:	f35ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80003f14:	00000097          	auipc	ra,0x0
    80003f18:	b28080e7          	jalr	-1240(ra) # 80003a3c <_ZN5RiscV22executePutcUtilSyscallEv>
    80003f1c:	f29ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    80003f20:	00000097          	auipc	ra,0x0
    80003f24:	b50080e7          	jalr	-1200(ra) # 80003a70 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003f28:	f1dff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80003f2c:	00000097          	auipc	ra,0x0
    80003f30:	bb8080e7          	jalr	-1096(ra) # 80003ae4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003f34:	f11ff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003f38:	00010793          	mv	a5,sp
    80003f3c:	00008717          	auipc	a4,0x8
    80003f40:	b9473703          	ld	a4,-1132(a4) # 8000bad0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003f44:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003f48:	00000097          	auipc	ra,0x0
    80003f4c:	d48080e7          	jalr	-696(ra) # 80003c90 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003f50:	00000097          	auipc	ra,0x0
    80003f54:	bf0080e7          	jalr	-1040(ra) # 80003b40 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003f58:	eedff06f          	j	80003e44 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003f5c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003f60:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003f64:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003f68:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003f6c:	00200793          	li	a5,2
    80003f70:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003f74:	00008717          	auipc	a4,0x8
    80003f78:	ddc70713          	addi	a4,a4,-548 # 8000bd50 <_ZN5RiscV16userMainFinishedE>
    80003f7c:	00873783          	ld	a5,8(a4)
    80003f80:	00178793          	addi	a5,a5,1
    80003f84:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80003f88:	00000097          	auipc	ra,0x0
    80003f8c:	254080e7          	jalr	596(ra) # 800041dc <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003f90:	00008717          	auipc	a4,0x8
    80003f94:	b2073703          	ld	a4,-1248(a4) # 8000bab0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003f98:	00073783          	ld	a5,0(a4)
    80003f9c:	00178793          	addi	a5,a5,1
    80003fa0:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003fa4:	00008717          	auipc	a4,0x8
    80003fa8:	b7c73703          	ld	a4,-1156(a4) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003fac:	00073703          	ld	a4,0(a4)
    80003fb0:	03073683          	ld	a3,48(a4)
    80003fb4:	00d7fc63          	bgeu	a5,a3,80003fcc <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80003fb8:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003fbc:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003fc0:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003fc4:	14179073          	csrw	sepc,a5
}
    80003fc8:	e99ff06f          	j	80003e60 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80003fcc:	00008797          	auipc	a5,0x8
    80003fd0:	ae47b783          	ld	a5,-1308(a5) # 8000bab0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003fd4:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003fd8:	00100793          	li	a5,1
    80003fdc:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003fe0:	ffffe097          	auipc	ra,0xffffe
    80003fe4:	6c0080e7          	jalr	1728(ra) # 800026a0 <_ZN3TCB8dispatchEv>
    80003fe8:	fd1ff06f          	j	80003fb8 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003fec:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003ff0:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003ff4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003ff8:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80003ffc:	00008797          	auipc	a5,0x8
    80004000:	aa47b783          	ld	a5,-1372(a5) # 8000baa0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004004:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004008:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000400c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004010:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004014:	0017f793          	andi	a5,a5,1
    80004018:	02078863          	beqz	a5,80004048 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    8000401c:	00008797          	auipc	a5,0x8
    80004020:	aa47b783          	ld	a5,-1372(a5) # 8000bac0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004024:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004028:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    8000402c:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004030:	00058513          	mv	a0,a1
    80004034:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004038:	00008797          	auipc	a5,0x8
    8000403c:	a907b783          	ld	a5,-1392(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004040:	0007b783          	ld	a5,0(a5)
    80004044:	02079463          	bnez	a5,8000406c <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80004048:	00003097          	auipc	ra,0x3
    8000404c:	dec080e7          	jalr	-532(ra) # 80006e34 <plic_claim>
    80004050:	00003097          	auipc	ra,0x3
    80004054:	e1c080e7          	jalr	-484(ra) # 80006e6c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004058:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000405c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004060:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004064:	14179073          	csrw	sepc,a5
}
    80004068:	df9ff06f          	j	80003e60 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    8000406c:	fff78793          	addi	a5,a5,-1
    80004070:	00008717          	auipc	a4,0x8
    80004074:	a5873703          	ld	a4,-1448(a4) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004078:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    8000407c:	00000097          	auipc	ra,0x0
    80004080:	338080e7          	jalr	824(ra) # 800043b4 <_ZN11ConsoleUtil8putInputEc>
    80004084:	fc5ff06f          	j	80004048 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80004088:	00008797          	auipc	a5,0x8
    8000408c:	a987b783          	ld	a5,-1384(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004090:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004094:	00200713          	li	a4,2
    80004098:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    8000409c:	00005517          	auipc	a0,0x5
    800040a0:	10c50513          	addi	a0,a0,268 # 800091a8 <CONSOLE_STATUS+0x198>
    800040a4:	00000097          	auipc	ra,0x0
    800040a8:	4e8080e7          	jalr	1256(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800040ac:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800040b0:	00000613          	li	a2,0
    800040b4:	01000593          	li	a1,16
    800040b8:	0005051b          	sext.w	a0,a0
    800040bc:	00000097          	auipc	ra,0x0
    800040c0:	514080e7          	jalr	1300(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800040c4:	00005517          	auipc	a0,0x5
    800040c8:	0dc50513          	addi	a0,a0,220 # 800091a0 <CONSOLE_STATUS+0x190>
    800040cc:	00000097          	auipc	ra,0x0
    800040d0:	4c0080e7          	jalr	1216(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    800040d4:	00005517          	auipc	a0,0x5
    800040d8:	0dc50513          	addi	a0,a0,220 # 800091b0 <CONSOLE_STATUS+0x1a0>
    800040dc:	00000097          	auipc	ra,0x0
    800040e0:	4b0080e7          	jalr	1200(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800040e4:	ffffe097          	auipc	ra,0xffffe
    800040e8:	5bc080e7          	jalr	1468(ra) # 800026a0 <_ZN3TCB8dispatchEv>
    800040ec:	d75ff06f          	j	80003e60 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

00000000800040f0 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    800040f0:	ff010113          	addi	sp,sp,-16
    800040f4:	00813423          	sd	s0,8(sp)
    800040f8:	01010413          	addi	s0,sp,16
}
    800040fc:	00813403          	ld	s0,8(sp)
    80004100:	01010113          	addi	sp,sp,16
    80004104:	00008067          	ret

0000000080004108 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004108:	ff010113          	addi	sp,sp,-16
    8000410c:	00813423          	sd	s0,8(sp)
    80004110:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004114:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004118:	00008797          	auipc	a5,0x8
    8000411c:	c487b783          	ld	a5,-952(a5) # 8000bd60 <_ZN9Scheduler9readyHeadE>
    80004120:	02078263          	beqz	a5,80004144 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004124:	00008797          	auipc	a5,0x8
    80004128:	c447b783          	ld	a5,-956(a5) # 8000bd68 <_ZN9Scheduler9readyTailE>
    8000412c:	04a7b423          	sd	a0,72(a5)
    80004130:	00008797          	auipc	a5,0x8
    80004134:	c2a7bc23          	sd	a0,-968(a5) # 8000bd68 <_ZN9Scheduler9readyTailE>
}
    80004138:	00813403          	ld	s0,8(sp)
    8000413c:	01010113          	addi	sp,sp,16
    80004140:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004144:	00008797          	auipc	a5,0x8
    80004148:	c0a7be23          	sd	a0,-996(a5) # 8000bd60 <_ZN9Scheduler9readyHeadE>
    8000414c:	fe5ff06f          	j	80004130 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004150 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004150:	ff010113          	addi	sp,sp,-16
    80004154:	00813423          	sd	s0,8(sp)
    80004158:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    8000415c:	00008517          	auipc	a0,0x8
    80004160:	c0453503          	ld	a0,-1020(a0) # 8000bd60 <_ZN9Scheduler9readyHeadE>
    80004164:	00050a63          	beqz	a0,80004178 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004168:	04853783          	ld	a5,72(a0)
    8000416c:	00008717          	auipc	a4,0x8
    80004170:	bef73a23          	sd	a5,-1036(a4) # 8000bd60 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004174:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004178:	00813403          	ld	s0,8(sp)
    8000417c:	01010113          	addi	sp,sp,16
    80004180:	00008067          	ret

0000000080004184 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004184:	ff010113          	addi	sp,sp,-16
    80004188:	00813423          	sd	s0,8(sp)
    8000418c:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004190:	00008797          	auipc	a5,0x8
    80004194:	be07b783          	ld	a5,-1056(a5) # 8000bd70 <_ZN9Scheduler12sleepingHeadE>
    80004198:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    8000419c:	00078e63          	beqz	a5,800041b8 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800041a0:	0587b683          	ld	a3,88(a5)
    800041a4:	05853703          	ld	a4,88(a0)
    800041a8:	00d76863          	bltu	a4,a3,800041b8 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800041ac:	00078613          	mv	a2,a5
    800041b0:	0487b783          	ld	a5,72(a5)
    800041b4:	fe9ff06f          	j	8000419c <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    800041b8:	04f53423          	sd	a5,72(a0)
    if(prev)
    800041bc:	00060a63          	beqz	a2,800041d0 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    800041c0:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    800041c4:	00813403          	ld	s0,8(sp)
    800041c8:	01010113          	addi	sp,sp,16
    800041cc:	00008067          	ret
        sleepingHead = t;
    800041d0:	00008797          	auipc	a5,0x8
    800041d4:	baa7b023          	sd	a0,-1120(a5) # 8000bd70 <_ZN9Scheduler12sleepingHeadE>
}
    800041d8:	fedff06f          	j	800041c4 <_ZN9Scheduler5sleepEP3TCB+0x40>

00000000800041dc <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    800041dc:	fe010113          	addi	sp,sp,-32
    800041e0:	00113c23          	sd	ra,24(sp)
    800041e4:	00813823          	sd	s0,16(sp)
    800041e8:	00913423          	sd	s1,8(sp)
    800041ec:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    800041f0:	00008497          	auipc	s1,0x8
    800041f4:	b804b483          	ld	s1,-1152(s1) # 8000bd70 <_ZN9Scheduler12sleepingHeadE>
    800041f8:	02048c63          	beqz	s1,80004230 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    800041fc:	0584b703          	ld	a4,88(s1)
    80004200:	00008797          	auipc	a5,0x8
    80004204:	9387b783          	ld	a5,-1736(a5) # 8000bb38 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004208:	0007b783          	ld	a5,0(a5)
    8000420c:	02e7e263          	bltu	a5,a4,80004230 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004210:	0484b783          	ld	a5,72(s1)
    80004214:	00008717          	auipc	a4,0x8
    80004218:	b4f73e23          	sd	a5,-1188(a4) # 8000bd70 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    8000421c:	00048513          	mv	a0,s1
    80004220:	00000097          	auipc	ra,0x0
    80004224:	ee8080e7          	jalr	-280(ra) # 80004108 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004228:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    8000422c:	fc5ff06f          	j	800041f0 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004230:	01813083          	ld	ra,24(sp)
    80004234:	01013403          	ld	s0,16(sp)
    80004238:	00813483          	ld	s1,8(sp)
    8000423c:	02010113          	addi	sp,sp,32
    80004240:	00008067          	ret

0000000080004244 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004244:	fe010113          	addi	sp,sp,-32
    80004248:	00113c23          	sd	ra,24(sp)
    8000424c:	00813823          	sd	s0,16(sp)
    80004250:	00913423          	sd	s1,8(sp)
    80004254:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004258:	00008497          	auipc	s1,0x8
    8000425c:	b084b483          	ld	s1,-1272(s1) # 8000bd60 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004260:	02048863          	beqz	s1,80004290 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004264:	00000613          	li	a2,0
    80004268:	01000593          	li	a1,16
    8000426c:	0004851b          	sext.w	a0,s1
    80004270:	00000097          	auipc	ra,0x0
    80004274:	360080e7          	jalr	864(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004278:	00005517          	auipc	a0,0x5
    8000427c:	f2850513          	addi	a0,a0,-216 # 800091a0 <CONSOLE_STATUS+0x190>
    80004280:	00000097          	auipc	ra,0x0
    80004284:	30c080e7          	jalr	780(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004288:	0484b483          	ld	s1,72(s1)
    while(iter){
    8000428c:	fd5ff06f          	j	80004260 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004290:	01813083          	ld	ra,24(sp)
    80004294:	01013403          	ld	s0,16(sp)
    80004298:	00813483          	ld	s1,8(sp)
    8000429c:	02010113          	addi	sp,sp,32
    800042a0:	00008067          	ret

00000000800042a4 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800042a4:	fe010113          	addi	sp,sp,-32
    800042a8:	00113c23          	sd	ra,24(sp)
    800042ac:	00813823          	sd	s0,16(sp)
    800042b0:	00913423          	sd	s1,8(sp)
    800042b4:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    800042b8:	00008497          	auipc	s1,0x8
    800042bc:	ab84b483          	ld	s1,-1352(s1) # 8000bd70 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    800042c0:	02048863          	beqz	s1,800042f0 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    800042c4:	00000613          	li	a2,0
    800042c8:	01000593          	li	a1,16
    800042cc:	0004851b          	sext.w	a0,s1
    800042d0:	ffffe097          	auipc	ra,0xffffe
    800042d4:	f44080e7          	jalr	-188(ra) # 80002214 <_Z8printIntiii>
        printString("\n");
    800042d8:	00005517          	auipc	a0,0x5
    800042dc:	ec850513          	addi	a0,a0,-312 # 800091a0 <CONSOLE_STATUS+0x190>
    800042e0:	ffffe097          	auipc	ra,0xffffe
    800042e4:	d9c080e7          	jalr	-612(ra) # 8000207c <_Z11printStringPKc>
        iter = iter->next;
    800042e8:	0484b483          	ld	s1,72(s1)
    while(iter){
    800042ec:	fd5ff06f          	j	800042c0 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    800042f0:	01813083          	ld	ra,24(sp)
    800042f4:	01013403          	ld	s0,16(sp)
    800042f8:	00813483          	ld	s1,8(sp)
    800042fc:	02010113          	addi	sp,sp,32
    80004300:	00008067          	ret

0000000080004304 <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    80004304:	fe010113          	addi	sp,sp,-32
    80004308:	00113c23          	sd	ra,24(sp)
    8000430c:	00813823          	sd	s0,16(sp)
    80004310:	00913423          	sd	s1,8(sp)
    80004314:	01213023          	sd	s2,0(sp)
    80004318:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    8000431c:	01800513          	li	a0,24
    80004320:	ffffe097          	auipc	ra,0xffffe
    80004324:	1c4080e7          	jalr	452(ra) # 800024e4 <_ZN3SCBnwEm>
    80004328:	00050493          	mv	s1,a0
    8000432c:	00000593          	li	a1,0
    80004330:	ffffe097          	auipc	ra,0xffffe
    80004334:	ff8080e7          	jalr	-8(ra) # 80002328 <_ZN3SCBC1Em>
    80004338:	00008797          	auipc	a5,0x8
    8000433c:	a497b023          	sd	s1,-1472(a5) # 8000bd78 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004340:	01800513          	li	a0,24
    80004344:	ffffe097          	auipc	ra,0xffffe
    80004348:	1a0080e7          	jalr	416(ra) # 800024e4 <_ZN3SCBnwEm>
    8000434c:	00050493          	mv	s1,a0
    80004350:	00000593          	li	a1,0
    80004354:	ffffe097          	auipc	ra,0xffffe
    80004358:	fd4080e7          	jalr	-44(ra) # 80002328 <_ZN3SCBC1Em>
    8000435c:	00008797          	auipc	a5,0x8
    80004360:	a297b223          	sd	s1,-1500(a5) # 8000bd80 <_ZN11ConsoleUtil9outputSemE>
}
    80004364:	01813083          	ld	ra,24(sp)
    80004368:	01013403          	ld	s0,16(sp)
    8000436c:	00813483          	ld	s1,8(sp)
    80004370:	00013903          	ld	s2,0(sp)
    80004374:	02010113          	addi	sp,sp,32
    80004378:	00008067          	ret
    8000437c:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004380:	00048513          	mv	a0,s1
    80004384:	ffffe097          	auipc	ra,0xffffe
    80004388:	188080e7          	jalr	392(ra) # 8000250c <_ZN3SCBdlEPv>
    8000438c:	00090513          	mv	a0,s2
    80004390:	0000d097          	auipc	ra,0xd
    80004394:	b18080e7          	jalr	-1256(ra) # 80010ea8 <_Unwind_Resume>
    80004398:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    8000439c:	00048513          	mv	a0,s1
    800043a0:	ffffe097          	auipc	ra,0xffffe
    800043a4:	16c080e7          	jalr	364(ra) # 8000250c <_ZN3SCBdlEPv>
    800043a8:	00090513          	mv	a0,s2
    800043ac:	0000d097          	auipc	ra,0xd
    800043b0:	afc080e7          	jalr	-1284(ra) # 80010ea8 <_Unwind_Resume>

00000000800043b4 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    800043b4:	00008697          	auipc	a3,0x8
    800043b8:	9c468693          	addi	a3,a3,-1596 # 8000bd78 <_ZN11ConsoleUtil8inputSemE>
    800043bc:	0106b603          	ld	a2,16(a3)
    800043c0:	00160793          	addi	a5,a2,1
    800043c4:	00002737          	lui	a4,0x2
    800043c8:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    800043cc:	00e7f7b3          	and	a5,a5,a4
    800043d0:	0186b703          	ld	a4,24(a3)
    800043d4:	04e78263          	beq	a5,a4,80004418 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    800043d8:	ff010113          	addi	sp,sp,-16
    800043dc:	00113423          	sd	ra,8(sp)
    800043e0:	00813023          	sd	s0,0(sp)
    800043e4:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    800043e8:	0000a717          	auipc	a4,0xa
    800043ec:	9c870713          	addi	a4,a4,-1592 # 8000ddb0 <_ZN11ConsoleUtil11inputBufferE>
    800043f0:	00c70633          	add	a2,a4,a2
    800043f4:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    800043f8:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    800043fc:	0006b503          	ld	a0,0(a3)
    80004400:	ffffe097          	auipc	ra,0xffffe
    80004404:	0a8080e7          	jalr	168(ra) # 800024a8 <_ZN3SCB6signalEv>
}
    80004408:	00813083          	ld	ra,8(sp)
    8000440c:	00013403          	ld	s0,0(sp)
    80004410:	01010113          	addi	sp,sp,16
    80004414:	00008067          	ret
    80004418:	00008067          	ret

000000008000441c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    8000441c:	fe010113          	addi	sp,sp,-32
    80004420:	00113c23          	sd	ra,24(sp)
    80004424:	00813823          	sd	s0,16(sp)
    80004428:	00913423          	sd	s1,8(sp)
    8000442c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004430:	00008497          	auipc	s1,0x8
    80004434:	94848493          	addi	s1,s1,-1720 # 8000bd78 <_ZN11ConsoleUtil8inputSemE>
    80004438:	0004b503          	ld	a0,0(s1)
    8000443c:	ffffe097          	auipc	ra,0xffffe
    80004440:	01c080e7          	jalr	28(ra) # 80002458 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004444:	0184b783          	ld	a5,24(s1)
    80004448:	0104b703          	ld	a4,16(s1)
    8000444c:	04e78063          	beq	a5,a4,8000448c <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004450:	0000a717          	auipc	a4,0xa
    80004454:	96070713          	addi	a4,a4,-1696 # 8000ddb0 <_ZN11ConsoleUtil11inputBufferE>
    80004458:	00f70733          	add	a4,a4,a5
    8000445c:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004460:	00178793          	addi	a5,a5,1
    80004464:	00002737          	lui	a4,0x2
    80004468:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    8000446c:	00e7f7b3          	and	a5,a5,a4
    80004470:	00008717          	auipc	a4,0x8
    80004474:	92f73023          	sd	a5,-1760(a4) # 8000bd90 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004478:	01813083          	ld	ra,24(sp)
    8000447c:	01013403          	ld	s0,16(sp)
    80004480:	00813483          	ld	s1,8(sp)
    80004484:	02010113          	addi	sp,sp,32
    80004488:	00008067          	ret
        return -1;
    8000448c:	0ff00513          	li	a0,255
    80004490:	fe9ff06f          	j	80004478 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004494 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004494:	00008797          	auipc	a5,0x8
    80004498:	8e478793          	addi	a5,a5,-1820 # 8000bd78 <_ZN11ConsoleUtil8inputSemE>
    8000449c:	0207b603          	ld	a2,32(a5)
    800044a0:	00160713          	addi	a4,a2,1
    800044a4:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    800044a8:	0287b583          	ld	a1,40(a5)
    800044ac:	00158713          	addi	a4,a1,1
    800044b0:	000026b7          	lui	a3,0x2
    800044b4:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    800044b8:	00d77733          	and	a4,a4,a3
    800044bc:	0307b783          	ld	a5,48(a5)
    800044c0:	04f70863          	beq	a4,a5,80004510 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    800044c4:	ff010113          	addi	sp,sp,-16
    800044c8:	00113423          	sd	ra,8(sp)
    800044cc:	00813023          	sd	s0,0(sp)
    800044d0:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800044d4:	00008797          	auipc	a5,0x8
    800044d8:	8dc78793          	addi	a5,a5,-1828 # 8000bdb0 <_ZN11ConsoleUtil12outputBufferE>
    800044dc:	00b785b3          	add	a1,a5,a1
    800044e0:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    800044e4:	00008797          	auipc	a5,0x8
    800044e8:	89478793          	addi	a5,a5,-1900 # 8000bd78 <_ZN11ConsoleUtil8inputSemE>
    800044ec:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    800044f0:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    800044f4:	0087b503          	ld	a0,8(a5)
    800044f8:	ffffe097          	auipc	ra,0xffffe
    800044fc:	fb0080e7          	jalr	-80(ra) # 800024a8 <_ZN3SCB6signalEv>
}
    80004500:	00813083          	ld	ra,8(sp)
    80004504:	00013403          	ld	s0,0(sp)
    80004508:	01010113          	addi	sp,sp,16
    8000450c:	00008067          	ret
    80004510:	00008067          	ret

0000000080004514 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004514:	fe010113          	addi	sp,sp,-32
    80004518:	00113c23          	sd	ra,24(sp)
    8000451c:	00813823          	sd	s0,16(sp)
    80004520:	00913423          	sd	s1,8(sp)
    80004524:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004528:	00008497          	auipc	s1,0x8
    8000452c:	85048493          	addi	s1,s1,-1968 # 8000bd78 <_ZN11ConsoleUtil8inputSemE>
    80004530:	0084b503          	ld	a0,8(s1)
    80004534:	ffffe097          	auipc	ra,0xffffe
    80004538:	f24080e7          	jalr	-220(ra) # 80002458 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000453c:	0304b783          	ld	a5,48(s1)
    80004540:	0284b703          	ld	a4,40(s1)
    80004544:	04e78063          	beq	a5,a4,80004584 <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004548:	00008717          	auipc	a4,0x8
    8000454c:	86870713          	addi	a4,a4,-1944 # 8000bdb0 <_ZN11ConsoleUtil12outputBufferE>
    80004550:	00f70733          	add	a4,a4,a5
    80004554:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004558:	00178793          	addi	a5,a5,1
    8000455c:	00002737          	lui	a4,0x2
    80004560:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004564:	00e7f7b3          	and	a5,a5,a4
    80004568:	00008717          	auipc	a4,0x8
    8000456c:	84f73023          	sd	a5,-1984(a4) # 8000bda8 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004570:	01813083          	ld	ra,24(sp)
    80004574:	01013403          	ld	s0,16(sp)
    80004578:	00813483          	ld	s1,8(sp)
    8000457c:	02010113          	addi	sp,sp,32
    80004580:	00008067          	ret
        return -1;
    80004584:	0ff00513          	li	a0,255
    80004588:	fe9ff06f          	j	80004570 <_ZN11ConsoleUtil9getOutputEv+0x5c>

000000008000458c <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    8000458c:	fe010113          	addi	sp,sp,-32
    80004590:	00113c23          	sd	ra,24(sp)
    80004594:	00813823          	sd	s0,16(sp)
    80004598:	00913423          	sd	s1,8(sp)
    8000459c:	02010413          	addi	s0,sp,32
    800045a0:	00050493          	mv	s1,a0
    while (*string != '\0')
    800045a4:	0004c503          	lbu	a0,0(s1)
    800045a8:	00050a63          	beqz	a0,800045bc <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    800045ac:	00000097          	auipc	ra,0x0
    800045b0:	ee8080e7          	jalr	-280(ra) # 80004494 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800045b4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800045b8:	fedff06f          	j	800045a4 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800045bc:	01813083          	ld	ra,24(sp)
    800045c0:	01013403          	ld	s0,16(sp)
    800045c4:	00813483          	ld	s1,8(sp)
    800045c8:	02010113          	addi	sp,sp,32
    800045cc:	00008067          	ret

00000000800045d0 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800045d0:	fb010113          	addi	sp,sp,-80
    800045d4:	04113423          	sd	ra,72(sp)
    800045d8:	04813023          	sd	s0,64(sp)
    800045dc:	02913c23          	sd	s1,56(sp)
    800045e0:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800045e4:	00005797          	auipc	a5,0x5
    800045e8:	db478793          	addi	a5,a5,-588 # 80009398 <CONSOLE_STATUS+0x388>
    800045ec:	0007b703          	ld	a4,0(a5)
    800045f0:	fce43423          	sd	a4,-56(s0)
    800045f4:	0087b703          	ld	a4,8(a5)
    800045f8:	fce43823          	sd	a4,-48(s0)
    800045fc:	0107c783          	lbu	a5,16(a5)
    80004600:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004604:	00060463          	beqz	a2,8000460c <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004608:	08054263          	bltz	a0,8000468c <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000460c:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004610:	00000813          	li	a6,0
    }

    i = 0;
    80004614:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004618:	0005871b          	sext.w	a4,a1
    8000461c:	02b577bb          	remuw	a5,a0,a1
    80004620:	00048693          	mv	a3,s1
    80004624:	0014849b          	addiw	s1,s1,1
    80004628:	02079793          	slli	a5,a5,0x20
    8000462c:	0207d793          	srli	a5,a5,0x20
    80004630:	fe040613          	addi	a2,s0,-32
    80004634:	00f607b3          	add	a5,a2,a5
    80004638:	fe87c603          	lbu	a2,-24(a5)
    8000463c:	fe040793          	addi	a5,s0,-32
    80004640:	00d787b3          	add	a5,a5,a3
    80004644:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004648:	0005061b          	sext.w	a2,a0
    8000464c:	02b5553b          	divuw	a0,a0,a1
    80004650:	fce674e3          	bgeu	a2,a4,80004618 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004654:	00080c63          	beqz	a6,8000466c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004658:	fe040793          	addi	a5,s0,-32
    8000465c:	009784b3          	add	s1,a5,s1
    80004660:	02d00793          	li	a5,45
    80004664:	fcf48c23          	sb	a5,-40(s1)
    80004668:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000466c:	fff4849b          	addiw	s1,s1,-1
    80004670:	0204c463          	bltz	s1,80004698 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004674:	fe040793          	addi	a5,s0,-32
    80004678:	009787b3          	add	a5,a5,s1
    8000467c:	fd87c503          	lbu	a0,-40(a5)
    80004680:	00000097          	auipc	ra,0x0
    80004684:	e14080e7          	jalr	-492(ra) # 80004494 <_ZN11ConsoleUtil9putOutputEc>
    80004688:	fe5ff06f          	j	8000466c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    8000468c:	40a0053b          	negw	a0,a0
        neg = 1;
    80004690:	00100813          	li	a6,1
        x = -xx;
    80004694:	f81ff06f          	j	80004614 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004698:	04813083          	ld	ra,72(sp)
    8000469c:	04013403          	ld	s0,64(sp)
    800046a0:	03813483          	ld	s1,56(sp)
    800046a4:	05010113          	addi	sp,sp,80
    800046a8:	00008067          	ret

00000000800046ac <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    800046ac:	fe010113          	addi	sp,sp,-32
    800046b0:	00113c23          	sd	ra,24(sp)
    800046b4:	00813823          	sd	s0,16(sp)
    800046b8:	00913423          	sd	s1,8(sp)
    800046bc:	01213023          	sd	s2,0(sp)
    800046c0:	02010413          	addi	s0,sp,32
    800046c4:	00058913          	mv	s2,a1
    800046c8:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    800046cc:	00000097          	auipc	ra,0x0
    800046d0:	ec0080e7          	jalr	-320(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    800046d4:	00000613          	li	a2,0
    800046d8:	00a00593          	li	a1,10
    800046dc:	00090513          	mv	a0,s2
    800046e0:	00000097          	auipc	ra,0x0
    800046e4:	ef0080e7          	jalr	-272(ra) # 800045d0 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    800046e8:	00048513          	mv	a0,s1
    800046ec:	00000097          	auipc	ra,0x0
    800046f0:	ea0080e7          	jalr	-352(ra) # 8000458c <_ZN11ConsoleUtil11printStringEPKc>
}
    800046f4:	01813083          	ld	ra,24(sp)
    800046f8:	01013403          	ld	s0,16(sp)
    800046fc:	00813483          	ld	s1,8(sp)
    80004700:	00013903          	ld	s2,0(sp)
    80004704:	02010113          	addi	sp,sp,32
    80004708:	00008067          	ret

000000008000470c <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    8000470c:	ff010113          	addi	sp,sp,-16
    80004710:	00813423          	sd	s0,8(sp)
    80004714:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004718:	04300513          	li	a0,67

    asm("ecall");
    8000471c:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004720:	00050513          	mv	a0,a0

    return (char)status;
}
    80004724:	0ff57513          	andi	a0,a0,255
    80004728:	00813403          	ld	s0,8(sp)
    8000472c:	01010113          	addi	sp,sp,16
    80004730:	00008067          	ret

0000000080004734 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004734:	ff010113          	addi	sp,sp,-16
    80004738:	00113423          	sd	ra,8(sp)
    8000473c:	00813023          	sd	s0,0(sp)
    80004740:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004744:	ffffd097          	auipc	ra,0xffffd
    80004748:	e20080e7          	jalr	-480(ra) # 80001564 <_ZN13SlabAllocator10initializeEPvm>
    8000474c:	00813083          	ld	ra,8(sp)
    80004750:	00013403          	ld	s0,0(sp)
    80004754:	01010113          	addi	sp,sp,16
    80004758:	00008067          	ret

000000008000475c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000475c:	fd010113          	addi	sp,sp,-48
    80004760:	02113423          	sd	ra,40(sp)
    80004764:	02813023          	sd	s0,32(sp)
    80004768:	00913c23          	sd	s1,24(sp)
    8000476c:	01213823          	sd	s2,16(sp)
    80004770:	01313423          	sd	s3,8(sp)
    80004774:	03010413          	addi	s0,sp,48
    80004778:	00050493          	mv	s1,a0
    8000477c:	00058913          	mv	s2,a1
    80004780:	0015879b          	addiw	a5,a1,1
    80004784:	0007851b          	sext.w	a0,a5
    80004788:	00f4a023          	sw	a5,0(s1)
    8000478c:	0004a823          	sw	zero,16(s1)
    80004790:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004794:	00251513          	slli	a0,a0,0x2
    80004798:	ffffd097          	auipc	ra,0xffffd
    8000479c:	e64080e7          	jalr	-412(ra) # 800015fc <_Z9mem_allocm>
    800047a0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800047a4:	01000513          	li	a0,16
    800047a8:	ffffe097          	auipc	ra,0xffffe
    800047ac:	600080e7          	jalr	1536(ra) # 80002da8 <_Znwm>
    800047b0:	00050993          	mv	s3,a0
    800047b4:	00000593          	li	a1,0
    800047b8:	ffffe097          	auipc	ra,0xffffe
    800047bc:	6e8080e7          	jalr	1768(ra) # 80002ea0 <_ZN9SemaphoreC1Ej>
    800047c0:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800047c4:	01000513          	li	a0,16
    800047c8:	ffffe097          	auipc	ra,0xffffe
    800047cc:	5e0080e7          	jalr	1504(ra) # 80002da8 <_Znwm>
    800047d0:	00050993          	mv	s3,a0
    800047d4:	00090593          	mv	a1,s2
    800047d8:	ffffe097          	auipc	ra,0xffffe
    800047dc:	6c8080e7          	jalr	1736(ra) # 80002ea0 <_ZN9SemaphoreC1Ej>
    800047e0:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800047e4:	01000513          	li	a0,16
    800047e8:	ffffe097          	auipc	ra,0xffffe
    800047ec:	5c0080e7          	jalr	1472(ra) # 80002da8 <_Znwm>
    800047f0:	00050913          	mv	s2,a0
    800047f4:	00100593          	li	a1,1
    800047f8:	ffffe097          	auipc	ra,0xffffe
    800047fc:	6a8080e7          	jalr	1704(ra) # 80002ea0 <_ZN9SemaphoreC1Ej>
    80004800:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004804:	01000513          	li	a0,16
    80004808:	ffffe097          	auipc	ra,0xffffe
    8000480c:	5a0080e7          	jalr	1440(ra) # 80002da8 <_Znwm>
    80004810:	00050913          	mv	s2,a0
    80004814:	00100593          	li	a1,1
    80004818:	ffffe097          	auipc	ra,0xffffe
    8000481c:	688080e7          	jalr	1672(ra) # 80002ea0 <_ZN9SemaphoreC1Ej>
    80004820:	0324b823          	sd	s2,48(s1)
}
    80004824:	02813083          	ld	ra,40(sp)
    80004828:	02013403          	ld	s0,32(sp)
    8000482c:	01813483          	ld	s1,24(sp)
    80004830:	01013903          	ld	s2,16(sp)
    80004834:	00813983          	ld	s3,8(sp)
    80004838:	03010113          	addi	sp,sp,48
    8000483c:	00008067          	ret
    80004840:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004844:	00098513          	mv	a0,s3
    80004848:	ffffe097          	auipc	ra,0xffffe
    8000484c:	5b0080e7          	jalr	1456(ra) # 80002df8 <_ZdlPv>
    80004850:	00048513          	mv	a0,s1
    80004854:	0000c097          	auipc	ra,0xc
    80004858:	654080e7          	jalr	1620(ra) # 80010ea8 <_Unwind_Resume>
    8000485c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004860:	00098513          	mv	a0,s3
    80004864:	ffffe097          	auipc	ra,0xffffe
    80004868:	594080e7          	jalr	1428(ra) # 80002df8 <_ZdlPv>
    8000486c:	00048513          	mv	a0,s1
    80004870:	0000c097          	auipc	ra,0xc
    80004874:	638080e7          	jalr	1592(ra) # 80010ea8 <_Unwind_Resume>
    80004878:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000487c:	00090513          	mv	a0,s2
    80004880:	ffffe097          	auipc	ra,0xffffe
    80004884:	578080e7          	jalr	1400(ra) # 80002df8 <_ZdlPv>
    80004888:	00048513          	mv	a0,s1
    8000488c:	0000c097          	auipc	ra,0xc
    80004890:	61c080e7          	jalr	1564(ra) # 80010ea8 <_Unwind_Resume>
    80004894:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004898:	00090513          	mv	a0,s2
    8000489c:	ffffe097          	auipc	ra,0xffffe
    800048a0:	55c080e7          	jalr	1372(ra) # 80002df8 <_ZdlPv>
    800048a4:	00048513          	mv	a0,s1
    800048a8:	0000c097          	auipc	ra,0xc
    800048ac:	600080e7          	jalr	1536(ra) # 80010ea8 <_Unwind_Resume>

00000000800048b0 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800048b0:	fe010113          	addi	sp,sp,-32
    800048b4:	00113c23          	sd	ra,24(sp)
    800048b8:	00813823          	sd	s0,16(sp)
    800048bc:	00913423          	sd	s1,8(sp)
    800048c0:	01213023          	sd	s2,0(sp)
    800048c4:	02010413          	addi	s0,sp,32
    800048c8:	00050493          	mv	s1,a0
    800048cc:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800048d0:	01853503          	ld	a0,24(a0)
    800048d4:	ffffe097          	auipc	ra,0xffffe
    800048d8:	604080e7          	jalr	1540(ra) # 80002ed8 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800048dc:	0304b503          	ld	a0,48(s1)
    800048e0:	ffffe097          	auipc	ra,0xffffe
    800048e4:	5f8080e7          	jalr	1528(ra) # 80002ed8 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800048e8:	0084b783          	ld	a5,8(s1)
    800048ec:	0144a703          	lw	a4,20(s1)
    800048f0:	00271713          	slli	a4,a4,0x2
    800048f4:	00e787b3          	add	a5,a5,a4
    800048f8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800048fc:	0144a783          	lw	a5,20(s1)
    80004900:	0017879b          	addiw	a5,a5,1
    80004904:	0004a703          	lw	a4,0(s1)
    80004908:	02e7e7bb          	remw	a5,a5,a4
    8000490c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004910:	0304b503          	ld	a0,48(s1)
    80004914:	ffffe097          	auipc	ra,0xffffe
    80004918:	5f0080e7          	jalr	1520(ra) # 80002f04 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000491c:	0204b503          	ld	a0,32(s1)
    80004920:	ffffe097          	auipc	ra,0xffffe
    80004924:	5e4080e7          	jalr	1508(ra) # 80002f04 <_ZN9Semaphore6signalEv>

}
    80004928:	01813083          	ld	ra,24(sp)
    8000492c:	01013403          	ld	s0,16(sp)
    80004930:	00813483          	ld	s1,8(sp)
    80004934:	00013903          	ld	s2,0(sp)
    80004938:	02010113          	addi	sp,sp,32
    8000493c:	00008067          	ret

0000000080004940 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004940:	fe010113          	addi	sp,sp,-32
    80004944:	00113c23          	sd	ra,24(sp)
    80004948:	00813823          	sd	s0,16(sp)
    8000494c:	00913423          	sd	s1,8(sp)
    80004950:	01213023          	sd	s2,0(sp)
    80004954:	02010413          	addi	s0,sp,32
    80004958:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000495c:	02053503          	ld	a0,32(a0)
    80004960:	ffffe097          	auipc	ra,0xffffe
    80004964:	578080e7          	jalr	1400(ra) # 80002ed8 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004968:	0284b503          	ld	a0,40(s1)
    8000496c:	ffffe097          	auipc	ra,0xffffe
    80004970:	56c080e7          	jalr	1388(ra) # 80002ed8 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004974:	0084b703          	ld	a4,8(s1)
    80004978:	0104a783          	lw	a5,16(s1)
    8000497c:	00279693          	slli	a3,a5,0x2
    80004980:	00d70733          	add	a4,a4,a3
    80004984:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004988:	0017879b          	addiw	a5,a5,1
    8000498c:	0004a703          	lw	a4,0(s1)
    80004990:	02e7e7bb          	remw	a5,a5,a4
    80004994:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004998:	0284b503          	ld	a0,40(s1)
    8000499c:	ffffe097          	auipc	ra,0xffffe
    800049a0:	568080e7          	jalr	1384(ra) # 80002f04 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800049a4:	0184b503          	ld	a0,24(s1)
    800049a8:	ffffe097          	auipc	ra,0xffffe
    800049ac:	55c080e7          	jalr	1372(ra) # 80002f04 <_ZN9Semaphore6signalEv>

    return ret;
}
    800049b0:	00090513          	mv	a0,s2
    800049b4:	01813083          	ld	ra,24(sp)
    800049b8:	01013403          	ld	s0,16(sp)
    800049bc:	00813483          	ld	s1,8(sp)
    800049c0:	00013903          	ld	s2,0(sp)
    800049c4:	02010113          	addi	sp,sp,32
    800049c8:	00008067          	ret

00000000800049cc <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800049cc:	fe010113          	addi	sp,sp,-32
    800049d0:	00113c23          	sd	ra,24(sp)
    800049d4:	00813823          	sd	s0,16(sp)
    800049d8:	00913423          	sd	s1,8(sp)
    800049dc:	01213023          	sd	s2,0(sp)
    800049e0:	02010413          	addi	s0,sp,32
    800049e4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800049e8:	02853503          	ld	a0,40(a0)
    800049ec:	ffffe097          	auipc	ra,0xffffe
    800049f0:	4ec080e7          	jalr	1260(ra) # 80002ed8 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800049f4:	0304b503          	ld	a0,48(s1)
    800049f8:	ffffe097          	auipc	ra,0xffffe
    800049fc:	4e0080e7          	jalr	1248(ra) # 80002ed8 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004a00:	0144a783          	lw	a5,20(s1)
    80004a04:	0104a903          	lw	s2,16(s1)
    80004a08:	0327ce63          	blt	a5,s2,80004a44 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004a0c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004a10:	0304b503          	ld	a0,48(s1)
    80004a14:	ffffe097          	auipc	ra,0xffffe
    80004a18:	4f0080e7          	jalr	1264(ra) # 80002f04 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004a1c:	0284b503          	ld	a0,40(s1)
    80004a20:	ffffe097          	auipc	ra,0xffffe
    80004a24:	4e4080e7          	jalr	1252(ra) # 80002f04 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004a28:	00090513          	mv	a0,s2
    80004a2c:	01813083          	ld	ra,24(sp)
    80004a30:	01013403          	ld	s0,16(sp)
    80004a34:	00813483          	ld	s1,8(sp)
    80004a38:	00013903          	ld	s2,0(sp)
    80004a3c:	02010113          	addi	sp,sp,32
    80004a40:	00008067          	ret
        ret = cap - head + tail;
    80004a44:	0004a703          	lw	a4,0(s1)
    80004a48:	4127093b          	subw	s2,a4,s2
    80004a4c:	00f9093b          	addw	s2,s2,a5
    80004a50:	fc1ff06f          	j	80004a10 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004a54 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004a54:	fe010113          	addi	sp,sp,-32
    80004a58:	00113c23          	sd	ra,24(sp)
    80004a5c:	00813823          	sd	s0,16(sp)
    80004a60:	00913423          	sd	s1,8(sp)
    80004a64:	02010413          	addi	s0,sp,32
    80004a68:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004a6c:	00a00513          	li	a0,10
    80004a70:	ffffe097          	auipc	ra,0xffffe
    80004a74:	690080e7          	jalr	1680(ra) # 80003100 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004a78:	00005517          	auipc	a0,0x5
    80004a7c:	93850513          	addi	a0,a0,-1736 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80004a80:	ffffd097          	auipc	ra,0xffffd
    80004a84:	5fc080e7          	jalr	1532(ra) # 8000207c <_Z11printStringPKc>
    while (getCnt()) {
    80004a88:	00048513          	mv	a0,s1
    80004a8c:	00000097          	auipc	ra,0x0
    80004a90:	f40080e7          	jalr	-192(ra) # 800049cc <_ZN9BufferCPP6getCntEv>
    80004a94:	02050c63          	beqz	a0,80004acc <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004a98:	0084b783          	ld	a5,8(s1)
    80004a9c:	0104a703          	lw	a4,16(s1)
    80004aa0:	00271713          	slli	a4,a4,0x2
    80004aa4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004aa8:	0007c503          	lbu	a0,0(a5)
    80004aac:	ffffe097          	auipc	ra,0xffffe
    80004ab0:	654080e7          	jalr	1620(ra) # 80003100 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004ab4:	0104a783          	lw	a5,16(s1)
    80004ab8:	0017879b          	addiw	a5,a5,1
    80004abc:	0004a703          	lw	a4,0(s1)
    80004ac0:	02e7e7bb          	remw	a5,a5,a4
    80004ac4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004ac8:	fc1ff06f          	j	80004a88 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004acc:	02100513          	li	a0,33
    80004ad0:	ffffe097          	auipc	ra,0xffffe
    80004ad4:	630080e7          	jalr	1584(ra) # 80003100 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004ad8:	00a00513          	li	a0,10
    80004adc:	ffffe097          	auipc	ra,0xffffe
    80004ae0:	624080e7          	jalr	1572(ra) # 80003100 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004ae4:	0084b503          	ld	a0,8(s1)
    80004ae8:	ffffd097          	auipc	ra,0xffffd
    80004aec:	b44080e7          	jalr	-1212(ra) # 8000162c <_Z8mem_freePv>
    delete itemAvailable;
    80004af0:	0204b503          	ld	a0,32(s1)
    80004af4:	00050863          	beqz	a0,80004b04 <_ZN9BufferCPPD1Ev+0xb0>
    80004af8:	00053783          	ld	a5,0(a0)
    80004afc:	0087b783          	ld	a5,8(a5)
    80004b00:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004b04:	0184b503          	ld	a0,24(s1)
    80004b08:	00050863          	beqz	a0,80004b18 <_ZN9BufferCPPD1Ev+0xc4>
    80004b0c:	00053783          	ld	a5,0(a0)
    80004b10:	0087b783          	ld	a5,8(a5)
    80004b14:	000780e7          	jalr	a5
    delete mutexTail;
    80004b18:	0304b503          	ld	a0,48(s1)
    80004b1c:	00050863          	beqz	a0,80004b2c <_ZN9BufferCPPD1Ev+0xd8>
    80004b20:	00053783          	ld	a5,0(a0)
    80004b24:	0087b783          	ld	a5,8(a5)
    80004b28:	000780e7          	jalr	a5
    delete mutexHead;
    80004b2c:	0284b503          	ld	a0,40(s1)
    80004b30:	00050863          	beqz	a0,80004b40 <_ZN9BufferCPPD1Ev+0xec>
    80004b34:	00053783          	ld	a5,0(a0)
    80004b38:	0087b783          	ld	a5,8(a5)
    80004b3c:	000780e7          	jalr	a5
}
    80004b40:	01813083          	ld	ra,24(sp)
    80004b44:	01013403          	ld	s0,16(sp)
    80004b48:	00813483          	ld	s1,8(sp)
    80004b4c:	02010113          	addi	sp,sp,32
    80004b50:	00008067          	ret

0000000080004b54 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80004b54:	fe010113          	addi	sp,sp,-32
    80004b58:	00113c23          	sd	ra,24(sp)
    80004b5c:	00813823          	sd	s0,16(sp)
    80004b60:	00913423          	sd	s1,8(sp)
    80004b64:	01213023          	sd	s2,0(sp)
    80004b68:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004b6c:	00000913          	li	s2,0
    80004b70:	0380006f          	j	80004ba8 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004b74:	ffffd097          	auipc	ra,0xffffd
    80004b78:	b88080e7          	jalr	-1144(ra) # 800016fc <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004b7c:	00148493          	addi	s1,s1,1
    80004b80:	000027b7          	lui	a5,0x2
    80004b84:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004b88:	0097ee63          	bltu	a5,s1,80004ba4 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004b8c:	00000713          	li	a4,0
    80004b90:	000077b7          	lui	a5,0x7
    80004b94:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004b98:	fce7eee3          	bltu	a5,a4,80004b74 <_Z11workerBodyAPv+0x20>
    80004b9c:	00170713          	addi	a4,a4,1
    80004ba0:	ff1ff06f          	j	80004b90 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004ba4:	00190913          	addi	s2,s2,1
    80004ba8:	00900793          	li	a5,9
    80004bac:	0527e063          	bltu	a5,s2,80004bec <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004bb0:	00005517          	auipc	a0,0x5
    80004bb4:	81850513          	addi	a0,a0,-2024 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80004bb8:	ffffd097          	auipc	ra,0xffffd
    80004bbc:	4c4080e7          	jalr	1220(ra) # 8000207c <_Z11printStringPKc>
    80004bc0:	00000613          	li	a2,0
    80004bc4:	00a00593          	li	a1,10
    80004bc8:	0009051b          	sext.w	a0,s2
    80004bcc:	ffffd097          	auipc	ra,0xffffd
    80004bd0:	648080e7          	jalr	1608(ra) # 80002214 <_Z8printIntiii>
    80004bd4:	00004517          	auipc	a0,0x4
    80004bd8:	5cc50513          	addi	a0,a0,1484 # 800091a0 <CONSOLE_STATUS+0x190>
    80004bdc:	ffffd097          	auipc	ra,0xffffd
    80004be0:	4a0080e7          	jalr	1184(ra) # 8000207c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004be4:	00000493          	li	s1,0
    80004be8:	f99ff06f          	j	80004b80 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004bec:	00004517          	auipc	a0,0x4
    80004bf0:	7e450513          	addi	a0,a0,2020 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004bf4:	ffffd097          	auipc	ra,0xffffd
    80004bf8:	488080e7          	jalr	1160(ra) # 8000207c <_Z11printStringPKc>
    finishedA = true;
    80004bfc:	00100793          	li	a5,1
    80004c00:	0000b717          	auipc	a4,0xb
    80004c04:	1af70c23          	sb	a5,440(a4) # 8000fdb8 <finishedA>
}
    80004c08:	01813083          	ld	ra,24(sp)
    80004c0c:	01013403          	ld	s0,16(sp)
    80004c10:	00813483          	ld	s1,8(sp)
    80004c14:	00013903          	ld	s2,0(sp)
    80004c18:	02010113          	addi	sp,sp,32
    80004c1c:	00008067          	ret

0000000080004c20 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80004c20:	fe010113          	addi	sp,sp,-32
    80004c24:	00113c23          	sd	ra,24(sp)
    80004c28:	00813823          	sd	s0,16(sp)
    80004c2c:	00913423          	sd	s1,8(sp)
    80004c30:	01213023          	sd	s2,0(sp)
    80004c34:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004c38:	00000913          	li	s2,0
    80004c3c:	0380006f          	j	80004c74 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004c40:	ffffd097          	auipc	ra,0xffffd
    80004c44:	abc080e7          	jalr	-1348(ra) # 800016fc <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004c48:	00148493          	addi	s1,s1,1
    80004c4c:	000027b7          	lui	a5,0x2
    80004c50:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004c54:	0097ee63          	bltu	a5,s1,80004c70 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004c58:	00000713          	li	a4,0
    80004c5c:	000077b7          	lui	a5,0x7
    80004c60:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004c64:	fce7eee3          	bltu	a5,a4,80004c40 <_Z11workerBodyBPv+0x20>
    80004c68:	00170713          	addi	a4,a4,1
    80004c6c:	ff1ff06f          	j	80004c5c <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004c70:	00190913          	addi	s2,s2,1
    80004c74:	00f00793          	li	a5,15
    80004c78:	0527e063          	bltu	a5,s2,80004cb8 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004c7c:	00004517          	auipc	a0,0x4
    80004c80:	76450513          	addi	a0,a0,1892 # 800093e0 <CONSOLE_STATUS+0x3d0>
    80004c84:	ffffd097          	auipc	ra,0xffffd
    80004c88:	3f8080e7          	jalr	1016(ra) # 8000207c <_Z11printStringPKc>
    80004c8c:	00000613          	li	a2,0
    80004c90:	00a00593          	li	a1,10
    80004c94:	0009051b          	sext.w	a0,s2
    80004c98:	ffffd097          	auipc	ra,0xffffd
    80004c9c:	57c080e7          	jalr	1404(ra) # 80002214 <_Z8printIntiii>
    80004ca0:	00004517          	auipc	a0,0x4
    80004ca4:	50050513          	addi	a0,a0,1280 # 800091a0 <CONSOLE_STATUS+0x190>
    80004ca8:	ffffd097          	auipc	ra,0xffffd
    80004cac:	3d4080e7          	jalr	980(ra) # 8000207c <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004cb0:	00000493          	li	s1,0
    80004cb4:	f99ff06f          	j	80004c4c <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004cb8:	00004517          	auipc	a0,0x4
    80004cbc:	73050513          	addi	a0,a0,1840 # 800093e8 <CONSOLE_STATUS+0x3d8>
    80004cc0:	ffffd097          	auipc	ra,0xffffd
    80004cc4:	3bc080e7          	jalr	956(ra) # 8000207c <_Z11printStringPKc>
    finishedB = true;
    80004cc8:	00100793          	li	a5,1
    80004ccc:	0000b717          	auipc	a4,0xb
    80004cd0:	0ef706a3          	sb	a5,237(a4) # 8000fdb9 <finishedB>
    thread_dispatch();
    80004cd4:	ffffd097          	auipc	ra,0xffffd
    80004cd8:	a28080e7          	jalr	-1496(ra) # 800016fc <_Z15thread_dispatchv>
}
    80004cdc:	01813083          	ld	ra,24(sp)
    80004ce0:	01013403          	ld	s0,16(sp)
    80004ce4:	00813483          	ld	s1,8(sp)
    80004ce8:	00013903          	ld	s2,0(sp)
    80004cec:	02010113          	addi	sp,sp,32
    80004cf0:	00008067          	ret

0000000080004cf4 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80004cf4:	fe010113          	addi	sp,sp,-32
    80004cf8:	00113c23          	sd	ra,24(sp)
    80004cfc:	00813823          	sd	s0,16(sp)
    80004d00:	00913423          	sd	s1,8(sp)
    80004d04:	01213023          	sd	s2,0(sp)
    80004d08:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80004d0c:	00053903          	ld	s2,0(a0)
    int i = 6;
    80004d10:	00600493          	li	s1,6
    while (--i > 0) {
    80004d14:	fff4849b          	addiw	s1,s1,-1
    80004d18:	04905463          	blez	s1,80004d60 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80004d1c:	00004517          	auipc	a0,0x4
    80004d20:	6dc50513          	addi	a0,a0,1756 # 800093f8 <CONSOLE_STATUS+0x3e8>
    80004d24:	ffffd097          	auipc	ra,0xffffd
    80004d28:	358080e7          	jalr	856(ra) # 8000207c <_Z11printStringPKc>
        printInt(sleep_time);
    80004d2c:	00000613          	li	a2,0
    80004d30:	00a00593          	li	a1,10
    80004d34:	0009051b          	sext.w	a0,s2
    80004d38:	ffffd097          	auipc	ra,0xffffd
    80004d3c:	4dc080e7          	jalr	1244(ra) # 80002214 <_Z8printIntiii>
        printString(" !\n");
    80004d40:	00004517          	auipc	a0,0x4
    80004d44:	6c050513          	addi	a0,a0,1728 # 80009400 <CONSOLE_STATUS+0x3f0>
    80004d48:	ffffd097          	auipc	ra,0xffffd
    80004d4c:	334080e7          	jalr	820(ra) # 8000207c <_Z11printStringPKc>
        time_sleep(sleep_time);
    80004d50:	00090513          	mv	a0,s2
    80004d54:	ffffd097          	auipc	ra,0xffffd
    80004d58:	b2c080e7          	jalr	-1236(ra) # 80001880 <_Z10time_sleepm>
    while (--i > 0) {
    80004d5c:	fb9ff06f          	j	80004d14 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80004d60:	00a00793          	li	a5,10
    80004d64:	02f95933          	divu	s2,s2,a5
    80004d68:	fff90913          	addi	s2,s2,-1
    80004d6c:	0000b797          	auipc	a5,0xb
    80004d70:	04c78793          	addi	a5,a5,76 # 8000fdb8 <finishedA>
    80004d74:	01278933          	add	s2,a5,s2
    80004d78:	00100793          	li	a5,1
    80004d7c:	00f90423          	sb	a5,8(s2)
}
    80004d80:	01813083          	ld	ra,24(sp)
    80004d84:	01013403          	ld	s0,16(sp)
    80004d88:	00813483          	ld	s1,8(sp)
    80004d8c:	00013903          	ld	s2,0(sp)
    80004d90:	02010113          	addi	sp,sp,32
    80004d94:	00008067          	ret

0000000080004d98 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80004d98:	fe010113          	addi	sp,sp,-32
    80004d9c:	00113c23          	sd	ra,24(sp)
    80004da0:	00813823          	sd	s0,16(sp)
    80004da4:	00913423          	sd	s1,8(sp)
    80004da8:	01213023          	sd	s2,0(sp)
    80004dac:	02010413          	addi	s0,sp,32
    80004db0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004db4:	00100793          	li	a5,1
    80004db8:	02a7f863          	bgeu	a5,a0,80004de8 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004dbc:	00a00793          	li	a5,10
    80004dc0:	02f577b3          	remu	a5,a0,a5
    80004dc4:	02078e63          	beqz	a5,80004e00 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004dc8:	fff48513          	addi	a0,s1,-1
    80004dcc:	00000097          	auipc	ra,0x0
    80004dd0:	fcc080e7          	jalr	-52(ra) # 80004d98 <_Z9fibonaccim>
    80004dd4:	00050913          	mv	s2,a0
    80004dd8:	ffe48513          	addi	a0,s1,-2
    80004ddc:	00000097          	auipc	ra,0x0
    80004de0:	fbc080e7          	jalr	-68(ra) # 80004d98 <_Z9fibonaccim>
    80004de4:	00a90533          	add	a0,s2,a0
}
    80004de8:	01813083          	ld	ra,24(sp)
    80004dec:	01013403          	ld	s0,16(sp)
    80004df0:	00813483          	ld	s1,8(sp)
    80004df4:	00013903          	ld	s2,0(sp)
    80004df8:	02010113          	addi	sp,sp,32
    80004dfc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004e00:	ffffd097          	auipc	ra,0xffffd
    80004e04:	8fc080e7          	jalr	-1796(ra) # 800016fc <_Z15thread_dispatchv>
    80004e08:	fc1ff06f          	j	80004dc8 <_Z9fibonaccim+0x30>

0000000080004e0c <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80004e0c:	fe010113          	addi	sp,sp,-32
    80004e10:	00113c23          	sd	ra,24(sp)
    80004e14:	00813823          	sd	s0,16(sp)
    80004e18:	00913423          	sd	s1,8(sp)
    80004e1c:	01213023          	sd	s2,0(sp)
    80004e20:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004e24:	00000493          	li	s1,0
    80004e28:	0400006f          	j	80004e68 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004e2c:	00004517          	auipc	a0,0x4
    80004e30:	5dc50513          	addi	a0,a0,1500 # 80009408 <CONSOLE_STATUS+0x3f8>
    80004e34:	ffffd097          	auipc	ra,0xffffd
    80004e38:	248080e7          	jalr	584(ra) # 8000207c <_Z11printStringPKc>
    80004e3c:	00000613          	li	a2,0
    80004e40:	00a00593          	li	a1,10
    80004e44:	00048513          	mv	a0,s1
    80004e48:	ffffd097          	auipc	ra,0xffffd
    80004e4c:	3cc080e7          	jalr	972(ra) # 80002214 <_Z8printIntiii>
    80004e50:	00004517          	auipc	a0,0x4
    80004e54:	35050513          	addi	a0,a0,848 # 800091a0 <CONSOLE_STATUS+0x190>
    80004e58:	ffffd097          	auipc	ra,0xffffd
    80004e5c:	224080e7          	jalr	548(ra) # 8000207c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004e60:	0014849b          	addiw	s1,s1,1
    80004e64:	0ff4f493          	andi	s1,s1,255
    80004e68:	00200793          	li	a5,2
    80004e6c:	fc97f0e3          	bgeu	a5,s1,80004e2c <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80004e70:	00004517          	auipc	a0,0x4
    80004e74:	5a050513          	addi	a0,a0,1440 # 80009410 <CONSOLE_STATUS+0x400>
    80004e78:	ffffd097          	auipc	ra,0xffffd
    80004e7c:	204080e7          	jalr	516(ra) # 8000207c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004e80:	00700313          	li	t1,7
    thread_dispatch();
    80004e84:	ffffd097          	auipc	ra,0xffffd
    80004e88:	878080e7          	jalr	-1928(ra) # 800016fc <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004e8c:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004e90:	00004517          	auipc	a0,0x4
    80004e94:	59050513          	addi	a0,a0,1424 # 80009420 <CONSOLE_STATUS+0x410>
    80004e98:	ffffd097          	auipc	ra,0xffffd
    80004e9c:	1e4080e7          	jalr	484(ra) # 8000207c <_Z11printStringPKc>
    80004ea0:	00000613          	li	a2,0
    80004ea4:	00a00593          	li	a1,10
    80004ea8:	0009051b          	sext.w	a0,s2
    80004eac:	ffffd097          	auipc	ra,0xffffd
    80004eb0:	368080e7          	jalr	872(ra) # 80002214 <_Z8printIntiii>
    80004eb4:	00004517          	auipc	a0,0x4
    80004eb8:	2ec50513          	addi	a0,a0,748 # 800091a0 <CONSOLE_STATUS+0x190>
    80004ebc:	ffffd097          	auipc	ra,0xffffd
    80004ec0:	1c0080e7          	jalr	448(ra) # 8000207c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004ec4:	00c00513          	li	a0,12
    80004ec8:	00000097          	auipc	ra,0x0
    80004ecc:	ed0080e7          	jalr	-304(ra) # 80004d98 <_Z9fibonaccim>
    80004ed0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004ed4:	00004517          	auipc	a0,0x4
    80004ed8:	55450513          	addi	a0,a0,1364 # 80009428 <CONSOLE_STATUS+0x418>
    80004edc:	ffffd097          	auipc	ra,0xffffd
    80004ee0:	1a0080e7          	jalr	416(ra) # 8000207c <_Z11printStringPKc>
    80004ee4:	00000613          	li	a2,0
    80004ee8:	00a00593          	li	a1,10
    80004eec:	0009051b          	sext.w	a0,s2
    80004ef0:	ffffd097          	auipc	ra,0xffffd
    80004ef4:	324080e7          	jalr	804(ra) # 80002214 <_Z8printIntiii>
    80004ef8:	00004517          	auipc	a0,0x4
    80004efc:	2a850513          	addi	a0,a0,680 # 800091a0 <CONSOLE_STATUS+0x190>
    80004f00:	ffffd097          	auipc	ra,0xffffd
    80004f04:	17c080e7          	jalr	380(ra) # 8000207c <_Z11printStringPKc>
    80004f08:	0400006f          	j	80004f48 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004f0c:	00004517          	auipc	a0,0x4
    80004f10:	4fc50513          	addi	a0,a0,1276 # 80009408 <CONSOLE_STATUS+0x3f8>
    80004f14:	ffffd097          	auipc	ra,0xffffd
    80004f18:	168080e7          	jalr	360(ra) # 8000207c <_Z11printStringPKc>
    80004f1c:	00000613          	li	a2,0
    80004f20:	00a00593          	li	a1,10
    80004f24:	00048513          	mv	a0,s1
    80004f28:	ffffd097          	auipc	ra,0xffffd
    80004f2c:	2ec080e7          	jalr	748(ra) # 80002214 <_Z8printIntiii>
    80004f30:	00004517          	auipc	a0,0x4
    80004f34:	27050513          	addi	a0,a0,624 # 800091a0 <CONSOLE_STATUS+0x190>
    80004f38:	ffffd097          	auipc	ra,0xffffd
    80004f3c:	144080e7          	jalr	324(ra) # 8000207c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004f40:	0014849b          	addiw	s1,s1,1
    80004f44:	0ff4f493          	andi	s1,s1,255
    80004f48:	00500793          	li	a5,5
    80004f4c:	fc97f0e3          	bgeu	a5,s1,80004f0c <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80004f50:	00004517          	auipc	a0,0x4
    80004f54:	48050513          	addi	a0,a0,1152 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004f58:	ffffd097          	auipc	ra,0xffffd
    80004f5c:	124080e7          	jalr	292(ra) # 8000207c <_Z11printStringPKc>
    finishedC = true;
    80004f60:	00100793          	li	a5,1
    80004f64:	0000b717          	auipc	a4,0xb
    80004f68:	e4f70f23          	sb	a5,-418(a4) # 8000fdc2 <finishedC>
    thread_dispatch();
    80004f6c:	ffffc097          	auipc	ra,0xffffc
    80004f70:	790080e7          	jalr	1936(ra) # 800016fc <_Z15thread_dispatchv>
}
    80004f74:	01813083          	ld	ra,24(sp)
    80004f78:	01013403          	ld	s0,16(sp)
    80004f7c:	00813483          	ld	s1,8(sp)
    80004f80:	00013903          	ld	s2,0(sp)
    80004f84:	02010113          	addi	sp,sp,32
    80004f88:	00008067          	ret

0000000080004f8c <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80004f8c:	fe010113          	addi	sp,sp,-32
    80004f90:	00113c23          	sd	ra,24(sp)
    80004f94:	00813823          	sd	s0,16(sp)
    80004f98:	00913423          	sd	s1,8(sp)
    80004f9c:	01213023          	sd	s2,0(sp)
    80004fa0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004fa4:	00a00493          	li	s1,10
    80004fa8:	0400006f          	j	80004fe8 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004fac:	00004517          	auipc	a0,0x4
    80004fb0:	48c50513          	addi	a0,a0,1164 # 80009438 <CONSOLE_STATUS+0x428>
    80004fb4:	ffffd097          	auipc	ra,0xffffd
    80004fb8:	0c8080e7          	jalr	200(ra) # 8000207c <_Z11printStringPKc>
    80004fbc:	00000613          	li	a2,0
    80004fc0:	00a00593          	li	a1,10
    80004fc4:	00048513          	mv	a0,s1
    80004fc8:	ffffd097          	auipc	ra,0xffffd
    80004fcc:	24c080e7          	jalr	588(ra) # 80002214 <_Z8printIntiii>
    80004fd0:	00004517          	auipc	a0,0x4
    80004fd4:	1d050513          	addi	a0,a0,464 # 800091a0 <CONSOLE_STATUS+0x190>
    80004fd8:	ffffd097          	auipc	ra,0xffffd
    80004fdc:	0a4080e7          	jalr	164(ra) # 8000207c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004fe0:	0014849b          	addiw	s1,s1,1
    80004fe4:	0ff4f493          	andi	s1,s1,255
    80004fe8:	00c00793          	li	a5,12
    80004fec:	fc97f0e3          	bgeu	a5,s1,80004fac <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004ff0:	00004517          	auipc	a0,0x4
    80004ff4:	45050513          	addi	a0,a0,1104 # 80009440 <CONSOLE_STATUS+0x430>
    80004ff8:	ffffd097          	auipc	ra,0xffffd
    80004ffc:	084080e7          	jalr	132(ra) # 8000207c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005000:	00500313          	li	t1,5
    thread_dispatch();
    80005004:	ffffc097          	auipc	ra,0xffffc
    80005008:	6f8080e7          	jalr	1784(ra) # 800016fc <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000500c:	01000513          	li	a0,16
    80005010:	00000097          	auipc	ra,0x0
    80005014:	d88080e7          	jalr	-632(ra) # 80004d98 <_Z9fibonaccim>
    80005018:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000501c:	00004517          	auipc	a0,0x4
    80005020:	43450513          	addi	a0,a0,1076 # 80009450 <CONSOLE_STATUS+0x440>
    80005024:	ffffd097          	auipc	ra,0xffffd
    80005028:	058080e7          	jalr	88(ra) # 8000207c <_Z11printStringPKc>
    8000502c:	00000613          	li	a2,0
    80005030:	00a00593          	li	a1,10
    80005034:	0009051b          	sext.w	a0,s2
    80005038:	ffffd097          	auipc	ra,0xffffd
    8000503c:	1dc080e7          	jalr	476(ra) # 80002214 <_Z8printIntiii>
    80005040:	00004517          	auipc	a0,0x4
    80005044:	16050513          	addi	a0,a0,352 # 800091a0 <CONSOLE_STATUS+0x190>
    80005048:	ffffd097          	auipc	ra,0xffffd
    8000504c:	034080e7          	jalr	52(ra) # 8000207c <_Z11printStringPKc>
    80005050:	0400006f          	j	80005090 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005054:	00004517          	auipc	a0,0x4
    80005058:	3e450513          	addi	a0,a0,996 # 80009438 <CONSOLE_STATUS+0x428>
    8000505c:	ffffd097          	auipc	ra,0xffffd
    80005060:	020080e7          	jalr	32(ra) # 8000207c <_Z11printStringPKc>
    80005064:	00000613          	li	a2,0
    80005068:	00a00593          	li	a1,10
    8000506c:	00048513          	mv	a0,s1
    80005070:	ffffd097          	auipc	ra,0xffffd
    80005074:	1a4080e7          	jalr	420(ra) # 80002214 <_Z8printIntiii>
    80005078:	00004517          	auipc	a0,0x4
    8000507c:	12850513          	addi	a0,a0,296 # 800091a0 <CONSOLE_STATUS+0x190>
    80005080:	ffffd097          	auipc	ra,0xffffd
    80005084:	ffc080e7          	jalr	-4(ra) # 8000207c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005088:	0014849b          	addiw	s1,s1,1
    8000508c:	0ff4f493          	andi	s1,s1,255
    80005090:	00f00793          	li	a5,15
    80005094:	fc97f0e3          	bgeu	a5,s1,80005054 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005098:	00004517          	auipc	a0,0x4
    8000509c:	3c850513          	addi	a0,a0,968 # 80009460 <CONSOLE_STATUS+0x450>
    800050a0:	ffffd097          	auipc	ra,0xffffd
    800050a4:	fdc080e7          	jalr	-36(ra) # 8000207c <_Z11printStringPKc>
    finishedD = true;
    800050a8:	00100793          	li	a5,1
    800050ac:	0000b717          	auipc	a4,0xb
    800050b0:	d0f70ba3          	sb	a5,-745(a4) # 8000fdc3 <finishedD>
    thread_dispatch();
    800050b4:	ffffc097          	auipc	ra,0xffffc
    800050b8:	648080e7          	jalr	1608(ra) # 800016fc <_Z15thread_dispatchv>
}
    800050bc:	01813083          	ld	ra,24(sp)
    800050c0:	01013403          	ld	s0,16(sp)
    800050c4:	00813483          	ld	s1,8(sp)
    800050c8:	00013903          	ld	s2,0(sp)
    800050cc:	02010113          	addi	sp,sp,32
    800050d0:	00008067          	ret

00000000800050d4 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800050d4:	fc010113          	addi	sp,sp,-64
    800050d8:	02113c23          	sd	ra,56(sp)
    800050dc:	02813823          	sd	s0,48(sp)
    800050e0:	02913423          	sd	s1,40(sp)
    800050e4:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800050e8:	00000613          	li	a2,0
    800050ec:	00000597          	auipc	a1,0x0
    800050f0:	a6858593          	addi	a1,a1,-1432 # 80004b54 <_Z11workerBodyAPv>
    800050f4:	fc040513          	addi	a0,s0,-64
    800050f8:	ffffc097          	auipc	ra,0xffffc
    800050fc:	560080e7          	jalr	1376(ra) # 80001658 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80005100:	00004517          	auipc	a0,0x4
    80005104:	37050513          	addi	a0,a0,880 # 80009470 <CONSOLE_STATUS+0x460>
    80005108:	ffffd097          	auipc	ra,0xffffd
    8000510c:	f74080e7          	jalr	-140(ra) # 8000207c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005110:	00000613          	li	a2,0
    80005114:	00000597          	auipc	a1,0x0
    80005118:	b0c58593          	addi	a1,a1,-1268 # 80004c20 <_Z11workerBodyBPv>
    8000511c:	fc840513          	addi	a0,s0,-56
    80005120:	ffffc097          	auipc	ra,0xffffc
    80005124:	538080e7          	jalr	1336(ra) # 80001658 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005128:	00004517          	auipc	a0,0x4
    8000512c:	36050513          	addi	a0,a0,864 # 80009488 <CONSOLE_STATUS+0x478>
    80005130:	ffffd097          	auipc	ra,0xffffd
    80005134:	f4c080e7          	jalr	-180(ra) # 8000207c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005138:	00000613          	li	a2,0
    8000513c:	00000597          	auipc	a1,0x0
    80005140:	cd058593          	addi	a1,a1,-816 # 80004e0c <_Z11workerBodyCPv>
    80005144:	fd040513          	addi	a0,s0,-48
    80005148:	ffffc097          	auipc	ra,0xffffc
    8000514c:	510080e7          	jalr	1296(ra) # 80001658 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80005150:	00004517          	auipc	a0,0x4
    80005154:	35050513          	addi	a0,a0,848 # 800094a0 <CONSOLE_STATUS+0x490>
    80005158:	ffffd097          	auipc	ra,0xffffd
    8000515c:	f24080e7          	jalr	-220(ra) # 8000207c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005160:	00000613          	li	a2,0
    80005164:	00000597          	auipc	a1,0x0
    80005168:	e2858593          	addi	a1,a1,-472 # 80004f8c <_Z11workerBodyDPv>
    8000516c:	fd840513          	addi	a0,s0,-40
    80005170:	ffffc097          	auipc	ra,0xffffc
    80005174:	4e8080e7          	jalr	1256(ra) # 80001658 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80005178:	00004517          	auipc	a0,0x4
    8000517c:	34050513          	addi	a0,a0,832 # 800094b8 <CONSOLE_STATUS+0x4a8>
    80005180:	ffffd097          	auipc	ra,0xffffd
    80005184:	efc080e7          	jalr	-260(ra) # 8000207c <_Z11printStringPKc>
    80005188:	00c0006f          	j	80005194 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000518c:	ffffc097          	auipc	ra,0xffffc
    80005190:	570080e7          	jalr	1392(ra) # 800016fc <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005194:	0000b797          	auipc	a5,0xb
    80005198:	c247c783          	lbu	a5,-988(a5) # 8000fdb8 <finishedA>
    8000519c:	fe0788e3          	beqz	a5,8000518c <_Z18Threads_C_API_testv+0xb8>
    800051a0:	0000b797          	auipc	a5,0xb
    800051a4:	c197c783          	lbu	a5,-999(a5) # 8000fdb9 <finishedB>
    800051a8:	fe0782e3          	beqz	a5,8000518c <_Z18Threads_C_API_testv+0xb8>
    800051ac:	0000b797          	auipc	a5,0xb
    800051b0:	c167c783          	lbu	a5,-1002(a5) # 8000fdc2 <finishedC>
    800051b4:	fc078ce3          	beqz	a5,8000518c <_Z18Threads_C_API_testv+0xb8>
    800051b8:	0000b797          	auipc	a5,0xb
    800051bc:	c0b7c783          	lbu	a5,-1013(a5) # 8000fdc3 <finishedD>
    800051c0:	fc0786e3          	beqz	a5,8000518c <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    800051c4:	fc040493          	addi	s1,s0,-64
    800051c8:	0080006f          	j	800051d0 <_Z18Threads_C_API_testv+0xfc>
    800051cc:	00848493          	addi	s1,s1,8
    800051d0:	fe040793          	addi	a5,s0,-32
    800051d4:	00f48c63          	beq	s1,a5,800051ec <_Z18Threads_C_API_testv+0x118>
    800051d8:	0004b503          	ld	a0,0(s1)
    800051dc:	fe0508e3          	beqz	a0,800051cc <_Z18Threads_C_API_testv+0xf8>
    800051e0:	ffffc097          	auipc	ra,0xffffc
    800051e4:	768080e7          	jalr	1896(ra) # 80001948 <_ZN7_threaddlEPv>
    800051e8:	fe5ff06f          	j	800051cc <_Z18Threads_C_API_testv+0xf8>
}
    800051ec:	03813083          	ld	ra,56(sp)
    800051f0:	03013403          	ld	s0,48(sp)
    800051f4:	02813483          	ld	s1,40(sp)
    800051f8:	04010113          	addi	sp,sp,64
    800051fc:	00008067          	ret

0000000080005200 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005200:	fd010113          	addi	sp,sp,-48
    80005204:	02113423          	sd	ra,40(sp)
    80005208:	02813023          	sd	s0,32(sp)
    8000520c:	00913c23          	sd	s1,24(sp)
    80005210:	01213823          	sd	s2,16(sp)
    80005214:	01313423          	sd	s3,8(sp)
    80005218:	03010413          	addi	s0,sp,48
    8000521c:	00050993          	mv	s3,a0
    80005220:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80005224:	00000913          	li	s2,0
    80005228:	00c0006f          	j	80005234 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000522c:	ffffe097          	auipc	ra,0xffffe
    80005230:	de8080e7          	jalr	-536(ra) # 80003014 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80005234:	ffffc097          	auipc	ra,0xffffc
    80005238:	678080e7          	jalr	1656(ra) # 800018ac <_Z4getcv>
    8000523c:	0005059b          	sext.w	a1,a0
    80005240:	01b00793          	li	a5,27
    80005244:	02f58a63          	beq	a1,a5,80005278 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80005248:	0084b503          	ld	a0,8(s1)
    8000524c:	fffff097          	auipc	ra,0xfffff
    80005250:	664080e7          	jalr	1636(ra) # 800048b0 <_ZN9BufferCPP3putEi>
        i++;
    80005254:	0019071b          	addiw	a4,s2,1
    80005258:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000525c:	0004a683          	lw	a3,0(s1)
    80005260:	0026979b          	slliw	a5,a3,0x2
    80005264:	00d787bb          	addw	a5,a5,a3
    80005268:	0017979b          	slliw	a5,a5,0x1
    8000526c:	02f767bb          	remw	a5,a4,a5
    80005270:	fc0792e3          	bnez	a5,80005234 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80005274:	fb9ff06f          	j	8000522c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80005278:	00100793          	li	a5,1
    8000527c:	0000b717          	auipc	a4,0xb
    80005280:	b4f72423          	sw	a5,-1208(a4) # 8000fdc4 <threadEnd>
    td->buffer->put('!');
    80005284:	0109b783          	ld	a5,16(s3)
    80005288:	02100593          	li	a1,33
    8000528c:	0087b503          	ld	a0,8(a5)
    80005290:	fffff097          	auipc	ra,0xfffff
    80005294:	620080e7          	jalr	1568(ra) # 800048b0 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80005298:	0104b503          	ld	a0,16(s1)
    8000529c:	ffffe097          	auipc	ra,0xffffe
    800052a0:	c68080e7          	jalr	-920(ra) # 80002f04 <_ZN9Semaphore6signalEv>
}
    800052a4:	02813083          	ld	ra,40(sp)
    800052a8:	02013403          	ld	s0,32(sp)
    800052ac:	01813483          	ld	s1,24(sp)
    800052b0:	01013903          	ld	s2,16(sp)
    800052b4:	00813983          	ld	s3,8(sp)
    800052b8:	03010113          	addi	sp,sp,48
    800052bc:	00008067          	ret

00000000800052c0 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    800052c0:	fe010113          	addi	sp,sp,-32
    800052c4:	00113c23          	sd	ra,24(sp)
    800052c8:	00813823          	sd	s0,16(sp)
    800052cc:	00913423          	sd	s1,8(sp)
    800052d0:	01213023          	sd	s2,0(sp)
    800052d4:	02010413          	addi	s0,sp,32
    800052d8:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800052dc:	00000913          	li	s2,0
    800052e0:	00c0006f          	j	800052ec <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800052e4:	ffffe097          	auipc	ra,0xffffe
    800052e8:	d30080e7          	jalr	-720(ra) # 80003014 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    800052ec:	0000b797          	auipc	a5,0xb
    800052f0:	ad87a783          	lw	a5,-1320(a5) # 8000fdc4 <threadEnd>
    800052f4:	02079e63          	bnez	a5,80005330 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    800052f8:	0004a583          	lw	a1,0(s1)
    800052fc:	0305859b          	addiw	a1,a1,48
    80005300:	0084b503          	ld	a0,8(s1)
    80005304:	fffff097          	auipc	ra,0xfffff
    80005308:	5ac080e7          	jalr	1452(ra) # 800048b0 <_ZN9BufferCPP3putEi>
        i++;
    8000530c:	0019071b          	addiw	a4,s2,1
    80005310:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005314:	0004a683          	lw	a3,0(s1)
    80005318:	0026979b          	slliw	a5,a3,0x2
    8000531c:	00d787bb          	addw	a5,a5,a3
    80005320:	0017979b          	slliw	a5,a5,0x1
    80005324:	02f767bb          	remw	a5,a4,a5
    80005328:	fc0792e3          	bnez	a5,800052ec <_ZN8Producer8producerEPv+0x2c>
    8000532c:	fb9ff06f          	j	800052e4 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005330:	0104b503          	ld	a0,16(s1)
    80005334:	ffffe097          	auipc	ra,0xffffe
    80005338:	bd0080e7          	jalr	-1072(ra) # 80002f04 <_ZN9Semaphore6signalEv>
}
    8000533c:	01813083          	ld	ra,24(sp)
    80005340:	01013403          	ld	s0,16(sp)
    80005344:	00813483          	ld	s1,8(sp)
    80005348:	00013903          	ld	s2,0(sp)
    8000534c:	02010113          	addi	sp,sp,32
    80005350:	00008067          	ret

0000000080005354 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    80005354:	fd010113          	addi	sp,sp,-48
    80005358:	02113423          	sd	ra,40(sp)
    8000535c:	02813023          	sd	s0,32(sp)
    80005360:	00913c23          	sd	s1,24(sp)
    80005364:	01213823          	sd	s2,16(sp)
    80005368:	01313423          	sd	s3,8(sp)
    8000536c:	01413023          	sd	s4,0(sp)
    80005370:	03010413          	addi	s0,sp,48
    80005374:	00050993          	mv	s3,a0
    80005378:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000537c:	00000a13          	li	s4,0
    80005380:	01c0006f          	j	8000539c <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80005384:	ffffe097          	auipc	ra,0xffffe
    80005388:	c90080e7          	jalr	-880(ra) # 80003014 <_ZN6Thread8dispatchEv>
    8000538c:	0500006f          	j	800053dc <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80005390:	00a00513          	li	a0,10
    80005394:	ffffc097          	auipc	ra,0xffffc
    80005398:	540080e7          	jalr	1344(ra) # 800018d4 <_Z4putcc>
    while (!threadEnd) {
    8000539c:	0000b797          	auipc	a5,0xb
    800053a0:	a287a783          	lw	a5,-1496(a5) # 8000fdc4 <threadEnd>
    800053a4:	06079263          	bnez	a5,80005408 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    800053a8:	00893503          	ld	a0,8(s2)
    800053ac:	fffff097          	auipc	ra,0xfffff
    800053b0:	594080e7          	jalr	1428(ra) # 80004940 <_ZN9BufferCPP3getEv>
        i++;
    800053b4:	001a049b          	addiw	s1,s4,1
    800053b8:	00048a1b          	sext.w	s4,s1
        putc(key);
    800053bc:	0ff57513          	andi	a0,a0,255
    800053c0:	ffffc097          	auipc	ra,0xffffc
    800053c4:	514080e7          	jalr	1300(ra) # 800018d4 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800053c8:	00092703          	lw	a4,0(s2)
    800053cc:	0027179b          	slliw	a5,a4,0x2
    800053d0:	00e787bb          	addw	a5,a5,a4
    800053d4:	02f4e7bb          	remw	a5,s1,a5
    800053d8:	fa0786e3          	beqz	a5,80005384 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    800053dc:	05000793          	li	a5,80
    800053e0:	02f4e4bb          	remw	s1,s1,a5
    800053e4:	fa049ce3          	bnez	s1,8000539c <_ZN8Consumer8consumerEPv+0x48>
    800053e8:	fa9ff06f          	j	80005390 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800053ec:	0109b783          	ld	a5,16(s3)
    800053f0:	0087b503          	ld	a0,8(a5)
    800053f4:	fffff097          	auipc	ra,0xfffff
    800053f8:	54c080e7          	jalr	1356(ra) # 80004940 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    800053fc:	0ff57513          	andi	a0,a0,255
    80005400:	ffffe097          	auipc	ra,0xffffe
    80005404:	d00080e7          	jalr	-768(ra) # 80003100 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80005408:	0109b783          	ld	a5,16(s3)
    8000540c:	0087b503          	ld	a0,8(a5)
    80005410:	fffff097          	auipc	ra,0xfffff
    80005414:	5bc080e7          	jalr	1468(ra) # 800049cc <_ZN9BufferCPP6getCntEv>
    80005418:	fca04ae3          	bgtz	a0,800053ec <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    8000541c:	01093503          	ld	a0,16(s2)
    80005420:	ffffe097          	auipc	ra,0xffffe
    80005424:	ae4080e7          	jalr	-1308(ra) # 80002f04 <_ZN9Semaphore6signalEv>
}
    80005428:	02813083          	ld	ra,40(sp)
    8000542c:	02013403          	ld	s0,32(sp)
    80005430:	01813483          	ld	s1,24(sp)
    80005434:	01013903          	ld	s2,16(sp)
    80005438:	00813983          	ld	s3,8(sp)
    8000543c:	00013a03          	ld	s4,0(sp)
    80005440:	03010113          	addi	sp,sp,48
    80005444:	00008067          	ret

0000000080005448 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80005448:	f8010113          	addi	sp,sp,-128
    8000544c:	06113c23          	sd	ra,120(sp)
    80005450:	06813823          	sd	s0,112(sp)
    80005454:	06913423          	sd	s1,104(sp)
    80005458:	07213023          	sd	s2,96(sp)
    8000545c:	05313c23          	sd	s3,88(sp)
    80005460:	05413823          	sd	s4,80(sp)
    80005464:	05513423          	sd	s5,72(sp)
    80005468:	05613023          	sd	s6,64(sp)
    8000546c:	03713c23          	sd	s7,56(sp)
    80005470:	03813823          	sd	s8,48(sp)
    80005474:	03913423          	sd	s9,40(sp)
    80005478:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    8000547c:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80005480:	00004517          	auipc	a0,0x4
    80005484:	05050513          	addi	a0,a0,80 # 800094d0 <CONSOLE_STATUS+0x4c0>
    80005488:	ffffd097          	auipc	ra,0xffffd
    8000548c:	bf4080e7          	jalr	-1036(ra) # 8000207c <_Z11printStringPKc>
    getString(input, 30);
    80005490:	01e00593          	li	a1,30
    80005494:	f8040493          	addi	s1,s0,-128
    80005498:	00048513          	mv	a0,s1
    8000549c:	ffffd097          	auipc	ra,0xffffd
    800054a0:	c5c080e7          	jalr	-932(ra) # 800020f8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800054a4:	00048513          	mv	a0,s1
    800054a8:	ffffd097          	auipc	ra,0xffffd
    800054ac:	d1c080e7          	jalr	-740(ra) # 800021c4 <_Z11stringToIntPKc>
    800054b0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800054b4:	00004517          	auipc	a0,0x4
    800054b8:	03c50513          	addi	a0,a0,60 # 800094f0 <CONSOLE_STATUS+0x4e0>
    800054bc:	ffffd097          	auipc	ra,0xffffd
    800054c0:	bc0080e7          	jalr	-1088(ra) # 8000207c <_Z11printStringPKc>
    getString(input, 30);
    800054c4:	01e00593          	li	a1,30
    800054c8:	00048513          	mv	a0,s1
    800054cc:	ffffd097          	auipc	ra,0xffffd
    800054d0:	c2c080e7          	jalr	-980(ra) # 800020f8 <_Z9getStringPci>
    n = stringToInt(input);
    800054d4:	00048513          	mv	a0,s1
    800054d8:	ffffd097          	auipc	ra,0xffffd
    800054dc:	cec080e7          	jalr	-788(ra) # 800021c4 <_Z11stringToIntPKc>
    800054e0:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800054e4:	00004517          	auipc	a0,0x4
    800054e8:	02c50513          	addi	a0,a0,44 # 80009510 <CONSOLE_STATUS+0x500>
    800054ec:	ffffd097          	auipc	ra,0xffffd
    800054f0:	b90080e7          	jalr	-1136(ra) # 8000207c <_Z11printStringPKc>
    800054f4:	00000613          	li	a2,0
    800054f8:	00a00593          	li	a1,10
    800054fc:	00090513          	mv	a0,s2
    80005500:	ffffd097          	auipc	ra,0xffffd
    80005504:	d14080e7          	jalr	-748(ra) # 80002214 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005508:	00004517          	auipc	a0,0x4
    8000550c:	02050513          	addi	a0,a0,32 # 80009528 <CONSOLE_STATUS+0x518>
    80005510:	ffffd097          	auipc	ra,0xffffd
    80005514:	b6c080e7          	jalr	-1172(ra) # 8000207c <_Z11printStringPKc>
    80005518:	00000613          	li	a2,0
    8000551c:	00a00593          	li	a1,10
    80005520:	00048513          	mv	a0,s1
    80005524:	ffffd097          	auipc	ra,0xffffd
    80005528:	cf0080e7          	jalr	-784(ra) # 80002214 <_Z8printIntiii>
    printString(".\n");
    8000552c:	00004517          	auipc	a0,0x4
    80005530:	cdc50513          	addi	a0,a0,-804 # 80009208 <CONSOLE_STATUS+0x1f8>
    80005534:	ffffd097          	auipc	ra,0xffffd
    80005538:	b48080e7          	jalr	-1208(ra) # 8000207c <_Z11printStringPKc>
    if(threadNum > n) {
    8000553c:	0324c463          	blt	s1,s2,80005564 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005540:	03205c63          	blez	s2,80005578 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80005544:	03800513          	li	a0,56
    80005548:	ffffe097          	auipc	ra,0xffffe
    8000554c:	860080e7          	jalr	-1952(ra) # 80002da8 <_Znwm>
    80005550:	00050a93          	mv	s5,a0
    80005554:	00048593          	mv	a1,s1
    80005558:	fffff097          	auipc	ra,0xfffff
    8000555c:	204080e7          	jalr	516(ra) # 8000475c <_ZN9BufferCPPC1Ei>
    80005560:	0300006f          	j	80005590 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005564:	00004517          	auipc	a0,0x4
    80005568:	fdc50513          	addi	a0,a0,-36 # 80009540 <CONSOLE_STATUS+0x530>
    8000556c:	ffffd097          	auipc	ra,0xffffd
    80005570:	b10080e7          	jalr	-1264(ra) # 8000207c <_Z11printStringPKc>
        return;
    80005574:	0140006f          	j	80005588 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005578:	00004517          	auipc	a0,0x4
    8000557c:	00850513          	addi	a0,a0,8 # 80009580 <CONSOLE_STATUS+0x570>
    80005580:	ffffd097          	auipc	ra,0xffffd
    80005584:	afc080e7          	jalr	-1284(ra) # 8000207c <_Z11printStringPKc>
        return;
    80005588:	000b8113          	mv	sp,s7
    8000558c:	2400006f          	j	800057cc <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    80005590:	01000513          	li	a0,16
    80005594:	ffffe097          	auipc	ra,0xffffe
    80005598:	814080e7          	jalr	-2028(ra) # 80002da8 <_Znwm>
    8000559c:	00050493          	mv	s1,a0
    800055a0:	00000593          	li	a1,0
    800055a4:	ffffe097          	auipc	ra,0xffffe
    800055a8:	8fc080e7          	jalr	-1796(ra) # 80002ea0 <_ZN9SemaphoreC1Ej>
    800055ac:	0000b717          	auipc	a4,0xb
    800055b0:	80c70713          	addi	a4,a4,-2036 # 8000fdb8 <finishedA>
    800055b4:	00973823          	sd	s1,16(a4)
    Thread* threads[threadNum];
    800055b8:	00391793          	slli	a5,s2,0x3
    800055bc:	00f78793          	addi	a5,a5,15
    800055c0:	ff07f793          	andi	a5,a5,-16
    800055c4:	40f10133          	sub	sp,sp,a5
    800055c8:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800055cc:	0019069b          	addiw	a3,s2,1
    800055d0:	00169793          	slli	a5,a3,0x1
    800055d4:	00d787b3          	add	a5,a5,a3
    800055d8:	00379793          	slli	a5,a5,0x3
    800055dc:	00f78793          	addi	a5,a5,15
    800055e0:	ff07f793          	andi	a5,a5,-16
    800055e4:	40f10133          	sub	sp,sp,a5
    800055e8:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800055ec:	00191493          	slli	s1,s2,0x1
    800055f0:	012487b3          	add	a5,s1,s2
    800055f4:	00379793          	slli	a5,a5,0x3
    800055f8:	00fa07b3          	add	a5,s4,a5
    800055fc:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005600:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005604:	01073703          	ld	a4,16(a4)
    80005608:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    8000560c:	01800513          	li	a0,24
    80005610:	ffffd097          	auipc	ra,0xffffd
    80005614:	798080e7          	jalr	1944(ra) # 80002da8 <_Znwm>
    80005618:	00050b13          	mv	s6,a0
    8000561c:	012484b3          	add	s1,s1,s2
    80005620:	00349493          	slli	s1,s1,0x3
    80005624:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    80005628:	ffffe097          	auipc	ra,0xffffe
    8000562c:	940080e7          	jalr	-1728(ra) # 80002f68 <_ZN6ThreadC1Ev>
    80005630:	00006797          	auipc	a5,0x6
    80005634:	3d078793          	addi	a5,a5,976 # 8000ba00 <_ZTV8Consumer+0x10>
    80005638:	00fb3023          	sd	a5,0(s6)
    8000563c:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    80005640:	000b0513          	mv	a0,s6
    80005644:	ffffe097          	auipc	ra,0xffffe
    80005648:	9f8080e7          	jalr	-1544(ra) # 8000303c <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    8000564c:	00000493          	li	s1,0
    80005650:	0380006f          	j	80005688 <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005654:	00006797          	auipc	a5,0x6
    80005658:	38478793          	addi	a5,a5,900 # 8000b9d8 <_ZTV8Producer+0x10>
    8000565c:	00fcb023          	sd	a5,0(s9)
    80005660:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    80005664:	00349793          	slli	a5,s1,0x3
    80005668:	00f987b3          	add	a5,s3,a5
    8000566c:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80005670:	00349793          	slli	a5,s1,0x3
    80005674:	00f987b3          	add	a5,s3,a5
    80005678:	0007b503          	ld	a0,0(a5)
    8000567c:	ffffe097          	auipc	ra,0xffffe
    80005680:	9c0080e7          	jalr	-1600(ra) # 8000303c <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005684:	0014849b          	addiw	s1,s1,1
    80005688:	0b24d063          	bge	s1,s2,80005728 <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    8000568c:	00149793          	slli	a5,s1,0x1
    80005690:	009787b3          	add	a5,a5,s1
    80005694:	00379793          	slli	a5,a5,0x3
    80005698:	00fa07b3          	add	a5,s4,a5
    8000569c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800056a0:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800056a4:	0000a717          	auipc	a4,0xa
    800056a8:	72473703          	ld	a4,1828(a4) # 8000fdc8 <waitForAll>
    800056ac:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800056b0:	02905863          	blez	s1,800056e0 <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    800056b4:	01800513          	li	a0,24
    800056b8:	ffffd097          	auipc	ra,0xffffd
    800056bc:	6f0080e7          	jalr	1776(ra) # 80002da8 <_Znwm>
    800056c0:	00050c93          	mv	s9,a0
    800056c4:	00149c13          	slli	s8,s1,0x1
    800056c8:	009c0c33          	add	s8,s8,s1
    800056cc:	003c1c13          	slli	s8,s8,0x3
    800056d0:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    800056d4:	ffffe097          	auipc	ra,0xffffe
    800056d8:	894080e7          	jalr	-1900(ra) # 80002f68 <_ZN6ThreadC1Ev>
    800056dc:	f79ff06f          	j	80005654 <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    800056e0:	01800513          	li	a0,24
    800056e4:	ffffd097          	auipc	ra,0xffffd
    800056e8:	6c4080e7          	jalr	1732(ra) # 80002da8 <_Znwm>
    800056ec:	00050c93          	mv	s9,a0
    800056f0:	00149c13          	slli	s8,s1,0x1
    800056f4:	009c0c33          	add	s8,s8,s1
    800056f8:	003c1c13          	slli	s8,s8,0x3
    800056fc:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005700:	ffffe097          	auipc	ra,0xffffe
    80005704:	868080e7          	jalr	-1944(ra) # 80002f68 <_ZN6ThreadC1Ev>
    80005708:	00006797          	auipc	a5,0x6
    8000570c:	2a878793          	addi	a5,a5,680 # 8000b9b0 <_ZTV16ProducerKeyboard+0x10>
    80005710:	00fcb023          	sd	a5,0(s9)
    80005714:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005718:	00349793          	slli	a5,s1,0x3
    8000571c:	00f987b3          	add	a5,s3,a5
    80005720:	0197b023          	sd	s9,0(a5)
    80005724:	f4dff06f          	j	80005670 <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    80005728:	ffffe097          	auipc	ra,0xffffe
    8000572c:	8ec080e7          	jalr	-1812(ra) # 80003014 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005730:	00000493          	li	s1,0
    80005734:	00994e63          	blt	s2,s1,80005750 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    80005738:	0000a517          	auipc	a0,0xa
    8000573c:	69053503          	ld	a0,1680(a0) # 8000fdc8 <waitForAll>
    80005740:	ffffd097          	auipc	ra,0xffffd
    80005744:	798080e7          	jalr	1944(ra) # 80002ed8 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80005748:	0014849b          	addiw	s1,s1,1
    8000574c:	fe9ff06f          	j	80005734 <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    80005750:	00000493          	li	s1,0
    80005754:	0080006f          	j	8000575c <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    80005758:	0014849b          	addiw	s1,s1,1
    8000575c:	0324d263          	bge	s1,s2,80005780 <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    80005760:	00349793          	slli	a5,s1,0x3
    80005764:	00f987b3          	add	a5,s3,a5
    80005768:	0007b503          	ld	a0,0(a5)
    8000576c:	fe0506e3          	beqz	a0,80005758 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    80005770:	00053783          	ld	a5,0(a0)
    80005774:	0087b783          	ld	a5,8(a5)
    80005778:	000780e7          	jalr	a5
    8000577c:	fddff06f          	j	80005758 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    80005780:	000b0a63          	beqz	s6,80005794 <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    80005784:	000b3783          	ld	a5,0(s6)
    80005788:	0087b783          	ld	a5,8(a5)
    8000578c:	000b0513          	mv	a0,s6
    80005790:	000780e7          	jalr	a5
    delete waitForAll;
    80005794:	0000a517          	auipc	a0,0xa
    80005798:	63453503          	ld	a0,1588(a0) # 8000fdc8 <waitForAll>
    8000579c:	00050863          	beqz	a0,800057ac <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    800057a0:	00053783          	ld	a5,0(a0)
    800057a4:	0087b783          	ld	a5,8(a5)
    800057a8:	000780e7          	jalr	a5
    delete buffer;
    800057ac:	000a8e63          	beqz	s5,800057c8 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    800057b0:	000a8513          	mv	a0,s5
    800057b4:	fffff097          	auipc	ra,0xfffff
    800057b8:	2a0080e7          	jalr	672(ra) # 80004a54 <_ZN9BufferCPPD1Ev>
    800057bc:	000a8513          	mv	a0,s5
    800057c0:	ffffd097          	auipc	ra,0xffffd
    800057c4:	638080e7          	jalr	1592(ra) # 80002df8 <_ZdlPv>
    800057c8:	000b8113          	mv	sp,s7

}
    800057cc:	f8040113          	addi	sp,s0,-128
    800057d0:	07813083          	ld	ra,120(sp)
    800057d4:	07013403          	ld	s0,112(sp)
    800057d8:	06813483          	ld	s1,104(sp)
    800057dc:	06013903          	ld	s2,96(sp)
    800057e0:	05813983          	ld	s3,88(sp)
    800057e4:	05013a03          	ld	s4,80(sp)
    800057e8:	04813a83          	ld	s5,72(sp)
    800057ec:	04013b03          	ld	s6,64(sp)
    800057f0:	03813b83          	ld	s7,56(sp)
    800057f4:	03013c03          	ld	s8,48(sp)
    800057f8:	02813c83          	ld	s9,40(sp)
    800057fc:	08010113          	addi	sp,sp,128
    80005800:	00008067          	ret
    80005804:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005808:	000a8513          	mv	a0,s5
    8000580c:	ffffd097          	auipc	ra,0xffffd
    80005810:	5ec080e7          	jalr	1516(ra) # 80002df8 <_ZdlPv>
    80005814:	00048513          	mv	a0,s1
    80005818:	0000b097          	auipc	ra,0xb
    8000581c:	690080e7          	jalr	1680(ra) # 80010ea8 <_Unwind_Resume>
    80005820:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80005824:	00048513          	mv	a0,s1
    80005828:	ffffd097          	auipc	ra,0xffffd
    8000582c:	5d0080e7          	jalr	1488(ra) # 80002df8 <_ZdlPv>
    80005830:	00090513          	mv	a0,s2
    80005834:	0000b097          	auipc	ra,0xb
    80005838:	674080e7          	jalr	1652(ra) # 80010ea8 <_Unwind_Resume>
    8000583c:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    80005840:	000b0513          	mv	a0,s6
    80005844:	ffffd097          	auipc	ra,0xffffd
    80005848:	5b4080e7          	jalr	1460(ra) # 80002df8 <_ZdlPv>
    8000584c:	00048513          	mv	a0,s1
    80005850:	0000b097          	auipc	ra,0xb
    80005854:	658080e7          	jalr	1624(ra) # 80010ea8 <_Unwind_Resume>
    80005858:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    8000585c:	000c8513          	mv	a0,s9
    80005860:	ffffd097          	auipc	ra,0xffffd
    80005864:	598080e7          	jalr	1432(ra) # 80002df8 <_ZdlPv>
    80005868:	00048513          	mv	a0,s1
    8000586c:	0000b097          	auipc	ra,0xb
    80005870:	63c080e7          	jalr	1596(ra) # 80010ea8 <_Unwind_Resume>
    80005874:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80005878:	000c8513          	mv	a0,s9
    8000587c:	ffffd097          	auipc	ra,0xffffd
    80005880:	57c080e7          	jalr	1404(ra) # 80002df8 <_ZdlPv>
    80005884:	00048513          	mv	a0,s1
    80005888:	0000b097          	auipc	ra,0xb
    8000588c:	620080e7          	jalr	1568(ra) # 80010ea8 <_Unwind_Resume>

0000000080005890 <_Z12testSleepingv>:

void testSleeping() {
    80005890:	fc010113          	addi	sp,sp,-64
    80005894:	02113c23          	sd	ra,56(sp)
    80005898:	02813823          	sd	s0,48(sp)
    8000589c:	02913423          	sd	s1,40(sp)
    800058a0:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800058a4:	00a00793          	li	a5,10
    800058a8:	fcf43823          	sd	a5,-48(s0)
    800058ac:	01400793          	li	a5,20
    800058b0:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    800058b4:	00000493          	li	s1,0
    800058b8:	02c0006f          	j	800058e4 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    800058bc:	00349793          	slli	a5,s1,0x3
    800058c0:	fd040613          	addi	a2,s0,-48
    800058c4:	00f60633          	add	a2,a2,a5
    800058c8:	fffff597          	auipc	a1,0xfffff
    800058cc:	42c58593          	addi	a1,a1,1068 # 80004cf4 <_Z9sleepyRunPv>
    800058d0:	fc040513          	addi	a0,s0,-64
    800058d4:	00f50533          	add	a0,a0,a5
    800058d8:	ffffc097          	auipc	ra,0xffffc
    800058dc:	d80080e7          	jalr	-640(ra) # 80001658 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800058e0:	0014849b          	addiw	s1,s1,1
    800058e4:	00100793          	li	a5,1
    800058e8:	fc97dae3          	bge	a5,s1,800058bc <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800058ec:	0000a797          	auipc	a5,0xa
    800058f0:	4d47c783          	lbu	a5,1236(a5) # 8000fdc0 <finished>
    800058f4:	fe078ce3          	beqz	a5,800058ec <_Z12testSleepingv+0x5c>
    800058f8:	0000a797          	auipc	a5,0xa
    800058fc:	4c97c783          	lbu	a5,1225(a5) # 8000fdc1 <finished+0x1>
    80005900:	fe0786e3          	beqz	a5,800058ec <_Z12testSleepingv+0x5c>
}
    80005904:	03813083          	ld	ra,56(sp)
    80005908:	03013403          	ld	s0,48(sp)
    8000590c:	02813483          	ld	s1,40(sp)
    80005910:	04010113          	addi	sp,sp,64
    80005914:	00008067          	ret

0000000080005918 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005918:	f8010113          	addi	sp,sp,-128
    8000591c:	06113c23          	sd	ra,120(sp)
    80005920:	06813823          	sd	s0,112(sp)
    80005924:	06913423          	sd	s1,104(sp)
    80005928:	07213023          	sd	s2,96(sp)
    8000592c:	05313c23          	sd	s3,88(sp)
    80005930:	05413823          	sd	s4,80(sp)
    80005934:	05513423          	sd	s5,72(sp)
    80005938:	05613023          	sd	s6,64(sp)
    8000593c:	03713c23          	sd	s7,56(sp)
    80005940:	03813823          	sd	s8,48(sp)
    80005944:	03913423          	sd	s9,40(sp)
    80005948:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000594c:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    80005950:	00004517          	auipc	a0,0x4
    80005954:	b8050513          	addi	a0,a0,-1152 # 800094d0 <CONSOLE_STATUS+0x4c0>
    80005958:	ffffc097          	auipc	ra,0xffffc
    8000595c:	724080e7          	jalr	1828(ra) # 8000207c <_Z11printStringPKc>
        getString(input, 30);
    80005960:	01e00593          	li	a1,30
    80005964:	f8040493          	addi	s1,s0,-128
    80005968:	00048513          	mv	a0,s1
    8000596c:	ffffc097          	auipc	ra,0xffffc
    80005970:	78c080e7          	jalr	1932(ra) # 800020f8 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80005974:	00048513          	mv	a0,s1
    80005978:	ffffd097          	auipc	ra,0xffffd
    8000597c:	84c080e7          	jalr	-1972(ra) # 800021c4 <_Z11stringToIntPKc>
    80005980:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    80005984:	00004517          	auipc	a0,0x4
    80005988:	b6c50513          	addi	a0,a0,-1172 # 800094f0 <CONSOLE_STATUS+0x4e0>
    8000598c:	ffffc097          	auipc	ra,0xffffc
    80005990:	6f0080e7          	jalr	1776(ra) # 8000207c <_Z11printStringPKc>
        getString(input, 30);
    80005994:	01e00593          	li	a1,30
    80005998:	00048513          	mv	a0,s1
    8000599c:	ffffc097          	auipc	ra,0xffffc
    800059a0:	75c080e7          	jalr	1884(ra) # 800020f8 <_Z9getStringPci>
        n = stringToInt(input);
    800059a4:	00048513          	mv	a0,s1
    800059a8:	ffffd097          	auipc	ra,0xffffd
    800059ac:	81c080e7          	jalr	-2020(ra) # 800021c4 <_Z11stringToIntPKc>
    800059b0:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    800059b4:	00004517          	auipc	a0,0x4
    800059b8:	b5c50513          	addi	a0,a0,-1188 # 80009510 <CONSOLE_STATUS+0x500>
    800059bc:	ffffc097          	auipc	ra,0xffffc
    800059c0:	6c0080e7          	jalr	1728(ra) # 8000207c <_Z11printStringPKc>
    800059c4:	00000613          	li	a2,0
    800059c8:	00a00593          	li	a1,10
    800059cc:	00098513          	mv	a0,s3
    800059d0:	ffffd097          	auipc	ra,0xffffd
    800059d4:	844080e7          	jalr	-1980(ra) # 80002214 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    800059d8:	00004517          	auipc	a0,0x4
    800059dc:	b5050513          	addi	a0,a0,-1200 # 80009528 <CONSOLE_STATUS+0x518>
    800059e0:	ffffc097          	auipc	ra,0xffffc
    800059e4:	69c080e7          	jalr	1692(ra) # 8000207c <_Z11printStringPKc>
    800059e8:	00000613          	li	a2,0
    800059ec:	00a00593          	li	a1,10
    800059f0:	00048513          	mv	a0,s1
    800059f4:	ffffd097          	auipc	ra,0xffffd
    800059f8:	820080e7          	jalr	-2016(ra) # 80002214 <_Z8printIntiii>
        printString(".\n");
    800059fc:	00004517          	auipc	a0,0x4
    80005a00:	80c50513          	addi	a0,a0,-2036 # 80009208 <CONSOLE_STATUS+0x1f8>
    80005a04:	ffffc097          	auipc	ra,0xffffc
    80005a08:	678080e7          	jalr	1656(ra) # 8000207c <_Z11printStringPKc>
        if(threadNum > n) {
    80005a0c:	0334c463          	blt	s1,s3,80005a34 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005a10:	03305c63          	blez	s3,80005a48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005a14:	03800513          	li	a0,56
    80005a18:	ffffd097          	auipc	ra,0xffffd
    80005a1c:	390080e7          	jalr	912(ra) # 80002da8 <_Znwm>
    80005a20:	00050a93          	mv	s5,a0
    80005a24:	00048593          	mv	a1,s1
    80005a28:	fffff097          	auipc	ra,0xfffff
    80005a2c:	d34080e7          	jalr	-716(ra) # 8000475c <_ZN9BufferCPPC1Ei>
    80005a30:	0300006f          	j	80005a60 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005a34:	00004517          	auipc	a0,0x4
    80005a38:	b0c50513          	addi	a0,a0,-1268 # 80009540 <CONSOLE_STATUS+0x530>
    80005a3c:	ffffc097          	auipc	ra,0xffffc
    80005a40:	640080e7          	jalr	1600(ra) # 8000207c <_Z11printStringPKc>
            return;
    80005a44:	0140006f          	j	80005a58 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005a48:	00004517          	auipc	a0,0x4
    80005a4c:	b3850513          	addi	a0,a0,-1224 # 80009580 <CONSOLE_STATUS+0x570>
    80005a50:	ffffc097          	auipc	ra,0xffffc
    80005a54:	62c080e7          	jalr	1580(ra) # 8000207c <_Z11printStringPKc>
            return;
    80005a58:	000c0113          	mv	sp,s8
    80005a5c:	21c0006f          	j	80005c78 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    80005a60:	01000513          	li	a0,16
    80005a64:	ffffd097          	auipc	ra,0xffffd
    80005a68:	344080e7          	jalr	836(ra) # 80002da8 <_Znwm>
    80005a6c:	00050493          	mv	s1,a0
    80005a70:	00000593          	li	a1,0
    80005a74:	ffffd097          	auipc	ra,0xffffd
    80005a78:	42c080e7          	jalr	1068(ra) # 80002ea0 <_ZN9SemaphoreC1Ej>
    80005a7c:	0000a717          	auipc	a4,0xa
    80005a80:	33c70713          	addi	a4,a4,828 # 8000fdb8 <finishedA>
    80005a84:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    80005a88:	00399793          	slli	a5,s3,0x3
    80005a8c:	00f78793          	addi	a5,a5,15
    80005a90:	ff07f793          	andi	a5,a5,-16
    80005a94:	40f10133          	sub	sp,sp,a5
    80005a98:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80005a9c:	0019869b          	addiw	a3,s3,1
    80005aa0:	00169793          	slli	a5,a3,0x1
    80005aa4:	00d787b3          	add	a5,a5,a3
    80005aa8:	00379793          	slli	a5,a5,0x3
    80005aac:	00f78793          	addi	a5,a5,15
    80005ab0:	ff07f793          	andi	a5,a5,-16
    80005ab4:	40f10133          	sub	sp,sp,a5
    80005ab8:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80005abc:	00199493          	slli	s1,s3,0x1
    80005ac0:	013484b3          	add	s1,s1,s3
    80005ac4:	00349493          	slli	s1,s1,0x3
    80005ac8:	009b04b3          	add	s1,s6,s1
    80005acc:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005ad0:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005ad4:	01873783          	ld	a5,24(a4)
    80005ad8:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005adc:	01800513          	li	a0,24
    80005ae0:	ffffd097          	auipc	ra,0xffffd
    80005ae4:	2c8080e7          	jalr	712(ra) # 80002da8 <_Znwm>
    80005ae8:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005aec:	ffffd097          	auipc	ra,0xffffd
    80005af0:	47c080e7          	jalr	1148(ra) # 80002f68 <_ZN6ThreadC1Ev>
    80005af4:	00006797          	auipc	a5,0x6
    80005af8:	f8478793          	addi	a5,a5,-124 # 8000ba78 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005afc:	00fbb023          	sd	a5,0(s7)
    80005b00:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005b04:	000b8513          	mv	a0,s7
    80005b08:	ffffd097          	auipc	ra,0xffffd
    80005b0c:	534080e7          	jalr	1332(ra) # 8000303c <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005b10:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005b14:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005b18:	0000a797          	auipc	a5,0xa
    80005b1c:	2b87b783          	ld	a5,696(a5) # 8000fdd0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005b20:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005b24:	01800513          	li	a0,24
    80005b28:	ffffd097          	auipc	ra,0xffffd
    80005b2c:	280080e7          	jalr	640(ra) # 80002da8 <_Znwm>
    80005b30:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005b34:	ffffd097          	auipc	ra,0xffffd
    80005b38:	434080e7          	jalr	1076(ra) # 80002f68 <_ZN6ThreadC1Ev>
    80005b3c:	00006797          	auipc	a5,0x6
    80005b40:	eec78793          	addi	a5,a5,-276 # 8000ba28 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005b44:	00f4b023          	sd	a5,0(s1)
    80005b48:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005b4c:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80005b50:	00048513          	mv	a0,s1
    80005b54:	ffffd097          	auipc	ra,0xffffd
    80005b58:	4e8080e7          	jalr	1256(ra) # 8000303c <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005b5c:	00100913          	li	s2,1
    80005b60:	0300006f          	j	80005b90 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005b64:	00006797          	auipc	a5,0x6
    80005b68:	eec78793          	addi	a5,a5,-276 # 8000ba50 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005b6c:	00fcb023          	sd	a5,0(s9)
    80005b70:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80005b74:	00391793          	slli	a5,s2,0x3
    80005b78:	00fa07b3          	add	a5,s4,a5
    80005b7c:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80005b80:	000c8513          	mv	a0,s9
    80005b84:	ffffd097          	auipc	ra,0xffffd
    80005b88:	4b8080e7          	jalr	1208(ra) # 8000303c <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005b8c:	0019091b          	addiw	s2,s2,1
    80005b90:	05395263          	bge	s2,s3,80005bd4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80005b94:	00191493          	slli	s1,s2,0x1
    80005b98:	012484b3          	add	s1,s1,s2
    80005b9c:	00349493          	slli	s1,s1,0x3
    80005ba0:	009b04b3          	add	s1,s6,s1
    80005ba4:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80005ba8:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80005bac:	0000a797          	auipc	a5,0xa
    80005bb0:	2247b783          	ld	a5,548(a5) # 8000fdd0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005bb4:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80005bb8:	01800513          	li	a0,24
    80005bbc:	ffffd097          	auipc	ra,0xffffd
    80005bc0:	1ec080e7          	jalr	492(ra) # 80002da8 <_Znwm>
    80005bc4:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005bc8:	ffffd097          	auipc	ra,0xffffd
    80005bcc:	3a0080e7          	jalr	928(ra) # 80002f68 <_ZN6ThreadC1Ev>
    80005bd0:	f95ff06f          	j	80005b64 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80005bd4:	ffffd097          	auipc	ra,0xffffd
    80005bd8:	440080e7          	jalr	1088(ra) # 80003014 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80005bdc:	00000493          	li	s1,0
    80005be0:	0099ce63          	blt	s3,s1,80005bfc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80005be4:	0000a517          	auipc	a0,0xa
    80005be8:	1ec53503          	ld	a0,492(a0) # 8000fdd0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005bec:	ffffd097          	auipc	ra,0xffffd
    80005bf0:	2ec080e7          	jalr	748(ra) # 80002ed8 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80005bf4:	0014849b          	addiw	s1,s1,1
    80005bf8:	fe9ff06f          	j	80005be0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80005bfc:	0000a517          	auipc	a0,0xa
    80005c00:	1d453503          	ld	a0,468(a0) # 8000fdd0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005c04:	00050863          	beqz	a0,80005c14 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80005c08:	00053783          	ld	a5,0(a0)
    80005c0c:	0087b783          	ld	a5,8(a5)
    80005c10:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80005c14:	00000493          	li	s1,0
    80005c18:	0080006f          	j	80005c20 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80005c1c:	0014849b          	addiw	s1,s1,1
    80005c20:	0334d263          	bge	s1,s3,80005c44 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80005c24:	00349793          	slli	a5,s1,0x3
    80005c28:	00fa07b3          	add	a5,s4,a5
    80005c2c:	0007b503          	ld	a0,0(a5)
    80005c30:	fe0506e3          	beqz	a0,80005c1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80005c34:	00053783          	ld	a5,0(a0)
    80005c38:	0087b783          	ld	a5,8(a5)
    80005c3c:	000780e7          	jalr	a5
    80005c40:	fddff06f          	j	80005c1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    80005c44:	000b8a63          	beqz	s7,80005c58 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    80005c48:	000bb783          	ld	a5,0(s7)
    80005c4c:	0087b783          	ld	a5,8(a5)
    80005c50:	000b8513          	mv	a0,s7
    80005c54:	000780e7          	jalr	a5
        delete buffer;
    80005c58:	000a8e63          	beqz	s5,80005c74 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    80005c5c:	000a8513          	mv	a0,s5
    80005c60:	fffff097          	auipc	ra,0xfffff
    80005c64:	df4080e7          	jalr	-524(ra) # 80004a54 <_ZN9BufferCPPD1Ev>
    80005c68:	000a8513          	mv	a0,s5
    80005c6c:	ffffd097          	auipc	ra,0xffffd
    80005c70:	18c080e7          	jalr	396(ra) # 80002df8 <_ZdlPv>
    80005c74:	000c0113          	mv	sp,s8
    }
    80005c78:	f8040113          	addi	sp,s0,-128
    80005c7c:	07813083          	ld	ra,120(sp)
    80005c80:	07013403          	ld	s0,112(sp)
    80005c84:	06813483          	ld	s1,104(sp)
    80005c88:	06013903          	ld	s2,96(sp)
    80005c8c:	05813983          	ld	s3,88(sp)
    80005c90:	05013a03          	ld	s4,80(sp)
    80005c94:	04813a83          	ld	s5,72(sp)
    80005c98:	04013b03          	ld	s6,64(sp)
    80005c9c:	03813b83          	ld	s7,56(sp)
    80005ca0:	03013c03          	ld	s8,48(sp)
    80005ca4:	02813c83          	ld	s9,40(sp)
    80005ca8:	08010113          	addi	sp,sp,128
    80005cac:	00008067          	ret
    80005cb0:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80005cb4:	000a8513          	mv	a0,s5
    80005cb8:	ffffd097          	auipc	ra,0xffffd
    80005cbc:	140080e7          	jalr	320(ra) # 80002df8 <_ZdlPv>
    80005cc0:	00048513          	mv	a0,s1
    80005cc4:	0000b097          	auipc	ra,0xb
    80005cc8:	1e4080e7          	jalr	484(ra) # 80010ea8 <_Unwind_Resume>
    80005ccc:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80005cd0:	00048513          	mv	a0,s1
    80005cd4:	ffffd097          	auipc	ra,0xffffd
    80005cd8:	124080e7          	jalr	292(ra) # 80002df8 <_ZdlPv>
    80005cdc:	00090513          	mv	a0,s2
    80005ce0:	0000b097          	auipc	ra,0xb
    80005ce4:	1c8080e7          	jalr	456(ra) # 80010ea8 <_Unwind_Resume>
    80005ce8:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005cec:	000b8513          	mv	a0,s7
    80005cf0:	ffffd097          	auipc	ra,0xffffd
    80005cf4:	108080e7          	jalr	264(ra) # 80002df8 <_ZdlPv>
    80005cf8:	00048513          	mv	a0,s1
    80005cfc:	0000b097          	auipc	ra,0xb
    80005d00:	1ac080e7          	jalr	428(ra) # 80010ea8 <_Unwind_Resume>
    80005d04:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005d08:	00048513          	mv	a0,s1
    80005d0c:	ffffd097          	auipc	ra,0xffffd
    80005d10:	0ec080e7          	jalr	236(ra) # 80002df8 <_ZdlPv>
    80005d14:	00090513          	mv	a0,s2
    80005d18:	0000b097          	auipc	ra,0xb
    80005d1c:	190080e7          	jalr	400(ra) # 80010ea8 <_Unwind_Resume>
    80005d20:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80005d24:	000c8513          	mv	a0,s9
    80005d28:	ffffd097          	auipc	ra,0xffffd
    80005d2c:	0d0080e7          	jalr	208(ra) # 80002df8 <_ZdlPv>
    80005d30:	00048513          	mv	a0,s1
    80005d34:	0000b097          	auipc	ra,0xb
    80005d38:	174080e7          	jalr	372(ra) # 80010ea8 <_Unwind_Resume>

0000000080005d3c <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80005d3c:	ff010113          	addi	sp,sp,-16
    80005d40:	00813423          	sd	s0,8(sp)
    80005d44:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    80005d48:	00813403          	ld	s0,8(sp)
    80005d4c:	01010113          	addi	sp,sp,16
    80005d50:	00008067          	ret

0000000080005d54 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80005d54:	fe010113          	addi	sp,sp,-32
    80005d58:	00113c23          	sd	ra,24(sp)
    80005d5c:	00813823          	sd	s0,16(sp)
    80005d60:	00913423          	sd	s1,8(sp)
    80005d64:	02010413          	addi	s0,sp,32
    80005d68:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80005d6c:	ffffc097          	auipc	ra,0xffffc
    80005d70:	b40080e7          	jalr	-1216(ra) # 800018ac <_Z4getcv>
    80005d74:	0005059b          	sext.w	a1,a0
    80005d78:	01b00793          	li	a5,27
    80005d7c:	00f58c63          	beq	a1,a5,80005d94 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80005d80:	0104b783          	ld	a5,16(s1)
    80005d84:	0087b503          	ld	a0,8(a5)
    80005d88:	fffff097          	auipc	ra,0xfffff
    80005d8c:	b28080e7          	jalr	-1240(ra) # 800048b0 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80005d90:	fddff06f          	j	80005d6c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80005d94:	00100793          	li	a5,1
    80005d98:	0000a717          	auipc	a4,0xa
    80005d9c:	02f72223          	sw	a5,36(a4) # 8000fdbc <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80005da0:	0104b783          	ld	a5,16(s1)
    80005da4:	02100593          	li	a1,33
    80005da8:	0087b503          	ld	a0,8(a5)
    80005dac:	fffff097          	auipc	ra,0xfffff
    80005db0:	b04080e7          	jalr	-1276(ra) # 800048b0 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80005db4:	0104b783          	ld	a5,16(s1)
    80005db8:	0107b503          	ld	a0,16(a5)
    80005dbc:	ffffd097          	auipc	ra,0xffffd
    80005dc0:	148080e7          	jalr	328(ra) # 80002f04 <_ZN9Semaphore6signalEv>
        }
    80005dc4:	01813083          	ld	ra,24(sp)
    80005dc8:	01013403          	ld	s0,16(sp)
    80005dcc:	00813483          	ld	s1,8(sp)
    80005dd0:	02010113          	addi	sp,sp,32
    80005dd4:	00008067          	ret

0000000080005dd8 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80005dd8:	fd010113          	addi	sp,sp,-48
    80005ddc:	02113423          	sd	ra,40(sp)
    80005de0:	02813023          	sd	s0,32(sp)
    80005de4:	00913c23          	sd	s1,24(sp)
    80005de8:	01213823          	sd	s2,16(sp)
    80005dec:	01313423          	sd	s3,8(sp)
    80005df0:	03010413          	addi	s0,sp,48
    80005df4:	00050913          	mv	s2,a0
            int i = 0;
    80005df8:	00000993          	li	s3,0
    80005dfc:	0100006f          	j	80005e0c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80005e00:	00a00513          	li	a0,10
    80005e04:	ffffd097          	auipc	ra,0xffffd
    80005e08:	2fc080e7          	jalr	764(ra) # 80003100 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80005e0c:	0000a797          	auipc	a5,0xa
    80005e10:	fb07a783          	lw	a5,-80(a5) # 8000fdbc <_ZN19ConsumerProducerCPP9threadEndE>
    80005e14:	04079a63          	bnez	a5,80005e68 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80005e18:	01093783          	ld	a5,16(s2)
    80005e1c:	0087b503          	ld	a0,8(a5)
    80005e20:	fffff097          	auipc	ra,0xfffff
    80005e24:	b20080e7          	jalr	-1248(ra) # 80004940 <_ZN9BufferCPP3getEv>
                i++;
    80005e28:	0019849b          	addiw	s1,s3,1
    80005e2c:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80005e30:	0ff57513          	andi	a0,a0,255
    80005e34:	ffffd097          	auipc	ra,0xffffd
    80005e38:	2cc080e7          	jalr	716(ra) # 80003100 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80005e3c:	05000793          	li	a5,80
    80005e40:	02f4e4bb          	remw	s1,s1,a5
    80005e44:	fc0494e3          	bnez	s1,80005e0c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80005e48:	fb9ff06f          	j	80005e00 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80005e4c:	01093783          	ld	a5,16(s2)
    80005e50:	0087b503          	ld	a0,8(a5)
    80005e54:	fffff097          	auipc	ra,0xfffff
    80005e58:	aec080e7          	jalr	-1300(ra) # 80004940 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80005e5c:	0ff57513          	andi	a0,a0,255
    80005e60:	ffffd097          	auipc	ra,0xffffd
    80005e64:	2a0080e7          	jalr	672(ra) # 80003100 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80005e68:	01093783          	ld	a5,16(s2)
    80005e6c:	0087b503          	ld	a0,8(a5)
    80005e70:	fffff097          	auipc	ra,0xfffff
    80005e74:	b5c080e7          	jalr	-1188(ra) # 800049cc <_ZN9BufferCPP6getCntEv>
    80005e78:	fca04ae3          	bgtz	a0,80005e4c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80005e7c:	01093783          	ld	a5,16(s2)
    80005e80:	0107b503          	ld	a0,16(a5)
    80005e84:	ffffd097          	auipc	ra,0xffffd
    80005e88:	080080e7          	jalr	128(ra) # 80002f04 <_ZN9Semaphore6signalEv>
        }
    80005e8c:	02813083          	ld	ra,40(sp)
    80005e90:	02013403          	ld	s0,32(sp)
    80005e94:	01813483          	ld	s1,24(sp)
    80005e98:	01013903          	ld	s2,16(sp)
    80005e9c:	00813983          	ld	s3,8(sp)
    80005ea0:	03010113          	addi	sp,sp,48
    80005ea4:	00008067          	ret

0000000080005ea8 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    80005ea8:	ff010113          	addi	sp,sp,-16
    80005eac:	00113423          	sd	ra,8(sp)
    80005eb0:	00813023          	sd	s0,0(sp)
    80005eb4:	01010413          	addi	s0,sp,16
    80005eb8:	00006797          	auipc	a5,0x6
    80005ebc:	b4878793          	addi	a5,a5,-1208 # 8000ba00 <_ZTV8Consumer+0x10>
    80005ec0:	00f53023          	sd	a5,0(a0)
    80005ec4:	ffffd097          	auipc	ra,0xffffd
    80005ec8:	ea4080e7          	jalr	-348(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80005ecc:	00813083          	ld	ra,8(sp)
    80005ed0:	00013403          	ld	s0,0(sp)
    80005ed4:	01010113          	addi	sp,sp,16
    80005ed8:	00008067          	ret

0000000080005edc <_ZN8ConsumerD0Ev>:
    80005edc:	fe010113          	addi	sp,sp,-32
    80005ee0:	00113c23          	sd	ra,24(sp)
    80005ee4:	00813823          	sd	s0,16(sp)
    80005ee8:	00913423          	sd	s1,8(sp)
    80005eec:	02010413          	addi	s0,sp,32
    80005ef0:	00050493          	mv	s1,a0
    80005ef4:	00006797          	auipc	a5,0x6
    80005ef8:	b0c78793          	addi	a5,a5,-1268 # 8000ba00 <_ZTV8Consumer+0x10>
    80005efc:	00f53023          	sd	a5,0(a0)
    80005f00:	ffffd097          	auipc	ra,0xffffd
    80005f04:	e68080e7          	jalr	-408(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80005f08:	00048513          	mv	a0,s1
    80005f0c:	ffffd097          	auipc	ra,0xffffd
    80005f10:	eec080e7          	jalr	-276(ra) # 80002df8 <_ZdlPv>
    80005f14:	01813083          	ld	ra,24(sp)
    80005f18:	01013403          	ld	s0,16(sp)
    80005f1c:	00813483          	ld	s1,8(sp)
    80005f20:	02010113          	addi	sp,sp,32
    80005f24:	00008067          	ret

0000000080005f28 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80005f28:	ff010113          	addi	sp,sp,-16
    80005f2c:	00113423          	sd	ra,8(sp)
    80005f30:	00813023          	sd	s0,0(sp)
    80005f34:	01010413          	addi	s0,sp,16
    80005f38:	00006797          	auipc	a5,0x6
    80005f3c:	aa078793          	addi	a5,a5,-1376 # 8000b9d8 <_ZTV8Producer+0x10>
    80005f40:	00f53023          	sd	a5,0(a0)
    80005f44:	ffffd097          	auipc	ra,0xffffd
    80005f48:	e24080e7          	jalr	-476(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80005f4c:	00813083          	ld	ra,8(sp)
    80005f50:	00013403          	ld	s0,0(sp)
    80005f54:	01010113          	addi	sp,sp,16
    80005f58:	00008067          	ret

0000000080005f5c <_ZN8ProducerD0Ev>:
    80005f5c:	fe010113          	addi	sp,sp,-32
    80005f60:	00113c23          	sd	ra,24(sp)
    80005f64:	00813823          	sd	s0,16(sp)
    80005f68:	00913423          	sd	s1,8(sp)
    80005f6c:	02010413          	addi	s0,sp,32
    80005f70:	00050493          	mv	s1,a0
    80005f74:	00006797          	auipc	a5,0x6
    80005f78:	a6478793          	addi	a5,a5,-1436 # 8000b9d8 <_ZTV8Producer+0x10>
    80005f7c:	00f53023          	sd	a5,0(a0)
    80005f80:	ffffd097          	auipc	ra,0xffffd
    80005f84:	de8080e7          	jalr	-536(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80005f88:	00048513          	mv	a0,s1
    80005f8c:	ffffd097          	auipc	ra,0xffffd
    80005f90:	e6c080e7          	jalr	-404(ra) # 80002df8 <_ZdlPv>
    80005f94:	01813083          	ld	ra,24(sp)
    80005f98:	01013403          	ld	s0,16(sp)
    80005f9c:	00813483          	ld	s1,8(sp)
    80005fa0:	02010113          	addi	sp,sp,32
    80005fa4:	00008067          	ret

0000000080005fa8 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80005fa8:	ff010113          	addi	sp,sp,-16
    80005fac:	00113423          	sd	ra,8(sp)
    80005fb0:	00813023          	sd	s0,0(sp)
    80005fb4:	01010413          	addi	s0,sp,16
    80005fb8:	00006797          	auipc	a5,0x6
    80005fbc:	9f878793          	addi	a5,a5,-1544 # 8000b9b0 <_ZTV16ProducerKeyboard+0x10>
    80005fc0:	00f53023          	sd	a5,0(a0)
    80005fc4:	ffffd097          	auipc	ra,0xffffd
    80005fc8:	da4080e7          	jalr	-604(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80005fcc:	00813083          	ld	ra,8(sp)
    80005fd0:	00013403          	ld	s0,0(sp)
    80005fd4:	01010113          	addi	sp,sp,16
    80005fd8:	00008067          	ret

0000000080005fdc <_ZN16ProducerKeyboardD0Ev>:
    80005fdc:	fe010113          	addi	sp,sp,-32
    80005fe0:	00113c23          	sd	ra,24(sp)
    80005fe4:	00813823          	sd	s0,16(sp)
    80005fe8:	00913423          	sd	s1,8(sp)
    80005fec:	02010413          	addi	s0,sp,32
    80005ff0:	00050493          	mv	s1,a0
    80005ff4:	00006797          	auipc	a5,0x6
    80005ff8:	9bc78793          	addi	a5,a5,-1604 # 8000b9b0 <_ZTV16ProducerKeyboard+0x10>
    80005ffc:	00f53023          	sd	a5,0(a0)
    80006000:	ffffd097          	auipc	ra,0xffffd
    80006004:	d68080e7          	jalr	-664(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80006008:	00048513          	mv	a0,s1
    8000600c:	ffffd097          	auipc	ra,0xffffd
    80006010:	dec080e7          	jalr	-532(ra) # 80002df8 <_ZdlPv>
    80006014:	01813083          	ld	ra,24(sp)
    80006018:	01013403          	ld	s0,16(sp)
    8000601c:	00813483          	ld	s1,8(sp)
    80006020:	02010113          	addi	sp,sp,32
    80006024:	00008067          	ret

0000000080006028 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006028:	ff010113          	addi	sp,sp,-16
    8000602c:	00113423          	sd	ra,8(sp)
    80006030:	00813023          	sd	s0,0(sp)
    80006034:	01010413          	addi	s0,sp,16
    80006038:	00006797          	auipc	a5,0x6
    8000603c:	a4078793          	addi	a5,a5,-1472 # 8000ba78 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006040:	00f53023          	sd	a5,0(a0)
    80006044:	ffffd097          	auipc	ra,0xffffd
    80006048:	d24080e7          	jalr	-732(ra) # 80002d68 <_ZN6ThreadD1Ev>
    8000604c:	00813083          	ld	ra,8(sp)
    80006050:	00013403          	ld	s0,0(sp)
    80006054:	01010113          	addi	sp,sp,16
    80006058:	00008067          	ret

000000008000605c <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    8000605c:	fe010113          	addi	sp,sp,-32
    80006060:	00113c23          	sd	ra,24(sp)
    80006064:	00813823          	sd	s0,16(sp)
    80006068:	00913423          	sd	s1,8(sp)
    8000606c:	02010413          	addi	s0,sp,32
    80006070:	00050493          	mv	s1,a0
    80006074:	00006797          	auipc	a5,0x6
    80006078:	a0478793          	addi	a5,a5,-1532 # 8000ba78 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000607c:	00f53023          	sd	a5,0(a0)
    80006080:	ffffd097          	auipc	ra,0xffffd
    80006084:	ce8080e7          	jalr	-792(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80006088:	00048513          	mv	a0,s1
    8000608c:	ffffd097          	auipc	ra,0xffffd
    80006090:	d6c080e7          	jalr	-660(ra) # 80002df8 <_ZdlPv>
    80006094:	01813083          	ld	ra,24(sp)
    80006098:	01013403          	ld	s0,16(sp)
    8000609c:	00813483          	ld	s1,8(sp)
    800060a0:	02010113          	addi	sp,sp,32
    800060a4:	00008067          	ret

00000000800060a8 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    800060a8:	ff010113          	addi	sp,sp,-16
    800060ac:	00113423          	sd	ra,8(sp)
    800060b0:	00813023          	sd	s0,0(sp)
    800060b4:	01010413          	addi	s0,sp,16
    800060b8:	00006797          	auipc	a5,0x6
    800060bc:	97078793          	addi	a5,a5,-1680 # 8000ba28 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800060c0:	00f53023          	sd	a5,0(a0)
    800060c4:	ffffd097          	auipc	ra,0xffffd
    800060c8:	ca4080e7          	jalr	-860(ra) # 80002d68 <_ZN6ThreadD1Ev>
    800060cc:	00813083          	ld	ra,8(sp)
    800060d0:	00013403          	ld	s0,0(sp)
    800060d4:	01010113          	addi	sp,sp,16
    800060d8:	00008067          	ret

00000000800060dc <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    800060dc:	fe010113          	addi	sp,sp,-32
    800060e0:	00113c23          	sd	ra,24(sp)
    800060e4:	00813823          	sd	s0,16(sp)
    800060e8:	00913423          	sd	s1,8(sp)
    800060ec:	02010413          	addi	s0,sp,32
    800060f0:	00050493          	mv	s1,a0
    800060f4:	00006797          	auipc	a5,0x6
    800060f8:	93478793          	addi	a5,a5,-1740 # 8000ba28 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800060fc:	00f53023          	sd	a5,0(a0)
    80006100:	ffffd097          	auipc	ra,0xffffd
    80006104:	c68080e7          	jalr	-920(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80006108:	00048513          	mv	a0,s1
    8000610c:	ffffd097          	auipc	ra,0xffffd
    80006110:	cec080e7          	jalr	-788(ra) # 80002df8 <_ZdlPv>
    80006114:	01813083          	ld	ra,24(sp)
    80006118:	01013403          	ld	s0,16(sp)
    8000611c:	00813483          	ld	s1,8(sp)
    80006120:	02010113          	addi	sp,sp,32
    80006124:	00008067          	ret

0000000080006128 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006128:	ff010113          	addi	sp,sp,-16
    8000612c:	00113423          	sd	ra,8(sp)
    80006130:	00813023          	sd	s0,0(sp)
    80006134:	01010413          	addi	s0,sp,16
    80006138:	00006797          	auipc	a5,0x6
    8000613c:	91878793          	addi	a5,a5,-1768 # 8000ba50 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006140:	00f53023          	sd	a5,0(a0)
    80006144:	ffffd097          	auipc	ra,0xffffd
    80006148:	c24080e7          	jalr	-988(ra) # 80002d68 <_ZN6ThreadD1Ev>
    8000614c:	00813083          	ld	ra,8(sp)
    80006150:	00013403          	ld	s0,0(sp)
    80006154:	01010113          	addi	sp,sp,16
    80006158:	00008067          	ret

000000008000615c <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    8000615c:	fe010113          	addi	sp,sp,-32
    80006160:	00113c23          	sd	ra,24(sp)
    80006164:	00813823          	sd	s0,16(sp)
    80006168:	00913423          	sd	s1,8(sp)
    8000616c:	02010413          	addi	s0,sp,32
    80006170:	00050493          	mv	s1,a0
    80006174:	00006797          	auipc	a5,0x6
    80006178:	8dc78793          	addi	a5,a5,-1828 # 8000ba50 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000617c:	00f53023          	sd	a5,0(a0)
    80006180:	ffffd097          	auipc	ra,0xffffd
    80006184:	be8080e7          	jalr	-1048(ra) # 80002d68 <_ZN6ThreadD1Ev>
    80006188:	00048513          	mv	a0,s1
    8000618c:	ffffd097          	auipc	ra,0xffffd
    80006190:	c6c080e7          	jalr	-916(ra) # 80002df8 <_ZdlPv>
    80006194:	01813083          	ld	ra,24(sp)
    80006198:	01013403          	ld	s0,16(sp)
    8000619c:	00813483          	ld	s1,8(sp)
    800061a0:	02010113          	addi	sp,sp,32
    800061a4:	00008067          	ret

00000000800061a8 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    800061a8:	fe010113          	addi	sp,sp,-32
    800061ac:	00113c23          	sd	ra,24(sp)
    800061b0:	00813823          	sd	s0,16(sp)
    800061b4:	00913423          	sd	s1,8(sp)
    800061b8:	01213023          	sd	s2,0(sp)
    800061bc:	02010413          	addi	s0,sp,32
    800061c0:	00050493          	mv	s1,a0
            int i = 0;
    800061c4:	00000913          	li	s2,0
            while (!threadEnd) {
    800061c8:	0000a797          	auipc	a5,0xa
    800061cc:	bf47a783          	lw	a5,-1036(a5) # 8000fdbc <_ZN19ConsumerProducerCPP9threadEndE>
    800061d0:	04079263          	bnez	a5,80006214 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    800061d4:	0104b783          	ld	a5,16(s1)
    800061d8:	0007a583          	lw	a1,0(a5)
    800061dc:	0305859b          	addiw	a1,a1,48
    800061e0:	0087b503          	ld	a0,8(a5)
    800061e4:	ffffe097          	auipc	ra,0xffffe
    800061e8:	6cc080e7          	jalr	1740(ra) # 800048b0 <_ZN9BufferCPP3putEi>
                i++;
    800061ec:	0019071b          	addiw	a4,s2,1
    800061f0:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    800061f4:	0104b783          	ld	a5,16(s1)
    800061f8:	0007a783          	lw	a5,0(a5)
    800061fc:	00e787bb          	addw	a5,a5,a4
    80006200:	00500513          	li	a0,5
    80006204:	02a7e53b          	remw	a0,a5,a0
    80006208:	ffffd097          	auipc	ra,0xffffd
    8000620c:	da4080e7          	jalr	-604(ra) # 80002fac <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006210:	fb9ff06f          	j	800061c8 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80006214:	0104b783          	ld	a5,16(s1)
    80006218:	0107b503          	ld	a0,16(a5)
    8000621c:	ffffd097          	auipc	ra,0xffffd
    80006220:	ce8080e7          	jalr	-792(ra) # 80002f04 <_ZN9Semaphore6signalEv>
        }
    80006224:	01813083          	ld	ra,24(sp)
    80006228:	01013403          	ld	s0,16(sp)
    8000622c:	00813483          	ld	s1,8(sp)
    80006230:	00013903          	ld	s2,0(sp)
    80006234:	02010113          	addi	sp,sp,32
    80006238:	00008067          	ret

000000008000623c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    8000623c:	ff010113          	addi	sp,sp,-16
    80006240:	00113423          	sd	ra,8(sp)
    80006244:	00813023          	sd	s0,0(sp)
    80006248:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    8000624c:	01053583          	ld	a1,16(a0)
    80006250:	fffff097          	auipc	ra,0xfffff
    80006254:	fb0080e7          	jalr	-80(ra) # 80005200 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006258:	00813083          	ld	ra,8(sp)
    8000625c:	00013403          	ld	s0,0(sp)
    80006260:	01010113          	addi	sp,sp,16
    80006264:	00008067          	ret

0000000080006268 <_ZN8Producer3runEv>:
    void run() override {
    80006268:	ff010113          	addi	sp,sp,-16
    8000626c:	00113423          	sd	ra,8(sp)
    80006270:	00813023          	sd	s0,0(sp)
    80006274:	01010413          	addi	s0,sp,16
        producer(td);
    80006278:	01053583          	ld	a1,16(a0)
    8000627c:	fffff097          	auipc	ra,0xfffff
    80006280:	044080e7          	jalr	68(ra) # 800052c0 <_ZN8Producer8producerEPv>
    }
    80006284:	00813083          	ld	ra,8(sp)
    80006288:	00013403          	ld	s0,0(sp)
    8000628c:	01010113          	addi	sp,sp,16
    80006290:	00008067          	ret

0000000080006294 <_ZN8Consumer3runEv>:
    void run() override {
    80006294:	ff010113          	addi	sp,sp,-16
    80006298:	00113423          	sd	ra,8(sp)
    8000629c:	00813023          	sd	s0,0(sp)
    800062a0:	01010413          	addi	s0,sp,16
        consumer(td);
    800062a4:	01053583          	ld	a1,16(a0)
    800062a8:	fffff097          	auipc	ra,0xfffff
    800062ac:	0ac080e7          	jalr	172(ra) # 80005354 <_ZN8Consumer8consumerEPv>
    }
    800062b0:	00813083          	ld	ra,8(sp)
    800062b4:	00013403          	ld	s0,0(sp)
    800062b8:	01010113          	addi	sp,sp,16
    800062bc:	00008067          	ret

00000000800062c0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800062c0:	fe010113          	addi	sp,sp,-32
    800062c4:	00113c23          	sd	ra,24(sp)
    800062c8:	00813823          	sd	s0,16(sp)
    800062cc:	00913423          	sd	s1,8(sp)
    800062d0:	01213023          	sd	s2,0(sp)
    800062d4:	02010413          	addi	s0,sp,32
    800062d8:	00050493          	mv	s1,a0
    800062dc:	00058913          	mv	s2,a1
    800062e0:	0015879b          	addiw	a5,a1,1
    800062e4:	0007851b          	sext.w	a0,a5
    800062e8:	00f4a023          	sw	a5,0(s1)
    800062ec:	0004a823          	sw	zero,16(s1)
    800062f0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800062f4:	00251513          	slli	a0,a0,0x2
    800062f8:	ffffb097          	auipc	ra,0xffffb
    800062fc:	304080e7          	jalr	772(ra) # 800015fc <_Z9mem_allocm>
    80006300:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006304:	00000593          	li	a1,0
    80006308:	02048513          	addi	a0,s1,32
    8000630c:	ffffb097          	auipc	ra,0xffffb
    80006310:	4b8080e7          	jalr	1208(ra) # 800017c4 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006314:	00090593          	mv	a1,s2
    80006318:	01848513          	addi	a0,s1,24
    8000631c:	ffffb097          	auipc	ra,0xffffb
    80006320:	4a8080e7          	jalr	1192(ra) # 800017c4 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006324:	00100593          	li	a1,1
    80006328:	02848513          	addi	a0,s1,40
    8000632c:	ffffb097          	auipc	ra,0xffffb
    80006330:	498080e7          	jalr	1176(ra) # 800017c4 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80006334:	00100593          	li	a1,1
    80006338:	03048513          	addi	a0,s1,48
    8000633c:	ffffb097          	auipc	ra,0xffffb
    80006340:	488080e7          	jalr	1160(ra) # 800017c4 <_Z8sem_openPP10_semaphorej>
}
    80006344:	01813083          	ld	ra,24(sp)
    80006348:	01013403          	ld	s0,16(sp)
    8000634c:	00813483          	ld	s1,8(sp)
    80006350:	00013903          	ld	s2,0(sp)
    80006354:	02010113          	addi	sp,sp,32
    80006358:	00008067          	ret

000000008000635c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000635c:	fe010113          	addi	sp,sp,-32
    80006360:	00113c23          	sd	ra,24(sp)
    80006364:	00813823          	sd	s0,16(sp)
    80006368:	00913423          	sd	s1,8(sp)
    8000636c:	01213023          	sd	s2,0(sp)
    80006370:	02010413          	addi	s0,sp,32
    80006374:	00050493          	mv	s1,a0
    80006378:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    8000637c:	01853503          	ld	a0,24(a0)
    80006380:	ffffb097          	auipc	ra,0xffffb
    80006384:	4a8080e7          	jalr	1192(ra) # 80001828 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80006388:	0304b503          	ld	a0,48(s1)
    8000638c:	ffffb097          	auipc	ra,0xffffb
    80006390:	49c080e7          	jalr	1180(ra) # 80001828 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80006394:	0084b783          	ld	a5,8(s1)
    80006398:	0144a703          	lw	a4,20(s1)
    8000639c:	00271713          	slli	a4,a4,0x2
    800063a0:	00e787b3          	add	a5,a5,a4
    800063a4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800063a8:	0144a783          	lw	a5,20(s1)
    800063ac:	0017879b          	addiw	a5,a5,1
    800063b0:	0004a703          	lw	a4,0(s1)
    800063b4:	02e7e7bb          	remw	a5,a5,a4
    800063b8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800063bc:	0304b503          	ld	a0,48(s1)
    800063c0:	ffffb097          	auipc	ra,0xffffb
    800063c4:	494080e7          	jalr	1172(ra) # 80001854 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    800063c8:	0204b503          	ld	a0,32(s1)
    800063cc:	ffffb097          	auipc	ra,0xffffb
    800063d0:	488080e7          	jalr	1160(ra) # 80001854 <_Z10sem_signalP10_semaphore>

}
    800063d4:	01813083          	ld	ra,24(sp)
    800063d8:	01013403          	ld	s0,16(sp)
    800063dc:	00813483          	ld	s1,8(sp)
    800063e0:	00013903          	ld	s2,0(sp)
    800063e4:	02010113          	addi	sp,sp,32
    800063e8:	00008067          	ret

00000000800063ec <_ZN6Buffer3getEv>:

int Buffer::get() {
    800063ec:	fe010113          	addi	sp,sp,-32
    800063f0:	00113c23          	sd	ra,24(sp)
    800063f4:	00813823          	sd	s0,16(sp)
    800063f8:	00913423          	sd	s1,8(sp)
    800063fc:	01213023          	sd	s2,0(sp)
    80006400:	02010413          	addi	s0,sp,32
    80006404:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006408:	02053503          	ld	a0,32(a0)
    8000640c:	ffffb097          	auipc	ra,0xffffb
    80006410:	41c080e7          	jalr	1052(ra) # 80001828 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006414:	0284b503          	ld	a0,40(s1)
    80006418:	ffffb097          	auipc	ra,0xffffb
    8000641c:	410080e7          	jalr	1040(ra) # 80001828 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006420:	0084b703          	ld	a4,8(s1)
    80006424:	0104a783          	lw	a5,16(s1)
    80006428:	00279693          	slli	a3,a5,0x2
    8000642c:	00d70733          	add	a4,a4,a3
    80006430:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006434:	0017879b          	addiw	a5,a5,1
    80006438:	0004a703          	lw	a4,0(s1)
    8000643c:	02e7e7bb          	remw	a5,a5,a4
    80006440:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006444:	0284b503          	ld	a0,40(s1)
    80006448:	ffffb097          	auipc	ra,0xffffb
    8000644c:	40c080e7          	jalr	1036(ra) # 80001854 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006450:	0184b503          	ld	a0,24(s1)
    80006454:	ffffb097          	auipc	ra,0xffffb
    80006458:	400080e7          	jalr	1024(ra) # 80001854 <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000645c:	00090513          	mv	a0,s2
    80006460:	01813083          	ld	ra,24(sp)
    80006464:	01013403          	ld	s0,16(sp)
    80006468:	00813483          	ld	s1,8(sp)
    8000646c:	00013903          	ld	s2,0(sp)
    80006470:	02010113          	addi	sp,sp,32
    80006474:	00008067          	ret

0000000080006478 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006478:	fe010113          	addi	sp,sp,-32
    8000647c:	00113c23          	sd	ra,24(sp)
    80006480:	00813823          	sd	s0,16(sp)
    80006484:	00913423          	sd	s1,8(sp)
    80006488:	01213023          	sd	s2,0(sp)
    8000648c:	02010413          	addi	s0,sp,32
    80006490:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006494:	02853503          	ld	a0,40(a0)
    80006498:	ffffb097          	auipc	ra,0xffffb
    8000649c:	390080e7          	jalr	912(ra) # 80001828 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800064a0:	0304b503          	ld	a0,48(s1)
    800064a4:	ffffb097          	auipc	ra,0xffffb
    800064a8:	384080e7          	jalr	900(ra) # 80001828 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    800064ac:	0144a783          	lw	a5,20(s1)
    800064b0:	0104a903          	lw	s2,16(s1)
    800064b4:	0327ce63          	blt	a5,s2,800064f0 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800064b8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800064bc:	0304b503          	ld	a0,48(s1)
    800064c0:	ffffb097          	auipc	ra,0xffffb
    800064c4:	394080e7          	jalr	916(ra) # 80001854 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    800064c8:	0284b503          	ld	a0,40(s1)
    800064cc:	ffffb097          	auipc	ra,0xffffb
    800064d0:	388080e7          	jalr	904(ra) # 80001854 <_Z10sem_signalP10_semaphore>

    return ret;
}
    800064d4:	00090513          	mv	a0,s2
    800064d8:	01813083          	ld	ra,24(sp)
    800064dc:	01013403          	ld	s0,16(sp)
    800064e0:	00813483          	ld	s1,8(sp)
    800064e4:	00013903          	ld	s2,0(sp)
    800064e8:	02010113          	addi	sp,sp,32
    800064ec:	00008067          	ret
        ret = cap - head + tail;
    800064f0:	0004a703          	lw	a4,0(s1)
    800064f4:	4127093b          	subw	s2,a4,s2
    800064f8:	00f9093b          	addw	s2,s2,a5
    800064fc:	fc1ff06f          	j	800064bc <_ZN6Buffer6getCntEv+0x44>

0000000080006500 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006500:	fe010113          	addi	sp,sp,-32
    80006504:	00113c23          	sd	ra,24(sp)
    80006508:	00813823          	sd	s0,16(sp)
    8000650c:	00913423          	sd	s1,8(sp)
    80006510:	02010413          	addi	s0,sp,32
    80006514:	00050493          	mv	s1,a0
    putc('\n');
    80006518:	00a00513          	li	a0,10
    8000651c:	ffffb097          	auipc	ra,0xffffb
    80006520:	3b8080e7          	jalr	952(ra) # 800018d4 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006524:	00003517          	auipc	a0,0x3
    80006528:	e8c50513          	addi	a0,a0,-372 # 800093b0 <CONSOLE_STATUS+0x3a0>
    8000652c:	ffffc097          	auipc	ra,0xffffc
    80006530:	b50080e7          	jalr	-1200(ra) # 8000207c <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006534:	00048513          	mv	a0,s1
    80006538:	00000097          	auipc	ra,0x0
    8000653c:	f40080e7          	jalr	-192(ra) # 80006478 <_ZN6Buffer6getCntEv>
    80006540:	02a05c63          	blez	a0,80006578 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006544:	0084b783          	ld	a5,8(s1)
    80006548:	0104a703          	lw	a4,16(s1)
    8000654c:	00271713          	slli	a4,a4,0x2
    80006550:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006554:	0007c503          	lbu	a0,0(a5)
    80006558:	ffffb097          	auipc	ra,0xffffb
    8000655c:	37c080e7          	jalr	892(ra) # 800018d4 <_Z4putcc>
        head = (head + 1) % cap;
    80006560:	0104a783          	lw	a5,16(s1)
    80006564:	0017879b          	addiw	a5,a5,1
    80006568:	0004a703          	lw	a4,0(s1)
    8000656c:	02e7e7bb          	remw	a5,a5,a4
    80006570:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006574:	fc1ff06f          	j	80006534 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006578:	02100513          	li	a0,33
    8000657c:	ffffb097          	auipc	ra,0xffffb
    80006580:	358080e7          	jalr	856(ra) # 800018d4 <_Z4putcc>
    putc('\n');
    80006584:	00a00513          	li	a0,10
    80006588:	ffffb097          	auipc	ra,0xffffb
    8000658c:	34c080e7          	jalr	844(ra) # 800018d4 <_Z4putcc>
    mem_free(buffer);
    80006590:	0084b503          	ld	a0,8(s1)
    80006594:	ffffb097          	auipc	ra,0xffffb
    80006598:	098080e7          	jalr	152(ra) # 8000162c <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000659c:	0204b503          	ld	a0,32(s1)
    800065a0:	ffffb097          	auipc	ra,0xffffb
    800065a4:	25c080e7          	jalr	604(ra) # 800017fc <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    800065a8:	0184b503          	ld	a0,24(s1)
    800065ac:	ffffb097          	auipc	ra,0xffffb
    800065b0:	250080e7          	jalr	592(ra) # 800017fc <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    800065b4:	0304b503          	ld	a0,48(s1)
    800065b8:	ffffb097          	auipc	ra,0xffffb
    800065bc:	244080e7          	jalr	580(ra) # 800017fc <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    800065c0:	0284b503          	ld	a0,40(s1)
    800065c4:	ffffb097          	auipc	ra,0xffffb
    800065c8:	238080e7          	jalr	568(ra) # 800017fc <_Z9sem_closeP10_semaphore>
}
    800065cc:	01813083          	ld	ra,24(sp)
    800065d0:	01013403          	ld	s0,16(sp)
    800065d4:	00813483          	ld	s1,8(sp)
    800065d8:	02010113          	addi	sp,sp,32
    800065dc:	00008067          	ret

00000000800065e0 <start>:
    800065e0:	ff010113          	addi	sp,sp,-16
    800065e4:	00813423          	sd	s0,8(sp)
    800065e8:	01010413          	addi	s0,sp,16
    800065ec:	300027f3          	csrr	a5,mstatus
    800065f0:	ffffe737          	lui	a4,0xffffe
    800065f4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed7bf>
    800065f8:	00e7f7b3          	and	a5,a5,a4
    800065fc:	00001737          	lui	a4,0x1
    80006600:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006604:	00e7e7b3          	or	a5,a5,a4
    80006608:	30079073          	csrw	mstatus,a5
    8000660c:	00000797          	auipc	a5,0x0
    80006610:	16078793          	addi	a5,a5,352 # 8000676c <system_main>
    80006614:	34179073          	csrw	mepc,a5
    80006618:	00000793          	li	a5,0
    8000661c:	18079073          	csrw	satp,a5
    80006620:	000107b7          	lui	a5,0x10
    80006624:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006628:	30279073          	csrw	medeleg,a5
    8000662c:	30379073          	csrw	mideleg,a5
    80006630:	104027f3          	csrr	a5,sie
    80006634:	2227e793          	ori	a5,a5,546
    80006638:	10479073          	csrw	sie,a5
    8000663c:	fff00793          	li	a5,-1
    80006640:	00a7d793          	srli	a5,a5,0xa
    80006644:	3b079073          	csrw	pmpaddr0,a5
    80006648:	00f00793          	li	a5,15
    8000664c:	3a079073          	csrw	pmpcfg0,a5
    80006650:	f14027f3          	csrr	a5,mhartid
    80006654:	0200c737          	lui	a4,0x200c
    80006658:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000665c:	0007869b          	sext.w	a3,a5
    80006660:	00269713          	slli	a4,a3,0x2
    80006664:	000f4637          	lui	a2,0xf4
    80006668:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000666c:	00d70733          	add	a4,a4,a3
    80006670:	0037979b          	slliw	a5,a5,0x3
    80006674:	020046b7          	lui	a3,0x2004
    80006678:	00d787b3          	add	a5,a5,a3
    8000667c:	00c585b3          	add	a1,a1,a2
    80006680:	00371693          	slli	a3,a4,0x3
    80006684:	00009717          	auipc	a4,0x9
    80006688:	75c70713          	addi	a4,a4,1884 # 8000fde0 <timer_scratch>
    8000668c:	00b7b023          	sd	a1,0(a5)
    80006690:	00d70733          	add	a4,a4,a3
    80006694:	00f73c23          	sd	a5,24(a4)
    80006698:	02c73023          	sd	a2,32(a4)
    8000669c:	34071073          	csrw	mscratch,a4
    800066a0:	00000797          	auipc	a5,0x0
    800066a4:	6e078793          	addi	a5,a5,1760 # 80006d80 <timervec>
    800066a8:	30579073          	csrw	mtvec,a5
    800066ac:	300027f3          	csrr	a5,mstatus
    800066b0:	0087e793          	ori	a5,a5,8
    800066b4:	30079073          	csrw	mstatus,a5
    800066b8:	304027f3          	csrr	a5,mie
    800066bc:	0807e793          	ori	a5,a5,128
    800066c0:	30479073          	csrw	mie,a5
    800066c4:	f14027f3          	csrr	a5,mhartid
    800066c8:	0007879b          	sext.w	a5,a5
    800066cc:	00078213          	mv	tp,a5
    800066d0:	30200073          	mret
    800066d4:	00813403          	ld	s0,8(sp)
    800066d8:	01010113          	addi	sp,sp,16
    800066dc:	00008067          	ret

00000000800066e0 <timerinit>:
    800066e0:	ff010113          	addi	sp,sp,-16
    800066e4:	00813423          	sd	s0,8(sp)
    800066e8:	01010413          	addi	s0,sp,16
    800066ec:	f14027f3          	csrr	a5,mhartid
    800066f0:	0200c737          	lui	a4,0x200c
    800066f4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800066f8:	0007869b          	sext.w	a3,a5
    800066fc:	00269713          	slli	a4,a3,0x2
    80006700:	000f4637          	lui	a2,0xf4
    80006704:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006708:	00d70733          	add	a4,a4,a3
    8000670c:	0037979b          	slliw	a5,a5,0x3
    80006710:	020046b7          	lui	a3,0x2004
    80006714:	00d787b3          	add	a5,a5,a3
    80006718:	00c585b3          	add	a1,a1,a2
    8000671c:	00371693          	slli	a3,a4,0x3
    80006720:	00009717          	auipc	a4,0x9
    80006724:	6c070713          	addi	a4,a4,1728 # 8000fde0 <timer_scratch>
    80006728:	00b7b023          	sd	a1,0(a5)
    8000672c:	00d70733          	add	a4,a4,a3
    80006730:	00f73c23          	sd	a5,24(a4)
    80006734:	02c73023          	sd	a2,32(a4)
    80006738:	34071073          	csrw	mscratch,a4
    8000673c:	00000797          	auipc	a5,0x0
    80006740:	64478793          	addi	a5,a5,1604 # 80006d80 <timervec>
    80006744:	30579073          	csrw	mtvec,a5
    80006748:	300027f3          	csrr	a5,mstatus
    8000674c:	0087e793          	ori	a5,a5,8
    80006750:	30079073          	csrw	mstatus,a5
    80006754:	304027f3          	csrr	a5,mie
    80006758:	0807e793          	ori	a5,a5,128
    8000675c:	30479073          	csrw	mie,a5
    80006760:	00813403          	ld	s0,8(sp)
    80006764:	01010113          	addi	sp,sp,16
    80006768:	00008067          	ret

000000008000676c <system_main>:
    8000676c:	fe010113          	addi	sp,sp,-32
    80006770:	00813823          	sd	s0,16(sp)
    80006774:	00913423          	sd	s1,8(sp)
    80006778:	00113c23          	sd	ra,24(sp)
    8000677c:	02010413          	addi	s0,sp,32
    80006780:	00000097          	auipc	ra,0x0
    80006784:	0c4080e7          	jalr	196(ra) # 80006844 <cpuid>
    80006788:	00005497          	auipc	s1,0x5
    8000678c:	3d848493          	addi	s1,s1,984 # 8000bb60 <started>
    80006790:	02050263          	beqz	a0,800067b4 <system_main+0x48>
    80006794:	0004a783          	lw	a5,0(s1)
    80006798:	0007879b          	sext.w	a5,a5
    8000679c:	fe078ce3          	beqz	a5,80006794 <system_main+0x28>
    800067a0:	0ff0000f          	fence
    800067a4:	00003517          	auipc	a0,0x3
    800067a8:	e3c50513          	addi	a0,a0,-452 # 800095e0 <CONSOLE_STATUS+0x5d0>
    800067ac:	00001097          	auipc	ra,0x1
    800067b0:	a70080e7          	jalr	-1424(ra) # 8000721c <panic>
    800067b4:	00001097          	auipc	ra,0x1
    800067b8:	9c4080e7          	jalr	-1596(ra) # 80007178 <consoleinit>
    800067bc:	00001097          	auipc	ra,0x1
    800067c0:	150080e7          	jalr	336(ra) # 8000790c <printfinit>
    800067c4:	00003517          	auipc	a0,0x3
    800067c8:	9dc50513          	addi	a0,a0,-1572 # 800091a0 <CONSOLE_STATUS+0x190>
    800067cc:	00001097          	auipc	ra,0x1
    800067d0:	aac080e7          	jalr	-1364(ra) # 80007278 <__printf>
    800067d4:	00003517          	auipc	a0,0x3
    800067d8:	ddc50513          	addi	a0,a0,-548 # 800095b0 <CONSOLE_STATUS+0x5a0>
    800067dc:	00001097          	auipc	ra,0x1
    800067e0:	a9c080e7          	jalr	-1380(ra) # 80007278 <__printf>
    800067e4:	00003517          	auipc	a0,0x3
    800067e8:	9bc50513          	addi	a0,a0,-1604 # 800091a0 <CONSOLE_STATUS+0x190>
    800067ec:	00001097          	auipc	ra,0x1
    800067f0:	a8c080e7          	jalr	-1396(ra) # 80007278 <__printf>
    800067f4:	00001097          	auipc	ra,0x1
    800067f8:	4a4080e7          	jalr	1188(ra) # 80007c98 <kinit>
    800067fc:	00000097          	auipc	ra,0x0
    80006800:	148080e7          	jalr	328(ra) # 80006944 <trapinit>
    80006804:	00000097          	auipc	ra,0x0
    80006808:	16c080e7          	jalr	364(ra) # 80006970 <trapinithart>
    8000680c:	00000097          	auipc	ra,0x0
    80006810:	5b4080e7          	jalr	1460(ra) # 80006dc0 <plicinit>
    80006814:	00000097          	auipc	ra,0x0
    80006818:	5d4080e7          	jalr	1492(ra) # 80006de8 <plicinithart>
    8000681c:	00000097          	auipc	ra,0x0
    80006820:	078080e7          	jalr	120(ra) # 80006894 <userinit>
    80006824:	0ff0000f          	fence
    80006828:	00100793          	li	a5,1
    8000682c:	00003517          	auipc	a0,0x3
    80006830:	d9c50513          	addi	a0,a0,-612 # 800095c8 <CONSOLE_STATUS+0x5b8>
    80006834:	00f4a023          	sw	a5,0(s1)
    80006838:	00001097          	auipc	ra,0x1
    8000683c:	a40080e7          	jalr	-1472(ra) # 80007278 <__printf>
    80006840:	0000006f          	j	80006840 <system_main+0xd4>

0000000080006844 <cpuid>:
    80006844:	ff010113          	addi	sp,sp,-16
    80006848:	00813423          	sd	s0,8(sp)
    8000684c:	01010413          	addi	s0,sp,16
    80006850:	00020513          	mv	a0,tp
    80006854:	00813403          	ld	s0,8(sp)
    80006858:	0005051b          	sext.w	a0,a0
    8000685c:	01010113          	addi	sp,sp,16
    80006860:	00008067          	ret

0000000080006864 <mycpu>:
    80006864:	ff010113          	addi	sp,sp,-16
    80006868:	00813423          	sd	s0,8(sp)
    8000686c:	01010413          	addi	s0,sp,16
    80006870:	00020793          	mv	a5,tp
    80006874:	00813403          	ld	s0,8(sp)
    80006878:	0007879b          	sext.w	a5,a5
    8000687c:	00779793          	slli	a5,a5,0x7
    80006880:	0000a517          	auipc	a0,0xa
    80006884:	59050513          	addi	a0,a0,1424 # 80010e10 <cpus>
    80006888:	00f50533          	add	a0,a0,a5
    8000688c:	01010113          	addi	sp,sp,16
    80006890:	00008067          	ret

0000000080006894 <userinit>:
    80006894:	ff010113          	addi	sp,sp,-16
    80006898:	00813423          	sd	s0,8(sp)
    8000689c:	01010413          	addi	s0,sp,16
    800068a0:	00813403          	ld	s0,8(sp)
    800068a4:	01010113          	addi	sp,sp,16
    800068a8:	ffffc317          	auipc	t1,0xffffc
    800068ac:	cb830067          	jr	-840(t1) # 80002560 <main>

00000000800068b0 <either_copyout>:
    800068b0:	ff010113          	addi	sp,sp,-16
    800068b4:	00813023          	sd	s0,0(sp)
    800068b8:	00113423          	sd	ra,8(sp)
    800068bc:	01010413          	addi	s0,sp,16
    800068c0:	02051663          	bnez	a0,800068ec <either_copyout+0x3c>
    800068c4:	00058513          	mv	a0,a1
    800068c8:	00060593          	mv	a1,a2
    800068cc:	0006861b          	sext.w	a2,a3
    800068d0:	00002097          	auipc	ra,0x2
    800068d4:	c54080e7          	jalr	-940(ra) # 80008524 <__memmove>
    800068d8:	00813083          	ld	ra,8(sp)
    800068dc:	00013403          	ld	s0,0(sp)
    800068e0:	00000513          	li	a0,0
    800068e4:	01010113          	addi	sp,sp,16
    800068e8:	00008067          	ret
    800068ec:	00003517          	auipc	a0,0x3
    800068f0:	d1c50513          	addi	a0,a0,-740 # 80009608 <CONSOLE_STATUS+0x5f8>
    800068f4:	00001097          	auipc	ra,0x1
    800068f8:	928080e7          	jalr	-1752(ra) # 8000721c <panic>

00000000800068fc <either_copyin>:
    800068fc:	ff010113          	addi	sp,sp,-16
    80006900:	00813023          	sd	s0,0(sp)
    80006904:	00113423          	sd	ra,8(sp)
    80006908:	01010413          	addi	s0,sp,16
    8000690c:	02059463          	bnez	a1,80006934 <either_copyin+0x38>
    80006910:	00060593          	mv	a1,a2
    80006914:	0006861b          	sext.w	a2,a3
    80006918:	00002097          	auipc	ra,0x2
    8000691c:	c0c080e7          	jalr	-1012(ra) # 80008524 <__memmove>
    80006920:	00813083          	ld	ra,8(sp)
    80006924:	00013403          	ld	s0,0(sp)
    80006928:	00000513          	li	a0,0
    8000692c:	01010113          	addi	sp,sp,16
    80006930:	00008067          	ret
    80006934:	00003517          	auipc	a0,0x3
    80006938:	cfc50513          	addi	a0,a0,-772 # 80009630 <CONSOLE_STATUS+0x620>
    8000693c:	00001097          	auipc	ra,0x1
    80006940:	8e0080e7          	jalr	-1824(ra) # 8000721c <panic>

0000000080006944 <trapinit>:
    80006944:	ff010113          	addi	sp,sp,-16
    80006948:	00813423          	sd	s0,8(sp)
    8000694c:	01010413          	addi	s0,sp,16
    80006950:	00813403          	ld	s0,8(sp)
    80006954:	00003597          	auipc	a1,0x3
    80006958:	d0458593          	addi	a1,a1,-764 # 80009658 <CONSOLE_STATUS+0x648>
    8000695c:	0000a517          	auipc	a0,0xa
    80006960:	53450513          	addi	a0,a0,1332 # 80010e90 <tickslock>
    80006964:	01010113          	addi	sp,sp,16
    80006968:	00001317          	auipc	t1,0x1
    8000696c:	5c030067          	jr	1472(t1) # 80007f28 <initlock>

0000000080006970 <trapinithart>:
    80006970:	ff010113          	addi	sp,sp,-16
    80006974:	00813423          	sd	s0,8(sp)
    80006978:	01010413          	addi	s0,sp,16
    8000697c:	00000797          	auipc	a5,0x0
    80006980:	2f478793          	addi	a5,a5,756 # 80006c70 <kernelvec>
    80006984:	10579073          	csrw	stvec,a5
    80006988:	00813403          	ld	s0,8(sp)
    8000698c:	01010113          	addi	sp,sp,16
    80006990:	00008067          	ret

0000000080006994 <usertrap>:
    80006994:	ff010113          	addi	sp,sp,-16
    80006998:	00813423          	sd	s0,8(sp)
    8000699c:	01010413          	addi	s0,sp,16
    800069a0:	00813403          	ld	s0,8(sp)
    800069a4:	01010113          	addi	sp,sp,16
    800069a8:	00008067          	ret

00000000800069ac <usertrapret>:
    800069ac:	ff010113          	addi	sp,sp,-16
    800069b0:	00813423          	sd	s0,8(sp)
    800069b4:	01010413          	addi	s0,sp,16
    800069b8:	00813403          	ld	s0,8(sp)
    800069bc:	01010113          	addi	sp,sp,16
    800069c0:	00008067          	ret

00000000800069c4 <kerneltrap>:
    800069c4:	fe010113          	addi	sp,sp,-32
    800069c8:	00813823          	sd	s0,16(sp)
    800069cc:	00113c23          	sd	ra,24(sp)
    800069d0:	00913423          	sd	s1,8(sp)
    800069d4:	02010413          	addi	s0,sp,32
    800069d8:	142025f3          	csrr	a1,scause
    800069dc:	100027f3          	csrr	a5,sstatus
    800069e0:	0027f793          	andi	a5,a5,2
    800069e4:	10079c63          	bnez	a5,80006afc <kerneltrap+0x138>
    800069e8:	142027f3          	csrr	a5,scause
    800069ec:	0207ce63          	bltz	a5,80006a28 <kerneltrap+0x64>
    800069f0:	00003517          	auipc	a0,0x3
    800069f4:	cb050513          	addi	a0,a0,-848 # 800096a0 <CONSOLE_STATUS+0x690>
    800069f8:	00001097          	auipc	ra,0x1
    800069fc:	880080e7          	jalr	-1920(ra) # 80007278 <__printf>
    80006a00:	141025f3          	csrr	a1,sepc
    80006a04:	14302673          	csrr	a2,stval
    80006a08:	00003517          	auipc	a0,0x3
    80006a0c:	ca850513          	addi	a0,a0,-856 # 800096b0 <CONSOLE_STATUS+0x6a0>
    80006a10:	00001097          	auipc	ra,0x1
    80006a14:	868080e7          	jalr	-1944(ra) # 80007278 <__printf>
    80006a18:	00003517          	auipc	a0,0x3
    80006a1c:	cb050513          	addi	a0,a0,-848 # 800096c8 <CONSOLE_STATUS+0x6b8>
    80006a20:	00000097          	auipc	ra,0x0
    80006a24:	7fc080e7          	jalr	2044(ra) # 8000721c <panic>
    80006a28:	0ff7f713          	andi	a4,a5,255
    80006a2c:	00900693          	li	a3,9
    80006a30:	04d70063          	beq	a4,a3,80006a70 <kerneltrap+0xac>
    80006a34:	fff00713          	li	a4,-1
    80006a38:	03f71713          	slli	a4,a4,0x3f
    80006a3c:	00170713          	addi	a4,a4,1
    80006a40:	fae798e3          	bne	a5,a4,800069f0 <kerneltrap+0x2c>
    80006a44:	00000097          	auipc	ra,0x0
    80006a48:	e00080e7          	jalr	-512(ra) # 80006844 <cpuid>
    80006a4c:	06050663          	beqz	a0,80006ab8 <kerneltrap+0xf4>
    80006a50:	144027f3          	csrr	a5,sip
    80006a54:	ffd7f793          	andi	a5,a5,-3
    80006a58:	14479073          	csrw	sip,a5
    80006a5c:	01813083          	ld	ra,24(sp)
    80006a60:	01013403          	ld	s0,16(sp)
    80006a64:	00813483          	ld	s1,8(sp)
    80006a68:	02010113          	addi	sp,sp,32
    80006a6c:	00008067          	ret
    80006a70:	00000097          	auipc	ra,0x0
    80006a74:	3c4080e7          	jalr	964(ra) # 80006e34 <plic_claim>
    80006a78:	00a00793          	li	a5,10
    80006a7c:	00050493          	mv	s1,a0
    80006a80:	06f50863          	beq	a0,a5,80006af0 <kerneltrap+0x12c>
    80006a84:	fc050ce3          	beqz	a0,80006a5c <kerneltrap+0x98>
    80006a88:	00050593          	mv	a1,a0
    80006a8c:	00003517          	auipc	a0,0x3
    80006a90:	bf450513          	addi	a0,a0,-1036 # 80009680 <CONSOLE_STATUS+0x670>
    80006a94:	00000097          	auipc	ra,0x0
    80006a98:	7e4080e7          	jalr	2020(ra) # 80007278 <__printf>
    80006a9c:	01013403          	ld	s0,16(sp)
    80006aa0:	01813083          	ld	ra,24(sp)
    80006aa4:	00048513          	mv	a0,s1
    80006aa8:	00813483          	ld	s1,8(sp)
    80006aac:	02010113          	addi	sp,sp,32
    80006ab0:	00000317          	auipc	t1,0x0
    80006ab4:	3bc30067          	jr	956(t1) # 80006e6c <plic_complete>
    80006ab8:	0000a517          	auipc	a0,0xa
    80006abc:	3d850513          	addi	a0,a0,984 # 80010e90 <tickslock>
    80006ac0:	00001097          	auipc	ra,0x1
    80006ac4:	48c080e7          	jalr	1164(ra) # 80007f4c <acquire>
    80006ac8:	00005717          	auipc	a4,0x5
    80006acc:	09c70713          	addi	a4,a4,156 # 8000bb64 <ticks>
    80006ad0:	00072783          	lw	a5,0(a4)
    80006ad4:	0000a517          	auipc	a0,0xa
    80006ad8:	3bc50513          	addi	a0,a0,956 # 80010e90 <tickslock>
    80006adc:	0017879b          	addiw	a5,a5,1
    80006ae0:	00f72023          	sw	a5,0(a4)
    80006ae4:	00001097          	auipc	ra,0x1
    80006ae8:	534080e7          	jalr	1332(ra) # 80008018 <release>
    80006aec:	f65ff06f          	j	80006a50 <kerneltrap+0x8c>
    80006af0:	00001097          	auipc	ra,0x1
    80006af4:	090080e7          	jalr	144(ra) # 80007b80 <uartintr>
    80006af8:	fa5ff06f          	j	80006a9c <kerneltrap+0xd8>
    80006afc:	00003517          	auipc	a0,0x3
    80006b00:	b6450513          	addi	a0,a0,-1180 # 80009660 <CONSOLE_STATUS+0x650>
    80006b04:	00000097          	auipc	ra,0x0
    80006b08:	718080e7          	jalr	1816(ra) # 8000721c <panic>

0000000080006b0c <clockintr>:
    80006b0c:	fe010113          	addi	sp,sp,-32
    80006b10:	00813823          	sd	s0,16(sp)
    80006b14:	00913423          	sd	s1,8(sp)
    80006b18:	00113c23          	sd	ra,24(sp)
    80006b1c:	02010413          	addi	s0,sp,32
    80006b20:	0000a497          	auipc	s1,0xa
    80006b24:	37048493          	addi	s1,s1,880 # 80010e90 <tickslock>
    80006b28:	00048513          	mv	a0,s1
    80006b2c:	00001097          	auipc	ra,0x1
    80006b30:	420080e7          	jalr	1056(ra) # 80007f4c <acquire>
    80006b34:	00005717          	auipc	a4,0x5
    80006b38:	03070713          	addi	a4,a4,48 # 8000bb64 <ticks>
    80006b3c:	00072783          	lw	a5,0(a4)
    80006b40:	01013403          	ld	s0,16(sp)
    80006b44:	01813083          	ld	ra,24(sp)
    80006b48:	00048513          	mv	a0,s1
    80006b4c:	0017879b          	addiw	a5,a5,1
    80006b50:	00813483          	ld	s1,8(sp)
    80006b54:	00f72023          	sw	a5,0(a4)
    80006b58:	02010113          	addi	sp,sp,32
    80006b5c:	00001317          	auipc	t1,0x1
    80006b60:	4bc30067          	jr	1212(t1) # 80008018 <release>

0000000080006b64 <devintr>:
    80006b64:	142027f3          	csrr	a5,scause
    80006b68:	00000513          	li	a0,0
    80006b6c:	0007c463          	bltz	a5,80006b74 <devintr+0x10>
    80006b70:	00008067          	ret
    80006b74:	fe010113          	addi	sp,sp,-32
    80006b78:	00813823          	sd	s0,16(sp)
    80006b7c:	00113c23          	sd	ra,24(sp)
    80006b80:	00913423          	sd	s1,8(sp)
    80006b84:	02010413          	addi	s0,sp,32
    80006b88:	0ff7f713          	andi	a4,a5,255
    80006b8c:	00900693          	li	a3,9
    80006b90:	04d70c63          	beq	a4,a3,80006be8 <devintr+0x84>
    80006b94:	fff00713          	li	a4,-1
    80006b98:	03f71713          	slli	a4,a4,0x3f
    80006b9c:	00170713          	addi	a4,a4,1
    80006ba0:	00e78c63          	beq	a5,a4,80006bb8 <devintr+0x54>
    80006ba4:	01813083          	ld	ra,24(sp)
    80006ba8:	01013403          	ld	s0,16(sp)
    80006bac:	00813483          	ld	s1,8(sp)
    80006bb0:	02010113          	addi	sp,sp,32
    80006bb4:	00008067          	ret
    80006bb8:	00000097          	auipc	ra,0x0
    80006bbc:	c8c080e7          	jalr	-884(ra) # 80006844 <cpuid>
    80006bc0:	06050663          	beqz	a0,80006c2c <devintr+0xc8>
    80006bc4:	144027f3          	csrr	a5,sip
    80006bc8:	ffd7f793          	andi	a5,a5,-3
    80006bcc:	14479073          	csrw	sip,a5
    80006bd0:	01813083          	ld	ra,24(sp)
    80006bd4:	01013403          	ld	s0,16(sp)
    80006bd8:	00813483          	ld	s1,8(sp)
    80006bdc:	00200513          	li	a0,2
    80006be0:	02010113          	addi	sp,sp,32
    80006be4:	00008067          	ret
    80006be8:	00000097          	auipc	ra,0x0
    80006bec:	24c080e7          	jalr	588(ra) # 80006e34 <plic_claim>
    80006bf0:	00a00793          	li	a5,10
    80006bf4:	00050493          	mv	s1,a0
    80006bf8:	06f50663          	beq	a0,a5,80006c64 <devintr+0x100>
    80006bfc:	00100513          	li	a0,1
    80006c00:	fa0482e3          	beqz	s1,80006ba4 <devintr+0x40>
    80006c04:	00048593          	mv	a1,s1
    80006c08:	00003517          	auipc	a0,0x3
    80006c0c:	a7850513          	addi	a0,a0,-1416 # 80009680 <CONSOLE_STATUS+0x670>
    80006c10:	00000097          	auipc	ra,0x0
    80006c14:	668080e7          	jalr	1640(ra) # 80007278 <__printf>
    80006c18:	00048513          	mv	a0,s1
    80006c1c:	00000097          	auipc	ra,0x0
    80006c20:	250080e7          	jalr	592(ra) # 80006e6c <plic_complete>
    80006c24:	00100513          	li	a0,1
    80006c28:	f7dff06f          	j	80006ba4 <devintr+0x40>
    80006c2c:	0000a517          	auipc	a0,0xa
    80006c30:	26450513          	addi	a0,a0,612 # 80010e90 <tickslock>
    80006c34:	00001097          	auipc	ra,0x1
    80006c38:	318080e7          	jalr	792(ra) # 80007f4c <acquire>
    80006c3c:	00005717          	auipc	a4,0x5
    80006c40:	f2870713          	addi	a4,a4,-216 # 8000bb64 <ticks>
    80006c44:	00072783          	lw	a5,0(a4)
    80006c48:	0000a517          	auipc	a0,0xa
    80006c4c:	24850513          	addi	a0,a0,584 # 80010e90 <tickslock>
    80006c50:	0017879b          	addiw	a5,a5,1
    80006c54:	00f72023          	sw	a5,0(a4)
    80006c58:	00001097          	auipc	ra,0x1
    80006c5c:	3c0080e7          	jalr	960(ra) # 80008018 <release>
    80006c60:	f65ff06f          	j	80006bc4 <devintr+0x60>
    80006c64:	00001097          	auipc	ra,0x1
    80006c68:	f1c080e7          	jalr	-228(ra) # 80007b80 <uartintr>
    80006c6c:	fadff06f          	j	80006c18 <devintr+0xb4>

0000000080006c70 <kernelvec>:
    80006c70:	f0010113          	addi	sp,sp,-256
    80006c74:	00113023          	sd	ra,0(sp)
    80006c78:	00213423          	sd	sp,8(sp)
    80006c7c:	00313823          	sd	gp,16(sp)
    80006c80:	00413c23          	sd	tp,24(sp)
    80006c84:	02513023          	sd	t0,32(sp)
    80006c88:	02613423          	sd	t1,40(sp)
    80006c8c:	02713823          	sd	t2,48(sp)
    80006c90:	02813c23          	sd	s0,56(sp)
    80006c94:	04913023          	sd	s1,64(sp)
    80006c98:	04a13423          	sd	a0,72(sp)
    80006c9c:	04b13823          	sd	a1,80(sp)
    80006ca0:	04c13c23          	sd	a2,88(sp)
    80006ca4:	06d13023          	sd	a3,96(sp)
    80006ca8:	06e13423          	sd	a4,104(sp)
    80006cac:	06f13823          	sd	a5,112(sp)
    80006cb0:	07013c23          	sd	a6,120(sp)
    80006cb4:	09113023          	sd	a7,128(sp)
    80006cb8:	09213423          	sd	s2,136(sp)
    80006cbc:	09313823          	sd	s3,144(sp)
    80006cc0:	09413c23          	sd	s4,152(sp)
    80006cc4:	0b513023          	sd	s5,160(sp)
    80006cc8:	0b613423          	sd	s6,168(sp)
    80006ccc:	0b713823          	sd	s7,176(sp)
    80006cd0:	0b813c23          	sd	s8,184(sp)
    80006cd4:	0d913023          	sd	s9,192(sp)
    80006cd8:	0da13423          	sd	s10,200(sp)
    80006cdc:	0db13823          	sd	s11,208(sp)
    80006ce0:	0dc13c23          	sd	t3,216(sp)
    80006ce4:	0fd13023          	sd	t4,224(sp)
    80006ce8:	0fe13423          	sd	t5,232(sp)
    80006cec:	0ff13823          	sd	t6,240(sp)
    80006cf0:	cd5ff0ef          	jal	ra,800069c4 <kerneltrap>
    80006cf4:	00013083          	ld	ra,0(sp)
    80006cf8:	00813103          	ld	sp,8(sp)
    80006cfc:	01013183          	ld	gp,16(sp)
    80006d00:	02013283          	ld	t0,32(sp)
    80006d04:	02813303          	ld	t1,40(sp)
    80006d08:	03013383          	ld	t2,48(sp)
    80006d0c:	03813403          	ld	s0,56(sp)
    80006d10:	04013483          	ld	s1,64(sp)
    80006d14:	04813503          	ld	a0,72(sp)
    80006d18:	05013583          	ld	a1,80(sp)
    80006d1c:	05813603          	ld	a2,88(sp)
    80006d20:	06013683          	ld	a3,96(sp)
    80006d24:	06813703          	ld	a4,104(sp)
    80006d28:	07013783          	ld	a5,112(sp)
    80006d2c:	07813803          	ld	a6,120(sp)
    80006d30:	08013883          	ld	a7,128(sp)
    80006d34:	08813903          	ld	s2,136(sp)
    80006d38:	09013983          	ld	s3,144(sp)
    80006d3c:	09813a03          	ld	s4,152(sp)
    80006d40:	0a013a83          	ld	s5,160(sp)
    80006d44:	0a813b03          	ld	s6,168(sp)
    80006d48:	0b013b83          	ld	s7,176(sp)
    80006d4c:	0b813c03          	ld	s8,184(sp)
    80006d50:	0c013c83          	ld	s9,192(sp)
    80006d54:	0c813d03          	ld	s10,200(sp)
    80006d58:	0d013d83          	ld	s11,208(sp)
    80006d5c:	0d813e03          	ld	t3,216(sp)
    80006d60:	0e013e83          	ld	t4,224(sp)
    80006d64:	0e813f03          	ld	t5,232(sp)
    80006d68:	0f013f83          	ld	t6,240(sp)
    80006d6c:	10010113          	addi	sp,sp,256
    80006d70:	10200073          	sret
    80006d74:	00000013          	nop
    80006d78:	00000013          	nop
    80006d7c:	00000013          	nop

0000000080006d80 <timervec>:
    80006d80:	34051573          	csrrw	a0,mscratch,a0
    80006d84:	00b53023          	sd	a1,0(a0)
    80006d88:	00c53423          	sd	a2,8(a0)
    80006d8c:	00d53823          	sd	a3,16(a0)
    80006d90:	01853583          	ld	a1,24(a0)
    80006d94:	02053603          	ld	a2,32(a0)
    80006d98:	0005b683          	ld	a3,0(a1)
    80006d9c:	00c686b3          	add	a3,a3,a2
    80006da0:	00d5b023          	sd	a3,0(a1)
    80006da4:	00200593          	li	a1,2
    80006da8:	14459073          	csrw	sip,a1
    80006dac:	01053683          	ld	a3,16(a0)
    80006db0:	00853603          	ld	a2,8(a0)
    80006db4:	00053583          	ld	a1,0(a0)
    80006db8:	34051573          	csrrw	a0,mscratch,a0
    80006dbc:	30200073          	mret

0000000080006dc0 <plicinit>:
    80006dc0:	ff010113          	addi	sp,sp,-16
    80006dc4:	00813423          	sd	s0,8(sp)
    80006dc8:	01010413          	addi	s0,sp,16
    80006dcc:	00813403          	ld	s0,8(sp)
    80006dd0:	0c0007b7          	lui	a5,0xc000
    80006dd4:	00100713          	li	a4,1
    80006dd8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80006ddc:	00e7a223          	sw	a4,4(a5)
    80006de0:	01010113          	addi	sp,sp,16
    80006de4:	00008067          	ret

0000000080006de8 <plicinithart>:
    80006de8:	ff010113          	addi	sp,sp,-16
    80006dec:	00813023          	sd	s0,0(sp)
    80006df0:	00113423          	sd	ra,8(sp)
    80006df4:	01010413          	addi	s0,sp,16
    80006df8:	00000097          	auipc	ra,0x0
    80006dfc:	a4c080e7          	jalr	-1460(ra) # 80006844 <cpuid>
    80006e00:	0085171b          	slliw	a4,a0,0x8
    80006e04:	0c0027b7          	lui	a5,0xc002
    80006e08:	00e787b3          	add	a5,a5,a4
    80006e0c:	40200713          	li	a4,1026
    80006e10:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006e14:	00813083          	ld	ra,8(sp)
    80006e18:	00013403          	ld	s0,0(sp)
    80006e1c:	00d5151b          	slliw	a0,a0,0xd
    80006e20:	0c2017b7          	lui	a5,0xc201
    80006e24:	00a78533          	add	a0,a5,a0
    80006e28:	00052023          	sw	zero,0(a0)
    80006e2c:	01010113          	addi	sp,sp,16
    80006e30:	00008067          	ret

0000000080006e34 <plic_claim>:
    80006e34:	ff010113          	addi	sp,sp,-16
    80006e38:	00813023          	sd	s0,0(sp)
    80006e3c:	00113423          	sd	ra,8(sp)
    80006e40:	01010413          	addi	s0,sp,16
    80006e44:	00000097          	auipc	ra,0x0
    80006e48:	a00080e7          	jalr	-1536(ra) # 80006844 <cpuid>
    80006e4c:	00813083          	ld	ra,8(sp)
    80006e50:	00013403          	ld	s0,0(sp)
    80006e54:	00d5151b          	slliw	a0,a0,0xd
    80006e58:	0c2017b7          	lui	a5,0xc201
    80006e5c:	00a78533          	add	a0,a5,a0
    80006e60:	00452503          	lw	a0,4(a0)
    80006e64:	01010113          	addi	sp,sp,16
    80006e68:	00008067          	ret

0000000080006e6c <plic_complete>:
    80006e6c:	fe010113          	addi	sp,sp,-32
    80006e70:	00813823          	sd	s0,16(sp)
    80006e74:	00913423          	sd	s1,8(sp)
    80006e78:	00113c23          	sd	ra,24(sp)
    80006e7c:	02010413          	addi	s0,sp,32
    80006e80:	00050493          	mv	s1,a0
    80006e84:	00000097          	auipc	ra,0x0
    80006e88:	9c0080e7          	jalr	-1600(ra) # 80006844 <cpuid>
    80006e8c:	01813083          	ld	ra,24(sp)
    80006e90:	01013403          	ld	s0,16(sp)
    80006e94:	00d5179b          	slliw	a5,a0,0xd
    80006e98:	0c201737          	lui	a4,0xc201
    80006e9c:	00f707b3          	add	a5,a4,a5
    80006ea0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006ea4:	00813483          	ld	s1,8(sp)
    80006ea8:	02010113          	addi	sp,sp,32
    80006eac:	00008067          	ret

0000000080006eb0 <consolewrite>:
    80006eb0:	fb010113          	addi	sp,sp,-80
    80006eb4:	04813023          	sd	s0,64(sp)
    80006eb8:	04113423          	sd	ra,72(sp)
    80006ebc:	02913c23          	sd	s1,56(sp)
    80006ec0:	03213823          	sd	s2,48(sp)
    80006ec4:	03313423          	sd	s3,40(sp)
    80006ec8:	03413023          	sd	s4,32(sp)
    80006ecc:	01513c23          	sd	s5,24(sp)
    80006ed0:	05010413          	addi	s0,sp,80
    80006ed4:	06c05c63          	blez	a2,80006f4c <consolewrite+0x9c>
    80006ed8:	00060993          	mv	s3,a2
    80006edc:	00050a13          	mv	s4,a0
    80006ee0:	00058493          	mv	s1,a1
    80006ee4:	00000913          	li	s2,0
    80006ee8:	fff00a93          	li	s5,-1
    80006eec:	01c0006f          	j	80006f08 <consolewrite+0x58>
    80006ef0:	fbf44503          	lbu	a0,-65(s0)
    80006ef4:	0019091b          	addiw	s2,s2,1
    80006ef8:	00148493          	addi	s1,s1,1
    80006efc:	00001097          	auipc	ra,0x1
    80006f00:	a9c080e7          	jalr	-1380(ra) # 80007998 <uartputc>
    80006f04:	03298063          	beq	s3,s2,80006f24 <consolewrite+0x74>
    80006f08:	00048613          	mv	a2,s1
    80006f0c:	00100693          	li	a3,1
    80006f10:	000a0593          	mv	a1,s4
    80006f14:	fbf40513          	addi	a0,s0,-65
    80006f18:	00000097          	auipc	ra,0x0
    80006f1c:	9e4080e7          	jalr	-1564(ra) # 800068fc <either_copyin>
    80006f20:	fd5518e3          	bne	a0,s5,80006ef0 <consolewrite+0x40>
    80006f24:	04813083          	ld	ra,72(sp)
    80006f28:	04013403          	ld	s0,64(sp)
    80006f2c:	03813483          	ld	s1,56(sp)
    80006f30:	02813983          	ld	s3,40(sp)
    80006f34:	02013a03          	ld	s4,32(sp)
    80006f38:	01813a83          	ld	s5,24(sp)
    80006f3c:	00090513          	mv	a0,s2
    80006f40:	03013903          	ld	s2,48(sp)
    80006f44:	05010113          	addi	sp,sp,80
    80006f48:	00008067          	ret
    80006f4c:	00000913          	li	s2,0
    80006f50:	fd5ff06f          	j	80006f24 <consolewrite+0x74>

0000000080006f54 <consoleread>:
    80006f54:	f9010113          	addi	sp,sp,-112
    80006f58:	06813023          	sd	s0,96(sp)
    80006f5c:	04913c23          	sd	s1,88(sp)
    80006f60:	05213823          	sd	s2,80(sp)
    80006f64:	05313423          	sd	s3,72(sp)
    80006f68:	05413023          	sd	s4,64(sp)
    80006f6c:	03513c23          	sd	s5,56(sp)
    80006f70:	03613823          	sd	s6,48(sp)
    80006f74:	03713423          	sd	s7,40(sp)
    80006f78:	03813023          	sd	s8,32(sp)
    80006f7c:	06113423          	sd	ra,104(sp)
    80006f80:	01913c23          	sd	s9,24(sp)
    80006f84:	07010413          	addi	s0,sp,112
    80006f88:	00060b93          	mv	s7,a2
    80006f8c:	00050913          	mv	s2,a0
    80006f90:	00058c13          	mv	s8,a1
    80006f94:	00060b1b          	sext.w	s6,a2
    80006f98:	0000a497          	auipc	s1,0xa
    80006f9c:	f2048493          	addi	s1,s1,-224 # 80010eb8 <cons>
    80006fa0:	00400993          	li	s3,4
    80006fa4:	fff00a13          	li	s4,-1
    80006fa8:	00a00a93          	li	s5,10
    80006fac:	05705e63          	blez	s7,80007008 <consoleread+0xb4>
    80006fb0:	09c4a703          	lw	a4,156(s1)
    80006fb4:	0984a783          	lw	a5,152(s1)
    80006fb8:	0007071b          	sext.w	a4,a4
    80006fbc:	08e78463          	beq	a5,a4,80007044 <consoleread+0xf0>
    80006fc0:	07f7f713          	andi	a4,a5,127
    80006fc4:	00e48733          	add	a4,s1,a4
    80006fc8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006fcc:	0017869b          	addiw	a3,a5,1
    80006fd0:	08d4ac23          	sw	a3,152(s1)
    80006fd4:	00070c9b          	sext.w	s9,a4
    80006fd8:	0b370663          	beq	a4,s3,80007084 <consoleread+0x130>
    80006fdc:	00100693          	li	a3,1
    80006fe0:	f9f40613          	addi	a2,s0,-97
    80006fe4:	000c0593          	mv	a1,s8
    80006fe8:	00090513          	mv	a0,s2
    80006fec:	f8e40fa3          	sb	a4,-97(s0)
    80006ff0:	00000097          	auipc	ra,0x0
    80006ff4:	8c0080e7          	jalr	-1856(ra) # 800068b0 <either_copyout>
    80006ff8:	01450863          	beq	a0,s4,80007008 <consoleread+0xb4>
    80006ffc:	001c0c13          	addi	s8,s8,1
    80007000:	fffb8b9b          	addiw	s7,s7,-1
    80007004:	fb5c94e3          	bne	s9,s5,80006fac <consoleread+0x58>
    80007008:	000b851b          	sext.w	a0,s7
    8000700c:	06813083          	ld	ra,104(sp)
    80007010:	06013403          	ld	s0,96(sp)
    80007014:	05813483          	ld	s1,88(sp)
    80007018:	05013903          	ld	s2,80(sp)
    8000701c:	04813983          	ld	s3,72(sp)
    80007020:	04013a03          	ld	s4,64(sp)
    80007024:	03813a83          	ld	s5,56(sp)
    80007028:	02813b83          	ld	s7,40(sp)
    8000702c:	02013c03          	ld	s8,32(sp)
    80007030:	01813c83          	ld	s9,24(sp)
    80007034:	40ab053b          	subw	a0,s6,a0
    80007038:	03013b03          	ld	s6,48(sp)
    8000703c:	07010113          	addi	sp,sp,112
    80007040:	00008067          	ret
    80007044:	00001097          	auipc	ra,0x1
    80007048:	1d8080e7          	jalr	472(ra) # 8000821c <push_on>
    8000704c:	0984a703          	lw	a4,152(s1)
    80007050:	09c4a783          	lw	a5,156(s1)
    80007054:	0007879b          	sext.w	a5,a5
    80007058:	fef70ce3          	beq	a4,a5,80007050 <consoleread+0xfc>
    8000705c:	00001097          	auipc	ra,0x1
    80007060:	234080e7          	jalr	564(ra) # 80008290 <pop_on>
    80007064:	0984a783          	lw	a5,152(s1)
    80007068:	07f7f713          	andi	a4,a5,127
    8000706c:	00e48733          	add	a4,s1,a4
    80007070:	01874703          	lbu	a4,24(a4)
    80007074:	0017869b          	addiw	a3,a5,1
    80007078:	08d4ac23          	sw	a3,152(s1)
    8000707c:	00070c9b          	sext.w	s9,a4
    80007080:	f5371ee3          	bne	a4,s3,80006fdc <consoleread+0x88>
    80007084:	000b851b          	sext.w	a0,s7
    80007088:	f96bf2e3          	bgeu	s7,s6,8000700c <consoleread+0xb8>
    8000708c:	08f4ac23          	sw	a5,152(s1)
    80007090:	f7dff06f          	j	8000700c <consoleread+0xb8>

0000000080007094 <consputc>:
    80007094:	10000793          	li	a5,256
    80007098:	00f50663          	beq	a0,a5,800070a4 <consputc+0x10>
    8000709c:	00001317          	auipc	t1,0x1
    800070a0:	9f430067          	jr	-1548(t1) # 80007a90 <uartputc_sync>
    800070a4:	ff010113          	addi	sp,sp,-16
    800070a8:	00113423          	sd	ra,8(sp)
    800070ac:	00813023          	sd	s0,0(sp)
    800070b0:	01010413          	addi	s0,sp,16
    800070b4:	00800513          	li	a0,8
    800070b8:	00001097          	auipc	ra,0x1
    800070bc:	9d8080e7          	jalr	-1576(ra) # 80007a90 <uartputc_sync>
    800070c0:	02000513          	li	a0,32
    800070c4:	00001097          	auipc	ra,0x1
    800070c8:	9cc080e7          	jalr	-1588(ra) # 80007a90 <uartputc_sync>
    800070cc:	00013403          	ld	s0,0(sp)
    800070d0:	00813083          	ld	ra,8(sp)
    800070d4:	00800513          	li	a0,8
    800070d8:	01010113          	addi	sp,sp,16
    800070dc:	00001317          	auipc	t1,0x1
    800070e0:	9b430067          	jr	-1612(t1) # 80007a90 <uartputc_sync>

00000000800070e4 <consoleintr>:
    800070e4:	fe010113          	addi	sp,sp,-32
    800070e8:	00813823          	sd	s0,16(sp)
    800070ec:	00913423          	sd	s1,8(sp)
    800070f0:	01213023          	sd	s2,0(sp)
    800070f4:	00113c23          	sd	ra,24(sp)
    800070f8:	02010413          	addi	s0,sp,32
    800070fc:	0000a917          	auipc	s2,0xa
    80007100:	dbc90913          	addi	s2,s2,-580 # 80010eb8 <cons>
    80007104:	00050493          	mv	s1,a0
    80007108:	00090513          	mv	a0,s2
    8000710c:	00001097          	auipc	ra,0x1
    80007110:	e40080e7          	jalr	-448(ra) # 80007f4c <acquire>
    80007114:	02048c63          	beqz	s1,8000714c <consoleintr+0x68>
    80007118:	0a092783          	lw	a5,160(s2)
    8000711c:	09892703          	lw	a4,152(s2)
    80007120:	07f00693          	li	a3,127
    80007124:	40e7873b          	subw	a4,a5,a4
    80007128:	02e6e263          	bltu	a3,a4,8000714c <consoleintr+0x68>
    8000712c:	00d00713          	li	a4,13
    80007130:	04e48063          	beq	s1,a4,80007170 <consoleintr+0x8c>
    80007134:	07f7f713          	andi	a4,a5,127
    80007138:	00e90733          	add	a4,s2,a4
    8000713c:	0017879b          	addiw	a5,a5,1
    80007140:	0af92023          	sw	a5,160(s2)
    80007144:	00970c23          	sb	s1,24(a4)
    80007148:	08f92e23          	sw	a5,156(s2)
    8000714c:	01013403          	ld	s0,16(sp)
    80007150:	01813083          	ld	ra,24(sp)
    80007154:	00813483          	ld	s1,8(sp)
    80007158:	00013903          	ld	s2,0(sp)
    8000715c:	0000a517          	auipc	a0,0xa
    80007160:	d5c50513          	addi	a0,a0,-676 # 80010eb8 <cons>
    80007164:	02010113          	addi	sp,sp,32
    80007168:	00001317          	auipc	t1,0x1
    8000716c:	eb030067          	jr	-336(t1) # 80008018 <release>
    80007170:	00a00493          	li	s1,10
    80007174:	fc1ff06f          	j	80007134 <consoleintr+0x50>

0000000080007178 <consoleinit>:
    80007178:	fe010113          	addi	sp,sp,-32
    8000717c:	00113c23          	sd	ra,24(sp)
    80007180:	00813823          	sd	s0,16(sp)
    80007184:	00913423          	sd	s1,8(sp)
    80007188:	02010413          	addi	s0,sp,32
    8000718c:	0000a497          	auipc	s1,0xa
    80007190:	d2c48493          	addi	s1,s1,-724 # 80010eb8 <cons>
    80007194:	00048513          	mv	a0,s1
    80007198:	00002597          	auipc	a1,0x2
    8000719c:	54058593          	addi	a1,a1,1344 # 800096d8 <CONSOLE_STATUS+0x6c8>
    800071a0:	00001097          	auipc	ra,0x1
    800071a4:	d88080e7          	jalr	-632(ra) # 80007f28 <initlock>
    800071a8:	00000097          	auipc	ra,0x0
    800071ac:	7ac080e7          	jalr	1964(ra) # 80007954 <uartinit>
    800071b0:	01813083          	ld	ra,24(sp)
    800071b4:	01013403          	ld	s0,16(sp)
    800071b8:	00000797          	auipc	a5,0x0
    800071bc:	d9c78793          	addi	a5,a5,-612 # 80006f54 <consoleread>
    800071c0:	0af4bc23          	sd	a5,184(s1)
    800071c4:	00000797          	auipc	a5,0x0
    800071c8:	cec78793          	addi	a5,a5,-788 # 80006eb0 <consolewrite>
    800071cc:	0cf4b023          	sd	a5,192(s1)
    800071d0:	00813483          	ld	s1,8(sp)
    800071d4:	02010113          	addi	sp,sp,32
    800071d8:	00008067          	ret

00000000800071dc <console_read>:
    800071dc:	ff010113          	addi	sp,sp,-16
    800071e0:	00813423          	sd	s0,8(sp)
    800071e4:	01010413          	addi	s0,sp,16
    800071e8:	00813403          	ld	s0,8(sp)
    800071ec:	0000a317          	auipc	t1,0xa
    800071f0:	d8433303          	ld	t1,-636(t1) # 80010f70 <devsw+0x10>
    800071f4:	01010113          	addi	sp,sp,16
    800071f8:	00030067          	jr	t1

00000000800071fc <console_write>:
    800071fc:	ff010113          	addi	sp,sp,-16
    80007200:	00813423          	sd	s0,8(sp)
    80007204:	01010413          	addi	s0,sp,16
    80007208:	00813403          	ld	s0,8(sp)
    8000720c:	0000a317          	auipc	t1,0xa
    80007210:	d6c33303          	ld	t1,-660(t1) # 80010f78 <devsw+0x18>
    80007214:	01010113          	addi	sp,sp,16
    80007218:	00030067          	jr	t1

000000008000721c <panic>:
    8000721c:	fe010113          	addi	sp,sp,-32
    80007220:	00113c23          	sd	ra,24(sp)
    80007224:	00813823          	sd	s0,16(sp)
    80007228:	00913423          	sd	s1,8(sp)
    8000722c:	02010413          	addi	s0,sp,32
    80007230:	00050493          	mv	s1,a0
    80007234:	00002517          	auipc	a0,0x2
    80007238:	4ac50513          	addi	a0,a0,1196 # 800096e0 <CONSOLE_STATUS+0x6d0>
    8000723c:	0000a797          	auipc	a5,0xa
    80007240:	dc07ae23          	sw	zero,-548(a5) # 80011018 <pr+0x18>
    80007244:	00000097          	auipc	ra,0x0
    80007248:	034080e7          	jalr	52(ra) # 80007278 <__printf>
    8000724c:	00048513          	mv	a0,s1
    80007250:	00000097          	auipc	ra,0x0
    80007254:	028080e7          	jalr	40(ra) # 80007278 <__printf>
    80007258:	00002517          	auipc	a0,0x2
    8000725c:	f4850513          	addi	a0,a0,-184 # 800091a0 <CONSOLE_STATUS+0x190>
    80007260:	00000097          	auipc	ra,0x0
    80007264:	018080e7          	jalr	24(ra) # 80007278 <__printf>
    80007268:	00100793          	li	a5,1
    8000726c:	00005717          	auipc	a4,0x5
    80007270:	8ef72e23          	sw	a5,-1796(a4) # 8000bb68 <panicked>
    80007274:	0000006f          	j	80007274 <panic+0x58>

0000000080007278 <__printf>:
    80007278:	f3010113          	addi	sp,sp,-208
    8000727c:	08813023          	sd	s0,128(sp)
    80007280:	07313423          	sd	s3,104(sp)
    80007284:	09010413          	addi	s0,sp,144
    80007288:	05813023          	sd	s8,64(sp)
    8000728c:	08113423          	sd	ra,136(sp)
    80007290:	06913c23          	sd	s1,120(sp)
    80007294:	07213823          	sd	s2,112(sp)
    80007298:	07413023          	sd	s4,96(sp)
    8000729c:	05513c23          	sd	s5,88(sp)
    800072a0:	05613823          	sd	s6,80(sp)
    800072a4:	05713423          	sd	s7,72(sp)
    800072a8:	03913c23          	sd	s9,56(sp)
    800072ac:	03a13823          	sd	s10,48(sp)
    800072b0:	03b13423          	sd	s11,40(sp)
    800072b4:	0000a317          	auipc	t1,0xa
    800072b8:	d4c30313          	addi	t1,t1,-692 # 80011000 <pr>
    800072bc:	01832c03          	lw	s8,24(t1)
    800072c0:	00b43423          	sd	a1,8(s0)
    800072c4:	00c43823          	sd	a2,16(s0)
    800072c8:	00d43c23          	sd	a3,24(s0)
    800072cc:	02e43023          	sd	a4,32(s0)
    800072d0:	02f43423          	sd	a5,40(s0)
    800072d4:	03043823          	sd	a6,48(s0)
    800072d8:	03143c23          	sd	a7,56(s0)
    800072dc:	00050993          	mv	s3,a0
    800072e0:	4a0c1663          	bnez	s8,8000778c <__printf+0x514>
    800072e4:	60098c63          	beqz	s3,800078fc <__printf+0x684>
    800072e8:	0009c503          	lbu	a0,0(s3)
    800072ec:	00840793          	addi	a5,s0,8
    800072f0:	f6f43c23          	sd	a5,-136(s0)
    800072f4:	00000493          	li	s1,0
    800072f8:	22050063          	beqz	a0,80007518 <__printf+0x2a0>
    800072fc:	00002a37          	lui	s4,0x2
    80007300:	00018ab7          	lui	s5,0x18
    80007304:	000f4b37          	lui	s6,0xf4
    80007308:	00989bb7          	lui	s7,0x989
    8000730c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007310:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007314:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007318:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000731c:	00148c9b          	addiw	s9,s1,1
    80007320:	02500793          	li	a5,37
    80007324:	01998933          	add	s2,s3,s9
    80007328:	38f51263          	bne	a0,a5,800076ac <__printf+0x434>
    8000732c:	00094783          	lbu	a5,0(s2)
    80007330:	00078c9b          	sext.w	s9,a5
    80007334:	1e078263          	beqz	a5,80007518 <__printf+0x2a0>
    80007338:	0024849b          	addiw	s1,s1,2
    8000733c:	07000713          	li	a4,112
    80007340:	00998933          	add	s2,s3,s1
    80007344:	38e78a63          	beq	a5,a4,800076d8 <__printf+0x460>
    80007348:	20f76863          	bltu	a4,a5,80007558 <__printf+0x2e0>
    8000734c:	42a78863          	beq	a5,a0,8000777c <__printf+0x504>
    80007350:	06400713          	li	a4,100
    80007354:	40e79663          	bne	a5,a4,80007760 <__printf+0x4e8>
    80007358:	f7843783          	ld	a5,-136(s0)
    8000735c:	0007a603          	lw	a2,0(a5)
    80007360:	00878793          	addi	a5,a5,8
    80007364:	f6f43c23          	sd	a5,-136(s0)
    80007368:	42064a63          	bltz	a2,8000779c <__printf+0x524>
    8000736c:	00a00713          	li	a4,10
    80007370:	02e677bb          	remuw	a5,a2,a4
    80007374:	00002d97          	auipc	s11,0x2
    80007378:	394d8d93          	addi	s11,s11,916 # 80009708 <digits>
    8000737c:	00900593          	li	a1,9
    80007380:	0006051b          	sext.w	a0,a2
    80007384:	00000c93          	li	s9,0
    80007388:	02079793          	slli	a5,a5,0x20
    8000738c:	0207d793          	srli	a5,a5,0x20
    80007390:	00fd87b3          	add	a5,s11,a5
    80007394:	0007c783          	lbu	a5,0(a5)
    80007398:	02e656bb          	divuw	a3,a2,a4
    8000739c:	f8f40023          	sb	a5,-128(s0)
    800073a0:	14c5d863          	bge	a1,a2,800074f0 <__printf+0x278>
    800073a4:	06300593          	li	a1,99
    800073a8:	00100c93          	li	s9,1
    800073ac:	02e6f7bb          	remuw	a5,a3,a4
    800073b0:	02079793          	slli	a5,a5,0x20
    800073b4:	0207d793          	srli	a5,a5,0x20
    800073b8:	00fd87b3          	add	a5,s11,a5
    800073bc:	0007c783          	lbu	a5,0(a5)
    800073c0:	02e6d73b          	divuw	a4,a3,a4
    800073c4:	f8f400a3          	sb	a5,-127(s0)
    800073c8:	12a5f463          	bgeu	a1,a0,800074f0 <__printf+0x278>
    800073cc:	00a00693          	li	a3,10
    800073d0:	00900593          	li	a1,9
    800073d4:	02d777bb          	remuw	a5,a4,a3
    800073d8:	02079793          	slli	a5,a5,0x20
    800073dc:	0207d793          	srli	a5,a5,0x20
    800073e0:	00fd87b3          	add	a5,s11,a5
    800073e4:	0007c503          	lbu	a0,0(a5)
    800073e8:	02d757bb          	divuw	a5,a4,a3
    800073ec:	f8a40123          	sb	a0,-126(s0)
    800073f0:	48e5f263          	bgeu	a1,a4,80007874 <__printf+0x5fc>
    800073f4:	06300513          	li	a0,99
    800073f8:	02d7f5bb          	remuw	a1,a5,a3
    800073fc:	02059593          	slli	a1,a1,0x20
    80007400:	0205d593          	srli	a1,a1,0x20
    80007404:	00bd85b3          	add	a1,s11,a1
    80007408:	0005c583          	lbu	a1,0(a1)
    8000740c:	02d7d7bb          	divuw	a5,a5,a3
    80007410:	f8b401a3          	sb	a1,-125(s0)
    80007414:	48e57263          	bgeu	a0,a4,80007898 <__printf+0x620>
    80007418:	3e700513          	li	a0,999
    8000741c:	02d7f5bb          	remuw	a1,a5,a3
    80007420:	02059593          	slli	a1,a1,0x20
    80007424:	0205d593          	srli	a1,a1,0x20
    80007428:	00bd85b3          	add	a1,s11,a1
    8000742c:	0005c583          	lbu	a1,0(a1)
    80007430:	02d7d7bb          	divuw	a5,a5,a3
    80007434:	f8b40223          	sb	a1,-124(s0)
    80007438:	46e57663          	bgeu	a0,a4,800078a4 <__printf+0x62c>
    8000743c:	02d7f5bb          	remuw	a1,a5,a3
    80007440:	02059593          	slli	a1,a1,0x20
    80007444:	0205d593          	srli	a1,a1,0x20
    80007448:	00bd85b3          	add	a1,s11,a1
    8000744c:	0005c583          	lbu	a1,0(a1)
    80007450:	02d7d7bb          	divuw	a5,a5,a3
    80007454:	f8b402a3          	sb	a1,-123(s0)
    80007458:	46ea7863          	bgeu	s4,a4,800078c8 <__printf+0x650>
    8000745c:	02d7f5bb          	remuw	a1,a5,a3
    80007460:	02059593          	slli	a1,a1,0x20
    80007464:	0205d593          	srli	a1,a1,0x20
    80007468:	00bd85b3          	add	a1,s11,a1
    8000746c:	0005c583          	lbu	a1,0(a1)
    80007470:	02d7d7bb          	divuw	a5,a5,a3
    80007474:	f8b40323          	sb	a1,-122(s0)
    80007478:	3eeaf863          	bgeu	s5,a4,80007868 <__printf+0x5f0>
    8000747c:	02d7f5bb          	remuw	a1,a5,a3
    80007480:	02059593          	slli	a1,a1,0x20
    80007484:	0205d593          	srli	a1,a1,0x20
    80007488:	00bd85b3          	add	a1,s11,a1
    8000748c:	0005c583          	lbu	a1,0(a1)
    80007490:	02d7d7bb          	divuw	a5,a5,a3
    80007494:	f8b403a3          	sb	a1,-121(s0)
    80007498:	42eb7e63          	bgeu	s6,a4,800078d4 <__printf+0x65c>
    8000749c:	02d7f5bb          	remuw	a1,a5,a3
    800074a0:	02059593          	slli	a1,a1,0x20
    800074a4:	0205d593          	srli	a1,a1,0x20
    800074a8:	00bd85b3          	add	a1,s11,a1
    800074ac:	0005c583          	lbu	a1,0(a1)
    800074b0:	02d7d7bb          	divuw	a5,a5,a3
    800074b4:	f8b40423          	sb	a1,-120(s0)
    800074b8:	42ebfc63          	bgeu	s7,a4,800078f0 <__printf+0x678>
    800074bc:	02079793          	slli	a5,a5,0x20
    800074c0:	0207d793          	srli	a5,a5,0x20
    800074c4:	00fd8db3          	add	s11,s11,a5
    800074c8:	000dc703          	lbu	a4,0(s11)
    800074cc:	00a00793          	li	a5,10
    800074d0:	00900c93          	li	s9,9
    800074d4:	f8e404a3          	sb	a4,-119(s0)
    800074d8:	00065c63          	bgez	a2,800074f0 <__printf+0x278>
    800074dc:	f9040713          	addi	a4,s0,-112
    800074e0:	00f70733          	add	a4,a4,a5
    800074e4:	02d00693          	li	a3,45
    800074e8:	fed70823          	sb	a3,-16(a4)
    800074ec:	00078c93          	mv	s9,a5
    800074f0:	f8040793          	addi	a5,s0,-128
    800074f4:	01978cb3          	add	s9,a5,s9
    800074f8:	f7f40d13          	addi	s10,s0,-129
    800074fc:	000cc503          	lbu	a0,0(s9)
    80007500:	fffc8c93          	addi	s9,s9,-1
    80007504:	00000097          	auipc	ra,0x0
    80007508:	b90080e7          	jalr	-1136(ra) # 80007094 <consputc>
    8000750c:	ffac98e3          	bne	s9,s10,800074fc <__printf+0x284>
    80007510:	00094503          	lbu	a0,0(s2)
    80007514:	e00514e3          	bnez	a0,8000731c <__printf+0xa4>
    80007518:	1a0c1663          	bnez	s8,800076c4 <__printf+0x44c>
    8000751c:	08813083          	ld	ra,136(sp)
    80007520:	08013403          	ld	s0,128(sp)
    80007524:	07813483          	ld	s1,120(sp)
    80007528:	07013903          	ld	s2,112(sp)
    8000752c:	06813983          	ld	s3,104(sp)
    80007530:	06013a03          	ld	s4,96(sp)
    80007534:	05813a83          	ld	s5,88(sp)
    80007538:	05013b03          	ld	s6,80(sp)
    8000753c:	04813b83          	ld	s7,72(sp)
    80007540:	04013c03          	ld	s8,64(sp)
    80007544:	03813c83          	ld	s9,56(sp)
    80007548:	03013d03          	ld	s10,48(sp)
    8000754c:	02813d83          	ld	s11,40(sp)
    80007550:	0d010113          	addi	sp,sp,208
    80007554:	00008067          	ret
    80007558:	07300713          	li	a4,115
    8000755c:	1ce78a63          	beq	a5,a4,80007730 <__printf+0x4b8>
    80007560:	07800713          	li	a4,120
    80007564:	1ee79e63          	bne	a5,a4,80007760 <__printf+0x4e8>
    80007568:	f7843783          	ld	a5,-136(s0)
    8000756c:	0007a703          	lw	a4,0(a5)
    80007570:	00878793          	addi	a5,a5,8
    80007574:	f6f43c23          	sd	a5,-136(s0)
    80007578:	28074263          	bltz	a4,800077fc <__printf+0x584>
    8000757c:	00002d97          	auipc	s11,0x2
    80007580:	18cd8d93          	addi	s11,s11,396 # 80009708 <digits>
    80007584:	00f77793          	andi	a5,a4,15
    80007588:	00fd87b3          	add	a5,s11,a5
    8000758c:	0007c683          	lbu	a3,0(a5)
    80007590:	00f00613          	li	a2,15
    80007594:	0007079b          	sext.w	a5,a4
    80007598:	f8d40023          	sb	a3,-128(s0)
    8000759c:	0047559b          	srliw	a1,a4,0x4
    800075a0:	0047569b          	srliw	a3,a4,0x4
    800075a4:	00000c93          	li	s9,0
    800075a8:	0ee65063          	bge	a2,a4,80007688 <__printf+0x410>
    800075ac:	00f6f693          	andi	a3,a3,15
    800075b0:	00dd86b3          	add	a3,s11,a3
    800075b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800075b8:	0087d79b          	srliw	a5,a5,0x8
    800075bc:	00100c93          	li	s9,1
    800075c0:	f8d400a3          	sb	a3,-127(s0)
    800075c4:	0cb67263          	bgeu	a2,a1,80007688 <__printf+0x410>
    800075c8:	00f7f693          	andi	a3,a5,15
    800075cc:	00dd86b3          	add	a3,s11,a3
    800075d0:	0006c583          	lbu	a1,0(a3)
    800075d4:	00f00613          	li	a2,15
    800075d8:	0047d69b          	srliw	a3,a5,0x4
    800075dc:	f8b40123          	sb	a1,-126(s0)
    800075e0:	0047d593          	srli	a1,a5,0x4
    800075e4:	28f67e63          	bgeu	a2,a5,80007880 <__printf+0x608>
    800075e8:	00f6f693          	andi	a3,a3,15
    800075ec:	00dd86b3          	add	a3,s11,a3
    800075f0:	0006c503          	lbu	a0,0(a3)
    800075f4:	0087d813          	srli	a6,a5,0x8
    800075f8:	0087d69b          	srliw	a3,a5,0x8
    800075fc:	f8a401a3          	sb	a0,-125(s0)
    80007600:	28b67663          	bgeu	a2,a1,8000788c <__printf+0x614>
    80007604:	00f6f693          	andi	a3,a3,15
    80007608:	00dd86b3          	add	a3,s11,a3
    8000760c:	0006c583          	lbu	a1,0(a3)
    80007610:	00c7d513          	srli	a0,a5,0xc
    80007614:	00c7d69b          	srliw	a3,a5,0xc
    80007618:	f8b40223          	sb	a1,-124(s0)
    8000761c:	29067a63          	bgeu	a2,a6,800078b0 <__printf+0x638>
    80007620:	00f6f693          	andi	a3,a3,15
    80007624:	00dd86b3          	add	a3,s11,a3
    80007628:	0006c583          	lbu	a1,0(a3)
    8000762c:	0107d813          	srli	a6,a5,0x10
    80007630:	0107d69b          	srliw	a3,a5,0x10
    80007634:	f8b402a3          	sb	a1,-123(s0)
    80007638:	28a67263          	bgeu	a2,a0,800078bc <__printf+0x644>
    8000763c:	00f6f693          	andi	a3,a3,15
    80007640:	00dd86b3          	add	a3,s11,a3
    80007644:	0006c683          	lbu	a3,0(a3)
    80007648:	0147d79b          	srliw	a5,a5,0x14
    8000764c:	f8d40323          	sb	a3,-122(s0)
    80007650:	21067663          	bgeu	a2,a6,8000785c <__printf+0x5e4>
    80007654:	02079793          	slli	a5,a5,0x20
    80007658:	0207d793          	srli	a5,a5,0x20
    8000765c:	00fd8db3          	add	s11,s11,a5
    80007660:	000dc683          	lbu	a3,0(s11)
    80007664:	00800793          	li	a5,8
    80007668:	00700c93          	li	s9,7
    8000766c:	f8d403a3          	sb	a3,-121(s0)
    80007670:	00075c63          	bgez	a4,80007688 <__printf+0x410>
    80007674:	f9040713          	addi	a4,s0,-112
    80007678:	00f70733          	add	a4,a4,a5
    8000767c:	02d00693          	li	a3,45
    80007680:	fed70823          	sb	a3,-16(a4)
    80007684:	00078c93          	mv	s9,a5
    80007688:	f8040793          	addi	a5,s0,-128
    8000768c:	01978cb3          	add	s9,a5,s9
    80007690:	f7f40d13          	addi	s10,s0,-129
    80007694:	000cc503          	lbu	a0,0(s9)
    80007698:	fffc8c93          	addi	s9,s9,-1
    8000769c:	00000097          	auipc	ra,0x0
    800076a0:	9f8080e7          	jalr	-1544(ra) # 80007094 <consputc>
    800076a4:	ff9d18e3          	bne	s10,s9,80007694 <__printf+0x41c>
    800076a8:	0100006f          	j	800076b8 <__printf+0x440>
    800076ac:	00000097          	auipc	ra,0x0
    800076b0:	9e8080e7          	jalr	-1560(ra) # 80007094 <consputc>
    800076b4:	000c8493          	mv	s1,s9
    800076b8:	00094503          	lbu	a0,0(s2)
    800076bc:	c60510e3          	bnez	a0,8000731c <__printf+0xa4>
    800076c0:	e40c0ee3          	beqz	s8,8000751c <__printf+0x2a4>
    800076c4:	0000a517          	auipc	a0,0xa
    800076c8:	93c50513          	addi	a0,a0,-1732 # 80011000 <pr>
    800076cc:	00001097          	auipc	ra,0x1
    800076d0:	94c080e7          	jalr	-1716(ra) # 80008018 <release>
    800076d4:	e49ff06f          	j	8000751c <__printf+0x2a4>
    800076d8:	f7843783          	ld	a5,-136(s0)
    800076dc:	03000513          	li	a0,48
    800076e0:	01000d13          	li	s10,16
    800076e4:	00878713          	addi	a4,a5,8
    800076e8:	0007bc83          	ld	s9,0(a5)
    800076ec:	f6e43c23          	sd	a4,-136(s0)
    800076f0:	00000097          	auipc	ra,0x0
    800076f4:	9a4080e7          	jalr	-1628(ra) # 80007094 <consputc>
    800076f8:	07800513          	li	a0,120
    800076fc:	00000097          	auipc	ra,0x0
    80007700:	998080e7          	jalr	-1640(ra) # 80007094 <consputc>
    80007704:	00002d97          	auipc	s11,0x2
    80007708:	004d8d93          	addi	s11,s11,4 # 80009708 <digits>
    8000770c:	03ccd793          	srli	a5,s9,0x3c
    80007710:	00fd87b3          	add	a5,s11,a5
    80007714:	0007c503          	lbu	a0,0(a5)
    80007718:	fffd0d1b          	addiw	s10,s10,-1
    8000771c:	004c9c93          	slli	s9,s9,0x4
    80007720:	00000097          	auipc	ra,0x0
    80007724:	974080e7          	jalr	-1676(ra) # 80007094 <consputc>
    80007728:	fe0d12e3          	bnez	s10,8000770c <__printf+0x494>
    8000772c:	f8dff06f          	j	800076b8 <__printf+0x440>
    80007730:	f7843783          	ld	a5,-136(s0)
    80007734:	0007bc83          	ld	s9,0(a5)
    80007738:	00878793          	addi	a5,a5,8
    8000773c:	f6f43c23          	sd	a5,-136(s0)
    80007740:	000c9a63          	bnez	s9,80007754 <__printf+0x4dc>
    80007744:	1080006f          	j	8000784c <__printf+0x5d4>
    80007748:	001c8c93          	addi	s9,s9,1
    8000774c:	00000097          	auipc	ra,0x0
    80007750:	948080e7          	jalr	-1720(ra) # 80007094 <consputc>
    80007754:	000cc503          	lbu	a0,0(s9)
    80007758:	fe0518e3          	bnez	a0,80007748 <__printf+0x4d0>
    8000775c:	f5dff06f          	j	800076b8 <__printf+0x440>
    80007760:	02500513          	li	a0,37
    80007764:	00000097          	auipc	ra,0x0
    80007768:	930080e7          	jalr	-1744(ra) # 80007094 <consputc>
    8000776c:	000c8513          	mv	a0,s9
    80007770:	00000097          	auipc	ra,0x0
    80007774:	924080e7          	jalr	-1756(ra) # 80007094 <consputc>
    80007778:	f41ff06f          	j	800076b8 <__printf+0x440>
    8000777c:	02500513          	li	a0,37
    80007780:	00000097          	auipc	ra,0x0
    80007784:	914080e7          	jalr	-1772(ra) # 80007094 <consputc>
    80007788:	f31ff06f          	j	800076b8 <__printf+0x440>
    8000778c:	00030513          	mv	a0,t1
    80007790:	00000097          	auipc	ra,0x0
    80007794:	7bc080e7          	jalr	1980(ra) # 80007f4c <acquire>
    80007798:	b4dff06f          	j	800072e4 <__printf+0x6c>
    8000779c:	40c0053b          	negw	a0,a2
    800077a0:	00a00713          	li	a4,10
    800077a4:	02e576bb          	remuw	a3,a0,a4
    800077a8:	00002d97          	auipc	s11,0x2
    800077ac:	f60d8d93          	addi	s11,s11,-160 # 80009708 <digits>
    800077b0:	ff700593          	li	a1,-9
    800077b4:	02069693          	slli	a3,a3,0x20
    800077b8:	0206d693          	srli	a3,a3,0x20
    800077bc:	00dd86b3          	add	a3,s11,a3
    800077c0:	0006c683          	lbu	a3,0(a3)
    800077c4:	02e557bb          	divuw	a5,a0,a4
    800077c8:	f8d40023          	sb	a3,-128(s0)
    800077cc:	10b65e63          	bge	a2,a1,800078e8 <__printf+0x670>
    800077d0:	06300593          	li	a1,99
    800077d4:	02e7f6bb          	remuw	a3,a5,a4
    800077d8:	02069693          	slli	a3,a3,0x20
    800077dc:	0206d693          	srli	a3,a3,0x20
    800077e0:	00dd86b3          	add	a3,s11,a3
    800077e4:	0006c683          	lbu	a3,0(a3)
    800077e8:	02e7d73b          	divuw	a4,a5,a4
    800077ec:	00200793          	li	a5,2
    800077f0:	f8d400a3          	sb	a3,-127(s0)
    800077f4:	bca5ece3          	bltu	a1,a0,800073cc <__printf+0x154>
    800077f8:	ce5ff06f          	j	800074dc <__printf+0x264>
    800077fc:	40e007bb          	negw	a5,a4
    80007800:	00002d97          	auipc	s11,0x2
    80007804:	f08d8d93          	addi	s11,s11,-248 # 80009708 <digits>
    80007808:	00f7f693          	andi	a3,a5,15
    8000780c:	00dd86b3          	add	a3,s11,a3
    80007810:	0006c583          	lbu	a1,0(a3)
    80007814:	ff100613          	li	a2,-15
    80007818:	0047d69b          	srliw	a3,a5,0x4
    8000781c:	f8b40023          	sb	a1,-128(s0)
    80007820:	0047d59b          	srliw	a1,a5,0x4
    80007824:	0ac75e63          	bge	a4,a2,800078e0 <__printf+0x668>
    80007828:	00f6f693          	andi	a3,a3,15
    8000782c:	00dd86b3          	add	a3,s11,a3
    80007830:	0006c603          	lbu	a2,0(a3)
    80007834:	00f00693          	li	a3,15
    80007838:	0087d79b          	srliw	a5,a5,0x8
    8000783c:	f8c400a3          	sb	a2,-127(s0)
    80007840:	d8b6e4e3          	bltu	a3,a1,800075c8 <__printf+0x350>
    80007844:	00200793          	li	a5,2
    80007848:	e2dff06f          	j	80007674 <__printf+0x3fc>
    8000784c:	00002c97          	auipc	s9,0x2
    80007850:	e9cc8c93          	addi	s9,s9,-356 # 800096e8 <CONSOLE_STATUS+0x6d8>
    80007854:	02800513          	li	a0,40
    80007858:	ef1ff06f          	j	80007748 <__printf+0x4d0>
    8000785c:	00700793          	li	a5,7
    80007860:	00600c93          	li	s9,6
    80007864:	e0dff06f          	j	80007670 <__printf+0x3f8>
    80007868:	00700793          	li	a5,7
    8000786c:	00600c93          	li	s9,6
    80007870:	c69ff06f          	j	800074d8 <__printf+0x260>
    80007874:	00300793          	li	a5,3
    80007878:	00200c93          	li	s9,2
    8000787c:	c5dff06f          	j	800074d8 <__printf+0x260>
    80007880:	00300793          	li	a5,3
    80007884:	00200c93          	li	s9,2
    80007888:	de9ff06f          	j	80007670 <__printf+0x3f8>
    8000788c:	00400793          	li	a5,4
    80007890:	00300c93          	li	s9,3
    80007894:	dddff06f          	j	80007670 <__printf+0x3f8>
    80007898:	00400793          	li	a5,4
    8000789c:	00300c93          	li	s9,3
    800078a0:	c39ff06f          	j	800074d8 <__printf+0x260>
    800078a4:	00500793          	li	a5,5
    800078a8:	00400c93          	li	s9,4
    800078ac:	c2dff06f          	j	800074d8 <__printf+0x260>
    800078b0:	00500793          	li	a5,5
    800078b4:	00400c93          	li	s9,4
    800078b8:	db9ff06f          	j	80007670 <__printf+0x3f8>
    800078bc:	00600793          	li	a5,6
    800078c0:	00500c93          	li	s9,5
    800078c4:	dadff06f          	j	80007670 <__printf+0x3f8>
    800078c8:	00600793          	li	a5,6
    800078cc:	00500c93          	li	s9,5
    800078d0:	c09ff06f          	j	800074d8 <__printf+0x260>
    800078d4:	00800793          	li	a5,8
    800078d8:	00700c93          	li	s9,7
    800078dc:	bfdff06f          	j	800074d8 <__printf+0x260>
    800078e0:	00100793          	li	a5,1
    800078e4:	d91ff06f          	j	80007674 <__printf+0x3fc>
    800078e8:	00100793          	li	a5,1
    800078ec:	bf1ff06f          	j	800074dc <__printf+0x264>
    800078f0:	00900793          	li	a5,9
    800078f4:	00800c93          	li	s9,8
    800078f8:	be1ff06f          	j	800074d8 <__printf+0x260>
    800078fc:	00002517          	auipc	a0,0x2
    80007900:	df450513          	addi	a0,a0,-524 # 800096f0 <CONSOLE_STATUS+0x6e0>
    80007904:	00000097          	auipc	ra,0x0
    80007908:	918080e7          	jalr	-1768(ra) # 8000721c <panic>

000000008000790c <printfinit>:
    8000790c:	fe010113          	addi	sp,sp,-32
    80007910:	00813823          	sd	s0,16(sp)
    80007914:	00913423          	sd	s1,8(sp)
    80007918:	00113c23          	sd	ra,24(sp)
    8000791c:	02010413          	addi	s0,sp,32
    80007920:	00009497          	auipc	s1,0x9
    80007924:	6e048493          	addi	s1,s1,1760 # 80011000 <pr>
    80007928:	00048513          	mv	a0,s1
    8000792c:	00002597          	auipc	a1,0x2
    80007930:	dd458593          	addi	a1,a1,-556 # 80009700 <CONSOLE_STATUS+0x6f0>
    80007934:	00000097          	auipc	ra,0x0
    80007938:	5f4080e7          	jalr	1524(ra) # 80007f28 <initlock>
    8000793c:	01813083          	ld	ra,24(sp)
    80007940:	01013403          	ld	s0,16(sp)
    80007944:	0004ac23          	sw	zero,24(s1)
    80007948:	00813483          	ld	s1,8(sp)
    8000794c:	02010113          	addi	sp,sp,32
    80007950:	00008067          	ret

0000000080007954 <uartinit>:
    80007954:	ff010113          	addi	sp,sp,-16
    80007958:	00813423          	sd	s0,8(sp)
    8000795c:	01010413          	addi	s0,sp,16
    80007960:	100007b7          	lui	a5,0x10000
    80007964:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007968:	f8000713          	li	a4,-128
    8000796c:	00e781a3          	sb	a4,3(a5)
    80007970:	00300713          	li	a4,3
    80007974:	00e78023          	sb	a4,0(a5)
    80007978:	000780a3          	sb	zero,1(a5)
    8000797c:	00e781a3          	sb	a4,3(a5)
    80007980:	00700693          	li	a3,7
    80007984:	00d78123          	sb	a3,2(a5)
    80007988:	00e780a3          	sb	a4,1(a5)
    8000798c:	00813403          	ld	s0,8(sp)
    80007990:	01010113          	addi	sp,sp,16
    80007994:	00008067          	ret

0000000080007998 <uartputc>:
    80007998:	00004797          	auipc	a5,0x4
    8000799c:	1d07a783          	lw	a5,464(a5) # 8000bb68 <panicked>
    800079a0:	00078463          	beqz	a5,800079a8 <uartputc+0x10>
    800079a4:	0000006f          	j	800079a4 <uartputc+0xc>
    800079a8:	fd010113          	addi	sp,sp,-48
    800079ac:	02813023          	sd	s0,32(sp)
    800079b0:	00913c23          	sd	s1,24(sp)
    800079b4:	01213823          	sd	s2,16(sp)
    800079b8:	01313423          	sd	s3,8(sp)
    800079bc:	02113423          	sd	ra,40(sp)
    800079c0:	03010413          	addi	s0,sp,48
    800079c4:	00004917          	auipc	s2,0x4
    800079c8:	1ac90913          	addi	s2,s2,428 # 8000bb70 <uart_tx_r>
    800079cc:	00093783          	ld	a5,0(s2)
    800079d0:	00004497          	auipc	s1,0x4
    800079d4:	1a848493          	addi	s1,s1,424 # 8000bb78 <uart_tx_w>
    800079d8:	0004b703          	ld	a4,0(s1)
    800079dc:	02078693          	addi	a3,a5,32
    800079e0:	00050993          	mv	s3,a0
    800079e4:	02e69c63          	bne	a3,a4,80007a1c <uartputc+0x84>
    800079e8:	00001097          	auipc	ra,0x1
    800079ec:	834080e7          	jalr	-1996(ra) # 8000821c <push_on>
    800079f0:	00093783          	ld	a5,0(s2)
    800079f4:	0004b703          	ld	a4,0(s1)
    800079f8:	02078793          	addi	a5,a5,32
    800079fc:	00e79463          	bne	a5,a4,80007a04 <uartputc+0x6c>
    80007a00:	0000006f          	j	80007a00 <uartputc+0x68>
    80007a04:	00001097          	auipc	ra,0x1
    80007a08:	88c080e7          	jalr	-1908(ra) # 80008290 <pop_on>
    80007a0c:	00093783          	ld	a5,0(s2)
    80007a10:	0004b703          	ld	a4,0(s1)
    80007a14:	02078693          	addi	a3,a5,32
    80007a18:	fce688e3          	beq	a3,a4,800079e8 <uartputc+0x50>
    80007a1c:	01f77693          	andi	a3,a4,31
    80007a20:	00009597          	auipc	a1,0x9
    80007a24:	60058593          	addi	a1,a1,1536 # 80011020 <uart_tx_buf>
    80007a28:	00d586b3          	add	a3,a1,a3
    80007a2c:	00170713          	addi	a4,a4,1
    80007a30:	01368023          	sb	s3,0(a3)
    80007a34:	00e4b023          	sd	a4,0(s1)
    80007a38:	10000637          	lui	a2,0x10000
    80007a3c:	02f71063          	bne	a4,a5,80007a5c <uartputc+0xc4>
    80007a40:	0340006f          	j	80007a74 <uartputc+0xdc>
    80007a44:	00074703          	lbu	a4,0(a4)
    80007a48:	00f93023          	sd	a5,0(s2)
    80007a4c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007a50:	00093783          	ld	a5,0(s2)
    80007a54:	0004b703          	ld	a4,0(s1)
    80007a58:	00f70e63          	beq	a4,a5,80007a74 <uartputc+0xdc>
    80007a5c:	00564683          	lbu	a3,5(a2)
    80007a60:	01f7f713          	andi	a4,a5,31
    80007a64:	00e58733          	add	a4,a1,a4
    80007a68:	0206f693          	andi	a3,a3,32
    80007a6c:	00178793          	addi	a5,a5,1
    80007a70:	fc069ae3          	bnez	a3,80007a44 <uartputc+0xac>
    80007a74:	02813083          	ld	ra,40(sp)
    80007a78:	02013403          	ld	s0,32(sp)
    80007a7c:	01813483          	ld	s1,24(sp)
    80007a80:	01013903          	ld	s2,16(sp)
    80007a84:	00813983          	ld	s3,8(sp)
    80007a88:	03010113          	addi	sp,sp,48
    80007a8c:	00008067          	ret

0000000080007a90 <uartputc_sync>:
    80007a90:	ff010113          	addi	sp,sp,-16
    80007a94:	00813423          	sd	s0,8(sp)
    80007a98:	01010413          	addi	s0,sp,16
    80007a9c:	00004717          	auipc	a4,0x4
    80007aa0:	0cc72703          	lw	a4,204(a4) # 8000bb68 <panicked>
    80007aa4:	02071663          	bnez	a4,80007ad0 <uartputc_sync+0x40>
    80007aa8:	00050793          	mv	a5,a0
    80007aac:	100006b7          	lui	a3,0x10000
    80007ab0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007ab4:	02077713          	andi	a4,a4,32
    80007ab8:	fe070ce3          	beqz	a4,80007ab0 <uartputc_sync+0x20>
    80007abc:	0ff7f793          	andi	a5,a5,255
    80007ac0:	00f68023          	sb	a5,0(a3)
    80007ac4:	00813403          	ld	s0,8(sp)
    80007ac8:	01010113          	addi	sp,sp,16
    80007acc:	00008067          	ret
    80007ad0:	0000006f          	j	80007ad0 <uartputc_sync+0x40>

0000000080007ad4 <uartstart>:
    80007ad4:	ff010113          	addi	sp,sp,-16
    80007ad8:	00813423          	sd	s0,8(sp)
    80007adc:	01010413          	addi	s0,sp,16
    80007ae0:	00004617          	auipc	a2,0x4
    80007ae4:	09060613          	addi	a2,a2,144 # 8000bb70 <uart_tx_r>
    80007ae8:	00004517          	auipc	a0,0x4
    80007aec:	09050513          	addi	a0,a0,144 # 8000bb78 <uart_tx_w>
    80007af0:	00063783          	ld	a5,0(a2)
    80007af4:	00053703          	ld	a4,0(a0)
    80007af8:	04f70263          	beq	a4,a5,80007b3c <uartstart+0x68>
    80007afc:	100005b7          	lui	a1,0x10000
    80007b00:	00009817          	auipc	a6,0x9
    80007b04:	52080813          	addi	a6,a6,1312 # 80011020 <uart_tx_buf>
    80007b08:	01c0006f          	j	80007b24 <uartstart+0x50>
    80007b0c:	0006c703          	lbu	a4,0(a3)
    80007b10:	00f63023          	sd	a5,0(a2)
    80007b14:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007b18:	00063783          	ld	a5,0(a2)
    80007b1c:	00053703          	ld	a4,0(a0)
    80007b20:	00f70e63          	beq	a4,a5,80007b3c <uartstart+0x68>
    80007b24:	01f7f713          	andi	a4,a5,31
    80007b28:	00e806b3          	add	a3,a6,a4
    80007b2c:	0055c703          	lbu	a4,5(a1)
    80007b30:	00178793          	addi	a5,a5,1
    80007b34:	02077713          	andi	a4,a4,32
    80007b38:	fc071ae3          	bnez	a4,80007b0c <uartstart+0x38>
    80007b3c:	00813403          	ld	s0,8(sp)
    80007b40:	01010113          	addi	sp,sp,16
    80007b44:	00008067          	ret

0000000080007b48 <uartgetc>:
    80007b48:	ff010113          	addi	sp,sp,-16
    80007b4c:	00813423          	sd	s0,8(sp)
    80007b50:	01010413          	addi	s0,sp,16
    80007b54:	10000737          	lui	a4,0x10000
    80007b58:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007b5c:	0017f793          	andi	a5,a5,1
    80007b60:	00078c63          	beqz	a5,80007b78 <uartgetc+0x30>
    80007b64:	00074503          	lbu	a0,0(a4)
    80007b68:	0ff57513          	andi	a0,a0,255
    80007b6c:	00813403          	ld	s0,8(sp)
    80007b70:	01010113          	addi	sp,sp,16
    80007b74:	00008067          	ret
    80007b78:	fff00513          	li	a0,-1
    80007b7c:	ff1ff06f          	j	80007b6c <uartgetc+0x24>

0000000080007b80 <uartintr>:
    80007b80:	100007b7          	lui	a5,0x10000
    80007b84:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007b88:	0017f793          	andi	a5,a5,1
    80007b8c:	0a078463          	beqz	a5,80007c34 <uartintr+0xb4>
    80007b90:	fe010113          	addi	sp,sp,-32
    80007b94:	00813823          	sd	s0,16(sp)
    80007b98:	00913423          	sd	s1,8(sp)
    80007b9c:	00113c23          	sd	ra,24(sp)
    80007ba0:	02010413          	addi	s0,sp,32
    80007ba4:	100004b7          	lui	s1,0x10000
    80007ba8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80007bac:	0ff57513          	andi	a0,a0,255
    80007bb0:	fffff097          	auipc	ra,0xfffff
    80007bb4:	534080e7          	jalr	1332(ra) # 800070e4 <consoleintr>
    80007bb8:	0054c783          	lbu	a5,5(s1)
    80007bbc:	0017f793          	andi	a5,a5,1
    80007bc0:	fe0794e3          	bnez	a5,80007ba8 <uartintr+0x28>
    80007bc4:	00004617          	auipc	a2,0x4
    80007bc8:	fac60613          	addi	a2,a2,-84 # 8000bb70 <uart_tx_r>
    80007bcc:	00004517          	auipc	a0,0x4
    80007bd0:	fac50513          	addi	a0,a0,-84 # 8000bb78 <uart_tx_w>
    80007bd4:	00063783          	ld	a5,0(a2)
    80007bd8:	00053703          	ld	a4,0(a0)
    80007bdc:	04f70263          	beq	a4,a5,80007c20 <uartintr+0xa0>
    80007be0:	100005b7          	lui	a1,0x10000
    80007be4:	00009817          	auipc	a6,0x9
    80007be8:	43c80813          	addi	a6,a6,1084 # 80011020 <uart_tx_buf>
    80007bec:	01c0006f          	j	80007c08 <uartintr+0x88>
    80007bf0:	0006c703          	lbu	a4,0(a3)
    80007bf4:	00f63023          	sd	a5,0(a2)
    80007bf8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007bfc:	00063783          	ld	a5,0(a2)
    80007c00:	00053703          	ld	a4,0(a0)
    80007c04:	00f70e63          	beq	a4,a5,80007c20 <uartintr+0xa0>
    80007c08:	01f7f713          	andi	a4,a5,31
    80007c0c:	00e806b3          	add	a3,a6,a4
    80007c10:	0055c703          	lbu	a4,5(a1)
    80007c14:	00178793          	addi	a5,a5,1
    80007c18:	02077713          	andi	a4,a4,32
    80007c1c:	fc071ae3          	bnez	a4,80007bf0 <uartintr+0x70>
    80007c20:	01813083          	ld	ra,24(sp)
    80007c24:	01013403          	ld	s0,16(sp)
    80007c28:	00813483          	ld	s1,8(sp)
    80007c2c:	02010113          	addi	sp,sp,32
    80007c30:	00008067          	ret
    80007c34:	00004617          	auipc	a2,0x4
    80007c38:	f3c60613          	addi	a2,a2,-196 # 8000bb70 <uart_tx_r>
    80007c3c:	00004517          	auipc	a0,0x4
    80007c40:	f3c50513          	addi	a0,a0,-196 # 8000bb78 <uart_tx_w>
    80007c44:	00063783          	ld	a5,0(a2)
    80007c48:	00053703          	ld	a4,0(a0)
    80007c4c:	04f70263          	beq	a4,a5,80007c90 <uartintr+0x110>
    80007c50:	100005b7          	lui	a1,0x10000
    80007c54:	00009817          	auipc	a6,0x9
    80007c58:	3cc80813          	addi	a6,a6,972 # 80011020 <uart_tx_buf>
    80007c5c:	01c0006f          	j	80007c78 <uartintr+0xf8>
    80007c60:	0006c703          	lbu	a4,0(a3)
    80007c64:	00f63023          	sd	a5,0(a2)
    80007c68:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007c6c:	00063783          	ld	a5,0(a2)
    80007c70:	00053703          	ld	a4,0(a0)
    80007c74:	02f70063          	beq	a4,a5,80007c94 <uartintr+0x114>
    80007c78:	01f7f713          	andi	a4,a5,31
    80007c7c:	00e806b3          	add	a3,a6,a4
    80007c80:	0055c703          	lbu	a4,5(a1)
    80007c84:	00178793          	addi	a5,a5,1
    80007c88:	02077713          	andi	a4,a4,32
    80007c8c:	fc071ae3          	bnez	a4,80007c60 <uartintr+0xe0>
    80007c90:	00008067          	ret
    80007c94:	00008067          	ret

0000000080007c98 <kinit>:
    80007c98:	fc010113          	addi	sp,sp,-64
    80007c9c:	02913423          	sd	s1,40(sp)
    80007ca0:	fffff7b7          	lui	a5,0xfffff
    80007ca4:	0000a497          	auipc	s1,0xa
    80007ca8:	39b48493          	addi	s1,s1,923 # 8001203f <end+0xfff>
    80007cac:	02813823          	sd	s0,48(sp)
    80007cb0:	01313c23          	sd	s3,24(sp)
    80007cb4:	00f4f4b3          	and	s1,s1,a5
    80007cb8:	02113c23          	sd	ra,56(sp)
    80007cbc:	03213023          	sd	s2,32(sp)
    80007cc0:	01413823          	sd	s4,16(sp)
    80007cc4:	01513423          	sd	s5,8(sp)
    80007cc8:	04010413          	addi	s0,sp,64
    80007ccc:	000017b7          	lui	a5,0x1
    80007cd0:	01100993          	li	s3,17
    80007cd4:	00f487b3          	add	a5,s1,a5
    80007cd8:	01b99993          	slli	s3,s3,0x1b
    80007cdc:	06f9e063          	bltu	s3,a5,80007d3c <kinit+0xa4>
    80007ce0:	00009a97          	auipc	s5,0x9
    80007ce4:	360a8a93          	addi	s5,s5,864 # 80011040 <end>
    80007ce8:	0754ec63          	bltu	s1,s5,80007d60 <kinit+0xc8>
    80007cec:	0734fa63          	bgeu	s1,s3,80007d60 <kinit+0xc8>
    80007cf0:	00088a37          	lui	s4,0x88
    80007cf4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007cf8:	00004917          	auipc	s2,0x4
    80007cfc:	e8890913          	addi	s2,s2,-376 # 8000bb80 <kmem>
    80007d00:	00ca1a13          	slli	s4,s4,0xc
    80007d04:	0140006f          	j	80007d18 <kinit+0x80>
    80007d08:	000017b7          	lui	a5,0x1
    80007d0c:	00f484b3          	add	s1,s1,a5
    80007d10:	0554e863          	bltu	s1,s5,80007d60 <kinit+0xc8>
    80007d14:	0534f663          	bgeu	s1,s3,80007d60 <kinit+0xc8>
    80007d18:	00001637          	lui	a2,0x1
    80007d1c:	00100593          	li	a1,1
    80007d20:	00048513          	mv	a0,s1
    80007d24:	00000097          	auipc	ra,0x0
    80007d28:	5e4080e7          	jalr	1508(ra) # 80008308 <__memset>
    80007d2c:	00093783          	ld	a5,0(s2)
    80007d30:	00f4b023          	sd	a5,0(s1)
    80007d34:	00993023          	sd	s1,0(s2)
    80007d38:	fd4498e3          	bne	s1,s4,80007d08 <kinit+0x70>
    80007d3c:	03813083          	ld	ra,56(sp)
    80007d40:	03013403          	ld	s0,48(sp)
    80007d44:	02813483          	ld	s1,40(sp)
    80007d48:	02013903          	ld	s2,32(sp)
    80007d4c:	01813983          	ld	s3,24(sp)
    80007d50:	01013a03          	ld	s4,16(sp)
    80007d54:	00813a83          	ld	s5,8(sp)
    80007d58:	04010113          	addi	sp,sp,64
    80007d5c:	00008067          	ret
    80007d60:	00002517          	auipc	a0,0x2
    80007d64:	9c050513          	addi	a0,a0,-1600 # 80009720 <digits+0x18>
    80007d68:	fffff097          	auipc	ra,0xfffff
    80007d6c:	4b4080e7          	jalr	1204(ra) # 8000721c <panic>

0000000080007d70 <freerange>:
    80007d70:	fc010113          	addi	sp,sp,-64
    80007d74:	000017b7          	lui	a5,0x1
    80007d78:	02913423          	sd	s1,40(sp)
    80007d7c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007d80:	009504b3          	add	s1,a0,s1
    80007d84:	fffff537          	lui	a0,0xfffff
    80007d88:	02813823          	sd	s0,48(sp)
    80007d8c:	02113c23          	sd	ra,56(sp)
    80007d90:	03213023          	sd	s2,32(sp)
    80007d94:	01313c23          	sd	s3,24(sp)
    80007d98:	01413823          	sd	s4,16(sp)
    80007d9c:	01513423          	sd	s5,8(sp)
    80007da0:	01613023          	sd	s6,0(sp)
    80007da4:	04010413          	addi	s0,sp,64
    80007da8:	00a4f4b3          	and	s1,s1,a0
    80007dac:	00f487b3          	add	a5,s1,a5
    80007db0:	06f5e463          	bltu	a1,a5,80007e18 <freerange+0xa8>
    80007db4:	00009a97          	auipc	s5,0x9
    80007db8:	28ca8a93          	addi	s5,s5,652 # 80011040 <end>
    80007dbc:	0954e263          	bltu	s1,s5,80007e40 <freerange+0xd0>
    80007dc0:	01100993          	li	s3,17
    80007dc4:	01b99993          	slli	s3,s3,0x1b
    80007dc8:	0734fc63          	bgeu	s1,s3,80007e40 <freerange+0xd0>
    80007dcc:	00058a13          	mv	s4,a1
    80007dd0:	00004917          	auipc	s2,0x4
    80007dd4:	db090913          	addi	s2,s2,-592 # 8000bb80 <kmem>
    80007dd8:	00002b37          	lui	s6,0x2
    80007ddc:	0140006f          	j	80007df0 <freerange+0x80>
    80007de0:	000017b7          	lui	a5,0x1
    80007de4:	00f484b3          	add	s1,s1,a5
    80007de8:	0554ec63          	bltu	s1,s5,80007e40 <freerange+0xd0>
    80007dec:	0534fa63          	bgeu	s1,s3,80007e40 <freerange+0xd0>
    80007df0:	00001637          	lui	a2,0x1
    80007df4:	00100593          	li	a1,1
    80007df8:	00048513          	mv	a0,s1
    80007dfc:	00000097          	auipc	ra,0x0
    80007e00:	50c080e7          	jalr	1292(ra) # 80008308 <__memset>
    80007e04:	00093703          	ld	a4,0(s2)
    80007e08:	016487b3          	add	a5,s1,s6
    80007e0c:	00e4b023          	sd	a4,0(s1)
    80007e10:	00993023          	sd	s1,0(s2)
    80007e14:	fcfa76e3          	bgeu	s4,a5,80007de0 <freerange+0x70>
    80007e18:	03813083          	ld	ra,56(sp)
    80007e1c:	03013403          	ld	s0,48(sp)
    80007e20:	02813483          	ld	s1,40(sp)
    80007e24:	02013903          	ld	s2,32(sp)
    80007e28:	01813983          	ld	s3,24(sp)
    80007e2c:	01013a03          	ld	s4,16(sp)
    80007e30:	00813a83          	ld	s5,8(sp)
    80007e34:	00013b03          	ld	s6,0(sp)
    80007e38:	04010113          	addi	sp,sp,64
    80007e3c:	00008067          	ret
    80007e40:	00002517          	auipc	a0,0x2
    80007e44:	8e050513          	addi	a0,a0,-1824 # 80009720 <digits+0x18>
    80007e48:	fffff097          	auipc	ra,0xfffff
    80007e4c:	3d4080e7          	jalr	980(ra) # 8000721c <panic>

0000000080007e50 <kfree>:
    80007e50:	fe010113          	addi	sp,sp,-32
    80007e54:	00813823          	sd	s0,16(sp)
    80007e58:	00113c23          	sd	ra,24(sp)
    80007e5c:	00913423          	sd	s1,8(sp)
    80007e60:	02010413          	addi	s0,sp,32
    80007e64:	03451793          	slli	a5,a0,0x34
    80007e68:	04079c63          	bnez	a5,80007ec0 <kfree+0x70>
    80007e6c:	00009797          	auipc	a5,0x9
    80007e70:	1d478793          	addi	a5,a5,468 # 80011040 <end>
    80007e74:	00050493          	mv	s1,a0
    80007e78:	04f56463          	bltu	a0,a5,80007ec0 <kfree+0x70>
    80007e7c:	01100793          	li	a5,17
    80007e80:	01b79793          	slli	a5,a5,0x1b
    80007e84:	02f57e63          	bgeu	a0,a5,80007ec0 <kfree+0x70>
    80007e88:	00001637          	lui	a2,0x1
    80007e8c:	00100593          	li	a1,1
    80007e90:	00000097          	auipc	ra,0x0
    80007e94:	478080e7          	jalr	1144(ra) # 80008308 <__memset>
    80007e98:	00004797          	auipc	a5,0x4
    80007e9c:	ce878793          	addi	a5,a5,-792 # 8000bb80 <kmem>
    80007ea0:	0007b703          	ld	a4,0(a5)
    80007ea4:	01813083          	ld	ra,24(sp)
    80007ea8:	01013403          	ld	s0,16(sp)
    80007eac:	00e4b023          	sd	a4,0(s1)
    80007eb0:	0097b023          	sd	s1,0(a5)
    80007eb4:	00813483          	ld	s1,8(sp)
    80007eb8:	02010113          	addi	sp,sp,32
    80007ebc:	00008067          	ret
    80007ec0:	00002517          	auipc	a0,0x2
    80007ec4:	86050513          	addi	a0,a0,-1952 # 80009720 <digits+0x18>
    80007ec8:	fffff097          	auipc	ra,0xfffff
    80007ecc:	354080e7          	jalr	852(ra) # 8000721c <panic>

0000000080007ed0 <kalloc>:
    80007ed0:	fe010113          	addi	sp,sp,-32
    80007ed4:	00813823          	sd	s0,16(sp)
    80007ed8:	00913423          	sd	s1,8(sp)
    80007edc:	00113c23          	sd	ra,24(sp)
    80007ee0:	02010413          	addi	s0,sp,32
    80007ee4:	00004797          	auipc	a5,0x4
    80007ee8:	c9c78793          	addi	a5,a5,-868 # 8000bb80 <kmem>
    80007eec:	0007b483          	ld	s1,0(a5)
    80007ef0:	02048063          	beqz	s1,80007f10 <kalloc+0x40>
    80007ef4:	0004b703          	ld	a4,0(s1)
    80007ef8:	00001637          	lui	a2,0x1
    80007efc:	00500593          	li	a1,5
    80007f00:	00048513          	mv	a0,s1
    80007f04:	00e7b023          	sd	a4,0(a5)
    80007f08:	00000097          	auipc	ra,0x0
    80007f0c:	400080e7          	jalr	1024(ra) # 80008308 <__memset>
    80007f10:	01813083          	ld	ra,24(sp)
    80007f14:	01013403          	ld	s0,16(sp)
    80007f18:	00048513          	mv	a0,s1
    80007f1c:	00813483          	ld	s1,8(sp)
    80007f20:	02010113          	addi	sp,sp,32
    80007f24:	00008067          	ret

0000000080007f28 <initlock>:
    80007f28:	ff010113          	addi	sp,sp,-16
    80007f2c:	00813423          	sd	s0,8(sp)
    80007f30:	01010413          	addi	s0,sp,16
    80007f34:	00813403          	ld	s0,8(sp)
    80007f38:	00b53423          	sd	a1,8(a0)
    80007f3c:	00052023          	sw	zero,0(a0)
    80007f40:	00053823          	sd	zero,16(a0)
    80007f44:	01010113          	addi	sp,sp,16
    80007f48:	00008067          	ret

0000000080007f4c <acquire>:
    80007f4c:	fe010113          	addi	sp,sp,-32
    80007f50:	00813823          	sd	s0,16(sp)
    80007f54:	00913423          	sd	s1,8(sp)
    80007f58:	00113c23          	sd	ra,24(sp)
    80007f5c:	01213023          	sd	s2,0(sp)
    80007f60:	02010413          	addi	s0,sp,32
    80007f64:	00050493          	mv	s1,a0
    80007f68:	10002973          	csrr	s2,sstatus
    80007f6c:	100027f3          	csrr	a5,sstatus
    80007f70:	ffd7f793          	andi	a5,a5,-3
    80007f74:	10079073          	csrw	sstatus,a5
    80007f78:	fffff097          	auipc	ra,0xfffff
    80007f7c:	8ec080e7          	jalr	-1812(ra) # 80006864 <mycpu>
    80007f80:	07852783          	lw	a5,120(a0)
    80007f84:	06078e63          	beqz	a5,80008000 <acquire+0xb4>
    80007f88:	fffff097          	auipc	ra,0xfffff
    80007f8c:	8dc080e7          	jalr	-1828(ra) # 80006864 <mycpu>
    80007f90:	07852783          	lw	a5,120(a0)
    80007f94:	0004a703          	lw	a4,0(s1)
    80007f98:	0017879b          	addiw	a5,a5,1
    80007f9c:	06f52c23          	sw	a5,120(a0)
    80007fa0:	04071063          	bnez	a4,80007fe0 <acquire+0x94>
    80007fa4:	00100713          	li	a4,1
    80007fa8:	00070793          	mv	a5,a4
    80007fac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007fb0:	0007879b          	sext.w	a5,a5
    80007fb4:	fe079ae3          	bnez	a5,80007fa8 <acquire+0x5c>
    80007fb8:	0ff0000f          	fence
    80007fbc:	fffff097          	auipc	ra,0xfffff
    80007fc0:	8a8080e7          	jalr	-1880(ra) # 80006864 <mycpu>
    80007fc4:	01813083          	ld	ra,24(sp)
    80007fc8:	01013403          	ld	s0,16(sp)
    80007fcc:	00a4b823          	sd	a0,16(s1)
    80007fd0:	00013903          	ld	s2,0(sp)
    80007fd4:	00813483          	ld	s1,8(sp)
    80007fd8:	02010113          	addi	sp,sp,32
    80007fdc:	00008067          	ret
    80007fe0:	0104b903          	ld	s2,16(s1)
    80007fe4:	fffff097          	auipc	ra,0xfffff
    80007fe8:	880080e7          	jalr	-1920(ra) # 80006864 <mycpu>
    80007fec:	faa91ce3          	bne	s2,a0,80007fa4 <acquire+0x58>
    80007ff0:	00001517          	auipc	a0,0x1
    80007ff4:	73850513          	addi	a0,a0,1848 # 80009728 <digits+0x20>
    80007ff8:	fffff097          	auipc	ra,0xfffff
    80007ffc:	224080e7          	jalr	548(ra) # 8000721c <panic>
    80008000:	00195913          	srli	s2,s2,0x1
    80008004:	fffff097          	auipc	ra,0xfffff
    80008008:	860080e7          	jalr	-1952(ra) # 80006864 <mycpu>
    8000800c:	00197913          	andi	s2,s2,1
    80008010:	07252e23          	sw	s2,124(a0)
    80008014:	f75ff06f          	j	80007f88 <acquire+0x3c>

0000000080008018 <release>:
    80008018:	fe010113          	addi	sp,sp,-32
    8000801c:	00813823          	sd	s0,16(sp)
    80008020:	00113c23          	sd	ra,24(sp)
    80008024:	00913423          	sd	s1,8(sp)
    80008028:	01213023          	sd	s2,0(sp)
    8000802c:	02010413          	addi	s0,sp,32
    80008030:	00052783          	lw	a5,0(a0)
    80008034:	00079a63          	bnez	a5,80008048 <release+0x30>
    80008038:	00001517          	auipc	a0,0x1
    8000803c:	6f850513          	addi	a0,a0,1784 # 80009730 <digits+0x28>
    80008040:	fffff097          	auipc	ra,0xfffff
    80008044:	1dc080e7          	jalr	476(ra) # 8000721c <panic>
    80008048:	01053903          	ld	s2,16(a0)
    8000804c:	00050493          	mv	s1,a0
    80008050:	fffff097          	auipc	ra,0xfffff
    80008054:	814080e7          	jalr	-2028(ra) # 80006864 <mycpu>
    80008058:	fea910e3          	bne	s2,a0,80008038 <release+0x20>
    8000805c:	0004b823          	sd	zero,16(s1)
    80008060:	0ff0000f          	fence
    80008064:	0f50000f          	fence	iorw,ow
    80008068:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000806c:	ffffe097          	auipc	ra,0xffffe
    80008070:	7f8080e7          	jalr	2040(ra) # 80006864 <mycpu>
    80008074:	100027f3          	csrr	a5,sstatus
    80008078:	0027f793          	andi	a5,a5,2
    8000807c:	04079a63          	bnez	a5,800080d0 <release+0xb8>
    80008080:	07852783          	lw	a5,120(a0)
    80008084:	02f05e63          	blez	a5,800080c0 <release+0xa8>
    80008088:	fff7871b          	addiw	a4,a5,-1
    8000808c:	06e52c23          	sw	a4,120(a0)
    80008090:	00071c63          	bnez	a4,800080a8 <release+0x90>
    80008094:	07c52783          	lw	a5,124(a0)
    80008098:	00078863          	beqz	a5,800080a8 <release+0x90>
    8000809c:	100027f3          	csrr	a5,sstatus
    800080a0:	0027e793          	ori	a5,a5,2
    800080a4:	10079073          	csrw	sstatus,a5
    800080a8:	01813083          	ld	ra,24(sp)
    800080ac:	01013403          	ld	s0,16(sp)
    800080b0:	00813483          	ld	s1,8(sp)
    800080b4:	00013903          	ld	s2,0(sp)
    800080b8:	02010113          	addi	sp,sp,32
    800080bc:	00008067          	ret
    800080c0:	00001517          	auipc	a0,0x1
    800080c4:	69050513          	addi	a0,a0,1680 # 80009750 <digits+0x48>
    800080c8:	fffff097          	auipc	ra,0xfffff
    800080cc:	154080e7          	jalr	340(ra) # 8000721c <panic>
    800080d0:	00001517          	auipc	a0,0x1
    800080d4:	66850513          	addi	a0,a0,1640 # 80009738 <digits+0x30>
    800080d8:	fffff097          	auipc	ra,0xfffff
    800080dc:	144080e7          	jalr	324(ra) # 8000721c <panic>

00000000800080e0 <holding>:
    800080e0:	00052783          	lw	a5,0(a0)
    800080e4:	00079663          	bnez	a5,800080f0 <holding+0x10>
    800080e8:	00000513          	li	a0,0
    800080ec:	00008067          	ret
    800080f0:	fe010113          	addi	sp,sp,-32
    800080f4:	00813823          	sd	s0,16(sp)
    800080f8:	00913423          	sd	s1,8(sp)
    800080fc:	00113c23          	sd	ra,24(sp)
    80008100:	02010413          	addi	s0,sp,32
    80008104:	01053483          	ld	s1,16(a0)
    80008108:	ffffe097          	auipc	ra,0xffffe
    8000810c:	75c080e7          	jalr	1884(ra) # 80006864 <mycpu>
    80008110:	01813083          	ld	ra,24(sp)
    80008114:	01013403          	ld	s0,16(sp)
    80008118:	40a48533          	sub	a0,s1,a0
    8000811c:	00153513          	seqz	a0,a0
    80008120:	00813483          	ld	s1,8(sp)
    80008124:	02010113          	addi	sp,sp,32
    80008128:	00008067          	ret

000000008000812c <push_off>:
    8000812c:	fe010113          	addi	sp,sp,-32
    80008130:	00813823          	sd	s0,16(sp)
    80008134:	00113c23          	sd	ra,24(sp)
    80008138:	00913423          	sd	s1,8(sp)
    8000813c:	02010413          	addi	s0,sp,32
    80008140:	100024f3          	csrr	s1,sstatus
    80008144:	100027f3          	csrr	a5,sstatus
    80008148:	ffd7f793          	andi	a5,a5,-3
    8000814c:	10079073          	csrw	sstatus,a5
    80008150:	ffffe097          	auipc	ra,0xffffe
    80008154:	714080e7          	jalr	1812(ra) # 80006864 <mycpu>
    80008158:	07852783          	lw	a5,120(a0)
    8000815c:	02078663          	beqz	a5,80008188 <push_off+0x5c>
    80008160:	ffffe097          	auipc	ra,0xffffe
    80008164:	704080e7          	jalr	1796(ra) # 80006864 <mycpu>
    80008168:	07852783          	lw	a5,120(a0)
    8000816c:	01813083          	ld	ra,24(sp)
    80008170:	01013403          	ld	s0,16(sp)
    80008174:	0017879b          	addiw	a5,a5,1
    80008178:	06f52c23          	sw	a5,120(a0)
    8000817c:	00813483          	ld	s1,8(sp)
    80008180:	02010113          	addi	sp,sp,32
    80008184:	00008067          	ret
    80008188:	0014d493          	srli	s1,s1,0x1
    8000818c:	ffffe097          	auipc	ra,0xffffe
    80008190:	6d8080e7          	jalr	1752(ra) # 80006864 <mycpu>
    80008194:	0014f493          	andi	s1,s1,1
    80008198:	06952e23          	sw	s1,124(a0)
    8000819c:	fc5ff06f          	j	80008160 <push_off+0x34>

00000000800081a0 <pop_off>:
    800081a0:	ff010113          	addi	sp,sp,-16
    800081a4:	00813023          	sd	s0,0(sp)
    800081a8:	00113423          	sd	ra,8(sp)
    800081ac:	01010413          	addi	s0,sp,16
    800081b0:	ffffe097          	auipc	ra,0xffffe
    800081b4:	6b4080e7          	jalr	1716(ra) # 80006864 <mycpu>
    800081b8:	100027f3          	csrr	a5,sstatus
    800081bc:	0027f793          	andi	a5,a5,2
    800081c0:	04079663          	bnez	a5,8000820c <pop_off+0x6c>
    800081c4:	07852783          	lw	a5,120(a0)
    800081c8:	02f05a63          	blez	a5,800081fc <pop_off+0x5c>
    800081cc:	fff7871b          	addiw	a4,a5,-1
    800081d0:	06e52c23          	sw	a4,120(a0)
    800081d4:	00071c63          	bnez	a4,800081ec <pop_off+0x4c>
    800081d8:	07c52783          	lw	a5,124(a0)
    800081dc:	00078863          	beqz	a5,800081ec <pop_off+0x4c>
    800081e0:	100027f3          	csrr	a5,sstatus
    800081e4:	0027e793          	ori	a5,a5,2
    800081e8:	10079073          	csrw	sstatus,a5
    800081ec:	00813083          	ld	ra,8(sp)
    800081f0:	00013403          	ld	s0,0(sp)
    800081f4:	01010113          	addi	sp,sp,16
    800081f8:	00008067          	ret
    800081fc:	00001517          	auipc	a0,0x1
    80008200:	55450513          	addi	a0,a0,1364 # 80009750 <digits+0x48>
    80008204:	fffff097          	auipc	ra,0xfffff
    80008208:	018080e7          	jalr	24(ra) # 8000721c <panic>
    8000820c:	00001517          	auipc	a0,0x1
    80008210:	52c50513          	addi	a0,a0,1324 # 80009738 <digits+0x30>
    80008214:	fffff097          	auipc	ra,0xfffff
    80008218:	008080e7          	jalr	8(ra) # 8000721c <panic>

000000008000821c <push_on>:
    8000821c:	fe010113          	addi	sp,sp,-32
    80008220:	00813823          	sd	s0,16(sp)
    80008224:	00113c23          	sd	ra,24(sp)
    80008228:	00913423          	sd	s1,8(sp)
    8000822c:	02010413          	addi	s0,sp,32
    80008230:	100024f3          	csrr	s1,sstatus
    80008234:	100027f3          	csrr	a5,sstatus
    80008238:	0027e793          	ori	a5,a5,2
    8000823c:	10079073          	csrw	sstatus,a5
    80008240:	ffffe097          	auipc	ra,0xffffe
    80008244:	624080e7          	jalr	1572(ra) # 80006864 <mycpu>
    80008248:	07852783          	lw	a5,120(a0)
    8000824c:	02078663          	beqz	a5,80008278 <push_on+0x5c>
    80008250:	ffffe097          	auipc	ra,0xffffe
    80008254:	614080e7          	jalr	1556(ra) # 80006864 <mycpu>
    80008258:	07852783          	lw	a5,120(a0)
    8000825c:	01813083          	ld	ra,24(sp)
    80008260:	01013403          	ld	s0,16(sp)
    80008264:	0017879b          	addiw	a5,a5,1
    80008268:	06f52c23          	sw	a5,120(a0)
    8000826c:	00813483          	ld	s1,8(sp)
    80008270:	02010113          	addi	sp,sp,32
    80008274:	00008067          	ret
    80008278:	0014d493          	srli	s1,s1,0x1
    8000827c:	ffffe097          	auipc	ra,0xffffe
    80008280:	5e8080e7          	jalr	1512(ra) # 80006864 <mycpu>
    80008284:	0014f493          	andi	s1,s1,1
    80008288:	06952e23          	sw	s1,124(a0)
    8000828c:	fc5ff06f          	j	80008250 <push_on+0x34>

0000000080008290 <pop_on>:
    80008290:	ff010113          	addi	sp,sp,-16
    80008294:	00813023          	sd	s0,0(sp)
    80008298:	00113423          	sd	ra,8(sp)
    8000829c:	01010413          	addi	s0,sp,16
    800082a0:	ffffe097          	auipc	ra,0xffffe
    800082a4:	5c4080e7          	jalr	1476(ra) # 80006864 <mycpu>
    800082a8:	100027f3          	csrr	a5,sstatus
    800082ac:	0027f793          	andi	a5,a5,2
    800082b0:	04078463          	beqz	a5,800082f8 <pop_on+0x68>
    800082b4:	07852783          	lw	a5,120(a0)
    800082b8:	02f05863          	blez	a5,800082e8 <pop_on+0x58>
    800082bc:	fff7879b          	addiw	a5,a5,-1
    800082c0:	06f52c23          	sw	a5,120(a0)
    800082c4:	07853783          	ld	a5,120(a0)
    800082c8:	00079863          	bnez	a5,800082d8 <pop_on+0x48>
    800082cc:	100027f3          	csrr	a5,sstatus
    800082d0:	ffd7f793          	andi	a5,a5,-3
    800082d4:	10079073          	csrw	sstatus,a5
    800082d8:	00813083          	ld	ra,8(sp)
    800082dc:	00013403          	ld	s0,0(sp)
    800082e0:	01010113          	addi	sp,sp,16
    800082e4:	00008067          	ret
    800082e8:	00001517          	auipc	a0,0x1
    800082ec:	49050513          	addi	a0,a0,1168 # 80009778 <digits+0x70>
    800082f0:	fffff097          	auipc	ra,0xfffff
    800082f4:	f2c080e7          	jalr	-212(ra) # 8000721c <panic>
    800082f8:	00001517          	auipc	a0,0x1
    800082fc:	46050513          	addi	a0,a0,1120 # 80009758 <digits+0x50>
    80008300:	fffff097          	auipc	ra,0xfffff
    80008304:	f1c080e7          	jalr	-228(ra) # 8000721c <panic>

0000000080008308 <__memset>:
    80008308:	ff010113          	addi	sp,sp,-16
    8000830c:	00813423          	sd	s0,8(sp)
    80008310:	01010413          	addi	s0,sp,16
    80008314:	1a060e63          	beqz	a2,800084d0 <__memset+0x1c8>
    80008318:	40a007b3          	neg	a5,a0
    8000831c:	0077f793          	andi	a5,a5,7
    80008320:	00778693          	addi	a3,a5,7
    80008324:	00b00813          	li	a6,11
    80008328:	0ff5f593          	andi	a1,a1,255
    8000832c:	fff6071b          	addiw	a4,a2,-1
    80008330:	1b06e663          	bltu	a3,a6,800084dc <__memset+0x1d4>
    80008334:	1cd76463          	bltu	a4,a3,800084fc <__memset+0x1f4>
    80008338:	1a078e63          	beqz	a5,800084f4 <__memset+0x1ec>
    8000833c:	00b50023          	sb	a1,0(a0)
    80008340:	00100713          	li	a4,1
    80008344:	1ae78463          	beq	a5,a4,800084ec <__memset+0x1e4>
    80008348:	00b500a3          	sb	a1,1(a0)
    8000834c:	00200713          	li	a4,2
    80008350:	1ae78a63          	beq	a5,a4,80008504 <__memset+0x1fc>
    80008354:	00b50123          	sb	a1,2(a0)
    80008358:	00300713          	li	a4,3
    8000835c:	18e78463          	beq	a5,a4,800084e4 <__memset+0x1dc>
    80008360:	00b501a3          	sb	a1,3(a0)
    80008364:	00400713          	li	a4,4
    80008368:	1ae78263          	beq	a5,a4,8000850c <__memset+0x204>
    8000836c:	00b50223          	sb	a1,4(a0)
    80008370:	00500713          	li	a4,5
    80008374:	1ae78063          	beq	a5,a4,80008514 <__memset+0x20c>
    80008378:	00b502a3          	sb	a1,5(a0)
    8000837c:	00700713          	li	a4,7
    80008380:	18e79e63          	bne	a5,a4,8000851c <__memset+0x214>
    80008384:	00b50323          	sb	a1,6(a0)
    80008388:	00700e93          	li	t4,7
    8000838c:	00859713          	slli	a4,a1,0x8
    80008390:	00e5e733          	or	a4,a1,a4
    80008394:	01059e13          	slli	t3,a1,0x10
    80008398:	01c76e33          	or	t3,a4,t3
    8000839c:	01859313          	slli	t1,a1,0x18
    800083a0:	006e6333          	or	t1,t3,t1
    800083a4:	02059893          	slli	a7,a1,0x20
    800083a8:	40f60e3b          	subw	t3,a2,a5
    800083ac:	011368b3          	or	a7,t1,a7
    800083b0:	02859813          	slli	a6,a1,0x28
    800083b4:	0108e833          	or	a6,a7,a6
    800083b8:	03059693          	slli	a3,a1,0x30
    800083bc:	003e589b          	srliw	a7,t3,0x3
    800083c0:	00d866b3          	or	a3,a6,a3
    800083c4:	03859713          	slli	a4,a1,0x38
    800083c8:	00389813          	slli	a6,a7,0x3
    800083cc:	00f507b3          	add	a5,a0,a5
    800083d0:	00e6e733          	or	a4,a3,a4
    800083d4:	000e089b          	sext.w	a7,t3
    800083d8:	00f806b3          	add	a3,a6,a5
    800083dc:	00e7b023          	sd	a4,0(a5)
    800083e0:	00878793          	addi	a5,a5,8
    800083e4:	fed79ce3          	bne	a5,a3,800083dc <__memset+0xd4>
    800083e8:	ff8e7793          	andi	a5,t3,-8
    800083ec:	0007871b          	sext.w	a4,a5
    800083f0:	01d787bb          	addw	a5,a5,t4
    800083f4:	0ce88e63          	beq	a7,a4,800084d0 <__memset+0x1c8>
    800083f8:	00f50733          	add	a4,a0,a5
    800083fc:	00b70023          	sb	a1,0(a4)
    80008400:	0017871b          	addiw	a4,a5,1
    80008404:	0cc77663          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008408:	00e50733          	add	a4,a0,a4
    8000840c:	00b70023          	sb	a1,0(a4)
    80008410:	0027871b          	addiw	a4,a5,2
    80008414:	0ac77e63          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008418:	00e50733          	add	a4,a0,a4
    8000841c:	00b70023          	sb	a1,0(a4)
    80008420:	0037871b          	addiw	a4,a5,3
    80008424:	0ac77663          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008428:	00e50733          	add	a4,a0,a4
    8000842c:	00b70023          	sb	a1,0(a4)
    80008430:	0047871b          	addiw	a4,a5,4
    80008434:	08c77e63          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008438:	00e50733          	add	a4,a0,a4
    8000843c:	00b70023          	sb	a1,0(a4)
    80008440:	0057871b          	addiw	a4,a5,5
    80008444:	08c77663          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008448:	00e50733          	add	a4,a0,a4
    8000844c:	00b70023          	sb	a1,0(a4)
    80008450:	0067871b          	addiw	a4,a5,6
    80008454:	06c77e63          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008458:	00e50733          	add	a4,a0,a4
    8000845c:	00b70023          	sb	a1,0(a4)
    80008460:	0077871b          	addiw	a4,a5,7
    80008464:	06c77663          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008468:	00e50733          	add	a4,a0,a4
    8000846c:	00b70023          	sb	a1,0(a4)
    80008470:	0087871b          	addiw	a4,a5,8
    80008474:	04c77e63          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008478:	00e50733          	add	a4,a0,a4
    8000847c:	00b70023          	sb	a1,0(a4)
    80008480:	0097871b          	addiw	a4,a5,9
    80008484:	04c77663          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008488:	00e50733          	add	a4,a0,a4
    8000848c:	00b70023          	sb	a1,0(a4)
    80008490:	00a7871b          	addiw	a4,a5,10
    80008494:	02c77e63          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    80008498:	00e50733          	add	a4,a0,a4
    8000849c:	00b70023          	sb	a1,0(a4)
    800084a0:	00b7871b          	addiw	a4,a5,11
    800084a4:	02c77663          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    800084a8:	00e50733          	add	a4,a0,a4
    800084ac:	00b70023          	sb	a1,0(a4)
    800084b0:	00c7871b          	addiw	a4,a5,12
    800084b4:	00c77e63          	bgeu	a4,a2,800084d0 <__memset+0x1c8>
    800084b8:	00e50733          	add	a4,a0,a4
    800084bc:	00b70023          	sb	a1,0(a4)
    800084c0:	00d7879b          	addiw	a5,a5,13
    800084c4:	00c7f663          	bgeu	a5,a2,800084d0 <__memset+0x1c8>
    800084c8:	00f507b3          	add	a5,a0,a5
    800084cc:	00b78023          	sb	a1,0(a5)
    800084d0:	00813403          	ld	s0,8(sp)
    800084d4:	01010113          	addi	sp,sp,16
    800084d8:	00008067          	ret
    800084dc:	00b00693          	li	a3,11
    800084e0:	e55ff06f          	j	80008334 <__memset+0x2c>
    800084e4:	00300e93          	li	t4,3
    800084e8:	ea5ff06f          	j	8000838c <__memset+0x84>
    800084ec:	00100e93          	li	t4,1
    800084f0:	e9dff06f          	j	8000838c <__memset+0x84>
    800084f4:	00000e93          	li	t4,0
    800084f8:	e95ff06f          	j	8000838c <__memset+0x84>
    800084fc:	00000793          	li	a5,0
    80008500:	ef9ff06f          	j	800083f8 <__memset+0xf0>
    80008504:	00200e93          	li	t4,2
    80008508:	e85ff06f          	j	8000838c <__memset+0x84>
    8000850c:	00400e93          	li	t4,4
    80008510:	e7dff06f          	j	8000838c <__memset+0x84>
    80008514:	00500e93          	li	t4,5
    80008518:	e75ff06f          	j	8000838c <__memset+0x84>
    8000851c:	00600e93          	li	t4,6
    80008520:	e6dff06f          	j	8000838c <__memset+0x84>

0000000080008524 <__memmove>:
    80008524:	ff010113          	addi	sp,sp,-16
    80008528:	00813423          	sd	s0,8(sp)
    8000852c:	01010413          	addi	s0,sp,16
    80008530:	0e060863          	beqz	a2,80008620 <__memmove+0xfc>
    80008534:	fff6069b          	addiw	a3,a2,-1
    80008538:	0006881b          	sext.w	a6,a3
    8000853c:	0ea5e863          	bltu	a1,a0,8000862c <__memmove+0x108>
    80008540:	00758713          	addi	a4,a1,7
    80008544:	00a5e7b3          	or	a5,a1,a0
    80008548:	40a70733          	sub	a4,a4,a0
    8000854c:	0077f793          	andi	a5,a5,7
    80008550:	00f73713          	sltiu	a4,a4,15
    80008554:	00174713          	xori	a4,a4,1
    80008558:	0017b793          	seqz	a5,a5
    8000855c:	00e7f7b3          	and	a5,a5,a4
    80008560:	10078863          	beqz	a5,80008670 <__memmove+0x14c>
    80008564:	00900793          	li	a5,9
    80008568:	1107f463          	bgeu	a5,a6,80008670 <__memmove+0x14c>
    8000856c:	0036581b          	srliw	a6,a2,0x3
    80008570:	fff8081b          	addiw	a6,a6,-1
    80008574:	02081813          	slli	a6,a6,0x20
    80008578:	01d85893          	srli	a7,a6,0x1d
    8000857c:	00858813          	addi	a6,a1,8
    80008580:	00058793          	mv	a5,a1
    80008584:	00050713          	mv	a4,a0
    80008588:	01088833          	add	a6,a7,a6
    8000858c:	0007b883          	ld	a7,0(a5)
    80008590:	00878793          	addi	a5,a5,8
    80008594:	00870713          	addi	a4,a4,8
    80008598:	ff173c23          	sd	a7,-8(a4)
    8000859c:	ff0798e3          	bne	a5,a6,8000858c <__memmove+0x68>
    800085a0:	ff867713          	andi	a4,a2,-8
    800085a4:	02071793          	slli	a5,a4,0x20
    800085a8:	0207d793          	srli	a5,a5,0x20
    800085ac:	00f585b3          	add	a1,a1,a5
    800085b0:	40e686bb          	subw	a3,a3,a4
    800085b4:	00f507b3          	add	a5,a0,a5
    800085b8:	06e60463          	beq	a2,a4,80008620 <__memmove+0xfc>
    800085bc:	0005c703          	lbu	a4,0(a1)
    800085c0:	00e78023          	sb	a4,0(a5)
    800085c4:	04068e63          	beqz	a3,80008620 <__memmove+0xfc>
    800085c8:	0015c603          	lbu	a2,1(a1)
    800085cc:	00100713          	li	a4,1
    800085d0:	00c780a3          	sb	a2,1(a5)
    800085d4:	04e68663          	beq	a3,a4,80008620 <__memmove+0xfc>
    800085d8:	0025c603          	lbu	a2,2(a1)
    800085dc:	00200713          	li	a4,2
    800085e0:	00c78123          	sb	a2,2(a5)
    800085e4:	02e68e63          	beq	a3,a4,80008620 <__memmove+0xfc>
    800085e8:	0035c603          	lbu	a2,3(a1)
    800085ec:	00300713          	li	a4,3
    800085f0:	00c781a3          	sb	a2,3(a5)
    800085f4:	02e68663          	beq	a3,a4,80008620 <__memmove+0xfc>
    800085f8:	0045c603          	lbu	a2,4(a1)
    800085fc:	00400713          	li	a4,4
    80008600:	00c78223          	sb	a2,4(a5)
    80008604:	00e68e63          	beq	a3,a4,80008620 <__memmove+0xfc>
    80008608:	0055c603          	lbu	a2,5(a1)
    8000860c:	00500713          	li	a4,5
    80008610:	00c782a3          	sb	a2,5(a5)
    80008614:	00e68663          	beq	a3,a4,80008620 <__memmove+0xfc>
    80008618:	0065c703          	lbu	a4,6(a1)
    8000861c:	00e78323          	sb	a4,6(a5)
    80008620:	00813403          	ld	s0,8(sp)
    80008624:	01010113          	addi	sp,sp,16
    80008628:	00008067          	ret
    8000862c:	02061713          	slli	a4,a2,0x20
    80008630:	02075713          	srli	a4,a4,0x20
    80008634:	00e587b3          	add	a5,a1,a4
    80008638:	f0f574e3          	bgeu	a0,a5,80008540 <__memmove+0x1c>
    8000863c:	02069613          	slli	a2,a3,0x20
    80008640:	02065613          	srli	a2,a2,0x20
    80008644:	fff64613          	not	a2,a2
    80008648:	00e50733          	add	a4,a0,a4
    8000864c:	00c78633          	add	a2,a5,a2
    80008650:	fff7c683          	lbu	a3,-1(a5)
    80008654:	fff78793          	addi	a5,a5,-1
    80008658:	fff70713          	addi	a4,a4,-1
    8000865c:	00d70023          	sb	a3,0(a4)
    80008660:	fec798e3          	bne	a5,a2,80008650 <__memmove+0x12c>
    80008664:	00813403          	ld	s0,8(sp)
    80008668:	01010113          	addi	sp,sp,16
    8000866c:	00008067          	ret
    80008670:	02069713          	slli	a4,a3,0x20
    80008674:	02075713          	srli	a4,a4,0x20
    80008678:	00170713          	addi	a4,a4,1
    8000867c:	00e50733          	add	a4,a0,a4
    80008680:	00050793          	mv	a5,a0
    80008684:	0005c683          	lbu	a3,0(a1)
    80008688:	00178793          	addi	a5,a5,1
    8000868c:	00158593          	addi	a1,a1,1
    80008690:	fed78fa3          	sb	a3,-1(a5)
    80008694:	fee798e3          	bne	a5,a4,80008684 <__memmove+0x160>
    80008698:	f89ff06f          	j	80008620 <__memmove+0xfc>
	...
