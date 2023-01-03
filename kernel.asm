
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	da813103          	ld	sp,-600(sp) # 8000bda8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	031060ef          	jal	ra,8000684c <start>

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
    800010a8:	4e8030ef          	jal	ra,80004590 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	45c080e7          	jalr	1116(ra) # 800025dc <_ZN5Buddy4freeEPvm>
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
    800011e0:	19460613          	addi	a2,a2,404 # 80009370 <CONSOLE_STATUS+0x360>
    800011e4:	0005059b          	sext.w	a1,a0
    800011e8:	00008517          	auipc	a0,0x8
    800011ec:	e3850513          	addi	a0,a0,-456 # 80009020 <CONSOLE_STATUS+0x10>
    800011f0:	00004097          	auipc	ra,0x4
    800011f4:	e5c080e7          	jalr	-420(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011f8:	00008617          	auipc	a2,0x8
    800011fc:	17860613          	addi	a2,a2,376 # 80009370 <CONSOLE_STATUS+0x360>
    80001200:	01892583          	lw	a1,24(s2)
    80001204:	00008517          	auipc	a0,0x8
    80001208:	e2c50513          	addi	a0,a0,-468 # 80009030 <CONSOLE_STATUS+0x20>
    8000120c:	00004097          	auipc	ra,0x4
    80001210:	e40080e7          	jalr	-448(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    80001214:	00008617          	auipc	a2,0x8
    80001218:	15c60613          	addi	a2,a2,348 # 80009370 <CONSOLE_STATUS+0x360>
    8000121c:	01092583          	lw	a1,16(s2)
    80001220:	00008517          	auipc	a0,0x8
    80001224:	e2850513          	addi	a0,a0,-472 # 80009048 <CONSOLE_STATUS+0x38>
    80001228:	00004097          	auipc	ra,0x4
    8000122c:	e24080e7          	jalr	-476(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    80001230:	00008617          	auipc	a2,0x8
    80001234:	14060613          	addi	a2,a2,320 # 80009370 <CONSOLE_STATUS+0x360>
    80001238:	03800593          	li	a1,56
    8000123c:	00008517          	auipc	a0,0x8
    80001240:	e2450513          	addi	a0,a0,-476 # 80009060 <CONSOLE_STATUS+0x50>
    80001244:	00004097          	auipc	ra,0x4
    80001248:	e08080e7          	jalr	-504(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000124c:	00008617          	auipc	a2,0x8
    80001250:	12460613          	addi	a2,a2,292 # 80009370 <CONSOLE_STATUS+0x360>
    80001254:	02892583          	lw	a1,40(s2)
    80001258:	00008517          	auipc	a0,0x8
    8000125c:	e2050513          	addi	a0,a0,-480 # 80009078 <CONSOLE_STATUS+0x68>
    80001260:	00004097          	auipc	ra,0x4
    80001264:	dec080e7          	jalr	-532(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    80001268:	00008617          	auipc	a2,0x8
    8000126c:	10860613          	addi	a2,a2,264 # 80009370 <CONSOLE_STATUS+0x360>
    80001270:	02092583          	lw	a1,32(s2)
    80001274:	00008517          	auipc	a0,0x8
    80001278:	e1450513          	addi	a0,a0,-492 # 80009088 <CONSOLE_STATUS+0x78>
    8000127c:	00004097          	auipc	ra,0x4
    80001280:	dd0080e7          	jalr	-560(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::printString("Allocated status array:\n");
    80001284:	00008517          	auipc	a0,0x8
    80001288:	e2450513          	addi	a0,a0,-476 # 800090a8 <CONSOLE_STATUS+0x98>
    8000128c:	00004097          	auipc	ra,0x4
    80001290:	ca0080e7          	jalr	-864(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
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
    800012b4:	10050513          	addi	a0,a0,256 # 800093b0 <CONSOLE_STATUS+0x3a0>
    800012b8:	00004097          	auipc	ra,0x4
    800012bc:	d94080e7          	jalr	-620(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012c0:	00148493          	addi	s1,s1,1
    800012c4:	01893783          	ld	a5,24(s2)
    800012c8:	0037d793          	srli	a5,a5,0x3
    800012cc:	00178793          	addi	a5,a5,1
    800012d0:	fcf4e6e3          	bltu	s1,a5,8000129c <_ZN13SlabAllocator9printSlabEP4Slab+0xe0>
        }
        ConsoleUtil::printString("\n");
    800012d4:	00008517          	auipc	a0,0x8
    800012d8:	09c50513          	addi	a0,a0,156 # 80009370 <CONSOLE_STATUS+0x360>
    800012dc:	00004097          	auipc	ra,0x4
    800012e0:	c50080e7          	jalr	-944(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
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
    80001328:	c08080e7          	jalr	-1016(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    8000132c:	00090513          	mv	a0,s2
    80001330:	00004097          	auipc	ra,0x4
    80001334:	bfc080e7          	jalr	-1028(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001338:	00008517          	auipc	a0,0x8
    8000133c:	03850513          	addi	a0,a0,56 # 80009370 <CONSOLE_STATUS+0x360>
    80001340:	00004097          	auipc	ra,0x4
    80001344:	bec080e7          	jalr	-1044(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001348:	00008617          	auipc	a2,0x8
    8000134c:	02860613          	addi	a2,a2,40 # 80009370 <CONSOLE_STATUS+0x360>
    80001350:	0000b797          	auipc	a5,0xb
    80001354:	a287b783          	ld	a5,-1496(a5) # 8000bd78 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001358:	0007a583          	lw	a1,0(a5)
    8000135c:	00008517          	auipc	a0,0x8
    80001360:	d7c50513          	addi	a0,a0,-644 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001364:	00004097          	auipc	ra,0x4
    80001368:	ce8080e7          	jalr	-792(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	00008617          	auipc	a2,0x8
    80001370:	00460613          	addi	a2,a2,4 # 80009370 <CONSOLE_STATUS+0x360>
    80001374:	0009059b          	sext.w	a1,s2
    80001378:	00008517          	auipc	a0,0x8
    8000137c:	d7850513          	addi	a0,a0,-648 # 800090f0 <CONSOLE_STATUS+0xe0>
    80001380:	00004097          	auipc	ra,0x4
    80001384:	ccc080e7          	jalr	-820(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    80001388:	00008617          	auipc	a2,0x8
    8000138c:	fe860613          	addi	a2,a2,-24 # 80009370 <CONSOLE_STATUS+0x360>
    80001390:	04892583          	lw	a1,72(s2)
    80001394:	00008517          	auipc	a0,0x8
    80001398:	d6c50513          	addi	a0,a0,-660 # 80009100 <CONSOLE_STATUS+0xf0>
    8000139c:	00004097          	auipc	ra,0x4
    800013a0:	cb0080e7          	jalr	-848(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013a4:	00008617          	auipc	a2,0x8
    800013a8:	fcc60613          	addi	a2,a2,-52 # 80009370 <CONSOLE_STATUS+0x360>
    800013ac:	04092583          	lw	a1,64(s2)
    800013b0:	00008517          	auipc	a0,0x8
    800013b4:	d6850513          	addi	a0,a0,-664 # 80009118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	c94080e7          	jalr	-876(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013c0:	00008617          	auipc	a2,0x8
    800013c4:	fb060613          	addi	a2,a2,-80 # 80009370 <CONSOLE_STATUS+0x360>
    800013c8:	06092583          	lw	a1,96(s2)
    800013cc:	00008517          	auipc	a0,0x8
    800013d0:	d6450513          	addi	a0,a0,-668 # 80009130 <CONSOLE_STATUS+0x120>
    800013d4:	00004097          	auipc	ra,0x4
    800013d8:	c78080e7          	jalr	-904(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    800013dc:	06093483          	ld	s1,96(s2)
    while(iter){
    800013e0:	02048463          	beqz	s1,80001408 <_ZN13SlabAllocator10printCacheEP5Cache+0x108>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013e4:	00008617          	auipc	a2,0x8
    800013e8:	d0460613          	addi	a2,a2,-764 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013ec:	0004859b          	sext.w	a1,s1
    800013f0:	00008517          	auipc	a0,0x8
    800013f4:	fc050513          	addi	a0,a0,-64 # 800093b0 <CONSOLE_STATUS+0x3a0>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	c54080e7          	jalr	-940(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001400:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001404:	fddff06f          	j	800013e0 <_ZN13SlabAllocator10printCacheEP5Cache+0xe0>
    }
    ConsoleUtil::printString("\n");
    80001408:	00008517          	auipc	a0,0x8
    8000140c:	f6850513          	addi	a0,a0,-152 # 80009370 <CONSOLE_STATUS+0x360>
    80001410:	00004097          	auipc	ra,0x4
    80001414:	b1c080e7          	jalr	-1252(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001418:	00008617          	auipc	a2,0x8
    8000141c:	f5860613          	addi	a2,a2,-168 # 80009370 <CONSOLE_STATUS+0x360>
    80001420:	06892583          	lw	a1,104(s2)
    80001424:	00008517          	auipc	a0,0x8
    80001428:	d1c50513          	addi	a0,a0,-740 # 80009140 <CONSOLE_STATUS+0x130>
    8000142c:	00004097          	auipc	ra,0x4
    80001430:	c20080e7          	jalr	-992(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    80001434:	06893483          	ld	s1,104(s2)
    while(iter){
    80001438:	02048463          	beqz	s1,80001460 <_ZN13SlabAllocator10printCacheEP5Cache+0x160>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000143c:	00008617          	auipc	a2,0x8
    80001440:	cac60613          	addi	a2,a2,-852 # 800090e8 <CONSOLE_STATUS+0xd8>
    80001444:	0004859b          	sext.w	a1,s1
    80001448:	00008517          	auipc	a0,0x8
    8000144c:	f6850513          	addi	a0,a0,-152 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80001450:	00004097          	auipc	ra,0x4
    80001454:	bfc080e7          	jalr	-1028(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001458:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000145c:	fddff06f          	j	80001438 <_ZN13SlabAllocator10printCacheEP5Cache+0x138>
    }
    ConsoleUtil::printString("\n");
    80001460:	00008517          	auipc	a0,0x8
    80001464:	f1050513          	addi	a0,a0,-240 # 80009370 <CONSOLE_STATUS+0x360>
    80001468:	00004097          	auipc	ra,0x4
    8000146c:	ac4080e7          	jalr	-1340(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001470:	00008617          	auipc	a2,0x8
    80001474:	f0060613          	addi	a2,a2,-256 # 80009370 <CONSOLE_STATUS+0x360>
    80001478:	07092583          	lw	a1,112(s2)
    8000147c:	00008517          	auipc	a0,0x8
    80001480:	cd450513          	addi	a0,a0,-812 # 80009150 <CONSOLE_STATUS+0x140>
    80001484:	00004097          	auipc	ra,0x4
    80001488:	bc8080e7          	jalr	-1080(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    8000148c:	07093483          	ld	s1,112(s2)
    while(iter){
    80001490:	02048463          	beqz	s1,800014b8 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001494:	00008617          	auipc	a2,0x8
    80001498:	c5460613          	addi	a2,a2,-940 # 800090e8 <CONSOLE_STATUS+0xd8>
    8000149c:	0004859b          	sext.w	a1,s1
    800014a0:	00008517          	auipc	a0,0x8
    800014a4:	f1050513          	addi	a0,a0,-240 # 800093b0 <CONSOLE_STATUS+0x3a0>
    800014a8:	00004097          	auipc	ra,0x4
    800014ac:	ba4080e7          	jalr	-1116(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800014b0:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014b4:	fddff06f          	j	80001490 <_ZN13SlabAllocator10printCacheEP5Cache+0x190>
    }
    ConsoleUtil::printString("\n");
    800014b8:	00008517          	auipc	a0,0x8
    800014bc:	eb850513          	addi	a0,a0,-328 # 80009370 <CONSOLE_STATUS+0x360>
    800014c0:	00004097          	auipc	ra,0x4
    800014c4:	a6c080e7          	jalr	-1428(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    800014c8:	00008617          	auipc	a2,0x8
    800014cc:	ea860613          	addi	a2,a2,-344 # 80009370 <CONSOLE_STATUS+0x360>
    800014d0:	04092583          	lw	a1,64(s2)
    800014d4:	00008517          	auipc	a0,0x8
    800014d8:	c8c50513          	addi	a0,a0,-884 # 80009160 <CONSOLE_STATUS+0x150>
    800014dc:	00004097          	auipc	ra,0x4
    800014e0:	b70080e7          	jalr	-1168(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
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
    80001554:	164080e7          	jalr	356(ra) # 800026b4 <_ZN5Buddy5allocEm>
    if(!slab)
    80001558:	0a050863          	beqz	a0,80001608 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xdc>
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
    if(cache->ctor) {
    800015d0:	0509b783          	ld	a5,80(s3)
    800015d4:	02078e63          	beqz	a5,80001610 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015d8:	00000913          	li	s2,0
    800015dc:	0184b783          	ld	a5,24(s1)
    800015e0:	02f97c63          	bgeu	s2,a5,80001618 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800015e4:	0509b703          	ld	a4,80(s3)
    800015e8:	0284b503          	ld	a0,40(s1)
    800015ec:	0304b783          	ld	a5,48(s1)
    800015f0:	0407b783          	ld	a5,64(a5)
    800015f4:	032787b3          	mul	a5,a5,s2
    800015f8:	00f50533          	add	a0,a0,a5
    800015fc:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80001600:	00190913          	addi	s2,s2,1
    80001604:	fd9ff06f          	j	800015dc <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb0>
        return false;
    80001608:	00000513          	li	a0,0
    8000160c:	0100006f          	j	8000161c <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    return true;
    80001610:	00100513          	li	a0,1
    80001614:	0080006f          	j	8000161c <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    80001618:	00100513          	li	a0,1
}
    8000161c:	02813083          	ld	ra,40(sp)
    80001620:	02013403          	ld	s0,32(sp)
    80001624:	01813483          	ld	s1,24(sp)
    80001628:	01013903          	ld	s2,16(sp)
    8000162c:	00813983          	ld	s3,8(sp)
    80001630:	03010113          	addi	sp,sp,48
    80001634:	00008067          	ret

0000000080001638 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001638:	ff010113          	addi	sp,sp,-16
    8000163c:	00813423          	sd	s0,8(sp)
    80001640:	01010413          	addi	s0,sp,16
    if(slab == head)
    80001644:	00053783          	ld	a5,0(a0)
    80001648:	02b78c63          	beq	a5,a1,80001680 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    8000164c:	0085b783          	ld	a5,8(a1)
    80001650:	00078663          	beqz	a5,8000165c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    80001654:	0005b703          	ld	a4,0(a1)
    80001658:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    8000165c:	0005b783          	ld	a5,0(a1)
    80001660:	00078663          	beqz	a5,8000166c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    80001664:	0085b703          	ld	a4,8(a1)
    80001668:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    8000166c:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001670:	0005b423          	sd	zero,8(a1)
}
    80001674:	00813403          	ld	s0,8(sp)
    80001678:	01010113          	addi	sp,sp,16
    8000167c:	00008067          	ret
        head = slab->next;
    80001680:	0085b783          	ld	a5,8(a1)
    80001684:	00f53023          	sd	a5,0(a0)
    80001688:	fc5ff06f          	j	8000164c <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

000000008000168c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    8000168c:	fe010113          	addi	sp,sp,-32
    80001690:	00113c23          	sd	ra,24(sp)
    80001694:	00813823          	sd	s0,16(sp)
    80001698:	00913423          	sd	s1,8(sp)
    8000169c:	01213023          	sd	s2,0(sp)
    800016a0:	02010413          	addi	s0,sp,32
    800016a4:	00058913          	mv	s2,a1
    800016a8:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800016ac:	00060593          	mv	a1,a2
    800016b0:	00000097          	auipc	ra,0x0
    800016b4:	f88080e7          	jalr	-120(ra) # 80001638 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    800016b8:	00048593          	mv	a1,s1
    800016bc:	00090513          	mv	a0,s2
    800016c0:	00000097          	auipc	ra,0x0
    800016c4:	e3c080e7          	jalr	-452(ra) # 800014fc <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800016c8:	01813083          	ld	ra,24(sp)
    800016cc:	01013403          	ld	s0,16(sp)
    800016d0:	00813483          	ld	s1,8(sp)
    800016d4:	00013903          	ld	s2,0(sp)
    800016d8:	02010113          	addi	sp,sp,32
    800016dc:	00008067          	ret

00000000800016e0 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    800016e0:	fe010113          	addi	sp,sp,-32
    800016e4:	00113c23          	sd	ra,24(sp)
    800016e8:	00813823          	sd	s0,16(sp)
    800016ec:	00913423          	sd	s1,8(sp)
    800016f0:	01213023          	sd	s2,0(sp)
    800016f4:	02010413          	addi	s0,sp,32
    800016f8:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    800016fc:	00000493          	li	s1,0
    80001700:	01893783          	ld	a5,24(s2)
    80001704:	0af4f863          	bgeu	s1,a5,800017b4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80001708:	02093783          	ld	a5,32(s2)
    8000170c:	0034d713          	srli	a4,s1,0x3
    80001710:	00e787b3          	add	a5,a5,a4
    80001714:	0007c603          	lbu	a2,0(a5)
    80001718:	fff4c713          	not	a4,s1
    8000171c:	00777713          	andi	a4,a4,7
    80001720:	40e656bb          	sraw	a3,a2,a4
    80001724:	0016f693          	andi	a3,a3,1
    80001728:	00068663          	beqz	a3,80001734 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x54>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    8000172c:	00148493          	addi	s1,s1,1
    80001730:	fd1ff06f          	j	80001700 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    80001734:	00100693          	li	a3,1
    80001738:	00e6973b          	sllw	a4,a3,a4
    8000173c:	00e66633          	or	a2,a2,a4
    80001740:	00c78023          	sb	a2,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001744:	01093783          	ld	a5,16(s2)
    80001748:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    8000174c:	04f70863          	beq	a4,a5,8000179c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
    80001750:	03093503          	ld	a0,48(s2)
    80001754:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001758:	fff78793          	addi	a5,a5,-1
    8000175c:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001760:	04079463          	bnez	a5,800017a8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    80001764:	03093583          	ld	a1,48(s2)
    80001768:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    8000176c:	0005b703          	ld	a4,0(a1)
    80001770:	00053783          	ld	a5,0(a0)
    80001774:	00f70863          	beq	a4,a5,80001784 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa4>
                SlabAllocator::move(headFrom, headTo, slab);
    80001778:	00090613          	mv	a2,s2
    8000177c:	00000097          	auipc	ra,0x0
    80001780:	f10080e7          	jalr	-240(ra) # 8000168c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    80001784:	02893503          	ld	a0,40(s2)
    80001788:	03093783          	ld	a5,48(s2)
    8000178c:	0407b783          	ld	a5,64(a5)
    80001790:	029784b3          	mul	s1,a5,s1
    80001794:	00950533          	add	a0,a0,s1
    80001798:	0200006f          	j	800017b8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd8>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    8000179c:	03093503          	ld	a0,48(s2)
    800017a0:	06050513          	addi	a0,a0,96
    800017a4:	fb5ff06f          	j	80001758 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x78>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800017a8:	03093583          	ld	a1,48(s2)
    800017ac:	06858593          	addi	a1,a1,104
    800017b0:	fbdff06f          	j	8000176c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x8c>
    return nullptr;
    800017b4:	00000513          	li	a0,0
}
    800017b8:	01813083          	ld	ra,24(sp)
    800017bc:	01013403          	ld	s0,16(sp)
    800017c0:	00813483          	ld	s1,8(sp)
    800017c4:	00013903          	ld	s2,0(sp)
    800017c8:	02010113          	addi	sp,sp,32
    800017cc:	00008067          	ret

00000000800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800017d0:	fe010113          	addi	sp,sp,-32
    800017d4:	00113c23          	sd	ra,24(sp)
    800017d8:	00813823          	sd	s0,16(sp)
    800017dc:	00913423          	sd	s1,8(sp)
    800017e0:	01213023          	sd	s2,0(sp)
    800017e4:	02010413          	addi	s0,sp,32
    800017e8:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800017ec:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800017f0:	00048c63          	beqz	s1,80001808 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    800017f4:	00048513          	mv	a0,s1
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	ee8080e7          	jalr	-280(ra) # 800016e0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001800:	fe0508e3          	beqz	a0,800017f0 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    80001804:	00050493          	mv	s1,a0
    if(ret){
    80001808:	02048063          	beqz	s1,80001828 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    8000180c:	00048513          	mv	a0,s1
    80001810:	01813083          	ld	ra,24(sp)
    80001814:	01013403          	ld	s0,16(sp)
    80001818:	00813483          	ld	s1,8(sp)
    8000181c:	00013903          	ld	s2,0(sp)
    80001820:	02010113          	addi	sp,sp,32
    80001824:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80001828:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    8000182c:	00048c63          	beqz	s1,80001844 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80001830:	00048513          	mv	a0,s1
    80001834:	00000097          	auipc	ra,0x0
    80001838:	eac080e7          	jalr	-340(ra) # 800016e0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    8000183c:	fe0508e3          	beqz	a0,8000182c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001840:	00050493          	mv	s1,a0
    if(ret){
    80001844:	fc0494e3          	bnez	s1,8000180c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001848:	00090513          	mv	a0,s2
    8000184c:	00000097          	auipc	ra,0x0
    80001850:	ce0080e7          	jalr	-800(ra) # 8000152c <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80001854:	fa050ce3          	beqz	a0,8000180c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001858:	06093503          	ld	a0,96(s2)
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	e84080e7          	jalr	-380(ra) # 800016e0 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001864:	00050493          	mv	s1,a0
    return ret;
    80001868:	fa5ff06f          	j	8000180c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

000000008000186c <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    8000186c:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80001870:	0017d513          	srli	a0,a5,0x1
    80001874:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80001878:	0027d713          	srli	a4,a5,0x2
    8000187c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80001880:	0047d713          	srli	a4,a5,0x4
    80001884:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80001888:	0087d713          	srli	a4,a5,0x8
    8000188c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80001890:	0107d713          	srli	a4,a5,0x10
    80001894:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    80001898:	0207d713          	srli	a4,a5,0x20
    8000189c:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    800018a0:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800018a4:	00000713          	li	a4,0
        while(num>1){
    800018a8:	00100693          	li	a3,1
    800018ac:	00f6f863          	bgeu	a3,a5,800018bc <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    800018b0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800018b4:	00170713          	addi	a4,a4,1
        while(num>1){
    800018b8:	ff1ff06f          	j	800018a8 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800018bc:	ffb70713          	addi	a4,a4,-5
    800018c0:	00c00793          	li	a5,12
    800018c4:	04e7e063          	bltu	a5,a4,80001904 <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    800018c8:	ff010113          	addi	sp,sp,-16
    800018cc:	00113423          	sd	ra,8(sp)
    800018d0:	00813023          	sd	s0,0(sp)
    800018d4:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    800018d8:	00371713          	slli	a4,a4,0x3
    800018dc:	0000a797          	auipc	a5,0xa
    800018e0:	57478793          	addi	a5,a5,1396 # 8000be50 <_ZN13SlabAllocator5sizeNE>
    800018e4:	00e78733          	add	a4,a5,a4
    800018e8:	00073503          	ld	a0,0(a4)
    800018ec:	00000097          	auipc	ra,0x0
    800018f0:	ee4080e7          	jalr	-284(ra) # 800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800018f4:	00813083          	ld	ra,8(sp)
    800018f8:	00013403          	ld	s0,0(sp)
    800018fc:	01010113          	addi	sp,sp,16
    80001900:	00008067          	ret
        return nullptr;
    80001904:	00000513          	li	a0,0
}
    80001908:	00008067          	ret

000000008000190c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    8000190c:	fc010113          	addi	sp,sp,-64
    80001910:	02113c23          	sd	ra,56(sp)
    80001914:	02813823          	sd	s0,48(sp)
    80001918:	02913423          	sd	s1,40(sp)
    8000191c:	03213023          	sd	s2,32(sp)
    80001920:	01313c23          	sd	s3,24(sp)
    80001924:	01413823          	sd	s4,16(sp)
    80001928:	01513423          	sd	s5,8(sp)
    8000192c:	04010413          	addi	s0,sp,64
    80001930:	00050913          	mv	s2,a0
    80001934:	00058993          	mv	s3,a1
    80001938:	00060a93          	mv	s5,a2
    8000193c:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001940:	0000a517          	auipc	a0,0xa
    80001944:	57853503          	ld	a0,1400(a0) # 8000beb8 <_ZN13SlabAllocator5cacheE>
    80001948:	00000097          	auipc	ra,0x0
    8000194c:	e88080e7          	jalr	-376(ra) # 800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001950:	00050493          	mv	s1,a0
    ret->ctor = ctor;
    80001954:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001958:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    8000195c:	06053823          	sd	zero,112(a0)
    80001960:	06053423          	sd	zero,104(a0)
    80001964:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001968:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    8000196c:	00200793          	li	a5,2
    80001970:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    80001974:	00050593          	mv	a1,a0
    80001978:	00090513          	mv	a0,s2
    8000197c:	00003097          	auipc	ra,0x3
    80001980:	048080e7          	jalr	72(ra) # 800049c4 <_Z6strcpyPKcPc>
}
    80001984:	00048513          	mv	a0,s1
    80001988:	03813083          	ld	ra,56(sp)
    8000198c:	03013403          	ld	s0,48(sp)
    80001990:	02813483          	ld	s1,40(sp)
    80001994:	02013903          	ld	s2,32(sp)
    80001998:	01813983          	ld	s3,24(sp)
    8000199c:	01013a03          	ld	s4,16(sp)
    800019a0:	00813a83          	ld	s5,8(sp)
    800019a4:	04010113          	addi	sp,sp,64
    800019a8:	00008067          	ret

00000000800019ac <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800019ac:	fe010113          	addi	sp,sp,-32
    800019b0:	00113c23          	sd	ra,24(sp)
    800019b4:	00813823          	sd	s0,16(sp)
    800019b8:	00913423          	sd	s1,8(sp)
    800019bc:	01213023          	sd	s2,0(sp)
    800019c0:	02010413          	addi	s0,sp,32
    800019c4:	00050913          	mv	s2,a0
    800019c8:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    800019cc:	00001097          	auipc	ra,0x1
    800019d0:	918080e7          	jalr	-1768(ra) # 800022e4 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    800019d4:	0000a797          	auipc	a5,0xa
    800019d8:	47c78793          	addi	a5,a5,1148 # 8000be50 <_ZN13SlabAllocator5sizeNE>
    800019dc:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800019e0:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800019e4:	0000a717          	auipc	a4,0xa
    800019e8:	39473703          	ld	a4,916(a4) # 8000bd78 <_GLOBAL_OFFSET_TABLE_+0x18>
    800019ec:	00073583          	ld	a1,0(a4)
    800019f0:	00c5d593          	srli	a1,a1,0xc
    800019f4:	00158593          	addi	a1,a1,1
    800019f8:	00c59593          	slli	a1,a1,0xc
    800019fc:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    80001a00:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001a04:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001a08:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001a0c:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001a10:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001a14:	07800793          	li	a5,120
    80001a18:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001a1c:	00200793          	li	a5,2
    80001a20:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001a24:	00007517          	auipc	a0,0x7
    80001a28:	74c50513          	addi	a0,a0,1868 # 80009170 <CONSOLE_STATUS+0x160>
    80001a2c:	00003097          	auipc	ra,0x3
    80001a30:	f98080e7          	jalr	-104(ra) # 800049c4 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a34:	00000493          	li	s1,0
    80001a38:	0440006f          	j	80001a7c <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a3c:	00349913          	slli	s2,s1,0x3
    80001a40:	0000a797          	auipc	a5,0xa
    80001a44:	1a078793          	addi	a5,a5,416 # 8000bbe0 <_ZN13SlabAllocator5namesE>
    80001a48:	012787b3          	add	a5,a5,s2
    80001a4c:	00000693          	li	a3,0
    80001a50:	00000613          	li	a2,0
    80001a54:	00200593          	li	a1,2
    80001a58:	009595bb          	sllw	a1,a1,s1
    80001a5c:	0007b503          	ld	a0,0(a5)
    80001a60:	00000097          	auipc	ra,0x0
    80001a64:	eac080e7          	jalr	-340(ra) # 8000190c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a68:	0000a797          	auipc	a5,0xa
    80001a6c:	3e878793          	addi	a5,a5,1000 # 8000be50 <_ZN13SlabAllocator5sizeNE>
    80001a70:	012787b3          	add	a5,a5,s2
    80001a74:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a78:	0014849b          	addiw	s1,s1,1
    80001a7c:	00c00793          	li	a5,12
    80001a80:	fa97dee3          	bge	a5,s1,80001a3c <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80001a84:	01813083          	ld	ra,24(sp)
    80001a88:	01013403          	ld	s0,16(sp)
    80001a8c:	00813483          	ld	s1,8(sp)
    80001a90:	00013903          	ld	s2,0(sp)
    80001a94:	02010113          	addi	sp,sp,32
    80001a98:	00008067          	ret

0000000080001a9c <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001a9c:	02053783          	ld	a5,32(a0)
    80001aa0:	0035d713          	srli	a4,a1,0x3
    80001aa4:	00e787b3          	add	a5,a5,a4
    80001aa8:	0007c683          	lbu	a3,0(a5)
    80001aac:	fff5c593          	not	a1,a1
    80001ab0:	0075f593          	andi	a1,a1,7
    80001ab4:	40b6d73b          	sraw	a4,a3,a1
    80001ab8:	00177713          	andi	a4,a4,1
    80001abc:	0c070263          	beqz	a4,80001b80 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001ac0:	fe010113          	addi	sp,sp,-32
    80001ac4:	00113c23          	sd	ra,24(sp)
    80001ac8:	00813823          	sd	s0,16(sp)
    80001acc:	00913423          	sd	s1,8(sp)
    80001ad0:	02010413          	addi	s0,sp,32
    80001ad4:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001ad8:	00100713          	li	a4,1
    80001adc:	00b715bb          	sllw	a1,a4,a1
    80001ae0:	fff5c593          	not	a1,a1
    80001ae4:	00d5f5b3          	and	a1,a1,a3
    80001ae8:	00b78023          	sb	a1,0(a5)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001aec:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001af0:	04079a63          	bnez	a5,80001b44 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001af4:	03053503          	ld	a0,48(a0)
    80001af8:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001afc:	00178793          	addi	a5,a5,1
    80001b00:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001b04:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b08:	04e78463          	beq	a5,a4,80001b50 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001b0c:	0304b583          	ld	a1,48(s1)
    80001b10:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001b14:	04e78463          	beq	a5,a4,80001b5c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001b18:	0005b703          	ld	a4,0(a1)
    80001b1c:	00053783          	ld	a5,0(a0)
    80001b20:	00f70863          	beq	a4,a5,80001b30 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001b24:	00048613          	mv	a2,s1
    80001b28:	00000097          	auipc	ra,0x0
    80001b2c:	b64080e7          	jalr	-1180(ra) # 8000168c <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001b30:	01813083          	ld	ra,24(sp)
    80001b34:	01013403          	ld	s0,16(sp)
    80001b38:	00813483          	ld	s1,8(sp)
    80001b3c:	02010113          	addi	sp,sp,32
    80001b40:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b44:	03053503          	ld	a0,48(a0)
    80001b48:	06850513          	addi	a0,a0,104
    80001b4c:	fb1ff06f          	j	80001afc <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b50:	0304b583          	ld	a1,48(s1)
    80001b54:	06058593          	addi	a1,a1,96
    80001b58:	fbdff06f          	j	80001b14 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b5c:	00048593          	mv	a1,s1
    80001b60:	00000097          	auipc	ra,0x0
    80001b64:	ad8080e7          	jalr	-1320(ra) # 80001638 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b68:	0304b783          	ld	a5,48(s1)
    80001b6c:	0487b583          	ld	a1,72(a5)
    80001b70:	00048513          	mv	a0,s1
    80001b74:	00001097          	auipc	ra,0x1
    80001b78:	a68080e7          	jalr	-1432(ra) # 800025dc <_ZN5Buddy4freeEPvm>
    80001b7c:	fb5ff06f          	j	80001b30 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001b80:	00008067          	ret

0000000080001b84 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001b84:	fe010113          	addi	sp,sp,-32
    80001b88:	00113c23          	sd	ra,24(sp)
    80001b8c:	00813823          	sd	s0,16(sp)
    80001b90:	00913423          	sd	s1,8(sp)
    80001b94:	01213023          	sd	s2,0(sp)
    80001b98:	02010413          	addi	s0,sp,32
    80001b9c:	00050913          	mv	s2,a0
    80001ba0:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001ba4:	05853783          	ld	a5,88(a0)
    80001ba8:	00078663          	beqz	a5,80001bb4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001bac:	00058513          	mv	a0,a1
    80001bb0:	000780e7          	jalr	a5
    if(cache->ctor)
    80001bb4:	05093783          	ld	a5,80(s2)
    80001bb8:	00078663          	beqz	a5,80001bc4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001bbc:	00048513          	mv	a0,s1
    80001bc0:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001bc4:	07093503          	ld	a0,112(s2)
    80001bc8:	0080006f          	j	80001bd0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001bcc:	00853503          	ld	a0,8(a0)
        while(head){
    80001bd0:	02050e63          	beqz	a0,80001c0c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001bd4:	02853703          	ld	a4,40(a0)
    80001bd8:	01853783          	ld	a5,24(a0)
    80001bdc:	03053683          	ld	a3,48(a0)
    80001be0:	0406b583          	ld	a1,64(a3)
    80001be4:	02b787b3          	mul	a5,a5,a1
    80001be8:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001bec:	fef4f0e3          	bgeu	s1,a5,80001bcc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001bf0:	fce4eee3          	bltu	s1,a4,80001bcc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001bf4:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001bf8:	02b755b3          	divu	a1,a4,a1
    80001bfc:	00000097          	auipc	ra,0x0
    80001c00:	ea0080e7          	jalr	-352(ra) # 80001a9c <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c04:	00100513          	li	a0,1
    80001c08:	0080006f          	j	80001c10 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001c0c:	00000513          	li	a0,0
    if(deleted)
    80001c10:	00050e63          	beqz	a0,80001c2c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001c14:	01813083          	ld	ra,24(sp)
    80001c18:	01013403          	ld	s0,16(sp)
    80001c1c:	00813483          	ld	s1,8(sp)
    80001c20:	00013903          	ld	s2,0(sp)
    80001c24:	02010113          	addi	sp,sp,32
    80001c28:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001c2c:	06893783          	ld	a5,104(s2)
    80001c30:	0080006f          	j	80001c38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001c34:	0087b783          	ld	a5,8(a5)
        while(head){
    80001c38:	fc078ee3          	beqz	a5,80001c14 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c3c:	0287b683          	ld	a3,40(a5)
    80001c40:	0187b703          	ld	a4,24(a5)
    80001c44:	0307b603          	ld	a2,48(a5)
    80001c48:	04063583          	ld	a1,64(a2)
    80001c4c:	02b70733          	mul	a4,a4,a1
    80001c50:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c54:	fee4f0e3          	bgeu	s1,a4,80001c34 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001c58:	fcd4eee3          	bltu	s1,a3,80001c34 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c5c:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001c60:	02b6d5b3          	divu	a1,a3,a1
    80001c64:	00078513          	mv	a0,a5
    80001c68:	00000097          	auipc	ra,0x0
    80001c6c:	e34080e7          	jalr	-460(ra) # 80001a9c <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c70:	00100513          	li	a0,1
    80001c74:	fa1ff06f          	j	80001c14 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001c78 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001c78:	fe010113          	addi	sp,sp,-32
    80001c7c:	00113c23          	sd	ra,24(sp)
    80001c80:	00813823          	sd	s0,16(sp)
    80001c84:	00913423          	sd	s1,8(sp)
    80001c88:	01213023          	sd	s2,0(sp)
    80001c8c:	02010413          	addi	s0,sp,32
    80001c90:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001c94:	00000493          	li	s1,0
    80001c98:	00c00793          	li	a5,12
    80001c9c:	0297c863          	blt	a5,s1,80001ccc <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001ca0:	00349713          	slli	a4,s1,0x3
    80001ca4:	0000a797          	auipc	a5,0xa
    80001ca8:	1ac78793          	addi	a5,a5,428 # 8000be50 <_ZN13SlabAllocator5sizeNE>
    80001cac:	00e787b3          	add	a5,a5,a4
    80001cb0:	00090593          	mv	a1,s2
    80001cb4:	0007b503          	ld	a0,0(a5)
    80001cb8:	00000097          	auipc	ra,0x0
    80001cbc:	ecc080e7          	jalr	-308(ra) # 80001b84 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001cc0:	00051663          	bnez	a0,80001ccc <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cc4:	0014849b          	addiw	s1,s1,1
    80001cc8:	fd1ff06f          	j	80001c98 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001ccc:	01813083          	ld	ra,24(sp)
    80001cd0:	01013403          	ld	s0,16(sp)
    80001cd4:	00813483          	ld	s1,8(sp)
    80001cd8:	00013903          	ld	s2,0(sp)
    80001cdc:	02010113          	addi	sp,sp,32
    80001ce0:	00008067          	ret

0000000080001ce4 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001ce4:	fe010113          	addi	sp,sp,-32
    80001ce8:	00113c23          	sd	ra,24(sp)
    80001cec:	00813823          	sd	s0,16(sp)
    80001cf0:	00913423          	sd	s1,8(sp)
    80001cf4:	01213023          	sd	s2,0(sp)
    80001cf8:	02010413          	addi	s0,sp,32
    80001cfc:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001d00:	00053903          	ld	s2,0(a0)
    80001d04:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001d08:	00093503          	ld	a0,0(s2)
    80001d0c:	02050263          	beqz	a0,80001d30 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001d10:	03053783          	ld	a5,48(a0)
    80001d14:	0487b583          	ld	a1,72(a5)
    80001d18:	00001097          	auipc	ra,0x1
    80001d1c:	8c4080e7          	jalr	-1852(ra) # 800025dc <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d20:	00093783          	ld	a5,0(s2)
    80001d24:	0087b783          	ld	a5,8(a5)
    80001d28:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d2c:	fddff06f          	j	80001d08 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001d30:	0004b903          	ld	s2,0(s1)
    80001d34:	06890913          	addi	s2,s2,104
    80001d38:	00093503          	ld	a0,0(s2)
    80001d3c:	02050263          	beqz	a0,80001d60 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001d40:	03053783          	ld	a5,48(a0)
    80001d44:	0487b583          	ld	a1,72(a5)
    80001d48:	00001097          	auipc	ra,0x1
    80001d4c:	894080e7          	jalr	-1900(ra) # 800025dc <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d50:	00093783          	ld	a5,0(s2)
    80001d54:	0087b783          	ld	a5,8(a5)
    80001d58:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d5c:	fddff06f          	j	80001d38 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001d60:	0004b903          	ld	s2,0(s1)
    80001d64:	06090913          	addi	s2,s2,96
    80001d68:	00093503          	ld	a0,0(s2)
    80001d6c:	02050263          	beqz	a0,80001d90 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001d70:	03053783          	ld	a5,48(a0)
    80001d74:	0487b583          	ld	a1,72(a5)
    80001d78:	00001097          	auipc	ra,0x1
    80001d7c:	864080e7          	jalr	-1948(ra) # 800025dc <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d80:	00093783          	ld	a5,0(s2)
    80001d84:	0087b783          	ld	a5,8(a5)
    80001d88:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d8c:	fddff06f          	j	80001d68 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001d90:	0004b583          	ld	a1,0(s1)
    80001d94:	0000a517          	auipc	a0,0xa
    80001d98:	12453503          	ld	a0,292(a0) # 8000beb8 <_ZN13SlabAllocator5cacheE>
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	de8080e7          	jalr	-536(ra) # 80001b84 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001da4:	0004b023          	sd	zero,0(s1)
}
    80001da8:	01813083          	ld	ra,24(sp)
    80001dac:	01013403          	ld	s0,16(sp)
    80001db0:	00813483          	ld	s1,8(sp)
    80001db4:	00013903          	ld	s2,0(sp)
    80001db8:	02010113          	addi	sp,sp,32
    80001dbc:	00008067          	ret

0000000080001dc0 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001dc0:	ff010113          	addi	sp,sp,-16
    80001dc4:	00813423          	sd	s0,8(sp)
    80001dc8:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001dcc:	03f50513          	addi	a0,a0,63
    80001dd0:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001dd4:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001dd8:	00100513          	li	a0,1
    asm("ecall");
    80001ddc:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001de0:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001de4:	00813403          	ld	s0,8(sp)
    80001de8:	01010113          	addi	sp,sp,16
    80001dec:	00008067          	ret

0000000080001df0 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001df0:	ff010113          	addi	sp,sp,-16
    80001df4:	00813423          	sd	s0,8(sp)
    80001df8:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001dfc:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001e00:	00200513          	li	a0,2
    asm("ecall");
    80001e04:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e08:	00050513          	mv	a0,a0
    return status;
}
    80001e0c:	0005051b          	sext.w	a0,a0
    80001e10:	00813403          	ld	s0,8(sp)
    80001e14:	01010113          	addi	sp,sp,16
    80001e18:	00008067          	ret

0000000080001e1c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001e1c:	fd010113          	addi	sp,sp,-48
    80001e20:	02113423          	sd	ra,40(sp)
    80001e24:	02813023          	sd	s0,32(sp)
    80001e28:	00913c23          	sd	s1,24(sp)
    80001e2c:	01213823          	sd	s2,16(sp)
    80001e30:	01313423          	sd	s3,8(sp)
    80001e34:	03010413          	addi	s0,sp,48
    80001e38:	00050913          	mv	s2,a0
    80001e3c:	00058493          	mv	s1,a1
    80001e40:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001e44:	04058663          	beqz	a1,80001e90 <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001e48:	00001537          	lui	a0,0x1
    80001e4c:	00000097          	auipc	ra,0x0
    80001e50:	f74080e7          	jalr	-140(ra) # 80001dc0 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001e54:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001e58:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001e5c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e60:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001e64:	01100513          	li	a0,17

    asm("ecall");
    80001e68:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e6c:	00050513          	mv	a0,a0

    return status;
}
    80001e70:	0005051b          	sext.w	a0,a0
    80001e74:	02813083          	ld	ra,40(sp)
    80001e78:	02013403          	ld	s0,32(sp)
    80001e7c:	01813483          	ld	s1,24(sp)
    80001e80:	01013903          	ld	s2,16(sp)
    80001e84:	00813983          	ld	s3,8(sp)
    80001e88:	03010113          	addi	sp,sp,48
    80001e8c:	00008067          	ret
    uint64 istack = 0;
    80001e90:	00000513          	li	a0,0
    80001e94:	fc1ff06f          	j	80001e54 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

0000000080001e98 <_Z11thread_exitv>:

int thread_exit(){
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00813423          	sd	s0,8(sp)
    80001ea0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001ea4:	01200513          	li	a0,18

    asm("ecall");
    80001ea8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001eac:	00050513          	mv	a0,a0

    return status;
}
    80001eb0:	0005051b          	sext.w	a0,a0
    80001eb4:	00813403          	ld	s0,8(sp)
    80001eb8:	01010113          	addi	sp,sp,16
    80001ebc:	00008067          	ret

0000000080001ec0 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001ec0:	ff010113          	addi	sp,sp,-16
    80001ec4:	00813423          	sd	s0,8(sp)
    80001ec8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001ecc:	01300513          	li	a0,19

    asm("ecall");
    80001ed0:	00000073          	ecall
}
    80001ed4:	00813403          	ld	s0,8(sp)
    80001ed8:	01010113          	addi	sp,sp,16
    80001edc:	00008067          	ret

0000000080001ee0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001ee0:	fd010113          	addi	sp,sp,-48
    80001ee4:	02113423          	sd	ra,40(sp)
    80001ee8:	02813023          	sd	s0,32(sp)
    80001eec:	00913c23          	sd	s1,24(sp)
    80001ef0:	01213823          	sd	s2,16(sp)
    80001ef4:	01313423          	sd	s3,8(sp)
    80001ef8:	03010413          	addi	s0,sp,48
    80001efc:	00050913          	mv	s2,a0
    80001f00:	00058493          	mv	s1,a1
    80001f04:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001f08:	04058663          	beqz	a1,80001f54 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001f0c:	00001537          	lui	a0,0x1
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	eb0080e7          	jalr	-336(ra) # 80001dc0 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001f18:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001f1c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001f20:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f24:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    80001f28:	01400513          	li	a0,20

    asm("ecall");
    80001f2c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f30:	00050513          	mv	a0,a0

    return status;
}
    80001f34:	0005051b          	sext.w	a0,a0
    80001f38:	02813083          	ld	ra,40(sp)
    80001f3c:	02013403          	ld	s0,32(sp)
    80001f40:	01813483          	ld	s1,24(sp)
    80001f44:	01013903          	ld	s2,16(sp)
    80001f48:	00813983          	ld	s3,8(sp)
    80001f4c:	03010113          	addi	sp,sp,48
    80001f50:	00008067          	ret
    uint64 istack = 0;
    80001f54:	00000513          	li	a0,0
    80001f58:	fc1ff06f          	j	80001f18 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

0000000080001f5c <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001f5c:	ff010113          	addi	sp,sp,-16
    80001f60:	00813423          	sd	s0,8(sp)
    80001f64:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f68:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001f6c:	01500513          	li	a0,21

    asm("ecall");
    80001f70:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f74:	00050513          	mv	a0,a0

    return status;
}
    80001f78:	0005051b          	sext.w	a0,a0
    80001f7c:	00813403          	ld	s0,8(sp)
    80001f80:	01010113          	addi	sp,sp,16
    80001f84:	00008067          	ret

0000000080001f88 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001f88:	ff010113          	addi	sp,sp,-16
    80001f8c:	00813423          	sd	s0,8(sp)
    80001f90:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001f94:	02059593          	slli	a1,a1,0x20
    80001f98:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001f9c:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fa0:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001fa4:	02100513          	li	a0,33


    asm("ecall");
    80001fa8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fac:	00050513          	mv	a0,a0

    return status;

}
    80001fb0:	0005051b          	sext.w	a0,a0
    80001fb4:	00813403          	ld	s0,8(sp)
    80001fb8:	01010113          	addi	sp,sp,16
    80001fbc:	00008067          	ret

0000000080001fc0 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001fc0:	ff010113          	addi	sp,sp,-16
    80001fc4:	00813423          	sd	s0,8(sp)
    80001fc8:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001fcc:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001fd0:	02200513          	li	a0,34


    asm("ecall");
    80001fd4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fd8:	00050513          	mv	a0,a0

    return status;
}
    80001fdc:	0005051b          	sext.w	a0,a0
    80001fe0:	00813403          	ld	s0,8(sp)
    80001fe4:	01010113          	addi	sp,sp,16
    80001fe8:	00008067          	ret

0000000080001fec <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001fec:	ff010113          	addi	sp,sp,-16
    80001ff0:	00813423          	sd	s0,8(sp)
    80001ff4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001ff8:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001ffc:	02300513          	li	a0,35


    asm("ecall");
    80002000:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002004:	00050513          	mv	a0,a0

    return status;
}
    80002008:	0005051b          	sext.w	a0,a0
    8000200c:	00813403          	ld	s0,8(sp)
    80002010:	01010113          	addi	sp,sp,16
    80002014:	00008067          	ret

0000000080002018 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80002018:	ff010113          	addi	sp,sp,-16
    8000201c:	00813423          	sd	s0,8(sp)
    80002020:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80002024:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80002028:	02400513          	li	a0,36


    asm("ecall");
    8000202c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002030:	00050513          	mv	a0,a0

    return status;
}
    80002034:	0005051b          	sext.w	a0,a0
    80002038:	00813403          	ld	s0,8(sp)
    8000203c:	01010113          	addi	sp,sp,16
    80002040:	00008067          	ret

0000000080002044 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80002044:	ff010113          	addi	sp,sp,-16
    80002048:	00813423          	sd	s0,8(sp)
    8000204c:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    80002050:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80002054:	03100513          	li	a0,49


    asm("ecall");
    80002058:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000205c:	00050513          	mv	a0,a0

    return status;
}
    80002060:	0005051b          	sext.w	a0,a0
    80002064:	00813403          	ld	s0,8(sp)
    80002068:	01010113          	addi	sp,sp,16
    8000206c:	00008067          	ret

0000000080002070 <_Z4getcv>:

char getc(){
    80002070:	ff010113          	addi	sp,sp,-16
    80002074:	00813423          	sd	s0,8(sp)
    80002078:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    8000207c:	04100513          	li	a0,65

    asm("ecall");
    80002080:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80002084:	00050513          	mv	a0,a0

    return c;
}
    80002088:	0ff57513          	andi	a0,a0,255
    8000208c:	00813403          	ld	s0,8(sp)
    80002090:	01010113          	addi	sp,sp,16
    80002094:	00008067          	ret

0000000080002098 <_Z4putcc>:

void putc(char c){
    80002098:	ff010113          	addi	sp,sp,-16
    8000209c:	00813423          	sd	s0,8(sp)
    800020a0:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    800020a4:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    800020a8:	04200513          	li	a0,66

    asm("ecall");
    800020ac:	00000073          	ecall
}
    800020b0:	00813403          	ld	s0,8(sp)
    800020b4:	01010113          	addi	sp,sp,16
    800020b8:	00008067          	ret

00000000800020bc <_Z4forkv>:


int fork(){
    800020bc:	ff010113          	addi	sp,sp,-16
    800020c0:	00813423          	sd	s0,8(sp)
    800020c4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    800020c8:	06100513          	li	a0,97

    asm("ecall");
    800020cc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    800020d0:	00050513          	mv	a0,a0

    return status;
}
    800020d4:	0005051b          	sext.w	a0,a0
    800020d8:	00813403          	ld	s0,8(sp)
    800020dc:	01010113          	addi	sp,sp,16
    800020e0:	00008067          	ret

00000000800020e4 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    800020e4:	ff010113          	addi	sp,sp,-16
    800020e8:	00113423          	sd	ra,8(sp)
    800020ec:	00813023          	sd	s0,0(sp)
    800020f0:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    800020f4:	00000097          	auipc	ra,0x0
    800020f8:	ecc080e7          	jalr	-308(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
}
    800020fc:	00813083          	ld	ra,8(sp)
    80002100:	00013403          	ld	s0,0(sp)
    80002104:	01010113          	addi	sp,sp,16
    80002108:	00008067          	ret

000000008000210c <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    8000210c:	ff010113          	addi	sp,sp,-16
    80002110:	00113423          	sd	ra,8(sp)
    80002114:	00813023          	sd	s0,0(sp)
    80002118:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    8000211c:	00001097          	auipc	ra,0x1
    80002120:	ff8080e7          	jalr	-8(ra) # 80003114 <_ZN3TCB11thread_freeEPv>
    80002124:	00813083          	ld	ra,8(sp)
    80002128:	00013403          	ld	s0,0(sp)
    8000212c:	01010113          	addi	sp,sp,16
    80002130:	00008067          	ret

0000000080002134 <_Z4ctorPv>:

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    80002134:	ff010113          	addi	sp,sp,-16
    80002138:	00813423          	sd	s0,8(sp)
    8000213c:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    80002140:	01100793          	li	a5,17
    80002144:	00f53023          	sd	a5,0(a0) # 1000 <_entry-0x7ffff000>
    ((Test*)tst)->b = 32;
    80002148:	02000793          	li	a5,32
    8000214c:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    80002150:	00d00793          	li	a5,13
    80002154:	00f53823          	sd	a5,16(a0)

}
    80002158:	00813403          	ld	s0,8(sp)
    8000215c:	01010113          	addi	sp,sp,16
    80002160:	00008067          	ret

0000000080002164 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002164:	ff010113          	addi	sp,sp,-16
    80002168:	00813423          	sd	s0,8(sp)
    8000216c:	01010413          	addi	s0,sp,16
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
//    userMain();
    80002170:	00813403          	ld	s0,8(sp)
    80002174:	01010113          	addi	sp,sp,16
    80002178:	00008067          	ret

000000008000217c <_ZN6SystemC1Ev>:
    if (!initialized) {
    8000217c:	0000a797          	auipc	a5,0xa
    80002180:	d547c783          	lbu	a5,-684(a5) # 8000bed0 <_ZN6System11initializedE>
    80002184:	00078463          	beqz	a5,8000218c <_ZN6SystemC1Ev+0x10>
    80002188:	00008067          	ret
System::System() {
    8000218c:	fd010113          	addi	sp,sp,-48
    80002190:	02113423          	sd	ra,40(sp)
    80002194:	02813023          	sd	s0,32(sp)
    80002198:	00913c23          	sd	s1,24(sp)
    8000219c:	03010413          	addi	s0,sp,48
        initialized = true;
    800021a0:	00100793          	li	a5,1
    800021a4:	0000a717          	auipc	a4,0xa
    800021a8:	d2f70623          	sb	a5,-724(a4) # 8000bed0 <_ZN6System11initializedE>
        RiscV::initialize();
    800021ac:	00002097          	auipc	ra,0x2
    800021b0:	904080e7          	jalr	-1788(ra) # 80003ab0 <_ZN5RiscV10initializeEv>
        kmem_cache_t* cache = kmem_cache_create("Custom cache", sizeof(Test), ctor,nullptr);
    800021b4:	00000693          	li	a3,0
    800021b8:	00000617          	auipc	a2,0x0
    800021bc:	f7c60613          	addi	a2,a2,-132 # 80002134 <_Z4ctorPv>
    800021c0:	03000593          	li	a1,48
    800021c4:	00007517          	auipc	a0,0x7
    800021c8:	0f450513          	addi	a0,a0,244 # 800092b8 <CONSOLE_STATUS+0x2a8>
    800021cc:	00003097          	auipc	ra,0x3
    800021d0:	f30080e7          	jalr	-208(ra) # 800050fc <_Z17kmem_cache_createPKcmPFvPvES3_>
        Test* tst = (Test*)kmem_cache_alloc(cache);
    800021d4:	00003097          	auipc	ra,0x3
    800021d8:	f50080e7          	jalr	-176(ra) # 80005124 <_Z16kmem_cache_allocP5Cache>
    800021dc:	00050493          	mv	s1,a0
        ConsoleUtil::print("", tst->a,"\n");
    800021e0:	00007617          	auipc	a2,0x7
    800021e4:	19060613          	addi	a2,a2,400 # 80009370 <CONSOLE_STATUS+0x360>
    800021e8:	00052583          	lw	a1,0(a0)
    800021ec:	00007517          	auipc	a0,0x7
    800021f0:	1c450513          	addi	a0,a0,452 # 800093b0 <CONSOLE_STATUS+0x3a0>
    800021f4:	00003097          	auipc	ra,0x3
    800021f8:	e58080e7          	jalr	-424(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("", tst->b,"\n");
    800021fc:	00007617          	auipc	a2,0x7
    80002200:	17460613          	addi	a2,a2,372 # 80009370 <CONSOLE_STATUS+0x360>
    80002204:	0084a583          	lw	a1,8(s1)
    80002208:	00007517          	auipc	a0,0x7
    8000220c:	1a850513          	addi	a0,a0,424 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80002210:	00003097          	auipc	ra,0x3
    80002214:	e3c080e7          	jalr	-452(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("", tst->c,"\n");
    80002218:	00007617          	auipc	a2,0x7
    8000221c:	15860613          	addi	a2,a2,344 # 80009370 <CONSOLE_STATUS+0x360>
    80002220:	0104a583          	lw	a1,16(s1)
    80002224:	00007517          	auipc	a0,0x7
    80002228:	18c50513          	addi	a0,a0,396 # 800093b0 <CONSOLE_STATUS+0x3a0>
    8000222c:	00003097          	auipc	ra,0x3
    80002230:	e20080e7          	jalr	-480(ra) # 8000504c <_ZN11ConsoleUtil5printEPKciS1_>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80002234:	00000613          	li	a2,0
    80002238:	00000597          	auipc	a1,0x0
    8000223c:	f2c58593          	addi	a1,a1,-212 # 80002164 <_ZN6System15userMainWrapperEPv>
    80002240:	fd840513          	addi	a0,s0,-40
    80002244:	00000097          	auipc	ra,0x0
    80002248:	bd8080e7          	jalr	-1064(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    8000224c:	fd843783          	ld	a5,-40(s0)
    80002250:	0107a703          	lw	a4,16(a5)
    80002254:	00200793          	li	a5,2
    80002258:	00f70863          	beq	a4,a5,80002268 <_ZN6SystemC1Ev+0xec>
            thread_dispatch();
    8000225c:	00000097          	auipc	ra,0x0
    80002260:	c64080e7          	jalr	-924(ra) # 80001ec0 <_Z15thread_dispatchv>
    80002264:	fe9ff06f          	j	8000224c <_ZN6SystemC1Ev+0xd0>
        RiscV::finalize();
    80002268:	00002097          	auipc	ra,0x2
    8000226c:	a4c080e7          	jalr	-1460(ra) # 80003cb4 <_ZN5RiscV8finalizeEv>
}
    80002270:	02813083          	ld	ra,40(sp)
    80002274:	02013403          	ld	s0,32(sp)
    80002278:	01813483          	ld	s1,24(sp)
    8000227c:	03010113          	addi	sp,sp,48
    80002280:	00008067          	ret

0000000080002284 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80002284:	ff010113          	addi	sp,sp,-16
    80002288:	00813423          	sd	s0,8(sp)
    8000228c:	01010413          	addi	s0,sp,16
    80002290:	00100793          	li	a5,1
    80002294:	00f50863          	beq	a0,a5,800022a4 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002298:	00813403          	ld	s0,8(sp)
    8000229c:	01010113          	addi	sp,sp,16
    800022a0:	00008067          	ret
    800022a4:	000107b7          	lui	a5,0x10
    800022a8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022ac:	fef596e3          	bne	a1,a5,80002298 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    800022b0:	0000a797          	auipc	a5,0xa
    800022b4:	ac87b783          	ld	a5,-1336(a5) # 8000bd78 <_GLOBAL_OFFSET_TABLE_+0x18>
    800022b8:	0007b703          	ld	a4,0(a5)
    800022bc:	00c75793          	srli	a5,a4,0xc
    800022c0:	00278793          	addi	a5,a5,2
    800022c4:	00c79793          	slli	a5,a5,0xc
    800022c8:	0000a697          	auipc	a3,0xa
    800022cc:	c1068693          	addi	a3,a3,-1008 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022d0:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800022d4:	fffff7b7          	lui	a5,0xfffff
    800022d8:	00f77733          	and	a4,a4,a5
    800022dc:	00e6b423          	sd	a4,8(a3)
    800022e0:	fb9ff06f          	j	80002298 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800022e4 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    800022e4:	ff010113          	addi	sp,sp,-16
    800022e8:	00813423          	sd	s0,8(sp)
    800022ec:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    800022f0:	0000a717          	auipc	a4,0xa
    800022f4:	be870713          	addi	a4,a4,-1048 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022f8:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    800022fc:	0000a797          	auipc	a5,0xa
    80002300:	a7c7b783          	ld	a5,-1412(a5) # 8000bd78 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002304:	0007b783          	ld	a5,0(a5)
    80002308:	fffff6b7          	lui	a3,0xfffff
    8000230c:	00d7f7b3          	and	a5,a5,a3
    80002310:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80002314:	0000a797          	auipc	a5,0xa
    80002318:	92b7ba23          	sd	a1,-1740(a5) # 8000bc48 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    8000231c:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80002320:	00000713          	li	a4,0
        while(num>1){
    80002324:	00100693          	li	a3,1
    80002328:	00f6f863          	bgeu	a3,a5,80002338 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    8000232c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002330:	00170713          	addi	a4,a4,1
        while(num>1){
    80002334:	ff1ff06f          	j	80002324 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80002338:	00371713          	slli	a4,a4,0x3
    8000233c:	0000a797          	auipc	a5,0xa
    80002340:	b9c78793          	addi	a5,a5,-1124 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002344:	00e78733          	add	a4,a5,a4
    80002348:	00a73823          	sd	a0,16(a4)
    8000234c:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002350:	00000713          	li	a4,0
        while(num>1){
    80002354:	00100693          	li	a3,1
    80002358:	00f6f863          	bgeu	a3,a5,80002368 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    8000235c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002360:	00170713          	addi	a4,a4,1
        while(num>1){
    80002364:	ff1ff06f          	j	80002354 <_ZN5Buddy10initializeEPvm+0x70>
    80002368:	00371713          	slli	a4,a4,0x3
    8000236c:	0000a797          	auipc	a5,0xa
    80002370:	b6c78793          	addi	a5,a5,-1172 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002374:	00e78733          	add	a4,a5,a4
    80002378:	06a73c23          	sd	a0,120(a4)
    8000237c:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80002380:	00000713          	li	a4,0
        while(num>1){
    80002384:	00100693          	li	a3,1
    80002388:	00f6f863          	bgeu	a3,a5,80002398 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    8000238c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002390:	00170713          	addi	a4,a4,1
        while(num>1){
    80002394:	ff1ff06f          	j	80002384 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80002398:	00371713          	slli	a4,a4,0x3
    8000239c:	0000a797          	auipc	a5,0xa
    800023a0:	b3c78793          	addi	a5,a5,-1220 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023a4:	00e78733          	add	a4,a5,a4
    800023a8:	01073783          	ld	a5,16(a4)
    800023ac:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    800023b0:	00000793          	li	a5,0
    800023b4:	00c0006f          	j	800023c0 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    800023b8:	0015d593          	srli	a1,a1,0x1
            deg++;
    800023bc:	00178793          	addi	a5,a5,1
        while(num>1){
    800023c0:	00100713          	li	a4,1
    800023c4:	feb76ae3          	bltu	a4,a1,800023b8 <_ZN5Buddy10initializeEPvm+0xd4>
    800023c8:	00379793          	slli	a5,a5,0x3
    800023cc:	0000a717          	auipc	a4,0xa
    800023d0:	b0c70713          	addi	a4,a4,-1268 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023d4:	00f707b3          	add	a5,a4,a5
    800023d8:	0787b783          	ld	a5,120(a5)
    800023dc:	0007b023          	sd	zero,0(a5)
}
    800023e0:	00813403          	ld	s0,8(sp)
    800023e4:	01010113          	addi	sp,sp,16
    800023e8:	00008067          	ret

00000000800023ec <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    800023ec:	00c00793          	li	a5,12
    800023f0:	10f50063          	beq	a0,a5,800024f0 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    800023f4:	fd010113          	addi	sp,sp,-48
    800023f8:	02113423          	sd	ra,40(sp)
    800023fc:	02813023          	sd	s0,32(sp)
    80002400:	00913c23          	sd	s1,24(sp)
    80002404:	01213823          	sd	s2,16(sp)
    80002408:	01313423          	sd	s3,8(sp)
    8000240c:	03010413          	addi	s0,sp,48
    80002410:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002414:	00351713          	slli	a4,a0,0x3
    80002418:	0000a797          	auipc	a5,0xa
    8000241c:	ac078793          	addi	a5,a5,-1344 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002420:	00e787b3          	add	a5,a5,a4
    80002424:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002428:	00000993          	li	s3,0
    8000242c:	0180006f          	j	80002444 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002430:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002434:	04f70463          	beq	a4,a5,8000247c <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002438:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    8000243c:	08f70063          	beq	a4,a5,800024bc <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002440:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002444:	08048863          	beqz	s1,800024d4 <_ZN5Buddy8compressEm+0xe8>
    80002448:	0004b683          	ld	a3,0(s1)
    8000244c:	08068463          	beqz	a3,800024d4 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002450:	0000a797          	auipc	a5,0xa
    80002454:	a887b783          	ld	a5,-1400(a5) # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002458:	40f48733          	sub	a4,s1,a5
    8000245c:	00c9061b          	addiw	a2,s2,12
    80002460:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002464:	40f687b3          	sub	a5,a3,a5
    80002468:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    8000246c:	00177613          	andi	a2,a4,1
    80002470:	fc0610e3          	bnez	a2,80002430 <_ZN5Buddy8compressEm+0x44>
    80002474:	00170713          	addi	a4,a4,1
    80002478:	fbdff06f          	j	80002434 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    8000247c:	00098863          	beqz	s3,8000248c <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80002480:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7fff1ce0>
    80002484:	00d9b023          	sd	a3,0(s3)
    80002488:	fb5ff06f          	j	8000243c <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    8000248c:	0006b603          	ld	a2,0(a3)
    80002490:	00391593          	slli	a1,s2,0x3
    80002494:	0000a697          	auipc	a3,0xa
    80002498:	a4468693          	addi	a3,a3,-1468 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000249c:	00b686b3          	add	a3,a3,a1
    800024a0:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    800024a4:	f8061ce3          	bnez	a2,8000243c <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    800024a8:	0000a697          	auipc	a3,0xa
    800024ac:	a3068693          	addi	a3,a3,-1488 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024b0:	00b686b3          	add	a3,a3,a1
    800024b4:	0006b823          	sd	zero,16(a3)
    800024b8:	f85ff06f          	j	8000243c <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800024bc:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    800024c0:	00190593          	addi	a1,s2,1
    800024c4:	00048513          	mv	a0,s1
    800024c8:	00000097          	auipc	ra,0x0
    800024cc:	02c080e7          	jalr	44(ra) # 800024f4 <_ZN5Buddy6insertEPvm>
    800024d0:	f71ff06f          	j	80002440 <_ZN5Buddy8compressEm+0x54>
}
    800024d4:	02813083          	ld	ra,40(sp)
    800024d8:	02013403          	ld	s0,32(sp)
    800024dc:	01813483          	ld	s1,24(sp)
    800024e0:	01013903          	ld	s2,16(sp)
    800024e4:	00813983          	ld	s3,8(sp)
    800024e8:	03010113          	addi	sp,sp,48
    800024ec:	00008067          	ret
    800024f0:	00008067          	ret

00000000800024f4 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    800024f4:	00050693          	mv	a3,a0
    if(!head[size]){
    800024f8:	00359713          	slli	a4,a1,0x3
    800024fc:	0000a797          	auipc	a5,0xa
    80002500:	9dc78793          	addi	a5,a5,-1572 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002504:	00e787b3          	add	a5,a5,a4
    80002508:	0787b783          	ld	a5,120(a5)
    8000250c:	02078c63          	beqz	a5,80002544 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002510:	ff010113          	addi	sp,sp,-16
    80002514:	00113423          	sd	ra,8(sp)
    80002518:	00813023          	sd	s0,0(sp)
    8000251c:	01010413          	addi	s0,sp,16
    80002520:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002524:	00068713          	mv	a4,a3
    80002528:	04f6e063          	bltu	a3,a5,80002568 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    8000252c:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002530:	06078863          	beqz	a5,800025a0 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002534:	04f76c63          	bltu	a4,a5,8000258c <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002538:	00078613          	mv	a2,a5
                    iter = iter->next;
    8000253c:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002540:	ff1ff06f          	j	80002530 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002544:	0000a797          	auipc	a5,0xa
    80002548:	99478793          	addi	a5,a5,-1644 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000254c:	00e78533          	add	a0,a5,a4
    80002550:	00d53823          	sd	a3,16(a0)
    80002554:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002558:	0006b023          	sd	zero,0(a3)
    8000255c:	07853783          	ld	a5,120(a0)
    80002560:	0007b023          	sd	zero,0(a5)
        return;
    80002564:	00008067          	ret
            newHead->next = head[size];
    80002568:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    8000256c:	00359713          	slli	a4,a1,0x3
    80002570:	0000a797          	auipc	a5,0xa
    80002574:	96878793          	addi	a5,a5,-1688 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002578:	00e787b3          	add	a5,a5,a4
    8000257c:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80002580:	00000097          	auipc	ra,0x0
    80002584:	e6c080e7          	jalr	-404(ra) # 800023ec <_ZN5Buddy8compressEm>
            return;
    80002588:	0440006f          	j	800025cc <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    8000258c:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80002590:	00d63023          	sd	a3,0(a2)
                    compress(size);
    80002594:	00000097          	auipc	ra,0x0
    80002598:	e58080e7          	jalr	-424(ra) # 800023ec <_ZN5Buddy8compressEm>
                    return;
    8000259c:	0300006f          	j	800025cc <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    800025a0:	00351713          	slli	a4,a0,0x3
    800025a4:	0000a797          	auipc	a5,0xa
    800025a8:	93478793          	addi	a5,a5,-1740 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025ac:	00e787b3          	add	a5,a5,a4
    800025b0:	0107b703          	ld	a4,16(a5)
    800025b4:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800025b8:	0107b703          	ld	a4,16(a5)
    800025bc:	00073703          	ld	a4,0(a4)
    800025c0:	00e7b823          	sd	a4,16(a5)
    compress(size);
    800025c4:	00000097          	auipc	ra,0x0
    800025c8:	e28080e7          	jalr	-472(ra) # 800023ec <_ZN5Buddy8compressEm>
}
    800025cc:	00813083          	ld	ra,8(sp)
    800025d0:	00013403          	ld	s0,0(sp)
    800025d4:	01010113          	addi	sp,sp,16
    800025d8:	00008067          	ret

00000000800025dc <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800025dc:	02050663          	beqz	a0,80002608 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800025e0:	ff010113          	addi	sp,sp,-16
    800025e4:	00113423          	sd	ra,8(sp)
    800025e8:	00813023          	sd	s0,0(sp)
    800025ec:	01010413          	addi	s0,sp,16
    insert(addr,size);
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	f04080e7          	jalr	-252(ra) # 800024f4 <_ZN5Buddy6insertEPvm>
}
    800025f8:	00813083          	ld	ra,8(sp)
    800025fc:	00013403          	ld	s0,0(sp)
    80002600:	01010113          	addi	sp,sp,16
    80002604:	00008067          	ret
    80002608:	00008067          	ret

000000008000260c <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000260c:	ff010113          	addi	sp,sp,-16
    80002610:	00813423          	sd	s0,8(sp)
    80002614:	01010413          	addi	s0,sp,16
    80002618:	03c0006f          	j	80002654 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000261c:	00b5859b          	addiw	a1,a1,11
    80002620:	00100713          	li	a4,1
    80002624:	00b715bb          	sllw	a1,a4,a1
    80002628:	00b505b3          	add	a1,a0,a1
    8000262c:	00379693          	slli	a3,a5,0x3
    80002630:	0000a717          	auipc	a4,0xa
    80002634:	8a870713          	addi	a4,a4,-1880 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002638:	00d70733          	add	a4,a4,a3
    8000263c:	00b73823          	sd	a1,16(a4)
    80002640:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002644:	0005b023          	sd	zero,0(a1)
    80002648:	07873703          	ld	a4,120(a4)
    8000264c:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002650:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002654:	fff5879b          	addiw	a5,a1,-1
    80002658:	04c7c863          	blt	a5,a2,800026a8 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    8000265c:	00379693          	slli	a3,a5,0x3
    80002660:	0000a717          	auipc	a4,0xa
    80002664:	87870713          	addi	a4,a4,-1928 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002668:	00d70733          	add	a4,a4,a3
    8000266c:	01073683          	ld	a3,16(a4)
    80002670:	fa0686e3          	beqz	a3,8000261c <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002674:	00b5859b          	addiw	a1,a1,11
    80002678:	00100713          	li	a4,1
    8000267c:	00b715bb          	sllw	a1,a4,a1
    80002680:	00b505b3          	add	a1,a0,a1
    80002684:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002688:	00379693          	slli	a3,a5,0x3
    8000268c:	0000a717          	auipc	a4,0xa
    80002690:	84c70713          	addi	a4,a4,-1972 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002694:	00d70733          	add	a4,a4,a3
    80002698:	01073683          	ld	a3,16(a4)
    8000269c:	0006b683          	ld	a3,0(a3)
    800026a0:	00d73823          	sd	a3,16(a4)
    800026a4:	fadff06f          	j	80002650 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800026a8:	00813403          	ld	s0,8(sp)
    800026ac:	01010113          	addi	sp,sp,16
    800026b0:	00008067          	ret

00000000800026b4 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800026b4:	fe010113          	addi	sp,sp,-32
    800026b8:	00113c23          	sd	ra,24(sp)
    800026bc:	00813823          	sd	s0,16(sp)
    800026c0:	00913423          	sd	s1,8(sp)
    800026c4:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800026c8:	00c00793          	li	a5,12
    800026cc:	06a7ec63          	bltu	a5,a0,80002744 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800026d0:	00050593          	mv	a1,a0
    800026d4:	00c00793          	li	a5,12
    800026d8:	06b7ea63          	bltu	a5,a1,8000274c <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800026dc:	00359713          	slli	a4,a1,0x3
    800026e0:	00009797          	auipc	a5,0x9
    800026e4:	7f878793          	addi	a5,a5,2040 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800026e8:	00e787b3          	add	a5,a5,a4
    800026ec:	0787b483          	ld	s1,120(a5)
    800026f0:	00049663          	bnez	s1,800026fc <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800026f4:	00158593          	addi	a1,a1,1
    800026f8:	fddff06f          	j	800026d4 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    800026fc:	0004b703          	ld	a4,0(s1)
    80002700:	00359693          	slli	a3,a1,0x3
    80002704:	00009797          	auipc	a5,0x9
    80002708:	7d478793          	addi	a5,a5,2004 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000270c:	00d787b3          	add	a5,a5,a3
    80002710:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002714:	00070e63          	beqz	a4,80002730 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002718:	0005061b          	sext.w	a2,a0
    8000271c:	0005859b          	sext.w	a1,a1
    80002720:	00048513          	mv	a0,s1
    80002724:	00000097          	auipc	ra,0x0
    80002728:	ee8080e7          	jalr	-280(ra) # 8000260c <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    8000272c:	0240006f          	j	80002750 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002730:	00009797          	auipc	a5,0x9
    80002734:	7a878793          	addi	a5,a5,1960 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002738:	00d787b3          	add	a5,a5,a3
    8000273c:	0007b823          	sd	zero,16(a5)
    80002740:	fd9ff06f          	j	80002718 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002744:	00000493          	li	s1,0
    80002748:	0080006f          	j	80002750 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    8000274c:	00000493          	li	s1,0
}
    80002750:	00048513          	mv	a0,s1
    80002754:	01813083          	ld	ra,24(sp)
    80002758:	01013403          	ld	s0,16(sp)
    8000275c:	00813483          	ld	s1,8(sp)
    80002760:	02010113          	addi	sp,sp,32
    80002764:	00008067          	ret

0000000080002768 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002768:	fe010113          	addi	sp,sp,-32
    8000276c:	00113c23          	sd	ra,24(sp)
    80002770:	00813823          	sd	s0,16(sp)
    80002774:	00913423          	sd	s1,8(sp)
    80002778:	01213023          	sd	s2,0(sp)
    8000277c:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002780:	00000913          	li	s2,0
    80002784:	0180006f          	j	8000279c <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002788:	00007517          	auipc	a0,0x7
    8000278c:	be850513          	addi	a0,a0,-1048 # 80009370 <CONSOLE_STATUS+0x360>
    80002790:	00002097          	auipc	ra,0x2
    80002794:	79c080e7          	jalr	1948(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002798:	0019091b          	addiw	s2,s2,1
    8000279c:	00c00793          	li	a5,12
    800027a0:	0727c663          	blt	a5,s2,8000280c <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800027a4:	00000613          	li	a2,0
    800027a8:	00a00593          	li	a1,10
    800027ac:	00090513          	mv	a0,s2
    800027b0:	00002097          	auipc	ra,0x2
    800027b4:	7c0080e7          	jalr	1984(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800027b8:	00007517          	auipc	a0,0x7
    800027bc:	b1050513          	addi	a0,a0,-1264 # 800092c8 <CONSOLE_STATUS+0x2b8>
    800027c0:	00002097          	auipc	ra,0x2
    800027c4:	76c080e7          	jalr	1900(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    800027c8:	00391713          	slli	a4,s2,0x3
    800027cc:	00009797          	auipc	a5,0x9
    800027d0:	70c78793          	addi	a5,a5,1804 # 8000bed8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800027d4:	00e787b3          	add	a5,a5,a4
    800027d8:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    800027dc:	fa0486e3          	beqz	s1,80002788 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    800027e0:	00000613          	li	a2,0
    800027e4:	00a00593          	li	a1,10
    800027e8:	0004851b          	sext.w	a0,s1
    800027ec:	00002097          	auipc	ra,0x2
    800027f0:	784080e7          	jalr	1924(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    800027f4:	00007517          	auipc	a0,0x7
    800027f8:	8f450513          	addi	a0,a0,-1804 # 800090e8 <CONSOLE_STATUS+0xd8>
    800027fc:	00002097          	auipc	ra,0x2
    80002800:	730080e7          	jalr	1840(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002804:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002808:	fd5ff06f          	j	800027dc <_ZN5Buddy9printListEv+0x74>
    8000280c:	01813083          	ld	ra,24(sp)
    80002810:	01013403          	ld	s0,16(sp)
    80002814:	00813483          	ld	s1,8(sp)
    80002818:	00013903          	ld	s2,0(sp)
    8000281c:	02010113          	addi	sp,sp,32
    80002820:	00008067          	ret

0000000080002824 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002824:	ff010113          	addi	sp,sp,-16
    80002828:	00113423          	sd	ra,8(sp)
    8000282c:	00813023          	sd	s0,0(sp)
    80002830:	01010413          	addi	s0,sp,16
    80002834:	000105b7          	lui	a1,0x10
    80002838:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000283c:	00100513          	li	a0,1
    80002840:	00000097          	auipc	ra,0x0
    80002844:	a44080e7          	jalr	-1468(ra) # 80002284 <_Z41__static_initialization_and_destruction_0ii>
    80002848:	00813083          	ld	ra,8(sp)
    8000284c:	00013403          	ld	s0,0(sp)
    80002850:	01010113          	addi	sp,sp,16
    80002854:	00008067          	ret

0000000080002858 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002858:	fe010113          	addi	sp,sp,-32
    8000285c:	00113c23          	sd	ra,24(sp)
    80002860:	00813823          	sd	s0,16(sp)
    80002864:	00913423          	sd	s1,8(sp)
    80002868:	02010413          	addi	s0,sp,32
    8000286c:	00050493          	mv	s1,a0
    LOCK();
    80002870:	00100613          	li	a2,1
    80002874:	00000593          	li	a1,0
    80002878:	00009517          	auipc	a0,0x9
    8000287c:	74050513          	addi	a0,a0,1856 # 8000bfb8 <lockPrint>
    80002880:	ffffe097          	auipc	ra,0xffffe
    80002884:	780080e7          	jalr	1920(ra) # 80001000 <copy_and_swap>
    80002888:	fe0514e3          	bnez	a0,80002870 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000288c:	0004c503          	lbu	a0,0(s1)
    80002890:	00050a63          	beqz	a0,800028a4 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002894:	00000097          	auipc	ra,0x0
    80002898:	804080e7          	jalr	-2044(ra) # 80002098 <_Z4putcc>
        string++;
    8000289c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800028a0:	fedff06f          	j	8000288c <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800028a4:	00000613          	li	a2,0
    800028a8:	00100593          	li	a1,1
    800028ac:	00009517          	auipc	a0,0x9
    800028b0:	70c50513          	addi	a0,a0,1804 # 8000bfb8 <lockPrint>
    800028b4:	ffffe097          	auipc	ra,0xffffe
    800028b8:	74c080e7          	jalr	1868(ra) # 80001000 <copy_and_swap>
    800028bc:	fe0514e3          	bnez	a0,800028a4 <_Z11printStringPKc+0x4c>
}
    800028c0:	01813083          	ld	ra,24(sp)
    800028c4:	01013403          	ld	s0,16(sp)
    800028c8:	00813483          	ld	s1,8(sp)
    800028cc:	02010113          	addi	sp,sp,32
    800028d0:	00008067          	ret

00000000800028d4 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800028d4:	fd010113          	addi	sp,sp,-48
    800028d8:	02113423          	sd	ra,40(sp)
    800028dc:	02813023          	sd	s0,32(sp)
    800028e0:	00913c23          	sd	s1,24(sp)
    800028e4:	01213823          	sd	s2,16(sp)
    800028e8:	01313423          	sd	s3,8(sp)
    800028ec:	01413023          	sd	s4,0(sp)
    800028f0:	03010413          	addi	s0,sp,48
    800028f4:	00050993          	mv	s3,a0
    800028f8:	00058a13          	mv	s4,a1
    LOCK();
    800028fc:	00100613          	li	a2,1
    80002900:	00000593          	li	a1,0
    80002904:	00009517          	auipc	a0,0x9
    80002908:	6b450513          	addi	a0,a0,1716 # 8000bfb8 <lockPrint>
    8000290c:	ffffe097          	auipc	ra,0xffffe
    80002910:	6f4080e7          	jalr	1780(ra) # 80001000 <copy_and_swap>
    80002914:	fe0514e3          	bnez	a0,800028fc <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002918:	00000913          	li	s2,0
    8000291c:	00090493          	mv	s1,s2
    80002920:	0019091b          	addiw	s2,s2,1
    80002924:	03495a63          	bge	s2,s4,80002958 <_Z9getStringPci+0x84>
        cc = getc();
    80002928:	fffff097          	auipc	ra,0xfffff
    8000292c:	748080e7          	jalr	1864(ra) # 80002070 <_Z4getcv>
        if(cc < 1)
    80002930:	02050463          	beqz	a0,80002958 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002934:	009984b3          	add	s1,s3,s1
    80002938:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000293c:	00a00793          	li	a5,10
    80002940:	00f50a63          	beq	a0,a5,80002954 <_Z9getStringPci+0x80>
    80002944:	00d00793          	li	a5,13
    80002948:	fcf51ae3          	bne	a0,a5,8000291c <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000294c:	00090493          	mv	s1,s2
    80002950:	0080006f          	j	80002958 <_Z9getStringPci+0x84>
    80002954:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002958:	009984b3          	add	s1,s3,s1
    8000295c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002960:	00000613          	li	a2,0
    80002964:	00100593          	li	a1,1
    80002968:	00009517          	auipc	a0,0x9
    8000296c:	65050513          	addi	a0,a0,1616 # 8000bfb8 <lockPrint>
    80002970:	ffffe097          	auipc	ra,0xffffe
    80002974:	690080e7          	jalr	1680(ra) # 80001000 <copy_and_swap>
    80002978:	fe0514e3          	bnez	a0,80002960 <_Z9getStringPci+0x8c>
    return buf;
}
    8000297c:	00098513          	mv	a0,s3
    80002980:	02813083          	ld	ra,40(sp)
    80002984:	02013403          	ld	s0,32(sp)
    80002988:	01813483          	ld	s1,24(sp)
    8000298c:	01013903          	ld	s2,16(sp)
    80002990:	00813983          	ld	s3,8(sp)
    80002994:	00013a03          	ld	s4,0(sp)
    80002998:	03010113          	addi	sp,sp,48
    8000299c:	00008067          	ret

00000000800029a0 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800029a0:	ff010113          	addi	sp,sp,-16
    800029a4:	00813423          	sd	s0,8(sp)
    800029a8:	01010413          	addi	s0,sp,16
    800029ac:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800029b0:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800029b4:	0006c603          	lbu	a2,0(a3)
    800029b8:	fd06071b          	addiw	a4,a2,-48
    800029bc:	0ff77713          	andi	a4,a4,255
    800029c0:	00900793          	li	a5,9
    800029c4:	02e7e063          	bltu	a5,a4,800029e4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800029c8:	0025179b          	slliw	a5,a0,0x2
    800029cc:	00a787bb          	addw	a5,a5,a0
    800029d0:	0017979b          	slliw	a5,a5,0x1
    800029d4:	00168693          	addi	a3,a3,1
    800029d8:	00c787bb          	addw	a5,a5,a2
    800029dc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800029e0:	fd5ff06f          	j	800029b4 <_Z11stringToIntPKc+0x14>
    return n;
}
    800029e4:	00813403          	ld	s0,8(sp)
    800029e8:	01010113          	addi	sp,sp,16
    800029ec:	00008067          	ret

00000000800029f0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800029f0:	fc010113          	addi	sp,sp,-64
    800029f4:	02113c23          	sd	ra,56(sp)
    800029f8:	02813823          	sd	s0,48(sp)
    800029fc:	02913423          	sd	s1,40(sp)
    80002a00:	03213023          	sd	s2,32(sp)
    80002a04:	01313c23          	sd	s3,24(sp)
    80002a08:	04010413          	addi	s0,sp,64
    80002a0c:	00050493          	mv	s1,a0
    80002a10:	00058913          	mv	s2,a1
    80002a14:	00060993          	mv	s3,a2
    LOCK();
    80002a18:	00100613          	li	a2,1
    80002a1c:	00000593          	li	a1,0
    80002a20:	00009517          	auipc	a0,0x9
    80002a24:	59850513          	addi	a0,a0,1432 # 8000bfb8 <lockPrint>
    80002a28:	ffffe097          	auipc	ra,0xffffe
    80002a2c:	5d8080e7          	jalr	1496(ra) # 80001000 <copy_and_swap>
    80002a30:	fe0514e3          	bnez	a0,80002a18 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002a34:	00098463          	beqz	s3,80002a3c <_Z8printIntiii+0x4c>
    80002a38:	0804c463          	bltz	s1,80002ac0 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002a3c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002a40:	00000593          	li	a1,0
    }

    i = 0;
    80002a44:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002a48:	0009079b          	sext.w	a5,s2
    80002a4c:	0325773b          	remuw	a4,a0,s2
    80002a50:	00048613          	mv	a2,s1
    80002a54:	0014849b          	addiw	s1,s1,1
    80002a58:	02071693          	slli	a3,a4,0x20
    80002a5c:	0206d693          	srli	a3,a3,0x20
    80002a60:	00009717          	auipc	a4,0x9
    80002a64:	1f070713          	addi	a4,a4,496 # 8000bc50 <digits>
    80002a68:	00d70733          	add	a4,a4,a3
    80002a6c:	00074683          	lbu	a3,0(a4)
    80002a70:	fd040713          	addi	a4,s0,-48
    80002a74:	00c70733          	add	a4,a4,a2
    80002a78:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002a7c:	0005071b          	sext.w	a4,a0
    80002a80:	0325553b          	divuw	a0,a0,s2
    80002a84:	fcf772e3          	bgeu	a4,a5,80002a48 <_Z8printIntiii+0x58>
    if(neg)
    80002a88:	00058c63          	beqz	a1,80002aa0 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002a8c:	fd040793          	addi	a5,s0,-48
    80002a90:	009784b3          	add	s1,a5,s1
    80002a94:	02d00793          	li	a5,45
    80002a98:	fef48823          	sb	a5,-16(s1)
    80002a9c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002aa0:	fff4849b          	addiw	s1,s1,-1
    80002aa4:	0204c463          	bltz	s1,80002acc <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002aa8:	fd040793          	addi	a5,s0,-48
    80002aac:	009787b3          	add	a5,a5,s1
    80002ab0:	ff07c503          	lbu	a0,-16(a5)
    80002ab4:	fffff097          	auipc	ra,0xfffff
    80002ab8:	5e4080e7          	jalr	1508(ra) # 80002098 <_Z4putcc>
    80002abc:	fe5ff06f          	j	80002aa0 <_Z8printIntiii+0xb0>
        x = -xx;
    80002ac0:	4090053b          	negw	a0,s1
        neg = 1;
    80002ac4:	00100593          	li	a1,1
        x = -xx;
    80002ac8:	f7dff06f          	j	80002a44 <_Z8printIntiii+0x54>

    UNLOCK();
    80002acc:	00000613          	li	a2,0
    80002ad0:	00100593          	li	a1,1
    80002ad4:	00009517          	auipc	a0,0x9
    80002ad8:	4e450513          	addi	a0,a0,1252 # 8000bfb8 <lockPrint>
    80002adc:	ffffe097          	auipc	ra,0xffffe
    80002ae0:	524080e7          	jalr	1316(ra) # 80001000 <copy_and_swap>
    80002ae4:	fe0514e3          	bnez	a0,80002acc <_Z8printIntiii+0xdc>
    80002ae8:	03813083          	ld	ra,56(sp)
    80002aec:	03013403          	ld	s0,48(sp)
    80002af0:	02813483          	ld	s1,40(sp)
    80002af4:	02013903          	ld	s2,32(sp)
    80002af8:	01813983          	ld	s3,24(sp)
    80002afc:	04010113          	addi	sp,sp,64
    80002b00:	00008067          	ret

0000000080002b04 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002b04:	ff010113          	addi	sp,sp,-16
    80002b08:	00813423          	sd	s0,8(sp)
    80002b0c:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002b10:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002b14:	00053823          	sd	zero,16(a0)
}
    80002b18:	00813403          	ld	s0,8(sp)
    80002b1c:	01010113          	addi	sp,sp,16
    80002b20:	00008067          	ret

0000000080002b24 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002b24:	ff010113          	addi	sp,sp,-16
    80002b28:	00813423          	sd	s0,8(sp)
    80002b2c:	01010413          	addi	s0,sp,16

    80002b30:	00813403          	ld	s0,8(sp)
    80002b34:	01010113          	addi	sp,sp,16
    80002b38:	00008067          	ret

0000000080002b3c <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002b3c:	ff010113          	addi	sp,sp,-16
    80002b40:	00113423          	sd	ra,8(sp)
    80002b44:	00813023          	sd	s0,0(sp)
    80002b48:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    80002b4c:	00000697          	auipc	a3,0x0
    80002b50:	fd868693          	addi	a3,a3,-40 # 80002b24 <_ZN3SCB4dtorEPv>
    80002b54:	00000617          	auipc	a2,0x0
    80002b58:	fb060613          	addi	a2,a2,-80 # 80002b04 <_ZN3SCB4ctorEPv>
    80002b5c:	01800593          	li	a1,24
    80002b60:	00006517          	auipc	a0,0x6
    80002b64:	77050513          	addi	a0,a0,1904 # 800092d0 <CONSOLE_STATUS+0x2c0>
    80002b68:	00002097          	auipc	ra,0x2
    80002b6c:	594080e7          	jalr	1428(ra) # 800050fc <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002b70:	00009797          	auipc	a5,0x9
    80002b74:	44a7b823          	sd	a0,1104(a5) # 8000bfc0 <_ZN3SCB8scbCacheE>
}
    80002b78:	00813083          	ld	ra,8(sp)
    80002b7c:	00013403          	ld	s0,0(sp)
    80002b80:	01010113          	addi	sp,sp,16
    80002b84:	00008067          	ret

0000000080002b88 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    80002b88:	ff010113          	addi	sp,sp,-16
    80002b8c:	00813423          	sd	s0,8(sp)
    80002b90:	01010413          	addi	s0,sp,16
    val = init;
    80002b94:	00b52023          	sw	a1,0(a0)
}
    80002b98:	00813403          	ld	s0,8(sp)
    80002b9c:	01010113          	addi	sp,sp,16
    80002ba0:	00008067          	ret

0000000080002ba4 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002ba4:	fe010113          	addi	sp,sp,-32
    80002ba8:	00113c23          	sd	ra,24(sp)
    80002bac:	00813823          	sd	s0,16(sp)
    80002bb0:	00913423          	sd	s1,8(sp)
    80002bb4:	01213023          	sd	s2,0(sp)
    80002bb8:	02010413          	addi	s0,sp,32
    80002bbc:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002bc0:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002bc4:	02050063          	beqz	a0,80002be4 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002bc8:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002bcc:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002bd0:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002bd4:	00002097          	auipc	ra,0x2
    80002bd8:	e94080e7          	jalr	-364(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002bdc:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002be0:	fe5ff06f          	j	80002bc4 <_ZN3SCBD1Ev+0x20>
}
    80002be4:	01813083          	ld	ra,24(sp)
    80002be8:	01013403          	ld	s0,16(sp)
    80002bec:	00813483          	ld	s1,8(sp)
    80002bf0:	00013903          	ld	s2,0(sp)
    80002bf4:	02010113          	addi	sp,sp,32
    80002bf8:	00008067          	ret

0000000080002bfc <_ZN3SCB5blockEv>:
void SCB::block() {
    80002bfc:	ff010113          	addi	sp,sp,-16
    80002c00:	00113423          	sd	ra,8(sp)
    80002c04:	00813023          	sd	s0,0(sp)
    80002c08:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002c0c:	00853783          	ld	a5,8(a0)
    80002c10:	04078063          	beqz	a5,80002c50 <_ZN3SCB5blockEv+0x54>
    80002c14:	01053703          	ld	a4,16(a0)
    80002c18:	00009797          	auipc	a5,0x9
    80002c1c:	1d07b783          	ld	a5,464(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c20:	0007b783          	ld	a5,0(a5)
    80002c24:	04f73423          	sd	a5,72(a4)
    80002c28:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002c2c:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002c30:	00300713          	li	a4,3
    80002c34:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002c38:	00000097          	auipc	ra,0x0
    80002c3c:	304080e7          	jalr	772(ra) # 80002f3c <_ZN3TCB8dispatchEv>
}
    80002c40:	00813083          	ld	ra,8(sp)
    80002c44:	00013403          	ld	s0,0(sp)
    80002c48:	01010113          	addi	sp,sp,16
    80002c4c:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002c50:	00009797          	auipc	a5,0x9
    80002c54:	1987b783          	ld	a5,408(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002c58:	0007b783          	ld	a5,0(a5)
    80002c5c:	00f53423          	sd	a5,8(a0)
    80002c60:	fc9ff06f          	j	80002c28 <_ZN3SCB5blockEv+0x2c>

0000000080002c64 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    80002c64:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002c68:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002c6c:	04853703          	ld	a4,72(a0)
    80002c70:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002c74:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002c78:	02050a63          	beqz	a0,80002cac <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002c7c:	ff010113          	addi	sp,sp,-16
    80002c80:	00113423          	sd	ra,8(sp)
    80002c84:	00813023          	sd	s0,0(sp)
    80002c88:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002c8c:	00100793          	li	a5,1
    80002c90:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002c94:	00002097          	auipc	ra,0x2
    80002c98:	dd4080e7          	jalr	-556(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
}
    80002c9c:	00813083          	ld	ra,8(sp)
    80002ca0:	00013403          	ld	s0,0(sp)
    80002ca4:	01010113          	addi	sp,sp,16
    80002ca8:	00008067          	ret
    80002cac:	00008067          	ret

0000000080002cb0 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002cb0:	00009797          	auipc	a5,0x9
    80002cb4:	1387b783          	ld	a5,312(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002cb8:	0007b783          	ld	a5,0(a5)
    80002cbc:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002cc0:	00052783          	lw	a5,0(a0)
    80002cc4:	fff7879b          	addiw	a5,a5,-1
    80002cc8:	00f52023          	sw	a5,0(a0)
    80002ccc:	02079713          	slli	a4,a5,0x20
    80002cd0:	00074463          	bltz	a4,80002cd8 <_ZN3SCB4waitEv+0x28>
    80002cd4:	00008067          	ret
void SCB::wait() {
    80002cd8:	ff010113          	addi	sp,sp,-16
    80002cdc:	00113423          	sd	ra,8(sp)
    80002ce0:	00813023          	sd	s0,0(sp)
    80002ce4:	01010413          	addi	s0,sp,16
        block();
    80002ce8:	00000097          	auipc	ra,0x0
    80002cec:	f14080e7          	jalr	-236(ra) # 80002bfc <_ZN3SCB5blockEv>
}
    80002cf0:	00813083          	ld	ra,8(sp)
    80002cf4:	00013403          	ld	s0,0(sp)
    80002cf8:	01010113          	addi	sp,sp,16
    80002cfc:	00008067          	ret

0000000080002d00 <_ZN3SCB6signalEv>:
    if(val++<0)
    80002d00:	00052783          	lw	a5,0(a0)
    80002d04:	0017871b          	addiw	a4,a5,1
    80002d08:	00e52023          	sw	a4,0(a0)
    80002d0c:	0007c463          	bltz	a5,80002d14 <_ZN3SCB6signalEv+0x14>
    80002d10:	00008067          	ret
void SCB::signal(){
    80002d14:	ff010113          	addi	sp,sp,-16
    80002d18:	00113423          	sd	ra,8(sp)
    80002d1c:	00813023          	sd	s0,0(sp)
    80002d20:	01010413          	addi	s0,sp,16
        deblock();
    80002d24:	00000097          	auipc	ra,0x0
    80002d28:	f40080e7          	jalr	-192(ra) # 80002c64 <_ZN3SCB7deblockEv>
}
    80002d2c:	00813083          	ld	ra,8(sp)
    80002d30:	00013403          	ld	s0,0(sp)
    80002d34:	01010113          	addi	sp,sp,16
    80002d38:	00008067          	ret

0000000080002d3c <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80002d3c:	ff010113          	addi	sp,sp,-16
    80002d40:	00113423          	sd	ra,8(sp)
    80002d44:	00813023          	sd	s0,0(sp)
    80002d48:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80002d4c:	00009517          	auipc	a0,0x9
    80002d50:	27453503          	ld	a0,628(a0) # 8000bfc0 <_ZN3SCB8scbCacheE>
    80002d54:	00002097          	auipc	ra,0x2
    80002d58:	3d0080e7          	jalr	976(ra) # 80005124 <_Z16kmem_cache_allocP5Cache>
}
    80002d5c:	00813083          	ld	ra,8(sp)
    80002d60:	00013403          	ld	s0,0(sp)
    80002d64:	01010113          	addi	sp,sp,16
    80002d68:	00008067          	ret

0000000080002d6c <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    80002d6c:	ff010113          	addi	sp,sp,-16
    80002d70:	00113423          	sd	ra,8(sp)
    80002d74:	00813023          	sd	s0,0(sp)
    80002d78:	01010413          	addi	s0,sp,16
    80002d7c:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80002d80:	00009517          	auipc	a0,0x9
    80002d84:	24053503          	ld	a0,576(a0) # 8000bfc0 <_ZN3SCB8scbCacheE>
    80002d88:	00002097          	auipc	ra,0x2
    80002d8c:	3c4080e7          	jalr	964(ra) # 8000514c <_Z15kmem_cache_freeP5CachePv>
}
    80002d90:	00813083          	ld	ra,8(sp)
    80002d94:	00013403          	ld	s0,0(sp)
    80002d98:	01010113          	addi	sp,sp,16
    80002d9c:	00008067          	ret

0000000080002da0 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    80002da0:	ff010113          	addi	sp,sp,-16
    80002da4:	00813423          	sd	s0,8(sp)
    80002da8:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002dac:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002db0:	05200513          	li	a0,82
    asm("ecall");
    80002db4:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002db8:	00050513          	mv	a0,a0
}
    80002dbc:	0005051b          	sext.w	a0,a0
    80002dc0:	00813403          	ld	s0,8(sp)
    80002dc4:	01010113          	addi	sp,sp,16
    80002dc8:	00008067          	ret

0000000080002dcc <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002dcc:	fe010113          	addi	sp,sp,-32
    80002dd0:	00113c23          	sd	ra,24(sp)
    80002dd4:	00813823          	sd	s0,16(sp)
    80002dd8:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002ddc:	fe840513          	addi	a0,s0,-24
    80002de0:	fffff097          	auipc	ra,0xfffff
    80002de4:	39c080e7          	jalr	924(ra) # 8000217c <_ZN6SystemC1Ev>

    return 0;
    80002de8:	00000513          	li	a0,0
    80002dec:	01813083          	ld	ra,24(sp)
    80002df0:	01013403          	ld	s0,16(sp)
    80002df4:	02010113          	addi	sp,sp,32
    80002df8:	00008067          	ret

0000000080002dfc <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002dfc:	ff010113          	addi	sp,sp,-16
    80002e00:	00813423          	sd	s0,8(sp)
    80002e04:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002e08:	00100793          	li	a5,1
    80002e0c:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002e10:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002e14:	00052a23          	sw	zero,20(a0)
}
    80002e18:	00813403          	ld	s0,8(sp)
    80002e1c:	01010113          	addi	sp,sp,16
    80002e20:	00008067          	ret

0000000080002e24 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002e24:	ff010113          	addi	sp,sp,-16
    80002e28:	00813423          	sd	s0,8(sp)
    80002e2c:	01010413          	addi	s0,sp,16

    80002e30:	00813403          	ld	s0,8(sp)
    80002e34:	01010113          	addi	sp,sp,16
    80002e38:	00008067          	ret

0000000080002e3c <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    80002e3c:	ff010113          	addi	sp,sp,-16
    80002e40:	00113423          	sd	ra,8(sp)
    80002e44:	00813023          	sd	s0,0(sp)
    80002e48:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002e4c:	00001097          	auipc	ra,0x1
    80002e50:	cf0080e7          	jalr	-784(ra) # 80003b3c <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    80002e54:	00009797          	auipc	a5,0x9
    80002e58:	1747b783          	ld	a5,372(a5) # 8000bfc8 <_ZN3TCB7runningE>
    80002e5c:	0187b703          	ld	a4,24(a5)
    80002e60:	0207b503          	ld	a0,32(a5)
    80002e64:	000700e7          	jalr	a4
    thread_exit();
    80002e68:	fffff097          	auipc	ra,0xfffff
    80002e6c:	030080e7          	jalr	48(ra) # 80001e98 <_Z11thread_exitv>
}
    80002e70:	00813083          	ld	ra,8(sp)
    80002e74:	00013403          	ld	s0,0(sp)
    80002e78:	01010113          	addi	sp,sp,16
    80002e7c:	00008067          	ret

0000000080002e80 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002e80:	ff010113          	addi	sp,sp,-16
    80002e84:	00813423          	sd	s0,8(sp)
    80002e88:	01010413          	addi	s0,sp,16
    80002e8c:	04053823          	sd	zero,80(a0)
    80002e90:	04053c23          	sd	zero,88(a0)
    80002e94:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002e98:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002e9c:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002ea0:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002ea4:	02058a63          	beqz	a1,80002ed8 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002ea8:	00068793          	mv	a5,a3
    80002eac:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002eb0:	02058863          	beqz	a1,80002ee0 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002eb4:	000017b7          	lui	a5,0x1
    80002eb8:	00f686b3          	add	a3,a3,a5
    80002ebc:	00d53023          	sd	a3,0(a0)
    80002ec0:	00000797          	auipc	a5,0x0
    80002ec4:	f7c78793          	addi	a5,a5,-132 # 80002e3c <_ZN3TCB7wrapperEPv>
    80002ec8:	00f53423          	sd	a5,8(a0)
}
    80002ecc:	00813403          	ld	s0,8(sp)
    80002ed0:	01010113          	addi	sp,sp,16
    80002ed4:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002ed8:	00000793          	li	a5,0
    80002edc:	fd1ff06f          	j	80002eac <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002ee0:	00000693          	li	a3,0
    80002ee4:	fd9ff06f          	j	80002ebc <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002ee8 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002ee8:	ff010113          	addi	sp,sp,-16
    80002eec:	00113423          	sd	ra,8(sp)
    80002ef0:	00813023          	sd	s0,0(sp)
    80002ef4:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002ef8:	02853503          	ld	a0,40(a0)
    80002efc:	00002097          	auipc	ra,0x2
    80002f00:	320080e7          	jalr	800(ra) # 8000521c <_Z5kfreePKv>
}
    80002f04:	00813083          	ld	ra,8(sp)
    80002f08:	00013403          	ld	s0,0(sp)
    80002f0c:	01010113          	addi	sp,sp,16
    80002f10:	00008067          	ret

0000000080002f14 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002f14:	ff010113          	addi	sp,sp,-16
    80002f18:	00113423          	sd	ra,8(sp)
    80002f1c:	00813023          	sd	s0,0(sp)
    80002f20:	01010413          	addi	s0,sp,16
    free();
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	fc4080e7          	jalr	-60(ra) # 80002ee8 <_ZN3TCB4freeEv>
}
    80002f2c:	00813083          	ld	ra,8(sp)
    80002f30:	00013403          	ld	s0,0(sp)
    80002f34:	01010113          	addi	sp,sp,16
    80002f38:	00008067          	ret

0000000080002f3c <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002f3c:	fe010113          	addi	sp,sp,-32
    80002f40:	00113c23          	sd	ra,24(sp)
    80002f44:	00813823          	sd	s0,16(sp)
    80002f48:	00913423          	sd	s1,8(sp)
    80002f4c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002f50:	00009497          	auipc	s1,0x9
    80002f54:	0784b483          	ld	s1,120(s1) # 8000bfc8 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002f58:	0104a703          	lw	a4,16(s1)
    80002f5c:	00100793          	li	a5,1
    80002f60:	04e7f663          	bgeu	a5,a4,80002fac <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002f64:	00002097          	auipc	ra,0x2
    80002f68:	b4c080e7          	jalr	-1204(ra) # 80004ab0 <_ZN9Scheduler3getEv>
    80002f6c:	00009797          	auipc	a5,0x9
    80002f70:	04a7be23          	sd	a0,92(a5) # 8000bfc8 <_ZN3TCB7runningE>
    if(running) {
    80002f74:	02050263          	beqz	a0,80002f98 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002f78:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002f7c:	00001097          	auipc	ra,0x1
    80002f80:	cf4080e7          	jalr	-780(ra) # 80003c70 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002f84:	00009597          	auipc	a1,0x9
    80002f88:	0445b583          	ld	a1,68(a1) # 8000bfc8 <_ZN3TCB7runningE>
    80002f8c:	00048513          	mv	a0,s1
    80002f90:	ffffe097          	auipc	ra,0xffffe
    80002f94:	1b0080e7          	jalr	432(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002f98:	01813083          	ld	ra,24(sp)
    80002f9c:	01013403          	ld	s0,16(sp)
    80002fa0:	00813483          	ld	s1,8(sp)
    80002fa4:	02010113          	addi	sp,sp,32
    80002fa8:	00008067          	ret
        Scheduler::put(old);
    80002fac:	00048513          	mv	a0,s1
    80002fb0:	00002097          	auipc	ra,0x2
    80002fb4:	ab8080e7          	jalr	-1352(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
    80002fb8:	fadff06f          	j	80002f64 <_ZN3TCB8dispatchEv+0x28>

0000000080002fbc <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002fbc:	ff010113          	addi	sp,sp,-16
    80002fc0:	00113423          	sd	ra,8(sp)
    80002fc4:	00813023          	sd	s0,0(sp)
    80002fc8:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002fcc:	00009517          	auipc	a0,0x9
    80002fd0:	00453503          	ld	a0,4(a0) # 8000bfd0 <_ZN3TCB8tcbCacheE>
    80002fd4:	00002097          	auipc	ra,0x2
    80002fd8:	150080e7          	jalr	336(ra) # 80005124 <_Z16kmem_cache_allocP5Cache>
}
    80002fdc:	00813083          	ld	ra,8(sp)
    80002fe0:	00013403          	ld	s0,0(sp)
    80002fe4:	01010113          	addi	sp,sp,16
    80002fe8:	00008067          	ret

0000000080002fec <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002fec:	fd010113          	addi	sp,sp,-48
    80002ff0:	02113423          	sd	ra,40(sp)
    80002ff4:	02813023          	sd	s0,32(sp)
    80002ff8:	00913c23          	sd	s1,24(sp)
    80002ffc:	01213823          	sd	s2,16(sp)
    80003000:	01313423          	sd	s3,8(sp)
    80003004:	01413023          	sd	s4,0(sp)
    80003008:	03010413          	addi	s0,sp,48
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    8000300c:	00000697          	auipc	a3,0x0
    80003010:	e1868693          	addi	a3,a3,-488 # 80002e24 <_ZN3TCB4dtorEPv>
    80003014:	00000617          	auipc	a2,0x0
    80003018:	de860613          	addi	a2,a2,-536 # 80002dfc <_ZN3TCB4ctorEPv>
    8000301c:	07000593          	li	a1,112
    80003020:	00006517          	auipc	a0,0x6
    80003024:	2c050513          	addi	a0,a0,704 # 800092e0 <CONSOLE_STATUS+0x2d0>
    80003028:	00002097          	auipc	ra,0x2
    8000302c:	0d4080e7          	jalr	212(ra) # 800050fc <_Z17kmem_cache_createPKcmPFvPvES3_>
    80003030:	00009917          	auipc	s2,0x9
    80003034:	f9890913          	addi	s2,s2,-104 # 8000bfc8 <_ZN3TCB7runningE>
    80003038:	00a93423          	sd	a0,8(s2)
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    8000303c:	07000513          	li	a0,112
    80003040:	00000097          	auipc	ra,0x0
    80003044:	f7c080e7          	jalr	-132(ra) # 80002fbc <_ZN3TCBnwEm>
    80003048:	00050493          	mv	s1,a0
    8000304c:	00200713          	li	a4,2
    80003050:	00000693          	li	a3,0
    80003054:	00000613          	li	a2,0
    80003058:	00000593          	li	a1,0
    8000305c:	00000097          	auipc	ra,0x0
    80003060:	e24080e7          	jalr	-476(ra) # 80002e80 <_ZN3TCBC1EPFvPvES0_Pmm>
    80003064:	00993023          	sd	s1,0(s2)
    TCB::running->mode = Mode::SUPERVISOR;
    80003068:	00100a13          	li	s4,1
    8000306c:	0144aa23          	sw	s4,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003070:	00001537          	lui	a0,0x1
    80003074:	00002097          	auipc	ra,0x2
    80003078:	180080e7          	jalr	384(ra) # 800051f4 <_Z7kmallocm>
    8000307c:	00050993          	mv	s3,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80003080:	07000513          	li	a0,112
    80003084:	00000097          	auipc	ra,0x0
    80003088:	f38080e7          	jalr	-200(ra) # 80002fbc <_ZN3TCBnwEm>
    8000308c:	00050493          	mv	s1,a0
    80003090:	00200713          	li	a4,2
    80003094:	00098693          	mv	a3,s3
    80003098:	00000613          	li	a2,0
    8000309c:	00009597          	auipc	a1,0x9
    800030a0:	cec5b583          	ld	a1,-788(a1) # 8000bd88 <_GLOBAL_OFFSET_TABLE_+0x28>
    800030a4:	00000097          	auipc	ra,0x0
    800030a8:	ddc080e7          	jalr	-548(ra) # 80002e80 <_ZN3TCBC1EPFvPvES0_Pmm>
    800030ac:	00993823          	sd	s1,16(s2)
    putcThread->mode = Mode::SUPERVISOR;
    800030b0:	0144aa23          	sw	s4,20(s1)
    Scheduler::put(putcThread);
    800030b4:	00048513          	mv	a0,s1
    800030b8:	00002097          	auipc	ra,0x2
    800030bc:	9b0080e7          	jalr	-1616(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
}
    800030c0:	02813083          	ld	ra,40(sp)
    800030c4:	02013403          	ld	s0,32(sp)
    800030c8:	01813483          	ld	s1,24(sp)
    800030cc:	01013903          	ld	s2,16(sp)
    800030d0:	00813983          	ld	s3,8(sp)
    800030d4:	00013a03          	ld	s4,0(sp)
    800030d8:	03010113          	addi	sp,sp,48
    800030dc:	00008067          	ret

00000000800030e0 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    800030e0:	ff010113          	addi	sp,sp,-16
    800030e4:	00113423          	sd	ra,8(sp)
    800030e8:	00813023          	sd	s0,0(sp)
    800030ec:	01010413          	addi	s0,sp,16
    800030f0:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    800030f4:	00009517          	auipc	a0,0x9
    800030f8:	edc53503          	ld	a0,-292(a0) # 8000bfd0 <_ZN3TCB8tcbCacheE>
    800030fc:	00002097          	auipc	ra,0x2
    80003100:	050080e7          	jalr	80(ra) # 8000514c <_Z15kmem_cache_freeP5CachePv>
}
    80003104:	00813083          	ld	ra,8(sp)
    80003108:	00013403          	ld	s0,0(sp)
    8000310c:	01010113          	addi	sp,sp,16
    80003110:	00008067          	ret

0000000080003114 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80003114:	ff010113          	addi	sp,sp,-16
    80003118:	00813423          	sd	s0,8(sp)
    8000311c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003120:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80003124:	05100513          	li	a0,81
    asm("ecall");
    80003128:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000312c:	00050513          	mv	a0,a0
}
    80003130:	0005051b          	sext.w	a0,a0
    80003134:	00813403          	ld	s0,8(sp)
    80003138:	01010113          	addi	sp,sp,16
    8000313c:	00008067          	ret

0000000080003140 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80003140:	ff010113          	addi	sp,sp,-16
    80003144:	00813423          	sd	s0,8(sp)
    80003148:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    8000314c:	00009797          	auipc	a5,0x9
    80003150:	c2c7b783          	ld	a5,-980(a5) # 8000bd78 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003154:	0007b603          	ld	a2,0(a5)
    80003158:	00c65793          	srli	a5,a2,0xc
    8000315c:	00278793          	addi	a5,a5,2
    80003160:	00c79793          	slli	a5,a5,0xc
    80003164:	01000737          	lui	a4,0x1000
    80003168:	00e787b3          	add	a5,a5,a4
    8000316c:	00009717          	auipc	a4,0x9
    80003170:	e8c70713          	addi	a4,a4,-372 # 8000bff8 <_ZN15MemoryAllocator11freeMemTailE>
    80003174:	00f73023          	sd	a5,0(a4)
    80003178:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    8000317c:	0007b823          	sd	zero,16(a5)
    80003180:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003184:	00073823          	sd	zero,16(a4)
    80003188:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    8000318c:	00009697          	auipc	a3,0x9
    80003190:	c6c6b683          	ld	a3,-916(a3) # 8000bdf8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003194:	0006b683          	ld	a3,0(a3)
    80003198:	40c686b3          	sub	a3,a3,a2
    8000319c:	fe868693          	addi	a3,a3,-24
    800031a0:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800031a4:	00873783          	ld	a5,8(a4)
    800031a8:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800031ac:	00100793          	li	a5,1
    800031b0:	02f70023          	sb	a5,32(a4)
}
    800031b4:	00813403          	ld	s0,8(sp)
    800031b8:	01010113          	addi	sp,sp,16
    800031bc:	00008067          	ret

00000000800031c0 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800031c0:	ff010113          	addi	sp,sp,-16
    800031c4:	00813423          	sd	s0,8(sp)
    800031c8:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    800031cc:	14050263          	beqz	a0,80003310 <_ZN15MemoryAllocator7kmallocEm+0x150>
    800031d0:	00050793          	mv	a5,a0
    800031d4:	00009517          	auipc	a0,0x9
    800031d8:	e2c53503          	ld	a0,-468(a0) # 8000c000 <_ZN15MemoryAllocator11freeMemHeadE>
    800031dc:	0a050a63          	beqz	a0,80003290 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800031e0:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    800031e4:	00000613          	li	a2,0
    800031e8:	00c0006f          	j	800031f4 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800031ec:	00050613          	mv	a2,a0
    800031f0:	01053503          	ld	a0,16(a0)
    800031f4:	00050863          	beqz	a0,80003204 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    800031f8:	00053683          	ld	a3,0(a0)
    800031fc:	01878713          	addi	a4,a5,24
    80003200:	fee6e6e3          	bltu	a3,a4,800031ec <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80003204:	08050663          	beqz	a0,80003290 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80003208:	00053683          	ld	a3,0(a0)
    8000320c:	01868713          	addi	a4,a3,24
    80003210:	00e50733          	add	a4,a0,a4
    80003214:	00009597          	auipc	a1,0x9
    80003218:	be45b583          	ld	a1,-1052(a1) # 8000bdf8 <_GLOBAL_OFFSET_TABLE_+0x98>
    8000321c:	0005b583          	ld	a1,0(a1)
    80003220:	00b76463          	bltu	a4,a1,80003228 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80003224:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80003228:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    8000322c:	05700593          	li	a1,87
    80003230:	08d5f063          	bgeu	a1,a3,800032b0 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80003234:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80003238:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    8000323c:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80003240:	01053583          	ld	a1,16(a0)
    80003244:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80003248:	00853583          	ld	a1,8(a0)
    8000324c:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80003250:	fe868693          	addi	a3,a3,-24
    80003254:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80003258:	04060263          	beqz	a2,8000329c <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    8000325c:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003260:	00009797          	auipc	a5,0x9
    80003264:	db07b783          	ld	a5,-592(a5) # 8000c010 <_ZN15MemoryAllocator12allocMemHeadE>
    80003268:	06078463          	beqz	a5,800032d0 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    8000326c:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80003270:	08070063          	beqz	a4,800032f0 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80003274:	00873783          	ld	a5,8(a4)
    80003278:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    8000327c:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80003280:	00873783          	ld	a5,8(a4)
    80003284:	06078063          	beqz	a5,800032e4 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    80003288:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    8000328c:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003290:	00813403          	ld	s0,8(sp)
    80003294:	01010113          	addi	sp,sp,16
    80003298:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    8000329c:	00009697          	auipc	a3,0x9
    800032a0:	d5c68693          	addi	a3,a3,-676 # 8000bff8 <_ZN15MemoryAllocator11freeMemTailE>
    800032a4:	00f6b023          	sd	a5,0(a3)
    800032a8:	00f6b423          	sd	a5,8(a3)
    800032ac:	fb5ff06f          	j	80003260 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    800032b0:	00060863          	beqz	a2,800032c0 <_ZN15MemoryAllocator7kmallocEm+0x100>
    800032b4:	01053783          	ld	a5,16(a0)
    800032b8:	00f63823          	sd	a5,16(a2)
    800032bc:	fa5ff06f          	j	80003260 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    800032c0:	01053783          	ld	a5,16(a0)
    800032c4:	00009697          	auipc	a3,0x9
    800032c8:	d2f6be23          	sd	a5,-708(a3) # 8000c000 <_ZN15MemoryAllocator11freeMemHeadE>
    800032cc:	f95ff06f          	j	80003260 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    800032d0:	00009797          	auipc	a5,0x9
    800032d4:	d2878793          	addi	a5,a5,-728 # 8000bff8 <_ZN15MemoryAllocator11freeMemTailE>
    800032d8:	00a7b823          	sd	a0,16(a5)
    800032dc:	00a7bc23          	sd	a0,24(a5)
    800032e0:	fadff06f          	j	8000328c <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    800032e4:	00009797          	auipc	a5,0x9
    800032e8:	d2a7b623          	sd	a0,-724(a5) # 8000c010 <_ZN15MemoryAllocator12allocMemHeadE>
    800032ec:	fa1ff06f          	j	8000328c <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    800032f0:	00009797          	auipc	a5,0x9
    800032f4:	d0878793          	addi	a5,a5,-760 # 8000bff8 <_ZN15MemoryAllocator11freeMemTailE>
    800032f8:	0107b703          	ld	a4,16(a5)
    800032fc:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80003300:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80003304:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80003308:	00a7b823          	sd	a0,16(a5)
    8000330c:	f81ff06f          	j	8000328c <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80003310:	00000513          	li	a0,0
    80003314:	f7dff06f          	j	80003290 <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080003318 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80003318:	ff010113          	addi	sp,sp,-16
    8000331c:	00813423          	sd	s0,8(sp)
    80003320:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80003324:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003328:	00000713          	li	a4,0
    8000332c:	00078a63          	beqz	a5,80003340 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80003330:	00a7f863          	bgeu	a5,a0,80003340 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003334:	00078713          	mv	a4,a5
    80003338:	0107b783          	ld	a5,16(a5)
    8000333c:	ff1ff06f          	j	8000332c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80003340:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003344:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80003348:	00078463          	beqz	a5,80003350 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    8000334c:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003350:	02070263          	beqz	a4,80003374 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003354:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80003358:	0005b703          	ld	a4,0(a1)
    8000335c:	00009797          	auipc	a5,0x9
    80003360:	ca47b783          	ld	a5,-860(a5) # 8000c000 <_ZN15MemoryAllocator11freeMemHeadE>
    80003364:	00f70c63          	beq	a4,a5,8000337c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80003368:	00813403          	ld	s0,8(sp)
    8000336c:	01010113          	addi	sp,sp,16
    80003370:	00008067          	ret
        *head = blk;
    80003374:	00a5b023          	sd	a0,0(a1)
    80003378:	fe1ff06f          	j	80003358 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    8000337c:	01053783          	ld	a5,16(a0)
    80003380:	00078a63          	beqz	a5,80003394 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003384:	00053683          	ld	a3,0(a0)
    80003388:	00d50733          	add	a4,a0,a3
    8000338c:	01870713          	addi	a4,a4,24
    80003390:	02f70e63          	beq	a4,a5,800033cc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003394:	00853783          	ld	a5,8(a0)
    80003398:	fc0788e3          	beqz	a5,80003368 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    8000339c:	0007b683          	ld	a3,0(a5)
    800033a0:	00d78733          	add	a4,a5,a3
    800033a4:	01870713          	addi	a4,a4,24
    800033a8:	fca710e3          	bne	a4,a0,80003368 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800033ac:	00053703          	ld	a4,0(a0)
    800033b0:	00e68733          	add	a4,a3,a4
    800033b4:	01870713          	addi	a4,a4,24
    800033b8:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800033bc:	00853783          	ld	a5,8(a0)
    800033c0:	01053703          	ld	a4,16(a0)
    800033c4:	00e7b823          	sd	a4,16(a5)
}
    800033c8:	fa1ff06f          	j	80003368 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800033cc:	0007b703          	ld	a4,0(a5)
    800033d0:	00e68733          	add	a4,a3,a4
    800033d4:	01870713          	addi	a4,a4,24
    800033d8:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800033dc:	0107b783          	ld	a5,16(a5)
    800033e0:	00f53823          	sd	a5,16(a0)
    800033e4:	fb1ff06f          	j	80003394 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800033e8 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800033e8:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800033ec:	00009697          	auipc	a3,0x9
    800033f0:	c246b683          	ld	a3,-988(a3) # 8000c010 <_ZN15MemoryAllocator12allocMemHeadE>
    800033f4:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800033f8:	00050a63          	beqz	a0,8000340c <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    800033fc:	fe870793          	addi	a5,a4,-24
    80003400:	00a78663          	beq	a5,a0,8000340c <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003404:	01053503          	ld	a0,16(a0)
    80003408:	ff1ff06f          	j	800033f8 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    8000340c:	08050463          	beqz	a0,80003494 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003410:	ff010113          	addi	sp,sp,-16
    80003414:	00113423          	sd	ra,8(sp)
    80003418:	00813023          	sd	s0,0(sp)
    8000341c:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003420:	00009797          	auipc	a5,0x9
    80003424:	be87b783          	ld	a5,-1048(a5) # 8000c008 <_ZN15MemoryAllocator12allocMemTailE>
    80003428:	04a78663          	beq	a5,a0,80003474 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    8000342c:	04d50c63          	beq	a0,a3,80003484 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80003430:	01053783          	ld	a5,16(a0)
    80003434:	00078663          	beqz	a5,80003440 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80003438:	00853703          	ld	a4,8(a0)
    8000343c:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80003440:	00853783          	ld	a5,8(a0)
    80003444:	00078663          	beqz	a5,80003450 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80003448:	01053703          	ld	a4,16(a0)
    8000344c:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003450:	00009597          	auipc	a1,0x9
    80003454:	bb058593          	addi	a1,a1,-1104 # 8000c000 <_ZN15MemoryAllocator11freeMemHeadE>
    80003458:	00000097          	auipc	ra,0x0
    8000345c:	ec0080e7          	jalr	-320(ra) # 80003318 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003460:	00000513          	li	a0,0
}
    80003464:	00813083          	ld	ra,8(sp)
    80003468:	00013403          	ld	s0,0(sp)
    8000346c:	01010113          	addi	sp,sp,16
    80003470:	00008067          	ret
            allocMemTail = blk->prev;
    80003474:	00853783          	ld	a5,8(a0)
    80003478:	00009717          	auipc	a4,0x9
    8000347c:	b8f73823          	sd	a5,-1136(a4) # 8000c008 <_ZN15MemoryAllocator12allocMemTailE>
    80003480:	fadff06f          	j	8000342c <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003484:	01053783          	ld	a5,16(a0)
    80003488:	00009717          	auipc	a4,0x9
    8000348c:	b8f73423          	sd	a5,-1144(a4) # 8000c010 <_ZN15MemoryAllocator12allocMemHeadE>
    80003490:	fa1ff06f          	j	80003430 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003494:	fff00513          	li	a0,-1
}
    80003498:	00008067          	ret

000000008000349c <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    8000349c:	fe010113          	addi	sp,sp,-32
    800034a0:	00113c23          	sd	ra,24(sp)
    800034a4:	00813823          	sd	s0,16(sp)
    800034a8:	00913423          	sd	s1,8(sp)
    800034ac:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800034b0:	00009497          	auipc	s1,0x9
    800034b4:	b604b483          	ld	s1,-1184(s1) # 8000c010 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800034b8:	00006517          	auipc	a0,0x6
    800034bc:	e3850513          	addi	a0,a0,-456 # 800092f0 <CONSOLE_STATUS+0x2e0>
    800034c0:	fffff097          	auipc	ra,0xfffff
    800034c4:	398080e7          	jalr	920(ra) # 80002858 <_Z11printStringPKc>
    while(iter!=nullptr){
    800034c8:	04048663          	beqz	s1,80003514 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800034cc:	00000613          	li	a2,0
    800034d0:	00a00593          	li	a1,10
    800034d4:	0004851b          	sext.w	a0,s1
    800034d8:	fffff097          	auipc	ra,0xfffff
    800034dc:	518080e7          	jalr	1304(ra) # 800029f0 <_Z8printIntiii>
        putc(' ');
    800034e0:	02000513          	li	a0,32
    800034e4:	fffff097          	auipc	ra,0xfffff
    800034e8:	bb4080e7          	jalr	-1100(ra) # 80002098 <_Z4putcc>
        printInt(iter->size);
    800034ec:	00000613          	li	a2,0
    800034f0:	00a00593          	li	a1,10
    800034f4:	0004a503          	lw	a0,0(s1)
    800034f8:	fffff097          	auipc	ra,0xfffff
    800034fc:	4f8080e7          	jalr	1272(ra) # 800029f0 <_Z8printIntiii>
        putc('\n');
    80003500:	00a00513          	li	a0,10
    80003504:	fffff097          	auipc	ra,0xfffff
    80003508:	b94080e7          	jalr	-1132(ra) # 80002098 <_Z4putcc>
        iter=iter->next;
    8000350c:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003510:	fb9ff06f          	j	800034c8 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003514:	00006517          	auipc	a0,0x6
    80003518:	dfc50513          	addi	a0,a0,-516 # 80009310 <CONSOLE_STATUS+0x300>
    8000351c:	fffff097          	auipc	ra,0xfffff
    80003520:	33c080e7          	jalr	828(ra) # 80002858 <_Z11printStringPKc>
    iter = freeMemHead;
    80003524:	00009497          	auipc	s1,0x9
    80003528:	adc4b483          	ld	s1,-1316(s1) # 8000c000 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    8000352c:	04048663          	beqz	s1,80003578 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003530:	00000613          	li	a2,0
    80003534:	00a00593          	li	a1,10
    80003538:	0004851b          	sext.w	a0,s1
    8000353c:	fffff097          	auipc	ra,0xfffff
    80003540:	4b4080e7          	jalr	1204(ra) # 800029f0 <_Z8printIntiii>
        putc(' ');
    80003544:	02000513          	li	a0,32
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	b50080e7          	jalr	-1200(ra) # 80002098 <_Z4putcc>
        printInt(iter->size);
    80003550:	00000613          	li	a2,0
    80003554:	00a00593          	li	a1,10
    80003558:	0004a503          	lw	a0,0(s1)
    8000355c:	fffff097          	auipc	ra,0xfffff
    80003560:	494080e7          	jalr	1172(ra) # 800029f0 <_Z8printIntiii>
        putc('\n');
    80003564:	00a00513          	li	a0,10
    80003568:	fffff097          	auipc	ra,0xfffff
    8000356c:	b30080e7          	jalr	-1232(ra) # 80002098 <_Z4putcc>
        iter=iter->next;
    80003570:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003574:	fb9ff06f          	j	8000352c <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80003578:	00006517          	auipc	a0,0x6
    8000357c:	db850513          	addi	a0,a0,-584 # 80009330 <CONSOLE_STATUS+0x320>
    80003580:	fffff097          	auipc	ra,0xfffff
    80003584:	2d8080e7          	jalr	728(ra) # 80002858 <_Z11printStringPKc>
}
    80003588:	01813083          	ld	ra,24(sp)
    8000358c:	01013403          	ld	s0,16(sp)
    80003590:	00813483          	ld	s1,8(sp)
    80003594:	02010113          	addi	sp,sp,32
    80003598:	00008067          	ret

000000008000359c <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    8000359c:	ff010113          	addi	sp,sp,-16
    800035a0:	00813423          	sd	s0,8(sp)
    800035a4:	01010413          	addi	s0,sp,16
    800035a8:	00050813          	mv	a6,a0
    800035ac:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800035b0:	00000793          	li	a5,0
    800035b4:	00c7fe63          	bgeu	a5,a2,800035d0 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800035b8:	00f50733          	add	a4,a0,a5
    800035bc:	00f806b3          	add	a3,a6,a5
    800035c0:	0006c683          	lbu	a3,0(a3)
    800035c4:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800035c8:	00178793          	addi	a5,a5,1
    800035cc:	fe9ff06f          	j	800035b4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800035d0:	00813403          	ld	s0,8(sp)
    800035d4:	01010113          	addi	sp,sp,16
    800035d8:	00008067          	ret

00000000800035dc <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    800035dc:	ff010113          	addi	sp,sp,-16
    800035e0:	00113423          	sd	ra,8(sp)
    800035e4:	00813023          	sd	s0,0(sp)
    800035e8:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800035ec:	00053783          	ld	a5,0(a0)
    800035f0:	0107b783          	ld	a5,16(a5)
    800035f4:	000780e7          	jalr	a5
}
    800035f8:	00813083          	ld	ra,8(sp)
    800035fc:	00013403          	ld	s0,0(sp)
    80003600:	01010113          	addi	sp,sp,16
    80003604:	00008067          	ret

0000000080003608 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80003608:	ff010113          	addi	sp,sp,-16
    8000360c:	00113423          	sd	ra,8(sp)
    80003610:	00813023          	sd	s0,0(sp)
    80003614:	01010413          	addi	s0,sp,16
    80003618:	00008797          	auipc	a5,0x8
    8000361c:	69878793          	addi	a5,a5,1688 # 8000bcb0 <_ZTV9Semaphore+0x10>
    80003620:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003624:	00853503          	ld	a0,8(a0)
    80003628:	fffff097          	auipc	ra,0xfffff
    8000362c:	998080e7          	jalr	-1640(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
};
    80003630:	00813083          	ld	ra,8(sp)
    80003634:	00013403          	ld	s0,0(sp)
    80003638:	01010113          	addi	sp,sp,16
    8000363c:	00008067          	ret

0000000080003640 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80003640:	00008797          	auipc	a5,0x8
    80003644:	69078793          	addi	a5,a5,1680 # 8000bcd0 <_ZTV6Thread+0x10>
    80003648:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8000364c:	00853503          	ld	a0,8(a0)
    80003650:	02050663          	beqz	a0,8000367c <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003654:	ff010113          	addi	sp,sp,-16
    80003658:	00113423          	sd	ra,8(sp)
    8000365c:	00813023          	sd	s0,0(sp)
    80003660:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003664:	fffff097          	auipc	ra,0xfffff
    80003668:	aa8080e7          	jalr	-1368(ra) # 8000210c <_ZN7_threaddlEPv>
}
    8000366c:	00813083          	ld	ra,8(sp)
    80003670:	00013403          	ld	s0,0(sp)
    80003674:	01010113          	addi	sp,sp,16
    80003678:	00008067          	ret
    8000367c:	00008067          	ret

0000000080003680 <_Znwm>:
void* operator new(size_t sz){
    80003680:	ff010113          	addi	sp,sp,-16
    80003684:	00113423          	sd	ra,8(sp)
    80003688:	00813023          	sd	s0,0(sp)
    8000368c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003690:	ffffe097          	auipc	ra,0xffffe
    80003694:	730080e7          	jalr	1840(ra) # 80001dc0 <_Z9mem_allocm>
}
    80003698:	00813083          	ld	ra,8(sp)
    8000369c:	00013403          	ld	s0,0(sp)
    800036a0:	01010113          	addi	sp,sp,16
    800036a4:	00008067          	ret

00000000800036a8 <_Znam>:
void* operator new[](size_t sz){
    800036a8:	ff010113          	addi	sp,sp,-16
    800036ac:	00113423          	sd	ra,8(sp)
    800036b0:	00813023          	sd	s0,0(sp)
    800036b4:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800036b8:	ffffe097          	auipc	ra,0xffffe
    800036bc:	708080e7          	jalr	1800(ra) # 80001dc0 <_Z9mem_allocm>
}
    800036c0:	00813083          	ld	ra,8(sp)
    800036c4:	00013403          	ld	s0,0(sp)
    800036c8:	01010113          	addi	sp,sp,16
    800036cc:	00008067          	ret

00000000800036d0 <_ZdlPv>:
void operator delete(void *ptr){
    800036d0:	ff010113          	addi	sp,sp,-16
    800036d4:	00113423          	sd	ra,8(sp)
    800036d8:	00813023          	sd	s0,0(sp)
    800036dc:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800036e0:	ffffe097          	auipc	ra,0xffffe
    800036e4:	710080e7          	jalr	1808(ra) # 80001df0 <_Z8mem_freePv>
}
    800036e8:	00813083          	ld	ra,8(sp)
    800036ec:	00013403          	ld	s0,0(sp)
    800036f0:	01010113          	addi	sp,sp,16
    800036f4:	00008067          	ret

00000000800036f8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    800036f8:	fe010113          	addi	sp,sp,-32
    800036fc:	00113c23          	sd	ra,24(sp)
    80003700:	00813823          	sd	s0,16(sp)
    80003704:	00913423          	sd	s1,8(sp)
    80003708:	02010413          	addi	s0,sp,32
    8000370c:	00050493          	mv	s1,a0
};
    80003710:	00000097          	auipc	ra,0x0
    80003714:	ef8080e7          	jalr	-264(ra) # 80003608 <_ZN9SemaphoreD1Ev>
    80003718:	00048513          	mv	a0,s1
    8000371c:	00000097          	auipc	ra,0x0
    80003720:	fb4080e7          	jalr	-76(ra) # 800036d0 <_ZdlPv>
    80003724:	01813083          	ld	ra,24(sp)
    80003728:	01013403          	ld	s0,16(sp)
    8000372c:	00813483          	ld	s1,8(sp)
    80003730:	02010113          	addi	sp,sp,32
    80003734:	00008067          	ret

0000000080003738 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80003738:	fe010113          	addi	sp,sp,-32
    8000373c:	00113c23          	sd	ra,24(sp)
    80003740:	00813823          	sd	s0,16(sp)
    80003744:	00913423          	sd	s1,8(sp)
    80003748:	02010413          	addi	s0,sp,32
    8000374c:	00050493          	mv	s1,a0
}
    80003750:	00000097          	auipc	ra,0x0
    80003754:	ef0080e7          	jalr	-272(ra) # 80003640 <_ZN6ThreadD1Ev>
    80003758:	00048513          	mv	a0,s1
    8000375c:	00000097          	auipc	ra,0x0
    80003760:	f74080e7          	jalr	-140(ra) # 800036d0 <_ZdlPv>
    80003764:	01813083          	ld	ra,24(sp)
    80003768:	01013403          	ld	s0,16(sp)
    8000376c:	00813483          	ld	s1,8(sp)
    80003770:	02010113          	addi	sp,sp,32
    80003774:	00008067          	ret

0000000080003778 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80003778:	ff010113          	addi	sp,sp,-16
    8000377c:	00113423          	sd	ra,8(sp)
    80003780:	00813023          	sd	s0,0(sp)
    80003784:	01010413          	addi	s0,sp,16
    80003788:	00008797          	auipc	a5,0x8
    8000378c:	52878793          	addi	a5,a5,1320 # 8000bcb0 <_ZTV9Semaphore+0x10>
    80003790:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003794:	00850513          	addi	a0,a0,8
    80003798:	ffffe097          	auipc	ra,0xffffe
    8000379c:	7f0080e7          	jalr	2032(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
}
    800037a0:	00813083          	ld	ra,8(sp)
    800037a4:	00013403          	ld	s0,0(sp)
    800037a8:	01010113          	addi	sp,sp,16
    800037ac:	00008067          	ret

00000000800037b0 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    800037b0:	ff010113          	addi	sp,sp,-16
    800037b4:	00113423          	sd	ra,8(sp)
    800037b8:	00813023          	sd	s0,0(sp)
    800037bc:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800037c0:	00853503          	ld	a0,8(a0)
    800037c4:	fffff097          	auipc	ra,0xfffff
    800037c8:	828080e7          	jalr	-2008(ra) # 80001fec <_Z8sem_waitP10_semaphore>
}
    800037cc:	00813083          	ld	ra,8(sp)
    800037d0:	00013403          	ld	s0,0(sp)
    800037d4:	01010113          	addi	sp,sp,16
    800037d8:	00008067          	ret

00000000800037dc <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800037dc:	ff010113          	addi	sp,sp,-16
    800037e0:	00113423          	sd	ra,8(sp)
    800037e4:	00813023          	sd	s0,0(sp)
    800037e8:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800037ec:	00853503          	ld	a0,8(a0)
    800037f0:	fffff097          	auipc	ra,0xfffff
    800037f4:	828080e7          	jalr	-2008(ra) # 80002018 <_Z10sem_signalP10_semaphore>
}
    800037f8:	00813083          	ld	ra,8(sp)
    800037fc:	00013403          	ld	s0,0(sp)
    80003800:	01010113          	addi	sp,sp,16
    80003804:	00008067          	ret

0000000080003808 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80003808:	ff010113          	addi	sp,sp,-16
    8000380c:	00113423          	sd	ra,8(sp)
    80003810:	00813023          	sd	s0,0(sp)
    80003814:	01010413          	addi	s0,sp,16
    80003818:	00008797          	auipc	a5,0x8
    8000381c:	4b878793          	addi	a5,a5,1208 # 8000bcd0 <_ZTV6Thread+0x10>
    80003820:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80003824:	00850513          	addi	a0,a0,8
    80003828:	ffffe097          	auipc	ra,0xffffe
    8000382c:	6b8080e7          	jalr	1720(ra) # 80001ee0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003830:	00813083          	ld	ra,8(sp)
    80003834:	00013403          	ld	s0,0(sp)
    80003838:	01010113          	addi	sp,sp,16
    8000383c:	00008067          	ret

0000000080003840 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003840:	ff010113          	addi	sp,sp,-16
    80003844:	00113423          	sd	ra,8(sp)
    80003848:	00813023          	sd	s0,0(sp)
    8000384c:	01010413          	addi	s0,sp,16
    80003850:	00008797          	auipc	a5,0x8
    80003854:	48078793          	addi	a5,a5,1152 # 8000bcd0 <_ZTV6Thread+0x10>
    80003858:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    8000385c:	00050613          	mv	a2,a0
    80003860:	00000597          	auipc	a1,0x0
    80003864:	d7c58593          	addi	a1,a1,-644 # 800035dc <_ZN6Thread7wrapperEPv>
    80003868:	00850513          	addi	a0,a0,8
    8000386c:	ffffe097          	auipc	ra,0xffffe
    80003870:	674080e7          	jalr	1652(ra) # 80001ee0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003874:	00813083          	ld	ra,8(sp)
    80003878:	00013403          	ld	s0,0(sp)
    8000387c:	01010113          	addi	sp,sp,16
    80003880:	00008067          	ret

0000000080003884 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003884:	ff010113          	addi	sp,sp,-16
    80003888:	00113423          	sd	ra,8(sp)
    8000388c:	00813023          	sd	s0,0(sp)
    80003890:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003894:	ffffe097          	auipc	ra,0xffffe
    80003898:	7b0080e7          	jalr	1968(ra) # 80002044 <_Z10time_sleepm>
}
    8000389c:	00813083          	ld	ra,8(sp)
    800038a0:	00013403          	ld	s0,0(sp)
    800038a4:	01010113          	addi	sp,sp,16
    800038a8:	00008067          	ret

00000000800038ac <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    800038ac:	fe010113          	addi	sp,sp,-32
    800038b0:	00113c23          	sd	ra,24(sp)
    800038b4:	00813823          	sd	s0,16(sp)
    800038b8:	00913423          	sd	s1,8(sp)
    800038bc:	01213023          	sd	s2,0(sp)
    800038c0:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    800038c4:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    800038c8:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    800038cc:	0004b783          	ld	a5,0(s1)
    800038d0:	0187b783          	ld	a5,24(a5)
    800038d4:	00048513          	mv	a0,s1
    800038d8:	000780e7          	jalr	a5
        pt->sleep(time);
    800038dc:	00090513          	mv	a0,s2
    800038e0:	00000097          	auipc	ra,0x0
    800038e4:	fa4080e7          	jalr	-92(ra) # 80003884 <_ZN6Thread5sleepEm>
    while(true){
    800038e8:	fe5ff06f          	j	800038cc <_ZN14PeriodicThread7wrapperEPv+0x20>

00000000800038ec <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800038ec:	ff010113          	addi	sp,sp,-16
    800038f0:	00113423          	sd	ra,8(sp)
    800038f4:	00813023          	sd	s0,0(sp)
    800038f8:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800038fc:	ffffe097          	auipc	ra,0xffffe
    80003900:	5c4080e7          	jalr	1476(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    80003904:	00813083          	ld	ra,8(sp)
    80003908:	00013403          	ld	s0,0(sp)
    8000390c:	01010113          	addi	sp,sp,16
    80003910:	00008067          	ret

0000000080003914 <_ZN6Thread5startEv>:
int Thread::start() {
    80003914:	ff010113          	addi	sp,sp,-16
    80003918:	00113423          	sd	ra,8(sp)
    8000391c:	00813023          	sd	s0,0(sp)
    80003920:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80003924:	00853503          	ld	a0,8(a0)
    80003928:	ffffe097          	auipc	ra,0xffffe
    8000392c:	634080e7          	jalr	1588(ra) # 80001f5c <_Z12thread_startP7_thread>
}
    80003930:	00813083          	ld	ra,8(sp)
    80003934:	00013403          	ld	s0,0(sp)
    80003938:	01010113          	addi	sp,sp,16
    8000393c:	00008067          	ret

0000000080003940 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003940:	fe010113          	addi	sp,sp,-32
    80003944:	00113c23          	sd	ra,24(sp)
    80003948:	00813823          	sd	s0,16(sp)
    8000394c:	00913423          	sd	s1,8(sp)
    80003950:	01213023          	sd	s2,0(sp)
    80003954:	02010413          	addi	s0,sp,32
    80003958:	00050493          	mv	s1,a0
    8000395c:	00058913          	mv	s2,a1
    80003960:	01000513          	li	a0,16
    80003964:	00000097          	auipc	ra,0x0
    80003968:	d1c080e7          	jalr	-740(ra) # 80003680 <_Znwm>
    8000396c:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003970:	00953023          	sd	s1,0(a0)
    80003974:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003978:	00000597          	auipc	a1,0x0
    8000397c:	f3458593          	addi	a1,a1,-204 # 800038ac <_ZN14PeriodicThread7wrapperEPv>
    80003980:	00048513          	mv	a0,s1
    80003984:	00000097          	auipc	ra,0x0
    80003988:	e84080e7          	jalr	-380(ra) # 80003808 <_ZN6ThreadC1EPFvPvES0_>
    8000398c:	00008797          	auipc	a5,0x8
    80003990:	2f478793          	addi	a5,a5,756 # 8000bc80 <_ZTV14PeriodicThread+0x10>
    80003994:	00f4b023          	sd	a5,0(s1)
    80003998:	01813083          	ld	ra,24(sp)
    8000399c:	01013403          	ld	s0,16(sp)
    800039a0:	00813483          	ld	s1,8(sp)
    800039a4:	00013903          	ld	s2,0(sp)
    800039a8:	02010113          	addi	sp,sp,32
    800039ac:	00008067          	ret

00000000800039b0 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    800039b0:	ff010113          	addi	sp,sp,-16
    800039b4:	00113423          	sd	ra,8(sp)
    800039b8:	00813023          	sd	s0,0(sp)
    800039bc:	01010413          	addi	s0,sp,16
    return ::getc();
    800039c0:	ffffe097          	auipc	ra,0xffffe
    800039c4:	6b0080e7          	jalr	1712(ra) # 80002070 <_Z4getcv>
}
    800039c8:	00813083          	ld	ra,8(sp)
    800039cc:	00013403          	ld	s0,0(sp)
    800039d0:	01010113          	addi	sp,sp,16
    800039d4:	00008067          	ret

00000000800039d8 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800039d8:	ff010113          	addi	sp,sp,-16
    800039dc:	00113423          	sd	ra,8(sp)
    800039e0:	00813023          	sd	s0,0(sp)
    800039e4:	01010413          	addi	s0,sp,16
    ::putc(c);
    800039e8:	ffffe097          	auipc	ra,0xffffe
    800039ec:	6b0080e7          	jalr	1712(ra) # 80002098 <_Z4putcc>
}
    800039f0:	00813083          	ld	ra,8(sp)
    800039f4:	00013403          	ld	s0,0(sp)
    800039f8:	01010113          	addi	sp,sp,16
    800039fc:	00008067          	ret

0000000080003a00 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003a00:	ff010113          	addi	sp,sp,-16
    80003a04:	00813423          	sd	s0,8(sp)
    80003a08:	01010413          	addi	s0,sp,16
    80003a0c:	00813403          	ld	s0,8(sp)
    80003a10:	01010113          	addi	sp,sp,16
    80003a14:	00008067          	ret

0000000080003a18 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003a18:	ff010113          	addi	sp,sp,-16
    80003a1c:	00813423          	sd	s0,8(sp)
    80003a20:	01010413          	addi	s0,sp,16
    80003a24:	00813403          	ld	s0,8(sp)
    80003a28:	01010113          	addi	sp,sp,16
    80003a2c:	00008067          	ret

0000000080003a30 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003a30:	ff010113          	addi	sp,sp,-16
    80003a34:	00113423          	sd	ra,8(sp)
    80003a38:	00813023          	sd	s0,0(sp)
    80003a3c:	01010413          	addi	s0,sp,16
    80003a40:	00008797          	auipc	a5,0x8
    80003a44:	24078793          	addi	a5,a5,576 # 8000bc80 <_ZTV14PeriodicThread+0x10>
    80003a48:	00f53023          	sd	a5,0(a0)
    80003a4c:	00000097          	auipc	ra,0x0
    80003a50:	bf4080e7          	jalr	-1036(ra) # 80003640 <_ZN6ThreadD1Ev>
    80003a54:	00813083          	ld	ra,8(sp)
    80003a58:	00013403          	ld	s0,0(sp)
    80003a5c:	01010113          	addi	sp,sp,16
    80003a60:	00008067          	ret

0000000080003a64 <_ZN14PeriodicThreadD0Ev>:
    80003a64:	fe010113          	addi	sp,sp,-32
    80003a68:	00113c23          	sd	ra,24(sp)
    80003a6c:	00813823          	sd	s0,16(sp)
    80003a70:	00913423          	sd	s1,8(sp)
    80003a74:	02010413          	addi	s0,sp,32
    80003a78:	00050493          	mv	s1,a0
    80003a7c:	00008797          	auipc	a5,0x8
    80003a80:	20478793          	addi	a5,a5,516 # 8000bc80 <_ZTV14PeriodicThread+0x10>
    80003a84:	00f53023          	sd	a5,0(a0)
    80003a88:	00000097          	auipc	ra,0x0
    80003a8c:	bb8080e7          	jalr	-1096(ra) # 80003640 <_ZN6ThreadD1Ev>
    80003a90:	00048513          	mv	a0,s1
    80003a94:	00000097          	auipc	ra,0x0
    80003a98:	c3c080e7          	jalr	-964(ra) # 800036d0 <_ZdlPv>
    80003a9c:	01813083          	ld	ra,24(sp)
    80003aa0:	01013403          	ld	s0,16(sp)
    80003aa4:	00813483          	ld	s1,8(sp)
    80003aa8:	02010113          	addi	sp,sp,32
    80003aac:	00008067          	ret

0000000080003ab0 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003ab0:	ff010113          	addi	sp,sp,-16
    80003ab4:	00113423          	sd	ra,8(sp)
    80003ab8:	00813023          	sd	s0,0(sp)
    80003abc:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003ac0:	00008797          	auipc	a5,0x8
    80003ac4:	3087b783          	ld	a5,776(a5) # 8000bdc8 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003ac8:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 32);
    80003acc:	00008797          	auipc	a5,0x8
    80003ad0:	2ac7b783          	ld	a5,684(a5) # 8000bd78 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003ad4:	0007b503          	ld	a0,0(a5)
    80003ad8:	00c55513          	srli	a0,a0,0xc
    80003adc:	00250513          	addi	a0,a0,2
    80003ae0:	02000593          	li	a1,32
    80003ae4:	00c51513          	slli	a0,a0,0xc
    80003ae8:	00001097          	auipc	ra,0x1
    80003aec:	5ec080e7          	jalr	1516(ra) # 800050d4 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    80003af0:	fffff097          	auipc	ra,0xfffff
    80003af4:	650080e7          	jalr	1616(ra) # 80003140 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003af8:	00001097          	auipc	ra,0x1
    80003afc:	f58080e7          	jalr	-168(ra) # 80004a50 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003b00:	fffff097          	auipc	ra,0xfffff
    80003b04:	4ec080e7          	jalr	1260(ra) # 80002fec <_ZN3TCB10initializeEv>
    SCB::initialize();
    80003b08:	fffff097          	auipc	ra,0xfffff
    80003b0c:	034080e7          	jalr	52(ra) # 80002b3c <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80003b10:	00001097          	auipc	ra,0x1
    80003b14:	154080e7          	jalr	340(ra) # 80004c64 <_ZN11ConsoleUtil10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003b18:	00200793          	li	a5,2
    80003b1c:	1047a073          	csrs	sie,a5
    80003b20:	20000713          	li	a4,512
    80003b24:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003b28:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003b2c:	00813083          	ld	ra,8(sp)
    80003b30:	00013403          	ld	s0,0(sp)
    80003b34:	01010113          	addi	sp,sp,16
    80003b38:	00008067          	ret

0000000080003b3c <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003b3c:	ff010113          	addi	sp,sp,-16
    80003b40:	00813423          	sd	s0,8(sp)
    80003b44:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003b48:	14109073          	csrw	sepc,ra
    asm("sret");
    80003b4c:	10200073          	sret
}
    80003b50:	00813403          	ld	s0,8(sp)
    80003b54:	01010113          	addi	sp,sp,16
    80003b58:	00008067          	ret

0000000080003b5c <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003b5c:	ff010113          	addi	sp,sp,-16
    80003b60:	00113423          	sd	ra,8(sp)
    80003b64:	00813023          	sd	s0,0(sp)
    80003b68:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003b6c:	00008797          	auipc	a5,0x8
    80003b70:	27c7b783          	ld	a5,636(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b74:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003b78:	00100713          	li	a4,1
    80003b7c:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003b80:	fffff097          	auipc	ra,0xfffff
    80003b84:	3bc080e7          	jalr	956(ra) # 80002f3c <_ZN3TCB8dispatchEv>
}
    80003b88:	00813083          	ld	ra,8(sp)
    80003b8c:	00013403          	ld	s0,0(sp)
    80003b90:	01010113          	addi	sp,sp,16
    80003b94:	00008067          	ret

0000000080003b98 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003b98:	ff010113          	addi	sp,sp,-16
    80003b9c:	00113423          	sd	ra,8(sp)
    80003ba0:	00813023          	sd	s0,0(sp)
    80003ba4:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003ba8:	00008797          	auipc	a5,0x8
    80003bac:	4787c783          	lbu	a5,1144(a5) # 8000c020 <_ZN5RiscV16userMainFinishedE>
    80003bb0:	00079c63          	bnez	a5,80003bc8 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003bb4:	00008717          	auipc	a4,0x8
    80003bb8:	22c73703          	ld	a4,556(a4) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003bbc:	00073783          	ld	a5,0(a4)
    80003bc0:	00178793          	addi	a5,a5,1
    80003bc4:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003bc8:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003bcc:	0ff57513          	andi	a0,a0,255
    80003bd0:	00001097          	auipc	ra,0x1
    80003bd4:	254080e7          	jalr	596(ra) # 80004e24 <_ZN11ConsoleUtil9putOutputEc>
}
    80003bd8:	00813083          	ld	ra,8(sp)
    80003bdc:	00013403          	ld	s0,0(sp)
    80003be0:	01010113          	addi	sp,sp,16
    80003be4:	00008067          	ret

0000000080003be8 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003be8:	fe010113          	addi	sp,sp,-32
    80003bec:	00113c23          	sd	ra,24(sp)
    80003bf0:	00813823          	sd	s0,16(sp)
    80003bf4:	02010413          	addi	s0,sp,32
    80003bf8:	00c0006f          	j	80003c04 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003bfc:	ffffe097          	auipc	ra,0xffffe
    80003c00:	2c4080e7          	jalr	708(ra) # 80001ec0 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003c04:	00008797          	auipc	a5,0x8
    80003c08:	16c7b783          	ld	a5,364(a5) # 8000bd70 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003c0c:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003c10:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003c14:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003c18:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003c1c:	0207f793          	andi	a5,a5,32
    80003c20:	fc078ee3          	beqz	a5,80003bfc <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003c24:	00001097          	auipc	ra,0x1
    80003c28:	488080e7          	jalr	1160(ra) # 800050ac <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003c2c:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003c30:	00008797          	auipc	a5,0x8
    80003c34:	1387b783          	ld	a5,312(a5) # 8000bd68 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003c38:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003c3c:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003c40:	fef44783          	lbu	a5,-17(s0)
    80003c44:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003c48:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003c4c:	00008797          	auipc	a5,0x8
    80003c50:	1947b783          	ld	a5,404(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003c54:	0007b783          	ld	a5,0(a5)
    80003c58:	fa0786e3          	beqz	a5,80003c04 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003c5c:	fff78793          	addi	a5,a5,-1
    80003c60:	00008717          	auipc	a4,0x8
    80003c64:	18073703          	ld	a4,384(a4) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003c68:	00f73023          	sd	a5,0(a4)
    80003c6c:	f99ff06f          	j	80003c04 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003c70 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003c70:	ff010113          	addi	sp,sp,-16
    80003c74:	00813423          	sd	s0,8(sp)
    80003c78:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80003c7c:	00008797          	auipc	a5,0x8
    80003c80:	16c7b783          	ld	a5,364(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003c84:	0007b783          	ld	a5,0(a5)
    80003c88:	0147a703          	lw	a4,20(a5)
    80003c8c:	00100793          	li	a5,1
    80003c90:	00f70c63          	beq	a4,a5,80003ca8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003c94:	10000793          	li	a5,256
    80003c98:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    80003c9c:	00813403          	ld	s0,8(sp)
    80003ca0:	01010113          	addi	sp,sp,16
    80003ca4:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003ca8:	10000793          	li	a5,256
    80003cac:	1007a073          	csrs	sstatus,a5
}
    80003cb0:	fedff06f          	j	80003c9c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080003cb4 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003cb4:	ff010113          	addi	sp,sp,-16
    80003cb8:	00113423          	sd	ra,8(sp)
    80003cbc:	00813023          	sd	s0,0(sp)
    80003cc0:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003cc4:	00100793          	li	a5,1
    80003cc8:	00008717          	auipc	a4,0x8
    80003ccc:	34f70c23          	sb	a5,856(a4) # 8000c020 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003cd0:	00008797          	auipc	a5,0x8
    80003cd4:	1107b783          	ld	a5,272(a5) # 8000bde0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003cd8:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003cdc:	00008797          	auipc	a5,0x8
    80003ce0:	0bc7b783          	ld	a5,188(a5) # 8000bd98 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003ce4:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003ce8:	00200793          	li	a5,2
    80003cec:	1047b073          	csrc	sie,a5
    80003cf0:	20000793          	li	a5,512
    80003cf4:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003cf8:	00008797          	auipc	a5,0x8
    80003cfc:	0c07b783          	ld	a5,192(a5) # 8000bdb8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003d00:	0007b783          	ld	a5,0(a5)
    80003d04:	00078c63          	beqz	a5,80003d1c <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003d08:	0487b703          	ld	a4,72(a5)
    80003d0c:	00008797          	auipc	a5,0x8
    80003d10:	0ac7b783          	ld	a5,172(a5) # 8000bdb8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003d14:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003d18:	fe1ff06f          	j	80003cf8 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003d1c:	00008797          	auipc	a5,0x8
    80003d20:	0a47b783          	ld	a5,164(a5) # 8000bdc0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003d24:	0007b503          	ld	a0,0(a5)
    80003d28:	00001097          	auipc	ra,0x1
    80003d2c:	d40080e7          	jalr	-704(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003d30:	00008797          	auipc	a5,0x8
    80003d34:	0a07b783          	ld	a5,160(a5) # 8000bdd0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003d38:	0007b703          	ld	a4,0(a5)
    80003d3c:	00008797          	auipc	a5,0x8
    80003d40:	09c7b783          	ld	a5,156(a5) # 8000bdd8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003d44:	0007b783          	ld	a5,0(a5)
    80003d48:	00f70863          	beq	a4,a5,80003d58 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003d4c:	ffffe097          	auipc	ra,0xffffe
    80003d50:	174080e7          	jalr	372(ra) # 80001ec0 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003d54:	fddff06f          	j	80003d30 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003d58:	00813083          	ld	ra,8(sp)
    80003d5c:	00013403          	ld	s0,0(sp)
    80003d60:	01010113          	addi	sp,sp,16
    80003d64:	00008067          	ret

0000000080003d68 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003d68:	ff010113          	addi	sp,sp,-16
    80003d6c:	00813423          	sd	s0,8(sp)
    80003d70:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003d74:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003d78:	00008717          	auipc	a4,0x8
    80003d7c:	07073703          	ld	a4,112(a4) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003d80:	00073703          	ld	a4,0(a4)
    80003d84:	06873703          	ld	a4,104(a4)
    80003d88:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003d8c:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003d90:	00078593          	mv	a1,a5
}
    80003d94:	00813403          	ld	s0,8(sp)
    80003d98:	01010113          	addi	sp,sp,16
    80003d9c:	00008067          	ret

0000000080003da0 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003da0:	ff010113          	addi	sp,sp,-16
    80003da4:	00113423          	sd	ra,8(sp)
    80003da8:	00813023          	sd	s0,0(sp)
    80003dac:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003db0:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80003db4:	fffff097          	auipc	ra,0xfffff
    80003db8:	40c080e7          	jalr	1036(ra) # 800031c0 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003dbc:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003dc0:	00000097          	auipc	ra,0x0
    80003dc4:	fa8080e7          	jalr	-88(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003dc8:	00813083          	ld	ra,8(sp)
    80003dcc:	00013403          	ld	s0,0(sp)
    80003dd0:	01010113          	addi	sp,sp,16
    80003dd4:	00008067          	ret

0000000080003dd8 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003dd8:	ff010113          	addi	sp,sp,-16
    80003ddc:	00113423          	sd	ra,8(sp)
    80003de0:	00813023          	sd	s0,0(sp)
    80003de4:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003de8:	00008797          	auipc	a5,0x8
    80003dec:	0087b783          	ld	a5,8(a5) # 8000bdf0 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003df0:	0007c783          	lbu	a5,0(a5)
    80003df4:	02079263          	bnez	a5,80003e18 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003df8:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003dfc:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003e00:	00000097          	auipc	ra,0x0
    80003e04:	f68080e7          	jalr	-152(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e08:	00813083          	ld	ra,8(sp)
    80003e0c:	00013403          	ld	s0,0(sp)
    80003e10:	01010113          	addi	sp,sp,16
    80003e14:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003e18:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003e1c:	fffff097          	auipc	ra,0xfffff
    80003e20:	5cc080e7          	jalr	1484(ra) # 800033e8 <_ZN15MemoryAllocator5kfreeEPv>
    80003e24:	fd9ff06f          	j	80003dfc <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003e28 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003e28:	fc010113          	addi	sp,sp,-64
    80003e2c:	02113c23          	sd	ra,56(sp)
    80003e30:	02813823          	sd	s0,48(sp)
    80003e34:	02913423          	sd	s1,40(sp)
    80003e38:	03213023          	sd	s2,32(sp)
    80003e3c:	01313c23          	sd	s3,24(sp)
    80003e40:	01413823          	sd	s4,16(sp)
    80003e44:	01513423          	sd	s5,8(sp)
    80003e48:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003e4c:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003e50:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003e54:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003e58:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003e5c:	07000513          	li	a0,112
    80003e60:	fffff097          	auipc	ra,0xfffff
    80003e64:	15c080e7          	jalr	348(ra) # 80002fbc <_ZN3TCBnwEm>
    80003e68:	00050493          	mv	s1,a0
    80003e6c:	00200713          	li	a4,2
    80003e70:	000a0693          	mv	a3,s4
    80003e74:	00098613          	mv	a2,s3
    80003e78:	00090593          	mv	a1,s2
    80003e7c:	fffff097          	auipc	ra,0xfffff
    80003e80:	004080e7          	jalr	4(ra) # 80002e80 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003e84:	04048863          	beqz	s1,80003ed4 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003e88:	0184b783          	ld	a5,24(s1)
    80003e8c:	00078863          	beqz	a5,80003e9c <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003e90:	00048513          	mv	a0,s1
    80003e94:	00001097          	auipc	ra,0x1
    80003e98:	bd4080e7          	jalr	-1068(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003e9c:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003ea0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ea4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003ea8:	00000097          	auipc	ra,0x0
    80003eac:	ec0080e7          	jalr	-320(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003eb0:	03813083          	ld	ra,56(sp)
    80003eb4:	03013403          	ld	s0,48(sp)
    80003eb8:	02813483          	ld	s1,40(sp)
    80003ebc:	02013903          	ld	s2,32(sp)
    80003ec0:	01813983          	ld	s3,24(sp)
    80003ec4:	01013a03          	ld	s4,16(sp)
    80003ec8:	00813a83          	ld	s5,8(sp)
    80003ecc:	04010113          	addi	sp,sp,64
    80003ed0:	00008067          	ret
        status = -1;
    80003ed4:	fff00793          	li	a5,-1
    80003ed8:	fcdff06f          	j	80003ea4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    80003edc:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003ee0:	00048513          	mv	a0,s1
    80003ee4:	fffff097          	auipc	ra,0xfffff
    80003ee8:	1fc080e7          	jalr	508(ra) # 800030e0 <_ZN3TCBdlEPv>
    80003eec:	00090513          	mv	a0,s2
    80003ef0:	00009097          	auipc	ra,0x9
    80003ef4:	298080e7          	jalr	664(ra) # 8000d188 <_Unwind_Resume>

0000000080003ef8 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003ef8:	fc010113          	addi	sp,sp,-64
    80003efc:	02113c23          	sd	ra,56(sp)
    80003f00:	02813823          	sd	s0,48(sp)
    80003f04:	02913423          	sd	s1,40(sp)
    80003f08:	03213023          	sd	s2,32(sp)
    80003f0c:	01313c23          	sd	s3,24(sp)
    80003f10:	01413823          	sd	s4,16(sp)
    80003f14:	01513423          	sd	s5,8(sp)
    80003f18:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003f1c:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003f20:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003f24:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003f28:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003f2c:	07000513          	li	a0,112
    80003f30:	fffff097          	auipc	ra,0xfffff
    80003f34:	08c080e7          	jalr	140(ra) # 80002fbc <_ZN3TCBnwEm>
    80003f38:	00050493          	mv	s1,a0
    80003f3c:	00200713          	li	a4,2
    80003f40:	00090693          	mv	a3,s2
    80003f44:	00098613          	mv	a2,s3
    80003f48:	000a0593          	mv	a1,s4
    80003f4c:	fffff097          	auipc	ra,0xfffff
    80003f50:	f34080e7          	jalr	-204(ra) # 80002e80 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003f54:	04048263          	beqz	s1,80003f98 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003f58:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003f5c:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003f60:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003f64:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003f68:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003f6c:	00000097          	auipc	ra,0x0
    80003f70:	dfc080e7          	jalr	-516(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003f74:	03813083          	ld	ra,56(sp)
    80003f78:	03013403          	ld	s0,48(sp)
    80003f7c:	02813483          	ld	s1,40(sp)
    80003f80:	02013903          	ld	s2,32(sp)
    80003f84:	01813983          	ld	s3,24(sp)
    80003f88:	01013a03          	ld	s4,16(sp)
    80003f8c:	00813a83          	ld	s5,8(sp)
    80003f90:	04010113          	addi	sp,sp,64
    80003f94:	00008067          	ret
        status = -1;
    80003f98:	fff00793          	li	a5,-1
    80003f9c:	fcdff06f          	j	80003f68 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003fa0:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003fa4:	00048513          	mv	a0,s1
    80003fa8:	fffff097          	auipc	ra,0xfffff
    80003fac:	138080e7          	jalr	312(ra) # 800030e0 <_ZN3TCBdlEPv>
    80003fb0:	00090513          	mv	a0,s2
    80003fb4:	00009097          	auipc	ra,0x9
    80003fb8:	1d4080e7          	jalr	468(ra) # 8000d188 <_Unwind_Resume>

0000000080003fbc <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003fbc:	ff010113          	addi	sp,sp,-16
    80003fc0:	00113423          	sd	ra,8(sp)
    80003fc4:	00813023          	sd	s0,0(sp)
    80003fc8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003fcc:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003fd0:	02051263          	bnez	a0,80003ff4 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003fd4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003fd8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003fdc:	00000097          	auipc	ra,0x0
    80003fe0:	d8c080e7          	jalr	-628(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003fe4:	00813083          	ld	ra,8(sp)
    80003fe8:	00013403          	ld	s0,0(sp)
    80003fec:	01010113          	addi	sp,sp,16
    80003ff0:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003ff4:	00100793          	li	a5,1
    80003ff8:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003ffc:	00001097          	auipc	ra,0x1
    80004000:	a6c080e7          	jalr	-1428(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80004004:	fffff097          	auipc	ra,0xfffff
    80004008:	f38080e7          	jalr	-200(ra) # 80002f3c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000400c:	00000793          	li	a5,0
    80004010:	fc9ff06f          	j	80003fd8 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080004014 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80004014:	ff010113          	addi	sp,sp,-16
    80004018:	00113423          	sd	ra,8(sp)
    8000401c:	00813023          	sd	s0,0(sp)
    80004020:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80004024:	00008797          	auipc	a5,0x8
    80004028:	dc47b783          	ld	a5,-572(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000402c:	0007b783          	ld	a5,0(a5)
    80004030:	02078a63          	beqz	a5,80004064 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80004034:	00200713          	li	a4,2
    80004038:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    8000403c:	fffff097          	auipc	ra,0xfffff
    80004040:	f00080e7          	jalr	-256(ra) # 80002f3c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80004044:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004048:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000404c:	00000097          	auipc	ra,0x0
    80004050:	d1c080e7          	jalr	-740(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004054:	00813083          	ld	ra,8(sp)
    80004058:	00013403          	ld	s0,0(sp)
    8000405c:	01010113          	addi	sp,sp,16
    80004060:	00008067          	ret
        status = -1;
    80004064:	fff00793          	li	a5,-1
    80004068:	fe1ff06f          	j	80004048 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

000000008000406c <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    8000406c:	fd010113          	addi	sp,sp,-48
    80004070:	02113423          	sd	ra,40(sp)
    80004074:	02813023          	sd	s0,32(sp)
    80004078:	00913c23          	sd	s1,24(sp)
    8000407c:	01213823          	sd	s2,16(sp)
    80004080:	01313423          	sd	s3,8(sp)
    80004084:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004088:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    8000408c:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80004090:	01800513          	li	a0,24
    80004094:	fffff097          	auipc	ra,0xfffff
    80004098:	ca8080e7          	jalr	-856(ra) # 80002d3c <_ZN3SCBnwEm>
    8000409c:	00050493          	mv	s1,a0
    800040a0:	00090593          	mv	a1,s2
    800040a4:	fffff097          	auipc	ra,0xfffff
    800040a8:	ae4080e7          	jalr	-1308(ra) # 80002b88 <_ZN3SCBC1Em>
    if(scb == nullptr){
    800040ac:	02048a63          	beqz	s1,800040e0 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    800040b0:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    800040b4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800040b8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800040bc:	00000097          	auipc	ra,0x0
    800040c0:	cac080e7          	jalr	-852(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    800040c4:	02813083          	ld	ra,40(sp)
    800040c8:	02013403          	ld	s0,32(sp)
    800040cc:	01813483          	ld	s1,24(sp)
    800040d0:	01013903          	ld	s2,16(sp)
    800040d4:	00813983          	ld	s3,8(sp)
    800040d8:	03010113          	addi	sp,sp,48
    800040dc:	00008067          	ret
        status = -1;
    800040e0:	fff00793          	li	a5,-1
    800040e4:	fd5ff06f          	j	800040b8 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    800040e8:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    800040ec:	00048513          	mv	a0,s1
    800040f0:	fffff097          	auipc	ra,0xfffff
    800040f4:	c7c080e7          	jalr	-900(ra) # 80002d6c <_ZN3SCBdlEPv>
    800040f8:	00090513          	mv	a0,s2
    800040fc:	00009097          	auipc	ra,0x9
    80004100:	08c080e7          	jalr	140(ra) # 8000d188 <_Unwind_Resume>

0000000080004104 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80004104:	fe010113          	addi	sp,sp,-32
    80004108:	00113c23          	sd	ra,24(sp)
    8000410c:	00813823          	sd	s0,16(sp)
    80004110:	00913423          	sd	s1,8(sp)
    80004114:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004118:	00058493          	mv	s1,a1
    if(scb == nullptr){
    8000411c:	02049463          	bnez	s1,80004144 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80004120:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004124:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004128:	00000097          	auipc	ra,0x0
    8000412c:	c40080e7          	jalr	-960(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004130:	01813083          	ld	ra,24(sp)
    80004134:	01013403          	ld	s0,16(sp)
    80004138:	00813483          	ld	s1,8(sp)
    8000413c:	02010113          	addi	sp,sp,32
    80004140:	00008067          	ret
        delete (SCB*)ihandle;
    80004144:	00048513          	mv	a0,s1
    80004148:	fffff097          	auipc	ra,0xfffff
    8000414c:	a5c080e7          	jalr	-1444(ra) # 80002ba4 <_ZN3SCBD1Ev>
    80004150:	00048513          	mv	a0,s1
    80004154:	fffff097          	auipc	ra,0xfffff
    80004158:	c18080e7          	jalr	-1000(ra) # 80002d6c <_ZN3SCBdlEPv>
    uint64 status = 0;
    8000415c:	00000793          	li	a5,0
    80004160:	fc5ff06f          	j	80004124 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080004164 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80004164:	ff010113          	addi	sp,sp,-16
    80004168:	00113423          	sd	ra,8(sp)
    8000416c:	00813023          	sd	s0,0(sp)
    80004170:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004174:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80004178:	02051c63          	bnez	a0,800041b0 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    8000417c:	00008797          	auipc	a5,0x8
    80004180:	c6c7b783          	ld	a5,-916(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004184:	0007b783          	ld	a5,0(a5)
    80004188:	0607b783          	ld	a5,96(a5)
    8000418c:	02078863          	beqz	a5,800041bc <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80004190:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004194:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004198:	00000097          	auipc	ra,0x0
    8000419c:	bd0080e7          	jalr	-1072(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    800041a0:	00813083          	ld	ra,8(sp)
    800041a4:	00013403          	ld	s0,0(sp)
    800041a8:	01010113          	addi	sp,sp,16
    800041ac:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800041b0:	fffff097          	auipc	ra,0xfffff
    800041b4:	b00080e7          	jalr	-1280(ra) # 80002cb0 <_ZN3SCB4waitEv>
    800041b8:	fc5ff06f          	j	8000417c <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800041bc:	00000793          	li	a5,0
    800041c0:	fd5ff06f          	j	80004194 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800041c4 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800041c4:	ff010113          	addi	sp,sp,-16
    800041c8:	00113423          	sd	ra,8(sp)
    800041cc:	00813023          	sd	s0,0(sp)
    800041d0:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800041d4:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800041d8:	02051263          	bnez	a0,800041fc <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800041dc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800041e0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800041e4:	00000097          	auipc	ra,0x0
    800041e8:	b84080e7          	jalr	-1148(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    800041ec:	00813083          	ld	ra,8(sp)
    800041f0:	00013403          	ld	s0,0(sp)
    800041f4:	01010113          	addi	sp,sp,16
    800041f8:	00008067          	ret
        ((SCB*)ihandle)->signal();
    800041fc:	fffff097          	auipc	ra,0xfffff
    80004200:	b04080e7          	jalr	-1276(ra) # 80002d00 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80004204:	00000793          	li	a5,0
    80004208:	fd9ff06f          	j	800041e0 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

000000008000420c <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    8000420c:	fe010113          	addi	sp,sp,-32
    80004210:	00113c23          	sd	ra,24(sp)
    80004214:	00813823          	sd	s0,16(sp)
    80004218:	00913423          	sd	s1,8(sp)
    8000421c:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80004220:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80004224:	00008797          	auipc	a5,0x8
    80004228:	bc47b783          	ld	a5,-1084(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000422c:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80004230:	00008797          	auipc	a5,0x8
    80004234:	df87b783          	ld	a5,-520(a5) # 8000c028 <_ZN5RiscV10globalTimeE>
    80004238:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    8000423c:	00e787b3          	add	a5,a5,a4
    80004240:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80004244:	00048513          	mv	a0,s1
    80004248:	00001097          	auipc	ra,0x1
    8000424c:	89c080e7          	jalr	-1892(ra) # 80004ae4 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80004250:	00300793          	li	a5,3
    80004254:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80004258:	fffff097          	auipc	ra,0xfffff
    8000425c:	ce4080e7          	jalr	-796(ra) # 80002f3c <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004260:	00000793          	li	a5,0
    80004264:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80004268:	00000097          	auipc	ra,0x0
    8000426c:	b00080e7          	jalr	-1280(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004270:	01813083          	ld	ra,24(sp)
    80004274:	01013403          	ld	s0,16(sp)
    80004278:	00813483          	ld	s1,8(sp)
    8000427c:	02010113          	addi	sp,sp,32
    80004280:	00008067          	ret

0000000080004284 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80004284:	fe010113          	addi	sp,sp,-32
    80004288:	00113c23          	sd	ra,24(sp)
    8000428c:	00813823          	sd	s0,16(sp)
    80004290:	00913423          	sd	s1,8(sp)
    80004294:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80004298:	00008797          	auipc	a5,0x8
    8000429c:	d887c783          	lbu	a5,-632(a5) # 8000c020 <_ZN5RiscV16userMainFinishedE>
    800042a0:	00079c63          	bnez	a5,800042b8 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800042a4:	00008717          	auipc	a4,0x8
    800042a8:	af473703          	ld	a4,-1292(a4) # 8000bd98 <_GLOBAL_OFFSET_TABLE_+0x38>
    800042ac:	00073783          	ld	a5,0(a4)
    800042b0:	00178793          	addi	a5,a5,1
    800042b4:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800042b8:	00001097          	auipc	ra,0x1
    800042bc:	afc080e7          	jalr	-1284(ra) # 80004db4 <_ZN11ConsoleUtil8getInputEv>
    800042c0:	00050493          	mv	s1,a0
    if(c==13) {
    800042c4:	00d00793          	li	a5,13
    800042c8:	02f50663          	beq	a0,a5,800042f4 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800042cc:	01b00793          	li	a5,27
    800042d0:	04f51063          	bne	a0,a5,80004310 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800042d4:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800042d8:	00000097          	auipc	ra,0x0
    800042dc:	a90080e7          	jalr	-1392(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    800042e0:	01813083          	ld	ra,24(sp)
    800042e4:	01013403          	ld	s0,16(sp)
    800042e8:	00813483          	ld	s1,8(sp)
    800042ec:	02010113          	addi	sp,sp,32
    800042f0:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800042f4:	00d00513          	li	a0,13
    800042f8:	00001097          	auipc	ra,0x1
    800042fc:	b2c080e7          	jalr	-1236(ra) # 80004e24 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80004300:	00a00513          	li	a0,10
    80004304:	00001097          	auipc	ra,0x1
    80004308:	b20080e7          	jalr	-1248(ra) # 80004e24 <_ZN11ConsoleUtil9putOutputEc>
    8000430c:	fc9ff06f          	j	800042d4 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80004310:	00001097          	auipc	ra,0x1
    80004314:	b14080e7          	jalr	-1260(ra) # 80004e24 <_ZN11ConsoleUtil9putOutputEc>
    80004318:	fbdff06f          	j	800042d4 <_ZN5RiscV18executeGetcSyscallEv+0x50>

000000008000431c <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    8000431c:	ff010113          	addi	sp,sp,-16
    80004320:	00113423          	sd	ra,8(sp)
    80004324:	00813023          	sd	s0,0(sp)
    80004328:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    8000432c:	00001097          	auipc	ra,0x1
    80004330:	b90080e7          	jalr	-1136(ra) # 80004ebc <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80004334:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004338:	00000097          	auipc	ra,0x0
    8000433c:	a30080e7          	jalr	-1488(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    80004340:	00813083          	ld	ra,8(sp)
    80004344:	00013403          	ld	s0,0(sp)
    80004348:	01010113          	addi	sp,sp,16
    8000434c:	00008067          	ret

0000000080004350 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80004350:	fe010113          	addi	sp,sp,-32
    80004354:	00113c23          	sd	ra,24(sp)
    80004358:	00813823          	sd	s0,16(sp)
    8000435c:	00913423          	sd	s1,8(sp)
    80004360:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004364:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80004368:	02049463          	bnez	s1,80004390 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000436c:	fff00793          	li	a5,-1
    80004370:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004374:	00000097          	auipc	ra,0x0
    80004378:	9f4080e7          	jalr	-1548(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000437c:	01813083          	ld	ra,24(sp)
    80004380:	01013403          	ld	s0,16(sp)
    80004384:	00813483          	ld	s1,8(sp)
    80004388:	02010113          	addi	sp,sp,32
    8000438c:	00008067          	ret
        kfree(thr->stack);
    80004390:	0284b503          	ld	a0,40(s1)
    80004394:	00001097          	auipc	ra,0x1
    80004398:	e88080e7          	jalr	-376(ra) # 8000521c <_Z5kfreePKv>
        delete thr;
    8000439c:	00048513          	mv	a0,s1
    800043a0:	fffff097          	auipc	ra,0xfffff
    800043a4:	b74080e7          	jalr	-1164(ra) # 80002f14 <_ZN3TCBD1Ev>
    800043a8:	00048513          	mv	a0,s1
    800043ac:	fffff097          	auipc	ra,0xfffff
    800043b0:	d34080e7          	jalr	-716(ra) # 800030e0 <_ZN3TCBdlEPv>
    800043b4:	fb9ff06f          	j	8000436c <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

00000000800043b8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800043b8:	fe010113          	addi	sp,sp,-32
    800043bc:	00113c23          	sd	ra,24(sp)
    800043c0:	00813823          	sd	s0,16(sp)
    800043c4:	00913423          	sd	s1,8(sp)
    800043c8:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800043cc:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    800043d0:	02049463          	bnez	s1,800043f8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800043d4:	fff00793          	li	a5,-1
    800043d8:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800043dc:	00000097          	auipc	ra,0x0
    800043e0:	98c080e7          	jalr	-1652(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>
}
    800043e4:	01813083          	ld	ra,24(sp)
    800043e8:	01013403          	ld	s0,16(sp)
    800043ec:	00813483          	ld	s1,8(sp)
    800043f0:	02010113          	addi	sp,sp,32
    800043f4:	00008067          	ret
        delete scb;
    800043f8:	00048513          	mv	a0,s1
    800043fc:	ffffe097          	auipc	ra,0xffffe
    80004400:	7a8080e7          	jalr	1960(ra) # 80002ba4 <_ZN3SCBD1Ev>
    80004404:	00048513          	mv	a0,s1
    80004408:	fffff097          	auipc	ra,0xfffff
    8000440c:	964080e7          	jalr	-1692(ra) # 80002d6c <_ZN3SCBdlEPv>
    80004410:	fc5ff06f          	j	800043d4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080004414 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80004414:	fe010113          	addi	sp,sp,-32
    80004418:	00113c23          	sd	ra,24(sp)
    8000441c:	00813823          	sd	s0,16(sp)
    80004420:	00913423          	sd	s1,8(sp)
    80004424:	01213023          	sd	s2,0(sp)
    80004428:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    8000442c:	00001537          	lui	a0,0x1
    80004430:	00001097          	auipc	ra,0x1
    80004434:	dc4080e7          	jalr	-572(ra) # 800051f4 <_Z7kmallocm>
    80004438:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    8000443c:	00008797          	auipc	a5,0x8
    80004440:	9ac7b783          	ld	a5,-1620(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004444:	0007b783          	ld	a5,0(a5)
    80004448:	00001637          	lui	a2,0x1
    8000444c:	00050593          	mv	a1,a0
    80004450:	0287b503          	ld	a0,40(a5)
    80004454:	fffff097          	auipc	ra,0xfffff
    80004458:	148080e7          	jalr	328(ra) # 8000359c <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000445c:	07000513          	li	a0,112
    80004460:	fffff097          	auipc	ra,0xfffff
    80004464:	b5c080e7          	jalr	-1188(ra) # 80002fbc <_ZN3TCBnwEm>
    80004468:	00050493          	mv	s1,a0
    8000446c:	00200713          	li	a4,2
    80004470:	00090693          	mv	a3,s2
    80004474:	00000613          	li	a2,0
    80004478:	00000593          	li	a1,0
    8000447c:	fffff097          	auipc	ra,0xfffff
    80004480:	a04080e7          	jalr	-1532(ra) # 80002e80 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80004484:	0a048e63          	beqz	s1,80004540 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80004488:	00008797          	auipc	a5,0x8
    8000448c:	9287b783          	ld	a5,-1752(a5) # 8000bdb0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004490:	0007b783          	ld	a5,0(a5)
    80004494:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80004498:	00008797          	auipc	a5,0x8
    8000449c:	9087b783          	ld	a5,-1784(a5) # 8000bda0 <_GLOBAL_OFFSET_TABLE_+0x40>
    800044a0:	0007b783          	ld	a5,0(a5)
    800044a4:	00f907b3          	add	a5,s2,a5
    800044a8:	00008717          	auipc	a4,0x8
    800044ac:	94073703          	ld	a4,-1728(a4) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800044b0:	00073683          	ld	a3,0(a4)
    800044b4:	0286b683          	ld	a3,40(a3)
    800044b8:	40d787b3          	sub	a5,a5,a3
    800044bc:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800044c0:	00073783          	ld	a5,0(a4)
    800044c4:	0687b503          	ld	a0,104(a5)
    800044c8:	0287b783          	ld	a5,40(a5)
    800044cc:	40f50533          	sub	a0,a0,a5
    800044d0:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    800044d4:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800044d8:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800044dc:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800044e0:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800044e4:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800044e8:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800044ec:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800044f0:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800044f4:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800044f8:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    800044fc:	00073783          	ld	a5,0(a4)
    80004500:	0387b703          	ld	a4,56(a5)
    80004504:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004508:	0407b783          	ld	a5,64(a5)
    8000450c:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004510:	00048513          	mv	a0,s1
    80004514:	00000097          	auipc	ra,0x0
    80004518:	554080e7          	jalr	1364(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    8000451c:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80004520:	00000097          	auipc	ra,0x0
    80004524:	848080e7          	jalr	-1976(ra) # 80003d68 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004528:	01813083          	ld	ra,24(sp)
    8000452c:	01013403          	ld	s0,16(sp)
    80004530:	00813483          	ld	s1,8(sp)
    80004534:	00013903          	ld	s2,0(sp)
    80004538:	02010113          	addi	sp,sp,32
    8000453c:	00008067          	ret
        status = -1;
    80004540:	fff00493          	li	s1,-1
    80004544:	fd9ff06f          	j	8000451c <_ZN5RiscV18executeForkSyscallEv+0x108>
    80004548:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    8000454c:	00048513          	mv	a0,s1
    80004550:	fffff097          	auipc	ra,0xfffff
    80004554:	b90080e7          	jalr	-1136(ra) # 800030e0 <_ZN3TCBdlEPv>
    80004558:	00090513          	mv	a0,s2
    8000455c:	00009097          	auipc	ra,0x9
    80004560:	c2c080e7          	jalr	-980(ra) # 8000d188 <_Unwind_Resume>

0000000080004564 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80004564:	ff010113          	addi	sp,sp,-16
    80004568:	00813423          	sd	s0,8(sp)
    8000456c:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80004570:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80004574:	00878793          	addi	a5,a5,8
    80004578:	00008717          	auipc	a4,0x8
    8000457c:	83873703          	ld	a4,-1992(a4) # 8000bdb0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004580:	00f73023          	sd	a5,0(a4)
}
    80004584:	00813403          	ld	s0,8(sp)
    80004588:	01010113          	addi	sp,sp,16
    8000458c:	00008067          	ret

0000000080004590 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004590:	fa010113          	addi	sp,sp,-96
    80004594:	04113c23          	sd	ra,88(sp)
    80004598:	04813823          	sd	s0,80(sp)
    8000459c:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800045a0:	142027f3          	csrr	a5,scause
    800045a4:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    800045a8:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    800045ac:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800045b0:	00008797          	auipc	a5,0x8
    800045b4:	8387b783          	ld	a5,-1992(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800045b8:	0007b783          	ld	a5,0(a5)
    800045bc:	14002773          	csrr	a4,sscratch
    800045c0:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800045c4:	fe843703          	ld	a4,-24(s0)
    800045c8:	00900793          	li	a5,9
    800045cc:	0ef70663          	beq	a4,a5,800046b8 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    800045d0:	fe843703          	ld	a4,-24(s0)
    800045d4:	00800793          	li	a5,8
    800045d8:	0ef70063          	beq	a4,a5,800046b8 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    800045dc:	fe843703          	ld	a4,-24(s0)
    800045e0:	fff00793          	li	a5,-1
    800045e4:	03f79793          	slli	a5,a5,0x3f
    800045e8:	00178793          	addi	a5,a5,1
    800045ec:	24f70263          	beq	a4,a5,80004830 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    800045f0:	fe843703          	ld	a4,-24(s0)
    800045f4:	fff00793          	li	a5,-1
    800045f8:	03f79793          	slli	a5,a5,0x3f
    800045fc:	00978793          	addi	a5,a5,9
    80004600:	2cf70063          	beq	a4,a5,800048c0 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80004604:	fe843703          	ld	a4,-24(s0)
    80004608:	00200793          	li	a5,2
    8000460c:	34f70863          	beq	a4,a5,8000495c <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004610:	00005517          	auipc	a0,0x5
    80004614:	d9850513          	addi	a0,a0,-616 # 800093a8 <CONSOLE_STATUS+0x398>
    80004618:	00001097          	auipc	ra,0x1
    8000461c:	914080e7          	jalr	-1772(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004620:	00005517          	auipc	a0,0x5
    80004624:	d9850513          	addi	a0,a0,-616 # 800093b8 <CONSOLE_STATUS+0x3a8>
    80004628:	00001097          	auipc	ra,0x1
    8000462c:	904080e7          	jalr	-1788(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004630:	142027f3          	csrr	a5,scause
    80004634:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004638:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    8000463c:	00000613          	li	a2,0
    80004640:	00a00593          	li	a1,10
    80004644:	0005051b          	sext.w	a0,a0
    80004648:	00001097          	auipc	ra,0x1
    8000464c:	928080e7          	jalr	-1752(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80004650:	00005517          	auipc	a0,0x5
    80004654:	d2850513          	addi	a0,a0,-728 # 80009378 <CONSOLE_STATUS+0x368>
    80004658:	00001097          	auipc	ra,0x1
    8000465c:	8d4080e7          	jalr	-1836(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004660:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004664:	00000613          	li	a2,0
    80004668:	01000593          	li	a1,16
    8000466c:	0005051b          	sext.w	a0,a0
    80004670:	00001097          	auipc	ra,0x1
    80004674:	900080e7          	jalr	-1792(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004678:	00005517          	auipc	a0,0x5
    8000467c:	cf850513          	addi	a0,a0,-776 # 80009370 <CONSOLE_STATUS+0x360>
    80004680:	00001097          	auipc	ra,0x1
    80004684:	8ac080e7          	jalr	-1876(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80004688:	00007797          	auipc	a5,0x7
    8000468c:	7607b783          	ld	a5,1888(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004690:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004694:	00200713          	li	a4,2
    80004698:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    8000469c:	00005517          	auipc	a0,0x5
    800046a0:	d2c50513          	addi	a0,a0,-724 # 800093c8 <CONSOLE_STATUS+0x3b8>
    800046a4:	00001097          	auipc	ra,0x1
    800046a8:	888080e7          	jalr	-1912(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800046ac:	fffff097          	auipc	ra,0xfffff
    800046b0:	890080e7          	jalr	-1904(ra) # 80002f3c <_ZN3TCB8dispatchEv>
    800046b4:	0800006f          	j	80004734 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800046b8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800046bc:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800046c0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800046c4:	00478793          	addi	a5,a5,4
    800046c8:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    800046cc:	00007797          	auipc	a5,0x7
    800046d0:	71c7b783          	ld	a5,1820(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800046d4:	0007b783          	ld	a5,0(a5)
    800046d8:	fb043703          	ld	a4,-80(s0)
    800046dc:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800046e0:	fa843703          	ld	a4,-88(s0)
    800046e4:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800046e8:	00050793          	mv	a5,a0
        switch(syscallID){
    800046ec:	06100713          	li	a4,97
    800046f0:	02f76463          	bltu	a4,a5,80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    800046f4:	00279793          	slli	a5,a5,0x2
    800046f8:	00005717          	auipc	a4,0x5
    800046fc:	ce470713          	addi	a4,a4,-796 # 800093dc <CONSOLE_STATUS+0x3cc>
    80004700:	00e787b3          	add	a5,a5,a4
    80004704:	0007a783          	lw	a5,0(a5)
    80004708:	00e787b3          	add	a5,a5,a4
    8000470c:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004710:	fffff097          	auipc	ra,0xfffff
    80004714:	690080e7          	jalr	1680(ra) # 80003da0 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004718:	00007797          	auipc	a5,0x7
    8000471c:	6d07b783          	ld	a5,1744(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004720:	0007b783          	ld	a5,0(a5)
    80004724:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004728:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    8000472c:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004730:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004734:	fffff097          	auipc	ra,0xfffff
    80004738:	53c080e7          	jalr	1340(ra) # 80003c70 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    8000473c:	05813083          	ld	ra,88(sp)
    80004740:	05013403          	ld	s0,80(sp)
    80004744:	06010113          	addi	sp,sp,96
    80004748:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    8000474c:	fffff097          	auipc	ra,0xfffff
    80004750:	68c080e7          	jalr	1676(ra) # 80003dd8 <_ZN5RiscV21executeMemFreeSyscallEv>
    80004754:	fc5ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80004758:	fffff097          	auipc	ra,0xfffff
    8000475c:	6d0080e7          	jalr	1744(ra) # 80003e28 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004760:	fb9ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80004764:	00000097          	auipc	ra,0x0
    80004768:	8b0080e7          	jalr	-1872(ra) # 80004014 <_ZN5RiscV24executeThreadExitSyscallEv>
    8000476c:	fadff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004770:	fffff097          	auipc	ra,0xfffff
    80004774:	3ec080e7          	jalr	1004(ra) # 80003b5c <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004778:	fa1ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    8000477c:	fffff097          	auipc	ra,0xfffff
    80004780:	77c080e7          	jalr	1916(ra) # 80003ef8 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004784:	f95ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004788:	00000097          	auipc	ra,0x0
    8000478c:	834080e7          	jalr	-1996(ra) # 80003fbc <_ZN5RiscV25executeThreadStartSyscallEv>
    80004790:	f89ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80004794:	00000097          	auipc	ra,0x0
    80004798:	8d8080e7          	jalr	-1832(ra) # 8000406c <_ZN5RiscV21executeSemOpenSyscallEv>
    8000479c:	f7dff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    800047a0:	00000097          	auipc	ra,0x0
    800047a4:	964080e7          	jalr	-1692(ra) # 80004104 <_ZN5RiscV22executeSemCloseSyscallEv>
    800047a8:	f71ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    800047ac:	00000097          	auipc	ra,0x0
    800047b0:	9b8080e7          	jalr	-1608(ra) # 80004164 <_ZN5RiscV21executeSemWaitSyscallEv>
    800047b4:	f65ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    800047b8:	00000097          	auipc	ra,0x0
    800047bc:	a0c080e7          	jalr	-1524(ra) # 800041c4 <_ZN5RiscV23executeSemSignalSyscallEv>
    800047c0:	f59ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    800047c4:	00000097          	auipc	ra,0x0
    800047c8:	a48080e7          	jalr	-1464(ra) # 8000420c <_ZN5RiscV23executeTimeSleepSyscallEv>
    800047cc:	f4dff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    800047d0:	00000097          	auipc	ra,0x0
    800047d4:	ab4080e7          	jalr	-1356(ra) # 80004284 <_ZN5RiscV18executeGetcSyscallEv>
    800047d8:	f41ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    800047dc:	fffff097          	auipc	ra,0xfffff
    800047e0:	3bc080e7          	jalr	956(ra) # 80003b98 <_ZN5RiscV18executePutcSyscallEv>
    800047e4:	f35ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    800047e8:	00000097          	auipc	ra,0x0
    800047ec:	b34080e7          	jalr	-1228(ra) # 8000431c <_ZN5RiscV22executePutcUtilSyscallEv>
    800047f0:	f29ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    800047f4:	00000097          	auipc	ra,0x0
    800047f8:	b5c080e7          	jalr	-1188(ra) # 80004350 <_ZN5RiscV24executeThreadFreeSyscallEv>
    800047fc:	f1dff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004800:	00000097          	auipc	ra,0x0
    80004804:	bb8080e7          	jalr	-1096(ra) # 800043b8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004808:	f11ff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    8000480c:	00010793          	mv	a5,sp
    80004810:	00007717          	auipc	a4,0x7
    80004814:	59073703          	ld	a4,1424(a4) # 8000bda0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004818:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    8000481c:	00000097          	auipc	ra,0x0
    80004820:	d48080e7          	jalr	-696(ra) # 80004564 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004824:	00000097          	auipc	ra,0x0
    80004828:	bf0080e7          	jalr	-1040(ra) # 80004414 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    8000482c:	eedff06f          	j	80004718 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004830:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004834:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004838:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    8000483c:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004840:	00200793          	li	a5,2
    80004844:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80004848:	00007717          	auipc	a4,0x7
    8000484c:	7d870713          	addi	a4,a4,2008 # 8000c020 <_ZN5RiscV16userMainFinishedE>
    80004850:	00873783          	ld	a5,8(a4)
    80004854:	00178793          	addi	a5,a5,1
    80004858:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    8000485c:	00000097          	auipc	ra,0x0
    80004860:	2e0080e7          	jalr	736(ra) # 80004b3c <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004864:	00007717          	auipc	a4,0x7
    80004868:	51c73703          	ld	a4,1308(a4) # 8000bd80 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000486c:	00073783          	ld	a5,0(a4)
    80004870:	00178793          	addi	a5,a5,1
    80004874:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004878:	00007717          	auipc	a4,0x7
    8000487c:	57073703          	ld	a4,1392(a4) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004880:	00073703          	ld	a4,0(a4)
    80004884:	03073683          	ld	a3,48(a4)
    80004888:	00d7fc63          	bgeu	a5,a3,800048a0 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    8000488c:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004890:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004894:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004898:	14179073          	csrw	sepc,a5
}
    8000489c:	e99ff06f          	j	80004734 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    800048a0:	00007797          	auipc	a5,0x7
    800048a4:	4e07b783          	ld	a5,1248(a5) # 8000bd80 <_GLOBAL_OFFSET_TABLE_+0x20>
    800048a8:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    800048ac:	00100793          	li	a5,1
    800048b0:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    800048b4:	ffffe097          	auipc	ra,0xffffe
    800048b8:	688080e7          	jalr	1672(ra) # 80002f3c <_ZN3TCB8dispatchEv>
    800048bc:	fd1ff06f          	j	8000488c <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800048c0:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800048c4:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800048c8:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800048cc:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    800048d0:	00007797          	auipc	a5,0x7
    800048d4:	4a07b783          	ld	a5,1184(a5) # 8000bd70 <_GLOBAL_OFFSET_TABLE_+0x10>
    800048d8:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800048dc:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800048e0:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800048e4:	00058793          	mv	a5,a1
        if(status & 1UL)
    800048e8:	0017f793          	andi	a5,a5,1
    800048ec:	02078863          	beqz	a5,8000491c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    800048f0:	00007797          	auipc	a5,0x7
    800048f4:	4a07b783          	ld	a5,1184(a5) # 8000bd90 <_GLOBAL_OFFSET_TABLE_+0x30>
    800048f8:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    800048fc:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004900:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004904:	00058513          	mv	a0,a1
    80004908:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    8000490c:	00007797          	auipc	a5,0x7
    80004910:	48c7b783          	ld	a5,1164(a5) # 8000bd98 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004914:	0007b783          	ld	a5,0(a5)
    80004918:	02079463          	bnez	a5,80004940 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    8000491c:	00002097          	auipc	ra,0x2
    80004920:	788080e7          	jalr	1928(ra) # 800070a4 <plic_claim>
    80004924:	00002097          	auipc	ra,0x2
    80004928:	7b8080e7          	jalr	1976(ra) # 800070dc <plic_complete>
        RiscV::w_sstatus(sstatus);
    8000492c:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004930:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004934:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004938:	14179073          	csrw	sepc,a5
}
    8000493c:	df9ff06f          	j	80004734 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004940:	fff78793          	addi	a5,a5,-1
    80004944:	00007717          	auipc	a4,0x7
    80004948:	45473703          	ld	a4,1108(a4) # 8000bd98 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000494c:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004950:	00000097          	auipc	ra,0x0
    80004954:	3e8080e7          	jalr	1000(ra) # 80004d38 <_ZN11ConsoleUtil8putInputEc>
    80004958:	fc5ff06f          	j	8000491c <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    8000495c:	00007797          	auipc	a5,0x7
    80004960:	48c7b783          	ld	a5,1164(a5) # 8000bde8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004964:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004968:	00200713          	li	a4,2
    8000496c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004970:	00005517          	auipc	a0,0x5
    80004974:	a0850513          	addi	a0,a0,-1528 # 80009378 <CONSOLE_STATUS+0x368>
    80004978:	00000097          	auipc	ra,0x0
    8000497c:	5b4080e7          	jalr	1460(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004980:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004984:	00000613          	li	a2,0
    80004988:	01000593          	li	a1,16
    8000498c:	0005051b          	sext.w	a0,a0
    80004990:	00000097          	auipc	ra,0x0
    80004994:	5e0080e7          	jalr	1504(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004998:	00005517          	auipc	a0,0x5
    8000499c:	9d850513          	addi	a0,a0,-1576 # 80009370 <CONSOLE_STATUS+0x360>
    800049a0:	00000097          	auipc	ra,0x0
    800049a4:	58c080e7          	jalr	1420(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    800049a8:	00005517          	auipc	a0,0x5
    800049ac:	9d850513          	addi	a0,a0,-1576 # 80009380 <CONSOLE_STATUS+0x370>
    800049b0:	00000097          	auipc	ra,0x0
    800049b4:	57c080e7          	jalr	1404(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800049b8:	ffffe097          	auipc	ra,0xffffe
    800049bc:	584080e7          	jalr	1412(ra) # 80002f3c <_ZN3TCB8dispatchEv>
    800049c0:	d75ff06f          	j	80004734 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

00000000800049c4 <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    800049c4:	ff010113          	addi	sp,sp,-16
    800049c8:	00813423          	sd	s0,8(sp)
    800049cc:	01010413          	addi	s0,sp,16
    800049d0:	00050793          	mv	a5,a0
    800049d4:	00058513          	mv	a0,a1
    while(*src != '\0')
    800049d8:	0007c703          	lbu	a4,0(a5)
    800049dc:	00070a63          	beqz	a4,800049f0 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    800049e0:	00178793          	addi	a5,a5,1
    800049e4:	00e50023          	sb	a4,0(a0)
    800049e8:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    800049ec:	fedff06f          	j	800049d8 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800049f0:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800049f4:	00813403          	ld	s0,8(sp)
    800049f8:	01010113          	addi	sp,sp,16
    800049fc:	00008067          	ret

0000000080004a00 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004a00:	fe010113          	addi	sp,sp,-32
    80004a04:	00113c23          	sd	ra,24(sp)
    80004a08:	00813823          	sd	s0,16(sp)
    80004a0c:	00913423          	sd	s1,8(sp)
    80004a10:	02010413          	addi	s0,sp,32
    80004a14:	00050493          	mv	s1,a0
    80004a18:	00058513          	mv	a0,a1
    char *dest = dst;
    80004a1c:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004a20:	0005c783          	lbu	a5,0(a1)
    80004a24:	00078663          	beqz	a5,80004a30 <_Z6strcatPcPKc+0x30>
        dest++;
    80004a28:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004a2c:	ff5ff06f          	j	80004a20 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004a30:	00000097          	auipc	ra,0x0
    80004a34:	f94080e7          	jalr	-108(ra) # 800049c4 <_Z6strcpyPKcPc>
    return dst;
}
    80004a38:	00048513          	mv	a0,s1
    80004a3c:	01813083          	ld	ra,24(sp)
    80004a40:	01013403          	ld	s0,16(sp)
    80004a44:	00813483          	ld	s1,8(sp)
    80004a48:	02010113          	addi	sp,sp,32
    80004a4c:	00008067          	ret

0000000080004a50 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004a50:	ff010113          	addi	sp,sp,-16
    80004a54:	00813423          	sd	s0,8(sp)
    80004a58:	01010413          	addi	s0,sp,16
}
    80004a5c:	00813403          	ld	s0,8(sp)
    80004a60:	01010113          	addi	sp,sp,16
    80004a64:	00008067          	ret

0000000080004a68 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004a68:	ff010113          	addi	sp,sp,-16
    80004a6c:	00813423          	sd	s0,8(sp)
    80004a70:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004a74:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004a78:	00007797          	auipc	a5,0x7
    80004a7c:	5b87b783          	ld	a5,1464(a5) # 8000c030 <_ZN9Scheduler9readyHeadE>
    80004a80:	02078263          	beqz	a5,80004aa4 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004a84:	00007797          	auipc	a5,0x7
    80004a88:	5b47b783          	ld	a5,1460(a5) # 8000c038 <_ZN9Scheduler9readyTailE>
    80004a8c:	04a7b423          	sd	a0,72(a5)
    80004a90:	00007797          	auipc	a5,0x7
    80004a94:	5aa7b423          	sd	a0,1448(a5) # 8000c038 <_ZN9Scheduler9readyTailE>
}
    80004a98:	00813403          	ld	s0,8(sp)
    80004a9c:	01010113          	addi	sp,sp,16
    80004aa0:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004aa4:	00007797          	auipc	a5,0x7
    80004aa8:	58a7b623          	sd	a0,1420(a5) # 8000c030 <_ZN9Scheduler9readyHeadE>
    80004aac:	fe5ff06f          	j	80004a90 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004ab0 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004ab0:	ff010113          	addi	sp,sp,-16
    80004ab4:	00813423          	sd	s0,8(sp)
    80004ab8:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004abc:	00007517          	auipc	a0,0x7
    80004ac0:	57453503          	ld	a0,1396(a0) # 8000c030 <_ZN9Scheduler9readyHeadE>
    80004ac4:	00050a63          	beqz	a0,80004ad8 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004ac8:	04853783          	ld	a5,72(a0)
    80004acc:	00007717          	auipc	a4,0x7
    80004ad0:	56f73223          	sd	a5,1380(a4) # 8000c030 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004ad4:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004ad8:	00813403          	ld	s0,8(sp)
    80004adc:	01010113          	addi	sp,sp,16
    80004ae0:	00008067          	ret

0000000080004ae4 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004ae4:	ff010113          	addi	sp,sp,-16
    80004ae8:	00813423          	sd	s0,8(sp)
    80004aec:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004af0:	00007797          	auipc	a5,0x7
    80004af4:	5507b783          	ld	a5,1360(a5) # 8000c040 <_ZN9Scheduler12sleepingHeadE>
    80004af8:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004afc:	00078e63          	beqz	a5,80004b18 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004b00:	0587b683          	ld	a3,88(a5)
    80004b04:	05853703          	ld	a4,88(a0)
    80004b08:	00d76863          	bltu	a4,a3,80004b18 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004b0c:	00078613          	mv	a2,a5
    80004b10:	0487b783          	ld	a5,72(a5)
    80004b14:	fe9ff06f          	j	80004afc <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004b18:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004b1c:	00060a63          	beqz	a2,80004b30 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004b20:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004b24:	00813403          	ld	s0,8(sp)
    80004b28:	01010113          	addi	sp,sp,16
    80004b2c:	00008067          	ret
        sleepingHead = t;
    80004b30:	00007797          	auipc	a5,0x7
    80004b34:	50a7b823          	sd	a0,1296(a5) # 8000c040 <_ZN9Scheduler12sleepingHeadE>
}
    80004b38:	fedff06f          	j	80004b24 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004b3c <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004b3c:	fe010113          	addi	sp,sp,-32
    80004b40:	00113c23          	sd	ra,24(sp)
    80004b44:	00813823          	sd	s0,16(sp)
    80004b48:	00913423          	sd	s1,8(sp)
    80004b4c:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004b50:	00007497          	auipc	s1,0x7
    80004b54:	4f04b483          	ld	s1,1264(s1) # 8000c040 <_ZN9Scheduler12sleepingHeadE>
    80004b58:	02048c63          	beqz	s1,80004b90 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004b5c:	0584b703          	ld	a4,88(s1)
    80004b60:	00007797          	auipc	a5,0x7
    80004b64:	2a07b783          	ld	a5,672(a5) # 8000be00 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80004b68:	0007b783          	ld	a5,0(a5)
    80004b6c:	02e7e263          	bltu	a5,a4,80004b90 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004b70:	0484b783          	ld	a5,72(s1)
    80004b74:	00007717          	auipc	a4,0x7
    80004b78:	4cf73623          	sd	a5,1228(a4) # 8000c040 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004b7c:	00048513          	mv	a0,s1
    80004b80:	00000097          	auipc	ra,0x0
    80004b84:	ee8080e7          	jalr	-280(ra) # 80004a68 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004b88:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004b8c:	fc5ff06f          	j	80004b50 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004b90:	01813083          	ld	ra,24(sp)
    80004b94:	01013403          	ld	s0,16(sp)
    80004b98:	00813483          	ld	s1,8(sp)
    80004b9c:	02010113          	addi	sp,sp,32
    80004ba0:	00008067          	ret

0000000080004ba4 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004ba4:	fe010113          	addi	sp,sp,-32
    80004ba8:	00113c23          	sd	ra,24(sp)
    80004bac:	00813823          	sd	s0,16(sp)
    80004bb0:	00913423          	sd	s1,8(sp)
    80004bb4:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004bb8:	00007497          	auipc	s1,0x7
    80004bbc:	4784b483          	ld	s1,1144(s1) # 8000c030 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004bc0:	02048863          	beqz	s1,80004bf0 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004bc4:	00000613          	li	a2,0
    80004bc8:	01000593          	li	a1,16
    80004bcc:	0004851b          	sext.w	a0,s1
    80004bd0:	00000097          	auipc	ra,0x0
    80004bd4:	3a0080e7          	jalr	928(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004bd8:	00004517          	auipc	a0,0x4
    80004bdc:	79850513          	addi	a0,a0,1944 # 80009370 <CONSOLE_STATUS+0x360>
    80004be0:	00000097          	auipc	ra,0x0
    80004be4:	34c080e7          	jalr	844(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004be8:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004bec:	fd5ff06f          	j	80004bc0 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004bf0:	01813083          	ld	ra,24(sp)
    80004bf4:	01013403          	ld	s0,16(sp)
    80004bf8:	00813483          	ld	s1,8(sp)
    80004bfc:	02010113          	addi	sp,sp,32
    80004c00:	00008067          	ret

0000000080004c04 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004c04:	fe010113          	addi	sp,sp,-32
    80004c08:	00113c23          	sd	ra,24(sp)
    80004c0c:	00813823          	sd	s0,16(sp)
    80004c10:	00913423          	sd	s1,8(sp)
    80004c14:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004c18:	00007497          	auipc	s1,0x7
    80004c1c:	4284b483          	ld	s1,1064(s1) # 8000c040 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004c20:	02048863          	beqz	s1,80004c50 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004c24:	00000613          	li	a2,0
    80004c28:	01000593          	li	a1,16
    80004c2c:	0004851b          	sext.w	a0,s1
    80004c30:	ffffe097          	auipc	ra,0xffffe
    80004c34:	dc0080e7          	jalr	-576(ra) # 800029f0 <_Z8printIntiii>
        printString("\n");
    80004c38:	00004517          	auipc	a0,0x4
    80004c3c:	73850513          	addi	a0,a0,1848 # 80009370 <CONSOLE_STATUS+0x360>
    80004c40:	ffffe097          	auipc	ra,0xffffe
    80004c44:	c18080e7          	jalr	-1000(ra) # 80002858 <_Z11printStringPKc>
        iter = iter->next;
    80004c48:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004c4c:	fd5ff06f          	j	80004c20 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004c50:	01813083          	ld	ra,24(sp)
    80004c54:	01013403          	ld	s0,16(sp)
    80004c58:	00813483          	ld	s1,8(sp)
    80004c5c:	02010113          	addi	sp,sp,32
    80004c60:	00008067          	ret

0000000080004c64 <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;

void ConsoleUtil::initialize() {
    80004c64:	fe010113          	addi	sp,sp,-32
    80004c68:	00113c23          	sd	ra,24(sp)
    80004c6c:	00813823          	sd	s0,16(sp)
    80004c70:	00913423          	sd	s1,8(sp)
    80004c74:	01213023          	sd	s2,0(sp)
    80004c78:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004c7c:	01800513          	li	a0,24
    80004c80:	ffffe097          	auipc	ra,0xffffe
    80004c84:	0bc080e7          	jalr	188(ra) # 80002d3c <_ZN3SCBnwEm>
    80004c88:	00050493          	mv	s1,a0
    80004c8c:	00000593          	li	a1,0
    80004c90:	ffffe097          	auipc	ra,0xffffe
    80004c94:	ef8080e7          	jalr	-264(ra) # 80002b88 <_ZN3SCBC1Em>
    80004c98:	00007797          	auipc	a5,0x7
    80004c9c:	3a97b823          	sd	s1,944(a5) # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004ca0:	01800513          	li	a0,24
    80004ca4:	ffffe097          	auipc	ra,0xffffe
    80004ca8:	098080e7          	jalr	152(ra) # 80002d3c <_ZN3SCBnwEm>
    80004cac:	00050493          	mv	s1,a0
    80004cb0:	00000593          	li	a1,0
    80004cb4:	ffffe097          	auipc	ra,0xffffe
    80004cb8:	ed4080e7          	jalr	-300(ra) # 80002b88 <_ZN3SCBC1Em>
    80004cbc:	00007917          	auipc	s2,0x7
    80004cc0:	38c90913          	addi	s2,s2,908 # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    80004cc4:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004cc8:	00002537          	lui	a0,0x2
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	528080e7          	jalr	1320(ra) # 800051f4 <_Z7kmallocm>
    80004cd4:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004cd8:	00002537          	lui	a0,0x2
    80004cdc:	00000097          	auipc	ra,0x0
    80004ce0:	518080e7          	jalr	1304(ra) # 800051f4 <_Z7kmallocm>
    80004ce4:	00a93c23          	sd	a0,24(s2)
}
    80004ce8:	01813083          	ld	ra,24(sp)
    80004cec:	01013403          	ld	s0,16(sp)
    80004cf0:	00813483          	ld	s1,8(sp)
    80004cf4:	00013903          	ld	s2,0(sp)
    80004cf8:	02010113          	addi	sp,sp,32
    80004cfc:	00008067          	ret
    80004d00:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004d04:	00048513          	mv	a0,s1
    80004d08:	ffffe097          	auipc	ra,0xffffe
    80004d0c:	064080e7          	jalr	100(ra) # 80002d6c <_ZN3SCBdlEPv>
    80004d10:	00090513          	mv	a0,s2
    80004d14:	00008097          	auipc	ra,0x8
    80004d18:	474080e7          	jalr	1140(ra) # 8000d188 <_Unwind_Resume>
    80004d1c:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004d20:	00048513          	mv	a0,s1
    80004d24:	ffffe097          	auipc	ra,0xffffe
    80004d28:	048080e7          	jalr	72(ra) # 80002d6c <_ZN3SCBdlEPv>
    80004d2c:	00090513          	mv	a0,s2
    80004d30:	00008097          	auipc	ra,0x8
    80004d34:	458080e7          	jalr	1112(ra) # 8000d188 <_Unwind_Resume>

0000000080004d38 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004d38:	00007697          	auipc	a3,0x7
    80004d3c:	31068693          	addi	a3,a3,784 # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    80004d40:	0206b603          	ld	a2,32(a3)
    80004d44:	00160793          	addi	a5,a2,1
    80004d48:	00002737          	lui	a4,0x2
    80004d4c:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004d50:	00e7f7b3          	and	a5,a5,a4
    80004d54:	0286b703          	ld	a4,40(a3)
    80004d58:	04e78c63          	beq	a5,a4,80004db0 <_ZN11ConsoleUtil8putInputEc+0x78>
void ConsoleUtil::putInput(char c) {
    80004d5c:	ff010113          	addi	sp,sp,-16
    80004d60:	00113423          	sd	ra,8(sp)
    80004d64:	00813023          	sd	s0,0(sp)
    80004d68:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004d6c:	00068713          	mv	a4,a3
    80004d70:	0106b783          	ld	a5,16(a3)
    80004d74:	00c78633          	add	a2,a5,a2
    80004d78:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80004d7c:	0206b783          	ld	a5,32(a3)
    80004d80:	00178793          	addi	a5,a5,1
    80004d84:	000026b7          	lui	a3,0x2
    80004d88:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004d8c:	00d7f7b3          	and	a5,a5,a3
    80004d90:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    80004d94:	00073503          	ld	a0,0(a4)
    80004d98:	ffffe097          	auipc	ra,0xffffe
    80004d9c:	f68080e7          	jalr	-152(ra) # 80002d00 <_ZN3SCB6signalEv>
}
    80004da0:	00813083          	ld	ra,8(sp)
    80004da4:	00013403          	ld	s0,0(sp)
    80004da8:	01010113          	addi	sp,sp,16
    80004dac:	00008067          	ret
    80004db0:	00008067          	ret

0000000080004db4 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004db4:	fe010113          	addi	sp,sp,-32
    80004db8:	00113c23          	sd	ra,24(sp)
    80004dbc:	00813823          	sd	s0,16(sp)
    80004dc0:	00913423          	sd	s1,8(sp)
    80004dc4:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004dc8:	00007497          	auipc	s1,0x7
    80004dcc:	28048493          	addi	s1,s1,640 # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    80004dd0:	0004b503          	ld	a0,0(s1)
    80004dd4:	ffffe097          	auipc	ra,0xffffe
    80004dd8:	edc080e7          	jalr	-292(ra) # 80002cb0 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004ddc:	0284b783          	ld	a5,40(s1)
    80004de0:	0204b703          	ld	a4,32(s1)
    80004de4:	02e78c63          	beq	a5,a4,80004e1c <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80004de8:	0104b703          	ld	a4,16(s1)
    80004dec:	00f70733          	add	a4,a4,a5
    80004df0:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004df4:	00178793          	addi	a5,a5,1
    80004df8:	00002737          	lui	a4,0x2
    80004dfc:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004e00:	00e7f7b3          	and	a5,a5,a4
    80004e04:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80004e08:	01813083          	ld	ra,24(sp)
    80004e0c:	01013403          	ld	s0,16(sp)
    80004e10:	00813483          	ld	s1,8(sp)
    80004e14:	02010113          	addi	sp,sp,32
    80004e18:	00008067          	ret
        return -1;
    80004e1c:	0ff00513          	li	a0,255
    80004e20:	fe9ff06f          	j	80004e08 <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080004e24 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004e24:	00007797          	auipc	a5,0x7
    80004e28:	22478793          	addi	a5,a5,548 # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    80004e2c:	0307b703          	ld	a4,48(a5)
    80004e30:	00170713          	addi	a4,a4,1
    80004e34:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004e38:	0387b603          	ld	a2,56(a5)
    80004e3c:	00160713          	addi	a4,a2,1
    80004e40:	000026b7          	lui	a3,0x2
    80004e44:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004e48:	00d77733          	and	a4,a4,a3
    80004e4c:	0407b783          	ld	a5,64(a5)
    80004e50:	06f70463          	beq	a4,a5,80004eb8 <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    80004e54:	ff010113          	addi	sp,sp,-16
    80004e58:	00113423          	sd	ra,8(sp)
    80004e5c:	00813023          	sd	s0,0(sp)
    80004e60:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004e64:	00007797          	auipc	a5,0x7
    80004e68:	1e478793          	addi	a5,a5,484 # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    80004e6c:	0187b703          	ld	a4,24(a5)
    80004e70:	00c70633          	add	a2,a4,a2
    80004e74:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    80004e78:	0387b703          	ld	a4,56(a5)
    80004e7c:	00170713          	addi	a4,a4,1
    80004e80:	000026b7          	lui	a3,0x2
    80004e84:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004e88:	00d77733          	and	a4,a4,a3
    80004e8c:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    80004e90:	0307b703          	ld	a4,48(a5)
    80004e94:	fff70713          	addi	a4,a4,-1
    80004e98:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    80004e9c:	0087b503          	ld	a0,8(a5)
    80004ea0:	ffffe097          	auipc	ra,0xffffe
    80004ea4:	e60080e7          	jalr	-416(ra) # 80002d00 <_ZN3SCB6signalEv>
}
    80004ea8:	00813083          	ld	ra,8(sp)
    80004eac:	00013403          	ld	s0,0(sp)
    80004eb0:	01010113          	addi	sp,sp,16
    80004eb4:	00008067          	ret
    80004eb8:	00008067          	ret

0000000080004ebc <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004ebc:	fe010113          	addi	sp,sp,-32
    80004ec0:	00113c23          	sd	ra,24(sp)
    80004ec4:	00813823          	sd	s0,16(sp)
    80004ec8:	00913423          	sd	s1,8(sp)
    80004ecc:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004ed0:	00007497          	auipc	s1,0x7
    80004ed4:	17848493          	addi	s1,s1,376 # 8000c048 <_ZN11ConsoleUtil8inputSemE>
    80004ed8:	0084b503          	ld	a0,8(s1)
    80004edc:	ffffe097          	auipc	ra,0xffffe
    80004ee0:	dd4080e7          	jalr	-556(ra) # 80002cb0 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004ee4:	0404b783          	ld	a5,64(s1)
    80004ee8:	0384b703          	ld	a4,56(s1)
    80004eec:	02e78c63          	beq	a5,a4,80004f24 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80004ef0:	0184b703          	ld	a4,24(s1)
    80004ef4:	00f70733          	add	a4,a4,a5
    80004ef8:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004efc:	00178793          	addi	a5,a5,1
    80004f00:	00002737          	lui	a4,0x2
    80004f04:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004f08:	00e7f7b3          	and	a5,a5,a4
    80004f0c:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80004f10:	01813083          	ld	ra,24(sp)
    80004f14:	01013403          	ld	s0,16(sp)
    80004f18:	00813483          	ld	s1,8(sp)
    80004f1c:	02010113          	addi	sp,sp,32
    80004f20:	00008067          	ret
        return -1;
    80004f24:	0ff00513          	li	a0,255
    80004f28:	fe9ff06f          	j	80004f10 <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080004f2c <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004f2c:	fe010113          	addi	sp,sp,-32
    80004f30:	00113c23          	sd	ra,24(sp)
    80004f34:	00813823          	sd	s0,16(sp)
    80004f38:	00913423          	sd	s1,8(sp)
    80004f3c:	02010413          	addi	s0,sp,32
    80004f40:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004f44:	0004c503          	lbu	a0,0(s1)
    80004f48:	00050a63          	beqz	a0,80004f5c <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004f4c:	00000097          	auipc	ra,0x0
    80004f50:	ed8080e7          	jalr	-296(ra) # 80004e24 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004f54:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004f58:	fedff06f          	j	80004f44 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004f5c:	01813083          	ld	ra,24(sp)
    80004f60:	01013403          	ld	s0,16(sp)
    80004f64:	00813483          	ld	s1,8(sp)
    80004f68:	02010113          	addi	sp,sp,32
    80004f6c:	00008067          	ret

0000000080004f70 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004f70:	fb010113          	addi	sp,sp,-80
    80004f74:	04113423          	sd	ra,72(sp)
    80004f78:	04813023          	sd	s0,64(sp)
    80004f7c:	02913c23          	sd	s1,56(sp)
    80004f80:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004f84:	00004797          	auipc	a5,0x4
    80004f88:	5e478793          	addi	a5,a5,1508 # 80009568 <CONSOLE_STATUS+0x558>
    80004f8c:	0007b703          	ld	a4,0(a5)
    80004f90:	fce43423          	sd	a4,-56(s0)
    80004f94:	0087b703          	ld	a4,8(a5)
    80004f98:	fce43823          	sd	a4,-48(s0)
    80004f9c:	0107c783          	lbu	a5,16(a5)
    80004fa0:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004fa4:	00060463          	beqz	a2,80004fac <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004fa8:	08054263          	bltz	a0,8000502c <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004fac:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004fb0:	00000813          	li	a6,0
    }

    i = 0;
    80004fb4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004fb8:	0005871b          	sext.w	a4,a1
    80004fbc:	02b577bb          	remuw	a5,a0,a1
    80004fc0:	00048693          	mv	a3,s1
    80004fc4:	0014849b          	addiw	s1,s1,1
    80004fc8:	02079793          	slli	a5,a5,0x20
    80004fcc:	0207d793          	srli	a5,a5,0x20
    80004fd0:	fe040613          	addi	a2,s0,-32
    80004fd4:	00f607b3          	add	a5,a2,a5
    80004fd8:	fe87c603          	lbu	a2,-24(a5)
    80004fdc:	fe040793          	addi	a5,s0,-32
    80004fe0:	00d787b3          	add	a5,a5,a3
    80004fe4:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004fe8:	0005061b          	sext.w	a2,a0
    80004fec:	02b5553b          	divuw	a0,a0,a1
    80004ff0:	fce674e3          	bgeu	a2,a4,80004fb8 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004ff4:	00080c63          	beqz	a6,8000500c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004ff8:	fe040793          	addi	a5,s0,-32
    80004ffc:	009784b3          	add	s1,a5,s1
    80005000:	02d00793          	li	a5,45
    80005004:	fcf48c23          	sb	a5,-40(s1)
    80005008:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000500c:	fff4849b          	addiw	s1,s1,-1
    80005010:	0204c463          	bltz	s1,80005038 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80005014:	fe040793          	addi	a5,s0,-32
    80005018:	009787b3          	add	a5,a5,s1
    8000501c:	fd87c503          	lbu	a0,-40(a5)
    80005020:	00000097          	auipc	ra,0x0
    80005024:	e04080e7          	jalr	-508(ra) # 80004e24 <_ZN11ConsoleUtil9putOutputEc>
    80005028:	fe5ff06f          	j	8000500c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    8000502c:	40a0053b          	negw	a0,a0
        neg = 1;
    80005030:	00100813          	li	a6,1
        x = -xx;
    80005034:	f81ff06f          	j	80004fb4 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80005038:	04813083          	ld	ra,72(sp)
    8000503c:	04013403          	ld	s0,64(sp)
    80005040:	03813483          	ld	s1,56(sp)
    80005044:	05010113          	addi	sp,sp,80
    80005048:	00008067          	ret

000000008000504c <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    8000504c:	fe010113          	addi	sp,sp,-32
    80005050:	00113c23          	sd	ra,24(sp)
    80005054:	00813823          	sd	s0,16(sp)
    80005058:	00913423          	sd	s1,8(sp)
    8000505c:	01213023          	sd	s2,0(sp)
    80005060:	02010413          	addi	s0,sp,32
    80005064:	00058913          	mv	s2,a1
    80005068:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    8000506c:	00000097          	auipc	ra,0x0
    80005070:	ec0080e7          	jalr	-320(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    80005074:	00000613          	li	a2,0
    80005078:	00a00593          	li	a1,10
    8000507c:	00090513          	mv	a0,s2
    80005080:	00000097          	auipc	ra,0x0
    80005084:	ef0080e7          	jalr	-272(ra) # 80004f70 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80005088:	00048513          	mv	a0,s1
    8000508c:	00000097          	auipc	ra,0x0
    80005090:	ea0080e7          	jalr	-352(ra) # 80004f2c <_ZN11ConsoleUtil11printStringEPKc>
}
    80005094:	01813083          	ld	ra,24(sp)
    80005098:	01013403          	ld	s0,16(sp)
    8000509c:	00813483          	ld	s1,8(sp)
    800050a0:	00013903          	ld	s2,0(sp)
    800050a4:	02010113          	addi	sp,sp,32
    800050a8:	00008067          	ret

00000000800050ac <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    800050ac:	ff010113          	addi	sp,sp,-16
    800050b0:	00813423          	sd	s0,8(sp)
    800050b4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    800050b8:	04300513          	li	a0,67

    asm("ecall");
    800050bc:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    800050c0:	00050513          	mv	a0,a0

    return (char)status;
}
    800050c4:	0ff57513          	andi	a0,a0,255
    800050c8:	00813403          	ld	s0,8(sp)
    800050cc:	01010113          	addi	sp,sp,16
    800050d0:	00008067          	ret

00000000800050d4 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    800050d4:	ff010113          	addi	sp,sp,-16
    800050d8:	00113423          	sd	ra,8(sp)
    800050dc:	00813023          	sd	s0,0(sp)
    800050e0:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    800050e4:	ffffd097          	auipc	ra,0xffffd
    800050e8:	8c8080e7          	jalr	-1848(ra) # 800019ac <_ZN13SlabAllocator10initializeEPvm>
}
    800050ec:	00813083          	ld	ra,8(sp)
    800050f0:	00013403          	ld	s0,0(sp)
    800050f4:	01010113          	addi	sp,sp,16
    800050f8:	00008067          	ret

00000000800050fc <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    800050fc:	ff010113          	addi	sp,sp,-16
    80005100:	00113423          	sd	ra,8(sp)
    80005104:	00813023          	sd	s0,0(sp)
    80005108:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    8000510c:	ffffd097          	auipc	ra,0xffffd
    80005110:	800080e7          	jalr	-2048(ra) # 8000190c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80005114:	00813083          	ld	ra,8(sp)
    80005118:	00013403          	ld	s0,0(sp)
    8000511c:	01010113          	addi	sp,sp,16
    80005120:	00008067          	ret

0000000080005124 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80005124:	ff010113          	addi	sp,sp,-16
    80005128:	00113423          	sd	ra,8(sp)
    8000512c:	00813023          	sd	s0,0(sp)
    80005130:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80005134:	ffffc097          	auipc	ra,0xffffc
    80005138:	69c080e7          	jalr	1692(ra) # 800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    8000513c:	00813083          	ld	ra,8(sp)
    80005140:	00013403          	ld	s0,0(sp)
    80005144:	01010113          	addi	sp,sp,16
    80005148:	00008067          	ret

000000008000514c <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    8000514c:	ff010113          	addi	sp,sp,-16
    80005150:	00113423          	sd	ra,8(sp)
    80005154:	00813023          	sd	s0,0(sp)
    80005158:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    8000515c:	ffffd097          	auipc	ra,0xffffd
    80005160:	a28080e7          	jalr	-1496(ra) # 80001b84 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80005164:	00813083          	ld	ra,8(sp)
    80005168:	00013403          	ld	s0,0(sp)
    8000516c:	01010113          	addi	sp,sp,16
    80005170:	00008067          	ret

0000000080005174 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80005174:	fe010113          	addi	sp,sp,-32
    80005178:	00113c23          	sd	ra,24(sp)
    8000517c:	00813823          	sd	s0,16(sp)
    80005180:	02010413          	addi	s0,sp,32
    80005184:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80005188:	fe840513          	addi	a0,s0,-24
    8000518c:	ffffd097          	auipc	ra,0xffffd
    80005190:	b58080e7          	jalr	-1192(ra) # 80001ce4 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80005194:	01813083          	ld	ra,24(sp)
    80005198:	01013403          	ld	s0,16(sp)
    8000519c:	02010113          	addi	sp,sp,32
    800051a0:	00008067          	ret

00000000800051a4 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    800051a4:	ff010113          	addi	sp,sp,-16
    800051a8:	00113423          	sd	ra,8(sp)
    800051ac:	00813023          	sd	s0,0(sp)
    800051b0:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    800051b4:	ffffc097          	auipc	ra,0xffffc
    800051b8:	14c080e7          	jalr	332(ra) # 80001300 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    800051bc:	00813083          	ld	ra,8(sp)
    800051c0:	00013403          	ld	s0,0(sp)
    800051c4:	01010113          	addi	sp,sp,16
    800051c8:	00008067          	ret

00000000800051cc <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    800051cc:	ff010113          	addi	sp,sp,-16
    800051d0:	00113423          	sd	ra,8(sp)
    800051d4:	00813023          	sd	s0,0(sp)
    800051d8:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    800051dc:	ffffc097          	auipc	ra,0xffffc
    800051e0:	f78080e7          	jalr	-136(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    800051e4:	00813083          	ld	ra,8(sp)
    800051e8:	00013403          	ld	s0,0(sp)
    800051ec:	01010113          	addi	sp,sp,16
    800051f0:	00008067          	ret

00000000800051f4 <_Z7kmallocm>:
void* kmalloc(size_t size){
    800051f4:	ff010113          	addi	sp,sp,-16
    800051f8:	00113423          	sd	ra,8(sp)
    800051fc:	00813023          	sd	s0,0(sp)
    80005200:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80005204:	ffffc097          	auipc	ra,0xffffc
    80005208:	668080e7          	jalr	1640(ra) # 8000186c <_ZN13SlabAllocator14allocateBufferEm>
}
    8000520c:	00813083          	ld	ra,8(sp)
    80005210:	00013403          	ld	s0,0(sp)
    80005214:	01010113          	addi	sp,sp,16
    80005218:	00008067          	ret

000000008000521c <_Z5kfreePKv>:

void kfree(const void* objp){
    8000521c:	ff010113          	addi	sp,sp,-16
    80005220:	00113423          	sd	ra,8(sp)
    80005224:	00813023          	sd	s0,0(sp)
    80005228:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    8000522c:	ffffd097          	auipc	ra,0xffffd
    80005230:	a4c080e7          	jalr	-1460(ra) # 80001c78 <_ZN13SlabAllocator10freeBufferEPKv>
    80005234:	00813083          	ld	ra,8(sp)
    80005238:	00013403          	ld	s0,0(sp)
    8000523c:	01010113          	addi	sp,sp,16
    80005240:	00008067          	ret

0000000080005244 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005244:	fd010113          	addi	sp,sp,-48
    80005248:	02113423          	sd	ra,40(sp)
    8000524c:	02813023          	sd	s0,32(sp)
    80005250:	00913c23          	sd	s1,24(sp)
    80005254:	01213823          	sd	s2,16(sp)
    80005258:	01313423          	sd	s3,8(sp)
    8000525c:	03010413          	addi	s0,sp,48
    80005260:	00050493          	mv	s1,a0
    80005264:	00058913          	mv	s2,a1
    80005268:	0015879b          	addiw	a5,a1,1
    8000526c:	0007851b          	sext.w	a0,a5
    80005270:	00f4a023          	sw	a5,0(s1)
    80005274:	0004a823          	sw	zero,16(s1)
    80005278:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000527c:	00251513          	slli	a0,a0,0x2
    80005280:	ffffd097          	auipc	ra,0xffffd
    80005284:	b40080e7          	jalr	-1216(ra) # 80001dc0 <_Z9mem_allocm>
    80005288:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000528c:	01000513          	li	a0,16
    80005290:	ffffe097          	auipc	ra,0xffffe
    80005294:	3f0080e7          	jalr	1008(ra) # 80003680 <_Znwm>
    80005298:	00050993          	mv	s3,a0
    8000529c:	00000593          	li	a1,0
    800052a0:	ffffe097          	auipc	ra,0xffffe
    800052a4:	4d8080e7          	jalr	1240(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    800052a8:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800052ac:	01000513          	li	a0,16
    800052b0:	ffffe097          	auipc	ra,0xffffe
    800052b4:	3d0080e7          	jalr	976(ra) # 80003680 <_Znwm>
    800052b8:	00050993          	mv	s3,a0
    800052bc:	00090593          	mv	a1,s2
    800052c0:	ffffe097          	auipc	ra,0xffffe
    800052c4:	4b8080e7          	jalr	1208(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    800052c8:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800052cc:	01000513          	li	a0,16
    800052d0:	ffffe097          	auipc	ra,0xffffe
    800052d4:	3b0080e7          	jalr	944(ra) # 80003680 <_Znwm>
    800052d8:	00050913          	mv	s2,a0
    800052dc:	00100593          	li	a1,1
    800052e0:	ffffe097          	auipc	ra,0xffffe
    800052e4:	498080e7          	jalr	1176(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    800052e8:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800052ec:	01000513          	li	a0,16
    800052f0:	ffffe097          	auipc	ra,0xffffe
    800052f4:	390080e7          	jalr	912(ra) # 80003680 <_Znwm>
    800052f8:	00050913          	mv	s2,a0
    800052fc:	00100593          	li	a1,1
    80005300:	ffffe097          	auipc	ra,0xffffe
    80005304:	478080e7          	jalr	1144(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    80005308:	0324b823          	sd	s2,48(s1)
}
    8000530c:	02813083          	ld	ra,40(sp)
    80005310:	02013403          	ld	s0,32(sp)
    80005314:	01813483          	ld	s1,24(sp)
    80005318:	01013903          	ld	s2,16(sp)
    8000531c:	00813983          	ld	s3,8(sp)
    80005320:	03010113          	addi	sp,sp,48
    80005324:	00008067          	ret
    80005328:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000532c:	00098513          	mv	a0,s3
    80005330:	ffffe097          	auipc	ra,0xffffe
    80005334:	3a0080e7          	jalr	928(ra) # 800036d0 <_ZdlPv>
    80005338:	00048513          	mv	a0,s1
    8000533c:	00008097          	auipc	ra,0x8
    80005340:	e4c080e7          	jalr	-436(ra) # 8000d188 <_Unwind_Resume>
    80005344:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005348:	00098513          	mv	a0,s3
    8000534c:	ffffe097          	auipc	ra,0xffffe
    80005350:	384080e7          	jalr	900(ra) # 800036d0 <_ZdlPv>
    80005354:	00048513          	mv	a0,s1
    80005358:	00008097          	auipc	ra,0x8
    8000535c:	e30080e7          	jalr	-464(ra) # 8000d188 <_Unwind_Resume>
    80005360:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80005364:	00090513          	mv	a0,s2
    80005368:	ffffe097          	auipc	ra,0xffffe
    8000536c:	368080e7          	jalr	872(ra) # 800036d0 <_ZdlPv>
    80005370:	00048513          	mv	a0,s1
    80005374:	00008097          	auipc	ra,0x8
    80005378:	e14080e7          	jalr	-492(ra) # 8000d188 <_Unwind_Resume>
    8000537c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005380:	00090513          	mv	a0,s2
    80005384:	ffffe097          	auipc	ra,0xffffe
    80005388:	34c080e7          	jalr	844(ra) # 800036d0 <_ZdlPv>
    8000538c:	00048513          	mv	a0,s1
    80005390:	00008097          	auipc	ra,0x8
    80005394:	df8080e7          	jalr	-520(ra) # 8000d188 <_Unwind_Resume>

0000000080005398 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005398:	fe010113          	addi	sp,sp,-32
    8000539c:	00113c23          	sd	ra,24(sp)
    800053a0:	00813823          	sd	s0,16(sp)
    800053a4:	00913423          	sd	s1,8(sp)
    800053a8:	01213023          	sd	s2,0(sp)
    800053ac:	02010413          	addi	s0,sp,32
    800053b0:	00050493          	mv	s1,a0
    800053b4:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800053b8:	01853503          	ld	a0,24(a0) # 2018 <_entry-0x7fffdfe8>
    800053bc:	ffffe097          	auipc	ra,0xffffe
    800053c0:	3f4080e7          	jalr	1012(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800053c4:	0304b503          	ld	a0,48(s1)
    800053c8:	ffffe097          	auipc	ra,0xffffe
    800053cc:	3e8080e7          	jalr	1000(ra) # 800037b0 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800053d0:	0084b783          	ld	a5,8(s1)
    800053d4:	0144a703          	lw	a4,20(s1)
    800053d8:	00271713          	slli	a4,a4,0x2
    800053dc:	00e787b3          	add	a5,a5,a4
    800053e0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800053e4:	0144a783          	lw	a5,20(s1)
    800053e8:	0017879b          	addiw	a5,a5,1
    800053ec:	0004a703          	lw	a4,0(s1)
    800053f0:	02e7e7bb          	remw	a5,a5,a4
    800053f4:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800053f8:	0304b503          	ld	a0,48(s1)
    800053fc:	ffffe097          	auipc	ra,0xffffe
    80005400:	3e0080e7          	jalr	992(ra) # 800037dc <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80005404:	0204b503          	ld	a0,32(s1)
    80005408:	ffffe097          	auipc	ra,0xffffe
    8000540c:	3d4080e7          	jalr	980(ra) # 800037dc <_ZN9Semaphore6signalEv>

}
    80005410:	01813083          	ld	ra,24(sp)
    80005414:	01013403          	ld	s0,16(sp)
    80005418:	00813483          	ld	s1,8(sp)
    8000541c:	00013903          	ld	s2,0(sp)
    80005420:	02010113          	addi	sp,sp,32
    80005424:	00008067          	ret

0000000080005428 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005428:	fe010113          	addi	sp,sp,-32
    8000542c:	00113c23          	sd	ra,24(sp)
    80005430:	00813823          	sd	s0,16(sp)
    80005434:	00913423          	sd	s1,8(sp)
    80005438:	01213023          	sd	s2,0(sp)
    8000543c:	02010413          	addi	s0,sp,32
    80005440:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005444:	02053503          	ld	a0,32(a0)
    80005448:	ffffe097          	auipc	ra,0xffffe
    8000544c:	368080e7          	jalr	872(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005450:	0284b503          	ld	a0,40(s1)
    80005454:	ffffe097          	auipc	ra,0xffffe
    80005458:	35c080e7          	jalr	860(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000545c:	0084b703          	ld	a4,8(s1)
    80005460:	0104a783          	lw	a5,16(s1)
    80005464:	00279693          	slli	a3,a5,0x2
    80005468:	00d70733          	add	a4,a4,a3
    8000546c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005470:	0017879b          	addiw	a5,a5,1
    80005474:	0004a703          	lw	a4,0(s1)
    80005478:	02e7e7bb          	remw	a5,a5,a4
    8000547c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005480:	0284b503          	ld	a0,40(s1)
    80005484:	ffffe097          	auipc	ra,0xffffe
    80005488:	358080e7          	jalr	856(ra) # 800037dc <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000548c:	0184b503          	ld	a0,24(s1)
    80005490:	ffffe097          	auipc	ra,0xffffe
    80005494:	34c080e7          	jalr	844(ra) # 800037dc <_ZN9Semaphore6signalEv>

    return ret;
}
    80005498:	00090513          	mv	a0,s2
    8000549c:	01813083          	ld	ra,24(sp)
    800054a0:	01013403          	ld	s0,16(sp)
    800054a4:	00813483          	ld	s1,8(sp)
    800054a8:	00013903          	ld	s2,0(sp)
    800054ac:	02010113          	addi	sp,sp,32
    800054b0:	00008067          	ret

00000000800054b4 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800054b4:	fe010113          	addi	sp,sp,-32
    800054b8:	00113c23          	sd	ra,24(sp)
    800054bc:	00813823          	sd	s0,16(sp)
    800054c0:	00913423          	sd	s1,8(sp)
    800054c4:	01213023          	sd	s2,0(sp)
    800054c8:	02010413          	addi	s0,sp,32
    800054cc:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800054d0:	02853503          	ld	a0,40(a0)
    800054d4:	ffffe097          	auipc	ra,0xffffe
    800054d8:	2dc080e7          	jalr	732(ra) # 800037b0 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800054dc:	0304b503          	ld	a0,48(s1)
    800054e0:	ffffe097          	auipc	ra,0xffffe
    800054e4:	2d0080e7          	jalr	720(ra) # 800037b0 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800054e8:	0144a783          	lw	a5,20(s1)
    800054ec:	0104a903          	lw	s2,16(s1)
    800054f0:	0327ce63          	blt	a5,s2,8000552c <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800054f4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800054f8:	0304b503          	ld	a0,48(s1)
    800054fc:	ffffe097          	auipc	ra,0xffffe
    80005500:	2e0080e7          	jalr	736(ra) # 800037dc <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005504:	0284b503          	ld	a0,40(s1)
    80005508:	ffffe097          	auipc	ra,0xffffe
    8000550c:	2d4080e7          	jalr	724(ra) # 800037dc <_ZN9Semaphore6signalEv>

    return ret;
}
    80005510:	00090513          	mv	a0,s2
    80005514:	01813083          	ld	ra,24(sp)
    80005518:	01013403          	ld	s0,16(sp)
    8000551c:	00813483          	ld	s1,8(sp)
    80005520:	00013903          	ld	s2,0(sp)
    80005524:	02010113          	addi	sp,sp,32
    80005528:	00008067          	ret
        ret = cap - head + tail;
    8000552c:	0004a703          	lw	a4,0(s1)
    80005530:	4127093b          	subw	s2,a4,s2
    80005534:	00f9093b          	addw	s2,s2,a5
    80005538:	fc1ff06f          	j	800054f8 <_ZN9BufferCPP6getCntEv+0x44>

000000008000553c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000553c:	fe010113          	addi	sp,sp,-32
    80005540:	00113c23          	sd	ra,24(sp)
    80005544:	00813823          	sd	s0,16(sp)
    80005548:	00913423          	sd	s1,8(sp)
    8000554c:	02010413          	addi	s0,sp,32
    80005550:	00050493          	mv	s1,a0
    Console::putc('\n');
    80005554:	00a00513          	li	a0,10
    80005558:	ffffe097          	auipc	ra,0xffffe
    8000555c:	480080e7          	jalr	1152(ra) # 800039d8 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005560:	00004517          	auipc	a0,0x4
    80005564:	02050513          	addi	a0,a0,32 # 80009580 <CONSOLE_STATUS+0x570>
    80005568:	ffffd097          	auipc	ra,0xffffd
    8000556c:	2f0080e7          	jalr	752(ra) # 80002858 <_Z11printStringPKc>
    while (getCnt()) {
    80005570:	00048513          	mv	a0,s1
    80005574:	00000097          	auipc	ra,0x0
    80005578:	f40080e7          	jalr	-192(ra) # 800054b4 <_ZN9BufferCPP6getCntEv>
    8000557c:	02050c63          	beqz	a0,800055b4 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005580:	0084b783          	ld	a5,8(s1)
    80005584:	0104a703          	lw	a4,16(s1)
    80005588:	00271713          	slli	a4,a4,0x2
    8000558c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005590:	0007c503          	lbu	a0,0(a5)
    80005594:	ffffe097          	auipc	ra,0xffffe
    80005598:	444080e7          	jalr	1092(ra) # 800039d8 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000559c:	0104a783          	lw	a5,16(s1)
    800055a0:	0017879b          	addiw	a5,a5,1
    800055a4:	0004a703          	lw	a4,0(s1)
    800055a8:	02e7e7bb          	remw	a5,a5,a4
    800055ac:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800055b0:	fc1ff06f          	j	80005570 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800055b4:	02100513          	li	a0,33
    800055b8:	ffffe097          	auipc	ra,0xffffe
    800055bc:	420080e7          	jalr	1056(ra) # 800039d8 <_ZN7Console4putcEc>
    Console::putc('\n');
    800055c0:	00a00513          	li	a0,10
    800055c4:	ffffe097          	auipc	ra,0xffffe
    800055c8:	414080e7          	jalr	1044(ra) # 800039d8 <_ZN7Console4putcEc>
    mem_free(buffer);
    800055cc:	0084b503          	ld	a0,8(s1)
    800055d0:	ffffd097          	auipc	ra,0xffffd
    800055d4:	820080e7          	jalr	-2016(ra) # 80001df0 <_Z8mem_freePv>
    delete itemAvailable;
    800055d8:	0204b503          	ld	a0,32(s1)
    800055dc:	00050863          	beqz	a0,800055ec <_ZN9BufferCPPD1Ev+0xb0>
    800055e0:	00053783          	ld	a5,0(a0)
    800055e4:	0087b783          	ld	a5,8(a5)
    800055e8:	000780e7          	jalr	a5
    delete spaceAvailable;
    800055ec:	0184b503          	ld	a0,24(s1)
    800055f0:	00050863          	beqz	a0,80005600 <_ZN9BufferCPPD1Ev+0xc4>
    800055f4:	00053783          	ld	a5,0(a0)
    800055f8:	0087b783          	ld	a5,8(a5)
    800055fc:	000780e7          	jalr	a5
    delete mutexTail;
    80005600:	0304b503          	ld	a0,48(s1)
    80005604:	00050863          	beqz	a0,80005614 <_ZN9BufferCPPD1Ev+0xd8>
    80005608:	00053783          	ld	a5,0(a0)
    8000560c:	0087b783          	ld	a5,8(a5)
    80005610:	000780e7          	jalr	a5
    delete mutexHead;
    80005614:	0284b503          	ld	a0,40(s1)
    80005618:	00050863          	beqz	a0,80005628 <_ZN9BufferCPPD1Ev+0xec>
    8000561c:	00053783          	ld	a5,0(a0)
    80005620:	0087b783          	ld	a5,8(a5)
    80005624:	000780e7          	jalr	a5
}
    80005628:	01813083          	ld	ra,24(sp)
    8000562c:	01013403          	ld	s0,16(sp)
    80005630:	00813483          	ld	s1,8(sp)
    80005634:	02010113          	addi	sp,sp,32
    80005638:	00008067          	ret

000000008000563c <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    8000563c:	fe010113          	addi	sp,sp,-32
    80005640:	00113c23          	sd	ra,24(sp)
    80005644:	00813823          	sd	s0,16(sp)
    80005648:	00913423          	sd	s1,8(sp)
    8000564c:	01213023          	sd	s2,0(sp)
    80005650:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005654:	00000913          	li	s2,0
    80005658:	0380006f          	j	80005690 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000565c:	ffffd097          	auipc	ra,0xffffd
    80005660:	864080e7          	jalr	-1948(ra) # 80001ec0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005664:	00148493          	addi	s1,s1,1
    80005668:	000027b7          	lui	a5,0x2
    8000566c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005670:	0097ee63          	bltu	a5,s1,8000568c <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005674:	00000713          	li	a4,0
    80005678:	000077b7          	lui	a5,0x7
    8000567c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005680:	fce7eee3          	bltu	a5,a4,8000565c <_Z11workerBodyAPv+0x20>
    80005684:	00170713          	addi	a4,a4,1
    80005688:	ff1ff06f          	j	80005678 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000568c:	00190913          	addi	s2,s2,1
    80005690:	00900793          	li	a5,9
    80005694:	0527e063          	bltu	a5,s2,800056d4 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005698:	00004517          	auipc	a0,0x4
    8000569c:	f0050513          	addi	a0,a0,-256 # 80009598 <CONSOLE_STATUS+0x588>
    800056a0:	ffffd097          	auipc	ra,0xffffd
    800056a4:	1b8080e7          	jalr	440(ra) # 80002858 <_Z11printStringPKc>
    800056a8:	00000613          	li	a2,0
    800056ac:	00a00593          	li	a1,10
    800056b0:	0009051b          	sext.w	a0,s2
    800056b4:	ffffd097          	auipc	ra,0xffffd
    800056b8:	33c080e7          	jalr	828(ra) # 800029f0 <_Z8printIntiii>
    800056bc:	00004517          	auipc	a0,0x4
    800056c0:	cb450513          	addi	a0,a0,-844 # 80009370 <CONSOLE_STATUS+0x360>
    800056c4:	ffffd097          	auipc	ra,0xffffd
    800056c8:	194080e7          	jalr	404(ra) # 80002858 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800056cc:	00000493          	li	s1,0
    800056d0:	f99ff06f          	j	80005668 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    800056d4:	00004517          	auipc	a0,0x4
    800056d8:	ecc50513          	addi	a0,a0,-308 # 800095a0 <CONSOLE_STATUS+0x590>
    800056dc:	ffffd097          	auipc	ra,0xffffd
    800056e0:	17c080e7          	jalr	380(ra) # 80002858 <_Z11printStringPKc>
    finishedA = true;
    800056e4:	00100793          	li	a5,1
    800056e8:	00007717          	auipc	a4,0x7
    800056ec:	9af70823          	sb	a5,-1616(a4) # 8000c098 <finishedA>
}
    800056f0:	01813083          	ld	ra,24(sp)
    800056f4:	01013403          	ld	s0,16(sp)
    800056f8:	00813483          	ld	s1,8(sp)
    800056fc:	00013903          	ld	s2,0(sp)
    80005700:	02010113          	addi	sp,sp,32
    80005704:	00008067          	ret

0000000080005708 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    80005708:	fe010113          	addi	sp,sp,-32
    8000570c:	00113c23          	sd	ra,24(sp)
    80005710:	00813823          	sd	s0,16(sp)
    80005714:	00913423          	sd	s1,8(sp)
    80005718:	01213023          	sd	s2,0(sp)
    8000571c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005720:	00000913          	li	s2,0
    80005724:	0380006f          	j	8000575c <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005728:	ffffc097          	auipc	ra,0xffffc
    8000572c:	798080e7          	jalr	1944(ra) # 80001ec0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005730:	00148493          	addi	s1,s1,1
    80005734:	000027b7          	lui	a5,0x2
    80005738:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000573c:	0097ee63          	bltu	a5,s1,80005758 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005740:	00000713          	li	a4,0
    80005744:	000077b7          	lui	a5,0x7
    80005748:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000574c:	fce7eee3          	bltu	a5,a4,80005728 <_Z11workerBodyBPv+0x20>
    80005750:	00170713          	addi	a4,a4,1
    80005754:	ff1ff06f          	j	80005744 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005758:	00190913          	addi	s2,s2,1
    8000575c:	00f00793          	li	a5,15
    80005760:	0527e063          	bltu	a5,s2,800057a0 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005764:	00004517          	auipc	a0,0x4
    80005768:	e4c50513          	addi	a0,a0,-436 # 800095b0 <CONSOLE_STATUS+0x5a0>
    8000576c:	ffffd097          	auipc	ra,0xffffd
    80005770:	0ec080e7          	jalr	236(ra) # 80002858 <_Z11printStringPKc>
    80005774:	00000613          	li	a2,0
    80005778:	00a00593          	li	a1,10
    8000577c:	0009051b          	sext.w	a0,s2
    80005780:	ffffd097          	auipc	ra,0xffffd
    80005784:	270080e7          	jalr	624(ra) # 800029f0 <_Z8printIntiii>
    80005788:	00004517          	auipc	a0,0x4
    8000578c:	be850513          	addi	a0,a0,-1048 # 80009370 <CONSOLE_STATUS+0x360>
    80005790:	ffffd097          	auipc	ra,0xffffd
    80005794:	0c8080e7          	jalr	200(ra) # 80002858 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005798:	00000493          	li	s1,0
    8000579c:	f99ff06f          	j	80005734 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    800057a0:	00004517          	auipc	a0,0x4
    800057a4:	e1850513          	addi	a0,a0,-488 # 800095b8 <CONSOLE_STATUS+0x5a8>
    800057a8:	ffffd097          	auipc	ra,0xffffd
    800057ac:	0b0080e7          	jalr	176(ra) # 80002858 <_Z11printStringPKc>
    finishedB = true;
    800057b0:	00100793          	li	a5,1
    800057b4:	00007717          	auipc	a4,0x7
    800057b8:	8ef702a3          	sb	a5,-1819(a4) # 8000c099 <finishedB>
    thread_dispatch();
    800057bc:	ffffc097          	auipc	ra,0xffffc
    800057c0:	704080e7          	jalr	1796(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    800057c4:	01813083          	ld	ra,24(sp)
    800057c8:	01013403          	ld	s0,16(sp)
    800057cc:	00813483          	ld	s1,8(sp)
    800057d0:	00013903          	ld	s2,0(sp)
    800057d4:	02010113          	addi	sp,sp,32
    800057d8:	00008067          	ret

00000000800057dc <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    800057dc:	fe010113          	addi	sp,sp,-32
    800057e0:	00113c23          	sd	ra,24(sp)
    800057e4:	00813823          	sd	s0,16(sp)
    800057e8:	00913423          	sd	s1,8(sp)
    800057ec:	01213023          	sd	s2,0(sp)
    800057f0:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    800057f4:	00053903          	ld	s2,0(a0)
    int i = 6;
    800057f8:	00600493          	li	s1,6
    while (--i > 0) {
    800057fc:	fff4849b          	addiw	s1,s1,-1
    80005800:	04905463          	blez	s1,80005848 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80005804:	00004517          	auipc	a0,0x4
    80005808:	dc450513          	addi	a0,a0,-572 # 800095c8 <CONSOLE_STATUS+0x5b8>
    8000580c:	ffffd097          	auipc	ra,0xffffd
    80005810:	04c080e7          	jalr	76(ra) # 80002858 <_Z11printStringPKc>
        printInt(sleep_time);
    80005814:	00000613          	li	a2,0
    80005818:	00a00593          	li	a1,10
    8000581c:	0009051b          	sext.w	a0,s2
    80005820:	ffffd097          	auipc	ra,0xffffd
    80005824:	1d0080e7          	jalr	464(ra) # 800029f0 <_Z8printIntiii>
        printString(" !\n");
    80005828:	00004517          	auipc	a0,0x4
    8000582c:	da850513          	addi	a0,a0,-600 # 800095d0 <CONSOLE_STATUS+0x5c0>
    80005830:	ffffd097          	auipc	ra,0xffffd
    80005834:	028080e7          	jalr	40(ra) # 80002858 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80005838:	00090513          	mv	a0,s2
    8000583c:	ffffd097          	auipc	ra,0xffffd
    80005840:	808080e7          	jalr	-2040(ra) # 80002044 <_Z10time_sleepm>
    while (--i > 0) {
    80005844:	fb9ff06f          	j	800057fc <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80005848:	00a00793          	li	a5,10
    8000584c:	02f95933          	divu	s2,s2,a5
    80005850:	fff90913          	addi	s2,s2,-1
    80005854:	00007797          	auipc	a5,0x7
    80005858:	84478793          	addi	a5,a5,-1980 # 8000c098 <finishedA>
    8000585c:	01278933          	add	s2,a5,s2
    80005860:	00100793          	li	a5,1
    80005864:	00f90423          	sb	a5,8(s2)
}
    80005868:	01813083          	ld	ra,24(sp)
    8000586c:	01013403          	ld	s0,16(sp)
    80005870:	00813483          	ld	s1,8(sp)
    80005874:	00013903          	ld	s2,0(sp)
    80005878:	02010113          	addi	sp,sp,32
    8000587c:	00008067          	ret

0000000080005880 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    80005880:	fe010113          	addi	sp,sp,-32
    80005884:	00113c23          	sd	ra,24(sp)
    80005888:	00813823          	sd	s0,16(sp)
    8000588c:	00913423          	sd	s1,8(sp)
    80005890:	01213023          	sd	s2,0(sp)
    80005894:	02010413          	addi	s0,sp,32
    80005898:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000589c:	00100793          	li	a5,1
    800058a0:	02a7f863          	bgeu	a5,a0,800058d0 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800058a4:	00a00793          	li	a5,10
    800058a8:	02f577b3          	remu	a5,a0,a5
    800058ac:	02078e63          	beqz	a5,800058e8 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800058b0:	fff48513          	addi	a0,s1,-1
    800058b4:	00000097          	auipc	ra,0x0
    800058b8:	fcc080e7          	jalr	-52(ra) # 80005880 <_Z9fibonaccim>
    800058bc:	00050913          	mv	s2,a0
    800058c0:	ffe48513          	addi	a0,s1,-2
    800058c4:	00000097          	auipc	ra,0x0
    800058c8:	fbc080e7          	jalr	-68(ra) # 80005880 <_Z9fibonaccim>
    800058cc:	00a90533          	add	a0,s2,a0
}
    800058d0:	01813083          	ld	ra,24(sp)
    800058d4:	01013403          	ld	s0,16(sp)
    800058d8:	00813483          	ld	s1,8(sp)
    800058dc:	00013903          	ld	s2,0(sp)
    800058e0:	02010113          	addi	sp,sp,32
    800058e4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800058e8:	ffffc097          	auipc	ra,0xffffc
    800058ec:	5d8080e7          	jalr	1496(ra) # 80001ec0 <_Z15thread_dispatchv>
    800058f0:	fc1ff06f          	j	800058b0 <_Z9fibonaccim+0x30>

00000000800058f4 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    800058f4:	fe010113          	addi	sp,sp,-32
    800058f8:	00113c23          	sd	ra,24(sp)
    800058fc:	00813823          	sd	s0,16(sp)
    80005900:	00913423          	sd	s1,8(sp)
    80005904:	01213023          	sd	s2,0(sp)
    80005908:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000590c:	00000493          	li	s1,0
    80005910:	0400006f          	j	80005950 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005914:	00004517          	auipc	a0,0x4
    80005918:	cc450513          	addi	a0,a0,-828 # 800095d8 <CONSOLE_STATUS+0x5c8>
    8000591c:	ffffd097          	auipc	ra,0xffffd
    80005920:	f3c080e7          	jalr	-196(ra) # 80002858 <_Z11printStringPKc>
    80005924:	00000613          	li	a2,0
    80005928:	00a00593          	li	a1,10
    8000592c:	00048513          	mv	a0,s1
    80005930:	ffffd097          	auipc	ra,0xffffd
    80005934:	0c0080e7          	jalr	192(ra) # 800029f0 <_Z8printIntiii>
    80005938:	00004517          	auipc	a0,0x4
    8000593c:	a3850513          	addi	a0,a0,-1480 # 80009370 <CONSOLE_STATUS+0x360>
    80005940:	ffffd097          	auipc	ra,0xffffd
    80005944:	f18080e7          	jalr	-232(ra) # 80002858 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005948:	0014849b          	addiw	s1,s1,1
    8000594c:	0ff4f493          	andi	s1,s1,255
    80005950:	00200793          	li	a5,2
    80005954:	fc97f0e3          	bgeu	a5,s1,80005914 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    80005958:	00004517          	auipc	a0,0x4
    8000595c:	c8850513          	addi	a0,a0,-888 # 800095e0 <CONSOLE_STATUS+0x5d0>
    80005960:	ffffd097          	auipc	ra,0xffffd
    80005964:	ef8080e7          	jalr	-264(ra) # 80002858 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005968:	00700313          	li	t1,7
    thread_dispatch();
    8000596c:	ffffc097          	auipc	ra,0xffffc
    80005970:	554080e7          	jalr	1364(ra) # 80001ec0 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005974:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80005978:	00004517          	auipc	a0,0x4
    8000597c:	c7850513          	addi	a0,a0,-904 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80005980:	ffffd097          	auipc	ra,0xffffd
    80005984:	ed8080e7          	jalr	-296(ra) # 80002858 <_Z11printStringPKc>
    80005988:	00000613          	li	a2,0
    8000598c:	00a00593          	li	a1,10
    80005990:	0009051b          	sext.w	a0,s2
    80005994:	ffffd097          	auipc	ra,0xffffd
    80005998:	05c080e7          	jalr	92(ra) # 800029f0 <_Z8printIntiii>
    8000599c:	00004517          	auipc	a0,0x4
    800059a0:	9d450513          	addi	a0,a0,-1580 # 80009370 <CONSOLE_STATUS+0x360>
    800059a4:	ffffd097          	auipc	ra,0xffffd
    800059a8:	eb4080e7          	jalr	-332(ra) # 80002858 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800059ac:	00c00513          	li	a0,12
    800059b0:	00000097          	auipc	ra,0x0
    800059b4:	ed0080e7          	jalr	-304(ra) # 80005880 <_Z9fibonaccim>
    800059b8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800059bc:	00004517          	auipc	a0,0x4
    800059c0:	c3c50513          	addi	a0,a0,-964 # 800095f8 <CONSOLE_STATUS+0x5e8>
    800059c4:	ffffd097          	auipc	ra,0xffffd
    800059c8:	e94080e7          	jalr	-364(ra) # 80002858 <_Z11printStringPKc>
    800059cc:	00000613          	li	a2,0
    800059d0:	00a00593          	li	a1,10
    800059d4:	0009051b          	sext.w	a0,s2
    800059d8:	ffffd097          	auipc	ra,0xffffd
    800059dc:	018080e7          	jalr	24(ra) # 800029f0 <_Z8printIntiii>
    800059e0:	00004517          	auipc	a0,0x4
    800059e4:	99050513          	addi	a0,a0,-1648 # 80009370 <CONSOLE_STATUS+0x360>
    800059e8:	ffffd097          	auipc	ra,0xffffd
    800059ec:	e70080e7          	jalr	-400(ra) # 80002858 <_Z11printStringPKc>
    800059f0:	0400006f          	j	80005a30 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800059f4:	00004517          	auipc	a0,0x4
    800059f8:	be450513          	addi	a0,a0,-1052 # 800095d8 <CONSOLE_STATUS+0x5c8>
    800059fc:	ffffd097          	auipc	ra,0xffffd
    80005a00:	e5c080e7          	jalr	-420(ra) # 80002858 <_Z11printStringPKc>
    80005a04:	00000613          	li	a2,0
    80005a08:	00a00593          	li	a1,10
    80005a0c:	00048513          	mv	a0,s1
    80005a10:	ffffd097          	auipc	ra,0xffffd
    80005a14:	fe0080e7          	jalr	-32(ra) # 800029f0 <_Z8printIntiii>
    80005a18:	00004517          	auipc	a0,0x4
    80005a1c:	95850513          	addi	a0,a0,-1704 # 80009370 <CONSOLE_STATUS+0x360>
    80005a20:	ffffd097          	auipc	ra,0xffffd
    80005a24:	e38080e7          	jalr	-456(ra) # 80002858 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005a28:	0014849b          	addiw	s1,s1,1
    80005a2c:	0ff4f493          	andi	s1,s1,255
    80005a30:	00500793          	li	a5,5
    80005a34:	fc97f0e3          	bgeu	a5,s1,800059f4 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80005a38:	00004517          	auipc	a0,0x4
    80005a3c:	b6850513          	addi	a0,a0,-1176 # 800095a0 <CONSOLE_STATUS+0x590>
    80005a40:	ffffd097          	auipc	ra,0xffffd
    80005a44:	e18080e7          	jalr	-488(ra) # 80002858 <_Z11printStringPKc>
    finishedC = true;
    80005a48:	00100793          	li	a5,1
    80005a4c:	00006717          	auipc	a4,0x6
    80005a50:	64f70e23          	sb	a5,1628(a4) # 8000c0a8 <finishedC>
    thread_dispatch();
    80005a54:	ffffc097          	auipc	ra,0xffffc
    80005a58:	46c080e7          	jalr	1132(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    80005a5c:	01813083          	ld	ra,24(sp)
    80005a60:	01013403          	ld	s0,16(sp)
    80005a64:	00813483          	ld	s1,8(sp)
    80005a68:	00013903          	ld	s2,0(sp)
    80005a6c:	02010113          	addi	sp,sp,32
    80005a70:	00008067          	ret

0000000080005a74 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    80005a74:	fe010113          	addi	sp,sp,-32
    80005a78:	00113c23          	sd	ra,24(sp)
    80005a7c:	00813823          	sd	s0,16(sp)
    80005a80:	00913423          	sd	s1,8(sp)
    80005a84:	01213023          	sd	s2,0(sp)
    80005a88:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005a8c:	00a00493          	li	s1,10
    80005a90:	0400006f          	j	80005ad0 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005a94:	00004517          	auipc	a0,0x4
    80005a98:	b7450513          	addi	a0,a0,-1164 # 80009608 <CONSOLE_STATUS+0x5f8>
    80005a9c:	ffffd097          	auipc	ra,0xffffd
    80005aa0:	dbc080e7          	jalr	-580(ra) # 80002858 <_Z11printStringPKc>
    80005aa4:	00000613          	li	a2,0
    80005aa8:	00a00593          	li	a1,10
    80005aac:	00048513          	mv	a0,s1
    80005ab0:	ffffd097          	auipc	ra,0xffffd
    80005ab4:	f40080e7          	jalr	-192(ra) # 800029f0 <_Z8printIntiii>
    80005ab8:	00004517          	auipc	a0,0x4
    80005abc:	8b850513          	addi	a0,a0,-1864 # 80009370 <CONSOLE_STATUS+0x360>
    80005ac0:	ffffd097          	auipc	ra,0xffffd
    80005ac4:	d98080e7          	jalr	-616(ra) # 80002858 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005ac8:	0014849b          	addiw	s1,s1,1
    80005acc:	0ff4f493          	andi	s1,s1,255
    80005ad0:	00c00793          	li	a5,12
    80005ad4:	fc97f0e3          	bgeu	a5,s1,80005a94 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005ad8:	00004517          	auipc	a0,0x4
    80005adc:	b3850513          	addi	a0,a0,-1224 # 80009610 <CONSOLE_STATUS+0x600>
    80005ae0:	ffffd097          	auipc	ra,0xffffd
    80005ae4:	d78080e7          	jalr	-648(ra) # 80002858 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005ae8:	00500313          	li	t1,5
    thread_dispatch();
    80005aec:	ffffc097          	auipc	ra,0xffffc
    80005af0:	3d4080e7          	jalr	980(ra) # 80001ec0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005af4:	01000513          	li	a0,16
    80005af8:	00000097          	auipc	ra,0x0
    80005afc:	d88080e7          	jalr	-632(ra) # 80005880 <_Z9fibonaccim>
    80005b00:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005b04:	00004517          	auipc	a0,0x4
    80005b08:	b1c50513          	addi	a0,a0,-1252 # 80009620 <CONSOLE_STATUS+0x610>
    80005b0c:	ffffd097          	auipc	ra,0xffffd
    80005b10:	d4c080e7          	jalr	-692(ra) # 80002858 <_Z11printStringPKc>
    80005b14:	00000613          	li	a2,0
    80005b18:	00a00593          	li	a1,10
    80005b1c:	0009051b          	sext.w	a0,s2
    80005b20:	ffffd097          	auipc	ra,0xffffd
    80005b24:	ed0080e7          	jalr	-304(ra) # 800029f0 <_Z8printIntiii>
    80005b28:	00004517          	auipc	a0,0x4
    80005b2c:	84850513          	addi	a0,a0,-1976 # 80009370 <CONSOLE_STATUS+0x360>
    80005b30:	ffffd097          	auipc	ra,0xffffd
    80005b34:	d28080e7          	jalr	-728(ra) # 80002858 <_Z11printStringPKc>
    80005b38:	0400006f          	j	80005b78 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005b3c:	00004517          	auipc	a0,0x4
    80005b40:	acc50513          	addi	a0,a0,-1332 # 80009608 <CONSOLE_STATUS+0x5f8>
    80005b44:	ffffd097          	auipc	ra,0xffffd
    80005b48:	d14080e7          	jalr	-748(ra) # 80002858 <_Z11printStringPKc>
    80005b4c:	00000613          	li	a2,0
    80005b50:	00a00593          	li	a1,10
    80005b54:	00048513          	mv	a0,s1
    80005b58:	ffffd097          	auipc	ra,0xffffd
    80005b5c:	e98080e7          	jalr	-360(ra) # 800029f0 <_Z8printIntiii>
    80005b60:	00004517          	auipc	a0,0x4
    80005b64:	81050513          	addi	a0,a0,-2032 # 80009370 <CONSOLE_STATUS+0x360>
    80005b68:	ffffd097          	auipc	ra,0xffffd
    80005b6c:	cf0080e7          	jalr	-784(ra) # 80002858 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005b70:	0014849b          	addiw	s1,s1,1
    80005b74:	0ff4f493          	andi	s1,s1,255
    80005b78:	00f00793          	li	a5,15
    80005b7c:	fc97f0e3          	bgeu	a5,s1,80005b3c <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005b80:	00004517          	auipc	a0,0x4
    80005b84:	ab050513          	addi	a0,a0,-1360 # 80009630 <CONSOLE_STATUS+0x620>
    80005b88:	ffffd097          	auipc	ra,0xffffd
    80005b8c:	cd0080e7          	jalr	-816(ra) # 80002858 <_Z11printStringPKc>
    finishedD = true;
    80005b90:	00100793          	li	a5,1
    80005b94:	00006717          	auipc	a4,0x6
    80005b98:	50f70aa3          	sb	a5,1301(a4) # 8000c0a9 <finishedD>
    thread_dispatch();
    80005b9c:	ffffc097          	auipc	ra,0xffffc
    80005ba0:	324080e7          	jalr	804(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    80005ba4:	01813083          	ld	ra,24(sp)
    80005ba8:	01013403          	ld	s0,16(sp)
    80005bac:	00813483          	ld	s1,8(sp)
    80005bb0:	00013903          	ld	s2,0(sp)
    80005bb4:	02010113          	addi	sp,sp,32
    80005bb8:	00008067          	ret

0000000080005bbc <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005bbc:	fc010113          	addi	sp,sp,-64
    80005bc0:	02113c23          	sd	ra,56(sp)
    80005bc4:	02813823          	sd	s0,48(sp)
    80005bc8:	02913423          	sd	s1,40(sp)
    80005bcc:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005bd0:	00000613          	li	a2,0
    80005bd4:	00000597          	auipc	a1,0x0
    80005bd8:	a6858593          	addi	a1,a1,-1432 # 8000563c <_Z11workerBodyAPv>
    80005bdc:	fc040513          	addi	a0,s0,-64
    80005be0:	ffffc097          	auipc	ra,0xffffc
    80005be4:	23c080e7          	jalr	572(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80005be8:	00004517          	auipc	a0,0x4
    80005bec:	a5850513          	addi	a0,a0,-1448 # 80009640 <CONSOLE_STATUS+0x630>
    80005bf0:	ffffd097          	auipc	ra,0xffffd
    80005bf4:	c68080e7          	jalr	-920(ra) # 80002858 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005bf8:	00000613          	li	a2,0
    80005bfc:	00000597          	auipc	a1,0x0
    80005c00:	b0c58593          	addi	a1,a1,-1268 # 80005708 <_Z11workerBodyBPv>
    80005c04:	fc840513          	addi	a0,s0,-56
    80005c08:	ffffc097          	auipc	ra,0xffffc
    80005c0c:	214080e7          	jalr	532(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005c10:	00004517          	auipc	a0,0x4
    80005c14:	a4850513          	addi	a0,a0,-1464 # 80009658 <CONSOLE_STATUS+0x648>
    80005c18:	ffffd097          	auipc	ra,0xffffd
    80005c1c:	c40080e7          	jalr	-960(ra) # 80002858 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005c20:	00000613          	li	a2,0
    80005c24:	00000597          	auipc	a1,0x0
    80005c28:	cd058593          	addi	a1,a1,-816 # 800058f4 <_Z11workerBodyCPv>
    80005c2c:	fd040513          	addi	a0,s0,-48
    80005c30:	ffffc097          	auipc	ra,0xffffc
    80005c34:	1ec080e7          	jalr	492(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80005c38:	00004517          	auipc	a0,0x4
    80005c3c:	a3850513          	addi	a0,a0,-1480 # 80009670 <CONSOLE_STATUS+0x660>
    80005c40:	ffffd097          	auipc	ra,0xffffd
    80005c44:	c18080e7          	jalr	-1000(ra) # 80002858 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005c48:	00000613          	li	a2,0
    80005c4c:	00000597          	auipc	a1,0x0
    80005c50:	e2858593          	addi	a1,a1,-472 # 80005a74 <_Z11workerBodyDPv>
    80005c54:	fd840513          	addi	a0,s0,-40
    80005c58:	ffffc097          	auipc	ra,0xffffc
    80005c5c:	1c4080e7          	jalr	452(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80005c60:	00004517          	auipc	a0,0x4
    80005c64:	a2850513          	addi	a0,a0,-1496 # 80009688 <CONSOLE_STATUS+0x678>
    80005c68:	ffffd097          	auipc	ra,0xffffd
    80005c6c:	bf0080e7          	jalr	-1040(ra) # 80002858 <_Z11printStringPKc>
    80005c70:	00c0006f          	j	80005c7c <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005c74:	ffffc097          	auipc	ra,0xffffc
    80005c78:	24c080e7          	jalr	588(ra) # 80001ec0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005c7c:	00006797          	auipc	a5,0x6
    80005c80:	41c7c783          	lbu	a5,1052(a5) # 8000c098 <finishedA>
    80005c84:	fe0788e3          	beqz	a5,80005c74 <_Z18Threads_C_API_testv+0xb8>
    80005c88:	00006797          	auipc	a5,0x6
    80005c8c:	4117c783          	lbu	a5,1041(a5) # 8000c099 <finishedB>
    80005c90:	fe0782e3          	beqz	a5,80005c74 <_Z18Threads_C_API_testv+0xb8>
    80005c94:	00006797          	auipc	a5,0x6
    80005c98:	4147c783          	lbu	a5,1044(a5) # 8000c0a8 <finishedC>
    80005c9c:	fc078ce3          	beqz	a5,80005c74 <_Z18Threads_C_API_testv+0xb8>
    80005ca0:	00006797          	auipc	a5,0x6
    80005ca4:	4097c783          	lbu	a5,1033(a5) # 8000c0a9 <finishedD>
    80005ca8:	fc0786e3          	beqz	a5,80005c74 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80005cac:	fc040493          	addi	s1,s0,-64
    80005cb0:	0080006f          	j	80005cb8 <_Z18Threads_C_API_testv+0xfc>
    80005cb4:	00848493          	addi	s1,s1,8
    80005cb8:	fe040793          	addi	a5,s0,-32
    80005cbc:	00f48c63          	beq	s1,a5,80005cd4 <_Z18Threads_C_API_testv+0x118>
    80005cc0:	0004b503          	ld	a0,0(s1)
    80005cc4:	fe0508e3          	beqz	a0,80005cb4 <_Z18Threads_C_API_testv+0xf8>
    80005cc8:	ffffc097          	auipc	ra,0xffffc
    80005ccc:	444080e7          	jalr	1092(ra) # 8000210c <_ZN7_threaddlEPv>
    80005cd0:	fe5ff06f          	j	80005cb4 <_Z18Threads_C_API_testv+0xf8>
}
    80005cd4:	03813083          	ld	ra,56(sp)
    80005cd8:	03013403          	ld	s0,48(sp)
    80005cdc:	02813483          	ld	s1,40(sp)
    80005ce0:	04010113          	addi	sp,sp,64
    80005ce4:	00008067          	ret

0000000080005ce8 <_Z12testSleepingv>:

void testSleeping() {
    80005ce8:	fc010113          	addi	sp,sp,-64
    80005cec:	02113c23          	sd	ra,56(sp)
    80005cf0:	02813823          	sd	s0,48(sp)
    80005cf4:	02913423          	sd	s1,40(sp)
    80005cf8:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005cfc:	00a00793          	li	a5,10
    80005d00:	fcf43823          	sd	a5,-48(s0)
    80005d04:	01400793          	li	a5,20
    80005d08:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005d0c:	00000493          	li	s1,0
    80005d10:	02c0006f          	j	80005d3c <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80005d14:	00349793          	slli	a5,s1,0x3
    80005d18:	fd040613          	addi	a2,s0,-48
    80005d1c:	00f60633          	add	a2,a2,a5
    80005d20:	00000597          	auipc	a1,0x0
    80005d24:	abc58593          	addi	a1,a1,-1348 # 800057dc <_Z9sleepyRunPv>
    80005d28:	fc040513          	addi	a0,s0,-64
    80005d2c:	00f50533          	add	a0,a0,a5
    80005d30:	ffffc097          	auipc	ra,0xffffc
    80005d34:	0ec080e7          	jalr	236(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005d38:	0014849b          	addiw	s1,s1,1
    80005d3c:	00100793          	li	a5,1
    80005d40:	fc97dae3          	bge	a5,s1,80005d14 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80005d44:	00006797          	auipc	a5,0x6
    80005d48:	35c7c783          	lbu	a5,860(a5) # 8000c0a0 <finished>
    80005d4c:	fe078ce3          	beqz	a5,80005d44 <_Z12testSleepingv+0x5c>
    80005d50:	00006797          	auipc	a5,0x6
    80005d54:	3517c783          	lbu	a5,849(a5) # 8000c0a1 <finished+0x1>
    80005d58:	fe0786e3          	beqz	a5,80005d44 <_Z12testSleepingv+0x5c>
}
    80005d5c:	03813083          	ld	ra,56(sp)
    80005d60:	03013403          	ld	s0,48(sp)
    80005d64:	02813483          	ld	s1,40(sp)
    80005d68:	04010113          	addi	sp,sp,64
    80005d6c:	00008067          	ret

0000000080005d70 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005d70:	f8010113          	addi	sp,sp,-128
    80005d74:	06113c23          	sd	ra,120(sp)
    80005d78:	06813823          	sd	s0,112(sp)
    80005d7c:	06913423          	sd	s1,104(sp)
    80005d80:	07213023          	sd	s2,96(sp)
    80005d84:	05313c23          	sd	s3,88(sp)
    80005d88:	05413823          	sd	s4,80(sp)
    80005d8c:	05513423          	sd	s5,72(sp)
    80005d90:	05613023          	sd	s6,64(sp)
    80005d94:	03713c23          	sd	s7,56(sp)
    80005d98:	03813823          	sd	s8,48(sp)
    80005d9c:	03913423          	sd	s9,40(sp)
    80005da0:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80005da4:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    80005da8:	00004517          	auipc	a0,0x4
    80005dac:	8f850513          	addi	a0,a0,-1800 # 800096a0 <CONSOLE_STATUS+0x690>
    80005db0:	ffffd097          	auipc	ra,0xffffd
    80005db4:	aa8080e7          	jalr	-1368(ra) # 80002858 <_Z11printStringPKc>
        getString(input, 30);
    80005db8:	01e00593          	li	a1,30
    80005dbc:	f8040493          	addi	s1,s0,-128
    80005dc0:	00048513          	mv	a0,s1
    80005dc4:	ffffd097          	auipc	ra,0xffffd
    80005dc8:	b10080e7          	jalr	-1264(ra) # 800028d4 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80005dcc:	00048513          	mv	a0,s1
    80005dd0:	ffffd097          	auipc	ra,0xffffd
    80005dd4:	bd0080e7          	jalr	-1072(ra) # 800029a0 <_Z11stringToIntPKc>
    80005dd8:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    80005ddc:	00004517          	auipc	a0,0x4
    80005de0:	8e450513          	addi	a0,a0,-1820 # 800096c0 <CONSOLE_STATUS+0x6b0>
    80005de4:	ffffd097          	auipc	ra,0xffffd
    80005de8:	a74080e7          	jalr	-1420(ra) # 80002858 <_Z11printStringPKc>
        getString(input, 30);
    80005dec:	01e00593          	li	a1,30
    80005df0:	00048513          	mv	a0,s1
    80005df4:	ffffd097          	auipc	ra,0xffffd
    80005df8:	ae0080e7          	jalr	-1312(ra) # 800028d4 <_Z9getStringPci>
        n = stringToInt(input);
    80005dfc:	00048513          	mv	a0,s1
    80005e00:	ffffd097          	auipc	ra,0xffffd
    80005e04:	ba0080e7          	jalr	-1120(ra) # 800029a0 <_Z11stringToIntPKc>
    80005e08:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80005e0c:	00004517          	auipc	a0,0x4
    80005e10:	8d450513          	addi	a0,a0,-1836 # 800096e0 <CONSOLE_STATUS+0x6d0>
    80005e14:	ffffd097          	auipc	ra,0xffffd
    80005e18:	a44080e7          	jalr	-1468(ra) # 80002858 <_Z11printStringPKc>
    80005e1c:	00000613          	li	a2,0
    80005e20:	00a00593          	li	a1,10
    80005e24:	00098513          	mv	a0,s3
    80005e28:	ffffd097          	auipc	ra,0xffffd
    80005e2c:	bc8080e7          	jalr	-1080(ra) # 800029f0 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005e30:	00004517          	auipc	a0,0x4
    80005e34:	8c850513          	addi	a0,a0,-1848 # 800096f8 <CONSOLE_STATUS+0x6e8>
    80005e38:	ffffd097          	auipc	ra,0xffffd
    80005e3c:	a20080e7          	jalr	-1504(ra) # 80002858 <_Z11printStringPKc>
    80005e40:	00000613          	li	a2,0
    80005e44:	00a00593          	li	a1,10
    80005e48:	00048513          	mv	a0,s1
    80005e4c:	ffffd097          	auipc	ra,0xffffd
    80005e50:	ba4080e7          	jalr	-1116(ra) # 800029f0 <_Z8printIntiii>
        printString(".\n");
    80005e54:	00003517          	auipc	a0,0x3
    80005e58:	58450513          	addi	a0,a0,1412 # 800093d8 <CONSOLE_STATUS+0x3c8>
    80005e5c:	ffffd097          	auipc	ra,0xffffd
    80005e60:	9fc080e7          	jalr	-1540(ra) # 80002858 <_Z11printStringPKc>
        if(threadNum > n) {
    80005e64:	0334c463          	blt	s1,s3,80005e8c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005e68:	03305c63          	blez	s3,80005ea0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005e6c:	03800513          	li	a0,56
    80005e70:	ffffe097          	auipc	ra,0xffffe
    80005e74:	810080e7          	jalr	-2032(ra) # 80003680 <_Znwm>
    80005e78:	00050a93          	mv	s5,a0
    80005e7c:	00048593          	mv	a1,s1
    80005e80:	fffff097          	auipc	ra,0xfffff
    80005e84:	3c4080e7          	jalr	964(ra) # 80005244 <_ZN9BufferCPPC1Ei>
    80005e88:	0300006f          	j	80005eb8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005e8c:	00004517          	auipc	a0,0x4
    80005e90:	88450513          	addi	a0,a0,-1916 # 80009710 <CONSOLE_STATUS+0x700>
    80005e94:	ffffd097          	auipc	ra,0xffffd
    80005e98:	9c4080e7          	jalr	-1596(ra) # 80002858 <_Z11printStringPKc>
            return;
    80005e9c:	0140006f          	j	80005eb0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005ea0:	00004517          	auipc	a0,0x4
    80005ea4:	8b050513          	addi	a0,a0,-1872 # 80009750 <CONSOLE_STATUS+0x740>
    80005ea8:	ffffd097          	auipc	ra,0xffffd
    80005eac:	9b0080e7          	jalr	-1616(ra) # 80002858 <_Z11printStringPKc>
            return;
    80005eb0:	000c0113          	mv	sp,s8
    80005eb4:	21c0006f          	j	800060d0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    80005eb8:	01000513          	li	a0,16
    80005ebc:	ffffd097          	auipc	ra,0xffffd
    80005ec0:	7c4080e7          	jalr	1988(ra) # 80003680 <_Znwm>
    80005ec4:	00050493          	mv	s1,a0
    80005ec8:	00000593          	li	a1,0
    80005ecc:	ffffe097          	auipc	ra,0xffffe
    80005ed0:	8ac080e7          	jalr	-1876(ra) # 80003778 <_ZN9SemaphoreC1Ej>
    80005ed4:	00006717          	auipc	a4,0x6
    80005ed8:	1c470713          	addi	a4,a4,452 # 8000c098 <finishedA>
    80005edc:	00973c23          	sd	s1,24(a4)
        Thread *producers[threadNum];
    80005ee0:	00399793          	slli	a5,s3,0x3
    80005ee4:	00f78793          	addi	a5,a5,15
    80005ee8:	ff07f793          	andi	a5,a5,-16
    80005eec:	40f10133          	sub	sp,sp,a5
    80005ef0:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80005ef4:	0019869b          	addiw	a3,s3,1
    80005ef8:	00169793          	slli	a5,a3,0x1
    80005efc:	00d787b3          	add	a5,a5,a3
    80005f00:	00379793          	slli	a5,a5,0x3
    80005f04:	00f78793          	addi	a5,a5,15
    80005f08:	ff07f793          	andi	a5,a5,-16
    80005f0c:	40f10133          	sub	sp,sp,a5
    80005f10:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80005f14:	00199493          	slli	s1,s3,0x1
    80005f18:	013484b3          	add	s1,s1,s3
    80005f1c:	00349493          	slli	s1,s1,0x3
    80005f20:	009b04b3          	add	s1,s6,s1
    80005f24:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005f28:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005f2c:	01873783          	ld	a5,24(a4)
    80005f30:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005f34:	01800513          	li	a0,24
    80005f38:	ffffd097          	auipc	ra,0xffffd
    80005f3c:	748080e7          	jalr	1864(ra) # 80003680 <_Znwm>
    80005f40:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005f44:	ffffe097          	auipc	ra,0xffffe
    80005f48:	8fc080e7          	jalr	-1796(ra) # 80003840 <_ZN6ThreadC1Ev>
    80005f4c:	00006797          	auipc	a5,0x6
    80005f50:	dfc78793          	addi	a5,a5,-516 # 8000bd48 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005f54:	00fbb023          	sd	a5,0(s7)
    80005f58:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005f5c:	000b8513          	mv	a0,s7
    80005f60:	ffffe097          	auipc	ra,0xffffe
    80005f64:	9b4080e7          	jalr	-1612(ra) # 80003914 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005f68:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005f6c:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005f70:	00006797          	auipc	a5,0x6
    80005f74:	1407b783          	ld	a5,320(a5) # 8000c0b0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005f78:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005f7c:	01800513          	li	a0,24
    80005f80:	ffffd097          	auipc	ra,0xffffd
    80005f84:	700080e7          	jalr	1792(ra) # 80003680 <_Znwm>
    80005f88:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005f8c:	ffffe097          	auipc	ra,0xffffe
    80005f90:	8b4080e7          	jalr	-1868(ra) # 80003840 <_ZN6ThreadC1Ev>
    80005f94:	00006797          	auipc	a5,0x6
    80005f98:	d6478793          	addi	a5,a5,-668 # 8000bcf8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005f9c:	00f4b023          	sd	a5,0(s1)
    80005fa0:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005fa4:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80005fa8:	00048513          	mv	a0,s1
    80005fac:	ffffe097          	auipc	ra,0xffffe
    80005fb0:	968080e7          	jalr	-1688(ra) # 80003914 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005fb4:	00100913          	li	s2,1
    80005fb8:	0300006f          	j	80005fe8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005fbc:	00006797          	auipc	a5,0x6
    80005fc0:	d6478793          	addi	a5,a5,-668 # 8000bd20 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005fc4:	00fcb023          	sd	a5,0(s9)
    80005fc8:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80005fcc:	00391793          	slli	a5,s2,0x3
    80005fd0:	00fa07b3          	add	a5,s4,a5
    80005fd4:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80005fd8:	000c8513          	mv	a0,s9
    80005fdc:	ffffe097          	auipc	ra,0xffffe
    80005fe0:	938080e7          	jalr	-1736(ra) # 80003914 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005fe4:	0019091b          	addiw	s2,s2,1
    80005fe8:	05395263          	bge	s2,s3,8000602c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80005fec:	00191493          	slli	s1,s2,0x1
    80005ff0:	012484b3          	add	s1,s1,s2
    80005ff4:	00349493          	slli	s1,s1,0x3
    80005ff8:	009b04b3          	add	s1,s6,s1
    80005ffc:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80006000:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80006004:	00006797          	auipc	a5,0x6
    80006008:	0ac7b783          	ld	a5,172(a5) # 8000c0b0 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000600c:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80006010:	01800513          	li	a0,24
    80006014:	ffffd097          	auipc	ra,0xffffd
    80006018:	66c080e7          	jalr	1644(ra) # 80003680 <_Znwm>
    8000601c:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006020:	ffffe097          	auipc	ra,0xffffe
    80006024:	820080e7          	jalr	-2016(ra) # 80003840 <_ZN6ThreadC1Ev>
    80006028:	f95ff06f          	j	80005fbc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    8000602c:	ffffe097          	auipc	ra,0xffffe
    80006030:	8c0080e7          	jalr	-1856(ra) # 800038ec <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80006034:	00000493          	li	s1,0
    80006038:	0099ce63          	blt	s3,s1,80006054 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    8000603c:	00006517          	auipc	a0,0x6
    80006040:	07453503          	ld	a0,116(a0) # 8000c0b0 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006044:	ffffd097          	auipc	ra,0xffffd
    80006048:	76c080e7          	jalr	1900(ra) # 800037b0 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    8000604c:	0014849b          	addiw	s1,s1,1
    80006050:	fe9ff06f          	j	80006038 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80006054:	00006517          	auipc	a0,0x6
    80006058:	05c53503          	ld	a0,92(a0) # 8000c0b0 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000605c:	00050863          	beqz	a0,8000606c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80006060:	00053783          	ld	a5,0(a0)
    80006064:	0087b783          	ld	a5,8(a5)
    80006068:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8000606c:	00000493          	li	s1,0
    80006070:	0080006f          	j	80006078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80006074:	0014849b          	addiw	s1,s1,1
    80006078:	0334d263          	bge	s1,s3,8000609c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    8000607c:	00349793          	slli	a5,s1,0x3
    80006080:	00fa07b3          	add	a5,s4,a5
    80006084:	0007b503          	ld	a0,0(a5)
    80006088:	fe0506e3          	beqz	a0,80006074 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    8000608c:	00053783          	ld	a5,0(a0)
    80006090:	0087b783          	ld	a5,8(a5)
    80006094:	000780e7          	jalr	a5
    80006098:	fddff06f          	j	80006074 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    8000609c:	000b8a63          	beqz	s7,800060b0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    800060a0:	000bb783          	ld	a5,0(s7)
    800060a4:	0087b783          	ld	a5,8(a5)
    800060a8:	000b8513          	mv	a0,s7
    800060ac:	000780e7          	jalr	a5
        delete buffer;
    800060b0:	000a8e63          	beqz	s5,800060cc <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    800060b4:	000a8513          	mv	a0,s5
    800060b8:	fffff097          	auipc	ra,0xfffff
    800060bc:	484080e7          	jalr	1156(ra) # 8000553c <_ZN9BufferCPPD1Ev>
    800060c0:	000a8513          	mv	a0,s5
    800060c4:	ffffd097          	auipc	ra,0xffffd
    800060c8:	60c080e7          	jalr	1548(ra) # 800036d0 <_ZdlPv>
    800060cc:	000c0113          	mv	sp,s8
    }
    800060d0:	f8040113          	addi	sp,s0,-128
    800060d4:	07813083          	ld	ra,120(sp)
    800060d8:	07013403          	ld	s0,112(sp)
    800060dc:	06813483          	ld	s1,104(sp)
    800060e0:	06013903          	ld	s2,96(sp)
    800060e4:	05813983          	ld	s3,88(sp)
    800060e8:	05013a03          	ld	s4,80(sp)
    800060ec:	04813a83          	ld	s5,72(sp)
    800060f0:	04013b03          	ld	s6,64(sp)
    800060f4:	03813b83          	ld	s7,56(sp)
    800060f8:	03013c03          	ld	s8,48(sp)
    800060fc:	02813c83          	ld	s9,40(sp)
    80006100:	08010113          	addi	sp,sp,128
    80006104:	00008067          	ret
    80006108:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    8000610c:	000a8513          	mv	a0,s5
    80006110:	ffffd097          	auipc	ra,0xffffd
    80006114:	5c0080e7          	jalr	1472(ra) # 800036d0 <_ZdlPv>
    80006118:	00048513          	mv	a0,s1
    8000611c:	00007097          	auipc	ra,0x7
    80006120:	06c080e7          	jalr	108(ra) # 8000d188 <_Unwind_Resume>
    80006124:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80006128:	00048513          	mv	a0,s1
    8000612c:	ffffd097          	auipc	ra,0xffffd
    80006130:	5a4080e7          	jalr	1444(ra) # 800036d0 <_ZdlPv>
    80006134:	00090513          	mv	a0,s2
    80006138:	00007097          	auipc	ra,0x7
    8000613c:	050080e7          	jalr	80(ra) # 8000d188 <_Unwind_Resume>
    80006140:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80006144:	000b8513          	mv	a0,s7
    80006148:	ffffd097          	auipc	ra,0xffffd
    8000614c:	588080e7          	jalr	1416(ra) # 800036d0 <_ZdlPv>
    80006150:	00048513          	mv	a0,s1
    80006154:	00007097          	auipc	ra,0x7
    80006158:	034080e7          	jalr	52(ra) # 8000d188 <_Unwind_Resume>
    8000615c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006160:	00048513          	mv	a0,s1
    80006164:	ffffd097          	auipc	ra,0xffffd
    80006168:	56c080e7          	jalr	1388(ra) # 800036d0 <_ZdlPv>
    8000616c:	00090513          	mv	a0,s2
    80006170:	00007097          	auipc	ra,0x7
    80006174:	018080e7          	jalr	24(ra) # 8000d188 <_Unwind_Resume>
    80006178:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8000617c:	000c8513          	mv	a0,s9
    80006180:	ffffd097          	auipc	ra,0xffffd
    80006184:	550080e7          	jalr	1360(ra) # 800036d0 <_ZdlPv>
    80006188:	00048513          	mv	a0,s1
    8000618c:	00007097          	auipc	ra,0x7
    80006190:	ffc080e7          	jalr	-4(ra) # 8000d188 <_Unwind_Resume>

0000000080006194 <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80006194:	ff010113          	addi	sp,sp,-16
    80006198:	00113423          	sd	ra,8(sp)
    8000619c:	00813023          	sd	s0,0(sp)
    800061a0:	01010413          	addi	s0,sp,16
//    Threads_CPP_API_test(); // zadatak 2., niti CPP API i sinhrona promena konteksta

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    testSleeping(); // thread_sleep test C API
    800061a4:	00000097          	auipc	ra,0x0
    800061a8:	b44080e7          	jalr	-1212(ra) # 80005ce8 <_Z12testSleepingv>
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    800061ac:	00000097          	auipc	ra,0x0
    800061b0:	bc4080e7          	jalr	-1084(ra) # 80005d70 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>

    800061b4:	00813083          	ld	ra,8(sp)
    800061b8:	00013403          	ld	s0,0(sp)
    800061bc:	01010113          	addi	sp,sp,16
    800061c0:	00008067          	ret

00000000800061c4 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    800061c4:	fd010113          	addi	sp,sp,-48
    800061c8:	02113423          	sd	ra,40(sp)
    800061cc:	02813023          	sd	s0,32(sp)
    800061d0:	00913c23          	sd	s1,24(sp)
    800061d4:	01213823          	sd	s2,16(sp)
    800061d8:	01313423          	sd	s3,8(sp)
    800061dc:	03010413          	addi	s0,sp,48
    800061e0:	00050913          	mv	s2,a0
            int i = 0;
    800061e4:	00000993          	li	s3,0
    800061e8:	0100006f          	j	800061f8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    800061ec:	00a00513          	li	a0,10
    800061f0:	ffffd097          	auipc	ra,0xffffd
    800061f4:	7e8080e7          	jalr	2024(ra) # 800039d8 <_ZN7Console4putcEc>
            while (!threadEnd) {
    800061f8:	00006797          	auipc	a5,0x6
    800061fc:	eac7a783          	lw	a5,-340(a5) # 8000c0a4 <_ZN19ConsumerProducerCPP9threadEndE>
    80006200:	04079a63          	bnez	a5,80006254 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80006204:	01093783          	ld	a5,16(s2)
    80006208:	0087b503          	ld	a0,8(a5)
    8000620c:	fffff097          	auipc	ra,0xfffff
    80006210:	21c080e7          	jalr	540(ra) # 80005428 <_ZN9BufferCPP3getEv>
                i++;
    80006214:	0019849b          	addiw	s1,s3,1
    80006218:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    8000621c:	0ff57513          	andi	a0,a0,255
    80006220:	ffffd097          	auipc	ra,0xffffd
    80006224:	7b8080e7          	jalr	1976(ra) # 800039d8 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80006228:	05000793          	li	a5,80
    8000622c:	02f4e4bb          	remw	s1,s1,a5
    80006230:	fc0494e3          	bnez	s1,800061f8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80006234:	fb9ff06f          	j	800061ec <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80006238:	01093783          	ld	a5,16(s2)
    8000623c:	0087b503          	ld	a0,8(a5)
    80006240:	fffff097          	auipc	ra,0xfffff
    80006244:	1e8080e7          	jalr	488(ra) # 80005428 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80006248:	0ff57513          	andi	a0,a0,255
    8000624c:	ffffd097          	auipc	ra,0xffffd
    80006250:	78c080e7          	jalr	1932(ra) # 800039d8 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80006254:	01093783          	ld	a5,16(s2)
    80006258:	0087b503          	ld	a0,8(a5)
    8000625c:	fffff097          	auipc	ra,0xfffff
    80006260:	258080e7          	jalr	600(ra) # 800054b4 <_ZN9BufferCPP6getCntEv>
    80006264:	fca04ae3          	bgtz	a0,80006238 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80006268:	01093783          	ld	a5,16(s2)
    8000626c:	0107b503          	ld	a0,16(a5)
    80006270:	ffffd097          	auipc	ra,0xffffd
    80006274:	56c080e7          	jalr	1388(ra) # 800037dc <_ZN9Semaphore6signalEv>
        }
    80006278:	02813083          	ld	ra,40(sp)
    8000627c:	02013403          	ld	s0,32(sp)
    80006280:	01813483          	ld	s1,24(sp)
    80006284:	01013903          	ld	s2,16(sp)
    80006288:	00813983          	ld	s3,8(sp)
    8000628c:	03010113          	addi	sp,sp,48
    80006290:	00008067          	ret

0000000080006294 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006294:	ff010113          	addi	sp,sp,-16
    80006298:	00113423          	sd	ra,8(sp)
    8000629c:	00813023          	sd	s0,0(sp)
    800062a0:	01010413          	addi	s0,sp,16
    800062a4:	00006797          	auipc	a5,0x6
    800062a8:	aa478793          	addi	a5,a5,-1372 # 8000bd48 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800062ac:	00f53023          	sd	a5,0(a0)
    800062b0:	ffffd097          	auipc	ra,0xffffd
    800062b4:	390080e7          	jalr	912(ra) # 80003640 <_ZN6ThreadD1Ev>
    800062b8:	00813083          	ld	ra,8(sp)
    800062bc:	00013403          	ld	s0,0(sp)
    800062c0:	01010113          	addi	sp,sp,16
    800062c4:	00008067          	ret

00000000800062c8 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    800062c8:	fe010113          	addi	sp,sp,-32
    800062cc:	00113c23          	sd	ra,24(sp)
    800062d0:	00813823          	sd	s0,16(sp)
    800062d4:	00913423          	sd	s1,8(sp)
    800062d8:	02010413          	addi	s0,sp,32
    800062dc:	00050493          	mv	s1,a0
    800062e0:	00006797          	auipc	a5,0x6
    800062e4:	a6878793          	addi	a5,a5,-1432 # 8000bd48 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800062e8:	00f53023          	sd	a5,0(a0)
    800062ec:	ffffd097          	auipc	ra,0xffffd
    800062f0:	354080e7          	jalr	852(ra) # 80003640 <_ZN6ThreadD1Ev>
    800062f4:	00048513          	mv	a0,s1
    800062f8:	ffffd097          	auipc	ra,0xffffd
    800062fc:	3d8080e7          	jalr	984(ra) # 800036d0 <_ZdlPv>
    80006300:	01813083          	ld	ra,24(sp)
    80006304:	01013403          	ld	s0,16(sp)
    80006308:	00813483          	ld	s1,8(sp)
    8000630c:	02010113          	addi	sp,sp,32
    80006310:	00008067          	ret

0000000080006314 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80006314:	ff010113          	addi	sp,sp,-16
    80006318:	00113423          	sd	ra,8(sp)
    8000631c:	00813023          	sd	s0,0(sp)
    80006320:	01010413          	addi	s0,sp,16
    80006324:	00006797          	auipc	a5,0x6
    80006328:	9d478793          	addi	a5,a5,-1580 # 8000bcf8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    8000632c:	00f53023          	sd	a5,0(a0)
    80006330:	ffffd097          	auipc	ra,0xffffd
    80006334:	310080e7          	jalr	784(ra) # 80003640 <_ZN6ThreadD1Ev>
    80006338:	00813083          	ld	ra,8(sp)
    8000633c:	00013403          	ld	s0,0(sp)
    80006340:	01010113          	addi	sp,sp,16
    80006344:	00008067          	ret

0000000080006348 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80006348:	fe010113          	addi	sp,sp,-32
    8000634c:	00113c23          	sd	ra,24(sp)
    80006350:	00813823          	sd	s0,16(sp)
    80006354:	00913423          	sd	s1,8(sp)
    80006358:	02010413          	addi	s0,sp,32
    8000635c:	00050493          	mv	s1,a0
    80006360:	00006797          	auipc	a5,0x6
    80006364:	99878793          	addi	a5,a5,-1640 # 8000bcf8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006368:	00f53023          	sd	a5,0(a0)
    8000636c:	ffffd097          	auipc	ra,0xffffd
    80006370:	2d4080e7          	jalr	724(ra) # 80003640 <_ZN6ThreadD1Ev>
    80006374:	00048513          	mv	a0,s1
    80006378:	ffffd097          	auipc	ra,0xffffd
    8000637c:	358080e7          	jalr	856(ra) # 800036d0 <_ZdlPv>
    80006380:	01813083          	ld	ra,24(sp)
    80006384:	01013403          	ld	s0,16(sp)
    80006388:	00813483          	ld	s1,8(sp)
    8000638c:	02010113          	addi	sp,sp,32
    80006390:	00008067          	ret

0000000080006394 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006394:	ff010113          	addi	sp,sp,-16
    80006398:	00113423          	sd	ra,8(sp)
    8000639c:	00813023          	sd	s0,0(sp)
    800063a0:	01010413          	addi	s0,sp,16
    800063a4:	00006797          	auipc	a5,0x6
    800063a8:	97c78793          	addi	a5,a5,-1668 # 8000bd20 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800063ac:	00f53023          	sd	a5,0(a0)
    800063b0:	ffffd097          	auipc	ra,0xffffd
    800063b4:	290080e7          	jalr	656(ra) # 80003640 <_ZN6ThreadD1Ev>
    800063b8:	00813083          	ld	ra,8(sp)
    800063bc:	00013403          	ld	s0,0(sp)
    800063c0:	01010113          	addi	sp,sp,16
    800063c4:	00008067          	ret

00000000800063c8 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    800063c8:	fe010113          	addi	sp,sp,-32
    800063cc:	00113c23          	sd	ra,24(sp)
    800063d0:	00813823          	sd	s0,16(sp)
    800063d4:	00913423          	sd	s1,8(sp)
    800063d8:	02010413          	addi	s0,sp,32
    800063dc:	00050493          	mv	s1,a0
    800063e0:	00006797          	auipc	a5,0x6
    800063e4:	94078793          	addi	a5,a5,-1728 # 8000bd20 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800063e8:	00f53023          	sd	a5,0(a0)
    800063ec:	ffffd097          	auipc	ra,0xffffd
    800063f0:	254080e7          	jalr	596(ra) # 80003640 <_ZN6ThreadD1Ev>
    800063f4:	00048513          	mv	a0,s1
    800063f8:	ffffd097          	auipc	ra,0xffffd
    800063fc:	2d8080e7          	jalr	728(ra) # 800036d0 <_ZdlPv>
    80006400:	01813083          	ld	ra,24(sp)
    80006404:	01013403          	ld	s0,16(sp)
    80006408:	00813483          	ld	s1,8(sp)
    8000640c:	02010113          	addi	sp,sp,32
    80006410:	00008067          	ret

0000000080006414 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80006414:	fe010113          	addi	sp,sp,-32
    80006418:	00113c23          	sd	ra,24(sp)
    8000641c:	00813823          	sd	s0,16(sp)
    80006420:	00913423          	sd	s1,8(sp)
    80006424:	02010413          	addi	s0,sp,32
    80006428:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    8000642c:	ffffc097          	auipc	ra,0xffffc
    80006430:	c44080e7          	jalr	-956(ra) # 80002070 <_Z4getcv>
    80006434:	0005059b          	sext.w	a1,a0
    80006438:	01b00793          	li	a5,27
    8000643c:	00f58c63          	beq	a1,a5,80006454 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80006440:	0104b783          	ld	a5,16(s1)
    80006444:	0087b503          	ld	a0,8(a5)
    80006448:	fffff097          	auipc	ra,0xfffff
    8000644c:	f50080e7          	jalr	-176(ra) # 80005398 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80006450:	fddff06f          	j	8000642c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80006454:	00100793          	li	a5,1
    80006458:	00006717          	auipc	a4,0x6
    8000645c:	c4f72623          	sw	a5,-948(a4) # 8000c0a4 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80006460:	0104b783          	ld	a5,16(s1)
    80006464:	02100593          	li	a1,33
    80006468:	0087b503          	ld	a0,8(a5)
    8000646c:	fffff097          	auipc	ra,0xfffff
    80006470:	f2c080e7          	jalr	-212(ra) # 80005398 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80006474:	0104b783          	ld	a5,16(s1)
    80006478:	0107b503          	ld	a0,16(a5)
    8000647c:	ffffd097          	auipc	ra,0xffffd
    80006480:	360080e7          	jalr	864(ra) # 800037dc <_ZN9Semaphore6signalEv>
        }
    80006484:	01813083          	ld	ra,24(sp)
    80006488:	01013403          	ld	s0,16(sp)
    8000648c:	00813483          	ld	s1,8(sp)
    80006490:	02010113          	addi	sp,sp,32
    80006494:	00008067          	ret

0000000080006498 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006498:	fe010113          	addi	sp,sp,-32
    8000649c:	00113c23          	sd	ra,24(sp)
    800064a0:	00813823          	sd	s0,16(sp)
    800064a4:	00913423          	sd	s1,8(sp)
    800064a8:	01213023          	sd	s2,0(sp)
    800064ac:	02010413          	addi	s0,sp,32
    800064b0:	00050493          	mv	s1,a0
            int i = 0;
    800064b4:	00000913          	li	s2,0
            while (!threadEnd) {
    800064b8:	00006797          	auipc	a5,0x6
    800064bc:	bec7a783          	lw	a5,-1044(a5) # 8000c0a4 <_ZN19ConsumerProducerCPP9threadEndE>
    800064c0:	04079263          	bnez	a5,80006504 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    800064c4:	0104b783          	ld	a5,16(s1)
    800064c8:	0007a583          	lw	a1,0(a5)
    800064cc:	0305859b          	addiw	a1,a1,48
    800064d0:	0087b503          	ld	a0,8(a5)
    800064d4:	fffff097          	auipc	ra,0xfffff
    800064d8:	ec4080e7          	jalr	-316(ra) # 80005398 <_ZN9BufferCPP3putEi>
                i++;
    800064dc:	0019071b          	addiw	a4,s2,1
    800064e0:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    800064e4:	0104b783          	ld	a5,16(s1)
    800064e8:	0007a783          	lw	a5,0(a5)
    800064ec:	00e787bb          	addw	a5,a5,a4
    800064f0:	00500513          	li	a0,5
    800064f4:	02a7e53b          	remw	a0,a5,a0
    800064f8:	ffffd097          	auipc	ra,0xffffd
    800064fc:	38c080e7          	jalr	908(ra) # 80003884 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006500:	fb9ff06f          	j	800064b8 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80006504:	0104b783          	ld	a5,16(s1)
    80006508:	0107b503          	ld	a0,16(a5)
    8000650c:	ffffd097          	auipc	ra,0xffffd
    80006510:	2d0080e7          	jalr	720(ra) # 800037dc <_ZN9Semaphore6signalEv>
        }
    80006514:	01813083          	ld	ra,24(sp)
    80006518:	01013403          	ld	s0,16(sp)
    8000651c:	00813483          	ld	s1,8(sp)
    80006520:	00013903          	ld	s2,0(sp)
    80006524:	02010113          	addi	sp,sp,32
    80006528:	00008067          	ret

000000008000652c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000652c:	fe010113          	addi	sp,sp,-32
    80006530:	00113c23          	sd	ra,24(sp)
    80006534:	00813823          	sd	s0,16(sp)
    80006538:	00913423          	sd	s1,8(sp)
    8000653c:	01213023          	sd	s2,0(sp)
    80006540:	02010413          	addi	s0,sp,32
    80006544:	00050493          	mv	s1,a0
    80006548:	00058913          	mv	s2,a1
    8000654c:	0015879b          	addiw	a5,a1,1
    80006550:	0007851b          	sext.w	a0,a5
    80006554:	00f4a023          	sw	a5,0(s1)
    80006558:	0004a823          	sw	zero,16(s1)
    8000655c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006560:	00251513          	slli	a0,a0,0x2
    80006564:	ffffc097          	auipc	ra,0xffffc
    80006568:	85c080e7          	jalr	-1956(ra) # 80001dc0 <_Z9mem_allocm>
    8000656c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006570:	00000593          	li	a1,0
    80006574:	02048513          	addi	a0,s1,32
    80006578:	ffffc097          	auipc	ra,0xffffc
    8000657c:	a10080e7          	jalr	-1520(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006580:	00090593          	mv	a1,s2
    80006584:	01848513          	addi	a0,s1,24
    80006588:	ffffc097          	auipc	ra,0xffffc
    8000658c:	a00080e7          	jalr	-1536(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006590:	00100593          	li	a1,1
    80006594:	02848513          	addi	a0,s1,40
    80006598:	ffffc097          	auipc	ra,0xffffc
    8000659c:	9f0080e7          	jalr	-1552(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    800065a0:	00100593          	li	a1,1
    800065a4:	03048513          	addi	a0,s1,48
    800065a8:	ffffc097          	auipc	ra,0xffffc
    800065ac:	9e0080e7          	jalr	-1568(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
}
    800065b0:	01813083          	ld	ra,24(sp)
    800065b4:	01013403          	ld	s0,16(sp)
    800065b8:	00813483          	ld	s1,8(sp)
    800065bc:	00013903          	ld	s2,0(sp)
    800065c0:	02010113          	addi	sp,sp,32
    800065c4:	00008067          	ret

00000000800065c8 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800065c8:	fe010113          	addi	sp,sp,-32
    800065cc:	00113c23          	sd	ra,24(sp)
    800065d0:	00813823          	sd	s0,16(sp)
    800065d4:	00913423          	sd	s1,8(sp)
    800065d8:	01213023          	sd	s2,0(sp)
    800065dc:	02010413          	addi	s0,sp,32
    800065e0:	00050493          	mv	s1,a0
    800065e4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800065e8:	01853503          	ld	a0,24(a0)
    800065ec:	ffffc097          	auipc	ra,0xffffc
    800065f0:	a00080e7          	jalr	-1536(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    800065f4:	0304b503          	ld	a0,48(s1)
    800065f8:	ffffc097          	auipc	ra,0xffffc
    800065fc:	9f4080e7          	jalr	-1548(ra) # 80001fec <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80006600:	0084b783          	ld	a5,8(s1)
    80006604:	0144a703          	lw	a4,20(s1)
    80006608:	00271713          	slli	a4,a4,0x2
    8000660c:	00e787b3          	add	a5,a5,a4
    80006610:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006614:	0144a783          	lw	a5,20(s1)
    80006618:	0017879b          	addiw	a5,a5,1
    8000661c:	0004a703          	lw	a4,0(s1)
    80006620:	02e7e7bb          	remw	a5,a5,a4
    80006624:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006628:	0304b503          	ld	a0,48(s1)
    8000662c:	ffffc097          	auipc	ra,0xffffc
    80006630:	9ec080e7          	jalr	-1556(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80006634:	0204b503          	ld	a0,32(s1)
    80006638:	ffffc097          	auipc	ra,0xffffc
    8000663c:	9e0080e7          	jalr	-1568(ra) # 80002018 <_Z10sem_signalP10_semaphore>

}
    80006640:	01813083          	ld	ra,24(sp)
    80006644:	01013403          	ld	s0,16(sp)
    80006648:	00813483          	ld	s1,8(sp)
    8000664c:	00013903          	ld	s2,0(sp)
    80006650:	02010113          	addi	sp,sp,32
    80006654:	00008067          	ret

0000000080006658 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006658:	fe010113          	addi	sp,sp,-32
    8000665c:	00113c23          	sd	ra,24(sp)
    80006660:	00813823          	sd	s0,16(sp)
    80006664:	00913423          	sd	s1,8(sp)
    80006668:	01213023          	sd	s2,0(sp)
    8000666c:	02010413          	addi	s0,sp,32
    80006670:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006674:	02053503          	ld	a0,32(a0)
    80006678:	ffffc097          	auipc	ra,0xffffc
    8000667c:	974080e7          	jalr	-1676(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006680:	0284b503          	ld	a0,40(s1)
    80006684:	ffffc097          	auipc	ra,0xffffc
    80006688:	968080e7          	jalr	-1688(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    8000668c:	0084b703          	ld	a4,8(s1)
    80006690:	0104a783          	lw	a5,16(s1)
    80006694:	00279693          	slli	a3,a5,0x2
    80006698:	00d70733          	add	a4,a4,a3
    8000669c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800066a0:	0017879b          	addiw	a5,a5,1
    800066a4:	0004a703          	lw	a4,0(s1)
    800066a8:	02e7e7bb          	remw	a5,a5,a4
    800066ac:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800066b0:	0284b503          	ld	a0,40(s1)
    800066b4:	ffffc097          	auipc	ra,0xffffc
    800066b8:	964080e7          	jalr	-1692(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    800066bc:	0184b503          	ld	a0,24(s1)
    800066c0:	ffffc097          	auipc	ra,0xffffc
    800066c4:	958080e7          	jalr	-1704(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    return ret;
}
    800066c8:	00090513          	mv	a0,s2
    800066cc:	01813083          	ld	ra,24(sp)
    800066d0:	01013403          	ld	s0,16(sp)
    800066d4:	00813483          	ld	s1,8(sp)
    800066d8:	00013903          	ld	s2,0(sp)
    800066dc:	02010113          	addi	sp,sp,32
    800066e0:	00008067          	ret

00000000800066e4 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800066e4:	fe010113          	addi	sp,sp,-32
    800066e8:	00113c23          	sd	ra,24(sp)
    800066ec:	00813823          	sd	s0,16(sp)
    800066f0:	00913423          	sd	s1,8(sp)
    800066f4:	01213023          	sd	s2,0(sp)
    800066f8:	02010413          	addi	s0,sp,32
    800066fc:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006700:	02853503          	ld	a0,40(a0)
    80006704:	ffffc097          	auipc	ra,0xffffc
    80006708:	8e8080e7          	jalr	-1816(ra) # 80001fec <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    8000670c:	0304b503          	ld	a0,48(s1)
    80006710:	ffffc097          	auipc	ra,0xffffc
    80006714:	8dc080e7          	jalr	-1828(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80006718:	0144a783          	lw	a5,20(s1)
    8000671c:	0104a903          	lw	s2,16(s1)
    80006720:	0327ce63          	blt	a5,s2,8000675c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006724:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006728:	0304b503          	ld	a0,48(s1)
    8000672c:	ffffc097          	auipc	ra,0xffffc
    80006730:	8ec080e7          	jalr	-1812(ra) # 80002018 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006734:	0284b503          	ld	a0,40(s1)
    80006738:	ffffc097          	auipc	ra,0xffffc
    8000673c:	8e0080e7          	jalr	-1824(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006740:	00090513          	mv	a0,s2
    80006744:	01813083          	ld	ra,24(sp)
    80006748:	01013403          	ld	s0,16(sp)
    8000674c:	00813483          	ld	s1,8(sp)
    80006750:	00013903          	ld	s2,0(sp)
    80006754:	02010113          	addi	sp,sp,32
    80006758:	00008067          	ret
        ret = cap - head + tail;
    8000675c:	0004a703          	lw	a4,0(s1)
    80006760:	4127093b          	subw	s2,a4,s2
    80006764:	00f9093b          	addw	s2,s2,a5
    80006768:	fc1ff06f          	j	80006728 <_ZN6Buffer6getCntEv+0x44>

000000008000676c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000676c:	fe010113          	addi	sp,sp,-32
    80006770:	00113c23          	sd	ra,24(sp)
    80006774:	00813823          	sd	s0,16(sp)
    80006778:	00913423          	sd	s1,8(sp)
    8000677c:	02010413          	addi	s0,sp,32
    80006780:	00050493          	mv	s1,a0
    putc('\n');
    80006784:	00a00513          	li	a0,10
    80006788:	ffffc097          	auipc	ra,0xffffc
    8000678c:	910080e7          	jalr	-1776(ra) # 80002098 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006790:	00003517          	auipc	a0,0x3
    80006794:	df050513          	addi	a0,a0,-528 # 80009580 <CONSOLE_STATUS+0x570>
    80006798:	ffffc097          	auipc	ra,0xffffc
    8000679c:	0c0080e7          	jalr	192(ra) # 80002858 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800067a0:	00048513          	mv	a0,s1
    800067a4:	00000097          	auipc	ra,0x0
    800067a8:	f40080e7          	jalr	-192(ra) # 800066e4 <_ZN6Buffer6getCntEv>
    800067ac:	02a05c63          	blez	a0,800067e4 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800067b0:	0084b783          	ld	a5,8(s1)
    800067b4:	0104a703          	lw	a4,16(s1)
    800067b8:	00271713          	slli	a4,a4,0x2
    800067bc:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800067c0:	0007c503          	lbu	a0,0(a5)
    800067c4:	ffffc097          	auipc	ra,0xffffc
    800067c8:	8d4080e7          	jalr	-1836(ra) # 80002098 <_Z4putcc>
        head = (head + 1) % cap;
    800067cc:	0104a783          	lw	a5,16(s1)
    800067d0:	0017879b          	addiw	a5,a5,1
    800067d4:	0004a703          	lw	a4,0(s1)
    800067d8:	02e7e7bb          	remw	a5,a5,a4
    800067dc:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800067e0:	fc1ff06f          	j	800067a0 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800067e4:	02100513          	li	a0,33
    800067e8:	ffffc097          	auipc	ra,0xffffc
    800067ec:	8b0080e7          	jalr	-1872(ra) # 80002098 <_Z4putcc>
    putc('\n');
    800067f0:	00a00513          	li	a0,10
    800067f4:	ffffc097          	auipc	ra,0xffffc
    800067f8:	8a4080e7          	jalr	-1884(ra) # 80002098 <_Z4putcc>
    mem_free(buffer);
    800067fc:	0084b503          	ld	a0,8(s1)
    80006800:	ffffb097          	auipc	ra,0xffffb
    80006804:	5f0080e7          	jalr	1520(ra) # 80001df0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006808:	0204b503          	ld	a0,32(s1)
    8000680c:	ffffb097          	auipc	ra,0xffffb
    80006810:	7b4080e7          	jalr	1972(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006814:	0184b503          	ld	a0,24(s1)
    80006818:	ffffb097          	auipc	ra,0xffffb
    8000681c:	7a8080e7          	jalr	1960(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80006820:	0304b503          	ld	a0,48(s1)
    80006824:	ffffb097          	auipc	ra,0xffffb
    80006828:	79c080e7          	jalr	1948(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    8000682c:	0284b503          	ld	a0,40(s1)
    80006830:	ffffb097          	auipc	ra,0xffffb
    80006834:	790080e7          	jalr	1936(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
}
    80006838:	01813083          	ld	ra,24(sp)
    8000683c:	01013403          	ld	s0,16(sp)
    80006840:	00813483          	ld	s1,8(sp)
    80006844:	02010113          	addi	sp,sp,32
    80006848:	00008067          	ret

000000008000684c <start>:
    8000684c:	ff010113          	addi	sp,sp,-16
    80006850:	00813423          	sd	s0,8(sp)
    80006854:	01010413          	addi	s0,sp,16
    80006858:	300027f3          	csrr	a5,mstatus
    8000685c:	ffffe737          	lui	a4,0xffffe
    80006860:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff14df>
    80006864:	00e7f7b3          	and	a5,a5,a4
    80006868:	00001737          	lui	a4,0x1
    8000686c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006870:	00e7e7b3          	or	a5,a5,a4
    80006874:	30079073          	csrw	mstatus,a5
    80006878:	00000797          	auipc	a5,0x0
    8000687c:	16078793          	addi	a5,a5,352 # 800069d8 <system_main>
    80006880:	34179073          	csrw	mepc,a5
    80006884:	00000793          	li	a5,0
    80006888:	18079073          	csrw	satp,a5
    8000688c:	000107b7          	lui	a5,0x10
    80006890:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006894:	30279073          	csrw	medeleg,a5
    80006898:	30379073          	csrw	mideleg,a5
    8000689c:	104027f3          	csrr	a5,sie
    800068a0:	2227e793          	ori	a5,a5,546
    800068a4:	10479073          	csrw	sie,a5
    800068a8:	fff00793          	li	a5,-1
    800068ac:	00a7d793          	srli	a5,a5,0xa
    800068b0:	3b079073          	csrw	pmpaddr0,a5
    800068b4:	00f00793          	li	a5,15
    800068b8:	3a079073          	csrw	pmpcfg0,a5
    800068bc:	f14027f3          	csrr	a5,mhartid
    800068c0:	0200c737          	lui	a4,0x200c
    800068c4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800068c8:	0007869b          	sext.w	a3,a5
    800068cc:	00269713          	slli	a4,a3,0x2
    800068d0:	000f4637          	lui	a2,0xf4
    800068d4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800068d8:	00d70733          	add	a4,a4,a3
    800068dc:	0037979b          	slliw	a5,a5,0x3
    800068e0:	020046b7          	lui	a3,0x2004
    800068e4:	00d787b3          	add	a5,a5,a3
    800068e8:	00c585b3          	add	a1,a1,a2
    800068ec:	00371693          	slli	a3,a4,0x3
    800068f0:	00005717          	auipc	a4,0x5
    800068f4:	7d070713          	addi	a4,a4,2000 # 8000c0c0 <timer_scratch>
    800068f8:	00b7b023          	sd	a1,0(a5)
    800068fc:	00d70733          	add	a4,a4,a3
    80006900:	00f73c23          	sd	a5,24(a4)
    80006904:	02c73023          	sd	a2,32(a4)
    80006908:	34071073          	csrw	mscratch,a4
    8000690c:	00000797          	auipc	a5,0x0
    80006910:	6e478793          	addi	a5,a5,1764 # 80006ff0 <timervec>
    80006914:	30579073          	csrw	mtvec,a5
    80006918:	300027f3          	csrr	a5,mstatus
    8000691c:	0087e793          	ori	a5,a5,8
    80006920:	30079073          	csrw	mstatus,a5
    80006924:	304027f3          	csrr	a5,mie
    80006928:	0807e793          	ori	a5,a5,128
    8000692c:	30479073          	csrw	mie,a5
    80006930:	f14027f3          	csrr	a5,mhartid
    80006934:	0007879b          	sext.w	a5,a5
    80006938:	00078213          	mv	tp,a5
    8000693c:	30200073          	mret
    80006940:	00813403          	ld	s0,8(sp)
    80006944:	01010113          	addi	sp,sp,16
    80006948:	00008067          	ret

000000008000694c <timerinit>:
    8000694c:	ff010113          	addi	sp,sp,-16
    80006950:	00813423          	sd	s0,8(sp)
    80006954:	01010413          	addi	s0,sp,16
    80006958:	f14027f3          	csrr	a5,mhartid
    8000695c:	0200c737          	lui	a4,0x200c
    80006960:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006964:	0007869b          	sext.w	a3,a5
    80006968:	00269713          	slli	a4,a3,0x2
    8000696c:	000f4637          	lui	a2,0xf4
    80006970:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006974:	00d70733          	add	a4,a4,a3
    80006978:	0037979b          	slliw	a5,a5,0x3
    8000697c:	020046b7          	lui	a3,0x2004
    80006980:	00d787b3          	add	a5,a5,a3
    80006984:	00c585b3          	add	a1,a1,a2
    80006988:	00371693          	slli	a3,a4,0x3
    8000698c:	00005717          	auipc	a4,0x5
    80006990:	73470713          	addi	a4,a4,1844 # 8000c0c0 <timer_scratch>
    80006994:	00b7b023          	sd	a1,0(a5)
    80006998:	00d70733          	add	a4,a4,a3
    8000699c:	00f73c23          	sd	a5,24(a4)
    800069a0:	02c73023          	sd	a2,32(a4)
    800069a4:	34071073          	csrw	mscratch,a4
    800069a8:	00000797          	auipc	a5,0x0
    800069ac:	64878793          	addi	a5,a5,1608 # 80006ff0 <timervec>
    800069b0:	30579073          	csrw	mtvec,a5
    800069b4:	300027f3          	csrr	a5,mstatus
    800069b8:	0087e793          	ori	a5,a5,8
    800069bc:	30079073          	csrw	mstatus,a5
    800069c0:	304027f3          	csrr	a5,mie
    800069c4:	0807e793          	ori	a5,a5,128
    800069c8:	30479073          	csrw	mie,a5
    800069cc:	00813403          	ld	s0,8(sp)
    800069d0:	01010113          	addi	sp,sp,16
    800069d4:	00008067          	ret

00000000800069d8 <system_main>:
    800069d8:	fe010113          	addi	sp,sp,-32
    800069dc:	00813823          	sd	s0,16(sp)
    800069e0:	00913423          	sd	s1,8(sp)
    800069e4:	00113c23          	sd	ra,24(sp)
    800069e8:	02010413          	addi	s0,sp,32
    800069ec:	00000097          	auipc	ra,0x0
    800069f0:	0c4080e7          	jalr	196(ra) # 80006ab0 <cpuid>
    800069f4:	00005497          	auipc	s1,0x5
    800069f8:	42c48493          	addi	s1,s1,1068 # 8000be20 <started>
    800069fc:	02050263          	beqz	a0,80006a20 <system_main+0x48>
    80006a00:	0004a783          	lw	a5,0(s1)
    80006a04:	0007879b          	sext.w	a5,a5
    80006a08:	fe078ce3          	beqz	a5,80006a00 <system_main+0x28>
    80006a0c:	0ff0000f          	fence
    80006a10:	00003517          	auipc	a0,0x3
    80006a14:	da050513          	addi	a0,a0,-608 # 800097b0 <CONSOLE_STATUS+0x7a0>
    80006a18:	00001097          	auipc	ra,0x1
    80006a1c:	a74080e7          	jalr	-1420(ra) # 8000748c <panic>
    80006a20:	00001097          	auipc	ra,0x1
    80006a24:	9c8080e7          	jalr	-1592(ra) # 800073e8 <consoleinit>
    80006a28:	00001097          	auipc	ra,0x1
    80006a2c:	154080e7          	jalr	340(ra) # 80007b7c <printfinit>
    80006a30:	00003517          	auipc	a0,0x3
    80006a34:	94050513          	addi	a0,a0,-1728 # 80009370 <CONSOLE_STATUS+0x360>
    80006a38:	00001097          	auipc	ra,0x1
    80006a3c:	ab0080e7          	jalr	-1360(ra) # 800074e8 <__printf>
    80006a40:	00003517          	auipc	a0,0x3
    80006a44:	d4050513          	addi	a0,a0,-704 # 80009780 <CONSOLE_STATUS+0x770>
    80006a48:	00001097          	auipc	ra,0x1
    80006a4c:	aa0080e7          	jalr	-1376(ra) # 800074e8 <__printf>
    80006a50:	00003517          	auipc	a0,0x3
    80006a54:	92050513          	addi	a0,a0,-1760 # 80009370 <CONSOLE_STATUS+0x360>
    80006a58:	00001097          	auipc	ra,0x1
    80006a5c:	a90080e7          	jalr	-1392(ra) # 800074e8 <__printf>
    80006a60:	00001097          	auipc	ra,0x1
    80006a64:	4a8080e7          	jalr	1192(ra) # 80007f08 <kinit>
    80006a68:	00000097          	auipc	ra,0x0
    80006a6c:	148080e7          	jalr	328(ra) # 80006bb0 <trapinit>
    80006a70:	00000097          	auipc	ra,0x0
    80006a74:	16c080e7          	jalr	364(ra) # 80006bdc <trapinithart>
    80006a78:	00000097          	auipc	ra,0x0
    80006a7c:	5b8080e7          	jalr	1464(ra) # 80007030 <plicinit>
    80006a80:	00000097          	auipc	ra,0x0
    80006a84:	5d8080e7          	jalr	1496(ra) # 80007058 <plicinithart>
    80006a88:	00000097          	auipc	ra,0x0
    80006a8c:	078080e7          	jalr	120(ra) # 80006b00 <userinit>
    80006a90:	0ff0000f          	fence
    80006a94:	00100793          	li	a5,1
    80006a98:	00003517          	auipc	a0,0x3
    80006a9c:	d0050513          	addi	a0,a0,-768 # 80009798 <CONSOLE_STATUS+0x788>
    80006aa0:	00f4a023          	sw	a5,0(s1)
    80006aa4:	00001097          	auipc	ra,0x1
    80006aa8:	a44080e7          	jalr	-1468(ra) # 800074e8 <__printf>
    80006aac:	0000006f          	j	80006aac <system_main+0xd4>

0000000080006ab0 <cpuid>:
    80006ab0:	ff010113          	addi	sp,sp,-16
    80006ab4:	00813423          	sd	s0,8(sp)
    80006ab8:	01010413          	addi	s0,sp,16
    80006abc:	00020513          	mv	a0,tp
    80006ac0:	00813403          	ld	s0,8(sp)
    80006ac4:	0005051b          	sext.w	a0,a0
    80006ac8:	01010113          	addi	sp,sp,16
    80006acc:	00008067          	ret

0000000080006ad0 <mycpu>:
    80006ad0:	ff010113          	addi	sp,sp,-16
    80006ad4:	00813423          	sd	s0,8(sp)
    80006ad8:	01010413          	addi	s0,sp,16
    80006adc:	00020793          	mv	a5,tp
    80006ae0:	00813403          	ld	s0,8(sp)
    80006ae4:	0007879b          	sext.w	a5,a5
    80006ae8:	00779793          	slli	a5,a5,0x7
    80006aec:	00006517          	auipc	a0,0x6
    80006af0:	60450513          	addi	a0,a0,1540 # 8000d0f0 <cpus>
    80006af4:	00f50533          	add	a0,a0,a5
    80006af8:	01010113          	addi	sp,sp,16
    80006afc:	00008067          	ret

0000000080006b00 <userinit>:
    80006b00:	ff010113          	addi	sp,sp,-16
    80006b04:	00813423          	sd	s0,8(sp)
    80006b08:	01010413          	addi	s0,sp,16
    80006b0c:	00813403          	ld	s0,8(sp)
    80006b10:	01010113          	addi	sp,sp,16
    80006b14:	ffffc317          	auipc	t1,0xffffc
    80006b18:	2b830067          	jr	696(t1) # 80002dcc <main>

0000000080006b1c <either_copyout>:
    80006b1c:	ff010113          	addi	sp,sp,-16
    80006b20:	00813023          	sd	s0,0(sp)
    80006b24:	00113423          	sd	ra,8(sp)
    80006b28:	01010413          	addi	s0,sp,16
    80006b2c:	02051663          	bnez	a0,80006b58 <either_copyout+0x3c>
    80006b30:	00058513          	mv	a0,a1
    80006b34:	00060593          	mv	a1,a2
    80006b38:	0006861b          	sext.w	a2,a3
    80006b3c:	00002097          	auipc	ra,0x2
    80006b40:	c58080e7          	jalr	-936(ra) # 80008794 <__memmove>
    80006b44:	00813083          	ld	ra,8(sp)
    80006b48:	00013403          	ld	s0,0(sp)
    80006b4c:	00000513          	li	a0,0
    80006b50:	01010113          	addi	sp,sp,16
    80006b54:	00008067          	ret
    80006b58:	00003517          	auipc	a0,0x3
    80006b5c:	c8050513          	addi	a0,a0,-896 # 800097d8 <CONSOLE_STATUS+0x7c8>
    80006b60:	00001097          	auipc	ra,0x1
    80006b64:	92c080e7          	jalr	-1748(ra) # 8000748c <panic>

0000000080006b68 <either_copyin>:
    80006b68:	ff010113          	addi	sp,sp,-16
    80006b6c:	00813023          	sd	s0,0(sp)
    80006b70:	00113423          	sd	ra,8(sp)
    80006b74:	01010413          	addi	s0,sp,16
    80006b78:	02059463          	bnez	a1,80006ba0 <either_copyin+0x38>
    80006b7c:	00060593          	mv	a1,a2
    80006b80:	0006861b          	sext.w	a2,a3
    80006b84:	00002097          	auipc	ra,0x2
    80006b88:	c10080e7          	jalr	-1008(ra) # 80008794 <__memmove>
    80006b8c:	00813083          	ld	ra,8(sp)
    80006b90:	00013403          	ld	s0,0(sp)
    80006b94:	00000513          	li	a0,0
    80006b98:	01010113          	addi	sp,sp,16
    80006b9c:	00008067          	ret
    80006ba0:	00003517          	auipc	a0,0x3
    80006ba4:	c6050513          	addi	a0,a0,-928 # 80009800 <CONSOLE_STATUS+0x7f0>
    80006ba8:	00001097          	auipc	ra,0x1
    80006bac:	8e4080e7          	jalr	-1820(ra) # 8000748c <panic>

0000000080006bb0 <trapinit>:
    80006bb0:	ff010113          	addi	sp,sp,-16
    80006bb4:	00813423          	sd	s0,8(sp)
    80006bb8:	01010413          	addi	s0,sp,16
    80006bbc:	00813403          	ld	s0,8(sp)
    80006bc0:	00003597          	auipc	a1,0x3
    80006bc4:	c6858593          	addi	a1,a1,-920 # 80009828 <CONSOLE_STATUS+0x818>
    80006bc8:	00006517          	auipc	a0,0x6
    80006bcc:	5a850513          	addi	a0,a0,1448 # 8000d170 <tickslock>
    80006bd0:	01010113          	addi	sp,sp,16
    80006bd4:	00001317          	auipc	t1,0x1
    80006bd8:	5c430067          	jr	1476(t1) # 80008198 <initlock>

0000000080006bdc <trapinithart>:
    80006bdc:	ff010113          	addi	sp,sp,-16
    80006be0:	00813423          	sd	s0,8(sp)
    80006be4:	01010413          	addi	s0,sp,16
    80006be8:	00000797          	auipc	a5,0x0
    80006bec:	2f878793          	addi	a5,a5,760 # 80006ee0 <kernelvec>
    80006bf0:	10579073          	csrw	stvec,a5
    80006bf4:	00813403          	ld	s0,8(sp)
    80006bf8:	01010113          	addi	sp,sp,16
    80006bfc:	00008067          	ret

0000000080006c00 <usertrap>:
    80006c00:	ff010113          	addi	sp,sp,-16
    80006c04:	00813423          	sd	s0,8(sp)
    80006c08:	01010413          	addi	s0,sp,16
    80006c0c:	00813403          	ld	s0,8(sp)
    80006c10:	01010113          	addi	sp,sp,16
    80006c14:	00008067          	ret

0000000080006c18 <usertrapret>:
    80006c18:	ff010113          	addi	sp,sp,-16
    80006c1c:	00813423          	sd	s0,8(sp)
    80006c20:	01010413          	addi	s0,sp,16
    80006c24:	00813403          	ld	s0,8(sp)
    80006c28:	01010113          	addi	sp,sp,16
    80006c2c:	00008067          	ret

0000000080006c30 <kerneltrap>:
    80006c30:	fe010113          	addi	sp,sp,-32
    80006c34:	00813823          	sd	s0,16(sp)
    80006c38:	00113c23          	sd	ra,24(sp)
    80006c3c:	00913423          	sd	s1,8(sp)
    80006c40:	02010413          	addi	s0,sp,32
    80006c44:	142025f3          	csrr	a1,scause
    80006c48:	100027f3          	csrr	a5,sstatus
    80006c4c:	0027f793          	andi	a5,a5,2
    80006c50:	10079c63          	bnez	a5,80006d68 <kerneltrap+0x138>
    80006c54:	142027f3          	csrr	a5,scause
    80006c58:	0207ce63          	bltz	a5,80006c94 <kerneltrap+0x64>
    80006c5c:	00003517          	auipc	a0,0x3
    80006c60:	c1450513          	addi	a0,a0,-1004 # 80009870 <CONSOLE_STATUS+0x860>
    80006c64:	00001097          	auipc	ra,0x1
    80006c68:	884080e7          	jalr	-1916(ra) # 800074e8 <__printf>
    80006c6c:	141025f3          	csrr	a1,sepc
    80006c70:	14302673          	csrr	a2,stval
    80006c74:	00003517          	auipc	a0,0x3
    80006c78:	c0c50513          	addi	a0,a0,-1012 # 80009880 <CONSOLE_STATUS+0x870>
    80006c7c:	00001097          	auipc	ra,0x1
    80006c80:	86c080e7          	jalr	-1940(ra) # 800074e8 <__printf>
    80006c84:	00003517          	auipc	a0,0x3
    80006c88:	c1450513          	addi	a0,a0,-1004 # 80009898 <CONSOLE_STATUS+0x888>
    80006c8c:	00001097          	auipc	ra,0x1
    80006c90:	800080e7          	jalr	-2048(ra) # 8000748c <panic>
    80006c94:	0ff7f713          	andi	a4,a5,255
    80006c98:	00900693          	li	a3,9
    80006c9c:	04d70063          	beq	a4,a3,80006cdc <kerneltrap+0xac>
    80006ca0:	fff00713          	li	a4,-1
    80006ca4:	03f71713          	slli	a4,a4,0x3f
    80006ca8:	00170713          	addi	a4,a4,1
    80006cac:	fae798e3          	bne	a5,a4,80006c5c <kerneltrap+0x2c>
    80006cb0:	00000097          	auipc	ra,0x0
    80006cb4:	e00080e7          	jalr	-512(ra) # 80006ab0 <cpuid>
    80006cb8:	06050663          	beqz	a0,80006d24 <kerneltrap+0xf4>
    80006cbc:	144027f3          	csrr	a5,sip
    80006cc0:	ffd7f793          	andi	a5,a5,-3
    80006cc4:	14479073          	csrw	sip,a5
    80006cc8:	01813083          	ld	ra,24(sp)
    80006ccc:	01013403          	ld	s0,16(sp)
    80006cd0:	00813483          	ld	s1,8(sp)
    80006cd4:	02010113          	addi	sp,sp,32
    80006cd8:	00008067          	ret
    80006cdc:	00000097          	auipc	ra,0x0
    80006ce0:	3c8080e7          	jalr	968(ra) # 800070a4 <plic_claim>
    80006ce4:	00a00793          	li	a5,10
    80006ce8:	00050493          	mv	s1,a0
    80006cec:	06f50863          	beq	a0,a5,80006d5c <kerneltrap+0x12c>
    80006cf0:	fc050ce3          	beqz	a0,80006cc8 <kerneltrap+0x98>
    80006cf4:	00050593          	mv	a1,a0
    80006cf8:	00003517          	auipc	a0,0x3
    80006cfc:	b5850513          	addi	a0,a0,-1192 # 80009850 <CONSOLE_STATUS+0x840>
    80006d00:	00000097          	auipc	ra,0x0
    80006d04:	7e8080e7          	jalr	2024(ra) # 800074e8 <__printf>
    80006d08:	01013403          	ld	s0,16(sp)
    80006d0c:	01813083          	ld	ra,24(sp)
    80006d10:	00048513          	mv	a0,s1
    80006d14:	00813483          	ld	s1,8(sp)
    80006d18:	02010113          	addi	sp,sp,32
    80006d1c:	00000317          	auipc	t1,0x0
    80006d20:	3c030067          	jr	960(t1) # 800070dc <plic_complete>
    80006d24:	00006517          	auipc	a0,0x6
    80006d28:	44c50513          	addi	a0,a0,1100 # 8000d170 <tickslock>
    80006d2c:	00001097          	auipc	ra,0x1
    80006d30:	490080e7          	jalr	1168(ra) # 800081bc <acquire>
    80006d34:	00005717          	auipc	a4,0x5
    80006d38:	0f070713          	addi	a4,a4,240 # 8000be24 <ticks>
    80006d3c:	00072783          	lw	a5,0(a4)
    80006d40:	00006517          	auipc	a0,0x6
    80006d44:	43050513          	addi	a0,a0,1072 # 8000d170 <tickslock>
    80006d48:	0017879b          	addiw	a5,a5,1
    80006d4c:	00f72023          	sw	a5,0(a4)
    80006d50:	00001097          	auipc	ra,0x1
    80006d54:	538080e7          	jalr	1336(ra) # 80008288 <release>
    80006d58:	f65ff06f          	j	80006cbc <kerneltrap+0x8c>
    80006d5c:	00001097          	auipc	ra,0x1
    80006d60:	094080e7          	jalr	148(ra) # 80007df0 <uartintr>
    80006d64:	fa5ff06f          	j	80006d08 <kerneltrap+0xd8>
    80006d68:	00003517          	auipc	a0,0x3
    80006d6c:	ac850513          	addi	a0,a0,-1336 # 80009830 <CONSOLE_STATUS+0x820>
    80006d70:	00000097          	auipc	ra,0x0
    80006d74:	71c080e7          	jalr	1820(ra) # 8000748c <panic>

0000000080006d78 <clockintr>:
    80006d78:	fe010113          	addi	sp,sp,-32
    80006d7c:	00813823          	sd	s0,16(sp)
    80006d80:	00913423          	sd	s1,8(sp)
    80006d84:	00113c23          	sd	ra,24(sp)
    80006d88:	02010413          	addi	s0,sp,32
    80006d8c:	00006497          	auipc	s1,0x6
    80006d90:	3e448493          	addi	s1,s1,996 # 8000d170 <tickslock>
    80006d94:	00048513          	mv	a0,s1
    80006d98:	00001097          	auipc	ra,0x1
    80006d9c:	424080e7          	jalr	1060(ra) # 800081bc <acquire>
    80006da0:	00005717          	auipc	a4,0x5
    80006da4:	08470713          	addi	a4,a4,132 # 8000be24 <ticks>
    80006da8:	00072783          	lw	a5,0(a4)
    80006dac:	01013403          	ld	s0,16(sp)
    80006db0:	01813083          	ld	ra,24(sp)
    80006db4:	00048513          	mv	a0,s1
    80006db8:	0017879b          	addiw	a5,a5,1
    80006dbc:	00813483          	ld	s1,8(sp)
    80006dc0:	00f72023          	sw	a5,0(a4)
    80006dc4:	02010113          	addi	sp,sp,32
    80006dc8:	00001317          	auipc	t1,0x1
    80006dcc:	4c030067          	jr	1216(t1) # 80008288 <release>

0000000080006dd0 <devintr>:
    80006dd0:	142027f3          	csrr	a5,scause
    80006dd4:	00000513          	li	a0,0
    80006dd8:	0007c463          	bltz	a5,80006de0 <devintr+0x10>
    80006ddc:	00008067          	ret
    80006de0:	fe010113          	addi	sp,sp,-32
    80006de4:	00813823          	sd	s0,16(sp)
    80006de8:	00113c23          	sd	ra,24(sp)
    80006dec:	00913423          	sd	s1,8(sp)
    80006df0:	02010413          	addi	s0,sp,32
    80006df4:	0ff7f713          	andi	a4,a5,255
    80006df8:	00900693          	li	a3,9
    80006dfc:	04d70c63          	beq	a4,a3,80006e54 <devintr+0x84>
    80006e00:	fff00713          	li	a4,-1
    80006e04:	03f71713          	slli	a4,a4,0x3f
    80006e08:	00170713          	addi	a4,a4,1
    80006e0c:	00e78c63          	beq	a5,a4,80006e24 <devintr+0x54>
    80006e10:	01813083          	ld	ra,24(sp)
    80006e14:	01013403          	ld	s0,16(sp)
    80006e18:	00813483          	ld	s1,8(sp)
    80006e1c:	02010113          	addi	sp,sp,32
    80006e20:	00008067          	ret
    80006e24:	00000097          	auipc	ra,0x0
    80006e28:	c8c080e7          	jalr	-884(ra) # 80006ab0 <cpuid>
    80006e2c:	06050663          	beqz	a0,80006e98 <devintr+0xc8>
    80006e30:	144027f3          	csrr	a5,sip
    80006e34:	ffd7f793          	andi	a5,a5,-3
    80006e38:	14479073          	csrw	sip,a5
    80006e3c:	01813083          	ld	ra,24(sp)
    80006e40:	01013403          	ld	s0,16(sp)
    80006e44:	00813483          	ld	s1,8(sp)
    80006e48:	00200513          	li	a0,2
    80006e4c:	02010113          	addi	sp,sp,32
    80006e50:	00008067          	ret
    80006e54:	00000097          	auipc	ra,0x0
    80006e58:	250080e7          	jalr	592(ra) # 800070a4 <plic_claim>
    80006e5c:	00a00793          	li	a5,10
    80006e60:	00050493          	mv	s1,a0
    80006e64:	06f50663          	beq	a0,a5,80006ed0 <devintr+0x100>
    80006e68:	00100513          	li	a0,1
    80006e6c:	fa0482e3          	beqz	s1,80006e10 <devintr+0x40>
    80006e70:	00048593          	mv	a1,s1
    80006e74:	00003517          	auipc	a0,0x3
    80006e78:	9dc50513          	addi	a0,a0,-1572 # 80009850 <CONSOLE_STATUS+0x840>
    80006e7c:	00000097          	auipc	ra,0x0
    80006e80:	66c080e7          	jalr	1644(ra) # 800074e8 <__printf>
    80006e84:	00048513          	mv	a0,s1
    80006e88:	00000097          	auipc	ra,0x0
    80006e8c:	254080e7          	jalr	596(ra) # 800070dc <plic_complete>
    80006e90:	00100513          	li	a0,1
    80006e94:	f7dff06f          	j	80006e10 <devintr+0x40>
    80006e98:	00006517          	auipc	a0,0x6
    80006e9c:	2d850513          	addi	a0,a0,728 # 8000d170 <tickslock>
    80006ea0:	00001097          	auipc	ra,0x1
    80006ea4:	31c080e7          	jalr	796(ra) # 800081bc <acquire>
    80006ea8:	00005717          	auipc	a4,0x5
    80006eac:	f7c70713          	addi	a4,a4,-132 # 8000be24 <ticks>
    80006eb0:	00072783          	lw	a5,0(a4)
    80006eb4:	00006517          	auipc	a0,0x6
    80006eb8:	2bc50513          	addi	a0,a0,700 # 8000d170 <tickslock>
    80006ebc:	0017879b          	addiw	a5,a5,1
    80006ec0:	00f72023          	sw	a5,0(a4)
    80006ec4:	00001097          	auipc	ra,0x1
    80006ec8:	3c4080e7          	jalr	964(ra) # 80008288 <release>
    80006ecc:	f65ff06f          	j	80006e30 <devintr+0x60>
    80006ed0:	00001097          	auipc	ra,0x1
    80006ed4:	f20080e7          	jalr	-224(ra) # 80007df0 <uartintr>
    80006ed8:	fadff06f          	j	80006e84 <devintr+0xb4>
    80006edc:	0000                	unimp
	...

0000000080006ee0 <kernelvec>:
    80006ee0:	f0010113          	addi	sp,sp,-256
    80006ee4:	00113023          	sd	ra,0(sp)
    80006ee8:	00213423          	sd	sp,8(sp)
    80006eec:	00313823          	sd	gp,16(sp)
    80006ef0:	00413c23          	sd	tp,24(sp)
    80006ef4:	02513023          	sd	t0,32(sp)
    80006ef8:	02613423          	sd	t1,40(sp)
    80006efc:	02713823          	sd	t2,48(sp)
    80006f00:	02813c23          	sd	s0,56(sp)
    80006f04:	04913023          	sd	s1,64(sp)
    80006f08:	04a13423          	sd	a0,72(sp)
    80006f0c:	04b13823          	sd	a1,80(sp)
    80006f10:	04c13c23          	sd	a2,88(sp)
    80006f14:	06d13023          	sd	a3,96(sp)
    80006f18:	06e13423          	sd	a4,104(sp)
    80006f1c:	06f13823          	sd	a5,112(sp)
    80006f20:	07013c23          	sd	a6,120(sp)
    80006f24:	09113023          	sd	a7,128(sp)
    80006f28:	09213423          	sd	s2,136(sp)
    80006f2c:	09313823          	sd	s3,144(sp)
    80006f30:	09413c23          	sd	s4,152(sp)
    80006f34:	0b513023          	sd	s5,160(sp)
    80006f38:	0b613423          	sd	s6,168(sp)
    80006f3c:	0b713823          	sd	s7,176(sp)
    80006f40:	0b813c23          	sd	s8,184(sp)
    80006f44:	0d913023          	sd	s9,192(sp)
    80006f48:	0da13423          	sd	s10,200(sp)
    80006f4c:	0db13823          	sd	s11,208(sp)
    80006f50:	0dc13c23          	sd	t3,216(sp)
    80006f54:	0fd13023          	sd	t4,224(sp)
    80006f58:	0fe13423          	sd	t5,232(sp)
    80006f5c:	0ff13823          	sd	t6,240(sp)
    80006f60:	cd1ff0ef          	jal	ra,80006c30 <kerneltrap>
    80006f64:	00013083          	ld	ra,0(sp)
    80006f68:	00813103          	ld	sp,8(sp)
    80006f6c:	01013183          	ld	gp,16(sp)
    80006f70:	02013283          	ld	t0,32(sp)
    80006f74:	02813303          	ld	t1,40(sp)
    80006f78:	03013383          	ld	t2,48(sp)
    80006f7c:	03813403          	ld	s0,56(sp)
    80006f80:	04013483          	ld	s1,64(sp)
    80006f84:	04813503          	ld	a0,72(sp)
    80006f88:	05013583          	ld	a1,80(sp)
    80006f8c:	05813603          	ld	a2,88(sp)
    80006f90:	06013683          	ld	a3,96(sp)
    80006f94:	06813703          	ld	a4,104(sp)
    80006f98:	07013783          	ld	a5,112(sp)
    80006f9c:	07813803          	ld	a6,120(sp)
    80006fa0:	08013883          	ld	a7,128(sp)
    80006fa4:	08813903          	ld	s2,136(sp)
    80006fa8:	09013983          	ld	s3,144(sp)
    80006fac:	09813a03          	ld	s4,152(sp)
    80006fb0:	0a013a83          	ld	s5,160(sp)
    80006fb4:	0a813b03          	ld	s6,168(sp)
    80006fb8:	0b013b83          	ld	s7,176(sp)
    80006fbc:	0b813c03          	ld	s8,184(sp)
    80006fc0:	0c013c83          	ld	s9,192(sp)
    80006fc4:	0c813d03          	ld	s10,200(sp)
    80006fc8:	0d013d83          	ld	s11,208(sp)
    80006fcc:	0d813e03          	ld	t3,216(sp)
    80006fd0:	0e013e83          	ld	t4,224(sp)
    80006fd4:	0e813f03          	ld	t5,232(sp)
    80006fd8:	0f013f83          	ld	t6,240(sp)
    80006fdc:	10010113          	addi	sp,sp,256
    80006fe0:	10200073          	sret
    80006fe4:	00000013          	nop
    80006fe8:	00000013          	nop
    80006fec:	00000013          	nop

0000000080006ff0 <timervec>:
    80006ff0:	34051573          	csrrw	a0,mscratch,a0
    80006ff4:	00b53023          	sd	a1,0(a0)
    80006ff8:	00c53423          	sd	a2,8(a0)
    80006ffc:	00d53823          	sd	a3,16(a0)
    80007000:	01853583          	ld	a1,24(a0)
    80007004:	02053603          	ld	a2,32(a0)
    80007008:	0005b683          	ld	a3,0(a1)
    8000700c:	00c686b3          	add	a3,a3,a2
    80007010:	00d5b023          	sd	a3,0(a1)
    80007014:	00200593          	li	a1,2
    80007018:	14459073          	csrw	sip,a1
    8000701c:	01053683          	ld	a3,16(a0)
    80007020:	00853603          	ld	a2,8(a0)
    80007024:	00053583          	ld	a1,0(a0)
    80007028:	34051573          	csrrw	a0,mscratch,a0
    8000702c:	30200073          	mret

0000000080007030 <plicinit>:
    80007030:	ff010113          	addi	sp,sp,-16
    80007034:	00813423          	sd	s0,8(sp)
    80007038:	01010413          	addi	s0,sp,16
    8000703c:	00813403          	ld	s0,8(sp)
    80007040:	0c0007b7          	lui	a5,0xc000
    80007044:	00100713          	li	a4,1
    80007048:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000704c:	00e7a223          	sw	a4,4(a5)
    80007050:	01010113          	addi	sp,sp,16
    80007054:	00008067          	ret

0000000080007058 <plicinithart>:
    80007058:	ff010113          	addi	sp,sp,-16
    8000705c:	00813023          	sd	s0,0(sp)
    80007060:	00113423          	sd	ra,8(sp)
    80007064:	01010413          	addi	s0,sp,16
    80007068:	00000097          	auipc	ra,0x0
    8000706c:	a48080e7          	jalr	-1464(ra) # 80006ab0 <cpuid>
    80007070:	0085171b          	slliw	a4,a0,0x8
    80007074:	0c0027b7          	lui	a5,0xc002
    80007078:	00e787b3          	add	a5,a5,a4
    8000707c:	40200713          	li	a4,1026
    80007080:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007084:	00813083          	ld	ra,8(sp)
    80007088:	00013403          	ld	s0,0(sp)
    8000708c:	00d5151b          	slliw	a0,a0,0xd
    80007090:	0c2017b7          	lui	a5,0xc201
    80007094:	00a78533          	add	a0,a5,a0
    80007098:	00052023          	sw	zero,0(a0)
    8000709c:	01010113          	addi	sp,sp,16
    800070a0:	00008067          	ret

00000000800070a4 <plic_claim>:
    800070a4:	ff010113          	addi	sp,sp,-16
    800070a8:	00813023          	sd	s0,0(sp)
    800070ac:	00113423          	sd	ra,8(sp)
    800070b0:	01010413          	addi	s0,sp,16
    800070b4:	00000097          	auipc	ra,0x0
    800070b8:	9fc080e7          	jalr	-1540(ra) # 80006ab0 <cpuid>
    800070bc:	00813083          	ld	ra,8(sp)
    800070c0:	00013403          	ld	s0,0(sp)
    800070c4:	00d5151b          	slliw	a0,a0,0xd
    800070c8:	0c2017b7          	lui	a5,0xc201
    800070cc:	00a78533          	add	a0,a5,a0
    800070d0:	00452503          	lw	a0,4(a0)
    800070d4:	01010113          	addi	sp,sp,16
    800070d8:	00008067          	ret

00000000800070dc <plic_complete>:
    800070dc:	fe010113          	addi	sp,sp,-32
    800070e0:	00813823          	sd	s0,16(sp)
    800070e4:	00913423          	sd	s1,8(sp)
    800070e8:	00113c23          	sd	ra,24(sp)
    800070ec:	02010413          	addi	s0,sp,32
    800070f0:	00050493          	mv	s1,a0
    800070f4:	00000097          	auipc	ra,0x0
    800070f8:	9bc080e7          	jalr	-1604(ra) # 80006ab0 <cpuid>
    800070fc:	01813083          	ld	ra,24(sp)
    80007100:	01013403          	ld	s0,16(sp)
    80007104:	00d5179b          	slliw	a5,a0,0xd
    80007108:	0c201737          	lui	a4,0xc201
    8000710c:	00f707b3          	add	a5,a4,a5
    80007110:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007114:	00813483          	ld	s1,8(sp)
    80007118:	02010113          	addi	sp,sp,32
    8000711c:	00008067          	ret

0000000080007120 <consolewrite>:
    80007120:	fb010113          	addi	sp,sp,-80
    80007124:	04813023          	sd	s0,64(sp)
    80007128:	04113423          	sd	ra,72(sp)
    8000712c:	02913c23          	sd	s1,56(sp)
    80007130:	03213823          	sd	s2,48(sp)
    80007134:	03313423          	sd	s3,40(sp)
    80007138:	03413023          	sd	s4,32(sp)
    8000713c:	01513c23          	sd	s5,24(sp)
    80007140:	05010413          	addi	s0,sp,80
    80007144:	06c05c63          	blez	a2,800071bc <consolewrite+0x9c>
    80007148:	00060993          	mv	s3,a2
    8000714c:	00050a13          	mv	s4,a0
    80007150:	00058493          	mv	s1,a1
    80007154:	00000913          	li	s2,0
    80007158:	fff00a93          	li	s5,-1
    8000715c:	01c0006f          	j	80007178 <consolewrite+0x58>
    80007160:	fbf44503          	lbu	a0,-65(s0)
    80007164:	0019091b          	addiw	s2,s2,1
    80007168:	00148493          	addi	s1,s1,1
    8000716c:	00001097          	auipc	ra,0x1
    80007170:	a9c080e7          	jalr	-1380(ra) # 80007c08 <uartputc>
    80007174:	03298063          	beq	s3,s2,80007194 <consolewrite+0x74>
    80007178:	00048613          	mv	a2,s1
    8000717c:	00100693          	li	a3,1
    80007180:	000a0593          	mv	a1,s4
    80007184:	fbf40513          	addi	a0,s0,-65
    80007188:	00000097          	auipc	ra,0x0
    8000718c:	9e0080e7          	jalr	-1568(ra) # 80006b68 <either_copyin>
    80007190:	fd5518e3          	bne	a0,s5,80007160 <consolewrite+0x40>
    80007194:	04813083          	ld	ra,72(sp)
    80007198:	04013403          	ld	s0,64(sp)
    8000719c:	03813483          	ld	s1,56(sp)
    800071a0:	02813983          	ld	s3,40(sp)
    800071a4:	02013a03          	ld	s4,32(sp)
    800071a8:	01813a83          	ld	s5,24(sp)
    800071ac:	00090513          	mv	a0,s2
    800071b0:	03013903          	ld	s2,48(sp)
    800071b4:	05010113          	addi	sp,sp,80
    800071b8:	00008067          	ret
    800071bc:	00000913          	li	s2,0
    800071c0:	fd5ff06f          	j	80007194 <consolewrite+0x74>

00000000800071c4 <consoleread>:
    800071c4:	f9010113          	addi	sp,sp,-112
    800071c8:	06813023          	sd	s0,96(sp)
    800071cc:	04913c23          	sd	s1,88(sp)
    800071d0:	05213823          	sd	s2,80(sp)
    800071d4:	05313423          	sd	s3,72(sp)
    800071d8:	05413023          	sd	s4,64(sp)
    800071dc:	03513c23          	sd	s5,56(sp)
    800071e0:	03613823          	sd	s6,48(sp)
    800071e4:	03713423          	sd	s7,40(sp)
    800071e8:	03813023          	sd	s8,32(sp)
    800071ec:	06113423          	sd	ra,104(sp)
    800071f0:	01913c23          	sd	s9,24(sp)
    800071f4:	07010413          	addi	s0,sp,112
    800071f8:	00060b93          	mv	s7,a2
    800071fc:	00050913          	mv	s2,a0
    80007200:	00058c13          	mv	s8,a1
    80007204:	00060b1b          	sext.w	s6,a2
    80007208:	00006497          	auipc	s1,0x6
    8000720c:	f9048493          	addi	s1,s1,-112 # 8000d198 <cons>
    80007210:	00400993          	li	s3,4
    80007214:	fff00a13          	li	s4,-1
    80007218:	00a00a93          	li	s5,10
    8000721c:	05705e63          	blez	s7,80007278 <consoleread+0xb4>
    80007220:	09c4a703          	lw	a4,156(s1)
    80007224:	0984a783          	lw	a5,152(s1)
    80007228:	0007071b          	sext.w	a4,a4
    8000722c:	08e78463          	beq	a5,a4,800072b4 <consoleread+0xf0>
    80007230:	07f7f713          	andi	a4,a5,127
    80007234:	00e48733          	add	a4,s1,a4
    80007238:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000723c:	0017869b          	addiw	a3,a5,1
    80007240:	08d4ac23          	sw	a3,152(s1)
    80007244:	00070c9b          	sext.w	s9,a4
    80007248:	0b370663          	beq	a4,s3,800072f4 <consoleread+0x130>
    8000724c:	00100693          	li	a3,1
    80007250:	f9f40613          	addi	a2,s0,-97
    80007254:	000c0593          	mv	a1,s8
    80007258:	00090513          	mv	a0,s2
    8000725c:	f8e40fa3          	sb	a4,-97(s0)
    80007260:	00000097          	auipc	ra,0x0
    80007264:	8bc080e7          	jalr	-1860(ra) # 80006b1c <either_copyout>
    80007268:	01450863          	beq	a0,s4,80007278 <consoleread+0xb4>
    8000726c:	001c0c13          	addi	s8,s8,1
    80007270:	fffb8b9b          	addiw	s7,s7,-1
    80007274:	fb5c94e3          	bne	s9,s5,8000721c <consoleread+0x58>
    80007278:	000b851b          	sext.w	a0,s7
    8000727c:	06813083          	ld	ra,104(sp)
    80007280:	06013403          	ld	s0,96(sp)
    80007284:	05813483          	ld	s1,88(sp)
    80007288:	05013903          	ld	s2,80(sp)
    8000728c:	04813983          	ld	s3,72(sp)
    80007290:	04013a03          	ld	s4,64(sp)
    80007294:	03813a83          	ld	s5,56(sp)
    80007298:	02813b83          	ld	s7,40(sp)
    8000729c:	02013c03          	ld	s8,32(sp)
    800072a0:	01813c83          	ld	s9,24(sp)
    800072a4:	40ab053b          	subw	a0,s6,a0
    800072a8:	03013b03          	ld	s6,48(sp)
    800072ac:	07010113          	addi	sp,sp,112
    800072b0:	00008067          	ret
    800072b4:	00001097          	auipc	ra,0x1
    800072b8:	1d8080e7          	jalr	472(ra) # 8000848c <push_on>
    800072bc:	0984a703          	lw	a4,152(s1)
    800072c0:	09c4a783          	lw	a5,156(s1)
    800072c4:	0007879b          	sext.w	a5,a5
    800072c8:	fef70ce3          	beq	a4,a5,800072c0 <consoleread+0xfc>
    800072cc:	00001097          	auipc	ra,0x1
    800072d0:	234080e7          	jalr	564(ra) # 80008500 <pop_on>
    800072d4:	0984a783          	lw	a5,152(s1)
    800072d8:	07f7f713          	andi	a4,a5,127
    800072dc:	00e48733          	add	a4,s1,a4
    800072e0:	01874703          	lbu	a4,24(a4)
    800072e4:	0017869b          	addiw	a3,a5,1
    800072e8:	08d4ac23          	sw	a3,152(s1)
    800072ec:	00070c9b          	sext.w	s9,a4
    800072f0:	f5371ee3          	bne	a4,s3,8000724c <consoleread+0x88>
    800072f4:	000b851b          	sext.w	a0,s7
    800072f8:	f96bf2e3          	bgeu	s7,s6,8000727c <consoleread+0xb8>
    800072fc:	08f4ac23          	sw	a5,152(s1)
    80007300:	f7dff06f          	j	8000727c <consoleread+0xb8>

0000000080007304 <consputc>:
    80007304:	10000793          	li	a5,256
    80007308:	00f50663          	beq	a0,a5,80007314 <consputc+0x10>
    8000730c:	00001317          	auipc	t1,0x1
    80007310:	9f430067          	jr	-1548(t1) # 80007d00 <uartputc_sync>
    80007314:	ff010113          	addi	sp,sp,-16
    80007318:	00113423          	sd	ra,8(sp)
    8000731c:	00813023          	sd	s0,0(sp)
    80007320:	01010413          	addi	s0,sp,16
    80007324:	00800513          	li	a0,8
    80007328:	00001097          	auipc	ra,0x1
    8000732c:	9d8080e7          	jalr	-1576(ra) # 80007d00 <uartputc_sync>
    80007330:	02000513          	li	a0,32
    80007334:	00001097          	auipc	ra,0x1
    80007338:	9cc080e7          	jalr	-1588(ra) # 80007d00 <uartputc_sync>
    8000733c:	00013403          	ld	s0,0(sp)
    80007340:	00813083          	ld	ra,8(sp)
    80007344:	00800513          	li	a0,8
    80007348:	01010113          	addi	sp,sp,16
    8000734c:	00001317          	auipc	t1,0x1
    80007350:	9b430067          	jr	-1612(t1) # 80007d00 <uartputc_sync>

0000000080007354 <consoleintr>:
    80007354:	fe010113          	addi	sp,sp,-32
    80007358:	00813823          	sd	s0,16(sp)
    8000735c:	00913423          	sd	s1,8(sp)
    80007360:	01213023          	sd	s2,0(sp)
    80007364:	00113c23          	sd	ra,24(sp)
    80007368:	02010413          	addi	s0,sp,32
    8000736c:	00006917          	auipc	s2,0x6
    80007370:	e2c90913          	addi	s2,s2,-468 # 8000d198 <cons>
    80007374:	00050493          	mv	s1,a0
    80007378:	00090513          	mv	a0,s2
    8000737c:	00001097          	auipc	ra,0x1
    80007380:	e40080e7          	jalr	-448(ra) # 800081bc <acquire>
    80007384:	02048c63          	beqz	s1,800073bc <consoleintr+0x68>
    80007388:	0a092783          	lw	a5,160(s2)
    8000738c:	09892703          	lw	a4,152(s2)
    80007390:	07f00693          	li	a3,127
    80007394:	40e7873b          	subw	a4,a5,a4
    80007398:	02e6e263          	bltu	a3,a4,800073bc <consoleintr+0x68>
    8000739c:	00d00713          	li	a4,13
    800073a0:	04e48063          	beq	s1,a4,800073e0 <consoleintr+0x8c>
    800073a4:	07f7f713          	andi	a4,a5,127
    800073a8:	00e90733          	add	a4,s2,a4
    800073ac:	0017879b          	addiw	a5,a5,1
    800073b0:	0af92023          	sw	a5,160(s2)
    800073b4:	00970c23          	sb	s1,24(a4)
    800073b8:	08f92e23          	sw	a5,156(s2)
    800073bc:	01013403          	ld	s0,16(sp)
    800073c0:	01813083          	ld	ra,24(sp)
    800073c4:	00813483          	ld	s1,8(sp)
    800073c8:	00013903          	ld	s2,0(sp)
    800073cc:	00006517          	auipc	a0,0x6
    800073d0:	dcc50513          	addi	a0,a0,-564 # 8000d198 <cons>
    800073d4:	02010113          	addi	sp,sp,32
    800073d8:	00001317          	auipc	t1,0x1
    800073dc:	eb030067          	jr	-336(t1) # 80008288 <release>
    800073e0:	00a00493          	li	s1,10
    800073e4:	fc1ff06f          	j	800073a4 <consoleintr+0x50>

00000000800073e8 <consoleinit>:
    800073e8:	fe010113          	addi	sp,sp,-32
    800073ec:	00113c23          	sd	ra,24(sp)
    800073f0:	00813823          	sd	s0,16(sp)
    800073f4:	00913423          	sd	s1,8(sp)
    800073f8:	02010413          	addi	s0,sp,32
    800073fc:	00006497          	auipc	s1,0x6
    80007400:	d9c48493          	addi	s1,s1,-612 # 8000d198 <cons>
    80007404:	00048513          	mv	a0,s1
    80007408:	00002597          	auipc	a1,0x2
    8000740c:	4a058593          	addi	a1,a1,1184 # 800098a8 <CONSOLE_STATUS+0x898>
    80007410:	00001097          	auipc	ra,0x1
    80007414:	d88080e7          	jalr	-632(ra) # 80008198 <initlock>
    80007418:	00000097          	auipc	ra,0x0
    8000741c:	7ac080e7          	jalr	1964(ra) # 80007bc4 <uartinit>
    80007420:	01813083          	ld	ra,24(sp)
    80007424:	01013403          	ld	s0,16(sp)
    80007428:	00000797          	auipc	a5,0x0
    8000742c:	d9c78793          	addi	a5,a5,-612 # 800071c4 <consoleread>
    80007430:	0af4bc23          	sd	a5,184(s1)
    80007434:	00000797          	auipc	a5,0x0
    80007438:	cec78793          	addi	a5,a5,-788 # 80007120 <consolewrite>
    8000743c:	0cf4b023          	sd	a5,192(s1)
    80007440:	00813483          	ld	s1,8(sp)
    80007444:	02010113          	addi	sp,sp,32
    80007448:	00008067          	ret

000000008000744c <console_read>:
    8000744c:	ff010113          	addi	sp,sp,-16
    80007450:	00813423          	sd	s0,8(sp)
    80007454:	01010413          	addi	s0,sp,16
    80007458:	00813403          	ld	s0,8(sp)
    8000745c:	00006317          	auipc	t1,0x6
    80007460:	df433303          	ld	t1,-524(t1) # 8000d250 <devsw+0x10>
    80007464:	01010113          	addi	sp,sp,16
    80007468:	00030067          	jr	t1

000000008000746c <console_write>:
    8000746c:	ff010113          	addi	sp,sp,-16
    80007470:	00813423          	sd	s0,8(sp)
    80007474:	01010413          	addi	s0,sp,16
    80007478:	00813403          	ld	s0,8(sp)
    8000747c:	00006317          	auipc	t1,0x6
    80007480:	ddc33303          	ld	t1,-548(t1) # 8000d258 <devsw+0x18>
    80007484:	01010113          	addi	sp,sp,16
    80007488:	00030067          	jr	t1

000000008000748c <panic>:
    8000748c:	fe010113          	addi	sp,sp,-32
    80007490:	00113c23          	sd	ra,24(sp)
    80007494:	00813823          	sd	s0,16(sp)
    80007498:	00913423          	sd	s1,8(sp)
    8000749c:	02010413          	addi	s0,sp,32
    800074a0:	00050493          	mv	s1,a0
    800074a4:	00002517          	auipc	a0,0x2
    800074a8:	40c50513          	addi	a0,a0,1036 # 800098b0 <CONSOLE_STATUS+0x8a0>
    800074ac:	00006797          	auipc	a5,0x6
    800074b0:	e407a623          	sw	zero,-436(a5) # 8000d2f8 <pr+0x18>
    800074b4:	00000097          	auipc	ra,0x0
    800074b8:	034080e7          	jalr	52(ra) # 800074e8 <__printf>
    800074bc:	00048513          	mv	a0,s1
    800074c0:	00000097          	auipc	ra,0x0
    800074c4:	028080e7          	jalr	40(ra) # 800074e8 <__printf>
    800074c8:	00002517          	auipc	a0,0x2
    800074cc:	ea850513          	addi	a0,a0,-344 # 80009370 <CONSOLE_STATUS+0x360>
    800074d0:	00000097          	auipc	ra,0x0
    800074d4:	018080e7          	jalr	24(ra) # 800074e8 <__printf>
    800074d8:	00100793          	li	a5,1
    800074dc:	00005717          	auipc	a4,0x5
    800074e0:	94f72623          	sw	a5,-1716(a4) # 8000be28 <panicked>
    800074e4:	0000006f          	j	800074e4 <panic+0x58>

00000000800074e8 <__printf>:
    800074e8:	f3010113          	addi	sp,sp,-208
    800074ec:	08813023          	sd	s0,128(sp)
    800074f0:	07313423          	sd	s3,104(sp)
    800074f4:	09010413          	addi	s0,sp,144
    800074f8:	05813023          	sd	s8,64(sp)
    800074fc:	08113423          	sd	ra,136(sp)
    80007500:	06913c23          	sd	s1,120(sp)
    80007504:	07213823          	sd	s2,112(sp)
    80007508:	07413023          	sd	s4,96(sp)
    8000750c:	05513c23          	sd	s5,88(sp)
    80007510:	05613823          	sd	s6,80(sp)
    80007514:	05713423          	sd	s7,72(sp)
    80007518:	03913c23          	sd	s9,56(sp)
    8000751c:	03a13823          	sd	s10,48(sp)
    80007520:	03b13423          	sd	s11,40(sp)
    80007524:	00006317          	auipc	t1,0x6
    80007528:	dbc30313          	addi	t1,t1,-580 # 8000d2e0 <pr>
    8000752c:	01832c03          	lw	s8,24(t1)
    80007530:	00b43423          	sd	a1,8(s0)
    80007534:	00c43823          	sd	a2,16(s0)
    80007538:	00d43c23          	sd	a3,24(s0)
    8000753c:	02e43023          	sd	a4,32(s0)
    80007540:	02f43423          	sd	a5,40(s0)
    80007544:	03043823          	sd	a6,48(s0)
    80007548:	03143c23          	sd	a7,56(s0)
    8000754c:	00050993          	mv	s3,a0
    80007550:	4a0c1663          	bnez	s8,800079fc <__printf+0x514>
    80007554:	60098c63          	beqz	s3,80007b6c <__printf+0x684>
    80007558:	0009c503          	lbu	a0,0(s3)
    8000755c:	00840793          	addi	a5,s0,8
    80007560:	f6f43c23          	sd	a5,-136(s0)
    80007564:	00000493          	li	s1,0
    80007568:	22050063          	beqz	a0,80007788 <__printf+0x2a0>
    8000756c:	00002a37          	lui	s4,0x2
    80007570:	00018ab7          	lui	s5,0x18
    80007574:	000f4b37          	lui	s6,0xf4
    80007578:	00989bb7          	lui	s7,0x989
    8000757c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007580:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007584:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007588:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000758c:	00148c9b          	addiw	s9,s1,1
    80007590:	02500793          	li	a5,37
    80007594:	01998933          	add	s2,s3,s9
    80007598:	38f51263          	bne	a0,a5,8000791c <__printf+0x434>
    8000759c:	00094783          	lbu	a5,0(s2)
    800075a0:	00078c9b          	sext.w	s9,a5
    800075a4:	1e078263          	beqz	a5,80007788 <__printf+0x2a0>
    800075a8:	0024849b          	addiw	s1,s1,2
    800075ac:	07000713          	li	a4,112
    800075b0:	00998933          	add	s2,s3,s1
    800075b4:	38e78a63          	beq	a5,a4,80007948 <__printf+0x460>
    800075b8:	20f76863          	bltu	a4,a5,800077c8 <__printf+0x2e0>
    800075bc:	42a78863          	beq	a5,a0,800079ec <__printf+0x504>
    800075c0:	06400713          	li	a4,100
    800075c4:	40e79663          	bne	a5,a4,800079d0 <__printf+0x4e8>
    800075c8:	f7843783          	ld	a5,-136(s0)
    800075cc:	0007a603          	lw	a2,0(a5)
    800075d0:	00878793          	addi	a5,a5,8
    800075d4:	f6f43c23          	sd	a5,-136(s0)
    800075d8:	42064a63          	bltz	a2,80007a0c <__printf+0x524>
    800075dc:	00a00713          	li	a4,10
    800075e0:	02e677bb          	remuw	a5,a2,a4
    800075e4:	00002d97          	auipc	s11,0x2
    800075e8:	2f4d8d93          	addi	s11,s11,756 # 800098d8 <digits>
    800075ec:	00900593          	li	a1,9
    800075f0:	0006051b          	sext.w	a0,a2
    800075f4:	00000c93          	li	s9,0
    800075f8:	02079793          	slli	a5,a5,0x20
    800075fc:	0207d793          	srli	a5,a5,0x20
    80007600:	00fd87b3          	add	a5,s11,a5
    80007604:	0007c783          	lbu	a5,0(a5)
    80007608:	02e656bb          	divuw	a3,a2,a4
    8000760c:	f8f40023          	sb	a5,-128(s0)
    80007610:	14c5d863          	bge	a1,a2,80007760 <__printf+0x278>
    80007614:	06300593          	li	a1,99
    80007618:	00100c93          	li	s9,1
    8000761c:	02e6f7bb          	remuw	a5,a3,a4
    80007620:	02079793          	slli	a5,a5,0x20
    80007624:	0207d793          	srli	a5,a5,0x20
    80007628:	00fd87b3          	add	a5,s11,a5
    8000762c:	0007c783          	lbu	a5,0(a5)
    80007630:	02e6d73b          	divuw	a4,a3,a4
    80007634:	f8f400a3          	sb	a5,-127(s0)
    80007638:	12a5f463          	bgeu	a1,a0,80007760 <__printf+0x278>
    8000763c:	00a00693          	li	a3,10
    80007640:	00900593          	li	a1,9
    80007644:	02d777bb          	remuw	a5,a4,a3
    80007648:	02079793          	slli	a5,a5,0x20
    8000764c:	0207d793          	srli	a5,a5,0x20
    80007650:	00fd87b3          	add	a5,s11,a5
    80007654:	0007c503          	lbu	a0,0(a5)
    80007658:	02d757bb          	divuw	a5,a4,a3
    8000765c:	f8a40123          	sb	a0,-126(s0)
    80007660:	48e5f263          	bgeu	a1,a4,80007ae4 <__printf+0x5fc>
    80007664:	06300513          	li	a0,99
    80007668:	02d7f5bb          	remuw	a1,a5,a3
    8000766c:	02059593          	slli	a1,a1,0x20
    80007670:	0205d593          	srli	a1,a1,0x20
    80007674:	00bd85b3          	add	a1,s11,a1
    80007678:	0005c583          	lbu	a1,0(a1)
    8000767c:	02d7d7bb          	divuw	a5,a5,a3
    80007680:	f8b401a3          	sb	a1,-125(s0)
    80007684:	48e57263          	bgeu	a0,a4,80007b08 <__printf+0x620>
    80007688:	3e700513          	li	a0,999
    8000768c:	02d7f5bb          	remuw	a1,a5,a3
    80007690:	02059593          	slli	a1,a1,0x20
    80007694:	0205d593          	srli	a1,a1,0x20
    80007698:	00bd85b3          	add	a1,s11,a1
    8000769c:	0005c583          	lbu	a1,0(a1)
    800076a0:	02d7d7bb          	divuw	a5,a5,a3
    800076a4:	f8b40223          	sb	a1,-124(s0)
    800076a8:	46e57663          	bgeu	a0,a4,80007b14 <__printf+0x62c>
    800076ac:	02d7f5bb          	remuw	a1,a5,a3
    800076b0:	02059593          	slli	a1,a1,0x20
    800076b4:	0205d593          	srli	a1,a1,0x20
    800076b8:	00bd85b3          	add	a1,s11,a1
    800076bc:	0005c583          	lbu	a1,0(a1)
    800076c0:	02d7d7bb          	divuw	a5,a5,a3
    800076c4:	f8b402a3          	sb	a1,-123(s0)
    800076c8:	46ea7863          	bgeu	s4,a4,80007b38 <__printf+0x650>
    800076cc:	02d7f5bb          	remuw	a1,a5,a3
    800076d0:	02059593          	slli	a1,a1,0x20
    800076d4:	0205d593          	srli	a1,a1,0x20
    800076d8:	00bd85b3          	add	a1,s11,a1
    800076dc:	0005c583          	lbu	a1,0(a1)
    800076e0:	02d7d7bb          	divuw	a5,a5,a3
    800076e4:	f8b40323          	sb	a1,-122(s0)
    800076e8:	3eeaf863          	bgeu	s5,a4,80007ad8 <__printf+0x5f0>
    800076ec:	02d7f5bb          	remuw	a1,a5,a3
    800076f0:	02059593          	slli	a1,a1,0x20
    800076f4:	0205d593          	srli	a1,a1,0x20
    800076f8:	00bd85b3          	add	a1,s11,a1
    800076fc:	0005c583          	lbu	a1,0(a1)
    80007700:	02d7d7bb          	divuw	a5,a5,a3
    80007704:	f8b403a3          	sb	a1,-121(s0)
    80007708:	42eb7e63          	bgeu	s6,a4,80007b44 <__printf+0x65c>
    8000770c:	02d7f5bb          	remuw	a1,a5,a3
    80007710:	02059593          	slli	a1,a1,0x20
    80007714:	0205d593          	srli	a1,a1,0x20
    80007718:	00bd85b3          	add	a1,s11,a1
    8000771c:	0005c583          	lbu	a1,0(a1)
    80007720:	02d7d7bb          	divuw	a5,a5,a3
    80007724:	f8b40423          	sb	a1,-120(s0)
    80007728:	42ebfc63          	bgeu	s7,a4,80007b60 <__printf+0x678>
    8000772c:	02079793          	slli	a5,a5,0x20
    80007730:	0207d793          	srli	a5,a5,0x20
    80007734:	00fd8db3          	add	s11,s11,a5
    80007738:	000dc703          	lbu	a4,0(s11)
    8000773c:	00a00793          	li	a5,10
    80007740:	00900c93          	li	s9,9
    80007744:	f8e404a3          	sb	a4,-119(s0)
    80007748:	00065c63          	bgez	a2,80007760 <__printf+0x278>
    8000774c:	f9040713          	addi	a4,s0,-112
    80007750:	00f70733          	add	a4,a4,a5
    80007754:	02d00693          	li	a3,45
    80007758:	fed70823          	sb	a3,-16(a4)
    8000775c:	00078c93          	mv	s9,a5
    80007760:	f8040793          	addi	a5,s0,-128
    80007764:	01978cb3          	add	s9,a5,s9
    80007768:	f7f40d13          	addi	s10,s0,-129
    8000776c:	000cc503          	lbu	a0,0(s9)
    80007770:	fffc8c93          	addi	s9,s9,-1
    80007774:	00000097          	auipc	ra,0x0
    80007778:	b90080e7          	jalr	-1136(ra) # 80007304 <consputc>
    8000777c:	ffac98e3          	bne	s9,s10,8000776c <__printf+0x284>
    80007780:	00094503          	lbu	a0,0(s2)
    80007784:	e00514e3          	bnez	a0,8000758c <__printf+0xa4>
    80007788:	1a0c1663          	bnez	s8,80007934 <__printf+0x44c>
    8000778c:	08813083          	ld	ra,136(sp)
    80007790:	08013403          	ld	s0,128(sp)
    80007794:	07813483          	ld	s1,120(sp)
    80007798:	07013903          	ld	s2,112(sp)
    8000779c:	06813983          	ld	s3,104(sp)
    800077a0:	06013a03          	ld	s4,96(sp)
    800077a4:	05813a83          	ld	s5,88(sp)
    800077a8:	05013b03          	ld	s6,80(sp)
    800077ac:	04813b83          	ld	s7,72(sp)
    800077b0:	04013c03          	ld	s8,64(sp)
    800077b4:	03813c83          	ld	s9,56(sp)
    800077b8:	03013d03          	ld	s10,48(sp)
    800077bc:	02813d83          	ld	s11,40(sp)
    800077c0:	0d010113          	addi	sp,sp,208
    800077c4:	00008067          	ret
    800077c8:	07300713          	li	a4,115
    800077cc:	1ce78a63          	beq	a5,a4,800079a0 <__printf+0x4b8>
    800077d0:	07800713          	li	a4,120
    800077d4:	1ee79e63          	bne	a5,a4,800079d0 <__printf+0x4e8>
    800077d8:	f7843783          	ld	a5,-136(s0)
    800077dc:	0007a703          	lw	a4,0(a5)
    800077e0:	00878793          	addi	a5,a5,8
    800077e4:	f6f43c23          	sd	a5,-136(s0)
    800077e8:	28074263          	bltz	a4,80007a6c <__printf+0x584>
    800077ec:	00002d97          	auipc	s11,0x2
    800077f0:	0ecd8d93          	addi	s11,s11,236 # 800098d8 <digits>
    800077f4:	00f77793          	andi	a5,a4,15
    800077f8:	00fd87b3          	add	a5,s11,a5
    800077fc:	0007c683          	lbu	a3,0(a5)
    80007800:	00f00613          	li	a2,15
    80007804:	0007079b          	sext.w	a5,a4
    80007808:	f8d40023          	sb	a3,-128(s0)
    8000780c:	0047559b          	srliw	a1,a4,0x4
    80007810:	0047569b          	srliw	a3,a4,0x4
    80007814:	00000c93          	li	s9,0
    80007818:	0ee65063          	bge	a2,a4,800078f8 <__printf+0x410>
    8000781c:	00f6f693          	andi	a3,a3,15
    80007820:	00dd86b3          	add	a3,s11,a3
    80007824:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007828:	0087d79b          	srliw	a5,a5,0x8
    8000782c:	00100c93          	li	s9,1
    80007830:	f8d400a3          	sb	a3,-127(s0)
    80007834:	0cb67263          	bgeu	a2,a1,800078f8 <__printf+0x410>
    80007838:	00f7f693          	andi	a3,a5,15
    8000783c:	00dd86b3          	add	a3,s11,a3
    80007840:	0006c583          	lbu	a1,0(a3)
    80007844:	00f00613          	li	a2,15
    80007848:	0047d69b          	srliw	a3,a5,0x4
    8000784c:	f8b40123          	sb	a1,-126(s0)
    80007850:	0047d593          	srli	a1,a5,0x4
    80007854:	28f67e63          	bgeu	a2,a5,80007af0 <__printf+0x608>
    80007858:	00f6f693          	andi	a3,a3,15
    8000785c:	00dd86b3          	add	a3,s11,a3
    80007860:	0006c503          	lbu	a0,0(a3)
    80007864:	0087d813          	srli	a6,a5,0x8
    80007868:	0087d69b          	srliw	a3,a5,0x8
    8000786c:	f8a401a3          	sb	a0,-125(s0)
    80007870:	28b67663          	bgeu	a2,a1,80007afc <__printf+0x614>
    80007874:	00f6f693          	andi	a3,a3,15
    80007878:	00dd86b3          	add	a3,s11,a3
    8000787c:	0006c583          	lbu	a1,0(a3)
    80007880:	00c7d513          	srli	a0,a5,0xc
    80007884:	00c7d69b          	srliw	a3,a5,0xc
    80007888:	f8b40223          	sb	a1,-124(s0)
    8000788c:	29067a63          	bgeu	a2,a6,80007b20 <__printf+0x638>
    80007890:	00f6f693          	andi	a3,a3,15
    80007894:	00dd86b3          	add	a3,s11,a3
    80007898:	0006c583          	lbu	a1,0(a3)
    8000789c:	0107d813          	srli	a6,a5,0x10
    800078a0:	0107d69b          	srliw	a3,a5,0x10
    800078a4:	f8b402a3          	sb	a1,-123(s0)
    800078a8:	28a67263          	bgeu	a2,a0,80007b2c <__printf+0x644>
    800078ac:	00f6f693          	andi	a3,a3,15
    800078b0:	00dd86b3          	add	a3,s11,a3
    800078b4:	0006c683          	lbu	a3,0(a3)
    800078b8:	0147d79b          	srliw	a5,a5,0x14
    800078bc:	f8d40323          	sb	a3,-122(s0)
    800078c0:	21067663          	bgeu	a2,a6,80007acc <__printf+0x5e4>
    800078c4:	02079793          	slli	a5,a5,0x20
    800078c8:	0207d793          	srli	a5,a5,0x20
    800078cc:	00fd8db3          	add	s11,s11,a5
    800078d0:	000dc683          	lbu	a3,0(s11)
    800078d4:	00800793          	li	a5,8
    800078d8:	00700c93          	li	s9,7
    800078dc:	f8d403a3          	sb	a3,-121(s0)
    800078e0:	00075c63          	bgez	a4,800078f8 <__printf+0x410>
    800078e4:	f9040713          	addi	a4,s0,-112
    800078e8:	00f70733          	add	a4,a4,a5
    800078ec:	02d00693          	li	a3,45
    800078f0:	fed70823          	sb	a3,-16(a4)
    800078f4:	00078c93          	mv	s9,a5
    800078f8:	f8040793          	addi	a5,s0,-128
    800078fc:	01978cb3          	add	s9,a5,s9
    80007900:	f7f40d13          	addi	s10,s0,-129
    80007904:	000cc503          	lbu	a0,0(s9)
    80007908:	fffc8c93          	addi	s9,s9,-1
    8000790c:	00000097          	auipc	ra,0x0
    80007910:	9f8080e7          	jalr	-1544(ra) # 80007304 <consputc>
    80007914:	ff9d18e3          	bne	s10,s9,80007904 <__printf+0x41c>
    80007918:	0100006f          	j	80007928 <__printf+0x440>
    8000791c:	00000097          	auipc	ra,0x0
    80007920:	9e8080e7          	jalr	-1560(ra) # 80007304 <consputc>
    80007924:	000c8493          	mv	s1,s9
    80007928:	00094503          	lbu	a0,0(s2)
    8000792c:	c60510e3          	bnez	a0,8000758c <__printf+0xa4>
    80007930:	e40c0ee3          	beqz	s8,8000778c <__printf+0x2a4>
    80007934:	00006517          	auipc	a0,0x6
    80007938:	9ac50513          	addi	a0,a0,-1620 # 8000d2e0 <pr>
    8000793c:	00001097          	auipc	ra,0x1
    80007940:	94c080e7          	jalr	-1716(ra) # 80008288 <release>
    80007944:	e49ff06f          	j	8000778c <__printf+0x2a4>
    80007948:	f7843783          	ld	a5,-136(s0)
    8000794c:	03000513          	li	a0,48
    80007950:	01000d13          	li	s10,16
    80007954:	00878713          	addi	a4,a5,8
    80007958:	0007bc83          	ld	s9,0(a5)
    8000795c:	f6e43c23          	sd	a4,-136(s0)
    80007960:	00000097          	auipc	ra,0x0
    80007964:	9a4080e7          	jalr	-1628(ra) # 80007304 <consputc>
    80007968:	07800513          	li	a0,120
    8000796c:	00000097          	auipc	ra,0x0
    80007970:	998080e7          	jalr	-1640(ra) # 80007304 <consputc>
    80007974:	00002d97          	auipc	s11,0x2
    80007978:	f64d8d93          	addi	s11,s11,-156 # 800098d8 <digits>
    8000797c:	03ccd793          	srli	a5,s9,0x3c
    80007980:	00fd87b3          	add	a5,s11,a5
    80007984:	0007c503          	lbu	a0,0(a5)
    80007988:	fffd0d1b          	addiw	s10,s10,-1
    8000798c:	004c9c93          	slli	s9,s9,0x4
    80007990:	00000097          	auipc	ra,0x0
    80007994:	974080e7          	jalr	-1676(ra) # 80007304 <consputc>
    80007998:	fe0d12e3          	bnez	s10,8000797c <__printf+0x494>
    8000799c:	f8dff06f          	j	80007928 <__printf+0x440>
    800079a0:	f7843783          	ld	a5,-136(s0)
    800079a4:	0007bc83          	ld	s9,0(a5)
    800079a8:	00878793          	addi	a5,a5,8
    800079ac:	f6f43c23          	sd	a5,-136(s0)
    800079b0:	000c9a63          	bnez	s9,800079c4 <__printf+0x4dc>
    800079b4:	1080006f          	j	80007abc <__printf+0x5d4>
    800079b8:	001c8c93          	addi	s9,s9,1
    800079bc:	00000097          	auipc	ra,0x0
    800079c0:	948080e7          	jalr	-1720(ra) # 80007304 <consputc>
    800079c4:	000cc503          	lbu	a0,0(s9)
    800079c8:	fe0518e3          	bnez	a0,800079b8 <__printf+0x4d0>
    800079cc:	f5dff06f          	j	80007928 <__printf+0x440>
    800079d0:	02500513          	li	a0,37
    800079d4:	00000097          	auipc	ra,0x0
    800079d8:	930080e7          	jalr	-1744(ra) # 80007304 <consputc>
    800079dc:	000c8513          	mv	a0,s9
    800079e0:	00000097          	auipc	ra,0x0
    800079e4:	924080e7          	jalr	-1756(ra) # 80007304 <consputc>
    800079e8:	f41ff06f          	j	80007928 <__printf+0x440>
    800079ec:	02500513          	li	a0,37
    800079f0:	00000097          	auipc	ra,0x0
    800079f4:	914080e7          	jalr	-1772(ra) # 80007304 <consputc>
    800079f8:	f31ff06f          	j	80007928 <__printf+0x440>
    800079fc:	00030513          	mv	a0,t1
    80007a00:	00000097          	auipc	ra,0x0
    80007a04:	7bc080e7          	jalr	1980(ra) # 800081bc <acquire>
    80007a08:	b4dff06f          	j	80007554 <__printf+0x6c>
    80007a0c:	40c0053b          	negw	a0,a2
    80007a10:	00a00713          	li	a4,10
    80007a14:	02e576bb          	remuw	a3,a0,a4
    80007a18:	00002d97          	auipc	s11,0x2
    80007a1c:	ec0d8d93          	addi	s11,s11,-320 # 800098d8 <digits>
    80007a20:	ff700593          	li	a1,-9
    80007a24:	02069693          	slli	a3,a3,0x20
    80007a28:	0206d693          	srli	a3,a3,0x20
    80007a2c:	00dd86b3          	add	a3,s11,a3
    80007a30:	0006c683          	lbu	a3,0(a3)
    80007a34:	02e557bb          	divuw	a5,a0,a4
    80007a38:	f8d40023          	sb	a3,-128(s0)
    80007a3c:	10b65e63          	bge	a2,a1,80007b58 <__printf+0x670>
    80007a40:	06300593          	li	a1,99
    80007a44:	02e7f6bb          	remuw	a3,a5,a4
    80007a48:	02069693          	slli	a3,a3,0x20
    80007a4c:	0206d693          	srli	a3,a3,0x20
    80007a50:	00dd86b3          	add	a3,s11,a3
    80007a54:	0006c683          	lbu	a3,0(a3)
    80007a58:	02e7d73b          	divuw	a4,a5,a4
    80007a5c:	00200793          	li	a5,2
    80007a60:	f8d400a3          	sb	a3,-127(s0)
    80007a64:	bca5ece3          	bltu	a1,a0,8000763c <__printf+0x154>
    80007a68:	ce5ff06f          	j	8000774c <__printf+0x264>
    80007a6c:	40e007bb          	negw	a5,a4
    80007a70:	00002d97          	auipc	s11,0x2
    80007a74:	e68d8d93          	addi	s11,s11,-408 # 800098d8 <digits>
    80007a78:	00f7f693          	andi	a3,a5,15
    80007a7c:	00dd86b3          	add	a3,s11,a3
    80007a80:	0006c583          	lbu	a1,0(a3)
    80007a84:	ff100613          	li	a2,-15
    80007a88:	0047d69b          	srliw	a3,a5,0x4
    80007a8c:	f8b40023          	sb	a1,-128(s0)
    80007a90:	0047d59b          	srliw	a1,a5,0x4
    80007a94:	0ac75e63          	bge	a4,a2,80007b50 <__printf+0x668>
    80007a98:	00f6f693          	andi	a3,a3,15
    80007a9c:	00dd86b3          	add	a3,s11,a3
    80007aa0:	0006c603          	lbu	a2,0(a3)
    80007aa4:	00f00693          	li	a3,15
    80007aa8:	0087d79b          	srliw	a5,a5,0x8
    80007aac:	f8c400a3          	sb	a2,-127(s0)
    80007ab0:	d8b6e4e3          	bltu	a3,a1,80007838 <__printf+0x350>
    80007ab4:	00200793          	li	a5,2
    80007ab8:	e2dff06f          	j	800078e4 <__printf+0x3fc>
    80007abc:	00002c97          	auipc	s9,0x2
    80007ac0:	dfcc8c93          	addi	s9,s9,-516 # 800098b8 <CONSOLE_STATUS+0x8a8>
    80007ac4:	02800513          	li	a0,40
    80007ac8:	ef1ff06f          	j	800079b8 <__printf+0x4d0>
    80007acc:	00700793          	li	a5,7
    80007ad0:	00600c93          	li	s9,6
    80007ad4:	e0dff06f          	j	800078e0 <__printf+0x3f8>
    80007ad8:	00700793          	li	a5,7
    80007adc:	00600c93          	li	s9,6
    80007ae0:	c69ff06f          	j	80007748 <__printf+0x260>
    80007ae4:	00300793          	li	a5,3
    80007ae8:	00200c93          	li	s9,2
    80007aec:	c5dff06f          	j	80007748 <__printf+0x260>
    80007af0:	00300793          	li	a5,3
    80007af4:	00200c93          	li	s9,2
    80007af8:	de9ff06f          	j	800078e0 <__printf+0x3f8>
    80007afc:	00400793          	li	a5,4
    80007b00:	00300c93          	li	s9,3
    80007b04:	dddff06f          	j	800078e0 <__printf+0x3f8>
    80007b08:	00400793          	li	a5,4
    80007b0c:	00300c93          	li	s9,3
    80007b10:	c39ff06f          	j	80007748 <__printf+0x260>
    80007b14:	00500793          	li	a5,5
    80007b18:	00400c93          	li	s9,4
    80007b1c:	c2dff06f          	j	80007748 <__printf+0x260>
    80007b20:	00500793          	li	a5,5
    80007b24:	00400c93          	li	s9,4
    80007b28:	db9ff06f          	j	800078e0 <__printf+0x3f8>
    80007b2c:	00600793          	li	a5,6
    80007b30:	00500c93          	li	s9,5
    80007b34:	dadff06f          	j	800078e0 <__printf+0x3f8>
    80007b38:	00600793          	li	a5,6
    80007b3c:	00500c93          	li	s9,5
    80007b40:	c09ff06f          	j	80007748 <__printf+0x260>
    80007b44:	00800793          	li	a5,8
    80007b48:	00700c93          	li	s9,7
    80007b4c:	bfdff06f          	j	80007748 <__printf+0x260>
    80007b50:	00100793          	li	a5,1
    80007b54:	d91ff06f          	j	800078e4 <__printf+0x3fc>
    80007b58:	00100793          	li	a5,1
    80007b5c:	bf1ff06f          	j	8000774c <__printf+0x264>
    80007b60:	00900793          	li	a5,9
    80007b64:	00800c93          	li	s9,8
    80007b68:	be1ff06f          	j	80007748 <__printf+0x260>
    80007b6c:	00002517          	auipc	a0,0x2
    80007b70:	d5450513          	addi	a0,a0,-684 # 800098c0 <CONSOLE_STATUS+0x8b0>
    80007b74:	00000097          	auipc	ra,0x0
    80007b78:	918080e7          	jalr	-1768(ra) # 8000748c <panic>

0000000080007b7c <printfinit>:
    80007b7c:	fe010113          	addi	sp,sp,-32
    80007b80:	00813823          	sd	s0,16(sp)
    80007b84:	00913423          	sd	s1,8(sp)
    80007b88:	00113c23          	sd	ra,24(sp)
    80007b8c:	02010413          	addi	s0,sp,32
    80007b90:	00005497          	auipc	s1,0x5
    80007b94:	75048493          	addi	s1,s1,1872 # 8000d2e0 <pr>
    80007b98:	00048513          	mv	a0,s1
    80007b9c:	00002597          	auipc	a1,0x2
    80007ba0:	d3458593          	addi	a1,a1,-716 # 800098d0 <CONSOLE_STATUS+0x8c0>
    80007ba4:	00000097          	auipc	ra,0x0
    80007ba8:	5f4080e7          	jalr	1524(ra) # 80008198 <initlock>
    80007bac:	01813083          	ld	ra,24(sp)
    80007bb0:	01013403          	ld	s0,16(sp)
    80007bb4:	0004ac23          	sw	zero,24(s1)
    80007bb8:	00813483          	ld	s1,8(sp)
    80007bbc:	02010113          	addi	sp,sp,32
    80007bc0:	00008067          	ret

0000000080007bc4 <uartinit>:
    80007bc4:	ff010113          	addi	sp,sp,-16
    80007bc8:	00813423          	sd	s0,8(sp)
    80007bcc:	01010413          	addi	s0,sp,16
    80007bd0:	100007b7          	lui	a5,0x10000
    80007bd4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007bd8:	f8000713          	li	a4,-128
    80007bdc:	00e781a3          	sb	a4,3(a5)
    80007be0:	00300713          	li	a4,3
    80007be4:	00e78023          	sb	a4,0(a5)
    80007be8:	000780a3          	sb	zero,1(a5)
    80007bec:	00e781a3          	sb	a4,3(a5)
    80007bf0:	00700693          	li	a3,7
    80007bf4:	00d78123          	sb	a3,2(a5)
    80007bf8:	00e780a3          	sb	a4,1(a5)
    80007bfc:	00813403          	ld	s0,8(sp)
    80007c00:	01010113          	addi	sp,sp,16
    80007c04:	00008067          	ret

0000000080007c08 <uartputc>:
    80007c08:	00004797          	auipc	a5,0x4
    80007c0c:	2207a783          	lw	a5,544(a5) # 8000be28 <panicked>
    80007c10:	00078463          	beqz	a5,80007c18 <uartputc+0x10>
    80007c14:	0000006f          	j	80007c14 <uartputc+0xc>
    80007c18:	fd010113          	addi	sp,sp,-48
    80007c1c:	02813023          	sd	s0,32(sp)
    80007c20:	00913c23          	sd	s1,24(sp)
    80007c24:	01213823          	sd	s2,16(sp)
    80007c28:	01313423          	sd	s3,8(sp)
    80007c2c:	02113423          	sd	ra,40(sp)
    80007c30:	03010413          	addi	s0,sp,48
    80007c34:	00004917          	auipc	s2,0x4
    80007c38:	1fc90913          	addi	s2,s2,508 # 8000be30 <uart_tx_r>
    80007c3c:	00093783          	ld	a5,0(s2)
    80007c40:	00004497          	auipc	s1,0x4
    80007c44:	1f848493          	addi	s1,s1,504 # 8000be38 <uart_tx_w>
    80007c48:	0004b703          	ld	a4,0(s1)
    80007c4c:	02078693          	addi	a3,a5,32
    80007c50:	00050993          	mv	s3,a0
    80007c54:	02e69c63          	bne	a3,a4,80007c8c <uartputc+0x84>
    80007c58:	00001097          	auipc	ra,0x1
    80007c5c:	834080e7          	jalr	-1996(ra) # 8000848c <push_on>
    80007c60:	00093783          	ld	a5,0(s2)
    80007c64:	0004b703          	ld	a4,0(s1)
    80007c68:	02078793          	addi	a5,a5,32
    80007c6c:	00e79463          	bne	a5,a4,80007c74 <uartputc+0x6c>
    80007c70:	0000006f          	j	80007c70 <uartputc+0x68>
    80007c74:	00001097          	auipc	ra,0x1
    80007c78:	88c080e7          	jalr	-1908(ra) # 80008500 <pop_on>
    80007c7c:	00093783          	ld	a5,0(s2)
    80007c80:	0004b703          	ld	a4,0(s1)
    80007c84:	02078693          	addi	a3,a5,32
    80007c88:	fce688e3          	beq	a3,a4,80007c58 <uartputc+0x50>
    80007c8c:	01f77693          	andi	a3,a4,31
    80007c90:	00005597          	auipc	a1,0x5
    80007c94:	67058593          	addi	a1,a1,1648 # 8000d300 <uart_tx_buf>
    80007c98:	00d586b3          	add	a3,a1,a3
    80007c9c:	00170713          	addi	a4,a4,1
    80007ca0:	01368023          	sb	s3,0(a3)
    80007ca4:	00e4b023          	sd	a4,0(s1)
    80007ca8:	10000637          	lui	a2,0x10000
    80007cac:	02f71063          	bne	a4,a5,80007ccc <uartputc+0xc4>
    80007cb0:	0340006f          	j	80007ce4 <uartputc+0xdc>
    80007cb4:	00074703          	lbu	a4,0(a4)
    80007cb8:	00f93023          	sd	a5,0(s2)
    80007cbc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007cc0:	00093783          	ld	a5,0(s2)
    80007cc4:	0004b703          	ld	a4,0(s1)
    80007cc8:	00f70e63          	beq	a4,a5,80007ce4 <uartputc+0xdc>
    80007ccc:	00564683          	lbu	a3,5(a2)
    80007cd0:	01f7f713          	andi	a4,a5,31
    80007cd4:	00e58733          	add	a4,a1,a4
    80007cd8:	0206f693          	andi	a3,a3,32
    80007cdc:	00178793          	addi	a5,a5,1
    80007ce0:	fc069ae3          	bnez	a3,80007cb4 <uartputc+0xac>
    80007ce4:	02813083          	ld	ra,40(sp)
    80007ce8:	02013403          	ld	s0,32(sp)
    80007cec:	01813483          	ld	s1,24(sp)
    80007cf0:	01013903          	ld	s2,16(sp)
    80007cf4:	00813983          	ld	s3,8(sp)
    80007cf8:	03010113          	addi	sp,sp,48
    80007cfc:	00008067          	ret

0000000080007d00 <uartputc_sync>:
    80007d00:	ff010113          	addi	sp,sp,-16
    80007d04:	00813423          	sd	s0,8(sp)
    80007d08:	01010413          	addi	s0,sp,16
    80007d0c:	00004717          	auipc	a4,0x4
    80007d10:	11c72703          	lw	a4,284(a4) # 8000be28 <panicked>
    80007d14:	02071663          	bnez	a4,80007d40 <uartputc_sync+0x40>
    80007d18:	00050793          	mv	a5,a0
    80007d1c:	100006b7          	lui	a3,0x10000
    80007d20:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007d24:	02077713          	andi	a4,a4,32
    80007d28:	fe070ce3          	beqz	a4,80007d20 <uartputc_sync+0x20>
    80007d2c:	0ff7f793          	andi	a5,a5,255
    80007d30:	00f68023          	sb	a5,0(a3)
    80007d34:	00813403          	ld	s0,8(sp)
    80007d38:	01010113          	addi	sp,sp,16
    80007d3c:	00008067          	ret
    80007d40:	0000006f          	j	80007d40 <uartputc_sync+0x40>

0000000080007d44 <uartstart>:
    80007d44:	ff010113          	addi	sp,sp,-16
    80007d48:	00813423          	sd	s0,8(sp)
    80007d4c:	01010413          	addi	s0,sp,16
    80007d50:	00004617          	auipc	a2,0x4
    80007d54:	0e060613          	addi	a2,a2,224 # 8000be30 <uart_tx_r>
    80007d58:	00004517          	auipc	a0,0x4
    80007d5c:	0e050513          	addi	a0,a0,224 # 8000be38 <uart_tx_w>
    80007d60:	00063783          	ld	a5,0(a2)
    80007d64:	00053703          	ld	a4,0(a0)
    80007d68:	04f70263          	beq	a4,a5,80007dac <uartstart+0x68>
    80007d6c:	100005b7          	lui	a1,0x10000
    80007d70:	00005817          	auipc	a6,0x5
    80007d74:	59080813          	addi	a6,a6,1424 # 8000d300 <uart_tx_buf>
    80007d78:	01c0006f          	j	80007d94 <uartstart+0x50>
    80007d7c:	0006c703          	lbu	a4,0(a3)
    80007d80:	00f63023          	sd	a5,0(a2)
    80007d84:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007d88:	00063783          	ld	a5,0(a2)
    80007d8c:	00053703          	ld	a4,0(a0)
    80007d90:	00f70e63          	beq	a4,a5,80007dac <uartstart+0x68>
    80007d94:	01f7f713          	andi	a4,a5,31
    80007d98:	00e806b3          	add	a3,a6,a4
    80007d9c:	0055c703          	lbu	a4,5(a1)
    80007da0:	00178793          	addi	a5,a5,1
    80007da4:	02077713          	andi	a4,a4,32
    80007da8:	fc071ae3          	bnez	a4,80007d7c <uartstart+0x38>
    80007dac:	00813403          	ld	s0,8(sp)
    80007db0:	01010113          	addi	sp,sp,16
    80007db4:	00008067          	ret

0000000080007db8 <uartgetc>:
    80007db8:	ff010113          	addi	sp,sp,-16
    80007dbc:	00813423          	sd	s0,8(sp)
    80007dc0:	01010413          	addi	s0,sp,16
    80007dc4:	10000737          	lui	a4,0x10000
    80007dc8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007dcc:	0017f793          	andi	a5,a5,1
    80007dd0:	00078c63          	beqz	a5,80007de8 <uartgetc+0x30>
    80007dd4:	00074503          	lbu	a0,0(a4)
    80007dd8:	0ff57513          	andi	a0,a0,255
    80007ddc:	00813403          	ld	s0,8(sp)
    80007de0:	01010113          	addi	sp,sp,16
    80007de4:	00008067          	ret
    80007de8:	fff00513          	li	a0,-1
    80007dec:	ff1ff06f          	j	80007ddc <uartgetc+0x24>

0000000080007df0 <uartintr>:
    80007df0:	100007b7          	lui	a5,0x10000
    80007df4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007df8:	0017f793          	andi	a5,a5,1
    80007dfc:	0a078463          	beqz	a5,80007ea4 <uartintr+0xb4>
    80007e00:	fe010113          	addi	sp,sp,-32
    80007e04:	00813823          	sd	s0,16(sp)
    80007e08:	00913423          	sd	s1,8(sp)
    80007e0c:	00113c23          	sd	ra,24(sp)
    80007e10:	02010413          	addi	s0,sp,32
    80007e14:	100004b7          	lui	s1,0x10000
    80007e18:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80007e1c:	0ff57513          	andi	a0,a0,255
    80007e20:	fffff097          	auipc	ra,0xfffff
    80007e24:	534080e7          	jalr	1332(ra) # 80007354 <consoleintr>
    80007e28:	0054c783          	lbu	a5,5(s1)
    80007e2c:	0017f793          	andi	a5,a5,1
    80007e30:	fe0794e3          	bnez	a5,80007e18 <uartintr+0x28>
    80007e34:	00004617          	auipc	a2,0x4
    80007e38:	ffc60613          	addi	a2,a2,-4 # 8000be30 <uart_tx_r>
    80007e3c:	00004517          	auipc	a0,0x4
    80007e40:	ffc50513          	addi	a0,a0,-4 # 8000be38 <uart_tx_w>
    80007e44:	00063783          	ld	a5,0(a2)
    80007e48:	00053703          	ld	a4,0(a0)
    80007e4c:	04f70263          	beq	a4,a5,80007e90 <uartintr+0xa0>
    80007e50:	100005b7          	lui	a1,0x10000
    80007e54:	00005817          	auipc	a6,0x5
    80007e58:	4ac80813          	addi	a6,a6,1196 # 8000d300 <uart_tx_buf>
    80007e5c:	01c0006f          	j	80007e78 <uartintr+0x88>
    80007e60:	0006c703          	lbu	a4,0(a3)
    80007e64:	00f63023          	sd	a5,0(a2)
    80007e68:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007e6c:	00063783          	ld	a5,0(a2)
    80007e70:	00053703          	ld	a4,0(a0)
    80007e74:	00f70e63          	beq	a4,a5,80007e90 <uartintr+0xa0>
    80007e78:	01f7f713          	andi	a4,a5,31
    80007e7c:	00e806b3          	add	a3,a6,a4
    80007e80:	0055c703          	lbu	a4,5(a1)
    80007e84:	00178793          	addi	a5,a5,1
    80007e88:	02077713          	andi	a4,a4,32
    80007e8c:	fc071ae3          	bnez	a4,80007e60 <uartintr+0x70>
    80007e90:	01813083          	ld	ra,24(sp)
    80007e94:	01013403          	ld	s0,16(sp)
    80007e98:	00813483          	ld	s1,8(sp)
    80007e9c:	02010113          	addi	sp,sp,32
    80007ea0:	00008067          	ret
    80007ea4:	00004617          	auipc	a2,0x4
    80007ea8:	f8c60613          	addi	a2,a2,-116 # 8000be30 <uart_tx_r>
    80007eac:	00004517          	auipc	a0,0x4
    80007eb0:	f8c50513          	addi	a0,a0,-116 # 8000be38 <uart_tx_w>
    80007eb4:	00063783          	ld	a5,0(a2)
    80007eb8:	00053703          	ld	a4,0(a0)
    80007ebc:	04f70263          	beq	a4,a5,80007f00 <uartintr+0x110>
    80007ec0:	100005b7          	lui	a1,0x10000
    80007ec4:	00005817          	auipc	a6,0x5
    80007ec8:	43c80813          	addi	a6,a6,1084 # 8000d300 <uart_tx_buf>
    80007ecc:	01c0006f          	j	80007ee8 <uartintr+0xf8>
    80007ed0:	0006c703          	lbu	a4,0(a3)
    80007ed4:	00f63023          	sd	a5,0(a2)
    80007ed8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007edc:	00063783          	ld	a5,0(a2)
    80007ee0:	00053703          	ld	a4,0(a0)
    80007ee4:	02f70063          	beq	a4,a5,80007f04 <uartintr+0x114>
    80007ee8:	01f7f713          	andi	a4,a5,31
    80007eec:	00e806b3          	add	a3,a6,a4
    80007ef0:	0055c703          	lbu	a4,5(a1)
    80007ef4:	00178793          	addi	a5,a5,1
    80007ef8:	02077713          	andi	a4,a4,32
    80007efc:	fc071ae3          	bnez	a4,80007ed0 <uartintr+0xe0>
    80007f00:	00008067          	ret
    80007f04:	00008067          	ret

0000000080007f08 <kinit>:
    80007f08:	fc010113          	addi	sp,sp,-64
    80007f0c:	02913423          	sd	s1,40(sp)
    80007f10:	fffff7b7          	lui	a5,0xfffff
    80007f14:	00006497          	auipc	s1,0x6
    80007f18:	40b48493          	addi	s1,s1,1035 # 8000e31f <end+0xfff>
    80007f1c:	02813823          	sd	s0,48(sp)
    80007f20:	01313c23          	sd	s3,24(sp)
    80007f24:	00f4f4b3          	and	s1,s1,a5
    80007f28:	02113c23          	sd	ra,56(sp)
    80007f2c:	03213023          	sd	s2,32(sp)
    80007f30:	01413823          	sd	s4,16(sp)
    80007f34:	01513423          	sd	s5,8(sp)
    80007f38:	04010413          	addi	s0,sp,64
    80007f3c:	000017b7          	lui	a5,0x1
    80007f40:	01100993          	li	s3,17
    80007f44:	00f487b3          	add	a5,s1,a5
    80007f48:	01b99993          	slli	s3,s3,0x1b
    80007f4c:	06f9e063          	bltu	s3,a5,80007fac <kinit+0xa4>
    80007f50:	00005a97          	auipc	s5,0x5
    80007f54:	3d0a8a93          	addi	s5,s5,976 # 8000d320 <end>
    80007f58:	0754ec63          	bltu	s1,s5,80007fd0 <kinit+0xc8>
    80007f5c:	0734fa63          	bgeu	s1,s3,80007fd0 <kinit+0xc8>
    80007f60:	00088a37          	lui	s4,0x88
    80007f64:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007f68:	00004917          	auipc	s2,0x4
    80007f6c:	ed890913          	addi	s2,s2,-296 # 8000be40 <kmem>
    80007f70:	00ca1a13          	slli	s4,s4,0xc
    80007f74:	0140006f          	j	80007f88 <kinit+0x80>
    80007f78:	000017b7          	lui	a5,0x1
    80007f7c:	00f484b3          	add	s1,s1,a5
    80007f80:	0554e863          	bltu	s1,s5,80007fd0 <kinit+0xc8>
    80007f84:	0534f663          	bgeu	s1,s3,80007fd0 <kinit+0xc8>
    80007f88:	00001637          	lui	a2,0x1
    80007f8c:	00100593          	li	a1,1
    80007f90:	00048513          	mv	a0,s1
    80007f94:	00000097          	auipc	ra,0x0
    80007f98:	5e4080e7          	jalr	1508(ra) # 80008578 <__memset>
    80007f9c:	00093783          	ld	a5,0(s2)
    80007fa0:	00f4b023          	sd	a5,0(s1)
    80007fa4:	00993023          	sd	s1,0(s2)
    80007fa8:	fd4498e3          	bne	s1,s4,80007f78 <kinit+0x70>
    80007fac:	03813083          	ld	ra,56(sp)
    80007fb0:	03013403          	ld	s0,48(sp)
    80007fb4:	02813483          	ld	s1,40(sp)
    80007fb8:	02013903          	ld	s2,32(sp)
    80007fbc:	01813983          	ld	s3,24(sp)
    80007fc0:	01013a03          	ld	s4,16(sp)
    80007fc4:	00813a83          	ld	s5,8(sp)
    80007fc8:	04010113          	addi	sp,sp,64
    80007fcc:	00008067          	ret
    80007fd0:	00002517          	auipc	a0,0x2
    80007fd4:	92050513          	addi	a0,a0,-1760 # 800098f0 <digits+0x18>
    80007fd8:	fffff097          	auipc	ra,0xfffff
    80007fdc:	4b4080e7          	jalr	1204(ra) # 8000748c <panic>

0000000080007fe0 <freerange>:
    80007fe0:	fc010113          	addi	sp,sp,-64
    80007fe4:	000017b7          	lui	a5,0x1
    80007fe8:	02913423          	sd	s1,40(sp)
    80007fec:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007ff0:	009504b3          	add	s1,a0,s1
    80007ff4:	fffff537          	lui	a0,0xfffff
    80007ff8:	02813823          	sd	s0,48(sp)
    80007ffc:	02113c23          	sd	ra,56(sp)
    80008000:	03213023          	sd	s2,32(sp)
    80008004:	01313c23          	sd	s3,24(sp)
    80008008:	01413823          	sd	s4,16(sp)
    8000800c:	01513423          	sd	s5,8(sp)
    80008010:	01613023          	sd	s6,0(sp)
    80008014:	04010413          	addi	s0,sp,64
    80008018:	00a4f4b3          	and	s1,s1,a0
    8000801c:	00f487b3          	add	a5,s1,a5
    80008020:	06f5e463          	bltu	a1,a5,80008088 <freerange+0xa8>
    80008024:	00005a97          	auipc	s5,0x5
    80008028:	2fca8a93          	addi	s5,s5,764 # 8000d320 <end>
    8000802c:	0954e263          	bltu	s1,s5,800080b0 <freerange+0xd0>
    80008030:	01100993          	li	s3,17
    80008034:	01b99993          	slli	s3,s3,0x1b
    80008038:	0734fc63          	bgeu	s1,s3,800080b0 <freerange+0xd0>
    8000803c:	00058a13          	mv	s4,a1
    80008040:	00004917          	auipc	s2,0x4
    80008044:	e0090913          	addi	s2,s2,-512 # 8000be40 <kmem>
    80008048:	00002b37          	lui	s6,0x2
    8000804c:	0140006f          	j	80008060 <freerange+0x80>
    80008050:	000017b7          	lui	a5,0x1
    80008054:	00f484b3          	add	s1,s1,a5
    80008058:	0554ec63          	bltu	s1,s5,800080b0 <freerange+0xd0>
    8000805c:	0534fa63          	bgeu	s1,s3,800080b0 <freerange+0xd0>
    80008060:	00001637          	lui	a2,0x1
    80008064:	00100593          	li	a1,1
    80008068:	00048513          	mv	a0,s1
    8000806c:	00000097          	auipc	ra,0x0
    80008070:	50c080e7          	jalr	1292(ra) # 80008578 <__memset>
    80008074:	00093703          	ld	a4,0(s2)
    80008078:	016487b3          	add	a5,s1,s6
    8000807c:	00e4b023          	sd	a4,0(s1)
    80008080:	00993023          	sd	s1,0(s2)
    80008084:	fcfa76e3          	bgeu	s4,a5,80008050 <freerange+0x70>
    80008088:	03813083          	ld	ra,56(sp)
    8000808c:	03013403          	ld	s0,48(sp)
    80008090:	02813483          	ld	s1,40(sp)
    80008094:	02013903          	ld	s2,32(sp)
    80008098:	01813983          	ld	s3,24(sp)
    8000809c:	01013a03          	ld	s4,16(sp)
    800080a0:	00813a83          	ld	s5,8(sp)
    800080a4:	00013b03          	ld	s6,0(sp)
    800080a8:	04010113          	addi	sp,sp,64
    800080ac:	00008067          	ret
    800080b0:	00002517          	auipc	a0,0x2
    800080b4:	84050513          	addi	a0,a0,-1984 # 800098f0 <digits+0x18>
    800080b8:	fffff097          	auipc	ra,0xfffff
    800080bc:	3d4080e7          	jalr	980(ra) # 8000748c <panic>

00000000800080c0 <kfree>:
    800080c0:	fe010113          	addi	sp,sp,-32
    800080c4:	00813823          	sd	s0,16(sp)
    800080c8:	00113c23          	sd	ra,24(sp)
    800080cc:	00913423          	sd	s1,8(sp)
    800080d0:	02010413          	addi	s0,sp,32
    800080d4:	03451793          	slli	a5,a0,0x34
    800080d8:	04079c63          	bnez	a5,80008130 <kfree+0x70>
    800080dc:	00005797          	auipc	a5,0x5
    800080e0:	24478793          	addi	a5,a5,580 # 8000d320 <end>
    800080e4:	00050493          	mv	s1,a0
    800080e8:	04f56463          	bltu	a0,a5,80008130 <kfree+0x70>
    800080ec:	01100793          	li	a5,17
    800080f0:	01b79793          	slli	a5,a5,0x1b
    800080f4:	02f57e63          	bgeu	a0,a5,80008130 <kfree+0x70>
    800080f8:	00001637          	lui	a2,0x1
    800080fc:	00100593          	li	a1,1
    80008100:	00000097          	auipc	ra,0x0
    80008104:	478080e7          	jalr	1144(ra) # 80008578 <__memset>
    80008108:	00004797          	auipc	a5,0x4
    8000810c:	d3878793          	addi	a5,a5,-712 # 8000be40 <kmem>
    80008110:	0007b703          	ld	a4,0(a5)
    80008114:	01813083          	ld	ra,24(sp)
    80008118:	01013403          	ld	s0,16(sp)
    8000811c:	00e4b023          	sd	a4,0(s1)
    80008120:	0097b023          	sd	s1,0(a5)
    80008124:	00813483          	ld	s1,8(sp)
    80008128:	02010113          	addi	sp,sp,32
    8000812c:	00008067          	ret
    80008130:	00001517          	auipc	a0,0x1
    80008134:	7c050513          	addi	a0,a0,1984 # 800098f0 <digits+0x18>
    80008138:	fffff097          	auipc	ra,0xfffff
    8000813c:	354080e7          	jalr	852(ra) # 8000748c <panic>

0000000080008140 <kalloc>:
    80008140:	fe010113          	addi	sp,sp,-32
    80008144:	00813823          	sd	s0,16(sp)
    80008148:	00913423          	sd	s1,8(sp)
    8000814c:	00113c23          	sd	ra,24(sp)
    80008150:	02010413          	addi	s0,sp,32
    80008154:	00004797          	auipc	a5,0x4
    80008158:	cec78793          	addi	a5,a5,-788 # 8000be40 <kmem>
    8000815c:	0007b483          	ld	s1,0(a5)
    80008160:	02048063          	beqz	s1,80008180 <kalloc+0x40>
    80008164:	0004b703          	ld	a4,0(s1)
    80008168:	00001637          	lui	a2,0x1
    8000816c:	00500593          	li	a1,5
    80008170:	00048513          	mv	a0,s1
    80008174:	00e7b023          	sd	a4,0(a5)
    80008178:	00000097          	auipc	ra,0x0
    8000817c:	400080e7          	jalr	1024(ra) # 80008578 <__memset>
    80008180:	01813083          	ld	ra,24(sp)
    80008184:	01013403          	ld	s0,16(sp)
    80008188:	00048513          	mv	a0,s1
    8000818c:	00813483          	ld	s1,8(sp)
    80008190:	02010113          	addi	sp,sp,32
    80008194:	00008067          	ret

0000000080008198 <initlock>:
    80008198:	ff010113          	addi	sp,sp,-16
    8000819c:	00813423          	sd	s0,8(sp)
    800081a0:	01010413          	addi	s0,sp,16
    800081a4:	00813403          	ld	s0,8(sp)
    800081a8:	00b53423          	sd	a1,8(a0)
    800081ac:	00052023          	sw	zero,0(a0)
    800081b0:	00053823          	sd	zero,16(a0)
    800081b4:	01010113          	addi	sp,sp,16
    800081b8:	00008067          	ret

00000000800081bc <acquire>:
    800081bc:	fe010113          	addi	sp,sp,-32
    800081c0:	00813823          	sd	s0,16(sp)
    800081c4:	00913423          	sd	s1,8(sp)
    800081c8:	00113c23          	sd	ra,24(sp)
    800081cc:	01213023          	sd	s2,0(sp)
    800081d0:	02010413          	addi	s0,sp,32
    800081d4:	00050493          	mv	s1,a0
    800081d8:	10002973          	csrr	s2,sstatus
    800081dc:	100027f3          	csrr	a5,sstatus
    800081e0:	ffd7f793          	andi	a5,a5,-3
    800081e4:	10079073          	csrw	sstatus,a5
    800081e8:	fffff097          	auipc	ra,0xfffff
    800081ec:	8e8080e7          	jalr	-1816(ra) # 80006ad0 <mycpu>
    800081f0:	07852783          	lw	a5,120(a0)
    800081f4:	06078e63          	beqz	a5,80008270 <acquire+0xb4>
    800081f8:	fffff097          	auipc	ra,0xfffff
    800081fc:	8d8080e7          	jalr	-1832(ra) # 80006ad0 <mycpu>
    80008200:	07852783          	lw	a5,120(a0)
    80008204:	0004a703          	lw	a4,0(s1)
    80008208:	0017879b          	addiw	a5,a5,1
    8000820c:	06f52c23          	sw	a5,120(a0)
    80008210:	04071063          	bnez	a4,80008250 <acquire+0x94>
    80008214:	00100713          	li	a4,1
    80008218:	00070793          	mv	a5,a4
    8000821c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008220:	0007879b          	sext.w	a5,a5
    80008224:	fe079ae3          	bnez	a5,80008218 <acquire+0x5c>
    80008228:	0ff0000f          	fence
    8000822c:	fffff097          	auipc	ra,0xfffff
    80008230:	8a4080e7          	jalr	-1884(ra) # 80006ad0 <mycpu>
    80008234:	01813083          	ld	ra,24(sp)
    80008238:	01013403          	ld	s0,16(sp)
    8000823c:	00a4b823          	sd	a0,16(s1)
    80008240:	00013903          	ld	s2,0(sp)
    80008244:	00813483          	ld	s1,8(sp)
    80008248:	02010113          	addi	sp,sp,32
    8000824c:	00008067          	ret
    80008250:	0104b903          	ld	s2,16(s1)
    80008254:	fffff097          	auipc	ra,0xfffff
    80008258:	87c080e7          	jalr	-1924(ra) # 80006ad0 <mycpu>
    8000825c:	faa91ce3          	bne	s2,a0,80008214 <acquire+0x58>
    80008260:	00001517          	auipc	a0,0x1
    80008264:	69850513          	addi	a0,a0,1688 # 800098f8 <digits+0x20>
    80008268:	fffff097          	auipc	ra,0xfffff
    8000826c:	224080e7          	jalr	548(ra) # 8000748c <panic>
    80008270:	00195913          	srli	s2,s2,0x1
    80008274:	fffff097          	auipc	ra,0xfffff
    80008278:	85c080e7          	jalr	-1956(ra) # 80006ad0 <mycpu>
    8000827c:	00197913          	andi	s2,s2,1
    80008280:	07252e23          	sw	s2,124(a0)
    80008284:	f75ff06f          	j	800081f8 <acquire+0x3c>

0000000080008288 <release>:
    80008288:	fe010113          	addi	sp,sp,-32
    8000828c:	00813823          	sd	s0,16(sp)
    80008290:	00113c23          	sd	ra,24(sp)
    80008294:	00913423          	sd	s1,8(sp)
    80008298:	01213023          	sd	s2,0(sp)
    8000829c:	02010413          	addi	s0,sp,32
    800082a0:	00052783          	lw	a5,0(a0)
    800082a4:	00079a63          	bnez	a5,800082b8 <release+0x30>
    800082a8:	00001517          	auipc	a0,0x1
    800082ac:	65850513          	addi	a0,a0,1624 # 80009900 <digits+0x28>
    800082b0:	fffff097          	auipc	ra,0xfffff
    800082b4:	1dc080e7          	jalr	476(ra) # 8000748c <panic>
    800082b8:	01053903          	ld	s2,16(a0)
    800082bc:	00050493          	mv	s1,a0
    800082c0:	fffff097          	auipc	ra,0xfffff
    800082c4:	810080e7          	jalr	-2032(ra) # 80006ad0 <mycpu>
    800082c8:	fea910e3          	bne	s2,a0,800082a8 <release+0x20>
    800082cc:	0004b823          	sd	zero,16(s1)
    800082d0:	0ff0000f          	fence
    800082d4:	0f50000f          	fence	iorw,ow
    800082d8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800082dc:	ffffe097          	auipc	ra,0xffffe
    800082e0:	7f4080e7          	jalr	2036(ra) # 80006ad0 <mycpu>
    800082e4:	100027f3          	csrr	a5,sstatus
    800082e8:	0027f793          	andi	a5,a5,2
    800082ec:	04079a63          	bnez	a5,80008340 <release+0xb8>
    800082f0:	07852783          	lw	a5,120(a0)
    800082f4:	02f05e63          	blez	a5,80008330 <release+0xa8>
    800082f8:	fff7871b          	addiw	a4,a5,-1
    800082fc:	06e52c23          	sw	a4,120(a0)
    80008300:	00071c63          	bnez	a4,80008318 <release+0x90>
    80008304:	07c52783          	lw	a5,124(a0)
    80008308:	00078863          	beqz	a5,80008318 <release+0x90>
    8000830c:	100027f3          	csrr	a5,sstatus
    80008310:	0027e793          	ori	a5,a5,2
    80008314:	10079073          	csrw	sstatus,a5
    80008318:	01813083          	ld	ra,24(sp)
    8000831c:	01013403          	ld	s0,16(sp)
    80008320:	00813483          	ld	s1,8(sp)
    80008324:	00013903          	ld	s2,0(sp)
    80008328:	02010113          	addi	sp,sp,32
    8000832c:	00008067          	ret
    80008330:	00001517          	auipc	a0,0x1
    80008334:	5f050513          	addi	a0,a0,1520 # 80009920 <digits+0x48>
    80008338:	fffff097          	auipc	ra,0xfffff
    8000833c:	154080e7          	jalr	340(ra) # 8000748c <panic>
    80008340:	00001517          	auipc	a0,0x1
    80008344:	5c850513          	addi	a0,a0,1480 # 80009908 <digits+0x30>
    80008348:	fffff097          	auipc	ra,0xfffff
    8000834c:	144080e7          	jalr	324(ra) # 8000748c <panic>

0000000080008350 <holding>:
    80008350:	00052783          	lw	a5,0(a0)
    80008354:	00079663          	bnez	a5,80008360 <holding+0x10>
    80008358:	00000513          	li	a0,0
    8000835c:	00008067          	ret
    80008360:	fe010113          	addi	sp,sp,-32
    80008364:	00813823          	sd	s0,16(sp)
    80008368:	00913423          	sd	s1,8(sp)
    8000836c:	00113c23          	sd	ra,24(sp)
    80008370:	02010413          	addi	s0,sp,32
    80008374:	01053483          	ld	s1,16(a0)
    80008378:	ffffe097          	auipc	ra,0xffffe
    8000837c:	758080e7          	jalr	1880(ra) # 80006ad0 <mycpu>
    80008380:	01813083          	ld	ra,24(sp)
    80008384:	01013403          	ld	s0,16(sp)
    80008388:	40a48533          	sub	a0,s1,a0
    8000838c:	00153513          	seqz	a0,a0
    80008390:	00813483          	ld	s1,8(sp)
    80008394:	02010113          	addi	sp,sp,32
    80008398:	00008067          	ret

000000008000839c <push_off>:
    8000839c:	fe010113          	addi	sp,sp,-32
    800083a0:	00813823          	sd	s0,16(sp)
    800083a4:	00113c23          	sd	ra,24(sp)
    800083a8:	00913423          	sd	s1,8(sp)
    800083ac:	02010413          	addi	s0,sp,32
    800083b0:	100024f3          	csrr	s1,sstatus
    800083b4:	100027f3          	csrr	a5,sstatus
    800083b8:	ffd7f793          	andi	a5,a5,-3
    800083bc:	10079073          	csrw	sstatus,a5
    800083c0:	ffffe097          	auipc	ra,0xffffe
    800083c4:	710080e7          	jalr	1808(ra) # 80006ad0 <mycpu>
    800083c8:	07852783          	lw	a5,120(a0)
    800083cc:	02078663          	beqz	a5,800083f8 <push_off+0x5c>
    800083d0:	ffffe097          	auipc	ra,0xffffe
    800083d4:	700080e7          	jalr	1792(ra) # 80006ad0 <mycpu>
    800083d8:	07852783          	lw	a5,120(a0)
    800083dc:	01813083          	ld	ra,24(sp)
    800083e0:	01013403          	ld	s0,16(sp)
    800083e4:	0017879b          	addiw	a5,a5,1
    800083e8:	06f52c23          	sw	a5,120(a0)
    800083ec:	00813483          	ld	s1,8(sp)
    800083f0:	02010113          	addi	sp,sp,32
    800083f4:	00008067          	ret
    800083f8:	0014d493          	srli	s1,s1,0x1
    800083fc:	ffffe097          	auipc	ra,0xffffe
    80008400:	6d4080e7          	jalr	1748(ra) # 80006ad0 <mycpu>
    80008404:	0014f493          	andi	s1,s1,1
    80008408:	06952e23          	sw	s1,124(a0)
    8000840c:	fc5ff06f          	j	800083d0 <push_off+0x34>

0000000080008410 <pop_off>:
    80008410:	ff010113          	addi	sp,sp,-16
    80008414:	00813023          	sd	s0,0(sp)
    80008418:	00113423          	sd	ra,8(sp)
    8000841c:	01010413          	addi	s0,sp,16
    80008420:	ffffe097          	auipc	ra,0xffffe
    80008424:	6b0080e7          	jalr	1712(ra) # 80006ad0 <mycpu>
    80008428:	100027f3          	csrr	a5,sstatus
    8000842c:	0027f793          	andi	a5,a5,2
    80008430:	04079663          	bnez	a5,8000847c <pop_off+0x6c>
    80008434:	07852783          	lw	a5,120(a0)
    80008438:	02f05a63          	blez	a5,8000846c <pop_off+0x5c>
    8000843c:	fff7871b          	addiw	a4,a5,-1
    80008440:	06e52c23          	sw	a4,120(a0)
    80008444:	00071c63          	bnez	a4,8000845c <pop_off+0x4c>
    80008448:	07c52783          	lw	a5,124(a0)
    8000844c:	00078863          	beqz	a5,8000845c <pop_off+0x4c>
    80008450:	100027f3          	csrr	a5,sstatus
    80008454:	0027e793          	ori	a5,a5,2
    80008458:	10079073          	csrw	sstatus,a5
    8000845c:	00813083          	ld	ra,8(sp)
    80008460:	00013403          	ld	s0,0(sp)
    80008464:	01010113          	addi	sp,sp,16
    80008468:	00008067          	ret
    8000846c:	00001517          	auipc	a0,0x1
    80008470:	4b450513          	addi	a0,a0,1204 # 80009920 <digits+0x48>
    80008474:	fffff097          	auipc	ra,0xfffff
    80008478:	018080e7          	jalr	24(ra) # 8000748c <panic>
    8000847c:	00001517          	auipc	a0,0x1
    80008480:	48c50513          	addi	a0,a0,1164 # 80009908 <digits+0x30>
    80008484:	fffff097          	auipc	ra,0xfffff
    80008488:	008080e7          	jalr	8(ra) # 8000748c <panic>

000000008000848c <push_on>:
    8000848c:	fe010113          	addi	sp,sp,-32
    80008490:	00813823          	sd	s0,16(sp)
    80008494:	00113c23          	sd	ra,24(sp)
    80008498:	00913423          	sd	s1,8(sp)
    8000849c:	02010413          	addi	s0,sp,32
    800084a0:	100024f3          	csrr	s1,sstatus
    800084a4:	100027f3          	csrr	a5,sstatus
    800084a8:	0027e793          	ori	a5,a5,2
    800084ac:	10079073          	csrw	sstatus,a5
    800084b0:	ffffe097          	auipc	ra,0xffffe
    800084b4:	620080e7          	jalr	1568(ra) # 80006ad0 <mycpu>
    800084b8:	07852783          	lw	a5,120(a0)
    800084bc:	02078663          	beqz	a5,800084e8 <push_on+0x5c>
    800084c0:	ffffe097          	auipc	ra,0xffffe
    800084c4:	610080e7          	jalr	1552(ra) # 80006ad0 <mycpu>
    800084c8:	07852783          	lw	a5,120(a0)
    800084cc:	01813083          	ld	ra,24(sp)
    800084d0:	01013403          	ld	s0,16(sp)
    800084d4:	0017879b          	addiw	a5,a5,1
    800084d8:	06f52c23          	sw	a5,120(a0)
    800084dc:	00813483          	ld	s1,8(sp)
    800084e0:	02010113          	addi	sp,sp,32
    800084e4:	00008067          	ret
    800084e8:	0014d493          	srli	s1,s1,0x1
    800084ec:	ffffe097          	auipc	ra,0xffffe
    800084f0:	5e4080e7          	jalr	1508(ra) # 80006ad0 <mycpu>
    800084f4:	0014f493          	andi	s1,s1,1
    800084f8:	06952e23          	sw	s1,124(a0)
    800084fc:	fc5ff06f          	j	800084c0 <push_on+0x34>

0000000080008500 <pop_on>:
    80008500:	ff010113          	addi	sp,sp,-16
    80008504:	00813023          	sd	s0,0(sp)
    80008508:	00113423          	sd	ra,8(sp)
    8000850c:	01010413          	addi	s0,sp,16
    80008510:	ffffe097          	auipc	ra,0xffffe
    80008514:	5c0080e7          	jalr	1472(ra) # 80006ad0 <mycpu>
    80008518:	100027f3          	csrr	a5,sstatus
    8000851c:	0027f793          	andi	a5,a5,2
    80008520:	04078463          	beqz	a5,80008568 <pop_on+0x68>
    80008524:	07852783          	lw	a5,120(a0)
    80008528:	02f05863          	blez	a5,80008558 <pop_on+0x58>
    8000852c:	fff7879b          	addiw	a5,a5,-1
    80008530:	06f52c23          	sw	a5,120(a0)
    80008534:	07853783          	ld	a5,120(a0)
    80008538:	00079863          	bnez	a5,80008548 <pop_on+0x48>
    8000853c:	100027f3          	csrr	a5,sstatus
    80008540:	ffd7f793          	andi	a5,a5,-3
    80008544:	10079073          	csrw	sstatus,a5
    80008548:	00813083          	ld	ra,8(sp)
    8000854c:	00013403          	ld	s0,0(sp)
    80008550:	01010113          	addi	sp,sp,16
    80008554:	00008067          	ret
    80008558:	00001517          	auipc	a0,0x1
    8000855c:	3f050513          	addi	a0,a0,1008 # 80009948 <digits+0x70>
    80008560:	fffff097          	auipc	ra,0xfffff
    80008564:	f2c080e7          	jalr	-212(ra) # 8000748c <panic>
    80008568:	00001517          	auipc	a0,0x1
    8000856c:	3c050513          	addi	a0,a0,960 # 80009928 <digits+0x50>
    80008570:	fffff097          	auipc	ra,0xfffff
    80008574:	f1c080e7          	jalr	-228(ra) # 8000748c <panic>

0000000080008578 <__memset>:
    80008578:	ff010113          	addi	sp,sp,-16
    8000857c:	00813423          	sd	s0,8(sp)
    80008580:	01010413          	addi	s0,sp,16
    80008584:	1a060e63          	beqz	a2,80008740 <__memset+0x1c8>
    80008588:	40a007b3          	neg	a5,a0
    8000858c:	0077f793          	andi	a5,a5,7
    80008590:	00778693          	addi	a3,a5,7
    80008594:	00b00813          	li	a6,11
    80008598:	0ff5f593          	andi	a1,a1,255
    8000859c:	fff6071b          	addiw	a4,a2,-1
    800085a0:	1b06e663          	bltu	a3,a6,8000874c <__memset+0x1d4>
    800085a4:	1cd76463          	bltu	a4,a3,8000876c <__memset+0x1f4>
    800085a8:	1a078e63          	beqz	a5,80008764 <__memset+0x1ec>
    800085ac:	00b50023          	sb	a1,0(a0)
    800085b0:	00100713          	li	a4,1
    800085b4:	1ae78463          	beq	a5,a4,8000875c <__memset+0x1e4>
    800085b8:	00b500a3          	sb	a1,1(a0)
    800085bc:	00200713          	li	a4,2
    800085c0:	1ae78a63          	beq	a5,a4,80008774 <__memset+0x1fc>
    800085c4:	00b50123          	sb	a1,2(a0)
    800085c8:	00300713          	li	a4,3
    800085cc:	18e78463          	beq	a5,a4,80008754 <__memset+0x1dc>
    800085d0:	00b501a3          	sb	a1,3(a0)
    800085d4:	00400713          	li	a4,4
    800085d8:	1ae78263          	beq	a5,a4,8000877c <__memset+0x204>
    800085dc:	00b50223          	sb	a1,4(a0)
    800085e0:	00500713          	li	a4,5
    800085e4:	1ae78063          	beq	a5,a4,80008784 <__memset+0x20c>
    800085e8:	00b502a3          	sb	a1,5(a0)
    800085ec:	00700713          	li	a4,7
    800085f0:	18e79e63          	bne	a5,a4,8000878c <__memset+0x214>
    800085f4:	00b50323          	sb	a1,6(a0)
    800085f8:	00700e93          	li	t4,7
    800085fc:	00859713          	slli	a4,a1,0x8
    80008600:	00e5e733          	or	a4,a1,a4
    80008604:	01059e13          	slli	t3,a1,0x10
    80008608:	01c76e33          	or	t3,a4,t3
    8000860c:	01859313          	slli	t1,a1,0x18
    80008610:	006e6333          	or	t1,t3,t1
    80008614:	02059893          	slli	a7,a1,0x20
    80008618:	40f60e3b          	subw	t3,a2,a5
    8000861c:	011368b3          	or	a7,t1,a7
    80008620:	02859813          	slli	a6,a1,0x28
    80008624:	0108e833          	or	a6,a7,a6
    80008628:	03059693          	slli	a3,a1,0x30
    8000862c:	003e589b          	srliw	a7,t3,0x3
    80008630:	00d866b3          	or	a3,a6,a3
    80008634:	03859713          	slli	a4,a1,0x38
    80008638:	00389813          	slli	a6,a7,0x3
    8000863c:	00f507b3          	add	a5,a0,a5
    80008640:	00e6e733          	or	a4,a3,a4
    80008644:	000e089b          	sext.w	a7,t3
    80008648:	00f806b3          	add	a3,a6,a5
    8000864c:	00e7b023          	sd	a4,0(a5)
    80008650:	00878793          	addi	a5,a5,8
    80008654:	fed79ce3          	bne	a5,a3,8000864c <__memset+0xd4>
    80008658:	ff8e7793          	andi	a5,t3,-8
    8000865c:	0007871b          	sext.w	a4,a5
    80008660:	01d787bb          	addw	a5,a5,t4
    80008664:	0ce88e63          	beq	a7,a4,80008740 <__memset+0x1c8>
    80008668:	00f50733          	add	a4,a0,a5
    8000866c:	00b70023          	sb	a1,0(a4)
    80008670:	0017871b          	addiw	a4,a5,1
    80008674:	0cc77663          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    80008678:	00e50733          	add	a4,a0,a4
    8000867c:	00b70023          	sb	a1,0(a4)
    80008680:	0027871b          	addiw	a4,a5,2
    80008684:	0ac77e63          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    80008688:	00e50733          	add	a4,a0,a4
    8000868c:	00b70023          	sb	a1,0(a4)
    80008690:	0037871b          	addiw	a4,a5,3
    80008694:	0ac77663          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    80008698:	00e50733          	add	a4,a0,a4
    8000869c:	00b70023          	sb	a1,0(a4)
    800086a0:	0047871b          	addiw	a4,a5,4
    800086a4:	08c77e63          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    800086a8:	00e50733          	add	a4,a0,a4
    800086ac:	00b70023          	sb	a1,0(a4)
    800086b0:	0057871b          	addiw	a4,a5,5
    800086b4:	08c77663          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    800086b8:	00e50733          	add	a4,a0,a4
    800086bc:	00b70023          	sb	a1,0(a4)
    800086c0:	0067871b          	addiw	a4,a5,6
    800086c4:	06c77e63          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    800086c8:	00e50733          	add	a4,a0,a4
    800086cc:	00b70023          	sb	a1,0(a4)
    800086d0:	0077871b          	addiw	a4,a5,7
    800086d4:	06c77663          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    800086d8:	00e50733          	add	a4,a0,a4
    800086dc:	00b70023          	sb	a1,0(a4)
    800086e0:	0087871b          	addiw	a4,a5,8
    800086e4:	04c77e63          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    800086e8:	00e50733          	add	a4,a0,a4
    800086ec:	00b70023          	sb	a1,0(a4)
    800086f0:	0097871b          	addiw	a4,a5,9
    800086f4:	04c77663          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    800086f8:	00e50733          	add	a4,a0,a4
    800086fc:	00b70023          	sb	a1,0(a4)
    80008700:	00a7871b          	addiw	a4,a5,10
    80008704:	02c77e63          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    80008708:	00e50733          	add	a4,a0,a4
    8000870c:	00b70023          	sb	a1,0(a4)
    80008710:	00b7871b          	addiw	a4,a5,11
    80008714:	02c77663          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    80008718:	00e50733          	add	a4,a0,a4
    8000871c:	00b70023          	sb	a1,0(a4)
    80008720:	00c7871b          	addiw	a4,a5,12
    80008724:	00c77e63          	bgeu	a4,a2,80008740 <__memset+0x1c8>
    80008728:	00e50733          	add	a4,a0,a4
    8000872c:	00b70023          	sb	a1,0(a4)
    80008730:	00d7879b          	addiw	a5,a5,13
    80008734:	00c7f663          	bgeu	a5,a2,80008740 <__memset+0x1c8>
    80008738:	00f507b3          	add	a5,a0,a5
    8000873c:	00b78023          	sb	a1,0(a5)
    80008740:	00813403          	ld	s0,8(sp)
    80008744:	01010113          	addi	sp,sp,16
    80008748:	00008067          	ret
    8000874c:	00b00693          	li	a3,11
    80008750:	e55ff06f          	j	800085a4 <__memset+0x2c>
    80008754:	00300e93          	li	t4,3
    80008758:	ea5ff06f          	j	800085fc <__memset+0x84>
    8000875c:	00100e93          	li	t4,1
    80008760:	e9dff06f          	j	800085fc <__memset+0x84>
    80008764:	00000e93          	li	t4,0
    80008768:	e95ff06f          	j	800085fc <__memset+0x84>
    8000876c:	00000793          	li	a5,0
    80008770:	ef9ff06f          	j	80008668 <__memset+0xf0>
    80008774:	00200e93          	li	t4,2
    80008778:	e85ff06f          	j	800085fc <__memset+0x84>
    8000877c:	00400e93          	li	t4,4
    80008780:	e7dff06f          	j	800085fc <__memset+0x84>
    80008784:	00500e93          	li	t4,5
    80008788:	e75ff06f          	j	800085fc <__memset+0x84>
    8000878c:	00600e93          	li	t4,6
    80008790:	e6dff06f          	j	800085fc <__memset+0x84>

0000000080008794 <__memmove>:
    80008794:	ff010113          	addi	sp,sp,-16
    80008798:	00813423          	sd	s0,8(sp)
    8000879c:	01010413          	addi	s0,sp,16
    800087a0:	0e060863          	beqz	a2,80008890 <__memmove+0xfc>
    800087a4:	fff6069b          	addiw	a3,a2,-1
    800087a8:	0006881b          	sext.w	a6,a3
    800087ac:	0ea5e863          	bltu	a1,a0,8000889c <__memmove+0x108>
    800087b0:	00758713          	addi	a4,a1,7
    800087b4:	00a5e7b3          	or	a5,a1,a0
    800087b8:	40a70733          	sub	a4,a4,a0
    800087bc:	0077f793          	andi	a5,a5,7
    800087c0:	00f73713          	sltiu	a4,a4,15
    800087c4:	00174713          	xori	a4,a4,1
    800087c8:	0017b793          	seqz	a5,a5
    800087cc:	00e7f7b3          	and	a5,a5,a4
    800087d0:	10078863          	beqz	a5,800088e0 <__memmove+0x14c>
    800087d4:	00900793          	li	a5,9
    800087d8:	1107f463          	bgeu	a5,a6,800088e0 <__memmove+0x14c>
    800087dc:	0036581b          	srliw	a6,a2,0x3
    800087e0:	fff8081b          	addiw	a6,a6,-1
    800087e4:	02081813          	slli	a6,a6,0x20
    800087e8:	01d85893          	srli	a7,a6,0x1d
    800087ec:	00858813          	addi	a6,a1,8
    800087f0:	00058793          	mv	a5,a1
    800087f4:	00050713          	mv	a4,a0
    800087f8:	01088833          	add	a6,a7,a6
    800087fc:	0007b883          	ld	a7,0(a5)
    80008800:	00878793          	addi	a5,a5,8
    80008804:	00870713          	addi	a4,a4,8
    80008808:	ff173c23          	sd	a7,-8(a4)
    8000880c:	ff0798e3          	bne	a5,a6,800087fc <__memmove+0x68>
    80008810:	ff867713          	andi	a4,a2,-8
    80008814:	02071793          	slli	a5,a4,0x20
    80008818:	0207d793          	srli	a5,a5,0x20
    8000881c:	00f585b3          	add	a1,a1,a5
    80008820:	40e686bb          	subw	a3,a3,a4
    80008824:	00f507b3          	add	a5,a0,a5
    80008828:	06e60463          	beq	a2,a4,80008890 <__memmove+0xfc>
    8000882c:	0005c703          	lbu	a4,0(a1)
    80008830:	00e78023          	sb	a4,0(a5)
    80008834:	04068e63          	beqz	a3,80008890 <__memmove+0xfc>
    80008838:	0015c603          	lbu	a2,1(a1)
    8000883c:	00100713          	li	a4,1
    80008840:	00c780a3          	sb	a2,1(a5)
    80008844:	04e68663          	beq	a3,a4,80008890 <__memmove+0xfc>
    80008848:	0025c603          	lbu	a2,2(a1)
    8000884c:	00200713          	li	a4,2
    80008850:	00c78123          	sb	a2,2(a5)
    80008854:	02e68e63          	beq	a3,a4,80008890 <__memmove+0xfc>
    80008858:	0035c603          	lbu	a2,3(a1)
    8000885c:	00300713          	li	a4,3
    80008860:	00c781a3          	sb	a2,3(a5)
    80008864:	02e68663          	beq	a3,a4,80008890 <__memmove+0xfc>
    80008868:	0045c603          	lbu	a2,4(a1)
    8000886c:	00400713          	li	a4,4
    80008870:	00c78223          	sb	a2,4(a5)
    80008874:	00e68e63          	beq	a3,a4,80008890 <__memmove+0xfc>
    80008878:	0055c603          	lbu	a2,5(a1)
    8000887c:	00500713          	li	a4,5
    80008880:	00c782a3          	sb	a2,5(a5)
    80008884:	00e68663          	beq	a3,a4,80008890 <__memmove+0xfc>
    80008888:	0065c703          	lbu	a4,6(a1)
    8000888c:	00e78323          	sb	a4,6(a5)
    80008890:	00813403          	ld	s0,8(sp)
    80008894:	01010113          	addi	sp,sp,16
    80008898:	00008067          	ret
    8000889c:	02061713          	slli	a4,a2,0x20
    800088a0:	02075713          	srli	a4,a4,0x20
    800088a4:	00e587b3          	add	a5,a1,a4
    800088a8:	f0f574e3          	bgeu	a0,a5,800087b0 <__memmove+0x1c>
    800088ac:	02069613          	slli	a2,a3,0x20
    800088b0:	02065613          	srli	a2,a2,0x20
    800088b4:	fff64613          	not	a2,a2
    800088b8:	00e50733          	add	a4,a0,a4
    800088bc:	00c78633          	add	a2,a5,a2
    800088c0:	fff7c683          	lbu	a3,-1(a5)
    800088c4:	fff78793          	addi	a5,a5,-1
    800088c8:	fff70713          	addi	a4,a4,-1
    800088cc:	00d70023          	sb	a3,0(a4)
    800088d0:	fec798e3          	bne	a5,a2,800088c0 <__memmove+0x12c>
    800088d4:	00813403          	ld	s0,8(sp)
    800088d8:	01010113          	addi	sp,sp,16
    800088dc:	00008067          	ret
    800088e0:	02069713          	slli	a4,a3,0x20
    800088e4:	02075713          	srli	a4,a4,0x20
    800088e8:	00170713          	addi	a4,a4,1
    800088ec:	00e50733          	add	a4,a0,a4
    800088f0:	00050793          	mv	a5,a0
    800088f4:	0005c683          	lbu	a3,0(a1)
    800088f8:	00178793          	addi	a5,a5,1
    800088fc:	00158593          	addi	a1,a1,1
    80008900:	fed78fa3          	sb	a3,-1(a5)
    80008904:	fee798e3          	bne	a5,a4,800088f4 <__memmove+0x160>
    80008908:	f89ff06f          	j	80008890 <__memmove+0xfc>
	...
