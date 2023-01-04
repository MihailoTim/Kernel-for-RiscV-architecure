
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	f1013103          	ld	sp,-240(sp) # 8000bf10 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3ad060ef          	jal	ra,80006bc8 <start>

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
    800010a8:	049030ef          	jal	ra,800048f0 <_ZN5RiscV20handleSupervisorTrapEv>

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

0000000080001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    80001154:	fe010113          	addi	sp,sp,-32
    80001158:	00113c23          	sd	ra,24(sp)
    8000115c:	00813823          	sd	s0,16(sp)
    80001160:	00913423          	sd	s1,8(sp)
    80001164:	01213023          	sd	s2,0(sp)
    80001168:	02010413          	addi	s0,sp,32
    8000116c:	00050493          	mv	s1,a0
    int ret = 0;
    80001170:	00000913          	li	s2,0
    while(cache->emptyHead){
    80001174:	0604b503          	ld	a0,96(s1)
    80001178:	02050463          	beqz	a0,800011a0 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x4c>
        Buddy::free(cache->emptyHead, cache->slabSize);
    8000117c:	0484b583          	ld	a1,72(s1)
    80001180:	00001097          	auipc	ra,0x1
    80001184:	748080e7          	jalr	1864(ra) # 800028c8 <_ZN5Buddy4freeEPvm>
        ret += cache->emptyHead->totalNumOfSlots;
    80001188:	0604b783          	ld	a5,96(s1)
    8000118c:	0187b703          	ld	a4,24(a5)
    80001190:	0127093b          	addw	s2,a4,s2
        cache->emptyHead = cache->emptyHead->next;
    80001194:	0087b783          	ld	a5,8(a5)
    80001198:	06f4b023          	sd	a5,96(s1)
    while(cache->emptyHead){
    8000119c:	fd9ff06f          	j	80001174 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x20>
    }
    return ret;
}
    800011a0:	00090513          	mv	a0,s2
    800011a4:	01813083          	ld	ra,24(sp)
    800011a8:	01013403          	ld	s0,16(sp)
    800011ac:	00813483          	ld	s1,8(sp)
    800011b0:	00013903          	ld	s2,0(sp)
    800011b4:	02010113          	addi	sp,sp,32
    800011b8:	00008067          	ret

00000000800011bc <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    800011bc:	14050063          	beqz	a0,800012fc <_ZN13SlabAllocator9printSlabEP4Slab+0x140>
void SlabAllocator::printSlab(Slab *slab) {
    800011c0:	fe010113          	addi	sp,sp,-32
    800011c4:	00113c23          	sd	ra,24(sp)
    800011c8:	00813823          	sd	s0,16(sp)
    800011cc:	00913423          	sd	s1,8(sp)
    800011d0:	01213023          	sd	s2,0(sp)
    800011d4:	02010413          	addi	s0,sp,32
    800011d8:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800011dc:	00008617          	auipc	a2,0x8
    800011e0:	1bc60613          	addi	a2,a2,444 # 80009398 <CONSOLE_STATUS+0x388>
    800011e4:	0005059b          	sext.w	a1,a0
    800011e8:	00008517          	auipc	a0,0x8
    800011ec:	e3850513          	addi	a0,a0,-456 # 80009020 <CONSOLE_STATUS+0x10>
    800011f0:	00004097          	auipc	ra,0x4
    800011f4:	1c4080e7          	jalr	452(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011f8:	00008617          	auipc	a2,0x8
    800011fc:	1a060613          	addi	a2,a2,416 # 80009398 <CONSOLE_STATUS+0x388>
    80001200:	01892583          	lw	a1,24(s2)
    80001204:	00008517          	auipc	a0,0x8
    80001208:	e2c50513          	addi	a0,a0,-468 # 80009030 <CONSOLE_STATUS+0x20>
    8000120c:	00004097          	auipc	ra,0x4
    80001210:	1a8080e7          	jalr	424(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    80001214:	00008617          	auipc	a2,0x8
    80001218:	18460613          	addi	a2,a2,388 # 80009398 <CONSOLE_STATUS+0x388>
    8000121c:	01092583          	lw	a1,16(s2)
    80001220:	00008517          	auipc	a0,0x8
    80001224:	e2850513          	addi	a0,a0,-472 # 80009048 <CONSOLE_STATUS+0x38>
    80001228:	00004097          	auipc	ra,0x4
    8000122c:	18c080e7          	jalr	396(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    80001230:	00008617          	auipc	a2,0x8
    80001234:	16860613          	addi	a2,a2,360 # 80009398 <CONSOLE_STATUS+0x388>
    80001238:	03800593          	li	a1,56
    8000123c:	00008517          	auipc	a0,0x8
    80001240:	e2450513          	addi	a0,a0,-476 # 80009060 <CONSOLE_STATUS+0x50>
    80001244:	00004097          	auipc	ra,0x4
    80001248:	170080e7          	jalr	368(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000124c:	00008617          	auipc	a2,0x8
    80001250:	14c60613          	addi	a2,a2,332 # 80009398 <CONSOLE_STATUS+0x388>
    80001254:	02892583          	lw	a1,40(s2)
    80001258:	00008517          	auipc	a0,0x8
    8000125c:	e2050513          	addi	a0,a0,-480 # 80009078 <CONSOLE_STATUS+0x68>
    80001260:	00004097          	auipc	ra,0x4
    80001264:	154080e7          	jalr	340(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    80001268:	00008617          	auipc	a2,0x8
    8000126c:	13060613          	addi	a2,a2,304 # 80009398 <CONSOLE_STATUS+0x388>
    80001270:	02092583          	lw	a1,32(s2)
    80001274:	00008517          	auipc	a0,0x8
    80001278:	e1450513          	addi	a0,a0,-492 # 80009088 <CONSOLE_STATUS+0x78>
    8000127c:	00004097          	auipc	ra,0x4
    80001280:	138080e7          	jalr	312(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::printString("Allocated status array:\n");
    80001284:	00008517          	auipc	a0,0x8
    80001288:	e2450513          	addi	a0,a0,-476 # 800090a8 <CONSOLE_STATUS+0x98>
    8000128c:	00004097          	auipc	ra,0x4
    80001290:	008080e7          	jalr	8(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    80001294:	00000493          	li	s1,0
    80001298:	02c0006f          	j	800012c4 <_ZN13SlabAllocator9printSlabEP4Slab+0x108>
            ConsoleUtil::print("", slab->allocated[i], " ");
    8000129c:	02093783          	ld	a5,32(s2)
    800012a0:	009787b3          	add	a5,a5,s1
    800012a4:	00008617          	auipc	a2,0x8
    800012a8:	e4460613          	addi	a2,a2,-444 # 800090e8 <CONSOLE_STATUS+0xd8>
    800012ac:	0007c583          	lbu	a1,0(a5)
    800012b0:	00008517          	auipc	a0,0x8
    800012b4:	12850513          	addi	a0,a0,296 # 800093d8 <CONSOLE_STATUS+0x3c8>
    800012b8:	00004097          	auipc	ra,0x4
    800012bc:	0fc080e7          	jalr	252(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012c0:	00148493          	addi	s1,s1,1
    800012c4:	01893783          	ld	a5,24(s2)
    800012c8:	0037d793          	srli	a5,a5,0x3
    800012cc:	00178793          	addi	a5,a5,1
    800012d0:	fcf4e6e3          	bltu	s1,a5,8000129c <_ZN13SlabAllocator9printSlabEP4Slab+0xe0>
        }
        ConsoleUtil::printString("\n");
    800012d4:	00008517          	auipc	a0,0x8
    800012d8:	0c450513          	addi	a0,a0,196 # 80009398 <CONSOLE_STATUS+0x388>
    800012dc:	00004097          	auipc	ra,0x4
    800012e0:	fb8080e7          	jalr	-72(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800012e4:	01813083          	ld	ra,24(sp)
    800012e8:	01013403          	ld	s0,16(sp)
    800012ec:	00813483          	ld	s1,8(sp)
    800012f0:	00013903          	ld	s2,0(sp)
    800012f4:	02010113          	addi	sp,sp,32
    800012f8:	00008067          	ret
    800012fc:	00008067          	ret

0000000080001300 <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    80001300:	fe010113          	addi	sp,sp,-32
    80001304:	00113c23          	sd	ra,24(sp)
    80001308:	00813823          	sd	s0,16(sp)
    8000130c:	00913423          	sd	s1,8(sp)
    80001310:	01213023          	sd	s2,0(sp)
    80001314:	02010413          	addi	s0,sp,32
    80001318:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    8000131c:	00008517          	auipc	a0,0x8
    80001320:	dac50513          	addi	a0,a0,-596 # 800090c8 <CONSOLE_STATUS+0xb8>
    80001324:	00004097          	auipc	ra,0x4
    80001328:	f70080e7          	jalr	-144(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    8000132c:	00090513          	mv	a0,s2
    80001330:	00004097          	auipc	ra,0x4
    80001334:	f64080e7          	jalr	-156(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001338:	00008517          	auipc	a0,0x8
    8000133c:	06050513          	addi	a0,a0,96 # 80009398 <CONSOLE_STATUS+0x388>
    80001340:	00004097          	auipc	ra,0x4
    80001344:	f54080e7          	jalr	-172(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001348:	00008617          	auipc	a2,0x8
    8000134c:	05060613          	addi	a2,a2,80 # 80009398 <CONSOLE_STATUS+0x388>
    80001350:	0000b797          	auipc	a5,0xb
    80001354:	b907b783          	ld	a5,-1136(a5) # 8000bee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001358:	0007a583          	lw	a1,0(a5)
    8000135c:	00008517          	auipc	a0,0x8
    80001360:	d7c50513          	addi	a0,a0,-644 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001364:	00004097          	auipc	ra,0x4
    80001368:	050080e7          	jalr	80(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	00008617          	auipc	a2,0x8
    80001370:	02c60613          	addi	a2,a2,44 # 80009398 <CONSOLE_STATUS+0x388>
    80001374:	0009059b          	sext.w	a1,s2
    80001378:	00008517          	auipc	a0,0x8
    8000137c:	d7850513          	addi	a0,a0,-648 # 800090f0 <CONSOLE_STATUS+0xe0>
    80001380:	00004097          	auipc	ra,0x4
    80001384:	034080e7          	jalr	52(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    80001388:	00008617          	auipc	a2,0x8
    8000138c:	01060613          	addi	a2,a2,16 # 80009398 <CONSOLE_STATUS+0x388>
    80001390:	04892583          	lw	a1,72(s2)
    80001394:	00008517          	auipc	a0,0x8
    80001398:	d6c50513          	addi	a0,a0,-660 # 80009100 <CONSOLE_STATUS+0xf0>
    8000139c:	00004097          	auipc	ra,0x4
    800013a0:	018080e7          	jalr	24(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013a4:	00008617          	auipc	a2,0x8
    800013a8:	ff460613          	addi	a2,a2,-12 # 80009398 <CONSOLE_STATUS+0x388>
    800013ac:	04092583          	lw	a1,64(s2)
    800013b0:	00008517          	auipc	a0,0x8
    800013b4:	d6850513          	addi	a0,a0,-664 # 80009118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	ffc080e7          	jalr	-4(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013c0:	00008617          	auipc	a2,0x8
    800013c4:	fd860613          	addi	a2,a2,-40 # 80009398 <CONSOLE_STATUS+0x388>
    800013c8:	06092583          	lw	a1,96(s2)
    800013cc:	00008517          	auipc	a0,0x8
    800013d0:	d6450513          	addi	a0,a0,-668 # 80009130 <CONSOLE_STATUS+0x120>
    800013d4:	00004097          	auipc	ra,0x4
    800013d8:	fe0080e7          	jalr	-32(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    800013dc:	06093483          	ld	s1,96(s2)
    while(iter){
    800013e0:	02048463          	beqz	s1,80001408 <_ZN13SlabAllocator10printCacheEP5Cache+0x108>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013e4:	00008617          	auipc	a2,0x8
    800013e8:	d0460613          	addi	a2,a2,-764 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013ec:	0004859b          	sext.w	a1,s1
    800013f0:	00008517          	auipc	a0,0x8
    800013f4:	fe850513          	addi	a0,a0,-24 # 800093d8 <CONSOLE_STATUS+0x3c8>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	fbc080e7          	jalr	-68(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001400:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001404:	fddff06f          	j	800013e0 <_ZN13SlabAllocator10printCacheEP5Cache+0xe0>
    }
    ConsoleUtil::printString("\n");
    80001408:	00008517          	auipc	a0,0x8
    8000140c:	f9050513          	addi	a0,a0,-112 # 80009398 <CONSOLE_STATUS+0x388>
    80001410:	00004097          	auipc	ra,0x4
    80001414:	e84080e7          	jalr	-380(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001418:	00008617          	auipc	a2,0x8
    8000141c:	f8060613          	addi	a2,a2,-128 # 80009398 <CONSOLE_STATUS+0x388>
    80001420:	06892583          	lw	a1,104(s2)
    80001424:	00008517          	auipc	a0,0x8
    80001428:	d1c50513          	addi	a0,a0,-740 # 80009140 <CONSOLE_STATUS+0x130>
    8000142c:	00004097          	auipc	ra,0x4
    80001430:	f88080e7          	jalr	-120(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    80001434:	06893483          	ld	s1,104(s2)
    while(iter){
    80001438:	02048463          	beqz	s1,80001460 <_ZN13SlabAllocator10printCacheEP5Cache+0x160>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000143c:	00008617          	auipc	a2,0x8
    80001440:	cac60613          	addi	a2,a2,-852 # 800090e8 <CONSOLE_STATUS+0xd8>
    80001444:	0004859b          	sext.w	a1,s1
    80001448:	00008517          	auipc	a0,0x8
    8000144c:	f9050513          	addi	a0,a0,-112 # 800093d8 <CONSOLE_STATUS+0x3c8>
    80001450:	00004097          	auipc	ra,0x4
    80001454:	f64080e7          	jalr	-156(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001458:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000145c:	fddff06f          	j	80001438 <_ZN13SlabAllocator10printCacheEP5Cache+0x138>
    }
    ConsoleUtil::printString("\n");
    80001460:	00008517          	auipc	a0,0x8
    80001464:	f3850513          	addi	a0,a0,-200 # 80009398 <CONSOLE_STATUS+0x388>
    80001468:	00004097          	auipc	ra,0x4
    8000146c:	e2c080e7          	jalr	-468(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001470:	00008617          	auipc	a2,0x8
    80001474:	f2860613          	addi	a2,a2,-216 # 80009398 <CONSOLE_STATUS+0x388>
    80001478:	07092583          	lw	a1,112(s2)
    8000147c:	00008517          	auipc	a0,0x8
    80001480:	cd450513          	addi	a0,a0,-812 # 80009150 <CONSOLE_STATUS+0x140>
    80001484:	00004097          	auipc	ra,0x4
    80001488:	f30080e7          	jalr	-208(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    8000148c:	07093483          	ld	s1,112(s2)
    while(iter){
    80001490:	02048463          	beqz	s1,800014b8 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001494:	00008617          	auipc	a2,0x8
    80001498:	c5460613          	addi	a2,a2,-940 # 800090e8 <CONSOLE_STATUS+0xd8>
    8000149c:	0004859b          	sext.w	a1,s1
    800014a0:	00008517          	auipc	a0,0x8
    800014a4:	f3850513          	addi	a0,a0,-200 # 800093d8 <CONSOLE_STATUS+0x3c8>
    800014a8:	00004097          	auipc	ra,0x4
    800014ac:	f0c080e7          	jalr	-244(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800014b0:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014b4:	fddff06f          	j	80001490 <_ZN13SlabAllocator10printCacheEP5Cache+0x190>
    }
    ConsoleUtil::printString("\n");
    800014b8:	00008517          	auipc	a0,0x8
    800014bc:	ee050513          	addi	a0,a0,-288 # 80009398 <CONSOLE_STATUS+0x388>
    800014c0:	00004097          	auipc	ra,0x4
    800014c4:	dd4080e7          	jalr	-556(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
}
    800014c8:	01813083          	ld	ra,24(sp)
    800014cc:	01013403          	ld	s0,16(sp)
    800014d0:	00813483          	ld	s1,8(sp)
    800014d4:	00013903          	ld	s2,0(sp)
    800014d8:	02010113          	addi	sp,sp,32
    800014dc:	00008067          	ret

00000000800014e0 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    800014e0:	ff010113          	addi	sp,sp,-16
    800014e4:	00813423          	sd	s0,8(sp)
    800014e8:	01010413          	addi	s0,sp,16
    slab->next = head;
    800014ec:	00053783          	ld	a5,0(a0)
    800014f0:	00f5b423          	sd	a5,8(a1)
    if(head)
    800014f4:	00078463          	beqz	a5,800014fc <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800014f8:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800014fc:	0005b023          	sd	zero,0(a1)
    head = slab;
    80001500:	00b53023          	sd	a1,0(a0)
}
    80001504:	00813403          	ld	s0,8(sp)
    80001508:	01010113          	addi	sp,sp,16
    8000150c:	00008067          	ret

0000000080001510 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80001510:	fd010113          	addi	sp,sp,-48
    80001514:	02113423          	sd	ra,40(sp)
    80001518:	02813023          	sd	s0,32(sp)
    8000151c:	00913c23          	sd	s1,24(sp)
    80001520:	01213823          	sd	s2,16(sp)
    80001524:	01313423          	sd	s3,8(sp)
    80001528:	03010413          	addi	s0,sp,48
    8000152c:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80001530:	04853503          	ld	a0,72(a0)
    80001534:	00001097          	auipc	ra,0x1
    80001538:	46c080e7          	jalr	1132(ra) # 800029a0 <_ZN5Buddy5allocEm>
    if(!slab)
    8000153c:	0a050863          	beqz	a0,800015ec <_ZN13SlabAllocator12allocateSlabEP5Cache+0xdc>
    80001540:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001544:	00050593          	mv	a1,a0
    80001548:	06098513          	addi	a0,s3,96
    8000154c:	00000097          	auipc	ra,0x0
    80001550:	f94080e7          	jalr	-108(ra) # 800014e0 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001554:	0489b783          	ld	a5,72(s3)
    80001558:	00c79793          	slli	a5,a5,0xc
    8000155c:	fc878793          	addi	a5,a5,-56
    80001560:	0409b703          	ld	a4,64(s3)
    80001564:	02e7d7b3          	divu	a5,a5,a4
    80001568:	00f4b823          	sd	a5,16(s1)
    8000156c:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + slab->totalNumOfSlots/8 + 1);
    80001570:	0037d793          	srli	a5,a5,0x3
    80001574:	009787b3          	add	a5,a5,s1
    80001578:	03978793          	addi	a5,a5,57
    8000157c:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (char*)((uint64)slab + sizeof(Slab));
    80001580:	03848793          	addi	a5,s1,56
    80001584:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    80001588:	0334b823          	sd	s3,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    8000158c:	00000713          	li	a4,0
    80001590:	0184b783          	ld	a5,24(s1)
    80001594:	0037d793          	srli	a5,a5,0x3
    80001598:	00178793          	addi	a5,a5,1
    8000159c:	00f77c63          	bgeu	a4,a5,800015b4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
        slab->allocated[i] = 0;
    800015a0:	0204b783          	ld	a5,32(s1)
    800015a4:	00e787b3          	add	a5,a5,a4
    800015a8:	00078023          	sb	zero,0(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015ac:	00170713          	addi	a4,a4,1
    800015b0:	fe1ff06f          	j	80001590 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x80>
    if(cache->ctor) {
    800015b4:	0509b783          	ld	a5,80(s3)
    800015b8:	02078e63          	beqz	a5,800015f4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015bc:	00000913          	li	s2,0
    800015c0:	0184b783          	ld	a5,24(s1)
    800015c4:	02f97c63          	bgeu	s2,a5,800015fc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800015c8:	0509b703          	ld	a4,80(s3)
    800015cc:	0284b503          	ld	a0,40(s1)
    800015d0:	0304b783          	ld	a5,48(s1)
    800015d4:	0407b783          	ld	a5,64(a5)
    800015d8:	032787b3          	mul	a5,a5,s2
    800015dc:	00f50533          	add	a0,a0,a5
    800015e0:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015e4:	00190913          	addi	s2,s2,1
    800015e8:	fd9ff06f          	j	800015c0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb0>
        return false;
    800015ec:	00000513          	li	a0,0
    800015f0:	0100006f          	j	80001600 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    return true;
    800015f4:	00100513          	li	a0,1
    800015f8:	0080006f          	j	80001600 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    800015fc:	00100513          	li	a0,1
}
    80001600:	02813083          	ld	ra,40(sp)
    80001604:	02013403          	ld	s0,32(sp)
    80001608:	01813483          	ld	s1,24(sp)
    8000160c:	01013903          	ld	s2,16(sp)
    80001610:	00813983          	ld	s3,8(sp)
    80001614:	03010113          	addi	sp,sp,48
    80001618:	00008067          	ret

000000008000161c <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    8000161c:	ff010113          	addi	sp,sp,-16
    80001620:	00813423          	sd	s0,8(sp)
    80001624:	01010413          	addi	s0,sp,16
    if(slab == head)
    80001628:	00053783          	ld	a5,0(a0)
    8000162c:	02b78c63          	beq	a5,a1,80001664 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001630:	0085b783          	ld	a5,8(a1)
    80001634:	00078663          	beqz	a5,80001640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80001638:	0005b703          	ld	a4,0(a1)
    8000163c:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001640:	0005b783          	ld	a5,0(a1)
    80001644:	00078663          	beqz	a5,80001650 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80001648:	0085b703          	ld	a4,8(a1)
    8000164c:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001650:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001654:	0005b423          	sd	zero,8(a1)
}
    80001658:	00813403          	ld	s0,8(sp)
    8000165c:	01010113          	addi	sp,sp,16
    80001660:	00008067          	ret
        head = slab->next;
    80001664:	0085b783          	ld	a5,8(a1)
    80001668:	00f53023          	sd	a5,0(a0)
    8000166c:	fc5ff06f          	j	80001630 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080001670 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80001670:	fe010113          	addi	sp,sp,-32
    80001674:	00113c23          	sd	ra,24(sp)
    80001678:	00813823          	sd	s0,16(sp)
    8000167c:	00913423          	sd	s1,8(sp)
    80001680:	01213023          	sd	s2,0(sp)
    80001684:	02010413          	addi	s0,sp,32
    80001688:	00058913          	mv	s2,a1
    8000168c:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80001690:	00060593          	mv	a1,a2
    80001694:	00000097          	auipc	ra,0x0
    80001698:	f88080e7          	jalr	-120(ra) # 8000161c <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    8000169c:	00048593          	mv	a1,s1
    800016a0:	00090513          	mv	a0,s2
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	e3c080e7          	jalr	-452(ra) # 800014e0 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800016ac:	01813083          	ld	ra,24(sp)
    800016b0:	01013403          	ld	s0,16(sp)
    800016b4:	00813483          	ld	s1,8(sp)
    800016b8:	00013903          	ld	s2,0(sp)
    800016bc:	02010113          	addi	sp,sp,32
    800016c0:	00008067          	ret

00000000800016c4 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    800016c4:	fe010113          	addi	sp,sp,-32
    800016c8:	00113c23          	sd	ra,24(sp)
    800016cc:	00813823          	sd	s0,16(sp)
    800016d0:	00913423          	sd	s1,8(sp)
    800016d4:	01213023          	sd	s2,0(sp)
    800016d8:	02010413          	addi	s0,sp,32
    800016dc:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016e0:	00000493          	li	s1,0
    800016e4:	01893783          	ld	a5,24(s2)
    800016e8:	0af4f863          	bgeu	s1,a5,80001798 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    800016ec:	02093783          	ld	a5,32(s2)
    800016f0:	0034d713          	srli	a4,s1,0x3
    800016f4:	00e787b3          	add	a5,a5,a4
    800016f8:	0007c603          	lbu	a2,0(a5)
    800016fc:	fff4c713          	not	a4,s1
    80001700:	00777713          	andi	a4,a4,7
    80001704:	40e656bb          	sraw	a3,a2,a4
    80001708:	0016f693          	andi	a3,a3,1
    8000170c:	00068663          	beqz	a3,80001718 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x54>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001710:	00148493          	addi	s1,s1,1
    80001714:	fd1ff06f          	j	800016e4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    80001718:	00100693          	li	a3,1
    8000171c:	00e6973b          	sllw	a4,a3,a4
    80001720:	00e66633          	or	a2,a2,a4
    80001724:	00c78023          	sb	a2,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001728:	01093783          	ld	a5,16(s2)
    8000172c:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001730:	04f70863          	beq	a4,a5,80001780 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
    80001734:	03093503          	ld	a0,48(s2)
    80001738:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    8000173c:	fff78793          	addi	a5,a5,-1
    80001740:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001744:	04079463          	bnez	a5,8000178c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    80001748:	03093583          	ld	a1,48(s2)
    8000174c:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001750:	0005b703          	ld	a4,0(a1)
    80001754:	00053783          	ld	a5,0(a0)
    80001758:	00f70863          	beq	a4,a5,80001768 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa4>
                SlabAllocator::move(headFrom, headTo, slab);
    8000175c:	00090613          	mv	a2,s2
    80001760:	00000097          	auipc	ra,0x0
    80001764:	f10080e7          	jalr	-240(ra) # 80001670 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80001768:	02893503          	ld	a0,40(s2)
    8000176c:	03093783          	ld	a5,48(s2)
    80001770:	0407b783          	ld	a5,64(a5)
    80001774:	029784b3          	mul	s1,a5,s1
    80001778:	00950533          	add	a0,a0,s1
    8000177c:	0200006f          	j	8000179c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd8>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001780:	03093503          	ld	a0,48(s2)
    80001784:	06050513          	addi	a0,a0,96
    80001788:	fb5ff06f          	j	8000173c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x78>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    8000178c:	03093583          	ld	a1,48(s2)
    80001790:	06858593          	addi	a1,a1,104
    80001794:	fbdff06f          	j	80001750 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x8c>
    return nullptr;
    80001798:	00000513          	li	a0,0
}
    8000179c:	01813083          	ld	ra,24(sp)
    800017a0:	01013403          	ld	s0,16(sp)
    800017a4:	00813483          	ld	s1,8(sp)
    800017a8:	00013903          	ld	s2,0(sp)
    800017ac:	02010113          	addi	sp,sp,32
    800017b0:	00008067          	ret

00000000800017b4 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800017b4:	fe010113          	addi	sp,sp,-32
    800017b8:	00113c23          	sd	ra,24(sp)
    800017bc:	00813823          	sd	s0,16(sp)
    800017c0:	00913423          	sd	s1,8(sp)
    800017c4:	01213023          	sd	s2,0(sp)
    800017c8:	02010413          	addi	s0,sp,32
    800017cc:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800017d0:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800017d4:	00048c63          	beqz	s1,800017ec <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    800017d8:	00048513          	mv	a0,s1
    800017dc:	00000097          	auipc	ra,0x0
    800017e0:	ee8080e7          	jalr	-280(ra) # 800016c4 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    800017e4:	fe0508e3          	beqz	a0,800017d4 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    800017e8:	00050493          	mv	s1,a0
    if(ret){
    800017ec:	02048063          	beqz	s1,8000180c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    800017f0:	00048513          	mv	a0,s1
    800017f4:	01813083          	ld	ra,24(sp)
    800017f8:	01013403          	ld	s0,16(sp)
    800017fc:	00813483          	ld	s1,8(sp)
    80001800:	00013903          	ld	s2,0(sp)
    80001804:	02010113          	addi	sp,sp,32
    80001808:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    8000180c:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80001810:	00048c63          	beqz	s1,80001828 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80001814:	00048513          	mv	a0,s1
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	eac080e7          	jalr	-340(ra) # 800016c4 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001820:	fe0508e3          	beqz	a0,80001810 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001824:	00050493          	mv	s1,a0
    if(ret){
    80001828:	fc0494e3          	bnez	s1,800017f0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    8000182c:	00090513          	mv	a0,s2
    80001830:	00000097          	auipc	ra,0x0
    80001834:	ce0080e7          	jalr	-800(ra) # 80001510 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80001838:	fa050ce3          	beqz	a0,800017f0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    8000183c:	06093503          	ld	a0,96(s2)
    80001840:	00000097          	auipc	ra,0x0
    80001844:	e84080e7          	jalr	-380(ra) # 800016c4 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001848:	00050493          	mv	s1,a0
    return ret;
    8000184c:	fa5ff06f          	j	800017f0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

0000000080001850 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80001850:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80001854:	0017d513          	srli	a0,a5,0x1
    80001858:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    8000185c:	0027d713          	srli	a4,a5,0x2
    80001860:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80001864:	0047d713          	srli	a4,a5,0x4
    80001868:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    8000186c:	0087d713          	srli	a4,a5,0x8
    80001870:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80001874:	0107d713          	srli	a4,a5,0x10
    80001878:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    8000187c:	0207d713          	srli	a4,a5,0x20
    80001880:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    80001884:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001888:	00000713          	li	a4,0
        while(num>1){
    8000188c:	00100693          	li	a3,1
    80001890:	00f6f863          	bgeu	a3,a5,800018a0 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    80001894:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001898:	00170713          	addi	a4,a4,1
        while(num>1){
    8000189c:	ff1ff06f          	j	8000188c <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800018a0:	ffb70713          	addi	a4,a4,-5
    800018a4:	00c00793          	li	a5,12
    800018a8:	04e7e063          	bltu	a5,a4,800018e8 <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    800018ac:	ff010113          	addi	sp,sp,-16
    800018b0:	00113423          	sd	ra,8(sp)
    800018b4:	00813023          	sd	s0,0(sp)
    800018b8:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    800018bc:	00371713          	slli	a4,a4,0x3
    800018c0:	0000a797          	auipc	a5,0xa
    800018c4:	70078793          	addi	a5,a5,1792 # 8000bfc0 <_ZN13SlabAllocator5sizeNE>
    800018c8:	00e78733          	add	a4,a5,a4
    800018cc:	00073503          	ld	a0,0(a4)
    800018d0:	00000097          	auipc	ra,0x0
    800018d4:	ee4080e7          	jalr	-284(ra) # 800017b4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800018d8:	00813083          	ld	ra,8(sp)
    800018dc:	00013403          	ld	s0,0(sp)
    800018e0:	01010113          	addi	sp,sp,16
    800018e4:	00008067          	ret
        return nullptr;
    800018e8:	00000513          	li	a0,0
}
    800018ec:	00008067          	ret

00000000800018f0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800018f0:	fc010113          	addi	sp,sp,-64
    800018f4:	02113c23          	sd	ra,56(sp)
    800018f8:	02813823          	sd	s0,48(sp)
    800018fc:	02913423          	sd	s1,40(sp)
    80001900:	03213023          	sd	s2,32(sp)
    80001904:	01313c23          	sd	s3,24(sp)
    80001908:	01413823          	sd	s4,16(sp)
    8000190c:	01513423          	sd	s5,8(sp)
    80001910:	04010413          	addi	s0,sp,64
    80001914:	00050913          	mv	s2,a0
    80001918:	00058993          	mv	s3,a1
    8000191c:	00060a93          	mv	s5,a2
    80001920:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001924:	0000a517          	auipc	a0,0xa
    80001928:	70453503          	ld	a0,1796(a0) # 8000c028 <_ZN13SlabAllocator5cacheE>
    8000192c:	00000097          	auipc	ra,0x0
    80001930:	e88080e7          	jalr	-376(ra) # 800017b4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001934:	00050493          	mv	s1,a0
    if(ret == nullptr)
    80001938:	02050a63          	beqz	a0,8000196c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x7c>
    ret->ctor = ctor;
    8000193c:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001940:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001944:	06053823          	sd	zero,112(a0)
    80001948:	06053423          	sd	zero,104(a0)
    8000194c:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001950:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    80001954:	00200793          	li	a5,2
    80001958:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    8000195c:	00050593          	mv	a1,a0
    80001960:	00090513          	mv	a0,s2
    80001964:	00003097          	auipc	ra,0x3
    80001968:	3c0080e7          	jalr	960(ra) # 80004d24 <_Z6strcpyPKcPc>
}
    8000196c:	00048513          	mv	a0,s1
    80001970:	03813083          	ld	ra,56(sp)
    80001974:	03013403          	ld	s0,48(sp)
    80001978:	02813483          	ld	s1,40(sp)
    8000197c:	02013903          	ld	s2,32(sp)
    80001980:	01813983          	ld	s3,24(sp)
    80001984:	01013a03          	ld	s4,16(sp)
    80001988:	00813a83          	ld	s5,8(sp)
    8000198c:	04010113          	addi	sp,sp,64
    80001990:	00008067          	ret

0000000080001994 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80001994:	fe010113          	addi	sp,sp,-32
    80001998:	00113c23          	sd	ra,24(sp)
    8000199c:	00813823          	sd	s0,16(sp)
    800019a0:	00913423          	sd	s1,8(sp)
    800019a4:	01213023          	sd	s2,0(sp)
    800019a8:	02010413          	addi	s0,sp,32
    800019ac:	00050913          	mv	s2,a0
    800019b0:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    800019b4:	00001097          	auipc	ra,0x1
    800019b8:	c1c080e7          	jalr	-996(ra) # 800025d0 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    800019bc:	0000a797          	auipc	a5,0xa
    800019c0:	60478793          	addi	a5,a5,1540 # 8000bfc0 <_ZN13SlabAllocator5sizeNE>
    800019c4:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800019c8:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800019cc:	0000a717          	auipc	a4,0xa
    800019d0:	51473703          	ld	a4,1300(a4) # 8000bee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800019d4:	00073583          	ld	a1,0(a4)
    800019d8:	00c5d593          	srli	a1,a1,0xc
    800019dc:	00158593          	addi	a1,a1,1
    800019e0:	00c59593          	slli	a1,a1,0xc
    800019e4:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    800019e8:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    800019ec:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    800019f0:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    800019f4:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    800019f8:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    800019fc:	07800793          	li	a5,120
    80001a00:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001a04:	00200793          	li	a5,2
    80001a08:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001a0c:	00007517          	auipc	a0,0x7
    80001a10:	75450513          	addi	a0,a0,1876 # 80009160 <CONSOLE_STATUS+0x150>
    80001a14:	00003097          	auipc	ra,0x3
    80001a18:	310080e7          	jalr	784(ra) # 80004d24 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a1c:	00000493          	li	s1,0
    80001a20:	0440006f          	j	80001a64 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a24:	00349913          	slli	s2,s1,0x3
    80001a28:	0000a797          	auipc	a5,0xa
    80001a2c:	2f878793          	addi	a5,a5,760 # 8000bd20 <_ZN13SlabAllocator5namesE>
    80001a30:	012787b3          	add	a5,a5,s2
    80001a34:	00000693          	li	a3,0
    80001a38:	00000613          	li	a2,0
    80001a3c:	00200593          	li	a1,2
    80001a40:	009595bb          	sllw	a1,a1,s1
    80001a44:	0007b503          	ld	a0,0(a5)
    80001a48:	00000097          	auipc	ra,0x0
    80001a4c:	ea8080e7          	jalr	-344(ra) # 800018f0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a50:	0000a797          	auipc	a5,0xa
    80001a54:	57078793          	addi	a5,a5,1392 # 8000bfc0 <_ZN13SlabAllocator5sizeNE>
    80001a58:	012787b3          	add	a5,a5,s2
    80001a5c:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a60:	0014849b          	addiw	s1,s1,1
    80001a64:	00c00793          	li	a5,12
    80001a68:	fa97dee3          	bge	a5,s1,80001a24 <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80001a6c:	01813083          	ld	ra,24(sp)
    80001a70:	01013403          	ld	s0,16(sp)
    80001a74:	00813483          	ld	s1,8(sp)
    80001a78:	00013903          	ld	s2,0(sp)
    80001a7c:	02010113          	addi	sp,sp,32
    80001a80:	00008067          	ret

0000000080001a84 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001a84:	02053783          	ld	a5,32(a0)
    80001a88:	0035d713          	srli	a4,a1,0x3
    80001a8c:	00e787b3          	add	a5,a5,a4
    80001a90:	0007c683          	lbu	a3,0(a5)
    80001a94:	fff5c593          	not	a1,a1
    80001a98:	0075f593          	andi	a1,a1,7
    80001a9c:	40b6d73b          	sraw	a4,a3,a1
    80001aa0:	00177713          	andi	a4,a4,1
    80001aa4:	0c070263          	beqz	a4,80001b68 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001aa8:	fe010113          	addi	sp,sp,-32
    80001aac:	00113c23          	sd	ra,24(sp)
    80001ab0:	00813823          	sd	s0,16(sp)
    80001ab4:	00913423          	sd	s1,8(sp)
    80001ab8:	02010413          	addi	s0,sp,32
    80001abc:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001ac0:	00100713          	li	a4,1
    80001ac4:	00b715bb          	sllw	a1,a4,a1
    80001ac8:	fff5c593          	not	a1,a1
    80001acc:	00d5f5b3          	and	a1,a1,a3
    80001ad0:	00b78023          	sb	a1,0(a5)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001ad4:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001ad8:	04079a63          	bnez	a5,80001b2c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001adc:	03053503          	ld	a0,48(a0)
    80001ae0:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001ae4:	00178793          	addi	a5,a5,1
    80001ae8:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001aec:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001af0:	04e78463          	beq	a5,a4,80001b38 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001af4:	0304b583          	ld	a1,48(s1)
    80001af8:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001afc:	04e78463          	beq	a5,a4,80001b44 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001b00:	0005b703          	ld	a4,0(a1)
    80001b04:	00053783          	ld	a5,0(a0)
    80001b08:	00f70863          	beq	a4,a5,80001b18 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001b0c:	00048613          	mv	a2,s1
    80001b10:	00000097          	auipc	ra,0x0
    80001b14:	b60080e7          	jalr	-1184(ra) # 80001670 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001b18:	01813083          	ld	ra,24(sp)
    80001b1c:	01013403          	ld	s0,16(sp)
    80001b20:	00813483          	ld	s1,8(sp)
    80001b24:	02010113          	addi	sp,sp,32
    80001b28:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b2c:	03053503          	ld	a0,48(a0)
    80001b30:	06850513          	addi	a0,a0,104
    80001b34:	fb1ff06f          	j	80001ae4 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b38:	0304b583          	ld	a1,48(s1)
    80001b3c:	06058593          	addi	a1,a1,96
    80001b40:	fbdff06f          	j	80001afc <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b44:	00048593          	mv	a1,s1
    80001b48:	00000097          	auipc	ra,0x0
    80001b4c:	ad4080e7          	jalr	-1324(ra) # 8000161c <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b50:	0304b783          	ld	a5,48(s1)
    80001b54:	0487b583          	ld	a1,72(a5)
    80001b58:	00048513          	mv	a0,s1
    80001b5c:	00001097          	auipc	ra,0x1
    80001b60:	d6c080e7          	jalr	-660(ra) # 800028c8 <_ZN5Buddy4freeEPvm>
    80001b64:	fb5ff06f          	j	80001b18 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001b68:	00008067          	ret

0000000080001b6c <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001b6c:	fe010113          	addi	sp,sp,-32
    80001b70:	00113c23          	sd	ra,24(sp)
    80001b74:	00813823          	sd	s0,16(sp)
    80001b78:	00913423          	sd	s1,8(sp)
    80001b7c:	01213023          	sd	s2,0(sp)
    80001b80:	02010413          	addi	s0,sp,32
    80001b84:	00050913          	mv	s2,a0
    80001b88:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001b8c:	05853783          	ld	a5,88(a0)
    80001b90:	00078663          	beqz	a5,80001b9c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001b94:	00058513          	mv	a0,a1
    80001b98:	000780e7          	jalr	a5
    if(cache->ctor)
    80001b9c:	05093783          	ld	a5,80(s2)
    80001ba0:	00078663          	beqz	a5,80001bac <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001ba4:	00048513          	mv	a0,s1
    80001ba8:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001bac:	07093503          	ld	a0,112(s2)
    80001bb0:	0080006f          	j	80001bb8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001bb4:	00853503          	ld	a0,8(a0)
        while(head){
    80001bb8:	02050e63          	beqz	a0,80001bf4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001bbc:	02853703          	ld	a4,40(a0)
    80001bc0:	01853783          	ld	a5,24(a0)
    80001bc4:	03053683          	ld	a3,48(a0)
    80001bc8:	0406b583          	ld	a1,64(a3)
    80001bcc:	02b787b3          	mul	a5,a5,a1
    80001bd0:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001bd4:	fef4f0e3          	bgeu	s1,a5,80001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001bd8:	fce4eee3          	bltu	s1,a4,80001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001bdc:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001be0:	02b755b3          	divu	a1,a4,a1
    80001be4:	00000097          	auipc	ra,0x0
    80001be8:	ea0080e7          	jalr	-352(ra) # 80001a84 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001bec:	00100513          	li	a0,1
    80001bf0:	0080006f          	j	80001bf8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001bf4:	00000513          	li	a0,0
    if(deleted)
    80001bf8:	00050e63          	beqz	a0,80001c14 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001bfc:	01813083          	ld	ra,24(sp)
    80001c00:	01013403          	ld	s0,16(sp)
    80001c04:	00813483          	ld	s1,8(sp)
    80001c08:	00013903          	ld	s2,0(sp)
    80001c0c:	02010113          	addi	sp,sp,32
    80001c10:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001c14:	06893783          	ld	a5,104(s2)
    80001c18:	0080006f          	j	80001c20 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001c1c:	0087b783          	ld	a5,8(a5)
        while(head){
    80001c20:	fc078ee3          	beqz	a5,80001bfc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c24:	0287b683          	ld	a3,40(a5)
    80001c28:	0187b703          	ld	a4,24(a5)
    80001c2c:	0307b603          	ld	a2,48(a5)
    80001c30:	04063583          	ld	a1,64(a2)
    80001c34:	02b70733          	mul	a4,a4,a1
    80001c38:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c3c:	fee4f0e3          	bgeu	s1,a4,80001c1c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001c40:	fcd4eee3          	bltu	s1,a3,80001c1c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c44:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001c48:	02b6d5b3          	divu	a1,a3,a1
    80001c4c:	00078513          	mv	a0,a5
    80001c50:	00000097          	auipc	ra,0x0
    80001c54:	e34080e7          	jalr	-460(ra) # 80001a84 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c58:	00100513          	li	a0,1
    80001c5c:	fa1ff06f          	j	80001bfc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001c60 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001c60:	fe010113          	addi	sp,sp,-32
    80001c64:	00113c23          	sd	ra,24(sp)
    80001c68:	00813823          	sd	s0,16(sp)
    80001c6c:	00913423          	sd	s1,8(sp)
    80001c70:	01213023          	sd	s2,0(sp)
    80001c74:	02010413          	addi	s0,sp,32
    80001c78:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001c7c:	00000493          	li	s1,0
    80001c80:	00c00793          	li	a5,12
    80001c84:	0297c863          	blt	a5,s1,80001cb4 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001c88:	00349713          	slli	a4,s1,0x3
    80001c8c:	0000a797          	auipc	a5,0xa
    80001c90:	33478793          	addi	a5,a5,820 # 8000bfc0 <_ZN13SlabAllocator5sizeNE>
    80001c94:	00e787b3          	add	a5,a5,a4
    80001c98:	00090593          	mv	a1,s2
    80001c9c:	0007b503          	ld	a0,0(a5)
    80001ca0:	00000097          	auipc	ra,0x0
    80001ca4:	ecc080e7          	jalr	-308(ra) # 80001b6c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001ca8:	00051663          	bnez	a0,80001cb4 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cac:	0014849b          	addiw	s1,s1,1
    80001cb0:	fd1ff06f          	j	80001c80 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001cb4:	01813083          	ld	ra,24(sp)
    80001cb8:	01013403          	ld	s0,16(sp)
    80001cbc:	00813483          	ld	s1,8(sp)
    80001cc0:	00013903          	ld	s2,0(sp)
    80001cc4:	02010113          	addi	sp,sp,32
    80001cc8:	00008067          	ret

0000000080001ccc <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001ccc:	fe010113          	addi	sp,sp,-32
    80001cd0:	00113c23          	sd	ra,24(sp)
    80001cd4:	00813823          	sd	s0,16(sp)
    80001cd8:	00913423          	sd	s1,8(sp)
    80001cdc:	01213023          	sd	s2,0(sp)
    80001ce0:	02010413          	addi	s0,sp,32
    80001ce4:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001ce8:	00053903          	ld	s2,0(a0)
    80001cec:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001cf0:	00093503          	ld	a0,0(s2)
    80001cf4:	02050263          	beqz	a0,80001d18 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001cf8:	03053783          	ld	a5,48(a0)
    80001cfc:	0487b583          	ld	a1,72(a5)
    80001d00:	00001097          	auipc	ra,0x1
    80001d04:	bc8080e7          	jalr	-1080(ra) # 800028c8 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d08:	00093783          	ld	a5,0(s2)
    80001d0c:	0087b783          	ld	a5,8(a5)
    80001d10:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d14:	fddff06f          	j	80001cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001d18:	0004b903          	ld	s2,0(s1)
    80001d1c:	06890913          	addi	s2,s2,104
    80001d20:	00093503          	ld	a0,0(s2)
    80001d24:	02050263          	beqz	a0,80001d48 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001d28:	03053783          	ld	a5,48(a0)
    80001d2c:	0487b583          	ld	a1,72(a5)
    80001d30:	00001097          	auipc	ra,0x1
    80001d34:	b98080e7          	jalr	-1128(ra) # 800028c8 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d38:	00093783          	ld	a5,0(s2)
    80001d3c:	0087b783          	ld	a5,8(a5)
    80001d40:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d44:	fddff06f          	j	80001d20 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001d48:	0004b903          	ld	s2,0(s1)
    80001d4c:	06090913          	addi	s2,s2,96
    80001d50:	00093503          	ld	a0,0(s2)
    80001d54:	02050263          	beqz	a0,80001d78 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001d58:	03053783          	ld	a5,48(a0)
    80001d5c:	0487b583          	ld	a1,72(a5)
    80001d60:	00001097          	auipc	ra,0x1
    80001d64:	b68080e7          	jalr	-1176(ra) # 800028c8 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d68:	00093783          	ld	a5,0(s2)
    80001d6c:	0087b783          	ld	a5,8(a5)
    80001d70:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d74:	fddff06f          	j	80001d50 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001d78:	0004b583          	ld	a1,0(s1)
    80001d7c:	0000a517          	auipc	a0,0xa
    80001d80:	2ac53503          	ld	a0,684(a0) # 8000c028 <_ZN13SlabAllocator5cacheE>
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	de8080e7          	jalr	-536(ra) # 80001b6c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001d8c:	0004b023          	sd	zero,0(s1)
}
    80001d90:	01813083          	ld	ra,24(sp)
    80001d94:	01013403          	ld	s0,16(sp)
    80001d98:	00813483          	ld	s1,8(sp)
    80001d9c:	00013903          	ld	s2,0(sp)
    80001da0:	02010113          	addi	sp,sp,32
    80001da4:	00008067          	ret

0000000080001da8 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001da8:	ff010113          	addi	sp,sp,-16
    80001dac:	00813423          	sd	s0,8(sp)
    80001db0:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001db4:	03f50513          	addi	a0,a0,63
    80001db8:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001dbc:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001dc0:	00100513          	li	a0,1
    asm("ecall");
    80001dc4:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001dc8:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001dcc:	00813403          	ld	s0,8(sp)
    80001dd0:	01010113          	addi	sp,sp,16
    80001dd4:	00008067          	ret

0000000080001dd8 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001dd8:	ff010113          	addi	sp,sp,-16
    80001ddc:	00813423          	sd	s0,8(sp)
    80001de0:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001de4:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001de8:	00200513          	li	a0,2
    asm("ecall");
    80001dec:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001df0:	00050513          	mv	a0,a0
    return status;
}
    80001df4:	0005051b          	sext.w	a0,a0
    80001df8:	00813403          	ld	s0,8(sp)
    80001dfc:	01010113          	addi	sp,sp,16
    80001e00:	00008067          	ret

0000000080001e04 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001e04:	fd010113          	addi	sp,sp,-48
    80001e08:	02113423          	sd	ra,40(sp)
    80001e0c:	02813023          	sd	s0,32(sp)
    80001e10:	00913c23          	sd	s1,24(sp)
    80001e14:	01213823          	sd	s2,16(sp)
    80001e18:	01313423          	sd	s3,8(sp)
    80001e1c:	03010413          	addi	s0,sp,48
    80001e20:	00050913          	mv	s2,a0
    80001e24:	00058493          	mv	s1,a1
    80001e28:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    80001e2c:	04058e63          	beqz	a1,80001e88 <_Z13thread_createPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001e30:	00001537          	lui	a0,0x1
    80001e34:	00000097          	auipc	ra,0x0
    80001e38:	f74080e7          	jalr	-140(ra) # 80001da8 <_Z9mem_allocm>
        if(istack == 0) {
    80001e3c:	04050063          	beqz	a0,80001e7c <_Z13thread_createPP7_threadPFvPvES2_+0x78>
            *handle = nullptr;
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001e40:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001e44:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001e48:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e4c:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001e50:	01100513          	li	a0,17

    asm("ecall");
    80001e54:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e58:	00050513          	mv	a0,a0

    return status;
    80001e5c:	0005051b          	sext.w	a0,a0
}
    80001e60:	02813083          	ld	ra,40(sp)
    80001e64:	02013403          	ld	s0,32(sp)
    80001e68:	01813483          	ld	s1,24(sp)
    80001e6c:	01013903          	ld	s2,16(sp)
    80001e70:	00813983          	ld	s3,8(sp)
    80001e74:	03010113          	addi	sp,sp,48
    80001e78:	00008067          	ret
            *handle = nullptr;
    80001e7c:	00093023          	sd	zero,0(s2)
            return -1;
    80001e80:	fff00513          	li	a0,-1
    80001e84:	fddff06f          	j	80001e60 <_Z13thread_createPP7_threadPFvPvES2_+0x5c>
    uint64 istack = 0;
    80001e88:	00000513          	li	a0,0
    80001e8c:	fb5ff06f          	j	80001e40 <_Z13thread_createPP7_threadPFvPvES2_+0x3c>

0000000080001e90 <_Z11thread_exitv>:

int thread_exit(){
    80001e90:	ff010113          	addi	sp,sp,-16
    80001e94:	00813423          	sd	s0,8(sp)
    80001e98:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001e9c:	01200513          	li	a0,18

    asm("ecall");
    80001ea0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001ea4:	00050513          	mv	a0,a0

    return status;
}
    80001ea8:	0005051b          	sext.w	a0,a0
    80001eac:	00813403          	ld	s0,8(sp)
    80001eb0:	01010113          	addi	sp,sp,16
    80001eb4:	00008067          	ret

0000000080001eb8 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001eb8:	ff010113          	addi	sp,sp,-16
    80001ebc:	00813423          	sd	s0,8(sp)
    80001ec0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001ec4:	01300513          	li	a0,19

    asm("ecall");
    80001ec8:	00000073          	ecall
}
    80001ecc:	00813403          	ld	s0,8(sp)
    80001ed0:	01010113          	addi	sp,sp,16
    80001ed4:	00008067          	ret

0000000080001ed8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001ed8:	fd010113          	addi	sp,sp,-48
    80001edc:	02113423          	sd	ra,40(sp)
    80001ee0:	02813023          	sd	s0,32(sp)
    80001ee4:	00913c23          	sd	s1,24(sp)
    80001ee8:	01213823          	sd	s2,16(sp)
    80001eec:	01313423          	sd	s3,8(sp)
    80001ef0:	03010413          	addi	s0,sp,48
    80001ef4:	00050493          	mv	s1,a0
    80001ef8:	00058913          	mv	s2,a1
    80001efc:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(handle && start_routine) {
    80001f00:	04050a63          	beqz	a0,80001f54 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x7c>
    80001f04:	04058c63          	beqz	a1,80001f5c <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001f08:	00001537          	lui	a0,0x1
    80001f0c:	00000097          	auipc	ra,0x0
    80001f10:	e9c080e7          	jalr	-356(ra) # 80001da8 <_Z9mem_allocm>
        if(istack == 0) {
    80001f14:	04050863          	beqz	a0,80001f64 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x8c>
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001f18:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001f1c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001f20:	00090613          	mv	a2,s2
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f24:	00048593          	mv	a1,s1
    asm("li a0, 0x14");
    80001f28:	01400513          	li	a0,20

    asm("ecall");
    80001f2c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f30:	00050513          	mv	a0,a0

    return status;
    80001f34:	0005051b          	sext.w	a0,a0
}
    80001f38:	02813083          	ld	ra,40(sp)
    80001f3c:	02013403          	ld	s0,32(sp)
    80001f40:	01813483          	ld	s1,24(sp)
    80001f44:	01013903          	ld	s2,16(sp)
    80001f48:	00813983          	ld	s3,8(sp)
    80001f4c:	03010113          	addi	sp,sp,48
    80001f50:	00008067          	ret
    uint64 istack = 0;
    80001f54:	00000513          	li	a0,0
    80001f58:	fc1ff06f          	j	80001f18 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
    80001f5c:	00000513          	li	a0,0
    80001f60:	fb9ff06f          	j	80001f18 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
            return -1;
    80001f64:	fff00513          	li	a0,-1
    80001f68:	fd1ff06f          	j	80001f38 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x60>

0000000080001f6c <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001f6c:	ff010113          	addi	sp,sp,-16
    80001f70:	00813423          	sd	s0,8(sp)
    80001f74:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;
    if(handle == nullptr)
    80001f78:	02050263          	beqz	a0,80001f9c <_Z12thread_startP7_thread+0x30>
        return -1;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f7c:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001f80:	01500513          	li	a0,21

    asm("ecall");
    80001f84:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f88:	00050513          	mv	a0,a0

    return status;
    80001f8c:	0005051b          	sext.w	a0,a0
}
    80001f90:	00813403          	ld	s0,8(sp)
    80001f94:	01010113          	addi	sp,sp,16
    80001f98:	00008067          	ret
        return -1;
    80001f9c:	fff00513          	li	a0,-1
    80001fa0:	ff1ff06f          	j	80001f90 <_Z12thread_startP7_thread+0x24>

0000000080001fa4 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001fa4:	ff010113          	addi	sp,sp,-16
    80001fa8:	00813423          	sd	s0,8(sp)
    80001fac:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001fb0:	02059593          	slli	a1,a1,0x20
    80001fb4:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001fb8:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fbc:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001fc0:	02100513          	li	a0,33


    asm("ecall");
    80001fc4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fc8:	00050513          	mv	a0,a0

    return status;

}
    80001fcc:	0005051b          	sext.w	a0,a0
    80001fd0:	00813403          	ld	s0,8(sp)
    80001fd4:	01010113          	addi	sp,sp,16
    80001fd8:	00008067          	ret

0000000080001fdc <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001fdc:	ff010113          	addi	sp,sp,-16
    80001fe0:	00813423          	sd	s0,8(sp)
    80001fe4:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fe8:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001fec:	02200513          	li	a0,34


    asm("ecall");
    80001ff0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001ff4:	00050513          	mv	a0,a0

    return status;
}
    80001ff8:	0005051b          	sext.w	a0,a0
    80001ffc:	00813403          	ld	s0,8(sp)
    80002000:	01010113          	addi	sp,sp,16
    80002004:	00008067          	ret

0000000080002008 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80002008:	ff010113          	addi	sp,sp,-16
    8000200c:	00813423          	sd	s0,8(sp)
    80002010:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002014:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80002018:	02300513          	li	a0,35


    asm("ecall");
    8000201c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002020:	00050513          	mv	a0,a0

    return status;
}
    80002024:	0005051b          	sext.w	a0,a0
    80002028:	00813403          	ld	s0,8(sp)
    8000202c:	01010113          	addi	sp,sp,16
    80002030:	00008067          	ret

0000000080002034 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80002034:	ff010113          	addi	sp,sp,-16
    80002038:	00813423          	sd	s0,8(sp)
    8000203c:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002040:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80002044:	02400513          	li	a0,36


    asm("ecall");
    80002048:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000204c:	00050513          	mv	a0,a0

    return status;
}
    80002050:	0005051b          	sext.w	a0,a0
    80002054:	00813403          	ld	s0,8(sp)
    80002058:	01010113          	addi	sp,sp,16
    8000205c:	00008067          	ret

0000000080002060 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80002060:	ff010113          	addi	sp,sp,-16
    80002064:	00813423          	sd	s0,8(sp)
    80002068:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    8000206c:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80002070:	03100513          	li	a0,49


    asm("ecall");
    80002074:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002078:	00050513          	mv	a0,a0

    return status;
}
    8000207c:	0005051b          	sext.w	a0,a0
    80002080:	00813403          	ld	s0,8(sp)
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00008067          	ret

000000008000208c <_Z4getcv>:

char getc(){
    8000208c:	ff010113          	addi	sp,sp,-16
    80002090:	00813423          	sd	s0,8(sp)
    80002094:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80002098:	04100513          	li	a0,65

    asm("ecall");
    8000209c:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    800020a0:	00050513          	mv	a0,a0

    return c;
}
    800020a4:	0ff57513          	andi	a0,a0,255
    800020a8:	00813403          	ld	s0,8(sp)
    800020ac:	01010113          	addi	sp,sp,16
    800020b0:	00008067          	ret

00000000800020b4 <_Z4putcc>:

void putc(char c){
    800020b4:	ff010113          	addi	sp,sp,-16
    800020b8:	00813423          	sd	s0,8(sp)
    800020bc:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    800020c0:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    800020c4:	04200513          	li	a0,66

    asm("ecall");
    800020c8:	00000073          	ecall
}
    800020cc:	00813403          	ld	s0,8(sp)
    800020d0:	01010113          	addi	sp,sp,16
    800020d4:	00008067          	ret

00000000800020d8 <_Z4forkv>:


int fork(){
    800020d8:	ff010113          	addi	sp,sp,-16
    800020dc:	00813423          	sd	s0,8(sp)
    800020e0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    800020e4:	06100513          	li	a0,97

    asm("ecall");
    800020e8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800020ec:	00050513          	mv	a0,a0

    return status;
}
    800020f0:	0005051b          	sext.w	a0,a0
    800020f4:	00813403          	ld	s0,8(sp)
    800020f8:	01010113          	addi	sp,sp,16
    800020fc:	00008067          	ret

0000000080002100 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80002100:	ff010113          	addi	sp,sp,-16
    80002104:	00113423          	sd	ra,8(sp)
    80002108:	00813023          	sd	s0,0(sp)
    8000210c:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80002110:	00000097          	auipc	ra,0x0
    80002114:	ecc080e7          	jalr	-308(ra) # 80001fdc <_Z9sem_closeP10_semaphore>
}
    80002118:	00813083          	ld	ra,8(sp)
    8000211c:	00013403          	ld	s0,0(sp)
    80002120:	01010113          	addi	sp,sp,16
    80002124:	00008067          	ret

0000000080002128 <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    80002128:	ff010113          	addi	sp,sp,-16
    8000212c:	00113423          	sd	ra,8(sp)
    80002130:	00813023          	sd	s0,0(sp)
    80002134:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    80002138:	00001097          	auipc	ra,0x1
    8000213c:	2e0080e7          	jalr	736(ra) # 80003418 <_ZN3TCB11thread_freeEPv>
    80002140:	00813083          	ld	ra,8(sp)
    80002144:	00013403          	ld	s0,0(sp)
    80002148:	01010113          	addi	sp,sp,16
    8000214c:	00008067          	ret

0000000080002150 <_Z1fP10ForkThread>:
struct thread_data {
    int id;
};
class ForkThread;

void f(ForkThread *f){
    80002150:	ff010113          	addi	sp,sp,-16
    80002154:	00813423          	sd	s0,8(sp)
    80002158:	01010413          	addi	s0,sp,16

}
    8000215c:	00813403          	ld	s0,8(sp)
    80002160:	01010113          	addi	sp,sp,16
    80002164:	00008067          	ret

0000000080002168 <_Z8userMainv>:
    long id;
    bool finished;
};


void userMain() {
    80002168:	fc010113          	addi	sp,sp,-64
    8000216c:	02113c23          	sd	ra,56(sp)
    80002170:	02813823          	sd	s0,48(sp)
    80002174:	02913423          	sd	s1,40(sp)
    80002178:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000217c:	fc040493          	addi	s1,s0,-64
    80002180:	00048513          	mv	a0,s1
    80002184:	00002097          	auipc	ra,0x2
    80002188:	9ec080e7          	jalr	-1556(ra) # 80003b70 <_ZN6ThreadC1Ev>
    8000218c:	0000a797          	auipc	a5,0xa
    80002190:	c0c78793          	addi	a5,a5,-1012 # 8000bd98 <_ZTV10ForkThread+0x10>
    80002194:	fcf43023          	sd	a5,-64(s0)
    80002198:	00100793          	li	a5,1
    8000219c:	fcf43823          	sd	a5,-48(s0)
    800021a0:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    800021a4:	00048513          	mv	a0,s1
    800021a8:	00002097          	auipc	ra,0x2
    800021ac:	ab8080e7          	jalr	-1352(ra) # 80003c60 <_ZN6Thread5startEv>
        return finished;
    800021b0:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    800021b4:	00079863          	bnez	a5,800021c4 <_Z8userMainv+0x5c>
        thread_dispatch();
    800021b8:	00000097          	auipc	ra,0x0
    800021bc:	d00080e7          	jalr	-768(ra) # 80001eb8 <_Z15thread_dispatchv>
    800021c0:	ff1ff06f          	j	800021b0 <_Z8userMainv+0x48>
    }

    ConsoleUtil::printString("User main finished\n");
    800021c4:	00007517          	auipc	a0,0x7
    800021c8:	11450513          	addi	a0,a0,276 # 800092d8 <CONSOLE_STATUS+0x2c8>
    800021cc:	00003097          	auipc	ra,0x3
    800021d0:	0c8080e7          	jalr	200(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
class ForkThread : public Thread {
    800021d4:	0000a797          	auipc	a5,0xa
    800021d8:	bc478793          	addi	a5,a5,-1084 # 8000bd98 <_ZTV10ForkThread+0x10>
    800021dc:	fcf43023          	sd	a5,-64(s0)
    800021e0:	fc040513          	addi	a0,s0,-64
    800021e4:	00001097          	auipc	ra,0x1
    800021e8:	770080e7          	jalr	1904(ra) # 80003954 <_ZN6ThreadD1Ev>
    800021ec:	03813083          	ld	ra,56(sp)
    800021f0:	03013403          	ld	s0,48(sp)
    800021f4:	02813483          	ld	s1,40(sp)
    800021f8:	04010113          	addi	sp,sp,64
    800021fc:	00008067          	ret
    80002200:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    80002204:	0000a797          	auipc	a5,0xa
    80002208:	b9478793          	addi	a5,a5,-1132 # 8000bd98 <_ZTV10ForkThread+0x10>
    8000220c:	fcf43023          	sd	a5,-64(s0)
    80002210:	fc040513          	addi	a0,s0,-64
    80002214:	00001097          	auipc	ra,0x1
    80002218:	740080e7          	jalr	1856(ra) # 80003954 <_ZN6ThreadD1Ev>
    8000221c:	00048513          	mv	a0,s1
    80002220:	0000b097          	auipc	ra,0xb
    80002224:	0d8080e7          	jalr	216(ra) # 8000d2f8 <_Unwind_Resume>

0000000080002228 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002228:	ff010113          	addi	sp,sp,-16
    8000222c:	00113423          	sd	ra,8(sp)
    80002230:	00813023          	sd	s0,0(sp)
    80002234:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80002238:	00000097          	auipc	ra,0x0
    8000223c:	f30080e7          	jalr	-208(ra) # 80002168 <_Z8userMainv>
    80002240:	00813083          	ld	ra,8(sp)
    80002244:	00013403          	ld	s0,0(sp)
    80002248:	01010113          	addi	sp,sp,16
    8000224c:	00008067          	ret

0000000080002250 <_Z4ctorPv>:
void ctor(void* tst){
    80002250:	ff010113          	addi	sp,sp,-16
    80002254:	00813423          	sd	s0,8(sp)
    80002258:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    8000225c:	01100793          	li	a5,17
    80002260:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    80002264:	02000793          	li	a5,32
    80002268:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    8000226c:	00d00793          	li	a5,13
    80002270:	00f53823          	sd	a5,16(a0)
}
    80002274:	00813403          	ld	s0,8(sp)
    80002278:	01010113          	addi	sp,sp,16
    8000227c:	00008067          	ret

0000000080002280 <_ZN6SystemC1Ev>:
    if (!initialized) {
    80002280:	0000a797          	auipc	a5,0xa
    80002284:	dc07c783          	lbu	a5,-576(a5) # 8000c040 <_ZN6System11initializedE>
    80002288:	00078463          	beqz	a5,80002290 <_ZN6SystemC1Ev+0x10>
    8000228c:	00008067          	ret
System::System() {
    80002290:	fe010113          	addi	sp,sp,-32
    80002294:	00113c23          	sd	ra,24(sp)
    80002298:	00813823          	sd	s0,16(sp)
    8000229c:	02010413          	addi	s0,sp,32
        initialized = true;
    800022a0:	00100793          	li	a5,1
    800022a4:	0000a717          	auipc	a4,0xa
    800022a8:	d8f70e23          	sb	a5,-612(a4) # 8000c040 <_ZN6System11initializedE>
        RiscV::initialize();
    800022ac:	00002097          	auipc	ra,0x2
    800022b0:	b54080e7          	jalr	-1196(ra) # 80003e00 <_ZN5RiscV10initializeEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    800022b4:	00000613          	li	a2,0
    800022b8:	00000597          	auipc	a1,0x0
    800022bc:	f7058593          	addi	a1,a1,-144 # 80002228 <_ZN6System15userMainWrapperEPv>
    800022c0:	fe840513          	addi	a0,s0,-24
    800022c4:	00000097          	auipc	ra,0x0
    800022c8:	b40080e7          	jalr	-1216(ra) # 80001e04 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    800022cc:	fe843783          	ld	a5,-24(s0)
    800022d0:	0107a703          	lw	a4,16(a5)
    800022d4:	00200793          	li	a5,2
    800022d8:	00f70863          	beq	a4,a5,800022e8 <_ZN6SystemC1Ev+0x68>
            thread_dispatch();
    800022dc:	00000097          	auipc	ra,0x0
    800022e0:	bdc080e7          	jalr	-1060(ra) # 80001eb8 <_Z15thread_dispatchv>
    800022e4:	fe9ff06f          	j	800022cc <_ZN6SystemC1Ev+0x4c>
        RiscV::finalize();
    800022e8:	00002097          	auipc	ra,0x2
    800022ec:	d1c080e7          	jalr	-740(ra) # 80004004 <_ZN5RiscV8finalizeEv>
}
    800022f0:	01813083          	ld	ra,24(sp)
    800022f4:	01013403          	ld	s0,16(sp)
    800022f8:	02010113          	addi	sp,sp,32
    800022fc:	00008067          	ret

0000000080002300 <_ZN10ForkThread3runEv>:
    virtual void run() {
    80002300:	fc010113          	addi	sp,sp,-64
    80002304:	02113c23          	sd	ra,56(sp)
    80002308:	02813823          	sd	s0,48(sp)
    8000230c:	02913423          	sd	s1,40(sp)
    80002310:	03213023          	sd	s2,32(sp)
    80002314:	01313c23          	sd	s3,24(sp)
    80002318:	01413823          	sd	s4,16(sp)
    8000231c:	01513423          	sd	s5,8(sp)
    80002320:	01613023          	sd	s6,0(sp)
    80002324:	04010413          	addi	s0,sp,64
    80002328:	00050a13          	mv	s4,a0
        ConsoleUtil::print("Started thread id:", id, "\n");
    8000232c:	00007617          	auipc	a2,0x7
    80002330:	06c60613          	addi	a2,a2,108 # 80009398 <CONSOLE_STATUS+0x388>
    80002334:	01052583          	lw	a1,16(a0)
    80002338:	00007517          	auipc	a0,0x7
    8000233c:	f7050513          	addi	a0,a0,-144 # 800092a8 <CONSOLE_STATUS+0x298>
    80002340:	00003097          	auipc	ra,0x3
    80002344:	074080e7          	jalr	116(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        ForkThread* thread = new ForkThread(id + 1);
    80002348:	02000513          	li	a0,32
    8000234c:	00001097          	auipc	ra,0x1
    80002350:	648080e7          	jalr	1608(ra) # 80003994 <_Znwm>
    80002354:	00050993          	mv	s3,a0
    80002358:	02050463          	beqz	a0,80002380 <_ZN10ForkThread3runEv+0x80>
    8000235c:	010a3483          	ld	s1,16(s4)
    80002360:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80002364:	00002097          	auipc	ra,0x2
    80002368:	80c080e7          	jalr	-2036(ra) # 80003b70 <_ZN6ThreadC1Ev>
    8000236c:	0000a797          	auipc	a5,0xa
    80002370:	a2c78793          	addi	a5,a5,-1492 # 8000bd98 <_ZTV10ForkThread+0x10>
    80002374:	00f9b023          	sd	a5,0(s3)
    80002378:	0099b823          	sd	s1,16(s3)
    8000237c:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80002380:	010a3503          	ld	a0,16(s4)
    80002384:	00351513          	slli	a0,a0,0x3
    80002388:	00000097          	auipc	ra,0x0
    8000238c:	a20080e7          	jalr	-1504(ra) # 80001da8 <_Z9mem_allocm>
    80002390:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    80002394:	10050863          	beqz	a0,800024a4 <_ZN10ForkThread3runEv+0x1a4>
            for (long i = 0; i < id; i++) {
    80002398:	00000913          	li	s2,0
    8000239c:	0140006f          	j	800023b0 <_ZN10ForkThread3runEv+0xb0>
                threads[i] = new ForkThread(id);
    800023a0:	00391793          	slli	a5,s2,0x3
    800023a4:	00fa87b3          	add	a5,s5,a5
    800023a8:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    800023ac:	00190913          	addi	s2,s2,1
    800023b0:	010a3783          	ld	a5,16(s4)
    800023b4:	02f95e63          	bge	s2,a5,800023f0 <_ZN10ForkThread3runEv+0xf0>
                threads[i] = new ForkThread(id);
    800023b8:	02000513          	li	a0,32
    800023bc:	00001097          	auipc	ra,0x1
    800023c0:	5d8080e7          	jalr	1496(ra) # 80003994 <_Znwm>
    800023c4:	00050493          	mv	s1,a0
    800023c8:	fc050ce3          	beqz	a0,800023a0 <_ZN10ForkThread3runEv+0xa0>
    800023cc:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    800023d0:	00001097          	auipc	ra,0x1
    800023d4:	7a0080e7          	jalr	1952(ra) # 80003b70 <_ZN6ThreadC1Ev>
    800023d8:	0000a797          	auipc	a5,0xa
    800023dc:	9c078793          	addi	a5,a5,-1600 # 8000bd98 <_ZTV10ForkThread+0x10>
    800023e0:	00f4b023          	sd	a5,0(s1)
    800023e4:	0164b823          	sd	s6,16(s1)
    800023e8:	00048c23          	sb	zero,24(s1)
    800023ec:	fb5ff06f          	j	800023a0 <_ZN10ForkThread3runEv+0xa0>
            if (thread != nullptr) {
    800023f0:	06098a63          	beqz	s3,80002464 <_ZN10ForkThread3runEv+0x164>
                if (thread->start() == 0) {
    800023f4:	00098513          	mv	a0,s3
    800023f8:	00002097          	auipc	ra,0x2
    800023fc:	868080e7          	jalr	-1944(ra) # 80003c60 <_ZN6Thread5startEv>
    80002400:	00050913          	mv	s2,a0
    80002404:	04051863          	bnez	a0,80002454 <_ZN10ForkThread3runEv+0x154>
                    for (int i = 0; i < 5000; i++) {
    80002408:	00050493          	mv	s1,a0
    8000240c:	0100006f          	j	8000241c <_ZN10ForkThread3runEv+0x11c>
                        thread_dispatch();
    80002410:	00000097          	auipc	ra,0x0
    80002414:	aa8080e7          	jalr	-1368(ra) # 80001eb8 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    80002418:	0014849b          	addiw	s1,s1,1
    8000241c:	000017b7          	lui	a5,0x1
    80002420:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80002424:	0097ce63          	blt	a5,s1,80002440 <_ZN10ForkThread3runEv+0x140>
                        for (int j = 0; j < 5000; j++) {
    80002428:	00090713          	mv	a4,s2
    8000242c:	000017b7          	lui	a5,0x1
    80002430:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80002434:	fce7cee3          	blt	a5,a4,80002410 <_ZN10ForkThread3runEv+0x110>
    80002438:	0017071b          	addiw	a4,a4,1
    8000243c:	ff1ff06f          	j	8000242c <_ZN10ForkThread3runEv+0x12c>
        return finished;
    80002440:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80002444:	00079863          	bnez	a5,80002454 <_ZN10ForkThread3runEv+0x154>
                        thread_dispatch();
    80002448:	00000097          	auipc	ra,0x0
    8000244c:	a70080e7          	jalr	-1424(ra) # 80001eb8 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    80002450:	ff1ff06f          	j	80002440 <_ZN10ForkThread3runEv+0x140>
                delete thread;
    80002454:	0009b783          	ld	a5,0(s3)
    80002458:	0087b783          	ld	a5,8(a5)
    8000245c:	00098513          	mv	a0,s3
    80002460:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80002464:	00000493          	li	s1,0
    80002468:	0080006f          	j	80002470 <_ZN10ForkThread3runEv+0x170>
            for (long i = 0; i < id; i++) {
    8000246c:	00148493          	addi	s1,s1,1
    80002470:	010a3783          	ld	a5,16(s4)
    80002474:	02f4d263          	bge	s1,a5,80002498 <_ZN10ForkThread3runEv+0x198>
                delete threads[i];
    80002478:	00349793          	slli	a5,s1,0x3
    8000247c:	00fa87b3          	add	a5,s5,a5
    80002480:	0007b503          	ld	a0,0(a5)
    80002484:	fe0504e3          	beqz	a0,8000246c <_ZN10ForkThread3runEv+0x16c>
    80002488:	00053783          	ld	a5,0(a0)
    8000248c:	0087b783          	ld	a5,8(a5)
    80002490:	000780e7          	jalr	a5
    80002494:	fd9ff06f          	j	8000246c <_ZN10ForkThread3runEv+0x16c>
            mem_free(threads);
    80002498:	000a8513          	mv	a0,s5
    8000249c:	00000097          	auipc	ra,0x0
    800024a0:	93c080e7          	jalr	-1732(ra) # 80001dd8 <_Z8mem_freePv>
        ConsoleUtil::print("Finished thread id:", id,"\n");
    800024a4:	00007617          	auipc	a2,0x7
    800024a8:	ef460613          	addi	a2,a2,-268 # 80009398 <CONSOLE_STATUS+0x388>
    800024ac:	010a2583          	lw	a1,16(s4)
    800024b0:	00007517          	auipc	a0,0x7
    800024b4:	e1050513          	addi	a0,a0,-496 # 800092c0 <CONSOLE_STATUS+0x2b0>
    800024b8:	00003097          	auipc	ra,0x3
    800024bc:	efc080e7          	jalr	-260(ra) # 800053b4 <_ZN11ConsoleUtil5printEPKciS1_>
        finished = true;
    800024c0:	00100793          	li	a5,1
    800024c4:	00fa0c23          	sb	a5,24(s4)
    }
    800024c8:	03813083          	ld	ra,56(sp)
    800024cc:	03013403          	ld	s0,48(sp)
    800024d0:	02813483          	ld	s1,40(sp)
    800024d4:	02013903          	ld	s2,32(sp)
    800024d8:	01813983          	ld	s3,24(sp)
    800024dc:	01013a03          	ld	s4,16(sp)
    800024e0:	00813a83          	ld	s5,8(sp)
    800024e4:	00013b03          	ld	s6,0(sp)
    800024e8:	04010113          	addi	sp,sp,64
    800024ec:	00008067          	ret

00000000800024f0 <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    800024f0:	ff010113          	addi	sp,sp,-16
    800024f4:	00113423          	sd	ra,8(sp)
    800024f8:	00813023          	sd	s0,0(sp)
    800024fc:	01010413          	addi	s0,sp,16
    80002500:	0000a797          	auipc	a5,0xa
    80002504:	89878793          	addi	a5,a5,-1896 # 8000bd98 <_ZTV10ForkThread+0x10>
    80002508:	00f53023          	sd	a5,0(a0)
    8000250c:	00001097          	auipc	ra,0x1
    80002510:	448080e7          	jalr	1096(ra) # 80003954 <_ZN6ThreadD1Ev>
    80002514:	00813083          	ld	ra,8(sp)
    80002518:	00013403          	ld	s0,0(sp)
    8000251c:	01010113          	addi	sp,sp,16
    80002520:	00008067          	ret

0000000080002524 <_ZN10ForkThreadD0Ev>:
    80002524:	fe010113          	addi	sp,sp,-32
    80002528:	00113c23          	sd	ra,24(sp)
    8000252c:	00813823          	sd	s0,16(sp)
    80002530:	00913423          	sd	s1,8(sp)
    80002534:	02010413          	addi	s0,sp,32
    80002538:	00050493          	mv	s1,a0
    8000253c:	0000a797          	auipc	a5,0xa
    80002540:	85c78793          	addi	a5,a5,-1956 # 8000bd98 <_ZTV10ForkThread+0x10>
    80002544:	00f53023          	sd	a5,0(a0)
    80002548:	00001097          	auipc	ra,0x1
    8000254c:	40c080e7          	jalr	1036(ra) # 80003954 <_ZN6ThreadD1Ev>
    80002550:	00048513          	mv	a0,s1
    80002554:	00001097          	auipc	ra,0x1
    80002558:	490080e7          	jalr	1168(ra) # 800039e4 <_ZdlPv>
    8000255c:	01813083          	ld	ra,24(sp)
    80002560:	01013403          	ld	s0,16(sp)
    80002564:	00813483          	ld	s1,8(sp)
    80002568:	02010113          	addi	sp,sp,32
    8000256c:	00008067          	ret

0000000080002570 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80002570:	ff010113          	addi	sp,sp,-16
    80002574:	00813423          	sd	s0,8(sp)
    80002578:	01010413          	addi	s0,sp,16
    8000257c:	00100793          	li	a5,1
    80002580:	00f50863          	beq	a0,a5,80002590 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002584:	00813403          	ld	s0,8(sp)
    80002588:	01010113          	addi	sp,sp,16
    8000258c:	00008067          	ret
    80002590:	000107b7          	lui	a5,0x10
    80002594:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002598:	fef596e3          	bne	a1,a5,80002584 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    8000259c:	0000a797          	auipc	a5,0xa
    800025a0:	9447b783          	ld	a5,-1724(a5) # 8000bee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800025a4:	0007b703          	ld	a4,0(a5)
    800025a8:	00c75793          	srli	a5,a4,0xc
    800025ac:	00278793          	addi	a5,a5,2
    800025b0:	00c79793          	slli	a5,a5,0xc
    800025b4:	0000a697          	auipc	a3,0xa
    800025b8:	a9468693          	addi	a3,a3,-1388 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025bc:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800025c0:	fffff7b7          	lui	a5,0xfffff
    800025c4:	00f77733          	and	a4,a4,a5
    800025c8:	00e6b423          	sd	a4,8(a3)
    800025cc:	fb9ff06f          	j	80002584 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800025d0 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    800025d0:	ff010113          	addi	sp,sp,-16
    800025d4:	00813423          	sd	s0,8(sp)
    800025d8:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    800025dc:	0000a717          	auipc	a4,0xa
    800025e0:	a6c70713          	addi	a4,a4,-1428 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025e4:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800025e8:	0000a797          	auipc	a5,0xa
    800025ec:	8f87b783          	ld	a5,-1800(a5) # 8000bee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800025f0:	0007b783          	ld	a5,0(a5)
    800025f4:	fffff6b7          	lui	a3,0xfffff
    800025f8:	00d7f7b3          	and	a5,a5,a3
    800025fc:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80002600:	00009797          	auipc	a5,0x9
    80002604:	7ab7bc23          	sd	a1,1976(a5) # 8000bdb8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80002608:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    8000260c:	00000713          	li	a4,0
        while(num>1){
    80002610:	00100693          	li	a3,1
    80002614:	00f6f863          	bgeu	a3,a5,80002624 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80002618:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000261c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002620:	ff1ff06f          	j	80002610 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80002624:	00371713          	slli	a4,a4,0x3
    80002628:	0000a797          	auipc	a5,0xa
    8000262c:	a2078793          	addi	a5,a5,-1504 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002630:	00e78733          	add	a4,a5,a4
    80002634:	00a73823          	sd	a0,16(a4)
    80002638:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000263c:	00000713          	li	a4,0
        while(num>1){
    80002640:	00100693          	li	a3,1
    80002644:	00f6f863          	bgeu	a3,a5,80002654 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80002648:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000264c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002650:	ff1ff06f          	j	80002640 <_ZN5Buddy10initializeEPvm+0x70>
    80002654:	00371713          	slli	a4,a4,0x3
    80002658:	0000a797          	auipc	a5,0xa
    8000265c:	9f078793          	addi	a5,a5,-1552 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002660:	00e78733          	add	a4,a5,a4
    80002664:	06a73c23          	sd	a0,120(a4)
    80002668:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000266c:	00000713          	li	a4,0
        while(num>1){
    80002670:	00100693          	li	a3,1
    80002674:	00f6f863          	bgeu	a3,a5,80002684 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80002678:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000267c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002680:	ff1ff06f          	j	80002670 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80002684:	00371713          	slli	a4,a4,0x3
    80002688:	0000a797          	auipc	a5,0xa
    8000268c:	9c078793          	addi	a5,a5,-1600 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002690:	00e78733          	add	a4,a5,a4
    80002694:	01073783          	ld	a5,16(a4)
    80002698:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    8000269c:	00000793          	li	a5,0
    800026a0:	00c0006f          	j	800026ac <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    800026a4:	0015d593          	srli	a1,a1,0x1
            deg++;
    800026a8:	00178793          	addi	a5,a5,1
        while(num>1){
    800026ac:	00100713          	li	a4,1
    800026b0:	feb76ae3          	bltu	a4,a1,800026a4 <_ZN5Buddy10initializeEPvm+0xd4>
    800026b4:	00379793          	slli	a5,a5,0x3
    800026b8:	0000a717          	auipc	a4,0xa
    800026bc:	99070713          	addi	a4,a4,-1648 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026c0:	00f707b3          	add	a5,a4,a5
    800026c4:	0787b783          	ld	a5,120(a5)
    800026c8:	0007b023          	sd	zero,0(a5)
}
    800026cc:	00813403          	ld	s0,8(sp)
    800026d0:	01010113          	addi	sp,sp,16
    800026d4:	00008067          	ret

00000000800026d8 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    800026d8:	00c00793          	li	a5,12
    800026dc:	10f50063          	beq	a0,a5,800027dc <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    800026e0:	fd010113          	addi	sp,sp,-48
    800026e4:	02113423          	sd	ra,40(sp)
    800026e8:	02813023          	sd	s0,32(sp)
    800026ec:	00913c23          	sd	s1,24(sp)
    800026f0:	01213823          	sd	s2,16(sp)
    800026f4:	01313423          	sd	s3,8(sp)
    800026f8:	03010413          	addi	s0,sp,48
    800026fc:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002700:	00351713          	slli	a4,a0,0x3
    80002704:	0000a797          	auipc	a5,0xa
    80002708:	94478793          	addi	a5,a5,-1724 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000270c:	00e787b3          	add	a5,a5,a4
    80002710:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002714:	00000993          	li	s3,0
    80002718:	0180006f          	j	80002730 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    8000271c:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002720:	04f70463          	beq	a4,a5,80002768 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002724:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002728:	08f70063          	beq	a4,a5,800027a8 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    8000272c:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002730:	08048863          	beqz	s1,800027c0 <_ZN5Buddy8compressEm+0xe8>
    80002734:	0004b683          	ld	a3,0(s1)
    80002738:	08068463          	beqz	a3,800027c0 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    8000273c:	0000a797          	auipc	a5,0xa
    80002740:	90c7b783          	ld	a5,-1780(a5) # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002744:	40f48733          	sub	a4,s1,a5
    80002748:	00c9061b          	addiw	a2,s2,12
    8000274c:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002750:	40f687b3          	sub	a5,a3,a5
    80002754:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002758:	00177613          	andi	a2,a4,1
    8000275c:	fc0610e3          	bnez	a2,8000271c <_ZN5Buddy8compressEm+0x44>
    80002760:	00170713          	addi	a4,a4,1
    80002764:	fbdff06f          	j	80002720 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002768:	00098863          	beqz	s3,80002778 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    8000276c:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7fff1b70>
    80002770:	00d9b023          	sd	a3,0(s3)
    80002774:	fb5ff06f          	j	80002728 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80002778:	0006b603          	ld	a2,0(a3)
    8000277c:	00391593          	slli	a1,s2,0x3
    80002780:	0000a697          	auipc	a3,0xa
    80002784:	8c868693          	addi	a3,a3,-1848 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002788:	00b686b3          	add	a3,a3,a1
    8000278c:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80002790:	f8061ce3          	bnez	a2,80002728 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80002794:	0000a697          	auipc	a3,0xa
    80002798:	8b468693          	addi	a3,a3,-1868 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000279c:	00b686b3          	add	a3,a3,a1
    800027a0:	0006b823          	sd	zero,16(a3)
    800027a4:	f85ff06f          	j	80002728 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800027a8:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    800027ac:	00190593          	addi	a1,s2,1
    800027b0:	00048513          	mv	a0,s1
    800027b4:	00000097          	auipc	ra,0x0
    800027b8:	02c080e7          	jalr	44(ra) # 800027e0 <_ZN5Buddy6insertEPvm>
    800027bc:	f71ff06f          	j	8000272c <_ZN5Buddy8compressEm+0x54>
}
    800027c0:	02813083          	ld	ra,40(sp)
    800027c4:	02013403          	ld	s0,32(sp)
    800027c8:	01813483          	ld	s1,24(sp)
    800027cc:	01013903          	ld	s2,16(sp)
    800027d0:	00813983          	ld	s3,8(sp)
    800027d4:	03010113          	addi	sp,sp,48
    800027d8:	00008067          	ret
    800027dc:	00008067          	ret

00000000800027e0 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    800027e0:	00050693          	mv	a3,a0
    if(!head[size]){
    800027e4:	00359713          	slli	a4,a1,0x3
    800027e8:	0000a797          	auipc	a5,0xa
    800027ec:	86078793          	addi	a5,a5,-1952 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027f0:	00e787b3          	add	a5,a5,a4
    800027f4:	0787b783          	ld	a5,120(a5)
    800027f8:	02078c63          	beqz	a5,80002830 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    800027fc:	ff010113          	addi	sp,sp,-16
    80002800:	00113423          	sd	ra,8(sp)
    80002804:	00813023          	sd	s0,0(sp)
    80002808:	01010413          	addi	s0,sp,16
    8000280c:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002810:	00068713          	mv	a4,a3
    80002814:	04f6e063          	bltu	a3,a5,80002854 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002818:	00000613          	li	a2,0
            while (iter != nullptr) {
    8000281c:	06078863          	beqz	a5,8000288c <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002820:	04f76c63          	bltu	a4,a5,80002878 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002824:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002828:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    8000282c:	ff1ff06f          	j	8000281c <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002830:	0000a797          	auipc	a5,0xa
    80002834:	81878793          	addi	a5,a5,-2024 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002838:	00e78533          	add	a0,a5,a4
    8000283c:	00d53823          	sd	a3,16(a0)
    80002840:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002844:	0006b023          	sd	zero,0(a3)
    80002848:	07853783          	ld	a5,120(a0)
    8000284c:	0007b023          	sd	zero,0(a5)
        return;
    80002850:	00008067          	ret
            newHead->next = head[size];
    80002854:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80002858:	00359713          	slli	a4,a1,0x3
    8000285c:	00009797          	auipc	a5,0x9
    80002860:	7ec78793          	addi	a5,a5,2028 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002864:	00e787b3          	add	a5,a5,a4
    80002868:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	e6c080e7          	jalr	-404(ra) # 800026d8 <_ZN5Buddy8compressEm>
            return;
    80002874:	0440006f          	j	800028b8 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80002878:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    8000287c:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80002880:	00000097          	auipc	ra,0x0
    80002884:	e58080e7          	jalr	-424(ra) # 800026d8 <_ZN5Buddy8compressEm>
                    return;
    80002888:	0300006f          	j	800028b8 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    8000288c:	00351713          	slli	a4,a0,0x3
    80002890:	00009797          	auipc	a5,0x9
    80002894:	7b878793          	addi	a5,a5,1976 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002898:	00e787b3          	add	a5,a5,a4
    8000289c:	0107b703          	ld	a4,16(a5)
    800028a0:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800028a4:	0107b703          	ld	a4,16(a5)
    800028a8:	00073703          	ld	a4,0(a4)
    800028ac:	00e7b823          	sd	a4,16(a5)
    compress(size);
    800028b0:	00000097          	auipc	ra,0x0
    800028b4:	e28080e7          	jalr	-472(ra) # 800026d8 <_ZN5Buddy8compressEm>
}
    800028b8:	00813083          	ld	ra,8(sp)
    800028bc:	00013403          	ld	s0,0(sp)
    800028c0:	01010113          	addi	sp,sp,16
    800028c4:	00008067          	ret

00000000800028c8 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800028c8:	02050663          	beqz	a0,800028f4 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800028cc:	ff010113          	addi	sp,sp,-16
    800028d0:	00113423          	sd	ra,8(sp)
    800028d4:	00813023          	sd	s0,0(sp)
    800028d8:	01010413          	addi	s0,sp,16
    insert(addr,size);
    800028dc:	00000097          	auipc	ra,0x0
    800028e0:	f04080e7          	jalr	-252(ra) # 800027e0 <_ZN5Buddy6insertEPvm>
}
    800028e4:	00813083          	ld	ra,8(sp)
    800028e8:	00013403          	ld	s0,0(sp)
    800028ec:	01010113          	addi	sp,sp,16
    800028f0:	00008067          	ret
    800028f4:	00008067          	ret

00000000800028f8 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800028f8:	ff010113          	addi	sp,sp,-16
    800028fc:	00813423          	sd	s0,8(sp)
    80002900:	01010413          	addi	s0,sp,16
    80002904:	03c0006f          	j	80002940 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002908:	00b5859b          	addiw	a1,a1,11
    8000290c:	00100713          	li	a4,1
    80002910:	00b715bb          	sllw	a1,a4,a1
    80002914:	00b505b3          	add	a1,a0,a1
    80002918:	00379693          	slli	a3,a5,0x3
    8000291c:	00009717          	auipc	a4,0x9
    80002920:	72c70713          	addi	a4,a4,1836 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002924:	00d70733          	add	a4,a4,a3
    80002928:	00b73823          	sd	a1,16(a4)
    8000292c:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002930:	0005b023          	sd	zero,0(a1)
    80002934:	07873703          	ld	a4,120(a4)
    80002938:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000293c:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002940:	fff5879b          	addiw	a5,a1,-1
    80002944:	04c7c863          	blt	a5,a2,80002994 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80002948:	00379693          	slli	a3,a5,0x3
    8000294c:	00009717          	auipc	a4,0x9
    80002950:	6fc70713          	addi	a4,a4,1788 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002954:	00d70733          	add	a4,a4,a3
    80002958:	01073683          	ld	a3,16(a4)
    8000295c:	fa0686e3          	beqz	a3,80002908 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002960:	00b5859b          	addiw	a1,a1,11
    80002964:	00100713          	li	a4,1
    80002968:	00b715bb          	sllw	a1,a4,a1
    8000296c:	00b505b3          	add	a1,a0,a1
    80002970:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002974:	00379693          	slli	a3,a5,0x3
    80002978:	00009717          	auipc	a4,0x9
    8000297c:	6d070713          	addi	a4,a4,1744 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002980:	00d70733          	add	a4,a4,a3
    80002984:	01073683          	ld	a3,16(a4)
    80002988:	0006b683          	ld	a3,0(a3)
    8000298c:	00d73823          	sd	a3,16(a4)
    80002990:	fadff06f          	j	8000293c <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80002994:	00813403          	ld	s0,8(sp)
    80002998:	01010113          	addi	sp,sp,16
    8000299c:	00008067          	ret

00000000800029a0 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800029a0:	fe010113          	addi	sp,sp,-32
    800029a4:	00113c23          	sd	ra,24(sp)
    800029a8:	00813823          	sd	s0,16(sp)
    800029ac:	00913423          	sd	s1,8(sp)
    800029b0:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800029b4:	00c00793          	li	a5,12
    800029b8:	06a7ec63          	bltu	a5,a0,80002a30 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800029bc:	00050593          	mv	a1,a0
    800029c0:	00c00793          	li	a5,12
    800029c4:	06b7ea63          	bltu	a5,a1,80002a38 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800029c8:	00359713          	slli	a4,a1,0x3
    800029cc:	00009797          	auipc	a5,0x9
    800029d0:	67c78793          	addi	a5,a5,1660 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029d4:	00e787b3          	add	a5,a5,a4
    800029d8:	0787b483          	ld	s1,120(a5)
    800029dc:	00049663          	bnez	s1,800029e8 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800029e0:	00158593          	addi	a1,a1,1
    800029e4:	fddff06f          	j	800029c0 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    800029e8:	0004b703          	ld	a4,0(s1)
    800029ec:	00359693          	slli	a3,a1,0x3
    800029f0:	00009797          	auipc	a5,0x9
    800029f4:	65878793          	addi	a5,a5,1624 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    800029f8:	00d787b3          	add	a5,a5,a3
    800029fc:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002a00:	00070e63          	beqz	a4,80002a1c <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002a04:	0005061b          	sext.w	a2,a0
    80002a08:	0005859b          	sext.w	a1,a1
    80002a0c:	00048513          	mv	a0,s1
    80002a10:	00000097          	auipc	ra,0x0
    80002a14:	ee8080e7          	jalr	-280(ra) # 800028f8 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002a18:	0240006f          	j	80002a3c <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002a1c:	00009797          	auipc	a5,0x9
    80002a20:	62c78793          	addi	a5,a5,1580 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002a24:	00d787b3          	add	a5,a5,a3
    80002a28:	0007b823          	sd	zero,16(a5)
    80002a2c:	fd9ff06f          	j	80002a04 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002a30:	00000493          	li	s1,0
    80002a34:	0080006f          	j	80002a3c <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002a38:	00000493          	li	s1,0
}
    80002a3c:	00048513          	mv	a0,s1
    80002a40:	01813083          	ld	ra,24(sp)
    80002a44:	01013403          	ld	s0,16(sp)
    80002a48:	00813483          	ld	s1,8(sp)
    80002a4c:	02010113          	addi	sp,sp,32
    80002a50:	00008067          	ret

0000000080002a54 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002a54:	fe010113          	addi	sp,sp,-32
    80002a58:	00113c23          	sd	ra,24(sp)
    80002a5c:	00813823          	sd	s0,16(sp)
    80002a60:	00913423          	sd	s1,8(sp)
    80002a64:	01213023          	sd	s2,0(sp)
    80002a68:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002a6c:	00000913          	li	s2,0
    80002a70:	0180006f          	j	80002a88 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002a74:	00007517          	auipc	a0,0x7
    80002a78:	92450513          	addi	a0,a0,-1756 # 80009398 <CONSOLE_STATUS+0x388>
    80002a7c:	00003097          	auipc	ra,0x3
    80002a80:	818080e7          	jalr	-2024(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002a84:	0019091b          	addiw	s2,s2,1
    80002a88:	00c00793          	li	a5,12
    80002a8c:	0727c663          	blt	a5,s2,80002af8 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002a90:	00000613          	li	a2,0
    80002a94:	00a00593          	li	a1,10
    80002a98:	00090513          	mv	a0,s2
    80002a9c:	00003097          	auipc	ra,0x3
    80002aa0:	83c080e7          	jalr	-1988(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002aa4:	00007517          	auipc	a0,0x7
    80002aa8:	84c50513          	addi	a0,a0,-1972 # 800092f0 <CONSOLE_STATUS+0x2e0>
    80002aac:	00002097          	auipc	ra,0x2
    80002ab0:	7e8080e7          	jalr	2024(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002ab4:	00391713          	slli	a4,s2,0x3
    80002ab8:	00009797          	auipc	a5,0x9
    80002abc:	59078793          	addi	a5,a5,1424 # 8000c048 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002ac0:	00e787b3          	add	a5,a5,a4
    80002ac4:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002ac8:	fa0486e3          	beqz	s1,80002a74 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    80002acc:	00000613          	li	a2,0
    80002ad0:	00a00593          	li	a1,10
    80002ad4:	0004851b          	sext.w	a0,s1
    80002ad8:	00003097          	auipc	ra,0x3
    80002adc:	800080e7          	jalr	-2048(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002ae0:	00006517          	auipc	a0,0x6
    80002ae4:	60850513          	addi	a0,a0,1544 # 800090e8 <CONSOLE_STATUS+0xd8>
    80002ae8:	00002097          	auipc	ra,0x2
    80002aec:	7ac080e7          	jalr	1964(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002af0:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002af4:	fd5ff06f          	j	80002ac8 <_ZN5Buddy9printListEv+0x74>
    80002af8:	01813083          	ld	ra,24(sp)
    80002afc:	01013403          	ld	s0,16(sp)
    80002b00:	00813483          	ld	s1,8(sp)
    80002b04:	00013903          	ld	s2,0(sp)
    80002b08:	02010113          	addi	sp,sp,32
    80002b0c:	00008067          	ret

0000000080002b10 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002b10:	ff010113          	addi	sp,sp,-16
    80002b14:	00113423          	sd	ra,8(sp)
    80002b18:	00813023          	sd	s0,0(sp)
    80002b1c:	01010413          	addi	s0,sp,16
    80002b20:	000105b7          	lui	a1,0x10
    80002b24:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002b28:	00100513          	li	a0,1
    80002b2c:	00000097          	auipc	ra,0x0
    80002b30:	a44080e7          	jalr	-1468(ra) # 80002570 <_Z41__static_initialization_and_destruction_0ii>
    80002b34:	00813083          	ld	ra,8(sp)
    80002b38:	00013403          	ld	s0,0(sp)
    80002b3c:	01010113          	addi	sp,sp,16
    80002b40:	00008067          	ret

0000000080002b44 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002b44:	fe010113          	addi	sp,sp,-32
    80002b48:	00113c23          	sd	ra,24(sp)
    80002b4c:	00813823          	sd	s0,16(sp)
    80002b50:	00913423          	sd	s1,8(sp)
    80002b54:	02010413          	addi	s0,sp,32
    80002b58:	00050493          	mv	s1,a0
    LOCK();
    80002b5c:	00100613          	li	a2,1
    80002b60:	00000593          	li	a1,0
    80002b64:	00009517          	auipc	a0,0x9
    80002b68:	5c450513          	addi	a0,a0,1476 # 8000c128 <lockPrint>
    80002b6c:	ffffe097          	auipc	ra,0xffffe
    80002b70:	494080e7          	jalr	1172(ra) # 80001000 <copy_and_swap>
    80002b74:	fe0514e3          	bnez	a0,80002b5c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002b78:	0004c503          	lbu	a0,0(s1)
    80002b7c:	00050a63          	beqz	a0,80002b90 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002b80:	fffff097          	auipc	ra,0xfffff
    80002b84:	534080e7          	jalr	1332(ra) # 800020b4 <_Z4putcc>
        string++;
    80002b88:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002b8c:	fedff06f          	j	80002b78 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002b90:	00000613          	li	a2,0
    80002b94:	00100593          	li	a1,1
    80002b98:	00009517          	auipc	a0,0x9
    80002b9c:	59050513          	addi	a0,a0,1424 # 8000c128 <lockPrint>
    80002ba0:	ffffe097          	auipc	ra,0xffffe
    80002ba4:	460080e7          	jalr	1120(ra) # 80001000 <copy_and_swap>
    80002ba8:	fe0514e3          	bnez	a0,80002b90 <_Z11printStringPKc+0x4c>
}
    80002bac:	01813083          	ld	ra,24(sp)
    80002bb0:	01013403          	ld	s0,16(sp)
    80002bb4:	00813483          	ld	s1,8(sp)
    80002bb8:	02010113          	addi	sp,sp,32
    80002bbc:	00008067          	ret

0000000080002bc0 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002bc0:	fd010113          	addi	sp,sp,-48
    80002bc4:	02113423          	sd	ra,40(sp)
    80002bc8:	02813023          	sd	s0,32(sp)
    80002bcc:	00913c23          	sd	s1,24(sp)
    80002bd0:	01213823          	sd	s2,16(sp)
    80002bd4:	01313423          	sd	s3,8(sp)
    80002bd8:	01413023          	sd	s4,0(sp)
    80002bdc:	03010413          	addi	s0,sp,48
    80002be0:	00050993          	mv	s3,a0
    80002be4:	00058a13          	mv	s4,a1
    LOCK();
    80002be8:	00100613          	li	a2,1
    80002bec:	00000593          	li	a1,0
    80002bf0:	00009517          	auipc	a0,0x9
    80002bf4:	53850513          	addi	a0,a0,1336 # 8000c128 <lockPrint>
    80002bf8:	ffffe097          	auipc	ra,0xffffe
    80002bfc:	408080e7          	jalr	1032(ra) # 80001000 <copy_and_swap>
    80002c00:	fe0514e3          	bnez	a0,80002be8 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002c04:	00000913          	li	s2,0
    80002c08:	00090493          	mv	s1,s2
    80002c0c:	0019091b          	addiw	s2,s2,1
    80002c10:	03495a63          	bge	s2,s4,80002c44 <_Z9getStringPci+0x84>
        cc = getc();
    80002c14:	fffff097          	auipc	ra,0xfffff
    80002c18:	478080e7          	jalr	1144(ra) # 8000208c <_Z4getcv>
        if(cc < 1)
    80002c1c:	02050463          	beqz	a0,80002c44 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002c20:	009984b3          	add	s1,s3,s1
    80002c24:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002c28:	00a00793          	li	a5,10
    80002c2c:	00f50a63          	beq	a0,a5,80002c40 <_Z9getStringPci+0x80>
    80002c30:	00d00793          	li	a5,13
    80002c34:	fcf51ae3          	bne	a0,a5,80002c08 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80002c38:	00090493          	mv	s1,s2
    80002c3c:	0080006f          	j	80002c44 <_Z9getStringPci+0x84>
    80002c40:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002c44:	009984b3          	add	s1,s3,s1
    80002c48:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002c4c:	00000613          	li	a2,0
    80002c50:	00100593          	li	a1,1
    80002c54:	00009517          	auipc	a0,0x9
    80002c58:	4d450513          	addi	a0,a0,1236 # 8000c128 <lockPrint>
    80002c5c:	ffffe097          	auipc	ra,0xffffe
    80002c60:	3a4080e7          	jalr	932(ra) # 80001000 <copy_and_swap>
    80002c64:	fe0514e3          	bnez	a0,80002c4c <_Z9getStringPci+0x8c>
    return buf;
}
    80002c68:	00098513          	mv	a0,s3
    80002c6c:	02813083          	ld	ra,40(sp)
    80002c70:	02013403          	ld	s0,32(sp)
    80002c74:	01813483          	ld	s1,24(sp)
    80002c78:	01013903          	ld	s2,16(sp)
    80002c7c:	00813983          	ld	s3,8(sp)
    80002c80:	00013a03          	ld	s4,0(sp)
    80002c84:	03010113          	addi	sp,sp,48
    80002c88:	00008067          	ret

0000000080002c8c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002c8c:	ff010113          	addi	sp,sp,-16
    80002c90:	00813423          	sd	s0,8(sp)
    80002c94:	01010413          	addi	s0,sp,16
    80002c98:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002c9c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002ca0:	0006c603          	lbu	a2,0(a3)
    80002ca4:	fd06071b          	addiw	a4,a2,-48
    80002ca8:	0ff77713          	andi	a4,a4,255
    80002cac:	00900793          	li	a5,9
    80002cb0:	02e7e063          	bltu	a5,a4,80002cd0 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002cb4:	0025179b          	slliw	a5,a0,0x2
    80002cb8:	00a787bb          	addw	a5,a5,a0
    80002cbc:	0017979b          	slliw	a5,a5,0x1
    80002cc0:	00168693          	addi	a3,a3,1
    80002cc4:	00c787bb          	addw	a5,a5,a2
    80002cc8:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002ccc:	fd5ff06f          	j	80002ca0 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002cd0:	00813403          	ld	s0,8(sp)
    80002cd4:	01010113          	addi	sp,sp,16
    80002cd8:	00008067          	ret

0000000080002cdc <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002cdc:	fc010113          	addi	sp,sp,-64
    80002ce0:	02113c23          	sd	ra,56(sp)
    80002ce4:	02813823          	sd	s0,48(sp)
    80002ce8:	02913423          	sd	s1,40(sp)
    80002cec:	03213023          	sd	s2,32(sp)
    80002cf0:	01313c23          	sd	s3,24(sp)
    80002cf4:	04010413          	addi	s0,sp,64
    80002cf8:	00050493          	mv	s1,a0
    80002cfc:	00058913          	mv	s2,a1
    80002d00:	00060993          	mv	s3,a2
    LOCK();
    80002d04:	00100613          	li	a2,1
    80002d08:	00000593          	li	a1,0
    80002d0c:	00009517          	auipc	a0,0x9
    80002d10:	41c50513          	addi	a0,a0,1052 # 8000c128 <lockPrint>
    80002d14:	ffffe097          	auipc	ra,0xffffe
    80002d18:	2ec080e7          	jalr	748(ra) # 80001000 <copy_and_swap>
    80002d1c:	fe0514e3          	bnez	a0,80002d04 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002d20:	00098463          	beqz	s3,80002d28 <_Z8printIntiii+0x4c>
    80002d24:	0804c463          	bltz	s1,80002dac <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002d28:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002d2c:	00000593          	li	a1,0
    }

    i = 0;
    80002d30:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002d34:	0009079b          	sext.w	a5,s2
    80002d38:	0325773b          	remuw	a4,a0,s2
    80002d3c:	00048613          	mv	a2,s1
    80002d40:	0014849b          	addiw	s1,s1,1
    80002d44:	02071693          	slli	a3,a4,0x20
    80002d48:	0206d693          	srli	a3,a3,0x20
    80002d4c:	00009717          	auipc	a4,0x9
    80002d50:	07470713          	addi	a4,a4,116 # 8000bdc0 <digits>
    80002d54:	00d70733          	add	a4,a4,a3
    80002d58:	00074683          	lbu	a3,0(a4)
    80002d5c:	fd040713          	addi	a4,s0,-48
    80002d60:	00c70733          	add	a4,a4,a2
    80002d64:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002d68:	0005071b          	sext.w	a4,a0
    80002d6c:	0325553b          	divuw	a0,a0,s2
    80002d70:	fcf772e3          	bgeu	a4,a5,80002d34 <_Z8printIntiii+0x58>
    if(neg)
    80002d74:	00058c63          	beqz	a1,80002d8c <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002d78:	fd040793          	addi	a5,s0,-48
    80002d7c:	009784b3          	add	s1,a5,s1
    80002d80:	02d00793          	li	a5,45
    80002d84:	fef48823          	sb	a5,-16(s1)
    80002d88:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002d8c:	fff4849b          	addiw	s1,s1,-1
    80002d90:	0204c463          	bltz	s1,80002db8 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002d94:	fd040793          	addi	a5,s0,-48
    80002d98:	009787b3          	add	a5,a5,s1
    80002d9c:	ff07c503          	lbu	a0,-16(a5)
    80002da0:	fffff097          	auipc	ra,0xfffff
    80002da4:	314080e7          	jalr	788(ra) # 800020b4 <_Z4putcc>
    80002da8:	fe5ff06f          	j	80002d8c <_Z8printIntiii+0xb0>
        x = -xx;
    80002dac:	4090053b          	negw	a0,s1
        neg = 1;
    80002db0:	00100593          	li	a1,1
        x = -xx;
    80002db4:	f7dff06f          	j	80002d30 <_Z8printIntiii+0x54>

    UNLOCK();
    80002db8:	00000613          	li	a2,0
    80002dbc:	00100593          	li	a1,1
    80002dc0:	00009517          	auipc	a0,0x9
    80002dc4:	36850513          	addi	a0,a0,872 # 8000c128 <lockPrint>
    80002dc8:	ffffe097          	auipc	ra,0xffffe
    80002dcc:	238080e7          	jalr	568(ra) # 80001000 <copy_and_swap>
    80002dd0:	fe0514e3          	bnez	a0,80002db8 <_Z8printIntiii+0xdc>
    80002dd4:	03813083          	ld	ra,56(sp)
    80002dd8:	03013403          	ld	s0,48(sp)
    80002ddc:	02813483          	ld	s1,40(sp)
    80002de0:	02013903          	ld	s2,32(sp)
    80002de4:	01813983          	ld	s3,24(sp)
    80002de8:	04010113          	addi	sp,sp,64
    80002dec:	00008067          	ret

0000000080002df0 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002df0:	ff010113          	addi	sp,sp,-16
    80002df4:	00813423          	sd	s0,8(sp)
    80002df8:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002dfc:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002e00:	00053823          	sd	zero,16(a0)
}
    80002e04:	00813403          	ld	s0,8(sp)
    80002e08:	01010113          	addi	sp,sp,16
    80002e0c:	00008067          	ret

0000000080002e10 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002e10:	ff010113          	addi	sp,sp,-16
    80002e14:	00813423          	sd	s0,8(sp)
    80002e18:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002e1c:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002e20:	00053823          	sd	zero,16(a0)
    80002e24:	00813403          	ld	s0,8(sp)
    80002e28:	01010113          	addi	sp,sp,16
    80002e2c:	00008067          	ret

0000000080002e30 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002e30:	ff010113          	addi	sp,sp,-16
    80002e34:	00113423          	sd	ra,8(sp)
    80002e38:	00813023          	sd	s0,0(sp)
    80002e3c:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    80002e40:	00000697          	auipc	a3,0x0
    80002e44:	fd068693          	addi	a3,a3,-48 # 80002e10 <_ZN3SCB4dtorEPv>
    80002e48:	00000617          	auipc	a2,0x0
    80002e4c:	fa860613          	addi	a2,a2,-88 # 80002df0 <_ZN3SCB4ctorEPv>
    80002e50:	01800593          	li	a1,24
    80002e54:	00006517          	auipc	a0,0x6
    80002e58:	4a450513          	addi	a0,a0,1188 # 800092f8 <CONSOLE_STATUS+0x2e8>
    80002e5c:	00002097          	auipc	ra,0x2
    80002e60:	608080e7          	jalr	1544(ra) # 80005464 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002e64:	00009797          	auipc	a5,0x9
    80002e68:	2ca7b623          	sd	a0,716(a5) # 8000c130 <_ZN3SCB8scbCacheE>
}
    80002e6c:	00813083          	ld	ra,8(sp)
    80002e70:	00013403          	ld	s0,0(sp)
    80002e74:	01010113          	addi	sp,sp,16
    80002e78:	00008067          	ret

0000000080002e7c <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002e7c:	ff010113          	addi	sp,sp,-16
    80002e80:	00813423          	sd	s0,8(sp)
    80002e84:	01010413          	addi	s0,sp,16
    val = init;
    80002e88:	00b52023          	sw	a1,0(a0)
}
    80002e8c:	00813403          	ld	s0,8(sp)
    80002e90:	01010113          	addi	sp,sp,16
    80002e94:	00008067          	ret

0000000080002e98 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002e98:	fe010113          	addi	sp,sp,-32
    80002e9c:	00113c23          	sd	ra,24(sp)
    80002ea0:	00813823          	sd	s0,16(sp)
    80002ea4:	00913423          	sd	s1,8(sp)
    80002ea8:	01213023          	sd	s2,0(sp)
    80002eac:	02010413          	addi	s0,sp,32
    80002eb0:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002eb4:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002eb8:	02050063          	beqz	a0,80002ed8 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002ebc:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002ec0:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002ec4:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002ec8:	00002097          	auipc	ra,0x2
    80002ecc:	f00080e7          	jalr	-256(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002ed0:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002ed4:	fe5ff06f          	j	80002eb8 <_ZN3SCBD1Ev+0x20>
}
    80002ed8:	01813083          	ld	ra,24(sp)
    80002edc:	01013403          	ld	s0,16(sp)
    80002ee0:	00813483          	ld	s1,8(sp)
    80002ee4:	00013903          	ld	s2,0(sp)
    80002ee8:	02010113          	addi	sp,sp,32
    80002eec:	00008067          	ret

0000000080002ef0 <_ZN3SCB5blockEv>:
void SCB::block() {
    80002ef0:	ff010113          	addi	sp,sp,-16
    80002ef4:	00113423          	sd	ra,8(sp)
    80002ef8:	00813023          	sd	s0,0(sp)
    80002efc:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002f00:	00853783          	ld	a5,8(a0)
    80002f04:	04078063          	beqz	a5,80002f44 <_ZN3SCB5blockEv+0x54>
    80002f08:	01053703          	ld	a4,16(a0)
    80002f0c:	00009797          	auipc	a5,0x9
    80002f10:	0447b783          	ld	a5,68(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002f14:	0007b783          	ld	a5,0(a5)
    80002f18:	04f73423          	sd	a5,72(a4)
    80002f1c:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002f20:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002f24:	00300713          	li	a4,3
    80002f28:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002f2c:	00000097          	auipc	ra,0x0
    80002f30:	314080e7          	jalr	788(ra) # 80003240 <_ZN3TCB8dispatchEv>
}
    80002f34:	00813083          	ld	ra,8(sp)
    80002f38:	00013403          	ld	s0,0(sp)
    80002f3c:	01010113          	addi	sp,sp,16
    80002f40:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002f44:	00009797          	auipc	a5,0x9
    80002f48:	00c7b783          	ld	a5,12(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002f4c:	0007b783          	ld	a5,0(a5)
    80002f50:	00f53423          	sd	a5,8(a0)
    80002f54:	fc9ff06f          	j	80002f1c <_ZN3SCB5blockEv+0x2c>

0000000080002f58 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80002f58:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002f5c:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002f60:	04853703          	ld	a4,72(a0)
    80002f64:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002f68:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002f6c:	02050a63          	beqz	a0,80002fa0 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002f70:	ff010113          	addi	sp,sp,-16
    80002f74:	00113423          	sd	ra,8(sp)
    80002f78:	00813023          	sd	s0,0(sp)
    80002f7c:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002f80:	00100793          	li	a5,1
    80002f84:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002f88:	00002097          	auipc	ra,0x2
    80002f8c:	e40080e7          	jalr	-448(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
}
    80002f90:	00813083          	ld	ra,8(sp)
    80002f94:	00013403          	ld	s0,0(sp)
    80002f98:	01010113          	addi	sp,sp,16
    80002f9c:	00008067          	ret
    80002fa0:	00008067          	ret

0000000080002fa4 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002fa4:	00009797          	auipc	a5,0x9
    80002fa8:	fac7b783          	ld	a5,-84(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002fac:	0007b783          	ld	a5,0(a5)
    80002fb0:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002fb4:	00052783          	lw	a5,0(a0)
    80002fb8:	fff7879b          	addiw	a5,a5,-1
    80002fbc:	00f52023          	sw	a5,0(a0)
    80002fc0:	02079713          	slli	a4,a5,0x20
    80002fc4:	00074463          	bltz	a4,80002fcc <_ZN3SCB4waitEv+0x28>
    80002fc8:	00008067          	ret
void SCB::wait() {
    80002fcc:	ff010113          	addi	sp,sp,-16
    80002fd0:	00113423          	sd	ra,8(sp)
    80002fd4:	00813023          	sd	s0,0(sp)
    80002fd8:	01010413          	addi	s0,sp,16
        block();
    80002fdc:	00000097          	auipc	ra,0x0
    80002fe0:	f14080e7          	jalr	-236(ra) # 80002ef0 <_ZN3SCB5blockEv>
}
    80002fe4:	00813083          	ld	ra,8(sp)
    80002fe8:	00013403          	ld	s0,0(sp)
    80002fec:	01010113          	addi	sp,sp,16
    80002ff0:	00008067          	ret

0000000080002ff4 <_ZN3SCB6signalEv>:
    if(val++<0)
    80002ff4:	00052783          	lw	a5,0(a0)
    80002ff8:	0017871b          	addiw	a4,a5,1
    80002ffc:	00e52023          	sw	a4,0(a0)
    80003000:	0007c463          	bltz	a5,80003008 <_ZN3SCB6signalEv+0x14>
    80003004:	00008067          	ret
void SCB::signal(){
    80003008:	ff010113          	addi	sp,sp,-16
    8000300c:	00113423          	sd	ra,8(sp)
    80003010:	00813023          	sd	s0,0(sp)
    80003014:	01010413          	addi	s0,sp,16
        deblock();
    80003018:	00000097          	auipc	ra,0x0
    8000301c:	f40080e7          	jalr	-192(ra) # 80002f58 <_ZN3SCB7deblockEv>
}
    80003020:	00813083          	ld	ra,8(sp)
    80003024:	00013403          	ld	s0,0(sp)
    80003028:	01010113          	addi	sp,sp,16
    8000302c:	00008067          	ret

0000000080003030 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80003030:	ff010113          	addi	sp,sp,-16
    80003034:	00113423          	sd	ra,8(sp)
    80003038:	00813023          	sd	s0,0(sp)
    8000303c:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80003040:	00009517          	auipc	a0,0x9
    80003044:	0f053503          	ld	a0,240(a0) # 8000c130 <_ZN3SCB8scbCacheE>
    80003048:	00002097          	auipc	ra,0x2
    8000304c:	444080e7          	jalr	1092(ra) # 8000548c <_Z16kmem_cache_allocP5Cache>
}
    80003050:	00813083          	ld	ra,8(sp)
    80003054:	00013403          	ld	s0,0(sp)
    80003058:	01010113          	addi	sp,sp,16
    8000305c:	00008067          	ret

0000000080003060 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80003060:	ff010113          	addi	sp,sp,-16
    80003064:	00113423          	sd	ra,8(sp)
    80003068:	00813023          	sd	s0,0(sp)
    8000306c:	01010413          	addi	s0,sp,16
    80003070:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80003074:	00009517          	auipc	a0,0x9
    80003078:	0bc53503          	ld	a0,188(a0) # 8000c130 <_ZN3SCB8scbCacheE>
    8000307c:	00002097          	auipc	ra,0x2
    80003080:	438080e7          	jalr	1080(ra) # 800054b4 <_Z15kmem_cache_freeP5CachePv>
}
    80003084:	00813083          	ld	ra,8(sp)
    80003088:	00013403          	ld	s0,0(sp)
    8000308c:	01010113          	addi	sp,sp,16
    80003090:	00008067          	ret

0000000080003094 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80003094:	ff010113          	addi	sp,sp,-16
    80003098:	00813423          	sd	s0,8(sp)
    8000309c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    800030a0:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    800030a4:	05200513          	li	a0,82
    asm("ecall");
    800030a8:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    800030ac:	00050513          	mv	a0,a0
}
    800030b0:	0005051b          	sext.w	a0,a0
    800030b4:	00813403          	ld	s0,8(sp)
    800030b8:	01010113          	addi	sp,sp,16
    800030bc:	00008067          	ret

00000000800030c0 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    800030c0:	fe010113          	addi	sp,sp,-32
    800030c4:	00113c23          	sd	ra,24(sp)
    800030c8:	00813823          	sd	s0,16(sp)
    800030cc:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    800030d0:	fe840513          	addi	a0,s0,-24
    800030d4:	fffff097          	auipc	ra,0xfffff
    800030d8:	1ac080e7          	jalr	428(ra) # 80002280 <_ZN6SystemC1Ev>

    return 0;
    800030dc:	00000513          	li	a0,0
    800030e0:	01813083          	ld	ra,24(sp)
    800030e4:	01013403          	ld	s0,16(sp)
    800030e8:	02010113          	addi	sp,sp,32
    800030ec:	00008067          	ret

00000000800030f0 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    800030f0:	ff010113          	addi	sp,sp,-16
    800030f4:	00813423          	sd	s0,8(sp)
    800030f8:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    800030fc:	00100793          	li	a5,1
    80003100:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80003104:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80003108:	00052a23          	sw	zero,20(a0)
}
    8000310c:	00813403          	ld	s0,8(sp)
    80003110:	01010113          	addi	sp,sp,16
    80003114:	00008067          	ret

0000000080003118 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80003118:	ff010113          	addi	sp,sp,-16
    8000311c:	00813423          	sd	s0,8(sp)
    80003120:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80003124:	00100793          	li	a5,1
    80003128:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    8000312c:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80003130:	00052a23          	sw	zero,20(a0)
    80003134:	00813403          	ld	s0,8(sp)
    80003138:	01010113          	addi	sp,sp,16
    8000313c:	00008067          	ret

0000000080003140 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00113423          	sd	ra,8(sp)
    80003148:	00813023          	sd	s0,0(sp)
    8000314c:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80003150:	00001097          	auipc	ra,0x1
    80003154:	d3c080e7          	jalr	-708(ra) # 80003e8c <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80003158:	00009797          	auipc	a5,0x9
    8000315c:	fe07b783          	ld	a5,-32(a5) # 8000c138 <_ZN3TCB7runningE>
    80003160:	0187b703          	ld	a4,24(a5)
    80003164:	0207b503          	ld	a0,32(a5)
    80003168:	000700e7          	jalr	a4
    thread_exit();
    8000316c:	fffff097          	auipc	ra,0xfffff
    80003170:	d24080e7          	jalr	-732(ra) # 80001e90 <_Z11thread_exitv>
}
    80003174:	00813083          	ld	ra,8(sp)
    80003178:	00013403          	ld	s0,0(sp)
    8000317c:	01010113          	addi	sp,sp,16
    80003180:	00008067          	ret

0000000080003184 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80003184:	ff010113          	addi	sp,sp,-16
    80003188:	00813423          	sd	s0,8(sp)
    8000318c:	01010413          	addi	s0,sp,16
    80003190:	04053823          	sd	zero,80(a0)
    80003194:	04053c23          	sd	zero,88(a0)
    80003198:	06053023          	sd	zero,96(a0)
    this->body = body;
    8000319c:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    800031a0:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    800031a4:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    800031a8:	02058a63          	beqz	a1,800031dc <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    800031ac:	00068793          	mv	a5,a3
    800031b0:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    800031b4:	02058863          	beqz	a1,800031e4 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    800031b8:	000017b7          	lui	a5,0x1
    800031bc:	00f686b3          	add	a3,a3,a5
    800031c0:	00d53023          	sd	a3,0(a0)
    800031c4:	00000797          	auipc	a5,0x0
    800031c8:	f7c78793          	addi	a5,a5,-132 # 80003140 <_ZN3TCB7wrapperEPv>
    800031cc:	00f53423          	sd	a5,8(a0)
}
    800031d0:	00813403          	ld	s0,8(sp)
    800031d4:	01010113          	addi	sp,sp,16
    800031d8:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    800031dc:	00000793          	li	a5,0
    800031e0:	fd1ff06f          	j	800031b0 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    800031e4:	00000693          	li	a3,0
    800031e8:	fd9ff06f          	j	800031c0 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

00000000800031ec <_ZN3TCB4freeEv>:
void TCB::free(){
    800031ec:	ff010113          	addi	sp,sp,-16
    800031f0:	00113423          	sd	ra,8(sp)
    800031f4:	00813023          	sd	s0,0(sp)
    800031f8:	01010413          	addi	s0,sp,16
    kfree(stack);
    800031fc:	02853503          	ld	a0,40(a0)
    80003200:	00002097          	auipc	ra,0x2
    80003204:	384080e7          	jalr	900(ra) # 80005584 <_Z5kfreePKv>
}
    80003208:	00813083          	ld	ra,8(sp)
    8000320c:	00013403          	ld	s0,0(sp)
    80003210:	01010113          	addi	sp,sp,16
    80003214:	00008067          	ret

0000000080003218 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80003218:	ff010113          	addi	sp,sp,-16
    8000321c:	00113423          	sd	ra,8(sp)
    80003220:	00813023          	sd	s0,0(sp)
    80003224:	01010413          	addi	s0,sp,16
    free();
    80003228:	00000097          	auipc	ra,0x0
    8000322c:	fc4080e7          	jalr	-60(ra) # 800031ec <_ZN3TCB4freeEv>
}
    80003230:	00813083          	ld	ra,8(sp)
    80003234:	00013403          	ld	s0,0(sp)
    80003238:	01010113          	addi	sp,sp,16
    8000323c:	00008067          	ret

0000000080003240 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80003240:	fe010113          	addi	sp,sp,-32
    80003244:	00113c23          	sd	ra,24(sp)
    80003248:	00813823          	sd	s0,16(sp)
    8000324c:	00913423          	sd	s1,8(sp)
    80003250:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80003254:	00009497          	auipc	s1,0x9
    80003258:	ee44b483          	ld	s1,-284(s1) # 8000c138 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    8000325c:	0104a703          	lw	a4,16(s1)
    80003260:	00100793          	li	a5,1
    80003264:	04e7f663          	bgeu	a5,a4,800032b0 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80003268:	00002097          	auipc	ra,0x2
    8000326c:	ba8080e7          	jalr	-1112(ra) # 80004e10 <_ZN9Scheduler3getEv>
    80003270:	00009797          	auipc	a5,0x9
    80003274:	eca7b423          	sd	a0,-312(a5) # 8000c138 <_ZN3TCB7runningE>
    if(running) {
    80003278:	02050263          	beqz	a0,8000329c <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    8000327c:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80003280:	00001097          	auipc	ra,0x1
    80003284:	d40080e7          	jalr	-704(ra) # 80003fc0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80003288:	00009597          	auipc	a1,0x9
    8000328c:	eb05b583          	ld	a1,-336(a1) # 8000c138 <_ZN3TCB7runningE>
    80003290:	00048513          	mv	a0,s1
    80003294:	ffffe097          	auipc	ra,0xffffe
    80003298:	eac080e7          	jalr	-340(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    8000329c:	01813083          	ld	ra,24(sp)
    800032a0:	01013403          	ld	s0,16(sp)
    800032a4:	00813483          	ld	s1,8(sp)
    800032a8:	02010113          	addi	sp,sp,32
    800032ac:	00008067          	ret
        Scheduler::put(old);
    800032b0:	00048513          	mv	a0,s1
    800032b4:	00002097          	auipc	ra,0x2
    800032b8:	b14080e7          	jalr	-1260(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
    800032bc:	fadff06f          	j	80003268 <_ZN3TCB8dispatchEv+0x28>

00000000800032c0 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    800032c0:	ff010113          	addi	sp,sp,-16
    800032c4:	00113423          	sd	ra,8(sp)
    800032c8:	00813023          	sd	s0,0(sp)
    800032cc:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    800032d0:	00009517          	auipc	a0,0x9
    800032d4:	e7053503          	ld	a0,-400(a0) # 8000c140 <_ZN3TCB8tcbCacheE>
    800032d8:	00002097          	auipc	ra,0x2
    800032dc:	1b4080e7          	jalr	436(ra) # 8000548c <_Z16kmem_cache_allocP5Cache>
}
    800032e0:	00813083          	ld	ra,8(sp)
    800032e4:	00013403          	ld	s0,0(sp)
    800032e8:	01010113          	addi	sp,sp,16
    800032ec:	00008067          	ret

00000000800032f0 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    800032f0:	fe010113          	addi	sp,sp,-32
    800032f4:	00113c23          	sd	ra,24(sp)
    800032f8:	00813823          	sd	s0,16(sp)
    800032fc:	00913423          	sd	s1,8(sp)
    80003300:	01213023          	sd	s2,0(sp)
    80003304:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80003308:	00000697          	auipc	a3,0x0
    8000330c:	e1068693          	addi	a3,a3,-496 # 80003118 <_ZN3TCB4dtorEPv>
    80003310:	00000617          	auipc	a2,0x0
    80003314:	de060613          	addi	a2,a2,-544 # 800030f0 <_ZN3TCB4ctorEPv>
    80003318:	07000593          	li	a1,112
    8000331c:	00006517          	auipc	a0,0x6
    80003320:	fec50513          	addi	a0,a0,-20 # 80009308 <CONSOLE_STATUS+0x2f8>
    80003324:	00002097          	auipc	ra,0x2
    80003328:	140080e7          	jalr	320(ra) # 80005464 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000332c:	00009797          	auipc	a5,0x9
    80003330:	e0a7ba23          	sd	a0,-492(a5) # 8000c140 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80003334:	07000513          	li	a0,112
    80003338:	00000097          	auipc	ra,0x0
    8000333c:	f88080e7          	jalr	-120(ra) # 800032c0 <_ZN3TCBnwEm>
    80003340:	00050493          	mv	s1,a0
    80003344:	00050e63          	beqz	a0,80003360 <_ZN3TCB10initializeEv+0x70>
    80003348:	00200713          	li	a4,2
    8000334c:	00000693          	li	a3,0
    80003350:	00000613          	li	a2,0
    80003354:	00000593          	li	a1,0
    80003358:	00000097          	auipc	ra,0x0
    8000335c:	e2c080e7          	jalr	-468(ra) # 80003184 <_ZN3TCBC1EPFvPvES0_Pmm>
    80003360:	00009797          	auipc	a5,0x9
    80003364:	dc97bc23          	sd	s1,-552(a5) # 8000c138 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    80003368:	00100793          	li	a5,1
    8000336c:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003370:	00001537          	lui	a0,0x1
    80003374:	00002097          	auipc	ra,0x2
    80003378:	1e8080e7          	jalr	488(ra) # 8000555c <_Z7kmallocm>
    8000337c:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80003380:	07000513          	li	a0,112
    80003384:	00000097          	auipc	ra,0x0
    80003388:	f3c080e7          	jalr	-196(ra) # 800032c0 <_ZN3TCBnwEm>
    8000338c:	00050493          	mv	s1,a0
    80003390:	02050063          	beqz	a0,800033b0 <_ZN3TCB10initializeEv+0xc0>
    80003394:	00200713          	li	a4,2
    80003398:	00090693          	mv	a3,s2
    8000339c:	00000613          	li	a2,0
    800033a0:	00009597          	auipc	a1,0x9
    800033a4:	b505b583          	ld	a1,-1200(a1) # 8000bef0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800033a8:	00000097          	auipc	ra,0x0
    800033ac:	ddc080e7          	jalr	-548(ra) # 80003184 <_ZN3TCBC1EPFvPvES0_Pmm>
    800033b0:	00009797          	auipc	a5,0x9
    800033b4:	d897bc23          	sd	s1,-616(a5) # 8000c148 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    800033b8:	00100793          	li	a5,1
    800033bc:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    800033c0:	00048513          	mv	a0,s1
    800033c4:	00002097          	auipc	ra,0x2
    800033c8:	a04080e7          	jalr	-1532(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
}
    800033cc:	01813083          	ld	ra,24(sp)
    800033d0:	01013403          	ld	s0,16(sp)
    800033d4:	00813483          	ld	s1,8(sp)
    800033d8:	00013903          	ld	s2,0(sp)
    800033dc:	02010113          	addi	sp,sp,32
    800033e0:	00008067          	ret

00000000800033e4 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    800033e4:	ff010113          	addi	sp,sp,-16
    800033e8:	00113423          	sd	ra,8(sp)
    800033ec:	00813023          	sd	s0,0(sp)
    800033f0:	01010413          	addi	s0,sp,16
    800033f4:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    800033f8:	00009517          	auipc	a0,0x9
    800033fc:	d4853503          	ld	a0,-696(a0) # 8000c140 <_ZN3TCB8tcbCacheE>
    80003400:	00002097          	auipc	ra,0x2
    80003404:	0b4080e7          	jalr	180(ra) # 800054b4 <_Z15kmem_cache_freeP5CachePv>
}
    80003408:	00813083          	ld	ra,8(sp)
    8000340c:	00013403          	ld	s0,0(sp)
    80003410:	01010113          	addi	sp,sp,16
    80003414:	00008067          	ret

0000000080003418 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80003418:	ff010113          	addi	sp,sp,-16
    8000341c:	00813423          	sd	s0,8(sp)
    80003420:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003424:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80003428:	05100513          	li	a0,81
    asm("ecall");
    8000342c:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80003430:	00050513          	mv	a0,a0
}
    80003434:	0005051b          	sext.w	a0,a0
    80003438:	00813403          	ld	s0,8(sp)
    8000343c:	01010113          	addi	sp,sp,16
    80003440:	00008067          	ret

0000000080003444 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80003444:	ff010113          	addi	sp,sp,-16
    80003448:	00813423          	sd	s0,8(sp)
    8000344c:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80003450:	00009797          	auipc	a5,0x9
    80003454:	a907b783          	ld	a5,-1392(a5) # 8000bee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003458:	0007b783          	ld	a5,0(a5)
    8000345c:	00c7d793          	srli	a5,a5,0xc
    80003460:	00278793          	addi	a5,a5,2
    80003464:	00c79793          	slli	a5,a5,0xc
    80003468:	01000737          	lui	a4,0x1000
    8000346c:	00e787b3          	add	a5,a5,a4
    80003470:	00009717          	auipc	a4,0x9
    80003474:	cf870713          	addi	a4,a4,-776 # 8000c168 <_ZN15MemoryAllocator11freeMemTailE>
    80003478:	00f73023          	sd	a5,0(a4)
    8000347c:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80003480:	0007b823          	sd	zero,16(a5)
    80003484:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003488:	00073823          	sd	zero,16(a4)
    8000348c:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80003490:	00009697          	auipc	a3,0x9
    80003494:	ad06b683          	ld	a3,-1328(a3) # 8000bf60 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003498:	0006b683          	ld	a3,0(a3)
    8000349c:	40f686b3          	sub	a3,a3,a5
    800034a0:	fe868693          	addi	a3,a3,-24
    800034a4:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800034a8:	00873783          	ld	a5,8(a4)
    800034ac:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800034b0:	00100793          	li	a5,1
    800034b4:	02f70023          	sb	a5,32(a4)
}
    800034b8:	00813403          	ld	s0,8(sp)
    800034bc:	01010113          	addi	sp,sp,16
    800034c0:	00008067          	ret

00000000800034c4 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800034c4:	ff010113          	addi	sp,sp,-16
    800034c8:	00813423          	sd	s0,8(sp)
    800034cc:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    800034d0:	14050663          	beqz	a0,8000361c <_ZN15MemoryAllocator7kmallocEm+0x158>
    800034d4:	00050793          	mv	a5,a0
    800034d8:	00009517          	auipc	a0,0x9
    800034dc:	c9853503          	ld	a0,-872(a0) # 8000c170 <_ZN15MemoryAllocator11freeMemHeadE>
    800034e0:	0a050e63          	beqz	a0,8000359c <_ZN15MemoryAllocator7kmallocEm+0xd8>
    800034e4:	00053703          	ld	a4,0(a0)
    800034e8:	12f76e63          	bltu	a4,a5,80003624 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800034ec:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    800034f0:	00000613          	li	a2,0
    800034f4:	00c0006f          	j	80003500 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800034f8:	00050613          	mv	a2,a0
    800034fc:	01053503          	ld	a0,16(a0)
    80003500:	00050863          	beqz	a0,80003510 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80003504:	00053683          	ld	a3,0(a0)
    80003508:	01878713          	addi	a4,a5,24
    8000350c:	fee6e6e3          	bltu	a3,a4,800034f8 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80003510:	08050663          	beqz	a0,8000359c <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80003514:	00053683          	ld	a3,0(a0)
    80003518:	01868713          	addi	a4,a3,24
    8000351c:	00e50733          	add	a4,a0,a4
    80003520:	00009597          	auipc	a1,0x9
    80003524:	a405b583          	ld	a1,-1472(a1) # 8000bf60 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003528:	0005b583          	ld	a1,0(a1)
    8000352c:	00b76463          	bltu	a4,a1,80003534 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80003530:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80003534:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80003538:	05700593          	li	a1,87
    8000353c:	08d5f063          	bgeu	a1,a3,800035bc <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    80003540:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80003544:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80003548:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    8000354c:	01053583          	ld	a1,16(a0)
    80003550:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80003554:	00853583          	ld	a1,8(a0)
    80003558:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    8000355c:	fe868693          	addi	a3,a3,-24
    80003560:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003564:	04060263          	beqz	a2,800035a8 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80003568:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    8000356c:	00009797          	auipc	a5,0x9
    80003570:	c147b783          	ld	a5,-1004(a5) # 8000c180 <_ZN15MemoryAllocator12allocMemHeadE>
    80003574:	06078463          	beqz	a5,800035dc <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80003578:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    8000357c:	08070063          	beqz	a4,800035fc <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80003580:	00873783          	ld	a5,8(a4)
    80003584:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003588:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    8000358c:	00873783          	ld	a5,8(a4)
    80003590:	06078063          	beqz	a5,800035f0 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80003594:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003598:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    8000359c:	00813403          	ld	s0,8(sp)
    800035a0:	01010113          	addi	sp,sp,16
    800035a4:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800035a8:	00009697          	auipc	a3,0x9
    800035ac:	bc068693          	addi	a3,a3,-1088 # 8000c168 <_ZN15MemoryAllocator11freeMemTailE>
    800035b0:	00f6b023          	sd	a5,0(a3)
    800035b4:	00f6b423          	sd	a5,8(a3)
    800035b8:	fb5ff06f          	j	8000356c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    800035bc:	00060863          	beqz	a2,800035cc <_ZN15MemoryAllocator7kmallocEm+0x108>
    800035c0:	01053783          	ld	a5,16(a0)
    800035c4:	00f63823          	sd	a5,16(a2)
    800035c8:	fa5ff06f          	j	8000356c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    800035cc:	01053783          	ld	a5,16(a0)
    800035d0:	00009697          	auipc	a3,0x9
    800035d4:	baf6b023          	sd	a5,-1120(a3) # 8000c170 <_ZN15MemoryAllocator11freeMemHeadE>
    800035d8:	f95ff06f          	j	8000356c <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    800035dc:	00009797          	auipc	a5,0x9
    800035e0:	b8c78793          	addi	a5,a5,-1140 # 8000c168 <_ZN15MemoryAllocator11freeMemTailE>
    800035e4:	00a7b823          	sd	a0,16(a5)
    800035e8:	00a7bc23          	sd	a0,24(a5)
    800035ec:	fadff06f          	j	80003598 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    800035f0:	00009797          	auipc	a5,0x9
    800035f4:	b8a7b823          	sd	a0,-1136(a5) # 8000c180 <_ZN15MemoryAllocator12allocMemHeadE>
    800035f8:	fa1ff06f          	j	80003598 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    800035fc:	00009797          	auipc	a5,0x9
    80003600:	b6c78793          	addi	a5,a5,-1172 # 8000c168 <_ZN15MemoryAllocator11freeMemTailE>
    80003604:	0107b703          	ld	a4,16(a5)
    80003608:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    8000360c:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80003610:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80003614:	00a7b823          	sd	a0,16(a5)
    80003618:	f81ff06f          	j	80003598 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    8000361c:	00000513          	li	a0,0
    80003620:	f7dff06f          	j	8000359c <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80003624:	00000513          	li	a0,0
    80003628:	f75ff06f          	j	8000359c <_ZN15MemoryAllocator7kmallocEm+0xd8>

000000008000362c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    8000362c:	ff010113          	addi	sp,sp,-16
    80003630:	00813423          	sd	s0,8(sp)
    80003634:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80003638:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    8000363c:	00000713          	li	a4,0
    80003640:	00078a63          	beqz	a5,80003654 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80003644:	00a7f863          	bgeu	a5,a0,80003654 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003648:	00078713          	mv	a4,a5
    8000364c:	0107b783          	ld	a5,16(a5)
    80003650:	ff1ff06f          	j	80003640 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80003654:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003658:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    8000365c:	00078463          	beqz	a5,80003664 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80003660:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003664:	02070263          	beqz	a4,80003688 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003668:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    8000366c:	0005b703          	ld	a4,0(a1)
    80003670:	00009797          	auipc	a5,0x9
    80003674:	b007b783          	ld	a5,-1280(a5) # 8000c170 <_ZN15MemoryAllocator11freeMemHeadE>
    80003678:	00f70c63          	beq	a4,a5,80003690 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    8000367c:	00813403          	ld	s0,8(sp)
    80003680:	01010113          	addi	sp,sp,16
    80003684:	00008067          	ret
        *head = blk;
    80003688:	00a5b023          	sd	a0,0(a1)
    8000368c:	fe1ff06f          	j	8000366c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80003690:	01053783          	ld	a5,16(a0)
    80003694:	00078a63          	beqz	a5,800036a8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003698:	00053683          	ld	a3,0(a0)
    8000369c:	00d50733          	add	a4,a0,a3
    800036a0:	01870713          	addi	a4,a4,24
    800036a4:	02f70e63          	beq	a4,a5,800036e0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    800036a8:	00853783          	ld	a5,8(a0)
    800036ac:	fc0788e3          	beqz	a5,8000367c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800036b0:	0007b683          	ld	a3,0(a5)
    800036b4:	00d78733          	add	a4,a5,a3
    800036b8:	01870713          	addi	a4,a4,24
    800036bc:	fca710e3          	bne	a4,a0,8000367c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800036c0:	00053703          	ld	a4,0(a0)
    800036c4:	00e68733          	add	a4,a3,a4
    800036c8:	01870713          	addi	a4,a4,24
    800036cc:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800036d0:	00853783          	ld	a5,8(a0)
    800036d4:	01053703          	ld	a4,16(a0)
    800036d8:	00e7b823          	sd	a4,16(a5)
}
    800036dc:	fa1ff06f          	j	8000367c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800036e0:	0007b703          	ld	a4,0(a5)
    800036e4:	00e68733          	add	a4,a3,a4
    800036e8:	01870713          	addi	a4,a4,24
    800036ec:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800036f0:	0107b783          	ld	a5,16(a5)
    800036f4:	00f53823          	sd	a5,16(a0)
    800036f8:	fb1ff06f          	j	800036a8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800036fc <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800036fc:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80003700:	00009697          	auipc	a3,0x9
    80003704:	a806b683          	ld	a3,-1408(a3) # 8000c180 <_ZN15MemoryAllocator12allocMemHeadE>
    80003708:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    8000370c:	00050a63          	beqz	a0,80003720 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80003710:	fe870793          	addi	a5,a4,-24
    80003714:	00a78663          	beq	a5,a0,80003720 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003718:	01053503          	ld	a0,16(a0)
    8000371c:	ff1ff06f          	j	8000370c <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80003720:	08050463          	beqz	a0,800037a8 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003724:	ff010113          	addi	sp,sp,-16
    80003728:	00113423          	sd	ra,8(sp)
    8000372c:	00813023          	sd	s0,0(sp)
    80003730:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003734:	00009797          	auipc	a5,0x9
    80003738:	a447b783          	ld	a5,-1468(a5) # 8000c178 <_ZN15MemoryAllocator12allocMemTailE>
    8000373c:	04a78663          	beq	a5,a0,80003788 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80003740:	04d50c63          	beq	a0,a3,80003798 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80003744:	01053783          	ld	a5,16(a0)
    80003748:	00078663          	beqz	a5,80003754 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    8000374c:	00853703          	ld	a4,8(a0)
    80003750:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80003754:	00853783          	ld	a5,8(a0)
    80003758:	00078663          	beqz	a5,80003764 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    8000375c:	01053703          	ld	a4,16(a0)
    80003760:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003764:	00009597          	auipc	a1,0x9
    80003768:	a0c58593          	addi	a1,a1,-1524 # 8000c170 <_ZN15MemoryAllocator11freeMemHeadE>
    8000376c:	00000097          	auipc	ra,0x0
    80003770:	ec0080e7          	jalr	-320(ra) # 8000362c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003774:	00000513          	li	a0,0
}
    80003778:	00813083          	ld	ra,8(sp)
    8000377c:	00013403          	ld	s0,0(sp)
    80003780:	01010113          	addi	sp,sp,16
    80003784:	00008067          	ret
            allocMemTail = blk->prev;
    80003788:	00853783          	ld	a5,8(a0)
    8000378c:	00009717          	auipc	a4,0x9
    80003790:	9ef73623          	sd	a5,-1556(a4) # 8000c178 <_ZN15MemoryAllocator12allocMemTailE>
    80003794:	fadff06f          	j	80003740 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003798:	01053783          	ld	a5,16(a0)
    8000379c:	00009717          	auipc	a4,0x9
    800037a0:	9ef73223          	sd	a5,-1564(a4) # 8000c180 <_ZN15MemoryAllocator12allocMemHeadE>
    800037a4:	fa1ff06f          	j	80003744 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    800037a8:	fff00513          	li	a0,-1
}
    800037ac:	00008067          	ret

00000000800037b0 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800037b0:	fe010113          	addi	sp,sp,-32
    800037b4:	00113c23          	sd	ra,24(sp)
    800037b8:	00813823          	sd	s0,16(sp)
    800037bc:	00913423          	sd	s1,8(sp)
    800037c0:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800037c4:	00009497          	auipc	s1,0x9
    800037c8:	9bc4b483          	ld	s1,-1604(s1) # 8000c180 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800037cc:	00006517          	auipc	a0,0x6
    800037d0:	b4c50513          	addi	a0,a0,-1204 # 80009318 <CONSOLE_STATUS+0x308>
    800037d4:	fffff097          	auipc	ra,0xfffff
    800037d8:	370080e7          	jalr	880(ra) # 80002b44 <_Z11printStringPKc>
    while(iter!=nullptr){
    800037dc:	04048663          	beqz	s1,80003828 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800037e0:	00000613          	li	a2,0
    800037e4:	00a00593          	li	a1,10
    800037e8:	0004851b          	sext.w	a0,s1
    800037ec:	fffff097          	auipc	ra,0xfffff
    800037f0:	4f0080e7          	jalr	1264(ra) # 80002cdc <_Z8printIntiii>
        putc(' ');
    800037f4:	02000513          	li	a0,32
    800037f8:	fffff097          	auipc	ra,0xfffff
    800037fc:	8bc080e7          	jalr	-1860(ra) # 800020b4 <_Z4putcc>
        printInt(iter->size);
    80003800:	00000613          	li	a2,0
    80003804:	00a00593          	li	a1,10
    80003808:	0004a503          	lw	a0,0(s1)
    8000380c:	fffff097          	auipc	ra,0xfffff
    80003810:	4d0080e7          	jalr	1232(ra) # 80002cdc <_Z8printIntiii>
        putc('\n');
    80003814:	00a00513          	li	a0,10
    80003818:	fffff097          	auipc	ra,0xfffff
    8000381c:	89c080e7          	jalr	-1892(ra) # 800020b4 <_Z4putcc>
        iter=iter->next;
    80003820:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003824:	fb9ff06f          	j	800037dc <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003828:	00006517          	auipc	a0,0x6
    8000382c:	b1050513          	addi	a0,a0,-1264 # 80009338 <CONSOLE_STATUS+0x328>
    80003830:	fffff097          	auipc	ra,0xfffff
    80003834:	314080e7          	jalr	788(ra) # 80002b44 <_Z11printStringPKc>
    iter = freeMemHead;
    80003838:	00009497          	auipc	s1,0x9
    8000383c:	9384b483          	ld	s1,-1736(s1) # 8000c170 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80003840:	04048663          	beqz	s1,8000388c <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003844:	00000613          	li	a2,0
    80003848:	00a00593          	li	a1,10
    8000384c:	0004851b          	sext.w	a0,s1
    80003850:	fffff097          	auipc	ra,0xfffff
    80003854:	48c080e7          	jalr	1164(ra) # 80002cdc <_Z8printIntiii>
        putc(' ');
    80003858:	02000513          	li	a0,32
    8000385c:	fffff097          	auipc	ra,0xfffff
    80003860:	858080e7          	jalr	-1960(ra) # 800020b4 <_Z4putcc>
        printInt(iter->size);
    80003864:	00000613          	li	a2,0
    80003868:	00a00593          	li	a1,10
    8000386c:	0004a503          	lw	a0,0(s1)
    80003870:	fffff097          	auipc	ra,0xfffff
    80003874:	46c080e7          	jalr	1132(ra) # 80002cdc <_Z8printIntiii>
        putc('\n');
    80003878:	00a00513          	li	a0,10
    8000387c:	fffff097          	auipc	ra,0xfffff
    80003880:	838080e7          	jalr	-1992(ra) # 800020b4 <_Z4putcc>
        iter=iter->next;
    80003884:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003888:	fb9ff06f          	j	80003840 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    8000388c:	00006517          	auipc	a0,0x6
    80003890:	acc50513          	addi	a0,a0,-1332 # 80009358 <CONSOLE_STATUS+0x348>
    80003894:	fffff097          	auipc	ra,0xfffff
    80003898:	2b0080e7          	jalr	688(ra) # 80002b44 <_Z11printStringPKc>
}
    8000389c:	01813083          	ld	ra,24(sp)
    800038a0:	01013403          	ld	s0,16(sp)
    800038a4:	00813483          	ld	s1,8(sp)
    800038a8:	02010113          	addi	sp,sp,32
    800038ac:	00008067          	ret

00000000800038b0 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800038b0:	ff010113          	addi	sp,sp,-16
    800038b4:	00813423          	sd	s0,8(sp)
    800038b8:	01010413          	addi	s0,sp,16
    800038bc:	00050813          	mv	a6,a0
    800038c0:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800038c4:	00000793          	li	a5,0
    800038c8:	00c7fe63          	bgeu	a5,a2,800038e4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800038cc:	00f50733          	add	a4,a0,a5
    800038d0:	00f806b3          	add	a3,a6,a5
    800038d4:	0006c683          	lbu	a3,0(a3)
    800038d8:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800038dc:	00178793          	addi	a5,a5,1
    800038e0:	fe9ff06f          	j	800038c8 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800038e4:	00813403          	ld	s0,8(sp)
    800038e8:	01010113          	addi	sp,sp,16
    800038ec:	00008067          	ret

00000000800038f0 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    800038f0:	ff010113          	addi	sp,sp,-16
    800038f4:	00113423          	sd	ra,8(sp)
    800038f8:	00813023          	sd	s0,0(sp)
    800038fc:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80003900:	00053783          	ld	a5,0(a0)
    80003904:	0107b783          	ld	a5,16(a5)
    80003908:	000780e7          	jalr	a5
}
    8000390c:	00813083          	ld	ra,8(sp)
    80003910:	00013403          	ld	s0,0(sp)
    80003914:	01010113          	addi	sp,sp,16
    80003918:	00008067          	ret

000000008000391c <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000391c:	ff010113          	addi	sp,sp,-16
    80003920:	00113423          	sd	ra,8(sp)
    80003924:	00813023          	sd	s0,0(sp)
    80003928:	01010413          	addi	s0,sp,16
    8000392c:	00008797          	auipc	a5,0x8
    80003930:	4ec78793          	addi	a5,a5,1260 # 8000be18 <_ZTV9Semaphore+0x10>
    80003934:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003938:	00853503          	ld	a0,8(a0)
    8000393c:	ffffe097          	auipc	ra,0xffffe
    80003940:	6a0080e7          	jalr	1696(ra) # 80001fdc <_Z9sem_closeP10_semaphore>
};
    80003944:	00813083          	ld	ra,8(sp)
    80003948:	00013403          	ld	s0,0(sp)
    8000394c:	01010113          	addi	sp,sp,16
    80003950:	00008067          	ret

0000000080003954 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80003954:	00008797          	auipc	a5,0x8
    80003958:	4e478793          	addi	a5,a5,1252 # 8000be38 <_ZTV6Thread+0x10>
    8000395c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80003960:	00853503          	ld	a0,8(a0)
    80003964:	02050663          	beqz	a0,80003990 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003968:	ff010113          	addi	sp,sp,-16
    8000396c:	00113423          	sd	ra,8(sp)
    80003970:	00813023          	sd	s0,0(sp)
    80003974:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003978:	ffffe097          	auipc	ra,0xffffe
    8000397c:	7b0080e7          	jalr	1968(ra) # 80002128 <_ZN7_threaddlEPv>
}
    80003980:	00813083          	ld	ra,8(sp)
    80003984:	00013403          	ld	s0,0(sp)
    80003988:	01010113          	addi	sp,sp,16
    8000398c:	00008067          	ret
    80003990:	00008067          	ret

0000000080003994 <_Znwm>:
void* operator new(size_t sz){
    80003994:	ff010113          	addi	sp,sp,-16
    80003998:	00113423          	sd	ra,8(sp)
    8000399c:	00813023          	sd	s0,0(sp)
    800039a0:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800039a4:	ffffe097          	auipc	ra,0xffffe
    800039a8:	404080e7          	jalr	1028(ra) # 80001da8 <_Z9mem_allocm>
}
    800039ac:	00813083          	ld	ra,8(sp)
    800039b0:	00013403          	ld	s0,0(sp)
    800039b4:	01010113          	addi	sp,sp,16
    800039b8:	00008067          	ret

00000000800039bc <_Znam>:
void* operator new[](size_t sz){
    800039bc:	ff010113          	addi	sp,sp,-16
    800039c0:	00113423          	sd	ra,8(sp)
    800039c4:	00813023          	sd	s0,0(sp)
    800039c8:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800039cc:	ffffe097          	auipc	ra,0xffffe
    800039d0:	3dc080e7          	jalr	988(ra) # 80001da8 <_Z9mem_allocm>
}
    800039d4:	00813083          	ld	ra,8(sp)
    800039d8:	00013403          	ld	s0,0(sp)
    800039dc:	01010113          	addi	sp,sp,16
    800039e0:	00008067          	ret

00000000800039e4 <_ZdlPv>:
void operator delete(void *ptr){
    800039e4:	ff010113          	addi	sp,sp,-16
    800039e8:	00113423          	sd	ra,8(sp)
    800039ec:	00813023          	sd	s0,0(sp)
    800039f0:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800039f4:	ffffe097          	auipc	ra,0xffffe
    800039f8:	3e4080e7          	jalr	996(ra) # 80001dd8 <_Z8mem_freePv>
}
    800039fc:	00813083          	ld	ra,8(sp)
    80003a00:	00013403          	ld	s0,0(sp)
    80003a04:	01010113          	addi	sp,sp,16
    80003a08:	00008067          	ret

0000000080003a0c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80003a0c:	fe010113          	addi	sp,sp,-32
    80003a10:	00113c23          	sd	ra,24(sp)
    80003a14:	00813823          	sd	s0,16(sp)
    80003a18:	00913423          	sd	s1,8(sp)
    80003a1c:	02010413          	addi	s0,sp,32
    80003a20:	00050493          	mv	s1,a0
};
    80003a24:	00000097          	auipc	ra,0x0
    80003a28:	ef8080e7          	jalr	-264(ra) # 8000391c <_ZN9SemaphoreD1Ev>
    80003a2c:	00048513          	mv	a0,s1
    80003a30:	00000097          	auipc	ra,0x0
    80003a34:	fb4080e7          	jalr	-76(ra) # 800039e4 <_ZdlPv>
    80003a38:	01813083          	ld	ra,24(sp)
    80003a3c:	01013403          	ld	s0,16(sp)
    80003a40:	00813483          	ld	s1,8(sp)
    80003a44:	02010113          	addi	sp,sp,32
    80003a48:	00008067          	ret

0000000080003a4c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003a4c:	fe010113          	addi	sp,sp,-32
    80003a50:	00113c23          	sd	ra,24(sp)
    80003a54:	00813823          	sd	s0,16(sp)
    80003a58:	00913423          	sd	s1,8(sp)
    80003a5c:	02010413          	addi	s0,sp,32
    80003a60:	00050493          	mv	s1,a0
}
    80003a64:	00000097          	auipc	ra,0x0
    80003a68:	ef0080e7          	jalr	-272(ra) # 80003954 <_ZN6ThreadD1Ev>
    80003a6c:	00048513          	mv	a0,s1
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	f74080e7          	jalr	-140(ra) # 800039e4 <_ZdlPv>
    80003a78:	01813083          	ld	ra,24(sp)
    80003a7c:	01013403          	ld	s0,16(sp)
    80003a80:	00813483          	ld	s1,8(sp)
    80003a84:	02010113          	addi	sp,sp,32
    80003a88:	00008067          	ret

0000000080003a8c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80003a8c:	ff010113          	addi	sp,sp,-16
    80003a90:	00113423          	sd	ra,8(sp)
    80003a94:	00813023          	sd	s0,0(sp)
    80003a98:	01010413          	addi	s0,sp,16
    80003a9c:	00008797          	auipc	a5,0x8
    80003aa0:	37c78793          	addi	a5,a5,892 # 8000be18 <_ZTV9Semaphore+0x10>
    80003aa4:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003aa8:	00850513          	addi	a0,a0,8
    80003aac:	ffffe097          	auipc	ra,0xffffe
    80003ab0:	4f8080e7          	jalr	1272(ra) # 80001fa4 <_Z8sem_openPP10_semaphorej>
}
    80003ab4:	00813083          	ld	ra,8(sp)
    80003ab8:	00013403          	ld	s0,0(sp)
    80003abc:	01010113          	addi	sp,sp,16
    80003ac0:	00008067          	ret

0000000080003ac4 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80003ac4:	ff010113          	addi	sp,sp,-16
    80003ac8:	00113423          	sd	ra,8(sp)
    80003acc:	00813023          	sd	s0,0(sp)
    80003ad0:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003ad4:	00853503          	ld	a0,8(a0)
    80003ad8:	ffffe097          	auipc	ra,0xffffe
    80003adc:	530080e7          	jalr	1328(ra) # 80002008 <_Z8sem_waitP10_semaphore>
}
    80003ae0:	00813083          	ld	ra,8(sp)
    80003ae4:	00013403          	ld	s0,0(sp)
    80003ae8:	01010113          	addi	sp,sp,16
    80003aec:	00008067          	ret

0000000080003af0 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003af0:	ff010113          	addi	sp,sp,-16
    80003af4:	00113423          	sd	ra,8(sp)
    80003af8:	00813023          	sd	s0,0(sp)
    80003afc:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003b00:	00853503          	ld	a0,8(a0)
    80003b04:	ffffe097          	auipc	ra,0xffffe
    80003b08:	530080e7          	jalr	1328(ra) # 80002034 <_Z10sem_signalP10_semaphore>
}
    80003b0c:	00813083          	ld	ra,8(sp)
    80003b10:	00013403          	ld	s0,0(sp)
    80003b14:	01010113          	addi	sp,sp,16
    80003b18:	00008067          	ret

0000000080003b1c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80003b1c:	fe010113          	addi	sp,sp,-32
    80003b20:	00113c23          	sd	ra,24(sp)
    80003b24:	00813823          	sd	s0,16(sp)
    80003b28:	00913423          	sd	s1,8(sp)
    80003b2c:	02010413          	addi	s0,sp,32
    80003b30:	00050493          	mv	s1,a0
    80003b34:	00008797          	auipc	a5,0x8
    80003b38:	30478793          	addi	a5,a5,772 # 8000be38 <_ZTV6Thread+0x10>
    80003b3c:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    80003b40:	00850513          	addi	a0,a0,8
    80003b44:	ffffe097          	auipc	ra,0xffffe
    80003b48:	394080e7          	jalr	916(ra) # 80001ed8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80003b4c:	fff00793          	li	a5,-1
    80003b50:	00f50c63          	beq	a0,a5,80003b68 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    80003b54:	01813083          	ld	ra,24(sp)
    80003b58:	01013403          	ld	s0,16(sp)
    80003b5c:	00813483          	ld	s1,8(sp)
    80003b60:	02010113          	addi	sp,sp,32
    80003b64:	00008067          	ret
        myHandle = nullptr;
    80003b68:	0004b423          	sd	zero,8(s1)
}
    80003b6c:	fe9ff06f          	j	80003b54 <_ZN6ThreadC1EPFvPvES0_+0x38>

0000000080003b70 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003b70:	fe010113          	addi	sp,sp,-32
    80003b74:	00113c23          	sd	ra,24(sp)
    80003b78:	00813823          	sd	s0,16(sp)
    80003b7c:	00913423          	sd	s1,8(sp)
    80003b80:	02010413          	addi	s0,sp,32
    80003b84:	00050493          	mv	s1,a0
    80003b88:	00008797          	auipc	a5,0x8
    80003b8c:	2b078793          	addi	a5,a5,688 # 8000be38 <_ZTV6Thread+0x10>
    80003b90:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80003b94:	00050613          	mv	a2,a0
    80003b98:	00000597          	auipc	a1,0x0
    80003b9c:	d5858593          	addi	a1,a1,-680 # 800038f0 <_ZN6Thread7wrapperEPv>
    80003ba0:	00850513          	addi	a0,a0,8
    80003ba4:	ffffe097          	auipc	ra,0xffffe
    80003ba8:	334080e7          	jalr	820(ra) # 80001ed8 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80003bac:	fff00793          	li	a5,-1
    80003bb0:	00f50c63          	beq	a0,a5,80003bc8 <_ZN6ThreadC1Ev+0x58>
}
    80003bb4:	01813083          	ld	ra,24(sp)
    80003bb8:	01013403          	ld	s0,16(sp)
    80003bbc:	00813483          	ld	s1,8(sp)
    80003bc0:	02010113          	addi	sp,sp,32
    80003bc4:	00008067          	ret
        myHandle = nullptr;
    80003bc8:	0004b423          	sd	zero,8(s1)
}
    80003bcc:	fe9ff06f          	j	80003bb4 <_ZN6ThreadC1Ev+0x44>

0000000080003bd0 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003bd0:	ff010113          	addi	sp,sp,-16
    80003bd4:	00113423          	sd	ra,8(sp)
    80003bd8:	00813023          	sd	s0,0(sp)
    80003bdc:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003be0:	ffffe097          	auipc	ra,0xffffe
    80003be4:	480080e7          	jalr	1152(ra) # 80002060 <_Z10time_sleepm>
}
    80003be8:	00813083          	ld	ra,8(sp)
    80003bec:	00013403          	ld	s0,0(sp)
    80003bf0:	01010113          	addi	sp,sp,16
    80003bf4:	00008067          	ret

0000000080003bf8 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80003bf8:	fe010113          	addi	sp,sp,-32
    80003bfc:	00113c23          	sd	ra,24(sp)
    80003c00:	00813823          	sd	s0,16(sp)
    80003c04:	00913423          	sd	s1,8(sp)
    80003c08:	01213023          	sd	s2,0(sp)
    80003c0c:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80003c10:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80003c14:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80003c18:	0004b783          	ld	a5,0(s1)
    80003c1c:	0187b783          	ld	a5,24(a5)
    80003c20:	00048513          	mv	a0,s1
    80003c24:	000780e7          	jalr	a5
        pt->sleep(time);
    80003c28:	00090513          	mv	a0,s2
    80003c2c:	00000097          	auipc	ra,0x0
    80003c30:	fa4080e7          	jalr	-92(ra) # 80003bd0 <_ZN6Thread5sleepEm>
    while(true){
    80003c34:	fe5ff06f          	j	80003c18 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080003c38 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003c38:	ff010113          	addi	sp,sp,-16
    80003c3c:	00113423          	sd	ra,8(sp)
    80003c40:	00813023          	sd	s0,0(sp)
    80003c44:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003c48:	ffffe097          	auipc	ra,0xffffe
    80003c4c:	270080e7          	jalr	624(ra) # 80001eb8 <_Z15thread_dispatchv>
}
    80003c50:	00813083          	ld	ra,8(sp)
    80003c54:	00013403          	ld	s0,0(sp)
    80003c58:	01010113          	addi	sp,sp,16
    80003c5c:	00008067          	ret

0000000080003c60 <_ZN6Thread5startEv>:
int Thread::start() {
    80003c60:	ff010113          	addi	sp,sp,-16
    80003c64:	00113423          	sd	ra,8(sp)
    80003c68:	00813023          	sd	s0,0(sp)
    80003c6c:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80003c70:	00853503          	ld	a0,8(a0)
    80003c74:	ffffe097          	auipc	ra,0xffffe
    80003c78:	2f8080e7          	jalr	760(ra) # 80001f6c <_Z12thread_startP7_thread>
}
    80003c7c:	00813083          	ld	ra,8(sp)
    80003c80:	00013403          	ld	s0,0(sp)
    80003c84:	01010113          	addi	sp,sp,16
    80003c88:	00008067          	ret

0000000080003c8c <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003c8c:	fe010113          	addi	sp,sp,-32
    80003c90:	00113c23          	sd	ra,24(sp)
    80003c94:	00813823          	sd	s0,16(sp)
    80003c98:	00913423          	sd	s1,8(sp)
    80003c9c:	01213023          	sd	s2,0(sp)
    80003ca0:	02010413          	addi	s0,sp,32
    80003ca4:	00050493          	mv	s1,a0
    80003ca8:	00058913          	mv	s2,a1
    80003cac:	01000513          	li	a0,16
    80003cb0:	00000097          	auipc	ra,0x0
    80003cb4:	ce4080e7          	jalr	-796(ra) # 80003994 <_Znwm>
    80003cb8:	00050613          	mv	a2,a0
    80003cbc:	00050663          	beqz	a0,80003cc8 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003cc0:	00953023          	sd	s1,0(a0)
    80003cc4:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003cc8:	00000597          	auipc	a1,0x0
    80003ccc:	f3058593          	addi	a1,a1,-208 # 80003bf8 <_ZN14PeriodicThread7wrapperEPv>
    80003cd0:	00048513          	mv	a0,s1
    80003cd4:	00000097          	auipc	ra,0x0
    80003cd8:	e48080e7          	jalr	-440(ra) # 80003b1c <_ZN6ThreadC1EPFvPvES0_>
    80003cdc:	00008797          	auipc	a5,0x8
    80003ce0:	10c78793          	addi	a5,a5,268 # 8000bde8 <_ZTV14PeriodicThread+0x10>
    80003ce4:	00f4b023          	sd	a5,0(s1)
    80003ce8:	01813083          	ld	ra,24(sp)
    80003cec:	01013403          	ld	s0,16(sp)
    80003cf0:	00813483          	ld	s1,8(sp)
    80003cf4:	00013903          	ld	s2,0(sp)
    80003cf8:	02010113          	addi	sp,sp,32
    80003cfc:	00008067          	ret

0000000080003d00 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80003d00:	ff010113          	addi	sp,sp,-16
    80003d04:	00113423          	sd	ra,8(sp)
    80003d08:	00813023          	sd	s0,0(sp)
    80003d0c:	01010413          	addi	s0,sp,16
    return ::getc();
    80003d10:	ffffe097          	auipc	ra,0xffffe
    80003d14:	37c080e7          	jalr	892(ra) # 8000208c <_Z4getcv>
}
    80003d18:	00813083          	ld	ra,8(sp)
    80003d1c:	00013403          	ld	s0,0(sp)
    80003d20:	01010113          	addi	sp,sp,16
    80003d24:	00008067          	ret

0000000080003d28 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003d28:	ff010113          	addi	sp,sp,-16
    80003d2c:	00113423          	sd	ra,8(sp)
    80003d30:	00813023          	sd	s0,0(sp)
    80003d34:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003d38:	ffffe097          	auipc	ra,0xffffe
    80003d3c:	37c080e7          	jalr	892(ra) # 800020b4 <_Z4putcc>
}
    80003d40:	00813083          	ld	ra,8(sp)
    80003d44:	00013403          	ld	s0,0(sp)
    80003d48:	01010113          	addi	sp,sp,16
    80003d4c:	00008067          	ret

0000000080003d50 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003d50:	ff010113          	addi	sp,sp,-16
    80003d54:	00813423          	sd	s0,8(sp)
    80003d58:	01010413          	addi	s0,sp,16
    80003d5c:	00813403          	ld	s0,8(sp)
    80003d60:	01010113          	addi	sp,sp,16
    80003d64:	00008067          	ret

0000000080003d68 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003d68:	ff010113          	addi	sp,sp,-16
    80003d6c:	00813423          	sd	s0,8(sp)
    80003d70:	01010413          	addi	s0,sp,16
    80003d74:	00813403          	ld	s0,8(sp)
    80003d78:	01010113          	addi	sp,sp,16
    80003d7c:	00008067          	ret

0000000080003d80 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003d80:	ff010113          	addi	sp,sp,-16
    80003d84:	00113423          	sd	ra,8(sp)
    80003d88:	00813023          	sd	s0,0(sp)
    80003d8c:	01010413          	addi	s0,sp,16
    80003d90:	00008797          	auipc	a5,0x8
    80003d94:	05878793          	addi	a5,a5,88 # 8000bde8 <_ZTV14PeriodicThread+0x10>
    80003d98:	00f53023          	sd	a5,0(a0)
    80003d9c:	00000097          	auipc	ra,0x0
    80003da0:	bb8080e7          	jalr	-1096(ra) # 80003954 <_ZN6ThreadD1Ev>
    80003da4:	00813083          	ld	ra,8(sp)
    80003da8:	00013403          	ld	s0,0(sp)
    80003dac:	01010113          	addi	sp,sp,16
    80003db0:	00008067          	ret

0000000080003db4 <_ZN14PeriodicThreadD0Ev>:
    80003db4:	fe010113          	addi	sp,sp,-32
    80003db8:	00113c23          	sd	ra,24(sp)
    80003dbc:	00813823          	sd	s0,16(sp)
    80003dc0:	00913423          	sd	s1,8(sp)
    80003dc4:	02010413          	addi	s0,sp,32
    80003dc8:	00050493          	mv	s1,a0
    80003dcc:	00008797          	auipc	a5,0x8
    80003dd0:	01c78793          	addi	a5,a5,28 # 8000bde8 <_ZTV14PeriodicThread+0x10>
    80003dd4:	00f53023          	sd	a5,0(a0)
    80003dd8:	00000097          	auipc	ra,0x0
    80003ddc:	b7c080e7          	jalr	-1156(ra) # 80003954 <_ZN6ThreadD1Ev>
    80003de0:	00048513          	mv	a0,s1
    80003de4:	00000097          	auipc	ra,0x0
    80003de8:	c00080e7          	jalr	-1024(ra) # 800039e4 <_ZdlPv>
    80003dec:	01813083          	ld	ra,24(sp)
    80003df0:	01013403          	ld	s0,16(sp)
    80003df4:	00813483          	ld	s1,8(sp)
    80003df8:	02010113          	addi	sp,sp,32
    80003dfc:	00008067          	ret

0000000080003e00 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003e00:	ff010113          	addi	sp,sp,-16
    80003e04:	00113423          	sd	ra,8(sp)
    80003e08:	00813023          	sd	s0,0(sp)
    80003e0c:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003e10:	00008797          	auipc	a5,0x8
    80003e14:	1207b783          	ld	a5,288(a5) # 8000bf30 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003e18:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80003e1c:	00008797          	auipc	a5,0x8
    80003e20:	0c47b783          	ld	a5,196(a5) # 8000bee0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003e24:	0007b503          	ld	a0,0(a5)
    80003e28:	00c55513          	srli	a0,a0,0xc
    80003e2c:	00250513          	addi	a0,a0,2
    80003e30:	000015b7          	lui	a1,0x1
    80003e34:	00c51513          	slli	a0,a0,0xc
    80003e38:	00001097          	auipc	ra,0x1
    80003e3c:	604080e7          	jalr	1540(ra) # 8000543c <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80003e40:	fffff097          	auipc	ra,0xfffff
    80003e44:	604080e7          	jalr	1540(ra) # 80003444 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003e48:	00001097          	auipc	ra,0x1
    80003e4c:	f68080e7          	jalr	-152(ra) # 80004db0 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003e50:	fffff097          	auipc	ra,0xfffff
    80003e54:	4a0080e7          	jalr	1184(ra) # 800032f0 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80003e58:	fffff097          	auipc	ra,0xfffff
    80003e5c:	fd8080e7          	jalr	-40(ra) # 80002e30 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80003e60:	00001097          	auipc	ra,0x1
    80003e64:	164080e7          	jalr	356(ra) # 80004fc4 <_ZN11ConsoleUtil10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003e68:	00200793          	li	a5,2
    80003e6c:	1047a073          	csrs	sie,a5
    80003e70:	20000713          	li	a4,512
    80003e74:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003e78:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003e7c:	00813083          	ld	ra,8(sp)
    80003e80:	00013403          	ld	s0,0(sp)
    80003e84:	01010113          	addi	sp,sp,16
    80003e88:	00008067          	ret

0000000080003e8c <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003e8c:	ff010113          	addi	sp,sp,-16
    80003e90:	00813423          	sd	s0,8(sp)
    80003e94:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003e98:	14109073          	csrw	sepc,ra
    asm("sret");
    80003e9c:	10200073          	sret
}
    80003ea0:	00813403          	ld	s0,8(sp)
    80003ea4:	01010113          	addi	sp,sp,16
    80003ea8:	00008067          	ret

0000000080003eac <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003eac:	ff010113          	addi	sp,sp,-16
    80003eb0:	00113423          	sd	ra,8(sp)
    80003eb4:	00813023          	sd	s0,0(sp)
    80003eb8:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003ebc:	00008797          	auipc	a5,0x8
    80003ec0:	0947b783          	ld	a5,148(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003ec4:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003ec8:	00100713          	li	a4,1
    80003ecc:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	370080e7          	jalr	880(ra) # 80003240 <_ZN3TCB8dispatchEv>
}
    80003ed8:	00813083          	ld	ra,8(sp)
    80003edc:	00013403          	ld	s0,0(sp)
    80003ee0:	01010113          	addi	sp,sp,16
    80003ee4:	00008067          	ret

0000000080003ee8 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003ee8:	ff010113          	addi	sp,sp,-16
    80003eec:	00113423          	sd	ra,8(sp)
    80003ef0:	00813023          	sd	s0,0(sp)
    80003ef4:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003ef8:	00008797          	auipc	a5,0x8
    80003efc:	2987c783          	lbu	a5,664(a5) # 8000c190 <_ZN5RiscV16userMainFinishedE>
    80003f00:	00079c63          	bnez	a5,80003f18 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003f04:	00008717          	auipc	a4,0x8
    80003f08:	04473703          	ld	a4,68(a4) # 8000bf48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003f0c:	00073783          	ld	a5,0(a4)
    80003f10:	00178793          	addi	a5,a5,1
    80003f14:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003f18:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003f1c:	0ff57513          	andi	a0,a0,255
    80003f20:	00001097          	auipc	ra,0x1
    80003f24:	26c080e7          	jalr	620(ra) # 8000518c <_ZN11ConsoleUtil9putOutputEc>
}
    80003f28:	00813083          	ld	ra,8(sp)
    80003f2c:	00013403          	ld	s0,0(sp)
    80003f30:	01010113          	addi	sp,sp,16
    80003f34:	00008067          	ret

0000000080003f38 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003f38:	fe010113          	addi	sp,sp,-32
    80003f3c:	00113c23          	sd	ra,24(sp)
    80003f40:	00813823          	sd	s0,16(sp)
    80003f44:	02010413          	addi	s0,sp,32
    80003f48:	00c0006f          	j	80003f54 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003f4c:	ffffe097          	auipc	ra,0xffffe
    80003f50:	f6c080e7          	jalr	-148(ra) # 80001eb8 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003f54:	00008797          	auipc	a5,0x8
    80003f58:	f847b783          	ld	a5,-124(a5) # 8000bed8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003f5c:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003f60:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003f64:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003f68:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003f6c:	0207f793          	andi	a5,a5,32
    80003f70:	fc078ee3          	beqz	a5,80003f4c <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003f74:	00001097          	auipc	ra,0x1
    80003f78:	4a0080e7          	jalr	1184(ra) # 80005414 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003f7c:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003f80:	00008797          	auipc	a5,0x8
    80003f84:	f507b783          	ld	a5,-176(a5) # 8000bed0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003f88:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003f8c:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003f90:	fef44783          	lbu	a5,-17(s0)
    80003f94:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003f98:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003f9c:	00008797          	auipc	a5,0x8
    80003fa0:	fac7b783          	ld	a5,-84(a5) # 8000bf48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003fa4:	0007b783          	ld	a5,0(a5)
    80003fa8:	fa0786e3          	beqz	a5,80003f54 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003fac:	fff78793          	addi	a5,a5,-1
    80003fb0:	00008717          	auipc	a4,0x8
    80003fb4:	f9873703          	ld	a4,-104(a4) # 8000bf48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003fb8:	00f73023          	sd	a5,0(a4)
    80003fbc:	f99ff06f          	j	80003f54 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003fc0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003fc0:	ff010113          	addi	sp,sp,-16
    80003fc4:	00813423          	sd	s0,8(sp)
    80003fc8:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80003fcc:	00008797          	auipc	a5,0x8
    80003fd0:	f847b783          	ld	a5,-124(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003fd4:	0007b783          	ld	a5,0(a5)
    80003fd8:	0147a703          	lw	a4,20(a5)
    80003fdc:	00100793          	li	a5,1
    80003fe0:	00f70c63          	beq	a4,a5,80003ff8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003fe4:	10000793          	li	a5,256
    80003fe8:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    80003fec:	00813403          	ld	s0,8(sp)
    80003ff0:	01010113          	addi	sp,sp,16
    80003ff4:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003ff8:	10000793          	li	a5,256
    80003ffc:	1007a073          	csrs	sstatus,a5
}
    80004000:	fedff06f          	j	80003fec <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080004004 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80004004:	ff010113          	addi	sp,sp,-16
    80004008:	00113423          	sd	ra,8(sp)
    8000400c:	00813023          	sd	s0,0(sp)
    80004010:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80004014:	00100793          	li	a5,1
    80004018:	00008717          	auipc	a4,0x8
    8000401c:	16f70c23          	sb	a5,376(a4) # 8000c190 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80004020:	00008797          	auipc	a5,0x8
    80004024:	f287b783          	ld	a5,-216(a5) # 8000bf48 <_GLOBAL_OFFSET_TABLE_+0x80>
    80004028:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    8000402c:	00008797          	auipc	a5,0x8
    80004030:	ed47b783          	ld	a5,-300(a5) # 8000bf00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004034:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80004038:	00200793          	li	a5,2
    8000403c:	1047b073          	csrc	sie,a5
    80004040:	20000793          	li	a5,512
    80004044:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80004048:	00008797          	auipc	a5,0x8
    8000404c:	ed87b783          	ld	a5,-296(a5) # 8000bf20 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004050:	0007b783          	ld	a5,0(a5)
    80004054:	00078c63          	beqz	a5,8000406c <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80004058:	0487b703          	ld	a4,72(a5)
    8000405c:	00008797          	auipc	a5,0x8
    80004060:	ec47b783          	ld	a5,-316(a5) # 8000bf20 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004064:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80004068:	fe1ff06f          	j	80004048 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    8000406c:	00008797          	auipc	a5,0x8
    80004070:	ebc7b783          	ld	a5,-324(a5) # 8000bf28 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004074:	0007b503          	ld	a0,0(a5)
    80004078:	00001097          	auipc	ra,0x1
    8000407c:	d50080e7          	jalr	-688(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80004080:	00008797          	auipc	a5,0x8
    80004084:	eb87b783          	ld	a5,-328(a5) # 8000bf38 <_GLOBAL_OFFSET_TABLE_+0x70>
    80004088:	0007b703          	ld	a4,0(a5)
    8000408c:	00008797          	auipc	a5,0x8
    80004090:	eb47b783          	ld	a5,-332(a5) # 8000bf40 <_GLOBAL_OFFSET_TABLE_+0x78>
    80004094:	0007b783          	ld	a5,0(a5)
    80004098:	00f70863          	beq	a4,a5,800040a8 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    8000409c:	ffffe097          	auipc	ra,0xffffe
    800040a0:	e1c080e7          	jalr	-484(ra) # 80001eb8 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    800040a4:	fddff06f          	j	80004080 <_ZN5RiscV8finalizeEv+0x7c>
}
    800040a8:	00813083          	ld	ra,8(sp)
    800040ac:	00013403          	ld	s0,0(sp)
    800040b0:	01010113          	addi	sp,sp,16
    800040b4:	00008067          	ret

00000000800040b8 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    800040b8:	ff010113          	addi	sp,sp,-16
    800040bc:	00813423          	sd	s0,8(sp)
    800040c0:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800040c4:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800040c8:	00008717          	auipc	a4,0x8
    800040cc:	e8873703          	ld	a4,-376(a4) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800040d0:	00073703          	ld	a4,0(a4)
    800040d4:	06873703          	ld	a4,104(a4)
    800040d8:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800040dc:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800040e0:	00078593          	mv	a1,a5
}
    800040e4:	00813403          	ld	s0,8(sp)
    800040e8:	01010113          	addi	sp,sp,16
    800040ec:	00008067          	ret

00000000800040f0 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800040f0:	ff010113          	addi	sp,sp,-16
    800040f4:	00113423          	sd	ra,8(sp)
    800040f8:	00813023          	sd	s0,0(sp)
    800040fc:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80004100:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80004104:	fffff097          	auipc	ra,0xfffff
    80004108:	3c0080e7          	jalr	960(ra) # 800034c4 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    8000410c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004110:	00000097          	auipc	ra,0x0
    80004114:	fa8080e7          	jalr	-88(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004118:	00813083          	ld	ra,8(sp)
    8000411c:	00013403          	ld	s0,0(sp)
    80004120:	01010113          	addi	sp,sp,16
    80004124:	00008067          	ret

0000000080004128 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80004128:	ff010113          	addi	sp,sp,-16
    8000412c:	00113423          	sd	ra,8(sp)
    80004130:	00813023          	sd	s0,0(sp)
    80004134:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80004138:	00008797          	auipc	a5,0x8
    8000413c:	e207b783          	ld	a5,-480(a5) # 8000bf58 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004140:	0007c783          	lbu	a5,0(a5)
    80004144:	02079263          	bnez	a5,80004168 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80004148:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000414c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004150:	00000097          	auipc	ra,0x0
    80004154:	f68080e7          	jalr	-152(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004158:	00813083          	ld	ra,8(sp)
    8000415c:	00013403          	ld	s0,0(sp)
    80004160:	01010113          	addi	sp,sp,16
    80004164:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004168:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    8000416c:	fffff097          	auipc	ra,0xfffff
    80004170:	590080e7          	jalr	1424(ra) # 800036fc <_ZN15MemoryAllocator5kfreeEPv>
    80004174:	fd9ff06f          	j	8000414c <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080004178 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80004178:	fc010113          	addi	sp,sp,-64
    8000417c:	02113c23          	sd	ra,56(sp)
    80004180:	02813823          	sd	s0,48(sp)
    80004184:	02913423          	sd	s1,40(sp)
    80004188:	03213023          	sd	s2,32(sp)
    8000418c:	01313c23          	sd	s3,24(sp)
    80004190:	01413823          	sd	s4,16(sp)
    80004194:	01513423          	sd	s5,8(sp)
    80004198:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000419c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800041a0:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    800041a4:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    800041a8:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800041ac:	07000513          	li	a0,112
    800041b0:	fffff097          	auipc	ra,0xfffff
    800041b4:	110080e7          	jalr	272(ra) # 800032c0 <_ZN3TCBnwEm>
    800041b8:	00050493          	mv	s1,a0
    800041bc:	00050e63          	beqz	a0,800041d8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    800041c0:	00200713          	li	a4,2
    800041c4:	000a8693          	mv	a3,s5
    800041c8:	000a0613          	mv	a2,s4
    800041cc:	00098593          	mv	a1,s3
    800041d0:	fffff097          	auipc	ra,0xfffff
    800041d4:	fb4080e7          	jalr	-76(ra) # 80003184 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800041d8:	04048863          	beqz	s1,80004228 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    800041dc:	0184b783          	ld	a5,24(s1)
    800041e0:	00078863          	beqz	a5,800041f0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    800041e4:	00048513          	mv	a0,s1
    800041e8:	00001097          	auipc	ra,0x1
    800041ec:	be0080e7          	jalr	-1056(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800041f0:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800041f4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800041f8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800041fc:	00000097          	auipc	ra,0x0
    80004200:	ebc080e7          	jalr	-324(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004204:	03813083          	ld	ra,56(sp)
    80004208:	03013403          	ld	s0,48(sp)
    8000420c:	02813483          	ld	s1,40(sp)
    80004210:	02013903          	ld	s2,32(sp)
    80004214:	01813983          	ld	s3,24(sp)
    80004218:	01013a03          	ld	s4,16(sp)
    8000421c:	00813a83          	ld	s5,8(sp)
    80004220:	04010113          	addi	sp,sp,64
    80004224:	00008067          	ret
        status = -1;
    80004228:	fff00793          	li	a5,-1
    8000422c:	fcdff06f          	j	800041f8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80004230:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80004234:	00048513          	mv	a0,s1
    80004238:	fffff097          	auipc	ra,0xfffff
    8000423c:	1ac080e7          	jalr	428(ra) # 800033e4 <_ZN3TCBdlEPv>
    80004240:	00090513          	mv	a0,s2
    80004244:	00009097          	auipc	ra,0x9
    80004248:	0b4080e7          	jalr	180(ra) # 8000d2f8 <_Unwind_Resume>

000000008000424c <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    8000424c:	fc010113          	addi	sp,sp,-64
    80004250:	02113c23          	sd	ra,56(sp)
    80004254:	02813823          	sd	s0,48(sp)
    80004258:	02913423          	sd	s1,40(sp)
    8000425c:	03213023          	sd	s2,32(sp)
    80004260:	01313c23          	sd	s3,24(sp)
    80004264:	01413823          	sd	s4,16(sp)
    80004268:	01513423          	sd	s5,8(sp)
    8000426c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80004270:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004274:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80004278:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    8000427c:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80004280:	07000513          	li	a0,112
    80004284:	fffff097          	auipc	ra,0xfffff
    80004288:	03c080e7          	jalr	60(ra) # 800032c0 <_ZN3TCBnwEm>
    8000428c:	00050493          	mv	s1,a0
    80004290:	00050e63          	beqz	a0,800042ac <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80004294:	00200713          	li	a4,2
    80004298:	000a8693          	mv	a3,s5
    8000429c:	00090613          	mv	a2,s2
    800042a0:	00098593          	mv	a1,s3
    800042a4:	fffff097          	auipc	ra,0xfffff
    800042a8:	ee0080e7          	jalr	-288(ra) # 80003184 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800042ac:	04048263          	beqz	s1,800042f0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    800042b0:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    800042b4:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    800042b8:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    800042bc:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800042c0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800042c4:	00000097          	auipc	ra,0x0
    800042c8:	df4080e7          	jalr	-524(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800042cc:	03813083          	ld	ra,56(sp)
    800042d0:	03013403          	ld	s0,48(sp)
    800042d4:	02813483          	ld	s1,40(sp)
    800042d8:	02013903          	ld	s2,32(sp)
    800042dc:	01813983          	ld	s3,24(sp)
    800042e0:	01013a03          	ld	s4,16(sp)
    800042e4:	00813a83          	ld	s5,8(sp)
    800042e8:	04010113          	addi	sp,sp,64
    800042ec:	00008067          	ret
        status = -1;
    800042f0:	fff00793          	li	a5,-1
    800042f4:	fcdff06f          	j	800042c0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800042f8:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800042fc:	00048513          	mv	a0,s1
    80004300:	fffff097          	auipc	ra,0xfffff
    80004304:	0e4080e7          	jalr	228(ra) # 800033e4 <_ZN3TCBdlEPv>
    80004308:	00090513          	mv	a0,s2
    8000430c:	00009097          	auipc	ra,0x9
    80004310:	fec080e7          	jalr	-20(ra) # 8000d2f8 <_Unwind_Resume>

0000000080004314 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80004314:	ff010113          	addi	sp,sp,-16
    80004318:	00113423          	sd	ra,8(sp)
    8000431c:	00813023          	sd	s0,0(sp)
    80004320:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004324:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80004328:	02051263          	bnez	a0,8000434c <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    8000432c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004330:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004334:	00000097          	auipc	ra,0x0
    80004338:	d84080e7          	jalr	-636(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000433c:	00813083          	ld	ra,8(sp)
    80004340:	00013403          	ld	s0,0(sp)
    80004344:	01010113          	addi	sp,sp,16
    80004348:	00008067          	ret
        tcb->status = TCB::Status::READY;
    8000434c:	00100793          	li	a5,1
    80004350:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80004354:	00001097          	auipc	ra,0x1
    80004358:	a74080e7          	jalr	-1420(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    8000435c:	fffff097          	auipc	ra,0xfffff
    80004360:	ee4080e7          	jalr	-284(ra) # 80003240 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80004364:	00000793          	li	a5,0
    80004368:	fc9ff06f          	j	80004330 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

000000008000436c <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    8000436c:	ff010113          	addi	sp,sp,-16
    80004370:	00113423          	sd	ra,8(sp)
    80004374:	00813023          	sd	s0,0(sp)
    80004378:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000437c:	00008797          	auipc	a5,0x8
    80004380:	bd47b783          	ld	a5,-1068(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004384:	0007b783          	ld	a5,0(a5)
    80004388:	02078a63          	beqz	a5,800043bc <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    8000438c:	00200713          	li	a4,2
    80004390:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80004394:	fffff097          	auipc	ra,0xfffff
    80004398:	eac080e7          	jalr	-340(ra) # 80003240 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000439c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800043a0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800043a4:	00000097          	auipc	ra,0x0
    800043a8:	d14080e7          	jalr	-748(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800043ac:	00813083          	ld	ra,8(sp)
    800043b0:	00013403          	ld	s0,0(sp)
    800043b4:	01010113          	addi	sp,sp,16
    800043b8:	00008067          	ret
        status = -1;
    800043bc:	fff00793          	li	a5,-1
    800043c0:	fe1ff06f          	j	800043a0 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800043c4 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800043c4:	fd010113          	addi	sp,sp,-48
    800043c8:	02113423          	sd	ra,40(sp)
    800043cc:	02813023          	sd	s0,32(sp)
    800043d0:	00913c23          	sd	s1,24(sp)
    800043d4:	01213823          	sd	s2,16(sp)
    800043d8:	01313423          	sd	s3,8(sp)
    800043dc:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800043e0:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800043e4:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    800043e8:	01800513          	li	a0,24
    800043ec:	fffff097          	auipc	ra,0xfffff
    800043f0:	c44080e7          	jalr	-956(ra) # 80003030 <_ZN3SCBnwEm>
    800043f4:	00050493          	mv	s1,a0
    800043f8:	00050863          	beqz	a0,80004408 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800043fc:	00098593          	mv	a1,s3
    80004400:	fffff097          	auipc	ra,0xfffff
    80004404:	a7c080e7          	jalr	-1412(ra) # 80002e7c <_ZN3SCBC1Em>
    if(scb == nullptr){
    80004408:	02048a63          	beqz	s1,8000443c <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    8000440c:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    80004410:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004414:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004418:	00000097          	auipc	ra,0x0
    8000441c:	ca0080e7          	jalr	-864(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004420:	02813083          	ld	ra,40(sp)
    80004424:	02013403          	ld	s0,32(sp)
    80004428:	01813483          	ld	s1,24(sp)
    8000442c:	01013903          	ld	s2,16(sp)
    80004430:	00813983          	ld	s3,8(sp)
    80004434:	03010113          	addi	sp,sp,48
    80004438:	00008067          	ret
        status = -1;
    8000443c:	fff00793          	li	a5,-1
    80004440:	fd5ff06f          	j	80004414 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80004444:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80004448:	00048513          	mv	a0,s1
    8000444c:	fffff097          	auipc	ra,0xfffff
    80004450:	c14080e7          	jalr	-1004(ra) # 80003060 <_ZN3SCBdlEPv>
    80004454:	00090513          	mv	a0,s2
    80004458:	00009097          	auipc	ra,0x9
    8000445c:	ea0080e7          	jalr	-352(ra) # 8000d2f8 <_Unwind_Resume>

0000000080004460 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80004460:	fe010113          	addi	sp,sp,-32
    80004464:	00113c23          	sd	ra,24(sp)
    80004468:	00813823          	sd	s0,16(sp)
    8000446c:	00913423          	sd	s1,8(sp)
    80004470:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004474:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80004478:	02049463          	bnez	s1,800044a0 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    8000447c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004480:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004484:	00000097          	auipc	ra,0x0
    80004488:	c34080e7          	jalr	-972(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000448c:	01813083          	ld	ra,24(sp)
    80004490:	01013403          	ld	s0,16(sp)
    80004494:	00813483          	ld	s1,8(sp)
    80004498:	02010113          	addi	sp,sp,32
    8000449c:	00008067          	ret
        delete (SCB*)ihandle;
    800044a0:	00048513          	mv	a0,s1
    800044a4:	fffff097          	auipc	ra,0xfffff
    800044a8:	9f4080e7          	jalr	-1548(ra) # 80002e98 <_ZN3SCBD1Ev>
    800044ac:	00048513          	mv	a0,s1
    800044b0:	fffff097          	auipc	ra,0xfffff
    800044b4:	bb0080e7          	jalr	-1104(ra) # 80003060 <_ZN3SCBdlEPv>
    uint64 status = 0;
    800044b8:	00000793          	li	a5,0
    800044bc:	fc5ff06f          	j	80004480 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800044c0 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800044c0:	ff010113          	addi	sp,sp,-16
    800044c4:	00113423          	sd	ra,8(sp)
    800044c8:	00813023          	sd	s0,0(sp)
    800044cc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800044d0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800044d4:	02051c63          	bnez	a0,8000450c <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800044d8:	00008797          	auipc	a5,0x8
    800044dc:	a787b783          	ld	a5,-1416(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800044e0:	0007b783          	ld	a5,0(a5)
    800044e4:	0607b783          	ld	a5,96(a5)
    800044e8:	02078863          	beqz	a5,80004518 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800044ec:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800044f0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800044f4:	00000097          	auipc	ra,0x0
    800044f8:	bc4080e7          	jalr	-1084(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800044fc:	00813083          	ld	ra,8(sp)
    80004500:	00013403          	ld	s0,0(sp)
    80004504:	01010113          	addi	sp,sp,16
    80004508:	00008067          	ret
        ((SCB*)ihandle)->wait();
    8000450c:	fffff097          	auipc	ra,0xfffff
    80004510:	a98080e7          	jalr	-1384(ra) # 80002fa4 <_ZN3SCB4waitEv>
    80004514:	fc5ff06f          	j	800044d8 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80004518:	00000793          	li	a5,0
    8000451c:	fd5ff06f          	j	800044f0 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080004520 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80004520:	ff010113          	addi	sp,sp,-16
    80004524:	00113423          	sd	ra,8(sp)
    80004528:	00813023          	sd	s0,0(sp)
    8000452c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004530:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80004534:	02051263          	bnez	a0,80004558 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80004538:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000453c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004540:	00000097          	auipc	ra,0x0
    80004544:	b78080e7          	jalr	-1160(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004548:	00813083          	ld	ra,8(sp)
    8000454c:	00013403          	ld	s0,0(sp)
    80004550:	01010113          	addi	sp,sp,16
    80004554:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80004558:	fffff097          	auipc	ra,0xfffff
    8000455c:	a9c080e7          	jalr	-1380(ra) # 80002ff4 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80004560:	00000793          	li	a5,0
    80004564:	fd9ff06f          	j	8000453c <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080004568 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80004568:	fe010113          	addi	sp,sp,-32
    8000456c:	00113c23          	sd	ra,24(sp)
    80004570:	00813823          	sd	s0,16(sp)
    80004574:	00913423          	sd	s1,8(sp)
    80004578:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    8000457c:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80004580:	00008797          	auipc	a5,0x8
    80004584:	9d07b783          	ld	a5,-1584(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004588:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    8000458c:	00008797          	auipc	a5,0x8
    80004590:	c0c7b783          	ld	a5,-1012(a5) # 8000c198 <_ZN5RiscV10globalTimeE>
    80004594:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80004598:	00e787b3          	add	a5,a5,a4
    8000459c:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    800045a0:	00048513          	mv	a0,s1
    800045a4:	00001097          	auipc	ra,0x1
    800045a8:	8a0080e7          	jalr	-1888(ra) # 80004e44 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    800045ac:	00300793          	li	a5,3
    800045b0:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    800045b4:	fffff097          	auipc	ra,0xfffff
    800045b8:	c8c080e7          	jalr	-884(ra) # 80003240 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    800045bc:	00000793          	li	a5,0
    800045c0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800045c4:	00000097          	auipc	ra,0x0
    800045c8:	af4080e7          	jalr	-1292(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800045cc:	01813083          	ld	ra,24(sp)
    800045d0:	01013403          	ld	s0,16(sp)
    800045d4:	00813483          	ld	s1,8(sp)
    800045d8:	02010113          	addi	sp,sp,32
    800045dc:	00008067          	ret

00000000800045e0 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    800045e0:	fe010113          	addi	sp,sp,-32
    800045e4:	00113c23          	sd	ra,24(sp)
    800045e8:	00813823          	sd	s0,16(sp)
    800045ec:	00913423          	sd	s1,8(sp)
    800045f0:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    800045f4:	00008797          	auipc	a5,0x8
    800045f8:	b9c7c783          	lbu	a5,-1124(a5) # 8000c190 <_ZN5RiscV16userMainFinishedE>
    800045fc:	00079c63          	bnez	a5,80004614 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80004600:	00008717          	auipc	a4,0x8
    80004604:	90073703          	ld	a4,-1792(a4) # 8000bf00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004608:	00073783          	ld	a5,0(a4)
    8000460c:	00178793          	addi	a5,a5,1
    80004610:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80004614:	00001097          	auipc	ra,0x1
    80004618:	b08080e7          	jalr	-1272(ra) # 8000511c <_ZN11ConsoleUtil8getInputEv>
    8000461c:	00050493          	mv	s1,a0
    if(c==13) {
    80004620:	00d00793          	li	a5,13
    80004624:	02f50663          	beq	a0,a5,80004650 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80004628:	01b00793          	li	a5,27
    8000462c:	04f51063          	bne	a0,a5,8000466c <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80004630:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80004634:	00000097          	auipc	ra,0x0
    80004638:	a84080e7          	jalr	-1404(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000463c:	01813083          	ld	ra,24(sp)
    80004640:	01013403          	ld	s0,16(sp)
    80004644:	00813483          	ld	s1,8(sp)
    80004648:	02010113          	addi	sp,sp,32
    8000464c:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80004650:	00d00513          	li	a0,13
    80004654:	00001097          	auipc	ra,0x1
    80004658:	b38080e7          	jalr	-1224(ra) # 8000518c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    8000465c:	00a00513          	li	a0,10
    80004660:	00001097          	auipc	ra,0x1
    80004664:	b2c080e7          	jalr	-1236(ra) # 8000518c <_ZN11ConsoleUtil9putOutputEc>
    80004668:	fc9ff06f          	j	80004630 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    8000466c:	00001097          	auipc	ra,0x1
    80004670:	b20080e7          	jalr	-1248(ra) # 8000518c <_ZN11ConsoleUtil9putOutputEc>
    80004674:	fbdff06f          	j	80004630 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004678 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004678:	ff010113          	addi	sp,sp,-16
    8000467c:	00113423          	sd	ra,8(sp)
    80004680:	00813023          	sd	s0,0(sp)
    80004684:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80004688:	00001097          	auipc	ra,0x1
    8000468c:	b9c080e7          	jalr	-1124(ra) # 80005224 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80004690:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004694:	00000097          	auipc	ra,0x0
    80004698:	a24080e7          	jalr	-1500(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000469c:	00813083          	ld	ra,8(sp)
    800046a0:	00013403          	ld	s0,0(sp)
    800046a4:	01010113          	addi	sp,sp,16
    800046a8:	00008067          	ret

00000000800046ac <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    800046ac:	fe010113          	addi	sp,sp,-32
    800046b0:	00113c23          	sd	ra,24(sp)
    800046b4:	00813823          	sd	s0,16(sp)
    800046b8:	00913423          	sd	s1,8(sp)
    800046bc:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800046c0:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800046c4:	02049463          	bnez	s1,800046ec <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800046c8:	fff00793          	li	a5,-1
    800046cc:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800046d0:	00000097          	auipc	ra,0x0
    800046d4:	9e8080e7          	jalr	-1560(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    800046d8:	01813083          	ld	ra,24(sp)
    800046dc:	01013403          	ld	s0,16(sp)
    800046e0:	00813483          	ld	s1,8(sp)
    800046e4:	02010113          	addi	sp,sp,32
    800046e8:	00008067          	ret
        kfree(thr->stack);
    800046ec:	0284b503          	ld	a0,40(s1)
    800046f0:	00001097          	auipc	ra,0x1
    800046f4:	e94080e7          	jalr	-364(ra) # 80005584 <_Z5kfreePKv>
        delete thr;
    800046f8:	00048513          	mv	a0,s1
    800046fc:	fffff097          	auipc	ra,0xfffff
    80004700:	b1c080e7          	jalr	-1252(ra) # 80003218 <_ZN3TCBD1Ev>
    80004704:	00048513          	mv	a0,s1
    80004708:	fffff097          	auipc	ra,0xfffff
    8000470c:	cdc080e7          	jalr	-804(ra) # 800033e4 <_ZN3TCBdlEPv>
    80004710:	fb9ff06f          	j	800046c8 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080004714 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80004714:	fe010113          	addi	sp,sp,-32
    80004718:	00113c23          	sd	ra,24(sp)
    8000471c:	00813823          	sd	s0,16(sp)
    80004720:	00913423          	sd	s1,8(sp)
    80004724:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004728:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    8000472c:	02049463          	bnez	s1,80004754 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004730:	fff00793          	li	a5,-1
    80004734:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004738:	00000097          	auipc	ra,0x0
    8000473c:	980080e7          	jalr	-1664(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004740:	01813083          	ld	ra,24(sp)
    80004744:	01013403          	ld	s0,16(sp)
    80004748:	00813483          	ld	s1,8(sp)
    8000474c:	02010113          	addi	sp,sp,32
    80004750:	00008067          	ret
        delete scb;
    80004754:	00048513          	mv	a0,s1
    80004758:	ffffe097          	auipc	ra,0xffffe
    8000475c:	740080e7          	jalr	1856(ra) # 80002e98 <_ZN3SCBD1Ev>
    80004760:	00048513          	mv	a0,s1
    80004764:	fffff097          	auipc	ra,0xfffff
    80004768:	8fc080e7          	jalr	-1796(ra) # 80003060 <_ZN3SCBdlEPv>
    8000476c:	fc5ff06f          	j	80004730 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080004770 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80004770:	fe010113          	addi	sp,sp,-32
    80004774:	00113c23          	sd	ra,24(sp)
    80004778:	00813823          	sd	s0,16(sp)
    8000477c:	00913423          	sd	s1,8(sp)
    80004780:	01213023          	sd	s2,0(sp)
    80004784:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80004788:	00001537          	lui	a0,0x1
    8000478c:	00001097          	auipc	ra,0x1
    80004790:	dd0080e7          	jalr	-560(ra) # 8000555c <_Z7kmallocm>
    80004794:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80004798:	00007797          	auipc	a5,0x7
    8000479c:	7b87b783          	ld	a5,1976(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800047a0:	0007b783          	ld	a5,0(a5)
    800047a4:	00001637          	lui	a2,0x1
    800047a8:	00050593          	mv	a1,a0
    800047ac:	0287b503          	ld	a0,40(a5)
    800047b0:	fffff097          	auipc	ra,0xfffff
    800047b4:	100080e7          	jalr	256(ra) # 800038b0 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800047b8:	07000513          	li	a0,112
    800047bc:	fffff097          	auipc	ra,0xfffff
    800047c0:	b04080e7          	jalr	-1276(ra) # 800032c0 <_ZN3TCBnwEm>
    800047c4:	00050493          	mv	s1,a0
    800047c8:	00050e63          	beqz	a0,800047e4 <_ZN5RiscV18executeForkSyscallEv+0x74>
    800047cc:	00200713          	li	a4,2
    800047d0:	00090693          	mv	a3,s2
    800047d4:	00000613          	li	a2,0
    800047d8:	00000593          	li	a1,0
    800047dc:	fffff097          	auipc	ra,0xfffff
    800047e0:	9a8080e7          	jalr	-1624(ra) # 80003184 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    800047e4:	0a048e63          	beqz	s1,800048a0 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    800047e8:	00007797          	auipc	a5,0x7
    800047ec:	7307b783          	ld	a5,1840(a5) # 8000bf18 <_GLOBAL_OFFSET_TABLE_+0x50>
    800047f0:	0007b783          	ld	a5,0(a5)
    800047f4:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    800047f8:	00007797          	auipc	a5,0x7
    800047fc:	7107b783          	ld	a5,1808(a5) # 8000bf08 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004800:	0007b783          	ld	a5,0(a5)
    80004804:	00f907b3          	add	a5,s2,a5
    80004808:	00007717          	auipc	a4,0x7
    8000480c:	74873703          	ld	a4,1864(a4) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004810:	00073683          	ld	a3,0(a4)
    80004814:	0286b683          	ld	a3,40(a3)
    80004818:	40d787b3          	sub	a5,a5,a3
    8000481c:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80004820:	00073783          	ld	a5,0(a4)
    80004824:	0687b503          	ld	a0,104(a5)
    80004828:	0287b783          	ld	a5,40(a5)
    8000482c:	40f50533          	sub	a0,a0,a5
    80004830:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80004834:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80004838:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    8000483c:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80004840:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80004844:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80004848:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    8000484c:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80004850:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80004854:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80004858:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    8000485c:	00073783          	ld	a5,0(a4)
    80004860:	0387b703          	ld	a4,56(a5)
    80004864:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004868:	0407b783          	ld	a5,64(a5)
    8000486c:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004870:	00048513          	mv	a0,s1
    80004874:	00000097          	auipc	ra,0x0
    80004878:	554080e7          	jalr	1364(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    8000487c:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80004880:	00000097          	auipc	ra,0x0
    80004884:	838080e7          	jalr	-1992(ra) # 800040b8 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004888:	01813083          	ld	ra,24(sp)
    8000488c:	01013403          	ld	s0,16(sp)
    80004890:	00813483          	ld	s1,8(sp)
    80004894:	00013903          	ld	s2,0(sp)
    80004898:	02010113          	addi	sp,sp,32
    8000489c:	00008067          	ret
        status = -1;
    800048a0:	fff00493          	li	s1,-1
    800048a4:	fd9ff06f          	j	8000487c <_ZN5RiscV18executeForkSyscallEv+0x10c>
    800048a8:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800048ac:	00048513          	mv	a0,s1
    800048b0:	fffff097          	auipc	ra,0xfffff
    800048b4:	b34080e7          	jalr	-1228(ra) # 800033e4 <_ZN3TCBdlEPv>
    800048b8:	00090513          	mv	a0,s2
    800048bc:	00009097          	auipc	ra,0x9
    800048c0:	a3c080e7          	jalr	-1476(ra) # 8000d2f8 <_Unwind_Resume>

00000000800048c4 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    800048c4:	ff010113          	addi	sp,sp,-16
    800048c8:	00813423          	sd	s0,8(sp)
    800048cc:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800048d0:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800048d4:	00878793          	addi	a5,a5,8
    800048d8:	00007717          	auipc	a4,0x7
    800048dc:	64073703          	ld	a4,1600(a4) # 8000bf18 <_GLOBAL_OFFSET_TABLE_+0x50>
    800048e0:	00f73023          	sd	a5,0(a4)
}
    800048e4:	00813403          	ld	s0,8(sp)
    800048e8:	01010113          	addi	sp,sp,16
    800048ec:	00008067          	ret

00000000800048f0 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    800048f0:	fa010113          	addi	sp,sp,-96
    800048f4:	04113c23          	sd	ra,88(sp)
    800048f8:	04813823          	sd	s0,80(sp)
    800048fc:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004900:	142027f3          	csrr	a5,scause
    80004904:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80004908:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    8000490c:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80004910:	00007797          	auipc	a5,0x7
    80004914:	6407b783          	ld	a5,1600(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004918:	0007b783          	ld	a5,0(a5)
    8000491c:	14002773          	csrr	a4,sscratch
    80004920:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80004924:	fe843703          	ld	a4,-24(s0)
    80004928:	00900793          	li	a5,9
    8000492c:	0ef70663          	beq	a4,a5,80004a18 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    80004930:	fe843703          	ld	a4,-24(s0)
    80004934:	00800793          	li	a5,8
    80004938:	0ef70063          	beq	a4,a5,80004a18 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    8000493c:	fe843703          	ld	a4,-24(s0)
    80004940:	fff00793          	li	a5,-1
    80004944:	03f79793          	slli	a5,a5,0x3f
    80004948:	00178793          	addi	a5,a5,1
    8000494c:	24f70263          	beq	a4,a5,80004b90 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    80004950:	fe843703          	ld	a4,-24(s0)
    80004954:	fff00793          	li	a5,-1
    80004958:	03f79793          	slli	a5,a5,0x3f
    8000495c:	00978793          	addi	a5,a5,9
    80004960:	2cf70063          	beq	a4,a5,80004c20 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80004964:	fe843703          	ld	a4,-24(s0)
    80004968:	00200793          	li	a5,2
    8000496c:	34f70863          	beq	a4,a5,80004cbc <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004970:	00005517          	auipc	a0,0x5
    80004974:	a6050513          	addi	a0,a0,-1440 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004978:	00001097          	auipc	ra,0x1
    8000497c:	91c080e7          	jalr	-1764(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004980:	00005517          	auipc	a0,0x5
    80004984:	a6050513          	addi	a0,a0,-1440 # 800093e0 <CONSOLE_STATUS+0x3d0>
    80004988:	00001097          	auipc	ra,0x1
    8000498c:	90c080e7          	jalr	-1780(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004990:	142027f3          	csrr	a5,scause
    80004994:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004998:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    8000499c:	00000613          	li	a2,0
    800049a0:	00a00593          	li	a1,10
    800049a4:	0005051b          	sext.w	a0,a0
    800049a8:	00001097          	auipc	ra,0x1
    800049ac:	930080e7          	jalr	-1744(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    800049b0:	00005517          	auipc	a0,0x5
    800049b4:	9f050513          	addi	a0,a0,-1552 # 800093a0 <CONSOLE_STATUS+0x390>
    800049b8:	00001097          	auipc	ra,0x1
    800049bc:	8dc080e7          	jalr	-1828(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800049c0:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800049c4:	00000613          	li	a2,0
    800049c8:	01000593          	li	a1,16
    800049cc:	0005051b          	sext.w	a0,a0
    800049d0:	00001097          	auipc	ra,0x1
    800049d4:	908080e7          	jalr	-1784(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800049d8:	00005517          	auipc	a0,0x5
    800049dc:	9c050513          	addi	a0,a0,-1600 # 80009398 <CONSOLE_STATUS+0x388>
    800049e0:	00001097          	auipc	ra,0x1
    800049e4:	8b4080e7          	jalr	-1868(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    800049e8:	00007797          	auipc	a5,0x7
    800049ec:	5687b783          	ld	a5,1384(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    800049f0:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800049f4:	00200713          	li	a4,2
    800049f8:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    800049fc:	00005517          	auipc	a0,0x5
    80004a00:	9f450513          	addi	a0,a0,-1548 # 800093f0 <CONSOLE_STATUS+0x3e0>
    80004a04:	00001097          	auipc	ra,0x1
    80004a08:	890080e7          	jalr	-1904(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004a0c:	fffff097          	auipc	ra,0xfffff
    80004a10:	834080e7          	jalr	-1996(ra) # 80003240 <_ZN3TCB8dispatchEv>
    80004a14:	0800006f          	j	80004a94 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004a18:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004a1c:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004a20:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80004a24:	00478793          	addi	a5,a5,4
    80004a28:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80004a2c:	00007797          	auipc	a5,0x7
    80004a30:	5247b783          	ld	a5,1316(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004a34:	0007b783          	ld	a5,0(a5)
    80004a38:	fb043703          	ld	a4,-80(s0)
    80004a3c:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80004a40:	fa843703          	ld	a4,-88(s0)
    80004a44:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80004a48:	00050793          	mv	a5,a0
        switch(syscallID){
    80004a4c:	06100713          	li	a4,97
    80004a50:	02f76463          	bltu	a4,a5,80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    80004a54:	00279793          	slli	a5,a5,0x2
    80004a58:	00005717          	auipc	a4,0x5
    80004a5c:	9ac70713          	addi	a4,a4,-1620 # 80009404 <CONSOLE_STATUS+0x3f4>
    80004a60:	00e787b3          	add	a5,a5,a4
    80004a64:	0007a783          	lw	a5,0(a5)
    80004a68:	00e787b3          	add	a5,a5,a4
    80004a6c:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004a70:	fffff097          	auipc	ra,0xfffff
    80004a74:	680080e7          	jalr	1664(ra) # 800040f0 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004a78:	00007797          	auipc	a5,0x7
    80004a7c:	4d87b783          	ld	a5,1240(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004a80:	0007b783          	ld	a5,0(a5)
    80004a84:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004a88:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80004a8c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004a90:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004a94:	fffff097          	auipc	ra,0xfffff
    80004a98:	52c080e7          	jalr	1324(ra) # 80003fc0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80004a9c:	05813083          	ld	ra,88(sp)
    80004aa0:	05013403          	ld	s0,80(sp)
    80004aa4:	06010113          	addi	sp,sp,96
    80004aa8:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004aac:	fffff097          	auipc	ra,0xfffff
    80004ab0:	67c080e7          	jalr	1660(ra) # 80004128 <_ZN5RiscV21executeMemFreeSyscallEv>
    80004ab4:	fc5ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80004ab8:	fffff097          	auipc	ra,0xfffff
    80004abc:	6c0080e7          	jalr	1728(ra) # 80004178 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004ac0:	fb9ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80004ac4:	00000097          	auipc	ra,0x0
    80004ac8:	8a8080e7          	jalr	-1880(ra) # 8000436c <_ZN5RiscV24executeThreadExitSyscallEv>
    80004acc:	fadff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004ad0:	fffff097          	auipc	ra,0xfffff
    80004ad4:	3dc080e7          	jalr	988(ra) # 80003eac <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004ad8:	fa1ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004adc:	fffff097          	auipc	ra,0xfffff
    80004ae0:	770080e7          	jalr	1904(ra) # 8000424c <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004ae4:	f95ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004ae8:	00000097          	auipc	ra,0x0
    80004aec:	82c080e7          	jalr	-2004(ra) # 80004314 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004af0:	f89ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80004af4:	00000097          	auipc	ra,0x0
    80004af8:	8d0080e7          	jalr	-1840(ra) # 800043c4 <_ZN5RiscV21executeSemOpenSyscallEv>
    80004afc:	f7dff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80004b00:	00000097          	auipc	ra,0x0
    80004b04:	960080e7          	jalr	-1696(ra) # 80004460 <_ZN5RiscV22executeSemCloseSyscallEv>
    80004b08:	f71ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80004b0c:	00000097          	auipc	ra,0x0
    80004b10:	9b4080e7          	jalr	-1612(ra) # 800044c0 <_ZN5RiscV21executeSemWaitSyscallEv>
    80004b14:	f65ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80004b18:	00000097          	auipc	ra,0x0
    80004b1c:	a08080e7          	jalr	-1528(ra) # 80004520 <_ZN5RiscV23executeSemSignalSyscallEv>
    80004b20:	f59ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    80004b24:	00000097          	auipc	ra,0x0
    80004b28:	a44080e7          	jalr	-1468(ra) # 80004568 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004b2c:	f4dff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80004b30:	00000097          	auipc	ra,0x0
    80004b34:	ab0080e7          	jalr	-1360(ra) # 800045e0 <_ZN5RiscV18executeGetcSyscallEv>
    80004b38:	f41ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80004b3c:	fffff097          	auipc	ra,0xfffff
    80004b40:	3ac080e7          	jalr	940(ra) # 80003ee8 <_ZN5RiscV18executePutcSyscallEv>
    80004b44:	f35ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80004b48:	00000097          	auipc	ra,0x0
    80004b4c:	b30080e7          	jalr	-1232(ra) # 80004678 <_ZN5RiscV22executePutcUtilSyscallEv>
    80004b50:	f29ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    80004b54:	00000097          	auipc	ra,0x0
    80004b58:	b58080e7          	jalr	-1192(ra) # 800046ac <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004b5c:	f1dff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004b60:	00000097          	auipc	ra,0x0
    80004b64:	bb4080e7          	jalr	-1100(ra) # 80004714 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004b68:	f11ff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004b6c:	00010793          	mv	a5,sp
    80004b70:	00007717          	auipc	a4,0x7
    80004b74:	39873703          	ld	a4,920(a4) # 8000bf08 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004b78:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004b7c:	00000097          	auipc	ra,0x0
    80004b80:	d48080e7          	jalr	-696(ra) # 800048c4 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004b84:	00000097          	auipc	ra,0x0
    80004b88:	bec080e7          	jalr	-1044(ra) # 80004770 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004b8c:	eedff06f          	j	80004a78 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004b90:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004b94:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004b98:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004b9c:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004ba0:	00200793          	li	a5,2
    80004ba4:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80004ba8:	00007717          	auipc	a4,0x7
    80004bac:	5e870713          	addi	a4,a4,1512 # 8000c190 <_ZN5RiscV16userMainFinishedE>
    80004bb0:	00873783          	ld	a5,8(a4)
    80004bb4:	00178793          	addi	a5,a5,1
    80004bb8:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80004bbc:	00000097          	auipc	ra,0x0
    80004bc0:	2e0080e7          	jalr	736(ra) # 80004e9c <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004bc4:	00007717          	auipc	a4,0x7
    80004bc8:	32473703          	ld	a4,804(a4) # 8000bee8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004bcc:	00073783          	ld	a5,0(a4)
    80004bd0:	00178793          	addi	a5,a5,1
    80004bd4:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004bd8:	00007717          	auipc	a4,0x7
    80004bdc:	37873703          	ld	a4,888(a4) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004be0:	00073703          	ld	a4,0(a4)
    80004be4:	03073683          	ld	a3,48(a4)
    80004be8:	00d7fc63          	bgeu	a5,a3,80004c00 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004bec:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004bf0:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004bf4:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004bf8:	14179073          	csrw	sepc,a5
}
    80004bfc:	e99ff06f          	j	80004a94 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80004c00:	00007797          	auipc	a5,0x7
    80004c04:	2e87b783          	ld	a5,744(a5) # 8000bee8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004c08:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004c0c:	00100793          	li	a5,1
    80004c10:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004c14:	ffffe097          	auipc	ra,0xffffe
    80004c18:	62c080e7          	jalr	1580(ra) # 80003240 <_ZN3TCB8dispatchEv>
    80004c1c:	fd1ff06f          	j	80004bec <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004c20:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004c24:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004c28:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004c2c:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80004c30:	00007797          	auipc	a5,0x7
    80004c34:	2a87b783          	ld	a5,680(a5) # 8000bed8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004c38:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004c3c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004c40:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004c44:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004c48:	0017f793          	andi	a5,a5,1
    80004c4c:	02078863          	beqz	a5,80004c7c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80004c50:	00007797          	auipc	a5,0x7
    80004c54:	2a87b783          	ld	a5,680(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004c58:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004c5c:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004c60:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004c64:	00058513          	mv	a0,a1
    80004c68:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004c6c:	00007797          	auipc	a5,0x7
    80004c70:	2947b783          	ld	a5,660(a5) # 8000bf00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004c74:	0007b783          	ld	a5,0(a5)
    80004c78:	02079463          	bnez	a5,80004ca0 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80004c7c:	00002097          	auipc	ra,0x2
    80004c80:	7a8080e7          	jalr	1960(ra) # 80007424 <plic_claim>
    80004c84:	00002097          	auipc	ra,0x2
    80004c88:	7d8080e7          	jalr	2008(ra) # 8000745c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004c8c:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004c90:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004c94:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004c98:	14179073          	csrw	sepc,a5
}
    80004c9c:	df9ff06f          	j	80004a94 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004ca0:	fff78793          	addi	a5,a5,-1
    80004ca4:	00007717          	auipc	a4,0x7
    80004ca8:	25c73703          	ld	a4,604(a4) # 8000bf00 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004cac:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004cb0:	00000097          	auipc	ra,0x0
    80004cb4:	3f0080e7          	jalr	1008(ra) # 800050a0 <_ZN11ConsoleUtil8putInputEc>
    80004cb8:	fc5ff06f          	j	80004c7c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80004cbc:	00007797          	auipc	a5,0x7
    80004cc0:	2947b783          	ld	a5,660(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004cc4:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004cc8:	00200713          	li	a4,2
    80004ccc:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004cd0:	00004517          	auipc	a0,0x4
    80004cd4:	6d050513          	addi	a0,a0,1744 # 800093a0 <CONSOLE_STATUS+0x390>
    80004cd8:	00000097          	auipc	ra,0x0
    80004cdc:	5bc080e7          	jalr	1468(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004ce0:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004ce4:	00000613          	li	a2,0
    80004ce8:	01000593          	li	a1,16
    80004cec:	0005051b          	sext.w	a0,a0
    80004cf0:	00000097          	auipc	ra,0x0
    80004cf4:	5e8080e7          	jalr	1512(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004cf8:	00004517          	auipc	a0,0x4
    80004cfc:	6a050513          	addi	a0,a0,1696 # 80009398 <CONSOLE_STATUS+0x388>
    80004d00:	00000097          	auipc	ra,0x0
    80004d04:	594080e7          	jalr	1428(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004d08:	00004517          	auipc	a0,0x4
    80004d0c:	6a050513          	addi	a0,a0,1696 # 800093a8 <CONSOLE_STATUS+0x398>
    80004d10:	00000097          	auipc	ra,0x0
    80004d14:	584080e7          	jalr	1412(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004d18:	ffffe097          	auipc	ra,0xffffe
    80004d1c:	528080e7          	jalr	1320(ra) # 80003240 <_ZN3TCB8dispatchEv>
    80004d20:	d75ff06f          	j	80004a94 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

0000000080004d24 <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004d24:	ff010113          	addi	sp,sp,-16
    80004d28:	00813423          	sd	s0,8(sp)
    80004d2c:	01010413          	addi	s0,sp,16
    80004d30:	00050793          	mv	a5,a0
    80004d34:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004d38:	0007c703          	lbu	a4,0(a5)
    80004d3c:	00070a63          	beqz	a4,80004d50 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004d40:	00178793          	addi	a5,a5,1
    80004d44:	00e50023          	sb	a4,0(a0)
    80004d48:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004d4c:	fedff06f          	j	80004d38 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004d50:	00e50023          	sb	a4,0(a0)
    return dst;
}
    80004d54:	00813403          	ld	s0,8(sp)
    80004d58:	01010113          	addi	sp,sp,16
    80004d5c:	00008067          	ret

0000000080004d60 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004d60:	fe010113          	addi	sp,sp,-32
    80004d64:	00113c23          	sd	ra,24(sp)
    80004d68:	00813823          	sd	s0,16(sp)
    80004d6c:	00913423          	sd	s1,8(sp)
    80004d70:	02010413          	addi	s0,sp,32
    80004d74:	00050493          	mv	s1,a0
    80004d78:	00058513          	mv	a0,a1
    char *dest = dst;
    80004d7c:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004d80:	0005c783          	lbu	a5,0(a1)
    80004d84:	00078663          	beqz	a5,80004d90 <_Z6strcatPcPKc+0x30>
        dest++;
    80004d88:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004d8c:	ff5ff06f          	j	80004d80 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004d90:	00000097          	auipc	ra,0x0
    80004d94:	f94080e7          	jalr	-108(ra) # 80004d24 <_Z6strcpyPKcPc>
    return dst;
}
    80004d98:	00048513          	mv	a0,s1
    80004d9c:	01813083          	ld	ra,24(sp)
    80004da0:	01013403          	ld	s0,16(sp)
    80004da4:	00813483          	ld	s1,8(sp)
    80004da8:	02010113          	addi	sp,sp,32
    80004dac:	00008067          	ret

0000000080004db0 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004db0:	ff010113          	addi	sp,sp,-16
    80004db4:	00813423          	sd	s0,8(sp)
    80004db8:	01010413          	addi	s0,sp,16
}
    80004dbc:	00813403          	ld	s0,8(sp)
    80004dc0:	01010113          	addi	sp,sp,16
    80004dc4:	00008067          	ret

0000000080004dc8 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004dc8:	ff010113          	addi	sp,sp,-16
    80004dcc:	00813423          	sd	s0,8(sp)
    80004dd0:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004dd4:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004dd8:	00007797          	auipc	a5,0x7
    80004ddc:	3c87b783          	ld	a5,968(a5) # 8000c1a0 <_ZN9Scheduler9readyHeadE>
    80004de0:	02078263          	beqz	a5,80004e04 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004de4:	00007797          	auipc	a5,0x7
    80004de8:	3c47b783          	ld	a5,964(a5) # 8000c1a8 <_ZN9Scheduler9readyTailE>
    80004dec:	04a7b423          	sd	a0,72(a5)
    80004df0:	00007797          	auipc	a5,0x7
    80004df4:	3aa7bc23          	sd	a0,952(a5) # 8000c1a8 <_ZN9Scheduler9readyTailE>
}
    80004df8:	00813403          	ld	s0,8(sp)
    80004dfc:	01010113          	addi	sp,sp,16
    80004e00:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004e04:	00007797          	auipc	a5,0x7
    80004e08:	38a7be23          	sd	a0,924(a5) # 8000c1a0 <_ZN9Scheduler9readyHeadE>
    80004e0c:	fe5ff06f          	j	80004df0 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004e10 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004e10:	ff010113          	addi	sp,sp,-16
    80004e14:	00813423          	sd	s0,8(sp)
    80004e18:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004e1c:	00007517          	auipc	a0,0x7
    80004e20:	38453503          	ld	a0,900(a0) # 8000c1a0 <_ZN9Scheduler9readyHeadE>
    80004e24:	00050a63          	beqz	a0,80004e38 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004e28:	04853783          	ld	a5,72(a0)
    80004e2c:	00007717          	auipc	a4,0x7
    80004e30:	36f73a23          	sd	a5,884(a4) # 8000c1a0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004e34:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004e38:	00813403          	ld	s0,8(sp)
    80004e3c:	01010113          	addi	sp,sp,16
    80004e40:	00008067          	ret

0000000080004e44 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004e44:	ff010113          	addi	sp,sp,-16
    80004e48:	00813423          	sd	s0,8(sp)
    80004e4c:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004e50:	00007797          	auipc	a5,0x7
    80004e54:	3607b783          	ld	a5,864(a5) # 8000c1b0 <_ZN9Scheduler12sleepingHeadE>
    80004e58:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004e5c:	00078e63          	beqz	a5,80004e78 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004e60:	0587b683          	ld	a3,88(a5)
    80004e64:	05853703          	ld	a4,88(a0)
    80004e68:	00d76863          	bltu	a4,a3,80004e78 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004e6c:	00078613          	mv	a2,a5
    80004e70:	0487b783          	ld	a5,72(a5)
    80004e74:	fe9ff06f          	j	80004e5c <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004e78:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004e7c:	00060a63          	beqz	a2,80004e90 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004e80:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004e84:	00813403          	ld	s0,8(sp)
    80004e88:	01010113          	addi	sp,sp,16
    80004e8c:	00008067          	ret
        sleepingHead = t;
    80004e90:	00007797          	auipc	a5,0x7
    80004e94:	32a7b023          	sd	a0,800(a5) # 8000c1b0 <_ZN9Scheduler12sleepingHeadE>
}
    80004e98:	fedff06f          	j	80004e84 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004e9c <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004e9c:	fe010113          	addi	sp,sp,-32
    80004ea0:	00113c23          	sd	ra,24(sp)
    80004ea4:	00813823          	sd	s0,16(sp)
    80004ea8:	00913423          	sd	s1,8(sp)
    80004eac:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004eb0:	00007497          	auipc	s1,0x7
    80004eb4:	3004b483          	ld	s1,768(s1) # 8000c1b0 <_ZN9Scheduler12sleepingHeadE>
    80004eb8:	02048c63          	beqz	s1,80004ef0 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004ebc:	0584b703          	ld	a4,88(s1)
    80004ec0:	00007797          	auipc	a5,0x7
    80004ec4:	0a87b783          	ld	a5,168(a5) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80004ec8:	0007b783          	ld	a5,0(a5)
    80004ecc:	02e7e263          	bltu	a5,a4,80004ef0 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004ed0:	0484b783          	ld	a5,72(s1)
    80004ed4:	00007717          	auipc	a4,0x7
    80004ed8:	2cf73e23          	sd	a5,732(a4) # 8000c1b0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004edc:	00048513          	mv	a0,s1
    80004ee0:	00000097          	auipc	ra,0x0
    80004ee4:	ee8080e7          	jalr	-280(ra) # 80004dc8 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004ee8:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004eec:	fc5ff06f          	j	80004eb0 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004ef0:	01813083          	ld	ra,24(sp)
    80004ef4:	01013403          	ld	s0,16(sp)
    80004ef8:	00813483          	ld	s1,8(sp)
    80004efc:	02010113          	addi	sp,sp,32
    80004f00:	00008067          	ret

0000000080004f04 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004f04:	fe010113          	addi	sp,sp,-32
    80004f08:	00113c23          	sd	ra,24(sp)
    80004f0c:	00813823          	sd	s0,16(sp)
    80004f10:	00913423          	sd	s1,8(sp)
    80004f14:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004f18:	00007497          	auipc	s1,0x7
    80004f1c:	2884b483          	ld	s1,648(s1) # 8000c1a0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004f20:	02048863          	beqz	s1,80004f50 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004f24:	00000613          	li	a2,0
    80004f28:	01000593          	li	a1,16
    80004f2c:	0004851b          	sext.w	a0,s1
    80004f30:	00000097          	auipc	ra,0x0
    80004f34:	3a8080e7          	jalr	936(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004f38:	00004517          	auipc	a0,0x4
    80004f3c:	46050513          	addi	a0,a0,1120 # 80009398 <CONSOLE_STATUS+0x388>
    80004f40:	00000097          	auipc	ra,0x0
    80004f44:	354080e7          	jalr	852(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004f48:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004f4c:	fd5ff06f          	j	80004f20 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004f50:	01813083          	ld	ra,24(sp)
    80004f54:	01013403          	ld	s0,16(sp)
    80004f58:	00813483          	ld	s1,8(sp)
    80004f5c:	02010113          	addi	sp,sp,32
    80004f60:	00008067          	ret

0000000080004f64 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004f64:	fe010113          	addi	sp,sp,-32
    80004f68:	00113c23          	sd	ra,24(sp)
    80004f6c:	00813823          	sd	s0,16(sp)
    80004f70:	00913423          	sd	s1,8(sp)
    80004f74:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004f78:	00007497          	auipc	s1,0x7
    80004f7c:	2384b483          	ld	s1,568(s1) # 8000c1b0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004f80:	02048863          	beqz	s1,80004fb0 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004f84:	00000613          	li	a2,0
    80004f88:	01000593          	li	a1,16
    80004f8c:	0004851b          	sext.w	a0,s1
    80004f90:	ffffe097          	auipc	ra,0xffffe
    80004f94:	d4c080e7          	jalr	-692(ra) # 80002cdc <_Z8printIntiii>
        printString("\n");
    80004f98:	00004517          	auipc	a0,0x4
    80004f9c:	40050513          	addi	a0,a0,1024 # 80009398 <CONSOLE_STATUS+0x388>
    80004fa0:	ffffe097          	auipc	ra,0xffffe
    80004fa4:	ba4080e7          	jalr	-1116(ra) # 80002b44 <_Z11printStringPKc>
        iter = iter->next;
    80004fa8:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004fac:	fd5ff06f          	j	80004f80 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004fb0:	01813083          	ld	ra,24(sp)
    80004fb4:	01013403          	ld	s0,16(sp)
    80004fb8:	00813483          	ld	s1,8(sp)
    80004fbc:	02010113          	addi	sp,sp,32
    80004fc0:	00008067          	ret

0000000080004fc4 <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;

void ConsoleUtil::initialize() {
    80004fc4:	fe010113          	addi	sp,sp,-32
    80004fc8:	00113c23          	sd	ra,24(sp)
    80004fcc:	00813823          	sd	s0,16(sp)
    80004fd0:	00913423          	sd	s1,8(sp)
    80004fd4:	01213023          	sd	s2,0(sp)
    80004fd8:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004fdc:	01800513          	li	a0,24
    80004fe0:	ffffe097          	auipc	ra,0xffffe
    80004fe4:	050080e7          	jalr	80(ra) # 80003030 <_ZN3SCBnwEm>
    80004fe8:	00050493          	mv	s1,a0
    80004fec:	00050863          	beqz	a0,80004ffc <_ZN11ConsoleUtil10initializeEv+0x38>
    80004ff0:	00000593          	li	a1,0
    80004ff4:	ffffe097          	auipc	ra,0xffffe
    80004ff8:	e88080e7          	jalr	-376(ra) # 80002e7c <_ZN3SCBC1Em>
    80004ffc:	00007797          	auipc	a5,0x7
    80005000:	1a97be23          	sd	s1,444(a5) # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80005004:	01800513          	li	a0,24
    80005008:	ffffe097          	auipc	ra,0xffffe
    8000500c:	028080e7          	jalr	40(ra) # 80003030 <_ZN3SCBnwEm>
    80005010:	00050493          	mv	s1,a0
    80005014:	00050863          	beqz	a0,80005024 <_ZN11ConsoleUtil10initializeEv+0x60>
    80005018:	00000593          	li	a1,0
    8000501c:	ffffe097          	auipc	ra,0xffffe
    80005020:	e60080e7          	jalr	-416(ra) # 80002e7c <_ZN3SCBC1Em>
    80005024:	00007917          	auipc	s2,0x7
    80005028:	19490913          	addi	s2,s2,404 # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    8000502c:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80005030:	00002537          	lui	a0,0x2
    80005034:	00000097          	auipc	ra,0x0
    80005038:	528080e7          	jalr	1320(ra) # 8000555c <_Z7kmallocm>
    8000503c:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80005040:	00002537          	lui	a0,0x2
    80005044:	00000097          	auipc	ra,0x0
    80005048:	518080e7          	jalr	1304(ra) # 8000555c <_Z7kmallocm>
    8000504c:	00a93c23          	sd	a0,24(s2)
}
    80005050:	01813083          	ld	ra,24(sp)
    80005054:	01013403          	ld	s0,16(sp)
    80005058:	00813483          	ld	s1,8(sp)
    8000505c:	00013903          	ld	s2,0(sp)
    80005060:	02010113          	addi	sp,sp,32
    80005064:	00008067          	ret
    80005068:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    8000506c:	00048513          	mv	a0,s1
    80005070:	ffffe097          	auipc	ra,0xffffe
    80005074:	ff0080e7          	jalr	-16(ra) # 80003060 <_ZN3SCBdlEPv>
    80005078:	00090513          	mv	a0,s2
    8000507c:	00008097          	auipc	ra,0x8
    80005080:	27c080e7          	jalr	636(ra) # 8000d2f8 <_Unwind_Resume>
    80005084:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80005088:	00048513          	mv	a0,s1
    8000508c:	ffffe097          	auipc	ra,0xffffe
    80005090:	fd4080e7          	jalr	-44(ra) # 80003060 <_ZN3SCBdlEPv>
    80005094:	00090513          	mv	a0,s2
    80005098:	00008097          	auipc	ra,0x8
    8000509c:	260080e7          	jalr	608(ra) # 8000d2f8 <_Unwind_Resume>

00000000800050a0 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    800050a0:	00007697          	auipc	a3,0x7
    800050a4:	11868693          	addi	a3,a3,280 # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    800050a8:	0206b603          	ld	a2,32(a3)
    800050ac:	00160793          	addi	a5,a2,1
    800050b0:	00002737          	lui	a4,0x2
    800050b4:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    800050b8:	00e7f7b3          	and	a5,a5,a4
    800050bc:	0286b703          	ld	a4,40(a3)
    800050c0:	04e78c63          	beq	a5,a4,80005118 <_ZN11ConsoleUtil8putInputEc+0x78>
void ConsoleUtil::putInput(char c) {
    800050c4:	ff010113          	addi	sp,sp,-16
    800050c8:	00113423          	sd	ra,8(sp)
    800050cc:	00813023          	sd	s0,0(sp)
    800050d0:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    800050d4:	00068713          	mv	a4,a3
    800050d8:	0106b783          	ld	a5,16(a3)
    800050dc:	00c78633          	add	a2,a5,a2
    800050e0:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    800050e4:	0206b783          	ld	a5,32(a3)
    800050e8:	00178793          	addi	a5,a5,1
    800050ec:	000026b7          	lui	a3,0x2
    800050f0:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    800050f4:	00d7f7b3          	and	a5,a5,a3
    800050f8:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    800050fc:	00073503          	ld	a0,0(a4)
    80005100:	ffffe097          	auipc	ra,0xffffe
    80005104:	ef4080e7          	jalr	-268(ra) # 80002ff4 <_ZN3SCB6signalEv>
}
    80005108:	00813083          	ld	ra,8(sp)
    8000510c:	00013403          	ld	s0,0(sp)
    80005110:	01010113          	addi	sp,sp,16
    80005114:	00008067          	ret
    80005118:	00008067          	ret

000000008000511c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    8000511c:	fe010113          	addi	sp,sp,-32
    80005120:	00113c23          	sd	ra,24(sp)
    80005124:	00813823          	sd	s0,16(sp)
    80005128:	00913423          	sd	s1,8(sp)
    8000512c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80005130:	00007497          	auipc	s1,0x7
    80005134:	08848493          	addi	s1,s1,136 # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    80005138:	0004b503          	ld	a0,0(s1)
    8000513c:	ffffe097          	auipc	ra,0xffffe
    80005140:	e68080e7          	jalr	-408(ra) # 80002fa4 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80005144:	0284b783          	ld	a5,40(s1)
    80005148:	0204b703          	ld	a4,32(s1)
    8000514c:	02e78c63          	beq	a5,a4,80005184 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80005150:	0104b703          	ld	a4,16(s1)
    80005154:	00f70733          	add	a4,a4,a5
    80005158:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    8000515c:	00178793          	addi	a5,a5,1
    80005160:	00002737          	lui	a4,0x2
    80005164:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80005168:	00e7f7b3          	and	a5,a5,a4
    8000516c:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80005170:	01813083          	ld	ra,24(sp)
    80005174:	01013403          	ld	s0,16(sp)
    80005178:	00813483          	ld	s1,8(sp)
    8000517c:	02010113          	addi	sp,sp,32
    80005180:	00008067          	ret
        return -1;
    80005184:	0ff00513          	li	a0,255
    80005188:	fe9ff06f          	j	80005170 <_ZN11ConsoleUtil8getInputEv+0x54>

000000008000518c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    8000518c:	00007797          	auipc	a5,0x7
    80005190:	02c78793          	addi	a5,a5,44 # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    80005194:	0307b703          	ld	a4,48(a5)
    80005198:	00170713          	addi	a4,a4,1
    8000519c:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    800051a0:	0387b603          	ld	a2,56(a5)
    800051a4:	00160713          	addi	a4,a2,1
    800051a8:	000026b7          	lui	a3,0x2
    800051ac:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    800051b0:	00d77733          	and	a4,a4,a3
    800051b4:	0407b783          	ld	a5,64(a5)
    800051b8:	06f70463          	beq	a4,a5,80005220 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    800051bc:	ff010113          	addi	sp,sp,-16
    800051c0:	00113423          	sd	ra,8(sp)
    800051c4:	00813023          	sd	s0,0(sp)
    800051c8:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800051cc:	00007797          	auipc	a5,0x7
    800051d0:	fec78793          	addi	a5,a5,-20 # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    800051d4:	0187b703          	ld	a4,24(a5)
    800051d8:	00c70633          	add	a2,a4,a2
    800051dc:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    800051e0:	0387b703          	ld	a4,56(a5)
    800051e4:	00170713          	addi	a4,a4,1
    800051e8:	000026b7          	lui	a3,0x2
    800051ec:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    800051f0:	00d77733          	and	a4,a4,a3
    800051f4:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    800051f8:	0307b703          	ld	a4,48(a5)
    800051fc:	fff70713          	addi	a4,a4,-1
    80005200:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    80005204:	0087b503          	ld	a0,8(a5)
    80005208:	ffffe097          	auipc	ra,0xffffe
    8000520c:	dec080e7          	jalr	-532(ra) # 80002ff4 <_ZN3SCB6signalEv>
}
    80005210:	00813083          	ld	ra,8(sp)
    80005214:	00013403          	ld	s0,0(sp)
    80005218:	01010113          	addi	sp,sp,16
    8000521c:	00008067          	ret
    80005220:	00008067          	ret

0000000080005224 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80005224:	fe010113          	addi	sp,sp,-32
    80005228:	00113c23          	sd	ra,24(sp)
    8000522c:	00813823          	sd	s0,16(sp)
    80005230:	00913423          	sd	s1,8(sp)
    80005234:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80005238:	00007497          	auipc	s1,0x7
    8000523c:	f8048493          	addi	s1,s1,-128 # 8000c1b8 <_ZN11ConsoleUtil8inputSemE>
    80005240:	0084b503          	ld	a0,8(s1)
    80005244:	ffffe097          	auipc	ra,0xffffe
    80005248:	d60080e7          	jalr	-672(ra) # 80002fa4 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000524c:	0404b783          	ld	a5,64(s1)
    80005250:	0384b703          	ld	a4,56(s1)
    80005254:	02e78c63          	beq	a5,a4,8000528c <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80005258:	0184b703          	ld	a4,24(s1)
    8000525c:	00f70733          	add	a4,a4,a5
    80005260:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80005264:	00178793          	addi	a5,a5,1
    80005268:	00002737          	lui	a4,0x2
    8000526c:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80005270:	00e7f7b3          	and	a5,a5,a4
    80005274:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80005278:	01813083          	ld	ra,24(sp)
    8000527c:	01013403          	ld	s0,16(sp)
    80005280:	00813483          	ld	s1,8(sp)
    80005284:	02010113          	addi	sp,sp,32
    80005288:	00008067          	ret
        return -1;
    8000528c:	0ff00513          	li	a0,255
    80005290:	fe9ff06f          	j	80005278 <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080005294 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80005294:	fe010113          	addi	sp,sp,-32
    80005298:	00113c23          	sd	ra,24(sp)
    8000529c:	00813823          	sd	s0,16(sp)
    800052a0:	00913423          	sd	s1,8(sp)
    800052a4:	02010413          	addi	s0,sp,32
    800052a8:	00050493          	mv	s1,a0
    while (*string != '\0')
    800052ac:	0004c503          	lbu	a0,0(s1)
    800052b0:	00050a63          	beqz	a0,800052c4 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    800052b4:	00000097          	auipc	ra,0x0
    800052b8:	ed8080e7          	jalr	-296(ra) # 8000518c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800052bc:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800052c0:	fedff06f          	j	800052ac <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800052c4:	01813083          	ld	ra,24(sp)
    800052c8:	01013403          	ld	s0,16(sp)
    800052cc:	00813483          	ld	s1,8(sp)
    800052d0:	02010113          	addi	sp,sp,32
    800052d4:	00008067          	ret

00000000800052d8 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800052d8:	fb010113          	addi	sp,sp,-80
    800052dc:	04113423          	sd	ra,72(sp)
    800052e0:	04813023          	sd	s0,64(sp)
    800052e4:	02913c23          	sd	s1,56(sp)
    800052e8:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    800052ec:	00004797          	auipc	a5,0x4
    800052f0:	2a478793          	addi	a5,a5,676 # 80009590 <CONSOLE_STATUS+0x580>
    800052f4:	0007b703          	ld	a4,0(a5)
    800052f8:	fce43423          	sd	a4,-56(s0)
    800052fc:	0087b703          	ld	a4,8(a5)
    80005300:	fce43823          	sd	a4,-48(s0)
    80005304:	0107c783          	lbu	a5,16(a5)
    80005308:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000530c:	00060463          	beqz	a2,80005314 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80005310:	08054263          	bltz	a0,80005394 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80005314:	0005051b          	sext.w	a0,a0
    neg = 0;
    80005318:	00000813          	li	a6,0
    }

    i = 0;
    8000531c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005320:	0005871b          	sext.w	a4,a1
    80005324:	02b577bb          	remuw	a5,a0,a1
    80005328:	00048693          	mv	a3,s1
    8000532c:	0014849b          	addiw	s1,s1,1
    80005330:	02079793          	slli	a5,a5,0x20
    80005334:	0207d793          	srli	a5,a5,0x20
    80005338:	fe040613          	addi	a2,s0,-32
    8000533c:	00f607b3          	add	a5,a2,a5
    80005340:	fe87c603          	lbu	a2,-24(a5)
    80005344:	fe040793          	addi	a5,s0,-32
    80005348:	00d787b3          	add	a5,a5,a3
    8000534c:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80005350:	0005061b          	sext.w	a2,a0
    80005354:	02b5553b          	divuw	a0,a0,a1
    80005358:	fce674e3          	bgeu	a2,a4,80005320 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    8000535c:	00080c63          	beqz	a6,80005374 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80005360:	fe040793          	addi	a5,s0,-32
    80005364:	009784b3          	add	s1,a5,s1
    80005368:	02d00793          	li	a5,45
    8000536c:	fcf48c23          	sb	a5,-40(s1)
    80005370:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80005374:	fff4849b          	addiw	s1,s1,-1
    80005378:	0204c463          	bltz	s1,800053a0 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    8000537c:	fe040793          	addi	a5,s0,-32
    80005380:	009787b3          	add	a5,a5,s1
    80005384:	fd87c503          	lbu	a0,-40(a5)
    80005388:	00000097          	auipc	ra,0x0
    8000538c:	e04080e7          	jalr	-508(ra) # 8000518c <_ZN11ConsoleUtil9putOutputEc>
    80005390:	fe5ff06f          	j	80005374 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80005394:	40a0053b          	negw	a0,a0
        neg = 1;
    80005398:	00100813          	li	a6,1
        x = -xx;
    8000539c:	f81ff06f          	j	8000531c <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    800053a0:	04813083          	ld	ra,72(sp)
    800053a4:	04013403          	ld	s0,64(sp)
    800053a8:	03813483          	ld	s1,56(sp)
    800053ac:	05010113          	addi	sp,sp,80
    800053b0:	00008067          	ret

00000000800053b4 <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    800053b4:	fe010113          	addi	sp,sp,-32
    800053b8:	00113c23          	sd	ra,24(sp)
    800053bc:	00813823          	sd	s0,16(sp)
    800053c0:	00913423          	sd	s1,8(sp)
    800053c4:	01213023          	sd	s2,0(sp)
    800053c8:	02010413          	addi	s0,sp,32
    800053cc:	00058913          	mv	s2,a1
    800053d0:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    800053d4:	00000097          	auipc	ra,0x0
    800053d8:	ec0080e7          	jalr	-320(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    800053dc:	00000613          	li	a2,0
    800053e0:	00a00593          	li	a1,10
    800053e4:	00090513          	mv	a0,s2
    800053e8:	00000097          	auipc	ra,0x0
    800053ec:	ef0080e7          	jalr	-272(ra) # 800052d8 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    800053f0:	00048513          	mv	a0,s1
    800053f4:	00000097          	auipc	ra,0x0
    800053f8:	ea0080e7          	jalr	-352(ra) # 80005294 <_ZN11ConsoleUtil11printStringEPKc>
}
    800053fc:	01813083          	ld	ra,24(sp)
    80005400:	01013403          	ld	s0,16(sp)
    80005404:	00813483          	ld	s1,8(sp)
    80005408:	00013903          	ld	s2,0(sp)
    8000540c:	02010113          	addi	sp,sp,32
    80005410:	00008067          	ret

0000000080005414 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80005414:	ff010113          	addi	sp,sp,-16
    80005418:	00813423          	sd	s0,8(sp)
    8000541c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80005420:	04300513          	li	a0,67

    asm("ecall");
    80005424:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80005428:	00050513          	mv	a0,a0

    return (char)status;
}
    8000542c:	0ff57513          	andi	a0,a0,255
    80005430:	00813403          	ld	s0,8(sp)
    80005434:	01010113          	addi	sp,sp,16
    80005438:	00008067          	ret

000000008000543c <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    8000543c:	ff010113          	addi	sp,sp,-16
    80005440:	00113423          	sd	ra,8(sp)
    80005444:	00813023          	sd	s0,0(sp)
    80005448:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    8000544c:	ffffc097          	auipc	ra,0xffffc
    80005450:	548080e7          	jalr	1352(ra) # 80001994 <_ZN13SlabAllocator10initializeEPvm>
}
    80005454:	00813083          	ld	ra,8(sp)
    80005458:	00013403          	ld	s0,0(sp)
    8000545c:	01010113          	addi	sp,sp,16
    80005460:	00008067          	ret

0000000080005464 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005464:	ff010113          	addi	sp,sp,-16
    80005468:	00113423          	sd	ra,8(sp)
    8000546c:	00813023          	sd	s0,0(sp)
    80005470:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005474:	ffffc097          	auipc	ra,0xffffc
    80005478:	47c080e7          	jalr	1148(ra) # 800018f0 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    8000547c:	00813083          	ld	ra,8(sp)
    80005480:	00013403          	ld	s0,0(sp)
    80005484:	01010113          	addi	sp,sp,16
    80005488:	00008067          	ret

000000008000548c <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    8000548c:	ff010113          	addi	sp,sp,-16
    80005490:	00113423          	sd	ra,8(sp)
    80005494:	00813023          	sd	s0,0(sp)
    80005498:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    8000549c:	ffffc097          	auipc	ra,0xffffc
    800054a0:	318080e7          	jalr	792(ra) # 800017b4 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800054a4:	00813083          	ld	ra,8(sp)
    800054a8:	00013403          	ld	s0,0(sp)
    800054ac:	01010113          	addi	sp,sp,16
    800054b0:	00008067          	ret

00000000800054b4 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    800054b4:	ff010113          	addi	sp,sp,-16
    800054b8:	00113423          	sd	ra,8(sp)
    800054bc:	00813023          	sd	s0,0(sp)
    800054c0:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800054c4:	ffffc097          	auipc	ra,0xffffc
    800054c8:	6a8080e7          	jalr	1704(ra) # 80001b6c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800054cc:	00813083          	ld	ra,8(sp)
    800054d0:	00013403          	ld	s0,0(sp)
    800054d4:	01010113          	addi	sp,sp,16
    800054d8:	00008067          	ret

00000000800054dc <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800054dc:	fe010113          	addi	sp,sp,-32
    800054e0:	00113c23          	sd	ra,24(sp)
    800054e4:	00813823          	sd	s0,16(sp)
    800054e8:	02010413          	addi	s0,sp,32
    800054ec:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800054f0:	fe840513          	addi	a0,s0,-24
    800054f4:	ffffc097          	auipc	ra,0xffffc
    800054f8:	7d8080e7          	jalr	2008(ra) # 80001ccc <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800054fc:	01813083          	ld	ra,24(sp)
    80005500:	01013403          	ld	s0,16(sp)
    80005504:	02010113          	addi	sp,sp,32
    80005508:	00008067          	ret

000000008000550c <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    8000550c:	ff010113          	addi	sp,sp,-16
    80005510:	00113423          	sd	ra,8(sp)
    80005514:	00813023          	sd	s0,0(sp)
    80005518:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    8000551c:	ffffc097          	auipc	ra,0xffffc
    80005520:	de4080e7          	jalr	-540(ra) # 80001300 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80005524:	00813083          	ld	ra,8(sp)
    80005528:	00013403          	ld	s0,0(sp)
    8000552c:	01010113          	addi	sp,sp,16
    80005530:	00008067          	ret

0000000080005534 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80005534:	ff010113          	addi	sp,sp,-16
    80005538:	00113423          	sd	ra,8(sp)
    8000553c:	00813023          	sd	s0,0(sp)
    80005540:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80005544:	ffffc097          	auipc	ra,0xffffc
    80005548:	c10080e7          	jalr	-1008(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    8000554c:	00813083          	ld	ra,8(sp)
    80005550:	00013403          	ld	s0,0(sp)
    80005554:	01010113          	addi	sp,sp,16
    80005558:	00008067          	ret

000000008000555c <_Z7kmallocm>:
void* kmalloc(size_t size){
    8000555c:	ff010113          	addi	sp,sp,-16
    80005560:	00113423          	sd	ra,8(sp)
    80005564:	00813023          	sd	s0,0(sp)
    80005568:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    8000556c:	ffffc097          	auipc	ra,0xffffc
    80005570:	2e4080e7          	jalr	740(ra) # 80001850 <_ZN13SlabAllocator14allocateBufferEm>
}
    80005574:	00813083          	ld	ra,8(sp)
    80005578:	00013403          	ld	s0,0(sp)
    8000557c:	01010113          	addi	sp,sp,16
    80005580:	00008067          	ret

0000000080005584 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005584:	ff010113          	addi	sp,sp,-16
    80005588:	00113423          	sd	ra,8(sp)
    8000558c:	00813023          	sd	s0,0(sp)
    80005590:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005594:	ffffc097          	auipc	ra,0xffffc
    80005598:	6cc080e7          	jalr	1740(ra) # 80001c60 <_ZN13SlabAllocator10freeBufferEPKv>
    8000559c:	00813083          	ld	ra,8(sp)
    800055a0:	00013403          	ld	s0,0(sp)
    800055a4:	01010113          	addi	sp,sp,16
    800055a8:	00008067          	ret

00000000800055ac <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800055ac:	fd010113          	addi	sp,sp,-48
    800055b0:	02113423          	sd	ra,40(sp)
    800055b4:	02813023          	sd	s0,32(sp)
    800055b8:	00913c23          	sd	s1,24(sp)
    800055bc:	01213823          	sd	s2,16(sp)
    800055c0:	01313423          	sd	s3,8(sp)
    800055c4:	03010413          	addi	s0,sp,48
    800055c8:	00050493          	mv	s1,a0
    800055cc:	00058993          	mv	s3,a1
    800055d0:	0015879b          	addiw	a5,a1,1
    800055d4:	0007851b          	sext.w	a0,a5
    800055d8:	00f4a023          	sw	a5,0(s1)
    800055dc:	0004a823          	sw	zero,16(s1)
    800055e0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800055e4:	00251513          	slli	a0,a0,0x2
    800055e8:	ffffc097          	auipc	ra,0xffffc
    800055ec:	7c0080e7          	jalr	1984(ra) # 80001da8 <_Z9mem_allocm>
    800055f0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800055f4:	01000513          	li	a0,16
    800055f8:	ffffe097          	auipc	ra,0xffffe
    800055fc:	39c080e7          	jalr	924(ra) # 80003994 <_Znwm>
    80005600:	00050913          	mv	s2,a0
    80005604:	00050863          	beqz	a0,80005614 <_ZN9BufferCPPC1Ei+0x68>
    80005608:	00000593          	li	a1,0
    8000560c:	ffffe097          	auipc	ra,0xffffe
    80005610:	480080e7          	jalr	1152(ra) # 80003a8c <_ZN9SemaphoreC1Ej>
    80005614:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80005618:	01000513          	li	a0,16
    8000561c:	ffffe097          	auipc	ra,0xffffe
    80005620:	378080e7          	jalr	888(ra) # 80003994 <_Znwm>
    80005624:	00050913          	mv	s2,a0
    80005628:	00050863          	beqz	a0,80005638 <_ZN9BufferCPPC1Ei+0x8c>
    8000562c:	00098593          	mv	a1,s3
    80005630:	ffffe097          	auipc	ra,0xffffe
    80005634:	45c080e7          	jalr	1116(ra) # 80003a8c <_ZN9SemaphoreC1Ej>
    80005638:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000563c:	01000513          	li	a0,16
    80005640:	ffffe097          	auipc	ra,0xffffe
    80005644:	354080e7          	jalr	852(ra) # 80003994 <_Znwm>
    80005648:	00050913          	mv	s2,a0
    8000564c:	00050863          	beqz	a0,8000565c <_ZN9BufferCPPC1Ei+0xb0>
    80005650:	00100593          	li	a1,1
    80005654:	ffffe097          	auipc	ra,0xffffe
    80005658:	438080e7          	jalr	1080(ra) # 80003a8c <_ZN9SemaphoreC1Ej>
    8000565c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005660:	01000513          	li	a0,16
    80005664:	ffffe097          	auipc	ra,0xffffe
    80005668:	330080e7          	jalr	816(ra) # 80003994 <_Znwm>
    8000566c:	00050913          	mv	s2,a0
    80005670:	00050863          	beqz	a0,80005680 <_ZN9BufferCPPC1Ei+0xd4>
    80005674:	00100593          	li	a1,1
    80005678:	ffffe097          	auipc	ra,0xffffe
    8000567c:	414080e7          	jalr	1044(ra) # 80003a8c <_ZN9SemaphoreC1Ej>
    80005680:	0324b823          	sd	s2,48(s1)
}
    80005684:	02813083          	ld	ra,40(sp)
    80005688:	02013403          	ld	s0,32(sp)
    8000568c:	01813483          	ld	s1,24(sp)
    80005690:	01013903          	ld	s2,16(sp)
    80005694:	00813983          	ld	s3,8(sp)
    80005698:	03010113          	addi	sp,sp,48
    8000569c:	00008067          	ret
    800056a0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800056a4:	00090513          	mv	a0,s2
    800056a8:	ffffe097          	auipc	ra,0xffffe
    800056ac:	33c080e7          	jalr	828(ra) # 800039e4 <_ZdlPv>
    800056b0:	00048513          	mv	a0,s1
    800056b4:	00008097          	auipc	ra,0x8
    800056b8:	c44080e7          	jalr	-956(ra) # 8000d2f8 <_Unwind_Resume>
    800056bc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800056c0:	00090513          	mv	a0,s2
    800056c4:	ffffe097          	auipc	ra,0xffffe
    800056c8:	320080e7          	jalr	800(ra) # 800039e4 <_ZdlPv>
    800056cc:	00048513          	mv	a0,s1
    800056d0:	00008097          	auipc	ra,0x8
    800056d4:	c28080e7          	jalr	-984(ra) # 8000d2f8 <_Unwind_Resume>
    800056d8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800056dc:	00090513          	mv	a0,s2
    800056e0:	ffffe097          	auipc	ra,0xffffe
    800056e4:	304080e7          	jalr	772(ra) # 800039e4 <_ZdlPv>
    800056e8:	00048513          	mv	a0,s1
    800056ec:	00008097          	auipc	ra,0x8
    800056f0:	c0c080e7          	jalr	-1012(ra) # 8000d2f8 <_Unwind_Resume>
    800056f4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800056f8:	00090513          	mv	a0,s2
    800056fc:	ffffe097          	auipc	ra,0xffffe
    80005700:	2e8080e7          	jalr	744(ra) # 800039e4 <_ZdlPv>
    80005704:	00048513          	mv	a0,s1
    80005708:	00008097          	auipc	ra,0x8
    8000570c:	bf0080e7          	jalr	-1040(ra) # 8000d2f8 <_Unwind_Resume>

0000000080005710 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005710:	fe010113          	addi	sp,sp,-32
    80005714:	00113c23          	sd	ra,24(sp)
    80005718:	00813823          	sd	s0,16(sp)
    8000571c:	00913423          	sd	s1,8(sp)
    80005720:	01213023          	sd	s2,0(sp)
    80005724:	02010413          	addi	s0,sp,32
    80005728:	00050493          	mv	s1,a0
    8000572c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005730:	01853503          	ld	a0,24(a0) # 2018 <_entry-0x7fffdfe8>
    80005734:	ffffe097          	auipc	ra,0xffffe
    80005738:	390080e7          	jalr	912(ra) # 80003ac4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000573c:	0304b503          	ld	a0,48(s1)
    80005740:	ffffe097          	auipc	ra,0xffffe
    80005744:	384080e7          	jalr	900(ra) # 80003ac4 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80005748:	0084b783          	ld	a5,8(s1)
    8000574c:	0144a703          	lw	a4,20(s1)
    80005750:	00271713          	slli	a4,a4,0x2
    80005754:	00e787b3          	add	a5,a5,a4
    80005758:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000575c:	0144a783          	lw	a5,20(s1)
    80005760:	0017879b          	addiw	a5,a5,1
    80005764:	0004a703          	lw	a4,0(s1)
    80005768:	02e7e7bb          	remw	a5,a5,a4
    8000576c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005770:	0304b503          	ld	a0,48(s1)
    80005774:	ffffe097          	auipc	ra,0xffffe
    80005778:	37c080e7          	jalr	892(ra) # 80003af0 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000577c:	0204b503          	ld	a0,32(s1)
    80005780:	ffffe097          	auipc	ra,0xffffe
    80005784:	370080e7          	jalr	880(ra) # 80003af0 <_ZN9Semaphore6signalEv>

}
    80005788:	01813083          	ld	ra,24(sp)
    8000578c:	01013403          	ld	s0,16(sp)
    80005790:	00813483          	ld	s1,8(sp)
    80005794:	00013903          	ld	s2,0(sp)
    80005798:	02010113          	addi	sp,sp,32
    8000579c:	00008067          	ret

00000000800057a0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800057a0:	fe010113          	addi	sp,sp,-32
    800057a4:	00113c23          	sd	ra,24(sp)
    800057a8:	00813823          	sd	s0,16(sp)
    800057ac:	00913423          	sd	s1,8(sp)
    800057b0:	01213023          	sd	s2,0(sp)
    800057b4:	02010413          	addi	s0,sp,32
    800057b8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800057bc:	02053503          	ld	a0,32(a0)
    800057c0:	ffffe097          	auipc	ra,0xffffe
    800057c4:	304080e7          	jalr	772(ra) # 80003ac4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800057c8:	0284b503          	ld	a0,40(s1)
    800057cc:	ffffe097          	auipc	ra,0xffffe
    800057d0:	2f8080e7          	jalr	760(ra) # 80003ac4 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800057d4:	0084b703          	ld	a4,8(s1)
    800057d8:	0104a783          	lw	a5,16(s1)
    800057dc:	00279693          	slli	a3,a5,0x2
    800057e0:	00d70733          	add	a4,a4,a3
    800057e4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800057e8:	0017879b          	addiw	a5,a5,1
    800057ec:	0004a703          	lw	a4,0(s1)
    800057f0:	02e7e7bb          	remw	a5,a5,a4
    800057f4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800057f8:	0284b503          	ld	a0,40(s1)
    800057fc:	ffffe097          	auipc	ra,0xffffe
    80005800:	2f4080e7          	jalr	756(ra) # 80003af0 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80005804:	0184b503          	ld	a0,24(s1)
    80005808:	ffffe097          	auipc	ra,0xffffe
    8000580c:	2e8080e7          	jalr	744(ra) # 80003af0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005810:	00090513          	mv	a0,s2
    80005814:	01813083          	ld	ra,24(sp)
    80005818:	01013403          	ld	s0,16(sp)
    8000581c:	00813483          	ld	s1,8(sp)
    80005820:	00013903          	ld	s2,0(sp)
    80005824:	02010113          	addi	sp,sp,32
    80005828:	00008067          	ret

000000008000582c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000582c:	fe010113          	addi	sp,sp,-32
    80005830:	00113c23          	sd	ra,24(sp)
    80005834:	00813823          	sd	s0,16(sp)
    80005838:	00913423          	sd	s1,8(sp)
    8000583c:	01213023          	sd	s2,0(sp)
    80005840:	02010413          	addi	s0,sp,32
    80005844:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005848:	02853503          	ld	a0,40(a0)
    8000584c:	ffffe097          	auipc	ra,0xffffe
    80005850:	278080e7          	jalr	632(ra) # 80003ac4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005854:	0304b503          	ld	a0,48(s1)
    80005858:	ffffe097          	auipc	ra,0xffffe
    8000585c:	26c080e7          	jalr	620(ra) # 80003ac4 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005860:	0144a783          	lw	a5,20(s1)
    80005864:	0104a903          	lw	s2,16(s1)
    80005868:	0327ce63          	blt	a5,s2,800058a4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000586c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005870:	0304b503          	ld	a0,48(s1)
    80005874:	ffffe097          	auipc	ra,0xffffe
    80005878:	27c080e7          	jalr	636(ra) # 80003af0 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000587c:	0284b503          	ld	a0,40(s1)
    80005880:	ffffe097          	auipc	ra,0xffffe
    80005884:	270080e7          	jalr	624(ra) # 80003af0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005888:	00090513          	mv	a0,s2
    8000588c:	01813083          	ld	ra,24(sp)
    80005890:	01013403          	ld	s0,16(sp)
    80005894:	00813483          	ld	s1,8(sp)
    80005898:	00013903          	ld	s2,0(sp)
    8000589c:	02010113          	addi	sp,sp,32
    800058a0:	00008067          	ret
        ret = cap - head + tail;
    800058a4:	0004a703          	lw	a4,0(s1)
    800058a8:	4127093b          	subw	s2,a4,s2
    800058ac:	00f9093b          	addw	s2,s2,a5
    800058b0:	fc1ff06f          	j	80005870 <_ZN9BufferCPP6getCntEv+0x44>

00000000800058b4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800058b4:	fe010113          	addi	sp,sp,-32
    800058b8:	00113c23          	sd	ra,24(sp)
    800058bc:	00813823          	sd	s0,16(sp)
    800058c0:	00913423          	sd	s1,8(sp)
    800058c4:	02010413          	addi	s0,sp,32
    800058c8:	00050493          	mv	s1,a0
    Console::putc('\n');
    800058cc:	00a00513          	li	a0,10
    800058d0:	ffffe097          	auipc	ra,0xffffe
    800058d4:	458080e7          	jalr	1112(ra) # 80003d28 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800058d8:	00004517          	auipc	a0,0x4
    800058dc:	cd050513          	addi	a0,a0,-816 # 800095a8 <CONSOLE_STATUS+0x598>
    800058e0:	ffffd097          	auipc	ra,0xffffd
    800058e4:	264080e7          	jalr	612(ra) # 80002b44 <_Z11printStringPKc>
    while (getCnt()) {
    800058e8:	00048513          	mv	a0,s1
    800058ec:	00000097          	auipc	ra,0x0
    800058f0:	f40080e7          	jalr	-192(ra) # 8000582c <_ZN9BufferCPP6getCntEv>
    800058f4:	02050c63          	beqz	a0,8000592c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800058f8:	0084b783          	ld	a5,8(s1)
    800058fc:	0104a703          	lw	a4,16(s1)
    80005900:	00271713          	slli	a4,a4,0x2
    80005904:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005908:	0007c503          	lbu	a0,0(a5)
    8000590c:	ffffe097          	auipc	ra,0xffffe
    80005910:	41c080e7          	jalr	1052(ra) # 80003d28 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80005914:	0104a783          	lw	a5,16(s1)
    80005918:	0017879b          	addiw	a5,a5,1
    8000591c:	0004a703          	lw	a4,0(s1)
    80005920:	02e7e7bb          	remw	a5,a5,a4
    80005924:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005928:	fc1ff06f          	j	800058e8 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000592c:	02100513          	li	a0,33
    80005930:	ffffe097          	auipc	ra,0xffffe
    80005934:	3f8080e7          	jalr	1016(ra) # 80003d28 <_ZN7Console4putcEc>
    Console::putc('\n');
    80005938:	00a00513          	li	a0,10
    8000593c:	ffffe097          	auipc	ra,0xffffe
    80005940:	3ec080e7          	jalr	1004(ra) # 80003d28 <_ZN7Console4putcEc>
    mem_free(buffer);
    80005944:	0084b503          	ld	a0,8(s1)
    80005948:	ffffc097          	auipc	ra,0xffffc
    8000594c:	490080e7          	jalr	1168(ra) # 80001dd8 <_Z8mem_freePv>
    delete itemAvailable;
    80005950:	0204b503          	ld	a0,32(s1)
    80005954:	00050863          	beqz	a0,80005964 <_ZN9BufferCPPD1Ev+0xb0>
    80005958:	00053783          	ld	a5,0(a0)
    8000595c:	0087b783          	ld	a5,8(a5)
    80005960:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005964:	0184b503          	ld	a0,24(s1)
    80005968:	00050863          	beqz	a0,80005978 <_ZN9BufferCPPD1Ev+0xc4>
    8000596c:	00053783          	ld	a5,0(a0)
    80005970:	0087b783          	ld	a5,8(a5)
    80005974:	000780e7          	jalr	a5
    delete mutexTail;
    80005978:	0304b503          	ld	a0,48(s1)
    8000597c:	00050863          	beqz	a0,8000598c <_ZN9BufferCPPD1Ev+0xd8>
    80005980:	00053783          	ld	a5,0(a0)
    80005984:	0087b783          	ld	a5,8(a5)
    80005988:	000780e7          	jalr	a5
    delete mutexHead;
    8000598c:	0284b503          	ld	a0,40(s1)
    80005990:	00050863          	beqz	a0,800059a0 <_ZN9BufferCPPD1Ev+0xec>
    80005994:	00053783          	ld	a5,0(a0)
    80005998:	0087b783          	ld	a5,8(a5)
    8000599c:	000780e7          	jalr	a5
}
    800059a0:	01813083          	ld	ra,24(sp)
    800059a4:	01013403          	ld	s0,16(sp)
    800059a8:	00813483          	ld	s1,8(sp)
    800059ac:	02010113          	addi	sp,sp,32
    800059b0:	00008067          	ret

00000000800059b4 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    800059b4:	fe010113          	addi	sp,sp,-32
    800059b8:	00113c23          	sd	ra,24(sp)
    800059bc:	00813823          	sd	s0,16(sp)
    800059c0:	00913423          	sd	s1,8(sp)
    800059c4:	01213023          	sd	s2,0(sp)
    800059c8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800059cc:	00000913          	li	s2,0
    800059d0:	0380006f          	j	80005a08 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800059d4:	ffffc097          	auipc	ra,0xffffc
    800059d8:	4e4080e7          	jalr	1252(ra) # 80001eb8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800059dc:	00148493          	addi	s1,s1,1
    800059e0:	000027b7          	lui	a5,0x2
    800059e4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800059e8:	0097ee63          	bltu	a5,s1,80005a04 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800059ec:	00000713          	li	a4,0
    800059f0:	000077b7          	lui	a5,0x7
    800059f4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800059f8:	fce7eee3          	bltu	a5,a4,800059d4 <_Z11workerBodyAPv+0x20>
    800059fc:	00170713          	addi	a4,a4,1
    80005a00:	ff1ff06f          	j	800059f0 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005a04:	00190913          	addi	s2,s2,1
    80005a08:	00900793          	li	a5,9
    80005a0c:	0527e063          	bltu	a5,s2,80005a4c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005a10:	00004517          	auipc	a0,0x4
    80005a14:	bb050513          	addi	a0,a0,-1104 # 800095c0 <CONSOLE_STATUS+0x5b0>
    80005a18:	ffffd097          	auipc	ra,0xffffd
    80005a1c:	12c080e7          	jalr	300(ra) # 80002b44 <_Z11printStringPKc>
    80005a20:	00000613          	li	a2,0
    80005a24:	00a00593          	li	a1,10
    80005a28:	0009051b          	sext.w	a0,s2
    80005a2c:	ffffd097          	auipc	ra,0xffffd
    80005a30:	2b0080e7          	jalr	688(ra) # 80002cdc <_Z8printIntiii>
    80005a34:	00004517          	auipc	a0,0x4
    80005a38:	96450513          	addi	a0,a0,-1692 # 80009398 <CONSOLE_STATUS+0x388>
    80005a3c:	ffffd097          	auipc	ra,0xffffd
    80005a40:	108080e7          	jalr	264(ra) # 80002b44 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005a44:	00000493          	li	s1,0
    80005a48:	f99ff06f          	j	800059e0 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    80005a4c:	00004517          	auipc	a0,0x4
    80005a50:	b7c50513          	addi	a0,a0,-1156 # 800095c8 <CONSOLE_STATUS+0x5b8>
    80005a54:	ffffd097          	auipc	ra,0xffffd
    80005a58:	0f0080e7          	jalr	240(ra) # 80002b44 <_Z11printStringPKc>
    finishedA = true;
    80005a5c:	00100793          	li	a5,1
    80005a60:	00006717          	auipc	a4,0x6
    80005a64:	7af70423          	sb	a5,1960(a4) # 8000c208 <finishedA>
}
    80005a68:	01813083          	ld	ra,24(sp)
    80005a6c:	01013403          	ld	s0,16(sp)
    80005a70:	00813483          	ld	s1,8(sp)
    80005a74:	00013903          	ld	s2,0(sp)
    80005a78:	02010113          	addi	sp,sp,32
    80005a7c:	00008067          	ret

0000000080005a80 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80005a80:	fe010113          	addi	sp,sp,-32
    80005a84:	00113c23          	sd	ra,24(sp)
    80005a88:	00813823          	sd	s0,16(sp)
    80005a8c:	00913423          	sd	s1,8(sp)
    80005a90:	01213023          	sd	s2,0(sp)
    80005a94:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005a98:	00000913          	li	s2,0
    80005a9c:	0380006f          	j	80005ad4 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005aa0:	ffffc097          	auipc	ra,0xffffc
    80005aa4:	418080e7          	jalr	1048(ra) # 80001eb8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005aa8:	00148493          	addi	s1,s1,1
    80005aac:	000027b7          	lui	a5,0x2
    80005ab0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005ab4:	0097ee63          	bltu	a5,s1,80005ad0 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005ab8:	00000713          	li	a4,0
    80005abc:	000077b7          	lui	a5,0x7
    80005ac0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005ac4:	fce7eee3          	bltu	a5,a4,80005aa0 <_Z11workerBodyBPv+0x20>
    80005ac8:	00170713          	addi	a4,a4,1
    80005acc:	ff1ff06f          	j	80005abc <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005ad0:	00190913          	addi	s2,s2,1
    80005ad4:	00f00793          	li	a5,15
    80005ad8:	0527e063          	bltu	a5,s2,80005b18 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005adc:	00004517          	auipc	a0,0x4
    80005ae0:	afc50513          	addi	a0,a0,-1284 # 800095d8 <CONSOLE_STATUS+0x5c8>
    80005ae4:	ffffd097          	auipc	ra,0xffffd
    80005ae8:	060080e7          	jalr	96(ra) # 80002b44 <_Z11printStringPKc>
    80005aec:	00000613          	li	a2,0
    80005af0:	00a00593          	li	a1,10
    80005af4:	0009051b          	sext.w	a0,s2
    80005af8:	ffffd097          	auipc	ra,0xffffd
    80005afc:	1e4080e7          	jalr	484(ra) # 80002cdc <_Z8printIntiii>
    80005b00:	00004517          	auipc	a0,0x4
    80005b04:	89850513          	addi	a0,a0,-1896 # 80009398 <CONSOLE_STATUS+0x388>
    80005b08:	ffffd097          	auipc	ra,0xffffd
    80005b0c:	03c080e7          	jalr	60(ra) # 80002b44 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005b10:	00000493          	li	s1,0
    80005b14:	f99ff06f          	j	80005aac <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    80005b18:	00004517          	auipc	a0,0x4
    80005b1c:	ac850513          	addi	a0,a0,-1336 # 800095e0 <CONSOLE_STATUS+0x5d0>
    80005b20:	ffffd097          	auipc	ra,0xffffd
    80005b24:	024080e7          	jalr	36(ra) # 80002b44 <_Z11printStringPKc>
    finishedB = true;
    80005b28:	00100793          	li	a5,1
    80005b2c:	00006717          	auipc	a4,0x6
    80005b30:	6cf70ea3          	sb	a5,1757(a4) # 8000c209 <finishedB>
    thread_dispatch();
    80005b34:	ffffc097          	auipc	ra,0xffffc
    80005b38:	384080e7          	jalr	900(ra) # 80001eb8 <_Z15thread_dispatchv>
}
    80005b3c:	01813083          	ld	ra,24(sp)
    80005b40:	01013403          	ld	s0,16(sp)
    80005b44:	00813483          	ld	s1,8(sp)
    80005b48:	00013903          	ld	s2,0(sp)
    80005b4c:	02010113          	addi	sp,sp,32
    80005b50:	00008067          	ret

0000000080005b54 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80005b54:	fe010113          	addi	sp,sp,-32
    80005b58:	00113c23          	sd	ra,24(sp)
    80005b5c:	00813823          	sd	s0,16(sp)
    80005b60:	00913423          	sd	s1,8(sp)
    80005b64:	01213023          	sd	s2,0(sp)
    80005b68:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80005b6c:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005b70:	00600493          	li	s1,6
    while (--i > 0) {
    80005b74:	fff4849b          	addiw	s1,s1,-1
    80005b78:	04905463          	blez	s1,80005bc0 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80005b7c:	00004517          	auipc	a0,0x4
    80005b80:	a7450513          	addi	a0,a0,-1420 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80005b84:	ffffd097          	auipc	ra,0xffffd
    80005b88:	fc0080e7          	jalr	-64(ra) # 80002b44 <_Z11printStringPKc>
        printInt(sleep_time);
    80005b8c:	00000613          	li	a2,0
    80005b90:	00a00593          	li	a1,10
    80005b94:	0009051b          	sext.w	a0,s2
    80005b98:	ffffd097          	auipc	ra,0xffffd
    80005b9c:	144080e7          	jalr	324(ra) # 80002cdc <_Z8printIntiii>
        printString(" !\n");
    80005ba0:	00004517          	auipc	a0,0x4
    80005ba4:	a5850513          	addi	a0,a0,-1448 # 800095f8 <CONSOLE_STATUS+0x5e8>
    80005ba8:	ffffd097          	auipc	ra,0xffffd
    80005bac:	f9c080e7          	jalr	-100(ra) # 80002b44 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80005bb0:	00090513          	mv	a0,s2
    80005bb4:	ffffc097          	auipc	ra,0xffffc
    80005bb8:	4ac080e7          	jalr	1196(ra) # 80002060 <_Z10time_sleepm>
    while (--i > 0) {
    80005bbc:	fb9ff06f          	j	80005b74 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005bc0:	00a00793          	li	a5,10
    80005bc4:	02f95933          	divu	s2,s2,a5
    80005bc8:	fff90913          	addi	s2,s2,-1
    80005bcc:	00006797          	auipc	a5,0x6
    80005bd0:	63c78793          	addi	a5,a5,1596 # 8000c208 <finishedA>
    80005bd4:	01278933          	add	s2,a5,s2
    80005bd8:	00100793          	li	a5,1
    80005bdc:	00f90423          	sb	a5,8(s2)
}
    80005be0:	01813083          	ld	ra,24(sp)
    80005be4:	01013403          	ld	s0,16(sp)
    80005be8:	00813483          	ld	s1,8(sp)
    80005bec:	00013903          	ld	s2,0(sp)
    80005bf0:	02010113          	addi	sp,sp,32
    80005bf4:	00008067          	ret

0000000080005bf8 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80005bf8:	fe010113          	addi	sp,sp,-32
    80005bfc:	00113c23          	sd	ra,24(sp)
    80005c00:	00813823          	sd	s0,16(sp)
    80005c04:	00913423          	sd	s1,8(sp)
    80005c08:	01213023          	sd	s2,0(sp)
    80005c0c:	02010413          	addi	s0,sp,32
    80005c10:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005c14:	00100793          	li	a5,1
    80005c18:	02a7f863          	bgeu	a5,a0,80005c48 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005c1c:	00a00793          	li	a5,10
    80005c20:	02f577b3          	remu	a5,a0,a5
    80005c24:	02078e63          	beqz	a5,80005c60 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005c28:	fff48513          	addi	a0,s1,-1
    80005c2c:	00000097          	auipc	ra,0x0
    80005c30:	fcc080e7          	jalr	-52(ra) # 80005bf8 <_Z9fibonaccim>
    80005c34:	00050913          	mv	s2,a0
    80005c38:	ffe48513          	addi	a0,s1,-2
    80005c3c:	00000097          	auipc	ra,0x0
    80005c40:	fbc080e7          	jalr	-68(ra) # 80005bf8 <_Z9fibonaccim>
    80005c44:	00a90533          	add	a0,s2,a0
}
    80005c48:	01813083          	ld	ra,24(sp)
    80005c4c:	01013403          	ld	s0,16(sp)
    80005c50:	00813483          	ld	s1,8(sp)
    80005c54:	00013903          	ld	s2,0(sp)
    80005c58:	02010113          	addi	sp,sp,32
    80005c5c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005c60:	ffffc097          	auipc	ra,0xffffc
    80005c64:	258080e7          	jalr	600(ra) # 80001eb8 <_Z15thread_dispatchv>
    80005c68:	fc1ff06f          	j	80005c28 <_Z9fibonaccim+0x30>

0000000080005c6c <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80005c6c:	fe010113          	addi	sp,sp,-32
    80005c70:	00113c23          	sd	ra,24(sp)
    80005c74:	00813823          	sd	s0,16(sp)
    80005c78:	00913423          	sd	s1,8(sp)
    80005c7c:	01213023          	sd	s2,0(sp)
    80005c80:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005c84:	00000493          	li	s1,0
    80005c88:	0400006f          	j	80005cc8 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005c8c:	00004517          	auipc	a0,0x4
    80005c90:	97450513          	addi	a0,a0,-1676 # 80009600 <CONSOLE_STATUS+0x5f0>
    80005c94:	ffffd097          	auipc	ra,0xffffd
    80005c98:	eb0080e7          	jalr	-336(ra) # 80002b44 <_Z11printStringPKc>
    80005c9c:	00000613          	li	a2,0
    80005ca0:	00a00593          	li	a1,10
    80005ca4:	00048513          	mv	a0,s1
    80005ca8:	ffffd097          	auipc	ra,0xffffd
    80005cac:	034080e7          	jalr	52(ra) # 80002cdc <_Z8printIntiii>
    80005cb0:	00003517          	auipc	a0,0x3
    80005cb4:	6e850513          	addi	a0,a0,1768 # 80009398 <CONSOLE_STATUS+0x388>
    80005cb8:	ffffd097          	auipc	ra,0xffffd
    80005cbc:	e8c080e7          	jalr	-372(ra) # 80002b44 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005cc0:	0014849b          	addiw	s1,s1,1
    80005cc4:	0ff4f493          	andi	s1,s1,255
    80005cc8:	00200793          	li	a5,2
    80005ccc:	fc97f0e3          	bgeu	a5,s1,80005c8c <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80005cd0:	00004517          	auipc	a0,0x4
    80005cd4:	93850513          	addi	a0,a0,-1736 # 80009608 <CONSOLE_STATUS+0x5f8>
    80005cd8:	ffffd097          	auipc	ra,0xffffd
    80005cdc:	e6c080e7          	jalr	-404(ra) # 80002b44 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005ce0:	00700313          	li	t1,7
    thread_dispatch();
    80005ce4:	ffffc097          	auipc	ra,0xffffc
    80005ce8:	1d4080e7          	jalr	468(ra) # 80001eb8 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005cec:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80005cf0:	00004517          	auipc	a0,0x4
    80005cf4:	92850513          	addi	a0,a0,-1752 # 80009618 <CONSOLE_STATUS+0x608>
    80005cf8:	ffffd097          	auipc	ra,0xffffd
    80005cfc:	e4c080e7          	jalr	-436(ra) # 80002b44 <_Z11printStringPKc>
    80005d00:	00000613          	li	a2,0
    80005d04:	00a00593          	li	a1,10
    80005d08:	0009051b          	sext.w	a0,s2
    80005d0c:	ffffd097          	auipc	ra,0xffffd
    80005d10:	fd0080e7          	jalr	-48(ra) # 80002cdc <_Z8printIntiii>
    80005d14:	00003517          	auipc	a0,0x3
    80005d18:	68450513          	addi	a0,a0,1668 # 80009398 <CONSOLE_STATUS+0x388>
    80005d1c:	ffffd097          	auipc	ra,0xffffd
    80005d20:	e28080e7          	jalr	-472(ra) # 80002b44 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80005d24:	00c00513          	li	a0,12
    80005d28:	00000097          	auipc	ra,0x0
    80005d2c:	ed0080e7          	jalr	-304(ra) # 80005bf8 <_Z9fibonaccim>
    80005d30:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005d34:	00004517          	auipc	a0,0x4
    80005d38:	8ec50513          	addi	a0,a0,-1812 # 80009620 <CONSOLE_STATUS+0x610>
    80005d3c:	ffffd097          	auipc	ra,0xffffd
    80005d40:	e08080e7          	jalr	-504(ra) # 80002b44 <_Z11printStringPKc>
    80005d44:	00000613          	li	a2,0
    80005d48:	00a00593          	li	a1,10
    80005d4c:	0009051b          	sext.w	a0,s2
    80005d50:	ffffd097          	auipc	ra,0xffffd
    80005d54:	f8c080e7          	jalr	-116(ra) # 80002cdc <_Z8printIntiii>
    80005d58:	00003517          	auipc	a0,0x3
    80005d5c:	64050513          	addi	a0,a0,1600 # 80009398 <CONSOLE_STATUS+0x388>
    80005d60:	ffffd097          	auipc	ra,0xffffd
    80005d64:	de4080e7          	jalr	-540(ra) # 80002b44 <_Z11printStringPKc>
    80005d68:	0400006f          	j	80005da8 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005d6c:	00004517          	auipc	a0,0x4
    80005d70:	89450513          	addi	a0,a0,-1900 # 80009600 <CONSOLE_STATUS+0x5f0>
    80005d74:	ffffd097          	auipc	ra,0xffffd
    80005d78:	dd0080e7          	jalr	-560(ra) # 80002b44 <_Z11printStringPKc>
    80005d7c:	00000613          	li	a2,0
    80005d80:	00a00593          	li	a1,10
    80005d84:	00048513          	mv	a0,s1
    80005d88:	ffffd097          	auipc	ra,0xffffd
    80005d8c:	f54080e7          	jalr	-172(ra) # 80002cdc <_Z8printIntiii>
    80005d90:	00003517          	auipc	a0,0x3
    80005d94:	60850513          	addi	a0,a0,1544 # 80009398 <CONSOLE_STATUS+0x388>
    80005d98:	ffffd097          	auipc	ra,0xffffd
    80005d9c:	dac080e7          	jalr	-596(ra) # 80002b44 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005da0:	0014849b          	addiw	s1,s1,1
    80005da4:	0ff4f493          	andi	s1,s1,255
    80005da8:	00500793          	li	a5,5
    80005dac:	fc97f0e3          	bgeu	a5,s1,80005d6c <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80005db0:	00004517          	auipc	a0,0x4
    80005db4:	81850513          	addi	a0,a0,-2024 # 800095c8 <CONSOLE_STATUS+0x5b8>
    80005db8:	ffffd097          	auipc	ra,0xffffd
    80005dbc:	d8c080e7          	jalr	-628(ra) # 80002b44 <_Z11printStringPKc>
    finishedC = true;
    80005dc0:	00100793          	li	a5,1
    80005dc4:	00006717          	auipc	a4,0x6
    80005dc8:	44f70a23          	sb	a5,1108(a4) # 8000c218 <finishedC>
    thread_dispatch();
    80005dcc:	ffffc097          	auipc	ra,0xffffc
    80005dd0:	0ec080e7          	jalr	236(ra) # 80001eb8 <_Z15thread_dispatchv>
}
    80005dd4:	01813083          	ld	ra,24(sp)
    80005dd8:	01013403          	ld	s0,16(sp)
    80005ddc:	00813483          	ld	s1,8(sp)
    80005de0:	00013903          	ld	s2,0(sp)
    80005de4:	02010113          	addi	sp,sp,32
    80005de8:	00008067          	ret

0000000080005dec <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80005dec:	fe010113          	addi	sp,sp,-32
    80005df0:	00113c23          	sd	ra,24(sp)
    80005df4:	00813823          	sd	s0,16(sp)
    80005df8:	00913423          	sd	s1,8(sp)
    80005dfc:	01213023          	sd	s2,0(sp)
    80005e00:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005e04:	00a00493          	li	s1,10
    80005e08:	0400006f          	j	80005e48 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005e0c:	00004517          	auipc	a0,0x4
    80005e10:	82450513          	addi	a0,a0,-2012 # 80009630 <CONSOLE_STATUS+0x620>
    80005e14:	ffffd097          	auipc	ra,0xffffd
    80005e18:	d30080e7          	jalr	-720(ra) # 80002b44 <_Z11printStringPKc>
    80005e1c:	00000613          	li	a2,0
    80005e20:	00a00593          	li	a1,10
    80005e24:	00048513          	mv	a0,s1
    80005e28:	ffffd097          	auipc	ra,0xffffd
    80005e2c:	eb4080e7          	jalr	-332(ra) # 80002cdc <_Z8printIntiii>
    80005e30:	00003517          	auipc	a0,0x3
    80005e34:	56850513          	addi	a0,a0,1384 # 80009398 <CONSOLE_STATUS+0x388>
    80005e38:	ffffd097          	auipc	ra,0xffffd
    80005e3c:	d0c080e7          	jalr	-756(ra) # 80002b44 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005e40:	0014849b          	addiw	s1,s1,1
    80005e44:	0ff4f493          	andi	s1,s1,255
    80005e48:	00c00793          	li	a5,12
    80005e4c:	fc97f0e3          	bgeu	a5,s1,80005e0c <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005e50:	00003517          	auipc	a0,0x3
    80005e54:	7e850513          	addi	a0,a0,2024 # 80009638 <CONSOLE_STATUS+0x628>
    80005e58:	ffffd097          	auipc	ra,0xffffd
    80005e5c:	cec080e7          	jalr	-788(ra) # 80002b44 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005e60:	00500313          	li	t1,5
    thread_dispatch();
    80005e64:	ffffc097          	auipc	ra,0xffffc
    80005e68:	054080e7          	jalr	84(ra) # 80001eb8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005e6c:	01000513          	li	a0,16
    80005e70:	00000097          	auipc	ra,0x0
    80005e74:	d88080e7          	jalr	-632(ra) # 80005bf8 <_Z9fibonaccim>
    80005e78:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005e7c:	00003517          	auipc	a0,0x3
    80005e80:	7cc50513          	addi	a0,a0,1996 # 80009648 <CONSOLE_STATUS+0x638>
    80005e84:	ffffd097          	auipc	ra,0xffffd
    80005e88:	cc0080e7          	jalr	-832(ra) # 80002b44 <_Z11printStringPKc>
    80005e8c:	00000613          	li	a2,0
    80005e90:	00a00593          	li	a1,10
    80005e94:	0009051b          	sext.w	a0,s2
    80005e98:	ffffd097          	auipc	ra,0xffffd
    80005e9c:	e44080e7          	jalr	-444(ra) # 80002cdc <_Z8printIntiii>
    80005ea0:	00003517          	auipc	a0,0x3
    80005ea4:	4f850513          	addi	a0,a0,1272 # 80009398 <CONSOLE_STATUS+0x388>
    80005ea8:	ffffd097          	auipc	ra,0xffffd
    80005eac:	c9c080e7          	jalr	-868(ra) # 80002b44 <_Z11printStringPKc>
    80005eb0:	0400006f          	j	80005ef0 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005eb4:	00003517          	auipc	a0,0x3
    80005eb8:	77c50513          	addi	a0,a0,1916 # 80009630 <CONSOLE_STATUS+0x620>
    80005ebc:	ffffd097          	auipc	ra,0xffffd
    80005ec0:	c88080e7          	jalr	-888(ra) # 80002b44 <_Z11printStringPKc>
    80005ec4:	00000613          	li	a2,0
    80005ec8:	00a00593          	li	a1,10
    80005ecc:	00048513          	mv	a0,s1
    80005ed0:	ffffd097          	auipc	ra,0xffffd
    80005ed4:	e0c080e7          	jalr	-500(ra) # 80002cdc <_Z8printIntiii>
    80005ed8:	00003517          	auipc	a0,0x3
    80005edc:	4c050513          	addi	a0,a0,1216 # 80009398 <CONSOLE_STATUS+0x388>
    80005ee0:	ffffd097          	auipc	ra,0xffffd
    80005ee4:	c64080e7          	jalr	-924(ra) # 80002b44 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005ee8:	0014849b          	addiw	s1,s1,1
    80005eec:	0ff4f493          	andi	s1,s1,255
    80005ef0:	00f00793          	li	a5,15
    80005ef4:	fc97f0e3          	bgeu	a5,s1,80005eb4 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005ef8:	00003517          	auipc	a0,0x3
    80005efc:	76050513          	addi	a0,a0,1888 # 80009658 <CONSOLE_STATUS+0x648>
    80005f00:	ffffd097          	auipc	ra,0xffffd
    80005f04:	c44080e7          	jalr	-956(ra) # 80002b44 <_Z11printStringPKc>
    finishedD = true;
    80005f08:	00100793          	li	a5,1
    80005f0c:	00006717          	auipc	a4,0x6
    80005f10:	30f706a3          	sb	a5,781(a4) # 8000c219 <finishedD>
    thread_dispatch();
    80005f14:	ffffc097          	auipc	ra,0xffffc
    80005f18:	fa4080e7          	jalr	-92(ra) # 80001eb8 <_Z15thread_dispatchv>
}
    80005f1c:	01813083          	ld	ra,24(sp)
    80005f20:	01013403          	ld	s0,16(sp)
    80005f24:	00813483          	ld	s1,8(sp)
    80005f28:	00013903          	ld	s2,0(sp)
    80005f2c:	02010113          	addi	sp,sp,32
    80005f30:	00008067          	ret

0000000080005f34 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005f34:	fc010113          	addi	sp,sp,-64
    80005f38:	02113c23          	sd	ra,56(sp)
    80005f3c:	02813823          	sd	s0,48(sp)
    80005f40:	02913423          	sd	s1,40(sp)
    80005f44:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005f48:	00000613          	li	a2,0
    80005f4c:	00000597          	auipc	a1,0x0
    80005f50:	a6858593          	addi	a1,a1,-1432 # 800059b4 <_Z11workerBodyAPv>
    80005f54:	fc040513          	addi	a0,s0,-64
    80005f58:	ffffc097          	auipc	ra,0xffffc
    80005f5c:	eac080e7          	jalr	-340(ra) # 80001e04 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80005f60:	00003517          	auipc	a0,0x3
    80005f64:	70850513          	addi	a0,a0,1800 # 80009668 <CONSOLE_STATUS+0x658>
    80005f68:	ffffd097          	auipc	ra,0xffffd
    80005f6c:	bdc080e7          	jalr	-1060(ra) # 80002b44 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005f70:	00000613          	li	a2,0
    80005f74:	00000597          	auipc	a1,0x0
    80005f78:	b0c58593          	addi	a1,a1,-1268 # 80005a80 <_Z11workerBodyBPv>
    80005f7c:	fc840513          	addi	a0,s0,-56
    80005f80:	ffffc097          	auipc	ra,0xffffc
    80005f84:	e84080e7          	jalr	-380(ra) # 80001e04 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005f88:	00003517          	auipc	a0,0x3
    80005f8c:	6f850513          	addi	a0,a0,1784 # 80009680 <CONSOLE_STATUS+0x670>
    80005f90:	ffffd097          	auipc	ra,0xffffd
    80005f94:	bb4080e7          	jalr	-1100(ra) # 80002b44 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005f98:	00000613          	li	a2,0
    80005f9c:	00000597          	auipc	a1,0x0
    80005fa0:	cd058593          	addi	a1,a1,-816 # 80005c6c <_Z11workerBodyCPv>
    80005fa4:	fd040513          	addi	a0,s0,-48
    80005fa8:	ffffc097          	auipc	ra,0xffffc
    80005fac:	e5c080e7          	jalr	-420(ra) # 80001e04 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80005fb0:	00003517          	auipc	a0,0x3
    80005fb4:	6e850513          	addi	a0,a0,1768 # 80009698 <CONSOLE_STATUS+0x688>
    80005fb8:	ffffd097          	auipc	ra,0xffffd
    80005fbc:	b8c080e7          	jalr	-1140(ra) # 80002b44 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005fc0:	00000613          	li	a2,0
    80005fc4:	00000597          	auipc	a1,0x0
    80005fc8:	e2858593          	addi	a1,a1,-472 # 80005dec <_Z11workerBodyDPv>
    80005fcc:	fd840513          	addi	a0,s0,-40
    80005fd0:	ffffc097          	auipc	ra,0xffffc
    80005fd4:	e34080e7          	jalr	-460(ra) # 80001e04 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80005fd8:	00003517          	auipc	a0,0x3
    80005fdc:	6d850513          	addi	a0,a0,1752 # 800096b0 <CONSOLE_STATUS+0x6a0>
    80005fe0:	ffffd097          	auipc	ra,0xffffd
    80005fe4:	b64080e7          	jalr	-1180(ra) # 80002b44 <_Z11printStringPKc>
    80005fe8:	00c0006f          	j	80005ff4 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005fec:	ffffc097          	auipc	ra,0xffffc
    80005ff0:	ecc080e7          	jalr	-308(ra) # 80001eb8 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005ff4:	00006797          	auipc	a5,0x6
    80005ff8:	2147c783          	lbu	a5,532(a5) # 8000c208 <finishedA>
    80005ffc:	fe0788e3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb8>
    80006000:	00006797          	auipc	a5,0x6
    80006004:	2097c783          	lbu	a5,521(a5) # 8000c209 <finishedB>
    80006008:	fe0782e3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb8>
    8000600c:	00006797          	auipc	a5,0x6
    80006010:	20c7c783          	lbu	a5,524(a5) # 8000c218 <finishedC>
    80006014:	fc078ce3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb8>
    80006018:	00006797          	auipc	a5,0x6
    8000601c:	2017c783          	lbu	a5,513(a5) # 8000c219 <finishedD>
    80006020:	fc0786e3          	beqz	a5,80005fec <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80006024:	fc040493          	addi	s1,s0,-64
    80006028:	0080006f          	j	80006030 <_Z18Threads_C_API_testv+0xfc>
    8000602c:	00848493          	addi	s1,s1,8
    80006030:	fe040793          	addi	a5,s0,-32
    80006034:	00f48c63          	beq	s1,a5,8000604c <_Z18Threads_C_API_testv+0x118>
    80006038:	0004b503          	ld	a0,0(s1)
    8000603c:	fe0508e3          	beqz	a0,8000602c <_Z18Threads_C_API_testv+0xf8>
    80006040:	ffffc097          	auipc	ra,0xffffc
    80006044:	0e8080e7          	jalr	232(ra) # 80002128 <_ZN7_threaddlEPv>
    80006048:	fe5ff06f          	j	8000602c <_Z18Threads_C_API_testv+0xf8>
}
    8000604c:	03813083          	ld	ra,56(sp)
    80006050:	03013403          	ld	s0,48(sp)
    80006054:	02813483          	ld	s1,40(sp)
    80006058:	04010113          	addi	sp,sp,64
    8000605c:	00008067          	ret

0000000080006060 <_Z12testSleepingv>:

void testSleeping() {
    80006060:	fc010113          	addi	sp,sp,-64
    80006064:	02113c23          	sd	ra,56(sp)
    80006068:	02813823          	sd	s0,48(sp)
    8000606c:	02913423          	sd	s1,40(sp)
    80006070:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80006074:	00a00793          	li	a5,10
    80006078:	fcf43823          	sd	a5,-48(s0)
    8000607c:	01400793          	li	a5,20
    80006080:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006084:	00000493          	li	s1,0
    80006088:	02c0006f          	j	800060b4 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000608c:	00349793          	slli	a5,s1,0x3
    80006090:	fd040613          	addi	a2,s0,-48
    80006094:	00f60633          	add	a2,a2,a5
    80006098:	00000597          	auipc	a1,0x0
    8000609c:	abc58593          	addi	a1,a1,-1348 # 80005b54 <_Z9sleepyRunPv>
    800060a0:	fc040513          	addi	a0,s0,-64
    800060a4:	00f50533          	add	a0,a0,a5
    800060a8:	ffffc097          	auipc	ra,0xffffc
    800060ac:	d5c080e7          	jalr	-676(ra) # 80001e04 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800060b0:	0014849b          	addiw	s1,s1,1
    800060b4:	00100793          	li	a5,1
    800060b8:	fc97dae3          	bge	a5,s1,8000608c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800060bc:	00006797          	auipc	a5,0x6
    800060c0:	1547c783          	lbu	a5,340(a5) # 8000c210 <finished>
    800060c4:	fe078ce3          	beqz	a5,800060bc <_Z12testSleepingv+0x5c>
    800060c8:	00006797          	auipc	a5,0x6
    800060cc:	1497c783          	lbu	a5,329(a5) # 8000c211 <finished+0x1>
    800060d0:	fe0786e3          	beqz	a5,800060bc <_Z12testSleepingv+0x5c>
}
    800060d4:	03813083          	ld	ra,56(sp)
    800060d8:	03013403          	ld	s0,48(sp)
    800060dc:	02813483          	ld	s1,40(sp)
    800060e0:	04010113          	addi	sp,sp,64
    800060e4:	00008067          	ret

00000000800060e8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    800060e8:	f8010113          	addi	sp,sp,-128
    800060ec:	06113c23          	sd	ra,120(sp)
    800060f0:	06813823          	sd	s0,112(sp)
    800060f4:	06913423          	sd	s1,104(sp)
    800060f8:	07213023          	sd	s2,96(sp)
    800060fc:	05313c23          	sd	s3,88(sp)
    80006100:	05413823          	sd	s4,80(sp)
    80006104:	05513423          	sd	s5,72(sp)
    80006108:	05613023          	sd	s6,64(sp)
    8000610c:	03713c23          	sd	s7,56(sp)
    80006110:	03813823          	sd	s8,48(sp)
    80006114:	03913423          	sd	s9,40(sp)
    80006118:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000611c:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    80006120:	00003517          	auipc	a0,0x3
    80006124:	5a850513          	addi	a0,a0,1448 # 800096c8 <CONSOLE_STATUS+0x6b8>
    80006128:	ffffd097          	auipc	ra,0xffffd
    8000612c:	a1c080e7          	jalr	-1508(ra) # 80002b44 <_Z11printStringPKc>
        getString(input, 30);
    80006130:	01e00593          	li	a1,30
    80006134:	f8040493          	addi	s1,s0,-128
    80006138:	00048513          	mv	a0,s1
    8000613c:	ffffd097          	auipc	ra,0xffffd
    80006140:	a84080e7          	jalr	-1404(ra) # 80002bc0 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80006144:	00048513          	mv	a0,s1
    80006148:	ffffd097          	auipc	ra,0xffffd
    8000614c:	b44080e7          	jalr	-1212(ra) # 80002c8c <_Z11stringToIntPKc>
    80006150:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    80006154:	00003517          	auipc	a0,0x3
    80006158:	59450513          	addi	a0,a0,1428 # 800096e8 <CONSOLE_STATUS+0x6d8>
    8000615c:	ffffd097          	auipc	ra,0xffffd
    80006160:	9e8080e7          	jalr	-1560(ra) # 80002b44 <_Z11printStringPKc>
        getString(input, 30);
    80006164:	01e00593          	li	a1,30
    80006168:	00048513          	mv	a0,s1
    8000616c:	ffffd097          	auipc	ra,0xffffd
    80006170:	a54080e7          	jalr	-1452(ra) # 80002bc0 <_Z9getStringPci>
        n = stringToInt(input);
    80006174:	00048513          	mv	a0,s1
    80006178:	ffffd097          	auipc	ra,0xffffd
    8000617c:	b14080e7          	jalr	-1260(ra) # 80002c8c <_Z11stringToIntPKc>
    80006180:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80006184:	00003517          	auipc	a0,0x3
    80006188:	58450513          	addi	a0,a0,1412 # 80009708 <CONSOLE_STATUS+0x6f8>
    8000618c:	ffffd097          	auipc	ra,0xffffd
    80006190:	9b8080e7          	jalr	-1608(ra) # 80002b44 <_Z11printStringPKc>
    80006194:	00000613          	li	a2,0
    80006198:	00a00593          	li	a1,10
    8000619c:	00090513          	mv	a0,s2
    800061a0:	ffffd097          	auipc	ra,0xffffd
    800061a4:	b3c080e7          	jalr	-1220(ra) # 80002cdc <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    800061a8:	00003517          	auipc	a0,0x3
    800061ac:	57850513          	addi	a0,a0,1400 # 80009720 <CONSOLE_STATUS+0x710>
    800061b0:	ffffd097          	auipc	ra,0xffffd
    800061b4:	994080e7          	jalr	-1644(ra) # 80002b44 <_Z11printStringPKc>
    800061b8:	00000613          	li	a2,0
    800061bc:	00a00593          	li	a1,10
    800061c0:	00048513          	mv	a0,s1
    800061c4:	ffffd097          	auipc	ra,0xffffd
    800061c8:	b18080e7          	jalr	-1256(ra) # 80002cdc <_Z8printIntiii>
        printString(".\n");
    800061cc:	00003517          	auipc	a0,0x3
    800061d0:	23450513          	addi	a0,a0,564 # 80009400 <CONSOLE_STATUS+0x3f0>
    800061d4:	ffffd097          	auipc	ra,0xffffd
    800061d8:	970080e7          	jalr	-1680(ra) # 80002b44 <_Z11printStringPKc>
        if(threadNum > n) {
    800061dc:	0324c663          	blt	s1,s2,80006208 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    800061e0:	03205e63          	blez	s2,8000621c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    800061e4:	03800513          	li	a0,56
    800061e8:	ffffd097          	auipc	ra,0xffffd
    800061ec:	7ac080e7          	jalr	1964(ra) # 80003994 <_Znwm>
    800061f0:	00050a93          	mv	s5,a0
    800061f4:	04050063          	beqz	a0,80006234 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    800061f8:	00048593          	mv	a1,s1
    800061fc:	fffff097          	auipc	ra,0xfffff
    80006200:	3b0080e7          	jalr	944(ra) # 800055ac <_ZN9BufferCPPC1Ei>
    80006204:	0300006f          	j	80006234 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80006208:	00003517          	auipc	a0,0x3
    8000620c:	53050513          	addi	a0,a0,1328 # 80009738 <CONSOLE_STATUS+0x728>
    80006210:	ffffd097          	auipc	ra,0xffffd
    80006214:	934080e7          	jalr	-1740(ra) # 80002b44 <_Z11printStringPKc>
            return;
    80006218:	0140006f          	j	8000622c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000621c:	00003517          	auipc	a0,0x3
    80006220:	55c50513          	addi	a0,a0,1372 # 80009778 <CONSOLE_STATUS+0x768>
    80006224:	ffffd097          	auipc	ra,0xffffd
    80006228:	920080e7          	jalr	-1760(ra) # 80002b44 <_Z11printStringPKc>
            return;
    8000622c:	000b8113          	mv	sp,s7
    80006230:	24c0006f          	j	8000647c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    80006234:	01000513          	li	a0,16
    80006238:	ffffd097          	auipc	ra,0xffffd
    8000623c:	75c080e7          	jalr	1884(ra) # 80003994 <_Znwm>
    80006240:	00050493          	mv	s1,a0
    80006244:	00050863          	beqz	a0,80006254 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    80006248:	00000593          	li	a1,0
    8000624c:	ffffe097          	auipc	ra,0xffffe
    80006250:	840080e7          	jalr	-1984(ra) # 80003a8c <_ZN9SemaphoreC1Ej>
    80006254:	00006717          	auipc	a4,0x6
    80006258:	fb470713          	addi	a4,a4,-76 # 8000c208 <finishedA>
    8000625c:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    80006260:	00391793          	slli	a5,s2,0x3
    80006264:	00f78793          	addi	a5,a5,15
    80006268:	ff07f793          	andi	a5,a5,-16
    8000626c:	40f10133          	sub	sp,sp,a5
    80006270:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80006274:	0019069b          	addiw	a3,s2,1
    80006278:	00169793          	slli	a5,a3,0x1
    8000627c:	00d787b3          	add	a5,a5,a3
    80006280:	00379793          	slli	a5,a5,0x3
    80006284:	00f78793          	addi	a5,a5,15
    80006288:	ff07f793          	andi	a5,a5,-16
    8000628c:	40f10133          	sub	sp,sp,a5
    80006290:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    80006294:	00191793          	slli	a5,s2,0x1
    80006298:	012787b3          	add	a5,a5,s2
    8000629c:	00379793          	slli	a5,a5,0x3
    800062a0:	00f987b3          	add	a5,s3,a5
    800062a4:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    800062a8:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    800062ac:	01873703          	ld	a4,24(a4)
    800062b0:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800062b4:	01800513          	li	a0,24
    800062b8:	ffffd097          	auipc	ra,0xffffd
    800062bc:	6dc080e7          	jalr	1756(ra) # 80003994 <_Znwm>
    800062c0:	00050b13          	mv	s6,a0
    800062c4:	02050663          	beqz	a0,800062f0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    800062c8:	00191493          	slli	s1,s2,0x1
    800062cc:	012484b3          	add	s1,s1,s2
    800062d0:	00349493          	slli	s1,s1,0x3
    800062d4:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    800062d8:	ffffe097          	auipc	ra,0xffffe
    800062dc:	898080e7          	jalr	-1896(ra) # 80003b70 <_ZN6ThreadC1Ev>
    800062e0:	00006797          	auipc	a5,0x6
    800062e4:	bd078793          	addi	a5,a5,-1072 # 8000beb0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800062e8:	00fb3023          	sd	a5,0(s6)
    800062ec:	009b3823          	sd	s1,16(s6)
        consumer->start();
    800062f0:	000b0513          	mv	a0,s6
    800062f4:	ffffe097          	auipc	ra,0xffffe
    800062f8:	96c080e7          	jalr	-1684(ra) # 80003c60 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    800062fc:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    80006300:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    80006304:	00006797          	auipc	a5,0x6
    80006308:	f1c7b783          	ld	a5,-228(a5) # 8000c220 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000630c:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006310:	01800513          	li	a0,24
    80006314:	ffffd097          	auipc	ra,0xffffd
    80006318:	680080e7          	jalr	1664(ra) # 80003994 <_Znwm>
    8000631c:	00050493          	mv	s1,a0
    80006320:	00050e63          	beqz	a0,8000633c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80006324:	ffffe097          	auipc	ra,0xffffe
    80006328:	84c080e7          	jalr	-1972(ra) # 80003b70 <_ZN6ThreadC1Ev>
    8000632c:	00006797          	auipc	a5,0x6
    80006330:	b3478793          	addi	a5,a5,-1228 # 8000be60 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006334:	00f4b023          	sd	a5,0(s1)
    80006338:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000633c:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80006340:	00048513          	mv	a0,s1
    80006344:	ffffe097          	auipc	ra,0xffffe
    80006348:	91c080e7          	jalr	-1764(ra) # 80003c60 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000634c:	00100493          	li	s1,1
    80006350:	0300006f          	j	80006380 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006354:	00006797          	auipc	a5,0x6
    80006358:	b3478793          	addi	a5,a5,-1228 # 8000be88 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000635c:	00fc3023          	sd	a5,0(s8)
    80006360:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    80006364:	00349793          	slli	a5,s1,0x3
    80006368:	00fa07b3          	add	a5,s4,a5
    8000636c:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    80006370:	000c0513          	mv	a0,s8
    80006374:	ffffe097          	auipc	ra,0xffffe
    80006378:	8ec080e7          	jalr	-1812(ra) # 80003c60 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000637c:	0014849b          	addiw	s1,s1,1
    80006380:	0524dc63          	bge	s1,s2,800063d8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    80006384:	00149793          	slli	a5,s1,0x1
    80006388:	009787b3          	add	a5,a5,s1
    8000638c:	00379793          	slli	a5,a5,0x3
    80006390:	00f987b3          	add	a5,s3,a5
    80006394:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    80006398:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    8000639c:	00006717          	auipc	a4,0x6
    800063a0:	e8473703          	ld	a4,-380(a4) # 8000c220 <_ZN19ConsumerProducerCPP10waitForAllE>
    800063a4:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    800063a8:	01800513          	li	a0,24
    800063ac:	ffffd097          	auipc	ra,0xffffd
    800063b0:	5e8080e7          	jalr	1512(ra) # 80003994 <_Znwm>
    800063b4:	00050c13          	mv	s8,a0
    800063b8:	fa0506e3          	beqz	a0,80006364 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    800063bc:	00149c93          	slli	s9,s1,0x1
    800063c0:	009c8cb3          	add	s9,s9,s1
    800063c4:	003c9c93          	slli	s9,s9,0x3
    800063c8:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800063cc:	ffffd097          	auipc	ra,0xffffd
    800063d0:	7a4080e7          	jalr	1956(ra) # 80003b70 <_ZN6ThreadC1Ev>
    800063d4:	f81ff06f          	j	80006354 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    800063d8:	ffffe097          	auipc	ra,0xffffe
    800063dc:	860080e7          	jalr	-1952(ra) # 80003c38 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    800063e0:	00000493          	li	s1,0
    800063e4:	00994e63          	blt	s2,s1,80006400 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    800063e8:	00006517          	auipc	a0,0x6
    800063ec:	e3853503          	ld	a0,-456(a0) # 8000c220 <_ZN19ConsumerProducerCPP10waitForAllE>
    800063f0:	ffffd097          	auipc	ra,0xffffd
    800063f4:	6d4080e7          	jalr	1748(ra) # 80003ac4 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    800063f8:	0014849b          	addiw	s1,s1,1
    800063fc:	fe9ff06f          	j	800063e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    80006400:	00006517          	auipc	a0,0x6
    80006404:	e2053503          	ld	a0,-480(a0) # 8000c220 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006408:	00050863          	beqz	a0,80006418 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    8000640c:	00053783          	ld	a5,0(a0)
    80006410:	0087b783          	ld	a5,8(a5)
    80006414:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80006418:	00000493          	li	s1,0
    8000641c:	0080006f          	j	80006424 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    80006420:	0014849b          	addiw	s1,s1,1
    80006424:	0324d263          	bge	s1,s2,80006448 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    80006428:	00349793          	slli	a5,s1,0x3
    8000642c:	00fa07b3          	add	a5,s4,a5
    80006430:	0007b503          	ld	a0,0(a5)
    80006434:	fe0506e3          	beqz	a0,80006420 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    80006438:	00053783          	ld	a5,0(a0)
    8000643c:	0087b783          	ld	a5,8(a5)
    80006440:	000780e7          	jalr	a5
    80006444:	fddff06f          	j	80006420 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    80006448:	000b0a63          	beqz	s6,8000645c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    8000644c:	000b3783          	ld	a5,0(s6)
    80006450:	0087b783          	ld	a5,8(a5)
    80006454:	000b0513          	mv	a0,s6
    80006458:	000780e7          	jalr	a5
        delete buffer;
    8000645c:	000a8e63          	beqz	s5,80006478 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    80006460:	000a8513          	mv	a0,s5
    80006464:	fffff097          	auipc	ra,0xfffff
    80006468:	450080e7          	jalr	1104(ra) # 800058b4 <_ZN9BufferCPPD1Ev>
    8000646c:	000a8513          	mv	a0,s5
    80006470:	ffffd097          	auipc	ra,0xffffd
    80006474:	574080e7          	jalr	1396(ra) # 800039e4 <_ZdlPv>
    80006478:	000b8113          	mv	sp,s7
    }
    8000647c:	f8040113          	addi	sp,s0,-128
    80006480:	07813083          	ld	ra,120(sp)
    80006484:	07013403          	ld	s0,112(sp)
    80006488:	06813483          	ld	s1,104(sp)
    8000648c:	06013903          	ld	s2,96(sp)
    80006490:	05813983          	ld	s3,88(sp)
    80006494:	05013a03          	ld	s4,80(sp)
    80006498:	04813a83          	ld	s5,72(sp)
    8000649c:	04013b03          	ld	s6,64(sp)
    800064a0:	03813b83          	ld	s7,56(sp)
    800064a4:	03013c03          	ld	s8,48(sp)
    800064a8:	02813c83          	ld	s9,40(sp)
    800064ac:	08010113          	addi	sp,sp,128
    800064b0:	00008067          	ret
    800064b4:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    800064b8:	000a8513          	mv	a0,s5
    800064bc:	ffffd097          	auipc	ra,0xffffd
    800064c0:	528080e7          	jalr	1320(ra) # 800039e4 <_ZdlPv>
    800064c4:	00048513          	mv	a0,s1
    800064c8:	00007097          	auipc	ra,0x7
    800064cc:	e30080e7          	jalr	-464(ra) # 8000d2f8 <_Unwind_Resume>
    800064d0:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    800064d4:	00048513          	mv	a0,s1
    800064d8:	ffffd097          	auipc	ra,0xffffd
    800064dc:	50c080e7          	jalr	1292(ra) # 800039e4 <_ZdlPv>
    800064e0:	00090513          	mv	a0,s2
    800064e4:	00007097          	auipc	ra,0x7
    800064e8:	e14080e7          	jalr	-492(ra) # 8000d2f8 <_Unwind_Resume>
    800064ec:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800064f0:	000b0513          	mv	a0,s6
    800064f4:	ffffd097          	auipc	ra,0xffffd
    800064f8:	4f0080e7          	jalr	1264(ra) # 800039e4 <_ZdlPv>
    800064fc:	00048513          	mv	a0,s1
    80006500:	00007097          	auipc	ra,0x7
    80006504:	df8080e7          	jalr	-520(ra) # 8000d2f8 <_Unwind_Resume>
    80006508:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    8000650c:	00048513          	mv	a0,s1
    80006510:	ffffd097          	auipc	ra,0xffffd
    80006514:	4d4080e7          	jalr	1236(ra) # 800039e4 <_ZdlPv>
    80006518:	00090513          	mv	a0,s2
    8000651c:	00007097          	auipc	ra,0x7
    80006520:	ddc080e7          	jalr	-548(ra) # 8000d2f8 <_Unwind_Resume>
    80006524:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80006528:	000c0513          	mv	a0,s8
    8000652c:	ffffd097          	auipc	ra,0xffffd
    80006530:	4b8080e7          	jalr	1208(ra) # 800039e4 <_ZdlPv>
    80006534:	00048513          	mv	a0,s1
    80006538:	00007097          	auipc	ra,0x7
    8000653c:	dc0080e7          	jalr	-576(ra) # 8000d2f8 <_Unwind_Resume>

0000000080006540 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80006540:	fd010113          	addi	sp,sp,-48
    80006544:	02113423          	sd	ra,40(sp)
    80006548:	02813023          	sd	s0,32(sp)
    8000654c:	00913c23          	sd	s1,24(sp)
    80006550:	01213823          	sd	s2,16(sp)
    80006554:	01313423          	sd	s3,8(sp)
    80006558:	03010413          	addi	s0,sp,48
    8000655c:	00050913          	mv	s2,a0
            int i = 0;
    80006560:	00000993          	li	s3,0
    80006564:	0100006f          	j	80006574 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80006568:	00a00513          	li	a0,10
    8000656c:	ffffd097          	auipc	ra,0xffffd
    80006570:	7bc080e7          	jalr	1980(ra) # 80003d28 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80006574:	00006797          	auipc	a5,0x6
    80006578:	ca07a783          	lw	a5,-864(a5) # 8000c214 <_ZN19ConsumerProducerCPP9threadEndE>
    8000657c:	04079a63          	bnez	a5,800065d0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80006580:	01093783          	ld	a5,16(s2)
    80006584:	0087b503          	ld	a0,8(a5)
    80006588:	fffff097          	auipc	ra,0xfffff
    8000658c:	218080e7          	jalr	536(ra) # 800057a0 <_ZN9BufferCPP3getEv>
                i++;
    80006590:	0019849b          	addiw	s1,s3,1
    80006594:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80006598:	0ff57513          	andi	a0,a0,255
    8000659c:	ffffd097          	auipc	ra,0xffffd
    800065a0:	78c080e7          	jalr	1932(ra) # 80003d28 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    800065a4:	05000793          	li	a5,80
    800065a8:	02f4e4bb          	remw	s1,s1,a5
    800065ac:	fc0494e3          	bnez	s1,80006574 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800065b0:	fb9ff06f          	j	80006568 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    800065b4:	01093783          	ld	a5,16(s2)
    800065b8:	0087b503          	ld	a0,8(a5)
    800065bc:	fffff097          	auipc	ra,0xfffff
    800065c0:	1e4080e7          	jalr	484(ra) # 800057a0 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    800065c4:	0ff57513          	andi	a0,a0,255
    800065c8:	ffffd097          	auipc	ra,0xffffd
    800065cc:	760080e7          	jalr	1888(ra) # 80003d28 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    800065d0:	01093783          	ld	a5,16(s2)
    800065d4:	0087b503          	ld	a0,8(a5)
    800065d8:	fffff097          	auipc	ra,0xfffff
    800065dc:	254080e7          	jalr	596(ra) # 8000582c <_ZN9BufferCPP6getCntEv>
    800065e0:	fca04ae3          	bgtz	a0,800065b4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    800065e4:	01093783          	ld	a5,16(s2)
    800065e8:	0107b503          	ld	a0,16(a5)
    800065ec:	ffffd097          	auipc	ra,0xffffd
    800065f0:	504080e7          	jalr	1284(ra) # 80003af0 <_ZN9Semaphore6signalEv>
        }
    800065f4:	02813083          	ld	ra,40(sp)
    800065f8:	02013403          	ld	s0,32(sp)
    800065fc:	01813483          	ld	s1,24(sp)
    80006600:	01013903          	ld	s2,16(sp)
    80006604:	00813983          	ld	s3,8(sp)
    80006608:	03010113          	addi	sp,sp,48
    8000660c:	00008067          	ret

0000000080006610 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006610:	ff010113          	addi	sp,sp,-16
    80006614:	00113423          	sd	ra,8(sp)
    80006618:	00813023          	sd	s0,0(sp)
    8000661c:	01010413          	addi	s0,sp,16
    80006620:	00006797          	auipc	a5,0x6
    80006624:	89078793          	addi	a5,a5,-1904 # 8000beb0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006628:	00f53023          	sd	a5,0(a0)
    8000662c:	ffffd097          	auipc	ra,0xffffd
    80006630:	328080e7          	jalr	808(ra) # 80003954 <_ZN6ThreadD1Ev>
    80006634:	00813083          	ld	ra,8(sp)
    80006638:	00013403          	ld	s0,0(sp)
    8000663c:	01010113          	addi	sp,sp,16
    80006640:	00008067          	ret

0000000080006644 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80006644:	fe010113          	addi	sp,sp,-32
    80006648:	00113c23          	sd	ra,24(sp)
    8000664c:	00813823          	sd	s0,16(sp)
    80006650:	00913423          	sd	s1,8(sp)
    80006654:	02010413          	addi	s0,sp,32
    80006658:	00050493          	mv	s1,a0
    8000665c:	00006797          	auipc	a5,0x6
    80006660:	85478793          	addi	a5,a5,-1964 # 8000beb0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006664:	00f53023          	sd	a5,0(a0)
    80006668:	ffffd097          	auipc	ra,0xffffd
    8000666c:	2ec080e7          	jalr	748(ra) # 80003954 <_ZN6ThreadD1Ev>
    80006670:	00048513          	mv	a0,s1
    80006674:	ffffd097          	auipc	ra,0xffffd
    80006678:	370080e7          	jalr	880(ra) # 800039e4 <_ZdlPv>
    8000667c:	01813083          	ld	ra,24(sp)
    80006680:	01013403          	ld	s0,16(sp)
    80006684:	00813483          	ld	s1,8(sp)
    80006688:	02010113          	addi	sp,sp,32
    8000668c:	00008067          	ret

0000000080006690 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80006690:	ff010113          	addi	sp,sp,-16
    80006694:	00113423          	sd	ra,8(sp)
    80006698:	00813023          	sd	s0,0(sp)
    8000669c:	01010413          	addi	s0,sp,16
    800066a0:	00005797          	auipc	a5,0x5
    800066a4:	7c078793          	addi	a5,a5,1984 # 8000be60 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800066a8:	00f53023          	sd	a5,0(a0)
    800066ac:	ffffd097          	auipc	ra,0xffffd
    800066b0:	2a8080e7          	jalr	680(ra) # 80003954 <_ZN6ThreadD1Ev>
    800066b4:	00813083          	ld	ra,8(sp)
    800066b8:	00013403          	ld	s0,0(sp)
    800066bc:	01010113          	addi	sp,sp,16
    800066c0:	00008067          	ret

00000000800066c4 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    800066c4:	fe010113          	addi	sp,sp,-32
    800066c8:	00113c23          	sd	ra,24(sp)
    800066cc:	00813823          	sd	s0,16(sp)
    800066d0:	00913423          	sd	s1,8(sp)
    800066d4:	02010413          	addi	s0,sp,32
    800066d8:	00050493          	mv	s1,a0
    800066dc:	00005797          	auipc	a5,0x5
    800066e0:	78478793          	addi	a5,a5,1924 # 8000be60 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800066e4:	00f53023          	sd	a5,0(a0)
    800066e8:	ffffd097          	auipc	ra,0xffffd
    800066ec:	26c080e7          	jalr	620(ra) # 80003954 <_ZN6ThreadD1Ev>
    800066f0:	00048513          	mv	a0,s1
    800066f4:	ffffd097          	auipc	ra,0xffffd
    800066f8:	2f0080e7          	jalr	752(ra) # 800039e4 <_ZdlPv>
    800066fc:	01813083          	ld	ra,24(sp)
    80006700:	01013403          	ld	s0,16(sp)
    80006704:	00813483          	ld	s1,8(sp)
    80006708:	02010113          	addi	sp,sp,32
    8000670c:	00008067          	ret

0000000080006710 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006710:	ff010113          	addi	sp,sp,-16
    80006714:	00113423          	sd	ra,8(sp)
    80006718:	00813023          	sd	s0,0(sp)
    8000671c:	01010413          	addi	s0,sp,16
    80006720:	00005797          	auipc	a5,0x5
    80006724:	76878793          	addi	a5,a5,1896 # 8000be88 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006728:	00f53023          	sd	a5,0(a0)
    8000672c:	ffffd097          	auipc	ra,0xffffd
    80006730:	228080e7          	jalr	552(ra) # 80003954 <_ZN6ThreadD1Ev>
    80006734:	00813083          	ld	ra,8(sp)
    80006738:	00013403          	ld	s0,0(sp)
    8000673c:	01010113          	addi	sp,sp,16
    80006740:	00008067          	ret

0000000080006744 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80006744:	fe010113          	addi	sp,sp,-32
    80006748:	00113c23          	sd	ra,24(sp)
    8000674c:	00813823          	sd	s0,16(sp)
    80006750:	00913423          	sd	s1,8(sp)
    80006754:	02010413          	addi	s0,sp,32
    80006758:	00050493          	mv	s1,a0
    8000675c:	00005797          	auipc	a5,0x5
    80006760:	72c78793          	addi	a5,a5,1836 # 8000be88 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006764:	00f53023          	sd	a5,0(a0)
    80006768:	ffffd097          	auipc	ra,0xffffd
    8000676c:	1ec080e7          	jalr	492(ra) # 80003954 <_ZN6ThreadD1Ev>
    80006770:	00048513          	mv	a0,s1
    80006774:	ffffd097          	auipc	ra,0xffffd
    80006778:	270080e7          	jalr	624(ra) # 800039e4 <_ZdlPv>
    8000677c:	01813083          	ld	ra,24(sp)
    80006780:	01013403          	ld	s0,16(sp)
    80006784:	00813483          	ld	s1,8(sp)
    80006788:	02010113          	addi	sp,sp,32
    8000678c:	00008067          	ret

0000000080006790 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80006790:	fe010113          	addi	sp,sp,-32
    80006794:	00113c23          	sd	ra,24(sp)
    80006798:	00813823          	sd	s0,16(sp)
    8000679c:	00913423          	sd	s1,8(sp)
    800067a0:	02010413          	addi	s0,sp,32
    800067a4:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    800067a8:	ffffc097          	auipc	ra,0xffffc
    800067ac:	8e4080e7          	jalr	-1820(ra) # 8000208c <_Z4getcv>
    800067b0:	0005059b          	sext.w	a1,a0
    800067b4:	01b00793          	li	a5,27
    800067b8:	00f58c63          	beq	a1,a5,800067d0 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    800067bc:	0104b783          	ld	a5,16(s1)
    800067c0:	0087b503          	ld	a0,8(a5)
    800067c4:	fffff097          	auipc	ra,0xfffff
    800067c8:	f4c080e7          	jalr	-180(ra) # 80005710 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    800067cc:	fddff06f          	j	800067a8 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    800067d0:	00100793          	li	a5,1
    800067d4:	00006717          	auipc	a4,0x6
    800067d8:	a4f72023          	sw	a5,-1472(a4) # 8000c214 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    800067dc:	0104b783          	ld	a5,16(s1)
    800067e0:	02100593          	li	a1,33
    800067e4:	0087b503          	ld	a0,8(a5)
    800067e8:	fffff097          	auipc	ra,0xfffff
    800067ec:	f28080e7          	jalr	-216(ra) # 80005710 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    800067f0:	0104b783          	ld	a5,16(s1)
    800067f4:	0107b503          	ld	a0,16(a5)
    800067f8:	ffffd097          	auipc	ra,0xffffd
    800067fc:	2f8080e7          	jalr	760(ra) # 80003af0 <_ZN9Semaphore6signalEv>
        }
    80006800:	01813083          	ld	ra,24(sp)
    80006804:	01013403          	ld	s0,16(sp)
    80006808:	00813483          	ld	s1,8(sp)
    8000680c:	02010113          	addi	sp,sp,32
    80006810:	00008067          	ret

0000000080006814 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006814:	fe010113          	addi	sp,sp,-32
    80006818:	00113c23          	sd	ra,24(sp)
    8000681c:	00813823          	sd	s0,16(sp)
    80006820:	00913423          	sd	s1,8(sp)
    80006824:	01213023          	sd	s2,0(sp)
    80006828:	02010413          	addi	s0,sp,32
    8000682c:	00050493          	mv	s1,a0
            int i = 0;
    80006830:	00000913          	li	s2,0
            while (!threadEnd) {
    80006834:	00006797          	auipc	a5,0x6
    80006838:	9e07a783          	lw	a5,-1568(a5) # 8000c214 <_ZN19ConsumerProducerCPP9threadEndE>
    8000683c:	04079263          	bnez	a5,80006880 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80006840:	0104b783          	ld	a5,16(s1)
    80006844:	0007a583          	lw	a1,0(a5)
    80006848:	0305859b          	addiw	a1,a1,48
    8000684c:	0087b503          	ld	a0,8(a5)
    80006850:	fffff097          	auipc	ra,0xfffff
    80006854:	ec0080e7          	jalr	-320(ra) # 80005710 <_ZN9BufferCPP3putEi>
                i++;
    80006858:	0019071b          	addiw	a4,s2,1
    8000685c:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80006860:	0104b783          	ld	a5,16(s1)
    80006864:	0007a783          	lw	a5,0(a5)
    80006868:	00e787bb          	addw	a5,a5,a4
    8000686c:	00500513          	li	a0,5
    80006870:	02a7e53b          	remw	a0,a5,a0
    80006874:	ffffd097          	auipc	ra,0xffffd
    80006878:	35c080e7          	jalr	860(ra) # 80003bd0 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    8000687c:	fb9ff06f          	j	80006834 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80006880:	0104b783          	ld	a5,16(s1)
    80006884:	0107b503          	ld	a0,16(a5)
    80006888:	ffffd097          	auipc	ra,0xffffd
    8000688c:	268080e7          	jalr	616(ra) # 80003af0 <_ZN9Semaphore6signalEv>
        }
    80006890:	01813083          	ld	ra,24(sp)
    80006894:	01013403          	ld	s0,16(sp)
    80006898:	00813483          	ld	s1,8(sp)
    8000689c:	00013903          	ld	s2,0(sp)
    800068a0:	02010113          	addi	sp,sp,32
    800068a4:	00008067          	ret

00000000800068a8 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800068a8:	fe010113          	addi	sp,sp,-32
    800068ac:	00113c23          	sd	ra,24(sp)
    800068b0:	00813823          	sd	s0,16(sp)
    800068b4:	00913423          	sd	s1,8(sp)
    800068b8:	01213023          	sd	s2,0(sp)
    800068bc:	02010413          	addi	s0,sp,32
    800068c0:	00050493          	mv	s1,a0
    800068c4:	00058913          	mv	s2,a1
    800068c8:	0015879b          	addiw	a5,a1,1
    800068cc:	0007851b          	sext.w	a0,a5
    800068d0:	00f4a023          	sw	a5,0(s1)
    800068d4:	0004a823          	sw	zero,16(s1)
    800068d8:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800068dc:	00251513          	slli	a0,a0,0x2
    800068e0:	ffffb097          	auipc	ra,0xffffb
    800068e4:	4c8080e7          	jalr	1224(ra) # 80001da8 <_Z9mem_allocm>
    800068e8:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800068ec:	00000593          	li	a1,0
    800068f0:	02048513          	addi	a0,s1,32
    800068f4:	ffffb097          	auipc	ra,0xffffb
    800068f8:	6b0080e7          	jalr	1712(ra) # 80001fa4 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    800068fc:	00090593          	mv	a1,s2
    80006900:	01848513          	addi	a0,s1,24
    80006904:	ffffb097          	auipc	ra,0xffffb
    80006908:	6a0080e7          	jalr	1696(ra) # 80001fa4 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    8000690c:	00100593          	li	a1,1
    80006910:	02848513          	addi	a0,s1,40
    80006914:	ffffb097          	auipc	ra,0xffffb
    80006918:	690080e7          	jalr	1680(ra) # 80001fa4 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    8000691c:	00100593          	li	a1,1
    80006920:	03048513          	addi	a0,s1,48
    80006924:	ffffb097          	auipc	ra,0xffffb
    80006928:	680080e7          	jalr	1664(ra) # 80001fa4 <_Z8sem_openPP10_semaphorej>
}
    8000692c:	01813083          	ld	ra,24(sp)
    80006930:	01013403          	ld	s0,16(sp)
    80006934:	00813483          	ld	s1,8(sp)
    80006938:	00013903          	ld	s2,0(sp)
    8000693c:	02010113          	addi	sp,sp,32
    80006940:	00008067          	ret

0000000080006944 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006944:	fe010113          	addi	sp,sp,-32
    80006948:	00113c23          	sd	ra,24(sp)
    8000694c:	00813823          	sd	s0,16(sp)
    80006950:	00913423          	sd	s1,8(sp)
    80006954:	01213023          	sd	s2,0(sp)
    80006958:	02010413          	addi	s0,sp,32
    8000695c:	00050493          	mv	s1,a0
    80006960:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006964:	01853503          	ld	a0,24(a0)
    80006968:	ffffb097          	auipc	ra,0xffffb
    8000696c:	6a0080e7          	jalr	1696(ra) # 80002008 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80006970:	0304b503          	ld	a0,48(s1)
    80006974:	ffffb097          	auipc	ra,0xffffb
    80006978:	694080e7          	jalr	1684(ra) # 80002008 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    8000697c:	0084b783          	ld	a5,8(s1)
    80006980:	0144a703          	lw	a4,20(s1)
    80006984:	00271713          	slli	a4,a4,0x2
    80006988:	00e787b3          	add	a5,a5,a4
    8000698c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006990:	0144a783          	lw	a5,20(s1)
    80006994:	0017879b          	addiw	a5,a5,1
    80006998:	0004a703          	lw	a4,0(s1)
    8000699c:	02e7e7bb          	remw	a5,a5,a4
    800069a0:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800069a4:	0304b503          	ld	a0,48(s1)
    800069a8:	ffffb097          	auipc	ra,0xffffb
    800069ac:	68c080e7          	jalr	1676(ra) # 80002034 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    800069b0:	0204b503          	ld	a0,32(s1)
    800069b4:	ffffb097          	auipc	ra,0xffffb
    800069b8:	680080e7          	jalr	1664(ra) # 80002034 <_Z10sem_signalP10_semaphore>

}
    800069bc:	01813083          	ld	ra,24(sp)
    800069c0:	01013403          	ld	s0,16(sp)
    800069c4:	00813483          	ld	s1,8(sp)
    800069c8:	00013903          	ld	s2,0(sp)
    800069cc:	02010113          	addi	sp,sp,32
    800069d0:	00008067          	ret

00000000800069d4 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800069d4:	fe010113          	addi	sp,sp,-32
    800069d8:	00113c23          	sd	ra,24(sp)
    800069dc:	00813823          	sd	s0,16(sp)
    800069e0:	00913423          	sd	s1,8(sp)
    800069e4:	01213023          	sd	s2,0(sp)
    800069e8:	02010413          	addi	s0,sp,32
    800069ec:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800069f0:	02053503          	ld	a0,32(a0)
    800069f4:	ffffb097          	auipc	ra,0xffffb
    800069f8:	614080e7          	jalr	1556(ra) # 80002008 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    800069fc:	0284b503          	ld	a0,40(s1)
    80006a00:	ffffb097          	auipc	ra,0xffffb
    80006a04:	608080e7          	jalr	1544(ra) # 80002008 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006a08:	0084b703          	ld	a4,8(s1)
    80006a0c:	0104a783          	lw	a5,16(s1)
    80006a10:	00279693          	slli	a3,a5,0x2
    80006a14:	00d70733          	add	a4,a4,a3
    80006a18:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006a1c:	0017879b          	addiw	a5,a5,1
    80006a20:	0004a703          	lw	a4,0(s1)
    80006a24:	02e7e7bb          	remw	a5,a5,a4
    80006a28:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006a2c:	0284b503          	ld	a0,40(s1)
    80006a30:	ffffb097          	auipc	ra,0xffffb
    80006a34:	604080e7          	jalr	1540(ra) # 80002034 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006a38:	0184b503          	ld	a0,24(s1)
    80006a3c:	ffffb097          	auipc	ra,0xffffb
    80006a40:	5f8080e7          	jalr	1528(ra) # 80002034 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006a44:	00090513          	mv	a0,s2
    80006a48:	01813083          	ld	ra,24(sp)
    80006a4c:	01013403          	ld	s0,16(sp)
    80006a50:	00813483          	ld	s1,8(sp)
    80006a54:	00013903          	ld	s2,0(sp)
    80006a58:	02010113          	addi	sp,sp,32
    80006a5c:	00008067          	ret

0000000080006a60 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006a60:	fe010113          	addi	sp,sp,-32
    80006a64:	00113c23          	sd	ra,24(sp)
    80006a68:	00813823          	sd	s0,16(sp)
    80006a6c:	00913423          	sd	s1,8(sp)
    80006a70:	01213023          	sd	s2,0(sp)
    80006a74:	02010413          	addi	s0,sp,32
    80006a78:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006a7c:	02853503          	ld	a0,40(a0)
    80006a80:	ffffb097          	auipc	ra,0xffffb
    80006a84:	588080e7          	jalr	1416(ra) # 80002008 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80006a88:	0304b503          	ld	a0,48(s1)
    80006a8c:	ffffb097          	auipc	ra,0xffffb
    80006a90:	57c080e7          	jalr	1404(ra) # 80002008 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80006a94:	0144a783          	lw	a5,20(s1)
    80006a98:	0104a903          	lw	s2,16(s1)
    80006a9c:	0327ce63          	blt	a5,s2,80006ad8 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006aa0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006aa4:	0304b503          	ld	a0,48(s1)
    80006aa8:	ffffb097          	auipc	ra,0xffffb
    80006aac:	58c080e7          	jalr	1420(ra) # 80002034 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006ab0:	0284b503          	ld	a0,40(s1)
    80006ab4:	ffffb097          	auipc	ra,0xffffb
    80006ab8:	580080e7          	jalr	1408(ra) # 80002034 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006abc:	00090513          	mv	a0,s2
    80006ac0:	01813083          	ld	ra,24(sp)
    80006ac4:	01013403          	ld	s0,16(sp)
    80006ac8:	00813483          	ld	s1,8(sp)
    80006acc:	00013903          	ld	s2,0(sp)
    80006ad0:	02010113          	addi	sp,sp,32
    80006ad4:	00008067          	ret
        ret = cap - head + tail;
    80006ad8:	0004a703          	lw	a4,0(s1)
    80006adc:	4127093b          	subw	s2,a4,s2
    80006ae0:	00f9093b          	addw	s2,s2,a5
    80006ae4:	fc1ff06f          	j	80006aa4 <_ZN6Buffer6getCntEv+0x44>

0000000080006ae8 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006ae8:	fe010113          	addi	sp,sp,-32
    80006aec:	00113c23          	sd	ra,24(sp)
    80006af0:	00813823          	sd	s0,16(sp)
    80006af4:	00913423          	sd	s1,8(sp)
    80006af8:	02010413          	addi	s0,sp,32
    80006afc:	00050493          	mv	s1,a0
    putc('\n');
    80006b00:	00a00513          	li	a0,10
    80006b04:	ffffb097          	auipc	ra,0xffffb
    80006b08:	5b0080e7          	jalr	1456(ra) # 800020b4 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006b0c:	00003517          	auipc	a0,0x3
    80006b10:	a9c50513          	addi	a0,a0,-1380 # 800095a8 <CONSOLE_STATUS+0x598>
    80006b14:	ffffc097          	auipc	ra,0xffffc
    80006b18:	030080e7          	jalr	48(ra) # 80002b44 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006b1c:	00048513          	mv	a0,s1
    80006b20:	00000097          	auipc	ra,0x0
    80006b24:	f40080e7          	jalr	-192(ra) # 80006a60 <_ZN6Buffer6getCntEv>
    80006b28:	02a05c63          	blez	a0,80006b60 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006b2c:	0084b783          	ld	a5,8(s1)
    80006b30:	0104a703          	lw	a4,16(s1)
    80006b34:	00271713          	slli	a4,a4,0x2
    80006b38:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006b3c:	0007c503          	lbu	a0,0(a5)
    80006b40:	ffffb097          	auipc	ra,0xffffb
    80006b44:	574080e7          	jalr	1396(ra) # 800020b4 <_Z4putcc>
        head = (head + 1) % cap;
    80006b48:	0104a783          	lw	a5,16(s1)
    80006b4c:	0017879b          	addiw	a5,a5,1
    80006b50:	0004a703          	lw	a4,0(s1)
    80006b54:	02e7e7bb          	remw	a5,a5,a4
    80006b58:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006b5c:	fc1ff06f          	j	80006b1c <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006b60:	02100513          	li	a0,33
    80006b64:	ffffb097          	auipc	ra,0xffffb
    80006b68:	550080e7          	jalr	1360(ra) # 800020b4 <_Z4putcc>
    putc('\n');
    80006b6c:	00a00513          	li	a0,10
    80006b70:	ffffb097          	auipc	ra,0xffffb
    80006b74:	544080e7          	jalr	1348(ra) # 800020b4 <_Z4putcc>
    mem_free(buffer);
    80006b78:	0084b503          	ld	a0,8(s1)
    80006b7c:	ffffb097          	auipc	ra,0xffffb
    80006b80:	25c080e7          	jalr	604(ra) # 80001dd8 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006b84:	0204b503          	ld	a0,32(s1)
    80006b88:	ffffb097          	auipc	ra,0xffffb
    80006b8c:	454080e7          	jalr	1108(ra) # 80001fdc <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006b90:	0184b503          	ld	a0,24(s1)
    80006b94:	ffffb097          	auipc	ra,0xffffb
    80006b98:	448080e7          	jalr	1096(ra) # 80001fdc <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80006b9c:	0304b503          	ld	a0,48(s1)
    80006ba0:	ffffb097          	auipc	ra,0xffffb
    80006ba4:	43c080e7          	jalr	1084(ra) # 80001fdc <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006ba8:	0284b503          	ld	a0,40(s1)
    80006bac:	ffffb097          	auipc	ra,0xffffb
    80006bb0:	430080e7          	jalr	1072(ra) # 80001fdc <_Z9sem_closeP10_semaphore>
}
    80006bb4:	01813083          	ld	ra,24(sp)
    80006bb8:	01013403          	ld	s0,16(sp)
    80006bbc:	00813483          	ld	s1,8(sp)
    80006bc0:	02010113          	addi	sp,sp,32
    80006bc4:	00008067          	ret

0000000080006bc8 <start>:
    80006bc8:	ff010113          	addi	sp,sp,-16
    80006bcc:	00813423          	sd	s0,8(sp)
    80006bd0:	01010413          	addi	s0,sp,16
    80006bd4:	300027f3          	csrr	a5,mstatus
    80006bd8:	ffffe737          	lui	a4,0xffffe
    80006bdc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff136f>
    80006be0:	00e7f7b3          	and	a5,a5,a4
    80006be4:	00001737          	lui	a4,0x1
    80006be8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006bec:	00e7e7b3          	or	a5,a5,a4
    80006bf0:	30079073          	csrw	mstatus,a5
    80006bf4:	00000797          	auipc	a5,0x0
    80006bf8:	16078793          	addi	a5,a5,352 # 80006d54 <system_main>
    80006bfc:	34179073          	csrw	mepc,a5
    80006c00:	00000793          	li	a5,0
    80006c04:	18079073          	csrw	satp,a5
    80006c08:	000107b7          	lui	a5,0x10
    80006c0c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006c10:	30279073          	csrw	medeleg,a5
    80006c14:	30379073          	csrw	mideleg,a5
    80006c18:	104027f3          	csrr	a5,sie
    80006c1c:	2227e793          	ori	a5,a5,546
    80006c20:	10479073          	csrw	sie,a5
    80006c24:	fff00793          	li	a5,-1
    80006c28:	00a7d793          	srli	a5,a5,0xa
    80006c2c:	3b079073          	csrw	pmpaddr0,a5
    80006c30:	00f00793          	li	a5,15
    80006c34:	3a079073          	csrw	pmpcfg0,a5
    80006c38:	f14027f3          	csrr	a5,mhartid
    80006c3c:	0200c737          	lui	a4,0x200c
    80006c40:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006c44:	0007869b          	sext.w	a3,a5
    80006c48:	00269713          	slli	a4,a3,0x2
    80006c4c:	000f4637          	lui	a2,0xf4
    80006c50:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006c54:	00d70733          	add	a4,a4,a3
    80006c58:	0037979b          	slliw	a5,a5,0x3
    80006c5c:	020046b7          	lui	a3,0x2004
    80006c60:	00d787b3          	add	a5,a5,a3
    80006c64:	00c585b3          	add	a1,a1,a2
    80006c68:	00371693          	slli	a3,a4,0x3
    80006c6c:	00005717          	auipc	a4,0x5
    80006c70:	5c470713          	addi	a4,a4,1476 # 8000c230 <timer_scratch>
    80006c74:	00b7b023          	sd	a1,0(a5)
    80006c78:	00d70733          	add	a4,a4,a3
    80006c7c:	00f73c23          	sd	a5,24(a4)
    80006c80:	02c73023          	sd	a2,32(a4)
    80006c84:	34071073          	csrw	mscratch,a4
    80006c88:	00000797          	auipc	a5,0x0
    80006c8c:	6e878793          	addi	a5,a5,1768 # 80007370 <timervec>
    80006c90:	30579073          	csrw	mtvec,a5
    80006c94:	300027f3          	csrr	a5,mstatus
    80006c98:	0087e793          	ori	a5,a5,8
    80006c9c:	30079073          	csrw	mstatus,a5
    80006ca0:	304027f3          	csrr	a5,mie
    80006ca4:	0807e793          	ori	a5,a5,128
    80006ca8:	30479073          	csrw	mie,a5
    80006cac:	f14027f3          	csrr	a5,mhartid
    80006cb0:	0007879b          	sext.w	a5,a5
    80006cb4:	00078213          	mv	tp,a5
    80006cb8:	30200073          	mret
    80006cbc:	00813403          	ld	s0,8(sp)
    80006cc0:	01010113          	addi	sp,sp,16
    80006cc4:	00008067          	ret

0000000080006cc8 <timerinit>:
    80006cc8:	ff010113          	addi	sp,sp,-16
    80006ccc:	00813423          	sd	s0,8(sp)
    80006cd0:	01010413          	addi	s0,sp,16
    80006cd4:	f14027f3          	csrr	a5,mhartid
    80006cd8:	0200c737          	lui	a4,0x200c
    80006cdc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006ce0:	0007869b          	sext.w	a3,a5
    80006ce4:	00269713          	slli	a4,a3,0x2
    80006ce8:	000f4637          	lui	a2,0xf4
    80006cec:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006cf0:	00d70733          	add	a4,a4,a3
    80006cf4:	0037979b          	slliw	a5,a5,0x3
    80006cf8:	020046b7          	lui	a3,0x2004
    80006cfc:	00d787b3          	add	a5,a5,a3
    80006d00:	00c585b3          	add	a1,a1,a2
    80006d04:	00371693          	slli	a3,a4,0x3
    80006d08:	00005717          	auipc	a4,0x5
    80006d0c:	52870713          	addi	a4,a4,1320 # 8000c230 <timer_scratch>
    80006d10:	00b7b023          	sd	a1,0(a5)
    80006d14:	00d70733          	add	a4,a4,a3
    80006d18:	00f73c23          	sd	a5,24(a4)
    80006d1c:	02c73023          	sd	a2,32(a4)
    80006d20:	34071073          	csrw	mscratch,a4
    80006d24:	00000797          	auipc	a5,0x0
    80006d28:	64c78793          	addi	a5,a5,1612 # 80007370 <timervec>
    80006d2c:	30579073          	csrw	mtvec,a5
    80006d30:	300027f3          	csrr	a5,mstatus
    80006d34:	0087e793          	ori	a5,a5,8
    80006d38:	30079073          	csrw	mstatus,a5
    80006d3c:	304027f3          	csrr	a5,mie
    80006d40:	0807e793          	ori	a5,a5,128
    80006d44:	30479073          	csrw	mie,a5
    80006d48:	00813403          	ld	s0,8(sp)
    80006d4c:	01010113          	addi	sp,sp,16
    80006d50:	00008067          	ret

0000000080006d54 <system_main>:
    80006d54:	fe010113          	addi	sp,sp,-32
    80006d58:	00813823          	sd	s0,16(sp)
    80006d5c:	00913423          	sd	s1,8(sp)
    80006d60:	00113c23          	sd	ra,24(sp)
    80006d64:	02010413          	addi	s0,sp,32
    80006d68:	00000097          	auipc	ra,0x0
    80006d6c:	0c4080e7          	jalr	196(ra) # 80006e2c <cpuid>
    80006d70:	00005497          	auipc	s1,0x5
    80006d74:	22048493          	addi	s1,s1,544 # 8000bf90 <started>
    80006d78:	02050263          	beqz	a0,80006d9c <system_main+0x48>
    80006d7c:	0004a783          	lw	a5,0(s1)
    80006d80:	0007879b          	sext.w	a5,a5
    80006d84:	fe078ce3          	beqz	a5,80006d7c <system_main+0x28>
    80006d88:	0ff0000f          	fence
    80006d8c:	00003517          	auipc	a0,0x3
    80006d90:	a4c50513          	addi	a0,a0,-1460 # 800097d8 <CONSOLE_STATUS+0x7c8>
    80006d94:	00001097          	auipc	ra,0x1
    80006d98:	a78080e7          	jalr	-1416(ra) # 8000780c <panic>
    80006d9c:	00001097          	auipc	ra,0x1
    80006da0:	9cc080e7          	jalr	-1588(ra) # 80007768 <consoleinit>
    80006da4:	00001097          	auipc	ra,0x1
    80006da8:	158080e7          	jalr	344(ra) # 80007efc <printfinit>
    80006dac:	00002517          	auipc	a0,0x2
    80006db0:	5ec50513          	addi	a0,a0,1516 # 80009398 <CONSOLE_STATUS+0x388>
    80006db4:	00001097          	auipc	ra,0x1
    80006db8:	ab4080e7          	jalr	-1356(ra) # 80007868 <__printf>
    80006dbc:	00003517          	auipc	a0,0x3
    80006dc0:	9ec50513          	addi	a0,a0,-1556 # 800097a8 <CONSOLE_STATUS+0x798>
    80006dc4:	00001097          	auipc	ra,0x1
    80006dc8:	aa4080e7          	jalr	-1372(ra) # 80007868 <__printf>
    80006dcc:	00002517          	auipc	a0,0x2
    80006dd0:	5cc50513          	addi	a0,a0,1484 # 80009398 <CONSOLE_STATUS+0x388>
    80006dd4:	00001097          	auipc	ra,0x1
    80006dd8:	a94080e7          	jalr	-1388(ra) # 80007868 <__printf>
    80006ddc:	00001097          	auipc	ra,0x1
    80006de0:	4ac080e7          	jalr	1196(ra) # 80008288 <kinit>
    80006de4:	00000097          	auipc	ra,0x0
    80006de8:	148080e7          	jalr	328(ra) # 80006f2c <trapinit>
    80006dec:	00000097          	auipc	ra,0x0
    80006df0:	16c080e7          	jalr	364(ra) # 80006f58 <trapinithart>
    80006df4:	00000097          	auipc	ra,0x0
    80006df8:	5bc080e7          	jalr	1468(ra) # 800073b0 <plicinit>
    80006dfc:	00000097          	auipc	ra,0x0
    80006e00:	5dc080e7          	jalr	1500(ra) # 800073d8 <plicinithart>
    80006e04:	00000097          	auipc	ra,0x0
    80006e08:	078080e7          	jalr	120(ra) # 80006e7c <userinit>
    80006e0c:	0ff0000f          	fence
    80006e10:	00100793          	li	a5,1
    80006e14:	00003517          	auipc	a0,0x3
    80006e18:	9ac50513          	addi	a0,a0,-1620 # 800097c0 <CONSOLE_STATUS+0x7b0>
    80006e1c:	00f4a023          	sw	a5,0(s1)
    80006e20:	00001097          	auipc	ra,0x1
    80006e24:	a48080e7          	jalr	-1464(ra) # 80007868 <__printf>
    80006e28:	0000006f          	j	80006e28 <system_main+0xd4>

0000000080006e2c <cpuid>:
    80006e2c:	ff010113          	addi	sp,sp,-16
    80006e30:	00813423          	sd	s0,8(sp)
    80006e34:	01010413          	addi	s0,sp,16
    80006e38:	00020513          	mv	a0,tp
    80006e3c:	00813403          	ld	s0,8(sp)
    80006e40:	0005051b          	sext.w	a0,a0
    80006e44:	01010113          	addi	sp,sp,16
    80006e48:	00008067          	ret

0000000080006e4c <mycpu>:
    80006e4c:	ff010113          	addi	sp,sp,-16
    80006e50:	00813423          	sd	s0,8(sp)
    80006e54:	01010413          	addi	s0,sp,16
    80006e58:	00020793          	mv	a5,tp
    80006e5c:	00813403          	ld	s0,8(sp)
    80006e60:	0007879b          	sext.w	a5,a5
    80006e64:	00779793          	slli	a5,a5,0x7
    80006e68:	00006517          	auipc	a0,0x6
    80006e6c:	3f850513          	addi	a0,a0,1016 # 8000d260 <cpus>
    80006e70:	00f50533          	add	a0,a0,a5
    80006e74:	01010113          	addi	sp,sp,16
    80006e78:	00008067          	ret

0000000080006e7c <userinit>:
    80006e7c:	ff010113          	addi	sp,sp,-16
    80006e80:	00813423          	sd	s0,8(sp)
    80006e84:	01010413          	addi	s0,sp,16
    80006e88:	00813403          	ld	s0,8(sp)
    80006e8c:	01010113          	addi	sp,sp,16
    80006e90:	ffffc317          	auipc	t1,0xffffc
    80006e94:	23030067          	jr	560(t1) # 800030c0 <main>

0000000080006e98 <either_copyout>:
    80006e98:	ff010113          	addi	sp,sp,-16
    80006e9c:	00813023          	sd	s0,0(sp)
    80006ea0:	00113423          	sd	ra,8(sp)
    80006ea4:	01010413          	addi	s0,sp,16
    80006ea8:	02051663          	bnez	a0,80006ed4 <either_copyout+0x3c>
    80006eac:	00058513          	mv	a0,a1
    80006eb0:	00060593          	mv	a1,a2
    80006eb4:	0006861b          	sext.w	a2,a3
    80006eb8:	00002097          	auipc	ra,0x2
    80006ebc:	c5c080e7          	jalr	-932(ra) # 80008b14 <__memmove>
    80006ec0:	00813083          	ld	ra,8(sp)
    80006ec4:	00013403          	ld	s0,0(sp)
    80006ec8:	00000513          	li	a0,0
    80006ecc:	01010113          	addi	sp,sp,16
    80006ed0:	00008067          	ret
    80006ed4:	00003517          	auipc	a0,0x3
    80006ed8:	92c50513          	addi	a0,a0,-1748 # 80009800 <CONSOLE_STATUS+0x7f0>
    80006edc:	00001097          	auipc	ra,0x1
    80006ee0:	930080e7          	jalr	-1744(ra) # 8000780c <panic>

0000000080006ee4 <either_copyin>:
    80006ee4:	ff010113          	addi	sp,sp,-16
    80006ee8:	00813023          	sd	s0,0(sp)
    80006eec:	00113423          	sd	ra,8(sp)
    80006ef0:	01010413          	addi	s0,sp,16
    80006ef4:	02059463          	bnez	a1,80006f1c <either_copyin+0x38>
    80006ef8:	00060593          	mv	a1,a2
    80006efc:	0006861b          	sext.w	a2,a3
    80006f00:	00002097          	auipc	ra,0x2
    80006f04:	c14080e7          	jalr	-1004(ra) # 80008b14 <__memmove>
    80006f08:	00813083          	ld	ra,8(sp)
    80006f0c:	00013403          	ld	s0,0(sp)
    80006f10:	00000513          	li	a0,0
    80006f14:	01010113          	addi	sp,sp,16
    80006f18:	00008067          	ret
    80006f1c:	00003517          	auipc	a0,0x3
    80006f20:	90c50513          	addi	a0,a0,-1780 # 80009828 <CONSOLE_STATUS+0x818>
    80006f24:	00001097          	auipc	ra,0x1
    80006f28:	8e8080e7          	jalr	-1816(ra) # 8000780c <panic>

0000000080006f2c <trapinit>:
    80006f2c:	ff010113          	addi	sp,sp,-16
    80006f30:	00813423          	sd	s0,8(sp)
    80006f34:	01010413          	addi	s0,sp,16
    80006f38:	00813403          	ld	s0,8(sp)
    80006f3c:	00003597          	auipc	a1,0x3
    80006f40:	91458593          	addi	a1,a1,-1772 # 80009850 <CONSOLE_STATUS+0x840>
    80006f44:	00006517          	auipc	a0,0x6
    80006f48:	39c50513          	addi	a0,a0,924 # 8000d2e0 <tickslock>
    80006f4c:	01010113          	addi	sp,sp,16
    80006f50:	00001317          	auipc	t1,0x1
    80006f54:	5c830067          	jr	1480(t1) # 80008518 <initlock>

0000000080006f58 <trapinithart>:
    80006f58:	ff010113          	addi	sp,sp,-16
    80006f5c:	00813423          	sd	s0,8(sp)
    80006f60:	01010413          	addi	s0,sp,16
    80006f64:	00000797          	auipc	a5,0x0
    80006f68:	2fc78793          	addi	a5,a5,764 # 80007260 <kernelvec>
    80006f6c:	10579073          	csrw	stvec,a5
    80006f70:	00813403          	ld	s0,8(sp)
    80006f74:	01010113          	addi	sp,sp,16
    80006f78:	00008067          	ret

0000000080006f7c <usertrap>:
    80006f7c:	ff010113          	addi	sp,sp,-16
    80006f80:	00813423          	sd	s0,8(sp)
    80006f84:	01010413          	addi	s0,sp,16
    80006f88:	00813403          	ld	s0,8(sp)
    80006f8c:	01010113          	addi	sp,sp,16
    80006f90:	00008067          	ret

0000000080006f94 <usertrapret>:
    80006f94:	ff010113          	addi	sp,sp,-16
    80006f98:	00813423          	sd	s0,8(sp)
    80006f9c:	01010413          	addi	s0,sp,16
    80006fa0:	00813403          	ld	s0,8(sp)
    80006fa4:	01010113          	addi	sp,sp,16
    80006fa8:	00008067          	ret

0000000080006fac <kerneltrap>:
    80006fac:	fe010113          	addi	sp,sp,-32
    80006fb0:	00813823          	sd	s0,16(sp)
    80006fb4:	00113c23          	sd	ra,24(sp)
    80006fb8:	00913423          	sd	s1,8(sp)
    80006fbc:	02010413          	addi	s0,sp,32
    80006fc0:	142025f3          	csrr	a1,scause
    80006fc4:	100027f3          	csrr	a5,sstatus
    80006fc8:	0027f793          	andi	a5,a5,2
    80006fcc:	10079c63          	bnez	a5,800070e4 <kerneltrap+0x138>
    80006fd0:	142027f3          	csrr	a5,scause
    80006fd4:	0207ce63          	bltz	a5,80007010 <kerneltrap+0x64>
    80006fd8:	00003517          	auipc	a0,0x3
    80006fdc:	8c050513          	addi	a0,a0,-1856 # 80009898 <CONSOLE_STATUS+0x888>
    80006fe0:	00001097          	auipc	ra,0x1
    80006fe4:	888080e7          	jalr	-1912(ra) # 80007868 <__printf>
    80006fe8:	141025f3          	csrr	a1,sepc
    80006fec:	14302673          	csrr	a2,stval
    80006ff0:	00003517          	auipc	a0,0x3
    80006ff4:	8b850513          	addi	a0,a0,-1864 # 800098a8 <CONSOLE_STATUS+0x898>
    80006ff8:	00001097          	auipc	ra,0x1
    80006ffc:	870080e7          	jalr	-1936(ra) # 80007868 <__printf>
    80007000:	00003517          	auipc	a0,0x3
    80007004:	8c050513          	addi	a0,a0,-1856 # 800098c0 <CONSOLE_STATUS+0x8b0>
    80007008:	00001097          	auipc	ra,0x1
    8000700c:	804080e7          	jalr	-2044(ra) # 8000780c <panic>
    80007010:	0ff7f713          	andi	a4,a5,255
    80007014:	00900693          	li	a3,9
    80007018:	04d70063          	beq	a4,a3,80007058 <kerneltrap+0xac>
    8000701c:	fff00713          	li	a4,-1
    80007020:	03f71713          	slli	a4,a4,0x3f
    80007024:	00170713          	addi	a4,a4,1
    80007028:	fae798e3          	bne	a5,a4,80006fd8 <kerneltrap+0x2c>
    8000702c:	00000097          	auipc	ra,0x0
    80007030:	e00080e7          	jalr	-512(ra) # 80006e2c <cpuid>
    80007034:	06050663          	beqz	a0,800070a0 <kerneltrap+0xf4>
    80007038:	144027f3          	csrr	a5,sip
    8000703c:	ffd7f793          	andi	a5,a5,-3
    80007040:	14479073          	csrw	sip,a5
    80007044:	01813083          	ld	ra,24(sp)
    80007048:	01013403          	ld	s0,16(sp)
    8000704c:	00813483          	ld	s1,8(sp)
    80007050:	02010113          	addi	sp,sp,32
    80007054:	00008067          	ret
    80007058:	00000097          	auipc	ra,0x0
    8000705c:	3cc080e7          	jalr	972(ra) # 80007424 <plic_claim>
    80007060:	00a00793          	li	a5,10
    80007064:	00050493          	mv	s1,a0
    80007068:	06f50863          	beq	a0,a5,800070d8 <kerneltrap+0x12c>
    8000706c:	fc050ce3          	beqz	a0,80007044 <kerneltrap+0x98>
    80007070:	00050593          	mv	a1,a0
    80007074:	00003517          	auipc	a0,0x3
    80007078:	80450513          	addi	a0,a0,-2044 # 80009878 <CONSOLE_STATUS+0x868>
    8000707c:	00000097          	auipc	ra,0x0
    80007080:	7ec080e7          	jalr	2028(ra) # 80007868 <__printf>
    80007084:	01013403          	ld	s0,16(sp)
    80007088:	01813083          	ld	ra,24(sp)
    8000708c:	00048513          	mv	a0,s1
    80007090:	00813483          	ld	s1,8(sp)
    80007094:	02010113          	addi	sp,sp,32
    80007098:	00000317          	auipc	t1,0x0
    8000709c:	3c430067          	jr	964(t1) # 8000745c <plic_complete>
    800070a0:	00006517          	auipc	a0,0x6
    800070a4:	24050513          	addi	a0,a0,576 # 8000d2e0 <tickslock>
    800070a8:	00001097          	auipc	ra,0x1
    800070ac:	494080e7          	jalr	1172(ra) # 8000853c <acquire>
    800070b0:	00005717          	auipc	a4,0x5
    800070b4:	ee470713          	addi	a4,a4,-284 # 8000bf94 <ticks>
    800070b8:	00072783          	lw	a5,0(a4)
    800070bc:	00006517          	auipc	a0,0x6
    800070c0:	22450513          	addi	a0,a0,548 # 8000d2e0 <tickslock>
    800070c4:	0017879b          	addiw	a5,a5,1
    800070c8:	00f72023          	sw	a5,0(a4)
    800070cc:	00001097          	auipc	ra,0x1
    800070d0:	53c080e7          	jalr	1340(ra) # 80008608 <release>
    800070d4:	f65ff06f          	j	80007038 <kerneltrap+0x8c>
    800070d8:	00001097          	auipc	ra,0x1
    800070dc:	098080e7          	jalr	152(ra) # 80008170 <uartintr>
    800070e0:	fa5ff06f          	j	80007084 <kerneltrap+0xd8>
    800070e4:	00002517          	auipc	a0,0x2
    800070e8:	77450513          	addi	a0,a0,1908 # 80009858 <CONSOLE_STATUS+0x848>
    800070ec:	00000097          	auipc	ra,0x0
    800070f0:	720080e7          	jalr	1824(ra) # 8000780c <panic>

00000000800070f4 <clockintr>:
    800070f4:	fe010113          	addi	sp,sp,-32
    800070f8:	00813823          	sd	s0,16(sp)
    800070fc:	00913423          	sd	s1,8(sp)
    80007100:	00113c23          	sd	ra,24(sp)
    80007104:	02010413          	addi	s0,sp,32
    80007108:	00006497          	auipc	s1,0x6
    8000710c:	1d848493          	addi	s1,s1,472 # 8000d2e0 <tickslock>
    80007110:	00048513          	mv	a0,s1
    80007114:	00001097          	auipc	ra,0x1
    80007118:	428080e7          	jalr	1064(ra) # 8000853c <acquire>
    8000711c:	00005717          	auipc	a4,0x5
    80007120:	e7870713          	addi	a4,a4,-392 # 8000bf94 <ticks>
    80007124:	00072783          	lw	a5,0(a4)
    80007128:	01013403          	ld	s0,16(sp)
    8000712c:	01813083          	ld	ra,24(sp)
    80007130:	00048513          	mv	a0,s1
    80007134:	0017879b          	addiw	a5,a5,1
    80007138:	00813483          	ld	s1,8(sp)
    8000713c:	00f72023          	sw	a5,0(a4)
    80007140:	02010113          	addi	sp,sp,32
    80007144:	00001317          	auipc	t1,0x1
    80007148:	4c430067          	jr	1220(t1) # 80008608 <release>

000000008000714c <devintr>:
    8000714c:	142027f3          	csrr	a5,scause
    80007150:	00000513          	li	a0,0
    80007154:	0007c463          	bltz	a5,8000715c <devintr+0x10>
    80007158:	00008067          	ret
    8000715c:	fe010113          	addi	sp,sp,-32
    80007160:	00813823          	sd	s0,16(sp)
    80007164:	00113c23          	sd	ra,24(sp)
    80007168:	00913423          	sd	s1,8(sp)
    8000716c:	02010413          	addi	s0,sp,32
    80007170:	0ff7f713          	andi	a4,a5,255
    80007174:	00900693          	li	a3,9
    80007178:	04d70c63          	beq	a4,a3,800071d0 <devintr+0x84>
    8000717c:	fff00713          	li	a4,-1
    80007180:	03f71713          	slli	a4,a4,0x3f
    80007184:	00170713          	addi	a4,a4,1
    80007188:	00e78c63          	beq	a5,a4,800071a0 <devintr+0x54>
    8000718c:	01813083          	ld	ra,24(sp)
    80007190:	01013403          	ld	s0,16(sp)
    80007194:	00813483          	ld	s1,8(sp)
    80007198:	02010113          	addi	sp,sp,32
    8000719c:	00008067          	ret
    800071a0:	00000097          	auipc	ra,0x0
    800071a4:	c8c080e7          	jalr	-884(ra) # 80006e2c <cpuid>
    800071a8:	06050663          	beqz	a0,80007214 <devintr+0xc8>
    800071ac:	144027f3          	csrr	a5,sip
    800071b0:	ffd7f793          	andi	a5,a5,-3
    800071b4:	14479073          	csrw	sip,a5
    800071b8:	01813083          	ld	ra,24(sp)
    800071bc:	01013403          	ld	s0,16(sp)
    800071c0:	00813483          	ld	s1,8(sp)
    800071c4:	00200513          	li	a0,2
    800071c8:	02010113          	addi	sp,sp,32
    800071cc:	00008067          	ret
    800071d0:	00000097          	auipc	ra,0x0
    800071d4:	254080e7          	jalr	596(ra) # 80007424 <plic_claim>
    800071d8:	00a00793          	li	a5,10
    800071dc:	00050493          	mv	s1,a0
    800071e0:	06f50663          	beq	a0,a5,8000724c <devintr+0x100>
    800071e4:	00100513          	li	a0,1
    800071e8:	fa0482e3          	beqz	s1,8000718c <devintr+0x40>
    800071ec:	00048593          	mv	a1,s1
    800071f0:	00002517          	auipc	a0,0x2
    800071f4:	68850513          	addi	a0,a0,1672 # 80009878 <CONSOLE_STATUS+0x868>
    800071f8:	00000097          	auipc	ra,0x0
    800071fc:	670080e7          	jalr	1648(ra) # 80007868 <__printf>
    80007200:	00048513          	mv	a0,s1
    80007204:	00000097          	auipc	ra,0x0
    80007208:	258080e7          	jalr	600(ra) # 8000745c <plic_complete>
    8000720c:	00100513          	li	a0,1
    80007210:	f7dff06f          	j	8000718c <devintr+0x40>
    80007214:	00006517          	auipc	a0,0x6
    80007218:	0cc50513          	addi	a0,a0,204 # 8000d2e0 <tickslock>
    8000721c:	00001097          	auipc	ra,0x1
    80007220:	320080e7          	jalr	800(ra) # 8000853c <acquire>
    80007224:	00005717          	auipc	a4,0x5
    80007228:	d7070713          	addi	a4,a4,-656 # 8000bf94 <ticks>
    8000722c:	00072783          	lw	a5,0(a4)
    80007230:	00006517          	auipc	a0,0x6
    80007234:	0b050513          	addi	a0,a0,176 # 8000d2e0 <tickslock>
    80007238:	0017879b          	addiw	a5,a5,1
    8000723c:	00f72023          	sw	a5,0(a4)
    80007240:	00001097          	auipc	ra,0x1
    80007244:	3c8080e7          	jalr	968(ra) # 80008608 <release>
    80007248:	f65ff06f          	j	800071ac <devintr+0x60>
    8000724c:	00001097          	auipc	ra,0x1
    80007250:	f24080e7          	jalr	-220(ra) # 80008170 <uartintr>
    80007254:	fadff06f          	j	80007200 <devintr+0xb4>
	...

0000000080007260 <kernelvec>:
    80007260:	f0010113          	addi	sp,sp,-256
    80007264:	00113023          	sd	ra,0(sp)
    80007268:	00213423          	sd	sp,8(sp)
    8000726c:	00313823          	sd	gp,16(sp)
    80007270:	00413c23          	sd	tp,24(sp)
    80007274:	02513023          	sd	t0,32(sp)
    80007278:	02613423          	sd	t1,40(sp)
    8000727c:	02713823          	sd	t2,48(sp)
    80007280:	02813c23          	sd	s0,56(sp)
    80007284:	04913023          	sd	s1,64(sp)
    80007288:	04a13423          	sd	a0,72(sp)
    8000728c:	04b13823          	sd	a1,80(sp)
    80007290:	04c13c23          	sd	a2,88(sp)
    80007294:	06d13023          	sd	a3,96(sp)
    80007298:	06e13423          	sd	a4,104(sp)
    8000729c:	06f13823          	sd	a5,112(sp)
    800072a0:	07013c23          	sd	a6,120(sp)
    800072a4:	09113023          	sd	a7,128(sp)
    800072a8:	09213423          	sd	s2,136(sp)
    800072ac:	09313823          	sd	s3,144(sp)
    800072b0:	09413c23          	sd	s4,152(sp)
    800072b4:	0b513023          	sd	s5,160(sp)
    800072b8:	0b613423          	sd	s6,168(sp)
    800072bc:	0b713823          	sd	s7,176(sp)
    800072c0:	0b813c23          	sd	s8,184(sp)
    800072c4:	0d913023          	sd	s9,192(sp)
    800072c8:	0da13423          	sd	s10,200(sp)
    800072cc:	0db13823          	sd	s11,208(sp)
    800072d0:	0dc13c23          	sd	t3,216(sp)
    800072d4:	0fd13023          	sd	t4,224(sp)
    800072d8:	0fe13423          	sd	t5,232(sp)
    800072dc:	0ff13823          	sd	t6,240(sp)
    800072e0:	ccdff0ef          	jal	ra,80006fac <kerneltrap>
    800072e4:	00013083          	ld	ra,0(sp)
    800072e8:	00813103          	ld	sp,8(sp)
    800072ec:	01013183          	ld	gp,16(sp)
    800072f0:	02013283          	ld	t0,32(sp)
    800072f4:	02813303          	ld	t1,40(sp)
    800072f8:	03013383          	ld	t2,48(sp)
    800072fc:	03813403          	ld	s0,56(sp)
    80007300:	04013483          	ld	s1,64(sp)
    80007304:	04813503          	ld	a0,72(sp)
    80007308:	05013583          	ld	a1,80(sp)
    8000730c:	05813603          	ld	a2,88(sp)
    80007310:	06013683          	ld	a3,96(sp)
    80007314:	06813703          	ld	a4,104(sp)
    80007318:	07013783          	ld	a5,112(sp)
    8000731c:	07813803          	ld	a6,120(sp)
    80007320:	08013883          	ld	a7,128(sp)
    80007324:	08813903          	ld	s2,136(sp)
    80007328:	09013983          	ld	s3,144(sp)
    8000732c:	09813a03          	ld	s4,152(sp)
    80007330:	0a013a83          	ld	s5,160(sp)
    80007334:	0a813b03          	ld	s6,168(sp)
    80007338:	0b013b83          	ld	s7,176(sp)
    8000733c:	0b813c03          	ld	s8,184(sp)
    80007340:	0c013c83          	ld	s9,192(sp)
    80007344:	0c813d03          	ld	s10,200(sp)
    80007348:	0d013d83          	ld	s11,208(sp)
    8000734c:	0d813e03          	ld	t3,216(sp)
    80007350:	0e013e83          	ld	t4,224(sp)
    80007354:	0e813f03          	ld	t5,232(sp)
    80007358:	0f013f83          	ld	t6,240(sp)
    8000735c:	10010113          	addi	sp,sp,256
    80007360:	10200073          	sret
    80007364:	00000013          	nop
    80007368:	00000013          	nop
    8000736c:	00000013          	nop

0000000080007370 <timervec>:
    80007370:	34051573          	csrrw	a0,mscratch,a0
    80007374:	00b53023          	sd	a1,0(a0)
    80007378:	00c53423          	sd	a2,8(a0)
    8000737c:	00d53823          	sd	a3,16(a0)
    80007380:	01853583          	ld	a1,24(a0)
    80007384:	02053603          	ld	a2,32(a0)
    80007388:	0005b683          	ld	a3,0(a1)
    8000738c:	00c686b3          	add	a3,a3,a2
    80007390:	00d5b023          	sd	a3,0(a1)
    80007394:	00200593          	li	a1,2
    80007398:	14459073          	csrw	sip,a1
    8000739c:	01053683          	ld	a3,16(a0)
    800073a0:	00853603          	ld	a2,8(a0)
    800073a4:	00053583          	ld	a1,0(a0)
    800073a8:	34051573          	csrrw	a0,mscratch,a0
    800073ac:	30200073          	mret

00000000800073b0 <plicinit>:
    800073b0:	ff010113          	addi	sp,sp,-16
    800073b4:	00813423          	sd	s0,8(sp)
    800073b8:	01010413          	addi	s0,sp,16
    800073bc:	00813403          	ld	s0,8(sp)
    800073c0:	0c0007b7          	lui	a5,0xc000
    800073c4:	00100713          	li	a4,1
    800073c8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800073cc:	00e7a223          	sw	a4,4(a5)
    800073d0:	01010113          	addi	sp,sp,16
    800073d4:	00008067          	ret

00000000800073d8 <plicinithart>:
    800073d8:	ff010113          	addi	sp,sp,-16
    800073dc:	00813023          	sd	s0,0(sp)
    800073e0:	00113423          	sd	ra,8(sp)
    800073e4:	01010413          	addi	s0,sp,16
    800073e8:	00000097          	auipc	ra,0x0
    800073ec:	a44080e7          	jalr	-1468(ra) # 80006e2c <cpuid>
    800073f0:	0085171b          	slliw	a4,a0,0x8
    800073f4:	0c0027b7          	lui	a5,0xc002
    800073f8:	00e787b3          	add	a5,a5,a4
    800073fc:	40200713          	li	a4,1026
    80007400:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007404:	00813083          	ld	ra,8(sp)
    80007408:	00013403          	ld	s0,0(sp)
    8000740c:	00d5151b          	slliw	a0,a0,0xd
    80007410:	0c2017b7          	lui	a5,0xc201
    80007414:	00a78533          	add	a0,a5,a0
    80007418:	00052023          	sw	zero,0(a0)
    8000741c:	01010113          	addi	sp,sp,16
    80007420:	00008067          	ret

0000000080007424 <plic_claim>:
    80007424:	ff010113          	addi	sp,sp,-16
    80007428:	00813023          	sd	s0,0(sp)
    8000742c:	00113423          	sd	ra,8(sp)
    80007430:	01010413          	addi	s0,sp,16
    80007434:	00000097          	auipc	ra,0x0
    80007438:	9f8080e7          	jalr	-1544(ra) # 80006e2c <cpuid>
    8000743c:	00813083          	ld	ra,8(sp)
    80007440:	00013403          	ld	s0,0(sp)
    80007444:	00d5151b          	slliw	a0,a0,0xd
    80007448:	0c2017b7          	lui	a5,0xc201
    8000744c:	00a78533          	add	a0,a5,a0
    80007450:	00452503          	lw	a0,4(a0)
    80007454:	01010113          	addi	sp,sp,16
    80007458:	00008067          	ret

000000008000745c <plic_complete>:
    8000745c:	fe010113          	addi	sp,sp,-32
    80007460:	00813823          	sd	s0,16(sp)
    80007464:	00913423          	sd	s1,8(sp)
    80007468:	00113c23          	sd	ra,24(sp)
    8000746c:	02010413          	addi	s0,sp,32
    80007470:	00050493          	mv	s1,a0
    80007474:	00000097          	auipc	ra,0x0
    80007478:	9b8080e7          	jalr	-1608(ra) # 80006e2c <cpuid>
    8000747c:	01813083          	ld	ra,24(sp)
    80007480:	01013403          	ld	s0,16(sp)
    80007484:	00d5179b          	slliw	a5,a0,0xd
    80007488:	0c201737          	lui	a4,0xc201
    8000748c:	00f707b3          	add	a5,a4,a5
    80007490:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007494:	00813483          	ld	s1,8(sp)
    80007498:	02010113          	addi	sp,sp,32
    8000749c:	00008067          	ret

00000000800074a0 <consolewrite>:
    800074a0:	fb010113          	addi	sp,sp,-80
    800074a4:	04813023          	sd	s0,64(sp)
    800074a8:	04113423          	sd	ra,72(sp)
    800074ac:	02913c23          	sd	s1,56(sp)
    800074b0:	03213823          	sd	s2,48(sp)
    800074b4:	03313423          	sd	s3,40(sp)
    800074b8:	03413023          	sd	s4,32(sp)
    800074bc:	01513c23          	sd	s5,24(sp)
    800074c0:	05010413          	addi	s0,sp,80
    800074c4:	06c05c63          	blez	a2,8000753c <consolewrite+0x9c>
    800074c8:	00060993          	mv	s3,a2
    800074cc:	00050a13          	mv	s4,a0
    800074d0:	00058493          	mv	s1,a1
    800074d4:	00000913          	li	s2,0
    800074d8:	fff00a93          	li	s5,-1
    800074dc:	01c0006f          	j	800074f8 <consolewrite+0x58>
    800074e0:	fbf44503          	lbu	a0,-65(s0)
    800074e4:	0019091b          	addiw	s2,s2,1
    800074e8:	00148493          	addi	s1,s1,1
    800074ec:	00001097          	auipc	ra,0x1
    800074f0:	a9c080e7          	jalr	-1380(ra) # 80007f88 <uartputc>
    800074f4:	03298063          	beq	s3,s2,80007514 <consolewrite+0x74>
    800074f8:	00048613          	mv	a2,s1
    800074fc:	00100693          	li	a3,1
    80007500:	000a0593          	mv	a1,s4
    80007504:	fbf40513          	addi	a0,s0,-65
    80007508:	00000097          	auipc	ra,0x0
    8000750c:	9dc080e7          	jalr	-1572(ra) # 80006ee4 <either_copyin>
    80007510:	fd5518e3          	bne	a0,s5,800074e0 <consolewrite+0x40>
    80007514:	04813083          	ld	ra,72(sp)
    80007518:	04013403          	ld	s0,64(sp)
    8000751c:	03813483          	ld	s1,56(sp)
    80007520:	02813983          	ld	s3,40(sp)
    80007524:	02013a03          	ld	s4,32(sp)
    80007528:	01813a83          	ld	s5,24(sp)
    8000752c:	00090513          	mv	a0,s2
    80007530:	03013903          	ld	s2,48(sp)
    80007534:	05010113          	addi	sp,sp,80
    80007538:	00008067          	ret
    8000753c:	00000913          	li	s2,0
    80007540:	fd5ff06f          	j	80007514 <consolewrite+0x74>

0000000080007544 <consoleread>:
    80007544:	f9010113          	addi	sp,sp,-112
    80007548:	06813023          	sd	s0,96(sp)
    8000754c:	04913c23          	sd	s1,88(sp)
    80007550:	05213823          	sd	s2,80(sp)
    80007554:	05313423          	sd	s3,72(sp)
    80007558:	05413023          	sd	s4,64(sp)
    8000755c:	03513c23          	sd	s5,56(sp)
    80007560:	03613823          	sd	s6,48(sp)
    80007564:	03713423          	sd	s7,40(sp)
    80007568:	03813023          	sd	s8,32(sp)
    8000756c:	06113423          	sd	ra,104(sp)
    80007570:	01913c23          	sd	s9,24(sp)
    80007574:	07010413          	addi	s0,sp,112
    80007578:	00060b93          	mv	s7,a2
    8000757c:	00050913          	mv	s2,a0
    80007580:	00058c13          	mv	s8,a1
    80007584:	00060b1b          	sext.w	s6,a2
    80007588:	00006497          	auipc	s1,0x6
    8000758c:	d8048493          	addi	s1,s1,-640 # 8000d308 <cons>
    80007590:	00400993          	li	s3,4
    80007594:	fff00a13          	li	s4,-1
    80007598:	00a00a93          	li	s5,10
    8000759c:	05705e63          	blez	s7,800075f8 <consoleread+0xb4>
    800075a0:	09c4a703          	lw	a4,156(s1)
    800075a4:	0984a783          	lw	a5,152(s1)
    800075a8:	0007071b          	sext.w	a4,a4
    800075ac:	08e78463          	beq	a5,a4,80007634 <consoleread+0xf0>
    800075b0:	07f7f713          	andi	a4,a5,127
    800075b4:	00e48733          	add	a4,s1,a4
    800075b8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800075bc:	0017869b          	addiw	a3,a5,1
    800075c0:	08d4ac23          	sw	a3,152(s1)
    800075c4:	00070c9b          	sext.w	s9,a4
    800075c8:	0b370663          	beq	a4,s3,80007674 <consoleread+0x130>
    800075cc:	00100693          	li	a3,1
    800075d0:	f9f40613          	addi	a2,s0,-97
    800075d4:	000c0593          	mv	a1,s8
    800075d8:	00090513          	mv	a0,s2
    800075dc:	f8e40fa3          	sb	a4,-97(s0)
    800075e0:	00000097          	auipc	ra,0x0
    800075e4:	8b8080e7          	jalr	-1864(ra) # 80006e98 <either_copyout>
    800075e8:	01450863          	beq	a0,s4,800075f8 <consoleread+0xb4>
    800075ec:	001c0c13          	addi	s8,s8,1
    800075f0:	fffb8b9b          	addiw	s7,s7,-1
    800075f4:	fb5c94e3          	bne	s9,s5,8000759c <consoleread+0x58>
    800075f8:	000b851b          	sext.w	a0,s7
    800075fc:	06813083          	ld	ra,104(sp)
    80007600:	06013403          	ld	s0,96(sp)
    80007604:	05813483          	ld	s1,88(sp)
    80007608:	05013903          	ld	s2,80(sp)
    8000760c:	04813983          	ld	s3,72(sp)
    80007610:	04013a03          	ld	s4,64(sp)
    80007614:	03813a83          	ld	s5,56(sp)
    80007618:	02813b83          	ld	s7,40(sp)
    8000761c:	02013c03          	ld	s8,32(sp)
    80007620:	01813c83          	ld	s9,24(sp)
    80007624:	40ab053b          	subw	a0,s6,a0
    80007628:	03013b03          	ld	s6,48(sp)
    8000762c:	07010113          	addi	sp,sp,112
    80007630:	00008067          	ret
    80007634:	00001097          	auipc	ra,0x1
    80007638:	1d8080e7          	jalr	472(ra) # 8000880c <push_on>
    8000763c:	0984a703          	lw	a4,152(s1)
    80007640:	09c4a783          	lw	a5,156(s1)
    80007644:	0007879b          	sext.w	a5,a5
    80007648:	fef70ce3          	beq	a4,a5,80007640 <consoleread+0xfc>
    8000764c:	00001097          	auipc	ra,0x1
    80007650:	234080e7          	jalr	564(ra) # 80008880 <pop_on>
    80007654:	0984a783          	lw	a5,152(s1)
    80007658:	07f7f713          	andi	a4,a5,127
    8000765c:	00e48733          	add	a4,s1,a4
    80007660:	01874703          	lbu	a4,24(a4)
    80007664:	0017869b          	addiw	a3,a5,1
    80007668:	08d4ac23          	sw	a3,152(s1)
    8000766c:	00070c9b          	sext.w	s9,a4
    80007670:	f5371ee3          	bne	a4,s3,800075cc <consoleread+0x88>
    80007674:	000b851b          	sext.w	a0,s7
    80007678:	f96bf2e3          	bgeu	s7,s6,800075fc <consoleread+0xb8>
    8000767c:	08f4ac23          	sw	a5,152(s1)
    80007680:	f7dff06f          	j	800075fc <consoleread+0xb8>

0000000080007684 <consputc>:
    80007684:	10000793          	li	a5,256
    80007688:	00f50663          	beq	a0,a5,80007694 <consputc+0x10>
    8000768c:	00001317          	auipc	t1,0x1
    80007690:	9f430067          	jr	-1548(t1) # 80008080 <uartputc_sync>
    80007694:	ff010113          	addi	sp,sp,-16
    80007698:	00113423          	sd	ra,8(sp)
    8000769c:	00813023          	sd	s0,0(sp)
    800076a0:	01010413          	addi	s0,sp,16
    800076a4:	00800513          	li	a0,8
    800076a8:	00001097          	auipc	ra,0x1
    800076ac:	9d8080e7          	jalr	-1576(ra) # 80008080 <uartputc_sync>
    800076b0:	02000513          	li	a0,32
    800076b4:	00001097          	auipc	ra,0x1
    800076b8:	9cc080e7          	jalr	-1588(ra) # 80008080 <uartputc_sync>
    800076bc:	00013403          	ld	s0,0(sp)
    800076c0:	00813083          	ld	ra,8(sp)
    800076c4:	00800513          	li	a0,8
    800076c8:	01010113          	addi	sp,sp,16
    800076cc:	00001317          	auipc	t1,0x1
    800076d0:	9b430067          	jr	-1612(t1) # 80008080 <uartputc_sync>

00000000800076d4 <consoleintr>:
    800076d4:	fe010113          	addi	sp,sp,-32
    800076d8:	00813823          	sd	s0,16(sp)
    800076dc:	00913423          	sd	s1,8(sp)
    800076e0:	01213023          	sd	s2,0(sp)
    800076e4:	00113c23          	sd	ra,24(sp)
    800076e8:	02010413          	addi	s0,sp,32
    800076ec:	00006917          	auipc	s2,0x6
    800076f0:	c1c90913          	addi	s2,s2,-996 # 8000d308 <cons>
    800076f4:	00050493          	mv	s1,a0
    800076f8:	00090513          	mv	a0,s2
    800076fc:	00001097          	auipc	ra,0x1
    80007700:	e40080e7          	jalr	-448(ra) # 8000853c <acquire>
    80007704:	02048c63          	beqz	s1,8000773c <consoleintr+0x68>
    80007708:	0a092783          	lw	a5,160(s2)
    8000770c:	09892703          	lw	a4,152(s2)
    80007710:	07f00693          	li	a3,127
    80007714:	40e7873b          	subw	a4,a5,a4
    80007718:	02e6e263          	bltu	a3,a4,8000773c <consoleintr+0x68>
    8000771c:	00d00713          	li	a4,13
    80007720:	04e48063          	beq	s1,a4,80007760 <consoleintr+0x8c>
    80007724:	07f7f713          	andi	a4,a5,127
    80007728:	00e90733          	add	a4,s2,a4
    8000772c:	0017879b          	addiw	a5,a5,1
    80007730:	0af92023          	sw	a5,160(s2)
    80007734:	00970c23          	sb	s1,24(a4)
    80007738:	08f92e23          	sw	a5,156(s2)
    8000773c:	01013403          	ld	s0,16(sp)
    80007740:	01813083          	ld	ra,24(sp)
    80007744:	00813483          	ld	s1,8(sp)
    80007748:	00013903          	ld	s2,0(sp)
    8000774c:	00006517          	auipc	a0,0x6
    80007750:	bbc50513          	addi	a0,a0,-1092 # 8000d308 <cons>
    80007754:	02010113          	addi	sp,sp,32
    80007758:	00001317          	auipc	t1,0x1
    8000775c:	eb030067          	jr	-336(t1) # 80008608 <release>
    80007760:	00a00493          	li	s1,10
    80007764:	fc1ff06f          	j	80007724 <consoleintr+0x50>

0000000080007768 <consoleinit>:
    80007768:	fe010113          	addi	sp,sp,-32
    8000776c:	00113c23          	sd	ra,24(sp)
    80007770:	00813823          	sd	s0,16(sp)
    80007774:	00913423          	sd	s1,8(sp)
    80007778:	02010413          	addi	s0,sp,32
    8000777c:	00006497          	auipc	s1,0x6
    80007780:	b8c48493          	addi	s1,s1,-1140 # 8000d308 <cons>
    80007784:	00048513          	mv	a0,s1
    80007788:	00002597          	auipc	a1,0x2
    8000778c:	14858593          	addi	a1,a1,328 # 800098d0 <CONSOLE_STATUS+0x8c0>
    80007790:	00001097          	auipc	ra,0x1
    80007794:	d88080e7          	jalr	-632(ra) # 80008518 <initlock>
    80007798:	00000097          	auipc	ra,0x0
    8000779c:	7ac080e7          	jalr	1964(ra) # 80007f44 <uartinit>
    800077a0:	01813083          	ld	ra,24(sp)
    800077a4:	01013403          	ld	s0,16(sp)
    800077a8:	00000797          	auipc	a5,0x0
    800077ac:	d9c78793          	addi	a5,a5,-612 # 80007544 <consoleread>
    800077b0:	0af4bc23          	sd	a5,184(s1)
    800077b4:	00000797          	auipc	a5,0x0
    800077b8:	cec78793          	addi	a5,a5,-788 # 800074a0 <consolewrite>
    800077bc:	0cf4b023          	sd	a5,192(s1)
    800077c0:	00813483          	ld	s1,8(sp)
    800077c4:	02010113          	addi	sp,sp,32
    800077c8:	00008067          	ret

00000000800077cc <console_read>:
    800077cc:	ff010113          	addi	sp,sp,-16
    800077d0:	00813423          	sd	s0,8(sp)
    800077d4:	01010413          	addi	s0,sp,16
    800077d8:	00813403          	ld	s0,8(sp)
    800077dc:	00006317          	auipc	t1,0x6
    800077e0:	be433303          	ld	t1,-1052(t1) # 8000d3c0 <devsw+0x10>
    800077e4:	01010113          	addi	sp,sp,16
    800077e8:	00030067          	jr	t1

00000000800077ec <console_write>:
    800077ec:	ff010113          	addi	sp,sp,-16
    800077f0:	00813423          	sd	s0,8(sp)
    800077f4:	01010413          	addi	s0,sp,16
    800077f8:	00813403          	ld	s0,8(sp)
    800077fc:	00006317          	auipc	t1,0x6
    80007800:	bcc33303          	ld	t1,-1076(t1) # 8000d3c8 <devsw+0x18>
    80007804:	01010113          	addi	sp,sp,16
    80007808:	00030067          	jr	t1

000000008000780c <panic>:
    8000780c:	fe010113          	addi	sp,sp,-32
    80007810:	00113c23          	sd	ra,24(sp)
    80007814:	00813823          	sd	s0,16(sp)
    80007818:	00913423          	sd	s1,8(sp)
    8000781c:	02010413          	addi	s0,sp,32
    80007820:	00050493          	mv	s1,a0
    80007824:	00002517          	auipc	a0,0x2
    80007828:	0b450513          	addi	a0,a0,180 # 800098d8 <CONSOLE_STATUS+0x8c8>
    8000782c:	00006797          	auipc	a5,0x6
    80007830:	c207ae23          	sw	zero,-964(a5) # 8000d468 <pr+0x18>
    80007834:	00000097          	auipc	ra,0x0
    80007838:	034080e7          	jalr	52(ra) # 80007868 <__printf>
    8000783c:	00048513          	mv	a0,s1
    80007840:	00000097          	auipc	ra,0x0
    80007844:	028080e7          	jalr	40(ra) # 80007868 <__printf>
    80007848:	00002517          	auipc	a0,0x2
    8000784c:	b5050513          	addi	a0,a0,-1200 # 80009398 <CONSOLE_STATUS+0x388>
    80007850:	00000097          	auipc	ra,0x0
    80007854:	018080e7          	jalr	24(ra) # 80007868 <__printf>
    80007858:	00100793          	li	a5,1
    8000785c:	00004717          	auipc	a4,0x4
    80007860:	72f72e23          	sw	a5,1852(a4) # 8000bf98 <panicked>
    80007864:	0000006f          	j	80007864 <panic+0x58>

0000000080007868 <__printf>:
    80007868:	f3010113          	addi	sp,sp,-208
    8000786c:	08813023          	sd	s0,128(sp)
    80007870:	07313423          	sd	s3,104(sp)
    80007874:	09010413          	addi	s0,sp,144
    80007878:	05813023          	sd	s8,64(sp)
    8000787c:	08113423          	sd	ra,136(sp)
    80007880:	06913c23          	sd	s1,120(sp)
    80007884:	07213823          	sd	s2,112(sp)
    80007888:	07413023          	sd	s4,96(sp)
    8000788c:	05513c23          	sd	s5,88(sp)
    80007890:	05613823          	sd	s6,80(sp)
    80007894:	05713423          	sd	s7,72(sp)
    80007898:	03913c23          	sd	s9,56(sp)
    8000789c:	03a13823          	sd	s10,48(sp)
    800078a0:	03b13423          	sd	s11,40(sp)
    800078a4:	00006317          	auipc	t1,0x6
    800078a8:	bac30313          	addi	t1,t1,-1108 # 8000d450 <pr>
    800078ac:	01832c03          	lw	s8,24(t1)
    800078b0:	00b43423          	sd	a1,8(s0)
    800078b4:	00c43823          	sd	a2,16(s0)
    800078b8:	00d43c23          	sd	a3,24(s0)
    800078bc:	02e43023          	sd	a4,32(s0)
    800078c0:	02f43423          	sd	a5,40(s0)
    800078c4:	03043823          	sd	a6,48(s0)
    800078c8:	03143c23          	sd	a7,56(s0)
    800078cc:	00050993          	mv	s3,a0
    800078d0:	4a0c1663          	bnez	s8,80007d7c <__printf+0x514>
    800078d4:	60098c63          	beqz	s3,80007eec <__printf+0x684>
    800078d8:	0009c503          	lbu	a0,0(s3)
    800078dc:	00840793          	addi	a5,s0,8
    800078e0:	f6f43c23          	sd	a5,-136(s0)
    800078e4:	00000493          	li	s1,0
    800078e8:	22050063          	beqz	a0,80007b08 <__printf+0x2a0>
    800078ec:	00002a37          	lui	s4,0x2
    800078f0:	00018ab7          	lui	s5,0x18
    800078f4:	000f4b37          	lui	s6,0xf4
    800078f8:	00989bb7          	lui	s7,0x989
    800078fc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007900:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007904:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007908:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000790c:	00148c9b          	addiw	s9,s1,1
    80007910:	02500793          	li	a5,37
    80007914:	01998933          	add	s2,s3,s9
    80007918:	38f51263          	bne	a0,a5,80007c9c <__printf+0x434>
    8000791c:	00094783          	lbu	a5,0(s2)
    80007920:	00078c9b          	sext.w	s9,a5
    80007924:	1e078263          	beqz	a5,80007b08 <__printf+0x2a0>
    80007928:	0024849b          	addiw	s1,s1,2
    8000792c:	07000713          	li	a4,112
    80007930:	00998933          	add	s2,s3,s1
    80007934:	38e78a63          	beq	a5,a4,80007cc8 <__printf+0x460>
    80007938:	20f76863          	bltu	a4,a5,80007b48 <__printf+0x2e0>
    8000793c:	42a78863          	beq	a5,a0,80007d6c <__printf+0x504>
    80007940:	06400713          	li	a4,100
    80007944:	40e79663          	bne	a5,a4,80007d50 <__printf+0x4e8>
    80007948:	f7843783          	ld	a5,-136(s0)
    8000794c:	0007a603          	lw	a2,0(a5)
    80007950:	00878793          	addi	a5,a5,8
    80007954:	f6f43c23          	sd	a5,-136(s0)
    80007958:	42064a63          	bltz	a2,80007d8c <__printf+0x524>
    8000795c:	00a00713          	li	a4,10
    80007960:	02e677bb          	remuw	a5,a2,a4
    80007964:	00002d97          	auipc	s11,0x2
    80007968:	f9cd8d93          	addi	s11,s11,-100 # 80009900 <digits>
    8000796c:	00900593          	li	a1,9
    80007970:	0006051b          	sext.w	a0,a2
    80007974:	00000c93          	li	s9,0
    80007978:	02079793          	slli	a5,a5,0x20
    8000797c:	0207d793          	srli	a5,a5,0x20
    80007980:	00fd87b3          	add	a5,s11,a5
    80007984:	0007c783          	lbu	a5,0(a5)
    80007988:	02e656bb          	divuw	a3,a2,a4
    8000798c:	f8f40023          	sb	a5,-128(s0)
    80007990:	14c5d863          	bge	a1,a2,80007ae0 <__printf+0x278>
    80007994:	06300593          	li	a1,99
    80007998:	00100c93          	li	s9,1
    8000799c:	02e6f7bb          	remuw	a5,a3,a4
    800079a0:	02079793          	slli	a5,a5,0x20
    800079a4:	0207d793          	srli	a5,a5,0x20
    800079a8:	00fd87b3          	add	a5,s11,a5
    800079ac:	0007c783          	lbu	a5,0(a5)
    800079b0:	02e6d73b          	divuw	a4,a3,a4
    800079b4:	f8f400a3          	sb	a5,-127(s0)
    800079b8:	12a5f463          	bgeu	a1,a0,80007ae0 <__printf+0x278>
    800079bc:	00a00693          	li	a3,10
    800079c0:	00900593          	li	a1,9
    800079c4:	02d777bb          	remuw	a5,a4,a3
    800079c8:	02079793          	slli	a5,a5,0x20
    800079cc:	0207d793          	srli	a5,a5,0x20
    800079d0:	00fd87b3          	add	a5,s11,a5
    800079d4:	0007c503          	lbu	a0,0(a5)
    800079d8:	02d757bb          	divuw	a5,a4,a3
    800079dc:	f8a40123          	sb	a0,-126(s0)
    800079e0:	48e5f263          	bgeu	a1,a4,80007e64 <__printf+0x5fc>
    800079e4:	06300513          	li	a0,99
    800079e8:	02d7f5bb          	remuw	a1,a5,a3
    800079ec:	02059593          	slli	a1,a1,0x20
    800079f0:	0205d593          	srli	a1,a1,0x20
    800079f4:	00bd85b3          	add	a1,s11,a1
    800079f8:	0005c583          	lbu	a1,0(a1)
    800079fc:	02d7d7bb          	divuw	a5,a5,a3
    80007a00:	f8b401a3          	sb	a1,-125(s0)
    80007a04:	48e57263          	bgeu	a0,a4,80007e88 <__printf+0x620>
    80007a08:	3e700513          	li	a0,999
    80007a0c:	02d7f5bb          	remuw	a1,a5,a3
    80007a10:	02059593          	slli	a1,a1,0x20
    80007a14:	0205d593          	srli	a1,a1,0x20
    80007a18:	00bd85b3          	add	a1,s11,a1
    80007a1c:	0005c583          	lbu	a1,0(a1)
    80007a20:	02d7d7bb          	divuw	a5,a5,a3
    80007a24:	f8b40223          	sb	a1,-124(s0)
    80007a28:	46e57663          	bgeu	a0,a4,80007e94 <__printf+0x62c>
    80007a2c:	02d7f5bb          	remuw	a1,a5,a3
    80007a30:	02059593          	slli	a1,a1,0x20
    80007a34:	0205d593          	srli	a1,a1,0x20
    80007a38:	00bd85b3          	add	a1,s11,a1
    80007a3c:	0005c583          	lbu	a1,0(a1)
    80007a40:	02d7d7bb          	divuw	a5,a5,a3
    80007a44:	f8b402a3          	sb	a1,-123(s0)
    80007a48:	46ea7863          	bgeu	s4,a4,80007eb8 <__printf+0x650>
    80007a4c:	02d7f5bb          	remuw	a1,a5,a3
    80007a50:	02059593          	slli	a1,a1,0x20
    80007a54:	0205d593          	srli	a1,a1,0x20
    80007a58:	00bd85b3          	add	a1,s11,a1
    80007a5c:	0005c583          	lbu	a1,0(a1)
    80007a60:	02d7d7bb          	divuw	a5,a5,a3
    80007a64:	f8b40323          	sb	a1,-122(s0)
    80007a68:	3eeaf863          	bgeu	s5,a4,80007e58 <__printf+0x5f0>
    80007a6c:	02d7f5bb          	remuw	a1,a5,a3
    80007a70:	02059593          	slli	a1,a1,0x20
    80007a74:	0205d593          	srli	a1,a1,0x20
    80007a78:	00bd85b3          	add	a1,s11,a1
    80007a7c:	0005c583          	lbu	a1,0(a1)
    80007a80:	02d7d7bb          	divuw	a5,a5,a3
    80007a84:	f8b403a3          	sb	a1,-121(s0)
    80007a88:	42eb7e63          	bgeu	s6,a4,80007ec4 <__printf+0x65c>
    80007a8c:	02d7f5bb          	remuw	a1,a5,a3
    80007a90:	02059593          	slli	a1,a1,0x20
    80007a94:	0205d593          	srli	a1,a1,0x20
    80007a98:	00bd85b3          	add	a1,s11,a1
    80007a9c:	0005c583          	lbu	a1,0(a1)
    80007aa0:	02d7d7bb          	divuw	a5,a5,a3
    80007aa4:	f8b40423          	sb	a1,-120(s0)
    80007aa8:	42ebfc63          	bgeu	s7,a4,80007ee0 <__printf+0x678>
    80007aac:	02079793          	slli	a5,a5,0x20
    80007ab0:	0207d793          	srli	a5,a5,0x20
    80007ab4:	00fd8db3          	add	s11,s11,a5
    80007ab8:	000dc703          	lbu	a4,0(s11)
    80007abc:	00a00793          	li	a5,10
    80007ac0:	00900c93          	li	s9,9
    80007ac4:	f8e404a3          	sb	a4,-119(s0)
    80007ac8:	00065c63          	bgez	a2,80007ae0 <__printf+0x278>
    80007acc:	f9040713          	addi	a4,s0,-112
    80007ad0:	00f70733          	add	a4,a4,a5
    80007ad4:	02d00693          	li	a3,45
    80007ad8:	fed70823          	sb	a3,-16(a4)
    80007adc:	00078c93          	mv	s9,a5
    80007ae0:	f8040793          	addi	a5,s0,-128
    80007ae4:	01978cb3          	add	s9,a5,s9
    80007ae8:	f7f40d13          	addi	s10,s0,-129
    80007aec:	000cc503          	lbu	a0,0(s9)
    80007af0:	fffc8c93          	addi	s9,s9,-1
    80007af4:	00000097          	auipc	ra,0x0
    80007af8:	b90080e7          	jalr	-1136(ra) # 80007684 <consputc>
    80007afc:	ffac98e3          	bne	s9,s10,80007aec <__printf+0x284>
    80007b00:	00094503          	lbu	a0,0(s2)
    80007b04:	e00514e3          	bnez	a0,8000790c <__printf+0xa4>
    80007b08:	1a0c1663          	bnez	s8,80007cb4 <__printf+0x44c>
    80007b0c:	08813083          	ld	ra,136(sp)
    80007b10:	08013403          	ld	s0,128(sp)
    80007b14:	07813483          	ld	s1,120(sp)
    80007b18:	07013903          	ld	s2,112(sp)
    80007b1c:	06813983          	ld	s3,104(sp)
    80007b20:	06013a03          	ld	s4,96(sp)
    80007b24:	05813a83          	ld	s5,88(sp)
    80007b28:	05013b03          	ld	s6,80(sp)
    80007b2c:	04813b83          	ld	s7,72(sp)
    80007b30:	04013c03          	ld	s8,64(sp)
    80007b34:	03813c83          	ld	s9,56(sp)
    80007b38:	03013d03          	ld	s10,48(sp)
    80007b3c:	02813d83          	ld	s11,40(sp)
    80007b40:	0d010113          	addi	sp,sp,208
    80007b44:	00008067          	ret
    80007b48:	07300713          	li	a4,115
    80007b4c:	1ce78a63          	beq	a5,a4,80007d20 <__printf+0x4b8>
    80007b50:	07800713          	li	a4,120
    80007b54:	1ee79e63          	bne	a5,a4,80007d50 <__printf+0x4e8>
    80007b58:	f7843783          	ld	a5,-136(s0)
    80007b5c:	0007a703          	lw	a4,0(a5)
    80007b60:	00878793          	addi	a5,a5,8
    80007b64:	f6f43c23          	sd	a5,-136(s0)
    80007b68:	28074263          	bltz	a4,80007dec <__printf+0x584>
    80007b6c:	00002d97          	auipc	s11,0x2
    80007b70:	d94d8d93          	addi	s11,s11,-620 # 80009900 <digits>
    80007b74:	00f77793          	andi	a5,a4,15
    80007b78:	00fd87b3          	add	a5,s11,a5
    80007b7c:	0007c683          	lbu	a3,0(a5)
    80007b80:	00f00613          	li	a2,15
    80007b84:	0007079b          	sext.w	a5,a4
    80007b88:	f8d40023          	sb	a3,-128(s0)
    80007b8c:	0047559b          	srliw	a1,a4,0x4
    80007b90:	0047569b          	srliw	a3,a4,0x4
    80007b94:	00000c93          	li	s9,0
    80007b98:	0ee65063          	bge	a2,a4,80007c78 <__printf+0x410>
    80007b9c:	00f6f693          	andi	a3,a3,15
    80007ba0:	00dd86b3          	add	a3,s11,a3
    80007ba4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007ba8:	0087d79b          	srliw	a5,a5,0x8
    80007bac:	00100c93          	li	s9,1
    80007bb0:	f8d400a3          	sb	a3,-127(s0)
    80007bb4:	0cb67263          	bgeu	a2,a1,80007c78 <__printf+0x410>
    80007bb8:	00f7f693          	andi	a3,a5,15
    80007bbc:	00dd86b3          	add	a3,s11,a3
    80007bc0:	0006c583          	lbu	a1,0(a3)
    80007bc4:	00f00613          	li	a2,15
    80007bc8:	0047d69b          	srliw	a3,a5,0x4
    80007bcc:	f8b40123          	sb	a1,-126(s0)
    80007bd0:	0047d593          	srli	a1,a5,0x4
    80007bd4:	28f67e63          	bgeu	a2,a5,80007e70 <__printf+0x608>
    80007bd8:	00f6f693          	andi	a3,a3,15
    80007bdc:	00dd86b3          	add	a3,s11,a3
    80007be0:	0006c503          	lbu	a0,0(a3)
    80007be4:	0087d813          	srli	a6,a5,0x8
    80007be8:	0087d69b          	srliw	a3,a5,0x8
    80007bec:	f8a401a3          	sb	a0,-125(s0)
    80007bf0:	28b67663          	bgeu	a2,a1,80007e7c <__printf+0x614>
    80007bf4:	00f6f693          	andi	a3,a3,15
    80007bf8:	00dd86b3          	add	a3,s11,a3
    80007bfc:	0006c583          	lbu	a1,0(a3)
    80007c00:	00c7d513          	srli	a0,a5,0xc
    80007c04:	00c7d69b          	srliw	a3,a5,0xc
    80007c08:	f8b40223          	sb	a1,-124(s0)
    80007c0c:	29067a63          	bgeu	a2,a6,80007ea0 <__printf+0x638>
    80007c10:	00f6f693          	andi	a3,a3,15
    80007c14:	00dd86b3          	add	a3,s11,a3
    80007c18:	0006c583          	lbu	a1,0(a3)
    80007c1c:	0107d813          	srli	a6,a5,0x10
    80007c20:	0107d69b          	srliw	a3,a5,0x10
    80007c24:	f8b402a3          	sb	a1,-123(s0)
    80007c28:	28a67263          	bgeu	a2,a0,80007eac <__printf+0x644>
    80007c2c:	00f6f693          	andi	a3,a3,15
    80007c30:	00dd86b3          	add	a3,s11,a3
    80007c34:	0006c683          	lbu	a3,0(a3)
    80007c38:	0147d79b          	srliw	a5,a5,0x14
    80007c3c:	f8d40323          	sb	a3,-122(s0)
    80007c40:	21067663          	bgeu	a2,a6,80007e4c <__printf+0x5e4>
    80007c44:	02079793          	slli	a5,a5,0x20
    80007c48:	0207d793          	srli	a5,a5,0x20
    80007c4c:	00fd8db3          	add	s11,s11,a5
    80007c50:	000dc683          	lbu	a3,0(s11)
    80007c54:	00800793          	li	a5,8
    80007c58:	00700c93          	li	s9,7
    80007c5c:	f8d403a3          	sb	a3,-121(s0)
    80007c60:	00075c63          	bgez	a4,80007c78 <__printf+0x410>
    80007c64:	f9040713          	addi	a4,s0,-112
    80007c68:	00f70733          	add	a4,a4,a5
    80007c6c:	02d00693          	li	a3,45
    80007c70:	fed70823          	sb	a3,-16(a4)
    80007c74:	00078c93          	mv	s9,a5
    80007c78:	f8040793          	addi	a5,s0,-128
    80007c7c:	01978cb3          	add	s9,a5,s9
    80007c80:	f7f40d13          	addi	s10,s0,-129
    80007c84:	000cc503          	lbu	a0,0(s9)
    80007c88:	fffc8c93          	addi	s9,s9,-1
    80007c8c:	00000097          	auipc	ra,0x0
    80007c90:	9f8080e7          	jalr	-1544(ra) # 80007684 <consputc>
    80007c94:	ff9d18e3          	bne	s10,s9,80007c84 <__printf+0x41c>
    80007c98:	0100006f          	j	80007ca8 <__printf+0x440>
    80007c9c:	00000097          	auipc	ra,0x0
    80007ca0:	9e8080e7          	jalr	-1560(ra) # 80007684 <consputc>
    80007ca4:	000c8493          	mv	s1,s9
    80007ca8:	00094503          	lbu	a0,0(s2)
    80007cac:	c60510e3          	bnez	a0,8000790c <__printf+0xa4>
    80007cb0:	e40c0ee3          	beqz	s8,80007b0c <__printf+0x2a4>
    80007cb4:	00005517          	auipc	a0,0x5
    80007cb8:	79c50513          	addi	a0,a0,1948 # 8000d450 <pr>
    80007cbc:	00001097          	auipc	ra,0x1
    80007cc0:	94c080e7          	jalr	-1716(ra) # 80008608 <release>
    80007cc4:	e49ff06f          	j	80007b0c <__printf+0x2a4>
    80007cc8:	f7843783          	ld	a5,-136(s0)
    80007ccc:	03000513          	li	a0,48
    80007cd0:	01000d13          	li	s10,16
    80007cd4:	00878713          	addi	a4,a5,8
    80007cd8:	0007bc83          	ld	s9,0(a5)
    80007cdc:	f6e43c23          	sd	a4,-136(s0)
    80007ce0:	00000097          	auipc	ra,0x0
    80007ce4:	9a4080e7          	jalr	-1628(ra) # 80007684 <consputc>
    80007ce8:	07800513          	li	a0,120
    80007cec:	00000097          	auipc	ra,0x0
    80007cf0:	998080e7          	jalr	-1640(ra) # 80007684 <consputc>
    80007cf4:	00002d97          	auipc	s11,0x2
    80007cf8:	c0cd8d93          	addi	s11,s11,-1012 # 80009900 <digits>
    80007cfc:	03ccd793          	srli	a5,s9,0x3c
    80007d00:	00fd87b3          	add	a5,s11,a5
    80007d04:	0007c503          	lbu	a0,0(a5)
    80007d08:	fffd0d1b          	addiw	s10,s10,-1
    80007d0c:	004c9c93          	slli	s9,s9,0x4
    80007d10:	00000097          	auipc	ra,0x0
    80007d14:	974080e7          	jalr	-1676(ra) # 80007684 <consputc>
    80007d18:	fe0d12e3          	bnez	s10,80007cfc <__printf+0x494>
    80007d1c:	f8dff06f          	j	80007ca8 <__printf+0x440>
    80007d20:	f7843783          	ld	a5,-136(s0)
    80007d24:	0007bc83          	ld	s9,0(a5)
    80007d28:	00878793          	addi	a5,a5,8
    80007d2c:	f6f43c23          	sd	a5,-136(s0)
    80007d30:	000c9a63          	bnez	s9,80007d44 <__printf+0x4dc>
    80007d34:	1080006f          	j	80007e3c <__printf+0x5d4>
    80007d38:	001c8c93          	addi	s9,s9,1
    80007d3c:	00000097          	auipc	ra,0x0
    80007d40:	948080e7          	jalr	-1720(ra) # 80007684 <consputc>
    80007d44:	000cc503          	lbu	a0,0(s9)
    80007d48:	fe0518e3          	bnez	a0,80007d38 <__printf+0x4d0>
    80007d4c:	f5dff06f          	j	80007ca8 <__printf+0x440>
    80007d50:	02500513          	li	a0,37
    80007d54:	00000097          	auipc	ra,0x0
    80007d58:	930080e7          	jalr	-1744(ra) # 80007684 <consputc>
    80007d5c:	000c8513          	mv	a0,s9
    80007d60:	00000097          	auipc	ra,0x0
    80007d64:	924080e7          	jalr	-1756(ra) # 80007684 <consputc>
    80007d68:	f41ff06f          	j	80007ca8 <__printf+0x440>
    80007d6c:	02500513          	li	a0,37
    80007d70:	00000097          	auipc	ra,0x0
    80007d74:	914080e7          	jalr	-1772(ra) # 80007684 <consputc>
    80007d78:	f31ff06f          	j	80007ca8 <__printf+0x440>
    80007d7c:	00030513          	mv	a0,t1
    80007d80:	00000097          	auipc	ra,0x0
    80007d84:	7bc080e7          	jalr	1980(ra) # 8000853c <acquire>
    80007d88:	b4dff06f          	j	800078d4 <__printf+0x6c>
    80007d8c:	40c0053b          	negw	a0,a2
    80007d90:	00a00713          	li	a4,10
    80007d94:	02e576bb          	remuw	a3,a0,a4
    80007d98:	00002d97          	auipc	s11,0x2
    80007d9c:	b68d8d93          	addi	s11,s11,-1176 # 80009900 <digits>
    80007da0:	ff700593          	li	a1,-9
    80007da4:	02069693          	slli	a3,a3,0x20
    80007da8:	0206d693          	srli	a3,a3,0x20
    80007dac:	00dd86b3          	add	a3,s11,a3
    80007db0:	0006c683          	lbu	a3,0(a3)
    80007db4:	02e557bb          	divuw	a5,a0,a4
    80007db8:	f8d40023          	sb	a3,-128(s0)
    80007dbc:	10b65e63          	bge	a2,a1,80007ed8 <__printf+0x670>
    80007dc0:	06300593          	li	a1,99
    80007dc4:	02e7f6bb          	remuw	a3,a5,a4
    80007dc8:	02069693          	slli	a3,a3,0x20
    80007dcc:	0206d693          	srli	a3,a3,0x20
    80007dd0:	00dd86b3          	add	a3,s11,a3
    80007dd4:	0006c683          	lbu	a3,0(a3)
    80007dd8:	02e7d73b          	divuw	a4,a5,a4
    80007ddc:	00200793          	li	a5,2
    80007de0:	f8d400a3          	sb	a3,-127(s0)
    80007de4:	bca5ece3          	bltu	a1,a0,800079bc <__printf+0x154>
    80007de8:	ce5ff06f          	j	80007acc <__printf+0x264>
    80007dec:	40e007bb          	negw	a5,a4
    80007df0:	00002d97          	auipc	s11,0x2
    80007df4:	b10d8d93          	addi	s11,s11,-1264 # 80009900 <digits>
    80007df8:	00f7f693          	andi	a3,a5,15
    80007dfc:	00dd86b3          	add	a3,s11,a3
    80007e00:	0006c583          	lbu	a1,0(a3)
    80007e04:	ff100613          	li	a2,-15
    80007e08:	0047d69b          	srliw	a3,a5,0x4
    80007e0c:	f8b40023          	sb	a1,-128(s0)
    80007e10:	0047d59b          	srliw	a1,a5,0x4
    80007e14:	0ac75e63          	bge	a4,a2,80007ed0 <__printf+0x668>
    80007e18:	00f6f693          	andi	a3,a3,15
    80007e1c:	00dd86b3          	add	a3,s11,a3
    80007e20:	0006c603          	lbu	a2,0(a3)
    80007e24:	00f00693          	li	a3,15
    80007e28:	0087d79b          	srliw	a5,a5,0x8
    80007e2c:	f8c400a3          	sb	a2,-127(s0)
    80007e30:	d8b6e4e3          	bltu	a3,a1,80007bb8 <__printf+0x350>
    80007e34:	00200793          	li	a5,2
    80007e38:	e2dff06f          	j	80007c64 <__printf+0x3fc>
    80007e3c:	00002c97          	auipc	s9,0x2
    80007e40:	aa4c8c93          	addi	s9,s9,-1372 # 800098e0 <CONSOLE_STATUS+0x8d0>
    80007e44:	02800513          	li	a0,40
    80007e48:	ef1ff06f          	j	80007d38 <__printf+0x4d0>
    80007e4c:	00700793          	li	a5,7
    80007e50:	00600c93          	li	s9,6
    80007e54:	e0dff06f          	j	80007c60 <__printf+0x3f8>
    80007e58:	00700793          	li	a5,7
    80007e5c:	00600c93          	li	s9,6
    80007e60:	c69ff06f          	j	80007ac8 <__printf+0x260>
    80007e64:	00300793          	li	a5,3
    80007e68:	00200c93          	li	s9,2
    80007e6c:	c5dff06f          	j	80007ac8 <__printf+0x260>
    80007e70:	00300793          	li	a5,3
    80007e74:	00200c93          	li	s9,2
    80007e78:	de9ff06f          	j	80007c60 <__printf+0x3f8>
    80007e7c:	00400793          	li	a5,4
    80007e80:	00300c93          	li	s9,3
    80007e84:	dddff06f          	j	80007c60 <__printf+0x3f8>
    80007e88:	00400793          	li	a5,4
    80007e8c:	00300c93          	li	s9,3
    80007e90:	c39ff06f          	j	80007ac8 <__printf+0x260>
    80007e94:	00500793          	li	a5,5
    80007e98:	00400c93          	li	s9,4
    80007e9c:	c2dff06f          	j	80007ac8 <__printf+0x260>
    80007ea0:	00500793          	li	a5,5
    80007ea4:	00400c93          	li	s9,4
    80007ea8:	db9ff06f          	j	80007c60 <__printf+0x3f8>
    80007eac:	00600793          	li	a5,6
    80007eb0:	00500c93          	li	s9,5
    80007eb4:	dadff06f          	j	80007c60 <__printf+0x3f8>
    80007eb8:	00600793          	li	a5,6
    80007ebc:	00500c93          	li	s9,5
    80007ec0:	c09ff06f          	j	80007ac8 <__printf+0x260>
    80007ec4:	00800793          	li	a5,8
    80007ec8:	00700c93          	li	s9,7
    80007ecc:	bfdff06f          	j	80007ac8 <__printf+0x260>
    80007ed0:	00100793          	li	a5,1
    80007ed4:	d91ff06f          	j	80007c64 <__printf+0x3fc>
    80007ed8:	00100793          	li	a5,1
    80007edc:	bf1ff06f          	j	80007acc <__printf+0x264>
    80007ee0:	00900793          	li	a5,9
    80007ee4:	00800c93          	li	s9,8
    80007ee8:	be1ff06f          	j	80007ac8 <__printf+0x260>
    80007eec:	00002517          	auipc	a0,0x2
    80007ef0:	9fc50513          	addi	a0,a0,-1540 # 800098e8 <CONSOLE_STATUS+0x8d8>
    80007ef4:	00000097          	auipc	ra,0x0
    80007ef8:	918080e7          	jalr	-1768(ra) # 8000780c <panic>

0000000080007efc <printfinit>:
    80007efc:	fe010113          	addi	sp,sp,-32
    80007f00:	00813823          	sd	s0,16(sp)
    80007f04:	00913423          	sd	s1,8(sp)
    80007f08:	00113c23          	sd	ra,24(sp)
    80007f0c:	02010413          	addi	s0,sp,32
    80007f10:	00005497          	auipc	s1,0x5
    80007f14:	54048493          	addi	s1,s1,1344 # 8000d450 <pr>
    80007f18:	00048513          	mv	a0,s1
    80007f1c:	00002597          	auipc	a1,0x2
    80007f20:	9dc58593          	addi	a1,a1,-1572 # 800098f8 <CONSOLE_STATUS+0x8e8>
    80007f24:	00000097          	auipc	ra,0x0
    80007f28:	5f4080e7          	jalr	1524(ra) # 80008518 <initlock>
    80007f2c:	01813083          	ld	ra,24(sp)
    80007f30:	01013403          	ld	s0,16(sp)
    80007f34:	0004ac23          	sw	zero,24(s1)
    80007f38:	00813483          	ld	s1,8(sp)
    80007f3c:	02010113          	addi	sp,sp,32
    80007f40:	00008067          	ret

0000000080007f44 <uartinit>:
    80007f44:	ff010113          	addi	sp,sp,-16
    80007f48:	00813423          	sd	s0,8(sp)
    80007f4c:	01010413          	addi	s0,sp,16
    80007f50:	100007b7          	lui	a5,0x10000
    80007f54:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007f58:	f8000713          	li	a4,-128
    80007f5c:	00e781a3          	sb	a4,3(a5)
    80007f60:	00300713          	li	a4,3
    80007f64:	00e78023          	sb	a4,0(a5)
    80007f68:	000780a3          	sb	zero,1(a5)
    80007f6c:	00e781a3          	sb	a4,3(a5)
    80007f70:	00700693          	li	a3,7
    80007f74:	00d78123          	sb	a3,2(a5)
    80007f78:	00e780a3          	sb	a4,1(a5)
    80007f7c:	00813403          	ld	s0,8(sp)
    80007f80:	01010113          	addi	sp,sp,16
    80007f84:	00008067          	ret

0000000080007f88 <uartputc>:
    80007f88:	00004797          	auipc	a5,0x4
    80007f8c:	0107a783          	lw	a5,16(a5) # 8000bf98 <panicked>
    80007f90:	00078463          	beqz	a5,80007f98 <uartputc+0x10>
    80007f94:	0000006f          	j	80007f94 <uartputc+0xc>
    80007f98:	fd010113          	addi	sp,sp,-48
    80007f9c:	02813023          	sd	s0,32(sp)
    80007fa0:	00913c23          	sd	s1,24(sp)
    80007fa4:	01213823          	sd	s2,16(sp)
    80007fa8:	01313423          	sd	s3,8(sp)
    80007fac:	02113423          	sd	ra,40(sp)
    80007fb0:	03010413          	addi	s0,sp,48
    80007fb4:	00004917          	auipc	s2,0x4
    80007fb8:	fec90913          	addi	s2,s2,-20 # 8000bfa0 <uart_tx_r>
    80007fbc:	00093783          	ld	a5,0(s2)
    80007fc0:	00004497          	auipc	s1,0x4
    80007fc4:	fe848493          	addi	s1,s1,-24 # 8000bfa8 <uart_tx_w>
    80007fc8:	0004b703          	ld	a4,0(s1)
    80007fcc:	02078693          	addi	a3,a5,32
    80007fd0:	00050993          	mv	s3,a0
    80007fd4:	02e69c63          	bne	a3,a4,8000800c <uartputc+0x84>
    80007fd8:	00001097          	auipc	ra,0x1
    80007fdc:	834080e7          	jalr	-1996(ra) # 8000880c <push_on>
    80007fe0:	00093783          	ld	a5,0(s2)
    80007fe4:	0004b703          	ld	a4,0(s1)
    80007fe8:	02078793          	addi	a5,a5,32
    80007fec:	00e79463          	bne	a5,a4,80007ff4 <uartputc+0x6c>
    80007ff0:	0000006f          	j	80007ff0 <uartputc+0x68>
    80007ff4:	00001097          	auipc	ra,0x1
    80007ff8:	88c080e7          	jalr	-1908(ra) # 80008880 <pop_on>
    80007ffc:	00093783          	ld	a5,0(s2)
    80008000:	0004b703          	ld	a4,0(s1)
    80008004:	02078693          	addi	a3,a5,32
    80008008:	fce688e3          	beq	a3,a4,80007fd8 <uartputc+0x50>
    8000800c:	01f77693          	andi	a3,a4,31
    80008010:	00005597          	auipc	a1,0x5
    80008014:	46058593          	addi	a1,a1,1120 # 8000d470 <uart_tx_buf>
    80008018:	00d586b3          	add	a3,a1,a3
    8000801c:	00170713          	addi	a4,a4,1
    80008020:	01368023          	sb	s3,0(a3)
    80008024:	00e4b023          	sd	a4,0(s1)
    80008028:	10000637          	lui	a2,0x10000
    8000802c:	02f71063          	bne	a4,a5,8000804c <uartputc+0xc4>
    80008030:	0340006f          	j	80008064 <uartputc+0xdc>
    80008034:	00074703          	lbu	a4,0(a4)
    80008038:	00f93023          	sd	a5,0(s2)
    8000803c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008040:	00093783          	ld	a5,0(s2)
    80008044:	0004b703          	ld	a4,0(s1)
    80008048:	00f70e63          	beq	a4,a5,80008064 <uartputc+0xdc>
    8000804c:	00564683          	lbu	a3,5(a2)
    80008050:	01f7f713          	andi	a4,a5,31
    80008054:	00e58733          	add	a4,a1,a4
    80008058:	0206f693          	andi	a3,a3,32
    8000805c:	00178793          	addi	a5,a5,1
    80008060:	fc069ae3          	bnez	a3,80008034 <uartputc+0xac>
    80008064:	02813083          	ld	ra,40(sp)
    80008068:	02013403          	ld	s0,32(sp)
    8000806c:	01813483          	ld	s1,24(sp)
    80008070:	01013903          	ld	s2,16(sp)
    80008074:	00813983          	ld	s3,8(sp)
    80008078:	03010113          	addi	sp,sp,48
    8000807c:	00008067          	ret

0000000080008080 <uartputc_sync>:
    80008080:	ff010113          	addi	sp,sp,-16
    80008084:	00813423          	sd	s0,8(sp)
    80008088:	01010413          	addi	s0,sp,16
    8000808c:	00004717          	auipc	a4,0x4
    80008090:	f0c72703          	lw	a4,-244(a4) # 8000bf98 <panicked>
    80008094:	02071663          	bnez	a4,800080c0 <uartputc_sync+0x40>
    80008098:	00050793          	mv	a5,a0
    8000809c:	100006b7          	lui	a3,0x10000
    800080a0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800080a4:	02077713          	andi	a4,a4,32
    800080a8:	fe070ce3          	beqz	a4,800080a0 <uartputc_sync+0x20>
    800080ac:	0ff7f793          	andi	a5,a5,255
    800080b0:	00f68023          	sb	a5,0(a3)
    800080b4:	00813403          	ld	s0,8(sp)
    800080b8:	01010113          	addi	sp,sp,16
    800080bc:	00008067          	ret
    800080c0:	0000006f          	j	800080c0 <uartputc_sync+0x40>

00000000800080c4 <uartstart>:
    800080c4:	ff010113          	addi	sp,sp,-16
    800080c8:	00813423          	sd	s0,8(sp)
    800080cc:	01010413          	addi	s0,sp,16
    800080d0:	00004617          	auipc	a2,0x4
    800080d4:	ed060613          	addi	a2,a2,-304 # 8000bfa0 <uart_tx_r>
    800080d8:	00004517          	auipc	a0,0x4
    800080dc:	ed050513          	addi	a0,a0,-304 # 8000bfa8 <uart_tx_w>
    800080e0:	00063783          	ld	a5,0(a2)
    800080e4:	00053703          	ld	a4,0(a0)
    800080e8:	04f70263          	beq	a4,a5,8000812c <uartstart+0x68>
    800080ec:	100005b7          	lui	a1,0x10000
    800080f0:	00005817          	auipc	a6,0x5
    800080f4:	38080813          	addi	a6,a6,896 # 8000d470 <uart_tx_buf>
    800080f8:	01c0006f          	j	80008114 <uartstart+0x50>
    800080fc:	0006c703          	lbu	a4,0(a3)
    80008100:	00f63023          	sd	a5,0(a2)
    80008104:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008108:	00063783          	ld	a5,0(a2)
    8000810c:	00053703          	ld	a4,0(a0)
    80008110:	00f70e63          	beq	a4,a5,8000812c <uartstart+0x68>
    80008114:	01f7f713          	andi	a4,a5,31
    80008118:	00e806b3          	add	a3,a6,a4
    8000811c:	0055c703          	lbu	a4,5(a1)
    80008120:	00178793          	addi	a5,a5,1
    80008124:	02077713          	andi	a4,a4,32
    80008128:	fc071ae3          	bnez	a4,800080fc <uartstart+0x38>
    8000812c:	00813403          	ld	s0,8(sp)
    80008130:	01010113          	addi	sp,sp,16
    80008134:	00008067          	ret

0000000080008138 <uartgetc>:
    80008138:	ff010113          	addi	sp,sp,-16
    8000813c:	00813423          	sd	s0,8(sp)
    80008140:	01010413          	addi	s0,sp,16
    80008144:	10000737          	lui	a4,0x10000
    80008148:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000814c:	0017f793          	andi	a5,a5,1
    80008150:	00078c63          	beqz	a5,80008168 <uartgetc+0x30>
    80008154:	00074503          	lbu	a0,0(a4)
    80008158:	0ff57513          	andi	a0,a0,255
    8000815c:	00813403          	ld	s0,8(sp)
    80008160:	01010113          	addi	sp,sp,16
    80008164:	00008067          	ret
    80008168:	fff00513          	li	a0,-1
    8000816c:	ff1ff06f          	j	8000815c <uartgetc+0x24>

0000000080008170 <uartintr>:
    80008170:	100007b7          	lui	a5,0x10000
    80008174:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008178:	0017f793          	andi	a5,a5,1
    8000817c:	0a078463          	beqz	a5,80008224 <uartintr+0xb4>
    80008180:	fe010113          	addi	sp,sp,-32
    80008184:	00813823          	sd	s0,16(sp)
    80008188:	00913423          	sd	s1,8(sp)
    8000818c:	00113c23          	sd	ra,24(sp)
    80008190:	02010413          	addi	s0,sp,32
    80008194:	100004b7          	lui	s1,0x10000
    80008198:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000819c:	0ff57513          	andi	a0,a0,255
    800081a0:	fffff097          	auipc	ra,0xfffff
    800081a4:	534080e7          	jalr	1332(ra) # 800076d4 <consoleintr>
    800081a8:	0054c783          	lbu	a5,5(s1)
    800081ac:	0017f793          	andi	a5,a5,1
    800081b0:	fe0794e3          	bnez	a5,80008198 <uartintr+0x28>
    800081b4:	00004617          	auipc	a2,0x4
    800081b8:	dec60613          	addi	a2,a2,-532 # 8000bfa0 <uart_tx_r>
    800081bc:	00004517          	auipc	a0,0x4
    800081c0:	dec50513          	addi	a0,a0,-532 # 8000bfa8 <uart_tx_w>
    800081c4:	00063783          	ld	a5,0(a2)
    800081c8:	00053703          	ld	a4,0(a0)
    800081cc:	04f70263          	beq	a4,a5,80008210 <uartintr+0xa0>
    800081d0:	100005b7          	lui	a1,0x10000
    800081d4:	00005817          	auipc	a6,0x5
    800081d8:	29c80813          	addi	a6,a6,668 # 8000d470 <uart_tx_buf>
    800081dc:	01c0006f          	j	800081f8 <uartintr+0x88>
    800081e0:	0006c703          	lbu	a4,0(a3)
    800081e4:	00f63023          	sd	a5,0(a2)
    800081e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800081ec:	00063783          	ld	a5,0(a2)
    800081f0:	00053703          	ld	a4,0(a0)
    800081f4:	00f70e63          	beq	a4,a5,80008210 <uartintr+0xa0>
    800081f8:	01f7f713          	andi	a4,a5,31
    800081fc:	00e806b3          	add	a3,a6,a4
    80008200:	0055c703          	lbu	a4,5(a1)
    80008204:	00178793          	addi	a5,a5,1
    80008208:	02077713          	andi	a4,a4,32
    8000820c:	fc071ae3          	bnez	a4,800081e0 <uartintr+0x70>
    80008210:	01813083          	ld	ra,24(sp)
    80008214:	01013403          	ld	s0,16(sp)
    80008218:	00813483          	ld	s1,8(sp)
    8000821c:	02010113          	addi	sp,sp,32
    80008220:	00008067          	ret
    80008224:	00004617          	auipc	a2,0x4
    80008228:	d7c60613          	addi	a2,a2,-644 # 8000bfa0 <uart_tx_r>
    8000822c:	00004517          	auipc	a0,0x4
    80008230:	d7c50513          	addi	a0,a0,-644 # 8000bfa8 <uart_tx_w>
    80008234:	00063783          	ld	a5,0(a2)
    80008238:	00053703          	ld	a4,0(a0)
    8000823c:	04f70263          	beq	a4,a5,80008280 <uartintr+0x110>
    80008240:	100005b7          	lui	a1,0x10000
    80008244:	00005817          	auipc	a6,0x5
    80008248:	22c80813          	addi	a6,a6,556 # 8000d470 <uart_tx_buf>
    8000824c:	01c0006f          	j	80008268 <uartintr+0xf8>
    80008250:	0006c703          	lbu	a4,0(a3)
    80008254:	00f63023          	sd	a5,0(a2)
    80008258:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000825c:	00063783          	ld	a5,0(a2)
    80008260:	00053703          	ld	a4,0(a0)
    80008264:	02f70063          	beq	a4,a5,80008284 <uartintr+0x114>
    80008268:	01f7f713          	andi	a4,a5,31
    8000826c:	00e806b3          	add	a3,a6,a4
    80008270:	0055c703          	lbu	a4,5(a1)
    80008274:	00178793          	addi	a5,a5,1
    80008278:	02077713          	andi	a4,a4,32
    8000827c:	fc071ae3          	bnez	a4,80008250 <uartintr+0xe0>
    80008280:	00008067          	ret
    80008284:	00008067          	ret

0000000080008288 <kinit>:
    80008288:	fc010113          	addi	sp,sp,-64
    8000828c:	02913423          	sd	s1,40(sp)
    80008290:	fffff7b7          	lui	a5,0xfffff
    80008294:	00006497          	auipc	s1,0x6
    80008298:	1fb48493          	addi	s1,s1,507 # 8000e48f <end+0xfff>
    8000829c:	02813823          	sd	s0,48(sp)
    800082a0:	01313c23          	sd	s3,24(sp)
    800082a4:	00f4f4b3          	and	s1,s1,a5
    800082a8:	02113c23          	sd	ra,56(sp)
    800082ac:	03213023          	sd	s2,32(sp)
    800082b0:	01413823          	sd	s4,16(sp)
    800082b4:	01513423          	sd	s5,8(sp)
    800082b8:	04010413          	addi	s0,sp,64
    800082bc:	000017b7          	lui	a5,0x1
    800082c0:	01100993          	li	s3,17
    800082c4:	00f487b3          	add	a5,s1,a5
    800082c8:	01b99993          	slli	s3,s3,0x1b
    800082cc:	06f9e063          	bltu	s3,a5,8000832c <kinit+0xa4>
    800082d0:	00005a97          	auipc	s5,0x5
    800082d4:	1c0a8a93          	addi	s5,s5,448 # 8000d490 <end>
    800082d8:	0754ec63          	bltu	s1,s5,80008350 <kinit+0xc8>
    800082dc:	0734fa63          	bgeu	s1,s3,80008350 <kinit+0xc8>
    800082e0:	00088a37          	lui	s4,0x88
    800082e4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800082e8:	00004917          	auipc	s2,0x4
    800082ec:	cc890913          	addi	s2,s2,-824 # 8000bfb0 <kmem>
    800082f0:	00ca1a13          	slli	s4,s4,0xc
    800082f4:	0140006f          	j	80008308 <kinit+0x80>
    800082f8:	000017b7          	lui	a5,0x1
    800082fc:	00f484b3          	add	s1,s1,a5
    80008300:	0554e863          	bltu	s1,s5,80008350 <kinit+0xc8>
    80008304:	0534f663          	bgeu	s1,s3,80008350 <kinit+0xc8>
    80008308:	00001637          	lui	a2,0x1
    8000830c:	00100593          	li	a1,1
    80008310:	00048513          	mv	a0,s1
    80008314:	00000097          	auipc	ra,0x0
    80008318:	5e4080e7          	jalr	1508(ra) # 800088f8 <__memset>
    8000831c:	00093783          	ld	a5,0(s2)
    80008320:	00f4b023          	sd	a5,0(s1)
    80008324:	00993023          	sd	s1,0(s2)
    80008328:	fd4498e3          	bne	s1,s4,800082f8 <kinit+0x70>
    8000832c:	03813083          	ld	ra,56(sp)
    80008330:	03013403          	ld	s0,48(sp)
    80008334:	02813483          	ld	s1,40(sp)
    80008338:	02013903          	ld	s2,32(sp)
    8000833c:	01813983          	ld	s3,24(sp)
    80008340:	01013a03          	ld	s4,16(sp)
    80008344:	00813a83          	ld	s5,8(sp)
    80008348:	04010113          	addi	sp,sp,64
    8000834c:	00008067          	ret
    80008350:	00001517          	auipc	a0,0x1
    80008354:	5c850513          	addi	a0,a0,1480 # 80009918 <digits+0x18>
    80008358:	fffff097          	auipc	ra,0xfffff
    8000835c:	4b4080e7          	jalr	1204(ra) # 8000780c <panic>

0000000080008360 <freerange>:
    80008360:	fc010113          	addi	sp,sp,-64
    80008364:	000017b7          	lui	a5,0x1
    80008368:	02913423          	sd	s1,40(sp)
    8000836c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008370:	009504b3          	add	s1,a0,s1
    80008374:	fffff537          	lui	a0,0xfffff
    80008378:	02813823          	sd	s0,48(sp)
    8000837c:	02113c23          	sd	ra,56(sp)
    80008380:	03213023          	sd	s2,32(sp)
    80008384:	01313c23          	sd	s3,24(sp)
    80008388:	01413823          	sd	s4,16(sp)
    8000838c:	01513423          	sd	s5,8(sp)
    80008390:	01613023          	sd	s6,0(sp)
    80008394:	04010413          	addi	s0,sp,64
    80008398:	00a4f4b3          	and	s1,s1,a0
    8000839c:	00f487b3          	add	a5,s1,a5
    800083a0:	06f5e463          	bltu	a1,a5,80008408 <freerange+0xa8>
    800083a4:	00005a97          	auipc	s5,0x5
    800083a8:	0eca8a93          	addi	s5,s5,236 # 8000d490 <end>
    800083ac:	0954e263          	bltu	s1,s5,80008430 <freerange+0xd0>
    800083b0:	01100993          	li	s3,17
    800083b4:	01b99993          	slli	s3,s3,0x1b
    800083b8:	0734fc63          	bgeu	s1,s3,80008430 <freerange+0xd0>
    800083bc:	00058a13          	mv	s4,a1
    800083c0:	00004917          	auipc	s2,0x4
    800083c4:	bf090913          	addi	s2,s2,-1040 # 8000bfb0 <kmem>
    800083c8:	00002b37          	lui	s6,0x2
    800083cc:	0140006f          	j	800083e0 <freerange+0x80>
    800083d0:	000017b7          	lui	a5,0x1
    800083d4:	00f484b3          	add	s1,s1,a5
    800083d8:	0554ec63          	bltu	s1,s5,80008430 <freerange+0xd0>
    800083dc:	0534fa63          	bgeu	s1,s3,80008430 <freerange+0xd0>
    800083e0:	00001637          	lui	a2,0x1
    800083e4:	00100593          	li	a1,1
    800083e8:	00048513          	mv	a0,s1
    800083ec:	00000097          	auipc	ra,0x0
    800083f0:	50c080e7          	jalr	1292(ra) # 800088f8 <__memset>
    800083f4:	00093703          	ld	a4,0(s2)
    800083f8:	016487b3          	add	a5,s1,s6
    800083fc:	00e4b023          	sd	a4,0(s1)
    80008400:	00993023          	sd	s1,0(s2)
    80008404:	fcfa76e3          	bgeu	s4,a5,800083d0 <freerange+0x70>
    80008408:	03813083          	ld	ra,56(sp)
    8000840c:	03013403          	ld	s0,48(sp)
    80008410:	02813483          	ld	s1,40(sp)
    80008414:	02013903          	ld	s2,32(sp)
    80008418:	01813983          	ld	s3,24(sp)
    8000841c:	01013a03          	ld	s4,16(sp)
    80008420:	00813a83          	ld	s5,8(sp)
    80008424:	00013b03          	ld	s6,0(sp)
    80008428:	04010113          	addi	sp,sp,64
    8000842c:	00008067          	ret
    80008430:	00001517          	auipc	a0,0x1
    80008434:	4e850513          	addi	a0,a0,1256 # 80009918 <digits+0x18>
    80008438:	fffff097          	auipc	ra,0xfffff
    8000843c:	3d4080e7          	jalr	980(ra) # 8000780c <panic>

0000000080008440 <kfree>:
    80008440:	fe010113          	addi	sp,sp,-32
    80008444:	00813823          	sd	s0,16(sp)
    80008448:	00113c23          	sd	ra,24(sp)
    8000844c:	00913423          	sd	s1,8(sp)
    80008450:	02010413          	addi	s0,sp,32
    80008454:	03451793          	slli	a5,a0,0x34
    80008458:	04079c63          	bnez	a5,800084b0 <kfree+0x70>
    8000845c:	00005797          	auipc	a5,0x5
    80008460:	03478793          	addi	a5,a5,52 # 8000d490 <end>
    80008464:	00050493          	mv	s1,a0
    80008468:	04f56463          	bltu	a0,a5,800084b0 <kfree+0x70>
    8000846c:	01100793          	li	a5,17
    80008470:	01b79793          	slli	a5,a5,0x1b
    80008474:	02f57e63          	bgeu	a0,a5,800084b0 <kfree+0x70>
    80008478:	00001637          	lui	a2,0x1
    8000847c:	00100593          	li	a1,1
    80008480:	00000097          	auipc	ra,0x0
    80008484:	478080e7          	jalr	1144(ra) # 800088f8 <__memset>
    80008488:	00004797          	auipc	a5,0x4
    8000848c:	b2878793          	addi	a5,a5,-1240 # 8000bfb0 <kmem>
    80008490:	0007b703          	ld	a4,0(a5)
    80008494:	01813083          	ld	ra,24(sp)
    80008498:	01013403          	ld	s0,16(sp)
    8000849c:	00e4b023          	sd	a4,0(s1)
    800084a0:	0097b023          	sd	s1,0(a5)
    800084a4:	00813483          	ld	s1,8(sp)
    800084a8:	02010113          	addi	sp,sp,32
    800084ac:	00008067          	ret
    800084b0:	00001517          	auipc	a0,0x1
    800084b4:	46850513          	addi	a0,a0,1128 # 80009918 <digits+0x18>
    800084b8:	fffff097          	auipc	ra,0xfffff
    800084bc:	354080e7          	jalr	852(ra) # 8000780c <panic>

00000000800084c0 <kalloc>:
    800084c0:	fe010113          	addi	sp,sp,-32
    800084c4:	00813823          	sd	s0,16(sp)
    800084c8:	00913423          	sd	s1,8(sp)
    800084cc:	00113c23          	sd	ra,24(sp)
    800084d0:	02010413          	addi	s0,sp,32
    800084d4:	00004797          	auipc	a5,0x4
    800084d8:	adc78793          	addi	a5,a5,-1316 # 8000bfb0 <kmem>
    800084dc:	0007b483          	ld	s1,0(a5)
    800084e0:	02048063          	beqz	s1,80008500 <kalloc+0x40>
    800084e4:	0004b703          	ld	a4,0(s1)
    800084e8:	00001637          	lui	a2,0x1
    800084ec:	00500593          	li	a1,5
    800084f0:	00048513          	mv	a0,s1
    800084f4:	00e7b023          	sd	a4,0(a5)
    800084f8:	00000097          	auipc	ra,0x0
    800084fc:	400080e7          	jalr	1024(ra) # 800088f8 <__memset>
    80008500:	01813083          	ld	ra,24(sp)
    80008504:	01013403          	ld	s0,16(sp)
    80008508:	00048513          	mv	a0,s1
    8000850c:	00813483          	ld	s1,8(sp)
    80008510:	02010113          	addi	sp,sp,32
    80008514:	00008067          	ret

0000000080008518 <initlock>:
    80008518:	ff010113          	addi	sp,sp,-16
    8000851c:	00813423          	sd	s0,8(sp)
    80008520:	01010413          	addi	s0,sp,16
    80008524:	00813403          	ld	s0,8(sp)
    80008528:	00b53423          	sd	a1,8(a0)
    8000852c:	00052023          	sw	zero,0(a0)
    80008530:	00053823          	sd	zero,16(a0)
    80008534:	01010113          	addi	sp,sp,16
    80008538:	00008067          	ret

000000008000853c <acquire>:
    8000853c:	fe010113          	addi	sp,sp,-32
    80008540:	00813823          	sd	s0,16(sp)
    80008544:	00913423          	sd	s1,8(sp)
    80008548:	00113c23          	sd	ra,24(sp)
    8000854c:	01213023          	sd	s2,0(sp)
    80008550:	02010413          	addi	s0,sp,32
    80008554:	00050493          	mv	s1,a0
    80008558:	10002973          	csrr	s2,sstatus
    8000855c:	100027f3          	csrr	a5,sstatus
    80008560:	ffd7f793          	andi	a5,a5,-3
    80008564:	10079073          	csrw	sstatus,a5
    80008568:	fffff097          	auipc	ra,0xfffff
    8000856c:	8e4080e7          	jalr	-1820(ra) # 80006e4c <mycpu>
    80008570:	07852783          	lw	a5,120(a0)
    80008574:	06078e63          	beqz	a5,800085f0 <acquire+0xb4>
    80008578:	fffff097          	auipc	ra,0xfffff
    8000857c:	8d4080e7          	jalr	-1836(ra) # 80006e4c <mycpu>
    80008580:	07852783          	lw	a5,120(a0)
    80008584:	0004a703          	lw	a4,0(s1)
    80008588:	0017879b          	addiw	a5,a5,1
    8000858c:	06f52c23          	sw	a5,120(a0)
    80008590:	04071063          	bnez	a4,800085d0 <acquire+0x94>
    80008594:	00100713          	li	a4,1
    80008598:	00070793          	mv	a5,a4
    8000859c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800085a0:	0007879b          	sext.w	a5,a5
    800085a4:	fe079ae3          	bnez	a5,80008598 <acquire+0x5c>
    800085a8:	0ff0000f          	fence
    800085ac:	fffff097          	auipc	ra,0xfffff
    800085b0:	8a0080e7          	jalr	-1888(ra) # 80006e4c <mycpu>
    800085b4:	01813083          	ld	ra,24(sp)
    800085b8:	01013403          	ld	s0,16(sp)
    800085bc:	00a4b823          	sd	a0,16(s1)
    800085c0:	00013903          	ld	s2,0(sp)
    800085c4:	00813483          	ld	s1,8(sp)
    800085c8:	02010113          	addi	sp,sp,32
    800085cc:	00008067          	ret
    800085d0:	0104b903          	ld	s2,16(s1)
    800085d4:	fffff097          	auipc	ra,0xfffff
    800085d8:	878080e7          	jalr	-1928(ra) # 80006e4c <mycpu>
    800085dc:	faa91ce3          	bne	s2,a0,80008594 <acquire+0x58>
    800085e0:	00001517          	auipc	a0,0x1
    800085e4:	34050513          	addi	a0,a0,832 # 80009920 <digits+0x20>
    800085e8:	fffff097          	auipc	ra,0xfffff
    800085ec:	224080e7          	jalr	548(ra) # 8000780c <panic>
    800085f0:	00195913          	srli	s2,s2,0x1
    800085f4:	fffff097          	auipc	ra,0xfffff
    800085f8:	858080e7          	jalr	-1960(ra) # 80006e4c <mycpu>
    800085fc:	00197913          	andi	s2,s2,1
    80008600:	07252e23          	sw	s2,124(a0)
    80008604:	f75ff06f          	j	80008578 <acquire+0x3c>

0000000080008608 <release>:
    80008608:	fe010113          	addi	sp,sp,-32
    8000860c:	00813823          	sd	s0,16(sp)
    80008610:	00113c23          	sd	ra,24(sp)
    80008614:	00913423          	sd	s1,8(sp)
    80008618:	01213023          	sd	s2,0(sp)
    8000861c:	02010413          	addi	s0,sp,32
    80008620:	00052783          	lw	a5,0(a0)
    80008624:	00079a63          	bnez	a5,80008638 <release+0x30>
    80008628:	00001517          	auipc	a0,0x1
    8000862c:	30050513          	addi	a0,a0,768 # 80009928 <digits+0x28>
    80008630:	fffff097          	auipc	ra,0xfffff
    80008634:	1dc080e7          	jalr	476(ra) # 8000780c <panic>
    80008638:	01053903          	ld	s2,16(a0)
    8000863c:	00050493          	mv	s1,a0
    80008640:	fffff097          	auipc	ra,0xfffff
    80008644:	80c080e7          	jalr	-2036(ra) # 80006e4c <mycpu>
    80008648:	fea910e3          	bne	s2,a0,80008628 <release+0x20>
    8000864c:	0004b823          	sd	zero,16(s1)
    80008650:	0ff0000f          	fence
    80008654:	0f50000f          	fence	iorw,ow
    80008658:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000865c:	ffffe097          	auipc	ra,0xffffe
    80008660:	7f0080e7          	jalr	2032(ra) # 80006e4c <mycpu>
    80008664:	100027f3          	csrr	a5,sstatus
    80008668:	0027f793          	andi	a5,a5,2
    8000866c:	04079a63          	bnez	a5,800086c0 <release+0xb8>
    80008670:	07852783          	lw	a5,120(a0)
    80008674:	02f05e63          	blez	a5,800086b0 <release+0xa8>
    80008678:	fff7871b          	addiw	a4,a5,-1
    8000867c:	06e52c23          	sw	a4,120(a0)
    80008680:	00071c63          	bnez	a4,80008698 <release+0x90>
    80008684:	07c52783          	lw	a5,124(a0)
    80008688:	00078863          	beqz	a5,80008698 <release+0x90>
    8000868c:	100027f3          	csrr	a5,sstatus
    80008690:	0027e793          	ori	a5,a5,2
    80008694:	10079073          	csrw	sstatus,a5
    80008698:	01813083          	ld	ra,24(sp)
    8000869c:	01013403          	ld	s0,16(sp)
    800086a0:	00813483          	ld	s1,8(sp)
    800086a4:	00013903          	ld	s2,0(sp)
    800086a8:	02010113          	addi	sp,sp,32
    800086ac:	00008067          	ret
    800086b0:	00001517          	auipc	a0,0x1
    800086b4:	29850513          	addi	a0,a0,664 # 80009948 <digits+0x48>
    800086b8:	fffff097          	auipc	ra,0xfffff
    800086bc:	154080e7          	jalr	340(ra) # 8000780c <panic>
    800086c0:	00001517          	auipc	a0,0x1
    800086c4:	27050513          	addi	a0,a0,624 # 80009930 <digits+0x30>
    800086c8:	fffff097          	auipc	ra,0xfffff
    800086cc:	144080e7          	jalr	324(ra) # 8000780c <panic>

00000000800086d0 <holding>:
    800086d0:	00052783          	lw	a5,0(a0)
    800086d4:	00079663          	bnez	a5,800086e0 <holding+0x10>
    800086d8:	00000513          	li	a0,0
    800086dc:	00008067          	ret
    800086e0:	fe010113          	addi	sp,sp,-32
    800086e4:	00813823          	sd	s0,16(sp)
    800086e8:	00913423          	sd	s1,8(sp)
    800086ec:	00113c23          	sd	ra,24(sp)
    800086f0:	02010413          	addi	s0,sp,32
    800086f4:	01053483          	ld	s1,16(a0)
    800086f8:	ffffe097          	auipc	ra,0xffffe
    800086fc:	754080e7          	jalr	1876(ra) # 80006e4c <mycpu>
    80008700:	01813083          	ld	ra,24(sp)
    80008704:	01013403          	ld	s0,16(sp)
    80008708:	40a48533          	sub	a0,s1,a0
    8000870c:	00153513          	seqz	a0,a0
    80008710:	00813483          	ld	s1,8(sp)
    80008714:	02010113          	addi	sp,sp,32
    80008718:	00008067          	ret

000000008000871c <push_off>:
    8000871c:	fe010113          	addi	sp,sp,-32
    80008720:	00813823          	sd	s0,16(sp)
    80008724:	00113c23          	sd	ra,24(sp)
    80008728:	00913423          	sd	s1,8(sp)
    8000872c:	02010413          	addi	s0,sp,32
    80008730:	100024f3          	csrr	s1,sstatus
    80008734:	100027f3          	csrr	a5,sstatus
    80008738:	ffd7f793          	andi	a5,a5,-3
    8000873c:	10079073          	csrw	sstatus,a5
    80008740:	ffffe097          	auipc	ra,0xffffe
    80008744:	70c080e7          	jalr	1804(ra) # 80006e4c <mycpu>
    80008748:	07852783          	lw	a5,120(a0)
    8000874c:	02078663          	beqz	a5,80008778 <push_off+0x5c>
    80008750:	ffffe097          	auipc	ra,0xffffe
    80008754:	6fc080e7          	jalr	1788(ra) # 80006e4c <mycpu>
    80008758:	07852783          	lw	a5,120(a0)
    8000875c:	01813083          	ld	ra,24(sp)
    80008760:	01013403          	ld	s0,16(sp)
    80008764:	0017879b          	addiw	a5,a5,1
    80008768:	06f52c23          	sw	a5,120(a0)
    8000876c:	00813483          	ld	s1,8(sp)
    80008770:	02010113          	addi	sp,sp,32
    80008774:	00008067          	ret
    80008778:	0014d493          	srli	s1,s1,0x1
    8000877c:	ffffe097          	auipc	ra,0xffffe
    80008780:	6d0080e7          	jalr	1744(ra) # 80006e4c <mycpu>
    80008784:	0014f493          	andi	s1,s1,1
    80008788:	06952e23          	sw	s1,124(a0)
    8000878c:	fc5ff06f          	j	80008750 <push_off+0x34>

0000000080008790 <pop_off>:
    80008790:	ff010113          	addi	sp,sp,-16
    80008794:	00813023          	sd	s0,0(sp)
    80008798:	00113423          	sd	ra,8(sp)
    8000879c:	01010413          	addi	s0,sp,16
    800087a0:	ffffe097          	auipc	ra,0xffffe
    800087a4:	6ac080e7          	jalr	1708(ra) # 80006e4c <mycpu>
    800087a8:	100027f3          	csrr	a5,sstatus
    800087ac:	0027f793          	andi	a5,a5,2
    800087b0:	04079663          	bnez	a5,800087fc <pop_off+0x6c>
    800087b4:	07852783          	lw	a5,120(a0)
    800087b8:	02f05a63          	blez	a5,800087ec <pop_off+0x5c>
    800087bc:	fff7871b          	addiw	a4,a5,-1
    800087c0:	06e52c23          	sw	a4,120(a0)
    800087c4:	00071c63          	bnez	a4,800087dc <pop_off+0x4c>
    800087c8:	07c52783          	lw	a5,124(a0)
    800087cc:	00078863          	beqz	a5,800087dc <pop_off+0x4c>
    800087d0:	100027f3          	csrr	a5,sstatus
    800087d4:	0027e793          	ori	a5,a5,2
    800087d8:	10079073          	csrw	sstatus,a5
    800087dc:	00813083          	ld	ra,8(sp)
    800087e0:	00013403          	ld	s0,0(sp)
    800087e4:	01010113          	addi	sp,sp,16
    800087e8:	00008067          	ret
    800087ec:	00001517          	auipc	a0,0x1
    800087f0:	15c50513          	addi	a0,a0,348 # 80009948 <digits+0x48>
    800087f4:	fffff097          	auipc	ra,0xfffff
    800087f8:	018080e7          	jalr	24(ra) # 8000780c <panic>
    800087fc:	00001517          	auipc	a0,0x1
    80008800:	13450513          	addi	a0,a0,308 # 80009930 <digits+0x30>
    80008804:	fffff097          	auipc	ra,0xfffff
    80008808:	008080e7          	jalr	8(ra) # 8000780c <panic>

000000008000880c <push_on>:
    8000880c:	fe010113          	addi	sp,sp,-32
    80008810:	00813823          	sd	s0,16(sp)
    80008814:	00113c23          	sd	ra,24(sp)
    80008818:	00913423          	sd	s1,8(sp)
    8000881c:	02010413          	addi	s0,sp,32
    80008820:	100024f3          	csrr	s1,sstatus
    80008824:	100027f3          	csrr	a5,sstatus
    80008828:	0027e793          	ori	a5,a5,2
    8000882c:	10079073          	csrw	sstatus,a5
    80008830:	ffffe097          	auipc	ra,0xffffe
    80008834:	61c080e7          	jalr	1564(ra) # 80006e4c <mycpu>
    80008838:	07852783          	lw	a5,120(a0)
    8000883c:	02078663          	beqz	a5,80008868 <push_on+0x5c>
    80008840:	ffffe097          	auipc	ra,0xffffe
    80008844:	60c080e7          	jalr	1548(ra) # 80006e4c <mycpu>
    80008848:	07852783          	lw	a5,120(a0)
    8000884c:	01813083          	ld	ra,24(sp)
    80008850:	01013403          	ld	s0,16(sp)
    80008854:	0017879b          	addiw	a5,a5,1
    80008858:	06f52c23          	sw	a5,120(a0)
    8000885c:	00813483          	ld	s1,8(sp)
    80008860:	02010113          	addi	sp,sp,32
    80008864:	00008067          	ret
    80008868:	0014d493          	srli	s1,s1,0x1
    8000886c:	ffffe097          	auipc	ra,0xffffe
    80008870:	5e0080e7          	jalr	1504(ra) # 80006e4c <mycpu>
    80008874:	0014f493          	andi	s1,s1,1
    80008878:	06952e23          	sw	s1,124(a0)
    8000887c:	fc5ff06f          	j	80008840 <push_on+0x34>

0000000080008880 <pop_on>:
    80008880:	ff010113          	addi	sp,sp,-16
    80008884:	00813023          	sd	s0,0(sp)
    80008888:	00113423          	sd	ra,8(sp)
    8000888c:	01010413          	addi	s0,sp,16
    80008890:	ffffe097          	auipc	ra,0xffffe
    80008894:	5bc080e7          	jalr	1468(ra) # 80006e4c <mycpu>
    80008898:	100027f3          	csrr	a5,sstatus
    8000889c:	0027f793          	andi	a5,a5,2
    800088a0:	04078463          	beqz	a5,800088e8 <pop_on+0x68>
    800088a4:	07852783          	lw	a5,120(a0)
    800088a8:	02f05863          	blez	a5,800088d8 <pop_on+0x58>
    800088ac:	fff7879b          	addiw	a5,a5,-1
    800088b0:	06f52c23          	sw	a5,120(a0)
    800088b4:	07853783          	ld	a5,120(a0)
    800088b8:	00079863          	bnez	a5,800088c8 <pop_on+0x48>
    800088bc:	100027f3          	csrr	a5,sstatus
    800088c0:	ffd7f793          	andi	a5,a5,-3
    800088c4:	10079073          	csrw	sstatus,a5
    800088c8:	00813083          	ld	ra,8(sp)
    800088cc:	00013403          	ld	s0,0(sp)
    800088d0:	01010113          	addi	sp,sp,16
    800088d4:	00008067          	ret
    800088d8:	00001517          	auipc	a0,0x1
    800088dc:	09850513          	addi	a0,a0,152 # 80009970 <digits+0x70>
    800088e0:	fffff097          	auipc	ra,0xfffff
    800088e4:	f2c080e7          	jalr	-212(ra) # 8000780c <panic>
    800088e8:	00001517          	auipc	a0,0x1
    800088ec:	06850513          	addi	a0,a0,104 # 80009950 <digits+0x50>
    800088f0:	fffff097          	auipc	ra,0xfffff
    800088f4:	f1c080e7          	jalr	-228(ra) # 8000780c <panic>

00000000800088f8 <__memset>:
    800088f8:	ff010113          	addi	sp,sp,-16
    800088fc:	00813423          	sd	s0,8(sp)
    80008900:	01010413          	addi	s0,sp,16
    80008904:	1a060e63          	beqz	a2,80008ac0 <__memset+0x1c8>
    80008908:	40a007b3          	neg	a5,a0
    8000890c:	0077f793          	andi	a5,a5,7
    80008910:	00778693          	addi	a3,a5,7
    80008914:	00b00813          	li	a6,11
    80008918:	0ff5f593          	andi	a1,a1,255
    8000891c:	fff6071b          	addiw	a4,a2,-1
    80008920:	1b06e663          	bltu	a3,a6,80008acc <__memset+0x1d4>
    80008924:	1cd76463          	bltu	a4,a3,80008aec <__memset+0x1f4>
    80008928:	1a078e63          	beqz	a5,80008ae4 <__memset+0x1ec>
    8000892c:	00b50023          	sb	a1,0(a0)
    80008930:	00100713          	li	a4,1
    80008934:	1ae78463          	beq	a5,a4,80008adc <__memset+0x1e4>
    80008938:	00b500a3          	sb	a1,1(a0)
    8000893c:	00200713          	li	a4,2
    80008940:	1ae78a63          	beq	a5,a4,80008af4 <__memset+0x1fc>
    80008944:	00b50123          	sb	a1,2(a0)
    80008948:	00300713          	li	a4,3
    8000894c:	18e78463          	beq	a5,a4,80008ad4 <__memset+0x1dc>
    80008950:	00b501a3          	sb	a1,3(a0)
    80008954:	00400713          	li	a4,4
    80008958:	1ae78263          	beq	a5,a4,80008afc <__memset+0x204>
    8000895c:	00b50223          	sb	a1,4(a0)
    80008960:	00500713          	li	a4,5
    80008964:	1ae78063          	beq	a5,a4,80008b04 <__memset+0x20c>
    80008968:	00b502a3          	sb	a1,5(a0)
    8000896c:	00700713          	li	a4,7
    80008970:	18e79e63          	bne	a5,a4,80008b0c <__memset+0x214>
    80008974:	00b50323          	sb	a1,6(a0)
    80008978:	00700e93          	li	t4,7
    8000897c:	00859713          	slli	a4,a1,0x8
    80008980:	00e5e733          	or	a4,a1,a4
    80008984:	01059e13          	slli	t3,a1,0x10
    80008988:	01c76e33          	or	t3,a4,t3
    8000898c:	01859313          	slli	t1,a1,0x18
    80008990:	006e6333          	or	t1,t3,t1
    80008994:	02059893          	slli	a7,a1,0x20
    80008998:	40f60e3b          	subw	t3,a2,a5
    8000899c:	011368b3          	or	a7,t1,a7
    800089a0:	02859813          	slli	a6,a1,0x28
    800089a4:	0108e833          	or	a6,a7,a6
    800089a8:	03059693          	slli	a3,a1,0x30
    800089ac:	003e589b          	srliw	a7,t3,0x3
    800089b0:	00d866b3          	or	a3,a6,a3
    800089b4:	03859713          	slli	a4,a1,0x38
    800089b8:	00389813          	slli	a6,a7,0x3
    800089bc:	00f507b3          	add	a5,a0,a5
    800089c0:	00e6e733          	or	a4,a3,a4
    800089c4:	000e089b          	sext.w	a7,t3
    800089c8:	00f806b3          	add	a3,a6,a5
    800089cc:	00e7b023          	sd	a4,0(a5)
    800089d0:	00878793          	addi	a5,a5,8
    800089d4:	fed79ce3          	bne	a5,a3,800089cc <__memset+0xd4>
    800089d8:	ff8e7793          	andi	a5,t3,-8
    800089dc:	0007871b          	sext.w	a4,a5
    800089e0:	01d787bb          	addw	a5,a5,t4
    800089e4:	0ce88e63          	beq	a7,a4,80008ac0 <__memset+0x1c8>
    800089e8:	00f50733          	add	a4,a0,a5
    800089ec:	00b70023          	sb	a1,0(a4)
    800089f0:	0017871b          	addiw	a4,a5,1
    800089f4:	0cc77663          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    800089f8:	00e50733          	add	a4,a0,a4
    800089fc:	00b70023          	sb	a1,0(a4)
    80008a00:	0027871b          	addiw	a4,a5,2
    80008a04:	0ac77e63          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a08:	00e50733          	add	a4,a0,a4
    80008a0c:	00b70023          	sb	a1,0(a4)
    80008a10:	0037871b          	addiw	a4,a5,3
    80008a14:	0ac77663          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a18:	00e50733          	add	a4,a0,a4
    80008a1c:	00b70023          	sb	a1,0(a4)
    80008a20:	0047871b          	addiw	a4,a5,4
    80008a24:	08c77e63          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a28:	00e50733          	add	a4,a0,a4
    80008a2c:	00b70023          	sb	a1,0(a4)
    80008a30:	0057871b          	addiw	a4,a5,5
    80008a34:	08c77663          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a38:	00e50733          	add	a4,a0,a4
    80008a3c:	00b70023          	sb	a1,0(a4)
    80008a40:	0067871b          	addiw	a4,a5,6
    80008a44:	06c77e63          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a48:	00e50733          	add	a4,a0,a4
    80008a4c:	00b70023          	sb	a1,0(a4)
    80008a50:	0077871b          	addiw	a4,a5,7
    80008a54:	06c77663          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a58:	00e50733          	add	a4,a0,a4
    80008a5c:	00b70023          	sb	a1,0(a4)
    80008a60:	0087871b          	addiw	a4,a5,8
    80008a64:	04c77e63          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a68:	00e50733          	add	a4,a0,a4
    80008a6c:	00b70023          	sb	a1,0(a4)
    80008a70:	0097871b          	addiw	a4,a5,9
    80008a74:	04c77663          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a78:	00e50733          	add	a4,a0,a4
    80008a7c:	00b70023          	sb	a1,0(a4)
    80008a80:	00a7871b          	addiw	a4,a5,10
    80008a84:	02c77e63          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a88:	00e50733          	add	a4,a0,a4
    80008a8c:	00b70023          	sb	a1,0(a4)
    80008a90:	00b7871b          	addiw	a4,a5,11
    80008a94:	02c77663          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008a98:	00e50733          	add	a4,a0,a4
    80008a9c:	00b70023          	sb	a1,0(a4)
    80008aa0:	00c7871b          	addiw	a4,a5,12
    80008aa4:	00c77e63          	bgeu	a4,a2,80008ac0 <__memset+0x1c8>
    80008aa8:	00e50733          	add	a4,a0,a4
    80008aac:	00b70023          	sb	a1,0(a4)
    80008ab0:	00d7879b          	addiw	a5,a5,13
    80008ab4:	00c7f663          	bgeu	a5,a2,80008ac0 <__memset+0x1c8>
    80008ab8:	00f507b3          	add	a5,a0,a5
    80008abc:	00b78023          	sb	a1,0(a5)
    80008ac0:	00813403          	ld	s0,8(sp)
    80008ac4:	01010113          	addi	sp,sp,16
    80008ac8:	00008067          	ret
    80008acc:	00b00693          	li	a3,11
    80008ad0:	e55ff06f          	j	80008924 <__memset+0x2c>
    80008ad4:	00300e93          	li	t4,3
    80008ad8:	ea5ff06f          	j	8000897c <__memset+0x84>
    80008adc:	00100e93          	li	t4,1
    80008ae0:	e9dff06f          	j	8000897c <__memset+0x84>
    80008ae4:	00000e93          	li	t4,0
    80008ae8:	e95ff06f          	j	8000897c <__memset+0x84>
    80008aec:	00000793          	li	a5,0
    80008af0:	ef9ff06f          	j	800089e8 <__memset+0xf0>
    80008af4:	00200e93          	li	t4,2
    80008af8:	e85ff06f          	j	8000897c <__memset+0x84>
    80008afc:	00400e93          	li	t4,4
    80008b00:	e7dff06f          	j	8000897c <__memset+0x84>
    80008b04:	00500e93          	li	t4,5
    80008b08:	e75ff06f          	j	8000897c <__memset+0x84>
    80008b0c:	00600e93          	li	t4,6
    80008b10:	e6dff06f          	j	8000897c <__memset+0x84>

0000000080008b14 <__memmove>:
    80008b14:	ff010113          	addi	sp,sp,-16
    80008b18:	00813423          	sd	s0,8(sp)
    80008b1c:	01010413          	addi	s0,sp,16
    80008b20:	0e060863          	beqz	a2,80008c10 <__memmove+0xfc>
    80008b24:	fff6069b          	addiw	a3,a2,-1
    80008b28:	0006881b          	sext.w	a6,a3
    80008b2c:	0ea5e863          	bltu	a1,a0,80008c1c <__memmove+0x108>
    80008b30:	00758713          	addi	a4,a1,7
    80008b34:	00a5e7b3          	or	a5,a1,a0
    80008b38:	40a70733          	sub	a4,a4,a0
    80008b3c:	0077f793          	andi	a5,a5,7
    80008b40:	00f73713          	sltiu	a4,a4,15
    80008b44:	00174713          	xori	a4,a4,1
    80008b48:	0017b793          	seqz	a5,a5
    80008b4c:	00e7f7b3          	and	a5,a5,a4
    80008b50:	10078863          	beqz	a5,80008c60 <__memmove+0x14c>
    80008b54:	00900793          	li	a5,9
    80008b58:	1107f463          	bgeu	a5,a6,80008c60 <__memmove+0x14c>
    80008b5c:	0036581b          	srliw	a6,a2,0x3
    80008b60:	fff8081b          	addiw	a6,a6,-1
    80008b64:	02081813          	slli	a6,a6,0x20
    80008b68:	01d85893          	srli	a7,a6,0x1d
    80008b6c:	00858813          	addi	a6,a1,8
    80008b70:	00058793          	mv	a5,a1
    80008b74:	00050713          	mv	a4,a0
    80008b78:	01088833          	add	a6,a7,a6
    80008b7c:	0007b883          	ld	a7,0(a5)
    80008b80:	00878793          	addi	a5,a5,8
    80008b84:	00870713          	addi	a4,a4,8
    80008b88:	ff173c23          	sd	a7,-8(a4)
    80008b8c:	ff0798e3          	bne	a5,a6,80008b7c <__memmove+0x68>
    80008b90:	ff867713          	andi	a4,a2,-8
    80008b94:	02071793          	slli	a5,a4,0x20
    80008b98:	0207d793          	srli	a5,a5,0x20
    80008b9c:	00f585b3          	add	a1,a1,a5
    80008ba0:	40e686bb          	subw	a3,a3,a4
    80008ba4:	00f507b3          	add	a5,a0,a5
    80008ba8:	06e60463          	beq	a2,a4,80008c10 <__memmove+0xfc>
    80008bac:	0005c703          	lbu	a4,0(a1)
    80008bb0:	00e78023          	sb	a4,0(a5)
    80008bb4:	04068e63          	beqz	a3,80008c10 <__memmove+0xfc>
    80008bb8:	0015c603          	lbu	a2,1(a1)
    80008bbc:	00100713          	li	a4,1
    80008bc0:	00c780a3          	sb	a2,1(a5)
    80008bc4:	04e68663          	beq	a3,a4,80008c10 <__memmove+0xfc>
    80008bc8:	0025c603          	lbu	a2,2(a1)
    80008bcc:	00200713          	li	a4,2
    80008bd0:	00c78123          	sb	a2,2(a5)
    80008bd4:	02e68e63          	beq	a3,a4,80008c10 <__memmove+0xfc>
    80008bd8:	0035c603          	lbu	a2,3(a1)
    80008bdc:	00300713          	li	a4,3
    80008be0:	00c781a3          	sb	a2,3(a5)
    80008be4:	02e68663          	beq	a3,a4,80008c10 <__memmove+0xfc>
    80008be8:	0045c603          	lbu	a2,4(a1)
    80008bec:	00400713          	li	a4,4
    80008bf0:	00c78223          	sb	a2,4(a5)
    80008bf4:	00e68e63          	beq	a3,a4,80008c10 <__memmove+0xfc>
    80008bf8:	0055c603          	lbu	a2,5(a1)
    80008bfc:	00500713          	li	a4,5
    80008c00:	00c782a3          	sb	a2,5(a5)
    80008c04:	00e68663          	beq	a3,a4,80008c10 <__memmove+0xfc>
    80008c08:	0065c703          	lbu	a4,6(a1)
    80008c0c:	00e78323          	sb	a4,6(a5)
    80008c10:	00813403          	ld	s0,8(sp)
    80008c14:	01010113          	addi	sp,sp,16
    80008c18:	00008067          	ret
    80008c1c:	02061713          	slli	a4,a2,0x20
    80008c20:	02075713          	srli	a4,a4,0x20
    80008c24:	00e587b3          	add	a5,a1,a4
    80008c28:	f0f574e3          	bgeu	a0,a5,80008b30 <__memmove+0x1c>
    80008c2c:	02069613          	slli	a2,a3,0x20
    80008c30:	02065613          	srli	a2,a2,0x20
    80008c34:	fff64613          	not	a2,a2
    80008c38:	00e50733          	add	a4,a0,a4
    80008c3c:	00c78633          	add	a2,a5,a2
    80008c40:	fff7c683          	lbu	a3,-1(a5)
    80008c44:	fff78793          	addi	a5,a5,-1
    80008c48:	fff70713          	addi	a4,a4,-1
    80008c4c:	00d70023          	sb	a3,0(a4)
    80008c50:	fec798e3          	bne	a5,a2,80008c40 <__memmove+0x12c>
    80008c54:	00813403          	ld	s0,8(sp)
    80008c58:	01010113          	addi	sp,sp,16
    80008c5c:	00008067          	ret
    80008c60:	02069713          	slli	a4,a3,0x20
    80008c64:	02075713          	srli	a4,a4,0x20
    80008c68:	00170713          	addi	a4,a4,1
    80008c6c:	00e50733          	add	a4,a0,a4
    80008c70:	00050793          	mv	a5,a0
    80008c74:	0005c683          	lbu	a3,0(a1)
    80008c78:	00178793          	addi	a5,a5,1
    80008c7c:	00158593          	addi	a1,a1,1
    80008c80:	fed78fa3          	sb	a3,-1(a5)
    80008c84:	fee798e3          	bne	a5,a4,80008c74 <__memmove+0x160>
    80008c88:	f89ff06f          	j	80008c10 <__memmove+0xfc>
	...
