
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	f2813103          	ld	sp,-216(sp) # 8000bf28 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	505060ef          	jal	ra,80006d20 <start>

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
    800010a8:	7c1020ef          	jal	ra,80004068 <_ZN5RiscV20handleSupervisorTrapEv>

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

0000000080001154 <_ZN13SlabAllocator10initializeEPvm>:
Cache* SlabAllocator::cache = nullptr;
Cache* SlabAllocator::sizeN[BUCKET_SIZE] = {nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr};
void* SlabAllocator::startAddr = nullptr;
uint64 SlabAllocator::blocksResponsibleFor = 0;

void SlabAllocator::initialize(void* space, uint64 blockNum) {
    80001154:	fe010113          	addi	sp,sp,-32
    80001158:	00113c23          	sd	ra,24(sp)
    8000115c:	00813823          	sd	s0,16(sp)
    80001160:	00913423          	sd	s1,8(sp)
    80001164:	01213023          	sd	s2,0(sp)
    80001168:	02010413          	addi	s0,sp,32
    8000116c:	00050913          	mv	s2,a0
    80001170:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    80001174:	00001097          	auipc	ra,0x1
    80001178:	d58080e7          	jalr	-680(ra) # 80001ecc <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    8000117c:	0000b717          	auipc	a4,0xb
    80001180:	e6470713          	addi	a4,a4,-412 # 8000bfe0 <_ZN13SlabAllocator9startAddrE>
    80001184:	01273023          	sd	s2,0(a4)
    blocksResponsibleFor = blockNum;
    80001188:	00973423          	sd	s1,8(a4)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    8000118c:	0000b797          	auipc	a5,0xb
    80001190:	d6c7b783          	ld	a5,-660(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001194:	0007b783          	ld	a5,0(a5)
    80001198:	00c7d793          	srli	a5,a5,0xc
    8000119c:	00178793          	addi	a5,a5,1
    800011a0:	00c79793          	slli	a5,a5,0xc
    800011a4:	00f73823          	sd	a5,16(a4)
    cache->ctor = nullptr;
    800011a8:	0407b823          	sd	zero,80(a5)
    cache->dtor = nullptr;
    800011ac:	0407bc23          	sd	zero,88(a5)
    cache->emptyHead = nullptr;
    800011b0:	0607b023          	sd	zero,96(a5)
    cache->partialHead = nullptr;
    800011b4:	0607b423          	sd	zero,104(a5)
    cache->fullHead = nullptr;
    800011b8:	0607b823          	sd	zero,112(a5)
    cache->objectSize = sizeof(Cache);
    800011bc:	07800713          	li	a4,120
    800011c0:	04e7b023          	sd	a4,64(a5)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    800011c4:	00200713          	li	a4,2
    800011c8:	04e7b423          	sd	a4,72(a5)
}
    800011cc:	01813083          	ld	ra,24(sp)
    800011d0:	01013403          	ld	s0,16(sp)
    800011d4:	00813483          	ld	s1,8(sp)
    800011d8:	00013903          	ld	s2,0(sp)
    800011dc:	02010113          	addi	sp,sp,32
    800011e0:	00008067          	ret

00000000800011e4 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:

    deleted = SlabAllocator::freeFromList(cache->fullHead, addr);

}

Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    800011e4:	ff010113          	addi	sp,sp,-16
    800011e8:	00813423          	sd	s0,8(sp)
    800011ec:	01010413          	addi	s0,sp,16
    return nullptr;
}
    800011f0:	00000513          	li	a0,0
    800011f4:	00813403          	ld	s0,8(sp)
    800011f8:	01010113          	addi	sp,sp,16
    800011fc:	00008067          	ret

0000000080001200 <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    80001200:	fe010113          	addi	sp,sp,-32
    80001204:	00113c23          	sd	ra,24(sp)
    80001208:	00813823          	sd	s0,16(sp)
    8000120c:	00913423          	sd	s1,8(sp)
    80001210:	01213023          	sd	s2,0(sp)
    80001214:	02010413          	addi	s0,sp,32
    80001218:	00050913          	mv	s2,a0
    ConsoleUtil::print("Slab address:", (uint64)slab, "\n");
    8000121c:	00008617          	auipc	a2,0x8
    80001220:	f8460613          	addi	a2,a2,-124 # 800091a0 <CONSOLE_STATUS+0x190>
    80001224:	0005059b          	sext.w	a1,a0
    80001228:	00008517          	auipc	a0,0x8
    8000122c:	df850513          	addi	a0,a0,-520 # 80009020 <CONSOLE_STATUS+0x10>
    80001230:	00004097          	auipc	ra,0x4
    80001234:	828080e7          	jalr	-2008(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Number of slots:", (uint64)slab->totalNumOfSlots, "\n");
    80001238:	00008617          	auipc	a2,0x8
    8000123c:	f6860613          	addi	a2,a2,-152 # 800091a0 <CONSOLE_STATUS+0x190>
    80001240:	01892583          	lw	a1,24(s2)
    80001244:	00008517          	auipc	a0,0x8
    80001248:	dec50513          	addi	a0,a0,-532 # 80009030 <CONSOLE_STATUS+0x20>
    8000124c:	00004097          	auipc	ra,0x4
    80001250:	80c080e7          	jalr	-2036(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab object size:", (uint64)sizeof(Slab), "\n");
    80001254:	00008617          	auipc	a2,0x8
    80001258:	f4c60613          	addi	a2,a2,-180 # 800091a0 <CONSOLE_STATUS+0x190>
    8000125c:	03800593          	li	a1,56
    80001260:	00008517          	auipc	a0,0x8
    80001264:	de850513          	addi	a0,a0,-536 # 80009048 <CONSOLE_STATUS+0x38>
    80001268:	00003097          	auipc	ra,0x3
    8000126c:	7f0080e7          	jalr	2032(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Object offset:", (uint64)slab->objectOffset, "\n");
    80001270:	00008617          	auipc	a2,0x8
    80001274:	f3060613          	addi	a2,a2,-208 # 800091a0 <CONSOLE_STATUS+0x190>
    80001278:	02892583          	lw	a1,40(s2)
    8000127c:	00008517          	auipc	a0,0x8
    80001280:	de450513          	addi	a0,a0,-540 # 80009060 <CONSOLE_STATUS+0x50>
    80001284:	00003097          	auipc	ra,0x3
    80001288:	7d4080e7          	jalr	2004(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab allocated array address:", (uint64)slab->allocated, "\n");
    8000128c:	00008617          	auipc	a2,0x8
    80001290:	f1460613          	addi	a2,a2,-236 # 800091a0 <CONSOLE_STATUS+0x190>
    80001294:	02092583          	lw	a1,32(s2)
    80001298:	00008517          	auipc	a0,0x8
    8000129c:	dd850513          	addi	a0,a0,-552 # 80009070 <CONSOLE_STATUS+0x60>
    800012a0:	00003097          	auipc	ra,0x3
    800012a4:	7b8080e7          	jalr	1976(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::printString("Allocated status array:\n");
    800012a8:	00008517          	auipc	a0,0x8
    800012ac:	de850513          	addi	a0,a0,-536 # 80009090 <CONSOLE_STATUS+0x80>
    800012b0:	00003097          	auipc	ra,0x3
    800012b4:	688080e7          	jalr	1672(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    800012b8:	00000493          	li	s1,0
    800012bc:	01893783          	ld	a5,24(s2)
    800012c0:	02f4f863          	bgeu	s1,a5,800012f0 <_ZN13SlabAllocator9printSlabEP4Slab+0xf0>
        ConsoleUtil::print("", (uint8)slab->allocated[i], " ");
    800012c4:	02093783          	ld	a5,32(s2)
    800012c8:	009787b3          	add	a5,a5,s1
    800012cc:	00008617          	auipc	a2,0x8
    800012d0:	df460613          	addi	a2,a2,-524 # 800090c0 <CONSOLE_STATUS+0xb0>
    800012d4:	0007c583          	lbu	a1,0(a5)
    800012d8:	00008517          	auipc	a0,0x8
    800012dc:	f0850513          	addi	a0,a0,-248 # 800091e0 <CONSOLE_STATUS+0x1d0>
    800012e0:	00003097          	auipc	ra,0x3
    800012e4:	778080e7          	jalr	1912(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    800012e8:	00148493          	addi	s1,s1,1
    800012ec:	fd1ff06f          	j	800012bc <_ZN13SlabAllocator9printSlabEP4Slab+0xbc>
    }
    ConsoleUtil::printString("\n");
    800012f0:	00008517          	auipc	a0,0x8
    800012f4:	eb050513          	addi	a0,a0,-336 # 800091a0 <CONSOLE_STATUS+0x190>
    800012f8:	00003097          	auipc	ra,0x3
    800012fc:	640080e7          	jalr	1600(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
}
    80001300:	01813083          	ld	ra,24(sp)
    80001304:	01013403          	ld	s0,16(sp)
    80001308:	00813483          	ld	s1,8(sp)
    8000130c:	00013903          	ld	s2,0(sp)
    80001310:	02010113          	addi	sp,sp,32
    80001314:	00008067          	ret

0000000080001318 <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    80001318:	fe010113          	addi	sp,sp,-32
    8000131c:	00113c23          	sd	ra,24(sp)
    80001320:	00813823          	sd	s0,16(sp)
    80001324:	00913423          	sd	s1,8(sp)
    80001328:	01213023          	sd	s2,0(sp)
    8000132c:	02010413          	addi	s0,sp,32
    80001330:	00050913          	mv	s2,a0
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001334:	00008617          	auipc	a2,0x8
    80001338:	e6c60613          	addi	a2,a2,-404 # 800091a0 <CONSOLE_STATUS+0x190>
    8000133c:	0000b797          	auipc	a5,0xb
    80001340:	bbc7b783          	ld	a5,-1092(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001344:	0007a583          	lw	a1,0(a5)
    80001348:	00008517          	auipc	a0,0x8
    8000134c:	d6850513          	addi	a0,a0,-664 # 800090b0 <CONSOLE_STATUS+0xa0>
    80001350:	00003097          	auipc	ra,0x3
    80001354:	708080e7          	jalr	1800(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001358:	00008617          	auipc	a2,0x8
    8000135c:	e4860613          	addi	a2,a2,-440 # 800091a0 <CONSOLE_STATUS+0x190>
    80001360:	0009059b          	sext.w	a1,s2
    80001364:	00008517          	auipc	a0,0x8
    80001368:	d6450513          	addi	a0,a0,-668 # 800090c8 <CONSOLE_STATUS+0xb8>
    8000136c:	00003097          	auipc	ra,0x3
    80001370:	6ec080e7          	jalr	1772(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    80001374:	00008617          	auipc	a2,0x8
    80001378:	e2c60613          	addi	a2,a2,-468 # 800091a0 <CONSOLE_STATUS+0x190>
    8000137c:	06092583          	lw	a1,96(s2)
    80001380:	00008517          	auipc	a0,0x8
    80001384:	d5850513          	addi	a0,a0,-680 # 800090d8 <CONSOLE_STATUS+0xc8>
    80001388:	00003097          	auipc	ra,0x3
    8000138c:	6d0080e7          	jalr	1744(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    80001390:	06093483          	ld	s1,96(s2)
    while(iter){
    80001394:	02048463          	beqz	s1,800013bc <_ZN13SlabAllocator10printCacheEP5Cache+0xa4>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001398:	00008617          	auipc	a2,0x8
    8000139c:	d2860613          	addi	a2,a2,-728 # 800090c0 <CONSOLE_STATUS+0xb0>
    800013a0:	0004859b          	sext.w	a1,s1
    800013a4:	00008517          	auipc	a0,0x8
    800013a8:	e3c50513          	addi	a0,a0,-452 # 800091e0 <CONSOLE_STATUS+0x1d0>
    800013ac:	00003097          	auipc	ra,0x3
    800013b0:	6ac080e7          	jalr	1708(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800013b4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013b8:	fddff06f          	j	80001394 <_ZN13SlabAllocator10printCacheEP5Cache+0x7c>
    }
    ConsoleUtil::printString("\n");
    800013bc:	00008517          	auipc	a0,0x8
    800013c0:	de450513          	addi	a0,a0,-540 # 800091a0 <CONSOLE_STATUS+0x190>
    800013c4:	00003097          	auipc	ra,0x3
    800013c8:	574080e7          	jalr	1396(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    800013cc:	00008617          	auipc	a2,0x8
    800013d0:	dd460613          	addi	a2,a2,-556 # 800091a0 <CONSOLE_STATUS+0x190>
    800013d4:	06892583          	lw	a1,104(s2)
    800013d8:	00008517          	auipc	a0,0x8
    800013dc:	d1050513          	addi	a0,a0,-752 # 800090e8 <CONSOLE_STATUS+0xd8>
    800013e0:	00003097          	auipc	ra,0x3
    800013e4:	678080e7          	jalr	1656(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    800013e8:	06893483          	ld	s1,104(s2)
    while(iter){
    800013ec:	02048463          	beqz	s1,80001414 <_ZN13SlabAllocator10printCacheEP5Cache+0xfc>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013f0:	00008617          	auipc	a2,0x8
    800013f4:	cd060613          	addi	a2,a2,-816 # 800090c0 <CONSOLE_STATUS+0xb0>
    800013f8:	0004859b          	sext.w	a1,s1
    800013fc:	00008517          	auipc	a0,0x8
    80001400:	de450513          	addi	a0,a0,-540 # 800091e0 <CONSOLE_STATUS+0x1d0>
    80001404:	00003097          	auipc	ra,0x3
    80001408:	654080e7          	jalr	1620(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    8000140c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001410:	fddff06f          	j	800013ec <_ZN13SlabAllocator10printCacheEP5Cache+0xd4>
    }
    ConsoleUtil::printString("\n");
    80001414:	00008517          	auipc	a0,0x8
    80001418:	d8c50513          	addi	a0,a0,-628 # 800091a0 <CONSOLE_STATUS+0x190>
    8000141c:	00003097          	auipc	ra,0x3
    80001420:	51c080e7          	jalr	1308(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    80001424:	00008617          	auipc	a2,0x8
    80001428:	d7c60613          	addi	a2,a2,-644 # 800091a0 <CONSOLE_STATUS+0x190>
    8000142c:	07092583          	lw	a1,112(s2)
    80001430:	00008517          	auipc	a0,0x8
    80001434:	cc850513          	addi	a0,a0,-824 # 800090f8 <CONSOLE_STATUS+0xe8>
    80001438:	00003097          	auipc	ra,0x3
    8000143c:	620080e7          	jalr	1568(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    80001440:	07093483          	ld	s1,112(s2)
    while(iter){
    80001444:	02048463          	beqz	s1,8000146c <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001448:	00008617          	auipc	a2,0x8
    8000144c:	c7860613          	addi	a2,a2,-904 # 800090c0 <CONSOLE_STATUS+0xb0>
    80001450:	0004859b          	sext.w	a1,s1
    80001454:	00008517          	auipc	a0,0x8
    80001458:	d8c50513          	addi	a0,a0,-628 # 800091e0 <CONSOLE_STATUS+0x1d0>
    8000145c:	00003097          	auipc	ra,0x3
    80001460:	5fc080e7          	jalr	1532(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    80001464:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001468:	fddff06f          	j	80001444 <_ZN13SlabAllocator10printCacheEP5Cache+0x12c>
    }
    ConsoleUtil::printString("\n");
    8000146c:	00008517          	auipc	a0,0x8
    80001470:	d3450513          	addi	a0,a0,-716 # 800091a0 <CONSOLE_STATUS+0x190>
    80001474:	00003097          	auipc	ra,0x3
    80001478:	4c4080e7          	jalr	1220(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    8000147c:	00008617          	auipc	a2,0x8
    80001480:	d2460613          	addi	a2,a2,-732 # 800091a0 <CONSOLE_STATUS+0x190>
    80001484:	04092583          	lw	a1,64(s2)
    80001488:	00008517          	auipc	a0,0x8
    8000148c:	c8050513          	addi	a0,a0,-896 # 80009108 <CONSOLE_STATUS+0xf8>
    80001490:	00003097          	auipc	ra,0x3
    80001494:	5c8080e7          	jalr	1480(ra) # 80004a58 <_ZN11ConsoleUtil5printEPKciS1_>
}
    80001498:	01813083          	ld	ra,24(sp)
    8000149c:	01013403          	ld	s0,16(sp)
    800014a0:	00813483          	ld	s1,8(sp)
    800014a4:	00013903          	ld	s2,0(sp)
    800014a8:	02010113          	addi	sp,sp,32
    800014ac:	00008067          	ret

00000000800014b0 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    800014b0:	ff010113          	addi	sp,sp,-16
    800014b4:	00813423          	sd	s0,8(sp)
    800014b8:	01010413          	addi	s0,sp,16
    slab->next = head;
    800014bc:	00053783          	ld	a5,0(a0)
    800014c0:	00f5b423          	sd	a5,8(a1)
    if(head)
    800014c4:	00078463          	beqz	a5,800014cc <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800014c8:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800014cc:	0005b023          	sd	zero,0(a1)
    head = slab;
    800014d0:	00b53023          	sd	a1,0(a0)
}
    800014d4:	00813403          	ld	s0,8(sp)
    800014d8:	01010113          	addi	sp,sp,16
    800014dc:	00008067          	ret

00000000800014e0 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    800014e0:	fe010113          	addi	sp,sp,-32
    800014e4:	00113c23          	sd	ra,24(sp)
    800014e8:	00813823          	sd	s0,16(sp)
    800014ec:	00913423          	sd	s1,8(sp)
    800014f0:	01213023          	sd	s2,0(sp)
    800014f4:	02010413          	addi	s0,sp,32
    800014f8:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    800014fc:	04853503          	ld	a0,72(a0)
    80001500:	00001097          	auipc	ra,0x1
    80001504:	d84080e7          	jalr	-636(ra) # 80002284 <_ZN5Buddy5allocEm>
    if(!slab)
    80001508:	06050863          	beqz	a0,80001578 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x98>
    8000150c:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001510:	00050593          	mv	a1,a0
    80001514:	06090513          	addi	a0,s2,96
    80001518:	00000097          	auipc	ra,0x0
    8000151c:	f98080e7          	jalr	-104(ra) # 800014b0 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001520:	04893783          	ld	a5,72(s2)
    80001524:	00c79793          	slli	a5,a5,0xc
    80001528:	fc878793          	addi	a5,a5,-56
    8000152c:	04093703          	ld	a4,64(s2)
    80001530:	02e7d7b3          	divu	a5,a5,a4
    80001534:	00f4b823          	sd	a5,16(s1)
    80001538:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + (slab->totalNumOfSlots>>3) + 1);
    8000153c:	0037d793          	srli	a5,a5,0x3
    80001540:	009787b3          	add	a5,a5,s1
    80001544:	03978793          	addi	a5,a5,57
    80001548:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (bool*)((uint64)slab + sizeof(Slab));
    8000154c:	03848793          	addi	a5,s1,56
    80001550:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    80001554:	0324b823          	sd	s2,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001558:	00000793          	li	a5,0
    8000155c:	0184b703          	ld	a4,24(s1)
    80001560:	02e7f063          	bgeu	a5,a4,80001580 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa0>
        slab->allocated[i] = false;
    80001564:	0204b703          	ld	a4,32(s1)
    80001568:	00f70733          	add	a4,a4,a5
    8000156c:	00070023          	sb	zero,0(a4)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001570:	00178793          	addi	a5,a5,1
    80001574:	fe9ff06f          	j	8000155c <_ZN13SlabAllocator12allocateSlabEP5Cache+0x7c>
        return false;
    80001578:	00000513          	li	a0,0
    8000157c:	0080006f          	j	80001584 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
    return true;
    80001580:	00100513          	li	a0,1
}
    80001584:	01813083          	ld	ra,24(sp)
    80001588:	01013403          	ld	s0,16(sp)
    8000158c:	00813483          	ld	s1,8(sp)
    80001590:	00013903          	ld	s2,0(sp)
    80001594:	02010113          	addi	sp,sp,32
    80001598:	00008067          	ret

000000008000159c <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    8000159c:	ff010113          	addi	sp,sp,-16
    800015a0:	00813423          	sd	s0,8(sp)
    800015a4:	01010413          	addi	s0,sp,16
    if(slab == head)
    800015a8:	00053783          	ld	a5,0(a0)
    800015ac:	02b78c63          	beq	a5,a1,800015e4 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    800015b0:	0085b783          	ld	a5,8(a1)
    800015b4:	00078663          	beqz	a5,800015c0 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    800015b8:	0005b703          	ld	a4,0(a1)
    800015bc:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    800015c0:	0005b783          	ld	a5,0(a1)
    800015c4:	00078663          	beqz	a5,800015d0 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    800015c8:	0085b703          	ld	a4,8(a1)
    800015cc:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    800015d0:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    800015d4:	0005b423          	sd	zero,8(a1)
}
    800015d8:	00813403          	ld	s0,8(sp)
    800015dc:	01010113          	addi	sp,sp,16
    800015e0:	00008067          	ret
        head = slab->next;
    800015e4:	0085b783          	ld	a5,8(a1)
    800015e8:	00f53023          	sd	a5,0(a0)
    800015ec:	fc5ff06f          	j	800015b0 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

00000000800015f0 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    800015f0:	fe010113          	addi	sp,sp,-32
    800015f4:	00113c23          	sd	ra,24(sp)
    800015f8:	00813823          	sd	s0,16(sp)
    800015fc:	00913423          	sd	s1,8(sp)
    80001600:	01213023          	sd	s2,0(sp)
    80001604:	02010413          	addi	s0,sp,32
    80001608:	00058913          	mv	s2,a1
    8000160c:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    80001610:	00060593          	mv	a1,a2
    80001614:	00000097          	auipc	ra,0x0
    80001618:	f88080e7          	jalr	-120(ra) # 8000159c <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    8000161c:	00048593          	mv	a1,s1
    80001620:	00090513          	mv	a0,s2
    80001624:	00000097          	auipc	ra,0x0
    80001628:	e8c080e7          	jalr	-372(ra) # 800014b0 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    8000162c:	01813083          	ld	ra,24(sp)
    80001630:	01013403          	ld	s0,16(sp)
    80001634:	00813483          	ld	s1,8(sp)
    80001638:	00013903          	ld	s2,0(sp)
    8000163c:	02010113          	addi	sp,sp,32
    80001640:	00008067          	ret

0000000080001644 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    80001644:	fe010113          	addi	sp,sp,-32
    80001648:	00113c23          	sd	ra,24(sp)
    8000164c:	00813823          	sd	s0,16(sp)
    80001650:	00913423          	sd	s1,8(sp)
    80001654:	01213023          	sd	s2,0(sp)
    80001658:	02010413          	addi	s0,sp,32
    8000165c:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001660:	00000493          	li	s1,0
    80001664:	01893783          	ld	a5,24(s2)
    80001668:	08f4fa63          	bgeu	s1,a5,800016fc <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
        if(!slab->allocated[i]){
    8000166c:	02093783          	ld	a5,32(s2)
    80001670:	009787b3          	add	a5,a5,s1
    80001674:	0007c703          	lbu	a4,0(a5)
    80001678:	00070663          	beqz	a4,80001684 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x40>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    8000167c:	00148493          	addi	s1,s1,1
    80001680:	fe5ff06f          	j	80001664 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i] = true;
    80001684:	00100713          	li	a4,1
    80001688:	00e78023          	sb	a4,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    8000168c:	01093783          	ld	a5,16(s2)
    80001690:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001694:	04f70863          	beq	a4,a5,800016e4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
    80001698:	03093503          	ld	a0,48(s2)
    8000169c:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    800016a0:	fff78793          	addi	a5,a5,-1
    800016a4:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800016a8:	04079463          	bnez	a5,800016f0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xac>
    800016ac:	03093583          	ld	a1,48(s2)
    800016b0:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    800016b4:	0005b703          	ld	a4,0(a1)
    800016b8:	00053783          	ld	a5,0(a0)
    800016bc:	00f70863          	beq	a4,a5,800016cc <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
                SlabAllocator::move(headFrom, headTo, slab);
    800016c0:	00090613          	mv	a2,s2
    800016c4:	00000097          	auipc	ra,0x0
    800016c8:	f2c080e7          	jalr	-212(ra) # 800015f0 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    800016cc:	02893503          	ld	a0,40(s2)
    800016d0:	03093783          	ld	a5,48(s2)
    800016d4:	0407b783          	ld	a5,64(a5)
    800016d8:	029784b3          	mul	s1,a5,s1
    800016dc:	00950533          	add	a0,a0,s1
    800016e0:	0200006f          	j	80001700 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800016e4:	03093503          	ld	a0,48(s2)
    800016e8:	06050513          	addi	a0,a0,96
    800016ec:	fb5ff06f          	j	800016a0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x5c>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800016f0:	03093583          	ld	a1,48(s2)
    800016f4:	06858593          	addi	a1,a1,104
    800016f8:	fbdff06f          	j	800016b4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x70>
    return nullptr;
    800016fc:	00000513          	li	a0,0
}
    80001700:	01813083          	ld	ra,24(sp)
    80001704:	01013403          	ld	s0,16(sp)
    80001708:	00813483          	ld	s1,8(sp)
    8000170c:	00013903          	ld	s2,0(sp)
    80001710:	02010113          	addi	sp,sp,32
    80001714:	00008067          	ret

0000000080001718 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80001718:	fe010113          	addi	sp,sp,-32
    8000171c:	00113c23          	sd	ra,24(sp)
    80001720:	00813823          	sd	s0,16(sp)
    80001724:	00913423          	sd	s1,8(sp)
    80001728:	01213023          	sd	s2,0(sp)
    8000172c:	02010413          	addi	s0,sp,32
    80001730:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    80001734:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80001738:	00048c63          	beqz	s1,80001750 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    8000173c:	00048513          	mv	a0,s1
    80001740:	00000097          	auipc	ra,0x0
    80001744:	f04080e7          	jalr	-252(ra) # 80001644 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001748:	fe0508e3          	beqz	a0,80001738 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    8000174c:	00050493          	mv	s1,a0
    if(ret)
    80001750:	02048063          	beqz	s1,80001770 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    80001754:	00048513          	mv	a0,s1
    80001758:	01813083          	ld	ra,24(sp)
    8000175c:	01013403          	ld	s0,16(sp)
    80001760:	00813483          	ld	s1,8(sp)
    80001764:	00013903          	ld	s2,0(sp)
    80001768:	02010113          	addi	sp,sp,32
    8000176c:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80001770:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80001774:	00048c63          	beqz	s1,8000178c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80001778:	00048513          	mv	a0,s1
    8000177c:	00000097          	auipc	ra,0x0
    80001780:	ec8080e7          	jalr	-312(ra) # 80001644 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001784:	fe0508e3          	beqz	a0,80001774 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001788:	00050493          	mv	s1,a0
    if(ret)
    8000178c:	fc0494e3          	bnez	s1,80001754 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001790:	00090513          	mv	a0,s2
    80001794:	00000097          	auipc	ra,0x0
    80001798:	d4c080e7          	jalr	-692(ra) # 800014e0 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    8000179c:	fa050ce3          	beqz	a0,80001754 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    800017a0:	06093503          	ld	a0,96(s2)
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	ea0080e7          	jalr	-352(ra) # 80001644 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    800017ac:	00050493          	mv	s1,a0
    return ret;
    800017b0:	fa5ff06f          	j	80001754 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

00000000800017b4 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index]) {
    800017b4:	02053783          	ld	a5,32(a0)
    800017b8:	00b785b3          	add	a1,a5,a1
    800017bc:	0005c783          	lbu	a5,0(a1)
    800017c0:	0a078a63          	beqz	a5,80001874 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    800017c4:	fe010113          	addi	sp,sp,-32
    800017c8:	00113c23          	sd	ra,24(sp)
    800017cc:	00813823          	sd	s0,16(sp)
    800017d0:	00913423          	sd	s1,8(sp)
    800017d4:	02010413          	addi	s0,sp,32
    800017d8:	00050493          	mv	s1,a0
        slab->allocated[index] = false;
    800017dc:	00058023          	sb	zero,0(a1)
    inline bool isFull(){return numOfFreeSlots == 0;}
    800017e0:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800017e4:	04079a63          	bnez	a5,80001838 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x84>
    800017e8:	03053503          	ld	a0,48(a0)
    800017ec:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    800017f0:	00178793          	addi	a5,a5,1
    800017f4:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    800017f8:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800017fc:	04e78463          	beq	a5,a4,80001844 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x90>
    80001800:	0304b583          	ld	a1,48(s1)
    80001804:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001808:	04e78463          	beq	a5,a4,80001850 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x9c>
            if (headTo != headFrom)
    8000180c:	0005b703          	ld	a4,0(a1)
    80001810:	00053783          	ld	a5,0(a0)
    80001814:	00f70863          	beq	a4,a5,80001824 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x70>
                SlabAllocator::move(headFrom, headTo, slab);
    80001818:	00048613          	mv	a2,s1
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	dd4080e7          	jalr	-556(ra) # 800015f0 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001824:	01813083          	ld	ra,24(sp)
    80001828:	01013403          	ld	s0,16(sp)
    8000182c:	00813483          	ld	s1,8(sp)
    80001830:	02010113          	addi	sp,sp,32
    80001834:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001838:	03053503          	ld	a0,48(a0)
    8000183c:	06850513          	addi	a0,a0,104
    80001840:	fb1ff06f          	j	800017f0 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x3c>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001844:	0304b583          	ld	a1,48(s1)
    80001848:	06058593          	addi	a1,a1,96
    8000184c:	fbdff06f          	j	80001808 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x54>
            SlabAllocator::removeFromList(headFrom, slab);
    80001850:	00048593          	mv	a1,s1
    80001854:	00000097          	auipc	ra,0x0
    80001858:	d48080e7          	jalr	-696(ra) # 8000159c <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    8000185c:	0304b783          	ld	a5,48(s1)
    80001860:	0487b583          	ld	a1,72(a5)
    80001864:	00048513          	mv	a0,s1
    80001868:	00001097          	auipc	ra,0x1
    8000186c:	944080e7          	jalr	-1724(ra) # 800021ac <_ZN5Buddy4freeEPvm>
    80001870:	fb5ff06f          	j	80001824 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x70>
    80001874:	00008067          	ret

0000000080001878 <_ZN13SlabAllocator10freeObjectEP5CachePv>:
void SlabAllocator::freeObject(Cache* cache, void *addr) {
    80001878:	fe010113          	addi	sp,sp,-32
    8000187c:	00113c23          	sd	ra,24(sp)
    80001880:	00813823          	sd	s0,16(sp)
    80001884:	00913423          	sd	s1,8(sp)
    80001888:	01213023          	sd	s2,0(sp)
    8000188c:	02010413          	addi	s0,sp,32
    80001890:	00050913          	mv	s2,a0
    80001894:	00058493          	mv	s1,a1
    bool deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001898:	06853503          	ld	a0,104(a0)
    8000189c:	0080006f          	j	800018a4 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x2c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    800018a0:	00853503          	ld	a0,8(a0)
        while(head){
    800018a4:	04050463          	beqz	a0,800018ec <_ZN13SlabAllocator10freeObjectEP5CachePv+0x74>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    800018a8:	02853583          	ld	a1,40(a0)
    800018ac:	01853783          	ld	a5,24(a0)
    800018b0:	03053703          	ld	a4,48(a0)
    800018b4:	04073703          	ld	a4,64(a4)
    800018b8:	02e787b3          	mul	a5,a5,a4
    800018bc:	00f587b3          	add	a5,a1,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    800018c0:	fef4f0e3          	bgeu	s1,a5,800018a0 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x28>
    800018c4:	fcb4eee3          	bltu	s1,a1,800018a0 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x28>
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
    800018c8:	40b485b3          	sub	a1,s1,a1
    800018cc:	0000a797          	auipc	a5,0xa
    800018d0:	7247b783          	ld	a5,1828(a5) # 8000bff0 <_ZN13SlabAllocator5cacheE>
    800018d4:	0407b783          	ld	a5,64(a5)
                freeSlot(head, index);
    800018d8:	02f5d5b3          	divu	a1,a1,a5
    800018dc:	00000097          	auipc	ra,0x0
    800018e0:	ed8080e7          	jalr	-296(ra) # 800017b4 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    800018e4:	00100793          	li	a5,1
    800018e8:	0080006f          	j	800018f0 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x78>
        }
        return false;
    800018ec:	00000793          	li	a5,0
    if(deleted)
    800018f0:	00078e63          	beqz	a5,8000190c <_ZN13SlabAllocator10freeObjectEP5CachePv+0x94>
}
    800018f4:	01813083          	ld	ra,24(sp)
    800018f8:	01013403          	ld	s0,16(sp)
    800018fc:	00813483          	ld	s1,8(sp)
    80001900:	00013903          	ld	s2,0(sp)
    80001904:	02010113          	addi	sp,sp,32
    80001908:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    8000190c:	07093503          	ld	a0,112(s2)
    80001910:	0080006f          	j	80001918 <_ZN13SlabAllocator10freeObjectEP5CachePv+0xa0>
            head = head->next;
    80001914:	00853503          	ld	a0,8(a0)
        while(head){
    80001918:	fc050ee3          	beqz	a0,800018f4 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x7c>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    8000191c:	02853583          	ld	a1,40(a0)
    80001920:	01853783          	ld	a5,24(a0)
    80001924:	03053703          	ld	a4,48(a0)
    80001928:	04073703          	ld	a4,64(a4)
    8000192c:	02e787b3          	mul	a5,a5,a4
    80001930:	00f587b3          	add	a5,a1,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001934:	fef4f0e3          	bgeu	s1,a5,80001914 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x9c>
    80001938:	fcb4eee3          	bltu	s1,a1,80001914 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x9c>
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
    8000193c:	40b485b3          	sub	a1,s1,a1
    80001940:	0000a797          	auipc	a5,0xa
    80001944:	6b07b783          	ld	a5,1712(a5) # 8000bff0 <_ZN13SlabAllocator5cacheE>
    80001948:	0407b783          	ld	a5,64(a5)
                freeSlot(head, index);
    8000194c:	02f5d5b3          	divu	a1,a1,a5
    80001950:	00000097          	auipc	ra,0x0
    80001954:	e64080e7          	jalr	-412(ra) # 800017b4 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001958:	f9dff06f          	j	800018f4 <_ZN13SlabAllocator10freeObjectEP5CachePv+0x7c>

000000008000195c <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    8000195c:	ff010113          	addi	sp,sp,-16
    80001960:	00813423          	sd	s0,8(sp)
    80001964:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001968:	03f50513          	addi	a0,a0,63
    8000196c:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001970:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001974:	00100513          	li	a0,1
    asm("ecall");
    80001978:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    8000197c:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001980:	00813403          	ld	s0,8(sp)
    80001984:	01010113          	addi	sp,sp,16
    80001988:	00008067          	ret

000000008000198c <_Z8mem_freePv>:

int mem_free(void *ptr){
    8000198c:	ff010113          	addi	sp,sp,-16
    80001990:	00813423          	sd	s0,8(sp)
    80001994:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001998:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    8000199c:	00200513          	li	a0,2
    asm("ecall");
    800019a0:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    800019a4:	00050513          	mv	a0,a0
    return status;
}
    800019a8:	0005051b          	sext.w	a0,a0
    800019ac:	00813403          	ld	s0,8(sp)
    800019b0:	01010113          	addi	sp,sp,16
    800019b4:	00008067          	ret

00000000800019b8 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    800019b8:	fd010113          	addi	sp,sp,-48
    800019bc:	02113423          	sd	ra,40(sp)
    800019c0:	02813023          	sd	s0,32(sp)
    800019c4:	00913c23          	sd	s1,24(sp)
    800019c8:	01213823          	sd	s2,16(sp)
    800019cc:	01313423          	sd	s3,8(sp)
    800019d0:	03010413          	addi	s0,sp,48
    800019d4:	00050913          	mv	s2,a0
    800019d8:	00058493          	mv	s1,a1
    800019dc:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    800019e0:	04058663          	beqz	a1,80001a2c <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    800019e4:	00001537          	lui	a0,0x1
    800019e8:	00000097          	auipc	ra,0x0
    800019ec:	f74080e7          	jalr	-140(ra) # 8000195c <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    800019f0:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    800019f4:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    800019f8:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    800019fc:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001a00:	01100513          	li	a0,17

    asm("ecall");
    80001a04:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001a08:	00050513          	mv	a0,a0

    return status;
}
    80001a0c:	0005051b          	sext.w	a0,a0
    80001a10:	02813083          	ld	ra,40(sp)
    80001a14:	02013403          	ld	s0,32(sp)
    80001a18:	01813483          	ld	s1,24(sp)
    80001a1c:	01013903          	ld	s2,16(sp)
    80001a20:	00813983          	ld	s3,8(sp)
    80001a24:	03010113          	addi	sp,sp,48
    80001a28:	00008067          	ret
    uint64 istack = 0;
    80001a2c:	00000513          	li	a0,0
    80001a30:	fc1ff06f          	j	800019f0 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

0000000080001a34 <_Z11thread_exitv>:

int thread_exit(){
    80001a34:	ff010113          	addi	sp,sp,-16
    80001a38:	00813423          	sd	s0,8(sp)
    80001a3c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001a40:	01200513          	li	a0,18

    asm("ecall");
    80001a44:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001a48:	00050513          	mv	a0,a0

    return status;
}
    80001a4c:	0005051b          	sext.w	a0,a0
    80001a50:	00813403          	ld	s0,8(sp)
    80001a54:	01010113          	addi	sp,sp,16
    80001a58:	00008067          	ret

0000000080001a5c <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001a5c:	ff010113          	addi	sp,sp,-16
    80001a60:	00813423          	sd	s0,8(sp)
    80001a64:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001a68:	01300513          	li	a0,19

    asm("ecall");
    80001a6c:	00000073          	ecall
}
    80001a70:	00813403          	ld	s0,8(sp)
    80001a74:	01010113          	addi	sp,sp,16
    80001a78:	00008067          	ret

0000000080001a7c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001a7c:	fd010113          	addi	sp,sp,-48
    80001a80:	02113423          	sd	ra,40(sp)
    80001a84:	02813023          	sd	s0,32(sp)
    80001a88:	00913c23          	sd	s1,24(sp)
    80001a8c:	01213823          	sd	s2,16(sp)
    80001a90:	01313423          	sd	s3,8(sp)
    80001a94:	03010413          	addi	s0,sp,48
    80001a98:	00050913          	mv	s2,a0
    80001a9c:	00058493          	mv	s1,a1
    80001aa0:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001aa4:	04058663          	beqz	a1,80001af0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001aa8:	00001537          	lui	a0,0x1
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	eb0080e7          	jalr	-336(ra) # 8000195c <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001ab4:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001ab8:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001abc:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001ac0:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    80001ac4:	01400513          	li	a0,20

    asm("ecall");
    80001ac8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001acc:	00050513          	mv	a0,a0

    return status;
}
    80001ad0:	0005051b          	sext.w	a0,a0
    80001ad4:	02813083          	ld	ra,40(sp)
    80001ad8:	02013403          	ld	s0,32(sp)
    80001adc:	01813483          	ld	s1,24(sp)
    80001ae0:	01013903          	ld	s2,16(sp)
    80001ae4:	00813983          	ld	s3,8(sp)
    80001ae8:	03010113          	addi	sp,sp,48
    80001aec:	00008067          	ret
    uint64 istack = 0;
    80001af0:	00000513          	li	a0,0
    80001af4:	fc1ff06f          	j	80001ab4 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

0000000080001af8 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001af8:	ff010113          	addi	sp,sp,-16
    80001afc:	00813423          	sd	s0,8(sp)
    80001b00:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001b04:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001b08:	01500513          	li	a0,21

    asm("ecall");
    80001b0c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001b10:	00050513          	mv	a0,a0

    return status;
}
    80001b14:	0005051b          	sext.w	a0,a0
    80001b18:	00813403          	ld	s0,8(sp)
    80001b1c:	01010113          	addi	sp,sp,16
    80001b20:	00008067          	ret

0000000080001b24 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001b24:	ff010113          	addi	sp,sp,-16
    80001b28:	00813423          	sd	s0,8(sp)
    80001b2c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001b30:	02059593          	slli	a1,a1,0x20
    80001b34:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001b38:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001b3c:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001b40:	02100513          	li	a0,33


    asm("ecall");
    80001b44:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001b48:	00050513          	mv	a0,a0

    return status;

}
    80001b4c:	0005051b          	sext.w	a0,a0
    80001b50:	00813403          	ld	s0,8(sp)
    80001b54:	01010113          	addi	sp,sp,16
    80001b58:	00008067          	ret

0000000080001b5c <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001b5c:	ff010113          	addi	sp,sp,-16
    80001b60:	00813423          	sd	s0,8(sp)
    80001b64:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001b68:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001b6c:	02200513          	li	a0,34


    asm("ecall");
    80001b70:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001b74:	00050513          	mv	a0,a0

    return status;
}
    80001b78:	0005051b          	sext.w	a0,a0
    80001b7c:	00813403          	ld	s0,8(sp)
    80001b80:	01010113          	addi	sp,sp,16
    80001b84:	00008067          	ret

0000000080001b88 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001b88:	ff010113          	addi	sp,sp,-16
    80001b8c:	00813423          	sd	s0,8(sp)
    80001b90:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001b94:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001b98:	02300513          	li	a0,35


    asm("ecall");
    80001b9c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001ba0:	00050513          	mv	a0,a0

    return status;
}
    80001ba4:	0005051b          	sext.w	a0,a0
    80001ba8:	00813403          	ld	s0,8(sp)
    80001bac:	01010113          	addi	sp,sp,16
    80001bb0:	00008067          	ret

0000000080001bb4 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80001bb4:	ff010113          	addi	sp,sp,-16
    80001bb8:	00813423          	sd	s0,8(sp)
    80001bbc:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001bc0:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80001bc4:	02400513          	li	a0,36


    asm("ecall");
    80001bc8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001bcc:	00050513          	mv	a0,a0

    return status;
}
    80001bd0:	0005051b          	sext.w	a0,a0
    80001bd4:	00813403          	ld	s0,8(sp)
    80001bd8:	01010113          	addi	sp,sp,16
    80001bdc:	00008067          	ret

0000000080001be0 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80001be0:	ff010113          	addi	sp,sp,-16
    80001be4:	00813423          	sd	s0,8(sp)
    80001be8:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    80001bec:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80001bf0:	03100513          	li	a0,49


    asm("ecall");
    80001bf4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001bf8:	00050513          	mv	a0,a0

    return status;
}
    80001bfc:	0005051b          	sext.w	a0,a0
    80001c00:	00813403          	ld	s0,8(sp)
    80001c04:	01010113          	addi	sp,sp,16
    80001c08:	00008067          	ret

0000000080001c0c <_Z4getcv>:

char getc(){
    80001c0c:	ff010113          	addi	sp,sp,-16
    80001c10:	00813423          	sd	s0,8(sp)
    80001c14:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80001c18:	04100513          	li	a0,65

    asm("ecall");
    80001c1c:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80001c20:	00050513          	mv	a0,a0

    return c;
}
    80001c24:	0ff57513          	andi	a0,a0,255
    80001c28:	00813403          	ld	s0,8(sp)
    80001c2c:	01010113          	addi	sp,sp,16
    80001c30:	00008067          	ret

0000000080001c34 <_Z4putcc>:

void putc(char c){
    80001c34:	ff010113          	addi	sp,sp,-16
    80001c38:	00813423          	sd	s0,8(sp)
    80001c3c:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80001c40:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    80001c44:	04200513          	li	a0,66

    asm("ecall");
    80001c48:	00000073          	ecall
}
    80001c4c:	00813403          	ld	s0,8(sp)
    80001c50:	01010113          	addi	sp,sp,16
    80001c54:	00008067          	ret

0000000080001c58 <_Z4forkv>:


int fork(){
    80001c58:	ff010113          	addi	sp,sp,-16
    80001c5c:	00813423          	sd	s0,8(sp)
    80001c60:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    80001c64:	06100513          	li	a0,97

    asm("ecall");
    80001c68:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001c6c:	00050513          	mv	a0,a0

    return status;
}
    80001c70:	0005051b          	sext.w	a0,a0
    80001c74:	00813403          	ld	s0,8(sp)
    80001c78:	01010113          	addi	sp,sp,16
    80001c7c:	00008067          	ret

0000000080001c80 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80001c80:	ff010113          	addi	sp,sp,-16
    80001c84:	00113423          	sd	ra,8(sp)
    80001c88:	00813023          	sd	s0,0(sp)
    80001c8c:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80001c90:	00000097          	auipc	ra,0x0
    80001c94:	ecc080e7          	jalr	-308(ra) # 80001b5c <_Z9sem_closeP10_semaphore>
}
    80001c98:	00813083          	ld	ra,8(sp)
    80001c9c:	00013403          	ld	s0,0(sp)
    80001ca0:	01010113          	addi	sp,sp,16
    80001ca4:	00008067          	ret

0000000080001ca8 <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    80001ca8:	ff010113          	addi	sp,sp,-16
    80001cac:	00113423          	sd	ra,8(sp)
    80001cb0:	00813023          	sd	s0,0(sp)
    80001cb4:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    80001cb8:	00001097          	auipc	ra,0x1
    80001cbc:	f30080e7          	jalr	-208(ra) # 80002be8 <_ZN3TCB11thread_freeEPv>
    80001cc0:	00813083          	ld	ra,8(sp)
    80001cc4:	00013403          	ld	s0,0(sp)
    80001cc8:	01010113          	addi	sp,sp,16
    80001ccc:	00008067          	ret

0000000080001cd0 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80001cd0:	ff010113          	addi	sp,sp,-16
    80001cd4:	00113423          	sd	ra,8(sp)
    80001cd8:	00813023          	sd	s0,0(sp)
    80001cdc:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80001ce0:	00004097          	auipc	ra,0x4
    80001ce4:	4ec080e7          	jalr	1260(ra) # 800061cc <_Z8userMainv>
    80001ce8:	00813083          	ld	ra,8(sp)
    80001cec:	00013403          	ld	s0,0(sp)
    80001cf0:	01010113          	addi	sp,sp,16
    80001cf4:	00008067          	ret

0000000080001cf8 <_ZN6SystemC1Ev>:
    if (!initialized) {
    80001cf8:	0000a797          	auipc	a5,0xa
    80001cfc:	3687c783          	lbu	a5,872(a5) # 8000c060 <_ZN6System11initializedE>
    80001d00:	00078463          	beqz	a5,80001d08 <_ZN6SystemC1Ev+0x10>
    80001d04:	00008067          	ret
System::System() {
    80001d08:	ca010113          	addi	sp,sp,-864
    80001d0c:	34113c23          	sd	ra,856(sp)
    80001d10:	34813823          	sd	s0,848(sp)
    80001d14:	34913423          	sd	s1,840(sp)
    80001d18:	35213023          	sd	s2,832(sp)
    80001d1c:	33313c23          	sd	s3,824(sp)
    80001d20:	36010413          	addi	s0,sp,864
        initialized = true;
    80001d24:	00100793          	li	a5,1
    80001d28:	0000a717          	auipc	a4,0xa
    80001d2c:	32f70c23          	sb	a5,824(a4) # 8000c060 <_ZN6System11initializedE>
        RiscV::initialize();
    80001d30:	00002097          	auipc	ra,0x2
    80001d34:	854080e7          	jalr	-1964(ra) # 80003584 <_ZN5RiscV10initializeEv>
        Cache *cache = SlabAllocator::cache;
    80001d38:	0000a797          	auipc	a5,0xa
    80001d3c:	1f87b783          	ld	a5,504(a5) # 8000bf30 <_GLOBAL_OFFSET_TABLE_+0x50>
    80001d40:	0007b903          	ld	s2,0(a5)
        SlabAllocator::printCache(cache);
    80001d44:	00090513          	mv	a0,s2
    80001d48:	fffff097          	auipc	ra,0xfffff
    80001d4c:	5d0080e7          	jalr	1488(ra) # 80001318 <_ZN13SlabAllocator10printCacheEP5Cache>
        SlabAllocator::allocateObject(cache);
    80001d50:	00090513          	mv	a0,s2
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	9c4080e7          	jalr	-1596(ra) # 80001718 <_ZN13SlabAllocator14allocateObjectEP5Cache>
        for(int i = 0; i < 67; i++)
    80001d5c:	00000493          	li	s1,0
    80001d60:	0240006f          	j	80001d84 <_ZN6SystemC1Ev+0x8c>
            alloc[i] = SlabAllocator::allocateObject(cache);
    80001d64:	00090513          	mv	a0,s2
    80001d68:	00000097          	auipc	ra,0x0
    80001d6c:	9b0080e7          	jalr	-1616(ra) # 80001718 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001d70:	00349793          	slli	a5,s1,0x3
    80001d74:	fd040713          	addi	a4,s0,-48
    80001d78:	00f707b3          	add	a5,a4,a5
    80001d7c:	cea7b023          	sd	a0,-800(a5)
        for(int i = 0; i < 67; i++)
    80001d80:	0014849b          	addiw	s1,s1,1
    80001d84:	04200793          	li	a5,66
    80001d88:	fc97dee3          	bge	a5,s1,80001d64 <_ZN6SystemC1Ev+0x6c>
        SlabAllocator::printSlab(cache->fullHead);
    80001d8c:	07093503          	ld	a0,112(s2)
    80001d90:	fffff097          	auipc	ra,0xfffff
    80001d94:	470080e7          	jalr	1136(ra) # 80001200 <_ZN13SlabAllocator9printSlabEP4Slab>
        void* all1 = SlabAllocator::allocateObject(cache);
    80001d98:	00090513          	mv	a0,s2
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	97c080e7          	jalr	-1668(ra) # 80001718 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001da4:	00050993          	mv	s3,a0
        void* all2 = SlabAllocator::allocateObject(cache);
    80001da8:	00090513          	mv	a0,s2
    80001dac:	00000097          	auipc	ra,0x0
    80001db0:	96c080e7          	jalr	-1684(ra) # 80001718 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001db4:	00050493          	mv	s1,a0
        SlabAllocator::freeObject(cache, all1);
    80001db8:	00098593          	mv	a1,s3
    80001dbc:	00090513          	mv	a0,s2
    80001dc0:	00000097          	auipc	ra,0x0
    80001dc4:	ab8080e7          	jalr	-1352(ra) # 80001878 <_ZN13SlabAllocator10freeObjectEP5CachePv>
        SlabAllocator::freeObject(cache, all2);
    80001dc8:	00048593          	mv	a1,s1
    80001dcc:	00090513          	mv	a0,s2
    80001dd0:	00000097          	auipc	ra,0x0
    80001dd4:	aa8080e7          	jalr	-1368(ra) # 80001878 <_ZN13SlabAllocator10freeObjectEP5CachePv>
        for(int i=0; i<67;i++)
    80001dd8:	00000493          	li	s1,0
    80001ddc:	0240006f          	j	80001e00 <_ZN6SystemC1Ev+0x108>
            SlabAllocator::freeObject(cache, alloc[i]);
    80001de0:	00349793          	slli	a5,s1,0x3
    80001de4:	fd040713          	addi	a4,s0,-48
    80001de8:	00f707b3          	add	a5,a4,a5
    80001dec:	ce07b583          	ld	a1,-800(a5)
    80001df0:	00090513          	mv	a0,s2
    80001df4:	00000097          	auipc	ra,0x0
    80001df8:	a84080e7          	jalr	-1404(ra) # 80001878 <_ZN13SlabAllocator10freeObjectEP5CachePv>
        for(int i=0; i<67;i++)
    80001dfc:	0014849b          	addiw	s1,s1,1
    80001e00:	04200793          	li	a5,66
    80001e04:	fc97dee3          	bge	a5,s1,80001de0 <_ZN6SystemC1Ev+0xe8>
        SlabAllocator::printCache(cache);
    80001e08:	00090513          	mv	a0,s2
    80001e0c:	fffff097          	auipc	ra,0xfffff
    80001e10:	50c080e7          	jalr	1292(ra) # 80001318 <_ZN13SlabAllocator10printCacheEP5Cache>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    80001e14:	00000613          	li	a2,0
    80001e18:	00000597          	auipc	a1,0x0
    80001e1c:	eb858593          	addi	a1,a1,-328 # 80001cd0 <_ZN6System15userMainWrapperEPv>
    80001e20:	ca840513          	addi	a0,s0,-856
    80001e24:	00000097          	auipc	ra,0x0
    80001e28:	b94080e7          	jalr	-1132(ra) # 800019b8 <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001e2c:	ca843783          	ld	a5,-856(s0)
    80001e30:	0107a703          	lw	a4,16(a5)
    80001e34:	00200793          	li	a5,2
    80001e38:	00f70863          	beq	a4,a5,80001e48 <_ZN6SystemC1Ev+0x150>
            thread_dispatch();
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	c20080e7          	jalr	-992(ra) # 80001a5c <_Z15thread_dispatchv>
    80001e44:	fe9ff06f          	j	80001e2c <_ZN6SystemC1Ev+0x134>
        RiscV::finalize();
    80001e48:	00002097          	auipc	ra,0x2
    80001e4c:	938080e7          	jalr	-1736(ra) # 80003780 <_ZN5RiscV8finalizeEv>
}
    80001e50:	35813083          	ld	ra,856(sp)
    80001e54:	35013403          	ld	s0,848(sp)
    80001e58:	34813483          	ld	s1,840(sp)
    80001e5c:	34013903          	ld	s2,832(sp)
    80001e60:	33813983          	ld	s3,824(sp)
    80001e64:	36010113          	addi	sp,sp,864
    80001e68:	00008067          	ret

0000000080001e6c <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001e6c:	ff010113          	addi	sp,sp,-16
    80001e70:	00813423          	sd	s0,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    80001e78:	00100793          	li	a5,1
    80001e7c:	00f50863          	beq	a0,a5,80001e8c <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001e80:	00813403          	ld	s0,8(sp)
    80001e84:	01010113          	addi	sp,sp,16
    80001e88:	00008067          	ret
    80001e8c:	000107b7          	lui	a5,0x10
    80001e90:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001e94:	fef596e3          	bne	a1,a5,80001e80 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80001e98:	0000a797          	auipc	a5,0xa
    80001e9c:	0607b783          	ld	a5,96(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001ea0:	0007b703          	ld	a4,0(a5)
    80001ea4:	00c75793          	srli	a5,a4,0xc
    80001ea8:	00278793          	addi	a5,a5,2
    80001eac:	00c79793          	slli	a5,a5,0xc
    80001eb0:	0000a697          	auipc	a3,0xa
    80001eb4:	1b868693          	addi	a3,a3,440 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001eb8:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001ebc:	fffff7b7          	lui	a5,0xfffff
    80001ec0:	00f77733          	and	a4,a4,a5
    80001ec4:	00e6b423          	sd	a4,8(a3)
    80001ec8:	fb9ff06f          	j	80001e80 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001ecc <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80001ecc:	ff010113          	addi	sp,sp,-16
    80001ed0:	00813423          	sd	s0,8(sp)
    80001ed4:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80001ed8:	0000a717          	auipc	a4,0xa
    80001edc:	19070713          	addi	a4,a4,400 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ee0:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001ee4:	0000a797          	auipc	a5,0xa
    80001ee8:	0147b783          	ld	a5,20(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001eec:	0007b783          	ld	a5,0(a5)
    80001ef0:	fffff6b7          	lui	a3,0xfffff
    80001ef4:	00d7f7b3          	and	a5,a5,a3
    80001ef8:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80001efc:	0000a797          	auipc	a5,0xa
    80001f00:	dab7ba23          	sd	a1,-588(a5) # 8000bcb0 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80001f04:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001f08:	00000713          	li	a4,0
        while(num>1){
    80001f0c:	00100693          	li	a3,1
    80001f10:	00f6f863          	bgeu	a3,a5,80001f20 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80001f14:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f18:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f1c:	ff1ff06f          	j	80001f0c <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001f20:	00371713          	slli	a4,a4,0x3
    80001f24:	0000a797          	auipc	a5,0xa
    80001f28:	14478793          	addi	a5,a5,324 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f2c:	00e78733          	add	a4,a5,a4
    80001f30:	00a73823          	sd	a0,16(a4)
    80001f34:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001f38:	00000713          	li	a4,0
        while(num>1){
    80001f3c:	00100693          	li	a3,1
    80001f40:	00f6f863          	bgeu	a3,a5,80001f50 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001f44:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f48:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f4c:	ff1ff06f          	j	80001f3c <_ZN5Buddy10initializeEPvm+0x70>
    80001f50:	00371713          	slli	a4,a4,0x3
    80001f54:	0000a797          	auipc	a5,0xa
    80001f58:	11478793          	addi	a5,a5,276 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f5c:	00e78733          	add	a4,a5,a4
    80001f60:	06a73c23          	sd	a0,120(a4)
    80001f64:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001f68:	00000713          	li	a4,0
        while(num>1){
    80001f6c:	00100693          	li	a3,1
    80001f70:	00f6f863          	bgeu	a3,a5,80001f80 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001f74:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f78:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f7c:	ff1ff06f          	j	80001f6c <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001f80:	00371713          	slli	a4,a4,0x3
    80001f84:	0000a797          	auipc	a5,0xa
    80001f88:	0e478793          	addi	a5,a5,228 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f8c:	00e78733          	add	a4,a5,a4
    80001f90:	01073783          	ld	a5,16(a4)
    80001f94:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001f98:	00000793          	li	a5,0
    80001f9c:	00c0006f          	j	80001fa8 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001fa0:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001fa4:	00178793          	addi	a5,a5,1
        while(num>1){
    80001fa8:	00100713          	li	a4,1
    80001fac:	feb76ae3          	bltu	a4,a1,80001fa0 <_ZN5Buddy10initializeEPvm+0xd4>
    80001fb0:	00379793          	slli	a5,a5,0x3
    80001fb4:	0000a717          	auipc	a4,0xa
    80001fb8:	0b470713          	addi	a4,a4,180 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001fbc:	00f707b3          	add	a5,a4,a5
    80001fc0:	0787b783          	ld	a5,120(a5)
    80001fc4:	0007b023          	sd	zero,0(a5)
}
    80001fc8:	00813403          	ld	s0,8(sp)
    80001fcc:	01010113          	addi	sp,sp,16
    80001fd0:	00008067          	ret

0000000080001fd4 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001fd4:	00c00793          	li	a5,12
    80001fd8:	0ef50863          	beq	a0,a5,800020c8 <_ZN5Buddy8compressEm+0xf4>
void Buddy::compress(uint64 size) {
    80001fdc:	fd010113          	addi	sp,sp,-48
    80001fe0:	02113423          	sd	ra,40(sp)
    80001fe4:	02813023          	sd	s0,32(sp)
    80001fe8:	00913c23          	sd	s1,24(sp)
    80001fec:	01213823          	sd	s2,16(sp)
    80001ff0:	01313423          	sd	s3,8(sp)
    80001ff4:	03010413          	addi	s0,sp,48
    80001ff8:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80001ffc:	00351713          	slli	a4,a0,0x3
    80002000:	0000a797          	auipc	a5,0xa
    80002004:	06878793          	addi	a5,a5,104 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002008:	00e787b3          	add	a5,a5,a4
    8000200c:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002010:	00000993          	li	s3,0
    80002014:	0180006f          	j	8000202c <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80002018:	40d70733          	sub	a4,a4,a3
        if(blkNoNext == pair){
    8000201c:	04f70663          	beq	a4,a5,80002068 <_ZN5Buddy8compressEm+0x94>
            prev = curr;
    80002020:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002024:	06f70863          	beq	a4,a5,80002094 <_ZN5Buddy8compressEm+0xc0>
        curr = curr->next;
    80002028:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    8000202c:	08048063          	beqz	s1,800020ac <_ZN5Buddy8compressEm+0xd8>
    80002030:	0004b603          	ld	a2,0(s1)
    80002034:	06060c63          	beqz	a2,800020ac <_ZN5Buddy8compressEm+0xd8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    80002038:	0000a797          	auipc	a5,0xa
    8000203c:	0307b783          	ld	a5,48(a5) # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002040:	40f48733          	sub	a4,s1,a5
    80002044:	00c75713          	srli	a4,a4,0xc
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    80002048:	40f607b3          	sub	a5,a2,a5
    8000204c:	00c7d793          	srli	a5,a5,0xc
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    80002050:	00100693          	li	a3,1
    80002054:	012696bb          	sllw	a3,a3,s2
    80002058:	02d775b3          	remu	a1,a4,a3
    8000205c:	fa059ee3          	bnez	a1,80002018 <_ZN5Buddy8compressEm+0x44>
    80002060:	00e68733          	add	a4,a3,a4
    80002064:	fb9ff06f          	j	8000201c <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002068:	00098863          	beqz	s3,80002078 <_ZN5Buddy8compressEm+0xa4>
                prev->next = curr->next->next;
    8000206c:	00063683          	ld	a3,0(a2)
    80002070:	00d9b023          	sd	a3,0(s3)
    80002074:	fb1ff06f          	j	80002024 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80002078:	00063603          	ld	a2,0(a2)
    8000207c:	00391593          	slli	a1,s2,0x3
    80002080:	0000a697          	auipc	a3,0xa
    80002084:	fe868693          	addi	a3,a3,-24 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002088:	00b686b3          	add	a3,a3,a1
    8000208c:	06c6bc23          	sd	a2,120(a3)
    80002090:	f95ff06f          	j	80002024 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002094:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    80002098:	00190593          	addi	a1,s2,1
    8000209c:	00048513          	mv	a0,s1
    800020a0:	00000097          	auipc	ra,0x0
    800020a4:	02c080e7          	jalr	44(ra) # 800020cc <_ZN5Buddy6insertEPvm>
    800020a8:	f81ff06f          	j	80002028 <_ZN5Buddy8compressEm+0x54>
}
    800020ac:	02813083          	ld	ra,40(sp)
    800020b0:	02013403          	ld	s0,32(sp)
    800020b4:	01813483          	ld	s1,24(sp)
    800020b8:	01013903          	ld	s2,16(sp)
    800020bc:	00813983          	ld	s3,8(sp)
    800020c0:	03010113          	addi	sp,sp,48
    800020c4:	00008067          	ret
    800020c8:	00008067          	ret

00000000800020cc <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    800020cc:	00050693          	mv	a3,a0
    if(!head[size]){
    800020d0:	00359713          	slli	a4,a1,0x3
    800020d4:	0000a797          	auipc	a5,0xa
    800020d8:	f9478793          	addi	a5,a5,-108 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    800020dc:	00e787b3          	add	a5,a5,a4
    800020e0:	0787b783          	ld	a5,120(a5)
    800020e4:	02078863          	beqz	a5,80002114 <_ZN5Buddy6insertEPvm+0x48>
void Buddy::insert(void *addr, uint64 size) {
    800020e8:	ff010113          	addi	sp,sp,-16
    800020ec:	00113423          	sd	ra,8(sp)
    800020f0:	00813023          	sd	s0,0(sp)
    800020f4:	01010413          	addi	s0,sp,16
    800020f8:	00058513          	mv	a0,a1
        if((uint64)addr < (uint64)head[size]){
    800020fc:	00068713          	mv	a4,a3
    80002100:	02f6ec63          	bltu	a3,a5,80002138 <_ZN5Buddy6insertEPvm+0x6c>
            while(iter != nullptr){
    80002104:	06078663          	beqz	a5,80002170 <_ZN5Buddy6insertEPvm+0xa4>
                if((uint64)addr < (uint64)iter) {
    80002108:	04f76a63          	bltu	a4,a5,8000215c <_ZN5Buddy6insertEPvm+0x90>
                    iter = iter->next;
    8000210c:	0007b783          	ld	a5,0(a5)
            while(iter != nullptr){
    80002110:	ff5ff06f          	j	80002104 <_ZN5Buddy6insertEPvm+0x38>
        head[size] = tail[size] = (Block*)addr;
    80002114:	0000a797          	auipc	a5,0xa
    80002118:	f5478793          	addi	a5,a5,-172 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000211c:	00e78533          	add	a0,a5,a4
    80002120:	00d53823          	sd	a3,16(a0) # 1010 <_entry-0x7fffeff0>
    80002124:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002128:	0006b023          	sd	zero,0(a3)
    8000212c:	07853783          	ld	a5,120(a0)
    80002130:	0007b023          	sd	zero,0(a5)
        return;
    80002134:	00008067          	ret
            newHead->next = head[size];
    80002138:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    8000213c:	00359713          	slli	a4,a1,0x3
    80002140:	0000a797          	auipc	a5,0xa
    80002144:	f2878793          	addi	a5,a5,-216 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002148:	00e787b3          	add	a5,a5,a4
    8000214c:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80002150:	00000097          	auipc	ra,0x0
    80002154:	e84080e7          	jalr	-380(ra) # 80001fd4 <_ZN5Buddy8compressEm>
            return;
    80002158:	0440006f          	j	8000219c <_ZN5Buddy6insertEPvm+0xd0>
                    newBlock->next = iter;
    8000215c:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80002160:	00d03023          	sd	a3,0(zero) # 0 <_entry-0x80000000>
                    compress(size);
    80002164:	00000097          	auipc	ra,0x0
    80002168:	e70080e7          	jalr	-400(ra) # 80001fd4 <_ZN5Buddy8compressEm>
                    return;
    8000216c:	0300006f          	j	8000219c <_ZN5Buddy6insertEPvm+0xd0>
    tail[size]->next = (Block*)addr;
    80002170:	00351713          	slli	a4,a0,0x3
    80002174:	0000a797          	auipc	a5,0xa
    80002178:	ef478793          	addi	a5,a5,-268 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000217c:	00e787b3          	add	a5,a5,a4
    80002180:	0107b703          	ld	a4,16(a5)
    80002184:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    80002188:	0107b703          	ld	a4,16(a5)
    8000218c:	00073703          	ld	a4,0(a4)
    80002190:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80002194:	00000097          	auipc	ra,0x0
    80002198:	e40080e7          	jalr	-448(ra) # 80001fd4 <_ZN5Buddy8compressEm>
}
    8000219c:	00813083          	ld	ra,8(sp)
    800021a0:	00013403          	ld	s0,0(sp)
    800021a4:	01010113          	addi	sp,sp,16
    800021a8:	00008067          	ret

00000000800021ac <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800021ac:	02050663          	beqz	a0,800021d8 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800021b0:	ff010113          	addi	sp,sp,-16
    800021b4:	00113423          	sd	ra,8(sp)
    800021b8:	00813023          	sd	s0,0(sp)
    800021bc:	01010413          	addi	s0,sp,16
    insert(addr,size);
    800021c0:	00000097          	auipc	ra,0x0
    800021c4:	f0c080e7          	jalr	-244(ra) # 800020cc <_ZN5Buddy6insertEPvm>
}
    800021c8:	00813083          	ld	ra,8(sp)
    800021cc:	00013403          	ld	s0,0(sp)
    800021d0:	01010113          	addi	sp,sp,16
    800021d4:	00008067          	ret
    800021d8:	00008067          	ret

00000000800021dc <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800021dc:	ff010113          	addi	sp,sp,-16
    800021e0:	00813423          	sd	s0,8(sp)
    800021e4:	01010413          	addi	s0,sp,16
    800021e8:	03c0006f          	j	80002224 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800021ec:	00b5859b          	addiw	a1,a1,11
    800021f0:	00100713          	li	a4,1
    800021f4:	00b715bb          	sllw	a1,a4,a1
    800021f8:	00b505b3          	add	a1,a0,a1
    800021fc:	00379693          	slli	a3,a5,0x3
    80002200:	0000a717          	auipc	a4,0xa
    80002204:	e6870713          	addi	a4,a4,-408 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002208:	00d70733          	add	a4,a4,a3
    8000220c:	00b73823          	sd	a1,16(a4)
    80002210:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002214:	0005b023          	sd	zero,0(a1)
    80002218:	07873703          	ld	a4,120(a4)
    8000221c:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002220:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002224:	fff5879b          	addiw	a5,a1,-1
    80002228:	04c7c863          	blt	a5,a2,80002278 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    8000222c:	00379693          	slli	a3,a5,0x3
    80002230:	0000a717          	auipc	a4,0xa
    80002234:	e3870713          	addi	a4,a4,-456 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002238:	00d70733          	add	a4,a4,a3
    8000223c:	01073683          	ld	a3,16(a4)
    80002240:	fa0686e3          	beqz	a3,800021ec <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002244:	00b5859b          	addiw	a1,a1,11
    80002248:	00100713          	li	a4,1
    8000224c:	00b715bb          	sllw	a1,a4,a1
    80002250:	00b505b3          	add	a1,a0,a1
    80002254:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002258:	00379693          	slli	a3,a5,0x3
    8000225c:	0000a717          	auipc	a4,0xa
    80002260:	e0c70713          	addi	a4,a4,-500 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002264:	00d70733          	add	a4,a4,a3
    80002268:	01073683          	ld	a3,16(a4)
    8000226c:	0006b683          	ld	a3,0(a3)
    80002270:	00d73823          	sd	a3,16(a4)
    80002274:	fadff06f          	j	80002220 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    80002278:	00813403          	ld	s0,8(sp)
    8000227c:	01010113          	addi	sp,sp,16
    80002280:	00008067          	ret

0000000080002284 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80002284:	fe010113          	addi	sp,sp,-32
    80002288:	00113c23          	sd	ra,24(sp)
    8000228c:	00813823          	sd	s0,16(sp)
    80002290:	00913423          	sd	s1,8(sp)
    80002294:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    80002298:	00c00793          	li	a5,12
    8000229c:	06a7ec63          	bltu	a5,a0,80002314 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800022a0:	00050593          	mv	a1,a0
    800022a4:	00c00793          	li	a5,12
    800022a8:	06b7ea63          	bltu	a5,a1,8000231c <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800022ac:	00359713          	slli	a4,a1,0x3
    800022b0:	0000a797          	auipc	a5,0xa
    800022b4:	db878793          	addi	a5,a5,-584 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022b8:	00e787b3          	add	a5,a5,a4
    800022bc:	0787b483          	ld	s1,120(a5)
    800022c0:	00049663          	bnez	s1,800022cc <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800022c4:	00158593          	addi	a1,a1,1
    800022c8:	fddff06f          	j	800022a4 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    800022cc:	0004b703          	ld	a4,0(s1)
    800022d0:	00359693          	slli	a3,a1,0x3
    800022d4:	0000a797          	auipc	a5,0xa
    800022d8:	d9478793          	addi	a5,a5,-620 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022dc:	00d787b3          	add	a5,a5,a3
    800022e0:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    800022e4:	00070e63          	beqz	a4,80002300 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    800022e8:	0005061b          	sext.w	a2,a0
    800022ec:	0005859b          	sext.w	a1,a1
    800022f0:	00048513          	mv	a0,s1
    800022f4:	00000097          	auipc	ra,0x0
    800022f8:	ee8080e7          	jalr	-280(ra) # 800021dc <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    800022fc:	0240006f          	j	80002320 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002300:	0000a797          	auipc	a5,0xa
    80002304:	d6878793          	addi	a5,a5,-664 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002308:	00d787b3          	add	a5,a5,a3
    8000230c:	0007b823          	sd	zero,16(a5)
    80002310:	fd9ff06f          	j	800022e8 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002314:	00000493          	li	s1,0
    80002318:	0080006f          	j	80002320 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    8000231c:	00000493          	li	s1,0
}
    80002320:	00048513          	mv	a0,s1
    80002324:	01813083          	ld	ra,24(sp)
    80002328:	01013403          	ld	s0,16(sp)
    8000232c:	00813483          	ld	s1,8(sp)
    80002330:	02010113          	addi	sp,sp,32
    80002334:	00008067          	ret

0000000080002338 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002338:	fe010113          	addi	sp,sp,-32
    8000233c:	00113c23          	sd	ra,24(sp)
    80002340:	00813823          	sd	s0,16(sp)
    80002344:	00913423          	sd	s1,8(sp)
    80002348:	01213023          	sd	s2,0(sp)
    8000234c:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002350:	00000913          	li	s2,0
    80002354:	0180006f          	j	8000236c <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002358:	00007517          	auipc	a0,0x7
    8000235c:	e4850513          	addi	a0,a0,-440 # 800091a0 <CONSOLE_STATUS+0x190>
    80002360:	00002097          	auipc	ra,0x2
    80002364:	5d8080e7          	jalr	1496(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002368:	0019091b          	addiw	s2,s2,1
    8000236c:	00c00793          	li	a5,12
    80002370:	0727c663          	blt	a5,s2,800023dc <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002374:	00000613          	li	a2,0
    80002378:	00a00593          	li	a1,10
    8000237c:	00090513          	mv	a0,s2
    80002380:	00002097          	auipc	ra,0x2
    80002384:	5fc080e7          	jalr	1532(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    80002388:	00007517          	auipc	a0,0x7
    8000238c:	d9050513          	addi	a0,a0,-624 # 80009118 <CONSOLE_STATUS+0x108>
    80002390:	00002097          	auipc	ra,0x2
    80002394:	5a8080e7          	jalr	1448(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    80002398:	00391713          	slli	a4,s2,0x3
    8000239c:	0000a797          	auipc	a5,0xa
    800023a0:	ccc78793          	addi	a5,a5,-820 # 8000c068 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023a4:	00e787b3          	add	a5,a5,a4
    800023a8:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    800023ac:	fa0486e3          	beqz	s1,80002358 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    800023b0:	00000613          	li	a2,0
    800023b4:	00a00593          	li	a1,10
    800023b8:	0004851b          	sext.w	a0,s1
    800023bc:	00002097          	auipc	ra,0x2
    800023c0:	5c0080e7          	jalr	1472(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    800023c4:	00007517          	auipc	a0,0x7
    800023c8:	cfc50513          	addi	a0,a0,-772 # 800090c0 <CONSOLE_STATUS+0xb0>
    800023cc:	00002097          	auipc	ra,0x2
    800023d0:	56c080e7          	jalr	1388(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    800023d4:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    800023d8:	fd5ff06f          	j	800023ac <_ZN5Buddy9printListEv+0x74>
    800023dc:	01813083          	ld	ra,24(sp)
    800023e0:	01013403          	ld	s0,16(sp)
    800023e4:	00813483          	ld	s1,8(sp)
    800023e8:	00013903          	ld	s2,0(sp)
    800023ec:	02010113          	addi	sp,sp,32
    800023f0:	00008067          	ret

00000000800023f4 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    800023f4:	ff010113          	addi	sp,sp,-16
    800023f8:	00113423          	sd	ra,8(sp)
    800023fc:	00813023          	sd	s0,0(sp)
    80002400:	01010413          	addi	s0,sp,16
    80002404:	000105b7          	lui	a1,0x10
    80002408:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000240c:	00100513          	li	a0,1
    80002410:	00000097          	auipc	ra,0x0
    80002414:	a5c080e7          	jalr	-1444(ra) # 80001e6c <_Z41__static_initialization_and_destruction_0ii>
    80002418:	00813083          	ld	ra,8(sp)
    8000241c:	00013403          	ld	s0,0(sp)
    80002420:	01010113          	addi	sp,sp,16
    80002424:	00008067          	ret

0000000080002428 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002428:	fe010113          	addi	sp,sp,-32
    8000242c:	00113c23          	sd	ra,24(sp)
    80002430:	00813823          	sd	s0,16(sp)
    80002434:	00913423          	sd	s1,8(sp)
    80002438:	02010413          	addi	s0,sp,32
    8000243c:	00050493          	mv	s1,a0
    LOCK();
    80002440:	00100613          	li	a2,1
    80002444:	00000593          	li	a1,0
    80002448:	0000a517          	auipc	a0,0xa
    8000244c:	d0050513          	addi	a0,a0,-768 # 8000c148 <lockPrint>
    80002450:	fffff097          	auipc	ra,0xfffff
    80002454:	bb0080e7          	jalr	-1104(ra) # 80001000 <copy_and_swap>
    80002458:	fe0514e3          	bnez	a0,80002440 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000245c:	0004c503          	lbu	a0,0(s1)
    80002460:	00050a63          	beqz	a0,80002474 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002464:	fffff097          	auipc	ra,0xfffff
    80002468:	7d0080e7          	jalr	2000(ra) # 80001c34 <_Z4putcc>
        string++;
    8000246c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002470:	fedff06f          	j	8000245c <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002474:	00000613          	li	a2,0
    80002478:	00100593          	li	a1,1
    8000247c:	0000a517          	auipc	a0,0xa
    80002480:	ccc50513          	addi	a0,a0,-820 # 8000c148 <lockPrint>
    80002484:	fffff097          	auipc	ra,0xfffff
    80002488:	b7c080e7          	jalr	-1156(ra) # 80001000 <copy_and_swap>
    8000248c:	fe0514e3          	bnez	a0,80002474 <_Z11printStringPKc+0x4c>
}
    80002490:	01813083          	ld	ra,24(sp)
    80002494:	01013403          	ld	s0,16(sp)
    80002498:	00813483          	ld	s1,8(sp)
    8000249c:	02010113          	addi	sp,sp,32
    800024a0:	00008067          	ret

00000000800024a4 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800024a4:	fd010113          	addi	sp,sp,-48
    800024a8:	02113423          	sd	ra,40(sp)
    800024ac:	02813023          	sd	s0,32(sp)
    800024b0:	00913c23          	sd	s1,24(sp)
    800024b4:	01213823          	sd	s2,16(sp)
    800024b8:	01313423          	sd	s3,8(sp)
    800024bc:	01413023          	sd	s4,0(sp)
    800024c0:	03010413          	addi	s0,sp,48
    800024c4:	00050993          	mv	s3,a0
    800024c8:	00058a13          	mv	s4,a1
    LOCK();
    800024cc:	00100613          	li	a2,1
    800024d0:	00000593          	li	a1,0
    800024d4:	0000a517          	auipc	a0,0xa
    800024d8:	c7450513          	addi	a0,a0,-908 # 8000c148 <lockPrint>
    800024dc:	fffff097          	auipc	ra,0xfffff
    800024e0:	b24080e7          	jalr	-1244(ra) # 80001000 <copy_and_swap>
    800024e4:	fe0514e3          	bnez	a0,800024cc <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800024e8:	00000913          	li	s2,0
    800024ec:	00090493          	mv	s1,s2
    800024f0:	0019091b          	addiw	s2,s2,1
    800024f4:	03495a63          	bge	s2,s4,80002528 <_Z9getStringPci+0x84>
        cc = getc();
    800024f8:	fffff097          	auipc	ra,0xfffff
    800024fc:	714080e7          	jalr	1812(ra) # 80001c0c <_Z4getcv>
        if(cc < 1)
    80002500:	02050463          	beqz	a0,80002528 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80002504:	009984b3          	add	s1,s3,s1
    80002508:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000250c:	00a00793          	li	a5,10
    80002510:	00f50a63          	beq	a0,a5,80002524 <_Z9getStringPci+0x80>
    80002514:	00d00793          	li	a5,13
    80002518:	fcf51ae3          	bne	a0,a5,800024ec <_Z9getStringPci+0x48>
        buf[i++] = c;
    8000251c:	00090493          	mv	s1,s2
    80002520:	0080006f          	j	80002528 <_Z9getStringPci+0x84>
    80002524:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002528:	009984b3          	add	s1,s3,s1
    8000252c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002530:	00000613          	li	a2,0
    80002534:	00100593          	li	a1,1
    80002538:	0000a517          	auipc	a0,0xa
    8000253c:	c1050513          	addi	a0,a0,-1008 # 8000c148 <lockPrint>
    80002540:	fffff097          	auipc	ra,0xfffff
    80002544:	ac0080e7          	jalr	-1344(ra) # 80001000 <copy_and_swap>
    80002548:	fe0514e3          	bnez	a0,80002530 <_Z9getStringPci+0x8c>
    return buf;
}
    8000254c:	00098513          	mv	a0,s3
    80002550:	02813083          	ld	ra,40(sp)
    80002554:	02013403          	ld	s0,32(sp)
    80002558:	01813483          	ld	s1,24(sp)
    8000255c:	01013903          	ld	s2,16(sp)
    80002560:	00813983          	ld	s3,8(sp)
    80002564:	00013a03          	ld	s4,0(sp)
    80002568:	03010113          	addi	sp,sp,48
    8000256c:	00008067          	ret

0000000080002570 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002570:	ff010113          	addi	sp,sp,-16
    80002574:	00813423          	sd	s0,8(sp)
    80002578:	01010413          	addi	s0,sp,16
    8000257c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002580:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002584:	0006c603          	lbu	a2,0(a3)
    80002588:	fd06071b          	addiw	a4,a2,-48
    8000258c:	0ff77713          	andi	a4,a4,255
    80002590:	00900793          	li	a5,9
    80002594:	02e7e063          	bltu	a5,a4,800025b4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002598:	0025179b          	slliw	a5,a0,0x2
    8000259c:	00a787bb          	addw	a5,a5,a0
    800025a0:	0017979b          	slliw	a5,a5,0x1
    800025a4:	00168693          	addi	a3,a3,1
    800025a8:	00c787bb          	addw	a5,a5,a2
    800025ac:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800025b0:	fd5ff06f          	j	80002584 <_Z11stringToIntPKc+0x14>
    return n;
}
    800025b4:	00813403          	ld	s0,8(sp)
    800025b8:	01010113          	addi	sp,sp,16
    800025bc:	00008067          	ret

00000000800025c0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800025c0:	fc010113          	addi	sp,sp,-64
    800025c4:	02113c23          	sd	ra,56(sp)
    800025c8:	02813823          	sd	s0,48(sp)
    800025cc:	02913423          	sd	s1,40(sp)
    800025d0:	03213023          	sd	s2,32(sp)
    800025d4:	01313c23          	sd	s3,24(sp)
    800025d8:	04010413          	addi	s0,sp,64
    800025dc:	00050493          	mv	s1,a0
    800025e0:	00058913          	mv	s2,a1
    800025e4:	00060993          	mv	s3,a2
    LOCK();
    800025e8:	00100613          	li	a2,1
    800025ec:	00000593          	li	a1,0
    800025f0:	0000a517          	auipc	a0,0xa
    800025f4:	b5850513          	addi	a0,a0,-1192 # 8000c148 <lockPrint>
    800025f8:	fffff097          	auipc	ra,0xfffff
    800025fc:	a08080e7          	jalr	-1528(ra) # 80001000 <copy_and_swap>
    80002600:	fe0514e3          	bnez	a0,800025e8 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002604:	00098463          	beqz	s3,8000260c <_Z8printIntiii+0x4c>
    80002608:	0804c463          	bltz	s1,80002690 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000260c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002610:	00000593          	li	a1,0
    }

    i = 0;
    80002614:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002618:	0009079b          	sext.w	a5,s2
    8000261c:	0325773b          	remuw	a4,a0,s2
    80002620:	00048613          	mv	a2,s1
    80002624:	0014849b          	addiw	s1,s1,1
    80002628:	02071693          	slli	a3,a4,0x20
    8000262c:	0206d693          	srli	a3,a3,0x20
    80002630:	00009717          	auipc	a4,0x9
    80002634:	68870713          	addi	a4,a4,1672 # 8000bcb8 <digits>
    80002638:	00d70733          	add	a4,a4,a3
    8000263c:	00074683          	lbu	a3,0(a4)
    80002640:	fd040713          	addi	a4,s0,-48
    80002644:	00c70733          	add	a4,a4,a2
    80002648:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000264c:	0005071b          	sext.w	a4,a0
    80002650:	0325553b          	divuw	a0,a0,s2
    80002654:	fcf772e3          	bgeu	a4,a5,80002618 <_Z8printIntiii+0x58>
    if(neg)
    80002658:	00058c63          	beqz	a1,80002670 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    8000265c:	fd040793          	addi	a5,s0,-48
    80002660:	009784b3          	add	s1,a5,s1
    80002664:	02d00793          	li	a5,45
    80002668:	fef48823          	sb	a5,-16(s1)
    8000266c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002670:	fff4849b          	addiw	s1,s1,-1
    80002674:	0204c463          	bltz	s1,8000269c <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80002678:	fd040793          	addi	a5,s0,-48
    8000267c:	009787b3          	add	a5,a5,s1
    80002680:	ff07c503          	lbu	a0,-16(a5)
    80002684:	fffff097          	auipc	ra,0xfffff
    80002688:	5b0080e7          	jalr	1456(ra) # 80001c34 <_Z4putcc>
    8000268c:	fe5ff06f          	j	80002670 <_Z8printIntiii+0xb0>
        x = -xx;
    80002690:	4090053b          	negw	a0,s1
        neg = 1;
    80002694:	00100593          	li	a1,1
        x = -xx;
    80002698:	f7dff06f          	j	80002614 <_Z8printIntiii+0x54>

    UNLOCK();
    8000269c:	00000613          	li	a2,0
    800026a0:	00100593          	li	a1,1
    800026a4:	0000a517          	auipc	a0,0xa
    800026a8:	aa450513          	addi	a0,a0,-1372 # 8000c148 <lockPrint>
    800026ac:	fffff097          	auipc	ra,0xfffff
    800026b0:	954080e7          	jalr	-1708(ra) # 80001000 <copy_and_swap>
    800026b4:	fe0514e3          	bnez	a0,8000269c <_Z8printIntiii+0xdc>
    800026b8:	03813083          	ld	ra,56(sp)
    800026bc:	03013403          	ld	s0,48(sp)
    800026c0:	02813483          	ld	s1,40(sp)
    800026c4:	02013903          	ld	s2,32(sp)
    800026c8:	01813983          	ld	s3,24(sp)
    800026cc:	04010113          	addi	sp,sp,64
    800026d0:	00008067          	ret

00000000800026d4 <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    800026d4:	ff010113          	addi	sp,sp,-16
    800026d8:	00813423          	sd	s0,8(sp)
    800026dc:	01010413          	addi	s0,sp,16
    val = init;
    800026e0:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    800026e4:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    800026e8:	00053823          	sd	zero,16(a0)
}
    800026ec:	00813403          	ld	s0,8(sp)
    800026f0:	01010113          	addi	sp,sp,16
    800026f4:	00008067          	ret

00000000800026f8 <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    800026f8:	fe010113          	addi	sp,sp,-32
    800026fc:	00113c23          	sd	ra,24(sp)
    80002700:	00813823          	sd	s0,16(sp)
    80002704:	00913423          	sd	s1,8(sp)
    80002708:	01213023          	sd	s2,0(sp)
    8000270c:	02010413          	addi	s0,sp,32
    80002710:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002714:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002718:	02050063          	beqz	a0,80002738 <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    8000271c:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002720:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002724:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002728:	00002097          	auipc	ra,0x2
    8000272c:	d8c080e7          	jalr	-628(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002730:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002734:	fe5ff06f          	j	80002718 <_ZN3SCBD1Ev+0x20>
    }
}
    80002738:	01813083          	ld	ra,24(sp)
    8000273c:	01013403          	ld	s0,16(sp)
    80002740:	00813483          	ld	s1,8(sp)
    80002744:	00013903          	ld	s2,0(sp)
    80002748:	02010113          	addi	sp,sp,32
    8000274c:	00008067          	ret

0000000080002750 <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    80002750:	ff010113          	addi	sp,sp,-16
    80002754:	00113423          	sd	ra,8(sp)
    80002758:	00813023          	sd	s0,0(sp)
    8000275c:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002760:	00853783          	ld	a5,8(a0)
    80002764:	04078063          	beqz	a5,800027a4 <_ZN3SCB5blockEv+0x54>
    80002768:	01053703          	ld	a4,16(a0)
    8000276c:	0000a797          	auipc	a5,0xa
    80002770:	8047b783          	ld	a5,-2044(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80002774:	0007b783          	ld	a5,0(a5)
    80002778:	04f73423          	sd	a5,72(a4)
    8000277c:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002780:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002784:	00300713          	li	a4,3
    80002788:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    8000278c:	00000097          	auipc	ra,0x0
    80002790:	2c0080e7          	jalr	704(ra) # 80002a4c <_ZN3TCB8dispatchEv>
}
    80002794:	00813083          	ld	ra,8(sp)
    80002798:	00013403          	ld	s0,0(sp)
    8000279c:	01010113          	addi	sp,sp,16
    800027a0:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800027a4:	00009797          	auipc	a5,0x9
    800027a8:	7cc7b783          	ld	a5,1996(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    800027ac:	0007b783          	ld	a5,0(a5)
    800027b0:	00f53423          	sd	a5,8(a0)
    800027b4:	fc9ff06f          	j	8000277c <_ZN3SCB5blockEv+0x2c>

00000000800027b8 <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    800027b8:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    800027bc:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    800027c0:	04853703          	ld	a4,72(a0)
    800027c4:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    800027c8:	04053423          	sd	zero,72(a0)
    if(tcb) {
    800027cc:	02050a63          	beqz	a0,80002800 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    800027d0:	ff010113          	addi	sp,sp,-16
    800027d4:	00113423          	sd	ra,8(sp)
    800027d8:	00813023          	sd	s0,0(sp)
    800027dc:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    800027e0:	00100793          	li	a5,1
    800027e4:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    800027e8:	00002097          	auipc	ra,0x2
    800027ec:	ccc080e7          	jalr	-820(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
    }
}
    800027f0:	00813083          	ld	ra,8(sp)
    800027f4:	00013403          	ld	s0,0(sp)
    800027f8:	01010113          	addi	sp,sp,16
    800027fc:	00008067          	ret
    80002800:	00008067          	ret

0000000080002804 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80002804:	00009797          	auipc	a5,0x9
    80002808:	76c7b783          	ld	a5,1900(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000280c:	0007b783          	ld	a5,0(a5)
    80002810:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002814:	00052783          	lw	a5,0(a0)
    80002818:	fff7879b          	addiw	a5,a5,-1
    8000281c:	00f52023          	sw	a5,0(a0)
    80002820:	02079713          	slli	a4,a5,0x20
    80002824:	00074463          	bltz	a4,8000282c <_ZN3SCB4waitEv+0x28>
    80002828:	00008067          	ret
void SCB::wait() {
    8000282c:	ff010113          	addi	sp,sp,-16
    80002830:	00113423          	sd	ra,8(sp)
    80002834:	00813023          	sd	s0,0(sp)
    80002838:	01010413          	addi	s0,sp,16
        block();
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	f14080e7          	jalr	-236(ra) # 80002750 <_ZN3SCB5blockEv>
}
    80002844:	00813083          	ld	ra,8(sp)
    80002848:	00013403          	ld	s0,0(sp)
    8000284c:	01010113          	addi	sp,sp,16
    80002850:	00008067          	ret

0000000080002854 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80002854:	00052783          	lw	a5,0(a0)
    80002858:	0017871b          	addiw	a4,a5,1
    8000285c:	00e52023          	sw	a4,0(a0)
    80002860:	0007c463          	bltz	a5,80002868 <_ZN3SCB6signalEv+0x14>
    80002864:	00008067          	ret
void SCB::signal(){
    80002868:	ff010113          	addi	sp,sp,-16
    8000286c:	00113423          	sd	ra,8(sp)
    80002870:	00813023          	sd	s0,0(sp)
    80002874:	01010413          	addi	s0,sp,16
        deblock();
    80002878:	00000097          	auipc	ra,0x0
    8000287c:	f40080e7          	jalr	-192(ra) # 800027b8 <_ZN3SCB7deblockEv>
}
    80002880:	00813083          	ld	ra,8(sp)
    80002884:	00013403          	ld	s0,0(sp)
    80002888:	01010113          	addi	sp,sp,16
    8000288c:	00008067          	ret

0000000080002890 <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    80002890:	ff010113          	addi	sp,sp,-16
    80002894:	00113423          	sd	ra,8(sp)
    80002898:	00813023          	sd	s0,0(sp)
    8000289c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    800028a0:	00000097          	auipc	ra,0x0
    800028a4:	3f4080e7          	jalr	1012(ra) # 80002c94 <_ZN15MemoryAllocator7kmallocEm>
}
    800028a8:	00813083          	ld	ra,8(sp)
    800028ac:	00013403          	ld	s0,0(sp)
    800028b0:	01010113          	addi	sp,sp,16
    800028b4:	00008067          	ret

00000000800028b8 <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    800028b8:	ff010113          	addi	sp,sp,-16
    800028bc:	00113423          	sd	ra,8(sp)
    800028c0:	00813023          	sd	s0,0(sp)
    800028c4:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    800028c8:	00000097          	auipc	ra,0x0
    800028cc:	5f4080e7          	jalr	1524(ra) # 80002ebc <_ZN15MemoryAllocator5kfreeEPv>
}
    800028d0:	00813083          	ld	ra,8(sp)
    800028d4:	00013403          	ld	s0,0(sp)
    800028d8:	01010113          	addi	sp,sp,16
    800028dc:	00008067          	ret

00000000800028e0 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    800028e0:	ff010113          	addi	sp,sp,-16
    800028e4:	00813423          	sd	s0,8(sp)
    800028e8:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    800028ec:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    800028f0:	05200513          	li	a0,82
    asm("ecall");
    800028f4:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    800028f8:	00050513          	mv	a0,a0
    return status;
}
    800028fc:	0005051b          	sext.w	a0,a0
    80002900:	00813403          	ld	s0,8(sp)
    80002904:	01010113          	addi	sp,sp,16
    80002908:	00008067          	ret

000000008000290c <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    8000290c:	fe010113          	addi	sp,sp,-32
    80002910:	00113c23          	sd	ra,24(sp)
    80002914:	00813823          	sd	s0,16(sp)
    80002918:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    8000291c:	fe840513          	addi	a0,s0,-24
    80002920:	fffff097          	auipc	ra,0xfffff
    80002924:	3d8080e7          	jalr	984(ra) # 80001cf8 <_ZN6SystemC1Ev>

    return 0;
    80002928:	00000513          	li	a0,0
    8000292c:	01813083          	ld	ra,24(sp)
    80002930:	01013403          	ld	s0,16(sp)
    80002934:	02010113          	addi	sp,sp,32
    80002938:	00008067          	ret

000000008000293c <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    8000293c:	ff010113          	addi	sp,sp,-16
    80002940:	00113423          	sd	ra,8(sp)
    80002944:	00813023          	sd	s0,0(sp)
    80002948:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    8000294c:	00001097          	auipc	ra,0x1
    80002950:	cbc080e7          	jalr	-836(ra) # 80003608 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    80002954:	00009797          	auipc	a5,0x9
    80002958:	7fc7b783          	ld	a5,2044(a5) # 8000c150 <_ZN3TCB7runningE>
    8000295c:	0187b703          	ld	a4,24(a5)
    80002960:	0207b503          	ld	a0,32(a5)
    80002964:	000700e7          	jalr	a4

    thread_exit();
    80002968:	fffff097          	auipc	ra,0xfffff
    8000296c:	0cc080e7          	jalr	204(ra) # 80001a34 <_Z11thread_exitv>
}
    80002970:	00813083          	ld	ra,8(sp)
    80002974:	00013403          	ld	s0,0(sp)
    80002978:	01010113          	addi	sp,sp,16
    8000297c:	00008067          	ret

0000000080002980 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002980:	ff010113          	addi	sp,sp,-16
    80002984:	00813423          	sd	s0,8(sp)
    80002988:	01010413          	addi	s0,sp,16
    8000298c:	04053823          	sd	zero,80(a0)
    80002990:	04053c23          	sd	zero,88(a0)
    80002994:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002998:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    8000299c:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    800029a0:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    800029a4:	04058263          	beqz	a1,800029e8 <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    800029a8:	00068793          	mv	a5,a3
    800029ac:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    800029b0:	00100793          	li	a5,1
    800029b4:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    800029b8:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    800029bc:	02058a63          	beqz	a1,800029f0 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    800029c0:	000017b7          	lui	a5,0x1
    800029c4:	00f686b3          	add	a3,a3,a5
    800029c8:	00d53023          	sd	a3,0(a0)
    800029cc:	00000797          	auipc	a5,0x0
    800029d0:	f7078793          	addi	a5,a5,-144 # 8000293c <_ZN3TCB7wrapperEPv>
    800029d4:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    800029d8:	00052a23          	sw	zero,20(a0)
}
    800029dc:	00813403          	ld	s0,8(sp)
    800029e0:	01010113          	addi	sp,sp,16
    800029e4:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    800029e8:	00000793          	li	a5,0
    800029ec:	fc1ff06f          	j	800029ac <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    800029f0:	00000693          	li	a3,0
    800029f4:	fd5ff06f          	j	800029c8 <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

00000000800029f8 <_ZN3TCB4freeEv>:
void TCB::free(){
    800029f8:	ff010113          	addi	sp,sp,-16
    800029fc:	00113423          	sd	ra,8(sp)
    80002a00:	00813023          	sd	s0,0(sp)
    80002a04:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    80002a08:	02853503          	ld	a0,40(a0)
    80002a0c:	00000097          	auipc	ra,0x0
    80002a10:	4b0080e7          	jalr	1200(ra) # 80002ebc <_ZN15MemoryAllocator5kfreeEPv>
}
    80002a14:	00813083          	ld	ra,8(sp)
    80002a18:	00013403          	ld	s0,0(sp)
    80002a1c:	01010113          	addi	sp,sp,16
    80002a20:	00008067          	ret

0000000080002a24 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002a24:	ff010113          	addi	sp,sp,-16
    80002a28:	00113423          	sd	ra,8(sp)
    80002a2c:	00813023          	sd	s0,0(sp)
    80002a30:	01010413          	addi	s0,sp,16
    free();
    80002a34:	00000097          	auipc	ra,0x0
    80002a38:	fc4080e7          	jalr	-60(ra) # 800029f8 <_ZN3TCB4freeEv>
}
    80002a3c:	00813083          	ld	ra,8(sp)
    80002a40:	00013403          	ld	s0,0(sp)
    80002a44:	01010113          	addi	sp,sp,16
    80002a48:	00008067          	ret

0000000080002a4c <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002a4c:	fe010113          	addi	sp,sp,-32
    80002a50:	00113c23          	sd	ra,24(sp)
    80002a54:	00813823          	sd	s0,16(sp)
    80002a58:	00913423          	sd	s1,8(sp)
    80002a5c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002a60:	00009497          	auipc	s1,0x9
    80002a64:	6f04b483          	ld	s1,1776(s1) # 8000c150 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002a68:	0104a703          	lw	a4,16(s1)
    80002a6c:	00100793          	li	a5,1
    80002a70:	04e7f663          	bgeu	a5,a4,80002abc <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002a74:	00002097          	auipc	ra,0x2
    80002a78:	a88080e7          	jalr	-1400(ra) # 800044fc <_ZN9Scheduler3getEv>
    80002a7c:	00009797          	auipc	a5,0x9
    80002a80:	6ca7ba23          	sd	a0,1748(a5) # 8000c150 <_ZN3TCB7runningE>
    if(running) {
    80002a84:	02050263          	beqz	a0,80002aa8 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002a88:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002a8c:	00001097          	auipc	ra,0x1
    80002a90:	cb0080e7          	jalr	-848(ra) # 8000373c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002a94:	00009597          	auipc	a1,0x9
    80002a98:	6bc5b583          	ld	a1,1724(a1) # 8000c150 <_ZN3TCB7runningE>
    80002a9c:	00048513          	mv	a0,s1
    80002aa0:	ffffe097          	auipc	ra,0xffffe
    80002aa4:	6a0080e7          	jalr	1696(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002aa8:	01813083          	ld	ra,24(sp)
    80002aac:	01013403          	ld	s0,16(sp)
    80002ab0:	00813483          	ld	s1,8(sp)
    80002ab4:	02010113          	addi	sp,sp,32
    80002ab8:	00008067          	ret
        Scheduler::put(old);
    80002abc:	00048513          	mv	a0,s1
    80002ac0:	00002097          	auipc	ra,0x2
    80002ac4:	9f4080e7          	jalr	-1548(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
    80002ac8:	fadff06f          	j	80002a74 <_ZN3TCB8dispatchEv+0x28>

0000000080002acc <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002acc:	ff010113          	addi	sp,sp,-16
    80002ad0:	00113423          	sd	ra,8(sp)
    80002ad4:	00813023          	sd	s0,0(sp)
    80002ad8:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	1b8080e7          	jalr	440(ra) # 80002c94 <_ZN15MemoryAllocator7kmallocEm>
}
    80002ae4:	00813083          	ld	ra,8(sp)
    80002ae8:	00013403          	ld	s0,0(sp)
    80002aec:	01010113          	addi	sp,sp,16
    80002af0:	00008067          	ret

0000000080002af4 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002af4:	fd010113          	addi	sp,sp,-48
    80002af8:	02113423          	sd	ra,40(sp)
    80002afc:	02813023          	sd	s0,32(sp)
    80002b00:	00913c23          	sd	s1,24(sp)
    80002b04:	01213823          	sd	s2,16(sp)
    80002b08:	01313423          	sd	s3,8(sp)
    80002b0c:	01413023          	sd	s4,0(sp)
    80002b10:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002b14:	07000513          	li	a0,112
    80002b18:	00000097          	auipc	ra,0x0
    80002b1c:	fb4080e7          	jalr	-76(ra) # 80002acc <_ZN3TCBnwEm>
    80002b20:	00050493          	mv	s1,a0
    80002b24:	00200713          	li	a4,2
    80002b28:	00000693          	li	a3,0
    80002b2c:	00000613          	li	a2,0
    80002b30:	00000593          	li	a1,0
    80002b34:	00000097          	auipc	ra,0x0
    80002b38:	e4c080e7          	jalr	-436(ra) # 80002980 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002b3c:	00009a17          	auipc	s4,0x9
    80002b40:	614a0a13          	addi	s4,s4,1556 # 8000c150 <_ZN3TCB7runningE>
    80002b44:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    80002b48:	00100993          	li	s3,1
    80002b4c:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002b50:	04000513          	li	a0,64
    80002b54:	00000097          	auipc	ra,0x0
    80002b58:	140080e7          	jalr	320(ra) # 80002c94 <_ZN15MemoryAllocator7kmallocEm>
    80002b5c:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002b60:	07000513          	li	a0,112
    80002b64:	00000097          	auipc	ra,0x0
    80002b68:	f68080e7          	jalr	-152(ra) # 80002acc <_ZN3TCBnwEm>
    80002b6c:	00050493          	mv	s1,a0
    80002b70:	00200713          	li	a4,2
    80002b74:	00090693          	mv	a3,s2
    80002b78:	00000613          	li	a2,0
    80002b7c:	00009597          	auipc	a1,0x9
    80002b80:	38c5b583          	ld	a1,908(a1) # 8000bf08 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002b84:	00000097          	auipc	ra,0x0
    80002b88:	dfc080e7          	jalr	-516(ra) # 80002980 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002b8c:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    80002b90:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    80002b94:	00048513          	mv	a0,s1
    80002b98:	00002097          	auipc	ra,0x2
    80002b9c:	91c080e7          	jalr	-1764(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
}
    80002ba0:	02813083          	ld	ra,40(sp)
    80002ba4:	02013403          	ld	s0,32(sp)
    80002ba8:	01813483          	ld	s1,24(sp)
    80002bac:	01013903          	ld	s2,16(sp)
    80002bb0:	00813983          	ld	s3,8(sp)
    80002bb4:	00013a03          	ld	s4,0(sp)
    80002bb8:	03010113          	addi	sp,sp,48
    80002bbc:	00008067          	ret

0000000080002bc0 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    80002bc0:	ff010113          	addi	sp,sp,-16
    80002bc4:	00113423          	sd	ra,8(sp)
    80002bc8:	00813023          	sd	s0,0(sp)
    80002bcc:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002bd0:	00000097          	auipc	ra,0x0
    80002bd4:	2ec080e7          	jalr	748(ra) # 80002ebc <_ZN15MemoryAllocator5kfreeEPv>
}
    80002bd8:	00813083          	ld	ra,8(sp)
    80002bdc:	00013403          	ld	s0,0(sp)
    80002be0:	01010113          	addi	sp,sp,16
    80002be4:	00008067          	ret

0000000080002be8 <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80002be8:	ff010113          	addi	sp,sp,-16
    80002bec:	00813423          	sd	s0,8(sp)
    80002bf0:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002bf4:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002bf8:	05100513          	li	a0,81
    asm("ecall");
    80002bfc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002c00:	00050513          	mv	a0,a0
    return status;
    80002c04:	0005051b          	sext.w	a0,a0
    80002c08:	00813403          	ld	s0,8(sp)
    80002c0c:	01010113          	addi	sp,sp,16
    80002c10:	00008067          	ret

0000000080002c14 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002c14:	ff010113          	addi	sp,sp,-16
    80002c18:	00813423          	sd	s0,8(sp)
    80002c1c:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002c20:	00009797          	auipc	a5,0x9
    80002c24:	2d87b783          	ld	a5,728(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002c28:	0007b603          	ld	a2,0(a5)
    80002c2c:	00c65793          	srli	a5,a2,0xc
    80002c30:	00278793          	addi	a5,a5,2
    80002c34:	00c79793          	slli	a5,a5,0xc
    80002c38:	01000737          	lui	a4,0x1000
    80002c3c:	00e787b3          	add	a5,a5,a4
    80002c40:	00009717          	auipc	a4,0x9
    80002c44:	53870713          	addi	a4,a4,1336 # 8000c178 <_ZN15MemoryAllocator11freeMemTailE>
    80002c48:	00f73023          	sd	a5,0(a4)
    80002c4c:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002c50:	0007b823          	sd	zero,16(a5)
    80002c54:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002c58:	00073823          	sd	zero,16(a4)
    80002c5c:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    80002c60:	00009697          	auipc	a3,0x9
    80002c64:	3206b683          	ld	a3,800(a3) # 8000bf80 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002c68:	0006b683          	ld	a3,0(a3)
    80002c6c:	40c686b3          	sub	a3,a3,a2
    80002c70:	fe868693          	addi	a3,a3,-24
    80002c74:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002c78:	00873783          	ld	a5,8(a4)
    80002c7c:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002c80:	00100793          	li	a5,1
    80002c84:	02f70023          	sb	a5,32(a4)
}
    80002c88:	00813403          	ld	s0,8(sp)
    80002c8c:	01010113          	addi	sp,sp,16
    80002c90:	00008067          	ret

0000000080002c94 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002c94:	ff010113          	addi	sp,sp,-16
    80002c98:	00813423          	sd	s0,8(sp)
    80002c9c:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    80002ca0:	14050263          	beqz	a0,80002de4 <_ZN15MemoryAllocator7kmallocEm+0x150>
    80002ca4:	00050793          	mv	a5,a0
    80002ca8:	00009517          	auipc	a0,0x9
    80002cac:	4d853503          	ld	a0,1240(a0) # 8000c180 <_ZN15MemoryAllocator11freeMemHeadE>
    80002cb0:	0a050a63          	beqz	a0,80002d64 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002cb4:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002cb8:	00000613          	li	a2,0
    80002cbc:	00c0006f          	j	80002cc8 <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002cc0:	00050613          	mv	a2,a0
    80002cc4:	01053503          	ld	a0,16(a0)
    80002cc8:	00050863          	beqz	a0,80002cd8 <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002ccc:	00053683          	ld	a3,0(a0)
    80002cd0:	01878713          	addi	a4,a5,24
    80002cd4:	fee6e6e3          	bltu	a3,a4,80002cc0 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002cd8:	08050663          	beqz	a0,80002d64 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80002cdc:	00053683          	ld	a3,0(a0)
    80002ce0:	01868713          	addi	a4,a3,24
    80002ce4:	00e50733          	add	a4,a0,a4
    80002ce8:	00009597          	auipc	a1,0x9
    80002cec:	2985b583          	ld	a1,664(a1) # 8000bf80 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80002cf0:	0005b583          	ld	a1,0(a1)
    80002cf4:	00b76463          	bltu	a4,a1,80002cfc <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002cf8:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002cfc:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002d00:	05700593          	li	a1,87
    80002d04:	08d5f063          	bgeu	a1,a3,80002d84 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80002d08:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002d0c:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002d10:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002d14:	01053583          	ld	a1,16(a0)
    80002d18:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002d1c:	00853583          	ld	a1,8(a0)
    80002d20:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80002d24:	fe868693          	addi	a3,a3,-24
    80002d28:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002d2c:	04060263          	beqz	a2,80002d70 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    80002d30:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80002d34:	00009797          	auipc	a5,0x9
    80002d38:	45c7b783          	ld	a5,1116(a5) # 8000c190 <_ZN15MemoryAllocator12allocMemHeadE>
    80002d3c:	06078463          	beqz	a5,80002da4 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002d40:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80002d44:	08070063          	beqz	a4,80002dc4 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80002d48:	00873783          	ld	a5,8(a4)
    80002d4c:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002d50:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80002d54:	00873783          	ld	a5,8(a4)
    80002d58:	06078063          	beqz	a5,80002db8 <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    80002d5c:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80002d60:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80002d64:	00813403          	ld	s0,8(sp)
    80002d68:	01010113          	addi	sp,sp,16
    80002d6c:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80002d70:	00009697          	auipc	a3,0x9
    80002d74:	40868693          	addi	a3,a3,1032 # 8000c178 <_ZN15MemoryAllocator11freeMemTailE>
    80002d78:	00f6b023          	sd	a5,0(a3)
    80002d7c:	00f6b423          	sd	a5,8(a3)
    80002d80:	fb5ff06f          	j	80002d34 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    80002d84:	00060863          	beqz	a2,80002d94 <_ZN15MemoryAllocator7kmallocEm+0x100>
    80002d88:	01053783          	ld	a5,16(a0)
    80002d8c:	00f63823          	sd	a5,16(a2)
    80002d90:	fa5ff06f          	j	80002d34 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    80002d94:	01053783          	ld	a5,16(a0)
    80002d98:	00009697          	auipc	a3,0x9
    80002d9c:	3ef6b423          	sd	a5,1000(a3) # 8000c180 <_ZN15MemoryAllocator11freeMemHeadE>
    80002da0:	f95ff06f          	j	80002d34 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    80002da4:	00009797          	auipc	a5,0x9
    80002da8:	3d478793          	addi	a5,a5,980 # 8000c178 <_ZN15MemoryAllocator11freeMemTailE>
    80002dac:	00a7b823          	sd	a0,16(a5)
    80002db0:	00a7bc23          	sd	a0,24(a5)
    80002db4:	fadff06f          	j	80002d60 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    80002db8:	00009797          	auipc	a5,0x9
    80002dbc:	3ca7bc23          	sd	a0,984(a5) # 8000c190 <_ZN15MemoryAllocator12allocMemHeadE>
    80002dc0:	fa1ff06f          	j	80002d60 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    80002dc4:	00009797          	auipc	a5,0x9
    80002dc8:	3b478793          	addi	a5,a5,948 # 8000c178 <_ZN15MemoryAllocator11freeMemTailE>
    80002dcc:	0107b703          	ld	a4,16(a5)
    80002dd0:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002dd4:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002dd8:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002ddc:	00a7b823          	sd	a0,16(a5)
    80002de0:	f81ff06f          	j	80002d60 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80002de4:	00000513          	li	a0,0
    80002de8:	f7dff06f          	j	80002d64 <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080002dec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002dec:	ff010113          	addi	sp,sp,-16
    80002df0:	00813423          	sd	s0,8(sp)
    80002df4:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002df8:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002dfc:	00000713          	li	a4,0
    80002e00:	00078a63          	beqz	a5,80002e14 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002e04:	00a7f863          	bgeu	a5,a0,80002e14 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002e08:	00078713          	mv	a4,a5
    80002e0c:	0107b783          	ld	a5,16(a5)
    80002e10:	ff1ff06f          	j	80002e00 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80002e14:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002e18:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002e1c:	00078463          	beqz	a5,80002e24 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002e20:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80002e24:	02070263          	beqz	a4,80002e48 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002e28:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002e2c:	0005b703          	ld	a4,0(a1)
    80002e30:	00009797          	auipc	a5,0x9
    80002e34:	3507b783          	ld	a5,848(a5) # 8000c180 <_ZN15MemoryAllocator11freeMemHeadE>
    80002e38:	00f70c63          	beq	a4,a5,80002e50 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002e3c:	00813403          	ld	s0,8(sp)
    80002e40:	01010113          	addi	sp,sp,16
    80002e44:	00008067          	ret
        *head = blk;
    80002e48:	00a5b023          	sd	a0,0(a1)
    80002e4c:	fe1ff06f          	j	80002e2c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002e50:	01053783          	ld	a5,16(a0)
    80002e54:	00078a63          	beqz	a5,80002e68 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002e58:	00053683          	ld	a3,0(a0)
    80002e5c:	00d50733          	add	a4,a0,a3
    80002e60:	01870713          	addi	a4,a4,24
    80002e64:	02f70e63          	beq	a4,a5,80002ea0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80002e68:	00853783          	ld	a5,8(a0)
    80002e6c:	fc0788e3          	beqz	a5,80002e3c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002e70:	0007b683          	ld	a3,0(a5)
    80002e74:	00d78733          	add	a4,a5,a3
    80002e78:	01870713          	addi	a4,a4,24
    80002e7c:	fca710e3          	bne	a4,a0,80002e3c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002e80:	00053703          	ld	a4,0(a0)
    80002e84:	00e68733          	add	a4,a3,a4
    80002e88:	01870713          	addi	a4,a4,24
    80002e8c:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002e90:	00853783          	ld	a5,8(a0)
    80002e94:	01053703          	ld	a4,16(a0)
    80002e98:	00e7b823          	sd	a4,16(a5)
}
    80002e9c:	fa1ff06f          	j	80002e3c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80002ea0:	0007b703          	ld	a4,0(a5)
    80002ea4:	00e68733          	add	a4,a3,a4
    80002ea8:	01870713          	addi	a4,a4,24
    80002eac:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80002eb0:	0107b783          	ld	a5,16(a5)
    80002eb4:	00f53823          	sd	a5,16(a0)
    80002eb8:	fb1ff06f          	j	80002e68 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002ebc <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002ebc:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002ec0:	00009697          	auipc	a3,0x9
    80002ec4:	2d06b683          	ld	a3,720(a3) # 8000c190 <_ZN15MemoryAllocator12allocMemHeadE>
    80002ec8:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002ecc:	00050a63          	beqz	a0,80002ee0 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002ed0:	fe870793          	addi	a5,a4,-24
    80002ed4:	00a78663          	beq	a5,a0,80002ee0 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002ed8:	01053503          	ld	a0,16(a0)
    80002edc:	ff1ff06f          	j	80002ecc <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002ee0:	08050463          	beqz	a0,80002f68 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80002ee4:	ff010113          	addi	sp,sp,-16
    80002ee8:	00113423          	sd	ra,8(sp)
    80002eec:	00813023          	sd	s0,0(sp)
    80002ef0:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80002ef4:	00009797          	auipc	a5,0x9
    80002ef8:	2947b783          	ld	a5,660(a5) # 8000c188 <_ZN15MemoryAllocator12allocMemTailE>
    80002efc:	04a78663          	beq	a5,a0,80002f48 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002f00:	04d50c63          	beq	a0,a3,80002f58 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002f04:	01053783          	ld	a5,16(a0)
    80002f08:	00078663          	beqz	a5,80002f14 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002f0c:	00853703          	ld	a4,8(a0)
    80002f10:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80002f14:	00853783          	ld	a5,8(a0)
    80002f18:	00078663          	beqz	a5,80002f24 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002f1c:	01053703          	ld	a4,16(a0)
    80002f20:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80002f24:	00009597          	auipc	a1,0x9
    80002f28:	25c58593          	addi	a1,a1,604 # 8000c180 <_ZN15MemoryAllocator11freeMemHeadE>
    80002f2c:	00000097          	auipc	ra,0x0
    80002f30:	ec0080e7          	jalr	-320(ra) # 80002dec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80002f34:	00000513          	li	a0,0
}
    80002f38:	00813083          	ld	ra,8(sp)
    80002f3c:	00013403          	ld	s0,0(sp)
    80002f40:	01010113          	addi	sp,sp,16
    80002f44:	00008067          	ret
            allocMemTail = blk->prev;
    80002f48:	00853783          	ld	a5,8(a0)
    80002f4c:	00009717          	auipc	a4,0x9
    80002f50:	22f73e23          	sd	a5,572(a4) # 8000c188 <_ZN15MemoryAllocator12allocMemTailE>
    80002f54:	fadff06f          	j	80002f00 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002f58:	01053783          	ld	a5,16(a0)
    80002f5c:	00009717          	auipc	a4,0x9
    80002f60:	22f73a23          	sd	a5,564(a4) # 8000c190 <_ZN15MemoryAllocator12allocMemHeadE>
    80002f64:	fa1ff06f          	j	80002f04 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80002f68:	fff00513          	li	a0,-1
}
    80002f6c:	00008067          	ret

0000000080002f70 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002f70:	fe010113          	addi	sp,sp,-32
    80002f74:	00113c23          	sd	ra,24(sp)
    80002f78:	00813823          	sd	s0,16(sp)
    80002f7c:	00913423          	sd	s1,8(sp)
    80002f80:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002f84:	00009497          	auipc	s1,0x9
    80002f88:	20c4b483          	ld	s1,524(s1) # 8000c190 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002f8c:	00006517          	auipc	a0,0x6
    80002f90:	19450513          	addi	a0,a0,404 # 80009120 <CONSOLE_STATUS+0x110>
    80002f94:	fffff097          	auipc	ra,0xfffff
    80002f98:	494080e7          	jalr	1172(ra) # 80002428 <_Z11printStringPKc>
    while(iter!=nullptr){
    80002f9c:	04048663          	beqz	s1,80002fe8 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002fa0:	00000613          	li	a2,0
    80002fa4:	00a00593          	li	a1,10
    80002fa8:	0004851b          	sext.w	a0,s1
    80002fac:	fffff097          	auipc	ra,0xfffff
    80002fb0:	614080e7          	jalr	1556(ra) # 800025c0 <_Z8printIntiii>
        putc(' ');
    80002fb4:	02000513          	li	a0,32
    80002fb8:	fffff097          	auipc	ra,0xfffff
    80002fbc:	c7c080e7          	jalr	-900(ra) # 80001c34 <_Z4putcc>
        printInt(iter->size);
    80002fc0:	00000613          	li	a2,0
    80002fc4:	00a00593          	li	a1,10
    80002fc8:	0004a503          	lw	a0,0(s1)
    80002fcc:	fffff097          	auipc	ra,0xfffff
    80002fd0:	5f4080e7          	jalr	1524(ra) # 800025c0 <_Z8printIntiii>
        putc('\n');
    80002fd4:	00a00513          	li	a0,10
    80002fd8:	fffff097          	auipc	ra,0xfffff
    80002fdc:	c5c080e7          	jalr	-932(ra) # 80001c34 <_Z4putcc>
        iter=iter->next;
    80002fe0:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002fe4:	fb9ff06f          	j	80002f9c <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002fe8:	00006517          	auipc	a0,0x6
    80002fec:	15850513          	addi	a0,a0,344 # 80009140 <CONSOLE_STATUS+0x130>
    80002ff0:	fffff097          	auipc	ra,0xfffff
    80002ff4:	438080e7          	jalr	1080(ra) # 80002428 <_Z11printStringPKc>
    iter = freeMemHead;
    80002ff8:	00009497          	auipc	s1,0x9
    80002ffc:	1884b483          	ld	s1,392(s1) # 8000c180 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80003000:	04048663          	beqz	s1,8000304c <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80003004:	00000613          	li	a2,0
    80003008:	00a00593          	li	a1,10
    8000300c:	0004851b          	sext.w	a0,s1
    80003010:	fffff097          	auipc	ra,0xfffff
    80003014:	5b0080e7          	jalr	1456(ra) # 800025c0 <_Z8printIntiii>
        putc(' ');
    80003018:	02000513          	li	a0,32
    8000301c:	fffff097          	auipc	ra,0xfffff
    80003020:	c18080e7          	jalr	-1000(ra) # 80001c34 <_Z4putcc>
        printInt(iter->size);
    80003024:	00000613          	li	a2,0
    80003028:	00a00593          	li	a1,10
    8000302c:	0004a503          	lw	a0,0(s1)
    80003030:	fffff097          	auipc	ra,0xfffff
    80003034:	590080e7          	jalr	1424(ra) # 800025c0 <_Z8printIntiii>
        putc('\n');
    80003038:	00a00513          	li	a0,10
    8000303c:	fffff097          	auipc	ra,0xfffff
    80003040:	bf8080e7          	jalr	-1032(ra) # 80001c34 <_Z4putcc>
        iter=iter->next;
    80003044:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003048:	fb9ff06f          	j	80003000 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    8000304c:	00006517          	auipc	a0,0x6
    80003050:	11450513          	addi	a0,a0,276 # 80009160 <CONSOLE_STATUS+0x150>
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	3d4080e7          	jalr	980(ra) # 80002428 <_Z11printStringPKc>
}
    8000305c:	01813083          	ld	ra,24(sp)
    80003060:	01013403          	ld	s0,16(sp)
    80003064:	00813483          	ld	s1,8(sp)
    80003068:	02010113          	addi	sp,sp,32
    8000306c:	00008067          	ret

0000000080003070 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80003070:	ff010113          	addi	sp,sp,-16
    80003074:	00813423          	sd	s0,8(sp)
    80003078:	01010413          	addi	s0,sp,16
    8000307c:	00050813          	mv	a6,a0
    80003080:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80003084:	00000793          	li	a5,0
    80003088:	00c7fe63          	bgeu	a5,a2,800030a4 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    8000308c:	00f50733          	add	a4,a0,a5
    80003090:	00f806b3          	add	a3,a6,a5
    80003094:	0006c683          	lbu	a3,0(a3)
    80003098:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    8000309c:	00178793          	addi	a5,a5,1
    800030a0:	fe9ff06f          	j	80003088 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    800030a4:	00813403          	ld	s0,8(sp)
    800030a8:	01010113          	addi	sp,sp,16
    800030ac:	00008067          	ret

00000000800030b0 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    800030b0:	ff010113          	addi	sp,sp,-16
    800030b4:	00113423          	sd	ra,8(sp)
    800030b8:	00813023          	sd	s0,0(sp)
    800030bc:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800030c0:	00053783          	ld	a5,0(a0)
    800030c4:	0107b783          	ld	a5,16(a5)
    800030c8:	000780e7          	jalr	a5
}
    800030cc:	00813083          	ld	ra,8(sp)
    800030d0:	00013403          	ld	s0,0(sp)
    800030d4:	01010113          	addi	sp,sp,16
    800030d8:	00008067          	ret

00000000800030dc <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    800030dc:	ff010113          	addi	sp,sp,-16
    800030e0:	00113423          	sd	ra,8(sp)
    800030e4:	00813023          	sd	s0,0(sp)
    800030e8:	01010413          	addi	s0,sp,16
    800030ec:	00009797          	auipc	a5,0x9
    800030f0:	c2c78793          	addi	a5,a5,-980 # 8000bd18 <_ZTV9Semaphore+0x10>
    800030f4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800030f8:	00853503          	ld	a0,8(a0)
    800030fc:	fffff097          	auipc	ra,0xfffff
    80003100:	a60080e7          	jalr	-1440(ra) # 80001b5c <_Z9sem_closeP10_semaphore>
};
    80003104:	00813083          	ld	ra,8(sp)
    80003108:	00013403          	ld	s0,0(sp)
    8000310c:	01010113          	addi	sp,sp,16
    80003110:	00008067          	ret

0000000080003114 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80003114:	00009797          	auipc	a5,0x9
    80003118:	c2478793          	addi	a5,a5,-988 # 8000bd38 <_ZTV6Thread+0x10>
    8000311c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80003120:	00853503          	ld	a0,8(a0)
    80003124:	02050663          	beqz	a0,80003150 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80003128:	ff010113          	addi	sp,sp,-16
    8000312c:	00113423          	sd	ra,8(sp)
    80003130:	00813023          	sd	s0,0(sp)
    80003134:	01010413          	addi	s0,sp,16
    delete myHandle;
    80003138:	fffff097          	auipc	ra,0xfffff
    8000313c:	b70080e7          	jalr	-1168(ra) # 80001ca8 <_ZN7_threaddlEPv>
}
    80003140:	00813083          	ld	ra,8(sp)
    80003144:	00013403          	ld	s0,0(sp)
    80003148:	01010113          	addi	sp,sp,16
    8000314c:	00008067          	ret
    80003150:	00008067          	ret

0000000080003154 <_Znwm>:
void* operator new(size_t sz){
    80003154:	ff010113          	addi	sp,sp,-16
    80003158:	00113423          	sd	ra,8(sp)
    8000315c:	00813023          	sd	s0,0(sp)
    80003160:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003164:	ffffe097          	auipc	ra,0xffffe
    80003168:	7f8080e7          	jalr	2040(ra) # 8000195c <_Z9mem_allocm>
}
    8000316c:	00813083          	ld	ra,8(sp)
    80003170:	00013403          	ld	s0,0(sp)
    80003174:	01010113          	addi	sp,sp,16
    80003178:	00008067          	ret

000000008000317c <_Znam>:
void* operator new[](size_t sz){
    8000317c:	ff010113          	addi	sp,sp,-16
    80003180:	00113423          	sd	ra,8(sp)
    80003184:	00813023          	sd	s0,0(sp)
    80003188:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    8000318c:	ffffe097          	auipc	ra,0xffffe
    80003190:	7d0080e7          	jalr	2000(ra) # 8000195c <_Z9mem_allocm>
}
    80003194:	00813083          	ld	ra,8(sp)
    80003198:	00013403          	ld	s0,0(sp)
    8000319c:	01010113          	addi	sp,sp,16
    800031a0:	00008067          	ret

00000000800031a4 <_ZdlPv>:
void operator delete(void *ptr){
    800031a4:	ff010113          	addi	sp,sp,-16
    800031a8:	00113423          	sd	ra,8(sp)
    800031ac:	00813023          	sd	s0,0(sp)
    800031b0:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800031b4:	ffffe097          	auipc	ra,0xffffe
    800031b8:	7d8080e7          	jalr	2008(ra) # 8000198c <_Z8mem_freePv>
}
    800031bc:	00813083          	ld	ra,8(sp)
    800031c0:	00013403          	ld	s0,0(sp)
    800031c4:	01010113          	addi	sp,sp,16
    800031c8:	00008067          	ret

00000000800031cc <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    800031cc:	fe010113          	addi	sp,sp,-32
    800031d0:	00113c23          	sd	ra,24(sp)
    800031d4:	00813823          	sd	s0,16(sp)
    800031d8:	00913423          	sd	s1,8(sp)
    800031dc:	02010413          	addi	s0,sp,32
    800031e0:	00050493          	mv	s1,a0
};
    800031e4:	00000097          	auipc	ra,0x0
    800031e8:	ef8080e7          	jalr	-264(ra) # 800030dc <_ZN9SemaphoreD1Ev>
    800031ec:	00048513          	mv	a0,s1
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	fb4080e7          	jalr	-76(ra) # 800031a4 <_ZdlPv>
    800031f8:	01813083          	ld	ra,24(sp)
    800031fc:	01013403          	ld	s0,16(sp)
    80003200:	00813483          	ld	s1,8(sp)
    80003204:	02010113          	addi	sp,sp,32
    80003208:	00008067          	ret

000000008000320c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    8000320c:	fe010113          	addi	sp,sp,-32
    80003210:	00113c23          	sd	ra,24(sp)
    80003214:	00813823          	sd	s0,16(sp)
    80003218:	00913423          	sd	s1,8(sp)
    8000321c:	02010413          	addi	s0,sp,32
    80003220:	00050493          	mv	s1,a0
}
    80003224:	00000097          	auipc	ra,0x0
    80003228:	ef0080e7          	jalr	-272(ra) # 80003114 <_ZN6ThreadD1Ev>
    8000322c:	00048513          	mv	a0,s1
    80003230:	00000097          	auipc	ra,0x0
    80003234:	f74080e7          	jalr	-140(ra) # 800031a4 <_ZdlPv>
    80003238:	01813083          	ld	ra,24(sp)
    8000323c:	01013403          	ld	s0,16(sp)
    80003240:	00813483          	ld	s1,8(sp)
    80003244:	02010113          	addi	sp,sp,32
    80003248:	00008067          	ret

000000008000324c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    8000324c:	ff010113          	addi	sp,sp,-16
    80003250:	00113423          	sd	ra,8(sp)
    80003254:	00813023          	sd	s0,0(sp)
    80003258:	01010413          	addi	s0,sp,16
    8000325c:	00009797          	auipc	a5,0x9
    80003260:	abc78793          	addi	a5,a5,-1348 # 8000bd18 <_ZTV9Semaphore+0x10>
    80003264:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80003268:	00850513          	addi	a0,a0,8
    8000326c:	fffff097          	auipc	ra,0xfffff
    80003270:	8b8080e7          	jalr	-1864(ra) # 80001b24 <_Z8sem_openPP10_semaphorej>
}
    80003274:	00813083          	ld	ra,8(sp)
    80003278:	00013403          	ld	s0,0(sp)
    8000327c:	01010113          	addi	sp,sp,16
    80003280:	00008067          	ret

0000000080003284 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80003284:	ff010113          	addi	sp,sp,-16
    80003288:	00113423          	sd	ra,8(sp)
    8000328c:	00813023          	sd	s0,0(sp)
    80003290:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003294:	00853503          	ld	a0,8(a0)
    80003298:	fffff097          	auipc	ra,0xfffff
    8000329c:	8f0080e7          	jalr	-1808(ra) # 80001b88 <_Z8sem_waitP10_semaphore>
}
    800032a0:	00813083          	ld	ra,8(sp)
    800032a4:	00013403          	ld	s0,0(sp)
    800032a8:	01010113          	addi	sp,sp,16
    800032ac:	00008067          	ret

00000000800032b0 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800032b0:	ff010113          	addi	sp,sp,-16
    800032b4:	00113423          	sd	ra,8(sp)
    800032b8:	00813023          	sd	s0,0(sp)
    800032bc:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800032c0:	00853503          	ld	a0,8(a0)
    800032c4:	fffff097          	auipc	ra,0xfffff
    800032c8:	8f0080e7          	jalr	-1808(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>
}
    800032cc:	00813083          	ld	ra,8(sp)
    800032d0:	00013403          	ld	s0,0(sp)
    800032d4:	01010113          	addi	sp,sp,16
    800032d8:	00008067          	ret

00000000800032dc <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    800032dc:	ff010113          	addi	sp,sp,-16
    800032e0:	00113423          	sd	ra,8(sp)
    800032e4:	00813023          	sd	s0,0(sp)
    800032e8:	01010413          	addi	s0,sp,16
    800032ec:	00009797          	auipc	a5,0x9
    800032f0:	a4c78793          	addi	a5,a5,-1460 # 8000bd38 <_ZTV6Thread+0x10>
    800032f4:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    800032f8:	00850513          	addi	a0,a0,8
    800032fc:	ffffe097          	auipc	ra,0xffffe
    80003300:	780080e7          	jalr	1920(ra) # 80001a7c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003304:	00813083          	ld	ra,8(sp)
    80003308:	00013403          	ld	s0,0(sp)
    8000330c:	01010113          	addi	sp,sp,16
    80003310:	00008067          	ret

0000000080003314 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80003314:	ff010113          	addi	sp,sp,-16
    80003318:	00113423          	sd	ra,8(sp)
    8000331c:	00813023          	sd	s0,0(sp)
    80003320:	01010413          	addi	s0,sp,16
    80003324:	00009797          	auipc	a5,0x9
    80003328:	a1478793          	addi	a5,a5,-1516 # 8000bd38 <_ZTV6Thread+0x10>
    8000332c:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    80003330:	00050613          	mv	a2,a0
    80003334:	00000597          	auipc	a1,0x0
    80003338:	d7c58593          	addi	a1,a1,-644 # 800030b0 <_ZN6Thread7wrapperEPv>
    8000333c:	00850513          	addi	a0,a0,8
    80003340:	ffffe097          	auipc	ra,0xffffe
    80003344:	73c080e7          	jalr	1852(ra) # 80001a7c <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    80003348:	00813083          	ld	ra,8(sp)
    8000334c:	00013403          	ld	s0,0(sp)
    80003350:	01010113          	addi	sp,sp,16
    80003354:	00008067          	ret

0000000080003358 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80003358:	ff010113          	addi	sp,sp,-16
    8000335c:	00113423          	sd	ra,8(sp)
    80003360:	00813023          	sd	s0,0(sp)
    80003364:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80003368:	fffff097          	auipc	ra,0xfffff
    8000336c:	878080e7          	jalr	-1928(ra) # 80001be0 <_Z10time_sleepm>
}
    80003370:	00813083          	ld	ra,8(sp)
    80003374:	00013403          	ld	s0,0(sp)
    80003378:	01010113          	addi	sp,sp,16
    8000337c:	00008067          	ret

0000000080003380 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80003380:	fe010113          	addi	sp,sp,-32
    80003384:	00113c23          	sd	ra,24(sp)
    80003388:	00813823          	sd	s0,16(sp)
    8000338c:	00913423          	sd	s1,8(sp)
    80003390:	01213023          	sd	s2,0(sp)
    80003394:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80003398:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    8000339c:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    800033a0:	0004b783          	ld	a5,0(s1)
    800033a4:	0187b783          	ld	a5,24(a5)
    800033a8:	00048513          	mv	a0,s1
    800033ac:	000780e7          	jalr	a5
        pt->sleep(time);
    800033b0:	00090513          	mv	a0,s2
    800033b4:	00000097          	auipc	ra,0x0
    800033b8:	fa4080e7          	jalr	-92(ra) # 80003358 <_ZN6Thread5sleepEm>
    while(true){
    800033bc:	fe5ff06f          	j	800033a0 <_ZN14PeriodicThread7wrapperEPv+0x20>

00000000800033c0 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800033c0:	ff010113          	addi	sp,sp,-16
    800033c4:	00113423          	sd	ra,8(sp)
    800033c8:	00813023          	sd	s0,0(sp)
    800033cc:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800033d0:	ffffe097          	auipc	ra,0xffffe
    800033d4:	68c080e7          	jalr	1676(ra) # 80001a5c <_Z15thread_dispatchv>
}
    800033d8:	00813083          	ld	ra,8(sp)
    800033dc:	00013403          	ld	s0,0(sp)
    800033e0:	01010113          	addi	sp,sp,16
    800033e4:	00008067          	ret

00000000800033e8 <_ZN6Thread5startEv>:
int Thread::start() {
    800033e8:	ff010113          	addi	sp,sp,-16
    800033ec:	00113423          	sd	ra,8(sp)
    800033f0:	00813023          	sd	s0,0(sp)
    800033f4:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    800033f8:	00853503          	ld	a0,8(a0)
    800033fc:	ffffe097          	auipc	ra,0xffffe
    80003400:	6fc080e7          	jalr	1788(ra) # 80001af8 <_Z12thread_startP7_thread>
}
    80003404:	00813083          	ld	ra,8(sp)
    80003408:	00013403          	ld	s0,0(sp)
    8000340c:	01010113          	addi	sp,sp,16
    80003410:	00008067          	ret

0000000080003414 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80003414:	fe010113          	addi	sp,sp,-32
    80003418:	00113c23          	sd	ra,24(sp)
    8000341c:	00813823          	sd	s0,16(sp)
    80003420:	00913423          	sd	s1,8(sp)
    80003424:	01213023          	sd	s2,0(sp)
    80003428:	02010413          	addi	s0,sp,32
    8000342c:	00050493          	mv	s1,a0
    80003430:	00058913          	mv	s2,a1
    80003434:	01000513          	li	a0,16
    80003438:	00000097          	auipc	ra,0x0
    8000343c:	d1c080e7          	jalr	-740(ra) # 80003154 <_Znwm>
    80003440:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    80003444:	00953023          	sd	s1,0(a0)
    80003448:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    8000344c:	00000597          	auipc	a1,0x0
    80003450:	f3458593          	addi	a1,a1,-204 # 80003380 <_ZN14PeriodicThread7wrapperEPv>
    80003454:	00048513          	mv	a0,s1
    80003458:	00000097          	auipc	ra,0x0
    8000345c:	e84080e7          	jalr	-380(ra) # 800032dc <_ZN6ThreadC1EPFvPvES0_>
    80003460:	00009797          	auipc	a5,0x9
    80003464:	88878793          	addi	a5,a5,-1912 # 8000bce8 <_ZTV14PeriodicThread+0x10>
    80003468:	00f4b023          	sd	a5,0(s1)
    8000346c:	01813083          	ld	ra,24(sp)
    80003470:	01013403          	ld	s0,16(sp)
    80003474:	00813483          	ld	s1,8(sp)
    80003478:	00013903          	ld	s2,0(sp)
    8000347c:	02010113          	addi	sp,sp,32
    80003480:	00008067          	ret

0000000080003484 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80003484:	ff010113          	addi	sp,sp,-16
    80003488:	00113423          	sd	ra,8(sp)
    8000348c:	00813023          	sd	s0,0(sp)
    80003490:	01010413          	addi	s0,sp,16
    return ::getc();
    80003494:	ffffe097          	auipc	ra,0xffffe
    80003498:	778080e7          	jalr	1912(ra) # 80001c0c <_Z4getcv>
}
    8000349c:	00813083          	ld	ra,8(sp)
    800034a0:	00013403          	ld	s0,0(sp)
    800034a4:	01010113          	addi	sp,sp,16
    800034a8:	00008067          	ret

00000000800034ac <_ZN7Console4putcEc>:

void Console::putc(char c) {
    800034ac:	ff010113          	addi	sp,sp,-16
    800034b0:	00113423          	sd	ra,8(sp)
    800034b4:	00813023          	sd	s0,0(sp)
    800034b8:	01010413          	addi	s0,sp,16
    ::putc(c);
    800034bc:	ffffe097          	auipc	ra,0xffffe
    800034c0:	778080e7          	jalr	1912(ra) # 80001c34 <_Z4putcc>
}
    800034c4:	00813083          	ld	ra,8(sp)
    800034c8:	00013403          	ld	s0,0(sp)
    800034cc:	01010113          	addi	sp,sp,16
    800034d0:	00008067          	ret

00000000800034d4 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    800034d4:	ff010113          	addi	sp,sp,-16
    800034d8:	00813423          	sd	s0,8(sp)
    800034dc:	01010413          	addi	s0,sp,16
    800034e0:	00813403          	ld	s0,8(sp)
    800034e4:	01010113          	addi	sp,sp,16
    800034e8:	00008067          	ret

00000000800034ec <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    800034ec:	ff010113          	addi	sp,sp,-16
    800034f0:	00813423          	sd	s0,8(sp)
    800034f4:	01010413          	addi	s0,sp,16
    800034f8:	00813403          	ld	s0,8(sp)
    800034fc:	01010113          	addi	sp,sp,16
    80003500:	00008067          	ret

0000000080003504 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80003504:	ff010113          	addi	sp,sp,-16
    80003508:	00113423          	sd	ra,8(sp)
    8000350c:	00813023          	sd	s0,0(sp)
    80003510:	01010413          	addi	s0,sp,16
    80003514:	00008797          	auipc	a5,0x8
    80003518:	7d478793          	addi	a5,a5,2004 # 8000bce8 <_ZTV14PeriodicThread+0x10>
    8000351c:	00f53023          	sd	a5,0(a0)
    80003520:	00000097          	auipc	ra,0x0
    80003524:	bf4080e7          	jalr	-1036(ra) # 80003114 <_ZN6ThreadD1Ev>
    80003528:	00813083          	ld	ra,8(sp)
    8000352c:	00013403          	ld	s0,0(sp)
    80003530:	01010113          	addi	sp,sp,16
    80003534:	00008067          	ret

0000000080003538 <_ZN14PeriodicThreadD0Ev>:
    80003538:	fe010113          	addi	sp,sp,-32
    8000353c:	00113c23          	sd	ra,24(sp)
    80003540:	00813823          	sd	s0,16(sp)
    80003544:	00913423          	sd	s1,8(sp)
    80003548:	02010413          	addi	s0,sp,32
    8000354c:	00050493          	mv	s1,a0
    80003550:	00008797          	auipc	a5,0x8
    80003554:	79878793          	addi	a5,a5,1944 # 8000bce8 <_ZTV14PeriodicThread+0x10>
    80003558:	00f53023          	sd	a5,0(a0)
    8000355c:	00000097          	auipc	ra,0x0
    80003560:	bb8080e7          	jalr	-1096(ra) # 80003114 <_ZN6ThreadD1Ev>
    80003564:	00048513          	mv	a0,s1
    80003568:	00000097          	auipc	ra,0x0
    8000356c:	c3c080e7          	jalr	-964(ra) # 800031a4 <_ZdlPv>
    80003570:	01813083          	ld	ra,24(sp)
    80003574:	01013403          	ld	s0,16(sp)
    80003578:	00813483          	ld	s1,8(sp)
    8000357c:	02010113          	addi	sp,sp,32
    80003580:	00008067          	ret

0000000080003584 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003584:	ff010113          	addi	sp,sp,-16
    80003588:	00113423          	sd	ra,8(sp)
    8000358c:	00813023          	sd	s0,0(sp)
    80003590:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003594:	00009797          	auipc	a5,0x9
    80003598:	9bc7b783          	ld	a5,-1604(a5) # 8000bf50 <_GLOBAL_OFFSET_TABLE_+0x70>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    8000359c:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    800035a0:	fffff097          	auipc	ra,0xfffff
    800035a4:	674080e7          	jalr	1652(ra) # 80002c14 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    800035a8:	00001097          	auipc	ra,0x1
    800035ac:	ef4080e7          	jalr	-268(ra) # 8000449c <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    800035b0:	fffff097          	auipc	ra,0xfffff
    800035b4:	544080e7          	jalr	1348(ra) # 80002af4 <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    800035b8:	00001097          	auipc	ra,0x1
    800035bc:	0f8080e7          	jalr	248(ra) # 800046b0 <_ZN11ConsoleUtil10initializeEv>
    SlabAllocator::initialize(BUDDY_START_ADDR_CONST, 4096);
    800035c0:	00009797          	auipc	a5,0x9
    800035c4:	9387b783          	ld	a5,-1736(a5) # 8000bef8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800035c8:	0007b503          	ld	a0,0(a5)
    800035cc:	00c55513          	srli	a0,a0,0xc
    800035d0:	00250513          	addi	a0,a0,2
    800035d4:	000015b7          	lui	a1,0x1
    800035d8:	00c51513          	slli	a0,a0,0xc
    800035dc:	ffffe097          	auipc	ra,0xffffe
    800035e0:	b78080e7          	jalr	-1160(ra) # 80001154 <_ZN13SlabAllocator10initializeEPvm>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    800035e4:	00200793          	li	a5,2
    800035e8:	1047a073          	csrs	sie,a5
    800035ec:	20000713          	li	a4,512
    800035f0:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800035f4:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    800035f8:	00813083          	ld	ra,8(sp)
    800035fc:	00013403          	ld	s0,0(sp)
    80003600:	01010113          	addi	sp,sp,16
    80003604:	00008067          	ret

0000000080003608 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003608:	ff010113          	addi	sp,sp,-16
    8000360c:	00813423          	sd	s0,8(sp)
    80003610:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003614:	14109073          	csrw	sepc,ra
    asm("sret");
    80003618:	10200073          	sret
}
    8000361c:	00813403          	ld	s0,8(sp)
    80003620:	01010113          	addi	sp,sp,16
    80003624:	00008067          	ret

0000000080003628 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003628:	ff010113          	addi	sp,sp,-16
    8000362c:	00113423          	sd	ra,8(sp)
    80003630:	00813023          	sd	s0,0(sp)
    80003634:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003638:	00009797          	auipc	a5,0x9
    8000363c:	9387b783          	ld	a5,-1736(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003640:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003644:	00100713          	li	a4,1
    80003648:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    8000364c:	fffff097          	auipc	ra,0xfffff
    80003650:	400080e7          	jalr	1024(ra) # 80002a4c <_ZN3TCB8dispatchEv>
}
    80003654:	00813083          	ld	ra,8(sp)
    80003658:	00013403          	ld	s0,0(sp)
    8000365c:	01010113          	addi	sp,sp,16
    80003660:	00008067          	ret

0000000080003664 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003664:	ff010113          	addi	sp,sp,-16
    80003668:	00113423          	sd	ra,8(sp)
    8000366c:	00813023          	sd	s0,0(sp)
    80003670:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003674:	00009797          	auipc	a5,0x9
    80003678:	b2c7c783          	lbu	a5,-1236(a5) # 8000c1a0 <_ZN5RiscV16userMainFinishedE>
    8000367c:	00079c63          	bnez	a5,80003694 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003680:	00009717          	auipc	a4,0x9
    80003684:	8e873703          	ld	a4,-1816(a4) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003688:	00073783          	ld	a5,0(a4)
    8000368c:	00178793          	addi	a5,a5,1
    80003690:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003694:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003698:	0ff57513          	andi	a0,a0,255
    8000369c:	00001097          	auipc	ra,0x1
    800036a0:	1a4080e7          	jalr	420(ra) # 80004840 <_ZN11ConsoleUtil9putOutputEc>
}
    800036a4:	00813083          	ld	ra,8(sp)
    800036a8:	00013403          	ld	s0,0(sp)
    800036ac:	01010113          	addi	sp,sp,16
    800036b0:	00008067          	ret

00000000800036b4 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    800036b4:	fe010113          	addi	sp,sp,-32
    800036b8:	00113c23          	sd	ra,24(sp)
    800036bc:	00813823          	sd	s0,16(sp)
    800036c0:	02010413          	addi	s0,sp,32
    800036c4:	00c0006f          	j	800036d0 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    800036c8:	ffffe097          	auipc	ra,0xffffe
    800036cc:	394080e7          	jalr	916(ra) # 80001a5c <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    800036d0:	00009797          	auipc	a5,0x9
    800036d4:	8207b783          	ld	a5,-2016(a5) # 8000bef0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800036d8:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800036dc:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800036e0:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800036e4:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    800036e8:	0207f793          	andi	a5,a5,32
    800036ec:	fc078ee3          	beqz	a5,800036c8 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    800036f0:	00001097          	auipc	ra,0x1
    800036f4:	3c8080e7          	jalr	968(ra) # 80004ab8 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    800036f8:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    800036fc:	00008797          	auipc	a5,0x8
    80003700:	7ec7b783          	ld	a5,2028(a5) # 8000bee8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003704:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003708:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    8000370c:	fef44783          	lbu	a5,-17(s0)
    80003710:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003714:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003718:	00009797          	auipc	a5,0x9
    8000371c:	8507b783          	ld	a5,-1968(a5) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003720:	0007b783          	ld	a5,0(a5)
    80003724:	fa0786e3          	beqz	a5,800036d0 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003728:	fff78793          	addi	a5,a5,-1
    8000372c:	00009717          	auipc	a4,0x9
    80003730:	83c73703          	ld	a4,-1988(a4) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003734:	00f73023          	sd	a5,0(a4)
    80003738:	f99ff06f          	j	800036d0 <_ZN5RiscV11putcWrapperEPv+0x1c>

000000008000373c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    8000373c:	ff010113          	addi	sp,sp,-16
    80003740:	00813423          	sd	s0,8(sp)
    80003744:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003748:	00009797          	auipc	a5,0x9
    8000374c:	8287b783          	ld	a5,-2008(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003750:	0007b783          	ld	a5,0(a5)
    80003754:	0147a703          	lw	a4,20(a5)
    80003758:	00100793          	li	a5,1
    8000375c:	00f70c63          	beq	a4,a5,80003774 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003760:	10000793          	li	a5,256
    80003764:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    80003768:	00813403          	ld	s0,8(sp)
    8000376c:	01010113          	addi	sp,sp,16
    80003770:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003774:	10000793          	li	a5,256
    80003778:	1007a073          	csrs	sstatus,a5
}
    8000377c:	fedff06f          	j	80003768 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080003780 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003780:	ff010113          	addi	sp,sp,-16
    80003784:	00113423          	sd	ra,8(sp)
    80003788:	00813023          	sd	s0,0(sp)
    8000378c:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003790:	00100793          	li	a5,1
    80003794:	00009717          	auipc	a4,0x9
    80003798:	a0f70623          	sb	a5,-1524(a4) # 8000c1a0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    8000379c:	00008797          	auipc	a5,0x8
    800037a0:	7cc7b783          	ld	a5,1996(a5) # 8000bf68 <_GLOBAL_OFFSET_TABLE_+0x88>
    800037a4:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    800037a8:	00008797          	auipc	a5,0x8
    800037ac:	7707b783          	ld	a5,1904(a5) # 8000bf18 <_GLOBAL_OFFSET_TABLE_+0x38>
    800037b0:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    800037b4:	00200793          	li	a5,2
    800037b8:	1047b073          	csrc	sie,a5
    800037bc:	20000793          	li	a5,512
    800037c0:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    800037c4:	00008797          	auipc	a5,0x8
    800037c8:	77c7b783          	ld	a5,1916(a5) # 8000bf40 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037cc:	0007b783          	ld	a5,0(a5)
    800037d0:	00078c63          	beqz	a5,800037e8 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    800037d4:	0487b703          	ld	a4,72(a5)
    800037d8:	00008797          	auipc	a5,0x8
    800037dc:	7687b783          	ld	a5,1896(a5) # 8000bf40 <_GLOBAL_OFFSET_TABLE_+0x60>
    800037e0:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    800037e4:	fe1ff06f          	j	800037c4 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    800037e8:	00008797          	auipc	a5,0x8
    800037ec:	7607b783          	ld	a5,1888(a5) # 8000bf48 <_GLOBAL_OFFSET_TABLE_+0x68>
    800037f0:	0007b503          	ld	a0,0(a5)
    800037f4:	00001097          	auipc	ra,0x1
    800037f8:	cc0080e7          	jalr	-832(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    800037fc:	00008797          	auipc	a5,0x8
    80003800:	75c7b783          	ld	a5,1884(a5) # 8000bf58 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003804:	0007b703          	ld	a4,0(a5)
    80003808:	00008797          	auipc	a5,0x8
    8000380c:	7587b783          	ld	a5,1880(a5) # 8000bf60 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003810:	0007b783          	ld	a5,0(a5)
    80003814:	00f70863          	beq	a4,a5,80003824 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003818:	ffffe097          	auipc	ra,0xffffe
    8000381c:	244080e7          	jalr	580(ra) # 80001a5c <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003820:	fddff06f          	j	800037fc <_ZN5RiscV8finalizeEv+0x7c>
}
    80003824:	00813083          	ld	ra,8(sp)
    80003828:	00013403          	ld	s0,0(sp)
    8000382c:	01010113          	addi	sp,sp,16
    80003830:	00008067          	ret

0000000080003834 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003834:	ff010113          	addi	sp,sp,-16
    80003838:	00813423          	sd	s0,8(sp)
    8000383c:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003840:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003844:	00008717          	auipc	a4,0x8
    80003848:	72c73703          	ld	a4,1836(a4) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000384c:	00073703          	ld	a4,0(a4)
    80003850:	06873703          	ld	a4,104(a4)
    80003854:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003858:	04a5b823          	sd	a0,80(a1) # 1050 <_entry-0x7fffefb0>
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000385c:	00078593          	mv	a1,a5
}
    80003860:	00813403          	ld	s0,8(sp)
    80003864:	01010113          	addi	sp,sp,16
    80003868:	00008067          	ret

000000008000386c <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    8000386c:	ff010113          	addi	sp,sp,-16
    80003870:	00113423          	sd	ra,8(sp)
    80003874:	00813023          	sd	s0,0(sp)
    80003878:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    8000387c:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80003880:	fffff097          	auipc	ra,0xfffff
    80003884:	414080e7          	jalr	1044(ra) # 80002c94 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003888:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    8000388c:	00000097          	auipc	ra,0x0
    80003890:	fa8080e7          	jalr	-88(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003894:	00813083          	ld	ra,8(sp)
    80003898:	00013403          	ld	s0,0(sp)
    8000389c:	01010113          	addi	sp,sp,16
    800038a0:	00008067          	ret

00000000800038a4 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    800038a4:	ff010113          	addi	sp,sp,-16
    800038a8:	00113423          	sd	ra,8(sp)
    800038ac:	00813023          	sd	s0,0(sp)
    800038b0:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    800038b4:	00008797          	auipc	a5,0x8
    800038b8:	6c47b783          	ld	a5,1732(a5) # 8000bf78 <_GLOBAL_OFFSET_TABLE_+0x98>
    800038bc:	0007c783          	lbu	a5,0(a5)
    800038c0:	02079263          	bnez	a5,800038e4 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    800038c4:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800038c8:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800038cc:	00000097          	auipc	ra,0x0
    800038d0:	f68080e7          	jalr	-152(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    800038d4:	00813083          	ld	ra,8(sp)
    800038d8:	00013403          	ld	s0,0(sp)
    800038dc:	01010113          	addi	sp,sp,16
    800038e0:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800038e4:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    800038e8:	fffff097          	auipc	ra,0xfffff
    800038ec:	5d4080e7          	jalr	1492(ra) # 80002ebc <_ZN15MemoryAllocator5kfreeEPv>
    800038f0:	fd9ff06f          	j	800038c8 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

00000000800038f4 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    800038f4:	fc010113          	addi	sp,sp,-64
    800038f8:	02113c23          	sd	ra,56(sp)
    800038fc:	02813823          	sd	s0,48(sp)
    80003900:	02913423          	sd	s1,40(sp)
    80003904:	03213023          	sd	s2,32(sp)
    80003908:	01313c23          	sd	s3,24(sp)
    8000390c:	01413823          	sd	s4,16(sp)
    80003910:	01513423          	sd	s5,8(sp)
    80003914:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003918:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000391c:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003920:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003924:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003928:	07000513          	li	a0,112
    8000392c:	fffff097          	auipc	ra,0xfffff
    80003930:	1a0080e7          	jalr	416(ra) # 80002acc <_ZN3TCBnwEm>
    80003934:	00050493          	mv	s1,a0
    80003938:	00200713          	li	a4,2
    8000393c:	000a0693          	mv	a3,s4
    80003940:	00098613          	mv	a2,s3
    80003944:	00090593          	mv	a1,s2
    80003948:	fffff097          	auipc	ra,0xfffff
    8000394c:	038080e7          	jalr	56(ra) # 80002980 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003950:	04048863          	beqz	s1,800039a0 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003954:	0184b783          	ld	a5,24(s1)
    80003958:	00078863          	beqz	a5,80003968 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    8000395c:	00048513          	mv	a0,s1
    80003960:	00001097          	auipc	ra,0x1
    80003964:	b54080e7          	jalr	-1196(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003968:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    8000396c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003970:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003974:	00000097          	auipc	ra,0x0
    80003978:	ec0080e7          	jalr	-320(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000397c:	03813083          	ld	ra,56(sp)
    80003980:	03013403          	ld	s0,48(sp)
    80003984:	02813483          	ld	s1,40(sp)
    80003988:	02013903          	ld	s2,32(sp)
    8000398c:	01813983          	ld	s3,24(sp)
    80003990:	01013a03          	ld	s4,16(sp)
    80003994:	00813a83          	ld	s5,8(sp)
    80003998:	04010113          	addi	sp,sp,64
    8000399c:	00008067          	ret
        status = -1;
    800039a0:	fff00793          	li	a5,-1
    800039a4:	fcdff06f          	j	80003970 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    800039a8:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800039ac:	00048513          	mv	a0,s1
    800039b0:	fffff097          	auipc	ra,0xfffff
    800039b4:	210080e7          	jalr	528(ra) # 80002bc0 <_ZN3TCBdlEPv>
    800039b8:	00090513          	mv	a0,s2
    800039bc:	0000e097          	auipc	ra,0xe
    800039c0:	93c080e7          	jalr	-1732(ra) # 800112f8 <_Unwind_Resume>

00000000800039c4 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    800039c4:	fc010113          	addi	sp,sp,-64
    800039c8:	02113c23          	sd	ra,56(sp)
    800039cc:	02813823          	sd	s0,48(sp)
    800039d0:	02913423          	sd	s1,40(sp)
    800039d4:	03213023          	sd	s2,32(sp)
    800039d8:	01313c23          	sd	s3,24(sp)
    800039dc:	01413823          	sd	s4,16(sp)
    800039e0:	01513423          	sd	s5,8(sp)
    800039e4:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    800039e8:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800039ec:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    800039f0:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    800039f4:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800039f8:	07000513          	li	a0,112
    800039fc:	fffff097          	auipc	ra,0xfffff
    80003a00:	0d0080e7          	jalr	208(ra) # 80002acc <_ZN3TCBnwEm>
    80003a04:	00050493          	mv	s1,a0
    80003a08:	00200713          	li	a4,2
    80003a0c:	00090693          	mv	a3,s2
    80003a10:	00098613          	mv	a2,s3
    80003a14:	000a0593          	mv	a1,s4
    80003a18:	fffff097          	auipc	ra,0xfffff
    80003a1c:	f68080e7          	jalr	-152(ra) # 80002980 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003a20:	04048263          	beqz	s1,80003a64 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003a24:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003a28:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003a2c:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003a30:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a34:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a38:	00000097          	auipc	ra,0x0
    80003a3c:	dfc080e7          	jalr	-516(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a40:	03813083          	ld	ra,56(sp)
    80003a44:	03013403          	ld	s0,48(sp)
    80003a48:	02813483          	ld	s1,40(sp)
    80003a4c:	02013903          	ld	s2,32(sp)
    80003a50:	01813983          	ld	s3,24(sp)
    80003a54:	01013a03          	ld	s4,16(sp)
    80003a58:	00813a83          	ld	s5,8(sp)
    80003a5c:	04010113          	addi	sp,sp,64
    80003a60:	00008067          	ret
        status = -1;
    80003a64:	fff00793          	li	a5,-1
    80003a68:	fcdff06f          	j	80003a34 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003a6c:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003a70:	00048513          	mv	a0,s1
    80003a74:	fffff097          	auipc	ra,0xfffff
    80003a78:	14c080e7          	jalr	332(ra) # 80002bc0 <_ZN3TCBdlEPv>
    80003a7c:	00090513          	mv	a0,s2
    80003a80:	0000e097          	auipc	ra,0xe
    80003a84:	878080e7          	jalr	-1928(ra) # 800112f8 <_Unwind_Resume>

0000000080003a88 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003a88:	ff010113          	addi	sp,sp,-16
    80003a8c:	00113423          	sd	ra,8(sp)
    80003a90:	00813023          	sd	s0,0(sp)
    80003a94:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a98:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003a9c:	02051263          	bnez	a0,80003ac0 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003aa0:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003aa4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003aa8:	00000097          	auipc	ra,0x0
    80003aac:	d8c080e7          	jalr	-628(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ab0:	00813083          	ld	ra,8(sp)
    80003ab4:	00013403          	ld	s0,0(sp)
    80003ab8:	01010113          	addi	sp,sp,16
    80003abc:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003ac0:	00100793          	li	a5,1
    80003ac4:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003ac8:	00001097          	auipc	ra,0x1
    80003acc:	9ec080e7          	jalr	-1556(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003ad0:	fffff097          	auipc	ra,0xfffff
    80003ad4:	f7c080e7          	jalr	-132(ra) # 80002a4c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003ad8:	00000793          	li	a5,0
    80003adc:	fc9ff06f          	j	80003aa4 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003ae0 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003ae0:	ff010113          	addi	sp,sp,-16
    80003ae4:	00113423          	sd	ra,8(sp)
    80003ae8:	00813023          	sd	s0,0(sp)
    80003aec:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003af0:	00008797          	auipc	a5,0x8
    80003af4:	4807b783          	ld	a5,1152(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003af8:	0007b783          	ld	a5,0(a5)
    80003afc:	02078a63          	beqz	a5,80003b30 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003b00:	00200713          	li	a4,2
    80003b04:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003b08:	fffff097          	auipc	ra,0xfffff
    80003b0c:	f44080e7          	jalr	-188(ra) # 80002a4c <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003b10:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b14:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b18:	00000097          	auipc	ra,0x0
    80003b1c:	d1c080e7          	jalr	-740(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b20:	00813083          	ld	ra,8(sp)
    80003b24:	00013403          	ld	s0,0(sp)
    80003b28:	01010113          	addi	sp,sp,16
    80003b2c:	00008067          	ret
        status = -1;
    80003b30:	fff00793          	li	a5,-1
    80003b34:	fe1ff06f          	j	80003b14 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003b38 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003b38:	fd010113          	addi	sp,sp,-48
    80003b3c:	02113423          	sd	ra,40(sp)
    80003b40:	02813023          	sd	s0,32(sp)
    80003b44:	00913c23          	sd	s1,24(sp)
    80003b48:	01213823          	sd	s2,16(sp)
    80003b4c:	01313423          	sd	s3,8(sp)
    80003b50:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003b54:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003b58:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003b5c:	01800513          	li	a0,24
    80003b60:	fffff097          	auipc	ra,0xfffff
    80003b64:	d30080e7          	jalr	-720(ra) # 80002890 <_ZN3SCBnwEm>
    80003b68:	00050493          	mv	s1,a0
    80003b6c:	00090593          	mv	a1,s2
    80003b70:	fffff097          	auipc	ra,0xfffff
    80003b74:	b64080e7          	jalr	-1180(ra) # 800026d4 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003b78:	02048a63          	beqz	s1,80003bac <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    80003b7c:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    80003b80:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b84:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003b88:	00000097          	auipc	ra,0x0
    80003b8c:	cac080e7          	jalr	-852(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b90:	02813083          	ld	ra,40(sp)
    80003b94:	02013403          	ld	s0,32(sp)
    80003b98:	01813483          	ld	s1,24(sp)
    80003b9c:	01013903          	ld	s2,16(sp)
    80003ba0:	00813983          	ld	s3,8(sp)
    80003ba4:	03010113          	addi	sp,sp,48
    80003ba8:	00008067          	ret
        status = -1;
    80003bac:	fff00793          	li	a5,-1
    80003bb0:	fd5ff06f          	j	80003b84 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80003bb4:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003bb8:	00048513          	mv	a0,s1
    80003bbc:	fffff097          	auipc	ra,0xfffff
    80003bc0:	cfc080e7          	jalr	-772(ra) # 800028b8 <_ZN3SCBdlEPv>
    80003bc4:	00090513          	mv	a0,s2
    80003bc8:	0000d097          	auipc	ra,0xd
    80003bcc:	730080e7          	jalr	1840(ra) # 800112f8 <_Unwind_Resume>

0000000080003bd0 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003bd0:	fe010113          	addi	sp,sp,-32
    80003bd4:	00113c23          	sd	ra,24(sp)
    80003bd8:	00813823          	sd	s0,16(sp)
    80003bdc:	00913423          	sd	s1,8(sp)
    80003be0:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003be4:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003be8:	02049463          	bnez	s1,80003c10 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003bec:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003bf0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003bf4:	00000097          	auipc	ra,0x0
    80003bf8:	c40080e7          	jalr	-960(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003bfc:	01813083          	ld	ra,24(sp)
    80003c00:	01013403          	ld	s0,16(sp)
    80003c04:	00813483          	ld	s1,8(sp)
    80003c08:	02010113          	addi	sp,sp,32
    80003c0c:	00008067          	ret
        delete (SCB*)ihandle;
    80003c10:	00048513          	mv	a0,s1
    80003c14:	fffff097          	auipc	ra,0xfffff
    80003c18:	ae4080e7          	jalr	-1308(ra) # 800026f8 <_ZN3SCBD1Ev>
    80003c1c:	00048513          	mv	a0,s1
    80003c20:	fffff097          	auipc	ra,0xfffff
    80003c24:	c98080e7          	jalr	-872(ra) # 800028b8 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003c28:	00000793          	li	a5,0
    80003c2c:	fc5ff06f          	j	80003bf0 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003c30 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003c30:	ff010113          	addi	sp,sp,-16
    80003c34:	00113423          	sd	ra,8(sp)
    80003c38:	00813023          	sd	s0,0(sp)
    80003c3c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003c40:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003c44:	02051c63          	bnez	a0,80003c7c <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003c48:	00008797          	auipc	a5,0x8
    80003c4c:	3287b783          	ld	a5,808(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003c50:	0007b783          	ld	a5,0(a5)
    80003c54:	0607b783          	ld	a5,96(a5)
    80003c58:	02078863          	beqz	a5,80003c88 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003c5c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c60:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003c64:	00000097          	auipc	ra,0x0
    80003c68:	bd0080e7          	jalr	-1072(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c6c:	00813083          	ld	ra,8(sp)
    80003c70:	00013403          	ld	s0,0(sp)
    80003c74:	01010113          	addi	sp,sp,16
    80003c78:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003c7c:	fffff097          	auipc	ra,0xfffff
    80003c80:	b88080e7          	jalr	-1144(ra) # 80002804 <_ZN3SCB4waitEv>
    80003c84:	fc5ff06f          	j	80003c48 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003c88:	00000793          	li	a5,0
    80003c8c:	fd5ff06f          	j	80003c60 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003c90 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003c90:	ff010113          	addi	sp,sp,-16
    80003c94:	00113423          	sd	ra,8(sp)
    80003c98:	00813023          	sd	s0,0(sp)
    80003c9c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003ca0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003ca4:	02051263          	bnez	a0,80003cc8 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003ca8:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003cac:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003cb0:	00000097          	auipc	ra,0x0
    80003cb4:	b84080e7          	jalr	-1148(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003cb8:	00813083          	ld	ra,8(sp)
    80003cbc:	00013403          	ld	s0,0(sp)
    80003cc0:	01010113          	addi	sp,sp,16
    80003cc4:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003cc8:	fffff097          	auipc	ra,0xfffff
    80003ccc:	b8c080e7          	jalr	-1140(ra) # 80002854 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003cd0:	00000793          	li	a5,0
    80003cd4:	fd9ff06f          	j	80003cac <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003cd8 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003cd8:	fe010113          	addi	sp,sp,-32
    80003cdc:	00113c23          	sd	ra,24(sp)
    80003ce0:	00813823          	sd	s0,16(sp)
    80003ce4:	00913423          	sd	s1,8(sp)
    80003ce8:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003cec:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003cf0:	00008797          	auipc	a5,0x8
    80003cf4:	2807b783          	ld	a5,640(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003cf8:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003cfc:	00008797          	auipc	a5,0x8
    80003d00:	4ac7b783          	ld	a5,1196(a5) # 8000c1a8 <_ZN5RiscV10globalTimeE>
    80003d04:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003d08:	00e787b3          	add	a5,a5,a4
    80003d0c:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003d10:	00048513          	mv	a0,s1
    80003d14:	00001097          	auipc	ra,0x1
    80003d18:	81c080e7          	jalr	-2020(ra) # 80004530 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003d1c:	00300793          	li	a5,3
    80003d20:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003d24:	fffff097          	auipc	ra,0xfffff
    80003d28:	d28080e7          	jalr	-728(ra) # 80002a4c <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d2c:	00000793          	li	a5,0
    80003d30:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003d34:	00000097          	auipc	ra,0x0
    80003d38:	b00080e7          	jalr	-1280(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d3c:	01813083          	ld	ra,24(sp)
    80003d40:	01013403          	ld	s0,16(sp)
    80003d44:	00813483          	ld	s1,8(sp)
    80003d48:	02010113          	addi	sp,sp,32
    80003d4c:	00008067          	ret

0000000080003d50 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003d50:	fe010113          	addi	sp,sp,-32
    80003d54:	00113c23          	sd	ra,24(sp)
    80003d58:	00813823          	sd	s0,16(sp)
    80003d5c:	00913423          	sd	s1,8(sp)
    80003d60:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003d64:	00008797          	auipc	a5,0x8
    80003d68:	43c7c783          	lbu	a5,1084(a5) # 8000c1a0 <_ZN5RiscV16userMainFinishedE>
    80003d6c:	00079c63          	bnez	a5,80003d84 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003d70:	00008717          	auipc	a4,0x8
    80003d74:	1a873703          	ld	a4,424(a4) # 8000bf18 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003d78:	00073783          	ld	a5,0(a4)
    80003d7c:	00178793          	addi	a5,a5,1
    80003d80:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003d84:	00001097          	auipc	ra,0x1
    80003d88:	a44080e7          	jalr	-1468(ra) # 800047c8 <_ZN11ConsoleUtil8getInputEv>
    80003d8c:	00050493          	mv	s1,a0
    if(c==13) {
    80003d90:	00d00793          	li	a5,13
    80003d94:	02f50663          	beq	a0,a5,80003dc0 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003d98:	01b00793          	li	a5,27
    80003d9c:	04f51063          	bne	a0,a5,80003ddc <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003da0:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003da4:	00000097          	auipc	ra,0x0
    80003da8:	a90080e7          	jalr	-1392(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003dac:	01813083          	ld	ra,24(sp)
    80003db0:	01013403          	ld	s0,16(sp)
    80003db4:	00813483          	ld	s1,8(sp)
    80003db8:	02010113          	addi	sp,sp,32
    80003dbc:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003dc0:	00d00513          	li	a0,13
    80003dc4:	00001097          	auipc	ra,0x1
    80003dc8:	a7c080e7          	jalr	-1412(ra) # 80004840 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003dcc:	00a00513          	li	a0,10
    80003dd0:	00001097          	auipc	ra,0x1
    80003dd4:	a70080e7          	jalr	-1424(ra) # 80004840 <_ZN11ConsoleUtil9putOutputEc>
    80003dd8:	fc9ff06f          	j	80003da0 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003ddc:	00001097          	auipc	ra,0x1
    80003de0:	a64080e7          	jalr	-1436(ra) # 80004840 <_ZN11ConsoleUtil9putOutputEc>
    80003de4:	fbdff06f          	j	80003da0 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003de8 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003de8:	ff010113          	addi	sp,sp,-16
    80003dec:	00113423          	sd	ra,8(sp)
    80003df0:	00813023          	sd	s0,0(sp)
    80003df4:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003df8:	00001097          	auipc	ra,0x1
    80003dfc:	ac8080e7          	jalr	-1336(ra) # 800048c0 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003e00:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003e04:	00000097          	auipc	ra,0x0
    80003e08:	a30080e7          	jalr	-1488(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e0c:	00813083          	ld	ra,8(sp)
    80003e10:	00013403          	ld	s0,0(sp)
    80003e14:	01010113          	addi	sp,sp,16
    80003e18:	00008067          	ret

0000000080003e1c <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003e1c:	fe010113          	addi	sp,sp,-32
    80003e20:	00113c23          	sd	ra,24(sp)
    80003e24:	00813823          	sd	s0,16(sp)
    80003e28:	00913423          	sd	s1,8(sp)
    80003e2c:	01213023          	sd	s2,0(sp)
    80003e30:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003e34:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003e38:	02049663          	bnez	s1,80003e64 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    80003e3c:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e40:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    80003e44:	00000097          	auipc	ra,0x0
    80003e48:	9f0080e7          	jalr	-1552(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e4c:	01813083          	ld	ra,24(sp)
    80003e50:	01013403          	ld	s0,16(sp)
    80003e54:	00813483          	ld	s1,8(sp)
    80003e58:	00013903          	ld	s2,0(sp)
    80003e5c:	02010113          	addi	sp,sp,32
    80003e60:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    80003e64:	0284b503          	ld	a0,40(s1)
    80003e68:	fffff097          	auipc	ra,0xfffff
    80003e6c:	054080e7          	jalr	84(ra) # 80002ebc <_ZN15MemoryAllocator5kfreeEPv>
    80003e70:	00050913          	mv	s2,a0
        delete thr;
    80003e74:	00048513          	mv	a0,s1
    80003e78:	fffff097          	auipc	ra,0xfffff
    80003e7c:	bac080e7          	jalr	-1108(ra) # 80002a24 <_ZN3TCBD1Ev>
    80003e80:	00048513          	mv	a0,s1
    80003e84:	fffff097          	auipc	ra,0xfffff
    80003e88:	d3c080e7          	jalr	-708(ra) # 80002bc0 <_ZN3TCBdlEPv>
    80003e8c:	fb5ff06f          	j	80003e40 <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

0000000080003e90 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003e90:	fe010113          	addi	sp,sp,-32
    80003e94:	00113c23          	sd	ra,24(sp)
    80003e98:	00813823          	sd	s0,16(sp)
    80003e9c:	00913423          	sd	s1,8(sp)
    80003ea0:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003ea4:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003ea8:	02049463          	bnez	s1,80003ed0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003eac:	fff00793          	li	a5,-1
    80003eb0:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003eb4:	00000097          	auipc	ra,0x0
    80003eb8:	980080e7          	jalr	-1664(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003ebc:	01813083          	ld	ra,24(sp)
    80003ec0:	01013403          	ld	s0,16(sp)
    80003ec4:	00813483          	ld	s1,8(sp)
    80003ec8:	02010113          	addi	sp,sp,32
    80003ecc:	00008067          	ret
        delete scb;
    80003ed0:	00048513          	mv	a0,s1
    80003ed4:	fffff097          	auipc	ra,0xfffff
    80003ed8:	824080e7          	jalr	-2012(ra) # 800026f8 <_ZN3SCBD1Ev>
    80003edc:	00048513          	mv	a0,s1
    80003ee0:	fffff097          	auipc	ra,0xfffff
    80003ee4:	9d8080e7          	jalr	-1576(ra) # 800028b8 <_ZN3SCBdlEPv>
    80003ee8:	fc5ff06f          	j	80003eac <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003eec <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003eec:	fe010113          	addi	sp,sp,-32
    80003ef0:	00113c23          	sd	ra,24(sp)
    80003ef4:	00813823          	sd	s0,16(sp)
    80003ef8:	00913423          	sd	s1,8(sp)
    80003efc:	01213023          	sd	s2,0(sp)
    80003f00:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80003f04:	04000513          	li	a0,64
    80003f08:	fffff097          	auipc	ra,0xfffff
    80003f0c:	d8c080e7          	jalr	-628(ra) # 80002c94 <_ZN15MemoryAllocator7kmallocEm>
    80003f10:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003f14:	00008797          	auipc	a5,0x8
    80003f18:	05c7b783          	ld	a5,92(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003f1c:	0007b783          	ld	a5,0(a5)
    80003f20:	00001637          	lui	a2,0x1
    80003f24:	00050593          	mv	a1,a0
    80003f28:	0287b503          	ld	a0,40(a5)
    80003f2c:	fffff097          	auipc	ra,0xfffff
    80003f30:	144080e7          	jalr	324(ra) # 80003070 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003f34:	07000513          	li	a0,112
    80003f38:	fffff097          	auipc	ra,0xfffff
    80003f3c:	b94080e7          	jalr	-1132(ra) # 80002acc <_ZN3TCBnwEm>
    80003f40:	00050493          	mv	s1,a0
    80003f44:	00200713          	li	a4,2
    80003f48:	00090693          	mv	a3,s2
    80003f4c:	00000613          	li	a2,0
    80003f50:	00000593          	li	a1,0
    80003f54:	fffff097          	auipc	ra,0xfffff
    80003f58:	a2c080e7          	jalr	-1492(ra) # 80002980 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003f5c:	0a048e63          	beqz	s1,80004018 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003f60:	00008797          	auipc	a5,0x8
    80003f64:	fd87b783          	ld	a5,-40(a5) # 8000bf38 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003f68:	0007b783          	ld	a5,0(a5)
    80003f6c:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003f70:	00008797          	auipc	a5,0x8
    80003f74:	fb07b783          	ld	a5,-80(a5) # 8000bf20 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003f78:	0007b783          	ld	a5,0(a5)
    80003f7c:	00f907b3          	add	a5,s2,a5
    80003f80:	00008717          	auipc	a4,0x8
    80003f84:	ff073703          	ld	a4,-16(a4) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003f88:	00073683          	ld	a3,0(a4)
    80003f8c:	0286b683          	ld	a3,40(a3)
    80003f90:	40d787b3          	sub	a5,a5,a3
    80003f94:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003f98:	00073783          	ld	a5,0(a4)
    80003f9c:	0687b503          	ld	a0,104(a5)
    80003fa0:	0287b783          	ld	a5,40(a5)
    80003fa4:	40f50533          	sub	a0,a0,a5
    80003fa8:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003fac:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003fb0:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003fb4:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003fb8:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003fbc:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003fc0:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003fc4:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003fc8:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003fcc:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003fd0:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003fd4:	00073783          	ld	a5,0(a4)
    80003fd8:	0387b703          	ld	a4,56(a5)
    80003fdc:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003fe0:	0407b783          	ld	a5,64(a5)
    80003fe4:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003fe8:	00048513          	mv	a0,s1
    80003fec:	00000097          	auipc	ra,0x0
    80003ff0:	4c8080e7          	jalr	1224(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ff4:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003ff8:	00000097          	auipc	ra,0x0
    80003ffc:	83c080e7          	jalr	-1988(ra) # 80003834 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004000:	01813083          	ld	ra,24(sp)
    80004004:	01013403          	ld	s0,16(sp)
    80004008:	00813483          	ld	s1,8(sp)
    8000400c:	00013903          	ld	s2,0(sp)
    80004010:	02010113          	addi	sp,sp,32
    80004014:	00008067          	ret
        status = -1;
    80004018:	fff00493          	li	s1,-1
    8000401c:	fd9ff06f          	j	80003ff4 <_ZN5RiscV18executeForkSyscallEv+0x108>
    80004020:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80004024:	00048513          	mv	a0,s1
    80004028:	fffff097          	auipc	ra,0xfffff
    8000402c:	b98080e7          	jalr	-1128(ra) # 80002bc0 <_ZN3TCBdlEPv>
    80004030:	00090513          	mv	a0,s2
    80004034:	0000d097          	auipc	ra,0xd
    80004038:	2c4080e7          	jalr	708(ra) # 800112f8 <_Unwind_Resume>

000000008000403c <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    8000403c:	ff010113          	addi	sp,sp,-16
    80004040:	00813423          	sd	s0,8(sp)
    80004044:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80004048:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    8000404c:	00878793          	addi	a5,a5,8
    80004050:	00008717          	auipc	a4,0x8
    80004054:	ee873703          	ld	a4,-280(a4) # 8000bf38 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004058:	00f73023          	sd	a5,0(a4)
}
    8000405c:	00813403          	ld	s0,8(sp)
    80004060:	01010113          	addi	sp,sp,16
    80004064:	00008067          	ret

0000000080004068 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80004068:	fa010113          	addi	sp,sp,-96
    8000406c:	04113c23          	sd	ra,88(sp)
    80004070:	04813823          	sd	s0,80(sp)
    80004074:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004078:	142027f3          	csrr	a5,scause
    8000407c:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80004080:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    80004084:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80004088:	00008797          	auipc	a5,0x8
    8000408c:	ee87b783          	ld	a5,-280(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004090:	0007b783          	ld	a5,0(a5)
    80004094:	14002773          	csrr	a4,sscratch
    80004098:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    8000409c:	fe843703          	ld	a4,-24(s0)
    800040a0:	00900793          	li	a5,9
    800040a4:	0ef70663          	beq	a4,a5,80004190 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    800040a8:	fe843703          	ld	a4,-24(s0)
    800040ac:	00800793          	li	a5,8
    800040b0:	0ef70063          	beq	a4,a5,80004190 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    800040b4:	fe843703          	ld	a4,-24(s0)
    800040b8:	fff00793          	li	a5,-1
    800040bc:	03f79793          	slli	a5,a5,0x3f
    800040c0:	00178793          	addi	a5,a5,1
    800040c4:	24f70263          	beq	a4,a5,80004308 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    800040c8:	fe843703          	ld	a4,-24(s0)
    800040cc:	fff00793          	li	a5,-1
    800040d0:	03f79793          	slli	a5,a5,0x3f
    800040d4:	00978793          	addi	a5,a5,9
    800040d8:	2cf70063          	beq	a4,a5,80004398 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    800040dc:	fe843703          	ld	a4,-24(s0)
    800040e0:	00200793          	li	a5,2
    800040e4:	34f70863          	beq	a4,a5,80004434 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    800040e8:	00005517          	auipc	a0,0x5
    800040ec:	0f050513          	addi	a0,a0,240 # 800091d8 <CONSOLE_STATUS+0x1c8>
    800040f0:	00001097          	auipc	ra,0x1
    800040f4:	848080e7          	jalr	-1976(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    800040f8:	00005517          	auipc	a0,0x5
    800040fc:	0f050513          	addi	a0,a0,240 # 800091e8 <CONSOLE_STATUS+0x1d8>
    80004100:	00001097          	auipc	ra,0x1
    80004104:	838080e7          	jalr	-1992(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004108:	142027f3          	csrr	a5,scause
    8000410c:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004110:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80004114:	00000613          	li	a2,0
    80004118:	00a00593          	li	a1,10
    8000411c:	0005051b          	sext.w	a0,a0
    80004120:	00001097          	auipc	ra,0x1
    80004124:	85c080e7          	jalr	-1956(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80004128:	00005517          	auipc	a0,0x5
    8000412c:	08050513          	addi	a0,a0,128 # 800091a8 <CONSOLE_STATUS+0x198>
    80004130:	00001097          	auipc	ra,0x1
    80004134:	808080e7          	jalr	-2040(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004138:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    8000413c:	00000613          	li	a2,0
    80004140:	01000593          	li	a1,16
    80004144:	0005051b          	sext.w	a0,a0
    80004148:	00001097          	auipc	ra,0x1
    8000414c:	834080e7          	jalr	-1996(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004150:	00005517          	auipc	a0,0x5
    80004154:	05050513          	addi	a0,a0,80 # 800091a0 <CONSOLE_STATUS+0x190>
    80004158:	00000097          	auipc	ra,0x0
    8000415c:	7e0080e7          	jalr	2016(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    80004160:	00008797          	auipc	a5,0x8
    80004164:	e107b783          	ld	a5,-496(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004168:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    8000416c:	00200713          	li	a4,2
    80004170:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80004174:	00005517          	auipc	a0,0x5
    80004178:	08450513          	addi	a0,a0,132 # 800091f8 <CONSOLE_STATUS+0x1e8>
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	7bc080e7          	jalr	1980(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004184:	fffff097          	auipc	ra,0xfffff
    80004188:	8c8080e7          	jalr	-1848(ra) # 80002a4c <_ZN3TCB8dispatchEv>
    8000418c:	0800006f          	j	8000420c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004190:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004194:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004198:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    8000419c:	00478793          	addi	a5,a5,4
    800041a0:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    800041a4:	00008797          	auipc	a5,0x8
    800041a8:	dcc7b783          	ld	a5,-564(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    800041ac:	0007b783          	ld	a5,0(a5)
    800041b0:	fb043703          	ld	a4,-80(s0)
    800041b4:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    800041b8:	fa843703          	ld	a4,-88(s0)
    800041bc:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    800041c0:	00050793          	mv	a5,a0
        switch(syscallID){
    800041c4:	06100713          	li	a4,97
    800041c8:	02f76463          	bltu	a4,a5,800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    800041cc:	00279793          	slli	a5,a5,0x2
    800041d0:	00005717          	auipc	a4,0x5
    800041d4:	03c70713          	addi	a4,a4,60 # 8000920c <CONSOLE_STATUS+0x1fc>
    800041d8:	00e787b3          	add	a5,a5,a4
    800041dc:	0007a783          	lw	a5,0(a5)
    800041e0:	00e787b3          	add	a5,a5,a4
    800041e4:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    800041e8:	fffff097          	auipc	ra,0xfffff
    800041ec:	684080e7          	jalr	1668(ra) # 8000386c <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    800041f0:	00008797          	auipc	a5,0x8
    800041f4:	d807b783          	ld	a5,-640(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    800041f8:	0007b783          	ld	a5,0(a5)
    800041fc:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004200:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80004204:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004208:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    8000420c:	fffff097          	auipc	ra,0xfffff
    80004210:	530080e7          	jalr	1328(ra) # 8000373c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80004214:	05813083          	ld	ra,88(sp)
    80004218:	05013403          	ld	s0,80(sp)
    8000421c:	06010113          	addi	sp,sp,96
    80004220:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80004224:	fffff097          	auipc	ra,0xfffff
    80004228:	680080e7          	jalr	1664(ra) # 800038a4 <_ZN5RiscV21executeMemFreeSyscallEv>
    8000422c:	fc5ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    80004230:	fffff097          	auipc	ra,0xfffff
    80004234:	6c4080e7          	jalr	1732(ra) # 800038f4 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80004238:	fb9ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    8000423c:	00000097          	auipc	ra,0x0
    80004240:	8a4080e7          	jalr	-1884(ra) # 80003ae0 <_ZN5RiscV24executeThreadExitSyscallEv>
    80004244:	fadff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    80004248:	fffff097          	auipc	ra,0xfffff
    8000424c:	3e0080e7          	jalr	992(ra) # 80003628 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80004250:	fa1ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80004254:	fffff097          	auipc	ra,0xfffff
    80004258:	770080e7          	jalr	1904(ra) # 800039c4 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    8000425c:	f95ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    80004260:	00000097          	auipc	ra,0x0
    80004264:	828080e7          	jalr	-2008(ra) # 80003a88 <_ZN5RiscV25executeThreadStartSyscallEv>
    80004268:	f89ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    8000426c:	00000097          	auipc	ra,0x0
    80004270:	8cc080e7          	jalr	-1844(ra) # 80003b38 <_ZN5RiscV21executeSemOpenSyscallEv>
    80004274:	f7dff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    80004278:	00000097          	auipc	ra,0x0
    8000427c:	958080e7          	jalr	-1704(ra) # 80003bd0 <_ZN5RiscV22executeSemCloseSyscallEv>
    80004280:	f71ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80004284:	00000097          	auipc	ra,0x0
    80004288:	9ac080e7          	jalr	-1620(ra) # 80003c30 <_ZN5RiscV21executeSemWaitSyscallEv>
    8000428c:	f65ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80004290:	00000097          	auipc	ra,0x0
    80004294:	a00080e7          	jalr	-1536(ra) # 80003c90 <_ZN5RiscV23executeSemSignalSyscallEv>
    80004298:	f59ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    8000429c:	00000097          	auipc	ra,0x0
    800042a0:	a3c080e7          	jalr	-1476(ra) # 80003cd8 <_ZN5RiscV23executeTimeSleepSyscallEv>
    800042a4:	f4dff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    800042a8:	00000097          	auipc	ra,0x0
    800042ac:	aa8080e7          	jalr	-1368(ra) # 80003d50 <_ZN5RiscV18executeGetcSyscallEv>
    800042b0:	f41ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    800042b4:	fffff097          	auipc	ra,0xfffff
    800042b8:	3b0080e7          	jalr	944(ra) # 80003664 <_ZN5RiscV18executePutcSyscallEv>
    800042bc:	f35ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    800042c0:	00000097          	auipc	ra,0x0
    800042c4:	b28080e7          	jalr	-1240(ra) # 80003de8 <_ZN5RiscV22executePutcUtilSyscallEv>
    800042c8:	f29ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    800042cc:	00000097          	auipc	ra,0x0
    800042d0:	b50080e7          	jalr	-1200(ra) # 80003e1c <_ZN5RiscV24executeThreadFreeSyscallEv>
    800042d4:	f1dff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    800042d8:	00000097          	auipc	ra,0x0
    800042dc:	bb8080e7          	jalr	-1096(ra) # 80003e90 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    800042e0:	f11ff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    800042e4:	00010793          	mv	a5,sp
    800042e8:	00008717          	auipc	a4,0x8
    800042ec:	c3873703          	ld	a4,-968(a4) # 8000bf20 <_GLOBAL_OFFSET_TABLE_+0x40>
    800042f0:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    800042f4:	00000097          	auipc	ra,0x0
    800042f8:	d48080e7          	jalr	-696(ra) # 8000403c <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    800042fc:	00000097          	auipc	ra,0x0
    80004300:	bf0080e7          	jalr	-1040(ra) # 80003eec <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004304:	eedff06f          	j	800041f0 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004308:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000430c:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004310:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004314:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004318:	00200793          	li	a5,2
    8000431c:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80004320:	00008717          	auipc	a4,0x8
    80004324:	e8070713          	addi	a4,a4,-384 # 8000c1a0 <_ZN5RiscV16userMainFinishedE>
    80004328:	00873783          	ld	a5,8(a4)
    8000432c:	00178793          	addi	a5,a5,1
    80004330:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    80004334:	00000097          	auipc	ra,0x0
    80004338:	254080e7          	jalr	596(ra) # 80004588 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    8000433c:	00008717          	auipc	a4,0x8
    80004340:	bc473703          	ld	a4,-1084(a4) # 8000bf00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004344:	00073783          	ld	a5,0(a4)
    80004348:	00178793          	addi	a5,a5,1
    8000434c:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80004350:	00008717          	auipc	a4,0x8
    80004354:	c2073703          	ld	a4,-992(a4) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    80004358:	00073703          	ld	a4,0(a4)
    8000435c:	03073683          	ld	a3,48(a4)
    80004360:	00d7fc63          	bgeu	a5,a3,80004378 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    80004364:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004368:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    8000436c:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004370:	14179073          	csrw	sepc,a5
}
    80004374:	e99ff06f          	j	8000420c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    80004378:	00008797          	auipc	a5,0x8
    8000437c:	b887b783          	ld	a5,-1144(a5) # 8000bf00 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004380:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004384:	00100793          	li	a5,1
    80004388:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    8000438c:	ffffe097          	auipc	ra,0xffffe
    80004390:	6c0080e7          	jalr	1728(ra) # 80002a4c <_ZN3TCB8dispatchEv>
    80004394:	fd1ff06f          	j	80004364 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004398:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000439c:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800043a0:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800043a4:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    800043a8:	00008797          	auipc	a5,0x8
    800043ac:	b487b783          	ld	a5,-1208(a5) # 8000bef0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800043b0:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    800043b4:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    800043b8:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    800043bc:	00058793          	mv	a5,a1
        if(status & 1UL)
    800043c0:	0017f793          	andi	a5,a5,1
    800043c4:	02078863          	beqz	a5,800043f4 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    800043c8:	00008797          	auipc	a5,0x8
    800043cc:	b487b783          	ld	a5,-1208(a5) # 8000bf10 <_GLOBAL_OFFSET_TABLE_+0x30>
    800043d0:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    800043d4:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    800043d8:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    800043dc:	00058513          	mv	a0,a1
    800043e0:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    800043e4:	00008797          	auipc	a5,0x8
    800043e8:	b347b783          	ld	a5,-1228(a5) # 8000bf18 <_GLOBAL_OFFSET_TABLE_+0x38>
    800043ec:	0007b783          	ld	a5,0(a5)
    800043f0:	02079463          	bnez	a5,80004418 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    800043f4:	00003097          	auipc	ra,0x3
    800043f8:	180080e7          	jalr	384(ra) # 80007574 <plic_claim>
    800043fc:	00003097          	auipc	ra,0x3
    80004400:	1b0080e7          	jalr	432(ra) # 800075ac <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004404:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004408:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    8000440c:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004410:	14179073          	csrw	sepc,a5
}
    80004414:	df9ff06f          	j	8000420c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004418:	fff78793          	addi	a5,a5,-1
    8000441c:	00008717          	auipc	a4,0x8
    80004420:	afc73703          	ld	a4,-1284(a4) # 8000bf18 <_GLOBAL_OFFSET_TABLE_+0x38>
    80004424:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80004428:	00000097          	auipc	ra,0x0
    8000442c:	338080e7          	jalr	824(ra) # 80004760 <_ZN11ConsoleUtil8putInputEc>
    80004430:	fc5ff06f          	j	800043f4 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    80004434:	00008797          	auipc	a5,0x8
    80004438:	b3c7b783          	ld	a5,-1220(a5) # 8000bf70 <_GLOBAL_OFFSET_TABLE_+0x90>
    8000443c:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80004440:	00200713          	li	a4,2
    80004444:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80004448:	00005517          	auipc	a0,0x5
    8000444c:	d6050513          	addi	a0,a0,-672 # 800091a8 <CONSOLE_STATUS+0x198>
    80004450:	00000097          	auipc	ra,0x0
    80004454:	4e8080e7          	jalr	1256(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004458:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    8000445c:	00000613          	li	a2,0
    80004460:	01000593          	li	a1,16
    80004464:	0005051b          	sext.w	a0,a0
    80004468:	00000097          	auipc	ra,0x0
    8000446c:	514080e7          	jalr	1300(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004470:	00005517          	auipc	a0,0x5
    80004474:	d3050513          	addi	a0,a0,-720 # 800091a0 <CONSOLE_STATUS+0x190>
    80004478:	00000097          	auipc	ra,0x0
    8000447c:	4c0080e7          	jalr	1216(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004480:	00005517          	auipc	a0,0x5
    80004484:	d3050513          	addi	a0,a0,-720 # 800091b0 <CONSOLE_STATUS+0x1a0>
    80004488:	00000097          	auipc	ra,0x0
    8000448c:	4b0080e7          	jalr	1200(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004490:	ffffe097          	auipc	ra,0xffffe
    80004494:	5bc080e7          	jalr	1468(ra) # 80002a4c <_ZN3TCB8dispatchEv>
    80004498:	d75ff06f          	j	8000420c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

000000008000449c <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    8000449c:	ff010113          	addi	sp,sp,-16
    800044a0:	00813423          	sd	s0,8(sp)
    800044a4:	01010413          	addi	s0,sp,16
}
    800044a8:	00813403          	ld	s0,8(sp)
    800044ac:	01010113          	addi	sp,sp,16
    800044b0:	00008067          	ret

00000000800044b4 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800044b4:	ff010113          	addi	sp,sp,-16
    800044b8:	00813423          	sd	s0,8(sp)
    800044bc:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    800044c0:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800044c4:	00008797          	auipc	a5,0x8
    800044c8:	cec7b783          	ld	a5,-788(a5) # 8000c1b0 <_ZN9Scheduler9readyHeadE>
    800044cc:	02078263          	beqz	a5,800044f0 <_ZN9Scheduler3putEP3TCB+0x3c>
    800044d0:	00008797          	auipc	a5,0x8
    800044d4:	ce87b783          	ld	a5,-792(a5) # 8000c1b8 <_ZN9Scheduler9readyTailE>
    800044d8:	04a7b423          	sd	a0,72(a5)
    800044dc:	00008797          	auipc	a5,0x8
    800044e0:	cca7be23          	sd	a0,-804(a5) # 8000c1b8 <_ZN9Scheduler9readyTailE>
}
    800044e4:	00813403          	ld	s0,8(sp)
    800044e8:	01010113          	addi	sp,sp,16
    800044ec:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800044f0:	00008797          	auipc	a5,0x8
    800044f4:	cca7b023          	sd	a0,-832(a5) # 8000c1b0 <_ZN9Scheduler9readyHeadE>
    800044f8:	fe5ff06f          	j	800044dc <_ZN9Scheduler3putEP3TCB+0x28>

00000000800044fc <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800044fc:	ff010113          	addi	sp,sp,-16
    80004500:	00813423          	sd	s0,8(sp)
    80004504:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004508:	00008517          	auipc	a0,0x8
    8000450c:	ca853503          	ld	a0,-856(a0) # 8000c1b0 <_ZN9Scheduler9readyHeadE>
    80004510:	00050a63          	beqz	a0,80004524 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004514:	04853783          	ld	a5,72(a0)
    80004518:	00008717          	auipc	a4,0x8
    8000451c:	c8f73c23          	sd	a5,-872(a4) # 8000c1b0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004520:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004524:	00813403          	ld	s0,8(sp)
    80004528:	01010113          	addi	sp,sp,16
    8000452c:	00008067          	ret

0000000080004530 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004530:	ff010113          	addi	sp,sp,-16
    80004534:	00813423          	sd	s0,8(sp)
    80004538:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    8000453c:	00008797          	auipc	a5,0x8
    80004540:	c847b783          	ld	a5,-892(a5) # 8000c1c0 <_ZN9Scheduler12sleepingHeadE>
    80004544:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004548:	00078e63          	beqz	a5,80004564 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    8000454c:	0587b683          	ld	a3,88(a5)
    80004550:	05853703          	ld	a4,88(a0)
    80004554:	00d76863          	bltu	a4,a3,80004564 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004558:	00078613          	mv	a2,a5
    8000455c:	0487b783          	ld	a5,72(a5)
    80004560:	fe9ff06f          	j	80004548 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004564:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004568:	00060a63          	beqz	a2,8000457c <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    8000456c:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    80004570:	00813403          	ld	s0,8(sp)
    80004574:	01010113          	addi	sp,sp,16
    80004578:	00008067          	ret
        sleepingHead = t;
    8000457c:	00008797          	auipc	a5,0x8
    80004580:	c4a7b223          	sd	a0,-956(a5) # 8000c1c0 <_ZN9Scheduler12sleepingHeadE>
}
    80004584:	fedff06f          	j	80004570 <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004588 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004588:	fe010113          	addi	sp,sp,-32
    8000458c:	00113c23          	sd	ra,24(sp)
    80004590:	00813823          	sd	s0,16(sp)
    80004594:	00913423          	sd	s1,8(sp)
    80004598:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    8000459c:	00008497          	auipc	s1,0x8
    800045a0:	c244b483          	ld	s1,-988(s1) # 8000c1c0 <_ZN9Scheduler12sleepingHeadE>
    800045a4:	02048c63          	beqz	s1,800045dc <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    800045a8:	0584b703          	ld	a4,88(s1)
    800045ac:	00008797          	auipc	a5,0x8
    800045b0:	9dc7b783          	ld	a5,-1572(a5) # 8000bf88 <_GLOBAL_OFFSET_TABLE_+0xa8>
    800045b4:	0007b783          	ld	a5,0(a5)
    800045b8:	02e7e263          	bltu	a5,a4,800045dc <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    800045bc:	0484b783          	ld	a5,72(s1)
    800045c0:	00008717          	auipc	a4,0x8
    800045c4:	c0f73023          	sd	a5,-1024(a4) # 8000c1c0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    800045c8:	00048513          	mv	a0,s1
    800045cc:	00000097          	auipc	ra,0x0
    800045d0:	ee8080e7          	jalr	-280(ra) # 800044b4 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    800045d4:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    800045d8:	fc5ff06f          	j	8000459c <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    800045dc:	01813083          	ld	ra,24(sp)
    800045e0:	01013403          	ld	s0,16(sp)
    800045e4:	00813483          	ld	s1,8(sp)
    800045e8:	02010113          	addi	sp,sp,32
    800045ec:	00008067          	ret

00000000800045f0 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    800045f0:	fe010113          	addi	sp,sp,-32
    800045f4:	00113c23          	sd	ra,24(sp)
    800045f8:	00813823          	sd	s0,16(sp)
    800045fc:	00913423          	sd	s1,8(sp)
    80004600:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004604:	00008497          	auipc	s1,0x8
    80004608:	bac4b483          	ld	s1,-1108(s1) # 8000c1b0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    8000460c:	02048863          	beqz	s1,8000463c <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004610:	00000613          	li	a2,0
    80004614:	01000593          	li	a1,16
    80004618:	0004851b          	sext.w	a0,s1
    8000461c:	00000097          	auipc	ra,0x0
    80004620:	360080e7          	jalr	864(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004624:	00005517          	auipc	a0,0x5
    80004628:	b7c50513          	addi	a0,a0,-1156 # 800091a0 <CONSOLE_STATUS+0x190>
    8000462c:	00000097          	auipc	ra,0x0
    80004630:	30c080e7          	jalr	780(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004634:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004638:	fd5ff06f          	j	8000460c <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    8000463c:	01813083          	ld	ra,24(sp)
    80004640:	01013403          	ld	s0,16(sp)
    80004644:	00813483          	ld	s1,8(sp)
    80004648:	02010113          	addi	sp,sp,32
    8000464c:	00008067          	ret

0000000080004650 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    80004650:	fe010113          	addi	sp,sp,-32
    80004654:	00113c23          	sd	ra,24(sp)
    80004658:	00813823          	sd	s0,16(sp)
    8000465c:	00913423          	sd	s1,8(sp)
    80004660:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004664:	00008497          	auipc	s1,0x8
    80004668:	b5c4b483          	ld	s1,-1188(s1) # 8000c1c0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    8000466c:	02048863          	beqz	s1,8000469c <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004670:	00000613          	li	a2,0
    80004674:	01000593          	li	a1,16
    80004678:	0004851b          	sext.w	a0,s1
    8000467c:	ffffe097          	auipc	ra,0xffffe
    80004680:	f44080e7          	jalr	-188(ra) # 800025c0 <_Z8printIntiii>
        printString("\n");
    80004684:	00005517          	auipc	a0,0x5
    80004688:	b1c50513          	addi	a0,a0,-1252 # 800091a0 <CONSOLE_STATUS+0x190>
    8000468c:	ffffe097          	auipc	ra,0xffffe
    80004690:	d9c080e7          	jalr	-612(ra) # 80002428 <_Z11printStringPKc>
        iter = iter->next;
    80004694:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004698:	fd5ff06f          	j	8000466c <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    8000469c:	01813083          	ld	ra,24(sp)
    800046a0:	01013403          	ld	s0,16(sp)
    800046a4:	00813483          	ld	s1,8(sp)
    800046a8:	02010113          	addi	sp,sp,32
    800046ac:	00008067          	ret

00000000800046b0 <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    800046b0:	fe010113          	addi	sp,sp,-32
    800046b4:	00113c23          	sd	ra,24(sp)
    800046b8:	00813823          	sd	s0,16(sp)
    800046bc:	00913423          	sd	s1,8(sp)
    800046c0:	01213023          	sd	s2,0(sp)
    800046c4:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    800046c8:	01800513          	li	a0,24
    800046cc:	ffffe097          	auipc	ra,0xffffe
    800046d0:	1c4080e7          	jalr	452(ra) # 80002890 <_ZN3SCBnwEm>
    800046d4:	00050493          	mv	s1,a0
    800046d8:	00000593          	li	a1,0
    800046dc:	ffffe097          	auipc	ra,0xffffe
    800046e0:	ff8080e7          	jalr	-8(ra) # 800026d4 <_ZN3SCBC1Em>
    800046e4:	00008797          	auipc	a5,0x8
    800046e8:	ae97b223          	sd	s1,-1308(a5) # 8000c1c8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    800046ec:	01800513          	li	a0,24
    800046f0:	ffffe097          	auipc	ra,0xffffe
    800046f4:	1a0080e7          	jalr	416(ra) # 80002890 <_ZN3SCBnwEm>
    800046f8:	00050493          	mv	s1,a0
    800046fc:	00000593          	li	a1,0
    80004700:	ffffe097          	auipc	ra,0xffffe
    80004704:	fd4080e7          	jalr	-44(ra) # 800026d4 <_ZN3SCBC1Em>
    80004708:	00008797          	auipc	a5,0x8
    8000470c:	ac97b423          	sd	s1,-1336(a5) # 8000c1d0 <_ZN11ConsoleUtil9outputSemE>
}
    80004710:	01813083          	ld	ra,24(sp)
    80004714:	01013403          	ld	s0,16(sp)
    80004718:	00813483          	ld	s1,8(sp)
    8000471c:	00013903          	ld	s2,0(sp)
    80004720:	02010113          	addi	sp,sp,32
    80004724:	00008067          	ret
    80004728:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    8000472c:	00048513          	mv	a0,s1
    80004730:	ffffe097          	auipc	ra,0xffffe
    80004734:	188080e7          	jalr	392(ra) # 800028b8 <_ZN3SCBdlEPv>
    80004738:	00090513          	mv	a0,s2
    8000473c:	0000d097          	auipc	ra,0xd
    80004740:	bbc080e7          	jalr	-1092(ra) # 800112f8 <_Unwind_Resume>
    80004744:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004748:	00048513          	mv	a0,s1
    8000474c:	ffffe097          	auipc	ra,0xffffe
    80004750:	16c080e7          	jalr	364(ra) # 800028b8 <_ZN3SCBdlEPv>
    80004754:	00090513          	mv	a0,s2
    80004758:	0000d097          	auipc	ra,0xd
    8000475c:	ba0080e7          	jalr	-1120(ra) # 800112f8 <_Unwind_Resume>

0000000080004760 <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004760:	00008697          	auipc	a3,0x8
    80004764:	a6868693          	addi	a3,a3,-1432 # 8000c1c8 <_ZN11ConsoleUtil8inputSemE>
    80004768:	0106b603          	ld	a2,16(a3)
    8000476c:	00160793          	addi	a5,a2,1
    80004770:	00002737          	lui	a4,0x2
    80004774:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004778:	00e7f7b3          	and	a5,a5,a4
    8000477c:	0186b703          	ld	a4,24(a3)
    80004780:	04e78263          	beq	a5,a4,800047c4 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80004784:	ff010113          	addi	sp,sp,-16
    80004788:	00113423          	sd	ra,8(sp)
    8000478c:	00813023          	sd	s0,0(sp)
    80004790:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004794:	0000a717          	auipc	a4,0xa
    80004798:	a6c70713          	addi	a4,a4,-1428 # 8000e200 <_ZN11ConsoleUtil11inputBufferE>
    8000479c:	00c70633          	add	a2,a4,a2
    800047a0:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    800047a4:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    800047a8:	0006b503          	ld	a0,0(a3)
    800047ac:	ffffe097          	auipc	ra,0xffffe
    800047b0:	0a8080e7          	jalr	168(ra) # 80002854 <_ZN3SCB6signalEv>
}
    800047b4:	00813083          	ld	ra,8(sp)
    800047b8:	00013403          	ld	s0,0(sp)
    800047bc:	01010113          	addi	sp,sp,16
    800047c0:	00008067          	ret
    800047c4:	00008067          	ret

00000000800047c8 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    800047c8:	fe010113          	addi	sp,sp,-32
    800047cc:	00113c23          	sd	ra,24(sp)
    800047d0:	00813823          	sd	s0,16(sp)
    800047d4:	00913423          	sd	s1,8(sp)
    800047d8:	02010413          	addi	s0,sp,32
    inputSem->wait();
    800047dc:	00008497          	auipc	s1,0x8
    800047e0:	9ec48493          	addi	s1,s1,-1556 # 8000c1c8 <_ZN11ConsoleUtil8inputSemE>
    800047e4:	0004b503          	ld	a0,0(s1)
    800047e8:	ffffe097          	auipc	ra,0xffffe
    800047ec:	01c080e7          	jalr	28(ra) # 80002804 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    800047f0:	0184b783          	ld	a5,24(s1)
    800047f4:	0104b703          	ld	a4,16(s1)
    800047f8:	04e78063          	beq	a5,a4,80004838 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    800047fc:	0000a717          	auipc	a4,0xa
    80004800:	a0470713          	addi	a4,a4,-1532 # 8000e200 <_ZN11ConsoleUtil11inputBufferE>
    80004804:	00f70733          	add	a4,a4,a5
    80004808:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    8000480c:	00178793          	addi	a5,a5,1
    80004810:	00002737          	lui	a4,0x2
    80004814:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004818:	00e7f7b3          	and	a5,a5,a4
    8000481c:	00008717          	auipc	a4,0x8
    80004820:	9cf73223          	sd	a5,-1596(a4) # 8000c1e0 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004824:	01813083          	ld	ra,24(sp)
    80004828:	01013403          	ld	s0,16(sp)
    8000482c:	00813483          	ld	s1,8(sp)
    80004830:	02010113          	addi	sp,sp,32
    80004834:	00008067          	ret
        return -1;
    80004838:	0ff00513          	li	a0,255
    8000483c:	fe9ff06f          	j	80004824 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004840 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004840:	00008797          	auipc	a5,0x8
    80004844:	98878793          	addi	a5,a5,-1656 # 8000c1c8 <_ZN11ConsoleUtil8inputSemE>
    80004848:	0207b603          	ld	a2,32(a5)
    8000484c:	00160713          	addi	a4,a2,1
    80004850:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004854:	0287b583          	ld	a1,40(a5)
    80004858:	00158713          	addi	a4,a1,1
    8000485c:	000026b7          	lui	a3,0x2
    80004860:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004864:	00d77733          	and	a4,a4,a3
    80004868:	0307b783          	ld	a5,48(a5)
    8000486c:	04f70863          	beq	a4,a5,800048bc <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80004870:	ff010113          	addi	sp,sp,-16
    80004874:	00113423          	sd	ra,8(sp)
    80004878:	00813023          	sd	s0,0(sp)
    8000487c:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004880:	00008797          	auipc	a5,0x8
    80004884:	98078793          	addi	a5,a5,-1664 # 8000c200 <_ZN11ConsoleUtil12outputBufferE>
    80004888:	00b785b3          	add	a1,a5,a1
    8000488c:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    80004890:	00008797          	auipc	a5,0x8
    80004894:	93878793          	addi	a5,a5,-1736 # 8000c1c8 <_ZN11ConsoleUtil8inputSemE>
    80004898:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    8000489c:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    800048a0:	0087b503          	ld	a0,8(a5)
    800048a4:	ffffe097          	auipc	ra,0xffffe
    800048a8:	fb0080e7          	jalr	-80(ra) # 80002854 <_ZN3SCB6signalEv>
}
    800048ac:	00813083          	ld	ra,8(sp)
    800048b0:	00013403          	ld	s0,0(sp)
    800048b4:	01010113          	addi	sp,sp,16
    800048b8:	00008067          	ret
    800048bc:	00008067          	ret

00000000800048c0 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    800048c0:	fe010113          	addi	sp,sp,-32
    800048c4:	00113c23          	sd	ra,24(sp)
    800048c8:	00813823          	sd	s0,16(sp)
    800048cc:	00913423          	sd	s1,8(sp)
    800048d0:	02010413          	addi	s0,sp,32
    outputSem->wait();
    800048d4:	00008497          	auipc	s1,0x8
    800048d8:	8f448493          	addi	s1,s1,-1804 # 8000c1c8 <_ZN11ConsoleUtil8inputSemE>
    800048dc:	0084b503          	ld	a0,8(s1)
    800048e0:	ffffe097          	auipc	ra,0xffffe
    800048e4:	f24080e7          	jalr	-220(ra) # 80002804 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    800048e8:	0304b783          	ld	a5,48(s1)
    800048ec:	0284b703          	ld	a4,40(s1)
    800048f0:	04e78063          	beq	a5,a4,80004930 <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    800048f4:	00008717          	auipc	a4,0x8
    800048f8:	90c70713          	addi	a4,a4,-1780 # 8000c200 <_ZN11ConsoleUtil12outputBufferE>
    800048fc:	00f70733          	add	a4,a4,a5
    80004900:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004904:	00178793          	addi	a5,a5,1
    80004908:	00002737          	lui	a4,0x2
    8000490c:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004910:	00e7f7b3          	and	a5,a5,a4
    80004914:	00008717          	auipc	a4,0x8
    80004918:	8ef73223          	sd	a5,-1820(a4) # 8000c1f8 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    8000491c:	01813083          	ld	ra,24(sp)
    80004920:	01013403          	ld	s0,16(sp)
    80004924:	00813483          	ld	s1,8(sp)
    80004928:	02010113          	addi	sp,sp,32
    8000492c:	00008067          	ret
        return -1;
    80004930:	0ff00513          	li	a0,255
    80004934:	fe9ff06f          	j	8000491c <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004938 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004938:	fe010113          	addi	sp,sp,-32
    8000493c:	00113c23          	sd	ra,24(sp)
    80004940:	00813823          	sd	s0,16(sp)
    80004944:	00913423          	sd	s1,8(sp)
    80004948:	02010413          	addi	s0,sp,32
    8000494c:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004950:	0004c503          	lbu	a0,0(s1)
    80004954:	00050a63          	beqz	a0,80004968 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004958:	00000097          	auipc	ra,0x0
    8000495c:	ee8080e7          	jalr	-280(ra) # 80004840 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004960:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004964:	fedff06f          	j	80004950 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004968:	01813083          	ld	ra,24(sp)
    8000496c:	01013403          	ld	s0,16(sp)
    80004970:	00813483          	ld	s1,8(sp)
    80004974:	02010113          	addi	sp,sp,32
    80004978:	00008067          	ret

000000008000497c <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    8000497c:	fb010113          	addi	sp,sp,-80
    80004980:	04113423          	sd	ra,72(sp)
    80004984:	04813023          	sd	s0,64(sp)
    80004988:	02913c23          	sd	s1,56(sp)
    8000498c:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004990:	00005797          	auipc	a5,0x5
    80004994:	a0878793          	addi	a5,a5,-1528 # 80009398 <CONSOLE_STATUS+0x388>
    80004998:	0007b703          	ld	a4,0(a5)
    8000499c:	fce43423          	sd	a4,-56(s0)
    800049a0:	0087b703          	ld	a4,8(a5)
    800049a4:	fce43823          	sd	a4,-48(s0)
    800049a8:	0107c783          	lbu	a5,16(a5)
    800049ac:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800049b0:	00060463          	beqz	a2,800049b8 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    800049b4:	08054263          	bltz	a0,80004a38 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800049b8:	0005051b          	sext.w	a0,a0
    neg = 0;
    800049bc:	00000813          	li	a6,0
    }

    i = 0;
    800049c0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800049c4:	0005871b          	sext.w	a4,a1
    800049c8:	02b577bb          	remuw	a5,a0,a1
    800049cc:	00048693          	mv	a3,s1
    800049d0:	0014849b          	addiw	s1,s1,1
    800049d4:	02079793          	slli	a5,a5,0x20
    800049d8:	0207d793          	srli	a5,a5,0x20
    800049dc:	fe040613          	addi	a2,s0,-32
    800049e0:	00f607b3          	add	a5,a2,a5
    800049e4:	fe87c603          	lbu	a2,-24(a5)
    800049e8:	fe040793          	addi	a5,s0,-32
    800049ec:	00d787b3          	add	a5,a5,a3
    800049f0:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    800049f4:	0005061b          	sext.w	a2,a0
    800049f8:	02b5553b          	divuw	a0,a0,a1
    800049fc:	fce674e3          	bgeu	a2,a4,800049c4 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004a00:	00080c63          	beqz	a6,80004a18 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004a04:	fe040793          	addi	a5,s0,-32
    80004a08:	009784b3          	add	s1,a5,s1
    80004a0c:	02d00793          	li	a5,45
    80004a10:	fcf48c23          	sb	a5,-40(s1)
    80004a14:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004a18:	fff4849b          	addiw	s1,s1,-1
    80004a1c:	0204c463          	bltz	s1,80004a44 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004a20:	fe040793          	addi	a5,s0,-32
    80004a24:	009787b3          	add	a5,a5,s1
    80004a28:	fd87c503          	lbu	a0,-40(a5)
    80004a2c:	00000097          	auipc	ra,0x0
    80004a30:	e14080e7          	jalr	-492(ra) # 80004840 <_ZN11ConsoleUtil9putOutputEc>
    80004a34:	fe5ff06f          	j	80004a18 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004a38:	40a0053b          	negw	a0,a0
        neg = 1;
    80004a3c:	00100813          	li	a6,1
        x = -xx;
    80004a40:	f81ff06f          	j	800049c0 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004a44:	04813083          	ld	ra,72(sp)
    80004a48:	04013403          	ld	s0,64(sp)
    80004a4c:	03813483          	ld	s1,56(sp)
    80004a50:	05010113          	addi	sp,sp,80
    80004a54:	00008067          	ret

0000000080004a58 <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    80004a58:	fe010113          	addi	sp,sp,-32
    80004a5c:	00113c23          	sd	ra,24(sp)
    80004a60:	00813823          	sd	s0,16(sp)
    80004a64:	00913423          	sd	s1,8(sp)
    80004a68:	01213023          	sd	s2,0(sp)
    80004a6c:	02010413          	addi	s0,sp,32
    80004a70:	00058913          	mv	s2,a1
    80004a74:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    80004a78:	00000097          	auipc	ra,0x0
    80004a7c:	ec0080e7          	jalr	-320(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    80004a80:	00000613          	li	a2,0
    80004a84:	00a00593          	li	a1,10
    80004a88:	00090513          	mv	a0,s2
    80004a8c:	00000097          	auipc	ra,0x0
    80004a90:	ef0080e7          	jalr	-272(ra) # 8000497c <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004a94:	00048513          	mv	a0,s1
    80004a98:	00000097          	auipc	ra,0x0
    80004a9c:	ea0080e7          	jalr	-352(ra) # 80004938 <_ZN11ConsoleUtil11printStringEPKc>
}
    80004aa0:	01813083          	ld	ra,24(sp)
    80004aa4:	01013403          	ld	s0,16(sp)
    80004aa8:	00813483          	ld	s1,8(sp)
    80004aac:	00013903          	ld	s2,0(sp)
    80004ab0:	02010113          	addi	sp,sp,32
    80004ab4:	00008067          	ret

0000000080004ab8 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004ab8:	ff010113          	addi	sp,sp,-16
    80004abc:	00813423          	sd	s0,8(sp)
    80004ac0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004ac4:	04300513          	li	a0,67

    asm("ecall");
    80004ac8:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004acc:	00050513          	mv	a0,a0

    return (char)status;
}
    80004ad0:	0ff57513          	andi	a0,a0,255
    80004ad4:	00813403          	ld	s0,8(sp)
    80004ad8:	01010113          	addi	sp,sp,16
    80004adc:	00008067          	ret

0000000080004ae0 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004ae0:	ff010113          	addi	sp,sp,-16
    80004ae4:	00113423          	sd	ra,8(sp)
    80004ae8:	00813023          	sd	s0,0(sp)
    80004aec:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004af0:	ffffc097          	auipc	ra,0xffffc
    80004af4:	664080e7          	jalr	1636(ra) # 80001154 <_ZN13SlabAllocator10initializeEPvm>
    80004af8:	00813083          	ld	ra,8(sp)
    80004afc:	00013403          	ld	s0,0(sp)
    80004b00:	01010113          	addi	sp,sp,16
    80004b04:	00008067          	ret

0000000080004b08 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004b08:	fd010113          	addi	sp,sp,-48
    80004b0c:	02113423          	sd	ra,40(sp)
    80004b10:	02813023          	sd	s0,32(sp)
    80004b14:	00913c23          	sd	s1,24(sp)
    80004b18:	01213823          	sd	s2,16(sp)
    80004b1c:	01313423          	sd	s3,8(sp)
    80004b20:	03010413          	addi	s0,sp,48
    80004b24:	00050493          	mv	s1,a0
    80004b28:	00058913          	mv	s2,a1
    80004b2c:	0015879b          	addiw	a5,a1,1
    80004b30:	0007851b          	sext.w	a0,a5
    80004b34:	00f4a023          	sw	a5,0(s1)
    80004b38:	0004a823          	sw	zero,16(s1)
    80004b3c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004b40:	00251513          	slli	a0,a0,0x2
    80004b44:	ffffd097          	auipc	ra,0xffffd
    80004b48:	e18080e7          	jalr	-488(ra) # 8000195c <_Z9mem_allocm>
    80004b4c:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004b50:	01000513          	li	a0,16
    80004b54:	ffffe097          	auipc	ra,0xffffe
    80004b58:	600080e7          	jalr	1536(ra) # 80003154 <_Znwm>
    80004b5c:	00050993          	mv	s3,a0
    80004b60:	00000593          	li	a1,0
    80004b64:	ffffe097          	auipc	ra,0xffffe
    80004b68:	6e8080e7          	jalr	1768(ra) # 8000324c <_ZN9SemaphoreC1Ej>
    80004b6c:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004b70:	01000513          	li	a0,16
    80004b74:	ffffe097          	auipc	ra,0xffffe
    80004b78:	5e0080e7          	jalr	1504(ra) # 80003154 <_Znwm>
    80004b7c:	00050993          	mv	s3,a0
    80004b80:	00090593          	mv	a1,s2
    80004b84:	ffffe097          	auipc	ra,0xffffe
    80004b88:	6c8080e7          	jalr	1736(ra) # 8000324c <_ZN9SemaphoreC1Ej>
    80004b8c:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004b90:	01000513          	li	a0,16
    80004b94:	ffffe097          	auipc	ra,0xffffe
    80004b98:	5c0080e7          	jalr	1472(ra) # 80003154 <_Znwm>
    80004b9c:	00050913          	mv	s2,a0
    80004ba0:	00100593          	li	a1,1
    80004ba4:	ffffe097          	auipc	ra,0xffffe
    80004ba8:	6a8080e7          	jalr	1704(ra) # 8000324c <_ZN9SemaphoreC1Ej>
    80004bac:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004bb0:	01000513          	li	a0,16
    80004bb4:	ffffe097          	auipc	ra,0xffffe
    80004bb8:	5a0080e7          	jalr	1440(ra) # 80003154 <_Znwm>
    80004bbc:	00050913          	mv	s2,a0
    80004bc0:	00100593          	li	a1,1
    80004bc4:	ffffe097          	auipc	ra,0xffffe
    80004bc8:	688080e7          	jalr	1672(ra) # 8000324c <_ZN9SemaphoreC1Ej>
    80004bcc:	0324b823          	sd	s2,48(s1)
}
    80004bd0:	02813083          	ld	ra,40(sp)
    80004bd4:	02013403          	ld	s0,32(sp)
    80004bd8:	01813483          	ld	s1,24(sp)
    80004bdc:	01013903          	ld	s2,16(sp)
    80004be0:	00813983          	ld	s3,8(sp)
    80004be4:	03010113          	addi	sp,sp,48
    80004be8:	00008067          	ret
    80004bec:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004bf0:	00098513          	mv	a0,s3
    80004bf4:	ffffe097          	auipc	ra,0xffffe
    80004bf8:	5b0080e7          	jalr	1456(ra) # 800031a4 <_ZdlPv>
    80004bfc:	00048513          	mv	a0,s1
    80004c00:	0000c097          	auipc	ra,0xc
    80004c04:	6f8080e7          	jalr	1784(ra) # 800112f8 <_Unwind_Resume>
    80004c08:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004c0c:	00098513          	mv	a0,s3
    80004c10:	ffffe097          	auipc	ra,0xffffe
    80004c14:	594080e7          	jalr	1428(ra) # 800031a4 <_ZdlPv>
    80004c18:	00048513          	mv	a0,s1
    80004c1c:	0000c097          	auipc	ra,0xc
    80004c20:	6dc080e7          	jalr	1756(ra) # 800112f8 <_Unwind_Resume>
    80004c24:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004c28:	00090513          	mv	a0,s2
    80004c2c:	ffffe097          	auipc	ra,0xffffe
    80004c30:	578080e7          	jalr	1400(ra) # 800031a4 <_ZdlPv>
    80004c34:	00048513          	mv	a0,s1
    80004c38:	0000c097          	auipc	ra,0xc
    80004c3c:	6c0080e7          	jalr	1728(ra) # 800112f8 <_Unwind_Resume>
    80004c40:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004c44:	00090513          	mv	a0,s2
    80004c48:	ffffe097          	auipc	ra,0xffffe
    80004c4c:	55c080e7          	jalr	1372(ra) # 800031a4 <_ZdlPv>
    80004c50:	00048513          	mv	a0,s1
    80004c54:	0000c097          	auipc	ra,0xc
    80004c58:	6a4080e7          	jalr	1700(ra) # 800112f8 <_Unwind_Resume>

0000000080004c5c <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004c5c:	fe010113          	addi	sp,sp,-32
    80004c60:	00113c23          	sd	ra,24(sp)
    80004c64:	00813823          	sd	s0,16(sp)
    80004c68:	00913423          	sd	s1,8(sp)
    80004c6c:	01213023          	sd	s2,0(sp)
    80004c70:	02010413          	addi	s0,sp,32
    80004c74:	00050493          	mv	s1,a0
    80004c78:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004c7c:	01853503          	ld	a0,24(a0)
    80004c80:	ffffe097          	auipc	ra,0xffffe
    80004c84:	604080e7          	jalr	1540(ra) # 80003284 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004c88:	0304b503          	ld	a0,48(s1)
    80004c8c:	ffffe097          	auipc	ra,0xffffe
    80004c90:	5f8080e7          	jalr	1528(ra) # 80003284 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004c94:	0084b783          	ld	a5,8(s1)
    80004c98:	0144a703          	lw	a4,20(s1)
    80004c9c:	00271713          	slli	a4,a4,0x2
    80004ca0:	00e787b3          	add	a5,a5,a4
    80004ca4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004ca8:	0144a783          	lw	a5,20(s1)
    80004cac:	0017879b          	addiw	a5,a5,1
    80004cb0:	0004a703          	lw	a4,0(s1)
    80004cb4:	02e7e7bb          	remw	a5,a5,a4
    80004cb8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004cbc:	0304b503          	ld	a0,48(s1)
    80004cc0:	ffffe097          	auipc	ra,0xffffe
    80004cc4:	5f0080e7          	jalr	1520(ra) # 800032b0 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004cc8:	0204b503          	ld	a0,32(s1)
    80004ccc:	ffffe097          	auipc	ra,0xffffe
    80004cd0:	5e4080e7          	jalr	1508(ra) # 800032b0 <_ZN9Semaphore6signalEv>

}
    80004cd4:	01813083          	ld	ra,24(sp)
    80004cd8:	01013403          	ld	s0,16(sp)
    80004cdc:	00813483          	ld	s1,8(sp)
    80004ce0:	00013903          	ld	s2,0(sp)
    80004ce4:	02010113          	addi	sp,sp,32
    80004ce8:	00008067          	ret

0000000080004cec <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004cec:	fe010113          	addi	sp,sp,-32
    80004cf0:	00113c23          	sd	ra,24(sp)
    80004cf4:	00813823          	sd	s0,16(sp)
    80004cf8:	00913423          	sd	s1,8(sp)
    80004cfc:	01213023          	sd	s2,0(sp)
    80004d00:	02010413          	addi	s0,sp,32
    80004d04:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004d08:	02053503          	ld	a0,32(a0)
    80004d0c:	ffffe097          	auipc	ra,0xffffe
    80004d10:	578080e7          	jalr	1400(ra) # 80003284 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004d14:	0284b503          	ld	a0,40(s1)
    80004d18:	ffffe097          	auipc	ra,0xffffe
    80004d1c:	56c080e7          	jalr	1388(ra) # 80003284 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004d20:	0084b703          	ld	a4,8(s1)
    80004d24:	0104a783          	lw	a5,16(s1)
    80004d28:	00279693          	slli	a3,a5,0x2
    80004d2c:	00d70733          	add	a4,a4,a3
    80004d30:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004d34:	0017879b          	addiw	a5,a5,1
    80004d38:	0004a703          	lw	a4,0(s1)
    80004d3c:	02e7e7bb          	remw	a5,a5,a4
    80004d40:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004d44:	0284b503          	ld	a0,40(s1)
    80004d48:	ffffe097          	auipc	ra,0xffffe
    80004d4c:	568080e7          	jalr	1384(ra) # 800032b0 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004d50:	0184b503          	ld	a0,24(s1)
    80004d54:	ffffe097          	auipc	ra,0xffffe
    80004d58:	55c080e7          	jalr	1372(ra) # 800032b0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004d5c:	00090513          	mv	a0,s2
    80004d60:	01813083          	ld	ra,24(sp)
    80004d64:	01013403          	ld	s0,16(sp)
    80004d68:	00813483          	ld	s1,8(sp)
    80004d6c:	00013903          	ld	s2,0(sp)
    80004d70:	02010113          	addi	sp,sp,32
    80004d74:	00008067          	ret

0000000080004d78 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004d78:	fe010113          	addi	sp,sp,-32
    80004d7c:	00113c23          	sd	ra,24(sp)
    80004d80:	00813823          	sd	s0,16(sp)
    80004d84:	00913423          	sd	s1,8(sp)
    80004d88:	01213023          	sd	s2,0(sp)
    80004d8c:	02010413          	addi	s0,sp,32
    80004d90:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004d94:	02853503          	ld	a0,40(a0)
    80004d98:	ffffe097          	auipc	ra,0xffffe
    80004d9c:	4ec080e7          	jalr	1260(ra) # 80003284 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004da0:	0304b503          	ld	a0,48(s1)
    80004da4:	ffffe097          	auipc	ra,0xffffe
    80004da8:	4e0080e7          	jalr	1248(ra) # 80003284 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004dac:	0144a783          	lw	a5,20(s1)
    80004db0:	0104a903          	lw	s2,16(s1)
    80004db4:	0327ce63          	blt	a5,s2,80004df0 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004db8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004dbc:	0304b503          	ld	a0,48(s1)
    80004dc0:	ffffe097          	auipc	ra,0xffffe
    80004dc4:	4f0080e7          	jalr	1264(ra) # 800032b0 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004dc8:	0284b503          	ld	a0,40(s1)
    80004dcc:	ffffe097          	auipc	ra,0xffffe
    80004dd0:	4e4080e7          	jalr	1252(ra) # 800032b0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004dd4:	00090513          	mv	a0,s2
    80004dd8:	01813083          	ld	ra,24(sp)
    80004ddc:	01013403          	ld	s0,16(sp)
    80004de0:	00813483          	ld	s1,8(sp)
    80004de4:	00013903          	ld	s2,0(sp)
    80004de8:	02010113          	addi	sp,sp,32
    80004dec:	00008067          	ret
        ret = cap - head + tail;
    80004df0:	0004a703          	lw	a4,0(s1)
    80004df4:	4127093b          	subw	s2,a4,s2
    80004df8:	00f9093b          	addw	s2,s2,a5
    80004dfc:	fc1ff06f          	j	80004dbc <_ZN9BufferCPP6getCntEv+0x44>

0000000080004e00 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004e00:	fe010113          	addi	sp,sp,-32
    80004e04:	00113c23          	sd	ra,24(sp)
    80004e08:	00813823          	sd	s0,16(sp)
    80004e0c:	00913423          	sd	s1,8(sp)
    80004e10:	02010413          	addi	s0,sp,32
    80004e14:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004e18:	00a00513          	li	a0,10
    80004e1c:	ffffe097          	auipc	ra,0xffffe
    80004e20:	690080e7          	jalr	1680(ra) # 800034ac <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004e24:	00004517          	auipc	a0,0x4
    80004e28:	58c50513          	addi	a0,a0,1420 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80004e2c:	ffffd097          	auipc	ra,0xffffd
    80004e30:	5fc080e7          	jalr	1532(ra) # 80002428 <_Z11printStringPKc>
    while (getCnt()) {
    80004e34:	00048513          	mv	a0,s1
    80004e38:	00000097          	auipc	ra,0x0
    80004e3c:	f40080e7          	jalr	-192(ra) # 80004d78 <_ZN9BufferCPP6getCntEv>
    80004e40:	02050c63          	beqz	a0,80004e78 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004e44:	0084b783          	ld	a5,8(s1)
    80004e48:	0104a703          	lw	a4,16(s1)
    80004e4c:	00271713          	slli	a4,a4,0x2
    80004e50:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004e54:	0007c503          	lbu	a0,0(a5)
    80004e58:	ffffe097          	auipc	ra,0xffffe
    80004e5c:	654080e7          	jalr	1620(ra) # 800034ac <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004e60:	0104a783          	lw	a5,16(s1)
    80004e64:	0017879b          	addiw	a5,a5,1
    80004e68:	0004a703          	lw	a4,0(s1)
    80004e6c:	02e7e7bb          	remw	a5,a5,a4
    80004e70:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004e74:	fc1ff06f          	j	80004e34 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004e78:	02100513          	li	a0,33
    80004e7c:	ffffe097          	auipc	ra,0xffffe
    80004e80:	630080e7          	jalr	1584(ra) # 800034ac <_ZN7Console4putcEc>
    Console::putc('\n');
    80004e84:	00a00513          	li	a0,10
    80004e88:	ffffe097          	auipc	ra,0xffffe
    80004e8c:	624080e7          	jalr	1572(ra) # 800034ac <_ZN7Console4putcEc>
    mem_free(buffer);
    80004e90:	0084b503          	ld	a0,8(s1)
    80004e94:	ffffd097          	auipc	ra,0xffffd
    80004e98:	af8080e7          	jalr	-1288(ra) # 8000198c <_Z8mem_freePv>
    delete itemAvailable;
    80004e9c:	0204b503          	ld	a0,32(s1)
    80004ea0:	00050863          	beqz	a0,80004eb0 <_ZN9BufferCPPD1Ev+0xb0>
    80004ea4:	00053783          	ld	a5,0(a0)
    80004ea8:	0087b783          	ld	a5,8(a5)
    80004eac:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004eb0:	0184b503          	ld	a0,24(s1)
    80004eb4:	00050863          	beqz	a0,80004ec4 <_ZN9BufferCPPD1Ev+0xc4>
    80004eb8:	00053783          	ld	a5,0(a0)
    80004ebc:	0087b783          	ld	a5,8(a5)
    80004ec0:	000780e7          	jalr	a5
    delete mutexTail;
    80004ec4:	0304b503          	ld	a0,48(s1)
    80004ec8:	00050863          	beqz	a0,80004ed8 <_ZN9BufferCPPD1Ev+0xd8>
    80004ecc:	00053783          	ld	a5,0(a0)
    80004ed0:	0087b783          	ld	a5,8(a5)
    80004ed4:	000780e7          	jalr	a5
    delete mutexHead;
    80004ed8:	0284b503          	ld	a0,40(s1)
    80004edc:	00050863          	beqz	a0,80004eec <_ZN9BufferCPPD1Ev+0xec>
    80004ee0:	00053783          	ld	a5,0(a0)
    80004ee4:	0087b783          	ld	a5,8(a5)
    80004ee8:	000780e7          	jalr	a5
}
    80004eec:	01813083          	ld	ra,24(sp)
    80004ef0:	01013403          	ld	s0,16(sp)
    80004ef4:	00813483          	ld	s1,8(sp)
    80004ef8:	02010113          	addi	sp,sp,32
    80004efc:	00008067          	ret

0000000080004f00 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80004f00:	fe010113          	addi	sp,sp,-32
    80004f04:	00113c23          	sd	ra,24(sp)
    80004f08:	00813823          	sd	s0,16(sp)
    80004f0c:	00913423          	sd	s1,8(sp)
    80004f10:	01213023          	sd	s2,0(sp)
    80004f14:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80004f18:	00053903          	ld	s2,0(a0)
    int i = 6;
    80004f1c:	00600493          	li	s1,6
    while (--i > 0) {
    80004f20:	fff4849b          	addiw	s1,s1,-1
    80004f24:	04905463          	blez	s1,80004f6c <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    80004f28:	00004517          	auipc	a0,0x4
    80004f2c:	4a050513          	addi	a0,a0,1184 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80004f30:	ffffd097          	auipc	ra,0xffffd
    80004f34:	4f8080e7          	jalr	1272(ra) # 80002428 <_Z11printStringPKc>
        printInt(sleep_time);
    80004f38:	00000613          	li	a2,0
    80004f3c:	00a00593          	li	a1,10
    80004f40:	0009051b          	sext.w	a0,s2
    80004f44:	ffffd097          	auipc	ra,0xffffd
    80004f48:	67c080e7          	jalr	1660(ra) # 800025c0 <_Z8printIntiii>
        printString(" !\n");
    80004f4c:	00004517          	auipc	a0,0x4
    80004f50:	48450513          	addi	a0,a0,1156 # 800093d0 <CONSOLE_STATUS+0x3c0>
    80004f54:	ffffd097          	auipc	ra,0xffffd
    80004f58:	4d4080e7          	jalr	1236(ra) # 80002428 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80004f5c:	00090513          	mv	a0,s2
    80004f60:	ffffd097          	auipc	ra,0xffffd
    80004f64:	c80080e7          	jalr	-896(ra) # 80001be0 <_Z10time_sleepm>
    while (--i > 0) {
    80004f68:	fb9ff06f          	j	80004f20 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80004f6c:	00a00793          	li	a5,10
    80004f70:	02f95933          	divu	s2,s2,a5
    80004f74:	fff90913          	addi	s2,s2,-1
    80004f78:	0000b797          	auipc	a5,0xb
    80004f7c:	29078793          	addi	a5,a5,656 # 80010208 <_ZN19ConsumerProducerCPP9threadEndE>
    80004f80:	01278933          	add	s2,a5,s2
    80004f84:	00100793          	li	a5,1
    80004f88:	00f90423          	sb	a5,8(s2)
}
    80004f8c:	01813083          	ld	ra,24(sp)
    80004f90:	01013403          	ld	s0,16(sp)
    80004f94:	00813483          	ld	s1,8(sp)
    80004f98:	00013903          	ld	s2,0(sp)
    80004f9c:	02010113          	addi	sp,sp,32
    80004fa0:	00008067          	ret

0000000080004fa4 <_Z9fibonaccim>:
bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    80004fa4:	fe010113          	addi	sp,sp,-32
    80004fa8:	00113c23          	sd	ra,24(sp)
    80004fac:	00813823          	sd	s0,16(sp)
    80004fb0:	00913423          	sd	s1,8(sp)
    80004fb4:	01213023          	sd	s2,0(sp)
    80004fb8:	02010413          	addi	s0,sp,32
    80004fbc:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004fc0:	00100793          	li	a5,1
    80004fc4:	02a7f863          	bgeu	a5,a0,80004ff4 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004fc8:	00a00793          	li	a5,10
    80004fcc:	02f577b3          	remu	a5,a0,a5
    80004fd0:	02078e63          	beqz	a5,8000500c <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004fd4:	fff48513          	addi	a0,s1,-1
    80004fd8:	00000097          	auipc	ra,0x0
    80004fdc:	fcc080e7          	jalr	-52(ra) # 80004fa4 <_Z9fibonaccim>
    80004fe0:	00050913          	mv	s2,a0
    80004fe4:	ffe48513          	addi	a0,s1,-2
    80004fe8:	00000097          	auipc	ra,0x0
    80004fec:	fbc080e7          	jalr	-68(ra) # 80004fa4 <_Z9fibonaccim>
    80004ff0:	00a90533          	add	a0,s2,a0
}
    80004ff4:	01813083          	ld	ra,24(sp)
    80004ff8:	01013403          	ld	s0,16(sp)
    80004ffc:	00813483          	ld	s1,8(sp)
    80005000:	00013903          	ld	s2,0(sp)
    80005004:	02010113          	addi	sp,sp,32
    80005008:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000500c:	ffffd097          	auipc	ra,0xffffd
    80005010:	a50080e7          	jalr	-1456(ra) # 80001a5c <_Z15thread_dispatchv>
    80005014:	fc1ff06f          	j	80004fd4 <_Z9fibonaccim+0x30>

0000000080005018 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80005018:	fe010113          	addi	sp,sp,-32
    8000501c:	00113c23          	sd	ra,24(sp)
    80005020:	00813823          	sd	s0,16(sp)
    80005024:	00913423          	sd	s1,8(sp)
    80005028:	01213023          	sd	s2,0(sp)
    8000502c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005030:	00000913          	li	s2,0
    80005034:	0380006f          	j	8000506c <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005038:	ffffd097          	auipc	ra,0xffffd
    8000503c:	a24080e7          	jalr	-1500(ra) # 80001a5c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005040:	00148493          	addi	s1,s1,1
    80005044:	000027b7          	lui	a5,0x2
    80005048:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000504c:	0097ee63          	bltu	a5,s1,80005068 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005050:	00000713          	li	a4,0
    80005054:	000077b7          	lui	a5,0x7
    80005058:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000505c:	fce7eee3          	bltu	a5,a4,80005038 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80005060:	00170713          	addi	a4,a4,1
    80005064:	ff1ff06f          	j	80005054 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005068:	00190913          	addi	s2,s2,1
    8000506c:	00900793          	li	a5,9
    80005070:	0527e063          	bltu	a5,s2,800050b0 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005074:	00004517          	auipc	a0,0x4
    80005078:	36450513          	addi	a0,a0,868 # 800093d8 <CONSOLE_STATUS+0x3c8>
    8000507c:	ffffd097          	auipc	ra,0xffffd
    80005080:	3ac080e7          	jalr	940(ra) # 80002428 <_Z11printStringPKc>
    80005084:	00000613          	li	a2,0
    80005088:	00a00593          	li	a1,10
    8000508c:	0009051b          	sext.w	a0,s2
    80005090:	ffffd097          	auipc	ra,0xffffd
    80005094:	530080e7          	jalr	1328(ra) # 800025c0 <_Z8printIntiii>
    80005098:	00004517          	auipc	a0,0x4
    8000509c:	10850513          	addi	a0,a0,264 # 800091a0 <CONSOLE_STATUS+0x190>
    800050a0:	ffffd097          	auipc	ra,0xffffd
    800050a4:	388080e7          	jalr	904(ra) # 80002428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800050a8:	00000493          	li	s1,0
    800050ac:	f99ff06f          	j	80005044 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    800050b0:	00004517          	auipc	a0,0x4
    800050b4:	33050513          	addi	a0,a0,816 # 800093e0 <CONSOLE_STATUS+0x3d0>
    800050b8:	ffffd097          	auipc	ra,0xffffd
    800050bc:	370080e7          	jalr	880(ra) # 80002428 <_Z11printStringPKc>
    finishedA = true;
    800050c0:	00100793          	li	a5,1
    800050c4:	0000b717          	auipc	a4,0xb
    800050c8:	14f70723          	sb	a5,334(a4) # 80010212 <finishedA>
}
    800050cc:	01813083          	ld	ra,24(sp)
    800050d0:	01013403          	ld	s0,16(sp)
    800050d4:	00813483          	ld	s1,8(sp)
    800050d8:	00013903          	ld	s2,0(sp)
    800050dc:	02010113          	addi	sp,sp,32
    800050e0:	00008067          	ret

00000000800050e4 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800050e4:	fe010113          	addi	sp,sp,-32
    800050e8:	00113c23          	sd	ra,24(sp)
    800050ec:	00813823          	sd	s0,16(sp)
    800050f0:	00913423          	sd	s1,8(sp)
    800050f4:	01213023          	sd	s2,0(sp)
    800050f8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800050fc:	00000913          	li	s2,0
    80005100:	0380006f          	j	80005138 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005104:	ffffd097          	auipc	ra,0xffffd
    80005108:	958080e7          	jalr	-1704(ra) # 80001a5c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000510c:	00148493          	addi	s1,s1,1
    80005110:	000027b7          	lui	a5,0x2
    80005114:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005118:	0097ee63          	bltu	a5,s1,80005134 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000511c:	00000713          	li	a4,0
    80005120:	000077b7          	lui	a5,0x7
    80005124:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005128:	fce7eee3          	bltu	a5,a4,80005104 <_ZN7WorkerB11workerBodyBEPv+0x20>
    8000512c:	00170713          	addi	a4,a4,1
    80005130:	ff1ff06f          	j	80005120 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005134:	00190913          	addi	s2,s2,1
    80005138:	00f00793          	li	a5,15
    8000513c:	0527e063          	bltu	a5,s2,8000517c <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005140:	00004517          	auipc	a0,0x4
    80005144:	2b050513          	addi	a0,a0,688 # 800093f0 <CONSOLE_STATUS+0x3e0>
    80005148:	ffffd097          	auipc	ra,0xffffd
    8000514c:	2e0080e7          	jalr	736(ra) # 80002428 <_Z11printStringPKc>
    80005150:	00000613          	li	a2,0
    80005154:	00a00593          	li	a1,10
    80005158:	0009051b          	sext.w	a0,s2
    8000515c:	ffffd097          	auipc	ra,0xffffd
    80005160:	464080e7          	jalr	1124(ra) # 800025c0 <_Z8printIntiii>
    80005164:	00004517          	auipc	a0,0x4
    80005168:	03c50513          	addi	a0,a0,60 # 800091a0 <CONSOLE_STATUS+0x190>
    8000516c:	ffffd097          	auipc	ra,0xffffd
    80005170:	2bc080e7          	jalr	700(ra) # 80002428 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80005174:	00000493          	li	s1,0
    80005178:	f99ff06f          	j	80005110 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000517c:	00004517          	auipc	a0,0x4
    80005180:	27c50513          	addi	a0,a0,636 # 800093f8 <CONSOLE_STATUS+0x3e8>
    80005184:	ffffd097          	auipc	ra,0xffffd
    80005188:	2a4080e7          	jalr	676(ra) # 80002428 <_Z11printStringPKc>
    finishedB = true;
    8000518c:	00100793          	li	a5,1
    80005190:	0000b717          	auipc	a4,0xb
    80005194:	08f701a3          	sb	a5,131(a4) # 80010213 <finishedB>
    thread_dispatch();
    80005198:	ffffd097          	auipc	ra,0xffffd
    8000519c:	8c4080e7          	jalr	-1852(ra) # 80001a5c <_Z15thread_dispatchv>
}
    800051a0:	01813083          	ld	ra,24(sp)
    800051a4:	01013403          	ld	s0,16(sp)
    800051a8:	00813483          	ld	s1,8(sp)
    800051ac:	00013903          	ld	s2,0(sp)
    800051b0:	02010113          	addi	sp,sp,32
    800051b4:	00008067          	ret

00000000800051b8 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    800051b8:	fe010113          	addi	sp,sp,-32
    800051bc:	00113c23          	sd	ra,24(sp)
    800051c0:	00813823          	sd	s0,16(sp)
    800051c4:	00913423          	sd	s1,8(sp)
    800051c8:	01213023          	sd	s2,0(sp)
    800051cc:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800051d0:	00000493          	li	s1,0
    800051d4:	0400006f          	j	80005214 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800051d8:	00004517          	auipc	a0,0x4
    800051dc:	23050513          	addi	a0,a0,560 # 80009408 <CONSOLE_STATUS+0x3f8>
    800051e0:	ffffd097          	auipc	ra,0xffffd
    800051e4:	248080e7          	jalr	584(ra) # 80002428 <_Z11printStringPKc>
    800051e8:	00000613          	li	a2,0
    800051ec:	00a00593          	li	a1,10
    800051f0:	00048513          	mv	a0,s1
    800051f4:	ffffd097          	auipc	ra,0xffffd
    800051f8:	3cc080e7          	jalr	972(ra) # 800025c0 <_Z8printIntiii>
    800051fc:	00004517          	auipc	a0,0x4
    80005200:	fa450513          	addi	a0,a0,-92 # 800091a0 <CONSOLE_STATUS+0x190>
    80005204:	ffffd097          	auipc	ra,0xffffd
    80005208:	224080e7          	jalr	548(ra) # 80002428 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000520c:	0014849b          	addiw	s1,s1,1
    80005210:	0ff4f493          	andi	s1,s1,255
    80005214:	00200793          	li	a5,2
    80005218:	fc97f0e3          	bgeu	a5,s1,800051d8 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    8000521c:	00004517          	auipc	a0,0x4
    80005220:	1f450513          	addi	a0,a0,500 # 80009410 <CONSOLE_STATUS+0x400>
    80005224:	ffffd097          	auipc	ra,0xffffd
    80005228:	204080e7          	jalr	516(ra) # 80002428 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000522c:	00700313          	li	t1,7
    thread_dispatch();
    80005230:	ffffd097          	auipc	ra,0xffffd
    80005234:	82c080e7          	jalr	-2004(ra) # 80001a5c <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005238:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000523c:	00004517          	auipc	a0,0x4
    80005240:	1e450513          	addi	a0,a0,484 # 80009420 <CONSOLE_STATUS+0x410>
    80005244:	ffffd097          	auipc	ra,0xffffd
    80005248:	1e4080e7          	jalr	484(ra) # 80002428 <_Z11printStringPKc>
    8000524c:	00000613          	li	a2,0
    80005250:	00a00593          	li	a1,10
    80005254:	0009051b          	sext.w	a0,s2
    80005258:	ffffd097          	auipc	ra,0xffffd
    8000525c:	368080e7          	jalr	872(ra) # 800025c0 <_Z8printIntiii>
    80005260:	00004517          	auipc	a0,0x4
    80005264:	f4050513          	addi	a0,a0,-192 # 800091a0 <CONSOLE_STATUS+0x190>
    80005268:	ffffd097          	auipc	ra,0xffffd
    8000526c:	1c0080e7          	jalr	448(ra) # 80002428 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80005270:	00c00513          	li	a0,12
    80005274:	00000097          	auipc	ra,0x0
    80005278:	d30080e7          	jalr	-720(ra) # 80004fa4 <_Z9fibonaccim>
    8000527c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005280:	00004517          	auipc	a0,0x4
    80005284:	1a850513          	addi	a0,a0,424 # 80009428 <CONSOLE_STATUS+0x418>
    80005288:	ffffd097          	auipc	ra,0xffffd
    8000528c:	1a0080e7          	jalr	416(ra) # 80002428 <_Z11printStringPKc>
    80005290:	00000613          	li	a2,0
    80005294:	00a00593          	li	a1,10
    80005298:	0009051b          	sext.w	a0,s2
    8000529c:	ffffd097          	auipc	ra,0xffffd
    800052a0:	324080e7          	jalr	804(ra) # 800025c0 <_Z8printIntiii>
    800052a4:	00004517          	auipc	a0,0x4
    800052a8:	efc50513          	addi	a0,a0,-260 # 800091a0 <CONSOLE_STATUS+0x190>
    800052ac:	ffffd097          	auipc	ra,0xffffd
    800052b0:	17c080e7          	jalr	380(ra) # 80002428 <_Z11printStringPKc>
    800052b4:	0400006f          	j	800052f4 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800052b8:	00004517          	auipc	a0,0x4
    800052bc:	15050513          	addi	a0,a0,336 # 80009408 <CONSOLE_STATUS+0x3f8>
    800052c0:	ffffd097          	auipc	ra,0xffffd
    800052c4:	168080e7          	jalr	360(ra) # 80002428 <_Z11printStringPKc>
    800052c8:	00000613          	li	a2,0
    800052cc:	00a00593          	li	a1,10
    800052d0:	00048513          	mv	a0,s1
    800052d4:	ffffd097          	auipc	ra,0xffffd
    800052d8:	2ec080e7          	jalr	748(ra) # 800025c0 <_Z8printIntiii>
    800052dc:	00004517          	auipc	a0,0x4
    800052e0:	ec450513          	addi	a0,a0,-316 # 800091a0 <CONSOLE_STATUS+0x190>
    800052e4:	ffffd097          	auipc	ra,0xffffd
    800052e8:	144080e7          	jalr	324(ra) # 80002428 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800052ec:	0014849b          	addiw	s1,s1,1
    800052f0:	0ff4f493          	andi	s1,s1,255
    800052f4:	00500793          	li	a5,5
    800052f8:	fc97f0e3          	bgeu	a5,s1,800052b8 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    800052fc:	00004517          	auipc	a0,0x4
    80005300:	13c50513          	addi	a0,a0,316 # 80009438 <CONSOLE_STATUS+0x428>
    80005304:	ffffd097          	auipc	ra,0xffffd
    80005308:	124080e7          	jalr	292(ra) # 80002428 <_Z11printStringPKc>
    finishedC = true;
    8000530c:	00100793          	li	a5,1
    80005310:	0000b717          	auipc	a4,0xb
    80005314:	f0f70223          	sb	a5,-252(a4) # 80010214 <finishedC>
    thread_dispatch();
    80005318:	ffffc097          	auipc	ra,0xffffc
    8000531c:	744080e7          	jalr	1860(ra) # 80001a5c <_Z15thread_dispatchv>
}
    80005320:	01813083          	ld	ra,24(sp)
    80005324:	01013403          	ld	s0,16(sp)
    80005328:	00813483          	ld	s1,8(sp)
    8000532c:	00013903          	ld	s2,0(sp)
    80005330:	02010113          	addi	sp,sp,32
    80005334:	00008067          	ret

0000000080005338 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80005338:	fe010113          	addi	sp,sp,-32
    8000533c:	00113c23          	sd	ra,24(sp)
    80005340:	00813823          	sd	s0,16(sp)
    80005344:	00913423          	sd	s1,8(sp)
    80005348:	01213023          	sd	s2,0(sp)
    8000534c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005350:	00a00493          	li	s1,10
    80005354:	0400006f          	j	80005394 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005358:	00004517          	auipc	a0,0x4
    8000535c:	0f050513          	addi	a0,a0,240 # 80009448 <CONSOLE_STATUS+0x438>
    80005360:	ffffd097          	auipc	ra,0xffffd
    80005364:	0c8080e7          	jalr	200(ra) # 80002428 <_Z11printStringPKc>
    80005368:	00000613          	li	a2,0
    8000536c:	00a00593          	li	a1,10
    80005370:	00048513          	mv	a0,s1
    80005374:	ffffd097          	auipc	ra,0xffffd
    80005378:	24c080e7          	jalr	588(ra) # 800025c0 <_Z8printIntiii>
    8000537c:	00004517          	auipc	a0,0x4
    80005380:	e2450513          	addi	a0,a0,-476 # 800091a0 <CONSOLE_STATUS+0x190>
    80005384:	ffffd097          	auipc	ra,0xffffd
    80005388:	0a4080e7          	jalr	164(ra) # 80002428 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000538c:	0014849b          	addiw	s1,s1,1
    80005390:	0ff4f493          	andi	s1,s1,255
    80005394:	00c00793          	li	a5,12
    80005398:	fc97f0e3          	bgeu	a5,s1,80005358 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    8000539c:	00004517          	auipc	a0,0x4
    800053a0:	0b450513          	addi	a0,a0,180 # 80009450 <CONSOLE_STATUS+0x440>
    800053a4:	ffffd097          	auipc	ra,0xffffd
    800053a8:	084080e7          	jalr	132(ra) # 80002428 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800053ac:	00500313          	li	t1,5
    thread_dispatch();
    800053b0:	ffffc097          	auipc	ra,0xffffc
    800053b4:	6ac080e7          	jalr	1708(ra) # 80001a5c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800053b8:	01000513          	li	a0,16
    800053bc:	00000097          	auipc	ra,0x0
    800053c0:	be8080e7          	jalr	-1048(ra) # 80004fa4 <_Z9fibonaccim>
    800053c4:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800053c8:	00004517          	auipc	a0,0x4
    800053cc:	09850513          	addi	a0,a0,152 # 80009460 <CONSOLE_STATUS+0x450>
    800053d0:	ffffd097          	auipc	ra,0xffffd
    800053d4:	058080e7          	jalr	88(ra) # 80002428 <_Z11printStringPKc>
    800053d8:	00000613          	li	a2,0
    800053dc:	00a00593          	li	a1,10
    800053e0:	0009051b          	sext.w	a0,s2
    800053e4:	ffffd097          	auipc	ra,0xffffd
    800053e8:	1dc080e7          	jalr	476(ra) # 800025c0 <_Z8printIntiii>
    800053ec:	00004517          	auipc	a0,0x4
    800053f0:	db450513          	addi	a0,a0,-588 # 800091a0 <CONSOLE_STATUS+0x190>
    800053f4:	ffffd097          	auipc	ra,0xffffd
    800053f8:	034080e7          	jalr	52(ra) # 80002428 <_Z11printStringPKc>
    800053fc:	0400006f          	j	8000543c <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005400:	00004517          	auipc	a0,0x4
    80005404:	04850513          	addi	a0,a0,72 # 80009448 <CONSOLE_STATUS+0x438>
    80005408:	ffffd097          	auipc	ra,0xffffd
    8000540c:	020080e7          	jalr	32(ra) # 80002428 <_Z11printStringPKc>
    80005410:	00000613          	li	a2,0
    80005414:	00a00593          	li	a1,10
    80005418:	00048513          	mv	a0,s1
    8000541c:	ffffd097          	auipc	ra,0xffffd
    80005420:	1a4080e7          	jalr	420(ra) # 800025c0 <_Z8printIntiii>
    80005424:	00004517          	auipc	a0,0x4
    80005428:	d7c50513          	addi	a0,a0,-644 # 800091a0 <CONSOLE_STATUS+0x190>
    8000542c:	ffffd097          	auipc	ra,0xffffd
    80005430:	ffc080e7          	jalr	-4(ra) # 80002428 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005434:	0014849b          	addiw	s1,s1,1
    80005438:	0ff4f493          	andi	s1,s1,255
    8000543c:	00f00793          	li	a5,15
    80005440:	fc97f0e3          	bgeu	a5,s1,80005400 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80005444:	00004517          	auipc	a0,0x4
    80005448:	02c50513          	addi	a0,a0,44 # 80009470 <CONSOLE_STATUS+0x460>
    8000544c:	ffffd097          	auipc	ra,0xffffd
    80005450:	fdc080e7          	jalr	-36(ra) # 80002428 <_Z11printStringPKc>
    finishedD = true;
    80005454:	00100793          	li	a5,1
    80005458:	0000b717          	auipc	a4,0xb
    8000545c:	daf70ea3          	sb	a5,-579(a4) # 80010215 <finishedD>
    thread_dispatch();
    80005460:	ffffc097          	auipc	ra,0xffffc
    80005464:	5fc080e7          	jalr	1532(ra) # 80001a5c <_Z15thread_dispatchv>
}
    80005468:	01813083          	ld	ra,24(sp)
    8000546c:	01013403          	ld	s0,16(sp)
    80005470:	00813483          	ld	s1,8(sp)
    80005474:	00013903          	ld	s2,0(sp)
    80005478:	02010113          	addi	sp,sp,32
    8000547c:	00008067          	ret

0000000080005480 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80005480:	fc010113          	addi	sp,sp,-64
    80005484:	02113c23          	sd	ra,56(sp)
    80005488:	02813823          	sd	s0,48(sp)
    8000548c:	02913423          	sd	s1,40(sp)
    80005490:	03213023          	sd	s2,32(sp)
    80005494:	04010413          	addi	s0,sp,64

    Thread* threads[4];

    threads[0] = new WorkerA();
    80005498:	01000513          	li	a0,16
    8000549c:	ffffe097          	auipc	ra,0xffffe
    800054a0:	cb8080e7          	jalr	-840(ra) # 80003154 <_Znwm>
    800054a4:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    800054a8:	ffffe097          	auipc	ra,0xffffe
    800054ac:	e6c080e7          	jalr	-404(ra) # 80003314 <_ZN6ThreadC1Ev>
    800054b0:	00007797          	auipc	a5,0x7
    800054b4:	8b078793          	addi	a5,a5,-1872 # 8000bd60 <_ZTV7WorkerA+0x10>
    800054b8:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    800054bc:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    800054c0:	00004517          	auipc	a0,0x4
    800054c4:	fc050513          	addi	a0,a0,-64 # 80009480 <CONSOLE_STATUS+0x470>
    800054c8:	ffffd097          	auipc	ra,0xffffd
    800054cc:	f60080e7          	jalr	-160(ra) # 80002428 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800054d0:	01000513          	li	a0,16
    800054d4:	ffffe097          	auipc	ra,0xffffe
    800054d8:	c80080e7          	jalr	-896(ra) # 80003154 <_Znwm>
    800054dc:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    800054e0:	ffffe097          	auipc	ra,0xffffe
    800054e4:	e34080e7          	jalr	-460(ra) # 80003314 <_ZN6ThreadC1Ev>
    800054e8:	00007797          	auipc	a5,0x7
    800054ec:	8a078793          	addi	a5,a5,-1888 # 8000bd88 <_ZTV7WorkerB+0x10>
    800054f0:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    800054f4:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    800054f8:	00004517          	auipc	a0,0x4
    800054fc:	fa050513          	addi	a0,a0,-96 # 80009498 <CONSOLE_STATUS+0x488>
    80005500:	ffffd097          	auipc	ra,0xffffd
    80005504:	f28080e7          	jalr	-216(ra) # 80002428 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80005508:	01000513          	li	a0,16
    8000550c:	ffffe097          	auipc	ra,0xffffe
    80005510:	c48080e7          	jalr	-952(ra) # 80003154 <_Znwm>
    80005514:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80005518:	ffffe097          	auipc	ra,0xffffe
    8000551c:	dfc080e7          	jalr	-516(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005520:	00007797          	auipc	a5,0x7
    80005524:	89078793          	addi	a5,a5,-1904 # 8000bdb0 <_ZTV7WorkerC+0x10>
    80005528:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    8000552c:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80005530:	00004517          	auipc	a0,0x4
    80005534:	f8050513          	addi	a0,a0,-128 # 800094b0 <CONSOLE_STATUS+0x4a0>
    80005538:	ffffd097          	auipc	ra,0xffffd
    8000553c:	ef0080e7          	jalr	-272(ra) # 80002428 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80005540:	01000513          	li	a0,16
    80005544:	ffffe097          	auipc	ra,0xffffe
    80005548:	c10080e7          	jalr	-1008(ra) # 80003154 <_Znwm>
    8000554c:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80005550:	ffffe097          	auipc	ra,0xffffe
    80005554:	dc4080e7          	jalr	-572(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005558:	00007797          	auipc	a5,0x7
    8000555c:	88078793          	addi	a5,a5,-1920 # 8000bdd8 <_ZTV7WorkerD+0x10>
    80005560:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80005564:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80005568:	00004517          	auipc	a0,0x4
    8000556c:	f6050513          	addi	a0,a0,-160 # 800094c8 <CONSOLE_STATUS+0x4b8>
    80005570:	ffffd097          	auipc	ra,0xffffd
    80005574:	eb8080e7          	jalr	-328(ra) # 80002428 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80005578:	00000493          	li	s1,0
    8000557c:	00300793          	li	a5,3
    80005580:	0297c663          	blt	a5,s1,800055ac <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80005584:	00349793          	slli	a5,s1,0x3
    80005588:	fe040713          	addi	a4,s0,-32
    8000558c:	00f707b3          	add	a5,a4,a5
    80005590:	fe07b503          	ld	a0,-32(a5)
    80005594:	ffffe097          	auipc	ra,0xffffe
    80005598:	e54080e7          	jalr	-428(ra) # 800033e8 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    8000559c:	0014849b          	addiw	s1,s1,1
    800055a0:	fddff06f          	j	8000557c <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    800055a4:	ffffe097          	auipc	ra,0xffffe
    800055a8:	e1c080e7          	jalr	-484(ra) # 800033c0 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800055ac:	0000b797          	auipc	a5,0xb
    800055b0:	c667c783          	lbu	a5,-922(a5) # 80010212 <finishedA>
    800055b4:	fe0788e3          	beqz	a5,800055a4 <_Z20Threads_CPP_API_testv+0x124>
    800055b8:	0000b797          	auipc	a5,0xb
    800055bc:	c5b7c783          	lbu	a5,-933(a5) # 80010213 <finishedB>
    800055c0:	fe0782e3          	beqz	a5,800055a4 <_Z20Threads_CPP_API_testv+0x124>
    800055c4:	0000b797          	auipc	a5,0xb
    800055c8:	c507c783          	lbu	a5,-944(a5) # 80010214 <finishedC>
    800055cc:	fc078ce3          	beqz	a5,800055a4 <_Z20Threads_CPP_API_testv+0x124>
    800055d0:	0000b797          	auipc	a5,0xb
    800055d4:	c457c783          	lbu	a5,-955(a5) # 80010215 <finishedD>
    800055d8:	fc0786e3          	beqz	a5,800055a4 <_Z20Threads_CPP_API_testv+0x124>
    }

    for (auto thread: threads) { delete thread; }
    800055dc:	fc040493          	addi	s1,s0,-64
    800055e0:	0080006f          	j	800055e8 <_Z20Threads_CPP_API_testv+0x168>
    800055e4:	00848493          	addi	s1,s1,8
    800055e8:	fe040793          	addi	a5,s0,-32
    800055ec:	08f48663          	beq	s1,a5,80005678 <_Z20Threads_CPP_API_testv+0x1f8>
    800055f0:	0004b503          	ld	a0,0(s1)
    800055f4:	fe0508e3          	beqz	a0,800055e4 <_Z20Threads_CPP_API_testv+0x164>
    800055f8:	00053783          	ld	a5,0(a0)
    800055fc:	0087b783          	ld	a5,8(a5)
    80005600:	000780e7          	jalr	a5
    80005604:	fe1ff06f          	j	800055e4 <_Z20Threads_CPP_API_testv+0x164>
    80005608:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    8000560c:	00048513          	mv	a0,s1
    80005610:	ffffe097          	auipc	ra,0xffffe
    80005614:	b94080e7          	jalr	-1132(ra) # 800031a4 <_ZdlPv>
    80005618:	00090513          	mv	a0,s2
    8000561c:	0000c097          	auipc	ra,0xc
    80005620:	cdc080e7          	jalr	-804(ra) # 800112f8 <_Unwind_Resume>
    80005624:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80005628:	00048513          	mv	a0,s1
    8000562c:	ffffe097          	auipc	ra,0xffffe
    80005630:	b78080e7          	jalr	-1160(ra) # 800031a4 <_ZdlPv>
    80005634:	00090513          	mv	a0,s2
    80005638:	0000c097          	auipc	ra,0xc
    8000563c:	cc0080e7          	jalr	-832(ra) # 800112f8 <_Unwind_Resume>
    80005640:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80005644:	00048513          	mv	a0,s1
    80005648:	ffffe097          	auipc	ra,0xffffe
    8000564c:	b5c080e7          	jalr	-1188(ra) # 800031a4 <_ZdlPv>
    80005650:	00090513          	mv	a0,s2
    80005654:	0000c097          	auipc	ra,0xc
    80005658:	ca4080e7          	jalr	-860(ra) # 800112f8 <_Unwind_Resume>
    8000565c:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80005660:	00048513          	mv	a0,s1
    80005664:	ffffe097          	auipc	ra,0xffffe
    80005668:	b40080e7          	jalr	-1216(ra) # 800031a4 <_ZdlPv>
    8000566c:	00090513          	mv	a0,s2
    80005670:	0000c097          	auipc	ra,0xc
    80005674:	c88080e7          	jalr	-888(ra) # 800112f8 <_Unwind_Resume>
}
    80005678:	03813083          	ld	ra,56(sp)
    8000567c:	03013403          	ld	s0,48(sp)
    80005680:	02813483          	ld	s1,40(sp)
    80005684:	02013903          	ld	s2,32(sp)
    80005688:	04010113          	addi	sp,sp,64
    8000568c:	00008067          	ret

0000000080005690 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005690:	fd010113          	addi	sp,sp,-48
    80005694:	02113423          	sd	ra,40(sp)
    80005698:	02813023          	sd	s0,32(sp)
    8000569c:	00913c23          	sd	s1,24(sp)
    800056a0:	01213823          	sd	s2,16(sp)
    800056a4:	01313423          	sd	s3,8(sp)
    800056a8:	03010413          	addi	s0,sp,48
    800056ac:	00050993          	mv	s3,a0
    800056b0:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800056b4:	00000913          	li	s2,0
    800056b8:	00c0006f          	j	800056c4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800056bc:	ffffe097          	auipc	ra,0xffffe
    800056c0:	d04080e7          	jalr	-764(ra) # 800033c0 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    800056c4:	ffffc097          	auipc	ra,0xffffc
    800056c8:	548080e7          	jalr	1352(ra) # 80001c0c <_Z4getcv>
    800056cc:	0005059b          	sext.w	a1,a0
    800056d0:	01b00793          	li	a5,27
    800056d4:	02f58a63          	beq	a1,a5,80005708 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800056d8:	0084b503          	ld	a0,8(s1)
    800056dc:	fffff097          	auipc	ra,0xfffff
    800056e0:	580080e7          	jalr	1408(ra) # 80004c5c <_ZN9BufferCPP3putEi>
        i++;
    800056e4:	0019071b          	addiw	a4,s2,1
    800056e8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800056ec:	0004a683          	lw	a3,0(s1)
    800056f0:	0026979b          	slliw	a5,a3,0x2
    800056f4:	00d787bb          	addw	a5,a5,a3
    800056f8:	0017979b          	slliw	a5,a5,0x1
    800056fc:	02f767bb          	remw	a5,a4,a5
    80005700:	fc0792e3          	bnez	a5,800056c4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80005704:	fb9ff06f          	j	800056bc <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80005708:	00100793          	li	a5,1
    8000570c:	0000b717          	auipc	a4,0xb
    80005710:	b0f72623          	sw	a5,-1268(a4) # 80010218 <threadEnd>
    td->buffer->put('!');
    80005714:	0109b783          	ld	a5,16(s3)
    80005718:	02100593          	li	a1,33
    8000571c:	0087b503          	ld	a0,8(a5)
    80005720:	fffff097          	auipc	ra,0xfffff
    80005724:	53c080e7          	jalr	1340(ra) # 80004c5c <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80005728:	0104b503          	ld	a0,16(s1)
    8000572c:	ffffe097          	auipc	ra,0xffffe
    80005730:	b84080e7          	jalr	-1148(ra) # 800032b0 <_ZN9Semaphore6signalEv>
}
    80005734:	02813083          	ld	ra,40(sp)
    80005738:	02013403          	ld	s0,32(sp)
    8000573c:	01813483          	ld	s1,24(sp)
    80005740:	01013903          	ld	s2,16(sp)
    80005744:	00813983          	ld	s3,8(sp)
    80005748:	03010113          	addi	sp,sp,48
    8000574c:	00008067          	ret

0000000080005750 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    80005750:	fe010113          	addi	sp,sp,-32
    80005754:	00113c23          	sd	ra,24(sp)
    80005758:	00813823          	sd	s0,16(sp)
    8000575c:	00913423          	sd	s1,8(sp)
    80005760:	01213023          	sd	s2,0(sp)
    80005764:	02010413          	addi	s0,sp,32
    80005768:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000576c:	00000913          	li	s2,0
    80005770:	00c0006f          	j	8000577c <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005774:	ffffe097          	auipc	ra,0xffffe
    80005778:	c4c080e7          	jalr	-948(ra) # 800033c0 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    8000577c:	0000b797          	auipc	a5,0xb
    80005780:	a9c7a783          	lw	a5,-1380(a5) # 80010218 <threadEnd>
    80005784:	02079e63          	bnez	a5,800057c0 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80005788:	0004a583          	lw	a1,0(s1)
    8000578c:	0305859b          	addiw	a1,a1,48
    80005790:	0084b503          	ld	a0,8(s1)
    80005794:	fffff097          	auipc	ra,0xfffff
    80005798:	4c8080e7          	jalr	1224(ra) # 80004c5c <_ZN9BufferCPP3putEi>
        i++;
    8000579c:	0019071b          	addiw	a4,s2,1
    800057a0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800057a4:	0004a683          	lw	a3,0(s1)
    800057a8:	0026979b          	slliw	a5,a3,0x2
    800057ac:	00d787bb          	addw	a5,a5,a3
    800057b0:	0017979b          	slliw	a5,a5,0x1
    800057b4:	02f767bb          	remw	a5,a4,a5
    800057b8:	fc0792e3          	bnez	a5,8000577c <_ZN8Producer8producerEPv+0x2c>
    800057bc:	fb9ff06f          	j	80005774 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    800057c0:	0104b503          	ld	a0,16(s1)
    800057c4:	ffffe097          	auipc	ra,0xffffe
    800057c8:	aec080e7          	jalr	-1300(ra) # 800032b0 <_ZN9Semaphore6signalEv>
}
    800057cc:	01813083          	ld	ra,24(sp)
    800057d0:	01013403          	ld	s0,16(sp)
    800057d4:	00813483          	ld	s1,8(sp)
    800057d8:	00013903          	ld	s2,0(sp)
    800057dc:	02010113          	addi	sp,sp,32
    800057e0:	00008067          	ret

00000000800057e4 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    800057e4:	fd010113          	addi	sp,sp,-48
    800057e8:	02113423          	sd	ra,40(sp)
    800057ec:	02813023          	sd	s0,32(sp)
    800057f0:	00913c23          	sd	s1,24(sp)
    800057f4:	01213823          	sd	s2,16(sp)
    800057f8:	01313423          	sd	s3,8(sp)
    800057fc:	01413023          	sd	s4,0(sp)
    80005800:	03010413          	addi	s0,sp,48
    80005804:	00050993          	mv	s3,a0
    80005808:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000580c:	00000a13          	li	s4,0
    80005810:	01c0006f          	j	8000582c <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80005814:	ffffe097          	auipc	ra,0xffffe
    80005818:	bac080e7          	jalr	-1108(ra) # 800033c0 <_ZN6Thread8dispatchEv>
    8000581c:	0500006f          	j	8000586c <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80005820:	00a00513          	li	a0,10
    80005824:	ffffc097          	auipc	ra,0xffffc
    80005828:	410080e7          	jalr	1040(ra) # 80001c34 <_Z4putcc>
    while (!threadEnd) {
    8000582c:	0000b797          	auipc	a5,0xb
    80005830:	9ec7a783          	lw	a5,-1556(a5) # 80010218 <threadEnd>
    80005834:	06079263          	bnez	a5,80005898 <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80005838:	00893503          	ld	a0,8(s2)
    8000583c:	fffff097          	auipc	ra,0xfffff
    80005840:	4b0080e7          	jalr	1200(ra) # 80004cec <_ZN9BufferCPP3getEv>
        i++;
    80005844:	001a049b          	addiw	s1,s4,1
    80005848:	00048a1b          	sext.w	s4,s1
        putc(key);
    8000584c:	0ff57513          	andi	a0,a0,255
    80005850:	ffffc097          	auipc	ra,0xffffc
    80005854:	3e4080e7          	jalr	996(ra) # 80001c34 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80005858:	00092703          	lw	a4,0(s2)
    8000585c:	0027179b          	slliw	a5,a4,0x2
    80005860:	00e787bb          	addw	a5,a5,a4
    80005864:	02f4e7bb          	remw	a5,s1,a5
    80005868:	fa0786e3          	beqz	a5,80005814 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    8000586c:	05000793          	li	a5,80
    80005870:	02f4e4bb          	remw	s1,s1,a5
    80005874:	fa049ce3          	bnez	s1,8000582c <_ZN8Consumer8consumerEPv+0x48>
    80005878:	fa9ff06f          	j	80005820 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    8000587c:	0109b783          	ld	a5,16(s3)
    80005880:	0087b503          	ld	a0,8(a5)
    80005884:	fffff097          	auipc	ra,0xfffff
    80005888:	468080e7          	jalr	1128(ra) # 80004cec <_ZN9BufferCPP3getEv>
        Console::putc(key);
    8000588c:	0ff57513          	andi	a0,a0,255
    80005890:	ffffe097          	auipc	ra,0xffffe
    80005894:	c1c080e7          	jalr	-996(ra) # 800034ac <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80005898:	0109b783          	ld	a5,16(s3)
    8000589c:	0087b503          	ld	a0,8(a5)
    800058a0:	fffff097          	auipc	ra,0xfffff
    800058a4:	4d8080e7          	jalr	1240(ra) # 80004d78 <_ZN9BufferCPP6getCntEv>
    800058a8:	fca04ae3          	bgtz	a0,8000587c <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    800058ac:	01093503          	ld	a0,16(s2)
    800058b0:	ffffe097          	auipc	ra,0xffffe
    800058b4:	a00080e7          	jalr	-1536(ra) # 800032b0 <_ZN9Semaphore6signalEv>
}
    800058b8:	02813083          	ld	ra,40(sp)
    800058bc:	02013403          	ld	s0,32(sp)
    800058c0:	01813483          	ld	s1,24(sp)
    800058c4:	01013903          	ld	s2,16(sp)
    800058c8:	00813983          	ld	s3,8(sp)
    800058cc:	00013a03          	ld	s4,0(sp)
    800058d0:	03010113          	addi	sp,sp,48
    800058d4:	00008067          	ret

00000000800058d8 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800058d8:	f8010113          	addi	sp,sp,-128
    800058dc:	06113c23          	sd	ra,120(sp)
    800058e0:	06813823          	sd	s0,112(sp)
    800058e4:	06913423          	sd	s1,104(sp)
    800058e8:	07213023          	sd	s2,96(sp)
    800058ec:	05313c23          	sd	s3,88(sp)
    800058f0:	05413823          	sd	s4,80(sp)
    800058f4:	05513423          	sd	s5,72(sp)
    800058f8:	05613023          	sd	s6,64(sp)
    800058fc:	03713c23          	sd	s7,56(sp)
    80005900:	03813823          	sd	s8,48(sp)
    80005904:	03913423          	sd	s9,40(sp)
    80005908:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    8000590c:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80005910:	00004517          	auipc	a0,0x4
    80005914:	bd050513          	addi	a0,a0,-1072 # 800094e0 <CONSOLE_STATUS+0x4d0>
    80005918:	ffffd097          	auipc	ra,0xffffd
    8000591c:	b10080e7          	jalr	-1264(ra) # 80002428 <_Z11printStringPKc>
    getString(input, 30);
    80005920:	01e00593          	li	a1,30
    80005924:	f8040493          	addi	s1,s0,-128
    80005928:	00048513          	mv	a0,s1
    8000592c:	ffffd097          	auipc	ra,0xffffd
    80005930:	b78080e7          	jalr	-1160(ra) # 800024a4 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005934:	00048513          	mv	a0,s1
    80005938:	ffffd097          	auipc	ra,0xffffd
    8000593c:	c38080e7          	jalr	-968(ra) # 80002570 <_Z11stringToIntPKc>
    80005940:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80005944:	00004517          	auipc	a0,0x4
    80005948:	bbc50513          	addi	a0,a0,-1092 # 80009500 <CONSOLE_STATUS+0x4f0>
    8000594c:	ffffd097          	auipc	ra,0xffffd
    80005950:	adc080e7          	jalr	-1316(ra) # 80002428 <_Z11printStringPKc>
    getString(input, 30);
    80005954:	01e00593          	li	a1,30
    80005958:	00048513          	mv	a0,s1
    8000595c:	ffffd097          	auipc	ra,0xffffd
    80005960:	b48080e7          	jalr	-1208(ra) # 800024a4 <_Z9getStringPci>
    n = stringToInt(input);
    80005964:	00048513          	mv	a0,s1
    80005968:	ffffd097          	auipc	ra,0xffffd
    8000596c:	c08080e7          	jalr	-1016(ra) # 80002570 <_Z11stringToIntPKc>
    80005970:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005974:	00004517          	auipc	a0,0x4
    80005978:	bac50513          	addi	a0,a0,-1108 # 80009520 <CONSOLE_STATUS+0x510>
    8000597c:	ffffd097          	auipc	ra,0xffffd
    80005980:	aac080e7          	jalr	-1364(ra) # 80002428 <_Z11printStringPKc>
    80005984:	00000613          	li	a2,0
    80005988:	00a00593          	li	a1,10
    8000598c:	00090513          	mv	a0,s2
    80005990:	ffffd097          	auipc	ra,0xffffd
    80005994:	c30080e7          	jalr	-976(ra) # 800025c0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005998:	00004517          	auipc	a0,0x4
    8000599c:	ba050513          	addi	a0,a0,-1120 # 80009538 <CONSOLE_STATUS+0x528>
    800059a0:	ffffd097          	auipc	ra,0xffffd
    800059a4:	a88080e7          	jalr	-1400(ra) # 80002428 <_Z11printStringPKc>
    800059a8:	00000613          	li	a2,0
    800059ac:	00a00593          	li	a1,10
    800059b0:	00048513          	mv	a0,s1
    800059b4:	ffffd097          	auipc	ra,0xffffd
    800059b8:	c0c080e7          	jalr	-1012(ra) # 800025c0 <_Z8printIntiii>
    printString(".\n");
    800059bc:	00004517          	auipc	a0,0x4
    800059c0:	84c50513          	addi	a0,a0,-1972 # 80009208 <CONSOLE_STATUS+0x1f8>
    800059c4:	ffffd097          	auipc	ra,0xffffd
    800059c8:	a64080e7          	jalr	-1436(ra) # 80002428 <_Z11printStringPKc>
    if(threadNum > n) {
    800059cc:	0324c463          	blt	s1,s2,800059f4 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    800059d0:	03205c63          	blez	s2,80005a08 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800059d4:	03800513          	li	a0,56
    800059d8:	ffffd097          	auipc	ra,0xffffd
    800059dc:	77c080e7          	jalr	1916(ra) # 80003154 <_Znwm>
    800059e0:	00050a93          	mv	s5,a0
    800059e4:	00048593          	mv	a1,s1
    800059e8:	fffff097          	auipc	ra,0xfffff
    800059ec:	120080e7          	jalr	288(ra) # 80004b08 <_ZN9BufferCPPC1Ei>
    800059f0:	0300006f          	j	80005a20 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800059f4:	00004517          	auipc	a0,0x4
    800059f8:	b5c50513          	addi	a0,a0,-1188 # 80009550 <CONSOLE_STATUS+0x540>
    800059fc:	ffffd097          	auipc	ra,0xffffd
    80005a00:	a2c080e7          	jalr	-1492(ra) # 80002428 <_Z11printStringPKc>
        return;
    80005a04:	0140006f          	j	80005a18 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005a08:	00004517          	auipc	a0,0x4
    80005a0c:	b8850513          	addi	a0,a0,-1144 # 80009590 <CONSOLE_STATUS+0x580>
    80005a10:	ffffd097          	auipc	ra,0xffffd
    80005a14:	a18080e7          	jalr	-1512(ra) # 80002428 <_Z11printStringPKc>
        return;
    80005a18:	000b8113          	mv	sp,s7
    80005a1c:	2400006f          	j	80005c5c <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    80005a20:	01000513          	li	a0,16
    80005a24:	ffffd097          	auipc	ra,0xffffd
    80005a28:	730080e7          	jalr	1840(ra) # 80003154 <_Znwm>
    80005a2c:	00050493          	mv	s1,a0
    80005a30:	00000593          	li	a1,0
    80005a34:	ffffe097          	auipc	ra,0xffffe
    80005a38:	818080e7          	jalr	-2024(ra) # 8000324c <_ZN9SemaphoreC1Ej>
    80005a3c:	0000a717          	auipc	a4,0xa
    80005a40:	7cc70713          	addi	a4,a4,1996 # 80010208 <_ZN19ConsumerProducerCPP9threadEndE>
    80005a44:	00973c23          	sd	s1,24(a4)
    Thread* threads[threadNum];
    80005a48:	00391793          	slli	a5,s2,0x3
    80005a4c:	00f78793          	addi	a5,a5,15
    80005a50:	ff07f793          	andi	a5,a5,-16
    80005a54:	40f10133          	sub	sp,sp,a5
    80005a58:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80005a5c:	0019069b          	addiw	a3,s2,1
    80005a60:	00169793          	slli	a5,a3,0x1
    80005a64:	00d787b3          	add	a5,a5,a3
    80005a68:	00379793          	slli	a5,a5,0x3
    80005a6c:	00f78793          	addi	a5,a5,15
    80005a70:	ff07f793          	andi	a5,a5,-16
    80005a74:	40f10133          	sub	sp,sp,a5
    80005a78:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80005a7c:	00191493          	slli	s1,s2,0x1
    80005a80:	012487b3          	add	a5,s1,s2
    80005a84:	00379793          	slli	a5,a5,0x3
    80005a88:	00fa07b3          	add	a5,s4,a5
    80005a8c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005a90:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005a94:	01873703          	ld	a4,24(a4)
    80005a98:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    80005a9c:	01800513          	li	a0,24
    80005aa0:	ffffd097          	auipc	ra,0xffffd
    80005aa4:	6b4080e7          	jalr	1716(ra) # 80003154 <_Znwm>
    80005aa8:	00050b13          	mv	s6,a0
    80005aac:	012484b3          	add	s1,s1,s2
    80005ab0:	00349493          	slli	s1,s1,0x3
    80005ab4:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    80005ab8:	ffffe097          	auipc	ra,0xffffe
    80005abc:	85c080e7          	jalr	-1956(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005ac0:	00006797          	auipc	a5,0x6
    80005ac4:	39078793          	addi	a5,a5,912 # 8000be50 <_ZTV8Consumer+0x10>
    80005ac8:	00fb3023          	sd	a5,0(s6)
    80005acc:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    80005ad0:	000b0513          	mv	a0,s6
    80005ad4:	ffffe097          	auipc	ra,0xffffe
    80005ad8:	914080e7          	jalr	-1772(ra) # 800033e8 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005adc:	00000493          	li	s1,0
    80005ae0:	0380006f          	j	80005b18 <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005ae4:	00006797          	auipc	a5,0x6
    80005ae8:	34478793          	addi	a5,a5,836 # 8000be28 <_ZTV8Producer+0x10>
    80005aec:	00fcb023          	sd	a5,0(s9)
    80005af0:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    80005af4:	00349793          	slli	a5,s1,0x3
    80005af8:	00f987b3          	add	a5,s3,a5
    80005afc:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80005b00:	00349793          	slli	a5,s1,0x3
    80005b04:	00f987b3          	add	a5,s3,a5
    80005b08:	0007b503          	ld	a0,0(a5)
    80005b0c:	ffffe097          	auipc	ra,0xffffe
    80005b10:	8dc080e7          	jalr	-1828(ra) # 800033e8 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005b14:	0014849b          	addiw	s1,s1,1
    80005b18:	0b24d063          	bge	s1,s2,80005bb8 <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    80005b1c:	00149793          	slli	a5,s1,0x1
    80005b20:	009787b3          	add	a5,a5,s1
    80005b24:	00379793          	slli	a5,a5,0x3
    80005b28:	00fa07b3          	add	a5,s4,a5
    80005b2c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80005b30:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80005b34:	0000a717          	auipc	a4,0xa
    80005b38:	6ec73703          	ld	a4,1772(a4) # 80010220 <waitForAll>
    80005b3c:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80005b40:	02905863          	blez	s1,80005b70 <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    80005b44:	01800513          	li	a0,24
    80005b48:	ffffd097          	auipc	ra,0xffffd
    80005b4c:	60c080e7          	jalr	1548(ra) # 80003154 <_Znwm>
    80005b50:	00050c93          	mv	s9,a0
    80005b54:	00149c13          	slli	s8,s1,0x1
    80005b58:	009c0c33          	add	s8,s8,s1
    80005b5c:	003c1c13          	slli	s8,s8,0x3
    80005b60:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005b64:	ffffd097          	auipc	ra,0xffffd
    80005b68:	7b0080e7          	jalr	1968(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005b6c:	f79ff06f          	j	80005ae4 <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    80005b70:	01800513          	li	a0,24
    80005b74:	ffffd097          	auipc	ra,0xffffd
    80005b78:	5e0080e7          	jalr	1504(ra) # 80003154 <_Znwm>
    80005b7c:	00050c93          	mv	s9,a0
    80005b80:	00149c13          	slli	s8,s1,0x1
    80005b84:	009c0c33          	add	s8,s8,s1
    80005b88:	003c1c13          	slli	s8,s8,0x3
    80005b8c:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005b90:	ffffd097          	auipc	ra,0xffffd
    80005b94:	784080e7          	jalr	1924(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005b98:	00006797          	auipc	a5,0x6
    80005b9c:	26878793          	addi	a5,a5,616 # 8000be00 <_ZTV16ProducerKeyboard+0x10>
    80005ba0:	00fcb023          	sd	a5,0(s9)
    80005ba4:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005ba8:	00349793          	slli	a5,s1,0x3
    80005bac:	00f987b3          	add	a5,s3,a5
    80005bb0:	0197b023          	sd	s9,0(a5)
    80005bb4:	f4dff06f          	j	80005b00 <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    80005bb8:	ffffe097          	auipc	ra,0xffffe
    80005bbc:	808080e7          	jalr	-2040(ra) # 800033c0 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005bc0:	00000493          	li	s1,0
    80005bc4:	00994e63          	blt	s2,s1,80005be0 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    80005bc8:	0000a517          	auipc	a0,0xa
    80005bcc:	65853503          	ld	a0,1624(a0) # 80010220 <waitForAll>
    80005bd0:	ffffd097          	auipc	ra,0xffffd
    80005bd4:	6b4080e7          	jalr	1716(ra) # 80003284 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80005bd8:	0014849b          	addiw	s1,s1,1
    80005bdc:	fe9ff06f          	j	80005bc4 <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    80005be0:	00000493          	li	s1,0
    80005be4:	0080006f          	j	80005bec <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    80005be8:	0014849b          	addiw	s1,s1,1
    80005bec:	0324d263          	bge	s1,s2,80005c10 <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    80005bf0:	00349793          	slli	a5,s1,0x3
    80005bf4:	00f987b3          	add	a5,s3,a5
    80005bf8:	0007b503          	ld	a0,0(a5)
    80005bfc:	fe0506e3          	beqz	a0,80005be8 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    80005c00:	00053783          	ld	a5,0(a0)
    80005c04:	0087b783          	ld	a5,8(a5)
    80005c08:	000780e7          	jalr	a5
    80005c0c:	fddff06f          	j	80005be8 <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    80005c10:	000b0a63          	beqz	s6,80005c24 <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    80005c14:	000b3783          	ld	a5,0(s6)
    80005c18:	0087b783          	ld	a5,8(a5)
    80005c1c:	000b0513          	mv	a0,s6
    80005c20:	000780e7          	jalr	a5
    delete waitForAll;
    80005c24:	0000a517          	auipc	a0,0xa
    80005c28:	5fc53503          	ld	a0,1532(a0) # 80010220 <waitForAll>
    80005c2c:	00050863          	beqz	a0,80005c3c <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    80005c30:	00053783          	ld	a5,0(a0)
    80005c34:	0087b783          	ld	a5,8(a5)
    80005c38:	000780e7          	jalr	a5
    delete buffer;
    80005c3c:	000a8e63          	beqz	s5,80005c58 <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    80005c40:	000a8513          	mv	a0,s5
    80005c44:	fffff097          	auipc	ra,0xfffff
    80005c48:	1bc080e7          	jalr	444(ra) # 80004e00 <_ZN9BufferCPPD1Ev>
    80005c4c:	000a8513          	mv	a0,s5
    80005c50:	ffffd097          	auipc	ra,0xffffd
    80005c54:	554080e7          	jalr	1364(ra) # 800031a4 <_ZdlPv>
    80005c58:	000b8113          	mv	sp,s7

}
    80005c5c:	f8040113          	addi	sp,s0,-128
    80005c60:	07813083          	ld	ra,120(sp)
    80005c64:	07013403          	ld	s0,112(sp)
    80005c68:	06813483          	ld	s1,104(sp)
    80005c6c:	06013903          	ld	s2,96(sp)
    80005c70:	05813983          	ld	s3,88(sp)
    80005c74:	05013a03          	ld	s4,80(sp)
    80005c78:	04813a83          	ld	s5,72(sp)
    80005c7c:	04013b03          	ld	s6,64(sp)
    80005c80:	03813b83          	ld	s7,56(sp)
    80005c84:	03013c03          	ld	s8,48(sp)
    80005c88:	02813c83          	ld	s9,40(sp)
    80005c8c:	08010113          	addi	sp,sp,128
    80005c90:	00008067          	ret
    80005c94:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005c98:	000a8513          	mv	a0,s5
    80005c9c:	ffffd097          	auipc	ra,0xffffd
    80005ca0:	508080e7          	jalr	1288(ra) # 800031a4 <_ZdlPv>
    80005ca4:	00048513          	mv	a0,s1
    80005ca8:	0000b097          	auipc	ra,0xb
    80005cac:	650080e7          	jalr	1616(ra) # 800112f8 <_Unwind_Resume>
    80005cb0:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80005cb4:	00048513          	mv	a0,s1
    80005cb8:	ffffd097          	auipc	ra,0xffffd
    80005cbc:	4ec080e7          	jalr	1260(ra) # 800031a4 <_ZdlPv>
    80005cc0:	00090513          	mv	a0,s2
    80005cc4:	0000b097          	auipc	ra,0xb
    80005cc8:	634080e7          	jalr	1588(ra) # 800112f8 <_Unwind_Resume>
    80005ccc:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    80005cd0:	000b0513          	mv	a0,s6
    80005cd4:	ffffd097          	auipc	ra,0xffffd
    80005cd8:	4d0080e7          	jalr	1232(ra) # 800031a4 <_ZdlPv>
    80005cdc:	00048513          	mv	a0,s1
    80005ce0:	0000b097          	auipc	ra,0xb
    80005ce4:	618080e7          	jalr	1560(ra) # 800112f8 <_Unwind_Resume>
    80005ce8:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    80005cec:	000c8513          	mv	a0,s9
    80005cf0:	ffffd097          	auipc	ra,0xffffd
    80005cf4:	4b4080e7          	jalr	1204(ra) # 800031a4 <_ZdlPv>
    80005cf8:	00048513          	mv	a0,s1
    80005cfc:	0000b097          	auipc	ra,0xb
    80005d00:	5fc080e7          	jalr	1532(ra) # 800112f8 <_Unwind_Resume>
    80005d04:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80005d08:	000c8513          	mv	a0,s9
    80005d0c:	ffffd097          	auipc	ra,0xffffd
    80005d10:	498080e7          	jalr	1176(ra) # 800031a4 <_ZdlPv>
    80005d14:	00048513          	mv	a0,s1
    80005d18:	0000b097          	auipc	ra,0xb
    80005d1c:	5e0080e7          	jalr	1504(ra) # 800112f8 <_Unwind_Resume>

0000000080005d20 <_Z12testSleepingv>:

void testSleeping() {
    80005d20:	fc010113          	addi	sp,sp,-64
    80005d24:	02113c23          	sd	ra,56(sp)
    80005d28:	02813823          	sd	s0,48(sp)
    80005d2c:	02913423          	sd	s1,40(sp)
    80005d30:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005d34:	00a00793          	li	a5,10
    80005d38:	fcf43823          	sd	a5,-48(s0)
    80005d3c:	01400793          	li	a5,20
    80005d40:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005d44:	00000493          	li	s1,0
    80005d48:	02c0006f          	j	80005d74 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    80005d4c:	00349793          	slli	a5,s1,0x3
    80005d50:	fd040613          	addi	a2,s0,-48
    80005d54:	00f60633          	add	a2,a2,a5
    80005d58:	fffff597          	auipc	a1,0xfffff
    80005d5c:	1a858593          	addi	a1,a1,424 # 80004f00 <_Z9sleepyRunPv>
    80005d60:	fc040513          	addi	a0,s0,-64
    80005d64:	00f50533          	add	a0,a0,a5
    80005d68:	ffffc097          	auipc	ra,0xffffc
    80005d6c:	c50080e7          	jalr	-944(ra) # 800019b8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    80005d70:	0014849b          	addiw	s1,s1,1
    80005d74:	00100793          	li	a5,1
    80005d78:	fc97dae3          	bge	a5,s1,80005d4c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80005d7c:	0000a797          	auipc	a5,0xa
    80005d80:	4947c783          	lbu	a5,1172(a5) # 80010210 <finished>
    80005d84:	fe078ce3          	beqz	a5,80005d7c <_Z12testSleepingv+0x5c>
    80005d88:	0000a797          	auipc	a5,0xa
    80005d8c:	4897c783          	lbu	a5,1161(a5) # 80010211 <finished+0x1>
    80005d90:	fe0786e3          	beqz	a5,80005d7c <_Z12testSleepingv+0x5c>
}
    80005d94:	03813083          	ld	ra,56(sp)
    80005d98:	03013403          	ld	s0,48(sp)
    80005d9c:	02813483          	ld	s1,40(sp)
    80005da0:	04010113          	addi	sp,sp,64
    80005da4:	00008067          	ret

0000000080005da8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    80005da8:	f8010113          	addi	sp,sp,-128
    80005dac:	06113c23          	sd	ra,120(sp)
    80005db0:	06813823          	sd	s0,112(sp)
    80005db4:	06913423          	sd	s1,104(sp)
    80005db8:	07213023          	sd	s2,96(sp)
    80005dbc:	05313c23          	sd	s3,88(sp)
    80005dc0:	05413823          	sd	s4,80(sp)
    80005dc4:	05513423          	sd	s5,72(sp)
    80005dc8:	05613023          	sd	s6,64(sp)
    80005dcc:	03713c23          	sd	s7,56(sp)
    80005dd0:	03813823          	sd	s8,48(sp)
    80005dd4:	03913423          	sd	s9,40(sp)
    80005dd8:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80005ddc:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    80005de0:	00003517          	auipc	a0,0x3
    80005de4:	70050513          	addi	a0,a0,1792 # 800094e0 <CONSOLE_STATUS+0x4d0>
    80005de8:	ffffc097          	auipc	ra,0xffffc
    80005dec:	640080e7          	jalr	1600(ra) # 80002428 <_Z11printStringPKc>
        getString(input, 30);
    80005df0:	01e00593          	li	a1,30
    80005df4:	f8040493          	addi	s1,s0,-128
    80005df8:	00048513          	mv	a0,s1
    80005dfc:	ffffc097          	auipc	ra,0xffffc
    80005e00:	6a8080e7          	jalr	1704(ra) # 800024a4 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80005e04:	00048513          	mv	a0,s1
    80005e08:	ffffc097          	auipc	ra,0xffffc
    80005e0c:	768080e7          	jalr	1896(ra) # 80002570 <_Z11stringToIntPKc>
    80005e10:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    80005e14:	00003517          	auipc	a0,0x3
    80005e18:	6ec50513          	addi	a0,a0,1772 # 80009500 <CONSOLE_STATUS+0x4f0>
    80005e1c:	ffffc097          	auipc	ra,0xffffc
    80005e20:	60c080e7          	jalr	1548(ra) # 80002428 <_Z11printStringPKc>
        getString(input, 30);
    80005e24:	01e00593          	li	a1,30
    80005e28:	00048513          	mv	a0,s1
    80005e2c:	ffffc097          	auipc	ra,0xffffc
    80005e30:	678080e7          	jalr	1656(ra) # 800024a4 <_Z9getStringPci>
        n = stringToInt(input);
    80005e34:	00048513          	mv	a0,s1
    80005e38:	ffffc097          	auipc	ra,0xffffc
    80005e3c:	738080e7          	jalr	1848(ra) # 80002570 <_Z11stringToIntPKc>
    80005e40:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80005e44:	00003517          	auipc	a0,0x3
    80005e48:	6dc50513          	addi	a0,a0,1756 # 80009520 <CONSOLE_STATUS+0x510>
    80005e4c:	ffffc097          	auipc	ra,0xffffc
    80005e50:	5dc080e7          	jalr	1500(ra) # 80002428 <_Z11printStringPKc>
    80005e54:	00000613          	li	a2,0
    80005e58:	00a00593          	li	a1,10
    80005e5c:	00098513          	mv	a0,s3
    80005e60:	ffffc097          	auipc	ra,0xffffc
    80005e64:	760080e7          	jalr	1888(ra) # 800025c0 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    80005e68:	00003517          	auipc	a0,0x3
    80005e6c:	6d050513          	addi	a0,a0,1744 # 80009538 <CONSOLE_STATUS+0x528>
    80005e70:	ffffc097          	auipc	ra,0xffffc
    80005e74:	5b8080e7          	jalr	1464(ra) # 80002428 <_Z11printStringPKc>
    80005e78:	00000613          	li	a2,0
    80005e7c:	00a00593          	li	a1,10
    80005e80:	00048513          	mv	a0,s1
    80005e84:	ffffc097          	auipc	ra,0xffffc
    80005e88:	73c080e7          	jalr	1852(ra) # 800025c0 <_Z8printIntiii>
        printString(".\n");
    80005e8c:	00003517          	auipc	a0,0x3
    80005e90:	37c50513          	addi	a0,a0,892 # 80009208 <CONSOLE_STATUS+0x1f8>
    80005e94:	ffffc097          	auipc	ra,0xffffc
    80005e98:	594080e7          	jalr	1428(ra) # 80002428 <_Z11printStringPKc>
        if(threadNum > n) {
    80005e9c:	0334c463          	blt	s1,s3,80005ec4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    80005ea0:	03305c63          	blez	s3,80005ed8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    80005ea4:	03800513          	li	a0,56
    80005ea8:	ffffd097          	auipc	ra,0xffffd
    80005eac:	2ac080e7          	jalr	684(ra) # 80003154 <_Znwm>
    80005eb0:	00050a93          	mv	s5,a0
    80005eb4:	00048593          	mv	a1,s1
    80005eb8:	fffff097          	auipc	ra,0xfffff
    80005ebc:	c50080e7          	jalr	-944(ra) # 80004b08 <_ZN9BufferCPPC1Ei>
    80005ec0:	0300006f          	j	80005ef0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005ec4:	00003517          	auipc	a0,0x3
    80005ec8:	68c50513          	addi	a0,a0,1676 # 80009550 <CONSOLE_STATUS+0x540>
    80005ecc:	ffffc097          	auipc	ra,0xffffc
    80005ed0:	55c080e7          	jalr	1372(ra) # 80002428 <_Z11printStringPKc>
            return;
    80005ed4:	0140006f          	j	80005ee8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005ed8:	00003517          	auipc	a0,0x3
    80005edc:	6b850513          	addi	a0,a0,1720 # 80009590 <CONSOLE_STATUS+0x580>
    80005ee0:	ffffc097          	auipc	ra,0xffffc
    80005ee4:	548080e7          	jalr	1352(ra) # 80002428 <_Z11printStringPKc>
            return;
    80005ee8:	000c0113          	mv	sp,s8
    80005eec:	21c0006f          	j	80006108 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    80005ef0:	01000513          	li	a0,16
    80005ef4:	ffffd097          	auipc	ra,0xffffd
    80005ef8:	260080e7          	jalr	608(ra) # 80003154 <_Znwm>
    80005efc:	00050493          	mv	s1,a0
    80005f00:	00000593          	li	a1,0
    80005f04:	ffffd097          	auipc	ra,0xffffd
    80005f08:	348080e7          	jalr	840(ra) # 8000324c <_ZN9SemaphoreC1Ej>
    80005f0c:	0000a717          	auipc	a4,0xa
    80005f10:	2fc70713          	addi	a4,a4,764 # 80010208 <_ZN19ConsumerProducerCPP9threadEndE>
    80005f14:	02973023          	sd	s1,32(a4)
        Thread *producers[threadNum];
    80005f18:	00399793          	slli	a5,s3,0x3
    80005f1c:	00f78793          	addi	a5,a5,15
    80005f20:	ff07f793          	andi	a5,a5,-16
    80005f24:	40f10133          	sub	sp,sp,a5
    80005f28:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80005f2c:	0019869b          	addiw	a3,s3,1
    80005f30:	00169793          	slli	a5,a3,0x1
    80005f34:	00d787b3          	add	a5,a5,a3
    80005f38:	00379793          	slli	a5,a5,0x3
    80005f3c:	00f78793          	addi	a5,a5,15
    80005f40:	ff07f793          	andi	a5,a5,-16
    80005f44:	40f10133          	sub	sp,sp,a5
    80005f48:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    80005f4c:	00199493          	slli	s1,s3,0x1
    80005f50:	013484b3          	add	s1,s1,s3
    80005f54:	00349493          	slli	s1,s1,0x3
    80005f58:	009b04b3          	add	s1,s6,s1
    80005f5c:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    80005f60:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    80005f64:	02073783          	ld	a5,32(a4)
    80005f68:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80005f6c:	01800513          	li	a0,24
    80005f70:	ffffd097          	auipc	ra,0xffffd
    80005f74:	1e4080e7          	jalr	484(ra) # 80003154 <_Znwm>
    80005f78:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    80005f7c:	ffffd097          	auipc	ra,0xffffd
    80005f80:	398080e7          	jalr	920(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005f84:	00006797          	auipc	a5,0x6
    80005f88:	f4478793          	addi	a5,a5,-188 # 8000bec8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80005f8c:	00fbb023          	sd	a5,0(s7)
    80005f90:	009bb823          	sd	s1,16(s7)
        consumer->start();
    80005f94:	000b8513          	mv	a0,s7
    80005f98:	ffffd097          	auipc	ra,0xffffd
    80005f9c:	450080e7          	jalr	1104(ra) # 800033e8 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80005fa0:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    80005fa4:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    80005fa8:	0000a797          	auipc	a5,0xa
    80005fac:	2807b783          	ld	a5,640(a5) # 80010228 <_ZN19ConsumerProducerCPP10waitForAllE>
    80005fb0:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005fb4:	01800513          	li	a0,24
    80005fb8:	ffffd097          	auipc	ra,0xffffd
    80005fbc:	19c080e7          	jalr	412(ra) # 80003154 <_Znwm>
    80005fc0:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80005fc4:	ffffd097          	auipc	ra,0xffffd
    80005fc8:	350080e7          	jalr	848(ra) # 80003314 <_ZN6ThreadC1Ev>
    80005fcc:	00006797          	auipc	a5,0x6
    80005fd0:	eac78793          	addi	a5,a5,-340 # 8000be78 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80005fd4:	00f4b023          	sd	a5,0(s1)
    80005fd8:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80005fdc:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80005fe0:	00048513          	mv	a0,s1
    80005fe4:	ffffd097          	auipc	ra,0xffffd
    80005fe8:	404080e7          	jalr	1028(ra) # 800033e8 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80005fec:	00100913          	li	s2,1
    80005ff0:	0300006f          	j	80006020 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80005ff4:	00006797          	auipc	a5,0x6
    80005ff8:	eac78793          	addi	a5,a5,-340 # 8000bea0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80005ffc:	00fcb023          	sd	a5,0(s9)
    80006000:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80006004:	00391793          	slli	a5,s2,0x3
    80006008:	00fa07b3          	add	a5,s4,a5
    8000600c:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80006010:	000c8513          	mv	a0,s9
    80006014:	ffffd097          	auipc	ra,0xffffd
    80006018:	3d4080e7          	jalr	980(ra) # 800033e8 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    8000601c:	0019091b          	addiw	s2,s2,1
    80006020:	05395263          	bge	s2,s3,80006064 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80006024:	00191493          	slli	s1,s2,0x1
    80006028:	012484b3          	add	s1,s1,s2
    8000602c:	00349493          	slli	s1,s1,0x3
    80006030:	009b04b3          	add	s1,s6,s1
    80006034:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    80006038:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    8000603c:	0000a797          	auipc	a5,0xa
    80006040:	1ec7b783          	ld	a5,492(a5) # 80010228 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006044:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    80006048:	01800513          	li	a0,24
    8000604c:	ffffd097          	auipc	ra,0xffffd
    80006050:	108080e7          	jalr	264(ra) # 80003154 <_Znwm>
    80006054:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006058:	ffffd097          	auipc	ra,0xffffd
    8000605c:	2bc080e7          	jalr	700(ra) # 80003314 <_ZN6ThreadC1Ev>
    80006060:	f95ff06f          	j	80005ff4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    80006064:	ffffd097          	auipc	ra,0xffffd
    80006068:	35c080e7          	jalr	860(ra) # 800033c0 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    8000606c:	00000493          	li	s1,0
    80006070:	0099ce63          	blt	s3,s1,8000608c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    80006074:	0000a517          	auipc	a0,0xa
    80006078:	1b453503          	ld	a0,436(a0) # 80010228 <_ZN19ConsumerProducerCPP10waitForAllE>
    8000607c:	ffffd097          	auipc	ra,0xffffd
    80006080:	208080e7          	jalr	520(ra) # 80003284 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    80006084:	0014849b          	addiw	s1,s1,1
    80006088:	fe9ff06f          	j	80006070 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    8000608c:	0000a517          	auipc	a0,0xa
    80006090:	19c53503          	ld	a0,412(a0) # 80010228 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006094:	00050863          	beqz	a0,800060a4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    80006098:	00053783          	ld	a5,0(a0)
    8000609c:	0087b783          	ld	a5,8(a5)
    800060a0:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    800060a4:	00000493          	li	s1,0
    800060a8:	0080006f          	j	800060b0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    800060ac:	0014849b          	addiw	s1,s1,1
    800060b0:	0334d263          	bge	s1,s3,800060d4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    800060b4:	00349793          	slli	a5,s1,0x3
    800060b8:	00fa07b3          	add	a5,s4,a5
    800060bc:	0007b503          	ld	a0,0(a5)
    800060c0:	fe0506e3          	beqz	a0,800060ac <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    800060c4:	00053783          	ld	a5,0(a0)
    800060c8:	0087b783          	ld	a5,8(a5)
    800060cc:	000780e7          	jalr	a5
    800060d0:	fddff06f          	j	800060ac <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    800060d4:	000b8a63          	beqz	s7,800060e8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    800060d8:	000bb783          	ld	a5,0(s7)
    800060dc:	0087b783          	ld	a5,8(a5)
    800060e0:	000b8513          	mv	a0,s7
    800060e4:	000780e7          	jalr	a5
        delete buffer;
    800060e8:	000a8e63          	beqz	s5,80006104 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    800060ec:	000a8513          	mv	a0,s5
    800060f0:	fffff097          	auipc	ra,0xfffff
    800060f4:	d10080e7          	jalr	-752(ra) # 80004e00 <_ZN9BufferCPPD1Ev>
    800060f8:	000a8513          	mv	a0,s5
    800060fc:	ffffd097          	auipc	ra,0xffffd
    80006100:	0a8080e7          	jalr	168(ra) # 800031a4 <_ZdlPv>
    80006104:	000c0113          	mv	sp,s8
    }
    80006108:	f8040113          	addi	sp,s0,-128
    8000610c:	07813083          	ld	ra,120(sp)
    80006110:	07013403          	ld	s0,112(sp)
    80006114:	06813483          	ld	s1,104(sp)
    80006118:	06013903          	ld	s2,96(sp)
    8000611c:	05813983          	ld	s3,88(sp)
    80006120:	05013a03          	ld	s4,80(sp)
    80006124:	04813a83          	ld	s5,72(sp)
    80006128:	04013b03          	ld	s6,64(sp)
    8000612c:	03813b83          	ld	s7,56(sp)
    80006130:	03013c03          	ld	s8,48(sp)
    80006134:	02813c83          	ld	s9,40(sp)
    80006138:	08010113          	addi	sp,sp,128
    8000613c:	00008067          	ret
    80006140:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80006144:	000a8513          	mv	a0,s5
    80006148:	ffffd097          	auipc	ra,0xffffd
    8000614c:	05c080e7          	jalr	92(ra) # 800031a4 <_ZdlPv>
    80006150:	00048513          	mv	a0,s1
    80006154:	0000b097          	auipc	ra,0xb
    80006158:	1a4080e7          	jalr	420(ra) # 800112f8 <_Unwind_Resume>
    8000615c:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    80006160:	00048513          	mv	a0,s1
    80006164:	ffffd097          	auipc	ra,0xffffd
    80006168:	040080e7          	jalr	64(ra) # 800031a4 <_ZdlPv>
    8000616c:	00090513          	mv	a0,s2
    80006170:	0000b097          	auipc	ra,0xb
    80006174:	188080e7          	jalr	392(ra) # 800112f8 <_Unwind_Resume>
    80006178:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000617c:	000b8513          	mv	a0,s7
    80006180:	ffffd097          	auipc	ra,0xffffd
    80006184:	024080e7          	jalr	36(ra) # 800031a4 <_ZdlPv>
    80006188:	00048513          	mv	a0,s1
    8000618c:	0000b097          	auipc	ra,0xb
    80006190:	16c080e7          	jalr	364(ra) # 800112f8 <_Unwind_Resume>
    80006194:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006198:	00048513          	mv	a0,s1
    8000619c:	ffffd097          	auipc	ra,0xffffd
    800061a0:	008080e7          	jalr	8(ra) # 800031a4 <_ZdlPv>
    800061a4:	00090513          	mv	a0,s2
    800061a8:	0000b097          	auipc	ra,0xb
    800061ac:	150080e7          	jalr	336(ra) # 800112f8 <_Unwind_Resume>
    800061b0:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    800061b4:	000c8513          	mv	a0,s9
    800061b8:	ffffd097          	auipc	ra,0xffffd
    800061bc:	fec080e7          	jalr	-20(ra) # 800031a4 <_ZdlPv>
    800061c0:	00048513          	mv	a0,s1
    800061c4:	0000b097          	auipc	ra,0xb
    800061c8:	134080e7          	jalr	308(ra) # 800112f8 <_Unwind_Resume>

00000000800061cc <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    800061cc:	ff010113          	addi	sp,sp,-16
    800061d0:	00813423          	sd	s0,8(sp)
    800061d4:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    800061d8:	00813403          	ld	s0,8(sp)
    800061dc:	01010113          	addi	sp,sp,16
    800061e0:	00008067          	ret

00000000800061e4 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800061e4:	ff010113          	addi	sp,sp,-16
    800061e8:	00113423          	sd	ra,8(sp)
    800061ec:	00813023          	sd	s0,0(sp)
    800061f0:	01010413          	addi	s0,sp,16
    800061f4:	00006797          	auipc	a5,0x6
    800061f8:	b6c78793          	addi	a5,a5,-1172 # 8000bd60 <_ZTV7WorkerA+0x10>
    800061fc:	00f53023          	sd	a5,0(a0)
    80006200:	ffffd097          	auipc	ra,0xffffd
    80006204:	f14080e7          	jalr	-236(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006208:	00813083          	ld	ra,8(sp)
    8000620c:	00013403          	ld	s0,0(sp)
    80006210:	01010113          	addi	sp,sp,16
    80006214:	00008067          	ret

0000000080006218 <_ZN7WorkerAD0Ev>:
    80006218:	fe010113          	addi	sp,sp,-32
    8000621c:	00113c23          	sd	ra,24(sp)
    80006220:	00813823          	sd	s0,16(sp)
    80006224:	00913423          	sd	s1,8(sp)
    80006228:	02010413          	addi	s0,sp,32
    8000622c:	00050493          	mv	s1,a0
    80006230:	00006797          	auipc	a5,0x6
    80006234:	b3078793          	addi	a5,a5,-1232 # 8000bd60 <_ZTV7WorkerA+0x10>
    80006238:	00f53023          	sd	a5,0(a0)
    8000623c:	ffffd097          	auipc	ra,0xffffd
    80006240:	ed8080e7          	jalr	-296(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006244:	00048513          	mv	a0,s1
    80006248:	ffffd097          	auipc	ra,0xffffd
    8000624c:	f5c080e7          	jalr	-164(ra) # 800031a4 <_ZdlPv>
    80006250:	01813083          	ld	ra,24(sp)
    80006254:	01013403          	ld	s0,16(sp)
    80006258:	00813483          	ld	s1,8(sp)
    8000625c:	02010113          	addi	sp,sp,32
    80006260:	00008067          	ret

0000000080006264 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80006264:	ff010113          	addi	sp,sp,-16
    80006268:	00113423          	sd	ra,8(sp)
    8000626c:	00813023          	sd	s0,0(sp)
    80006270:	01010413          	addi	s0,sp,16
    80006274:	00006797          	auipc	a5,0x6
    80006278:	b1478793          	addi	a5,a5,-1260 # 8000bd88 <_ZTV7WorkerB+0x10>
    8000627c:	00f53023          	sd	a5,0(a0)
    80006280:	ffffd097          	auipc	ra,0xffffd
    80006284:	e94080e7          	jalr	-364(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006288:	00813083          	ld	ra,8(sp)
    8000628c:	00013403          	ld	s0,0(sp)
    80006290:	01010113          	addi	sp,sp,16
    80006294:	00008067          	ret

0000000080006298 <_ZN7WorkerBD0Ev>:
    80006298:	fe010113          	addi	sp,sp,-32
    8000629c:	00113c23          	sd	ra,24(sp)
    800062a0:	00813823          	sd	s0,16(sp)
    800062a4:	00913423          	sd	s1,8(sp)
    800062a8:	02010413          	addi	s0,sp,32
    800062ac:	00050493          	mv	s1,a0
    800062b0:	00006797          	auipc	a5,0x6
    800062b4:	ad878793          	addi	a5,a5,-1320 # 8000bd88 <_ZTV7WorkerB+0x10>
    800062b8:	00f53023          	sd	a5,0(a0)
    800062bc:	ffffd097          	auipc	ra,0xffffd
    800062c0:	e58080e7          	jalr	-424(ra) # 80003114 <_ZN6ThreadD1Ev>
    800062c4:	00048513          	mv	a0,s1
    800062c8:	ffffd097          	auipc	ra,0xffffd
    800062cc:	edc080e7          	jalr	-292(ra) # 800031a4 <_ZdlPv>
    800062d0:	01813083          	ld	ra,24(sp)
    800062d4:	01013403          	ld	s0,16(sp)
    800062d8:	00813483          	ld	s1,8(sp)
    800062dc:	02010113          	addi	sp,sp,32
    800062e0:	00008067          	ret

00000000800062e4 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800062e4:	ff010113          	addi	sp,sp,-16
    800062e8:	00113423          	sd	ra,8(sp)
    800062ec:	00813023          	sd	s0,0(sp)
    800062f0:	01010413          	addi	s0,sp,16
    800062f4:	00006797          	auipc	a5,0x6
    800062f8:	abc78793          	addi	a5,a5,-1348 # 8000bdb0 <_ZTV7WorkerC+0x10>
    800062fc:	00f53023          	sd	a5,0(a0)
    80006300:	ffffd097          	auipc	ra,0xffffd
    80006304:	e14080e7          	jalr	-492(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006308:	00813083          	ld	ra,8(sp)
    8000630c:	00013403          	ld	s0,0(sp)
    80006310:	01010113          	addi	sp,sp,16
    80006314:	00008067          	ret

0000000080006318 <_ZN7WorkerCD0Ev>:
    80006318:	fe010113          	addi	sp,sp,-32
    8000631c:	00113c23          	sd	ra,24(sp)
    80006320:	00813823          	sd	s0,16(sp)
    80006324:	00913423          	sd	s1,8(sp)
    80006328:	02010413          	addi	s0,sp,32
    8000632c:	00050493          	mv	s1,a0
    80006330:	00006797          	auipc	a5,0x6
    80006334:	a8078793          	addi	a5,a5,-1408 # 8000bdb0 <_ZTV7WorkerC+0x10>
    80006338:	00f53023          	sd	a5,0(a0)
    8000633c:	ffffd097          	auipc	ra,0xffffd
    80006340:	dd8080e7          	jalr	-552(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006344:	00048513          	mv	a0,s1
    80006348:	ffffd097          	auipc	ra,0xffffd
    8000634c:	e5c080e7          	jalr	-420(ra) # 800031a4 <_ZdlPv>
    80006350:	01813083          	ld	ra,24(sp)
    80006354:	01013403          	ld	s0,16(sp)
    80006358:	00813483          	ld	s1,8(sp)
    8000635c:	02010113          	addi	sp,sp,32
    80006360:	00008067          	ret

0000000080006364 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80006364:	ff010113          	addi	sp,sp,-16
    80006368:	00113423          	sd	ra,8(sp)
    8000636c:	00813023          	sd	s0,0(sp)
    80006370:	01010413          	addi	s0,sp,16
    80006374:	00006797          	auipc	a5,0x6
    80006378:	a6478793          	addi	a5,a5,-1436 # 8000bdd8 <_ZTV7WorkerD+0x10>
    8000637c:	00f53023          	sd	a5,0(a0)
    80006380:	ffffd097          	auipc	ra,0xffffd
    80006384:	d94080e7          	jalr	-620(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006388:	00813083          	ld	ra,8(sp)
    8000638c:	00013403          	ld	s0,0(sp)
    80006390:	01010113          	addi	sp,sp,16
    80006394:	00008067          	ret

0000000080006398 <_ZN7WorkerDD0Ev>:
    80006398:	fe010113          	addi	sp,sp,-32
    8000639c:	00113c23          	sd	ra,24(sp)
    800063a0:	00813823          	sd	s0,16(sp)
    800063a4:	00913423          	sd	s1,8(sp)
    800063a8:	02010413          	addi	s0,sp,32
    800063ac:	00050493          	mv	s1,a0
    800063b0:	00006797          	auipc	a5,0x6
    800063b4:	a2878793          	addi	a5,a5,-1496 # 8000bdd8 <_ZTV7WorkerD+0x10>
    800063b8:	00f53023          	sd	a5,0(a0)
    800063bc:	ffffd097          	auipc	ra,0xffffd
    800063c0:	d58080e7          	jalr	-680(ra) # 80003114 <_ZN6ThreadD1Ev>
    800063c4:	00048513          	mv	a0,s1
    800063c8:	ffffd097          	auipc	ra,0xffffd
    800063cc:	ddc080e7          	jalr	-548(ra) # 800031a4 <_ZdlPv>
    800063d0:	01813083          	ld	ra,24(sp)
    800063d4:	01013403          	ld	s0,16(sp)
    800063d8:	00813483          	ld	s1,8(sp)
    800063dc:	02010113          	addi	sp,sp,32
    800063e0:	00008067          	ret

00000000800063e4 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    800063e4:	ff010113          	addi	sp,sp,-16
    800063e8:	00113423          	sd	ra,8(sp)
    800063ec:	00813023          	sd	s0,0(sp)
    800063f0:	01010413          	addi	s0,sp,16
    800063f4:	00006797          	auipc	a5,0x6
    800063f8:	a5c78793          	addi	a5,a5,-1444 # 8000be50 <_ZTV8Consumer+0x10>
    800063fc:	00f53023          	sd	a5,0(a0)
    80006400:	ffffd097          	auipc	ra,0xffffd
    80006404:	d14080e7          	jalr	-748(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006408:	00813083          	ld	ra,8(sp)
    8000640c:	00013403          	ld	s0,0(sp)
    80006410:	01010113          	addi	sp,sp,16
    80006414:	00008067          	ret

0000000080006418 <_ZN8ConsumerD0Ev>:
    80006418:	fe010113          	addi	sp,sp,-32
    8000641c:	00113c23          	sd	ra,24(sp)
    80006420:	00813823          	sd	s0,16(sp)
    80006424:	00913423          	sd	s1,8(sp)
    80006428:	02010413          	addi	s0,sp,32
    8000642c:	00050493          	mv	s1,a0
    80006430:	00006797          	auipc	a5,0x6
    80006434:	a2078793          	addi	a5,a5,-1504 # 8000be50 <_ZTV8Consumer+0x10>
    80006438:	00f53023          	sd	a5,0(a0)
    8000643c:	ffffd097          	auipc	ra,0xffffd
    80006440:	cd8080e7          	jalr	-808(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006444:	00048513          	mv	a0,s1
    80006448:	ffffd097          	auipc	ra,0xffffd
    8000644c:	d5c080e7          	jalr	-676(ra) # 800031a4 <_ZdlPv>
    80006450:	01813083          	ld	ra,24(sp)
    80006454:	01013403          	ld	s0,16(sp)
    80006458:	00813483          	ld	s1,8(sp)
    8000645c:	02010113          	addi	sp,sp,32
    80006460:	00008067          	ret

0000000080006464 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    80006464:	ff010113          	addi	sp,sp,-16
    80006468:	00113423          	sd	ra,8(sp)
    8000646c:	00813023          	sd	s0,0(sp)
    80006470:	01010413          	addi	s0,sp,16
    80006474:	00006797          	auipc	a5,0x6
    80006478:	9b478793          	addi	a5,a5,-1612 # 8000be28 <_ZTV8Producer+0x10>
    8000647c:	00f53023          	sd	a5,0(a0)
    80006480:	ffffd097          	auipc	ra,0xffffd
    80006484:	c94080e7          	jalr	-876(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006488:	00813083          	ld	ra,8(sp)
    8000648c:	00013403          	ld	s0,0(sp)
    80006490:	01010113          	addi	sp,sp,16
    80006494:	00008067          	ret

0000000080006498 <_ZN8ProducerD0Ev>:
    80006498:	fe010113          	addi	sp,sp,-32
    8000649c:	00113c23          	sd	ra,24(sp)
    800064a0:	00813823          	sd	s0,16(sp)
    800064a4:	00913423          	sd	s1,8(sp)
    800064a8:	02010413          	addi	s0,sp,32
    800064ac:	00050493          	mv	s1,a0
    800064b0:	00006797          	auipc	a5,0x6
    800064b4:	97878793          	addi	a5,a5,-1672 # 8000be28 <_ZTV8Producer+0x10>
    800064b8:	00f53023          	sd	a5,0(a0)
    800064bc:	ffffd097          	auipc	ra,0xffffd
    800064c0:	c58080e7          	jalr	-936(ra) # 80003114 <_ZN6ThreadD1Ev>
    800064c4:	00048513          	mv	a0,s1
    800064c8:	ffffd097          	auipc	ra,0xffffd
    800064cc:	cdc080e7          	jalr	-804(ra) # 800031a4 <_ZdlPv>
    800064d0:	01813083          	ld	ra,24(sp)
    800064d4:	01013403          	ld	s0,16(sp)
    800064d8:	00813483          	ld	s1,8(sp)
    800064dc:	02010113          	addi	sp,sp,32
    800064e0:	00008067          	ret

00000000800064e4 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800064e4:	ff010113          	addi	sp,sp,-16
    800064e8:	00113423          	sd	ra,8(sp)
    800064ec:	00813023          	sd	s0,0(sp)
    800064f0:	01010413          	addi	s0,sp,16
    800064f4:	00006797          	auipc	a5,0x6
    800064f8:	90c78793          	addi	a5,a5,-1780 # 8000be00 <_ZTV16ProducerKeyboard+0x10>
    800064fc:	00f53023          	sd	a5,0(a0)
    80006500:	ffffd097          	auipc	ra,0xffffd
    80006504:	c14080e7          	jalr	-1004(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006508:	00813083          	ld	ra,8(sp)
    8000650c:	00013403          	ld	s0,0(sp)
    80006510:	01010113          	addi	sp,sp,16
    80006514:	00008067          	ret

0000000080006518 <_ZN16ProducerKeyboardD0Ev>:
    80006518:	fe010113          	addi	sp,sp,-32
    8000651c:	00113c23          	sd	ra,24(sp)
    80006520:	00813823          	sd	s0,16(sp)
    80006524:	00913423          	sd	s1,8(sp)
    80006528:	02010413          	addi	s0,sp,32
    8000652c:	00050493          	mv	s1,a0
    80006530:	00006797          	auipc	a5,0x6
    80006534:	8d078793          	addi	a5,a5,-1840 # 8000be00 <_ZTV16ProducerKeyboard+0x10>
    80006538:	00f53023          	sd	a5,0(a0)
    8000653c:	ffffd097          	auipc	ra,0xffffd
    80006540:	bd8080e7          	jalr	-1064(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006544:	00048513          	mv	a0,s1
    80006548:	ffffd097          	auipc	ra,0xffffd
    8000654c:	c5c080e7          	jalr	-932(ra) # 800031a4 <_ZdlPv>
    80006550:	01813083          	ld	ra,24(sp)
    80006554:	01013403          	ld	s0,16(sp)
    80006558:	00813483          	ld	s1,8(sp)
    8000655c:	02010113          	addi	sp,sp,32
    80006560:	00008067          	ret

0000000080006564 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    80006564:	ff010113          	addi	sp,sp,-16
    80006568:	00113423          	sd	ra,8(sp)
    8000656c:	00813023          	sd	s0,0(sp)
    80006570:	01010413          	addi	s0,sp,16
    80006574:	00006797          	auipc	a5,0x6
    80006578:	95478793          	addi	a5,a5,-1708 # 8000bec8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000657c:	00f53023          	sd	a5,0(a0)
    80006580:	ffffd097          	auipc	ra,0xffffd
    80006584:	b94080e7          	jalr	-1132(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006588:	00813083          	ld	ra,8(sp)
    8000658c:	00013403          	ld	s0,0(sp)
    80006590:	01010113          	addi	sp,sp,16
    80006594:	00008067          	ret

0000000080006598 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80006598:	fe010113          	addi	sp,sp,-32
    8000659c:	00113c23          	sd	ra,24(sp)
    800065a0:	00813823          	sd	s0,16(sp)
    800065a4:	00913423          	sd	s1,8(sp)
    800065a8:	02010413          	addi	s0,sp,32
    800065ac:	00050493          	mv	s1,a0
    800065b0:	00006797          	auipc	a5,0x6
    800065b4:	91878793          	addi	a5,a5,-1768 # 8000bec8 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800065b8:	00f53023          	sd	a5,0(a0)
    800065bc:	ffffd097          	auipc	ra,0xffffd
    800065c0:	b58080e7          	jalr	-1192(ra) # 80003114 <_ZN6ThreadD1Ev>
    800065c4:	00048513          	mv	a0,s1
    800065c8:	ffffd097          	auipc	ra,0xffffd
    800065cc:	bdc080e7          	jalr	-1060(ra) # 800031a4 <_ZdlPv>
    800065d0:	01813083          	ld	ra,24(sp)
    800065d4:	01013403          	ld	s0,16(sp)
    800065d8:	00813483          	ld	s1,8(sp)
    800065dc:	02010113          	addi	sp,sp,32
    800065e0:	00008067          	ret

00000000800065e4 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    800065e4:	ff010113          	addi	sp,sp,-16
    800065e8:	00113423          	sd	ra,8(sp)
    800065ec:	00813023          	sd	s0,0(sp)
    800065f0:	01010413          	addi	s0,sp,16
    800065f4:	00006797          	auipc	a5,0x6
    800065f8:	88478793          	addi	a5,a5,-1916 # 8000be78 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800065fc:	00f53023          	sd	a5,0(a0)
    80006600:	ffffd097          	auipc	ra,0xffffd
    80006604:	b14080e7          	jalr	-1260(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006608:	00813083          	ld	ra,8(sp)
    8000660c:	00013403          	ld	s0,0(sp)
    80006610:	01010113          	addi	sp,sp,16
    80006614:	00008067          	ret

0000000080006618 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80006618:	fe010113          	addi	sp,sp,-32
    8000661c:	00113c23          	sd	ra,24(sp)
    80006620:	00813823          	sd	s0,16(sp)
    80006624:	00913423          	sd	s1,8(sp)
    80006628:	02010413          	addi	s0,sp,32
    8000662c:	00050493          	mv	s1,a0
    80006630:	00006797          	auipc	a5,0x6
    80006634:	84878793          	addi	a5,a5,-1976 # 8000be78 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006638:	00f53023          	sd	a5,0(a0)
    8000663c:	ffffd097          	auipc	ra,0xffffd
    80006640:	ad8080e7          	jalr	-1320(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006644:	00048513          	mv	a0,s1
    80006648:	ffffd097          	auipc	ra,0xffffd
    8000664c:	b5c080e7          	jalr	-1188(ra) # 800031a4 <_ZdlPv>
    80006650:	01813083          	ld	ra,24(sp)
    80006654:	01013403          	ld	s0,16(sp)
    80006658:	00813483          	ld	s1,8(sp)
    8000665c:	02010113          	addi	sp,sp,32
    80006660:	00008067          	ret

0000000080006664 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006664:	ff010113          	addi	sp,sp,-16
    80006668:	00113423          	sd	ra,8(sp)
    8000666c:	00813023          	sd	s0,0(sp)
    80006670:	01010413          	addi	s0,sp,16
    80006674:	00006797          	auipc	a5,0x6
    80006678:	82c78793          	addi	a5,a5,-2004 # 8000bea0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    8000667c:	00f53023          	sd	a5,0(a0)
    80006680:	ffffd097          	auipc	ra,0xffffd
    80006684:	a94080e7          	jalr	-1388(ra) # 80003114 <_ZN6ThreadD1Ev>
    80006688:	00813083          	ld	ra,8(sp)
    8000668c:	00013403          	ld	s0,0(sp)
    80006690:	01010113          	addi	sp,sp,16
    80006694:	00008067          	ret

0000000080006698 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80006698:	fe010113          	addi	sp,sp,-32
    8000669c:	00113c23          	sd	ra,24(sp)
    800066a0:	00813823          	sd	s0,16(sp)
    800066a4:	00913423          	sd	s1,8(sp)
    800066a8:	02010413          	addi	s0,sp,32
    800066ac:	00050493          	mv	s1,a0
    800066b0:	00005797          	auipc	a5,0x5
    800066b4:	7f078793          	addi	a5,a5,2032 # 8000bea0 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800066b8:	00f53023          	sd	a5,0(a0)
    800066bc:	ffffd097          	auipc	ra,0xffffd
    800066c0:	a58080e7          	jalr	-1448(ra) # 80003114 <_ZN6ThreadD1Ev>
    800066c4:	00048513          	mv	a0,s1
    800066c8:	ffffd097          	auipc	ra,0xffffd
    800066cc:	adc080e7          	jalr	-1316(ra) # 800031a4 <_ZdlPv>
    800066d0:	01813083          	ld	ra,24(sp)
    800066d4:	01013403          	ld	s0,16(sp)
    800066d8:	00813483          	ld	s1,8(sp)
    800066dc:	02010113          	addi	sp,sp,32
    800066e0:	00008067          	ret

00000000800066e4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    800066e4:	fe010113          	addi	sp,sp,-32
    800066e8:	00113c23          	sd	ra,24(sp)
    800066ec:	00813823          	sd	s0,16(sp)
    800066f0:	00913423          	sd	s1,8(sp)
    800066f4:	02010413          	addi	s0,sp,32
    800066f8:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    800066fc:	ffffb097          	auipc	ra,0xffffb
    80006700:	510080e7          	jalr	1296(ra) # 80001c0c <_Z4getcv>
    80006704:	0005059b          	sext.w	a1,a0
    80006708:	01b00793          	li	a5,27
    8000670c:	00f58c63          	beq	a1,a5,80006724 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80006710:	0104b783          	ld	a5,16(s1)
    80006714:	0087b503          	ld	a0,8(a5)
    80006718:	ffffe097          	auipc	ra,0xffffe
    8000671c:	544080e7          	jalr	1348(ra) # 80004c5c <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80006720:	fddff06f          	j	800066fc <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80006724:	00100793          	li	a5,1
    80006728:	0000a717          	auipc	a4,0xa
    8000672c:	aef72023          	sw	a5,-1312(a4) # 80010208 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80006730:	0104b783          	ld	a5,16(s1)
    80006734:	02100593          	li	a1,33
    80006738:	0087b503          	ld	a0,8(a5)
    8000673c:	ffffe097          	auipc	ra,0xffffe
    80006740:	520080e7          	jalr	1312(ra) # 80004c5c <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80006744:	0104b783          	ld	a5,16(s1)
    80006748:	0107b503          	ld	a0,16(a5)
    8000674c:	ffffd097          	auipc	ra,0xffffd
    80006750:	b64080e7          	jalr	-1180(ra) # 800032b0 <_ZN9Semaphore6signalEv>
        }
    80006754:	01813083          	ld	ra,24(sp)
    80006758:	01013403          	ld	s0,16(sp)
    8000675c:	00813483          	ld	s1,8(sp)
    80006760:	02010113          	addi	sp,sp,32
    80006764:	00008067          	ret

0000000080006768 <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80006768:	fd010113          	addi	sp,sp,-48
    8000676c:	02113423          	sd	ra,40(sp)
    80006770:	02813023          	sd	s0,32(sp)
    80006774:	00913c23          	sd	s1,24(sp)
    80006778:	01213823          	sd	s2,16(sp)
    8000677c:	01313423          	sd	s3,8(sp)
    80006780:	03010413          	addi	s0,sp,48
    80006784:	00050913          	mv	s2,a0
            int i = 0;
    80006788:	00000993          	li	s3,0
    8000678c:	0100006f          	j	8000679c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80006790:	00a00513          	li	a0,10
    80006794:	ffffd097          	auipc	ra,0xffffd
    80006798:	d18080e7          	jalr	-744(ra) # 800034ac <_ZN7Console4putcEc>
            while (!threadEnd) {
    8000679c:	0000a797          	auipc	a5,0xa
    800067a0:	a6c7a783          	lw	a5,-1428(a5) # 80010208 <_ZN19ConsumerProducerCPP9threadEndE>
    800067a4:	04079a63          	bnez	a5,800067f8 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    800067a8:	01093783          	ld	a5,16(s2)
    800067ac:	0087b503          	ld	a0,8(a5)
    800067b0:	ffffe097          	auipc	ra,0xffffe
    800067b4:	53c080e7          	jalr	1340(ra) # 80004cec <_ZN9BufferCPP3getEv>
                i++;
    800067b8:	0019849b          	addiw	s1,s3,1
    800067bc:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    800067c0:	0ff57513          	andi	a0,a0,255
    800067c4:	ffffd097          	auipc	ra,0xffffd
    800067c8:	ce8080e7          	jalr	-792(ra) # 800034ac <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    800067cc:	05000793          	li	a5,80
    800067d0:	02f4e4bb          	remw	s1,s1,a5
    800067d4:	fc0494e3          	bnez	s1,8000679c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800067d8:	fb9ff06f          	j	80006790 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    800067dc:	01093783          	ld	a5,16(s2)
    800067e0:	0087b503          	ld	a0,8(a5)
    800067e4:	ffffe097          	auipc	ra,0xffffe
    800067e8:	508080e7          	jalr	1288(ra) # 80004cec <_ZN9BufferCPP3getEv>
                Console::putc(key);
    800067ec:	0ff57513          	andi	a0,a0,255
    800067f0:	ffffd097          	auipc	ra,0xffffd
    800067f4:	cbc080e7          	jalr	-836(ra) # 800034ac <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    800067f8:	01093783          	ld	a5,16(s2)
    800067fc:	0087b503          	ld	a0,8(a5)
    80006800:	ffffe097          	auipc	ra,0xffffe
    80006804:	578080e7          	jalr	1400(ra) # 80004d78 <_ZN9BufferCPP6getCntEv>
    80006808:	fca04ae3          	bgtz	a0,800067dc <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    8000680c:	01093783          	ld	a5,16(s2)
    80006810:	0107b503          	ld	a0,16(a5)
    80006814:	ffffd097          	auipc	ra,0xffffd
    80006818:	a9c080e7          	jalr	-1380(ra) # 800032b0 <_ZN9Semaphore6signalEv>
        }
    8000681c:	02813083          	ld	ra,40(sp)
    80006820:	02013403          	ld	s0,32(sp)
    80006824:	01813483          	ld	s1,24(sp)
    80006828:	01013903          	ld	s2,16(sp)
    8000682c:	00813983          	ld	s3,8(sp)
    80006830:	03010113          	addi	sp,sp,48
    80006834:	00008067          	ret

0000000080006838 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006838:	fe010113          	addi	sp,sp,-32
    8000683c:	00113c23          	sd	ra,24(sp)
    80006840:	00813823          	sd	s0,16(sp)
    80006844:	00913423          	sd	s1,8(sp)
    80006848:	01213023          	sd	s2,0(sp)
    8000684c:	02010413          	addi	s0,sp,32
    80006850:	00050493          	mv	s1,a0
            int i = 0;
    80006854:	00000913          	li	s2,0
            while (!threadEnd) {
    80006858:	0000a797          	auipc	a5,0xa
    8000685c:	9b07a783          	lw	a5,-1616(a5) # 80010208 <_ZN19ConsumerProducerCPP9threadEndE>
    80006860:	04079263          	bnez	a5,800068a4 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80006864:	0104b783          	ld	a5,16(s1)
    80006868:	0007a583          	lw	a1,0(a5)
    8000686c:	0305859b          	addiw	a1,a1,48
    80006870:	0087b503          	ld	a0,8(a5)
    80006874:	ffffe097          	auipc	ra,0xffffe
    80006878:	3e8080e7          	jalr	1000(ra) # 80004c5c <_ZN9BufferCPP3putEi>
                i++;
    8000687c:	0019071b          	addiw	a4,s2,1
    80006880:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80006884:	0104b783          	ld	a5,16(s1)
    80006888:	0007a783          	lw	a5,0(a5)
    8000688c:	00e787bb          	addw	a5,a5,a4
    80006890:	00500513          	li	a0,5
    80006894:	02a7e53b          	remw	a0,a5,a0
    80006898:	ffffd097          	auipc	ra,0xffffd
    8000689c:	ac0080e7          	jalr	-1344(ra) # 80003358 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    800068a0:	fb9ff06f          	j	80006858 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    800068a4:	0104b783          	ld	a5,16(s1)
    800068a8:	0107b503          	ld	a0,16(a5)
    800068ac:	ffffd097          	auipc	ra,0xffffd
    800068b0:	a04080e7          	jalr	-1532(ra) # 800032b0 <_ZN9Semaphore6signalEv>
        }
    800068b4:	01813083          	ld	ra,24(sp)
    800068b8:	01013403          	ld	s0,16(sp)
    800068bc:	00813483          	ld	s1,8(sp)
    800068c0:	00013903          	ld	s2,0(sp)
    800068c4:	02010113          	addi	sp,sp,32
    800068c8:	00008067          	ret

00000000800068cc <_ZN7WorkerA3runEv>:
    void run() override {
    800068cc:	ff010113          	addi	sp,sp,-16
    800068d0:	00113423          	sd	ra,8(sp)
    800068d4:	00813023          	sd	s0,0(sp)
    800068d8:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    800068dc:	00000593          	li	a1,0
    800068e0:	ffffe097          	auipc	ra,0xffffe
    800068e4:	738080e7          	jalr	1848(ra) # 80005018 <_ZN7WorkerA11workerBodyAEPv>
    }
    800068e8:	00813083          	ld	ra,8(sp)
    800068ec:	00013403          	ld	s0,0(sp)
    800068f0:	01010113          	addi	sp,sp,16
    800068f4:	00008067          	ret

00000000800068f8 <_ZN7WorkerB3runEv>:
    void run() override {
    800068f8:	ff010113          	addi	sp,sp,-16
    800068fc:	00113423          	sd	ra,8(sp)
    80006900:	00813023          	sd	s0,0(sp)
    80006904:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80006908:	00000593          	li	a1,0
    8000690c:	ffffe097          	auipc	ra,0xffffe
    80006910:	7d8080e7          	jalr	2008(ra) # 800050e4 <_ZN7WorkerB11workerBodyBEPv>
    }
    80006914:	00813083          	ld	ra,8(sp)
    80006918:	00013403          	ld	s0,0(sp)
    8000691c:	01010113          	addi	sp,sp,16
    80006920:	00008067          	ret

0000000080006924 <_ZN7WorkerC3runEv>:
    void run() override {
    80006924:	ff010113          	addi	sp,sp,-16
    80006928:	00113423          	sd	ra,8(sp)
    8000692c:	00813023          	sd	s0,0(sp)
    80006930:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80006934:	00000593          	li	a1,0
    80006938:	fffff097          	auipc	ra,0xfffff
    8000693c:	880080e7          	jalr	-1920(ra) # 800051b8 <_ZN7WorkerC11workerBodyCEPv>
    }
    80006940:	00813083          	ld	ra,8(sp)
    80006944:	00013403          	ld	s0,0(sp)
    80006948:	01010113          	addi	sp,sp,16
    8000694c:	00008067          	ret

0000000080006950 <_ZN7WorkerD3runEv>:
    void run() override {
    80006950:	ff010113          	addi	sp,sp,-16
    80006954:	00113423          	sd	ra,8(sp)
    80006958:	00813023          	sd	s0,0(sp)
    8000695c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80006960:	00000593          	li	a1,0
    80006964:	fffff097          	auipc	ra,0xfffff
    80006968:	9d4080e7          	jalr	-1580(ra) # 80005338 <_ZN7WorkerD11workerBodyDEPv>
    }
    8000696c:	00813083          	ld	ra,8(sp)
    80006970:	00013403          	ld	s0,0(sp)
    80006974:	01010113          	addi	sp,sp,16
    80006978:	00008067          	ret

000000008000697c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    8000697c:	ff010113          	addi	sp,sp,-16
    80006980:	00113423          	sd	ra,8(sp)
    80006984:	00813023          	sd	s0,0(sp)
    80006988:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    8000698c:	01053583          	ld	a1,16(a0)
    80006990:	fffff097          	auipc	ra,0xfffff
    80006994:	d00080e7          	jalr	-768(ra) # 80005690 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006998:	00813083          	ld	ra,8(sp)
    8000699c:	00013403          	ld	s0,0(sp)
    800069a0:	01010113          	addi	sp,sp,16
    800069a4:	00008067          	ret

00000000800069a8 <_ZN8Producer3runEv>:
    void run() override {
    800069a8:	ff010113          	addi	sp,sp,-16
    800069ac:	00113423          	sd	ra,8(sp)
    800069b0:	00813023          	sd	s0,0(sp)
    800069b4:	01010413          	addi	s0,sp,16
        producer(td);
    800069b8:	01053583          	ld	a1,16(a0)
    800069bc:	fffff097          	auipc	ra,0xfffff
    800069c0:	d94080e7          	jalr	-620(ra) # 80005750 <_ZN8Producer8producerEPv>
    }
    800069c4:	00813083          	ld	ra,8(sp)
    800069c8:	00013403          	ld	s0,0(sp)
    800069cc:	01010113          	addi	sp,sp,16
    800069d0:	00008067          	ret

00000000800069d4 <_ZN8Consumer3runEv>:
    void run() override {
    800069d4:	ff010113          	addi	sp,sp,-16
    800069d8:	00113423          	sd	ra,8(sp)
    800069dc:	00813023          	sd	s0,0(sp)
    800069e0:	01010413          	addi	s0,sp,16
        consumer(td);
    800069e4:	01053583          	ld	a1,16(a0)
    800069e8:	fffff097          	auipc	ra,0xfffff
    800069ec:	dfc080e7          	jalr	-516(ra) # 800057e4 <_ZN8Consumer8consumerEPv>
    }
    800069f0:	00813083          	ld	ra,8(sp)
    800069f4:	00013403          	ld	s0,0(sp)
    800069f8:	01010113          	addi	sp,sp,16
    800069fc:	00008067          	ret

0000000080006a00 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006a00:	fe010113          	addi	sp,sp,-32
    80006a04:	00113c23          	sd	ra,24(sp)
    80006a08:	00813823          	sd	s0,16(sp)
    80006a0c:	00913423          	sd	s1,8(sp)
    80006a10:	01213023          	sd	s2,0(sp)
    80006a14:	02010413          	addi	s0,sp,32
    80006a18:	00050493          	mv	s1,a0
    80006a1c:	00058913          	mv	s2,a1
    80006a20:	0015879b          	addiw	a5,a1,1
    80006a24:	0007851b          	sext.w	a0,a5
    80006a28:	00f4a023          	sw	a5,0(s1)
    80006a2c:	0004a823          	sw	zero,16(s1)
    80006a30:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006a34:	00251513          	slli	a0,a0,0x2
    80006a38:	ffffb097          	auipc	ra,0xffffb
    80006a3c:	f24080e7          	jalr	-220(ra) # 8000195c <_Z9mem_allocm>
    80006a40:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006a44:	00000593          	li	a1,0
    80006a48:	02048513          	addi	a0,s1,32
    80006a4c:	ffffb097          	auipc	ra,0xffffb
    80006a50:	0d8080e7          	jalr	216(ra) # 80001b24 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006a54:	00090593          	mv	a1,s2
    80006a58:	01848513          	addi	a0,s1,24
    80006a5c:	ffffb097          	auipc	ra,0xffffb
    80006a60:	0c8080e7          	jalr	200(ra) # 80001b24 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006a64:	00100593          	li	a1,1
    80006a68:	02848513          	addi	a0,s1,40
    80006a6c:	ffffb097          	auipc	ra,0xffffb
    80006a70:	0b8080e7          	jalr	184(ra) # 80001b24 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80006a74:	00100593          	li	a1,1
    80006a78:	03048513          	addi	a0,s1,48
    80006a7c:	ffffb097          	auipc	ra,0xffffb
    80006a80:	0a8080e7          	jalr	168(ra) # 80001b24 <_Z8sem_openPP10_semaphorej>
}
    80006a84:	01813083          	ld	ra,24(sp)
    80006a88:	01013403          	ld	s0,16(sp)
    80006a8c:	00813483          	ld	s1,8(sp)
    80006a90:	00013903          	ld	s2,0(sp)
    80006a94:	02010113          	addi	sp,sp,32
    80006a98:	00008067          	ret

0000000080006a9c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006a9c:	fe010113          	addi	sp,sp,-32
    80006aa0:	00113c23          	sd	ra,24(sp)
    80006aa4:	00813823          	sd	s0,16(sp)
    80006aa8:	00913423          	sd	s1,8(sp)
    80006aac:	01213023          	sd	s2,0(sp)
    80006ab0:	02010413          	addi	s0,sp,32
    80006ab4:	00050493          	mv	s1,a0
    80006ab8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006abc:	01853503          	ld	a0,24(a0)
    80006ac0:	ffffb097          	auipc	ra,0xffffb
    80006ac4:	0c8080e7          	jalr	200(ra) # 80001b88 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80006ac8:	0304b503          	ld	a0,48(s1)
    80006acc:	ffffb097          	auipc	ra,0xffffb
    80006ad0:	0bc080e7          	jalr	188(ra) # 80001b88 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80006ad4:	0084b783          	ld	a5,8(s1)
    80006ad8:	0144a703          	lw	a4,20(s1)
    80006adc:	00271713          	slli	a4,a4,0x2
    80006ae0:	00e787b3          	add	a5,a5,a4
    80006ae4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006ae8:	0144a783          	lw	a5,20(s1)
    80006aec:	0017879b          	addiw	a5,a5,1
    80006af0:	0004a703          	lw	a4,0(s1)
    80006af4:	02e7e7bb          	remw	a5,a5,a4
    80006af8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006afc:	0304b503          	ld	a0,48(s1)
    80006b00:	ffffb097          	auipc	ra,0xffffb
    80006b04:	0b4080e7          	jalr	180(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80006b08:	0204b503          	ld	a0,32(s1)
    80006b0c:	ffffb097          	auipc	ra,0xffffb
    80006b10:	0a8080e7          	jalr	168(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>

}
    80006b14:	01813083          	ld	ra,24(sp)
    80006b18:	01013403          	ld	s0,16(sp)
    80006b1c:	00813483          	ld	s1,8(sp)
    80006b20:	00013903          	ld	s2,0(sp)
    80006b24:	02010113          	addi	sp,sp,32
    80006b28:	00008067          	ret

0000000080006b2c <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006b2c:	fe010113          	addi	sp,sp,-32
    80006b30:	00113c23          	sd	ra,24(sp)
    80006b34:	00813823          	sd	s0,16(sp)
    80006b38:	00913423          	sd	s1,8(sp)
    80006b3c:	01213023          	sd	s2,0(sp)
    80006b40:	02010413          	addi	s0,sp,32
    80006b44:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006b48:	02053503          	ld	a0,32(a0)
    80006b4c:	ffffb097          	auipc	ra,0xffffb
    80006b50:	03c080e7          	jalr	60(ra) # 80001b88 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006b54:	0284b503          	ld	a0,40(s1)
    80006b58:	ffffb097          	auipc	ra,0xffffb
    80006b5c:	030080e7          	jalr	48(ra) # 80001b88 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006b60:	0084b703          	ld	a4,8(s1)
    80006b64:	0104a783          	lw	a5,16(s1)
    80006b68:	00279693          	slli	a3,a5,0x2
    80006b6c:	00d70733          	add	a4,a4,a3
    80006b70:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006b74:	0017879b          	addiw	a5,a5,1
    80006b78:	0004a703          	lw	a4,0(s1)
    80006b7c:	02e7e7bb          	remw	a5,a5,a4
    80006b80:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006b84:	0284b503          	ld	a0,40(s1)
    80006b88:	ffffb097          	auipc	ra,0xffffb
    80006b8c:	02c080e7          	jalr	44(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006b90:	0184b503          	ld	a0,24(s1)
    80006b94:	ffffb097          	auipc	ra,0xffffb
    80006b98:	020080e7          	jalr	32(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006b9c:	00090513          	mv	a0,s2
    80006ba0:	01813083          	ld	ra,24(sp)
    80006ba4:	01013403          	ld	s0,16(sp)
    80006ba8:	00813483          	ld	s1,8(sp)
    80006bac:	00013903          	ld	s2,0(sp)
    80006bb0:	02010113          	addi	sp,sp,32
    80006bb4:	00008067          	ret

0000000080006bb8 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006bb8:	fe010113          	addi	sp,sp,-32
    80006bbc:	00113c23          	sd	ra,24(sp)
    80006bc0:	00813823          	sd	s0,16(sp)
    80006bc4:	00913423          	sd	s1,8(sp)
    80006bc8:	01213023          	sd	s2,0(sp)
    80006bcc:	02010413          	addi	s0,sp,32
    80006bd0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006bd4:	02853503          	ld	a0,40(a0)
    80006bd8:	ffffb097          	auipc	ra,0xffffb
    80006bdc:	fb0080e7          	jalr	-80(ra) # 80001b88 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80006be0:	0304b503          	ld	a0,48(s1)
    80006be4:	ffffb097          	auipc	ra,0xffffb
    80006be8:	fa4080e7          	jalr	-92(ra) # 80001b88 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80006bec:	0144a783          	lw	a5,20(s1)
    80006bf0:	0104a903          	lw	s2,16(s1)
    80006bf4:	0327ce63          	blt	a5,s2,80006c30 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006bf8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006bfc:	0304b503          	ld	a0,48(s1)
    80006c00:	ffffb097          	auipc	ra,0xffffb
    80006c04:	fb4080e7          	jalr	-76(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    80006c08:	0284b503          	ld	a0,40(s1)
    80006c0c:	ffffb097          	auipc	ra,0xffffb
    80006c10:	fa8080e7          	jalr	-88(ra) # 80001bb4 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006c14:	00090513          	mv	a0,s2
    80006c18:	01813083          	ld	ra,24(sp)
    80006c1c:	01013403          	ld	s0,16(sp)
    80006c20:	00813483          	ld	s1,8(sp)
    80006c24:	00013903          	ld	s2,0(sp)
    80006c28:	02010113          	addi	sp,sp,32
    80006c2c:	00008067          	ret
        ret = cap - head + tail;
    80006c30:	0004a703          	lw	a4,0(s1)
    80006c34:	4127093b          	subw	s2,a4,s2
    80006c38:	00f9093b          	addw	s2,s2,a5
    80006c3c:	fc1ff06f          	j	80006bfc <_ZN6Buffer6getCntEv+0x44>

0000000080006c40 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006c40:	fe010113          	addi	sp,sp,-32
    80006c44:	00113c23          	sd	ra,24(sp)
    80006c48:	00813823          	sd	s0,16(sp)
    80006c4c:	00913423          	sd	s1,8(sp)
    80006c50:	02010413          	addi	s0,sp,32
    80006c54:	00050493          	mv	s1,a0
    putc('\n');
    80006c58:	00a00513          	li	a0,10
    80006c5c:	ffffb097          	auipc	ra,0xffffb
    80006c60:	fd8080e7          	jalr	-40(ra) # 80001c34 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006c64:	00002517          	auipc	a0,0x2
    80006c68:	74c50513          	addi	a0,a0,1868 # 800093b0 <CONSOLE_STATUS+0x3a0>
    80006c6c:	ffffb097          	auipc	ra,0xffffb
    80006c70:	7bc080e7          	jalr	1980(ra) # 80002428 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006c74:	00048513          	mv	a0,s1
    80006c78:	00000097          	auipc	ra,0x0
    80006c7c:	f40080e7          	jalr	-192(ra) # 80006bb8 <_ZN6Buffer6getCntEv>
    80006c80:	02a05c63          	blez	a0,80006cb8 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006c84:	0084b783          	ld	a5,8(s1)
    80006c88:	0104a703          	lw	a4,16(s1)
    80006c8c:	00271713          	slli	a4,a4,0x2
    80006c90:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006c94:	0007c503          	lbu	a0,0(a5)
    80006c98:	ffffb097          	auipc	ra,0xffffb
    80006c9c:	f9c080e7          	jalr	-100(ra) # 80001c34 <_Z4putcc>
        head = (head + 1) % cap;
    80006ca0:	0104a783          	lw	a5,16(s1)
    80006ca4:	0017879b          	addiw	a5,a5,1
    80006ca8:	0004a703          	lw	a4,0(s1)
    80006cac:	02e7e7bb          	remw	a5,a5,a4
    80006cb0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006cb4:	fc1ff06f          	j	80006c74 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006cb8:	02100513          	li	a0,33
    80006cbc:	ffffb097          	auipc	ra,0xffffb
    80006cc0:	f78080e7          	jalr	-136(ra) # 80001c34 <_Z4putcc>
    putc('\n');
    80006cc4:	00a00513          	li	a0,10
    80006cc8:	ffffb097          	auipc	ra,0xffffb
    80006ccc:	f6c080e7          	jalr	-148(ra) # 80001c34 <_Z4putcc>
    mem_free(buffer);
    80006cd0:	0084b503          	ld	a0,8(s1)
    80006cd4:	ffffb097          	auipc	ra,0xffffb
    80006cd8:	cb8080e7          	jalr	-840(ra) # 8000198c <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006cdc:	0204b503          	ld	a0,32(s1)
    80006ce0:	ffffb097          	auipc	ra,0xffffb
    80006ce4:	e7c080e7          	jalr	-388(ra) # 80001b5c <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    80006ce8:	0184b503          	ld	a0,24(s1)
    80006cec:	ffffb097          	auipc	ra,0xffffb
    80006cf0:	e70080e7          	jalr	-400(ra) # 80001b5c <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80006cf4:	0304b503          	ld	a0,48(s1)
    80006cf8:	ffffb097          	auipc	ra,0xffffb
    80006cfc:	e64080e7          	jalr	-412(ra) # 80001b5c <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80006d00:	0284b503          	ld	a0,40(s1)
    80006d04:	ffffb097          	auipc	ra,0xffffb
    80006d08:	e58080e7          	jalr	-424(ra) # 80001b5c <_Z9sem_closeP10_semaphore>
}
    80006d0c:	01813083          	ld	ra,24(sp)
    80006d10:	01013403          	ld	s0,16(sp)
    80006d14:	00813483          	ld	s1,8(sp)
    80006d18:	02010113          	addi	sp,sp,32
    80006d1c:	00008067          	ret

0000000080006d20 <start>:
    80006d20:	ff010113          	addi	sp,sp,-16
    80006d24:	00813423          	sd	s0,8(sp)
    80006d28:	01010413          	addi	s0,sp,16
    80006d2c:	300027f3          	csrr	a5,mstatus
    80006d30:	ffffe737          	lui	a4,0xffffe
    80006d34:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffed36f>
    80006d38:	00e7f7b3          	and	a5,a5,a4
    80006d3c:	00001737          	lui	a4,0x1
    80006d40:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006d44:	00e7e7b3          	or	a5,a5,a4
    80006d48:	30079073          	csrw	mstatus,a5
    80006d4c:	00000797          	auipc	a5,0x0
    80006d50:	16078793          	addi	a5,a5,352 # 80006eac <system_main>
    80006d54:	34179073          	csrw	mepc,a5
    80006d58:	00000793          	li	a5,0
    80006d5c:	18079073          	csrw	satp,a5
    80006d60:	000107b7          	lui	a5,0x10
    80006d64:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006d68:	30279073          	csrw	medeleg,a5
    80006d6c:	30379073          	csrw	mideleg,a5
    80006d70:	104027f3          	csrr	a5,sie
    80006d74:	2227e793          	ori	a5,a5,546
    80006d78:	10479073          	csrw	sie,a5
    80006d7c:	fff00793          	li	a5,-1
    80006d80:	00a7d793          	srli	a5,a5,0xa
    80006d84:	3b079073          	csrw	pmpaddr0,a5
    80006d88:	00f00793          	li	a5,15
    80006d8c:	3a079073          	csrw	pmpcfg0,a5
    80006d90:	f14027f3          	csrr	a5,mhartid
    80006d94:	0200c737          	lui	a4,0x200c
    80006d98:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006d9c:	0007869b          	sext.w	a3,a5
    80006da0:	00269713          	slli	a4,a3,0x2
    80006da4:	000f4637          	lui	a2,0xf4
    80006da8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006dac:	00d70733          	add	a4,a4,a3
    80006db0:	0037979b          	slliw	a5,a5,0x3
    80006db4:	020046b7          	lui	a3,0x2004
    80006db8:	00d787b3          	add	a5,a5,a3
    80006dbc:	00c585b3          	add	a1,a1,a2
    80006dc0:	00371693          	slli	a3,a4,0x3
    80006dc4:	00009717          	auipc	a4,0x9
    80006dc8:	46c70713          	addi	a4,a4,1132 # 80010230 <timer_scratch>
    80006dcc:	00b7b023          	sd	a1,0(a5)
    80006dd0:	00d70733          	add	a4,a4,a3
    80006dd4:	00f73c23          	sd	a5,24(a4)
    80006dd8:	02c73023          	sd	a2,32(a4)
    80006ddc:	34071073          	csrw	mscratch,a4
    80006de0:	00000797          	auipc	a5,0x0
    80006de4:	6e078793          	addi	a5,a5,1760 # 800074c0 <timervec>
    80006de8:	30579073          	csrw	mtvec,a5
    80006dec:	300027f3          	csrr	a5,mstatus
    80006df0:	0087e793          	ori	a5,a5,8
    80006df4:	30079073          	csrw	mstatus,a5
    80006df8:	304027f3          	csrr	a5,mie
    80006dfc:	0807e793          	ori	a5,a5,128
    80006e00:	30479073          	csrw	mie,a5
    80006e04:	f14027f3          	csrr	a5,mhartid
    80006e08:	0007879b          	sext.w	a5,a5
    80006e0c:	00078213          	mv	tp,a5
    80006e10:	30200073          	mret
    80006e14:	00813403          	ld	s0,8(sp)
    80006e18:	01010113          	addi	sp,sp,16
    80006e1c:	00008067          	ret

0000000080006e20 <timerinit>:
    80006e20:	ff010113          	addi	sp,sp,-16
    80006e24:	00813423          	sd	s0,8(sp)
    80006e28:	01010413          	addi	s0,sp,16
    80006e2c:	f14027f3          	csrr	a5,mhartid
    80006e30:	0200c737          	lui	a4,0x200c
    80006e34:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006e38:	0007869b          	sext.w	a3,a5
    80006e3c:	00269713          	slli	a4,a3,0x2
    80006e40:	000f4637          	lui	a2,0xf4
    80006e44:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006e48:	00d70733          	add	a4,a4,a3
    80006e4c:	0037979b          	slliw	a5,a5,0x3
    80006e50:	020046b7          	lui	a3,0x2004
    80006e54:	00d787b3          	add	a5,a5,a3
    80006e58:	00c585b3          	add	a1,a1,a2
    80006e5c:	00371693          	slli	a3,a4,0x3
    80006e60:	00009717          	auipc	a4,0x9
    80006e64:	3d070713          	addi	a4,a4,976 # 80010230 <timer_scratch>
    80006e68:	00b7b023          	sd	a1,0(a5)
    80006e6c:	00d70733          	add	a4,a4,a3
    80006e70:	00f73c23          	sd	a5,24(a4)
    80006e74:	02c73023          	sd	a2,32(a4)
    80006e78:	34071073          	csrw	mscratch,a4
    80006e7c:	00000797          	auipc	a5,0x0
    80006e80:	64478793          	addi	a5,a5,1604 # 800074c0 <timervec>
    80006e84:	30579073          	csrw	mtvec,a5
    80006e88:	300027f3          	csrr	a5,mstatus
    80006e8c:	0087e793          	ori	a5,a5,8
    80006e90:	30079073          	csrw	mstatus,a5
    80006e94:	304027f3          	csrr	a5,mie
    80006e98:	0807e793          	ori	a5,a5,128
    80006e9c:	30479073          	csrw	mie,a5
    80006ea0:	00813403          	ld	s0,8(sp)
    80006ea4:	01010113          	addi	sp,sp,16
    80006ea8:	00008067          	ret

0000000080006eac <system_main>:
    80006eac:	fe010113          	addi	sp,sp,-32
    80006eb0:	00813823          	sd	s0,16(sp)
    80006eb4:	00913423          	sd	s1,8(sp)
    80006eb8:	00113c23          	sd	ra,24(sp)
    80006ebc:	02010413          	addi	s0,sp,32
    80006ec0:	00000097          	auipc	ra,0x0
    80006ec4:	0c4080e7          	jalr	196(ra) # 80006f84 <cpuid>
    80006ec8:	00005497          	auipc	s1,0x5
    80006ecc:	0e848493          	addi	s1,s1,232 # 8000bfb0 <started>
    80006ed0:	02050263          	beqz	a0,80006ef4 <system_main+0x48>
    80006ed4:	0004a783          	lw	a5,0(s1)
    80006ed8:	0007879b          	sext.w	a5,a5
    80006edc:	fe078ce3          	beqz	a5,80006ed4 <system_main+0x28>
    80006ee0:	0ff0000f          	fence
    80006ee4:	00002517          	auipc	a0,0x2
    80006ee8:	70c50513          	addi	a0,a0,1804 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80006eec:	00001097          	auipc	ra,0x1
    80006ef0:	a70080e7          	jalr	-1424(ra) # 8000795c <panic>
    80006ef4:	00001097          	auipc	ra,0x1
    80006ef8:	9c4080e7          	jalr	-1596(ra) # 800078b8 <consoleinit>
    80006efc:	00001097          	auipc	ra,0x1
    80006f00:	150080e7          	jalr	336(ra) # 8000804c <printfinit>
    80006f04:	00002517          	auipc	a0,0x2
    80006f08:	29c50513          	addi	a0,a0,668 # 800091a0 <CONSOLE_STATUS+0x190>
    80006f0c:	00001097          	auipc	ra,0x1
    80006f10:	aac080e7          	jalr	-1364(ra) # 800079b8 <__printf>
    80006f14:	00002517          	auipc	a0,0x2
    80006f18:	6ac50513          	addi	a0,a0,1708 # 800095c0 <CONSOLE_STATUS+0x5b0>
    80006f1c:	00001097          	auipc	ra,0x1
    80006f20:	a9c080e7          	jalr	-1380(ra) # 800079b8 <__printf>
    80006f24:	00002517          	auipc	a0,0x2
    80006f28:	27c50513          	addi	a0,a0,636 # 800091a0 <CONSOLE_STATUS+0x190>
    80006f2c:	00001097          	auipc	ra,0x1
    80006f30:	a8c080e7          	jalr	-1396(ra) # 800079b8 <__printf>
    80006f34:	00001097          	auipc	ra,0x1
    80006f38:	4a4080e7          	jalr	1188(ra) # 800083d8 <kinit>
    80006f3c:	00000097          	auipc	ra,0x0
    80006f40:	148080e7          	jalr	328(ra) # 80007084 <trapinit>
    80006f44:	00000097          	auipc	ra,0x0
    80006f48:	16c080e7          	jalr	364(ra) # 800070b0 <trapinithart>
    80006f4c:	00000097          	auipc	ra,0x0
    80006f50:	5b4080e7          	jalr	1460(ra) # 80007500 <plicinit>
    80006f54:	00000097          	auipc	ra,0x0
    80006f58:	5d4080e7          	jalr	1492(ra) # 80007528 <plicinithart>
    80006f5c:	00000097          	auipc	ra,0x0
    80006f60:	078080e7          	jalr	120(ra) # 80006fd4 <userinit>
    80006f64:	0ff0000f          	fence
    80006f68:	00100793          	li	a5,1
    80006f6c:	00002517          	auipc	a0,0x2
    80006f70:	66c50513          	addi	a0,a0,1644 # 800095d8 <CONSOLE_STATUS+0x5c8>
    80006f74:	00f4a023          	sw	a5,0(s1)
    80006f78:	00001097          	auipc	ra,0x1
    80006f7c:	a40080e7          	jalr	-1472(ra) # 800079b8 <__printf>
    80006f80:	0000006f          	j	80006f80 <system_main+0xd4>

0000000080006f84 <cpuid>:
    80006f84:	ff010113          	addi	sp,sp,-16
    80006f88:	00813423          	sd	s0,8(sp)
    80006f8c:	01010413          	addi	s0,sp,16
    80006f90:	00020513          	mv	a0,tp
    80006f94:	00813403          	ld	s0,8(sp)
    80006f98:	0005051b          	sext.w	a0,a0
    80006f9c:	01010113          	addi	sp,sp,16
    80006fa0:	00008067          	ret

0000000080006fa4 <mycpu>:
    80006fa4:	ff010113          	addi	sp,sp,-16
    80006fa8:	00813423          	sd	s0,8(sp)
    80006fac:	01010413          	addi	s0,sp,16
    80006fb0:	00020793          	mv	a5,tp
    80006fb4:	00813403          	ld	s0,8(sp)
    80006fb8:	0007879b          	sext.w	a5,a5
    80006fbc:	00779793          	slli	a5,a5,0x7
    80006fc0:	0000a517          	auipc	a0,0xa
    80006fc4:	2a050513          	addi	a0,a0,672 # 80011260 <cpus>
    80006fc8:	00f50533          	add	a0,a0,a5
    80006fcc:	01010113          	addi	sp,sp,16
    80006fd0:	00008067          	ret

0000000080006fd4 <userinit>:
    80006fd4:	ff010113          	addi	sp,sp,-16
    80006fd8:	00813423          	sd	s0,8(sp)
    80006fdc:	01010413          	addi	s0,sp,16
    80006fe0:	00813403          	ld	s0,8(sp)
    80006fe4:	01010113          	addi	sp,sp,16
    80006fe8:	ffffc317          	auipc	t1,0xffffc
    80006fec:	92430067          	jr	-1756(t1) # 8000290c <main>

0000000080006ff0 <either_copyout>:
    80006ff0:	ff010113          	addi	sp,sp,-16
    80006ff4:	00813023          	sd	s0,0(sp)
    80006ff8:	00113423          	sd	ra,8(sp)
    80006ffc:	01010413          	addi	s0,sp,16
    80007000:	02051663          	bnez	a0,8000702c <either_copyout+0x3c>
    80007004:	00058513          	mv	a0,a1
    80007008:	00060593          	mv	a1,a2
    8000700c:	0006861b          	sext.w	a2,a3
    80007010:	00002097          	auipc	ra,0x2
    80007014:	c54080e7          	jalr	-940(ra) # 80008c64 <__memmove>
    80007018:	00813083          	ld	ra,8(sp)
    8000701c:	00013403          	ld	s0,0(sp)
    80007020:	00000513          	li	a0,0
    80007024:	01010113          	addi	sp,sp,16
    80007028:	00008067          	ret
    8000702c:	00002517          	auipc	a0,0x2
    80007030:	5ec50513          	addi	a0,a0,1516 # 80009618 <CONSOLE_STATUS+0x608>
    80007034:	00001097          	auipc	ra,0x1
    80007038:	928080e7          	jalr	-1752(ra) # 8000795c <panic>

000000008000703c <either_copyin>:
    8000703c:	ff010113          	addi	sp,sp,-16
    80007040:	00813023          	sd	s0,0(sp)
    80007044:	00113423          	sd	ra,8(sp)
    80007048:	01010413          	addi	s0,sp,16
    8000704c:	02059463          	bnez	a1,80007074 <either_copyin+0x38>
    80007050:	00060593          	mv	a1,a2
    80007054:	0006861b          	sext.w	a2,a3
    80007058:	00002097          	auipc	ra,0x2
    8000705c:	c0c080e7          	jalr	-1012(ra) # 80008c64 <__memmove>
    80007060:	00813083          	ld	ra,8(sp)
    80007064:	00013403          	ld	s0,0(sp)
    80007068:	00000513          	li	a0,0
    8000706c:	01010113          	addi	sp,sp,16
    80007070:	00008067          	ret
    80007074:	00002517          	auipc	a0,0x2
    80007078:	5cc50513          	addi	a0,a0,1484 # 80009640 <CONSOLE_STATUS+0x630>
    8000707c:	00001097          	auipc	ra,0x1
    80007080:	8e0080e7          	jalr	-1824(ra) # 8000795c <panic>

0000000080007084 <trapinit>:
    80007084:	ff010113          	addi	sp,sp,-16
    80007088:	00813423          	sd	s0,8(sp)
    8000708c:	01010413          	addi	s0,sp,16
    80007090:	00813403          	ld	s0,8(sp)
    80007094:	00002597          	auipc	a1,0x2
    80007098:	5d458593          	addi	a1,a1,1492 # 80009668 <CONSOLE_STATUS+0x658>
    8000709c:	0000a517          	auipc	a0,0xa
    800070a0:	24450513          	addi	a0,a0,580 # 800112e0 <tickslock>
    800070a4:	01010113          	addi	sp,sp,16
    800070a8:	00001317          	auipc	t1,0x1
    800070ac:	5c030067          	jr	1472(t1) # 80008668 <initlock>

00000000800070b0 <trapinithart>:
    800070b0:	ff010113          	addi	sp,sp,-16
    800070b4:	00813423          	sd	s0,8(sp)
    800070b8:	01010413          	addi	s0,sp,16
    800070bc:	00000797          	auipc	a5,0x0
    800070c0:	2f478793          	addi	a5,a5,756 # 800073b0 <kernelvec>
    800070c4:	10579073          	csrw	stvec,a5
    800070c8:	00813403          	ld	s0,8(sp)
    800070cc:	01010113          	addi	sp,sp,16
    800070d0:	00008067          	ret

00000000800070d4 <usertrap>:
    800070d4:	ff010113          	addi	sp,sp,-16
    800070d8:	00813423          	sd	s0,8(sp)
    800070dc:	01010413          	addi	s0,sp,16
    800070e0:	00813403          	ld	s0,8(sp)
    800070e4:	01010113          	addi	sp,sp,16
    800070e8:	00008067          	ret

00000000800070ec <usertrapret>:
    800070ec:	ff010113          	addi	sp,sp,-16
    800070f0:	00813423          	sd	s0,8(sp)
    800070f4:	01010413          	addi	s0,sp,16
    800070f8:	00813403          	ld	s0,8(sp)
    800070fc:	01010113          	addi	sp,sp,16
    80007100:	00008067          	ret

0000000080007104 <kerneltrap>:
    80007104:	fe010113          	addi	sp,sp,-32
    80007108:	00813823          	sd	s0,16(sp)
    8000710c:	00113c23          	sd	ra,24(sp)
    80007110:	00913423          	sd	s1,8(sp)
    80007114:	02010413          	addi	s0,sp,32
    80007118:	142025f3          	csrr	a1,scause
    8000711c:	100027f3          	csrr	a5,sstatus
    80007120:	0027f793          	andi	a5,a5,2
    80007124:	10079c63          	bnez	a5,8000723c <kerneltrap+0x138>
    80007128:	142027f3          	csrr	a5,scause
    8000712c:	0207ce63          	bltz	a5,80007168 <kerneltrap+0x64>
    80007130:	00002517          	auipc	a0,0x2
    80007134:	58050513          	addi	a0,a0,1408 # 800096b0 <CONSOLE_STATUS+0x6a0>
    80007138:	00001097          	auipc	ra,0x1
    8000713c:	880080e7          	jalr	-1920(ra) # 800079b8 <__printf>
    80007140:	141025f3          	csrr	a1,sepc
    80007144:	14302673          	csrr	a2,stval
    80007148:	00002517          	auipc	a0,0x2
    8000714c:	57850513          	addi	a0,a0,1400 # 800096c0 <CONSOLE_STATUS+0x6b0>
    80007150:	00001097          	auipc	ra,0x1
    80007154:	868080e7          	jalr	-1944(ra) # 800079b8 <__printf>
    80007158:	00002517          	auipc	a0,0x2
    8000715c:	58050513          	addi	a0,a0,1408 # 800096d8 <CONSOLE_STATUS+0x6c8>
    80007160:	00000097          	auipc	ra,0x0
    80007164:	7fc080e7          	jalr	2044(ra) # 8000795c <panic>
    80007168:	0ff7f713          	andi	a4,a5,255
    8000716c:	00900693          	li	a3,9
    80007170:	04d70063          	beq	a4,a3,800071b0 <kerneltrap+0xac>
    80007174:	fff00713          	li	a4,-1
    80007178:	03f71713          	slli	a4,a4,0x3f
    8000717c:	00170713          	addi	a4,a4,1
    80007180:	fae798e3          	bne	a5,a4,80007130 <kerneltrap+0x2c>
    80007184:	00000097          	auipc	ra,0x0
    80007188:	e00080e7          	jalr	-512(ra) # 80006f84 <cpuid>
    8000718c:	06050663          	beqz	a0,800071f8 <kerneltrap+0xf4>
    80007190:	144027f3          	csrr	a5,sip
    80007194:	ffd7f793          	andi	a5,a5,-3
    80007198:	14479073          	csrw	sip,a5
    8000719c:	01813083          	ld	ra,24(sp)
    800071a0:	01013403          	ld	s0,16(sp)
    800071a4:	00813483          	ld	s1,8(sp)
    800071a8:	02010113          	addi	sp,sp,32
    800071ac:	00008067          	ret
    800071b0:	00000097          	auipc	ra,0x0
    800071b4:	3c4080e7          	jalr	964(ra) # 80007574 <plic_claim>
    800071b8:	00a00793          	li	a5,10
    800071bc:	00050493          	mv	s1,a0
    800071c0:	06f50863          	beq	a0,a5,80007230 <kerneltrap+0x12c>
    800071c4:	fc050ce3          	beqz	a0,8000719c <kerneltrap+0x98>
    800071c8:	00050593          	mv	a1,a0
    800071cc:	00002517          	auipc	a0,0x2
    800071d0:	4c450513          	addi	a0,a0,1220 # 80009690 <CONSOLE_STATUS+0x680>
    800071d4:	00000097          	auipc	ra,0x0
    800071d8:	7e4080e7          	jalr	2020(ra) # 800079b8 <__printf>
    800071dc:	01013403          	ld	s0,16(sp)
    800071e0:	01813083          	ld	ra,24(sp)
    800071e4:	00048513          	mv	a0,s1
    800071e8:	00813483          	ld	s1,8(sp)
    800071ec:	02010113          	addi	sp,sp,32
    800071f0:	00000317          	auipc	t1,0x0
    800071f4:	3bc30067          	jr	956(t1) # 800075ac <plic_complete>
    800071f8:	0000a517          	auipc	a0,0xa
    800071fc:	0e850513          	addi	a0,a0,232 # 800112e0 <tickslock>
    80007200:	00001097          	auipc	ra,0x1
    80007204:	48c080e7          	jalr	1164(ra) # 8000868c <acquire>
    80007208:	00005717          	auipc	a4,0x5
    8000720c:	dac70713          	addi	a4,a4,-596 # 8000bfb4 <ticks>
    80007210:	00072783          	lw	a5,0(a4)
    80007214:	0000a517          	auipc	a0,0xa
    80007218:	0cc50513          	addi	a0,a0,204 # 800112e0 <tickslock>
    8000721c:	0017879b          	addiw	a5,a5,1
    80007220:	00f72023          	sw	a5,0(a4)
    80007224:	00001097          	auipc	ra,0x1
    80007228:	534080e7          	jalr	1332(ra) # 80008758 <release>
    8000722c:	f65ff06f          	j	80007190 <kerneltrap+0x8c>
    80007230:	00001097          	auipc	ra,0x1
    80007234:	090080e7          	jalr	144(ra) # 800082c0 <uartintr>
    80007238:	fa5ff06f          	j	800071dc <kerneltrap+0xd8>
    8000723c:	00002517          	auipc	a0,0x2
    80007240:	43450513          	addi	a0,a0,1076 # 80009670 <CONSOLE_STATUS+0x660>
    80007244:	00000097          	auipc	ra,0x0
    80007248:	718080e7          	jalr	1816(ra) # 8000795c <panic>

000000008000724c <clockintr>:
    8000724c:	fe010113          	addi	sp,sp,-32
    80007250:	00813823          	sd	s0,16(sp)
    80007254:	00913423          	sd	s1,8(sp)
    80007258:	00113c23          	sd	ra,24(sp)
    8000725c:	02010413          	addi	s0,sp,32
    80007260:	0000a497          	auipc	s1,0xa
    80007264:	08048493          	addi	s1,s1,128 # 800112e0 <tickslock>
    80007268:	00048513          	mv	a0,s1
    8000726c:	00001097          	auipc	ra,0x1
    80007270:	420080e7          	jalr	1056(ra) # 8000868c <acquire>
    80007274:	00005717          	auipc	a4,0x5
    80007278:	d4070713          	addi	a4,a4,-704 # 8000bfb4 <ticks>
    8000727c:	00072783          	lw	a5,0(a4)
    80007280:	01013403          	ld	s0,16(sp)
    80007284:	01813083          	ld	ra,24(sp)
    80007288:	00048513          	mv	a0,s1
    8000728c:	0017879b          	addiw	a5,a5,1
    80007290:	00813483          	ld	s1,8(sp)
    80007294:	00f72023          	sw	a5,0(a4)
    80007298:	02010113          	addi	sp,sp,32
    8000729c:	00001317          	auipc	t1,0x1
    800072a0:	4bc30067          	jr	1212(t1) # 80008758 <release>

00000000800072a4 <devintr>:
    800072a4:	142027f3          	csrr	a5,scause
    800072a8:	00000513          	li	a0,0
    800072ac:	0007c463          	bltz	a5,800072b4 <devintr+0x10>
    800072b0:	00008067          	ret
    800072b4:	fe010113          	addi	sp,sp,-32
    800072b8:	00813823          	sd	s0,16(sp)
    800072bc:	00113c23          	sd	ra,24(sp)
    800072c0:	00913423          	sd	s1,8(sp)
    800072c4:	02010413          	addi	s0,sp,32
    800072c8:	0ff7f713          	andi	a4,a5,255
    800072cc:	00900693          	li	a3,9
    800072d0:	04d70c63          	beq	a4,a3,80007328 <devintr+0x84>
    800072d4:	fff00713          	li	a4,-1
    800072d8:	03f71713          	slli	a4,a4,0x3f
    800072dc:	00170713          	addi	a4,a4,1
    800072e0:	00e78c63          	beq	a5,a4,800072f8 <devintr+0x54>
    800072e4:	01813083          	ld	ra,24(sp)
    800072e8:	01013403          	ld	s0,16(sp)
    800072ec:	00813483          	ld	s1,8(sp)
    800072f0:	02010113          	addi	sp,sp,32
    800072f4:	00008067          	ret
    800072f8:	00000097          	auipc	ra,0x0
    800072fc:	c8c080e7          	jalr	-884(ra) # 80006f84 <cpuid>
    80007300:	06050663          	beqz	a0,8000736c <devintr+0xc8>
    80007304:	144027f3          	csrr	a5,sip
    80007308:	ffd7f793          	andi	a5,a5,-3
    8000730c:	14479073          	csrw	sip,a5
    80007310:	01813083          	ld	ra,24(sp)
    80007314:	01013403          	ld	s0,16(sp)
    80007318:	00813483          	ld	s1,8(sp)
    8000731c:	00200513          	li	a0,2
    80007320:	02010113          	addi	sp,sp,32
    80007324:	00008067          	ret
    80007328:	00000097          	auipc	ra,0x0
    8000732c:	24c080e7          	jalr	588(ra) # 80007574 <plic_claim>
    80007330:	00a00793          	li	a5,10
    80007334:	00050493          	mv	s1,a0
    80007338:	06f50663          	beq	a0,a5,800073a4 <devintr+0x100>
    8000733c:	00100513          	li	a0,1
    80007340:	fa0482e3          	beqz	s1,800072e4 <devintr+0x40>
    80007344:	00048593          	mv	a1,s1
    80007348:	00002517          	auipc	a0,0x2
    8000734c:	34850513          	addi	a0,a0,840 # 80009690 <CONSOLE_STATUS+0x680>
    80007350:	00000097          	auipc	ra,0x0
    80007354:	668080e7          	jalr	1640(ra) # 800079b8 <__printf>
    80007358:	00048513          	mv	a0,s1
    8000735c:	00000097          	auipc	ra,0x0
    80007360:	250080e7          	jalr	592(ra) # 800075ac <plic_complete>
    80007364:	00100513          	li	a0,1
    80007368:	f7dff06f          	j	800072e4 <devintr+0x40>
    8000736c:	0000a517          	auipc	a0,0xa
    80007370:	f7450513          	addi	a0,a0,-140 # 800112e0 <tickslock>
    80007374:	00001097          	auipc	ra,0x1
    80007378:	318080e7          	jalr	792(ra) # 8000868c <acquire>
    8000737c:	00005717          	auipc	a4,0x5
    80007380:	c3870713          	addi	a4,a4,-968 # 8000bfb4 <ticks>
    80007384:	00072783          	lw	a5,0(a4)
    80007388:	0000a517          	auipc	a0,0xa
    8000738c:	f5850513          	addi	a0,a0,-168 # 800112e0 <tickslock>
    80007390:	0017879b          	addiw	a5,a5,1
    80007394:	00f72023          	sw	a5,0(a4)
    80007398:	00001097          	auipc	ra,0x1
    8000739c:	3c0080e7          	jalr	960(ra) # 80008758 <release>
    800073a0:	f65ff06f          	j	80007304 <devintr+0x60>
    800073a4:	00001097          	auipc	ra,0x1
    800073a8:	f1c080e7          	jalr	-228(ra) # 800082c0 <uartintr>
    800073ac:	fadff06f          	j	80007358 <devintr+0xb4>

00000000800073b0 <kernelvec>:
    800073b0:	f0010113          	addi	sp,sp,-256
    800073b4:	00113023          	sd	ra,0(sp)
    800073b8:	00213423          	sd	sp,8(sp)
    800073bc:	00313823          	sd	gp,16(sp)
    800073c0:	00413c23          	sd	tp,24(sp)
    800073c4:	02513023          	sd	t0,32(sp)
    800073c8:	02613423          	sd	t1,40(sp)
    800073cc:	02713823          	sd	t2,48(sp)
    800073d0:	02813c23          	sd	s0,56(sp)
    800073d4:	04913023          	sd	s1,64(sp)
    800073d8:	04a13423          	sd	a0,72(sp)
    800073dc:	04b13823          	sd	a1,80(sp)
    800073e0:	04c13c23          	sd	a2,88(sp)
    800073e4:	06d13023          	sd	a3,96(sp)
    800073e8:	06e13423          	sd	a4,104(sp)
    800073ec:	06f13823          	sd	a5,112(sp)
    800073f0:	07013c23          	sd	a6,120(sp)
    800073f4:	09113023          	sd	a7,128(sp)
    800073f8:	09213423          	sd	s2,136(sp)
    800073fc:	09313823          	sd	s3,144(sp)
    80007400:	09413c23          	sd	s4,152(sp)
    80007404:	0b513023          	sd	s5,160(sp)
    80007408:	0b613423          	sd	s6,168(sp)
    8000740c:	0b713823          	sd	s7,176(sp)
    80007410:	0b813c23          	sd	s8,184(sp)
    80007414:	0d913023          	sd	s9,192(sp)
    80007418:	0da13423          	sd	s10,200(sp)
    8000741c:	0db13823          	sd	s11,208(sp)
    80007420:	0dc13c23          	sd	t3,216(sp)
    80007424:	0fd13023          	sd	t4,224(sp)
    80007428:	0fe13423          	sd	t5,232(sp)
    8000742c:	0ff13823          	sd	t6,240(sp)
    80007430:	cd5ff0ef          	jal	ra,80007104 <kerneltrap>
    80007434:	00013083          	ld	ra,0(sp)
    80007438:	00813103          	ld	sp,8(sp)
    8000743c:	01013183          	ld	gp,16(sp)
    80007440:	02013283          	ld	t0,32(sp)
    80007444:	02813303          	ld	t1,40(sp)
    80007448:	03013383          	ld	t2,48(sp)
    8000744c:	03813403          	ld	s0,56(sp)
    80007450:	04013483          	ld	s1,64(sp)
    80007454:	04813503          	ld	a0,72(sp)
    80007458:	05013583          	ld	a1,80(sp)
    8000745c:	05813603          	ld	a2,88(sp)
    80007460:	06013683          	ld	a3,96(sp)
    80007464:	06813703          	ld	a4,104(sp)
    80007468:	07013783          	ld	a5,112(sp)
    8000746c:	07813803          	ld	a6,120(sp)
    80007470:	08013883          	ld	a7,128(sp)
    80007474:	08813903          	ld	s2,136(sp)
    80007478:	09013983          	ld	s3,144(sp)
    8000747c:	09813a03          	ld	s4,152(sp)
    80007480:	0a013a83          	ld	s5,160(sp)
    80007484:	0a813b03          	ld	s6,168(sp)
    80007488:	0b013b83          	ld	s7,176(sp)
    8000748c:	0b813c03          	ld	s8,184(sp)
    80007490:	0c013c83          	ld	s9,192(sp)
    80007494:	0c813d03          	ld	s10,200(sp)
    80007498:	0d013d83          	ld	s11,208(sp)
    8000749c:	0d813e03          	ld	t3,216(sp)
    800074a0:	0e013e83          	ld	t4,224(sp)
    800074a4:	0e813f03          	ld	t5,232(sp)
    800074a8:	0f013f83          	ld	t6,240(sp)
    800074ac:	10010113          	addi	sp,sp,256
    800074b0:	10200073          	sret
    800074b4:	00000013          	nop
    800074b8:	00000013          	nop
    800074bc:	00000013          	nop

00000000800074c0 <timervec>:
    800074c0:	34051573          	csrrw	a0,mscratch,a0
    800074c4:	00b53023          	sd	a1,0(a0)
    800074c8:	00c53423          	sd	a2,8(a0)
    800074cc:	00d53823          	sd	a3,16(a0)
    800074d0:	01853583          	ld	a1,24(a0)
    800074d4:	02053603          	ld	a2,32(a0)
    800074d8:	0005b683          	ld	a3,0(a1)
    800074dc:	00c686b3          	add	a3,a3,a2
    800074e0:	00d5b023          	sd	a3,0(a1)
    800074e4:	00200593          	li	a1,2
    800074e8:	14459073          	csrw	sip,a1
    800074ec:	01053683          	ld	a3,16(a0)
    800074f0:	00853603          	ld	a2,8(a0)
    800074f4:	00053583          	ld	a1,0(a0)
    800074f8:	34051573          	csrrw	a0,mscratch,a0
    800074fc:	30200073          	mret

0000000080007500 <plicinit>:
    80007500:	ff010113          	addi	sp,sp,-16
    80007504:	00813423          	sd	s0,8(sp)
    80007508:	01010413          	addi	s0,sp,16
    8000750c:	00813403          	ld	s0,8(sp)
    80007510:	0c0007b7          	lui	a5,0xc000
    80007514:	00100713          	li	a4,1
    80007518:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000751c:	00e7a223          	sw	a4,4(a5)
    80007520:	01010113          	addi	sp,sp,16
    80007524:	00008067          	ret

0000000080007528 <plicinithart>:
    80007528:	ff010113          	addi	sp,sp,-16
    8000752c:	00813023          	sd	s0,0(sp)
    80007530:	00113423          	sd	ra,8(sp)
    80007534:	01010413          	addi	s0,sp,16
    80007538:	00000097          	auipc	ra,0x0
    8000753c:	a4c080e7          	jalr	-1460(ra) # 80006f84 <cpuid>
    80007540:	0085171b          	slliw	a4,a0,0x8
    80007544:	0c0027b7          	lui	a5,0xc002
    80007548:	00e787b3          	add	a5,a5,a4
    8000754c:	40200713          	li	a4,1026
    80007550:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007554:	00813083          	ld	ra,8(sp)
    80007558:	00013403          	ld	s0,0(sp)
    8000755c:	00d5151b          	slliw	a0,a0,0xd
    80007560:	0c2017b7          	lui	a5,0xc201
    80007564:	00a78533          	add	a0,a5,a0
    80007568:	00052023          	sw	zero,0(a0)
    8000756c:	01010113          	addi	sp,sp,16
    80007570:	00008067          	ret

0000000080007574 <plic_claim>:
    80007574:	ff010113          	addi	sp,sp,-16
    80007578:	00813023          	sd	s0,0(sp)
    8000757c:	00113423          	sd	ra,8(sp)
    80007580:	01010413          	addi	s0,sp,16
    80007584:	00000097          	auipc	ra,0x0
    80007588:	a00080e7          	jalr	-1536(ra) # 80006f84 <cpuid>
    8000758c:	00813083          	ld	ra,8(sp)
    80007590:	00013403          	ld	s0,0(sp)
    80007594:	00d5151b          	slliw	a0,a0,0xd
    80007598:	0c2017b7          	lui	a5,0xc201
    8000759c:	00a78533          	add	a0,a5,a0
    800075a0:	00452503          	lw	a0,4(a0)
    800075a4:	01010113          	addi	sp,sp,16
    800075a8:	00008067          	ret

00000000800075ac <plic_complete>:
    800075ac:	fe010113          	addi	sp,sp,-32
    800075b0:	00813823          	sd	s0,16(sp)
    800075b4:	00913423          	sd	s1,8(sp)
    800075b8:	00113c23          	sd	ra,24(sp)
    800075bc:	02010413          	addi	s0,sp,32
    800075c0:	00050493          	mv	s1,a0
    800075c4:	00000097          	auipc	ra,0x0
    800075c8:	9c0080e7          	jalr	-1600(ra) # 80006f84 <cpuid>
    800075cc:	01813083          	ld	ra,24(sp)
    800075d0:	01013403          	ld	s0,16(sp)
    800075d4:	00d5179b          	slliw	a5,a0,0xd
    800075d8:	0c201737          	lui	a4,0xc201
    800075dc:	00f707b3          	add	a5,a4,a5
    800075e0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800075e4:	00813483          	ld	s1,8(sp)
    800075e8:	02010113          	addi	sp,sp,32
    800075ec:	00008067          	ret

00000000800075f0 <consolewrite>:
    800075f0:	fb010113          	addi	sp,sp,-80
    800075f4:	04813023          	sd	s0,64(sp)
    800075f8:	04113423          	sd	ra,72(sp)
    800075fc:	02913c23          	sd	s1,56(sp)
    80007600:	03213823          	sd	s2,48(sp)
    80007604:	03313423          	sd	s3,40(sp)
    80007608:	03413023          	sd	s4,32(sp)
    8000760c:	01513c23          	sd	s5,24(sp)
    80007610:	05010413          	addi	s0,sp,80
    80007614:	06c05c63          	blez	a2,8000768c <consolewrite+0x9c>
    80007618:	00060993          	mv	s3,a2
    8000761c:	00050a13          	mv	s4,a0
    80007620:	00058493          	mv	s1,a1
    80007624:	00000913          	li	s2,0
    80007628:	fff00a93          	li	s5,-1
    8000762c:	01c0006f          	j	80007648 <consolewrite+0x58>
    80007630:	fbf44503          	lbu	a0,-65(s0)
    80007634:	0019091b          	addiw	s2,s2,1
    80007638:	00148493          	addi	s1,s1,1
    8000763c:	00001097          	auipc	ra,0x1
    80007640:	a9c080e7          	jalr	-1380(ra) # 800080d8 <uartputc>
    80007644:	03298063          	beq	s3,s2,80007664 <consolewrite+0x74>
    80007648:	00048613          	mv	a2,s1
    8000764c:	00100693          	li	a3,1
    80007650:	000a0593          	mv	a1,s4
    80007654:	fbf40513          	addi	a0,s0,-65
    80007658:	00000097          	auipc	ra,0x0
    8000765c:	9e4080e7          	jalr	-1564(ra) # 8000703c <either_copyin>
    80007660:	fd5518e3          	bne	a0,s5,80007630 <consolewrite+0x40>
    80007664:	04813083          	ld	ra,72(sp)
    80007668:	04013403          	ld	s0,64(sp)
    8000766c:	03813483          	ld	s1,56(sp)
    80007670:	02813983          	ld	s3,40(sp)
    80007674:	02013a03          	ld	s4,32(sp)
    80007678:	01813a83          	ld	s5,24(sp)
    8000767c:	00090513          	mv	a0,s2
    80007680:	03013903          	ld	s2,48(sp)
    80007684:	05010113          	addi	sp,sp,80
    80007688:	00008067          	ret
    8000768c:	00000913          	li	s2,0
    80007690:	fd5ff06f          	j	80007664 <consolewrite+0x74>

0000000080007694 <consoleread>:
    80007694:	f9010113          	addi	sp,sp,-112
    80007698:	06813023          	sd	s0,96(sp)
    8000769c:	04913c23          	sd	s1,88(sp)
    800076a0:	05213823          	sd	s2,80(sp)
    800076a4:	05313423          	sd	s3,72(sp)
    800076a8:	05413023          	sd	s4,64(sp)
    800076ac:	03513c23          	sd	s5,56(sp)
    800076b0:	03613823          	sd	s6,48(sp)
    800076b4:	03713423          	sd	s7,40(sp)
    800076b8:	03813023          	sd	s8,32(sp)
    800076bc:	06113423          	sd	ra,104(sp)
    800076c0:	01913c23          	sd	s9,24(sp)
    800076c4:	07010413          	addi	s0,sp,112
    800076c8:	00060b93          	mv	s7,a2
    800076cc:	00050913          	mv	s2,a0
    800076d0:	00058c13          	mv	s8,a1
    800076d4:	00060b1b          	sext.w	s6,a2
    800076d8:	0000a497          	auipc	s1,0xa
    800076dc:	c3048493          	addi	s1,s1,-976 # 80011308 <cons>
    800076e0:	00400993          	li	s3,4
    800076e4:	fff00a13          	li	s4,-1
    800076e8:	00a00a93          	li	s5,10
    800076ec:	05705e63          	blez	s7,80007748 <consoleread+0xb4>
    800076f0:	09c4a703          	lw	a4,156(s1)
    800076f4:	0984a783          	lw	a5,152(s1)
    800076f8:	0007071b          	sext.w	a4,a4
    800076fc:	08e78463          	beq	a5,a4,80007784 <consoleread+0xf0>
    80007700:	07f7f713          	andi	a4,a5,127
    80007704:	00e48733          	add	a4,s1,a4
    80007708:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000770c:	0017869b          	addiw	a3,a5,1
    80007710:	08d4ac23          	sw	a3,152(s1)
    80007714:	00070c9b          	sext.w	s9,a4
    80007718:	0b370663          	beq	a4,s3,800077c4 <consoleread+0x130>
    8000771c:	00100693          	li	a3,1
    80007720:	f9f40613          	addi	a2,s0,-97
    80007724:	000c0593          	mv	a1,s8
    80007728:	00090513          	mv	a0,s2
    8000772c:	f8e40fa3          	sb	a4,-97(s0)
    80007730:	00000097          	auipc	ra,0x0
    80007734:	8c0080e7          	jalr	-1856(ra) # 80006ff0 <either_copyout>
    80007738:	01450863          	beq	a0,s4,80007748 <consoleread+0xb4>
    8000773c:	001c0c13          	addi	s8,s8,1
    80007740:	fffb8b9b          	addiw	s7,s7,-1
    80007744:	fb5c94e3          	bne	s9,s5,800076ec <consoleread+0x58>
    80007748:	000b851b          	sext.w	a0,s7
    8000774c:	06813083          	ld	ra,104(sp)
    80007750:	06013403          	ld	s0,96(sp)
    80007754:	05813483          	ld	s1,88(sp)
    80007758:	05013903          	ld	s2,80(sp)
    8000775c:	04813983          	ld	s3,72(sp)
    80007760:	04013a03          	ld	s4,64(sp)
    80007764:	03813a83          	ld	s5,56(sp)
    80007768:	02813b83          	ld	s7,40(sp)
    8000776c:	02013c03          	ld	s8,32(sp)
    80007770:	01813c83          	ld	s9,24(sp)
    80007774:	40ab053b          	subw	a0,s6,a0
    80007778:	03013b03          	ld	s6,48(sp)
    8000777c:	07010113          	addi	sp,sp,112
    80007780:	00008067          	ret
    80007784:	00001097          	auipc	ra,0x1
    80007788:	1d8080e7          	jalr	472(ra) # 8000895c <push_on>
    8000778c:	0984a703          	lw	a4,152(s1)
    80007790:	09c4a783          	lw	a5,156(s1)
    80007794:	0007879b          	sext.w	a5,a5
    80007798:	fef70ce3          	beq	a4,a5,80007790 <consoleread+0xfc>
    8000779c:	00001097          	auipc	ra,0x1
    800077a0:	234080e7          	jalr	564(ra) # 800089d0 <pop_on>
    800077a4:	0984a783          	lw	a5,152(s1)
    800077a8:	07f7f713          	andi	a4,a5,127
    800077ac:	00e48733          	add	a4,s1,a4
    800077b0:	01874703          	lbu	a4,24(a4)
    800077b4:	0017869b          	addiw	a3,a5,1
    800077b8:	08d4ac23          	sw	a3,152(s1)
    800077bc:	00070c9b          	sext.w	s9,a4
    800077c0:	f5371ee3          	bne	a4,s3,8000771c <consoleread+0x88>
    800077c4:	000b851b          	sext.w	a0,s7
    800077c8:	f96bf2e3          	bgeu	s7,s6,8000774c <consoleread+0xb8>
    800077cc:	08f4ac23          	sw	a5,152(s1)
    800077d0:	f7dff06f          	j	8000774c <consoleread+0xb8>

00000000800077d4 <consputc>:
    800077d4:	10000793          	li	a5,256
    800077d8:	00f50663          	beq	a0,a5,800077e4 <consputc+0x10>
    800077dc:	00001317          	auipc	t1,0x1
    800077e0:	9f430067          	jr	-1548(t1) # 800081d0 <uartputc_sync>
    800077e4:	ff010113          	addi	sp,sp,-16
    800077e8:	00113423          	sd	ra,8(sp)
    800077ec:	00813023          	sd	s0,0(sp)
    800077f0:	01010413          	addi	s0,sp,16
    800077f4:	00800513          	li	a0,8
    800077f8:	00001097          	auipc	ra,0x1
    800077fc:	9d8080e7          	jalr	-1576(ra) # 800081d0 <uartputc_sync>
    80007800:	02000513          	li	a0,32
    80007804:	00001097          	auipc	ra,0x1
    80007808:	9cc080e7          	jalr	-1588(ra) # 800081d0 <uartputc_sync>
    8000780c:	00013403          	ld	s0,0(sp)
    80007810:	00813083          	ld	ra,8(sp)
    80007814:	00800513          	li	a0,8
    80007818:	01010113          	addi	sp,sp,16
    8000781c:	00001317          	auipc	t1,0x1
    80007820:	9b430067          	jr	-1612(t1) # 800081d0 <uartputc_sync>

0000000080007824 <consoleintr>:
    80007824:	fe010113          	addi	sp,sp,-32
    80007828:	00813823          	sd	s0,16(sp)
    8000782c:	00913423          	sd	s1,8(sp)
    80007830:	01213023          	sd	s2,0(sp)
    80007834:	00113c23          	sd	ra,24(sp)
    80007838:	02010413          	addi	s0,sp,32
    8000783c:	0000a917          	auipc	s2,0xa
    80007840:	acc90913          	addi	s2,s2,-1332 # 80011308 <cons>
    80007844:	00050493          	mv	s1,a0
    80007848:	00090513          	mv	a0,s2
    8000784c:	00001097          	auipc	ra,0x1
    80007850:	e40080e7          	jalr	-448(ra) # 8000868c <acquire>
    80007854:	02048c63          	beqz	s1,8000788c <consoleintr+0x68>
    80007858:	0a092783          	lw	a5,160(s2)
    8000785c:	09892703          	lw	a4,152(s2)
    80007860:	07f00693          	li	a3,127
    80007864:	40e7873b          	subw	a4,a5,a4
    80007868:	02e6e263          	bltu	a3,a4,8000788c <consoleintr+0x68>
    8000786c:	00d00713          	li	a4,13
    80007870:	04e48063          	beq	s1,a4,800078b0 <consoleintr+0x8c>
    80007874:	07f7f713          	andi	a4,a5,127
    80007878:	00e90733          	add	a4,s2,a4
    8000787c:	0017879b          	addiw	a5,a5,1
    80007880:	0af92023          	sw	a5,160(s2)
    80007884:	00970c23          	sb	s1,24(a4)
    80007888:	08f92e23          	sw	a5,156(s2)
    8000788c:	01013403          	ld	s0,16(sp)
    80007890:	01813083          	ld	ra,24(sp)
    80007894:	00813483          	ld	s1,8(sp)
    80007898:	00013903          	ld	s2,0(sp)
    8000789c:	0000a517          	auipc	a0,0xa
    800078a0:	a6c50513          	addi	a0,a0,-1428 # 80011308 <cons>
    800078a4:	02010113          	addi	sp,sp,32
    800078a8:	00001317          	auipc	t1,0x1
    800078ac:	eb030067          	jr	-336(t1) # 80008758 <release>
    800078b0:	00a00493          	li	s1,10
    800078b4:	fc1ff06f          	j	80007874 <consoleintr+0x50>

00000000800078b8 <consoleinit>:
    800078b8:	fe010113          	addi	sp,sp,-32
    800078bc:	00113c23          	sd	ra,24(sp)
    800078c0:	00813823          	sd	s0,16(sp)
    800078c4:	00913423          	sd	s1,8(sp)
    800078c8:	02010413          	addi	s0,sp,32
    800078cc:	0000a497          	auipc	s1,0xa
    800078d0:	a3c48493          	addi	s1,s1,-1476 # 80011308 <cons>
    800078d4:	00048513          	mv	a0,s1
    800078d8:	00002597          	auipc	a1,0x2
    800078dc:	e1058593          	addi	a1,a1,-496 # 800096e8 <CONSOLE_STATUS+0x6d8>
    800078e0:	00001097          	auipc	ra,0x1
    800078e4:	d88080e7          	jalr	-632(ra) # 80008668 <initlock>
    800078e8:	00000097          	auipc	ra,0x0
    800078ec:	7ac080e7          	jalr	1964(ra) # 80008094 <uartinit>
    800078f0:	01813083          	ld	ra,24(sp)
    800078f4:	01013403          	ld	s0,16(sp)
    800078f8:	00000797          	auipc	a5,0x0
    800078fc:	d9c78793          	addi	a5,a5,-612 # 80007694 <consoleread>
    80007900:	0af4bc23          	sd	a5,184(s1)
    80007904:	00000797          	auipc	a5,0x0
    80007908:	cec78793          	addi	a5,a5,-788 # 800075f0 <consolewrite>
    8000790c:	0cf4b023          	sd	a5,192(s1)
    80007910:	00813483          	ld	s1,8(sp)
    80007914:	02010113          	addi	sp,sp,32
    80007918:	00008067          	ret

000000008000791c <console_read>:
    8000791c:	ff010113          	addi	sp,sp,-16
    80007920:	00813423          	sd	s0,8(sp)
    80007924:	01010413          	addi	s0,sp,16
    80007928:	00813403          	ld	s0,8(sp)
    8000792c:	0000a317          	auipc	t1,0xa
    80007930:	a9433303          	ld	t1,-1388(t1) # 800113c0 <devsw+0x10>
    80007934:	01010113          	addi	sp,sp,16
    80007938:	00030067          	jr	t1

000000008000793c <console_write>:
    8000793c:	ff010113          	addi	sp,sp,-16
    80007940:	00813423          	sd	s0,8(sp)
    80007944:	01010413          	addi	s0,sp,16
    80007948:	00813403          	ld	s0,8(sp)
    8000794c:	0000a317          	auipc	t1,0xa
    80007950:	a7c33303          	ld	t1,-1412(t1) # 800113c8 <devsw+0x18>
    80007954:	01010113          	addi	sp,sp,16
    80007958:	00030067          	jr	t1

000000008000795c <panic>:
    8000795c:	fe010113          	addi	sp,sp,-32
    80007960:	00113c23          	sd	ra,24(sp)
    80007964:	00813823          	sd	s0,16(sp)
    80007968:	00913423          	sd	s1,8(sp)
    8000796c:	02010413          	addi	s0,sp,32
    80007970:	00050493          	mv	s1,a0
    80007974:	00002517          	auipc	a0,0x2
    80007978:	d7c50513          	addi	a0,a0,-644 # 800096f0 <CONSOLE_STATUS+0x6e0>
    8000797c:	0000a797          	auipc	a5,0xa
    80007980:	ae07a623          	sw	zero,-1300(a5) # 80011468 <pr+0x18>
    80007984:	00000097          	auipc	ra,0x0
    80007988:	034080e7          	jalr	52(ra) # 800079b8 <__printf>
    8000798c:	00048513          	mv	a0,s1
    80007990:	00000097          	auipc	ra,0x0
    80007994:	028080e7          	jalr	40(ra) # 800079b8 <__printf>
    80007998:	00002517          	auipc	a0,0x2
    8000799c:	80850513          	addi	a0,a0,-2040 # 800091a0 <CONSOLE_STATUS+0x190>
    800079a0:	00000097          	auipc	ra,0x0
    800079a4:	018080e7          	jalr	24(ra) # 800079b8 <__printf>
    800079a8:	00100793          	li	a5,1
    800079ac:	00004717          	auipc	a4,0x4
    800079b0:	60f72623          	sw	a5,1548(a4) # 8000bfb8 <panicked>
    800079b4:	0000006f          	j	800079b4 <panic+0x58>

00000000800079b8 <__printf>:
    800079b8:	f3010113          	addi	sp,sp,-208
    800079bc:	08813023          	sd	s0,128(sp)
    800079c0:	07313423          	sd	s3,104(sp)
    800079c4:	09010413          	addi	s0,sp,144
    800079c8:	05813023          	sd	s8,64(sp)
    800079cc:	08113423          	sd	ra,136(sp)
    800079d0:	06913c23          	sd	s1,120(sp)
    800079d4:	07213823          	sd	s2,112(sp)
    800079d8:	07413023          	sd	s4,96(sp)
    800079dc:	05513c23          	sd	s5,88(sp)
    800079e0:	05613823          	sd	s6,80(sp)
    800079e4:	05713423          	sd	s7,72(sp)
    800079e8:	03913c23          	sd	s9,56(sp)
    800079ec:	03a13823          	sd	s10,48(sp)
    800079f0:	03b13423          	sd	s11,40(sp)
    800079f4:	0000a317          	auipc	t1,0xa
    800079f8:	a5c30313          	addi	t1,t1,-1444 # 80011450 <pr>
    800079fc:	01832c03          	lw	s8,24(t1)
    80007a00:	00b43423          	sd	a1,8(s0)
    80007a04:	00c43823          	sd	a2,16(s0)
    80007a08:	00d43c23          	sd	a3,24(s0)
    80007a0c:	02e43023          	sd	a4,32(s0)
    80007a10:	02f43423          	sd	a5,40(s0)
    80007a14:	03043823          	sd	a6,48(s0)
    80007a18:	03143c23          	sd	a7,56(s0)
    80007a1c:	00050993          	mv	s3,a0
    80007a20:	4a0c1663          	bnez	s8,80007ecc <__printf+0x514>
    80007a24:	60098c63          	beqz	s3,8000803c <__printf+0x684>
    80007a28:	0009c503          	lbu	a0,0(s3)
    80007a2c:	00840793          	addi	a5,s0,8
    80007a30:	f6f43c23          	sd	a5,-136(s0)
    80007a34:	00000493          	li	s1,0
    80007a38:	22050063          	beqz	a0,80007c58 <__printf+0x2a0>
    80007a3c:	00002a37          	lui	s4,0x2
    80007a40:	00018ab7          	lui	s5,0x18
    80007a44:	000f4b37          	lui	s6,0xf4
    80007a48:	00989bb7          	lui	s7,0x989
    80007a4c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007a50:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007a54:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007a58:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80007a5c:	00148c9b          	addiw	s9,s1,1
    80007a60:	02500793          	li	a5,37
    80007a64:	01998933          	add	s2,s3,s9
    80007a68:	38f51263          	bne	a0,a5,80007dec <__printf+0x434>
    80007a6c:	00094783          	lbu	a5,0(s2)
    80007a70:	00078c9b          	sext.w	s9,a5
    80007a74:	1e078263          	beqz	a5,80007c58 <__printf+0x2a0>
    80007a78:	0024849b          	addiw	s1,s1,2
    80007a7c:	07000713          	li	a4,112
    80007a80:	00998933          	add	s2,s3,s1
    80007a84:	38e78a63          	beq	a5,a4,80007e18 <__printf+0x460>
    80007a88:	20f76863          	bltu	a4,a5,80007c98 <__printf+0x2e0>
    80007a8c:	42a78863          	beq	a5,a0,80007ebc <__printf+0x504>
    80007a90:	06400713          	li	a4,100
    80007a94:	40e79663          	bne	a5,a4,80007ea0 <__printf+0x4e8>
    80007a98:	f7843783          	ld	a5,-136(s0)
    80007a9c:	0007a603          	lw	a2,0(a5)
    80007aa0:	00878793          	addi	a5,a5,8
    80007aa4:	f6f43c23          	sd	a5,-136(s0)
    80007aa8:	42064a63          	bltz	a2,80007edc <__printf+0x524>
    80007aac:	00a00713          	li	a4,10
    80007ab0:	02e677bb          	remuw	a5,a2,a4
    80007ab4:	00002d97          	auipc	s11,0x2
    80007ab8:	c64d8d93          	addi	s11,s11,-924 # 80009718 <digits>
    80007abc:	00900593          	li	a1,9
    80007ac0:	0006051b          	sext.w	a0,a2
    80007ac4:	00000c93          	li	s9,0
    80007ac8:	02079793          	slli	a5,a5,0x20
    80007acc:	0207d793          	srli	a5,a5,0x20
    80007ad0:	00fd87b3          	add	a5,s11,a5
    80007ad4:	0007c783          	lbu	a5,0(a5)
    80007ad8:	02e656bb          	divuw	a3,a2,a4
    80007adc:	f8f40023          	sb	a5,-128(s0)
    80007ae0:	14c5d863          	bge	a1,a2,80007c30 <__printf+0x278>
    80007ae4:	06300593          	li	a1,99
    80007ae8:	00100c93          	li	s9,1
    80007aec:	02e6f7bb          	remuw	a5,a3,a4
    80007af0:	02079793          	slli	a5,a5,0x20
    80007af4:	0207d793          	srli	a5,a5,0x20
    80007af8:	00fd87b3          	add	a5,s11,a5
    80007afc:	0007c783          	lbu	a5,0(a5)
    80007b00:	02e6d73b          	divuw	a4,a3,a4
    80007b04:	f8f400a3          	sb	a5,-127(s0)
    80007b08:	12a5f463          	bgeu	a1,a0,80007c30 <__printf+0x278>
    80007b0c:	00a00693          	li	a3,10
    80007b10:	00900593          	li	a1,9
    80007b14:	02d777bb          	remuw	a5,a4,a3
    80007b18:	02079793          	slli	a5,a5,0x20
    80007b1c:	0207d793          	srli	a5,a5,0x20
    80007b20:	00fd87b3          	add	a5,s11,a5
    80007b24:	0007c503          	lbu	a0,0(a5)
    80007b28:	02d757bb          	divuw	a5,a4,a3
    80007b2c:	f8a40123          	sb	a0,-126(s0)
    80007b30:	48e5f263          	bgeu	a1,a4,80007fb4 <__printf+0x5fc>
    80007b34:	06300513          	li	a0,99
    80007b38:	02d7f5bb          	remuw	a1,a5,a3
    80007b3c:	02059593          	slli	a1,a1,0x20
    80007b40:	0205d593          	srli	a1,a1,0x20
    80007b44:	00bd85b3          	add	a1,s11,a1
    80007b48:	0005c583          	lbu	a1,0(a1)
    80007b4c:	02d7d7bb          	divuw	a5,a5,a3
    80007b50:	f8b401a3          	sb	a1,-125(s0)
    80007b54:	48e57263          	bgeu	a0,a4,80007fd8 <__printf+0x620>
    80007b58:	3e700513          	li	a0,999
    80007b5c:	02d7f5bb          	remuw	a1,a5,a3
    80007b60:	02059593          	slli	a1,a1,0x20
    80007b64:	0205d593          	srli	a1,a1,0x20
    80007b68:	00bd85b3          	add	a1,s11,a1
    80007b6c:	0005c583          	lbu	a1,0(a1)
    80007b70:	02d7d7bb          	divuw	a5,a5,a3
    80007b74:	f8b40223          	sb	a1,-124(s0)
    80007b78:	46e57663          	bgeu	a0,a4,80007fe4 <__printf+0x62c>
    80007b7c:	02d7f5bb          	remuw	a1,a5,a3
    80007b80:	02059593          	slli	a1,a1,0x20
    80007b84:	0205d593          	srli	a1,a1,0x20
    80007b88:	00bd85b3          	add	a1,s11,a1
    80007b8c:	0005c583          	lbu	a1,0(a1)
    80007b90:	02d7d7bb          	divuw	a5,a5,a3
    80007b94:	f8b402a3          	sb	a1,-123(s0)
    80007b98:	46ea7863          	bgeu	s4,a4,80008008 <__printf+0x650>
    80007b9c:	02d7f5bb          	remuw	a1,a5,a3
    80007ba0:	02059593          	slli	a1,a1,0x20
    80007ba4:	0205d593          	srli	a1,a1,0x20
    80007ba8:	00bd85b3          	add	a1,s11,a1
    80007bac:	0005c583          	lbu	a1,0(a1)
    80007bb0:	02d7d7bb          	divuw	a5,a5,a3
    80007bb4:	f8b40323          	sb	a1,-122(s0)
    80007bb8:	3eeaf863          	bgeu	s5,a4,80007fa8 <__printf+0x5f0>
    80007bbc:	02d7f5bb          	remuw	a1,a5,a3
    80007bc0:	02059593          	slli	a1,a1,0x20
    80007bc4:	0205d593          	srli	a1,a1,0x20
    80007bc8:	00bd85b3          	add	a1,s11,a1
    80007bcc:	0005c583          	lbu	a1,0(a1)
    80007bd0:	02d7d7bb          	divuw	a5,a5,a3
    80007bd4:	f8b403a3          	sb	a1,-121(s0)
    80007bd8:	42eb7e63          	bgeu	s6,a4,80008014 <__printf+0x65c>
    80007bdc:	02d7f5bb          	remuw	a1,a5,a3
    80007be0:	02059593          	slli	a1,a1,0x20
    80007be4:	0205d593          	srli	a1,a1,0x20
    80007be8:	00bd85b3          	add	a1,s11,a1
    80007bec:	0005c583          	lbu	a1,0(a1)
    80007bf0:	02d7d7bb          	divuw	a5,a5,a3
    80007bf4:	f8b40423          	sb	a1,-120(s0)
    80007bf8:	42ebfc63          	bgeu	s7,a4,80008030 <__printf+0x678>
    80007bfc:	02079793          	slli	a5,a5,0x20
    80007c00:	0207d793          	srli	a5,a5,0x20
    80007c04:	00fd8db3          	add	s11,s11,a5
    80007c08:	000dc703          	lbu	a4,0(s11)
    80007c0c:	00a00793          	li	a5,10
    80007c10:	00900c93          	li	s9,9
    80007c14:	f8e404a3          	sb	a4,-119(s0)
    80007c18:	00065c63          	bgez	a2,80007c30 <__printf+0x278>
    80007c1c:	f9040713          	addi	a4,s0,-112
    80007c20:	00f70733          	add	a4,a4,a5
    80007c24:	02d00693          	li	a3,45
    80007c28:	fed70823          	sb	a3,-16(a4)
    80007c2c:	00078c93          	mv	s9,a5
    80007c30:	f8040793          	addi	a5,s0,-128
    80007c34:	01978cb3          	add	s9,a5,s9
    80007c38:	f7f40d13          	addi	s10,s0,-129
    80007c3c:	000cc503          	lbu	a0,0(s9)
    80007c40:	fffc8c93          	addi	s9,s9,-1
    80007c44:	00000097          	auipc	ra,0x0
    80007c48:	b90080e7          	jalr	-1136(ra) # 800077d4 <consputc>
    80007c4c:	ffac98e3          	bne	s9,s10,80007c3c <__printf+0x284>
    80007c50:	00094503          	lbu	a0,0(s2)
    80007c54:	e00514e3          	bnez	a0,80007a5c <__printf+0xa4>
    80007c58:	1a0c1663          	bnez	s8,80007e04 <__printf+0x44c>
    80007c5c:	08813083          	ld	ra,136(sp)
    80007c60:	08013403          	ld	s0,128(sp)
    80007c64:	07813483          	ld	s1,120(sp)
    80007c68:	07013903          	ld	s2,112(sp)
    80007c6c:	06813983          	ld	s3,104(sp)
    80007c70:	06013a03          	ld	s4,96(sp)
    80007c74:	05813a83          	ld	s5,88(sp)
    80007c78:	05013b03          	ld	s6,80(sp)
    80007c7c:	04813b83          	ld	s7,72(sp)
    80007c80:	04013c03          	ld	s8,64(sp)
    80007c84:	03813c83          	ld	s9,56(sp)
    80007c88:	03013d03          	ld	s10,48(sp)
    80007c8c:	02813d83          	ld	s11,40(sp)
    80007c90:	0d010113          	addi	sp,sp,208
    80007c94:	00008067          	ret
    80007c98:	07300713          	li	a4,115
    80007c9c:	1ce78a63          	beq	a5,a4,80007e70 <__printf+0x4b8>
    80007ca0:	07800713          	li	a4,120
    80007ca4:	1ee79e63          	bne	a5,a4,80007ea0 <__printf+0x4e8>
    80007ca8:	f7843783          	ld	a5,-136(s0)
    80007cac:	0007a703          	lw	a4,0(a5)
    80007cb0:	00878793          	addi	a5,a5,8
    80007cb4:	f6f43c23          	sd	a5,-136(s0)
    80007cb8:	28074263          	bltz	a4,80007f3c <__printf+0x584>
    80007cbc:	00002d97          	auipc	s11,0x2
    80007cc0:	a5cd8d93          	addi	s11,s11,-1444 # 80009718 <digits>
    80007cc4:	00f77793          	andi	a5,a4,15
    80007cc8:	00fd87b3          	add	a5,s11,a5
    80007ccc:	0007c683          	lbu	a3,0(a5)
    80007cd0:	00f00613          	li	a2,15
    80007cd4:	0007079b          	sext.w	a5,a4
    80007cd8:	f8d40023          	sb	a3,-128(s0)
    80007cdc:	0047559b          	srliw	a1,a4,0x4
    80007ce0:	0047569b          	srliw	a3,a4,0x4
    80007ce4:	00000c93          	li	s9,0
    80007ce8:	0ee65063          	bge	a2,a4,80007dc8 <__printf+0x410>
    80007cec:	00f6f693          	andi	a3,a3,15
    80007cf0:	00dd86b3          	add	a3,s11,a3
    80007cf4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007cf8:	0087d79b          	srliw	a5,a5,0x8
    80007cfc:	00100c93          	li	s9,1
    80007d00:	f8d400a3          	sb	a3,-127(s0)
    80007d04:	0cb67263          	bgeu	a2,a1,80007dc8 <__printf+0x410>
    80007d08:	00f7f693          	andi	a3,a5,15
    80007d0c:	00dd86b3          	add	a3,s11,a3
    80007d10:	0006c583          	lbu	a1,0(a3)
    80007d14:	00f00613          	li	a2,15
    80007d18:	0047d69b          	srliw	a3,a5,0x4
    80007d1c:	f8b40123          	sb	a1,-126(s0)
    80007d20:	0047d593          	srli	a1,a5,0x4
    80007d24:	28f67e63          	bgeu	a2,a5,80007fc0 <__printf+0x608>
    80007d28:	00f6f693          	andi	a3,a3,15
    80007d2c:	00dd86b3          	add	a3,s11,a3
    80007d30:	0006c503          	lbu	a0,0(a3)
    80007d34:	0087d813          	srli	a6,a5,0x8
    80007d38:	0087d69b          	srliw	a3,a5,0x8
    80007d3c:	f8a401a3          	sb	a0,-125(s0)
    80007d40:	28b67663          	bgeu	a2,a1,80007fcc <__printf+0x614>
    80007d44:	00f6f693          	andi	a3,a3,15
    80007d48:	00dd86b3          	add	a3,s11,a3
    80007d4c:	0006c583          	lbu	a1,0(a3)
    80007d50:	00c7d513          	srli	a0,a5,0xc
    80007d54:	00c7d69b          	srliw	a3,a5,0xc
    80007d58:	f8b40223          	sb	a1,-124(s0)
    80007d5c:	29067a63          	bgeu	a2,a6,80007ff0 <__printf+0x638>
    80007d60:	00f6f693          	andi	a3,a3,15
    80007d64:	00dd86b3          	add	a3,s11,a3
    80007d68:	0006c583          	lbu	a1,0(a3)
    80007d6c:	0107d813          	srli	a6,a5,0x10
    80007d70:	0107d69b          	srliw	a3,a5,0x10
    80007d74:	f8b402a3          	sb	a1,-123(s0)
    80007d78:	28a67263          	bgeu	a2,a0,80007ffc <__printf+0x644>
    80007d7c:	00f6f693          	andi	a3,a3,15
    80007d80:	00dd86b3          	add	a3,s11,a3
    80007d84:	0006c683          	lbu	a3,0(a3)
    80007d88:	0147d79b          	srliw	a5,a5,0x14
    80007d8c:	f8d40323          	sb	a3,-122(s0)
    80007d90:	21067663          	bgeu	a2,a6,80007f9c <__printf+0x5e4>
    80007d94:	02079793          	slli	a5,a5,0x20
    80007d98:	0207d793          	srli	a5,a5,0x20
    80007d9c:	00fd8db3          	add	s11,s11,a5
    80007da0:	000dc683          	lbu	a3,0(s11)
    80007da4:	00800793          	li	a5,8
    80007da8:	00700c93          	li	s9,7
    80007dac:	f8d403a3          	sb	a3,-121(s0)
    80007db0:	00075c63          	bgez	a4,80007dc8 <__printf+0x410>
    80007db4:	f9040713          	addi	a4,s0,-112
    80007db8:	00f70733          	add	a4,a4,a5
    80007dbc:	02d00693          	li	a3,45
    80007dc0:	fed70823          	sb	a3,-16(a4)
    80007dc4:	00078c93          	mv	s9,a5
    80007dc8:	f8040793          	addi	a5,s0,-128
    80007dcc:	01978cb3          	add	s9,a5,s9
    80007dd0:	f7f40d13          	addi	s10,s0,-129
    80007dd4:	000cc503          	lbu	a0,0(s9)
    80007dd8:	fffc8c93          	addi	s9,s9,-1
    80007ddc:	00000097          	auipc	ra,0x0
    80007de0:	9f8080e7          	jalr	-1544(ra) # 800077d4 <consputc>
    80007de4:	ff9d18e3          	bne	s10,s9,80007dd4 <__printf+0x41c>
    80007de8:	0100006f          	j	80007df8 <__printf+0x440>
    80007dec:	00000097          	auipc	ra,0x0
    80007df0:	9e8080e7          	jalr	-1560(ra) # 800077d4 <consputc>
    80007df4:	000c8493          	mv	s1,s9
    80007df8:	00094503          	lbu	a0,0(s2)
    80007dfc:	c60510e3          	bnez	a0,80007a5c <__printf+0xa4>
    80007e00:	e40c0ee3          	beqz	s8,80007c5c <__printf+0x2a4>
    80007e04:	00009517          	auipc	a0,0x9
    80007e08:	64c50513          	addi	a0,a0,1612 # 80011450 <pr>
    80007e0c:	00001097          	auipc	ra,0x1
    80007e10:	94c080e7          	jalr	-1716(ra) # 80008758 <release>
    80007e14:	e49ff06f          	j	80007c5c <__printf+0x2a4>
    80007e18:	f7843783          	ld	a5,-136(s0)
    80007e1c:	03000513          	li	a0,48
    80007e20:	01000d13          	li	s10,16
    80007e24:	00878713          	addi	a4,a5,8
    80007e28:	0007bc83          	ld	s9,0(a5)
    80007e2c:	f6e43c23          	sd	a4,-136(s0)
    80007e30:	00000097          	auipc	ra,0x0
    80007e34:	9a4080e7          	jalr	-1628(ra) # 800077d4 <consputc>
    80007e38:	07800513          	li	a0,120
    80007e3c:	00000097          	auipc	ra,0x0
    80007e40:	998080e7          	jalr	-1640(ra) # 800077d4 <consputc>
    80007e44:	00002d97          	auipc	s11,0x2
    80007e48:	8d4d8d93          	addi	s11,s11,-1836 # 80009718 <digits>
    80007e4c:	03ccd793          	srli	a5,s9,0x3c
    80007e50:	00fd87b3          	add	a5,s11,a5
    80007e54:	0007c503          	lbu	a0,0(a5)
    80007e58:	fffd0d1b          	addiw	s10,s10,-1
    80007e5c:	004c9c93          	slli	s9,s9,0x4
    80007e60:	00000097          	auipc	ra,0x0
    80007e64:	974080e7          	jalr	-1676(ra) # 800077d4 <consputc>
    80007e68:	fe0d12e3          	bnez	s10,80007e4c <__printf+0x494>
    80007e6c:	f8dff06f          	j	80007df8 <__printf+0x440>
    80007e70:	f7843783          	ld	a5,-136(s0)
    80007e74:	0007bc83          	ld	s9,0(a5)
    80007e78:	00878793          	addi	a5,a5,8
    80007e7c:	f6f43c23          	sd	a5,-136(s0)
    80007e80:	000c9a63          	bnez	s9,80007e94 <__printf+0x4dc>
    80007e84:	1080006f          	j	80007f8c <__printf+0x5d4>
    80007e88:	001c8c93          	addi	s9,s9,1
    80007e8c:	00000097          	auipc	ra,0x0
    80007e90:	948080e7          	jalr	-1720(ra) # 800077d4 <consputc>
    80007e94:	000cc503          	lbu	a0,0(s9)
    80007e98:	fe0518e3          	bnez	a0,80007e88 <__printf+0x4d0>
    80007e9c:	f5dff06f          	j	80007df8 <__printf+0x440>
    80007ea0:	02500513          	li	a0,37
    80007ea4:	00000097          	auipc	ra,0x0
    80007ea8:	930080e7          	jalr	-1744(ra) # 800077d4 <consputc>
    80007eac:	000c8513          	mv	a0,s9
    80007eb0:	00000097          	auipc	ra,0x0
    80007eb4:	924080e7          	jalr	-1756(ra) # 800077d4 <consputc>
    80007eb8:	f41ff06f          	j	80007df8 <__printf+0x440>
    80007ebc:	02500513          	li	a0,37
    80007ec0:	00000097          	auipc	ra,0x0
    80007ec4:	914080e7          	jalr	-1772(ra) # 800077d4 <consputc>
    80007ec8:	f31ff06f          	j	80007df8 <__printf+0x440>
    80007ecc:	00030513          	mv	a0,t1
    80007ed0:	00000097          	auipc	ra,0x0
    80007ed4:	7bc080e7          	jalr	1980(ra) # 8000868c <acquire>
    80007ed8:	b4dff06f          	j	80007a24 <__printf+0x6c>
    80007edc:	40c0053b          	negw	a0,a2
    80007ee0:	00a00713          	li	a4,10
    80007ee4:	02e576bb          	remuw	a3,a0,a4
    80007ee8:	00002d97          	auipc	s11,0x2
    80007eec:	830d8d93          	addi	s11,s11,-2000 # 80009718 <digits>
    80007ef0:	ff700593          	li	a1,-9
    80007ef4:	02069693          	slli	a3,a3,0x20
    80007ef8:	0206d693          	srli	a3,a3,0x20
    80007efc:	00dd86b3          	add	a3,s11,a3
    80007f00:	0006c683          	lbu	a3,0(a3)
    80007f04:	02e557bb          	divuw	a5,a0,a4
    80007f08:	f8d40023          	sb	a3,-128(s0)
    80007f0c:	10b65e63          	bge	a2,a1,80008028 <__printf+0x670>
    80007f10:	06300593          	li	a1,99
    80007f14:	02e7f6bb          	remuw	a3,a5,a4
    80007f18:	02069693          	slli	a3,a3,0x20
    80007f1c:	0206d693          	srli	a3,a3,0x20
    80007f20:	00dd86b3          	add	a3,s11,a3
    80007f24:	0006c683          	lbu	a3,0(a3)
    80007f28:	02e7d73b          	divuw	a4,a5,a4
    80007f2c:	00200793          	li	a5,2
    80007f30:	f8d400a3          	sb	a3,-127(s0)
    80007f34:	bca5ece3          	bltu	a1,a0,80007b0c <__printf+0x154>
    80007f38:	ce5ff06f          	j	80007c1c <__printf+0x264>
    80007f3c:	40e007bb          	negw	a5,a4
    80007f40:	00001d97          	auipc	s11,0x1
    80007f44:	7d8d8d93          	addi	s11,s11,2008 # 80009718 <digits>
    80007f48:	00f7f693          	andi	a3,a5,15
    80007f4c:	00dd86b3          	add	a3,s11,a3
    80007f50:	0006c583          	lbu	a1,0(a3)
    80007f54:	ff100613          	li	a2,-15
    80007f58:	0047d69b          	srliw	a3,a5,0x4
    80007f5c:	f8b40023          	sb	a1,-128(s0)
    80007f60:	0047d59b          	srliw	a1,a5,0x4
    80007f64:	0ac75e63          	bge	a4,a2,80008020 <__printf+0x668>
    80007f68:	00f6f693          	andi	a3,a3,15
    80007f6c:	00dd86b3          	add	a3,s11,a3
    80007f70:	0006c603          	lbu	a2,0(a3)
    80007f74:	00f00693          	li	a3,15
    80007f78:	0087d79b          	srliw	a5,a5,0x8
    80007f7c:	f8c400a3          	sb	a2,-127(s0)
    80007f80:	d8b6e4e3          	bltu	a3,a1,80007d08 <__printf+0x350>
    80007f84:	00200793          	li	a5,2
    80007f88:	e2dff06f          	j	80007db4 <__printf+0x3fc>
    80007f8c:	00001c97          	auipc	s9,0x1
    80007f90:	76cc8c93          	addi	s9,s9,1900 # 800096f8 <CONSOLE_STATUS+0x6e8>
    80007f94:	02800513          	li	a0,40
    80007f98:	ef1ff06f          	j	80007e88 <__printf+0x4d0>
    80007f9c:	00700793          	li	a5,7
    80007fa0:	00600c93          	li	s9,6
    80007fa4:	e0dff06f          	j	80007db0 <__printf+0x3f8>
    80007fa8:	00700793          	li	a5,7
    80007fac:	00600c93          	li	s9,6
    80007fb0:	c69ff06f          	j	80007c18 <__printf+0x260>
    80007fb4:	00300793          	li	a5,3
    80007fb8:	00200c93          	li	s9,2
    80007fbc:	c5dff06f          	j	80007c18 <__printf+0x260>
    80007fc0:	00300793          	li	a5,3
    80007fc4:	00200c93          	li	s9,2
    80007fc8:	de9ff06f          	j	80007db0 <__printf+0x3f8>
    80007fcc:	00400793          	li	a5,4
    80007fd0:	00300c93          	li	s9,3
    80007fd4:	dddff06f          	j	80007db0 <__printf+0x3f8>
    80007fd8:	00400793          	li	a5,4
    80007fdc:	00300c93          	li	s9,3
    80007fe0:	c39ff06f          	j	80007c18 <__printf+0x260>
    80007fe4:	00500793          	li	a5,5
    80007fe8:	00400c93          	li	s9,4
    80007fec:	c2dff06f          	j	80007c18 <__printf+0x260>
    80007ff0:	00500793          	li	a5,5
    80007ff4:	00400c93          	li	s9,4
    80007ff8:	db9ff06f          	j	80007db0 <__printf+0x3f8>
    80007ffc:	00600793          	li	a5,6
    80008000:	00500c93          	li	s9,5
    80008004:	dadff06f          	j	80007db0 <__printf+0x3f8>
    80008008:	00600793          	li	a5,6
    8000800c:	00500c93          	li	s9,5
    80008010:	c09ff06f          	j	80007c18 <__printf+0x260>
    80008014:	00800793          	li	a5,8
    80008018:	00700c93          	li	s9,7
    8000801c:	bfdff06f          	j	80007c18 <__printf+0x260>
    80008020:	00100793          	li	a5,1
    80008024:	d91ff06f          	j	80007db4 <__printf+0x3fc>
    80008028:	00100793          	li	a5,1
    8000802c:	bf1ff06f          	j	80007c1c <__printf+0x264>
    80008030:	00900793          	li	a5,9
    80008034:	00800c93          	li	s9,8
    80008038:	be1ff06f          	j	80007c18 <__printf+0x260>
    8000803c:	00001517          	auipc	a0,0x1
    80008040:	6c450513          	addi	a0,a0,1732 # 80009700 <CONSOLE_STATUS+0x6f0>
    80008044:	00000097          	auipc	ra,0x0
    80008048:	918080e7          	jalr	-1768(ra) # 8000795c <panic>

000000008000804c <printfinit>:
    8000804c:	fe010113          	addi	sp,sp,-32
    80008050:	00813823          	sd	s0,16(sp)
    80008054:	00913423          	sd	s1,8(sp)
    80008058:	00113c23          	sd	ra,24(sp)
    8000805c:	02010413          	addi	s0,sp,32
    80008060:	00009497          	auipc	s1,0x9
    80008064:	3f048493          	addi	s1,s1,1008 # 80011450 <pr>
    80008068:	00048513          	mv	a0,s1
    8000806c:	00001597          	auipc	a1,0x1
    80008070:	6a458593          	addi	a1,a1,1700 # 80009710 <CONSOLE_STATUS+0x700>
    80008074:	00000097          	auipc	ra,0x0
    80008078:	5f4080e7          	jalr	1524(ra) # 80008668 <initlock>
    8000807c:	01813083          	ld	ra,24(sp)
    80008080:	01013403          	ld	s0,16(sp)
    80008084:	0004ac23          	sw	zero,24(s1)
    80008088:	00813483          	ld	s1,8(sp)
    8000808c:	02010113          	addi	sp,sp,32
    80008090:	00008067          	ret

0000000080008094 <uartinit>:
    80008094:	ff010113          	addi	sp,sp,-16
    80008098:	00813423          	sd	s0,8(sp)
    8000809c:	01010413          	addi	s0,sp,16
    800080a0:	100007b7          	lui	a5,0x10000
    800080a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800080a8:	f8000713          	li	a4,-128
    800080ac:	00e781a3          	sb	a4,3(a5)
    800080b0:	00300713          	li	a4,3
    800080b4:	00e78023          	sb	a4,0(a5)
    800080b8:	000780a3          	sb	zero,1(a5)
    800080bc:	00e781a3          	sb	a4,3(a5)
    800080c0:	00700693          	li	a3,7
    800080c4:	00d78123          	sb	a3,2(a5)
    800080c8:	00e780a3          	sb	a4,1(a5)
    800080cc:	00813403          	ld	s0,8(sp)
    800080d0:	01010113          	addi	sp,sp,16
    800080d4:	00008067          	ret

00000000800080d8 <uartputc>:
    800080d8:	00004797          	auipc	a5,0x4
    800080dc:	ee07a783          	lw	a5,-288(a5) # 8000bfb8 <panicked>
    800080e0:	00078463          	beqz	a5,800080e8 <uartputc+0x10>
    800080e4:	0000006f          	j	800080e4 <uartputc+0xc>
    800080e8:	fd010113          	addi	sp,sp,-48
    800080ec:	02813023          	sd	s0,32(sp)
    800080f0:	00913c23          	sd	s1,24(sp)
    800080f4:	01213823          	sd	s2,16(sp)
    800080f8:	01313423          	sd	s3,8(sp)
    800080fc:	02113423          	sd	ra,40(sp)
    80008100:	03010413          	addi	s0,sp,48
    80008104:	00004917          	auipc	s2,0x4
    80008108:	ebc90913          	addi	s2,s2,-324 # 8000bfc0 <uart_tx_r>
    8000810c:	00093783          	ld	a5,0(s2)
    80008110:	00004497          	auipc	s1,0x4
    80008114:	eb848493          	addi	s1,s1,-328 # 8000bfc8 <uart_tx_w>
    80008118:	0004b703          	ld	a4,0(s1)
    8000811c:	02078693          	addi	a3,a5,32
    80008120:	00050993          	mv	s3,a0
    80008124:	02e69c63          	bne	a3,a4,8000815c <uartputc+0x84>
    80008128:	00001097          	auipc	ra,0x1
    8000812c:	834080e7          	jalr	-1996(ra) # 8000895c <push_on>
    80008130:	00093783          	ld	a5,0(s2)
    80008134:	0004b703          	ld	a4,0(s1)
    80008138:	02078793          	addi	a5,a5,32
    8000813c:	00e79463          	bne	a5,a4,80008144 <uartputc+0x6c>
    80008140:	0000006f          	j	80008140 <uartputc+0x68>
    80008144:	00001097          	auipc	ra,0x1
    80008148:	88c080e7          	jalr	-1908(ra) # 800089d0 <pop_on>
    8000814c:	00093783          	ld	a5,0(s2)
    80008150:	0004b703          	ld	a4,0(s1)
    80008154:	02078693          	addi	a3,a5,32
    80008158:	fce688e3          	beq	a3,a4,80008128 <uartputc+0x50>
    8000815c:	01f77693          	andi	a3,a4,31
    80008160:	00009597          	auipc	a1,0x9
    80008164:	31058593          	addi	a1,a1,784 # 80011470 <uart_tx_buf>
    80008168:	00d586b3          	add	a3,a1,a3
    8000816c:	00170713          	addi	a4,a4,1
    80008170:	01368023          	sb	s3,0(a3)
    80008174:	00e4b023          	sd	a4,0(s1)
    80008178:	10000637          	lui	a2,0x10000
    8000817c:	02f71063          	bne	a4,a5,8000819c <uartputc+0xc4>
    80008180:	0340006f          	j	800081b4 <uartputc+0xdc>
    80008184:	00074703          	lbu	a4,0(a4)
    80008188:	00f93023          	sd	a5,0(s2)
    8000818c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80008190:	00093783          	ld	a5,0(s2)
    80008194:	0004b703          	ld	a4,0(s1)
    80008198:	00f70e63          	beq	a4,a5,800081b4 <uartputc+0xdc>
    8000819c:	00564683          	lbu	a3,5(a2)
    800081a0:	01f7f713          	andi	a4,a5,31
    800081a4:	00e58733          	add	a4,a1,a4
    800081a8:	0206f693          	andi	a3,a3,32
    800081ac:	00178793          	addi	a5,a5,1
    800081b0:	fc069ae3          	bnez	a3,80008184 <uartputc+0xac>
    800081b4:	02813083          	ld	ra,40(sp)
    800081b8:	02013403          	ld	s0,32(sp)
    800081bc:	01813483          	ld	s1,24(sp)
    800081c0:	01013903          	ld	s2,16(sp)
    800081c4:	00813983          	ld	s3,8(sp)
    800081c8:	03010113          	addi	sp,sp,48
    800081cc:	00008067          	ret

00000000800081d0 <uartputc_sync>:
    800081d0:	ff010113          	addi	sp,sp,-16
    800081d4:	00813423          	sd	s0,8(sp)
    800081d8:	01010413          	addi	s0,sp,16
    800081dc:	00004717          	auipc	a4,0x4
    800081e0:	ddc72703          	lw	a4,-548(a4) # 8000bfb8 <panicked>
    800081e4:	02071663          	bnez	a4,80008210 <uartputc_sync+0x40>
    800081e8:	00050793          	mv	a5,a0
    800081ec:	100006b7          	lui	a3,0x10000
    800081f0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800081f4:	02077713          	andi	a4,a4,32
    800081f8:	fe070ce3          	beqz	a4,800081f0 <uartputc_sync+0x20>
    800081fc:	0ff7f793          	andi	a5,a5,255
    80008200:	00f68023          	sb	a5,0(a3)
    80008204:	00813403          	ld	s0,8(sp)
    80008208:	01010113          	addi	sp,sp,16
    8000820c:	00008067          	ret
    80008210:	0000006f          	j	80008210 <uartputc_sync+0x40>

0000000080008214 <uartstart>:
    80008214:	ff010113          	addi	sp,sp,-16
    80008218:	00813423          	sd	s0,8(sp)
    8000821c:	01010413          	addi	s0,sp,16
    80008220:	00004617          	auipc	a2,0x4
    80008224:	da060613          	addi	a2,a2,-608 # 8000bfc0 <uart_tx_r>
    80008228:	00004517          	auipc	a0,0x4
    8000822c:	da050513          	addi	a0,a0,-608 # 8000bfc8 <uart_tx_w>
    80008230:	00063783          	ld	a5,0(a2)
    80008234:	00053703          	ld	a4,0(a0)
    80008238:	04f70263          	beq	a4,a5,8000827c <uartstart+0x68>
    8000823c:	100005b7          	lui	a1,0x10000
    80008240:	00009817          	auipc	a6,0x9
    80008244:	23080813          	addi	a6,a6,560 # 80011470 <uart_tx_buf>
    80008248:	01c0006f          	j	80008264 <uartstart+0x50>
    8000824c:	0006c703          	lbu	a4,0(a3)
    80008250:	00f63023          	sd	a5,0(a2)
    80008254:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008258:	00063783          	ld	a5,0(a2)
    8000825c:	00053703          	ld	a4,0(a0)
    80008260:	00f70e63          	beq	a4,a5,8000827c <uartstart+0x68>
    80008264:	01f7f713          	andi	a4,a5,31
    80008268:	00e806b3          	add	a3,a6,a4
    8000826c:	0055c703          	lbu	a4,5(a1)
    80008270:	00178793          	addi	a5,a5,1
    80008274:	02077713          	andi	a4,a4,32
    80008278:	fc071ae3          	bnez	a4,8000824c <uartstart+0x38>
    8000827c:	00813403          	ld	s0,8(sp)
    80008280:	01010113          	addi	sp,sp,16
    80008284:	00008067          	ret

0000000080008288 <uartgetc>:
    80008288:	ff010113          	addi	sp,sp,-16
    8000828c:	00813423          	sd	s0,8(sp)
    80008290:	01010413          	addi	s0,sp,16
    80008294:	10000737          	lui	a4,0x10000
    80008298:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000829c:	0017f793          	andi	a5,a5,1
    800082a0:	00078c63          	beqz	a5,800082b8 <uartgetc+0x30>
    800082a4:	00074503          	lbu	a0,0(a4)
    800082a8:	0ff57513          	andi	a0,a0,255
    800082ac:	00813403          	ld	s0,8(sp)
    800082b0:	01010113          	addi	sp,sp,16
    800082b4:	00008067          	ret
    800082b8:	fff00513          	li	a0,-1
    800082bc:	ff1ff06f          	j	800082ac <uartgetc+0x24>

00000000800082c0 <uartintr>:
    800082c0:	100007b7          	lui	a5,0x10000
    800082c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800082c8:	0017f793          	andi	a5,a5,1
    800082cc:	0a078463          	beqz	a5,80008374 <uartintr+0xb4>
    800082d0:	fe010113          	addi	sp,sp,-32
    800082d4:	00813823          	sd	s0,16(sp)
    800082d8:	00913423          	sd	s1,8(sp)
    800082dc:	00113c23          	sd	ra,24(sp)
    800082e0:	02010413          	addi	s0,sp,32
    800082e4:	100004b7          	lui	s1,0x10000
    800082e8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800082ec:	0ff57513          	andi	a0,a0,255
    800082f0:	fffff097          	auipc	ra,0xfffff
    800082f4:	534080e7          	jalr	1332(ra) # 80007824 <consoleintr>
    800082f8:	0054c783          	lbu	a5,5(s1)
    800082fc:	0017f793          	andi	a5,a5,1
    80008300:	fe0794e3          	bnez	a5,800082e8 <uartintr+0x28>
    80008304:	00004617          	auipc	a2,0x4
    80008308:	cbc60613          	addi	a2,a2,-836 # 8000bfc0 <uart_tx_r>
    8000830c:	00004517          	auipc	a0,0x4
    80008310:	cbc50513          	addi	a0,a0,-836 # 8000bfc8 <uart_tx_w>
    80008314:	00063783          	ld	a5,0(a2)
    80008318:	00053703          	ld	a4,0(a0)
    8000831c:	04f70263          	beq	a4,a5,80008360 <uartintr+0xa0>
    80008320:	100005b7          	lui	a1,0x10000
    80008324:	00009817          	auipc	a6,0x9
    80008328:	14c80813          	addi	a6,a6,332 # 80011470 <uart_tx_buf>
    8000832c:	01c0006f          	j	80008348 <uartintr+0x88>
    80008330:	0006c703          	lbu	a4,0(a3)
    80008334:	00f63023          	sd	a5,0(a2)
    80008338:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000833c:	00063783          	ld	a5,0(a2)
    80008340:	00053703          	ld	a4,0(a0)
    80008344:	00f70e63          	beq	a4,a5,80008360 <uartintr+0xa0>
    80008348:	01f7f713          	andi	a4,a5,31
    8000834c:	00e806b3          	add	a3,a6,a4
    80008350:	0055c703          	lbu	a4,5(a1)
    80008354:	00178793          	addi	a5,a5,1
    80008358:	02077713          	andi	a4,a4,32
    8000835c:	fc071ae3          	bnez	a4,80008330 <uartintr+0x70>
    80008360:	01813083          	ld	ra,24(sp)
    80008364:	01013403          	ld	s0,16(sp)
    80008368:	00813483          	ld	s1,8(sp)
    8000836c:	02010113          	addi	sp,sp,32
    80008370:	00008067          	ret
    80008374:	00004617          	auipc	a2,0x4
    80008378:	c4c60613          	addi	a2,a2,-948 # 8000bfc0 <uart_tx_r>
    8000837c:	00004517          	auipc	a0,0x4
    80008380:	c4c50513          	addi	a0,a0,-948 # 8000bfc8 <uart_tx_w>
    80008384:	00063783          	ld	a5,0(a2)
    80008388:	00053703          	ld	a4,0(a0)
    8000838c:	04f70263          	beq	a4,a5,800083d0 <uartintr+0x110>
    80008390:	100005b7          	lui	a1,0x10000
    80008394:	00009817          	auipc	a6,0x9
    80008398:	0dc80813          	addi	a6,a6,220 # 80011470 <uart_tx_buf>
    8000839c:	01c0006f          	j	800083b8 <uartintr+0xf8>
    800083a0:	0006c703          	lbu	a4,0(a3)
    800083a4:	00f63023          	sd	a5,0(a2)
    800083a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800083ac:	00063783          	ld	a5,0(a2)
    800083b0:	00053703          	ld	a4,0(a0)
    800083b4:	02f70063          	beq	a4,a5,800083d4 <uartintr+0x114>
    800083b8:	01f7f713          	andi	a4,a5,31
    800083bc:	00e806b3          	add	a3,a6,a4
    800083c0:	0055c703          	lbu	a4,5(a1)
    800083c4:	00178793          	addi	a5,a5,1
    800083c8:	02077713          	andi	a4,a4,32
    800083cc:	fc071ae3          	bnez	a4,800083a0 <uartintr+0xe0>
    800083d0:	00008067          	ret
    800083d4:	00008067          	ret

00000000800083d8 <kinit>:
    800083d8:	fc010113          	addi	sp,sp,-64
    800083dc:	02913423          	sd	s1,40(sp)
    800083e0:	fffff7b7          	lui	a5,0xfffff
    800083e4:	0000a497          	auipc	s1,0xa
    800083e8:	0ab48493          	addi	s1,s1,171 # 8001248f <end+0xfff>
    800083ec:	02813823          	sd	s0,48(sp)
    800083f0:	01313c23          	sd	s3,24(sp)
    800083f4:	00f4f4b3          	and	s1,s1,a5
    800083f8:	02113c23          	sd	ra,56(sp)
    800083fc:	03213023          	sd	s2,32(sp)
    80008400:	01413823          	sd	s4,16(sp)
    80008404:	01513423          	sd	s5,8(sp)
    80008408:	04010413          	addi	s0,sp,64
    8000840c:	000017b7          	lui	a5,0x1
    80008410:	01100993          	li	s3,17
    80008414:	00f487b3          	add	a5,s1,a5
    80008418:	01b99993          	slli	s3,s3,0x1b
    8000841c:	06f9e063          	bltu	s3,a5,8000847c <kinit+0xa4>
    80008420:	00009a97          	auipc	s5,0x9
    80008424:	070a8a93          	addi	s5,s5,112 # 80011490 <end>
    80008428:	0754ec63          	bltu	s1,s5,800084a0 <kinit+0xc8>
    8000842c:	0734fa63          	bgeu	s1,s3,800084a0 <kinit+0xc8>
    80008430:	00088a37          	lui	s4,0x88
    80008434:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008438:	00004917          	auipc	s2,0x4
    8000843c:	b9890913          	addi	s2,s2,-1128 # 8000bfd0 <kmem>
    80008440:	00ca1a13          	slli	s4,s4,0xc
    80008444:	0140006f          	j	80008458 <kinit+0x80>
    80008448:	000017b7          	lui	a5,0x1
    8000844c:	00f484b3          	add	s1,s1,a5
    80008450:	0554e863          	bltu	s1,s5,800084a0 <kinit+0xc8>
    80008454:	0534f663          	bgeu	s1,s3,800084a0 <kinit+0xc8>
    80008458:	00001637          	lui	a2,0x1
    8000845c:	00100593          	li	a1,1
    80008460:	00048513          	mv	a0,s1
    80008464:	00000097          	auipc	ra,0x0
    80008468:	5e4080e7          	jalr	1508(ra) # 80008a48 <__memset>
    8000846c:	00093783          	ld	a5,0(s2)
    80008470:	00f4b023          	sd	a5,0(s1)
    80008474:	00993023          	sd	s1,0(s2)
    80008478:	fd4498e3          	bne	s1,s4,80008448 <kinit+0x70>
    8000847c:	03813083          	ld	ra,56(sp)
    80008480:	03013403          	ld	s0,48(sp)
    80008484:	02813483          	ld	s1,40(sp)
    80008488:	02013903          	ld	s2,32(sp)
    8000848c:	01813983          	ld	s3,24(sp)
    80008490:	01013a03          	ld	s4,16(sp)
    80008494:	00813a83          	ld	s5,8(sp)
    80008498:	04010113          	addi	sp,sp,64
    8000849c:	00008067          	ret
    800084a0:	00001517          	auipc	a0,0x1
    800084a4:	29050513          	addi	a0,a0,656 # 80009730 <digits+0x18>
    800084a8:	fffff097          	auipc	ra,0xfffff
    800084ac:	4b4080e7          	jalr	1204(ra) # 8000795c <panic>

00000000800084b0 <freerange>:
    800084b0:	fc010113          	addi	sp,sp,-64
    800084b4:	000017b7          	lui	a5,0x1
    800084b8:	02913423          	sd	s1,40(sp)
    800084bc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800084c0:	009504b3          	add	s1,a0,s1
    800084c4:	fffff537          	lui	a0,0xfffff
    800084c8:	02813823          	sd	s0,48(sp)
    800084cc:	02113c23          	sd	ra,56(sp)
    800084d0:	03213023          	sd	s2,32(sp)
    800084d4:	01313c23          	sd	s3,24(sp)
    800084d8:	01413823          	sd	s4,16(sp)
    800084dc:	01513423          	sd	s5,8(sp)
    800084e0:	01613023          	sd	s6,0(sp)
    800084e4:	04010413          	addi	s0,sp,64
    800084e8:	00a4f4b3          	and	s1,s1,a0
    800084ec:	00f487b3          	add	a5,s1,a5
    800084f0:	06f5e463          	bltu	a1,a5,80008558 <freerange+0xa8>
    800084f4:	00009a97          	auipc	s5,0x9
    800084f8:	f9ca8a93          	addi	s5,s5,-100 # 80011490 <end>
    800084fc:	0954e263          	bltu	s1,s5,80008580 <freerange+0xd0>
    80008500:	01100993          	li	s3,17
    80008504:	01b99993          	slli	s3,s3,0x1b
    80008508:	0734fc63          	bgeu	s1,s3,80008580 <freerange+0xd0>
    8000850c:	00058a13          	mv	s4,a1
    80008510:	00004917          	auipc	s2,0x4
    80008514:	ac090913          	addi	s2,s2,-1344 # 8000bfd0 <kmem>
    80008518:	00002b37          	lui	s6,0x2
    8000851c:	0140006f          	j	80008530 <freerange+0x80>
    80008520:	000017b7          	lui	a5,0x1
    80008524:	00f484b3          	add	s1,s1,a5
    80008528:	0554ec63          	bltu	s1,s5,80008580 <freerange+0xd0>
    8000852c:	0534fa63          	bgeu	s1,s3,80008580 <freerange+0xd0>
    80008530:	00001637          	lui	a2,0x1
    80008534:	00100593          	li	a1,1
    80008538:	00048513          	mv	a0,s1
    8000853c:	00000097          	auipc	ra,0x0
    80008540:	50c080e7          	jalr	1292(ra) # 80008a48 <__memset>
    80008544:	00093703          	ld	a4,0(s2)
    80008548:	016487b3          	add	a5,s1,s6
    8000854c:	00e4b023          	sd	a4,0(s1)
    80008550:	00993023          	sd	s1,0(s2)
    80008554:	fcfa76e3          	bgeu	s4,a5,80008520 <freerange+0x70>
    80008558:	03813083          	ld	ra,56(sp)
    8000855c:	03013403          	ld	s0,48(sp)
    80008560:	02813483          	ld	s1,40(sp)
    80008564:	02013903          	ld	s2,32(sp)
    80008568:	01813983          	ld	s3,24(sp)
    8000856c:	01013a03          	ld	s4,16(sp)
    80008570:	00813a83          	ld	s5,8(sp)
    80008574:	00013b03          	ld	s6,0(sp)
    80008578:	04010113          	addi	sp,sp,64
    8000857c:	00008067          	ret
    80008580:	00001517          	auipc	a0,0x1
    80008584:	1b050513          	addi	a0,a0,432 # 80009730 <digits+0x18>
    80008588:	fffff097          	auipc	ra,0xfffff
    8000858c:	3d4080e7          	jalr	980(ra) # 8000795c <panic>

0000000080008590 <kfree>:
    80008590:	fe010113          	addi	sp,sp,-32
    80008594:	00813823          	sd	s0,16(sp)
    80008598:	00113c23          	sd	ra,24(sp)
    8000859c:	00913423          	sd	s1,8(sp)
    800085a0:	02010413          	addi	s0,sp,32
    800085a4:	03451793          	slli	a5,a0,0x34
    800085a8:	04079c63          	bnez	a5,80008600 <kfree+0x70>
    800085ac:	00009797          	auipc	a5,0x9
    800085b0:	ee478793          	addi	a5,a5,-284 # 80011490 <end>
    800085b4:	00050493          	mv	s1,a0
    800085b8:	04f56463          	bltu	a0,a5,80008600 <kfree+0x70>
    800085bc:	01100793          	li	a5,17
    800085c0:	01b79793          	slli	a5,a5,0x1b
    800085c4:	02f57e63          	bgeu	a0,a5,80008600 <kfree+0x70>
    800085c8:	00001637          	lui	a2,0x1
    800085cc:	00100593          	li	a1,1
    800085d0:	00000097          	auipc	ra,0x0
    800085d4:	478080e7          	jalr	1144(ra) # 80008a48 <__memset>
    800085d8:	00004797          	auipc	a5,0x4
    800085dc:	9f878793          	addi	a5,a5,-1544 # 8000bfd0 <kmem>
    800085e0:	0007b703          	ld	a4,0(a5)
    800085e4:	01813083          	ld	ra,24(sp)
    800085e8:	01013403          	ld	s0,16(sp)
    800085ec:	00e4b023          	sd	a4,0(s1)
    800085f0:	0097b023          	sd	s1,0(a5)
    800085f4:	00813483          	ld	s1,8(sp)
    800085f8:	02010113          	addi	sp,sp,32
    800085fc:	00008067          	ret
    80008600:	00001517          	auipc	a0,0x1
    80008604:	13050513          	addi	a0,a0,304 # 80009730 <digits+0x18>
    80008608:	fffff097          	auipc	ra,0xfffff
    8000860c:	354080e7          	jalr	852(ra) # 8000795c <panic>

0000000080008610 <kalloc>:
    80008610:	fe010113          	addi	sp,sp,-32
    80008614:	00813823          	sd	s0,16(sp)
    80008618:	00913423          	sd	s1,8(sp)
    8000861c:	00113c23          	sd	ra,24(sp)
    80008620:	02010413          	addi	s0,sp,32
    80008624:	00004797          	auipc	a5,0x4
    80008628:	9ac78793          	addi	a5,a5,-1620 # 8000bfd0 <kmem>
    8000862c:	0007b483          	ld	s1,0(a5)
    80008630:	02048063          	beqz	s1,80008650 <kalloc+0x40>
    80008634:	0004b703          	ld	a4,0(s1)
    80008638:	00001637          	lui	a2,0x1
    8000863c:	00500593          	li	a1,5
    80008640:	00048513          	mv	a0,s1
    80008644:	00e7b023          	sd	a4,0(a5)
    80008648:	00000097          	auipc	ra,0x0
    8000864c:	400080e7          	jalr	1024(ra) # 80008a48 <__memset>
    80008650:	01813083          	ld	ra,24(sp)
    80008654:	01013403          	ld	s0,16(sp)
    80008658:	00048513          	mv	a0,s1
    8000865c:	00813483          	ld	s1,8(sp)
    80008660:	02010113          	addi	sp,sp,32
    80008664:	00008067          	ret

0000000080008668 <initlock>:
    80008668:	ff010113          	addi	sp,sp,-16
    8000866c:	00813423          	sd	s0,8(sp)
    80008670:	01010413          	addi	s0,sp,16
    80008674:	00813403          	ld	s0,8(sp)
    80008678:	00b53423          	sd	a1,8(a0)
    8000867c:	00052023          	sw	zero,0(a0)
    80008680:	00053823          	sd	zero,16(a0)
    80008684:	01010113          	addi	sp,sp,16
    80008688:	00008067          	ret

000000008000868c <acquire>:
    8000868c:	fe010113          	addi	sp,sp,-32
    80008690:	00813823          	sd	s0,16(sp)
    80008694:	00913423          	sd	s1,8(sp)
    80008698:	00113c23          	sd	ra,24(sp)
    8000869c:	01213023          	sd	s2,0(sp)
    800086a0:	02010413          	addi	s0,sp,32
    800086a4:	00050493          	mv	s1,a0
    800086a8:	10002973          	csrr	s2,sstatus
    800086ac:	100027f3          	csrr	a5,sstatus
    800086b0:	ffd7f793          	andi	a5,a5,-3
    800086b4:	10079073          	csrw	sstatus,a5
    800086b8:	fffff097          	auipc	ra,0xfffff
    800086bc:	8ec080e7          	jalr	-1812(ra) # 80006fa4 <mycpu>
    800086c0:	07852783          	lw	a5,120(a0)
    800086c4:	06078e63          	beqz	a5,80008740 <acquire+0xb4>
    800086c8:	fffff097          	auipc	ra,0xfffff
    800086cc:	8dc080e7          	jalr	-1828(ra) # 80006fa4 <mycpu>
    800086d0:	07852783          	lw	a5,120(a0)
    800086d4:	0004a703          	lw	a4,0(s1)
    800086d8:	0017879b          	addiw	a5,a5,1
    800086dc:	06f52c23          	sw	a5,120(a0)
    800086e0:	04071063          	bnez	a4,80008720 <acquire+0x94>
    800086e4:	00100713          	li	a4,1
    800086e8:	00070793          	mv	a5,a4
    800086ec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800086f0:	0007879b          	sext.w	a5,a5
    800086f4:	fe079ae3          	bnez	a5,800086e8 <acquire+0x5c>
    800086f8:	0ff0000f          	fence
    800086fc:	fffff097          	auipc	ra,0xfffff
    80008700:	8a8080e7          	jalr	-1880(ra) # 80006fa4 <mycpu>
    80008704:	01813083          	ld	ra,24(sp)
    80008708:	01013403          	ld	s0,16(sp)
    8000870c:	00a4b823          	sd	a0,16(s1)
    80008710:	00013903          	ld	s2,0(sp)
    80008714:	00813483          	ld	s1,8(sp)
    80008718:	02010113          	addi	sp,sp,32
    8000871c:	00008067          	ret
    80008720:	0104b903          	ld	s2,16(s1)
    80008724:	fffff097          	auipc	ra,0xfffff
    80008728:	880080e7          	jalr	-1920(ra) # 80006fa4 <mycpu>
    8000872c:	faa91ce3          	bne	s2,a0,800086e4 <acquire+0x58>
    80008730:	00001517          	auipc	a0,0x1
    80008734:	00850513          	addi	a0,a0,8 # 80009738 <digits+0x20>
    80008738:	fffff097          	auipc	ra,0xfffff
    8000873c:	224080e7          	jalr	548(ra) # 8000795c <panic>
    80008740:	00195913          	srli	s2,s2,0x1
    80008744:	fffff097          	auipc	ra,0xfffff
    80008748:	860080e7          	jalr	-1952(ra) # 80006fa4 <mycpu>
    8000874c:	00197913          	andi	s2,s2,1
    80008750:	07252e23          	sw	s2,124(a0)
    80008754:	f75ff06f          	j	800086c8 <acquire+0x3c>

0000000080008758 <release>:
    80008758:	fe010113          	addi	sp,sp,-32
    8000875c:	00813823          	sd	s0,16(sp)
    80008760:	00113c23          	sd	ra,24(sp)
    80008764:	00913423          	sd	s1,8(sp)
    80008768:	01213023          	sd	s2,0(sp)
    8000876c:	02010413          	addi	s0,sp,32
    80008770:	00052783          	lw	a5,0(a0)
    80008774:	00079a63          	bnez	a5,80008788 <release+0x30>
    80008778:	00001517          	auipc	a0,0x1
    8000877c:	fc850513          	addi	a0,a0,-56 # 80009740 <digits+0x28>
    80008780:	fffff097          	auipc	ra,0xfffff
    80008784:	1dc080e7          	jalr	476(ra) # 8000795c <panic>
    80008788:	01053903          	ld	s2,16(a0)
    8000878c:	00050493          	mv	s1,a0
    80008790:	fffff097          	auipc	ra,0xfffff
    80008794:	814080e7          	jalr	-2028(ra) # 80006fa4 <mycpu>
    80008798:	fea910e3          	bne	s2,a0,80008778 <release+0x20>
    8000879c:	0004b823          	sd	zero,16(s1)
    800087a0:	0ff0000f          	fence
    800087a4:	0f50000f          	fence	iorw,ow
    800087a8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800087ac:	ffffe097          	auipc	ra,0xffffe
    800087b0:	7f8080e7          	jalr	2040(ra) # 80006fa4 <mycpu>
    800087b4:	100027f3          	csrr	a5,sstatus
    800087b8:	0027f793          	andi	a5,a5,2
    800087bc:	04079a63          	bnez	a5,80008810 <release+0xb8>
    800087c0:	07852783          	lw	a5,120(a0)
    800087c4:	02f05e63          	blez	a5,80008800 <release+0xa8>
    800087c8:	fff7871b          	addiw	a4,a5,-1
    800087cc:	06e52c23          	sw	a4,120(a0)
    800087d0:	00071c63          	bnez	a4,800087e8 <release+0x90>
    800087d4:	07c52783          	lw	a5,124(a0)
    800087d8:	00078863          	beqz	a5,800087e8 <release+0x90>
    800087dc:	100027f3          	csrr	a5,sstatus
    800087e0:	0027e793          	ori	a5,a5,2
    800087e4:	10079073          	csrw	sstatus,a5
    800087e8:	01813083          	ld	ra,24(sp)
    800087ec:	01013403          	ld	s0,16(sp)
    800087f0:	00813483          	ld	s1,8(sp)
    800087f4:	00013903          	ld	s2,0(sp)
    800087f8:	02010113          	addi	sp,sp,32
    800087fc:	00008067          	ret
    80008800:	00001517          	auipc	a0,0x1
    80008804:	f6050513          	addi	a0,a0,-160 # 80009760 <digits+0x48>
    80008808:	fffff097          	auipc	ra,0xfffff
    8000880c:	154080e7          	jalr	340(ra) # 8000795c <panic>
    80008810:	00001517          	auipc	a0,0x1
    80008814:	f3850513          	addi	a0,a0,-200 # 80009748 <digits+0x30>
    80008818:	fffff097          	auipc	ra,0xfffff
    8000881c:	144080e7          	jalr	324(ra) # 8000795c <panic>

0000000080008820 <holding>:
    80008820:	00052783          	lw	a5,0(a0)
    80008824:	00079663          	bnez	a5,80008830 <holding+0x10>
    80008828:	00000513          	li	a0,0
    8000882c:	00008067          	ret
    80008830:	fe010113          	addi	sp,sp,-32
    80008834:	00813823          	sd	s0,16(sp)
    80008838:	00913423          	sd	s1,8(sp)
    8000883c:	00113c23          	sd	ra,24(sp)
    80008840:	02010413          	addi	s0,sp,32
    80008844:	01053483          	ld	s1,16(a0)
    80008848:	ffffe097          	auipc	ra,0xffffe
    8000884c:	75c080e7          	jalr	1884(ra) # 80006fa4 <mycpu>
    80008850:	01813083          	ld	ra,24(sp)
    80008854:	01013403          	ld	s0,16(sp)
    80008858:	40a48533          	sub	a0,s1,a0
    8000885c:	00153513          	seqz	a0,a0
    80008860:	00813483          	ld	s1,8(sp)
    80008864:	02010113          	addi	sp,sp,32
    80008868:	00008067          	ret

000000008000886c <push_off>:
    8000886c:	fe010113          	addi	sp,sp,-32
    80008870:	00813823          	sd	s0,16(sp)
    80008874:	00113c23          	sd	ra,24(sp)
    80008878:	00913423          	sd	s1,8(sp)
    8000887c:	02010413          	addi	s0,sp,32
    80008880:	100024f3          	csrr	s1,sstatus
    80008884:	100027f3          	csrr	a5,sstatus
    80008888:	ffd7f793          	andi	a5,a5,-3
    8000888c:	10079073          	csrw	sstatus,a5
    80008890:	ffffe097          	auipc	ra,0xffffe
    80008894:	714080e7          	jalr	1812(ra) # 80006fa4 <mycpu>
    80008898:	07852783          	lw	a5,120(a0)
    8000889c:	02078663          	beqz	a5,800088c8 <push_off+0x5c>
    800088a0:	ffffe097          	auipc	ra,0xffffe
    800088a4:	704080e7          	jalr	1796(ra) # 80006fa4 <mycpu>
    800088a8:	07852783          	lw	a5,120(a0)
    800088ac:	01813083          	ld	ra,24(sp)
    800088b0:	01013403          	ld	s0,16(sp)
    800088b4:	0017879b          	addiw	a5,a5,1
    800088b8:	06f52c23          	sw	a5,120(a0)
    800088bc:	00813483          	ld	s1,8(sp)
    800088c0:	02010113          	addi	sp,sp,32
    800088c4:	00008067          	ret
    800088c8:	0014d493          	srli	s1,s1,0x1
    800088cc:	ffffe097          	auipc	ra,0xffffe
    800088d0:	6d8080e7          	jalr	1752(ra) # 80006fa4 <mycpu>
    800088d4:	0014f493          	andi	s1,s1,1
    800088d8:	06952e23          	sw	s1,124(a0)
    800088dc:	fc5ff06f          	j	800088a0 <push_off+0x34>

00000000800088e0 <pop_off>:
    800088e0:	ff010113          	addi	sp,sp,-16
    800088e4:	00813023          	sd	s0,0(sp)
    800088e8:	00113423          	sd	ra,8(sp)
    800088ec:	01010413          	addi	s0,sp,16
    800088f0:	ffffe097          	auipc	ra,0xffffe
    800088f4:	6b4080e7          	jalr	1716(ra) # 80006fa4 <mycpu>
    800088f8:	100027f3          	csrr	a5,sstatus
    800088fc:	0027f793          	andi	a5,a5,2
    80008900:	04079663          	bnez	a5,8000894c <pop_off+0x6c>
    80008904:	07852783          	lw	a5,120(a0)
    80008908:	02f05a63          	blez	a5,8000893c <pop_off+0x5c>
    8000890c:	fff7871b          	addiw	a4,a5,-1
    80008910:	06e52c23          	sw	a4,120(a0)
    80008914:	00071c63          	bnez	a4,8000892c <pop_off+0x4c>
    80008918:	07c52783          	lw	a5,124(a0)
    8000891c:	00078863          	beqz	a5,8000892c <pop_off+0x4c>
    80008920:	100027f3          	csrr	a5,sstatus
    80008924:	0027e793          	ori	a5,a5,2
    80008928:	10079073          	csrw	sstatus,a5
    8000892c:	00813083          	ld	ra,8(sp)
    80008930:	00013403          	ld	s0,0(sp)
    80008934:	01010113          	addi	sp,sp,16
    80008938:	00008067          	ret
    8000893c:	00001517          	auipc	a0,0x1
    80008940:	e2450513          	addi	a0,a0,-476 # 80009760 <digits+0x48>
    80008944:	fffff097          	auipc	ra,0xfffff
    80008948:	018080e7          	jalr	24(ra) # 8000795c <panic>
    8000894c:	00001517          	auipc	a0,0x1
    80008950:	dfc50513          	addi	a0,a0,-516 # 80009748 <digits+0x30>
    80008954:	fffff097          	auipc	ra,0xfffff
    80008958:	008080e7          	jalr	8(ra) # 8000795c <panic>

000000008000895c <push_on>:
    8000895c:	fe010113          	addi	sp,sp,-32
    80008960:	00813823          	sd	s0,16(sp)
    80008964:	00113c23          	sd	ra,24(sp)
    80008968:	00913423          	sd	s1,8(sp)
    8000896c:	02010413          	addi	s0,sp,32
    80008970:	100024f3          	csrr	s1,sstatus
    80008974:	100027f3          	csrr	a5,sstatus
    80008978:	0027e793          	ori	a5,a5,2
    8000897c:	10079073          	csrw	sstatus,a5
    80008980:	ffffe097          	auipc	ra,0xffffe
    80008984:	624080e7          	jalr	1572(ra) # 80006fa4 <mycpu>
    80008988:	07852783          	lw	a5,120(a0)
    8000898c:	02078663          	beqz	a5,800089b8 <push_on+0x5c>
    80008990:	ffffe097          	auipc	ra,0xffffe
    80008994:	614080e7          	jalr	1556(ra) # 80006fa4 <mycpu>
    80008998:	07852783          	lw	a5,120(a0)
    8000899c:	01813083          	ld	ra,24(sp)
    800089a0:	01013403          	ld	s0,16(sp)
    800089a4:	0017879b          	addiw	a5,a5,1
    800089a8:	06f52c23          	sw	a5,120(a0)
    800089ac:	00813483          	ld	s1,8(sp)
    800089b0:	02010113          	addi	sp,sp,32
    800089b4:	00008067          	ret
    800089b8:	0014d493          	srli	s1,s1,0x1
    800089bc:	ffffe097          	auipc	ra,0xffffe
    800089c0:	5e8080e7          	jalr	1512(ra) # 80006fa4 <mycpu>
    800089c4:	0014f493          	andi	s1,s1,1
    800089c8:	06952e23          	sw	s1,124(a0)
    800089cc:	fc5ff06f          	j	80008990 <push_on+0x34>

00000000800089d0 <pop_on>:
    800089d0:	ff010113          	addi	sp,sp,-16
    800089d4:	00813023          	sd	s0,0(sp)
    800089d8:	00113423          	sd	ra,8(sp)
    800089dc:	01010413          	addi	s0,sp,16
    800089e0:	ffffe097          	auipc	ra,0xffffe
    800089e4:	5c4080e7          	jalr	1476(ra) # 80006fa4 <mycpu>
    800089e8:	100027f3          	csrr	a5,sstatus
    800089ec:	0027f793          	andi	a5,a5,2
    800089f0:	04078463          	beqz	a5,80008a38 <pop_on+0x68>
    800089f4:	07852783          	lw	a5,120(a0)
    800089f8:	02f05863          	blez	a5,80008a28 <pop_on+0x58>
    800089fc:	fff7879b          	addiw	a5,a5,-1
    80008a00:	06f52c23          	sw	a5,120(a0)
    80008a04:	07853783          	ld	a5,120(a0)
    80008a08:	00079863          	bnez	a5,80008a18 <pop_on+0x48>
    80008a0c:	100027f3          	csrr	a5,sstatus
    80008a10:	ffd7f793          	andi	a5,a5,-3
    80008a14:	10079073          	csrw	sstatus,a5
    80008a18:	00813083          	ld	ra,8(sp)
    80008a1c:	00013403          	ld	s0,0(sp)
    80008a20:	01010113          	addi	sp,sp,16
    80008a24:	00008067          	ret
    80008a28:	00001517          	auipc	a0,0x1
    80008a2c:	d6050513          	addi	a0,a0,-672 # 80009788 <digits+0x70>
    80008a30:	fffff097          	auipc	ra,0xfffff
    80008a34:	f2c080e7          	jalr	-212(ra) # 8000795c <panic>
    80008a38:	00001517          	auipc	a0,0x1
    80008a3c:	d3050513          	addi	a0,a0,-720 # 80009768 <digits+0x50>
    80008a40:	fffff097          	auipc	ra,0xfffff
    80008a44:	f1c080e7          	jalr	-228(ra) # 8000795c <panic>

0000000080008a48 <__memset>:
    80008a48:	ff010113          	addi	sp,sp,-16
    80008a4c:	00813423          	sd	s0,8(sp)
    80008a50:	01010413          	addi	s0,sp,16
    80008a54:	1a060e63          	beqz	a2,80008c10 <__memset+0x1c8>
    80008a58:	40a007b3          	neg	a5,a0
    80008a5c:	0077f793          	andi	a5,a5,7
    80008a60:	00778693          	addi	a3,a5,7
    80008a64:	00b00813          	li	a6,11
    80008a68:	0ff5f593          	andi	a1,a1,255
    80008a6c:	fff6071b          	addiw	a4,a2,-1
    80008a70:	1b06e663          	bltu	a3,a6,80008c1c <__memset+0x1d4>
    80008a74:	1cd76463          	bltu	a4,a3,80008c3c <__memset+0x1f4>
    80008a78:	1a078e63          	beqz	a5,80008c34 <__memset+0x1ec>
    80008a7c:	00b50023          	sb	a1,0(a0)
    80008a80:	00100713          	li	a4,1
    80008a84:	1ae78463          	beq	a5,a4,80008c2c <__memset+0x1e4>
    80008a88:	00b500a3          	sb	a1,1(a0)
    80008a8c:	00200713          	li	a4,2
    80008a90:	1ae78a63          	beq	a5,a4,80008c44 <__memset+0x1fc>
    80008a94:	00b50123          	sb	a1,2(a0)
    80008a98:	00300713          	li	a4,3
    80008a9c:	18e78463          	beq	a5,a4,80008c24 <__memset+0x1dc>
    80008aa0:	00b501a3          	sb	a1,3(a0)
    80008aa4:	00400713          	li	a4,4
    80008aa8:	1ae78263          	beq	a5,a4,80008c4c <__memset+0x204>
    80008aac:	00b50223          	sb	a1,4(a0)
    80008ab0:	00500713          	li	a4,5
    80008ab4:	1ae78063          	beq	a5,a4,80008c54 <__memset+0x20c>
    80008ab8:	00b502a3          	sb	a1,5(a0)
    80008abc:	00700713          	li	a4,7
    80008ac0:	18e79e63          	bne	a5,a4,80008c5c <__memset+0x214>
    80008ac4:	00b50323          	sb	a1,6(a0)
    80008ac8:	00700e93          	li	t4,7
    80008acc:	00859713          	slli	a4,a1,0x8
    80008ad0:	00e5e733          	or	a4,a1,a4
    80008ad4:	01059e13          	slli	t3,a1,0x10
    80008ad8:	01c76e33          	or	t3,a4,t3
    80008adc:	01859313          	slli	t1,a1,0x18
    80008ae0:	006e6333          	or	t1,t3,t1
    80008ae4:	02059893          	slli	a7,a1,0x20
    80008ae8:	40f60e3b          	subw	t3,a2,a5
    80008aec:	011368b3          	or	a7,t1,a7
    80008af0:	02859813          	slli	a6,a1,0x28
    80008af4:	0108e833          	or	a6,a7,a6
    80008af8:	03059693          	slli	a3,a1,0x30
    80008afc:	003e589b          	srliw	a7,t3,0x3
    80008b00:	00d866b3          	or	a3,a6,a3
    80008b04:	03859713          	slli	a4,a1,0x38
    80008b08:	00389813          	slli	a6,a7,0x3
    80008b0c:	00f507b3          	add	a5,a0,a5
    80008b10:	00e6e733          	or	a4,a3,a4
    80008b14:	000e089b          	sext.w	a7,t3
    80008b18:	00f806b3          	add	a3,a6,a5
    80008b1c:	00e7b023          	sd	a4,0(a5)
    80008b20:	00878793          	addi	a5,a5,8
    80008b24:	fed79ce3          	bne	a5,a3,80008b1c <__memset+0xd4>
    80008b28:	ff8e7793          	andi	a5,t3,-8
    80008b2c:	0007871b          	sext.w	a4,a5
    80008b30:	01d787bb          	addw	a5,a5,t4
    80008b34:	0ce88e63          	beq	a7,a4,80008c10 <__memset+0x1c8>
    80008b38:	00f50733          	add	a4,a0,a5
    80008b3c:	00b70023          	sb	a1,0(a4)
    80008b40:	0017871b          	addiw	a4,a5,1
    80008b44:	0cc77663          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008b48:	00e50733          	add	a4,a0,a4
    80008b4c:	00b70023          	sb	a1,0(a4)
    80008b50:	0027871b          	addiw	a4,a5,2
    80008b54:	0ac77e63          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008b58:	00e50733          	add	a4,a0,a4
    80008b5c:	00b70023          	sb	a1,0(a4)
    80008b60:	0037871b          	addiw	a4,a5,3
    80008b64:	0ac77663          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008b68:	00e50733          	add	a4,a0,a4
    80008b6c:	00b70023          	sb	a1,0(a4)
    80008b70:	0047871b          	addiw	a4,a5,4
    80008b74:	08c77e63          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008b78:	00e50733          	add	a4,a0,a4
    80008b7c:	00b70023          	sb	a1,0(a4)
    80008b80:	0057871b          	addiw	a4,a5,5
    80008b84:	08c77663          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008b88:	00e50733          	add	a4,a0,a4
    80008b8c:	00b70023          	sb	a1,0(a4)
    80008b90:	0067871b          	addiw	a4,a5,6
    80008b94:	06c77e63          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008b98:	00e50733          	add	a4,a0,a4
    80008b9c:	00b70023          	sb	a1,0(a4)
    80008ba0:	0077871b          	addiw	a4,a5,7
    80008ba4:	06c77663          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008ba8:	00e50733          	add	a4,a0,a4
    80008bac:	00b70023          	sb	a1,0(a4)
    80008bb0:	0087871b          	addiw	a4,a5,8
    80008bb4:	04c77e63          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008bb8:	00e50733          	add	a4,a0,a4
    80008bbc:	00b70023          	sb	a1,0(a4)
    80008bc0:	0097871b          	addiw	a4,a5,9
    80008bc4:	04c77663          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008bc8:	00e50733          	add	a4,a0,a4
    80008bcc:	00b70023          	sb	a1,0(a4)
    80008bd0:	00a7871b          	addiw	a4,a5,10
    80008bd4:	02c77e63          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008bd8:	00e50733          	add	a4,a0,a4
    80008bdc:	00b70023          	sb	a1,0(a4)
    80008be0:	00b7871b          	addiw	a4,a5,11
    80008be4:	02c77663          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008be8:	00e50733          	add	a4,a0,a4
    80008bec:	00b70023          	sb	a1,0(a4)
    80008bf0:	00c7871b          	addiw	a4,a5,12
    80008bf4:	00c77e63          	bgeu	a4,a2,80008c10 <__memset+0x1c8>
    80008bf8:	00e50733          	add	a4,a0,a4
    80008bfc:	00b70023          	sb	a1,0(a4)
    80008c00:	00d7879b          	addiw	a5,a5,13
    80008c04:	00c7f663          	bgeu	a5,a2,80008c10 <__memset+0x1c8>
    80008c08:	00f507b3          	add	a5,a0,a5
    80008c0c:	00b78023          	sb	a1,0(a5)
    80008c10:	00813403          	ld	s0,8(sp)
    80008c14:	01010113          	addi	sp,sp,16
    80008c18:	00008067          	ret
    80008c1c:	00b00693          	li	a3,11
    80008c20:	e55ff06f          	j	80008a74 <__memset+0x2c>
    80008c24:	00300e93          	li	t4,3
    80008c28:	ea5ff06f          	j	80008acc <__memset+0x84>
    80008c2c:	00100e93          	li	t4,1
    80008c30:	e9dff06f          	j	80008acc <__memset+0x84>
    80008c34:	00000e93          	li	t4,0
    80008c38:	e95ff06f          	j	80008acc <__memset+0x84>
    80008c3c:	00000793          	li	a5,0
    80008c40:	ef9ff06f          	j	80008b38 <__memset+0xf0>
    80008c44:	00200e93          	li	t4,2
    80008c48:	e85ff06f          	j	80008acc <__memset+0x84>
    80008c4c:	00400e93          	li	t4,4
    80008c50:	e7dff06f          	j	80008acc <__memset+0x84>
    80008c54:	00500e93          	li	t4,5
    80008c58:	e75ff06f          	j	80008acc <__memset+0x84>
    80008c5c:	00600e93          	li	t4,6
    80008c60:	e6dff06f          	j	80008acc <__memset+0x84>

0000000080008c64 <__memmove>:
    80008c64:	ff010113          	addi	sp,sp,-16
    80008c68:	00813423          	sd	s0,8(sp)
    80008c6c:	01010413          	addi	s0,sp,16
    80008c70:	0e060863          	beqz	a2,80008d60 <__memmove+0xfc>
    80008c74:	fff6069b          	addiw	a3,a2,-1
    80008c78:	0006881b          	sext.w	a6,a3
    80008c7c:	0ea5e863          	bltu	a1,a0,80008d6c <__memmove+0x108>
    80008c80:	00758713          	addi	a4,a1,7
    80008c84:	00a5e7b3          	or	a5,a1,a0
    80008c88:	40a70733          	sub	a4,a4,a0
    80008c8c:	0077f793          	andi	a5,a5,7
    80008c90:	00f73713          	sltiu	a4,a4,15
    80008c94:	00174713          	xori	a4,a4,1
    80008c98:	0017b793          	seqz	a5,a5
    80008c9c:	00e7f7b3          	and	a5,a5,a4
    80008ca0:	10078863          	beqz	a5,80008db0 <__memmove+0x14c>
    80008ca4:	00900793          	li	a5,9
    80008ca8:	1107f463          	bgeu	a5,a6,80008db0 <__memmove+0x14c>
    80008cac:	0036581b          	srliw	a6,a2,0x3
    80008cb0:	fff8081b          	addiw	a6,a6,-1
    80008cb4:	02081813          	slli	a6,a6,0x20
    80008cb8:	01d85893          	srli	a7,a6,0x1d
    80008cbc:	00858813          	addi	a6,a1,8
    80008cc0:	00058793          	mv	a5,a1
    80008cc4:	00050713          	mv	a4,a0
    80008cc8:	01088833          	add	a6,a7,a6
    80008ccc:	0007b883          	ld	a7,0(a5)
    80008cd0:	00878793          	addi	a5,a5,8
    80008cd4:	00870713          	addi	a4,a4,8
    80008cd8:	ff173c23          	sd	a7,-8(a4)
    80008cdc:	ff0798e3          	bne	a5,a6,80008ccc <__memmove+0x68>
    80008ce0:	ff867713          	andi	a4,a2,-8
    80008ce4:	02071793          	slli	a5,a4,0x20
    80008ce8:	0207d793          	srli	a5,a5,0x20
    80008cec:	00f585b3          	add	a1,a1,a5
    80008cf0:	40e686bb          	subw	a3,a3,a4
    80008cf4:	00f507b3          	add	a5,a0,a5
    80008cf8:	06e60463          	beq	a2,a4,80008d60 <__memmove+0xfc>
    80008cfc:	0005c703          	lbu	a4,0(a1)
    80008d00:	00e78023          	sb	a4,0(a5)
    80008d04:	04068e63          	beqz	a3,80008d60 <__memmove+0xfc>
    80008d08:	0015c603          	lbu	a2,1(a1)
    80008d0c:	00100713          	li	a4,1
    80008d10:	00c780a3          	sb	a2,1(a5)
    80008d14:	04e68663          	beq	a3,a4,80008d60 <__memmove+0xfc>
    80008d18:	0025c603          	lbu	a2,2(a1)
    80008d1c:	00200713          	li	a4,2
    80008d20:	00c78123          	sb	a2,2(a5)
    80008d24:	02e68e63          	beq	a3,a4,80008d60 <__memmove+0xfc>
    80008d28:	0035c603          	lbu	a2,3(a1)
    80008d2c:	00300713          	li	a4,3
    80008d30:	00c781a3          	sb	a2,3(a5)
    80008d34:	02e68663          	beq	a3,a4,80008d60 <__memmove+0xfc>
    80008d38:	0045c603          	lbu	a2,4(a1)
    80008d3c:	00400713          	li	a4,4
    80008d40:	00c78223          	sb	a2,4(a5)
    80008d44:	00e68e63          	beq	a3,a4,80008d60 <__memmove+0xfc>
    80008d48:	0055c603          	lbu	a2,5(a1)
    80008d4c:	00500713          	li	a4,5
    80008d50:	00c782a3          	sb	a2,5(a5)
    80008d54:	00e68663          	beq	a3,a4,80008d60 <__memmove+0xfc>
    80008d58:	0065c703          	lbu	a4,6(a1)
    80008d5c:	00e78323          	sb	a4,6(a5)
    80008d60:	00813403          	ld	s0,8(sp)
    80008d64:	01010113          	addi	sp,sp,16
    80008d68:	00008067          	ret
    80008d6c:	02061713          	slli	a4,a2,0x20
    80008d70:	02075713          	srli	a4,a4,0x20
    80008d74:	00e587b3          	add	a5,a1,a4
    80008d78:	f0f574e3          	bgeu	a0,a5,80008c80 <__memmove+0x1c>
    80008d7c:	02069613          	slli	a2,a3,0x20
    80008d80:	02065613          	srli	a2,a2,0x20
    80008d84:	fff64613          	not	a2,a2
    80008d88:	00e50733          	add	a4,a0,a4
    80008d8c:	00c78633          	add	a2,a5,a2
    80008d90:	fff7c683          	lbu	a3,-1(a5)
    80008d94:	fff78793          	addi	a5,a5,-1
    80008d98:	fff70713          	addi	a4,a4,-1
    80008d9c:	00d70023          	sb	a3,0(a4)
    80008da0:	fec798e3          	bne	a5,a2,80008d90 <__memmove+0x12c>
    80008da4:	00813403          	ld	s0,8(sp)
    80008da8:	01010113          	addi	sp,sp,16
    80008dac:	00008067          	ret
    80008db0:	02069713          	slli	a4,a3,0x20
    80008db4:	02075713          	srli	a4,a4,0x20
    80008db8:	00170713          	addi	a4,a4,1
    80008dbc:	00e50733          	add	a4,a0,a4
    80008dc0:	00050793          	mv	a5,a0
    80008dc4:	0005c683          	lbu	a3,0(a1)
    80008dc8:	00178793          	addi	a5,a5,1
    80008dcc:	00158593          	addi	a1,a1,1
    80008dd0:	fed78fa3          	sb	a3,-1(a5)
    80008dd4:	fee798e3          	bne	a5,a4,80008dc4 <__memmove+0x160>
    80008dd8:	f89ff06f          	j	80008d60 <__memmove+0xfc>
	...
