
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	af813103          	ld	sp,-1288(sp) # 8000baf8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	61c060ef          	jal	ra,80006638 <start>

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
    800010a8:	46d020ef          	jal	ra,80003d14 <_ZN5RiscV20handleSupervisorTrapEv>

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

0000000080001154 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
    slab->parent = cache;
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
    80001168:	04e7f463          	bgeu	a5,a4,800011b0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x5c>
        if(!slab->allocated[i]){
    8000116c:	02053703          	ld	a4,32(a0)
    80001170:	00f70733          	add	a4,a4,a5
    80001174:	00074683          	lbu	a3,0(a4)
    80001178:	00068663          	beqz	a3,80001184 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x30>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    8000117c:	00178793          	addi	a5,a5,1
    80001180:	fe5ff06f          	j	80001164 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x10>
            slab->allocated[i] = true;
    80001184:	00100693          	li	a3,1
    80001188:	00d70023          	sb	a3,0(a4)
            slab->numOfFreeSlots--;
    8000118c:	01053703          	ld	a4,16(a0)
    80001190:	fff70713          	addi	a4,a4,-1
    80001194:	00e53823          	sd	a4,16(a0)
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80001198:	02853703          	ld	a4,40(a0)
    8000119c:	03053683          	ld	a3,48(a0)
    800011a0:	0406b503          	ld	a0,64(a3)
    800011a4:	02f507b3          	mul	a5,a0,a5
    800011a8:	00f70533          	add	a0,a4,a5
    800011ac:	0080006f          	j	800011b4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x60>
        }
    }
    return nullptr;
    800011b0:	00000513          	li	a0,0
}
    800011b4:	00813403          	ld	s0,8(sp)
    800011b8:	01010113          	addi	sp,sp,16
    800011bc:	00008067          	ret

00000000800011c0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800011c0:	ff010113          	addi	sp,sp,-16
    800011c4:	00813423          	sd	s0,8(sp)
    800011c8:	01010413          	addi	s0,sp,16
    return nullptr;
}
    800011cc:	00000513          	li	a0,0
    800011d0:	00813403          	ld	s0,8(sp)
    800011d4:	01010113          	addi	sp,sp,16
    800011d8:	00008067          	ret

00000000800011dc <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    800011dc:	fe010113          	addi	sp,sp,-32
    800011e0:	00113c23          	sd	ra,24(sp)
    800011e4:	00813823          	sd	s0,16(sp)
    800011e8:	00913423          	sd	s1,8(sp)
    800011ec:	01213023          	sd	s2,0(sp)
    800011f0:	02010413          	addi	s0,sp,32
    800011f4:	00050913          	mv	s2,a0
    ConsoleUtil::print("Slab address:", (uint64)slab, "\n");
    800011f8:	00008617          	auipc	a2,0x8
    800011fc:	fa860613          	addi	a2,a2,-88 # 800091a0 <CONSOLE_STATUS+0x190>
    80001200:	0005059b          	sext.w	a1,a0
    80001204:	00008517          	auipc	a0,0x8
    80001208:	e1c50513          	addi	a0,a0,-484 # 80009020 <CONSOLE_STATUS+0x10>
    8000120c:	00003097          	auipc	ra,0x3
    80001210:	4f8080e7          	jalr	1272(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Number of slots:", (uint64)slab->totalNumOfSlots, "\n");
    80001214:	00008617          	auipc	a2,0x8
    80001218:	f8c60613          	addi	a2,a2,-116 # 800091a0 <CONSOLE_STATUS+0x190>
    8000121c:	01892583          	lw	a1,24(s2)
    80001220:	00008517          	auipc	a0,0x8
    80001224:	e1050513          	addi	a0,a0,-496 # 80009030 <CONSOLE_STATUS+0x20>
    80001228:	00003097          	auipc	ra,0x3
    8000122c:	4dc080e7          	jalr	1244(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab object size:", (uint64)sizeof(Slab), "\n");
    80001230:	00008617          	auipc	a2,0x8
    80001234:	f7060613          	addi	a2,a2,-144 # 800091a0 <CONSOLE_STATUS+0x190>
    80001238:	03800593          	li	a1,56
    8000123c:	00008517          	auipc	a0,0x8
    80001240:	e0c50513          	addi	a0,a0,-500 # 80009048 <CONSOLE_STATUS+0x38>
    80001244:	00003097          	auipc	ra,0x3
    80001248:	4c0080e7          	jalr	1216(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Object offset:", (uint64)slab->objectOffset, "\n");
    8000124c:	00008617          	auipc	a2,0x8
    80001250:	f5460613          	addi	a2,a2,-172 # 800091a0 <CONSOLE_STATUS+0x190>
    80001254:	02892583          	lw	a1,40(s2)
    80001258:	00008517          	auipc	a0,0x8
    8000125c:	e0850513          	addi	a0,a0,-504 # 80009060 <CONSOLE_STATUS+0x50>
    80001260:	00003097          	auipc	ra,0x3
    80001264:	4a4080e7          	jalr	1188(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab allocated array address:", (uint64)slab->allocated, "\n");
    80001268:	00008617          	auipc	a2,0x8
    8000126c:	f3860613          	addi	a2,a2,-200 # 800091a0 <CONSOLE_STATUS+0x190>
    80001270:	02092583          	lw	a1,32(s2)
    80001274:	00008517          	auipc	a0,0x8
    80001278:	dfc50513          	addi	a0,a0,-516 # 80009070 <CONSOLE_STATUS+0x60>
    8000127c:	00003097          	auipc	ra,0x3
    80001280:	488080e7          	jalr	1160(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::printString("Allocated status array:\n");
    80001284:	00008517          	auipc	a0,0x8
    80001288:	e0c50513          	addi	a0,a0,-500 # 80009090 <CONSOLE_STATUS+0x80>
    8000128c:	00003097          	auipc	ra,0x3
    80001290:	358080e7          	jalr	856(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    80001294:	00000493          	li	s1,0
    80001298:	01893783          	ld	a5,24(s2)
    8000129c:	02f4f863          	bgeu	s1,a5,800012cc <_ZN13SlabAllocator9printSlabEP4Slab+0xf0>
        ConsoleUtil::print("", (uint8)slab->allocated[i], " ");
    800012a0:	02093783          	ld	a5,32(s2)
    800012a4:	009787b3          	add	a5,a5,s1
    800012a8:	00008617          	auipc	a2,0x8
    800012ac:	e1860613          	addi	a2,a2,-488 # 800090c0 <CONSOLE_STATUS+0xb0>
    800012b0:	0007c583          	lbu	a1,0(a5)
    800012b4:	00008517          	auipc	a0,0x8
    800012b8:	f2c50513          	addi	a0,a0,-212 # 800091e0 <CONSOLE_STATUS+0x1d0>
    800012bc:	00003097          	auipc	ra,0x3
    800012c0:	448080e7          	jalr	1096(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    800012c4:	00148493          	addi	s1,s1,1
    800012c8:	fd1ff06f          	j	80001298 <_ZN13SlabAllocator9printSlabEP4Slab+0xbc>
    }
    ConsoleUtil::printString("\n");
    800012cc:	00008517          	auipc	a0,0x8
    800012d0:	ed450513          	addi	a0,a0,-300 # 800091a0 <CONSOLE_STATUS+0x190>
    800012d4:	00003097          	auipc	ra,0x3
    800012d8:	310080e7          	jalr	784(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
}
    800012dc:	01813083          	ld	ra,24(sp)
    800012e0:	01013403          	ld	s0,16(sp)
    800012e4:	00813483          	ld	s1,8(sp)
    800012e8:	00013903          	ld	s2,0(sp)
    800012ec:	02010113          	addi	sp,sp,32
    800012f0:	00008067          	ret

00000000800012f4 <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800012f4:	fe010113          	addi	sp,sp,-32
    800012f8:	00113c23          	sd	ra,24(sp)
    800012fc:	00813823          	sd	s0,16(sp)
    80001300:	00913423          	sd	s1,8(sp)
    80001304:	01213023          	sd	s2,0(sp)
    80001308:	02010413          	addi	s0,sp,32
    8000130c:	00050913          	mv	s2,a0
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001310:	00008617          	auipc	a2,0x8
    80001314:	e9060613          	addi	a2,a2,-368 # 800091a0 <CONSOLE_STATUS+0x190>
    80001318:	0000a797          	auipc	a5,0xa
    8000131c:	7b07b783          	ld	a5,1968(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001320:	0007a583          	lw	a1,0(a5)
    80001324:	00008517          	auipc	a0,0x8
    80001328:	d8c50513          	addi	a0,a0,-628 # 800090b0 <CONSOLE_STATUS+0xa0>
    8000132c:	00003097          	auipc	ra,0x3
    80001330:	3d8080e7          	jalr	984(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001334:	00008617          	auipc	a2,0x8
    80001338:	e6c60613          	addi	a2,a2,-404 # 800091a0 <CONSOLE_STATUS+0x190>
    8000133c:	0009059b          	sext.w	a1,s2
    80001340:	00008517          	auipc	a0,0x8
    80001344:	d8850513          	addi	a0,a0,-632 # 800090c8 <CONSOLE_STATUS+0xb8>
    80001348:	00003097          	auipc	ra,0x3
    8000134c:	3bc080e7          	jalr	956(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    80001350:	00008617          	auipc	a2,0x8
    80001354:	e5060613          	addi	a2,a2,-432 # 800091a0 <CONSOLE_STATUS+0x190>
    80001358:	06092583          	lw	a1,96(s2)
    8000135c:	00008517          	auipc	a0,0x8
    80001360:	d7c50513          	addi	a0,a0,-644 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001364:	00003097          	auipc	ra,0x3
    80001368:	3a0080e7          	jalr	928(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    8000136c:	06093483          	ld	s1,96(s2)
    while(iter){
    80001370:	02048463          	beqz	s1,80001398 <_ZN13SlabAllocator10printCacheEP5Cache+0xa4>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001374:	00008617          	auipc	a2,0x8
    80001378:	d4c60613          	addi	a2,a2,-692 # 800090c0 <CONSOLE_STATUS+0xb0>
    8000137c:	0004859b          	sext.w	a1,s1
    80001380:	00008517          	auipc	a0,0x8
    80001384:	e6050513          	addi	a0,a0,-416 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001388:	00003097          	auipc	ra,0x3
    8000138c:	37c080e7          	jalr	892(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001390:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001394:	fddff06f          	j	80001370 <_ZN13SlabAllocator10printCacheEP5Cache+0x7c>
    }
    ConsoleUtil::printString("\n");
    80001398:	00008517          	auipc	a0,0x8
    8000139c:	e0850513          	addi	a0,a0,-504 # 800091a0 <CONSOLE_STATUS+0x190>
    800013a0:	00003097          	auipc	ra,0x3
    800013a4:	244080e7          	jalr	580(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    800013a8:	00008617          	auipc	a2,0x8
    800013ac:	df860613          	addi	a2,a2,-520 # 800091a0 <CONSOLE_STATUS+0x190>
    800013b0:	06892583          	lw	a1,104(s2)
    800013b4:	00008517          	auipc	a0,0x8
    800013b8:	d3450513          	addi	a0,a0,-716 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013bc:	00003097          	auipc	ra,0x3
    800013c0:	348080e7          	jalr	840(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    800013c4:	06893483          	ld	s1,104(s2)
    while(iter){
    800013c8:	02048463          	beqz	s1,800013f0 <_ZN13SlabAllocator10printCacheEP5Cache+0xfc>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013cc:	00008617          	auipc	a2,0x8
    800013d0:	cf460613          	addi	a2,a2,-780 # 800090c0 <CONSOLE_STATUS+0xb0>
    800013d4:	0004859b          	sext.w	a1,s1
    800013d8:	00008517          	auipc	a0,0x8
    800013dc:	e0850513          	addi	a0,a0,-504 # 800091e0 <CONSOLE_STATUS+0x1d0>
    800013e0:	00003097          	auipc	ra,0x3
    800013e4:	324080e7          	jalr	804(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800013e8:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013ec:	fddff06f          	j	800013c8 <_ZN13SlabAllocator10printCacheEP5Cache+0xd4>
    }
    ConsoleUtil::printString("\n");
    800013f0:	00008517          	auipc	a0,0x8
    800013f4:	db050513          	addi	a0,a0,-592 # 800091a0 <CONSOLE_STATUS+0x190>
    800013f8:	00003097          	auipc	ra,0x3
    800013fc:	1ec080e7          	jalr	492(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001400:	00008617          	auipc	a2,0x8
    80001404:	da060613          	addi	a2,a2,-608 # 800091a0 <CONSOLE_STATUS+0x190>
    80001408:	07092583          	lw	a1,112(s2)
    8000140c:	00008517          	auipc	a0,0x8
    80001410:	cec50513          	addi	a0,a0,-788 # 800090f8 <CONSOLE_STATUS+0xe8>
    80001414:	00003097          	auipc	ra,0x3
    80001418:	2f0080e7          	jalr	752(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    8000141c:	07093483          	ld	s1,112(s2)
    while(iter){
    80001420:	02048463          	beqz	s1,80001448 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001424:	00008617          	auipc	a2,0x8
    80001428:	c9c60613          	addi	a2,a2,-868 # 800090c0 <CONSOLE_STATUS+0xb0>
    8000142c:	0004859b          	sext.w	a1,s1
    80001430:	00008517          	auipc	a0,0x8
    80001434:	db050513          	addi	a0,a0,-592 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001438:	00003097          	auipc	ra,0x3
    8000143c:	2cc080e7          	jalr	716(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001440:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001444:	fddff06f          	j	80001420 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    80001448:	00008517          	auipc	a0,0x8
    8000144c:	d5850513          	addi	a0,a0,-680 # 800091a0 <CONSOLE_STATUS+0x190>
    80001450:	00003097          	auipc	ra,0x3
    80001454:	194080e7          	jalr	404(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    80001458:	00008617          	auipc	a2,0x8
    8000145c:	d4860613          	addi	a2,a2,-696 # 800091a0 <CONSOLE_STATUS+0x190>
    80001460:	04092583          	lw	a1,64(s2)
    80001464:	00008517          	auipc	a0,0x8
    80001468:	ca450513          	addi	a0,a0,-860 # 80009108 <CONSOLE_STATUS+0xf8>
    8000146c:	00003097          	auipc	ra,0x3
    80001470:	298080e7          	jalr	664(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
}
    80001474:	01813083          	ld	ra,24(sp)
    80001478:	01013403          	ld	s0,16(sp)
    8000147c:	00813483          	ld	s1,8(sp)
    80001480:	00013903          	ld	s2,0(sp)
    80001484:	02010113          	addi	sp,sp,32
    80001488:	00008067          	ret

000000008000148c <_ZN13SlabAllocator14insertIntoListEPP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab **head, Slab *slab) {
    8000148c:	ff010113          	addi	sp,sp,-16
    80001490:	00813423          	sd	s0,8(sp)
    80001494:	01010413          	addi	s0,sp,16
    slab->next = *head;
    80001498:	00053783          	ld	a5,0(a0)
    8000149c:	00f5b423          	sd	a5,8(a1)
    if(*head)
    800014a0:	00078463          	beqz	a5,800014a8 <_ZN13SlabAllocator14insertIntoListEPP4SlabS1_+0x1c>
        (*head)->prev = slab;
    800014a4:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800014a8:	0005b023          	sd	zero,0(a1)
    *head = slab;
    800014ac:	00b53023          	sd	a1,0(a0)
}
    800014b0:	00813403          	ld	s0,8(sp)
    800014b4:	01010113          	addi	sp,sp,16
    800014b8:	00008067          	ret

00000000800014bc <_ZN13SlabAllocator12allocateSlabEP5Cache>:
void SlabAllocator::allocateSlab(Cache *cache) {
    800014bc:	fe010113          	addi	sp,sp,-32
    800014c0:	00113c23          	sd	ra,24(sp)
    800014c4:	00813823          	sd	s0,16(sp)
    800014c8:	00913423          	sd	s1,8(sp)
    800014cc:	01213023          	sd	s2,0(sp)
    800014d0:	02010413          	addi	s0,sp,32
    800014d4:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    800014d8:	04853503          	ld	a0,72(a0)
    800014dc:	00001097          	auipc	ra,0x1
    800014e0:	a54080e7          	jalr	-1452(ra) # 80001f30 <_ZN5Buddy5allocEm>
    800014e4:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(&cache->emptyHead, slab);
    800014e8:	00050593          	mv	a1,a0
    800014ec:	06090513          	addi	a0,s2,96
    800014f0:	00000097          	auipc	ra,0x0
    800014f4:	f9c080e7          	jalr	-100(ra) # 8000148c <_ZN13SlabAllocator14insertIntoListEPP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    800014f8:	04893783          	ld	a5,72(s2)
    800014fc:	00c79793          	slli	a5,a5,0xc
    80001500:	fc878793          	addi	a5,a5,-56
    80001504:	04093703          	ld	a4,64(s2)
    80001508:	02e7d7b3          	divu	a5,a5,a4
    8000150c:	00f4b823          	sd	a5,16(s1)
    80001510:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + (slab->totalNumOfSlots>>3) + 1);
    80001514:	0037d793          	srli	a5,a5,0x3
    80001518:	009787b3          	add	a5,a5,s1
    8000151c:	03978793          	addi	a5,a5,57
    80001520:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (bool*)((uint64)slab + sizeof(Slab));
    80001524:	03848793          	addi	a5,s1,56
    80001528:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    8000152c:	0324b823          	sd	s2,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001530:	00000793          	li	a5,0
    80001534:	0184b703          	ld	a4,24(s1)
    80001538:	00e7fc63          	bgeu	a5,a4,80001550 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x94>
        slab->allocated[i] = false;
    8000153c:	0204b703          	ld	a4,32(s1)
    80001540:	00f70733          	add	a4,a4,a5
    80001544:	00070023          	sb	zero,0(a4)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001548:	00178793          	addi	a5,a5,1
    8000154c:	fe9ff06f          	j	80001534 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x78>
}
    80001550:	01813083          	ld	ra,24(sp)
    80001554:	01013403          	ld	s0,16(sp)
    80001558:	00813483          	ld	s1,8(sp)
    8000155c:	00013903          	ld	s2,0(sp)
    80001560:	02010113          	addi	sp,sp,32
    80001564:	00008067          	ret

0000000080001568 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80001568:	fe010113          	addi	sp,sp,-32
    8000156c:	00113c23          	sd	ra,24(sp)
    80001570:	00813823          	sd	s0,16(sp)
    80001574:	00913423          	sd	s1,8(sp)
    80001578:	01213023          	sd	s2,0(sp)
    8000157c:	02010413          	addi	s0,sp,32
    80001580:	00050913          	mv	s2,a0
    80001584:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    80001588:	00000097          	auipc	ra,0x0
    8000158c:	5f0080e7          	jalr	1520(ra) # 80001b78 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    80001590:	0000a797          	auipc	a5,0xa
    80001594:	62078793          	addi	a5,a5,1568 # 8000bbb0 <_ZN13SlabAllocator9startAddrE>
    80001598:	0127b023          	sd	s2,0(a5)
    blocksResponsibleFor = blockNum;
    8000159c:	0097b423          	sd	s1,8(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800015a0:	0000a717          	auipc	a4,0xa
    800015a4:	52873703          	ld	a4,1320(a4) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800015a8:	00073503          	ld	a0,0(a4)
    800015ac:	00c55513          	srli	a0,a0,0xc
    800015b0:	00150513          	addi	a0,a0,1
    800015b4:	00c51513          	slli	a0,a0,0xc
    800015b8:	00a7b823          	sd	a0,16(a5)
    cache->ctor = nullptr;
    800015bc:	04053823          	sd	zero,80(a0)
    cache->dtor = nullptr;
    800015c0:	04053c23          	sd	zero,88(a0)
    cache->emptyHead = nullptr;
    800015c4:	06053023          	sd	zero,96(a0)
    cache->partialHead = nullptr;
    800015c8:	06053423          	sd	zero,104(a0)
    cache->fullHead = nullptr;
    800015cc:	06053823          	sd	zero,112(a0)
    cache->objectSize = sizeof(Cache);
    800015d0:	07800793          	li	a5,120
    800015d4:	04f53023          	sd	a5,64(a0)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    800015d8:	00200793          	li	a5,2
    800015dc:	04f53423          	sd	a5,72(a0)
    allocateSlab(cache);
    800015e0:	00000097          	auipc	ra,0x0
    800015e4:	edc080e7          	jalr	-292(ra) # 800014bc <_ZN13SlabAllocator12allocateSlabEP5Cache>
}
    800015e8:	01813083          	ld	ra,24(sp)
    800015ec:	01013403          	ld	s0,16(sp)
    800015f0:	00813483          	ld	s1,8(sp)
    800015f4:	00013903          	ld	s2,0(sp)
    800015f8:	02010113          	addi	sp,sp,32
    800015fc:	00008067          	ret

0000000080001600 <_ZN13SlabAllocator14removeFromListEPP4SlabS1_>:

void SlabAllocator::removeFromList(Slab** head, Slab* slab) {
    80001600:	ff010113          	addi	sp,sp,-16
    80001604:	00813423          	sd	s0,8(sp)
    80001608:	01010413          	addi	s0,sp,16
    if(slab == *head)
    8000160c:	00053783          	ld	a5,0(a0)
    80001610:	02b78c63          	beq	a5,a1,80001648 <_ZN13SlabAllocator14removeFromListEPP4SlabS1_+0x48>
        *head = slab->next;
    if(slab->next)
    80001614:	0085b783          	ld	a5,8(a1)
    80001618:	00078663          	beqz	a5,80001624 <_ZN13SlabAllocator14removeFromListEPP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    8000161c:	0005b703          	ld	a4,0(a1)
    80001620:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001624:	0005b783          	ld	a5,0(a1)
    80001628:	00078663          	beqz	a5,80001634 <_ZN13SlabAllocator14removeFromListEPP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    8000162c:	0085b703          	ld	a4,8(a1)
    80001630:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001634:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001638:	0005b423          	sd	zero,8(a1)
    8000163c:	00813403          	ld	s0,8(sp)
    80001640:	01010113          	addi	sp,sp,16
    80001644:	00008067          	ret
        *head = slab->next;
    80001648:	0085b783          	ld	a5,8(a1)
    8000164c:	00f53023          	sd	a5,0(a0)
    80001650:	fc5ff06f          	j	80001614 <_ZN13SlabAllocator14removeFromListEPP4SlabS1_+0x14>

0000000080001654 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001654:	ff010113          	addi	sp,sp,-16
    80001658:	00813423          	sd	s0,8(sp)
    8000165c:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001660:	03f50513          	addi	a0,a0,63
    80001664:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001668:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    8000166c:	00100513          	li	a0,1
    asm("ecall");
    80001670:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001674:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001678:	00813403          	ld	s0,8(sp)
    8000167c:	01010113          	addi	sp,sp,16
    80001680:	00008067          	ret

0000000080001684 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001684:	ff010113          	addi	sp,sp,-16
    80001688:	00813423          	sd	s0,8(sp)
    8000168c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001690:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001694:	00200513          	li	a0,2
    asm("ecall");
    80001698:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    8000169c:	00050513          	mv	a0,a0
    return status;
}
    800016a0:	0005051b          	sext.w	a0,a0
    800016a4:	00813403          	ld	s0,8(sp)
    800016a8:	01010113          	addi	sp,sp,16
    800016ac:	00008067          	ret

00000000800016b0 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    800016b0:	fd010113          	addi	sp,sp,-48
    800016b4:	02113423          	sd	ra,40(sp)
    800016b8:	02813023          	sd	s0,32(sp)
    800016bc:	00913c23          	sd	s1,24(sp)
    800016c0:	01213823          	sd	s2,16(sp)
    800016c4:	01313423          	sd	s3,8(sp)
    800016c8:	03010413          	addi	s0,sp,48
    800016cc:	00050913          	mv	s2,a0
    800016d0:	00058493          	mv	s1,a1
    800016d4:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    800016d8:	04058663          	beqz	a1,80001724 <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800016dc:	00001537          	lui	a0,0x1
    800016e0:	00000097          	auipc	ra,0x0
    800016e4:	f74080e7          	jalr	-140(ra) # 80001654 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800016e8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800016ec:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800016f0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800016f4:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    800016f8:	01100513          	li	a0,17

    asm("ecall");
    800016fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001700:	00050513          	mv	a0,a0

    return status;
}
    80001704:	0005051b          	sext.w	a0,a0
    80001708:	02813083          	ld	ra,40(sp)
    8000170c:	02013403          	ld	s0,32(sp)
    80001710:	01813483          	ld	s1,24(sp)
    80001714:	01013903          	ld	s2,16(sp)
    80001718:	00813983          	ld	s3,8(sp)
    8000171c:	03010113          	addi	sp,sp,48
    80001720:	00008067          	ret
    uint64 istack = 0;
    80001724:	00000513          	li	a0,0
    80001728:	fc1ff06f          	j	800016e8 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

000000008000172c <_Z11thread_exitv>:

int thread_exit(){
    8000172c:	ff010113          	addi	sp,sp,-16
    80001730:	00813423          	sd	s0,8(sp)
    80001734:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001738:	01200513          	li	a0,18

    asm("ecall");
    8000173c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001740:	00050513          	mv	a0,a0

    return status;
}
    80001744:	0005051b          	sext.w	a0,a0
    80001748:	00813403          	ld	s0,8(sp)
    8000174c:	01010113          	addi	sp,sp,16
    80001750:	00008067          	ret

0000000080001754 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001754:	ff010113          	addi	sp,sp,-16
    80001758:	00813423          	sd	s0,8(sp)
    8000175c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001760:	01300513          	li	a0,19

    asm("ecall");
    80001764:	00000073          	ecall
}
    80001768:	00813403          	ld	s0,8(sp)
    8000176c:	01010113          	addi	sp,sp,16
    80001770:	00008067          	ret

0000000080001774 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001774:	fd010113          	addi	sp,sp,-48
    80001778:	02113423          	sd	ra,40(sp)
    8000177c:	02813023          	sd	s0,32(sp)
    80001780:	00913c23          	sd	s1,24(sp)
    80001784:	01213823          	sd	s2,16(sp)
    80001788:	01313423          	sd	s3,8(sp)
    8000178c:	03010413          	addi	s0,sp,48
    80001790:	00050913          	mv	s2,a0
    80001794:	00058493          	mv	s1,a1
    80001798:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    8000179c:	04058663          	beqz	a1,800017e8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800017a0:	00001537          	lui	a0,0x1
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	eb0080e7          	jalr	-336(ra) # 80001654 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800017ac:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800017b0:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800017b4:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800017b8:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    800017bc:	01400513          	li	a0,20

    asm("ecall");
    800017c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800017c4:	00050513          	mv	a0,a0

    return status;
}
    800017c8:	0005051b          	sext.w	a0,a0
    800017cc:	02813083          	ld	ra,40(sp)
    800017d0:	02013403          	ld	s0,32(sp)
    800017d4:	01813483          	ld	s1,24(sp)
    800017d8:	01013903          	ld	s2,16(sp)
    800017dc:	00813983          	ld	s3,8(sp)
    800017e0:	03010113          	addi	sp,sp,48
    800017e4:	00008067          	ret
    uint64 istack = 0;
    800017e8:	00000513          	li	a0,0
    800017ec:	fc1ff06f          	j	800017ac <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

00000000800017f0 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    800017f0:	ff010113          	addi	sp,sp,-16
    800017f4:	00813423          	sd	s0,8(sp)
    800017f8:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800017fc:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001800:	01500513          	li	a0,21

    asm("ecall");
    80001804:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001808:	00050513          	mv	a0,a0

    return status;
}
    8000180c:	0005051b          	sext.w	a0,a0
    80001810:	00813403          	ld	s0,8(sp)
    80001814:	01010113          	addi	sp,sp,16
    80001818:	00008067          	ret

000000008000181c <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    8000181c:	ff010113          	addi	sp,sp,-16
    80001820:	00813423          	sd	s0,8(sp)
    80001824:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001828:	02059593          	slli	a1,a1,0x20
    8000182c:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001830:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001834:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001838:	02100513          	li	a0,33


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

0000000080001854 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001854:	ff010113          	addi	sp,sp,-16
    80001858:	00813423          	sd	s0,8(sp)
    8000185c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001860:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001864:	02200513          	li	a0,34


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

0000000080001880 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00813423          	sd	s0,8(sp)
    80001888:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000188c:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001890:	02300513          	li	a0,35


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

00000000800018ac <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    800018ac:	ff010113          	addi	sp,sp,-16
    800018b0:	00813423          	sd	s0,8(sp)
    800018b4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800018b8:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    800018bc:	02400513          	li	a0,36


    asm("ecall");
    800018c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800018c4:	00050513          	mv	a0,a0

    return status;
}
    800018c8:	0005051b          	sext.w	a0,a0
    800018cc:	00813403          	ld	s0,8(sp)
    800018d0:	01010113          	addi	sp,sp,16
    800018d4:	00008067          	ret

00000000800018d8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    800018d8:	ff010113          	addi	sp,sp,-16
    800018dc:	00813423          	sd	s0,8(sp)
    800018e0:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    800018e4:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    800018e8:	03100513          	li	a0,49


    asm("ecall");
    800018ec:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800018f0:	00050513          	mv	a0,a0

    return status;
}
    800018f4:	0005051b          	sext.w	a0,a0
    800018f8:	00813403          	ld	s0,8(sp)
    800018fc:	01010113          	addi	sp,sp,16
    80001900:	00008067          	ret

0000000080001904 <_Z4getcv>:

char getc(){
    80001904:	ff010113          	addi	sp,sp,-16
    80001908:	00813423          	sd	s0,8(sp)
    8000190c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80001910:	04100513          	li	a0,65

    asm("ecall");
    80001914:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80001918:	00050513          	mv	a0,a0

    return c;
}
    8000191c:	0ff57513          	andi	a0,a0,255
    80001920:	00813403          	ld	s0,8(sp)
    80001924:	01010113          	addi	sp,sp,16
    80001928:	00008067          	ret

000000008000192c <_Z4putcc>:

void putc(char c){
    8000192c:	ff010113          	addi	sp,sp,-16
    80001930:	00813423          	sd	s0,8(sp)
    80001934:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80001938:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    8000193c:	04200513          	li	a0,66

    asm("ecall");
    80001940:	00000073          	ecall
}
    80001944:	00813403          	ld	s0,8(sp)
    80001948:	01010113          	addi	sp,sp,16
    8000194c:	00008067          	ret

0000000080001950 <_Z4forkv>:


int fork(){
    80001950:	ff010113          	addi	sp,sp,-16
    80001954:	00813423          	sd	s0,8(sp)
    80001958:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    8000195c:	06100513          	li	a0,97

    asm("ecall");
    80001960:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001964:	00050513          	mv	a0,a0

    return status;
}
    80001968:	0005051b          	sext.w	a0,a0
    8000196c:	00813403          	ld	s0,8(sp)
    80001970:	01010113          	addi	sp,sp,16
    80001974:	00008067          	ret

0000000080001978 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80001978:	ff010113          	addi	sp,sp,-16
    8000197c:	00113423          	sd	ra,8(sp)
    80001980:	00813023          	sd	s0,0(sp)
    80001984:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80001988:	00000097          	auipc	ra,0x0
    8000198c:	ecc080e7          	jalr	-308(ra) # 80001854 <_Z9sem_closeP10_semaphore>
}
    80001990:	00813083          	ld	ra,8(sp)
    80001994:	00013403          	ld	s0,0(sp)
    80001998:	01010113          	addi	sp,sp,16
    8000199c:	00008067          	ret

00000000800019a0 <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    800019a0:	ff010113          	addi	sp,sp,-16
    800019a4:	00113423          	sd	ra,8(sp)
    800019a8:	00813023          	sd	s0,0(sp)
    800019ac:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    800019b0:	00001097          	auipc	ra,0x1
    800019b4:	ee4080e7          	jalr	-284(ra) # 80002894 <_ZN3TCB11thread_freeEPv>
    800019b8:	00813083          	ld	ra,8(sp)
    800019bc:	00013403          	ld	s0,0(sp)
    800019c0:	01010113          	addi	sp,sp,16
    800019c4:	00008067          	ret

00000000800019c8 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    800019c8:	ff010113          	addi	sp,sp,-16
    800019cc:	00113423          	sd	ra,8(sp)
    800019d0:	00813023          	sd	s0,0(sp)
    800019d4:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    800019d8:	00004097          	auipc	ra,0x4
    800019dc:	3bc080e7          	jalr	956(ra) # 80005d94 <_Z8userMainv>
    800019e0:	00813083          	ld	ra,8(sp)
    800019e4:	00013403          	ld	s0,0(sp)
    800019e8:	01010113          	addi	sp,sp,16
    800019ec:	00008067          	ret

00000000800019f0 <_ZN6SystemC1Ev>:
    if (!initialized) {
    800019f0:	0000a797          	auipc	a5,0xa
    800019f4:	2407c783          	lbu	a5,576(a5) # 8000bc30 <_ZN6System11initializedE>
    800019f8:	00078463          	beqz	a5,80001a00 <_ZN6SystemC1Ev+0x10>
    800019fc:	00008067          	ret
System::System() {
    80001a00:	fc010113          	addi	sp,sp,-64
    80001a04:	02113c23          	sd	ra,56(sp)
    80001a08:	02813823          	sd	s0,48(sp)
    80001a0c:	02913423          	sd	s1,40(sp)
    80001a10:	03213023          	sd	s2,32(sp)
    80001a14:	01313c23          	sd	s3,24(sp)
    80001a18:	04010413          	addi	s0,sp,64
        initialized = true;
    80001a1c:	00100793          	li	a5,1
    80001a20:	0000a717          	auipc	a4,0xa
    80001a24:	20f70823          	sb	a5,528(a4) # 8000bc30 <_ZN6System11initializedE>
        RiscV::initialize();
    80001a28:	00002097          	auipc	ra,0x2
    80001a2c:	808080e7          	jalr	-2040(ra) # 80003230 <_ZN5RiscV10initializeEv>
        Cache *cache = SlabAllocator::cache;
    80001a30:	0000a497          	auipc	s1,0xa
    80001a34:	0d04b483          	ld	s1,208(s1) # 8000bb00 <_GLOBAL_OFFSET_TABLE_+0x50>
    80001a38:	0004b903          	ld	s2,0(s1)
        SlabAllocator::printCache(cache);
    80001a3c:	00090513          	mv	a0,s2
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	8b4080e7          	jalr	-1868(ra) # 800012f4 <_ZN13SlabAllocator10printCacheEP5Cache>
        Slab *slab = cache->emptyHead;
    80001a48:	06093983          	ld	s3,96(s2)
        SlabAllocator::printSlab(SlabAllocator::cache->emptyHead);
    80001a4c:	0004b783          	ld	a5,0(s1)
    80001a50:	0607b503          	ld	a0,96(a5)
    80001a54:	fffff097          	auipc	ra,0xfffff
    80001a58:	788080e7          	jalr	1928(ra) # 800011dc <_ZN13SlabAllocator9printSlabEP4Slab>
        void* all1 = SlabAllocator::allocateSlot(slab);
    80001a5c:	00098513          	mv	a0,s3
    80001a60:	fffff097          	auipc	ra,0xfffff
    80001a64:	6f4080e7          	jalr	1780(ra) # 80001154 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001a68:	00050913          	mv	s2,a0
        void* all2 = SlabAllocator::allocateSlot(slab);
    80001a6c:	00098513          	mv	a0,s3
    80001a70:	fffff097          	auipc	ra,0xfffff
    80001a74:	6e4080e7          	jalr	1764(ra) # 80001154 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001a78:	00050493          	mv	s1,a0
        SlabAllocator::printSlab(slab);
    80001a7c:	00098513          	mv	a0,s3
    80001a80:	fffff097          	auipc	ra,0xfffff
    80001a84:	75c080e7          	jalr	1884(ra) # 800011dc <_ZN13SlabAllocator9printSlabEP4Slab>
        ConsoleUtil::print("",(uint64)all1,"\n");
    80001a88:	00007617          	auipc	a2,0x7
    80001a8c:	71860613          	addi	a2,a2,1816 # 800091a0 <CONSOLE_STATUS+0x190>
    80001a90:	0009059b          	sext.w	a1,s2
    80001a94:	00007517          	auipc	a0,0x7
    80001a98:	74c50513          	addi	a0,a0,1868 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001a9c:	00003097          	auipc	ra,0x3
    80001aa0:	c68080e7          	jalr	-920(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("",(uint64)all2,"\n");
    80001aa4:	00007617          	auipc	a2,0x7
    80001aa8:	6fc60613          	addi	a2,a2,1788 # 800091a0 <CONSOLE_STATUS+0x190>
    80001aac:	0004859b          	sext.w	a1,s1
    80001ab0:	00007517          	auipc	a0,0x7
    80001ab4:	73050513          	addi	a0,a0,1840 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001ab8:	00003097          	auipc	ra,0x3
    80001abc:	c4c080e7          	jalr	-948(ra) # 80004704 <_ZN11ConsoleUtil5printEPKciS1_>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80001ac0:	00000613          	li	a2,0
    80001ac4:	00000597          	auipc	a1,0x0
    80001ac8:	f0458593          	addi	a1,a1,-252 # 800019c8 <_ZN6System15userMainWrapperEPv>
    80001acc:	fc840513          	addi	a0,s0,-56
    80001ad0:	00000097          	auipc	ra,0x0
    80001ad4:	be0080e7          	jalr	-1056(ra) # 800016b0 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001ad8:	fc843783          	ld	a5,-56(s0)
    80001adc:	0107a703          	lw	a4,16(a5)
    80001ae0:	00200793          	li	a5,2
    80001ae4:	00f70863          	beq	a4,a5,80001af4 <_ZN6SystemC1Ev+0x104>
            thread_dispatch();
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	c6c080e7          	jalr	-916(ra) # 80001754 <_Z15thread_dispatchv>
    80001af0:	fe9ff06f          	j	80001ad8 <_ZN6SystemC1Ev+0xe8>
        RiscV::finalize();
    80001af4:	00002097          	auipc	ra,0x2
    80001af8:	938080e7          	jalr	-1736(ra) # 8000342c <_ZN5RiscV8finalizeEv>
}
    80001afc:	03813083          	ld	ra,56(sp)
    80001b00:	03013403          	ld	s0,48(sp)
    80001b04:	02813483          	ld	s1,40(sp)
    80001b08:	02013903          	ld	s2,32(sp)
    80001b0c:	01813983          	ld	s3,24(sp)
    80001b10:	04010113          	addi	sp,sp,64
    80001b14:	00008067          	ret

0000000080001b18 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001b18:	ff010113          	addi	sp,sp,-16
    80001b1c:	00813423          	sd	s0,8(sp)
    80001b20:	01010413          	addi	s0,sp,16
    80001b24:	00100793          	li	a5,1
    80001b28:	00f50863          	beq	a0,a5,80001b38 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001b2c:	00813403          	ld	s0,8(sp)
    80001b30:	01010113          	addi	sp,sp,16
    80001b34:	00008067          	ret
    80001b38:	000107b7          	lui	a5,0x10
    80001b3c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001b40:	fef596e3          	bne	a1,a5,80001b2c <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80001b44:	0000a797          	auipc	a5,0xa
    80001b48:	f847b783          	ld	a5,-124(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001b4c:	0007b703          	ld	a4,0(a5)
    80001b50:	00c75793          	srli	a5,a4,0xc
    80001b54:	00278793          	addi	a5,a5,2
    80001b58:	00c79793          	slli	a5,a5,0xc
    80001b5c:	0000a697          	auipc	a3,0xa
    80001b60:	0dc68693          	addi	a3,a3,220 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b64:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001b68:	fffff7b7          	lui	a5,0xfffff
    80001b6c:	00f77733          	and	a4,a4,a5
    80001b70:	00e6b423          	sd	a4,8(a3)
    80001b74:	fb9ff06f          	j	80001b2c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001b78 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80001b78:	ff010113          	addi	sp,sp,-16
    80001b7c:	00813423          	sd	s0,8(sp)
    80001b80:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80001b84:	0000a717          	auipc	a4,0xa
    80001b88:	0b470713          	addi	a4,a4,180 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001b8c:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001b90:	0000a797          	auipc	a5,0xa
    80001b94:	f387b783          	ld	a5,-200(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001b98:	0007b783          	ld	a5,0(a5)
    80001b9c:	fffff6b7          	lui	a3,0xfffff
    80001ba0:	00d7f7b3          	and	a5,a5,a3
    80001ba4:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80001ba8:	0000a797          	auipc	a5,0xa
    80001bac:	d6b7bc23          	sd	a1,-648(a5) # 8000b920 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80001bb0:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001bb4:	00000713          	li	a4,0
        while(num>1){
    80001bb8:	00100693          	li	a3,1
    80001bbc:	00f6f863          	bgeu	a3,a5,80001bcc <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80001bc0:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001bc4:	00170713          	addi	a4,a4,1
        while(num>1){
    80001bc8:	ff1ff06f          	j	80001bb8 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001bcc:	00371713          	slli	a4,a4,0x3
    80001bd0:	0000a797          	auipc	a5,0xa
    80001bd4:	06878793          	addi	a5,a5,104 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001bd8:	00e78733          	add	a4,a5,a4
    80001bdc:	00a73823          	sd	a0,16(a4)
    80001be0:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001be4:	00000713          	li	a4,0
        while(num>1){
    80001be8:	00100693          	li	a3,1
    80001bec:	00f6f863          	bgeu	a3,a5,80001bfc <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001bf0:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001bf4:	00170713          	addi	a4,a4,1
        while(num>1){
    80001bf8:	ff1ff06f          	j	80001be8 <_ZN5Buddy10initializeEPvm+0x70>
    80001bfc:	00371713          	slli	a4,a4,0x3
    80001c00:	0000a797          	auipc	a5,0xa
    80001c04:	03878793          	addi	a5,a5,56 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c08:	00e78733          	add	a4,a5,a4
    80001c0c:	06a73c23          	sd	a0,120(a4)
    80001c10:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001c14:	00000713          	li	a4,0
        while(num>1){
    80001c18:	00100693          	li	a3,1
    80001c1c:	00f6f863          	bgeu	a3,a5,80001c2c <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001c20:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001c24:	00170713          	addi	a4,a4,1
        while(num>1){
    80001c28:	ff1ff06f          	j	80001c18 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001c2c:	00371713          	slli	a4,a4,0x3
    80001c30:	0000a797          	auipc	a5,0xa
    80001c34:	00878793          	addi	a5,a5,8 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c38:	00e78733          	add	a4,a5,a4
    80001c3c:	01073783          	ld	a5,16(a4)
    80001c40:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001c44:	00000793          	li	a5,0
    80001c48:	00c0006f          	j	80001c54 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001c4c:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001c50:	00178793          	addi	a5,a5,1
        while(num>1){
    80001c54:	00100713          	li	a4,1
    80001c58:	feb76ae3          	bltu	a4,a1,80001c4c <_ZN5Buddy10initializeEPvm+0xd4>
    80001c5c:	00379793          	slli	a5,a5,0x3
    80001c60:	0000a717          	auipc	a4,0xa
    80001c64:	fd870713          	addi	a4,a4,-40 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001c68:	00f707b3          	add	a5,a4,a5
    80001c6c:	0787b783          	ld	a5,120(a5)
    80001c70:	0007b023          	sd	zero,0(a5)
}
    80001c74:	00813403          	ld	s0,8(sp)
    80001c78:	01010113          	addi	sp,sp,16
    80001c7c:	00008067          	ret

0000000080001c80 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001c80:	00c00793          	li	a5,12
    80001c84:	0ef50863          	beq	a0,a5,80001d74 <_ZN5Buddy8compressEm+0xf4>
void Buddy::compress(uint64 size) {
    80001c88:	fd010113          	addi	sp,sp,-48
    80001c8c:	02113423          	sd	ra,40(sp)
    80001c90:	02813023          	sd	s0,32(sp)
    80001c94:	00913c23          	sd	s1,24(sp)
    80001c98:	01213823          	sd	s2,16(sp)
    80001c9c:	01313423          	sd	s3,8(sp)
    80001ca0:	03010413          	addi	s0,sp,48
    80001ca4:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001ca8:	00351713          	slli	a4,a0,0x3
    80001cac:	0000a797          	auipc	a5,0xa
    80001cb0:	f8c78793          	addi	a5,a5,-116 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001cb4:	00e787b3          	add	a5,a5,a4
    80001cb8:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80001cbc:	00000993          	li	s3,0
    80001cc0:	0180006f          	j	80001cd8 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80001cc4:	40d70733          	sub	a4,a4,a3
        if(blkNoNext == pair){
    80001cc8:	04f70663          	beq	a4,a5,80001d14 <_ZN5Buddy8compressEm+0x94>
            prev = curr;
    80001ccc:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80001cd0:	06f70863          	beq	a4,a5,80001d40 <_ZN5Buddy8compressEm+0xc0>
        curr = curr->next;
    80001cd4:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80001cd8:	08048063          	beqz	s1,80001d58 <_ZN5Buddy8compressEm+0xd8>
    80001cdc:	0004b603          	ld	a2,0(s1)
    80001ce0:	06060c63          	beqz	a2,80001d58 <_ZN5Buddy8compressEm+0xd8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    80001ce4:	0000a797          	auipc	a5,0xa
    80001ce8:	f547b783          	ld	a5,-172(a5) # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001cec:	40f48733          	sub	a4,s1,a5
    80001cf0:	00c75713          	srli	a4,a4,0xc
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    80001cf4:	40f607b3          	sub	a5,a2,a5
    80001cf8:	00c7d793          	srli	a5,a5,0xc
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80001cfc:	00100693          	li	a3,1
    80001d00:	012696bb          	sllw	a3,a3,s2
    80001d04:	02d775b3          	remu	a1,a4,a3
    80001d08:	fa059ee3          	bnez	a1,80001cc4 <_ZN5Buddy8compressEm+0x44>
    80001d0c:	00e68733          	add	a4,a3,a4
    80001d10:	fb9ff06f          	j	80001cc8 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80001d14:	00098863          	beqz	s3,80001d24 <_ZN5Buddy8compressEm+0xa4>
                prev->next = curr->next->next;
    80001d18:	00063683          	ld	a3,0(a2)
    80001d1c:	00d9b023          	sd	a3,0(s3)
    80001d20:	fb1ff06f          	j	80001cd0 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80001d24:	00063603          	ld	a2,0(a2)
    80001d28:	00391593          	slli	a1,s2,0x3
    80001d2c:	0000a697          	auipc	a3,0xa
    80001d30:	f0c68693          	addi	a3,a3,-244 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d34:	00b686b3          	add	a3,a3,a1
    80001d38:	06c6bc23          	sd	a2,120(a3)
    80001d3c:	f95ff06f          	j	80001cd0 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80001d40:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80001d44:	00190593          	addi	a1,s2,1
    80001d48:	00048513          	mv	a0,s1
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	02c080e7          	jalr	44(ra) # 80001d78 <_ZN5Buddy6insertEPvm>
    80001d54:	f81ff06f          	j	80001cd4 <_ZN5Buddy8compressEm+0x54>
}
    80001d58:	02813083          	ld	ra,40(sp)
    80001d5c:	02013403          	ld	s0,32(sp)
    80001d60:	01813483          	ld	s1,24(sp)
    80001d64:	01013903          	ld	s2,16(sp)
    80001d68:	00813983          	ld	s3,8(sp)
    80001d6c:	03010113          	addi	sp,sp,48
    80001d70:	00008067          	ret
    80001d74:	00008067          	ret

0000000080001d78 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80001d78:	00050693          	mv	a3,a0
    if(!head[size]){
    80001d7c:	00359713          	slli	a4,a1,0x3
    80001d80:	0000a797          	auipc	a5,0xa
    80001d84:	eb878793          	addi	a5,a5,-328 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001d88:	00e787b3          	add	a5,a5,a4
    80001d8c:	0787b783          	ld	a5,120(a5)
    80001d90:	02078863          	beqz	a5,80001dc0 <_ZN5Buddy6insertEPvm+0x48>
void Buddy::insert(void *addr, uint64 size) {
    80001d94:	ff010113          	addi	sp,sp,-16
    80001d98:	00113423          	sd	ra,8(sp)
    80001d9c:	00813023          	sd	s0,0(sp)
    80001da0:	01010413          	addi	s0,sp,16
    80001da4:	00058513          	mv	a0,a1
        if((uint64)addr < (uint64)head[size]){
    80001da8:	00068713          	mv	a4,a3
    80001dac:	02f6ec63          	bltu	a3,a5,80001de4 <_ZN5Buddy6insertEPvm+0x6c>
            while(iter != nullptr){
    80001db0:	06078663          	beqz	a5,80001e1c <_ZN5Buddy6insertEPvm+0xa4>
                if((uint64)addr < (uint64)iter) {
    80001db4:	04f76a63          	bltu	a4,a5,80001e08 <_ZN5Buddy6insertEPvm+0x90>
                    iter = iter->next;
    80001db8:	0007b783          	ld	a5,0(a5)
            while(iter != nullptr){
    80001dbc:	ff5ff06f          	j	80001db0 <_ZN5Buddy6insertEPvm+0x38>
        head[size] = tail[size] = (Block*)addr;
    80001dc0:	0000a797          	auipc	a5,0xa
    80001dc4:	e7878793          	addi	a5,a5,-392 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001dc8:	00e78533          	add	a0,a5,a4
    80001dcc:	00d53823          	sd	a3,16(a0)
    80001dd0:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80001dd4:	0006b023          	sd	zero,0(a3)
    80001dd8:	07853783          	ld	a5,120(a0)
    80001ddc:	0007b023          	sd	zero,0(a5)
        return;
    80001de0:	00008067          	ret
            newHead->next = head[size];
    80001de4:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80001de8:	00359713          	slli	a4,a1,0x3
    80001dec:	0000a797          	auipc	a5,0xa
    80001df0:	e4c78793          	addi	a5,a5,-436 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001df4:	00e787b3          	add	a5,a5,a4
    80001df8:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80001dfc:	00000097          	auipc	ra,0x0
    80001e00:	e84080e7          	jalr	-380(ra) # 80001c80 <_ZN5Buddy8compressEm>
            return;
    80001e04:	0440006f          	j	80001e48 <_ZN5Buddy6insertEPvm+0xd0>
                    newBlock->next = iter;
    80001e08:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80001e0c:	00d03023          	sd	a3,0(zero) # 0 <_entry-0x80000000>
                    compress(size);
    80001e10:	00000097          	auipc	ra,0x0
    80001e14:	e70080e7          	jalr	-400(ra) # 80001c80 <_ZN5Buddy8compressEm>
                    return;
    80001e18:	0300006f          	j	80001e48 <_ZN5Buddy6insertEPvm+0xd0>
    tail[size]->next = (Block*)addr;
    80001e1c:	00351713          	slli	a4,a0,0x3
    80001e20:	0000a797          	auipc	a5,0xa
    80001e24:	e1878793          	addi	a5,a5,-488 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001e28:	00e787b3          	add	a5,a5,a4
    80001e2c:	0107b703          	ld	a4,16(a5)
    80001e30:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80001e34:	0107b703          	ld	a4,16(a5)
    80001e38:	00073703          	ld	a4,0(a4)
    80001e3c:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80001e40:	00000097          	auipc	ra,0x0
    80001e44:	e40080e7          	jalr	-448(ra) # 80001c80 <_ZN5Buddy8compressEm>
}
    80001e48:	00813083          	ld	ra,8(sp)
    80001e4c:	00013403          	ld	s0,0(sp)
    80001e50:	01010113          	addi	sp,sp,16
    80001e54:	00008067          	ret

0000000080001e58 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80001e58:	02050663          	beqz	a0,80001e84 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80001e5c:	ff010113          	addi	sp,sp,-16
    80001e60:	00113423          	sd	ra,8(sp)
    80001e64:	00813023          	sd	s0,0(sp)
    80001e68:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80001e6c:	00000097          	auipc	ra,0x0
    80001e70:	f0c080e7          	jalr	-244(ra) # 80001d78 <_ZN5Buddy6insertEPvm>
}
    80001e74:	00813083          	ld	ra,8(sp)
    80001e78:	00013403          	ld	s0,0(sp)
    80001e7c:	01010113          	addi	sp,sp,16
    80001e80:	00008067          	ret
    80001e84:	00008067          	ret

0000000080001e88 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001e88:	ff010113          	addi	sp,sp,-16
    80001e8c:	00813423          	sd	s0,8(sp)
    80001e90:	01010413          	addi	s0,sp,16
    80001e94:	03c0006f          	j	80001ed0 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001e98:	00b5859b          	addiw	a1,a1,11
    80001e9c:	00100713          	li	a4,1
    80001ea0:	00b715bb          	sllw	a1,a4,a1
    80001ea4:	00b505b3          	add	a1,a0,a1
    80001ea8:	00379693          	slli	a3,a5,0x3
    80001eac:	0000a717          	auipc	a4,0xa
    80001eb0:	d8c70713          	addi	a4,a4,-628 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001eb4:	00d70733          	add	a4,a4,a3
    80001eb8:	00b73823          	sd	a1,16(a4)
    80001ebc:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80001ec0:	0005b023          	sd	zero,0(a1)
    80001ec4:	07873703          	ld	a4,120(a4)
    80001ec8:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80001ecc:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80001ed0:	fff5879b          	addiw	a5,a1,-1
    80001ed4:	04c7c863          	blt	a5,a2,80001f24 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80001ed8:	00379693          	slli	a3,a5,0x3
    80001edc:	0000a717          	auipc	a4,0xa
    80001ee0:	d5c70713          	addi	a4,a4,-676 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ee4:	00d70733          	add	a4,a4,a3
    80001ee8:	01073683          	ld	a3,16(a4)
    80001eec:	fa0686e3          	beqz	a3,80001e98 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80001ef0:	00b5859b          	addiw	a1,a1,11
    80001ef4:	00100713          	li	a4,1
    80001ef8:	00b715bb          	sllw	a1,a4,a1
    80001efc:	00b505b3          	add	a1,a0,a1
    80001f00:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80001f04:	00379693          	slli	a3,a5,0x3
    80001f08:	0000a717          	auipc	a4,0xa
    80001f0c:	d3070713          	addi	a4,a4,-720 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f10:	00d70733          	add	a4,a4,a3
    80001f14:	01073683          	ld	a3,16(a4)
    80001f18:	0006b683          	ld	a3,0(a3)
    80001f1c:	00d73823          	sd	a3,16(a4)
    80001f20:	fadff06f          	j	80001ecc <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80001f24:	00813403          	ld	s0,8(sp)
    80001f28:	01010113          	addi	sp,sp,16
    80001f2c:	00008067          	ret

0000000080001f30 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80001f30:	fe010113          	addi	sp,sp,-32
    80001f34:	00113c23          	sd	ra,24(sp)
    80001f38:	00813823          	sd	s0,16(sp)
    80001f3c:	00913423          	sd	s1,8(sp)
    80001f40:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80001f44:	00c00793          	li	a5,12
    80001f48:	06a7ec63          	bltu	a5,a0,80001fc0 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001f4c:	00050593          	mv	a1,a0
    80001f50:	00c00793          	li	a5,12
    80001f54:	06b7ea63          	bltu	a5,a1,80001fc8 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80001f58:	00359713          	slli	a4,a1,0x3
    80001f5c:	0000a797          	auipc	a5,0xa
    80001f60:	cdc78793          	addi	a5,a5,-804 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f64:	00e787b3          	add	a5,a5,a4
    80001f68:	0787b483          	ld	s1,120(a5)
    80001f6c:	00049663          	bnez	s1,80001f78 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80001f70:	00158593          	addi	a1,a1,1
    80001f74:	fddff06f          	j	80001f50 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80001f78:	0004b703          	ld	a4,0(s1)
    80001f7c:	00359693          	slli	a3,a1,0x3
    80001f80:	0000a797          	auipc	a5,0xa
    80001f84:	cb878793          	addi	a5,a5,-840 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f88:	00d787b3          	add	a5,a5,a3
    80001f8c:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80001f90:	00070e63          	beqz	a4,80001fac <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80001f94:	0005061b          	sext.w	a2,a0
    80001f98:	0005859b          	sext.w	a1,a1
    80001f9c:	00048513          	mv	a0,s1
    80001fa0:	00000097          	auipc	ra,0x0
    80001fa4:	ee8080e7          	jalr	-280(ra) # 80001e88 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80001fa8:	0240006f          	j	80001fcc <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80001fac:	0000a797          	auipc	a5,0xa
    80001fb0:	c8c78793          	addi	a5,a5,-884 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001fb4:	00d787b3          	add	a5,a5,a3
    80001fb8:	0007b823          	sd	zero,16(a5)
    80001fbc:	fd9ff06f          	j	80001f94 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80001fc0:	00000493          	li	s1,0
    80001fc4:	0080006f          	j	80001fcc <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80001fc8:	00000493          	li	s1,0
}
    80001fcc:	00048513          	mv	a0,s1
    80001fd0:	01813083          	ld	ra,24(sp)
    80001fd4:	01013403          	ld	s0,16(sp)
    80001fd8:	00813483          	ld	s1,8(sp)
    80001fdc:	02010113          	addi	sp,sp,32
    80001fe0:	00008067          	ret

0000000080001fe4 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80001fe4:	fe010113          	addi	sp,sp,-32
    80001fe8:	00113c23          	sd	ra,24(sp)
    80001fec:	00813823          	sd	s0,16(sp)
    80001ff0:	00913423          	sd	s1,8(sp)
    80001ff4:	01213023          	sd	s2,0(sp)
    80001ff8:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80001ffc:	00000913          	li	s2,0
    80002000:	0180006f          	j	80002018 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002004:	00007517          	auipc	a0,0x7
    80002008:	19c50513          	addi	a0,a0,412 # 800091a0 <CONSOLE_STATUS+0x190>
    8000200c:	00002097          	auipc	ra,0x2
    80002010:	5d8080e7          	jalr	1496(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002014:	0019091b          	addiw	s2,s2,1
    80002018:	00c00793          	li	a5,12
    8000201c:	0727c663          	blt	a5,s2,80002088 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002020:	00000613          	li	a2,0
    80002024:	00a00593          	li	a1,10
    80002028:	00090513          	mv	a0,s2
    8000202c:	00002097          	auipc	ra,0x2
    80002030:	5fc080e7          	jalr	1532(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002034:	00007517          	auipc	a0,0x7
    80002038:	0e450513          	addi	a0,a0,228 # 80009118 <CONSOLE_STATUS+0x108>
    8000203c:	00002097          	auipc	ra,0x2
    80002040:	5a8080e7          	jalr	1448(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002044:	00391713          	slli	a4,s2,0x3
    80002048:	0000a797          	auipc	a5,0xa
    8000204c:	bf078793          	addi	a5,a5,-1040 # 8000bc38 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002050:	00e787b3          	add	a5,a5,a4
    80002054:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002058:	fa0486e3          	beqz	s1,80002004 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    8000205c:	00000613          	li	a2,0
    80002060:	00a00593          	li	a1,10
    80002064:	0004851b          	sext.w	a0,s1
    80002068:	00002097          	auipc	ra,0x2
    8000206c:	5c0080e7          	jalr	1472(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002070:	00007517          	auipc	a0,0x7
    80002074:	05050513          	addi	a0,a0,80 # 800090c0 <CONSOLE_STATUS+0xb0>
    80002078:	00002097          	auipc	ra,0x2
    8000207c:	56c080e7          	jalr	1388(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002080:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002084:	fd5ff06f          	j	80002058 <_ZN5Buddy9printListEv+0x74>
    80002088:	01813083          	ld	ra,24(sp)
    8000208c:	01013403          	ld	s0,16(sp)
    80002090:	00813483          	ld	s1,8(sp)
    80002094:	00013903          	ld	s2,0(sp)
    80002098:	02010113          	addi	sp,sp,32
    8000209c:	00008067          	ret

00000000800020a0 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    800020a0:	ff010113          	addi	sp,sp,-16
    800020a4:	00113423          	sd	ra,8(sp)
    800020a8:	00813023          	sd	s0,0(sp)
    800020ac:	01010413          	addi	s0,sp,16
    800020b0:	000105b7          	lui	a1,0x10
    800020b4:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800020b8:	00100513          	li	a0,1
    800020bc:	00000097          	auipc	ra,0x0
    800020c0:	a5c080e7          	jalr	-1444(ra) # 80001b18 <_Z41__static_initialization_and_destruction_0ii>
    800020c4:	00813083          	ld	ra,8(sp)
    800020c8:	00013403          	ld	s0,0(sp)
    800020cc:	01010113          	addi	sp,sp,16
    800020d0:	00008067          	ret

00000000800020d4 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800020d4:	fe010113          	addi	sp,sp,-32
    800020d8:	00113c23          	sd	ra,24(sp)
    800020dc:	00813823          	sd	s0,16(sp)
    800020e0:	00913423          	sd	s1,8(sp)
    800020e4:	02010413          	addi	s0,sp,32
    800020e8:	00050493          	mv	s1,a0
    LOCK();
    800020ec:	00100613          	li	a2,1
    800020f0:	00000593          	li	a1,0
    800020f4:	0000a517          	auipc	a0,0xa
    800020f8:	c2450513          	addi	a0,a0,-988 # 8000bd18 <lockPrint>
    800020fc:	fffff097          	auipc	ra,0xfffff
    80002100:	f04080e7          	jalr	-252(ra) # 80001000 <copy_and_swap>
    80002104:	fe0514e3          	bnez	a0,800020ec <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002108:	0004c503          	lbu	a0,0(s1)
    8000210c:	00050a63          	beqz	a0,80002120 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002110:	00000097          	auipc	ra,0x0
    80002114:	81c080e7          	jalr	-2020(ra) # 8000192c <_Z4putcc>
        string++;
    80002118:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000211c:	fedff06f          	j	80002108 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002120:	00000613          	li	a2,0
    80002124:	00100593          	li	a1,1
    80002128:	0000a517          	auipc	a0,0xa
    8000212c:	bf050513          	addi	a0,a0,-1040 # 8000bd18 <lockPrint>
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	ed0080e7          	jalr	-304(ra) # 80001000 <copy_and_swap>
    80002138:	fe0514e3          	bnez	a0,80002120 <_Z11printStringPKc+0x4c>
}
    8000213c:	01813083          	ld	ra,24(sp)
    80002140:	01013403          	ld	s0,16(sp)
    80002144:	00813483          	ld	s1,8(sp)
    80002148:	02010113          	addi	sp,sp,32
    8000214c:	00008067          	ret

0000000080002150 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002150:	fd010113          	addi	sp,sp,-48
    80002154:	02113423          	sd	ra,40(sp)
    80002158:	02813023          	sd	s0,32(sp)
    8000215c:	00913c23          	sd	s1,24(sp)
    80002160:	01213823          	sd	s2,16(sp)
    80002164:	01313423          	sd	s3,8(sp)
    80002168:	01413023          	sd	s4,0(sp)
    8000216c:	03010413          	addi	s0,sp,48
    80002170:	00050993          	mv	s3,a0
    80002174:	00058a13          	mv	s4,a1
    LOCK();
    80002178:	00100613          	li	a2,1
    8000217c:	00000593          	li	a1,0
    80002180:	0000a517          	auipc	a0,0xa
    80002184:	b9850513          	addi	a0,a0,-1128 # 8000bd18 <lockPrint>
    80002188:	fffff097          	auipc	ra,0xfffff
    8000218c:	e78080e7          	jalr	-392(ra) # 80001000 <copy_and_swap>
    80002190:	fe0514e3          	bnez	a0,80002178 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002194:	00000913          	li	s2,0
    80002198:	00090493          	mv	s1,s2
    8000219c:	0019091b          	addiw	s2,s2,1
    800021a0:	03495a63          	bge	s2,s4,800021d4 <_Z9getStringPci+0x84>
        cc = getc();
    800021a4:	fffff097          	auipc	ra,0xfffff
    800021a8:	760080e7          	jalr	1888(ra) # 80001904 <_Z4getcv>
        if(cc < 1)
    800021ac:	02050463          	beqz	a0,800021d4 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    800021b0:	009984b3          	add	s1,s3,s1
    800021b4:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800021b8:	00a00793          	li	a5,10
    800021bc:	00f50a63          	beq	a0,a5,800021d0 <_Z9getStringPci+0x80>
    800021c0:	00d00793          	li	a5,13
    800021c4:	fcf51ae3          	bne	a0,a5,80002198 <_Z9getStringPci+0x48>
        buf[i++] = c;
    800021c8:	00090493          	mv	s1,s2
    800021cc:	0080006f          	j	800021d4 <_Z9getStringPci+0x84>
    800021d0:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800021d4:	009984b3          	add	s1,s3,s1
    800021d8:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800021dc:	00000613          	li	a2,0
    800021e0:	00100593          	li	a1,1
    800021e4:	0000a517          	auipc	a0,0xa
    800021e8:	b3450513          	addi	a0,a0,-1228 # 8000bd18 <lockPrint>
    800021ec:	fffff097          	auipc	ra,0xfffff
    800021f0:	e14080e7          	jalr	-492(ra) # 80001000 <copy_and_swap>
    800021f4:	fe0514e3          	bnez	a0,800021dc <_Z9getStringPci+0x8c>
    return buf;
}
    800021f8:	00098513          	mv	a0,s3
    800021fc:	02813083          	ld	ra,40(sp)
    80002200:	02013403          	ld	s0,32(sp)
    80002204:	01813483          	ld	s1,24(sp)
    80002208:	01013903          	ld	s2,16(sp)
    8000220c:	00813983          	ld	s3,8(sp)
    80002210:	00013a03          	ld	s4,0(sp)
    80002214:	03010113          	addi	sp,sp,48
    80002218:	00008067          	ret

000000008000221c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000221c:	ff010113          	addi	sp,sp,-16
    80002220:	00813423          	sd	s0,8(sp)
    80002224:	01010413          	addi	s0,sp,16
    80002228:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000222c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002230:	0006c603          	lbu	a2,0(a3)
    80002234:	fd06071b          	addiw	a4,a2,-48
    80002238:	0ff77713          	andi	a4,a4,255
    8000223c:	00900793          	li	a5,9
    80002240:	02e7e063          	bltu	a5,a4,80002260 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002244:	0025179b          	slliw	a5,a0,0x2
    80002248:	00a787bb          	addw	a5,a5,a0
    8000224c:	0017979b          	slliw	a5,a5,0x1
    80002250:	00168693          	addi	a3,a3,1
    80002254:	00c787bb          	addw	a5,a5,a2
    80002258:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000225c:	fd5ff06f          	j	80002230 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002260:	00813403          	ld	s0,8(sp)
    80002264:	01010113          	addi	sp,sp,16
    80002268:	00008067          	ret

000000008000226c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000226c:	fc010113          	addi	sp,sp,-64
    80002270:	02113c23          	sd	ra,56(sp)
    80002274:	02813823          	sd	s0,48(sp)
    80002278:	02913423          	sd	s1,40(sp)
    8000227c:	03213023          	sd	s2,32(sp)
    80002280:	01313c23          	sd	s3,24(sp)
    80002284:	04010413          	addi	s0,sp,64
    80002288:	00050493          	mv	s1,a0
    8000228c:	00058913          	mv	s2,a1
    80002290:	00060993          	mv	s3,a2
    LOCK();
    80002294:	00100613          	li	a2,1
    80002298:	00000593          	li	a1,0
    8000229c:	0000a517          	auipc	a0,0xa
    800022a0:	a7c50513          	addi	a0,a0,-1412 # 8000bd18 <lockPrint>
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	d5c080e7          	jalr	-676(ra) # 80001000 <copy_and_swap>
    800022ac:	fe0514e3          	bnez	a0,80002294 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800022b0:	00098463          	beqz	s3,800022b8 <_Z8printIntiii+0x4c>
    800022b4:	0804c463          	bltz	s1,8000233c <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800022b8:	0004851b          	sext.w	a0,s1
    neg = 0;
    800022bc:	00000593          	li	a1,0
    }

    i = 0;
    800022c0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800022c4:	0009079b          	sext.w	a5,s2
    800022c8:	0325773b          	remuw	a4,a0,s2
    800022cc:	00048613          	mv	a2,s1
    800022d0:	0014849b          	addiw	s1,s1,1
    800022d4:	02071693          	slli	a3,a4,0x20
    800022d8:	0206d693          	srli	a3,a3,0x20
    800022dc:	00009717          	auipc	a4,0x9
    800022e0:	64c70713          	addi	a4,a4,1612 # 8000b928 <digits>
    800022e4:	00d70733          	add	a4,a4,a3
    800022e8:	00074683          	lbu	a3,0(a4)
    800022ec:	fd040713          	addi	a4,s0,-48
    800022f0:	00c70733          	add	a4,a4,a2
    800022f4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800022f8:	0005071b          	sext.w	a4,a0
    800022fc:	0325553b          	divuw	a0,a0,s2
    80002300:	fcf772e3          	bgeu	a4,a5,800022c4 <_Z8printIntiii+0x58>
    if(neg)
    80002304:	00058c63          	beqz	a1,8000231c <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002308:	fd040793          	addi	a5,s0,-48
    8000230c:	009784b3          	add	s1,a5,s1
    80002310:	02d00793          	li	a5,45
    80002314:	fef48823          	sb	a5,-16(s1)
    80002318:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000231c:	fff4849b          	addiw	s1,s1,-1
    80002320:	0204c463          	bltz	s1,80002348 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002324:	fd040793          	addi	a5,s0,-48
    80002328:	009787b3          	add	a5,a5,s1
    8000232c:	ff07c503          	lbu	a0,-16(a5)
    80002330:	fffff097          	auipc	ra,0xfffff
    80002334:	5fc080e7          	jalr	1532(ra) # 8000192c <_Z4putcc>
    80002338:	fe5ff06f          	j	8000231c <_Z8printIntiii+0xb0>
        x = -xx;
    8000233c:	4090053b          	negw	a0,s1
        neg = 1;
    80002340:	00100593          	li	a1,1
        x = -xx;
    80002344:	f7dff06f          	j	800022c0 <_Z8printIntiii+0x54>

    UNLOCK();
    80002348:	00000613          	li	a2,0
    8000234c:	00100593          	li	a1,1
    80002350:	0000a517          	auipc	a0,0xa
    80002354:	9c850513          	addi	a0,a0,-1592 # 8000bd18 <lockPrint>
    80002358:	fffff097          	auipc	ra,0xfffff
    8000235c:	ca8080e7          	jalr	-856(ra) # 80001000 <copy_and_swap>
    80002360:	fe0514e3          	bnez	a0,80002348 <_Z8printIntiii+0xdc>
    80002364:	03813083          	ld	ra,56(sp)
    80002368:	03013403          	ld	s0,48(sp)
    8000236c:	02813483          	ld	s1,40(sp)
    80002370:	02013903          	ld	s2,32(sp)
    80002374:	01813983          	ld	s3,24(sp)
    80002378:	04010113          	addi	sp,sp,64
    8000237c:	00008067          	ret

0000000080002380 <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80002380:	ff010113          	addi	sp,sp,-16
    80002384:	00813423          	sd	s0,8(sp)
    80002388:	01010413          	addi	s0,sp,16
    val = init;
    8000238c:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80002390:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    80002394:	00053823          	sd	zero,16(a0)
}
    80002398:	00813403          	ld	s0,8(sp)
    8000239c:	01010113          	addi	sp,sp,16
    800023a0:	00008067          	ret

00000000800023a4 <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    800023a4:	fe010113          	addi	sp,sp,-32
    800023a8:	00113c23          	sd	ra,24(sp)
    800023ac:	00813823          	sd	s0,16(sp)
    800023b0:	00913423          	sd	s1,8(sp)
    800023b4:	01213023          	sd	s2,0(sp)
    800023b8:	02010413          	addi	s0,sp,32
    800023bc:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    800023c0:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    800023c4:	02050063          	beqz	a0,800023e4 <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    800023c8:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    800023cc:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    800023d0:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    800023d4:	00002097          	auipc	ra,0x2
    800023d8:	d8c080e7          	jalr	-628(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    800023dc:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    800023e0:	fe5ff06f          	j	800023c4 <_ZN3SCBD1Ev+0x20>
    }
}
    800023e4:	01813083          	ld	ra,24(sp)
    800023e8:	01013403          	ld	s0,16(sp)
    800023ec:	00813483          	ld	s1,8(sp)
    800023f0:	00013903          	ld	s2,0(sp)
    800023f4:	02010113          	addi	sp,sp,32
    800023f8:	00008067          	ret

00000000800023fc <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    800023fc:	ff010113          	addi	sp,sp,-16
    80002400:	00113423          	sd	ra,8(sp)
    80002404:	00813023          	sd	s0,0(sp)
    80002408:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    8000240c:	00853783          	ld	a5,8(a0)
    80002410:	04078063          	beqz	a5,80002450 <_ZN3SCB5blockEv+0x54>
    80002414:	01053703          	ld	a4,16(a0)
    80002418:	00009797          	auipc	a5,0x9
    8000241c:	7287b783          	ld	a5,1832(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002420:	0007b783          	ld	a5,0(a5)
    80002424:	04f73423          	sd	a5,72(a4)
    80002428:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    8000242c:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002430:	00300713          	li	a4,3
    80002434:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002438:	00000097          	auipc	ra,0x0
    8000243c:	2c0080e7          	jalr	704(ra) # 800026f8 <_ZN3TCB8dispatchEv>
}
    80002440:	00813083          	ld	ra,8(sp)
    80002444:	00013403          	ld	s0,0(sp)
    80002448:	01010113          	addi	sp,sp,16
    8000244c:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002450:	00009797          	auipc	a5,0x9
    80002454:	6f07b783          	ld	a5,1776(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002458:	0007b783          	ld	a5,0(a5)
    8000245c:	00f53423          	sd	a5,8(a0)
    80002460:	fc9ff06f          	j	80002428 <_ZN3SCB5blockEv+0x2c>

0000000080002464 <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80002464:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002468:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    8000246c:	04853703          	ld	a4,72(a0)
    80002470:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002474:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002478:	02050a63          	beqz	a0,800024ac <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    8000247c:	ff010113          	addi	sp,sp,-16
    80002480:	00113423          	sd	ra,8(sp)
    80002484:	00813023          	sd	s0,0(sp)
    80002488:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    8000248c:	00100793          	li	a5,1
    80002490:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002494:	00002097          	auipc	ra,0x2
    80002498:	ccc080e7          	jalr	-820(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
    }
}
    8000249c:	00813083          	ld	ra,8(sp)
    800024a0:	00013403          	ld	s0,0(sp)
    800024a4:	01010113          	addi	sp,sp,16
    800024a8:	00008067          	ret
    800024ac:	00008067          	ret

00000000800024b0 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    800024b0:	00009797          	auipc	a5,0x9
    800024b4:	6907b783          	ld	a5,1680(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800024b8:	0007b783          	ld	a5,0(a5)
    800024bc:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    800024c0:	00052783          	lw	a5,0(a0)
    800024c4:	fff7879b          	addiw	a5,a5,-1
    800024c8:	00f52023          	sw	a5,0(a0)
    800024cc:	02079713          	slli	a4,a5,0x20
    800024d0:	00074463          	bltz	a4,800024d8 <_ZN3SCB4waitEv+0x28>
    800024d4:	00008067          	ret
void SCB::wait() {
    800024d8:	ff010113          	addi	sp,sp,-16
    800024dc:	00113423          	sd	ra,8(sp)
    800024e0:	00813023          	sd	s0,0(sp)
    800024e4:	01010413          	addi	s0,sp,16
        block();
    800024e8:	00000097          	auipc	ra,0x0
    800024ec:	f14080e7          	jalr	-236(ra) # 800023fc <_ZN3SCB5blockEv>
}
    800024f0:	00813083          	ld	ra,8(sp)
    800024f4:	00013403          	ld	s0,0(sp)
    800024f8:	01010113          	addi	sp,sp,16
    800024fc:	00008067          	ret

0000000080002500 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80002500:	00052783          	lw	a5,0(a0)
    80002504:	0017871b          	addiw	a4,a5,1
    80002508:	00e52023          	sw	a4,0(a0)
    8000250c:	0007c463          	bltz	a5,80002514 <_ZN3SCB6signalEv+0x14>
    80002510:	00008067          	ret
void SCB::signal(){
    80002514:	ff010113          	addi	sp,sp,-16
    80002518:	00113423          	sd	ra,8(sp)
    8000251c:	00813023          	sd	s0,0(sp)
    80002520:	01010413          	addi	s0,sp,16
        deblock();
    80002524:	00000097          	auipc	ra,0x0
    80002528:	f40080e7          	jalr	-192(ra) # 80002464 <_ZN3SCB7deblockEv>
}
    8000252c:	00813083          	ld	ra,8(sp)
    80002530:	00013403          	ld	s0,0(sp)
    80002534:	01010113          	addi	sp,sp,16
    80002538:	00008067          	ret

000000008000253c <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    8000253c:	ff010113          	addi	sp,sp,-16
    80002540:	00113423          	sd	ra,8(sp)
    80002544:	00813023          	sd	s0,0(sp)
    80002548:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    8000254c:	00000097          	auipc	ra,0x0
    80002550:	3f4080e7          	jalr	1012(ra) # 80002940 <_ZN15MemoryAllocator7kmallocEm>
}
    80002554:	00813083          	ld	ra,8(sp)
    80002558:	00013403          	ld	s0,0(sp)
    8000255c:	01010113          	addi	sp,sp,16
    80002560:	00008067          	ret

0000000080002564 <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    80002564:	ff010113          	addi	sp,sp,-16
    80002568:	00113423          	sd	ra,8(sp)
    8000256c:	00813023          	sd	s0,0(sp)
    80002570:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002574:	00000097          	auipc	ra,0x0
    80002578:	5f4080e7          	jalr	1524(ra) # 80002b68 <_ZN15MemoryAllocator5kfreeEPv>
}
    8000257c:	00813083          	ld	ra,8(sp)
    80002580:	00013403          	ld	s0,0(sp)
    80002584:	01010113          	addi	sp,sp,16
    80002588:	00008067          	ret

000000008000258c <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    8000258c:	ff010113          	addi	sp,sp,-16
    80002590:	00813423          	sd	s0,8(sp)
    80002594:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002598:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    8000259c:	05200513          	li	a0,82
    asm("ecall");
    800025a0:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    800025a4:	00050513          	mv	a0,a0
    return status;
}
    800025a8:	0005051b          	sext.w	a0,a0
    800025ac:	00813403          	ld	s0,8(sp)
    800025b0:	01010113          	addi	sp,sp,16
    800025b4:	00008067          	ret

00000000800025b8 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    800025b8:	fe010113          	addi	sp,sp,-32
    800025bc:	00113c23          	sd	ra,24(sp)
    800025c0:	00813823          	sd	s0,16(sp)
    800025c4:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    800025c8:	fe840513          	addi	a0,s0,-24
    800025cc:	fffff097          	auipc	ra,0xfffff
    800025d0:	424080e7          	jalr	1060(ra) # 800019f0 <_ZN6SystemC1Ev>

    return 0;
    800025d4:	00000513          	li	a0,0
    800025d8:	01813083          	ld	ra,24(sp)
    800025dc:	01013403          	ld	s0,16(sp)
    800025e0:	02010113          	addi	sp,sp,32
    800025e4:	00008067          	ret

00000000800025e8 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    800025e8:	ff010113          	addi	sp,sp,-16
    800025ec:	00113423          	sd	ra,8(sp)
    800025f0:	00813023          	sd	s0,0(sp)
    800025f4:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    800025f8:	00001097          	auipc	ra,0x1
    800025fc:	cbc080e7          	jalr	-836(ra) # 800032b4 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    80002600:	00009797          	auipc	a5,0x9
    80002604:	7207b783          	ld	a5,1824(a5) # 8000bd20 <_ZN3TCB7runningE>
    80002608:	0187b703          	ld	a4,24(a5)
    8000260c:	0207b503          	ld	a0,32(a5)
    80002610:	000700e7          	jalr	a4

    thread_exit();
    80002614:	fffff097          	auipc	ra,0xfffff
    80002618:	118080e7          	jalr	280(ra) # 8000172c <_Z11thread_exitv>
}
    8000261c:	00813083          	ld	ra,8(sp)
    80002620:	00013403          	ld	s0,0(sp)
    80002624:	01010113          	addi	sp,sp,16
    80002628:	00008067          	ret

000000008000262c <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    8000262c:	ff010113          	addi	sp,sp,-16
    80002630:	00813423          	sd	s0,8(sp)
    80002634:	01010413          	addi	s0,sp,16
    80002638:	04053823          	sd	zero,80(a0)
    8000263c:	04053c23          	sd	zero,88(a0)
    80002640:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002644:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002648:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    8000264c:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002650:	04058263          	beqz	a1,80002694 <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    80002654:	00068793          	mv	a5,a3
    80002658:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    8000265c:	00100793          	li	a5,1
    80002660:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    80002664:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002668:	02058a63          	beqz	a1,8000269c <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    8000266c:	000017b7          	lui	a5,0x1
    80002670:	00f686b3          	add	a3,a3,a5
    80002674:	00d53023          	sd	a3,0(a0)
    80002678:	00000797          	auipc	a5,0x0
    8000267c:	f7078793          	addi	a5,a5,-144 # 800025e8 <_ZN3TCB7wrapperEPv>
    80002680:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002684:	00052a23          	sw	zero,20(a0)
}
    80002688:	00813403          	ld	s0,8(sp)
    8000268c:	01010113          	addi	sp,sp,16
    80002690:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002694:	00000793          	li	a5,0
    80002698:	fc1ff06f          	j	80002658 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    8000269c:	00000693          	li	a3,0
    800026a0:	fd5ff06f          	j	80002674 <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

00000000800026a4 <_ZN3TCB4freeEv>:
void TCB::free(){
    800026a4:	ff010113          	addi	sp,sp,-16
    800026a8:	00113423          	sd	ra,8(sp)
    800026ac:	00813023          	sd	s0,0(sp)
    800026b0:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    800026b4:	02853503          	ld	a0,40(a0)
    800026b8:	00000097          	auipc	ra,0x0
    800026bc:	4b0080e7          	jalr	1200(ra) # 80002b68 <_ZN15MemoryAllocator5kfreeEPv>
}
    800026c0:	00813083          	ld	ra,8(sp)
    800026c4:	00013403          	ld	s0,0(sp)
    800026c8:	01010113          	addi	sp,sp,16
    800026cc:	00008067          	ret

00000000800026d0 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    800026d0:	ff010113          	addi	sp,sp,-16
    800026d4:	00113423          	sd	ra,8(sp)
    800026d8:	00813023          	sd	s0,0(sp)
    800026dc:	01010413          	addi	s0,sp,16
    free();
    800026e0:	00000097          	auipc	ra,0x0
    800026e4:	fc4080e7          	jalr	-60(ra) # 800026a4 <_ZN3TCB4freeEv>
}
    800026e8:	00813083          	ld	ra,8(sp)
    800026ec:	00013403          	ld	s0,0(sp)
    800026f0:	01010113          	addi	sp,sp,16
    800026f4:	00008067          	ret

00000000800026f8 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800026f8:	fe010113          	addi	sp,sp,-32
    800026fc:	00113c23          	sd	ra,24(sp)
    80002700:	00813823          	sd	s0,16(sp)
    80002704:	00913423          	sd	s1,8(sp)
    80002708:	02010413          	addi	s0,sp,32
    TCB* old = running;
    8000270c:	00009497          	auipc	s1,0x9
    80002710:	6144b483          	ld	s1,1556(s1) # 8000bd20 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002714:	0104a703          	lw	a4,16(s1)
    80002718:	00100793          	li	a5,1
    8000271c:	04e7f663          	bgeu	a5,a4,80002768 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002720:	00002097          	auipc	ra,0x2
    80002724:	a88080e7          	jalr	-1400(ra) # 800041a8 <_ZN9Scheduler3getEv>
    80002728:	00009797          	auipc	a5,0x9
    8000272c:	5ea7bc23          	sd	a0,1528(a5) # 8000bd20 <_ZN3TCB7runningE>
    if(running) {
    80002730:	02050263          	beqz	a0,80002754 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002734:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002738:	00001097          	auipc	ra,0x1
    8000273c:	cb0080e7          	jalr	-848(ra) # 800033e8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002740:	00009597          	auipc	a1,0x9
    80002744:	5e05b583          	ld	a1,1504(a1) # 8000bd20 <_ZN3TCB7runningE>
    80002748:	00048513          	mv	a0,s1
    8000274c:	fffff097          	auipc	ra,0xfffff
    80002750:	9f4080e7          	jalr	-1548(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002754:	01813083          	ld	ra,24(sp)
    80002758:	01013403          	ld	s0,16(sp)
    8000275c:	00813483          	ld	s1,8(sp)
    80002760:	02010113          	addi	sp,sp,32
    80002764:	00008067          	ret
        Scheduler::put(old);
    80002768:	00048513          	mv	a0,s1
    8000276c:	00002097          	auipc	ra,0x2
    80002770:	9f4080e7          	jalr	-1548(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
    80002774:	fadff06f          	j	80002720 <_ZN3TCB8dispatchEv+0x28>

0000000080002778 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002778:	ff010113          	addi	sp,sp,-16
    8000277c:	00113423          	sd	ra,8(sp)
    80002780:	00813023          	sd	s0,0(sp)
    80002784:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002788:	00000097          	auipc	ra,0x0
    8000278c:	1b8080e7          	jalr	440(ra) # 80002940 <_ZN15MemoryAllocator7kmallocEm>
}
    80002790:	00813083          	ld	ra,8(sp)
    80002794:	00013403          	ld	s0,0(sp)
    80002798:	01010113          	addi	sp,sp,16
    8000279c:	00008067          	ret

00000000800027a0 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    800027a0:	fd010113          	addi	sp,sp,-48
    800027a4:	02113423          	sd	ra,40(sp)
    800027a8:	02813023          	sd	s0,32(sp)
    800027ac:	00913c23          	sd	s1,24(sp)
    800027b0:	01213823          	sd	s2,16(sp)
    800027b4:	01313423          	sd	s3,8(sp)
    800027b8:	01413023          	sd	s4,0(sp)
    800027bc:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    800027c0:	07000513          	li	a0,112
    800027c4:	00000097          	auipc	ra,0x0
    800027c8:	fb4080e7          	jalr	-76(ra) # 80002778 <_ZN3TCBnwEm>
    800027cc:	00050493          	mv	s1,a0
    800027d0:	00200713          	li	a4,2
    800027d4:	00000693          	li	a3,0
    800027d8:	00000613          	li	a2,0
    800027dc:	00000593          	li	a1,0
    800027e0:	00000097          	auipc	ra,0x0
    800027e4:	e4c080e7          	jalr	-436(ra) # 8000262c <_ZN3TCBC1EPFvPvES0_Pmm>
    800027e8:	00009a17          	auipc	s4,0x9
    800027ec:	538a0a13          	addi	s4,s4,1336 # 8000bd20 <_ZN3TCB7runningE>
    800027f0:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    800027f4:	00100993          	li	s3,1
    800027f8:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800027fc:	04000513          	li	a0,64
    80002800:	00000097          	auipc	ra,0x0
    80002804:	140080e7          	jalr	320(ra) # 80002940 <_ZN15MemoryAllocator7kmallocEm>
    80002808:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    8000280c:	07000513          	li	a0,112
    80002810:	00000097          	auipc	ra,0x0
    80002814:	f68080e7          	jalr	-152(ra) # 80002778 <_ZN3TCBnwEm>
    80002818:	00050493          	mv	s1,a0
    8000281c:	00200713          	li	a4,2
    80002820:	00090693          	mv	a3,s2
    80002824:	00000613          	li	a2,0
    80002828:	00009597          	auipc	a1,0x9
    8000282c:	2b05b583          	ld	a1,688(a1) # 8000bad8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002830:	00000097          	auipc	ra,0x0
    80002834:	dfc080e7          	jalr	-516(ra) # 8000262c <_ZN3TCBC1EPFvPvES0_Pmm>
    80002838:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    8000283c:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    80002840:	00048513          	mv	a0,s1
    80002844:	00002097          	auipc	ra,0x2
    80002848:	91c080e7          	jalr	-1764(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
}
    8000284c:	02813083          	ld	ra,40(sp)
    80002850:	02013403          	ld	s0,32(sp)
    80002854:	01813483          	ld	s1,24(sp)
    80002858:	01013903          	ld	s2,16(sp)
    8000285c:	00813983          	ld	s3,8(sp)
    80002860:	00013a03          	ld	s4,0(sp)
    80002864:	03010113          	addi	sp,sp,48
    80002868:	00008067          	ret

000000008000286c <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    8000286c:	ff010113          	addi	sp,sp,-16
    80002870:	00113423          	sd	ra,8(sp)
    80002874:	00813023          	sd	s0,0(sp)
    80002878:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    8000287c:	00000097          	auipc	ra,0x0
    80002880:	2ec080e7          	jalr	748(ra) # 80002b68 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002884:	00813083          	ld	ra,8(sp)
    80002888:	00013403          	ld	s0,0(sp)
    8000288c:	01010113          	addi	sp,sp,16
    80002890:	00008067          	ret

0000000080002894 <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80002894:	ff010113          	addi	sp,sp,-16
    80002898:	00813423          	sd	s0,8(sp)
    8000289c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    800028a0:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    800028a4:	05100513          	li	a0,81
    asm("ecall");
    800028a8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800028ac:	00050513          	mv	a0,a0
    return status;
    800028b0:	0005051b          	sext.w	a0,a0
    800028b4:	00813403          	ld	s0,8(sp)
    800028b8:	01010113          	addi	sp,sp,16
    800028bc:	00008067          	ret

00000000800028c0 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    800028c0:	ff010113          	addi	sp,sp,-16
    800028c4:	00813423          	sd	s0,8(sp)
    800028c8:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    800028cc:	00009797          	auipc	a5,0x9
    800028d0:	1fc7b783          	ld	a5,508(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800028d4:	0007b603          	ld	a2,0(a5)
    800028d8:	00c65793          	srli	a5,a2,0xc
    800028dc:	00278793          	addi	a5,a5,2
    800028e0:	00c79793          	slli	a5,a5,0xc
    800028e4:	01000737          	lui	a4,0x1000
    800028e8:	00e787b3          	add	a5,a5,a4
    800028ec:	00009717          	auipc	a4,0x9
    800028f0:	45c70713          	addi	a4,a4,1116 # 8000bd48 <_ZN15MemoryAllocator11freeMemTailE>
    800028f4:	00f73023          	sd	a5,0(a4)
    800028f8:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    800028fc:	0007b823          	sd	zero,16(a5)
    80002900:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002904:	00073823          	sd	zero,16(a4)
    80002908:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    8000290c:	00009697          	auipc	a3,0x9
    80002910:	2446b683          	ld	a3,580(a3) # 8000bb50 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002914:	0006b683          	ld	a3,0(a3)
    80002918:	40c686b3          	sub	a3,a3,a2
    8000291c:	fe868693          	addi	a3,a3,-24
    80002920:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002924:	00873783          	ld	a5,8(a4)
    80002928:	0007b823          	sd	zero,16(a5)

    initialized = true;
    8000292c:	00100793          	li	a5,1
    80002930:	02f70023          	sb	a5,32(a4)
}
    80002934:	00813403          	ld	s0,8(sp)
    80002938:	01010113          	addi	sp,sp,16
    8000293c:	00008067          	ret

0000000080002940 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002940:	ff010113          	addi	sp,sp,-16
    80002944:	00813423          	sd	s0,8(sp)
    80002948:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    8000294c:	14050263          	beqz	a0,80002a90 <_ZN15MemoryAllocator7kmallocEm+0x150>
    80002950:	00050793          	mv	a5,a0
    80002954:	00009517          	auipc	a0,0x9
    80002958:	3fc53503          	ld	a0,1020(a0) # 8000bd50 <_ZN15MemoryAllocator11freeMemHeadE>
    8000295c:	0a050a63          	beqz	a0,80002a10 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002960:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002964:	00000613          	li	a2,0
    80002968:	00c0006f          	j	80002974 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    8000296c:	00050613          	mv	a2,a0
    80002970:	01053503          	ld	a0,16(a0)
    80002974:	00050863          	beqz	a0,80002984 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002978:	00053683          	ld	a3,0(a0)
    8000297c:	01878713          	addi	a4,a5,24
    80002980:	fee6e6e3          	bltu	a3,a4,8000296c <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002984:	08050663          	beqz	a0,80002a10 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80002988:	00053683          	ld	a3,0(a0)
    8000298c:	01868713          	addi	a4,a3,24
    80002990:	00e50733          	add	a4,a0,a4
    80002994:	00009597          	auipc	a1,0x9
    80002998:	1bc5b583          	ld	a1,444(a1) # 8000bb50 <_GLOBAL_OFFSET_TABLE_+0xa0>
    8000299c:	0005b583          	ld	a1,0(a1)
    800029a0:	00b76463          	bltu	a4,a1,800029a8 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    800029a4:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    800029a8:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    800029ac:	05700593          	li	a1,87
    800029b0:	08d5f063          	bgeu	a1,a3,80002a30 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    800029b4:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    800029b8:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    800029bc:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    800029c0:	01053583          	ld	a1,16(a0)
    800029c4:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    800029c8:	00853583          	ld	a1,8(a0)
    800029cc:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    800029d0:	fe868693          	addi	a3,a3,-24
    800029d4:	00d7b023          	sd	a3,0(a5)

            if(prev)
    800029d8:	04060263          	beqz	a2,80002a1c <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    800029dc:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    800029e0:	00009797          	auipc	a5,0x9
    800029e4:	3807b783          	ld	a5,896(a5) # 8000bd60 <_ZN15MemoryAllocator12allocMemHeadE>
    800029e8:	06078463          	beqz	a5,80002a50 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    800029ec:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    800029f0:	08070063          	beqz	a4,80002a70 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    800029f4:	00873783          	ld	a5,8(a4)
    800029f8:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    800029fc:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80002a00:	00873783          	ld	a5,8(a4)
    80002a04:	06078063          	beqz	a5,80002a64 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    80002a08:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80002a0c:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80002a10:	00813403          	ld	s0,8(sp)
    80002a14:	01010113          	addi	sp,sp,16
    80002a18:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80002a1c:	00009697          	auipc	a3,0x9
    80002a20:	32c68693          	addi	a3,a3,812 # 8000bd48 <_ZN15MemoryAllocator11freeMemTailE>
    80002a24:	00f6b023          	sd	a5,0(a3)
    80002a28:	00f6b423          	sd	a5,8(a3)
    80002a2c:	fb5ff06f          	j	800029e0 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    80002a30:	00060863          	beqz	a2,80002a40 <_ZN15MemoryAllocator7kmallocEm+0x100>
    80002a34:	01053783          	ld	a5,16(a0)
    80002a38:	00f63823          	sd	a5,16(a2)
    80002a3c:	fa5ff06f          	j	800029e0 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    80002a40:	01053783          	ld	a5,16(a0)
    80002a44:	00009697          	auipc	a3,0x9
    80002a48:	30f6b623          	sd	a5,780(a3) # 8000bd50 <_ZN15MemoryAllocator11freeMemHeadE>
    80002a4c:	f95ff06f          	j	800029e0 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    80002a50:	00009797          	auipc	a5,0x9
    80002a54:	2f878793          	addi	a5,a5,760 # 8000bd48 <_ZN15MemoryAllocator11freeMemTailE>
    80002a58:	00a7b823          	sd	a0,16(a5)
    80002a5c:	00a7bc23          	sd	a0,24(a5)
    80002a60:	fadff06f          	j	80002a0c <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    80002a64:	00009797          	auipc	a5,0x9
    80002a68:	2ea7be23          	sd	a0,764(a5) # 8000bd60 <_ZN15MemoryAllocator12allocMemHeadE>
    80002a6c:	fa1ff06f          	j	80002a0c <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    80002a70:	00009797          	auipc	a5,0x9
    80002a74:	2d878793          	addi	a5,a5,728 # 8000bd48 <_ZN15MemoryAllocator11freeMemTailE>
    80002a78:	0107b703          	ld	a4,16(a5)
    80002a7c:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002a80:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002a84:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002a88:	00a7b823          	sd	a0,16(a5)
    80002a8c:	f81ff06f          	j	80002a0c <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80002a90:	00000513          	li	a0,0
    80002a94:	f7dff06f          	j	80002a10 <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080002a98 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002a98:	ff010113          	addi	sp,sp,-16
    80002a9c:	00813423          	sd	s0,8(sp)
    80002aa0:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002aa4:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002aa8:	00000713          	li	a4,0
    80002aac:	00078a63          	beqz	a5,80002ac0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002ab0:	00a7f863          	bgeu	a5,a0,80002ac0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002ab4:	00078713          	mv	a4,a5
    80002ab8:	0107b783          	ld	a5,16(a5)
    80002abc:	ff1ff06f          	j	80002aac <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80002ac0:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002ac4:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002ac8:	00078463          	beqz	a5,80002ad0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002acc:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80002ad0:	02070263          	beqz	a4,80002af4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002ad4:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002ad8:	0005b703          	ld	a4,0(a1)
    80002adc:	00009797          	auipc	a5,0x9
    80002ae0:	2747b783          	ld	a5,628(a5) # 8000bd50 <_ZN15MemoryAllocator11freeMemHeadE>
    80002ae4:	00f70c63          	beq	a4,a5,80002afc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002ae8:	00813403          	ld	s0,8(sp)
    80002aec:	01010113          	addi	sp,sp,16
    80002af0:	00008067          	ret
        *head = blk;
    80002af4:	00a5b023          	sd	a0,0(a1)
    80002af8:	fe1ff06f          	j	80002ad8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002afc:	01053783          	ld	a5,16(a0)
    80002b00:	00078a63          	beqz	a5,80002b14 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002b04:	00053683          	ld	a3,0(a0)
    80002b08:	00d50733          	add	a4,a0,a3
    80002b0c:	01870713          	addi	a4,a4,24
    80002b10:	02f70e63          	beq	a4,a5,80002b4c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80002b14:	00853783          	ld	a5,8(a0)
    80002b18:	fc0788e3          	beqz	a5,80002ae8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002b1c:	0007b683          	ld	a3,0(a5)
    80002b20:	00d78733          	add	a4,a5,a3
    80002b24:	01870713          	addi	a4,a4,24
    80002b28:	fca710e3          	bne	a4,a0,80002ae8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002b2c:	00053703          	ld	a4,0(a0)
    80002b30:	00e68733          	add	a4,a3,a4
    80002b34:	01870713          	addi	a4,a4,24
    80002b38:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002b3c:	00853783          	ld	a5,8(a0)
    80002b40:	01053703          	ld	a4,16(a0)
    80002b44:	00e7b823          	sd	a4,16(a5)
}
    80002b48:	fa1ff06f          	j	80002ae8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80002b4c:	0007b703          	ld	a4,0(a5)
    80002b50:	00e68733          	add	a4,a3,a4
    80002b54:	01870713          	addi	a4,a4,24
    80002b58:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80002b5c:	0107b783          	ld	a5,16(a5)
    80002b60:	00f53823          	sd	a5,16(a0)
    80002b64:	fb1ff06f          	j	80002b14 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002b68 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002b68:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002b6c:	00009697          	auipc	a3,0x9
    80002b70:	1f46b683          	ld	a3,500(a3) # 8000bd60 <_ZN15MemoryAllocator12allocMemHeadE>
    80002b74:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002b78:	00050a63          	beqz	a0,80002b8c <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002b7c:	fe870793          	addi	a5,a4,-24
    80002b80:	00a78663          	beq	a5,a0,80002b8c <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002b84:	01053503          	ld	a0,16(a0)
    80002b88:	ff1ff06f          	j	80002b78 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002b8c:	08050463          	beqz	a0,80002c14 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80002b90:	ff010113          	addi	sp,sp,-16
    80002b94:	00113423          	sd	ra,8(sp)
    80002b98:	00813023          	sd	s0,0(sp)
    80002b9c:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80002ba0:	00009797          	auipc	a5,0x9
    80002ba4:	1b87b783          	ld	a5,440(a5) # 8000bd58 <_ZN15MemoryAllocator12allocMemTailE>
    80002ba8:	04a78663          	beq	a5,a0,80002bf4 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002bac:	04d50c63          	beq	a0,a3,80002c04 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002bb0:	01053783          	ld	a5,16(a0)
    80002bb4:	00078663          	beqz	a5,80002bc0 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002bb8:	00853703          	ld	a4,8(a0)
    80002bbc:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80002bc0:	00853783          	ld	a5,8(a0)
    80002bc4:	00078663          	beqz	a5,80002bd0 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002bc8:	01053703          	ld	a4,16(a0)
    80002bcc:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80002bd0:	00009597          	auipc	a1,0x9
    80002bd4:	18058593          	addi	a1,a1,384 # 8000bd50 <_ZN15MemoryAllocator11freeMemHeadE>
    80002bd8:	00000097          	auipc	ra,0x0
    80002bdc:	ec0080e7          	jalr	-320(ra) # 80002a98 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80002be0:	00000513          	li	a0,0
}
    80002be4:	00813083          	ld	ra,8(sp)
    80002be8:	00013403          	ld	s0,0(sp)
    80002bec:	01010113          	addi	sp,sp,16
    80002bf0:	00008067          	ret
            allocMemTail = blk->prev;
    80002bf4:	00853783          	ld	a5,8(a0)
    80002bf8:	00009717          	auipc	a4,0x9
    80002bfc:	16f73023          	sd	a5,352(a4) # 8000bd58 <_ZN15MemoryAllocator12allocMemTailE>
    80002c00:	fadff06f          	j	80002bac <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002c04:	01053783          	ld	a5,16(a0)
    80002c08:	00009717          	auipc	a4,0x9
    80002c0c:	14f73c23          	sd	a5,344(a4) # 8000bd60 <_ZN15MemoryAllocator12allocMemHeadE>
    80002c10:	fa1ff06f          	j	80002bb0 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80002c14:	fff00513          	li	a0,-1
}
    80002c18:	00008067          	ret

0000000080002c1c <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002c1c:	fe010113          	addi	sp,sp,-32
    80002c20:	00113c23          	sd	ra,24(sp)
    80002c24:	00813823          	sd	s0,16(sp)
    80002c28:	00913423          	sd	s1,8(sp)
    80002c2c:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002c30:	00009497          	auipc	s1,0x9
    80002c34:	1304b483          	ld	s1,304(s1) # 8000bd60 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002c38:	00006517          	auipc	a0,0x6
    80002c3c:	4e850513          	addi	a0,a0,1256 # 80009120 <CONSOLE_STATUS+0x110>
    80002c40:	fffff097          	auipc	ra,0xfffff
    80002c44:	494080e7          	jalr	1172(ra) # 800020d4 <_Z11printStringPKc>
    while(iter!=nullptr){
    80002c48:	04048663          	beqz	s1,80002c94 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002c4c:	00000613          	li	a2,0
    80002c50:	00a00593          	li	a1,10
    80002c54:	0004851b          	sext.w	a0,s1
    80002c58:	fffff097          	auipc	ra,0xfffff
    80002c5c:	614080e7          	jalr	1556(ra) # 8000226c <_Z8printIntiii>
        putc(' ');
    80002c60:	02000513          	li	a0,32
    80002c64:	fffff097          	auipc	ra,0xfffff
    80002c68:	cc8080e7          	jalr	-824(ra) # 8000192c <_Z4putcc>
        printInt(iter->size);
    80002c6c:	00000613          	li	a2,0
    80002c70:	00a00593          	li	a1,10
    80002c74:	0004a503          	lw	a0,0(s1)
    80002c78:	fffff097          	auipc	ra,0xfffff
    80002c7c:	5f4080e7          	jalr	1524(ra) # 8000226c <_Z8printIntiii>
        putc('\n');
    80002c80:	00a00513          	li	a0,10
    80002c84:	fffff097          	auipc	ra,0xfffff
    80002c88:	ca8080e7          	jalr	-856(ra) # 8000192c <_Z4putcc>
        iter=iter->next;
    80002c8c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002c90:	fb9ff06f          	j	80002c48 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002c94:	00006517          	auipc	a0,0x6
    80002c98:	4ac50513          	addi	a0,a0,1196 # 80009140 <CONSOLE_STATUS+0x130>
    80002c9c:	fffff097          	auipc	ra,0xfffff
    80002ca0:	438080e7          	jalr	1080(ra) # 800020d4 <_Z11printStringPKc>
    iter = freeMemHead;
    80002ca4:	00009497          	auipc	s1,0x9
    80002ca8:	0ac4b483          	ld	s1,172(s1) # 8000bd50 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002cac:	04048663          	beqz	s1,80002cf8 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002cb0:	00000613          	li	a2,0
    80002cb4:	00a00593          	li	a1,10
    80002cb8:	0004851b          	sext.w	a0,s1
    80002cbc:	fffff097          	auipc	ra,0xfffff
    80002cc0:	5b0080e7          	jalr	1456(ra) # 8000226c <_Z8printIntiii>
        putc(' ');
    80002cc4:	02000513          	li	a0,32
    80002cc8:	fffff097          	auipc	ra,0xfffff
    80002ccc:	c64080e7          	jalr	-924(ra) # 8000192c <_Z4putcc>
        printInt(iter->size);
    80002cd0:	00000613          	li	a2,0
    80002cd4:	00a00593          	li	a1,10
    80002cd8:	0004a503          	lw	a0,0(s1)
    80002cdc:	fffff097          	auipc	ra,0xfffff
    80002ce0:	590080e7          	jalr	1424(ra) # 8000226c <_Z8printIntiii>
        putc('\n');
    80002ce4:	00a00513          	li	a0,10
    80002ce8:	fffff097          	auipc	ra,0xfffff
    80002cec:	c44080e7          	jalr	-956(ra) # 8000192c <_Z4putcc>
        iter=iter->next;
    80002cf0:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002cf4:	fb9ff06f          	j	80002cac <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002cf8:	00006517          	auipc	a0,0x6
    80002cfc:	46850513          	addi	a0,a0,1128 # 80009160 <CONSOLE_STATUS+0x150>
    80002d00:	fffff097          	auipc	ra,0xfffff
    80002d04:	3d4080e7          	jalr	980(ra) # 800020d4 <_Z11printStringPKc>
}
    80002d08:	01813083          	ld	ra,24(sp)
    80002d0c:	01013403          	ld	s0,16(sp)
    80002d10:	00813483          	ld	s1,8(sp)
    80002d14:	02010113          	addi	sp,sp,32
    80002d18:	00008067          	ret

0000000080002d1c <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80002d1c:	ff010113          	addi	sp,sp,-16
    80002d20:	00813423          	sd	s0,8(sp)
    80002d24:	01010413          	addi	s0,sp,16
    80002d28:	00050813          	mv	a6,a0
    80002d2c:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002d30:	00000793          	li	a5,0
    80002d34:	00c7fe63          	bgeu	a5,a2,80002d50 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80002d38:	00f50733          	add	a4,a0,a5
    80002d3c:	00f806b3          	add	a3,a6,a5
    80002d40:	0006c683          	lbu	a3,0(a3)
    80002d44:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80002d48:	00178793          	addi	a5,a5,1
    80002d4c:	fe9ff06f          	j	80002d34 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80002d50:	00813403          	ld	s0,8(sp)
    80002d54:	01010113          	addi	sp,sp,16
    80002d58:	00008067          	ret

0000000080002d5c <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    80002d5c:	ff010113          	addi	sp,sp,-16
    80002d60:	00113423          	sd	ra,8(sp)
    80002d64:	00813023          	sd	s0,0(sp)
    80002d68:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80002d6c:	00053783          	ld	a5,0(a0)
    80002d70:	0107b783          	ld	a5,16(a5)
    80002d74:	000780e7          	jalr	a5
}
    80002d78:	00813083          	ld	ra,8(sp)
    80002d7c:	00013403          	ld	s0,0(sp)
    80002d80:	01010113          	addi	sp,sp,16
    80002d84:	00008067          	ret

0000000080002d88 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80002d88:	ff010113          	addi	sp,sp,-16
    80002d8c:	00113423          	sd	ra,8(sp)
    80002d90:	00813023          	sd	s0,0(sp)
    80002d94:	01010413          	addi	s0,sp,16
    80002d98:	00009797          	auipc	a5,0x9
    80002d9c:	bf078793          	addi	a5,a5,-1040 # 8000b988 <_ZTV9Semaphore+0x10>
    80002da0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80002da4:	00853503          	ld	a0,8(a0)
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	aac080e7          	jalr	-1364(ra) # 80001854 <_Z9sem_closeP10_semaphore>
};
    80002db0:	00813083          	ld	ra,8(sp)
    80002db4:	00013403          	ld	s0,0(sp)
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00008067          	ret

0000000080002dc0 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80002dc0:	00009797          	auipc	a5,0x9
    80002dc4:	be878793          	addi	a5,a5,-1048 # 8000b9a8 <_ZTV6Thread+0x10>
    80002dc8:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80002dcc:	00853503          	ld	a0,8(a0)
    80002dd0:	02050663          	beqz	a0,80002dfc <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80002dd4:	ff010113          	addi	sp,sp,-16
    80002dd8:	00113423          	sd	ra,8(sp)
    80002ddc:	00813023          	sd	s0,0(sp)
    80002de0:	01010413          	addi	s0,sp,16
    delete myHandle;
    80002de4:	fffff097          	auipc	ra,0xfffff
    80002de8:	bbc080e7          	jalr	-1092(ra) # 800019a0 <_ZN7_threaddlEPv>
}
    80002dec:	00813083          	ld	ra,8(sp)
    80002df0:	00013403          	ld	s0,0(sp)
    80002df4:	01010113          	addi	sp,sp,16
    80002df8:	00008067          	ret
    80002dfc:	00008067          	ret

0000000080002e00 <_Znwm>:
void* operator new(size_t sz){
    80002e00:	ff010113          	addi	sp,sp,-16
    80002e04:	00113423          	sd	ra,8(sp)
    80002e08:	00813023          	sd	s0,0(sp)
    80002e0c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80002e10:	fffff097          	auipc	ra,0xfffff
    80002e14:	844080e7          	jalr	-1980(ra) # 80001654 <_Z9mem_allocm>
}
    80002e18:	00813083          	ld	ra,8(sp)
    80002e1c:	00013403          	ld	s0,0(sp)
    80002e20:	01010113          	addi	sp,sp,16
    80002e24:	00008067          	ret

0000000080002e28 <_Znam>:
void* operator new[](size_t sz){
    80002e28:	ff010113          	addi	sp,sp,-16
    80002e2c:	00113423          	sd	ra,8(sp)
    80002e30:	00813023          	sd	s0,0(sp)
    80002e34:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80002e38:	fffff097          	auipc	ra,0xfffff
    80002e3c:	81c080e7          	jalr	-2020(ra) # 80001654 <_Z9mem_allocm>
}
    80002e40:	00813083          	ld	ra,8(sp)
    80002e44:	00013403          	ld	s0,0(sp)
    80002e48:	01010113          	addi	sp,sp,16
    80002e4c:	00008067          	ret

0000000080002e50 <_ZdlPv>:
void operator delete(void *ptr){
    80002e50:	ff010113          	addi	sp,sp,-16
    80002e54:	00113423          	sd	ra,8(sp)
    80002e58:	00813023          	sd	s0,0(sp)
    80002e5c:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	824080e7          	jalr	-2012(ra) # 80001684 <_Z8mem_freePv>
}
    80002e68:	00813083          	ld	ra,8(sp)
    80002e6c:	00013403          	ld	s0,0(sp)
    80002e70:	01010113          	addi	sp,sp,16
    80002e74:	00008067          	ret

0000000080002e78 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80002e78:	fe010113          	addi	sp,sp,-32
    80002e7c:	00113c23          	sd	ra,24(sp)
    80002e80:	00813823          	sd	s0,16(sp)
    80002e84:	00913423          	sd	s1,8(sp)
    80002e88:	02010413          	addi	s0,sp,32
    80002e8c:	00050493          	mv	s1,a0
};
    80002e90:	00000097          	auipc	ra,0x0
    80002e94:	ef8080e7          	jalr	-264(ra) # 80002d88 <_ZN9SemaphoreD1Ev>
    80002e98:	00048513          	mv	a0,s1
    80002e9c:	00000097          	auipc	ra,0x0
    80002ea0:	fb4080e7          	jalr	-76(ra) # 80002e50 <_ZdlPv>
    80002ea4:	01813083          	ld	ra,24(sp)
    80002ea8:	01013403          	ld	s0,16(sp)
    80002eac:	00813483          	ld	s1,8(sp)
    80002eb0:	02010113          	addi	sp,sp,32
    80002eb4:	00008067          	ret

0000000080002eb8 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80002eb8:	fe010113          	addi	sp,sp,-32
    80002ebc:	00113c23          	sd	ra,24(sp)
    80002ec0:	00813823          	sd	s0,16(sp)
    80002ec4:	00913423          	sd	s1,8(sp)
    80002ec8:	02010413          	addi	s0,sp,32
    80002ecc:	00050493          	mv	s1,a0
}
    80002ed0:	00000097          	auipc	ra,0x0
    80002ed4:	ef0080e7          	jalr	-272(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80002ed8:	00048513          	mv	a0,s1
    80002edc:	00000097          	auipc	ra,0x0
    80002ee0:	f74080e7          	jalr	-140(ra) # 80002e50 <_ZdlPv>
    80002ee4:	01813083          	ld	ra,24(sp)
    80002ee8:	01013403          	ld	s0,16(sp)
    80002eec:	00813483          	ld	s1,8(sp)
    80002ef0:	02010113          	addi	sp,sp,32
    80002ef4:	00008067          	ret

0000000080002ef8 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80002ef8:	ff010113          	addi	sp,sp,-16
    80002efc:	00113423          	sd	ra,8(sp)
    80002f00:	00813023          	sd	s0,0(sp)
    80002f04:	01010413          	addi	s0,sp,16
    80002f08:	00009797          	auipc	a5,0x9
    80002f0c:	a8078793          	addi	a5,a5,-1408 # 8000b988 <_ZTV9Semaphore+0x10>
    80002f10:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80002f14:	00850513          	addi	a0,a0,8
    80002f18:	fffff097          	auipc	ra,0xfffff
    80002f1c:	904080e7          	jalr	-1788(ra) # 8000181c <_Z8sem_openPP10_semaphorej>
}
    80002f20:	00813083          	ld	ra,8(sp)
    80002f24:	00013403          	ld	s0,0(sp)
    80002f28:	01010113          	addi	sp,sp,16
    80002f2c:	00008067          	ret

0000000080002f30 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80002f30:	ff010113          	addi	sp,sp,-16
    80002f34:	00113423          	sd	ra,8(sp)
    80002f38:	00813023          	sd	s0,0(sp)
    80002f3c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80002f40:	00853503          	ld	a0,8(a0)
    80002f44:	fffff097          	auipc	ra,0xfffff
    80002f48:	93c080e7          	jalr	-1732(ra) # 80001880 <_Z8sem_waitP10_semaphore>
}
    80002f4c:	00813083          	ld	ra,8(sp)
    80002f50:	00013403          	ld	s0,0(sp)
    80002f54:	01010113          	addi	sp,sp,16
    80002f58:	00008067          	ret

0000000080002f5c <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002f5c:	ff010113          	addi	sp,sp,-16
    80002f60:	00113423          	sd	ra,8(sp)
    80002f64:	00813023          	sd	s0,0(sp)
    80002f68:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80002f6c:	00853503          	ld	a0,8(a0)
    80002f70:	fffff097          	auipc	ra,0xfffff
    80002f74:	93c080e7          	jalr	-1732(ra) # 800018ac <_Z10sem_signalP10_semaphore>
}
    80002f78:	00813083          	ld	ra,8(sp)
    80002f7c:	00013403          	ld	s0,0(sp)
    80002f80:	01010113          	addi	sp,sp,16
    80002f84:	00008067          	ret

0000000080002f88 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80002f88:	ff010113          	addi	sp,sp,-16
    80002f8c:	00113423          	sd	ra,8(sp)
    80002f90:	00813023          	sd	s0,0(sp)
    80002f94:	01010413          	addi	s0,sp,16
    80002f98:	00009797          	auipc	a5,0x9
    80002f9c:	a1078793          	addi	a5,a5,-1520 # 8000b9a8 <_ZTV6Thread+0x10>
    80002fa0:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80002fa4:	00850513          	addi	a0,a0,8
    80002fa8:	ffffe097          	auipc	ra,0xffffe
    80002fac:	7cc080e7          	jalr	1996(ra) # 80001774 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002fb0:	00813083          	ld	ra,8(sp)
    80002fb4:	00013403          	ld	s0,0(sp)
    80002fb8:	01010113          	addi	sp,sp,16
    80002fbc:	00008067          	ret

0000000080002fc0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80002fc0:	ff010113          	addi	sp,sp,-16
    80002fc4:	00113423          	sd	ra,8(sp)
    80002fc8:	00813023          	sd	s0,0(sp)
    80002fcc:	01010413          	addi	s0,sp,16
    80002fd0:	00009797          	auipc	a5,0x9
    80002fd4:	9d878793          	addi	a5,a5,-1576 # 8000b9a8 <_ZTV6Thread+0x10>
    80002fd8:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    80002fdc:	00050613          	mv	a2,a0
    80002fe0:	00000597          	auipc	a1,0x0
    80002fe4:	d7c58593          	addi	a1,a1,-644 # 80002d5c <_ZN6Thread7wrapperEPv>
    80002fe8:	00850513          	addi	a0,a0,8
    80002fec:	ffffe097          	auipc	ra,0xffffe
    80002ff0:	788080e7          	jalr	1928(ra) # 80001774 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80002ff4:	00813083          	ld	ra,8(sp)
    80002ff8:	00013403          	ld	s0,0(sp)
    80002ffc:	01010113          	addi	sp,sp,16
    80003000:	00008067          	ret

0000000080003004 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003004:	ff010113          	addi	sp,sp,-16
    80003008:	00113423          	sd	ra,8(sp)
    8000300c:	00813023          	sd	s0,0(sp)
    80003010:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	8c4080e7          	jalr	-1852(ra) # 800018d8 <_Z10time_sleepm>
}
    8000301c:	00813083          	ld	ra,8(sp)
    80003020:	00013403          	ld	s0,0(sp)
    80003024:	01010113          	addi	sp,sp,16
    80003028:	00008067          	ret

000000008000302c <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    8000302c:	fe010113          	addi	sp,sp,-32
    80003030:	00113c23          	sd	ra,24(sp)
    80003034:	00813823          	sd	s0,16(sp)
    80003038:	00913423          	sd	s1,8(sp)
    8000303c:	01213023          	sd	s2,0(sp)
    80003040:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80003044:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80003048:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    8000304c:	0004b783          	ld	a5,0(s1)
    80003050:	0187b783          	ld	a5,24(a5)
    80003054:	00048513          	mv	a0,s1
    80003058:	000780e7          	jalr	a5
        pt->sleep(time);
    8000305c:	00090513          	mv	a0,s2
    80003060:	00000097          	auipc	ra,0x0
    80003064:	fa4080e7          	jalr	-92(ra) # 80003004 <_ZN6Thread5sleepEm>
    while(true){
    80003068:	fe5ff06f          	j	8000304c <_ZN14PeriodicThread7wrapperEPv+0x20>

000000008000306c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000306c:	ff010113          	addi	sp,sp,-16
    80003070:	00113423          	sd	ra,8(sp)
    80003074:	00813023          	sd	s0,0(sp)
    80003078:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000307c:	ffffe097          	auipc	ra,0xffffe
    80003080:	6d8080e7          	jalr	1752(ra) # 80001754 <_Z15thread_dispatchv>
}
    80003084:	00813083          	ld	ra,8(sp)
    80003088:	00013403          	ld	s0,0(sp)
    8000308c:	01010113          	addi	sp,sp,16
    80003090:	00008067          	ret

0000000080003094 <_ZN6Thread5startEv>:
int Thread::start() {
    80003094:	ff010113          	addi	sp,sp,-16
    80003098:	00113423          	sd	ra,8(sp)
    8000309c:	00813023          	sd	s0,0(sp)
    800030a0:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    800030a4:	00853503          	ld	a0,8(a0)
    800030a8:	ffffe097          	auipc	ra,0xffffe
    800030ac:	748080e7          	jalr	1864(ra) # 800017f0 <_Z12thread_startP7_thread>
}
    800030b0:	00813083          	ld	ra,8(sp)
    800030b4:	00013403          	ld	s0,0(sp)
    800030b8:	01010113          	addi	sp,sp,16
    800030bc:	00008067          	ret

00000000800030c0 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800030c0:	fe010113          	addi	sp,sp,-32
    800030c4:	00113c23          	sd	ra,24(sp)
    800030c8:	00813823          	sd	s0,16(sp)
    800030cc:	00913423          	sd	s1,8(sp)
    800030d0:	01213023          	sd	s2,0(sp)
    800030d4:	02010413          	addi	s0,sp,32
    800030d8:	00050493          	mv	s1,a0
    800030dc:	00058913          	mv	s2,a1
    800030e0:	01000513          	li	a0,16
    800030e4:	00000097          	auipc	ra,0x0
    800030e8:	d1c080e7          	jalr	-740(ra) # 80002e00 <_Znwm>
    800030ec:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    800030f0:	00953023          	sd	s1,0(a0)
    800030f4:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800030f8:	00000597          	auipc	a1,0x0
    800030fc:	f3458593          	addi	a1,a1,-204 # 8000302c <_ZN14PeriodicThread7wrapperEPv>
    80003100:	00048513          	mv	a0,s1
    80003104:	00000097          	auipc	ra,0x0
    80003108:	e84080e7          	jalr	-380(ra) # 80002f88 <_ZN6ThreadC1EPFvPvES0_>
    8000310c:	00009797          	auipc	a5,0x9
    80003110:	84c78793          	addi	a5,a5,-1972 # 8000b958 <_ZTV14PeriodicThread+0x10>
    80003114:	00f4b023          	sd	a5,0(s1)
    80003118:	01813083          	ld	ra,24(sp)
    8000311c:	01013403          	ld	s0,16(sp)
    80003120:	00813483          	ld	s1,8(sp)
    80003124:	00013903          	ld	s2,0(sp)
    80003128:	02010113          	addi	sp,sp,32
    8000312c:	00008067          	ret

0000000080003130 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80003130:	ff010113          	addi	sp,sp,-16
    80003134:	00113423          	sd	ra,8(sp)
    80003138:	00813023          	sd	s0,0(sp)
    8000313c:	01010413          	addi	s0,sp,16
    return ::getc();
    80003140:	ffffe097          	auipc	ra,0xffffe
    80003144:	7c4080e7          	jalr	1988(ra) # 80001904 <_Z4getcv>
}
    80003148:	00813083          	ld	ra,8(sp)
    8000314c:	00013403          	ld	s0,0(sp)
    80003150:	01010113          	addi	sp,sp,16
    80003154:	00008067          	ret

0000000080003158 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003158:	ff010113          	addi	sp,sp,-16
    8000315c:	00113423          	sd	ra,8(sp)
    80003160:	00813023          	sd	s0,0(sp)
    80003164:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003168:	ffffe097          	auipc	ra,0xffffe
    8000316c:	7c4080e7          	jalr	1988(ra) # 8000192c <_Z4putcc>
}
    80003170:	00813083          	ld	ra,8(sp)
    80003174:	00013403          	ld	s0,0(sp)
    80003178:	01010113          	addi	sp,sp,16
    8000317c:	00008067          	ret

0000000080003180 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003180:	ff010113          	addi	sp,sp,-16
    80003184:	00813423          	sd	s0,8(sp)
    80003188:	01010413          	addi	s0,sp,16
    8000318c:	00813403          	ld	s0,8(sp)
    80003190:	01010113          	addi	sp,sp,16
    80003194:	00008067          	ret

0000000080003198 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003198:	ff010113          	addi	sp,sp,-16
    8000319c:	00813423          	sd	s0,8(sp)
    800031a0:	01010413          	addi	s0,sp,16
    800031a4:	00813403          	ld	s0,8(sp)
    800031a8:	01010113          	addi	sp,sp,16
    800031ac:	00008067          	ret

00000000800031b0 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    800031b0:	ff010113          	addi	sp,sp,-16
    800031b4:	00113423          	sd	ra,8(sp)
    800031b8:	00813023          	sd	s0,0(sp)
    800031bc:	01010413          	addi	s0,sp,16
    800031c0:	00008797          	auipc	a5,0x8
    800031c4:	79878793          	addi	a5,a5,1944 # 8000b958 <_ZTV14PeriodicThread+0x10>
    800031c8:	00f53023          	sd	a5,0(a0)
    800031cc:	00000097          	auipc	ra,0x0
    800031d0:	bf4080e7          	jalr	-1036(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    800031d4:	00813083          	ld	ra,8(sp)
    800031d8:	00013403          	ld	s0,0(sp)
    800031dc:	01010113          	addi	sp,sp,16
    800031e0:	00008067          	ret

00000000800031e4 <_ZN14PeriodicThreadD0Ev>:
    800031e4:	fe010113          	addi	sp,sp,-32
    800031e8:	00113c23          	sd	ra,24(sp)
    800031ec:	00813823          	sd	s0,16(sp)
    800031f0:	00913423          	sd	s1,8(sp)
    800031f4:	02010413          	addi	s0,sp,32
    800031f8:	00050493          	mv	s1,a0
    800031fc:	00008797          	auipc	a5,0x8
    80003200:	75c78793          	addi	a5,a5,1884 # 8000b958 <_ZTV14PeriodicThread+0x10>
    80003204:	00f53023          	sd	a5,0(a0)
    80003208:	00000097          	auipc	ra,0x0
    8000320c:	bb8080e7          	jalr	-1096(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80003210:	00048513          	mv	a0,s1
    80003214:	00000097          	auipc	ra,0x0
    80003218:	c3c080e7          	jalr	-964(ra) # 80002e50 <_ZdlPv>
    8000321c:	01813083          	ld	ra,24(sp)
    80003220:	01013403          	ld	s0,16(sp)
    80003224:	00813483          	ld	s1,8(sp)
    80003228:	02010113          	addi	sp,sp,32
    8000322c:	00008067          	ret

0000000080003230 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003230:	ff010113          	addi	sp,sp,-16
    80003234:	00113423          	sd	ra,8(sp)
    80003238:	00813023          	sd	s0,0(sp)
    8000323c:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003240:	00009797          	auipc	a5,0x9
    80003244:	8e07b783          	ld	a5,-1824(a5) # 8000bb20 <_GLOBAL_OFFSET_TABLE_+0x70>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003248:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    8000324c:	fffff097          	auipc	ra,0xfffff
    80003250:	674080e7          	jalr	1652(ra) # 800028c0 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003254:	00001097          	auipc	ra,0x1
    80003258:	ef4080e7          	jalr	-268(ra) # 80004148 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000325c:	fffff097          	auipc	ra,0xfffff
    80003260:	544080e7          	jalr	1348(ra) # 800027a0 <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    80003264:	00001097          	auipc	ra,0x1
    80003268:	0f8080e7          	jalr	248(ra) # 8000435c <_ZN11ConsoleUtil10initializeEv>
    SlabAllocator::initialize(BUDDY_START_ADDR_CONST, 4096);
    8000326c:	00009797          	auipc	a5,0x9
    80003270:	85c7b783          	ld	a5,-1956(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003274:	0007b503          	ld	a0,0(a5)
    80003278:	00c55513          	srli	a0,a0,0xc
    8000327c:	00250513          	addi	a0,a0,2
    80003280:	000015b7          	lui	a1,0x1
    80003284:	00c51513          	slli	a0,a0,0xc
    80003288:	ffffe097          	auipc	ra,0xffffe
    8000328c:	2e0080e7          	jalr	736(ra) # 80001568 <_ZN13SlabAllocator10initializeEPvm>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003290:	00200793          	li	a5,2
    80003294:	1047a073          	csrs	sie,a5
    80003298:	20000713          	li	a4,512
    8000329c:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800032a0:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    800032a4:	00813083          	ld	ra,8(sp)
    800032a8:	00013403          	ld	s0,0(sp)
    800032ac:	01010113          	addi	sp,sp,16
    800032b0:	00008067          	ret

00000000800032b4 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    800032b4:	ff010113          	addi	sp,sp,-16
    800032b8:	00813423          	sd	s0,8(sp)
    800032bc:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    800032c0:	14109073          	csrw	sepc,ra
    asm("sret");
    800032c4:	10200073          	sret
}
    800032c8:	00813403          	ld	s0,8(sp)
    800032cc:	01010113          	addi	sp,sp,16
    800032d0:	00008067          	ret

00000000800032d4 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    800032d4:	ff010113          	addi	sp,sp,-16
    800032d8:	00113423          	sd	ra,8(sp)
    800032dc:	00813023          	sd	s0,0(sp)
    800032e0:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    800032e4:	00009797          	auipc	a5,0x9
    800032e8:	85c7b783          	ld	a5,-1956(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800032ec:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    800032f0:	00100713          	li	a4,1
    800032f4:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800032f8:	fffff097          	auipc	ra,0xfffff
    800032fc:	400080e7          	jalr	1024(ra) # 800026f8 <_ZN3TCB8dispatchEv>
}
    80003300:	00813083          	ld	ra,8(sp)
    80003304:	00013403          	ld	s0,0(sp)
    80003308:	01010113          	addi	sp,sp,16
    8000330c:	00008067          	ret

0000000080003310 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003310:	ff010113          	addi	sp,sp,-16
    80003314:	00113423          	sd	ra,8(sp)
    80003318:	00813023          	sd	s0,0(sp)
    8000331c:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003320:	00009797          	auipc	a5,0x9
    80003324:	a507c783          	lbu	a5,-1456(a5) # 8000bd70 <_ZN5RiscV16userMainFinishedE>
    80003328:	00079c63          	bnez	a5,80003340 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    8000332c:	00009717          	auipc	a4,0x9
    80003330:	80c73703          	ld	a4,-2036(a4) # 8000bb38 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003334:	00073783          	ld	a5,0(a4)
    80003338:	00178793          	addi	a5,a5,1
    8000333c:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003340:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003344:	0ff57513          	andi	a0,a0,255
    80003348:	00001097          	auipc	ra,0x1
    8000334c:	1a4080e7          	jalr	420(ra) # 800044ec <_ZN11ConsoleUtil9putOutputEc>
}
    80003350:	00813083          	ld	ra,8(sp)
    80003354:	00013403          	ld	s0,0(sp)
    80003358:	01010113          	addi	sp,sp,16
    8000335c:	00008067          	ret

0000000080003360 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003360:	fe010113          	addi	sp,sp,-32
    80003364:	00113c23          	sd	ra,24(sp)
    80003368:	00813823          	sd	s0,16(sp)
    8000336c:	02010413          	addi	s0,sp,32
    80003370:	00c0006f          	j	8000337c <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003374:	ffffe097          	auipc	ra,0xffffe
    80003378:	3e0080e7          	jalr	992(ra) # 80001754 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    8000337c:	00008797          	auipc	a5,0x8
    80003380:	7447b783          	ld	a5,1860(a5) # 8000bac0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003384:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003388:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000338c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003390:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003394:	0207f793          	andi	a5,a5,32
    80003398:	fc078ee3          	beqz	a5,80003374 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    8000339c:	00001097          	auipc	ra,0x1
    800033a0:	3c8080e7          	jalr	968(ra) # 80004764 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    800033a4:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    800033a8:	00008797          	auipc	a5,0x8
    800033ac:	7107b783          	ld	a5,1808(a5) # 8000bab8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800033b0:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    800033b4:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    800033b8:	fef44783          	lbu	a5,-17(s0)
    800033bc:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    800033c0:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    800033c4:	00008797          	auipc	a5,0x8
    800033c8:	7747b783          	ld	a5,1908(a5) # 8000bb38 <_GLOBAL_OFFSET_TABLE_+0x88>
    800033cc:	0007b783          	ld	a5,0(a5)
    800033d0:	fa0786e3          	beqz	a5,8000337c <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    800033d4:	fff78793          	addi	a5,a5,-1
    800033d8:	00008717          	auipc	a4,0x8
    800033dc:	76073703          	ld	a4,1888(a4) # 8000bb38 <_GLOBAL_OFFSET_TABLE_+0x88>
    800033e0:	00f73023          	sd	a5,0(a4)
    800033e4:	f99ff06f          	j	8000337c <_ZN5RiscV11putcWrapperEPv+0x1c>

00000000800033e8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    800033e8:	ff010113          	addi	sp,sp,-16
    800033ec:	00813423          	sd	s0,8(sp)
    800033f0:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    800033f4:	00008797          	auipc	a5,0x8
    800033f8:	74c7b783          	ld	a5,1868(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800033fc:	0007b783          	ld	a5,0(a5)
    80003400:	0147a703          	lw	a4,20(a5)
    80003404:	00100793          	li	a5,1
    80003408:	00f70c63          	beq	a4,a5,80003420 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    8000340c:	10000793          	li	a5,256
    80003410:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80003414:	00813403          	ld	s0,8(sp)
    80003418:	01010113          	addi	sp,sp,16
    8000341c:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003420:	10000793          	li	a5,256
    80003424:	1007a073          	csrs	sstatus,a5
}
    80003428:	fedff06f          	j	80003414 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

000000008000342c <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    8000342c:	ff010113          	addi	sp,sp,-16
    80003430:	00113423          	sd	ra,8(sp)
    80003434:	00813023          	sd	s0,0(sp)
    80003438:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    8000343c:	00100793          	li	a5,1
    80003440:	00009717          	auipc	a4,0x9
    80003444:	92f70823          	sb	a5,-1744(a4) # 8000bd70 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003448:	00008797          	auipc	a5,0x8
    8000344c:	6f07b783          	ld	a5,1776(a5) # 8000bb38 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003450:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003454:	00008797          	auipc	a5,0x8
    80003458:	6947b783          	ld	a5,1684(a5) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000345c:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003460:	00200793          	li	a5,2
    80003464:	1047b073          	csrc	sie,a5
    80003468:	20000793          	li	a5,512
    8000346c:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003470:	00008797          	auipc	a5,0x8
    80003474:	6a07b783          	ld	a5,1696(a5) # 8000bb10 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003478:	0007b783          	ld	a5,0(a5)
    8000347c:	00078c63          	beqz	a5,80003494 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003480:	0487b703          	ld	a4,72(a5)
    80003484:	00008797          	auipc	a5,0x8
    80003488:	68c7b783          	ld	a5,1676(a5) # 8000bb10 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000348c:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003490:	fe1ff06f          	j	80003470 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003494:	00008797          	auipc	a5,0x8
    80003498:	6847b783          	ld	a5,1668(a5) # 8000bb18 <_GLOBAL_OFFSET_TABLE_+0x68>
    8000349c:	0007b503          	ld	a0,0(a5)
    800034a0:	00001097          	auipc	ra,0x1
    800034a4:	cc0080e7          	jalr	-832(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    800034a8:	00008797          	auipc	a5,0x8
    800034ac:	6807b783          	ld	a5,1664(a5) # 8000bb28 <_GLOBAL_OFFSET_TABLE_+0x78>
    800034b0:	0007b703          	ld	a4,0(a5)
    800034b4:	00008797          	auipc	a5,0x8
    800034b8:	67c7b783          	ld	a5,1660(a5) # 8000bb30 <_GLOBAL_OFFSET_TABLE_+0x80>
    800034bc:	0007b783          	ld	a5,0(a5)
    800034c0:	00f70863          	beq	a4,a5,800034d0 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    800034c4:	ffffe097          	auipc	ra,0xffffe
    800034c8:	290080e7          	jalr	656(ra) # 80001754 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    800034cc:	fddff06f          	j	800034a8 <_ZN5RiscV8finalizeEv+0x7c>
}
    800034d0:	00813083          	ld	ra,8(sp)
    800034d4:	00013403          	ld	s0,0(sp)
    800034d8:	01010113          	addi	sp,sp,16
    800034dc:	00008067          	ret

00000000800034e0 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    800034e0:	ff010113          	addi	sp,sp,-16
    800034e4:	00813423          	sd	s0,8(sp)
    800034e8:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800034ec:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800034f0:	00008717          	auipc	a4,0x8
    800034f4:	65073703          	ld	a4,1616(a4) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800034f8:	00073703          	ld	a4,0(a4)
    800034fc:	06873703          	ld	a4,104(a4)
    80003500:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003504:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003508:	00078593          	mv	a1,a5
}
    8000350c:	00813403          	ld	s0,8(sp)
    80003510:	01010113          	addi	sp,sp,16
    80003514:	00008067          	ret

0000000080003518 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003518:	ff010113          	addi	sp,sp,-16
    8000351c:	00113423          	sd	ra,8(sp)
    80003520:	00813023          	sd	s0,0(sp)
    80003524:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003528:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    8000352c:	fffff097          	auipc	ra,0xfffff
    80003530:	414080e7          	jalr	1044(ra) # 80002940 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003534:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003538:	00000097          	auipc	ra,0x0
    8000353c:	fa8080e7          	jalr	-88(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003540:	00813083          	ld	ra,8(sp)
    80003544:	00013403          	ld	s0,0(sp)
    80003548:	01010113          	addi	sp,sp,16
    8000354c:	00008067          	ret

0000000080003550 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003550:	ff010113          	addi	sp,sp,-16
    80003554:	00113423          	sd	ra,8(sp)
    80003558:	00813023          	sd	s0,0(sp)
    8000355c:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003560:	00008797          	auipc	a5,0x8
    80003564:	5e87b783          	ld	a5,1512(a5) # 8000bb48 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003568:	0007c783          	lbu	a5,0(a5)
    8000356c:	02079263          	bnez	a5,80003590 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003570:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003574:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003578:	00000097          	auipc	ra,0x0
    8000357c:	f68080e7          	jalr	-152(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003580:	00813083          	ld	ra,8(sp)
    80003584:	00013403          	ld	s0,0(sp)
    80003588:	01010113          	addi	sp,sp,16
    8000358c:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003590:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003594:	fffff097          	auipc	ra,0xfffff
    80003598:	5d4080e7          	jalr	1492(ra) # 80002b68 <_ZN15MemoryAllocator5kfreeEPv>
    8000359c:	fd9ff06f          	j	80003574 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

00000000800035a0 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    800035a0:	fc010113          	addi	sp,sp,-64
    800035a4:	02113c23          	sd	ra,56(sp)
    800035a8:	02813823          	sd	s0,48(sp)
    800035ac:	02913423          	sd	s1,40(sp)
    800035b0:	03213023          	sd	s2,32(sp)
    800035b4:	01313c23          	sd	s3,24(sp)
    800035b8:	01413823          	sd	s4,16(sp)
    800035bc:	01513423          	sd	s5,8(sp)
    800035c0:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    800035c4:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800035c8:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    800035cc:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    800035d0:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800035d4:	07000513          	li	a0,112
    800035d8:	fffff097          	auipc	ra,0xfffff
    800035dc:	1a0080e7          	jalr	416(ra) # 80002778 <_ZN3TCBnwEm>
    800035e0:	00050493          	mv	s1,a0
    800035e4:	00200713          	li	a4,2
    800035e8:	000a0693          	mv	a3,s4
    800035ec:	00098613          	mv	a2,s3
    800035f0:	00090593          	mv	a1,s2
    800035f4:	fffff097          	auipc	ra,0xfffff
    800035f8:	038080e7          	jalr	56(ra) # 8000262c <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800035fc:	04048863          	beqz	s1,8000364c <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003600:	0184b783          	ld	a5,24(s1)
    80003604:	00078863          	beqz	a5,80003614 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003608:	00048513          	mv	a0,s1
    8000360c:	00001097          	auipc	ra,0x1
    80003610:	b54080e7          	jalr	-1196(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003614:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003618:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000361c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003620:	00000097          	auipc	ra,0x0
    80003624:	ec0080e7          	jalr	-320(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003628:	03813083          	ld	ra,56(sp)
    8000362c:	03013403          	ld	s0,48(sp)
    80003630:	02813483          	ld	s1,40(sp)
    80003634:	02013903          	ld	s2,32(sp)
    80003638:	01813983          	ld	s3,24(sp)
    8000363c:	01013a03          	ld	s4,16(sp)
    80003640:	00813a83          	ld	s5,8(sp)
    80003644:	04010113          	addi	sp,sp,64
    80003648:	00008067          	ret
        status = -1;
    8000364c:	fff00793          	li	a5,-1
    80003650:	fcdff06f          	j	8000361c <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    80003654:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003658:	00048513          	mv	a0,s1
    8000365c:	fffff097          	auipc	ra,0xfffff
    80003660:	210080e7          	jalr	528(ra) # 8000286c <_ZN3TCBdlEPv>
    80003664:	00090513          	mv	a0,s2
    80003668:	0000e097          	auipc	ra,0xe
    8000366c:	860080e7          	jalr	-1952(ra) # 80010ec8 <_Unwind_Resume>

0000000080003670 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003670:	fc010113          	addi	sp,sp,-64
    80003674:	02113c23          	sd	ra,56(sp)
    80003678:	02813823          	sd	s0,48(sp)
    8000367c:	02913423          	sd	s1,40(sp)
    80003680:	03213023          	sd	s2,32(sp)
    80003684:	01313c23          	sd	s3,24(sp)
    80003688:	01413823          	sd	s4,16(sp)
    8000368c:	01513423          	sd	s5,8(sp)
    80003690:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003694:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003698:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    8000369c:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    800036a0:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800036a4:	07000513          	li	a0,112
    800036a8:	fffff097          	auipc	ra,0xfffff
    800036ac:	0d0080e7          	jalr	208(ra) # 80002778 <_ZN3TCBnwEm>
    800036b0:	00050493          	mv	s1,a0
    800036b4:	00200713          	li	a4,2
    800036b8:	00090693          	mv	a3,s2
    800036bc:	00098613          	mv	a2,s3
    800036c0:	000a0593          	mv	a1,s4
    800036c4:	fffff097          	auipc	ra,0xfffff
    800036c8:	f68080e7          	jalr	-152(ra) # 8000262c <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800036cc:	04048263          	beqz	s1,80003710 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    800036d0:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    800036d4:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    800036d8:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    800036dc:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800036e0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800036e4:	00000097          	auipc	ra,0x0
    800036e8:	dfc080e7          	jalr	-516(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    800036ec:	03813083          	ld	ra,56(sp)
    800036f0:	03013403          	ld	s0,48(sp)
    800036f4:	02813483          	ld	s1,40(sp)
    800036f8:	02013903          	ld	s2,32(sp)
    800036fc:	01813983          	ld	s3,24(sp)
    80003700:	01013a03          	ld	s4,16(sp)
    80003704:	00813a83          	ld	s5,8(sp)
    80003708:	04010113          	addi	sp,sp,64
    8000370c:	00008067          	ret
        status = -1;
    80003710:	fff00793          	li	a5,-1
    80003714:	fcdff06f          	j	800036e0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003718:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000371c:	00048513          	mv	a0,s1
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	14c080e7          	jalr	332(ra) # 8000286c <_ZN3TCBdlEPv>
    80003728:	00090513          	mv	a0,s2
    8000372c:	0000d097          	auipc	ra,0xd
    80003730:	79c080e7          	jalr	1948(ra) # 80010ec8 <_Unwind_Resume>

0000000080003734 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003734:	ff010113          	addi	sp,sp,-16
    80003738:	00113423          	sd	ra,8(sp)
    8000373c:	00813023          	sd	s0,0(sp)
    80003740:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003744:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003748:	02051263          	bnez	a0,8000376c <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    8000374c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003750:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003754:	00000097          	auipc	ra,0x0
    80003758:	d8c080e7          	jalr	-628(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000375c:	00813083          	ld	ra,8(sp)
    80003760:	00013403          	ld	s0,0(sp)
    80003764:	01010113          	addi	sp,sp,16
    80003768:	00008067          	ret
        tcb->status = TCB::Status::READY;
    8000376c:	00100793          	li	a5,1
    80003770:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003774:	00001097          	auipc	ra,0x1
    80003778:	9ec080e7          	jalr	-1556(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    8000377c:	fffff097          	auipc	ra,0xfffff
    80003780:	f7c080e7          	jalr	-132(ra) # 800026f8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003784:	00000793          	li	a5,0
    80003788:	fc9ff06f          	j	80003750 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

000000008000378c <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    8000378c:	ff010113          	addi	sp,sp,-16
    80003790:	00113423          	sd	ra,8(sp)
    80003794:	00813023          	sd	s0,0(sp)
    80003798:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000379c:	00008797          	auipc	a5,0x8
    800037a0:	3a47b783          	ld	a5,932(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800037a4:	0007b783          	ld	a5,0(a5)
    800037a8:	02078a63          	beqz	a5,800037dc <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    800037ac:	00200713          	li	a4,2
    800037b0:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    800037b4:	fffff097          	auipc	ra,0xfffff
    800037b8:	f44080e7          	jalr	-188(ra) # 800026f8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    800037bc:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800037c0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800037c4:	00000097          	auipc	ra,0x0
    800037c8:	d1c080e7          	jalr	-740(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    800037cc:	00813083          	ld	ra,8(sp)
    800037d0:	00013403          	ld	s0,0(sp)
    800037d4:	01010113          	addi	sp,sp,16
    800037d8:	00008067          	ret
        status = -1;
    800037dc:	fff00793          	li	a5,-1
    800037e0:	fe1ff06f          	j	800037c0 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800037e4 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800037e4:	fd010113          	addi	sp,sp,-48
    800037e8:	02113423          	sd	ra,40(sp)
    800037ec:	02813023          	sd	s0,32(sp)
    800037f0:	00913c23          	sd	s1,24(sp)
    800037f4:	01213823          	sd	s2,16(sp)
    800037f8:	01313423          	sd	s3,8(sp)
    800037fc:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003800:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003804:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003808:	01800513          	li	a0,24
    8000380c:	fffff097          	auipc	ra,0xfffff
    80003810:	d30080e7          	jalr	-720(ra) # 8000253c <_ZN3SCBnwEm>
    80003814:	00050493          	mv	s1,a0
    80003818:	00090593          	mv	a1,s2
    8000381c:	fffff097          	auipc	ra,0xfffff
    80003820:	b64080e7          	jalr	-1180(ra) # 80002380 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003824:	02048a63          	beqz	s1,80003858 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    80003828:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    8000382c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003830:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003834:	00000097          	auipc	ra,0x0
    80003838:	cac080e7          	jalr	-852(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000383c:	02813083          	ld	ra,40(sp)
    80003840:	02013403          	ld	s0,32(sp)
    80003844:	01813483          	ld	s1,24(sp)
    80003848:	01013903          	ld	s2,16(sp)
    8000384c:	00813983          	ld	s3,8(sp)
    80003850:	03010113          	addi	sp,sp,48
    80003854:	00008067          	ret
        status = -1;
    80003858:	fff00793          	li	a5,-1
    8000385c:	fd5ff06f          	j	80003830 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80003860:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003864:	00048513          	mv	a0,s1
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	cfc080e7          	jalr	-772(ra) # 80002564 <_ZN3SCBdlEPv>
    80003870:	00090513          	mv	a0,s2
    80003874:	0000d097          	auipc	ra,0xd
    80003878:	654080e7          	jalr	1620(ra) # 80010ec8 <_Unwind_Resume>

000000008000387c <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    8000387c:	fe010113          	addi	sp,sp,-32
    80003880:	00113c23          	sd	ra,24(sp)
    80003884:	00813823          	sd	s0,16(sp)
    80003888:	00913423          	sd	s1,8(sp)
    8000388c:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003890:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003894:	02049463          	bnez	s1,800038bc <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003898:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000389c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800038a0:	00000097          	auipc	ra,0x0
    800038a4:	c40080e7          	jalr	-960(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    800038a8:	01813083          	ld	ra,24(sp)
    800038ac:	01013403          	ld	s0,16(sp)
    800038b0:	00813483          	ld	s1,8(sp)
    800038b4:	02010113          	addi	sp,sp,32
    800038b8:	00008067          	ret
        delete (SCB*)ihandle;
    800038bc:	00048513          	mv	a0,s1
    800038c0:	fffff097          	auipc	ra,0xfffff
    800038c4:	ae4080e7          	jalr	-1308(ra) # 800023a4 <_ZN3SCBD1Ev>
    800038c8:	00048513          	mv	a0,s1
    800038cc:	fffff097          	auipc	ra,0xfffff
    800038d0:	c98080e7          	jalr	-872(ra) # 80002564 <_ZN3SCBdlEPv>
    uint64 status = 0;
    800038d4:	00000793          	li	a5,0
    800038d8:	fc5ff06f          	j	8000389c <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800038dc <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800038dc:	ff010113          	addi	sp,sp,-16
    800038e0:	00113423          	sd	ra,8(sp)
    800038e4:	00813023          	sd	s0,0(sp)
    800038e8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800038ec:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800038f0:	02051c63          	bnez	a0,80003928 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800038f4:	00008797          	auipc	a5,0x8
    800038f8:	24c7b783          	ld	a5,588(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800038fc:	0007b783          	ld	a5,0(a5)
    80003900:	0607b783          	ld	a5,96(a5)
    80003904:	02078863          	beqz	a5,80003934 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003908:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000390c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003910:	00000097          	auipc	ra,0x0
    80003914:	bd0080e7          	jalr	-1072(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003918:	00813083          	ld	ra,8(sp)
    8000391c:	00013403          	ld	s0,0(sp)
    80003920:	01010113          	addi	sp,sp,16
    80003924:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	b88080e7          	jalr	-1144(ra) # 800024b0 <_ZN3SCB4waitEv>
    80003930:	fc5ff06f          	j	800038f4 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003934:	00000793          	li	a5,0
    80003938:	fd5ff06f          	j	8000390c <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

000000008000393c <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    8000393c:	ff010113          	addi	sp,sp,-16
    80003940:	00113423          	sd	ra,8(sp)
    80003944:	00813023          	sd	s0,0(sp)
    80003948:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000394c:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003950:	02051263          	bnez	a0,80003974 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003954:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003958:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000395c:	00000097          	auipc	ra,0x0
    80003960:	b84080e7          	jalr	-1148(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003964:	00813083          	ld	ra,8(sp)
    80003968:	00013403          	ld	s0,0(sp)
    8000396c:	01010113          	addi	sp,sp,16
    80003970:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003974:	fffff097          	auipc	ra,0xfffff
    80003978:	b8c080e7          	jalr	-1140(ra) # 80002500 <_ZN3SCB6signalEv>
    uint64 status = 0;
    8000397c:	00000793          	li	a5,0
    80003980:	fd9ff06f          	j	80003958 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003984 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003984:	fe010113          	addi	sp,sp,-32
    80003988:	00113c23          	sd	ra,24(sp)
    8000398c:	00813823          	sd	s0,16(sp)
    80003990:	00913423          	sd	s1,8(sp)
    80003994:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003998:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000399c:	00008797          	auipc	a5,0x8
    800039a0:	1a47b783          	ld	a5,420(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800039a4:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    800039a8:	00008797          	auipc	a5,0x8
    800039ac:	3d07b783          	ld	a5,976(a5) # 8000bd78 <_ZN5RiscV10globalTimeE>
    800039b0:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    800039b4:	00e787b3          	add	a5,a5,a4
    800039b8:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    800039bc:	00048513          	mv	a0,s1
    800039c0:	00001097          	auipc	ra,0x1
    800039c4:	81c080e7          	jalr	-2020(ra) # 800041dc <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    800039c8:	00300793          	li	a5,3
    800039cc:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    800039d0:	fffff097          	auipc	ra,0xfffff
    800039d4:	d28080e7          	jalr	-728(ra) # 800026f8 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    800039d8:	00000793          	li	a5,0
    800039dc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800039e0:	00000097          	auipc	ra,0x0
    800039e4:	b00080e7          	jalr	-1280(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    800039e8:	01813083          	ld	ra,24(sp)
    800039ec:	01013403          	ld	s0,16(sp)
    800039f0:	00813483          	ld	s1,8(sp)
    800039f4:	02010113          	addi	sp,sp,32
    800039f8:	00008067          	ret

00000000800039fc <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    800039fc:	fe010113          	addi	sp,sp,-32
    80003a00:	00113c23          	sd	ra,24(sp)
    80003a04:	00813823          	sd	s0,16(sp)
    80003a08:	00913423          	sd	s1,8(sp)
    80003a0c:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003a10:	00008797          	auipc	a5,0x8
    80003a14:	3607c783          	lbu	a5,864(a5) # 8000bd70 <_ZN5RiscV16userMainFinishedE>
    80003a18:	00079c63          	bnez	a5,80003a30 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003a1c:	00008717          	auipc	a4,0x8
    80003a20:	0cc73703          	ld	a4,204(a4) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003a24:	00073783          	ld	a5,0(a4)
    80003a28:	00178793          	addi	a5,a5,1
    80003a2c:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003a30:	00001097          	auipc	ra,0x1
    80003a34:	a44080e7          	jalr	-1468(ra) # 80004474 <_ZN11ConsoleUtil8getInputEv>
    80003a38:	00050493          	mv	s1,a0
    if(c==13) {
    80003a3c:	00d00793          	li	a5,13
    80003a40:	02f50663          	beq	a0,a5,80003a6c <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003a44:	01b00793          	li	a5,27
    80003a48:	04f51063          	bne	a0,a5,80003a88 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003a4c:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003a50:	00000097          	auipc	ra,0x0
    80003a54:	a90080e7          	jalr	-1392(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a58:	01813083          	ld	ra,24(sp)
    80003a5c:	01013403          	ld	s0,16(sp)
    80003a60:	00813483          	ld	s1,8(sp)
    80003a64:	02010113          	addi	sp,sp,32
    80003a68:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003a6c:	00d00513          	li	a0,13
    80003a70:	00001097          	auipc	ra,0x1
    80003a74:	a7c080e7          	jalr	-1412(ra) # 800044ec <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003a78:	00a00513          	li	a0,10
    80003a7c:	00001097          	auipc	ra,0x1
    80003a80:	a70080e7          	jalr	-1424(ra) # 800044ec <_ZN11ConsoleUtil9putOutputEc>
    80003a84:	fc9ff06f          	j	80003a4c <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003a88:	00001097          	auipc	ra,0x1
    80003a8c:	a64080e7          	jalr	-1436(ra) # 800044ec <_ZN11ConsoleUtil9putOutputEc>
    80003a90:	fbdff06f          	j	80003a4c <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003a94 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003a94:	ff010113          	addi	sp,sp,-16
    80003a98:	00113423          	sd	ra,8(sp)
    80003a9c:	00813023          	sd	s0,0(sp)
    80003aa0:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003aa4:	00001097          	auipc	ra,0x1
    80003aa8:	ac8080e7          	jalr	-1336(ra) # 8000456c <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003aac:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003ab0:	00000097          	auipc	ra,0x0
    80003ab4:	a30080e7          	jalr	-1488(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ab8:	00813083          	ld	ra,8(sp)
    80003abc:	00013403          	ld	s0,0(sp)
    80003ac0:	01010113          	addi	sp,sp,16
    80003ac4:	00008067          	ret

0000000080003ac8 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003ac8:	fe010113          	addi	sp,sp,-32
    80003acc:	00113c23          	sd	ra,24(sp)
    80003ad0:	00813823          	sd	s0,16(sp)
    80003ad4:	00913423          	sd	s1,8(sp)
    80003ad8:	01213023          	sd	s2,0(sp)
    80003adc:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003ae0:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003ae4:	02049663          	bnez	s1,80003b10 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    80003ae8:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003aec:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    80003af0:	00000097          	auipc	ra,0x0
    80003af4:	9f0080e7          	jalr	-1552(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003af8:	01813083          	ld	ra,24(sp)
    80003afc:	01013403          	ld	s0,16(sp)
    80003b00:	00813483          	ld	s1,8(sp)
    80003b04:	00013903          	ld	s2,0(sp)
    80003b08:	02010113          	addi	sp,sp,32
    80003b0c:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    80003b10:	0284b503          	ld	a0,40(s1)
    80003b14:	fffff097          	auipc	ra,0xfffff
    80003b18:	054080e7          	jalr	84(ra) # 80002b68 <_ZN15MemoryAllocator5kfreeEPv>
    80003b1c:	00050913          	mv	s2,a0
        delete thr;
    80003b20:	00048513          	mv	a0,s1
    80003b24:	fffff097          	auipc	ra,0xfffff
    80003b28:	bac080e7          	jalr	-1108(ra) # 800026d0 <_ZN3TCBD1Ev>
    80003b2c:	00048513          	mv	a0,s1
    80003b30:	fffff097          	auipc	ra,0xfffff
    80003b34:	d3c080e7          	jalr	-708(ra) # 8000286c <_ZN3TCBdlEPv>
    80003b38:	fb5ff06f          	j	80003aec <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

0000000080003b3c <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003b3c:	fe010113          	addi	sp,sp,-32
    80003b40:	00113c23          	sd	ra,24(sp)
    80003b44:	00813823          	sd	s0,16(sp)
    80003b48:	00913423          	sd	s1,8(sp)
    80003b4c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003b50:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003b54:	02049463          	bnez	s1,80003b7c <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b58:	fff00793          	li	a5,-1
    80003b5c:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003b60:	00000097          	auipc	ra,0x0
    80003b64:	980080e7          	jalr	-1664(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b68:	01813083          	ld	ra,24(sp)
    80003b6c:	01013403          	ld	s0,16(sp)
    80003b70:	00813483          	ld	s1,8(sp)
    80003b74:	02010113          	addi	sp,sp,32
    80003b78:	00008067          	ret
        delete scb;
    80003b7c:	00048513          	mv	a0,s1
    80003b80:	fffff097          	auipc	ra,0xfffff
    80003b84:	824080e7          	jalr	-2012(ra) # 800023a4 <_ZN3SCBD1Ev>
    80003b88:	00048513          	mv	a0,s1
    80003b8c:	fffff097          	auipc	ra,0xfffff
    80003b90:	9d8080e7          	jalr	-1576(ra) # 80002564 <_ZN3SCBdlEPv>
    80003b94:	fc5ff06f          	j	80003b58 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003b98 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003b98:	fe010113          	addi	sp,sp,-32
    80003b9c:	00113c23          	sd	ra,24(sp)
    80003ba0:	00813823          	sd	s0,16(sp)
    80003ba4:	00913423          	sd	s1,8(sp)
    80003ba8:	01213023          	sd	s2,0(sp)
    80003bac:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003bb0:	04000513          	li	a0,64
    80003bb4:	fffff097          	auipc	ra,0xfffff
    80003bb8:	d8c080e7          	jalr	-628(ra) # 80002940 <_ZN15MemoryAllocator7kmallocEm>
    80003bbc:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003bc0:	00008797          	auipc	a5,0x8
    80003bc4:	f807b783          	ld	a5,-128(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003bc8:	0007b783          	ld	a5,0(a5)
    80003bcc:	00001637          	lui	a2,0x1
    80003bd0:	00050593          	mv	a1,a0
    80003bd4:	0287b503          	ld	a0,40(a5)
    80003bd8:	fffff097          	auipc	ra,0xfffff
    80003bdc:	144080e7          	jalr	324(ra) # 80002d1c <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003be0:	07000513          	li	a0,112
    80003be4:	fffff097          	auipc	ra,0xfffff
    80003be8:	b94080e7          	jalr	-1132(ra) # 80002778 <_ZN3TCBnwEm>
    80003bec:	00050493          	mv	s1,a0
    80003bf0:	00200713          	li	a4,2
    80003bf4:	00090693          	mv	a3,s2
    80003bf8:	00000613          	li	a2,0
    80003bfc:	00000593          	li	a1,0
    80003c00:	fffff097          	auipc	ra,0xfffff
    80003c04:	a2c080e7          	jalr	-1492(ra) # 8000262c <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003c08:	0a048e63          	beqz	s1,80003cc4 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003c0c:	00008797          	auipc	a5,0x8
    80003c10:	efc7b783          	ld	a5,-260(a5) # 8000bb08 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003c14:	0007b783          	ld	a5,0(a5)
    80003c18:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003c1c:	00008797          	auipc	a5,0x8
    80003c20:	ed47b783          	ld	a5,-300(a5) # 8000baf0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003c24:	0007b783          	ld	a5,0(a5)
    80003c28:	00f907b3          	add	a5,s2,a5
    80003c2c:	00008717          	auipc	a4,0x8
    80003c30:	f1473703          	ld	a4,-236(a4) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003c34:	00073683          	ld	a3,0(a4)
    80003c38:	0286b683          	ld	a3,40(a3)
    80003c3c:	40d787b3          	sub	a5,a5,a3
    80003c40:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003c44:	00073783          	ld	a5,0(a4)
    80003c48:	0687b503          	ld	a0,104(a5)
    80003c4c:	0287b783          	ld	a5,40(a5)
    80003c50:	40f50533          	sub	a0,a0,a5
    80003c54:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003c58:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003c5c:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003c60:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003c64:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003c68:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003c6c:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003c70:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003c74:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003c78:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003c7c:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003c80:	00073783          	ld	a5,0(a4)
    80003c84:	0387b703          	ld	a4,56(a5)
    80003c88:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003c8c:	0407b783          	ld	a5,64(a5)
    80003c90:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003c94:	00048513          	mv	a0,s1
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	4c8080e7          	jalr	1224(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ca0:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	83c080e7          	jalr	-1988(ra) # 800034e0 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003cac:	01813083          	ld	ra,24(sp)
    80003cb0:	01013403          	ld	s0,16(sp)
    80003cb4:	00813483          	ld	s1,8(sp)
    80003cb8:	00013903          	ld	s2,0(sp)
    80003cbc:	02010113          	addi	sp,sp,32
    80003cc0:	00008067          	ret
        status = -1;
    80003cc4:	fff00493          	li	s1,-1
    80003cc8:	fd9ff06f          	j	80003ca0 <_ZN5RiscV18executeForkSyscallEv+0x108>
    80003ccc:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003cd0:	00048513          	mv	a0,s1
    80003cd4:	fffff097          	auipc	ra,0xfffff
    80003cd8:	b98080e7          	jalr	-1128(ra) # 8000286c <_ZN3TCBdlEPv>
    80003cdc:	00090513          	mv	a0,s2
    80003ce0:	0000d097          	auipc	ra,0xd
    80003ce4:	1e8080e7          	jalr	488(ra) # 80010ec8 <_Unwind_Resume>

0000000080003ce8 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003ce8:	ff010113          	addi	sp,sp,-16
    80003cec:	00813423          	sd	s0,8(sp)
    80003cf0:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003cf4:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003cf8:	00878793          	addi	a5,a5,8
    80003cfc:	00008717          	auipc	a4,0x8
    80003d00:	e0c73703          	ld	a4,-500(a4) # 8000bb08 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003d04:	00f73023          	sd	a5,0(a4)
}
    80003d08:	00813403          	ld	s0,8(sp)
    80003d0c:	01010113          	addi	sp,sp,16
    80003d10:	00008067          	ret

0000000080003d14 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003d14:	fa010113          	addi	sp,sp,-96
    80003d18:	04113c23          	sd	ra,88(sp)
    80003d1c:	04813823          	sd	s0,80(sp)
    80003d20:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003d24:	142027f3          	csrr	a5,scause
    80003d28:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80003d2c:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003d30:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003d34:	00008797          	auipc	a5,0x8
    80003d38:	e0c7b783          	ld	a5,-500(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003d3c:	0007b783          	ld	a5,0(a5)
    80003d40:	14002773          	csrr	a4,sscratch
    80003d44:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80003d48:	fe843703          	ld	a4,-24(s0)
    80003d4c:	00900793          	li	a5,9
    80003d50:	0ef70663          	beq	a4,a5,80003e3c <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    80003d54:	fe843703          	ld	a4,-24(s0)
    80003d58:	00800793          	li	a5,8
    80003d5c:	0ef70063          	beq	a4,a5,80003e3c <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003d60:	fe843703          	ld	a4,-24(s0)
    80003d64:	fff00793          	li	a5,-1
    80003d68:	03f79793          	slli	a5,a5,0x3f
    80003d6c:	00178793          	addi	a5,a5,1
    80003d70:	24f70263          	beq	a4,a5,80003fb4 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003d74:	fe843703          	ld	a4,-24(s0)
    80003d78:	fff00793          	li	a5,-1
    80003d7c:	03f79793          	slli	a5,a5,0x3f
    80003d80:	00978793          	addi	a5,a5,9
    80003d84:	2cf70063          	beq	a4,a5,80004044 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80003d88:	fe843703          	ld	a4,-24(s0)
    80003d8c:	00200793          	li	a5,2
    80003d90:	34f70863          	beq	a4,a5,800040e0 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80003d94:	00005517          	auipc	a0,0x5
    80003d98:	44450513          	addi	a0,a0,1092 # 800091d8 <CONSOLE_STATUS+0x1c8>
    80003d9c:	00001097          	auipc	ra,0x1
    80003da0:	848080e7          	jalr	-1976(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003da4:	00005517          	auipc	a0,0x5
    80003da8:	44450513          	addi	a0,a0,1092 # 800091e8 <CONSOLE_STATUS+0x1d8>
    80003dac:	00001097          	auipc	ra,0x1
    80003db0:	838080e7          	jalr	-1992(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003db4:	142027f3          	csrr	a5,scause
    80003db8:	fef43023          	sd	a5,-32(s0)
    return scause;
    80003dbc:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80003dc0:	00000613          	li	a2,0
    80003dc4:	00a00593          	li	a1,10
    80003dc8:	0005051b          	sext.w	a0,a0
    80003dcc:	00001097          	auipc	ra,0x1
    80003dd0:	85c080e7          	jalr	-1956(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003dd4:	00005517          	auipc	a0,0x5
    80003dd8:	3d450513          	addi	a0,a0,980 # 800091a8 <CONSOLE_STATUS+0x198>
    80003ddc:	00001097          	auipc	ra,0x1
    80003de0:	808080e7          	jalr	-2040(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003de4:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003de8:	00000613          	li	a2,0
    80003dec:	01000593          	li	a1,16
    80003df0:	0005051b          	sext.w	a0,a0
    80003df4:	00001097          	auipc	ra,0x1
    80003df8:	834080e7          	jalr	-1996(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003dfc:	00005517          	auipc	a0,0x5
    80003e00:	3a450513          	addi	a0,a0,932 # 800091a0 <CONSOLE_STATUS+0x190>
    80003e04:	00000097          	auipc	ra,0x0
    80003e08:	7e0080e7          	jalr	2016(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80003e0c:	00008797          	auipc	a5,0x8
    80003e10:	d347b783          	ld	a5,-716(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003e14:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003e18:	00200713          	li	a4,2
    80003e1c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003e20:	00005517          	auipc	a0,0x5
    80003e24:	3d850513          	addi	a0,a0,984 # 800091f8 <CONSOLE_STATUS+0x1e8>
    80003e28:	00000097          	auipc	ra,0x0
    80003e2c:	7bc080e7          	jalr	1980(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003e30:	fffff097          	auipc	ra,0xfffff
    80003e34:	8c8080e7          	jalr	-1848(ra) # 800026f8 <_ZN3TCB8dispatchEv>
    80003e38:	0800006f          	j	80003eb8 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003e3c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003e40:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003e44:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003e48:	00478793          	addi	a5,a5,4
    80003e4c:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80003e50:	00008797          	auipc	a5,0x8
    80003e54:	cf07b783          	ld	a5,-784(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003e58:	0007b783          	ld	a5,0(a5)
    80003e5c:	fb043703          	ld	a4,-80(s0)
    80003e60:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003e64:	fa843703          	ld	a4,-88(s0)
    80003e68:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003e6c:	00050793          	mv	a5,a0
        switch(syscallID){
    80003e70:	06100713          	li	a4,97
    80003e74:	02f76463          	bltu	a4,a5,80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    80003e78:	00279793          	slli	a5,a5,0x2
    80003e7c:	00005717          	auipc	a4,0x5
    80003e80:	39070713          	addi	a4,a4,912 # 8000920c <CONSOLE_STATUS+0x1fc>
    80003e84:	00e787b3          	add	a5,a5,a4
    80003e88:	0007a783          	lw	a5,0(a5)
    80003e8c:	00e787b3          	add	a5,a5,a4
    80003e90:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003e94:	fffff097          	auipc	ra,0xfffff
    80003e98:	684080e7          	jalr	1668(ra) # 80003518 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003e9c:	00008797          	auipc	a5,0x8
    80003ea0:	ca47b783          	ld	a5,-860(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003ea4:	0007b783          	ld	a5,0(a5)
    80003ea8:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003eac:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003eb0:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003eb4:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003eb8:	fffff097          	auipc	ra,0xfffff
    80003ebc:	530080e7          	jalr	1328(ra) # 800033e8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003ec0:	05813083          	ld	ra,88(sp)
    80003ec4:	05013403          	ld	s0,80(sp)
    80003ec8:	06010113          	addi	sp,sp,96
    80003ecc:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	680080e7          	jalr	1664(ra) # 80003550 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003ed8:	fc5ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80003edc:	fffff097          	auipc	ra,0xfffff
    80003ee0:	6c4080e7          	jalr	1732(ra) # 800035a0 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003ee4:	fb9ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80003ee8:	00000097          	auipc	ra,0x0
    80003eec:	8a4080e7          	jalr	-1884(ra) # 8000378c <_ZN5RiscV24executeThreadExitSyscallEv>
    80003ef0:	fadff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003ef4:	fffff097          	auipc	ra,0xfffff
    80003ef8:	3e0080e7          	jalr	992(ra) # 800032d4 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003efc:	fa1ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003f00:	fffff097          	auipc	ra,0xfffff
    80003f04:	770080e7          	jalr	1904(ra) # 80003670 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003f08:	f95ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80003f0c:	00000097          	auipc	ra,0x0
    80003f10:	828080e7          	jalr	-2008(ra) # 80003734 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003f14:	f89ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80003f18:	00000097          	auipc	ra,0x0
    80003f1c:	8cc080e7          	jalr	-1844(ra) # 800037e4 <_ZN5RiscV21executeSemOpenSyscallEv>
    80003f20:	f7dff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80003f24:	00000097          	auipc	ra,0x0
    80003f28:	958080e7          	jalr	-1704(ra) # 8000387c <_ZN5RiscV22executeSemCloseSyscallEv>
    80003f2c:	f71ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80003f30:	00000097          	auipc	ra,0x0
    80003f34:	9ac080e7          	jalr	-1620(ra) # 800038dc <_ZN5RiscV21executeSemWaitSyscallEv>
    80003f38:	f65ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80003f3c:	00000097          	auipc	ra,0x0
    80003f40:	a00080e7          	jalr	-1536(ra) # 8000393c <_ZN5RiscV23executeSemSignalSyscallEv>
    80003f44:	f59ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    80003f48:	00000097          	auipc	ra,0x0
    80003f4c:	a3c080e7          	jalr	-1476(ra) # 80003984 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80003f50:	f4dff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80003f54:	00000097          	auipc	ra,0x0
    80003f58:	aa8080e7          	jalr	-1368(ra) # 800039fc <_ZN5RiscV18executeGetcSyscallEv>
    80003f5c:	f41ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80003f60:	fffff097          	auipc	ra,0xfffff
    80003f64:	3b0080e7          	jalr	944(ra) # 80003310 <_ZN5RiscV18executePutcSyscallEv>
    80003f68:	f35ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80003f6c:	00000097          	auipc	ra,0x0
    80003f70:	b28080e7          	jalr	-1240(ra) # 80003a94 <_ZN5RiscV22executePutcUtilSyscallEv>
    80003f74:	f29ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    80003f78:	00000097          	auipc	ra,0x0
    80003f7c:	b50080e7          	jalr	-1200(ra) # 80003ac8 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003f80:	f1dff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	bb8080e7          	jalr	-1096(ra) # 80003b3c <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003f8c:	f11ff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003f90:	00010793          	mv	a5,sp
    80003f94:	00008717          	auipc	a4,0x8
    80003f98:	b5c73703          	ld	a4,-1188(a4) # 8000baf0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003f9c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003fa0:	00000097          	auipc	ra,0x0
    80003fa4:	d48080e7          	jalr	-696(ra) # 80003ce8 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003fa8:	00000097          	auipc	ra,0x0
    80003fac:	bf0080e7          	jalr	-1040(ra) # 80003b98 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003fb0:	eedff06f          	j	80003e9c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003fb4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003fb8:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003fbc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003fc0:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003fc4:	00200793          	li	a5,2
    80003fc8:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003fcc:	00008717          	auipc	a4,0x8
    80003fd0:	da470713          	addi	a4,a4,-604 # 8000bd70 <_ZN5RiscV16userMainFinishedE>
    80003fd4:	00873783          	ld	a5,8(a4)
    80003fd8:	00178793          	addi	a5,a5,1
    80003fdc:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80003fe0:	00000097          	auipc	ra,0x0
    80003fe4:	254080e7          	jalr	596(ra) # 80004234 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003fe8:	00008717          	auipc	a4,0x8
    80003fec:	ae873703          	ld	a4,-1304(a4) # 8000bad0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003ff0:	00073783          	ld	a5,0(a4)
    80003ff4:	00178793          	addi	a5,a5,1
    80003ff8:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003ffc:	00008717          	auipc	a4,0x8
    80004000:	b4473703          	ld	a4,-1212(a4) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004004:	00073703          	ld	a4,0(a4)
    80004008:	03073683          	ld	a3,48(a4)
    8000400c:	00d7fc63          	bgeu	a5,a3,80004024 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004010:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004014:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004018:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000401c:	14179073          	csrw	sepc,a5
}
    80004020:	e99ff06f          	j	80003eb8 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80004024:	00008797          	auipc	a5,0x8
    80004028:	aac7b783          	ld	a5,-1364(a5) # 8000bad0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000402c:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004030:	00100793          	li	a5,1
    80004034:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004038:	ffffe097          	auipc	ra,0xffffe
    8000403c:	6c0080e7          	jalr	1728(ra) # 800026f8 <_ZN3TCB8dispatchEv>
    80004040:	fd1ff06f          	j	80004010 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004044:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004048:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000404c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004050:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80004054:	00008797          	auipc	a5,0x8
    80004058:	a6c7b783          	ld	a5,-1428(a5) # 8000bac0 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000405c:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004060:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004064:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004068:	00058793          	mv	a5,a1
        if(status & 1UL)
    8000406c:	0017f793          	andi	a5,a5,1
    80004070:	02078863          	beqz	a5,800040a0 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80004074:	00008797          	auipc	a5,0x8
    80004078:	a6c7b783          	ld	a5,-1428(a5) # 8000bae0 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000407c:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004080:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004084:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004088:	00058513          	mv	a0,a1
    8000408c:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004090:	00008797          	auipc	a5,0x8
    80004094:	a587b783          	ld	a5,-1448(a5) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004098:	0007b783          	ld	a5,0(a5)
    8000409c:	02079463          	bnez	a5,800040c4 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    800040a0:	00003097          	auipc	ra,0x3
    800040a4:	df4080e7          	jalr	-524(ra) # 80006e94 <plic_claim>
    800040a8:	00003097          	auipc	ra,0x3
    800040ac:	e24080e7          	jalr	-476(ra) # 80006ecc <plic_complete>
        RiscV::w_sstatus(sstatus);
    800040b0:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800040b4:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800040b8:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800040bc:	14179073          	csrw	sepc,a5
}
    800040c0:	df9ff06f          	j	80003eb8 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    800040c4:	fff78793          	addi	a5,a5,-1
    800040c8:	00008717          	auipc	a4,0x8
    800040cc:	a2073703          	ld	a4,-1504(a4) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800040d0:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800040d4:	00000097          	auipc	ra,0x0
    800040d8:	338080e7          	jalr	824(ra) # 8000440c <_ZN11ConsoleUtil8putInputEc>
    800040dc:	fc5ff06f          	j	800040a0 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    800040e0:	00008797          	auipc	a5,0x8
    800040e4:	a607b783          	ld	a5,-1440(a5) # 8000bb40 <_GLOBAL_OFFSET_TABLE_+0x90>
    800040e8:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800040ec:	00200713          	li	a4,2
    800040f0:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800040f4:	00005517          	auipc	a0,0x5
    800040f8:	0b450513          	addi	a0,a0,180 # 800091a8 <CONSOLE_STATUS+0x198>
    800040fc:	00000097          	auipc	ra,0x0
    80004100:	4e8080e7          	jalr	1256(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004104:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004108:	00000613          	li	a2,0
    8000410c:	01000593          	li	a1,16
    80004110:	0005051b          	sext.w	a0,a0
    80004114:	00000097          	auipc	ra,0x0
    80004118:	514080e7          	jalr	1300(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000411c:	00005517          	auipc	a0,0x5
    80004120:	08450513          	addi	a0,a0,132 # 800091a0 <CONSOLE_STATUS+0x190>
    80004124:	00000097          	auipc	ra,0x0
    80004128:	4c0080e7          	jalr	1216(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    8000412c:	00005517          	auipc	a0,0x5
    80004130:	08450513          	addi	a0,a0,132 # 800091b0 <CONSOLE_STATUS+0x1a0>
    80004134:	00000097          	auipc	ra,0x0
    80004138:	4b0080e7          	jalr	1200(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    8000413c:	ffffe097          	auipc	ra,0xffffe
    80004140:	5bc080e7          	jalr	1468(ra) # 800026f8 <_ZN3TCB8dispatchEv>
    80004144:	d75ff06f          	j	80003eb8 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

0000000080004148 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004148:	ff010113          	addi	sp,sp,-16
    8000414c:	00813423          	sd	s0,8(sp)
    80004150:	01010413          	addi	s0,sp,16
}
    80004154:	00813403          	ld	s0,8(sp)
    80004158:	01010113          	addi	sp,sp,16
    8000415c:	00008067          	ret

0000000080004160 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004160:	ff010113          	addi	sp,sp,-16
    80004164:	00813423          	sd	s0,8(sp)
    80004168:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    8000416c:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004170:	00008797          	auipc	a5,0x8
    80004174:	c107b783          	ld	a5,-1008(a5) # 8000bd80 <_ZN9Scheduler9readyHeadE>
    80004178:	02078263          	beqz	a5,8000419c <_ZN9Scheduler3putEP3TCB+0x3c>
    8000417c:	00008797          	auipc	a5,0x8
    80004180:	c0c7b783          	ld	a5,-1012(a5) # 8000bd88 <_ZN9Scheduler9readyTailE>
    80004184:	04a7b423          	sd	a0,72(a5)
    80004188:	00008797          	auipc	a5,0x8
    8000418c:	c0a7b023          	sd	a0,-1024(a5) # 8000bd88 <_ZN9Scheduler9readyTailE>
}
    80004190:	00813403          	ld	s0,8(sp)
    80004194:	01010113          	addi	sp,sp,16
    80004198:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    8000419c:	00008797          	auipc	a5,0x8
    800041a0:	bea7b223          	sd	a0,-1052(a5) # 8000bd80 <_ZN9Scheduler9readyHeadE>
    800041a4:	fe5ff06f          	j	80004188 <_ZN9Scheduler3putEP3TCB+0x28>

00000000800041a8 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800041a8:	ff010113          	addi	sp,sp,-16
    800041ac:	00813423          	sd	s0,8(sp)
    800041b0:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800041b4:	00008517          	auipc	a0,0x8
    800041b8:	bcc53503          	ld	a0,-1076(a0) # 8000bd80 <_ZN9Scheduler9readyHeadE>
    800041bc:	00050a63          	beqz	a0,800041d0 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    800041c0:	04853783          	ld	a5,72(a0)
    800041c4:	00008717          	auipc	a4,0x8
    800041c8:	baf73e23          	sd	a5,-1092(a4) # 8000bd80 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    800041cc:	04053423          	sd	zero,72(a0)
    return tmp;
}
    800041d0:	00813403          	ld	s0,8(sp)
    800041d4:	01010113          	addi	sp,sp,16
    800041d8:	00008067          	ret

00000000800041dc <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    800041dc:	ff010113          	addi	sp,sp,-16
    800041e0:	00813423          	sd	s0,8(sp)
    800041e4:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800041e8:	00008797          	auipc	a5,0x8
    800041ec:	ba87b783          	ld	a5,-1112(a5) # 8000bd90 <_ZN9Scheduler12sleepingHeadE>
    800041f0:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800041f4:	00078e63          	beqz	a5,80004210 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800041f8:	0587b683          	ld	a3,88(a5)
    800041fc:	05853703          	ld	a4,88(a0)
    80004200:	00d76863          	bltu	a4,a3,80004210 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004204:	00078613          	mv	a2,a5
    80004208:	0487b783          	ld	a5,72(a5)
    8000420c:	fe9ff06f          	j	800041f4 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004210:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004214:	00060a63          	beqz	a2,80004228 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004218:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    8000421c:	00813403          	ld	s0,8(sp)
    80004220:	01010113          	addi	sp,sp,16
    80004224:	00008067          	ret
        sleepingHead = t;
    80004228:	00008797          	auipc	a5,0x8
    8000422c:	b6a7b423          	sd	a0,-1176(a5) # 8000bd90 <_ZN9Scheduler12sleepingHeadE>
}
    80004230:	fedff06f          	j	8000421c <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004234 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004234:	fe010113          	addi	sp,sp,-32
    80004238:	00113c23          	sd	ra,24(sp)
    8000423c:	00813823          	sd	s0,16(sp)
    80004240:	00913423          	sd	s1,8(sp)
    80004244:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004248:	00008497          	auipc	s1,0x8
    8000424c:	b484b483          	ld	s1,-1208(s1) # 8000bd90 <_ZN9Scheduler12sleepingHeadE>
    80004250:	02048c63          	beqz	s1,80004288 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004254:	0584b703          	ld	a4,88(s1)
    80004258:	00008797          	auipc	a5,0x8
    8000425c:	9007b783          	ld	a5,-1792(a5) # 8000bb58 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004260:	0007b783          	ld	a5,0(a5)
    80004264:	02e7e263          	bltu	a5,a4,80004288 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004268:	0484b783          	ld	a5,72(s1)
    8000426c:	00008717          	auipc	a4,0x8
    80004270:	b2f73223          	sd	a5,-1244(a4) # 8000bd90 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004274:	00048513          	mv	a0,s1
    80004278:	00000097          	auipc	ra,0x0
    8000427c:	ee8080e7          	jalr	-280(ra) # 80004160 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004280:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004284:	fc5ff06f          	j	80004248 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004288:	01813083          	ld	ra,24(sp)
    8000428c:	01013403          	ld	s0,16(sp)
    80004290:	00813483          	ld	s1,8(sp)
    80004294:	02010113          	addi	sp,sp,32
    80004298:	00008067          	ret

000000008000429c <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    8000429c:	fe010113          	addi	sp,sp,-32
    800042a0:	00113c23          	sd	ra,24(sp)
    800042a4:	00813823          	sd	s0,16(sp)
    800042a8:	00913423          	sd	s1,8(sp)
    800042ac:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    800042b0:	00008497          	auipc	s1,0x8
    800042b4:	ad04b483          	ld	s1,-1328(s1) # 8000bd80 <_ZN9Scheduler9readyHeadE>
    while(iter){
    800042b8:	02048863          	beqz	s1,800042e8 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    800042bc:	00000613          	li	a2,0
    800042c0:	01000593          	li	a1,16
    800042c4:	0004851b          	sext.w	a0,s1
    800042c8:	00000097          	auipc	ra,0x0
    800042cc:	360080e7          	jalr	864(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800042d0:	00005517          	auipc	a0,0x5
    800042d4:	ed050513          	addi	a0,a0,-304 # 800091a0 <CONSOLE_STATUS+0x190>
    800042d8:	00000097          	auipc	ra,0x0
    800042dc:	30c080e7          	jalr	780(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    800042e0:	0484b483          	ld	s1,72(s1)
    while(iter){
    800042e4:	fd5ff06f          	j	800042b8 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    800042e8:	01813083          	ld	ra,24(sp)
    800042ec:	01013403          	ld	s0,16(sp)
    800042f0:	00813483          	ld	s1,8(sp)
    800042f4:	02010113          	addi	sp,sp,32
    800042f8:	00008067          	ret

00000000800042fc <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800042fc:	fe010113          	addi	sp,sp,-32
    80004300:	00113c23          	sd	ra,24(sp)
    80004304:	00813823          	sd	s0,16(sp)
    80004308:	00913423          	sd	s1,8(sp)
    8000430c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004310:	00008497          	auipc	s1,0x8
    80004314:	a804b483          	ld	s1,-1408(s1) # 8000bd90 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004318:	02048863          	beqz	s1,80004348 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    8000431c:	00000613          	li	a2,0
    80004320:	01000593          	li	a1,16
    80004324:	0004851b          	sext.w	a0,s1
    80004328:	ffffe097          	auipc	ra,0xffffe
    8000432c:	f44080e7          	jalr	-188(ra) # 8000226c <_Z8printIntiii>
        printString("\n");
    80004330:	00005517          	auipc	a0,0x5
    80004334:	e7050513          	addi	a0,a0,-400 # 800091a0 <CONSOLE_STATUS+0x190>
    80004338:	ffffe097          	auipc	ra,0xffffe
    8000433c:	d9c080e7          	jalr	-612(ra) # 800020d4 <_Z11printStringPKc>
        iter = iter->next;
    80004340:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004344:	fd5ff06f          	j	80004318 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004348:	01813083          	ld	ra,24(sp)
    8000434c:	01013403          	ld	s0,16(sp)
    80004350:	00813483          	ld	s1,8(sp)
    80004354:	02010113          	addi	sp,sp,32
    80004358:	00008067          	ret

000000008000435c <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    8000435c:	fe010113          	addi	sp,sp,-32
    80004360:	00113c23          	sd	ra,24(sp)
    80004364:	00813823          	sd	s0,16(sp)
    80004368:	00913423          	sd	s1,8(sp)
    8000436c:	01213023          	sd	s2,0(sp)
    80004370:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004374:	01800513          	li	a0,24
    80004378:	ffffe097          	auipc	ra,0xffffe
    8000437c:	1c4080e7          	jalr	452(ra) # 8000253c <_ZN3SCBnwEm>
    80004380:	00050493          	mv	s1,a0
    80004384:	00000593          	li	a1,0
    80004388:	ffffe097          	auipc	ra,0xffffe
    8000438c:	ff8080e7          	jalr	-8(ra) # 80002380 <_ZN3SCBC1Em>
    80004390:	00008797          	auipc	a5,0x8
    80004394:	a097b423          	sd	s1,-1528(a5) # 8000bd98 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004398:	01800513          	li	a0,24
    8000439c:	ffffe097          	auipc	ra,0xffffe
    800043a0:	1a0080e7          	jalr	416(ra) # 8000253c <_ZN3SCBnwEm>
    800043a4:	00050493          	mv	s1,a0
    800043a8:	00000593          	li	a1,0
    800043ac:	ffffe097          	auipc	ra,0xffffe
    800043b0:	fd4080e7          	jalr	-44(ra) # 80002380 <_ZN3SCBC1Em>
    800043b4:	00008797          	auipc	a5,0x8
    800043b8:	9e97b623          	sd	s1,-1556(a5) # 8000bda0 <_ZN11ConsoleUtil9outputSemE>
}
    800043bc:	01813083          	ld	ra,24(sp)
    800043c0:	01013403          	ld	s0,16(sp)
    800043c4:	00813483          	ld	s1,8(sp)
    800043c8:	00013903          	ld	s2,0(sp)
    800043cc:	02010113          	addi	sp,sp,32
    800043d0:	00008067          	ret
    800043d4:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    800043d8:	00048513          	mv	a0,s1
    800043dc:	ffffe097          	auipc	ra,0xffffe
    800043e0:	188080e7          	jalr	392(ra) # 80002564 <_ZN3SCBdlEPv>
    800043e4:	00090513          	mv	a0,s2
    800043e8:	0000d097          	auipc	ra,0xd
    800043ec:	ae0080e7          	jalr	-1312(ra) # 80010ec8 <_Unwind_Resume>
    800043f0:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    800043f4:	00048513          	mv	a0,s1
    800043f8:	ffffe097          	auipc	ra,0xffffe
    800043fc:	16c080e7          	jalr	364(ra) # 80002564 <_ZN3SCBdlEPv>
    80004400:	00090513          	mv	a0,s2
    80004404:	0000d097          	auipc	ra,0xd
    80004408:	ac4080e7          	jalr	-1340(ra) # 80010ec8 <_Unwind_Resume>

000000008000440c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    8000440c:	00008697          	auipc	a3,0x8
    80004410:	98c68693          	addi	a3,a3,-1652 # 8000bd98 <_ZN11ConsoleUtil8inputSemE>
    80004414:	0106b603          	ld	a2,16(a3)
    80004418:	00160793          	addi	a5,a2,1
    8000441c:	00002737          	lui	a4,0x2
    80004420:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004424:	00e7f7b3          	and	a5,a5,a4
    80004428:	0186b703          	ld	a4,24(a3)
    8000442c:	04e78263          	beq	a5,a4,80004470 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80004430:	ff010113          	addi	sp,sp,-16
    80004434:	00113423          	sd	ra,8(sp)
    80004438:	00813023          	sd	s0,0(sp)
    8000443c:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004440:	0000a717          	auipc	a4,0xa
    80004444:	99070713          	addi	a4,a4,-1648 # 8000ddd0 <_ZN11ConsoleUtil11inputBufferE>
    80004448:	00c70633          	add	a2,a4,a2
    8000444c:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80004450:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    80004454:	0006b503          	ld	a0,0(a3)
    80004458:	ffffe097          	auipc	ra,0xffffe
    8000445c:	0a8080e7          	jalr	168(ra) # 80002500 <_ZN3SCB6signalEv>
}
    80004460:	00813083          	ld	ra,8(sp)
    80004464:	00013403          	ld	s0,0(sp)
    80004468:	01010113          	addi	sp,sp,16
    8000446c:	00008067          	ret
    80004470:	00008067          	ret

0000000080004474 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004474:	fe010113          	addi	sp,sp,-32
    80004478:	00113c23          	sd	ra,24(sp)
    8000447c:	00813823          	sd	s0,16(sp)
    80004480:	00913423          	sd	s1,8(sp)
    80004484:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004488:	00008497          	auipc	s1,0x8
    8000448c:	91048493          	addi	s1,s1,-1776 # 8000bd98 <_ZN11ConsoleUtil8inputSemE>
    80004490:	0004b503          	ld	a0,0(s1)
    80004494:	ffffe097          	auipc	ra,0xffffe
    80004498:	01c080e7          	jalr	28(ra) # 800024b0 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    8000449c:	0184b783          	ld	a5,24(s1)
    800044a0:	0104b703          	ld	a4,16(s1)
    800044a4:	04e78063          	beq	a5,a4,800044e4 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    800044a8:	0000a717          	auipc	a4,0xa
    800044ac:	92870713          	addi	a4,a4,-1752 # 8000ddd0 <_ZN11ConsoleUtil11inputBufferE>
    800044b0:	00f70733          	add	a4,a4,a5
    800044b4:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    800044b8:	00178793          	addi	a5,a5,1
    800044bc:	00002737          	lui	a4,0x2
    800044c0:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    800044c4:	00e7f7b3          	and	a5,a5,a4
    800044c8:	00008717          	auipc	a4,0x8
    800044cc:	8ef73423          	sd	a5,-1816(a4) # 8000bdb0 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    800044d0:	01813083          	ld	ra,24(sp)
    800044d4:	01013403          	ld	s0,16(sp)
    800044d8:	00813483          	ld	s1,8(sp)
    800044dc:	02010113          	addi	sp,sp,32
    800044e0:	00008067          	ret
        return -1;
    800044e4:	0ff00513          	li	a0,255
    800044e8:	fe9ff06f          	j	800044d0 <_ZN11ConsoleUtil8getInputEv+0x5c>

00000000800044ec <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    800044ec:	00008797          	auipc	a5,0x8
    800044f0:	8ac78793          	addi	a5,a5,-1876 # 8000bd98 <_ZN11ConsoleUtil8inputSemE>
    800044f4:	0207b603          	ld	a2,32(a5)
    800044f8:	00160713          	addi	a4,a2,1
    800044fc:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004500:	0287b583          	ld	a1,40(a5)
    80004504:	00158713          	addi	a4,a1,1
    80004508:	000026b7          	lui	a3,0x2
    8000450c:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004510:	00d77733          	and	a4,a4,a3
    80004514:	0307b783          	ld	a5,48(a5)
    80004518:	04f70863          	beq	a4,a5,80004568 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    8000451c:	ff010113          	addi	sp,sp,-16
    80004520:	00113423          	sd	ra,8(sp)
    80004524:	00813023          	sd	s0,0(sp)
    80004528:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    8000452c:	00008797          	auipc	a5,0x8
    80004530:	8a478793          	addi	a5,a5,-1884 # 8000bdd0 <_ZN11ConsoleUtil12outputBufferE>
    80004534:	00b785b3          	add	a1,a5,a1
    80004538:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    8000453c:	00008797          	auipc	a5,0x8
    80004540:	85c78793          	addi	a5,a5,-1956 # 8000bd98 <_ZN11ConsoleUtil8inputSemE>
    80004544:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004548:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    8000454c:	0087b503          	ld	a0,8(a5)
    80004550:	ffffe097          	auipc	ra,0xffffe
    80004554:	fb0080e7          	jalr	-80(ra) # 80002500 <_ZN3SCB6signalEv>
}
    80004558:	00813083          	ld	ra,8(sp)
    8000455c:	00013403          	ld	s0,0(sp)
    80004560:	01010113          	addi	sp,sp,16
    80004564:	00008067          	ret
    80004568:	00008067          	ret

000000008000456c <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    8000456c:	fe010113          	addi	sp,sp,-32
    80004570:	00113c23          	sd	ra,24(sp)
    80004574:	00813823          	sd	s0,16(sp)
    80004578:	00913423          	sd	s1,8(sp)
    8000457c:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004580:	00008497          	auipc	s1,0x8
    80004584:	81848493          	addi	s1,s1,-2024 # 8000bd98 <_ZN11ConsoleUtil8inputSemE>
    80004588:	0084b503          	ld	a0,8(s1)
    8000458c:	ffffe097          	auipc	ra,0xffffe
    80004590:	f24080e7          	jalr	-220(ra) # 800024b0 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004594:	0304b783          	ld	a5,48(s1)
    80004598:	0284b703          	ld	a4,40(s1)
    8000459c:	04e78063          	beq	a5,a4,800045dc <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    800045a0:	00008717          	auipc	a4,0x8
    800045a4:	83070713          	addi	a4,a4,-2000 # 8000bdd0 <_ZN11ConsoleUtil12outputBufferE>
    800045a8:	00f70733          	add	a4,a4,a5
    800045ac:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    800045b0:	00178793          	addi	a5,a5,1
    800045b4:	00002737          	lui	a4,0x2
    800045b8:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    800045bc:	00e7f7b3          	and	a5,a5,a4
    800045c0:	00008717          	auipc	a4,0x8
    800045c4:	80f73423          	sd	a5,-2040(a4) # 8000bdc8 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    800045c8:	01813083          	ld	ra,24(sp)
    800045cc:	01013403          	ld	s0,16(sp)
    800045d0:	00813483          	ld	s1,8(sp)
    800045d4:	02010113          	addi	sp,sp,32
    800045d8:	00008067          	ret
        return -1;
    800045dc:	0ff00513          	li	a0,255
    800045e0:	fe9ff06f          	j	800045c8 <_ZN11ConsoleUtil9getOutputEv+0x5c>

00000000800045e4 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    800045e4:	fe010113          	addi	sp,sp,-32
    800045e8:	00113c23          	sd	ra,24(sp)
    800045ec:	00813823          	sd	s0,16(sp)
    800045f0:	00913423          	sd	s1,8(sp)
    800045f4:	02010413          	addi	s0,sp,32
    800045f8:	00050493          	mv	s1,a0
    while (*string != '\0')
    800045fc:	0004c503          	lbu	a0,0(s1)
    80004600:	00050a63          	beqz	a0,80004614 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004604:	00000097          	auipc	ra,0x0
    80004608:	ee8080e7          	jalr	-280(ra) # 800044ec <_ZN11ConsoleUtil9putOutputEc>
        string++;
    8000460c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004610:	fedff06f          	j	800045fc <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004614:	01813083          	ld	ra,24(sp)
    80004618:	01013403          	ld	s0,16(sp)
    8000461c:	00813483          	ld	s1,8(sp)
    80004620:	02010113          	addi	sp,sp,32
    80004624:	00008067          	ret

0000000080004628 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004628:	fb010113          	addi	sp,sp,-80
    8000462c:	04113423          	sd	ra,72(sp)
    80004630:	04813023          	sd	s0,64(sp)
    80004634:	02913c23          	sd	s1,56(sp)
    80004638:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    8000463c:	00005797          	auipc	a5,0x5
    80004640:	d5c78793          	addi	a5,a5,-676 # 80009398 <CONSOLE_STATUS+0x388>
    80004644:	0007b703          	ld	a4,0(a5)
    80004648:	fce43423          	sd	a4,-56(s0)
    8000464c:	0087b703          	ld	a4,8(a5)
    80004650:	fce43823          	sd	a4,-48(s0)
    80004654:	0107c783          	lbu	a5,16(a5)
    80004658:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000465c:	00060463          	beqz	a2,80004664 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004660:	08054263          	bltz	a0,800046e4 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004664:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004668:	00000813          	li	a6,0
    }

    i = 0;
    8000466c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004670:	0005871b          	sext.w	a4,a1
    80004674:	02b577bb          	remuw	a5,a0,a1
    80004678:	00048693          	mv	a3,s1
    8000467c:	0014849b          	addiw	s1,s1,1
    80004680:	02079793          	slli	a5,a5,0x20
    80004684:	0207d793          	srli	a5,a5,0x20
    80004688:	fe040613          	addi	a2,s0,-32
    8000468c:	00f607b3          	add	a5,a2,a5
    80004690:	fe87c603          	lbu	a2,-24(a5)
    80004694:	fe040793          	addi	a5,s0,-32
    80004698:	00d787b3          	add	a5,a5,a3
    8000469c:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    800046a0:	0005061b          	sext.w	a2,a0
    800046a4:	02b5553b          	divuw	a0,a0,a1
    800046a8:	fce674e3          	bgeu	a2,a4,80004670 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    800046ac:	00080c63          	beqz	a6,800046c4 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    800046b0:	fe040793          	addi	a5,s0,-32
    800046b4:	009784b3          	add	s1,a5,s1
    800046b8:	02d00793          	li	a5,45
    800046bc:	fcf48c23          	sb	a5,-40(s1)
    800046c0:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    800046c4:	fff4849b          	addiw	s1,s1,-1
    800046c8:	0204c463          	bltz	s1,800046f0 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    800046cc:	fe040793          	addi	a5,s0,-32
    800046d0:	009787b3          	add	a5,a5,s1
    800046d4:	fd87c503          	lbu	a0,-40(a5)
    800046d8:	00000097          	auipc	ra,0x0
    800046dc:	e14080e7          	jalr	-492(ra) # 800044ec <_ZN11ConsoleUtil9putOutputEc>
    800046e0:	fe5ff06f          	j	800046c4 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    800046e4:	40a0053b          	negw	a0,a0
        neg = 1;
    800046e8:	00100813          	li	a6,1
        x = -xx;
    800046ec:	f81ff06f          	j	8000466c <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    800046f0:	04813083          	ld	ra,72(sp)
    800046f4:	04013403          	ld	s0,64(sp)
    800046f8:	03813483          	ld	s1,56(sp)
    800046fc:	05010113          	addi	sp,sp,80
    80004700:	00008067          	ret

0000000080004704 <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    80004704:	fe010113          	addi	sp,sp,-32
    80004708:	00113c23          	sd	ra,24(sp)
    8000470c:	00813823          	sd	s0,16(sp)
    80004710:	00913423          	sd	s1,8(sp)
    80004714:	01213023          	sd	s2,0(sp)
    80004718:	02010413          	addi	s0,sp,32
    8000471c:	00058913          	mv	s2,a1
    80004720:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    80004724:	00000097          	auipc	ra,0x0
    80004728:	ec0080e7          	jalr	-320(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    8000472c:	00000613          	li	a2,0
    80004730:	00a00593          	li	a1,10
    80004734:	00090513          	mv	a0,s2
    80004738:	00000097          	auipc	ra,0x0
    8000473c:	ef0080e7          	jalr	-272(ra) # 80004628 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004740:	00048513          	mv	a0,s1
    80004744:	00000097          	auipc	ra,0x0
    80004748:	ea0080e7          	jalr	-352(ra) # 800045e4 <_ZN11ConsoleUtil11printStringEPKc>
}
    8000474c:	01813083          	ld	ra,24(sp)
    80004750:	01013403          	ld	s0,16(sp)
    80004754:	00813483          	ld	s1,8(sp)
    80004758:	00013903          	ld	s2,0(sp)
    8000475c:	02010113          	addi	sp,sp,32
    80004760:	00008067          	ret

0000000080004764 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004764:	ff010113          	addi	sp,sp,-16
    80004768:	00813423          	sd	s0,8(sp)
    8000476c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004770:	04300513          	li	a0,67

    asm("ecall");
    80004774:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004778:	00050513          	mv	a0,a0

    return (char)status;
}
    8000477c:	0ff57513          	andi	a0,a0,255
    80004780:	00813403          	ld	s0,8(sp)
    80004784:	01010113          	addi	sp,sp,16
    80004788:	00008067          	ret

000000008000478c <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    8000478c:	ff010113          	addi	sp,sp,-16
    80004790:	00113423          	sd	ra,8(sp)
    80004794:	00813023          	sd	s0,0(sp)
    80004798:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    8000479c:	ffffd097          	auipc	ra,0xffffd
    800047a0:	dcc080e7          	jalr	-564(ra) # 80001568 <_ZN13SlabAllocator10initializeEPvm>
    800047a4:	00813083          	ld	ra,8(sp)
    800047a8:	00013403          	ld	s0,0(sp)
    800047ac:	01010113          	addi	sp,sp,16
    800047b0:	00008067          	ret

00000000800047b4 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800047b4:	fd010113          	addi	sp,sp,-48
    800047b8:	02113423          	sd	ra,40(sp)
    800047bc:	02813023          	sd	s0,32(sp)
    800047c0:	00913c23          	sd	s1,24(sp)
    800047c4:	01213823          	sd	s2,16(sp)
    800047c8:	01313423          	sd	s3,8(sp)
    800047cc:	03010413          	addi	s0,sp,48
    800047d0:	00050493          	mv	s1,a0
    800047d4:	00058913          	mv	s2,a1
    800047d8:	0015879b          	addiw	a5,a1,1
    800047dc:	0007851b          	sext.w	a0,a5
    800047e0:	00f4a023          	sw	a5,0(s1)
    800047e4:	0004a823          	sw	zero,16(s1)
    800047e8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800047ec:	00251513          	slli	a0,a0,0x2
    800047f0:	ffffd097          	auipc	ra,0xffffd
    800047f4:	e64080e7          	jalr	-412(ra) # 80001654 <_Z9mem_allocm>
    800047f8:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800047fc:	01000513          	li	a0,16
    80004800:	ffffe097          	auipc	ra,0xffffe
    80004804:	600080e7          	jalr	1536(ra) # 80002e00 <_Znwm>
    80004808:	00050993          	mv	s3,a0
    8000480c:	00000593          	li	a1,0
    80004810:	ffffe097          	auipc	ra,0xffffe
    80004814:	6e8080e7          	jalr	1768(ra) # 80002ef8 <_ZN9SemaphoreC1Ej>
    80004818:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000481c:	01000513          	li	a0,16
    80004820:	ffffe097          	auipc	ra,0xffffe
    80004824:	5e0080e7          	jalr	1504(ra) # 80002e00 <_Znwm>
    80004828:	00050993          	mv	s3,a0
    8000482c:	00090593          	mv	a1,s2
    80004830:	ffffe097          	auipc	ra,0xffffe
    80004834:	6c8080e7          	jalr	1736(ra) # 80002ef8 <_ZN9SemaphoreC1Ej>
    80004838:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    8000483c:	01000513          	li	a0,16
    80004840:	ffffe097          	auipc	ra,0xffffe
    80004844:	5c0080e7          	jalr	1472(ra) # 80002e00 <_Znwm>
    80004848:	00050913          	mv	s2,a0
    8000484c:	00100593          	li	a1,1
    80004850:	ffffe097          	auipc	ra,0xffffe
    80004854:	6a8080e7          	jalr	1704(ra) # 80002ef8 <_ZN9SemaphoreC1Ej>
    80004858:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000485c:	01000513          	li	a0,16
    80004860:	ffffe097          	auipc	ra,0xffffe
    80004864:	5a0080e7          	jalr	1440(ra) # 80002e00 <_Znwm>
    80004868:	00050913          	mv	s2,a0
    8000486c:	00100593          	li	a1,1
    80004870:	ffffe097          	auipc	ra,0xffffe
    80004874:	688080e7          	jalr	1672(ra) # 80002ef8 <_ZN9SemaphoreC1Ej>
    80004878:	0324b823          	sd	s2,48(s1)
}
    8000487c:	02813083          	ld	ra,40(sp)
    80004880:	02013403          	ld	s0,32(sp)
    80004884:	01813483          	ld	s1,24(sp)
    80004888:	01013903          	ld	s2,16(sp)
    8000488c:	00813983          	ld	s3,8(sp)
    80004890:	03010113          	addi	sp,sp,48
    80004894:	00008067          	ret
    80004898:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000489c:	00098513          	mv	a0,s3
    800048a0:	ffffe097          	auipc	ra,0xffffe
    800048a4:	5b0080e7          	jalr	1456(ra) # 80002e50 <_ZdlPv>
    800048a8:	00048513          	mv	a0,s1
    800048ac:	0000c097          	auipc	ra,0xc
    800048b0:	61c080e7          	jalr	1564(ra) # 80010ec8 <_Unwind_Resume>
    800048b4:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800048b8:	00098513          	mv	a0,s3
    800048bc:	ffffe097          	auipc	ra,0xffffe
    800048c0:	594080e7          	jalr	1428(ra) # 80002e50 <_ZdlPv>
    800048c4:	00048513          	mv	a0,s1
    800048c8:	0000c097          	auipc	ra,0xc
    800048cc:	600080e7          	jalr	1536(ra) # 80010ec8 <_Unwind_Resume>
    800048d0:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800048d4:	00090513          	mv	a0,s2
    800048d8:	ffffe097          	auipc	ra,0xffffe
    800048dc:	578080e7          	jalr	1400(ra) # 80002e50 <_ZdlPv>
    800048e0:	00048513          	mv	a0,s1
    800048e4:	0000c097          	auipc	ra,0xc
    800048e8:	5e4080e7          	jalr	1508(ra) # 80010ec8 <_Unwind_Resume>
    800048ec:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800048f0:	00090513          	mv	a0,s2
    800048f4:	ffffe097          	auipc	ra,0xffffe
    800048f8:	55c080e7          	jalr	1372(ra) # 80002e50 <_ZdlPv>
    800048fc:	00048513          	mv	a0,s1
    80004900:	0000c097          	auipc	ra,0xc
    80004904:	5c8080e7          	jalr	1480(ra) # 80010ec8 <_Unwind_Resume>

0000000080004908 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004908:	fe010113          	addi	sp,sp,-32
    8000490c:	00113c23          	sd	ra,24(sp)
    80004910:	00813823          	sd	s0,16(sp)
    80004914:	00913423          	sd	s1,8(sp)
    80004918:	01213023          	sd	s2,0(sp)
    8000491c:	02010413          	addi	s0,sp,32
    80004920:	00050493          	mv	s1,a0
    80004924:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004928:	01853503          	ld	a0,24(a0)
    8000492c:	ffffe097          	auipc	ra,0xffffe
    80004930:	604080e7          	jalr	1540(ra) # 80002f30 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004934:	0304b503          	ld	a0,48(s1)
    80004938:	ffffe097          	auipc	ra,0xffffe
    8000493c:	5f8080e7          	jalr	1528(ra) # 80002f30 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004940:	0084b783          	ld	a5,8(s1)
    80004944:	0144a703          	lw	a4,20(s1)
    80004948:	00271713          	slli	a4,a4,0x2
    8000494c:	00e787b3          	add	a5,a5,a4
    80004950:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004954:	0144a783          	lw	a5,20(s1)
    80004958:	0017879b          	addiw	a5,a5,1
    8000495c:	0004a703          	lw	a4,0(s1)
    80004960:	02e7e7bb          	remw	a5,a5,a4
    80004964:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004968:	0304b503          	ld	a0,48(s1)
    8000496c:	ffffe097          	auipc	ra,0xffffe
    80004970:	5f0080e7          	jalr	1520(ra) # 80002f5c <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004974:	0204b503          	ld	a0,32(s1)
    80004978:	ffffe097          	auipc	ra,0xffffe
    8000497c:	5e4080e7          	jalr	1508(ra) # 80002f5c <_ZN9Semaphore6signalEv>

}
    80004980:	01813083          	ld	ra,24(sp)
    80004984:	01013403          	ld	s0,16(sp)
    80004988:	00813483          	ld	s1,8(sp)
    8000498c:	00013903          	ld	s2,0(sp)
    80004990:	02010113          	addi	sp,sp,32
    80004994:	00008067          	ret

0000000080004998 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004998:	fe010113          	addi	sp,sp,-32
    8000499c:	00113c23          	sd	ra,24(sp)
    800049a0:	00813823          	sd	s0,16(sp)
    800049a4:	00913423          	sd	s1,8(sp)
    800049a8:	01213023          	sd	s2,0(sp)
    800049ac:	02010413          	addi	s0,sp,32
    800049b0:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800049b4:	02053503          	ld	a0,32(a0)
    800049b8:	ffffe097          	auipc	ra,0xffffe
    800049bc:	578080e7          	jalr	1400(ra) # 80002f30 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800049c0:	0284b503          	ld	a0,40(s1)
    800049c4:	ffffe097          	auipc	ra,0xffffe
    800049c8:	56c080e7          	jalr	1388(ra) # 80002f30 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800049cc:	0084b703          	ld	a4,8(s1)
    800049d0:	0104a783          	lw	a5,16(s1)
    800049d4:	00279693          	slli	a3,a5,0x2
    800049d8:	00d70733          	add	a4,a4,a3
    800049dc:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800049e0:	0017879b          	addiw	a5,a5,1
    800049e4:	0004a703          	lw	a4,0(s1)
    800049e8:	02e7e7bb          	remw	a5,a5,a4
    800049ec:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800049f0:	0284b503          	ld	a0,40(s1)
    800049f4:	ffffe097          	auipc	ra,0xffffe
    800049f8:	568080e7          	jalr	1384(ra) # 80002f5c <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800049fc:	0184b503          	ld	a0,24(s1)
    80004a00:	ffffe097          	auipc	ra,0xffffe
    80004a04:	55c080e7          	jalr	1372(ra) # 80002f5c <_ZN9Semaphore6signalEv>

    return ret;
}
    80004a08:	00090513          	mv	a0,s2
    80004a0c:	01813083          	ld	ra,24(sp)
    80004a10:	01013403          	ld	s0,16(sp)
    80004a14:	00813483          	ld	s1,8(sp)
    80004a18:	00013903          	ld	s2,0(sp)
    80004a1c:	02010113          	addi	sp,sp,32
    80004a20:	00008067          	ret

0000000080004a24 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004a24:	fe010113          	addi	sp,sp,-32
    80004a28:	00113c23          	sd	ra,24(sp)
    80004a2c:	00813823          	sd	s0,16(sp)
    80004a30:	00913423          	sd	s1,8(sp)
    80004a34:	01213023          	sd	s2,0(sp)
    80004a38:	02010413          	addi	s0,sp,32
    80004a3c:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004a40:	02853503          	ld	a0,40(a0)
    80004a44:	ffffe097          	auipc	ra,0xffffe
    80004a48:	4ec080e7          	jalr	1260(ra) # 80002f30 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004a4c:	0304b503          	ld	a0,48(s1)
    80004a50:	ffffe097          	auipc	ra,0xffffe
    80004a54:	4e0080e7          	jalr	1248(ra) # 80002f30 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004a58:	0144a783          	lw	a5,20(s1)
    80004a5c:	0104a903          	lw	s2,16(s1)
    80004a60:	0327ce63          	blt	a5,s2,80004a9c <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004a64:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004a68:	0304b503          	ld	a0,48(s1)
    80004a6c:	ffffe097          	auipc	ra,0xffffe
    80004a70:	4f0080e7          	jalr	1264(ra) # 80002f5c <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004a74:	0284b503          	ld	a0,40(s1)
    80004a78:	ffffe097          	auipc	ra,0xffffe
    80004a7c:	4e4080e7          	jalr	1252(ra) # 80002f5c <_ZN9Semaphore6signalEv>

    return ret;
}
    80004a80:	00090513          	mv	a0,s2
    80004a84:	01813083          	ld	ra,24(sp)
    80004a88:	01013403          	ld	s0,16(sp)
    80004a8c:	00813483          	ld	s1,8(sp)
    80004a90:	00013903          	ld	s2,0(sp)
    80004a94:	02010113          	addi	sp,sp,32
    80004a98:	00008067          	ret
        ret = cap - head + tail;
    80004a9c:	0004a703          	lw	a4,0(s1)
    80004aa0:	4127093b          	subw	s2,a4,s2
    80004aa4:	00f9093b          	addw	s2,s2,a5
    80004aa8:	fc1ff06f          	j	80004a68 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004aac <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004aac:	fe010113          	addi	sp,sp,-32
    80004ab0:	00113c23          	sd	ra,24(sp)
    80004ab4:	00813823          	sd	s0,16(sp)
    80004ab8:	00913423          	sd	s1,8(sp)
    80004abc:	02010413          	addi	s0,sp,32
    80004ac0:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004ac4:	00a00513          	li	a0,10
    80004ac8:	ffffe097          	auipc	ra,0xffffe
    80004acc:	690080e7          	jalr	1680(ra) # 80003158 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004ad0:	00005517          	auipc	a0,0x5
    80004ad4:	8e050513          	addi	a0,a0,-1824 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80004ad8:	ffffd097          	auipc	ra,0xffffd
    80004adc:	5fc080e7          	jalr	1532(ra) # 800020d4 <_Z11printStringPKc>
    while (getCnt()) {
    80004ae0:	00048513          	mv	a0,s1
    80004ae4:	00000097          	auipc	ra,0x0
    80004ae8:	f40080e7          	jalr	-192(ra) # 80004a24 <_ZN9BufferCPP6getCntEv>
    80004aec:	02050c63          	beqz	a0,80004b24 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004af0:	0084b783          	ld	a5,8(s1)
    80004af4:	0104a703          	lw	a4,16(s1)
    80004af8:	00271713          	slli	a4,a4,0x2
    80004afc:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004b00:	0007c503          	lbu	a0,0(a5)
    80004b04:	ffffe097          	auipc	ra,0xffffe
    80004b08:	654080e7          	jalr	1620(ra) # 80003158 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004b0c:	0104a783          	lw	a5,16(s1)
    80004b10:	0017879b          	addiw	a5,a5,1
    80004b14:	0004a703          	lw	a4,0(s1)
    80004b18:	02e7e7bb          	remw	a5,a5,a4
    80004b1c:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004b20:	fc1ff06f          	j	80004ae0 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004b24:	02100513          	li	a0,33
    80004b28:	ffffe097          	auipc	ra,0xffffe
    80004b2c:	630080e7          	jalr	1584(ra) # 80003158 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004b30:	00a00513          	li	a0,10
    80004b34:	ffffe097          	auipc	ra,0xffffe
    80004b38:	624080e7          	jalr	1572(ra) # 80003158 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004b3c:	0084b503          	ld	a0,8(s1)
    80004b40:	ffffd097          	auipc	ra,0xffffd
    80004b44:	b44080e7          	jalr	-1212(ra) # 80001684 <_Z8mem_freePv>
    delete itemAvailable;
    80004b48:	0204b503          	ld	a0,32(s1)
    80004b4c:	00050863          	beqz	a0,80004b5c <_ZN9BufferCPPD1Ev+0xb0>
    80004b50:	00053783          	ld	a5,0(a0)
    80004b54:	0087b783          	ld	a5,8(a5)
    80004b58:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004b5c:	0184b503          	ld	a0,24(s1)
    80004b60:	00050863          	beqz	a0,80004b70 <_ZN9BufferCPPD1Ev+0xc4>
    80004b64:	00053783          	ld	a5,0(a0)
    80004b68:	0087b783          	ld	a5,8(a5)
    80004b6c:	000780e7          	jalr	a5
    delete mutexTail;
    80004b70:	0304b503          	ld	a0,48(s1)
    80004b74:	00050863          	beqz	a0,80004b84 <_ZN9BufferCPPD1Ev+0xd8>
    80004b78:	00053783          	ld	a5,0(a0)
    80004b7c:	0087b783          	ld	a5,8(a5)
    80004b80:	000780e7          	jalr	a5
    delete mutexHead;
    80004b84:	0284b503          	ld	a0,40(s1)
    80004b88:	00050863          	beqz	a0,80004b98 <_ZN9BufferCPPD1Ev+0xec>
    80004b8c:	00053783          	ld	a5,0(a0)
    80004b90:	0087b783          	ld	a5,8(a5)
    80004b94:	000780e7          	jalr	a5
}
    80004b98:	01813083          	ld	ra,24(sp)
    80004b9c:	01013403          	ld	s0,16(sp)
    80004ba0:	00813483          	ld	s1,8(sp)
    80004ba4:	02010113          	addi	sp,sp,32
    80004ba8:	00008067          	ret

0000000080004bac <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80004bac:	fe010113          	addi	sp,sp,-32
    80004bb0:	00113c23          	sd	ra,24(sp)
    80004bb4:	00813823          	sd	s0,16(sp)
    80004bb8:	00913423          	sd	s1,8(sp)
    80004bbc:	01213023          	sd	s2,0(sp)
    80004bc0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004bc4:	00000913          	li	s2,0
    80004bc8:	0380006f          	j	80004c00 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004bcc:	ffffd097          	auipc	ra,0xffffd
    80004bd0:	b88080e7          	jalr	-1144(ra) # 80001754 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004bd4:	00148493          	addi	s1,s1,1
    80004bd8:	000027b7          	lui	a5,0x2
    80004bdc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004be0:	0097ee63          	bltu	a5,s1,80004bfc <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004be4:	00000713          	li	a4,0
    80004be8:	000077b7          	lui	a5,0x7
    80004bec:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004bf0:	fce7eee3          	bltu	a5,a4,80004bcc <_Z11workerBodyAPv+0x20>
    80004bf4:	00170713          	addi	a4,a4,1
    80004bf8:	ff1ff06f          	j	80004be8 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004bfc:	00190913          	addi	s2,s2,1
    80004c00:	00900793          	li	a5,9
    80004c04:	0527e063          	bltu	a5,s2,80004c44 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004c08:	00004517          	auipc	a0,0x4
    80004c0c:	7c050513          	addi	a0,a0,1984 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80004c10:	ffffd097          	auipc	ra,0xffffd
    80004c14:	4c4080e7          	jalr	1220(ra) # 800020d4 <_Z11printStringPKc>
    80004c18:	00000613          	li	a2,0
    80004c1c:	00a00593          	li	a1,10
    80004c20:	0009051b          	sext.w	a0,s2
    80004c24:	ffffd097          	auipc	ra,0xffffd
    80004c28:	648080e7          	jalr	1608(ra) # 8000226c <_Z8printIntiii>
    80004c2c:	00004517          	auipc	a0,0x4
    80004c30:	57450513          	addi	a0,a0,1396 # 800091a0 <CONSOLE_STATUS+0x190>
    80004c34:	ffffd097          	auipc	ra,0xffffd
    80004c38:	4a0080e7          	jalr	1184(ra) # 800020d4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004c3c:	00000493          	li	s1,0
    80004c40:	f99ff06f          	j	80004bd8 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80004c44:	00004517          	auipc	a0,0x4
    80004c48:	78c50513          	addi	a0,a0,1932 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004c4c:	ffffd097          	auipc	ra,0xffffd
    80004c50:	488080e7          	jalr	1160(ra) # 800020d4 <_Z11printStringPKc>
    finishedA = true;
    80004c54:	00100793          	li	a5,1
    80004c58:	0000b717          	auipc	a4,0xb
    80004c5c:	18f70023          	sb	a5,384(a4) # 8000fdd8 <finishedA>
}
    80004c60:	01813083          	ld	ra,24(sp)
    80004c64:	01013403          	ld	s0,16(sp)
    80004c68:	00813483          	ld	s1,8(sp)
    80004c6c:	00013903          	ld	s2,0(sp)
    80004c70:	02010113          	addi	sp,sp,32
    80004c74:	00008067          	ret

0000000080004c78 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80004c78:	fe010113          	addi	sp,sp,-32
    80004c7c:	00113c23          	sd	ra,24(sp)
    80004c80:	00813823          	sd	s0,16(sp)
    80004c84:	00913423          	sd	s1,8(sp)
    80004c88:	01213023          	sd	s2,0(sp)
    80004c8c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004c90:	00000913          	li	s2,0
    80004c94:	0380006f          	j	80004ccc <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004c98:	ffffd097          	auipc	ra,0xffffd
    80004c9c:	abc080e7          	jalr	-1348(ra) # 80001754 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004ca0:	00148493          	addi	s1,s1,1
    80004ca4:	000027b7          	lui	a5,0x2
    80004ca8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004cac:	0097ee63          	bltu	a5,s1,80004cc8 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004cb0:	00000713          	li	a4,0
    80004cb4:	000077b7          	lui	a5,0x7
    80004cb8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004cbc:	fce7eee3          	bltu	a5,a4,80004c98 <_Z11workerBodyBPv+0x20>
    80004cc0:	00170713          	addi	a4,a4,1
    80004cc4:	ff1ff06f          	j	80004cb4 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004cc8:	00190913          	addi	s2,s2,1
    80004ccc:	00f00793          	li	a5,15
    80004cd0:	0527e063          	bltu	a5,s2,80004d10 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004cd4:	00004517          	auipc	a0,0x4
    80004cd8:	70c50513          	addi	a0,a0,1804 # 800093e0 <CONSOLE_STATUS+0x3d0>
    80004cdc:	ffffd097          	auipc	ra,0xffffd
    80004ce0:	3f8080e7          	jalr	1016(ra) # 800020d4 <_Z11printStringPKc>
    80004ce4:	00000613          	li	a2,0
    80004ce8:	00a00593          	li	a1,10
    80004cec:	0009051b          	sext.w	a0,s2
    80004cf0:	ffffd097          	auipc	ra,0xffffd
    80004cf4:	57c080e7          	jalr	1404(ra) # 8000226c <_Z8printIntiii>
    80004cf8:	00004517          	auipc	a0,0x4
    80004cfc:	4a850513          	addi	a0,a0,1192 # 800091a0 <CONSOLE_STATUS+0x190>
    80004d00:	ffffd097          	auipc	ra,0xffffd
    80004d04:	3d4080e7          	jalr	980(ra) # 800020d4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004d08:	00000493          	li	s1,0
    80004d0c:	f99ff06f          	j	80004ca4 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80004d10:	00004517          	auipc	a0,0x4
    80004d14:	6d850513          	addi	a0,a0,1752 # 800093e8 <CONSOLE_STATUS+0x3d8>
    80004d18:	ffffd097          	auipc	ra,0xffffd
    80004d1c:	3bc080e7          	jalr	956(ra) # 800020d4 <_Z11printStringPKc>
    finishedB = true;
    80004d20:	00100793          	li	a5,1
    80004d24:	0000b717          	auipc	a4,0xb
    80004d28:	0af70aa3          	sb	a5,181(a4) # 8000fdd9 <finishedB>
    thread_dispatch();
    80004d2c:	ffffd097          	auipc	ra,0xffffd
    80004d30:	a28080e7          	jalr	-1496(ra) # 80001754 <_Z15thread_dispatchv>
}
    80004d34:	01813083          	ld	ra,24(sp)
    80004d38:	01013403          	ld	s0,16(sp)
    80004d3c:	00813483          	ld	s1,8(sp)
    80004d40:	00013903          	ld	s2,0(sp)
    80004d44:	02010113          	addi	sp,sp,32
    80004d48:	00008067          	ret

0000000080004d4c <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80004d4c:	fe010113          	addi	sp,sp,-32
    80004d50:	00113c23          	sd	ra,24(sp)
    80004d54:	00813823          	sd	s0,16(sp)
    80004d58:	00913423          	sd	s1,8(sp)
    80004d5c:	01213023          	sd	s2,0(sp)
    80004d60:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80004d64:	00053903          	ld	s2,0(a0)
    int i = 6;
    80004d68:	00600493          	li	s1,6
    while (--i > 0) {
    80004d6c:	fff4849b          	addiw	s1,s1,-1
    80004d70:	04905463          	blez	s1,80004db8 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80004d74:	00004517          	auipc	a0,0x4
    80004d78:	68450513          	addi	a0,a0,1668 # 800093f8 <CONSOLE_STATUS+0x3e8>
    80004d7c:	ffffd097          	auipc	ra,0xffffd
    80004d80:	358080e7          	jalr	856(ra) # 800020d4 <_Z11printStringPKc>
        printInt(sleep_time);
    80004d84:	00000613          	li	a2,0
    80004d88:	00a00593          	li	a1,10
    80004d8c:	0009051b          	sext.w	a0,s2
    80004d90:	ffffd097          	auipc	ra,0xffffd
    80004d94:	4dc080e7          	jalr	1244(ra) # 8000226c <_Z8printIntiii>
        printString(" !\n");
    80004d98:	00004517          	auipc	a0,0x4
    80004d9c:	66850513          	addi	a0,a0,1640 # 80009400 <CONSOLE_STATUS+0x3f0>
    80004da0:	ffffd097          	auipc	ra,0xffffd
    80004da4:	334080e7          	jalr	820(ra) # 800020d4 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80004da8:	00090513          	mv	a0,s2
    80004dac:	ffffd097          	auipc	ra,0xffffd
    80004db0:	b2c080e7          	jalr	-1236(ra) # 800018d8 <_Z10time_sleepm>
    while (--i > 0) {
    80004db4:	fb9ff06f          	j	80004d6c <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80004db8:	00a00793          	li	a5,10
    80004dbc:	02f95933          	divu	s2,s2,a5
    80004dc0:	fff90913          	addi	s2,s2,-1
    80004dc4:	0000b797          	auipc	a5,0xb
    80004dc8:	01478793          	addi	a5,a5,20 # 8000fdd8 <finishedA>
    80004dcc:	01278933          	add	s2,a5,s2
    80004dd0:	00100793          	li	a5,1
    80004dd4:	00f90423          	sb	a5,8(s2)
}
    80004dd8:	01813083          	ld	ra,24(sp)
    80004ddc:	01013403          	ld	s0,16(sp)
    80004de0:	00813483          	ld	s1,8(sp)
    80004de4:	00013903          	ld	s2,0(sp)
    80004de8:	02010113          	addi	sp,sp,32
    80004dec:	00008067          	ret

0000000080004df0 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80004df0:	fe010113          	addi	sp,sp,-32
    80004df4:	00113c23          	sd	ra,24(sp)
    80004df8:	00813823          	sd	s0,16(sp)
    80004dfc:	00913423          	sd	s1,8(sp)
    80004e00:	01213023          	sd	s2,0(sp)
    80004e04:	02010413          	addi	s0,sp,32
    80004e08:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004e0c:	00100793          	li	a5,1
    80004e10:	02a7f863          	bgeu	a5,a0,80004e40 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004e14:	00a00793          	li	a5,10
    80004e18:	02f577b3          	remu	a5,a0,a5
    80004e1c:	02078e63          	beqz	a5,80004e58 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004e20:	fff48513          	addi	a0,s1,-1
    80004e24:	00000097          	auipc	ra,0x0
    80004e28:	fcc080e7          	jalr	-52(ra) # 80004df0 <_Z9fibonaccim>
    80004e2c:	00050913          	mv	s2,a0
    80004e30:	ffe48513          	addi	a0,s1,-2
    80004e34:	00000097          	auipc	ra,0x0
    80004e38:	fbc080e7          	jalr	-68(ra) # 80004df0 <_Z9fibonaccim>
    80004e3c:	00a90533          	add	a0,s2,a0
}
    80004e40:	01813083          	ld	ra,24(sp)
    80004e44:	01013403          	ld	s0,16(sp)
    80004e48:	00813483          	ld	s1,8(sp)
    80004e4c:	00013903          	ld	s2,0(sp)
    80004e50:	02010113          	addi	sp,sp,32
    80004e54:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004e58:	ffffd097          	auipc	ra,0xffffd
    80004e5c:	8fc080e7          	jalr	-1796(ra) # 80001754 <_Z15thread_dispatchv>
    80004e60:	fc1ff06f          	j	80004e20 <_Z9fibonaccim+0x30>

0000000080004e64 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80004e64:	fe010113          	addi	sp,sp,-32
    80004e68:	00113c23          	sd	ra,24(sp)
    80004e6c:	00813823          	sd	s0,16(sp)
    80004e70:	00913423          	sd	s1,8(sp)
    80004e74:	01213023          	sd	s2,0(sp)
    80004e78:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004e7c:	00000493          	li	s1,0
    80004e80:	0400006f          	j	80004ec0 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004e84:	00004517          	auipc	a0,0x4
    80004e88:	58450513          	addi	a0,a0,1412 # 80009408 <CONSOLE_STATUS+0x3f8>
    80004e8c:	ffffd097          	auipc	ra,0xffffd
    80004e90:	248080e7          	jalr	584(ra) # 800020d4 <_Z11printStringPKc>
    80004e94:	00000613          	li	a2,0
    80004e98:	00a00593          	li	a1,10
    80004e9c:	00048513          	mv	a0,s1
    80004ea0:	ffffd097          	auipc	ra,0xffffd
    80004ea4:	3cc080e7          	jalr	972(ra) # 8000226c <_Z8printIntiii>
    80004ea8:	00004517          	auipc	a0,0x4
    80004eac:	2f850513          	addi	a0,a0,760 # 800091a0 <CONSOLE_STATUS+0x190>
    80004eb0:	ffffd097          	auipc	ra,0xffffd
    80004eb4:	224080e7          	jalr	548(ra) # 800020d4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004eb8:	0014849b          	addiw	s1,s1,1
    80004ebc:	0ff4f493          	andi	s1,s1,255
    80004ec0:	00200793          	li	a5,2
    80004ec4:	fc97f0e3          	bgeu	a5,s1,80004e84 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80004ec8:	00004517          	auipc	a0,0x4
    80004ecc:	54850513          	addi	a0,a0,1352 # 80009410 <CONSOLE_STATUS+0x400>
    80004ed0:	ffffd097          	auipc	ra,0xffffd
    80004ed4:	204080e7          	jalr	516(ra) # 800020d4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004ed8:	00700313          	li	t1,7
    thread_dispatch();
    80004edc:	ffffd097          	auipc	ra,0xffffd
    80004ee0:	878080e7          	jalr	-1928(ra) # 80001754 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004ee4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004ee8:	00004517          	auipc	a0,0x4
    80004eec:	53850513          	addi	a0,a0,1336 # 80009420 <CONSOLE_STATUS+0x410>
    80004ef0:	ffffd097          	auipc	ra,0xffffd
    80004ef4:	1e4080e7          	jalr	484(ra) # 800020d4 <_Z11printStringPKc>
    80004ef8:	00000613          	li	a2,0
    80004efc:	00a00593          	li	a1,10
    80004f00:	0009051b          	sext.w	a0,s2
    80004f04:	ffffd097          	auipc	ra,0xffffd
    80004f08:	368080e7          	jalr	872(ra) # 8000226c <_Z8printIntiii>
    80004f0c:	00004517          	auipc	a0,0x4
    80004f10:	29450513          	addi	a0,a0,660 # 800091a0 <CONSOLE_STATUS+0x190>
    80004f14:	ffffd097          	auipc	ra,0xffffd
    80004f18:	1c0080e7          	jalr	448(ra) # 800020d4 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80004f1c:	00c00513          	li	a0,12
    80004f20:	00000097          	auipc	ra,0x0
    80004f24:	ed0080e7          	jalr	-304(ra) # 80004df0 <_Z9fibonaccim>
    80004f28:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004f2c:	00004517          	auipc	a0,0x4
    80004f30:	4fc50513          	addi	a0,a0,1276 # 80009428 <CONSOLE_STATUS+0x418>
    80004f34:	ffffd097          	auipc	ra,0xffffd
    80004f38:	1a0080e7          	jalr	416(ra) # 800020d4 <_Z11printStringPKc>
    80004f3c:	00000613          	li	a2,0
    80004f40:	00a00593          	li	a1,10
    80004f44:	0009051b          	sext.w	a0,s2
    80004f48:	ffffd097          	auipc	ra,0xffffd
    80004f4c:	324080e7          	jalr	804(ra) # 8000226c <_Z8printIntiii>
    80004f50:	00004517          	auipc	a0,0x4
    80004f54:	25050513          	addi	a0,a0,592 # 800091a0 <CONSOLE_STATUS+0x190>
    80004f58:	ffffd097          	auipc	ra,0xffffd
    80004f5c:	17c080e7          	jalr	380(ra) # 800020d4 <_Z11printStringPKc>
    80004f60:	0400006f          	j	80004fa0 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004f64:	00004517          	auipc	a0,0x4
    80004f68:	4a450513          	addi	a0,a0,1188 # 80009408 <CONSOLE_STATUS+0x3f8>
    80004f6c:	ffffd097          	auipc	ra,0xffffd
    80004f70:	168080e7          	jalr	360(ra) # 800020d4 <_Z11printStringPKc>
    80004f74:	00000613          	li	a2,0
    80004f78:	00a00593          	li	a1,10
    80004f7c:	00048513          	mv	a0,s1
    80004f80:	ffffd097          	auipc	ra,0xffffd
    80004f84:	2ec080e7          	jalr	748(ra) # 8000226c <_Z8printIntiii>
    80004f88:	00004517          	auipc	a0,0x4
    80004f8c:	21850513          	addi	a0,a0,536 # 800091a0 <CONSOLE_STATUS+0x190>
    80004f90:	ffffd097          	auipc	ra,0xffffd
    80004f94:	144080e7          	jalr	324(ra) # 800020d4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004f98:	0014849b          	addiw	s1,s1,1
    80004f9c:	0ff4f493          	andi	s1,s1,255
    80004fa0:	00500793          	li	a5,5
    80004fa4:	fc97f0e3          	bgeu	a5,s1,80004f64 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80004fa8:	00004517          	auipc	a0,0x4
    80004fac:	42850513          	addi	a0,a0,1064 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004fb0:	ffffd097          	auipc	ra,0xffffd
    80004fb4:	124080e7          	jalr	292(ra) # 800020d4 <_Z11printStringPKc>
    finishedC = true;
    80004fb8:	00100793          	li	a5,1
    80004fbc:	0000b717          	auipc	a4,0xb
    80004fc0:	e2f70323          	sb	a5,-474(a4) # 8000fde2 <finishedC>
    thread_dispatch();
    80004fc4:	ffffc097          	auipc	ra,0xffffc
    80004fc8:	790080e7          	jalr	1936(ra) # 80001754 <_Z15thread_dispatchv>
}
    80004fcc:	01813083          	ld	ra,24(sp)
    80004fd0:	01013403          	ld	s0,16(sp)
    80004fd4:	00813483          	ld	s1,8(sp)
    80004fd8:	00013903          	ld	s2,0(sp)
    80004fdc:	02010113          	addi	sp,sp,32
    80004fe0:	00008067          	ret

0000000080004fe4 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80004fe4:	fe010113          	addi	sp,sp,-32
    80004fe8:	00113c23          	sd	ra,24(sp)
    80004fec:	00813823          	sd	s0,16(sp)
    80004ff0:	00913423          	sd	s1,8(sp)
    80004ff4:	01213023          	sd	s2,0(sp)
    80004ff8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004ffc:	00a00493          	li	s1,10
    80005000:	0400006f          	j	80005040 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005004:	00004517          	auipc	a0,0x4
    80005008:	43450513          	addi	a0,a0,1076 # 80009438 <CONSOLE_STATUS+0x428>
    8000500c:	ffffd097          	auipc	ra,0xffffd
    80005010:	0c8080e7          	jalr	200(ra) # 800020d4 <_Z11printStringPKc>
    80005014:	00000613          	li	a2,0
    80005018:	00a00593          	li	a1,10
    8000501c:	00048513          	mv	a0,s1
    80005020:	ffffd097          	auipc	ra,0xffffd
    80005024:	24c080e7          	jalr	588(ra) # 8000226c <_Z8printIntiii>
    80005028:	00004517          	auipc	a0,0x4
    8000502c:	17850513          	addi	a0,a0,376 # 800091a0 <CONSOLE_STATUS+0x190>
    80005030:	ffffd097          	auipc	ra,0xffffd
    80005034:	0a4080e7          	jalr	164(ra) # 800020d4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005038:	0014849b          	addiw	s1,s1,1
    8000503c:	0ff4f493          	andi	s1,s1,255
    80005040:	00c00793          	li	a5,12
    80005044:	fc97f0e3          	bgeu	a5,s1,80005004 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005048:	00004517          	auipc	a0,0x4
    8000504c:	3f850513          	addi	a0,a0,1016 # 80009440 <CONSOLE_STATUS+0x430>
    80005050:	ffffd097          	auipc	ra,0xffffd
    80005054:	084080e7          	jalr	132(ra) # 800020d4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005058:	00500313          	li	t1,5
    thread_dispatch();
    8000505c:	ffffc097          	auipc	ra,0xffffc
    80005060:	6f8080e7          	jalr	1784(ra) # 80001754 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005064:	01000513          	li	a0,16
    80005068:	00000097          	auipc	ra,0x0
    8000506c:	d88080e7          	jalr	-632(ra) # 80004df0 <_Z9fibonaccim>
    80005070:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005074:	00004517          	auipc	a0,0x4
    80005078:	3dc50513          	addi	a0,a0,988 # 80009450 <CONSOLE_STATUS+0x440>
    8000507c:	ffffd097          	auipc	ra,0xffffd
    80005080:	058080e7          	jalr	88(ra) # 800020d4 <_Z11printStringPKc>
    80005084:	00000613          	li	a2,0
    80005088:	00a00593          	li	a1,10
    8000508c:	0009051b          	sext.w	a0,s2
    80005090:	ffffd097          	auipc	ra,0xffffd
    80005094:	1dc080e7          	jalr	476(ra) # 8000226c <_Z8printIntiii>
    80005098:	00004517          	auipc	a0,0x4
    8000509c:	10850513          	addi	a0,a0,264 # 800091a0 <CONSOLE_STATUS+0x190>
    800050a0:	ffffd097          	auipc	ra,0xffffd
    800050a4:	034080e7          	jalr	52(ra) # 800020d4 <_Z11printStringPKc>
    800050a8:	0400006f          	j	800050e8 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800050ac:	00004517          	auipc	a0,0x4
    800050b0:	38c50513          	addi	a0,a0,908 # 80009438 <CONSOLE_STATUS+0x428>
    800050b4:	ffffd097          	auipc	ra,0xffffd
    800050b8:	020080e7          	jalr	32(ra) # 800020d4 <_Z11printStringPKc>
    800050bc:	00000613          	li	a2,0
    800050c0:	00a00593          	li	a1,10
    800050c4:	00048513          	mv	a0,s1
    800050c8:	ffffd097          	auipc	ra,0xffffd
    800050cc:	1a4080e7          	jalr	420(ra) # 8000226c <_Z8printIntiii>
    800050d0:	00004517          	auipc	a0,0x4
    800050d4:	0d050513          	addi	a0,a0,208 # 800091a0 <CONSOLE_STATUS+0x190>
    800050d8:	ffffd097          	auipc	ra,0xffffd
    800050dc:	ffc080e7          	jalr	-4(ra) # 800020d4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800050e0:	0014849b          	addiw	s1,s1,1
    800050e4:	0ff4f493          	andi	s1,s1,255
    800050e8:	00f00793          	li	a5,15
    800050ec:	fc97f0e3          	bgeu	a5,s1,800050ac <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800050f0:	00004517          	auipc	a0,0x4
    800050f4:	37050513          	addi	a0,a0,880 # 80009460 <CONSOLE_STATUS+0x450>
    800050f8:	ffffd097          	auipc	ra,0xffffd
    800050fc:	fdc080e7          	jalr	-36(ra) # 800020d4 <_Z11printStringPKc>
    finishedD = true;
    80005100:	00100793          	li	a5,1
    80005104:	0000b717          	auipc	a4,0xb
    80005108:	ccf70fa3          	sb	a5,-801(a4) # 8000fde3 <finishedD>
    thread_dispatch();
    8000510c:	ffffc097          	auipc	ra,0xffffc
    80005110:	648080e7          	jalr	1608(ra) # 80001754 <_Z15thread_dispatchv>
}
    80005114:	01813083          	ld	ra,24(sp)
    80005118:	01013403          	ld	s0,16(sp)
    8000511c:	00813483          	ld	s1,8(sp)
    80005120:	00013903          	ld	s2,0(sp)
    80005124:	02010113          	addi	sp,sp,32
    80005128:	00008067          	ret

000000008000512c <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000512c:	fc010113          	addi	sp,sp,-64
    80005130:	02113c23          	sd	ra,56(sp)
    80005134:	02813823          	sd	s0,48(sp)
    80005138:	02913423          	sd	s1,40(sp)
    8000513c:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005140:	00000613          	li	a2,0
    80005144:	00000597          	auipc	a1,0x0
    80005148:	a6858593          	addi	a1,a1,-1432 # 80004bac <_Z11workerBodyAPv>
    8000514c:	fc040513          	addi	a0,s0,-64
    80005150:	ffffc097          	auipc	ra,0xffffc
    80005154:	560080e7          	jalr	1376(ra) # 800016b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80005158:	00004517          	auipc	a0,0x4
    8000515c:	31850513          	addi	a0,a0,792 # 80009470 <CONSOLE_STATUS+0x460>
    80005160:	ffffd097          	auipc	ra,0xffffd
    80005164:	f74080e7          	jalr	-140(ra) # 800020d4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005168:	00000613          	li	a2,0
    8000516c:	00000597          	auipc	a1,0x0
    80005170:	b0c58593          	addi	a1,a1,-1268 # 80004c78 <_Z11workerBodyBPv>
    80005174:	fc840513          	addi	a0,s0,-56
    80005178:	ffffc097          	auipc	ra,0xffffc
    8000517c:	538080e7          	jalr	1336(ra) # 800016b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005180:	00004517          	auipc	a0,0x4
    80005184:	30850513          	addi	a0,a0,776 # 80009488 <CONSOLE_STATUS+0x478>
    80005188:	ffffd097          	auipc	ra,0xffffd
    8000518c:	f4c080e7          	jalr	-180(ra) # 800020d4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005190:	00000613          	li	a2,0
    80005194:	00000597          	auipc	a1,0x0
    80005198:	cd058593          	addi	a1,a1,-816 # 80004e64 <_Z11workerBodyCPv>
    8000519c:	fd040513          	addi	a0,s0,-48
    800051a0:	ffffc097          	auipc	ra,0xffffc
    800051a4:	510080e7          	jalr	1296(ra) # 800016b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    800051a8:	00004517          	auipc	a0,0x4
    800051ac:	2f850513          	addi	a0,a0,760 # 800094a0 <CONSOLE_STATUS+0x490>
    800051b0:	ffffd097          	auipc	ra,0xffffd
    800051b4:	f24080e7          	jalr	-220(ra) # 800020d4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800051b8:	00000613          	li	a2,0
    800051bc:	00000597          	auipc	a1,0x0
    800051c0:	e2858593          	addi	a1,a1,-472 # 80004fe4 <_Z11workerBodyDPv>
    800051c4:	fd840513          	addi	a0,s0,-40
    800051c8:	ffffc097          	auipc	ra,0xffffc
    800051cc:	4e8080e7          	jalr	1256(ra) # 800016b0 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800051d0:	00004517          	auipc	a0,0x4
    800051d4:	2e850513          	addi	a0,a0,744 # 800094b8 <CONSOLE_STATUS+0x4a8>
    800051d8:	ffffd097          	auipc	ra,0xffffd
    800051dc:	efc080e7          	jalr	-260(ra) # 800020d4 <_Z11printStringPKc>
    800051e0:	00c0006f          	j	800051ec <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800051e4:	ffffc097          	auipc	ra,0xffffc
    800051e8:	570080e7          	jalr	1392(ra) # 80001754 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800051ec:	0000b797          	auipc	a5,0xb
    800051f0:	bec7c783          	lbu	a5,-1044(a5) # 8000fdd8 <finishedA>
    800051f4:	fe0788e3          	beqz	a5,800051e4 <_Z18Threads_C_API_testv+0xb8>
    800051f8:	0000b797          	auipc	a5,0xb
    800051fc:	be17c783          	lbu	a5,-1055(a5) # 8000fdd9 <finishedB>
    80005200:	fe0782e3          	beqz	a5,800051e4 <_Z18Threads_C_API_testv+0xb8>
    80005204:	0000b797          	auipc	a5,0xb
    80005208:	bde7c783          	lbu	a5,-1058(a5) # 8000fde2 <finishedC>
    8000520c:	fc078ce3          	beqz	a5,800051e4 <_Z18Threads_C_API_testv+0xb8>
    80005210:	0000b797          	auipc	a5,0xb
    80005214:	bd37c783          	lbu	a5,-1069(a5) # 8000fde3 <finishedD>
    80005218:	fc0786e3          	beqz	a5,800051e4 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    8000521c:	fc040493          	addi	s1,s0,-64
    80005220:	0080006f          	j	80005228 <_Z18Threads_C_API_testv+0xfc>
    80005224:	00848493          	addi	s1,s1,8
    80005228:	fe040793          	addi	a5,s0,-32
    8000522c:	00f48c63          	beq	s1,a5,80005244 <_Z18Threads_C_API_testv+0x118>
    80005230:	0004b503          	ld	a0,0(s1)
    80005234:	fe0508e3          	beqz	a0,80005224 <_Z18Threads_C_API_testv+0xf8>
    80005238:	ffffc097          	auipc	ra,0xffffc
    8000523c:	768080e7          	jalr	1896(ra) # 800019a0 <_ZN7_threaddlEPv>
    80005240:	fe5ff06f          	j	80005224 <_Z18Threads_C_API_testv+0xf8>
}
    80005244:	03813083          	ld	ra,56(sp)
    80005248:	03013403          	ld	s0,48(sp)
    8000524c:	02813483          	ld	s1,40(sp)
    80005250:	04010113          	addi	sp,sp,64
    80005254:	00008067          	ret

0000000080005258 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005258:	fd010113          	addi	sp,sp,-48
    8000525c:	02113423          	sd	ra,40(sp)
    80005260:	02813023          	sd	s0,32(sp)
    80005264:	00913c23          	sd	s1,24(sp)
    80005268:	01213823          	sd	s2,16(sp)
    8000526c:	01313423          	sd	s3,8(sp)
    80005270:	03010413          	addi	s0,sp,48
    80005274:	00050993          	mv	s3,a0
    80005278:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000527c:	00000913          	li	s2,0
    80005280:	00c0006f          	j	8000528c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005284:	ffffe097          	auipc	ra,0xffffe
    80005288:	de8080e7          	jalr	-536(ra) # 8000306c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    8000528c:	ffffc097          	auipc	ra,0xffffc
    80005290:	678080e7          	jalr	1656(ra) # 80001904 <_Z4getcv>
    80005294:	0005059b          	sext.w	a1,a0
    80005298:	01b00793          	li	a5,27
    8000529c:	02f58a63          	beq	a1,a5,800052d0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800052a0:	0084b503          	ld	a0,8(s1)
    800052a4:	fffff097          	auipc	ra,0xfffff
    800052a8:	664080e7          	jalr	1636(ra) # 80004908 <_ZN9BufferCPP3putEi>
        i++;
    800052ac:	0019071b          	addiw	a4,s2,1
    800052b0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800052b4:	0004a683          	lw	a3,0(s1)
    800052b8:	0026979b          	slliw	a5,a3,0x2
    800052bc:	00d787bb          	addw	a5,a5,a3
    800052c0:	0017979b          	slliw	a5,a5,0x1
    800052c4:	02f767bb          	remw	a5,a4,a5
    800052c8:	fc0792e3          	bnez	a5,8000528c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800052cc:	fb9ff06f          	j	80005284 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    800052d0:	00100793          	li	a5,1
    800052d4:	0000b717          	auipc	a4,0xb
    800052d8:	b0f72823          	sw	a5,-1264(a4) # 8000fde4 <threadEnd>
    td->buffer->put('!');
    800052dc:	0109b783          	ld	a5,16(s3)
    800052e0:	02100593          	li	a1,33
    800052e4:	0087b503          	ld	a0,8(a5)
    800052e8:	fffff097          	auipc	ra,0xfffff
    800052ec:	620080e7          	jalr	1568(ra) # 80004908 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800052f0:	0104b503          	ld	a0,16(s1)
    800052f4:	ffffe097          	auipc	ra,0xffffe
    800052f8:	c68080e7          	jalr	-920(ra) # 80002f5c <_ZN9Semaphore6signalEv>
}
    800052fc:	02813083          	ld	ra,40(sp)
    80005300:	02013403          	ld	s0,32(sp)
    80005304:	01813483          	ld	s1,24(sp)
    80005308:	01013903          	ld	s2,16(sp)
    8000530c:	00813983          	ld	s3,8(sp)
    80005310:	03010113          	addi	sp,sp,48
    80005314:	00008067          	ret

0000000080005318 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    80005318:	fe010113          	addi	sp,sp,-32
    8000531c:	00113c23          	sd	ra,24(sp)
    80005320:	00813823          	sd	s0,16(sp)
    80005324:	00913423          	sd	s1,8(sp)
    80005328:	01213023          	sd	s2,0(sp)
    8000532c:	02010413          	addi	s0,sp,32
    80005330:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005334:	00000913          	li	s2,0
    80005338:	00c0006f          	j	80005344 <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000533c:	ffffe097          	auipc	ra,0xffffe
    80005340:	d30080e7          	jalr	-720(ra) # 8000306c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80005344:	0000b797          	auipc	a5,0xb
    80005348:	aa07a783          	lw	a5,-1376(a5) # 8000fde4 <threadEnd>
    8000534c:	02079e63          	bnez	a5,80005388 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80005350:	0004a583          	lw	a1,0(s1)
    80005354:	0305859b          	addiw	a1,a1,48
    80005358:	0084b503          	ld	a0,8(s1)
    8000535c:	fffff097          	auipc	ra,0xfffff
    80005360:	5ac080e7          	jalr	1452(ra) # 80004908 <_ZN9BufferCPP3putEi>
        i++;
    80005364:	0019071b          	addiw	a4,s2,1
    80005368:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000536c:	0004a683          	lw	a3,0(s1)
    80005370:	0026979b          	slliw	a5,a3,0x2
    80005374:	00d787bb          	addw	a5,a5,a3
    80005378:	0017979b          	slliw	a5,a5,0x1
    8000537c:	02f767bb          	remw	a5,a4,a5
    80005380:	fc0792e3          	bnez	a5,80005344 <_ZN8Producer8producerEPv+0x2c>
    80005384:	fb9ff06f          	j	8000533c <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005388:	0104b503          	ld	a0,16(s1)
    8000538c:	ffffe097          	auipc	ra,0xffffe
    80005390:	bd0080e7          	jalr	-1072(ra) # 80002f5c <_ZN9Semaphore6signalEv>
}
    80005394:	01813083          	ld	ra,24(sp)
    80005398:	01013403          	ld	s0,16(sp)
    8000539c:	00813483          	ld	s1,8(sp)
    800053a0:	00013903          	ld	s2,0(sp)
    800053a4:	02010113          	addi	sp,sp,32
    800053a8:	00008067          	ret

00000000800053ac <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    800053ac:	fd010113          	addi	sp,sp,-48
    800053b0:	02113423          	sd	ra,40(sp)
    800053b4:	02813023          	sd	s0,32(sp)
    800053b8:	00913c23          	sd	s1,24(sp)
    800053bc:	01213823          	sd	s2,16(sp)
    800053c0:	01313423          	sd	s3,8(sp)
    800053c4:	01413023          	sd	s4,0(sp)
    800053c8:	03010413          	addi	s0,sp,48
    800053cc:	00050993          	mv	s3,a0
    800053d0:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800053d4:	00000a13          	li	s4,0
    800053d8:	01c0006f          	j	800053f4 <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    800053dc:	ffffe097          	auipc	ra,0xffffe
    800053e0:	c90080e7          	jalr	-880(ra) # 8000306c <_ZN6Thread8dispatchEv>
    800053e4:	0500006f          	j	80005434 <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800053e8:	00a00513          	li	a0,10
    800053ec:	ffffc097          	auipc	ra,0xffffc
    800053f0:	540080e7          	jalr	1344(ra) # 8000192c <_Z4putcc>
    while (!threadEnd) {
    800053f4:	0000b797          	auipc	a5,0xb
    800053f8:	9f07a783          	lw	a5,-1552(a5) # 8000fde4 <threadEnd>
    800053fc:	06079263          	bnez	a5,80005460 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80005400:	00893503          	ld	a0,8(s2)
    80005404:	fffff097          	auipc	ra,0xfffff
    80005408:	594080e7          	jalr	1428(ra) # 80004998 <_ZN9BufferCPP3getEv>
        i++;
    8000540c:	001a049b          	addiw	s1,s4,1
    80005410:	00048a1b          	sext.w	s4,s1
        putc(key);
    80005414:	0ff57513          	andi	a0,a0,255
    80005418:	ffffc097          	auipc	ra,0xffffc
    8000541c:	514080e7          	jalr	1300(ra) # 8000192c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80005420:	00092703          	lw	a4,0(s2)
    80005424:	0027179b          	slliw	a5,a4,0x2
    80005428:	00e787bb          	addw	a5,a5,a4
    8000542c:	02f4e7bb          	remw	a5,s1,a5
    80005430:	fa0786e3          	beqz	a5,800053dc <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    80005434:	05000793          	li	a5,80
    80005438:	02f4e4bb          	remw	s1,s1,a5
    8000543c:	fa049ce3          	bnez	s1,800053f4 <_ZN8Consumer8consumerEPv+0x48>
    80005440:	fa9ff06f          	j	800053e8 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80005444:	0109b783          	ld	a5,16(s3)
    80005448:	0087b503          	ld	a0,8(a5)
    8000544c:	fffff097          	auipc	ra,0xfffff
    80005450:	54c080e7          	jalr	1356(ra) # 80004998 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80005454:	0ff57513          	andi	a0,a0,255
    80005458:	ffffe097          	auipc	ra,0xffffe
    8000545c:	d00080e7          	jalr	-768(ra) # 80003158 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80005460:	0109b783          	ld	a5,16(s3)
    80005464:	0087b503          	ld	a0,8(a5)
    80005468:	fffff097          	auipc	ra,0xfffff
    8000546c:	5bc080e7          	jalr	1468(ra) # 80004a24 <_ZN9BufferCPP6getCntEv>
    80005470:	fca04ae3          	bgtz	a0,80005444 <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    80005474:	01093503          	ld	a0,16(s2)
    80005478:	ffffe097          	auipc	ra,0xffffe
    8000547c:	ae4080e7          	jalr	-1308(ra) # 80002f5c <_ZN9Semaphore6signalEv>
}
    80005480:	02813083          	ld	ra,40(sp)
    80005484:	02013403          	ld	s0,32(sp)
    80005488:	01813483          	ld	s1,24(sp)
    8000548c:	01013903          	ld	s2,16(sp)
    80005490:	00813983          	ld	s3,8(sp)
    80005494:	00013a03          	ld	s4,0(sp)
    80005498:	03010113          	addi	sp,sp,48
    8000549c:	00008067          	ret

00000000800054a0 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800054a0:	f8010113          	addi	sp,sp,-128
    800054a4:	06113c23          	sd	ra,120(sp)
    800054a8:	06813823          	sd	s0,112(sp)
    800054ac:	06913423          	sd	s1,104(sp)
    800054b0:	07213023          	sd	s2,96(sp)
    800054b4:	05313c23          	sd	s3,88(sp)
    800054b8:	05413823          	sd	s4,80(sp)
    800054bc:	05513423          	sd	s5,72(sp)
    800054c0:	05613023          	sd	s6,64(sp)
    800054c4:	03713c23          	sd	s7,56(sp)
    800054c8:	03813823          	sd	s8,48(sp)
    800054cc:	03913423          	sd	s9,40(sp)
    800054d0:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800054d4:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800054d8:	00004517          	auipc	a0,0x4
    800054dc:	ff850513          	addi	a0,a0,-8 # 800094d0 <CONSOLE_STATUS+0x4c0>
    800054e0:	ffffd097          	auipc	ra,0xffffd
    800054e4:	bf4080e7          	jalr	-1036(ra) # 800020d4 <_Z11printStringPKc>
    getString(input, 30);
    800054e8:	01e00593          	li	a1,30
    800054ec:	f8040493          	addi	s1,s0,-128
    800054f0:	00048513          	mv	a0,s1
    800054f4:	ffffd097          	auipc	ra,0xffffd
    800054f8:	c5c080e7          	jalr	-932(ra) # 80002150 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800054fc:	00048513          	mv	a0,s1
    80005500:	ffffd097          	auipc	ra,0xffffd
    80005504:	d1c080e7          	jalr	-740(ra) # 8000221c <_Z11stringToIntPKc>
    80005508:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000550c:	00004517          	auipc	a0,0x4
    80005510:	fe450513          	addi	a0,a0,-28 # 800094f0 <CONSOLE_STATUS+0x4e0>
    80005514:	ffffd097          	auipc	ra,0xffffd
    80005518:	bc0080e7          	jalr	-1088(ra) # 800020d4 <_Z11printStringPKc>
    getString(input, 30);
    8000551c:	01e00593          	li	a1,30
    80005520:	00048513          	mv	a0,s1
    80005524:	ffffd097          	auipc	ra,0xffffd
    80005528:	c2c080e7          	jalr	-980(ra) # 80002150 <_Z9getStringPci>
    n = stringToInt(input);
    8000552c:	00048513          	mv	a0,s1
    80005530:	ffffd097          	auipc	ra,0xffffd
    80005534:	cec080e7          	jalr	-788(ra) # 8000221c <_Z11stringToIntPKc>
    80005538:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000553c:	00004517          	auipc	a0,0x4
    80005540:	fd450513          	addi	a0,a0,-44 # 80009510 <CONSOLE_STATUS+0x500>
    80005544:	ffffd097          	auipc	ra,0xffffd
    80005548:	b90080e7          	jalr	-1136(ra) # 800020d4 <_Z11printStringPKc>
    8000554c:	00000613          	li	a2,0
    80005550:	00a00593          	li	a1,10
    80005554:	00090513          	mv	a0,s2
    80005558:	ffffd097          	auipc	ra,0xffffd
    8000555c:	d14080e7          	jalr	-748(ra) # 8000226c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005560:	00004517          	auipc	a0,0x4
    80005564:	fc850513          	addi	a0,a0,-56 # 80009528 <CONSOLE_STATUS+0x518>
    80005568:	ffffd097          	auipc	ra,0xffffd
    8000556c:	b6c080e7          	jalr	-1172(ra) # 800020d4 <_Z11printStringPKc>
    80005570:	00000613          	li	a2,0
    80005574:	00a00593          	li	a1,10
    80005578:	00048513          	mv	a0,s1
    8000557c:	ffffd097          	auipc	ra,0xffffd
    80005580:	cf0080e7          	jalr	-784(ra) # 8000226c <_Z8printIntiii>
    printString(".\n");
    80005584:	00004517          	auipc	a0,0x4
    80005588:	c8450513          	addi	a0,a0,-892 # 80009208 <CONSOLE_STATUS+0x1f8>
    8000558c:	ffffd097          	auipc	ra,0xffffd
    80005590:	b48080e7          	jalr	-1208(ra) # 800020d4 <_Z11printStringPKc>
    if(threadNum > n) {
    80005594:	0324c463          	blt	s1,s2,800055bc <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005598:	03205c63          	blez	s2,800055d0 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    8000559c:	03800513          	li	a0,56
    800055a0:	ffffe097          	auipc	ra,0xffffe
    800055a4:	860080e7          	jalr	-1952(ra) # 80002e00 <_Znwm>
    800055a8:	00050a93          	mv	s5,a0
    800055ac:	00048593          	mv	a1,s1
    800055b0:	fffff097          	auipc	ra,0xfffff
    800055b4:	204080e7          	jalr	516(ra) # 800047b4 <_ZN9BufferCPPC1Ei>
    800055b8:	0300006f          	j	800055e8 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800055bc:	00004517          	auipc	a0,0x4
    800055c0:	f8450513          	addi	a0,a0,-124 # 80009540 <CONSOLE_STATUS+0x530>
    800055c4:	ffffd097          	auipc	ra,0xffffd
    800055c8:	b10080e7          	jalr	-1264(ra) # 800020d4 <_Z11printStringPKc>
        return;
    800055cc:	0140006f          	j	800055e0 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800055d0:	00004517          	auipc	a0,0x4
    800055d4:	fb050513          	addi	a0,a0,-80 # 80009580 <CONSOLE_STATUS+0x570>
    800055d8:	ffffd097          	auipc	ra,0xffffd
    800055dc:	afc080e7          	jalr	-1284(ra) # 800020d4 <_Z11printStringPKc>
        return;
    800055e0:	000b8113          	mv	sp,s7
    800055e4:	2400006f          	j	80005824 <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    800055e8:	01000513          	li	a0,16
    800055ec:	ffffe097          	auipc	ra,0xffffe
    800055f0:	814080e7          	jalr	-2028(ra) # 80002e00 <_Znwm>
    800055f4:	00050493          	mv	s1,a0
    800055f8:	00000593          	li	a1,0
    800055fc:	ffffe097          	auipc	ra,0xffffe
    80005600:	8fc080e7          	jalr	-1796(ra) # 80002ef8 <_ZN9SemaphoreC1Ej>
    80005604:	0000a717          	auipc	a4,0xa
    80005608:	7d470713          	addi	a4,a4,2004 # 8000fdd8 <finishedA>
    8000560c:	00973823          	sd	s1,16(a4)
    Thread* threads[threadNum];
    80005610:	00391793          	slli	a5,s2,0x3
    80005614:	00f78793          	addi	a5,a5,15
    80005618:	ff07f793          	andi	a5,a5,-16
    8000561c:	40f10133          	sub	sp,sp,a5
    80005620:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80005624:	0019069b          	addiw	a3,s2,1
    80005628:	00169793          	slli	a5,a3,0x1
    8000562c:	00d787b3          	add	a5,a5,a3
    80005630:	00379793          	slli	a5,a5,0x3
    80005634:	00f78793          	addi	a5,a5,15
    80005638:	ff07f793          	andi	a5,a5,-16
    8000563c:	40f10133          	sub	sp,sp,a5
    80005640:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80005644:	00191493          	slli	s1,s2,0x1
    80005648:	012487b3          	add	a5,s1,s2
    8000564c:	00379793          	slli	a5,a5,0x3
    80005650:	00fa07b3          	add	a5,s4,a5
    80005654:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005658:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    8000565c:	01073703          	ld	a4,16(a4)
    80005660:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    80005664:	01800513          	li	a0,24
    80005668:	ffffd097          	auipc	ra,0xffffd
    8000566c:	798080e7          	jalr	1944(ra) # 80002e00 <_Znwm>
    80005670:	00050b13          	mv	s6,a0
    80005674:	012484b3          	add	s1,s1,s2
    80005678:	00349493          	slli	s1,s1,0x3
    8000567c:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    80005680:	ffffe097          	auipc	ra,0xffffe
    80005684:	940080e7          	jalr	-1728(ra) # 80002fc0 <_ZN6ThreadC1Ev>
    80005688:	00006797          	auipc	a5,0x6
    8000568c:	39878793          	addi	a5,a5,920 # 8000ba20 <_ZTV8Consumer+0x10>
    80005690:	00fb3023          	sd	a5,0(s6)
    80005694:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    80005698:	000b0513          	mv	a0,s6
    8000569c:	ffffe097          	auipc	ra,0xffffe
    800056a0:	9f8080e7          	jalr	-1544(ra) # 80003094 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800056a4:	00000493          	li	s1,0
    800056a8:	0380006f          	j	800056e0 <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    800056ac:	00006797          	auipc	a5,0x6
    800056b0:	34c78793          	addi	a5,a5,844 # 8000b9f8 <_ZTV8Producer+0x10>
    800056b4:	00fcb023          	sd	a5,0(s9)
    800056b8:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    800056bc:	00349793          	slli	a5,s1,0x3
    800056c0:	00f987b3          	add	a5,s3,a5
    800056c4:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800056c8:	00349793          	slli	a5,s1,0x3
    800056cc:	00f987b3          	add	a5,s3,a5
    800056d0:	0007b503          	ld	a0,0(a5)
    800056d4:	ffffe097          	auipc	ra,0xffffe
    800056d8:	9c0080e7          	jalr	-1600(ra) # 80003094 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800056dc:	0014849b          	addiw	s1,s1,1
    800056e0:	0b24d063          	bge	s1,s2,80005780 <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    800056e4:	00149793          	slli	a5,s1,0x1
    800056e8:	009787b3          	add	a5,a5,s1
    800056ec:	00379793          	slli	a5,a5,0x3
    800056f0:	00fa07b3          	add	a5,s4,a5
    800056f4:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800056f8:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800056fc:	0000a717          	auipc	a4,0xa
    80005700:	6ec73703          	ld	a4,1772(a4) # 8000fde8 <waitForAll>
    80005704:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80005708:	02905863          	blez	s1,80005738 <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    8000570c:	01800513          	li	a0,24
    80005710:	ffffd097          	auipc	ra,0xffffd
    80005714:	6f0080e7          	jalr	1776(ra) # 80002e00 <_Znwm>
    80005718:	00050c93          	mv	s9,a0
    8000571c:	00149c13          	slli	s8,s1,0x1
    80005720:	009c0c33          	add	s8,s8,s1
    80005724:	003c1c13          	slli	s8,s8,0x3
    80005728:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    8000572c:	ffffe097          	auipc	ra,0xffffe
    80005730:	894080e7          	jalr	-1900(ra) # 80002fc0 <_ZN6ThreadC1Ev>
    80005734:	f79ff06f          	j	800056ac <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    80005738:	01800513          	li	a0,24
    8000573c:	ffffd097          	auipc	ra,0xffffd
    80005740:	6c4080e7          	jalr	1732(ra) # 80002e00 <_Znwm>
    80005744:	00050c93          	mv	s9,a0
    80005748:	00149c13          	slli	s8,s1,0x1
    8000574c:	009c0c33          	add	s8,s8,s1
    80005750:	003c1c13          	slli	s8,s8,0x3
    80005754:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005758:	ffffe097          	auipc	ra,0xffffe
    8000575c:	868080e7          	jalr	-1944(ra) # 80002fc0 <_ZN6ThreadC1Ev>
    80005760:	00006797          	auipc	a5,0x6
    80005764:	27078793          	addi	a5,a5,624 # 8000b9d0 <_ZTV16ProducerKeyboard+0x10>
    80005768:	00fcb023          	sd	a5,0(s9)
    8000576c:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005770:	00349793          	slli	a5,s1,0x3
    80005774:	00f987b3          	add	a5,s3,a5
    80005778:	0197b023          	sd	s9,0(a5)
    8000577c:	f4dff06f          	j	800056c8 <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    80005780:	ffffe097          	auipc	ra,0xffffe
    80005784:	8ec080e7          	jalr	-1812(ra) # 8000306c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005788:	00000493          	li	s1,0
    8000578c:	00994e63          	blt	s2,s1,800057a8 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    80005790:	0000a517          	auipc	a0,0xa
    80005794:	65853503          	ld	a0,1624(a0) # 8000fde8 <waitForAll>
    80005798:	ffffd097          	auipc	ra,0xffffd
    8000579c:	798080e7          	jalr	1944(ra) # 80002f30 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800057a0:	0014849b          	addiw	s1,s1,1
    800057a4:	fe9ff06f          	j	8000578c <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    800057a8:	00000493          	li	s1,0
    800057ac:	0080006f          	j	800057b4 <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    800057b0:	0014849b          	addiw	s1,s1,1
    800057b4:	0324d263          	bge	s1,s2,800057d8 <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    800057b8:	00349793          	slli	a5,s1,0x3
    800057bc:	00f987b3          	add	a5,s3,a5
    800057c0:	0007b503          	ld	a0,0(a5)
    800057c4:	fe0506e3          	beqz	a0,800057b0 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    800057c8:	00053783          	ld	a5,0(a0)
    800057cc:	0087b783          	ld	a5,8(a5)
    800057d0:	000780e7          	jalr	a5
    800057d4:	fddff06f          	j	800057b0 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    800057d8:	000b0a63          	beqz	s6,800057ec <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    800057dc:	000b3783          	ld	a5,0(s6)
    800057e0:	0087b783          	ld	a5,8(a5)
    800057e4:	000b0513          	mv	a0,s6
    800057e8:	000780e7          	jalr	a5
    delete waitForAll;
    800057ec:	0000a517          	auipc	a0,0xa
    800057f0:	5fc53503          	ld	a0,1532(a0) # 8000fde8 <waitForAll>
    800057f4:	00050863          	beqz	a0,80005804 <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    800057f8:	00053783          	ld	a5,0(a0)
    800057fc:	0087b783          	ld	a5,8(a5)
    80005800:	000780e7          	jalr	a5
    delete buffer;
    80005804:	000a8e63          	beqz	s5,80005820 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    80005808:	000a8513          	mv	a0,s5
    8000580c:	fffff097          	auipc	ra,0xfffff
    80005810:	2a0080e7          	jalr	672(ra) # 80004aac <_ZN9BufferCPPD1Ev>
    80005814:	000a8513          	mv	a0,s5
    80005818:	ffffd097          	auipc	ra,0xffffd
    8000581c:	638080e7          	jalr	1592(ra) # 80002e50 <_ZdlPv>
    80005820:	000b8113          	mv	sp,s7

}
    80005824:	f8040113          	addi	sp,s0,-128
    80005828:	07813083          	ld	ra,120(sp)
    8000582c:	07013403          	ld	s0,112(sp)
    80005830:	06813483          	ld	s1,104(sp)
    80005834:	06013903          	ld	s2,96(sp)
    80005838:	05813983          	ld	s3,88(sp)
    8000583c:	05013a03          	ld	s4,80(sp)
    80005840:	04813a83          	ld	s5,72(sp)
    80005844:	04013b03          	ld	s6,64(sp)
    80005848:	03813b83          	ld	s7,56(sp)
    8000584c:	03013c03          	ld	s8,48(sp)
    80005850:	02813c83          	ld	s9,40(sp)
    80005854:	08010113          	addi	sp,sp,128
    80005858:	00008067          	ret
    8000585c:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005860:	000a8513          	mv	a0,s5
    80005864:	ffffd097          	auipc	ra,0xffffd
    80005868:	5ec080e7          	jalr	1516(ra) # 80002e50 <_ZdlPv>
    8000586c:	00048513          	mv	a0,s1
    80005870:	0000b097          	auipc	ra,0xb
    80005874:	658080e7          	jalr	1624(ra) # 80010ec8 <_Unwind_Resume>
    80005878:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    8000587c:	00048513          	mv	a0,s1
    80005880:	ffffd097          	auipc	ra,0xffffd
    80005884:	5d0080e7          	jalr	1488(ra) # 80002e50 <_ZdlPv>
    80005888:	00090513          	mv	a0,s2
    8000588c:	0000b097          	auipc	ra,0xb
    80005890:	63c080e7          	jalr	1596(ra) # 80010ec8 <_Unwind_Resume>
    80005894:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    80005898:	000b0513          	mv	a0,s6
    8000589c:	ffffd097          	auipc	ra,0xffffd
    800058a0:	5b4080e7          	jalr	1460(ra) # 80002e50 <_ZdlPv>
    800058a4:	00048513          	mv	a0,s1
    800058a8:	0000b097          	auipc	ra,0xb
    800058ac:	620080e7          	jalr	1568(ra) # 80010ec8 <_Unwind_Resume>
    800058b0:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    800058b4:	000c8513          	mv	a0,s9
    800058b8:	ffffd097          	auipc	ra,0xffffd
    800058bc:	598080e7          	jalr	1432(ra) # 80002e50 <_ZdlPv>
    800058c0:	00048513          	mv	a0,s1
    800058c4:	0000b097          	auipc	ra,0xb
    800058c8:	604080e7          	jalr	1540(ra) # 80010ec8 <_Unwind_Resume>
    800058cc:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    800058d0:	000c8513          	mv	a0,s9
    800058d4:	ffffd097          	auipc	ra,0xffffd
    800058d8:	57c080e7          	jalr	1404(ra) # 80002e50 <_ZdlPv>
    800058dc:	00048513          	mv	a0,s1
    800058e0:	0000b097          	auipc	ra,0xb
    800058e4:	5e8080e7          	jalr	1512(ra) # 80010ec8 <_Unwind_Resume>

00000000800058e8 <_Z12testSleepingv>:

void testSleeping() {
    800058e8:	fc010113          	addi	sp,sp,-64
    800058ec:	02113c23          	sd	ra,56(sp)
    800058f0:	02813823          	sd	s0,48(sp)
    800058f4:	02913423          	sd	s1,40(sp)
    800058f8:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800058fc:	00a00793          	li	a5,10
    80005900:	fcf43823          	sd	a5,-48(s0)
    80005904:	01400793          	li	a5,20
    80005908:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    8000590c:	00000493          	li	s1,0
    80005910:	02c0006f          	j	8000593c <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80005914:	00349793          	slli	a5,s1,0x3
    80005918:	fd040613          	addi	a2,s0,-48
    8000591c:	00f60633          	add	a2,a2,a5
    80005920:	fffff597          	auipc	a1,0xfffff
    80005924:	42c58593          	addi	a1,a1,1068 # 80004d4c <_Z9sleepyRunPv>
    80005928:	fc040513          	addi	a0,s0,-64
    8000592c:	00f50533          	add	a0,a0,a5
    80005930:	ffffc097          	auipc	ra,0xffffc
    80005934:	d80080e7          	jalr	-640(ra) # 800016b0 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005938:	0014849b          	addiw	s1,s1,1
    8000593c:	00100793          	li	a5,1
    80005940:	fc97dae3          	bge	a5,s1,80005914 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80005944:	0000a797          	auipc	a5,0xa
    80005948:	49c7c783          	lbu	a5,1180(a5) # 8000fde0 <finished>
    8000594c:	fe078ce3          	beqz	a5,80005944 <_Z12testSleepingv+0x5c>
    80005950:	0000a797          	auipc	a5,0xa
    80005954:	4917c783          	lbu	a5,1169(a5) # 8000fde1 <finished+0x1>
    80005958:	fe0786e3          	beqz	a5,80005944 <_Z12testSleepingv+0x5c>
}
    8000595c:	03813083          	ld	ra,56(sp)
    80005960:	03013403          	ld	s0,48(sp)
    80005964:	02813483          	ld	s1,40(sp)
    80005968:	04010113          	addi	sp,sp,64
    8000596c:	00008067          	ret

0000000080005970 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005970:	f8010113          	addi	sp,sp,-128
    80005974:	06113c23          	sd	ra,120(sp)
    80005978:	06813823          	sd	s0,112(sp)
    8000597c:	06913423          	sd	s1,104(sp)
    80005980:	07213023          	sd	s2,96(sp)
    80005984:	05313c23          	sd	s3,88(sp)
    80005988:	05413823          	sd	s4,80(sp)
    8000598c:	05513423          	sd	s5,72(sp)
    80005990:	05613023          	sd	s6,64(sp)
    80005994:	03713c23          	sd	s7,56(sp)
    80005998:	03813823          	sd	s8,48(sp)
    8000599c:	03913423          	sd	s9,40(sp)
    800059a0:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    800059a4:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    800059a8:	00004517          	auipc	a0,0x4
    800059ac:	b2850513          	addi	a0,a0,-1240 # 800094d0 <CONSOLE_STATUS+0x4c0>
    800059b0:	ffffc097          	auipc	ra,0xffffc
    800059b4:	724080e7          	jalr	1828(ra) # 800020d4 <_Z11printStringPKc>
        getString(input, 30);
    800059b8:	01e00593          	li	a1,30
    800059bc:	f8040493          	addi	s1,s0,-128
    800059c0:	00048513          	mv	a0,s1
    800059c4:	ffffc097          	auipc	ra,0xffffc
    800059c8:	78c080e7          	jalr	1932(ra) # 80002150 <_Z9getStringPci>
        threadNum = stringToInt(input);
    800059cc:	00048513          	mv	a0,s1
    800059d0:	ffffd097          	auipc	ra,0xffffd
    800059d4:	84c080e7          	jalr	-1972(ra) # 8000221c <_Z11stringToIntPKc>
    800059d8:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    800059dc:	00004517          	auipc	a0,0x4
    800059e0:	b1450513          	addi	a0,a0,-1260 # 800094f0 <CONSOLE_STATUS+0x4e0>
    800059e4:	ffffc097          	auipc	ra,0xffffc
    800059e8:	6f0080e7          	jalr	1776(ra) # 800020d4 <_Z11printStringPKc>
        getString(input, 30);
    800059ec:	01e00593          	li	a1,30
    800059f0:	00048513          	mv	a0,s1
    800059f4:	ffffc097          	auipc	ra,0xffffc
    800059f8:	75c080e7          	jalr	1884(ra) # 80002150 <_Z9getStringPci>
        n = stringToInt(input);
    800059fc:	00048513          	mv	a0,s1
    80005a00:	ffffd097          	auipc	ra,0xffffd
    80005a04:	81c080e7          	jalr	-2020(ra) # 8000221c <_Z11stringToIntPKc>
    80005a08:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80005a0c:	00004517          	auipc	a0,0x4
    80005a10:	b0450513          	addi	a0,a0,-1276 # 80009510 <CONSOLE_STATUS+0x500>
    80005a14:	ffffc097          	auipc	ra,0xffffc
    80005a18:	6c0080e7          	jalr	1728(ra) # 800020d4 <_Z11printStringPKc>
    80005a1c:	00000613          	li	a2,0
    80005a20:	00a00593          	li	a1,10
    80005a24:	00098513          	mv	a0,s3
    80005a28:	ffffd097          	auipc	ra,0xffffd
    80005a2c:	844080e7          	jalr	-1980(ra) # 8000226c <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005a30:	00004517          	auipc	a0,0x4
    80005a34:	af850513          	addi	a0,a0,-1288 # 80009528 <CONSOLE_STATUS+0x518>
    80005a38:	ffffc097          	auipc	ra,0xffffc
    80005a3c:	69c080e7          	jalr	1692(ra) # 800020d4 <_Z11printStringPKc>
    80005a40:	00000613          	li	a2,0
    80005a44:	00a00593          	li	a1,10
    80005a48:	00048513          	mv	a0,s1
    80005a4c:	ffffd097          	auipc	ra,0xffffd
    80005a50:	820080e7          	jalr	-2016(ra) # 8000226c <_Z8printIntiii>
        printString(".\n");
    80005a54:	00003517          	auipc	a0,0x3
    80005a58:	7b450513          	addi	a0,a0,1972 # 80009208 <CONSOLE_STATUS+0x1f8>
    80005a5c:	ffffc097          	auipc	ra,0xffffc
    80005a60:	678080e7          	jalr	1656(ra) # 800020d4 <_Z11printStringPKc>
        if(threadNum > n) {
    80005a64:	0334c463          	blt	s1,s3,80005a8c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005a68:	03305c63          	blez	s3,80005aa0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005a6c:	03800513          	li	a0,56
    80005a70:	ffffd097          	auipc	ra,0xffffd
    80005a74:	390080e7          	jalr	912(ra) # 80002e00 <_Znwm>
    80005a78:	00050a93          	mv	s5,a0
    80005a7c:	00048593          	mv	a1,s1
    80005a80:	fffff097          	auipc	ra,0xfffff
    80005a84:	d34080e7          	jalr	-716(ra) # 800047b4 <_ZN9BufferCPPC1Ei>
    80005a88:	0300006f          	j	80005ab8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005a8c:	00004517          	auipc	a0,0x4
    80005a90:	ab450513          	addi	a0,a0,-1356 # 80009540 <CONSOLE_STATUS+0x530>
    80005a94:	ffffc097          	auipc	ra,0xffffc
    80005a98:	640080e7          	jalr	1600(ra) # 800020d4 <_Z11printStringPKc>
            return;
    80005a9c:	0140006f          	j	80005ab0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005aa0:	00004517          	auipc	a0,0x4
    80005aa4:	ae050513          	addi	a0,a0,-1312 # 80009580 <CONSOLE_STATUS+0x570>
    80005aa8:	ffffc097          	auipc	ra,0xffffc
    80005aac:	62c080e7          	jalr	1580(ra) # 800020d4 <_Z11printStringPKc>
            return;
    80005ab0:	000c0113          	mv	sp,s8
    80005ab4:	21c0006f          	j	80005cd0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    80005ab8:	01000513          	li	a0,16
    80005abc:	ffffd097          	auipc	ra,0xffffd
    80005ac0:	344080e7          	jalr	836(ra) # 80002e00 <_Znwm>
    80005ac4:	00050493          	mv	s1,a0
    80005ac8:	00000593          	li	a1,0
    80005acc:	ffffd097          	auipc	ra,0xffffd
    80005ad0:	42c080e7          	jalr	1068(ra) # 80002ef8 <_ZN9SemaphoreC1Ej>
    80005ad4:	0000a717          	auipc	a4,0xa
    80005ad8:	30470713          	addi	a4,a4,772 # 8000fdd8 <finishedA>
    80005adc:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    80005ae0:	00399793          	slli	a5,s3,0x3
    80005ae4:	00f78793          	addi	a5,a5,15
    80005ae8:	ff07f793          	andi	a5,a5,-16
    80005aec:	40f10133          	sub	sp,sp,a5
    80005af0:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80005af4:	0019869b          	addiw	a3,s3,1
    80005af8:	00169793          	slli	a5,a3,0x1
    80005afc:	00d787b3          	add	a5,a5,a3
    80005b00:	00379793          	slli	a5,a5,0x3
    80005b04:	00f78793          	addi	a5,a5,15
    80005b08:	ff07f793          	andi	a5,a5,-16
    80005b0c:	40f10133          	sub	sp,sp,a5
    80005b10:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80005b14:	00199493          	slli	s1,s3,0x1
    80005b18:	013484b3          	add	s1,s1,s3
    80005b1c:	00349493          	slli	s1,s1,0x3
    80005b20:	009b04b3          	add	s1,s6,s1
    80005b24:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005b28:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005b2c:	01873783          	ld	a5,24(a4)
    80005b30:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005b34:	01800513          	li	a0,24
    80005b38:	ffffd097          	auipc	ra,0xffffd
    80005b3c:	2c8080e7          	jalr	712(ra) # 80002e00 <_Znwm>
    80005b40:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005b44:	ffffd097          	auipc	ra,0xffffd
    80005b48:	47c080e7          	jalr	1148(ra) # 80002fc0 <_ZN6ThreadC1Ev>
    80005b4c:	00006797          	auipc	a5,0x6
    80005b50:	f4c78793          	addi	a5,a5,-180 # 8000ba98 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005b54:	00fbb023          	sd	a5,0(s7)
    80005b58:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005b5c:	000b8513          	mv	a0,s7
    80005b60:	ffffd097          	auipc	ra,0xffffd
    80005b64:	534080e7          	jalr	1332(ra) # 80003094 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005b68:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005b6c:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005b70:	0000a797          	auipc	a5,0xa
    80005b74:	2807b783          	ld	a5,640(a5) # 8000fdf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005b78:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005b7c:	01800513          	li	a0,24
    80005b80:	ffffd097          	auipc	ra,0xffffd
    80005b84:	280080e7          	jalr	640(ra) # 80002e00 <_Znwm>
    80005b88:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005b8c:	ffffd097          	auipc	ra,0xffffd
    80005b90:	434080e7          	jalr	1076(ra) # 80002fc0 <_ZN6ThreadC1Ev>
    80005b94:	00006797          	auipc	a5,0x6
    80005b98:	eb478793          	addi	a5,a5,-332 # 8000ba48 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005b9c:	00f4b023          	sd	a5,0(s1)
    80005ba0:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005ba4:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80005ba8:	00048513          	mv	a0,s1
    80005bac:	ffffd097          	auipc	ra,0xffffd
    80005bb0:	4e8080e7          	jalr	1256(ra) # 80003094 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005bb4:	00100913          	li	s2,1
    80005bb8:	0300006f          	j	80005be8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005bbc:	00006797          	auipc	a5,0x6
    80005bc0:	eb478793          	addi	a5,a5,-332 # 8000ba70 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005bc4:	00fcb023          	sd	a5,0(s9)
    80005bc8:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80005bcc:	00391793          	slli	a5,s2,0x3
    80005bd0:	00fa07b3          	add	a5,s4,a5
    80005bd4:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80005bd8:	000c8513          	mv	a0,s9
    80005bdc:	ffffd097          	auipc	ra,0xffffd
    80005be0:	4b8080e7          	jalr	1208(ra) # 80003094 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005be4:	0019091b          	addiw	s2,s2,1
    80005be8:	05395263          	bge	s2,s3,80005c2c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80005bec:	00191493          	slli	s1,s2,0x1
    80005bf0:	012484b3          	add	s1,s1,s2
    80005bf4:	00349493          	slli	s1,s1,0x3
    80005bf8:	009b04b3          	add	s1,s6,s1
    80005bfc:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80005c00:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80005c04:	0000a797          	auipc	a5,0xa
    80005c08:	1ec7b783          	ld	a5,492(a5) # 8000fdf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005c0c:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80005c10:	01800513          	li	a0,24
    80005c14:	ffffd097          	auipc	ra,0xffffd
    80005c18:	1ec080e7          	jalr	492(ra) # 80002e00 <_Znwm>
    80005c1c:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005c20:	ffffd097          	auipc	ra,0xffffd
    80005c24:	3a0080e7          	jalr	928(ra) # 80002fc0 <_ZN6ThreadC1Ev>
    80005c28:	f95ff06f          	j	80005bbc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80005c2c:	ffffd097          	auipc	ra,0xffffd
    80005c30:	440080e7          	jalr	1088(ra) # 8000306c <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80005c34:	00000493          	li	s1,0
    80005c38:	0099ce63          	blt	s3,s1,80005c54 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80005c3c:	0000a517          	auipc	a0,0xa
    80005c40:	1b453503          	ld	a0,436(a0) # 8000fdf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005c44:	ffffd097          	auipc	ra,0xffffd
    80005c48:	2ec080e7          	jalr	748(ra) # 80002f30 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80005c4c:	0014849b          	addiw	s1,s1,1
    80005c50:	fe9ff06f          	j	80005c38 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80005c54:	0000a517          	auipc	a0,0xa
    80005c58:	19c53503          	ld	a0,412(a0) # 8000fdf0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005c5c:	00050863          	beqz	a0,80005c6c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80005c60:	00053783          	ld	a5,0(a0)
    80005c64:	0087b783          	ld	a5,8(a5)
    80005c68:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80005c6c:	00000493          	li	s1,0
    80005c70:	0080006f          	j	80005c78 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80005c74:	0014849b          	addiw	s1,s1,1
    80005c78:	0334d263          	bge	s1,s3,80005c9c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80005c7c:	00349793          	slli	a5,s1,0x3
    80005c80:	00fa07b3          	add	a5,s4,a5
    80005c84:	0007b503          	ld	a0,0(a5)
    80005c88:	fe0506e3          	beqz	a0,80005c74 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80005c8c:	00053783          	ld	a5,0(a0)
    80005c90:	0087b783          	ld	a5,8(a5)
    80005c94:	000780e7          	jalr	a5
    80005c98:	fddff06f          	j	80005c74 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    80005c9c:	000b8a63          	beqz	s7,80005cb0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    80005ca0:	000bb783          	ld	a5,0(s7)
    80005ca4:	0087b783          	ld	a5,8(a5)
    80005ca8:	000b8513          	mv	a0,s7
    80005cac:	000780e7          	jalr	a5
        delete buffer;
    80005cb0:	000a8e63          	beqz	s5,80005ccc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    80005cb4:	000a8513          	mv	a0,s5
    80005cb8:	fffff097          	auipc	ra,0xfffff
    80005cbc:	df4080e7          	jalr	-524(ra) # 80004aac <_ZN9BufferCPPD1Ev>
    80005cc0:	000a8513          	mv	a0,s5
    80005cc4:	ffffd097          	auipc	ra,0xffffd
    80005cc8:	18c080e7          	jalr	396(ra) # 80002e50 <_ZdlPv>
    80005ccc:	000c0113          	mv	sp,s8
    }
    80005cd0:	f8040113          	addi	sp,s0,-128
    80005cd4:	07813083          	ld	ra,120(sp)
    80005cd8:	07013403          	ld	s0,112(sp)
    80005cdc:	06813483          	ld	s1,104(sp)
    80005ce0:	06013903          	ld	s2,96(sp)
    80005ce4:	05813983          	ld	s3,88(sp)
    80005ce8:	05013a03          	ld	s4,80(sp)
    80005cec:	04813a83          	ld	s5,72(sp)
    80005cf0:	04013b03          	ld	s6,64(sp)
    80005cf4:	03813b83          	ld	s7,56(sp)
    80005cf8:	03013c03          	ld	s8,48(sp)
    80005cfc:	02813c83          	ld	s9,40(sp)
    80005d00:	08010113          	addi	sp,sp,128
    80005d04:	00008067          	ret
    80005d08:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80005d0c:	000a8513          	mv	a0,s5
    80005d10:	ffffd097          	auipc	ra,0xffffd
    80005d14:	140080e7          	jalr	320(ra) # 80002e50 <_ZdlPv>
    80005d18:	00048513          	mv	a0,s1
    80005d1c:	0000b097          	auipc	ra,0xb
    80005d20:	1ac080e7          	jalr	428(ra) # 80010ec8 <_Unwind_Resume>
    80005d24:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80005d28:	00048513          	mv	a0,s1
    80005d2c:	ffffd097          	auipc	ra,0xffffd
    80005d30:	124080e7          	jalr	292(ra) # 80002e50 <_ZdlPv>
    80005d34:	00090513          	mv	a0,s2
    80005d38:	0000b097          	auipc	ra,0xb
    80005d3c:	190080e7          	jalr	400(ra) # 80010ec8 <_Unwind_Resume>
    80005d40:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005d44:	000b8513          	mv	a0,s7
    80005d48:	ffffd097          	auipc	ra,0xffffd
    80005d4c:	108080e7          	jalr	264(ra) # 80002e50 <_ZdlPv>
    80005d50:	00048513          	mv	a0,s1
    80005d54:	0000b097          	auipc	ra,0xb
    80005d58:	174080e7          	jalr	372(ra) # 80010ec8 <_Unwind_Resume>
    80005d5c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005d60:	00048513          	mv	a0,s1
    80005d64:	ffffd097          	auipc	ra,0xffffd
    80005d68:	0ec080e7          	jalr	236(ra) # 80002e50 <_ZdlPv>
    80005d6c:	00090513          	mv	a0,s2
    80005d70:	0000b097          	auipc	ra,0xb
    80005d74:	158080e7          	jalr	344(ra) # 80010ec8 <_Unwind_Resume>
    80005d78:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80005d7c:	000c8513          	mv	a0,s9
    80005d80:	ffffd097          	auipc	ra,0xffffd
    80005d84:	0d0080e7          	jalr	208(ra) # 80002e50 <_ZdlPv>
    80005d88:	00048513          	mv	a0,s1
    80005d8c:	0000b097          	auipc	ra,0xb
    80005d90:	13c080e7          	jalr	316(ra) # 80010ec8 <_Unwind_Resume>

0000000080005d94 <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80005d94:	ff010113          	addi	sp,sp,-16
    80005d98:	00813423          	sd	s0,8(sp)
    80005d9c:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    80005da0:	00813403          	ld	s0,8(sp)
    80005da4:	01010113          	addi	sp,sp,16
    80005da8:	00008067          	ret

0000000080005dac <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80005dac:	fe010113          	addi	sp,sp,-32
    80005db0:	00113c23          	sd	ra,24(sp)
    80005db4:	00813823          	sd	s0,16(sp)
    80005db8:	00913423          	sd	s1,8(sp)
    80005dbc:	02010413          	addi	s0,sp,32
    80005dc0:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80005dc4:	ffffc097          	auipc	ra,0xffffc
    80005dc8:	b40080e7          	jalr	-1216(ra) # 80001904 <_Z4getcv>
    80005dcc:	0005059b          	sext.w	a1,a0
    80005dd0:	01b00793          	li	a5,27
    80005dd4:	00f58c63          	beq	a1,a5,80005dec <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80005dd8:	0104b783          	ld	a5,16(s1)
    80005ddc:	0087b503          	ld	a0,8(a5)
    80005de0:	fffff097          	auipc	ra,0xfffff
    80005de4:	b28080e7          	jalr	-1240(ra) # 80004908 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80005de8:	fddff06f          	j	80005dc4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80005dec:	00100793          	li	a5,1
    80005df0:	0000a717          	auipc	a4,0xa
    80005df4:	fef72623          	sw	a5,-20(a4) # 8000fddc <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80005df8:	0104b783          	ld	a5,16(s1)
    80005dfc:	02100593          	li	a1,33
    80005e00:	0087b503          	ld	a0,8(a5)
    80005e04:	fffff097          	auipc	ra,0xfffff
    80005e08:	b04080e7          	jalr	-1276(ra) # 80004908 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80005e0c:	0104b783          	ld	a5,16(s1)
    80005e10:	0107b503          	ld	a0,16(a5)
    80005e14:	ffffd097          	auipc	ra,0xffffd
    80005e18:	148080e7          	jalr	328(ra) # 80002f5c <_ZN9Semaphore6signalEv>
        }
    80005e1c:	01813083          	ld	ra,24(sp)
    80005e20:	01013403          	ld	s0,16(sp)
    80005e24:	00813483          	ld	s1,8(sp)
    80005e28:	02010113          	addi	sp,sp,32
    80005e2c:	00008067          	ret

0000000080005e30 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80005e30:	fd010113          	addi	sp,sp,-48
    80005e34:	02113423          	sd	ra,40(sp)
    80005e38:	02813023          	sd	s0,32(sp)
    80005e3c:	00913c23          	sd	s1,24(sp)
    80005e40:	01213823          	sd	s2,16(sp)
    80005e44:	01313423          	sd	s3,8(sp)
    80005e48:	03010413          	addi	s0,sp,48
    80005e4c:	00050913          	mv	s2,a0
            int i = 0;
    80005e50:	00000993          	li	s3,0
    80005e54:	0100006f          	j	80005e64 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80005e58:	00a00513          	li	a0,10
    80005e5c:	ffffd097          	auipc	ra,0xffffd
    80005e60:	2fc080e7          	jalr	764(ra) # 80003158 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80005e64:	0000a797          	auipc	a5,0xa
    80005e68:	f787a783          	lw	a5,-136(a5) # 8000fddc <_ZN19ConsumerProducerCPP9threadEndE>
    80005e6c:	04079a63          	bnez	a5,80005ec0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80005e70:	01093783          	ld	a5,16(s2)
    80005e74:	0087b503          	ld	a0,8(a5)
    80005e78:	fffff097          	auipc	ra,0xfffff
    80005e7c:	b20080e7          	jalr	-1248(ra) # 80004998 <_ZN9BufferCPP3getEv>
                i++;
    80005e80:	0019849b          	addiw	s1,s3,1
    80005e84:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80005e88:	0ff57513          	andi	a0,a0,255
    80005e8c:	ffffd097          	auipc	ra,0xffffd
    80005e90:	2cc080e7          	jalr	716(ra) # 80003158 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80005e94:	05000793          	li	a5,80
    80005e98:	02f4e4bb          	remw	s1,s1,a5
    80005e9c:	fc0494e3          	bnez	s1,80005e64 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80005ea0:	fb9ff06f          	j	80005e58 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80005ea4:	01093783          	ld	a5,16(s2)
    80005ea8:	0087b503          	ld	a0,8(a5)
    80005eac:	fffff097          	auipc	ra,0xfffff
    80005eb0:	aec080e7          	jalr	-1300(ra) # 80004998 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80005eb4:	0ff57513          	andi	a0,a0,255
    80005eb8:	ffffd097          	auipc	ra,0xffffd
    80005ebc:	2a0080e7          	jalr	672(ra) # 80003158 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80005ec0:	01093783          	ld	a5,16(s2)
    80005ec4:	0087b503          	ld	a0,8(a5)
    80005ec8:	fffff097          	auipc	ra,0xfffff
    80005ecc:	b5c080e7          	jalr	-1188(ra) # 80004a24 <_ZN9BufferCPP6getCntEv>
    80005ed0:	fca04ae3          	bgtz	a0,80005ea4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80005ed4:	01093783          	ld	a5,16(s2)
    80005ed8:	0107b503          	ld	a0,16(a5)
    80005edc:	ffffd097          	auipc	ra,0xffffd
    80005ee0:	080080e7          	jalr	128(ra) # 80002f5c <_ZN9Semaphore6signalEv>
        }
    80005ee4:	02813083          	ld	ra,40(sp)
    80005ee8:	02013403          	ld	s0,32(sp)
    80005eec:	01813483          	ld	s1,24(sp)
    80005ef0:	01013903          	ld	s2,16(sp)
    80005ef4:	00813983          	ld	s3,8(sp)
    80005ef8:	03010113          	addi	sp,sp,48
    80005efc:	00008067          	ret

0000000080005f00 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    80005f00:	ff010113          	addi	sp,sp,-16
    80005f04:	00113423          	sd	ra,8(sp)
    80005f08:	00813023          	sd	s0,0(sp)
    80005f0c:	01010413          	addi	s0,sp,16
    80005f10:	00006797          	auipc	a5,0x6
    80005f14:	b1078793          	addi	a5,a5,-1264 # 8000ba20 <_ZTV8Consumer+0x10>
    80005f18:	00f53023          	sd	a5,0(a0)
    80005f1c:	ffffd097          	auipc	ra,0xffffd
    80005f20:	ea4080e7          	jalr	-348(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80005f24:	00813083          	ld	ra,8(sp)
    80005f28:	00013403          	ld	s0,0(sp)
    80005f2c:	01010113          	addi	sp,sp,16
    80005f30:	00008067          	ret

0000000080005f34 <_ZN8ConsumerD0Ev>:
    80005f34:	fe010113          	addi	sp,sp,-32
    80005f38:	00113c23          	sd	ra,24(sp)
    80005f3c:	00813823          	sd	s0,16(sp)
    80005f40:	00913423          	sd	s1,8(sp)
    80005f44:	02010413          	addi	s0,sp,32
    80005f48:	00050493          	mv	s1,a0
    80005f4c:	00006797          	auipc	a5,0x6
    80005f50:	ad478793          	addi	a5,a5,-1324 # 8000ba20 <_ZTV8Consumer+0x10>
    80005f54:	00f53023          	sd	a5,0(a0)
    80005f58:	ffffd097          	auipc	ra,0xffffd
    80005f5c:	e68080e7          	jalr	-408(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80005f60:	00048513          	mv	a0,s1
    80005f64:	ffffd097          	auipc	ra,0xffffd
    80005f68:	eec080e7          	jalr	-276(ra) # 80002e50 <_ZdlPv>
    80005f6c:	01813083          	ld	ra,24(sp)
    80005f70:	01013403          	ld	s0,16(sp)
    80005f74:	00813483          	ld	s1,8(sp)
    80005f78:	02010113          	addi	sp,sp,32
    80005f7c:	00008067          	ret

0000000080005f80 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80005f80:	ff010113          	addi	sp,sp,-16
    80005f84:	00113423          	sd	ra,8(sp)
    80005f88:	00813023          	sd	s0,0(sp)
    80005f8c:	01010413          	addi	s0,sp,16
    80005f90:	00006797          	auipc	a5,0x6
    80005f94:	a6878793          	addi	a5,a5,-1432 # 8000b9f8 <_ZTV8Producer+0x10>
    80005f98:	00f53023          	sd	a5,0(a0)
    80005f9c:	ffffd097          	auipc	ra,0xffffd
    80005fa0:	e24080e7          	jalr	-476(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80005fa4:	00813083          	ld	ra,8(sp)
    80005fa8:	00013403          	ld	s0,0(sp)
    80005fac:	01010113          	addi	sp,sp,16
    80005fb0:	00008067          	ret

0000000080005fb4 <_ZN8ProducerD0Ev>:
    80005fb4:	fe010113          	addi	sp,sp,-32
    80005fb8:	00113c23          	sd	ra,24(sp)
    80005fbc:	00813823          	sd	s0,16(sp)
    80005fc0:	00913423          	sd	s1,8(sp)
    80005fc4:	02010413          	addi	s0,sp,32
    80005fc8:	00050493          	mv	s1,a0
    80005fcc:	00006797          	auipc	a5,0x6
    80005fd0:	a2c78793          	addi	a5,a5,-1492 # 8000b9f8 <_ZTV8Producer+0x10>
    80005fd4:	00f53023          	sd	a5,0(a0)
    80005fd8:	ffffd097          	auipc	ra,0xffffd
    80005fdc:	de8080e7          	jalr	-536(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80005fe0:	00048513          	mv	a0,s1
    80005fe4:	ffffd097          	auipc	ra,0xffffd
    80005fe8:	e6c080e7          	jalr	-404(ra) # 80002e50 <_ZdlPv>
    80005fec:	01813083          	ld	ra,24(sp)
    80005ff0:	01013403          	ld	s0,16(sp)
    80005ff4:	00813483          	ld	s1,8(sp)
    80005ff8:	02010113          	addi	sp,sp,32
    80005ffc:	00008067          	ret

0000000080006000 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80006000:	ff010113          	addi	sp,sp,-16
    80006004:	00113423          	sd	ra,8(sp)
    80006008:	00813023          	sd	s0,0(sp)
    8000600c:	01010413          	addi	s0,sp,16
    80006010:	00006797          	auipc	a5,0x6
    80006014:	9c078793          	addi	a5,a5,-1600 # 8000b9d0 <_ZTV16ProducerKeyboard+0x10>
    80006018:	00f53023          	sd	a5,0(a0)
    8000601c:	ffffd097          	auipc	ra,0xffffd
    80006020:	da4080e7          	jalr	-604(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80006024:	00813083          	ld	ra,8(sp)
    80006028:	00013403          	ld	s0,0(sp)
    8000602c:	01010113          	addi	sp,sp,16
    80006030:	00008067          	ret

0000000080006034 <_ZN16ProducerKeyboardD0Ev>:
    80006034:	fe010113          	addi	sp,sp,-32
    80006038:	00113c23          	sd	ra,24(sp)
    8000603c:	00813823          	sd	s0,16(sp)
    80006040:	00913423          	sd	s1,8(sp)
    80006044:	02010413          	addi	s0,sp,32
    80006048:	00050493          	mv	s1,a0
    8000604c:	00006797          	auipc	a5,0x6
    80006050:	98478793          	addi	a5,a5,-1660 # 8000b9d0 <_ZTV16ProducerKeyboard+0x10>
    80006054:	00f53023          	sd	a5,0(a0)
    80006058:	ffffd097          	auipc	ra,0xffffd
    8000605c:	d68080e7          	jalr	-664(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80006060:	00048513          	mv	a0,s1
    80006064:	ffffd097          	auipc	ra,0xffffd
    80006068:	dec080e7          	jalr	-532(ra) # 80002e50 <_ZdlPv>
    8000606c:	01813083          	ld	ra,24(sp)
    80006070:	01013403          	ld	s0,16(sp)
    80006074:	00813483          	ld	s1,8(sp)
    80006078:	02010113          	addi	sp,sp,32
    8000607c:	00008067          	ret

0000000080006080 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006080:	ff010113          	addi	sp,sp,-16
    80006084:	00113423          	sd	ra,8(sp)
    80006088:	00813023          	sd	s0,0(sp)
    8000608c:	01010413          	addi	s0,sp,16
    80006090:	00006797          	auipc	a5,0x6
    80006094:	a0878793          	addi	a5,a5,-1528 # 8000ba98 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006098:	00f53023          	sd	a5,0(a0)
    8000609c:	ffffd097          	auipc	ra,0xffffd
    800060a0:	d24080e7          	jalr	-732(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    800060a4:	00813083          	ld	ra,8(sp)
    800060a8:	00013403          	ld	s0,0(sp)
    800060ac:	01010113          	addi	sp,sp,16
    800060b0:	00008067          	ret

00000000800060b4 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    800060b4:	fe010113          	addi	sp,sp,-32
    800060b8:	00113c23          	sd	ra,24(sp)
    800060bc:	00813823          	sd	s0,16(sp)
    800060c0:	00913423          	sd	s1,8(sp)
    800060c4:	02010413          	addi	s0,sp,32
    800060c8:	00050493          	mv	s1,a0
    800060cc:	00006797          	auipc	a5,0x6
    800060d0:	9cc78793          	addi	a5,a5,-1588 # 8000ba98 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800060d4:	00f53023          	sd	a5,0(a0)
    800060d8:	ffffd097          	auipc	ra,0xffffd
    800060dc:	ce8080e7          	jalr	-792(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    800060e0:	00048513          	mv	a0,s1
    800060e4:	ffffd097          	auipc	ra,0xffffd
    800060e8:	d6c080e7          	jalr	-660(ra) # 80002e50 <_ZdlPv>
    800060ec:	01813083          	ld	ra,24(sp)
    800060f0:	01013403          	ld	s0,16(sp)
    800060f4:	00813483          	ld	s1,8(sp)
    800060f8:	02010113          	addi	sp,sp,32
    800060fc:	00008067          	ret

0000000080006100 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80006100:	ff010113          	addi	sp,sp,-16
    80006104:	00113423          	sd	ra,8(sp)
    80006108:	00813023          	sd	s0,0(sp)
    8000610c:	01010413          	addi	s0,sp,16
    80006110:	00006797          	auipc	a5,0x6
    80006114:	93878793          	addi	a5,a5,-1736 # 8000ba48 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006118:	00f53023          	sd	a5,0(a0)
    8000611c:	ffffd097          	auipc	ra,0xffffd
    80006120:	ca4080e7          	jalr	-860(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80006124:	00813083          	ld	ra,8(sp)
    80006128:	00013403          	ld	s0,0(sp)
    8000612c:	01010113          	addi	sp,sp,16
    80006130:	00008067          	ret

0000000080006134 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80006134:	fe010113          	addi	sp,sp,-32
    80006138:	00113c23          	sd	ra,24(sp)
    8000613c:	00813823          	sd	s0,16(sp)
    80006140:	00913423          	sd	s1,8(sp)
    80006144:	02010413          	addi	s0,sp,32
    80006148:	00050493          	mv	s1,a0
    8000614c:	00006797          	auipc	a5,0x6
    80006150:	8fc78793          	addi	a5,a5,-1796 # 8000ba48 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006154:	00f53023          	sd	a5,0(a0)
    80006158:	ffffd097          	auipc	ra,0xffffd
    8000615c:	c68080e7          	jalr	-920(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    80006160:	00048513          	mv	a0,s1
    80006164:	ffffd097          	auipc	ra,0xffffd
    80006168:	cec080e7          	jalr	-788(ra) # 80002e50 <_ZdlPv>
    8000616c:	01813083          	ld	ra,24(sp)
    80006170:	01013403          	ld	s0,16(sp)
    80006174:	00813483          	ld	s1,8(sp)
    80006178:	02010113          	addi	sp,sp,32
    8000617c:	00008067          	ret

0000000080006180 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006180:	ff010113          	addi	sp,sp,-16
    80006184:	00113423          	sd	ra,8(sp)
    80006188:	00813023          	sd	s0,0(sp)
    8000618c:	01010413          	addi	s0,sp,16
    80006190:	00006797          	auipc	a5,0x6
    80006194:	8e078793          	addi	a5,a5,-1824 # 8000ba70 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006198:	00f53023          	sd	a5,0(a0)
    8000619c:	ffffd097          	auipc	ra,0xffffd
    800061a0:	c24080e7          	jalr	-988(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    800061a4:	00813083          	ld	ra,8(sp)
    800061a8:	00013403          	ld	s0,0(sp)
    800061ac:	01010113          	addi	sp,sp,16
    800061b0:	00008067          	ret

00000000800061b4 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    800061b4:	fe010113          	addi	sp,sp,-32
    800061b8:	00113c23          	sd	ra,24(sp)
    800061bc:	00813823          	sd	s0,16(sp)
    800061c0:	00913423          	sd	s1,8(sp)
    800061c4:	02010413          	addi	s0,sp,32
    800061c8:	00050493          	mv	s1,a0
    800061cc:	00006797          	auipc	a5,0x6
    800061d0:	8a478793          	addi	a5,a5,-1884 # 8000ba70 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800061d4:	00f53023          	sd	a5,0(a0)
    800061d8:	ffffd097          	auipc	ra,0xffffd
    800061dc:	be8080e7          	jalr	-1048(ra) # 80002dc0 <_ZN6ThreadD1Ev>
    800061e0:	00048513          	mv	a0,s1
    800061e4:	ffffd097          	auipc	ra,0xffffd
    800061e8:	c6c080e7          	jalr	-916(ra) # 80002e50 <_ZdlPv>
    800061ec:	01813083          	ld	ra,24(sp)
    800061f0:	01013403          	ld	s0,16(sp)
    800061f4:	00813483          	ld	s1,8(sp)
    800061f8:	02010113          	addi	sp,sp,32
    800061fc:	00008067          	ret

0000000080006200 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006200:	fe010113          	addi	sp,sp,-32
    80006204:	00113c23          	sd	ra,24(sp)
    80006208:	00813823          	sd	s0,16(sp)
    8000620c:	00913423          	sd	s1,8(sp)
    80006210:	01213023          	sd	s2,0(sp)
    80006214:	02010413          	addi	s0,sp,32
    80006218:	00050493          	mv	s1,a0
            int i = 0;
    8000621c:	00000913          	li	s2,0
            while (!threadEnd) {
    80006220:	0000a797          	auipc	a5,0xa
    80006224:	bbc7a783          	lw	a5,-1092(a5) # 8000fddc <_ZN19ConsumerProducerCPP9threadEndE>
    80006228:	04079263          	bnez	a5,8000626c <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000622c:	0104b783          	ld	a5,16(s1)
    80006230:	0007a583          	lw	a1,0(a5)
    80006234:	0305859b          	addiw	a1,a1,48
    80006238:	0087b503          	ld	a0,8(a5)
    8000623c:	ffffe097          	auipc	ra,0xffffe
    80006240:	6cc080e7          	jalr	1740(ra) # 80004908 <_ZN9BufferCPP3putEi>
                i++;
    80006244:	0019071b          	addiw	a4,s2,1
    80006248:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8000624c:	0104b783          	ld	a5,16(s1)
    80006250:	0007a783          	lw	a5,0(a5)
    80006254:	00e787bb          	addw	a5,a5,a4
    80006258:	00500513          	li	a0,5
    8000625c:	02a7e53b          	remw	a0,a5,a0
    80006260:	ffffd097          	auipc	ra,0xffffd
    80006264:	da4080e7          	jalr	-604(ra) # 80003004 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006268:	fb9ff06f          	j	80006220 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    8000626c:	0104b783          	ld	a5,16(s1)
    80006270:	0107b503          	ld	a0,16(a5)
    80006274:	ffffd097          	auipc	ra,0xffffd
    80006278:	ce8080e7          	jalr	-792(ra) # 80002f5c <_ZN9Semaphore6signalEv>
        }
    8000627c:	01813083          	ld	ra,24(sp)
    80006280:	01013403          	ld	s0,16(sp)
    80006284:	00813483          	ld	s1,8(sp)
    80006288:	00013903          	ld	s2,0(sp)
    8000628c:	02010113          	addi	sp,sp,32
    80006290:	00008067          	ret

0000000080006294 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80006294:	ff010113          	addi	sp,sp,-16
    80006298:	00113423          	sd	ra,8(sp)
    8000629c:	00813023          	sd	s0,0(sp)
    800062a0:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    800062a4:	01053583          	ld	a1,16(a0)
    800062a8:	fffff097          	auipc	ra,0xfffff
    800062ac:	fb0080e7          	jalr	-80(ra) # 80005258 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    800062b0:	00813083          	ld	ra,8(sp)
    800062b4:	00013403          	ld	s0,0(sp)
    800062b8:	01010113          	addi	sp,sp,16
    800062bc:	00008067          	ret

00000000800062c0 <_ZN8Producer3runEv>:
    void run() override {
    800062c0:	ff010113          	addi	sp,sp,-16
    800062c4:	00113423          	sd	ra,8(sp)
    800062c8:	00813023          	sd	s0,0(sp)
    800062cc:	01010413          	addi	s0,sp,16
        producer(td);
    800062d0:	01053583          	ld	a1,16(a0)
    800062d4:	fffff097          	auipc	ra,0xfffff
    800062d8:	044080e7          	jalr	68(ra) # 80005318 <_ZN8Producer8producerEPv>
    }
    800062dc:	00813083          	ld	ra,8(sp)
    800062e0:	00013403          	ld	s0,0(sp)
    800062e4:	01010113          	addi	sp,sp,16
    800062e8:	00008067          	ret

00000000800062ec <_ZN8Consumer3runEv>:
    void run() override {
    800062ec:	ff010113          	addi	sp,sp,-16
    800062f0:	00113423          	sd	ra,8(sp)
    800062f4:	00813023          	sd	s0,0(sp)
    800062f8:	01010413          	addi	s0,sp,16
        consumer(td);
    800062fc:	01053583          	ld	a1,16(a0)
    80006300:	fffff097          	auipc	ra,0xfffff
    80006304:	0ac080e7          	jalr	172(ra) # 800053ac <_ZN8Consumer8consumerEPv>
    }
    80006308:	00813083          	ld	ra,8(sp)
    8000630c:	00013403          	ld	s0,0(sp)
    80006310:	01010113          	addi	sp,sp,16
    80006314:	00008067          	ret

0000000080006318 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006318:	fe010113          	addi	sp,sp,-32
    8000631c:	00113c23          	sd	ra,24(sp)
    80006320:	00813823          	sd	s0,16(sp)
    80006324:	00913423          	sd	s1,8(sp)
    80006328:	01213023          	sd	s2,0(sp)
    8000632c:	02010413          	addi	s0,sp,32
    80006330:	00050493          	mv	s1,a0
    80006334:	00058913          	mv	s2,a1
    80006338:	0015879b          	addiw	a5,a1,1
    8000633c:	0007851b          	sext.w	a0,a5
    80006340:	00f4a023          	sw	a5,0(s1)
    80006344:	0004a823          	sw	zero,16(s1)
    80006348:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000634c:	00251513          	slli	a0,a0,0x2
    80006350:	ffffb097          	auipc	ra,0xffffb
    80006354:	304080e7          	jalr	772(ra) # 80001654 <_Z9mem_allocm>
    80006358:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000635c:	00000593          	li	a1,0
    80006360:	02048513          	addi	a0,s1,32
    80006364:	ffffb097          	auipc	ra,0xffffb
    80006368:	4b8080e7          	jalr	1208(ra) # 8000181c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000636c:	00090593          	mv	a1,s2
    80006370:	01848513          	addi	a0,s1,24
    80006374:	ffffb097          	auipc	ra,0xffffb
    80006378:	4a8080e7          	jalr	1192(ra) # 8000181c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000637c:	00100593          	li	a1,1
    80006380:	02848513          	addi	a0,s1,40
    80006384:	ffffb097          	auipc	ra,0xffffb
    80006388:	498080e7          	jalr	1176(ra) # 8000181c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000638c:	00100593          	li	a1,1
    80006390:	03048513          	addi	a0,s1,48
    80006394:	ffffb097          	auipc	ra,0xffffb
    80006398:	488080e7          	jalr	1160(ra) # 8000181c <_Z8sem_openPP10_semaphorej>
}
    8000639c:	01813083          	ld	ra,24(sp)
    800063a0:	01013403          	ld	s0,16(sp)
    800063a4:	00813483          	ld	s1,8(sp)
    800063a8:	00013903          	ld	s2,0(sp)
    800063ac:	02010113          	addi	sp,sp,32
    800063b0:	00008067          	ret

00000000800063b4 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800063b4:	fe010113          	addi	sp,sp,-32
    800063b8:	00113c23          	sd	ra,24(sp)
    800063bc:	00813823          	sd	s0,16(sp)
    800063c0:	00913423          	sd	s1,8(sp)
    800063c4:	01213023          	sd	s2,0(sp)
    800063c8:	02010413          	addi	s0,sp,32
    800063cc:	00050493          	mv	s1,a0
    800063d0:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800063d4:	01853503          	ld	a0,24(a0)
    800063d8:	ffffb097          	auipc	ra,0xffffb
    800063dc:	4a8080e7          	jalr	1192(ra) # 80001880 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    800063e0:	0304b503          	ld	a0,48(s1)
    800063e4:	ffffb097          	auipc	ra,0xffffb
    800063e8:	49c080e7          	jalr	1180(ra) # 80001880 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    800063ec:	0084b783          	ld	a5,8(s1)
    800063f0:	0144a703          	lw	a4,20(s1)
    800063f4:	00271713          	slli	a4,a4,0x2
    800063f8:	00e787b3          	add	a5,a5,a4
    800063fc:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006400:	0144a783          	lw	a5,20(s1)
    80006404:	0017879b          	addiw	a5,a5,1
    80006408:	0004a703          	lw	a4,0(s1)
    8000640c:	02e7e7bb          	remw	a5,a5,a4
    80006410:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006414:	0304b503          	ld	a0,48(s1)
    80006418:	ffffb097          	auipc	ra,0xffffb
    8000641c:	494080e7          	jalr	1172(ra) # 800018ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80006420:	0204b503          	ld	a0,32(s1)
    80006424:	ffffb097          	auipc	ra,0xffffb
    80006428:	488080e7          	jalr	1160(ra) # 800018ac <_Z10sem_signalP10_semaphore>

}
    8000642c:	01813083          	ld	ra,24(sp)
    80006430:	01013403          	ld	s0,16(sp)
    80006434:	00813483          	ld	s1,8(sp)
    80006438:	00013903          	ld	s2,0(sp)
    8000643c:	02010113          	addi	sp,sp,32
    80006440:	00008067          	ret

0000000080006444 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006444:	fe010113          	addi	sp,sp,-32
    80006448:	00113c23          	sd	ra,24(sp)
    8000644c:	00813823          	sd	s0,16(sp)
    80006450:	00913423          	sd	s1,8(sp)
    80006454:	01213023          	sd	s2,0(sp)
    80006458:	02010413          	addi	s0,sp,32
    8000645c:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006460:	02053503          	ld	a0,32(a0)
    80006464:	ffffb097          	auipc	ra,0xffffb
    80006468:	41c080e7          	jalr	1052(ra) # 80001880 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    8000646c:	0284b503          	ld	a0,40(s1)
    80006470:	ffffb097          	auipc	ra,0xffffb
    80006474:	410080e7          	jalr	1040(ra) # 80001880 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006478:	0084b703          	ld	a4,8(s1)
    8000647c:	0104a783          	lw	a5,16(s1)
    80006480:	00279693          	slli	a3,a5,0x2
    80006484:	00d70733          	add	a4,a4,a3
    80006488:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000648c:	0017879b          	addiw	a5,a5,1
    80006490:	0004a703          	lw	a4,0(s1)
    80006494:	02e7e7bb          	remw	a5,a5,a4
    80006498:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000649c:	0284b503          	ld	a0,40(s1)
    800064a0:	ffffb097          	auipc	ra,0xffffb
    800064a4:	40c080e7          	jalr	1036(ra) # 800018ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    800064a8:	0184b503          	ld	a0,24(s1)
    800064ac:	ffffb097          	auipc	ra,0xffffb
    800064b0:	400080e7          	jalr	1024(ra) # 800018ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    800064b4:	00090513          	mv	a0,s2
    800064b8:	01813083          	ld	ra,24(sp)
    800064bc:	01013403          	ld	s0,16(sp)
    800064c0:	00813483          	ld	s1,8(sp)
    800064c4:	00013903          	ld	s2,0(sp)
    800064c8:	02010113          	addi	sp,sp,32
    800064cc:	00008067          	ret

00000000800064d0 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800064d0:	fe010113          	addi	sp,sp,-32
    800064d4:	00113c23          	sd	ra,24(sp)
    800064d8:	00813823          	sd	s0,16(sp)
    800064dc:	00913423          	sd	s1,8(sp)
    800064e0:	01213023          	sd	s2,0(sp)
    800064e4:	02010413          	addi	s0,sp,32
    800064e8:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800064ec:	02853503          	ld	a0,40(a0)
    800064f0:	ffffb097          	auipc	ra,0xffffb
    800064f4:	390080e7          	jalr	912(ra) # 80001880 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800064f8:	0304b503          	ld	a0,48(s1)
    800064fc:	ffffb097          	auipc	ra,0xffffb
    80006500:	384080e7          	jalr	900(ra) # 80001880 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80006504:	0144a783          	lw	a5,20(s1)
    80006508:	0104a903          	lw	s2,16(s1)
    8000650c:	0327ce63          	blt	a5,s2,80006548 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006510:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006514:	0304b503          	ld	a0,48(s1)
    80006518:	ffffb097          	auipc	ra,0xffffb
    8000651c:	394080e7          	jalr	916(ra) # 800018ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006520:	0284b503          	ld	a0,40(s1)
    80006524:	ffffb097          	auipc	ra,0xffffb
    80006528:	388080e7          	jalr	904(ra) # 800018ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    8000652c:	00090513          	mv	a0,s2
    80006530:	01813083          	ld	ra,24(sp)
    80006534:	01013403          	ld	s0,16(sp)
    80006538:	00813483          	ld	s1,8(sp)
    8000653c:	00013903          	ld	s2,0(sp)
    80006540:	02010113          	addi	sp,sp,32
    80006544:	00008067          	ret
        ret = cap - head + tail;
    80006548:	0004a703          	lw	a4,0(s1)
    8000654c:	4127093b          	subw	s2,a4,s2
    80006550:	00f9093b          	addw	s2,s2,a5
    80006554:	fc1ff06f          	j	80006514 <_ZN6Buffer6getCntEv+0x44>

0000000080006558 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006558:	fe010113          	addi	sp,sp,-32
    8000655c:	00113c23          	sd	ra,24(sp)
    80006560:	00813823          	sd	s0,16(sp)
    80006564:	00913423          	sd	s1,8(sp)
    80006568:	02010413          	addi	s0,sp,32
    8000656c:	00050493          	mv	s1,a0
    putc('\n');
    80006570:	00a00513          	li	a0,10
    80006574:	ffffb097          	auipc	ra,0xffffb
    80006578:	3b8080e7          	jalr	952(ra) # 8000192c <_Z4putcc>
    printString("Buffer deleted!\n");
    8000657c:	00003517          	auipc	a0,0x3
    80006580:	e3450513          	addi	a0,a0,-460 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80006584:	ffffc097          	auipc	ra,0xffffc
    80006588:	b50080e7          	jalr	-1200(ra) # 800020d4 <_Z11printStringPKc>
    while (getCnt() > 0) {
    8000658c:	00048513          	mv	a0,s1
    80006590:	00000097          	auipc	ra,0x0
    80006594:	f40080e7          	jalr	-192(ra) # 800064d0 <_ZN6Buffer6getCntEv>
    80006598:	02a05c63          	blez	a0,800065d0 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    8000659c:	0084b783          	ld	a5,8(s1)
    800065a0:	0104a703          	lw	a4,16(s1)
    800065a4:	00271713          	slli	a4,a4,0x2
    800065a8:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800065ac:	0007c503          	lbu	a0,0(a5)
    800065b0:	ffffb097          	auipc	ra,0xffffb
    800065b4:	37c080e7          	jalr	892(ra) # 8000192c <_Z4putcc>
        head = (head + 1) % cap;
    800065b8:	0104a783          	lw	a5,16(s1)
    800065bc:	0017879b          	addiw	a5,a5,1
    800065c0:	0004a703          	lw	a4,0(s1)
    800065c4:	02e7e7bb          	remw	a5,a5,a4
    800065c8:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800065cc:	fc1ff06f          	j	8000658c <_ZN6BufferD1Ev+0x34>
    putc('!');
    800065d0:	02100513          	li	a0,33
    800065d4:	ffffb097          	auipc	ra,0xffffb
    800065d8:	358080e7          	jalr	856(ra) # 8000192c <_Z4putcc>
    putc('\n');
    800065dc:	00a00513          	li	a0,10
    800065e0:	ffffb097          	auipc	ra,0xffffb
    800065e4:	34c080e7          	jalr	844(ra) # 8000192c <_Z4putcc>
    mem_free(buffer);
    800065e8:	0084b503          	ld	a0,8(s1)
    800065ec:	ffffb097          	auipc	ra,0xffffb
    800065f0:	098080e7          	jalr	152(ra) # 80001684 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800065f4:	0204b503          	ld	a0,32(s1)
    800065f8:	ffffb097          	auipc	ra,0xffffb
    800065fc:	25c080e7          	jalr	604(ra) # 80001854 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006600:	0184b503          	ld	a0,24(s1)
    80006604:	ffffb097          	auipc	ra,0xffffb
    80006608:	250080e7          	jalr	592(ra) # 80001854 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000660c:	0304b503          	ld	a0,48(s1)
    80006610:	ffffb097          	auipc	ra,0xffffb
    80006614:	244080e7          	jalr	580(ra) # 80001854 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006618:	0284b503          	ld	a0,40(s1)
    8000661c:	ffffb097          	auipc	ra,0xffffb
    80006620:	238080e7          	jalr	568(ra) # 80001854 <_Z9sem_closeP10_semaphore>
}
    80006624:	01813083          	ld	ra,24(sp)
    80006628:	01013403          	ld	s0,16(sp)
    8000662c:	00813483          	ld	s1,8(sp)
    80006630:	02010113          	addi	sp,sp,32
    80006634:	00008067          	ret

0000000080006638 <start>:
    80006638:	ff010113          	addi	sp,sp,-16
    8000663c:	00813423          	sd	s0,8(sp)
    80006640:	01010413          	addi	s0,sp,16
    80006644:	300027f3          	csrr	a5,mstatus
    80006648:	ffffe737          	lui	a4,0xffffe
    8000664c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed79f>
    80006650:	00e7f7b3          	and	a5,a5,a4
    80006654:	00001737          	lui	a4,0x1
    80006658:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000665c:	00e7e7b3          	or	a5,a5,a4
    80006660:	30079073          	csrw	mstatus,a5
    80006664:	00000797          	auipc	a5,0x0
    80006668:	16078793          	addi	a5,a5,352 # 800067c4 <system_main>
    8000666c:	34179073          	csrw	mepc,a5
    80006670:	00000793          	li	a5,0
    80006674:	18079073          	csrw	satp,a5
    80006678:	000107b7          	lui	a5,0x10
    8000667c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006680:	30279073          	csrw	medeleg,a5
    80006684:	30379073          	csrw	mideleg,a5
    80006688:	104027f3          	csrr	a5,sie
    8000668c:	2227e793          	ori	a5,a5,546
    80006690:	10479073          	csrw	sie,a5
    80006694:	fff00793          	li	a5,-1
    80006698:	00a7d793          	srli	a5,a5,0xa
    8000669c:	3b079073          	csrw	pmpaddr0,a5
    800066a0:	00f00793          	li	a5,15
    800066a4:	3a079073          	csrw	pmpcfg0,a5
    800066a8:	f14027f3          	csrr	a5,mhartid
    800066ac:	0200c737          	lui	a4,0x200c
    800066b0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800066b4:	0007869b          	sext.w	a3,a5
    800066b8:	00269713          	slli	a4,a3,0x2
    800066bc:	000f4637          	lui	a2,0xf4
    800066c0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800066c4:	00d70733          	add	a4,a4,a3
    800066c8:	0037979b          	slliw	a5,a5,0x3
    800066cc:	020046b7          	lui	a3,0x2004
    800066d0:	00d787b3          	add	a5,a5,a3
    800066d4:	00c585b3          	add	a1,a1,a2
    800066d8:	00371693          	slli	a3,a4,0x3
    800066dc:	00009717          	auipc	a4,0x9
    800066e0:	72470713          	addi	a4,a4,1828 # 8000fe00 <timer_scratch>
    800066e4:	00b7b023          	sd	a1,0(a5)
    800066e8:	00d70733          	add	a4,a4,a3
    800066ec:	00f73c23          	sd	a5,24(a4)
    800066f0:	02c73023          	sd	a2,32(a4)
    800066f4:	34071073          	csrw	mscratch,a4
    800066f8:	00000797          	auipc	a5,0x0
    800066fc:	6e878793          	addi	a5,a5,1768 # 80006de0 <timervec>
    80006700:	30579073          	csrw	mtvec,a5
    80006704:	300027f3          	csrr	a5,mstatus
    80006708:	0087e793          	ori	a5,a5,8
    8000670c:	30079073          	csrw	mstatus,a5
    80006710:	304027f3          	csrr	a5,mie
    80006714:	0807e793          	ori	a5,a5,128
    80006718:	30479073          	csrw	mie,a5
    8000671c:	f14027f3          	csrr	a5,mhartid
    80006720:	0007879b          	sext.w	a5,a5
    80006724:	00078213          	mv	tp,a5
    80006728:	30200073          	mret
    8000672c:	00813403          	ld	s0,8(sp)
    80006730:	01010113          	addi	sp,sp,16
    80006734:	00008067          	ret

0000000080006738 <timerinit>:
    80006738:	ff010113          	addi	sp,sp,-16
    8000673c:	00813423          	sd	s0,8(sp)
    80006740:	01010413          	addi	s0,sp,16
    80006744:	f14027f3          	csrr	a5,mhartid
    80006748:	0200c737          	lui	a4,0x200c
    8000674c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006750:	0007869b          	sext.w	a3,a5
    80006754:	00269713          	slli	a4,a3,0x2
    80006758:	000f4637          	lui	a2,0xf4
    8000675c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006760:	00d70733          	add	a4,a4,a3
    80006764:	0037979b          	slliw	a5,a5,0x3
    80006768:	020046b7          	lui	a3,0x2004
    8000676c:	00d787b3          	add	a5,a5,a3
    80006770:	00c585b3          	add	a1,a1,a2
    80006774:	00371693          	slli	a3,a4,0x3
    80006778:	00009717          	auipc	a4,0x9
    8000677c:	68870713          	addi	a4,a4,1672 # 8000fe00 <timer_scratch>
    80006780:	00b7b023          	sd	a1,0(a5)
    80006784:	00d70733          	add	a4,a4,a3
    80006788:	00f73c23          	sd	a5,24(a4)
    8000678c:	02c73023          	sd	a2,32(a4)
    80006790:	34071073          	csrw	mscratch,a4
    80006794:	00000797          	auipc	a5,0x0
    80006798:	64c78793          	addi	a5,a5,1612 # 80006de0 <timervec>
    8000679c:	30579073          	csrw	mtvec,a5
    800067a0:	300027f3          	csrr	a5,mstatus
    800067a4:	0087e793          	ori	a5,a5,8
    800067a8:	30079073          	csrw	mstatus,a5
    800067ac:	304027f3          	csrr	a5,mie
    800067b0:	0807e793          	ori	a5,a5,128
    800067b4:	30479073          	csrw	mie,a5
    800067b8:	00813403          	ld	s0,8(sp)
    800067bc:	01010113          	addi	sp,sp,16
    800067c0:	00008067          	ret

00000000800067c4 <system_main>:
    800067c4:	fe010113          	addi	sp,sp,-32
    800067c8:	00813823          	sd	s0,16(sp)
    800067cc:	00913423          	sd	s1,8(sp)
    800067d0:	00113c23          	sd	ra,24(sp)
    800067d4:	02010413          	addi	s0,sp,32
    800067d8:	00000097          	auipc	ra,0x0
    800067dc:	0c4080e7          	jalr	196(ra) # 8000689c <cpuid>
    800067e0:	00005497          	auipc	s1,0x5
    800067e4:	3a048493          	addi	s1,s1,928 # 8000bb80 <started>
    800067e8:	02050263          	beqz	a0,8000680c <system_main+0x48>
    800067ec:	0004a783          	lw	a5,0(s1)
    800067f0:	0007879b          	sext.w	a5,a5
    800067f4:	fe078ce3          	beqz	a5,800067ec <system_main+0x28>
    800067f8:	0ff0000f          	fence
    800067fc:	00003517          	auipc	a0,0x3
    80006800:	de450513          	addi	a0,a0,-540 # 800095e0 <CONSOLE_STATUS+0x5d0>
    80006804:	00001097          	auipc	ra,0x1
    80006808:	a78080e7          	jalr	-1416(ra) # 8000727c <panic>
    8000680c:	00001097          	auipc	ra,0x1
    80006810:	9cc080e7          	jalr	-1588(ra) # 800071d8 <consoleinit>
    80006814:	00001097          	auipc	ra,0x1
    80006818:	158080e7          	jalr	344(ra) # 8000796c <printfinit>
    8000681c:	00003517          	auipc	a0,0x3
    80006820:	98450513          	addi	a0,a0,-1660 # 800091a0 <CONSOLE_STATUS+0x190>
    80006824:	00001097          	auipc	ra,0x1
    80006828:	ab4080e7          	jalr	-1356(ra) # 800072d8 <__printf>
    8000682c:	00003517          	auipc	a0,0x3
    80006830:	d8450513          	addi	a0,a0,-636 # 800095b0 <CONSOLE_STATUS+0x5a0>
    80006834:	00001097          	auipc	ra,0x1
    80006838:	aa4080e7          	jalr	-1372(ra) # 800072d8 <__printf>
    8000683c:	00003517          	auipc	a0,0x3
    80006840:	96450513          	addi	a0,a0,-1692 # 800091a0 <CONSOLE_STATUS+0x190>
    80006844:	00001097          	auipc	ra,0x1
    80006848:	a94080e7          	jalr	-1388(ra) # 800072d8 <__printf>
    8000684c:	00001097          	auipc	ra,0x1
    80006850:	4ac080e7          	jalr	1196(ra) # 80007cf8 <kinit>
    80006854:	00000097          	auipc	ra,0x0
    80006858:	148080e7          	jalr	328(ra) # 8000699c <trapinit>
    8000685c:	00000097          	auipc	ra,0x0
    80006860:	16c080e7          	jalr	364(ra) # 800069c8 <trapinithart>
    80006864:	00000097          	auipc	ra,0x0
    80006868:	5bc080e7          	jalr	1468(ra) # 80006e20 <plicinit>
    8000686c:	00000097          	auipc	ra,0x0
    80006870:	5dc080e7          	jalr	1500(ra) # 80006e48 <plicinithart>
    80006874:	00000097          	auipc	ra,0x0
    80006878:	078080e7          	jalr	120(ra) # 800068ec <userinit>
    8000687c:	0ff0000f          	fence
    80006880:	00100793          	li	a5,1
    80006884:	00003517          	auipc	a0,0x3
    80006888:	d4450513          	addi	a0,a0,-700 # 800095c8 <CONSOLE_STATUS+0x5b8>
    8000688c:	00f4a023          	sw	a5,0(s1)
    80006890:	00001097          	auipc	ra,0x1
    80006894:	a48080e7          	jalr	-1464(ra) # 800072d8 <__printf>
    80006898:	0000006f          	j	80006898 <system_main+0xd4>

000000008000689c <cpuid>:
    8000689c:	ff010113          	addi	sp,sp,-16
    800068a0:	00813423          	sd	s0,8(sp)
    800068a4:	01010413          	addi	s0,sp,16
    800068a8:	00020513          	mv	a0,tp
    800068ac:	00813403          	ld	s0,8(sp)
    800068b0:	0005051b          	sext.w	a0,a0
    800068b4:	01010113          	addi	sp,sp,16
    800068b8:	00008067          	ret

00000000800068bc <mycpu>:
    800068bc:	ff010113          	addi	sp,sp,-16
    800068c0:	00813423          	sd	s0,8(sp)
    800068c4:	01010413          	addi	s0,sp,16
    800068c8:	00020793          	mv	a5,tp
    800068cc:	00813403          	ld	s0,8(sp)
    800068d0:	0007879b          	sext.w	a5,a5
    800068d4:	00779793          	slli	a5,a5,0x7
    800068d8:	0000a517          	auipc	a0,0xa
    800068dc:	55850513          	addi	a0,a0,1368 # 80010e30 <cpus>
    800068e0:	00f50533          	add	a0,a0,a5
    800068e4:	01010113          	addi	sp,sp,16
    800068e8:	00008067          	ret

00000000800068ec <userinit>:
    800068ec:	ff010113          	addi	sp,sp,-16
    800068f0:	00813423          	sd	s0,8(sp)
    800068f4:	01010413          	addi	s0,sp,16
    800068f8:	00813403          	ld	s0,8(sp)
    800068fc:	01010113          	addi	sp,sp,16
    80006900:	ffffc317          	auipc	t1,0xffffc
    80006904:	cb830067          	jr	-840(t1) # 800025b8 <main>

0000000080006908 <either_copyout>:
    80006908:	ff010113          	addi	sp,sp,-16
    8000690c:	00813023          	sd	s0,0(sp)
    80006910:	00113423          	sd	ra,8(sp)
    80006914:	01010413          	addi	s0,sp,16
    80006918:	02051663          	bnez	a0,80006944 <either_copyout+0x3c>
    8000691c:	00058513          	mv	a0,a1
    80006920:	00060593          	mv	a1,a2
    80006924:	0006861b          	sext.w	a2,a3
    80006928:	00002097          	auipc	ra,0x2
    8000692c:	c5c080e7          	jalr	-932(ra) # 80008584 <__memmove>
    80006930:	00813083          	ld	ra,8(sp)
    80006934:	00013403          	ld	s0,0(sp)
    80006938:	00000513          	li	a0,0
    8000693c:	01010113          	addi	sp,sp,16
    80006940:	00008067          	ret
    80006944:	00003517          	auipc	a0,0x3
    80006948:	cc450513          	addi	a0,a0,-828 # 80009608 <CONSOLE_STATUS+0x5f8>
    8000694c:	00001097          	auipc	ra,0x1
    80006950:	930080e7          	jalr	-1744(ra) # 8000727c <panic>

0000000080006954 <either_copyin>:
    80006954:	ff010113          	addi	sp,sp,-16
    80006958:	00813023          	sd	s0,0(sp)
    8000695c:	00113423          	sd	ra,8(sp)
    80006960:	01010413          	addi	s0,sp,16
    80006964:	02059463          	bnez	a1,8000698c <either_copyin+0x38>
    80006968:	00060593          	mv	a1,a2
    8000696c:	0006861b          	sext.w	a2,a3
    80006970:	00002097          	auipc	ra,0x2
    80006974:	c14080e7          	jalr	-1004(ra) # 80008584 <__memmove>
    80006978:	00813083          	ld	ra,8(sp)
    8000697c:	00013403          	ld	s0,0(sp)
    80006980:	00000513          	li	a0,0
    80006984:	01010113          	addi	sp,sp,16
    80006988:	00008067          	ret
    8000698c:	00003517          	auipc	a0,0x3
    80006990:	ca450513          	addi	a0,a0,-860 # 80009630 <CONSOLE_STATUS+0x620>
    80006994:	00001097          	auipc	ra,0x1
    80006998:	8e8080e7          	jalr	-1816(ra) # 8000727c <panic>

000000008000699c <trapinit>:
    8000699c:	ff010113          	addi	sp,sp,-16
    800069a0:	00813423          	sd	s0,8(sp)
    800069a4:	01010413          	addi	s0,sp,16
    800069a8:	00813403          	ld	s0,8(sp)
    800069ac:	00003597          	auipc	a1,0x3
    800069b0:	cac58593          	addi	a1,a1,-852 # 80009658 <CONSOLE_STATUS+0x648>
    800069b4:	0000a517          	auipc	a0,0xa
    800069b8:	4fc50513          	addi	a0,a0,1276 # 80010eb0 <tickslock>
    800069bc:	01010113          	addi	sp,sp,16
    800069c0:	00001317          	auipc	t1,0x1
    800069c4:	5c830067          	jr	1480(t1) # 80007f88 <initlock>

00000000800069c8 <trapinithart>:
    800069c8:	ff010113          	addi	sp,sp,-16
    800069cc:	00813423          	sd	s0,8(sp)
    800069d0:	01010413          	addi	s0,sp,16
    800069d4:	00000797          	auipc	a5,0x0
    800069d8:	2fc78793          	addi	a5,a5,764 # 80006cd0 <kernelvec>
    800069dc:	10579073          	csrw	stvec,a5
    800069e0:	00813403          	ld	s0,8(sp)
    800069e4:	01010113          	addi	sp,sp,16
    800069e8:	00008067          	ret

00000000800069ec <usertrap>:
    800069ec:	ff010113          	addi	sp,sp,-16
    800069f0:	00813423          	sd	s0,8(sp)
    800069f4:	01010413          	addi	s0,sp,16
    800069f8:	00813403          	ld	s0,8(sp)
    800069fc:	01010113          	addi	sp,sp,16
    80006a00:	00008067          	ret

0000000080006a04 <usertrapret>:
    80006a04:	ff010113          	addi	sp,sp,-16
    80006a08:	00813423          	sd	s0,8(sp)
    80006a0c:	01010413          	addi	s0,sp,16
    80006a10:	00813403          	ld	s0,8(sp)
    80006a14:	01010113          	addi	sp,sp,16
    80006a18:	00008067          	ret

0000000080006a1c <kerneltrap>:
    80006a1c:	fe010113          	addi	sp,sp,-32
    80006a20:	00813823          	sd	s0,16(sp)
    80006a24:	00113c23          	sd	ra,24(sp)
    80006a28:	00913423          	sd	s1,8(sp)
    80006a2c:	02010413          	addi	s0,sp,32
    80006a30:	142025f3          	csrr	a1,scause
    80006a34:	100027f3          	csrr	a5,sstatus
    80006a38:	0027f793          	andi	a5,a5,2
    80006a3c:	10079c63          	bnez	a5,80006b54 <kerneltrap+0x138>
    80006a40:	142027f3          	csrr	a5,scause
    80006a44:	0207ce63          	bltz	a5,80006a80 <kerneltrap+0x64>
    80006a48:	00003517          	auipc	a0,0x3
    80006a4c:	c5850513          	addi	a0,a0,-936 # 800096a0 <CONSOLE_STATUS+0x690>
    80006a50:	00001097          	auipc	ra,0x1
    80006a54:	888080e7          	jalr	-1912(ra) # 800072d8 <__printf>
    80006a58:	141025f3          	csrr	a1,sepc
    80006a5c:	14302673          	csrr	a2,stval
    80006a60:	00003517          	auipc	a0,0x3
    80006a64:	c5050513          	addi	a0,a0,-944 # 800096b0 <CONSOLE_STATUS+0x6a0>
    80006a68:	00001097          	auipc	ra,0x1
    80006a6c:	870080e7          	jalr	-1936(ra) # 800072d8 <__printf>
    80006a70:	00003517          	auipc	a0,0x3
    80006a74:	c5850513          	addi	a0,a0,-936 # 800096c8 <CONSOLE_STATUS+0x6b8>
    80006a78:	00001097          	auipc	ra,0x1
    80006a7c:	804080e7          	jalr	-2044(ra) # 8000727c <panic>
    80006a80:	0ff7f713          	andi	a4,a5,255
    80006a84:	00900693          	li	a3,9
    80006a88:	04d70063          	beq	a4,a3,80006ac8 <kerneltrap+0xac>
    80006a8c:	fff00713          	li	a4,-1
    80006a90:	03f71713          	slli	a4,a4,0x3f
    80006a94:	00170713          	addi	a4,a4,1
    80006a98:	fae798e3          	bne	a5,a4,80006a48 <kerneltrap+0x2c>
    80006a9c:	00000097          	auipc	ra,0x0
    80006aa0:	e00080e7          	jalr	-512(ra) # 8000689c <cpuid>
    80006aa4:	06050663          	beqz	a0,80006b10 <kerneltrap+0xf4>
    80006aa8:	144027f3          	csrr	a5,sip
    80006aac:	ffd7f793          	andi	a5,a5,-3
    80006ab0:	14479073          	csrw	sip,a5
    80006ab4:	01813083          	ld	ra,24(sp)
    80006ab8:	01013403          	ld	s0,16(sp)
    80006abc:	00813483          	ld	s1,8(sp)
    80006ac0:	02010113          	addi	sp,sp,32
    80006ac4:	00008067          	ret
    80006ac8:	00000097          	auipc	ra,0x0
    80006acc:	3cc080e7          	jalr	972(ra) # 80006e94 <plic_claim>
    80006ad0:	00a00793          	li	a5,10
    80006ad4:	00050493          	mv	s1,a0
    80006ad8:	06f50863          	beq	a0,a5,80006b48 <kerneltrap+0x12c>
    80006adc:	fc050ce3          	beqz	a0,80006ab4 <kerneltrap+0x98>
    80006ae0:	00050593          	mv	a1,a0
    80006ae4:	00003517          	auipc	a0,0x3
    80006ae8:	b9c50513          	addi	a0,a0,-1124 # 80009680 <CONSOLE_STATUS+0x670>
    80006aec:	00000097          	auipc	ra,0x0
    80006af0:	7ec080e7          	jalr	2028(ra) # 800072d8 <__printf>
    80006af4:	01013403          	ld	s0,16(sp)
    80006af8:	01813083          	ld	ra,24(sp)
    80006afc:	00048513          	mv	a0,s1
    80006b00:	00813483          	ld	s1,8(sp)
    80006b04:	02010113          	addi	sp,sp,32
    80006b08:	00000317          	auipc	t1,0x0
    80006b0c:	3c430067          	jr	964(t1) # 80006ecc <plic_complete>
    80006b10:	0000a517          	auipc	a0,0xa
    80006b14:	3a050513          	addi	a0,a0,928 # 80010eb0 <tickslock>
    80006b18:	00001097          	auipc	ra,0x1
    80006b1c:	494080e7          	jalr	1172(ra) # 80007fac <acquire>
    80006b20:	00005717          	auipc	a4,0x5
    80006b24:	06470713          	addi	a4,a4,100 # 8000bb84 <ticks>
    80006b28:	00072783          	lw	a5,0(a4)
    80006b2c:	0000a517          	auipc	a0,0xa
    80006b30:	38450513          	addi	a0,a0,900 # 80010eb0 <tickslock>
    80006b34:	0017879b          	addiw	a5,a5,1
    80006b38:	00f72023          	sw	a5,0(a4)
    80006b3c:	00001097          	auipc	ra,0x1
    80006b40:	53c080e7          	jalr	1340(ra) # 80008078 <release>
    80006b44:	f65ff06f          	j	80006aa8 <kerneltrap+0x8c>
    80006b48:	00001097          	auipc	ra,0x1
    80006b4c:	098080e7          	jalr	152(ra) # 80007be0 <uartintr>
    80006b50:	fa5ff06f          	j	80006af4 <kerneltrap+0xd8>
    80006b54:	00003517          	auipc	a0,0x3
    80006b58:	b0c50513          	addi	a0,a0,-1268 # 80009660 <CONSOLE_STATUS+0x650>
    80006b5c:	00000097          	auipc	ra,0x0
    80006b60:	720080e7          	jalr	1824(ra) # 8000727c <panic>

0000000080006b64 <clockintr>:
    80006b64:	fe010113          	addi	sp,sp,-32
    80006b68:	00813823          	sd	s0,16(sp)
    80006b6c:	00913423          	sd	s1,8(sp)
    80006b70:	00113c23          	sd	ra,24(sp)
    80006b74:	02010413          	addi	s0,sp,32
    80006b78:	0000a497          	auipc	s1,0xa
    80006b7c:	33848493          	addi	s1,s1,824 # 80010eb0 <tickslock>
    80006b80:	00048513          	mv	a0,s1
    80006b84:	00001097          	auipc	ra,0x1
    80006b88:	428080e7          	jalr	1064(ra) # 80007fac <acquire>
    80006b8c:	00005717          	auipc	a4,0x5
    80006b90:	ff870713          	addi	a4,a4,-8 # 8000bb84 <ticks>
    80006b94:	00072783          	lw	a5,0(a4)
    80006b98:	01013403          	ld	s0,16(sp)
    80006b9c:	01813083          	ld	ra,24(sp)
    80006ba0:	00048513          	mv	a0,s1
    80006ba4:	0017879b          	addiw	a5,a5,1
    80006ba8:	00813483          	ld	s1,8(sp)
    80006bac:	00f72023          	sw	a5,0(a4)
    80006bb0:	02010113          	addi	sp,sp,32
    80006bb4:	00001317          	auipc	t1,0x1
    80006bb8:	4c430067          	jr	1220(t1) # 80008078 <release>

0000000080006bbc <devintr>:
    80006bbc:	142027f3          	csrr	a5,scause
    80006bc0:	00000513          	li	a0,0
    80006bc4:	0007c463          	bltz	a5,80006bcc <devintr+0x10>
    80006bc8:	00008067          	ret
    80006bcc:	fe010113          	addi	sp,sp,-32
    80006bd0:	00813823          	sd	s0,16(sp)
    80006bd4:	00113c23          	sd	ra,24(sp)
    80006bd8:	00913423          	sd	s1,8(sp)
    80006bdc:	02010413          	addi	s0,sp,32
    80006be0:	0ff7f713          	andi	a4,a5,255
    80006be4:	00900693          	li	a3,9
    80006be8:	04d70c63          	beq	a4,a3,80006c40 <devintr+0x84>
    80006bec:	fff00713          	li	a4,-1
    80006bf0:	03f71713          	slli	a4,a4,0x3f
    80006bf4:	00170713          	addi	a4,a4,1
    80006bf8:	00e78c63          	beq	a5,a4,80006c10 <devintr+0x54>
    80006bfc:	01813083          	ld	ra,24(sp)
    80006c00:	01013403          	ld	s0,16(sp)
    80006c04:	00813483          	ld	s1,8(sp)
    80006c08:	02010113          	addi	sp,sp,32
    80006c0c:	00008067          	ret
    80006c10:	00000097          	auipc	ra,0x0
    80006c14:	c8c080e7          	jalr	-884(ra) # 8000689c <cpuid>
    80006c18:	06050663          	beqz	a0,80006c84 <devintr+0xc8>
    80006c1c:	144027f3          	csrr	a5,sip
    80006c20:	ffd7f793          	andi	a5,a5,-3
    80006c24:	14479073          	csrw	sip,a5
    80006c28:	01813083          	ld	ra,24(sp)
    80006c2c:	01013403          	ld	s0,16(sp)
    80006c30:	00813483          	ld	s1,8(sp)
    80006c34:	00200513          	li	a0,2
    80006c38:	02010113          	addi	sp,sp,32
    80006c3c:	00008067          	ret
    80006c40:	00000097          	auipc	ra,0x0
    80006c44:	254080e7          	jalr	596(ra) # 80006e94 <plic_claim>
    80006c48:	00a00793          	li	a5,10
    80006c4c:	00050493          	mv	s1,a0
    80006c50:	06f50663          	beq	a0,a5,80006cbc <devintr+0x100>
    80006c54:	00100513          	li	a0,1
    80006c58:	fa0482e3          	beqz	s1,80006bfc <devintr+0x40>
    80006c5c:	00048593          	mv	a1,s1
    80006c60:	00003517          	auipc	a0,0x3
    80006c64:	a2050513          	addi	a0,a0,-1504 # 80009680 <CONSOLE_STATUS+0x670>
    80006c68:	00000097          	auipc	ra,0x0
    80006c6c:	670080e7          	jalr	1648(ra) # 800072d8 <__printf>
    80006c70:	00048513          	mv	a0,s1
    80006c74:	00000097          	auipc	ra,0x0
    80006c78:	258080e7          	jalr	600(ra) # 80006ecc <plic_complete>
    80006c7c:	00100513          	li	a0,1
    80006c80:	f7dff06f          	j	80006bfc <devintr+0x40>
    80006c84:	0000a517          	auipc	a0,0xa
    80006c88:	22c50513          	addi	a0,a0,556 # 80010eb0 <tickslock>
    80006c8c:	00001097          	auipc	ra,0x1
    80006c90:	320080e7          	jalr	800(ra) # 80007fac <acquire>
    80006c94:	00005717          	auipc	a4,0x5
    80006c98:	ef070713          	addi	a4,a4,-272 # 8000bb84 <ticks>
    80006c9c:	00072783          	lw	a5,0(a4)
    80006ca0:	0000a517          	auipc	a0,0xa
    80006ca4:	21050513          	addi	a0,a0,528 # 80010eb0 <tickslock>
    80006ca8:	0017879b          	addiw	a5,a5,1
    80006cac:	00f72023          	sw	a5,0(a4)
    80006cb0:	00001097          	auipc	ra,0x1
    80006cb4:	3c8080e7          	jalr	968(ra) # 80008078 <release>
    80006cb8:	f65ff06f          	j	80006c1c <devintr+0x60>
    80006cbc:	00001097          	auipc	ra,0x1
    80006cc0:	f24080e7          	jalr	-220(ra) # 80007be0 <uartintr>
    80006cc4:	fadff06f          	j	80006c70 <devintr+0xb4>
	...

0000000080006cd0 <kernelvec>:
    80006cd0:	f0010113          	addi	sp,sp,-256
    80006cd4:	00113023          	sd	ra,0(sp)
    80006cd8:	00213423          	sd	sp,8(sp)
    80006cdc:	00313823          	sd	gp,16(sp)
    80006ce0:	00413c23          	sd	tp,24(sp)
    80006ce4:	02513023          	sd	t0,32(sp)
    80006ce8:	02613423          	sd	t1,40(sp)
    80006cec:	02713823          	sd	t2,48(sp)
    80006cf0:	02813c23          	sd	s0,56(sp)
    80006cf4:	04913023          	sd	s1,64(sp)
    80006cf8:	04a13423          	sd	a0,72(sp)
    80006cfc:	04b13823          	sd	a1,80(sp)
    80006d00:	04c13c23          	sd	a2,88(sp)
    80006d04:	06d13023          	sd	a3,96(sp)
    80006d08:	06e13423          	sd	a4,104(sp)
    80006d0c:	06f13823          	sd	a5,112(sp)
    80006d10:	07013c23          	sd	a6,120(sp)
    80006d14:	09113023          	sd	a7,128(sp)
    80006d18:	09213423          	sd	s2,136(sp)
    80006d1c:	09313823          	sd	s3,144(sp)
    80006d20:	09413c23          	sd	s4,152(sp)
    80006d24:	0b513023          	sd	s5,160(sp)
    80006d28:	0b613423          	sd	s6,168(sp)
    80006d2c:	0b713823          	sd	s7,176(sp)
    80006d30:	0b813c23          	sd	s8,184(sp)
    80006d34:	0d913023          	sd	s9,192(sp)
    80006d38:	0da13423          	sd	s10,200(sp)
    80006d3c:	0db13823          	sd	s11,208(sp)
    80006d40:	0dc13c23          	sd	t3,216(sp)
    80006d44:	0fd13023          	sd	t4,224(sp)
    80006d48:	0fe13423          	sd	t5,232(sp)
    80006d4c:	0ff13823          	sd	t6,240(sp)
    80006d50:	ccdff0ef          	jal	ra,80006a1c <kerneltrap>
    80006d54:	00013083          	ld	ra,0(sp)
    80006d58:	00813103          	ld	sp,8(sp)
    80006d5c:	01013183          	ld	gp,16(sp)
    80006d60:	02013283          	ld	t0,32(sp)
    80006d64:	02813303          	ld	t1,40(sp)
    80006d68:	03013383          	ld	t2,48(sp)
    80006d6c:	03813403          	ld	s0,56(sp)
    80006d70:	04013483          	ld	s1,64(sp)
    80006d74:	04813503          	ld	a0,72(sp)
    80006d78:	05013583          	ld	a1,80(sp)
    80006d7c:	05813603          	ld	a2,88(sp)
    80006d80:	06013683          	ld	a3,96(sp)
    80006d84:	06813703          	ld	a4,104(sp)
    80006d88:	07013783          	ld	a5,112(sp)
    80006d8c:	07813803          	ld	a6,120(sp)
    80006d90:	08013883          	ld	a7,128(sp)
    80006d94:	08813903          	ld	s2,136(sp)
    80006d98:	09013983          	ld	s3,144(sp)
    80006d9c:	09813a03          	ld	s4,152(sp)
    80006da0:	0a013a83          	ld	s5,160(sp)
    80006da4:	0a813b03          	ld	s6,168(sp)
    80006da8:	0b013b83          	ld	s7,176(sp)
    80006dac:	0b813c03          	ld	s8,184(sp)
    80006db0:	0c013c83          	ld	s9,192(sp)
    80006db4:	0c813d03          	ld	s10,200(sp)
    80006db8:	0d013d83          	ld	s11,208(sp)
    80006dbc:	0d813e03          	ld	t3,216(sp)
    80006dc0:	0e013e83          	ld	t4,224(sp)
    80006dc4:	0e813f03          	ld	t5,232(sp)
    80006dc8:	0f013f83          	ld	t6,240(sp)
    80006dcc:	10010113          	addi	sp,sp,256
    80006dd0:	10200073          	sret
    80006dd4:	00000013          	nop
    80006dd8:	00000013          	nop
    80006ddc:	00000013          	nop

0000000080006de0 <timervec>:
    80006de0:	34051573          	csrrw	a0,mscratch,a0
    80006de4:	00b53023          	sd	a1,0(a0)
    80006de8:	00c53423          	sd	a2,8(a0)
    80006dec:	00d53823          	sd	a3,16(a0)
    80006df0:	01853583          	ld	a1,24(a0)
    80006df4:	02053603          	ld	a2,32(a0)
    80006df8:	0005b683          	ld	a3,0(a1)
    80006dfc:	00c686b3          	add	a3,a3,a2
    80006e00:	00d5b023          	sd	a3,0(a1)
    80006e04:	00200593          	li	a1,2
    80006e08:	14459073          	csrw	sip,a1
    80006e0c:	01053683          	ld	a3,16(a0)
    80006e10:	00853603          	ld	a2,8(a0)
    80006e14:	00053583          	ld	a1,0(a0)
    80006e18:	34051573          	csrrw	a0,mscratch,a0
    80006e1c:	30200073          	mret

0000000080006e20 <plicinit>:
    80006e20:	ff010113          	addi	sp,sp,-16
    80006e24:	00813423          	sd	s0,8(sp)
    80006e28:	01010413          	addi	s0,sp,16
    80006e2c:	00813403          	ld	s0,8(sp)
    80006e30:	0c0007b7          	lui	a5,0xc000
    80006e34:	00100713          	li	a4,1
    80006e38:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80006e3c:	00e7a223          	sw	a4,4(a5)
    80006e40:	01010113          	addi	sp,sp,16
    80006e44:	00008067          	ret

0000000080006e48 <plicinithart>:
    80006e48:	ff010113          	addi	sp,sp,-16
    80006e4c:	00813023          	sd	s0,0(sp)
    80006e50:	00113423          	sd	ra,8(sp)
    80006e54:	01010413          	addi	s0,sp,16
    80006e58:	00000097          	auipc	ra,0x0
    80006e5c:	a44080e7          	jalr	-1468(ra) # 8000689c <cpuid>
    80006e60:	0085171b          	slliw	a4,a0,0x8
    80006e64:	0c0027b7          	lui	a5,0xc002
    80006e68:	00e787b3          	add	a5,a5,a4
    80006e6c:	40200713          	li	a4,1026
    80006e70:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006e74:	00813083          	ld	ra,8(sp)
    80006e78:	00013403          	ld	s0,0(sp)
    80006e7c:	00d5151b          	slliw	a0,a0,0xd
    80006e80:	0c2017b7          	lui	a5,0xc201
    80006e84:	00a78533          	add	a0,a5,a0
    80006e88:	00052023          	sw	zero,0(a0)
    80006e8c:	01010113          	addi	sp,sp,16
    80006e90:	00008067          	ret

0000000080006e94 <plic_claim>:
    80006e94:	ff010113          	addi	sp,sp,-16
    80006e98:	00813023          	sd	s0,0(sp)
    80006e9c:	00113423          	sd	ra,8(sp)
    80006ea0:	01010413          	addi	s0,sp,16
    80006ea4:	00000097          	auipc	ra,0x0
    80006ea8:	9f8080e7          	jalr	-1544(ra) # 8000689c <cpuid>
    80006eac:	00813083          	ld	ra,8(sp)
    80006eb0:	00013403          	ld	s0,0(sp)
    80006eb4:	00d5151b          	slliw	a0,a0,0xd
    80006eb8:	0c2017b7          	lui	a5,0xc201
    80006ebc:	00a78533          	add	a0,a5,a0
    80006ec0:	00452503          	lw	a0,4(a0)
    80006ec4:	01010113          	addi	sp,sp,16
    80006ec8:	00008067          	ret

0000000080006ecc <plic_complete>:
    80006ecc:	fe010113          	addi	sp,sp,-32
    80006ed0:	00813823          	sd	s0,16(sp)
    80006ed4:	00913423          	sd	s1,8(sp)
    80006ed8:	00113c23          	sd	ra,24(sp)
    80006edc:	02010413          	addi	s0,sp,32
    80006ee0:	00050493          	mv	s1,a0
    80006ee4:	00000097          	auipc	ra,0x0
    80006ee8:	9b8080e7          	jalr	-1608(ra) # 8000689c <cpuid>
    80006eec:	01813083          	ld	ra,24(sp)
    80006ef0:	01013403          	ld	s0,16(sp)
    80006ef4:	00d5179b          	slliw	a5,a0,0xd
    80006ef8:	0c201737          	lui	a4,0xc201
    80006efc:	00f707b3          	add	a5,a4,a5
    80006f00:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006f04:	00813483          	ld	s1,8(sp)
    80006f08:	02010113          	addi	sp,sp,32
    80006f0c:	00008067          	ret

0000000080006f10 <consolewrite>:
    80006f10:	fb010113          	addi	sp,sp,-80
    80006f14:	04813023          	sd	s0,64(sp)
    80006f18:	04113423          	sd	ra,72(sp)
    80006f1c:	02913c23          	sd	s1,56(sp)
    80006f20:	03213823          	sd	s2,48(sp)
    80006f24:	03313423          	sd	s3,40(sp)
    80006f28:	03413023          	sd	s4,32(sp)
    80006f2c:	01513c23          	sd	s5,24(sp)
    80006f30:	05010413          	addi	s0,sp,80
    80006f34:	06c05c63          	blez	a2,80006fac <consolewrite+0x9c>
    80006f38:	00060993          	mv	s3,a2
    80006f3c:	00050a13          	mv	s4,a0
    80006f40:	00058493          	mv	s1,a1
    80006f44:	00000913          	li	s2,0
    80006f48:	fff00a93          	li	s5,-1
    80006f4c:	01c0006f          	j	80006f68 <consolewrite+0x58>
    80006f50:	fbf44503          	lbu	a0,-65(s0)
    80006f54:	0019091b          	addiw	s2,s2,1
    80006f58:	00148493          	addi	s1,s1,1
    80006f5c:	00001097          	auipc	ra,0x1
    80006f60:	a9c080e7          	jalr	-1380(ra) # 800079f8 <uartputc>
    80006f64:	03298063          	beq	s3,s2,80006f84 <consolewrite+0x74>
    80006f68:	00048613          	mv	a2,s1
    80006f6c:	00100693          	li	a3,1
    80006f70:	000a0593          	mv	a1,s4
    80006f74:	fbf40513          	addi	a0,s0,-65
    80006f78:	00000097          	auipc	ra,0x0
    80006f7c:	9dc080e7          	jalr	-1572(ra) # 80006954 <either_copyin>
    80006f80:	fd5518e3          	bne	a0,s5,80006f50 <consolewrite+0x40>
    80006f84:	04813083          	ld	ra,72(sp)
    80006f88:	04013403          	ld	s0,64(sp)
    80006f8c:	03813483          	ld	s1,56(sp)
    80006f90:	02813983          	ld	s3,40(sp)
    80006f94:	02013a03          	ld	s4,32(sp)
    80006f98:	01813a83          	ld	s5,24(sp)
    80006f9c:	00090513          	mv	a0,s2
    80006fa0:	03013903          	ld	s2,48(sp)
    80006fa4:	05010113          	addi	sp,sp,80
    80006fa8:	00008067          	ret
    80006fac:	00000913          	li	s2,0
    80006fb0:	fd5ff06f          	j	80006f84 <consolewrite+0x74>

0000000080006fb4 <consoleread>:
    80006fb4:	f9010113          	addi	sp,sp,-112
    80006fb8:	06813023          	sd	s0,96(sp)
    80006fbc:	04913c23          	sd	s1,88(sp)
    80006fc0:	05213823          	sd	s2,80(sp)
    80006fc4:	05313423          	sd	s3,72(sp)
    80006fc8:	05413023          	sd	s4,64(sp)
    80006fcc:	03513c23          	sd	s5,56(sp)
    80006fd0:	03613823          	sd	s6,48(sp)
    80006fd4:	03713423          	sd	s7,40(sp)
    80006fd8:	03813023          	sd	s8,32(sp)
    80006fdc:	06113423          	sd	ra,104(sp)
    80006fe0:	01913c23          	sd	s9,24(sp)
    80006fe4:	07010413          	addi	s0,sp,112
    80006fe8:	00060b93          	mv	s7,a2
    80006fec:	00050913          	mv	s2,a0
    80006ff0:	00058c13          	mv	s8,a1
    80006ff4:	00060b1b          	sext.w	s6,a2
    80006ff8:	0000a497          	auipc	s1,0xa
    80006ffc:	ee048493          	addi	s1,s1,-288 # 80010ed8 <cons>
    80007000:	00400993          	li	s3,4
    80007004:	fff00a13          	li	s4,-1
    80007008:	00a00a93          	li	s5,10
    8000700c:	05705e63          	blez	s7,80007068 <consoleread+0xb4>
    80007010:	09c4a703          	lw	a4,156(s1)
    80007014:	0984a783          	lw	a5,152(s1)
    80007018:	0007071b          	sext.w	a4,a4
    8000701c:	08e78463          	beq	a5,a4,800070a4 <consoleread+0xf0>
    80007020:	07f7f713          	andi	a4,a5,127
    80007024:	00e48733          	add	a4,s1,a4
    80007028:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000702c:	0017869b          	addiw	a3,a5,1
    80007030:	08d4ac23          	sw	a3,152(s1)
    80007034:	00070c9b          	sext.w	s9,a4
    80007038:	0b370663          	beq	a4,s3,800070e4 <consoleread+0x130>
    8000703c:	00100693          	li	a3,1
    80007040:	f9f40613          	addi	a2,s0,-97
    80007044:	000c0593          	mv	a1,s8
    80007048:	00090513          	mv	a0,s2
    8000704c:	f8e40fa3          	sb	a4,-97(s0)
    80007050:	00000097          	auipc	ra,0x0
    80007054:	8b8080e7          	jalr	-1864(ra) # 80006908 <either_copyout>
    80007058:	01450863          	beq	a0,s4,80007068 <consoleread+0xb4>
    8000705c:	001c0c13          	addi	s8,s8,1
    80007060:	fffb8b9b          	addiw	s7,s7,-1
    80007064:	fb5c94e3          	bne	s9,s5,8000700c <consoleread+0x58>
    80007068:	000b851b          	sext.w	a0,s7
    8000706c:	06813083          	ld	ra,104(sp)
    80007070:	06013403          	ld	s0,96(sp)
    80007074:	05813483          	ld	s1,88(sp)
    80007078:	05013903          	ld	s2,80(sp)
    8000707c:	04813983          	ld	s3,72(sp)
    80007080:	04013a03          	ld	s4,64(sp)
    80007084:	03813a83          	ld	s5,56(sp)
    80007088:	02813b83          	ld	s7,40(sp)
    8000708c:	02013c03          	ld	s8,32(sp)
    80007090:	01813c83          	ld	s9,24(sp)
    80007094:	40ab053b          	subw	a0,s6,a0
    80007098:	03013b03          	ld	s6,48(sp)
    8000709c:	07010113          	addi	sp,sp,112
    800070a0:	00008067          	ret
    800070a4:	00001097          	auipc	ra,0x1
    800070a8:	1d8080e7          	jalr	472(ra) # 8000827c <push_on>
    800070ac:	0984a703          	lw	a4,152(s1)
    800070b0:	09c4a783          	lw	a5,156(s1)
    800070b4:	0007879b          	sext.w	a5,a5
    800070b8:	fef70ce3          	beq	a4,a5,800070b0 <consoleread+0xfc>
    800070bc:	00001097          	auipc	ra,0x1
    800070c0:	234080e7          	jalr	564(ra) # 800082f0 <pop_on>
    800070c4:	0984a783          	lw	a5,152(s1)
    800070c8:	07f7f713          	andi	a4,a5,127
    800070cc:	00e48733          	add	a4,s1,a4
    800070d0:	01874703          	lbu	a4,24(a4)
    800070d4:	0017869b          	addiw	a3,a5,1
    800070d8:	08d4ac23          	sw	a3,152(s1)
    800070dc:	00070c9b          	sext.w	s9,a4
    800070e0:	f5371ee3          	bne	a4,s3,8000703c <consoleread+0x88>
    800070e4:	000b851b          	sext.w	a0,s7
    800070e8:	f96bf2e3          	bgeu	s7,s6,8000706c <consoleread+0xb8>
    800070ec:	08f4ac23          	sw	a5,152(s1)
    800070f0:	f7dff06f          	j	8000706c <consoleread+0xb8>

00000000800070f4 <consputc>:
    800070f4:	10000793          	li	a5,256
    800070f8:	00f50663          	beq	a0,a5,80007104 <consputc+0x10>
    800070fc:	00001317          	auipc	t1,0x1
    80007100:	9f430067          	jr	-1548(t1) # 80007af0 <uartputc_sync>
    80007104:	ff010113          	addi	sp,sp,-16
    80007108:	00113423          	sd	ra,8(sp)
    8000710c:	00813023          	sd	s0,0(sp)
    80007110:	01010413          	addi	s0,sp,16
    80007114:	00800513          	li	a0,8
    80007118:	00001097          	auipc	ra,0x1
    8000711c:	9d8080e7          	jalr	-1576(ra) # 80007af0 <uartputc_sync>
    80007120:	02000513          	li	a0,32
    80007124:	00001097          	auipc	ra,0x1
    80007128:	9cc080e7          	jalr	-1588(ra) # 80007af0 <uartputc_sync>
    8000712c:	00013403          	ld	s0,0(sp)
    80007130:	00813083          	ld	ra,8(sp)
    80007134:	00800513          	li	a0,8
    80007138:	01010113          	addi	sp,sp,16
    8000713c:	00001317          	auipc	t1,0x1
    80007140:	9b430067          	jr	-1612(t1) # 80007af0 <uartputc_sync>

0000000080007144 <consoleintr>:
    80007144:	fe010113          	addi	sp,sp,-32
    80007148:	00813823          	sd	s0,16(sp)
    8000714c:	00913423          	sd	s1,8(sp)
    80007150:	01213023          	sd	s2,0(sp)
    80007154:	00113c23          	sd	ra,24(sp)
    80007158:	02010413          	addi	s0,sp,32
    8000715c:	0000a917          	auipc	s2,0xa
    80007160:	d7c90913          	addi	s2,s2,-644 # 80010ed8 <cons>
    80007164:	00050493          	mv	s1,a0
    80007168:	00090513          	mv	a0,s2
    8000716c:	00001097          	auipc	ra,0x1
    80007170:	e40080e7          	jalr	-448(ra) # 80007fac <acquire>
    80007174:	02048c63          	beqz	s1,800071ac <consoleintr+0x68>
    80007178:	0a092783          	lw	a5,160(s2)
    8000717c:	09892703          	lw	a4,152(s2)
    80007180:	07f00693          	li	a3,127
    80007184:	40e7873b          	subw	a4,a5,a4
    80007188:	02e6e263          	bltu	a3,a4,800071ac <consoleintr+0x68>
    8000718c:	00d00713          	li	a4,13
    80007190:	04e48063          	beq	s1,a4,800071d0 <consoleintr+0x8c>
    80007194:	07f7f713          	andi	a4,a5,127
    80007198:	00e90733          	add	a4,s2,a4
    8000719c:	0017879b          	addiw	a5,a5,1
    800071a0:	0af92023          	sw	a5,160(s2)
    800071a4:	00970c23          	sb	s1,24(a4)
    800071a8:	08f92e23          	sw	a5,156(s2)
    800071ac:	01013403          	ld	s0,16(sp)
    800071b0:	01813083          	ld	ra,24(sp)
    800071b4:	00813483          	ld	s1,8(sp)
    800071b8:	00013903          	ld	s2,0(sp)
    800071bc:	0000a517          	auipc	a0,0xa
    800071c0:	d1c50513          	addi	a0,a0,-740 # 80010ed8 <cons>
    800071c4:	02010113          	addi	sp,sp,32
    800071c8:	00001317          	auipc	t1,0x1
    800071cc:	eb030067          	jr	-336(t1) # 80008078 <release>
    800071d0:	00a00493          	li	s1,10
    800071d4:	fc1ff06f          	j	80007194 <consoleintr+0x50>

00000000800071d8 <consoleinit>:
    800071d8:	fe010113          	addi	sp,sp,-32
    800071dc:	00113c23          	sd	ra,24(sp)
    800071e0:	00813823          	sd	s0,16(sp)
    800071e4:	00913423          	sd	s1,8(sp)
    800071e8:	02010413          	addi	s0,sp,32
    800071ec:	0000a497          	auipc	s1,0xa
    800071f0:	cec48493          	addi	s1,s1,-788 # 80010ed8 <cons>
    800071f4:	00048513          	mv	a0,s1
    800071f8:	00002597          	auipc	a1,0x2
    800071fc:	4e058593          	addi	a1,a1,1248 # 800096d8 <CONSOLE_STATUS+0x6c8>
    80007200:	00001097          	auipc	ra,0x1
    80007204:	d88080e7          	jalr	-632(ra) # 80007f88 <initlock>
    80007208:	00000097          	auipc	ra,0x0
    8000720c:	7ac080e7          	jalr	1964(ra) # 800079b4 <uartinit>
    80007210:	01813083          	ld	ra,24(sp)
    80007214:	01013403          	ld	s0,16(sp)
    80007218:	00000797          	auipc	a5,0x0
    8000721c:	d9c78793          	addi	a5,a5,-612 # 80006fb4 <consoleread>
    80007220:	0af4bc23          	sd	a5,184(s1)
    80007224:	00000797          	auipc	a5,0x0
    80007228:	cec78793          	addi	a5,a5,-788 # 80006f10 <consolewrite>
    8000722c:	0cf4b023          	sd	a5,192(s1)
    80007230:	00813483          	ld	s1,8(sp)
    80007234:	02010113          	addi	sp,sp,32
    80007238:	00008067          	ret

000000008000723c <console_read>:
    8000723c:	ff010113          	addi	sp,sp,-16
    80007240:	00813423          	sd	s0,8(sp)
    80007244:	01010413          	addi	s0,sp,16
    80007248:	00813403          	ld	s0,8(sp)
    8000724c:	0000a317          	auipc	t1,0xa
    80007250:	d4433303          	ld	t1,-700(t1) # 80010f90 <devsw+0x10>
    80007254:	01010113          	addi	sp,sp,16
    80007258:	00030067          	jr	t1

000000008000725c <console_write>:
    8000725c:	ff010113          	addi	sp,sp,-16
    80007260:	00813423          	sd	s0,8(sp)
    80007264:	01010413          	addi	s0,sp,16
    80007268:	00813403          	ld	s0,8(sp)
    8000726c:	0000a317          	auipc	t1,0xa
    80007270:	d2c33303          	ld	t1,-724(t1) # 80010f98 <devsw+0x18>
    80007274:	01010113          	addi	sp,sp,16
    80007278:	00030067          	jr	t1

000000008000727c <panic>:
    8000727c:	fe010113          	addi	sp,sp,-32
    80007280:	00113c23          	sd	ra,24(sp)
    80007284:	00813823          	sd	s0,16(sp)
    80007288:	00913423          	sd	s1,8(sp)
    8000728c:	02010413          	addi	s0,sp,32
    80007290:	00050493          	mv	s1,a0
    80007294:	00002517          	auipc	a0,0x2
    80007298:	44c50513          	addi	a0,a0,1100 # 800096e0 <CONSOLE_STATUS+0x6d0>
    8000729c:	0000a797          	auipc	a5,0xa
    800072a0:	d807ae23          	sw	zero,-612(a5) # 80011038 <pr+0x18>
    800072a4:	00000097          	auipc	ra,0x0
    800072a8:	034080e7          	jalr	52(ra) # 800072d8 <__printf>
    800072ac:	00048513          	mv	a0,s1
    800072b0:	00000097          	auipc	ra,0x0
    800072b4:	028080e7          	jalr	40(ra) # 800072d8 <__printf>
    800072b8:	00002517          	auipc	a0,0x2
    800072bc:	ee850513          	addi	a0,a0,-280 # 800091a0 <CONSOLE_STATUS+0x190>
    800072c0:	00000097          	auipc	ra,0x0
    800072c4:	018080e7          	jalr	24(ra) # 800072d8 <__printf>
    800072c8:	00100793          	li	a5,1
    800072cc:	00005717          	auipc	a4,0x5
    800072d0:	8af72e23          	sw	a5,-1860(a4) # 8000bb88 <panicked>
    800072d4:	0000006f          	j	800072d4 <panic+0x58>

00000000800072d8 <__printf>:
    800072d8:	f3010113          	addi	sp,sp,-208
    800072dc:	08813023          	sd	s0,128(sp)
    800072e0:	07313423          	sd	s3,104(sp)
    800072e4:	09010413          	addi	s0,sp,144
    800072e8:	05813023          	sd	s8,64(sp)
    800072ec:	08113423          	sd	ra,136(sp)
    800072f0:	06913c23          	sd	s1,120(sp)
    800072f4:	07213823          	sd	s2,112(sp)
    800072f8:	07413023          	sd	s4,96(sp)
    800072fc:	05513c23          	sd	s5,88(sp)
    80007300:	05613823          	sd	s6,80(sp)
    80007304:	05713423          	sd	s7,72(sp)
    80007308:	03913c23          	sd	s9,56(sp)
    8000730c:	03a13823          	sd	s10,48(sp)
    80007310:	03b13423          	sd	s11,40(sp)
    80007314:	0000a317          	auipc	t1,0xa
    80007318:	d0c30313          	addi	t1,t1,-756 # 80011020 <pr>
    8000731c:	01832c03          	lw	s8,24(t1)
    80007320:	00b43423          	sd	a1,8(s0)
    80007324:	00c43823          	sd	a2,16(s0)
    80007328:	00d43c23          	sd	a3,24(s0)
    8000732c:	02e43023          	sd	a4,32(s0)
    80007330:	02f43423          	sd	a5,40(s0)
    80007334:	03043823          	sd	a6,48(s0)
    80007338:	03143c23          	sd	a7,56(s0)
    8000733c:	00050993          	mv	s3,a0
    80007340:	4a0c1663          	bnez	s8,800077ec <__printf+0x514>
    80007344:	60098c63          	beqz	s3,8000795c <__printf+0x684>
    80007348:	0009c503          	lbu	a0,0(s3)
    8000734c:	00840793          	addi	a5,s0,8
    80007350:	f6f43c23          	sd	a5,-136(s0)
    80007354:	00000493          	li	s1,0
    80007358:	22050063          	beqz	a0,80007578 <__printf+0x2a0>
    8000735c:	00002a37          	lui	s4,0x2
    80007360:	00018ab7          	lui	s5,0x18
    80007364:	000f4b37          	lui	s6,0xf4
    80007368:	00989bb7          	lui	s7,0x989
    8000736c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007370:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007374:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007378:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000737c:	00148c9b          	addiw	s9,s1,1
    80007380:	02500793          	li	a5,37
    80007384:	01998933          	add	s2,s3,s9
    80007388:	38f51263          	bne	a0,a5,8000770c <__printf+0x434>
    8000738c:	00094783          	lbu	a5,0(s2)
    80007390:	00078c9b          	sext.w	s9,a5
    80007394:	1e078263          	beqz	a5,80007578 <__printf+0x2a0>
    80007398:	0024849b          	addiw	s1,s1,2
    8000739c:	07000713          	li	a4,112
    800073a0:	00998933          	add	s2,s3,s1
    800073a4:	38e78a63          	beq	a5,a4,80007738 <__printf+0x460>
    800073a8:	20f76863          	bltu	a4,a5,800075b8 <__printf+0x2e0>
    800073ac:	42a78863          	beq	a5,a0,800077dc <__printf+0x504>
    800073b0:	06400713          	li	a4,100
    800073b4:	40e79663          	bne	a5,a4,800077c0 <__printf+0x4e8>
    800073b8:	f7843783          	ld	a5,-136(s0)
    800073bc:	0007a603          	lw	a2,0(a5)
    800073c0:	00878793          	addi	a5,a5,8
    800073c4:	f6f43c23          	sd	a5,-136(s0)
    800073c8:	42064a63          	bltz	a2,800077fc <__printf+0x524>
    800073cc:	00a00713          	li	a4,10
    800073d0:	02e677bb          	remuw	a5,a2,a4
    800073d4:	00002d97          	auipc	s11,0x2
    800073d8:	334d8d93          	addi	s11,s11,820 # 80009708 <digits>
    800073dc:	00900593          	li	a1,9
    800073e0:	0006051b          	sext.w	a0,a2
    800073e4:	00000c93          	li	s9,0
    800073e8:	02079793          	slli	a5,a5,0x20
    800073ec:	0207d793          	srli	a5,a5,0x20
    800073f0:	00fd87b3          	add	a5,s11,a5
    800073f4:	0007c783          	lbu	a5,0(a5)
    800073f8:	02e656bb          	divuw	a3,a2,a4
    800073fc:	f8f40023          	sb	a5,-128(s0)
    80007400:	14c5d863          	bge	a1,a2,80007550 <__printf+0x278>
    80007404:	06300593          	li	a1,99
    80007408:	00100c93          	li	s9,1
    8000740c:	02e6f7bb          	remuw	a5,a3,a4
    80007410:	02079793          	slli	a5,a5,0x20
    80007414:	0207d793          	srli	a5,a5,0x20
    80007418:	00fd87b3          	add	a5,s11,a5
    8000741c:	0007c783          	lbu	a5,0(a5)
    80007420:	02e6d73b          	divuw	a4,a3,a4
    80007424:	f8f400a3          	sb	a5,-127(s0)
    80007428:	12a5f463          	bgeu	a1,a0,80007550 <__printf+0x278>
    8000742c:	00a00693          	li	a3,10
    80007430:	00900593          	li	a1,9
    80007434:	02d777bb          	remuw	a5,a4,a3
    80007438:	02079793          	slli	a5,a5,0x20
    8000743c:	0207d793          	srli	a5,a5,0x20
    80007440:	00fd87b3          	add	a5,s11,a5
    80007444:	0007c503          	lbu	a0,0(a5)
    80007448:	02d757bb          	divuw	a5,a4,a3
    8000744c:	f8a40123          	sb	a0,-126(s0)
    80007450:	48e5f263          	bgeu	a1,a4,800078d4 <__printf+0x5fc>
    80007454:	06300513          	li	a0,99
    80007458:	02d7f5bb          	remuw	a1,a5,a3
    8000745c:	02059593          	slli	a1,a1,0x20
    80007460:	0205d593          	srli	a1,a1,0x20
    80007464:	00bd85b3          	add	a1,s11,a1
    80007468:	0005c583          	lbu	a1,0(a1)
    8000746c:	02d7d7bb          	divuw	a5,a5,a3
    80007470:	f8b401a3          	sb	a1,-125(s0)
    80007474:	48e57263          	bgeu	a0,a4,800078f8 <__printf+0x620>
    80007478:	3e700513          	li	a0,999
    8000747c:	02d7f5bb          	remuw	a1,a5,a3
    80007480:	02059593          	slli	a1,a1,0x20
    80007484:	0205d593          	srli	a1,a1,0x20
    80007488:	00bd85b3          	add	a1,s11,a1
    8000748c:	0005c583          	lbu	a1,0(a1)
    80007490:	02d7d7bb          	divuw	a5,a5,a3
    80007494:	f8b40223          	sb	a1,-124(s0)
    80007498:	46e57663          	bgeu	a0,a4,80007904 <__printf+0x62c>
    8000749c:	02d7f5bb          	remuw	a1,a5,a3
    800074a0:	02059593          	slli	a1,a1,0x20
    800074a4:	0205d593          	srli	a1,a1,0x20
    800074a8:	00bd85b3          	add	a1,s11,a1
    800074ac:	0005c583          	lbu	a1,0(a1)
    800074b0:	02d7d7bb          	divuw	a5,a5,a3
    800074b4:	f8b402a3          	sb	a1,-123(s0)
    800074b8:	46ea7863          	bgeu	s4,a4,80007928 <__printf+0x650>
    800074bc:	02d7f5bb          	remuw	a1,a5,a3
    800074c0:	02059593          	slli	a1,a1,0x20
    800074c4:	0205d593          	srli	a1,a1,0x20
    800074c8:	00bd85b3          	add	a1,s11,a1
    800074cc:	0005c583          	lbu	a1,0(a1)
    800074d0:	02d7d7bb          	divuw	a5,a5,a3
    800074d4:	f8b40323          	sb	a1,-122(s0)
    800074d8:	3eeaf863          	bgeu	s5,a4,800078c8 <__printf+0x5f0>
    800074dc:	02d7f5bb          	remuw	a1,a5,a3
    800074e0:	02059593          	slli	a1,a1,0x20
    800074e4:	0205d593          	srli	a1,a1,0x20
    800074e8:	00bd85b3          	add	a1,s11,a1
    800074ec:	0005c583          	lbu	a1,0(a1)
    800074f0:	02d7d7bb          	divuw	a5,a5,a3
    800074f4:	f8b403a3          	sb	a1,-121(s0)
    800074f8:	42eb7e63          	bgeu	s6,a4,80007934 <__printf+0x65c>
    800074fc:	02d7f5bb          	remuw	a1,a5,a3
    80007500:	02059593          	slli	a1,a1,0x20
    80007504:	0205d593          	srli	a1,a1,0x20
    80007508:	00bd85b3          	add	a1,s11,a1
    8000750c:	0005c583          	lbu	a1,0(a1)
    80007510:	02d7d7bb          	divuw	a5,a5,a3
    80007514:	f8b40423          	sb	a1,-120(s0)
    80007518:	42ebfc63          	bgeu	s7,a4,80007950 <__printf+0x678>
    8000751c:	02079793          	slli	a5,a5,0x20
    80007520:	0207d793          	srli	a5,a5,0x20
    80007524:	00fd8db3          	add	s11,s11,a5
    80007528:	000dc703          	lbu	a4,0(s11)
    8000752c:	00a00793          	li	a5,10
    80007530:	00900c93          	li	s9,9
    80007534:	f8e404a3          	sb	a4,-119(s0)
    80007538:	00065c63          	bgez	a2,80007550 <__printf+0x278>
    8000753c:	f9040713          	addi	a4,s0,-112
    80007540:	00f70733          	add	a4,a4,a5
    80007544:	02d00693          	li	a3,45
    80007548:	fed70823          	sb	a3,-16(a4)
    8000754c:	00078c93          	mv	s9,a5
    80007550:	f8040793          	addi	a5,s0,-128
    80007554:	01978cb3          	add	s9,a5,s9
    80007558:	f7f40d13          	addi	s10,s0,-129
    8000755c:	000cc503          	lbu	a0,0(s9)
    80007560:	fffc8c93          	addi	s9,s9,-1
    80007564:	00000097          	auipc	ra,0x0
    80007568:	b90080e7          	jalr	-1136(ra) # 800070f4 <consputc>
    8000756c:	ffac98e3          	bne	s9,s10,8000755c <__printf+0x284>
    80007570:	00094503          	lbu	a0,0(s2)
    80007574:	e00514e3          	bnez	a0,8000737c <__printf+0xa4>
    80007578:	1a0c1663          	bnez	s8,80007724 <__printf+0x44c>
    8000757c:	08813083          	ld	ra,136(sp)
    80007580:	08013403          	ld	s0,128(sp)
    80007584:	07813483          	ld	s1,120(sp)
    80007588:	07013903          	ld	s2,112(sp)
    8000758c:	06813983          	ld	s3,104(sp)
    80007590:	06013a03          	ld	s4,96(sp)
    80007594:	05813a83          	ld	s5,88(sp)
    80007598:	05013b03          	ld	s6,80(sp)
    8000759c:	04813b83          	ld	s7,72(sp)
    800075a0:	04013c03          	ld	s8,64(sp)
    800075a4:	03813c83          	ld	s9,56(sp)
    800075a8:	03013d03          	ld	s10,48(sp)
    800075ac:	02813d83          	ld	s11,40(sp)
    800075b0:	0d010113          	addi	sp,sp,208
    800075b4:	00008067          	ret
    800075b8:	07300713          	li	a4,115
    800075bc:	1ce78a63          	beq	a5,a4,80007790 <__printf+0x4b8>
    800075c0:	07800713          	li	a4,120
    800075c4:	1ee79e63          	bne	a5,a4,800077c0 <__printf+0x4e8>
    800075c8:	f7843783          	ld	a5,-136(s0)
    800075cc:	0007a703          	lw	a4,0(a5)
    800075d0:	00878793          	addi	a5,a5,8
    800075d4:	f6f43c23          	sd	a5,-136(s0)
    800075d8:	28074263          	bltz	a4,8000785c <__printf+0x584>
    800075dc:	00002d97          	auipc	s11,0x2
    800075e0:	12cd8d93          	addi	s11,s11,300 # 80009708 <digits>
    800075e4:	00f77793          	andi	a5,a4,15
    800075e8:	00fd87b3          	add	a5,s11,a5
    800075ec:	0007c683          	lbu	a3,0(a5)
    800075f0:	00f00613          	li	a2,15
    800075f4:	0007079b          	sext.w	a5,a4
    800075f8:	f8d40023          	sb	a3,-128(s0)
    800075fc:	0047559b          	srliw	a1,a4,0x4
    80007600:	0047569b          	srliw	a3,a4,0x4
    80007604:	00000c93          	li	s9,0
    80007608:	0ee65063          	bge	a2,a4,800076e8 <__printf+0x410>
    8000760c:	00f6f693          	andi	a3,a3,15
    80007610:	00dd86b3          	add	a3,s11,a3
    80007614:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007618:	0087d79b          	srliw	a5,a5,0x8
    8000761c:	00100c93          	li	s9,1
    80007620:	f8d400a3          	sb	a3,-127(s0)
    80007624:	0cb67263          	bgeu	a2,a1,800076e8 <__printf+0x410>
    80007628:	00f7f693          	andi	a3,a5,15
    8000762c:	00dd86b3          	add	a3,s11,a3
    80007630:	0006c583          	lbu	a1,0(a3)
    80007634:	00f00613          	li	a2,15
    80007638:	0047d69b          	srliw	a3,a5,0x4
    8000763c:	f8b40123          	sb	a1,-126(s0)
    80007640:	0047d593          	srli	a1,a5,0x4
    80007644:	28f67e63          	bgeu	a2,a5,800078e0 <__printf+0x608>
    80007648:	00f6f693          	andi	a3,a3,15
    8000764c:	00dd86b3          	add	a3,s11,a3
    80007650:	0006c503          	lbu	a0,0(a3)
    80007654:	0087d813          	srli	a6,a5,0x8
    80007658:	0087d69b          	srliw	a3,a5,0x8
    8000765c:	f8a401a3          	sb	a0,-125(s0)
    80007660:	28b67663          	bgeu	a2,a1,800078ec <__printf+0x614>
    80007664:	00f6f693          	andi	a3,a3,15
    80007668:	00dd86b3          	add	a3,s11,a3
    8000766c:	0006c583          	lbu	a1,0(a3)
    80007670:	00c7d513          	srli	a0,a5,0xc
    80007674:	00c7d69b          	srliw	a3,a5,0xc
    80007678:	f8b40223          	sb	a1,-124(s0)
    8000767c:	29067a63          	bgeu	a2,a6,80007910 <__printf+0x638>
    80007680:	00f6f693          	andi	a3,a3,15
    80007684:	00dd86b3          	add	a3,s11,a3
    80007688:	0006c583          	lbu	a1,0(a3)
    8000768c:	0107d813          	srli	a6,a5,0x10
    80007690:	0107d69b          	srliw	a3,a5,0x10
    80007694:	f8b402a3          	sb	a1,-123(s0)
    80007698:	28a67263          	bgeu	a2,a0,8000791c <__printf+0x644>
    8000769c:	00f6f693          	andi	a3,a3,15
    800076a0:	00dd86b3          	add	a3,s11,a3
    800076a4:	0006c683          	lbu	a3,0(a3)
    800076a8:	0147d79b          	srliw	a5,a5,0x14
    800076ac:	f8d40323          	sb	a3,-122(s0)
    800076b0:	21067663          	bgeu	a2,a6,800078bc <__printf+0x5e4>
    800076b4:	02079793          	slli	a5,a5,0x20
    800076b8:	0207d793          	srli	a5,a5,0x20
    800076bc:	00fd8db3          	add	s11,s11,a5
    800076c0:	000dc683          	lbu	a3,0(s11)
    800076c4:	00800793          	li	a5,8
    800076c8:	00700c93          	li	s9,7
    800076cc:	f8d403a3          	sb	a3,-121(s0)
    800076d0:	00075c63          	bgez	a4,800076e8 <__printf+0x410>
    800076d4:	f9040713          	addi	a4,s0,-112
    800076d8:	00f70733          	add	a4,a4,a5
    800076dc:	02d00693          	li	a3,45
    800076e0:	fed70823          	sb	a3,-16(a4)
    800076e4:	00078c93          	mv	s9,a5
    800076e8:	f8040793          	addi	a5,s0,-128
    800076ec:	01978cb3          	add	s9,a5,s9
    800076f0:	f7f40d13          	addi	s10,s0,-129
    800076f4:	000cc503          	lbu	a0,0(s9)
    800076f8:	fffc8c93          	addi	s9,s9,-1
    800076fc:	00000097          	auipc	ra,0x0
    80007700:	9f8080e7          	jalr	-1544(ra) # 800070f4 <consputc>
    80007704:	ff9d18e3          	bne	s10,s9,800076f4 <__printf+0x41c>
    80007708:	0100006f          	j	80007718 <__printf+0x440>
    8000770c:	00000097          	auipc	ra,0x0
    80007710:	9e8080e7          	jalr	-1560(ra) # 800070f4 <consputc>
    80007714:	000c8493          	mv	s1,s9
    80007718:	00094503          	lbu	a0,0(s2)
    8000771c:	c60510e3          	bnez	a0,8000737c <__printf+0xa4>
    80007720:	e40c0ee3          	beqz	s8,8000757c <__printf+0x2a4>
    80007724:	0000a517          	auipc	a0,0xa
    80007728:	8fc50513          	addi	a0,a0,-1796 # 80011020 <pr>
    8000772c:	00001097          	auipc	ra,0x1
    80007730:	94c080e7          	jalr	-1716(ra) # 80008078 <release>
    80007734:	e49ff06f          	j	8000757c <__printf+0x2a4>
    80007738:	f7843783          	ld	a5,-136(s0)
    8000773c:	03000513          	li	a0,48
    80007740:	01000d13          	li	s10,16
    80007744:	00878713          	addi	a4,a5,8
    80007748:	0007bc83          	ld	s9,0(a5)
    8000774c:	f6e43c23          	sd	a4,-136(s0)
    80007750:	00000097          	auipc	ra,0x0
    80007754:	9a4080e7          	jalr	-1628(ra) # 800070f4 <consputc>
    80007758:	07800513          	li	a0,120
    8000775c:	00000097          	auipc	ra,0x0
    80007760:	998080e7          	jalr	-1640(ra) # 800070f4 <consputc>
    80007764:	00002d97          	auipc	s11,0x2
    80007768:	fa4d8d93          	addi	s11,s11,-92 # 80009708 <digits>
    8000776c:	03ccd793          	srli	a5,s9,0x3c
    80007770:	00fd87b3          	add	a5,s11,a5
    80007774:	0007c503          	lbu	a0,0(a5)
    80007778:	fffd0d1b          	addiw	s10,s10,-1
    8000777c:	004c9c93          	slli	s9,s9,0x4
    80007780:	00000097          	auipc	ra,0x0
    80007784:	974080e7          	jalr	-1676(ra) # 800070f4 <consputc>
    80007788:	fe0d12e3          	bnez	s10,8000776c <__printf+0x494>
    8000778c:	f8dff06f          	j	80007718 <__printf+0x440>
    80007790:	f7843783          	ld	a5,-136(s0)
    80007794:	0007bc83          	ld	s9,0(a5)
    80007798:	00878793          	addi	a5,a5,8
    8000779c:	f6f43c23          	sd	a5,-136(s0)
    800077a0:	000c9a63          	bnez	s9,800077b4 <__printf+0x4dc>
    800077a4:	1080006f          	j	800078ac <__printf+0x5d4>
    800077a8:	001c8c93          	addi	s9,s9,1
    800077ac:	00000097          	auipc	ra,0x0
    800077b0:	948080e7          	jalr	-1720(ra) # 800070f4 <consputc>
    800077b4:	000cc503          	lbu	a0,0(s9)
    800077b8:	fe0518e3          	bnez	a0,800077a8 <__printf+0x4d0>
    800077bc:	f5dff06f          	j	80007718 <__printf+0x440>
    800077c0:	02500513          	li	a0,37
    800077c4:	00000097          	auipc	ra,0x0
    800077c8:	930080e7          	jalr	-1744(ra) # 800070f4 <consputc>
    800077cc:	000c8513          	mv	a0,s9
    800077d0:	00000097          	auipc	ra,0x0
    800077d4:	924080e7          	jalr	-1756(ra) # 800070f4 <consputc>
    800077d8:	f41ff06f          	j	80007718 <__printf+0x440>
    800077dc:	02500513          	li	a0,37
    800077e0:	00000097          	auipc	ra,0x0
    800077e4:	914080e7          	jalr	-1772(ra) # 800070f4 <consputc>
    800077e8:	f31ff06f          	j	80007718 <__printf+0x440>
    800077ec:	00030513          	mv	a0,t1
    800077f0:	00000097          	auipc	ra,0x0
    800077f4:	7bc080e7          	jalr	1980(ra) # 80007fac <acquire>
    800077f8:	b4dff06f          	j	80007344 <__printf+0x6c>
    800077fc:	40c0053b          	negw	a0,a2
    80007800:	00a00713          	li	a4,10
    80007804:	02e576bb          	remuw	a3,a0,a4
    80007808:	00002d97          	auipc	s11,0x2
    8000780c:	f00d8d93          	addi	s11,s11,-256 # 80009708 <digits>
    80007810:	ff700593          	li	a1,-9
    80007814:	02069693          	slli	a3,a3,0x20
    80007818:	0206d693          	srli	a3,a3,0x20
    8000781c:	00dd86b3          	add	a3,s11,a3
    80007820:	0006c683          	lbu	a3,0(a3)
    80007824:	02e557bb          	divuw	a5,a0,a4
    80007828:	f8d40023          	sb	a3,-128(s0)
    8000782c:	10b65e63          	bge	a2,a1,80007948 <__printf+0x670>
    80007830:	06300593          	li	a1,99
    80007834:	02e7f6bb          	remuw	a3,a5,a4
    80007838:	02069693          	slli	a3,a3,0x20
    8000783c:	0206d693          	srli	a3,a3,0x20
    80007840:	00dd86b3          	add	a3,s11,a3
    80007844:	0006c683          	lbu	a3,0(a3)
    80007848:	02e7d73b          	divuw	a4,a5,a4
    8000784c:	00200793          	li	a5,2
    80007850:	f8d400a3          	sb	a3,-127(s0)
    80007854:	bca5ece3          	bltu	a1,a0,8000742c <__printf+0x154>
    80007858:	ce5ff06f          	j	8000753c <__printf+0x264>
    8000785c:	40e007bb          	negw	a5,a4
    80007860:	00002d97          	auipc	s11,0x2
    80007864:	ea8d8d93          	addi	s11,s11,-344 # 80009708 <digits>
    80007868:	00f7f693          	andi	a3,a5,15
    8000786c:	00dd86b3          	add	a3,s11,a3
    80007870:	0006c583          	lbu	a1,0(a3)
    80007874:	ff100613          	li	a2,-15
    80007878:	0047d69b          	srliw	a3,a5,0x4
    8000787c:	f8b40023          	sb	a1,-128(s0)
    80007880:	0047d59b          	srliw	a1,a5,0x4
    80007884:	0ac75e63          	bge	a4,a2,80007940 <__printf+0x668>
    80007888:	00f6f693          	andi	a3,a3,15
    8000788c:	00dd86b3          	add	a3,s11,a3
    80007890:	0006c603          	lbu	a2,0(a3)
    80007894:	00f00693          	li	a3,15
    80007898:	0087d79b          	srliw	a5,a5,0x8
    8000789c:	f8c400a3          	sb	a2,-127(s0)
    800078a0:	d8b6e4e3          	bltu	a3,a1,80007628 <__printf+0x350>
    800078a4:	00200793          	li	a5,2
    800078a8:	e2dff06f          	j	800076d4 <__printf+0x3fc>
    800078ac:	00002c97          	auipc	s9,0x2
    800078b0:	e3cc8c93          	addi	s9,s9,-452 # 800096e8 <CONSOLE_STATUS+0x6d8>
    800078b4:	02800513          	li	a0,40
    800078b8:	ef1ff06f          	j	800077a8 <__printf+0x4d0>
    800078bc:	00700793          	li	a5,7
    800078c0:	00600c93          	li	s9,6
    800078c4:	e0dff06f          	j	800076d0 <__printf+0x3f8>
    800078c8:	00700793          	li	a5,7
    800078cc:	00600c93          	li	s9,6
    800078d0:	c69ff06f          	j	80007538 <__printf+0x260>
    800078d4:	00300793          	li	a5,3
    800078d8:	00200c93          	li	s9,2
    800078dc:	c5dff06f          	j	80007538 <__printf+0x260>
    800078e0:	00300793          	li	a5,3
    800078e4:	00200c93          	li	s9,2
    800078e8:	de9ff06f          	j	800076d0 <__printf+0x3f8>
    800078ec:	00400793          	li	a5,4
    800078f0:	00300c93          	li	s9,3
    800078f4:	dddff06f          	j	800076d0 <__printf+0x3f8>
    800078f8:	00400793          	li	a5,4
    800078fc:	00300c93          	li	s9,3
    80007900:	c39ff06f          	j	80007538 <__printf+0x260>
    80007904:	00500793          	li	a5,5
    80007908:	00400c93          	li	s9,4
    8000790c:	c2dff06f          	j	80007538 <__printf+0x260>
    80007910:	00500793          	li	a5,5
    80007914:	00400c93          	li	s9,4
    80007918:	db9ff06f          	j	800076d0 <__printf+0x3f8>
    8000791c:	00600793          	li	a5,6
    80007920:	00500c93          	li	s9,5
    80007924:	dadff06f          	j	800076d0 <__printf+0x3f8>
    80007928:	00600793          	li	a5,6
    8000792c:	00500c93          	li	s9,5
    80007930:	c09ff06f          	j	80007538 <__printf+0x260>
    80007934:	00800793          	li	a5,8
    80007938:	00700c93          	li	s9,7
    8000793c:	bfdff06f          	j	80007538 <__printf+0x260>
    80007940:	00100793          	li	a5,1
    80007944:	d91ff06f          	j	800076d4 <__printf+0x3fc>
    80007948:	00100793          	li	a5,1
    8000794c:	bf1ff06f          	j	8000753c <__printf+0x264>
    80007950:	00900793          	li	a5,9
    80007954:	00800c93          	li	s9,8
    80007958:	be1ff06f          	j	80007538 <__printf+0x260>
    8000795c:	00002517          	auipc	a0,0x2
    80007960:	d9450513          	addi	a0,a0,-620 # 800096f0 <CONSOLE_STATUS+0x6e0>
    80007964:	00000097          	auipc	ra,0x0
    80007968:	918080e7          	jalr	-1768(ra) # 8000727c <panic>

000000008000796c <printfinit>:
    8000796c:	fe010113          	addi	sp,sp,-32
    80007970:	00813823          	sd	s0,16(sp)
    80007974:	00913423          	sd	s1,8(sp)
    80007978:	00113c23          	sd	ra,24(sp)
    8000797c:	02010413          	addi	s0,sp,32
    80007980:	00009497          	auipc	s1,0x9
    80007984:	6a048493          	addi	s1,s1,1696 # 80011020 <pr>
    80007988:	00048513          	mv	a0,s1
    8000798c:	00002597          	auipc	a1,0x2
    80007990:	d7458593          	addi	a1,a1,-652 # 80009700 <CONSOLE_STATUS+0x6f0>
    80007994:	00000097          	auipc	ra,0x0
    80007998:	5f4080e7          	jalr	1524(ra) # 80007f88 <initlock>
    8000799c:	01813083          	ld	ra,24(sp)
    800079a0:	01013403          	ld	s0,16(sp)
    800079a4:	0004ac23          	sw	zero,24(s1)
    800079a8:	00813483          	ld	s1,8(sp)
    800079ac:	02010113          	addi	sp,sp,32
    800079b0:	00008067          	ret

00000000800079b4 <uartinit>:
    800079b4:	ff010113          	addi	sp,sp,-16
    800079b8:	00813423          	sd	s0,8(sp)
    800079bc:	01010413          	addi	s0,sp,16
    800079c0:	100007b7          	lui	a5,0x10000
    800079c4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800079c8:	f8000713          	li	a4,-128
    800079cc:	00e781a3          	sb	a4,3(a5)
    800079d0:	00300713          	li	a4,3
    800079d4:	00e78023          	sb	a4,0(a5)
    800079d8:	000780a3          	sb	zero,1(a5)
    800079dc:	00e781a3          	sb	a4,3(a5)
    800079e0:	00700693          	li	a3,7
    800079e4:	00d78123          	sb	a3,2(a5)
    800079e8:	00e780a3          	sb	a4,1(a5)
    800079ec:	00813403          	ld	s0,8(sp)
    800079f0:	01010113          	addi	sp,sp,16
    800079f4:	00008067          	ret

00000000800079f8 <uartputc>:
    800079f8:	00004797          	auipc	a5,0x4
    800079fc:	1907a783          	lw	a5,400(a5) # 8000bb88 <panicked>
    80007a00:	00078463          	beqz	a5,80007a08 <uartputc+0x10>
    80007a04:	0000006f          	j	80007a04 <uartputc+0xc>
    80007a08:	fd010113          	addi	sp,sp,-48
    80007a0c:	02813023          	sd	s0,32(sp)
    80007a10:	00913c23          	sd	s1,24(sp)
    80007a14:	01213823          	sd	s2,16(sp)
    80007a18:	01313423          	sd	s3,8(sp)
    80007a1c:	02113423          	sd	ra,40(sp)
    80007a20:	03010413          	addi	s0,sp,48
    80007a24:	00004917          	auipc	s2,0x4
    80007a28:	16c90913          	addi	s2,s2,364 # 8000bb90 <uart_tx_r>
    80007a2c:	00093783          	ld	a5,0(s2)
    80007a30:	00004497          	auipc	s1,0x4
    80007a34:	16848493          	addi	s1,s1,360 # 8000bb98 <uart_tx_w>
    80007a38:	0004b703          	ld	a4,0(s1)
    80007a3c:	02078693          	addi	a3,a5,32
    80007a40:	00050993          	mv	s3,a0
    80007a44:	02e69c63          	bne	a3,a4,80007a7c <uartputc+0x84>
    80007a48:	00001097          	auipc	ra,0x1
    80007a4c:	834080e7          	jalr	-1996(ra) # 8000827c <push_on>
    80007a50:	00093783          	ld	a5,0(s2)
    80007a54:	0004b703          	ld	a4,0(s1)
    80007a58:	02078793          	addi	a5,a5,32
    80007a5c:	00e79463          	bne	a5,a4,80007a64 <uartputc+0x6c>
    80007a60:	0000006f          	j	80007a60 <uartputc+0x68>
    80007a64:	00001097          	auipc	ra,0x1
    80007a68:	88c080e7          	jalr	-1908(ra) # 800082f0 <pop_on>
    80007a6c:	00093783          	ld	a5,0(s2)
    80007a70:	0004b703          	ld	a4,0(s1)
    80007a74:	02078693          	addi	a3,a5,32
    80007a78:	fce688e3          	beq	a3,a4,80007a48 <uartputc+0x50>
    80007a7c:	01f77693          	andi	a3,a4,31
    80007a80:	00009597          	auipc	a1,0x9
    80007a84:	5c058593          	addi	a1,a1,1472 # 80011040 <uart_tx_buf>
    80007a88:	00d586b3          	add	a3,a1,a3
    80007a8c:	00170713          	addi	a4,a4,1
    80007a90:	01368023          	sb	s3,0(a3)
    80007a94:	00e4b023          	sd	a4,0(s1)
    80007a98:	10000637          	lui	a2,0x10000
    80007a9c:	02f71063          	bne	a4,a5,80007abc <uartputc+0xc4>
    80007aa0:	0340006f          	j	80007ad4 <uartputc+0xdc>
    80007aa4:	00074703          	lbu	a4,0(a4)
    80007aa8:	00f93023          	sd	a5,0(s2)
    80007aac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007ab0:	00093783          	ld	a5,0(s2)
    80007ab4:	0004b703          	ld	a4,0(s1)
    80007ab8:	00f70e63          	beq	a4,a5,80007ad4 <uartputc+0xdc>
    80007abc:	00564683          	lbu	a3,5(a2)
    80007ac0:	01f7f713          	andi	a4,a5,31
    80007ac4:	00e58733          	add	a4,a1,a4
    80007ac8:	0206f693          	andi	a3,a3,32
    80007acc:	00178793          	addi	a5,a5,1
    80007ad0:	fc069ae3          	bnez	a3,80007aa4 <uartputc+0xac>
    80007ad4:	02813083          	ld	ra,40(sp)
    80007ad8:	02013403          	ld	s0,32(sp)
    80007adc:	01813483          	ld	s1,24(sp)
    80007ae0:	01013903          	ld	s2,16(sp)
    80007ae4:	00813983          	ld	s3,8(sp)
    80007ae8:	03010113          	addi	sp,sp,48
    80007aec:	00008067          	ret

0000000080007af0 <uartputc_sync>:
    80007af0:	ff010113          	addi	sp,sp,-16
    80007af4:	00813423          	sd	s0,8(sp)
    80007af8:	01010413          	addi	s0,sp,16
    80007afc:	00004717          	auipc	a4,0x4
    80007b00:	08c72703          	lw	a4,140(a4) # 8000bb88 <panicked>
    80007b04:	02071663          	bnez	a4,80007b30 <uartputc_sync+0x40>
    80007b08:	00050793          	mv	a5,a0
    80007b0c:	100006b7          	lui	a3,0x10000
    80007b10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007b14:	02077713          	andi	a4,a4,32
    80007b18:	fe070ce3          	beqz	a4,80007b10 <uartputc_sync+0x20>
    80007b1c:	0ff7f793          	andi	a5,a5,255
    80007b20:	00f68023          	sb	a5,0(a3)
    80007b24:	00813403          	ld	s0,8(sp)
    80007b28:	01010113          	addi	sp,sp,16
    80007b2c:	00008067          	ret
    80007b30:	0000006f          	j	80007b30 <uartputc_sync+0x40>

0000000080007b34 <uartstart>:
    80007b34:	ff010113          	addi	sp,sp,-16
    80007b38:	00813423          	sd	s0,8(sp)
    80007b3c:	01010413          	addi	s0,sp,16
    80007b40:	00004617          	auipc	a2,0x4
    80007b44:	05060613          	addi	a2,a2,80 # 8000bb90 <uart_tx_r>
    80007b48:	00004517          	auipc	a0,0x4
    80007b4c:	05050513          	addi	a0,a0,80 # 8000bb98 <uart_tx_w>
    80007b50:	00063783          	ld	a5,0(a2)
    80007b54:	00053703          	ld	a4,0(a0)
    80007b58:	04f70263          	beq	a4,a5,80007b9c <uartstart+0x68>
    80007b5c:	100005b7          	lui	a1,0x10000
    80007b60:	00009817          	auipc	a6,0x9
    80007b64:	4e080813          	addi	a6,a6,1248 # 80011040 <uart_tx_buf>
    80007b68:	01c0006f          	j	80007b84 <uartstart+0x50>
    80007b6c:	0006c703          	lbu	a4,0(a3)
    80007b70:	00f63023          	sd	a5,0(a2)
    80007b74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007b78:	00063783          	ld	a5,0(a2)
    80007b7c:	00053703          	ld	a4,0(a0)
    80007b80:	00f70e63          	beq	a4,a5,80007b9c <uartstart+0x68>
    80007b84:	01f7f713          	andi	a4,a5,31
    80007b88:	00e806b3          	add	a3,a6,a4
    80007b8c:	0055c703          	lbu	a4,5(a1)
    80007b90:	00178793          	addi	a5,a5,1
    80007b94:	02077713          	andi	a4,a4,32
    80007b98:	fc071ae3          	bnez	a4,80007b6c <uartstart+0x38>
    80007b9c:	00813403          	ld	s0,8(sp)
    80007ba0:	01010113          	addi	sp,sp,16
    80007ba4:	00008067          	ret

0000000080007ba8 <uartgetc>:
    80007ba8:	ff010113          	addi	sp,sp,-16
    80007bac:	00813423          	sd	s0,8(sp)
    80007bb0:	01010413          	addi	s0,sp,16
    80007bb4:	10000737          	lui	a4,0x10000
    80007bb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007bbc:	0017f793          	andi	a5,a5,1
    80007bc0:	00078c63          	beqz	a5,80007bd8 <uartgetc+0x30>
    80007bc4:	00074503          	lbu	a0,0(a4)
    80007bc8:	0ff57513          	andi	a0,a0,255
    80007bcc:	00813403          	ld	s0,8(sp)
    80007bd0:	01010113          	addi	sp,sp,16
    80007bd4:	00008067          	ret
    80007bd8:	fff00513          	li	a0,-1
    80007bdc:	ff1ff06f          	j	80007bcc <uartgetc+0x24>

0000000080007be0 <uartintr>:
    80007be0:	100007b7          	lui	a5,0x10000
    80007be4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007be8:	0017f793          	andi	a5,a5,1
    80007bec:	0a078463          	beqz	a5,80007c94 <uartintr+0xb4>
    80007bf0:	fe010113          	addi	sp,sp,-32
    80007bf4:	00813823          	sd	s0,16(sp)
    80007bf8:	00913423          	sd	s1,8(sp)
    80007bfc:	00113c23          	sd	ra,24(sp)
    80007c00:	02010413          	addi	s0,sp,32
    80007c04:	100004b7          	lui	s1,0x10000
    80007c08:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80007c0c:	0ff57513          	andi	a0,a0,255
    80007c10:	fffff097          	auipc	ra,0xfffff
    80007c14:	534080e7          	jalr	1332(ra) # 80007144 <consoleintr>
    80007c18:	0054c783          	lbu	a5,5(s1)
    80007c1c:	0017f793          	andi	a5,a5,1
    80007c20:	fe0794e3          	bnez	a5,80007c08 <uartintr+0x28>
    80007c24:	00004617          	auipc	a2,0x4
    80007c28:	f6c60613          	addi	a2,a2,-148 # 8000bb90 <uart_tx_r>
    80007c2c:	00004517          	auipc	a0,0x4
    80007c30:	f6c50513          	addi	a0,a0,-148 # 8000bb98 <uart_tx_w>
    80007c34:	00063783          	ld	a5,0(a2)
    80007c38:	00053703          	ld	a4,0(a0)
    80007c3c:	04f70263          	beq	a4,a5,80007c80 <uartintr+0xa0>
    80007c40:	100005b7          	lui	a1,0x10000
    80007c44:	00009817          	auipc	a6,0x9
    80007c48:	3fc80813          	addi	a6,a6,1020 # 80011040 <uart_tx_buf>
    80007c4c:	01c0006f          	j	80007c68 <uartintr+0x88>
    80007c50:	0006c703          	lbu	a4,0(a3)
    80007c54:	00f63023          	sd	a5,0(a2)
    80007c58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007c5c:	00063783          	ld	a5,0(a2)
    80007c60:	00053703          	ld	a4,0(a0)
    80007c64:	00f70e63          	beq	a4,a5,80007c80 <uartintr+0xa0>
    80007c68:	01f7f713          	andi	a4,a5,31
    80007c6c:	00e806b3          	add	a3,a6,a4
    80007c70:	0055c703          	lbu	a4,5(a1)
    80007c74:	00178793          	addi	a5,a5,1
    80007c78:	02077713          	andi	a4,a4,32
    80007c7c:	fc071ae3          	bnez	a4,80007c50 <uartintr+0x70>
    80007c80:	01813083          	ld	ra,24(sp)
    80007c84:	01013403          	ld	s0,16(sp)
    80007c88:	00813483          	ld	s1,8(sp)
    80007c8c:	02010113          	addi	sp,sp,32
    80007c90:	00008067          	ret
    80007c94:	00004617          	auipc	a2,0x4
    80007c98:	efc60613          	addi	a2,a2,-260 # 8000bb90 <uart_tx_r>
    80007c9c:	00004517          	auipc	a0,0x4
    80007ca0:	efc50513          	addi	a0,a0,-260 # 8000bb98 <uart_tx_w>
    80007ca4:	00063783          	ld	a5,0(a2)
    80007ca8:	00053703          	ld	a4,0(a0)
    80007cac:	04f70263          	beq	a4,a5,80007cf0 <uartintr+0x110>
    80007cb0:	100005b7          	lui	a1,0x10000
    80007cb4:	00009817          	auipc	a6,0x9
    80007cb8:	38c80813          	addi	a6,a6,908 # 80011040 <uart_tx_buf>
    80007cbc:	01c0006f          	j	80007cd8 <uartintr+0xf8>
    80007cc0:	0006c703          	lbu	a4,0(a3)
    80007cc4:	00f63023          	sd	a5,0(a2)
    80007cc8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007ccc:	00063783          	ld	a5,0(a2)
    80007cd0:	00053703          	ld	a4,0(a0)
    80007cd4:	02f70063          	beq	a4,a5,80007cf4 <uartintr+0x114>
    80007cd8:	01f7f713          	andi	a4,a5,31
    80007cdc:	00e806b3          	add	a3,a6,a4
    80007ce0:	0055c703          	lbu	a4,5(a1)
    80007ce4:	00178793          	addi	a5,a5,1
    80007ce8:	02077713          	andi	a4,a4,32
    80007cec:	fc071ae3          	bnez	a4,80007cc0 <uartintr+0xe0>
    80007cf0:	00008067          	ret
    80007cf4:	00008067          	ret

0000000080007cf8 <kinit>:
    80007cf8:	fc010113          	addi	sp,sp,-64
    80007cfc:	02913423          	sd	s1,40(sp)
    80007d00:	fffff7b7          	lui	a5,0xfffff
    80007d04:	0000a497          	auipc	s1,0xa
    80007d08:	35b48493          	addi	s1,s1,859 # 8001205f <end+0xfff>
    80007d0c:	02813823          	sd	s0,48(sp)
    80007d10:	01313c23          	sd	s3,24(sp)
    80007d14:	00f4f4b3          	and	s1,s1,a5
    80007d18:	02113c23          	sd	ra,56(sp)
    80007d1c:	03213023          	sd	s2,32(sp)
    80007d20:	01413823          	sd	s4,16(sp)
    80007d24:	01513423          	sd	s5,8(sp)
    80007d28:	04010413          	addi	s0,sp,64
    80007d2c:	000017b7          	lui	a5,0x1
    80007d30:	01100993          	li	s3,17
    80007d34:	00f487b3          	add	a5,s1,a5
    80007d38:	01b99993          	slli	s3,s3,0x1b
    80007d3c:	06f9e063          	bltu	s3,a5,80007d9c <kinit+0xa4>
    80007d40:	00009a97          	auipc	s5,0x9
    80007d44:	320a8a93          	addi	s5,s5,800 # 80011060 <end>
    80007d48:	0754ec63          	bltu	s1,s5,80007dc0 <kinit+0xc8>
    80007d4c:	0734fa63          	bgeu	s1,s3,80007dc0 <kinit+0xc8>
    80007d50:	00088a37          	lui	s4,0x88
    80007d54:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007d58:	00004917          	auipc	s2,0x4
    80007d5c:	e4890913          	addi	s2,s2,-440 # 8000bba0 <kmem>
    80007d60:	00ca1a13          	slli	s4,s4,0xc
    80007d64:	0140006f          	j	80007d78 <kinit+0x80>
    80007d68:	000017b7          	lui	a5,0x1
    80007d6c:	00f484b3          	add	s1,s1,a5
    80007d70:	0554e863          	bltu	s1,s5,80007dc0 <kinit+0xc8>
    80007d74:	0534f663          	bgeu	s1,s3,80007dc0 <kinit+0xc8>
    80007d78:	00001637          	lui	a2,0x1
    80007d7c:	00100593          	li	a1,1
    80007d80:	00048513          	mv	a0,s1
    80007d84:	00000097          	auipc	ra,0x0
    80007d88:	5e4080e7          	jalr	1508(ra) # 80008368 <__memset>
    80007d8c:	00093783          	ld	a5,0(s2)
    80007d90:	00f4b023          	sd	a5,0(s1)
    80007d94:	00993023          	sd	s1,0(s2)
    80007d98:	fd4498e3          	bne	s1,s4,80007d68 <kinit+0x70>
    80007d9c:	03813083          	ld	ra,56(sp)
    80007da0:	03013403          	ld	s0,48(sp)
    80007da4:	02813483          	ld	s1,40(sp)
    80007da8:	02013903          	ld	s2,32(sp)
    80007dac:	01813983          	ld	s3,24(sp)
    80007db0:	01013a03          	ld	s4,16(sp)
    80007db4:	00813a83          	ld	s5,8(sp)
    80007db8:	04010113          	addi	sp,sp,64
    80007dbc:	00008067          	ret
    80007dc0:	00002517          	auipc	a0,0x2
    80007dc4:	96050513          	addi	a0,a0,-1696 # 80009720 <digits+0x18>
    80007dc8:	fffff097          	auipc	ra,0xfffff
    80007dcc:	4b4080e7          	jalr	1204(ra) # 8000727c <panic>

0000000080007dd0 <freerange>:
    80007dd0:	fc010113          	addi	sp,sp,-64
    80007dd4:	000017b7          	lui	a5,0x1
    80007dd8:	02913423          	sd	s1,40(sp)
    80007ddc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007de0:	009504b3          	add	s1,a0,s1
    80007de4:	fffff537          	lui	a0,0xfffff
    80007de8:	02813823          	sd	s0,48(sp)
    80007dec:	02113c23          	sd	ra,56(sp)
    80007df0:	03213023          	sd	s2,32(sp)
    80007df4:	01313c23          	sd	s3,24(sp)
    80007df8:	01413823          	sd	s4,16(sp)
    80007dfc:	01513423          	sd	s5,8(sp)
    80007e00:	01613023          	sd	s6,0(sp)
    80007e04:	04010413          	addi	s0,sp,64
    80007e08:	00a4f4b3          	and	s1,s1,a0
    80007e0c:	00f487b3          	add	a5,s1,a5
    80007e10:	06f5e463          	bltu	a1,a5,80007e78 <freerange+0xa8>
    80007e14:	00009a97          	auipc	s5,0x9
    80007e18:	24ca8a93          	addi	s5,s5,588 # 80011060 <end>
    80007e1c:	0954e263          	bltu	s1,s5,80007ea0 <freerange+0xd0>
    80007e20:	01100993          	li	s3,17
    80007e24:	01b99993          	slli	s3,s3,0x1b
    80007e28:	0734fc63          	bgeu	s1,s3,80007ea0 <freerange+0xd0>
    80007e2c:	00058a13          	mv	s4,a1
    80007e30:	00004917          	auipc	s2,0x4
    80007e34:	d7090913          	addi	s2,s2,-656 # 8000bba0 <kmem>
    80007e38:	00002b37          	lui	s6,0x2
    80007e3c:	0140006f          	j	80007e50 <freerange+0x80>
    80007e40:	000017b7          	lui	a5,0x1
    80007e44:	00f484b3          	add	s1,s1,a5
    80007e48:	0554ec63          	bltu	s1,s5,80007ea0 <freerange+0xd0>
    80007e4c:	0534fa63          	bgeu	s1,s3,80007ea0 <freerange+0xd0>
    80007e50:	00001637          	lui	a2,0x1
    80007e54:	00100593          	li	a1,1
    80007e58:	00048513          	mv	a0,s1
    80007e5c:	00000097          	auipc	ra,0x0
    80007e60:	50c080e7          	jalr	1292(ra) # 80008368 <__memset>
    80007e64:	00093703          	ld	a4,0(s2)
    80007e68:	016487b3          	add	a5,s1,s6
    80007e6c:	00e4b023          	sd	a4,0(s1)
    80007e70:	00993023          	sd	s1,0(s2)
    80007e74:	fcfa76e3          	bgeu	s4,a5,80007e40 <freerange+0x70>
    80007e78:	03813083          	ld	ra,56(sp)
    80007e7c:	03013403          	ld	s0,48(sp)
    80007e80:	02813483          	ld	s1,40(sp)
    80007e84:	02013903          	ld	s2,32(sp)
    80007e88:	01813983          	ld	s3,24(sp)
    80007e8c:	01013a03          	ld	s4,16(sp)
    80007e90:	00813a83          	ld	s5,8(sp)
    80007e94:	00013b03          	ld	s6,0(sp)
    80007e98:	04010113          	addi	sp,sp,64
    80007e9c:	00008067          	ret
    80007ea0:	00002517          	auipc	a0,0x2
    80007ea4:	88050513          	addi	a0,a0,-1920 # 80009720 <digits+0x18>
    80007ea8:	fffff097          	auipc	ra,0xfffff
    80007eac:	3d4080e7          	jalr	980(ra) # 8000727c <panic>

0000000080007eb0 <kfree>:
    80007eb0:	fe010113          	addi	sp,sp,-32
    80007eb4:	00813823          	sd	s0,16(sp)
    80007eb8:	00113c23          	sd	ra,24(sp)
    80007ebc:	00913423          	sd	s1,8(sp)
    80007ec0:	02010413          	addi	s0,sp,32
    80007ec4:	03451793          	slli	a5,a0,0x34
    80007ec8:	04079c63          	bnez	a5,80007f20 <kfree+0x70>
    80007ecc:	00009797          	auipc	a5,0x9
    80007ed0:	19478793          	addi	a5,a5,404 # 80011060 <end>
    80007ed4:	00050493          	mv	s1,a0
    80007ed8:	04f56463          	bltu	a0,a5,80007f20 <kfree+0x70>
    80007edc:	01100793          	li	a5,17
    80007ee0:	01b79793          	slli	a5,a5,0x1b
    80007ee4:	02f57e63          	bgeu	a0,a5,80007f20 <kfree+0x70>
    80007ee8:	00001637          	lui	a2,0x1
    80007eec:	00100593          	li	a1,1
    80007ef0:	00000097          	auipc	ra,0x0
    80007ef4:	478080e7          	jalr	1144(ra) # 80008368 <__memset>
    80007ef8:	00004797          	auipc	a5,0x4
    80007efc:	ca878793          	addi	a5,a5,-856 # 8000bba0 <kmem>
    80007f00:	0007b703          	ld	a4,0(a5)
    80007f04:	01813083          	ld	ra,24(sp)
    80007f08:	01013403          	ld	s0,16(sp)
    80007f0c:	00e4b023          	sd	a4,0(s1)
    80007f10:	0097b023          	sd	s1,0(a5)
    80007f14:	00813483          	ld	s1,8(sp)
    80007f18:	02010113          	addi	sp,sp,32
    80007f1c:	00008067          	ret
    80007f20:	00002517          	auipc	a0,0x2
    80007f24:	80050513          	addi	a0,a0,-2048 # 80009720 <digits+0x18>
    80007f28:	fffff097          	auipc	ra,0xfffff
    80007f2c:	354080e7          	jalr	852(ra) # 8000727c <panic>

0000000080007f30 <kalloc>:
    80007f30:	fe010113          	addi	sp,sp,-32
    80007f34:	00813823          	sd	s0,16(sp)
    80007f38:	00913423          	sd	s1,8(sp)
    80007f3c:	00113c23          	sd	ra,24(sp)
    80007f40:	02010413          	addi	s0,sp,32
    80007f44:	00004797          	auipc	a5,0x4
    80007f48:	c5c78793          	addi	a5,a5,-932 # 8000bba0 <kmem>
    80007f4c:	0007b483          	ld	s1,0(a5)
    80007f50:	02048063          	beqz	s1,80007f70 <kalloc+0x40>
    80007f54:	0004b703          	ld	a4,0(s1)
    80007f58:	00001637          	lui	a2,0x1
    80007f5c:	00500593          	li	a1,5
    80007f60:	00048513          	mv	a0,s1
    80007f64:	00e7b023          	sd	a4,0(a5)
    80007f68:	00000097          	auipc	ra,0x0
    80007f6c:	400080e7          	jalr	1024(ra) # 80008368 <__memset>
    80007f70:	01813083          	ld	ra,24(sp)
    80007f74:	01013403          	ld	s0,16(sp)
    80007f78:	00048513          	mv	a0,s1
    80007f7c:	00813483          	ld	s1,8(sp)
    80007f80:	02010113          	addi	sp,sp,32
    80007f84:	00008067          	ret

0000000080007f88 <initlock>:
    80007f88:	ff010113          	addi	sp,sp,-16
    80007f8c:	00813423          	sd	s0,8(sp)
    80007f90:	01010413          	addi	s0,sp,16
    80007f94:	00813403          	ld	s0,8(sp)
    80007f98:	00b53423          	sd	a1,8(a0)
    80007f9c:	00052023          	sw	zero,0(a0)
    80007fa0:	00053823          	sd	zero,16(a0)
    80007fa4:	01010113          	addi	sp,sp,16
    80007fa8:	00008067          	ret

0000000080007fac <acquire>:
    80007fac:	fe010113          	addi	sp,sp,-32
    80007fb0:	00813823          	sd	s0,16(sp)
    80007fb4:	00913423          	sd	s1,8(sp)
    80007fb8:	00113c23          	sd	ra,24(sp)
    80007fbc:	01213023          	sd	s2,0(sp)
    80007fc0:	02010413          	addi	s0,sp,32
    80007fc4:	00050493          	mv	s1,a0
    80007fc8:	10002973          	csrr	s2,sstatus
    80007fcc:	100027f3          	csrr	a5,sstatus
    80007fd0:	ffd7f793          	andi	a5,a5,-3
    80007fd4:	10079073          	csrw	sstatus,a5
    80007fd8:	fffff097          	auipc	ra,0xfffff
    80007fdc:	8e4080e7          	jalr	-1820(ra) # 800068bc <mycpu>
    80007fe0:	07852783          	lw	a5,120(a0)
    80007fe4:	06078e63          	beqz	a5,80008060 <acquire+0xb4>
    80007fe8:	fffff097          	auipc	ra,0xfffff
    80007fec:	8d4080e7          	jalr	-1836(ra) # 800068bc <mycpu>
    80007ff0:	07852783          	lw	a5,120(a0)
    80007ff4:	0004a703          	lw	a4,0(s1)
    80007ff8:	0017879b          	addiw	a5,a5,1
    80007ffc:	06f52c23          	sw	a5,120(a0)
    80008000:	04071063          	bnez	a4,80008040 <acquire+0x94>
    80008004:	00100713          	li	a4,1
    80008008:	00070793          	mv	a5,a4
    8000800c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008010:	0007879b          	sext.w	a5,a5
    80008014:	fe079ae3          	bnez	a5,80008008 <acquire+0x5c>
    80008018:	0ff0000f          	fence
    8000801c:	fffff097          	auipc	ra,0xfffff
    80008020:	8a0080e7          	jalr	-1888(ra) # 800068bc <mycpu>
    80008024:	01813083          	ld	ra,24(sp)
    80008028:	01013403          	ld	s0,16(sp)
    8000802c:	00a4b823          	sd	a0,16(s1)
    80008030:	00013903          	ld	s2,0(sp)
    80008034:	00813483          	ld	s1,8(sp)
    80008038:	02010113          	addi	sp,sp,32
    8000803c:	00008067          	ret
    80008040:	0104b903          	ld	s2,16(s1)
    80008044:	fffff097          	auipc	ra,0xfffff
    80008048:	878080e7          	jalr	-1928(ra) # 800068bc <mycpu>
    8000804c:	faa91ce3          	bne	s2,a0,80008004 <acquire+0x58>
    80008050:	00001517          	auipc	a0,0x1
    80008054:	6d850513          	addi	a0,a0,1752 # 80009728 <digits+0x20>
    80008058:	fffff097          	auipc	ra,0xfffff
    8000805c:	224080e7          	jalr	548(ra) # 8000727c <panic>
    80008060:	00195913          	srli	s2,s2,0x1
    80008064:	fffff097          	auipc	ra,0xfffff
    80008068:	858080e7          	jalr	-1960(ra) # 800068bc <mycpu>
    8000806c:	00197913          	andi	s2,s2,1
    80008070:	07252e23          	sw	s2,124(a0)
    80008074:	f75ff06f          	j	80007fe8 <acquire+0x3c>

0000000080008078 <release>:
    80008078:	fe010113          	addi	sp,sp,-32
    8000807c:	00813823          	sd	s0,16(sp)
    80008080:	00113c23          	sd	ra,24(sp)
    80008084:	00913423          	sd	s1,8(sp)
    80008088:	01213023          	sd	s2,0(sp)
    8000808c:	02010413          	addi	s0,sp,32
    80008090:	00052783          	lw	a5,0(a0)
    80008094:	00079a63          	bnez	a5,800080a8 <release+0x30>
    80008098:	00001517          	auipc	a0,0x1
    8000809c:	69850513          	addi	a0,a0,1688 # 80009730 <digits+0x28>
    800080a0:	fffff097          	auipc	ra,0xfffff
    800080a4:	1dc080e7          	jalr	476(ra) # 8000727c <panic>
    800080a8:	01053903          	ld	s2,16(a0)
    800080ac:	00050493          	mv	s1,a0
    800080b0:	fffff097          	auipc	ra,0xfffff
    800080b4:	80c080e7          	jalr	-2036(ra) # 800068bc <mycpu>
    800080b8:	fea910e3          	bne	s2,a0,80008098 <release+0x20>
    800080bc:	0004b823          	sd	zero,16(s1)
    800080c0:	0ff0000f          	fence
    800080c4:	0f50000f          	fence	iorw,ow
    800080c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800080cc:	ffffe097          	auipc	ra,0xffffe
    800080d0:	7f0080e7          	jalr	2032(ra) # 800068bc <mycpu>
    800080d4:	100027f3          	csrr	a5,sstatus
    800080d8:	0027f793          	andi	a5,a5,2
    800080dc:	04079a63          	bnez	a5,80008130 <release+0xb8>
    800080e0:	07852783          	lw	a5,120(a0)
    800080e4:	02f05e63          	blez	a5,80008120 <release+0xa8>
    800080e8:	fff7871b          	addiw	a4,a5,-1
    800080ec:	06e52c23          	sw	a4,120(a0)
    800080f0:	00071c63          	bnez	a4,80008108 <release+0x90>
    800080f4:	07c52783          	lw	a5,124(a0)
    800080f8:	00078863          	beqz	a5,80008108 <release+0x90>
    800080fc:	100027f3          	csrr	a5,sstatus
    80008100:	0027e793          	ori	a5,a5,2
    80008104:	10079073          	csrw	sstatus,a5
    80008108:	01813083          	ld	ra,24(sp)
    8000810c:	01013403          	ld	s0,16(sp)
    80008110:	00813483          	ld	s1,8(sp)
    80008114:	00013903          	ld	s2,0(sp)
    80008118:	02010113          	addi	sp,sp,32
    8000811c:	00008067          	ret
    80008120:	00001517          	auipc	a0,0x1
    80008124:	63050513          	addi	a0,a0,1584 # 80009750 <digits+0x48>
    80008128:	fffff097          	auipc	ra,0xfffff
    8000812c:	154080e7          	jalr	340(ra) # 8000727c <panic>
    80008130:	00001517          	auipc	a0,0x1
    80008134:	60850513          	addi	a0,a0,1544 # 80009738 <digits+0x30>
    80008138:	fffff097          	auipc	ra,0xfffff
    8000813c:	144080e7          	jalr	324(ra) # 8000727c <panic>

0000000080008140 <holding>:
    80008140:	00052783          	lw	a5,0(a0)
    80008144:	00079663          	bnez	a5,80008150 <holding+0x10>
    80008148:	00000513          	li	a0,0
    8000814c:	00008067          	ret
    80008150:	fe010113          	addi	sp,sp,-32
    80008154:	00813823          	sd	s0,16(sp)
    80008158:	00913423          	sd	s1,8(sp)
    8000815c:	00113c23          	sd	ra,24(sp)
    80008160:	02010413          	addi	s0,sp,32
    80008164:	01053483          	ld	s1,16(a0)
    80008168:	ffffe097          	auipc	ra,0xffffe
    8000816c:	754080e7          	jalr	1876(ra) # 800068bc <mycpu>
    80008170:	01813083          	ld	ra,24(sp)
    80008174:	01013403          	ld	s0,16(sp)
    80008178:	40a48533          	sub	a0,s1,a0
    8000817c:	00153513          	seqz	a0,a0
    80008180:	00813483          	ld	s1,8(sp)
    80008184:	02010113          	addi	sp,sp,32
    80008188:	00008067          	ret

000000008000818c <push_off>:
    8000818c:	fe010113          	addi	sp,sp,-32
    80008190:	00813823          	sd	s0,16(sp)
    80008194:	00113c23          	sd	ra,24(sp)
    80008198:	00913423          	sd	s1,8(sp)
    8000819c:	02010413          	addi	s0,sp,32
    800081a0:	100024f3          	csrr	s1,sstatus
    800081a4:	100027f3          	csrr	a5,sstatus
    800081a8:	ffd7f793          	andi	a5,a5,-3
    800081ac:	10079073          	csrw	sstatus,a5
    800081b0:	ffffe097          	auipc	ra,0xffffe
    800081b4:	70c080e7          	jalr	1804(ra) # 800068bc <mycpu>
    800081b8:	07852783          	lw	a5,120(a0)
    800081bc:	02078663          	beqz	a5,800081e8 <push_off+0x5c>
    800081c0:	ffffe097          	auipc	ra,0xffffe
    800081c4:	6fc080e7          	jalr	1788(ra) # 800068bc <mycpu>
    800081c8:	07852783          	lw	a5,120(a0)
    800081cc:	01813083          	ld	ra,24(sp)
    800081d0:	01013403          	ld	s0,16(sp)
    800081d4:	0017879b          	addiw	a5,a5,1
    800081d8:	06f52c23          	sw	a5,120(a0)
    800081dc:	00813483          	ld	s1,8(sp)
    800081e0:	02010113          	addi	sp,sp,32
    800081e4:	00008067          	ret
    800081e8:	0014d493          	srli	s1,s1,0x1
    800081ec:	ffffe097          	auipc	ra,0xffffe
    800081f0:	6d0080e7          	jalr	1744(ra) # 800068bc <mycpu>
    800081f4:	0014f493          	andi	s1,s1,1
    800081f8:	06952e23          	sw	s1,124(a0)
    800081fc:	fc5ff06f          	j	800081c0 <push_off+0x34>

0000000080008200 <pop_off>:
    80008200:	ff010113          	addi	sp,sp,-16
    80008204:	00813023          	sd	s0,0(sp)
    80008208:	00113423          	sd	ra,8(sp)
    8000820c:	01010413          	addi	s0,sp,16
    80008210:	ffffe097          	auipc	ra,0xffffe
    80008214:	6ac080e7          	jalr	1708(ra) # 800068bc <mycpu>
    80008218:	100027f3          	csrr	a5,sstatus
    8000821c:	0027f793          	andi	a5,a5,2
    80008220:	04079663          	bnez	a5,8000826c <pop_off+0x6c>
    80008224:	07852783          	lw	a5,120(a0)
    80008228:	02f05a63          	blez	a5,8000825c <pop_off+0x5c>
    8000822c:	fff7871b          	addiw	a4,a5,-1
    80008230:	06e52c23          	sw	a4,120(a0)
    80008234:	00071c63          	bnez	a4,8000824c <pop_off+0x4c>
    80008238:	07c52783          	lw	a5,124(a0)
    8000823c:	00078863          	beqz	a5,8000824c <pop_off+0x4c>
    80008240:	100027f3          	csrr	a5,sstatus
    80008244:	0027e793          	ori	a5,a5,2
    80008248:	10079073          	csrw	sstatus,a5
    8000824c:	00813083          	ld	ra,8(sp)
    80008250:	00013403          	ld	s0,0(sp)
    80008254:	01010113          	addi	sp,sp,16
    80008258:	00008067          	ret
    8000825c:	00001517          	auipc	a0,0x1
    80008260:	4f450513          	addi	a0,a0,1268 # 80009750 <digits+0x48>
    80008264:	fffff097          	auipc	ra,0xfffff
    80008268:	018080e7          	jalr	24(ra) # 8000727c <panic>
    8000826c:	00001517          	auipc	a0,0x1
    80008270:	4cc50513          	addi	a0,a0,1228 # 80009738 <digits+0x30>
    80008274:	fffff097          	auipc	ra,0xfffff
    80008278:	008080e7          	jalr	8(ra) # 8000727c <panic>

000000008000827c <push_on>:
    8000827c:	fe010113          	addi	sp,sp,-32
    80008280:	00813823          	sd	s0,16(sp)
    80008284:	00113c23          	sd	ra,24(sp)
    80008288:	00913423          	sd	s1,8(sp)
    8000828c:	02010413          	addi	s0,sp,32
    80008290:	100024f3          	csrr	s1,sstatus
    80008294:	100027f3          	csrr	a5,sstatus
    80008298:	0027e793          	ori	a5,a5,2
    8000829c:	10079073          	csrw	sstatus,a5
    800082a0:	ffffe097          	auipc	ra,0xffffe
    800082a4:	61c080e7          	jalr	1564(ra) # 800068bc <mycpu>
    800082a8:	07852783          	lw	a5,120(a0)
    800082ac:	02078663          	beqz	a5,800082d8 <push_on+0x5c>
    800082b0:	ffffe097          	auipc	ra,0xffffe
    800082b4:	60c080e7          	jalr	1548(ra) # 800068bc <mycpu>
    800082b8:	07852783          	lw	a5,120(a0)
    800082bc:	01813083          	ld	ra,24(sp)
    800082c0:	01013403          	ld	s0,16(sp)
    800082c4:	0017879b          	addiw	a5,a5,1
    800082c8:	06f52c23          	sw	a5,120(a0)
    800082cc:	00813483          	ld	s1,8(sp)
    800082d0:	02010113          	addi	sp,sp,32
    800082d4:	00008067          	ret
    800082d8:	0014d493          	srli	s1,s1,0x1
    800082dc:	ffffe097          	auipc	ra,0xffffe
    800082e0:	5e0080e7          	jalr	1504(ra) # 800068bc <mycpu>
    800082e4:	0014f493          	andi	s1,s1,1
    800082e8:	06952e23          	sw	s1,124(a0)
    800082ec:	fc5ff06f          	j	800082b0 <push_on+0x34>

00000000800082f0 <pop_on>:
    800082f0:	ff010113          	addi	sp,sp,-16
    800082f4:	00813023          	sd	s0,0(sp)
    800082f8:	00113423          	sd	ra,8(sp)
    800082fc:	01010413          	addi	s0,sp,16
    80008300:	ffffe097          	auipc	ra,0xffffe
    80008304:	5bc080e7          	jalr	1468(ra) # 800068bc <mycpu>
    80008308:	100027f3          	csrr	a5,sstatus
    8000830c:	0027f793          	andi	a5,a5,2
    80008310:	04078463          	beqz	a5,80008358 <pop_on+0x68>
    80008314:	07852783          	lw	a5,120(a0)
    80008318:	02f05863          	blez	a5,80008348 <pop_on+0x58>
    8000831c:	fff7879b          	addiw	a5,a5,-1
    80008320:	06f52c23          	sw	a5,120(a0)
    80008324:	07853783          	ld	a5,120(a0)
    80008328:	00079863          	bnez	a5,80008338 <pop_on+0x48>
    8000832c:	100027f3          	csrr	a5,sstatus
    80008330:	ffd7f793          	andi	a5,a5,-3
    80008334:	10079073          	csrw	sstatus,a5
    80008338:	00813083          	ld	ra,8(sp)
    8000833c:	00013403          	ld	s0,0(sp)
    80008340:	01010113          	addi	sp,sp,16
    80008344:	00008067          	ret
    80008348:	00001517          	auipc	a0,0x1
    8000834c:	43050513          	addi	a0,a0,1072 # 80009778 <digits+0x70>
    80008350:	fffff097          	auipc	ra,0xfffff
    80008354:	f2c080e7          	jalr	-212(ra) # 8000727c <panic>
    80008358:	00001517          	auipc	a0,0x1
    8000835c:	40050513          	addi	a0,a0,1024 # 80009758 <digits+0x50>
    80008360:	fffff097          	auipc	ra,0xfffff
    80008364:	f1c080e7          	jalr	-228(ra) # 8000727c <panic>

0000000080008368 <__memset>:
    80008368:	ff010113          	addi	sp,sp,-16
    8000836c:	00813423          	sd	s0,8(sp)
    80008370:	01010413          	addi	s0,sp,16
    80008374:	1a060e63          	beqz	a2,80008530 <__memset+0x1c8>
    80008378:	40a007b3          	neg	a5,a0
    8000837c:	0077f793          	andi	a5,a5,7
    80008380:	00778693          	addi	a3,a5,7
    80008384:	00b00813          	li	a6,11
    80008388:	0ff5f593          	andi	a1,a1,255
    8000838c:	fff6071b          	addiw	a4,a2,-1
    80008390:	1b06e663          	bltu	a3,a6,8000853c <__memset+0x1d4>
    80008394:	1cd76463          	bltu	a4,a3,8000855c <__memset+0x1f4>
    80008398:	1a078e63          	beqz	a5,80008554 <__memset+0x1ec>
    8000839c:	00b50023          	sb	a1,0(a0)
    800083a0:	00100713          	li	a4,1
    800083a4:	1ae78463          	beq	a5,a4,8000854c <__memset+0x1e4>
    800083a8:	00b500a3          	sb	a1,1(a0)
    800083ac:	00200713          	li	a4,2
    800083b0:	1ae78a63          	beq	a5,a4,80008564 <__memset+0x1fc>
    800083b4:	00b50123          	sb	a1,2(a0)
    800083b8:	00300713          	li	a4,3
    800083bc:	18e78463          	beq	a5,a4,80008544 <__memset+0x1dc>
    800083c0:	00b501a3          	sb	a1,3(a0)
    800083c4:	00400713          	li	a4,4
    800083c8:	1ae78263          	beq	a5,a4,8000856c <__memset+0x204>
    800083cc:	00b50223          	sb	a1,4(a0)
    800083d0:	00500713          	li	a4,5
    800083d4:	1ae78063          	beq	a5,a4,80008574 <__memset+0x20c>
    800083d8:	00b502a3          	sb	a1,5(a0)
    800083dc:	00700713          	li	a4,7
    800083e0:	18e79e63          	bne	a5,a4,8000857c <__memset+0x214>
    800083e4:	00b50323          	sb	a1,6(a0)
    800083e8:	00700e93          	li	t4,7
    800083ec:	00859713          	slli	a4,a1,0x8
    800083f0:	00e5e733          	or	a4,a1,a4
    800083f4:	01059e13          	slli	t3,a1,0x10
    800083f8:	01c76e33          	or	t3,a4,t3
    800083fc:	01859313          	slli	t1,a1,0x18
    80008400:	006e6333          	or	t1,t3,t1
    80008404:	02059893          	slli	a7,a1,0x20
    80008408:	40f60e3b          	subw	t3,a2,a5
    8000840c:	011368b3          	or	a7,t1,a7
    80008410:	02859813          	slli	a6,a1,0x28
    80008414:	0108e833          	or	a6,a7,a6
    80008418:	03059693          	slli	a3,a1,0x30
    8000841c:	003e589b          	srliw	a7,t3,0x3
    80008420:	00d866b3          	or	a3,a6,a3
    80008424:	03859713          	slli	a4,a1,0x38
    80008428:	00389813          	slli	a6,a7,0x3
    8000842c:	00f507b3          	add	a5,a0,a5
    80008430:	00e6e733          	or	a4,a3,a4
    80008434:	000e089b          	sext.w	a7,t3
    80008438:	00f806b3          	add	a3,a6,a5
    8000843c:	00e7b023          	sd	a4,0(a5)
    80008440:	00878793          	addi	a5,a5,8
    80008444:	fed79ce3          	bne	a5,a3,8000843c <__memset+0xd4>
    80008448:	ff8e7793          	andi	a5,t3,-8
    8000844c:	0007871b          	sext.w	a4,a5
    80008450:	01d787bb          	addw	a5,a5,t4
    80008454:	0ce88e63          	beq	a7,a4,80008530 <__memset+0x1c8>
    80008458:	00f50733          	add	a4,a0,a5
    8000845c:	00b70023          	sb	a1,0(a4)
    80008460:	0017871b          	addiw	a4,a5,1
    80008464:	0cc77663          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    80008468:	00e50733          	add	a4,a0,a4
    8000846c:	00b70023          	sb	a1,0(a4)
    80008470:	0027871b          	addiw	a4,a5,2
    80008474:	0ac77e63          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    80008478:	00e50733          	add	a4,a0,a4
    8000847c:	00b70023          	sb	a1,0(a4)
    80008480:	0037871b          	addiw	a4,a5,3
    80008484:	0ac77663          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    80008488:	00e50733          	add	a4,a0,a4
    8000848c:	00b70023          	sb	a1,0(a4)
    80008490:	0047871b          	addiw	a4,a5,4
    80008494:	08c77e63          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    80008498:	00e50733          	add	a4,a0,a4
    8000849c:	00b70023          	sb	a1,0(a4)
    800084a0:	0057871b          	addiw	a4,a5,5
    800084a4:	08c77663          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    800084a8:	00e50733          	add	a4,a0,a4
    800084ac:	00b70023          	sb	a1,0(a4)
    800084b0:	0067871b          	addiw	a4,a5,6
    800084b4:	06c77e63          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    800084b8:	00e50733          	add	a4,a0,a4
    800084bc:	00b70023          	sb	a1,0(a4)
    800084c0:	0077871b          	addiw	a4,a5,7
    800084c4:	06c77663          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    800084c8:	00e50733          	add	a4,a0,a4
    800084cc:	00b70023          	sb	a1,0(a4)
    800084d0:	0087871b          	addiw	a4,a5,8
    800084d4:	04c77e63          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    800084d8:	00e50733          	add	a4,a0,a4
    800084dc:	00b70023          	sb	a1,0(a4)
    800084e0:	0097871b          	addiw	a4,a5,9
    800084e4:	04c77663          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    800084e8:	00e50733          	add	a4,a0,a4
    800084ec:	00b70023          	sb	a1,0(a4)
    800084f0:	00a7871b          	addiw	a4,a5,10
    800084f4:	02c77e63          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    800084f8:	00e50733          	add	a4,a0,a4
    800084fc:	00b70023          	sb	a1,0(a4)
    80008500:	00b7871b          	addiw	a4,a5,11
    80008504:	02c77663          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    80008508:	00e50733          	add	a4,a0,a4
    8000850c:	00b70023          	sb	a1,0(a4)
    80008510:	00c7871b          	addiw	a4,a5,12
    80008514:	00c77e63          	bgeu	a4,a2,80008530 <__memset+0x1c8>
    80008518:	00e50733          	add	a4,a0,a4
    8000851c:	00b70023          	sb	a1,0(a4)
    80008520:	00d7879b          	addiw	a5,a5,13
    80008524:	00c7f663          	bgeu	a5,a2,80008530 <__memset+0x1c8>
    80008528:	00f507b3          	add	a5,a0,a5
    8000852c:	00b78023          	sb	a1,0(a5)
    80008530:	00813403          	ld	s0,8(sp)
    80008534:	01010113          	addi	sp,sp,16
    80008538:	00008067          	ret
    8000853c:	00b00693          	li	a3,11
    80008540:	e55ff06f          	j	80008394 <__memset+0x2c>
    80008544:	00300e93          	li	t4,3
    80008548:	ea5ff06f          	j	800083ec <__memset+0x84>
    8000854c:	00100e93          	li	t4,1
    80008550:	e9dff06f          	j	800083ec <__memset+0x84>
    80008554:	00000e93          	li	t4,0
    80008558:	e95ff06f          	j	800083ec <__memset+0x84>
    8000855c:	00000793          	li	a5,0
    80008560:	ef9ff06f          	j	80008458 <__memset+0xf0>
    80008564:	00200e93          	li	t4,2
    80008568:	e85ff06f          	j	800083ec <__memset+0x84>
    8000856c:	00400e93          	li	t4,4
    80008570:	e7dff06f          	j	800083ec <__memset+0x84>
    80008574:	00500e93          	li	t4,5
    80008578:	e75ff06f          	j	800083ec <__memset+0x84>
    8000857c:	00600e93          	li	t4,6
    80008580:	e6dff06f          	j	800083ec <__memset+0x84>

0000000080008584 <__memmove>:
    80008584:	ff010113          	addi	sp,sp,-16
    80008588:	00813423          	sd	s0,8(sp)
    8000858c:	01010413          	addi	s0,sp,16
    80008590:	0e060863          	beqz	a2,80008680 <__memmove+0xfc>
    80008594:	fff6069b          	addiw	a3,a2,-1
    80008598:	0006881b          	sext.w	a6,a3
    8000859c:	0ea5e863          	bltu	a1,a0,8000868c <__memmove+0x108>
    800085a0:	00758713          	addi	a4,a1,7
    800085a4:	00a5e7b3          	or	a5,a1,a0
    800085a8:	40a70733          	sub	a4,a4,a0
    800085ac:	0077f793          	andi	a5,a5,7
    800085b0:	00f73713          	sltiu	a4,a4,15
    800085b4:	00174713          	xori	a4,a4,1
    800085b8:	0017b793          	seqz	a5,a5
    800085bc:	00e7f7b3          	and	a5,a5,a4
    800085c0:	10078863          	beqz	a5,800086d0 <__memmove+0x14c>
    800085c4:	00900793          	li	a5,9
    800085c8:	1107f463          	bgeu	a5,a6,800086d0 <__memmove+0x14c>
    800085cc:	0036581b          	srliw	a6,a2,0x3
    800085d0:	fff8081b          	addiw	a6,a6,-1
    800085d4:	02081813          	slli	a6,a6,0x20
    800085d8:	01d85893          	srli	a7,a6,0x1d
    800085dc:	00858813          	addi	a6,a1,8
    800085e0:	00058793          	mv	a5,a1
    800085e4:	00050713          	mv	a4,a0
    800085e8:	01088833          	add	a6,a7,a6
    800085ec:	0007b883          	ld	a7,0(a5)
    800085f0:	00878793          	addi	a5,a5,8
    800085f4:	00870713          	addi	a4,a4,8
    800085f8:	ff173c23          	sd	a7,-8(a4)
    800085fc:	ff0798e3          	bne	a5,a6,800085ec <__memmove+0x68>
    80008600:	ff867713          	andi	a4,a2,-8
    80008604:	02071793          	slli	a5,a4,0x20
    80008608:	0207d793          	srli	a5,a5,0x20
    8000860c:	00f585b3          	add	a1,a1,a5
    80008610:	40e686bb          	subw	a3,a3,a4
    80008614:	00f507b3          	add	a5,a0,a5
    80008618:	06e60463          	beq	a2,a4,80008680 <__memmove+0xfc>
    8000861c:	0005c703          	lbu	a4,0(a1)
    80008620:	00e78023          	sb	a4,0(a5)
    80008624:	04068e63          	beqz	a3,80008680 <__memmove+0xfc>
    80008628:	0015c603          	lbu	a2,1(a1)
    8000862c:	00100713          	li	a4,1
    80008630:	00c780a3          	sb	a2,1(a5)
    80008634:	04e68663          	beq	a3,a4,80008680 <__memmove+0xfc>
    80008638:	0025c603          	lbu	a2,2(a1)
    8000863c:	00200713          	li	a4,2
    80008640:	00c78123          	sb	a2,2(a5)
    80008644:	02e68e63          	beq	a3,a4,80008680 <__memmove+0xfc>
    80008648:	0035c603          	lbu	a2,3(a1)
    8000864c:	00300713          	li	a4,3
    80008650:	00c781a3          	sb	a2,3(a5)
    80008654:	02e68663          	beq	a3,a4,80008680 <__memmove+0xfc>
    80008658:	0045c603          	lbu	a2,4(a1)
    8000865c:	00400713          	li	a4,4
    80008660:	00c78223          	sb	a2,4(a5)
    80008664:	00e68e63          	beq	a3,a4,80008680 <__memmove+0xfc>
    80008668:	0055c603          	lbu	a2,5(a1)
    8000866c:	00500713          	li	a4,5
    80008670:	00c782a3          	sb	a2,5(a5)
    80008674:	00e68663          	beq	a3,a4,80008680 <__memmove+0xfc>
    80008678:	0065c703          	lbu	a4,6(a1)
    8000867c:	00e78323          	sb	a4,6(a5)
    80008680:	00813403          	ld	s0,8(sp)
    80008684:	01010113          	addi	sp,sp,16
    80008688:	00008067          	ret
    8000868c:	02061713          	slli	a4,a2,0x20
    80008690:	02075713          	srli	a4,a4,0x20
    80008694:	00e587b3          	add	a5,a1,a4
    80008698:	f0f574e3          	bgeu	a0,a5,800085a0 <__memmove+0x1c>
    8000869c:	02069613          	slli	a2,a3,0x20
    800086a0:	02065613          	srli	a2,a2,0x20
    800086a4:	fff64613          	not	a2,a2
    800086a8:	00e50733          	add	a4,a0,a4
    800086ac:	00c78633          	add	a2,a5,a2
    800086b0:	fff7c683          	lbu	a3,-1(a5)
    800086b4:	fff78793          	addi	a5,a5,-1
    800086b8:	fff70713          	addi	a4,a4,-1
    800086bc:	00d70023          	sb	a3,0(a4)
    800086c0:	fec798e3          	bne	a5,a2,800086b0 <__memmove+0x12c>
    800086c4:	00813403          	ld	s0,8(sp)
    800086c8:	01010113          	addi	sp,sp,16
    800086cc:	00008067          	ret
    800086d0:	02069713          	slli	a4,a3,0x20
    800086d4:	02075713          	srli	a4,a4,0x20
    800086d8:	00170713          	addi	a4,a4,1
    800086dc:	00e50733          	add	a4,a0,a4
    800086e0:	00050793          	mv	a5,a0
    800086e4:	0005c683          	lbu	a3,0(a1)
    800086e8:	00178793          	addi	a5,a5,1
    800086ec:	00158593          	addi	a1,a1,1
    800086f0:	fed78fa3          	sb	a3,-1(a5)
    800086f4:	fee798e3          	bne	a5,a4,800086e4 <__memmove+0x160>
    800086f8:	f89ff06f          	j	80008680 <__memmove+0xfc>
	...
