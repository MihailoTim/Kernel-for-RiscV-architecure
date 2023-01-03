
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	c9813103          	ld	sp,-872(sp) # 8000bc98 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	608060ef          	jal	ra,80006624 <start>

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
    800010a8:	3ec030ef          	jal	ra,80004494 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	3b4080e7          	jalr	948(ra) # 80002534 <_ZN5Buddy4freeEPvm>
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
    800011e0:	18460613          	addi	a2,a2,388 # 80009360 <CONSOLE_STATUS+0x350>
    800011e4:	0005059b          	sext.w	a1,a0
    800011e8:	00008517          	auipc	a0,0x8
    800011ec:	e3850513          	addi	a0,a0,-456 # 80009020 <CONSOLE_STATUS+0x10>
    800011f0:	00004097          	auipc	ra,0x4
    800011f4:	d60080e7          	jalr	-672(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011f8:	00008617          	auipc	a2,0x8
    800011fc:	16860613          	addi	a2,a2,360 # 80009360 <CONSOLE_STATUS+0x350>
    80001200:	01892583          	lw	a1,24(s2)
    80001204:	00008517          	auipc	a0,0x8
    80001208:	e2c50513          	addi	a0,a0,-468 # 80009030 <CONSOLE_STATUS+0x20>
    8000120c:	00004097          	auipc	ra,0x4
    80001210:	d44080e7          	jalr	-700(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    80001214:	00008617          	auipc	a2,0x8
    80001218:	14c60613          	addi	a2,a2,332 # 80009360 <CONSOLE_STATUS+0x350>
    8000121c:	01092583          	lw	a1,16(s2)
    80001220:	00008517          	auipc	a0,0x8
    80001224:	e2850513          	addi	a0,a0,-472 # 80009048 <CONSOLE_STATUS+0x38>
    80001228:	00004097          	auipc	ra,0x4
    8000122c:	d28080e7          	jalr	-728(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    80001230:	00008617          	auipc	a2,0x8
    80001234:	13060613          	addi	a2,a2,304 # 80009360 <CONSOLE_STATUS+0x350>
    80001238:	03800593          	li	a1,56
    8000123c:	00008517          	auipc	a0,0x8
    80001240:	e2450513          	addi	a0,a0,-476 # 80009060 <CONSOLE_STATUS+0x50>
    80001244:	00004097          	auipc	ra,0x4
    80001248:	d0c080e7          	jalr	-756(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000124c:	00008617          	auipc	a2,0x8
    80001250:	11460613          	addi	a2,a2,276 # 80009360 <CONSOLE_STATUS+0x350>
    80001254:	02892583          	lw	a1,40(s2)
    80001258:	00008517          	auipc	a0,0x8
    8000125c:	e2050513          	addi	a0,a0,-480 # 80009078 <CONSOLE_STATUS+0x68>
    80001260:	00004097          	auipc	ra,0x4
    80001264:	cf0080e7          	jalr	-784(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    80001268:	00008617          	auipc	a2,0x8
    8000126c:	0f860613          	addi	a2,a2,248 # 80009360 <CONSOLE_STATUS+0x350>
    80001270:	02092583          	lw	a1,32(s2)
    80001274:	00008517          	auipc	a0,0x8
    80001278:	e1450513          	addi	a0,a0,-492 # 80009088 <CONSOLE_STATUS+0x78>
    8000127c:	00004097          	auipc	ra,0x4
    80001280:	cd4080e7          	jalr	-812(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        ConsoleUtil::printString("Allocated status array:\n");
    80001284:	00008517          	auipc	a0,0x8
    80001288:	e2450513          	addi	a0,a0,-476 # 800090a8 <CONSOLE_STATUS+0x98>
    8000128c:	00004097          	auipc	ra,0x4
    80001290:	ba4080e7          	jalr	-1116(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
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
    800012b4:	0f050513          	addi	a0,a0,240 # 800093a0 <CONSOLE_STATUS+0x390>
    800012b8:	00004097          	auipc	ra,0x4
    800012bc:	c98080e7          	jalr	-872(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012c0:	00148493          	addi	s1,s1,1
    800012c4:	01893783          	ld	a5,24(s2)
    800012c8:	0037d793          	srli	a5,a5,0x3
    800012cc:	00178793          	addi	a5,a5,1
    800012d0:	fcf4e6e3          	bltu	s1,a5,8000129c <_ZN13SlabAllocator9printSlabEP4Slab+0xe0>
        }
        ConsoleUtil::printString("\n");
    800012d4:	00008517          	auipc	a0,0x8
    800012d8:	08c50513          	addi	a0,a0,140 # 80009360 <CONSOLE_STATUS+0x350>
    800012dc:	00004097          	auipc	ra,0x4
    800012e0:	b54080e7          	jalr	-1196(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
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
    80001328:	b0c080e7          	jalr	-1268(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    8000132c:	00090513          	mv	a0,s2
    80001330:	00004097          	auipc	ra,0x4
    80001334:	b00080e7          	jalr	-1280(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001338:	00008517          	auipc	a0,0x8
    8000133c:	02850513          	addi	a0,a0,40 # 80009360 <CONSOLE_STATUS+0x350>
    80001340:	00004097          	auipc	ra,0x4
    80001344:	af0080e7          	jalr	-1296(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001348:	00008617          	auipc	a2,0x8
    8000134c:	01860613          	addi	a2,a2,24 # 80009360 <CONSOLE_STATUS+0x350>
    80001350:	0000b797          	auipc	a5,0xb
    80001354:	9187b783          	ld	a5,-1768(a5) # 8000bc68 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001358:	0007a583          	lw	a1,0(a5)
    8000135c:	00008517          	auipc	a0,0x8
    80001360:	d7c50513          	addi	a0,a0,-644 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001364:	00004097          	auipc	ra,0x4
    80001368:	bec080e7          	jalr	-1044(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	00008617          	auipc	a2,0x8
    80001370:	ff460613          	addi	a2,a2,-12 # 80009360 <CONSOLE_STATUS+0x350>
    80001374:	0009059b          	sext.w	a1,s2
    80001378:	00008517          	auipc	a0,0x8
    8000137c:	d7850513          	addi	a0,a0,-648 # 800090f0 <CONSOLE_STATUS+0xe0>
    80001380:	00004097          	auipc	ra,0x4
    80001384:	bd0080e7          	jalr	-1072(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    80001388:	00008617          	auipc	a2,0x8
    8000138c:	fd860613          	addi	a2,a2,-40 # 80009360 <CONSOLE_STATUS+0x350>
    80001390:	04892583          	lw	a1,72(s2)
    80001394:	00008517          	auipc	a0,0x8
    80001398:	d6c50513          	addi	a0,a0,-660 # 80009100 <CONSOLE_STATUS+0xf0>
    8000139c:	00004097          	auipc	ra,0x4
    800013a0:	bb4080e7          	jalr	-1100(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013a4:	00008617          	auipc	a2,0x8
    800013a8:	fbc60613          	addi	a2,a2,-68 # 80009360 <CONSOLE_STATUS+0x350>
    800013ac:	04092583          	lw	a1,64(s2)
    800013b0:	00008517          	auipc	a0,0x8
    800013b4:	d6850513          	addi	a0,a0,-664 # 80009118 <CONSOLE_STATUS+0x108>
    800013b8:	00004097          	auipc	ra,0x4
    800013bc:	b98080e7          	jalr	-1128(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013c0:	00008617          	auipc	a2,0x8
    800013c4:	fa060613          	addi	a2,a2,-96 # 80009360 <CONSOLE_STATUS+0x350>
    800013c8:	06092583          	lw	a1,96(s2)
    800013cc:	00008517          	auipc	a0,0x8
    800013d0:	d6450513          	addi	a0,a0,-668 # 80009130 <CONSOLE_STATUS+0x120>
    800013d4:	00004097          	auipc	ra,0x4
    800013d8:	b7c080e7          	jalr	-1156(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    800013dc:	06093483          	ld	s1,96(s2)
    while(iter){
    800013e0:	02048463          	beqz	s1,80001408 <_ZN13SlabAllocator10printCacheEP5Cache+0x108>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013e4:	00008617          	auipc	a2,0x8
    800013e8:	d0460613          	addi	a2,a2,-764 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013ec:	0004859b          	sext.w	a1,s1
    800013f0:	00008517          	auipc	a0,0x8
    800013f4:	fb050513          	addi	a0,a0,-80 # 800093a0 <CONSOLE_STATUS+0x390>
    800013f8:	00004097          	auipc	ra,0x4
    800013fc:	b58080e7          	jalr	-1192(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001400:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001404:	fddff06f          	j	800013e0 <_ZN13SlabAllocator10printCacheEP5Cache+0xe0>
    }
    ConsoleUtil::printString("\n");
    80001408:	00008517          	auipc	a0,0x8
    8000140c:	f5850513          	addi	a0,a0,-168 # 80009360 <CONSOLE_STATUS+0x350>
    80001410:	00004097          	auipc	ra,0x4
    80001414:	a20080e7          	jalr	-1504(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    80001418:	00008617          	auipc	a2,0x8
    8000141c:	f4860613          	addi	a2,a2,-184 # 80009360 <CONSOLE_STATUS+0x350>
    80001420:	06892583          	lw	a1,104(s2)
    80001424:	00008517          	auipc	a0,0x8
    80001428:	d1c50513          	addi	a0,a0,-740 # 80009140 <CONSOLE_STATUS+0x130>
    8000142c:	00004097          	auipc	ra,0x4
    80001430:	b24080e7          	jalr	-1244(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    80001434:	06893483          	ld	s1,104(s2)
    while(iter){
    80001438:	02048463          	beqz	s1,80001460 <_ZN13SlabAllocator10printCacheEP5Cache+0x160>
        ConsoleUtil::print("", (uint64)iter, " ");
    8000143c:	00008617          	auipc	a2,0x8
    80001440:	cac60613          	addi	a2,a2,-852 # 800090e8 <CONSOLE_STATUS+0xd8>
    80001444:	0004859b          	sext.w	a1,s1
    80001448:	00008517          	auipc	a0,0x8
    8000144c:	f5850513          	addi	a0,a0,-168 # 800093a0 <CONSOLE_STATUS+0x390>
    80001450:	00004097          	auipc	ra,0x4
    80001454:	b00080e7          	jalr	-1280(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001458:	0084b483          	ld	s1,8(s1)
    while(iter){
    8000145c:	fddff06f          	j	80001438 <_ZN13SlabAllocator10printCacheEP5Cache+0x138>
    }
    ConsoleUtil::printString("\n");
    80001460:	00008517          	auipc	a0,0x8
    80001464:	f0050513          	addi	a0,a0,-256 # 80009360 <CONSOLE_STATUS+0x350>
    80001468:	00004097          	auipc	ra,0x4
    8000146c:	9c8080e7          	jalr	-1592(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001470:	00008617          	auipc	a2,0x8
    80001474:	ef060613          	addi	a2,a2,-272 # 80009360 <CONSOLE_STATUS+0x350>
    80001478:	07092583          	lw	a1,112(s2)
    8000147c:	00008517          	auipc	a0,0x8
    80001480:	cd450513          	addi	a0,a0,-812 # 80009150 <CONSOLE_STATUS+0x140>
    80001484:	00004097          	auipc	ra,0x4
    80001488:	acc080e7          	jalr	-1332(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    8000148c:	07093483          	ld	s1,112(s2)
    while(iter){
    80001490:	02048463          	beqz	s1,800014b8 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b8>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001494:	00008617          	auipc	a2,0x8
    80001498:	c5460613          	addi	a2,a2,-940 # 800090e8 <CONSOLE_STATUS+0xd8>
    8000149c:	0004859b          	sext.w	a1,s1
    800014a0:	00008517          	auipc	a0,0x8
    800014a4:	f0050513          	addi	a0,a0,-256 # 800093a0 <CONSOLE_STATUS+0x390>
    800014a8:	00004097          	auipc	ra,0x4
    800014ac:	aa8080e7          	jalr	-1368(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800014b0:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014b4:	fddff06f          	j	80001490 <_ZN13SlabAllocator10printCacheEP5Cache+0x190>
    }
    ConsoleUtil::printString("\n");
    800014b8:	00008517          	auipc	a0,0x8
    800014bc:	ea850513          	addi	a0,a0,-344 # 80009360 <CONSOLE_STATUS+0x350>
    800014c0:	00004097          	auipc	ra,0x4
    800014c4:	970080e7          	jalr	-1680(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    800014c8:	00008617          	auipc	a2,0x8
    800014cc:	e9860613          	addi	a2,a2,-360 # 80009360 <CONSOLE_STATUS+0x350>
    800014d0:	04092583          	lw	a1,64(s2)
    800014d4:	00008517          	auipc	a0,0x8
    800014d8:	c8c50513          	addi	a0,a0,-884 # 80009160 <CONSOLE_STATUS+0x150>
    800014dc:	00004097          	auipc	ra,0x4
    800014e0:	a74080e7          	jalr	-1420(ra) # 80004f50 <_ZN11ConsoleUtil5printEPKciS1_>
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
    80001554:	0bc080e7          	jalr	188(ra) # 8000260c <_ZN5Buddy5allocEm>
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
    if(cache->ctor)
    800015d0:	0509b783          	ld	a5,80(s3)
    800015d4:	02078e63          	beqz	a5,80001610 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
        for(uint64 i=0;i<slab->totalNumOfSlots;i++) {
    800015d8:	00000913          	li	s2,0
    800015dc:	0184b783          	ld	a5,24(s1)
    800015e0:	02f97c63          	bgeu	s2,a5,80001618 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
            cache->ctor((void*)((uint64)slab->objectOffset + i*slab->parent->objectSize));
    800015e4:	0509b703          	ld	a4,80(s3)
    800015e8:	0284b503          	ld	a0,40(s1)
    800015ec:	0304b783          	ld	a5,48(s1)
    800015f0:	0407b783          	ld	a5,64(a5)
    800015f4:	032787b3          	mul	a5,a5,s2
    800015f8:	00f50533          	add	a0,a0,a5
    800015fc:	000700e7          	jalr	a4
        for(uint64 i=0;i<slab->totalNumOfSlots;i++) {
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
    800018e0:	46478793          	addi	a5,a5,1124 # 8000bd40 <_ZN13SlabAllocator5sizeNE>
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
    80001944:	46853503          	ld	a0,1128(a0) # 8000bda8 <_ZN13SlabAllocator5cacheE>
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
    80001980:	f4c080e7          	jalr	-180(ra) # 800048c8 <_Z6strcpyPKcPc>
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
    800019d0:	870080e7          	jalr	-1936(ra) # 8000223c <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    800019d4:	0000a797          	auipc	a5,0xa
    800019d8:	36c78793          	addi	a5,a5,876 # 8000bd40 <_ZN13SlabAllocator5sizeNE>
    800019dc:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800019e0:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800019e4:	0000a717          	auipc	a4,0xa
    800019e8:	28473703          	ld	a4,644(a4) # 8000bc68 <_GLOBAL_OFFSET_TABLE_+0x18>
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
    80001a30:	e9c080e7          	jalr	-356(ra) # 800048c8 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a34:	00000493          	li	s1,0
    80001a38:	0440006f          	j	80001a7c <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a3c:	00349913          	slli	s2,s1,0x3
    80001a40:	0000a797          	auipc	a5,0xa
    80001a44:	09078793          	addi	a5,a5,144 # 8000bad0 <_ZN13SlabAllocator5namesE>
    80001a48:	012787b3          	add	a5,a5,s2
    80001a4c:	00000693          	li	a3,0
    80001a50:	00000613          	li	a2,0
    80001a54:	00200593          	li	a1,2
    80001a58:	009595bb          	sllw	a1,a1,s1
    80001a5c:	0007b503          	ld	a0,0(a5)
    80001a60:	00000097          	auipc	ra,0x0
    80001a64:	eac080e7          	jalr	-340(ra) # 8000190c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a68:	0000a797          	auipc	a5,0xa
    80001a6c:	2d878793          	addi	a5,a5,728 # 8000bd40 <_ZN13SlabAllocator5sizeNE>
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
    80001b78:	9c0080e7          	jalr	-1600(ra) # 80002534 <_ZN5Buddy4freeEPvm>
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
    80001ca8:	09c78793          	addi	a5,a5,156 # 8000bd40 <_ZN13SlabAllocator5sizeNE>
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
    80001d1c:	81c080e7          	jalr	-2020(ra) # 80002534 <_ZN5Buddy4freeEPvm>
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
    80001d48:	00000097          	auipc	ra,0x0
    80001d4c:	7ec080e7          	jalr	2028(ra) # 80002534 <_ZN5Buddy4freeEPvm>
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
    80001d78:	00000097          	auipc	ra,0x0
    80001d7c:	7bc080e7          	jalr	1980(ra) # 80002534 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d80:	00093783          	ld	a5,0(s2)
    80001d84:	0087b783          	ld	a5,8(a5)
    80001d88:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d8c:	fddff06f          	j	80001d68 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001d90:	0004b583          	ld	a1,0(s1)
    80001d94:	0000a517          	auipc	a0,0xa
    80001d98:	01453503          	ld	a0,20(a0) # 8000bda8 <_ZN13SlabAllocator5cacheE>
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
    80002120:	ee0080e7          	jalr	-288(ra) # 80002ffc <_ZN3TCB11thread_freeEPv>
    80002124:	00813083          	ld	ra,8(sp)
    80002128:	00013403          	ld	s0,0(sp)
    8000212c:	01010113          	addi	sp,sp,16
    80002130:	00008067          	ret

0000000080002134 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002134:	ff010113          	addi	sp,sp,-16
    80002138:	00113423          	sd	ra,8(sp)
    8000213c:	00813023          	sd	s0,0(sp)
    80002140:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80002144:	00004097          	auipc	ra,0x4
    80002148:	e28080e7          	jalr	-472(ra) # 80005f6c <_Z8userMainv>
    8000214c:	00813083          	ld	ra,8(sp)
    80002150:	00013403          	ld	s0,0(sp)
    80002154:	01010113          	addi	sp,sp,16
    80002158:	00008067          	ret

000000008000215c <_ZN6SystemC1Ev>:
    if (!initialized) {
    8000215c:	0000a797          	auipc	a5,0xa
    80002160:	c647c783          	lbu	a5,-924(a5) # 8000bdc0 <_ZN6System11initializedE>
    80002164:	00078463          	beqz	a5,8000216c <_ZN6SystemC1Ev+0x10>
    80002168:	00008067          	ret
System::System() {
    8000216c:	fe010113          	addi	sp,sp,-32
    80002170:	00113c23          	sd	ra,24(sp)
    80002174:	00813823          	sd	s0,16(sp)
    80002178:	02010413          	addi	s0,sp,32
        initialized = true;
    8000217c:	00100793          	li	a5,1
    80002180:	0000a717          	auipc	a4,0xa
    80002184:	c4f70023          	sb	a5,-960(a4) # 8000bdc0 <_ZN6System11initializedE>
        RiscV::initialize();
    80002188:	00002097          	auipc	ra,0x2
    8000218c:	82c080e7          	jalr	-2004(ra) # 800039b4 <_ZN5RiscV10initializeEv>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80002190:	00000613          	li	a2,0
    80002194:	00000597          	auipc	a1,0x0
    80002198:	fa058593          	addi	a1,a1,-96 # 80002134 <_ZN6System15userMainWrapperEPv>
    8000219c:	fe840513          	addi	a0,s0,-24
    800021a0:	00000097          	auipc	ra,0x0
    800021a4:	c7c080e7          	jalr	-900(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    800021a8:	fe843783          	ld	a5,-24(s0)
    800021ac:	0107a703          	lw	a4,16(a5)
    800021b0:	00200793          	li	a5,2
    800021b4:	00f70863          	beq	a4,a5,800021c4 <_ZN6SystemC1Ev+0x68>
            thread_dispatch();
    800021b8:	00000097          	auipc	ra,0x0
    800021bc:	d08080e7          	jalr	-760(ra) # 80001ec0 <_Z15thread_dispatchv>
    800021c0:	fe9ff06f          	j	800021a8 <_ZN6SystemC1Ev+0x4c>
        RiscV::finalize();
    800021c4:	00002097          	auipc	ra,0x2
    800021c8:	9f4080e7          	jalr	-1548(ra) # 80003bb8 <_ZN5RiscV8finalizeEv>
}
    800021cc:	01813083          	ld	ra,24(sp)
    800021d0:	01013403          	ld	s0,16(sp)
    800021d4:	02010113          	addi	sp,sp,32
    800021d8:	00008067          	ret

00000000800021dc <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    800021dc:	ff010113          	addi	sp,sp,-16
    800021e0:	00813423          	sd	s0,8(sp)
    800021e4:	01010413          	addi	s0,sp,16
    800021e8:	00100793          	li	a5,1
    800021ec:	00f50863          	beq	a0,a5,800021fc <_Z41__static_initialization_and_destruction_0ii+0x20>
    800021f0:	00813403          	ld	s0,8(sp)
    800021f4:	01010113          	addi	sp,sp,16
    800021f8:	00008067          	ret
    800021fc:	000107b7          	lui	a5,0x10
    80002200:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002204:	fef596e3          	bne	a1,a5,800021f0 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80002208:	0000a797          	auipc	a5,0xa
    8000220c:	a607b783          	ld	a5,-1440(a5) # 8000bc68 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002210:	0007b703          	ld	a4,0(a5)
    80002214:	00c75793          	srli	a5,a4,0xc
    80002218:	00278793          	addi	a5,a5,2
    8000221c:	00c79793          	slli	a5,a5,0xc
    80002220:	0000a697          	auipc	a3,0xa
    80002224:	ba868693          	addi	a3,a3,-1112 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002228:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    8000222c:	fffff7b7          	lui	a5,0xfffff
    80002230:	00f77733          	and	a4,a4,a5
    80002234:	00e6b423          	sd	a4,8(a3)
    80002238:	fb9ff06f          	j	800021f0 <_Z41__static_initialization_and_destruction_0ii+0x14>

000000008000223c <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    8000223c:	ff010113          	addi	sp,sp,-16
    80002240:	00813423          	sd	s0,8(sp)
    80002244:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80002248:	0000a717          	auipc	a4,0xa
    8000224c:	b8070713          	addi	a4,a4,-1152 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002250:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002254:	0000a797          	auipc	a5,0xa
    80002258:	a147b783          	ld	a5,-1516(a5) # 8000bc68 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000225c:	0007b783          	ld	a5,0(a5)
    80002260:	fffff6b7          	lui	a3,0xfffff
    80002264:	00d7f7b3          	and	a5,a5,a3
    80002268:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    8000226c:	0000a797          	auipc	a5,0xa
    80002270:	8cb7b623          	sd	a1,-1844(a5) # 8000bb38 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80002274:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80002278:	00000713          	li	a4,0
        while(num>1){
    8000227c:	00100693          	li	a3,1
    80002280:	00f6f863          	bgeu	a3,a5,80002290 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80002284:	0017d793          	srli	a5,a5,0x1
            deg++;
    80002288:	00170713          	addi	a4,a4,1
        while(num>1){
    8000228c:	ff1ff06f          	j	8000227c <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80002290:	00371713          	slli	a4,a4,0x3
    80002294:	0000a797          	auipc	a5,0xa
    80002298:	b3478793          	addi	a5,a5,-1228 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000229c:	00e78733          	add	a4,a5,a4
    800022a0:	00a73823          	sd	a0,16(a4)
    800022a4:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800022a8:	00000713          	li	a4,0
        while(num>1){
    800022ac:	00100693          	li	a3,1
    800022b0:	00f6f863          	bgeu	a3,a5,800022c0 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    800022b4:	0017d793          	srli	a5,a5,0x1
            deg++;
    800022b8:	00170713          	addi	a4,a4,1
        while(num>1){
    800022bc:	ff1ff06f          	j	800022ac <_ZN5Buddy10initializeEPvm+0x70>
    800022c0:	00371713          	slli	a4,a4,0x3
    800022c4:	0000a797          	auipc	a5,0xa
    800022c8:	b0478793          	addi	a5,a5,-1276 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022cc:	00e78733          	add	a4,a5,a4
    800022d0:	06a73c23          	sd	a0,120(a4)
    800022d4:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800022d8:	00000713          	li	a4,0
        while(num>1){
    800022dc:	00100693          	li	a3,1
    800022e0:	00f6f863          	bgeu	a3,a5,800022f0 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    800022e4:	0017d793          	srli	a5,a5,0x1
            deg++;
    800022e8:	00170713          	addi	a4,a4,1
        while(num>1){
    800022ec:	ff1ff06f          	j	800022dc <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    800022f0:	00371713          	slli	a4,a4,0x3
    800022f4:	0000a797          	auipc	a5,0xa
    800022f8:	ad478793          	addi	a5,a5,-1324 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022fc:	00e78733          	add	a4,a5,a4
    80002300:	01073783          	ld	a5,16(a4)
    80002304:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80002308:	00000793          	li	a5,0
    8000230c:	00c0006f          	j	80002318 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80002310:	0015d593          	srli	a1,a1,0x1
            deg++;
    80002314:	00178793          	addi	a5,a5,1
        while(num>1){
    80002318:	00100713          	li	a4,1
    8000231c:	feb76ae3          	bltu	a4,a1,80002310 <_ZN5Buddy10initializeEPvm+0xd4>
    80002320:	00379793          	slli	a5,a5,0x3
    80002324:	0000a717          	auipc	a4,0xa
    80002328:	aa470713          	addi	a4,a4,-1372 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000232c:	00f707b3          	add	a5,a4,a5
    80002330:	0787b783          	ld	a5,120(a5)
    80002334:	0007b023          	sd	zero,0(a5)
}
    80002338:	00813403          	ld	s0,8(sp)
    8000233c:	01010113          	addi	sp,sp,16
    80002340:	00008067          	ret

0000000080002344 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80002344:	00c00793          	li	a5,12
    80002348:	10f50063          	beq	a0,a5,80002448 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    8000234c:	fd010113          	addi	sp,sp,-48
    80002350:	02113423          	sd	ra,40(sp)
    80002354:	02813023          	sd	s0,32(sp)
    80002358:	00913c23          	sd	s1,24(sp)
    8000235c:	01213823          	sd	s2,16(sp)
    80002360:	01313423          	sd	s3,8(sp)
    80002364:	03010413          	addi	s0,sp,48
    80002368:	00050913          	mv	s2,a0
    Block *curr = head[size];
    8000236c:	00351713          	slli	a4,a0,0x3
    80002370:	0000a797          	auipc	a5,0xa
    80002374:	a5878793          	addi	a5,a5,-1448 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002378:	00e787b3          	add	a5,a5,a4
    8000237c:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002380:	00000993          	li	s3,0
    80002384:	0180006f          	j	8000239c <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002388:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    8000238c:	04f70463          	beq	a4,a5,800023d4 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002390:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002394:	08f70063          	beq	a4,a5,80002414 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002398:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    8000239c:	08048863          	beqz	s1,8000242c <_ZN5Buddy8compressEm+0xe8>
    800023a0:	0004b683          	ld	a3,0(s1)
    800023a4:	08068463          	beqz	a3,8000242c <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800023a8:	0000a797          	auipc	a5,0xa
    800023ac:	a207b783          	ld	a5,-1504(a5) # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023b0:	40f48733          	sub	a4,s1,a5
    800023b4:	00c9061b          	addiw	a2,s2,12
    800023b8:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    800023bc:	40f687b3          	sub	a5,a3,a5
    800023c0:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    800023c4:	00177613          	andi	a2,a4,1
    800023c8:	fc0610e3          	bnez	a2,80002388 <_ZN5Buddy8compressEm+0x44>
    800023cc:	00170713          	addi	a4,a4,1
    800023d0:	fbdff06f          	j	8000238c <_ZN5Buddy8compressEm+0x48>
            if(prev){
    800023d4:	00098863          	beqz	s3,800023e4 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    800023d8:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7fff1e00>
    800023dc:	00d9b023          	sd	a3,0(s3)
    800023e0:	fb5ff06f          	j	80002394 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    800023e4:	0006b603          	ld	a2,0(a3)
    800023e8:	00391593          	slli	a1,s2,0x3
    800023ec:	0000a697          	auipc	a3,0xa
    800023f0:	9dc68693          	addi	a3,a3,-1572 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023f4:	00b686b3          	add	a3,a3,a1
    800023f8:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    800023fc:	f8061ce3          	bnez	a2,80002394 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    80002400:	0000a697          	auipc	a3,0xa
    80002404:	9c868693          	addi	a3,a3,-1592 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002408:	00b686b3          	add	a3,a3,a1
    8000240c:	0006b823          	sd	zero,16(a3)
    80002410:	f85ff06f          	j	80002394 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002414:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80002418:	00190593          	addi	a1,s2,1
    8000241c:	00048513          	mv	a0,s1
    80002420:	00000097          	auipc	ra,0x0
    80002424:	02c080e7          	jalr	44(ra) # 8000244c <_ZN5Buddy6insertEPvm>
    80002428:	f71ff06f          	j	80002398 <_ZN5Buddy8compressEm+0x54>
}
    8000242c:	02813083          	ld	ra,40(sp)
    80002430:	02013403          	ld	s0,32(sp)
    80002434:	01813483          	ld	s1,24(sp)
    80002438:	01013903          	ld	s2,16(sp)
    8000243c:	00813983          	ld	s3,8(sp)
    80002440:	03010113          	addi	sp,sp,48
    80002444:	00008067          	ret
    80002448:	00008067          	ret

000000008000244c <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    8000244c:	00050693          	mv	a3,a0
    if(!head[size]){
    80002450:	00359713          	slli	a4,a1,0x3
    80002454:	0000a797          	auipc	a5,0xa
    80002458:	97478793          	addi	a5,a5,-1676 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000245c:	00e787b3          	add	a5,a5,a4
    80002460:	0787b783          	ld	a5,120(a5)
    80002464:	02078c63          	beqz	a5,8000249c <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002468:	ff010113          	addi	sp,sp,-16
    8000246c:	00113423          	sd	ra,8(sp)
    80002470:	00813023          	sd	s0,0(sp)
    80002474:	01010413          	addi	s0,sp,16
    80002478:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    8000247c:	00068713          	mv	a4,a3
    80002480:	04f6e063          	bltu	a3,a5,800024c0 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002484:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002488:	06078863          	beqz	a5,800024f8 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    8000248c:	04f76c63          	bltu	a4,a5,800024e4 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002490:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002494:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002498:	ff1ff06f          	j	80002488 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    8000249c:	0000a797          	auipc	a5,0xa
    800024a0:	92c78793          	addi	a5,a5,-1748 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024a4:	00e78533          	add	a0,a5,a4
    800024a8:	00d53823          	sd	a3,16(a0) # 1010 <_entry-0x7fffeff0>
    800024ac:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    800024b0:	0006b023          	sd	zero,0(a3)
    800024b4:	07853783          	ld	a5,120(a0)
    800024b8:	0007b023          	sd	zero,0(a5)
        return;
    800024bc:	00008067          	ret
            newHead->next = head[size];
    800024c0:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800024c4:	00359713          	slli	a4,a1,0x3
    800024c8:	0000a797          	auipc	a5,0xa
    800024cc:	90078793          	addi	a5,a5,-1792 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024d0:	00e787b3          	add	a5,a5,a4
    800024d4:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    800024d8:	00000097          	auipc	ra,0x0
    800024dc:	e6c080e7          	jalr	-404(ra) # 80002344 <_ZN5Buddy8compressEm>
            return;
    800024e0:	0440006f          	j	80002524 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    800024e4:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800024e8:	00d63023          	sd	a3,0(a2)
                    compress(size);
    800024ec:	00000097          	auipc	ra,0x0
    800024f0:	e58080e7          	jalr	-424(ra) # 80002344 <_ZN5Buddy8compressEm>
                    return;
    800024f4:	0300006f          	j	80002524 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    800024f8:	00351713          	slli	a4,a0,0x3
    800024fc:	0000a797          	auipc	a5,0xa
    80002500:	8cc78793          	addi	a5,a5,-1844 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002504:	00e787b3          	add	a5,a5,a4
    80002508:	0107b703          	ld	a4,16(a5)
    8000250c:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80002510:	0107b703          	ld	a4,16(a5)
    80002514:	00073703          	ld	a4,0(a4)
    80002518:	00e7b823          	sd	a4,16(a5)
    compress(size);
    8000251c:	00000097          	auipc	ra,0x0
    80002520:	e28080e7          	jalr	-472(ra) # 80002344 <_ZN5Buddy8compressEm>
}
    80002524:	00813083          	ld	ra,8(sp)
    80002528:	00013403          	ld	s0,0(sp)
    8000252c:	01010113          	addi	sp,sp,16
    80002530:	00008067          	ret

0000000080002534 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80002534:	02050663          	beqz	a0,80002560 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80002538:	ff010113          	addi	sp,sp,-16
    8000253c:	00113423          	sd	ra,8(sp)
    80002540:	00813023          	sd	s0,0(sp)
    80002544:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80002548:	00000097          	auipc	ra,0x0
    8000254c:	f04080e7          	jalr	-252(ra) # 8000244c <_ZN5Buddy6insertEPvm>
}
    80002550:	00813083          	ld	ra,8(sp)
    80002554:	00013403          	ld	s0,0(sp)
    80002558:	01010113          	addi	sp,sp,16
    8000255c:	00008067          	ret
    80002560:	00008067          	ret

0000000080002564 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002564:	ff010113          	addi	sp,sp,-16
    80002568:	00813423          	sd	s0,8(sp)
    8000256c:	01010413          	addi	s0,sp,16
    80002570:	03c0006f          	j	800025ac <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002574:	00b5859b          	addiw	a1,a1,11
    80002578:	00100713          	li	a4,1
    8000257c:	00b715bb          	sllw	a1,a4,a1
    80002580:	00b505b3          	add	a1,a0,a1
    80002584:	00379693          	slli	a3,a5,0x3
    80002588:	0000a717          	auipc	a4,0xa
    8000258c:	84070713          	addi	a4,a4,-1984 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002590:	00d70733          	add	a4,a4,a3
    80002594:	00b73823          	sd	a1,16(a4)
    80002598:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    8000259c:	0005b023          	sd	zero,0(a1)
    800025a0:	07873703          	ld	a4,120(a4)
    800025a4:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800025a8:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    800025ac:	fff5879b          	addiw	a5,a1,-1
    800025b0:	04c7c863          	blt	a5,a2,80002600 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    800025b4:	00379693          	slli	a3,a5,0x3
    800025b8:	0000a717          	auipc	a4,0xa
    800025bc:	81070713          	addi	a4,a4,-2032 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025c0:	00d70733          	add	a4,a4,a3
    800025c4:	01073683          	ld	a3,16(a4)
    800025c8:	fa0686e3          	beqz	a3,80002574 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800025cc:	00b5859b          	addiw	a1,a1,11
    800025d0:	00100713          	li	a4,1
    800025d4:	00b715bb          	sllw	a1,a4,a1
    800025d8:	00b505b3          	add	a1,a0,a1
    800025dc:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800025e0:	00379693          	slli	a3,a5,0x3
    800025e4:	00009717          	auipc	a4,0x9
    800025e8:	7e470713          	addi	a4,a4,2020 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025ec:	00d70733          	add	a4,a4,a3
    800025f0:	01073683          	ld	a3,16(a4)
    800025f4:	0006b683          	ld	a3,0(a3)
    800025f8:	00d73823          	sd	a3,16(a4)
    800025fc:	fadff06f          	j	800025a8 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80002600:	00813403          	ld	s0,8(sp)
    80002604:	01010113          	addi	sp,sp,16
    80002608:	00008067          	ret

000000008000260c <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    8000260c:	fe010113          	addi	sp,sp,-32
    80002610:	00113c23          	sd	ra,24(sp)
    80002614:	00813823          	sd	s0,16(sp)
    80002618:	00913423          	sd	s1,8(sp)
    8000261c:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80002620:	00c00793          	li	a5,12
    80002624:	06a7ec63          	bltu	a5,a0,8000269c <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002628:	00050593          	mv	a1,a0
    8000262c:	00c00793          	li	a5,12
    80002630:	06b7ea63          	bltu	a5,a1,800026a4 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80002634:	00359713          	slli	a4,a1,0x3
    80002638:	00009797          	auipc	a5,0x9
    8000263c:	79078793          	addi	a5,a5,1936 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002640:	00e787b3          	add	a5,a5,a4
    80002644:	0787b483          	ld	s1,120(a5)
    80002648:	00049663          	bnez	s1,80002654 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    8000264c:	00158593          	addi	a1,a1,1
    80002650:	fddff06f          	j	8000262c <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80002654:	0004b703          	ld	a4,0(s1)
    80002658:	00359693          	slli	a3,a1,0x3
    8000265c:	00009797          	auipc	a5,0x9
    80002660:	76c78793          	addi	a5,a5,1900 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002664:	00d787b3          	add	a5,a5,a3
    80002668:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    8000266c:	00070e63          	beqz	a4,80002688 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002670:	0005061b          	sext.w	a2,a0
    80002674:	0005859b          	sext.w	a1,a1
    80002678:	00048513          	mv	a0,s1
    8000267c:	00000097          	auipc	ra,0x0
    80002680:	ee8080e7          	jalr	-280(ra) # 80002564 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002684:	0240006f          	j	800026a8 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002688:	00009797          	auipc	a5,0x9
    8000268c:	74078793          	addi	a5,a5,1856 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002690:	00d787b3          	add	a5,a5,a3
    80002694:	0007b823          	sd	zero,16(a5)
    80002698:	fd9ff06f          	j	80002670 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    8000269c:	00000493          	li	s1,0
    800026a0:	0080006f          	j	800026a8 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    800026a4:	00000493          	li	s1,0
}
    800026a8:	00048513          	mv	a0,s1
    800026ac:	01813083          	ld	ra,24(sp)
    800026b0:	01013403          	ld	s0,16(sp)
    800026b4:	00813483          	ld	s1,8(sp)
    800026b8:	02010113          	addi	sp,sp,32
    800026bc:	00008067          	ret

00000000800026c0 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    800026c0:	fe010113          	addi	sp,sp,-32
    800026c4:	00113c23          	sd	ra,24(sp)
    800026c8:	00813823          	sd	s0,16(sp)
    800026cc:	00913423          	sd	s1,8(sp)
    800026d0:	01213023          	sd	s2,0(sp)
    800026d4:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    800026d8:	00000913          	li	s2,0
    800026dc:	0180006f          	j	800026f4 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800026e0:	00007517          	auipc	a0,0x7
    800026e4:	c8050513          	addi	a0,a0,-896 # 80009360 <CONSOLE_STATUS+0x350>
    800026e8:	00002097          	auipc	ra,0x2
    800026ec:	748080e7          	jalr	1864(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800026f0:	0019091b          	addiw	s2,s2,1
    800026f4:	00c00793          	li	a5,12
    800026f8:	0727c663          	blt	a5,s2,80002764 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800026fc:	00000613          	li	a2,0
    80002700:	00a00593          	li	a1,10
    80002704:	00090513          	mv	a0,s2
    80002708:	00002097          	auipc	ra,0x2
    8000270c:	76c080e7          	jalr	1900(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002710:	00007517          	auipc	a0,0x7
    80002714:	ba850513          	addi	a0,a0,-1112 # 800092b8 <CONSOLE_STATUS+0x2a8>
    80002718:	00002097          	auipc	ra,0x2
    8000271c:	718080e7          	jalr	1816(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002720:	00391713          	slli	a4,s2,0x3
    80002724:	00009797          	auipc	a5,0x9
    80002728:	6a478793          	addi	a5,a5,1700 # 8000bdc8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000272c:	00e787b3          	add	a5,a5,a4
    80002730:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002734:	fa0486e3          	beqz	s1,800026e0 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    80002738:	00000613          	li	a2,0
    8000273c:	00a00593          	li	a1,10
    80002740:	0004851b          	sext.w	a0,s1
    80002744:	00002097          	auipc	ra,0x2
    80002748:	730080e7          	jalr	1840(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    8000274c:	00007517          	auipc	a0,0x7
    80002750:	99c50513          	addi	a0,a0,-1636 # 800090e8 <CONSOLE_STATUS+0xd8>
    80002754:	00002097          	auipc	ra,0x2
    80002758:	6dc080e7          	jalr	1756(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    8000275c:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002760:	fd5ff06f          	j	80002734 <_ZN5Buddy9printListEv+0x74>
    80002764:	01813083          	ld	ra,24(sp)
    80002768:	01013403          	ld	s0,16(sp)
    8000276c:	00813483          	ld	s1,8(sp)
    80002770:	00013903          	ld	s2,0(sp)
    80002774:	02010113          	addi	sp,sp,32
    80002778:	00008067          	ret

000000008000277c <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    8000277c:	ff010113          	addi	sp,sp,-16
    80002780:	00113423          	sd	ra,8(sp)
    80002784:	00813023          	sd	s0,0(sp)
    80002788:	01010413          	addi	s0,sp,16
    8000278c:	000105b7          	lui	a1,0x10
    80002790:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002794:	00100513          	li	a0,1
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	a44080e7          	jalr	-1468(ra) # 800021dc <_Z41__static_initialization_and_destruction_0ii>
    800027a0:	00813083          	ld	ra,8(sp)
    800027a4:	00013403          	ld	s0,0(sp)
    800027a8:	01010113          	addi	sp,sp,16
    800027ac:	00008067          	ret

00000000800027b0 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800027b0:	fe010113          	addi	sp,sp,-32
    800027b4:	00113c23          	sd	ra,24(sp)
    800027b8:	00813823          	sd	s0,16(sp)
    800027bc:	00913423          	sd	s1,8(sp)
    800027c0:	02010413          	addi	s0,sp,32
    800027c4:	00050493          	mv	s1,a0
    LOCK();
    800027c8:	00100613          	li	a2,1
    800027cc:	00000593          	li	a1,0
    800027d0:	00009517          	auipc	a0,0x9
    800027d4:	6d850513          	addi	a0,a0,1752 # 8000bea8 <lockPrint>
    800027d8:	fffff097          	auipc	ra,0xfffff
    800027dc:	828080e7          	jalr	-2008(ra) # 80001000 <copy_and_swap>
    800027e0:	fe0514e3          	bnez	a0,800027c8 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800027e4:	0004c503          	lbu	a0,0(s1)
    800027e8:	00050a63          	beqz	a0,800027fc <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800027ec:	00000097          	auipc	ra,0x0
    800027f0:	8ac080e7          	jalr	-1876(ra) # 80002098 <_Z4putcc>
        string++;
    800027f4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800027f8:	fedff06f          	j	800027e4 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800027fc:	00000613          	li	a2,0
    80002800:	00100593          	li	a1,1
    80002804:	00009517          	auipc	a0,0x9
    80002808:	6a450513          	addi	a0,a0,1700 # 8000bea8 <lockPrint>
    8000280c:	ffffe097          	auipc	ra,0xffffe
    80002810:	7f4080e7          	jalr	2036(ra) # 80001000 <copy_and_swap>
    80002814:	fe0514e3          	bnez	a0,800027fc <_Z11printStringPKc+0x4c>
}
    80002818:	01813083          	ld	ra,24(sp)
    8000281c:	01013403          	ld	s0,16(sp)
    80002820:	00813483          	ld	s1,8(sp)
    80002824:	02010113          	addi	sp,sp,32
    80002828:	00008067          	ret

000000008000282c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000282c:	fd010113          	addi	sp,sp,-48
    80002830:	02113423          	sd	ra,40(sp)
    80002834:	02813023          	sd	s0,32(sp)
    80002838:	00913c23          	sd	s1,24(sp)
    8000283c:	01213823          	sd	s2,16(sp)
    80002840:	01313423          	sd	s3,8(sp)
    80002844:	01413023          	sd	s4,0(sp)
    80002848:	03010413          	addi	s0,sp,48
    8000284c:	00050993          	mv	s3,a0
    80002850:	00058a13          	mv	s4,a1
    LOCK();
    80002854:	00100613          	li	a2,1
    80002858:	00000593          	li	a1,0
    8000285c:	00009517          	auipc	a0,0x9
    80002860:	64c50513          	addi	a0,a0,1612 # 8000bea8 <lockPrint>
    80002864:	ffffe097          	auipc	ra,0xffffe
    80002868:	79c080e7          	jalr	1948(ra) # 80001000 <copy_and_swap>
    8000286c:	fe0514e3          	bnez	a0,80002854 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002870:	00000913          	li	s2,0
    80002874:	00090493          	mv	s1,s2
    80002878:	0019091b          	addiw	s2,s2,1
    8000287c:	03495a63          	bge	s2,s4,800028b0 <_Z9getStringPci+0x84>
        cc = getc();
    80002880:	fffff097          	auipc	ra,0xfffff
    80002884:	7f0080e7          	jalr	2032(ra) # 80002070 <_Z4getcv>
        if(cc < 1)
    80002888:	02050463          	beqz	a0,800028b0 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    8000288c:	009984b3          	add	s1,s3,s1
    80002890:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002894:	00a00793          	li	a5,10
    80002898:	00f50a63          	beq	a0,a5,800028ac <_Z9getStringPci+0x80>
    8000289c:	00d00793          	li	a5,13
    800028a0:	fcf51ae3          	bne	a0,a5,80002874 <_Z9getStringPci+0x48>
        buf[i++] = c;
    800028a4:	00090493          	mv	s1,s2
    800028a8:	0080006f          	j	800028b0 <_Z9getStringPci+0x84>
    800028ac:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800028b0:	009984b3          	add	s1,s3,s1
    800028b4:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800028b8:	00000613          	li	a2,0
    800028bc:	00100593          	li	a1,1
    800028c0:	00009517          	auipc	a0,0x9
    800028c4:	5e850513          	addi	a0,a0,1512 # 8000bea8 <lockPrint>
    800028c8:	ffffe097          	auipc	ra,0xffffe
    800028cc:	738080e7          	jalr	1848(ra) # 80001000 <copy_and_swap>
    800028d0:	fe0514e3          	bnez	a0,800028b8 <_Z9getStringPci+0x8c>
    return buf;
}
    800028d4:	00098513          	mv	a0,s3
    800028d8:	02813083          	ld	ra,40(sp)
    800028dc:	02013403          	ld	s0,32(sp)
    800028e0:	01813483          	ld	s1,24(sp)
    800028e4:	01013903          	ld	s2,16(sp)
    800028e8:	00813983          	ld	s3,8(sp)
    800028ec:	00013a03          	ld	s4,0(sp)
    800028f0:	03010113          	addi	sp,sp,48
    800028f4:	00008067          	ret

00000000800028f8 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800028f8:	ff010113          	addi	sp,sp,-16
    800028fc:	00813423          	sd	s0,8(sp)
    80002900:	01010413          	addi	s0,sp,16
    80002904:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002908:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000290c:	0006c603          	lbu	a2,0(a3)
    80002910:	fd06071b          	addiw	a4,a2,-48
    80002914:	0ff77713          	andi	a4,a4,255
    80002918:	00900793          	li	a5,9
    8000291c:	02e7e063          	bltu	a5,a4,8000293c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002920:	0025179b          	slliw	a5,a0,0x2
    80002924:	00a787bb          	addw	a5,a5,a0
    80002928:	0017979b          	slliw	a5,a5,0x1
    8000292c:	00168693          	addi	a3,a3,1
    80002930:	00c787bb          	addw	a5,a5,a2
    80002934:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002938:	fd5ff06f          	j	8000290c <_Z11stringToIntPKc+0x14>
    return n;
}
    8000293c:	00813403          	ld	s0,8(sp)
    80002940:	01010113          	addi	sp,sp,16
    80002944:	00008067          	ret

0000000080002948 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002948:	fc010113          	addi	sp,sp,-64
    8000294c:	02113c23          	sd	ra,56(sp)
    80002950:	02813823          	sd	s0,48(sp)
    80002954:	02913423          	sd	s1,40(sp)
    80002958:	03213023          	sd	s2,32(sp)
    8000295c:	01313c23          	sd	s3,24(sp)
    80002960:	04010413          	addi	s0,sp,64
    80002964:	00050493          	mv	s1,a0
    80002968:	00058913          	mv	s2,a1
    8000296c:	00060993          	mv	s3,a2
    LOCK();
    80002970:	00100613          	li	a2,1
    80002974:	00000593          	li	a1,0
    80002978:	00009517          	auipc	a0,0x9
    8000297c:	53050513          	addi	a0,a0,1328 # 8000bea8 <lockPrint>
    80002980:	ffffe097          	auipc	ra,0xffffe
    80002984:	680080e7          	jalr	1664(ra) # 80001000 <copy_and_swap>
    80002988:	fe0514e3          	bnez	a0,80002970 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000298c:	00098463          	beqz	s3,80002994 <_Z8printIntiii+0x4c>
    80002990:	0804c463          	bltz	s1,80002a18 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002994:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002998:	00000593          	li	a1,0
    }

    i = 0;
    8000299c:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800029a0:	0009079b          	sext.w	a5,s2
    800029a4:	0325773b          	remuw	a4,a0,s2
    800029a8:	00048613          	mv	a2,s1
    800029ac:	0014849b          	addiw	s1,s1,1
    800029b0:	02071693          	slli	a3,a4,0x20
    800029b4:	0206d693          	srli	a3,a3,0x20
    800029b8:	00009717          	auipc	a4,0x9
    800029bc:	18870713          	addi	a4,a4,392 # 8000bb40 <digits>
    800029c0:	00d70733          	add	a4,a4,a3
    800029c4:	00074683          	lbu	a3,0(a4)
    800029c8:	fd040713          	addi	a4,s0,-48
    800029cc:	00c70733          	add	a4,a4,a2
    800029d0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800029d4:	0005071b          	sext.w	a4,a0
    800029d8:	0325553b          	divuw	a0,a0,s2
    800029dc:	fcf772e3          	bgeu	a4,a5,800029a0 <_Z8printIntiii+0x58>
    if(neg)
    800029e0:	00058c63          	beqz	a1,800029f8 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800029e4:	fd040793          	addi	a5,s0,-48
    800029e8:	009784b3          	add	s1,a5,s1
    800029ec:	02d00793          	li	a5,45
    800029f0:	fef48823          	sb	a5,-16(s1)
    800029f4:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800029f8:	fff4849b          	addiw	s1,s1,-1
    800029fc:	0204c463          	bltz	s1,80002a24 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002a00:	fd040793          	addi	a5,s0,-48
    80002a04:	009787b3          	add	a5,a5,s1
    80002a08:	ff07c503          	lbu	a0,-16(a5)
    80002a0c:	fffff097          	auipc	ra,0xfffff
    80002a10:	68c080e7          	jalr	1676(ra) # 80002098 <_Z4putcc>
    80002a14:	fe5ff06f          	j	800029f8 <_Z8printIntiii+0xb0>
        x = -xx;
    80002a18:	4090053b          	negw	a0,s1
        neg = 1;
    80002a1c:	00100593          	li	a1,1
        x = -xx;
    80002a20:	f7dff06f          	j	8000299c <_Z8printIntiii+0x54>

    UNLOCK();
    80002a24:	00000613          	li	a2,0
    80002a28:	00100593          	li	a1,1
    80002a2c:	00009517          	auipc	a0,0x9
    80002a30:	47c50513          	addi	a0,a0,1148 # 8000bea8 <lockPrint>
    80002a34:	ffffe097          	auipc	ra,0xffffe
    80002a38:	5cc080e7          	jalr	1484(ra) # 80001000 <copy_and_swap>
    80002a3c:	fe0514e3          	bnez	a0,80002a24 <_Z8printIntiii+0xdc>
    80002a40:	03813083          	ld	ra,56(sp)
    80002a44:	03013403          	ld	s0,48(sp)
    80002a48:	02813483          	ld	s1,40(sp)
    80002a4c:	02013903          	ld	s2,32(sp)
    80002a50:	01813983          	ld	s3,24(sp)
    80002a54:	04010113          	addi	sp,sp,64
    80002a58:	00008067          	ret

0000000080002a5c <_ZN3SCB10initializeEv>:
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"

kmem_cache_t* SCB::scbCache = nullptr;

void SCB::initialize() {
    80002a5c:	ff010113          	addi	sp,sp,-16
    80002a60:	00113423          	sd	ra,8(sp)
    80002a64:	00813023          	sd	s0,0(sp)
    80002a68:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), nullptr, nullptr);
    80002a6c:	00000693          	li	a3,0
    80002a70:	00000613          	li	a2,0
    80002a74:	01800593          	li	a1,24
    80002a78:	00007517          	auipc	a0,0x7
    80002a7c:	84850513          	addi	a0,a0,-1976 # 800092c0 <CONSOLE_STATUS+0x2b0>
    80002a80:	00002097          	auipc	ra,0x2
    80002a84:	580080e7          	jalr	1408(ra) # 80005000 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002a88:	00009797          	auipc	a5,0x9
    80002a8c:	42a7b423          	sd	a0,1064(a5) # 8000beb0 <_ZN3SCB8scbCacheE>
}
    80002a90:	00813083          	ld	ra,8(sp)
    80002a94:	00013403          	ld	s0,0(sp)
    80002a98:	01010113          	addi	sp,sp,16
    80002a9c:	00008067          	ret

0000000080002aa0 <_ZN3SCBC1Em>:

SCB::SCB(uint64 init){
    80002aa0:	ff010113          	addi	sp,sp,-16
    80002aa4:	00813423          	sd	s0,8(sp)
    80002aa8:	01010413          	addi	s0,sp,16
    val = init;
    80002aac:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80002ab0:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    80002ab4:	00053823          	sd	zero,16(a0)
}
    80002ab8:	00813403          	ld	s0,8(sp)
    80002abc:	01010113          	addi	sp,sp,16
    80002ac0:	00008067          	ret

0000000080002ac4 <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    80002ac4:	fe010113          	addi	sp,sp,-32
    80002ac8:	00113c23          	sd	ra,24(sp)
    80002acc:	00813823          	sd	s0,16(sp)
    80002ad0:	00913423          	sd	s1,8(sp)
    80002ad4:	01213023          	sd	s2,0(sp)
    80002ad8:	02010413          	addi	s0,sp,32
    80002adc:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002ae0:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002ae4:	02050063          	beqz	a0,80002b04 <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    80002ae8:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002aec:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002af0:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002af4:	00002097          	auipc	ra,0x2
    80002af8:	e78080e7          	jalr	-392(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002afc:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002b00:	fe5ff06f          	j	80002ae4 <_ZN3SCBD1Ev+0x20>
    }
}
    80002b04:	01813083          	ld	ra,24(sp)
    80002b08:	01013403          	ld	s0,16(sp)
    80002b0c:	00813483          	ld	s1,8(sp)
    80002b10:	00013903          	ld	s2,0(sp)
    80002b14:	02010113          	addi	sp,sp,32
    80002b18:	00008067          	ret

0000000080002b1c <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    80002b1c:	ff010113          	addi	sp,sp,-16
    80002b20:	00113423          	sd	ra,8(sp)
    80002b24:	00813023          	sd	s0,0(sp)
    80002b28:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002b2c:	00853783          	ld	a5,8(a0)
    80002b30:	04078063          	beqz	a5,80002b70 <_ZN3SCB5blockEv+0x54>
    80002b34:	01053703          	ld	a4,16(a0)
    80002b38:	00009797          	auipc	a5,0x9
    80002b3c:	1a07b783          	ld	a5,416(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002b40:	0007b783          	ld	a5,0(a5)
    80002b44:	04f73423          	sd	a5,72(a4)
    80002b48:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002b4c:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002b50:	00300713          	li	a4,3
    80002b54:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002b58:	00000097          	auipc	ra,0x0
    80002b5c:	2d4080e7          	jalr	724(ra) # 80002e2c <_ZN3TCB8dispatchEv>
}
    80002b60:	00813083          	ld	ra,8(sp)
    80002b64:	00013403          	ld	s0,0(sp)
    80002b68:	01010113          	addi	sp,sp,16
    80002b6c:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002b70:	00009797          	auipc	a5,0x9
    80002b74:	1687b783          	ld	a5,360(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002b78:	0007b783          	ld	a5,0(a5)
    80002b7c:	00f53423          	sd	a5,8(a0)
    80002b80:	fc9ff06f          	j	80002b48 <_ZN3SCB5blockEv+0x2c>

0000000080002b84 <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80002b84:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002b88:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002b8c:	04853703          	ld	a4,72(a0)
    80002b90:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002b94:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002b98:	02050a63          	beqz	a0,80002bcc <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002b9c:	ff010113          	addi	sp,sp,-16
    80002ba0:	00113423          	sd	ra,8(sp)
    80002ba4:	00813023          	sd	s0,0(sp)
    80002ba8:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002bac:	00100793          	li	a5,1
    80002bb0:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002bb4:	00002097          	auipc	ra,0x2
    80002bb8:	db8080e7          	jalr	-584(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
    }
}
    80002bbc:	00813083          	ld	ra,8(sp)
    80002bc0:	00013403          	ld	s0,0(sp)
    80002bc4:	01010113          	addi	sp,sp,16
    80002bc8:	00008067          	ret
    80002bcc:	00008067          	ret

0000000080002bd0 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80002bd0:	00009797          	auipc	a5,0x9
    80002bd4:	1087b783          	ld	a5,264(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002bd8:	0007b783          	ld	a5,0(a5)
    80002bdc:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002be0:	00052783          	lw	a5,0(a0)
    80002be4:	fff7879b          	addiw	a5,a5,-1
    80002be8:	00f52023          	sw	a5,0(a0)
    80002bec:	02079713          	slli	a4,a5,0x20
    80002bf0:	00074463          	bltz	a4,80002bf8 <_ZN3SCB4waitEv+0x28>
    80002bf4:	00008067          	ret
void SCB::wait() {
    80002bf8:	ff010113          	addi	sp,sp,-16
    80002bfc:	00113423          	sd	ra,8(sp)
    80002c00:	00813023          	sd	s0,0(sp)
    80002c04:	01010413          	addi	s0,sp,16
        block();
    80002c08:	00000097          	auipc	ra,0x0
    80002c0c:	f14080e7          	jalr	-236(ra) # 80002b1c <_ZN3SCB5blockEv>
}
    80002c10:	00813083          	ld	ra,8(sp)
    80002c14:	00013403          	ld	s0,0(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	00008067          	ret

0000000080002c20 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80002c20:	00052783          	lw	a5,0(a0)
    80002c24:	0017871b          	addiw	a4,a5,1
    80002c28:	00e52023          	sw	a4,0(a0)
    80002c2c:	0007c463          	bltz	a5,80002c34 <_ZN3SCB6signalEv+0x14>
    80002c30:	00008067          	ret
void SCB::signal(){
    80002c34:	ff010113          	addi	sp,sp,-16
    80002c38:	00113423          	sd	ra,8(sp)
    80002c3c:	00813023          	sd	s0,0(sp)
    80002c40:	01010413          	addi	s0,sp,16
        deblock();
    80002c44:	00000097          	auipc	ra,0x0
    80002c48:	f40080e7          	jalr	-192(ra) # 80002b84 <_ZN3SCB7deblockEv>
}
    80002c4c:	00813083          	ld	ra,8(sp)
    80002c50:	00013403          	ld	s0,0(sp)
    80002c54:	01010113          	addi	sp,sp,16
    80002c58:	00008067          	ret

0000000080002c5c <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    80002c5c:	ff010113          	addi	sp,sp,-16
    80002c60:	00113423          	sd	ra,8(sp)
    80002c64:	00813023          	sd	s0,0(sp)
    80002c68:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    80002c6c:	00009517          	auipc	a0,0x9
    80002c70:	24453503          	ld	a0,580(a0) # 8000beb0 <_ZN3SCB8scbCacheE>
    80002c74:	00002097          	auipc	ra,0x2
    80002c78:	3b4080e7          	jalr	948(ra) # 80005028 <_Z16kmem_cache_allocP5Cache>
}
    80002c7c:	00813083          	ld	ra,8(sp)
    80002c80:	00013403          	ld	s0,0(sp)
    80002c84:	01010113          	addi	sp,sp,16
    80002c88:	00008067          	ret

0000000080002c8c <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    80002c8c:	ff010113          	addi	sp,sp,-16
    80002c90:	00113423          	sd	ra,8(sp)
    80002c94:	00813023          	sd	s0,0(sp)
    80002c98:	01010413          	addi	s0,sp,16
    80002c9c:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    80002ca0:	00009517          	auipc	a0,0x9
    80002ca4:	21053503          	ld	a0,528(a0) # 8000beb0 <_ZN3SCB8scbCacheE>
    80002ca8:	00002097          	auipc	ra,0x2
    80002cac:	3a8080e7          	jalr	936(ra) # 80005050 <_Z15kmem_cache_freeP5CachePv>
}
    80002cb0:	00813083          	ld	ra,8(sp)
    80002cb4:	00013403          	ld	s0,0(sp)
    80002cb8:	01010113          	addi	sp,sp,16
    80002cbc:	00008067          	ret

0000000080002cc0 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002cc0:	ff010113          	addi	sp,sp,-16
    80002cc4:	00813423          	sd	s0,8(sp)
    80002cc8:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002ccc:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002cd0:	05200513          	li	a0,82
    asm("ecall");
    80002cd4:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80002cd8:	00050513          	mv	a0,a0
    return status;
}
    80002cdc:	0005051b          	sext.w	a0,a0
    80002ce0:	00813403          	ld	s0,8(sp)
    80002ce4:	01010113          	addi	sp,sp,16
    80002ce8:	00008067          	ret

0000000080002cec <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002cec:	fe010113          	addi	sp,sp,-32
    80002cf0:	00113c23          	sd	ra,24(sp)
    80002cf4:	00813823          	sd	s0,16(sp)
    80002cf8:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002cfc:	fe840513          	addi	a0,s0,-24
    80002d00:	fffff097          	auipc	ra,0xfffff
    80002d04:	45c080e7          	jalr	1116(ra) # 8000215c <_ZN6SystemC1Ev>

    return 0;
    80002d08:	00000513          	li	a0,0
    80002d0c:	01813083          	ld	ra,24(sp)
    80002d10:	01013403          	ld	s0,16(sp)
    80002d14:	02010113          	addi	sp,sp,32
    80002d18:	00008067          	ret

0000000080002d1c <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002d1c:	ff010113          	addi	sp,sp,-16
    80002d20:	00113423          	sd	ra,8(sp)
    80002d24:	00813023          	sd	s0,0(sp)
    80002d28:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002d2c:	00001097          	auipc	ra,0x1
    80002d30:	d14080e7          	jalr	-748(ra) # 80003a40 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    80002d34:	00009797          	auipc	a5,0x9
    80002d38:	1847b783          	ld	a5,388(a5) # 8000beb8 <_ZN3TCB7runningE>
    80002d3c:	0187b703          	ld	a4,24(a5)
    80002d40:	0207b503          	ld	a0,32(a5)
    80002d44:	000700e7          	jalr	a4

    thread_exit();
    80002d48:	fffff097          	auipc	ra,0xfffff
    80002d4c:	150080e7          	jalr	336(ra) # 80001e98 <_Z11thread_exitv>
}
    80002d50:	00813083          	ld	ra,8(sp)
    80002d54:	00013403          	ld	s0,0(sp)
    80002d58:	01010113          	addi	sp,sp,16
    80002d5c:	00008067          	ret

0000000080002d60 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002d60:	ff010113          	addi	sp,sp,-16
    80002d64:	00813423          	sd	s0,8(sp)
    80002d68:	01010413          	addi	s0,sp,16
    80002d6c:	04053823          	sd	zero,80(a0)
    80002d70:	04053c23          	sd	zero,88(a0)
    80002d74:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002d78:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002d7c:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002d80:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002d84:	04058263          	beqz	a1,80002dc8 <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    80002d88:	00068793          	mv	a5,a3
    80002d8c:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    80002d90:	00100793          	li	a5,1
    80002d94:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    80002d98:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002d9c:	02058a63          	beqz	a1,80002dd0 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    80002da0:	000017b7          	lui	a5,0x1
    80002da4:	00f686b3          	add	a3,a3,a5
    80002da8:	00d53023          	sd	a3,0(a0)
    80002dac:	00000797          	auipc	a5,0x0
    80002db0:	f7078793          	addi	a5,a5,-144 # 80002d1c <_ZN3TCB7wrapperEPv>
    80002db4:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002db8:	00052a23          	sw	zero,20(a0)
}
    80002dbc:	00813403          	ld	s0,8(sp)
    80002dc0:	01010113          	addi	sp,sp,16
    80002dc4:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002dc8:	00000793          	li	a5,0
    80002dcc:	fc1ff06f          	j	80002d8c <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002dd0:	00000693          	li	a3,0
    80002dd4:	fd5ff06f          	j	80002da8 <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

0000000080002dd8 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002dd8:	ff010113          	addi	sp,sp,-16
    80002ddc:	00113423          	sd	ra,8(sp)
    80002de0:	00813023          	sd	s0,0(sp)
    80002de4:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002de8:	02853503          	ld	a0,40(a0)
    80002dec:	00002097          	auipc	ra,0x2
    80002df0:	334080e7          	jalr	820(ra) # 80005120 <_Z5kfreePKv>
}
    80002df4:	00813083          	ld	ra,8(sp)
    80002df8:	00013403          	ld	s0,0(sp)
    80002dfc:	01010113          	addi	sp,sp,16
    80002e00:	00008067          	ret

0000000080002e04 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002e04:	ff010113          	addi	sp,sp,-16
    80002e08:	00113423          	sd	ra,8(sp)
    80002e0c:	00813023          	sd	s0,0(sp)
    80002e10:	01010413          	addi	s0,sp,16
    free();
    80002e14:	00000097          	auipc	ra,0x0
    80002e18:	fc4080e7          	jalr	-60(ra) # 80002dd8 <_ZN3TCB4freeEv>
}
    80002e1c:	00813083          	ld	ra,8(sp)
    80002e20:	00013403          	ld	s0,0(sp)
    80002e24:	01010113          	addi	sp,sp,16
    80002e28:	00008067          	ret

0000000080002e2c <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002e2c:	fe010113          	addi	sp,sp,-32
    80002e30:	00113c23          	sd	ra,24(sp)
    80002e34:	00813823          	sd	s0,16(sp)
    80002e38:	00913423          	sd	s1,8(sp)
    80002e3c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002e40:	00009497          	auipc	s1,0x9
    80002e44:	0784b483          	ld	s1,120(s1) # 8000beb8 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002e48:	0104a703          	lw	a4,16(s1)
    80002e4c:	00100793          	li	a5,1
    80002e50:	04e7f663          	bgeu	a5,a4,80002e9c <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002e54:	00002097          	auipc	ra,0x2
    80002e58:	b60080e7          	jalr	-1184(ra) # 800049b4 <_ZN9Scheduler3getEv>
    80002e5c:	00009797          	auipc	a5,0x9
    80002e60:	04a7be23          	sd	a0,92(a5) # 8000beb8 <_ZN3TCB7runningE>
    if(running) {
    80002e64:	02050263          	beqz	a0,80002e88 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002e68:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002e6c:	00001097          	auipc	ra,0x1
    80002e70:	d08080e7          	jalr	-760(ra) # 80003b74 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002e74:	00009597          	auipc	a1,0x9
    80002e78:	0445b583          	ld	a1,68(a1) # 8000beb8 <_ZN3TCB7runningE>
    80002e7c:	00048513          	mv	a0,s1
    80002e80:	ffffe097          	auipc	ra,0xffffe
    80002e84:	2c0080e7          	jalr	704(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002e88:	01813083          	ld	ra,24(sp)
    80002e8c:	01013403          	ld	s0,16(sp)
    80002e90:	00813483          	ld	s1,8(sp)
    80002e94:	02010113          	addi	sp,sp,32
    80002e98:	00008067          	ret
        Scheduler::put(old);
    80002e9c:	00048513          	mv	a0,s1
    80002ea0:	00002097          	auipc	ra,0x2
    80002ea4:	acc080e7          	jalr	-1332(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
    80002ea8:	fadff06f          	j	80002e54 <_ZN3TCB8dispatchEv+0x28>

0000000080002eac <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002eac:	ff010113          	addi	sp,sp,-16
    80002eb0:	00113423          	sd	ra,8(sp)
    80002eb4:	00813023          	sd	s0,0(sp)
    80002eb8:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002ebc:	00009517          	auipc	a0,0x9
    80002ec0:	00453503          	ld	a0,4(a0) # 8000bec0 <_ZN3TCB8tcbCacheE>
    80002ec4:	00002097          	auipc	ra,0x2
    80002ec8:	164080e7          	jalr	356(ra) # 80005028 <_Z16kmem_cache_allocP5Cache>
}
    80002ecc:	00813083          	ld	ra,8(sp)
    80002ed0:	00013403          	ld	s0,0(sp)
    80002ed4:	01010113          	addi	sp,sp,16
    80002ed8:	00008067          	ret

0000000080002edc <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002edc:	fd010113          	addi	sp,sp,-48
    80002ee0:	02113423          	sd	ra,40(sp)
    80002ee4:	02813023          	sd	s0,32(sp)
    80002ee8:	00913c23          	sd	s1,24(sp)
    80002eec:	01213823          	sd	s2,16(sp)
    80002ef0:	01313423          	sd	s3,8(sp)
    80002ef4:	01413023          	sd	s4,0(sp)
    80002ef8:	03010413          	addi	s0,sp,48
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), nullptr, nullptr);
    80002efc:	00000693          	li	a3,0
    80002f00:	00000613          	li	a2,0
    80002f04:	07000593          	li	a1,112
    80002f08:	00006517          	auipc	a0,0x6
    80002f0c:	3c850513          	addi	a0,a0,968 # 800092d0 <CONSOLE_STATUS+0x2c0>
    80002f10:	00002097          	auipc	ra,0x2
    80002f14:	0f0080e7          	jalr	240(ra) # 80005000 <_Z17kmem_cache_createPKcmPFvPvES3_>
    80002f18:	00009917          	auipc	s2,0x9
    80002f1c:	fa090913          	addi	s2,s2,-96 # 8000beb8 <_ZN3TCB7runningE>
    80002f20:	00a93423          	sd	a0,8(s2)
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002f24:	07000513          	li	a0,112
    80002f28:	00000097          	auipc	ra,0x0
    80002f2c:	f84080e7          	jalr	-124(ra) # 80002eac <_ZN3TCBnwEm>
    80002f30:	00050493          	mv	s1,a0
    80002f34:	00200713          	li	a4,2
    80002f38:	00000693          	li	a3,0
    80002f3c:	00000613          	li	a2,0
    80002f40:	00000593          	li	a1,0
    80002f44:	00000097          	auipc	ra,0x0
    80002f48:	e1c080e7          	jalr	-484(ra) # 80002d60 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002f4c:	00993023          	sd	s1,0(s2)
    TCB::running->mode = Mode::SUPERVISOR;
    80002f50:	00100a13          	li	s4,1
    80002f54:	0144aa23          	sw	s4,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80002f58:	00001537          	lui	a0,0x1
    80002f5c:	00002097          	auipc	ra,0x2
    80002f60:	19c080e7          	jalr	412(ra) # 800050f8 <_Z7kmallocm>
    80002f64:	00050993          	mv	s3,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002f68:	07000513          	li	a0,112
    80002f6c:	00000097          	auipc	ra,0x0
    80002f70:	f40080e7          	jalr	-192(ra) # 80002eac <_ZN3TCBnwEm>
    80002f74:	00050493          	mv	s1,a0
    80002f78:	00200713          	li	a4,2
    80002f7c:	00098693          	mv	a3,s3
    80002f80:	00000613          	li	a2,0
    80002f84:	00009597          	auipc	a1,0x9
    80002f88:	cf45b583          	ld	a1,-780(a1) # 8000bc78 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002f8c:	00000097          	auipc	ra,0x0
    80002f90:	dd4080e7          	jalr	-556(ra) # 80002d60 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002f94:	00993823          	sd	s1,16(s2)
    putcThread->mode = Mode::SUPERVISOR;
    80002f98:	0144aa23          	sw	s4,20(s1)
    Scheduler::put(putcThread);
    80002f9c:	00048513          	mv	a0,s1
    80002fa0:	00002097          	auipc	ra,0x2
    80002fa4:	9cc080e7          	jalr	-1588(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
}
    80002fa8:	02813083          	ld	ra,40(sp)
    80002fac:	02013403          	ld	s0,32(sp)
    80002fb0:	01813483          	ld	s1,24(sp)
    80002fb4:	01013903          	ld	s2,16(sp)
    80002fb8:	00813983          	ld	s3,8(sp)
    80002fbc:	00013a03          	ld	s4,0(sp)
    80002fc0:	03010113          	addi	sp,sp,48
    80002fc4:	00008067          	ret

0000000080002fc8 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    80002fc8:	ff010113          	addi	sp,sp,-16
    80002fcc:	00113423          	sd	ra,8(sp)
    80002fd0:	00813023          	sd	s0,0(sp)
    80002fd4:	01010413          	addi	s0,sp,16
    80002fd8:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80002fdc:	00009517          	auipc	a0,0x9
    80002fe0:	ee453503          	ld	a0,-284(a0) # 8000bec0 <_ZN3TCB8tcbCacheE>
    80002fe4:	00002097          	auipc	ra,0x2
    80002fe8:	06c080e7          	jalr	108(ra) # 80005050 <_Z15kmem_cache_freeP5CachePv>
}
    80002fec:	00813083          	ld	ra,8(sp)
    80002ff0:	00013403          	ld	s0,0(sp)
    80002ff4:	01010113          	addi	sp,sp,16
    80002ff8:	00008067          	ret

0000000080002ffc <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80002ffc:	ff010113          	addi	sp,sp,-16
    80003000:	00813423          	sd	s0,8(sp)
    80003004:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80003008:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    8000300c:	05100513          	li	a0,81
    asm("ecall");
    80003010:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80003014:	00050513          	mv	a0,a0
    return status;
}
    80003018:	0005051b          	sext.w	a0,a0
    8000301c:	00813403          	ld	s0,8(sp)
    80003020:	01010113          	addi	sp,sp,16
    80003024:	00008067          	ret

0000000080003028 <_ZN3TCB4ctorEPv>:

void* TCB::ctor(void* tcb){
    80003028:	ff010113          	addi	sp,sp,-16
    8000302c:	00813423          	sd	s0,8(sp)
    80003030:	01010413          	addi	s0,sp,16
    return nullptr;
    80003034:	00000513          	li	a0,0
    80003038:	00813403          	ld	s0,8(sp)
    8000303c:	01010113          	addi	sp,sp,16
    80003040:	00008067          	ret

0000000080003044 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80003044:	ff010113          	addi	sp,sp,-16
    80003048:	00813423          	sd	s0,8(sp)
    8000304c:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80003050:	00009797          	auipc	a5,0x9
    80003054:	c187b783          	ld	a5,-1000(a5) # 8000bc68 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003058:	0007b603          	ld	a2,0(a5)
    8000305c:	00c65793          	srli	a5,a2,0xc
    80003060:	00278793          	addi	a5,a5,2
    80003064:	00c79793          	slli	a5,a5,0xc
    80003068:	01000737          	lui	a4,0x1000
    8000306c:	00e787b3          	add	a5,a5,a4
    80003070:	00009717          	auipc	a4,0x9
    80003074:	e7870713          	addi	a4,a4,-392 # 8000bee8 <_ZN15MemoryAllocator11freeMemTailE>
    80003078:	00f73023          	sd	a5,0(a4)
    8000307c:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80003080:	0007b823          	sd	zero,16(a5)
    80003084:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80003088:	00073823          	sd	zero,16(a4)
    8000308c:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    80003090:	00009697          	auipc	a3,0x9
    80003094:	c586b683          	ld	a3,-936(a3) # 8000bce8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003098:	0006b683          	ld	a3,0(a3)
    8000309c:	40c686b3          	sub	a3,a3,a2
    800030a0:	fe868693          	addi	a3,a3,-24
    800030a4:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    800030a8:	00873783          	ld	a5,8(a4)
    800030ac:	0007b823          	sd	zero,16(a5)

    initialized = true;
    800030b0:	00100793          	li	a5,1
    800030b4:	02f70023          	sb	a5,32(a4)
}
    800030b8:	00813403          	ld	s0,8(sp)
    800030bc:	01010113          	addi	sp,sp,16
    800030c0:	00008067          	ret

00000000800030c4 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    800030c4:	ff010113          	addi	sp,sp,-16
    800030c8:	00813423          	sd	s0,8(sp)
    800030cc:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    800030d0:	14050263          	beqz	a0,80003214 <_ZN15MemoryAllocator7kmallocEm+0x150>
    800030d4:	00050793          	mv	a5,a0
    800030d8:	00009517          	auipc	a0,0x9
    800030dc:	e1853503          	ld	a0,-488(a0) # 8000bef0 <_ZN15MemoryAllocator11freeMemHeadE>
    800030e0:	0a050a63          	beqz	a0,80003194 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    800030e4:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    800030e8:	00000613          	li	a2,0
    800030ec:	00c0006f          	j	800030f8 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    800030f0:	00050613          	mv	a2,a0
    800030f4:	01053503          	ld	a0,16(a0)
    800030f8:	00050863          	beqz	a0,80003108 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    800030fc:	00053683          	ld	a3,0(a0)
    80003100:	01878713          	addi	a4,a5,24
    80003104:	fee6e6e3          	bltu	a3,a4,800030f0 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80003108:	08050663          	beqz	a0,80003194 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    8000310c:	00053683          	ld	a3,0(a0)
    80003110:	01868713          	addi	a4,a3,24
    80003114:	00e50733          	add	a4,a0,a4
    80003118:	00009597          	auipc	a1,0x9
    8000311c:	bd05b583          	ld	a1,-1072(a1) # 8000bce8 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003120:	0005b583          	ld	a1,0(a1)
    80003124:	00b76463          	bltu	a4,a1,8000312c <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80003128:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    8000312c:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80003130:	05700593          	li	a1,87
    80003134:	08d5f063          	bgeu	a1,a3,800031b4 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80003138:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    8000313c:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80003140:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80003144:	01053583          	ld	a1,16(a0)
    80003148:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    8000314c:	00853583          	ld	a1,8(a0)
    80003150:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80003154:	fe868693          	addi	a3,a3,-24
    80003158:	00d7b023          	sd	a3,0(a5)

            if(prev)
    8000315c:	04060263          	beqz	a2,800031a0 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    80003160:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80003164:	00009797          	auipc	a5,0x9
    80003168:	d9c7b783          	ld	a5,-612(a5) # 8000bf00 <_ZN15MemoryAllocator12allocMemHeadE>
    8000316c:	06078463          	beqz	a5,800031d4 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80003170:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80003174:	08070063          	beqz	a4,800031f4 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80003178:	00873783          	ld	a5,8(a4)
    8000317c:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80003180:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80003184:	00873783          	ld	a5,8(a4)
    80003188:	06078063          	beqz	a5,800031e8 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    8000318c:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003190:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003194:	00813403          	ld	s0,8(sp)
    80003198:	01010113          	addi	sp,sp,16
    8000319c:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    800031a0:	00009697          	auipc	a3,0x9
    800031a4:	d4868693          	addi	a3,a3,-696 # 8000bee8 <_ZN15MemoryAllocator11freeMemTailE>
    800031a8:	00f6b023          	sd	a5,0(a3)
    800031ac:	00f6b423          	sd	a5,8(a3)
    800031b0:	fb5ff06f          	j	80003164 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    800031b4:	00060863          	beqz	a2,800031c4 <_ZN15MemoryAllocator7kmallocEm+0x100>
    800031b8:	01053783          	ld	a5,16(a0)
    800031bc:	00f63823          	sd	a5,16(a2)
    800031c0:	fa5ff06f          	j	80003164 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    800031c4:	01053783          	ld	a5,16(a0)
    800031c8:	00009697          	auipc	a3,0x9
    800031cc:	d2f6b423          	sd	a5,-728(a3) # 8000bef0 <_ZN15MemoryAllocator11freeMemHeadE>
    800031d0:	f95ff06f          	j	80003164 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    800031d4:	00009797          	auipc	a5,0x9
    800031d8:	d1478793          	addi	a5,a5,-748 # 8000bee8 <_ZN15MemoryAllocator11freeMemTailE>
    800031dc:	00a7b823          	sd	a0,16(a5)
    800031e0:	00a7bc23          	sd	a0,24(a5)
    800031e4:	fadff06f          	j	80003190 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    800031e8:	00009797          	auipc	a5,0x9
    800031ec:	d0a7bc23          	sd	a0,-744(a5) # 8000bf00 <_ZN15MemoryAllocator12allocMemHeadE>
    800031f0:	fa1ff06f          	j	80003190 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    800031f4:	00009797          	auipc	a5,0x9
    800031f8:	cf478793          	addi	a5,a5,-780 # 8000bee8 <_ZN15MemoryAllocator11freeMemTailE>
    800031fc:	0107b703          	ld	a4,16(a5)
    80003200:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80003204:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80003208:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    8000320c:	00a7b823          	sd	a0,16(a5)
    80003210:	f81ff06f          	j	80003190 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80003214:	00000513          	li	a0,0
    80003218:	f7dff06f          	j	80003194 <_ZN15MemoryAllocator7kmallocEm+0xd0>

000000008000321c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    8000321c:	ff010113          	addi	sp,sp,-16
    80003220:	00813423          	sd	s0,8(sp)
    80003224:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80003228:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    8000322c:	00000713          	li	a4,0
    80003230:	00078a63          	beqz	a5,80003244 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80003234:	00a7f863          	bgeu	a5,a0,80003244 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80003238:	00078713          	mv	a4,a5
    8000323c:	0107b783          	ld	a5,16(a5)
    80003240:	ff1ff06f          	j	80003230 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80003244:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80003248:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    8000324c:	00078463          	beqz	a5,80003254 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80003250:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80003254:	02070263          	beqz	a4,80003278 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80003258:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    8000325c:	0005b703          	ld	a4,0(a1)
    80003260:	00009797          	auipc	a5,0x9
    80003264:	c907b783          	ld	a5,-880(a5) # 8000bef0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003268:	00f70c63          	beq	a4,a5,80003280 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    8000326c:	00813403          	ld	s0,8(sp)
    80003270:	01010113          	addi	sp,sp,16
    80003274:	00008067          	ret
        *head = blk;
    80003278:	00a5b023          	sd	a0,0(a1)
    8000327c:	fe1ff06f          	j	8000325c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80003280:	01053783          	ld	a5,16(a0)
    80003284:	00078a63          	beqz	a5,80003298 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80003288:	00053683          	ld	a3,0(a0)
    8000328c:	00d50733          	add	a4,a0,a3
    80003290:	01870713          	addi	a4,a4,24
    80003294:	02f70e63          	beq	a4,a5,800032d0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80003298:	00853783          	ld	a5,8(a0)
    8000329c:	fc0788e3          	beqz	a5,8000326c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    800032a0:	0007b683          	ld	a3,0(a5)
    800032a4:	00d78733          	add	a4,a5,a3
    800032a8:	01870713          	addi	a4,a4,24
    800032ac:	fca710e3          	bne	a4,a0,8000326c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    800032b0:	00053703          	ld	a4,0(a0)
    800032b4:	00e68733          	add	a4,a3,a4
    800032b8:	01870713          	addi	a4,a4,24
    800032bc:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    800032c0:	00853783          	ld	a5,8(a0)
    800032c4:	01053703          	ld	a4,16(a0)
    800032c8:	00e7b823          	sd	a4,16(a5)
}
    800032cc:	fa1ff06f          	j	8000326c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    800032d0:	0007b703          	ld	a4,0(a5)
    800032d4:	00e68733          	add	a4,a3,a4
    800032d8:	01870713          	addi	a4,a4,24
    800032dc:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    800032e0:	0107b783          	ld	a5,16(a5)
    800032e4:	00f53823          	sd	a5,16(a0)
    800032e8:	fb1ff06f          	j	80003298 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

00000000800032ec <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    800032ec:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    800032f0:	00009697          	auipc	a3,0x9
    800032f4:	c106b683          	ld	a3,-1008(a3) # 8000bf00 <_ZN15MemoryAllocator12allocMemHeadE>
    800032f8:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    800032fc:	00050a63          	beqz	a0,80003310 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80003300:	fe870793          	addi	a5,a4,-24
    80003304:	00a78663          	beq	a5,a0,80003310 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80003308:	01053503          	ld	a0,16(a0)
    8000330c:	ff1ff06f          	j	800032fc <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80003310:	08050463          	beqz	a0,80003398 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003314:	ff010113          	addi	sp,sp,-16
    80003318:	00113423          	sd	ra,8(sp)
    8000331c:	00813023          	sd	s0,0(sp)
    80003320:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003324:	00009797          	auipc	a5,0x9
    80003328:	bd47b783          	ld	a5,-1068(a5) # 8000bef8 <_ZN15MemoryAllocator12allocMemTailE>
    8000332c:	04a78663          	beq	a5,a0,80003378 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80003330:	04d50c63          	beq	a0,a3,80003388 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80003334:	01053783          	ld	a5,16(a0)
    80003338:	00078663          	beqz	a5,80003344 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    8000333c:	00853703          	ld	a4,8(a0)
    80003340:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80003344:	00853783          	ld	a5,8(a0)
    80003348:	00078663          	beqz	a5,80003354 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    8000334c:	01053703          	ld	a4,16(a0)
    80003350:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80003354:	00009597          	auipc	a1,0x9
    80003358:	b9c58593          	addi	a1,a1,-1124 # 8000bef0 <_ZN15MemoryAllocator11freeMemHeadE>
    8000335c:	00000097          	auipc	ra,0x0
    80003360:	ec0080e7          	jalr	-320(ra) # 8000321c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80003364:	00000513          	li	a0,0
}
    80003368:	00813083          	ld	ra,8(sp)
    8000336c:	00013403          	ld	s0,0(sp)
    80003370:	01010113          	addi	sp,sp,16
    80003374:	00008067          	ret
            allocMemTail = blk->prev;
    80003378:	00853783          	ld	a5,8(a0)
    8000337c:	00009717          	auipc	a4,0x9
    80003380:	b6f73e23          	sd	a5,-1156(a4) # 8000bef8 <_ZN15MemoryAllocator12allocMemTailE>
    80003384:	fadff06f          	j	80003330 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80003388:	01053783          	ld	a5,16(a0)
    8000338c:	00009717          	auipc	a4,0x9
    80003390:	b6f73a23          	sd	a5,-1164(a4) # 8000bf00 <_ZN15MemoryAllocator12allocMemHeadE>
    80003394:	fa1ff06f          	j	80003334 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80003398:	fff00513          	li	a0,-1
}
    8000339c:	00008067          	ret

00000000800033a0 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    800033a0:	fe010113          	addi	sp,sp,-32
    800033a4:	00113c23          	sd	ra,24(sp)
    800033a8:	00813823          	sd	s0,16(sp)
    800033ac:	00913423          	sd	s1,8(sp)
    800033b0:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    800033b4:	00009497          	auipc	s1,0x9
    800033b8:	b4c4b483          	ld	s1,-1204(s1) # 8000bf00 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    800033bc:	00006517          	auipc	a0,0x6
    800033c0:	f2450513          	addi	a0,a0,-220 # 800092e0 <CONSOLE_STATUS+0x2d0>
    800033c4:	fffff097          	auipc	ra,0xfffff
    800033c8:	3ec080e7          	jalr	1004(ra) # 800027b0 <_Z11printStringPKc>
    while(iter!=nullptr){
    800033cc:	04048663          	beqz	s1,80003418 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    800033d0:	00000613          	li	a2,0
    800033d4:	00a00593          	li	a1,10
    800033d8:	0004851b          	sext.w	a0,s1
    800033dc:	fffff097          	auipc	ra,0xfffff
    800033e0:	56c080e7          	jalr	1388(ra) # 80002948 <_Z8printIntiii>
        putc(' ');
    800033e4:	02000513          	li	a0,32
    800033e8:	fffff097          	auipc	ra,0xfffff
    800033ec:	cb0080e7          	jalr	-848(ra) # 80002098 <_Z4putcc>
        printInt(iter->size);
    800033f0:	00000613          	li	a2,0
    800033f4:	00a00593          	li	a1,10
    800033f8:	0004a503          	lw	a0,0(s1)
    800033fc:	fffff097          	auipc	ra,0xfffff
    80003400:	54c080e7          	jalr	1356(ra) # 80002948 <_Z8printIntiii>
        putc('\n');
    80003404:	00a00513          	li	a0,10
    80003408:	fffff097          	auipc	ra,0xfffff
    8000340c:	c90080e7          	jalr	-880(ra) # 80002098 <_Z4putcc>
        iter=iter->next;
    80003410:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003414:	fb9ff06f          	j	800033cc <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80003418:	00006517          	auipc	a0,0x6
    8000341c:	ee850513          	addi	a0,a0,-280 # 80009300 <CONSOLE_STATUS+0x2f0>
    80003420:	fffff097          	auipc	ra,0xfffff
    80003424:	390080e7          	jalr	912(ra) # 800027b0 <_Z11printStringPKc>
    iter = freeMemHead;
    80003428:	00009497          	auipc	s1,0x9
    8000342c:	ac84b483          	ld	s1,-1336(s1) # 8000bef0 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80003430:	04048663          	beqz	s1,8000347c <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003434:	00000613          	li	a2,0
    80003438:	00a00593          	li	a1,10
    8000343c:	0004851b          	sext.w	a0,s1
    80003440:	fffff097          	auipc	ra,0xfffff
    80003444:	508080e7          	jalr	1288(ra) # 80002948 <_Z8printIntiii>
        putc(' ');
    80003448:	02000513          	li	a0,32
    8000344c:	fffff097          	auipc	ra,0xfffff
    80003450:	c4c080e7          	jalr	-948(ra) # 80002098 <_Z4putcc>
        printInt(iter->size);
    80003454:	00000613          	li	a2,0
    80003458:	00a00593          	li	a1,10
    8000345c:	0004a503          	lw	a0,0(s1)
    80003460:	fffff097          	auipc	ra,0xfffff
    80003464:	4e8080e7          	jalr	1256(ra) # 80002948 <_Z8printIntiii>
        putc('\n');
    80003468:	00a00513          	li	a0,10
    8000346c:	fffff097          	auipc	ra,0xfffff
    80003470:	c2c080e7          	jalr	-980(ra) # 80002098 <_Z4putcc>
        iter=iter->next;
    80003474:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003478:	fb9ff06f          	j	80003430 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    8000347c:	00006517          	auipc	a0,0x6
    80003480:	ea450513          	addi	a0,a0,-348 # 80009320 <CONSOLE_STATUS+0x310>
    80003484:	fffff097          	auipc	ra,0xfffff
    80003488:	32c080e7          	jalr	812(ra) # 800027b0 <_Z11printStringPKc>
}
    8000348c:	01813083          	ld	ra,24(sp)
    80003490:	01013403          	ld	s0,16(sp)
    80003494:	00813483          	ld	s1,8(sp)
    80003498:	02010113          	addi	sp,sp,32
    8000349c:	00008067          	ret

00000000800034a0 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    800034a0:	ff010113          	addi	sp,sp,-16
    800034a4:	00813423          	sd	s0,8(sp)
    800034a8:	01010413          	addi	s0,sp,16
    800034ac:	00050813          	mv	a6,a0
    800034b0:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    800034b4:	00000793          	li	a5,0
    800034b8:	00c7fe63          	bgeu	a5,a2,800034d4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    800034bc:	00f50733          	add	a4,a0,a5
    800034c0:	00f806b3          	add	a3,a6,a5
    800034c4:	0006c683          	lbu	a3,0(a3)
    800034c8:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    800034cc:	00178793          	addi	a5,a5,1
    800034d0:	fe9ff06f          	j	800034b8 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800034d4:	00813403          	ld	s0,8(sp)
    800034d8:	01010113          	addi	sp,sp,16
    800034dc:	00008067          	ret

00000000800034e0 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    800034e0:	ff010113          	addi	sp,sp,-16
    800034e4:	00113423          	sd	ra,8(sp)
    800034e8:	00813023          	sd	s0,0(sp)
    800034ec:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800034f0:	00053783          	ld	a5,0(a0)
    800034f4:	0107b783          	ld	a5,16(a5)
    800034f8:	000780e7          	jalr	a5
}
    800034fc:	00813083          	ld	ra,8(sp)
    80003500:	00013403          	ld	s0,0(sp)
    80003504:	01010113          	addi	sp,sp,16
    80003508:	00008067          	ret

000000008000350c <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    8000350c:	ff010113          	addi	sp,sp,-16
    80003510:	00113423          	sd	ra,8(sp)
    80003514:	00813023          	sd	s0,0(sp)
    80003518:	01010413          	addi	s0,sp,16
    8000351c:	00008797          	auipc	a5,0x8
    80003520:	68478793          	addi	a5,a5,1668 # 8000bba0 <_ZTV9Semaphore+0x10>
    80003524:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80003528:	00853503          	ld	a0,8(a0)
    8000352c:	fffff097          	auipc	ra,0xfffff
    80003530:	a94080e7          	jalr	-1388(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
};
    80003534:	00813083          	ld	ra,8(sp)
    80003538:	00013403          	ld	s0,0(sp)
    8000353c:	01010113          	addi	sp,sp,16
    80003540:	00008067          	ret

0000000080003544 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80003544:	00008797          	auipc	a5,0x8
    80003548:	67c78793          	addi	a5,a5,1660 # 8000bbc0 <_ZTV6Thread+0x10>
    8000354c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80003550:	00853503          	ld	a0,8(a0)
    80003554:	02050663          	beqz	a0,80003580 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003558:	ff010113          	addi	sp,sp,-16
    8000355c:	00113423          	sd	ra,8(sp)
    80003560:	00813023          	sd	s0,0(sp)
    80003564:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003568:	fffff097          	auipc	ra,0xfffff
    8000356c:	ba4080e7          	jalr	-1116(ra) # 8000210c <_ZN7_threaddlEPv>
}
    80003570:	00813083          	ld	ra,8(sp)
    80003574:	00013403          	ld	s0,0(sp)
    80003578:	01010113          	addi	sp,sp,16
    8000357c:	00008067          	ret
    80003580:	00008067          	ret

0000000080003584 <_Znwm>:
void* operator new(size_t sz){
    80003584:	ff010113          	addi	sp,sp,-16
    80003588:	00113423          	sd	ra,8(sp)
    8000358c:	00813023          	sd	s0,0(sp)
    80003590:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003594:	fffff097          	auipc	ra,0xfffff
    80003598:	82c080e7          	jalr	-2004(ra) # 80001dc0 <_Z9mem_allocm>
}
    8000359c:	00813083          	ld	ra,8(sp)
    800035a0:	00013403          	ld	s0,0(sp)
    800035a4:	01010113          	addi	sp,sp,16
    800035a8:	00008067          	ret

00000000800035ac <_Znam>:
void* operator new[](size_t sz){
    800035ac:	ff010113          	addi	sp,sp,-16
    800035b0:	00113423          	sd	ra,8(sp)
    800035b4:	00813023          	sd	s0,0(sp)
    800035b8:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    800035bc:	fffff097          	auipc	ra,0xfffff
    800035c0:	804080e7          	jalr	-2044(ra) # 80001dc0 <_Z9mem_allocm>
}
    800035c4:	00813083          	ld	ra,8(sp)
    800035c8:	00013403          	ld	s0,0(sp)
    800035cc:	01010113          	addi	sp,sp,16
    800035d0:	00008067          	ret

00000000800035d4 <_ZdlPv>:
void operator delete(void *ptr){
    800035d4:	ff010113          	addi	sp,sp,-16
    800035d8:	00113423          	sd	ra,8(sp)
    800035dc:	00813023          	sd	s0,0(sp)
    800035e0:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800035e4:	fffff097          	auipc	ra,0xfffff
    800035e8:	80c080e7          	jalr	-2036(ra) # 80001df0 <_Z8mem_freePv>
}
    800035ec:	00813083          	ld	ra,8(sp)
    800035f0:	00013403          	ld	s0,0(sp)
    800035f4:	01010113          	addi	sp,sp,16
    800035f8:	00008067          	ret

00000000800035fc <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    800035fc:	fe010113          	addi	sp,sp,-32
    80003600:	00113c23          	sd	ra,24(sp)
    80003604:	00813823          	sd	s0,16(sp)
    80003608:	00913423          	sd	s1,8(sp)
    8000360c:	02010413          	addi	s0,sp,32
    80003610:	00050493          	mv	s1,a0
};
    80003614:	00000097          	auipc	ra,0x0
    80003618:	ef8080e7          	jalr	-264(ra) # 8000350c <_ZN9SemaphoreD1Ev>
    8000361c:	00048513          	mv	a0,s1
    80003620:	00000097          	auipc	ra,0x0
    80003624:	fb4080e7          	jalr	-76(ra) # 800035d4 <_ZdlPv>
    80003628:	01813083          	ld	ra,24(sp)
    8000362c:	01013403          	ld	s0,16(sp)
    80003630:	00813483          	ld	s1,8(sp)
    80003634:	02010113          	addi	sp,sp,32
    80003638:	00008067          	ret

000000008000363c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000363c:	fe010113          	addi	sp,sp,-32
    80003640:	00113c23          	sd	ra,24(sp)
    80003644:	00813823          	sd	s0,16(sp)
    80003648:	00913423          	sd	s1,8(sp)
    8000364c:	02010413          	addi	s0,sp,32
    80003650:	00050493          	mv	s1,a0
}
    80003654:	00000097          	auipc	ra,0x0
    80003658:	ef0080e7          	jalr	-272(ra) # 80003544 <_ZN6ThreadD1Ev>
    8000365c:	00048513          	mv	a0,s1
    80003660:	00000097          	auipc	ra,0x0
    80003664:	f74080e7          	jalr	-140(ra) # 800035d4 <_ZdlPv>
    80003668:	01813083          	ld	ra,24(sp)
    8000366c:	01013403          	ld	s0,16(sp)
    80003670:	00813483          	ld	s1,8(sp)
    80003674:	02010113          	addi	sp,sp,32
    80003678:	00008067          	ret

000000008000367c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000367c:	ff010113          	addi	sp,sp,-16
    80003680:	00113423          	sd	ra,8(sp)
    80003684:	00813023          	sd	s0,0(sp)
    80003688:	01010413          	addi	s0,sp,16
    8000368c:	00008797          	auipc	a5,0x8
    80003690:	51478793          	addi	a5,a5,1300 # 8000bba0 <_ZTV9Semaphore+0x10>
    80003694:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003698:	00850513          	addi	a0,a0,8
    8000369c:	fffff097          	auipc	ra,0xfffff
    800036a0:	8ec080e7          	jalr	-1812(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
}
    800036a4:	00813083          	ld	ra,8(sp)
    800036a8:	00013403          	ld	s0,0(sp)
    800036ac:	01010113          	addi	sp,sp,16
    800036b0:	00008067          	ret

00000000800036b4 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    800036b4:	ff010113          	addi	sp,sp,-16
    800036b8:	00113423          	sd	ra,8(sp)
    800036bc:	00813023          	sd	s0,0(sp)
    800036c0:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800036c4:	00853503          	ld	a0,8(a0)
    800036c8:	fffff097          	auipc	ra,0xfffff
    800036cc:	924080e7          	jalr	-1756(ra) # 80001fec <_Z8sem_waitP10_semaphore>
}
    800036d0:	00813083          	ld	ra,8(sp)
    800036d4:	00013403          	ld	s0,0(sp)
    800036d8:	01010113          	addi	sp,sp,16
    800036dc:	00008067          	ret

00000000800036e0 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800036e0:	ff010113          	addi	sp,sp,-16
    800036e4:	00113423          	sd	ra,8(sp)
    800036e8:	00813023          	sd	s0,0(sp)
    800036ec:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800036f0:	00853503          	ld	a0,8(a0)
    800036f4:	fffff097          	auipc	ra,0xfffff
    800036f8:	924080e7          	jalr	-1756(ra) # 80002018 <_Z10sem_signalP10_semaphore>
}
    800036fc:	00813083          	ld	ra,8(sp)
    80003700:	00013403          	ld	s0,0(sp)
    80003704:	01010113          	addi	sp,sp,16
    80003708:	00008067          	ret

000000008000370c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    8000370c:	ff010113          	addi	sp,sp,-16
    80003710:	00113423          	sd	ra,8(sp)
    80003714:	00813023          	sd	s0,0(sp)
    80003718:	01010413          	addi	s0,sp,16
    8000371c:	00008797          	auipc	a5,0x8
    80003720:	4a478793          	addi	a5,a5,1188 # 8000bbc0 <_ZTV6Thread+0x10>
    80003724:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    80003728:	00850513          	addi	a0,a0,8
    8000372c:	ffffe097          	auipc	ra,0xffffe
    80003730:	7b4080e7          	jalr	1972(ra) # 80001ee0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003734:	00813083          	ld	ra,8(sp)
    80003738:	00013403          	ld	s0,0(sp)
    8000373c:	01010113          	addi	sp,sp,16
    80003740:	00008067          	ret

0000000080003744 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003744:	ff010113          	addi	sp,sp,-16
    80003748:	00113423          	sd	ra,8(sp)
    8000374c:	00813023          	sd	s0,0(sp)
    80003750:	01010413          	addi	s0,sp,16
    80003754:	00008797          	auipc	a5,0x8
    80003758:	46c78793          	addi	a5,a5,1132 # 8000bbc0 <_ZTV6Thread+0x10>
    8000375c:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    80003760:	00050613          	mv	a2,a0
    80003764:	00000597          	auipc	a1,0x0
    80003768:	d7c58593          	addi	a1,a1,-644 # 800034e0 <_ZN6Thread7wrapperEPv>
    8000376c:	00850513          	addi	a0,a0,8
    80003770:	ffffe097          	auipc	ra,0xffffe
    80003774:	770080e7          	jalr	1904(ra) # 80001ee0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003778:	00813083          	ld	ra,8(sp)
    8000377c:	00013403          	ld	s0,0(sp)
    80003780:	01010113          	addi	sp,sp,16
    80003784:	00008067          	ret

0000000080003788 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003788:	ff010113          	addi	sp,sp,-16
    8000378c:	00113423          	sd	ra,8(sp)
    80003790:	00813023          	sd	s0,0(sp)
    80003794:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003798:	fffff097          	auipc	ra,0xfffff
    8000379c:	8ac080e7          	jalr	-1876(ra) # 80002044 <_Z10time_sleepm>
}
    800037a0:	00813083          	ld	ra,8(sp)
    800037a4:	00013403          	ld	s0,0(sp)
    800037a8:	01010113          	addi	sp,sp,16
    800037ac:	00008067          	ret

00000000800037b0 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    800037b0:	fe010113          	addi	sp,sp,-32
    800037b4:	00113c23          	sd	ra,24(sp)
    800037b8:	00813823          	sd	s0,16(sp)
    800037bc:	00913423          	sd	s1,8(sp)
    800037c0:	01213023          	sd	s2,0(sp)
    800037c4:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    800037c8:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    800037cc:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    800037d0:	0004b783          	ld	a5,0(s1)
    800037d4:	0187b783          	ld	a5,24(a5)
    800037d8:	00048513          	mv	a0,s1
    800037dc:	000780e7          	jalr	a5
        pt->sleep(time);
    800037e0:	00090513          	mv	a0,s2
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	fa4080e7          	jalr	-92(ra) # 80003788 <_ZN6Thread5sleepEm>
    while(true){
    800037ec:	fe5ff06f          	j	800037d0 <_ZN14PeriodicThread7wrapperEPv+0x20>

00000000800037f0 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800037f0:	ff010113          	addi	sp,sp,-16
    800037f4:	00113423          	sd	ra,8(sp)
    800037f8:	00813023          	sd	s0,0(sp)
    800037fc:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003800:	ffffe097          	auipc	ra,0xffffe
    80003804:	6c0080e7          	jalr	1728(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    80003808:	00813083          	ld	ra,8(sp)
    8000380c:	00013403          	ld	s0,0(sp)
    80003810:	01010113          	addi	sp,sp,16
    80003814:	00008067          	ret

0000000080003818 <_ZN6Thread5startEv>:
int Thread::start() {
    80003818:	ff010113          	addi	sp,sp,-16
    8000381c:	00113423          	sd	ra,8(sp)
    80003820:	00813023          	sd	s0,0(sp)
    80003824:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80003828:	00853503          	ld	a0,8(a0)
    8000382c:	ffffe097          	auipc	ra,0xffffe
    80003830:	730080e7          	jalr	1840(ra) # 80001f5c <_Z12thread_startP7_thread>
}
    80003834:	00813083          	ld	ra,8(sp)
    80003838:	00013403          	ld	s0,0(sp)
    8000383c:	01010113          	addi	sp,sp,16
    80003840:	00008067          	ret

0000000080003844 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003844:	fe010113          	addi	sp,sp,-32
    80003848:	00113c23          	sd	ra,24(sp)
    8000384c:	00813823          	sd	s0,16(sp)
    80003850:	00913423          	sd	s1,8(sp)
    80003854:	01213023          	sd	s2,0(sp)
    80003858:	02010413          	addi	s0,sp,32
    8000385c:	00050493          	mv	s1,a0
    80003860:	00058913          	mv	s2,a1
    80003864:	01000513          	li	a0,16
    80003868:	00000097          	auipc	ra,0x0
    8000386c:	d1c080e7          	jalr	-740(ra) # 80003584 <_Znwm>
    80003870:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003874:	00953023          	sd	s1,0(a0)
    80003878:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000387c:	00000597          	auipc	a1,0x0
    80003880:	f3458593          	addi	a1,a1,-204 # 800037b0 <_ZN14PeriodicThread7wrapperEPv>
    80003884:	00048513          	mv	a0,s1
    80003888:	00000097          	auipc	ra,0x0
    8000388c:	e84080e7          	jalr	-380(ra) # 8000370c <_ZN6ThreadC1EPFvPvES0_>
    80003890:	00008797          	auipc	a5,0x8
    80003894:	2e078793          	addi	a5,a5,736 # 8000bb70 <_ZTV14PeriodicThread+0x10>
    80003898:	00f4b023          	sd	a5,0(s1)
    8000389c:	01813083          	ld	ra,24(sp)
    800038a0:	01013403          	ld	s0,16(sp)
    800038a4:	00813483          	ld	s1,8(sp)
    800038a8:	00013903          	ld	s2,0(sp)
    800038ac:	02010113          	addi	sp,sp,32
    800038b0:	00008067          	ret

00000000800038b4 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    800038b4:	ff010113          	addi	sp,sp,-16
    800038b8:	00113423          	sd	ra,8(sp)
    800038bc:	00813023          	sd	s0,0(sp)
    800038c0:	01010413          	addi	s0,sp,16
    return ::getc();
    800038c4:	ffffe097          	auipc	ra,0xffffe
    800038c8:	7ac080e7          	jalr	1964(ra) # 80002070 <_Z4getcv>
}
    800038cc:	00813083          	ld	ra,8(sp)
    800038d0:	00013403          	ld	s0,0(sp)
    800038d4:	01010113          	addi	sp,sp,16
    800038d8:	00008067          	ret

00000000800038dc <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800038dc:	ff010113          	addi	sp,sp,-16
    800038e0:	00113423          	sd	ra,8(sp)
    800038e4:	00813023          	sd	s0,0(sp)
    800038e8:	01010413          	addi	s0,sp,16
    ::putc(c);
    800038ec:	ffffe097          	auipc	ra,0xffffe
    800038f0:	7ac080e7          	jalr	1964(ra) # 80002098 <_Z4putcc>
}
    800038f4:	00813083          	ld	ra,8(sp)
    800038f8:	00013403          	ld	s0,0(sp)
    800038fc:	01010113          	addi	sp,sp,16
    80003900:	00008067          	ret

0000000080003904 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003904:	ff010113          	addi	sp,sp,-16
    80003908:	00813423          	sd	s0,8(sp)
    8000390c:	01010413          	addi	s0,sp,16
    80003910:	00813403          	ld	s0,8(sp)
    80003914:	01010113          	addi	sp,sp,16
    80003918:	00008067          	ret

000000008000391c <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    8000391c:	ff010113          	addi	sp,sp,-16
    80003920:	00813423          	sd	s0,8(sp)
    80003924:	01010413          	addi	s0,sp,16
    80003928:	00813403          	ld	s0,8(sp)
    8000392c:	01010113          	addi	sp,sp,16
    80003930:	00008067          	ret

0000000080003934 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003934:	ff010113          	addi	sp,sp,-16
    80003938:	00113423          	sd	ra,8(sp)
    8000393c:	00813023          	sd	s0,0(sp)
    80003940:	01010413          	addi	s0,sp,16
    80003944:	00008797          	auipc	a5,0x8
    80003948:	22c78793          	addi	a5,a5,556 # 8000bb70 <_ZTV14PeriodicThread+0x10>
    8000394c:	00f53023          	sd	a5,0(a0)
    80003950:	00000097          	auipc	ra,0x0
    80003954:	bf4080e7          	jalr	-1036(ra) # 80003544 <_ZN6ThreadD1Ev>
    80003958:	00813083          	ld	ra,8(sp)
    8000395c:	00013403          	ld	s0,0(sp)
    80003960:	01010113          	addi	sp,sp,16
    80003964:	00008067          	ret

0000000080003968 <_ZN14PeriodicThreadD0Ev>:
    80003968:	fe010113          	addi	sp,sp,-32
    8000396c:	00113c23          	sd	ra,24(sp)
    80003970:	00813823          	sd	s0,16(sp)
    80003974:	00913423          	sd	s1,8(sp)
    80003978:	02010413          	addi	s0,sp,32
    8000397c:	00050493          	mv	s1,a0
    80003980:	00008797          	auipc	a5,0x8
    80003984:	1f078793          	addi	a5,a5,496 # 8000bb70 <_ZTV14PeriodicThread+0x10>
    80003988:	00f53023          	sd	a5,0(a0)
    8000398c:	00000097          	auipc	ra,0x0
    80003990:	bb8080e7          	jalr	-1096(ra) # 80003544 <_ZN6ThreadD1Ev>
    80003994:	00048513          	mv	a0,s1
    80003998:	00000097          	auipc	ra,0x0
    8000399c:	c3c080e7          	jalr	-964(ra) # 800035d4 <_ZdlPv>
    800039a0:	01813083          	ld	ra,24(sp)
    800039a4:	01013403          	ld	s0,16(sp)
    800039a8:	00813483          	ld	s1,8(sp)
    800039ac:	02010113          	addi	sp,sp,32
    800039b0:	00008067          	ret

00000000800039b4 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    800039b4:	ff010113          	addi	sp,sp,-16
    800039b8:	00113423          	sd	ra,8(sp)
    800039bc:	00813023          	sd	s0,0(sp)
    800039c0:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    800039c4:	00008797          	auipc	a5,0x8
    800039c8:	2f47b783          	ld	a5,756(a5) # 8000bcb8 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    800039cc:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    800039d0:	00008797          	auipc	a5,0x8
    800039d4:	2987b783          	ld	a5,664(a5) # 8000bc68 <_GLOBAL_OFFSET_TABLE_+0x18>
    800039d8:	0007b503          	ld	a0,0(a5)
    800039dc:	00c55513          	srli	a0,a0,0xc
    800039e0:	00250513          	addi	a0,a0,2
    800039e4:	000015b7          	lui	a1,0x1
    800039e8:	00c51513          	slli	a0,a0,0xc
    800039ec:	00001097          	auipc	ra,0x1
    800039f0:	5ec080e7          	jalr	1516(ra) # 80004fd8 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    800039f4:	fffff097          	auipc	ra,0xfffff
    800039f8:	650080e7          	jalr	1616(ra) # 80003044 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    800039fc:	00001097          	auipc	ra,0x1
    80003a00:	f58080e7          	jalr	-168(ra) # 80004954 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003a04:	fffff097          	auipc	ra,0xfffff
    80003a08:	4d8080e7          	jalr	1240(ra) # 80002edc <_ZN3TCB10initializeEv>
    SCB::initialize();
    80003a0c:	fffff097          	auipc	ra,0xfffff
    80003a10:	050080e7          	jalr	80(ra) # 80002a5c <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    80003a14:	00001097          	auipc	ra,0x1
    80003a18:	154080e7          	jalr	340(ra) # 80004b68 <_ZN11ConsoleUtil10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003a1c:	00200793          	li	a5,2
    80003a20:	1047a073          	csrs	sie,a5
    80003a24:	20000713          	li	a4,512
    80003a28:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003a2c:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003a30:	00813083          	ld	ra,8(sp)
    80003a34:	00013403          	ld	s0,0(sp)
    80003a38:	01010113          	addi	sp,sp,16
    80003a3c:	00008067          	ret

0000000080003a40 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003a40:	ff010113          	addi	sp,sp,-16
    80003a44:	00813423          	sd	s0,8(sp)
    80003a48:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003a4c:	14109073          	csrw	sepc,ra
    asm("sret");
    80003a50:	10200073          	sret
}
    80003a54:	00813403          	ld	s0,8(sp)
    80003a58:	01010113          	addi	sp,sp,16
    80003a5c:	00008067          	ret

0000000080003a60 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003a60:	ff010113          	addi	sp,sp,-16
    80003a64:	00113423          	sd	ra,8(sp)
    80003a68:	00813023          	sd	s0,0(sp)
    80003a6c:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003a70:	00008797          	auipc	a5,0x8
    80003a74:	2687b783          	ld	a5,616(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003a78:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003a7c:	00100713          	li	a4,1
    80003a80:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003a84:	fffff097          	auipc	ra,0xfffff
    80003a88:	3a8080e7          	jalr	936(ra) # 80002e2c <_ZN3TCB8dispatchEv>
}
    80003a8c:	00813083          	ld	ra,8(sp)
    80003a90:	00013403          	ld	s0,0(sp)
    80003a94:	01010113          	addi	sp,sp,16
    80003a98:	00008067          	ret

0000000080003a9c <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003a9c:	ff010113          	addi	sp,sp,-16
    80003aa0:	00113423          	sd	ra,8(sp)
    80003aa4:	00813023          	sd	s0,0(sp)
    80003aa8:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003aac:	00008797          	auipc	a5,0x8
    80003ab0:	4647c783          	lbu	a5,1124(a5) # 8000bf10 <_ZN5RiscV16userMainFinishedE>
    80003ab4:	00079c63          	bnez	a5,80003acc <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003ab8:	00008717          	auipc	a4,0x8
    80003abc:	21873703          	ld	a4,536(a4) # 8000bcd0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003ac0:	00073783          	ld	a5,0(a4)
    80003ac4:	00178793          	addi	a5,a5,1
    80003ac8:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003acc:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003ad0:	0ff57513          	andi	a0,a0,255
    80003ad4:	00001097          	auipc	ra,0x1
    80003ad8:	254080e7          	jalr	596(ra) # 80004d28 <_ZN11ConsoleUtil9putOutputEc>
}
    80003adc:	00813083          	ld	ra,8(sp)
    80003ae0:	00013403          	ld	s0,0(sp)
    80003ae4:	01010113          	addi	sp,sp,16
    80003ae8:	00008067          	ret

0000000080003aec <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003aec:	fe010113          	addi	sp,sp,-32
    80003af0:	00113c23          	sd	ra,24(sp)
    80003af4:	00813823          	sd	s0,16(sp)
    80003af8:	02010413          	addi	s0,sp,32
    80003afc:	00c0006f          	j	80003b08 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003b00:	ffffe097          	auipc	ra,0xffffe
    80003b04:	3c0080e7          	jalr	960(ra) # 80001ec0 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003b08:	00008797          	auipc	a5,0x8
    80003b0c:	1587b783          	ld	a5,344(a5) # 8000bc60 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003b10:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003b14:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003b18:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003b1c:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003b20:	0207f793          	andi	a5,a5,32
    80003b24:	fc078ee3          	beqz	a5,80003b00 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003b28:	00001097          	auipc	ra,0x1
    80003b2c:	488080e7          	jalr	1160(ra) # 80004fb0 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003b30:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003b34:	00008797          	auipc	a5,0x8
    80003b38:	1247b783          	ld	a5,292(a5) # 8000bc58 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003b3c:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003b40:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003b44:	fef44783          	lbu	a5,-17(s0)
    80003b48:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003b4c:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003b50:	00008797          	auipc	a5,0x8
    80003b54:	1807b783          	ld	a5,384(a5) # 8000bcd0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003b58:	0007b783          	ld	a5,0(a5)
    80003b5c:	fa0786e3          	beqz	a5,80003b08 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003b60:	fff78793          	addi	a5,a5,-1
    80003b64:	00008717          	auipc	a4,0x8
    80003b68:	16c73703          	ld	a4,364(a4) # 8000bcd0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003b6c:	00f73023          	sd	a5,0(a4)
    80003b70:	f99ff06f          	j	80003b08 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003b74 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003b74:	ff010113          	addi	sp,sp,-16
    80003b78:	00813423          	sd	s0,8(sp)
    80003b7c:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003b80:	00008797          	auipc	a5,0x8
    80003b84:	1587b783          	ld	a5,344(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003b88:	0007b783          	ld	a5,0(a5)
    80003b8c:	0147a703          	lw	a4,20(a5)
    80003b90:	00100793          	li	a5,1
    80003b94:	00f70c63          	beq	a4,a5,80003bac <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003b98:	10000793          	li	a5,256
    80003b9c:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80003ba0:	00813403          	ld	s0,8(sp)
    80003ba4:	01010113          	addi	sp,sp,16
    80003ba8:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003bac:	10000793          	li	a5,256
    80003bb0:	1007a073          	csrs	sstatus,a5
}
    80003bb4:	fedff06f          	j	80003ba0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080003bb8 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003bb8:	ff010113          	addi	sp,sp,-16
    80003bbc:	00113423          	sd	ra,8(sp)
    80003bc0:	00813023          	sd	s0,0(sp)
    80003bc4:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003bc8:	00100793          	li	a5,1
    80003bcc:	00008717          	auipc	a4,0x8
    80003bd0:	34f70223          	sb	a5,836(a4) # 8000bf10 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003bd4:	00008797          	auipc	a5,0x8
    80003bd8:	0fc7b783          	ld	a5,252(a5) # 8000bcd0 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003bdc:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003be0:	00008797          	auipc	a5,0x8
    80003be4:	0a87b783          	ld	a5,168(a5) # 8000bc88 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003be8:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003bec:	00200793          	li	a5,2
    80003bf0:	1047b073          	csrc	sie,a5
    80003bf4:	20000793          	li	a5,512
    80003bf8:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003bfc:	00008797          	auipc	a5,0x8
    80003c00:	0ac7b783          	ld	a5,172(a5) # 8000bca8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003c04:	0007b783          	ld	a5,0(a5)
    80003c08:	00078c63          	beqz	a5,80003c20 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003c0c:	0487b703          	ld	a4,72(a5)
    80003c10:	00008797          	auipc	a5,0x8
    80003c14:	0987b783          	ld	a5,152(a5) # 8000bca8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003c18:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003c1c:	fe1ff06f          	j	80003bfc <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003c20:	00008797          	auipc	a5,0x8
    80003c24:	0907b783          	ld	a5,144(a5) # 8000bcb0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003c28:	0007b503          	ld	a0,0(a5)
    80003c2c:	00001097          	auipc	ra,0x1
    80003c30:	d40080e7          	jalr	-704(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003c34:	00008797          	auipc	a5,0x8
    80003c38:	08c7b783          	ld	a5,140(a5) # 8000bcc0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003c3c:	0007b703          	ld	a4,0(a5)
    80003c40:	00008797          	auipc	a5,0x8
    80003c44:	0887b783          	ld	a5,136(a5) # 8000bcc8 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003c48:	0007b783          	ld	a5,0(a5)
    80003c4c:	00f70863          	beq	a4,a5,80003c5c <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003c50:	ffffe097          	auipc	ra,0xffffe
    80003c54:	270080e7          	jalr	624(ra) # 80001ec0 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003c58:	fddff06f          	j	80003c34 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003c5c:	00813083          	ld	ra,8(sp)
    80003c60:	00013403          	ld	s0,0(sp)
    80003c64:	01010113          	addi	sp,sp,16
    80003c68:	00008067          	ret

0000000080003c6c <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003c6c:	ff010113          	addi	sp,sp,-16
    80003c70:	00813423          	sd	s0,8(sp)
    80003c74:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003c78:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003c7c:	00008717          	auipc	a4,0x8
    80003c80:	05c73703          	ld	a4,92(a4) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003c84:	00073703          	ld	a4,0(a4)
    80003c88:	06873703          	ld	a4,104(a4)
    80003c8c:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003c90:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003c94:	00078593          	mv	a1,a5
}
    80003c98:	00813403          	ld	s0,8(sp)
    80003c9c:	01010113          	addi	sp,sp,16
    80003ca0:	00008067          	ret

0000000080003ca4 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003ca4:	ff010113          	addi	sp,sp,-16
    80003ca8:	00113423          	sd	ra,8(sp)
    80003cac:	00813023          	sd	s0,0(sp)
    80003cb0:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003cb4:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80003cb8:	fffff097          	auipc	ra,0xfffff
    80003cbc:	40c080e7          	jalr	1036(ra) # 800030c4 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003cc0:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003cc4:	00000097          	auipc	ra,0x0
    80003cc8:	fa8080e7          	jalr	-88(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ccc:	00813083          	ld	ra,8(sp)
    80003cd0:	00013403          	ld	s0,0(sp)
    80003cd4:	01010113          	addi	sp,sp,16
    80003cd8:	00008067          	ret

0000000080003cdc <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003cdc:	ff010113          	addi	sp,sp,-16
    80003ce0:	00113423          	sd	ra,8(sp)
    80003ce4:	00813023          	sd	s0,0(sp)
    80003ce8:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003cec:	00008797          	auipc	a5,0x8
    80003cf0:	ff47b783          	ld	a5,-12(a5) # 8000bce0 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003cf4:	0007c783          	lbu	a5,0(a5)
    80003cf8:	02079263          	bnez	a5,80003d1c <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003cfc:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d00:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003d04:	00000097          	auipc	ra,0x0
    80003d08:	f68080e7          	jalr	-152(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d0c:	00813083          	ld	ra,8(sp)
    80003d10:	00013403          	ld	s0,0(sp)
    80003d14:	01010113          	addi	sp,sp,16
    80003d18:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003d1c:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003d20:	fffff097          	auipc	ra,0xfffff
    80003d24:	5cc080e7          	jalr	1484(ra) # 800032ec <_ZN15MemoryAllocator5kfreeEPv>
    80003d28:	fd9ff06f          	j	80003d00 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003d2c <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003d2c:	fc010113          	addi	sp,sp,-64
    80003d30:	02113c23          	sd	ra,56(sp)
    80003d34:	02813823          	sd	s0,48(sp)
    80003d38:	02913423          	sd	s1,40(sp)
    80003d3c:	03213023          	sd	s2,32(sp)
    80003d40:	01313c23          	sd	s3,24(sp)
    80003d44:	01413823          	sd	s4,16(sp)
    80003d48:	01513423          	sd	s5,8(sp)
    80003d4c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003d50:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003d54:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003d58:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003d5c:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003d60:	07000513          	li	a0,112
    80003d64:	fffff097          	auipc	ra,0xfffff
    80003d68:	148080e7          	jalr	328(ra) # 80002eac <_ZN3TCBnwEm>
    80003d6c:	00050493          	mv	s1,a0
    80003d70:	00200713          	li	a4,2
    80003d74:	000a0693          	mv	a3,s4
    80003d78:	00098613          	mv	a2,s3
    80003d7c:	00090593          	mv	a1,s2
    80003d80:	fffff097          	auipc	ra,0xfffff
    80003d84:	fe0080e7          	jalr	-32(ra) # 80002d60 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003d88:	04048863          	beqz	s1,80003dd8 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003d8c:	0184b783          	ld	a5,24(s1)
    80003d90:	00078863          	beqz	a5,80003da0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003d94:	00048513          	mv	a0,s1
    80003d98:	00001097          	auipc	ra,0x1
    80003d9c:	bd4080e7          	jalr	-1068(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003da0:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003da4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003da8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003dac:	00000097          	auipc	ra,0x0
    80003db0:	ec0080e7          	jalr	-320(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003db4:	03813083          	ld	ra,56(sp)
    80003db8:	03013403          	ld	s0,48(sp)
    80003dbc:	02813483          	ld	s1,40(sp)
    80003dc0:	02013903          	ld	s2,32(sp)
    80003dc4:	01813983          	ld	s3,24(sp)
    80003dc8:	01013a03          	ld	s4,16(sp)
    80003dcc:	00813a83          	ld	s5,8(sp)
    80003dd0:	04010113          	addi	sp,sp,64
    80003dd4:	00008067          	ret
        status = -1;
    80003dd8:	fff00793          	li	a5,-1
    80003ddc:	fcdff06f          	j	80003da8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    80003de0:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003de4:	00048513          	mv	a0,s1
    80003de8:	fffff097          	auipc	ra,0xfffff
    80003dec:	1e0080e7          	jalr	480(ra) # 80002fc8 <_ZN3TCBdlEPv>
    80003df0:	00090513          	mv	a0,s2
    80003df4:	00009097          	auipc	ra,0x9
    80003df8:	274080e7          	jalr	628(ra) # 8000d068 <_Unwind_Resume>

0000000080003dfc <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003dfc:	fc010113          	addi	sp,sp,-64
    80003e00:	02113c23          	sd	ra,56(sp)
    80003e04:	02813823          	sd	s0,48(sp)
    80003e08:	02913423          	sd	s1,40(sp)
    80003e0c:	03213023          	sd	s2,32(sp)
    80003e10:	01313c23          	sd	s3,24(sp)
    80003e14:	01413823          	sd	s4,16(sp)
    80003e18:	01513423          	sd	s5,8(sp)
    80003e1c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003e20:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003e24:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003e28:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003e2c:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003e30:	07000513          	li	a0,112
    80003e34:	fffff097          	auipc	ra,0xfffff
    80003e38:	078080e7          	jalr	120(ra) # 80002eac <_ZN3TCBnwEm>
    80003e3c:	00050493          	mv	s1,a0
    80003e40:	00200713          	li	a4,2
    80003e44:	00090693          	mv	a3,s2
    80003e48:	00098613          	mv	a2,s3
    80003e4c:	000a0593          	mv	a1,s4
    80003e50:	fffff097          	auipc	ra,0xfffff
    80003e54:	f10080e7          	jalr	-240(ra) # 80002d60 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003e58:	04048263          	beqz	s1,80003e9c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003e5c:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003e60:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003e64:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003e68:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e6c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003e70:	00000097          	auipc	ra,0x0
    80003e74:	dfc080e7          	jalr	-516(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e78:	03813083          	ld	ra,56(sp)
    80003e7c:	03013403          	ld	s0,48(sp)
    80003e80:	02813483          	ld	s1,40(sp)
    80003e84:	02013903          	ld	s2,32(sp)
    80003e88:	01813983          	ld	s3,24(sp)
    80003e8c:	01013a03          	ld	s4,16(sp)
    80003e90:	00813a83          	ld	s5,8(sp)
    80003e94:	04010113          	addi	sp,sp,64
    80003e98:	00008067          	ret
        status = -1;
    80003e9c:	fff00793          	li	a5,-1
    80003ea0:	fcdff06f          	j	80003e6c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003ea4:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003ea8:	00048513          	mv	a0,s1
    80003eac:	fffff097          	auipc	ra,0xfffff
    80003eb0:	11c080e7          	jalr	284(ra) # 80002fc8 <_ZN3TCBdlEPv>
    80003eb4:	00090513          	mv	a0,s2
    80003eb8:	00009097          	auipc	ra,0x9
    80003ebc:	1b0080e7          	jalr	432(ra) # 8000d068 <_Unwind_Resume>

0000000080003ec0 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003ec0:	ff010113          	addi	sp,sp,-16
    80003ec4:	00113423          	sd	ra,8(sp)
    80003ec8:	00813023          	sd	s0,0(sp)
    80003ecc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003ed0:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003ed4:	02051263          	bnez	a0,80003ef8 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003ed8:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003edc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003ee0:	00000097          	auipc	ra,0x0
    80003ee4:	d8c080e7          	jalr	-628(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ee8:	00813083          	ld	ra,8(sp)
    80003eec:	00013403          	ld	s0,0(sp)
    80003ef0:	01010113          	addi	sp,sp,16
    80003ef4:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003ef8:	00100793          	li	a5,1
    80003efc:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003f00:	00001097          	auipc	ra,0x1
    80003f04:	a6c080e7          	jalr	-1428(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003f08:	fffff097          	auipc	ra,0xfffff
    80003f0c:	f24080e7          	jalr	-220(ra) # 80002e2c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003f10:	00000793          	li	a5,0
    80003f14:	fc9ff06f          	j	80003edc <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003f18 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003f18:	ff010113          	addi	sp,sp,-16
    80003f1c:	00113423          	sd	ra,8(sp)
    80003f20:	00813023          	sd	s0,0(sp)
    80003f24:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003f28:	00008797          	auipc	a5,0x8
    80003f2c:	db07b783          	ld	a5,-592(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003f30:	0007b783          	ld	a5,0(a5)
    80003f34:	02078a63          	beqz	a5,80003f68 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003f38:	00200713          	li	a4,2
    80003f3c:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003f40:	fffff097          	auipc	ra,0xfffff
    80003f44:	eec080e7          	jalr	-276(ra) # 80002e2c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003f48:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003f4c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003f50:	00000097          	auipc	ra,0x0
    80003f54:	d1c080e7          	jalr	-740(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003f58:	00813083          	ld	ra,8(sp)
    80003f5c:	00013403          	ld	s0,0(sp)
    80003f60:	01010113          	addi	sp,sp,16
    80003f64:	00008067          	ret
        status = -1;
    80003f68:	fff00793          	li	a5,-1
    80003f6c:	fe1ff06f          	j	80003f4c <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003f70 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003f70:	fd010113          	addi	sp,sp,-48
    80003f74:	02113423          	sd	ra,40(sp)
    80003f78:	02813023          	sd	s0,32(sp)
    80003f7c:	00913c23          	sd	s1,24(sp)
    80003f80:	01213823          	sd	s2,16(sp)
    80003f84:	01313423          	sd	s3,8(sp)
    80003f88:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003f8c:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003f90:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003f94:	01800513          	li	a0,24
    80003f98:	fffff097          	auipc	ra,0xfffff
    80003f9c:	cc4080e7          	jalr	-828(ra) # 80002c5c <_ZN3SCBnwEm>
    80003fa0:	00050493          	mv	s1,a0
    80003fa4:	00090593          	mv	a1,s2
    80003fa8:	fffff097          	auipc	ra,0xfffff
    80003fac:	af8080e7          	jalr	-1288(ra) # 80002aa0 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003fb0:	02048a63          	beqz	s1,80003fe4 <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    80003fb4:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    80003fb8:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003fbc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003fc0:	00000097          	auipc	ra,0x0
    80003fc4:	cac080e7          	jalr	-852(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80003fc8:	02813083          	ld	ra,40(sp)
    80003fcc:	02013403          	ld	s0,32(sp)
    80003fd0:	01813483          	ld	s1,24(sp)
    80003fd4:	01013903          	ld	s2,16(sp)
    80003fd8:	00813983          	ld	s3,8(sp)
    80003fdc:	03010113          	addi	sp,sp,48
    80003fe0:	00008067          	ret
        status = -1;
    80003fe4:	fff00793          	li	a5,-1
    80003fe8:	fd5ff06f          	j	80003fbc <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80003fec:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003ff0:	00048513          	mv	a0,s1
    80003ff4:	fffff097          	auipc	ra,0xfffff
    80003ff8:	c98080e7          	jalr	-872(ra) # 80002c8c <_ZN3SCBdlEPv>
    80003ffc:	00090513          	mv	a0,s2
    80004000:	00009097          	auipc	ra,0x9
    80004004:	068080e7          	jalr	104(ra) # 8000d068 <_Unwind_Resume>

0000000080004008 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80004008:	fe010113          	addi	sp,sp,-32
    8000400c:	00113c23          	sd	ra,24(sp)
    80004010:	00813823          	sd	s0,16(sp)
    80004014:	00913423          	sd	s1,8(sp)
    80004018:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000401c:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80004020:	02049463          	bnez	s1,80004048 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80004024:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004028:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000402c:	00000097          	auipc	ra,0x0
    80004030:	c40080e7          	jalr	-960(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004034:	01813083          	ld	ra,24(sp)
    80004038:	01013403          	ld	s0,16(sp)
    8000403c:	00813483          	ld	s1,8(sp)
    80004040:	02010113          	addi	sp,sp,32
    80004044:	00008067          	ret
        delete (SCB*)ihandle;
    80004048:	00048513          	mv	a0,s1
    8000404c:	fffff097          	auipc	ra,0xfffff
    80004050:	a78080e7          	jalr	-1416(ra) # 80002ac4 <_ZN3SCBD1Ev>
    80004054:	00048513          	mv	a0,s1
    80004058:	fffff097          	auipc	ra,0xfffff
    8000405c:	c34080e7          	jalr	-972(ra) # 80002c8c <_ZN3SCBdlEPv>
    uint64 status = 0;
    80004060:	00000793          	li	a5,0
    80004064:	fc5ff06f          	j	80004028 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080004068 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80004068:	ff010113          	addi	sp,sp,-16
    8000406c:	00113423          	sd	ra,8(sp)
    80004070:	00813023          	sd	s0,0(sp)
    80004074:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80004078:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    8000407c:	02051c63          	bnez	a0,800040b4 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80004080:	00008797          	auipc	a5,0x8
    80004084:	c587b783          	ld	a5,-936(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004088:	0007b783          	ld	a5,0(a5)
    8000408c:	0607b783          	ld	a5,96(a5)
    80004090:	02078863          	beqz	a5,800040c0 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80004094:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004098:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000409c:	00000097          	auipc	ra,0x0
    800040a0:	bd0080e7          	jalr	-1072(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    800040a4:	00813083          	ld	ra,8(sp)
    800040a8:	00013403          	ld	s0,0(sp)
    800040ac:	01010113          	addi	sp,sp,16
    800040b0:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800040b4:	fffff097          	auipc	ra,0xfffff
    800040b8:	b1c080e7          	jalr	-1252(ra) # 80002bd0 <_ZN3SCB4waitEv>
    800040bc:	fc5ff06f          	j	80004080 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800040c0:	00000793          	li	a5,0
    800040c4:	fd5ff06f          	j	80004098 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800040c8 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800040c8:	ff010113          	addi	sp,sp,-16
    800040cc:	00113423          	sd	ra,8(sp)
    800040d0:	00813023          	sd	s0,0(sp)
    800040d4:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800040d8:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800040dc:	02051263          	bnez	a0,80004100 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800040e0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800040e4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800040e8:	00000097          	auipc	ra,0x0
    800040ec:	b84080e7          	jalr	-1148(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    800040f0:	00813083          	ld	ra,8(sp)
    800040f4:	00013403          	ld	s0,0(sp)
    800040f8:	01010113          	addi	sp,sp,16
    800040fc:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80004100:	fffff097          	auipc	ra,0xfffff
    80004104:	b20080e7          	jalr	-1248(ra) # 80002c20 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80004108:	00000793          	li	a5,0
    8000410c:	fd9ff06f          	j	800040e4 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080004110 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80004110:	fe010113          	addi	sp,sp,-32
    80004114:	00113c23          	sd	ra,24(sp)
    80004118:	00813823          	sd	s0,16(sp)
    8000411c:	00913423          	sd	s1,8(sp)
    80004120:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80004124:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80004128:	00008797          	auipc	a5,0x8
    8000412c:	bb07b783          	ld	a5,-1104(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004130:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80004134:	00008797          	auipc	a5,0x8
    80004138:	de47b783          	ld	a5,-540(a5) # 8000bf18 <_ZN5RiscV10globalTimeE>
    8000413c:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80004140:	00e787b3          	add	a5,a5,a4
    80004144:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80004148:	00048513          	mv	a0,s1
    8000414c:	00001097          	auipc	ra,0x1
    80004150:	89c080e7          	jalr	-1892(ra) # 800049e8 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80004154:	00300793          	li	a5,3
    80004158:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    8000415c:	fffff097          	auipc	ra,0xfffff
    80004160:	cd0080e7          	jalr	-816(ra) # 80002e2c <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004164:	00000793          	li	a5,0
    80004168:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    8000416c:	00000097          	auipc	ra,0x0
    80004170:	b00080e7          	jalr	-1280(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004174:	01813083          	ld	ra,24(sp)
    80004178:	01013403          	ld	s0,16(sp)
    8000417c:	00813483          	ld	s1,8(sp)
    80004180:	02010113          	addi	sp,sp,32
    80004184:	00008067          	ret

0000000080004188 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80004188:	fe010113          	addi	sp,sp,-32
    8000418c:	00113c23          	sd	ra,24(sp)
    80004190:	00813823          	sd	s0,16(sp)
    80004194:	00913423          	sd	s1,8(sp)
    80004198:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    8000419c:	00008797          	auipc	a5,0x8
    800041a0:	d747c783          	lbu	a5,-652(a5) # 8000bf10 <_ZN5RiscV16userMainFinishedE>
    800041a4:	00079c63          	bnez	a5,800041bc <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800041a8:	00008717          	auipc	a4,0x8
    800041ac:	ae073703          	ld	a4,-1312(a4) # 8000bc88 <_GLOBAL_OFFSET_TABLE_+0x38>
    800041b0:	00073783          	ld	a5,0(a4)
    800041b4:	00178793          	addi	a5,a5,1
    800041b8:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800041bc:	00001097          	auipc	ra,0x1
    800041c0:	afc080e7          	jalr	-1284(ra) # 80004cb8 <_ZN11ConsoleUtil8getInputEv>
    800041c4:	00050493          	mv	s1,a0
    if(c==13) {
    800041c8:	00d00793          	li	a5,13
    800041cc:	02f50663          	beq	a0,a5,800041f8 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800041d0:	01b00793          	li	a5,27
    800041d4:	04f51063          	bne	a0,a5,80004214 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800041d8:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800041dc:	00000097          	auipc	ra,0x0
    800041e0:	a90080e7          	jalr	-1392(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    800041e4:	01813083          	ld	ra,24(sp)
    800041e8:	01013403          	ld	s0,16(sp)
    800041ec:	00813483          	ld	s1,8(sp)
    800041f0:	02010113          	addi	sp,sp,32
    800041f4:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800041f8:	00d00513          	li	a0,13
    800041fc:	00001097          	auipc	ra,0x1
    80004200:	b2c080e7          	jalr	-1236(ra) # 80004d28 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80004204:	00a00513          	li	a0,10
    80004208:	00001097          	auipc	ra,0x1
    8000420c:	b20080e7          	jalr	-1248(ra) # 80004d28 <_ZN11ConsoleUtil9putOutputEc>
    80004210:	fc9ff06f          	j	800041d8 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80004214:	00001097          	auipc	ra,0x1
    80004218:	b14080e7          	jalr	-1260(ra) # 80004d28 <_ZN11ConsoleUtil9putOutputEc>
    8000421c:	fbdff06f          	j	800041d8 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004220 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004220:	ff010113          	addi	sp,sp,-16
    80004224:	00113423          	sd	ra,8(sp)
    80004228:	00813023          	sd	s0,0(sp)
    8000422c:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80004230:	00001097          	auipc	ra,0x1
    80004234:	b90080e7          	jalr	-1136(ra) # 80004dc0 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80004238:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000423c:	00000097          	auipc	ra,0x0
    80004240:	a30080e7          	jalr	-1488(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004244:	00813083          	ld	ra,8(sp)
    80004248:	00013403          	ld	s0,0(sp)
    8000424c:	01010113          	addi	sp,sp,16
    80004250:	00008067          	ret

0000000080004254 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80004254:	fe010113          	addi	sp,sp,-32
    80004258:	00113c23          	sd	ra,24(sp)
    8000425c:	00813823          	sd	s0,16(sp)
    80004260:	00913423          	sd	s1,8(sp)
    80004264:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004268:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    8000426c:	02049463          	bnez	s1,80004294 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80004270:	fff00793          	li	a5,-1
    80004274:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004278:	00000097          	auipc	ra,0x0
    8000427c:	9f4080e7          	jalr	-1548(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    80004280:	01813083          	ld	ra,24(sp)
    80004284:	01013403          	ld	s0,16(sp)
    80004288:	00813483          	ld	s1,8(sp)
    8000428c:	02010113          	addi	sp,sp,32
    80004290:	00008067          	ret
        kfree(thr->stack);
    80004294:	0284b503          	ld	a0,40(s1)
    80004298:	00001097          	auipc	ra,0x1
    8000429c:	e88080e7          	jalr	-376(ra) # 80005120 <_Z5kfreePKv>
        delete thr;
    800042a0:	00048513          	mv	a0,s1
    800042a4:	fffff097          	auipc	ra,0xfffff
    800042a8:	b60080e7          	jalr	-1184(ra) # 80002e04 <_ZN3TCBD1Ev>
    800042ac:	00048513          	mv	a0,s1
    800042b0:	fffff097          	auipc	ra,0xfffff
    800042b4:	d18080e7          	jalr	-744(ra) # 80002fc8 <_ZN3TCBdlEPv>
    800042b8:	fb9ff06f          	j	80004270 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

00000000800042bc <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800042bc:	fe010113          	addi	sp,sp,-32
    800042c0:	00113c23          	sd	ra,24(sp)
    800042c4:	00813823          	sd	s0,16(sp)
    800042c8:	00913423          	sd	s1,8(sp)
    800042cc:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800042d0:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    800042d4:	02049463          	bnez	s1,800042fc <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800042d8:	fff00793          	li	a5,-1
    800042dc:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800042e0:	00000097          	auipc	ra,0x0
    800042e4:	98c080e7          	jalr	-1652(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>
}
    800042e8:	01813083          	ld	ra,24(sp)
    800042ec:	01013403          	ld	s0,16(sp)
    800042f0:	00813483          	ld	s1,8(sp)
    800042f4:	02010113          	addi	sp,sp,32
    800042f8:	00008067          	ret
        delete scb;
    800042fc:	00048513          	mv	a0,s1
    80004300:	ffffe097          	auipc	ra,0xffffe
    80004304:	7c4080e7          	jalr	1988(ra) # 80002ac4 <_ZN3SCBD1Ev>
    80004308:	00048513          	mv	a0,s1
    8000430c:	fffff097          	auipc	ra,0xfffff
    80004310:	980080e7          	jalr	-1664(ra) # 80002c8c <_ZN3SCBdlEPv>
    80004314:	fc5ff06f          	j	800042d8 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080004318 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80004318:	fe010113          	addi	sp,sp,-32
    8000431c:	00113c23          	sd	ra,24(sp)
    80004320:	00813823          	sd	s0,16(sp)
    80004324:	00913423          	sd	s1,8(sp)
    80004328:	01213023          	sd	s2,0(sp)
    8000432c:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80004330:	00001537          	lui	a0,0x1
    80004334:	00001097          	auipc	ra,0x1
    80004338:	dc4080e7          	jalr	-572(ra) # 800050f8 <_Z7kmallocm>
    8000433c:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80004340:	00008797          	auipc	a5,0x8
    80004344:	9987b783          	ld	a5,-1640(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004348:	0007b783          	ld	a5,0(a5)
    8000434c:	00001637          	lui	a2,0x1
    80004350:	00050593          	mv	a1,a0
    80004354:	0287b503          	ld	a0,40(a5)
    80004358:	fffff097          	auipc	ra,0xfffff
    8000435c:	148080e7          	jalr	328(ra) # 800034a0 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004360:	07000513          	li	a0,112
    80004364:	fffff097          	auipc	ra,0xfffff
    80004368:	b48080e7          	jalr	-1208(ra) # 80002eac <_ZN3TCBnwEm>
    8000436c:	00050493          	mv	s1,a0
    80004370:	00200713          	li	a4,2
    80004374:	00090693          	mv	a3,s2
    80004378:	00000613          	li	a2,0
    8000437c:	00000593          	li	a1,0
    80004380:	fffff097          	auipc	ra,0xfffff
    80004384:	9e0080e7          	jalr	-1568(ra) # 80002d60 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80004388:	0a048e63          	beqz	s1,80004444 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    8000438c:	00008797          	auipc	a5,0x8
    80004390:	9147b783          	ld	a5,-1772(a5) # 8000bca0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004394:	0007b783          	ld	a5,0(a5)
    80004398:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    8000439c:	00008797          	auipc	a5,0x8
    800043a0:	8f47b783          	ld	a5,-1804(a5) # 8000bc90 <_GLOBAL_OFFSET_TABLE_+0x40>
    800043a4:	0007b783          	ld	a5,0(a5)
    800043a8:	00f907b3          	add	a5,s2,a5
    800043ac:	00008717          	auipc	a4,0x8
    800043b0:	92c73703          	ld	a4,-1748(a4) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800043b4:	00073683          	ld	a3,0(a4)
    800043b8:	0286b683          	ld	a3,40(a3)
    800043bc:	40d787b3          	sub	a5,a5,a3
    800043c0:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800043c4:	00073783          	ld	a5,0(a4)
    800043c8:	0687b503          	ld	a0,104(a5)
    800043cc:	0287b783          	ld	a5,40(a5)
    800043d0:	40f50533          	sub	a0,a0,a5
    800043d4:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    800043d8:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800043dc:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800043e0:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800043e4:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800043e8:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800043ec:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800043f0:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800043f4:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800043f8:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    800043fc:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80004400:	00073783          	ld	a5,0(a4)
    80004404:	0387b703          	ld	a4,56(a5)
    80004408:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    8000440c:	0407b783          	ld	a5,64(a5)
    80004410:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004414:	00048513          	mv	a0,s1
    80004418:	00000097          	auipc	ra,0x0
    8000441c:	554080e7          	jalr	1364(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80004420:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80004424:	00000097          	auipc	ra,0x0
    80004428:	848080e7          	jalr	-1976(ra) # 80003c6c <_ZN5RiscV16saveA0toSscratchEv>

}
    8000442c:	01813083          	ld	ra,24(sp)
    80004430:	01013403          	ld	s0,16(sp)
    80004434:	00813483          	ld	s1,8(sp)
    80004438:	00013903          	ld	s2,0(sp)
    8000443c:	02010113          	addi	sp,sp,32
    80004440:	00008067          	ret
        status = -1;
    80004444:	fff00493          	li	s1,-1
    80004448:	fd9ff06f          	j	80004420 <_ZN5RiscV18executeForkSyscallEv+0x108>
    8000444c:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004450:	00048513          	mv	a0,s1
    80004454:	fffff097          	auipc	ra,0xfffff
    80004458:	b74080e7          	jalr	-1164(ra) # 80002fc8 <_ZN3TCBdlEPv>
    8000445c:	00090513          	mv	a0,s2
    80004460:	00009097          	auipc	ra,0x9
    80004464:	c08080e7          	jalr	-1016(ra) # 8000d068 <_Unwind_Resume>

0000000080004468 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80004468:	ff010113          	addi	sp,sp,-16
    8000446c:	00813423          	sd	s0,8(sp)
    80004470:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80004474:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80004478:	00878793          	addi	a5,a5,8
    8000447c:	00008717          	auipc	a4,0x8
    80004480:	82473703          	ld	a4,-2012(a4) # 8000bca0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004484:	00f73023          	sd	a5,0(a4)
}
    80004488:	00813403          	ld	s0,8(sp)
    8000448c:	01010113          	addi	sp,sp,16
    80004490:	00008067          	ret

0000000080004494 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004494:	fa010113          	addi	sp,sp,-96
    80004498:	04113c23          	sd	ra,88(sp)
    8000449c:	04813823          	sd	s0,80(sp)
    800044a0:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800044a4:	142027f3          	csrr	a5,scause
    800044a8:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    800044ac:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    800044b0:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800044b4:	00008797          	auipc	a5,0x8
    800044b8:	8247b783          	ld	a5,-2012(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800044bc:	0007b783          	ld	a5,0(a5)
    800044c0:	14002773          	csrr	a4,sscratch
    800044c4:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800044c8:	fe843703          	ld	a4,-24(s0)
    800044cc:	00900793          	li	a5,9
    800044d0:	0ef70663          	beq	a4,a5,800045bc <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    800044d4:	fe843703          	ld	a4,-24(s0)
    800044d8:	00800793          	li	a5,8
    800044dc:	0ef70063          	beq	a4,a5,800045bc <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    800044e0:	fe843703          	ld	a4,-24(s0)
    800044e4:	fff00793          	li	a5,-1
    800044e8:	03f79793          	slli	a5,a5,0x3f
    800044ec:	00178793          	addi	a5,a5,1
    800044f0:	24f70263          	beq	a4,a5,80004734 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    800044f4:	fe843703          	ld	a4,-24(s0)
    800044f8:	fff00793          	li	a5,-1
    800044fc:	03f79793          	slli	a5,a5,0x3f
    80004500:	00978793          	addi	a5,a5,9
    80004504:	2cf70063          	beq	a4,a5,800047c4 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    80004508:	fe843703          	ld	a4,-24(s0)
    8000450c:	00200793          	li	a5,2
    80004510:	34f70863          	beq	a4,a5,80004860 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004514:	00005517          	auipc	a0,0x5
    80004518:	e8450513          	addi	a0,a0,-380 # 80009398 <CONSOLE_STATUS+0x388>
    8000451c:	00001097          	auipc	ra,0x1
    80004520:	914080e7          	jalr	-1772(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004524:	00005517          	auipc	a0,0x5
    80004528:	e8450513          	addi	a0,a0,-380 # 800093a8 <CONSOLE_STATUS+0x398>
    8000452c:	00001097          	auipc	ra,0x1
    80004530:	904080e7          	jalr	-1788(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004534:	142027f3          	csrr	a5,scause
    80004538:	fef43023          	sd	a5,-32(s0)
    return scause;
    8000453c:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80004540:	00000613          	li	a2,0
    80004544:	00a00593          	li	a1,10
    80004548:	0005051b          	sext.w	a0,a0
    8000454c:	00001097          	auipc	ra,0x1
    80004550:	928080e7          	jalr	-1752(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80004554:	00005517          	auipc	a0,0x5
    80004558:	e1450513          	addi	a0,a0,-492 # 80009368 <CONSOLE_STATUS+0x358>
    8000455c:	00001097          	auipc	ra,0x1
    80004560:	8d4080e7          	jalr	-1836(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004564:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004568:	00000613          	li	a2,0
    8000456c:	01000593          	li	a1,16
    80004570:	0005051b          	sext.w	a0,a0
    80004574:	00001097          	auipc	ra,0x1
    80004578:	900080e7          	jalr	-1792(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000457c:	00005517          	auipc	a0,0x5
    80004580:	de450513          	addi	a0,a0,-540 # 80009360 <CONSOLE_STATUS+0x350>
    80004584:	00001097          	auipc	ra,0x1
    80004588:	8ac080e7          	jalr	-1876(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    8000458c:	00007797          	auipc	a5,0x7
    80004590:	74c7b783          	ld	a5,1868(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004594:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004598:	00200713          	li	a4,2
    8000459c:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    800045a0:	00005517          	auipc	a0,0x5
    800045a4:	e1850513          	addi	a0,a0,-488 # 800093b8 <CONSOLE_STATUS+0x3a8>
    800045a8:	00001097          	auipc	ra,0x1
    800045ac:	888080e7          	jalr	-1912(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800045b0:	fffff097          	auipc	ra,0xfffff
    800045b4:	87c080e7          	jalr	-1924(ra) # 80002e2c <_ZN3TCB8dispatchEv>
    800045b8:	0800006f          	j	80004638 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800045bc:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800045c0:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800045c4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    800045c8:	00478793          	addi	a5,a5,4
    800045cc:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    800045d0:	00007797          	auipc	a5,0x7
    800045d4:	7087b783          	ld	a5,1800(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    800045d8:	0007b783          	ld	a5,0(a5)
    800045dc:	fb043703          	ld	a4,-80(s0)
    800045e0:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800045e4:	fa843703          	ld	a4,-88(s0)
    800045e8:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800045ec:	00050793          	mv	a5,a0
        switch(syscallID){
    800045f0:	06100713          	li	a4,97
    800045f4:	02f76463          	bltu	a4,a5,8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    800045f8:	00279793          	slli	a5,a5,0x2
    800045fc:	00005717          	auipc	a4,0x5
    80004600:	dd070713          	addi	a4,a4,-560 # 800093cc <CONSOLE_STATUS+0x3bc>
    80004604:	00e787b3          	add	a5,a5,a4
    80004608:	0007a783          	lw	a5,0(a5)
    8000460c:	00e787b3          	add	a5,a5,a4
    80004610:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004614:	fffff097          	auipc	ra,0xfffff
    80004618:	690080e7          	jalr	1680(ra) # 80003ca4 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    8000461c:	00007797          	auipc	a5,0x7
    80004620:	6bc7b783          	ld	a5,1724(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004624:	0007b783          	ld	a5,0(a5)
    80004628:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000462c:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80004630:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004634:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80004638:	fffff097          	auipc	ra,0xfffff
    8000463c:	53c080e7          	jalr	1340(ra) # 80003b74 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80004640:	05813083          	ld	ra,88(sp)
    80004644:	05013403          	ld	s0,80(sp)
    80004648:	06010113          	addi	sp,sp,96
    8000464c:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004650:	fffff097          	auipc	ra,0xfffff
    80004654:	68c080e7          	jalr	1676(ra) # 80003cdc <_ZN5RiscV21executeMemFreeSyscallEv>
    80004658:	fc5ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    8000465c:	fffff097          	auipc	ra,0xfffff
    80004660:	6d0080e7          	jalr	1744(ra) # 80003d2c <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004664:	fb9ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    80004668:	00000097          	auipc	ra,0x0
    8000466c:	8b0080e7          	jalr	-1872(ra) # 80003f18 <_ZN5RiscV24executeThreadExitSyscallEv>
    80004670:	fadff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004674:	fffff097          	auipc	ra,0xfffff
    80004678:	3ec080e7          	jalr	1004(ra) # 80003a60 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    8000467c:	fa1ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004680:	fffff097          	auipc	ra,0xfffff
    80004684:	77c080e7          	jalr	1916(ra) # 80003dfc <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80004688:	f95ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    8000468c:	00000097          	auipc	ra,0x0
    80004690:	834080e7          	jalr	-1996(ra) # 80003ec0 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004694:	f89ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    80004698:	00000097          	auipc	ra,0x0
    8000469c:	8d8080e7          	jalr	-1832(ra) # 80003f70 <_ZN5RiscV21executeSemOpenSyscallEv>
    800046a0:	f7dff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    800046a4:	00000097          	auipc	ra,0x0
    800046a8:	964080e7          	jalr	-1692(ra) # 80004008 <_ZN5RiscV22executeSemCloseSyscallEv>
    800046ac:	f71ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    800046b0:	00000097          	auipc	ra,0x0
    800046b4:	9b8080e7          	jalr	-1608(ra) # 80004068 <_ZN5RiscV21executeSemWaitSyscallEv>
    800046b8:	f65ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    800046bc:	00000097          	auipc	ra,0x0
    800046c0:	a0c080e7          	jalr	-1524(ra) # 800040c8 <_ZN5RiscV23executeSemSignalSyscallEv>
    800046c4:	f59ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    800046c8:	00000097          	auipc	ra,0x0
    800046cc:	a48080e7          	jalr	-1464(ra) # 80004110 <_ZN5RiscV23executeTimeSleepSyscallEv>
    800046d0:	f4dff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    800046d4:	00000097          	auipc	ra,0x0
    800046d8:	ab4080e7          	jalr	-1356(ra) # 80004188 <_ZN5RiscV18executeGetcSyscallEv>
    800046dc:	f41ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    800046e0:	fffff097          	auipc	ra,0xfffff
    800046e4:	3bc080e7          	jalr	956(ra) # 80003a9c <_ZN5RiscV18executePutcSyscallEv>
    800046e8:	f35ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    800046ec:	00000097          	auipc	ra,0x0
    800046f0:	b34080e7          	jalr	-1228(ra) # 80004220 <_ZN5RiscV22executePutcUtilSyscallEv>
    800046f4:	f29ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    800046f8:	00000097          	auipc	ra,0x0
    800046fc:	b5c080e7          	jalr	-1188(ra) # 80004254 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004700:	f1dff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004704:	00000097          	auipc	ra,0x0
    80004708:	bb8080e7          	jalr	-1096(ra) # 800042bc <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    8000470c:	f11ff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004710:	00010793          	mv	a5,sp
    80004714:	00007717          	auipc	a4,0x7
    80004718:	57c73703          	ld	a4,1404(a4) # 8000bc90 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000471c:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004720:	00000097          	auipc	ra,0x0
    80004724:	d48080e7          	jalr	-696(ra) # 80004468 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004728:	00000097          	auipc	ra,0x0
    8000472c:	bf0080e7          	jalr	-1040(ra) # 80004318 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004730:	eedff06f          	j	8000461c <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004734:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004738:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    8000473c:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004740:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004744:	00200793          	li	a5,2
    80004748:	1447b073          	csrc	sip,a5
        globalTime += 1;
    8000474c:	00007717          	auipc	a4,0x7
    80004750:	7c470713          	addi	a4,a4,1988 # 8000bf10 <_ZN5RiscV16userMainFinishedE>
    80004754:	00873783          	ld	a5,8(a4)
    80004758:	00178793          	addi	a5,a5,1
    8000475c:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80004760:	00000097          	auipc	ra,0x0
    80004764:	2e0080e7          	jalr	736(ra) # 80004a40 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80004768:	00007717          	auipc	a4,0x7
    8000476c:	50873703          	ld	a4,1288(a4) # 8000bc70 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004770:	00073783          	ld	a5,0(a4)
    80004774:	00178793          	addi	a5,a5,1
    80004778:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    8000477c:	00007717          	auipc	a4,0x7
    80004780:	55c73703          	ld	a4,1372(a4) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004784:	00073703          	ld	a4,0(a4)
    80004788:	03073683          	ld	a3,48(a4)
    8000478c:	00d7fc63          	bgeu	a5,a3,800047a4 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004790:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004794:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004798:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000479c:	14179073          	csrw	sepc,a5
}
    800047a0:	e99ff06f          	j	80004638 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    800047a4:	00007797          	auipc	a5,0x7
    800047a8:	4cc7b783          	ld	a5,1228(a5) # 8000bc70 <_GLOBAL_OFFSET_TABLE_+0x20>
    800047ac:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    800047b0:	00100793          	li	a5,1
    800047b4:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    800047b8:	ffffe097          	auipc	ra,0xffffe
    800047bc:	674080e7          	jalr	1652(ra) # 80002e2c <_ZN3TCB8dispatchEv>
    800047c0:	fd1ff06f          	j	80004790 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    800047c4:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800047c8:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800047cc:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800047d0:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    800047d4:	00007797          	auipc	a5,0x7
    800047d8:	48c7b783          	ld	a5,1164(a5) # 8000bc60 <_GLOBAL_OFFSET_TABLE_+0x10>
    800047dc:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800047e0:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800047e4:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800047e8:	00058793          	mv	a5,a1
        if(status & 1UL)
    800047ec:	0017f793          	andi	a5,a5,1
    800047f0:	02078863          	beqz	a5,80004820 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    800047f4:	00007797          	auipc	a5,0x7
    800047f8:	48c7b783          	ld	a5,1164(a5) # 8000bc80 <_GLOBAL_OFFSET_TABLE_+0x30>
    800047fc:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004800:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004804:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004808:	00058513          	mv	a0,a1
    8000480c:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004810:	00007797          	auipc	a5,0x7
    80004814:	4787b783          	ld	a5,1144(a5) # 8000bc88 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004818:	0007b783          	ld	a5,0(a5)
    8000481c:	02079463          	bnez	a5,80004844 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80004820:	00002097          	auipc	ra,0x2
    80004824:	664080e7          	jalr	1636(ra) # 80006e84 <plic_claim>
    80004828:	00002097          	auipc	ra,0x2
    8000482c:	694080e7          	jalr	1684(ra) # 80006ebc <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004830:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004834:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004838:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    8000483c:	14179073          	csrw	sepc,a5
}
    80004840:	df9ff06f          	j	80004638 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004844:	fff78793          	addi	a5,a5,-1
    80004848:	00007717          	auipc	a4,0x7
    8000484c:	44073703          	ld	a4,1088(a4) # 8000bc88 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004850:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004854:	00000097          	auipc	ra,0x0
    80004858:	3e8080e7          	jalr	1000(ra) # 80004c3c <_ZN11ConsoleUtil8putInputEc>
    8000485c:	fc5ff06f          	j	80004820 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80004860:	00007797          	auipc	a5,0x7
    80004864:	4787b783          	ld	a5,1144(a5) # 8000bcd8 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004868:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000486c:	00200713          	li	a4,2
    80004870:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004874:	00005517          	auipc	a0,0x5
    80004878:	af450513          	addi	a0,a0,-1292 # 80009368 <CONSOLE_STATUS+0x358>
    8000487c:	00000097          	auipc	ra,0x0
    80004880:	5b4080e7          	jalr	1460(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004884:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80004888:	00000613          	li	a2,0
    8000488c:	01000593          	li	a1,16
    80004890:	0005051b          	sext.w	a0,a0
    80004894:	00000097          	auipc	ra,0x0
    80004898:	5e0080e7          	jalr	1504(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    8000489c:	00005517          	auipc	a0,0x5
    800048a0:	ac450513          	addi	a0,a0,-1340 # 80009360 <CONSOLE_STATUS+0x350>
    800048a4:	00000097          	auipc	ra,0x0
    800048a8:	58c080e7          	jalr	1420(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    800048ac:	00005517          	auipc	a0,0x5
    800048b0:	ac450513          	addi	a0,a0,-1340 # 80009370 <CONSOLE_STATUS+0x360>
    800048b4:	00000097          	auipc	ra,0x0
    800048b8:	57c080e7          	jalr	1404(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    800048bc:	ffffe097          	auipc	ra,0xffffe
    800048c0:	570080e7          	jalr	1392(ra) # 80002e2c <_ZN3TCB8dispatchEv>
    800048c4:	d75ff06f          	j	80004638 <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

00000000800048c8 <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    800048c8:	ff010113          	addi	sp,sp,-16
    800048cc:	00813423          	sd	s0,8(sp)
    800048d0:	01010413          	addi	s0,sp,16
    800048d4:	00050793          	mv	a5,a0
    800048d8:	00058513          	mv	a0,a1
    while(*src != '\0')
    800048dc:	0007c703          	lbu	a4,0(a5)
    800048e0:	00070a63          	beqz	a4,800048f4 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    800048e4:	00178793          	addi	a5,a5,1
    800048e8:	00e50023          	sb	a4,0(a0)
    800048ec:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    800048f0:	fedff06f          	j	800048dc <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800048f4:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800048f8:	00813403          	ld	s0,8(sp)
    800048fc:	01010113          	addi	sp,sp,16
    80004900:	00008067          	ret

0000000080004904 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004904:	fe010113          	addi	sp,sp,-32
    80004908:	00113c23          	sd	ra,24(sp)
    8000490c:	00813823          	sd	s0,16(sp)
    80004910:	00913423          	sd	s1,8(sp)
    80004914:	02010413          	addi	s0,sp,32
    80004918:	00050493          	mv	s1,a0
    8000491c:	00058513          	mv	a0,a1
    char *dest = dst;
    80004920:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004924:	0005c783          	lbu	a5,0(a1)
    80004928:	00078663          	beqz	a5,80004934 <_Z6strcatPcPKc+0x30>
        dest++;
    8000492c:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004930:	ff5ff06f          	j	80004924 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004934:	00000097          	auipc	ra,0x0
    80004938:	f94080e7          	jalr	-108(ra) # 800048c8 <_Z6strcpyPKcPc>
    return dst;
}
    8000493c:	00048513          	mv	a0,s1
    80004940:	01813083          	ld	ra,24(sp)
    80004944:	01013403          	ld	s0,16(sp)
    80004948:	00813483          	ld	s1,8(sp)
    8000494c:	02010113          	addi	sp,sp,32
    80004950:	00008067          	ret

0000000080004954 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004954:	ff010113          	addi	sp,sp,-16
    80004958:	00813423          	sd	s0,8(sp)
    8000495c:	01010413          	addi	s0,sp,16
}
    80004960:	00813403          	ld	s0,8(sp)
    80004964:	01010113          	addi	sp,sp,16
    80004968:	00008067          	ret

000000008000496c <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    8000496c:	ff010113          	addi	sp,sp,-16
    80004970:	00813423          	sd	s0,8(sp)
    80004974:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004978:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    8000497c:	00007797          	auipc	a5,0x7
    80004980:	5a47b783          	ld	a5,1444(a5) # 8000bf20 <_ZN9Scheduler9readyHeadE>
    80004984:	02078263          	beqz	a5,800049a8 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004988:	00007797          	auipc	a5,0x7
    8000498c:	5a07b783          	ld	a5,1440(a5) # 8000bf28 <_ZN9Scheduler9readyTailE>
    80004990:	04a7b423          	sd	a0,72(a5)
    80004994:	00007797          	auipc	a5,0x7
    80004998:	58a7ba23          	sd	a0,1428(a5) # 8000bf28 <_ZN9Scheduler9readyTailE>
}
    8000499c:	00813403          	ld	s0,8(sp)
    800049a0:	01010113          	addi	sp,sp,16
    800049a4:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800049a8:	00007797          	auipc	a5,0x7
    800049ac:	56a7bc23          	sd	a0,1400(a5) # 8000bf20 <_ZN9Scheduler9readyHeadE>
    800049b0:	fe5ff06f          	j	80004994 <_ZN9Scheduler3putEP3TCB+0x28>

00000000800049b4 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800049b4:	ff010113          	addi	sp,sp,-16
    800049b8:	00813423          	sd	s0,8(sp)
    800049bc:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800049c0:	00007517          	auipc	a0,0x7
    800049c4:	56053503          	ld	a0,1376(a0) # 8000bf20 <_ZN9Scheduler9readyHeadE>
    800049c8:	00050a63          	beqz	a0,800049dc <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    800049cc:	04853783          	ld	a5,72(a0)
    800049d0:	00007717          	auipc	a4,0x7
    800049d4:	54f73823          	sd	a5,1360(a4) # 8000bf20 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    800049d8:	04053423          	sd	zero,72(a0)
    return tmp;
}
    800049dc:	00813403          	ld	s0,8(sp)
    800049e0:	01010113          	addi	sp,sp,16
    800049e4:	00008067          	ret

00000000800049e8 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    800049e8:	ff010113          	addi	sp,sp,-16
    800049ec:	00813423          	sd	s0,8(sp)
    800049f0:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800049f4:	00007797          	auipc	a5,0x7
    800049f8:	53c7b783          	ld	a5,1340(a5) # 8000bf30 <_ZN9Scheduler12sleepingHeadE>
    800049fc:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a00:	00078e63          	beqz	a5,80004a1c <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004a04:	0587b683          	ld	a3,88(a5)
    80004a08:	05853703          	ld	a4,88(a0)
    80004a0c:	00d76863          	bltu	a4,a3,80004a1c <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004a10:	00078613          	mv	a2,a5
    80004a14:	0487b783          	ld	a5,72(a5)
    80004a18:	fe9ff06f          	j	80004a00 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004a1c:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004a20:	00060a63          	beqz	a2,80004a34 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004a24:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004a28:	00813403          	ld	s0,8(sp)
    80004a2c:	01010113          	addi	sp,sp,16
    80004a30:	00008067          	ret
        sleepingHead = t;
    80004a34:	00007797          	auipc	a5,0x7
    80004a38:	4ea7be23          	sd	a0,1276(a5) # 8000bf30 <_ZN9Scheduler12sleepingHeadE>
}
    80004a3c:	fedff06f          	j	80004a28 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004a40 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004a40:	fe010113          	addi	sp,sp,-32
    80004a44:	00113c23          	sd	ra,24(sp)
    80004a48:	00813823          	sd	s0,16(sp)
    80004a4c:	00913423          	sd	s1,8(sp)
    80004a50:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004a54:	00007497          	auipc	s1,0x7
    80004a58:	4dc4b483          	ld	s1,1244(s1) # 8000bf30 <_ZN9Scheduler12sleepingHeadE>
    80004a5c:	02048c63          	beqz	s1,80004a94 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    80004a60:	0584b703          	ld	a4,88(s1)
    80004a64:	00007797          	auipc	a5,0x7
    80004a68:	28c7b783          	ld	a5,652(a5) # 8000bcf0 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80004a6c:	0007b783          	ld	a5,0(a5)
    80004a70:	02e7e263          	bltu	a5,a4,80004a94 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004a74:	0484b783          	ld	a5,72(s1)
    80004a78:	00007717          	auipc	a4,0x7
    80004a7c:	4af73c23          	sd	a5,1208(a4) # 8000bf30 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    80004a80:	00048513          	mv	a0,s1
    80004a84:	00000097          	auipc	ra,0x0
    80004a88:	ee8080e7          	jalr	-280(ra) # 8000496c <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004a8c:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    80004a90:	fc5ff06f          	j	80004a54 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004a94:	01813083          	ld	ra,24(sp)
    80004a98:	01013403          	ld	s0,16(sp)
    80004a9c:	00813483          	ld	s1,8(sp)
    80004aa0:	02010113          	addi	sp,sp,32
    80004aa4:	00008067          	ret

0000000080004aa8 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004aa8:	fe010113          	addi	sp,sp,-32
    80004aac:	00113c23          	sd	ra,24(sp)
    80004ab0:	00813823          	sd	s0,16(sp)
    80004ab4:	00913423          	sd	s1,8(sp)
    80004ab8:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004abc:	00007497          	auipc	s1,0x7
    80004ac0:	4644b483          	ld	s1,1124(s1) # 8000bf20 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004ac4:	02048863          	beqz	s1,80004af4 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004ac8:	00000613          	li	a2,0
    80004acc:	01000593          	li	a1,16
    80004ad0:	0004851b          	sext.w	a0,s1
    80004ad4:	00000097          	auipc	ra,0x0
    80004ad8:	3a0080e7          	jalr	928(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004adc:	00005517          	auipc	a0,0x5
    80004ae0:	88450513          	addi	a0,a0,-1916 # 80009360 <CONSOLE_STATUS+0x350>
    80004ae4:	00000097          	auipc	ra,0x0
    80004ae8:	34c080e7          	jalr	844(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004aec:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004af0:	fd5ff06f          	j	80004ac4 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004af4:	01813083          	ld	ra,24(sp)
    80004af8:	01013403          	ld	s0,16(sp)
    80004afc:	00813483          	ld	s1,8(sp)
    80004b00:	02010113          	addi	sp,sp,32
    80004b04:	00008067          	ret

0000000080004b08 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004b08:	fe010113          	addi	sp,sp,-32
    80004b0c:	00113c23          	sd	ra,24(sp)
    80004b10:	00813823          	sd	s0,16(sp)
    80004b14:	00913423          	sd	s1,8(sp)
    80004b18:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004b1c:	00007497          	auipc	s1,0x7
    80004b20:	4144b483          	ld	s1,1044(s1) # 8000bf30 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004b24:	02048863          	beqz	s1,80004b54 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004b28:	00000613          	li	a2,0
    80004b2c:	01000593          	li	a1,16
    80004b30:	0004851b          	sext.w	a0,s1
    80004b34:	ffffe097          	auipc	ra,0xffffe
    80004b38:	e14080e7          	jalr	-492(ra) # 80002948 <_Z8printIntiii>
        printString("\n");
    80004b3c:	00005517          	auipc	a0,0x5
    80004b40:	82450513          	addi	a0,a0,-2012 # 80009360 <CONSOLE_STATUS+0x350>
    80004b44:	ffffe097          	auipc	ra,0xffffe
    80004b48:	c6c080e7          	jalr	-916(ra) # 800027b0 <_Z11printStringPKc>
        iter = iter->next;
    80004b4c:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004b50:	fd5ff06f          	j	80004b24 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004b54:	01813083          	ld	ra,24(sp)
    80004b58:	01013403          	ld	s0,16(sp)
    80004b5c:	00813483          	ld	s1,8(sp)
    80004b60:	02010113          	addi	sp,sp,32
    80004b64:	00008067          	ret

0000000080004b68 <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char* ConsoleUtil::inputBuffer = nullptr;
char* ConsoleUtil::outputBuffer = nullptr;

void ConsoleUtil::initialize() {
    80004b68:	fe010113          	addi	sp,sp,-32
    80004b6c:	00113c23          	sd	ra,24(sp)
    80004b70:	00813823          	sd	s0,16(sp)
    80004b74:	00913423          	sd	s1,8(sp)
    80004b78:	01213023          	sd	s2,0(sp)
    80004b7c:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    80004b80:	01800513          	li	a0,24
    80004b84:	ffffe097          	auipc	ra,0xffffe
    80004b88:	0d8080e7          	jalr	216(ra) # 80002c5c <_ZN3SCBnwEm>
    80004b8c:	00050493          	mv	s1,a0
    80004b90:	00000593          	li	a1,0
    80004b94:	ffffe097          	auipc	ra,0xffffe
    80004b98:	f0c080e7          	jalr	-244(ra) # 80002aa0 <_ZN3SCBC1Em>
    80004b9c:	00007797          	auipc	a5,0x7
    80004ba0:	3897be23          	sd	s1,924(a5) # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004ba4:	01800513          	li	a0,24
    80004ba8:	ffffe097          	auipc	ra,0xffffe
    80004bac:	0b4080e7          	jalr	180(ra) # 80002c5c <_ZN3SCBnwEm>
    80004bb0:	00050493          	mv	s1,a0
    80004bb4:	00000593          	li	a1,0
    80004bb8:	ffffe097          	auipc	ra,0xffffe
    80004bbc:	ee8080e7          	jalr	-280(ra) # 80002aa0 <_ZN3SCBC1Em>
    80004bc0:	00007917          	auipc	s2,0x7
    80004bc4:	37890913          	addi	s2,s2,888 # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    80004bc8:	00993423          	sd	s1,8(s2)
    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004bcc:	00002537          	lui	a0,0x2
    80004bd0:	00000097          	auipc	ra,0x0
    80004bd4:	528080e7          	jalr	1320(ra) # 800050f8 <_Z7kmallocm>
    80004bd8:	00a93823          	sd	a0,16(s2)
    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
    80004bdc:	00002537          	lui	a0,0x2
    80004be0:	00000097          	auipc	ra,0x0
    80004be4:	518080e7          	jalr	1304(ra) # 800050f8 <_Z7kmallocm>
    80004be8:	00a93c23          	sd	a0,24(s2)
}
    80004bec:	01813083          	ld	ra,24(sp)
    80004bf0:	01013403          	ld	s0,16(sp)
    80004bf4:	00813483          	ld	s1,8(sp)
    80004bf8:	00013903          	ld	s2,0(sp)
    80004bfc:	02010113          	addi	sp,sp,32
    80004c00:	00008067          	ret
    80004c04:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004c08:	00048513          	mv	a0,s1
    80004c0c:	ffffe097          	auipc	ra,0xffffe
    80004c10:	080080e7          	jalr	128(ra) # 80002c8c <_ZN3SCBdlEPv>
    80004c14:	00090513          	mv	a0,s2
    80004c18:	00008097          	auipc	ra,0x8
    80004c1c:	450080e7          	jalr	1104(ra) # 8000d068 <_Unwind_Resume>
    80004c20:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004c24:	00048513          	mv	a0,s1
    80004c28:	ffffe097          	auipc	ra,0xffffe
    80004c2c:	064080e7          	jalr	100(ra) # 80002c8c <_ZN3SCBdlEPv>
    80004c30:	00090513          	mv	a0,s2
    80004c34:	00008097          	auipc	ra,0x8
    80004c38:	434080e7          	jalr	1076(ra) # 8000d068 <_Unwind_Resume>

0000000080004c3c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004c3c:	00007697          	auipc	a3,0x7
    80004c40:	2fc68693          	addi	a3,a3,764 # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    80004c44:	0206b603          	ld	a2,32(a3)
    80004c48:	00160793          	addi	a5,a2,1
    80004c4c:	00002737          	lui	a4,0x2
    80004c50:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004c54:	00e7f7b3          	and	a5,a5,a4
    80004c58:	0286b703          	ld	a4,40(a3)
    80004c5c:	04e78c63          	beq	a5,a4,80004cb4 <_ZN11ConsoleUtil8putInputEc+0x78>
void ConsoleUtil::putInput(char c) {
    80004c60:	ff010113          	addi	sp,sp,-16
    80004c64:	00113423          	sd	ra,8(sp)
    80004c68:	00813023          	sd	s0,0(sp)
    80004c6c:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004c70:	00068713          	mv	a4,a3
    80004c74:	0106b783          	ld	a5,16(a3)
    80004c78:	00c78633          	add	a2,a5,a2
    80004c7c:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80004c80:	0206b783          	ld	a5,32(a3)
    80004c84:	00178793          	addi	a5,a5,1
    80004c88:	000026b7          	lui	a3,0x2
    80004c8c:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004c90:	00d7f7b3          	and	a5,a5,a3
    80004c94:	02f73023          	sd	a5,32(a4)
    inputSem->signal();
    80004c98:	00073503          	ld	a0,0(a4)
    80004c9c:	ffffe097          	auipc	ra,0xffffe
    80004ca0:	f84080e7          	jalr	-124(ra) # 80002c20 <_ZN3SCB6signalEv>
}
    80004ca4:	00813083          	ld	ra,8(sp)
    80004ca8:	00013403          	ld	s0,0(sp)
    80004cac:	01010113          	addi	sp,sp,16
    80004cb0:	00008067          	ret
    80004cb4:	00008067          	ret

0000000080004cb8 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004cb8:	fe010113          	addi	sp,sp,-32
    80004cbc:	00113c23          	sd	ra,24(sp)
    80004cc0:	00813823          	sd	s0,16(sp)
    80004cc4:	00913423          	sd	s1,8(sp)
    80004cc8:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004ccc:	00007497          	auipc	s1,0x7
    80004cd0:	26c48493          	addi	s1,s1,620 # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    80004cd4:	0004b503          	ld	a0,0(s1)
    80004cd8:	ffffe097          	auipc	ra,0xffffe
    80004cdc:	ef8080e7          	jalr	-264(ra) # 80002bd0 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004ce0:	0284b783          	ld	a5,40(s1)
    80004ce4:	0204b703          	ld	a4,32(s1)
    80004ce8:	02e78c63          	beq	a5,a4,80004d20 <_ZN11ConsoleUtil8getInputEv+0x68>
        return -1;
    char c = inputBuffer[inputHead];
    80004cec:	0104b703          	ld	a4,16(s1)
    80004cf0:	00f70733          	add	a4,a4,a5
    80004cf4:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004cf8:	00178793          	addi	a5,a5,1
    80004cfc:	00002737          	lui	a4,0x2
    80004d00:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004d04:	00e7f7b3          	and	a5,a5,a4
    80004d08:	02f4b423          	sd	a5,40(s1)

    return c;
}
    80004d0c:	01813083          	ld	ra,24(sp)
    80004d10:	01013403          	ld	s0,16(sp)
    80004d14:	00813483          	ld	s1,8(sp)
    80004d18:	02010113          	addi	sp,sp,32
    80004d1c:	00008067          	ret
        return -1;
    80004d20:	0ff00513          	li	a0,255
    80004d24:	fe9ff06f          	j	80004d0c <_ZN11ConsoleUtil8getInputEv+0x54>

0000000080004d28 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004d28:	00007797          	auipc	a5,0x7
    80004d2c:	21078793          	addi	a5,a5,528 # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    80004d30:	0307b703          	ld	a4,48(a5)
    80004d34:	00170713          	addi	a4,a4,1
    80004d38:	02e7b823          	sd	a4,48(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004d3c:	0387b603          	ld	a2,56(a5)
    80004d40:	00160713          	addi	a4,a2,1
    80004d44:	000026b7          	lui	a3,0x2
    80004d48:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004d4c:	00d77733          	and	a4,a4,a3
    80004d50:	0407b783          	ld	a5,64(a5)
    80004d54:	06f70463          	beq	a4,a5,80004dbc <_ZN11ConsoleUtil9putOutputEc+0x94>
void ConsoleUtil::putOutput(char c) {
    80004d58:	ff010113          	addi	sp,sp,-16
    80004d5c:	00113423          	sd	ra,8(sp)
    80004d60:	00813023          	sd	s0,0(sp)
    80004d64:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004d68:	00007797          	auipc	a5,0x7
    80004d6c:	1d078793          	addi	a5,a5,464 # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    80004d70:	0187b703          	ld	a4,24(a5)
    80004d74:	00c70633          	add	a2,a4,a2
    80004d78:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    80004d7c:	0387b703          	ld	a4,56(a5)
    80004d80:	00170713          	addi	a4,a4,1
    80004d84:	000026b7          	lui	a3,0x2
    80004d88:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004d8c:	00d77733          	and	a4,a4,a3
    80004d90:	02e7bc23          	sd	a4,56(a5)

    pendingPutc--;
    80004d94:	0307b703          	ld	a4,48(a5)
    80004d98:	fff70713          	addi	a4,a4,-1
    80004d9c:	02e7b823          	sd	a4,48(a5)

    outputSem->signal();
    80004da0:	0087b503          	ld	a0,8(a5)
    80004da4:	ffffe097          	auipc	ra,0xffffe
    80004da8:	e7c080e7          	jalr	-388(ra) # 80002c20 <_ZN3SCB6signalEv>
}
    80004dac:	00813083          	ld	ra,8(sp)
    80004db0:	00013403          	ld	s0,0(sp)
    80004db4:	01010113          	addi	sp,sp,16
    80004db8:	00008067          	ret
    80004dbc:	00008067          	ret

0000000080004dc0 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004dc0:	fe010113          	addi	sp,sp,-32
    80004dc4:	00113c23          	sd	ra,24(sp)
    80004dc8:	00813823          	sd	s0,16(sp)
    80004dcc:	00913423          	sd	s1,8(sp)
    80004dd0:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004dd4:	00007497          	auipc	s1,0x7
    80004dd8:	16448493          	addi	s1,s1,356 # 8000bf38 <_ZN11ConsoleUtil8inputSemE>
    80004ddc:	0084b503          	ld	a0,8(s1)
    80004de0:	ffffe097          	auipc	ra,0xffffe
    80004de4:	df0080e7          	jalr	-528(ra) # 80002bd0 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004de8:	0404b783          	ld	a5,64(s1)
    80004dec:	0384b703          	ld	a4,56(s1)
    80004df0:	02e78c63          	beq	a5,a4,80004e28 <_ZN11ConsoleUtil9getOutputEv+0x68>
        return -1;

    char c = outputBuffer[outputHead];
    80004df4:	0184b703          	ld	a4,24(s1)
    80004df8:	00f70733          	add	a4,a4,a5
    80004dfc:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004e00:	00178793          	addi	a5,a5,1
    80004e04:	00002737          	lui	a4,0x2
    80004e08:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004e0c:	00e7f7b3          	and	a5,a5,a4
    80004e10:	04f4b023          	sd	a5,64(s1)

    return c;
}
    80004e14:	01813083          	ld	ra,24(sp)
    80004e18:	01013403          	ld	s0,16(sp)
    80004e1c:	00813483          	ld	s1,8(sp)
    80004e20:	02010113          	addi	sp,sp,32
    80004e24:	00008067          	ret
        return -1;
    80004e28:	0ff00513          	li	a0,255
    80004e2c:	fe9ff06f          	j	80004e14 <_ZN11ConsoleUtil9getOutputEv+0x54>

0000000080004e30 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004e30:	fe010113          	addi	sp,sp,-32
    80004e34:	00113c23          	sd	ra,24(sp)
    80004e38:	00813823          	sd	s0,16(sp)
    80004e3c:	00913423          	sd	s1,8(sp)
    80004e40:	02010413          	addi	s0,sp,32
    80004e44:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004e48:	0004c503          	lbu	a0,0(s1)
    80004e4c:	00050a63          	beqz	a0,80004e60 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004e50:	00000097          	auipc	ra,0x0
    80004e54:	ed8080e7          	jalr	-296(ra) # 80004d28 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004e58:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004e5c:	fedff06f          	j	80004e48 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004e60:	01813083          	ld	ra,24(sp)
    80004e64:	01013403          	ld	s0,16(sp)
    80004e68:	00813483          	ld	s1,8(sp)
    80004e6c:	02010113          	addi	sp,sp,32
    80004e70:	00008067          	ret

0000000080004e74 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004e74:	fb010113          	addi	sp,sp,-80
    80004e78:	04113423          	sd	ra,72(sp)
    80004e7c:	04813023          	sd	s0,64(sp)
    80004e80:	02913c23          	sd	s1,56(sp)
    80004e84:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004e88:	00004797          	auipc	a5,0x4
    80004e8c:	6d078793          	addi	a5,a5,1744 # 80009558 <CONSOLE_STATUS+0x548>
    80004e90:	0007b703          	ld	a4,0(a5)
    80004e94:	fce43423          	sd	a4,-56(s0)
    80004e98:	0087b703          	ld	a4,8(a5)
    80004e9c:	fce43823          	sd	a4,-48(s0)
    80004ea0:	0107c783          	lbu	a5,16(a5)
    80004ea4:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004ea8:	00060463          	beqz	a2,80004eb0 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004eac:	08054263          	bltz	a0,80004f30 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004eb0:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004eb4:	00000813          	li	a6,0
    }

    i = 0;
    80004eb8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004ebc:	0005871b          	sext.w	a4,a1
    80004ec0:	02b577bb          	remuw	a5,a0,a1
    80004ec4:	00048693          	mv	a3,s1
    80004ec8:	0014849b          	addiw	s1,s1,1
    80004ecc:	02079793          	slli	a5,a5,0x20
    80004ed0:	0207d793          	srli	a5,a5,0x20
    80004ed4:	fe040613          	addi	a2,s0,-32
    80004ed8:	00f607b3          	add	a5,a2,a5
    80004edc:	fe87c603          	lbu	a2,-24(a5)
    80004ee0:	fe040793          	addi	a5,s0,-32
    80004ee4:	00d787b3          	add	a5,a5,a3
    80004ee8:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004eec:	0005061b          	sext.w	a2,a0
    80004ef0:	02b5553b          	divuw	a0,a0,a1
    80004ef4:	fce674e3          	bgeu	a2,a4,80004ebc <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004ef8:	00080c63          	beqz	a6,80004f10 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004efc:	fe040793          	addi	a5,s0,-32
    80004f00:	009784b3          	add	s1,a5,s1
    80004f04:	02d00793          	li	a5,45
    80004f08:	fcf48c23          	sb	a5,-40(s1)
    80004f0c:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004f10:	fff4849b          	addiw	s1,s1,-1
    80004f14:	0204c463          	bltz	s1,80004f3c <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004f18:	fe040793          	addi	a5,s0,-32
    80004f1c:	009787b3          	add	a5,a5,s1
    80004f20:	fd87c503          	lbu	a0,-40(a5)
    80004f24:	00000097          	auipc	ra,0x0
    80004f28:	e04080e7          	jalr	-508(ra) # 80004d28 <_ZN11ConsoleUtil9putOutputEc>
    80004f2c:	fe5ff06f          	j	80004f10 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004f30:	40a0053b          	negw	a0,a0
        neg = 1;
    80004f34:	00100813          	li	a6,1
        x = -xx;
    80004f38:	f81ff06f          	j	80004eb8 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004f3c:	04813083          	ld	ra,72(sp)
    80004f40:	04013403          	ld	s0,64(sp)
    80004f44:	03813483          	ld	s1,56(sp)
    80004f48:	05010113          	addi	sp,sp,80
    80004f4c:	00008067          	ret

0000000080004f50 <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    80004f50:	fe010113          	addi	sp,sp,-32
    80004f54:	00113c23          	sd	ra,24(sp)
    80004f58:	00813823          	sd	s0,16(sp)
    80004f5c:	00913423          	sd	s1,8(sp)
    80004f60:	01213023          	sd	s2,0(sp)
    80004f64:	02010413          	addi	s0,sp,32
    80004f68:	00058913          	mv	s2,a1
    80004f6c:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    80004f70:	00000097          	auipc	ra,0x0
    80004f74:	ec0080e7          	jalr	-320(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    80004f78:	00000613          	li	a2,0
    80004f7c:	00a00593          	li	a1,10
    80004f80:	00090513          	mv	a0,s2
    80004f84:	00000097          	auipc	ra,0x0
    80004f88:	ef0080e7          	jalr	-272(ra) # 80004e74 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004f8c:	00048513          	mv	a0,s1
    80004f90:	00000097          	auipc	ra,0x0
    80004f94:	ea0080e7          	jalr	-352(ra) # 80004e30 <_ZN11ConsoleUtil11printStringEPKc>
}
    80004f98:	01813083          	ld	ra,24(sp)
    80004f9c:	01013403          	ld	s0,16(sp)
    80004fa0:	00813483          	ld	s1,8(sp)
    80004fa4:	00013903          	ld	s2,0(sp)
    80004fa8:	02010113          	addi	sp,sp,32
    80004fac:	00008067          	ret

0000000080004fb0 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004fb0:	ff010113          	addi	sp,sp,-16
    80004fb4:	00813423          	sd	s0,8(sp)
    80004fb8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004fbc:	04300513          	li	a0,67

    asm("ecall");
    80004fc0:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004fc4:	00050513          	mv	a0,a0

    return (char)status;
}
    80004fc8:	0ff57513          	andi	a0,a0,255
    80004fcc:	00813403          	ld	s0,8(sp)
    80004fd0:	01010113          	addi	sp,sp,16
    80004fd4:	00008067          	ret

0000000080004fd8 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004fd8:	ff010113          	addi	sp,sp,-16
    80004fdc:	00113423          	sd	ra,8(sp)
    80004fe0:	00813023          	sd	s0,0(sp)
    80004fe4:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004fe8:	ffffd097          	auipc	ra,0xffffd
    80004fec:	9c4080e7          	jalr	-1596(ra) # 800019ac <_ZN13SlabAllocator10initializeEPvm>
}
    80004ff0:	00813083          	ld	ra,8(sp)
    80004ff4:	00013403          	ld	s0,0(sp)
    80004ff8:	01010113          	addi	sp,sp,16
    80004ffc:	00008067          	ret

0000000080005000 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80005000:	ff010113          	addi	sp,sp,-16
    80005004:	00113423          	sd	ra,8(sp)
    80005008:	00813023          	sd	s0,0(sp)
    8000500c:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80005010:	ffffd097          	auipc	ra,0xffffd
    80005014:	8fc080e7          	jalr	-1796(ra) # 8000190c <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80005018:	00813083          	ld	ra,8(sp)
    8000501c:	00013403          	ld	s0,0(sp)
    80005020:	01010113          	addi	sp,sp,16
    80005024:	00008067          	ret

0000000080005028 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80005028:	ff010113          	addi	sp,sp,-16
    8000502c:	00113423          	sd	ra,8(sp)
    80005030:	00813023          	sd	s0,0(sp)
    80005034:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80005038:	ffffc097          	auipc	ra,0xffffc
    8000503c:	798080e7          	jalr	1944(ra) # 800017d0 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80005040:	00813083          	ld	ra,8(sp)
    80005044:	00013403          	ld	s0,0(sp)
    80005048:	01010113          	addi	sp,sp,16
    8000504c:	00008067          	ret

0000000080005050 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80005050:	ff010113          	addi	sp,sp,-16
    80005054:	00113423          	sd	ra,8(sp)
    80005058:	00813023          	sd	s0,0(sp)
    8000505c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80005060:	ffffd097          	auipc	ra,0xffffd
    80005064:	b24080e7          	jalr	-1244(ra) # 80001b84 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80005068:	00813083          	ld	ra,8(sp)
    8000506c:	00013403          	ld	s0,0(sp)
    80005070:	01010113          	addi	sp,sp,16
    80005074:	00008067          	ret

0000000080005078 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80005078:	fe010113          	addi	sp,sp,-32
    8000507c:	00113c23          	sd	ra,24(sp)
    80005080:	00813823          	sd	s0,16(sp)
    80005084:	02010413          	addi	s0,sp,32
    80005088:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    8000508c:	fe840513          	addi	a0,s0,-24
    80005090:	ffffd097          	auipc	ra,0xffffd
    80005094:	c54080e7          	jalr	-940(ra) # 80001ce4 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80005098:	01813083          	ld	ra,24(sp)
    8000509c:	01013403          	ld	s0,16(sp)
    800050a0:	02010113          	addi	sp,sp,32
    800050a4:	00008067          	ret

00000000800050a8 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    800050a8:	ff010113          	addi	sp,sp,-16
    800050ac:	00113423          	sd	ra,8(sp)
    800050b0:	00813023          	sd	s0,0(sp)
    800050b4:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    800050b8:	ffffc097          	auipc	ra,0xffffc
    800050bc:	248080e7          	jalr	584(ra) # 80001300 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    800050c0:	00813083          	ld	ra,8(sp)
    800050c4:	00013403          	ld	s0,0(sp)
    800050c8:	01010113          	addi	sp,sp,16
    800050cc:	00008067          	ret

00000000800050d0 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    800050d0:	ff010113          	addi	sp,sp,-16
    800050d4:	00113423          	sd	ra,8(sp)
    800050d8:	00813023          	sd	s0,0(sp)
    800050dc:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    800050e0:	ffffc097          	auipc	ra,0xffffc
    800050e4:	074080e7          	jalr	116(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    800050e8:	00813083          	ld	ra,8(sp)
    800050ec:	00013403          	ld	s0,0(sp)
    800050f0:	01010113          	addi	sp,sp,16
    800050f4:	00008067          	ret

00000000800050f8 <_Z7kmallocm>:
void* kmalloc(size_t size){
    800050f8:	ff010113          	addi	sp,sp,-16
    800050fc:	00113423          	sd	ra,8(sp)
    80005100:	00813023          	sd	s0,0(sp)
    80005104:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80005108:	ffffc097          	auipc	ra,0xffffc
    8000510c:	764080e7          	jalr	1892(ra) # 8000186c <_ZN13SlabAllocator14allocateBufferEm>
}
    80005110:	00813083          	ld	ra,8(sp)
    80005114:	00013403          	ld	s0,0(sp)
    80005118:	01010113          	addi	sp,sp,16
    8000511c:	00008067          	ret

0000000080005120 <_Z5kfreePKv>:

void kfree(const void* objp){
    80005120:	ff010113          	addi	sp,sp,-16
    80005124:	00113423          	sd	ra,8(sp)
    80005128:	00813023          	sd	s0,0(sp)
    8000512c:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80005130:	ffffd097          	auipc	ra,0xffffd
    80005134:	b48080e7          	jalr	-1208(ra) # 80001c78 <_ZN13SlabAllocator10freeBufferEPKv>
    80005138:	00813083          	ld	ra,8(sp)
    8000513c:	00013403          	ld	s0,0(sp)
    80005140:	01010113          	addi	sp,sp,16
    80005144:	00008067          	ret

0000000080005148 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005148:	fd010113          	addi	sp,sp,-48
    8000514c:	02113423          	sd	ra,40(sp)
    80005150:	02813023          	sd	s0,32(sp)
    80005154:	00913c23          	sd	s1,24(sp)
    80005158:	01213823          	sd	s2,16(sp)
    8000515c:	01313423          	sd	s3,8(sp)
    80005160:	03010413          	addi	s0,sp,48
    80005164:	00050493          	mv	s1,a0
    80005168:	00058913          	mv	s2,a1
    8000516c:	0015879b          	addiw	a5,a1,1
    80005170:	0007851b          	sext.w	a0,a5
    80005174:	00f4a023          	sw	a5,0(s1)
    80005178:	0004a823          	sw	zero,16(s1)
    8000517c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005180:	00251513          	slli	a0,a0,0x2
    80005184:	ffffd097          	auipc	ra,0xffffd
    80005188:	c3c080e7          	jalr	-964(ra) # 80001dc0 <_Z9mem_allocm>
    8000518c:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80005190:	01000513          	li	a0,16
    80005194:	ffffe097          	auipc	ra,0xffffe
    80005198:	3f0080e7          	jalr	1008(ra) # 80003584 <_Znwm>
    8000519c:	00050993          	mv	s3,a0
    800051a0:	00000593          	li	a1,0
    800051a4:	ffffe097          	auipc	ra,0xffffe
    800051a8:	4d8080e7          	jalr	1240(ra) # 8000367c <_ZN9SemaphoreC1Ej>
    800051ac:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800051b0:	01000513          	li	a0,16
    800051b4:	ffffe097          	auipc	ra,0xffffe
    800051b8:	3d0080e7          	jalr	976(ra) # 80003584 <_Znwm>
    800051bc:	00050993          	mv	s3,a0
    800051c0:	00090593          	mv	a1,s2
    800051c4:	ffffe097          	auipc	ra,0xffffe
    800051c8:	4b8080e7          	jalr	1208(ra) # 8000367c <_ZN9SemaphoreC1Ej>
    800051cc:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800051d0:	01000513          	li	a0,16
    800051d4:	ffffe097          	auipc	ra,0xffffe
    800051d8:	3b0080e7          	jalr	944(ra) # 80003584 <_Znwm>
    800051dc:	00050913          	mv	s2,a0
    800051e0:	00100593          	li	a1,1
    800051e4:	ffffe097          	auipc	ra,0xffffe
    800051e8:	498080e7          	jalr	1176(ra) # 8000367c <_ZN9SemaphoreC1Ej>
    800051ec:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800051f0:	01000513          	li	a0,16
    800051f4:	ffffe097          	auipc	ra,0xffffe
    800051f8:	390080e7          	jalr	912(ra) # 80003584 <_Znwm>
    800051fc:	00050913          	mv	s2,a0
    80005200:	00100593          	li	a1,1
    80005204:	ffffe097          	auipc	ra,0xffffe
    80005208:	478080e7          	jalr	1144(ra) # 8000367c <_ZN9SemaphoreC1Ej>
    8000520c:	0324b823          	sd	s2,48(s1)
}
    80005210:	02813083          	ld	ra,40(sp)
    80005214:	02013403          	ld	s0,32(sp)
    80005218:	01813483          	ld	s1,24(sp)
    8000521c:	01013903          	ld	s2,16(sp)
    80005220:	00813983          	ld	s3,8(sp)
    80005224:	03010113          	addi	sp,sp,48
    80005228:	00008067          	ret
    8000522c:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005230:	00098513          	mv	a0,s3
    80005234:	ffffe097          	auipc	ra,0xffffe
    80005238:	3a0080e7          	jalr	928(ra) # 800035d4 <_ZdlPv>
    8000523c:	00048513          	mv	a0,s1
    80005240:	00008097          	auipc	ra,0x8
    80005244:	e28080e7          	jalr	-472(ra) # 8000d068 <_Unwind_Resume>
    80005248:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000524c:	00098513          	mv	a0,s3
    80005250:	ffffe097          	auipc	ra,0xffffe
    80005254:	384080e7          	jalr	900(ra) # 800035d4 <_ZdlPv>
    80005258:	00048513          	mv	a0,s1
    8000525c:	00008097          	auipc	ra,0x8
    80005260:	e0c080e7          	jalr	-500(ra) # 8000d068 <_Unwind_Resume>
    80005264:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80005268:	00090513          	mv	a0,s2
    8000526c:	ffffe097          	auipc	ra,0xffffe
    80005270:	368080e7          	jalr	872(ra) # 800035d4 <_ZdlPv>
    80005274:	00048513          	mv	a0,s1
    80005278:	00008097          	auipc	ra,0x8
    8000527c:	df0080e7          	jalr	-528(ra) # 8000d068 <_Unwind_Resume>
    80005280:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005284:	00090513          	mv	a0,s2
    80005288:	ffffe097          	auipc	ra,0xffffe
    8000528c:	34c080e7          	jalr	844(ra) # 800035d4 <_ZdlPv>
    80005290:	00048513          	mv	a0,s1
    80005294:	00008097          	auipc	ra,0x8
    80005298:	dd4080e7          	jalr	-556(ra) # 8000d068 <_Unwind_Resume>

000000008000529c <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    8000529c:	fe010113          	addi	sp,sp,-32
    800052a0:	00113c23          	sd	ra,24(sp)
    800052a4:	00813823          	sd	s0,16(sp)
    800052a8:	00913423          	sd	s1,8(sp)
    800052ac:	01213023          	sd	s2,0(sp)
    800052b0:	02010413          	addi	s0,sp,32
    800052b4:	00050493          	mv	s1,a0
    800052b8:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800052bc:	01853503          	ld	a0,24(a0) # 2018 <_entry-0x7fffdfe8>
    800052c0:	ffffe097          	auipc	ra,0xffffe
    800052c4:	3f4080e7          	jalr	1012(ra) # 800036b4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800052c8:	0304b503          	ld	a0,48(s1)
    800052cc:	ffffe097          	auipc	ra,0xffffe
    800052d0:	3e8080e7          	jalr	1000(ra) # 800036b4 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800052d4:	0084b783          	ld	a5,8(s1)
    800052d8:	0144a703          	lw	a4,20(s1)
    800052dc:	00271713          	slli	a4,a4,0x2
    800052e0:	00e787b3          	add	a5,a5,a4
    800052e4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800052e8:	0144a783          	lw	a5,20(s1)
    800052ec:	0017879b          	addiw	a5,a5,1
    800052f0:	0004a703          	lw	a4,0(s1)
    800052f4:	02e7e7bb          	remw	a5,a5,a4
    800052f8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800052fc:	0304b503          	ld	a0,48(s1)
    80005300:	ffffe097          	auipc	ra,0xffffe
    80005304:	3e0080e7          	jalr	992(ra) # 800036e0 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80005308:	0204b503          	ld	a0,32(s1)
    8000530c:	ffffe097          	auipc	ra,0xffffe
    80005310:	3d4080e7          	jalr	980(ra) # 800036e0 <_ZN9Semaphore6signalEv>

}
    80005314:	01813083          	ld	ra,24(sp)
    80005318:	01013403          	ld	s0,16(sp)
    8000531c:	00813483          	ld	s1,8(sp)
    80005320:	00013903          	ld	s2,0(sp)
    80005324:	02010113          	addi	sp,sp,32
    80005328:	00008067          	ret

000000008000532c <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    8000532c:	fe010113          	addi	sp,sp,-32
    80005330:	00113c23          	sd	ra,24(sp)
    80005334:	00813823          	sd	s0,16(sp)
    80005338:	00913423          	sd	s1,8(sp)
    8000533c:	01213023          	sd	s2,0(sp)
    80005340:	02010413          	addi	s0,sp,32
    80005344:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005348:	02053503          	ld	a0,32(a0)
    8000534c:	ffffe097          	auipc	ra,0xffffe
    80005350:	368080e7          	jalr	872(ra) # 800036b4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005354:	0284b503          	ld	a0,40(s1)
    80005358:	ffffe097          	auipc	ra,0xffffe
    8000535c:	35c080e7          	jalr	860(ra) # 800036b4 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80005360:	0084b703          	ld	a4,8(s1)
    80005364:	0104a783          	lw	a5,16(s1)
    80005368:	00279693          	slli	a3,a5,0x2
    8000536c:	00d70733          	add	a4,a4,a3
    80005370:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005374:	0017879b          	addiw	a5,a5,1
    80005378:	0004a703          	lw	a4,0(s1)
    8000537c:	02e7e7bb          	remw	a5,a5,a4
    80005380:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005384:	0284b503          	ld	a0,40(s1)
    80005388:	ffffe097          	auipc	ra,0xffffe
    8000538c:	358080e7          	jalr	856(ra) # 800036e0 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80005390:	0184b503          	ld	a0,24(s1)
    80005394:	ffffe097          	auipc	ra,0xffffe
    80005398:	34c080e7          	jalr	844(ra) # 800036e0 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000539c:	00090513          	mv	a0,s2
    800053a0:	01813083          	ld	ra,24(sp)
    800053a4:	01013403          	ld	s0,16(sp)
    800053a8:	00813483          	ld	s1,8(sp)
    800053ac:	00013903          	ld	s2,0(sp)
    800053b0:	02010113          	addi	sp,sp,32
    800053b4:	00008067          	ret

00000000800053b8 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800053b8:	fe010113          	addi	sp,sp,-32
    800053bc:	00113c23          	sd	ra,24(sp)
    800053c0:	00813823          	sd	s0,16(sp)
    800053c4:	00913423          	sd	s1,8(sp)
    800053c8:	01213023          	sd	s2,0(sp)
    800053cc:	02010413          	addi	s0,sp,32
    800053d0:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800053d4:	02853503          	ld	a0,40(a0)
    800053d8:	ffffe097          	auipc	ra,0xffffe
    800053dc:	2dc080e7          	jalr	732(ra) # 800036b4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800053e0:	0304b503          	ld	a0,48(s1)
    800053e4:	ffffe097          	auipc	ra,0xffffe
    800053e8:	2d0080e7          	jalr	720(ra) # 800036b4 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800053ec:	0144a783          	lw	a5,20(s1)
    800053f0:	0104a903          	lw	s2,16(s1)
    800053f4:	0327ce63          	blt	a5,s2,80005430 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800053f8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800053fc:	0304b503          	ld	a0,48(s1)
    80005400:	ffffe097          	auipc	ra,0xffffe
    80005404:	2e0080e7          	jalr	736(ra) # 800036e0 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005408:	0284b503          	ld	a0,40(s1)
    8000540c:	ffffe097          	auipc	ra,0xffffe
    80005410:	2d4080e7          	jalr	724(ra) # 800036e0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005414:	00090513          	mv	a0,s2
    80005418:	01813083          	ld	ra,24(sp)
    8000541c:	01013403          	ld	s0,16(sp)
    80005420:	00813483          	ld	s1,8(sp)
    80005424:	00013903          	ld	s2,0(sp)
    80005428:	02010113          	addi	sp,sp,32
    8000542c:	00008067          	ret
        ret = cap - head + tail;
    80005430:	0004a703          	lw	a4,0(s1)
    80005434:	4127093b          	subw	s2,a4,s2
    80005438:	00f9093b          	addw	s2,s2,a5
    8000543c:	fc1ff06f          	j	800053fc <_ZN9BufferCPP6getCntEv+0x44>

0000000080005440 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005440:	fe010113          	addi	sp,sp,-32
    80005444:	00113c23          	sd	ra,24(sp)
    80005448:	00813823          	sd	s0,16(sp)
    8000544c:	00913423          	sd	s1,8(sp)
    80005450:	02010413          	addi	s0,sp,32
    80005454:	00050493          	mv	s1,a0
    Console::putc('\n');
    80005458:	00a00513          	li	a0,10
    8000545c:	ffffe097          	auipc	ra,0xffffe
    80005460:	480080e7          	jalr	1152(ra) # 800038dc <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005464:	00004517          	auipc	a0,0x4
    80005468:	10c50513          	addi	a0,a0,268 # 80009570 <CONSOLE_STATUS+0x560>
    8000546c:	ffffd097          	auipc	ra,0xffffd
    80005470:	344080e7          	jalr	836(ra) # 800027b0 <_Z11printStringPKc>
    while (getCnt()) {
    80005474:	00048513          	mv	a0,s1
    80005478:	00000097          	auipc	ra,0x0
    8000547c:	f40080e7          	jalr	-192(ra) # 800053b8 <_ZN9BufferCPP6getCntEv>
    80005480:	02050c63          	beqz	a0,800054b8 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005484:	0084b783          	ld	a5,8(s1)
    80005488:	0104a703          	lw	a4,16(s1)
    8000548c:	00271713          	slli	a4,a4,0x2
    80005490:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005494:	0007c503          	lbu	a0,0(a5)
    80005498:	ffffe097          	auipc	ra,0xffffe
    8000549c:	444080e7          	jalr	1092(ra) # 800038dc <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800054a0:	0104a783          	lw	a5,16(s1)
    800054a4:	0017879b          	addiw	a5,a5,1
    800054a8:	0004a703          	lw	a4,0(s1)
    800054ac:	02e7e7bb          	remw	a5,a5,a4
    800054b0:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800054b4:	fc1ff06f          	j	80005474 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800054b8:	02100513          	li	a0,33
    800054bc:	ffffe097          	auipc	ra,0xffffe
    800054c0:	420080e7          	jalr	1056(ra) # 800038dc <_ZN7Console4putcEc>
    Console::putc('\n');
    800054c4:	00a00513          	li	a0,10
    800054c8:	ffffe097          	auipc	ra,0xffffe
    800054cc:	414080e7          	jalr	1044(ra) # 800038dc <_ZN7Console4putcEc>
    mem_free(buffer);
    800054d0:	0084b503          	ld	a0,8(s1)
    800054d4:	ffffd097          	auipc	ra,0xffffd
    800054d8:	91c080e7          	jalr	-1764(ra) # 80001df0 <_Z8mem_freePv>
    delete itemAvailable;
    800054dc:	0204b503          	ld	a0,32(s1)
    800054e0:	00050863          	beqz	a0,800054f0 <_ZN9BufferCPPD1Ev+0xb0>
    800054e4:	00053783          	ld	a5,0(a0)
    800054e8:	0087b783          	ld	a5,8(a5)
    800054ec:	000780e7          	jalr	a5
    delete spaceAvailable;
    800054f0:	0184b503          	ld	a0,24(s1)
    800054f4:	00050863          	beqz	a0,80005504 <_ZN9BufferCPPD1Ev+0xc4>
    800054f8:	00053783          	ld	a5,0(a0)
    800054fc:	0087b783          	ld	a5,8(a5)
    80005500:	000780e7          	jalr	a5
    delete mutexTail;
    80005504:	0304b503          	ld	a0,48(s1)
    80005508:	00050863          	beqz	a0,80005518 <_ZN9BufferCPPD1Ev+0xd8>
    8000550c:	00053783          	ld	a5,0(a0)
    80005510:	0087b783          	ld	a5,8(a5)
    80005514:	000780e7          	jalr	a5
    delete mutexHead;
    80005518:	0284b503          	ld	a0,40(s1)
    8000551c:	00050863          	beqz	a0,8000552c <_ZN9BufferCPPD1Ev+0xec>
    80005520:	00053783          	ld	a5,0(a0)
    80005524:	0087b783          	ld	a5,8(a5)
    80005528:	000780e7          	jalr	a5
}
    8000552c:	01813083          	ld	ra,24(sp)
    80005530:	01013403          	ld	s0,16(sp)
    80005534:	00813483          	ld	s1,8(sp)
    80005538:	02010113          	addi	sp,sp,32
    8000553c:	00008067          	ret

0000000080005540 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    80005540:	fe010113          	addi	sp,sp,-32
    80005544:	00113c23          	sd	ra,24(sp)
    80005548:	00813823          	sd	s0,16(sp)
    8000554c:	00913423          	sd	s1,8(sp)
    80005550:	01213023          	sd	s2,0(sp)
    80005554:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005558:	00000913          	li	s2,0
    8000555c:	0380006f          	j	80005594 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005560:	ffffd097          	auipc	ra,0xffffd
    80005564:	960080e7          	jalr	-1696(ra) # 80001ec0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005568:	00148493          	addi	s1,s1,1
    8000556c:	000027b7          	lui	a5,0x2
    80005570:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005574:	0097ee63          	bltu	a5,s1,80005590 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005578:	00000713          	li	a4,0
    8000557c:	000077b7          	lui	a5,0x7
    80005580:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005584:	fce7eee3          	bltu	a5,a4,80005560 <_Z11workerBodyAPv+0x20>
    80005588:	00170713          	addi	a4,a4,1
    8000558c:	ff1ff06f          	j	8000557c <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005590:	00190913          	addi	s2,s2,1
    80005594:	00900793          	li	a5,9
    80005598:	0527e063          	bltu	a5,s2,800055d8 <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000559c:	00004517          	auipc	a0,0x4
    800055a0:	fec50513          	addi	a0,a0,-20 # 80009588 <CONSOLE_STATUS+0x578>
    800055a4:	ffffd097          	auipc	ra,0xffffd
    800055a8:	20c080e7          	jalr	524(ra) # 800027b0 <_Z11printStringPKc>
    800055ac:	00000613          	li	a2,0
    800055b0:	00a00593          	li	a1,10
    800055b4:	0009051b          	sext.w	a0,s2
    800055b8:	ffffd097          	auipc	ra,0xffffd
    800055bc:	390080e7          	jalr	912(ra) # 80002948 <_Z8printIntiii>
    800055c0:	00004517          	auipc	a0,0x4
    800055c4:	da050513          	addi	a0,a0,-608 # 80009360 <CONSOLE_STATUS+0x350>
    800055c8:	ffffd097          	auipc	ra,0xffffd
    800055cc:	1e8080e7          	jalr	488(ra) # 800027b0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800055d0:	00000493          	li	s1,0
    800055d4:	f99ff06f          	j	8000556c <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    800055d8:	00004517          	auipc	a0,0x4
    800055dc:	fb850513          	addi	a0,a0,-72 # 80009590 <CONSOLE_STATUS+0x580>
    800055e0:	ffffd097          	auipc	ra,0xffffd
    800055e4:	1d0080e7          	jalr	464(ra) # 800027b0 <_Z11printStringPKc>
    finishedA = true;
    800055e8:	00100793          	li	a5,1
    800055ec:	00007717          	auipc	a4,0x7
    800055f0:	98f70e23          	sb	a5,-1636(a4) # 8000bf88 <finishedA>
}
    800055f4:	01813083          	ld	ra,24(sp)
    800055f8:	01013403          	ld	s0,16(sp)
    800055fc:	00813483          	ld	s1,8(sp)
    80005600:	00013903          	ld	s2,0(sp)
    80005604:	02010113          	addi	sp,sp,32
    80005608:	00008067          	ret

000000008000560c <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    8000560c:	fe010113          	addi	sp,sp,-32
    80005610:	00113c23          	sd	ra,24(sp)
    80005614:	00813823          	sd	s0,16(sp)
    80005618:	00913423          	sd	s1,8(sp)
    8000561c:	01213023          	sd	s2,0(sp)
    80005620:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005624:	00000913          	li	s2,0
    80005628:	0380006f          	j	80005660 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000562c:	ffffd097          	auipc	ra,0xffffd
    80005630:	894080e7          	jalr	-1900(ra) # 80001ec0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005634:	00148493          	addi	s1,s1,1
    80005638:	000027b7          	lui	a5,0x2
    8000563c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005640:	0097ee63          	bltu	a5,s1,8000565c <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005644:	00000713          	li	a4,0
    80005648:	000077b7          	lui	a5,0x7
    8000564c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005650:	fce7eee3          	bltu	a5,a4,8000562c <_Z11workerBodyBPv+0x20>
    80005654:	00170713          	addi	a4,a4,1
    80005658:	ff1ff06f          	j	80005648 <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000565c:	00190913          	addi	s2,s2,1
    80005660:	00f00793          	li	a5,15
    80005664:	0527e063          	bltu	a5,s2,800056a4 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005668:	00004517          	auipc	a0,0x4
    8000566c:	f3850513          	addi	a0,a0,-200 # 800095a0 <CONSOLE_STATUS+0x590>
    80005670:	ffffd097          	auipc	ra,0xffffd
    80005674:	140080e7          	jalr	320(ra) # 800027b0 <_Z11printStringPKc>
    80005678:	00000613          	li	a2,0
    8000567c:	00a00593          	li	a1,10
    80005680:	0009051b          	sext.w	a0,s2
    80005684:	ffffd097          	auipc	ra,0xffffd
    80005688:	2c4080e7          	jalr	708(ra) # 80002948 <_Z8printIntiii>
    8000568c:	00004517          	auipc	a0,0x4
    80005690:	cd450513          	addi	a0,a0,-812 # 80009360 <CONSOLE_STATUS+0x350>
    80005694:	ffffd097          	auipc	ra,0xffffd
    80005698:	11c080e7          	jalr	284(ra) # 800027b0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000569c:	00000493          	li	s1,0
    800056a0:	f99ff06f          	j	80005638 <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    800056a4:	00004517          	auipc	a0,0x4
    800056a8:	f0450513          	addi	a0,a0,-252 # 800095a8 <CONSOLE_STATUS+0x598>
    800056ac:	ffffd097          	auipc	ra,0xffffd
    800056b0:	104080e7          	jalr	260(ra) # 800027b0 <_Z11printStringPKc>
    finishedB = true;
    800056b4:	00100793          	li	a5,1
    800056b8:	00007717          	auipc	a4,0x7
    800056bc:	8cf708a3          	sb	a5,-1839(a4) # 8000bf89 <finishedB>
    thread_dispatch();
    800056c0:	ffffd097          	auipc	ra,0xffffd
    800056c4:	800080e7          	jalr	-2048(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    800056c8:	01813083          	ld	ra,24(sp)
    800056cc:	01013403          	ld	s0,16(sp)
    800056d0:	00813483          	ld	s1,8(sp)
    800056d4:	00013903          	ld	s2,0(sp)
    800056d8:	02010113          	addi	sp,sp,32
    800056dc:	00008067          	ret

00000000800056e0 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    800056e0:	fe010113          	addi	sp,sp,-32
    800056e4:	00113c23          	sd	ra,24(sp)
    800056e8:	00813823          	sd	s0,16(sp)
    800056ec:	00913423          	sd	s1,8(sp)
    800056f0:	01213023          	sd	s2,0(sp)
    800056f4:	02010413          	addi	s0,sp,32
    800056f8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800056fc:	00100793          	li	a5,1
    80005700:	02a7f863          	bgeu	a5,a0,80005730 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80005704:	00a00793          	li	a5,10
    80005708:	02f577b3          	remu	a5,a0,a5
    8000570c:	02078e63          	beqz	a5,80005748 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005710:	fff48513          	addi	a0,s1,-1
    80005714:	00000097          	auipc	ra,0x0
    80005718:	fcc080e7          	jalr	-52(ra) # 800056e0 <_Z9fibonaccim>
    8000571c:	00050913          	mv	s2,a0
    80005720:	ffe48513          	addi	a0,s1,-2
    80005724:	00000097          	auipc	ra,0x0
    80005728:	fbc080e7          	jalr	-68(ra) # 800056e0 <_Z9fibonaccim>
    8000572c:	00a90533          	add	a0,s2,a0
}
    80005730:	01813083          	ld	ra,24(sp)
    80005734:	01013403          	ld	s0,16(sp)
    80005738:	00813483          	ld	s1,8(sp)
    8000573c:	00013903          	ld	s2,0(sp)
    80005740:	02010113          	addi	sp,sp,32
    80005744:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005748:	ffffc097          	auipc	ra,0xffffc
    8000574c:	778080e7          	jalr	1912(ra) # 80001ec0 <_Z15thread_dispatchv>
    80005750:	fc1ff06f          	j	80005710 <_Z9fibonaccim+0x30>

0000000080005754 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    80005754:	fe010113          	addi	sp,sp,-32
    80005758:	00113c23          	sd	ra,24(sp)
    8000575c:	00813823          	sd	s0,16(sp)
    80005760:	00913423          	sd	s1,8(sp)
    80005764:	01213023          	sd	s2,0(sp)
    80005768:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000576c:	00000493          	li	s1,0
    80005770:	0400006f          	j	800057b0 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005774:	00004517          	auipc	a0,0x4
    80005778:	e4450513          	addi	a0,a0,-444 # 800095b8 <CONSOLE_STATUS+0x5a8>
    8000577c:	ffffd097          	auipc	ra,0xffffd
    80005780:	034080e7          	jalr	52(ra) # 800027b0 <_Z11printStringPKc>
    80005784:	00000613          	li	a2,0
    80005788:	00a00593          	li	a1,10
    8000578c:	00048513          	mv	a0,s1
    80005790:	ffffd097          	auipc	ra,0xffffd
    80005794:	1b8080e7          	jalr	440(ra) # 80002948 <_Z8printIntiii>
    80005798:	00004517          	auipc	a0,0x4
    8000579c:	bc850513          	addi	a0,a0,-1080 # 80009360 <CONSOLE_STATUS+0x350>
    800057a0:	ffffd097          	auipc	ra,0xffffd
    800057a4:	010080e7          	jalr	16(ra) # 800027b0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800057a8:	0014849b          	addiw	s1,s1,1
    800057ac:	0ff4f493          	andi	s1,s1,255
    800057b0:	00200793          	li	a5,2
    800057b4:	fc97f0e3          	bgeu	a5,s1,80005774 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    800057b8:	00004517          	auipc	a0,0x4
    800057bc:	e0850513          	addi	a0,a0,-504 # 800095c0 <CONSOLE_STATUS+0x5b0>
    800057c0:	ffffd097          	auipc	ra,0xffffd
    800057c4:	ff0080e7          	jalr	-16(ra) # 800027b0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800057c8:	00700313          	li	t1,7
    thread_dispatch();
    800057cc:	ffffc097          	auipc	ra,0xffffc
    800057d0:	6f4080e7          	jalr	1780(ra) # 80001ec0 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800057d4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800057d8:	00004517          	auipc	a0,0x4
    800057dc:	df850513          	addi	a0,a0,-520 # 800095d0 <CONSOLE_STATUS+0x5c0>
    800057e0:	ffffd097          	auipc	ra,0xffffd
    800057e4:	fd0080e7          	jalr	-48(ra) # 800027b0 <_Z11printStringPKc>
    800057e8:	00000613          	li	a2,0
    800057ec:	00a00593          	li	a1,10
    800057f0:	0009051b          	sext.w	a0,s2
    800057f4:	ffffd097          	auipc	ra,0xffffd
    800057f8:	154080e7          	jalr	340(ra) # 80002948 <_Z8printIntiii>
    800057fc:	00004517          	auipc	a0,0x4
    80005800:	b6450513          	addi	a0,a0,-1180 # 80009360 <CONSOLE_STATUS+0x350>
    80005804:	ffffd097          	auipc	ra,0xffffd
    80005808:	fac080e7          	jalr	-84(ra) # 800027b0 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000580c:	00c00513          	li	a0,12
    80005810:	00000097          	auipc	ra,0x0
    80005814:	ed0080e7          	jalr	-304(ra) # 800056e0 <_Z9fibonaccim>
    80005818:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000581c:	00004517          	auipc	a0,0x4
    80005820:	dbc50513          	addi	a0,a0,-580 # 800095d8 <CONSOLE_STATUS+0x5c8>
    80005824:	ffffd097          	auipc	ra,0xffffd
    80005828:	f8c080e7          	jalr	-116(ra) # 800027b0 <_Z11printStringPKc>
    8000582c:	00000613          	li	a2,0
    80005830:	00a00593          	li	a1,10
    80005834:	0009051b          	sext.w	a0,s2
    80005838:	ffffd097          	auipc	ra,0xffffd
    8000583c:	110080e7          	jalr	272(ra) # 80002948 <_Z8printIntiii>
    80005840:	00004517          	auipc	a0,0x4
    80005844:	b2050513          	addi	a0,a0,-1248 # 80009360 <CONSOLE_STATUS+0x350>
    80005848:	ffffd097          	auipc	ra,0xffffd
    8000584c:	f68080e7          	jalr	-152(ra) # 800027b0 <_Z11printStringPKc>
    80005850:	0400006f          	j	80005890 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80005854:	00004517          	auipc	a0,0x4
    80005858:	d6450513          	addi	a0,a0,-668 # 800095b8 <CONSOLE_STATUS+0x5a8>
    8000585c:	ffffd097          	auipc	ra,0xffffd
    80005860:	f54080e7          	jalr	-172(ra) # 800027b0 <_Z11printStringPKc>
    80005864:	00000613          	li	a2,0
    80005868:	00a00593          	li	a1,10
    8000586c:	00048513          	mv	a0,s1
    80005870:	ffffd097          	auipc	ra,0xffffd
    80005874:	0d8080e7          	jalr	216(ra) # 80002948 <_Z8printIntiii>
    80005878:	00004517          	auipc	a0,0x4
    8000587c:	ae850513          	addi	a0,a0,-1304 # 80009360 <CONSOLE_STATUS+0x350>
    80005880:	ffffd097          	auipc	ra,0xffffd
    80005884:	f30080e7          	jalr	-208(ra) # 800027b0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005888:	0014849b          	addiw	s1,s1,1
    8000588c:	0ff4f493          	andi	s1,s1,255
    80005890:	00500793          	li	a5,5
    80005894:	fc97f0e3          	bgeu	a5,s1,80005854 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    80005898:	00004517          	auipc	a0,0x4
    8000589c:	cf850513          	addi	a0,a0,-776 # 80009590 <CONSOLE_STATUS+0x580>
    800058a0:	ffffd097          	auipc	ra,0xffffd
    800058a4:	f10080e7          	jalr	-240(ra) # 800027b0 <_Z11printStringPKc>
    finishedC = true;
    800058a8:	00100793          	li	a5,1
    800058ac:	00006717          	auipc	a4,0x6
    800058b0:	6ef70223          	sb	a5,1764(a4) # 8000bf90 <finishedC>
    thread_dispatch();
    800058b4:	ffffc097          	auipc	ra,0xffffc
    800058b8:	60c080e7          	jalr	1548(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    800058bc:	01813083          	ld	ra,24(sp)
    800058c0:	01013403          	ld	s0,16(sp)
    800058c4:	00813483          	ld	s1,8(sp)
    800058c8:	00013903          	ld	s2,0(sp)
    800058cc:	02010113          	addi	sp,sp,32
    800058d0:	00008067          	ret

00000000800058d4 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    800058d4:	fe010113          	addi	sp,sp,-32
    800058d8:	00113c23          	sd	ra,24(sp)
    800058dc:	00813823          	sd	s0,16(sp)
    800058e0:	00913423          	sd	s1,8(sp)
    800058e4:	01213023          	sd	s2,0(sp)
    800058e8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800058ec:	00a00493          	li	s1,10
    800058f0:	0400006f          	j	80005930 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800058f4:	00004517          	auipc	a0,0x4
    800058f8:	cf450513          	addi	a0,a0,-780 # 800095e8 <CONSOLE_STATUS+0x5d8>
    800058fc:	ffffd097          	auipc	ra,0xffffd
    80005900:	eb4080e7          	jalr	-332(ra) # 800027b0 <_Z11printStringPKc>
    80005904:	00000613          	li	a2,0
    80005908:	00a00593          	li	a1,10
    8000590c:	00048513          	mv	a0,s1
    80005910:	ffffd097          	auipc	ra,0xffffd
    80005914:	038080e7          	jalr	56(ra) # 80002948 <_Z8printIntiii>
    80005918:	00004517          	auipc	a0,0x4
    8000591c:	a4850513          	addi	a0,a0,-1464 # 80009360 <CONSOLE_STATUS+0x350>
    80005920:	ffffd097          	auipc	ra,0xffffd
    80005924:	e90080e7          	jalr	-368(ra) # 800027b0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80005928:	0014849b          	addiw	s1,s1,1
    8000592c:	0ff4f493          	andi	s1,s1,255
    80005930:	00c00793          	li	a5,12
    80005934:	fc97f0e3          	bgeu	a5,s1,800058f4 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80005938:	00004517          	auipc	a0,0x4
    8000593c:	cb850513          	addi	a0,a0,-840 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80005940:	ffffd097          	auipc	ra,0xffffd
    80005944:	e70080e7          	jalr	-400(ra) # 800027b0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005948:	00500313          	li	t1,5
    thread_dispatch();
    8000594c:	ffffc097          	auipc	ra,0xffffc
    80005950:	574080e7          	jalr	1396(ra) # 80001ec0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80005954:	01000513          	li	a0,16
    80005958:	00000097          	auipc	ra,0x0
    8000595c:	d88080e7          	jalr	-632(ra) # 800056e0 <_Z9fibonaccim>
    80005960:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80005964:	00004517          	auipc	a0,0x4
    80005968:	c9c50513          	addi	a0,a0,-868 # 80009600 <CONSOLE_STATUS+0x5f0>
    8000596c:	ffffd097          	auipc	ra,0xffffd
    80005970:	e44080e7          	jalr	-444(ra) # 800027b0 <_Z11printStringPKc>
    80005974:	00000613          	li	a2,0
    80005978:	00a00593          	li	a1,10
    8000597c:	0009051b          	sext.w	a0,s2
    80005980:	ffffd097          	auipc	ra,0xffffd
    80005984:	fc8080e7          	jalr	-56(ra) # 80002948 <_Z8printIntiii>
    80005988:	00004517          	auipc	a0,0x4
    8000598c:	9d850513          	addi	a0,a0,-1576 # 80009360 <CONSOLE_STATUS+0x350>
    80005990:	ffffd097          	auipc	ra,0xffffd
    80005994:	e20080e7          	jalr	-480(ra) # 800027b0 <_Z11printStringPKc>
    80005998:	0400006f          	j	800059d8 <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000599c:	00004517          	auipc	a0,0x4
    800059a0:	c4c50513          	addi	a0,a0,-948 # 800095e8 <CONSOLE_STATUS+0x5d8>
    800059a4:	ffffd097          	auipc	ra,0xffffd
    800059a8:	e0c080e7          	jalr	-500(ra) # 800027b0 <_Z11printStringPKc>
    800059ac:	00000613          	li	a2,0
    800059b0:	00a00593          	li	a1,10
    800059b4:	00048513          	mv	a0,s1
    800059b8:	ffffd097          	auipc	ra,0xffffd
    800059bc:	f90080e7          	jalr	-112(ra) # 80002948 <_Z8printIntiii>
    800059c0:	00004517          	auipc	a0,0x4
    800059c4:	9a050513          	addi	a0,a0,-1632 # 80009360 <CONSOLE_STATUS+0x350>
    800059c8:	ffffd097          	auipc	ra,0xffffd
    800059cc:	de8080e7          	jalr	-536(ra) # 800027b0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800059d0:	0014849b          	addiw	s1,s1,1
    800059d4:	0ff4f493          	andi	s1,s1,255
    800059d8:	00f00793          	li	a5,15
    800059dc:	fc97f0e3          	bgeu	a5,s1,8000599c <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800059e0:	00004517          	auipc	a0,0x4
    800059e4:	c3050513          	addi	a0,a0,-976 # 80009610 <CONSOLE_STATUS+0x600>
    800059e8:	ffffd097          	auipc	ra,0xffffd
    800059ec:	dc8080e7          	jalr	-568(ra) # 800027b0 <_Z11printStringPKc>
    finishedD = true;
    800059f0:	00100793          	li	a5,1
    800059f4:	00006717          	auipc	a4,0x6
    800059f8:	58f70ea3          	sb	a5,1437(a4) # 8000bf91 <finishedD>
    thread_dispatch();
    800059fc:	ffffc097          	auipc	ra,0xffffc
    80005a00:	4c4080e7          	jalr	1220(ra) # 80001ec0 <_Z15thread_dispatchv>
}
    80005a04:	01813083          	ld	ra,24(sp)
    80005a08:	01013403          	ld	s0,16(sp)
    80005a0c:	00813483          	ld	s1,8(sp)
    80005a10:	00013903          	ld	s2,0(sp)
    80005a14:	02010113          	addi	sp,sp,32
    80005a18:	00008067          	ret

0000000080005a1c <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005a1c:	fc010113          	addi	sp,sp,-64
    80005a20:	02113c23          	sd	ra,56(sp)
    80005a24:	02813823          	sd	s0,48(sp)
    80005a28:	02913423          	sd	s1,40(sp)
    80005a2c:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005a30:	00000613          	li	a2,0
    80005a34:	00000597          	auipc	a1,0x0
    80005a38:	b0c58593          	addi	a1,a1,-1268 # 80005540 <_Z11workerBodyAPv>
    80005a3c:	fc040513          	addi	a0,s0,-64
    80005a40:	ffffc097          	auipc	ra,0xffffc
    80005a44:	3dc080e7          	jalr	988(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80005a48:	00004517          	auipc	a0,0x4
    80005a4c:	bd850513          	addi	a0,a0,-1064 # 80009620 <CONSOLE_STATUS+0x610>
    80005a50:	ffffd097          	auipc	ra,0xffffd
    80005a54:	d60080e7          	jalr	-672(ra) # 800027b0 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005a58:	00000613          	li	a2,0
    80005a5c:	00000597          	auipc	a1,0x0
    80005a60:	bb058593          	addi	a1,a1,-1104 # 8000560c <_Z11workerBodyBPv>
    80005a64:	fc840513          	addi	a0,s0,-56
    80005a68:	ffffc097          	auipc	ra,0xffffc
    80005a6c:	3b4080e7          	jalr	948(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005a70:	00004517          	auipc	a0,0x4
    80005a74:	bc850513          	addi	a0,a0,-1080 # 80009638 <CONSOLE_STATUS+0x628>
    80005a78:	ffffd097          	auipc	ra,0xffffd
    80005a7c:	d38080e7          	jalr	-712(ra) # 800027b0 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005a80:	00000613          	li	a2,0
    80005a84:	00000597          	auipc	a1,0x0
    80005a88:	cd058593          	addi	a1,a1,-816 # 80005754 <_Z11workerBodyCPv>
    80005a8c:	fd040513          	addi	a0,s0,-48
    80005a90:	ffffc097          	auipc	ra,0xffffc
    80005a94:	38c080e7          	jalr	908(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80005a98:	00004517          	auipc	a0,0x4
    80005a9c:	bb850513          	addi	a0,a0,-1096 # 80009650 <CONSOLE_STATUS+0x640>
    80005aa0:	ffffd097          	auipc	ra,0xffffd
    80005aa4:	d10080e7          	jalr	-752(ra) # 800027b0 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005aa8:	00000613          	li	a2,0
    80005aac:	00000597          	auipc	a1,0x0
    80005ab0:	e2858593          	addi	a1,a1,-472 # 800058d4 <_Z11workerBodyDPv>
    80005ab4:	fd840513          	addi	a0,s0,-40
    80005ab8:	ffffc097          	auipc	ra,0xffffc
    80005abc:	364080e7          	jalr	868(ra) # 80001e1c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80005ac0:	00004517          	auipc	a0,0x4
    80005ac4:	ba850513          	addi	a0,a0,-1112 # 80009668 <CONSOLE_STATUS+0x658>
    80005ac8:	ffffd097          	auipc	ra,0xffffd
    80005acc:	ce8080e7          	jalr	-792(ra) # 800027b0 <_Z11printStringPKc>
    80005ad0:	00c0006f          	j	80005adc <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005ad4:	ffffc097          	auipc	ra,0xffffc
    80005ad8:	3ec080e7          	jalr	1004(ra) # 80001ec0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005adc:	00006797          	auipc	a5,0x6
    80005ae0:	4ac7c783          	lbu	a5,1196(a5) # 8000bf88 <finishedA>
    80005ae4:	fe0788e3          	beqz	a5,80005ad4 <_Z18Threads_C_API_testv+0xb8>
    80005ae8:	00006797          	auipc	a5,0x6
    80005aec:	4a17c783          	lbu	a5,1185(a5) # 8000bf89 <finishedB>
    80005af0:	fe0782e3          	beqz	a5,80005ad4 <_Z18Threads_C_API_testv+0xb8>
    80005af4:	00006797          	auipc	a5,0x6
    80005af8:	49c7c783          	lbu	a5,1180(a5) # 8000bf90 <finishedC>
    80005afc:	fc078ce3          	beqz	a5,80005ad4 <_Z18Threads_C_API_testv+0xb8>
    80005b00:	00006797          	auipc	a5,0x6
    80005b04:	4917c783          	lbu	a5,1169(a5) # 8000bf91 <finishedD>
    80005b08:	fc0786e3          	beqz	a5,80005ad4 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    80005b0c:	fc040493          	addi	s1,s0,-64
    80005b10:	0080006f          	j	80005b18 <_Z18Threads_C_API_testv+0xfc>
    80005b14:	00848493          	addi	s1,s1,8
    80005b18:	fe040793          	addi	a5,s0,-32
    80005b1c:	00f48c63          	beq	s1,a5,80005b34 <_Z18Threads_C_API_testv+0x118>
    80005b20:	0004b503          	ld	a0,0(s1)
    80005b24:	fe0508e3          	beqz	a0,80005b14 <_Z18Threads_C_API_testv+0xf8>
    80005b28:	ffffc097          	auipc	ra,0xffffc
    80005b2c:	5e4080e7          	jalr	1508(ra) # 8000210c <_ZN7_threaddlEPv>
    80005b30:	fe5ff06f          	j	80005b14 <_Z18Threads_C_API_testv+0xf8>
}
    80005b34:	03813083          	ld	ra,56(sp)
    80005b38:	03013403          	ld	s0,48(sp)
    80005b3c:	02813483          	ld	s1,40(sp)
    80005b40:	04010113          	addi	sp,sp,64
    80005b44:	00008067          	ret

0000000080005b48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005b48:	f8010113          	addi	sp,sp,-128
    80005b4c:	06113c23          	sd	ra,120(sp)
    80005b50:	06813823          	sd	s0,112(sp)
    80005b54:	06913423          	sd	s1,104(sp)
    80005b58:	07213023          	sd	s2,96(sp)
    80005b5c:	05313c23          	sd	s3,88(sp)
    80005b60:	05413823          	sd	s4,80(sp)
    80005b64:	05513423          	sd	s5,72(sp)
    80005b68:	05613023          	sd	s6,64(sp)
    80005b6c:	03713c23          	sd	s7,56(sp)
    80005b70:	03813823          	sd	s8,48(sp)
    80005b74:	03913423          	sd	s9,40(sp)
    80005b78:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80005b7c:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    80005b80:	00004517          	auipc	a0,0x4
    80005b84:	b0050513          	addi	a0,a0,-1280 # 80009680 <CONSOLE_STATUS+0x670>
    80005b88:	ffffd097          	auipc	ra,0xffffd
    80005b8c:	c28080e7          	jalr	-984(ra) # 800027b0 <_Z11printStringPKc>
        getString(input, 30);
    80005b90:	01e00593          	li	a1,30
    80005b94:	f8040493          	addi	s1,s0,-128
    80005b98:	00048513          	mv	a0,s1
    80005b9c:	ffffd097          	auipc	ra,0xffffd
    80005ba0:	c90080e7          	jalr	-880(ra) # 8000282c <_Z9getStringPci>
        threadNum = stringToInt(input);
    80005ba4:	00048513          	mv	a0,s1
    80005ba8:	ffffd097          	auipc	ra,0xffffd
    80005bac:	d50080e7          	jalr	-688(ra) # 800028f8 <_Z11stringToIntPKc>
    80005bb0:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    80005bb4:	00004517          	auipc	a0,0x4
    80005bb8:	aec50513          	addi	a0,a0,-1300 # 800096a0 <CONSOLE_STATUS+0x690>
    80005bbc:	ffffd097          	auipc	ra,0xffffd
    80005bc0:	bf4080e7          	jalr	-1036(ra) # 800027b0 <_Z11printStringPKc>
        getString(input, 30);
    80005bc4:	01e00593          	li	a1,30
    80005bc8:	00048513          	mv	a0,s1
    80005bcc:	ffffd097          	auipc	ra,0xffffd
    80005bd0:	c60080e7          	jalr	-928(ra) # 8000282c <_Z9getStringPci>
        n = stringToInt(input);
    80005bd4:	00048513          	mv	a0,s1
    80005bd8:	ffffd097          	auipc	ra,0xffffd
    80005bdc:	d20080e7          	jalr	-736(ra) # 800028f8 <_Z11stringToIntPKc>
    80005be0:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80005be4:	00004517          	auipc	a0,0x4
    80005be8:	adc50513          	addi	a0,a0,-1316 # 800096c0 <CONSOLE_STATUS+0x6b0>
    80005bec:	ffffd097          	auipc	ra,0xffffd
    80005bf0:	bc4080e7          	jalr	-1084(ra) # 800027b0 <_Z11printStringPKc>
    80005bf4:	00000613          	li	a2,0
    80005bf8:	00a00593          	li	a1,10
    80005bfc:	00098513          	mv	a0,s3
    80005c00:	ffffd097          	auipc	ra,0xffffd
    80005c04:	d48080e7          	jalr	-696(ra) # 80002948 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005c08:	00004517          	auipc	a0,0x4
    80005c0c:	ad050513          	addi	a0,a0,-1328 # 800096d8 <CONSOLE_STATUS+0x6c8>
    80005c10:	ffffd097          	auipc	ra,0xffffd
    80005c14:	ba0080e7          	jalr	-1120(ra) # 800027b0 <_Z11printStringPKc>
    80005c18:	00000613          	li	a2,0
    80005c1c:	00a00593          	li	a1,10
    80005c20:	00048513          	mv	a0,s1
    80005c24:	ffffd097          	auipc	ra,0xffffd
    80005c28:	d24080e7          	jalr	-732(ra) # 80002948 <_Z8printIntiii>
        printString(".\n");
    80005c2c:	00003517          	auipc	a0,0x3
    80005c30:	79c50513          	addi	a0,a0,1948 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80005c34:	ffffd097          	auipc	ra,0xffffd
    80005c38:	b7c080e7          	jalr	-1156(ra) # 800027b0 <_Z11printStringPKc>
        if(threadNum > n) {
    80005c3c:	0334c463          	blt	s1,s3,80005c64 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005c40:	03305c63          	blez	s3,80005c78 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005c44:	03800513          	li	a0,56
    80005c48:	ffffe097          	auipc	ra,0xffffe
    80005c4c:	93c080e7          	jalr	-1732(ra) # 80003584 <_Znwm>
    80005c50:	00050a93          	mv	s5,a0
    80005c54:	00048593          	mv	a1,s1
    80005c58:	fffff097          	auipc	ra,0xfffff
    80005c5c:	4f0080e7          	jalr	1264(ra) # 80005148 <_ZN9BufferCPPC1Ei>
    80005c60:	0300006f          	j	80005c90 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005c64:	00004517          	auipc	a0,0x4
    80005c68:	a8c50513          	addi	a0,a0,-1396 # 800096f0 <CONSOLE_STATUS+0x6e0>
    80005c6c:	ffffd097          	auipc	ra,0xffffd
    80005c70:	b44080e7          	jalr	-1212(ra) # 800027b0 <_Z11printStringPKc>
            return;
    80005c74:	0140006f          	j	80005c88 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005c78:	00004517          	auipc	a0,0x4
    80005c7c:	ab850513          	addi	a0,a0,-1352 # 80009730 <CONSOLE_STATUS+0x720>
    80005c80:	ffffd097          	auipc	ra,0xffffd
    80005c84:	b30080e7          	jalr	-1232(ra) # 800027b0 <_Z11printStringPKc>
            return;
    80005c88:	000c0113          	mv	sp,s8
    80005c8c:	21c0006f          	j	80005ea8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    80005c90:	01000513          	li	a0,16
    80005c94:	ffffe097          	auipc	ra,0xffffe
    80005c98:	8f0080e7          	jalr	-1808(ra) # 80003584 <_Znwm>
    80005c9c:	00050493          	mv	s1,a0
    80005ca0:	00000593          	li	a1,0
    80005ca4:	ffffe097          	auipc	ra,0xffffe
    80005ca8:	9d8080e7          	jalr	-1576(ra) # 8000367c <_ZN9SemaphoreC1Ej>
    80005cac:	00006717          	auipc	a4,0x6
    80005cb0:	2dc70713          	addi	a4,a4,732 # 8000bf88 <finishedA>
    80005cb4:	00973823          	sd	s1,16(a4)
        Thread *producers[threadNum];
    80005cb8:	00399793          	slli	a5,s3,0x3
    80005cbc:	00f78793          	addi	a5,a5,15
    80005cc0:	ff07f793          	andi	a5,a5,-16
    80005cc4:	40f10133          	sub	sp,sp,a5
    80005cc8:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80005ccc:	0019869b          	addiw	a3,s3,1
    80005cd0:	00169793          	slli	a5,a3,0x1
    80005cd4:	00d787b3          	add	a5,a5,a3
    80005cd8:	00379793          	slli	a5,a5,0x3
    80005cdc:	00f78793          	addi	a5,a5,15
    80005ce0:	ff07f793          	andi	a5,a5,-16
    80005ce4:	40f10133          	sub	sp,sp,a5
    80005ce8:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80005cec:	00199493          	slli	s1,s3,0x1
    80005cf0:	013484b3          	add	s1,s1,s3
    80005cf4:	00349493          	slli	s1,s1,0x3
    80005cf8:	009b04b3          	add	s1,s6,s1
    80005cfc:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005d00:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005d04:	01073783          	ld	a5,16(a4)
    80005d08:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005d0c:	01800513          	li	a0,24
    80005d10:	ffffe097          	auipc	ra,0xffffe
    80005d14:	874080e7          	jalr	-1932(ra) # 80003584 <_Znwm>
    80005d18:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005d1c:	ffffe097          	auipc	ra,0xffffe
    80005d20:	a28080e7          	jalr	-1496(ra) # 80003744 <_ZN6ThreadC1Ev>
    80005d24:	00006797          	auipc	a5,0x6
    80005d28:	f1478793          	addi	a5,a5,-236 # 8000bc38 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005d2c:	00fbb023          	sd	a5,0(s7)
    80005d30:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005d34:	000b8513          	mv	a0,s7
    80005d38:	ffffe097          	auipc	ra,0xffffe
    80005d3c:	ae0080e7          	jalr	-1312(ra) # 80003818 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005d40:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005d44:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005d48:	00006797          	auipc	a5,0x6
    80005d4c:	2507b783          	ld	a5,592(a5) # 8000bf98 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005d50:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005d54:	01800513          	li	a0,24
    80005d58:	ffffe097          	auipc	ra,0xffffe
    80005d5c:	82c080e7          	jalr	-2004(ra) # 80003584 <_Znwm>
    80005d60:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005d64:	ffffe097          	auipc	ra,0xffffe
    80005d68:	9e0080e7          	jalr	-1568(ra) # 80003744 <_ZN6ThreadC1Ev>
    80005d6c:	00006797          	auipc	a5,0x6
    80005d70:	e7c78793          	addi	a5,a5,-388 # 8000bbe8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005d74:	00f4b023          	sd	a5,0(s1)
    80005d78:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005d7c:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80005d80:	00048513          	mv	a0,s1
    80005d84:	ffffe097          	auipc	ra,0xffffe
    80005d88:	a94080e7          	jalr	-1388(ra) # 80003818 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005d8c:	00100913          	li	s2,1
    80005d90:	0300006f          	j	80005dc0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005d94:	00006797          	auipc	a5,0x6
    80005d98:	e7c78793          	addi	a5,a5,-388 # 8000bc10 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005d9c:	00fcb023          	sd	a5,0(s9)
    80005da0:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80005da4:	00391793          	slli	a5,s2,0x3
    80005da8:	00fa07b3          	add	a5,s4,a5
    80005dac:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80005db0:	000c8513          	mv	a0,s9
    80005db4:	ffffe097          	auipc	ra,0xffffe
    80005db8:	a64080e7          	jalr	-1436(ra) # 80003818 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005dbc:	0019091b          	addiw	s2,s2,1
    80005dc0:	05395263          	bge	s2,s3,80005e04 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80005dc4:	00191493          	slli	s1,s2,0x1
    80005dc8:	012484b3          	add	s1,s1,s2
    80005dcc:	00349493          	slli	s1,s1,0x3
    80005dd0:	009b04b3          	add	s1,s6,s1
    80005dd4:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80005dd8:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80005ddc:	00006797          	auipc	a5,0x6
    80005de0:	1bc7b783          	ld	a5,444(a5) # 8000bf98 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005de4:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80005de8:	01800513          	li	a0,24
    80005dec:	ffffd097          	auipc	ra,0xffffd
    80005df0:	798080e7          	jalr	1944(ra) # 80003584 <_Znwm>
    80005df4:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005df8:	ffffe097          	auipc	ra,0xffffe
    80005dfc:	94c080e7          	jalr	-1716(ra) # 80003744 <_ZN6ThreadC1Ev>
    80005e00:	f95ff06f          	j	80005d94 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80005e04:	ffffe097          	auipc	ra,0xffffe
    80005e08:	9ec080e7          	jalr	-1556(ra) # 800037f0 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    80005e0c:	00000493          	li	s1,0
    80005e10:	0099ce63          	blt	s3,s1,80005e2c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80005e14:	00006517          	auipc	a0,0x6
    80005e18:	18453503          	ld	a0,388(a0) # 8000bf98 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005e1c:	ffffe097          	auipc	ra,0xffffe
    80005e20:	898080e7          	jalr	-1896(ra) # 800036b4 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80005e24:	0014849b          	addiw	s1,s1,1
    80005e28:	fe9ff06f          	j	80005e10 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    80005e2c:	00006517          	auipc	a0,0x6
    80005e30:	16c53503          	ld	a0,364(a0) # 8000bf98 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005e34:	00050863          	beqz	a0,80005e44 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80005e38:	00053783          	ld	a5,0(a0)
    80005e3c:	0087b783          	ld	a5,8(a5)
    80005e40:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    80005e44:	00000493          	li	s1,0
    80005e48:	0080006f          	j	80005e50 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80005e4c:	0014849b          	addiw	s1,s1,1
    80005e50:	0334d263          	bge	s1,s3,80005e74 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80005e54:	00349793          	slli	a5,s1,0x3
    80005e58:	00fa07b3          	add	a5,s4,a5
    80005e5c:	0007b503          	ld	a0,0(a5)
    80005e60:	fe0506e3          	beqz	a0,80005e4c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80005e64:	00053783          	ld	a5,0(a0)
    80005e68:	0087b783          	ld	a5,8(a5)
    80005e6c:	000780e7          	jalr	a5
    80005e70:	fddff06f          	j	80005e4c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    80005e74:	000b8a63          	beqz	s7,80005e88 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    80005e78:	000bb783          	ld	a5,0(s7)
    80005e7c:	0087b783          	ld	a5,8(a5)
    80005e80:	000b8513          	mv	a0,s7
    80005e84:	000780e7          	jalr	a5
        delete buffer;
    80005e88:	000a8e63          	beqz	s5,80005ea4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    80005e8c:	000a8513          	mv	a0,s5
    80005e90:	fffff097          	auipc	ra,0xfffff
    80005e94:	5b0080e7          	jalr	1456(ra) # 80005440 <_ZN9BufferCPPD1Ev>
    80005e98:	000a8513          	mv	a0,s5
    80005e9c:	ffffd097          	auipc	ra,0xffffd
    80005ea0:	738080e7          	jalr	1848(ra) # 800035d4 <_ZdlPv>
    80005ea4:	000c0113          	mv	sp,s8
    }
    80005ea8:	f8040113          	addi	sp,s0,-128
    80005eac:	07813083          	ld	ra,120(sp)
    80005eb0:	07013403          	ld	s0,112(sp)
    80005eb4:	06813483          	ld	s1,104(sp)
    80005eb8:	06013903          	ld	s2,96(sp)
    80005ebc:	05813983          	ld	s3,88(sp)
    80005ec0:	05013a03          	ld	s4,80(sp)
    80005ec4:	04813a83          	ld	s5,72(sp)
    80005ec8:	04013b03          	ld	s6,64(sp)
    80005ecc:	03813b83          	ld	s7,56(sp)
    80005ed0:	03013c03          	ld	s8,48(sp)
    80005ed4:	02813c83          	ld	s9,40(sp)
    80005ed8:	08010113          	addi	sp,sp,128
    80005edc:	00008067          	ret
    80005ee0:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80005ee4:	000a8513          	mv	a0,s5
    80005ee8:	ffffd097          	auipc	ra,0xffffd
    80005eec:	6ec080e7          	jalr	1772(ra) # 800035d4 <_ZdlPv>
    80005ef0:	00048513          	mv	a0,s1
    80005ef4:	00007097          	auipc	ra,0x7
    80005ef8:	174080e7          	jalr	372(ra) # 8000d068 <_Unwind_Resume>
    80005efc:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80005f00:	00048513          	mv	a0,s1
    80005f04:	ffffd097          	auipc	ra,0xffffd
    80005f08:	6d0080e7          	jalr	1744(ra) # 800035d4 <_ZdlPv>
    80005f0c:	00090513          	mv	a0,s2
    80005f10:	00007097          	auipc	ra,0x7
    80005f14:	158080e7          	jalr	344(ra) # 8000d068 <_Unwind_Resume>
    80005f18:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005f1c:	000b8513          	mv	a0,s7
    80005f20:	ffffd097          	auipc	ra,0xffffd
    80005f24:	6b4080e7          	jalr	1716(ra) # 800035d4 <_ZdlPv>
    80005f28:	00048513          	mv	a0,s1
    80005f2c:	00007097          	auipc	ra,0x7
    80005f30:	13c080e7          	jalr	316(ra) # 8000d068 <_Unwind_Resume>
    80005f34:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005f38:	00048513          	mv	a0,s1
    80005f3c:	ffffd097          	auipc	ra,0xffffd
    80005f40:	698080e7          	jalr	1688(ra) # 800035d4 <_ZdlPv>
    80005f44:	00090513          	mv	a0,s2
    80005f48:	00007097          	auipc	ra,0x7
    80005f4c:	120080e7          	jalr	288(ra) # 8000d068 <_Unwind_Resume>
    80005f50:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80005f54:	000c8513          	mv	a0,s9
    80005f58:	ffffd097          	auipc	ra,0xffffd
    80005f5c:	67c080e7          	jalr	1660(ra) # 800035d4 <_ZdlPv>
    80005f60:	00048513          	mv	a0,s1
    80005f64:	00007097          	auipc	ra,0x7
    80005f68:	104080e7          	jalr	260(ra) # 8000d068 <_Unwind_Resume>

0000000080005f6c <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80005f6c:	ff010113          	addi	sp,sp,-16
    80005f70:	00113423          	sd	ra,8(sp)
    80005f74:	00813023          	sd	s0,0(sp)
    80005f78:	01010413          	addi	s0,sp,16
    Threads_C_API_test(); // zadatak 2., niti C API i sinhrona promena konteksta
    80005f7c:	00000097          	auipc	ra,0x0
    80005f80:	aa0080e7          	jalr	-1376(ra) # 80005a1c <_Z18Threads_C_API_testv>

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    80005f84:	00000097          	auipc	ra,0x0
    80005f88:	bc4080e7          	jalr	-1084(ra) # 80005b48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>

    80005f8c:	00813083          	ld	ra,8(sp)
    80005f90:	00013403          	ld	s0,0(sp)
    80005f94:	01010113          	addi	sp,sp,16
    80005f98:	00008067          	ret

0000000080005f9c <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80005f9c:	fd010113          	addi	sp,sp,-48
    80005fa0:	02113423          	sd	ra,40(sp)
    80005fa4:	02813023          	sd	s0,32(sp)
    80005fa8:	00913c23          	sd	s1,24(sp)
    80005fac:	01213823          	sd	s2,16(sp)
    80005fb0:	01313423          	sd	s3,8(sp)
    80005fb4:	03010413          	addi	s0,sp,48
    80005fb8:	00050913          	mv	s2,a0
            int i = 0;
    80005fbc:	00000993          	li	s3,0
    80005fc0:	0100006f          	j	80005fd0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80005fc4:	00a00513          	li	a0,10
    80005fc8:	ffffe097          	auipc	ra,0xffffe
    80005fcc:	914080e7          	jalr	-1772(ra) # 800038dc <_ZN7Console4putcEc>
            while (!threadEnd) {
    80005fd0:	00006797          	auipc	a5,0x6
    80005fd4:	fbc7a783          	lw	a5,-68(a5) # 8000bf8c <_ZN19ConsumerProducerCPP9threadEndE>
    80005fd8:	04079a63          	bnez	a5,8000602c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80005fdc:	01093783          	ld	a5,16(s2)
    80005fe0:	0087b503          	ld	a0,8(a5)
    80005fe4:	fffff097          	auipc	ra,0xfffff
    80005fe8:	348080e7          	jalr	840(ra) # 8000532c <_ZN9BufferCPP3getEv>
                i++;
    80005fec:	0019849b          	addiw	s1,s3,1
    80005ff0:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80005ff4:	0ff57513          	andi	a0,a0,255
    80005ff8:	ffffe097          	auipc	ra,0xffffe
    80005ffc:	8e4080e7          	jalr	-1820(ra) # 800038dc <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80006000:	05000793          	li	a5,80
    80006004:	02f4e4bb          	remw	s1,s1,a5
    80006008:	fc0494e3          	bnez	s1,80005fd0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    8000600c:	fb9ff06f          	j	80005fc4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80006010:	01093783          	ld	a5,16(s2)
    80006014:	0087b503          	ld	a0,8(a5)
    80006018:	fffff097          	auipc	ra,0xfffff
    8000601c:	314080e7          	jalr	788(ra) # 8000532c <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80006020:	0ff57513          	andi	a0,a0,255
    80006024:	ffffe097          	auipc	ra,0xffffe
    80006028:	8b8080e7          	jalr	-1864(ra) # 800038dc <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8000602c:	01093783          	ld	a5,16(s2)
    80006030:	0087b503          	ld	a0,8(a5)
    80006034:	fffff097          	auipc	ra,0xfffff
    80006038:	384080e7          	jalr	900(ra) # 800053b8 <_ZN9BufferCPP6getCntEv>
    8000603c:	fca04ae3          	bgtz	a0,80006010 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80006040:	01093783          	ld	a5,16(s2)
    80006044:	0107b503          	ld	a0,16(a5)
    80006048:	ffffd097          	auipc	ra,0xffffd
    8000604c:	698080e7          	jalr	1688(ra) # 800036e0 <_ZN9Semaphore6signalEv>
        }
    80006050:	02813083          	ld	ra,40(sp)
    80006054:	02013403          	ld	s0,32(sp)
    80006058:	01813483          	ld	s1,24(sp)
    8000605c:	01013903          	ld	s2,16(sp)
    80006060:	00813983          	ld	s3,8(sp)
    80006064:	03010113          	addi	sp,sp,48
    80006068:	00008067          	ret

000000008000606c <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8000606c:	ff010113          	addi	sp,sp,-16
    80006070:	00113423          	sd	ra,8(sp)
    80006074:	00813023          	sd	s0,0(sp)
    80006078:	01010413          	addi	s0,sp,16
    8000607c:	00006797          	auipc	a5,0x6
    80006080:	bbc78793          	addi	a5,a5,-1092 # 8000bc38 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006084:	00f53023          	sd	a5,0(a0)
    80006088:	ffffd097          	auipc	ra,0xffffd
    8000608c:	4bc080e7          	jalr	1212(ra) # 80003544 <_ZN6ThreadD1Ev>
    80006090:	00813083          	ld	ra,8(sp)
    80006094:	00013403          	ld	s0,0(sp)
    80006098:	01010113          	addi	sp,sp,16
    8000609c:	00008067          	ret

00000000800060a0 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    800060a0:	fe010113          	addi	sp,sp,-32
    800060a4:	00113c23          	sd	ra,24(sp)
    800060a8:	00813823          	sd	s0,16(sp)
    800060ac:	00913423          	sd	s1,8(sp)
    800060b0:	02010413          	addi	s0,sp,32
    800060b4:	00050493          	mv	s1,a0
    800060b8:	00006797          	auipc	a5,0x6
    800060bc:	b8078793          	addi	a5,a5,-1152 # 8000bc38 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800060c0:	00f53023          	sd	a5,0(a0)
    800060c4:	ffffd097          	auipc	ra,0xffffd
    800060c8:	480080e7          	jalr	1152(ra) # 80003544 <_ZN6ThreadD1Ev>
    800060cc:	00048513          	mv	a0,s1
    800060d0:	ffffd097          	auipc	ra,0xffffd
    800060d4:	504080e7          	jalr	1284(ra) # 800035d4 <_ZdlPv>
    800060d8:	01813083          	ld	ra,24(sp)
    800060dc:	01013403          	ld	s0,16(sp)
    800060e0:	00813483          	ld	s1,8(sp)
    800060e4:	02010113          	addi	sp,sp,32
    800060e8:	00008067          	ret

00000000800060ec <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    800060ec:	ff010113          	addi	sp,sp,-16
    800060f0:	00113423          	sd	ra,8(sp)
    800060f4:	00813023          	sd	s0,0(sp)
    800060f8:	01010413          	addi	s0,sp,16
    800060fc:	00006797          	auipc	a5,0x6
    80006100:	aec78793          	addi	a5,a5,-1300 # 8000bbe8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006104:	00f53023          	sd	a5,0(a0)
    80006108:	ffffd097          	auipc	ra,0xffffd
    8000610c:	43c080e7          	jalr	1084(ra) # 80003544 <_ZN6ThreadD1Ev>
    80006110:	00813083          	ld	ra,8(sp)
    80006114:	00013403          	ld	s0,0(sp)
    80006118:	01010113          	addi	sp,sp,16
    8000611c:	00008067          	ret

0000000080006120 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80006120:	fe010113          	addi	sp,sp,-32
    80006124:	00113c23          	sd	ra,24(sp)
    80006128:	00813823          	sd	s0,16(sp)
    8000612c:	00913423          	sd	s1,8(sp)
    80006130:	02010413          	addi	s0,sp,32
    80006134:	00050493          	mv	s1,a0
    80006138:	00006797          	auipc	a5,0x6
    8000613c:	ab078793          	addi	a5,a5,-1360 # 8000bbe8 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006140:	00f53023          	sd	a5,0(a0)
    80006144:	ffffd097          	auipc	ra,0xffffd
    80006148:	400080e7          	jalr	1024(ra) # 80003544 <_ZN6ThreadD1Ev>
    8000614c:	00048513          	mv	a0,s1
    80006150:	ffffd097          	auipc	ra,0xffffd
    80006154:	484080e7          	jalr	1156(ra) # 800035d4 <_ZdlPv>
    80006158:	01813083          	ld	ra,24(sp)
    8000615c:	01013403          	ld	s0,16(sp)
    80006160:	00813483          	ld	s1,8(sp)
    80006164:	02010113          	addi	sp,sp,32
    80006168:	00008067          	ret

000000008000616c <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8000616c:	ff010113          	addi	sp,sp,-16
    80006170:	00113423          	sd	ra,8(sp)
    80006174:	00813023          	sd	s0,0(sp)
    80006178:	01010413          	addi	s0,sp,16
    8000617c:	00006797          	auipc	a5,0x6
    80006180:	a9478793          	addi	a5,a5,-1388 # 8000bc10 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006184:	00f53023          	sd	a5,0(a0)
    80006188:	ffffd097          	auipc	ra,0xffffd
    8000618c:	3bc080e7          	jalr	956(ra) # 80003544 <_ZN6ThreadD1Ev>
    80006190:	00813083          	ld	ra,8(sp)
    80006194:	00013403          	ld	s0,0(sp)
    80006198:	01010113          	addi	sp,sp,16
    8000619c:	00008067          	ret

00000000800061a0 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    800061a0:	fe010113          	addi	sp,sp,-32
    800061a4:	00113c23          	sd	ra,24(sp)
    800061a8:	00813823          	sd	s0,16(sp)
    800061ac:	00913423          	sd	s1,8(sp)
    800061b0:	02010413          	addi	s0,sp,32
    800061b4:	00050493          	mv	s1,a0
    800061b8:	00006797          	auipc	a5,0x6
    800061bc:	a5878793          	addi	a5,a5,-1448 # 8000bc10 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800061c0:	00f53023          	sd	a5,0(a0)
    800061c4:	ffffd097          	auipc	ra,0xffffd
    800061c8:	380080e7          	jalr	896(ra) # 80003544 <_ZN6ThreadD1Ev>
    800061cc:	00048513          	mv	a0,s1
    800061d0:	ffffd097          	auipc	ra,0xffffd
    800061d4:	404080e7          	jalr	1028(ra) # 800035d4 <_ZdlPv>
    800061d8:	01813083          	ld	ra,24(sp)
    800061dc:	01013403          	ld	s0,16(sp)
    800061e0:	00813483          	ld	s1,8(sp)
    800061e4:	02010113          	addi	sp,sp,32
    800061e8:	00008067          	ret

00000000800061ec <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    800061ec:	fe010113          	addi	sp,sp,-32
    800061f0:	00113c23          	sd	ra,24(sp)
    800061f4:	00813823          	sd	s0,16(sp)
    800061f8:	00913423          	sd	s1,8(sp)
    800061fc:	02010413          	addi	s0,sp,32
    80006200:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80006204:	ffffc097          	auipc	ra,0xffffc
    80006208:	e6c080e7          	jalr	-404(ra) # 80002070 <_Z4getcv>
    8000620c:	0005059b          	sext.w	a1,a0
    80006210:	01b00793          	li	a5,27
    80006214:	00f58c63          	beq	a1,a5,8000622c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80006218:	0104b783          	ld	a5,16(s1)
    8000621c:	0087b503          	ld	a0,8(a5)
    80006220:	fffff097          	auipc	ra,0xfffff
    80006224:	07c080e7          	jalr	124(ra) # 8000529c <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80006228:	fddff06f          	j	80006204 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8000622c:	00100793          	li	a5,1
    80006230:	00006717          	auipc	a4,0x6
    80006234:	d4f72e23          	sw	a5,-676(a4) # 8000bf8c <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80006238:	0104b783          	ld	a5,16(s1)
    8000623c:	02100593          	li	a1,33
    80006240:	0087b503          	ld	a0,8(a5)
    80006244:	fffff097          	auipc	ra,0xfffff
    80006248:	058080e7          	jalr	88(ra) # 8000529c <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8000624c:	0104b783          	ld	a5,16(s1)
    80006250:	0107b503          	ld	a0,16(a5)
    80006254:	ffffd097          	auipc	ra,0xffffd
    80006258:	48c080e7          	jalr	1164(ra) # 800036e0 <_ZN9Semaphore6signalEv>
        }
    8000625c:	01813083          	ld	ra,24(sp)
    80006260:	01013403          	ld	s0,16(sp)
    80006264:	00813483          	ld	s1,8(sp)
    80006268:	02010113          	addi	sp,sp,32
    8000626c:	00008067          	ret

0000000080006270 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006270:	fe010113          	addi	sp,sp,-32
    80006274:	00113c23          	sd	ra,24(sp)
    80006278:	00813823          	sd	s0,16(sp)
    8000627c:	00913423          	sd	s1,8(sp)
    80006280:	01213023          	sd	s2,0(sp)
    80006284:	02010413          	addi	s0,sp,32
    80006288:	00050493          	mv	s1,a0
            int i = 0;
    8000628c:	00000913          	li	s2,0
            while (!threadEnd) {
    80006290:	00006797          	auipc	a5,0x6
    80006294:	cfc7a783          	lw	a5,-772(a5) # 8000bf8c <_ZN19ConsumerProducerCPP9threadEndE>
    80006298:	04079263          	bnez	a5,800062dc <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8000629c:	0104b783          	ld	a5,16(s1)
    800062a0:	0007a583          	lw	a1,0(a5)
    800062a4:	0305859b          	addiw	a1,a1,48
    800062a8:	0087b503          	ld	a0,8(a5)
    800062ac:	fffff097          	auipc	ra,0xfffff
    800062b0:	ff0080e7          	jalr	-16(ra) # 8000529c <_ZN9BufferCPP3putEi>
                i++;
    800062b4:	0019071b          	addiw	a4,s2,1
    800062b8:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    800062bc:	0104b783          	ld	a5,16(s1)
    800062c0:	0007a783          	lw	a5,0(a5)
    800062c4:	00e787bb          	addw	a5,a5,a4
    800062c8:	00500513          	li	a0,5
    800062cc:	02a7e53b          	remw	a0,a5,a0
    800062d0:	ffffd097          	auipc	ra,0xffffd
    800062d4:	4b8080e7          	jalr	1208(ra) # 80003788 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    800062d8:	fb9ff06f          	j	80006290 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    800062dc:	0104b783          	ld	a5,16(s1)
    800062e0:	0107b503          	ld	a0,16(a5)
    800062e4:	ffffd097          	auipc	ra,0xffffd
    800062e8:	3fc080e7          	jalr	1020(ra) # 800036e0 <_ZN9Semaphore6signalEv>
        }
    800062ec:	01813083          	ld	ra,24(sp)
    800062f0:	01013403          	ld	s0,16(sp)
    800062f4:	00813483          	ld	s1,8(sp)
    800062f8:	00013903          	ld	s2,0(sp)
    800062fc:	02010113          	addi	sp,sp,32
    80006300:	00008067          	ret

0000000080006304 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006304:	fe010113          	addi	sp,sp,-32
    80006308:	00113c23          	sd	ra,24(sp)
    8000630c:	00813823          	sd	s0,16(sp)
    80006310:	00913423          	sd	s1,8(sp)
    80006314:	01213023          	sd	s2,0(sp)
    80006318:	02010413          	addi	s0,sp,32
    8000631c:	00050493          	mv	s1,a0
    80006320:	00058913          	mv	s2,a1
    80006324:	0015879b          	addiw	a5,a1,1
    80006328:	0007851b          	sext.w	a0,a5
    8000632c:	00f4a023          	sw	a5,0(s1)
    80006330:	0004a823          	sw	zero,16(s1)
    80006334:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006338:	00251513          	slli	a0,a0,0x2
    8000633c:	ffffc097          	auipc	ra,0xffffc
    80006340:	a84080e7          	jalr	-1404(ra) # 80001dc0 <_Z9mem_allocm>
    80006344:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006348:	00000593          	li	a1,0
    8000634c:	02048513          	addi	a0,s1,32
    80006350:	ffffc097          	auipc	ra,0xffffc
    80006354:	c38080e7          	jalr	-968(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006358:	00090593          	mv	a1,s2
    8000635c:	01848513          	addi	a0,s1,24
    80006360:	ffffc097          	auipc	ra,0xffffc
    80006364:	c28080e7          	jalr	-984(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006368:	00100593          	li	a1,1
    8000636c:	02848513          	addi	a0,s1,40
    80006370:	ffffc097          	auipc	ra,0xffffc
    80006374:	c18080e7          	jalr	-1000(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80006378:	00100593          	li	a1,1
    8000637c:	03048513          	addi	a0,s1,48
    80006380:	ffffc097          	auipc	ra,0xffffc
    80006384:	c08080e7          	jalr	-1016(ra) # 80001f88 <_Z8sem_openPP10_semaphorej>
}
    80006388:	01813083          	ld	ra,24(sp)
    8000638c:	01013403          	ld	s0,16(sp)
    80006390:	00813483          	ld	s1,8(sp)
    80006394:	00013903          	ld	s2,0(sp)
    80006398:	02010113          	addi	sp,sp,32
    8000639c:	00008067          	ret

00000000800063a0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800063a0:	fe010113          	addi	sp,sp,-32
    800063a4:	00113c23          	sd	ra,24(sp)
    800063a8:	00813823          	sd	s0,16(sp)
    800063ac:	00913423          	sd	s1,8(sp)
    800063b0:	01213023          	sd	s2,0(sp)
    800063b4:	02010413          	addi	s0,sp,32
    800063b8:	00050493          	mv	s1,a0
    800063bc:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800063c0:	01853503          	ld	a0,24(a0)
    800063c4:	ffffc097          	auipc	ra,0xffffc
    800063c8:	c28080e7          	jalr	-984(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    800063cc:	0304b503          	ld	a0,48(s1)
    800063d0:	ffffc097          	auipc	ra,0xffffc
    800063d4:	c1c080e7          	jalr	-996(ra) # 80001fec <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    800063d8:	0084b783          	ld	a5,8(s1)
    800063dc:	0144a703          	lw	a4,20(s1)
    800063e0:	00271713          	slli	a4,a4,0x2
    800063e4:	00e787b3          	add	a5,a5,a4
    800063e8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800063ec:	0144a783          	lw	a5,20(s1)
    800063f0:	0017879b          	addiw	a5,a5,1
    800063f4:	0004a703          	lw	a4,0(s1)
    800063f8:	02e7e7bb          	remw	a5,a5,a4
    800063fc:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006400:	0304b503          	ld	a0,48(s1)
    80006404:	ffffc097          	auipc	ra,0xffffc
    80006408:	c14080e7          	jalr	-1004(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8000640c:	0204b503          	ld	a0,32(s1)
    80006410:	ffffc097          	auipc	ra,0xffffc
    80006414:	c08080e7          	jalr	-1016(ra) # 80002018 <_Z10sem_signalP10_semaphore>

}
    80006418:	01813083          	ld	ra,24(sp)
    8000641c:	01013403          	ld	s0,16(sp)
    80006420:	00813483          	ld	s1,8(sp)
    80006424:	00013903          	ld	s2,0(sp)
    80006428:	02010113          	addi	sp,sp,32
    8000642c:	00008067          	ret

0000000080006430 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006430:	fe010113          	addi	sp,sp,-32
    80006434:	00113c23          	sd	ra,24(sp)
    80006438:	00813823          	sd	s0,16(sp)
    8000643c:	00913423          	sd	s1,8(sp)
    80006440:	01213023          	sd	s2,0(sp)
    80006444:	02010413          	addi	s0,sp,32
    80006448:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8000644c:	02053503          	ld	a0,32(a0)
    80006450:	ffffc097          	auipc	ra,0xffffc
    80006454:	b9c080e7          	jalr	-1124(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006458:	0284b503          	ld	a0,40(s1)
    8000645c:	ffffc097          	auipc	ra,0xffffc
    80006460:	b90080e7          	jalr	-1136(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006464:	0084b703          	ld	a4,8(s1)
    80006468:	0104a783          	lw	a5,16(s1)
    8000646c:	00279693          	slli	a3,a5,0x2
    80006470:	00d70733          	add	a4,a4,a3
    80006474:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006478:	0017879b          	addiw	a5,a5,1
    8000647c:	0004a703          	lw	a4,0(s1)
    80006480:	02e7e7bb          	remw	a5,a5,a4
    80006484:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006488:	0284b503          	ld	a0,40(s1)
    8000648c:	ffffc097          	auipc	ra,0xffffc
    80006490:	b8c080e7          	jalr	-1140(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006494:	0184b503          	ld	a0,24(s1)
    80006498:	ffffc097          	auipc	ra,0xffffc
    8000649c:	b80080e7          	jalr	-1152(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    return ret;
}
    800064a0:	00090513          	mv	a0,s2
    800064a4:	01813083          	ld	ra,24(sp)
    800064a8:	01013403          	ld	s0,16(sp)
    800064ac:	00813483          	ld	s1,8(sp)
    800064b0:	00013903          	ld	s2,0(sp)
    800064b4:	02010113          	addi	sp,sp,32
    800064b8:	00008067          	ret

00000000800064bc <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800064bc:	fe010113          	addi	sp,sp,-32
    800064c0:	00113c23          	sd	ra,24(sp)
    800064c4:	00813823          	sd	s0,16(sp)
    800064c8:	00913423          	sd	s1,8(sp)
    800064cc:	01213023          	sd	s2,0(sp)
    800064d0:	02010413          	addi	s0,sp,32
    800064d4:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800064d8:	02853503          	ld	a0,40(a0)
    800064dc:	ffffc097          	auipc	ra,0xffffc
    800064e0:	b10080e7          	jalr	-1264(ra) # 80001fec <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800064e4:	0304b503          	ld	a0,48(s1)
    800064e8:	ffffc097          	auipc	ra,0xffffc
    800064ec:	b04080e7          	jalr	-1276(ra) # 80001fec <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    800064f0:	0144a783          	lw	a5,20(s1)
    800064f4:	0104a903          	lw	s2,16(s1)
    800064f8:	0327ce63          	blt	a5,s2,80006534 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800064fc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006500:	0304b503          	ld	a0,48(s1)
    80006504:	ffffc097          	auipc	ra,0xffffc
    80006508:	b14080e7          	jalr	-1260(ra) # 80002018 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000650c:	0284b503          	ld	a0,40(s1)
    80006510:	ffffc097          	auipc	ra,0xffffc
    80006514:	b08080e7          	jalr	-1272(ra) # 80002018 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006518:	00090513          	mv	a0,s2
    8000651c:	01813083          	ld	ra,24(sp)
    80006520:	01013403          	ld	s0,16(sp)
    80006524:	00813483          	ld	s1,8(sp)
    80006528:	00013903          	ld	s2,0(sp)
    8000652c:	02010113          	addi	sp,sp,32
    80006530:	00008067          	ret
        ret = cap - head + tail;
    80006534:	0004a703          	lw	a4,0(s1)
    80006538:	4127093b          	subw	s2,a4,s2
    8000653c:	00f9093b          	addw	s2,s2,a5
    80006540:	fc1ff06f          	j	80006500 <_ZN6Buffer6getCntEv+0x44>

0000000080006544 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006544:	fe010113          	addi	sp,sp,-32
    80006548:	00113c23          	sd	ra,24(sp)
    8000654c:	00813823          	sd	s0,16(sp)
    80006550:	00913423          	sd	s1,8(sp)
    80006554:	02010413          	addi	s0,sp,32
    80006558:	00050493          	mv	s1,a0
    putc('\n');
    8000655c:	00a00513          	li	a0,10
    80006560:	ffffc097          	auipc	ra,0xffffc
    80006564:	b38080e7          	jalr	-1224(ra) # 80002098 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006568:	00003517          	auipc	a0,0x3
    8000656c:	00850513          	addi	a0,a0,8 # 80009570 <CONSOLE_STATUS+0x560>
    80006570:	ffffc097          	auipc	ra,0xffffc
    80006574:	240080e7          	jalr	576(ra) # 800027b0 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006578:	00048513          	mv	a0,s1
    8000657c:	00000097          	auipc	ra,0x0
    80006580:	f40080e7          	jalr	-192(ra) # 800064bc <_ZN6Buffer6getCntEv>
    80006584:	02a05c63          	blez	a0,800065bc <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006588:	0084b783          	ld	a5,8(s1)
    8000658c:	0104a703          	lw	a4,16(s1)
    80006590:	00271713          	slli	a4,a4,0x2
    80006594:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006598:	0007c503          	lbu	a0,0(a5)
    8000659c:	ffffc097          	auipc	ra,0xffffc
    800065a0:	afc080e7          	jalr	-1284(ra) # 80002098 <_Z4putcc>
        head = (head + 1) % cap;
    800065a4:	0104a783          	lw	a5,16(s1)
    800065a8:	0017879b          	addiw	a5,a5,1
    800065ac:	0004a703          	lw	a4,0(s1)
    800065b0:	02e7e7bb          	remw	a5,a5,a4
    800065b4:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800065b8:	fc1ff06f          	j	80006578 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800065bc:	02100513          	li	a0,33
    800065c0:	ffffc097          	auipc	ra,0xffffc
    800065c4:	ad8080e7          	jalr	-1320(ra) # 80002098 <_Z4putcc>
    putc('\n');
    800065c8:	00a00513          	li	a0,10
    800065cc:	ffffc097          	auipc	ra,0xffffc
    800065d0:	acc080e7          	jalr	-1332(ra) # 80002098 <_Z4putcc>
    mem_free(buffer);
    800065d4:	0084b503          	ld	a0,8(s1)
    800065d8:	ffffc097          	auipc	ra,0xffffc
    800065dc:	818080e7          	jalr	-2024(ra) # 80001df0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800065e0:	0204b503          	ld	a0,32(s1)
    800065e4:	ffffc097          	auipc	ra,0xffffc
    800065e8:	9dc080e7          	jalr	-1572(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    800065ec:	0184b503          	ld	a0,24(s1)
    800065f0:	ffffc097          	auipc	ra,0xffffc
    800065f4:	9d0080e7          	jalr	-1584(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    800065f8:	0304b503          	ld	a0,48(s1)
    800065fc:	ffffc097          	auipc	ra,0xffffc
    80006600:	9c4080e7          	jalr	-1596(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006604:	0284b503          	ld	a0,40(s1)
    80006608:	ffffc097          	auipc	ra,0xffffc
    8000660c:	9b8080e7          	jalr	-1608(ra) # 80001fc0 <_Z9sem_closeP10_semaphore>
}
    80006610:	01813083          	ld	ra,24(sp)
    80006614:	01013403          	ld	s0,16(sp)
    80006618:	00813483          	ld	s1,8(sp)
    8000661c:	02010113          	addi	sp,sp,32
    80006620:	00008067          	ret

0000000080006624 <start>:
    80006624:	ff010113          	addi	sp,sp,-16
    80006628:	00813423          	sd	s0,8(sp)
    8000662c:	01010413          	addi	s0,sp,16
    80006630:	300027f3          	csrr	a5,mstatus
    80006634:	ffffe737          	lui	a4,0xffffe
    80006638:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff15ff>
    8000663c:	00e7f7b3          	and	a5,a5,a4
    80006640:	00001737          	lui	a4,0x1
    80006644:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006648:	00e7e7b3          	or	a5,a5,a4
    8000664c:	30079073          	csrw	mstatus,a5
    80006650:	00000797          	auipc	a5,0x0
    80006654:	16078793          	addi	a5,a5,352 # 800067b0 <system_main>
    80006658:	34179073          	csrw	mepc,a5
    8000665c:	00000793          	li	a5,0
    80006660:	18079073          	csrw	satp,a5
    80006664:	000107b7          	lui	a5,0x10
    80006668:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000666c:	30279073          	csrw	medeleg,a5
    80006670:	30379073          	csrw	mideleg,a5
    80006674:	104027f3          	csrr	a5,sie
    80006678:	2227e793          	ori	a5,a5,546
    8000667c:	10479073          	csrw	sie,a5
    80006680:	fff00793          	li	a5,-1
    80006684:	00a7d793          	srli	a5,a5,0xa
    80006688:	3b079073          	csrw	pmpaddr0,a5
    8000668c:	00f00793          	li	a5,15
    80006690:	3a079073          	csrw	pmpcfg0,a5
    80006694:	f14027f3          	csrr	a5,mhartid
    80006698:	0200c737          	lui	a4,0x200c
    8000669c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800066a0:	0007869b          	sext.w	a3,a5
    800066a4:	00269713          	slli	a4,a3,0x2
    800066a8:	000f4637          	lui	a2,0xf4
    800066ac:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800066b0:	00d70733          	add	a4,a4,a3
    800066b4:	0037979b          	slliw	a5,a5,0x3
    800066b8:	020046b7          	lui	a3,0x2004
    800066bc:	00d787b3          	add	a5,a5,a3
    800066c0:	00c585b3          	add	a1,a1,a2
    800066c4:	00371693          	slli	a3,a4,0x3
    800066c8:	00006717          	auipc	a4,0x6
    800066cc:	8d870713          	addi	a4,a4,-1832 # 8000bfa0 <timer_scratch>
    800066d0:	00b7b023          	sd	a1,0(a5)
    800066d4:	00d70733          	add	a4,a4,a3
    800066d8:	00f73c23          	sd	a5,24(a4)
    800066dc:	02c73023          	sd	a2,32(a4)
    800066e0:	34071073          	csrw	mscratch,a4
    800066e4:	00000797          	auipc	a5,0x0
    800066e8:	6ec78793          	addi	a5,a5,1772 # 80006dd0 <timervec>
    800066ec:	30579073          	csrw	mtvec,a5
    800066f0:	300027f3          	csrr	a5,mstatus
    800066f4:	0087e793          	ori	a5,a5,8
    800066f8:	30079073          	csrw	mstatus,a5
    800066fc:	304027f3          	csrr	a5,mie
    80006700:	0807e793          	ori	a5,a5,128
    80006704:	30479073          	csrw	mie,a5
    80006708:	f14027f3          	csrr	a5,mhartid
    8000670c:	0007879b          	sext.w	a5,a5
    80006710:	00078213          	mv	tp,a5
    80006714:	30200073          	mret
    80006718:	00813403          	ld	s0,8(sp)
    8000671c:	01010113          	addi	sp,sp,16
    80006720:	00008067          	ret

0000000080006724 <timerinit>:
    80006724:	ff010113          	addi	sp,sp,-16
    80006728:	00813423          	sd	s0,8(sp)
    8000672c:	01010413          	addi	s0,sp,16
    80006730:	f14027f3          	csrr	a5,mhartid
    80006734:	0200c737          	lui	a4,0x200c
    80006738:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000673c:	0007869b          	sext.w	a3,a5
    80006740:	00269713          	slli	a4,a3,0x2
    80006744:	000f4637          	lui	a2,0xf4
    80006748:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000674c:	00d70733          	add	a4,a4,a3
    80006750:	0037979b          	slliw	a5,a5,0x3
    80006754:	020046b7          	lui	a3,0x2004
    80006758:	00d787b3          	add	a5,a5,a3
    8000675c:	00c585b3          	add	a1,a1,a2
    80006760:	00371693          	slli	a3,a4,0x3
    80006764:	00006717          	auipc	a4,0x6
    80006768:	83c70713          	addi	a4,a4,-1988 # 8000bfa0 <timer_scratch>
    8000676c:	00b7b023          	sd	a1,0(a5)
    80006770:	00d70733          	add	a4,a4,a3
    80006774:	00f73c23          	sd	a5,24(a4)
    80006778:	02c73023          	sd	a2,32(a4)
    8000677c:	34071073          	csrw	mscratch,a4
    80006780:	00000797          	auipc	a5,0x0
    80006784:	65078793          	addi	a5,a5,1616 # 80006dd0 <timervec>
    80006788:	30579073          	csrw	mtvec,a5
    8000678c:	300027f3          	csrr	a5,mstatus
    80006790:	0087e793          	ori	a5,a5,8
    80006794:	30079073          	csrw	mstatus,a5
    80006798:	304027f3          	csrr	a5,mie
    8000679c:	0807e793          	ori	a5,a5,128
    800067a0:	30479073          	csrw	mie,a5
    800067a4:	00813403          	ld	s0,8(sp)
    800067a8:	01010113          	addi	sp,sp,16
    800067ac:	00008067          	ret

00000000800067b0 <system_main>:
    800067b0:	fe010113          	addi	sp,sp,-32
    800067b4:	00813823          	sd	s0,16(sp)
    800067b8:	00913423          	sd	s1,8(sp)
    800067bc:	00113c23          	sd	ra,24(sp)
    800067c0:	02010413          	addi	s0,sp,32
    800067c4:	00000097          	auipc	ra,0x0
    800067c8:	0c4080e7          	jalr	196(ra) # 80006888 <cpuid>
    800067cc:	00005497          	auipc	s1,0x5
    800067d0:	54448493          	addi	s1,s1,1348 # 8000bd10 <started>
    800067d4:	02050263          	beqz	a0,800067f8 <system_main+0x48>
    800067d8:	0004a783          	lw	a5,0(s1)
    800067dc:	0007879b          	sext.w	a5,a5
    800067e0:	fe078ce3          	beqz	a5,800067d8 <system_main+0x28>
    800067e4:	0ff0000f          	fence
    800067e8:	00003517          	auipc	a0,0x3
    800067ec:	fa850513          	addi	a0,a0,-88 # 80009790 <CONSOLE_STATUS+0x780>
    800067f0:	00001097          	auipc	ra,0x1
    800067f4:	a7c080e7          	jalr	-1412(ra) # 8000726c <panic>
    800067f8:	00001097          	auipc	ra,0x1
    800067fc:	9d0080e7          	jalr	-1584(ra) # 800071c8 <consoleinit>
    80006800:	00001097          	auipc	ra,0x1
    80006804:	15c080e7          	jalr	348(ra) # 8000795c <printfinit>
    80006808:	00003517          	auipc	a0,0x3
    8000680c:	b5850513          	addi	a0,a0,-1192 # 80009360 <CONSOLE_STATUS+0x350>
    80006810:	00001097          	auipc	ra,0x1
    80006814:	ab8080e7          	jalr	-1352(ra) # 800072c8 <__printf>
    80006818:	00003517          	auipc	a0,0x3
    8000681c:	f4850513          	addi	a0,a0,-184 # 80009760 <CONSOLE_STATUS+0x750>
    80006820:	00001097          	auipc	ra,0x1
    80006824:	aa8080e7          	jalr	-1368(ra) # 800072c8 <__printf>
    80006828:	00003517          	auipc	a0,0x3
    8000682c:	b3850513          	addi	a0,a0,-1224 # 80009360 <CONSOLE_STATUS+0x350>
    80006830:	00001097          	auipc	ra,0x1
    80006834:	a98080e7          	jalr	-1384(ra) # 800072c8 <__printf>
    80006838:	00001097          	auipc	ra,0x1
    8000683c:	4b0080e7          	jalr	1200(ra) # 80007ce8 <kinit>
    80006840:	00000097          	auipc	ra,0x0
    80006844:	148080e7          	jalr	328(ra) # 80006988 <trapinit>
    80006848:	00000097          	auipc	ra,0x0
    8000684c:	16c080e7          	jalr	364(ra) # 800069b4 <trapinithart>
    80006850:	00000097          	auipc	ra,0x0
    80006854:	5c0080e7          	jalr	1472(ra) # 80006e10 <plicinit>
    80006858:	00000097          	auipc	ra,0x0
    8000685c:	5e0080e7          	jalr	1504(ra) # 80006e38 <plicinithart>
    80006860:	00000097          	auipc	ra,0x0
    80006864:	078080e7          	jalr	120(ra) # 800068d8 <userinit>
    80006868:	0ff0000f          	fence
    8000686c:	00100793          	li	a5,1
    80006870:	00003517          	auipc	a0,0x3
    80006874:	f0850513          	addi	a0,a0,-248 # 80009778 <CONSOLE_STATUS+0x768>
    80006878:	00f4a023          	sw	a5,0(s1)
    8000687c:	00001097          	auipc	ra,0x1
    80006880:	a4c080e7          	jalr	-1460(ra) # 800072c8 <__printf>
    80006884:	0000006f          	j	80006884 <system_main+0xd4>

0000000080006888 <cpuid>:
    80006888:	ff010113          	addi	sp,sp,-16
    8000688c:	00813423          	sd	s0,8(sp)
    80006890:	01010413          	addi	s0,sp,16
    80006894:	00020513          	mv	a0,tp
    80006898:	00813403          	ld	s0,8(sp)
    8000689c:	0005051b          	sext.w	a0,a0
    800068a0:	01010113          	addi	sp,sp,16
    800068a4:	00008067          	ret

00000000800068a8 <mycpu>:
    800068a8:	ff010113          	addi	sp,sp,-16
    800068ac:	00813423          	sd	s0,8(sp)
    800068b0:	01010413          	addi	s0,sp,16
    800068b4:	00020793          	mv	a5,tp
    800068b8:	00813403          	ld	s0,8(sp)
    800068bc:	0007879b          	sext.w	a5,a5
    800068c0:	00779793          	slli	a5,a5,0x7
    800068c4:	00006517          	auipc	a0,0x6
    800068c8:	70c50513          	addi	a0,a0,1804 # 8000cfd0 <cpus>
    800068cc:	00f50533          	add	a0,a0,a5
    800068d0:	01010113          	addi	sp,sp,16
    800068d4:	00008067          	ret

00000000800068d8 <userinit>:
    800068d8:	ff010113          	addi	sp,sp,-16
    800068dc:	00813423          	sd	s0,8(sp)
    800068e0:	01010413          	addi	s0,sp,16
    800068e4:	00813403          	ld	s0,8(sp)
    800068e8:	01010113          	addi	sp,sp,16
    800068ec:	ffffc317          	auipc	t1,0xffffc
    800068f0:	40030067          	jr	1024(t1) # 80002cec <main>

00000000800068f4 <either_copyout>:
    800068f4:	ff010113          	addi	sp,sp,-16
    800068f8:	00813023          	sd	s0,0(sp)
    800068fc:	00113423          	sd	ra,8(sp)
    80006900:	01010413          	addi	s0,sp,16
    80006904:	02051663          	bnez	a0,80006930 <either_copyout+0x3c>
    80006908:	00058513          	mv	a0,a1
    8000690c:	00060593          	mv	a1,a2
    80006910:	0006861b          	sext.w	a2,a3
    80006914:	00002097          	auipc	ra,0x2
    80006918:	c60080e7          	jalr	-928(ra) # 80008574 <__memmove>
    8000691c:	00813083          	ld	ra,8(sp)
    80006920:	00013403          	ld	s0,0(sp)
    80006924:	00000513          	li	a0,0
    80006928:	01010113          	addi	sp,sp,16
    8000692c:	00008067          	ret
    80006930:	00003517          	auipc	a0,0x3
    80006934:	e8850513          	addi	a0,a0,-376 # 800097b8 <CONSOLE_STATUS+0x7a8>
    80006938:	00001097          	auipc	ra,0x1
    8000693c:	934080e7          	jalr	-1740(ra) # 8000726c <panic>

0000000080006940 <either_copyin>:
    80006940:	ff010113          	addi	sp,sp,-16
    80006944:	00813023          	sd	s0,0(sp)
    80006948:	00113423          	sd	ra,8(sp)
    8000694c:	01010413          	addi	s0,sp,16
    80006950:	02059463          	bnez	a1,80006978 <either_copyin+0x38>
    80006954:	00060593          	mv	a1,a2
    80006958:	0006861b          	sext.w	a2,a3
    8000695c:	00002097          	auipc	ra,0x2
    80006960:	c18080e7          	jalr	-1000(ra) # 80008574 <__memmove>
    80006964:	00813083          	ld	ra,8(sp)
    80006968:	00013403          	ld	s0,0(sp)
    8000696c:	00000513          	li	a0,0
    80006970:	01010113          	addi	sp,sp,16
    80006974:	00008067          	ret
    80006978:	00003517          	auipc	a0,0x3
    8000697c:	e6850513          	addi	a0,a0,-408 # 800097e0 <CONSOLE_STATUS+0x7d0>
    80006980:	00001097          	auipc	ra,0x1
    80006984:	8ec080e7          	jalr	-1812(ra) # 8000726c <panic>

0000000080006988 <trapinit>:
    80006988:	ff010113          	addi	sp,sp,-16
    8000698c:	00813423          	sd	s0,8(sp)
    80006990:	01010413          	addi	s0,sp,16
    80006994:	00813403          	ld	s0,8(sp)
    80006998:	00003597          	auipc	a1,0x3
    8000699c:	e7058593          	addi	a1,a1,-400 # 80009808 <CONSOLE_STATUS+0x7f8>
    800069a0:	00006517          	auipc	a0,0x6
    800069a4:	6b050513          	addi	a0,a0,1712 # 8000d050 <tickslock>
    800069a8:	01010113          	addi	sp,sp,16
    800069ac:	00001317          	auipc	t1,0x1
    800069b0:	5cc30067          	jr	1484(t1) # 80007f78 <initlock>

00000000800069b4 <trapinithart>:
    800069b4:	ff010113          	addi	sp,sp,-16
    800069b8:	00813423          	sd	s0,8(sp)
    800069bc:	01010413          	addi	s0,sp,16
    800069c0:	00000797          	auipc	a5,0x0
    800069c4:	30078793          	addi	a5,a5,768 # 80006cc0 <kernelvec>
    800069c8:	10579073          	csrw	stvec,a5
    800069cc:	00813403          	ld	s0,8(sp)
    800069d0:	01010113          	addi	sp,sp,16
    800069d4:	00008067          	ret

00000000800069d8 <usertrap>:
    800069d8:	ff010113          	addi	sp,sp,-16
    800069dc:	00813423          	sd	s0,8(sp)
    800069e0:	01010413          	addi	s0,sp,16
    800069e4:	00813403          	ld	s0,8(sp)
    800069e8:	01010113          	addi	sp,sp,16
    800069ec:	00008067          	ret

00000000800069f0 <usertrapret>:
    800069f0:	ff010113          	addi	sp,sp,-16
    800069f4:	00813423          	sd	s0,8(sp)
    800069f8:	01010413          	addi	s0,sp,16
    800069fc:	00813403          	ld	s0,8(sp)
    80006a00:	01010113          	addi	sp,sp,16
    80006a04:	00008067          	ret

0000000080006a08 <kerneltrap>:
    80006a08:	fe010113          	addi	sp,sp,-32
    80006a0c:	00813823          	sd	s0,16(sp)
    80006a10:	00113c23          	sd	ra,24(sp)
    80006a14:	00913423          	sd	s1,8(sp)
    80006a18:	02010413          	addi	s0,sp,32
    80006a1c:	142025f3          	csrr	a1,scause
    80006a20:	100027f3          	csrr	a5,sstatus
    80006a24:	0027f793          	andi	a5,a5,2
    80006a28:	10079c63          	bnez	a5,80006b40 <kerneltrap+0x138>
    80006a2c:	142027f3          	csrr	a5,scause
    80006a30:	0207ce63          	bltz	a5,80006a6c <kerneltrap+0x64>
    80006a34:	00003517          	auipc	a0,0x3
    80006a38:	e1c50513          	addi	a0,a0,-484 # 80009850 <CONSOLE_STATUS+0x840>
    80006a3c:	00001097          	auipc	ra,0x1
    80006a40:	88c080e7          	jalr	-1908(ra) # 800072c8 <__printf>
    80006a44:	141025f3          	csrr	a1,sepc
    80006a48:	14302673          	csrr	a2,stval
    80006a4c:	00003517          	auipc	a0,0x3
    80006a50:	e1450513          	addi	a0,a0,-492 # 80009860 <CONSOLE_STATUS+0x850>
    80006a54:	00001097          	auipc	ra,0x1
    80006a58:	874080e7          	jalr	-1932(ra) # 800072c8 <__printf>
    80006a5c:	00003517          	auipc	a0,0x3
    80006a60:	e1c50513          	addi	a0,a0,-484 # 80009878 <CONSOLE_STATUS+0x868>
    80006a64:	00001097          	auipc	ra,0x1
    80006a68:	808080e7          	jalr	-2040(ra) # 8000726c <panic>
    80006a6c:	0ff7f713          	andi	a4,a5,255
    80006a70:	00900693          	li	a3,9
    80006a74:	04d70063          	beq	a4,a3,80006ab4 <kerneltrap+0xac>
    80006a78:	fff00713          	li	a4,-1
    80006a7c:	03f71713          	slli	a4,a4,0x3f
    80006a80:	00170713          	addi	a4,a4,1
    80006a84:	fae798e3          	bne	a5,a4,80006a34 <kerneltrap+0x2c>
    80006a88:	00000097          	auipc	ra,0x0
    80006a8c:	e00080e7          	jalr	-512(ra) # 80006888 <cpuid>
    80006a90:	06050663          	beqz	a0,80006afc <kerneltrap+0xf4>
    80006a94:	144027f3          	csrr	a5,sip
    80006a98:	ffd7f793          	andi	a5,a5,-3
    80006a9c:	14479073          	csrw	sip,a5
    80006aa0:	01813083          	ld	ra,24(sp)
    80006aa4:	01013403          	ld	s0,16(sp)
    80006aa8:	00813483          	ld	s1,8(sp)
    80006aac:	02010113          	addi	sp,sp,32
    80006ab0:	00008067          	ret
    80006ab4:	00000097          	auipc	ra,0x0
    80006ab8:	3d0080e7          	jalr	976(ra) # 80006e84 <plic_claim>
    80006abc:	00a00793          	li	a5,10
    80006ac0:	00050493          	mv	s1,a0
    80006ac4:	06f50863          	beq	a0,a5,80006b34 <kerneltrap+0x12c>
    80006ac8:	fc050ce3          	beqz	a0,80006aa0 <kerneltrap+0x98>
    80006acc:	00050593          	mv	a1,a0
    80006ad0:	00003517          	auipc	a0,0x3
    80006ad4:	d6050513          	addi	a0,a0,-672 # 80009830 <CONSOLE_STATUS+0x820>
    80006ad8:	00000097          	auipc	ra,0x0
    80006adc:	7f0080e7          	jalr	2032(ra) # 800072c8 <__printf>
    80006ae0:	01013403          	ld	s0,16(sp)
    80006ae4:	01813083          	ld	ra,24(sp)
    80006ae8:	00048513          	mv	a0,s1
    80006aec:	00813483          	ld	s1,8(sp)
    80006af0:	02010113          	addi	sp,sp,32
    80006af4:	00000317          	auipc	t1,0x0
    80006af8:	3c830067          	jr	968(t1) # 80006ebc <plic_complete>
    80006afc:	00006517          	auipc	a0,0x6
    80006b00:	55450513          	addi	a0,a0,1364 # 8000d050 <tickslock>
    80006b04:	00001097          	auipc	ra,0x1
    80006b08:	498080e7          	jalr	1176(ra) # 80007f9c <acquire>
    80006b0c:	00005717          	auipc	a4,0x5
    80006b10:	20870713          	addi	a4,a4,520 # 8000bd14 <ticks>
    80006b14:	00072783          	lw	a5,0(a4)
    80006b18:	00006517          	auipc	a0,0x6
    80006b1c:	53850513          	addi	a0,a0,1336 # 8000d050 <tickslock>
    80006b20:	0017879b          	addiw	a5,a5,1
    80006b24:	00f72023          	sw	a5,0(a4)
    80006b28:	00001097          	auipc	ra,0x1
    80006b2c:	540080e7          	jalr	1344(ra) # 80008068 <release>
    80006b30:	f65ff06f          	j	80006a94 <kerneltrap+0x8c>
    80006b34:	00001097          	auipc	ra,0x1
    80006b38:	09c080e7          	jalr	156(ra) # 80007bd0 <uartintr>
    80006b3c:	fa5ff06f          	j	80006ae0 <kerneltrap+0xd8>
    80006b40:	00003517          	auipc	a0,0x3
    80006b44:	cd050513          	addi	a0,a0,-816 # 80009810 <CONSOLE_STATUS+0x800>
    80006b48:	00000097          	auipc	ra,0x0
    80006b4c:	724080e7          	jalr	1828(ra) # 8000726c <panic>

0000000080006b50 <clockintr>:
    80006b50:	fe010113          	addi	sp,sp,-32
    80006b54:	00813823          	sd	s0,16(sp)
    80006b58:	00913423          	sd	s1,8(sp)
    80006b5c:	00113c23          	sd	ra,24(sp)
    80006b60:	02010413          	addi	s0,sp,32
    80006b64:	00006497          	auipc	s1,0x6
    80006b68:	4ec48493          	addi	s1,s1,1260 # 8000d050 <tickslock>
    80006b6c:	00048513          	mv	a0,s1
    80006b70:	00001097          	auipc	ra,0x1
    80006b74:	42c080e7          	jalr	1068(ra) # 80007f9c <acquire>
    80006b78:	00005717          	auipc	a4,0x5
    80006b7c:	19c70713          	addi	a4,a4,412 # 8000bd14 <ticks>
    80006b80:	00072783          	lw	a5,0(a4)
    80006b84:	01013403          	ld	s0,16(sp)
    80006b88:	01813083          	ld	ra,24(sp)
    80006b8c:	00048513          	mv	a0,s1
    80006b90:	0017879b          	addiw	a5,a5,1
    80006b94:	00813483          	ld	s1,8(sp)
    80006b98:	00f72023          	sw	a5,0(a4)
    80006b9c:	02010113          	addi	sp,sp,32
    80006ba0:	00001317          	auipc	t1,0x1
    80006ba4:	4c830067          	jr	1224(t1) # 80008068 <release>

0000000080006ba8 <devintr>:
    80006ba8:	142027f3          	csrr	a5,scause
    80006bac:	00000513          	li	a0,0
    80006bb0:	0007c463          	bltz	a5,80006bb8 <devintr+0x10>
    80006bb4:	00008067          	ret
    80006bb8:	fe010113          	addi	sp,sp,-32
    80006bbc:	00813823          	sd	s0,16(sp)
    80006bc0:	00113c23          	sd	ra,24(sp)
    80006bc4:	00913423          	sd	s1,8(sp)
    80006bc8:	02010413          	addi	s0,sp,32
    80006bcc:	0ff7f713          	andi	a4,a5,255
    80006bd0:	00900693          	li	a3,9
    80006bd4:	04d70c63          	beq	a4,a3,80006c2c <devintr+0x84>
    80006bd8:	fff00713          	li	a4,-1
    80006bdc:	03f71713          	slli	a4,a4,0x3f
    80006be0:	00170713          	addi	a4,a4,1
    80006be4:	00e78c63          	beq	a5,a4,80006bfc <devintr+0x54>
    80006be8:	01813083          	ld	ra,24(sp)
    80006bec:	01013403          	ld	s0,16(sp)
    80006bf0:	00813483          	ld	s1,8(sp)
    80006bf4:	02010113          	addi	sp,sp,32
    80006bf8:	00008067          	ret
    80006bfc:	00000097          	auipc	ra,0x0
    80006c00:	c8c080e7          	jalr	-884(ra) # 80006888 <cpuid>
    80006c04:	06050663          	beqz	a0,80006c70 <devintr+0xc8>
    80006c08:	144027f3          	csrr	a5,sip
    80006c0c:	ffd7f793          	andi	a5,a5,-3
    80006c10:	14479073          	csrw	sip,a5
    80006c14:	01813083          	ld	ra,24(sp)
    80006c18:	01013403          	ld	s0,16(sp)
    80006c1c:	00813483          	ld	s1,8(sp)
    80006c20:	00200513          	li	a0,2
    80006c24:	02010113          	addi	sp,sp,32
    80006c28:	00008067          	ret
    80006c2c:	00000097          	auipc	ra,0x0
    80006c30:	258080e7          	jalr	600(ra) # 80006e84 <plic_claim>
    80006c34:	00a00793          	li	a5,10
    80006c38:	00050493          	mv	s1,a0
    80006c3c:	06f50663          	beq	a0,a5,80006ca8 <devintr+0x100>
    80006c40:	00100513          	li	a0,1
    80006c44:	fa0482e3          	beqz	s1,80006be8 <devintr+0x40>
    80006c48:	00048593          	mv	a1,s1
    80006c4c:	00003517          	auipc	a0,0x3
    80006c50:	be450513          	addi	a0,a0,-1052 # 80009830 <CONSOLE_STATUS+0x820>
    80006c54:	00000097          	auipc	ra,0x0
    80006c58:	674080e7          	jalr	1652(ra) # 800072c8 <__printf>
    80006c5c:	00048513          	mv	a0,s1
    80006c60:	00000097          	auipc	ra,0x0
    80006c64:	25c080e7          	jalr	604(ra) # 80006ebc <plic_complete>
    80006c68:	00100513          	li	a0,1
    80006c6c:	f7dff06f          	j	80006be8 <devintr+0x40>
    80006c70:	00006517          	auipc	a0,0x6
    80006c74:	3e050513          	addi	a0,a0,992 # 8000d050 <tickslock>
    80006c78:	00001097          	auipc	ra,0x1
    80006c7c:	324080e7          	jalr	804(ra) # 80007f9c <acquire>
    80006c80:	00005717          	auipc	a4,0x5
    80006c84:	09470713          	addi	a4,a4,148 # 8000bd14 <ticks>
    80006c88:	00072783          	lw	a5,0(a4)
    80006c8c:	00006517          	auipc	a0,0x6
    80006c90:	3c450513          	addi	a0,a0,964 # 8000d050 <tickslock>
    80006c94:	0017879b          	addiw	a5,a5,1
    80006c98:	00f72023          	sw	a5,0(a4)
    80006c9c:	00001097          	auipc	ra,0x1
    80006ca0:	3cc080e7          	jalr	972(ra) # 80008068 <release>
    80006ca4:	f65ff06f          	j	80006c08 <devintr+0x60>
    80006ca8:	00001097          	auipc	ra,0x1
    80006cac:	f28080e7          	jalr	-216(ra) # 80007bd0 <uartintr>
    80006cb0:	fadff06f          	j	80006c5c <devintr+0xb4>
	...

0000000080006cc0 <kernelvec>:
    80006cc0:	f0010113          	addi	sp,sp,-256
    80006cc4:	00113023          	sd	ra,0(sp)
    80006cc8:	00213423          	sd	sp,8(sp)
    80006ccc:	00313823          	sd	gp,16(sp)
    80006cd0:	00413c23          	sd	tp,24(sp)
    80006cd4:	02513023          	sd	t0,32(sp)
    80006cd8:	02613423          	sd	t1,40(sp)
    80006cdc:	02713823          	sd	t2,48(sp)
    80006ce0:	02813c23          	sd	s0,56(sp)
    80006ce4:	04913023          	sd	s1,64(sp)
    80006ce8:	04a13423          	sd	a0,72(sp)
    80006cec:	04b13823          	sd	a1,80(sp)
    80006cf0:	04c13c23          	sd	a2,88(sp)
    80006cf4:	06d13023          	sd	a3,96(sp)
    80006cf8:	06e13423          	sd	a4,104(sp)
    80006cfc:	06f13823          	sd	a5,112(sp)
    80006d00:	07013c23          	sd	a6,120(sp)
    80006d04:	09113023          	sd	a7,128(sp)
    80006d08:	09213423          	sd	s2,136(sp)
    80006d0c:	09313823          	sd	s3,144(sp)
    80006d10:	09413c23          	sd	s4,152(sp)
    80006d14:	0b513023          	sd	s5,160(sp)
    80006d18:	0b613423          	sd	s6,168(sp)
    80006d1c:	0b713823          	sd	s7,176(sp)
    80006d20:	0b813c23          	sd	s8,184(sp)
    80006d24:	0d913023          	sd	s9,192(sp)
    80006d28:	0da13423          	sd	s10,200(sp)
    80006d2c:	0db13823          	sd	s11,208(sp)
    80006d30:	0dc13c23          	sd	t3,216(sp)
    80006d34:	0fd13023          	sd	t4,224(sp)
    80006d38:	0fe13423          	sd	t5,232(sp)
    80006d3c:	0ff13823          	sd	t6,240(sp)
    80006d40:	cc9ff0ef          	jal	ra,80006a08 <kerneltrap>
    80006d44:	00013083          	ld	ra,0(sp)
    80006d48:	00813103          	ld	sp,8(sp)
    80006d4c:	01013183          	ld	gp,16(sp)
    80006d50:	02013283          	ld	t0,32(sp)
    80006d54:	02813303          	ld	t1,40(sp)
    80006d58:	03013383          	ld	t2,48(sp)
    80006d5c:	03813403          	ld	s0,56(sp)
    80006d60:	04013483          	ld	s1,64(sp)
    80006d64:	04813503          	ld	a0,72(sp)
    80006d68:	05013583          	ld	a1,80(sp)
    80006d6c:	05813603          	ld	a2,88(sp)
    80006d70:	06013683          	ld	a3,96(sp)
    80006d74:	06813703          	ld	a4,104(sp)
    80006d78:	07013783          	ld	a5,112(sp)
    80006d7c:	07813803          	ld	a6,120(sp)
    80006d80:	08013883          	ld	a7,128(sp)
    80006d84:	08813903          	ld	s2,136(sp)
    80006d88:	09013983          	ld	s3,144(sp)
    80006d8c:	09813a03          	ld	s4,152(sp)
    80006d90:	0a013a83          	ld	s5,160(sp)
    80006d94:	0a813b03          	ld	s6,168(sp)
    80006d98:	0b013b83          	ld	s7,176(sp)
    80006d9c:	0b813c03          	ld	s8,184(sp)
    80006da0:	0c013c83          	ld	s9,192(sp)
    80006da4:	0c813d03          	ld	s10,200(sp)
    80006da8:	0d013d83          	ld	s11,208(sp)
    80006dac:	0d813e03          	ld	t3,216(sp)
    80006db0:	0e013e83          	ld	t4,224(sp)
    80006db4:	0e813f03          	ld	t5,232(sp)
    80006db8:	0f013f83          	ld	t6,240(sp)
    80006dbc:	10010113          	addi	sp,sp,256
    80006dc0:	10200073          	sret
    80006dc4:	00000013          	nop
    80006dc8:	00000013          	nop
    80006dcc:	00000013          	nop

0000000080006dd0 <timervec>:
    80006dd0:	34051573          	csrrw	a0,mscratch,a0
    80006dd4:	00b53023          	sd	a1,0(a0)
    80006dd8:	00c53423          	sd	a2,8(a0)
    80006ddc:	00d53823          	sd	a3,16(a0)
    80006de0:	01853583          	ld	a1,24(a0)
    80006de4:	02053603          	ld	a2,32(a0)
    80006de8:	0005b683          	ld	a3,0(a1)
    80006dec:	00c686b3          	add	a3,a3,a2
    80006df0:	00d5b023          	sd	a3,0(a1)
    80006df4:	00200593          	li	a1,2
    80006df8:	14459073          	csrw	sip,a1
    80006dfc:	01053683          	ld	a3,16(a0)
    80006e00:	00853603          	ld	a2,8(a0)
    80006e04:	00053583          	ld	a1,0(a0)
    80006e08:	34051573          	csrrw	a0,mscratch,a0
    80006e0c:	30200073          	mret

0000000080006e10 <plicinit>:
    80006e10:	ff010113          	addi	sp,sp,-16
    80006e14:	00813423          	sd	s0,8(sp)
    80006e18:	01010413          	addi	s0,sp,16
    80006e1c:	00813403          	ld	s0,8(sp)
    80006e20:	0c0007b7          	lui	a5,0xc000
    80006e24:	00100713          	li	a4,1
    80006e28:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80006e2c:	00e7a223          	sw	a4,4(a5)
    80006e30:	01010113          	addi	sp,sp,16
    80006e34:	00008067          	ret

0000000080006e38 <plicinithart>:
    80006e38:	ff010113          	addi	sp,sp,-16
    80006e3c:	00813023          	sd	s0,0(sp)
    80006e40:	00113423          	sd	ra,8(sp)
    80006e44:	01010413          	addi	s0,sp,16
    80006e48:	00000097          	auipc	ra,0x0
    80006e4c:	a40080e7          	jalr	-1472(ra) # 80006888 <cpuid>
    80006e50:	0085171b          	slliw	a4,a0,0x8
    80006e54:	0c0027b7          	lui	a5,0xc002
    80006e58:	00e787b3          	add	a5,a5,a4
    80006e5c:	40200713          	li	a4,1026
    80006e60:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006e64:	00813083          	ld	ra,8(sp)
    80006e68:	00013403          	ld	s0,0(sp)
    80006e6c:	00d5151b          	slliw	a0,a0,0xd
    80006e70:	0c2017b7          	lui	a5,0xc201
    80006e74:	00a78533          	add	a0,a5,a0
    80006e78:	00052023          	sw	zero,0(a0)
    80006e7c:	01010113          	addi	sp,sp,16
    80006e80:	00008067          	ret

0000000080006e84 <plic_claim>:
    80006e84:	ff010113          	addi	sp,sp,-16
    80006e88:	00813023          	sd	s0,0(sp)
    80006e8c:	00113423          	sd	ra,8(sp)
    80006e90:	01010413          	addi	s0,sp,16
    80006e94:	00000097          	auipc	ra,0x0
    80006e98:	9f4080e7          	jalr	-1548(ra) # 80006888 <cpuid>
    80006e9c:	00813083          	ld	ra,8(sp)
    80006ea0:	00013403          	ld	s0,0(sp)
    80006ea4:	00d5151b          	slliw	a0,a0,0xd
    80006ea8:	0c2017b7          	lui	a5,0xc201
    80006eac:	00a78533          	add	a0,a5,a0
    80006eb0:	00452503          	lw	a0,4(a0)
    80006eb4:	01010113          	addi	sp,sp,16
    80006eb8:	00008067          	ret

0000000080006ebc <plic_complete>:
    80006ebc:	fe010113          	addi	sp,sp,-32
    80006ec0:	00813823          	sd	s0,16(sp)
    80006ec4:	00913423          	sd	s1,8(sp)
    80006ec8:	00113c23          	sd	ra,24(sp)
    80006ecc:	02010413          	addi	s0,sp,32
    80006ed0:	00050493          	mv	s1,a0
    80006ed4:	00000097          	auipc	ra,0x0
    80006ed8:	9b4080e7          	jalr	-1612(ra) # 80006888 <cpuid>
    80006edc:	01813083          	ld	ra,24(sp)
    80006ee0:	01013403          	ld	s0,16(sp)
    80006ee4:	00d5179b          	slliw	a5,a0,0xd
    80006ee8:	0c201737          	lui	a4,0xc201
    80006eec:	00f707b3          	add	a5,a4,a5
    80006ef0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006ef4:	00813483          	ld	s1,8(sp)
    80006ef8:	02010113          	addi	sp,sp,32
    80006efc:	00008067          	ret

0000000080006f00 <consolewrite>:
    80006f00:	fb010113          	addi	sp,sp,-80
    80006f04:	04813023          	sd	s0,64(sp)
    80006f08:	04113423          	sd	ra,72(sp)
    80006f0c:	02913c23          	sd	s1,56(sp)
    80006f10:	03213823          	sd	s2,48(sp)
    80006f14:	03313423          	sd	s3,40(sp)
    80006f18:	03413023          	sd	s4,32(sp)
    80006f1c:	01513c23          	sd	s5,24(sp)
    80006f20:	05010413          	addi	s0,sp,80
    80006f24:	06c05c63          	blez	a2,80006f9c <consolewrite+0x9c>
    80006f28:	00060993          	mv	s3,a2
    80006f2c:	00050a13          	mv	s4,a0
    80006f30:	00058493          	mv	s1,a1
    80006f34:	00000913          	li	s2,0
    80006f38:	fff00a93          	li	s5,-1
    80006f3c:	01c0006f          	j	80006f58 <consolewrite+0x58>
    80006f40:	fbf44503          	lbu	a0,-65(s0)
    80006f44:	0019091b          	addiw	s2,s2,1
    80006f48:	00148493          	addi	s1,s1,1
    80006f4c:	00001097          	auipc	ra,0x1
    80006f50:	a9c080e7          	jalr	-1380(ra) # 800079e8 <uartputc>
    80006f54:	03298063          	beq	s3,s2,80006f74 <consolewrite+0x74>
    80006f58:	00048613          	mv	a2,s1
    80006f5c:	00100693          	li	a3,1
    80006f60:	000a0593          	mv	a1,s4
    80006f64:	fbf40513          	addi	a0,s0,-65
    80006f68:	00000097          	auipc	ra,0x0
    80006f6c:	9d8080e7          	jalr	-1576(ra) # 80006940 <either_copyin>
    80006f70:	fd5518e3          	bne	a0,s5,80006f40 <consolewrite+0x40>
    80006f74:	04813083          	ld	ra,72(sp)
    80006f78:	04013403          	ld	s0,64(sp)
    80006f7c:	03813483          	ld	s1,56(sp)
    80006f80:	02813983          	ld	s3,40(sp)
    80006f84:	02013a03          	ld	s4,32(sp)
    80006f88:	01813a83          	ld	s5,24(sp)
    80006f8c:	00090513          	mv	a0,s2
    80006f90:	03013903          	ld	s2,48(sp)
    80006f94:	05010113          	addi	sp,sp,80
    80006f98:	00008067          	ret
    80006f9c:	00000913          	li	s2,0
    80006fa0:	fd5ff06f          	j	80006f74 <consolewrite+0x74>

0000000080006fa4 <consoleread>:
    80006fa4:	f9010113          	addi	sp,sp,-112
    80006fa8:	06813023          	sd	s0,96(sp)
    80006fac:	04913c23          	sd	s1,88(sp)
    80006fb0:	05213823          	sd	s2,80(sp)
    80006fb4:	05313423          	sd	s3,72(sp)
    80006fb8:	05413023          	sd	s4,64(sp)
    80006fbc:	03513c23          	sd	s5,56(sp)
    80006fc0:	03613823          	sd	s6,48(sp)
    80006fc4:	03713423          	sd	s7,40(sp)
    80006fc8:	03813023          	sd	s8,32(sp)
    80006fcc:	06113423          	sd	ra,104(sp)
    80006fd0:	01913c23          	sd	s9,24(sp)
    80006fd4:	07010413          	addi	s0,sp,112
    80006fd8:	00060b93          	mv	s7,a2
    80006fdc:	00050913          	mv	s2,a0
    80006fe0:	00058c13          	mv	s8,a1
    80006fe4:	00060b1b          	sext.w	s6,a2
    80006fe8:	00006497          	auipc	s1,0x6
    80006fec:	09048493          	addi	s1,s1,144 # 8000d078 <cons>
    80006ff0:	00400993          	li	s3,4
    80006ff4:	fff00a13          	li	s4,-1
    80006ff8:	00a00a93          	li	s5,10
    80006ffc:	05705e63          	blez	s7,80007058 <consoleread+0xb4>
    80007000:	09c4a703          	lw	a4,156(s1)
    80007004:	0984a783          	lw	a5,152(s1)
    80007008:	0007071b          	sext.w	a4,a4
    8000700c:	08e78463          	beq	a5,a4,80007094 <consoleread+0xf0>
    80007010:	07f7f713          	andi	a4,a5,127
    80007014:	00e48733          	add	a4,s1,a4
    80007018:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000701c:	0017869b          	addiw	a3,a5,1
    80007020:	08d4ac23          	sw	a3,152(s1)
    80007024:	00070c9b          	sext.w	s9,a4
    80007028:	0b370663          	beq	a4,s3,800070d4 <consoleread+0x130>
    8000702c:	00100693          	li	a3,1
    80007030:	f9f40613          	addi	a2,s0,-97
    80007034:	000c0593          	mv	a1,s8
    80007038:	00090513          	mv	a0,s2
    8000703c:	f8e40fa3          	sb	a4,-97(s0)
    80007040:	00000097          	auipc	ra,0x0
    80007044:	8b4080e7          	jalr	-1868(ra) # 800068f4 <either_copyout>
    80007048:	01450863          	beq	a0,s4,80007058 <consoleread+0xb4>
    8000704c:	001c0c13          	addi	s8,s8,1
    80007050:	fffb8b9b          	addiw	s7,s7,-1
    80007054:	fb5c94e3          	bne	s9,s5,80006ffc <consoleread+0x58>
    80007058:	000b851b          	sext.w	a0,s7
    8000705c:	06813083          	ld	ra,104(sp)
    80007060:	06013403          	ld	s0,96(sp)
    80007064:	05813483          	ld	s1,88(sp)
    80007068:	05013903          	ld	s2,80(sp)
    8000706c:	04813983          	ld	s3,72(sp)
    80007070:	04013a03          	ld	s4,64(sp)
    80007074:	03813a83          	ld	s5,56(sp)
    80007078:	02813b83          	ld	s7,40(sp)
    8000707c:	02013c03          	ld	s8,32(sp)
    80007080:	01813c83          	ld	s9,24(sp)
    80007084:	40ab053b          	subw	a0,s6,a0
    80007088:	03013b03          	ld	s6,48(sp)
    8000708c:	07010113          	addi	sp,sp,112
    80007090:	00008067          	ret
    80007094:	00001097          	auipc	ra,0x1
    80007098:	1d8080e7          	jalr	472(ra) # 8000826c <push_on>
    8000709c:	0984a703          	lw	a4,152(s1)
    800070a0:	09c4a783          	lw	a5,156(s1)
    800070a4:	0007879b          	sext.w	a5,a5
    800070a8:	fef70ce3          	beq	a4,a5,800070a0 <consoleread+0xfc>
    800070ac:	00001097          	auipc	ra,0x1
    800070b0:	234080e7          	jalr	564(ra) # 800082e0 <pop_on>
    800070b4:	0984a783          	lw	a5,152(s1)
    800070b8:	07f7f713          	andi	a4,a5,127
    800070bc:	00e48733          	add	a4,s1,a4
    800070c0:	01874703          	lbu	a4,24(a4)
    800070c4:	0017869b          	addiw	a3,a5,1
    800070c8:	08d4ac23          	sw	a3,152(s1)
    800070cc:	00070c9b          	sext.w	s9,a4
    800070d0:	f5371ee3          	bne	a4,s3,8000702c <consoleread+0x88>
    800070d4:	000b851b          	sext.w	a0,s7
    800070d8:	f96bf2e3          	bgeu	s7,s6,8000705c <consoleread+0xb8>
    800070dc:	08f4ac23          	sw	a5,152(s1)
    800070e0:	f7dff06f          	j	8000705c <consoleread+0xb8>

00000000800070e4 <consputc>:
    800070e4:	10000793          	li	a5,256
    800070e8:	00f50663          	beq	a0,a5,800070f4 <consputc+0x10>
    800070ec:	00001317          	auipc	t1,0x1
    800070f0:	9f430067          	jr	-1548(t1) # 80007ae0 <uartputc_sync>
    800070f4:	ff010113          	addi	sp,sp,-16
    800070f8:	00113423          	sd	ra,8(sp)
    800070fc:	00813023          	sd	s0,0(sp)
    80007100:	01010413          	addi	s0,sp,16
    80007104:	00800513          	li	a0,8
    80007108:	00001097          	auipc	ra,0x1
    8000710c:	9d8080e7          	jalr	-1576(ra) # 80007ae0 <uartputc_sync>
    80007110:	02000513          	li	a0,32
    80007114:	00001097          	auipc	ra,0x1
    80007118:	9cc080e7          	jalr	-1588(ra) # 80007ae0 <uartputc_sync>
    8000711c:	00013403          	ld	s0,0(sp)
    80007120:	00813083          	ld	ra,8(sp)
    80007124:	00800513          	li	a0,8
    80007128:	01010113          	addi	sp,sp,16
    8000712c:	00001317          	auipc	t1,0x1
    80007130:	9b430067          	jr	-1612(t1) # 80007ae0 <uartputc_sync>

0000000080007134 <consoleintr>:
    80007134:	fe010113          	addi	sp,sp,-32
    80007138:	00813823          	sd	s0,16(sp)
    8000713c:	00913423          	sd	s1,8(sp)
    80007140:	01213023          	sd	s2,0(sp)
    80007144:	00113c23          	sd	ra,24(sp)
    80007148:	02010413          	addi	s0,sp,32
    8000714c:	00006917          	auipc	s2,0x6
    80007150:	f2c90913          	addi	s2,s2,-212 # 8000d078 <cons>
    80007154:	00050493          	mv	s1,a0
    80007158:	00090513          	mv	a0,s2
    8000715c:	00001097          	auipc	ra,0x1
    80007160:	e40080e7          	jalr	-448(ra) # 80007f9c <acquire>
    80007164:	02048c63          	beqz	s1,8000719c <consoleintr+0x68>
    80007168:	0a092783          	lw	a5,160(s2)
    8000716c:	09892703          	lw	a4,152(s2)
    80007170:	07f00693          	li	a3,127
    80007174:	40e7873b          	subw	a4,a5,a4
    80007178:	02e6e263          	bltu	a3,a4,8000719c <consoleintr+0x68>
    8000717c:	00d00713          	li	a4,13
    80007180:	04e48063          	beq	s1,a4,800071c0 <consoleintr+0x8c>
    80007184:	07f7f713          	andi	a4,a5,127
    80007188:	00e90733          	add	a4,s2,a4
    8000718c:	0017879b          	addiw	a5,a5,1
    80007190:	0af92023          	sw	a5,160(s2)
    80007194:	00970c23          	sb	s1,24(a4)
    80007198:	08f92e23          	sw	a5,156(s2)
    8000719c:	01013403          	ld	s0,16(sp)
    800071a0:	01813083          	ld	ra,24(sp)
    800071a4:	00813483          	ld	s1,8(sp)
    800071a8:	00013903          	ld	s2,0(sp)
    800071ac:	00006517          	auipc	a0,0x6
    800071b0:	ecc50513          	addi	a0,a0,-308 # 8000d078 <cons>
    800071b4:	02010113          	addi	sp,sp,32
    800071b8:	00001317          	auipc	t1,0x1
    800071bc:	eb030067          	jr	-336(t1) # 80008068 <release>
    800071c0:	00a00493          	li	s1,10
    800071c4:	fc1ff06f          	j	80007184 <consoleintr+0x50>

00000000800071c8 <consoleinit>:
    800071c8:	fe010113          	addi	sp,sp,-32
    800071cc:	00113c23          	sd	ra,24(sp)
    800071d0:	00813823          	sd	s0,16(sp)
    800071d4:	00913423          	sd	s1,8(sp)
    800071d8:	02010413          	addi	s0,sp,32
    800071dc:	00006497          	auipc	s1,0x6
    800071e0:	e9c48493          	addi	s1,s1,-356 # 8000d078 <cons>
    800071e4:	00048513          	mv	a0,s1
    800071e8:	00002597          	auipc	a1,0x2
    800071ec:	6a058593          	addi	a1,a1,1696 # 80009888 <CONSOLE_STATUS+0x878>
    800071f0:	00001097          	auipc	ra,0x1
    800071f4:	d88080e7          	jalr	-632(ra) # 80007f78 <initlock>
    800071f8:	00000097          	auipc	ra,0x0
    800071fc:	7ac080e7          	jalr	1964(ra) # 800079a4 <uartinit>
    80007200:	01813083          	ld	ra,24(sp)
    80007204:	01013403          	ld	s0,16(sp)
    80007208:	00000797          	auipc	a5,0x0
    8000720c:	d9c78793          	addi	a5,a5,-612 # 80006fa4 <consoleread>
    80007210:	0af4bc23          	sd	a5,184(s1)
    80007214:	00000797          	auipc	a5,0x0
    80007218:	cec78793          	addi	a5,a5,-788 # 80006f00 <consolewrite>
    8000721c:	0cf4b023          	sd	a5,192(s1)
    80007220:	00813483          	ld	s1,8(sp)
    80007224:	02010113          	addi	sp,sp,32
    80007228:	00008067          	ret

000000008000722c <console_read>:
    8000722c:	ff010113          	addi	sp,sp,-16
    80007230:	00813423          	sd	s0,8(sp)
    80007234:	01010413          	addi	s0,sp,16
    80007238:	00813403          	ld	s0,8(sp)
    8000723c:	00006317          	auipc	t1,0x6
    80007240:	ef433303          	ld	t1,-268(t1) # 8000d130 <devsw+0x10>
    80007244:	01010113          	addi	sp,sp,16
    80007248:	00030067          	jr	t1

000000008000724c <console_write>:
    8000724c:	ff010113          	addi	sp,sp,-16
    80007250:	00813423          	sd	s0,8(sp)
    80007254:	01010413          	addi	s0,sp,16
    80007258:	00813403          	ld	s0,8(sp)
    8000725c:	00006317          	auipc	t1,0x6
    80007260:	edc33303          	ld	t1,-292(t1) # 8000d138 <devsw+0x18>
    80007264:	01010113          	addi	sp,sp,16
    80007268:	00030067          	jr	t1

000000008000726c <panic>:
    8000726c:	fe010113          	addi	sp,sp,-32
    80007270:	00113c23          	sd	ra,24(sp)
    80007274:	00813823          	sd	s0,16(sp)
    80007278:	00913423          	sd	s1,8(sp)
    8000727c:	02010413          	addi	s0,sp,32
    80007280:	00050493          	mv	s1,a0
    80007284:	00002517          	auipc	a0,0x2
    80007288:	60c50513          	addi	a0,a0,1548 # 80009890 <CONSOLE_STATUS+0x880>
    8000728c:	00006797          	auipc	a5,0x6
    80007290:	f407a623          	sw	zero,-180(a5) # 8000d1d8 <pr+0x18>
    80007294:	00000097          	auipc	ra,0x0
    80007298:	034080e7          	jalr	52(ra) # 800072c8 <__printf>
    8000729c:	00048513          	mv	a0,s1
    800072a0:	00000097          	auipc	ra,0x0
    800072a4:	028080e7          	jalr	40(ra) # 800072c8 <__printf>
    800072a8:	00002517          	auipc	a0,0x2
    800072ac:	0b850513          	addi	a0,a0,184 # 80009360 <CONSOLE_STATUS+0x350>
    800072b0:	00000097          	auipc	ra,0x0
    800072b4:	018080e7          	jalr	24(ra) # 800072c8 <__printf>
    800072b8:	00100793          	li	a5,1
    800072bc:	00005717          	auipc	a4,0x5
    800072c0:	a4f72e23          	sw	a5,-1444(a4) # 8000bd18 <panicked>
    800072c4:	0000006f          	j	800072c4 <panic+0x58>

00000000800072c8 <__printf>:
    800072c8:	f3010113          	addi	sp,sp,-208
    800072cc:	08813023          	sd	s0,128(sp)
    800072d0:	07313423          	sd	s3,104(sp)
    800072d4:	09010413          	addi	s0,sp,144
    800072d8:	05813023          	sd	s8,64(sp)
    800072dc:	08113423          	sd	ra,136(sp)
    800072e0:	06913c23          	sd	s1,120(sp)
    800072e4:	07213823          	sd	s2,112(sp)
    800072e8:	07413023          	sd	s4,96(sp)
    800072ec:	05513c23          	sd	s5,88(sp)
    800072f0:	05613823          	sd	s6,80(sp)
    800072f4:	05713423          	sd	s7,72(sp)
    800072f8:	03913c23          	sd	s9,56(sp)
    800072fc:	03a13823          	sd	s10,48(sp)
    80007300:	03b13423          	sd	s11,40(sp)
    80007304:	00006317          	auipc	t1,0x6
    80007308:	ebc30313          	addi	t1,t1,-324 # 8000d1c0 <pr>
    8000730c:	01832c03          	lw	s8,24(t1)
    80007310:	00b43423          	sd	a1,8(s0)
    80007314:	00c43823          	sd	a2,16(s0)
    80007318:	00d43c23          	sd	a3,24(s0)
    8000731c:	02e43023          	sd	a4,32(s0)
    80007320:	02f43423          	sd	a5,40(s0)
    80007324:	03043823          	sd	a6,48(s0)
    80007328:	03143c23          	sd	a7,56(s0)
    8000732c:	00050993          	mv	s3,a0
    80007330:	4a0c1663          	bnez	s8,800077dc <__printf+0x514>
    80007334:	60098c63          	beqz	s3,8000794c <__printf+0x684>
    80007338:	0009c503          	lbu	a0,0(s3)
    8000733c:	00840793          	addi	a5,s0,8
    80007340:	f6f43c23          	sd	a5,-136(s0)
    80007344:	00000493          	li	s1,0
    80007348:	22050063          	beqz	a0,80007568 <__printf+0x2a0>
    8000734c:	00002a37          	lui	s4,0x2
    80007350:	00018ab7          	lui	s5,0x18
    80007354:	000f4b37          	lui	s6,0xf4
    80007358:	00989bb7          	lui	s7,0x989
    8000735c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007360:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007364:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007368:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000736c:	00148c9b          	addiw	s9,s1,1
    80007370:	02500793          	li	a5,37
    80007374:	01998933          	add	s2,s3,s9
    80007378:	38f51263          	bne	a0,a5,800076fc <__printf+0x434>
    8000737c:	00094783          	lbu	a5,0(s2)
    80007380:	00078c9b          	sext.w	s9,a5
    80007384:	1e078263          	beqz	a5,80007568 <__printf+0x2a0>
    80007388:	0024849b          	addiw	s1,s1,2
    8000738c:	07000713          	li	a4,112
    80007390:	00998933          	add	s2,s3,s1
    80007394:	38e78a63          	beq	a5,a4,80007728 <__printf+0x460>
    80007398:	20f76863          	bltu	a4,a5,800075a8 <__printf+0x2e0>
    8000739c:	42a78863          	beq	a5,a0,800077cc <__printf+0x504>
    800073a0:	06400713          	li	a4,100
    800073a4:	40e79663          	bne	a5,a4,800077b0 <__printf+0x4e8>
    800073a8:	f7843783          	ld	a5,-136(s0)
    800073ac:	0007a603          	lw	a2,0(a5)
    800073b0:	00878793          	addi	a5,a5,8
    800073b4:	f6f43c23          	sd	a5,-136(s0)
    800073b8:	42064a63          	bltz	a2,800077ec <__printf+0x524>
    800073bc:	00a00713          	li	a4,10
    800073c0:	02e677bb          	remuw	a5,a2,a4
    800073c4:	00002d97          	auipc	s11,0x2
    800073c8:	4f4d8d93          	addi	s11,s11,1268 # 800098b8 <digits>
    800073cc:	00900593          	li	a1,9
    800073d0:	0006051b          	sext.w	a0,a2
    800073d4:	00000c93          	li	s9,0
    800073d8:	02079793          	slli	a5,a5,0x20
    800073dc:	0207d793          	srli	a5,a5,0x20
    800073e0:	00fd87b3          	add	a5,s11,a5
    800073e4:	0007c783          	lbu	a5,0(a5)
    800073e8:	02e656bb          	divuw	a3,a2,a4
    800073ec:	f8f40023          	sb	a5,-128(s0)
    800073f0:	14c5d863          	bge	a1,a2,80007540 <__printf+0x278>
    800073f4:	06300593          	li	a1,99
    800073f8:	00100c93          	li	s9,1
    800073fc:	02e6f7bb          	remuw	a5,a3,a4
    80007400:	02079793          	slli	a5,a5,0x20
    80007404:	0207d793          	srli	a5,a5,0x20
    80007408:	00fd87b3          	add	a5,s11,a5
    8000740c:	0007c783          	lbu	a5,0(a5)
    80007410:	02e6d73b          	divuw	a4,a3,a4
    80007414:	f8f400a3          	sb	a5,-127(s0)
    80007418:	12a5f463          	bgeu	a1,a0,80007540 <__printf+0x278>
    8000741c:	00a00693          	li	a3,10
    80007420:	00900593          	li	a1,9
    80007424:	02d777bb          	remuw	a5,a4,a3
    80007428:	02079793          	slli	a5,a5,0x20
    8000742c:	0207d793          	srli	a5,a5,0x20
    80007430:	00fd87b3          	add	a5,s11,a5
    80007434:	0007c503          	lbu	a0,0(a5)
    80007438:	02d757bb          	divuw	a5,a4,a3
    8000743c:	f8a40123          	sb	a0,-126(s0)
    80007440:	48e5f263          	bgeu	a1,a4,800078c4 <__printf+0x5fc>
    80007444:	06300513          	li	a0,99
    80007448:	02d7f5bb          	remuw	a1,a5,a3
    8000744c:	02059593          	slli	a1,a1,0x20
    80007450:	0205d593          	srli	a1,a1,0x20
    80007454:	00bd85b3          	add	a1,s11,a1
    80007458:	0005c583          	lbu	a1,0(a1)
    8000745c:	02d7d7bb          	divuw	a5,a5,a3
    80007460:	f8b401a3          	sb	a1,-125(s0)
    80007464:	48e57263          	bgeu	a0,a4,800078e8 <__printf+0x620>
    80007468:	3e700513          	li	a0,999
    8000746c:	02d7f5bb          	remuw	a1,a5,a3
    80007470:	02059593          	slli	a1,a1,0x20
    80007474:	0205d593          	srli	a1,a1,0x20
    80007478:	00bd85b3          	add	a1,s11,a1
    8000747c:	0005c583          	lbu	a1,0(a1)
    80007480:	02d7d7bb          	divuw	a5,a5,a3
    80007484:	f8b40223          	sb	a1,-124(s0)
    80007488:	46e57663          	bgeu	a0,a4,800078f4 <__printf+0x62c>
    8000748c:	02d7f5bb          	remuw	a1,a5,a3
    80007490:	02059593          	slli	a1,a1,0x20
    80007494:	0205d593          	srli	a1,a1,0x20
    80007498:	00bd85b3          	add	a1,s11,a1
    8000749c:	0005c583          	lbu	a1,0(a1)
    800074a0:	02d7d7bb          	divuw	a5,a5,a3
    800074a4:	f8b402a3          	sb	a1,-123(s0)
    800074a8:	46ea7863          	bgeu	s4,a4,80007918 <__printf+0x650>
    800074ac:	02d7f5bb          	remuw	a1,a5,a3
    800074b0:	02059593          	slli	a1,a1,0x20
    800074b4:	0205d593          	srli	a1,a1,0x20
    800074b8:	00bd85b3          	add	a1,s11,a1
    800074bc:	0005c583          	lbu	a1,0(a1)
    800074c0:	02d7d7bb          	divuw	a5,a5,a3
    800074c4:	f8b40323          	sb	a1,-122(s0)
    800074c8:	3eeaf863          	bgeu	s5,a4,800078b8 <__printf+0x5f0>
    800074cc:	02d7f5bb          	remuw	a1,a5,a3
    800074d0:	02059593          	slli	a1,a1,0x20
    800074d4:	0205d593          	srli	a1,a1,0x20
    800074d8:	00bd85b3          	add	a1,s11,a1
    800074dc:	0005c583          	lbu	a1,0(a1)
    800074e0:	02d7d7bb          	divuw	a5,a5,a3
    800074e4:	f8b403a3          	sb	a1,-121(s0)
    800074e8:	42eb7e63          	bgeu	s6,a4,80007924 <__printf+0x65c>
    800074ec:	02d7f5bb          	remuw	a1,a5,a3
    800074f0:	02059593          	slli	a1,a1,0x20
    800074f4:	0205d593          	srli	a1,a1,0x20
    800074f8:	00bd85b3          	add	a1,s11,a1
    800074fc:	0005c583          	lbu	a1,0(a1)
    80007500:	02d7d7bb          	divuw	a5,a5,a3
    80007504:	f8b40423          	sb	a1,-120(s0)
    80007508:	42ebfc63          	bgeu	s7,a4,80007940 <__printf+0x678>
    8000750c:	02079793          	slli	a5,a5,0x20
    80007510:	0207d793          	srli	a5,a5,0x20
    80007514:	00fd8db3          	add	s11,s11,a5
    80007518:	000dc703          	lbu	a4,0(s11)
    8000751c:	00a00793          	li	a5,10
    80007520:	00900c93          	li	s9,9
    80007524:	f8e404a3          	sb	a4,-119(s0)
    80007528:	00065c63          	bgez	a2,80007540 <__printf+0x278>
    8000752c:	f9040713          	addi	a4,s0,-112
    80007530:	00f70733          	add	a4,a4,a5
    80007534:	02d00693          	li	a3,45
    80007538:	fed70823          	sb	a3,-16(a4)
    8000753c:	00078c93          	mv	s9,a5
    80007540:	f8040793          	addi	a5,s0,-128
    80007544:	01978cb3          	add	s9,a5,s9
    80007548:	f7f40d13          	addi	s10,s0,-129
    8000754c:	000cc503          	lbu	a0,0(s9)
    80007550:	fffc8c93          	addi	s9,s9,-1
    80007554:	00000097          	auipc	ra,0x0
    80007558:	b90080e7          	jalr	-1136(ra) # 800070e4 <consputc>
    8000755c:	ffac98e3          	bne	s9,s10,8000754c <__printf+0x284>
    80007560:	00094503          	lbu	a0,0(s2)
    80007564:	e00514e3          	bnez	a0,8000736c <__printf+0xa4>
    80007568:	1a0c1663          	bnez	s8,80007714 <__printf+0x44c>
    8000756c:	08813083          	ld	ra,136(sp)
    80007570:	08013403          	ld	s0,128(sp)
    80007574:	07813483          	ld	s1,120(sp)
    80007578:	07013903          	ld	s2,112(sp)
    8000757c:	06813983          	ld	s3,104(sp)
    80007580:	06013a03          	ld	s4,96(sp)
    80007584:	05813a83          	ld	s5,88(sp)
    80007588:	05013b03          	ld	s6,80(sp)
    8000758c:	04813b83          	ld	s7,72(sp)
    80007590:	04013c03          	ld	s8,64(sp)
    80007594:	03813c83          	ld	s9,56(sp)
    80007598:	03013d03          	ld	s10,48(sp)
    8000759c:	02813d83          	ld	s11,40(sp)
    800075a0:	0d010113          	addi	sp,sp,208
    800075a4:	00008067          	ret
    800075a8:	07300713          	li	a4,115
    800075ac:	1ce78a63          	beq	a5,a4,80007780 <__printf+0x4b8>
    800075b0:	07800713          	li	a4,120
    800075b4:	1ee79e63          	bne	a5,a4,800077b0 <__printf+0x4e8>
    800075b8:	f7843783          	ld	a5,-136(s0)
    800075bc:	0007a703          	lw	a4,0(a5)
    800075c0:	00878793          	addi	a5,a5,8
    800075c4:	f6f43c23          	sd	a5,-136(s0)
    800075c8:	28074263          	bltz	a4,8000784c <__printf+0x584>
    800075cc:	00002d97          	auipc	s11,0x2
    800075d0:	2ecd8d93          	addi	s11,s11,748 # 800098b8 <digits>
    800075d4:	00f77793          	andi	a5,a4,15
    800075d8:	00fd87b3          	add	a5,s11,a5
    800075dc:	0007c683          	lbu	a3,0(a5)
    800075e0:	00f00613          	li	a2,15
    800075e4:	0007079b          	sext.w	a5,a4
    800075e8:	f8d40023          	sb	a3,-128(s0)
    800075ec:	0047559b          	srliw	a1,a4,0x4
    800075f0:	0047569b          	srliw	a3,a4,0x4
    800075f4:	00000c93          	li	s9,0
    800075f8:	0ee65063          	bge	a2,a4,800076d8 <__printf+0x410>
    800075fc:	00f6f693          	andi	a3,a3,15
    80007600:	00dd86b3          	add	a3,s11,a3
    80007604:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007608:	0087d79b          	srliw	a5,a5,0x8
    8000760c:	00100c93          	li	s9,1
    80007610:	f8d400a3          	sb	a3,-127(s0)
    80007614:	0cb67263          	bgeu	a2,a1,800076d8 <__printf+0x410>
    80007618:	00f7f693          	andi	a3,a5,15
    8000761c:	00dd86b3          	add	a3,s11,a3
    80007620:	0006c583          	lbu	a1,0(a3)
    80007624:	00f00613          	li	a2,15
    80007628:	0047d69b          	srliw	a3,a5,0x4
    8000762c:	f8b40123          	sb	a1,-126(s0)
    80007630:	0047d593          	srli	a1,a5,0x4
    80007634:	28f67e63          	bgeu	a2,a5,800078d0 <__printf+0x608>
    80007638:	00f6f693          	andi	a3,a3,15
    8000763c:	00dd86b3          	add	a3,s11,a3
    80007640:	0006c503          	lbu	a0,0(a3)
    80007644:	0087d813          	srli	a6,a5,0x8
    80007648:	0087d69b          	srliw	a3,a5,0x8
    8000764c:	f8a401a3          	sb	a0,-125(s0)
    80007650:	28b67663          	bgeu	a2,a1,800078dc <__printf+0x614>
    80007654:	00f6f693          	andi	a3,a3,15
    80007658:	00dd86b3          	add	a3,s11,a3
    8000765c:	0006c583          	lbu	a1,0(a3)
    80007660:	00c7d513          	srli	a0,a5,0xc
    80007664:	00c7d69b          	srliw	a3,a5,0xc
    80007668:	f8b40223          	sb	a1,-124(s0)
    8000766c:	29067a63          	bgeu	a2,a6,80007900 <__printf+0x638>
    80007670:	00f6f693          	andi	a3,a3,15
    80007674:	00dd86b3          	add	a3,s11,a3
    80007678:	0006c583          	lbu	a1,0(a3)
    8000767c:	0107d813          	srli	a6,a5,0x10
    80007680:	0107d69b          	srliw	a3,a5,0x10
    80007684:	f8b402a3          	sb	a1,-123(s0)
    80007688:	28a67263          	bgeu	a2,a0,8000790c <__printf+0x644>
    8000768c:	00f6f693          	andi	a3,a3,15
    80007690:	00dd86b3          	add	a3,s11,a3
    80007694:	0006c683          	lbu	a3,0(a3)
    80007698:	0147d79b          	srliw	a5,a5,0x14
    8000769c:	f8d40323          	sb	a3,-122(s0)
    800076a0:	21067663          	bgeu	a2,a6,800078ac <__printf+0x5e4>
    800076a4:	02079793          	slli	a5,a5,0x20
    800076a8:	0207d793          	srli	a5,a5,0x20
    800076ac:	00fd8db3          	add	s11,s11,a5
    800076b0:	000dc683          	lbu	a3,0(s11)
    800076b4:	00800793          	li	a5,8
    800076b8:	00700c93          	li	s9,7
    800076bc:	f8d403a3          	sb	a3,-121(s0)
    800076c0:	00075c63          	bgez	a4,800076d8 <__printf+0x410>
    800076c4:	f9040713          	addi	a4,s0,-112
    800076c8:	00f70733          	add	a4,a4,a5
    800076cc:	02d00693          	li	a3,45
    800076d0:	fed70823          	sb	a3,-16(a4)
    800076d4:	00078c93          	mv	s9,a5
    800076d8:	f8040793          	addi	a5,s0,-128
    800076dc:	01978cb3          	add	s9,a5,s9
    800076e0:	f7f40d13          	addi	s10,s0,-129
    800076e4:	000cc503          	lbu	a0,0(s9)
    800076e8:	fffc8c93          	addi	s9,s9,-1
    800076ec:	00000097          	auipc	ra,0x0
    800076f0:	9f8080e7          	jalr	-1544(ra) # 800070e4 <consputc>
    800076f4:	ff9d18e3          	bne	s10,s9,800076e4 <__printf+0x41c>
    800076f8:	0100006f          	j	80007708 <__printf+0x440>
    800076fc:	00000097          	auipc	ra,0x0
    80007700:	9e8080e7          	jalr	-1560(ra) # 800070e4 <consputc>
    80007704:	000c8493          	mv	s1,s9
    80007708:	00094503          	lbu	a0,0(s2)
    8000770c:	c60510e3          	bnez	a0,8000736c <__printf+0xa4>
    80007710:	e40c0ee3          	beqz	s8,8000756c <__printf+0x2a4>
    80007714:	00006517          	auipc	a0,0x6
    80007718:	aac50513          	addi	a0,a0,-1364 # 8000d1c0 <pr>
    8000771c:	00001097          	auipc	ra,0x1
    80007720:	94c080e7          	jalr	-1716(ra) # 80008068 <release>
    80007724:	e49ff06f          	j	8000756c <__printf+0x2a4>
    80007728:	f7843783          	ld	a5,-136(s0)
    8000772c:	03000513          	li	a0,48
    80007730:	01000d13          	li	s10,16
    80007734:	00878713          	addi	a4,a5,8
    80007738:	0007bc83          	ld	s9,0(a5)
    8000773c:	f6e43c23          	sd	a4,-136(s0)
    80007740:	00000097          	auipc	ra,0x0
    80007744:	9a4080e7          	jalr	-1628(ra) # 800070e4 <consputc>
    80007748:	07800513          	li	a0,120
    8000774c:	00000097          	auipc	ra,0x0
    80007750:	998080e7          	jalr	-1640(ra) # 800070e4 <consputc>
    80007754:	00002d97          	auipc	s11,0x2
    80007758:	164d8d93          	addi	s11,s11,356 # 800098b8 <digits>
    8000775c:	03ccd793          	srli	a5,s9,0x3c
    80007760:	00fd87b3          	add	a5,s11,a5
    80007764:	0007c503          	lbu	a0,0(a5)
    80007768:	fffd0d1b          	addiw	s10,s10,-1
    8000776c:	004c9c93          	slli	s9,s9,0x4
    80007770:	00000097          	auipc	ra,0x0
    80007774:	974080e7          	jalr	-1676(ra) # 800070e4 <consputc>
    80007778:	fe0d12e3          	bnez	s10,8000775c <__printf+0x494>
    8000777c:	f8dff06f          	j	80007708 <__printf+0x440>
    80007780:	f7843783          	ld	a5,-136(s0)
    80007784:	0007bc83          	ld	s9,0(a5)
    80007788:	00878793          	addi	a5,a5,8
    8000778c:	f6f43c23          	sd	a5,-136(s0)
    80007790:	000c9a63          	bnez	s9,800077a4 <__printf+0x4dc>
    80007794:	1080006f          	j	8000789c <__printf+0x5d4>
    80007798:	001c8c93          	addi	s9,s9,1
    8000779c:	00000097          	auipc	ra,0x0
    800077a0:	948080e7          	jalr	-1720(ra) # 800070e4 <consputc>
    800077a4:	000cc503          	lbu	a0,0(s9)
    800077a8:	fe0518e3          	bnez	a0,80007798 <__printf+0x4d0>
    800077ac:	f5dff06f          	j	80007708 <__printf+0x440>
    800077b0:	02500513          	li	a0,37
    800077b4:	00000097          	auipc	ra,0x0
    800077b8:	930080e7          	jalr	-1744(ra) # 800070e4 <consputc>
    800077bc:	000c8513          	mv	a0,s9
    800077c0:	00000097          	auipc	ra,0x0
    800077c4:	924080e7          	jalr	-1756(ra) # 800070e4 <consputc>
    800077c8:	f41ff06f          	j	80007708 <__printf+0x440>
    800077cc:	02500513          	li	a0,37
    800077d0:	00000097          	auipc	ra,0x0
    800077d4:	914080e7          	jalr	-1772(ra) # 800070e4 <consputc>
    800077d8:	f31ff06f          	j	80007708 <__printf+0x440>
    800077dc:	00030513          	mv	a0,t1
    800077e0:	00000097          	auipc	ra,0x0
    800077e4:	7bc080e7          	jalr	1980(ra) # 80007f9c <acquire>
    800077e8:	b4dff06f          	j	80007334 <__printf+0x6c>
    800077ec:	40c0053b          	negw	a0,a2
    800077f0:	00a00713          	li	a4,10
    800077f4:	02e576bb          	remuw	a3,a0,a4
    800077f8:	00002d97          	auipc	s11,0x2
    800077fc:	0c0d8d93          	addi	s11,s11,192 # 800098b8 <digits>
    80007800:	ff700593          	li	a1,-9
    80007804:	02069693          	slli	a3,a3,0x20
    80007808:	0206d693          	srli	a3,a3,0x20
    8000780c:	00dd86b3          	add	a3,s11,a3
    80007810:	0006c683          	lbu	a3,0(a3)
    80007814:	02e557bb          	divuw	a5,a0,a4
    80007818:	f8d40023          	sb	a3,-128(s0)
    8000781c:	10b65e63          	bge	a2,a1,80007938 <__printf+0x670>
    80007820:	06300593          	li	a1,99
    80007824:	02e7f6bb          	remuw	a3,a5,a4
    80007828:	02069693          	slli	a3,a3,0x20
    8000782c:	0206d693          	srli	a3,a3,0x20
    80007830:	00dd86b3          	add	a3,s11,a3
    80007834:	0006c683          	lbu	a3,0(a3)
    80007838:	02e7d73b          	divuw	a4,a5,a4
    8000783c:	00200793          	li	a5,2
    80007840:	f8d400a3          	sb	a3,-127(s0)
    80007844:	bca5ece3          	bltu	a1,a0,8000741c <__printf+0x154>
    80007848:	ce5ff06f          	j	8000752c <__printf+0x264>
    8000784c:	40e007bb          	negw	a5,a4
    80007850:	00002d97          	auipc	s11,0x2
    80007854:	068d8d93          	addi	s11,s11,104 # 800098b8 <digits>
    80007858:	00f7f693          	andi	a3,a5,15
    8000785c:	00dd86b3          	add	a3,s11,a3
    80007860:	0006c583          	lbu	a1,0(a3)
    80007864:	ff100613          	li	a2,-15
    80007868:	0047d69b          	srliw	a3,a5,0x4
    8000786c:	f8b40023          	sb	a1,-128(s0)
    80007870:	0047d59b          	srliw	a1,a5,0x4
    80007874:	0ac75e63          	bge	a4,a2,80007930 <__printf+0x668>
    80007878:	00f6f693          	andi	a3,a3,15
    8000787c:	00dd86b3          	add	a3,s11,a3
    80007880:	0006c603          	lbu	a2,0(a3)
    80007884:	00f00693          	li	a3,15
    80007888:	0087d79b          	srliw	a5,a5,0x8
    8000788c:	f8c400a3          	sb	a2,-127(s0)
    80007890:	d8b6e4e3          	bltu	a3,a1,80007618 <__printf+0x350>
    80007894:	00200793          	li	a5,2
    80007898:	e2dff06f          	j	800076c4 <__printf+0x3fc>
    8000789c:	00002c97          	auipc	s9,0x2
    800078a0:	ffcc8c93          	addi	s9,s9,-4 # 80009898 <CONSOLE_STATUS+0x888>
    800078a4:	02800513          	li	a0,40
    800078a8:	ef1ff06f          	j	80007798 <__printf+0x4d0>
    800078ac:	00700793          	li	a5,7
    800078b0:	00600c93          	li	s9,6
    800078b4:	e0dff06f          	j	800076c0 <__printf+0x3f8>
    800078b8:	00700793          	li	a5,7
    800078bc:	00600c93          	li	s9,6
    800078c0:	c69ff06f          	j	80007528 <__printf+0x260>
    800078c4:	00300793          	li	a5,3
    800078c8:	00200c93          	li	s9,2
    800078cc:	c5dff06f          	j	80007528 <__printf+0x260>
    800078d0:	00300793          	li	a5,3
    800078d4:	00200c93          	li	s9,2
    800078d8:	de9ff06f          	j	800076c0 <__printf+0x3f8>
    800078dc:	00400793          	li	a5,4
    800078e0:	00300c93          	li	s9,3
    800078e4:	dddff06f          	j	800076c0 <__printf+0x3f8>
    800078e8:	00400793          	li	a5,4
    800078ec:	00300c93          	li	s9,3
    800078f0:	c39ff06f          	j	80007528 <__printf+0x260>
    800078f4:	00500793          	li	a5,5
    800078f8:	00400c93          	li	s9,4
    800078fc:	c2dff06f          	j	80007528 <__printf+0x260>
    80007900:	00500793          	li	a5,5
    80007904:	00400c93          	li	s9,4
    80007908:	db9ff06f          	j	800076c0 <__printf+0x3f8>
    8000790c:	00600793          	li	a5,6
    80007910:	00500c93          	li	s9,5
    80007914:	dadff06f          	j	800076c0 <__printf+0x3f8>
    80007918:	00600793          	li	a5,6
    8000791c:	00500c93          	li	s9,5
    80007920:	c09ff06f          	j	80007528 <__printf+0x260>
    80007924:	00800793          	li	a5,8
    80007928:	00700c93          	li	s9,7
    8000792c:	bfdff06f          	j	80007528 <__printf+0x260>
    80007930:	00100793          	li	a5,1
    80007934:	d91ff06f          	j	800076c4 <__printf+0x3fc>
    80007938:	00100793          	li	a5,1
    8000793c:	bf1ff06f          	j	8000752c <__printf+0x264>
    80007940:	00900793          	li	a5,9
    80007944:	00800c93          	li	s9,8
    80007948:	be1ff06f          	j	80007528 <__printf+0x260>
    8000794c:	00002517          	auipc	a0,0x2
    80007950:	f5450513          	addi	a0,a0,-172 # 800098a0 <CONSOLE_STATUS+0x890>
    80007954:	00000097          	auipc	ra,0x0
    80007958:	918080e7          	jalr	-1768(ra) # 8000726c <panic>

000000008000795c <printfinit>:
    8000795c:	fe010113          	addi	sp,sp,-32
    80007960:	00813823          	sd	s0,16(sp)
    80007964:	00913423          	sd	s1,8(sp)
    80007968:	00113c23          	sd	ra,24(sp)
    8000796c:	02010413          	addi	s0,sp,32
    80007970:	00006497          	auipc	s1,0x6
    80007974:	85048493          	addi	s1,s1,-1968 # 8000d1c0 <pr>
    80007978:	00048513          	mv	a0,s1
    8000797c:	00002597          	auipc	a1,0x2
    80007980:	f3458593          	addi	a1,a1,-204 # 800098b0 <CONSOLE_STATUS+0x8a0>
    80007984:	00000097          	auipc	ra,0x0
    80007988:	5f4080e7          	jalr	1524(ra) # 80007f78 <initlock>
    8000798c:	01813083          	ld	ra,24(sp)
    80007990:	01013403          	ld	s0,16(sp)
    80007994:	0004ac23          	sw	zero,24(s1)
    80007998:	00813483          	ld	s1,8(sp)
    8000799c:	02010113          	addi	sp,sp,32
    800079a0:	00008067          	ret

00000000800079a4 <uartinit>:
    800079a4:	ff010113          	addi	sp,sp,-16
    800079a8:	00813423          	sd	s0,8(sp)
    800079ac:	01010413          	addi	s0,sp,16
    800079b0:	100007b7          	lui	a5,0x10000
    800079b4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800079b8:	f8000713          	li	a4,-128
    800079bc:	00e781a3          	sb	a4,3(a5)
    800079c0:	00300713          	li	a4,3
    800079c4:	00e78023          	sb	a4,0(a5)
    800079c8:	000780a3          	sb	zero,1(a5)
    800079cc:	00e781a3          	sb	a4,3(a5)
    800079d0:	00700693          	li	a3,7
    800079d4:	00d78123          	sb	a3,2(a5)
    800079d8:	00e780a3          	sb	a4,1(a5)
    800079dc:	00813403          	ld	s0,8(sp)
    800079e0:	01010113          	addi	sp,sp,16
    800079e4:	00008067          	ret

00000000800079e8 <uartputc>:
    800079e8:	00004797          	auipc	a5,0x4
    800079ec:	3307a783          	lw	a5,816(a5) # 8000bd18 <panicked>
    800079f0:	00078463          	beqz	a5,800079f8 <uartputc+0x10>
    800079f4:	0000006f          	j	800079f4 <uartputc+0xc>
    800079f8:	fd010113          	addi	sp,sp,-48
    800079fc:	02813023          	sd	s0,32(sp)
    80007a00:	00913c23          	sd	s1,24(sp)
    80007a04:	01213823          	sd	s2,16(sp)
    80007a08:	01313423          	sd	s3,8(sp)
    80007a0c:	02113423          	sd	ra,40(sp)
    80007a10:	03010413          	addi	s0,sp,48
    80007a14:	00004917          	auipc	s2,0x4
    80007a18:	30c90913          	addi	s2,s2,780 # 8000bd20 <uart_tx_r>
    80007a1c:	00093783          	ld	a5,0(s2)
    80007a20:	00004497          	auipc	s1,0x4
    80007a24:	30848493          	addi	s1,s1,776 # 8000bd28 <uart_tx_w>
    80007a28:	0004b703          	ld	a4,0(s1)
    80007a2c:	02078693          	addi	a3,a5,32
    80007a30:	00050993          	mv	s3,a0
    80007a34:	02e69c63          	bne	a3,a4,80007a6c <uartputc+0x84>
    80007a38:	00001097          	auipc	ra,0x1
    80007a3c:	834080e7          	jalr	-1996(ra) # 8000826c <push_on>
    80007a40:	00093783          	ld	a5,0(s2)
    80007a44:	0004b703          	ld	a4,0(s1)
    80007a48:	02078793          	addi	a5,a5,32
    80007a4c:	00e79463          	bne	a5,a4,80007a54 <uartputc+0x6c>
    80007a50:	0000006f          	j	80007a50 <uartputc+0x68>
    80007a54:	00001097          	auipc	ra,0x1
    80007a58:	88c080e7          	jalr	-1908(ra) # 800082e0 <pop_on>
    80007a5c:	00093783          	ld	a5,0(s2)
    80007a60:	0004b703          	ld	a4,0(s1)
    80007a64:	02078693          	addi	a3,a5,32
    80007a68:	fce688e3          	beq	a3,a4,80007a38 <uartputc+0x50>
    80007a6c:	01f77693          	andi	a3,a4,31
    80007a70:	00005597          	auipc	a1,0x5
    80007a74:	77058593          	addi	a1,a1,1904 # 8000d1e0 <uart_tx_buf>
    80007a78:	00d586b3          	add	a3,a1,a3
    80007a7c:	00170713          	addi	a4,a4,1
    80007a80:	01368023          	sb	s3,0(a3)
    80007a84:	00e4b023          	sd	a4,0(s1)
    80007a88:	10000637          	lui	a2,0x10000
    80007a8c:	02f71063          	bne	a4,a5,80007aac <uartputc+0xc4>
    80007a90:	0340006f          	j	80007ac4 <uartputc+0xdc>
    80007a94:	00074703          	lbu	a4,0(a4)
    80007a98:	00f93023          	sd	a5,0(s2)
    80007a9c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007aa0:	00093783          	ld	a5,0(s2)
    80007aa4:	0004b703          	ld	a4,0(s1)
    80007aa8:	00f70e63          	beq	a4,a5,80007ac4 <uartputc+0xdc>
    80007aac:	00564683          	lbu	a3,5(a2)
    80007ab0:	01f7f713          	andi	a4,a5,31
    80007ab4:	00e58733          	add	a4,a1,a4
    80007ab8:	0206f693          	andi	a3,a3,32
    80007abc:	00178793          	addi	a5,a5,1
    80007ac0:	fc069ae3          	bnez	a3,80007a94 <uartputc+0xac>
    80007ac4:	02813083          	ld	ra,40(sp)
    80007ac8:	02013403          	ld	s0,32(sp)
    80007acc:	01813483          	ld	s1,24(sp)
    80007ad0:	01013903          	ld	s2,16(sp)
    80007ad4:	00813983          	ld	s3,8(sp)
    80007ad8:	03010113          	addi	sp,sp,48
    80007adc:	00008067          	ret

0000000080007ae0 <uartputc_sync>:
    80007ae0:	ff010113          	addi	sp,sp,-16
    80007ae4:	00813423          	sd	s0,8(sp)
    80007ae8:	01010413          	addi	s0,sp,16
    80007aec:	00004717          	auipc	a4,0x4
    80007af0:	22c72703          	lw	a4,556(a4) # 8000bd18 <panicked>
    80007af4:	02071663          	bnez	a4,80007b20 <uartputc_sync+0x40>
    80007af8:	00050793          	mv	a5,a0
    80007afc:	100006b7          	lui	a3,0x10000
    80007b00:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007b04:	02077713          	andi	a4,a4,32
    80007b08:	fe070ce3          	beqz	a4,80007b00 <uartputc_sync+0x20>
    80007b0c:	0ff7f793          	andi	a5,a5,255
    80007b10:	00f68023          	sb	a5,0(a3)
    80007b14:	00813403          	ld	s0,8(sp)
    80007b18:	01010113          	addi	sp,sp,16
    80007b1c:	00008067          	ret
    80007b20:	0000006f          	j	80007b20 <uartputc_sync+0x40>

0000000080007b24 <uartstart>:
    80007b24:	ff010113          	addi	sp,sp,-16
    80007b28:	00813423          	sd	s0,8(sp)
    80007b2c:	01010413          	addi	s0,sp,16
    80007b30:	00004617          	auipc	a2,0x4
    80007b34:	1f060613          	addi	a2,a2,496 # 8000bd20 <uart_tx_r>
    80007b38:	00004517          	auipc	a0,0x4
    80007b3c:	1f050513          	addi	a0,a0,496 # 8000bd28 <uart_tx_w>
    80007b40:	00063783          	ld	a5,0(a2)
    80007b44:	00053703          	ld	a4,0(a0)
    80007b48:	04f70263          	beq	a4,a5,80007b8c <uartstart+0x68>
    80007b4c:	100005b7          	lui	a1,0x10000
    80007b50:	00005817          	auipc	a6,0x5
    80007b54:	69080813          	addi	a6,a6,1680 # 8000d1e0 <uart_tx_buf>
    80007b58:	01c0006f          	j	80007b74 <uartstart+0x50>
    80007b5c:	0006c703          	lbu	a4,0(a3)
    80007b60:	00f63023          	sd	a5,0(a2)
    80007b64:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007b68:	00063783          	ld	a5,0(a2)
    80007b6c:	00053703          	ld	a4,0(a0)
    80007b70:	00f70e63          	beq	a4,a5,80007b8c <uartstart+0x68>
    80007b74:	01f7f713          	andi	a4,a5,31
    80007b78:	00e806b3          	add	a3,a6,a4
    80007b7c:	0055c703          	lbu	a4,5(a1)
    80007b80:	00178793          	addi	a5,a5,1
    80007b84:	02077713          	andi	a4,a4,32
    80007b88:	fc071ae3          	bnez	a4,80007b5c <uartstart+0x38>
    80007b8c:	00813403          	ld	s0,8(sp)
    80007b90:	01010113          	addi	sp,sp,16
    80007b94:	00008067          	ret

0000000080007b98 <uartgetc>:
    80007b98:	ff010113          	addi	sp,sp,-16
    80007b9c:	00813423          	sd	s0,8(sp)
    80007ba0:	01010413          	addi	s0,sp,16
    80007ba4:	10000737          	lui	a4,0x10000
    80007ba8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007bac:	0017f793          	andi	a5,a5,1
    80007bb0:	00078c63          	beqz	a5,80007bc8 <uartgetc+0x30>
    80007bb4:	00074503          	lbu	a0,0(a4)
    80007bb8:	0ff57513          	andi	a0,a0,255
    80007bbc:	00813403          	ld	s0,8(sp)
    80007bc0:	01010113          	addi	sp,sp,16
    80007bc4:	00008067          	ret
    80007bc8:	fff00513          	li	a0,-1
    80007bcc:	ff1ff06f          	j	80007bbc <uartgetc+0x24>

0000000080007bd0 <uartintr>:
    80007bd0:	100007b7          	lui	a5,0x10000
    80007bd4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007bd8:	0017f793          	andi	a5,a5,1
    80007bdc:	0a078463          	beqz	a5,80007c84 <uartintr+0xb4>
    80007be0:	fe010113          	addi	sp,sp,-32
    80007be4:	00813823          	sd	s0,16(sp)
    80007be8:	00913423          	sd	s1,8(sp)
    80007bec:	00113c23          	sd	ra,24(sp)
    80007bf0:	02010413          	addi	s0,sp,32
    80007bf4:	100004b7          	lui	s1,0x10000
    80007bf8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80007bfc:	0ff57513          	andi	a0,a0,255
    80007c00:	fffff097          	auipc	ra,0xfffff
    80007c04:	534080e7          	jalr	1332(ra) # 80007134 <consoleintr>
    80007c08:	0054c783          	lbu	a5,5(s1)
    80007c0c:	0017f793          	andi	a5,a5,1
    80007c10:	fe0794e3          	bnez	a5,80007bf8 <uartintr+0x28>
    80007c14:	00004617          	auipc	a2,0x4
    80007c18:	10c60613          	addi	a2,a2,268 # 8000bd20 <uart_tx_r>
    80007c1c:	00004517          	auipc	a0,0x4
    80007c20:	10c50513          	addi	a0,a0,268 # 8000bd28 <uart_tx_w>
    80007c24:	00063783          	ld	a5,0(a2)
    80007c28:	00053703          	ld	a4,0(a0)
    80007c2c:	04f70263          	beq	a4,a5,80007c70 <uartintr+0xa0>
    80007c30:	100005b7          	lui	a1,0x10000
    80007c34:	00005817          	auipc	a6,0x5
    80007c38:	5ac80813          	addi	a6,a6,1452 # 8000d1e0 <uart_tx_buf>
    80007c3c:	01c0006f          	j	80007c58 <uartintr+0x88>
    80007c40:	0006c703          	lbu	a4,0(a3)
    80007c44:	00f63023          	sd	a5,0(a2)
    80007c48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007c4c:	00063783          	ld	a5,0(a2)
    80007c50:	00053703          	ld	a4,0(a0)
    80007c54:	00f70e63          	beq	a4,a5,80007c70 <uartintr+0xa0>
    80007c58:	01f7f713          	andi	a4,a5,31
    80007c5c:	00e806b3          	add	a3,a6,a4
    80007c60:	0055c703          	lbu	a4,5(a1)
    80007c64:	00178793          	addi	a5,a5,1
    80007c68:	02077713          	andi	a4,a4,32
    80007c6c:	fc071ae3          	bnez	a4,80007c40 <uartintr+0x70>
    80007c70:	01813083          	ld	ra,24(sp)
    80007c74:	01013403          	ld	s0,16(sp)
    80007c78:	00813483          	ld	s1,8(sp)
    80007c7c:	02010113          	addi	sp,sp,32
    80007c80:	00008067          	ret
    80007c84:	00004617          	auipc	a2,0x4
    80007c88:	09c60613          	addi	a2,a2,156 # 8000bd20 <uart_tx_r>
    80007c8c:	00004517          	auipc	a0,0x4
    80007c90:	09c50513          	addi	a0,a0,156 # 8000bd28 <uart_tx_w>
    80007c94:	00063783          	ld	a5,0(a2)
    80007c98:	00053703          	ld	a4,0(a0)
    80007c9c:	04f70263          	beq	a4,a5,80007ce0 <uartintr+0x110>
    80007ca0:	100005b7          	lui	a1,0x10000
    80007ca4:	00005817          	auipc	a6,0x5
    80007ca8:	53c80813          	addi	a6,a6,1340 # 8000d1e0 <uart_tx_buf>
    80007cac:	01c0006f          	j	80007cc8 <uartintr+0xf8>
    80007cb0:	0006c703          	lbu	a4,0(a3)
    80007cb4:	00f63023          	sd	a5,0(a2)
    80007cb8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007cbc:	00063783          	ld	a5,0(a2)
    80007cc0:	00053703          	ld	a4,0(a0)
    80007cc4:	02f70063          	beq	a4,a5,80007ce4 <uartintr+0x114>
    80007cc8:	01f7f713          	andi	a4,a5,31
    80007ccc:	00e806b3          	add	a3,a6,a4
    80007cd0:	0055c703          	lbu	a4,5(a1)
    80007cd4:	00178793          	addi	a5,a5,1
    80007cd8:	02077713          	andi	a4,a4,32
    80007cdc:	fc071ae3          	bnez	a4,80007cb0 <uartintr+0xe0>
    80007ce0:	00008067          	ret
    80007ce4:	00008067          	ret

0000000080007ce8 <kinit>:
    80007ce8:	fc010113          	addi	sp,sp,-64
    80007cec:	02913423          	sd	s1,40(sp)
    80007cf0:	fffff7b7          	lui	a5,0xfffff
    80007cf4:	00006497          	auipc	s1,0x6
    80007cf8:	50b48493          	addi	s1,s1,1291 # 8000e1ff <end+0xfff>
    80007cfc:	02813823          	sd	s0,48(sp)
    80007d00:	01313c23          	sd	s3,24(sp)
    80007d04:	00f4f4b3          	and	s1,s1,a5
    80007d08:	02113c23          	sd	ra,56(sp)
    80007d0c:	03213023          	sd	s2,32(sp)
    80007d10:	01413823          	sd	s4,16(sp)
    80007d14:	01513423          	sd	s5,8(sp)
    80007d18:	04010413          	addi	s0,sp,64
    80007d1c:	000017b7          	lui	a5,0x1
    80007d20:	01100993          	li	s3,17
    80007d24:	00f487b3          	add	a5,s1,a5
    80007d28:	01b99993          	slli	s3,s3,0x1b
    80007d2c:	06f9e063          	bltu	s3,a5,80007d8c <kinit+0xa4>
    80007d30:	00005a97          	auipc	s5,0x5
    80007d34:	4d0a8a93          	addi	s5,s5,1232 # 8000d200 <end>
    80007d38:	0754ec63          	bltu	s1,s5,80007db0 <kinit+0xc8>
    80007d3c:	0734fa63          	bgeu	s1,s3,80007db0 <kinit+0xc8>
    80007d40:	00088a37          	lui	s4,0x88
    80007d44:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80007d48:	00004917          	auipc	s2,0x4
    80007d4c:	fe890913          	addi	s2,s2,-24 # 8000bd30 <kmem>
    80007d50:	00ca1a13          	slli	s4,s4,0xc
    80007d54:	0140006f          	j	80007d68 <kinit+0x80>
    80007d58:	000017b7          	lui	a5,0x1
    80007d5c:	00f484b3          	add	s1,s1,a5
    80007d60:	0554e863          	bltu	s1,s5,80007db0 <kinit+0xc8>
    80007d64:	0534f663          	bgeu	s1,s3,80007db0 <kinit+0xc8>
    80007d68:	00001637          	lui	a2,0x1
    80007d6c:	00100593          	li	a1,1
    80007d70:	00048513          	mv	a0,s1
    80007d74:	00000097          	auipc	ra,0x0
    80007d78:	5e4080e7          	jalr	1508(ra) # 80008358 <__memset>
    80007d7c:	00093783          	ld	a5,0(s2)
    80007d80:	00f4b023          	sd	a5,0(s1)
    80007d84:	00993023          	sd	s1,0(s2)
    80007d88:	fd4498e3          	bne	s1,s4,80007d58 <kinit+0x70>
    80007d8c:	03813083          	ld	ra,56(sp)
    80007d90:	03013403          	ld	s0,48(sp)
    80007d94:	02813483          	ld	s1,40(sp)
    80007d98:	02013903          	ld	s2,32(sp)
    80007d9c:	01813983          	ld	s3,24(sp)
    80007da0:	01013a03          	ld	s4,16(sp)
    80007da4:	00813a83          	ld	s5,8(sp)
    80007da8:	04010113          	addi	sp,sp,64
    80007dac:	00008067          	ret
    80007db0:	00002517          	auipc	a0,0x2
    80007db4:	b2050513          	addi	a0,a0,-1248 # 800098d0 <digits+0x18>
    80007db8:	fffff097          	auipc	ra,0xfffff
    80007dbc:	4b4080e7          	jalr	1204(ra) # 8000726c <panic>

0000000080007dc0 <freerange>:
    80007dc0:	fc010113          	addi	sp,sp,-64
    80007dc4:	000017b7          	lui	a5,0x1
    80007dc8:	02913423          	sd	s1,40(sp)
    80007dcc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007dd0:	009504b3          	add	s1,a0,s1
    80007dd4:	fffff537          	lui	a0,0xfffff
    80007dd8:	02813823          	sd	s0,48(sp)
    80007ddc:	02113c23          	sd	ra,56(sp)
    80007de0:	03213023          	sd	s2,32(sp)
    80007de4:	01313c23          	sd	s3,24(sp)
    80007de8:	01413823          	sd	s4,16(sp)
    80007dec:	01513423          	sd	s5,8(sp)
    80007df0:	01613023          	sd	s6,0(sp)
    80007df4:	04010413          	addi	s0,sp,64
    80007df8:	00a4f4b3          	and	s1,s1,a0
    80007dfc:	00f487b3          	add	a5,s1,a5
    80007e00:	06f5e463          	bltu	a1,a5,80007e68 <freerange+0xa8>
    80007e04:	00005a97          	auipc	s5,0x5
    80007e08:	3fca8a93          	addi	s5,s5,1020 # 8000d200 <end>
    80007e0c:	0954e263          	bltu	s1,s5,80007e90 <freerange+0xd0>
    80007e10:	01100993          	li	s3,17
    80007e14:	01b99993          	slli	s3,s3,0x1b
    80007e18:	0734fc63          	bgeu	s1,s3,80007e90 <freerange+0xd0>
    80007e1c:	00058a13          	mv	s4,a1
    80007e20:	00004917          	auipc	s2,0x4
    80007e24:	f1090913          	addi	s2,s2,-240 # 8000bd30 <kmem>
    80007e28:	00002b37          	lui	s6,0x2
    80007e2c:	0140006f          	j	80007e40 <freerange+0x80>
    80007e30:	000017b7          	lui	a5,0x1
    80007e34:	00f484b3          	add	s1,s1,a5
    80007e38:	0554ec63          	bltu	s1,s5,80007e90 <freerange+0xd0>
    80007e3c:	0534fa63          	bgeu	s1,s3,80007e90 <freerange+0xd0>
    80007e40:	00001637          	lui	a2,0x1
    80007e44:	00100593          	li	a1,1
    80007e48:	00048513          	mv	a0,s1
    80007e4c:	00000097          	auipc	ra,0x0
    80007e50:	50c080e7          	jalr	1292(ra) # 80008358 <__memset>
    80007e54:	00093703          	ld	a4,0(s2)
    80007e58:	016487b3          	add	a5,s1,s6
    80007e5c:	00e4b023          	sd	a4,0(s1)
    80007e60:	00993023          	sd	s1,0(s2)
    80007e64:	fcfa76e3          	bgeu	s4,a5,80007e30 <freerange+0x70>
    80007e68:	03813083          	ld	ra,56(sp)
    80007e6c:	03013403          	ld	s0,48(sp)
    80007e70:	02813483          	ld	s1,40(sp)
    80007e74:	02013903          	ld	s2,32(sp)
    80007e78:	01813983          	ld	s3,24(sp)
    80007e7c:	01013a03          	ld	s4,16(sp)
    80007e80:	00813a83          	ld	s5,8(sp)
    80007e84:	00013b03          	ld	s6,0(sp)
    80007e88:	04010113          	addi	sp,sp,64
    80007e8c:	00008067          	ret
    80007e90:	00002517          	auipc	a0,0x2
    80007e94:	a4050513          	addi	a0,a0,-1472 # 800098d0 <digits+0x18>
    80007e98:	fffff097          	auipc	ra,0xfffff
    80007e9c:	3d4080e7          	jalr	980(ra) # 8000726c <panic>

0000000080007ea0 <kfree>:
    80007ea0:	fe010113          	addi	sp,sp,-32
    80007ea4:	00813823          	sd	s0,16(sp)
    80007ea8:	00113c23          	sd	ra,24(sp)
    80007eac:	00913423          	sd	s1,8(sp)
    80007eb0:	02010413          	addi	s0,sp,32
    80007eb4:	03451793          	slli	a5,a0,0x34
    80007eb8:	04079c63          	bnez	a5,80007f10 <kfree+0x70>
    80007ebc:	00005797          	auipc	a5,0x5
    80007ec0:	34478793          	addi	a5,a5,836 # 8000d200 <end>
    80007ec4:	00050493          	mv	s1,a0
    80007ec8:	04f56463          	bltu	a0,a5,80007f10 <kfree+0x70>
    80007ecc:	01100793          	li	a5,17
    80007ed0:	01b79793          	slli	a5,a5,0x1b
    80007ed4:	02f57e63          	bgeu	a0,a5,80007f10 <kfree+0x70>
    80007ed8:	00001637          	lui	a2,0x1
    80007edc:	00100593          	li	a1,1
    80007ee0:	00000097          	auipc	ra,0x0
    80007ee4:	478080e7          	jalr	1144(ra) # 80008358 <__memset>
    80007ee8:	00004797          	auipc	a5,0x4
    80007eec:	e4878793          	addi	a5,a5,-440 # 8000bd30 <kmem>
    80007ef0:	0007b703          	ld	a4,0(a5)
    80007ef4:	01813083          	ld	ra,24(sp)
    80007ef8:	01013403          	ld	s0,16(sp)
    80007efc:	00e4b023          	sd	a4,0(s1)
    80007f00:	0097b023          	sd	s1,0(a5)
    80007f04:	00813483          	ld	s1,8(sp)
    80007f08:	02010113          	addi	sp,sp,32
    80007f0c:	00008067          	ret
    80007f10:	00002517          	auipc	a0,0x2
    80007f14:	9c050513          	addi	a0,a0,-1600 # 800098d0 <digits+0x18>
    80007f18:	fffff097          	auipc	ra,0xfffff
    80007f1c:	354080e7          	jalr	852(ra) # 8000726c <panic>

0000000080007f20 <kalloc>:
    80007f20:	fe010113          	addi	sp,sp,-32
    80007f24:	00813823          	sd	s0,16(sp)
    80007f28:	00913423          	sd	s1,8(sp)
    80007f2c:	00113c23          	sd	ra,24(sp)
    80007f30:	02010413          	addi	s0,sp,32
    80007f34:	00004797          	auipc	a5,0x4
    80007f38:	dfc78793          	addi	a5,a5,-516 # 8000bd30 <kmem>
    80007f3c:	0007b483          	ld	s1,0(a5)
    80007f40:	02048063          	beqz	s1,80007f60 <kalloc+0x40>
    80007f44:	0004b703          	ld	a4,0(s1)
    80007f48:	00001637          	lui	a2,0x1
    80007f4c:	00500593          	li	a1,5
    80007f50:	00048513          	mv	a0,s1
    80007f54:	00e7b023          	sd	a4,0(a5)
    80007f58:	00000097          	auipc	ra,0x0
    80007f5c:	400080e7          	jalr	1024(ra) # 80008358 <__memset>
    80007f60:	01813083          	ld	ra,24(sp)
    80007f64:	01013403          	ld	s0,16(sp)
    80007f68:	00048513          	mv	a0,s1
    80007f6c:	00813483          	ld	s1,8(sp)
    80007f70:	02010113          	addi	sp,sp,32
    80007f74:	00008067          	ret

0000000080007f78 <initlock>:
    80007f78:	ff010113          	addi	sp,sp,-16
    80007f7c:	00813423          	sd	s0,8(sp)
    80007f80:	01010413          	addi	s0,sp,16
    80007f84:	00813403          	ld	s0,8(sp)
    80007f88:	00b53423          	sd	a1,8(a0)
    80007f8c:	00052023          	sw	zero,0(a0)
    80007f90:	00053823          	sd	zero,16(a0)
    80007f94:	01010113          	addi	sp,sp,16
    80007f98:	00008067          	ret

0000000080007f9c <acquire>:
    80007f9c:	fe010113          	addi	sp,sp,-32
    80007fa0:	00813823          	sd	s0,16(sp)
    80007fa4:	00913423          	sd	s1,8(sp)
    80007fa8:	00113c23          	sd	ra,24(sp)
    80007fac:	01213023          	sd	s2,0(sp)
    80007fb0:	02010413          	addi	s0,sp,32
    80007fb4:	00050493          	mv	s1,a0
    80007fb8:	10002973          	csrr	s2,sstatus
    80007fbc:	100027f3          	csrr	a5,sstatus
    80007fc0:	ffd7f793          	andi	a5,a5,-3
    80007fc4:	10079073          	csrw	sstatus,a5
    80007fc8:	fffff097          	auipc	ra,0xfffff
    80007fcc:	8e0080e7          	jalr	-1824(ra) # 800068a8 <mycpu>
    80007fd0:	07852783          	lw	a5,120(a0)
    80007fd4:	06078e63          	beqz	a5,80008050 <acquire+0xb4>
    80007fd8:	fffff097          	auipc	ra,0xfffff
    80007fdc:	8d0080e7          	jalr	-1840(ra) # 800068a8 <mycpu>
    80007fe0:	07852783          	lw	a5,120(a0)
    80007fe4:	0004a703          	lw	a4,0(s1)
    80007fe8:	0017879b          	addiw	a5,a5,1
    80007fec:	06f52c23          	sw	a5,120(a0)
    80007ff0:	04071063          	bnez	a4,80008030 <acquire+0x94>
    80007ff4:	00100713          	li	a4,1
    80007ff8:	00070793          	mv	a5,a4
    80007ffc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008000:	0007879b          	sext.w	a5,a5
    80008004:	fe079ae3          	bnez	a5,80007ff8 <acquire+0x5c>
    80008008:	0ff0000f          	fence
    8000800c:	fffff097          	auipc	ra,0xfffff
    80008010:	89c080e7          	jalr	-1892(ra) # 800068a8 <mycpu>
    80008014:	01813083          	ld	ra,24(sp)
    80008018:	01013403          	ld	s0,16(sp)
    8000801c:	00a4b823          	sd	a0,16(s1)
    80008020:	00013903          	ld	s2,0(sp)
    80008024:	00813483          	ld	s1,8(sp)
    80008028:	02010113          	addi	sp,sp,32
    8000802c:	00008067          	ret
    80008030:	0104b903          	ld	s2,16(s1)
    80008034:	fffff097          	auipc	ra,0xfffff
    80008038:	874080e7          	jalr	-1932(ra) # 800068a8 <mycpu>
    8000803c:	faa91ce3          	bne	s2,a0,80007ff4 <acquire+0x58>
    80008040:	00002517          	auipc	a0,0x2
    80008044:	89850513          	addi	a0,a0,-1896 # 800098d8 <digits+0x20>
    80008048:	fffff097          	auipc	ra,0xfffff
    8000804c:	224080e7          	jalr	548(ra) # 8000726c <panic>
    80008050:	00195913          	srli	s2,s2,0x1
    80008054:	fffff097          	auipc	ra,0xfffff
    80008058:	854080e7          	jalr	-1964(ra) # 800068a8 <mycpu>
    8000805c:	00197913          	andi	s2,s2,1
    80008060:	07252e23          	sw	s2,124(a0)
    80008064:	f75ff06f          	j	80007fd8 <acquire+0x3c>

0000000080008068 <release>:
    80008068:	fe010113          	addi	sp,sp,-32
    8000806c:	00813823          	sd	s0,16(sp)
    80008070:	00113c23          	sd	ra,24(sp)
    80008074:	00913423          	sd	s1,8(sp)
    80008078:	01213023          	sd	s2,0(sp)
    8000807c:	02010413          	addi	s0,sp,32
    80008080:	00052783          	lw	a5,0(a0)
    80008084:	00079a63          	bnez	a5,80008098 <release+0x30>
    80008088:	00002517          	auipc	a0,0x2
    8000808c:	85850513          	addi	a0,a0,-1960 # 800098e0 <digits+0x28>
    80008090:	fffff097          	auipc	ra,0xfffff
    80008094:	1dc080e7          	jalr	476(ra) # 8000726c <panic>
    80008098:	01053903          	ld	s2,16(a0)
    8000809c:	00050493          	mv	s1,a0
    800080a0:	fffff097          	auipc	ra,0xfffff
    800080a4:	808080e7          	jalr	-2040(ra) # 800068a8 <mycpu>
    800080a8:	fea910e3          	bne	s2,a0,80008088 <release+0x20>
    800080ac:	0004b823          	sd	zero,16(s1)
    800080b0:	0ff0000f          	fence
    800080b4:	0f50000f          	fence	iorw,ow
    800080b8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800080bc:	ffffe097          	auipc	ra,0xffffe
    800080c0:	7ec080e7          	jalr	2028(ra) # 800068a8 <mycpu>
    800080c4:	100027f3          	csrr	a5,sstatus
    800080c8:	0027f793          	andi	a5,a5,2
    800080cc:	04079a63          	bnez	a5,80008120 <release+0xb8>
    800080d0:	07852783          	lw	a5,120(a0)
    800080d4:	02f05e63          	blez	a5,80008110 <release+0xa8>
    800080d8:	fff7871b          	addiw	a4,a5,-1
    800080dc:	06e52c23          	sw	a4,120(a0)
    800080e0:	00071c63          	bnez	a4,800080f8 <release+0x90>
    800080e4:	07c52783          	lw	a5,124(a0)
    800080e8:	00078863          	beqz	a5,800080f8 <release+0x90>
    800080ec:	100027f3          	csrr	a5,sstatus
    800080f0:	0027e793          	ori	a5,a5,2
    800080f4:	10079073          	csrw	sstatus,a5
    800080f8:	01813083          	ld	ra,24(sp)
    800080fc:	01013403          	ld	s0,16(sp)
    80008100:	00813483          	ld	s1,8(sp)
    80008104:	00013903          	ld	s2,0(sp)
    80008108:	02010113          	addi	sp,sp,32
    8000810c:	00008067          	ret
    80008110:	00001517          	auipc	a0,0x1
    80008114:	7f050513          	addi	a0,a0,2032 # 80009900 <digits+0x48>
    80008118:	fffff097          	auipc	ra,0xfffff
    8000811c:	154080e7          	jalr	340(ra) # 8000726c <panic>
    80008120:	00001517          	auipc	a0,0x1
    80008124:	7c850513          	addi	a0,a0,1992 # 800098e8 <digits+0x30>
    80008128:	fffff097          	auipc	ra,0xfffff
    8000812c:	144080e7          	jalr	324(ra) # 8000726c <panic>

0000000080008130 <holding>:
    80008130:	00052783          	lw	a5,0(a0)
    80008134:	00079663          	bnez	a5,80008140 <holding+0x10>
    80008138:	00000513          	li	a0,0
    8000813c:	00008067          	ret
    80008140:	fe010113          	addi	sp,sp,-32
    80008144:	00813823          	sd	s0,16(sp)
    80008148:	00913423          	sd	s1,8(sp)
    8000814c:	00113c23          	sd	ra,24(sp)
    80008150:	02010413          	addi	s0,sp,32
    80008154:	01053483          	ld	s1,16(a0)
    80008158:	ffffe097          	auipc	ra,0xffffe
    8000815c:	750080e7          	jalr	1872(ra) # 800068a8 <mycpu>
    80008160:	01813083          	ld	ra,24(sp)
    80008164:	01013403          	ld	s0,16(sp)
    80008168:	40a48533          	sub	a0,s1,a0
    8000816c:	00153513          	seqz	a0,a0
    80008170:	00813483          	ld	s1,8(sp)
    80008174:	02010113          	addi	sp,sp,32
    80008178:	00008067          	ret

000000008000817c <push_off>:
    8000817c:	fe010113          	addi	sp,sp,-32
    80008180:	00813823          	sd	s0,16(sp)
    80008184:	00113c23          	sd	ra,24(sp)
    80008188:	00913423          	sd	s1,8(sp)
    8000818c:	02010413          	addi	s0,sp,32
    80008190:	100024f3          	csrr	s1,sstatus
    80008194:	100027f3          	csrr	a5,sstatus
    80008198:	ffd7f793          	andi	a5,a5,-3
    8000819c:	10079073          	csrw	sstatus,a5
    800081a0:	ffffe097          	auipc	ra,0xffffe
    800081a4:	708080e7          	jalr	1800(ra) # 800068a8 <mycpu>
    800081a8:	07852783          	lw	a5,120(a0)
    800081ac:	02078663          	beqz	a5,800081d8 <push_off+0x5c>
    800081b0:	ffffe097          	auipc	ra,0xffffe
    800081b4:	6f8080e7          	jalr	1784(ra) # 800068a8 <mycpu>
    800081b8:	07852783          	lw	a5,120(a0)
    800081bc:	01813083          	ld	ra,24(sp)
    800081c0:	01013403          	ld	s0,16(sp)
    800081c4:	0017879b          	addiw	a5,a5,1
    800081c8:	06f52c23          	sw	a5,120(a0)
    800081cc:	00813483          	ld	s1,8(sp)
    800081d0:	02010113          	addi	sp,sp,32
    800081d4:	00008067          	ret
    800081d8:	0014d493          	srli	s1,s1,0x1
    800081dc:	ffffe097          	auipc	ra,0xffffe
    800081e0:	6cc080e7          	jalr	1740(ra) # 800068a8 <mycpu>
    800081e4:	0014f493          	andi	s1,s1,1
    800081e8:	06952e23          	sw	s1,124(a0)
    800081ec:	fc5ff06f          	j	800081b0 <push_off+0x34>

00000000800081f0 <pop_off>:
    800081f0:	ff010113          	addi	sp,sp,-16
    800081f4:	00813023          	sd	s0,0(sp)
    800081f8:	00113423          	sd	ra,8(sp)
    800081fc:	01010413          	addi	s0,sp,16
    80008200:	ffffe097          	auipc	ra,0xffffe
    80008204:	6a8080e7          	jalr	1704(ra) # 800068a8 <mycpu>
    80008208:	100027f3          	csrr	a5,sstatus
    8000820c:	0027f793          	andi	a5,a5,2
    80008210:	04079663          	bnez	a5,8000825c <pop_off+0x6c>
    80008214:	07852783          	lw	a5,120(a0)
    80008218:	02f05a63          	blez	a5,8000824c <pop_off+0x5c>
    8000821c:	fff7871b          	addiw	a4,a5,-1
    80008220:	06e52c23          	sw	a4,120(a0)
    80008224:	00071c63          	bnez	a4,8000823c <pop_off+0x4c>
    80008228:	07c52783          	lw	a5,124(a0)
    8000822c:	00078863          	beqz	a5,8000823c <pop_off+0x4c>
    80008230:	100027f3          	csrr	a5,sstatus
    80008234:	0027e793          	ori	a5,a5,2
    80008238:	10079073          	csrw	sstatus,a5
    8000823c:	00813083          	ld	ra,8(sp)
    80008240:	00013403          	ld	s0,0(sp)
    80008244:	01010113          	addi	sp,sp,16
    80008248:	00008067          	ret
    8000824c:	00001517          	auipc	a0,0x1
    80008250:	6b450513          	addi	a0,a0,1716 # 80009900 <digits+0x48>
    80008254:	fffff097          	auipc	ra,0xfffff
    80008258:	018080e7          	jalr	24(ra) # 8000726c <panic>
    8000825c:	00001517          	auipc	a0,0x1
    80008260:	68c50513          	addi	a0,a0,1676 # 800098e8 <digits+0x30>
    80008264:	fffff097          	auipc	ra,0xfffff
    80008268:	008080e7          	jalr	8(ra) # 8000726c <panic>

000000008000826c <push_on>:
    8000826c:	fe010113          	addi	sp,sp,-32
    80008270:	00813823          	sd	s0,16(sp)
    80008274:	00113c23          	sd	ra,24(sp)
    80008278:	00913423          	sd	s1,8(sp)
    8000827c:	02010413          	addi	s0,sp,32
    80008280:	100024f3          	csrr	s1,sstatus
    80008284:	100027f3          	csrr	a5,sstatus
    80008288:	0027e793          	ori	a5,a5,2
    8000828c:	10079073          	csrw	sstatus,a5
    80008290:	ffffe097          	auipc	ra,0xffffe
    80008294:	618080e7          	jalr	1560(ra) # 800068a8 <mycpu>
    80008298:	07852783          	lw	a5,120(a0)
    8000829c:	02078663          	beqz	a5,800082c8 <push_on+0x5c>
    800082a0:	ffffe097          	auipc	ra,0xffffe
    800082a4:	608080e7          	jalr	1544(ra) # 800068a8 <mycpu>
    800082a8:	07852783          	lw	a5,120(a0)
    800082ac:	01813083          	ld	ra,24(sp)
    800082b0:	01013403          	ld	s0,16(sp)
    800082b4:	0017879b          	addiw	a5,a5,1
    800082b8:	06f52c23          	sw	a5,120(a0)
    800082bc:	00813483          	ld	s1,8(sp)
    800082c0:	02010113          	addi	sp,sp,32
    800082c4:	00008067          	ret
    800082c8:	0014d493          	srli	s1,s1,0x1
    800082cc:	ffffe097          	auipc	ra,0xffffe
    800082d0:	5dc080e7          	jalr	1500(ra) # 800068a8 <mycpu>
    800082d4:	0014f493          	andi	s1,s1,1
    800082d8:	06952e23          	sw	s1,124(a0)
    800082dc:	fc5ff06f          	j	800082a0 <push_on+0x34>

00000000800082e0 <pop_on>:
    800082e0:	ff010113          	addi	sp,sp,-16
    800082e4:	00813023          	sd	s0,0(sp)
    800082e8:	00113423          	sd	ra,8(sp)
    800082ec:	01010413          	addi	s0,sp,16
    800082f0:	ffffe097          	auipc	ra,0xffffe
    800082f4:	5b8080e7          	jalr	1464(ra) # 800068a8 <mycpu>
    800082f8:	100027f3          	csrr	a5,sstatus
    800082fc:	0027f793          	andi	a5,a5,2
    80008300:	04078463          	beqz	a5,80008348 <pop_on+0x68>
    80008304:	07852783          	lw	a5,120(a0)
    80008308:	02f05863          	blez	a5,80008338 <pop_on+0x58>
    8000830c:	fff7879b          	addiw	a5,a5,-1
    80008310:	06f52c23          	sw	a5,120(a0)
    80008314:	07853783          	ld	a5,120(a0)
    80008318:	00079863          	bnez	a5,80008328 <pop_on+0x48>
    8000831c:	100027f3          	csrr	a5,sstatus
    80008320:	ffd7f793          	andi	a5,a5,-3
    80008324:	10079073          	csrw	sstatus,a5
    80008328:	00813083          	ld	ra,8(sp)
    8000832c:	00013403          	ld	s0,0(sp)
    80008330:	01010113          	addi	sp,sp,16
    80008334:	00008067          	ret
    80008338:	00001517          	auipc	a0,0x1
    8000833c:	5f050513          	addi	a0,a0,1520 # 80009928 <digits+0x70>
    80008340:	fffff097          	auipc	ra,0xfffff
    80008344:	f2c080e7          	jalr	-212(ra) # 8000726c <panic>
    80008348:	00001517          	auipc	a0,0x1
    8000834c:	5c050513          	addi	a0,a0,1472 # 80009908 <digits+0x50>
    80008350:	fffff097          	auipc	ra,0xfffff
    80008354:	f1c080e7          	jalr	-228(ra) # 8000726c <panic>

0000000080008358 <__memset>:
    80008358:	ff010113          	addi	sp,sp,-16
    8000835c:	00813423          	sd	s0,8(sp)
    80008360:	01010413          	addi	s0,sp,16
    80008364:	1a060e63          	beqz	a2,80008520 <__memset+0x1c8>
    80008368:	40a007b3          	neg	a5,a0
    8000836c:	0077f793          	andi	a5,a5,7
    80008370:	00778693          	addi	a3,a5,7
    80008374:	00b00813          	li	a6,11
    80008378:	0ff5f593          	andi	a1,a1,255
    8000837c:	fff6071b          	addiw	a4,a2,-1
    80008380:	1b06e663          	bltu	a3,a6,8000852c <__memset+0x1d4>
    80008384:	1cd76463          	bltu	a4,a3,8000854c <__memset+0x1f4>
    80008388:	1a078e63          	beqz	a5,80008544 <__memset+0x1ec>
    8000838c:	00b50023          	sb	a1,0(a0)
    80008390:	00100713          	li	a4,1
    80008394:	1ae78463          	beq	a5,a4,8000853c <__memset+0x1e4>
    80008398:	00b500a3          	sb	a1,1(a0)
    8000839c:	00200713          	li	a4,2
    800083a0:	1ae78a63          	beq	a5,a4,80008554 <__memset+0x1fc>
    800083a4:	00b50123          	sb	a1,2(a0)
    800083a8:	00300713          	li	a4,3
    800083ac:	18e78463          	beq	a5,a4,80008534 <__memset+0x1dc>
    800083b0:	00b501a3          	sb	a1,3(a0)
    800083b4:	00400713          	li	a4,4
    800083b8:	1ae78263          	beq	a5,a4,8000855c <__memset+0x204>
    800083bc:	00b50223          	sb	a1,4(a0)
    800083c0:	00500713          	li	a4,5
    800083c4:	1ae78063          	beq	a5,a4,80008564 <__memset+0x20c>
    800083c8:	00b502a3          	sb	a1,5(a0)
    800083cc:	00700713          	li	a4,7
    800083d0:	18e79e63          	bne	a5,a4,8000856c <__memset+0x214>
    800083d4:	00b50323          	sb	a1,6(a0)
    800083d8:	00700e93          	li	t4,7
    800083dc:	00859713          	slli	a4,a1,0x8
    800083e0:	00e5e733          	or	a4,a1,a4
    800083e4:	01059e13          	slli	t3,a1,0x10
    800083e8:	01c76e33          	or	t3,a4,t3
    800083ec:	01859313          	slli	t1,a1,0x18
    800083f0:	006e6333          	or	t1,t3,t1
    800083f4:	02059893          	slli	a7,a1,0x20
    800083f8:	40f60e3b          	subw	t3,a2,a5
    800083fc:	011368b3          	or	a7,t1,a7
    80008400:	02859813          	slli	a6,a1,0x28
    80008404:	0108e833          	or	a6,a7,a6
    80008408:	03059693          	slli	a3,a1,0x30
    8000840c:	003e589b          	srliw	a7,t3,0x3
    80008410:	00d866b3          	or	a3,a6,a3
    80008414:	03859713          	slli	a4,a1,0x38
    80008418:	00389813          	slli	a6,a7,0x3
    8000841c:	00f507b3          	add	a5,a0,a5
    80008420:	00e6e733          	or	a4,a3,a4
    80008424:	000e089b          	sext.w	a7,t3
    80008428:	00f806b3          	add	a3,a6,a5
    8000842c:	00e7b023          	sd	a4,0(a5)
    80008430:	00878793          	addi	a5,a5,8
    80008434:	fed79ce3          	bne	a5,a3,8000842c <__memset+0xd4>
    80008438:	ff8e7793          	andi	a5,t3,-8
    8000843c:	0007871b          	sext.w	a4,a5
    80008440:	01d787bb          	addw	a5,a5,t4
    80008444:	0ce88e63          	beq	a7,a4,80008520 <__memset+0x1c8>
    80008448:	00f50733          	add	a4,a0,a5
    8000844c:	00b70023          	sb	a1,0(a4)
    80008450:	0017871b          	addiw	a4,a5,1
    80008454:	0cc77663          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    80008458:	00e50733          	add	a4,a0,a4
    8000845c:	00b70023          	sb	a1,0(a4)
    80008460:	0027871b          	addiw	a4,a5,2
    80008464:	0ac77e63          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    80008468:	00e50733          	add	a4,a0,a4
    8000846c:	00b70023          	sb	a1,0(a4)
    80008470:	0037871b          	addiw	a4,a5,3
    80008474:	0ac77663          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    80008478:	00e50733          	add	a4,a0,a4
    8000847c:	00b70023          	sb	a1,0(a4)
    80008480:	0047871b          	addiw	a4,a5,4
    80008484:	08c77e63          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    80008488:	00e50733          	add	a4,a0,a4
    8000848c:	00b70023          	sb	a1,0(a4)
    80008490:	0057871b          	addiw	a4,a5,5
    80008494:	08c77663          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    80008498:	00e50733          	add	a4,a0,a4
    8000849c:	00b70023          	sb	a1,0(a4)
    800084a0:	0067871b          	addiw	a4,a5,6
    800084a4:	06c77e63          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    800084a8:	00e50733          	add	a4,a0,a4
    800084ac:	00b70023          	sb	a1,0(a4)
    800084b0:	0077871b          	addiw	a4,a5,7
    800084b4:	06c77663          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    800084b8:	00e50733          	add	a4,a0,a4
    800084bc:	00b70023          	sb	a1,0(a4)
    800084c0:	0087871b          	addiw	a4,a5,8
    800084c4:	04c77e63          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    800084c8:	00e50733          	add	a4,a0,a4
    800084cc:	00b70023          	sb	a1,0(a4)
    800084d0:	0097871b          	addiw	a4,a5,9
    800084d4:	04c77663          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    800084d8:	00e50733          	add	a4,a0,a4
    800084dc:	00b70023          	sb	a1,0(a4)
    800084e0:	00a7871b          	addiw	a4,a5,10
    800084e4:	02c77e63          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    800084e8:	00e50733          	add	a4,a0,a4
    800084ec:	00b70023          	sb	a1,0(a4)
    800084f0:	00b7871b          	addiw	a4,a5,11
    800084f4:	02c77663          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    800084f8:	00e50733          	add	a4,a0,a4
    800084fc:	00b70023          	sb	a1,0(a4)
    80008500:	00c7871b          	addiw	a4,a5,12
    80008504:	00c77e63          	bgeu	a4,a2,80008520 <__memset+0x1c8>
    80008508:	00e50733          	add	a4,a0,a4
    8000850c:	00b70023          	sb	a1,0(a4)
    80008510:	00d7879b          	addiw	a5,a5,13
    80008514:	00c7f663          	bgeu	a5,a2,80008520 <__memset+0x1c8>
    80008518:	00f507b3          	add	a5,a0,a5
    8000851c:	00b78023          	sb	a1,0(a5)
    80008520:	00813403          	ld	s0,8(sp)
    80008524:	01010113          	addi	sp,sp,16
    80008528:	00008067          	ret
    8000852c:	00b00693          	li	a3,11
    80008530:	e55ff06f          	j	80008384 <__memset+0x2c>
    80008534:	00300e93          	li	t4,3
    80008538:	ea5ff06f          	j	800083dc <__memset+0x84>
    8000853c:	00100e93          	li	t4,1
    80008540:	e9dff06f          	j	800083dc <__memset+0x84>
    80008544:	00000e93          	li	t4,0
    80008548:	e95ff06f          	j	800083dc <__memset+0x84>
    8000854c:	00000793          	li	a5,0
    80008550:	ef9ff06f          	j	80008448 <__memset+0xf0>
    80008554:	00200e93          	li	t4,2
    80008558:	e85ff06f          	j	800083dc <__memset+0x84>
    8000855c:	00400e93          	li	t4,4
    80008560:	e7dff06f          	j	800083dc <__memset+0x84>
    80008564:	00500e93          	li	t4,5
    80008568:	e75ff06f          	j	800083dc <__memset+0x84>
    8000856c:	00600e93          	li	t4,6
    80008570:	e6dff06f          	j	800083dc <__memset+0x84>

0000000080008574 <__memmove>:
    80008574:	ff010113          	addi	sp,sp,-16
    80008578:	00813423          	sd	s0,8(sp)
    8000857c:	01010413          	addi	s0,sp,16
    80008580:	0e060863          	beqz	a2,80008670 <__memmove+0xfc>
    80008584:	fff6069b          	addiw	a3,a2,-1
    80008588:	0006881b          	sext.w	a6,a3
    8000858c:	0ea5e863          	bltu	a1,a0,8000867c <__memmove+0x108>
    80008590:	00758713          	addi	a4,a1,7
    80008594:	00a5e7b3          	or	a5,a1,a0
    80008598:	40a70733          	sub	a4,a4,a0
    8000859c:	0077f793          	andi	a5,a5,7
    800085a0:	00f73713          	sltiu	a4,a4,15
    800085a4:	00174713          	xori	a4,a4,1
    800085a8:	0017b793          	seqz	a5,a5
    800085ac:	00e7f7b3          	and	a5,a5,a4
    800085b0:	10078863          	beqz	a5,800086c0 <__memmove+0x14c>
    800085b4:	00900793          	li	a5,9
    800085b8:	1107f463          	bgeu	a5,a6,800086c0 <__memmove+0x14c>
    800085bc:	0036581b          	srliw	a6,a2,0x3
    800085c0:	fff8081b          	addiw	a6,a6,-1
    800085c4:	02081813          	slli	a6,a6,0x20
    800085c8:	01d85893          	srli	a7,a6,0x1d
    800085cc:	00858813          	addi	a6,a1,8
    800085d0:	00058793          	mv	a5,a1
    800085d4:	00050713          	mv	a4,a0
    800085d8:	01088833          	add	a6,a7,a6
    800085dc:	0007b883          	ld	a7,0(a5)
    800085e0:	00878793          	addi	a5,a5,8
    800085e4:	00870713          	addi	a4,a4,8
    800085e8:	ff173c23          	sd	a7,-8(a4)
    800085ec:	ff0798e3          	bne	a5,a6,800085dc <__memmove+0x68>
    800085f0:	ff867713          	andi	a4,a2,-8
    800085f4:	02071793          	slli	a5,a4,0x20
    800085f8:	0207d793          	srli	a5,a5,0x20
    800085fc:	00f585b3          	add	a1,a1,a5
    80008600:	40e686bb          	subw	a3,a3,a4
    80008604:	00f507b3          	add	a5,a0,a5
    80008608:	06e60463          	beq	a2,a4,80008670 <__memmove+0xfc>
    8000860c:	0005c703          	lbu	a4,0(a1)
    80008610:	00e78023          	sb	a4,0(a5)
    80008614:	04068e63          	beqz	a3,80008670 <__memmove+0xfc>
    80008618:	0015c603          	lbu	a2,1(a1)
    8000861c:	00100713          	li	a4,1
    80008620:	00c780a3          	sb	a2,1(a5)
    80008624:	04e68663          	beq	a3,a4,80008670 <__memmove+0xfc>
    80008628:	0025c603          	lbu	a2,2(a1)
    8000862c:	00200713          	li	a4,2
    80008630:	00c78123          	sb	a2,2(a5)
    80008634:	02e68e63          	beq	a3,a4,80008670 <__memmove+0xfc>
    80008638:	0035c603          	lbu	a2,3(a1)
    8000863c:	00300713          	li	a4,3
    80008640:	00c781a3          	sb	a2,3(a5)
    80008644:	02e68663          	beq	a3,a4,80008670 <__memmove+0xfc>
    80008648:	0045c603          	lbu	a2,4(a1)
    8000864c:	00400713          	li	a4,4
    80008650:	00c78223          	sb	a2,4(a5)
    80008654:	00e68e63          	beq	a3,a4,80008670 <__memmove+0xfc>
    80008658:	0055c603          	lbu	a2,5(a1)
    8000865c:	00500713          	li	a4,5
    80008660:	00c782a3          	sb	a2,5(a5)
    80008664:	00e68663          	beq	a3,a4,80008670 <__memmove+0xfc>
    80008668:	0065c703          	lbu	a4,6(a1)
    8000866c:	00e78323          	sb	a4,6(a5)
    80008670:	00813403          	ld	s0,8(sp)
    80008674:	01010113          	addi	sp,sp,16
    80008678:	00008067          	ret
    8000867c:	02061713          	slli	a4,a2,0x20
    80008680:	02075713          	srli	a4,a4,0x20
    80008684:	00e587b3          	add	a5,a1,a4
    80008688:	f0f574e3          	bgeu	a0,a5,80008590 <__memmove+0x1c>
    8000868c:	02069613          	slli	a2,a3,0x20
    80008690:	02065613          	srli	a2,a2,0x20
    80008694:	fff64613          	not	a2,a2
    80008698:	00e50733          	add	a4,a0,a4
    8000869c:	00c78633          	add	a2,a5,a2
    800086a0:	fff7c683          	lbu	a3,-1(a5)
    800086a4:	fff78793          	addi	a5,a5,-1
    800086a8:	fff70713          	addi	a4,a4,-1
    800086ac:	00d70023          	sb	a3,0(a4)
    800086b0:	fec798e3          	bne	a5,a2,800086a0 <__memmove+0x12c>
    800086b4:	00813403          	ld	s0,8(sp)
    800086b8:	01010113          	addi	sp,sp,16
    800086bc:	00008067          	ret
    800086c0:	02069713          	slli	a4,a3,0x20
    800086c4:	02075713          	srli	a4,a4,0x20
    800086c8:	00170713          	addi	a4,a4,1
    800086cc:	00e50733          	add	a4,a0,a4
    800086d0:	00050793          	mv	a5,a0
    800086d4:	0005c683          	lbu	a3,0(a1)
    800086d8:	00178793          	addi	a5,a5,1
    800086dc:	00158593          	addi	a1,a1,1
    800086e0:	fed78fa3          	sb	a3,-1(a5)
    800086e4:	fee798e3          	bne	a5,a4,800086d4 <__memmove+0x160>
    800086e8:	f89ff06f          	j	80008670 <__memmove+0xfc>
	...
