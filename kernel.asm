
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	a5013103          	ld	sp,-1456(sp) # 8000ba50 <_GLOBAL_OFFSET_TABLE_+0x50>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	03c060ef          	jal	ra,80006058 <start>

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
    800010a8:	470030ef          	jal	ra,80004518 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	4c0080e7          	jalr	1216(ra) # 80002640 <_ZN5Buddy4freeEPvm>
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
    800011e0:	16c60613          	addi	a2,a2,364 # 80009348 <CONSOLE_STATUS+0x338>
    800011e4:	0005059b          	sext.w	a1,a0
    800011e8:	00008517          	auipc	a0,0x8
    800011ec:	e3850513          	addi	a0,a0,-456 # 80009020 <CONSOLE_STATUS+0x10>
    800011f0:	00004097          	auipc	ra,0x4
    800011f4:	da4080e7          	jalr	-604(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011f8:	00008617          	auipc	a2,0x8
    800011fc:	15060613          	addi	a2,a2,336 # 80009348 <CONSOLE_STATUS+0x338>
    80001200:	01892583          	lw	a1,24(s2)
    80001204:	00008517          	auipc	a0,0x8
    80001208:	e2c50513          	addi	a0,a0,-468 # 80009030 <CONSOLE_STATUS+0x20>
    8000120c:	00004097          	auipc	ra,0x4
    80001210:	d88080e7          	jalr	-632(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    80001214:	00008617          	auipc	a2,0x8
    80001218:	13460613          	addi	a2,a2,308 # 80009348 <CONSOLE_STATUS+0x338>
    8000121c:	01092583          	lw	a1,16(s2)
    80001220:	00008517          	auipc	a0,0x8
    80001224:	e2850513          	addi	a0,a0,-472 # 80009048 <CONSOLE_STATUS+0x38>
    80001228:	00004097          	auipc	ra,0x4
    8000122c:	d6c080e7          	jalr	-660(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    80001230:	00008617          	auipc	a2,0x8
    80001234:	11860613          	addi	a2,a2,280 # 80009348 <CONSOLE_STATUS+0x338>
    80001238:	03800593          	li	a1,56
    8000123c:	00008517          	auipc	a0,0x8
    80001240:	e2450513          	addi	a0,a0,-476 # 80009060 <CONSOLE_STATUS+0x50>
    80001244:	00004097          	auipc	ra,0x4
    80001248:	d50080e7          	jalr	-688(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000124c:	00008617          	auipc	a2,0x8
    80001250:	0fc60613          	addi	a2,a2,252 # 80009348 <CONSOLE_STATUS+0x338>
    80001254:	02892583          	lw	a1,40(s2)
    80001258:	00008517          	auipc	a0,0x8
    8000125c:	e2050513          	addi	a0,a0,-480 # 80009078 <CONSOLE_STATUS+0x68>
    80001260:	00004097          	auipc	ra,0x4
    80001264:	d34080e7          	jalr	-716(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    80001268:	00008617          	auipc	a2,0x8
    8000126c:	0e060613          	addi	a2,a2,224 # 80009348 <CONSOLE_STATUS+0x338>
    80001270:	02092583          	lw	a1,32(s2)
    80001274:	00008517          	auipc	a0,0x8
    80001278:	e1450513          	addi	a0,a0,-492 # 80009088 <CONSOLE_STATUS+0x78>
    8000127c:	00004097          	auipc	ra,0x4
    80001280:	d18080e7          	jalr	-744(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::printString("Allocated status array:\n");
    80001284:	00008517          	auipc	a0,0x8
    80001288:	e2450513          	addi	a0,a0,-476 # 800090a8 <CONSOLE_STATUS+0x98>
    8000128c:	00004097          	auipc	ra,0x4
    80001290:	be8080e7          	jalr	-1048(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
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
    800012b4:	0d850513          	addi	a0,a0,216 # 80009388 <CONSOLE_STATUS+0x378>
    800012b8:	00004097          	auipc	ra,0x4
    800012bc:	cdc080e7          	jalr	-804(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012c0:	00148493          	addi	s1,s1,1
    800012c4:	01893783          	ld	a5,24(s2)
    800012c8:	0037d793          	srli	a5,a5,0x3
    800012cc:	00178793          	addi	a5,a5,1
    800012d0:	fcf4e6e3          	bltu	s1,a5,8000129c <_ZN13SlabAllocator9printSlabEP4Slab+0xe0>
        }
        ConsoleUtil::printString("\n");
    800012d4:	00008517          	auipc	a0,0x8
    800012d8:	07450513          	addi	a0,a0,116 # 80009348 <CONSOLE_STATUS+0x338>
    800012dc:	00004097          	auipc	ra,0x4
    800012e0:	b98080e7          	jalr	-1128(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
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
    80001328:	b50080e7          	jalr	-1200(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    8000132c:	00090513          	mv	a0,s2
    80001330:	00004097          	auipc	ra,0x4
    80001334:	b44080e7          	jalr	-1212(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001338:	00008517          	auipc	a0,0x8
    8000133c:	01050513          	addi	a0,a0,16 # 80009348 <CONSOLE_STATUS+0x338>
    80001340:	00004097          	auipc	ra,0x4
    80001344:	b34080e7          	jalr	-1228(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001348:	00008617          	auipc	a2,0x8
    8000134c:	00060613          	mv	a2,a2
    80001350:	0000a797          	auipc	a5,0xa
    80001354:	6c87b783          	ld	a5,1736(a5) # 8000ba18 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001358:	0007a583          	lw	a1,0(a5)
    8000135c:	00008517          	auipc	a0,0x8
    80001360:	d7c50513          	addi	a0,a0,-644 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001364:	00004097          	auipc	ra,0x4
    80001368:	c30080e7          	jalr	-976(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	00008617          	auipc	a2,0x8
    80001370:	fdc60613          	addi	a2,a2,-36 # 80009348 <CONSOLE_STATUS+0x338>
    80001374:	0009059b          	sext.w	a1,s2
    80001378:	00008517          	auipc	a0,0x8
    8000137c:	d7850513          	addi	a0,a0,-648 # 800090f0 <CONSOLE_STATUS+0xe0>
    80001380:	00004097          	auipc	ra,0x4
    80001384:	c14080e7          	jalr	-1004(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    80001388:	00008617          	auipc	a2,0x8
    8000138c:	fc060613          	addi	a2,a2,-64 # 80009348 <CONSOLE_STATUS+0x338>
    80001390:	04892583          	lw	a1,72(s2)
    80001394:	00008517          	auipc	a0,0x8
    80001398:	d6c50513          	addi	a0,a0,-660 # 80009100 <CONSOLE_STATUS+0xf0>
    8000139c:	00004097          	auipc	ra,0x4
    800013a0:	bf8080e7          	jalr	-1032(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013a4:	00008617          	auipc	a2,0x8
    800013a8:	fa460613          	addi	a2,a2,-92 # 80009348 <CONSOLE_STATUS+0x338>
    800013ac:	04092583          	lw	a1,64(s2)
    800013b0:	00008517          	auipc	a0,0x8
    800013b4:	d6850513          	addi	a0,a0,-664 # 80009118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	bdc080e7          	jalr	-1060(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013c0:	00008617          	auipc	a2,0x8
    800013c4:	f8860613          	addi	a2,a2,-120 # 80009348 <CONSOLE_STATUS+0x338>
    800013c8:	06092583          	lw	a1,96(s2)
    800013cc:	00008517          	auipc	a0,0x8
    800013d0:	d6450513          	addi	a0,a0,-668 # 80009130 <CONSOLE_STATUS+0x120>
    800013d4:	00004097          	auipc	ra,0x4
    800013d8:	bc0080e7          	jalr	-1088(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    800013dc:	06093483          	ld	s1,96(s2)
    while(iter){
    800013e0:	02048463          	beqz	s1,80001408 <_ZN13SlabAllocator10printCacheEP5Cache+0x108>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013e4:	00008617          	auipc	a2,0x8
    800013e8:	d0460613          	addi	a2,a2,-764 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013ec:	0004859b          	sext.w	a1,s1
    800013f0:	00008517          	auipc	a0,0x8
    800013f4:	f9850513          	addi	a0,a0,-104 # 80009388 <CONSOLE_STATUS+0x378>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	b9c080e7          	jalr	-1124(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001400:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001404:	fddff06f          	j	800013e0 <_ZN13SlabAllocator10printCacheEP5Cache+0xe0>
    }
    ConsoleUtil::printString("\n");
    80001408:	00008517          	auipc	a0,0x8
    8000140c:	f4050513          	addi	a0,a0,-192 # 80009348 <CONSOLE_STATUS+0x338>
    80001410:	00004097          	auipc	ra,0x4
    80001414:	a64080e7          	jalr	-1436(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001418:	00008617          	auipc	a2,0x8
    8000141c:	f3060613          	addi	a2,a2,-208 # 80009348 <CONSOLE_STATUS+0x338>
    80001420:	06892583          	lw	a1,104(s2)
    80001424:	00008517          	auipc	a0,0x8
    80001428:	d1c50513          	addi	a0,a0,-740 # 80009140 <CONSOLE_STATUS+0x130>
    8000142c:	00004097          	auipc	ra,0x4
    80001430:	b68080e7          	jalr	-1176(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    80001434:	06893483          	ld	s1,104(s2)
    while(iter){
    80001438:	02048463          	beqz	s1,80001460 <_ZN13SlabAllocator10printCacheEP5Cache+0x160>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000143c:	00008617          	auipc	a2,0x8
    80001440:	cac60613          	addi	a2,a2,-852 # 800090e8 <CONSOLE_STATUS+0xd8>
    80001444:	0004859b          	sext.w	a1,s1
    80001448:	00008517          	auipc	a0,0x8
    8000144c:	f4050513          	addi	a0,a0,-192 # 80009388 <CONSOLE_STATUS+0x378>
    80001450:	00004097          	auipc	ra,0x4
    80001454:	b44080e7          	jalr	-1212(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001458:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000145c:	fddff06f          	j	80001438 <_ZN13SlabAllocator10printCacheEP5Cache+0x138>
    }
    ConsoleUtil::printString("\n");
    80001460:	00008517          	auipc	a0,0x8
    80001464:	ee850513          	addi	a0,a0,-280 # 80009348 <CONSOLE_STATUS+0x338>
    80001468:	00004097          	auipc	ra,0x4
    8000146c:	a0c080e7          	jalr	-1524(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001470:	00008617          	auipc	a2,0x8
    80001474:	ed860613          	addi	a2,a2,-296 # 80009348 <CONSOLE_STATUS+0x338>
    80001478:	07092583          	lw	a1,112(s2)
    8000147c:	00008517          	auipc	a0,0x8
    80001480:	cd450513          	addi	a0,a0,-812 # 80009150 <CONSOLE_STATUS+0x140>
    80001484:	00004097          	auipc	ra,0x4
    80001488:	b10080e7          	jalr	-1264(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    8000148c:	07093483          	ld	s1,112(s2)
    while(iter){
    80001490:	02048463          	beqz	s1,800014b8 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001494:	00008617          	auipc	a2,0x8
    80001498:	c5460613          	addi	a2,a2,-940 # 800090e8 <CONSOLE_STATUS+0xd8>
    8000149c:	0004859b          	sext.w	a1,s1
    800014a0:	00008517          	auipc	a0,0x8
    800014a4:	ee850513          	addi	a0,a0,-280 # 80009388 <CONSOLE_STATUS+0x378>
    800014a8:	00004097          	auipc	ra,0x4
    800014ac:	aec080e7          	jalr	-1300(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800014b0:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014b4:	fddff06f          	j	80001490 <_ZN13SlabAllocator10printCacheEP5Cache+0x190>
    }
    ConsoleUtil::printString("\n");
    800014b8:	00008517          	auipc	a0,0x8
    800014bc:	e9050513          	addi	a0,a0,-368 # 80009348 <CONSOLE_STATUS+0x338>
    800014c0:	00004097          	auipc	ra,0x4
    800014c4:	9b4080e7          	jalr	-1612(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    800014c8:	00008617          	auipc	a2,0x8
    800014cc:	e8060613          	addi	a2,a2,-384 # 80009348 <CONSOLE_STATUS+0x338>
    800014d0:	04092583          	lw	a1,64(s2)
    800014d4:	00008517          	auipc	a0,0x8
    800014d8:	c8c50513          	addi	a0,a0,-884 # 80009160 <CONSOLE_STATUS+0x150>
    800014dc:	00004097          	auipc	ra,0x4
    800014e0:	ab8080e7          	jalr	-1352(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
}
    800014e4:	01813083          	ld	ra,24(sp)
    800014e8:	01013403          	ld	s0,16(sp)
    800014ec:	00813483          	ld	s1,8(sp)
    800014f0:	00013903          	ld	s2,0(sp)
    800014f4:	02010113          	addi	sp,sp,32
    800014f8:	00008067          	ret

00000000800014fc <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    800014fc:	ff010113          	addi	sp,sp,-16
    80001500:	00813423          	sd	s0,8(sp)
    80001504:	01010413          	addi	s0,sp,16
    slab->next = head;
    80001508:	00053783          	ld	a5,0(a0)
    8000150c:	00f5b423          	sd	a5,8(a1)
    if(head)
    80001510:	00078463          	beqz	a5,80001518 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    80001514:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80001518:	0005b023          	sd	zero,0(a1)
    head = slab;
    8000151c:	00b53023          	sd	a1,0(a0)
}
    80001520:	00813403          	ld	s0,8(sp)
    80001524:	01010113          	addi	sp,sp,16
    80001528:	00008067          	ret

000000008000152c <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    8000152c:	fd010113          	addi	sp,sp,-48
    80001530:	02113423          	sd	ra,40(sp)
    80001534:	02813023          	sd	s0,32(sp)
    80001538:	00913c23          	sd	s1,24(sp)
    8000153c:	01213823          	sd	s2,16(sp)
    80001540:	01313423          	sd	s3,8(sp)
    80001544:	03010413          	addi	s0,sp,48
    80001548:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    8000154c:	04853503          	ld	a0,72(a0)
    80001550:	00001097          	auipc	ra,0x1
    80001554:	1c8080e7          	jalr	456(ra) # 80002718 <_ZN5Buddy5allocEm>
    if(!slab)
    80001558:	0c050e63          	beqz	a0,80001634 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x108>
    8000155c:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001560:	00050593          	mv	a1,a0
    80001564:	06098513          	addi	a0,s3,96
    80001568:	00000097          	auipc	ra,0x0
    8000156c:	f94080e7          	jalr	-108(ra) # 800014fc <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001570:	0489b783          	ld	a5,72(s3)
    80001574:	00c79793          	slli	a5,a5,0xc
    80001578:	fc878793          	addi	a5,a5,-56
    8000157c:	0409b703          	ld	a4,64(s3)
    80001580:	02e7d7b3          	divu	a5,a5,a4
    80001584:	00f4b823          	sd	a5,16(s1)
    80001588:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + slab->totalNumOfSlots/8 + 1);
    8000158c:	0037d793          	srli	a5,a5,0x3
    80001590:	009787b3          	add	a5,a5,s1
    80001594:	03978793          	addi	a5,a5,57
    80001598:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (char*)((uint64)slab + sizeof(Slab));
    8000159c:	03848793          	addi	a5,s1,56
    800015a0:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    800015a4:	0334b823          	sd	s3,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015a8:	00000713          	li	a4,0
    800015ac:	0184b783          	ld	a5,24(s1)
    800015b0:	0037d793          	srli	a5,a5,0x3
    800015b4:	00178793          	addi	a5,a5,1
    800015b8:	00f77c63          	bgeu	a4,a5,800015d0 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
        slab->allocated[i] = 0;
    800015bc:	0204b783          	ld	a5,32(s1)
    800015c0:	00e787b3          	add	a5,a5,a4
    800015c4:	00078023          	sb	zero,0(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015c8:	00170713          	addi	a4,a4,1
    800015cc:	fe1ff06f          	j	800015ac <_ZN13SlabAllocator12allocateSlabEP5Cache+0x80>
    if(cache->ctor)
    800015d0:	0509b783          	ld	a5,80(s3)
    800015d4:	06078463          	beqz	a5,8000163c <_ZN13SlabAllocator12allocateSlabEP5Cache+0x110>
        for(uint64 i=0;i<slab->totalNumOfSlots;i++) {
    800015d8:	00000913          	li	s2,0
    800015dc:	0184b783          	ld	a5,24(s1)
    800015e0:	06f97263          	bgeu	s2,a5,80001644 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x118>
            ConsoleUtil::print("",((uint64)slab->objectOffset + i*slab->parent->objectSize), "\n");
    800015e4:	0284b583          	ld	a1,40(s1)
    800015e8:	0304b783          	ld	a5,48(s1)
    800015ec:	0407b783          	ld	a5,64(a5)
    800015f0:	032787bb          	mulw	a5,a5,s2
    800015f4:	00008617          	auipc	a2,0x8
    800015f8:	d5460613          	addi	a2,a2,-684 # 80009348 <CONSOLE_STATUS+0x338>
    800015fc:	00b785bb          	addw	a1,a5,a1
    80001600:	00008517          	auipc	a0,0x8
    80001604:	d8850513          	addi	a0,a0,-632 # 80009388 <CONSOLE_STATUS+0x378>
    80001608:	00004097          	auipc	ra,0x4
    8000160c:	98c080e7          	jalr	-1652(ra) # 80004f94 <_ZN11ConsoleUtil5printEPKciS1_>
            cache->ctor((void*)((uint64)slab->objectOffset + i*slab->parent->objectSize));
    80001610:	0509b703          	ld	a4,80(s3)
    80001614:	0284b503          	ld	a0,40(s1)
    80001618:	0304b783          	ld	a5,48(s1)
    8000161c:	0407b783          	ld	a5,64(a5)
    80001620:	032787b3          	mul	a5,a5,s2
    80001624:	00f50533          	add	a0,a0,a5
    80001628:	000700e7          	jalr	a4
        for(uint64 i=0;i<slab->totalNumOfSlots;i++) {
    8000162c:	00190913          	addi	s2,s2,1
    80001630:	fadff06f          	j	800015dc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb0>
        return false;
    80001634:	00000513          	li	a0,0
    80001638:	0100006f          	j	80001648 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x11c>
    return true;
    8000163c:	00100513          	li	a0,1
    80001640:	0080006f          	j	80001648 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x11c>
    80001644:	00100513          	li	a0,1
}
    80001648:	02813083          	ld	ra,40(sp)
    8000164c:	02013403          	ld	s0,32(sp)
    80001650:	01813483          	ld	s1,24(sp)
    80001654:	01013903          	ld	s2,16(sp)
    80001658:	00813983          	ld	s3,8(sp)
    8000165c:	03010113          	addi	sp,sp,48
    80001660:	00008067          	ret

0000000080001664 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001664:	ff010113          	addi	sp,sp,-16
    80001668:	00813423          	sd	s0,8(sp)
    8000166c:	01010413          	addi	s0,sp,16
    if(slab == head)
    80001670:	00053783          	ld	a5,0(a0)
    80001674:	02b78c63          	beq	a5,a1,800016ac <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001678:	0085b783          	ld	a5,8(a1)
    8000167c:	00078663          	beqz	a5,80001688 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80001680:	0005b703          	ld	a4,0(a1)
    80001684:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001688:	0005b783          	ld	a5,0(a1)
    8000168c:	00078663          	beqz	a5,80001698 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80001690:	0085b703          	ld	a4,8(a1)
    80001694:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001698:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    8000169c:	0005b423          	sd	zero,8(a1)
}
    800016a0:	00813403          	ld	s0,8(sp)
    800016a4:	01010113          	addi	sp,sp,16
    800016a8:	00008067          	ret
        head = slab->next;
    800016ac:	0085b783          	ld	a5,8(a1)
    800016b0:	00f53023          	sd	a5,0(a0)
    800016b4:	fc5ff06f          	j	80001678 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

00000000800016b8 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    800016b8:	fe010113          	addi	sp,sp,-32
    800016bc:	00113c23          	sd	ra,24(sp)
    800016c0:	00813823          	sd	s0,16(sp)
    800016c4:	00913423          	sd	s1,8(sp)
    800016c8:	01213023          	sd	s2,0(sp)
    800016cc:	02010413          	addi	s0,sp,32
    800016d0:	00058913          	mv	s2,a1
    800016d4:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800016d8:	00060593          	mv	a1,a2
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	f88080e7          	jalr	-120(ra) # 80001664 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    800016e4:	00048593          	mv	a1,s1
    800016e8:	00090513          	mv	a0,s2
    800016ec:	00000097          	auipc	ra,0x0
    800016f0:	e10080e7          	jalr	-496(ra) # 800014fc <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800016f4:	01813083          	ld	ra,24(sp)
    800016f8:	01013403          	ld	s0,16(sp)
    800016fc:	00813483          	ld	s1,8(sp)
    80001700:	00013903          	ld	s2,0(sp)
    80001704:	02010113          	addi	sp,sp,32
    80001708:	00008067          	ret

000000008000170c <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    8000170c:	fe010113          	addi	sp,sp,-32
    80001710:	00113c23          	sd	ra,24(sp)
    80001714:	00813823          	sd	s0,16(sp)
    80001718:	00913423          	sd	s1,8(sp)
    8000171c:	01213023          	sd	s2,0(sp)
    80001720:	02010413          	addi	s0,sp,32
    80001724:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001728:	00000493          	li	s1,0
    8000172c:	01893783          	ld	a5,24(s2)
    80001730:	0af4f863          	bgeu	s1,a5,800017e0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80001734:	02093783          	ld	a5,32(s2)
    80001738:	0034d713          	srli	a4,s1,0x3
    8000173c:	00e787b3          	add	a5,a5,a4
    80001740:	0007c603          	lbu	a2,0(a5)
    80001744:	fff4c713          	not	a4,s1
    80001748:	00777713          	andi	a4,a4,7
    8000174c:	40e656bb          	sraw	a3,a2,a4
    80001750:	0016f693          	andi	a3,a3,1
    80001754:	00068663          	beqz	a3,80001760 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x54>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001758:	00148493          	addi	s1,s1,1
    8000175c:	fd1ff06f          	j	8000172c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    80001760:	00100693          	li	a3,1
    80001764:	00e6973b          	sllw	a4,a3,a4
    80001768:	00e66633          	or	a2,a2,a4
    8000176c:	00c78023          	sb	a2,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001770:	01093783          	ld	a5,16(s2)
    80001774:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001778:	04f70863          	beq	a4,a5,800017c8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
    8000177c:	03093503          	ld	a0,48(s2)
    80001780:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001784:	fff78793          	addi	a5,a5,-1
    80001788:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    8000178c:	04079463          	bnez	a5,800017d4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    80001790:	03093583          	ld	a1,48(s2)
    80001794:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001798:	0005b703          	ld	a4,0(a1)
    8000179c:	00053783          	ld	a5,0(a0)
    800017a0:	00f70863          	beq	a4,a5,800017b0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa4>
                SlabAllocator::move(headFrom, headTo, slab);
    800017a4:	00090613          	mv	a2,s2
    800017a8:	00000097          	auipc	ra,0x0
    800017ac:	f10080e7          	jalr	-240(ra) # 800016b8 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    800017b0:	02893503          	ld	a0,40(s2)
    800017b4:	03093783          	ld	a5,48(s2)
    800017b8:	0407b783          	ld	a5,64(a5)
    800017bc:	029784b3          	mul	s1,a5,s1
    800017c0:	00950533          	add	a0,a0,s1
    800017c4:	0200006f          	j	800017e4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd8>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800017c8:	03093503          	ld	a0,48(s2)
    800017cc:	06050513          	addi	a0,a0,96
    800017d0:	fb5ff06f          	j	80001784 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x78>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800017d4:	03093583          	ld	a1,48(s2)
    800017d8:	06858593          	addi	a1,a1,104
    800017dc:	fbdff06f          	j	80001798 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x8c>
    return nullptr;
    800017e0:	00000513          	li	a0,0
}
    800017e4:	01813083          	ld	ra,24(sp)
    800017e8:	01013403          	ld	s0,16(sp)
    800017ec:	00813483          	ld	s1,8(sp)
    800017f0:	00013903          	ld	s2,0(sp)
    800017f4:	02010113          	addi	sp,sp,32
    800017f8:	00008067          	ret

00000000800017fc <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800017fc:	fe010113          	addi	sp,sp,-32
    80001800:	00113c23          	sd	ra,24(sp)
    80001804:	00813823          	sd	s0,16(sp)
    80001808:	00913423          	sd	s1,8(sp)
    8000180c:	01213023          	sd	s2,0(sp)
    80001810:	02010413          	addi	s0,sp,32
    80001814:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80001818:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    8000181c:	00048c63          	beqz	s1,80001834 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    80001820:	00048513          	mv	a0,s1
    80001824:	00000097          	auipc	ra,0x0
    80001828:	ee8080e7          	jalr	-280(ra) # 8000170c <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    8000182c:	fe0508e3          	beqz	a0,8000181c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    80001830:	00050493          	mv	s1,a0
    if(ret){
    80001834:	02048063          	beqz	s1,80001854 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    80001838:	00048513          	mv	a0,s1
    8000183c:	01813083          	ld	ra,24(sp)
    80001840:	01013403          	ld	s0,16(sp)
    80001844:	00813483          	ld	s1,8(sp)
    80001848:	00013903          	ld	s2,0(sp)
    8000184c:	02010113          	addi	sp,sp,32
    80001850:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80001854:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80001858:	00048c63          	beqz	s1,80001870 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    8000185c:	00048513          	mv	a0,s1
    80001860:	00000097          	auipc	ra,0x0
    80001864:	eac080e7          	jalr	-340(ra) # 8000170c <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001868:	fe0508e3          	beqz	a0,80001858 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    8000186c:	00050493          	mv	s1,a0
    if(ret){
    80001870:	fc0494e3          	bnez	s1,80001838 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001874:	00090513          	mv	a0,s2
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	cb4080e7          	jalr	-844(ra) # 8000152c <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80001880:	fa050ce3          	beqz	a0,80001838 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001884:	06093503          	ld	a0,96(s2)
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	e84080e7          	jalr	-380(ra) # 8000170c <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001890:	00050493          	mv	s1,a0
    return ret;
    80001894:	fa5ff06f          	j	80001838 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

0000000080001898 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80001898:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    8000189c:	0017d513          	srli	a0,a5,0x1
    800018a0:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    800018a4:	0027d713          	srli	a4,a5,0x2
    800018a8:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    800018ac:	0047d713          	srli	a4,a5,0x4
    800018b0:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    800018b4:	0087d713          	srli	a4,a5,0x8
    800018b8:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    800018bc:	0107d713          	srli	a4,a5,0x10
    800018c0:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    800018c4:	0207d713          	srli	a4,a5,0x20
    800018c8:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    800018cc:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800018d0:	00000713          	li	a4,0
        while(num>1){
    800018d4:	00100693          	li	a3,1
    800018d8:	00f6f863          	bgeu	a3,a5,800018e8 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    800018dc:	0017d793          	srli	a5,a5,0x1
            deg++;
    800018e0:	00170713          	addi	a4,a4,1
        while(num>1){
    800018e4:	ff1ff06f          	j	800018d4 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800018e8:	ffb70713          	addi	a4,a4,-5
    800018ec:	00c00793          	li	a5,12
    800018f0:	00e7f663          	bgeu	a5,a4,800018fc <_ZN13SlabAllocator14allocateBufferEm+0x64>
}
    800018f4:	00000513          	li	a0,0
    800018f8:	00008067          	ret
void* SlabAllocator::allocateBuffer(size_t size) {
    800018fc:	ff010113          	addi	sp,sp,-16
    80001900:	00113423          	sd	ra,8(sp)
    80001904:	00813023          	sd	s0,0(sp)
    80001908:	01010413          	addi	s0,sp,16
    SlabAllocator::allocateObject(sizeN[level]);
    8000190c:	00371713          	slli	a4,a4,0x3
    80001910:	0000a797          	auipc	a5,0xa
    80001914:	1f078793          	addi	a5,a5,496 # 8000bb00 <_ZN13SlabAllocator5sizeNE>
    80001918:	00e78733          	add	a4,a5,a4
    8000191c:	00073503          	ld	a0,0(a4)
    80001920:	00000097          	auipc	ra,0x0
    80001924:	edc080e7          	jalr	-292(ra) # 800017fc <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80001928:	00000513          	li	a0,0
    8000192c:	00813083          	ld	ra,8(sp)
    80001930:	00013403          	ld	s0,0(sp)
    80001934:	01010113          	addi	sp,sp,16
    80001938:	00008067          	ret

000000008000193c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    8000193c:	fc010113          	addi	sp,sp,-64
    80001940:	02113c23          	sd	ra,56(sp)
    80001944:	02813823          	sd	s0,48(sp)
    80001948:	02913423          	sd	s1,40(sp)
    8000194c:	03213023          	sd	s2,32(sp)
    80001950:	01313c23          	sd	s3,24(sp)
    80001954:	01413823          	sd	s4,16(sp)
    80001958:	01513423          	sd	s5,8(sp)
    8000195c:	04010413          	addi	s0,sp,64
    80001960:	00050913          	mv	s2,a0
    80001964:	00058993          	mv	s3,a1
    80001968:	00060a93          	mv	s5,a2
    8000196c:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001970:	0000a517          	auipc	a0,0xa
    80001974:	1f853503          	ld	a0,504(a0) # 8000bb68 <_ZN13SlabAllocator5cacheE>
    80001978:	00000097          	auipc	ra,0x0
    8000197c:	e84080e7          	jalr	-380(ra) # 800017fc <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001980:	00050493          	mv	s1,a0
    ret->ctor = ctor;
    80001984:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001988:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    8000198c:	06053823          	sd	zero,112(a0)
    80001990:	06053423          	sd	zero,104(a0)
    80001994:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001998:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    8000199c:	00200793          	li	a5,2
    800019a0:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    800019a4:	00050593          	mv	a1,a0
    800019a8:	00090513          	mv	a0,s2
    800019ac:	00003097          	auipc	ra,0x3
    800019b0:	fa0080e7          	jalr	-96(ra) # 8000494c <_Z6strcpyPKcPc>
}
    800019b4:	00048513          	mv	a0,s1
    800019b8:	03813083          	ld	ra,56(sp)
    800019bc:	03013403          	ld	s0,48(sp)
    800019c0:	02813483          	ld	s1,40(sp)
    800019c4:	02013903          	ld	s2,32(sp)
    800019c8:	01813983          	ld	s3,24(sp)
    800019cc:	01013a03          	ld	s4,16(sp)
    800019d0:	00813a83          	ld	s5,8(sp)
    800019d4:	04010113          	addi	sp,sp,64
    800019d8:	00008067          	ret

00000000800019dc <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800019dc:	fe010113          	addi	sp,sp,-32
    800019e0:	00113c23          	sd	ra,24(sp)
    800019e4:	00813823          	sd	s0,16(sp)
    800019e8:	00913423          	sd	s1,8(sp)
    800019ec:	01213023          	sd	s2,0(sp)
    800019f0:	02010413          	addi	s0,sp,32
    800019f4:	00050913          	mv	s2,a0
    800019f8:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    800019fc:	00001097          	auipc	ra,0x1
    80001a00:	94c080e7          	jalr	-1716(ra) # 80002348 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    80001a04:	0000a797          	auipc	a5,0xa
    80001a08:	0fc78793          	addi	a5,a5,252 # 8000bb00 <_ZN13SlabAllocator5sizeNE>
    80001a0c:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    80001a10:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001a14:	0000a717          	auipc	a4,0xa
    80001a18:	00473703          	ld	a4,4(a4) # 8000ba18 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001a1c:	00073583          	ld	a1,0(a4)
    80001a20:	00c5d593          	srli	a1,a1,0xc
    80001a24:	00158593          	addi	a1,a1,1
    80001a28:	00c59593          	slli	a1,a1,0xc
    80001a2c:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    80001a30:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001a34:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001a38:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001a3c:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001a40:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001a44:	07800793          	li	a5,120
    80001a48:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001a4c:	00200793          	li	a5,2
    80001a50:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001a54:	00007517          	auipc	a0,0x7
    80001a58:	71c50513          	addi	a0,a0,1820 # 80009170 <CONSOLE_STATUS+0x160>
    80001a5c:	00003097          	auipc	ra,0x3
    80001a60:	ef0080e7          	jalr	-272(ra) # 8000494c <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a64:	00000493          	li	s1,0
    80001a68:	0440006f          	j	80001aac <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a6c:	00349913          	slli	s2,s1,0x3
    80001a70:	0000a797          	auipc	a5,0xa
    80001a74:	e1078793          	addi	a5,a5,-496 # 8000b880 <_ZN13SlabAllocator5namesE>
    80001a78:	012787b3          	add	a5,a5,s2
    80001a7c:	00000693          	li	a3,0
    80001a80:	00000613          	li	a2,0
    80001a84:	00200593          	li	a1,2
    80001a88:	009595bb          	sllw	a1,a1,s1
    80001a8c:	0007b503          	ld	a0,0(a5)
    80001a90:	00000097          	auipc	ra,0x0
    80001a94:	eac080e7          	jalr	-340(ra) # 8000193c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a98:	0000a797          	auipc	a5,0xa
    80001a9c:	06878793          	addi	a5,a5,104 # 8000bb00 <_ZN13SlabAllocator5sizeNE>
    80001aa0:	012787b3          	add	a5,a5,s2
    80001aa4:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001aa8:	0014849b          	addiw	s1,s1,1
    80001aac:	00c00793          	li	a5,12
    80001ab0:	fa97dee3          	bge	a5,s1,80001a6c <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80001ab4:	01813083          	ld	ra,24(sp)
    80001ab8:	01013403          	ld	s0,16(sp)
    80001abc:	00813483          	ld	s1,8(sp)
    80001ac0:	00013903          	ld	s2,0(sp)
    80001ac4:	02010113          	addi	sp,sp,32
    80001ac8:	00008067          	ret

0000000080001acc <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001acc:	02053783          	ld	a5,32(a0)
    80001ad0:	0035d713          	srli	a4,a1,0x3
    80001ad4:	00e787b3          	add	a5,a5,a4
    80001ad8:	0007c683          	lbu	a3,0(a5)
    80001adc:	fff5c593          	not	a1,a1
    80001ae0:	0075f593          	andi	a1,a1,7
    80001ae4:	40b6d73b          	sraw	a4,a3,a1
    80001ae8:	00177713          	andi	a4,a4,1
    80001aec:	0c070263          	beqz	a4,80001bb0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001af0:	fe010113          	addi	sp,sp,-32
    80001af4:	00113c23          	sd	ra,24(sp)
    80001af8:	00813823          	sd	s0,16(sp)
    80001afc:	00913423          	sd	s1,8(sp)
    80001b00:	02010413          	addi	s0,sp,32
    80001b04:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001b08:	00100713          	li	a4,1
    80001b0c:	00b715bb          	sllw	a1,a4,a1
    80001b10:	fff5c593          	not	a1,a1
    80001b14:	00d5f5b3          	and	a1,a1,a3
    80001b18:	00b78023          	sb	a1,0(a5)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001b1c:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b20:	04079a63          	bnez	a5,80001b74 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001b24:	03053503          	ld	a0,48(a0)
    80001b28:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001b2c:	00178793          	addi	a5,a5,1
    80001b30:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001b34:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b38:	04e78463          	beq	a5,a4,80001b80 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001b3c:	0304b583          	ld	a1,48(s1)
    80001b40:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001b44:	04e78463          	beq	a5,a4,80001b8c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001b48:	0005b703          	ld	a4,0(a1)
    80001b4c:	00053783          	ld	a5,0(a0)
    80001b50:	00f70863          	beq	a4,a5,80001b60 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001b54:	00048613          	mv	a2,s1
    80001b58:	00000097          	auipc	ra,0x0
    80001b5c:	b60080e7          	jalr	-1184(ra) # 800016b8 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001b60:	01813083          	ld	ra,24(sp)
    80001b64:	01013403          	ld	s0,16(sp)
    80001b68:	00813483          	ld	s1,8(sp)
    80001b6c:	02010113          	addi	sp,sp,32
    80001b70:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b74:	03053503          	ld	a0,48(a0)
    80001b78:	06850513          	addi	a0,a0,104
    80001b7c:	fb1ff06f          	j	80001b2c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b80:	0304b583          	ld	a1,48(s1)
    80001b84:	06058593          	addi	a1,a1,96
    80001b88:	fbdff06f          	j	80001b44 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b8c:	00048593          	mv	a1,s1
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	ad4080e7          	jalr	-1324(ra) # 80001664 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b98:	0304b783          	ld	a5,48(s1)
    80001b9c:	0487b583          	ld	a1,72(a5)
    80001ba0:	00048513          	mv	a0,s1
    80001ba4:	00001097          	auipc	ra,0x1
    80001ba8:	a9c080e7          	jalr	-1380(ra) # 80002640 <_ZN5Buddy4freeEPvm>
    80001bac:	fb5ff06f          	j	80001b60 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001bb0:	00008067          	ret

0000000080001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001bb4:	fe010113          	addi	sp,sp,-32
    80001bb8:	00113c23          	sd	ra,24(sp)
    80001bbc:	00813823          	sd	s0,16(sp)
    80001bc0:	00913423          	sd	s1,8(sp)
    80001bc4:	01213023          	sd	s2,0(sp)
    80001bc8:	02010413          	addi	s0,sp,32
    80001bcc:	00050913          	mv	s2,a0
    80001bd0:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001bd4:	05853783          	ld	a5,88(a0)
    80001bd8:	00078663          	beqz	a5,80001be4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001bdc:	00058513          	mv	a0,a1
    80001be0:	000780e7          	jalr	a5
    if(cache->ctor)
    80001be4:	05093783          	ld	a5,80(s2)
    80001be8:	00078663          	beqz	a5,80001bf4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001bec:	00048513          	mv	a0,s1
    80001bf0:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001bf4:	07093503          	ld	a0,112(s2)
    80001bf8:	0080006f          	j	80001c00 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001bfc:	00853503          	ld	a0,8(a0)
        while(head){
    80001c00:	02050e63          	beqz	a0,80001c3c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c04:	02853703          	ld	a4,40(a0)
    80001c08:	01853783          	ld	a5,24(a0)
    80001c0c:	03053683          	ld	a3,48(a0)
    80001c10:	0406b583          	ld	a1,64(a3)
    80001c14:	02b787b3          	mul	a5,a5,a1
    80001c18:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c1c:	fef4f0e3          	bgeu	s1,a5,80001bfc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001c20:	fce4eee3          	bltu	s1,a4,80001bfc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c24:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001c28:	02b755b3          	divu	a1,a4,a1
    80001c2c:	00000097          	auipc	ra,0x0
    80001c30:	ea0080e7          	jalr	-352(ra) # 80001acc <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c34:	00100513          	li	a0,1
    80001c38:	0080006f          	j	80001c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001c3c:	00000513          	li	a0,0
    if(deleted)
    80001c40:	00050e63          	beqz	a0,80001c5c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001c44:	01813083          	ld	ra,24(sp)
    80001c48:	01013403          	ld	s0,16(sp)
    80001c4c:	00813483          	ld	s1,8(sp)
    80001c50:	00013903          	ld	s2,0(sp)
    80001c54:	02010113          	addi	sp,sp,32
    80001c58:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001c5c:	06893783          	ld	a5,104(s2)
    80001c60:	0080006f          	j	80001c68 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001c64:	0087b783          	ld	a5,8(a5)
        while(head){
    80001c68:	fc078ee3          	beqz	a5,80001c44 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c6c:	0287b683          	ld	a3,40(a5)
    80001c70:	0187b703          	ld	a4,24(a5)
    80001c74:	0307b603          	ld	a2,48(a5)
    80001c78:	04063583          	ld	a1,64(a2)
    80001c7c:	02b70733          	mul	a4,a4,a1
    80001c80:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c84:	fee4f0e3          	bgeu	s1,a4,80001c64 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001c88:	fcd4eee3          	bltu	s1,a3,80001c64 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c8c:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001c90:	02b6d5b3          	divu	a1,a3,a1
    80001c94:	00078513          	mv	a0,a5
    80001c98:	00000097          	auipc	ra,0x0
    80001c9c:	e34080e7          	jalr	-460(ra) # 80001acc <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001ca0:	00100513          	li	a0,1
    80001ca4:	fa1ff06f          	j	80001c44 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001ca8 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001ca8:	fe010113          	addi	sp,sp,-32
    80001cac:	00113c23          	sd	ra,24(sp)
    80001cb0:	00813823          	sd	s0,16(sp)
    80001cb4:	00913423          	sd	s1,8(sp)
    80001cb8:	01213023          	sd	s2,0(sp)
    80001cbc:	02010413          	addi	s0,sp,32
    80001cc0:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cc4:	00000493          	li	s1,0
    80001cc8:	00c00793          	li	a5,12
    80001ccc:	0297c863          	blt	a5,s1,80001cfc <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001cd0:	00349713          	slli	a4,s1,0x3
    80001cd4:	0000a797          	auipc	a5,0xa
    80001cd8:	e2c78793          	addi	a5,a5,-468 # 8000bb00 <_ZN13SlabAllocator5sizeNE>
    80001cdc:	00e787b3          	add	a5,a5,a4
    80001ce0:	00090593          	mv	a1,s2
    80001ce4:	0007b503          	ld	a0,0(a5)
    80001ce8:	00000097          	auipc	ra,0x0
    80001cec:	ecc080e7          	jalr	-308(ra) # 80001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001cf0:	00051663          	bnez	a0,80001cfc <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cf4:	0014849b          	addiw	s1,s1,1
    80001cf8:	fd1ff06f          	j	80001cc8 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001cfc:	01813083          	ld	ra,24(sp)
    80001d00:	01013403          	ld	s0,16(sp)
    80001d04:	00813483          	ld	s1,8(sp)
    80001d08:	00013903          	ld	s2,0(sp)
    80001d0c:	02010113          	addi	sp,sp,32
    80001d10:	00008067          	ret

0000000080001d14 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001d14:	fe010113          	addi	sp,sp,-32
    80001d18:	00113c23          	sd	ra,24(sp)
    80001d1c:	00813823          	sd	s0,16(sp)
    80001d20:	00913423          	sd	s1,8(sp)
    80001d24:	01213023          	sd	s2,0(sp)
    80001d28:	02010413          	addi	s0,sp,32
    80001d2c:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001d30:	00053903          	ld	s2,0(a0)
    80001d34:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001d38:	00093503          	ld	a0,0(s2)
    80001d3c:	02050263          	beqz	a0,80001d60 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001d40:	03053783          	ld	a5,48(a0)
    80001d44:	0487b583          	ld	a1,72(a5)
    80001d48:	00001097          	auipc	ra,0x1
    80001d4c:	8f8080e7          	jalr	-1800(ra) # 80002640 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d50:	00093783          	ld	a5,0(s2)
    80001d54:	0087b783          	ld	a5,8(a5)
    80001d58:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d5c:	fddff06f          	j	80001d38 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001d60:	0004b903          	ld	s2,0(s1)
    80001d64:	06890913          	addi	s2,s2,104
    80001d68:	00093503          	ld	a0,0(s2)
    80001d6c:	02050263          	beqz	a0,80001d90 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001d70:	03053783          	ld	a5,48(a0)
    80001d74:	0487b583          	ld	a1,72(a5)
    80001d78:	00001097          	auipc	ra,0x1
    80001d7c:	8c8080e7          	jalr	-1848(ra) # 80002640 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d80:	00093783          	ld	a5,0(s2)
    80001d84:	0087b783          	ld	a5,8(a5)
    80001d88:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d8c:	fddff06f          	j	80001d68 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001d90:	0004b903          	ld	s2,0(s1)
    80001d94:	06090913          	addi	s2,s2,96
    80001d98:	00093503          	ld	a0,0(s2)
    80001d9c:	02050263          	beqz	a0,80001dc0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001da0:	03053783          	ld	a5,48(a0)
    80001da4:	0487b583          	ld	a1,72(a5)
    80001da8:	00001097          	auipc	ra,0x1
    80001dac:	898080e7          	jalr	-1896(ra) # 80002640 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001db0:	00093783          	ld	a5,0(s2)
    80001db4:	0087b783          	ld	a5,8(a5)
    80001db8:	00f93023          	sd	a5,0(s2)
        while(head){
    80001dbc:	fddff06f          	j	80001d98 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001dc0:	0004b583          	ld	a1,0(s1)
    80001dc4:	0000a517          	auipc	a0,0xa
    80001dc8:	da453503          	ld	a0,-604(a0) # 8000bb68 <_ZN13SlabAllocator5cacheE>
    80001dcc:	00000097          	auipc	ra,0x0
    80001dd0:	de8080e7          	jalr	-536(ra) # 80001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001dd4:	0004b023          	sd	zero,0(s1)
}
    80001dd8:	01813083          	ld	ra,24(sp)
    80001ddc:	01013403          	ld	s0,16(sp)
    80001de0:	00813483          	ld	s1,8(sp)
    80001de4:	00013903          	ld	s2,0(sp)
    80001de8:	02010113          	addi	sp,sp,32
    80001dec:	00008067          	ret

0000000080001df0 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001df0:	ff010113          	addi	sp,sp,-16
    80001df4:	00813423          	sd	s0,8(sp)
    80001df8:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001dfc:	03f50513          	addi	a0,a0,63
    80001e00:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001e04:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001e08:	00100513          	li	a0,1
    asm("ecall");
    80001e0c:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001e10:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001e14:	00813403          	ld	s0,8(sp)
    80001e18:	01010113          	addi	sp,sp,16
    80001e1c:	00008067          	ret

0000000080001e20 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001e20:	ff010113          	addi	sp,sp,-16
    80001e24:	00813423          	sd	s0,8(sp)
    80001e28:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001e2c:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001e30:	00200513          	li	a0,2
    asm("ecall");
    80001e34:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e38:	00050513          	mv	a0,a0
    return status;
}
    80001e3c:	0005051b          	sext.w	a0,a0
    80001e40:	00813403          	ld	s0,8(sp)
    80001e44:	01010113          	addi	sp,sp,16
    80001e48:	00008067          	ret

0000000080001e4c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001e4c:	fd010113          	addi	sp,sp,-48
    80001e50:	02113423          	sd	ra,40(sp)
    80001e54:	02813023          	sd	s0,32(sp)
    80001e58:	00913c23          	sd	s1,24(sp)
    80001e5c:	01213823          	sd	s2,16(sp)
    80001e60:	01313423          	sd	s3,8(sp)
    80001e64:	03010413          	addi	s0,sp,48
    80001e68:	00050913          	mv	s2,a0
    80001e6c:	00058493          	mv	s1,a1
    80001e70:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001e74:	04058663          	beqz	a1,80001ec0 <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001e78:	00001537          	lui	a0,0x1
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	f74080e7          	jalr	-140(ra) # 80001df0 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001e84:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001e88:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001e8c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e90:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001e94:	01100513          	li	a0,17

    asm("ecall");
    80001e98:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e9c:	00050513          	mv	a0,a0

    return status;
}
    80001ea0:	0005051b          	sext.w	a0,a0
    80001ea4:	02813083          	ld	ra,40(sp)
    80001ea8:	02013403          	ld	s0,32(sp)
    80001eac:	01813483          	ld	s1,24(sp)
    80001eb0:	01013903          	ld	s2,16(sp)
    80001eb4:	00813983          	ld	s3,8(sp)
    80001eb8:	03010113          	addi	sp,sp,48
    80001ebc:	00008067          	ret
    uint64 istack = 0;
    80001ec0:	00000513          	li	a0,0
    80001ec4:	fc1ff06f          	j	80001e84 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

0000000080001ec8 <_Z11thread_exitv>:

int thread_exit(){
    80001ec8:	ff010113          	addi	sp,sp,-16
    80001ecc:	00813423          	sd	s0,8(sp)
    80001ed0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001ed4:	01200513          	li	a0,18

    asm("ecall");
    80001ed8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001edc:	00050513          	mv	a0,a0

    return status;
}
    80001ee0:	0005051b          	sext.w	a0,a0
    80001ee4:	00813403          	ld	s0,8(sp)
    80001ee8:	01010113          	addi	sp,sp,16
    80001eec:	00008067          	ret

0000000080001ef0 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001ef0:	ff010113          	addi	sp,sp,-16
    80001ef4:	00813423          	sd	s0,8(sp)
    80001ef8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001efc:	01300513          	li	a0,19

    asm("ecall");
    80001f00:	00000073          	ecall
}
    80001f04:	00813403          	ld	s0,8(sp)
    80001f08:	01010113          	addi	sp,sp,16
    80001f0c:	00008067          	ret

0000000080001f10 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001f10:	fd010113          	addi	sp,sp,-48
    80001f14:	02113423          	sd	ra,40(sp)
    80001f18:	02813023          	sd	s0,32(sp)
    80001f1c:	00913c23          	sd	s1,24(sp)
    80001f20:	01213823          	sd	s2,16(sp)
    80001f24:	01313423          	sd	s3,8(sp)
    80001f28:	03010413          	addi	s0,sp,48
    80001f2c:	00050913          	mv	s2,a0
    80001f30:	00058493          	mv	s1,a1
    80001f34:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001f38:	04058663          	beqz	a1,80001f84 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001f3c:	00001537          	lui	a0,0x1
    80001f40:	00000097          	auipc	ra,0x0
    80001f44:	eb0080e7          	jalr	-336(ra) # 80001df0 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001f48:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001f4c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001f50:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f54:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    80001f58:	01400513          	li	a0,20

    asm("ecall");
    80001f5c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f60:	00050513          	mv	a0,a0

    return status;
}
    80001f64:	0005051b          	sext.w	a0,a0
    80001f68:	02813083          	ld	ra,40(sp)
    80001f6c:	02013403          	ld	s0,32(sp)
    80001f70:	01813483          	ld	s1,24(sp)
    80001f74:	01013903          	ld	s2,16(sp)
    80001f78:	00813983          	ld	s3,8(sp)
    80001f7c:	03010113          	addi	sp,sp,48
    80001f80:	00008067          	ret
    uint64 istack = 0;
    80001f84:	00000513          	li	a0,0
    80001f88:	fc1ff06f          	j	80001f48 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

0000000080001f8c <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001f8c:	ff010113          	addi	sp,sp,-16
    80001f90:	00813423          	sd	s0,8(sp)
    80001f94:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f98:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001f9c:	01500513          	li	a0,21

    asm("ecall");
    80001fa0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fa4:	00050513          	mv	a0,a0

    return status;
}
    80001fa8:	0005051b          	sext.w	a0,a0
    80001fac:	00813403          	ld	s0,8(sp)
    80001fb0:	01010113          	addi	sp,sp,16
    80001fb4:	00008067          	ret

0000000080001fb8 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001fb8:	ff010113          	addi	sp,sp,-16
    80001fbc:	00813423          	sd	s0,8(sp)
    80001fc0:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001fc4:	02059593          	slli	a1,a1,0x20
    80001fc8:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001fcc:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fd0:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001fd4:	02100513          	li	a0,33


    asm("ecall");
    80001fd8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fdc:	00050513          	mv	a0,a0

    return status;

}
    80001fe0:	0005051b          	sext.w	a0,a0
    80001fe4:	00813403          	ld	s0,8(sp)
    80001fe8:	01010113          	addi	sp,sp,16
    80001fec:	00008067          	ret

0000000080001ff0 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001ff0:	ff010113          	addi	sp,sp,-16
    80001ff4:	00813423          	sd	s0,8(sp)
    80001ff8:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001ffc:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80002000:	02200513          	li	a0,34


    asm("ecall");
    80002004:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002008:	00050513          	mv	a0,a0

    return status;
}
    8000200c:	0005051b          	sext.w	a0,a0
    80002010:	00813403          	ld	s0,8(sp)
    80002014:	01010113          	addi	sp,sp,16
    80002018:	00008067          	ret

000000008000201c <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    8000201c:	ff010113          	addi	sp,sp,-16
    80002020:	00813423          	sd	s0,8(sp)
    80002024:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002028:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    8000202c:	02300513          	li	a0,35


    asm("ecall");
    80002030:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002034:	00050513          	mv	a0,a0

    return status;
}
    80002038:	0005051b          	sext.w	a0,a0
    8000203c:	00813403          	ld	s0,8(sp)
    80002040:	01010113          	addi	sp,sp,16
    80002044:	00008067          	ret

0000000080002048 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80002048:	ff010113          	addi	sp,sp,-16
    8000204c:	00813423          	sd	s0,8(sp)
    80002050:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002054:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80002058:	02400513          	li	a0,36


    asm("ecall");
    8000205c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002060:	00050513          	mv	a0,a0

    return status;
}
    80002064:	0005051b          	sext.w	a0,a0
    80002068:	00813403          	ld	s0,8(sp)
    8000206c:	01010113          	addi	sp,sp,16
    80002070:	00008067          	ret

0000000080002074 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80002074:	ff010113          	addi	sp,sp,-16
    80002078:	00813423          	sd	s0,8(sp)
    8000207c:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    80002080:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80002084:	03100513          	li	a0,49


    asm("ecall");
    80002088:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000208c:	00050513          	mv	a0,a0

    return status;
}
    80002090:	0005051b          	sext.w	a0,a0
    80002094:	00813403          	ld	s0,8(sp)
    80002098:	01010113          	addi	sp,sp,16
    8000209c:	00008067          	ret

00000000800020a0 <_Z4getcv>:

char getc(){
    800020a0:	ff010113          	addi	sp,sp,-16
    800020a4:	00813423          	sd	s0,8(sp)
    800020a8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    800020ac:	04100513          	li	a0,65

    asm("ecall");
    800020b0:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    800020b4:	00050513          	mv	a0,a0

    return c;
}
    800020b8:	0ff57513          	andi	a0,a0,255
    800020bc:	00813403          	ld	s0,8(sp)
    800020c0:	01010113          	addi	sp,sp,16
    800020c4:	00008067          	ret

00000000800020c8 <_Z4putcc>:

void putc(char c){
    800020c8:	ff010113          	addi	sp,sp,-16
    800020cc:	00813423          	sd	s0,8(sp)
    800020d0:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    800020d4:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    800020d8:	04200513          	li	a0,66

    asm("ecall");
    800020dc:	00000073          	ecall
}
    800020e0:	00813403          	ld	s0,8(sp)
    800020e4:	01010113          	addi	sp,sp,16
    800020e8:	00008067          	ret

00000000800020ec <_Z4forkv>:


int fork(){
    800020ec:	ff010113          	addi	sp,sp,-16
    800020f0:	00813423          	sd	s0,8(sp)
    800020f4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    800020f8:	06100513          	li	a0,97

    asm("ecall");
    800020fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002100:	00050513          	mv	a0,a0

    return status;
}
    80002104:	0005051b          	sext.w	a0,a0
    80002108:	00813403          	ld	s0,8(sp)
    8000210c:	01010113          	addi	sp,sp,16
    80002110:	00008067          	ret

0000000080002114 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80002114:	ff010113          	addi	sp,sp,-16
    80002118:	00113423          	sd	ra,8(sp)
    8000211c:	00813023          	sd	s0,0(sp)
    80002120:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80002124:	00000097          	auipc	ra,0x0
    80002128:	ecc080e7          	jalr	-308(ra) # 80001ff0 <_Z9sem_closeP10_semaphore>
}
    8000212c:	00813083          	ld	ra,8(sp)
    80002130:	00013403          	ld	s0,0(sp)
    80002134:	01010113          	addi	sp,sp,16
    80002138:	00008067          	ret

000000008000213c <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    8000213c:	ff010113          	addi	sp,sp,-16
    80002140:	00113423          	sd	ra,8(sp)
    80002144:	00813023          	sd	s0,0(sp)
    80002148:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    8000214c:	00001097          	auipc	ra,0x1
    80002150:	f30080e7          	jalr	-208(ra) # 8000307c <_ZN3TCB11thread_freeEPv>
    80002154:	00813083          	ld	ra,8(sp)
    80002158:	00013403          	ld	s0,0(sp)
    8000215c:	01010113          	addi	sp,sp,16
    80002160:	00008067          	ret

0000000080002164 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002164:	ff010113          	addi	sp,sp,-16
    80002168:	00113423          	sd	ra,8(sp)
    8000216c:	00813023          	sd	s0,0(sp)
    80002170:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80002174:	00004097          	auipc	ra,0x4
    80002178:	834080e7          	jalr	-1996(ra) # 800059a8 <_Z8userMainv>
    8000217c:	00813083          	ld	ra,8(sp)
    80002180:	00013403          	ld	s0,0(sp)
    80002184:	01010113          	addi	sp,sp,16
    80002188:	00008067          	ret

000000008000218c <_ZN6SystemC1Ev>:
    if (!initialized) {
    8000218c:	0000a797          	auipc	a5,0xa
    80002190:	9f47c783          	lbu	a5,-1548(a5) # 8000bb80 <_ZN6System11initializedE>
    80002194:	00078463          	beqz	a5,8000219c <_ZN6SystemC1Ev+0x10>
    80002198:	00008067          	ret
System::System() {
    8000219c:	99010113          	addi	sp,sp,-1648
    800021a0:	66113423          	sd	ra,1640(sp)
    800021a4:	66813023          	sd	s0,1632(sp)
    800021a8:	64913c23          	sd	s1,1624(sp)
    800021ac:	65213823          	sd	s2,1616(sp)
    800021b0:	67010413          	addi	s0,sp,1648
        initialized = true;
    800021b4:	00100793          	li	a5,1
    800021b8:	0000a717          	auipc	a4,0xa
    800021bc:	9cf70423          	sb	a5,-1592(a4) # 8000bb80 <_ZN6System11initializedE>
        RiscV::initialize();
    800021c0:	00002097          	auipc	ra,0x2
    800021c4:	874080e7          	jalr	-1932(ra) # 80003a34 <_ZN5RiscV10initializeEv>
        kmem_cache_t* cache1 = kmem_cache_create("Cache 1", sizeof(Test), nullptr, nullptr);
    800021c8:	00000693          	li	a3,0
    800021cc:	00000613          	li	a2,0
    800021d0:	03000593          	li	a1,48
    800021d4:	00007517          	auipc	a0,0x7
    800021d8:	0e450513          	addi	a0,a0,228 # 800092b8 <CONSOLE_STATUS+0x2a8>
    800021dc:	00003097          	auipc	ra,0x3
    800021e0:	e68080e7          	jalr	-408(ra) # 80005044 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800021e4:	00050913          	mv	s2,a0
        for(int i = 0; i<size; i++)
    800021e8:	00000493          	li	s1,0
    800021ec:	0c700793          	li	a5,199
    800021f0:	0297c463          	blt	a5,s1,80002218 <_ZN6SystemC1Ev+0x8c>
            mem[i] = kmem_cache_alloc(cache1);
    800021f4:	00090513          	mv	a0,s2
    800021f8:	00003097          	auipc	ra,0x3
    800021fc:	e74080e7          	jalr	-396(ra) # 8000506c <_Z16kmem_cache_allocP5Cache>
    80002200:	00349793          	slli	a5,s1,0x3
    80002204:	fe040713          	addi	a4,s0,-32
    80002208:	00f707b3          	add	a5,a4,a5
    8000220c:	9ca7b023          	sd	a0,-1600(a5)
        for(int i = 0; i<size; i++)
    80002210:	0014849b          	addiw	s1,s1,1
    80002214:	fd9ff06f          	j	800021ec <_ZN6SystemC1Ev+0x60>
        kmem_cache_info(cache1);
    80002218:	00090513          	mv	a0,s2
    8000221c:	00003097          	auipc	ra,0x3
    80002220:	ed0080e7          	jalr	-304(ra) # 800050ec <_Z15kmem_cache_infoP5Cache>
        for(int i=0;i<size;i++)
    80002224:	00000493          	li	s1,0
    80002228:	0c700793          	li	a5,199
    8000222c:	0297c463          	blt	a5,s1,80002254 <_ZN6SystemC1Ev+0xc8>
            kmem_cache_free(cache1, mem[i]);
    80002230:	00349793          	slli	a5,s1,0x3
    80002234:	fe040713          	addi	a4,s0,-32
    80002238:	00f707b3          	add	a5,a4,a5
    8000223c:	9c07b583          	ld	a1,-1600(a5)
    80002240:	00090513          	mv	a0,s2
    80002244:	00003097          	auipc	ra,0x3
    80002248:	e50080e7          	jalr	-432(ra) # 80005094 <_Z15kmem_cache_freeP5CachePv>
        for(int i=0;i<size;i++)
    8000224c:	0014849b          	addiw	s1,s1,1
    80002250:	fd9ff06f          	j	80002228 <_ZN6SystemC1Ev+0x9c>
        kmem_cache_destroy(cache1);
    80002254:	00090513          	mv	a0,s2
    80002258:	00003097          	auipc	ra,0x3
    8000225c:	e64080e7          	jalr	-412(ra) # 800050bc <_Z18kmem_cache_destroyP5Cache>
        for(int i=0; i<BUCKET_SIZE;i++)
    80002260:	00000493          	li	s1,0
    80002264:	00c00793          	li	a5,12
    80002268:	0297c263          	blt	a5,s1,8000228c <_ZN6SystemC1Ev+0x100>
            SlabAllocator::deleteCache(SlabAllocator::sizeN[i]);
    8000226c:	00349793          	slli	a5,s1,0x3
    80002270:	00009517          	auipc	a0,0x9
    80002274:	7b053503          	ld	a0,1968(a0) # 8000ba20 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002278:	00f50533          	add	a0,a0,a5
    8000227c:	00000097          	auipc	ra,0x0
    80002280:	a98080e7          	jalr	-1384(ra) # 80001d14 <_ZN13SlabAllocator11deleteCacheERP5Cache>
        for(int i=0; i<BUCKET_SIZE;i++)
    80002284:	0014849b          	addiw	s1,s1,1
    80002288:	fddff06f          	j	80002264 <_ZN6SystemC1Ev+0xd8>
        Buddy::printList();
    8000228c:	00000097          	auipc	ra,0x0
    80002290:	540080e7          	jalr	1344(ra) # 800027cc <_ZN5Buddy9printListEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80002294:	00000613          	li	a2,0
    80002298:	00000597          	auipc	a1,0x0
    8000229c:	ecc58593          	addi	a1,a1,-308 # 80002164 <_ZN6System15userMainWrapperEPv>
    800022a0:	99840513          	addi	a0,s0,-1640
    800022a4:	00000097          	auipc	ra,0x0
    800022a8:	ba8080e7          	jalr	-1112(ra) # 80001e4c <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    800022ac:	99843783          	ld	a5,-1640(s0)
    800022b0:	0107a703          	lw	a4,16(a5)
    800022b4:	00200793          	li	a5,2
    800022b8:	00f70863          	beq	a4,a5,800022c8 <_ZN6SystemC1Ev+0x13c>
            thread_dispatch();
    800022bc:	00000097          	auipc	ra,0x0
    800022c0:	c34080e7          	jalr	-972(ra) # 80001ef0 <_Z15thread_dispatchv>
    800022c4:	fe9ff06f          	j	800022ac <_ZN6SystemC1Ev+0x120>
        RiscV::finalize();
    800022c8:	00002097          	auipc	ra,0x2
    800022cc:	968080e7          	jalr	-1688(ra) # 80003c30 <_ZN5RiscV8finalizeEv>
}
    800022d0:	66813083          	ld	ra,1640(sp)
    800022d4:	66013403          	ld	s0,1632(sp)
    800022d8:	65813483          	ld	s1,1624(sp)
    800022dc:	65013903          	ld	s2,1616(sp)
    800022e0:	67010113          	addi	sp,sp,1648
    800022e4:	00008067          	ret

00000000800022e8 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    800022e8:	ff010113          	addi	sp,sp,-16
    800022ec:	00813423          	sd	s0,8(sp)
    800022f0:	01010413          	addi	s0,sp,16
    800022f4:	00100793          	li	a5,1
    800022f8:	00f50863          	beq	a0,a5,80002308 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800022fc:	00813403          	ld	s0,8(sp)
    80002300:	01010113          	addi	sp,sp,16
    80002304:	00008067          	ret
    80002308:	000107b7          	lui	a5,0x10
    8000230c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002310:	fef596e3          	bne	a1,a5,800022fc <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80002314:	00009797          	auipc	a5,0x9
    80002318:	7047b783          	ld	a5,1796(a5) # 8000ba18 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000231c:	0007b703          	ld	a4,0(a5)
    80002320:	00c75793          	srli	a5,a4,0xc
    80002324:	00278793          	addi	a5,a5,2
    80002328:	00c79793          	slli	a5,a5,0xc
    8000232c:	0000a697          	auipc	a3,0xa
    80002330:	85c68693          	addi	a3,a3,-1956 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002334:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002338:	fffff7b7          	lui	a5,0xfffff
    8000233c:	00f77733          	and	a4,a4,a5
    80002340:	00e6b423          	sd	a4,8(a3)
    80002344:	fb9ff06f          	j	800022fc <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002348 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80002348:	ff010113          	addi	sp,sp,-16
    8000234c:	00813423          	sd	s0,8(sp)
    80002350:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80002354:	0000a717          	auipc	a4,0xa
    80002358:	83470713          	addi	a4,a4,-1996 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000235c:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002360:	00009797          	auipc	a5,0x9
    80002364:	6b87b783          	ld	a5,1720(a5) # 8000ba18 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002368:	0007b783          	ld	a5,0(a5)
    8000236c:	fffff6b7          	lui	a3,0xfffff
    80002370:	00d7f7b3          	and	a5,a5,a3
    80002374:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80002378:	00009797          	auipc	a5,0x9
    8000237c:	56b7b823          	sd	a1,1392(a5) # 8000b8e8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80002380:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80002384:	00000713          	li	a4,0
        while(num>1){
    80002388:	00100693          	li	a3,1
    8000238c:	00f6f863          	bgeu	a3,a5,8000239c <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80002390:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002394:	00170713          	addi	a4,a4,1
        while(num>1){
    80002398:	ff1ff06f          	j	80002388 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    8000239c:	00371713          	slli	a4,a4,0x3
    800023a0:	00009797          	auipc	a5,0x9
    800023a4:	7e878793          	addi	a5,a5,2024 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023a8:	00e78733          	add	a4,a5,a4
    800023ac:	00a73823          	sd	a0,16(a4)
    800023b0:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800023b4:	00000713          	li	a4,0
        while(num>1){
    800023b8:	00100693          	li	a3,1
    800023bc:	00f6f863          	bgeu	a3,a5,800023cc <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    800023c0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800023c4:	00170713          	addi	a4,a4,1
        while(num>1){
    800023c8:	ff1ff06f          	j	800023b8 <_ZN5Buddy10initializeEPvm+0x70>
    800023cc:	00371713          	slli	a4,a4,0x3
    800023d0:	00009797          	auipc	a5,0x9
    800023d4:	7b878793          	addi	a5,a5,1976 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023d8:	00e78733          	add	a4,a5,a4
    800023dc:	06a73c23          	sd	a0,120(a4)
    800023e0:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800023e4:	00000713          	li	a4,0
        while(num>1){
    800023e8:	00100693          	li	a3,1
    800023ec:	00f6f863          	bgeu	a3,a5,800023fc <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    800023f0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800023f4:	00170713          	addi	a4,a4,1
        while(num>1){
    800023f8:	ff1ff06f          	j	800023e8 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    800023fc:	00371713          	slli	a4,a4,0x3
    80002400:	00009797          	auipc	a5,0x9
    80002404:	78878793          	addi	a5,a5,1928 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002408:	00e78733          	add	a4,a5,a4
    8000240c:	01073783          	ld	a5,16(a4)
    80002410:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80002414:	00000793          	li	a5,0
    80002418:	00c0006f          	j	80002424 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    8000241c:	0015d593          	srli	a1,a1,0x1
            deg++;
    80002420:	00178793          	addi	a5,a5,1
        while(num>1){
    80002424:	00100713          	li	a4,1
    80002428:	feb76ae3          	bltu	a4,a1,8000241c <_ZN5Buddy10initializeEPvm+0xd4>
    8000242c:	00379793          	slli	a5,a5,0x3
    80002430:	00009717          	auipc	a4,0x9
    80002434:	75870713          	addi	a4,a4,1880 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002438:	00f707b3          	add	a5,a4,a5
    8000243c:	0787b783          	ld	a5,120(a5)
    80002440:	0007b023          	sd	zero,0(a5)
}
    80002444:	00813403          	ld	s0,8(sp)
    80002448:	01010113          	addi	sp,sp,16
    8000244c:	00008067          	ret

0000000080002450 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80002450:	00c00793          	li	a5,12
    80002454:	10f50063          	beq	a0,a5,80002554 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80002458:	fd010113          	addi	sp,sp,-48
    8000245c:	02113423          	sd	ra,40(sp)
    80002460:	02813023          	sd	s0,32(sp)
    80002464:	00913c23          	sd	s1,24(sp)
    80002468:	01213823          	sd	s2,16(sp)
    8000246c:	01313423          	sd	s3,8(sp)
    80002470:	03010413          	addi	s0,sp,48
    80002474:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002478:	00351713          	slli	a4,a0,0x3
    8000247c:	00009797          	auipc	a5,0x9
    80002480:	70c78793          	addi	a5,a5,1804 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002484:	00e787b3          	add	a5,a5,a4
    80002488:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    8000248c:	00000993          	li	s3,0
    80002490:	0180006f          	j	800024a8 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002494:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002498:	04f70463          	beq	a4,a5,800024e0 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    8000249c:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    800024a0:	08f70063          	beq	a4,a5,80002520 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    800024a4:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    800024a8:	08048863          	beqz	s1,80002538 <_ZN5Buddy8compressEm+0xe8>
    800024ac:	0004b683          	ld	a3,0(s1)
    800024b0:	08068463          	beqz	a3,80002538 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800024b4:	00009797          	auipc	a5,0x9
    800024b8:	6d47b783          	ld	a5,1748(a5) # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024bc:	40f48733          	sub	a4,s1,a5
    800024c0:	00c9061b          	addiw	a2,s2,12
    800024c4:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800024c8:	40f687b3          	sub	a5,a3,a5
    800024cc:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800024d0:	00177613          	andi	a2,a4,1
    800024d4:	fc0610e3          	bnez	a2,80002494 <_ZN5Buddy8compressEm+0x44>
    800024d8:	00170713          	addi	a4,a4,1
    800024dc:	fbdff06f          	j	80002498 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    800024e0:	00098863          	beqz	s3,800024f0 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    800024e4:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffee060>
    800024e8:	00d9b023          	sd	a3,0(s3)
    800024ec:	fb5ff06f          	j	800024a0 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    800024f0:	0006b603          	ld	a2,0(a3)
    800024f4:	00391593          	slli	a1,s2,0x3
    800024f8:	00009697          	auipc	a3,0x9
    800024fc:	69068693          	addi	a3,a3,1680 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002500:	00b686b3          	add	a3,a3,a1
    80002504:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    80002508:	f8061ce3          	bnez	a2,800024a0 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    8000250c:	00009697          	auipc	a3,0x9
    80002510:	67c68693          	addi	a3,a3,1660 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002514:	00b686b3          	add	a3,a3,a1
    80002518:	0006b823          	sd	zero,16(a3)
    8000251c:	f85ff06f          	j	800024a0 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002520:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80002524:	00190593          	addi	a1,s2,1
    80002528:	00048513          	mv	a0,s1
    8000252c:	00000097          	auipc	ra,0x0
    80002530:	02c080e7          	jalr	44(ra) # 80002558 <_ZN5Buddy6insertEPvm>
    80002534:	f71ff06f          	j	800024a4 <_ZN5Buddy8compressEm+0x54>
}
    80002538:	02813083          	ld	ra,40(sp)
    8000253c:	02013403          	ld	s0,32(sp)
    80002540:	01813483          	ld	s1,24(sp)
    80002544:	01013903          	ld	s2,16(sp)
    80002548:	00813983          	ld	s3,8(sp)
    8000254c:	03010113          	addi	sp,sp,48
    80002550:	00008067          	ret
    80002554:	00008067          	ret

0000000080002558 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002558:	00050693          	mv	a3,a0
    if(!head[size]){
    8000255c:	00359713          	slli	a4,a1,0x3
    80002560:	00009797          	auipc	a5,0x9
    80002564:	62878793          	addi	a5,a5,1576 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002568:	00e787b3          	add	a5,a5,a4
    8000256c:	0787b783          	ld	a5,120(a5)
    80002570:	02078c63          	beqz	a5,800025a8 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002574:	ff010113          	addi	sp,sp,-16
    80002578:	00113423          	sd	ra,8(sp)
    8000257c:	00813023          	sd	s0,0(sp)
    80002580:	01010413          	addi	s0,sp,16
    80002584:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002588:	00068713          	mv	a4,a3
    8000258c:	04f6e063          	bltu	a3,a5,800025cc <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002590:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002594:	06078863          	beqz	a5,80002604 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002598:	04f76c63          	bltu	a4,a5,800025f0 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    8000259c:	00078613          	mv	a2,a5
                    iter = iter->next;
    800025a0:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    800025a4:	ff1ff06f          	j	80002594 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    800025a8:	00009797          	auipc	a5,0x9
    800025ac:	5e078793          	addi	a5,a5,1504 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025b0:	00e78533          	add	a0,a5,a4
    800025b4:	00d53823          	sd	a3,16(a0)
    800025b8:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    800025bc:	0006b023          	sd	zero,0(a3)
    800025c0:	07853783          	ld	a5,120(a0)
    800025c4:	0007b023          	sd	zero,0(a5)
        return;
    800025c8:	00008067          	ret
            newHead->next = head[size];
    800025cc:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800025d0:	00359713          	slli	a4,a1,0x3
    800025d4:	00009797          	auipc	a5,0x9
    800025d8:	5b478793          	addi	a5,a5,1460 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025dc:	00e787b3          	add	a5,a5,a4
    800025e0:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    800025e4:	00000097          	auipc	ra,0x0
    800025e8:	e6c080e7          	jalr	-404(ra) # 80002450 <_ZN5Buddy8compressEm>
            return;
    800025ec:	0440006f          	j	80002630 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    800025f0:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800025f4:	00d63023          	sd	a3,0(a2)
                    compress(size);
    800025f8:	00000097          	auipc	ra,0x0
    800025fc:	e58080e7          	jalr	-424(ra) # 80002450 <_ZN5Buddy8compressEm>
                    return;
    80002600:	0300006f          	j	80002630 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80002604:	00351713          	slli	a4,a0,0x3
    80002608:	00009797          	auipc	a5,0x9
    8000260c:	58078793          	addi	a5,a5,1408 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002610:	00e787b3          	add	a5,a5,a4
    80002614:	0107b703          	ld	a4,16(a5)
    80002618:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    8000261c:	0107b703          	ld	a4,16(a5)
    80002620:	00073703          	ld	a4,0(a4)
    80002624:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80002628:	00000097          	auipc	ra,0x0
    8000262c:	e28080e7          	jalr	-472(ra) # 80002450 <_ZN5Buddy8compressEm>
}
    80002630:	00813083          	ld	ra,8(sp)
    80002634:	00013403          	ld	s0,0(sp)
    80002638:	01010113          	addi	sp,sp,16
    8000263c:	00008067          	ret

0000000080002640 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80002640:	02050663          	beqz	a0,8000266c <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80002644:	ff010113          	addi	sp,sp,-16
    80002648:	00113423          	sd	ra,8(sp)
    8000264c:	00813023          	sd	s0,0(sp)
    80002650:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80002654:	00000097          	auipc	ra,0x0
    80002658:	f04080e7          	jalr	-252(ra) # 80002558 <_ZN5Buddy6insertEPvm>
}
    8000265c:	00813083          	ld	ra,8(sp)
    80002660:	00013403          	ld	s0,0(sp)
    80002664:	01010113          	addi	sp,sp,16
    80002668:	00008067          	ret
    8000266c:	00008067          	ret

0000000080002670 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002670:	ff010113          	addi	sp,sp,-16
    80002674:	00813423          	sd	s0,8(sp)
    80002678:	01010413          	addi	s0,sp,16
    8000267c:	03c0006f          	j	800026b8 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002680:	00b5859b          	addiw	a1,a1,11
    80002684:	00100713          	li	a4,1
    80002688:	00b715bb          	sllw	a1,a4,a1
    8000268c:	00b505b3          	add	a1,a0,a1
    80002690:	00379693          	slli	a3,a5,0x3
    80002694:	00009717          	auipc	a4,0x9
    80002698:	4f470713          	addi	a4,a4,1268 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000269c:	00d70733          	add	a4,a4,a3
    800026a0:	00b73823          	sd	a1,16(a4)
    800026a4:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    800026a8:	0005b023          	sd	zero,0(a1)
    800026ac:	07873703          	ld	a4,120(a4)
    800026b0:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800026b4:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    800026b8:	fff5879b          	addiw	a5,a1,-1
    800026bc:	04c7c863          	blt	a5,a2,8000270c <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    800026c0:	00379693          	slli	a3,a5,0x3
    800026c4:	00009717          	auipc	a4,0x9
    800026c8:	4c470713          	addi	a4,a4,1220 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026cc:	00d70733          	add	a4,a4,a3
    800026d0:	01073683          	ld	a3,16(a4)
    800026d4:	fa0686e3          	beqz	a3,80002680 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800026d8:	00b5859b          	addiw	a1,a1,11
    800026dc:	00100713          	li	a4,1
    800026e0:	00b715bb          	sllw	a1,a4,a1
    800026e4:	00b505b3          	add	a1,a0,a1
    800026e8:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800026ec:	00379693          	slli	a3,a5,0x3
    800026f0:	00009717          	auipc	a4,0x9
    800026f4:	49870713          	addi	a4,a4,1176 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026f8:	00d70733          	add	a4,a4,a3
    800026fc:	01073683          	ld	a3,16(a4)
    80002700:	0006b683          	ld	a3,0(a3)
    80002704:	00d73823          	sd	a3,16(a4)
    80002708:	fadff06f          	j	800026b4 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    8000270c:	00813403          	ld	s0,8(sp)
    80002710:	01010113          	addi	sp,sp,16
    80002714:	00008067          	ret

0000000080002718 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80002718:	fe010113          	addi	sp,sp,-32
    8000271c:	00113c23          	sd	ra,24(sp)
    80002720:	00813823          	sd	s0,16(sp)
    80002724:	00913423          	sd	s1,8(sp)
    80002728:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    8000272c:	00c00793          	li	a5,12
    80002730:	06a7ec63          	bltu	a5,a0,800027a8 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002734:	00050593          	mv	a1,a0
    80002738:	00c00793          	li	a5,12
    8000273c:	06b7ea63          	bltu	a5,a1,800027b0 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80002740:	00359713          	slli	a4,a1,0x3
    80002744:	00009797          	auipc	a5,0x9
    80002748:	44478793          	addi	a5,a5,1092 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000274c:	00e787b3          	add	a5,a5,a4
    80002750:	0787b483          	ld	s1,120(a5)
    80002754:	00049663          	bnez	s1,80002760 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002758:	00158593          	addi	a1,a1,1
    8000275c:	fddff06f          	j	80002738 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80002760:	0004b703          	ld	a4,0(s1)
    80002764:	00359693          	slli	a3,a1,0x3
    80002768:	00009797          	auipc	a5,0x9
    8000276c:	42078793          	addi	a5,a5,1056 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002770:	00d787b3          	add	a5,a5,a3
    80002774:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002778:	00070e63          	beqz	a4,80002794 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    8000277c:	0005061b          	sext.w	a2,a0
    80002780:	0005859b          	sext.w	a1,a1
    80002784:	00048513          	mv	a0,s1
    80002788:	00000097          	auipc	ra,0x0
    8000278c:	ee8080e7          	jalr	-280(ra) # 80002670 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002790:	0240006f          	j	800027b4 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002794:	00009797          	auipc	a5,0x9
    80002798:	3f478793          	addi	a5,a5,1012 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000279c:	00d787b3          	add	a5,a5,a3
    800027a0:	0007b823          	sd	zero,16(a5)
    800027a4:	fd9ff06f          	j	8000277c <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    800027a8:	00000493          	li	s1,0
    800027ac:	0080006f          	j	800027b4 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    800027b0:	00000493          	li	s1,0
}
    800027b4:	00048513          	mv	a0,s1
    800027b8:	01813083          	ld	ra,24(sp)
    800027bc:	01013403          	ld	s0,16(sp)
    800027c0:	00813483          	ld	s1,8(sp)
    800027c4:	02010113          	addi	sp,sp,32
    800027c8:	00008067          	ret

00000000800027cc <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    800027cc:	fe010113          	addi	sp,sp,-32
    800027d0:	00113c23          	sd	ra,24(sp)
    800027d4:	00813823          	sd	s0,16(sp)
    800027d8:	00913423          	sd	s1,8(sp)
    800027dc:	01213023          	sd	s2,0(sp)
    800027e0:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    800027e4:	00000913          	li	s2,0
    800027e8:	0180006f          	j	80002800 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800027ec:	00007517          	auipc	a0,0x7
    800027f0:	b5c50513          	addi	a0,a0,-1188 # 80009348 <CONSOLE_STATUS+0x338>
    800027f4:	00002097          	auipc	ra,0x2
    800027f8:	680080e7          	jalr	1664(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800027fc:	0019091b          	addiw	s2,s2,1
    80002800:	00c00793          	li	a5,12
    80002804:	0727c663          	blt	a5,s2,80002870 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002808:	00000613          	li	a2,0
    8000280c:	00a00593          	li	a1,10
    80002810:	00090513          	mv	a0,s2
    80002814:	00002097          	auipc	ra,0x2
    80002818:	6a4080e7          	jalr	1700(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    8000281c:	00007517          	auipc	a0,0x7
    80002820:	aa450513          	addi	a0,a0,-1372 # 800092c0 <CONSOLE_STATUS+0x2b0>
    80002824:	00002097          	auipc	ra,0x2
    80002828:	650080e7          	jalr	1616(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    8000282c:	00391713          	slli	a4,s2,0x3
    80002830:	00009797          	auipc	a5,0x9
    80002834:	35878793          	addi	a5,a5,856 # 8000bb88 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002838:	00e787b3          	add	a5,a5,a4
    8000283c:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002840:	fa0486e3          	beqz	s1,800027ec <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    80002844:	00000613          	li	a2,0
    80002848:	00a00593          	li	a1,10
    8000284c:	0004851b          	sext.w	a0,s1
    80002850:	00002097          	auipc	ra,0x2
    80002854:	668080e7          	jalr	1640(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002858:	00007517          	auipc	a0,0x7
    8000285c:	89050513          	addi	a0,a0,-1904 # 800090e8 <CONSOLE_STATUS+0xd8>
    80002860:	00002097          	auipc	ra,0x2
    80002864:	614080e7          	jalr	1556(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002868:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    8000286c:	fd5ff06f          	j	80002840 <_ZN5Buddy9printListEv+0x74>
    80002870:	01813083          	ld	ra,24(sp)
    80002874:	01013403          	ld	s0,16(sp)
    80002878:	00813483          	ld	s1,8(sp)
    8000287c:	00013903          	ld	s2,0(sp)
    80002880:	02010113          	addi	sp,sp,32
    80002884:	00008067          	ret

0000000080002888 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002888:	ff010113          	addi	sp,sp,-16
    8000288c:	00113423          	sd	ra,8(sp)
    80002890:	00813023          	sd	s0,0(sp)
    80002894:	01010413          	addi	s0,sp,16
    80002898:	000105b7          	lui	a1,0x10
    8000289c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800028a0:	00100513          	li	a0,1
    800028a4:	00000097          	auipc	ra,0x0
    800028a8:	a44080e7          	jalr	-1468(ra) # 800022e8 <_Z41__static_initialization_and_destruction_0ii>
    800028ac:	00813083          	ld	ra,8(sp)
    800028b0:	00013403          	ld	s0,0(sp)
    800028b4:	01010113          	addi	sp,sp,16
    800028b8:	00008067          	ret

00000000800028bc <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800028bc:	fe010113          	addi	sp,sp,-32
    800028c0:	00113c23          	sd	ra,24(sp)
    800028c4:	00813823          	sd	s0,16(sp)
    800028c8:	00913423          	sd	s1,8(sp)
    800028cc:	02010413          	addi	s0,sp,32
    800028d0:	00050493          	mv	s1,a0
    LOCK();
    800028d4:	00100613          	li	a2,1
    800028d8:	00000593          	li	a1,0
    800028dc:	00009517          	auipc	a0,0x9
    800028e0:	38c50513          	addi	a0,a0,908 # 8000bc68 <lockPrint>
    800028e4:	ffffe097          	auipc	ra,0xffffe
    800028e8:	71c080e7          	jalr	1820(ra) # 80001000 <copy_and_swap>
    800028ec:	fe0514e3          	bnez	a0,800028d4 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800028f0:	0004c503          	lbu	a0,0(s1)
    800028f4:	00050a63          	beqz	a0,80002908 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800028f8:	fffff097          	auipc	ra,0xfffff
    800028fc:	7d0080e7          	jalr	2000(ra) # 800020c8 <_Z4putcc>
        string++;
    80002900:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002904:	fedff06f          	j	800028f0 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002908:	00000613          	li	a2,0
    8000290c:	00100593          	li	a1,1
    80002910:	00009517          	auipc	a0,0x9
    80002914:	35850513          	addi	a0,a0,856 # 8000bc68 <lockPrint>
    80002918:	ffffe097          	auipc	ra,0xffffe
    8000291c:	6e8080e7          	jalr	1768(ra) # 80001000 <copy_and_swap>
    80002920:	fe0514e3          	bnez	a0,80002908 <_Z11printStringPKc+0x4c>
}
    80002924:	01813083          	ld	ra,24(sp)
    80002928:	01013403          	ld	s0,16(sp)
    8000292c:	00813483          	ld	s1,8(sp)
    80002930:	02010113          	addi	sp,sp,32
    80002934:	00008067          	ret

0000000080002938 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002938:	fd010113          	addi	sp,sp,-48
    8000293c:	02113423          	sd	ra,40(sp)
    80002940:	02813023          	sd	s0,32(sp)
    80002944:	00913c23          	sd	s1,24(sp)
    80002948:	01213823          	sd	s2,16(sp)
    8000294c:	01313423          	sd	s3,8(sp)
    80002950:	01413023          	sd	s4,0(sp)
    80002954:	03010413          	addi	s0,sp,48
    80002958:	00050993          	mv	s3,a0
    8000295c:	00058a13          	mv	s4,a1
    LOCK();
    80002960:	00100613          	li	a2,1
    80002964:	00000593          	li	a1,0
    80002968:	00009517          	auipc	a0,0x9
    8000296c:	30050513          	addi	a0,a0,768 # 8000bc68 <lockPrint>
    80002970:	ffffe097          	auipc	ra,0xffffe
    80002974:	690080e7          	jalr	1680(ra) # 80001000 <copy_and_swap>
    80002978:	fe0514e3          	bnez	a0,80002960 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000297c:	00000913          	li	s2,0
    80002980:	00090493          	mv	s1,s2
    80002984:	0019091b          	addiw	s2,s2,1
    80002988:	03495a63          	bge	s2,s4,800029bc <_Z9getStringPci+0x84>
        cc = getc();
    8000298c:	fffff097          	auipc	ra,0xfffff
    80002990:	714080e7          	jalr	1812(ra) # 800020a0 <_Z4getcv>
        if(cc < 1)
    80002994:	02050463          	beqz	a0,800029bc <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002998:	009984b3          	add	s1,s3,s1
    8000299c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800029a0:	00a00793          	li	a5,10
    800029a4:	00f50a63          	beq	a0,a5,800029b8 <_Z9getStringPci+0x80>
    800029a8:	00d00793          	li	a5,13
    800029ac:	fcf51ae3          	bne	a0,a5,80002980 <_Z9getStringPci+0x48>
        buf[i++] = c;
    800029b0:	00090493          	mv	s1,s2
    800029b4:	0080006f          	j	800029bc <_Z9getStringPci+0x84>
    800029b8:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800029bc:	009984b3          	add	s1,s3,s1
    800029c0:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800029c4:	00000613          	li	a2,0
    800029c8:	00100593          	li	a1,1
    800029cc:	00009517          	auipc	a0,0x9
    800029d0:	29c50513          	addi	a0,a0,668 # 8000bc68 <lockPrint>
    800029d4:	ffffe097          	auipc	ra,0xffffe
    800029d8:	62c080e7          	jalr	1580(ra) # 80001000 <copy_and_swap>
    800029dc:	fe0514e3          	bnez	a0,800029c4 <_Z9getStringPci+0x8c>
    return buf;
}
    800029e0:	00098513          	mv	a0,s3
    800029e4:	02813083          	ld	ra,40(sp)
    800029e8:	02013403          	ld	s0,32(sp)
    800029ec:	01813483          	ld	s1,24(sp)
    800029f0:	01013903          	ld	s2,16(sp)
    800029f4:	00813983          	ld	s3,8(sp)
    800029f8:	00013a03          	ld	s4,0(sp)
    800029fc:	03010113          	addi	sp,sp,48
    80002a00:	00008067          	ret

0000000080002a04 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002a04:	ff010113          	addi	sp,sp,-16
    80002a08:	00813423          	sd	s0,8(sp)
    80002a0c:	01010413          	addi	s0,sp,16
    80002a10:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002a14:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002a18:	0006c603          	lbu	a2,0(a3)
    80002a1c:	fd06071b          	addiw	a4,a2,-48
    80002a20:	0ff77713          	andi	a4,a4,255
    80002a24:	00900793          	li	a5,9
    80002a28:	02e7e063          	bltu	a5,a4,80002a48 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002a2c:	0025179b          	slliw	a5,a0,0x2
    80002a30:	00a787bb          	addw	a5,a5,a0
    80002a34:	0017979b          	slliw	a5,a5,0x1
    80002a38:	00168693          	addi	a3,a3,1
    80002a3c:	00c787bb          	addw	a5,a5,a2
    80002a40:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002a44:	fd5ff06f          	j	80002a18 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002a48:	00813403          	ld	s0,8(sp)
    80002a4c:	01010113          	addi	sp,sp,16
    80002a50:	00008067          	ret

0000000080002a54 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002a54:	fc010113          	addi	sp,sp,-64
    80002a58:	02113c23          	sd	ra,56(sp)
    80002a5c:	02813823          	sd	s0,48(sp)
    80002a60:	02913423          	sd	s1,40(sp)
    80002a64:	03213023          	sd	s2,32(sp)
    80002a68:	01313c23          	sd	s3,24(sp)
    80002a6c:	04010413          	addi	s0,sp,64
    80002a70:	00050493          	mv	s1,a0
    80002a74:	00058913          	mv	s2,a1
    80002a78:	00060993          	mv	s3,a2
    LOCK();
    80002a7c:	00100613          	li	a2,1
    80002a80:	00000593          	li	a1,0
    80002a84:	00009517          	auipc	a0,0x9
    80002a88:	1e450513          	addi	a0,a0,484 # 8000bc68 <lockPrint>
    80002a8c:	ffffe097          	auipc	ra,0xffffe
    80002a90:	574080e7          	jalr	1396(ra) # 80001000 <copy_and_swap>
    80002a94:	fe0514e3          	bnez	a0,80002a7c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a98:	00098463          	beqz	s3,80002aa0 <_Z8printIntiii+0x4c>
    80002a9c:	0804c463          	bltz	s1,80002b24 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002aa0:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002aa4:	00000593          	li	a1,0
    }

    i = 0;
    80002aa8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002aac:	0009079b          	sext.w	a5,s2
    80002ab0:	0325773b          	remuw	a4,a0,s2
    80002ab4:	00048613          	mv	a2,s1
    80002ab8:	0014849b          	addiw	s1,s1,1
    80002abc:	02071693          	slli	a3,a4,0x20
    80002ac0:	0206d693          	srli	a3,a3,0x20
    80002ac4:	00009717          	auipc	a4,0x9
    80002ac8:	e2c70713          	addi	a4,a4,-468 # 8000b8f0 <digits>
    80002acc:	00d70733          	add	a4,a4,a3
    80002ad0:	00074683          	lbu	a3,0(a4)
    80002ad4:	fd040713          	addi	a4,s0,-48
    80002ad8:	00c70733          	add	a4,a4,a2
    80002adc:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002ae0:	0005071b          	sext.w	a4,a0
    80002ae4:	0325553b          	divuw	a0,a0,s2
    80002ae8:	fcf772e3          	bgeu	a4,a5,80002aac <_Z8printIntiii+0x58>
    if(neg)
    80002aec:	00058c63          	beqz	a1,80002b04 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002af0:	fd040793          	addi	a5,s0,-48
    80002af4:	009784b3          	add	s1,a5,s1
    80002af8:	02d00793          	li	a5,45
    80002afc:	fef48823          	sb	a5,-16(s1)
    80002b00:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002b04:	fff4849b          	addiw	s1,s1,-1
    80002b08:	0204c463          	bltz	s1,80002b30 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002b0c:	fd040793          	addi	a5,s0,-48
    80002b10:	009787b3          	add	a5,a5,s1
    80002b14:	ff07c503          	lbu	a0,-16(a5)
    80002b18:	fffff097          	auipc	ra,0xfffff
    80002b1c:	5b0080e7          	jalr	1456(ra) # 800020c8 <_Z4putcc>
    80002b20:	fe5ff06f          	j	80002b04 <_Z8printIntiii+0xb0>
        x = -xx;
    80002b24:	4090053b          	negw	a0,s1
        neg = 1;
    80002b28:	00100593          	li	a1,1
        x = -xx;
    80002b2c:	f7dff06f          	j	80002aa8 <_Z8printIntiii+0x54>

    UNLOCK();
    80002b30:	00000613          	li	a2,0
    80002b34:	00100593          	li	a1,1
    80002b38:	00009517          	auipc	a0,0x9
    80002b3c:	13050513          	addi	a0,a0,304 # 8000bc68 <lockPrint>
    80002b40:	ffffe097          	auipc	ra,0xffffe
    80002b44:	4c0080e7          	jalr	1216(ra) # 80001000 <copy_and_swap>
    80002b48:	fe0514e3          	bnez	a0,80002b30 <_Z8printIntiii+0xdc>
    80002b4c:	03813083          	ld	ra,56(sp)
    80002b50:	03013403          	ld	s0,48(sp)
    80002b54:	02813483          	ld	s1,40(sp)
    80002b58:	02013903          	ld	s2,32(sp)
    80002b5c:	01813983          	ld	s3,24(sp)
    80002b60:	04010113          	addi	sp,sp,64
    80002b64:	00008067          	ret

0000000080002b68 <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80002b68:	ff010113          	addi	sp,sp,-16
    80002b6c:	00813423          	sd	s0,8(sp)
    80002b70:	01010413          	addi	s0,sp,16
    val = init;
    80002b74:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80002b78:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    80002b7c:	00053823          	sd	zero,16(a0)
}
    80002b80:	00813403          	ld	s0,8(sp)
    80002b84:	01010113          	addi	sp,sp,16
    80002b88:	00008067          	ret

0000000080002b8c <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    80002b8c:	fe010113          	addi	sp,sp,-32
    80002b90:	00113c23          	sd	ra,24(sp)
    80002b94:	00813823          	sd	s0,16(sp)
    80002b98:	00913423          	sd	s1,8(sp)
    80002b9c:	01213023          	sd	s2,0(sp)
    80002ba0:	02010413          	addi	s0,sp,32
    80002ba4:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002ba8:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002bac:	02050063          	beqz	a0,80002bcc <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    80002bb0:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002bb4:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002bb8:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002bbc:	00002097          	auipc	ra,0x2
    80002bc0:	e34080e7          	jalr	-460(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002bc4:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002bc8:	fe5ff06f          	j	80002bac <_ZN3SCBD1Ev+0x20>
    }
}
    80002bcc:	01813083          	ld	ra,24(sp)
    80002bd0:	01013403          	ld	s0,16(sp)
    80002bd4:	00813483          	ld	s1,8(sp)
    80002bd8:	00013903          	ld	s2,0(sp)
    80002bdc:	02010113          	addi	sp,sp,32
    80002be0:	00008067          	ret

0000000080002be4 <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    80002be4:	ff010113          	addi	sp,sp,-16
    80002be8:	00113423          	sd	ra,8(sp)
    80002bec:	00813023          	sd	s0,0(sp)
    80002bf0:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002bf4:	00853783          	ld	a5,8(a0)
    80002bf8:	04078063          	beqz	a5,80002c38 <_ZN3SCB5blockEv+0x54>
    80002bfc:	01053703          	ld	a4,16(a0)
    80002c00:	00009797          	auipc	a5,0x9
    80002c04:	e907b783          	ld	a5,-368(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002c08:	0007b783          	ld	a5,0(a5)
    80002c0c:	04f73423          	sd	a5,72(a4)
    80002c10:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002c14:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002c18:	00300713          	li	a4,3
    80002c1c:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002c20:	00000097          	auipc	ra,0x0
    80002c24:	2c0080e7          	jalr	704(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
}
    80002c28:	00813083          	ld	ra,8(sp)
    80002c2c:	00013403          	ld	s0,0(sp)
    80002c30:	01010113          	addi	sp,sp,16
    80002c34:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002c38:	00009797          	auipc	a5,0x9
    80002c3c:	e587b783          	ld	a5,-424(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002c40:	0007b783          	ld	a5,0(a5)
    80002c44:	00f53423          	sd	a5,8(a0)
    80002c48:	fc9ff06f          	j	80002c10 <_ZN3SCB5blockEv+0x2c>

0000000080002c4c <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80002c4c:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002c50:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002c54:	04853703          	ld	a4,72(a0)
    80002c58:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002c5c:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002c60:	02050a63          	beqz	a0,80002c94 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002c64:	ff010113          	addi	sp,sp,-16
    80002c68:	00113423          	sd	ra,8(sp)
    80002c6c:	00813023          	sd	s0,0(sp)
    80002c70:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002c74:	00100793          	li	a5,1
    80002c78:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002c7c:	00002097          	auipc	ra,0x2
    80002c80:	d74080e7          	jalr	-652(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
    }
}
    80002c84:	00813083          	ld	ra,8(sp)
    80002c88:	00013403          	ld	s0,0(sp)
    80002c8c:	01010113          	addi	sp,sp,16
    80002c90:	00008067          	ret
    80002c94:	00008067          	ret

0000000080002c98 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80002c98:	00009797          	auipc	a5,0x9
    80002c9c:	df87b783          	ld	a5,-520(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002ca0:	0007b783          	ld	a5,0(a5)
    80002ca4:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002ca8:	00052783          	lw	a5,0(a0)
    80002cac:	fff7879b          	addiw	a5,a5,-1
    80002cb0:	00f52023          	sw	a5,0(a0)
    80002cb4:	02079713          	slli	a4,a5,0x20
    80002cb8:	00074463          	bltz	a4,80002cc0 <_ZN3SCB4waitEv+0x28>
    80002cbc:	00008067          	ret
void SCB::wait() {
    80002cc0:	ff010113          	addi	sp,sp,-16
    80002cc4:	00113423          	sd	ra,8(sp)
    80002cc8:	00813023          	sd	s0,0(sp)
    80002ccc:	01010413          	addi	s0,sp,16
        block();
    80002cd0:	00000097          	auipc	ra,0x0
    80002cd4:	f14080e7          	jalr	-236(ra) # 80002be4 <_ZN3SCB5blockEv>
}
    80002cd8:	00813083          	ld	ra,8(sp)
    80002cdc:	00013403          	ld	s0,0(sp)
    80002ce0:	01010113          	addi	sp,sp,16
    80002ce4:	00008067          	ret

0000000080002ce8 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80002ce8:	00052783          	lw	a5,0(a0)
    80002cec:	0017871b          	addiw	a4,a5,1
    80002cf0:	00e52023          	sw	a4,0(a0)
    80002cf4:	0007c463          	bltz	a5,80002cfc <_ZN3SCB6signalEv+0x14>
    80002cf8:	00008067          	ret
void SCB::signal(){
    80002cfc:	ff010113          	addi	sp,sp,-16
    80002d00:	00113423          	sd	ra,8(sp)
    80002d04:	00813023          	sd	s0,0(sp)
    80002d08:	01010413          	addi	s0,sp,16
        deblock();
    80002d0c:	00000097          	auipc	ra,0x0
    80002d10:	f40080e7          	jalr	-192(ra) # 80002c4c <_ZN3SCB7deblockEv>
}
    80002d14:	00813083          	ld	ra,8(sp)
    80002d18:	00013403          	ld	s0,0(sp)
    80002d1c:	01010113          	addi	sp,sp,16
    80002d20:	00008067          	ret

0000000080002d24 <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    80002d24:	ff010113          	addi	sp,sp,-16
    80002d28:	00113423          	sd	ra,8(sp)
    80002d2c:	00813023          	sd	s0,0(sp)
    80002d30:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002d34:	00000097          	auipc	ra,0x0
    80002d38:	410080e7          	jalr	1040(ra) # 80003144 <_ZN15MemoryAllocator7kmallocEm>
}
    80002d3c:	00813083          	ld	ra,8(sp)
    80002d40:	00013403          	ld	s0,0(sp)
    80002d44:	01010113          	addi	sp,sp,16
    80002d48:	00008067          	ret

0000000080002d4c <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    80002d4c:	ff010113          	addi	sp,sp,-16
    80002d50:	00113423          	sd	ra,8(sp)
    80002d54:	00813023          	sd	s0,0(sp)
    80002d58:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002d5c:	00000097          	auipc	ra,0x0
    80002d60:	610080e7          	jalr	1552(ra) # 8000336c <_ZN15MemoryAllocator5kfreeEPv>
}
    80002d64:	00813083          	ld	ra,8(sp)
    80002d68:	00013403          	ld	s0,0(sp)
    80002d6c:	01010113          	addi	sp,sp,16
    80002d70:	00008067          	ret

0000000080002d74 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002d74:	ff010113          	addi	sp,sp,-16
    80002d78:	00813423          	sd	s0,8(sp)
    80002d7c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002d80:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002d84:	05200513          	li	a0,82
    asm("ecall");
    80002d88:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80002d8c:	00050513          	mv	a0,a0
    return status;
}
    80002d90:	0005051b          	sext.w	a0,a0
    80002d94:	00813403          	ld	s0,8(sp)
    80002d98:	01010113          	addi	sp,sp,16
    80002d9c:	00008067          	ret

0000000080002da0 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002da0:	fe010113          	addi	sp,sp,-32
    80002da4:	00113c23          	sd	ra,24(sp)
    80002da8:	00813823          	sd	s0,16(sp)
    80002dac:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002db0:	fe840513          	addi	a0,s0,-24
    80002db4:	fffff097          	auipc	ra,0xfffff
    80002db8:	3d8080e7          	jalr	984(ra) # 8000218c <_ZN6SystemC1Ev>

    return 0;
    80002dbc:	00000513          	li	a0,0
    80002dc0:	01813083          	ld	ra,24(sp)
    80002dc4:	01013403          	ld	s0,16(sp)
    80002dc8:	02010113          	addi	sp,sp,32
    80002dcc:	00008067          	ret

0000000080002dd0 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002dd0:	ff010113          	addi	sp,sp,-16
    80002dd4:	00113423          	sd	ra,8(sp)
    80002dd8:	00813023          	sd	s0,0(sp)
    80002ddc:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002de0:	00001097          	auipc	ra,0x1
    80002de4:	cd8080e7          	jalr	-808(ra) # 80003ab8 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    80002de8:	00009797          	auipc	a5,0x9
    80002dec:	e887b783          	ld	a5,-376(a5) # 8000bc70 <_ZN3TCB7runningE>
    80002df0:	0187b703          	ld	a4,24(a5)
    80002df4:	0207b503          	ld	a0,32(a5)
    80002df8:	000700e7          	jalr	a4

    thread_exit();
    80002dfc:	fffff097          	auipc	ra,0xfffff
    80002e00:	0cc080e7          	jalr	204(ra) # 80001ec8 <_Z11thread_exitv>
}
    80002e04:	00813083          	ld	ra,8(sp)
    80002e08:	00013403          	ld	s0,0(sp)
    80002e0c:	01010113          	addi	sp,sp,16
    80002e10:	00008067          	ret

0000000080002e14 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002e14:	ff010113          	addi	sp,sp,-16
    80002e18:	00813423          	sd	s0,8(sp)
    80002e1c:	01010413          	addi	s0,sp,16
    80002e20:	04053823          	sd	zero,80(a0)
    80002e24:	04053c23          	sd	zero,88(a0)
    80002e28:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002e2c:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002e30:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002e34:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002e38:	04058263          	beqz	a1,80002e7c <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    80002e3c:	00068793          	mv	a5,a3
    80002e40:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    80002e44:	00100793          	li	a5,1
    80002e48:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    80002e4c:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002e50:	02058a63          	beqz	a1,80002e84 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    80002e54:	000017b7          	lui	a5,0x1
    80002e58:	00f686b3          	add	a3,a3,a5
    80002e5c:	00d53023          	sd	a3,0(a0)
    80002e60:	00000797          	auipc	a5,0x0
    80002e64:	f7078793          	addi	a5,a5,-144 # 80002dd0 <_ZN3TCB7wrapperEPv>
    80002e68:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002e6c:	00052a23          	sw	zero,20(a0)
}
    80002e70:	00813403          	ld	s0,8(sp)
    80002e74:	01010113          	addi	sp,sp,16
    80002e78:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002e7c:	00000793          	li	a5,0
    80002e80:	fc1ff06f          	j	80002e40 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002e84:	00000693          	li	a3,0
    80002e88:	fd5ff06f          	j	80002e5c <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

0000000080002e8c <_ZN3TCB4freeEv>:
void TCB::free(){
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00113423          	sd	ra,8(sp)
    80002e94:	00813023          	sd	s0,0(sp)
    80002e98:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    80002e9c:	02853503          	ld	a0,40(a0)
    80002ea0:	00000097          	auipc	ra,0x0
    80002ea4:	4cc080e7          	jalr	1228(ra) # 8000336c <_ZN15MemoryAllocator5kfreeEPv>
}
    80002ea8:	00813083          	ld	ra,8(sp)
    80002eac:	00013403          	ld	s0,0(sp)
    80002eb0:	01010113          	addi	sp,sp,16
    80002eb4:	00008067          	ret

0000000080002eb8 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002eb8:	ff010113          	addi	sp,sp,-16
    80002ebc:	00113423          	sd	ra,8(sp)
    80002ec0:	00813023          	sd	s0,0(sp)
    80002ec4:	01010413          	addi	s0,sp,16
    free();
    80002ec8:	00000097          	auipc	ra,0x0
    80002ecc:	fc4080e7          	jalr	-60(ra) # 80002e8c <_ZN3TCB4freeEv>
}
    80002ed0:	00813083          	ld	ra,8(sp)
    80002ed4:	00013403          	ld	s0,0(sp)
    80002ed8:	01010113          	addi	sp,sp,16
    80002edc:	00008067          	ret

0000000080002ee0 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002ee0:	fe010113          	addi	sp,sp,-32
    80002ee4:	00113c23          	sd	ra,24(sp)
    80002ee8:	00813823          	sd	s0,16(sp)
    80002eec:	00913423          	sd	s1,8(sp)
    80002ef0:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002ef4:	00009497          	auipc	s1,0x9
    80002ef8:	d7c4b483          	ld	s1,-644(s1) # 8000bc70 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002efc:	0104a703          	lw	a4,16(s1)
    80002f00:	00100793          	li	a5,1
    80002f04:	04e7f663          	bgeu	a5,a4,80002f50 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002f08:	00002097          	auipc	ra,0x2
    80002f0c:	b30080e7          	jalr	-1232(ra) # 80004a38 <_ZN9Scheduler3getEv>
    80002f10:	00009797          	auipc	a5,0x9
    80002f14:	d6a7b023          	sd	a0,-672(a5) # 8000bc70 <_ZN3TCB7runningE>
    if(running) {
    80002f18:	02050263          	beqz	a0,80002f3c <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002f1c:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002f20:	00001097          	auipc	ra,0x1
    80002f24:	ccc080e7          	jalr	-820(ra) # 80003bec <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002f28:	00009597          	auipc	a1,0x9
    80002f2c:	d485b583          	ld	a1,-696(a1) # 8000bc70 <_ZN3TCB7runningE>
    80002f30:	00048513          	mv	a0,s1
    80002f34:	ffffe097          	auipc	ra,0xffffe
    80002f38:	20c080e7          	jalr	524(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002f3c:	01813083          	ld	ra,24(sp)
    80002f40:	01013403          	ld	s0,16(sp)
    80002f44:	00813483          	ld	s1,8(sp)
    80002f48:	02010113          	addi	sp,sp,32
    80002f4c:	00008067          	ret
        Scheduler::put(old);
    80002f50:	00048513          	mv	a0,s1
    80002f54:	00002097          	auipc	ra,0x2
    80002f58:	a9c080e7          	jalr	-1380(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
    80002f5c:	fadff06f          	j	80002f08 <_ZN3TCB8dispatchEv+0x28>

0000000080002f60 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002f60:	ff010113          	addi	sp,sp,-16
    80002f64:	00113423          	sd	ra,8(sp)
    80002f68:	00813023          	sd	s0,0(sp)
    80002f6c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002f70:	00000097          	auipc	ra,0x0
    80002f74:	1d4080e7          	jalr	468(ra) # 80003144 <_ZN15MemoryAllocator7kmallocEm>
}
    80002f78:	00813083          	ld	ra,8(sp)
    80002f7c:	00013403          	ld	s0,0(sp)
    80002f80:	01010113          	addi	sp,sp,16
    80002f84:	00008067          	ret

0000000080002f88 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002f88:	fd010113          	addi	sp,sp,-48
    80002f8c:	02113423          	sd	ra,40(sp)
    80002f90:	02813023          	sd	s0,32(sp)
    80002f94:	00913c23          	sd	s1,24(sp)
    80002f98:	01213823          	sd	s2,16(sp)
    80002f9c:	01313423          	sd	s3,8(sp)
    80002fa0:	01413023          	sd	s4,0(sp)
    80002fa4:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002fa8:	07000513          	li	a0,112
    80002fac:	00000097          	auipc	ra,0x0
    80002fb0:	fb4080e7          	jalr	-76(ra) # 80002f60 <_ZN3TCBnwEm>
    80002fb4:	00050493          	mv	s1,a0
    80002fb8:	00200713          	li	a4,2
    80002fbc:	00000693          	li	a3,0
    80002fc0:	00000613          	li	a2,0
    80002fc4:	00000593          	li	a1,0
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	e4c080e7          	jalr	-436(ra) # 80002e14 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002fd0:	00009a17          	auipc	s4,0x9
    80002fd4:	ca0a0a13          	addi	s4,s4,-864 # 8000bc70 <_ZN3TCB7runningE>
    80002fd8:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    80002fdc:	00100993          	li	s3,1
    80002fe0:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002fe4:	04000513          	li	a0,64
    80002fe8:	00000097          	auipc	ra,0x0
    80002fec:	15c080e7          	jalr	348(ra) # 80003144 <_ZN15MemoryAllocator7kmallocEm>
    80002ff0:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002ff4:	07000513          	li	a0,112
    80002ff8:	00000097          	auipc	ra,0x0
    80002ffc:	f68080e7          	jalr	-152(ra) # 80002f60 <_ZN3TCBnwEm>
    80003000:	00050493          	mv	s1,a0
    80003004:	00200713          	li	a4,2
    80003008:	00090693          	mv	a3,s2
    8000300c:	00000613          	li	a2,0
    80003010:	00009597          	auipc	a1,0x9
    80003014:	a205b583          	ld	a1,-1504(a1) # 8000ba30 <_GLOBAL_OFFSET_TABLE_+0x30>
    80003018:	00000097          	auipc	ra,0x0
    8000301c:	dfc080e7          	jalr	-516(ra) # 80002e14 <_ZN3TCBC1EPFvPvES0_Pmm>
    80003020:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    80003024:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    80003028:	00048513          	mv	a0,s1
    8000302c:	00002097          	auipc	ra,0x2
    80003030:	9c4080e7          	jalr	-1596(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
}
    80003034:	02813083          	ld	ra,40(sp)
    80003038:	02013403          	ld	s0,32(sp)
    8000303c:	01813483          	ld	s1,24(sp)
    80003040:	01013903          	ld	s2,16(sp)
    80003044:	00813983          	ld	s3,8(sp)
    80003048:	00013a03          	ld	s4,0(sp)
    8000304c:	03010113          	addi	sp,sp,48
    80003050:	00008067          	ret

0000000080003054 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    80003054:	ff010113          	addi	sp,sp,-16
    80003058:	00113423          	sd	ra,8(sp)
    8000305c:	00813023          	sd	s0,0(sp)
    80003060:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80003064:	00000097          	auipc	ra,0x0
    80003068:	308080e7          	jalr	776(ra) # 8000336c <_ZN15MemoryAllocator5kfreeEPv>
}
    8000306c:	00813083          	ld	ra,8(sp)
    80003070:	00013403          	ld	s0,0(sp)
    80003074:	01010113          	addi	sp,sp,16
    80003078:	00008067          	ret

000000008000307c <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    8000307c:	ff010113          	addi	sp,sp,-16
    80003080:	00813423          	sd	s0,8(sp)
    80003084:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003088:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    8000308c:	05100513          	li	a0,81
    asm("ecall");
    80003090:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80003094:	00050513          	mv	a0,a0
    return status;
}
    80003098:	0005051b          	sext.w	a0,a0
    8000309c:	00813403          	ld	s0,8(sp)
    800030a0:	01010113          	addi	sp,sp,16
    800030a4:	00008067          	ret

00000000800030a8 <_ZN3TCB4ctorEPv>:

void* TCB::ctor(void* tcb){
    800030a8:	ff010113          	addi	sp,sp,-16
    800030ac:	00813423          	sd	s0,8(sp)
    800030b0:	01010413          	addi	s0,sp,16
    return nullptr;
    800030b4:	00000513          	li	a0,0
    800030b8:	00813403          	ld	s0,8(sp)
    800030bc:	01010113          	addi	sp,sp,16
    800030c0:	00008067          	ret

00000000800030c4 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    800030c4:	ff010113          	addi	sp,sp,-16
    800030c8:	00813423          	sd	s0,8(sp)
    800030cc:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    800030d0:	00009797          	auipc	a5,0x9
    800030d4:	9487b783          	ld	a5,-1720(a5) # 8000ba18 <_GLOBAL_OFFSET_TABLE_+0x18>
    800030d8:	0007b603          	ld	a2,0(a5)
    800030dc:	00c65793          	srli	a5,a2,0xc
    800030e0:	00278793          	addi	a5,a5,2
    800030e4:	00c79793          	slli	a5,a5,0xc
    800030e8:	01000737          	lui	a4,0x1000
    800030ec:	00e787b3          	add	a5,a5,a4
    800030f0:	00009717          	auipc	a4,0x9
    800030f4:	ba870713          	addi	a4,a4,-1112 # 8000bc98 <_ZN15MemoryAllocator11freeMemTailE>
    800030f8:	00f73023          	sd	a5,0(a4)
    800030fc:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80003100:	0007b823          	sd	zero,16(a5)
    80003104:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003108:	00073823          	sd	zero,16(a4)
    8000310c:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    80003110:	00009697          	auipc	a3,0x9
    80003114:	9906b683          	ld	a3,-1648(a3) # 8000baa0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80003118:	0006b683          	ld	a3,0(a3)
    8000311c:	40c686b3          	sub	a3,a3,a2
    80003120:	fe868693          	addi	a3,a3,-24
    80003124:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80003128:	00873783          	ld	a5,8(a4)
    8000312c:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80003130:	00100793          	li	a5,1
    80003134:	02f70023          	sb	a5,32(a4)
}
    80003138:	00813403          	ld	s0,8(sp)
    8000313c:	01010113          	addi	sp,sp,16
    80003140:	00008067          	ret

0000000080003144 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80003144:	ff010113          	addi	sp,sp,-16
    80003148:	00813423          	sd	s0,8(sp)
    8000314c:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    80003150:	14050263          	beqz	a0,80003294 <_ZN15MemoryAllocator7kmallocEm+0x150>
    80003154:	00050793          	mv	a5,a0
    80003158:	00009517          	auipc	a0,0x9
    8000315c:	b4853503          	ld	a0,-1208(a0) # 8000bca0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003160:	0a050a63          	beqz	a0,80003214 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80003164:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80003168:	00000613          	li	a2,0
    8000316c:	00c0006f          	j	80003178 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80003170:	00050613          	mv	a2,a0
    80003174:	01053503          	ld	a0,16(a0)
    80003178:	00050863          	beqz	a0,80003188 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    8000317c:	00053683          	ld	a3,0(a0)
    80003180:	01878713          	addi	a4,a5,24
    80003184:	fee6e6e3          	bltu	a3,a4,80003170 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80003188:	08050663          	beqz	a0,80003214 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    8000318c:	00053683          	ld	a3,0(a0)
    80003190:	01868713          	addi	a4,a3,24
    80003194:	00e50733          	add	a4,a0,a4
    80003198:	00009597          	auipc	a1,0x9
    8000319c:	9085b583          	ld	a1,-1784(a1) # 8000baa0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    800031a0:	0005b583          	ld	a1,0(a1)
    800031a4:	00b76463          	bltu	a4,a1,800031ac <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    800031a8:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    800031ac:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    800031b0:	05700593          	li	a1,87
    800031b4:	08d5f063          	bgeu	a1,a3,80003234 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    800031b8:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    800031bc:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    800031c0:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    800031c4:	01053583          	ld	a1,16(a0)
    800031c8:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    800031cc:	00853583          	ld	a1,8(a0)
    800031d0:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    800031d4:	fe868693          	addi	a3,a3,-24
    800031d8:	00d7b023          	sd	a3,0(a5)

            if(prev)
    800031dc:	04060263          	beqz	a2,80003220 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    800031e0:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    800031e4:	00009797          	auipc	a5,0x9
    800031e8:	acc7b783          	ld	a5,-1332(a5) # 8000bcb0 <_ZN15MemoryAllocator12allocMemHeadE>
    800031ec:	06078463          	beqz	a5,80003254 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    800031f0:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    800031f4:	08070063          	beqz	a4,80003274 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    800031f8:	00873783          	ld	a5,8(a4)
    800031fc:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003200:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80003204:	00873783          	ld	a5,8(a4)
    80003208:	06078063          	beqz	a5,80003268 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    8000320c:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003210:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003214:	00813403          	ld	s0,8(sp)
    80003218:	01010113          	addi	sp,sp,16
    8000321c:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80003220:	00009697          	auipc	a3,0x9
    80003224:	a7868693          	addi	a3,a3,-1416 # 8000bc98 <_ZN15MemoryAllocator11freeMemTailE>
    80003228:	00f6b023          	sd	a5,0(a3)
    8000322c:	00f6b423          	sd	a5,8(a3)
    80003230:	fb5ff06f          	j	800031e4 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    80003234:	00060863          	beqz	a2,80003244 <_ZN15MemoryAllocator7kmallocEm+0x100>
    80003238:	01053783          	ld	a5,16(a0)
    8000323c:	00f63823          	sd	a5,16(a2)
    80003240:	fa5ff06f          	j	800031e4 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    80003244:	01053783          	ld	a5,16(a0)
    80003248:	00009697          	auipc	a3,0x9
    8000324c:	a4f6bc23          	sd	a5,-1448(a3) # 8000bca0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003250:	f95ff06f          	j	800031e4 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    80003254:	00009797          	auipc	a5,0x9
    80003258:	a4478793          	addi	a5,a5,-1468 # 8000bc98 <_ZN15MemoryAllocator11freeMemTailE>
    8000325c:	00a7b823          	sd	a0,16(a5)
    80003260:	00a7bc23          	sd	a0,24(a5)
    80003264:	fadff06f          	j	80003210 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    80003268:	00009797          	auipc	a5,0x9
    8000326c:	a4a7b423          	sd	a0,-1464(a5) # 8000bcb0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003270:	fa1ff06f          	j	80003210 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    80003274:	00009797          	auipc	a5,0x9
    80003278:	a2478793          	addi	a5,a5,-1500 # 8000bc98 <_ZN15MemoryAllocator11freeMemTailE>
    8000327c:	0107b703          	ld	a4,16(a5)
    80003280:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80003284:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80003288:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    8000328c:	00a7b823          	sd	a0,16(a5)
    80003290:	f81ff06f          	j	80003210 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80003294:	00000513          	li	a0,0
    80003298:	f7dff06f          	j	80003214 <_ZN15MemoryAllocator7kmallocEm+0xd0>

000000008000329c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    8000329c:	ff010113          	addi	sp,sp,-16
    800032a0:	00813423          	sd	s0,8(sp)
    800032a4:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    800032a8:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800032ac:	00000713          	li	a4,0
    800032b0:	00078a63          	beqz	a5,800032c4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    800032b4:	00a7f863          	bgeu	a5,a0,800032c4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800032b8:	00078713          	mv	a4,a5
    800032bc:	0107b783          	ld	a5,16(a5)
    800032c0:	ff1ff06f          	j	800032b0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800032c4:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    800032c8:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    800032cc:	00078463          	beqz	a5,800032d4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    800032d0:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    800032d4:	02070263          	beqz	a4,800032f8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    800032d8:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    800032dc:	0005b703          	ld	a4,0(a1)
    800032e0:	00009797          	auipc	a5,0x9
    800032e4:	9c07b783          	ld	a5,-1600(a5) # 8000bca0 <_ZN15MemoryAllocator11freeMemHeadE>
    800032e8:	00f70c63          	beq	a4,a5,80003300 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    800032ec:	00813403          	ld	s0,8(sp)
    800032f0:	01010113          	addi	sp,sp,16
    800032f4:	00008067          	ret
        *head = blk;
    800032f8:	00a5b023          	sd	a0,0(a1)
    800032fc:	fe1ff06f          	j	800032dc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80003300:	01053783          	ld	a5,16(a0)
    80003304:	00078a63          	beqz	a5,80003318 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003308:	00053683          	ld	a3,0(a0)
    8000330c:	00d50733          	add	a4,a0,a3
    80003310:	01870713          	addi	a4,a4,24
    80003314:	02f70e63          	beq	a4,a5,80003350 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003318:	00853783          	ld	a5,8(a0)
    8000331c:	fc0788e3          	beqz	a5,800032ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80003320:	0007b683          	ld	a3,0(a5)
    80003324:	00d78733          	add	a4,a5,a3
    80003328:	01870713          	addi	a4,a4,24
    8000332c:	fca710e3          	bne	a4,a0,800032ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80003330:	00053703          	ld	a4,0(a0)
    80003334:	00e68733          	add	a4,a3,a4
    80003338:	01870713          	addi	a4,a4,24
    8000333c:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80003340:	00853783          	ld	a5,8(a0)
    80003344:	01053703          	ld	a4,16(a0)
    80003348:	00e7b823          	sd	a4,16(a5)
}
    8000334c:	fa1ff06f          	j	800032ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80003350:	0007b703          	ld	a4,0(a5)
    80003354:	00e68733          	add	a4,a3,a4
    80003358:	01870713          	addi	a4,a4,24
    8000335c:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80003360:	0107b783          	ld	a5,16(a5)
    80003364:	00f53823          	sd	a5,16(a0)
    80003368:	fb1ff06f          	j	80003318 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

000000008000336c <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    8000336c:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80003370:	00009697          	auipc	a3,0x9
    80003374:	9406b683          	ld	a3,-1728(a3) # 8000bcb0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003378:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    8000337c:	00050a63          	beqz	a0,80003390 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80003380:	fe870793          	addi	a5,a4,-24
    80003384:	00a78663          	beq	a5,a0,80003390 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003388:	01053503          	ld	a0,16(a0)
    8000338c:	ff1ff06f          	j	8000337c <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80003390:	08050463          	beqz	a0,80003418 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003394:	ff010113          	addi	sp,sp,-16
    80003398:	00113423          	sd	ra,8(sp)
    8000339c:	00813023          	sd	s0,0(sp)
    800033a0:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    800033a4:	00009797          	auipc	a5,0x9
    800033a8:	9047b783          	ld	a5,-1788(a5) # 8000bca8 <_ZN15MemoryAllocator12allocMemTailE>
    800033ac:	04a78663          	beq	a5,a0,800033f8 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    800033b0:	04d50c63          	beq	a0,a3,80003408 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    800033b4:	01053783          	ld	a5,16(a0)
    800033b8:	00078663          	beqz	a5,800033c4 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    800033bc:	00853703          	ld	a4,8(a0)
    800033c0:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800033c4:	00853783          	ld	a5,8(a0)
    800033c8:	00078663          	beqz	a5,800033d4 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    800033cc:	01053703          	ld	a4,16(a0)
    800033d0:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    800033d4:	00009597          	auipc	a1,0x9
    800033d8:	8cc58593          	addi	a1,a1,-1844 # 8000bca0 <_ZN15MemoryAllocator11freeMemHeadE>
    800033dc:	00000097          	auipc	ra,0x0
    800033e0:	ec0080e7          	jalr	-320(ra) # 8000329c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    800033e4:	00000513          	li	a0,0
}
    800033e8:	00813083          	ld	ra,8(sp)
    800033ec:	00013403          	ld	s0,0(sp)
    800033f0:	01010113          	addi	sp,sp,16
    800033f4:	00008067          	ret
            allocMemTail = blk->prev;
    800033f8:	00853783          	ld	a5,8(a0)
    800033fc:	00009717          	auipc	a4,0x9
    80003400:	8af73623          	sd	a5,-1876(a4) # 8000bca8 <_ZN15MemoryAllocator12allocMemTailE>
    80003404:	fadff06f          	j	800033b0 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003408:	01053783          	ld	a5,16(a0)
    8000340c:	00009717          	auipc	a4,0x9
    80003410:	8af73223          	sd	a5,-1884(a4) # 8000bcb0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003414:	fa1ff06f          	j	800033b4 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003418:	fff00513          	li	a0,-1
}
    8000341c:	00008067          	ret

0000000080003420 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80003420:	fe010113          	addi	sp,sp,-32
    80003424:	00113c23          	sd	ra,24(sp)
    80003428:	00813823          	sd	s0,16(sp)
    8000342c:	00913423          	sd	s1,8(sp)
    80003430:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80003434:	00009497          	auipc	s1,0x9
    80003438:	87c4b483          	ld	s1,-1924(s1) # 8000bcb0 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    8000343c:	00006517          	auipc	a0,0x6
    80003440:	e8c50513          	addi	a0,a0,-372 # 800092c8 <CONSOLE_STATUS+0x2b8>
    80003444:	fffff097          	auipc	ra,0xfffff
    80003448:	478080e7          	jalr	1144(ra) # 800028bc <_Z11printStringPKc>
    while(iter!=nullptr){
    8000344c:	04048663          	beqz	s1,80003498 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80003450:	00000613          	li	a2,0
    80003454:	00a00593          	li	a1,10
    80003458:	0004851b          	sext.w	a0,s1
    8000345c:	fffff097          	auipc	ra,0xfffff
    80003460:	5f8080e7          	jalr	1528(ra) # 80002a54 <_Z8printIntiii>
        putc(' ');
    80003464:	02000513          	li	a0,32
    80003468:	fffff097          	auipc	ra,0xfffff
    8000346c:	c60080e7          	jalr	-928(ra) # 800020c8 <_Z4putcc>
        printInt(iter->size);
    80003470:	00000613          	li	a2,0
    80003474:	00a00593          	li	a1,10
    80003478:	0004a503          	lw	a0,0(s1)
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	5d8080e7          	jalr	1496(ra) # 80002a54 <_Z8printIntiii>
        putc('\n');
    80003484:	00a00513          	li	a0,10
    80003488:	fffff097          	auipc	ra,0xfffff
    8000348c:	c40080e7          	jalr	-960(ra) # 800020c8 <_Z4putcc>
        iter=iter->next;
    80003490:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003494:	fb9ff06f          	j	8000344c <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003498:	00006517          	auipc	a0,0x6
    8000349c:	e5050513          	addi	a0,a0,-432 # 800092e8 <CONSOLE_STATUS+0x2d8>
    800034a0:	fffff097          	auipc	ra,0xfffff
    800034a4:	41c080e7          	jalr	1052(ra) # 800028bc <_Z11printStringPKc>
    iter = freeMemHead;
    800034a8:	00008497          	auipc	s1,0x8
    800034ac:	7f84b483          	ld	s1,2040(s1) # 8000bca0 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    800034b0:	04048663          	beqz	s1,800034fc <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    800034b4:	00000613          	li	a2,0
    800034b8:	00a00593          	li	a1,10
    800034bc:	0004851b          	sext.w	a0,s1
    800034c0:	fffff097          	auipc	ra,0xfffff
    800034c4:	594080e7          	jalr	1428(ra) # 80002a54 <_Z8printIntiii>
        putc(' ');
    800034c8:	02000513          	li	a0,32
    800034cc:	fffff097          	auipc	ra,0xfffff
    800034d0:	bfc080e7          	jalr	-1028(ra) # 800020c8 <_Z4putcc>
        printInt(iter->size);
    800034d4:	00000613          	li	a2,0
    800034d8:	00a00593          	li	a1,10
    800034dc:	0004a503          	lw	a0,0(s1)
    800034e0:	fffff097          	auipc	ra,0xfffff
    800034e4:	574080e7          	jalr	1396(ra) # 80002a54 <_Z8printIntiii>
        putc('\n');
    800034e8:	00a00513          	li	a0,10
    800034ec:	fffff097          	auipc	ra,0xfffff
    800034f0:	bdc080e7          	jalr	-1060(ra) # 800020c8 <_Z4putcc>
        iter=iter->next;
    800034f4:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800034f8:	fb9ff06f          	j	800034b0 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    800034fc:	00006517          	auipc	a0,0x6
    80003500:	e0c50513          	addi	a0,a0,-500 # 80009308 <CONSOLE_STATUS+0x2f8>
    80003504:	fffff097          	auipc	ra,0xfffff
    80003508:	3b8080e7          	jalr	952(ra) # 800028bc <_Z11printStringPKc>
}
    8000350c:	01813083          	ld	ra,24(sp)
    80003510:	01013403          	ld	s0,16(sp)
    80003514:	00813483          	ld	s1,8(sp)
    80003518:	02010113          	addi	sp,sp,32
    8000351c:	00008067          	ret

0000000080003520 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80003520:	ff010113          	addi	sp,sp,-16
    80003524:	00813423          	sd	s0,8(sp)
    80003528:	01010413          	addi	s0,sp,16
    8000352c:	00050813          	mv	a6,a0
    80003530:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80003534:	00000793          	li	a5,0
    80003538:	00c7fe63          	bgeu	a5,a2,80003554 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    8000353c:	00f50733          	add	a4,a0,a5
    80003540:	00f806b3          	add	a3,a6,a5
    80003544:	0006c683          	lbu	a3,0(a3)
    80003548:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    8000354c:	00178793          	addi	a5,a5,1
    80003550:	fe9ff06f          	j	80003538 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80003554:	00813403          	ld	s0,8(sp)
    80003558:	01010113          	addi	sp,sp,16
    8000355c:	00008067          	ret

0000000080003560 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    80003560:	ff010113          	addi	sp,sp,-16
    80003564:	00113423          	sd	ra,8(sp)
    80003568:	00813023          	sd	s0,0(sp)
    8000356c:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80003570:	00053783          	ld	a5,0(a0)
    80003574:	0107b783          	ld	a5,16(a5)
    80003578:	000780e7          	jalr	a5
}
    8000357c:	00813083          	ld	ra,8(sp)
    80003580:	00013403          	ld	s0,0(sp)
    80003584:	01010113          	addi	sp,sp,16
    80003588:	00008067          	ret

000000008000358c <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000358c:	ff010113          	addi	sp,sp,-16
    80003590:	00113423          	sd	ra,8(sp)
    80003594:	00813023          	sd	s0,0(sp)
    80003598:	01010413          	addi	s0,sp,16
    8000359c:	00008797          	auipc	a5,0x8
    800035a0:	3b478793          	addi	a5,a5,948 # 8000b950 <_ZTV9Semaphore+0x10>
    800035a4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800035a8:	00853503          	ld	a0,8(a0)
    800035ac:	fffff097          	auipc	ra,0xfffff
    800035b0:	a44080e7          	jalr	-1468(ra) # 80001ff0 <_Z9sem_closeP10_semaphore>
};
    800035b4:	00813083          	ld	ra,8(sp)
    800035b8:	00013403          	ld	s0,0(sp)
    800035bc:	01010113          	addi	sp,sp,16
    800035c0:	00008067          	ret

00000000800035c4 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    800035c4:	00008797          	auipc	a5,0x8
    800035c8:	3ac78793          	addi	a5,a5,940 # 8000b970 <_ZTV6Thread+0x10>
    800035cc:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800035d0:	00853503          	ld	a0,8(a0)
    800035d4:	02050663          	beqz	a0,80003600 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    800035d8:	ff010113          	addi	sp,sp,-16
    800035dc:	00113423          	sd	ra,8(sp)
    800035e0:	00813023          	sd	s0,0(sp)
    800035e4:	01010413          	addi	s0,sp,16
    delete myHandle;
    800035e8:	fffff097          	auipc	ra,0xfffff
    800035ec:	b54080e7          	jalr	-1196(ra) # 8000213c <_ZN7_threaddlEPv>
}
    800035f0:	00813083          	ld	ra,8(sp)
    800035f4:	00013403          	ld	s0,0(sp)
    800035f8:	01010113          	addi	sp,sp,16
    800035fc:	00008067          	ret
    80003600:	00008067          	ret

0000000080003604 <_Znwm>:
void* operator new(size_t sz){
    80003604:	ff010113          	addi	sp,sp,-16
    80003608:	00113423          	sd	ra,8(sp)
    8000360c:	00813023          	sd	s0,0(sp)
    80003610:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003614:	ffffe097          	auipc	ra,0xffffe
    80003618:	7dc080e7          	jalr	2012(ra) # 80001df0 <_Z9mem_allocm>
}
    8000361c:	00813083          	ld	ra,8(sp)
    80003620:	00013403          	ld	s0,0(sp)
    80003624:	01010113          	addi	sp,sp,16
    80003628:	00008067          	ret

000000008000362c <_Znam>:
void* operator new[](size_t sz){
    8000362c:	ff010113          	addi	sp,sp,-16
    80003630:	00113423          	sd	ra,8(sp)
    80003634:	00813023          	sd	s0,0(sp)
    80003638:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000363c:	ffffe097          	auipc	ra,0xffffe
    80003640:	7b4080e7          	jalr	1972(ra) # 80001df0 <_Z9mem_allocm>
}
    80003644:	00813083          	ld	ra,8(sp)
    80003648:	00013403          	ld	s0,0(sp)
    8000364c:	01010113          	addi	sp,sp,16
    80003650:	00008067          	ret

0000000080003654 <_ZdlPv>:
void operator delete(void *ptr){
    80003654:	ff010113          	addi	sp,sp,-16
    80003658:	00113423          	sd	ra,8(sp)
    8000365c:	00813023          	sd	s0,0(sp)
    80003660:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80003664:	ffffe097          	auipc	ra,0xffffe
    80003668:	7bc080e7          	jalr	1980(ra) # 80001e20 <_Z8mem_freePv>
}
    8000366c:	00813083          	ld	ra,8(sp)
    80003670:	00013403          	ld	s0,0(sp)
    80003674:	01010113          	addi	sp,sp,16
    80003678:	00008067          	ret

000000008000367c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    8000367c:	fe010113          	addi	sp,sp,-32
    80003680:	00113c23          	sd	ra,24(sp)
    80003684:	00813823          	sd	s0,16(sp)
    80003688:	00913423          	sd	s1,8(sp)
    8000368c:	02010413          	addi	s0,sp,32
    80003690:	00050493          	mv	s1,a0
};
    80003694:	00000097          	auipc	ra,0x0
    80003698:	ef8080e7          	jalr	-264(ra) # 8000358c <_ZN9SemaphoreD1Ev>
    8000369c:	00048513          	mv	a0,s1
    800036a0:	00000097          	auipc	ra,0x0
    800036a4:	fb4080e7          	jalr	-76(ra) # 80003654 <_ZdlPv>
    800036a8:	01813083          	ld	ra,24(sp)
    800036ac:	01013403          	ld	s0,16(sp)
    800036b0:	00813483          	ld	s1,8(sp)
    800036b4:	02010113          	addi	sp,sp,32
    800036b8:	00008067          	ret

00000000800036bc <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800036bc:	fe010113          	addi	sp,sp,-32
    800036c0:	00113c23          	sd	ra,24(sp)
    800036c4:	00813823          	sd	s0,16(sp)
    800036c8:	00913423          	sd	s1,8(sp)
    800036cc:	02010413          	addi	s0,sp,32
    800036d0:	00050493          	mv	s1,a0
}
    800036d4:	00000097          	auipc	ra,0x0
    800036d8:	ef0080e7          	jalr	-272(ra) # 800035c4 <_ZN6ThreadD1Ev>
    800036dc:	00048513          	mv	a0,s1
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	f74080e7          	jalr	-140(ra) # 80003654 <_ZdlPv>
    800036e8:	01813083          	ld	ra,24(sp)
    800036ec:	01013403          	ld	s0,16(sp)
    800036f0:	00813483          	ld	s1,8(sp)
    800036f4:	02010113          	addi	sp,sp,32
    800036f8:	00008067          	ret

00000000800036fc <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800036fc:	ff010113          	addi	sp,sp,-16
    80003700:	00113423          	sd	ra,8(sp)
    80003704:	00813023          	sd	s0,0(sp)
    80003708:	01010413          	addi	s0,sp,16
    8000370c:	00008797          	auipc	a5,0x8
    80003710:	24478793          	addi	a5,a5,580 # 8000b950 <_ZTV9Semaphore+0x10>
    80003714:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003718:	00850513          	addi	a0,a0,8
    8000371c:	fffff097          	auipc	ra,0xfffff
    80003720:	89c080e7          	jalr	-1892(ra) # 80001fb8 <_Z8sem_openPP10_semaphorej>
}
    80003724:	00813083          	ld	ra,8(sp)
    80003728:	00013403          	ld	s0,0(sp)
    8000372c:	01010113          	addi	sp,sp,16
    80003730:	00008067          	ret

0000000080003734 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80003734:	ff010113          	addi	sp,sp,-16
    80003738:	00113423          	sd	ra,8(sp)
    8000373c:	00813023          	sd	s0,0(sp)
    80003740:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003744:	00853503          	ld	a0,8(a0)
    80003748:	fffff097          	auipc	ra,0xfffff
    8000374c:	8d4080e7          	jalr	-1836(ra) # 8000201c <_Z8sem_waitP10_semaphore>
}
    80003750:	00813083          	ld	ra,8(sp)
    80003754:	00013403          	ld	s0,0(sp)
    80003758:	01010113          	addi	sp,sp,16
    8000375c:	00008067          	ret

0000000080003760 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003760:	ff010113          	addi	sp,sp,-16
    80003764:	00113423          	sd	ra,8(sp)
    80003768:	00813023          	sd	s0,0(sp)
    8000376c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003770:	00853503          	ld	a0,8(a0)
    80003774:	fffff097          	auipc	ra,0xfffff
    80003778:	8d4080e7          	jalr	-1836(ra) # 80002048 <_Z10sem_signalP10_semaphore>
}
    8000377c:	00813083          	ld	ra,8(sp)
    80003780:	00013403          	ld	s0,0(sp)
    80003784:	01010113          	addi	sp,sp,16
    80003788:	00008067          	ret

000000008000378c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000378c:	ff010113          	addi	sp,sp,-16
    80003790:	00113423          	sd	ra,8(sp)
    80003794:	00813023          	sd	s0,0(sp)
    80003798:	01010413          	addi	s0,sp,16
    8000379c:	00008797          	auipc	a5,0x8
    800037a0:	1d478793          	addi	a5,a5,468 # 8000b970 <_ZTV6Thread+0x10>
    800037a4:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    800037a8:	00850513          	addi	a0,a0,8
    800037ac:	ffffe097          	auipc	ra,0xffffe
    800037b0:	764080e7          	jalr	1892(ra) # 80001f10 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    800037b4:	00813083          	ld	ra,8(sp)
    800037b8:	00013403          	ld	s0,0(sp)
    800037bc:	01010113          	addi	sp,sp,16
    800037c0:	00008067          	ret

00000000800037c4 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800037c4:	ff010113          	addi	sp,sp,-16
    800037c8:	00113423          	sd	ra,8(sp)
    800037cc:	00813023          	sd	s0,0(sp)
    800037d0:	01010413          	addi	s0,sp,16
    800037d4:	00008797          	auipc	a5,0x8
    800037d8:	19c78793          	addi	a5,a5,412 # 8000b970 <_ZTV6Thread+0x10>
    800037dc:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    800037e0:	00050613          	mv	a2,a0
    800037e4:	00000597          	auipc	a1,0x0
    800037e8:	d7c58593          	addi	a1,a1,-644 # 80003560 <_ZN6Thread7wrapperEPv>
    800037ec:	00850513          	addi	a0,a0,8
    800037f0:	ffffe097          	auipc	ra,0xffffe
    800037f4:	720080e7          	jalr	1824(ra) # 80001f10 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    800037f8:	00813083          	ld	ra,8(sp)
    800037fc:	00013403          	ld	s0,0(sp)
    80003800:	01010113          	addi	sp,sp,16
    80003804:	00008067          	ret

0000000080003808 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003808:	ff010113          	addi	sp,sp,-16
    8000380c:	00113423          	sd	ra,8(sp)
    80003810:	00813023          	sd	s0,0(sp)
    80003814:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003818:	fffff097          	auipc	ra,0xfffff
    8000381c:	85c080e7          	jalr	-1956(ra) # 80002074 <_Z10time_sleepm>
}
    80003820:	00813083          	ld	ra,8(sp)
    80003824:	00013403          	ld	s0,0(sp)
    80003828:	01010113          	addi	sp,sp,16
    8000382c:	00008067          	ret

0000000080003830 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80003830:	fe010113          	addi	sp,sp,-32
    80003834:	00113c23          	sd	ra,24(sp)
    80003838:	00813823          	sd	s0,16(sp)
    8000383c:	00913423          	sd	s1,8(sp)
    80003840:	01213023          	sd	s2,0(sp)
    80003844:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80003848:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000384c:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80003850:	0004b783          	ld	a5,0(s1)
    80003854:	0187b783          	ld	a5,24(a5)
    80003858:	00048513          	mv	a0,s1
    8000385c:	000780e7          	jalr	a5
        pt->sleep(time);
    80003860:	00090513          	mv	a0,s2
    80003864:	00000097          	auipc	ra,0x0
    80003868:	fa4080e7          	jalr	-92(ra) # 80003808 <_ZN6Thread5sleepEm>
    while(true){
    8000386c:	fe5ff06f          	j	80003850 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080003870 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003870:	ff010113          	addi	sp,sp,-16
    80003874:	00113423          	sd	ra,8(sp)
    80003878:	00813023          	sd	s0,0(sp)
    8000387c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003880:	ffffe097          	auipc	ra,0xffffe
    80003884:	670080e7          	jalr	1648(ra) # 80001ef0 <_Z15thread_dispatchv>
}
    80003888:	00813083          	ld	ra,8(sp)
    8000388c:	00013403          	ld	s0,0(sp)
    80003890:	01010113          	addi	sp,sp,16
    80003894:	00008067          	ret

0000000080003898 <_ZN6Thread5startEv>:
int Thread::start() {
    80003898:	ff010113          	addi	sp,sp,-16
    8000389c:	00113423          	sd	ra,8(sp)
    800038a0:	00813023          	sd	s0,0(sp)
    800038a4:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    800038a8:	00853503          	ld	a0,8(a0)
    800038ac:	ffffe097          	auipc	ra,0xffffe
    800038b0:	6e0080e7          	jalr	1760(ra) # 80001f8c <_Z12thread_startP7_thread>
}
    800038b4:	00813083          	ld	ra,8(sp)
    800038b8:	00013403          	ld	s0,0(sp)
    800038bc:	01010113          	addi	sp,sp,16
    800038c0:	00008067          	ret

00000000800038c4 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800038c4:	fe010113          	addi	sp,sp,-32
    800038c8:	00113c23          	sd	ra,24(sp)
    800038cc:	00813823          	sd	s0,16(sp)
    800038d0:	00913423          	sd	s1,8(sp)
    800038d4:	01213023          	sd	s2,0(sp)
    800038d8:	02010413          	addi	s0,sp,32
    800038dc:	00050493          	mv	s1,a0
    800038e0:	00058913          	mv	s2,a1
    800038e4:	01000513          	li	a0,16
    800038e8:	00000097          	auipc	ra,0x0
    800038ec:	d1c080e7          	jalr	-740(ra) # 80003604 <_Znwm>
    800038f0:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    800038f4:	00953023          	sd	s1,0(a0)
    800038f8:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800038fc:	00000597          	auipc	a1,0x0
    80003900:	f3458593          	addi	a1,a1,-204 # 80003830 <_ZN14PeriodicThread7wrapperEPv>
    80003904:	00048513          	mv	a0,s1
    80003908:	00000097          	auipc	ra,0x0
    8000390c:	e84080e7          	jalr	-380(ra) # 8000378c <_ZN6ThreadC1EPFvPvES0_>
    80003910:	00008797          	auipc	a5,0x8
    80003914:	01078793          	addi	a5,a5,16 # 8000b920 <_ZTV14PeriodicThread+0x10>
    80003918:	00f4b023          	sd	a5,0(s1)
    8000391c:	01813083          	ld	ra,24(sp)
    80003920:	01013403          	ld	s0,16(sp)
    80003924:	00813483          	ld	s1,8(sp)
    80003928:	00013903          	ld	s2,0(sp)
    8000392c:	02010113          	addi	sp,sp,32
    80003930:	00008067          	ret

0000000080003934 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80003934:	ff010113          	addi	sp,sp,-16
    80003938:	00113423          	sd	ra,8(sp)
    8000393c:	00813023          	sd	s0,0(sp)
    80003940:	01010413          	addi	s0,sp,16
    return ::getc();
    80003944:	ffffe097          	auipc	ra,0xffffe
    80003948:	75c080e7          	jalr	1884(ra) # 800020a0 <_Z4getcv>
}
    8000394c:	00813083          	ld	ra,8(sp)
    80003950:	00013403          	ld	s0,0(sp)
    80003954:	01010113          	addi	sp,sp,16
    80003958:	00008067          	ret

000000008000395c <_ZN7Console4putcEc>:

void Console::putc(char c) {
    8000395c:	ff010113          	addi	sp,sp,-16
    80003960:	00113423          	sd	ra,8(sp)
    80003964:	00813023          	sd	s0,0(sp)
    80003968:	01010413          	addi	s0,sp,16
    ::putc(c);
    8000396c:	ffffe097          	auipc	ra,0xffffe
    80003970:	75c080e7          	jalr	1884(ra) # 800020c8 <_Z4putcc>
}
    80003974:	00813083          	ld	ra,8(sp)
    80003978:	00013403          	ld	s0,0(sp)
    8000397c:	01010113          	addi	sp,sp,16
    80003980:	00008067          	ret

0000000080003984 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003984:	ff010113          	addi	sp,sp,-16
    80003988:	00813423          	sd	s0,8(sp)
    8000398c:	01010413          	addi	s0,sp,16
    80003990:	00813403          	ld	s0,8(sp)
    80003994:	01010113          	addi	sp,sp,16
    80003998:	00008067          	ret

000000008000399c <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000399c:	ff010113          	addi	sp,sp,-16
    800039a0:	00813423          	sd	s0,8(sp)
    800039a4:	01010413          	addi	s0,sp,16
    800039a8:	00813403          	ld	s0,8(sp)
    800039ac:	01010113          	addi	sp,sp,16
    800039b0:	00008067          	ret

00000000800039b4 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    800039b4:	ff010113          	addi	sp,sp,-16
    800039b8:	00113423          	sd	ra,8(sp)
    800039bc:	00813023          	sd	s0,0(sp)
    800039c0:	01010413          	addi	s0,sp,16
    800039c4:	00008797          	auipc	a5,0x8
    800039c8:	f5c78793          	addi	a5,a5,-164 # 8000b920 <_ZTV14PeriodicThread+0x10>
    800039cc:	00f53023          	sd	a5,0(a0)
    800039d0:	00000097          	auipc	ra,0x0
    800039d4:	bf4080e7          	jalr	-1036(ra) # 800035c4 <_ZN6ThreadD1Ev>
    800039d8:	00813083          	ld	ra,8(sp)
    800039dc:	00013403          	ld	s0,0(sp)
    800039e0:	01010113          	addi	sp,sp,16
    800039e4:	00008067          	ret

00000000800039e8 <_ZN14PeriodicThreadD0Ev>:
    800039e8:	fe010113          	addi	sp,sp,-32
    800039ec:	00113c23          	sd	ra,24(sp)
    800039f0:	00813823          	sd	s0,16(sp)
    800039f4:	00913423          	sd	s1,8(sp)
    800039f8:	02010413          	addi	s0,sp,32
    800039fc:	00050493          	mv	s1,a0
    80003a00:	00008797          	auipc	a5,0x8
    80003a04:	f2078793          	addi	a5,a5,-224 # 8000b920 <_ZTV14PeriodicThread+0x10>
    80003a08:	00f53023          	sd	a5,0(a0)
    80003a0c:	00000097          	auipc	ra,0x0
    80003a10:	bb8080e7          	jalr	-1096(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80003a14:	00048513          	mv	a0,s1
    80003a18:	00000097          	auipc	ra,0x0
    80003a1c:	c3c080e7          	jalr	-964(ra) # 80003654 <_ZdlPv>
    80003a20:	01813083          	ld	ra,24(sp)
    80003a24:	01013403          	ld	s0,16(sp)
    80003a28:	00813483          	ld	s1,8(sp)
    80003a2c:	02010113          	addi	sp,sp,32
    80003a30:	00008067          	ret

0000000080003a34 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003a34:	ff010113          	addi	sp,sp,-16
    80003a38:	00113423          	sd	ra,8(sp)
    80003a3c:	00813023          	sd	s0,0(sp)
    80003a40:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003a44:	00008797          	auipc	a5,0x8
    80003a48:	02c7b783          	ld	a5,44(a5) # 8000ba70 <_GLOBAL_OFFSET_TABLE_+0x70>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003a4c:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80003a50:	00008797          	auipc	a5,0x8
    80003a54:	fc87b783          	ld	a5,-56(a5) # 8000ba18 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003a58:	0007b503          	ld	a0,0(a5)
    80003a5c:	00c55513          	srli	a0,a0,0xc
    80003a60:	00250513          	addi	a0,a0,2
    80003a64:	000015b7          	lui	a1,0x1
    80003a68:	00c51513          	slli	a0,a0,0xc
    80003a6c:	00001097          	auipc	ra,0x1
    80003a70:	5b0080e7          	jalr	1456(ra) # 8000501c <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80003a74:	fffff097          	auipc	ra,0xfffff
    80003a78:	650080e7          	jalr	1616(ra) # 800030c4 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003a7c:	00001097          	auipc	ra,0x1
    80003a80:	f5c080e7          	jalr	-164(ra) # 800049d8 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003a84:	fffff097          	auipc	ra,0xfffff
    80003a88:	504080e7          	jalr	1284(ra) # 80002f88 <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    80003a8c:	00001097          	auipc	ra,0x1
    80003a90:	160080e7          	jalr	352(ra) # 80004bec <_ZN11ConsoleUtil10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003a94:	00200793          	li	a5,2
    80003a98:	1047a073          	csrs	sie,a5
    80003a9c:	20000713          	li	a4,512
    80003aa0:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003aa4:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003aa8:	00813083          	ld	ra,8(sp)
    80003aac:	00013403          	ld	s0,0(sp)
    80003ab0:	01010113          	addi	sp,sp,16
    80003ab4:	00008067          	ret

0000000080003ab8 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003ab8:	ff010113          	addi	sp,sp,-16
    80003abc:	00813423          	sd	s0,8(sp)
    80003ac0:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003ac4:	14109073          	csrw	sepc,ra
    asm("sret");
    80003ac8:	10200073          	sret
}
    80003acc:	00813403          	ld	s0,8(sp)
    80003ad0:	01010113          	addi	sp,sp,16
    80003ad4:	00008067          	ret

0000000080003ad8 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003ad8:	ff010113          	addi	sp,sp,-16
    80003adc:	00113423          	sd	ra,8(sp)
    80003ae0:	00813023          	sd	s0,0(sp)
    80003ae4:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003ae8:	00008797          	auipc	a5,0x8
    80003aec:	fa87b783          	ld	a5,-88(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003af0:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003af4:	00100713          	li	a4,1
    80003af8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003afc:	fffff097          	auipc	ra,0xfffff
    80003b00:	3e4080e7          	jalr	996(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
}
    80003b04:	00813083          	ld	ra,8(sp)
    80003b08:	00013403          	ld	s0,0(sp)
    80003b0c:	01010113          	addi	sp,sp,16
    80003b10:	00008067          	ret

0000000080003b14 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003b14:	ff010113          	addi	sp,sp,-16
    80003b18:	00113423          	sd	ra,8(sp)
    80003b1c:	00813023          	sd	s0,0(sp)
    80003b20:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003b24:	00008797          	auipc	a5,0x8
    80003b28:	19c7c783          	lbu	a5,412(a5) # 8000bcc0 <_ZN5RiscV16userMainFinishedE>
    80003b2c:	00079c63          	bnez	a5,80003b44 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003b30:	00008717          	auipc	a4,0x8
    80003b34:	f5873703          	ld	a4,-168(a4) # 8000ba88 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b38:	00073783          	ld	a5,0(a4)
    80003b3c:	00178793          	addi	a5,a5,1
    80003b40:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003b44:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003b48:	0ff57513          	andi	a0,a0,255
    80003b4c:	00001097          	auipc	ra,0x1
    80003b50:	230080e7          	jalr	560(ra) # 80004d7c <_ZN11ConsoleUtil9putOutputEc>
}
    80003b54:	00813083          	ld	ra,8(sp)
    80003b58:	00013403          	ld	s0,0(sp)
    80003b5c:	01010113          	addi	sp,sp,16
    80003b60:	00008067          	ret

0000000080003b64 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003b64:	fe010113          	addi	sp,sp,-32
    80003b68:	00113c23          	sd	ra,24(sp)
    80003b6c:	00813823          	sd	s0,16(sp)
    80003b70:	02010413          	addi	s0,sp,32
    80003b74:	00c0006f          	j	80003b80 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003b78:	ffffe097          	auipc	ra,0xffffe
    80003b7c:	378080e7          	jalr	888(ra) # 80001ef0 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003b80:	00008797          	auipc	a5,0x8
    80003b84:	e907b783          	ld	a5,-368(a5) # 8000ba10 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003b88:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003b8c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003b90:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003b94:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003b98:	0207f793          	andi	a5,a5,32
    80003b9c:	fc078ee3          	beqz	a5,80003b78 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003ba0:	00001097          	auipc	ra,0x1
    80003ba4:	454080e7          	jalr	1108(ra) # 80004ff4 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003ba8:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003bac:	00008797          	auipc	a5,0x8
    80003bb0:	e5c7b783          	ld	a5,-420(a5) # 8000ba08 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003bb4:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003bb8:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003bbc:	fef44783          	lbu	a5,-17(s0)
    80003bc0:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003bc4:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003bc8:	00008797          	auipc	a5,0x8
    80003bcc:	ec07b783          	ld	a5,-320(a5) # 8000ba88 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003bd0:	0007b783          	ld	a5,0(a5)
    80003bd4:	fa0786e3          	beqz	a5,80003b80 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003bd8:	fff78793          	addi	a5,a5,-1
    80003bdc:	00008717          	auipc	a4,0x8
    80003be0:	eac73703          	ld	a4,-340(a4) # 8000ba88 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003be4:	00f73023          	sd	a5,0(a4)
    80003be8:	f99ff06f          	j	80003b80 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003bec <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003bec:	ff010113          	addi	sp,sp,-16
    80003bf0:	00813423          	sd	s0,8(sp)
    80003bf4:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003bf8:	00008797          	auipc	a5,0x8
    80003bfc:	e987b783          	ld	a5,-360(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003c00:	0007b783          	ld	a5,0(a5)
    80003c04:	0147a703          	lw	a4,20(a5)
    80003c08:	00100793          	li	a5,1
    80003c0c:	00f70c63          	beq	a4,a5,80003c24 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003c10:	10000793          	li	a5,256
    80003c14:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80003c18:	00813403          	ld	s0,8(sp)
    80003c1c:	01010113          	addi	sp,sp,16
    80003c20:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003c24:	10000793          	li	a5,256
    80003c28:	1007a073          	csrs	sstatus,a5
}
    80003c2c:	fedff06f          	j	80003c18 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080003c30 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003c30:	ff010113          	addi	sp,sp,-16
    80003c34:	00113423          	sd	ra,8(sp)
    80003c38:	00813023          	sd	s0,0(sp)
    80003c3c:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003c40:	00100793          	li	a5,1
    80003c44:	00008717          	auipc	a4,0x8
    80003c48:	06f70e23          	sb	a5,124(a4) # 8000bcc0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003c4c:	00008797          	auipc	a5,0x8
    80003c50:	e3c7b783          	ld	a5,-452(a5) # 8000ba88 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003c54:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003c58:	00008797          	auipc	a5,0x8
    80003c5c:	de87b783          	ld	a5,-536(a5) # 8000ba40 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003c60:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003c64:	00200793          	li	a5,2
    80003c68:	1047b073          	csrc	sie,a5
    80003c6c:	20000793          	li	a5,512
    80003c70:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003c74:	00008797          	auipc	a5,0x8
    80003c78:	dec7b783          	ld	a5,-532(a5) # 8000ba60 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003c7c:	0007b783          	ld	a5,0(a5)
    80003c80:	00078c63          	beqz	a5,80003c98 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003c84:	0487b703          	ld	a4,72(a5)
    80003c88:	00008797          	auipc	a5,0x8
    80003c8c:	dd87b783          	ld	a5,-552(a5) # 8000ba60 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003c90:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003c94:	fe1ff06f          	j	80003c74 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003c98:	00008797          	auipc	a5,0x8
    80003c9c:	dd07b783          	ld	a5,-560(a5) # 8000ba68 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003ca0:	0007b503          	ld	a0,0(a5)
    80003ca4:	00001097          	auipc	ra,0x1
    80003ca8:	d4c080e7          	jalr	-692(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003cac:	00008797          	auipc	a5,0x8
    80003cb0:	dcc7b783          	ld	a5,-564(a5) # 8000ba78 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003cb4:	0007b703          	ld	a4,0(a5)
    80003cb8:	00008797          	auipc	a5,0x8
    80003cbc:	dc87b783          	ld	a5,-568(a5) # 8000ba80 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003cc0:	0007b783          	ld	a5,0(a5)
    80003cc4:	00f70863          	beq	a4,a5,80003cd4 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003cc8:	ffffe097          	auipc	ra,0xffffe
    80003ccc:	228080e7          	jalr	552(ra) # 80001ef0 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003cd0:	fddff06f          	j	80003cac <_ZN5RiscV8finalizeEv+0x7c>
}
    80003cd4:	00813083          	ld	ra,8(sp)
    80003cd8:	00013403          	ld	s0,0(sp)
    80003cdc:	01010113          	addi	sp,sp,16
    80003ce0:	00008067          	ret

0000000080003ce4 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003ce4:	ff010113          	addi	sp,sp,-16
    80003ce8:	00813423          	sd	s0,8(sp)
    80003cec:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003cf0:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003cf4:	00008717          	auipc	a4,0x8
    80003cf8:	d9c73703          	ld	a4,-612(a4) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003cfc:	00073703          	ld	a4,0(a4)
    80003d00:	06873703          	ld	a4,104(a4)
    80003d04:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003d08:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003d0c:	00078593          	mv	a1,a5
}
    80003d10:	00813403          	ld	s0,8(sp)
    80003d14:	01010113          	addi	sp,sp,16
    80003d18:	00008067          	ret

0000000080003d1c <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003d1c:	ff010113          	addi	sp,sp,-16
    80003d20:	00113423          	sd	ra,8(sp)
    80003d24:	00813023          	sd	s0,0(sp)
    80003d28:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003d2c:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80003d30:	fffff097          	auipc	ra,0xfffff
    80003d34:	414080e7          	jalr	1044(ra) # 80003144 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003d38:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003d3c:	00000097          	auipc	ra,0x0
    80003d40:	fa8080e7          	jalr	-88(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d44:	00813083          	ld	ra,8(sp)
    80003d48:	00013403          	ld	s0,0(sp)
    80003d4c:	01010113          	addi	sp,sp,16
    80003d50:	00008067          	ret

0000000080003d54 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003d54:	ff010113          	addi	sp,sp,-16
    80003d58:	00113423          	sd	ra,8(sp)
    80003d5c:	00813023          	sd	s0,0(sp)
    80003d60:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003d64:	00008797          	auipc	a5,0x8
    80003d68:	d347b783          	ld	a5,-716(a5) # 8000ba98 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003d6c:	0007c783          	lbu	a5,0(a5)
    80003d70:	02079263          	bnez	a5,80003d94 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003d74:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d78:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003d7c:	00000097          	auipc	ra,0x0
    80003d80:	f68080e7          	jalr	-152(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d84:	00813083          	ld	ra,8(sp)
    80003d88:	00013403          	ld	s0,0(sp)
    80003d8c:	01010113          	addi	sp,sp,16
    80003d90:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003d94:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	5d4080e7          	jalr	1492(ra) # 8000336c <_ZN15MemoryAllocator5kfreeEPv>
    80003da0:	fd9ff06f          	j	80003d78 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003da4 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003da4:	fc010113          	addi	sp,sp,-64
    80003da8:	02113c23          	sd	ra,56(sp)
    80003dac:	02813823          	sd	s0,48(sp)
    80003db0:	02913423          	sd	s1,40(sp)
    80003db4:	03213023          	sd	s2,32(sp)
    80003db8:	01313c23          	sd	s3,24(sp)
    80003dbc:	01413823          	sd	s4,16(sp)
    80003dc0:	01513423          	sd	s5,8(sp)
    80003dc4:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003dc8:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003dcc:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003dd0:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003dd4:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003dd8:	07000513          	li	a0,112
    80003ddc:	fffff097          	auipc	ra,0xfffff
    80003de0:	184080e7          	jalr	388(ra) # 80002f60 <_ZN3TCBnwEm>
    80003de4:	00050493          	mv	s1,a0
    80003de8:	00200713          	li	a4,2
    80003dec:	000a0693          	mv	a3,s4
    80003df0:	00098613          	mv	a2,s3
    80003df4:	00090593          	mv	a1,s2
    80003df8:	fffff097          	auipc	ra,0xfffff
    80003dfc:	01c080e7          	jalr	28(ra) # 80002e14 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003e00:	04048863          	beqz	s1,80003e50 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003e04:	0184b783          	ld	a5,24(s1)
    80003e08:	00078863          	beqz	a5,80003e18 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003e0c:	00048513          	mv	a0,s1
    80003e10:	00001097          	auipc	ra,0x1
    80003e14:	be0080e7          	jalr	-1056(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003e18:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003e1c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e20:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003e24:	00000097          	auipc	ra,0x0
    80003e28:	ec0080e7          	jalr	-320(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e2c:	03813083          	ld	ra,56(sp)
    80003e30:	03013403          	ld	s0,48(sp)
    80003e34:	02813483          	ld	s1,40(sp)
    80003e38:	02013903          	ld	s2,32(sp)
    80003e3c:	01813983          	ld	s3,24(sp)
    80003e40:	01013a03          	ld	s4,16(sp)
    80003e44:	00813a83          	ld	s5,8(sp)
    80003e48:	04010113          	addi	sp,sp,64
    80003e4c:	00008067          	ret
        status = -1;
    80003e50:	fff00793          	li	a5,-1
    80003e54:	fcdff06f          	j	80003e20 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    80003e58:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003e5c:	00048513          	mv	a0,s1
    80003e60:	fffff097          	auipc	ra,0xfffff
    80003e64:	1f4080e7          	jalr	500(ra) # 80003054 <_ZN3TCBdlEPv>
    80003e68:	00090513          	mv	a0,s2
    80003e6c:	0000d097          	auipc	ra,0xd
    80003e70:	f9c080e7          	jalr	-100(ra) # 80010e08 <_Unwind_Resume>

0000000080003e74 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003e74:	fc010113          	addi	sp,sp,-64
    80003e78:	02113c23          	sd	ra,56(sp)
    80003e7c:	02813823          	sd	s0,48(sp)
    80003e80:	02913423          	sd	s1,40(sp)
    80003e84:	03213023          	sd	s2,32(sp)
    80003e88:	01313c23          	sd	s3,24(sp)
    80003e8c:	01413823          	sd	s4,16(sp)
    80003e90:	01513423          	sd	s5,8(sp)
    80003e94:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003e98:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003e9c:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003ea0:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003ea4:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003ea8:	07000513          	li	a0,112
    80003eac:	fffff097          	auipc	ra,0xfffff
    80003eb0:	0b4080e7          	jalr	180(ra) # 80002f60 <_ZN3TCBnwEm>
    80003eb4:	00050493          	mv	s1,a0
    80003eb8:	00200713          	li	a4,2
    80003ebc:	00090693          	mv	a3,s2
    80003ec0:	00098613          	mv	a2,s3
    80003ec4:	000a0593          	mv	a1,s4
    80003ec8:	fffff097          	auipc	ra,0xfffff
    80003ecc:	f4c080e7          	jalr	-180(ra) # 80002e14 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003ed0:	04048263          	beqz	s1,80003f14 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003ed4:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003ed8:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003edc:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003ee0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ee4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003ee8:	00000097          	auipc	ra,0x0
    80003eec:	dfc080e7          	jalr	-516(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ef0:	03813083          	ld	ra,56(sp)
    80003ef4:	03013403          	ld	s0,48(sp)
    80003ef8:	02813483          	ld	s1,40(sp)
    80003efc:	02013903          	ld	s2,32(sp)
    80003f00:	01813983          	ld	s3,24(sp)
    80003f04:	01013a03          	ld	s4,16(sp)
    80003f08:	00813a83          	ld	s5,8(sp)
    80003f0c:	04010113          	addi	sp,sp,64
    80003f10:	00008067          	ret
        status = -1;
    80003f14:	fff00793          	li	a5,-1
    80003f18:	fcdff06f          	j	80003ee4 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003f1c:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003f20:	00048513          	mv	a0,s1
    80003f24:	fffff097          	auipc	ra,0xfffff
    80003f28:	130080e7          	jalr	304(ra) # 80003054 <_ZN3TCBdlEPv>
    80003f2c:	00090513          	mv	a0,s2
    80003f30:	0000d097          	auipc	ra,0xd
    80003f34:	ed8080e7          	jalr	-296(ra) # 80010e08 <_Unwind_Resume>

0000000080003f38 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003f38:	ff010113          	addi	sp,sp,-16
    80003f3c:	00113423          	sd	ra,8(sp)
    80003f40:	00813023          	sd	s0,0(sp)
    80003f44:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003f48:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003f4c:	02051263          	bnez	a0,80003f70 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003f50:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003f54:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003f58:	00000097          	auipc	ra,0x0
    80003f5c:	d8c080e7          	jalr	-628(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003f60:	00813083          	ld	ra,8(sp)
    80003f64:	00013403          	ld	s0,0(sp)
    80003f68:	01010113          	addi	sp,sp,16
    80003f6c:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003f70:	00100793          	li	a5,1
    80003f74:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003f78:	00001097          	auipc	ra,0x1
    80003f7c:	a78080e7          	jalr	-1416(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003f80:	fffff097          	auipc	ra,0xfffff
    80003f84:	f60080e7          	jalr	-160(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003f88:	00000793          	li	a5,0
    80003f8c:	fc9ff06f          	j	80003f54 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003f90 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003f90:	ff010113          	addi	sp,sp,-16
    80003f94:	00113423          	sd	ra,8(sp)
    80003f98:	00813023          	sd	s0,0(sp)
    80003f9c:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003fa0:	00008797          	auipc	a5,0x8
    80003fa4:	af07b783          	ld	a5,-1296(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003fa8:	0007b783          	ld	a5,0(a5)
    80003fac:	02078a63          	beqz	a5,80003fe0 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003fb0:	00200713          	li	a4,2
    80003fb4:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003fb8:	fffff097          	auipc	ra,0xfffff
    80003fbc:	f28080e7          	jalr	-216(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003fc0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003fc4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003fc8:	00000097          	auipc	ra,0x0
    80003fcc:	d1c080e7          	jalr	-740(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003fd0:	00813083          	ld	ra,8(sp)
    80003fd4:	00013403          	ld	s0,0(sp)
    80003fd8:	01010113          	addi	sp,sp,16
    80003fdc:	00008067          	ret
        status = -1;
    80003fe0:	fff00793          	li	a5,-1
    80003fe4:	fe1ff06f          	j	80003fc4 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003fe8 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003fe8:	fd010113          	addi	sp,sp,-48
    80003fec:	02113423          	sd	ra,40(sp)
    80003ff0:	02813023          	sd	s0,32(sp)
    80003ff4:	00913c23          	sd	s1,24(sp)
    80003ff8:	01213823          	sd	s2,16(sp)
    80003ffc:	01313423          	sd	s3,8(sp)
    80004000:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004004:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80004008:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    8000400c:	01800513          	li	a0,24
    80004010:	fffff097          	auipc	ra,0xfffff
    80004014:	d14080e7          	jalr	-748(ra) # 80002d24 <_ZN3SCBnwEm>
    80004018:	00050493          	mv	s1,a0
    8000401c:	00090593          	mv	a1,s2
    80004020:	fffff097          	auipc	ra,0xfffff
    80004024:	b48080e7          	jalr	-1208(ra) # 80002b68 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80004028:	02048a63          	beqz	s1,8000405c <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    8000402c:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    80004030:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004034:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004038:	00000097          	auipc	ra,0x0
    8000403c:	cac080e7          	jalr	-852(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004040:	02813083          	ld	ra,40(sp)
    80004044:	02013403          	ld	s0,32(sp)
    80004048:	01813483          	ld	s1,24(sp)
    8000404c:	01013903          	ld	s2,16(sp)
    80004050:	00813983          	ld	s3,8(sp)
    80004054:	03010113          	addi	sp,sp,48
    80004058:	00008067          	ret
        status = -1;
    8000405c:	fff00793          	li	a5,-1
    80004060:	fd5ff06f          	j	80004034 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80004064:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80004068:	00048513          	mv	a0,s1
    8000406c:	fffff097          	auipc	ra,0xfffff
    80004070:	ce0080e7          	jalr	-800(ra) # 80002d4c <_ZN3SCBdlEPv>
    80004074:	00090513          	mv	a0,s2
    80004078:	0000d097          	auipc	ra,0xd
    8000407c:	d90080e7          	jalr	-624(ra) # 80010e08 <_Unwind_Resume>

0000000080004080 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80004080:	fe010113          	addi	sp,sp,-32
    80004084:	00113c23          	sd	ra,24(sp)
    80004088:	00813823          	sd	s0,16(sp)
    8000408c:	00913423          	sd	s1,8(sp)
    80004090:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004094:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80004098:	02049463          	bnez	s1,800040c0 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    8000409c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800040a0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800040a4:	00000097          	auipc	ra,0x0
    800040a8:	c40080e7          	jalr	-960(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    800040ac:	01813083          	ld	ra,24(sp)
    800040b0:	01013403          	ld	s0,16(sp)
    800040b4:	00813483          	ld	s1,8(sp)
    800040b8:	02010113          	addi	sp,sp,32
    800040bc:	00008067          	ret
        delete (SCB*)ihandle;
    800040c0:	00048513          	mv	a0,s1
    800040c4:	fffff097          	auipc	ra,0xfffff
    800040c8:	ac8080e7          	jalr	-1336(ra) # 80002b8c <_ZN3SCBD1Ev>
    800040cc:	00048513          	mv	a0,s1
    800040d0:	fffff097          	auipc	ra,0xfffff
    800040d4:	c7c080e7          	jalr	-900(ra) # 80002d4c <_ZN3SCBdlEPv>
    uint64 status = 0;
    800040d8:	00000793          	li	a5,0
    800040dc:	fc5ff06f          	j	800040a0 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800040e0 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800040e0:	ff010113          	addi	sp,sp,-16
    800040e4:	00113423          	sd	ra,8(sp)
    800040e8:	00813023          	sd	s0,0(sp)
    800040ec:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800040f0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800040f4:	02051c63          	bnez	a0,8000412c <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800040f8:	00008797          	auipc	a5,0x8
    800040fc:	9987b783          	ld	a5,-1640(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004100:	0007b783          	ld	a5,0(a5)
    80004104:	0607b783          	ld	a5,96(a5)
    80004108:	02078863          	beqz	a5,80004138 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    8000410c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004110:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004114:	00000097          	auipc	ra,0x0
    80004118:	bd0080e7          	jalr	-1072(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000411c:	00813083          	ld	ra,8(sp)
    80004120:	00013403          	ld	s0,0(sp)
    80004124:	01010113          	addi	sp,sp,16
    80004128:	00008067          	ret
        ((SCB*)ihandle)->wait();
    8000412c:	fffff097          	auipc	ra,0xfffff
    80004130:	b6c080e7          	jalr	-1172(ra) # 80002c98 <_ZN3SCB4waitEv>
    80004134:	fc5ff06f          	j	800040f8 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80004138:	00000793          	li	a5,0
    8000413c:	fd5ff06f          	j	80004110 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080004140 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80004140:	ff010113          	addi	sp,sp,-16
    80004144:	00113423          	sd	ra,8(sp)
    80004148:	00813023          	sd	s0,0(sp)
    8000414c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004150:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80004154:	02051263          	bnez	a0,80004178 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80004158:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000415c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004160:	00000097          	auipc	ra,0x0
    80004164:	b84080e7          	jalr	-1148(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004168:	00813083          	ld	ra,8(sp)
    8000416c:	00013403          	ld	s0,0(sp)
    80004170:	01010113          	addi	sp,sp,16
    80004174:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80004178:	fffff097          	auipc	ra,0xfffff
    8000417c:	b70080e7          	jalr	-1168(ra) # 80002ce8 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80004180:	00000793          	li	a5,0
    80004184:	fd9ff06f          	j	8000415c <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080004188 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80004188:	fe010113          	addi	sp,sp,-32
    8000418c:	00113c23          	sd	ra,24(sp)
    80004190:	00813823          	sd	s0,16(sp)
    80004194:	00913423          	sd	s1,8(sp)
    80004198:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    8000419c:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    800041a0:	00008797          	auipc	a5,0x8
    800041a4:	8f07b783          	ld	a5,-1808(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    800041a8:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    800041ac:	00008797          	auipc	a5,0x8
    800041b0:	b1c7b783          	ld	a5,-1252(a5) # 8000bcc8 <_ZN5RiscV10globalTimeE>
    800041b4:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    800041b8:	00e787b3          	add	a5,a5,a4
    800041bc:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    800041c0:	00048513          	mv	a0,s1
    800041c4:	00001097          	auipc	ra,0x1
    800041c8:	8a8080e7          	jalr	-1880(ra) # 80004a6c <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    800041cc:	00300793          	li	a5,3
    800041d0:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    800041d4:	fffff097          	auipc	ra,0xfffff
    800041d8:	d0c080e7          	jalr	-756(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    800041dc:	00000793          	li	a5,0
    800041e0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800041e4:	00000097          	auipc	ra,0x0
    800041e8:	b00080e7          	jalr	-1280(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    800041ec:	01813083          	ld	ra,24(sp)
    800041f0:	01013403          	ld	s0,16(sp)
    800041f4:	00813483          	ld	s1,8(sp)
    800041f8:	02010113          	addi	sp,sp,32
    800041fc:	00008067          	ret

0000000080004200 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80004200:	fe010113          	addi	sp,sp,-32
    80004204:	00113c23          	sd	ra,24(sp)
    80004208:	00813823          	sd	s0,16(sp)
    8000420c:	00913423          	sd	s1,8(sp)
    80004210:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80004214:	00008797          	auipc	a5,0x8
    80004218:	aac7c783          	lbu	a5,-1364(a5) # 8000bcc0 <_ZN5RiscV16userMainFinishedE>
    8000421c:	00079c63          	bnez	a5,80004234 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80004220:	00008717          	auipc	a4,0x8
    80004224:	82073703          	ld	a4,-2016(a4) # 8000ba40 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004228:	00073783          	ld	a5,0(a4)
    8000422c:	00178793          	addi	a5,a5,1
    80004230:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80004234:	00001097          	auipc	ra,0x1
    80004238:	ad0080e7          	jalr	-1328(ra) # 80004d04 <_ZN11ConsoleUtil8getInputEv>
    8000423c:	00050493          	mv	s1,a0
    if(c==13) {
    80004240:	00d00793          	li	a5,13
    80004244:	02f50663          	beq	a0,a5,80004270 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80004248:	01b00793          	li	a5,27
    8000424c:	04f51063          	bne	a0,a5,8000428c <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80004250:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80004254:	00000097          	auipc	ra,0x0
    80004258:	a90080e7          	jalr	-1392(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000425c:	01813083          	ld	ra,24(sp)
    80004260:	01013403          	ld	s0,16(sp)
    80004264:	00813483          	ld	s1,8(sp)
    80004268:	02010113          	addi	sp,sp,32
    8000426c:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80004270:	00d00513          	li	a0,13
    80004274:	00001097          	auipc	ra,0x1
    80004278:	b08080e7          	jalr	-1272(ra) # 80004d7c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    8000427c:	00a00513          	li	a0,10
    80004280:	00001097          	auipc	ra,0x1
    80004284:	afc080e7          	jalr	-1284(ra) # 80004d7c <_ZN11ConsoleUtil9putOutputEc>
    80004288:	fc9ff06f          	j	80004250 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    8000428c:	00001097          	auipc	ra,0x1
    80004290:	af0080e7          	jalr	-1296(ra) # 80004d7c <_ZN11ConsoleUtil9putOutputEc>
    80004294:	fbdff06f          	j	80004250 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004298 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004298:	ff010113          	addi	sp,sp,-16
    8000429c:	00113423          	sd	ra,8(sp)
    800042a0:	00813023          	sd	s0,0(sp)
    800042a4:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    800042a8:	00001097          	auipc	ra,0x1
    800042ac:	b54080e7          	jalr	-1196(ra) # 80004dfc <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    800042b0:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800042b4:	00000097          	auipc	ra,0x0
    800042b8:	a30080e7          	jalr	-1488(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    800042bc:	00813083          	ld	ra,8(sp)
    800042c0:	00013403          	ld	s0,0(sp)
    800042c4:	01010113          	addi	sp,sp,16
    800042c8:	00008067          	ret

00000000800042cc <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    800042cc:	fe010113          	addi	sp,sp,-32
    800042d0:	00113c23          	sd	ra,24(sp)
    800042d4:	00813823          	sd	s0,16(sp)
    800042d8:	00913423          	sd	s1,8(sp)
    800042dc:	01213023          	sd	s2,0(sp)
    800042e0:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800042e4:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800042e8:	02049663          	bnez	s1,80004314 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    800042ec:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800042f0:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    800042f4:	00000097          	auipc	ra,0x0
    800042f8:	9f0080e7          	jalr	-1552(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    800042fc:	01813083          	ld	ra,24(sp)
    80004300:	01013403          	ld	s0,16(sp)
    80004304:	00813483          	ld	s1,8(sp)
    80004308:	00013903          	ld	s2,0(sp)
    8000430c:	02010113          	addi	sp,sp,32
    80004310:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    80004314:	0284b503          	ld	a0,40(s1)
    80004318:	fffff097          	auipc	ra,0xfffff
    8000431c:	054080e7          	jalr	84(ra) # 8000336c <_ZN15MemoryAllocator5kfreeEPv>
    80004320:	00050913          	mv	s2,a0
        delete thr;
    80004324:	00048513          	mv	a0,s1
    80004328:	fffff097          	auipc	ra,0xfffff
    8000432c:	b90080e7          	jalr	-1136(ra) # 80002eb8 <_ZN3TCBD1Ev>
    80004330:	00048513          	mv	a0,s1
    80004334:	fffff097          	auipc	ra,0xfffff
    80004338:	d20080e7          	jalr	-736(ra) # 80003054 <_ZN3TCBdlEPv>
    8000433c:	fb5ff06f          	j	800042f0 <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

0000000080004340 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80004340:	fe010113          	addi	sp,sp,-32
    80004344:	00113c23          	sd	ra,24(sp)
    80004348:	00813823          	sd	s0,16(sp)
    8000434c:	00913423          	sd	s1,8(sp)
    80004350:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004354:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80004358:	02049463          	bnez	s1,80004380 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000435c:	fff00793          	li	a5,-1
    80004360:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004364:	00000097          	auipc	ra,0x0
    80004368:	980080e7          	jalr	-1664(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000436c:	01813083          	ld	ra,24(sp)
    80004370:	01013403          	ld	s0,16(sp)
    80004374:	00813483          	ld	s1,8(sp)
    80004378:	02010113          	addi	sp,sp,32
    8000437c:	00008067          	ret
        delete scb;
    80004380:	00048513          	mv	a0,s1
    80004384:	fffff097          	auipc	ra,0xfffff
    80004388:	808080e7          	jalr	-2040(ra) # 80002b8c <_ZN3SCBD1Ev>
    8000438c:	00048513          	mv	a0,s1
    80004390:	fffff097          	auipc	ra,0xfffff
    80004394:	9bc080e7          	jalr	-1604(ra) # 80002d4c <_ZN3SCBdlEPv>
    80004398:	fc5ff06f          	j	8000435c <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

000000008000439c <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    8000439c:	fe010113          	addi	sp,sp,-32
    800043a0:	00113c23          	sd	ra,24(sp)
    800043a4:	00813823          	sd	s0,16(sp)
    800043a8:	00913423          	sd	s1,8(sp)
    800043ac:	01213023          	sd	s2,0(sp)
    800043b0:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    800043b4:	04000513          	li	a0,64
    800043b8:	fffff097          	auipc	ra,0xfffff
    800043bc:	d8c080e7          	jalr	-628(ra) # 80003144 <_ZN15MemoryAllocator7kmallocEm>
    800043c0:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    800043c4:	00007797          	auipc	a5,0x7
    800043c8:	6cc7b783          	ld	a5,1740(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    800043cc:	0007b783          	ld	a5,0(a5)
    800043d0:	00001637          	lui	a2,0x1
    800043d4:	00050593          	mv	a1,a0
    800043d8:	0287b503          	ld	a0,40(a5)
    800043dc:	fffff097          	auipc	ra,0xfffff
    800043e0:	144080e7          	jalr	324(ra) # 80003520 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800043e4:	07000513          	li	a0,112
    800043e8:	fffff097          	auipc	ra,0xfffff
    800043ec:	b78080e7          	jalr	-1160(ra) # 80002f60 <_ZN3TCBnwEm>
    800043f0:	00050493          	mv	s1,a0
    800043f4:	00200713          	li	a4,2
    800043f8:	00090693          	mv	a3,s2
    800043fc:	00000613          	li	a2,0
    80004400:	00000593          	li	a1,0
    80004404:	fffff097          	auipc	ra,0xfffff
    80004408:	a10080e7          	jalr	-1520(ra) # 80002e14 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    8000440c:	0a048e63          	beqz	s1,800044c8 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80004410:	00007797          	auipc	a5,0x7
    80004414:	6487b783          	ld	a5,1608(a5) # 8000ba58 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004418:	0007b783          	ld	a5,0(a5)
    8000441c:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80004420:	00007797          	auipc	a5,0x7
    80004424:	6287b783          	ld	a5,1576(a5) # 8000ba48 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004428:	0007b783          	ld	a5,0(a5)
    8000442c:	00f907b3          	add	a5,s2,a5
    80004430:	00007717          	auipc	a4,0x7
    80004434:	66073703          	ld	a4,1632(a4) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004438:	00073683          	ld	a3,0(a4)
    8000443c:	0286b683          	ld	a3,40(a3)
    80004440:	40d787b3          	sub	a5,a5,a3
    80004444:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80004448:	00073783          	ld	a5,0(a4)
    8000444c:	0687b503          	ld	a0,104(a5)
    80004450:	0287b783          	ld	a5,40(a5)
    80004454:	40f50533          	sub	a0,a0,a5
    80004458:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    8000445c:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80004460:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80004464:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80004468:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    8000446c:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80004470:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80004474:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80004478:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000447c:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80004480:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80004484:	00073783          	ld	a5,0(a4)
    80004488:	0387b703          	ld	a4,56(a5)
    8000448c:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004490:	0407b783          	ld	a5,64(a5)
    80004494:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004498:	00048513          	mv	a0,s1
    8000449c:	00000097          	auipc	ra,0x0
    800044a0:	554080e7          	jalr	1364(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    800044a4:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    800044a8:	00000097          	auipc	ra,0x0
    800044ac:	83c080e7          	jalr	-1988(ra) # 80003ce4 <_ZN5RiscV16saveA0toSscratchEv>

}
    800044b0:	01813083          	ld	ra,24(sp)
    800044b4:	01013403          	ld	s0,16(sp)
    800044b8:	00813483          	ld	s1,8(sp)
    800044bc:	00013903          	ld	s2,0(sp)
    800044c0:	02010113          	addi	sp,sp,32
    800044c4:	00008067          	ret
        status = -1;
    800044c8:	fff00493          	li	s1,-1
    800044cc:	fd9ff06f          	j	800044a4 <_ZN5RiscV18executeForkSyscallEv+0x108>
    800044d0:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800044d4:	00048513          	mv	a0,s1
    800044d8:	fffff097          	auipc	ra,0xfffff
    800044dc:	b7c080e7          	jalr	-1156(ra) # 80003054 <_ZN3TCBdlEPv>
    800044e0:	00090513          	mv	a0,s2
    800044e4:	0000d097          	auipc	ra,0xd
    800044e8:	924080e7          	jalr	-1756(ra) # 80010e08 <_Unwind_Resume>

00000000800044ec <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    800044ec:	ff010113          	addi	sp,sp,-16
    800044f0:	00813423          	sd	s0,8(sp)
    800044f4:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800044f8:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800044fc:	00878793          	addi	a5,a5,8
    80004500:	00007717          	auipc	a4,0x7
    80004504:	55873703          	ld	a4,1368(a4) # 8000ba58 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004508:	00f73023          	sd	a5,0(a4)
}
    8000450c:	00813403          	ld	s0,8(sp)
    80004510:	01010113          	addi	sp,sp,16
    80004514:	00008067          	ret

0000000080004518 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004518:	fa010113          	addi	sp,sp,-96
    8000451c:	04113c23          	sd	ra,88(sp)
    80004520:	04813823          	sd	s0,80(sp)
    80004524:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004528:	142027f3          	csrr	a5,scause
    8000452c:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80004530:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    80004534:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80004538:	00007797          	auipc	a5,0x7
    8000453c:	5587b783          	ld	a5,1368(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004540:	0007b783          	ld	a5,0(a5)
    80004544:	14002773          	csrr	a4,sscratch
    80004548:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    8000454c:	fe843703          	ld	a4,-24(s0)
    80004550:	00900793          	li	a5,9
    80004554:	0ef70663          	beq	a4,a5,80004640 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    80004558:	fe843703          	ld	a4,-24(s0)
    8000455c:	00800793          	li	a5,8
    80004560:	0ef70063          	beq	a4,a5,80004640 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    80004564:	fe843703          	ld	a4,-24(s0)
    80004568:	fff00793          	li	a5,-1
    8000456c:	03f79793          	slli	a5,a5,0x3f
    80004570:	00178793          	addi	a5,a5,1
    80004574:	24f70263          	beq	a4,a5,800047b8 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    80004578:	fe843703          	ld	a4,-24(s0)
    8000457c:	fff00793          	li	a5,-1
    80004580:	03f79793          	slli	a5,a5,0x3f
    80004584:	00978793          	addi	a5,a5,9
    80004588:	2cf70063          	beq	a4,a5,80004848 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    8000458c:	fe843703          	ld	a4,-24(s0)
    80004590:	00200793          	li	a5,2
    80004594:	34f70863          	beq	a4,a5,800048e4 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004598:	00005517          	auipc	a0,0x5
    8000459c:	de850513          	addi	a0,a0,-536 # 80009380 <CONSOLE_STATUS+0x370>
    800045a0:	00001097          	auipc	ra,0x1
    800045a4:	8d4080e7          	jalr	-1836(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    800045a8:	00005517          	auipc	a0,0x5
    800045ac:	de850513          	addi	a0,a0,-536 # 80009390 <CONSOLE_STATUS+0x380>
    800045b0:	00001097          	auipc	ra,0x1
    800045b4:	8c4080e7          	jalr	-1852(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800045b8:	142027f3          	csrr	a5,scause
    800045bc:	fef43023          	sd	a5,-32(s0)
    return scause;
    800045c0:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    800045c4:	00000613          	li	a2,0
    800045c8:	00a00593          	li	a1,10
    800045cc:	0005051b          	sext.w	a0,a0
    800045d0:	00001097          	auipc	ra,0x1
    800045d4:	8e8080e7          	jalr	-1816(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    800045d8:	00005517          	auipc	a0,0x5
    800045dc:	d7850513          	addi	a0,a0,-648 # 80009350 <CONSOLE_STATUS+0x340>
    800045e0:	00001097          	auipc	ra,0x1
    800045e4:	894080e7          	jalr	-1900(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800045e8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800045ec:	00000613          	li	a2,0
    800045f0:	01000593          	li	a1,16
    800045f4:	0005051b          	sext.w	a0,a0
    800045f8:	00001097          	auipc	ra,0x1
    800045fc:	8c0080e7          	jalr	-1856(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004600:	00005517          	auipc	a0,0x5
    80004604:	d4850513          	addi	a0,a0,-696 # 80009348 <CONSOLE_STATUS+0x338>
    80004608:	00001097          	auipc	ra,0x1
    8000460c:	86c080e7          	jalr	-1940(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80004610:	00007797          	auipc	a5,0x7
    80004614:	4807b783          	ld	a5,1152(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004618:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000461c:	00200713          	li	a4,2
    80004620:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80004624:	00005517          	auipc	a0,0x5
    80004628:	d7c50513          	addi	a0,a0,-644 # 800093a0 <CONSOLE_STATUS+0x390>
    8000462c:	00001097          	auipc	ra,0x1
    80004630:	848080e7          	jalr	-1976(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004634:	fffff097          	auipc	ra,0xfffff
    80004638:	8ac080e7          	jalr	-1876(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
    8000463c:	0800006f          	j	800046bc <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004640:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004644:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004648:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    8000464c:	00478793          	addi	a5,a5,4
    80004650:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80004654:	00007797          	auipc	a5,0x7
    80004658:	43c7b783          	ld	a5,1084(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000465c:	0007b783          	ld	a5,0(a5)
    80004660:	fb043703          	ld	a4,-80(s0)
    80004664:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80004668:	fa843703          	ld	a4,-88(s0)
    8000466c:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80004670:	00050793          	mv	a5,a0
        switch(syscallID){
    80004674:	06100713          	li	a4,97
    80004678:	02f76463          	bltu	a4,a5,800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    8000467c:	00279793          	slli	a5,a5,0x2
    80004680:	00005717          	auipc	a4,0x5
    80004684:	d3470713          	addi	a4,a4,-716 # 800093b4 <CONSOLE_STATUS+0x3a4>
    80004688:	00e787b3          	add	a5,a5,a4
    8000468c:	0007a783          	lw	a5,0(a5)
    80004690:	00e787b3          	add	a5,a5,a4
    80004694:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004698:	fffff097          	auipc	ra,0xfffff
    8000469c:	684080e7          	jalr	1668(ra) # 80003d1c <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    800046a0:	00007797          	auipc	a5,0x7
    800046a4:	3f07b783          	ld	a5,1008(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    800046a8:	0007b783          	ld	a5,0(a5)
    800046ac:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800046b0:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    800046b4:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800046b8:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    800046bc:	fffff097          	auipc	ra,0xfffff
    800046c0:	530080e7          	jalr	1328(ra) # 80003bec <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    800046c4:	05813083          	ld	ra,88(sp)
    800046c8:	05013403          	ld	s0,80(sp)
    800046cc:	06010113          	addi	sp,sp,96
    800046d0:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    800046d4:	fffff097          	auipc	ra,0xfffff
    800046d8:	680080e7          	jalr	1664(ra) # 80003d54 <_ZN5RiscV21executeMemFreeSyscallEv>
    800046dc:	fc5ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    800046e0:	fffff097          	auipc	ra,0xfffff
    800046e4:	6c4080e7          	jalr	1732(ra) # 80003da4 <_ZN5RiscV26executeThreadCreateSyscallEv>
    800046e8:	fb9ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    800046ec:	00000097          	auipc	ra,0x0
    800046f0:	8a4080e7          	jalr	-1884(ra) # 80003f90 <_ZN5RiscV24executeThreadExitSyscallEv>
    800046f4:	fadff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    800046f8:	fffff097          	auipc	ra,0xfffff
    800046fc:	3e0080e7          	jalr	992(ra) # 80003ad8 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004700:	fa1ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004704:	fffff097          	auipc	ra,0xfffff
    80004708:	770080e7          	jalr	1904(ra) # 80003e74 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    8000470c:	f95ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004710:	00000097          	auipc	ra,0x0
    80004714:	828080e7          	jalr	-2008(ra) # 80003f38 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004718:	f89ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    8000471c:	00000097          	auipc	ra,0x0
    80004720:	8cc080e7          	jalr	-1844(ra) # 80003fe8 <_ZN5RiscV21executeSemOpenSyscallEv>
    80004724:	f7dff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80004728:	00000097          	auipc	ra,0x0
    8000472c:	958080e7          	jalr	-1704(ra) # 80004080 <_ZN5RiscV22executeSemCloseSyscallEv>
    80004730:	f71ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80004734:	00000097          	auipc	ra,0x0
    80004738:	9ac080e7          	jalr	-1620(ra) # 800040e0 <_ZN5RiscV21executeSemWaitSyscallEv>
    8000473c:	f65ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80004740:	00000097          	auipc	ra,0x0
    80004744:	a00080e7          	jalr	-1536(ra) # 80004140 <_ZN5RiscV23executeSemSignalSyscallEv>
    80004748:	f59ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    8000474c:	00000097          	auipc	ra,0x0
    80004750:	a3c080e7          	jalr	-1476(ra) # 80004188 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004754:	f4dff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80004758:	00000097          	auipc	ra,0x0
    8000475c:	aa8080e7          	jalr	-1368(ra) # 80004200 <_ZN5RiscV18executeGetcSyscallEv>
    80004760:	f41ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80004764:	fffff097          	auipc	ra,0xfffff
    80004768:	3b0080e7          	jalr	944(ra) # 80003b14 <_ZN5RiscV18executePutcSyscallEv>
    8000476c:	f35ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80004770:	00000097          	auipc	ra,0x0
    80004774:	b28080e7          	jalr	-1240(ra) # 80004298 <_ZN5RiscV22executePutcUtilSyscallEv>
    80004778:	f29ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    8000477c:	00000097          	auipc	ra,0x0
    80004780:	b50080e7          	jalr	-1200(ra) # 800042cc <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004784:	f1dff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004788:	00000097          	auipc	ra,0x0
    8000478c:	bb8080e7          	jalr	-1096(ra) # 80004340 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004790:	f11ff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004794:	00010793          	mv	a5,sp
    80004798:	00007717          	auipc	a4,0x7
    8000479c:	2b073703          	ld	a4,688(a4) # 8000ba48 <_GLOBAL_OFFSET_TABLE_+0x48>
    800047a0:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    800047a4:	00000097          	auipc	ra,0x0
    800047a8:	d48080e7          	jalr	-696(ra) # 800044ec <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    800047ac:	00000097          	auipc	ra,0x0
    800047b0:	bf0080e7          	jalr	-1040(ra) # 8000439c <_ZN5RiscV18executeForkSyscallEv>
                        break;
    800047b4:	eedff06f          	j	800046a0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800047b8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800047bc:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800047c0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800047c4:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    800047c8:	00200793          	li	a5,2
    800047cc:	1447b073          	csrc	sip,a5
        globalTime += 1;
    800047d0:	00007717          	auipc	a4,0x7
    800047d4:	4f070713          	addi	a4,a4,1264 # 8000bcc0 <_ZN5RiscV16userMainFinishedE>
    800047d8:	00873783          	ld	a5,8(a4)
    800047dc:	00178793          	addi	a5,a5,1
    800047e0:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    800047e4:	00000097          	auipc	ra,0x0
    800047e8:	2e0080e7          	jalr	736(ra) # 80004ac4 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    800047ec:	00007717          	auipc	a4,0x7
    800047f0:	23c73703          	ld	a4,572(a4) # 8000ba28 <_GLOBAL_OFFSET_TABLE_+0x28>
    800047f4:	00073783          	ld	a5,0(a4)
    800047f8:	00178793          	addi	a5,a5,1
    800047fc:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004800:	00007717          	auipc	a4,0x7
    80004804:	29073703          	ld	a4,656(a4) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004808:	00073703          	ld	a4,0(a4)
    8000480c:	03073683          	ld	a3,48(a4)
    80004810:	00d7fc63          	bgeu	a5,a3,80004828 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004814:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004818:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    8000481c:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004820:	14179073          	csrw	sepc,a5
}
    80004824:	e99ff06f          	j	800046bc <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80004828:	00007797          	auipc	a5,0x7
    8000482c:	2007b783          	ld	a5,512(a5) # 8000ba28 <_GLOBAL_OFFSET_TABLE_+0x28>
    80004830:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004834:	00100793          	li	a5,1
    80004838:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    8000483c:	ffffe097          	auipc	ra,0xffffe
    80004840:	6a4080e7          	jalr	1700(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
    80004844:	fd1ff06f          	j	80004814 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004848:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000484c:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004850:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004854:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80004858:	00007797          	auipc	a5,0x7
    8000485c:	1b87b783          	ld	a5,440(a5) # 8000ba10 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004860:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004864:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004868:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    8000486c:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004870:	0017f793          	andi	a5,a5,1
    80004874:	02078863          	beqz	a5,800048a4 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80004878:	00007797          	auipc	a5,0x7
    8000487c:	1c07b783          	ld	a5,448(a5) # 8000ba38 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004880:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004884:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004888:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    8000488c:	00058513          	mv	a0,a1
    80004890:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004894:	00007797          	auipc	a5,0x7
    80004898:	1ac7b783          	ld	a5,428(a5) # 8000ba40 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000489c:	0007b783          	ld	a5,0(a5)
    800048a0:	02079463          	bnez	a5,800048c8 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    800048a4:	00002097          	auipc	ra,0x2
    800048a8:	010080e7          	jalr	16(ra) # 800068b4 <plic_claim>
    800048ac:	00002097          	auipc	ra,0x2
    800048b0:	040080e7          	jalr	64(ra) # 800068ec <plic_complete>
        RiscV::w_sstatus(sstatus);
    800048b4:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800048b8:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800048bc:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800048c0:	14179073          	csrw	sepc,a5
}
    800048c4:	df9ff06f          	j	800046bc <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    800048c8:	fff78793          	addi	a5,a5,-1
    800048cc:	00007717          	auipc	a4,0x7
    800048d0:	17473703          	ld	a4,372(a4) # 8000ba40 <_GLOBAL_OFFSET_TABLE_+0x40>
    800048d4:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800048d8:	00000097          	auipc	ra,0x0
    800048dc:	3c4080e7          	jalr	964(ra) # 80004c9c <_ZN11ConsoleUtil8putInputEc>
    800048e0:	fc5ff06f          	j	800048a4 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    800048e4:	00007797          	auipc	a5,0x7
    800048e8:	1ac7b783          	ld	a5,428(a5) # 8000ba90 <_GLOBAL_OFFSET_TABLE_+0x90>
    800048ec:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800048f0:	00200713          	li	a4,2
    800048f4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800048f8:	00005517          	auipc	a0,0x5
    800048fc:	a5850513          	addi	a0,a0,-1448 # 80009350 <CONSOLE_STATUS+0x340>
    80004900:	00000097          	auipc	ra,0x0
    80004904:	574080e7          	jalr	1396(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004908:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    8000490c:	00000613          	li	a2,0
    80004910:	01000593          	li	a1,16
    80004914:	0005051b          	sext.w	a0,a0
    80004918:	00000097          	auipc	ra,0x0
    8000491c:	5a0080e7          	jalr	1440(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004920:	00005517          	auipc	a0,0x5
    80004924:	a2850513          	addi	a0,a0,-1496 # 80009348 <CONSOLE_STATUS+0x338>
    80004928:	00000097          	auipc	ra,0x0
    8000492c:	54c080e7          	jalr	1356(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004930:	00005517          	auipc	a0,0x5
    80004934:	a2850513          	addi	a0,a0,-1496 # 80009358 <CONSOLE_STATUS+0x348>
    80004938:	00000097          	auipc	ra,0x0
    8000493c:	53c080e7          	jalr	1340(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004940:	ffffe097          	auipc	ra,0xffffe
    80004944:	5a0080e7          	jalr	1440(ra) # 80002ee0 <_ZN3TCB8dispatchEv>
    80004948:	d75ff06f          	j	800046bc <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

000000008000494c <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    8000494c:	ff010113          	addi	sp,sp,-16
    80004950:	00813423          	sd	s0,8(sp)
    80004954:	01010413          	addi	s0,sp,16
    80004958:	00050793          	mv	a5,a0
    8000495c:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004960:	0007c703          	lbu	a4,0(a5)
    80004964:	00070a63          	beqz	a4,80004978 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004968:	00178793          	addi	a5,a5,1
    8000496c:	00e50023          	sb	a4,0(a0)
    80004970:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004974:	fedff06f          	j	80004960 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004978:	00e50023          	sb	a4,0(a0)
    return dst;
}
    8000497c:	00813403          	ld	s0,8(sp)
    80004980:	01010113          	addi	sp,sp,16
    80004984:	00008067          	ret

0000000080004988 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004988:	fe010113          	addi	sp,sp,-32
    8000498c:	00113c23          	sd	ra,24(sp)
    80004990:	00813823          	sd	s0,16(sp)
    80004994:	00913423          	sd	s1,8(sp)
    80004998:	02010413          	addi	s0,sp,32
    8000499c:	00050493          	mv	s1,a0
    800049a0:	00058513          	mv	a0,a1
    char *dest = dst;
    800049a4:	00048593          	mv	a1,s1
    while(*dest != '\0')
    800049a8:	0005c783          	lbu	a5,0(a1)
    800049ac:	00078663          	beqz	a5,800049b8 <_Z6strcatPcPKc+0x30>
        dest++;
    800049b0:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    800049b4:	ff5ff06f          	j	800049a8 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    800049b8:	00000097          	auipc	ra,0x0
    800049bc:	f94080e7          	jalr	-108(ra) # 8000494c <_Z6strcpyPKcPc>
    return dst;
}
    800049c0:	00048513          	mv	a0,s1
    800049c4:	01813083          	ld	ra,24(sp)
    800049c8:	01013403          	ld	s0,16(sp)
    800049cc:	00813483          	ld	s1,8(sp)
    800049d0:	02010113          	addi	sp,sp,32
    800049d4:	00008067          	ret

00000000800049d8 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    800049d8:	ff010113          	addi	sp,sp,-16
    800049dc:	00813423          	sd	s0,8(sp)
    800049e0:	01010413          	addi	s0,sp,16
}
    800049e4:	00813403          	ld	s0,8(sp)
    800049e8:	01010113          	addi	sp,sp,16
    800049ec:	00008067          	ret

00000000800049f0 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800049f0:	ff010113          	addi	sp,sp,-16
    800049f4:	00813423          	sd	s0,8(sp)
    800049f8:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    800049fc:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004a00:	00007797          	auipc	a5,0x7
    80004a04:	2d07b783          	ld	a5,720(a5) # 8000bcd0 <_ZN9Scheduler9readyHeadE>
    80004a08:	02078263          	beqz	a5,80004a2c <_ZN9Scheduler3putEP3TCB+0x3c>
    80004a0c:	00007797          	auipc	a5,0x7
    80004a10:	2cc7b783          	ld	a5,716(a5) # 8000bcd8 <_ZN9Scheduler9readyTailE>
    80004a14:	04a7b423          	sd	a0,72(a5)
    80004a18:	00007797          	auipc	a5,0x7
    80004a1c:	2ca7b023          	sd	a0,704(a5) # 8000bcd8 <_ZN9Scheduler9readyTailE>
}
    80004a20:	00813403          	ld	s0,8(sp)
    80004a24:	01010113          	addi	sp,sp,16
    80004a28:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004a2c:	00007797          	auipc	a5,0x7
    80004a30:	2aa7b223          	sd	a0,676(a5) # 8000bcd0 <_ZN9Scheduler9readyHeadE>
    80004a34:	fe5ff06f          	j	80004a18 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004a38 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004a38:	ff010113          	addi	sp,sp,-16
    80004a3c:	00813423          	sd	s0,8(sp)
    80004a40:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004a44:	00007517          	auipc	a0,0x7
    80004a48:	28c53503          	ld	a0,652(a0) # 8000bcd0 <_ZN9Scheduler9readyHeadE>
    80004a4c:	00050a63          	beqz	a0,80004a60 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004a50:	04853783          	ld	a5,72(a0)
    80004a54:	00007717          	auipc	a4,0x7
    80004a58:	26f73e23          	sd	a5,636(a4) # 8000bcd0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004a5c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004a60:	00813403          	ld	s0,8(sp)
    80004a64:	01010113          	addi	sp,sp,16
    80004a68:	00008067          	ret

0000000080004a6c <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004a6c:	ff010113          	addi	sp,sp,-16
    80004a70:	00813423          	sd	s0,8(sp)
    80004a74:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004a78:	00007797          	auipc	a5,0x7
    80004a7c:	2687b783          	ld	a5,616(a5) # 8000bce0 <_ZN9Scheduler12sleepingHeadE>
    80004a80:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a84:	00078e63          	beqz	a5,80004aa0 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004a88:	0587b683          	ld	a3,88(a5)
    80004a8c:	05853703          	ld	a4,88(a0)
    80004a90:	00d76863          	bltu	a4,a3,80004aa0 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a94:	00078613          	mv	a2,a5
    80004a98:	0487b783          	ld	a5,72(a5)
    80004a9c:	fe9ff06f          	j	80004a84 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004aa0:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004aa4:	00060a63          	beqz	a2,80004ab8 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004aa8:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004aac:	00813403          	ld	s0,8(sp)
    80004ab0:	01010113          	addi	sp,sp,16
    80004ab4:	00008067          	ret
        sleepingHead = t;
    80004ab8:	00007797          	auipc	a5,0x7
    80004abc:	22a7b423          	sd	a0,552(a5) # 8000bce0 <_ZN9Scheduler12sleepingHeadE>
}
    80004ac0:	fedff06f          	j	80004aac <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004ac4 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004ac4:	fe010113          	addi	sp,sp,-32
    80004ac8:	00113c23          	sd	ra,24(sp)
    80004acc:	00813823          	sd	s0,16(sp)
    80004ad0:	00913423          	sd	s1,8(sp)
    80004ad4:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004ad8:	00007497          	auipc	s1,0x7
    80004adc:	2084b483          	ld	s1,520(s1) # 8000bce0 <_ZN9Scheduler12sleepingHeadE>
    80004ae0:	02048c63          	beqz	s1,80004b18 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004ae4:	0584b703          	ld	a4,88(s1)
    80004ae8:	00007797          	auipc	a5,0x7
    80004aec:	fc07b783          	ld	a5,-64(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004af0:	0007b783          	ld	a5,0(a5)
    80004af4:	02e7e263          	bltu	a5,a4,80004b18 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004af8:	0484b783          	ld	a5,72(s1)
    80004afc:	00007717          	auipc	a4,0x7
    80004b00:	1ef73223          	sd	a5,484(a4) # 8000bce0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004b04:	00048513          	mv	a0,s1
    80004b08:	00000097          	auipc	ra,0x0
    80004b0c:	ee8080e7          	jalr	-280(ra) # 800049f0 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004b10:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004b14:	fc5ff06f          	j	80004ad8 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004b18:	01813083          	ld	ra,24(sp)
    80004b1c:	01013403          	ld	s0,16(sp)
    80004b20:	00813483          	ld	s1,8(sp)
    80004b24:	02010113          	addi	sp,sp,32
    80004b28:	00008067          	ret

0000000080004b2c <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004b2c:	fe010113          	addi	sp,sp,-32
    80004b30:	00113c23          	sd	ra,24(sp)
    80004b34:	00813823          	sd	s0,16(sp)
    80004b38:	00913423          	sd	s1,8(sp)
    80004b3c:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004b40:	00007497          	auipc	s1,0x7
    80004b44:	1904b483          	ld	s1,400(s1) # 8000bcd0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004b48:	02048863          	beqz	s1,80004b78 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004b4c:	00000613          	li	a2,0
    80004b50:	01000593          	li	a1,16
    80004b54:	0004851b          	sext.w	a0,s1
    80004b58:	00000097          	auipc	ra,0x0
    80004b5c:	360080e7          	jalr	864(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004b60:	00004517          	auipc	a0,0x4
    80004b64:	7e850513          	addi	a0,a0,2024 # 80009348 <CONSOLE_STATUS+0x338>
    80004b68:	00000097          	auipc	ra,0x0
    80004b6c:	30c080e7          	jalr	780(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004b70:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004b74:	fd5ff06f          	j	80004b48 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004b78:	01813083          	ld	ra,24(sp)
    80004b7c:	01013403          	ld	s0,16(sp)
    80004b80:	00813483          	ld	s1,8(sp)
    80004b84:	02010113          	addi	sp,sp,32
    80004b88:	00008067          	ret

0000000080004b8c <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004b8c:	fe010113          	addi	sp,sp,-32
    80004b90:	00113c23          	sd	ra,24(sp)
    80004b94:	00813823          	sd	s0,16(sp)
    80004b98:	00913423          	sd	s1,8(sp)
    80004b9c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004ba0:	00007497          	auipc	s1,0x7
    80004ba4:	1404b483          	ld	s1,320(s1) # 8000bce0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004ba8:	02048863          	beqz	s1,80004bd8 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004bac:	00000613          	li	a2,0
    80004bb0:	01000593          	li	a1,16
    80004bb4:	0004851b          	sext.w	a0,s1
    80004bb8:	ffffe097          	auipc	ra,0xffffe
    80004bbc:	e9c080e7          	jalr	-356(ra) # 80002a54 <_Z8printIntiii>
        printString("\n");
    80004bc0:	00004517          	auipc	a0,0x4
    80004bc4:	78850513          	addi	a0,a0,1928 # 80009348 <CONSOLE_STATUS+0x338>
    80004bc8:	ffffe097          	auipc	ra,0xffffe
    80004bcc:	cf4080e7          	jalr	-780(ra) # 800028bc <_Z11printStringPKc>
        iter = iter->next;
    80004bd0:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004bd4:	fd5ff06f          	j	80004ba8 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004bd8:	01813083          	ld	ra,24(sp)
    80004bdc:	01013403          	ld	s0,16(sp)
    80004be0:	00813483          	ld	s1,8(sp)
    80004be4:	02010113          	addi	sp,sp,32
    80004be8:	00008067          	ret

0000000080004bec <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    80004bec:	fe010113          	addi	sp,sp,-32
    80004bf0:	00113c23          	sd	ra,24(sp)
    80004bf4:	00813823          	sd	s0,16(sp)
    80004bf8:	00913423          	sd	s1,8(sp)
    80004bfc:	01213023          	sd	s2,0(sp)
    80004c00:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004c04:	01800513          	li	a0,24
    80004c08:	ffffe097          	auipc	ra,0xffffe
    80004c0c:	11c080e7          	jalr	284(ra) # 80002d24 <_ZN3SCBnwEm>
    80004c10:	00050493          	mv	s1,a0
    80004c14:	00000593          	li	a1,0
    80004c18:	ffffe097          	auipc	ra,0xffffe
    80004c1c:	f50080e7          	jalr	-176(ra) # 80002b68 <_ZN3SCBC1Em>
    80004c20:	00007797          	auipc	a5,0x7
    80004c24:	0c97b423          	sd	s1,200(a5) # 8000bce8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004c28:	01800513          	li	a0,24
    80004c2c:	ffffe097          	auipc	ra,0xffffe
    80004c30:	0f8080e7          	jalr	248(ra) # 80002d24 <_ZN3SCBnwEm>
    80004c34:	00050493          	mv	s1,a0
    80004c38:	00000593          	li	a1,0
    80004c3c:	ffffe097          	auipc	ra,0xffffe
    80004c40:	f2c080e7          	jalr	-212(ra) # 80002b68 <_ZN3SCBC1Em>
    80004c44:	00007797          	auipc	a5,0x7
    80004c48:	0a97b623          	sd	s1,172(a5) # 8000bcf0 <_ZN11ConsoleUtil9outputSemE>
}
    80004c4c:	01813083          	ld	ra,24(sp)
    80004c50:	01013403          	ld	s0,16(sp)
    80004c54:	00813483          	ld	s1,8(sp)
    80004c58:	00013903          	ld	s2,0(sp)
    80004c5c:	02010113          	addi	sp,sp,32
    80004c60:	00008067          	ret
    80004c64:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004c68:	00048513          	mv	a0,s1
    80004c6c:	ffffe097          	auipc	ra,0xffffe
    80004c70:	0e0080e7          	jalr	224(ra) # 80002d4c <_ZN3SCBdlEPv>
    80004c74:	00090513          	mv	a0,s2
    80004c78:	0000c097          	auipc	ra,0xc
    80004c7c:	190080e7          	jalr	400(ra) # 80010e08 <_Unwind_Resume>
    80004c80:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004c84:	00048513          	mv	a0,s1
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	0c4080e7          	jalr	196(ra) # 80002d4c <_ZN3SCBdlEPv>
    80004c90:	00090513          	mv	a0,s2
    80004c94:	0000c097          	auipc	ra,0xc
    80004c98:	174080e7          	jalr	372(ra) # 80010e08 <_Unwind_Resume>

0000000080004c9c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004c9c:	00007697          	auipc	a3,0x7
    80004ca0:	04c68693          	addi	a3,a3,76 # 8000bce8 <_ZN11ConsoleUtil8inputSemE>
    80004ca4:	0106b603          	ld	a2,16(a3)
    80004ca8:	00160793          	addi	a5,a2,1
    80004cac:	00002737          	lui	a4,0x2
    80004cb0:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004cb4:	00e7f7b3          	and	a5,a5,a4
    80004cb8:	0186b703          	ld	a4,24(a3)
    80004cbc:	04e78263          	beq	a5,a4,80004d00 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80004cc0:	ff010113          	addi	sp,sp,-16
    80004cc4:	00113423          	sd	ra,8(sp)
    80004cc8:	00813023          	sd	s0,0(sp)
    80004ccc:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004cd0:	00009717          	auipc	a4,0x9
    80004cd4:	05070713          	addi	a4,a4,80 # 8000dd20 <_ZN11ConsoleUtil11inputBufferE>
    80004cd8:	00c70633          	add	a2,a4,a2
    80004cdc:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80004ce0:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    80004ce4:	0006b503          	ld	a0,0(a3)
    80004ce8:	ffffe097          	auipc	ra,0xffffe
    80004cec:	000080e7          	jalr	ra # 80002ce8 <_ZN3SCB6signalEv>
}
    80004cf0:	00813083          	ld	ra,8(sp)
    80004cf4:	00013403          	ld	s0,0(sp)
    80004cf8:	01010113          	addi	sp,sp,16
    80004cfc:	00008067          	ret
    80004d00:	00008067          	ret

0000000080004d04 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004d04:	fe010113          	addi	sp,sp,-32
    80004d08:	00113c23          	sd	ra,24(sp)
    80004d0c:	00813823          	sd	s0,16(sp)
    80004d10:	00913423          	sd	s1,8(sp)
    80004d14:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004d18:	00007497          	auipc	s1,0x7
    80004d1c:	fd048493          	addi	s1,s1,-48 # 8000bce8 <_ZN11ConsoleUtil8inputSemE>
    80004d20:	0004b503          	ld	a0,0(s1)
    80004d24:	ffffe097          	auipc	ra,0xffffe
    80004d28:	f74080e7          	jalr	-140(ra) # 80002c98 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004d2c:	0184b783          	ld	a5,24(s1)
    80004d30:	0104b703          	ld	a4,16(s1)
    80004d34:	04e78063          	beq	a5,a4,80004d74 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004d38:	00009717          	auipc	a4,0x9
    80004d3c:	fe870713          	addi	a4,a4,-24 # 8000dd20 <_ZN11ConsoleUtil11inputBufferE>
    80004d40:	00f70733          	add	a4,a4,a5
    80004d44:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004d48:	00178793          	addi	a5,a5,1
    80004d4c:	00002737          	lui	a4,0x2
    80004d50:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004d54:	00e7f7b3          	and	a5,a5,a4
    80004d58:	00007717          	auipc	a4,0x7
    80004d5c:	faf73423          	sd	a5,-88(a4) # 8000bd00 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004d60:	01813083          	ld	ra,24(sp)
    80004d64:	01013403          	ld	s0,16(sp)
    80004d68:	00813483          	ld	s1,8(sp)
    80004d6c:	02010113          	addi	sp,sp,32
    80004d70:	00008067          	ret
        return -1;
    80004d74:	0ff00513          	li	a0,255
    80004d78:	fe9ff06f          	j	80004d60 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004d7c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004d7c:	00007797          	auipc	a5,0x7
    80004d80:	f6c78793          	addi	a5,a5,-148 # 8000bce8 <_ZN11ConsoleUtil8inputSemE>
    80004d84:	0207b603          	ld	a2,32(a5)
    80004d88:	00160713          	addi	a4,a2,1
    80004d8c:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004d90:	0287b583          	ld	a1,40(a5)
    80004d94:	00158713          	addi	a4,a1,1
    80004d98:	000026b7          	lui	a3,0x2
    80004d9c:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004da0:	00d77733          	and	a4,a4,a3
    80004da4:	0307b783          	ld	a5,48(a5)
    80004da8:	04f70863          	beq	a4,a5,80004df8 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80004dac:	ff010113          	addi	sp,sp,-16
    80004db0:	00113423          	sd	ra,8(sp)
    80004db4:	00813023          	sd	s0,0(sp)
    80004db8:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004dbc:	00007797          	auipc	a5,0x7
    80004dc0:	f6478793          	addi	a5,a5,-156 # 8000bd20 <_ZN11ConsoleUtil12outputBufferE>
    80004dc4:	00b785b3          	add	a1,a5,a1
    80004dc8:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    80004dcc:	00007797          	auipc	a5,0x7
    80004dd0:	f1c78793          	addi	a5,a5,-228 # 8000bce8 <_ZN11ConsoleUtil8inputSemE>
    80004dd4:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004dd8:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    80004ddc:	0087b503          	ld	a0,8(a5)
    80004de0:	ffffe097          	auipc	ra,0xffffe
    80004de4:	f08080e7          	jalr	-248(ra) # 80002ce8 <_ZN3SCB6signalEv>
}
    80004de8:	00813083          	ld	ra,8(sp)
    80004dec:	00013403          	ld	s0,0(sp)
    80004df0:	01010113          	addi	sp,sp,16
    80004df4:	00008067          	ret
    80004df8:	00008067          	ret

0000000080004dfc <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004dfc:	fe010113          	addi	sp,sp,-32
    80004e00:	00113c23          	sd	ra,24(sp)
    80004e04:	00813823          	sd	s0,16(sp)
    80004e08:	00913423          	sd	s1,8(sp)
    80004e0c:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004e10:	00007497          	auipc	s1,0x7
    80004e14:	ed848493          	addi	s1,s1,-296 # 8000bce8 <_ZN11ConsoleUtil8inputSemE>
    80004e18:	0084b503          	ld	a0,8(s1)
    80004e1c:	ffffe097          	auipc	ra,0xffffe
    80004e20:	e7c080e7          	jalr	-388(ra) # 80002c98 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004e24:	0304b783          	ld	a5,48(s1)
    80004e28:	0284b703          	ld	a4,40(s1)
    80004e2c:	04e78063          	beq	a5,a4,80004e6c <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004e30:	00007717          	auipc	a4,0x7
    80004e34:	ef070713          	addi	a4,a4,-272 # 8000bd20 <_ZN11ConsoleUtil12outputBufferE>
    80004e38:	00f70733          	add	a4,a4,a5
    80004e3c:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004e40:	00178793          	addi	a5,a5,1
    80004e44:	00002737          	lui	a4,0x2
    80004e48:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004e4c:	00e7f7b3          	and	a5,a5,a4
    80004e50:	00007717          	auipc	a4,0x7
    80004e54:	ecf73423          	sd	a5,-312(a4) # 8000bd18 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004e58:	01813083          	ld	ra,24(sp)
    80004e5c:	01013403          	ld	s0,16(sp)
    80004e60:	00813483          	ld	s1,8(sp)
    80004e64:	02010113          	addi	sp,sp,32
    80004e68:	00008067          	ret
        return -1;
    80004e6c:	0ff00513          	li	a0,255
    80004e70:	fe9ff06f          	j	80004e58 <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004e74 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004e74:	fe010113          	addi	sp,sp,-32
    80004e78:	00113c23          	sd	ra,24(sp)
    80004e7c:	00813823          	sd	s0,16(sp)
    80004e80:	00913423          	sd	s1,8(sp)
    80004e84:	02010413          	addi	s0,sp,32
    80004e88:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004e8c:	0004c503          	lbu	a0,0(s1)
    80004e90:	00050a63          	beqz	a0,80004ea4 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004e94:	00000097          	auipc	ra,0x0
    80004e98:	ee8080e7          	jalr	-280(ra) # 80004d7c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004e9c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004ea0:	fedff06f          	j	80004e8c <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004ea4:	01813083          	ld	ra,24(sp)
    80004ea8:	01013403          	ld	s0,16(sp)
    80004eac:	00813483          	ld	s1,8(sp)
    80004eb0:	02010113          	addi	sp,sp,32
    80004eb4:	00008067          	ret

0000000080004eb8 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004eb8:	fb010113          	addi	sp,sp,-80
    80004ebc:	04113423          	sd	ra,72(sp)
    80004ec0:	04813023          	sd	s0,64(sp)
    80004ec4:	02913c23          	sd	s1,56(sp)
    80004ec8:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004ecc:	00004797          	auipc	a5,0x4
    80004ed0:	67478793          	addi	a5,a5,1652 # 80009540 <CONSOLE_STATUS+0x530>
    80004ed4:	0007b703          	ld	a4,0(a5)
    80004ed8:	fce43423          	sd	a4,-56(s0)
    80004edc:	0087b703          	ld	a4,8(a5)
    80004ee0:	fce43823          	sd	a4,-48(s0)
    80004ee4:	0107c783          	lbu	a5,16(a5)
    80004ee8:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004eec:	00060463          	beqz	a2,80004ef4 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004ef0:	08054263          	bltz	a0,80004f74 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004ef4:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004ef8:	00000813          	li	a6,0
    }

    i = 0;
    80004efc:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004f00:	0005871b          	sext.w	a4,a1
    80004f04:	02b577bb          	remuw	a5,a0,a1
    80004f08:	00048693          	mv	a3,s1
    80004f0c:	0014849b          	addiw	s1,s1,1
    80004f10:	02079793          	slli	a5,a5,0x20
    80004f14:	0207d793          	srli	a5,a5,0x20
    80004f18:	fe040613          	addi	a2,s0,-32
    80004f1c:	00f607b3          	add	a5,a2,a5
    80004f20:	fe87c603          	lbu	a2,-24(a5)
    80004f24:	fe040793          	addi	a5,s0,-32
    80004f28:	00d787b3          	add	a5,a5,a3
    80004f2c:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004f30:	0005061b          	sext.w	a2,a0
    80004f34:	02b5553b          	divuw	a0,a0,a1
    80004f38:	fce674e3          	bgeu	a2,a4,80004f00 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004f3c:	00080c63          	beqz	a6,80004f54 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004f40:	fe040793          	addi	a5,s0,-32
    80004f44:	009784b3          	add	s1,a5,s1
    80004f48:	02d00793          	li	a5,45
    80004f4c:	fcf48c23          	sb	a5,-40(s1)
    80004f50:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004f54:	fff4849b          	addiw	s1,s1,-1
    80004f58:	0204c463          	bltz	s1,80004f80 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004f5c:	fe040793          	addi	a5,s0,-32
    80004f60:	009787b3          	add	a5,a5,s1
    80004f64:	fd87c503          	lbu	a0,-40(a5)
    80004f68:	00000097          	auipc	ra,0x0
    80004f6c:	e14080e7          	jalr	-492(ra) # 80004d7c <_ZN11ConsoleUtil9putOutputEc>
    80004f70:	fe5ff06f          	j	80004f54 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004f74:	40a0053b          	negw	a0,a0
        neg = 1;
    80004f78:	00100813          	li	a6,1
        x = -xx;
    80004f7c:	f81ff06f          	j	80004efc <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004f80:	04813083          	ld	ra,72(sp)
    80004f84:	04013403          	ld	s0,64(sp)
    80004f88:	03813483          	ld	s1,56(sp)
    80004f8c:	05010113          	addi	sp,sp,80
    80004f90:	00008067          	ret

0000000080004f94 <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    80004f94:	fe010113          	addi	sp,sp,-32
    80004f98:	00113c23          	sd	ra,24(sp)
    80004f9c:	00813823          	sd	s0,16(sp)
    80004fa0:	00913423          	sd	s1,8(sp)
    80004fa4:	01213023          	sd	s2,0(sp)
    80004fa8:	02010413          	addi	s0,sp,32
    80004fac:	00058913          	mv	s2,a1
    80004fb0:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    80004fb4:	00000097          	auipc	ra,0x0
    80004fb8:	ec0080e7          	jalr	-320(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    80004fbc:	00000613          	li	a2,0
    80004fc0:	00a00593          	li	a1,10
    80004fc4:	00090513          	mv	a0,s2
    80004fc8:	00000097          	auipc	ra,0x0
    80004fcc:	ef0080e7          	jalr	-272(ra) # 80004eb8 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004fd0:	00048513          	mv	a0,s1
    80004fd4:	00000097          	auipc	ra,0x0
    80004fd8:	ea0080e7          	jalr	-352(ra) # 80004e74 <_ZN11ConsoleUtil11printStringEPKc>
}
    80004fdc:	01813083          	ld	ra,24(sp)
    80004fe0:	01013403          	ld	s0,16(sp)
    80004fe4:	00813483          	ld	s1,8(sp)
    80004fe8:	00013903          	ld	s2,0(sp)
    80004fec:	02010113          	addi	sp,sp,32
    80004ff0:	00008067          	ret

0000000080004ff4 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004ff4:	ff010113          	addi	sp,sp,-16
    80004ff8:	00813423          	sd	s0,8(sp)
    80004ffc:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80005000:	04300513          	li	a0,67

    asm("ecall");
    80005004:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80005008:	00050513          	mv	a0,a0

    return (char)status;
}
    8000500c:	0ff57513          	andi	a0,a0,255
    80005010:	00813403          	ld	s0,8(sp)
    80005014:	01010113          	addi	sp,sp,16
    80005018:	00008067          	ret

000000008000501c <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    8000501c:	ff010113          	addi	sp,sp,-16
    80005020:	00113423          	sd	ra,8(sp)
    80005024:	00813023          	sd	s0,0(sp)
    80005028:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    8000502c:	ffffd097          	auipc	ra,0xffffd
    80005030:	9b0080e7          	jalr	-1616(ra) # 800019dc <_ZN13SlabAllocator10initializeEPvm>
}
    80005034:	00813083          	ld	ra,8(sp)
    80005038:	00013403          	ld	s0,0(sp)
    8000503c:	01010113          	addi	sp,sp,16
    80005040:	00008067          	ret

0000000080005044 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005044:	ff010113          	addi	sp,sp,-16
    80005048:	00113423          	sd	ra,8(sp)
    8000504c:	00813023          	sd	s0,0(sp)
    80005050:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005054:	ffffd097          	auipc	ra,0xffffd
    80005058:	8e8080e7          	jalr	-1816(ra) # 8000193c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    8000505c:	00813083          	ld	ra,8(sp)
    80005060:	00013403          	ld	s0,0(sp)
    80005064:	01010113          	addi	sp,sp,16
    80005068:	00008067          	ret

000000008000506c <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    8000506c:	ff010113          	addi	sp,sp,-16
    80005070:	00113423          	sd	ra,8(sp)
    80005074:	00813023          	sd	s0,0(sp)
    80005078:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    8000507c:	ffffc097          	auipc	ra,0xffffc
    80005080:	780080e7          	jalr	1920(ra) # 800017fc <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80005084:	00813083          	ld	ra,8(sp)
    80005088:	00013403          	ld	s0,0(sp)
    8000508c:	01010113          	addi	sp,sp,16
    80005090:	00008067          	ret

0000000080005094 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80005094:	ff010113          	addi	sp,sp,-16
    80005098:	00113423          	sd	ra,8(sp)
    8000509c:	00813023          	sd	s0,0(sp)
    800050a0:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    800050a4:	ffffd097          	auipc	ra,0xffffd
    800050a8:	b10080e7          	jalr	-1264(ra) # 80001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    800050ac:	00813083          	ld	ra,8(sp)
    800050b0:	00013403          	ld	s0,0(sp)
    800050b4:	01010113          	addi	sp,sp,16
    800050b8:	00008067          	ret

00000000800050bc <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    800050bc:	fe010113          	addi	sp,sp,-32
    800050c0:	00113c23          	sd	ra,24(sp)
    800050c4:	00813823          	sd	s0,16(sp)
    800050c8:	02010413          	addi	s0,sp,32
    800050cc:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    800050d0:	fe840513          	addi	a0,s0,-24
    800050d4:	ffffd097          	auipc	ra,0xffffd
    800050d8:	c40080e7          	jalr	-960(ra) # 80001d14 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    800050dc:	01813083          	ld	ra,24(sp)
    800050e0:	01013403          	ld	s0,16(sp)
    800050e4:	02010113          	addi	sp,sp,32
    800050e8:	00008067          	ret

00000000800050ec <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    800050ec:	ff010113          	addi	sp,sp,-16
    800050f0:	00113423          	sd	ra,8(sp)
    800050f4:	00813023          	sd	s0,0(sp)
    800050f8:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    800050fc:	ffffc097          	auipc	ra,0xffffc
    80005100:	204080e7          	jalr	516(ra) # 80001300 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80005104:	00813083          	ld	ra,8(sp)
    80005108:	00013403          	ld	s0,0(sp)
    8000510c:	01010113          	addi	sp,sp,16
    80005110:	00008067          	ret

0000000080005114 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80005114:	ff010113          	addi	sp,sp,-16
    80005118:	00113423          	sd	ra,8(sp)
    8000511c:	00813023          	sd	s0,0(sp)
    80005120:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80005124:	ffffc097          	auipc	ra,0xffffc
    80005128:	030080e7          	jalr	48(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    8000512c:	00813083          	ld	ra,8(sp)
    80005130:	00013403          	ld	s0,0(sp)
    80005134:	01010113          	addi	sp,sp,16
    80005138:	00008067          	ret

000000008000513c <_Z7kmallocm>:
void* kmalloc(size_t size){
    8000513c:	ff010113          	addi	sp,sp,-16
    80005140:	00113423          	sd	ra,8(sp)
    80005144:	00813023          	sd	s0,0(sp)
    80005148:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    8000514c:	ffffc097          	auipc	ra,0xffffc
    80005150:	74c080e7          	jalr	1868(ra) # 80001898 <_ZN13SlabAllocator14allocateBufferEm>
}
    80005154:	00813083          	ld	ra,8(sp)
    80005158:	00013403          	ld	s0,0(sp)
    8000515c:	01010113          	addi	sp,sp,16
    80005160:	00008067          	ret

0000000080005164 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005164:	ff010113          	addi	sp,sp,-16
    80005168:	00113423          	sd	ra,8(sp)
    8000516c:	00813023          	sd	s0,0(sp)
    80005170:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005174:	ffffd097          	auipc	ra,0xffffd
    80005178:	b34080e7          	jalr	-1228(ra) # 80001ca8 <_ZN13SlabAllocator10freeBufferEPKv>
    8000517c:	00813083          	ld	ra,8(sp)
    80005180:	00013403          	ld	s0,0(sp)
    80005184:	01010113          	addi	sp,sp,16
    80005188:	00008067          	ret

000000008000518c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000518c:	fd010113          	addi	sp,sp,-48
    80005190:	02113423          	sd	ra,40(sp)
    80005194:	02813023          	sd	s0,32(sp)
    80005198:	00913c23          	sd	s1,24(sp)
    8000519c:	01213823          	sd	s2,16(sp)
    800051a0:	01313423          	sd	s3,8(sp)
    800051a4:	03010413          	addi	s0,sp,48
    800051a8:	00050493          	mv	s1,a0
    800051ac:	00058913          	mv	s2,a1
    800051b0:	0015879b          	addiw	a5,a1,1
    800051b4:	0007851b          	sext.w	a0,a5
    800051b8:	00f4a023          	sw	a5,0(s1)
    800051bc:	0004a823          	sw	zero,16(s1)
    800051c0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800051c4:	00251513          	slli	a0,a0,0x2
    800051c8:	ffffd097          	auipc	ra,0xffffd
    800051cc:	c28080e7          	jalr	-984(ra) # 80001df0 <_Z9mem_allocm>
    800051d0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800051d4:	01000513          	li	a0,16
    800051d8:	ffffe097          	auipc	ra,0xffffe
    800051dc:	42c080e7          	jalr	1068(ra) # 80003604 <_Znwm>
    800051e0:	00050993          	mv	s3,a0
    800051e4:	00000593          	li	a1,0
    800051e8:	ffffe097          	auipc	ra,0xffffe
    800051ec:	514080e7          	jalr	1300(ra) # 800036fc <_ZN9SemaphoreC1Ej>
    800051f0:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800051f4:	01000513          	li	a0,16
    800051f8:	ffffe097          	auipc	ra,0xffffe
    800051fc:	40c080e7          	jalr	1036(ra) # 80003604 <_Znwm>
    80005200:	00050993          	mv	s3,a0
    80005204:	00090593          	mv	a1,s2
    80005208:	ffffe097          	auipc	ra,0xffffe
    8000520c:	4f4080e7          	jalr	1268(ra) # 800036fc <_ZN9SemaphoreC1Ej>
    80005210:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80005214:	01000513          	li	a0,16
    80005218:	ffffe097          	auipc	ra,0xffffe
    8000521c:	3ec080e7          	jalr	1004(ra) # 80003604 <_Znwm>
    80005220:	00050913          	mv	s2,a0
    80005224:	00100593          	li	a1,1
    80005228:	ffffe097          	auipc	ra,0xffffe
    8000522c:	4d4080e7          	jalr	1236(ra) # 800036fc <_ZN9SemaphoreC1Ej>
    80005230:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005234:	01000513          	li	a0,16
    80005238:	ffffe097          	auipc	ra,0xffffe
    8000523c:	3cc080e7          	jalr	972(ra) # 80003604 <_Znwm>
    80005240:	00050913          	mv	s2,a0
    80005244:	00100593          	li	a1,1
    80005248:	ffffe097          	auipc	ra,0xffffe
    8000524c:	4b4080e7          	jalr	1204(ra) # 800036fc <_ZN9SemaphoreC1Ej>
    80005250:	0324b823          	sd	s2,48(s1)
}
    80005254:	02813083          	ld	ra,40(sp)
    80005258:	02013403          	ld	s0,32(sp)
    8000525c:	01813483          	ld	s1,24(sp)
    80005260:	01013903          	ld	s2,16(sp)
    80005264:	00813983          	ld	s3,8(sp)
    80005268:	03010113          	addi	sp,sp,48
    8000526c:	00008067          	ret
    80005270:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005274:	00098513          	mv	a0,s3
    80005278:	ffffe097          	auipc	ra,0xffffe
    8000527c:	3dc080e7          	jalr	988(ra) # 80003654 <_ZdlPv>
    80005280:	00048513          	mv	a0,s1
    80005284:	0000c097          	auipc	ra,0xc
    80005288:	b84080e7          	jalr	-1148(ra) # 80010e08 <_Unwind_Resume>
    8000528c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005290:	00098513          	mv	a0,s3
    80005294:	ffffe097          	auipc	ra,0xffffe
    80005298:	3c0080e7          	jalr	960(ra) # 80003654 <_ZdlPv>
    8000529c:	00048513          	mv	a0,s1
    800052a0:	0000c097          	auipc	ra,0xc
    800052a4:	b68080e7          	jalr	-1176(ra) # 80010e08 <_Unwind_Resume>
    800052a8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    800052ac:	00090513          	mv	a0,s2
    800052b0:	ffffe097          	auipc	ra,0xffffe
    800052b4:	3a4080e7          	jalr	932(ra) # 80003654 <_ZdlPv>
    800052b8:	00048513          	mv	a0,s1
    800052bc:	0000c097          	auipc	ra,0xc
    800052c0:	b4c080e7          	jalr	-1204(ra) # 80010e08 <_Unwind_Resume>
    800052c4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800052c8:	00090513          	mv	a0,s2
    800052cc:	ffffe097          	auipc	ra,0xffffe
    800052d0:	388080e7          	jalr	904(ra) # 80003654 <_ZdlPv>
    800052d4:	00048513          	mv	a0,s1
    800052d8:	0000c097          	auipc	ra,0xc
    800052dc:	b30080e7          	jalr	-1232(ra) # 80010e08 <_Unwind_Resume>

00000000800052e0 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800052e0:	fe010113          	addi	sp,sp,-32
    800052e4:	00113c23          	sd	ra,24(sp)
    800052e8:	00813823          	sd	s0,16(sp)
    800052ec:	00913423          	sd	s1,8(sp)
    800052f0:	01213023          	sd	s2,0(sp)
    800052f4:	02010413          	addi	s0,sp,32
    800052f8:	00050493          	mv	s1,a0
    800052fc:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005300:	01853503          	ld	a0,24(a0)
    80005304:	ffffe097          	auipc	ra,0xffffe
    80005308:	430080e7          	jalr	1072(ra) # 80003734 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000530c:	0304b503          	ld	a0,48(s1)
    80005310:	ffffe097          	auipc	ra,0xffffe
    80005314:	424080e7          	jalr	1060(ra) # 80003734 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80005318:	0084b783          	ld	a5,8(s1)
    8000531c:	0144a703          	lw	a4,20(s1)
    80005320:	00271713          	slli	a4,a4,0x2
    80005324:	00e787b3          	add	a5,a5,a4
    80005328:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000532c:	0144a783          	lw	a5,20(s1)
    80005330:	0017879b          	addiw	a5,a5,1
    80005334:	0004a703          	lw	a4,0(s1)
    80005338:	02e7e7bb          	remw	a5,a5,a4
    8000533c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005340:	0304b503          	ld	a0,48(s1)
    80005344:	ffffe097          	auipc	ra,0xffffe
    80005348:	41c080e7          	jalr	1052(ra) # 80003760 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000534c:	0204b503          	ld	a0,32(s1)
    80005350:	ffffe097          	auipc	ra,0xffffe
    80005354:	410080e7          	jalr	1040(ra) # 80003760 <_ZN9Semaphore6signalEv>

}
    80005358:	01813083          	ld	ra,24(sp)
    8000535c:	01013403          	ld	s0,16(sp)
    80005360:	00813483          	ld	s1,8(sp)
    80005364:	00013903          	ld	s2,0(sp)
    80005368:	02010113          	addi	sp,sp,32
    8000536c:	00008067          	ret

0000000080005370 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005370:	fe010113          	addi	sp,sp,-32
    80005374:	00113c23          	sd	ra,24(sp)
    80005378:	00813823          	sd	s0,16(sp)
    8000537c:	00913423          	sd	s1,8(sp)
    80005380:	01213023          	sd	s2,0(sp)
    80005384:	02010413          	addi	s0,sp,32
    80005388:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000538c:	02053503          	ld	a0,32(a0)
    80005390:	ffffe097          	auipc	ra,0xffffe
    80005394:	3a4080e7          	jalr	932(ra) # 80003734 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005398:	0284b503          	ld	a0,40(s1)
    8000539c:	ffffe097          	auipc	ra,0xffffe
    800053a0:	398080e7          	jalr	920(ra) # 80003734 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    800053a4:	0084b703          	ld	a4,8(s1)
    800053a8:	0104a783          	lw	a5,16(s1)
    800053ac:	00279693          	slli	a3,a5,0x2
    800053b0:	00d70733          	add	a4,a4,a3
    800053b4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800053b8:	0017879b          	addiw	a5,a5,1
    800053bc:	0004a703          	lw	a4,0(s1)
    800053c0:	02e7e7bb          	remw	a5,a5,a4
    800053c4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800053c8:	0284b503          	ld	a0,40(s1)
    800053cc:	ffffe097          	auipc	ra,0xffffe
    800053d0:	394080e7          	jalr	916(ra) # 80003760 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800053d4:	0184b503          	ld	a0,24(s1)
    800053d8:	ffffe097          	auipc	ra,0xffffe
    800053dc:	388080e7          	jalr	904(ra) # 80003760 <_ZN9Semaphore6signalEv>

    return ret;
}
    800053e0:	00090513          	mv	a0,s2
    800053e4:	01813083          	ld	ra,24(sp)
    800053e8:	01013403          	ld	s0,16(sp)
    800053ec:	00813483          	ld	s1,8(sp)
    800053f0:	00013903          	ld	s2,0(sp)
    800053f4:	02010113          	addi	sp,sp,32
    800053f8:	00008067          	ret

00000000800053fc <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800053fc:	fe010113          	addi	sp,sp,-32
    80005400:	00113c23          	sd	ra,24(sp)
    80005404:	00813823          	sd	s0,16(sp)
    80005408:	00913423          	sd	s1,8(sp)
    8000540c:	01213023          	sd	s2,0(sp)
    80005410:	02010413          	addi	s0,sp,32
    80005414:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005418:	02853503          	ld	a0,40(a0)
    8000541c:	ffffe097          	auipc	ra,0xffffe
    80005420:	318080e7          	jalr	792(ra) # 80003734 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005424:	0304b503          	ld	a0,48(s1)
    80005428:	ffffe097          	auipc	ra,0xffffe
    8000542c:	30c080e7          	jalr	780(ra) # 80003734 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005430:	0144a783          	lw	a5,20(s1)
    80005434:	0104a903          	lw	s2,16(s1)
    80005438:	0327ce63          	blt	a5,s2,80005474 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000543c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005440:	0304b503          	ld	a0,48(s1)
    80005444:	ffffe097          	auipc	ra,0xffffe
    80005448:	31c080e7          	jalr	796(ra) # 80003760 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000544c:	0284b503          	ld	a0,40(s1)
    80005450:	ffffe097          	auipc	ra,0xffffe
    80005454:	310080e7          	jalr	784(ra) # 80003760 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005458:	00090513          	mv	a0,s2
    8000545c:	01813083          	ld	ra,24(sp)
    80005460:	01013403          	ld	s0,16(sp)
    80005464:	00813483          	ld	s1,8(sp)
    80005468:	00013903          	ld	s2,0(sp)
    8000546c:	02010113          	addi	sp,sp,32
    80005470:	00008067          	ret
        ret = cap - head + tail;
    80005474:	0004a703          	lw	a4,0(s1)
    80005478:	4127093b          	subw	s2,a4,s2
    8000547c:	00f9093b          	addw	s2,s2,a5
    80005480:	fc1ff06f          	j	80005440 <_ZN9BufferCPP6getCntEv+0x44>

0000000080005484 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005484:	fe010113          	addi	sp,sp,-32
    80005488:	00113c23          	sd	ra,24(sp)
    8000548c:	00813823          	sd	s0,16(sp)
    80005490:	00913423          	sd	s1,8(sp)
    80005494:	02010413          	addi	s0,sp,32
    80005498:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000549c:	00a00513          	li	a0,10
    800054a0:	ffffe097          	auipc	ra,0xffffe
    800054a4:	4bc080e7          	jalr	1212(ra) # 8000395c <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    800054a8:	00004517          	auipc	a0,0x4
    800054ac:	0b050513          	addi	a0,a0,176 # 80009558 <CONSOLE_STATUS+0x548>
    800054b0:	ffffd097          	auipc	ra,0xffffd
    800054b4:	40c080e7          	jalr	1036(ra) # 800028bc <_Z11printStringPKc>
    while (getCnt()) {
    800054b8:	00048513          	mv	a0,s1
    800054bc:	00000097          	auipc	ra,0x0
    800054c0:	f40080e7          	jalr	-192(ra) # 800053fc <_ZN9BufferCPP6getCntEv>
    800054c4:	02050c63          	beqz	a0,800054fc <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800054c8:	0084b783          	ld	a5,8(s1)
    800054cc:	0104a703          	lw	a4,16(s1)
    800054d0:	00271713          	slli	a4,a4,0x2
    800054d4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800054d8:	0007c503          	lbu	a0,0(a5)
    800054dc:	ffffe097          	auipc	ra,0xffffe
    800054e0:	480080e7          	jalr	1152(ra) # 8000395c <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800054e4:	0104a783          	lw	a5,16(s1)
    800054e8:	0017879b          	addiw	a5,a5,1
    800054ec:	0004a703          	lw	a4,0(s1)
    800054f0:	02e7e7bb          	remw	a5,a5,a4
    800054f4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800054f8:	fc1ff06f          	j	800054b8 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800054fc:	02100513          	li	a0,33
    80005500:	ffffe097          	auipc	ra,0xffffe
    80005504:	45c080e7          	jalr	1116(ra) # 8000395c <_ZN7Console4putcEc>
    Console::putc('\n');
    80005508:	00a00513          	li	a0,10
    8000550c:	ffffe097          	auipc	ra,0xffffe
    80005510:	450080e7          	jalr	1104(ra) # 8000395c <_ZN7Console4putcEc>
    mem_free(buffer);
    80005514:	0084b503          	ld	a0,8(s1)
    80005518:	ffffd097          	auipc	ra,0xffffd
    8000551c:	908080e7          	jalr	-1784(ra) # 80001e20 <_Z8mem_freePv>
    delete itemAvailable;
    80005520:	0204b503          	ld	a0,32(s1)
    80005524:	00050863          	beqz	a0,80005534 <_ZN9BufferCPPD1Ev+0xb0>
    80005528:	00053783          	ld	a5,0(a0)
    8000552c:	0087b783          	ld	a5,8(a5)
    80005530:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005534:	0184b503          	ld	a0,24(s1)
    80005538:	00050863          	beqz	a0,80005548 <_ZN9BufferCPPD1Ev+0xc4>
    8000553c:	00053783          	ld	a5,0(a0)
    80005540:	0087b783          	ld	a5,8(a5)
    80005544:	000780e7          	jalr	a5
    delete mutexTail;
    80005548:	0304b503          	ld	a0,48(s1)
    8000554c:	00050863          	beqz	a0,8000555c <_ZN9BufferCPPD1Ev+0xd8>
    80005550:	00053783          	ld	a5,0(a0)
    80005554:	0087b783          	ld	a5,8(a5)
    80005558:	000780e7          	jalr	a5
    delete mutexHead;
    8000555c:	0284b503          	ld	a0,40(s1)
    80005560:	00050863          	beqz	a0,80005570 <_ZN9BufferCPPD1Ev+0xec>
    80005564:	00053783          	ld	a5,0(a0)
    80005568:	0087b783          	ld	a5,8(a5)
    8000556c:	000780e7          	jalr	a5
}
    80005570:	01813083          	ld	ra,24(sp)
    80005574:	01013403          	ld	s0,16(sp)
    80005578:	00813483          	ld	s1,8(sp)
    8000557c:	02010113          	addi	sp,sp,32
    80005580:	00008067          	ret

0000000080005584 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005584:	f8010113          	addi	sp,sp,-128
    80005588:	06113c23          	sd	ra,120(sp)
    8000558c:	06813823          	sd	s0,112(sp)
    80005590:	06913423          	sd	s1,104(sp)
    80005594:	07213023          	sd	s2,96(sp)
    80005598:	05313c23          	sd	s3,88(sp)
    8000559c:	05413823          	sd	s4,80(sp)
    800055a0:	05513423          	sd	s5,72(sp)
    800055a4:	05613023          	sd	s6,64(sp)
    800055a8:	03713c23          	sd	s7,56(sp)
    800055ac:	03813823          	sd	s8,48(sp)
    800055b0:	03913423          	sd	s9,40(sp)
    800055b4:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    800055b8:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    800055bc:	00004517          	auipc	a0,0x4
    800055c0:	fb450513          	addi	a0,a0,-76 # 80009570 <CONSOLE_STATUS+0x560>
    800055c4:	ffffd097          	auipc	ra,0xffffd
    800055c8:	2f8080e7          	jalr	760(ra) # 800028bc <_Z11printStringPKc>
        getString(input, 30);
    800055cc:	01e00593          	li	a1,30
    800055d0:	f8040493          	addi	s1,s0,-128
    800055d4:	00048513          	mv	a0,s1
    800055d8:	ffffd097          	auipc	ra,0xffffd
    800055dc:	360080e7          	jalr	864(ra) # 80002938 <_Z9getStringPci>
        threadNum = stringToInt(input);
    800055e0:	00048513          	mv	a0,s1
    800055e4:	ffffd097          	auipc	ra,0xffffd
    800055e8:	420080e7          	jalr	1056(ra) # 80002a04 <_Z11stringToIntPKc>
    800055ec:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    800055f0:	00004517          	auipc	a0,0x4
    800055f4:	fa050513          	addi	a0,a0,-96 # 80009590 <CONSOLE_STATUS+0x580>
    800055f8:	ffffd097          	auipc	ra,0xffffd
    800055fc:	2c4080e7          	jalr	708(ra) # 800028bc <_Z11printStringPKc>
        getString(input, 30);
    80005600:	01e00593          	li	a1,30
    80005604:	00048513          	mv	a0,s1
    80005608:	ffffd097          	auipc	ra,0xffffd
    8000560c:	330080e7          	jalr	816(ra) # 80002938 <_Z9getStringPci>
        n = stringToInt(input);
    80005610:	00048513          	mv	a0,s1
    80005614:	ffffd097          	auipc	ra,0xffffd
    80005618:	3f0080e7          	jalr	1008(ra) # 80002a04 <_Z11stringToIntPKc>
    8000561c:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80005620:	00004517          	auipc	a0,0x4
    80005624:	f9050513          	addi	a0,a0,-112 # 800095b0 <CONSOLE_STATUS+0x5a0>
    80005628:	ffffd097          	auipc	ra,0xffffd
    8000562c:	294080e7          	jalr	660(ra) # 800028bc <_Z11printStringPKc>
    80005630:	00000613          	li	a2,0
    80005634:	00a00593          	li	a1,10
    80005638:	00098513          	mv	a0,s3
    8000563c:	ffffd097          	auipc	ra,0xffffd
    80005640:	418080e7          	jalr	1048(ra) # 80002a54 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005644:	00004517          	auipc	a0,0x4
    80005648:	f8450513          	addi	a0,a0,-124 # 800095c8 <CONSOLE_STATUS+0x5b8>
    8000564c:	ffffd097          	auipc	ra,0xffffd
    80005650:	270080e7          	jalr	624(ra) # 800028bc <_Z11printStringPKc>
    80005654:	00000613          	li	a2,0
    80005658:	00a00593          	li	a1,10
    8000565c:	00048513          	mv	a0,s1
    80005660:	ffffd097          	auipc	ra,0xffffd
    80005664:	3f4080e7          	jalr	1012(ra) # 80002a54 <_Z8printIntiii>
        printString(".\n");
    80005668:	00004517          	auipc	a0,0x4
    8000566c:	d4850513          	addi	a0,a0,-696 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80005670:	ffffd097          	auipc	ra,0xffffd
    80005674:	24c080e7          	jalr	588(ra) # 800028bc <_Z11printStringPKc>
        if(threadNum > n) {
    80005678:	0334c463          	blt	s1,s3,800056a0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    8000567c:	03305c63          	blez	s3,800056b4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005680:	03800513          	li	a0,56
    80005684:	ffffe097          	auipc	ra,0xffffe
    80005688:	f80080e7          	jalr	-128(ra) # 80003604 <_Znwm>
    8000568c:	00050a93          	mv	s5,a0
    80005690:	00048593          	mv	a1,s1
    80005694:	00000097          	auipc	ra,0x0
    80005698:	af8080e7          	jalr	-1288(ra) # 8000518c <_ZN9BufferCPPC1Ei>
    8000569c:	0300006f          	j	800056cc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800056a0:	00004517          	auipc	a0,0x4
    800056a4:	f4050513          	addi	a0,a0,-192 # 800095e0 <CONSOLE_STATUS+0x5d0>
    800056a8:	ffffd097          	auipc	ra,0xffffd
    800056ac:	214080e7          	jalr	532(ra) # 800028bc <_Z11printStringPKc>
            return;
    800056b0:	0140006f          	j	800056c4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    800056b4:	00004517          	auipc	a0,0x4
    800056b8:	f6c50513          	addi	a0,a0,-148 # 80009620 <CONSOLE_STATUS+0x610>
    800056bc:	ffffd097          	auipc	ra,0xffffd
    800056c0:	200080e7          	jalr	512(ra) # 800028bc <_Z11printStringPKc>
            return;
    800056c4:	000c0113          	mv	sp,s8
    800056c8:	21c0006f          	j	800058e4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    800056cc:	01000513          	li	a0,16
    800056d0:	ffffe097          	auipc	ra,0xffffe
    800056d4:	f34080e7          	jalr	-204(ra) # 80003604 <_Znwm>
    800056d8:	00050493          	mv	s1,a0
    800056dc:	00000593          	li	a1,0
    800056e0:	ffffe097          	auipc	ra,0xffffe
    800056e4:	01c080e7          	jalr	28(ra) # 800036fc <_ZN9SemaphoreC1Ej>
    800056e8:	0000a717          	auipc	a4,0xa
    800056ec:	64070713          	addi	a4,a4,1600 # 8000fd28 <_ZN19ConsumerProducerCPP9threadEndE>
    800056f0:	00973423          	sd	s1,8(a4)
        Thread *producers[threadNum];
    800056f4:	00399793          	slli	a5,s3,0x3
    800056f8:	00f78793          	addi	a5,a5,15
    800056fc:	ff07f793          	andi	a5,a5,-16
    80005700:	40f10133          	sub	sp,sp,a5
    80005704:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80005708:	0019869b          	addiw	a3,s3,1
    8000570c:	00169793          	slli	a5,a3,0x1
    80005710:	00d787b3          	add	a5,a5,a3
    80005714:	00379793          	slli	a5,a5,0x3
    80005718:	00f78793          	addi	a5,a5,15
    8000571c:	ff07f793          	andi	a5,a5,-16
    80005720:	40f10133          	sub	sp,sp,a5
    80005724:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80005728:	00199493          	slli	s1,s3,0x1
    8000572c:	013484b3          	add	s1,s1,s3
    80005730:	00349493          	slli	s1,s1,0x3
    80005734:	009b04b3          	add	s1,s6,s1
    80005738:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    8000573c:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005740:	00873783          	ld	a5,8(a4)
    80005744:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005748:	01800513          	li	a0,24
    8000574c:	ffffe097          	auipc	ra,0xffffe
    80005750:	eb8080e7          	jalr	-328(ra) # 80003604 <_Znwm>
    80005754:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005758:	ffffe097          	auipc	ra,0xffffe
    8000575c:	06c080e7          	jalr	108(ra) # 800037c4 <_ZN6ThreadC1Ev>
    80005760:	00006797          	auipc	a5,0x6
    80005764:	28878793          	addi	a5,a5,648 # 8000b9e8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005768:	00fbb023          	sd	a5,0(s7)
    8000576c:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005770:	000b8513          	mv	a0,s7
    80005774:	ffffe097          	auipc	ra,0xffffe
    80005778:	124080e7          	jalr	292(ra) # 80003898 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    8000577c:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005780:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005784:	0000a797          	auipc	a5,0xa
    80005788:	5ac7b783          	ld	a5,1452(a5) # 8000fd30 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000578c:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005790:	01800513          	li	a0,24
    80005794:	ffffe097          	auipc	ra,0xffffe
    80005798:	e70080e7          	jalr	-400(ra) # 80003604 <_Znwm>
    8000579c:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    800057a0:	ffffe097          	auipc	ra,0xffffe
    800057a4:	024080e7          	jalr	36(ra) # 800037c4 <_ZN6ThreadC1Ev>
    800057a8:	00006797          	auipc	a5,0x6
    800057ac:	1f078793          	addi	a5,a5,496 # 8000b998 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800057b0:	00f4b023          	sd	a5,0(s1)
    800057b4:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    800057b8:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    800057bc:	00048513          	mv	a0,s1
    800057c0:	ffffe097          	auipc	ra,0xffffe
    800057c4:	0d8080e7          	jalr	216(ra) # 80003898 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800057c8:	00100913          	li	s2,1
    800057cc:	0300006f          	j	800057fc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800057d0:	00006797          	auipc	a5,0x6
    800057d4:	1f078793          	addi	a5,a5,496 # 8000b9c0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800057d8:	00fcb023          	sd	a5,0(s9)
    800057dc:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    800057e0:	00391793          	slli	a5,s2,0x3
    800057e4:	00fa07b3          	add	a5,s4,a5
    800057e8:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    800057ec:	000c8513          	mv	a0,s9
    800057f0:	ffffe097          	auipc	ra,0xffffe
    800057f4:	0a8080e7          	jalr	168(ra) # 80003898 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    800057f8:	0019091b          	addiw	s2,s2,1
    800057fc:	05395263          	bge	s2,s3,80005840 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80005800:	00191493          	slli	s1,s2,0x1
    80005804:	012484b3          	add	s1,s1,s2
    80005808:	00349493          	slli	s1,s1,0x3
    8000580c:	009b04b3          	add	s1,s6,s1
    80005810:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80005814:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80005818:	0000a797          	auipc	a5,0xa
    8000581c:	5187b783          	ld	a5,1304(a5) # 8000fd30 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005820:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80005824:	01800513          	li	a0,24
    80005828:	ffffe097          	auipc	ra,0xffffe
    8000582c:	ddc080e7          	jalr	-548(ra) # 80003604 <_Znwm>
    80005830:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005834:	ffffe097          	auipc	ra,0xffffe
    80005838:	f90080e7          	jalr	-112(ra) # 800037c4 <_ZN6ThreadC1Ev>
    8000583c:	f95ff06f          	j	800057d0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80005840:	ffffe097          	auipc	ra,0xffffe
    80005844:	030080e7          	jalr	48(ra) # 80003870 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80005848:	00000493          	li	s1,0
    8000584c:	0099ce63          	blt	s3,s1,80005868 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80005850:	0000a517          	auipc	a0,0xa
    80005854:	4e053503          	ld	a0,1248(a0) # 8000fd30 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005858:	ffffe097          	auipc	ra,0xffffe
    8000585c:	edc080e7          	jalr	-292(ra) # 80003734 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80005860:	0014849b          	addiw	s1,s1,1
    80005864:	fe9ff06f          	j	8000584c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80005868:	0000a517          	auipc	a0,0xa
    8000586c:	4c853503          	ld	a0,1224(a0) # 8000fd30 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005870:	00050863          	beqz	a0,80005880 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80005874:	00053783          	ld	a5,0(a0)
    80005878:	0087b783          	ld	a5,8(a5)
    8000587c:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80005880:	00000493          	li	s1,0
    80005884:	0080006f          	j	8000588c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80005888:	0014849b          	addiw	s1,s1,1
    8000588c:	0334d263          	bge	s1,s3,800058b0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80005890:	00349793          	slli	a5,s1,0x3
    80005894:	00fa07b3          	add	a5,s4,a5
    80005898:	0007b503          	ld	a0,0(a5)
    8000589c:	fe0506e3          	beqz	a0,80005888 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    800058a0:	00053783          	ld	a5,0(a0)
    800058a4:	0087b783          	ld	a5,8(a5)
    800058a8:	000780e7          	jalr	a5
    800058ac:	fddff06f          	j	80005888 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    800058b0:	000b8a63          	beqz	s7,800058c4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    800058b4:	000bb783          	ld	a5,0(s7)
    800058b8:	0087b783          	ld	a5,8(a5)
    800058bc:	000b8513          	mv	a0,s7
    800058c0:	000780e7          	jalr	a5
        delete buffer;
    800058c4:	000a8e63          	beqz	s5,800058e0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    800058c8:	000a8513          	mv	a0,s5
    800058cc:	00000097          	auipc	ra,0x0
    800058d0:	bb8080e7          	jalr	-1096(ra) # 80005484 <_ZN9BufferCPPD1Ev>
    800058d4:	000a8513          	mv	a0,s5
    800058d8:	ffffe097          	auipc	ra,0xffffe
    800058dc:	d7c080e7          	jalr	-644(ra) # 80003654 <_ZdlPv>
    800058e0:	000c0113          	mv	sp,s8
    }
    800058e4:	f8040113          	addi	sp,s0,-128
    800058e8:	07813083          	ld	ra,120(sp)
    800058ec:	07013403          	ld	s0,112(sp)
    800058f0:	06813483          	ld	s1,104(sp)
    800058f4:	06013903          	ld	s2,96(sp)
    800058f8:	05813983          	ld	s3,88(sp)
    800058fc:	05013a03          	ld	s4,80(sp)
    80005900:	04813a83          	ld	s5,72(sp)
    80005904:	04013b03          	ld	s6,64(sp)
    80005908:	03813b83          	ld	s7,56(sp)
    8000590c:	03013c03          	ld	s8,48(sp)
    80005910:	02813c83          	ld	s9,40(sp)
    80005914:	08010113          	addi	sp,sp,128
    80005918:	00008067          	ret
    8000591c:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80005920:	000a8513          	mv	a0,s5
    80005924:	ffffe097          	auipc	ra,0xffffe
    80005928:	d30080e7          	jalr	-720(ra) # 80003654 <_ZdlPv>
    8000592c:	00048513          	mv	a0,s1
    80005930:	0000b097          	auipc	ra,0xb
    80005934:	4d8080e7          	jalr	1240(ra) # 80010e08 <_Unwind_Resume>
    80005938:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    8000593c:	00048513          	mv	a0,s1
    80005940:	ffffe097          	auipc	ra,0xffffe
    80005944:	d14080e7          	jalr	-748(ra) # 80003654 <_ZdlPv>
    80005948:	00090513          	mv	a0,s2
    8000594c:	0000b097          	auipc	ra,0xb
    80005950:	4bc080e7          	jalr	1212(ra) # 80010e08 <_Unwind_Resume>
    80005954:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005958:	000b8513          	mv	a0,s7
    8000595c:	ffffe097          	auipc	ra,0xffffe
    80005960:	cf8080e7          	jalr	-776(ra) # 80003654 <_ZdlPv>
    80005964:	00048513          	mv	a0,s1
    80005968:	0000b097          	auipc	ra,0xb
    8000596c:	4a0080e7          	jalr	1184(ra) # 80010e08 <_Unwind_Resume>
    80005970:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005974:	00048513          	mv	a0,s1
    80005978:	ffffe097          	auipc	ra,0xffffe
    8000597c:	cdc080e7          	jalr	-804(ra) # 80003654 <_ZdlPv>
    80005980:	00090513          	mv	a0,s2
    80005984:	0000b097          	auipc	ra,0xb
    80005988:	484080e7          	jalr	1156(ra) # 80010e08 <_Unwind_Resume>
    8000598c:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80005990:	000c8513          	mv	a0,s9
    80005994:	ffffe097          	auipc	ra,0xffffe
    80005998:	cc0080e7          	jalr	-832(ra) # 80003654 <_ZdlPv>
    8000599c:	00048513          	mv	a0,s1
    800059a0:	0000b097          	auipc	ra,0xb
    800059a4:	468080e7          	jalr	1128(ra) # 80010e08 <_Unwind_Resume>

00000000800059a8 <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    800059a8:	ff010113          	addi	sp,sp,-16
    800059ac:	00113423          	sd	ra,8(sp)
    800059b0:	00813023          	sd	s0,0(sp)
    800059b4:	01010413          	addi	s0,sp,16

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    800059b8:	00000097          	auipc	ra,0x0
    800059bc:	bcc080e7          	jalr	-1076(ra) # 80005584 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>

    800059c0:	00813083          	ld	ra,8(sp)
    800059c4:	00013403          	ld	s0,0(sp)
    800059c8:	01010113          	addi	sp,sp,16
    800059cc:	00008067          	ret

00000000800059d0 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    800059d0:	fd010113          	addi	sp,sp,-48
    800059d4:	02113423          	sd	ra,40(sp)
    800059d8:	02813023          	sd	s0,32(sp)
    800059dc:	00913c23          	sd	s1,24(sp)
    800059e0:	01213823          	sd	s2,16(sp)
    800059e4:	01313423          	sd	s3,8(sp)
    800059e8:	03010413          	addi	s0,sp,48
    800059ec:	00050913          	mv	s2,a0
            int i = 0;
    800059f0:	00000993          	li	s3,0
    800059f4:	0100006f          	j	80005a04 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    800059f8:	00a00513          	li	a0,10
    800059fc:	ffffe097          	auipc	ra,0xffffe
    80005a00:	f60080e7          	jalr	-160(ra) # 8000395c <_ZN7Console4putcEc>
            while (!threadEnd) {
    80005a04:	0000a797          	auipc	a5,0xa
    80005a08:	3247a783          	lw	a5,804(a5) # 8000fd28 <_ZN19ConsumerProducerCPP9threadEndE>
    80005a0c:	04079a63          	bnez	a5,80005a60 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80005a10:	01093783          	ld	a5,16(s2)
    80005a14:	0087b503          	ld	a0,8(a5)
    80005a18:	00000097          	auipc	ra,0x0
    80005a1c:	958080e7          	jalr	-1704(ra) # 80005370 <_ZN9BufferCPP3getEv>
                i++;
    80005a20:	0019849b          	addiw	s1,s3,1
    80005a24:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80005a28:	0ff57513          	andi	a0,a0,255
    80005a2c:	ffffe097          	auipc	ra,0xffffe
    80005a30:	f30080e7          	jalr	-208(ra) # 8000395c <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80005a34:	05000793          	li	a5,80
    80005a38:	02f4e4bb          	remw	s1,s1,a5
    80005a3c:	fc0494e3          	bnez	s1,80005a04 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80005a40:	fb9ff06f          	j	800059f8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80005a44:	01093783          	ld	a5,16(s2)
    80005a48:	0087b503          	ld	a0,8(a5)
    80005a4c:	00000097          	auipc	ra,0x0
    80005a50:	924080e7          	jalr	-1756(ra) # 80005370 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80005a54:	0ff57513          	andi	a0,a0,255
    80005a58:	ffffe097          	auipc	ra,0xffffe
    80005a5c:	f04080e7          	jalr	-252(ra) # 8000395c <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80005a60:	01093783          	ld	a5,16(s2)
    80005a64:	0087b503          	ld	a0,8(a5)
    80005a68:	00000097          	auipc	ra,0x0
    80005a6c:	994080e7          	jalr	-1644(ra) # 800053fc <_ZN9BufferCPP6getCntEv>
    80005a70:	fca04ae3          	bgtz	a0,80005a44 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80005a74:	01093783          	ld	a5,16(s2)
    80005a78:	0107b503          	ld	a0,16(a5)
    80005a7c:	ffffe097          	auipc	ra,0xffffe
    80005a80:	ce4080e7          	jalr	-796(ra) # 80003760 <_ZN9Semaphore6signalEv>
        }
    80005a84:	02813083          	ld	ra,40(sp)
    80005a88:	02013403          	ld	s0,32(sp)
    80005a8c:	01813483          	ld	s1,24(sp)
    80005a90:	01013903          	ld	s2,16(sp)
    80005a94:	00813983          	ld	s3,8(sp)
    80005a98:	03010113          	addi	sp,sp,48
    80005a9c:	00008067          	ret

0000000080005aa0 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80005aa0:	ff010113          	addi	sp,sp,-16
    80005aa4:	00113423          	sd	ra,8(sp)
    80005aa8:	00813023          	sd	s0,0(sp)
    80005aac:	01010413          	addi	s0,sp,16
    80005ab0:	00006797          	auipc	a5,0x6
    80005ab4:	f3878793          	addi	a5,a5,-200 # 8000b9e8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005ab8:	00f53023          	sd	a5,0(a0)
    80005abc:	ffffe097          	auipc	ra,0xffffe
    80005ac0:	b08080e7          	jalr	-1272(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80005ac4:	00813083          	ld	ra,8(sp)
    80005ac8:	00013403          	ld	s0,0(sp)
    80005acc:	01010113          	addi	sp,sp,16
    80005ad0:	00008067          	ret

0000000080005ad4 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80005ad4:	fe010113          	addi	sp,sp,-32
    80005ad8:	00113c23          	sd	ra,24(sp)
    80005adc:	00813823          	sd	s0,16(sp)
    80005ae0:	00913423          	sd	s1,8(sp)
    80005ae4:	02010413          	addi	s0,sp,32
    80005ae8:	00050493          	mv	s1,a0
    80005aec:	00006797          	auipc	a5,0x6
    80005af0:	efc78793          	addi	a5,a5,-260 # 8000b9e8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005af4:	00f53023          	sd	a5,0(a0)
    80005af8:	ffffe097          	auipc	ra,0xffffe
    80005afc:	acc080e7          	jalr	-1332(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80005b00:	00048513          	mv	a0,s1
    80005b04:	ffffe097          	auipc	ra,0xffffe
    80005b08:	b50080e7          	jalr	-1200(ra) # 80003654 <_ZdlPv>
    80005b0c:	01813083          	ld	ra,24(sp)
    80005b10:	01013403          	ld	s0,16(sp)
    80005b14:	00813483          	ld	s1,8(sp)
    80005b18:	02010113          	addi	sp,sp,32
    80005b1c:	00008067          	ret

0000000080005b20 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80005b20:	ff010113          	addi	sp,sp,-16
    80005b24:	00113423          	sd	ra,8(sp)
    80005b28:	00813023          	sd	s0,0(sp)
    80005b2c:	01010413          	addi	s0,sp,16
    80005b30:	00006797          	auipc	a5,0x6
    80005b34:	e6878793          	addi	a5,a5,-408 # 8000b998 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005b38:	00f53023          	sd	a5,0(a0)
    80005b3c:	ffffe097          	auipc	ra,0xffffe
    80005b40:	a88080e7          	jalr	-1400(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80005b44:	00813083          	ld	ra,8(sp)
    80005b48:	00013403          	ld	s0,0(sp)
    80005b4c:	01010113          	addi	sp,sp,16
    80005b50:	00008067          	ret

0000000080005b54 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80005b54:	fe010113          	addi	sp,sp,-32
    80005b58:	00113c23          	sd	ra,24(sp)
    80005b5c:	00813823          	sd	s0,16(sp)
    80005b60:	00913423          	sd	s1,8(sp)
    80005b64:	02010413          	addi	s0,sp,32
    80005b68:	00050493          	mv	s1,a0
    80005b6c:	00006797          	auipc	a5,0x6
    80005b70:	e2c78793          	addi	a5,a5,-468 # 8000b998 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005b74:	00f53023          	sd	a5,0(a0)
    80005b78:	ffffe097          	auipc	ra,0xffffe
    80005b7c:	a4c080e7          	jalr	-1460(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80005b80:	00048513          	mv	a0,s1
    80005b84:	ffffe097          	auipc	ra,0xffffe
    80005b88:	ad0080e7          	jalr	-1328(ra) # 80003654 <_ZdlPv>
    80005b8c:	01813083          	ld	ra,24(sp)
    80005b90:	01013403          	ld	s0,16(sp)
    80005b94:	00813483          	ld	s1,8(sp)
    80005b98:	02010113          	addi	sp,sp,32
    80005b9c:	00008067          	ret

0000000080005ba0 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80005ba0:	ff010113          	addi	sp,sp,-16
    80005ba4:	00113423          	sd	ra,8(sp)
    80005ba8:	00813023          	sd	s0,0(sp)
    80005bac:	01010413          	addi	s0,sp,16
    80005bb0:	00006797          	auipc	a5,0x6
    80005bb4:	e1078793          	addi	a5,a5,-496 # 8000b9c0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005bb8:	00f53023          	sd	a5,0(a0)
    80005bbc:	ffffe097          	auipc	ra,0xffffe
    80005bc0:	a08080e7          	jalr	-1528(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80005bc4:	00813083          	ld	ra,8(sp)
    80005bc8:	00013403          	ld	s0,0(sp)
    80005bcc:	01010113          	addi	sp,sp,16
    80005bd0:	00008067          	ret

0000000080005bd4 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80005bd4:	fe010113          	addi	sp,sp,-32
    80005bd8:	00113c23          	sd	ra,24(sp)
    80005bdc:	00813823          	sd	s0,16(sp)
    80005be0:	00913423          	sd	s1,8(sp)
    80005be4:	02010413          	addi	s0,sp,32
    80005be8:	00050493          	mv	s1,a0
    80005bec:	00006797          	auipc	a5,0x6
    80005bf0:	dd478793          	addi	a5,a5,-556 # 8000b9c0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005bf4:	00f53023          	sd	a5,0(a0)
    80005bf8:	ffffe097          	auipc	ra,0xffffe
    80005bfc:	9cc080e7          	jalr	-1588(ra) # 800035c4 <_ZN6ThreadD1Ev>
    80005c00:	00048513          	mv	a0,s1
    80005c04:	ffffe097          	auipc	ra,0xffffe
    80005c08:	a50080e7          	jalr	-1456(ra) # 80003654 <_ZdlPv>
    80005c0c:	01813083          	ld	ra,24(sp)
    80005c10:	01013403          	ld	s0,16(sp)
    80005c14:	00813483          	ld	s1,8(sp)
    80005c18:	02010113          	addi	sp,sp,32
    80005c1c:	00008067          	ret

0000000080005c20 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80005c20:	fe010113          	addi	sp,sp,-32
    80005c24:	00113c23          	sd	ra,24(sp)
    80005c28:	00813823          	sd	s0,16(sp)
    80005c2c:	00913423          	sd	s1,8(sp)
    80005c30:	02010413          	addi	s0,sp,32
    80005c34:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80005c38:	ffffc097          	auipc	ra,0xffffc
    80005c3c:	468080e7          	jalr	1128(ra) # 800020a0 <_Z4getcv>
    80005c40:	0005059b          	sext.w	a1,a0
    80005c44:	01b00793          	li	a5,27
    80005c48:	00f58c63          	beq	a1,a5,80005c60 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80005c4c:	0104b783          	ld	a5,16(s1)
    80005c50:	0087b503          	ld	a0,8(a5)
    80005c54:	fffff097          	auipc	ra,0xfffff
    80005c58:	68c080e7          	jalr	1676(ra) # 800052e0 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80005c5c:	fddff06f          	j	80005c38 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80005c60:	00100793          	li	a5,1
    80005c64:	0000a717          	auipc	a4,0xa
    80005c68:	0cf72223          	sw	a5,196(a4) # 8000fd28 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80005c6c:	0104b783          	ld	a5,16(s1)
    80005c70:	02100593          	li	a1,33
    80005c74:	0087b503          	ld	a0,8(a5)
    80005c78:	fffff097          	auipc	ra,0xfffff
    80005c7c:	668080e7          	jalr	1640(ra) # 800052e0 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80005c80:	0104b783          	ld	a5,16(s1)
    80005c84:	0107b503          	ld	a0,16(a5)
    80005c88:	ffffe097          	auipc	ra,0xffffe
    80005c8c:	ad8080e7          	jalr	-1320(ra) # 80003760 <_ZN9Semaphore6signalEv>
        }
    80005c90:	01813083          	ld	ra,24(sp)
    80005c94:	01013403          	ld	s0,16(sp)
    80005c98:	00813483          	ld	s1,8(sp)
    80005c9c:	02010113          	addi	sp,sp,32
    80005ca0:	00008067          	ret

0000000080005ca4 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80005ca4:	fe010113          	addi	sp,sp,-32
    80005ca8:	00113c23          	sd	ra,24(sp)
    80005cac:	00813823          	sd	s0,16(sp)
    80005cb0:	00913423          	sd	s1,8(sp)
    80005cb4:	01213023          	sd	s2,0(sp)
    80005cb8:	02010413          	addi	s0,sp,32
    80005cbc:	00050493          	mv	s1,a0
            int i = 0;
    80005cc0:	00000913          	li	s2,0
            while (!threadEnd) {
    80005cc4:	0000a797          	auipc	a5,0xa
    80005cc8:	0647a783          	lw	a5,100(a5) # 8000fd28 <_ZN19ConsumerProducerCPP9threadEndE>
    80005ccc:	04079263          	bnez	a5,80005d10 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80005cd0:	0104b783          	ld	a5,16(s1)
    80005cd4:	0007a583          	lw	a1,0(a5)
    80005cd8:	0305859b          	addiw	a1,a1,48
    80005cdc:	0087b503          	ld	a0,8(a5)
    80005ce0:	fffff097          	auipc	ra,0xfffff
    80005ce4:	600080e7          	jalr	1536(ra) # 800052e0 <_ZN9BufferCPP3putEi>
                i++;
    80005ce8:	0019071b          	addiw	a4,s2,1
    80005cec:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80005cf0:	0104b783          	ld	a5,16(s1)
    80005cf4:	0007a783          	lw	a5,0(a5)
    80005cf8:	00e787bb          	addw	a5,a5,a4
    80005cfc:	00500513          	li	a0,5
    80005d00:	02a7e53b          	remw	a0,a5,a0
    80005d04:	ffffe097          	auipc	ra,0xffffe
    80005d08:	b04080e7          	jalr	-1276(ra) # 80003808 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80005d0c:	fb9ff06f          	j	80005cc4 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80005d10:	0104b783          	ld	a5,16(s1)
    80005d14:	0107b503          	ld	a0,16(a5)
    80005d18:	ffffe097          	auipc	ra,0xffffe
    80005d1c:	a48080e7          	jalr	-1464(ra) # 80003760 <_ZN9Semaphore6signalEv>
        }
    80005d20:	01813083          	ld	ra,24(sp)
    80005d24:	01013403          	ld	s0,16(sp)
    80005d28:	00813483          	ld	s1,8(sp)
    80005d2c:	00013903          	ld	s2,0(sp)
    80005d30:	02010113          	addi	sp,sp,32
    80005d34:	00008067          	ret

0000000080005d38 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005d38:	fe010113          	addi	sp,sp,-32
    80005d3c:	00113c23          	sd	ra,24(sp)
    80005d40:	00813823          	sd	s0,16(sp)
    80005d44:	00913423          	sd	s1,8(sp)
    80005d48:	01213023          	sd	s2,0(sp)
    80005d4c:	02010413          	addi	s0,sp,32
    80005d50:	00050493          	mv	s1,a0
    80005d54:	00058913          	mv	s2,a1
    80005d58:	0015879b          	addiw	a5,a1,1
    80005d5c:	0007851b          	sext.w	a0,a5
    80005d60:	00f4a023          	sw	a5,0(s1)
    80005d64:	0004a823          	sw	zero,16(s1)
    80005d68:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005d6c:	00251513          	slli	a0,a0,0x2
    80005d70:	ffffc097          	auipc	ra,0xffffc
    80005d74:	080080e7          	jalr	128(ra) # 80001df0 <_Z9mem_allocm>
    80005d78:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80005d7c:	00000593          	li	a1,0
    80005d80:	02048513          	addi	a0,s1,32
    80005d84:	ffffc097          	auipc	ra,0xffffc
    80005d88:	234080e7          	jalr	564(ra) # 80001fb8 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80005d8c:	00090593          	mv	a1,s2
    80005d90:	01848513          	addi	a0,s1,24
    80005d94:	ffffc097          	auipc	ra,0xffffc
    80005d98:	224080e7          	jalr	548(ra) # 80001fb8 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80005d9c:	00100593          	li	a1,1
    80005da0:	02848513          	addi	a0,s1,40
    80005da4:	ffffc097          	auipc	ra,0xffffc
    80005da8:	214080e7          	jalr	532(ra) # 80001fb8 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80005dac:	00100593          	li	a1,1
    80005db0:	03048513          	addi	a0,s1,48
    80005db4:	ffffc097          	auipc	ra,0xffffc
    80005db8:	204080e7          	jalr	516(ra) # 80001fb8 <_Z8sem_openPP10_semaphorej>
}
    80005dbc:	01813083          	ld	ra,24(sp)
    80005dc0:	01013403          	ld	s0,16(sp)
    80005dc4:	00813483          	ld	s1,8(sp)
    80005dc8:	00013903          	ld	s2,0(sp)
    80005dcc:	02010113          	addi	sp,sp,32
    80005dd0:	00008067          	ret

0000000080005dd4 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80005dd4:	fe010113          	addi	sp,sp,-32
    80005dd8:	00113c23          	sd	ra,24(sp)
    80005ddc:	00813823          	sd	s0,16(sp)
    80005de0:	00913423          	sd	s1,8(sp)
    80005de4:	01213023          	sd	s2,0(sp)
    80005de8:	02010413          	addi	s0,sp,32
    80005dec:	00050493          	mv	s1,a0
    80005df0:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80005df4:	01853503          	ld	a0,24(a0)
    80005df8:	ffffc097          	auipc	ra,0xffffc
    80005dfc:	224080e7          	jalr	548(ra) # 8000201c <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80005e00:	0304b503          	ld	a0,48(s1)
    80005e04:	ffffc097          	auipc	ra,0xffffc
    80005e08:	218080e7          	jalr	536(ra) # 8000201c <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80005e0c:	0084b783          	ld	a5,8(s1)
    80005e10:	0144a703          	lw	a4,20(s1)
    80005e14:	00271713          	slli	a4,a4,0x2
    80005e18:	00e787b3          	add	a5,a5,a4
    80005e1c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005e20:	0144a783          	lw	a5,20(s1)
    80005e24:	0017879b          	addiw	a5,a5,1
    80005e28:	0004a703          	lw	a4,0(s1)
    80005e2c:	02e7e7bb          	remw	a5,a5,a4
    80005e30:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80005e34:	0304b503          	ld	a0,48(s1)
    80005e38:	ffffc097          	auipc	ra,0xffffc
    80005e3c:	210080e7          	jalr	528(ra) # 80002048 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80005e40:	0204b503          	ld	a0,32(s1)
    80005e44:	ffffc097          	auipc	ra,0xffffc
    80005e48:	204080e7          	jalr	516(ra) # 80002048 <_Z10sem_signalP10_semaphore>

}
    80005e4c:	01813083          	ld	ra,24(sp)
    80005e50:	01013403          	ld	s0,16(sp)
    80005e54:	00813483          	ld	s1,8(sp)
    80005e58:	00013903          	ld	s2,0(sp)
    80005e5c:	02010113          	addi	sp,sp,32
    80005e60:	00008067          	ret

0000000080005e64 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005e64:	fe010113          	addi	sp,sp,-32
    80005e68:	00113c23          	sd	ra,24(sp)
    80005e6c:	00813823          	sd	s0,16(sp)
    80005e70:	00913423          	sd	s1,8(sp)
    80005e74:	01213023          	sd	s2,0(sp)
    80005e78:	02010413          	addi	s0,sp,32
    80005e7c:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005e80:	02053503          	ld	a0,32(a0)
    80005e84:	ffffc097          	auipc	ra,0xffffc
    80005e88:	198080e7          	jalr	408(ra) # 8000201c <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80005e8c:	0284b503          	ld	a0,40(s1)
    80005e90:	ffffc097          	auipc	ra,0xffffc
    80005e94:	18c080e7          	jalr	396(ra) # 8000201c <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80005e98:	0084b703          	ld	a4,8(s1)
    80005e9c:	0104a783          	lw	a5,16(s1)
    80005ea0:	00279693          	slli	a3,a5,0x2
    80005ea4:	00d70733          	add	a4,a4,a3
    80005ea8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005eac:	0017879b          	addiw	a5,a5,1
    80005eb0:	0004a703          	lw	a4,0(s1)
    80005eb4:	02e7e7bb          	remw	a5,a5,a4
    80005eb8:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005ebc:	0284b503          	ld	a0,40(s1)
    80005ec0:	ffffc097          	auipc	ra,0xffffc
    80005ec4:	188080e7          	jalr	392(ra) # 80002048 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80005ec8:	0184b503          	ld	a0,24(s1)
    80005ecc:	ffffc097          	auipc	ra,0xffffc
    80005ed0:	17c080e7          	jalr	380(ra) # 80002048 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80005ed4:	00090513          	mv	a0,s2
    80005ed8:	01813083          	ld	ra,24(sp)
    80005edc:	01013403          	ld	s0,16(sp)
    80005ee0:	00813483          	ld	s1,8(sp)
    80005ee4:	00013903          	ld	s2,0(sp)
    80005ee8:	02010113          	addi	sp,sp,32
    80005eec:	00008067          	ret

0000000080005ef0 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80005ef0:	fe010113          	addi	sp,sp,-32
    80005ef4:	00113c23          	sd	ra,24(sp)
    80005ef8:	00813823          	sd	s0,16(sp)
    80005efc:	00913423          	sd	s1,8(sp)
    80005f00:	01213023          	sd	s2,0(sp)
    80005f04:	02010413          	addi	s0,sp,32
    80005f08:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80005f0c:	02853503          	ld	a0,40(a0)
    80005f10:	ffffc097          	auipc	ra,0xffffc
    80005f14:	10c080e7          	jalr	268(ra) # 8000201c <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80005f18:	0304b503          	ld	a0,48(s1)
    80005f1c:	ffffc097          	auipc	ra,0xffffc
    80005f20:	100080e7          	jalr	256(ra) # 8000201c <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80005f24:	0144a783          	lw	a5,20(s1)
    80005f28:	0104a903          	lw	s2,16(s1)
    80005f2c:	0327ce63          	blt	a5,s2,80005f68 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80005f30:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80005f34:	0304b503          	ld	a0,48(s1)
    80005f38:	ffffc097          	auipc	ra,0xffffc
    80005f3c:	110080e7          	jalr	272(ra) # 80002048 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80005f40:	0284b503          	ld	a0,40(s1)
    80005f44:	ffffc097          	auipc	ra,0xffffc
    80005f48:	104080e7          	jalr	260(ra) # 80002048 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80005f4c:	00090513          	mv	a0,s2
    80005f50:	01813083          	ld	ra,24(sp)
    80005f54:	01013403          	ld	s0,16(sp)
    80005f58:	00813483          	ld	s1,8(sp)
    80005f5c:	00013903          	ld	s2,0(sp)
    80005f60:	02010113          	addi	sp,sp,32
    80005f64:	00008067          	ret
        ret = cap - head + tail;
    80005f68:	0004a703          	lw	a4,0(s1)
    80005f6c:	4127093b          	subw	s2,a4,s2
    80005f70:	00f9093b          	addw	s2,s2,a5
    80005f74:	fc1ff06f          	j	80005f34 <_ZN6Buffer6getCntEv+0x44>

0000000080005f78 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005f78:	fe010113          	addi	sp,sp,-32
    80005f7c:	00113c23          	sd	ra,24(sp)
    80005f80:	00813823          	sd	s0,16(sp)
    80005f84:	00913423          	sd	s1,8(sp)
    80005f88:	02010413          	addi	s0,sp,32
    80005f8c:	00050493          	mv	s1,a0
    putc('\n');
    80005f90:	00a00513          	li	a0,10
    80005f94:	ffffc097          	auipc	ra,0xffffc
    80005f98:	134080e7          	jalr	308(ra) # 800020c8 <_Z4putcc>
    printString("Buffer deleted!\n");
    80005f9c:	00003517          	auipc	a0,0x3
    80005fa0:	5bc50513          	addi	a0,a0,1468 # 80009558 <CONSOLE_STATUS+0x548>
    80005fa4:	ffffd097          	auipc	ra,0xffffd
    80005fa8:	918080e7          	jalr	-1768(ra) # 800028bc <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005fac:	00048513          	mv	a0,s1
    80005fb0:	00000097          	auipc	ra,0x0
    80005fb4:	f40080e7          	jalr	-192(ra) # 80005ef0 <_ZN6Buffer6getCntEv>
    80005fb8:	02a05c63          	blez	a0,80005ff0 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005fbc:	0084b783          	ld	a5,8(s1)
    80005fc0:	0104a703          	lw	a4,16(s1)
    80005fc4:	00271713          	slli	a4,a4,0x2
    80005fc8:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005fcc:	0007c503          	lbu	a0,0(a5)
    80005fd0:	ffffc097          	auipc	ra,0xffffc
    80005fd4:	0f8080e7          	jalr	248(ra) # 800020c8 <_Z4putcc>
        head = (head + 1) % cap;
    80005fd8:	0104a783          	lw	a5,16(s1)
    80005fdc:	0017879b          	addiw	a5,a5,1
    80005fe0:	0004a703          	lw	a4,0(s1)
    80005fe4:	02e7e7bb          	remw	a5,a5,a4
    80005fe8:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005fec:	fc1ff06f          	j	80005fac <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005ff0:	02100513          	li	a0,33
    80005ff4:	ffffc097          	auipc	ra,0xffffc
    80005ff8:	0d4080e7          	jalr	212(ra) # 800020c8 <_Z4putcc>
    putc('\n');
    80005ffc:	00a00513          	li	a0,10
    80006000:	ffffc097          	auipc	ra,0xffffc
    80006004:	0c8080e7          	jalr	200(ra) # 800020c8 <_Z4putcc>
    mem_free(buffer);
    80006008:	0084b503          	ld	a0,8(s1)
    8000600c:	ffffc097          	auipc	ra,0xffffc
    80006010:	e14080e7          	jalr	-492(ra) # 80001e20 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006014:	0204b503          	ld	a0,32(s1)
    80006018:	ffffc097          	auipc	ra,0xffffc
    8000601c:	fd8080e7          	jalr	-40(ra) # 80001ff0 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006020:	0184b503          	ld	a0,24(s1)
    80006024:	ffffc097          	auipc	ra,0xffffc
    80006028:	fcc080e7          	jalr	-52(ra) # 80001ff0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    8000602c:	0304b503          	ld	a0,48(s1)
    80006030:	ffffc097          	auipc	ra,0xffffc
    80006034:	fc0080e7          	jalr	-64(ra) # 80001ff0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006038:	0284b503          	ld	a0,40(s1)
    8000603c:	ffffc097          	auipc	ra,0xffffc
    80006040:	fb4080e7          	jalr	-76(ra) # 80001ff0 <_Z9sem_closeP10_semaphore>
}
    80006044:	01813083          	ld	ra,24(sp)
    80006048:	01013403          	ld	s0,16(sp)
    8000604c:	00813483          	ld	s1,8(sp)
    80006050:	02010113          	addi	sp,sp,32
    80006054:	00008067          	ret

0000000080006058 <start>:
    80006058:	ff010113          	addi	sp,sp,-16
    8000605c:	00813423          	sd	s0,8(sp)
    80006060:	01010413          	addi	s0,sp,16
    80006064:	300027f3          	csrr	a5,mstatus
    80006068:	ffffe737          	lui	a4,0xffffe
    8000606c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed85f>
    80006070:	00e7f7b3          	and	a5,a5,a4
    80006074:	00001737          	lui	a4,0x1
    80006078:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000607c:	00e7e7b3          	or	a5,a5,a4
    80006080:	30079073          	csrw	mstatus,a5
    80006084:	00000797          	auipc	a5,0x0
    80006088:	16078793          	addi	a5,a5,352 # 800061e4 <system_main>
    8000608c:	34179073          	csrw	mepc,a5
    80006090:	00000793          	li	a5,0
    80006094:	18079073          	csrw	satp,a5
    80006098:	000107b7          	lui	a5,0x10
    8000609c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800060a0:	30279073          	csrw	medeleg,a5
    800060a4:	30379073          	csrw	mideleg,a5
    800060a8:	104027f3          	csrr	a5,sie
    800060ac:	2227e793          	ori	a5,a5,546
    800060b0:	10479073          	csrw	sie,a5
    800060b4:	fff00793          	li	a5,-1
    800060b8:	00a7d793          	srli	a5,a5,0xa
    800060bc:	3b079073          	csrw	pmpaddr0,a5
    800060c0:	00f00793          	li	a5,15
    800060c4:	3a079073          	csrw	pmpcfg0,a5
    800060c8:	f14027f3          	csrr	a5,mhartid
    800060cc:	0200c737          	lui	a4,0x200c
    800060d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800060d4:	0007869b          	sext.w	a3,a5
    800060d8:	00269713          	slli	a4,a3,0x2
    800060dc:	000f4637          	lui	a2,0xf4
    800060e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800060e4:	00d70733          	add	a4,a4,a3
    800060e8:	0037979b          	slliw	a5,a5,0x3
    800060ec:	020046b7          	lui	a3,0x2004
    800060f0:	00d787b3          	add	a5,a5,a3
    800060f4:	00c585b3          	add	a1,a1,a2
    800060f8:	00371693          	slli	a3,a4,0x3
    800060fc:	0000a717          	auipc	a4,0xa
    80006100:	c4470713          	addi	a4,a4,-956 # 8000fd40 <timer_scratch>
    80006104:	00b7b023          	sd	a1,0(a5)
    80006108:	00d70733          	add	a4,a4,a3
    8000610c:	00f73c23          	sd	a5,24(a4)
    80006110:	02c73023          	sd	a2,32(a4)
    80006114:	34071073          	csrw	mscratch,a4
    80006118:	00000797          	auipc	a5,0x0
    8000611c:	6e878793          	addi	a5,a5,1768 # 80006800 <timervec>
    80006120:	30579073          	csrw	mtvec,a5
    80006124:	300027f3          	csrr	a5,mstatus
    80006128:	0087e793          	ori	a5,a5,8
    8000612c:	30079073          	csrw	mstatus,a5
    80006130:	304027f3          	csrr	a5,mie
    80006134:	0807e793          	ori	a5,a5,128
    80006138:	30479073          	csrw	mie,a5
    8000613c:	f14027f3          	csrr	a5,mhartid
    80006140:	0007879b          	sext.w	a5,a5
    80006144:	00078213          	mv	tp,a5
    80006148:	30200073          	mret
    8000614c:	00813403          	ld	s0,8(sp)
    80006150:	01010113          	addi	sp,sp,16
    80006154:	00008067          	ret

0000000080006158 <timerinit>:
    80006158:	ff010113          	addi	sp,sp,-16
    8000615c:	00813423          	sd	s0,8(sp)
    80006160:	01010413          	addi	s0,sp,16
    80006164:	f14027f3          	csrr	a5,mhartid
    80006168:	0200c737          	lui	a4,0x200c
    8000616c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006170:	0007869b          	sext.w	a3,a5
    80006174:	00269713          	slli	a4,a3,0x2
    80006178:	000f4637          	lui	a2,0xf4
    8000617c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006180:	00d70733          	add	a4,a4,a3
    80006184:	0037979b          	slliw	a5,a5,0x3
    80006188:	020046b7          	lui	a3,0x2004
    8000618c:	00d787b3          	add	a5,a5,a3
    80006190:	00c585b3          	add	a1,a1,a2
    80006194:	00371693          	slli	a3,a4,0x3
    80006198:	0000a717          	auipc	a4,0xa
    8000619c:	ba870713          	addi	a4,a4,-1112 # 8000fd40 <timer_scratch>
    800061a0:	00b7b023          	sd	a1,0(a5)
    800061a4:	00d70733          	add	a4,a4,a3
    800061a8:	00f73c23          	sd	a5,24(a4)
    800061ac:	02c73023          	sd	a2,32(a4)
    800061b0:	34071073          	csrw	mscratch,a4
    800061b4:	00000797          	auipc	a5,0x0
    800061b8:	64c78793          	addi	a5,a5,1612 # 80006800 <timervec>
    800061bc:	30579073          	csrw	mtvec,a5
    800061c0:	300027f3          	csrr	a5,mstatus
    800061c4:	0087e793          	ori	a5,a5,8
    800061c8:	30079073          	csrw	mstatus,a5
    800061cc:	304027f3          	csrr	a5,mie
    800061d0:	0807e793          	ori	a5,a5,128
    800061d4:	30479073          	csrw	mie,a5
    800061d8:	00813403          	ld	s0,8(sp)
    800061dc:	01010113          	addi	sp,sp,16
    800061e0:	00008067          	ret

00000000800061e4 <system_main>:
    800061e4:	fe010113          	addi	sp,sp,-32
    800061e8:	00813823          	sd	s0,16(sp)
    800061ec:	00913423          	sd	s1,8(sp)
    800061f0:	00113c23          	sd	ra,24(sp)
    800061f4:	02010413          	addi	s0,sp,32
    800061f8:	00000097          	auipc	ra,0x0
    800061fc:	0c4080e7          	jalr	196(ra) # 800062bc <cpuid>
    80006200:	00006497          	auipc	s1,0x6
    80006204:	8d048493          	addi	s1,s1,-1840 # 8000bad0 <started>
    80006208:	02050263          	beqz	a0,8000622c <system_main+0x48>
    8000620c:	0004a783          	lw	a5,0(s1)
    80006210:	0007879b          	sext.w	a5,a5
    80006214:	fe078ce3          	beqz	a5,8000620c <system_main+0x28>
    80006218:	0ff0000f          	fence
    8000621c:	00003517          	auipc	a0,0x3
    80006220:	46450513          	addi	a0,a0,1124 # 80009680 <CONSOLE_STATUS+0x670>
    80006224:	00001097          	auipc	ra,0x1
    80006228:	a78080e7          	jalr	-1416(ra) # 80006c9c <panic>
    8000622c:	00001097          	auipc	ra,0x1
    80006230:	9cc080e7          	jalr	-1588(ra) # 80006bf8 <consoleinit>
    80006234:	00001097          	auipc	ra,0x1
    80006238:	158080e7          	jalr	344(ra) # 8000738c <printfinit>
    8000623c:	00003517          	auipc	a0,0x3
    80006240:	10c50513          	addi	a0,a0,268 # 80009348 <CONSOLE_STATUS+0x338>
    80006244:	00001097          	auipc	ra,0x1
    80006248:	ab4080e7          	jalr	-1356(ra) # 80006cf8 <__printf>
    8000624c:	00003517          	auipc	a0,0x3
    80006250:	40450513          	addi	a0,a0,1028 # 80009650 <CONSOLE_STATUS+0x640>
    80006254:	00001097          	auipc	ra,0x1
    80006258:	aa4080e7          	jalr	-1372(ra) # 80006cf8 <__printf>
    8000625c:	00003517          	auipc	a0,0x3
    80006260:	0ec50513          	addi	a0,a0,236 # 80009348 <CONSOLE_STATUS+0x338>
    80006264:	00001097          	auipc	ra,0x1
    80006268:	a94080e7          	jalr	-1388(ra) # 80006cf8 <__printf>
    8000626c:	00001097          	auipc	ra,0x1
    80006270:	4ac080e7          	jalr	1196(ra) # 80007718 <kinit>
    80006274:	00000097          	auipc	ra,0x0
    80006278:	148080e7          	jalr	328(ra) # 800063bc <trapinit>
    8000627c:	00000097          	auipc	ra,0x0
    80006280:	16c080e7          	jalr	364(ra) # 800063e8 <trapinithart>
    80006284:	00000097          	auipc	ra,0x0
    80006288:	5bc080e7          	jalr	1468(ra) # 80006840 <plicinit>
    8000628c:	00000097          	auipc	ra,0x0
    80006290:	5dc080e7          	jalr	1500(ra) # 80006868 <plicinithart>
    80006294:	00000097          	auipc	ra,0x0
    80006298:	078080e7          	jalr	120(ra) # 8000630c <userinit>
    8000629c:	0ff0000f          	fence
    800062a0:	00100793          	li	a5,1
    800062a4:	00003517          	auipc	a0,0x3
    800062a8:	3c450513          	addi	a0,a0,964 # 80009668 <CONSOLE_STATUS+0x658>
    800062ac:	00f4a023          	sw	a5,0(s1)
    800062b0:	00001097          	auipc	ra,0x1
    800062b4:	a48080e7          	jalr	-1464(ra) # 80006cf8 <__printf>
    800062b8:	0000006f          	j	800062b8 <system_main+0xd4>

00000000800062bc <cpuid>:
    800062bc:	ff010113          	addi	sp,sp,-16
    800062c0:	00813423          	sd	s0,8(sp)
    800062c4:	01010413          	addi	s0,sp,16
    800062c8:	00020513          	mv	a0,tp
    800062cc:	00813403          	ld	s0,8(sp)
    800062d0:	0005051b          	sext.w	a0,a0
    800062d4:	01010113          	addi	sp,sp,16
    800062d8:	00008067          	ret

00000000800062dc <mycpu>:
    800062dc:	ff010113          	addi	sp,sp,-16
    800062e0:	00813423          	sd	s0,8(sp)
    800062e4:	01010413          	addi	s0,sp,16
    800062e8:	00020793          	mv	a5,tp
    800062ec:	00813403          	ld	s0,8(sp)
    800062f0:	0007879b          	sext.w	a5,a5
    800062f4:	00779793          	slli	a5,a5,0x7
    800062f8:	0000b517          	auipc	a0,0xb
    800062fc:	a7850513          	addi	a0,a0,-1416 # 80010d70 <cpus>
    80006300:	00f50533          	add	a0,a0,a5
    80006304:	01010113          	addi	sp,sp,16
    80006308:	00008067          	ret

000000008000630c <userinit>:
    8000630c:	ff010113          	addi	sp,sp,-16
    80006310:	00813423          	sd	s0,8(sp)
    80006314:	01010413          	addi	s0,sp,16
    80006318:	00813403          	ld	s0,8(sp)
    8000631c:	01010113          	addi	sp,sp,16
    80006320:	ffffd317          	auipc	t1,0xffffd
    80006324:	a8030067          	jr	-1408(t1) # 80002da0 <main>

0000000080006328 <either_copyout>:
    80006328:	ff010113          	addi	sp,sp,-16
    8000632c:	00813023          	sd	s0,0(sp)
    80006330:	00113423          	sd	ra,8(sp)
    80006334:	01010413          	addi	s0,sp,16
    80006338:	02051663          	bnez	a0,80006364 <either_copyout+0x3c>
    8000633c:	00058513          	mv	a0,a1
    80006340:	00060593          	mv	a1,a2
    80006344:	0006861b          	sext.w	a2,a3
    80006348:	00002097          	auipc	ra,0x2
    8000634c:	c5c080e7          	jalr	-932(ra) # 80007fa4 <__memmove>
    80006350:	00813083          	ld	ra,8(sp)
    80006354:	00013403          	ld	s0,0(sp)
    80006358:	00000513          	li	a0,0
    8000635c:	01010113          	addi	sp,sp,16
    80006360:	00008067          	ret
    80006364:	00003517          	auipc	a0,0x3
    80006368:	34450513          	addi	a0,a0,836 # 800096a8 <CONSOLE_STATUS+0x698>
    8000636c:	00001097          	auipc	ra,0x1
    80006370:	930080e7          	jalr	-1744(ra) # 80006c9c <panic>

0000000080006374 <either_copyin>:
    80006374:	ff010113          	addi	sp,sp,-16
    80006378:	00813023          	sd	s0,0(sp)
    8000637c:	00113423          	sd	ra,8(sp)
    80006380:	01010413          	addi	s0,sp,16
    80006384:	02059463          	bnez	a1,800063ac <either_copyin+0x38>
    80006388:	00060593          	mv	a1,a2
    8000638c:	0006861b          	sext.w	a2,a3
    80006390:	00002097          	auipc	ra,0x2
    80006394:	c14080e7          	jalr	-1004(ra) # 80007fa4 <__memmove>
    80006398:	00813083          	ld	ra,8(sp)
    8000639c:	00013403          	ld	s0,0(sp)
    800063a0:	00000513          	li	a0,0
    800063a4:	01010113          	addi	sp,sp,16
    800063a8:	00008067          	ret
    800063ac:	00003517          	auipc	a0,0x3
    800063b0:	32450513          	addi	a0,a0,804 # 800096d0 <CONSOLE_STATUS+0x6c0>
    800063b4:	00001097          	auipc	ra,0x1
    800063b8:	8e8080e7          	jalr	-1816(ra) # 80006c9c <panic>

00000000800063bc <trapinit>:
    800063bc:	ff010113          	addi	sp,sp,-16
    800063c0:	00813423          	sd	s0,8(sp)
    800063c4:	01010413          	addi	s0,sp,16
    800063c8:	00813403          	ld	s0,8(sp)
    800063cc:	00003597          	auipc	a1,0x3
    800063d0:	32c58593          	addi	a1,a1,812 # 800096f8 <CONSOLE_STATUS+0x6e8>
    800063d4:	0000b517          	auipc	a0,0xb
    800063d8:	a1c50513          	addi	a0,a0,-1508 # 80010df0 <tickslock>
    800063dc:	01010113          	addi	sp,sp,16
    800063e0:	00001317          	auipc	t1,0x1
    800063e4:	5c830067          	jr	1480(t1) # 800079a8 <initlock>

00000000800063e8 <trapinithart>:
    800063e8:	ff010113          	addi	sp,sp,-16
    800063ec:	00813423          	sd	s0,8(sp)
    800063f0:	01010413          	addi	s0,sp,16
    800063f4:	00000797          	auipc	a5,0x0
    800063f8:	2fc78793          	addi	a5,a5,764 # 800066f0 <kernelvec>
    800063fc:	10579073          	csrw	stvec,a5
    80006400:	00813403          	ld	s0,8(sp)
    80006404:	01010113          	addi	sp,sp,16
    80006408:	00008067          	ret

000000008000640c <usertrap>:
    8000640c:	ff010113          	addi	sp,sp,-16
    80006410:	00813423          	sd	s0,8(sp)
    80006414:	01010413          	addi	s0,sp,16
    80006418:	00813403          	ld	s0,8(sp)
    8000641c:	01010113          	addi	sp,sp,16
    80006420:	00008067          	ret

0000000080006424 <usertrapret>:
    80006424:	ff010113          	addi	sp,sp,-16
    80006428:	00813423          	sd	s0,8(sp)
    8000642c:	01010413          	addi	s0,sp,16
    80006430:	00813403          	ld	s0,8(sp)
    80006434:	01010113          	addi	sp,sp,16
    80006438:	00008067          	ret

000000008000643c <kerneltrap>:
    8000643c:	fe010113          	addi	sp,sp,-32
    80006440:	00813823          	sd	s0,16(sp)
    80006444:	00113c23          	sd	ra,24(sp)
    80006448:	00913423          	sd	s1,8(sp)
    8000644c:	02010413          	addi	s0,sp,32
    80006450:	142025f3          	csrr	a1,scause
    80006454:	100027f3          	csrr	a5,sstatus
    80006458:	0027f793          	andi	a5,a5,2
    8000645c:	10079c63          	bnez	a5,80006574 <kerneltrap+0x138>
    80006460:	142027f3          	csrr	a5,scause
    80006464:	0207ce63          	bltz	a5,800064a0 <kerneltrap+0x64>
    80006468:	00003517          	auipc	a0,0x3
    8000646c:	2d850513          	addi	a0,a0,728 # 80009740 <CONSOLE_STATUS+0x730>
    80006470:	00001097          	auipc	ra,0x1
    80006474:	888080e7          	jalr	-1912(ra) # 80006cf8 <__printf>
    80006478:	141025f3          	csrr	a1,sepc
    8000647c:	14302673          	csrr	a2,stval
    80006480:	00003517          	auipc	a0,0x3
    80006484:	2d050513          	addi	a0,a0,720 # 80009750 <CONSOLE_STATUS+0x740>
    80006488:	00001097          	auipc	ra,0x1
    8000648c:	870080e7          	jalr	-1936(ra) # 80006cf8 <__printf>
    80006490:	00003517          	auipc	a0,0x3
    80006494:	2d850513          	addi	a0,a0,728 # 80009768 <CONSOLE_STATUS+0x758>
    80006498:	00001097          	auipc	ra,0x1
    8000649c:	804080e7          	jalr	-2044(ra) # 80006c9c <panic>
    800064a0:	0ff7f713          	andi	a4,a5,255
    800064a4:	00900693          	li	a3,9
    800064a8:	04d70063          	beq	a4,a3,800064e8 <kerneltrap+0xac>
    800064ac:	fff00713          	li	a4,-1
    800064b0:	03f71713          	slli	a4,a4,0x3f
    800064b4:	00170713          	addi	a4,a4,1
    800064b8:	fae798e3          	bne	a5,a4,80006468 <kerneltrap+0x2c>
    800064bc:	00000097          	auipc	ra,0x0
    800064c0:	e00080e7          	jalr	-512(ra) # 800062bc <cpuid>
    800064c4:	06050663          	beqz	a0,80006530 <kerneltrap+0xf4>
    800064c8:	144027f3          	csrr	a5,sip
    800064cc:	ffd7f793          	andi	a5,a5,-3
    800064d0:	14479073          	csrw	sip,a5
    800064d4:	01813083          	ld	ra,24(sp)
    800064d8:	01013403          	ld	s0,16(sp)
    800064dc:	00813483          	ld	s1,8(sp)
    800064e0:	02010113          	addi	sp,sp,32
    800064e4:	00008067          	ret
    800064e8:	00000097          	auipc	ra,0x0
    800064ec:	3cc080e7          	jalr	972(ra) # 800068b4 <plic_claim>
    800064f0:	00a00793          	li	a5,10
    800064f4:	00050493          	mv	s1,a0
    800064f8:	06f50863          	beq	a0,a5,80006568 <kerneltrap+0x12c>
    800064fc:	fc050ce3          	beqz	a0,800064d4 <kerneltrap+0x98>
    80006500:	00050593          	mv	a1,a0
    80006504:	00003517          	auipc	a0,0x3
    80006508:	21c50513          	addi	a0,a0,540 # 80009720 <CONSOLE_STATUS+0x710>
    8000650c:	00000097          	auipc	ra,0x0
    80006510:	7ec080e7          	jalr	2028(ra) # 80006cf8 <__printf>
    80006514:	01013403          	ld	s0,16(sp)
    80006518:	01813083          	ld	ra,24(sp)
    8000651c:	00048513          	mv	a0,s1
    80006520:	00813483          	ld	s1,8(sp)
    80006524:	02010113          	addi	sp,sp,32
    80006528:	00000317          	auipc	t1,0x0
    8000652c:	3c430067          	jr	964(t1) # 800068ec <plic_complete>
    80006530:	0000b517          	auipc	a0,0xb
    80006534:	8c050513          	addi	a0,a0,-1856 # 80010df0 <tickslock>
    80006538:	00001097          	auipc	ra,0x1
    8000653c:	494080e7          	jalr	1172(ra) # 800079cc <acquire>
    80006540:	00005717          	auipc	a4,0x5
    80006544:	59470713          	addi	a4,a4,1428 # 8000bad4 <ticks>
    80006548:	00072783          	lw	a5,0(a4)
    8000654c:	0000b517          	auipc	a0,0xb
    80006550:	8a450513          	addi	a0,a0,-1884 # 80010df0 <tickslock>
    80006554:	0017879b          	addiw	a5,a5,1
    80006558:	00f72023          	sw	a5,0(a4)
    8000655c:	00001097          	auipc	ra,0x1
    80006560:	53c080e7          	jalr	1340(ra) # 80007a98 <release>
    80006564:	f65ff06f          	j	800064c8 <kerneltrap+0x8c>
    80006568:	00001097          	auipc	ra,0x1
    8000656c:	098080e7          	jalr	152(ra) # 80007600 <uartintr>
    80006570:	fa5ff06f          	j	80006514 <kerneltrap+0xd8>
    80006574:	00003517          	auipc	a0,0x3
    80006578:	18c50513          	addi	a0,a0,396 # 80009700 <CONSOLE_STATUS+0x6f0>
    8000657c:	00000097          	auipc	ra,0x0
    80006580:	720080e7          	jalr	1824(ra) # 80006c9c <panic>

0000000080006584 <clockintr>:
    80006584:	fe010113          	addi	sp,sp,-32
    80006588:	00813823          	sd	s0,16(sp)
    8000658c:	00913423          	sd	s1,8(sp)
    80006590:	00113c23          	sd	ra,24(sp)
    80006594:	02010413          	addi	s0,sp,32
    80006598:	0000b497          	auipc	s1,0xb
    8000659c:	85848493          	addi	s1,s1,-1960 # 80010df0 <tickslock>
    800065a0:	00048513          	mv	a0,s1
    800065a4:	00001097          	auipc	ra,0x1
    800065a8:	428080e7          	jalr	1064(ra) # 800079cc <acquire>
    800065ac:	00005717          	auipc	a4,0x5
    800065b0:	52870713          	addi	a4,a4,1320 # 8000bad4 <ticks>
    800065b4:	00072783          	lw	a5,0(a4)
    800065b8:	01013403          	ld	s0,16(sp)
    800065bc:	01813083          	ld	ra,24(sp)
    800065c0:	00048513          	mv	a0,s1
    800065c4:	0017879b          	addiw	a5,a5,1
    800065c8:	00813483          	ld	s1,8(sp)
    800065cc:	00f72023          	sw	a5,0(a4)
    800065d0:	02010113          	addi	sp,sp,32
    800065d4:	00001317          	auipc	t1,0x1
    800065d8:	4c430067          	jr	1220(t1) # 80007a98 <release>

00000000800065dc <devintr>:
    800065dc:	142027f3          	csrr	a5,scause
    800065e0:	00000513          	li	a0,0
    800065e4:	0007c463          	bltz	a5,800065ec <devintr+0x10>
    800065e8:	00008067          	ret
    800065ec:	fe010113          	addi	sp,sp,-32
    800065f0:	00813823          	sd	s0,16(sp)
    800065f4:	00113c23          	sd	ra,24(sp)
    800065f8:	00913423          	sd	s1,8(sp)
    800065fc:	02010413          	addi	s0,sp,32
    80006600:	0ff7f713          	andi	a4,a5,255
    80006604:	00900693          	li	a3,9
    80006608:	04d70c63          	beq	a4,a3,80006660 <devintr+0x84>
    8000660c:	fff00713          	li	a4,-1
    80006610:	03f71713          	slli	a4,a4,0x3f
    80006614:	00170713          	addi	a4,a4,1
    80006618:	00e78c63          	beq	a5,a4,80006630 <devintr+0x54>
    8000661c:	01813083          	ld	ra,24(sp)
    80006620:	01013403          	ld	s0,16(sp)
    80006624:	00813483          	ld	s1,8(sp)
    80006628:	02010113          	addi	sp,sp,32
    8000662c:	00008067          	ret
    80006630:	00000097          	auipc	ra,0x0
    80006634:	c8c080e7          	jalr	-884(ra) # 800062bc <cpuid>
    80006638:	06050663          	beqz	a0,800066a4 <devintr+0xc8>
    8000663c:	144027f3          	csrr	a5,sip
    80006640:	ffd7f793          	andi	a5,a5,-3
    80006644:	14479073          	csrw	sip,a5
    80006648:	01813083          	ld	ra,24(sp)
    8000664c:	01013403          	ld	s0,16(sp)
    80006650:	00813483          	ld	s1,8(sp)
    80006654:	00200513          	li	a0,2
    80006658:	02010113          	addi	sp,sp,32
    8000665c:	00008067          	ret
    80006660:	00000097          	auipc	ra,0x0
    80006664:	254080e7          	jalr	596(ra) # 800068b4 <plic_claim>
    80006668:	00a00793          	li	a5,10
    8000666c:	00050493          	mv	s1,a0
    80006670:	06f50663          	beq	a0,a5,800066dc <devintr+0x100>
    80006674:	00100513          	li	a0,1
    80006678:	fa0482e3          	beqz	s1,8000661c <devintr+0x40>
    8000667c:	00048593          	mv	a1,s1
    80006680:	00003517          	auipc	a0,0x3
    80006684:	0a050513          	addi	a0,a0,160 # 80009720 <CONSOLE_STATUS+0x710>
    80006688:	00000097          	auipc	ra,0x0
    8000668c:	670080e7          	jalr	1648(ra) # 80006cf8 <__printf>
    80006690:	00048513          	mv	a0,s1
    80006694:	00000097          	auipc	ra,0x0
    80006698:	258080e7          	jalr	600(ra) # 800068ec <plic_complete>
    8000669c:	00100513          	li	a0,1
    800066a0:	f7dff06f          	j	8000661c <devintr+0x40>
    800066a4:	0000a517          	auipc	a0,0xa
    800066a8:	74c50513          	addi	a0,a0,1868 # 80010df0 <tickslock>
    800066ac:	00001097          	auipc	ra,0x1
    800066b0:	320080e7          	jalr	800(ra) # 800079cc <acquire>
    800066b4:	00005717          	auipc	a4,0x5
    800066b8:	42070713          	addi	a4,a4,1056 # 8000bad4 <ticks>
    800066bc:	00072783          	lw	a5,0(a4)
    800066c0:	0000a517          	auipc	a0,0xa
    800066c4:	73050513          	addi	a0,a0,1840 # 80010df0 <tickslock>
    800066c8:	0017879b          	addiw	a5,a5,1
    800066cc:	00f72023          	sw	a5,0(a4)
    800066d0:	00001097          	auipc	ra,0x1
    800066d4:	3c8080e7          	jalr	968(ra) # 80007a98 <release>
    800066d8:	f65ff06f          	j	8000663c <devintr+0x60>
    800066dc:	00001097          	auipc	ra,0x1
    800066e0:	f24080e7          	jalr	-220(ra) # 80007600 <uartintr>
    800066e4:	fadff06f          	j	80006690 <devintr+0xb4>
	...

00000000800066f0 <kernelvec>:
    800066f0:	f0010113          	addi	sp,sp,-256
    800066f4:	00113023          	sd	ra,0(sp)
    800066f8:	00213423          	sd	sp,8(sp)
    800066fc:	00313823          	sd	gp,16(sp)
    80006700:	00413c23          	sd	tp,24(sp)
    80006704:	02513023          	sd	t0,32(sp)
    80006708:	02613423          	sd	t1,40(sp)
    8000670c:	02713823          	sd	t2,48(sp)
    80006710:	02813c23          	sd	s0,56(sp)
    80006714:	04913023          	sd	s1,64(sp)
    80006718:	04a13423          	sd	a0,72(sp)
    8000671c:	04b13823          	sd	a1,80(sp)
    80006720:	04c13c23          	sd	a2,88(sp)
    80006724:	06d13023          	sd	a3,96(sp)
    80006728:	06e13423          	sd	a4,104(sp)
    8000672c:	06f13823          	sd	a5,112(sp)
    80006730:	07013c23          	sd	a6,120(sp)
    80006734:	09113023          	sd	a7,128(sp)
    80006738:	09213423          	sd	s2,136(sp)
    8000673c:	09313823          	sd	s3,144(sp)
    80006740:	09413c23          	sd	s4,152(sp)
    80006744:	0b513023          	sd	s5,160(sp)
    80006748:	0b613423          	sd	s6,168(sp)
    8000674c:	0b713823          	sd	s7,176(sp)
    80006750:	0b813c23          	sd	s8,184(sp)
    80006754:	0d913023          	sd	s9,192(sp)
    80006758:	0da13423          	sd	s10,200(sp)
    8000675c:	0db13823          	sd	s11,208(sp)
    80006760:	0dc13c23          	sd	t3,216(sp)
    80006764:	0fd13023          	sd	t4,224(sp)
    80006768:	0fe13423          	sd	t5,232(sp)
    8000676c:	0ff13823          	sd	t6,240(sp)
    80006770:	ccdff0ef          	jal	ra,8000643c <kerneltrap>
    80006774:	00013083          	ld	ra,0(sp)
    80006778:	00813103          	ld	sp,8(sp)
    8000677c:	01013183          	ld	gp,16(sp)
    80006780:	02013283          	ld	t0,32(sp)
    80006784:	02813303          	ld	t1,40(sp)
    80006788:	03013383          	ld	t2,48(sp)
    8000678c:	03813403          	ld	s0,56(sp)
    80006790:	04013483          	ld	s1,64(sp)
    80006794:	04813503          	ld	a0,72(sp)
    80006798:	05013583          	ld	a1,80(sp)
    8000679c:	05813603          	ld	a2,88(sp)
    800067a0:	06013683          	ld	a3,96(sp)
    800067a4:	06813703          	ld	a4,104(sp)
    800067a8:	07013783          	ld	a5,112(sp)
    800067ac:	07813803          	ld	a6,120(sp)
    800067b0:	08013883          	ld	a7,128(sp)
    800067b4:	08813903          	ld	s2,136(sp)
    800067b8:	09013983          	ld	s3,144(sp)
    800067bc:	09813a03          	ld	s4,152(sp)
    800067c0:	0a013a83          	ld	s5,160(sp)
    800067c4:	0a813b03          	ld	s6,168(sp)
    800067c8:	0b013b83          	ld	s7,176(sp)
    800067cc:	0b813c03          	ld	s8,184(sp)
    800067d0:	0c013c83          	ld	s9,192(sp)
    800067d4:	0c813d03          	ld	s10,200(sp)
    800067d8:	0d013d83          	ld	s11,208(sp)
    800067dc:	0d813e03          	ld	t3,216(sp)
    800067e0:	0e013e83          	ld	t4,224(sp)
    800067e4:	0e813f03          	ld	t5,232(sp)
    800067e8:	0f013f83          	ld	t6,240(sp)
    800067ec:	10010113          	addi	sp,sp,256
    800067f0:	10200073          	sret
    800067f4:	00000013          	nop
    800067f8:	00000013          	nop
    800067fc:	00000013          	nop

0000000080006800 <timervec>:
    80006800:	34051573          	csrrw	a0,mscratch,a0
    80006804:	00b53023          	sd	a1,0(a0)
    80006808:	00c53423          	sd	a2,8(a0)
    8000680c:	00d53823          	sd	a3,16(a0)
    80006810:	01853583          	ld	a1,24(a0)
    80006814:	02053603          	ld	a2,32(a0)
    80006818:	0005b683          	ld	a3,0(a1)
    8000681c:	00c686b3          	add	a3,a3,a2
    80006820:	00d5b023          	sd	a3,0(a1)
    80006824:	00200593          	li	a1,2
    80006828:	14459073          	csrw	sip,a1
    8000682c:	01053683          	ld	a3,16(a0)
    80006830:	00853603          	ld	a2,8(a0)
    80006834:	00053583          	ld	a1,0(a0)
    80006838:	34051573          	csrrw	a0,mscratch,a0
    8000683c:	30200073          	mret

0000000080006840 <plicinit>:
    80006840:	ff010113          	addi	sp,sp,-16
    80006844:	00813423          	sd	s0,8(sp)
    80006848:	01010413          	addi	s0,sp,16
    8000684c:	00813403          	ld	s0,8(sp)
    80006850:	0c0007b7          	lui	a5,0xc000
    80006854:	00100713          	li	a4,1
    80006858:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000685c:	00e7a223          	sw	a4,4(a5)
    80006860:	01010113          	addi	sp,sp,16
    80006864:	00008067          	ret

0000000080006868 <plicinithart>:
    80006868:	ff010113          	addi	sp,sp,-16
    8000686c:	00813023          	sd	s0,0(sp)
    80006870:	00113423          	sd	ra,8(sp)
    80006874:	01010413          	addi	s0,sp,16
    80006878:	00000097          	auipc	ra,0x0
    8000687c:	a44080e7          	jalr	-1468(ra) # 800062bc <cpuid>
    80006880:	0085171b          	slliw	a4,a0,0x8
    80006884:	0c0027b7          	lui	a5,0xc002
    80006888:	00e787b3          	add	a5,a5,a4
    8000688c:	40200713          	li	a4,1026
    80006890:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006894:	00813083          	ld	ra,8(sp)
    80006898:	00013403          	ld	s0,0(sp)
    8000689c:	00d5151b          	slliw	a0,a0,0xd
    800068a0:	0c2017b7          	lui	a5,0xc201
    800068a4:	00a78533          	add	a0,a5,a0
    800068a8:	00052023          	sw	zero,0(a0)
    800068ac:	01010113          	addi	sp,sp,16
    800068b0:	00008067          	ret

00000000800068b4 <plic_claim>:
    800068b4:	ff010113          	addi	sp,sp,-16
    800068b8:	00813023          	sd	s0,0(sp)
    800068bc:	00113423          	sd	ra,8(sp)
    800068c0:	01010413          	addi	s0,sp,16
    800068c4:	00000097          	auipc	ra,0x0
    800068c8:	9f8080e7          	jalr	-1544(ra) # 800062bc <cpuid>
    800068cc:	00813083          	ld	ra,8(sp)
    800068d0:	00013403          	ld	s0,0(sp)
    800068d4:	00d5151b          	slliw	a0,a0,0xd
    800068d8:	0c2017b7          	lui	a5,0xc201
    800068dc:	00a78533          	add	a0,a5,a0
    800068e0:	00452503          	lw	a0,4(a0)
    800068e4:	01010113          	addi	sp,sp,16
    800068e8:	00008067          	ret

00000000800068ec <plic_complete>:
    800068ec:	fe010113          	addi	sp,sp,-32
    800068f0:	00813823          	sd	s0,16(sp)
    800068f4:	00913423          	sd	s1,8(sp)
    800068f8:	00113c23          	sd	ra,24(sp)
    800068fc:	02010413          	addi	s0,sp,32
    80006900:	00050493          	mv	s1,a0
    80006904:	00000097          	auipc	ra,0x0
    80006908:	9b8080e7          	jalr	-1608(ra) # 800062bc <cpuid>
    8000690c:	01813083          	ld	ra,24(sp)
    80006910:	01013403          	ld	s0,16(sp)
    80006914:	00d5179b          	slliw	a5,a0,0xd
    80006918:	0c201737          	lui	a4,0xc201
    8000691c:	00f707b3          	add	a5,a4,a5
    80006920:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006924:	00813483          	ld	s1,8(sp)
    80006928:	02010113          	addi	sp,sp,32
    8000692c:	00008067          	ret

0000000080006930 <consolewrite>:
    80006930:	fb010113          	addi	sp,sp,-80
    80006934:	04813023          	sd	s0,64(sp)
    80006938:	04113423          	sd	ra,72(sp)
    8000693c:	02913c23          	sd	s1,56(sp)
    80006940:	03213823          	sd	s2,48(sp)
    80006944:	03313423          	sd	s3,40(sp)
    80006948:	03413023          	sd	s4,32(sp)
    8000694c:	01513c23          	sd	s5,24(sp)
    80006950:	05010413          	addi	s0,sp,80
    80006954:	06c05c63          	blez	a2,800069cc <consolewrite+0x9c>
    80006958:	00060993          	mv	s3,a2
    8000695c:	00050a13          	mv	s4,a0
    80006960:	00058493          	mv	s1,a1
    80006964:	00000913          	li	s2,0
    80006968:	fff00a93          	li	s5,-1
    8000696c:	01c0006f          	j	80006988 <consolewrite+0x58>
    80006970:	fbf44503          	lbu	a0,-65(s0)
    80006974:	0019091b          	addiw	s2,s2,1
    80006978:	00148493          	addi	s1,s1,1
    8000697c:	00001097          	auipc	ra,0x1
    80006980:	a9c080e7          	jalr	-1380(ra) # 80007418 <uartputc>
    80006984:	03298063          	beq	s3,s2,800069a4 <consolewrite+0x74>
    80006988:	00048613          	mv	a2,s1
    8000698c:	00100693          	li	a3,1
    80006990:	000a0593          	mv	a1,s4
    80006994:	fbf40513          	addi	a0,s0,-65
    80006998:	00000097          	auipc	ra,0x0
    8000699c:	9dc080e7          	jalr	-1572(ra) # 80006374 <either_copyin>
    800069a0:	fd5518e3          	bne	a0,s5,80006970 <consolewrite+0x40>
    800069a4:	04813083          	ld	ra,72(sp)
    800069a8:	04013403          	ld	s0,64(sp)
    800069ac:	03813483          	ld	s1,56(sp)
    800069b0:	02813983          	ld	s3,40(sp)
    800069b4:	02013a03          	ld	s4,32(sp)
    800069b8:	01813a83          	ld	s5,24(sp)
    800069bc:	00090513          	mv	a0,s2
    800069c0:	03013903          	ld	s2,48(sp)
    800069c4:	05010113          	addi	sp,sp,80
    800069c8:	00008067          	ret
    800069cc:	00000913          	li	s2,0
    800069d0:	fd5ff06f          	j	800069a4 <consolewrite+0x74>

00000000800069d4 <consoleread>:
    800069d4:	f9010113          	addi	sp,sp,-112
    800069d8:	06813023          	sd	s0,96(sp)
    800069dc:	04913c23          	sd	s1,88(sp)
    800069e0:	05213823          	sd	s2,80(sp)
    800069e4:	05313423          	sd	s3,72(sp)
    800069e8:	05413023          	sd	s4,64(sp)
    800069ec:	03513c23          	sd	s5,56(sp)
    800069f0:	03613823          	sd	s6,48(sp)
    800069f4:	03713423          	sd	s7,40(sp)
    800069f8:	03813023          	sd	s8,32(sp)
    800069fc:	06113423          	sd	ra,104(sp)
    80006a00:	01913c23          	sd	s9,24(sp)
    80006a04:	07010413          	addi	s0,sp,112
    80006a08:	00060b93          	mv	s7,a2
    80006a0c:	00050913          	mv	s2,a0
    80006a10:	00058c13          	mv	s8,a1
    80006a14:	00060b1b          	sext.w	s6,a2
    80006a18:	0000a497          	auipc	s1,0xa
    80006a1c:	40048493          	addi	s1,s1,1024 # 80010e18 <cons>
    80006a20:	00400993          	li	s3,4
    80006a24:	fff00a13          	li	s4,-1
    80006a28:	00a00a93          	li	s5,10
    80006a2c:	05705e63          	blez	s7,80006a88 <consoleread+0xb4>
    80006a30:	09c4a703          	lw	a4,156(s1)
    80006a34:	0984a783          	lw	a5,152(s1)
    80006a38:	0007071b          	sext.w	a4,a4
    80006a3c:	08e78463          	beq	a5,a4,80006ac4 <consoleread+0xf0>
    80006a40:	07f7f713          	andi	a4,a5,127
    80006a44:	00e48733          	add	a4,s1,a4
    80006a48:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006a4c:	0017869b          	addiw	a3,a5,1
    80006a50:	08d4ac23          	sw	a3,152(s1)
    80006a54:	00070c9b          	sext.w	s9,a4
    80006a58:	0b370663          	beq	a4,s3,80006b04 <consoleread+0x130>
    80006a5c:	00100693          	li	a3,1
    80006a60:	f9f40613          	addi	a2,s0,-97
    80006a64:	000c0593          	mv	a1,s8
    80006a68:	00090513          	mv	a0,s2
    80006a6c:	f8e40fa3          	sb	a4,-97(s0)
    80006a70:	00000097          	auipc	ra,0x0
    80006a74:	8b8080e7          	jalr	-1864(ra) # 80006328 <either_copyout>
    80006a78:	01450863          	beq	a0,s4,80006a88 <consoleread+0xb4>
    80006a7c:	001c0c13          	addi	s8,s8,1
    80006a80:	fffb8b9b          	addiw	s7,s7,-1
    80006a84:	fb5c94e3          	bne	s9,s5,80006a2c <consoleread+0x58>
    80006a88:	000b851b          	sext.w	a0,s7
    80006a8c:	06813083          	ld	ra,104(sp)
    80006a90:	06013403          	ld	s0,96(sp)
    80006a94:	05813483          	ld	s1,88(sp)
    80006a98:	05013903          	ld	s2,80(sp)
    80006a9c:	04813983          	ld	s3,72(sp)
    80006aa0:	04013a03          	ld	s4,64(sp)
    80006aa4:	03813a83          	ld	s5,56(sp)
    80006aa8:	02813b83          	ld	s7,40(sp)
    80006aac:	02013c03          	ld	s8,32(sp)
    80006ab0:	01813c83          	ld	s9,24(sp)
    80006ab4:	40ab053b          	subw	a0,s6,a0
    80006ab8:	03013b03          	ld	s6,48(sp)
    80006abc:	07010113          	addi	sp,sp,112
    80006ac0:	00008067          	ret
    80006ac4:	00001097          	auipc	ra,0x1
    80006ac8:	1d8080e7          	jalr	472(ra) # 80007c9c <push_on>
    80006acc:	0984a703          	lw	a4,152(s1)
    80006ad0:	09c4a783          	lw	a5,156(s1)
    80006ad4:	0007879b          	sext.w	a5,a5
    80006ad8:	fef70ce3          	beq	a4,a5,80006ad0 <consoleread+0xfc>
    80006adc:	00001097          	auipc	ra,0x1
    80006ae0:	234080e7          	jalr	564(ra) # 80007d10 <pop_on>
    80006ae4:	0984a783          	lw	a5,152(s1)
    80006ae8:	07f7f713          	andi	a4,a5,127
    80006aec:	00e48733          	add	a4,s1,a4
    80006af0:	01874703          	lbu	a4,24(a4)
    80006af4:	0017869b          	addiw	a3,a5,1
    80006af8:	08d4ac23          	sw	a3,152(s1)
    80006afc:	00070c9b          	sext.w	s9,a4
    80006b00:	f5371ee3          	bne	a4,s3,80006a5c <consoleread+0x88>
    80006b04:	000b851b          	sext.w	a0,s7
    80006b08:	f96bf2e3          	bgeu	s7,s6,80006a8c <consoleread+0xb8>
    80006b0c:	08f4ac23          	sw	a5,152(s1)
    80006b10:	f7dff06f          	j	80006a8c <consoleread+0xb8>

0000000080006b14 <consputc>:
    80006b14:	10000793          	li	a5,256
    80006b18:	00f50663          	beq	a0,a5,80006b24 <consputc+0x10>
    80006b1c:	00001317          	auipc	t1,0x1
    80006b20:	9f430067          	jr	-1548(t1) # 80007510 <uartputc_sync>
    80006b24:	ff010113          	addi	sp,sp,-16
    80006b28:	00113423          	sd	ra,8(sp)
    80006b2c:	00813023          	sd	s0,0(sp)
    80006b30:	01010413          	addi	s0,sp,16
    80006b34:	00800513          	li	a0,8
    80006b38:	00001097          	auipc	ra,0x1
    80006b3c:	9d8080e7          	jalr	-1576(ra) # 80007510 <uartputc_sync>
    80006b40:	02000513          	li	a0,32
    80006b44:	00001097          	auipc	ra,0x1
    80006b48:	9cc080e7          	jalr	-1588(ra) # 80007510 <uartputc_sync>
    80006b4c:	00013403          	ld	s0,0(sp)
    80006b50:	00813083          	ld	ra,8(sp)
    80006b54:	00800513          	li	a0,8
    80006b58:	01010113          	addi	sp,sp,16
    80006b5c:	00001317          	auipc	t1,0x1
    80006b60:	9b430067          	jr	-1612(t1) # 80007510 <uartputc_sync>

0000000080006b64 <consoleintr>:
    80006b64:	fe010113          	addi	sp,sp,-32
    80006b68:	00813823          	sd	s0,16(sp)
    80006b6c:	00913423          	sd	s1,8(sp)
    80006b70:	01213023          	sd	s2,0(sp)
    80006b74:	00113c23          	sd	ra,24(sp)
    80006b78:	02010413          	addi	s0,sp,32
    80006b7c:	0000a917          	auipc	s2,0xa
    80006b80:	29c90913          	addi	s2,s2,668 # 80010e18 <cons>
    80006b84:	00050493          	mv	s1,a0
    80006b88:	00090513          	mv	a0,s2
    80006b8c:	00001097          	auipc	ra,0x1
    80006b90:	e40080e7          	jalr	-448(ra) # 800079cc <acquire>
    80006b94:	02048c63          	beqz	s1,80006bcc <consoleintr+0x68>
    80006b98:	0a092783          	lw	a5,160(s2)
    80006b9c:	09892703          	lw	a4,152(s2)
    80006ba0:	07f00693          	li	a3,127
    80006ba4:	40e7873b          	subw	a4,a5,a4
    80006ba8:	02e6e263          	bltu	a3,a4,80006bcc <consoleintr+0x68>
    80006bac:	00d00713          	li	a4,13
    80006bb0:	04e48063          	beq	s1,a4,80006bf0 <consoleintr+0x8c>
    80006bb4:	07f7f713          	andi	a4,a5,127
    80006bb8:	00e90733          	add	a4,s2,a4
    80006bbc:	0017879b          	addiw	a5,a5,1
    80006bc0:	0af92023          	sw	a5,160(s2)
    80006bc4:	00970c23          	sb	s1,24(a4)
    80006bc8:	08f92e23          	sw	a5,156(s2)
    80006bcc:	01013403          	ld	s0,16(sp)
    80006bd0:	01813083          	ld	ra,24(sp)
    80006bd4:	00813483          	ld	s1,8(sp)
    80006bd8:	00013903          	ld	s2,0(sp)
    80006bdc:	0000a517          	auipc	a0,0xa
    80006be0:	23c50513          	addi	a0,a0,572 # 80010e18 <cons>
    80006be4:	02010113          	addi	sp,sp,32
    80006be8:	00001317          	auipc	t1,0x1
    80006bec:	eb030067          	jr	-336(t1) # 80007a98 <release>
    80006bf0:	00a00493          	li	s1,10
    80006bf4:	fc1ff06f          	j	80006bb4 <consoleintr+0x50>

0000000080006bf8 <consoleinit>:
    80006bf8:	fe010113          	addi	sp,sp,-32
    80006bfc:	00113c23          	sd	ra,24(sp)
    80006c00:	00813823          	sd	s0,16(sp)
    80006c04:	00913423          	sd	s1,8(sp)
    80006c08:	02010413          	addi	s0,sp,32
    80006c0c:	0000a497          	auipc	s1,0xa
    80006c10:	20c48493          	addi	s1,s1,524 # 80010e18 <cons>
    80006c14:	00048513          	mv	a0,s1
    80006c18:	00003597          	auipc	a1,0x3
    80006c1c:	b6058593          	addi	a1,a1,-1184 # 80009778 <CONSOLE_STATUS+0x768>
    80006c20:	00001097          	auipc	ra,0x1
    80006c24:	d88080e7          	jalr	-632(ra) # 800079a8 <initlock>
    80006c28:	00000097          	auipc	ra,0x0
    80006c2c:	7ac080e7          	jalr	1964(ra) # 800073d4 <uartinit>
    80006c30:	01813083          	ld	ra,24(sp)
    80006c34:	01013403          	ld	s0,16(sp)
    80006c38:	00000797          	auipc	a5,0x0
    80006c3c:	d9c78793          	addi	a5,a5,-612 # 800069d4 <consoleread>
    80006c40:	0af4bc23          	sd	a5,184(s1)
    80006c44:	00000797          	auipc	a5,0x0
    80006c48:	cec78793          	addi	a5,a5,-788 # 80006930 <consolewrite>
    80006c4c:	0cf4b023          	sd	a5,192(s1)
    80006c50:	00813483          	ld	s1,8(sp)
    80006c54:	02010113          	addi	sp,sp,32
    80006c58:	00008067          	ret

0000000080006c5c <console_read>:
    80006c5c:	ff010113          	addi	sp,sp,-16
    80006c60:	00813423          	sd	s0,8(sp)
    80006c64:	01010413          	addi	s0,sp,16
    80006c68:	00813403          	ld	s0,8(sp)
    80006c6c:	0000a317          	auipc	t1,0xa
    80006c70:	26433303          	ld	t1,612(t1) # 80010ed0 <devsw+0x10>
    80006c74:	01010113          	addi	sp,sp,16
    80006c78:	00030067          	jr	t1

0000000080006c7c <console_write>:
    80006c7c:	ff010113          	addi	sp,sp,-16
    80006c80:	00813423          	sd	s0,8(sp)
    80006c84:	01010413          	addi	s0,sp,16
    80006c88:	00813403          	ld	s0,8(sp)
    80006c8c:	0000a317          	auipc	t1,0xa
    80006c90:	24c33303          	ld	t1,588(t1) # 80010ed8 <devsw+0x18>
    80006c94:	01010113          	addi	sp,sp,16
    80006c98:	00030067          	jr	t1

0000000080006c9c <panic>:
    80006c9c:	fe010113          	addi	sp,sp,-32
    80006ca0:	00113c23          	sd	ra,24(sp)
    80006ca4:	00813823          	sd	s0,16(sp)
    80006ca8:	00913423          	sd	s1,8(sp)
    80006cac:	02010413          	addi	s0,sp,32
    80006cb0:	00050493          	mv	s1,a0
    80006cb4:	00003517          	auipc	a0,0x3
    80006cb8:	acc50513          	addi	a0,a0,-1332 # 80009780 <CONSOLE_STATUS+0x770>
    80006cbc:	0000a797          	auipc	a5,0xa
    80006cc0:	2a07ae23          	sw	zero,700(a5) # 80010f78 <pr+0x18>
    80006cc4:	00000097          	auipc	ra,0x0
    80006cc8:	034080e7          	jalr	52(ra) # 80006cf8 <__printf>
    80006ccc:	00048513          	mv	a0,s1
    80006cd0:	00000097          	auipc	ra,0x0
    80006cd4:	028080e7          	jalr	40(ra) # 80006cf8 <__printf>
    80006cd8:	00002517          	auipc	a0,0x2
    80006cdc:	67050513          	addi	a0,a0,1648 # 80009348 <CONSOLE_STATUS+0x338>
    80006ce0:	00000097          	auipc	ra,0x0
    80006ce4:	018080e7          	jalr	24(ra) # 80006cf8 <__printf>
    80006ce8:	00100793          	li	a5,1
    80006cec:	00005717          	auipc	a4,0x5
    80006cf0:	def72623          	sw	a5,-532(a4) # 8000bad8 <panicked>
    80006cf4:	0000006f          	j	80006cf4 <panic+0x58>

0000000080006cf8 <__printf>:
    80006cf8:	f3010113          	addi	sp,sp,-208
    80006cfc:	08813023          	sd	s0,128(sp)
    80006d00:	07313423          	sd	s3,104(sp)
    80006d04:	09010413          	addi	s0,sp,144
    80006d08:	05813023          	sd	s8,64(sp)
    80006d0c:	08113423          	sd	ra,136(sp)
    80006d10:	06913c23          	sd	s1,120(sp)
    80006d14:	07213823          	sd	s2,112(sp)
    80006d18:	07413023          	sd	s4,96(sp)
    80006d1c:	05513c23          	sd	s5,88(sp)
    80006d20:	05613823          	sd	s6,80(sp)
    80006d24:	05713423          	sd	s7,72(sp)
    80006d28:	03913c23          	sd	s9,56(sp)
    80006d2c:	03a13823          	sd	s10,48(sp)
    80006d30:	03b13423          	sd	s11,40(sp)
    80006d34:	0000a317          	auipc	t1,0xa
    80006d38:	22c30313          	addi	t1,t1,556 # 80010f60 <pr>
    80006d3c:	01832c03          	lw	s8,24(t1)
    80006d40:	00b43423          	sd	a1,8(s0)
    80006d44:	00c43823          	sd	a2,16(s0)
    80006d48:	00d43c23          	sd	a3,24(s0)
    80006d4c:	02e43023          	sd	a4,32(s0)
    80006d50:	02f43423          	sd	a5,40(s0)
    80006d54:	03043823          	sd	a6,48(s0)
    80006d58:	03143c23          	sd	a7,56(s0)
    80006d5c:	00050993          	mv	s3,a0
    80006d60:	4a0c1663          	bnez	s8,8000720c <__printf+0x514>
    80006d64:	60098c63          	beqz	s3,8000737c <__printf+0x684>
    80006d68:	0009c503          	lbu	a0,0(s3)
    80006d6c:	00840793          	addi	a5,s0,8
    80006d70:	f6f43c23          	sd	a5,-136(s0)
    80006d74:	00000493          	li	s1,0
    80006d78:	22050063          	beqz	a0,80006f98 <__printf+0x2a0>
    80006d7c:	00002a37          	lui	s4,0x2
    80006d80:	00018ab7          	lui	s5,0x18
    80006d84:	000f4b37          	lui	s6,0xf4
    80006d88:	00989bb7          	lui	s7,0x989
    80006d8c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006d90:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006d94:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006d98:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80006d9c:	00148c9b          	addiw	s9,s1,1
    80006da0:	02500793          	li	a5,37
    80006da4:	01998933          	add	s2,s3,s9
    80006da8:	38f51263          	bne	a0,a5,8000712c <__printf+0x434>
    80006dac:	00094783          	lbu	a5,0(s2)
    80006db0:	00078c9b          	sext.w	s9,a5
    80006db4:	1e078263          	beqz	a5,80006f98 <__printf+0x2a0>
    80006db8:	0024849b          	addiw	s1,s1,2
    80006dbc:	07000713          	li	a4,112
    80006dc0:	00998933          	add	s2,s3,s1
    80006dc4:	38e78a63          	beq	a5,a4,80007158 <__printf+0x460>
    80006dc8:	20f76863          	bltu	a4,a5,80006fd8 <__printf+0x2e0>
    80006dcc:	42a78863          	beq	a5,a0,800071fc <__printf+0x504>
    80006dd0:	06400713          	li	a4,100
    80006dd4:	40e79663          	bne	a5,a4,800071e0 <__printf+0x4e8>
    80006dd8:	f7843783          	ld	a5,-136(s0)
    80006ddc:	0007a603          	lw	a2,0(a5)
    80006de0:	00878793          	addi	a5,a5,8
    80006de4:	f6f43c23          	sd	a5,-136(s0)
    80006de8:	42064a63          	bltz	a2,8000721c <__printf+0x524>
    80006dec:	00a00713          	li	a4,10
    80006df0:	02e677bb          	remuw	a5,a2,a4
    80006df4:	00003d97          	auipc	s11,0x3
    80006df8:	9b4d8d93          	addi	s11,s11,-1612 # 800097a8 <digits>
    80006dfc:	00900593          	li	a1,9
    80006e00:	0006051b          	sext.w	a0,a2
    80006e04:	00000c93          	li	s9,0
    80006e08:	02079793          	slli	a5,a5,0x20
    80006e0c:	0207d793          	srli	a5,a5,0x20
    80006e10:	00fd87b3          	add	a5,s11,a5
    80006e14:	0007c783          	lbu	a5,0(a5)
    80006e18:	02e656bb          	divuw	a3,a2,a4
    80006e1c:	f8f40023          	sb	a5,-128(s0)
    80006e20:	14c5d863          	bge	a1,a2,80006f70 <__printf+0x278>
    80006e24:	06300593          	li	a1,99
    80006e28:	00100c93          	li	s9,1
    80006e2c:	02e6f7bb          	remuw	a5,a3,a4
    80006e30:	02079793          	slli	a5,a5,0x20
    80006e34:	0207d793          	srli	a5,a5,0x20
    80006e38:	00fd87b3          	add	a5,s11,a5
    80006e3c:	0007c783          	lbu	a5,0(a5)
    80006e40:	02e6d73b          	divuw	a4,a3,a4
    80006e44:	f8f400a3          	sb	a5,-127(s0)
    80006e48:	12a5f463          	bgeu	a1,a0,80006f70 <__printf+0x278>
    80006e4c:	00a00693          	li	a3,10
    80006e50:	00900593          	li	a1,9
    80006e54:	02d777bb          	remuw	a5,a4,a3
    80006e58:	02079793          	slli	a5,a5,0x20
    80006e5c:	0207d793          	srli	a5,a5,0x20
    80006e60:	00fd87b3          	add	a5,s11,a5
    80006e64:	0007c503          	lbu	a0,0(a5)
    80006e68:	02d757bb          	divuw	a5,a4,a3
    80006e6c:	f8a40123          	sb	a0,-126(s0)
    80006e70:	48e5f263          	bgeu	a1,a4,800072f4 <__printf+0x5fc>
    80006e74:	06300513          	li	a0,99
    80006e78:	02d7f5bb          	remuw	a1,a5,a3
    80006e7c:	02059593          	slli	a1,a1,0x20
    80006e80:	0205d593          	srli	a1,a1,0x20
    80006e84:	00bd85b3          	add	a1,s11,a1
    80006e88:	0005c583          	lbu	a1,0(a1)
    80006e8c:	02d7d7bb          	divuw	a5,a5,a3
    80006e90:	f8b401a3          	sb	a1,-125(s0)
    80006e94:	48e57263          	bgeu	a0,a4,80007318 <__printf+0x620>
    80006e98:	3e700513          	li	a0,999
    80006e9c:	02d7f5bb          	remuw	a1,a5,a3
    80006ea0:	02059593          	slli	a1,a1,0x20
    80006ea4:	0205d593          	srli	a1,a1,0x20
    80006ea8:	00bd85b3          	add	a1,s11,a1
    80006eac:	0005c583          	lbu	a1,0(a1)
    80006eb0:	02d7d7bb          	divuw	a5,a5,a3
    80006eb4:	f8b40223          	sb	a1,-124(s0)
    80006eb8:	46e57663          	bgeu	a0,a4,80007324 <__printf+0x62c>
    80006ebc:	02d7f5bb          	remuw	a1,a5,a3
    80006ec0:	02059593          	slli	a1,a1,0x20
    80006ec4:	0205d593          	srli	a1,a1,0x20
    80006ec8:	00bd85b3          	add	a1,s11,a1
    80006ecc:	0005c583          	lbu	a1,0(a1)
    80006ed0:	02d7d7bb          	divuw	a5,a5,a3
    80006ed4:	f8b402a3          	sb	a1,-123(s0)
    80006ed8:	46ea7863          	bgeu	s4,a4,80007348 <__printf+0x650>
    80006edc:	02d7f5bb          	remuw	a1,a5,a3
    80006ee0:	02059593          	slli	a1,a1,0x20
    80006ee4:	0205d593          	srli	a1,a1,0x20
    80006ee8:	00bd85b3          	add	a1,s11,a1
    80006eec:	0005c583          	lbu	a1,0(a1)
    80006ef0:	02d7d7bb          	divuw	a5,a5,a3
    80006ef4:	f8b40323          	sb	a1,-122(s0)
    80006ef8:	3eeaf863          	bgeu	s5,a4,800072e8 <__printf+0x5f0>
    80006efc:	02d7f5bb          	remuw	a1,a5,a3
    80006f00:	02059593          	slli	a1,a1,0x20
    80006f04:	0205d593          	srli	a1,a1,0x20
    80006f08:	00bd85b3          	add	a1,s11,a1
    80006f0c:	0005c583          	lbu	a1,0(a1)
    80006f10:	02d7d7bb          	divuw	a5,a5,a3
    80006f14:	f8b403a3          	sb	a1,-121(s0)
    80006f18:	42eb7e63          	bgeu	s6,a4,80007354 <__printf+0x65c>
    80006f1c:	02d7f5bb          	remuw	a1,a5,a3
    80006f20:	02059593          	slli	a1,a1,0x20
    80006f24:	0205d593          	srli	a1,a1,0x20
    80006f28:	00bd85b3          	add	a1,s11,a1
    80006f2c:	0005c583          	lbu	a1,0(a1)
    80006f30:	02d7d7bb          	divuw	a5,a5,a3
    80006f34:	f8b40423          	sb	a1,-120(s0)
    80006f38:	42ebfc63          	bgeu	s7,a4,80007370 <__printf+0x678>
    80006f3c:	02079793          	slli	a5,a5,0x20
    80006f40:	0207d793          	srli	a5,a5,0x20
    80006f44:	00fd8db3          	add	s11,s11,a5
    80006f48:	000dc703          	lbu	a4,0(s11)
    80006f4c:	00a00793          	li	a5,10
    80006f50:	00900c93          	li	s9,9
    80006f54:	f8e404a3          	sb	a4,-119(s0)
    80006f58:	00065c63          	bgez	a2,80006f70 <__printf+0x278>
    80006f5c:	f9040713          	addi	a4,s0,-112
    80006f60:	00f70733          	add	a4,a4,a5
    80006f64:	02d00693          	li	a3,45
    80006f68:	fed70823          	sb	a3,-16(a4)
    80006f6c:	00078c93          	mv	s9,a5
    80006f70:	f8040793          	addi	a5,s0,-128
    80006f74:	01978cb3          	add	s9,a5,s9
    80006f78:	f7f40d13          	addi	s10,s0,-129
    80006f7c:	000cc503          	lbu	a0,0(s9)
    80006f80:	fffc8c93          	addi	s9,s9,-1
    80006f84:	00000097          	auipc	ra,0x0
    80006f88:	b90080e7          	jalr	-1136(ra) # 80006b14 <consputc>
    80006f8c:	ffac98e3          	bne	s9,s10,80006f7c <__printf+0x284>
    80006f90:	00094503          	lbu	a0,0(s2)
    80006f94:	e00514e3          	bnez	a0,80006d9c <__printf+0xa4>
    80006f98:	1a0c1663          	bnez	s8,80007144 <__printf+0x44c>
    80006f9c:	08813083          	ld	ra,136(sp)
    80006fa0:	08013403          	ld	s0,128(sp)
    80006fa4:	07813483          	ld	s1,120(sp)
    80006fa8:	07013903          	ld	s2,112(sp)
    80006fac:	06813983          	ld	s3,104(sp)
    80006fb0:	06013a03          	ld	s4,96(sp)
    80006fb4:	05813a83          	ld	s5,88(sp)
    80006fb8:	05013b03          	ld	s6,80(sp)
    80006fbc:	04813b83          	ld	s7,72(sp)
    80006fc0:	04013c03          	ld	s8,64(sp)
    80006fc4:	03813c83          	ld	s9,56(sp)
    80006fc8:	03013d03          	ld	s10,48(sp)
    80006fcc:	02813d83          	ld	s11,40(sp)
    80006fd0:	0d010113          	addi	sp,sp,208
    80006fd4:	00008067          	ret
    80006fd8:	07300713          	li	a4,115
    80006fdc:	1ce78a63          	beq	a5,a4,800071b0 <__printf+0x4b8>
    80006fe0:	07800713          	li	a4,120
    80006fe4:	1ee79e63          	bne	a5,a4,800071e0 <__printf+0x4e8>
    80006fe8:	f7843783          	ld	a5,-136(s0)
    80006fec:	0007a703          	lw	a4,0(a5)
    80006ff0:	00878793          	addi	a5,a5,8
    80006ff4:	f6f43c23          	sd	a5,-136(s0)
    80006ff8:	28074263          	bltz	a4,8000727c <__printf+0x584>
    80006ffc:	00002d97          	auipc	s11,0x2
    80007000:	7acd8d93          	addi	s11,s11,1964 # 800097a8 <digits>
    80007004:	00f77793          	andi	a5,a4,15
    80007008:	00fd87b3          	add	a5,s11,a5
    8000700c:	0007c683          	lbu	a3,0(a5)
    80007010:	00f00613          	li	a2,15
    80007014:	0007079b          	sext.w	a5,a4
    80007018:	f8d40023          	sb	a3,-128(s0)
    8000701c:	0047559b          	srliw	a1,a4,0x4
    80007020:	0047569b          	srliw	a3,a4,0x4
    80007024:	00000c93          	li	s9,0
    80007028:	0ee65063          	bge	a2,a4,80007108 <__printf+0x410>
    8000702c:	00f6f693          	andi	a3,a3,15
    80007030:	00dd86b3          	add	a3,s11,a3
    80007034:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007038:	0087d79b          	srliw	a5,a5,0x8
    8000703c:	00100c93          	li	s9,1
    80007040:	f8d400a3          	sb	a3,-127(s0)
    80007044:	0cb67263          	bgeu	a2,a1,80007108 <__printf+0x410>
    80007048:	00f7f693          	andi	a3,a5,15
    8000704c:	00dd86b3          	add	a3,s11,a3
    80007050:	0006c583          	lbu	a1,0(a3)
    80007054:	00f00613          	li	a2,15
    80007058:	0047d69b          	srliw	a3,a5,0x4
    8000705c:	f8b40123          	sb	a1,-126(s0)
    80007060:	0047d593          	srli	a1,a5,0x4
    80007064:	28f67e63          	bgeu	a2,a5,80007300 <__printf+0x608>
    80007068:	00f6f693          	andi	a3,a3,15
    8000706c:	00dd86b3          	add	a3,s11,a3
    80007070:	0006c503          	lbu	a0,0(a3)
    80007074:	0087d813          	srli	a6,a5,0x8
    80007078:	0087d69b          	srliw	a3,a5,0x8
    8000707c:	f8a401a3          	sb	a0,-125(s0)
    80007080:	28b67663          	bgeu	a2,a1,8000730c <__printf+0x614>
    80007084:	00f6f693          	andi	a3,a3,15
    80007088:	00dd86b3          	add	a3,s11,a3
    8000708c:	0006c583          	lbu	a1,0(a3)
    80007090:	00c7d513          	srli	a0,a5,0xc
    80007094:	00c7d69b          	srliw	a3,a5,0xc
    80007098:	f8b40223          	sb	a1,-124(s0)
    8000709c:	29067a63          	bgeu	a2,a6,80007330 <__printf+0x638>
    800070a0:	00f6f693          	andi	a3,a3,15
    800070a4:	00dd86b3          	add	a3,s11,a3
    800070a8:	0006c583          	lbu	a1,0(a3)
    800070ac:	0107d813          	srli	a6,a5,0x10
    800070b0:	0107d69b          	srliw	a3,a5,0x10
    800070b4:	f8b402a3          	sb	a1,-123(s0)
    800070b8:	28a67263          	bgeu	a2,a0,8000733c <__printf+0x644>
    800070bc:	00f6f693          	andi	a3,a3,15
    800070c0:	00dd86b3          	add	a3,s11,a3
    800070c4:	0006c683          	lbu	a3,0(a3)
    800070c8:	0147d79b          	srliw	a5,a5,0x14
    800070cc:	f8d40323          	sb	a3,-122(s0)
    800070d0:	21067663          	bgeu	a2,a6,800072dc <__printf+0x5e4>
    800070d4:	02079793          	slli	a5,a5,0x20
    800070d8:	0207d793          	srli	a5,a5,0x20
    800070dc:	00fd8db3          	add	s11,s11,a5
    800070e0:	000dc683          	lbu	a3,0(s11)
    800070e4:	00800793          	li	a5,8
    800070e8:	00700c93          	li	s9,7
    800070ec:	f8d403a3          	sb	a3,-121(s0)
    800070f0:	00075c63          	bgez	a4,80007108 <__printf+0x410>
    800070f4:	f9040713          	addi	a4,s0,-112
    800070f8:	00f70733          	add	a4,a4,a5
    800070fc:	02d00693          	li	a3,45
    80007100:	fed70823          	sb	a3,-16(a4)
    80007104:	00078c93          	mv	s9,a5
    80007108:	f8040793          	addi	a5,s0,-128
    8000710c:	01978cb3          	add	s9,a5,s9
    80007110:	f7f40d13          	addi	s10,s0,-129
    80007114:	000cc503          	lbu	a0,0(s9)
    80007118:	fffc8c93          	addi	s9,s9,-1
    8000711c:	00000097          	auipc	ra,0x0
    80007120:	9f8080e7          	jalr	-1544(ra) # 80006b14 <consputc>
    80007124:	ff9d18e3          	bne	s10,s9,80007114 <__printf+0x41c>
    80007128:	0100006f          	j	80007138 <__printf+0x440>
    8000712c:	00000097          	auipc	ra,0x0
    80007130:	9e8080e7          	jalr	-1560(ra) # 80006b14 <consputc>
    80007134:	000c8493          	mv	s1,s9
    80007138:	00094503          	lbu	a0,0(s2)
    8000713c:	c60510e3          	bnez	a0,80006d9c <__printf+0xa4>
    80007140:	e40c0ee3          	beqz	s8,80006f9c <__printf+0x2a4>
    80007144:	0000a517          	auipc	a0,0xa
    80007148:	e1c50513          	addi	a0,a0,-484 # 80010f60 <pr>
    8000714c:	00001097          	auipc	ra,0x1
    80007150:	94c080e7          	jalr	-1716(ra) # 80007a98 <release>
    80007154:	e49ff06f          	j	80006f9c <__printf+0x2a4>
    80007158:	f7843783          	ld	a5,-136(s0)
    8000715c:	03000513          	li	a0,48
    80007160:	01000d13          	li	s10,16
    80007164:	00878713          	addi	a4,a5,8
    80007168:	0007bc83          	ld	s9,0(a5)
    8000716c:	f6e43c23          	sd	a4,-136(s0)
    80007170:	00000097          	auipc	ra,0x0
    80007174:	9a4080e7          	jalr	-1628(ra) # 80006b14 <consputc>
    80007178:	07800513          	li	a0,120
    8000717c:	00000097          	auipc	ra,0x0
    80007180:	998080e7          	jalr	-1640(ra) # 80006b14 <consputc>
    80007184:	00002d97          	auipc	s11,0x2
    80007188:	624d8d93          	addi	s11,s11,1572 # 800097a8 <digits>
    8000718c:	03ccd793          	srli	a5,s9,0x3c
    80007190:	00fd87b3          	add	a5,s11,a5
    80007194:	0007c503          	lbu	a0,0(a5)
    80007198:	fffd0d1b          	addiw	s10,s10,-1
    8000719c:	004c9c93          	slli	s9,s9,0x4
    800071a0:	00000097          	auipc	ra,0x0
    800071a4:	974080e7          	jalr	-1676(ra) # 80006b14 <consputc>
    800071a8:	fe0d12e3          	bnez	s10,8000718c <__printf+0x494>
    800071ac:	f8dff06f          	j	80007138 <__printf+0x440>
    800071b0:	f7843783          	ld	a5,-136(s0)
    800071b4:	0007bc83          	ld	s9,0(a5)
    800071b8:	00878793          	addi	a5,a5,8
    800071bc:	f6f43c23          	sd	a5,-136(s0)
    800071c0:	000c9a63          	bnez	s9,800071d4 <__printf+0x4dc>
    800071c4:	1080006f          	j	800072cc <__printf+0x5d4>
    800071c8:	001c8c93          	addi	s9,s9,1
    800071cc:	00000097          	auipc	ra,0x0
    800071d0:	948080e7          	jalr	-1720(ra) # 80006b14 <consputc>
    800071d4:	000cc503          	lbu	a0,0(s9)
    800071d8:	fe0518e3          	bnez	a0,800071c8 <__printf+0x4d0>
    800071dc:	f5dff06f          	j	80007138 <__printf+0x440>
    800071e0:	02500513          	li	a0,37
    800071e4:	00000097          	auipc	ra,0x0
    800071e8:	930080e7          	jalr	-1744(ra) # 80006b14 <consputc>
    800071ec:	000c8513          	mv	a0,s9
    800071f0:	00000097          	auipc	ra,0x0
    800071f4:	924080e7          	jalr	-1756(ra) # 80006b14 <consputc>
    800071f8:	f41ff06f          	j	80007138 <__printf+0x440>
    800071fc:	02500513          	li	a0,37
    80007200:	00000097          	auipc	ra,0x0
    80007204:	914080e7          	jalr	-1772(ra) # 80006b14 <consputc>
    80007208:	f31ff06f          	j	80007138 <__printf+0x440>
    8000720c:	00030513          	mv	a0,t1
    80007210:	00000097          	auipc	ra,0x0
    80007214:	7bc080e7          	jalr	1980(ra) # 800079cc <acquire>
    80007218:	b4dff06f          	j	80006d64 <__printf+0x6c>
    8000721c:	40c0053b          	negw	a0,a2
    80007220:	00a00713          	li	a4,10
    80007224:	02e576bb          	remuw	a3,a0,a4
    80007228:	00002d97          	auipc	s11,0x2
    8000722c:	580d8d93          	addi	s11,s11,1408 # 800097a8 <digits>
    80007230:	ff700593          	li	a1,-9
    80007234:	02069693          	slli	a3,a3,0x20
    80007238:	0206d693          	srli	a3,a3,0x20
    8000723c:	00dd86b3          	add	a3,s11,a3
    80007240:	0006c683          	lbu	a3,0(a3)
    80007244:	02e557bb          	divuw	a5,a0,a4
    80007248:	f8d40023          	sb	a3,-128(s0)
    8000724c:	10b65e63          	bge	a2,a1,80007368 <__printf+0x670>
    80007250:	06300593          	li	a1,99
    80007254:	02e7f6bb          	remuw	a3,a5,a4
    80007258:	02069693          	slli	a3,a3,0x20
    8000725c:	0206d693          	srli	a3,a3,0x20
    80007260:	00dd86b3          	add	a3,s11,a3
    80007264:	0006c683          	lbu	a3,0(a3)
    80007268:	02e7d73b          	divuw	a4,a5,a4
    8000726c:	00200793          	li	a5,2
    80007270:	f8d400a3          	sb	a3,-127(s0)
    80007274:	bca5ece3          	bltu	a1,a0,80006e4c <__printf+0x154>
    80007278:	ce5ff06f          	j	80006f5c <__printf+0x264>
    8000727c:	40e007bb          	negw	a5,a4
    80007280:	00002d97          	auipc	s11,0x2
    80007284:	528d8d93          	addi	s11,s11,1320 # 800097a8 <digits>
    80007288:	00f7f693          	andi	a3,a5,15
    8000728c:	00dd86b3          	add	a3,s11,a3
    80007290:	0006c583          	lbu	a1,0(a3)
    80007294:	ff100613          	li	a2,-15
    80007298:	0047d69b          	srliw	a3,a5,0x4
    8000729c:	f8b40023          	sb	a1,-128(s0)
    800072a0:	0047d59b          	srliw	a1,a5,0x4
    800072a4:	0ac75e63          	bge	a4,a2,80007360 <__printf+0x668>
    800072a8:	00f6f693          	andi	a3,a3,15
    800072ac:	00dd86b3          	add	a3,s11,a3
    800072b0:	0006c603          	lbu	a2,0(a3)
    800072b4:	00f00693          	li	a3,15
    800072b8:	0087d79b          	srliw	a5,a5,0x8
    800072bc:	f8c400a3          	sb	a2,-127(s0)
    800072c0:	d8b6e4e3          	bltu	a3,a1,80007048 <__printf+0x350>
    800072c4:	00200793          	li	a5,2
    800072c8:	e2dff06f          	j	800070f4 <__printf+0x3fc>
    800072cc:	00002c97          	auipc	s9,0x2
    800072d0:	4bcc8c93          	addi	s9,s9,1212 # 80009788 <CONSOLE_STATUS+0x778>
    800072d4:	02800513          	li	a0,40
    800072d8:	ef1ff06f          	j	800071c8 <__printf+0x4d0>
    800072dc:	00700793          	li	a5,7
    800072e0:	00600c93          	li	s9,6
    800072e4:	e0dff06f          	j	800070f0 <__printf+0x3f8>
    800072e8:	00700793          	li	a5,7
    800072ec:	00600c93          	li	s9,6
    800072f0:	c69ff06f          	j	80006f58 <__printf+0x260>
    800072f4:	00300793          	li	a5,3
    800072f8:	00200c93          	li	s9,2
    800072fc:	c5dff06f          	j	80006f58 <__printf+0x260>
    80007300:	00300793          	li	a5,3
    80007304:	00200c93          	li	s9,2
    80007308:	de9ff06f          	j	800070f0 <__printf+0x3f8>
    8000730c:	00400793          	li	a5,4
    80007310:	00300c93          	li	s9,3
    80007314:	dddff06f          	j	800070f0 <__printf+0x3f8>
    80007318:	00400793          	li	a5,4
    8000731c:	00300c93          	li	s9,3
    80007320:	c39ff06f          	j	80006f58 <__printf+0x260>
    80007324:	00500793          	li	a5,5
    80007328:	00400c93          	li	s9,4
    8000732c:	c2dff06f          	j	80006f58 <__printf+0x260>
    80007330:	00500793          	li	a5,5
    80007334:	00400c93          	li	s9,4
    80007338:	db9ff06f          	j	800070f0 <__printf+0x3f8>
    8000733c:	00600793          	li	a5,6
    80007340:	00500c93          	li	s9,5
    80007344:	dadff06f          	j	800070f0 <__printf+0x3f8>
    80007348:	00600793          	li	a5,6
    8000734c:	00500c93          	li	s9,5
    80007350:	c09ff06f          	j	80006f58 <__printf+0x260>
    80007354:	00800793          	li	a5,8
    80007358:	00700c93          	li	s9,7
    8000735c:	bfdff06f          	j	80006f58 <__printf+0x260>
    80007360:	00100793          	li	a5,1
    80007364:	d91ff06f          	j	800070f4 <__printf+0x3fc>
    80007368:	00100793          	li	a5,1
    8000736c:	bf1ff06f          	j	80006f5c <__printf+0x264>
    80007370:	00900793          	li	a5,9
    80007374:	00800c93          	li	s9,8
    80007378:	be1ff06f          	j	80006f58 <__printf+0x260>
    8000737c:	00002517          	auipc	a0,0x2
    80007380:	41450513          	addi	a0,a0,1044 # 80009790 <CONSOLE_STATUS+0x780>
    80007384:	00000097          	auipc	ra,0x0
    80007388:	918080e7          	jalr	-1768(ra) # 80006c9c <panic>

000000008000738c <printfinit>:
    8000738c:	fe010113          	addi	sp,sp,-32
    80007390:	00813823          	sd	s0,16(sp)
    80007394:	00913423          	sd	s1,8(sp)
    80007398:	00113c23          	sd	ra,24(sp)
    8000739c:	02010413          	addi	s0,sp,32
    800073a0:	0000a497          	auipc	s1,0xa
    800073a4:	bc048493          	addi	s1,s1,-1088 # 80010f60 <pr>
    800073a8:	00048513          	mv	a0,s1
    800073ac:	00002597          	auipc	a1,0x2
    800073b0:	3f458593          	addi	a1,a1,1012 # 800097a0 <CONSOLE_STATUS+0x790>
    800073b4:	00000097          	auipc	ra,0x0
    800073b8:	5f4080e7          	jalr	1524(ra) # 800079a8 <initlock>
    800073bc:	01813083          	ld	ra,24(sp)
    800073c0:	01013403          	ld	s0,16(sp)
    800073c4:	0004ac23          	sw	zero,24(s1)
    800073c8:	00813483          	ld	s1,8(sp)
    800073cc:	02010113          	addi	sp,sp,32
    800073d0:	00008067          	ret

00000000800073d4 <uartinit>:
    800073d4:	ff010113          	addi	sp,sp,-16
    800073d8:	00813423          	sd	s0,8(sp)
    800073dc:	01010413          	addi	s0,sp,16
    800073e0:	100007b7          	lui	a5,0x10000
    800073e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800073e8:	f8000713          	li	a4,-128
    800073ec:	00e781a3          	sb	a4,3(a5)
    800073f0:	00300713          	li	a4,3
    800073f4:	00e78023          	sb	a4,0(a5)
    800073f8:	000780a3          	sb	zero,1(a5)
    800073fc:	00e781a3          	sb	a4,3(a5)
    80007400:	00700693          	li	a3,7
    80007404:	00d78123          	sb	a3,2(a5)
    80007408:	00e780a3          	sb	a4,1(a5)
    8000740c:	00813403          	ld	s0,8(sp)
    80007410:	01010113          	addi	sp,sp,16
    80007414:	00008067          	ret

0000000080007418 <uartputc>:
    80007418:	00004797          	auipc	a5,0x4
    8000741c:	6c07a783          	lw	a5,1728(a5) # 8000bad8 <panicked>
    80007420:	00078463          	beqz	a5,80007428 <uartputc+0x10>
    80007424:	0000006f          	j	80007424 <uartputc+0xc>
    80007428:	fd010113          	addi	sp,sp,-48
    8000742c:	02813023          	sd	s0,32(sp)
    80007430:	00913c23          	sd	s1,24(sp)
    80007434:	01213823          	sd	s2,16(sp)
    80007438:	01313423          	sd	s3,8(sp)
    8000743c:	02113423          	sd	ra,40(sp)
    80007440:	03010413          	addi	s0,sp,48
    80007444:	00004917          	auipc	s2,0x4
    80007448:	69c90913          	addi	s2,s2,1692 # 8000bae0 <uart_tx_r>
    8000744c:	00093783          	ld	a5,0(s2)
    80007450:	00004497          	auipc	s1,0x4
    80007454:	69848493          	addi	s1,s1,1688 # 8000bae8 <uart_tx_w>
    80007458:	0004b703          	ld	a4,0(s1)
    8000745c:	02078693          	addi	a3,a5,32
    80007460:	00050993          	mv	s3,a0
    80007464:	02e69c63          	bne	a3,a4,8000749c <uartputc+0x84>
    80007468:	00001097          	auipc	ra,0x1
    8000746c:	834080e7          	jalr	-1996(ra) # 80007c9c <push_on>
    80007470:	00093783          	ld	a5,0(s2)
    80007474:	0004b703          	ld	a4,0(s1)
    80007478:	02078793          	addi	a5,a5,32
    8000747c:	00e79463          	bne	a5,a4,80007484 <uartputc+0x6c>
    80007480:	0000006f          	j	80007480 <uartputc+0x68>
    80007484:	00001097          	auipc	ra,0x1
    80007488:	88c080e7          	jalr	-1908(ra) # 80007d10 <pop_on>
    8000748c:	00093783          	ld	a5,0(s2)
    80007490:	0004b703          	ld	a4,0(s1)
    80007494:	02078693          	addi	a3,a5,32
    80007498:	fce688e3          	beq	a3,a4,80007468 <uartputc+0x50>
    8000749c:	01f77693          	andi	a3,a4,31
    800074a0:	0000a597          	auipc	a1,0xa
    800074a4:	ae058593          	addi	a1,a1,-1312 # 80010f80 <uart_tx_buf>
    800074a8:	00d586b3          	add	a3,a1,a3
    800074ac:	00170713          	addi	a4,a4,1
    800074b0:	01368023          	sb	s3,0(a3)
    800074b4:	00e4b023          	sd	a4,0(s1)
    800074b8:	10000637          	lui	a2,0x10000
    800074bc:	02f71063          	bne	a4,a5,800074dc <uartputc+0xc4>
    800074c0:	0340006f          	j	800074f4 <uartputc+0xdc>
    800074c4:	00074703          	lbu	a4,0(a4)
    800074c8:	00f93023          	sd	a5,0(s2)
    800074cc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800074d0:	00093783          	ld	a5,0(s2)
    800074d4:	0004b703          	ld	a4,0(s1)
    800074d8:	00f70e63          	beq	a4,a5,800074f4 <uartputc+0xdc>
    800074dc:	00564683          	lbu	a3,5(a2)
    800074e0:	01f7f713          	andi	a4,a5,31
    800074e4:	00e58733          	add	a4,a1,a4
    800074e8:	0206f693          	andi	a3,a3,32
    800074ec:	00178793          	addi	a5,a5,1
    800074f0:	fc069ae3          	bnez	a3,800074c4 <uartputc+0xac>
    800074f4:	02813083          	ld	ra,40(sp)
    800074f8:	02013403          	ld	s0,32(sp)
    800074fc:	01813483          	ld	s1,24(sp)
    80007500:	01013903          	ld	s2,16(sp)
    80007504:	00813983          	ld	s3,8(sp)
    80007508:	03010113          	addi	sp,sp,48
    8000750c:	00008067          	ret

0000000080007510 <uartputc_sync>:
    80007510:	ff010113          	addi	sp,sp,-16
    80007514:	00813423          	sd	s0,8(sp)
    80007518:	01010413          	addi	s0,sp,16
    8000751c:	00004717          	auipc	a4,0x4
    80007520:	5bc72703          	lw	a4,1468(a4) # 8000bad8 <panicked>
    80007524:	02071663          	bnez	a4,80007550 <uartputc_sync+0x40>
    80007528:	00050793          	mv	a5,a0
    8000752c:	100006b7          	lui	a3,0x10000
    80007530:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007534:	02077713          	andi	a4,a4,32
    80007538:	fe070ce3          	beqz	a4,80007530 <uartputc_sync+0x20>
    8000753c:	0ff7f793          	andi	a5,a5,255
    80007540:	00f68023          	sb	a5,0(a3)
    80007544:	00813403          	ld	s0,8(sp)
    80007548:	01010113          	addi	sp,sp,16
    8000754c:	00008067          	ret
    80007550:	0000006f          	j	80007550 <uartputc_sync+0x40>

0000000080007554 <uartstart>:
    80007554:	ff010113          	addi	sp,sp,-16
    80007558:	00813423          	sd	s0,8(sp)
    8000755c:	01010413          	addi	s0,sp,16
    80007560:	00004617          	auipc	a2,0x4
    80007564:	58060613          	addi	a2,a2,1408 # 8000bae0 <uart_tx_r>
    80007568:	00004517          	auipc	a0,0x4
    8000756c:	58050513          	addi	a0,a0,1408 # 8000bae8 <uart_tx_w>
    80007570:	00063783          	ld	a5,0(a2)
    80007574:	00053703          	ld	a4,0(a0)
    80007578:	04f70263          	beq	a4,a5,800075bc <uartstart+0x68>
    8000757c:	100005b7          	lui	a1,0x10000
    80007580:	0000a817          	auipc	a6,0xa
    80007584:	a0080813          	addi	a6,a6,-1536 # 80010f80 <uart_tx_buf>
    80007588:	01c0006f          	j	800075a4 <uartstart+0x50>
    8000758c:	0006c703          	lbu	a4,0(a3)
    80007590:	00f63023          	sd	a5,0(a2)
    80007594:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007598:	00063783          	ld	a5,0(a2)
    8000759c:	00053703          	ld	a4,0(a0)
    800075a0:	00f70e63          	beq	a4,a5,800075bc <uartstart+0x68>
    800075a4:	01f7f713          	andi	a4,a5,31
    800075a8:	00e806b3          	add	a3,a6,a4
    800075ac:	0055c703          	lbu	a4,5(a1)
    800075b0:	00178793          	addi	a5,a5,1
    800075b4:	02077713          	andi	a4,a4,32
    800075b8:	fc071ae3          	bnez	a4,8000758c <uartstart+0x38>
    800075bc:	00813403          	ld	s0,8(sp)
    800075c0:	01010113          	addi	sp,sp,16
    800075c4:	00008067          	ret

00000000800075c8 <uartgetc>:
    800075c8:	ff010113          	addi	sp,sp,-16
    800075cc:	00813423          	sd	s0,8(sp)
    800075d0:	01010413          	addi	s0,sp,16
    800075d4:	10000737          	lui	a4,0x10000
    800075d8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800075dc:	0017f793          	andi	a5,a5,1
    800075e0:	00078c63          	beqz	a5,800075f8 <uartgetc+0x30>
    800075e4:	00074503          	lbu	a0,0(a4)
    800075e8:	0ff57513          	andi	a0,a0,255
    800075ec:	00813403          	ld	s0,8(sp)
    800075f0:	01010113          	addi	sp,sp,16
    800075f4:	00008067          	ret
    800075f8:	fff00513          	li	a0,-1
    800075fc:	ff1ff06f          	j	800075ec <uartgetc+0x24>

0000000080007600 <uartintr>:
    80007600:	100007b7          	lui	a5,0x10000
    80007604:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007608:	0017f793          	andi	a5,a5,1
    8000760c:	0a078463          	beqz	a5,800076b4 <uartintr+0xb4>
    80007610:	fe010113          	addi	sp,sp,-32
    80007614:	00813823          	sd	s0,16(sp)
    80007618:	00913423          	sd	s1,8(sp)
    8000761c:	00113c23          	sd	ra,24(sp)
    80007620:	02010413          	addi	s0,sp,32
    80007624:	100004b7          	lui	s1,0x10000
    80007628:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000762c:	0ff57513          	andi	a0,a0,255
    80007630:	fffff097          	auipc	ra,0xfffff
    80007634:	534080e7          	jalr	1332(ra) # 80006b64 <consoleintr>
    80007638:	0054c783          	lbu	a5,5(s1)
    8000763c:	0017f793          	andi	a5,a5,1
    80007640:	fe0794e3          	bnez	a5,80007628 <uartintr+0x28>
    80007644:	00004617          	auipc	a2,0x4
    80007648:	49c60613          	addi	a2,a2,1180 # 8000bae0 <uart_tx_r>
    8000764c:	00004517          	auipc	a0,0x4
    80007650:	49c50513          	addi	a0,a0,1180 # 8000bae8 <uart_tx_w>
    80007654:	00063783          	ld	a5,0(a2)
    80007658:	00053703          	ld	a4,0(a0)
    8000765c:	04f70263          	beq	a4,a5,800076a0 <uartintr+0xa0>
    80007660:	100005b7          	lui	a1,0x10000
    80007664:	0000a817          	auipc	a6,0xa
    80007668:	91c80813          	addi	a6,a6,-1764 # 80010f80 <uart_tx_buf>
    8000766c:	01c0006f          	j	80007688 <uartintr+0x88>
    80007670:	0006c703          	lbu	a4,0(a3)
    80007674:	00f63023          	sd	a5,0(a2)
    80007678:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000767c:	00063783          	ld	a5,0(a2)
    80007680:	00053703          	ld	a4,0(a0)
    80007684:	00f70e63          	beq	a4,a5,800076a0 <uartintr+0xa0>
    80007688:	01f7f713          	andi	a4,a5,31
    8000768c:	00e806b3          	add	a3,a6,a4
    80007690:	0055c703          	lbu	a4,5(a1)
    80007694:	00178793          	addi	a5,a5,1
    80007698:	02077713          	andi	a4,a4,32
    8000769c:	fc071ae3          	bnez	a4,80007670 <uartintr+0x70>
    800076a0:	01813083          	ld	ra,24(sp)
    800076a4:	01013403          	ld	s0,16(sp)
    800076a8:	00813483          	ld	s1,8(sp)
    800076ac:	02010113          	addi	sp,sp,32
    800076b0:	00008067          	ret
    800076b4:	00004617          	auipc	a2,0x4
    800076b8:	42c60613          	addi	a2,a2,1068 # 8000bae0 <uart_tx_r>
    800076bc:	00004517          	auipc	a0,0x4
    800076c0:	42c50513          	addi	a0,a0,1068 # 8000bae8 <uart_tx_w>
    800076c4:	00063783          	ld	a5,0(a2)
    800076c8:	00053703          	ld	a4,0(a0)
    800076cc:	04f70263          	beq	a4,a5,80007710 <uartintr+0x110>
    800076d0:	100005b7          	lui	a1,0x10000
    800076d4:	0000a817          	auipc	a6,0xa
    800076d8:	8ac80813          	addi	a6,a6,-1876 # 80010f80 <uart_tx_buf>
    800076dc:	01c0006f          	j	800076f8 <uartintr+0xf8>
    800076e0:	0006c703          	lbu	a4,0(a3)
    800076e4:	00f63023          	sd	a5,0(a2)
    800076e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800076ec:	00063783          	ld	a5,0(a2)
    800076f0:	00053703          	ld	a4,0(a0)
    800076f4:	02f70063          	beq	a4,a5,80007714 <uartintr+0x114>
    800076f8:	01f7f713          	andi	a4,a5,31
    800076fc:	00e806b3          	add	a3,a6,a4
    80007700:	0055c703          	lbu	a4,5(a1)
    80007704:	00178793          	addi	a5,a5,1
    80007708:	02077713          	andi	a4,a4,32
    8000770c:	fc071ae3          	bnez	a4,800076e0 <uartintr+0xe0>
    80007710:	00008067          	ret
    80007714:	00008067          	ret

0000000080007718 <kinit>:
    80007718:	fc010113          	addi	sp,sp,-64
    8000771c:	02913423          	sd	s1,40(sp)
    80007720:	fffff7b7          	lui	a5,0xfffff
    80007724:	0000b497          	auipc	s1,0xb
    80007728:	87b48493          	addi	s1,s1,-1925 # 80011f9f <end+0xfff>
    8000772c:	02813823          	sd	s0,48(sp)
    80007730:	01313c23          	sd	s3,24(sp)
    80007734:	00f4f4b3          	and	s1,s1,a5
    80007738:	02113c23          	sd	ra,56(sp)
    8000773c:	03213023          	sd	s2,32(sp)
    80007740:	01413823          	sd	s4,16(sp)
    80007744:	01513423          	sd	s5,8(sp)
    80007748:	04010413          	addi	s0,sp,64
    8000774c:	000017b7          	lui	a5,0x1
    80007750:	01100993          	li	s3,17
    80007754:	00f487b3          	add	a5,s1,a5
    80007758:	01b99993          	slli	s3,s3,0x1b
    8000775c:	06f9e063          	bltu	s3,a5,800077bc <kinit+0xa4>
    80007760:	0000aa97          	auipc	s5,0xa
    80007764:	840a8a93          	addi	s5,s5,-1984 # 80010fa0 <end>
    80007768:	0754ec63          	bltu	s1,s5,800077e0 <kinit+0xc8>
    8000776c:	0734fa63          	bgeu	s1,s3,800077e0 <kinit+0xc8>
    80007770:	00088a37          	lui	s4,0x88
    80007774:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007778:	00004917          	auipc	s2,0x4
    8000777c:	37890913          	addi	s2,s2,888 # 8000baf0 <kmem>
    80007780:	00ca1a13          	slli	s4,s4,0xc
    80007784:	0140006f          	j	80007798 <kinit+0x80>
    80007788:	000017b7          	lui	a5,0x1
    8000778c:	00f484b3          	add	s1,s1,a5
    80007790:	0554e863          	bltu	s1,s5,800077e0 <kinit+0xc8>
    80007794:	0534f663          	bgeu	s1,s3,800077e0 <kinit+0xc8>
    80007798:	00001637          	lui	a2,0x1
    8000779c:	00100593          	li	a1,1
    800077a0:	00048513          	mv	a0,s1
    800077a4:	00000097          	auipc	ra,0x0
    800077a8:	5e4080e7          	jalr	1508(ra) # 80007d88 <__memset>
    800077ac:	00093783          	ld	a5,0(s2)
    800077b0:	00f4b023          	sd	a5,0(s1)
    800077b4:	00993023          	sd	s1,0(s2)
    800077b8:	fd4498e3          	bne	s1,s4,80007788 <kinit+0x70>
    800077bc:	03813083          	ld	ra,56(sp)
    800077c0:	03013403          	ld	s0,48(sp)
    800077c4:	02813483          	ld	s1,40(sp)
    800077c8:	02013903          	ld	s2,32(sp)
    800077cc:	01813983          	ld	s3,24(sp)
    800077d0:	01013a03          	ld	s4,16(sp)
    800077d4:	00813a83          	ld	s5,8(sp)
    800077d8:	04010113          	addi	sp,sp,64
    800077dc:	00008067          	ret
    800077e0:	00002517          	auipc	a0,0x2
    800077e4:	fe050513          	addi	a0,a0,-32 # 800097c0 <digits+0x18>
    800077e8:	fffff097          	auipc	ra,0xfffff
    800077ec:	4b4080e7          	jalr	1204(ra) # 80006c9c <panic>

00000000800077f0 <freerange>:
    800077f0:	fc010113          	addi	sp,sp,-64
    800077f4:	000017b7          	lui	a5,0x1
    800077f8:	02913423          	sd	s1,40(sp)
    800077fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007800:	009504b3          	add	s1,a0,s1
    80007804:	fffff537          	lui	a0,0xfffff
    80007808:	02813823          	sd	s0,48(sp)
    8000780c:	02113c23          	sd	ra,56(sp)
    80007810:	03213023          	sd	s2,32(sp)
    80007814:	01313c23          	sd	s3,24(sp)
    80007818:	01413823          	sd	s4,16(sp)
    8000781c:	01513423          	sd	s5,8(sp)
    80007820:	01613023          	sd	s6,0(sp)
    80007824:	04010413          	addi	s0,sp,64
    80007828:	00a4f4b3          	and	s1,s1,a0
    8000782c:	00f487b3          	add	a5,s1,a5
    80007830:	06f5e463          	bltu	a1,a5,80007898 <freerange+0xa8>
    80007834:	00009a97          	auipc	s5,0x9
    80007838:	76ca8a93          	addi	s5,s5,1900 # 80010fa0 <end>
    8000783c:	0954e263          	bltu	s1,s5,800078c0 <freerange+0xd0>
    80007840:	01100993          	li	s3,17
    80007844:	01b99993          	slli	s3,s3,0x1b
    80007848:	0734fc63          	bgeu	s1,s3,800078c0 <freerange+0xd0>
    8000784c:	00058a13          	mv	s4,a1
    80007850:	00004917          	auipc	s2,0x4
    80007854:	2a090913          	addi	s2,s2,672 # 8000baf0 <kmem>
    80007858:	00002b37          	lui	s6,0x2
    8000785c:	0140006f          	j	80007870 <freerange+0x80>
    80007860:	000017b7          	lui	a5,0x1
    80007864:	00f484b3          	add	s1,s1,a5
    80007868:	0554ec63          	bltu	s1,s5,800078c0 <freerange+0xd0>
    8000786c:	0534fa63          	bgeu	s1,s3,800078c0 <freerange+0xd0>
    80007870:	00001637          	lui	a2,0x1
    80007874:	00100593          	li	a1,1
    80007878:	00048513          	mv	a0,s1
    8000787c:	00000097          	auipc	ra,0x0
    80007880:	50c080e7          	jalr	1292(ra) # 80007d88 <__memset>
    80007884:	00093703          	ld	a4,0(s2)
    80007888:	016487b3          	add	a5,s1,s6
    8000788c:	00e4b023          	sd	a4,0(s1)
    80007890:	00993023          	sd	s1,0(s2)
    80007894:	fcfa76e3          	bgeu	s4,a5,80007860 <freerange+0x70>
    80007898:	03813083          	ld	ra,56(sp)
    8000789c:	03013403          	ld	s0,48(sp)
    800078a0:	02813483          	ld	s1,40(sp)
    800078a4:	02013903          	ld	s2,32(sp)
    800078a8:	01813983          	ld	s3,24(sp)
    800078ac:	01013a03          	ld	s4,16(sp)
    800078b0:	00813a83          	ld	s5,8(sp)
    800078b4:	00013b03          	ld	s6,0(sp)
    800078b8:	04010113          	addi	sp,sp,64
    800078bc:	00008067          	ret
    800078c0:	00002517          	auipc	a0,0x2
    800078c4:	f0050513          	addi	a0,a0,-256 # 800097c0 <digits+0x18>
    800078c8:	fffff097          	auipc	ra,0xfffff
    800078cc:	3d4080e7          	jalr	980(ra) # 80006c9c <panic>

00000000800078d0 <kfree>:
    800078d0:	fe010113          	addi	sp,sp,-32
    800078d4:	00813823          	sd	s0,16(sp)
    800078d8:	00113c23          	sd	ra,24(sp)
    800078dc:	00913423          	sd	s1,8(sp)
    800078e0:	02010413          	addi	s0,sp,32
    800078e4:	03451793          	slli	a5,a0,0x34
    800078e8:	04079c63          	bnez	a5,80007940 <kfree+0x70>
    800078ec:	00009797          	auipc	a5,0x9
    800078f0:	6b478793          	addi	a5,a5,1716 # 80010fa0 <end>
    800078f4:	00050493          	mv	s1,a0
    800078f8:	04f56463          	bltu	a0,a5,80007940 <kfree+0x70>
    800078fc:	01100793          	li	a5,17
    80007900:	01b79793          	slli	a5,a5,0x1b
    80007904:	02f57e63          	bgeu	a0,a5,80007940 <kfree+0x70>
    80007908:	00001637          	lui	a2,0x1
    8000790c:	00100593          	li	a1,1
    80007910:	00000097          	auipc	ra,0x0
    80007914:	478080e7          	jalr	1144(ra) # 80007d88 <__memset>
    80007918:	00004797          	auipc	a5,0x4
    8000791c:	1d878793          	addi	a5,a5,472 # 8000baf0 <kmem>
    80007920:	0007b703          	ld	a4,0(a5)
    80007924:	01813083          	ld	ra,24(sp)
    80007928:	01013403          	ld	s0,16(sp)
    8000792c:	00e4b023          	sd	a4,0(s1)
    80007930:	0097b023          	sd	s1,0(a5)
    80007934:	00813483          	ld	s1,8(sp)
    80007938:	02010113          	addi	sp,sp,32
    8000793c:	00008067          	ret
    80007940:	00002517          	auipc	a0,0x2
    80007944:	e8050513          	addi	a0,a0,-384 # 800097c0 <digits+0x18>
    80007948:	fffff097          	auipc	ra,0xfffff
    8000794c:	354080e7          	jalr	852(ra) # 80006c9c <panic>

0000000080007950 <kalloc>:
    80007950:	fe010113          	addi	sp,sp,-32
    80007954:	00813823          	sd	s0,16(sp)
    80007958:	00913423          	sd	s1,8(sp)
    8000795c:	00113c23          	sd	ra,24(sp)
    80007960:	02010413          	addi	s0,sp,32
    80007964:	00004797          	auipc	a5,0x4
    80007968:	18c78793          	addi	a5,a5,396 # 8000baf0 <kmem>
    8000796c:	0007b483          	ld	s1,0(a5)
    80007970:	02048063          	beqz	s1,80007990 <kalloc+0x40>
    80007974:	0004b703          	ld	a4,0(s1)
    80007978:	00001637          	lui	a2,0x1
    8000797c:	00500593          	li	a1,5
    80007980:	00048513          	mv	a0,s1
    80007984:	00e7b023          	sd	a4,0(a5)
    80007988:	00000097          	auipc	ra,0x0
    8000798c:	400080e7          	jalr	1024(ra) # 80007d88 <__memset>
    80007990:	01813083          	ld	ra,24(sp)
    80007994:	01013403          	ld	s0,16(sp)
    80007998:	00048513          	mv	a0,s1
    8000799c:	00813483          	ld	s1,8(sp)
    800079a0:	02010113          	addi	sp,sp,32
    800079a4:	00008067          	ret

00000000800079a8 <initlock>:
    800079a8:	ff010113          	addi	sp,sp,-16
    800079ac:	00813423          	sd	s0,8(sp)
    800079b0:	01010413          	addi	s0,sp,16
    800079b4:	00813403          	ld	s0,8(sp)
    800079b8:	00b53423          	sd	a1,8(a0)
    800079bc:	00052023          	sw	zero,0(a0)
    800079c0:	00053823          	sd	zero,16(a0)
    800079c4:	01010113          	addi	sp,sp,16
    800079c8:	00008067          	ret

00000000800079cc <acquire>:
    800079cc:	fe010113          	addi	sp,sp,-32
    800079d0:	00813823          	sd	s0,16(sp)
    800079d4:	00913423          	sd	s1,8(sp)
    800079d8:	00113c23          	sd	ra,24(sp)
    800079dc:	01213023          	sd	s2,0(sp)
    800079e0:	02010413          	addi	s0,sp,32
    800079e4:	00050493          	mv	s1,a0
    800079e8:	10002973          	csrr	s2,sstatus
    800079ec:	100027f3          	csrr	a5,sstatus
    800079f0:	ffd7f793          	andi	a5,a5,-3
    800079f4:	10079073          	csrw	sstatus,a5
    800079f8:	fffff097          	auipc	ra,0xfffff
    800079fc:	8e4080e7          	jalr	-1820(ra) # 800062dc <mycpu>
    80007a00:	07852783          	lw	a5,120(a0)
    80007a04:	06078e63          	beqz	a5,80007a80 <acquire+0xb4>
    80007a08:	fffff097          	auipc	ra,0xfffff
    80007a0c:	8d4080e7          	jalr	-1836(ra) # 800062dc <mycpu>
    80007a10:	07852783          	lw	a5,120(a0)
    80007a14:	0004a703          	lw	a4,0(s1)
    80007a18:	0017879b          	addiw	a5,a5,1
    80007a1c:	06f52c23          	sw	a5,120(a0)
    80007a20:	04071063          	bnez	a4,80007a60 <acquire+0x94>
    80007a24:	00100713          	li	a4,1
    80007a28:	00070793          	mv	a5,a4
    80007a2c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007a30:	0007879b          	sext.w	a5,a5
    80007a34:	fe079ae3          	bnez	a5,80007a28 <acquire+0x5c>
    80007a38:	0ff0000f          	fence
    80007a3c:	fffff097          	auipc	ra,0xfffff
    80007a40:	8a0080e7          	jalr	-1888(ra) # 800062dc <mycpu>
    80007a44:	01813083          	ld	ra,24(sp)
    80007a48:	01013403          	ld	s0,16(sp)
    80007a4c:	00a4b823          	sd	a0,16(s1)
    80007a50:	00013903          	ld	s2,0(sp)
    80007a54:	00813483          	ld	s1,8(sp)
    80007a58:	02010113          	addi	sp,sp,32
    80007a5c:	00008067          	ret
    80007a60:	0104b903          	ld	s2,16(s1)
    80007a64:	fffff097          	auipc	ra,0xfffff
    80007a68:	878080e7          	jalr	-1928(ra) # 800062dc <mycpu>
    80007a6c:	faa91ce3          	bne	s2,a0,80007a24 <acquire+0x58>
    80007a70:	00002517          	auipc	a0,0x2
    80007a74:	d5850513          	addi	a0,a0,-680 # 800097c8 <digits+0x20>
    80007a78:	fffff097          	auipc	ra,0xfffff
    80007a7c:	224080e7          	jalr	548(ra) # 80006c9c <panic>
    80007a80:	00195913          	srli	s2,s2,0x1
    80007a84:	fffff097          	auipc	ra,0xfffff
    80007a88:	858080e7          	jalr	-1960(ra) # 800062dc <mycpu>
    80007a8c:	00197913          	andi	s2,s2,1
    80007a90:	07252e23          	sw	s2,124(a0)
    80007a94:	f75ff06f          	j	80007a08 <acquire+0x3c>

0000000080007a98 <release>:
    80007a98:	fe010113          	addi	sp,sp,-32
    80007a9c:	00813823          	sd	s0,16(sp)
    80007aa0:	00113c23          	sd	ra,24(sp)
    80007aa4:	00913423          	sd	s1,8(sp)
    80007aa8:	01213023          	sd	s2,0(sp)
    80007aac:	02010413          	addi	s0,sp,32
    80007ab0:	00052783          	lw	a5,0(a0)
    80007ab4:	00079a63          	bnez	a5,80007ac8 <release+0x30>
    80007ab8:	00002517          	auipc	a0,0x2
    80007abc:	d1850513          	addi	a0,a0,-744 # 800097d0 <digits+0x28>
    80007ac0:	fffff097          	auipc	ra,0xfffff
    80007ac4:	1dc080e7          	jalr	476(ra) # 80006c9c <panic>
    80007ac8:	01053903          	ld	s2,16(a0)
    80007acc:	00050493          	mv	s1,a0
    80007ad0:	fffff097          	auipc	ra,0xfffff
    80007ad4:	80c080e7          	jalr	-2036(ra) # 800062dc <mycpu>
    80007ad8:	fea910e3          	bne	s2,a0,80007ab8 <release+0x20>
    80007adc:	0004b823          	sd	zero,16(s1)
    80007ae0:	0ff0000f          	fence
    80007ae4:	0f50000f          	fence	iorw,ow
    80007ae8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007aec:	ffffe097          	auipc	ra,0xffffe
    80007af0:	7f0080e7          	jalr	2032(ra) # 800062dc <mycpu>
    80007af4:	100027f3          	csrr	a5,sstatus
    80007af8:	0027f793          	andi	a5,a5,2
    80007afc:	04079a63          	bnez	a5,80007b50 <release+0xb8>
    80007b00:	07852783          	lw	a5,120(a0)
    80007b04:	02f05e63          	blez	a5,80007b40 <release+0xa8>
    80007b08:	fff7871b          	addiw	a4,a5,-1
    80007b0c:	06e52c23          	sw	a4,120(a0)
    80007b10:	00071c63          	bnez	a4,80007b28 <release+0x90>
    80007b14:	07c52783          	lw	a5,124(a0)
    80007b18:	00078863          	beqz	a5,80007b28 <release+0x90>
    80007b1c:	100027f3          	csrr	a5,sstatus
    80007b20:	0027e793          	ori	a5,a5,2
    80007b24:	10079073          	csrw	sstatus,a5
    80007b28:	01813083          	ld	ra,24(sp)
    80007b2c:	01013403          	ld	s0,16(sp)
    80007b30:	00813483          	ld	s1,8(sp)
    80007b34:	00013903          	ld	s2,0(sp)
    80007b38:	02010113          	addi	sp,sp,32
    80007b3c:	00008067          	ret
    80007b40:	00002517          	auipc	a0,0x2
    80007b44:	cb050513          	addi	a0,a0,-848 # 800097f0 <digits+0x48>
    80007b48:	fffff097          	auipc	ra,0xfffff
    80007b4c:	154080e7          	jalr	340(ra) # 80006c9c <panic>
    80007b50:	00002517          	auipc	a0,0x2
    80007b54:	c8850513          	addi	a0,a0,-888 # 800097d8 <digits+0x30>
    80007b58:	fffff097          	auipc	ra,0xfffff
    80007b5c:	144080e7          	jalr	324(ra) # 80006c9c <panic>

0000000080007b60 <holding>:
    80007b60:	00052783          	lw	a5,0(a0)
    80007b64:	00079663          	bnez	a5,80007b70 <holding+0x10>
    80007b68:	00000513          	li	a0,0
    80007b6c:	00008067          	ret
    80007b70:	fe010113          	addi	sp,sp,-32
    80007b74:	00813823          	sd	s0,16(sp)
    80007b78:	00913423          	sd	s1,8(sp)
    80007b7c:	00113c23          	sd	ra,24(sp)
    80007b80:	02010413          	addi	s0,sp,32
    80007b84:	01053483          	ld	s1,16(a0)
    80007b88:	ffffe097          	auipc	ra,0xffffe
    80007b8c:	754080e7          	jalr	1876(ra) # 800062dc <mycpu>
    80007b90:	01813083          	ld	ra,24(sp)
    80007b94:	01013403          	ld	s0,16(sp)
    80007b98:	40a48533          	sub	a0,s1,a0
    80007b9c:	00153513          	seqz	a0,a0
    80007ba0:	00813483          	ld	s1,8(sp)
    80007ba4:	02010113          	addi	sp,sp,32
    80007ba8:	00008067          	ret

0000000080007bac <push_off>:
    80007bac:	fe010113          	addi	sp,sp,-32
    80007bb0:	00813823          	sd	s0,16(sp)
    80007bb4:	00113c23          	sd	ra,24(sp)
    80007bb8:	00913423          	sd	s1,8(sp)
    80007bbc:	02010413          	addi	s0,sp,32
    80007bc0:	100024f3          	csrr	s1,sstatus
    80007bc4:	100027f3          	csrr	a5,sstatus
    80007bc8:	ffd7f793          	andi	a5,a5,-3
    80007bcc:	10079073          	csrw	sstatus,a5
    80007bd0:	ffffe097          	auipc	ra,0xffffe
    80007bd4:	70c080e7          	jalr	1804(ra) # 800062dc <mycpu>
    80007bd8:	07852783          	lw	a5,120(a0)
    80007bdc:	02078663          	beqz	a5,80007c08 <push_off+0x5c>
    80007be0:	ffffe097          	auipc	ra,0xffffe
    80007be4:	6fc080e7          	jalr	1788(ra) # 800062dc <mycpu>
    80007be8:	07852783          	lw	a5,120(a0)
    80007bec:	01813083          	ld	ra,24(sp)
    80007bf0:	01013403          	ld	s0,16(sp)
    80007bf4:	0017879b          	addiw	a5,a5,1
    80007bf8:	06f52c23          	sw	a5,120(a0)
    80007bfc:	00813483          	ld	s1,8(sp)
    80007c00:	02010113          	addi	sp,sp,32
    80007c04:	00008067          	ret
    80007c08:	0014d493          	srli	s1,s1,0x1
    80007c0c:	ffffe097          	auipc	ra,0xffffe
    80007c10:	6d0080e7          	jalr	1744(ra) # 800062dc <mycpu>
    80007c14:	0014f493          	andi	s1,s1,1
    80007c18:	06952e23          	sw	s1,124(a0)
    80007c1c:	fc5ff06f          	j	80007be0 <push_off+0x34>

0000000080007c20 <pop_off>:
    80007c20:	ff010113          	addi	sp,sp,-16
    80007c24:	00813023          	sd	s0,0(sp)
    80007c28:	00113423          	sd	ra,8(sp)
    80007c2c:	01010413          	addi	s0,sp,16
    80007c30:	ffffe097          	auipc	ra,0xffffe
    80007c34:	6ac080e7          	jalr	1708(ra) # 800062dc <mycpu>
    80007c38:	100027f3          	csrr	a5,sstatus
    80007c3c:	0027f793          	andi	a5,a5,2
    80007c40:	04079663          	bnez	a5,80007c8c <pop_off+0x6c>
    80007c44:	07852783          	lw	a5,120(a0)
    80007c48:	02f05a63          	blez	a5,80007c7c <pop_off+0x5c>
    80007c4c:	fff7871b          	addiw	a4,a5,-1
    80007c50:	06e52c23          	sw	a4,120(a0)
    80007c54:	00071c63          	bnez	a4,80007c6c <pop_off+0x4c>
    80007c58:	07c52783          	lw	a5,124(a0)
    80007c5c:	00078863          	beqz	a5,80007c6c <pop_off+0x4c>
    80007c60:	100027f3          	csrr	a5,sstatus
    80007c64:	0027e793          	ori	a5,a5,2
    80007c68:	10079073          	csrw	sstatus,a5
    80007c6c:	00813083          	ld	ra,8(sp)
    80007c70:	00013403          	ld	s0,0(sp)
    80007c74:	01010113          	addi	sp,sp,16
    80007c78:	00008067          	ret
    80007c7c:	00002517          	auipc	a0,0x2
    80007c80:	b7450513          	addi	a0,a0,-1164 # 800097f0 <digits+0x48>
    80007c84:	fffff097          	auipc	ra,0xfffff
    80007c88:	018080e7          	jalr	24(ra) # 80006c9c <panic>
    80007c8c:	00002517          	auipc	a0,0x2
    80007c90:	b4c50513          	addi	a0,a0,-1204 # 800097d8 <digits+0x30>
    80007c94:	fffff097          	auipc	ra,0xfffff
    80007c98:	008080e7          	jalr	8(ra) # 80006c9c <panic>

0000000080007c9c <push_on>:
    80007c9c:	fe010113          	addi	sp,sp,-32
    80007ca0:	00813823          	sd	s0,16(sp)
    80007ca4:	00113c23          	sd	ra,24(sp)
    80007ca8:	00913423          	sd	s1,8(sp)
    80007cac:	02010413          	addi	s0,sp,32
    80007cb0:	100024f3          	csrr	s1,sstatus
    80007cb4:	100027f3          	csrr	a5,sstatus
    80007cb8:	0027e793          	ori	a5,a5,2
    80007cbc:	10079073          	csrw	sstatus,a5
    80007cc0:	ffffe097          	auipc	ra,0xffffe
    80007cc4:	61c080e7          	jalr	1564(ra) # 800062dc <mycpu>
    80007cc8:	07852783          	lw	a5,120(a0)
    80007ccc:	02078663          	beqz	a5,80007cf8 <push_on+0x5c>
    80007cd0:	ffffe097          	auipc	ra,0xffffe
    80007cd4:	60c080e7          	jalr	1548(ra) # 800062dc <mycpu>
    80007cd8:	07852783          	lw	a5,120(a0)
    80007cdc:	01813083          	ld	ra,24(sp)
    80007ce0:	01013403          	ld	s0,16(sp)
    80007ce4:	0017879b          	addiw	a5,a5,1
    80007ce8:	06f52c23          	sw	a5,120(a0)
    80007cec:	00813483          	ld	s1,8(sp)
    80007cf0:	02010113          	addi	sp,sp,32
    80007cf4:	00008067          	ret
    80007cf8:	0014d493          	srli	s1,s1,0x1
    80007cfc:	ffffe097          	auipc	ra,0xffffe
    80007d00:	5e0080e7          	jalr	1504(ra) # 800062dc <mycpu>
    80007d04:	0014f493          	andi	s1,s1,1
    80007d08:	06952e23          	sw	s1,124(a0)
    80007d0c:	fc5ff06f          	j	80007cd0 <push_on+0x34>

0000000080007d10 <pop_on>:
    80007d10:	ff010113          	addi	sp,sp,-16
    80007d14:	00813023          	sd	s0,0(sp)
    80007d18:	00113423          	sd	ra,8(sp)
    80007d1c:	01010413          	addi	s0,sp,16
    80007d20:	ffffe097          	auipc	ra,0xffffe
    80007d24:	5bc080e7          	jalr	1468(ra) # 800062dc <mycpu>
    80007d28:	100027f3          	csrr	a5,sstatus
    80007d2c:	0027f793          	andi	a5,a5,2
    80007d30:	04078463          	beqz	a5,80007d78 <pop_on+0x68>
    80007d34:	07852783          	lw	a5,120(a0)
    80007d38:	02f05863          	blez	a5,80007d68 <pop_on+0x58>
    80007d3c:	fff7879b          	addiw	a5,a5,-1
    80007d40:	06f52c23          	sw	a5,120(a0)
    80007d44:	07853783          	ld	a5,120(a0)
    80007d48:	00079863          	bnez	a5,80007d58 <pop_on+0x48>
    80007d4c:	100027f3          	csrr	a5,sstatus
    80007d50:	ffd7f793          	andi	a5,a5,-3
    80007d54:	10079073          	csrw	sstatus,a5
    80007d58:	00813083          	ld	ra,8(sp)
    80007d5c:	00013403          	ld	s0,0(sp)
    80007d60:	01010113          	addi	sp,sp,16
    80007d64:	00008067          	ret
    80007d68:	00002517          	auipc	a0,0x2
    80007d6c:	ab050513          	addi	a0,a0,-1360 # 80009818 <digits+0x70>
    80007d70:	fffff097          	auipc	ra,0xfffff
    80007d74:	f2c080e7          	jalr	-212(ra) # 80006c9c <panic>
    80007d78:	00002517          	auipc	a0,0x2
    80007d7c:	a8050513          	addi	a0,a0,-1408 # 800097f8 <digits+0x50>
    80007d80:	fffff097          	auipc	ra,0xfffff
    80007d84:	f1c080e7          	jalr	-228(ra) # 80006c9c <panic>

0000000080007d88 <__memset>:
    80007d88:	ff010113          	addi	sp,sp,-16
    80007d8c:	00813423          	sd	s0,8(sp)
    80007d90:	01010413          	addi	s0,sp,16
    80007d94:	1a060e63          	beqz	a2,80007f50 <__memset+0x1c8>
    80007d98:	40a007b3          	neg	a5,a0
    80007d9c:	0077f793          	andi	a5,a5,7
    80007da0:	00778693          	addi	a3,a5,7
    80007da4:	00b00813          	li	a6,11
    80007da8:	0ff5f593          	andi	a1,a1,255
    80007dac:	fff6071b          	addiw	a4,a2,-1
    80007db0:	1b06e663          	bltu	a3,a6,80007f5c <__memset+0x1d4>
    80007db4:	1cd76463          	bltu	a4,a3,80007f7c <__memset+0x1f4>
    80007db8:	1a078e63          	beqz	a5,80007f74 <__memset+0x1ec>
    80007dbc:	00b50023          	sb	a1,0(a0)
    80007dc0:	00100713          	li	a4,1
    80007dc4:	1ae78463          	beq	a5,a4,80007f6c <__memset+0x1e4>
    80007dc8:	00b500a3          	sb	a1,1(a0)
    80007dcc:	00200713          	li	a4,2
    80007dd0:	1ae78a63          	beq	a5,a4,80007f84 <__memset+0x1fc>
    80007dd4:	00b50123          	sb	a1,2(a0)
    80007dd8:	00300713          	li	a4,3
    80007ddc:	18e78463          	beq	a5,a4,80007f64 <__memset+0x1dc>
    80007de0:	00b501a3          	sb	a1,3(a0)
    80007de4:	00400713          	li	a4,4
    80007de8:	1ae78263          	beq	a5,a4,80007f8c <__memset+0x204>
    80007dec:	00b50223          	sb	a1,4(a0)
    80007df0:	00500713          	li	a4,5
    80007df4:	1ae78063          	beq	a5,a4,80007f94 <__memset+0x20c>
    80007df8:	00b502a3          	sb	a1,5(a0)
    80007dfc:	00700713          	li	a4,7
    80007e00:	18e79e63          	bne	a5,a4,80007f9c <__memset+0x214>
    80007e04:	00b50323          	sb	a1,6(a0)
    80007e08:	00700e93          	li	t4,7
    80007e0c:	00859713          	slli	a4,a1,0x8
    80007e10:	00e5e733          	or	a4,a1,a4
    80007e14:	01059e13          	slli	t3,a1,0x10
    80007e18:	01c76e33          	or	t3,a4,t3
    80007e1c:	01859313          	slli	t1,a1,0x18
    80007e20:	006e6333          	or	t1,t3,t1
    80007e24:	02059893          	slli	a7,a1,0x20
    80007e28:	40f60e3b          	subw	t3,a2,a5
    80007e2c:	011368b3          	or	a7,t1,a7
    80007e30:	02859813          	slli	a6,a1,0x28
    80007e34:	0108e833          	or	a6,a7,a6
    80007e38:	03059693          	slli	a3,a1,0x30
    80007e3c:	003e589b          	srliw	a7,t3,0x3
    80007e40:	00d866b3          	or	a3,a6,a3
    80007e44:	03859713          	slli	a4,a1,0x38
    80007e48:	00389813          	slli	a6,a7,0x3
    80007e4c:	00f507b3          	add	a5,a0,a5
    80007e50:	00e6e733          	or	a4,a3,a4
    80007e54:	000e089b          	sext.w	a7,t3
    80007e58:	00f806b3          	add	a3,a6,a5
    80007e5c:	00e7b023          	sd	a4,0(a5)
    80007e60:	00878793          	addi	a5,a5,8
    80007e64:	fed79ce3          	bne	a5,a3,80007e5c <__memset+0xd4>
    80007e68:	ff8e7793          	andi	a5,t3,-8
    80007e6c:	0007871b          	sext.w	a4,a5
    80007e70:	01d787bb          	addw	a5,a5,t4
    80007e74:	0ce88e63          	beq	a7,a4,80007f50 <__memset+0x1c8>
    80007e78:	00f50733          	add	a4,a0,a5
    80007e7c:	00b70023          	sb	a1,0(a4)
    80007e80:	0017871b          	addiw	a4,a5,1
    80007e84:	0cc77663          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007e88:	00e50733          	add	a4,a0,a4
    80007e8c:	00b70023          	sb	a1,0(a4)
    80007e90:	0027871b          	addiw	a4,a5,2
    80007e94:	0ac77e63          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007e98:	00e50733          	add	a4,a0,a4
    80007e9c:	00b70023          	sb	a1,0(a4)
    80007ea0:	0037871b          	addiw	a4,a5,3
    80007ea4:	0ac77663          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007ea8:	00e50733          	add	a4,a0,a4
    80007eac:	00b70023          	sb	a1,0(a4)
    80007eb0:	0047871b          	addiw	a4,a5,4
    80007eb4:	08c77e63          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007eb8:	00e50733          	add	a4,a0,a4
    80007ebc:	00b70023          	sb	a1,0(a4)
    80007ec0:	0057871b          	addiw	a4,a5,5
    80007ec4:	08c77663          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007ec8:	00e50733          	add	a4,a0,a4
    80007ecc:	00b70023          	sb	a1,0(a4)
    80007ed0:	0067871b          	addiw	a4,a5,6
    80007ed4:	06c77e63          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007ed8:	00e50733          	add	a4,a0,a4
    80007edc:	00b70023          	sb	a1,0(a4)
    80007ee0:	0077871b          	addiw	a4,a5,7
    80007ee4:	06c77663          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007ee8:	00e50733          	add	a4,a0,a4
    80007eec:	00b70023          	sb	a1,0(a4)
    80007ef0:	0087871b          	addiw	a4,a5,8
    80007ef4:	04c77e63          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007ef8:	00e50733          	add	a4,a0,a4
    80007efc:	00b70023          	sb	a1,0(a4)
    80007f00:	0097871b          	addiw	a4,a5,9
    80007f04:	04c77663          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007f08:	00e50733          	add	a4,a0,a4
    80007f0c:	00b70023          	sb	a1,0(a4)
    80007f10:	00a7871b          	addiw	a4,a5,10
    80007f14:	02c77e63          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007f18:	00e50733          	add	a4,a0,a4
    80007f1c:	00b70023          	sb	a1,0(a4)
    80007f20:	00b7871b          	addiw	a4,a5,11
    80007f24:	02c77663          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007f28:	00e50733          	add	a4,a0,a4
    80007f2c:	00b70023          	sb	a1,0(a4)
    80007f30:	00c7871b          	addiw	a4,a5,12
    80007f34:	00c77e63          	bgeu	a4,a2,80007f50 <__memset+0x1c8>
    80007f38:	00e50733          	add	a4,a0,a4
    80007f3c:	00b70023          	sb	a1,0(a4)
    80007f40:	00d7879b          	addiw	a5,a5,13
    80007f44:	00c7f663          	bgeu	a5,a2,80007f50 <__memset+0x1c8>
    80007f48:	00f507b3          	add	a5,a0,a5
    80007f4c:	00b78023          	sb	a1,0(a5)
    80007f50:	00813403          	ld	s0,8(sp)
    80007f54:	01010113          	addi	sp,sp,16
    80007f58:	00008067          	ret
    80007f5c:	00b00693          	li	a3,11
    80007f60:	e55ff06f          	j	80007db4 <__memset+0x2c>
    80007f64:	00300e93          	li	t4,3
    80007f68:	ea5ff06f          	j	80007e0c <__memset+0x84>
    80007f6c:	00100e93          	li	t4,1
    80007f70:	e9dff06f          	j	80007e0c <__memset+0x84>
    80007f74:	00000e93          	li	t4,0
    80007f78:	e95ff06f          	j	80007e0c <__memset+0x84>
    80007f7c:	00000793          	li	a5,0
    80007f80:	ef9ff06f          	j	80007e78 <__memset+0xf0>
    80007f84:	00200e93          	li	t4,2
    80007f88:	e85ff06f          	j	80007e0c <__memset+0x84>
    80007f8c:	00400e93          	li	t4,4
    80007f90:	e7dff06f          	j	80007e0c <__memset+0x84>
    80007f94:	00500e93          	li	t4,5
    80007f98:	e75ff06f          	j	80007e0c <__memset+0x84>
    80007f9c:	00600e93          	li	t4,6
    80007fa0:	e6dff06f          	j	80007e0c <__memset+0x84>

0000000080007fa4 <__memmove>:
    80007fa4:	ff010113          	addi	sp,sp,-16
    80007fa8:	00813423          	sd	s0,8(sp)
    80007fac:	01010413          	addi	s0,sp,16
    80007fb0:	0e060863          	beqz	a2,800080a0 <__memmove+0xfc>
    80007fb4:	fff6069b          	addiw	a3,a2,-1
    80007fb8:	0006881b          	sext.w	a6,a3
    80007fbc:	0ea5e863          	bltu	a1,a0,800080ac <__memmove+0x108>
    80007fc0:	00758713          	addi	a4,a1,7
    80007fc4:	00a5e7b3          	or	a5,a1,a0
    80007fc8:	40a70733          	sub	a4,a4,a0
    80007fcc:	0077f793          	andi	a5,a5,7
    80007fd0:	00f73713          	sltiu	a4,a4,15
    80007fd4:	00174713          	xori	a4,a4,1
    80007fd8:	0017b793          	seqz	a5,a5
    80007fdc:	00e7f7b3          	and	a5,a5,a4
    80007fe0:	10078863          	beqz	a5,800080f0 <__memmove+0x14c>
    80007fe4:	00900793          	li	a5,9
    80007fe8:	1107f463          	bgeu	a5,a6,800080f0 <__memmove+0x14c>
    80007fec:	0036581b          	srliw	a6,a2,0x3
    80007ff0:	fff8081b          	addiw	a6,a6,-1
    80007ff4:	02081813          	slli	a6,a6,0x20
    80007ff8:	01d85893          	srli	a7,a6,0x1d
    80007ffc:	00858813          	addi	a6,a1,8
    80008000:	00058793          	mv	a5,a1
    80008004:	00050713          	mv	a4,a0
    80008008:	01088833          	add	a6,a7,a6
    8000800c:	0007b883          	ld	a7,0(a5)
    80008010:	00878793          	addi	a5,a5,8
    80008014:	00870713          	addi	a4,a4,8
    80008018:	ff173c23          	sd	a7,-8(a4)
    8000801c:	ff0798e3          	bne	a5,a6,8000800c <__memmove+0x68>
    80008020:	ff867713          	andi	a4,a2,-8
    80008024:	02071793          	slli	a5,a4,0x20
    80008028:	0207d793          	srli	a5,a5,0x20
    8000802c:	00f585b3          	add	a1,a1,a5
    80008030:	40e686bb          	subw	a3,a3,a4
    80008034:	00f507b3          	add	a5,a0,a5
    80008038:	06e60463          	beq	a2,a4,800080a0 <__memmove+0xfc>
    8000803c:	0005c703          	lbu	a4,0(a1)
    80008040:	00e78023          	sb	a4,0(a5)
    80008044:	04068e63          	beqz	a3,800080a0 <__memmove+0xfc>
    80008048:	0015c603          	lbu	a2,1(a1)
    8000804c:	00100713          	li	a4,1
    80008050:	00c780a3          	sb	a2,1(a5)
    80008054:	04e68663          	beq	a3,a4,800080a0 <__memmove+0xfc>
    80008058:	0025c603          	lbu	a2,2(a1)
    8000805c:	00200713          	li	a4,2
    80008060:	00c78123          	sb	a2,2(a5)
    80008064:	02e68e63          	beq	a3,a4,800080a0 <__memmove+0xfc>
    80008068:	0035c603          	lbu	a2,3(a1)
    8000806c:	00300713          	li	a4,3
    80008070:	00c781a3          	sb	a2,3(a5)
    80008074:	02e68663          	beq	a3,a4,800080a0 <__memmove+0xfc>
    80008078:	0045c603          	lbu	a2,4(a1)
    8000807c:	00400713          	li	a4,4
    80008080:	00c78223          	sb	a2,4(a5)
    80008084:	00e68e63          	beq	a3,a4,800080a0 <__memmove+0xfc>
    80008088:	0055c603          	lbu	a2,5(a1)
    8000808c:	00500713          	li	a4,5
    80008090:	00c782a3          	sb	a2,5(a5)
    80008094:	00e68663          	beq	a3,a4,800080a0 <__memmove+0xfc>
    80008098:	0065c703          	lbu	a4,6(a1)
    8000809c:	00e78323          	sb	a4,6(a5)
    800080a0:	00813403          	ld	s0,8(sp)
    800080a4:	01010113          	addi	sp,sp,16
    800080a8:	00008067          	ret
    800080ac:	02061713          	slli	a4,a2,0x20
    800080b0:	02075713          	srli	a4,a4,0x20
    800080b4:	00e587b3          	add	a5,a1,a4
    800080b8:	f0f574e3          	bgeu	a0,a5,80007fc0 <__memmove+0x1c>
    800080bc:	02069613          	slli	a2,a3,0x20
    800080c0:	02065613          	srli	a2,a2,0x20
    800080c4:	fff64613          	not	a2,a2
    800080c8:	00e50733          	add	a4,a0,a4
    800080cc:	00c78633          	add	a2,a5,a2
    800080d0:	fff7c683          	lbu	a3,-1(a5)
    800080d4:	fff78793          	addi	a5,a5,-1
    800080d8:	fff70713          	addi	a4,a4,-1
    800080dc:	00d70023          	sb	a3,0(a4)
    800080e0:	fec798e3          	bne	a5,a2,800080d0 <__memmove+0x12c>
    800080e4:	00813403          	ld	s0,8(sp)
    800080e8:	01010113          	addi	sp,sp,16
    800080ec:	00008067          	ret
    800080f0:	02069713          	slli	a4,a3,0x20
    800080f4:	02075713          	srli	a4,a4,0x20
    800080f8:	00170713          	addi	a4,a4,1
    800080fc:	00e50733          	add	a4,a0,a4
    80008100:	00050793          	mv	a5,a0
    80008104:	0005c683          	lbu	a3,0(a1)
    80008108:	00178793          	addi	a5,a5,1
    8000810c:	00158593          	addi	a1,a1,1
    80008110:	fed78fa3          	sb	a3,-1(a5)
    80008114:	fee798e3          	bne	a5,a4,80008104 <__memmove+0x160>
    80008118:	f89ff06f          	j	800080a0 <__memmove+0xfc>
	...
