
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000d117          	auipc	sp,0xd
    80000004:	34013103          	ld	sp,832(sp) # 8000d340 <_GLOBAL_OFFSET_TABLE_+0x48>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	158070ef          	jal	ra,80007174 <start>

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
    800010a8:	240030ef          	jal	ra,800042e8 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001184:	2d0080e7          	jalr	720(ra) # 80002450 <_ZN5Buddy4freeEPvm>
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
    800011bc:	fe010113          	addi	sp,sp,-32
    800011c0:	00113c23          	sd	ra,24(sp)
    800011c4:	00813823          	sd	s0,16(sp)
    800011c8:	00913423          	sd	s1,8(sp)
    800011cc:	01213023          	sd	s2,0(sp)
    800011d0:	02010413          	addi	s0,sp,32
    800011d4:	00050913          	mv	s2,a0
    ConsoleUtil::print("Slab address:", (uint64)slab, "\n");
    800011d8:	00009617          	auipc	a2,0x9
    800011dc:	12060613          	addi	a2,a2,288 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800011e0:	0005059b          	sext.w	a1,a0
    800011e4:	00009517          	auipc	a0,0x9
    800011e8:	e3c50513          	addi	a0,a0,-452 # 8000a020 <CONSOLE_STATUS+0x10>
    800011ec:	00004097          	auipc	ra,0x4
    800011f0:	b78080e7          	jalr	-1160(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Number of slots:", (uint64)slab->totalNumOfSlots, "\n");
    800011f4:	00009617          	auipc	a2,0x9
    800011f8:	10460613          	addi	a2,a2,260 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800011fc:	01892583          	lw	a1,24(s2)
    80001200:	00009517          	auipc	a0,0x9
    80001204:	e3050513          	addi	a0,a0,-464 # 8000a030 <CONSOLE_STATUS+0x20>
    80001208:	00004097          	auipc	ra,0x4
    8000120c:	b5c080e7          	jalr	-1188(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab object size:", (uint64)sizeof(Slab), "\n");
    80001210:	00009617          	auipc	a2,0x9
    80001214:	0e860613          	addi	a2,a2,232 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001218:	03800593          	li	a1,56
    8000121c:	00009517          	auipc	a0,0x9
    80001220:	e2c50513          	addi	a0,a0,-468 # 8000a048 <CONSOLE_STATUS+0x38>
    80001224:	00004097          	auipc	ra,0x4
    80001228:	b40080e7          	jalr	-1216(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Object offset:", (uint64)slab->objectOffset, "\n");
    8000122c:	00009617          	auipc	a2,0x9
    80001230:	0cc60613          	addi	a2,a2,204 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001234:	02892583          	lw	a1,40(s2)
    80001238:	00009517          	auipc	a0,0x9
    8000123c:	e2850513          	addi	a0,a0,-472 # 8000a060 <CONSOLE_STATUS+0x50>
    80001240:	00004097          	auipc	ra,0x4
    80001244:	b24080e7          	jalr	-1244(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Slab allocated array address:", (uint64)slab->allocated, "\n");
    80001248:	00009617          	auipc	a2,0x9
    8000124c:	0b060613          	addi	a2,a2,176 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001250:	02092583          	lw	a1,32(s2)
    80001254:	00009517          	auipc	a0,0x9
    80001258:	e1c50513          	addi	a0,a0,-484 # 8000a070 <CONSOLE_STATUS+0x60>
    8000125c:	00004097          	auipc	ra,0x4
    80001260:	b08080e7          	jalr	-1272(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::printString("Allocated status array:\n");
    80001264:	00009517          	auipc	a0,0x9
    80001268:	e2c50513          	addi	a0,a0,-468 # 8000a090 <CONSOLE_STATUS+0x80>
    8000126c:	00004097          	auipc	ra,0x4
    80001270:	9d8080e7          	jalr	-1576(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    80001274:	00000493          	li	s1,0
    80001278:	01893783          	ld	a5,24(s2)
    8000127c:	02f4f863          	bgeu	s1,a5,800012ac <_ZN13SlabAllocator9printSlabEP4Slab+0xf0>
        ConsoleUtil::print("", (uint8)slab->allocated[i], " ");
    80001280:	02093783          	ld	a5,32(s2)
    80001284:	009787b3          	add	a5,a5,s1
    80001288:	00009617          	auipc	a2,0x9
    8000128c:	e4860613          	addi	a2,a2,-440 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    80001290:	0007c583          	lbu	a1,0(a5)
    80001294:	00009517          	auipc	a0,0x9
    80001298:	0a450513          	addi	a0,a0,164 # 8000a338 <CONSOLE_STATUS+0x328>
    8000129c:	00004097          	auipc	ra,0x4
    800012a0:	ac8080e7          	jalr	-1336(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    for(uint64 i=0;i<slab->totalNumOfSlots;i++){
    800012a4:	00148493          	addi	s1,s1,1
    800012a8:	fd1ff06f          	j	80001278 <_ZN13SlabAllocator9printSlabEP4Slab+0xbc>
    }
    ConsoleUtil::printString("\n");
    800012ac:	00009517          	auipc	a0,0x9
    800012b0:	04c50513          	addi	a0,a0,76 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800012b4:	00004097          	auipc	ra,0x4
    800012b8:	990080e7          	jalr	-1648(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
}
    800012bc:	01813083          	ld	ra,24(sp)
    800012c0:	01013403          	ld	s0,16(sp)
    800012c4:	00813483          	ld	s1,8(sp)
    800012c8:	00013903          	ld	s2,0(sp)
    800012cc:	02010113          	addi	sp,sp,32
    800012d0:	00008067          	ret

00000000800012d4 <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800012d4:	fe010113          	addi	sp,sp,-32
    800012d8:	00113c23          	sd	ra,24(sp)
    800012dc:	00813823          	sd	s0,16(sp)
    800012e0:	00913423          	sd	s1,8(sp)
    800012e4:	01213023          	sd	s2,0(sp)
    800012e8:	02010413          	addi	s0,sp,32
    800012ec:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    800012f0:	00009517          	auipc	a0,0x9
    800012f4:	dc050513          	addi	a0,a0,-576 # 8000a0b0 <CONSOLE_STATUS+0xa0>
    800012f8:	00004097          	auipc	ra,0x4
    800012fc:	94c080e7          	jalr	-1716(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001300:	00090513          	mv	a0,s2
    80001304:	00004097          	auipc	ra,0x4
    80001308:	940080e7          	jalr	-1728(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    8000130c:	00009517          	auipc	a0,0x9
    80001310:	fec50513          	addi	a0,a0,-20 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001314:	00004097          	auipc	ra,0x4
    80001318:	930080e7          	jalr	-1744(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    8000131c:	00009617          	auipc	a2,0x9
    80001320:	fdc60613          	addi	a2,a2,-36 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001324:	0000c797          	auipc	a5,0xc
    80001328:	fec7b783          	ld	a5,-20(a5) # 8000d310 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000132c:	0007a583          	lw	a1,0(a5)
    80001330:	00009517          	auipc	a0,0x9
    80001334:	d9050513          	addi	a0,a0,-624 # 8000a0c0 <CONSOLE_STATUS+0xb0>
    80001338:	00004097          	auipc	ra,0x4
    8000133c:	a2c080e7          	jalr	-1492(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    80001340:	00009617          	auipc	a2,0x9
    80001344:	fb860613          	addi	a2,a2,-72 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001348:	0009059b          	sext.w	a1,s2
    8000134c:	00009517          	auipc	a0,0x9
    80001350:	d8c50513          	addi	a0,a0,-628 # 8000a0d8 <CONSOLE_STATUS+0xc8>
    80001354:	00004097          	auipc	ra,0x4
    80001358:	a10080e7          	jalr	-1520(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    8000135c:	00009617          	auipc	a2,0x9
    80001360:	f9c60613          	addi	a2,a2,-100 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001364:	06092583          	lw	a1,96(s2)
    80001368:	00009517          	auipc	a0,0x9
    8000136c:	d8050513          	addi	a0,a0,-640 # 8000a0e8 <CONSOLE_STATUS+0xd8>
    80001370:	00004097          	auipc	ra,0x4
    80001374:	9f4080e7          	jalr	-1548(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>

    Slab* iter = cache->emptyHead;
    80001378:	06093483          	ld	s1,96(s2)
    while(iter){
    8000137c:	02048463          	beqz	s1,800013a4 <_ZN13SlabAllocator10printCacheEP5Cache+0xd0>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001380:	00009617          	auipc	a2,0x9
    80001384:	d5060613          	addi	a2,a2,-688 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    80001388:	0004859b          	sext.w	a1,s1
    8000138c:	00009517          	auipc	a0,0x9
    80001390:	fac50513          	addi	a0,a0,-84 # 8000a338 <CONSOLE_STATUS+0x328>
    80001394:	00004097          	auipc	ra,0x4
    80001398:	9d0080e7          	jalr	-1584(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    8000139c:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013a0:	fddff06f          	j	8000137c <_ZN13SlabAllocator10printCacheEP5Cache+0xa8>
    }
    ConsoleUtil::printString("\n");
    800013a4:	00009517          	auipc	a0,0x9
    800013a8:	f5450513          	addi	a0,a0,-172 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800013ac:	00004097          	auipc	ra,0x4
    800013b0:	898080e7          	jalr	-1896(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    800013b4:	00009617          	auipc	a2,0x9
    800013b8:	f4460613          	addi	a2,a2,-188 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800013bc:	06892583          	lw	a1,104(s2)
    800013c0:	00009517          	auipc	a0,0x9
    800013c4:	d3850513          	addi	a0,a0,-712 # 8000a0f8 <CONSOLE_STATUS+0xe8>
    800013c8:	00004097          	auipc	ra,0x4
    800013cc:	99c080e7          	jalr	-1636(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->partialHead;
    800013d0:	06893483          	ld	s1,104(s2)
    while(iter){
    800013d4:	02048463          	beqz	s1,800013fc <_ZN13SlabAllocator10printCacheEP5Cache+0x128>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013d8:	00009617          	auipc	a2,0x9
    800013dc:	cf860613          	addi	a2,a2,-776 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    800013e0:	0004859b          	sext.w	a1,s1
    800013e4:	00009517          	auipc	a0,0x9
    800013e8:	f5450513          	addi	a0,a0,-172 # 8000a338 <CONSOLE_STATUS+0x328>
    800013ec:	00004097          	auipc	ra,0x4
    800013f0:	978080e7          	jalr	-1672(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    800013f4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800013f8:	fddff06f          	j	800013d4 <_ZN13SlabAllocator10printCacheEP5Cache+0x100>
    }
    ConsoleUtil::printString("\n");
    800013fc:	00009517          	auipc	a0,0x9
    80001400:	efc50513          	addi	a0,a0,-260 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001404:	00004097          	auipc	ra,0x4
    80001408:	840080e7          	jalr	-1984(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    8000140c:	00009617          	auipc	a2,0x9
    80001410:	eec60613          	addi	a2,a2,-276 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80001414:	07092583          	lw	a1,112(s2)
    80001418:	00009517          	auipc	a0,0x9
    8000141c:	cf050513          	addi	a0,a0,-784 # 8000a108 <CONSOLE_STATUS+0xf8>
    80001420:	00004097          	auipc	ra,0x4
    80001424:	944080e7          	jalr	-1724(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>

    iter = cache->fullHead;
    80001428:	07093483          	ld	s1,112(s2)
    while(iter){
    8000142c:	02048463          	beqz	s1,80001454 <_ZN13SlabAllocator10printCacheEP5Cache+0x180>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001430:	00009617          	auipc	a2,0x9
    80001434:	ca060613          	addi	a2,a2,-864 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    80001438:	0004859b          	sext.w	a1,s1
    8000143c:	00009517          	auipc	a0,0x9
    80001440:	efc50513          	addi	a0,a0,-260 # 8000a338 <CONSOLE_STATUS+0x328>
    80001444:	00004097          	auipc	ra,0x4
    80001448:	920080e7          	jalr	-1760(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
        iter = iter->next;
    8000144c:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001450:	fddff06f          	j	8000142c <_ZN13SlabAllocator10printCacheEP5Cache+0x158>
    }
    ConsoleUtil::printString("\n");
    80001454:	00009517          	auipc	a0,0x9
    80001458:	ea450513          	addi	a0,a0,-348 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    8000145c:	00003097          	auipc	ra,0x3
    80001460:	7e8080e7          	jalr	2024(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Object size: ", (uint64)cache->objectSize, "\n");
    80001464:	00009617          	auipc	a2,0x9
    80001468:	e9460613          	addi	a2,a2,-364 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    8000146c:	04092583          	lw	a1,64(s2)
    80001470:	00009517          	auipc	a0,0x9
    80001474:	ca850513          	addi	a0,a0,-856 # 8000a118 <CONSOLE_STATUS+0x108>
    80001478:	00004097          	auipc	ra,0x4
    8000147c:	8ec080e7          	jalr	-1812(ra) # 80004d64 <_ZN11ConsoleUtil5printEPKciS1_>
}
    80001480:	01813083          	ld	ra,24(sp)
    80001484:	01013403          	ld	s0,16(sp)
    80001488:	00813483          	ld	s1,8(sp)
    8000148c:	00013903          	ld	s2,0(sp)
    80001490:	02010113          	addi	sp,sp,32
    80001494:	00008067          	ret

0000000080001498 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    80001498:	ff010113          	addi	sp,sp,-16
    8000149c:	00813423          	sd	s0,8(sp)
    800014a0:	01010413          	addi	s0,sp,16
    slab->next = head;
    800014a4:	00053783          	ld	a5,0(a0)
    800014a8:	00f5b423          	sd	a5,8(a1)
    if(head)
    800014ac:	00078463          	beqz	a5,800014b4 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    800014b0:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    800014b4:	0005b023          	sd	zero,0(a1)
    head = slab;
    800014b8:	00b53023          	sd	a1,0(a0)
}
    800014bc:	00813403          	ld	s0,8(sp)
    800014c0:	01010113          	addi	sp,sp,16
    800014c4:	00008067          	ret

00000000800014c8 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    800014c8:	fe010113          	addi	sp,sp,-32
    800014cc:	00113c23          	sd	ra,24(sp)
    800014d0:	00813823          	sd	s0,16(sp)
    800014d4:	00913423          	sd	s1,8(sp)
    800014d8:	01213023          	sd	s2,0(sp)
    800014dc:	02010413          	addi	s0,sp,32
    800014e0:	00050913          	mv	s2,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    800014e4:	04853503          	ld	a0,72(a0)
    800014e8:	00001097          	auipc	ra,0x1
    800014ec:	040080e7          	jalr	64(ra) # 80002528 <_ZN5Buddy5allocEm>
    if(!slab)
    800014f0:	06050863          	beqz	a0,80001560 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x98>
    800014f4:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    800014f8:	00050593          	mv	a1,a0
    800014fc:	06090513          	addi	a0,s2,96
    80001500:	00000097          	auipc	ra,0x0
    80001504:	f98080e7          	jalr	-104(ra) # 80001498 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001508:	04893783          	ld	a5,72(s2)
    8000150c:	00c79793          	slli	a5,a5,0xc
    80001510:	fc878793          	addi	a5,a5,-56
    80001514:	04093703          	ld	a4,64(s2)
    80001518:	02e7d7b3          	divu	a5,a5,a4
    8000151c:	00f4b823          	sd	a5,16(s1)
    80001520:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + (slab->totalNumOfSlots>>3) + 1);
    80001524:	0037d793          	srli	a5,a5,0x3
    80001528:	009787b3          	add	a5,a5,s1
    8000152c:	03978793          	addi	a5,a5,57
    80001530:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (bool*)((uint64)slab + sizeof(Slab));
    80001534:	03848793          	addi	a5,s1,56
    80001538:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    8000153c:	0324b823          	sd	s2,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001540:	00000793          	li	a5,0
    80001544:	0184b703          	ld	a4,24(s1)
    80001548:	02e7f063          	bgeu	a5,a4,80001568 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa0>
        slab->allocated[i] = false;
    8000154c:	0204b703          	ld	a4,32(s1)
    80001550:	00f70733          	add	a4,a4,a5
    80001554:	00070023          	sb	zero,0(a4)
    for(uint64 i=0;i<slab->totalNumOfSlots;i++)
    80001558:	00178793          	addi	a5,a5,1
    8000155c:	fe9ff06f          	j	80001544 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x7c>
        return false;
    80001560:	00000513          	li	a0,0
    80001564:	0080006f          	j	8000156c <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
    return true;
    80001568:	00100513          	li	a0,1
}
    8000156c:	01813083          	ld	ra,24(sp)
    80001570:	01013403          	ld	s0,16(sp)
    80001574:	00813483          	ld	s1,8(sp)
    80001578:	00013903          	ld	s2,0(sp)
    8000157c:	02010113          	addi	sp,sp,32
    80001580:	00008067          	ret

0000000080001584 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001584:	ff010113          	addi	sp,sp,-16
    80001588:	00813423          	sd	s0,8(sp)
    8000158c:	01010413          	addi	s0,sp,16
    if(slab == head)
    80001590:	00053783          	ld	a5,0(a0)
    80001594:	02b78c63          	beq	a5,a1,800015cc <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001598:	0085b783          	ld	a5,8(a1)
    8000159c:	00078663          	beqz	a5,800015a8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    800015a0:	0005b703          	ld	a4,0(a1)
    800015a4:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    800015a8:	0005b783          	ld	a5,0(a1)
    800015ac:	00078663          	beqz	a5,800015b8 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    800015b0:	0085b703          	ld	a4,8(a1)
    800015b4:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    800015b8:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    800015bc:	0005b423          	sd	zero,8(a1)
}
    800015c0:	00813403          	ld	s0,8(sp)
    800015c4:	01010113          	addi	sp,sp,16
    800015c8:	00008067          	ret
        head = slab->next;
    800015cc:	0085b783          	ld	a5,8(a1)
    800015d0:	00f53023          	sd	a5,0(a0)
    800015d4:	fc5ff06f          	j	80001598 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

00000000800015d8 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    800015d8:	fe010113          	addi	sp,sp,-32
    800015dc:	00113c23          	sd	ra,24(sp)
    800015e0:	00813823          	sd	s0,16(sp)
    800015e4:	00913423          	sd	s1,8(sp)
    800015e8:	01213023          	sd	s2,0(sp)
    800015ec:	02010413          	addi	s0,sp,32
    800015f0:	00058913          	mv	s2,a1
    800015f4:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800015f8:	00060593          	mv	a1,a2
    800015fc:	00000097          	auipc	ra,0x0
    80001600:	f88080e7          	jalr	-120(ra) # 80001584 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    80001604:	00048593          	mv	a1,s1
    80001608:	00090513          	mv	a0,s2
    8000160c:	00000097          	auipc	ra,0x0
    80001610:	e8c080e7          	jalr	-372(ra) # 80001498 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    80001614:	01813083          	ld	ra,24(sp)
    80001618:	01013403          	ld	s0,16(sp)
    8000161c:	00813483          	ld	s1,8(sp)
    80001620:	00013903          	ld	s2,0(sp)
    80001624:	02010113          	addi	sp,sp,32
    80001628:	00008067          	ret

000000008000162c <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    8000162c:	fe010113          	addi	sp,sp,-32
    80001630:	00113c23          	sd	ra,24(sp)
    80001634:	00813823          	sd	s0,16(sp)
    80001638:	00913423          	sd	s1,8(sp)
    8000163c:	01213023          	sd	s2,0(sp)
    80001640:	02010413          	addi	s0,sp,32
    80001644:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001648:	00000493          	li	s1,0
    8000164c:	01893783          	ld	a5,24(s2)
    80001650:	08f4fa63          	bgeu	s1,a5,800016e4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xb8>
        if(!slab->allocated[i]){
    80001654:	02093783          	ld	a5,32(s2)
    80001658:	009787b3          	add	a5,a5,s1
    8000165c:	0007c703          	lbu	a4,0(a5)
    80001660:	00070663          	beqz	a4,8000166c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x40>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001664:	00148493          	addi	s1,s1,1
    80001668:	fe5ff06f          	j	8000164c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i] = true;
    8000166c:	00100713          	li	a4,1
    80001670:	00e78023          	sb	a4,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001674:	01093783          	ld	a5,16(s2)
    80001678:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    8000167c:	04f70863          	beq	a4,a5,800016cc <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa0>
    80001680:	03093503          	ld	a0,48(s2)
    80001684:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001688:	fff78793          	addi	a5,a5,-1
    8000168c:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001690:	04079463          	bnez	a5,800016d8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xac>
    80001694:	03093583          	ld	a1,48(s2)
    80001698:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    8000169c:	0005b703          	ld	a4,0(a1)
    800016a0:	00053783          	ld	a5,0(a0)
    800016a4:	00f70863          	beq	a4,a5,800016b4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x88>
                SlabAllocator::move(headFrom, headTo, slab);
    800016a8:	00090613          	mv	a2,s2
    800016ac:	00000097          	auipc	ra,0x0
    800016b0:	f2c080e7          	jalr	-212(ra) # 800015d8 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    800016b4:	02893503          	ld	a0,40(s2)
    800016b8:	03093783          	ld	a5,48(s2)
    800016bc:	0407b783          	ld	a5,64(a5)
    800016c0:	029784b3          	mul	s1,a5,s1
    800016c4:	00950533          	add	a0,a0,s1
    800016c8:	0200006f          	j	800016e8 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800016cc:	03093503          	ld	a0,48(s2)
    800016d0:	06050513          	addi	a0,a0,96
    800016d4:	fb5ff06f          	j	80001688 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x5c>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800016d8:	03093583          	ld	a1,48(s2)
    800016dc:	06858593          	addi	a1,a1,104
    800016e0:	fbdff06f          	j	8000169c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x70>
    return nullptr;
    800016e4:	00000513          	li	a0,0
}
    800016e8:	01813083          	ld	ra,24(sp)
    800016ec:	01013403          	ld	s0,16(sp)
    800016f0:	00813483          	ld	s1,8(sp)
    800016f4:	00013903          	ld	s2,0(sp)
    800016f8:	02010113          	addi	sp,sp,32
    800016fc:	00008067          	ret

0000000080001700 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    80001700:	fe010113          	addi	sp,sp,-32
    80001704:	00113c23          	sd	ra,24(sp)
    80001708:	00813823          	sd	s0,16(sp)
    8000170c:	00913423          	sd	s1,8(sp)
    80001710:	01213023          	sd	s2,0(sp)
    80001714:	02010413          	addi	s0,sp,32
    80001718:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    8000171c:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    80001720:	00048c63          	beqz	s1,80001738 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    80001724:	00048513          	mv	a0,s1
    80001728:	00000097          	auipc	ra,0x0
    8000172c:	f04080e7          	jalr	-252(ra) # 8000162c <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001730:	fe0508e3          	beqz	a0,80001720 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    80001734:	00050493          	mv	s1,a0
    if(ret)
    80001738:	02048063          	beqz	s1,80001758 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    8000173c:	00048513          	mv	a0,s1
    80001740:	01813083          	ld	ra,24(sp)
    80001744:	01013403          	ld	s0,16(sp)
    80001748:	00813483          	ld	s1,8(sp)
    8000174c:	00013903          	ld	s2,0(sp)
    80001750:	02010113          	addi	sp,sp,32
    80001754:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80001758:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    8000175c:	00048c63          	beqz	s1,80001774 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80001760:	00048513          	mv	a0,s1
    80001764:	00000097          	auipc	ra,0x0
    80001768:	ec8080e7          	jalr	-312(ra) # 8000162c <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    8000176c:	fe0508e3          	beqz	a0,8000175c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001770:	00050493          	mv	s1,a0
    if(ret)
    80001774:	fc0494e3          	bnez	s1,8000173c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001778:	00090513          	mv	a0,s2
    8000177c:	00000097          	auipc	ra,0x0
    80001780:	d4c080e7          	jalr	-692(ra) # 800014c8 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    80001784:	fa050ce3          	beqz	a0,8000173c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001788:	06093503          	ld	a0,96(s2)
    8000178c:	00000097          	auipc	ra,0x0
    80001790:	ea0080e7          	jalr	-352(ra) # 8000162c <_ZN13SlabAllocator12allocateSlotEP4Slab>
    80001794:	00050493          	mv	s1,a0
    return ret;
    80001798:	fa5ff06f          	j	8000173c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

000000008000179c <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    8000179c:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    800017a0:	0017d513          	srli	a0,a5,0x1
    800017a4:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    800017a8:	0027d713          	srli	a4,a5,0x2
    800017ac:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    800017b0:	0047d713          	srli	a4,a5,0x4
    800017b4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    800017b8:	0087d713          	srli	a4,a5,0x8
    800017bc:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    800017c0:	0107d713          	srli	a4,a5,0x10
    800017c4:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    800017c8:	0207d713          	srli	a4,a5,0x20
    800017cc:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    800017d0:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800017d4:	00000713          	li	a4,0
        while(num>1){
    800017d8:	00100693          	li	a3,1
    800017dc:	00f6f863          	bgeu	a3,a5,800017ec <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    800017e0:	0017d793          	srli	a5,a5,0x1
            deg++;
    800017e4:	00170713          	addi	a4,a4,1
        while(num>1){
    800017e8:	ff1ff06f          	j	800017d8 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800017ec:	ffb70713          	addi	a4,a4,-5
    800017f0:	00c00793          	li	a5,12
    800017f4:	00e7f663          	bgeu	a5,a4,80001800 <_ZN13SlabAllocator14allocateBufferEm+0x64>
}
    800017f8:	00000513          	li	a0,0
    800017fc:	00008067          	ret
void* SlabAllocator::allocateBuffer(size_t size) {
    80001800:	ff010113          	addi	sp,sp,-16
    80001804:	00113423          	sd	ra,8(sp)
    80001808:	00813023          	sd	s0,0(sp)
    8000180c:	01010413          	addi	s0,sp,16
    SlabAllocator::allocateObject(sizeN[level]);
    80001810:	00371713          	slli	a4,a4,0x3
    80001814:	0000c797          	auipc	a5,0xc
    80001818:	bdc78793          	addi	a5,a5,-1060 # 8000d3f0 <_ZN13SlabAllocator5sizeNE>
    8000181c:	00e78733          	add	a4,a5,a4
    80001820:	00073503          	ld	a0,0(a4)
    80001824:	00000097          	auipc	ra,0x0
    80001828:	edc080e7          	jalr	-292(ra) # 80001700 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    8000182c:	00000513          	li	a0,0
    80001830:	00813083          	ld	ra,8(sp)
    80001834:	00013403          	ld	s0,0(sp)
    80001838:	01010113          	addi	sp,sp,16
    8000183c:	00008067          	ret

0000000080001840 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80001840:	fc010113          	addi	sp,sp,-64
    80001844:	02113c23          	sd	ra,56(sp)
    80001848:	02813823          	sd	s0,48(sp)
    8000184c:	02913423          	sd	s1,40(sp)
    80001850:	03213023          	sd	s2,32(sp)
    80001854:	01313c23          	sd	s3,24(sp)
    80001858:	01413823          	sd	s4,16(sp)
    8000185c:	01513423          	sd	s5,8(sp)
    80001860:	04010413          	addi	s0,sp,64
    80001864:	00050913          	mv	s2,a0
    80001868:	00058993          	mv	s3,a1
    8000186c:	00060a93          	mv	s5,a2
    80001870:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001874:	0000c517          	auipc	a0,0xc
    80001878:	be453503          	ld	a0,-1052(a0) # 8000d458 <_ZN13SlabAllocator5cacheE>
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	e84080e7          	jalr	-380(ra) # 80001700 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001884:	00050493          	mv	s1,a0
    ret->ctor = ctor;
    80001888:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    8000188c:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001890:	06053823          	sd	zero,112(a0)
    80001894:	06053423          	sd	zero,104(a0)
    80001898:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    8000189c:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    800018a0:	00200793          	li	a5,2
    800018a4:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    800018a8:	00050593          	mv	a1,a0
    800018ac:	00090513          	mv	a0,s2
    800018b0:	00003097          	auipc	ra,0x3
    800018b4:	e6c080e7          	jalr	-404(ra) # 8000471c <_Z6strcpyPKcPc>
}
    800018b8:	00048513          	mv	a0,s1
    800018bc:	03813083          	ld	ra,56(sp)
    800018c0:	03013403          	ld	s0,48(sp)
    800018c4:	02813483          	ld	s1,40(sp)
    800018c8:	02013903          	ld	s2,32(sp)
    800018cc:	01813983          	ld	s3,24(sp)
    800018d0:	01013a03          	ld	s4,16(sp)
    800018d4:	00813a83          	ld	s5,8(sp)
    800018d8:	04010113          	addi	sp,sp,64
    800018dc:	00008067          	ret

00000000800018e0 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800018e0:	fe010113          	addi	sp,sp,-32
    800018e4:	00113c23          	sd	ra,24(sp)
    800018e8:	00813823          	sd	s0,16(sp)
    800018ec:	00913423          	sd	s1,8(sp)
    800018f0:	01213023          	sd	s2,0(sp)
    800018f4:	02010413          	addi	s0,sp,32
    800018f8:	00050913          	mv	s2,a0
    800018fc:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    80001900:	00001097          	auipc	ra,0x1
    80001904:	870080e7          	jalr	-1936(ra) # 80002170 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    80001908:	0000c797          	auipc	a5,0xc
    8000190c:	ae878793          	addi	a5,a5,-1304 # 8000d3f0 <_ZN13SlabAllocator5sizeNE>
    80001910:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    80001914:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    80001918:	0000c717          	auipc	a4,0xc
    8000191c:	9f873703          	ld	a4,-1544(a4) # 8000d310 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001920:	00073583          	ld	a1,0(a4)
    80001924:	00c5d593          	srli	a1,a1,0xc
    80001928:	00158593          	addi	a1,a1,1
    8000192c:	00c59593          	slli	a1,a1,0xc
    80001930:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    80001934:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001938:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    8000193c:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001940:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001944:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001948:	07800793          	li	a5,120
    8000194c:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001950:	00200793          	li	a5,2
    80001954:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001958:	00008517          	auipc	a0,0x8
    8000195c:	7d050513          	addi	a0,a0,2000 # 8000a128 <CONSOLE_STATUS+0x118>
    80001960:	00003097          	auipc	ra,0x3
    80001964:	dbc080e7          	jalr	-580(ra) # 8000471c <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001968:	00000493          	li	s1,0
    8000196c:	04c0006f          	j	800019b8 <_ZN13SlabAllocator10initializeEPvm+0xd8>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001970:	00349913          	slli	s2,s1,0x3
    80001974:	0000b797          	auipc	a5,0xb
    80001978:	6ec78793          	addi	a5,a5,1772 # 8000d060 <_ZN13SlabAllocator5namesE>
    8000197c:	012787b3          	add	a5,a5,s2
    80001980:	00000693          	li	a3,0
    80001984:	00000613          	li	a2,0
    80001988:	00200593          	li	a1,2
    8000198c:	009595bb          	sllw	a1,a1,s1
    80001990:	0007b503          	ld	a0,0(a5)
    80001994:	00000097          	auipc	ra,0x0
    80001998:	eac080e7          	jalr	-340(ra) # 80001840 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    8000199c:	0000c797          	auipc	a5,0xc
    800019a0:	a5478793          	addi	a5,a5,-1452 # 8000d3f0 <_ZN13SlabAllocator5sizeNE>
    800019a4:	012787b3          	add	a5,a5,s2
    800019a8:	00a7b023          	sd	a0,0(a5)
        printCache(sizeN[i]);
    800019ac:	00000097          	auipc	ra,0x0
    800019b0:	928080e7          	jalr	-1752(ra) # 800012d4 <_ZN13SlabAllocator10printCacheEP5Cache>
    for(int i=0;i<BUCKET_SIZE;i++){
    800019b4:	0014849b          	addiw	s1,s1,1
    800019b8:	00c00793          	li	a5,12
    800019bc:	fa97dae3          	bge	a5,s1,80001970 <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    800019c0:	01813083          	ld	ra,24(sp)
    800019c4:	01013403          	ld	s0,16(sp)
    800019c8:	00813483          	ld	s1,8(sp)
    800019cc:	00013903          	ld	s2,0(sp)
    800019d0:	02010113          	addi	sp,sp,32
    800019d4:	00008067          	ret

00000000800019d8 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index]) {
    800019d8:	02053783          	ld	a5,32(a0)
    800019dc:	00b785b3          	add	a1,a5,a1
    800019e0:	0005c783          	lbu	a5,0(a1)
    800019e4:	0a078a63          	beqz	a5,80001a98 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    800019e8:	fe010113          	addi	sp,sp,-32
    800019ec:	00113c23          	sd	ra,24(sp)
    800019f0:	00813823          	sd	s0,16(sp)
    800019f4:	00913423          	sd	s1,8(sp)
    800019f8:	02010413          	addi	s0,sp,32
    800019fc:	00050493          	mv	s1,a0
        slab->allocated[index] = false;
    80001a00:	00058023          	sb	zero,0(a1)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001a04:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001a08:	04079a63          	bnez	a5,80001a5c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x84>
    80001a0c:	03053503          	ld	a0,48(a0)
    80001a10:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001a14:	00178793          	addi	a5,a5,1
    80001a18:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001a1c:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001a20:	04e78463          	beq	a5,a4,80001a68 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x90>
    80001a24:	0304b583          	ld	a1,48(s1)
    80001a28:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001a2c:	04e78463          	beq	a5,a4,80001a74 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x9c>
            if (headTo != headFrom)
    80001a30:	0005b703          	ld	a4,0(a1)
    80001a34:	00053783          	ld	a5,0(a0)
    80001a38:	00f70863          	beq	a4,a5,80001a48 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x70>
                SlabAllocator::move(headFrom, headTo, slab);
    80001a3c:	00048613          	mv	a2,s1
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	b98080e7          	jalr	-1128(ra) # 800015d8 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001a48:	01813083          	ld	ra,24(sp)
    80001a4c:	01013403          	ld	s0,16(sp)
    80001a50:	00813483          	ld	s1,8(sp)
    80001a54:	02010113          	addi	sp,sp,32
    80001a58:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001a5c:	03053503          	ld	a0,48(a0)
    80001a60:	06850513          	addi	a0,a0,104
    80001a64:	fb1ff06f          	j	80001a14 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x3c>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001a68:	0304b583          	ld	a1,48(s1)
    80001a6c:	06058593          	addi	a1,a1,96
    80001a70:	fbdff06f          	j	80001a2c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x54>
            SlabAllocator::removeFromList(headFrom, slab);
    80001a74:	00048593          	mv	a1,s1
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	b0c080e7          	jalr	-1268(ra) # 80001584 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001a80:	0304b783          	ld	a5,48(s1)
    80001a84:	0487b583          	ld	a1,72(a5)
    80001a88:	00048513          	mv	a0,s1
    80001a8c:	00001097          	auipc	ra,0x1
    80001a90:	9c4080e7          	jalr	-1596(ra) # 80002450 <_ZN5Buddy4freeEPvm>
    80001a94:	fb5ff06f          	j	80001a48 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x70>
    80001a98:	00008067          	ret

0000000080001a9c <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001a9c:	fe010113          	addi	sp,sp,-32
    80001aa0:	00113c23          	sd	ra,24(sp)
    80001aa4:	00813823          	sd	s0,16(sp)
    80001aa8:	00913423          	sd	s1,8(sp)
    80001aac:	01213023          	sd	s2,0(sp)
    80001ab0:	02010413          	addi	s0,sp,32
    80001ab4:	00050913          	mv	s2,a0
    80001ab8:	00058493          	mv	s1,a1
    bool deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001abc:	06853503          	ld	a0,104(a0)
    80001ac0:	0080006f          	j	80001ac8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x2c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001ac4:	00853503          	ld	a0,8(a0)
        while(head){
    80001ac8:	04050463          	beqz	a0,80001b10 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x74>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001acc:	02853583          	ld	a1,40(a0)
    80001ad0:	01853783          	ld	a5,24(a0)
    80001ad4:	03053703          	ld	a4,48(a0)
    80001ad8:	04073703          	ld	a4,64(a4)
    80001adc:	02e787b3          	mul	a5,a5,a4
    80001ae0:	00f587b3          	add	a5,a1,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001ae4:	fef4f0e3          	bgeu	s1,a5,80001ac4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x28>
    80001ae8:	fcb4eee3          	bltu	s1,a1,80001ac4 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x28>
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
    80001aec:	40b485b3          	sub	a1,s1,a1
    80001af0:	0000c797          	auipc	a5,0xc
    80001af4:	9687b783          	ld	a5,-1688(a5) # 8000d458 <_ZN13SlabAllocator5cacheE>
    80001af8:	0407b783          	ld	a5,64(a5)
                freeSlot(head, index);
    80001afc:	02f5d5b3          	divu	a1,a1,a5
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	ed8080e7          	jalr	-296(ra) # 800019d8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001b08:	00100513          	li	a0,1
    80001b0c:	0080006f          	j	80001b14 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x78>
        }
        return false;
    80001b10:	00000513          	li	a0,0
    if(deleted)
    80001b14:	00050e63          	beqz	a0,80001b30 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x94>
}
    80001b18:	01813083          	ld	ra,24(sp)
    80001b1c:	01013403          	ld	s0,16(sp)
    80001b20:	00813483          	ld	s1,8(sp)
    80001b24:	00013903          	ld	s2,0(sp)
    80001b28:	02010113          	addi	sp,sp,32
    80001b2c:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001b30:	07093783          	ld	a5,112(s2)
    80001b34:	0080006f          	j	80001b3c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa0>
            head = head->next;
    80001b38:	0087b783          	ld	a5,8(a5)
        while(head){
    80001b3c:	fc078ee3          	beqz	a5,80001b18 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x7c>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001b40:	0287b583          	ld	a1,40(a5)
    80001b44:	0187b703          	ld	a4,24(a5)
    80001b48:	0307b683          	ld	a3,48(a5)
    80001b4c:	0406b683          	ld	a3,64(a3)
    80001b50:	02d70733          	mul	a4,a4,a3
    80001b54:	00e58733          	add	a4,a1,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001b58:	fee4f0e3          	bgeu	s1,a4,80001b38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x9c>
    80001b5c:	fcb4eee3          	bltu	s1,a1,80001b38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x9c>
                uint64 index = ((uint64)addr - lowerBound) / cache->objectSize;
    80001b60:	40b485b3          	sub	a1,s1,a1
    80001b64:	0000c717          	auipc	a4,0xc
    80001b68:	8f473703          	ld	a4,-1804(a4) # 8000d458 <_ZN13SlabAllocator5cacheE>
    80001b6c:	04073703          	ld	a4,64(a4)
                freeSlot(head, index);
    80001b70:	02e5d5b3          	divu	a1,a1,a4
    80001b74:	00078513          	mv	a0,a5
    80001b78:	00000097          	auipc	ra,0x0
    80001b7c:	e60080e7          	jalr	-416(ra) # 800019d8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001b80:	00100513          	li	a0,1
    80001b84:	f95ff06f          	j	80001b18 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x7c>

0000000080001b88 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001b88:	fe010113          	addi	sp,sp,-32
    80001b8c:	00113c23          	sd	ra,24(sp)
    80001b90:	00813823          	sd	s0,16(sp)
    80001b94:	00913423          	sd	s1,8(sp)
    80001b98:	01213023          	sd	s2,0(sp)
    80001b9c:	02010413          	addi	s0,sp,32
    80001ba0:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001ba4:	00000493          	li	s1,0
    80001ba8:	00c00793          	li	a5,12
    80001bac:	0297c863          	blt	a5,s1,80001bdc <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001bb0:	00349713          	slli	a4,s1,0x3
    80001bb4:	0000c797          	auipc	a5,0xc
    80001bb8:	83c78793          	addi	a5,a5,-1988 # 8000d3f0 <_ZN13SlabAllocator5sizeNE>
    80001bbc:	00e787b3          	add	a5,a5,a4
    80001bc0:	00090593          	mv	a1,s2
    80001bc4:	0007b503          	ld	a0,0(a5)
    80001bc8:	00000097          	auipc	ra,0x0
    80001bcc:	ed4080e7          	jalr	-300(ra) # 80001a9c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001bd0:	00051663          	bnez	a0,80001bdc <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001bd4:	0014849b          	addiw	s1,s1,1
    80001bd8:	fd1ff06f          	j	80001ba8 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001bdc:	01813083          	ld	ra,24(sp)
    80001be0:	01013403          	ld	s0,16(sp)
    80001be4:	00813483          	ld	s1,8(sp)
    80001be8:	00013903          	ld	s2,0(sp)
    80001bec:	02010113          	addi	sp,sp,32
    80001bf0:	00008067          	ret

0000000080001bf4 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001bf4:	fe010113          	addi	sp,sp,-32
    80001bf8:	00113c23          	sd	ra,24(sp)
    80001bfc:	00813823          	sd	s0,16(sp)
    80001c00:	00913423          	sd	s1,8(sp)
    80001c04:	01213023          	sd	s2,0(sp)
    80001c08:	02010413          	addi	s0,sp,32
    80001c0c:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001c10:	00053903          	ld	s2,0(a0)
    80001c14:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001c18:	00093503          	ld	a0,0(s2)
    80001c1c:	02050263          	beqz	a0,80001c40 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Buddy::free(head, head->parent->slabSize);
    80001c20:	03053783          	ld	a5,48(a0)
    80001c24:	0487b583          	ld	a1,72(a5)
    80001c28:	00001097          	auipc	ra,0x1
    80001c2c:	828080e7          	jalr	-2008(ra) # 80002450 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001c30:	00093783          	ld	a5,0(s2)
    80001c34:	0087b783          	ld	a5,8(a5)
    80001c38:	00f93023          	sd	a5,0(s2)
        while(head){
    80001c3c:	fddff06f          	j	80001c18 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001c40:	0004b903          	ld	s2,0(s1)
    80001c44:	06890913          	addi	s2,s2,104
    80001c48:	00093503          	ld	a0,0(s2)
    80001c4c:	02050263          	beqz	a0,80001c70 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(head, head->parent->slabSize);
    80001c50:	03053783          	ld	a5,48(a0)
    80001c54:	0487b583          	ld	a1,72(a5)
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	7f8080e7          	jalr	2040(ra) # 80002450 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001c60:	00093783          	ld	a5,0(s2)
    80001c64:	0087b783          	ld	a5,8(a5)
    80001c68:	00f93023          	sd	a5,0(s2)
        while(head){
    80001c6c:	fddff06f          	j	80001c48 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001c70:	0004b903          	ld	s2,0(s1)
    80001c74:	06090913          	addi	s2,s2,96
    80001c78:	00093503          	ld	a0,0(s2)
    80001c7c:	02050263          	beqz	a0,80001ca0 <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(head, head->parent->slabSize);
    80001c80:	03053783          	ld	a5,48(a0)
    80001c84:	0487b583          	ld	a1,72(a5)
    80001c88:	00000097          	auipc	ra,0x0
    80001c8c:	7c8080e7          	jalr	1992(ra) # 80002450 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001c90:	00093783          	ld	a5,0(s2)
    80001c94:	0087b783          	ld	a5,8(a5)
    80001c98:	00f93023          	sd	a5,0(s2)
        while(head){
    80001c9c:	fddff06f          	j	80001c78 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001ca0:	0004b583          	ld	a1,0(s1)
    80001ca4:	0000b517          	auipc	a0,0xb
    80001ca8:	7b453503          	ld	a0,1972(a0) # 8000d458 <_ZN13SlabAllocator5cacheE>
    80001cac:	00000097          	auipc	ra,0x0
    80001cb0:	df0080e7          	jalr	-528(ra) # 80001a9c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001cb4:	0004b023          	sd	zero,0(s1)
}
    80001cb8:	01813083          	ld	ra,24(sp)
    80001cbc:	01013403          	ld	s0,16(sp)
    80001cc0:	00813483          	ld	s1,8(sp)
    80001cc4:	00013903          	ld	s2,0(sp)
    80001cc8:	02010113          	addi	sp,sp,32
    80001ccc:	00008067          	ret

0000000080001cd0 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    80001cd0:	ff010113          	addi	sp,sp,-16
    80001cd4:	00813423          	sd	s0,8(sp)
    80001cd8:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    80001cdc:	03f50513          	addi	a0,a0,63
    80001ce0:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    80001ce4:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    80001ce8:	00100513          	li	a0,1
    asm("ecall");
    80001cec:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    80001cf0:	00050513          	mv	a0,a0

    return (void*)addr;
}
    80001cf4:	00813403          	ld	s0,8(sp)
    80001cf8:	01010113          	addi	sp,sp,16
    80001cfc:	00008067          	ret

0000000080001d00 <_Z8mem_freePv>:

int mem_free(void *ptr){
    80001d00:	ff010113          	addi	sp,sp,-16
    80001d04:	00813423          	sd	s0,8(sp)
    80001d08:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80001d0c:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    80001d10:	00200513          	li	a0,2
    asm("ecall");
    80001d14:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80001d18:	00050513          	mv	a0,a0
    return status;
}
    80001d1c:	0005051b          	sext.w	a0,a0
    80001d20:	00813403          	ld	s0,8(sp)
    80001d24:	01010113          	addi	sp,sp,16
    80001d28:	00008067          	ret

0000000080001d2c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    80001d2c:	fd010113          	addi	sp,sp,-48
    80001d30:	02113423          	sd	ra,40(sp)
    80001d34:	02813023          	sd	s0,32(sp)
    80001d38:	00913c23          	sd	s1,24(sp)
    80001d3c:	01213823          	sd	s2,16(sp)
    80001d40:	01313423          	sd	s3,8(sp)
    80001d44:	03010413          	addi	s0,sp,48
    80001d48:	00050913          	mv	s2,a0
    80001d4c:	00058493          	mv	s1,a1
    80001d50:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001d54:	04058663          	beqz	a1,80001da0 <_Z13thread_createPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001d58:	00001537          	lui	a0,0x1
    80001d5c:	00000097          	auipc	ra,0x0
    80001d60:	f74080e7          	jalr	-140(ra) # 80001cd0 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001d64:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001d68:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001d6c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001d70:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80001d74:	01100513          	li	a0,17

    asm("ecall");
    80001d78:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001d7c:	00050513          	mv	a0,a0

    return status;
}
    80001d80:	0005051b          	sext.w	a0,a0
    80001d84:	02813083          	ld	ra,40(sp)
    80001d88:	02013403          	ld	s0,32(sp)
    80001d8c:	01813483          	ld	s1,24(sp)
    80001d90:	01013903          	ld	s2,16(sp)
    80001d94:	00813983          	ld	s3,8(sp)
    80001d98:	03010113          	addi	sp,sp,48
    80001d9c:	00008067          	ret
    uint64 istack = 0;
    80001da0:	00000513          	li	a0,0
    80001da4:	fc1ff06f          	j	80001d64 <_Z13thread_createPP7_threadPFvPvES2_+0x38>

0000000080001da8 <_Z11thread_exitv>:

int thread_exit(){
    80001da8:	ff010113          	addi	sp,sp,-16
    80001dac:	00813423          	sd	s0,8(sp)
    80001db0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80001db4:	01200513          	li	a0,18

    asm("ecall");
    80001db8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001dbc:	00050513          	mv	a0,a0

    return status;
}
    80001dc0:	0005051b          	sext.w	a0,a0
    80001dc4:	00813403          	ld	s0,8(sp)
    80001dc8:	01010113          	addi	sp,sp,16
    80001dcc:	00008067          	ret

0000000080001dd0 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001dd0:	ff010113          	addi	sp,sp,-16
    80001dd4:	00813423          	sd	s0,8(sp)
    80001dd8:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80001ddc:	01300513          	li	a0,19

    asm("ecall");
    80001de0:	00000073          	ecall
}
    80001de4:	00813403          	ld	s0,8(sp)
    80001de8:	01010113          	addi	sp,sp,16
    80001dec:	00008067          	ret

0000000080001df0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    80001df0:	fd010113          	addi	sp,sp,-48
    80001df4:	02113423          	sd	ra,40(sp)
    80001df8:	02813023          	sd	s0,32(sp)
    80001dfc:	00913c23          	sd	s1,24(sp)
    80001e00:	01213823          	sd	s2,16(sp)
    80001e04:	01313423          	sd	s3,8(sp)
    80001e08:	03010413          	addi	s0,sp,48
    80001e0c:	00050913          	mv	s2,a0
    80001e10:	00058493          	mv	s1,a1
    80001e14:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine)
    80001e18:	04058663          	beqz	a1,80001e64 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x74>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    80001e1c:	00001537          	lui	a0,0x1
    80001e20:	00000097          	auipc	ra,0x0
    80001e24:	eb0080e7          	jalr	-336(ra) # 80001cd0 <_Z9mem_allocm>

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80001e28:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80001e2c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80001e30:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e34:	00090593          	mv	a1,s2
    asm("li a0, 0x14");
    80001e38:	01400513          	li	a0,20

    asm("ecall");
    80001e3c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e40:	00050513          	mv	a0,a0

    return status;
}
    80001e44:	0005051b          	sext.w	a0,a0
    80001e48:	02813083          	ld	ra,40(sp)
    80001e4c:	02013403          	ld	s0,32(sp)
    80001e50:	01813483          	ld	s1,24(sp)
    80001e54:	01013903          	ld	s2,16(sp)
    80001e58:	00813983          	ld	s3,8(sp)
    80001e5c:	03010113          	addi	sp,sp,48
    80001e60:	00008067          	ret
    uint64 istack = 0;
    80001e64:	00000513          	li	a0,0
    80001e68:	fc1ff06f          	j	80001e28 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x38>

0000000080001e6c <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    80001e6c:	ff010113          	addi	sp,sp,-16
    80001e70:	00813423          	sd	s0,8(sp)
    80001e74:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001e78:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    80001e7c:	01500513          	li	a0,21

    asm("ecall");
    80001e80:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001e84:	00050513          	mv	a0,a0

    return status;
}
    80001e88:	0005051b          	sext.w	a0,a0
    80001e8c:	00813403          	ld	s0,8(sp)
    80001e90:	01010113          	addi	sp,sp,16
    80001e94:	00008067          	ret

0000000080001e98 <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00813423          	sd	s0,8(sp)
    80001ea0:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    80001ea4:	02059593          	slli	a1,a1,0x20
    80001ea8:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    80001eac:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001eb0:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    80001eb4:	02100513          	li	a0,33


    asm("ecall");
    80001eb8:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001ebc:	00050513          	mv	a0,a0

    return status;

}
    80001ec0:	0005051b          	sext.w	a0,a0
    80001ec4:	00813403          	ld	s0,8(sp)
    80001ec8:	01010113          	addi	sp,sp,16
    80001ecc:	00008067          	ret

0000000080001ed0 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    80001ed0:	ff010113          	addi	sp,sp,-16
    80001ed4:	00813423          	sd	s0,8(sp)
    80001ed8:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001edc:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    80001ee0:	02200513          	li	a0,34


    asm("ecall");
    80001ee4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001ee8:	00050513          	mv	a0,a0

    return status;
}
    80001eec:	0005051b          	sext.w	a0,a0
    80001ef0:	00813403          	ld	s0,8(sp)
    80001ef4:	01010113          	addi	sp,sp,16
    80001ef8:	00008067          	ret

0000000080001efc <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    80001efc:	ff010113          	addi	sp,sp,-16
    80001f00:	00813423          	sd	s0,8(sp)
    80001f04:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f08:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    80001f0c:	02300513          	li	a0,35


    asm("ecall");
    80001f10:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f14:	00050513          	mv	a0,a0

    return status;
}
    80001f18:	0005051b          	sext.w	a0,a0
    80001f1c:	00813403          	ld	s0,8(sp)
    80001f20:	01010113          	addi	sp,sp,16
    80001f24:	00008067          	ret

0000000080001f28 <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    80001f28:	ff010113          	addi	sp,sp,-16
    80001f2c:	00813423          	sd	s0,8(sp)
    80001f30:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80001f34:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    80001f38:	02400513          	li	a0,36


    asm("ecall");
    80001f3c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f40:	00050513          	mv	a0,a0

    return status;
}
    80001f44:	0005051b          	sext.w	a0,a0
    80001f48:	00813403          	ld	s0,8(sp)
    80001f4c:	01010113          	addi	sp,sp,16
    80001f50:	00008067          	ret

0000000080001f54 <_Z10time_sleepm>:

int time_sleep(time_t time){
    80001f54:	ff010113          	addi	sp,sp,-16
    80001f58:	00813423          	sd	s0,8(sp)
    80001f5c:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    80001f60:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    80001f64:	03100513          	li	a0,49


    asm("ecall");
    80001f68:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001f6c:	00050513          	mv	a0,a0

    return status;
}
    80001f70:	0005051b          	sext.w	a0,a0
    80001f74:	00813403          	ld	s0,8(sp)
    80001f78:	01010113          	addi	sp,sp,16
    80001f7c:	00008067          	ret

0000000080001f80 <_Z4getcv>:

char getc(){
    80001f80:	ff010113          	addi	sp,sp,-16
    80001f84:	00813423          	sd	s0,8(sp)
    80001f88:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    80001f8c:	04100513          	li	a0,65

    asm("ecall");
    80001f90:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    80001f94:	00050513          	mv	a0,a0

    return c;
}
    80001f98:	0ff57513          	andi	a0,a0,255
    80001f9c:	00813403          	ld	s0,8(sp)
    80001fa0:	01010113          	addi	sp,sp,16
    80001fa4:	00008067          	ret

0000000080001fa8 <_Z4putcc>:

void putc(char c){
    80001fa8:	ff010113          	addi	sp,sp,-16
    80001fac:	00813423          	sd	s0,8(sp)
    80001fb0:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    80001fb4:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    80001fb8:	04200513          	li	a0,66

    asm("ecall");
    80001fbc:	00000073          	ecall
}
    80001fc0:	00813403          	ld	s0,8(sp)
    80001fc4:	01010113          	addi	sp,sp,16
    80001fc8:	00008067          	ret

0000000080001fcc <_Z4forkv>:


int fork(){
    80001fcc:	ff010113          	addi	sp,sp,-16
    80001fd0:	00813423          	sd	s0,8(sp)
    80001fd4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    80001fd8:	06100513          	li	a0,97

    asm("ecall");
    80001fdc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80001fe0:	00050513          	mv	a0,a0

    return status;
}
    80001fe4:	0005051b          	sext.w	a0,a0
    80001fe8:	00813403          	ld	s0,8(sp)
    80001fec:	01010113          	addi	sp,sp,16
    80001ff0:	00008067          	ret

0000000080001ff4 <_ZN10_semaphoredlEPv>:
#include "../h/_semaphore.hpp"
#include "../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    80001ff4:	ff010113          	addi	sp,sp,-16
    80001ff8:	00113423          	sd	ra,8(sp)
    80001ffc:	00813023          	sd	s0,0(sp)
    80002000:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    80002004:	00000097          	auipc	ra,0x0
    80002008:	ecc080e7          	jalr	-308(ra) # 80001ed0 <_Z9sem_closeP10_semaphore>
}
    8000200c:	00813083          	ld	ra,8(sp)
    80002010:	00013403          	ld	s0,0(sp)
    80002014:	01010113          	addi	sp,sp,16
    80002018:	00008067          	ret

000000008000201c <_ZN7_threaddlEPv>:

#include "../h/_thread.hpp"
#include "../h/tcb.hpp"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    8000201c:	ff010113          	addi	sp,sp,-16
    80002020:	00113423          	sd	ra,8(sp)
    80002024:	00813023          	sd	s0,0(sp)
    80002028:	01010413          	addi	s0,sp,16
    TCB::thread_free(addr);
    8000202c:	00001097          	auipc	ra,0x1
    80002030:	e60080e7          	jalr	-416(ra) # 80002e8c <_ZN3TCB11thread_freeEPv>
    80002034:	00813083          	ld	ra,8(sp)
    80002038:	00013403          	ld	s0,0(sp)
    8000203c:	01010113          	addi	sp,sp,16
    80002040:	00008067          	ret

0000000080002044 <_ZN6System15userMainWrapperEPv>:
        RiscV::finalize();
    }
}

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80002044:	ff010113          	addi	sp,sp,-16
    80002048:	00113423          	sd	ra,8(sp)
    8000204c:	00813023          	sd	s0,0(sp)
    80002050:	01010413          	addi	s0,sp,16
//    else {
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
    userMain();
    80002054:	00004097          	auipc	ra,0x4
    80002058:	5cc080e7          	jalr	1484(ra) # 80006620 <_Z8userMainv>
    8000205c:	00813083          	ld	ra,8(sp)
    80002060:	00013403          	ld	s0,0(sp)
    80002064:	01010113          	addi	sp,sp,16
    80002068:	00008067          	ret

000000008000206c <_ZN6SystemC1Ev>:
    if (!initialized) {
    8000206c:	0000b797          	auipc	a5,0xb
    80002070:	4047c783          	lbu	a5,1028(a5) # 8000d470 <_ZN6System11initializedE>
    80002074:	00078463          	beqz	a5,8000207c <_ZN6SystemC1Ev+0x10>
    80002078:	00008067          	ret
System::System() {
    8000207c:	fe010113          	addi	sp,sp,-32
    80002080:	00113c23          	sd	ra,24(sp)
    80002084:	00813823          	sd	s0,16(sp)
    80002088:	02010413          	addi	s0,sp,32
        initialized = true;
    8000208c:	00100793          	li	a5,1
    80002090:	0000b717          	auipc	a4,0xb
    80002094:	3ef70023          	sb	a5,992(a4) # 8000d470 <_ZN6System11initializedE>
        RiscV::initialize();
    80002098:	00001097          	auipc	ra,0x1
    8000209c:	790080e7          	jalr	1936(ra) # 80003828 <_ZN5RiscV10initializeEv>
        kmem_init((void*)HEAP_START_ADDR, 4096);
    800020a0:	000015b7          	lui	a1,0x1
    800020a4:	0000b797          	auipc	a5,0xb
    800020a8:	26c7b783          	ld	a5,620(a5) # 8000d310 <_GLOBAL_OFFSET_TABLE_+0x18>
    800020ac:	0007b503          	ld	a0,0(a5)
    800020b0:	00003097          	auipc	ra,0x3
    800020b4:	d3c080e7          	jalr	-708(ra) # 80004dec <_Z9kmem_initPvi>
        SlabAllocator::allocateBuffer(100);
    800020b8:	06400513          	li	a0,100
    800020bc:	fffff097          	auipc	ra,0xfffff
    800020c0:	6e0080e7          	jalr	1760(ra) # 8000179c <_ZN13SlabAllocator14allocateBufferEm>
        thread_create(&userMainThread, userMainWrapper, nullptr);
    800020c4:	00000613          	li	a2,0
    800020c8:	00000597          	auipc	a1,0x0
    800020cc:	f7c58593          	addi	a1,a1,-132 # 80002044 <_ZN6System15userMainWrapperEPv>
    800020d0:	fe840513          	addi	a0,s0,-24
    800020d4:	00000097          	auipc	ra,0x0
    800020d8:	c58080e7          	jalr	-936(ra) # 80001d2c <_Z13thread_createPP7_threadPFvPvES2_>
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    800020dc:	fe843783          	ld	a5,-24(s0)
    800020e0:	0107a703          	lw	a4,16(a5)
    800020e4:	00200793          	li	a5,2
    800020e8:	00f70863          	beq	a4,a5,800020f8 <_ZN6SystemC1Ev+0x8c>
            thread_dispatch();
    800020ec:	00000097          	auipc	ra,0x0
    800020f0:	ce4080e7          	jalr	-796(ra) # 80001dd0 <_Z15thread_dispatchv>
    800020f4:	fe9ff06f          	j	800020dc <_ZN6SystemC1Ev+0x70>
        RiscV::finalize();
    800020f8:	00002097          	auipc	ra,0x2
    800020fc:	908080e7          	jalr	-1784(ra) # 80003a00 <_ZN5RiscV8finalizeEv>
}
    80002100:	01813083          	ld	ra,24(sp)
    80002104:	01013403          	ld	s0,16(sp)
    80002108:	02010113          	addi	sp,sp,32
    8000210c:	00008067          	ret

0000000080002110 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80002110:	ff010113          	addi	sp,sp,-16
    80002114:	00813423          	sd	s0,8(sp)
    80002118:	01010413          	addi	s0,sp,16
    8000211c:	00100793          	li	a5,1
    80002120:	00f50863          	beq	a0,a5,80002130 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002124:	00813403          	ld	s0,8(sp)
    80002128:	01010113          	addi	sp,sp,16
    8000212c:	00008067          	ret
    80002130:	000107b7          	lui	a5,0x10
    80002134:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002138:	fef596e3          	bne	a1,a5,80002124 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    8000213c:	0000b797          	auipc	a5,0xb
    80002140:	1d47b783          	ld	a5,468(a5) # 8000d310 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002144:	0007b703          	ld	a4,0(a5)
    80002148:	00c75793          	srli	a5,a4,0xc
    8000214c:	00278793          	addi	a5,a5,2
    80002150:	00c79793          	slli	a5,a5,0xc
    80002154:	0000b697          	auipc	a3,0xb
    80002158:	32468693          	addi	a3,a3,804 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000215c:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002160:	fffff7b7          	lui	a5,0xfffff
    80002164:	00f77733          	and	a4,a4,a5
    80002168:	00e6b423          	sd	a4,8(a3)
    8000216c:	fb9ff06f          	j	80002124 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002170 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80002170:	ff010113          	addi	sp,sp,-16
    80002174:	00813423          	sd	s0,8(sp)
    80002178:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    8000217c:	0000b717          	auipc	a4,0xb
    80002180:	2fc70713          	addi	a4,a4,764 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002184:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80002188:	0000b797          	auipc	a5,0xb
    8000218c:	1887b783          	ld	a5,392(a5) # 8000d310 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002190:	0007b783          	ld	a5,0(a5)
    80002194:	fffff6b7          	lui	a3,0xfffff
    80002198:	00d7f7b3          	and	a5,a5,a3
    8000219c:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    800021a0:	0000b797          	auipc	a5,0xb
    800021a4:	f2b7b423          	sd	a1,-216(a5) # 8000d0c8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    800021a8:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800021ac:	00000713          	li	a4,0
        while(num>1){
    800021b0:	00100693          	li	a3,1
    800021b4:	00f6f863          	bgeu	a3,a5,800021c4 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    800021b8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800021bc:	00170713          	addi	a4,a4,1
        while(num>1){
    800021c0:	ff1ff06f          	j	800021b0 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    800021c4:	00371713          	slli	a4,a4,0x3
    800021c8:	0000b797          	auipc	a5,0xb
    800021cc:	2b078793          	addi	a5,a5,688 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800021d0:	00e78733          	add	a4,a5,a4
    800021d4:	00a73823          	sd	a0,16(a4)
    800021d8:	00058793          	mv	a5,a1
        uint64 deg = 0;
    800021dc:	00000713          	li	a4,0
        while(num>1){
    800021e0:	00100693          	li	a3,1
    800021e4:	00f6f863          	bgeu	a3,a5,800021f4 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    800021e8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800021ec:	00170713          	addi	a4,a4,1
        while(num>1){
    800021f0:	ff1ff06f          	j	800021e0 <_ZN5Buddy10initializeEPvm+0x70>
    800021f4:	00371713          	slli	a4,a4,0x3
    800021f8:	0000b797          	auipc	a5,0xb
    800021fc:	28078793          	addi	a5,a5,640 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002200:	00e78733          	add	a4,a5,a4
    80002204:	06a73c23          	sd	a0,120(a4)
    80002208:	00058793          	mv	a5,a1
        uint64 deg = 0;
    8000220c:	00000713          	li	a4,0
        while(num>1){
    80002210:	00100693          	li	a3,1
    80002214:	00f6f863          	bgeu	a3,a5,80002224 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80002218:	0017d793          	srli	a5,a5,0x1
            deg++;
    8000221c:	00170713          	addi	a4,a4,1
        while(num>1){
    80002220:	ff1ff06f          	j	80002210 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80002224:	00371713          	slli	a4,a4,0x3
    80002228:	0000b797          	auipc	a5,0xb
    8000222c:	25078793          	addi	a5,a5,592 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002230:	00e78733          	add	a4,a5,a4
    80002234:	01073783          	ld	a5,16(a4)
    80002238:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    8000223c:	00000793          	li	a5,0
    80002240:	00c0006f          	j	8000224c <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80002244:	0015d593          	srli	a1,a1,0x1
            deg++;
    80002248:	00178793          	addi	a5,a5,1
        while(num>1){
    8000224c:	00100713          	li	a4,1
    80002250:	feb76ae3          	bltu	a4,a1,80002244 <_ZN5Buddy10initializeEPvm+0xd4>
    80002254:	00379793          	slli	a5,a5,0x3
    80002258:	0000b717          	auipc	a4,0xb
    8000225c:	22070713          	addi	a4,a4,544 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002260:	00f707b3          	add	a5,a4,a5
    80002264:	0787b783          	ld	a5,120(a5)
    80002268:	0007b023          	sd	zero,0(a5)
}
    8000226c:	00813403          	ld	s0,8(sp)
    80002270:	01010113          	addi	sp,sp,16
    80002274:	00008067          	ret

0000000080002278 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80002278:	00c00793          	li	a5,12
    8000227c:	0ef50863          	beq	a0,a5,8000236c <_ZN5Buddy8compressEm+0xf4>
void Buddy::compress(uint64 size) {
    80002280:	fd010113          	addi	sp,sp,-48
    80002284:	02113423          	sd	ra,40(sp)
    80002288:	02813023          	sd	s0,32(sp)
    8000228c:	00913c23          	sd	s1,24(sp)
    80002290:	01213823          	sd	s2,16(sp)
    80002294:	01313423          	sd	s3,8(sp)
    80002298:	03010413          	addi	s0,sp,48
    8000229c:	00050913          	mv	s2,a0
    Block *curr = head[size];
    800022a0:	00351713          	slli	a4,a0,0x3
    800022a4:	0000b797          	auipc	a5,0xb
    800022a8:	1d478793          	addi	a5,a5,468 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022ac:	00e787b3          	add	a5,a5,a4
    800022b0:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    800022b4:	00000993          	li	s3,0
    800022b8:	0180006f          	j	800022d0 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    800022bc:	40d70733          	sub	a4,a4,a3
        if(blkNoNext == pair){
    800022c0:	04f70663          	beq	a4,a5,8000230c <_ZN5Buddy8compressEm+0x94>
            prev = curr;
    800022c4:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    800022c8:	06f70863          	beq	a4,a5,80002338 <_ZN5Buddy8compressEm+0xc0>
        curr = curr->next;
    800022cc:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    800022d0:	08048063          	beqz	s1,80002350 <_ZN5Buddy8compressEm+0xd8>
    800022d4:	0004b603          	ld	a2,0(s1)
    800022d8:	06060c63          	beqz	a2,80002350 <_ZN5Buddy8compressEm+0xd8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    800022dc:	0000b797          	auipc	a5,0xb
    800022e0:	19c7b783          	ld	a5,412(a5) # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022e4:	40f48733          	sub	a4,s1,a5
    800022e8:	00c75713          	srli	a4,a4,0xc
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)BUDDY_START_ADDR) >> BUDDY_BLOCK_BITS;
    800022ec:	40f607b3          	sub	a5,a2,a5
    800022f0:	00c7d793          	srli	a5,a5,0xc
        uint64 pair = (blkNoCurr % (1<<size) == 0) ? blkNoCurr + (1<<size) : blkNoCurr - (1<<size);
    800022f4:	00100693          	li	a3,1
    800022f8:	012696bb          	sllw	a3,a3,s2
    800022fc:	02d775b3          	remu	a1,a4,a3
    80002300:	fa059ee3          	bnez	a1,800022bc <_ZN5Buddy8compressEm+0x44>
    80002304:	00e68733          	add	a4,a3,a4
    80002308:	fb9ff06f          	j	800022c0 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    8000230c:	00098863          	beqz	s3,8000231c <_ZN5Buddy8compressEm+0xa4>
                prev->next = curr->next->next;
    80002310:	00063683          	ld	a3,0(a2)
    80002314:	00d9b023          	sd	a3,0(s3)
    80002318:	fb1ff06f          	j	800022c8 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    8000231c:	00063603          	ld	a2,0(a2)
    80002320:	00391593          	slli	a1,s2,0x3
    80002324:	0000b697          	auipc	a3,0xb
    80002328:	15468693          	addi	a3,a3,340 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000232c:	00b686b3          	add	a3,a3,a1
    80002330:	06c6bc23          	sd	a2,120(a3)
    80002334:	f95ff06f          	j	800022c8 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    80002338:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    8000233c:	00190593          	addi	a1,s2,1
    80002340:	00048513          	mv	a0,s1
    80002344:	00000097          	auipc	ra,0x0
    80002348:	02c080e7          	jalr	44(ra) # 80002370 <_ZN5Buddy6insertEPvm>
    8000234c:	f81ff06f          	j	800022cc <_ZN5Buddy8compressEm+0x54>
}
    80002350:	02813083          	ld	ra,40(sp)
    80002354:	02013403          	ld	s0,32(sp)
    80002358:	01813483          	ld	s1,24(sp)
    8000235c:	01013903          	ld	s2,16(sp)
    80002360:	00813983          	ld	s3,8(sp)
    80002364:	03010113          	addi	sp,sp,48
    80002368:	00008067          	ret
    8000236c:	00008067          	ret

0000000080002370 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002370:	00050693          	mv	a3,a0
    if(!head[size]){
    80002374:	00359713          	slli	a4,a1,0x3
    80002378:	0000b797          	auipc	a5,0xb
    8000237c:	10078793          	addi	a5,a5,256 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002380:	00e787b3          	add	a5,a5,a4
    80002384:	0787b783          	ld	a5,120(a5)
    80002388:	02078863          	beqz	a5,800023b8 <_ZN5Buddy6insertEPvm+0x48>
void Buddy::insert(void *addr, uint64 size) {
    8000238c:	ff010113          	addi	sp,sp,-16
    80002390:	00113423          	sd	ra,8(sp)
    80002394:	00813023          	sd	s0,0(sp)
    80002398:	01010413          	addi	s0,sp,16
    8000239c:	00058513          	mv	a0,a1
        if((uint64)addr < (uint64)head[size]){
    800023a0:	00068713          	mv	a4,a3
    800023a4:	02f6ec63          	bltu	a3,a5,800023dc <_ZN5Buddy6insertEPvm+0x6c>
            while(iter != nullptr){
    800023a8:	06078663          	beqz	a5,80002414 <_ZN5Buddy6insertEPvm+0xa4>
                if((uint64)addr < (uint64)iter) {
    800023ac:	04f76a63          	bltu	a4,a5,80002400 <_ZN5Buddy6insertEPvm+0x90>
                    iter = iter->next;
    800023b0:	0007b783          	ld	a5,0(a5)
            while(iter != nullptr){
    800023b4:	ff5ff06f          	j	800023a8 <_ZN5Buddy6insertEPvm+0x38>
        head[size] = tail[size] = (Block*)addr;
    800023b8:	0000b797          	auipc	a5,0xb
    800023bc:	0c078793          	addi	a5,a5,192 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023c0:	00e78533          	add	a0,a5,a4
    800023c4:	00d53823          	sd	a3,16(a0) # 1010 <_entry-0x7fffeff0>
    800023c8:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    800023cc:	0006b023          	sd	zero,0(a3)
    800023d0:	07853783          	ld	a5,120(a0)
    800023d4:	0007b023          	sd	zero,0(a5)
        return;
    800023d8:	00008067          	ret
            newHead->next = head[size];
    800023dc:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    800023e0:	00359713          	slli	a4,a1,0x3
    800023e4:	0000b797          	auipc	a5,0xb
    800023e8:	09478793          	addi	a5,a5,148 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023ec:	00e787b3          	add	a5,a5,a4
    800023f0:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    800023f4:	00000097          	auipc	ra,0x0
    800023f8:	e84080e7          	jalr	-380(ra) # 80002278 <_ZN5Buddy8compressEm>
            return;
    800023fc:	0440006f          	j	80002440 <_ZN5Buddy6insertEPvm+0xd0>
                    newBlock->next = iter;
    80002400:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80002404:	00d03023          	sd	a3,0(zero) # 0 <_entry-0x80000000>
                    compress(size);
    80002408:	00000097          	auipc	ra,0x0
    8000240c:	e70080e7          	jalr	-400(ra) # 80002278 <_ZN5Buddy8compressEm>
                    return;
    80002410:	0300006f          	j	80002440 <_ZN5Buddy6insertEPvm+0xd0>
    tail[size]->next = (Block*)addr;
    80002414:	00351713          	slli	a4,a0,0x3
    80002418:	0000b797          	auipc	a5,0xb
    8000241c:	06078793          	addi	a5,a5,96 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002420:	00e787b3          	add	a5,a5,a4
    80002424:	0107b703          	ld	a4,16(a5)
    80002428:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    8000242c:	0107b703          	ld	a4,16(a5)
    80002430:	00073703          	ld	a4,0(a4)
    80002434:	00e7b823          	sd	a4,16(a5)
    compress(size);
    80002438:	00000097          	auipc	ra,0x0
    8000243c:	e40080e7          	jalr	-448(ra) # 80002278 <_ZN5Buddy8compressEm>
}
    80002440:	00813083          	ld	ra,8(sp)
    80002444:	00013403          	ld	s0,0(sp)
    80002448:	01010113          	addi	sp,sp,16
    8000244c:	00008067          	ret

0000000080002450 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    80002450:	02050663          	beqz	a0,8000247c <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    80002454:	ff010113          	addi	sp,sp,-16
    80002458:	00113423          	sd	ra,8(sp)
    8000245c:	00813023          	sd	s0,0(sp)
    80002460:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80002464:	00000097          	auipc	ra,0x0
    80002468:	f0c080e7          	jalr	-244(ra) # 80002370 <_ZN5Buddy6insertEPvm>
}
    8000246c:	00813083          	ld	ra,8(sp)
    80002470:	00013403          	ld	s0,0(sp)
    80002474:	01010113          	addi	sp,sp,16
    80002478:	00008067          	ret
    8000247c:	00008067          	ret

0000000080002480 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002480:	ff010113          	addi	sp,sp,-16
    80002484:	00813423          	sd	s0,8(sp)
    80002488:	01010413          	addi	s0,sp,16
    8000248c:	03c0006f          	j	800024c8 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002490:	00b5859b          	addiw	a1,a1,11
    80002494:	00100713          	li	a4,1
    80002498:	00b715bb          	sllw	a1,a4,a1
    8000249c:	00b505b3          	add	a1,a0,a1
    800024a0:	00379693          	slli	a3,a5,0x3
    800024a4:	0000b717          	auipc	a4,0xb
    800024a8:	fd470713          	addi	a4,a4,-44 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024ac:	00d70733          	add	a4,a4,a3
    800024b0:	00b73823          	sd	a1,16(a4)
    800024b4:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    800024b8:	0005b023          	sd	zero,0(a1)
    800024bc:	07873703          	ld	a4,120(a4)
    800024c0:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    800024c4:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    800024c8:	fff5879b          	addiw	a5,a1,-1
    800024cc:	04c7c863          	blt	a5,a2,8000251c <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    800024d0:	00379693          	slli	a3,a5,0x3
    800024d4:	0000b717          	auipc	a4,0xb
    800024d8:	fa470713          	addi	a4,a4,-92 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800024dc:	00d70733          	add	a4,a4,a3
    800024e0:	01073683          	ld	a3,16(a4)
    800024e4:	fa0686e3          	beqz	a3,80002490 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    800024e8:	00b5859b          	addiw	a1,a1,11
    800024ec:	00100713          	li	a4,1
    800024f0:	00b715bb          	sllw	a1,a4,a1
    800024f4:	00b505b3          	add	a1,a0,a1
    800024f8:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    800024fc:	00379693          	slli	a3,a5,0x3
    80002500:	0000b717          	auipc	a4,0xb
    80002504:	f7870713          	addi	a4,a4,-136 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002508:	00d70733          	add	a4,a4,a3
    8000250c:	01073683          	ld	a3,16(a4)
    80002510:	0006b683          	ld	a3,0(a3)
    80002514:	00d73823          	sd	a3,16(a4)
    80002518:	fadff06f          	j	800024c4 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    8000251c:	00813403          	ld	s0,8(sp)
    80002520:	01010113          	addi	sp,sp,16
    80002524:	00008067          	ret

0000000080002528 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    80002528:	fe010113          	addi	sp,sp,-32
    8000252c:	00113c23          	sd	ra,24(sp)
    80002530:	00813823          	sd	s0,16(sp)
    80002534:	00913423          	sd	s1,8(sp)
    80002538:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    8000253c:	00c00793          	li	a5,12
    80002540:	06a7ec63          	bltu	a5,a0,800025b8 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002544:	00050593          	mv	a1,a0
    80002548:	00c00793          	li	a5,12
    8000254c:	06b7ea63          	bltu	a5,a1,800025c0 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    80002550:	00359713          	slli	a4,a1,0x3
    80002554:	0000b797          	auipc	a5,0xb
    80002558:	f2478793          	addi	a5,a5,-220 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000255c:	00e787b3          	add	a5,a5,a4
    80002560:	0787b483          	ld	s1,120(a5)
    80002564:	00049663          	bnez	s1,80002570 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002568:	00158593          	addi	a1,a1,1
    8000256c:	fddff06f          	j	80002548 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    80002570:	0004b703          	ld	a4,0(s1)
    80002574:	00359693          	slli	a3,a1,0x3
    80002578:	0000b797          	auipc	a5,0xb
    8000257c:	f0078793          	addi	a5,a5,-256 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002580:	00d787b3          	add	a5,a5,a3
    80002584:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002588:	00070e63          	beqz	a4,800025a4 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    8000258c:	0005061b          	sext.w	a2,a0
    80002590:	0005859b          	sext.w	a1,a1
    80002594:	00048513          	mv	a0,s1
    80002598:	00000097          	auipc	ra,0x0
    8000259c:	ee8080e7          	jalr	-280(ra) # 80002480 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    800025a0:	0240006f          	j	800025c4 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    800025a4:	0000b797          	auipc	a5,0xb
    800025a8:	ed478793          	addi	a5,a5,-300 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    800025ac:	00d787b3          	add	a5,a5,a3
    800025b0:	0007b823          	sd	zero,16(a5)
    800025b4:	fd9ff06f          	j	8000258c <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    800025b8:	00000493          	li	s1,0
    800025bc:	0080006f          	j	800025c4 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    800025c0:	00000493          	li	s1,0
}
    800025c4:	00048513          	mv	a0,s1
    800025c8:	01813083          	ld	ra,24(sp)
    800025cc:	01013403          	ld	s0,16(sp)
    800025d0:	00813483          	ld	s1,8(sp)
    800025d4:	02010113          	addi	sp,sp,32
    800025d8:	00008067          	ret

00000000800025dc <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    800025dc:	fe010113          	addi	sp,sp,-32
    800025e0:	00113c23          	sd	ra,24(sp)
    800025e4:	00813823          	sd	s0,16(sp)
    800025e8:	00913423          	sd	s1,8(sp)
    800025ec:	01213023          	sd	s2,0(sp)
    800025f0:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    800025f4:	00000913          	li	s2,0
    800025f8:	0180006f          	j	80002610 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    800025fc:	00008517          	auipc	a0,0x8
    80002600:	cfc50513          	addi	a0,a0,-772 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80002604:	00002097          	auipc	ra,0x2
    80002608:	640080e7          	jalr	1600(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    8000260c:	0019091b          	addiw	s2,s2,1
    80002610:	00c00793          	li	a5,12
    80002614:	0727c663          	blt	a5,s2,80002680 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    80002618:	00000613          	li	a2,0
    8000261c:	00a00593          	li	a1,10
    80002620:	00090513          	mv	a0,s2
    80002624:	00002097          	auipc	ra,0x2
    80002628:	664080e7          	jalr	1636(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    8000262c:	00008517          	auipc	a0,0x8
    80002630:	c4450513          	addi	a0,a0,-956 # 8000a270 <CONSOLE_STATUS+0x260>
    80002634:	00002097          	auipc	ra,0x2
    80002638:	610080e7          	jalr	1552(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    8000263c:	00391713          	slli	a4,s2,0x3
    80002640:	0000b797          	auipc	a5,0xb
    80002644:	e3878793          	addi	a5,a5,-456 # 8000d478 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002648:	00e787b3          	add	a5,a5,a4
    8000264c:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    80002650:	fa0486e3          	beqz	s1,800025fc <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,10);
    80002654:	00000613          	li	a2,0
    80002658:	00a00593          	li	a1,10
    8000265c:	0004851b          	sext.w	a0,s1
    80002660:	00002097          	auipc	ra,0x2
    80002664:	628080e7          	jalr	1576(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002668:	00008517          	auipc	a0,0x8
    8000266c:	a6850513          	addi	a0,a0,-1432 # 8000a0d0 <CONSOLE_STATUS+0xc0>
    80002670:	00002097          	auipc	ra,0x2
    80002674:	5d4080e7          	jalr	1492(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002678:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    8000267c:	fd5ff06f          	j	80002650 <_ZN5Buddy9printListEv+0x74>
    80002680:	01813083          	ld	ra,24(sp)
    80002684:	01013403          	ld	s0,16(sp)
    80002688:	00813483          	ld	s1,8(sp)
    8000268c:	00013903          	ld	s2,0(sp)
    80002690:	02010113          	addi	sp,sp,32
    80002694:	00008067          	ret

0000000080002698 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002698:	ff010113          	addi	sp,sp,-16
    8000269c:	00113423          	sd	ra,8(sp)
    800026a0:	00813023          	sd	s0,0(sp)
    800026a4:	01010413          	addi	s0,sp,16
    800026a8:	000105b7          	lui	a1,0x10
    800026ac:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800026b0:	00100513          	li	a0,1
    800026b4:	00000097          	auipc	ra,0x0
    800026b8:	a5c080e7          	jalr	-1444(ra) # 80002110 <_Z41__static_initialization_and_destruction_0ii>
    800026bc:	00813083          	ld	ra,8(sp)
    800026c0:	00013403          	ld	s0,0(sp)
    800026c4:	01010113          	addi	sp,sp,16
    800026c8:	00008067          	ret

00000000800026cc <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800026cc:	fe010113          	addi	sp,sp,-32
    800026d0:	00113c23          	sd	ra,24(sp)
    800026d4:	00813823          	sd	s0,16(sp)
    800026d8:	00913423          	sd	s1,8(sp)
    800026dc:	02010413          	addi	s0,sp,32
    800026e0:	00050493          	mv	s1,a0
    LOCK();
    800026e4:	00100613          	li	a2,1
    800026e8:	00000593          	li	a1,0
    800026ec:	0000b517          	auipc	a0,0xb
    800026f0:	e6c50513          	addi	a0,a0,-404 # 8000d558 <lockPrint>
    800026f4:	fffff097          	auipc	ra,0xfffff
    800026f8:	90c080e7          	jalr	-1780(ra) # 80001000 <copy_and_swap>
    800026fc:	fe0514e3          	bnez	a0,800026e4 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002700:	0004c503          	lbu	a0,0(s1)
    80002704:	00050a63          	beqz	a0,80002718 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80002708:	00000097          	auipc	ra,0x0
    8000270c:	8a0080e7          	jalr	-1888(ra) # 80001fa8 <_Z4putcc>
        string++;
    80002710:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002714:	fedff06f          	j	80002700 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80002718:	00000613          	li	a2,0
    8000271c:	00100593          	li	a1,1
    80002720:	0000b517          	auipc	a0,0xb
    80002724:	e3850513          	addi	a0,a0,-456 # 8000d558 <lockPrint>
    80002728:	fffff097          	auipc	ra,0xfffff
    8000272c:	8d8080e7          	jalr	-1832(ra) # 80001000 <copy_and_swap>
    80002730:	fe0514e3          	bnez	a0,80002718 <_Z11printStringPKc+0x4c>
}
    80002734:	01813083          	ld	ra,24(sp)
    80002738:	01013403          	ld	s0,16(sp)
    8000273c:	00813483          	ld	s1,8(sp)
    80002740:	02010113          	addi	sp,sp,32
    80002744:	00008067          	ret

0000000080002748 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002748:	fd010113          	addi	sp,sp,-48
    8000274c:	02113423          	sd	ra,40(sp)
    80002750:	02813023          	sd	s0,32(sp)
    80002754:	00913c23          	sd	s1,24(sp)
    80002758:	01213823          	sd	s2,16(sp)
    8000275c:	01313423          	sd	s3,8(sp)
    80002760:	01413023          	sd	s4,0(sp)
    80002764:	03010413          	addi	s0,sp,48
    80002768:	00050993          	mv	s3,a0
    8000276c:	00058a13          	mv	s4,a1
    LOCK();
    80002770:	00100613          	li	a2,1
    80002774:	00000593          	li	a1,0
    80002778:	0000b517          	auipc	a0,0xb
    8000277c:	de050513          	addi	a0,a0,-544 # 8000d558 <lockPrint>
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	880080e7          	jalr	-1920(ra) # 80001000 <copy_and_swap>
    80002788:	fe0514e3          	bnez	a0,80002770 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000278c:	00000913          	li	s2,0
    80002790:	00090493          	mv	s1,s2
    80002794:	0019091b          	addiw	s2,s2,1
    80002798:	03495a63          	bge	s2,s4,800027cc <_Z9getStringPci+0x84>
        cc = getc();
    8000279c:	fffff097          	auipc	ra,0xfffff
    800027a0:	7e4080e7          	jalr	2020(ra) # 80001f80 <_Z4getcv>
        if(cc < 1)
    800027a4:	02050463          	beqz	a0,800027cc <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    800027a8:	009984b3          	add	s1,s3,s1
    800027ac:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800027b0:	00a00793          	li	a5,10
    800027b4:	00f50a63          	beq	a0,a5,800027c8 <_Z9getStringPci+0x80>
    800027b8:	00d00793          	li	a5,13
    800027bc:	fcf51ae3          	bne	a0,a5,80002790 <_Z9getStringPci+0x48>
        buf[i++] = c;
    800027c0:	00090493          	mv	s1,s2
    800027c4:	0080006f          	j	800027cc <_Z9getStringPci+0x84>
    800027c8:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800027cc:	009984b3          	add	s1,s3,s1
    800027d0:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800027d4:	00000613          	li	a2,0
    800027d8:	00100593          	li	a1,1
    800027dc:	0000b517          	auipc	a0,0xb
    800027e0:	d7c50513          	addi	a0,a0,-644 # 8000d558 <lockPrint>
    800027e4:	fffff097          	auipc	ra,0xfffff
    800027e8:	81c080e7          	jalr	-2020(ra) # 80001000 <copy_and_swap>
    800027ec:	fe0514e3          	bnez	a0,800027d4 <_Z9getStringPci+0x8c>
    return buf;
}
    800027f0:	00098513          	mv	a0,s3
    800027f4:	02813083          	ld	ra,40(sp)
    800027f8:	02013403          	ld	s0,32(sp)
    800027fc:	01813483          	ld	s1,24(sp)
    80002800:	01013903          	ld	s2,16(sp)
    80002804:	00813983          	ld	s3,8(sp)
    80002808:	00013a03          	ld	s4,0(sp)
    8000280c:	03010113          	addi	sp,sp,48
    80002810:	00008067          	ret

0000000080002814 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002814:	ff010113          	addi	sp,sp,-16
    80002818:	00813423          	sd	s0,8(sp)
    8000281c:	01010413          	addi	s0,sp,16
    80002820:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002824:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002828:	0006c603          	lbu	a2,0(a3)
    8000282c:	fd06071b          	addiw	a4,a2,-48
    80002830:	0ff77713          	andi	a4,a4,255
    80002834:	00900793          	li	a5,9
    80002838:	02e7e063          	bltu	a5,a4,80002858 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000283c:	0025179b          	slliw	a5,a0,0x2
    80002840:	00a787bb          	addw	a5,a5,a0
    80002844:	0017979b          	slliw	a5,a5,0x1
    80002848:	00168693          	addi	a3,a3,1
    8000284c:	00c787bb          	addw	a5,a5,a2
    80002850:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002854:	fd5ff06f          	j	80002828 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002858:	00813403          	ld	s0,8(sp)
    8000285c:	01010113          	addi	sp,sp,16
    80002860:	00008067          	ret

0000000080002864 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002864:	fc010113          	addi	sp,sp,-64
    80002868:	02113c23          	sd	ra,56(sp)
    8000286c:	02813823          	sd	s0,48(sp)
    80002870:	02913423          	sd	s1,40(sp)
    80002874:	03213023          	sd	s2,32(sp)
    80002878:	01313c23          	sd	s3,24(sp)
    8000287c:	04010413          	addi	s0,sp,64
    80002880:	00050493          	mv	s1,a0
    80002884:	00058913          	mv	s2,a1
    80002888:	00060993          	mv	s3,a2
    LOCK();
    8000288c:	00100613          	li	a2,1
    80002890:	00000593          	li	a1,0
    80002894:	0000b517          	auipc	a0,0xb
    80002898:	cc450513          	addi	a0,a0,-828 # 8000d558 <lockPrint>
    8000289c:	ffffe097          	auipc	ra,0xffffe
    800028a0:	764080e7          	jalr	1892(ra) # 80001000 <copy_and_swap>
    800028a4:	fe0514e3          	bnez	a0,8000288c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800028a8:	00098463          	beqz	s3,800028b0 <_Z8printIntiii+0x4c>
    800028ac:	0804c463          	bltz	s1,80002934 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800028b0:	0004851b          	sext.w	a0,s1
    neg = 0;
    800028b4:	00000593          	li	a1,0
    }

    i = 0;
    800028b8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800028bc:	0009079b          	sext.w	a5,s2
    800028c0:	0325773b          	remuw	a4,a0,s2
    800028c4:	00048613          	mv	a2,s1
    800028c8:	0014849b          	addiw	s1,s1,1
    800028cc:	02071693          	slli	a3,a4,0x20
    800028d0:	0206d693          	srli	a3,a3,0x20
    800028d4:	0000a717          	auipc	a4,0xa
    800028d8:	7fc70713          	addi	a4,a4,2044 # 8000d0d0 <digits>
    800028dc:	00d70733          	add	a4,a4,a3
    800028e0:	00074683          	lbu	a3,0(a4)
    800028e4:	fd040713          	addi	a4,s0,-48
    800028e8:	00c70733          	add	a4,a4,a2
    800028ec:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800028f0:	0005071b          	sext.w	a4,a0
    800028f4:	0325553b          	divuw	a0,a0,s2
    800028f8:	fcf772e3          	bgeu	a4,a5,800028bc <_Z8printIntiii+0x58>
    if(neg)
    800028fc:	00058c63          	beqz	a1,80002914 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80002900:	fd040793          	addi	a5,s0,-48
    80002904:	009784b3          	add	s1,a5,s1
    80002908:	02d00793          	li	a5,45
    8000290c:	fef48823          	sb	a5,-16(s1)
    80002910:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002914:	fff4849b          	addiw	s1,s1,-1
    80002918:	0204c463          	bltz	s1,80002940 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    8000291c:	fd040793          	addi	a5,s0,-48
    80002920:	009787b3          	add	a5,a5,s1
    80002924:	ff07c503          	lbu	a0,-16(a5)
    80002928:	fffff097          	auipc	ra,0xfffff
    8000292c:	680080e7          	jalr	1664(ra) # 80001fa8 <_Z4putcc>
    80002930:	fe5ff06f          	j	80002914 <_Z8printIntiii+0xb0>
        x = -xx;
    80002934:	4090053b          	negw	a0,s1
        neg = 1;
    80002938:	00100593          	li	a1,1
        x = -xx;
    8000293c:	f7dff06f          	j	800028b8 <_Z8printIntiii+0x54>

    UNLOCK();
    80002940:	00000613          	li	a2,0
    80002944:	00100593          	li	a1,1
    80002948:	0000b517          	auipc	a0,0xb
    8000294c:	c1050513          	addi	a0,a0,-1008 # 8000d558 <lockPrint>
    80002950:	ffffe097          	auipc	ra,0xffffe
    80002954:	6b0080e7          	jalr	1712(ra) # 80001000 <copy_and_swap>
    80002958:	fe0514e3          	bnez	a0,80002940 <_Z8printIntiii+0xdc>
    8000295c:	03813083          	ld	ra,56(sp)
    80002960:	03013403          	ld	s0,48(sp)
    80002964:	02813483          	ld	s1,40(sp)
    80002968:	02013903          	ld	s2,32(sp)
    8000296c:	01813983          	ld	s3,24(sp)
    80002970:	04010113          	addi	sp,sp,64
    80002974:	00008067          	ret

0000000080002978 <_ZN3SCBC1Em>:
#include "../h/memoryAllocator.hpp"
#include "../h/printing.hpp"
#include "../h/consoleUtil.hpp"


SCB::SCB(uint64 init){
    80002978:	ff010113          	addi	sp,sp,-16
    8000297c:	00813423          	sd	s0,8(sp)
    80002980:	01010413          	addi	s0,sp,16
    val = init;
    80002984:	00b52023          	sw	a1,0(a0)
    blockedHead = nullptr;
    80002988:	00053423          	sd	zero,8(a0)
    blockedTail = nullptr;
    8000298c:	00053823          	sd	zero,16(a0)
}
    80002990:	00813403          	ld	s0,8(sp)
    80002994:	01010113          	addi	sp,sp,16
    80002998:	00008067          	ret

000000008000299c <_ZN3SCBD1Ev>:

//if there are any threads that are still blocked on semaphore when it is being deleted
//free those threads and set their semError field to point to this semaphore
SCB::~SCB(){
    8000299c:	fe010113          	addi	sp,sp,-32
    800029a0:	00113c23          	sd	ra,24(sp)
    800029a4:	00813823          	sd	s0,16(sp)
    800029a8:	00913423          	sd	s1,8(sp)
    800029ac:	01213023          	sd	s2,0(sp)
    800029b0:	02010413          	addi	s0,sp,32
    800029b4:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    800029b8:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    800029bc:	02050063          	beqz	a0,800029dc <_ZN3SCBD1Ev+0x40>
        TCB* tmp = iter;
        iter = iter->next;
    800029c0:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    800029c4:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    800029c8:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    800029cc:	00002097          	auipc	ra,0x2
    800029d0:	df4080e7          	jalr	-524(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    800029d4:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    800029d8:	fe5ff06f          	j	800029bc <_ZN3SCBD1Ev+0x20>
    }
}
    800029dc:	01813083          	ld	ra,24(sp)
    800029e0:	01013403          	ld	s0,16(sp)
    800029e4:	00813483          	ld	s1,8(sp)
    800029e8:	00013903          	ld	s2,0(sp)
    800029ec:	02010113          	addi	sp,sp,32
    800029f0:	00008067          	ret

00000000800029f4 <_ZN3SCB5blockEv>:

//block a thread by putting running thread at the end of blocked queue
void SCB::block() {
    800029f4:	ff010113          	addi	sp,sp,-16
    800029f8:	00113423          	sd	ra,8(sp)
    800029fc:	00813023          	sd	s0,0(sp)
    80002a00:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002a04:	00853783          	ld	a5,8(a0)
    80002a08:	04078063          	beqz	a5,80002a48 <_ZN3SCB5blockEv+0x54>
    80002a0c:	01053703          	ld	a4,16(a0)
    80002a10:	0000b797          	auipc	a5,0xb
    80002a14:	9707b783          	ld	a5,-1680(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002a18:	0007b783          	ld	a5,0(a5)
    80002a1c:	04f73423          	sd	a5,72(a4)
    80002a20:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002a24:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002a28:	00300713          	li	a4,3
    80002a2c:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002a30:	00000097          	auipc	ra,0x0
    80002a34:	2c0080e7          	jalr	704(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
}
    80002a38:	00813083          	ld	ra,8(sp)
    80002a3c:	00013403          	ld	s0,0(sp)
    80002a40:	01010113          	addi	sp,sp,16
    80002a44:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002a48:	0000b797          	auipc	a5,0xb
    80002a4c:	9387b783          	ld	a5,-1736(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002a50:	0007b783          	ld	a5,0(a5)
    80002a54:	00f53423          	sd	a5,8(a0)
    80002a58:	fc9ff06f          	j	80002a20 <_ZN3SCB5blockEv+0x2c>

0000000080002a5c <_ZN3SCB7deblockEv>:

//unblock a thread by fetching first from the blocked queue and putting it in scheduler
void SCB::deblock(){
    80002a5c:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    80002a60:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    80002a64:	04853703          	ld	a4,72(a0)
    80002a68:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    80002a6c:	04053423          	sd	zero,72(a0)
    if(tcb) {
    80002a70:	02050a63          	beqz	a0,80002aa4 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    80002a74:	ff010113          	addi	sp,sp,-16
    80002a78:	00113423          	sd	ra,8(sp)
    80002a7c:	00813023          	sd	s0,0(sp)
    80002a80:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    80002a84:	00100793          	li	a5,1
    80002a88:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002a8c:	00002097          	auipc	ra,0x2
    80002a90:	d34080e7          	jalr	-716(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
    }
}
    80002a94:	00813083          	ld	ra,8(sp)
    80002a98:	00013403          	ld	s0,0(sp)
    80002a9c:	01010113          	addi	sp,sp,16
    80002aa0:	00008067          	ret
    80002aa4:	00008067          	ret

0000000080002aa8 <_ZN3SCB4waitEv>:

void SCB::wait() {
    TCB::running->semError = nullptr;
    80002aa8:	0000b797          	auipc	a5,0xb
    80002aac:	8d87b783          	ld	a5,-1832(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80002ab0:	0007b783          	ld	a5,0(a5)
    80002ab4:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002ab8:	00052783          	lw	a5,0(a0)
    80002abc:	fff7879b          	addiw	a5,a5,-1
    80002ac0:	00f52023          	sw	a5,0(a0)
    80002ac4:	02079713          	slli	a4,a5,0x20
    80002ac8:	00074463          	bltz	a4,80002ad0 <_ZN3SCB4waitEv+0x28>
    80002acc:	00008067          	ret
void SCB::wait() {
    80002ad0:	ff010113          	addi	sp,sp,-16
    80002ad4:	00113423          	sd	ra,8(sp)
    80002ad8:	00813023          	sd	s0,0(sp)
    80002adc:	01010413          	addi	s0,sp,16
        block();
    80002ae0:	00000097          	auipc	ra,0x0
    80002ae4:	f14080e7          	jalr	-236(ra) # 800029f4 <_ZN3SCB5blockEv>
}
    80002ae8:	00813083          	ld	ra,8(sp)
    80002aec:	00013403          	ld	s0,0(sp)
    80002af0:	01010113          	addi	sp,sp,16
    80002af4:	00008067          	ret

0000000080002af8 <_ZN3SCB6signalEv>:

void SCB::signal(){
    if(val++<0)
    80002af8:	00052783          	lw	a5,0(a0)
    80002afc:	0017871b          	addiw	a4,a5,1
    80002b00:	00e52023          	sw	a4,0(a0)
    80002b04:	0007c463          	bltz	a5,80002b0c <_ZN3SCB6signalEv+0x14>
    80002b08:	00008067          	ret
void SCB::signal(){
    80002b0c:	ff010113          	addi	sp,sp,-16
    80002b10:	00113423          	sd	ra,8(sp)
    80002b14:	00813023          	sd	s0,0(sp)
    80002b18:	01010413          	addi	s0,sp,16
        deblock();
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	f40080e7          	jalr	-192(ra) # 80002a5c <_ZN3SCB7deblockEv>
}
    80002b24:	00813083          	ld	ra,8(sp)
    80002b28:	00013403          	ld	s0,0(sp)
    80002b2c:	01010113          	addi	sp,sp,16
    80002b30:	00008067          	ret

0000000080002b34 <_ZN3SCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* SCB::operator new(size_t size){
    80002b34:	ff010113          	addi	sp,sp,-16
    80002b38:	00113423          	sd	ra,8(sp)
    80002b3c:	00813023          	sd	s0,0(sp)
    80002b40:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002b44:	00000097          	auipc	ra,0x0
    80002b48:	3f4080e7          	jalr	1012(ra) # 80002f38 <_ZN15MemoryAllocator7kmallocEm>
}
    80002b4c:	00813083          	ld	ra,8(sp)
    80002b50:	00013403          	ld	s0,0(sp)
    80002b54:	01010113          	addi	sp,sp,16
    80002b58:	00008067          	ret

0000000080002b5c <_ZN3SCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void SCB::operator delete(void *addr){
    80002b5c:	ff010113          	addi	sp,sp,-16
    80002b60:	00113423          	sd	ra,8(sp)
    80002b64:	00813023          	sd	s0,0(sp)
    80002b68:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002b6c:	00000097          	auipc	ra,0x0
    80002b70:	5f4080e7          	jalr	1524(ra) # 80003160 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002b74:	00813083          	ld	ra,8(sp)
    80002b78:	00013403          	ld	s0,0(sp)
    80002b7c:	01010113          	addi	sp,sp,16
    80002b80:	00008067          	ret

0000000080002b84 <_ZN3SCB14semaphore_freeEPv>:

//syscall to free space that is taken up by semaphore
int SCB::semaphore_free(void *addr) {
    80002b84:	ff010113          	addi	sp,sp,-16
    80002b88:	00813423          	sd	s0,8(sp)
    80002b8c:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002b90:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002b94:	05200513          	li	a0,82
    asm("ecall");
    80002b98:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    80002b9c:	00050513          	mv	a0,a0
    return status;
}
    80002ba0:	0005051b          	sext.w	a0,a0
    80002ba4:	00813403          	ld	s0,8(sp)
    80002ba8:	01010113          	addi	sp,sp,16
    80002bac:	00008067          	ret

0000000080002bb0 <main>:
//
// Created by os on 4/28/22.
//
#include "../h/system.hpp"

int main() {
    80002bb0:	fe010113          	addi	sp,sp,-32
    80002bb4:	00113c23          	sd	ra,24(sp)
    80002bb8:	00813823          	sd	s0,16(sp)
    80002bbc:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002bc0:	fe840513          	addi	a0,s0,-24
    80002bc4:	fffff097          	auipc	ra,0xfffff
    80002bc8:	4a8080e7          	jalr	1192(ra) # 8000206c <_ZN6SystemC1Ev>

    return 0;
    80002bcc:	00000513          	li	a0,0
    80002bd0:	01813083          	ld	ra,24(sp)
    80002bd4:	01013403          	ld	s0,16(sp)
    80002bd8:	02010113          	addi	sp,sp,32
    80002bdc:	00008067          	ret

0000000080002be0 <_ZN3TCB7wrapperEPv>:
        contextSwitch(&old->context, &running->context);
    }
}

//wrapper function to run body function
void TCB::wrapper(void *args) {
    80002be0:	ff010113          	addi	sp,sp,-16
    80002be4:	00113423          	sd	ra,8(sp)
    80002be8:	00813023          	sd	s0,0(sp)
    80002bec:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    80002bf0:	00001097          	auipc	ra,0x1
    80002bf4:	c98080e7          	jalr	-872(ra) # 80003888 <_ZN5RiscV10popSppSpieEv>

    running->body(running->args);
    80002bf8:	0000b797          	auipc	a5,0xb
    80002bfc:	9687b783          	ld	a5,-1688(a5) # 8000d560 <_ZN3TCB7runningE>
    80002c00:	0187b703          	ld	a4,24(a5)
    80002c04:	0207b503          	ld	a0,32(a5)
    80002c08:	000700e7          	jalr	a4

    thread_exit();
    80002c0c:	fffff097          	auipc	ra,0xfffff
    80002c10:	19c080e7          	jalr	412(ra) # 80001da8 <_Z11thread_exitv>
}
    80002c14:	00813083          	ld	ra,8(sp)
    80002c18:	00013403          	ld	s0,0(sp)
    80002c1c:	01010113          	addi	sp,sp,16
    80002c20:	00008067          	ret

0000000080002c24 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    80002c24:	ff010113          	addi	sp,sp,-16
    80002c28:	00813423          	sd	s0,8(sp)
    80002c2c:	01010413          	addi	s0,sp,16
    80002c30:	04053823          	sd	zero,80(a0)
    80002c34:	04053c23          	sd	zero,88(a0)
    80002c38:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002c3c:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002c40:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002c44:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002c48:	04058263          	beqz	a1,80002c8c <_ZN3TCBC1EPFvPvES0_Pmm+0x68>
    80002c4c:	00068793          	mv	a5,a3
    80002c50:	02f53423          	sd	a5,40(a0)
    this->status = Status::READY;
    80002c54:	00100793          	li	a5,1
    80002c58:	00f52823          	sw	a5,16(a0)
    this->next = nullptr;
    80002c5c:	04053423          	sd	zero,72(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002c60:	02058a63          	beqz	a1,80002c94 <_ZN3TCBC1EPFvPvES0_Pmm+0x70>
    80002c64:	000017b7          	lui	a5,0x1
    80002c68:	00f686b3          	add	a3,a3,a5
    80002c6c:	00d53023          	sd	a3,0(a0)
    80002c70:	00000797          	auipc	a5,0x0
    80002c74:	f7078793          	addi	a5,a5,-144 # 80002be0 <_ZN3TCB7wrapperEPv>
    80002c78:	00f53423          	sd	a5,8(a0)
    this->mode = Mode::USER;
    80002c7c:	00052a23          	sw	zero,20(a0)
}
    80002c80:	00813403          	ld	s0,8(sp)
    80002c84:	01010113          	addi	sp,sp,16
    80002c88:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002c8c:	00000793          	li	a5,0
    80002c90:	fc1ff06f          	j	80002c50 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002c94:	00000693          	li	a3,0
    80002c98:	fd5ff06f          	j	80002c6c <_ZN3TCBC1EPFvPvES0_Pmm+0x48>

0000000080002c9c <_ZN3TCB4freeEv>:
void TCB::free(){
    80002c9c:	ff010113          	addi	sp,sp,-16
    80002ca0:	00113423          	sd	ra,8(sp)
    80002ca4:	00813023          	sd	s0,0(sp)
    80002ca8:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(stack);
    80002cac:	02853503          	ld	a0,40(a0)
    80002cb0:	00000097          	auipc	ra,0x0
    80002cb4:	4b0080e7          	jalr	1200(ra) # 80003160 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002cb8:	00813083          	ld	ra,8(sp)
    80002cbc:	00013403          	ld	s0,0(sp)
    80002cc0:	01010113          	addi	sp,sp,16
    80002cc4:	00008067          	ret

0000000080002cc8 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002cc8:	ff010113          	addi	sp,sp,-16
    80002ccc:	00113423          	sd	ra,8(sp)
    80002cd0:	00813023          	sd	s0,0(sp)
    80002cd4:	01010413          	addi	s0,sp,16
    free();
    80002cd8:	00000097          	auipc	ra,0x0
    80002cdc:	fc4080e7          	jalr	-60(ra) # 80002c9c <_ZN3TCB4freeEv>
}
    80002ce0:	00813083          	ld	ra,8(sp)
    80002ce4:	00013403          	ld	s0,0(sp)
    80002ce8:	01010113          	addi	sp,sp,16
    80002cec:	00008067          	ret

0000000080002cf0 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    80002cf0:	fe010113          	addi	sp,sp,-32
    80002cf4:	00113c23          	sd	ra,24(sp)
    80002cf8:	00813823          	sd	s0,16(sp)
    80002cfc:	00913423          	sd	s1,8(sp)
    80002d00:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002d04:	0000b497          	auipc	s1,0xb
    80002d08:	85c4b483          	ld	s1,-1956(s1) # 8000d560 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    80002d0c:	0104a703          	lw	a4,16(s1)
    80002d10:	00100793          	li	a5,1
    80002d14:	04e7f663          	bgeu	a5,a4,80002d60 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    80002d18:	00002097          	auipc	ra,0x2
    80002d1c:	af0080e7          	jalr	-1296(ra) # 80004808 <_ZN9Scheduler3getEv>
    80002d20:	0000b797          	auipc	a5,0xb
    80002d24:	84a7b023          	sd	a0,-1984(a5) # 8000d560 <_ZN3TCB7runningE>
    if(running) {
    80002d28:	02050263          	beqz	a0,80002d4c <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    80002d2c:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    80002d30:	00001097          	auipc	ra,0x1
    80002d34:	c8c080e7          	jalr	-884(ra) # 800039bc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002d38:	0000b597          	auipc	a1,0xb
    80002d3c:	8285b583          	ld	a1,-2008(a1) # 8000d560 <_ZN3TCB7runningE>
    80002d40:	00048513          	mv	a0,s1
    80002d44:	ffffe097          	auipc	ra,0xffffe
    80002d48:	3fc080e7          	jalr	1020(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002d4c:	01813083          	ld	ra,24(sp)
    80002d50:	01013403          	ld	s0,16(sp)
    80002d54:	00813483          	ld	s1,8(sp)
    80002d58:	02010113          	addi	sp,sp,32
    80002d5c:	00008067          	ret
        Scheduler::put(old);
    80002d60:	00048513          	mv	a0,s1
    80002d64:	00002097          	auipc	ra,0x2
    80002d68:	a5c080e7          	jalr	-1444(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
    80002d6c:	fadff06f          	j	80002d18 <_ZN3TCB8dispatchEv+0x28>

0000000080002d70 <_ZN3TCBnwEm>:

//overload operator new, to not use system call for every kernel object that is being allocated
void* TCB::operator new(size_t size){
    80002d70:	ff010113          	addi	sp,sp,-16
    80002d74:	00113423          	sd	ra,8(sp)
    80002d78:	00813023          	sd	s0,0(sp)
    80002d7c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::kmalloc(size);
    80002d80:	00000097          	auipc	ra,0x0
    80002d84:	1b8080e7          	jalr	440(ra) # 80002f38 <_ZN15MemoryAllocator7kmallocEm>
}
    80002d88:	00813083          	ld	ra,8(sp)
    80002d8c:	00013403          	ld	s0,0(sp)
    80002d90:	01010113          	addi	sp,sp,16
    80002d94:	00008067          	ret

0000000080002d98 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002d98:	fd010113          	addi	sp,sp,-48
    80002d9c:	02113423          	sd	ra,40(sp)
    80002da0:	02813023          	sd	s0,32(sp)
    80002da4:	00913c23          	sd	s1,24(sp)
    80002da8:	01213823          	sd	s2,16(sp)
    80002dac:	01313423          	sd	s3,8(sp)
    80002db0:	01413023          	sd	s4,0(sp)
    80002db4:	03010413          	addi	s0,sp,48
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002db8:	07000513          	li	a0,112
    80002dbc:	00000097          	auipc	ra,0x0
    80002dc0:	fb4080e7          	jalr	-76(ra) # 80002d70 <_ZN3TCBnwEm>
    80002dc4:	00050493          	mv	s1,a0
    80002dc8:	00200713          	li	a4,2
    80002dcc:	00000693          	li	a3,0
    80002dd0:	00000613          	li	a2,0
    80002dd4:	00000593          	li	a1,0
    80002dd8:	00000097          	auipc	ra,0x0
    80002ddc:	e4c080e7          	jalr	-436(ra) # 80002c24 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002de0:	0000aa17          	auipc	s4,0xa
    80002de4:	780a0a13          	addi	s4,s4,1920 # 8000d560 <_ZN3TCB7runningE>
    80002de8:	009a3023          	sd	s1,0(s4)
    TCB::running->mode = Mode::SUPERVISOR;
    80002dec:	00100993          	li	s3,1
    80002df0:	0134aa23          	sw	s3,20(s1)
    uint64 *putcStack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80002df4:	04000513          	li	a0,64
    80002df8:	00000097          	auipc	ra,0x0
    80002dfc:	140080e7          	jalr	320(ra) # 80002f38 <_ZN15MemoryAllocator7kmallocEm>
    80002e00:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    80002e04:	07000513          	li	a0,112
    80002e08:	00000097          	auipc	ra,0x0
    80002e0c:	f68080e7          	jalr	-152(ra) # 80002d70 <_ZN3TCBnwEm>
    80002e10:	00050493          	mv	s1,a0
    80002e14:	00200713          	li	a4,2
    80002e18:	00090693          	mv	a3,s2
    80002e1c:	00000613          	li	a2,0
    80002e20:	0000a597          	auipc	a1,0xa
    80002e24:	5005b583          	ld	a1,1280(a1) # 8000d320 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002e28:	00000097          	auipc	ra,0x0
    80002e2c:	dfc080e7          	jalr	-516(ra) # 80002c24 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002e30:	009a3423          	sd	s1,8(s4)
    putcThread->mode = Mode::SUPERVISOR;
    80002e34:	0134aa23          	sw	s3,20(s1)
    Scheduler::put(putcThread);
    80002e38:	00048513          	mv	a0,s1
    80002e3c:	00002097          	auipc	ra,0x2
    80002e40:	984080e7          	jalr	-1660(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
}
    80002e44:	02813083          	ld	ra,40(sp)
    80002e48:	02013403          	ld	s0,32(sp)
    80002e4c:	01813483          	ld	s1,24(sp)
    80002e50:	01013903          	ld	s2,16(sp)
    80002e54:	00813983          	ld	s3,8(sp)
    80002e58:	00013a03          	ld	s4,0(sp)
    80002e5c:	03010113          	addi	sp,sp,48
    80002e60:	00008067          	ret

0000000080002e64 <_ZN3TCBdlEPv>:

//overload operator delete, to not use system call for every kernel object that is being deallocated
void TCB::operator delete(void *addr){
    80002e64:	ff010113          	addi	sp,sp,-16
    80002e68:	00113423          	sd	ra,8(sp)
    80002e6c:	00813023          	sd	s0,0(sp)
    80002e70:	01010413          	addi	s0,sp,16
    MemoryAllocator::kfree(addr);
    80002e74:	00000097          	auipc	ra,0x0
    80002e78:	2ec080e7          	jalr	748(ra) # 80003160 <_ZN15MemoryAllocator5kfreeEPv>
}
    80002e7c:	00813083          	ld	ra,8(sp)
    80002e80:	00013403          	ld	s0,0(sp)
    80002e84:	01010113          	addi	sp,sp,16
    80002e88:	00008067          	ret

0000000080002e8c <_ZN3TCB11thread_freeEPv>:

//internal syscall to free space allocated to a thread
int TCB::thread_free(void *addr) {
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00813423          	sd	s0,8(sp)
    80002e94:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002e98:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002e9c:	05100513          	li	a0,81
    asm("ecall");
    80002ea0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    80002ea4:	00050513          	mv	a0,a0
    return status;
    80002ea8:	0005051b          	sext.w	a0,a0
    80002eac:	00813403          	ld	s0,8(sp)
    80002eb0:	01010113          	addi	sp,sp,16
    80002eb4:	00008067          	ret

0000000080002eb8 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002eb8:	ff010113          	addi	sp,sp,-16
    80002ebc:	00813423          	sd	s0,8(sp)
    80002ec0:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002ec4:	0000a797          	auipc	a5,0xa
    80002ec8:	44c7b783          	ld	a5,1100(a5) # 8000d310 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002ecc:	0007b603          	ld	a2,0(a5)
    80002ed0:	00c65793          	srli	a5,a2,0xc
    80002ed4:	00278793          	addi	a5,a5,2
    80002ed8:	00c79793          	slli	a5,a5,0xc
    80002edc:	01000737          	lui	a4,0x1000
    80002ee0:	00e787b3          	add	a5,a5,a4
    80002ee4:	0000a717          	auipc	a4,0xa
    80002ee8:	6a470713          	addi	a4,a4,1700 # 8000d588 <_ZN15MemoryAllocator11freeMemTailE>
    80002eec:	00f73023          	sd	a5,0(a4)
    80002ef0:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002ef4:	0007b823          	sd	zero,16(a5)
    80002ef8:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002efc:	00073823          	sd	zero,16(a4)
    80002f00:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(BlockHeader);
    80002f04:	0000a697          	auipc	a3,0xa
    80002f08:	48c6b683          	ld	a3,1164(a3) # 8000d390 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002f0c:	0006b683          	ld	a3,0(a3)
    80002f10:	40c686b3          	sub	a3,a3,a2
    80002f14:	fe868693          	addi	a3,a3,-24
    80002f18:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002f1c:	00873783          	ld	a5,8(a4)
    80002f20:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002f24:	00100793          	li	a5,1
    80002f28:	02f70023          	sb	a5,32(a4)
}
    80002f2c:	00813403          	ld	s0,8(sp)
    80002f30:	01010113          	addi	sp,sp,16
    80002f34:	00008067          	ret

0000000080002f38 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002f38:	ff010113          	addi	sp,sp,-16
    80002f3c:	00813423          	sd	s0,8(sp)
    80002f40:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr)
    80002f44:	14050263          	beqz	a0,80003088 <_ZN15MemoryAllocator7kmallocEm+0x150>
    80002f48:	00050793          	mv	a5,a0
    80002f4c:	0000a517          	auipc	a0,0xa
    80002f50:	64453503          	ld	a0,1604(a0) # 8000d590 <_ZN15MemoryAllocator11freeMemHeadE>
    80002f54:	0a050a63          	beqz	a0,80003008 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002f58:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002f5c:	00000613          	li	a2,0
    80002f60:	00c0006f          	j	80002f6c <_ZN15MemoryAllocator7kmallocEm+0x34>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002f64:	00050613          	mv	a2,a0
    80002f68:	01053503          	ld	a0,16(a0)
    80002f6c:	00050863          	beqz	a0,80002f7c <_ZN15MemoryAllocator7kmallocEm+0x44>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002f70:	00053683          	ld	a3,0(a0)
    80002f74:	01878713          	addi	a4,a5,24
    80002f78:	fee6e6e3          	bltu	a3,a4,80002f64 <_ZN15MemoryAllocator7kmallocEm+0x2c>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002f7c:	08050663          	beqz	a0,80003008 <_ZN15MemoryAllocator7kmallocEm+0xd0>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) <HEAP_END_ADDR)
    80002f80:	00053683          	ld	a3,0(a0)
    80002f84:	01868713          	addi	a4,a3,24
    80002f88:	00e50733          	add	a4,a0,a4
    80002f8c:	0000a597          	auipc	a1,0xa
    80002f90:	4045b583          	ld	a1,1028(a1) # 8000d390 <_GLOBAL_OFFSET_TABLE_+0x98>
    80002f94:	0005b583          	ld	a1,0(a1)
    80002f98:	00b76463          	bltu	a4,a1,80002fa0 <_ZN15MemoryAllocator7kmallocEm+0x68>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002f9c:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002fa0:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002fa4:	05700593          	li	a1,87
    80002fa8:	08d5f063          	bgeu	a1,a3,80003028 <_ZN15MemoryAllocator7kmallocEm+0xf0>

            blk->size = byteSize;
    80002fac:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002fb0:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002fb4:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002fb8:	01053583          	ld	a1,16(a0)
    80002fbc:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002fc0:	00853583          	ld	a1,8(a0)
    80002fc4:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80002fc8:	fe868693          	addi	a3,a3,-24
    80002fcc:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002fd0:	04060263          	beqz	a2,80003014 <_ZN15MemoryAllocator7kmallocEm+0xdc>
                prev->next = newBlk;
    80002fd4:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80002fd8:	0000a797          	auipc	a5,0xa
    80002fdc:	5c87b783          	ld	a5,1480(a5) # 8000d5a0 <_ZN15MemoryAllocator12allocMemHeadE>
    80002fe0:	06078463          	beqz	a5,80003048 <_ZN15MemoryAllocator7kmallocEm+0x110>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002fe4:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80002fe8:	08070063          	beqz	a4,80003068 <_ZN15MemoryAllocator7kmallocEm+0x130>
                blk->prev = nextAllocated->prev;
    80002fec:	00873783          	ld	a5,8(a4)
    80002ff0:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002ff4:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80002ff8:	00873783          	ld	a5,8(a4)
    80002ffc:	06078063          	beqz	a5,8000305c <_ZN15MemoryAllocator7kmallocEm+0x124>
                    nextAllocated->prev = blk;
    80003000:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80003004:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80003008:	00813403          	ld	s0,8(sp)
    8000300c:	01010113          	addi	sp,sp,16
    80003010:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80003014:	0000a697          	auipc	a3,0xa
    80003018:	57468693          	addi	a3,a3,1396 # 8000d588 <_ZN15MemoryAllocator11freeMemTailE>
    8000301c:	00f6b023          	sd	a5,0(a3)
    80003020:	00f6b423          	sd	a5,8(a3)
    80003024:	fb5ff06f          	j	80002fd8 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            if (prev) prev->next = blk->next;
    80003028:	00060863          	beqz	a2,80003038 <_ZN15MemoryAllocator7kmallocEm+0x100>
    8000302c:	01053783          	ld	a5,16(a0)
    80003030:	00f63823          	sd	a5,16(a2)
    80003034:	fa5ff06f          	j	80002fd8 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            else freeMemHead = blk->next;
    80003038:	01053783          	ld	a5,16(a0)
    8000303c:	0000a697          	auipc	a3,0xa
    80003040:	54f6ba23          	sd	a5,1364(a3) # 8000d590 <_ZN15MemoryAllocator11freeMemHeadE>
    80003044:	f95ff06f          	j	80002fd8 <_ZN15MemoryAllocator7kmallocEm+0xa0>
            allocMemHead = allocMemTail = blk;
    80003048:	0000a797          	auipc	a5,0xa
    8000304c:	54078793          	addi	a5,a5,1344 # 8000d588 <_ZN15MemoryAllocator11freeMemTailE>
    80003050:	00a7b823          	sd	a0,16(a5)
    80003054:	00a7bc23          	sd	a0,24(a5)
    80003058:	fadff06f          	j	80003004 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                    allocMemHead = blk;
    8000305c:	0000a797          	auipc	a5,0xa
    80003060:	54a7b223          	sd	a0,1348(a5) # 8000d5a0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003064:	fa1ff06f          	j	80003004 <_ZN15MemoryAllocator7kmallocEm+0xcc>
                allocMemTail->next = blk;
    80003068:	0000a797          	auipc	a5,0xa
    8000306c:	52078793          	addi	a5,a5,1312 # 8000d588 <_ZN15MemoryAllocator11freeMemTailE>
    80003070:	0107b703          	ld	a4,16(a5)
    80003074:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80003078:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    8000307c:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80003080:	00a7b823          	sd	a0,16(a5)
    80003084:	f81ff06f          	j	80003004 <_ZN15MemoryAllocator7kmallocEm+0xcc>
        return nullptr;
    80003088:	00000513          	li	a0,0
    8000308c:	f7dff06f          	j	80003008 <_ZN15MemoryAllocator7kmallocEm+0xd0>

0000000080003090 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80003090:	ff010113          	addi	sp,sp,-16
    80003094:	00813423          	sd	s0,8(sp)
    80003098:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    8000309c:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800030a0:	00000713          	li	a4,0
    800030a4:	00078a63          	beqz	a5,800030b8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    800030a8:	00a7f863          	bgeu	a5,a0,800030b8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    800030ac:	00078713          	mv	a4,a5
    800030b0:	0107b783          	ld	a5,16(a5)
    800030b4:	ff1ff06f          	j	800030a4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    800030b8:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    800030bc:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    800030c0:	00078463          	beqz	a5,800030c8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    800030c4:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    800030c8:	02070263          	beqz	a4,800030ec <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    800030cc:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    800030d0:	0005b703          	ld	a4,0(a1)
    800030d4:	0000a797          	auipc	a5,0xa
    800030d8:	4bc7b783          	ld	a5,1212(a5) # 8000d590 <_ZN15MemoryAllocator11freeMemHeadE>
    800030dc:	00f70c63          	beq	a4,a5,800030f4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    800030e0:	00813403          	ld	s0,8(sp)
    800030e4:	01010113          	addi	sp,sp,16
    800030e8:	00008067          	ret
        *head = blk;
    800030ec:	00a5b023          	sd	a0,0(a1)
    800030f0:	fe1ff06f          	j	800030d0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    800030f4:	01053783          	ld	a5,16(a0)
    800030f8:	00078a63          	beqz	a5,8000310c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    800030fc:	00053683          	ld	a3,0(a0)
    80003100:	00d50733          	add	a4,a0,a3
    80003104:	01870713          	addi	a4,a4,24
    80003108:	02f70e63          	beq	a4,a5,80003144 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    8000310c:	00853783          	ld	a5,8(a0)
    80003110:	fc0788e3          	beqz	a5,800030e0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80003114:	0007b683          	ld	a3,0(a5)
    80003118:	00d78733          	add	a4,a5,a3
    8000311c:	01870713          	addi	a4,a4,24
    80003120:	fca710e3          	bne	a4,a0,800030e0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80003124:	00053703          	ld	a4,0(a0)
    80003128:	00e68733          	add	a4,a3,a4
    8000312c:	01870713          	addi	a4,a4,24
    80003130:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80003134:	00853783          	ld	a5,8(a0)
    80003138:	01053703          	ld	a4,16(a0)
    8000313c:	00e7b823          	sd	a4,16(a5)
}
    80003140:	fa1ff06f          	j	800030e0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80003144:	0007b703          	ld	a4,0(a5)
    80003148:	00e68733          	add	a4,a3,a4
    8000314c:	01870713          	addi	a4,a4,24
    80003150:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80003154:	0107b783          	ld	a5,16(a5)
    80003158:	00f53823          	sd	a5,16(a0)
    8000315c:	fb1ff06f          	j	8000310c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080003160 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80003160:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80003164:	0000a697          	auipc	a3,0xa
    80003168:	43c6b683          	ld	a3,1084(a3) # 8000d5a0 <_ZN15MemoryAllocator12allocMemHeadE>
    8000316c:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80003170:	00050a63          	beqz	a0,80003184 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80003174:	fe870793          	addi	a5,a4,-24
    80003178:	00a78663          	beq	a5,a0,80003184 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    8000317c:	01053503          	ld	a0,16(a0)
    80003180:	ff1ff06f          	j	80003170 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80003184:	08050463          	beqz	a0,8000320c <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80003188:	ff010113          	addi	sp,sp,-16
    8000318c:	00113423          	sd	ra,8(sp)
    80003190:	00813023          	sd	s0,0(sp)
    80003194:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80003198:	0000a797          	auipc	a5,0xa
    8000319c:	4007b783          	ld	a5,1024(a5) # 8000d598 <_ZN15MemoryAllocator12allocMemTailE>
    800031a0:	04a78663          	beq	a5,a0,800031ec <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    800031a4:	04d50c63          	beq	a0,a3,800031fc <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    800031a8:	01053783          	ld	a5,16(a0)
    800031ac:	00078663          	beqz	a5,800031b8 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    800031b0:	00853703          	ld	a4,8(a0)
    800031b4:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    800031b8:	00853783          	ld	a5,8(a0)
    800031bc:	00078663          	beqz	a5,800031c8 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    800031c0:	01053703          	ld	a4,16(a0)
    800031c4:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    800031c8:	0000a597          	auipc	a1,0xa
    800031cc:	3c858593          	addi	a1,a1,968 # 8000d590 <_ZN15MemoryAllocator11freeMemHeadE>
    800031d0:	00000097          	auipc	ra,0x0
    800031d4:	ec0080e7          	jalr	-320(ra) # 80003090 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    800031d8:	00000513          	li	a0,0
}
    800031dc:	00813083          	ld	ra,8(sp)
    800031e0:	00013403          	ld	s0,0(sp)
    800031e4:	01010113          	addi	sp,sp,16
    800031e8:	00008067          	ret
            allocMemTail = blk->prev;
    800031ec:	00853783          	ld	a5,8(a0)
    800031f0:	0000a717          	auipc	a4,0xa
    800031f4:	3af73423          	sd	a5,936(a4) # 8000d598 <_ZN15MemoryAllocator12allocMemTailE>
    800031f8:	fadff06f          	j	800031a4 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    800031fc:	01053783          	ld	a5,16(a0)
    80003200:	0000a717          	auipc	a4,0xa
    80003204:	3af73023          	sd	a5,928(a4) # 8000d5a0 <_ZN15MemoryAllocator12allocMemHeadE>
    80003208:	fa1ff06f          	j	800031a8 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    8000320c:	fff00513          	li	a0,-1
}
    80003210:	00008067          	ret

0000000080003214 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80003214:	fe010113          	addi	sp,sp,-32
    80003218:	00113c23          	sd	ra,24(sp)
    8000321c:	00813823          	sd	s0,16(sp)
    80003220:	00913423          	sd	s1,8(sp)
    80003224:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80003228:	0000a497          	auipc	s1,0xa
    8000322c:	3784b483          	ld	s1,888(s1) # 8000d5a0 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80003230:	00007517          	auipc	a0,0x7
    80003234:	04850513          	addi	a0,a0,72 # 8000a278 <CONSOLE_STATUS+0x268>
    80003238:	fffff097          	auipc	ra,0xfffff
    8000323c:	494080e7          	jalr	1172(ra) # 800026cc <_Z11printStringPKc>
    while(iter!=nullptr){
    80003240:	04048663          	beqz	s1,8000328c <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80003244:	00000613          	li	a2,0
    80003248:	00a00593          	li	a1,10
    8000324c:	0004851b          	sext.w	a0,s1
    80003250:	fffff097          	auipc	ra,0xfffff
    80003254:	614080e7          	jalr	1556(ra) # 80002864 <_Z8printIntiii>
        putc(' ');
    80003258:	02000513          	li	a0,32
    8000325c:	fffff097          	auipc	ra,0xfffff
    80003260:	d4c080e7          	jalr	-692(ra) # 80001fa8 <_Z4putcc>
        printInt(iter->size);
    80003264:	00000613          	li	a2,0
    80003268:	00a00593          	li	a1,10
    8000326c:	0004a503          	lw	a0,0(s1)
    80003270:	fffff097          	auipc	ra,0xfffff
    80003274:	5f4080e7          	jalr	1524(ra) # 80002864 <_Z8printIntiii>
        putc('\n');
    80003278:	00a00513          	li	a0,10
    8000327c:	fffff097          	auipc	ra,0xfffff
    80003280:	d2c080e7          	jalr	-724(ra) # 80001fa8 <_Z4putcc>
        iter=iter->next;
    80003284:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80003288:	fb9ff06f          	j	80003240 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    8000328c:	00007517          	auipc	a0,0x7
    80003290:	00c50513          	addi	a0,a0,12 # 8000a298 <CONSOLE_STATUS+0x288>
    80003294:	fffff097          	auipc	ra,0xfffff
    80003298:	438080e7          	jalr	1080(ra) # 800026cc <_Z11printStringPKc>
    iter = freeMemHead;
    8000329c:	0000a497          	auipc	s1,0xa
    800032a0:	2f44b483          	ld	s1,756(s1) # 8000d590 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    800032a4:	04048663          	beqz	s1,800032f0 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    800032a8:	00000613          	li	a2,0
    800032ac:	00a00593          	li	a1,10
    800032b0:	0004851b          	sext.w	a0,s1
    800032b4:	fffff097          	auipc	ra,0xfffff
    800032b8:	5b0080e7          	jalr	1456(ra) # 80002864 <_Z8printIntiii>
        putc(' ');
    800032bc:	02000513          	li	a0,32
    800032c0:	fffff097          	auipc	ra,0xfffff
    800032c4:	ce8080e7          	jalr	-792(ra) # 80001fa8 <_Z4putcc>
        printInt(iter->size);
    800032c8:	00000613          	li	a2,0
    800032cc:	00a00593          	li	a1,10
    800032d0:	0004a503          	lw	a0,0(s1)
    800032d4:	fffff097          	auipc	ra,0xfffff
    800032d8:	590080e7          	jalr	1424(ra) # 80002864 <_Z8printIntiii>
        putc('\n');
    800032dc:	00a00513          	li	a0,10
    800032e0:	fffff097          	auipc	ra,0xfffff
    800032e4:	cc8080e7          	jalr	-824(ra) # 80001fa8 <_Z4putcc>
        iter=iter->next;
    800032e8:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    800032ec:	fb9ff06f          	j	800032a4 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    800032f0:	00007517          	auipc	a0,0x7
    800032f4:	fc850513          	addi	a0,a0,-56 # 8000a2b8 <CONSOLE_STATUS+0x2a8>
    800032f8:	fffff097          	auipc	ra,0xfffff
    800032fc:	3d4080e7          	jalr	980(ra) # 800026cc <_Z11printStringPKc>
}
    80003300:	01813083          	ld	ra,24(sp)
    80003304:	01013403          	ld	s0,16(sp)
    80003308:	00813483          	ld	s1,8(sp)
    8000330c:	02010113          	addi	sp,sp,32
    80003310:	00008067          	ret

0000000080003314 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80003314:	ff010113          	addi	sp,sp,-16
    80003318:	00813423          	sd	s0,8(sp)
    8000331c:	01010413          	addi	s0,sp,16
    80003320:	00050813          	mv	a6,a0
    80003324:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80003328:	00000793          	li	a5,0
    8000332c:	00c7fe63          	bgeu	a5,a2,80003348 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80003330:	00f50733          	add	a4,a0,a5
    80003334:	00f806b3          	add	a3,a6,a5
    80003338:	0006c683          	lbu	a3,0(a3)
    8000333c:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80003340:	00178793          	addi	a5,a5,1
    80003344:	fe9ff06f          	j	8000332c <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80003348:	00813403          	ld	s0,8(sp)
    8000334c:	01010113          	addi	sp,sp,16
    80003350:	00008067          	ret

0000000080003354 <_ZN6Thread7wrapperEPv>:

Thread::Thread(void (*body)(void*), void *arg) {
    thread_attach_body(&myHandle, body, arg);
}

void Thread::wrapper(void *arg) {
    80003354:	ff010113          	addi	sp,sp,-16
    80003358:	00113423          	sd	ra,8(sp)
    8000335c:	00813023          	sd	s0,0(sp)
    80003360:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80003364:	00053783          	ld	a5,0(a0)
    80003368:	0107b783          	ld	a5,16(a5)
    8000336c:	000780e7          	jalr	a5
}
    80003370:	00813083          	ld	ra,8(sp)
    80003374:	00013403          	ld	s0,0(sp)
    80003378:	01010113          	addi	sp,sp,16
    8000337c:	00008067          	ret

0000000080003380 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80003380:	ff010113          	addi	sp,sp,-16
    80003384:	00113423          	sd	ra,8(sp)
    80003388:	00813023          	sd	s0,0(sp)
    8000338c:	01010413          	addi	s0,sp,16
    80003390:	0000a797          	auipc	a5,0xa
    80003394:	da078793          	addi	a5,a5,-608 # 8000d130 <_ZTV9Semaphore+0x10>
    80003398:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000339c:	00853503          	ld	a0,8(a0)
    800033a0:	fffff097          	auipc	ra,0xfffff
    800033a4:	b30080e7          	jalr	-1232(ra) # 80001ed0 <_Z9sem_closeP10_semaphore>
};
    800033a8:	00813083          	ld	ra,8(sp)
    800033ac:	00013403          	ld	s0,0(sp)
    800033b0:	01010113          	addi	sp,sp,16
    800033b4:	00008067          	ret

00000000800033b8 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    800033b8:	0000a797          	auipc	a5,0xa
    800033bc:	d9878793          	addi	a5,a5,-616 # 8000d150 <_ZTV6Thread+0x10>
    800033c0:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    800033c4:	00853503          	ld	a0,8(a0)
    800033c8:	02050663          	beqz	a0,800033f4 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    800033cc:	ff010113          	addi	sp,sp,-16
    800033d0:	00113423          	sd	ra,8(sp)
    800033d4:	00813023          	sd	s0,0(sp)
    800033d8:	01010413          	addi	s0,sp,16
    delete myHandle;
    800033dc:	fffff097          	auipc	ra,0xfffff
    800033e0:	c40080e7          	jalr	-960(ra) # 8000201c <_ZN7_threaddlEPv>
}
    800033e4:	00813083          	ld	ra,8(sp)
    800033e8:	00013403          	ld	s0,0(sp)
    800033ec:	01010113          	addi	sp,sp,16
    800033f0:	00008067          	ret
    800033f4:	00008067          	ret

00000000800033f8 <_Znwm>:
void* operator new(size_t sz){
    800033f8:	ff010113          	addi	sp,sp,-16
    800033fc:	00113423          	sd	ra,8(sp)
    80003400:	00813023          	sd	s0,0(sp)
    80003404:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003408:	fffff097          	auipc	ra,0xfffff
    8000340c:	8c8080e7          	jalr	-1848(ra) # 80001cd0 <_Z9mem_allocm>
}
    80003410:	00813083          	ld	ra,8(sp)
    80003414:	00013403          	ld	s0,0(sp)
    80003418:	01010113          	addi	sp,sp,16
    8000341c:	00008067          	ret

0000000080003420 <_Znam>:
void* operator new[](size_t sz){
    80003420:	ff010113          	addi	sp,sp,-16
    80003424:	00113423          	sd	ra,8(sp)
    80003428:	00813023          	sd	s0,0(sp)
    8000342c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80003430:	fffff097          	auipc	ra,0xfffff
    80003434:	8a0080e7          	jalr	-1888(ra) # 80001cd0 <_Z9mem_allocm>
}
    80003438:	00813083          	ld	ra,8(sp)
    8000343c:	00013403          	ld	s0,0(sp)
    80003440:	01010113          	addi	sp,sp,16
    80003444:	00008067          	ret

0000000080003448 <_ZdlPv>:
void operator delete(void *ptr){
    80003448:	ff010113          	addi	sp,sp,-16
    8000344c:	00113423          	sd	ra,8(sp)
    80003450:	00813023          	sd	s0,0(sp)
    80003454:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80003458:	fffff097          	auipc	ra,0xfffff
    8000345c:	8a8080e7          	jalr	-1880(ra) # 80001d00 <_Z8mem_freePv>
}
    80003460:	00813083          	ld	ra,8(sp)
    80003464:	00013403          	ld	s0,0(sp)
    80003468:	01010113          	addi	sp,sp,16
    8000346c:	00008067          	ret

0000000080003470 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80003470:	fe010113          	addi	sp,sp,-32
    80003474:	00113c23          	sd	ra,24(sp)
    80003478:	00813823          	sd	s0,16(sp)
    8000347c:	00913423          	sd	s1,8(sp)
    80003480:	02010413          	addi	s0,sp,32
    80003484:	00050493          	mv	s1,a0
};
    80003488:	00000097          	auipc	ra,0x0
    8000348c:	ef8080e7          	jalr	-264(ra) # 80003380 <_ZN9SemaphoreD1Ev>
    80003490:	00048513          	mv	a0,s1
    80003494:	00000097          	auipc	ra,0x0
    80003498:	fb4080e7          	jalr	-76(ra) # 80003448 <_ZdlPv>
    8000349c:	01813083          	ld	ra,24(sp)
    800034a0:	01013403          	ld	s0,16(sp)
    800034a4:	00813483          	ld	s1,8(sp)
    800034a8:	02010113          	addi	sp,sp,32
    800034ac:	00008067          	ret

00000000800034b0 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800034b0:	fe010113          	addi	sp,sp,-32
    800034b4:	00113c23          	sd	ra,24(sp)
    800034b8:	00813823          	sd	s0,16(sp)
    800034bc:	00913423          	sd	s1,8(sp)
    800034c0:	02010413          	addi	s0,sp,32
    800034c4:	00050493          	mv	s1,a0
}
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	ef0080e7          	jalr	-272(ra) # 800033b8 <_ZN6ThreadD1Ev>
    800034d0:	00048513          	mv	a0,s1
    800034d4:	00000097          	auipc	ra,0x0
    800034d8:	f74080e7          	jalr	-140(ra) # 80003448 <_ZdlPv>
    800034dc:	01813083          	ld	ra,24(sp)
    800034e0:	01013403          	ld	s0,16(sp)
    800034e4:	00813483          	ld	s1,8(sp)
    800034e8:	02010113          	addi	sp,sp,32
    800034ec:	00008067          	ret

00000000800034f0 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    800034f0:	ff010113          	addi	sp,sp,-16
    800034f4:	00113423          	sd	ra,8(sp)
    800034f8:	00813023          	sd	s0,0(sp)
    800034fc:	01010413          	addi	s0,sp,16
    80003500:	0000a797          	auipc	a5,0xa
    80003504:	c3078793          	addi	a5,a5,-976 # 8000d130 <_ZTV9Semaphore+0x10>
    80003508:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    8000350c:	00850513          	addi	a0,a0,8
    80003510:	fffff097          	auipc	ra,0xfffff
    80003514:	988080e7          	jalr	-1656(ra) # 80001e98 <_Z8sem_openPP10_semaphorej>
}
    80003518:	00813083          	ld	ra,8(sp)
    8000351c:	00013403          	ld	s0,0(sp)
    80003520:	01010113          	addi	sp,sp,16
    80003524:	00008067          	ret

0000000080003528 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80003528:	ff010113          	addi	sp,sp,-16
    8000352c:	00113423          	sd	ra,8(sp)
    80003530:	00813023          	sd	s0,0(sp)
    80003534:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80003538:	00853503          	ld	a0,8(a0)
    8000353c:	fffff097          	auipc	ra,0xfffff
    80003540:	9c0080e7          	jalr	-1600(ra) # 80001efc <_Z8sem_waitP10_semaphore>
}
    80003544:	00813083          	ld	ra,8(sp)
    80003548:	00013403          	ld	s0,0(sp)
    8000354c:	01010113          	addi	sp,sp,16
    80003550:	00008067          	ret

0000000080003554 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80003554:	ff010113          	addi	sp,sp,-16
    80003558:	00113423          	sd	ra,8(sp)
    8000355c:	00813023          	sd	s0,0(sp)
    80003560:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80003564:	00853503          	ld	a0,8(a0)
    80003568:	fffff097          	auipc	ra,0xfffff
    8000356c:	9c0080e7          	jalr	-1600(ra) # 80001f28 <_Z10sem_signalP10_semaphore>
}
    80003570:	00813083          	ld	ra,8(sp)
    80003574:	00013403          	ld	s0,0(sp)
    80003578:	01010113          	addi	sp,sp,16
    8000357c:	00008067          	ret

0000000080003580 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80003580:	ff010113          	addi	sp,sp,-16
    80003584:	00113423          	sd	ra,8(sp)
    80003588:	00813023          	sd	s0,0(sp)
    8000358c:	01010413          	addi	s0,sp,16
    80003590:	0000a797          	auipc	a5,0xa
    80003594:	bc078793          	addi	a5,a5,-1088 # 8000d150 <_ZTV6Thread+0x10>
    80003598:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, body, arg);
    8000359c:	00850513          	addi	a0,a0,8
    800035a0:	fffff097          	auipc	ra,0xfffff
    800035a4:	850080e7          	jalr	-1968(ra) # 80001df0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    800035a8:	00813083          	ld	ra,8(sp)
    800035ac:	00013403          	ld	s0,0(sp)
    800035b0:	01010113          	addi	sp,sp,16
    800035b4:	00008067          	ret

00000000800035b8 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800035b8:	ff010113          	addi	sp,sp,-16
    800035bc:	00113423          	sd	ra,8(sp)
    800035c0:	00813023          	sd	s0,0(sp)
    800035c4:	01010413          	addi	s0,sp,16
    800035c8:	0000a797          	auipc	a5,0xa
    800035cc:	b8878793          	addi	a5,a5,-1144 # 8000d150 <_ZTV6Thread+0x10>
    800035d0:	00f53023          	sd	a5,0(a0)
    thread_attach_body(&myHandle, &Thread::wrapper, this);
    800035d4:	00050613          	mv	a2,a0
    800035d8:	00000597          	auipc	a1,0x0
    800035dc:	d7c58593          	addi	a1,a1,-644 # 80003354 <_ZN6Thread7wrapperEPv>
    800035e0:	00850513          	addi	a0,a0,8
    800035e4:	fffff097          	auipc	ra,0xfffff
    800035e8:	80c080e7          	jalr	-2036(ra) # 80001df0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
}
    800035ec:	00813083          	ld	ra,8(sp)
    800035f0:	00013403          	ld	s0,0(sp)
    800035f4:	01010113          	addi	sp,sp,16
    800035f8:	00008067          	ret

00000000800035fc <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    800035fc:	ff010113          	addi	sp,sp,-16
    80003600:	00113423          	sd	ra,8(sp)
    80003604:	00813023          	sd	s0,0(sp)
    80003608:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    8000360c:	fffff097          	auipc	ra,0xfffff
    80003610:	948080e7          	jalr	-1720(ra) # 80001f54 <_Z10time_sleepm>
}
    80003614:	00813083          	ld	ra,8(sp)
    80003618:	00013403          	ld	s0,0(sp)
    8000361c:	01010113          	addi	sp,sp,16
    80003620:	00008067          	ret

0000000080003624 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80003624:	fe010113          	addi	sp,sp,-32
    80003628:	00113c23          	sd	ra,24(sp)
    8000362c:	00813823          	sd	s0,16(sp)
    80003630:	00913423          	sd	s1,8(sp)
    80003634:	01213023          	sd	s2,0(sp)
    80003638:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    8000363c:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80003640:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80003644:	0004b783          	ld	a5,0(s1)
    80003648:	0187b783          	ld	a5,24(a5)
    8000364c:	00048513          	mv	a0,s1
    80003650:	000780e7          	jalr	a5
        pt->sleep(time);
    80003654:	00090513          	mv	a0,s2
    80003658:	00000097          	auipc	ra,0x0
    8000365c:	fa4080e7          	jalr	-92(ra) # 800035fc <_ZN6Thread5sleepEm>
    while(true){
    80003660:	fe5ff06f          	j	80003644 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080003664 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80003664:	ff010113          	addi	sp,sp,-16
    80003668:	00113423          	sd	ra,8(sp)
    8000366c:	00813023          	sd	s0,0(sp)
    80003670:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80003674:	ffffe097          	auipc	ra,0xffffe
    80003678:	75c080e7          	jalr	1884(ra) # 80001dd0 <_Z15thread_dispatchv>
}
    8000367c:	00813083          	ld	ra,8(sp)
    80003680:	00013403          	ld	s0,0(sp)
    80003684:	01010113          	addi	sp,sp,16
    80003688:	00008067          	ret

000000008000368c <_ZN6Thread5startEv>:
int Thread::start() {
    8000368c:	ff010113          	addi	sp,sp,-16
    80003690:	00113423          	sd	ra,8(sp)
    80003694:	00813023          	sd	s0,0(sp)
    80003698:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    8000369c:	00853503          	ld	a0,8(a0)
    800036a0:	ffffe097          	auipc	ra,0xffffe
    800036a4:	7cc080e7          	jalr	1996(ra) # 80001e6c <_Z12thread_startP7_thread>
}
    800036a8:	00813083          	ld	ra,8(sp)
    800036ac:	00013403          	ld	s0,0(sp)
    800036b0:	01010113          	addi	sp,sp,16
    800036b4:	00008067          	ret

00000000800036b8 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800036b8:	fe010113          	addi	sp,sp,-32
    800036bc:	00113c23          	sd	ra,24(sp)
    800036c0:	00813823          	sd	s0,16(sp)
    800036c4:	00913423          	sd	s1,8(sp)
    800036c8:	01213023          	sd	s2,0(sp)
    800036cc:	02010413          	addi	s0,sp,32
    800036d0:	00050493          	mv	s1,a0
    800036d4:	00058913          	mv	s2,a1
    800036d8:	01000513          	li	a0,16
    800036dc:	00000097          	auipc	ra,0x0
    800036e0:	d1c080e7          	jalr	-740(ra) # 800033f8 <_Znwm>
    800036e4:	00050613          	mv	a2,a0
    Args(void *p, uint64 t) : pt(p), time(t){}
    800036e8:	00953023          	sd	s1,0(a0)
    800036ec:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    800036f0:	00000597          	auipc	a1,0x0
    800036f4:	f3458593          	addi	a1,a1,-204 # 80003624 <_ZN14PeriodicThread7wrapperEPv>
    800036f8:	00048513          	mv	a0,s1
    800036fc:	00000097          	auipc	ra,0x0
    80003700:	e84080e7          	jalr	-380(ra) # 80003580 <_ZN6ThreadC1EPFvPvES0_>
    80003704:	0000a797          	auipc	a5,0xa
    80003708:	9fc78793          	addi	a5,a5,-1540 # 8000d100 <_ZTV14PeriodicThread+0x10>
    8000370c:	00f4b023          	sd	a5,0(s1)
    80003710:	01813083          	ld	ra,24(sp)
    80003714:	01013403          	ld	s0,16(sp)
    80003718:	00813483          	ld	s1,8(sp)
    8000371c:	00013903          	ld	s2,0(sp)
    80003720:	02010113          	addi	sp,sp,32
    80003724:	00008067          	ret

0000000080003728 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80003728:	ff010113          	addi	sp,sp,-16
    8000372c:	00113423          	sd	ra,8(sp)
    80003730:	00813023          	sd	s0,0(sp)
    80003734:	01010413          	addi	s0,sp,16
    return ::getc();
    80003738:	fffff097          	auipc	ra,0xfffff
    8000373c:	848080e7          	jalr	-1976(ra) # 80001f80 <_Z4getcv>
}
    80003740:	00813083          	ld	ra,8(sp)
    80003744:	00013403          	ld	s0,0(sp)
    80003748:	01010113          	addi	sp,sp,16
    8000374c:	00008067          	ret

0000000080003750 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80003750:	ff010113          	addi	sp,sp,-16
    80003754:	00113423          	sd	ra,8(sp)
    80003758:	00813023          	sd	s0,0(sp)
    8000375c:	01010413          	addi	s0,sp,16
    ::putc(c);
    80003760:	fffff097          	auipc	ra,0xfffff
    80003764:	848080e7          	jalr	-1976(ra) # 80001fa8 <_Z4putcc>
}
    80003768:	00813083          	ld	ra,8(sp)
    8000376c:	00013403          	ld	s0,0(sp)
    80003770:	01010113          	addi	sp,sp,16
    80003774:	00008067          	ret

0000000080003778 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80003778:	ff010113          	addi	sp,sp,-16
    8000377c:	00813423          	sd	s0,8(sp)
    80003780:	01010413          	addi	s0,sp,16
    80003784:	00813403          	ld	s0,8(sp)
    80003788:	01010113          	addi	sp,sp,16
    8000378c:	00008067          	ret

0000000080003790 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80003790:	ff010113          	addi	sp,sp,-16
    80003794:	00813423          	sd	s0,8(sp)
    80003798:	01010413          	addi	s0,sp,16
    8000379c:	00813403          	ld	s0,8(sp)
    800037a0:	01010113          	addi	sp,sp,16
    800037a4:	00008067          	ret

00000000800037a8 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    800037a8:	ff010113          	addi	sp,sp,-16
    800037ac:	00113423          	sd	ra,8(sp)
    800037b0:	00813023          	sd	s0,0(sp)
    800037b4:	01010413          	addi	s0,sp,16
    800037b8:	0000a797          	auipc	a5,0xa
    800037bc:	94878793          	addi	a5,a5,-1720 # 8000d100 <_ZTV14PeriodicThread+0x10>
    800037c0:	00f53023          	sd	a5,0(a0)
    800037c4:	00000097          	auipc	ra,0x0
    800037c8:	bf4080e7          	jalr	-1036(ra) # 800033b8 <_ZN6ThreadD1Ev>
    800037cc:	00813083          	ld	ra,8(sp)
    800037d0:	00013403          	ld	s0,0(sp)
    800037d4:	01010113          	addi	sp,sp,16
    800037d8:	00008067          	ret

00000000800037dc <_ZN14PeriodicThreadD0Ev>:
    800037dc:	fe010113          	addi	sp,sp,-32
    800037e0:	00113c23          	sd	ra,24(sp)
    800037e4:	00813823          	sd	s0,16(sp)
    800037e8:	00913423          	sd	s1,8(sp)
    800037ec:	02010413          	addi	s0,sp,32
    800037f0:	00050493          	mv	s1,a0
    800037f4:	0000a797          	auipc	a5,0xa
    800037f8:	90c78793          	addi	a5,a5,-1780 # 8000d100 <_ZTV14PeriodicThread+0x10>
    800037fc:	00f53023          	sd	a5,0(a0)
    80003800:	00000097          	auipc	ra,0x0
    80003804:	bb8080e7          	jalr	-1096(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80003808:	00048513          	mv	a0,s1
    8000380c:	00000097          	auipc	ra,0x0
    80003810:	c3c080e7          	jalr	-964(ra) # 80003448 <_ZdlPv>
    80003814:	01813083          	ld	ra,24(sp)
    80003818:	01013403          	ld	s0,16(sp)
    8000381c:	00813483          	ld	s1,8(sp)
    80003820:	02010113          	addi	sp,sp,32
    80003824:	00008067          	ret

0000000080003828 <_ZN5RiscV10initializeEv>:

uint64 RiscV::globalTime = 0;
bool RiscV::userMainFinished = false;

//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    80003828:	ff010113          	addi	sp,sp,-16
    8000382c:	00113423          	sd	ra,8(sp)
    80003830:	00813023          	sd	s0,0(sp)
    80003834:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    80003838:	0000a797          	auipc	a5,0xa
    8000383c:	b287b783          	ld	a5,-1240(a5) # 8000d360 <_GLOBAL_OFFSET_TABLE_+0x68>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80003840:	10579073          	csrw	stvec,a5
    MemoryAllocator::initialize();
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	674080e7          	jalr	1652(ra) # 80002eb8 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    8000384c:	00001097          	auipc	ra,0x1
    80003850:	f5c080e7          	jalr	-164(ra) # 800047a8 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    80003854:	fffff097          	auipc	ra,0xfffff
    80003858:	544080e7          	jalr	1348(ra) # 80002d98 <_ZN3TCB10initializeEv>
    ConsoleUtil::initialize();
    8000385c:	00001097          	auipc	ra,0x1
    80003860:	160080e7          	jalr	352(ra) # 800049bc <_ZN11ConsoleUtil10initializeEv>
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003864:	00200793          	li	a5,2
    80003868:	1047a073          	csrs	sie,a5
    8000386c:	20000713          	li	a4,512
    80003870:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003874:	1007a073          	csrs	sstatus,a5
    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003878:	00813083          	ld	ra,8(sp)
    8000387c:	00013403          	ld	s0,0(sp)
    80003880:	01010113          	addi	sp,sp,16
    80003884:	00008067          	ret

0000000080003888 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003888:	ff010113          	addi	sp,sp,-16
    8000388c:	00813423          	sd	s0,8(sp)
    80003890:	01010413          	addi	s0,sp,16
    asm("csrw sepc, ra");
    80003894:	14109073          	csrw	sepc,ra
    asm("sret");
    80003898:	10200073          	sret
}
    8000389c:	00813403          	ld	s0,8(sp)
    800038a0:	01010113          	addi	sp,sp,16
    800038a4:	00008067          	ret

00000000800038a8 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    800038a8:	ff010113          	addi	sp,sp,-16
    800038ac:	00113423          	sd	ra,8(sp)
    800038b0:	00813023          	sd	s0,0(sp)
    800038b4:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    800038b8:	0000a797          	auipc	a5,0xa
    800038bc:	ac87b783          	ld	a5,-1336(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    800038c0:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    800038c4:	00100713          	li	a4,1
    800038c8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800038cc:	fffff097          	auipc	ra,0xfffff
    800038d0:	424080e7          	jalr	1060(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
}
    800038d4:	00813083          	ld	ra,8(sp)
    800038d8:	00013403          	ld	s0,0(sp)
    800038dc:	01010113          	addi	sp,sp,16
    800038e0:	00008067          	ret

00000000800038e4 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    800038e4:	ff010113          	addi	sp,sp,-16
    800038e8:	00113423          	sd	ra,8(sp)
    800038ec:	00813023          	sd	s0,0(sp)
    800038f0:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    800038f4:	0000a797          	auipc	a5,0xa
    800038f8:	cbc7c783          	lbu	a5,-836(a5) # 8000d5b0 <_ZN5RiscV16userMainFinishedE>
    800038fc:	00079c63          	bnez	a5,80003914 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003900:	0000a717          	auipc	a4,0xa
    80003904:	a7873703          	ld	a4,-1416(a4) # 8000d378 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003908:	00073783          	ld	a5,0(a4)
    8000390c:	00178793          	addi	a5,a5,1
    80003910:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003914:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003918:	0ff57513          	andi	a0,a0,255
    8000391c:	00001097          	auipc	ra,0x1
    80003920:	230080e7          	jalr	560(ra) # 80004b4c <_ZN11ConsoleUtil9putOutputEc>
}
    80003924:	00813083          	ld	ra,8(sp)
    80003928:	00013403          	ld	s0,0(sp)
    8000392c:	01010113          	addi	sp,sp,16
    80003930:	00008067          	ret

0000000080003934 <_ZN5RiscV11putcWrapperEPv>:

//wrapper function for putcThread
//spins in a while loop and checks whether console is ready to take output
//if ready read data from output buffer
void RiscV::putcWrapper(void* arg)
{
    80003934:	fe010113          	addi	sp,sp,-32
    80003938:	00113c23          	sd	ra,24(sp)
    8000393c:	00813823          	sd	s0,16(sp)
    80003940:	02010413          	addi	s0,sp,32
    80003944:	00c0006f          	j	80003950 <_ZN5RiscV11putcWrapperEPv+0x1c>
            //decrement number of pending putc requests
            if(ConsoleUtil::pendingPutc>0)
                ConsoleUtil::pendingPutc--;
        }
        else
            thread_dispatch();
    80003948:	ffffe097          	auipc	ra,0xffffe
    8000394c:	488080e7          	jalr	1160(ra) # 80001dd0 <_Z15thread_dispatchv>
        uint64 status = CONSOLE_STATUS;
    80003950:	0000a797          	auipc	a5,0xa
    80003954:	9b87b783          	ld	a5,-1608(a5) # 8000d308 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003958:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    8000395c:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003960:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003964:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003968:	0207f793          	andi	a5,a5,32
    8000396c:	fc078ee3          	beqz	a5,80003948 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003970:	00001097          	auipc	ra,0x1
    80003974:	454080e7          	jalr	1108(ra) # 80004dc4 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003978:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    8000397c:	0000a797          	auipc	a5,0xa
    80003980:	9847b783          	ld	a5,-1660(a5) # 8000d300 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003984:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003988:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    8000398c:	fef44783          	lbu	a5,-17(s0)
    80003990:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003994:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003998:	0000a797          	auipc	a5,0xa
    8000399c:	9e07b783          	ld	a5,-1568(a5) # 8000d378 <_GLOBAL_OFFSET_TABLE_+0x80>
    800039a0:	0007b783          	ld	a5,0(a5)
    800039a4:	fa0786e3          	beqz	a5,80003950 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    800039a8:	fff78793          	addi	a5,a5,-1
    800039ac:	0000a717          	auipc	a4,0xa
    800039b0:	9cc73703          	ld	a4,-1588(a4) # 8000d378 <_GLOBAL_OFFSET_TABLE_+0x80>
    800039b4:	00f73023          	sd	a5,0(a4)
    800039b8:	f99ff06f          	j	80003950 <_ZN5RiscV11putcWrapperEPv+0x1c>

00000000800039bc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    800039bc:	ff010113          	addi	sp,sp,-16
    800039c0:	00813423          	sd	s0,8(sp)
    800039c4:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    800039c8:	0000a797          	auipc	a5,0xa
    800039cc:	9b87b783          	ld	a5,-1608(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    800039d0:	0007b783          	ld	a5,0(a5)
    800039d4:	0147a703          	lw	a4,20(a5)
    800039d8:	00100793          	li	a5,1
    800039dc:	00f70c63          	beq	a4,a5,800039f4 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    800039e0:	10000793          	li	a5,256
    800039e4:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
}
    800039e8:	00813403          	ld	s0,8(sp)
    800039ec:	01010113          	addi	sp,sp,16
    800039f0:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800039f4:	10000793          	li	a5,256
    800039f8:	1007a073          	csrs	sstatus,a5
}
    800039fc:	fedff06f          	j	800039e8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

0000000080003a00 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    80003a00:	ff010113          	addi	sp,sp,-16
    80003a04:	00113423          	sd	ra,8(sp)
    80003a08:	00813023          	sd	s0,0(sp)
    80003a0c:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    80003a10:	00100793          	li	a5,1
    80003a14:	0000a717          	auipc	a4,0xa
    80003a18:	b8f70e23          	sb	a5,-1124(a4) # 8000d5b0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003a1c:	0000a797          	auipc	a5,0xa
    80003a20:	95c7b783          	ld	a5,-1700(a5) # 8000d378 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003a24:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    80003a28:	0000a797          	auipc	a5,0xa
    80003a2c:	9087b783          	ld	a5,-1784(a5) # 8000d330 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003a30:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003a34:	00200793          	li	a5,2
    80003a38:	1047b073          	csrc	sie,a5
    80003a3c:	20000793          	li	a5,512
    80003a40:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003a44:	0000a797          	auipc	a5,0xa
    80003a48:	90c7b783          	ld	a5,-1780(a5) # 8000d350 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003a4c:	0007b783          	ld	a5,0(a5)
    80003a50:	00078c63          	beqz	a5,80003a68 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003a54:	0487b703          	ld	a4,72(a5)
    80003a58:	0000a797          	auipc	a5,0xa
    80003a5c:	8f87b783          	ld	a5,-1800(a5) # 8000d350 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003a60:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003a64:	fe1ff06f          	j	80003a44 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003a68:	0000a797          	auipc	a5,0xa
    80003a6c:	8f07b783          	ld	a5,-1808(a5) # 8000d358 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003a70:	0007b503          	ld	a0,0(a5)
    80003a74:	00001097          	auipc	ra,0x1
    80003a78:	d4c080e7          	jalr	-692(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003a7c:	0000a797          	auipc	a5,0xa
    80003a80:	8ec7b783          	ld	a5,-1812(a5) # 8000d368 <_GLOBAL_OFFSET_TABLE_+0x70>
    80003a84:	0007b703          	ld	a4,0(a5)
    80003a88:	0000a797          	auipc	a5,0xa
    80003a8c:	8e87b783          	ld	a5,-1816(a5) # 8000d370 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003a90:	0007b783          	ld	a5,0(a5)
    80003a94:	00f70863          	beq	a4,a5,80003aa4 <_ZN5RiscV8finalizeEv+0xa4>
        thread_dispatch();
    80003a98:	ffffe097          	auipc	ra,0xffffe
    80003a9c:	338080e7          	jalr	824(ra) # 80001dd0 <_Z15thread_dispatchv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003aa0:	fddff06f          	j	80003a7c <_ZN5RiscV8finalizeEv+0x7c>
}
    80003aa4:	00813083          	ld	ra,8(sp)
    80003aa8:	00013403          	ld	s0,0(sp)
    80003aac:	01010113          	addi	sp,sp,16
    80003ab0:	00008067          	ret

0000000080003ab4 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003ab4:	ff010113          	addi	sp,sp,-16
    80003ab8:	00813423          	sd	s0,8(sp)
    80003abc:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003ac0:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003ac4:	0000a717          	auipc	a4,0xa
    80003ac8:	8bc73703          	ld	a4,-1860(a4) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003acc:	00073703          	ld	a4,0(a4)
    80003ad0:	06873703          	ld	a4,104(a4)
    80003ad4:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003ad8:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003adc:	00078593          	mv	a1,a5
}
    80003ae0:	00813403          	ld	s0,8(sp)
    80003ae4:	01010113          	addi	sp,sp,16
    80003ae8:	00008067          	ret

0000000080003aec <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    80003aec:	ff010113          	addi	sp,sp,-16
    80003af0:	00113423          	sd	ra,8(sp)
    80003af4:	00813023          	sd	s0,0(sp)
    80003af8:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    80003afc:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    80003b00:	fffff097          	auipc	ra,0xfffff
    80003b04:	438080e7          	jalr	1080(ra) # 80002f38 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    80003b08:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003b0c:	00000097          	auipc	ra,0x0
    80003b10:	fa8080e7          	jalr	-88(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b14:	00813083          	ld	ra,8(sp)
    80003b18:	00013403          	ld	s0,0(sp)
    80003b1c:	01010113          	addi	sp,sp,16
    80003b20:	00008067          	ret

0000000080003b24 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003b24:	ff010113          	addi	sp,sp,-16
    80003b28:	00113423          	sd	ra,8(sp)
    80003b2c:	00813023          	sd	s0,0(sp)
    80003b30:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003b34:	0000a797          	auipc	a5,0xa
    80003b38:	8547b783          	ld	a5,-1964(a5) # 8000d388 <_GLOBAL_OFFSET_TABLE_+0x90>
    80003b3c:	0007c783          	lbu	a5,0(a5)
    80003b40:	02079263          	bnez	a5,80003b64 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003b44:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003b48:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003b4c:	00000097          	auipc	ra,0x0
    80003b50:	f68080e7          	jalr	-152(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b54:	00813083          	ld	ra,8(sp)
    80003b58:	00013403          	ld	s0,0(sp)
    80003b5c:	01010113          	addi	sp,sp,16
    80003b60:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003b64:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003b68:	fffff097          	auipc	ra,0xfffff
    80003b6c:	5f8080e7          	jalr	1528(ra) # 80003160 <_ZN15MemoryAllocator5kfreeEPv>
    80003b70:	fd9ff06f          	j	80003b48 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003b74 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003b74:	fc010113          	addi	sp,sp,-64
    80003b78:	02113c23          	sd	ra,56(sp)
    80003b7c:	02813823          	sd	s0,48(sp)
    80003b80:	02913423          	sd	s1,40(sp)
    80003b84:	03213023          	sd	s2,32(sp)
    80003b88:	01313c23          	sd	s3,24(sp)
    80003b8c:	01413823          	sd	s4,16(sp)
    80003b90:	01513423          	sd	s5,8(sp)
    80003b94:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003b98:	00088a13          	mv	s4,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003b9c:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003ba0:	00060913          	mv	s2,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003ba4:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003ba8:	07000513          	li	a0,112
    80003bac:	fffff097          	auipc	ra,0xfffff
    80003bb0:	1c4080e7          	jalr	452(ra) # 80002d70 <_ZN3TCBnwEm>
    80003bb4:	00050493          	mv	s1,a0
    80003bb8:	00200713          	li	a4,2
    80003bbc:	000a0693          	mv	a3,s4
    80003bc0:	00098613          	mv	a2,s3
    80003bc4:	00090593          	mv	a1,s2
    80003bc8:	fffff097          	auipc	ra,0xfffff
    80003bcc:	05c080e7          	jalr	92(ra) # 80002c24 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003bd0:	04048863          	beqz	s1,80003c20 <_ZN5RiscV26executeThreadCreateSyscallEv+0xac>
        if(tcb->body)
    80003bd4:	0184b783          	ld	a5,24(s1)
    80003bd8:	00078863          	beqz	a5,80003be8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x74>
            Scheduler::put(tcb);
    80003bdc:	00048513          	mv	a0,s1
    80003be0:	00001097          	auipc	ra,0x1
    80003be4:	be0080e7          	jalr	-1056(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    80003be8:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003bec:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003bf0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003bf4:	00000097          	auipc	ra,0x0
    80003bf8:	ec0080e7          	jalr	-320(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003bfc:	03813083          	ld	ra,56(sp)
    80003c00:	03013403          	ld	s0,48(sp)
    80003c04:	02813483          	ld	s1,40(sp)
    80003c08:	02013903          	ld	s2,32(sp)
    80003c0c:	01813983          	ld	s3,24(sp)
    80003c10:	01013a03          	ld	s4,16(sp)
    80003c14:	00813a83          	ld	s5,8(sp)
    80003c18:	04010113          	addi	sp,sp,64
    80003c1c:	00008067          	ret
        status = -1;
    80003c20:	fff00793          	li	a5,-1
    80003c24:	fcdff06f          	j	80003bf0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x7c>
    80003c28:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003c2c:	00048513          	mv	a0,s1
    80003c30:	fffff097          	auipc	ra,0xfffff
    80003c34:	234080e7          	jalr	564(ra) # 80002e64 <_ZN3TCBdlEPv>
    80003c38:	00090513          	mv	a0,s2
    80003c3c:	0000f097          	auipc	ra,0xf
    80003c40:	acc080e7          	jalr	-1332(ra) # 80012708 <_Unwind_Resume>

0000000080003c44 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    80003c44:	fc010113          	addi	sp,sp,-64
    80003c48:	02113c23          	sd	ra,56(sp)
    80003c4c:	02813823          	sd	s0,48(sp)
    80003c50:	02913423          	sd	s1,40(sp)
    80003c54:	03213023          	sd	s2,32(sp)
    80003c58:	01313c23          	sd	s3,24(sp)
    80003c5c:	01413823          	sd	s4,16(sp)
    80003c60:	01513423          	sd	s5,8(sp)
    80003c64:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003c68:	00088913          	mv	s2,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003c6c:	00058a93          	mv	s5,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003c70:	00060a13          	mv	s4,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003c74:	00068993          	mv	s3,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003c78:	07000513          	li	a0,112
    80003c7c:	fffff097          	auipc	ra,0xfffff
    80003c80:	0f4080e7          	jalr	244(ra) # 80002d70 <_ZN3TCBnwEm>
    80003c84:	00050493          	mv	s1,a0
    80003c88:	00200713          	li	a4,2
    80003c8c:	00090693          	mv	a3,s2
    80003c90:	00098613          	mv	a2,s3
    80003c94:	000a0593          	mv	a1,s4
    80003c98:	fffff097          	auipc	ra,0xfffff
    80003c9c:	f8c080e7          	jalr	-116(ra) # 80002c24 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003ca0:	04048263          	beqz	s1,80003ce4 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa0>
        tcb->body = (TCB::Body)iroutine;
    80003ca4:	0144bc23          	sd	s4,24(s1)
        tcb->args = (void*)iargs;
    80003ca8:	0334b023          	sd	s3,32(s1)
        *((TCB**)ihandle) = tcb;
    80003cac:	009ab023          	sd	s1,0(s5)
    uint64 status = 0;
    80003cb0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003cb4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003cb8:	00000097          	auipc	ra,0x0
    80003cbc:	dfc080e7          	jalr	-516(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003cc0:	03813083          	ld	ra,56(sp)
    80003cc4:	03013403          	ld	s0,48(sp)
    80003cc8:	02813483          	ld	s1,40(sp)
    80003ccc:	02013903          	ld	s2,32(sp)
    80003cd0:	01813983          	ld	s3,24(sp)
    80003cd4:	01013a03          	ld	s4,16(sp)
    80003cd8:	00813a83          	ld	s5,8(sp)
    80003cdc:	04010113          	addi	sp,sp,64
    80003ce0:	00008067          	ret
        status = -1;
    80003ce4:	fff00793          	li	a5,-1
    80003ce8:	fcdff06f          	j	80003cb4 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x70>
    80003cec:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003cf0:	00048513          	mv	a0,s1
    80003cf4:	fffff097          	auipc	ra,0xfffff
    80003cf8:	170080e7          	jalr	368(ra) # 80002e64 <_ZN3TCBdlEPv>
    80003cfc:	00090513          	mv	a0,s2
    80003d00:	0000f097          	auipc	ra,0xf
    80003d04:	a08080e7          	jalr	-1528(ra) # 80012708 <_Unwind_Resume>

0000000080003d08 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    80003d08:	ff010113          	addi	sp,sp,-16
    80003d0c:	00113423          	sd	ra,8(sp)
    80003d10:	00813023          	sd	s0,0(sp)
    80003d14:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003d18:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003d1c:	02051263          	bnez	a0,80003d40 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    80003d20:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d24:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003d28:	00000097          	auipc	ra,0x0
    80003d2c:	d8c080e7          	jalr	-628(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003d30:	00813083          	ld	ra,8(sp)
    80003d34:	00013403          	ld	s0,0(sp)
    80003d38:	01010113          	addi	sp,sp,16
    80003d3c:	00008067          	ret
        tcb->status = TCB::Status::READY;
    80003d40:	00100793          	li	a5,1
    80003d44:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003d48:	00001097          	auipc	ra,0x1
    80003d4c:	a78080e7          	jalr	-1416(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003d50:	fffff097          	auipc	ra,0xfffff
    80003d54:	fa0080e7          	jalr	-96(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003d58:	00000793          	li	a5,0
    80003d5c:	fc9ff06f          	j	80003d24 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003d60 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003d60:	ff010113          	addi	sp,sp,-16
    80003d64:	00113423          	sd	ra,8(sp)
    80003d68:	00813023          	sd	s0,0(sp)
    80003d6c:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003d70:	00009797          	auipc	a5,0x9
    80003d74:	6107b783          	ld	a5,1552(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003d78:	0007b783          	ld	a5,0(a5)
    80003d7c:	02078a63          	beqz	a5,80003db0 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003d80:	00200713          	li	a4,2
    80003d84:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003d88:	fffff097          	auipc	ra,0xfffff
    80003d8c:	f68080e7          	jalr	-152(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003d90:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d94:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003d98:	00000097          	auipc	ra,0x0
    80003d9c:	d1c080e7          	jalr	-740(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003da0:	00813083          	ld	ra,8(sp)
    80003da4:	00013403          	ld	s0,0(sp)
    80003da8:	01010113          	addi	sp,sp,16
    80003dac:	00008067          	ret
        status = -1;
    80003db0:	fff00793          	li	a5,-1
    80003db4:	fe1ff06f          	j	80003d94 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003db8 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003db8:	fd010113          	addi	sp,sp,-48
    80003dbc:	02113423          	sd	ra,40(sp)
    80003dc0:	02813023          	sd	s0,32(sp)
    80003dc4:	00913c23          	sd	s1,24(sp)
    80003dc8:	01213823          	sd	s2,16(sp)
    80003dcc:	01313423          	sd	s3,8(sp)
    80003dd0:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003dd4:	00058993          	mv	s3,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003dd8:	00060913          	mv	s2,a2
    SCB *scb = new SCB(iinit);
    80003ddc:	01800513          	li	a0,24
    80003de0:	fffff097          	auipc	ra,0xfffff
    80003de4:	d54080e7          	jalr	-684(ra) # 80002b34 <_ZN3SCBnwEm>
    80003de8:	00050493          	mv	s1,a0
    80003dec:	00090593          	mv	a1,s2
    80003df0:	fffff097          	auipc	ra,0xfffff
    80003df4:	b88080e7          	jalr	-1144(ra) # 80002978 <_ZN3SCBC1Em>
    if(scb == nullptr){
    80003df8:	02048a63          	beqz	s1,80003e2c <_ZN5RiscV21executeSemOpenSyscallEv+0x74>
        *((SCB**)ihandle) = scb;
    80003dfc:	0099b023          	sd	s1,0(s3)
    uint64 status = 0;
    80003e00:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e04:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003e08:	00000097          	auipc	ra,0x0
    80003e0c:	cac080e7          	jalr	-852(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e10:	02813083          	ld	ra,40(sp)
    80003e14:	02013403          	ld	s0,32(sp)
    80003e18:	01813483          	ld	s1,24(sp)
    80003e1c:	01013903          	ld	s2,16(sp)
    80003e20:	00813983          	ld	s3,8(sp)
    80003e24:	03010113          	addi	sp,sp,48
    80003e28:	00008067          	ret
        status = -1;
    80003e2c:	fff00793          	li	a5,-1
    80003e30:	fd5ff06f          	j	80003e04 <_ZN5RiscV21executeSemOpenSyscallEv+0x4c>
    80003e34:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003e38:	00048513          	mv	a0,s1
    80003e3c:	fffff097          	auipc	ra,0xfffff
    80003e40:	d20080e7          	jalr	-736(ra) # 80002b5c <_ZN3SCBdlEPv>
    80003e44:	00090513          	mv	a0,s2
    80003e48:	0000f097          	auipc	ra,0xf
    80003e4c:	8c0080e7          	jalr	-1856(ra) # 80012708 <_Unwind_Resume>

0000000080003e50 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003e50:	fe010113          	addi	sp,sp,-32
    80003e54:	00113c23          	sd	ra,24(sp)
    80003e58:	00813823          	sd	s0,16(sp)
    80003e5c:	00913423          	sd	s1,8(sp)
    80003e60:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003e64:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003e68:	02049463          	bnez	s1,80003e90 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003e6c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003e70:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003e74:	00000097          	auipc	ra,0x0
    80003e78:	c40080e7          	jalr	-960(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003e7c:	01813083          	ld	ra,24(sp)
    80003e80:	01013403          	ld	s0,16(sp)
    80003e84:	00813483          	ld	s1,8(sp)
    80003e88:	02010113          	addi	sp,sp,32
    80003e8c:	00008067          	ret
        delete (SCB*)ihandle;
    80003e90:	00048513          	mv	a0,s1
    80003e94:	fffff097          	auipc	ra,0xfffff
    80003e98:	b08080e7          	jalr	-1272(ra) # 8000299c <_ZN3SCBD1Ev>
    80003e9c:	00048513          	mv	a0,s1
    80003ea0:	fffff097          	auipc	ra,0xfffff
    80003ea4:	cbc080e7          	jalr	-836(ra) # 80002b5c <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003ea8:	00000793          	li	a5,0
    80003eac:	fc5ff06f          	j	80003e70 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

0000000080003eb0 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    80003eb0:	ff010113          	addi	sp,sp,-16
    80003eb4:	00113423          	sd	ra,8(sp)
    80003eb8:	00813023          	sd	s0,0(sp)
    80003ebc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003ec0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003ec4:	02051c63          	bnez	a0,80003efc <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003ec8:	00009797          	auipc	a5,0x9
    80003ecc:	4b87b783          	ld	a5,1208(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003ed0:	0007b783          	ld	a5,0(a5)
    80003ed4:	0607b783          	ld	a5,96(a5)
    80003ed8:	02078863          	beqz	a5,80003f08 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003edc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ee0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003ee4:	00000097          	auipc	ra,0x0
    80003ee8:	bd0080e7          	jalr	-1072(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003eec:	00813083          	ld	ra,8(sp)
    80003ef0:	00013403          	ld	s0,0(sp)
    80003ef4:	01010113          	addi	sp,sp,16
    80003ef8:	00008067          	ret
        ((SCB*)ihandle)->wait();
    80003efc:	fffff097          	auipc	ra,0xfffff
    80003f00:	bac080e7          	jalr	-1108(ra) # 80002aa8 <_ZN3SCB4waitEv>
    80003f04:	fc5ff06f          	j	80003ec8 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    80003f08:	00000793          	li	a5,0
    80003f0c:	fd5ff06f          	j	80003ee0 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003f10 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003f10:	ff010113          	addi	sp,sp,-16
    80003f14:	00113423          	sd	ra,8(sp)
    80003f18:	00813023          	sd	s0,0(sp)
    80003f1c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003f20:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003f24:	02051263          	bnez	a0,80003f48 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003f28:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003f2c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003f30:	00000097          	auipc	ra,0x0
    80003f34:	b84080e7          	jalr	-1148(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003f38:	00813083          	ld	ra,8(sp)
    80003f3c:	00013403          	ld	s0,0(sp)
    80003f40:	01010113          	addi	sp,sp,16
    80003f44:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003f48:	fffff097          	auipc	ra,0xfffff
    80003f4c:	bb0080e7          	jalr	-1104(ra) # 80002af8 <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003f50:	00000793          	li	a5,0
    80003f54:	fd9ff06f          	j	80003f2c <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003f58 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003f58:	fe010113          	addi	sp,sp,-32
    80003f5c:	00113c23          	sd	ra,24(sp)
    80003f60:	00813823          	sd	s0,16(sp)
    80003f64:	00913423          	sd	s1,8(sp)
    80003f68:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003f6c:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003f70:	00009797          	auipc	a5,0x9
    80003f74:	4107b783          	ld	a5,1040(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003f78:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003f7c:	00009797          	auipc	a5,0x9
    80003f80:	63c7b783          	ld	a5,1596(a5) # 8000d5b8 <_ZN5RiscV10globalTimeE>
    80003f84:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003f88:	00e787b3          	add	a5,a5,a4
    80003f8c:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003f90:	00048513          	mv	a0,s1
    80003f94:	00001097          	auipc	ra,0x1
    80003f98:	8a8080e7          	jalr	-1880(ra) # 8000483c <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003f9c:	00300793          	li	a5,3
    80003fa0:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003fa4:	fffff097          	auipc	ra,0xfffff
    80003fa8:	d4c080e7          	jalr	-692(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003fac:	00000793          	li	a5,0
    80003fb0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003fb4:	00000097          	auipc	ra,0x0
    80003fb8:	b00080e7          	jalr	-1280(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003fbc:	01813083          	ld	ra,24(sp)
    80003fc0:	01013403          	ld	s0,16(sp)
    80003fc4:	00813483          	ld	s1,8(sp)
    80003fc8:	02010113          	addi	sp,sp,32
    80003fcc:	00008067          	ret

0000000080003fd0 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003fd0:	fe010113          	addi	sp,sp,-32
    80003fd4:	00113c23          	sd	ra,24(sp)
    80003fd8:	00813823          	sd	s0,16(sp)
    80003fdc:	00913423          	sd	s1,8(sp)
    80003fe0:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003fe4:	00009797          	auipc	a5,0x9
    80003fe8:	5cc7c783          	lbu	a5,1484(a5) # 8000d5b0 <_ZN5RiscV16userMainFinishedE>
    80003fec:	00079c63          	bnez	a5,80004004 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003ff0:	00009717          	auipc	a4,0x9
    80003ff4:	34073703          	ld	a4,832(a4) # 8000d330 <_GLOBAL_OFFSET_TABLE_+0x38>
    80003ff8:	00073783          	ld	a5,0(a4)
    80003ffc:	00178793          	addi	a5,a5,1
    80004000:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80004004:	00001097          	auipc	ra,0x1
    80004008:	ad0080e7          	jalr	-1328(ra) # 80004ad4 <_ZN11ConsoleUtil8getInputEv>
    8000400c:	00050493          	mv	s1,a0
    if(c==13) {
    80004010:	00d00793          	li	a5,13
    80004014:	02f50663          	beq	a0,a5,80004040 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80004018:	01b00793          	li	a5,27
    8000401c:	04f51063          	bne	a0,a5,8000405c <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80004020:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80004024:	00000097          	auipc	ra,0x0
    80004028:	a90080e7          	jalr	-1392(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000402c:	01813083          	ld	ra,24(sp)
    80004030:	01013403          	ld	s0,16(sp)
    80004034:	00813483          	ld	s1,8(sp)
    80004038:	02010113          	addi	sp,sp,32
    8000403c:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80004040:	00d00513          	li	a0,13
    80004044:	00001097          	auipc	ra,0x1
    80004048:	b08080e7          	jalr	-1272(ra) # 80004b4c <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    8000404c:	00a00513          	li	a0,10
    80004050:	00001097          	auipc	ra,0x1
    80004054:	afc080e7          	jalr	-1284(ra) # 80004b4c <_ZN11ConsoleUtil9putOutputEc>
    80004058:	fc9ff06f          	j	80004020 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    8000405c:	00001097          	auipc	ra,0x1
    80004060:	af0080e7          	jalr	-1296(ra) # 80004b4c <_ZN11ConsoleUtil9putOutputEc>
    80004064:	fbdff06f          	j	80004020 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080004068 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80004068:	ff010113          	addi	sp,sp,-16
    8000406c:	00113423          	sd	ra,8(sp)
    80004070:	00813023          	sd	s0,0(sp)
    80004074:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80004078:	00001097          	auipc	ra,0x1
    8000407c:	b54080e7          	jalr	-1196(ra) # 80004bcc <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80004080:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80004084:	00000097          	auipc	ra,0x0
    80004088:	a30080e7          	jalr	-1488(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000408c:	00813083          	ld	ra,8(sp)
    80004090:	00013403          	ld	s0,0(sp)
    80004094:	01010113          	addi	sp,sp,16
    80004098:	00008067          	ret

000000008000409c <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    8000409c:	fe010113          	addi	sp,sp,-32
    800040a0:	00113c23          	sd	ra,24(sp)
    800040a4:	00813823          	sd	s0,16(sp)
    800040a8:	00913423          	sd	s1,8(sp)
    800040ac:	01213023          	sd	s2,0(sp)
    800040b0:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800040b4:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    800040b8:	02049663          	bnez	s1,800040e4 <_ZN5RiscV24executeThreadFreeSyscallEv+0x48>
        status = -1;
    800040bc:	fff00913          	li	s2,-1
        status = MemoryAllocator::kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800040c0:	00090513          	mv	a0,s2

    RiscV::saveA0toSscratch();
    800040c4:	00000097          	auipc	ra,0x0
    800040c8:	9f0080e7          	jalr	-1552(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    800040cc:	01813083          	ld	ra,24(sp)
    800040d0:	01013403          	ld	s0,16(sp)
    800040d4:	00813483          	ld	s1,8(sp)
    800040d8:	00013903          	ld	s2,0(sp)
    800040dc:	02010113          	addi	sp,sp,32
    800040e0:	00008067          	ret
        status = MemoryAllocator::kfree(thr->stack);
    800040e4:	0284b503          	ld	a0,40(s1)
    800040e8:	fffff097          	auipc	ra,0xfffff
    800040ec:	078080e7          	jalr	120(ra) # 80003160 <_ZN15MemoryAllocator5kfreeEPv>
    800040f0:	00050913          	mv	s2,a0
        delete thr;
    800040f4:	00048513          	mv	a0,s1
    800040f8:	fffff097          	auipc	ra,0xfffff
    800040fc:	bd0080e7          	jalr	-1072(ra) # 80002cc8 <_ZN3TCBD1Ev>
    80004100:	00048513          	mv	a0,s1
    80004104:	fffff097          	auipc	ra,0xfffff
    80004108:	d60080e7          	jalr	-672(ra) # 80002e64 <_ZN3TCBdlEPv>
    8000410c:	fb5ff06f          	j	800040c0 <_ZN5RiscV24executeThreadFreeSyscallEv+0x24>

0000000080004110 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80004110:	fe010113          	addi	sp,sp,-32
    80004114:	00113c23          	sd	ra,24(sp)
    80004118:	00813823          	sd	s0,16(sp)
    8000411c:	00913423          	sd	s1,8(sp)
    80004120:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80004124:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80004128:	02049463          	bnez	s1,80004150 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000412c:	fff00793          	li	a5,-1
    80004130:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80004134:	00000097          	auipc	ra,0x0
    80004138:	980080e7          	jalr	-1664(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000413c:	01813083          	ld	ra,24(sp)
    80004140:	01013403          	ld	s0,16(sp)
    80004144:	00813483          	ld	s1,8(sp)
    80004148:	02010113          	addi	sp,sp,32
    8000414c:	00008067          	ret
        delete scb;
    80004150:	00048513          	mv	a0,s1
    80004154:	fffff097          	auipc	ra,0xfffff
    80004158:	848080e7          	jalr	-1976(ra) # 8000299c <_ZN3SCBD1Ev>
    8000415c:	00048513          	mv	a0,s1
    80004160:	fffff097          	auipc	ra,0xfffff
    80004164:	9fc080e7          	jalr	-1540(ra) # 80002b5c <_ZN3SCBdlEPv>
    80004168:	fc5ff06f          	j	8000412c <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

000000008000416c <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    8000416c:	fe010113          	addi	sp,sp,-32
    80004170:	00113c23          	sd	ra,24(sp)
    80004174:	00813823          	sd	s0,16(sp)
    80004178:	00913423          	sd	s1,8(sp)
    8000417c:	01213023          	sd	s2,0(sp)
    80004180:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)MemoryAllocator::kmalloc((DEFAULT_STACK_SIZE+MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE);
    80004184:	04000513          	li	a0,64
    80004188:	fffff097          	auipc	ra,0xfffff
    8000418c:	db0080e7          	jalr	-592(ra) # 80002f38 <_ZN15MemoryAllocator7kmallocEm>
    80004190:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80004194:	00009797          	auipc	a5,0x9
    80004198:	1ec7b783          	ld	a5,492(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000419c:	0007b783          	ld	a5,0(a5)
    800041a0:	00001637          	lui	a2,0x1
    800041a4:	00050593          	mv	a1,a0
    800041a8:	0287b503          	ld	a0,40(a5)
    800041ac:	fffff097          	auipc	ra,0xfffff
    800041b0:	168080e7          	jalr	360(ra) # 80003314 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800041b4:	07000513          	li	a0,112
    800041b8:	fffff097          	auipc	ra,0xfffff
    800041bc:	bb8080e7          	jalr	-1096(ra) # 80002d70 <_ZN3TCBnwEm>
    800041c0:	00050493          	mv	s1,a0
    800041c4:	00200713          	li	a4,2
    800041c8:	00090693          	mv	a3,s2
    800041cc:	00000613          	li	a2,0
    800041d0:	00000593          	li	a1,0
    800041d4:	fffff097          	auipc	ra,0xfffff
    800041d8:	a50080e7          	jalr	-1456(ra) # 80002c24 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    800041dc:	0a048e63          	beqz	s1,80004298 <_ZN5RiscV18executeForkSyscallEv+0x12c>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    800041e0:	00009797          	auipc	a5,0x9
    800041e4:	1687b783          	ld	a5,360(a5) # 8000d348 <_GLOBAL_OFFSET_TABLE_+0x50>
    800041e8:	0007b783          	ld	a5,0(a5)
    800041ec:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    800041f0:	00009797          	auipc	a5,0x9
    800041f4:	1487b783          	ld	a5,328(a5) # 8000d338 <_GLOBAL_OFFSET_TABLE_+0x40>
    800041f8:	0007b783          	ld	a5,0(a5)
    800041fc:	00f907b3          	add	a5,s2,a5
    80004200:	00009717          	auipc	a4,0x9
    80004204:	18073703          	ld	a4,384(a4) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004208:	00073683          	ld	a3,0(a4)
    8000420c:	0286b683          	ld	a3,40(a3)
    80004210:	40d787b3          	sub	a5,a5,a3
    80004214:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80004218:	00073783          	ld	a5,0(a4)
    8000421c:	0687b503          	ld	a0,104(a5)
    80004220:	0287b783          	ld	a5,40(a5)
    80004224:	40f50533          	sub	a0,a0,a5
    80004228:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    8000422c:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80004230:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80004234:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80004238:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    8000423c:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80004240:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80004244:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80004248:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000424c:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80004250:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80004254:	00073783          	ld	a5,0(a4)
    80004258:	0387b703          	ld	a4,56(a5)
    8000425c:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80004260:	0407b783          	ld	a5,64(a5)
    80004264:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80004268:	00048513          	mv	a0,s1
    8000426c:	00000097          	auipc	ra,0x0
    80004270:	554080e7          	jalr	1364(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80004274:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80004278:	00000097          	auipc	ra,0x0
    8000427c:	83c080e7          	jalr	-1988(ra) # 80003ab4 <_ZN5RiscV16saveA0toSscratchEv>

}
    80004280:	01813083          	ld	ra,24(sp)
    80004284:	01013403          	ld	s0,16(sp)
    80004288:	00813483          	ld	s1,8(sp)
    8000428c:	00013903          	ld	s2,0(sp)
    80004290:	02010113          	addi	sp,sp,32
    80004294:	00008067          	ret
        status = -1;
    80004298:	fff00493          	li	s1,-1
    8000429c:	fd9ff06f          	j	80004274 <_ZN5RiscV18executeForkSyscallEv+0x108>
    800042a0:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    800042a4:	00048513          	mv	a0,s1
    800042a8:	fffff097          	auipc	ra,0xfffff
    800042ac:	bbc080e7          	jalr	-1092(ra) # 80002e64 <_ZN3TCBdlEPv>
    800042b0:	00090513          	mv	a0,s2
    800042b4:	0000e097          	auipc	ra,0xe
    800042b8:	454080e7          	jalr	1108(ra) # 80012708 <_Unwind_Resume>

00000000800042bc <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    800042bc:	ff010113          	addi	sp,sp,-16
    800042c0:	00813423          	sd	s0,8(sp)
    800042c4:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    800042c8:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    800042cc:	00878793          	addi	a5,a5,8
    800042d0:	00009717          	auipc	a4,0x9
    800042d4:	07873703          	ld	a4,120(a4) # 8000d348 <_GLOBAL_OFFSET_TABLE_+0x50>
    800042d8:	00f73023          	sd	a5,0(a4)
}
    800042dc:	00813403          	ld	s0,8(sp)
    800042e0:	01010113          	addi	sp,sp,16
    800042e4:	00008067          	ret

00000000800042e8 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    800042e8:	fa010113          	addi	sp,sp,-96
    800042ec:	04113c23          	sd	ra,88(sp)
    800042f0:	04813823          	sd	s0,80(sp)
    800042f4:	06010413          	addi	s0,sp,96
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800042f8:	142027f3          	csrr	a5,scause
    800042fc:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    80004300:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = RiscV::r_scause();
    80004304:	fef43423          	sd	a5,-24(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80004308:	00009797          	auipc	a5,0x9
    8000430c:	0787b783          	ld	a5,120(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004310:	0007b783          	ld	a5,0(a5)
    80004314:	14002773          	csrr	a4,sscratch
    80004318:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    8000431c:	fe843703          	ld	a4,-24(s0)
    80004320:	00900793          	li	a5,9
    80004324:	0ef70663          	beq	a4,a5,80004410 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    80004328:	fe843703          	ld	a4,-24(s0)
    8000432c:	00800793          	li	a5,8
    80004330:	0ef70063          	beq	a4,a5,80004410 <_ZN5RiscV20handleSupervisorTrapEv+0x128>
    else if(scause == (0x01UL<<63 | 0x1)){
    80004334:	fe843703          	ld	a4,-24(s0)
    80004338:	fff00793          	li	a5,-1
    8000433c:	03f79793          	slli	a5,a5,0x3f
    80004340:	00178793          	addi	a5,a5,1
    80004344:	24f70263          	beq	a4,a5,80004588 <_ZN5RiscV20handleSupervisorTrapEv+0x2a0>
    else if(scause == (0x01UL<<63 | 0x9)){
    80004348:	fe843703          	ld	a4,-24(s0)
    8000434c:	fff00793          	li	a5,-1
    80004350:	03f79793          	slli	a5,a5,0x3f
    80004354:	00978793          	addi	a5,a5,9
    80004358:	2cf70063          	beq	a4,a5,80004618 <_ZN5RiscV20handleSupervisorTrapEv+0x330>
    else if(scause == 0x02){
    8000435c:	fe843703          	ld	a4,-24(s0)
    80004360:	00200793          	li	a5,2
    80004364:	34f70863          	beq	a4,a5,800046b4 <_ZN5RiscV20handleSupervisorTrapEv+0x3cc>
        ConsoleUtil::printString("Error: \n");
    80004368:	00006517          	auipc	a0,0x6
    8000436c:	fc850513          	addi	a0,a0,-56 # 8000a330 <CONSOLE_STATUS+0x320>
    80004370:	00001097          	auipc	ra,0x1
    80004374:	8d4080e7          	jalr	-1836(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80004378:	00006517          	auipc	a0,0x6
    8000437c:	fc850513          	addi	a0,a0,-56 # 8000a340 <CONSOLE_STATUS+0x330>
    80004380:	00001097          	auipc	ra,0x1
    80004384:	8c4080e7          	jalr	-1852(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80004388:	142027f3          	csrr	a5,scause
    8000438c:	fef43023          	sd	a5,-32(s0)
    return scause;
    80004390:	fe043503          	ld	a0,-32(s0)
        ConsoleUtil::printInt(scause);
    80004394:	00000613          	li	a2,0
    80004398:	00a00593          	li	a1,10
    8000439c:	0005051b          	sext.w	a0,a0
    800043a0:	00001097          	auipc	ra,0x1
    800043a4:	8e8080e7          	jalr	-1816(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    800043a8:	00006517          	auipc	a0,0x6
    800043ac:	f5850513          	addi	a0,a0,-168 # 8000a300 <CONSOLE_STATUS+0x2f0>
    800043b0:	00001097          	auipc	ra,0x1
    800043b4:	894080e7          	jalr	-1900(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800043b8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800043bc:	00000613          	li	a2,0
    800043c0:	01000593          	li	a1,16
    800043c4:	0005051b          	sext.w	a0,a0
    800043c8:	00001097          	auipc	ra,0x1
    800043cc:	8c0080e7          	jalr	-1856(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800043d0:	00006517          	auipc	a0,0x6
    800043d4:	f2850513          	addi	a0,a0,-216 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800043d8:	00001097          	auipc	ra,0x1
    800043dc:	86c080e7          	jalr	-1940(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        TCB* old = TCB::running;
    800043e0:	00009797          	auipc	a5,0x9
    800043e4:	fa07b783          	ld	a5,-96(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    800043e8:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800043ec:	00200713          	li	a4,2
    800043f0:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    800043f4:	00006517          	auipc	a0,0x6
    800043f8:	f5c50513          	addi	a0,a0,-164 # 8000a350 <CONSOLE_STATUS+0x340>
    800043fc:	00001097          	auipc	ra,0x1
    80004400:	848080e7          	jalr	-1976(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004404:	fffff097          	auipc	ra,0xfffff
    80004408:	8ec080e7          	jalr	-1812(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
    8000440c:	0800006f          	j	8000448c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004410:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004414:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004418:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    8000441c:	00478793          	addi	a5,a5,4
    80004420:	faf43823          	sd	a5,-80(s0)
        TCB::running->sepc = sepc;
    80004424:	00009797          	auipc	a5,0x9
    80004428:	f5c7b783          	ld	a5,-164(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    8000442c:	0007b783          	ld	a5,0(a5)
    80004430:	fb043703          	ld	a4,-80(s0)
    80004434:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80004438:	fa843703          	ld	a4,-88(s0)
    8000443c:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80004440:	00050793          	mv	a5,a0
        switch(syscallID){
    80004444:	06100713          	li	a4,97
    80004448:	02f76463          	bltu	a4,a5,80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    8000444c:	00279793          	slli	a5,a5,0x2
    80004450:	00006717          	auipc	a4,0x6
    80004454:	f1470713          	addi	a4,a4,-236 # 8000a364 <CONSOLE_STATUS+0x354>
    80004458:	00e787b3          	add	a5,a5,a4
    8000445c:	0007a783          	lw	a5,0(a5)
    80004460:	00e787b3          	add	a5,a5,a4
    80004464:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80004468:	fffff097          	auipc	ra,0xfffff
    8000446c:	684080e7          	jalr	1668(ra) # 80003aec <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80004470:	00009797          	auipc	a5,0x9
    80004474:	f107b783          	ld	a5,-240(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    80004478:	0007b783          	ld	a5,0(a5)
    8000447c:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004480:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80004484:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004488:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    8000448c:	fffff097          	auipc	ra,0xfffff
    80004490:	530080e7          	jalr	1328(ra) # 800039bc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80004494:	05813083          	ld	ra,88(sp)
    80004498:	05013403          	ld	s0,80(sp)
    8000449c:	06010113          	addi	sp,sp,96
    800044a0:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    800044a4:	fffff097          	auipc	ra,0xfffff
    800044a8:	680080e7          	jalr	1664(ra) # 80003b24 <_ZN5RiscV21executeMemFreeSyscallEv>
    800044ac:	fc5ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x11 : executeThreadCreateSyscall();break;
    800044b0:	fffff097          	auipc	ra,0xfffff
    800044b4:	6c4080e7          	jalr	1732(ra) # 80003b74 <_ZN5RiscV26executeThreadCreateSyscallEv>
    800044b8:	fb9ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x12 : executeThreadExitSyscall();break;
    800044bc:	00000097          	auipc	ra,0x0
    800044c0:	8a4080e7          	jalr	-1884(ra) # 80003d60 <_ZN5RiscV24executeThreadExitSyscallEv>
    800044c4:	fadff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x13 : executeThreadDispatchSyscall();break;
    800044c8:	fffff097          	auipc	ra,0xfffff
    800044cc:	3e0080e7          	jalr	992(ra) # 800038a8 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    800044d0:	fa1ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x14 : executeThreadAttachBodySyscall();break;
    800044d4:	fffff097          	auipc	ra,0xfffff
    800044d8:	770080e7          	jalr	1904(ra) # 80003c44 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    800044dc:	f95ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x15 : executeThreadStartSyscall();break;
    800044e0:	00000097          	auipc	ra,0x0
    800044e4:	828080e7          	jalr	-2008(ra) # 80003d08 <_ZN5RiscV25executeThreadStartSyscallEv>
    800044e8:	f89ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x21 : executeSemOpenSyscall();break;
    800044ec:	00000097          	auipc	ra,0x0
    800044f0:	8cc080e7          	jalr	-1844(ra) # 80003db8 <_ZN5RiscV21executeSemOpenSyscallEv>
    800044f4:	f7dff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x22 : executeSemCloseSyscall();break;
    800044f8:	00000097          	auipc	ra,0x0
    800044fc:	958080e7          	jalr	-1704(ra) # 80003e50 <_ZN5RiscV22executeSemCloseSyscallEv>
    80004500:	f71ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x23 : executeSemWaitSyscall();break;
    80004504:	00000097          	auipc	ra,0x0
    80004508:	9ac080e7          	jalr	-1620(ra) # 80003eb0 <_ZN5RiscV21executeSemWaitSyscallEv>
    8000450c:	f65ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x24 : executeSemSignalSyscall();break;
    80004510:	00000097          	auipc	ra,0x0
    80004514:	a00080e7          	jalr	-1536(ra) # 80003f10 <_ZN5RiscV23executeSemSignalSyscallEv>
    80004518:	f59ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x31 : executeTimeSleepSyscall();break;
    8000451c:	00000097          	auipc	ra,0x0
    80004520:	a3c080e7          	jalr	-1476(ra) # 80003f58 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004524:	f4dff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x41 : executeGetcSyscall();break;
    80004528:	00000097          	auipc	ra,0x0
    8000452c:	aa8080e7          	jalr	-1368(ra) # 80003fd0 <_ZN5RiscV18executeGetcSyscallEv>
    80004530:	f41ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x42 : executePutcSyscall();break;
    80004534:	fffff097          	auipc	ra,0xfffff
    80004538:	3b0080e7          	jalr	944(ra) # 800038e4 <_ZN5RiscV18executePutcSyscallEv>
    8000453c:	f35ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x43 : executePutcUtilSyscall();break;
    80004540:	00000097          	auipc	ra,0x0
    80004544:	b28080e7          	jalr	-1240(ra) # 80004068 <_ZN5RiscV22executePutcUtilSyscallEv>
    80004548:	f29ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x51 : executeThreadFreeSyscall();break;
    8000454c:	00000097          	auipc	ra,0x0
    80004550:	b50080e7          	jalr	-1200(ra) # 8000409c <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004554:	f1dff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80004558:	00000097          	auipc	ra,0x0
    8000455c:	bb8080e7          	jalr	-1096(ra) # 80004110 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004560:	f11ff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004564:	00010793          	mv	a5,sp
    80004568:	00009717          	auipc	a4,0x9
    8000456c:	dd073703          	ld	a4,-560(a4) # 8000d338 <_GLOBAL_OFFSET_TABLE_+0x40>
    80004570:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004574:	00000097          	auipc	ra,0x0
    80004578:	d48080e7          	jalr	-696(ra) # 800042bc <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    8000457c:	00000097          	auipc	ra,0x0
    80004580:	bf0080e7          	jalr	-1040(ra) # 8000416c <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004584:	eedff06f          	j	80004470 <_ZN5RiscV20handleSupervisorTrapEv+0x188>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004588:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000458c:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004590:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004594:	fcf43023          	sd	a5,-64(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80004598:	00200793          	li	a5,2
    8000459c:	1447b073          	csrc	sip,a5
        globalTime += 1;
    800045a0:	00009717          	auipc	a4,0x9
    800045a4:	01070713          	addi	a4,a4,16 # 8000d5b0 <_ZN5RiscV16userMainFinishedE>
    800045a8:	00873783          	ld	a5,8(a4)
    800045ac:	00178793          	addi	a5,a5,1
    800045b0:	00f73423          	sd	a5,8(a4)
        Scheduler::awake();
    800045b4:	00000097          	auipc	ra,0x0
    800045b8:	2e0080e7          	jalr	736(ra) # 80004894 <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    800045bc:	00009717          	auipc	a4,0x9
    800045c0:	d5c73703          	ld	a4,-676(a4) # 8000d318 <_GLOBAL_OFFSET_TABLE_+0x20>
    800045c4:	00073783          	ld	a5,0(a4)
    800045c8:	00178793          	addi	a5,a5,1
    800045cc:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    800045d0:	00009717          	auipc	a4,0x9
    800045d4:	db073703          	ld	a4,-592(a4) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    800045d8:	00073703          	ld	a4,0(a4)
    800045dc:	03073683          	ld	a3,48(a4)
    800045e0:	00d7fc63          	bgeu	a5,a3,800045f8 <_ZN5RiscV20handleSupervisorTrapEv+0x310>
        RiscV::w_sstatus(sstatus);
    800045e4:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800045e8:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800045ec:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800045f0:	14179073          	csrw	sepc,a5
}
    800045f4:	e99ff06f          	j	8000448c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
            TCB::timeSliceCounter = 0;
    800045f8:	00009797          	auipc	a5,0x9
    800045fc:	d207b783          	ld	a5,-736(a5) # 8000d318 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004600:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004604:	00100793          	li	a5,1
    80004608:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    8000460c:	ffffe097          	auipc	ra,0xffffe
    80004610:	6e4080e7          	jalr	1764(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
    80004614:	fd1ff06f          	j	800045e4 <_ZN5RiscV20handleSupervisorTrapEv+0x2fc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80004618:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    8000461c:	fcf43423          	sd	a5,-56(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004620:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004624:	fcf43823          	sd	a5,-48(s0)
        uint64 status = CONSOLE_STATUS;
    80004628:	00009797          	auipc	a5,0x9
    8000462c:	ce07b783          	ld	a5,-800(a5) # 8000d308 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004630:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004634:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004638:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    8000463c:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004640:	0017f793          	andi	a5,a5,1
    80004644:	02078863          	beqz	a5,80004674 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
            data = CONSOLE_TX_DATA;
    80004648:	00009797          	auipc	a5,0x9
    8000464c:	ce07b783          	ld	a5,-800(a5) # 8000d328 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004650:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004654:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80004658:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    8000465c:	00058513          	mv	a0,a1
    80004660:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004664:	00009797          	auipc	a5,0x9
    80004668:	ccc7b783          	ld	a5,-820(a5) # 8000d330 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000466c:	0007b783          	ld	a5,0(a5)
    80004670:	02079463          	bnez	a5,80004698 <_ZN5RiscV20handleSupervisorTrapEv+0x3b0>
        plic_complete(plic_claim());
    80004674:	00003097          	auipc	ra,0x3
    80004678:	360080e7          	jalr	864(ra) # 800079d4 <plic_claim>
    8000467c:	00003097          	auipc	ra,0x3
    80004680:	390080e7          	jalr	912(ra) # 80007a0c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004684:	fc843783          	ld	a5,-56(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80004688:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    8000468c:	fd043783          	ld	a5,-48(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004690:	14179073          	csrw	sepc,a5
}
    80004694:	df9ff06f          	j	8000448c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>
                ConsoleUtil::pendingGetc--;
    80004698:	fff78793          	addi	a5,a5,-1
    8000469c:	00009717          	auipc	a4,0x9
    800046a0:	c9473703          	ld	a4,-876(a4) # 8000d330 <_GLOBAL_OFFSET_TABLE_+0x38>
    800046a4:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800046a8:	00000097          	auipc	ra,0x0
    800046ac:	3c4080e7          	jalr	964(ra) # 80004a6c <_ZN11ConsoleUtil8putInputEc>
    800046b0:	fc5ff06f          	j	80004674 <_ZN5RiscV20handleSupervisorTrapEv+0x38c>
        TCB* old = TCB::running;
    800046b4:	00009797          	auipc	a5,0x9
    800046b8:	ccc7b783          	ld	a5,-820(a5) # 8000d380 <_GLOBAL_OFFSET_TABLE_+0x88>
    800046bc:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800046c0:	00200713          	li	a4,2
    800046c4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800046c8:	00006517          	auipc	a0,0x6
    800046cc:	c3850513          	addi	a0,a0,-968 # 8000a300 <CONSOLE_STATUS+0x2f0>
    800046d0:	00000097          	auipc	ra,0x0
    800046d4:	574080e7          	jalr	1396(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800046d8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800046dc:	00000613          	li	a2,0
    800046e0:	01000593          	li	a1,16
    800046e4:	0005051b          	sext.w	a0,a0
    800046e8:	00000097          	auipc	ra,0x0
    800046ec:	5a0080e7          	jalr	1440(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800046f0:	00006517          	auipc	a0,0x6
    800046f4:	c0850513          	addi	a0,a0,-1016 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800046f8:	00000097          	auipc	ra,0x0
    800046fc:	54c080e7          	jalr	1356(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004700:	00006517          	auipc	a0,0x6
    80004704:	c0850513          	addi	a0,a0,-1016 # 8000a308 <CONSOLE_STATUS+0x2f8>
    80004708:	00000097          	auipc	ra,0x0
    8000470c:	53c080e7          	jalr	1340(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004710:	ffffe097          	auipc	ra,0xffffe
    80004714:	5e0080e7          	jalr	1504(ra) # 80002cf0 <_ZN3TCB8dispatchEv>
    80004718:	d75ff06f          	j	8000448c <_ZN5RiscV20handleSupervisorTrapEv+0x1a4>

000000008000471c <_Z6strcpyPKcPc>:
//
// Created by os on 1/2/23.
//
#include "../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    8000471c:	ff010113          	addi	sp,sp,-16
    80004720:	00813423          	sd	s0,8(sp)
    80004724:	01010413          	addi	s0,sp,16
    80004728:	00050793          	mv	a5,a0
    8000472c:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004730:	0007c703          	lbu	a4,0(a5)
    80004734:	00070a63          	beqz	a4,80004748 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004738:	00178793          	addi	a5,a5,1
    8000473c:	00e50023          	sb	a4,0(a0)
    80004740:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    80004744:	fedff06f          	j	80004730 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    80004748:	00e50023          	sb	a4,0(a0)
    return dst;
}
    8000474c:	00813403          	ld	s0,8(sp)
    80004750:	01010113          	addi	sp,sp,16
    80004754:	00008067          	ret

0000000080004758 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    80004758:	fe010113          	addi	sp,sp,-32
    8000475c:	00113c23          	sd	ra,24(sp)
    80004760:	00813823          	sd	s0,16(sp)
    80004764:	00913423          	sd	s1,8(sp)
    80004768:	02010413          	addi	s0,sp,32
    8000476c:	00050493          	mv	s1,a0
    80004770:	00058513          	mv	a0,a1
    char *dest = dst;
    80004774:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004778:	0005c783          	lbu	a5,0(a1)
    8000477c:	00078663          	beqz	a5,80004788 <_Z6strcatPcPKc+0x30>
        dest++;
    80004780:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    80004784:	ff5ff06f          	j	80004778 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004788:	00000097          	auipc	ra,0x0
    8000478c:	f94080e7          	jalr	-108(ra) # 8000471c <_Z6strcpyPKcPc>
    return dst;
}
    80004790:	00048513          	mv	a0,s1
    80004794:	01813083          	ld	ra,24(sp)
    80004798:	01013403          	ld	s0,16(sp)
    8000479c:	00813483          	ld	s1,8(sp)
    800047a0:	02010113          	addi	sp,sp,32
    800047a4:	00008067          	ret

00000000800047a8 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    800047a8:	ff010113          	addi	sp,sp,-16
    800047ac:	00813423          	sd	s0,8(sp)
    800047b0:	01010413          	addi	s0,sp,16
}
    800047b4:	00813403          	ld	s0,8(sp)
    800047b8:	01010113          	addi	sp,sp,16
    800047bc:	00008067          	ret

00000000800047c0 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    800047c0:	ff010113          	addi	sp,sp,-16
    800047c4:	00813423          	sd	s0,8(sp)
    800047c8:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    800047cc:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800047d0:	00009797          	auipc	a5,0x9
    800047d4:	df07b783          	ld	a5,-528(a5) # 8000d5c0 <_ZN9Scheduler9readyHeadE>
    800047d8:	02078263          	beqz	a5,800047fc <_ZN9Scheduler3putEP3TCB+0x3c>
    800047dc:	00009797          	auipc	a5,0x9
    800047e0:	dec7b783          	ld	a5,-532(a5) # 8000d5c8 <_ZN9Scheduler9readyTailE>
    800047e4:	04a7b423          	sd	a0,72(a5)
    800047e8:	00009797          	auipc	a5,0x9
    800047ec:	dea7b023          	sd	a0,-544(a5) # 8000d5c8 <_ZN9Scheduler9readyTailE>
}
    800047f0:	00813403          	ld	s0,8(sp)
    800047f4:	01010113          	addi	sp,sp,16
    800047f8:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    800047fc:	00009797          	auipc	a5,0x9
    80004800:	dca7b223          	sd	a0,-572(a5) # 8000d5c0 <_ZN9Scheduler9readyHeadE>
    80004804:	fe5ff06f          	j	800047e8 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004808 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004808:	ff010113          	addi	sp,sp,-16
    8000480c:	00813423          	sd	s0,8(sp)
    80004810:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    80004814:	00009517          	auipc	a0,0x9
    80004818:	dac53503          	ld	a0,-596(a0) # 8000d5c0 <_ZN9Scheduler9readyHeadE>
    8000481c:	00050a63          	beqz	a0,80004830 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004820:	04853783          	ld	a5,72(a0)
    80004824:	00009717          	auipc	a4,0x9
    80004828:	d8f73e23          	sd	a5,-612(a4) # 8000d5c0 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    8000482c:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004830:	00813403          	ld	s0,8(sp)
    80004834:	01010113          	addi	sp,sp,16
    80004838:	00008067          	ret

000000008000483c <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    8000483c:	ff010113          	addi	sp,sp,-16
    80004840:	00813423          	sd	s0,8(sp)
    80004844:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    80004848:	00009797          	auipc	a5,0x9
    8000484c:	d887b783          	ld	a5,-632(a5) # 8000d5d0 <_ZN9Scheduler12sleepingHeadE>
    80004850:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004854:	00078e63          	beqz	a5,80004870 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    80004858:	0587b683          	ld	a3,88(a5)
    8000485c:	05853703          	ld	a4,88(a0)
    80004860:	00d76863          	bltu	a4,a3,80004870 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    80004864:	00078613          	mv	a2,a5
    80004868:	0487b783          	ld	a5,72(a5)
    8000486c:	fe9ff06f          	j	80004854 <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004870:	04f53423          	sd	a5,72(a0)
    if(prev)
    80004874:	00060a63          	beqz	a2,80004888 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004878:	04a63423          	sd	a0,72(a2) # 1048 <_entry-0x7fffefb8>
    else
        sleepingHead = t;
}
    8000487c:	00813403          	ld	s0,8(sp)
    80004880:	01010113          	addi	sp,sp,16
    80004884:	00008067          	ret
        sleepingHead = t;
    80004888:	00009797          	auipc	a5,0x9
    8000488c:	d4a7b423          	sd	a0,-696(a5) # 8000d5d0 <_ZN9Scheduler12sleepingHeadE>
}
    80004890:	fedff06f          	j	8000487c <_ZN9Scheduler5sleepEP3TCB+0x40>

0000000080004894 <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    80004894:	fe010113          	addi	sp,sp,-32
    80004898:	00113c23          	sd	ra,24(sp)
    8000489c:	00813823          	sd	s0,16(sp)
    800048a0:	00913423          	sd	s1,8(sp)
    800048a4:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    800048a8:	00009497          	auipc	s1,0x9
    800048ac:	d284b483          	ld	s1,-728(s1) # 8000d5d0 <_ZN9Scheduler12sleepingHeadE>
    800048b0:	02048c63          	beqz	s1,800048e8 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    800048b4:	0584b703          	ld	a4,88(s1)
    800048b8:	00009797          	auipc	a5,0x9
    800048bc:	ae07b783          	ld	a5,-1312(a5) # 8000d398 <_GLOBAL_OFFSET_TABLE_+0xa0>
    800048c0:	0007b783          	ld	a5,0(a5)
    800048c4:	02e7e263          	bltu	a5,a4,800048e8 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    800048c8:	0484b783          	ld	a5,72(s1)
    800048cc:	00009717          	auipc	a4,0x9
    800048d0:	d0f73223          	sd	a5,-764(a4) # 8000d5d0 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    800048d4:	00048513          	mv	a0,s1
    800048d8:	00000097          	auipc	ra,0x0
    800048dc:	ee8080e7          	jalr	-280(ra) # 800047c0 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    800048e0:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    800048e4:	fc5ff06f          	j	800048a8 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    800048e8:	01813083          	ld	ra,24(sp)
    800048ec:	01013403          	ld	s0,16(sp)
    800048f0:	00813483          	ld	s1,8(sp)
    800048f4:	02010113          	addi	sp,sp,32
    800048f8:	00008067          	ret

00000000800048fc <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    800048fc:	fe010113          	addi	sp,sp,-32
    80004900:	00113c23          	sd	ra,24(sp)
    80004904:	00813823          	sd	s0,16(sp)
    80004908:	00913423          	sd	s1,8(sp)
    8000490c:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004910:	00009497          	auipc	s1,0x9
    80004914:	cb04b483          	ld	s1,-848(s1) # 8000d5c0 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004918:	02048863          	beqz	s1,80004948 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    8000491c:	00000613          	li	a2,0
    80004920:	01000593          	li	a1,16
    80004924:	0004851b          	sext.w	a0,s1
    80004928:	00000097          	auipc	ra,0x0
    8000492c:	360080e7          	jalr	864(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004930:	00006517          	auipc	a0,0x6
    80004934:	9c850513          	addi	a0,a0,-1592 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80004938:	00000097          	auipc	ra,0x0
    8000493c:	30c080e7          	jalr	780(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004940:	0484b483          	ld	s1,72(s1)
    while(iter){
    80004944:	fd5ff06f          	j	80004918 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    80004948:	01813083          	ld	ra,24(sp)
    8000494c:	01013403          	ld	s0,16(sp)
    80004950:	00813483          	ld	s1,8(sp)
    80004954:	02010113          	addi	sp,sp,32
    80004958:	00008067          	ret

000000008000495c <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    8000495c:	fe010113          	addi	sp,sp,-32
    80004960:	00113c23          	sd	ra,24(sp)
    80004964:	00813823          	sd	s0,16(sp)
    80004968:	00913423          	sd	s1,8(sp)
    8000496c:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004970:	00009497          	auipc	s1,0x9
    80004974:	c604b483          	ld	s1,-928(s1) # 8000d5d0 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004978:	02048863          	beqz	s1,800049a8 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    8000497c:	00000613          	li	a2,0
    80004980:	01000593          	li	a1,16
    80004984:	0004851b          	sext.w	a0,s1
    80004988:	ffffe097          	auipc	ra,0xffffe
    8000498c:	edc080e7          	jalr	-292(ra) # 80002864 <_Z8printIntiii>
        printString("\n");
    80004990:	00006517          	auipc	a0,0x6
    80004994:	96850513          	addi	a0,a0,-1688 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80004998:	ffffe097          	auipc	ra,0xffffe
    8000499c:	d34080e7          	jalr	-716(ra) # 800026cc <_Z11printStringPKc>
        iter = iter->next;
    800049a0:	0484b483          	ld	s1,72(s1)
    while(iter){
    800049a4:	fd5ff06f          	j	80004978 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    800049a8:	01813083          	ld	ra,24(sp)
    800049ac:	01013403          	ld	s0,16(sp)
    800049b0:	00813483          	ld	s1,8(sp)
    800049b4:	02010113          	addi	sp,sp,32
    800049b8:	00008067          	ret

00000000800049bc <_ZN11ConsoleUtil10initializeEv>:
SCB* ConsoleUtil::inputSem = nullptr;

char ConsoleUtil::inputBuffer[bufferSize];
char ConsoleUtil::outputBuffer[bufferSize];

void ConsoleUtil::initialize() {
    800049bc:	fe010113          	addi	sp,sp,-32
    800049c0:	00113c23          	sd	ra,24(sp)
    800049c4:	00813823          	sd	s0,16(sp)
    800049c8:	00913423          	sd	s1,8(sp)
    800049cc:	01213023          	sd	s2,0(sp)
    800049d0:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    800049d4:	01800513          	li	a0,24
    800049d8:	ffffe097          	auipc	ra,0xffffe
    800049dc:	15c080e7          	jalr	348(ra) # 80002b34 <_ZN3SCBnwEm>
    800049e0:	00050493          	mv	s1,a0
    800049e4:	00000593          	li	a1,0
    800049e8:	ffffe097          	auipc	ra,0xffffe
    800049ec:	f90080e7          	jalr	-112(ra) # 80002978 <_ZN3SCBC1Em>
    800049f0:	00009797          	auipc	a5,0x9
    800049f4:	be97b423          	sd	s1,-1048(a5) # 8000d5d8 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    800049f8:	01800513          	li	a0,24
    800049fc:	ffffe097          	auipc	ra,0xffffe
    80004a00:	138080e7          	jalr	312(ra) # 80002b34 <_ZN3SCBnwEm>
    80004a04:	00050493          	mv	s1,a0
    80004a08:	00000593          	li	a1,0
    80004a0c:	ffffe097          	auipc	ra,0xffffe
    80004a10:	f6c080e7          	jalr	-148(ra) # 80002978 <_ZN3SCBC1Em>
    80004a14:	00009797          	auipc	a5,0x9
    80004a18:	bc97b623          	sd	s1,-1076(a5) # 8000d5e0 <_ZN11ConsoleUtil9outputSemE>
}
    80004a1c:	01813083          	ld	ra,24(sp)
    80004a20:	01013403          	ld	s0,16(sp)
    80004a24:	00813483          	ld	s1,8(sp)
    80004a28:	00013903          	ld	s2,0(sp)
    80004a2c:	02010113          	addi	sp,sp,32
    80004a30:	00008067          	ret
    80004a34:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004a38:	00048513          	mv	a0,s1
    80004a3c:	ffffe097          	auipc	ra,0xffffe
    80004a40:	120080e7          	jalr	288(ra) # 80002b5c <_ZN3SCBdlEPv>
    80004a44:	00090513          	mv	a0,s2
    80004a48:	0000e097          	auipc	ra,0xe
    80004a4c:	cc0080e7          	jalr	-832(ra) # 80012708 <_Unwind_Resume>
    80004a50:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    80004a54:	00048513          	mv	a0,s1
    80004a58:	ffffe097          	auipc	ra,0xffffe
    80004a5c:	104080e7          	jalr	260(ra) # 80002b5c <_ZN3SCBdlEPv>
    80004a60:	00090513          	mv	a0,s2
    80004a64:	0000e097          	auipc	ra,0xe
    80004a68:	ca4080e7          	jalr	-860(ra) # 80012708 <_Unwind_Resume>

0000000080004a6c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    80004a6c:	00009697          	auipc	a3,0x9
    80004a70:	b6c68693          	addi	a3,a3,-1172 # 8000d5d8 <_ZN11ConsoleUtil8inputSemE>
    80004a74:	0106b603          	ld	a2,16(a3)
    80004a78:	00160793          	addi	a5,a2,1
    80004a7c:	00002737          	lui	a4,0x2
    80004a80:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004a84:	00e7f7b3          	and	a5,a5,a4
    80004a88:	0186b703          	ld	a4,24(a3)
    80004a8c:	04e78263          	beq	a5,a4,80004ad0 <_ZN11ConsoleUtil8putInputEc+0x64>
void ConsoleUtil::putInput(char c) {
    80004a90:	ff010113          	addi	sp,sp,-16
    80004a94:	00113423          	sd	ra,8(sp)
    80004a98:	00813023          	sd	s0,0(sp)
    80004a9c:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004aa0:	0000b717          	auipc	a4,0xb
    80004aa4:	b7070713          	addi	a4,a4,-1168 # 8000f610 <_ZN11ConsoleUtil11inputBufferE>
    80004aa8:	00c70633          	add	a2,a4,a2
    80004aac:	00a60023          	sb	a0,0(a2)
    inputTail = (inputTail+1)%bufferSize;
    80004ab0:	00f6b823          	sd	a5,16(a3)
    inputSem->signal();
    80004ab4:	0006b503          	ld	a0,0(a3)
    80004ab8:	ffffe097          	auipc	ra,0xffffe
    80004abc:	040080e7          	jalr	64(ra) # 80002af8 <_ZN3SCB6signalEv>
}
    80004ac0:	00813083          	ld	ra,8(sp)
    80004ac4:	00013403          	ld	s0,0(sp)
    80004ac8:	01010113          	addi	sp,sp,16
    80004acc:	00008067          	ret
    80004ad0:	00008067          	ret

0000000080004ad4 <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    80004ad4:	fe010113          	addi	sp,sp,-32
    80004ad8:	00113c23          	sd	ra,24(sp)
    80004adc:	00813823          	sd	s0,16(sp)
    80004ae0:	00913423          	sd	s1,8(sp)
    80004ae4:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004ae8:	00009497          	auipc	s1,0x9
    80004aec:	af048493          	addi	s1,s1,-1296 # 8000d5d8 <_ZN11ConsoleUtil8inputSemE>
    80004af0:	0004b503          	ld	a0,0(s1)
    80004af4:	ffffe097          	auipc	ra,0xffffe
    80004af8:	fb4080e7          	jalr	-76(ra) # 80002aa8 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004afc:	0184b783          	ld	a5,24(s1)
    80004b00:	0104b703          	ld	a4,16(s1)
    80004b04:	04e78063          	beq	a5,a4,80004b44 <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004b08:	0000b717          	auipc	a4,0xb
    80004b0c:	b0870713          	addi	a4,a4,-1272 # 8000f610 <_ZN11ConsoleUtil11inputBufferE>
    80004b10:	00f70733          	add	a4,a4,a5
    80004b14:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004b18:	00178793          	addi	a5,a5,1
    80004b1c:	00002737          	lui	a4,0x2
    80004b20:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004b24:	00e7f7b3          	and	a5,a5,a4
    80004b28:	00009717          	auipc	a4,0x9
    80004b2c:	acf73423          	sd	a5,-1336(a4) # 8000d5f0 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004b30:	01813083          	ld	ra,24(sp)
    80004b34:	01013403          	ld	s0,16(sp)
    80004b38:	00813483          	ld	s1,8(sp)
    80004b3c:	02010113          	addi	sp,sp,32
    80004b40:	00008067          	ret
        return -1;
    80004b44:	0ff00513          	li	a0,255
    80004b48:	fe9ff06f          	j	80004b30 <_ZN11ConsoleUtil8getInputEv+0x5c>

0000000080004b4c <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    80004b4c:	00009797          	auipc	a5,0x9
    80004b50:	a8c78793          	addi	a5,a5,-1396 # 8000d5d8 <_ZN11ConsoleUtil8inputSemE>
    80004b54:	0207b603          	ld	a2,32(a5)
    80004b58:	00160713          	addi	a4,a2,1
    80004b5c:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004b60:	0287b583          	ld	a1,40(a5)
    80004b64:	00158713          	addi	a4,a1,1
    80004b68:	000026b7          	lui	a3,0x2
    80004b6c:	fff68693          	addi	a3,a3,-1 # 1fff <_entry-0x7fffe001>
    80004b70:	00d77733          	and	a4,a4,a3
    80004b74:	0307b783          	ld	a5,48(a5)
    80004b78:	04f70863          	beq	a4,a5,80004bc8 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80004b7c:	ff010113          	addi	sp,sp,-16
    80004b80:	00113423          	sd	ra,8(sp)
    80004b84:	00813023          	sd	s0,0(sp)
    80004b88:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004b8c:	00009797          	auipc	a5,0x9
    80004b90:	a8478793          	addi	a5,a5,-1404 # 8000d610 <_ZN11ConsoleUtil12outputBufferE>
    80004b94:	00b785b3          	add	a1,a5,a1
    80004b98:	00a58023          	sb	a0,0(a1)

    outputTail = (outputTail+1)%bufferSize;
    80004b9c:	00009797          	auipc	a5,0x9
    80004ba0:	a3c78793          	addi	a5,a5,-1476 # 8000d5d8 <_ZN11ConsoleUtil8inputSemE>
    80004ba4:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004ba8:	02c7b023          	sd	a2,32(a5)

    outputSem->signal();
    80004bac:	0087b503          	ld	a0,8(a5)
    80004bb0:	ffffe097          	auipc	ra,0xffffe
    80004bb4:	f48080e7          	jalr	-184(ra) # 80002af8 <_ZN3SCB6signalEv>
}
    80004bb8:	00813083          	ld	ra,8(sp)
    80004bbc:	00013403          	ld	s0,0(sp)
    80004bc0:	01010113          	addi	sp,sp,16
    80004bc4:	00008067          	ret
    80004bc8:	00008067          	ret

0000000080004bcc <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004bcc:	fe010113          	addi	sp,sp,-32
    80004bd0:	00113c23          	sd	ra,24(sp)
    80004bd4:	00813823          	sd	s0,16(sp)
    80004bd8:	00913423          	sd	s1,8(sp)
    80004bdc:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004be0:	00009497          	auipc	s1,0x9
    80004be4:	9f848493          	addi	s1,s1,-1544 # 8000d5d8 <_ZN11ConsoleUtil8inputSemE>
    80004be8:	0084b503          	ld	a0,8(s1)
    80004bec:	ffffe097          	auipc	ra,0xffffe
    80004bf0:	ebc080e7          	jalr	-324(ra) # 80002aa8 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    80004bf4:	0304b783          	ld	a5,48(s1)
    80004bf8:	0284b703          	ld	a4,40(s1)
    80004bfc:	04e78063          	beq	a5,a4,80004c3c <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004c00:	00009717          	auipc	a4,0x9
    80004c04:	a1070713          	addi	a4,a4,-1520 # 8000d610 <_ZN11ConsoleUtil12outputBufferE>
    80004c08:	00f70733          	add	a4,a4,a5
    80004c0c:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004c10:	00178793          	addi	a5,a5,1
    80004c14:	00002737          	lui	a4,0x2
    80004c18:	fff70713          	addi	a4,a4,-1 # 1fff <_entry-0x7fffe001>
    80004c1c:	00e7f7b3          	and	a5,a5,a4
    80004c20:	00009717          	auipc	a4,0x9
    80004c24:	9ef73423          	sd	a5,-1560(a4) # 8000d608 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004c28:	01813083          	ld	ra,24(sp)
    80004c2c:	01013403          	ld	s0,16(sp)
    80004c30:	00813483          	ld	s1,8(sp)
    80004c34:	02010113          	addi	sp,sp,32
    80004c38:	00008067          	ret
        return -1;
    80004c3c:	0ff00513          	li	a0,255
    80004c40:	fe9ff06f          	j	80004c28 <_ZN11ConsoleUtil9getOutputEv+0x5c>

0000000080004c44 <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    80004c44:	fe010113          	addi	sp,sp,-32
    80004c48:	00113c23          	sd	ra,24(sp)
    80004c4c:	00813823          	sd	s0,16(sp)
    80004c50:	00913423          	sd	s1,8(sp)
    80004c54:	02010413          	addi	s0,sp,32
    80004c58:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004c5c:	0004c503          	lbu	a0,0(s1)
    80004c60:	00050a63          	beqz	a0,80004c74 <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004c64:	00000097          	auipc	ra,0x0
    80004c68:	ee8080e7          	jalr	-280(ra) # 80004b4c <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004c6c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004c70:	fedff06f          	j	80004c5c <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004c74:	01813083          	ld	ra,24(sp)
    80004c78:	01013403          	ld	s0,16(sp)
    80004c7c:	00813483          	ld	s1,8(sp)
    80004c80:	02010113          	addi	sp,sp,32
    80004c84:	00008067          	ret

0000000080004c88 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004c88:	fb010113          	addi	sp,sp,-80
    80004c8c:	04113423          	sd	ra,72(sp)
    80004c90:	04813023          	sd	s0,64(sp)
    80004c94:	02913c23          	sd	s1,56(sp)
    80004c98:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004c9c:	00006797          	auipc	a5,0x6
    80004ca0:	85478793          	addi	a5,a5,-1964 # 8000a4f0 <CONSOLE_STATUS+0x4e0>
    80004ca4:	0007b703          	ld	a4,0(a5)
    80004ca8:	fce43423          	sd	a4,-56(s0)
    80004cac:	0087b703          	ld	a4,8(a5)
    80004cb0:	fce43823          	sd	a4,-48(s0)
    80004cb4:	0107c783          	lbu	a5,16(a5)
    80004cb8:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004cbc:	00060463          	beqz	a2,80004cc4 <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004cc0:	08054263          	bltz	a0,80004d44 <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004cc4:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004cc8:	00000813          	li	a6,0
    }

    i = 0;
    80004ccc:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004cd0:	0005871b          	sext.w	a4,a1
    80004cd4:	02b577bb          	remuw	a5,a0,a1
    80004cd8:	00048693          	mv	a3,s1
    80004cdc:	0014849b          	addiw	s1,s1,1
    80004ce0:	02079793          	slli	a5,a5,0x20
    80004ce4:	0207d793          	srli	a5,a5,0x20
    80004ce8:	fe040613          	addi	a2,s0,-32
    80004cec:	00f607b3          	add	a5,a2,a5
    80004cf0:	fe87c603          	lbu	a2,-24(a5)
    80004cf4:	fe040793          	addi	a5,s0,-32
    80004cf8:	00d787b3          	add	a5,a5,a3
    80004cfc:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004d00:	0005061b          	sext.w	a2,a0
    80004d04:	02b5553b          	divuw	a0,a0,a1
    80004d08:	fce674e3          	bgeu	a2,a4,80004cd0 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004d0c:	00080c63          	beqz	a6,80004d24 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004d10:	fe040793          	addi	a5,s0,-32
    80004d14:	009784b3          	add	s1,a5,s1
    80004d18:	02d00793          	li	a5,45
    80004d1c:	fcf48c23          	sb	a5,-40(s1)
    80004d20:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004d24:	fff4849b          	addiw	s1,s1,-1
    80004d28:	0204c463          	bltz	s1,80004d50 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004d2c:	fe040793          	addi	a5,s0,-32
    80004d30:	009787b3          	add	a5,a5,s1
    80004d34:	fd87c503          	lbu	a0,-40(a5)
    80004d38:	00000097          	auipc	ra,0x0
    80004d3c:	e14080e7          	jalr	-492(ra) # 80004b4c <_ZN11ConsoleUtil9putOutputEc>
    80004d40:	fe5ff06f          	j	80004d24 <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004d44:	40a0053b          	negw	a0,a0
        neg = 1;
    80004d48:	00100813          	li	a6,1
        x = -xx;
    80004d4c:	f81ff06f          	j	80004ccc <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004d50:	04813083          	ld	ra,72(sp)
    80004d54:	04013403          	ld	s0,64(sp)
    80004d58:	03813483          	ld	s1,56(sp)
    80004d5c:	05010113          	addi	sp,sp,80
    80004d60:	00008067          	ret

0000000080004d64 <_ZN11ConsoleUtil5printEPKciS1_>:

void ConsoleUtil::print(const char *string, int xx, const char *sep) {
    80004d64:	fe010113          	addi	sp,sp,-32
    80004d68:	00113c23          	sd	ra,24(sp)
    80004d6c:	00813823          	sd	s0,16(sp)
    80004d70:	00913423          	sd	s1,8(sp)
    80004d74:	01213023          	sd	s2,0(sp)
    80004d78:	02010413          	addi	s0,sp,32
    80004d7c:	00058913          	mv	s2,a1
    80004d80:	00060493          	mv	s1,a2
    ConsoleUtil::printString(string);
    80004d84:	00000097          	auipc	ra,0x0
    80004d88:	ec0080e7          	jalr	-320(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx);
    80004d8c:	00000613          	li	a2,0
    80004d90:	00a00593          	li	a1,10
    80004d94:	00090513          	mv	a0,s2
    80004d98:	00000097          	auipc	ra,0x0
    80004d9c:	ef0080e7          	jalr	-272(ra) # 80004c88 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004da0:	00048513          	mv	a0,s1
    80004da4:	00000097          	auipc	ra,0x0
    80004da8:	ea0080e7          	jalr	-352(ra) # 80004c44 <_ZN11ConsoleUtil11printStringEPKc>
}
    80004dac:	01813083          	ld	ra,24(sp)
    80004db0:	01013403          	ld	s0,16(sp)
    80004db4:	00813483          	ld	s1,8(sp)
    80004db8:	00013903          	ld	s2,0(sp)
    80004dbc:	02010113          	addi	sp,sp,32
    80004dc0:	00008067          	ret

0000000080004dc4 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004dc4:	ff010113          	addi	sp,sp,-16
    80004dc8:	00813423          	sd	s0,8(sp)
    80004dcc:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004dd0:	04300513          	li	a0,67

    asm("ecall");
    80004dd4:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004dd8:	00050513          	mv	a0,a0

    return (char)status;
}
    80004ddc:	0ff57513          	andi	a0,a0,255
    80004de0:	00813403          	ld	s0,8(sp)
    80004de4:	01010113          	addi	sp,sp,16
    80004de8:	00008067          	ret

0000000080004dec <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004dec:	ff010113          	addi	sp,sp,-16
    80004df0:	00113423          	sd	ra,8(sp)
    80004df4:	00813023          	sd	s0,0(sp)
    80004df8:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004dfc:	ffffd097          	auipc	ra,0xffffd
    80004e00:	ae4080e7          	jalr	-1308(ra) # 800018e0 <_ZN13SlabAllocator10initializeEPvm>
}
    80004e04:	00813083          	ld	ra,8(sp)
    80004e08:	00013403          	ld	s0,0(sp)
    80004e0c:	01010113          	addi	sp,sp,16
    80004e10:	00008067          	ret

0000000080004e14 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004e14:	ff010113          	addi	sp,sp,-16
    80004e18:	00113423          	sd	ra,8(sp)
    80004e1c:	00813023          	sd	s0,0(sp)
    80004e20:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004e24:	ffffd097          	auipc	ra,0xffffd
    80004e28:	a1c080e7          	jalr	-1508(ra) # 80001840 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004e2c:	00813083          	ld	ra,8(sp)
    80004e30:	00013403          	ld	s0,0(sp)
    80004e34:	01010113          	addi	sp,sp,16
    80004e38:	00008067          	ret

0000000080004e3c <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004e3c:	ff010113          	addi	sp,sp,-16
    80004e40:	00113423          	sd	ra,8(sp)
    80004e44:	00813023          	sd	s0,0(sp)
    80004e48:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004e4c:	ffffd097          	auipc	ra,0xffffd
    80004e50:	8b4080e7          	jalr	-1868(ra) # 80001700 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004e54:	00813083          	ld	ra,8(sp)
    80004e58:	00013403          	ld	s0,0(sp)
    80004e5c:	01010113          	addi	sp,sp,16
    80004e60:	00008067          	ret

0000000080004e64 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004e64:	ff010113          	addi	sp,sp,-16
    80004e68:	00113423          	sd	ra,8(sp)
    80004e6c:	00813023          	sd	s0,0(sp)
    80004e70:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80004e74:	ffffd097          	auipc	ra,0xffffd
    80004e78:	c28080e7          	jalr	-984(ra) # 80001a9c <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80004e7c:	00813083          	ld	ra,8(sp)
    80004e80:	00013403          	ld	s0,0(sp)
    80004e84:	01010113          	addi	sp,sp,16
    80004e88:	00008067          	ret

0000000080004e8c <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80004e8c:	fe010113          	addi	sp,sp,-32
    80004e90:	00113c23          	sd	ra,24(sp)
    80004e94:	00813823          	sd	s0,16(sp)
    80004e98:	02010413          	addi	s0,sp,32
    80004e9c:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80004ea0:	fe840513          	addi	a0,s0,-24
    80004ea4:	ffffd097          	auipc	ra,0xffffd
    80004ea8:	d50080e7          	jalr	-688(ra) # 80001bf4 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80004eac:	01813083          	ld	ra,24(sp)
    80004eb0:	01013403          	ld	s0,16(sp)
    80004eb4:	02010113          	addi	sp,sp,32
    80004eb8:	00008067          	ret

0000000080004ebc <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80004ebc:	ff010113          	addi	sp,sp,-16
    80004ec0:	00113423          	sd	ra,8(sp)
    80004ec4:	00813023          	sd	s0,0(sp)
    80004ec8:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80004ecc:	ffffc097          	auipc	ra,0xffffc
    80004ed0:	408080e7          	jalr	1032(ra) # 800012d4 <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004ed4:	00813083          	ld	ra,8(sp)
    80004ed8:	00013403          	ld	s0,0(sp)
    80004edc:	01010113          	addi	sp,sp,16
    80004ee0:	00008067          	ret

0000000080004ee4 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004ee4:	ff010113          	addi	sp,sp,-16
    80004ee8:	00113423          	sd	ra,8(sp)
    80004eec:	00813023          	sd	s0,0(sp)
    80004ef0:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004ef4:	ffffc097          	auipc	ra,0xffffc
    80004ef8:	260080e7          	jalr	608(ra) # 80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004efc:	00813083          	ld	ra,8(sp)
    80004f00:	00013403          	ld	s0,0(sp)
    80004f04:	01010113          	addi	sp,sp,16
    80004f08:	00008067          	ret

0000000080004f0c <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004f0c:	ff010113          	addi	sp,sp,-16
    80004f10:	00113423          	sd	ra,8(sp)
    80004f14:	00813023          	sd	s0,0(sp)
    80004f18:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004f1c:	ffffd097          	auipc	ra,0xffffd
    80004f20:	880080e7          	jalr	-1920(ra) # 8000179c <_ZN13SlabAllocator14allocateBufferEm>
}
    80004f24:	00813083          	ld	ra,8(sp)
    80004f28:	00013403          	ld	s0,0(sp)
    80004f2c:	01010113          	addi	sp,sp,16
    80004f30:	00008067          	ret

0000000080004f34 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004f34:	ff010113          	addi	sp,sp,-16
    80004f38:	00113423          	sd	ra,8(sp)
    80004f3c:	00813023          	sd	s0,0(sp)
    80004f40:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80004f44:	ffffd097          	auipc	ra,0xffffd
    80004f48:	c44080e7          	jalr	-956(ra) # 80001b88 <_ZN13SlabAllocator10freeBufferEPKv>
    80004f4c:	00813083          	ld	ra,8(sp)
    80004f50:	00013403          	ld	s0,0(sp)
    80004f54:	01010113          	addi	sp,sp,16
    80004f58:	00008067          	ret

0000000080004f5c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004f5c:	fd010113          	addi	sp,sp,-48
    80004f60:	02113423          	sd	ra,40(sp)
    80004f64:	02813023          	sd	s0,32(sp)
    80004f68:	00913c23          	sd	s1,24(sp)
    80004f6c:	01213823          	sd	s2,16(sp)
    80004f70:	01313423          	sd	s3,8(sp)
    80004f74:	03010413          	addi	s0,sp,48
    80004f78:	00050493          	mv	s1,a0
    80004f7c:	00058913          	mv	s2,a1
    80004f80:	0015879b          	addiw	a5,a1,1
    80004f84:	0007851b          	sext.w	a0,a5
    80004f88:	00f4a023          	sw	a5,0(s1)
    80004f8c:	0004a823          	sw	zero,16(s1)
    80004f90:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004f94:	00251513          	slli	a0,a0,0x2
    80004f98:	ffffd097          	auipc	ra,0xffffd
    80004f9c:	d38080e7          	jalr	-712(ra) # 80001cd0 <_Z9mem_allocm>
    80004fa0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004fa4:	01000513          	li	a0,16
    80004fa8:	ffffe097          	auipc	ra,0xffffe
    80004fac:	450080e7          	jalr	1104(ra) # 800033f8 <_Znwm>
    80004fb0:	00050993          	mv	s3,a0
    80004fb4:	00000593          	li	a1,0
    80004fb8:	ffffe097          	auipc	ra,0xffffe
    80004fbc:	538080e7          	jalr	1336(ra) # 800034f0 <_ZN9SemaphoreC1Ej>
    80004fc0:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004fc4:	01000513          	li	a0,16
    80004fc8:	ffffe097          	auipc	ra,0xffffe
    80004fcc:	430080e7          	jalr	1072(ra) # 800033f8 <_Znwm>
    80004fd0:	00050993          	mv	s3,a0
    80004fd4:	00090593          	mv	a1,s2
    80004fd8:	ffffe097          	auipc	ra,0xffffe
    80004fdc:	518080e7          	jalr	1304(ra) # 800034f0 <_ZN9SemaphoreC1Ej>
    80004fe0:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004fe4:	01000513          	li	a0,16
    80004fe8:	ffffe097          	auipc	ra,0xffffe
    80004fec:	410080e7          	jalr	1040(ra) # 800033f8 <_Znwm>
    80004ff0:	00050913          	mv	s2,a0
    80004ff4:	00100593          	li	a1,1
    80004ff8:	ffffe097          	auipc	ra,0xffffe
    80004ffc:	4f8080e7          	jalr	1272(ra) # 800034f0 <_ZN9SemaphoreC1Ej>
    80005000:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005004:	01000513          	li	a0,16
    80005008:	ffffe097          	auipc	ra,0xffffe
    8000500c:	3f0080e7          	jalr	1008(ra) # 800033f8 <_Znwm>
    80005010:	00050913          	mv	s2,a0
    80005014:	00100593          	li	a1,1
    80005018:	ffffe097          	auipc	ra,0xffffe
    8000501c:	4d8080e7          	jalr	1240(ra) # 800034f0 <_ZN9SemaphoreC1Ej>
    80005020:	0324b823          	sd	s2,48(s1)
}
    80005024:	02813083          	ld	ra,40(sp)
    80005028:	02013403          	ld	s0,32(sp)
    8000502c:	01813483          	ld	s1,24(sp)
    80005030:	01013903          	ld	s2,16(sp)
    80005034:	00813983          	ld	s3,8(sp)
    80005038:	03010113          	addi	sp,sp,48
    8000503c:	00008067          	ret
    80005040:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005044:	00098513          	mv	a0,s3
    80005048:	ffffe097          	auipc	ra,0xffffe
    8000504c:	400080e7          	jalr	1024(ra) # 80003448 <_ZdlPv>
    80005050:	00048513          	mv	a0,s1
    80005054:	0000d097          	auipc	ra,0xd
    80005058:	6b4080e7          	jalr	1716(ra) # 80012708 <_Unwind_Resume>
    8000505c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005060:	00098513          	mv	a0,s3
    80005064:	ffffe097          	auipc	ra,0xffffe
    80005068:	3e4080e7          	jalr	996(ra) # 80003448 <_ZdlPv>
    8000506c:	00048513          	mv	a0,s1
    80005070:	0000d097          	auipc	ra,0xd
    80005074:	698080e7          	jalr	1688(ra) # 80012708 <_Unwind_Resume>
    80005078:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000507c:	00090513          	mv	a0,s2
    80005080:	ffffe097          	auipc	ra,0xffffe
    80005084:	3c8080e7          	jalr	968(ra) # 80003448 <_ZdlPv>
    80005088:	00048513          	mv	a0,s1
    8000508c:	0000d097          	auipc	ra,0xd
    80005090:	67c080e7          	jalr	1660(ra) # 80012708 <_Unwind_Resume>
    80005094:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005098:	00090513          	mv	a0,s2
    8000509c:	ffffe097          	auipc	ra,0xffffe
    800050a0:	3ac080e7          	jalr	940(ra) # 80003448 <_ZdlPv>
    800050a4:	00048513          	mv	a0,s1
    800050a8:	0000d097          	auipc	ra,0xd
    800050ac:	660080e7          	jalr	1632(ra) # 80012708 <_Unwind_Resume>

00000000800050b0 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800050b0:	fe010113          	addi	sp,sp,-32
    800050b4:	00113c23          	sd	ra,24(sp)
    800050b8:	00813823          	sd	s0,16(sp)
    800050bc:	00913423          	sd	s1,8(sp)
    800050c0:	01213023          	sd	s2,0(sp)
    800050c4:	02010413          	addi	s0,sp,32
    800050c8:	00050493          	mv	s1,a0
    800050cc:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800050d0:	01853503          	ld	a0,24(a0)
    800050d4:	ffffe097          	auipc	ra,0xffffe
    800050d8:	454080e7          	jalr	1108(ra) # 80003528 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800050dc:	0304b503          	ld	a0,48(s1)
    800050e0:	ffffe097          	auipc	ra,0xffffe
    800050e4:	448080e7          	jalr	1096(ra) # 80003528 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800050e8:	0084b783          	ld	a5,8(s1)
    800050ec:	0144a703          	lw	a4,20(s1)
    800050f0:	00271713          	slli	a4,a4,0x2
    800050f4:	00e787b3          	add	a5,a5,a4
    800050f8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800050fc:	0144a783          	lw	a5,20(s1)
    80005100:	0017879b          	addiw	a5,a5,1
    80005104:	0004a703          	lw	a4,0(s1)
    80005108:	02e7e7bb          	remw	a5,a5,a4
    8000510c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005110:	0304b503          	ld	a0,48(s1)
    80005114:	ffffe097          	auipc	ra,0xffffe
    80005118:	440080e7          	jalr	1088(ra) # 80003554 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000511c:	0204b503          	ld	a0,32(s1)
    80005120:	ffffe097          	auipc	ra,0xffffe
    80005124:	434080e7          	jalr	1076(ra) # 80003554 <_ZN9Semaphore6signalEv>

}
    80005128:	01813083          	ld	ra,24(sp)
    8000512c:	01013403          	ld	s0,16(sp)
    80005130:	00813483          	ld	s1,8(sp)
    80005134:	00013903          	ld	s2,0(sp)
    80005138:	02010113          	addi	sp,sp,32
    8000513c:	00008067          	ret

0000000080005140 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005140:	fe010113          	addi	sp,sp,-32
    80005144:	00113c23          	sd	ra,24(sp)
    80005148:	00813823          	sd	s0,16(sp)
    8000514c:	00913423          	sd	s1,8(sp)
    80005150:	01213023          	sd	s2,0(sp)
    80005154:	02010413          	addi	s0,sp,32
    80005158:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000515c:	02053503          	ld	a0,32(a0)
    80005160:	ffffe097          	auipc	ra,0xffffe
    80005164:	3c8080e7          	jalr	968(ra) # 80003528 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005168:	0284b503          	ld	a0,40(s1)
    8000516c:	ffffe097          	auipc	ra,0xffffe
    80005170:	3bc080e7          	jalr	956(ra) # 80003528 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80005174:	0084b703          	ld	a4,8(s1)
    80005178:	0104a783          	lw	a5,16(s1)
    8000517c:	00279693          	slli	a3,a5,0x2
    80005180:	00d70733          	add	a4,a4,a3
    80005184:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005188:	0017879b          	addiw	a5,a5,1
    8000518c:	0004a703          	lw	a4,0(s1)
    80005190:	02e7e7bb          	remw	a5,a5,a4
    80005194:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005198:	0284b503          	ld	a0,40(s1)
    8000519c:	ffffe097          	auipc	ra,0xffffe
    800051a0:	3b8080e7          	jalr	952(ra) # 80003554 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800051a4:	0184b503          	ld	a0,24(s1)
    800051a8:	ffffe097          	auipc	ra,0xffffe
    800051ac:	3ac080e7          	jalr	940(ra) # 80003554 <_ZN9Semaphore6signalEv>

    return ret;
}
    800051b0:	00090513          	mv	a0,s2
    800051b4:	01813083          	ld	ra,24(sp)
    800051b8:	01013403          	ld	s0,16(sp)
    800051bc:	00813483          	ld	s1,8(sp)
    800051c0:	00013903          	ld	s2,0(sp)
    800051c4:	02010113          	addi	sp,sp,32
    800051c8:	00008067          	ret

00000000800051cc <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800051cc:	fe010113          	addi	sp,sp,-32
    800051d0:	00113c23          	sd	ra,24(sp)
    800051d4:	00813823          	sd	s0,16(sp)
    800051d8:	00913423          	sd	s1,8(sp)
    800051dc:	01213023          	sd	s2,0(sp)
    800051e0:	02010413          	addi	s0,sp,32
    800051e4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800051e8:	02853503          	ld	a0,40(a0)
    800051ec:	ffffe097          	auipc	ra,0xffffe
    800051f0:	33c080e7          	jalr	828(ra) # 80003528 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800051f4:	0304b503          	ld	a0,48(s1)
    800051f8:	ffffe097          	auipc	ra,0xffffe
    800051fc:	330080e7          	jalr	816(ra) # 80003528 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005200:	0144a783          	lw	a5,20(s1)
    80005204:	0104a903          	lw	s2,16(s1)
    80005208:	0327ce63          	blt	a5,s2,80005244 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000520c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005210:	0304b503          	ld	a0,48(s1)
    80005214:	ffffe097          	auipc	ra,0xffffe
    80005218:	340080e7          	jalr	832(ra) # 80003554 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000521c:	0284b503          	ld	a0,40(s1)
    80005220:	ffffe097          	auipc	ra,0xffffe
    80005224:	334080e7          	jalr	820(ra) # 80003554 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005228:	00090513          	mv	a0,s2
    8000522c:	01813083          	ld	ra,24(sp)
    80005230:	01013403          	ld	s0,16(sp)
    80005234:	00813483          	ld	s1,8(sp)
    80005238:	00013903          	ld	s2,0(sp)
    8000523c:	02010113          	addi	sp,sp,32
    80005240:	00008067          	ret
        ret = cap - head + tail;
    80005244:	0004a703          	lw	a4,0(s1)
    80005248:	4127093b          	subw	s2,a4,s2
    8000524c:	00f9093b          	addw	s2,s2,a5
    80005250:	fc1ff06f          	j	80005210 <_ZN9BufferCPP6getCntEv+0x44>

0000000080005254 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005254:	fe010113          	addi	sp,sp,-32
    80005258:	00113c23          	sd	ra,24(sp)
    8000525c:	00813823          	sd	s0,16(sp)
    80005260:	00913423          	sd	s1,8(sp)
    80005264:	02010413          	addi	s0,sp,32
    80005268:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000526c:	00a00513          	li	a0,10
    80005270:	ffffe097          	auipc	ra,0xffffe
    80005274:	4e0080e7          	jalr	1248(ra) # 80003750 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005278:	00005517          	auipc	a0,0x5
    8000527c:	29050513          	addi	a0,a0,656 # 8000a508 <CONSOLE_STATUS+0x4f8>
    80005280:	ffffd097          	auipc	ra,0xffffd
    80005284:	44c080e7          	jalr	1100(ra) # 800026cc <_Z11printStringPKc>
    while (getCnt()) {
    80005288:	00048513          	mv	a0,s1
    8000528c:	00000097          	auipc	ra,0x0
    80005290:	f40080e7          	jalr	-192(ra) # 800051cc <_ZN9BufferCPP6getCntEv>
    80005294:	02050c63          	beqz	a0,800052cc <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005298:	0084b783          	ld	a5,8(s1)
    8000529c:	0104a703          	lw	a4,16(s1)
    800052a0:	00271713          	slli	a4,a4,0x2
    800052a4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800052a8:	0007c503          	lbu	a0,0(a5)
    800052ac:	ffffe097          	auipc	ra,0xffffe
    800052b0:	4a4080e7          	jalr	1188(ra) # 80003750 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800052b4:	0104a783          	lw	a5,16(s1)
    800052b8:	0017879b          	addiw	a5,a5,1
    800052bc:	0004a703          	lw	a4,0(s1)
    800052c0:	02e7e7bb          	remw	a5,a5,a4
    800052c4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800052c8:	fc1ff06f          	j	80005288 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800052cc:	02100513          	li	a0,33
    800052d0:	ffffe097          	auipc	ra,0xffffe
    800052d4:	480080e7          	jalr	1152(ra) # 80003750 <_ZN7Console4putcEc>
    Console::putc('\n');
    800052d8:	00a00513          	li	a0,10
    800052dc:	ffffe097          	auipc	ra,0xffffe
    800052e0:	474080e7          	jalr	1140(ra) # 80003750 <_ZN7Console4putcEc>
    mem_free(buffer);
    800052e4:	0084b503          	ld	a0,8(s1)
    800052e8:	ffffd097          	auipc	ra,0xffffd
    800052ec:	a18080e7          	jalr	-1512(ra) # 80001d00 <_Z8mem_freePv>
    delete itemAvailable;
    800052f0:	0204b503          	ld	a0,32(s1)
    800052f4:	00050863          	beqz	a0,80005304 <_ZN9BufferCPPD1Ev+0xb0>
    800052f8:	00053783          	ld	a5,0(a0)
    800052fc:	0087b783          	ld	a5,8(a5)
    80005300:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005304:	0184b503          	ld	a0,24(s1)
    80005308:	00050863          	beqz	a0,80005318 <_ZN9BufferCPPD1Ev+0xc4>
    8000530c:	00053783          	ld	a5,0(a0)
    80005310:	0087b783          	ld	a5,8(a5)
    80005314:	000780e7          	jalr	a5
    delete mutexTail;
    80005318:	0304b503          	ld	a0,48(s1)
    8000531c:	00050863          	beqz	a0,8000532c <_ZN9BufferCPPD1Ev+0xd8>
    80005320:	00053783          	ld	a5,0(a0)
    80005324:	0087b783          	ld	a5,8(a5)
    80005328:	000780e7          	jalr	a5
    delete mutexHead;
    8000532c:	0284b503          	ld	a0,40(s1)
    80005330:	00050863          	beqz	a0,80005340 <_ZN9BufferCPPD1Ev+0xec>
    80005334:	00053783          	ld	a5,0(a0)
    80005338:	0087b783          	ld	a5,8(a5)
    8000533c:	000780e7          	jalr	a5
}
    80005340:	01813083          	ld	ra,24(sp)
    80005344:	01013403          	ld	s0,16(sp)
    80005348:	00813483          	ld	s1,8(sp)
    8000534c:	02010113          	addi	sp,sp,32
    80005350:	00008067          	ret

0000000080005354 <_Z9sleepyRunPv>:

#include "../h/printing.hpp"

bool finished[2];

void sleepyRun(void *arg) {
    80005354:	fe010113          	addi	sp,sp,-32
    80005358:	00113c23          	sd	ra,24(sp)
    8000535c:	00813823          	sd	s0,16(sp)
    80005360:	00913423          	sd	s1,8(sp)
    80005364:	01213023          	sd	s2,0(sp)
    80005368:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    8000536c:	00053903          	ld	s2,0(a0)
    int i = 6;
    80005370:	00600493          	li	s1,6
    while (--i > 0) {
    80005374:	fff4849b          	addiw	s1,s1,-1
    80005378:	04905463          	blez	s1,800053c0 <_Z9sleepyRunPv+0x6c>

        printString("Hello ");
    8000537c:	00005517          	auipc	a0,0x5
    80005380:	1a450513          	addi	a0,a0,420 # 8000a520 <CONSOLE_STATUS+0x510>
    80005384:	ffffd097          	auipc	ra,0xffffd
    80005388:	348080e7          	jalr	840(ra) # 800026cc <_Z11printStringPKc>
        printInt(sleep_time);
    8000538c:	00000613          	li	a2,0
    80005390:	00a00593          	li	a1,10
    80005394:	0009051b          	sext.w	a0,s2
    80005398:	ffffd097          	auipc	ra,0xffffd
    8000539c:	4cc080e7          	jalr	1228(ra) # 80002864 <_Z8printIntiii>
        printString(" !\n");
    800053a0:	00005517          	auipc	a0,0x5
    800053a4:	18850513          	addi	a0,a0,392 # 8000a528 <CONSOLE_STATUS+0x518>
    800053a8:	ffffd097          	auipc	ra,0xffffd
    800053ac:	324080e7          	jalr	804(ra) # 800026cc <_Z11printStringPKc>
        time_sleep(sleep_time);
    800053b0:	00090513          	mv	a0,s2
    800053b4:	ffffd097          	auipc	ra,0xffffd
    800053b8:	ba0080e7          	jalr	-1120(ra) # 80001f54 <_Z10time_sleepm>
    while (--i > 0) {
    800053bc:	fb9ff06f          	j	80005374 <_Z9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    800053c0:	00a00793          	li	a5,10
    800053c4:	02f95933          	divu	s2,s2,a5
    800053c8:	fff90913          	addi	s2,s2,-1
    800053cc:	0000c797          	auipc	a5,0xc
    800053d0:	24c78793          	addi	a5,a5,588 # 80011618 <_ZN19ConsumerProducerCPP9threadEndE>
    800053d4:	01278933          	add	s2,a5,s2
    800053d8:	00100793          	li	a5,1
    800053dc:	00f90423          	sb	a5,8(s2)
}
    800053e0:	01813083          	ld	ra,24(sp)
    800053e4:	01013403          	ld	s0,16(sp)
    800053e8:	00813483          	ld	s1,8(sp)
    800053ec:	00013903          	ld	s2,0(sp)
    800053f0:	02010113          	addi	sp,sp,32
    800053f4:	00008067          	ret

00000000800053f8 <_Z9fibonaccim>:
bool finishedA = false;
bool finishedB = false;
bool finishedC = false;
bool finishedD = false;

uint64 fibonacci(uint64 n) {
    800053f8:	fe010113          	addi	sp,sp,-32
    800053fc:	00113c23          	sd	ra,24(sp)
    80005400:	00813823          	sd	s0,16(sp)
    80005404:	00913423          	sd	s1,8(sp)
    80005408:	01213023          	sd	s2,0(sp)
    8000540c:	02010413          	addi	s0,sp,32
    80005410:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80005414:	00100793          	li	a5,1
    80005418:	02a7f863          	bgeu	a5,a0,80005448 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000541c:	00a00793          	li	a5,10
    80005420:	02f577b3          	remu	a5,a0,a5
    80005424:	02078e63          	beqz	a5,80005460 <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005428:	fff48513          	addi	a0,s1,-1
    8000542c:	00000097          	auipc	ra,0x0
    80005430:	fcc080e7          	jalr	-52(ra) # 800053f8 <_Z9fibonaccim>
    80005434:	00050913          	mv	s2,a0
    80005438:	ffe48513          	addi	a0,s1,-2
    8000543c:	00000097          	auipc	ra,0x0
    80005440:	fbc080e7          	jalr	-68(ra) # 800053f8 <_Z9fibonaccim>
    80005444:	00a90533          	add	a0,s2,a0
}
    80005448:	01813083          	ld	ra,24(sp)
    8000544c:	01013403          	ld	s0,16(sp)
    80005450:	00813483          	ld	s1,8(sp)
    80005454:	00013903          	ld	s2,0(sp)
    80005458:	02010113          	addi	sp,sp,32
    8000545c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005460:	ffffd097          	auipc	ra,0xffffd
    80005464:	970080e7          	jalr	-1680(ra) # 80001dd0 <_Z15thread_dispatchv>
    80005468:	fc1ff06f          	j	80005428 <_Z9fibonaccim+0x30>

000000008000546c <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    8000546c:	fe010113          	addi	sp,sp,-32
    80005470:	00113c23          	sd	ra,24(sp)
    80005474:	00813823          	sd	s0,16(sp)
    80005478:	00913423          	sd	s1,8(sp)
    8000547c:	01213023          	sd	s2,0(sp)
    80005480:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005484:	00000913          	li	s2,0
    80005488:	0380006f          	j	800054c0 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000548c:	ffffd097          	auipc	ra,0xffffd
    80005490:	944080e7          	jalr	-1724(ra) # 80001dd0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005494:	00148493          	addi	s1,s1,1
    80005498:	000027b7          	lui	a5,0x2
    8000549c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800054a0:	0097ee63          	bltu	a5,s1,800054bc <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800054a4:	00000713          	li	a4,0
    800054a8:	000077b7          	lui	a5,0x7
    800054ac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800054b0:	fce7eee3          	bltu	a5,a4,8000548c <_ZN7WorkerA11workerBodyAEPv+0x20>
    800054b4:	00170713          	addi	a4,a4,1
    800054b8:	ff1ff06f          	j	800054a8 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800054bc:	00190913          	addi	s2,s2,1
    800054c0:	00900793          	li	a5,9
    800054c4:	0527e063          	bltu	a5,s2,80005504 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800054c8:	00005517          	auipc	a0,0x5
    800054cc:	06850513          	addi	a0,a0,104 # 8000a530 <CONSOLE_STATUS+0x520>
    800054d0:	ffffd097          	auipc	ra,0xffffd
    800054d4:	1fc080e7          	jalr	508(ra) # 800026cc <_Z11printStringPKc>
    800054d8:	00000613          	li	a2,0
    800054dc:	00a00593          	li	a1,10
    800054e0:	0009051b          	sext.w	a0,s2
    800054e4:	ffffd097          	auipc	ra,0xffffd
    800054e8:	380080e7          	jalr	896(ra) # 80002864 <_Z8printIntiii>
    800054ec:	00005517          	auipc	a0,0x5
    800054f0:	e0c50513          	addi	a0,a0,-500 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800054f4:	ffffd097          	auipc	ra,0xffffd
    800054f8:	1d8080e7          	jalr	472(ra) # 800026cc <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800054fc:	00000493          	li	s1,0
    80005500:	f99ff06f          	j	80005498 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80005504:	00005517          	auipc	a0,0x5
    80005508:	03450513          	addi	a0,a0,52 # 8000a538 <CONSOLE_STATUS+0x528>
    8000550c:	ffffd097          	auipc	ra,0xffffd
    80005510:	1c0080e7          	jalr	448(ra) # 800026cc <_Z11printStringPKc>
    finishedA = true;
    80005514:	00100793          	li	a5,1
    80005518:	0000c717          	auipc	a4,0xc
    8000551c:	10f70523          	sb	a5,266(a4) # 80011622 <finishedA>
}
    80005520:	01813083          	ld	ra,24(sp)
    80005524:	01013403          	ld	s0,16(sp)
    80005528:	00813483          	ld	s1,8(sp)
    8000552c:	00013903          	ld	s2,0(sp)
    80005530:	02010113          	addi	sp,sp,32
    80005534:	00008067          	ret

0000000080005538 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80005538:	fe010113          	addi	sp,sp,-32
    8000553c:	00113c23          	sd	ra,24(sp)
    80005540:	00813823          	sd	s0,16(sp)
    80005544:	00913423          	sd	s1,8(sp)
    80005548:	01213023          	sd	s2,0(sp)
    8000554c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005550:	00000913          	li	s2,0
    80005554:	0380006f          	j	8000558c <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80005558:	ffffd097          	auipc	ra,0xffffd
    8000555c:	878080e7          	jalr	-1928(ra) # 80001dd0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005560:	00148493          	addi	s1,s1,1
    80005564:	000027b7          	lui	a5,0x2
    80005568:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000556c:	0097ee63          	bltu	a5,s1,80005588 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005570:	00000713          	li	a4,0
    80005574:	000077b7          	lui	a5,0x7
    80005578:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000557c:	fce7eee3          	bltu	a5,a4,80005558 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80005580:	00170713          	addi	a4,a4,1
    80005584:	ff1ff06f          	j	80005574 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80005588:	00190913          	addi	s2,s2,1
    8000558c:	00f00793          	li	a5,15
    80005590:	0527e063          	bltu	a5,s2,800055d0 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80005594:	00005517          	auipc	a0,0x5
    80005598:	fb450513          	addi	a0,a0,-76 # 8000a548 <CONSOLE_STATUS+0x538>
    8000559c:	ffffd097          	auipc	ra,0xffffd
    800055a0:	130080e7          	jalr	304(ra) # 800026cc <_Z11printStringPKc>
    800055a4:	00000613          	li	a2,0
    800055a8:	00a00593          	li	a1,10
    800055ac:	0009051b          	sext.w	a0,s2
    800055b0:	ffffd097          	auipc	ra,0xffffd
    800055b4:	2b4080e7          	jalr	692(ra) # 80002864 <_Z8printIntiii>
    800055b8:	00005517          	auipc	a0,0x5
    800055bc:	d4050513          	addi	a0,a0,-704 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800055c0:	ffffd097          	auipc	ra,0xffffd
    800055c4:	10c080e7          	jalr	268(ra) # 800026cc <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800055c8:	00000493          	li	s1,0
    800055cc:	f99ff06f          	j	80005564 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    800055d0:	00005517          	auipc	a0,0x5
    800055d4:	f8050513          	addi	a0,a0,-128 # 8000a550 <CONSOLE_STATUS+0x540>
    800055d8:	ffffd097          	auipc	ra,0xffffd
    800055dc:	0f4080e7          	jalr	244(ra) # 800026cc <_Z11printStringPKc>
    finishedB = true;
    800055e0:	00100793          	li	a5,1
    800055e4:	0000c717          	auipc	a4,0xc
    800055e8:	02f70fa3          	sb	a5,63(a4) # 80011623 <finishedB>
    thread_dispatch();
    800055ec:	ffffc097          	auipc	ra,0xffffc
    800055f0:	7e4080e7          	jalr	2020(ra) # 80001dd0 <_Z15thread_dispatchv>
}
    800055f4:	01813083          	ld	ra,24(sp)
    800055f8:	01013403          	ld	s0,16(sp)
    800055fc:	00813483          	ld	s1,8(sp)
    80005600:	00013903          	ld	s2,0(sp)
    80005604:	02010113          	addi	sp,sp,32
    80005608:	00008067          	ret

000000008000560c <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    8000560c:	fe010113          	addi	sp,sp,-32
    80005610:	00113c23          	sd	ra,24(sp)
    80005614:	00813823          	sd	s0,16(sp)
    80005618:	00913423          	sd	s1,8(sp)
    8000561c:	01213023          	sd	s2,0(sp)
    80005620:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005624:	00000493          	li	s1,0
    80005628:	0400006f          	j	80005668 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000562c:	00005517          	auipc	a0,0x5
    80005630:	f3450513          	addi	a0,a0,-204 # 8000a560 <CONSOLE_STATUS+0x550>
    80005634:	ffffd097          	auipc	ra,0xffffd
    80005638:	098080e7          	jalr	152(ra) # 800026cc <_Z11printStringPKc>
    8000563c:	00000613          	li	a2,0
    80005640:	00a00593          	li	a1,10
    80005644:	00048513          	mv	a0,s1
    80005648:	ffffd097          	auipc	ra,0xffffd
    8000564c:	21c080e7          	jalr	540(ra) # 80002864 <_Z8printIntiii>
    80005650:	00005517          	auipc	a0,0x5
    80005654:	ca850513          	addi	a0,a0,-856 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80005658:	ffffd097          	auipc	ra,0xffffd
    8000565c:	074080e7          	jalr	116(ra) # 800026cc <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005660:	0014849b          	addiw	s1,s1,1
    80005664:	0ff4f493          	andi	s1,s1,255
    80005668:	00200793          	li	a5,2
    8000566c:	fc97f0e3          	bgeu	a5,s1,8000562c <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80005670:	00005517          	auipc	a0,0x5
    80005674:	ef850513          	addi	a0,a0,-264 # 8000a568 <CONSOLE_STATUS+0x558>
    80005678:	ffffd097          	auipc	ra,0xffffd
    8000567c:	054080e7          	jalr	84(ra) # 800026cc <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005680:	00700313          	li	t1,7
    thread_dispatch();
    80005684:	ffffc097          	auipc	ra,0xffffc
    80005688:	74c080e7          	jalr	1868(ra) # 80001dd0 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000568c:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80005690:	00005517          	auipc	a0,0x5
    80005694:	ee850513          	addi	a0,a0,-280 # 8000a578 <CONSOLE_STATUS+0x568>
    80005698:	ffffd097          	auipc	ra,0xffffd
    8000569c:	034080e7          	jalr	52(ra) # 800026cc <_Z11printStringPKc>
    800056a0:	00000613          	li	a2,0
    800056a4:	00a00593          	li	a1,10
    800056a8:	0009051b          	sext.w	a0,s2
    800056ac:	ffffd097          	auipc	ra,0xffffd
    800056b0:	1b8080e7          	jalr	440(ra) # 80002864 <_Z8printIntiii>
    800056b4:	00005517          	auipc	a0,0x5
    800056b8:	c4450513          	addi	a0,a0,-956 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800056bc:	ffffd097          	auipc	ra,0xffffd
    800056c0:	010080e7          	jalr	16(ra) # 800026cc <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800056c4:	00c00513          	li	a0,12
    800056c8:	00000097          	auipc	ra,0x0
    800056cc:	d30080e7          	jalr	-720(ra) # 800053f8 <_Z9fibonaccim>
    800056d0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800056d4:	00005517          	auipc	a0,0x5
    800056d8:	eac50513          	addi	a0,a0,-340 # 8000a580 <CONSOLE_STATUS+0x570>
    800056dc:	ffffd097          	auipc	ra,0xffffd
    800056e0:	ff0080e7          	jalr	-16(ra) # 800026cc <_Z11printStringPKc>
    800056e4:	00000613          	li	a2,0
    800056e8:	00a00593          	li	a1,10
    800056ec:	0009051b          	sext.w	a0,s2
    800056f0:	ffffd097          	auipc	ra,0xffffd
    800056f4:	174080e7          	jalr	372(ra) # 80002864 <_Z8printIntiii>
    800056f8:	00005517          	auipc	a0,0x5
    800056fc:	c0050513          	addi	a0,a0,-1024 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80005700:	ffffd097          	auipc	ra,0xffffd
    80005704:	fcc080e7          	jalr	-52(ra) # 800026cc <_Z11printStringPKc>
    80005708:	0400006f          	j	80005748 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000570c:	00005517          	auipc	a0,0x5
    80005710:	e5450513          	addi	a0,a0,-428 # 8000a560 <CONSOLE_STATUS+0x550>
    80005714:	ffffd097          	auipc	ra,0xffffd
    80005718:	fb8080e7          	jalr	-72(ra) # 800026cc <_Z11printStringPKc>
    8000571c:	00000613          	li	a2,0
    80005720:	00a00593          	li	a1,10
    80005724:	00048513          	mv	a0,s1
    80005728:	ffffd097          	auipc	ra,0xffffd
    8000572c:	13c080e7          	jalr	316(ra) # 80002864 <_Z8printIntiii>
    80005730:	00005517          	auipc	a0,0x5
    80005734:	bc850513          	addi	a0,a0,-1080 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80005738:	ffffd097          	auipc	ra,0xffffd
    8000573c:	f94080e7          	jalr	-108(ra) # 800026cc <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005740:	0014849b          	addiw	s1,s1,1
    80005744:	0ff4f493          	andi	s1,s1,255
    80005748:	00500793          	li	a5,5
    8000574c:	fc97f0e3          	bgeu	a5,s1,8000570c <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("C finished!\n");
    80005750:	00005517          	auipc	a0,0x5
    80005754:	e4050513          	addi	a0,a0,-448 # 8000a590 <CONSOLE_STATUS+0x580>
    80005758:	ffffd097          	auipc	ra,0xffffd
    8000575c:	f74080e7          	jalr	-140(ra) # 800026cc <_Z11printStringPKc>
    finishedC = true;
    80005760:	00100793          	li	a5,1
    80005764:	0000c717          	auipc	a4,0xc
    80005768:	ecf70023          	sb	a5,-320(a4) # 80011624 <finishedC>
    thread_dispatch();
    8000576c:	ffffc097          	auipc	ra,0xffffc
    80005770:	664080e7          	jalr	1636(ra) # 80001dd0 <_Z15thread_dispatchv>
}
    80005774:	01813083          	ld	ra,24(sp)
    80005778:	01013403          	ld	s0,16(sp)
    8000577c:	00813483          	ld	s1,8(sp)
    80005780:	00013903          	ld	s2,0(sp)
    80005784:	02010113          	addi	sp,sp,32
    80005788:	00008067          	ret

000000008000578c <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    8000578c:	fe010113          	addi	sp,sp,-32
    80005790:	00113c23          	sd	ra,24(sp)
    80005794:	00813823          	sd	s0,16(sp)
    80005798:	00913423          	sd	s1,8(sp)
    8000579c:	01213023          	sd	s2,0(sp)
    800057a0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800057a4:	00a00493          	li	s1,10
    800057a8:	0400006f          	j	800057e8 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800057ac:	00005517          	auipc	a0,0x5
    800057b0:	df450513          	addi	a0,a0,-524 # 8000a5a0 <CONSOLE_STATUS+0x590>
    800057b4:	ffffd097          	auipc	ra,0xffffd
    800057b8:	f18080e7          	jalr	-232(ra) # 800026cc <_Z11printStringPKc>
    800057bc:	00000613          	li	a2,0
    800057c0:	00a00593          	li	a1,10
    800057c4:	00048513          	mv	a0,s1
    800057c8:	ffffd097          	auipc	ra,0xffffd
    800057cc:	09c080e7          	jalr	156(ra) # 80002864 <_Z8printIntiii>
    800057d0:	00005517          	auipc	a0,0x5
    800057d4:	b2850513          	addi	a0,a0,-1240 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    800057d8:	ffffd097          	auipc	ra,0xffffd
    800057dc:	ef4080e7          	jalr	-268(ra) # 800026cc <_Z11printStringPKc>
    for (; i < 13; i++) {
    800057e0:	0014849b          	addiw	s1,s1,1
    800057e4:	0ff4f493          	andi	s1,s1,255
    800057e8:	00c00793          	li	a5,12
    800057ec:	fc97f0e3          	bgeu	a5,s1,800057ac <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800057f0:	00005517          	auipc	a0,0x5
    800057f4:	db850513          	addi	a0,a0,-584 # 8000a5a8 <CONSOLE_STATUS+0x598>
    800057f8:	ffffd097          	auipc	ra,0xffffd
    800057fc:	ed4080e7          	jalr	-300(ra) # 800026cc <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80005800:	00500313          	li	t1,5
    thread_dispatch();
    80005804:	ffffc097          	auipc	ra,0xffffc
    80005808:	5cc080e7          	jalr	1484(ra) # 80001dd0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000580c:	01000513          	li	a0,16
    80005810:	00000097          	auipc	ra,0x0
    80005814:	be8080e7          	jalr	-1048(ra) # 800053f8 <_Z9fibonaccim>
    80005818:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000581c:	00005517          	auipc	a0,0x5
    80005820:	d9c50513          	addi	a0,a0,-612 # 8000a5b8 <CONSOLE_STATUS+0x5a8>
    80005824:	ffffd097          	auipc	ra,0xffffd
    80005828:	ea8080e7          	jalr	-344(ra) # 800026cc <_Z11printStringPKc>
    8000582c:	00000613          	li	a2,0
    80005830:	00a00593          	li	a1,10
    80005834:	0009051b          	sext.w	a0,s2
    80005838:	ffffd097          	auipc	ra,0xffffd
    8000583c:	02c080e7          	jalr	44(ra) # 80002864 <_Z8printIntiii>
    80005840:	00005517          	auipc	a0,0x5
    80005844:	ab850513          	addi	a0,a0,-1352 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80005848:	ffffd097          	auipc	ra,0xffffd
    8000584c:	e84080e7          	jalr	-380(ra) # 800026cc <_Z11printStringPKc>
    80005850:	0400006f          	j	80005890 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005854:	00005517          	auipc	a0,0x5
    80005858:	d4c50513          	addi	a0,a0,-692 # 8000a5a0 <CONSOLE_STATUS+0x590>
    8000585c:	ffffd097          	auipc	ra,0xffffd
    80005860:	e70080e7          	jalr	-400(ra) # 800026cc <_Z11printStringPKc>
    80005864:	00000613          	li	a2,0
    80005868:	00a00593          	li	a1,10
    8000586c:	00048513          	mv	a0,s1
    80005870:	ffffd097          	auipc	ra,0xffffd
    80005874:	ff4080e7          	jalr	-12(ra) # 80002864 <_Z8printIntiii>
    80005878:	00005517          	auipc	a0,0x5
    8000587c:	a8050513          	addi	a0,a0,-1408 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80005880:	ffffd097          	auipc	ra,0xffffd
    80005884:	e4c080e7          	jalr	-436(ra) # 800026cc <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005888:	0014849b          	addiw	s1,s1,1
    8000588c:	0ff4f493          	andi	s1,s1,255
    80005890:	00f00793          	li	a5,15
    80005894:	fc97f0e3          	bgeu	a5,s1,80005854 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80005898:	00005517          	auipc	a0,0x5
    8000589c:	d3050513          	addi	a0,a0,-720 # 8000a5c8 <CONSOLE_STATUS+0x5b8>
    800058a0:	ffffd097          	auipc	ra,0xffffd
    800058a4:	e2c080e7          	jalr	-468(ra) # 800026cc <_Z11printStringPKc>
    finishedD = true;
    800058a8:	00100793          	li	a5,1
    800058ac:	0000c717          	auipc	a4,0xc
    800058b0:	d6f70ca3          	sb	a5,-647(a4) # 80011625 <finishedD>
    thread_dispatch();
    800058b4:	ffffc097          	auipc	ra,0xffffc
    800058b8:	51c080e7          	jalr	1308(ra) # 80001dd0 <_Z15thread_dispatchv>
}
    800058bc:	01813083          	ld	ra,24(sp)
    800058c0:	01013403          	ld	s0,16(sp)
    800058c4:	00813483          	ld	s1,8(sp)
    800058c8:	00013903          	ld	s2,0(sp)
    800058cc:	02010113          	addi	sp,sp,32
    800058d0:	00008067          	ret

00000000800058d4 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    800058d4:	fc010113          	addi	sp,sp,-64
    800058d8:	02113c23          	sd	ra,56(sp)
    800058dc:	02813823          	sd	s0,48(sp)
    800058e0:	02913423          	sd	s1,40(sp)
    800058e4:	03213023          	sd	s2,32(sp)
    800058e8:	04010413          	addi	s0,sp,64

    Thread* threads[4];

    threads[0] = new WorkerA();
    800058ec:	01000513          	li	a0,16
    800058f0:	ffffe097          	auipc	ra,0xffffe
    800058f4:	b08080e7          	jalr	-1272(ra) # 800033f8 <_Znwm>
    800058f8:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    800058fc:	ffffe097          	auipc	ra,0xffffe
    80005900:	cbc080e7          	jalr	-836(ra) # 800035b8 <_ZN6ThreadC1Ev>
    80005904:	00008797          	auipc	a5,0x8
    80005908:	87478793          	addi	a5,a5,-1932 # 8000d178 <_ZTV7WorkerA+0x10>
    8000590c:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80005910:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80005914:	00005517          	auipc	a0,0x5
    80005918:	cc450513          	addi	a0,a0,-828 # 8000a5d8 <CONSOLE_STATUS+0x5c8>
    8000591c:	ffffd097          	auipc	ra,0xffffd
    80005920:	db0080e7          	jalr	-592(ra) # 800026cc <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80005924:	01000513          	li	a0,16
    80005928:	ffffe097          	auipc	ra,0xffffe
    8000592c:	ad0080e7          	jalr	-1328(ra) # 800033f8 <_Znwm>
    80005930:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80005934:	ffffe097          	auipc	ra,0xffffe
    80005938:	c84080e7          	jalr	-892(ra) # 800035b8 <_ZN6ThreadC1Ev>
    8000593c:	00008797          	auipc	a5,0x8
    80005940:	86478793          	addi	a5,a5,-1948 # 8000d1a0 <_ZTV7WorkerB+0x10>
    80005944:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80005948:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    8000594c:	00005517          	auipc	a0,0x5
    80005950:	ca450513          	addi	a0,a0,-860 # 8000a5f0 <CONSOLE_STATUS+0x5e0>
    80005954:	ffffd097          	auipc	ra,0xffffd
    80005958:	d78080e7          	jalr	-648(ra) # 800026cc <_Z11printStringPKc>

    threads[2] = new WorkerC();
    8000595c:	01000513          	li	a0,16
    80005960:	ffffe097          	auipc	ra,0xffffe
    80005964:	a98080e7          	jalr	-1384(ra) # 800033f8 <_Znwm>
    80005968:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    8000596c:	ffffe097          	auipc	ra,0xffffe
    80005970:	c4c080e7          	jalr	-948(ra) # 800035b8 <_ZN6ThreadC1Ev>
    80005974:	00008797          	auipc	a5,0x8
    80005978:	85478793          	addi	a5,a5,-1964 # 8000d1c8 <_ZTV7WorkerC+0x10>
    8000597c:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80005980:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80005984:	00005517          	auipc	a0,0x5
    80005988:	c8450513          	addi	a0,a0,-892 # 8000a608 <CONSOLE_STATUS+0x5f8>
    8000598c:	ffffd097          	auipc	ra,0xffffd
    80005990:	d40080e7          	jalr	-704(ra) # 800026cc <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80005994:	01000513          	li	a0,16
    80005998:	ffffe097          	auipc	ra,0xffffe
    8000599c:	a60080e7          	jalr	-1440(ra) # 800033f8 <_Znwm>
    800059a0:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    800059a4:	ffffe097          	auipc	ra,0xffffe
    800059a8:	c14080e7          	jalr	-1004(ra) # 800035b8 <_ZN6ThreadC1Ev>
    800059ac:	00008797          	auipc	a5,0x8
    800059b0:	84478793          	addi	a5,a5,-1980 # 8000d1f0 <_ZTV7WorkerD+0x10>
    800059b4:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    800059b8:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    800059bc:	00005517          	auipc	a0,0x5
    800059c0:	c6450513          	addi	a0,a0,-924 # 8000a620 <CONSOLE_STATUS+0x610>
    800059c4:	ffffd097          	auipc	ra,0xffffd
    800059c8:	d08080e7          	jalr	-760(ra) # 800026cc <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    800059cc:	00000493          	li	s1,0
    800059d0:	00300793          	li	a5,3
    800059d4:	0297c663          	blt	a5,s1,80005a00 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    800059d8:	00349793          	slli	a5,s1,0x3
    800059dc:	fe040713          	addi	a4,s0,-32
    800059e0:	00f707b3          	add	a5,a4,a5
    800059e4:	fe07b503          	ld	a0,-32(a5)
    800059e8:	ffffe097          	auipc	ra,0xffffe
    800059ec:	ca4080e7          	jalr	-860(ra) # 8000368c <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    800059f0:	0014849b          	addiw	s1,s1,1
    800059f4:	fddff06f          	j	800059d0 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    800059f8:	ffffe097          	auipc	ra,0xffffe
    800059fc:	c6c080e7          	jalr	-916(ra) # 80003664 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005a00:	0000c797          	auipc	a5,0xc
    80005a04:	c227c783          	lbu	a5,-990(a5) # 80011622 <finishedA>
    80005a08:	fe0788e3          	beqz	a5,800059f8 <_Z20Threads_CPP_API_testv+0x124>
    80005a0c:	0000c797          	auipc	a5,0xc
    80005a10:	c177c783          	lbu	a5,-1001(a5) # 80011623 <finishedB>
    80005a14:	fe0782e3          	beqz	a5,800059f8 <_Z20Threads_CPP_API_testv+0x124>
    80005a18:	0000c797          	auipc	a5,0xc
    80005a1c:	c0c7c783          	lbu	a5,-1012(a5) # 80011624 <finishedC>
    80005a20:	fc078ce3          	beqz	a5,800059f8 <_Z20Threads_CPP_API_testv+0x124>
    80005a24:	0000c797          	auipc	a5,0xc
    80005a28:	c017c783          	lbu	a5,-1023(a5) # 80011625 <finishedD>
    80005a2c:	fc0786e3          	beqz	a5,800059f8 <_Z20Threads_CPP_API_testv+0x124>
    }

    for (auto thread: threads) { delete thread; }
    80005a30:	fc040493          	addi	s1,s0,-64
    80005a34:	0080006f          	j	80005a3c <_Z20Threads_CPP_API_testv+0x168>
    80005a38:	00848493          	addi	s1,s1,8
    80005a3c:	fe040793          	addi	a5,s0,-32
    80005a40:	08f48663          	beq	s1,a5,80005acc <_Z20Threads_CPP_API_testv+0x1f8>
    80005a44:	0004b503          	ld	a0,0(s1)
    80005a48:	fe0508e3          	beqz	a0,80005a38 <_Z20Threads_CPP_API_testv+0x164>
    80005a4c:	00053783          	ld	a5,0(a0)
    80005a50:	0087b783          	ld	a5,8(a5)
    80005a54:	000780e7          	jalr	a5
    80005a58:	fe1ff06f          	j	80005a38 <_Z20Threads_CPP_API_testv+0x164>
    80005a5c:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80005a60:	00048513          	mv	a0,s1
    80005a64:	ffffe097          	auipc	ra,0xffffe
    80005a68:	9e4080e7          	jalr	-1564(ra) # 80003448 <_ZdlPv>
    80005a6c:	00090513          	mv	a0,s2
    80005a70:	0000d097          	auipc	ra,0xd
    80005a74:	c98080e7          	jalr	-872(ra) # 80012708 <_Unwind_Resume>
    80005a78:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80005a7c:	00048513          	mv	a0,s1
    80005a80:	ffffe097          	auipc	ra,0xffffe
    80005a84:	9c8080e7          	jalr	-1592(ra) # 80003448 <_ZdlPv>
    80005a88:	00090513          	mv	a0,s2
    80005a8c:	0000d097          	auipc	ra,0xd
    80005a90:	c7c080e7          	jalr	-900(ra) # 80012708 <_Unwind_Resume>
    80005a94:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80005a98:	00048513          	mv	a0,s1
    80005a9c:	ffffe097          	auipc	ra,0xffffe
    80005aa0:	9ac080e7          	jalr	-1620(ra) # 80003448 <_ZdlPv>
    80005aa4:	00090513          	mv	a0,s2
    80005aa8:	0000d097          	auipc	ra,0xd
    80005aac:	c60080e7          	jalr	-928(ra) # 80012708 <_Unwind_Resume>
    80005ab0:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80005ab4:	00048513          	mv	a0,s1
    80005ab8:	ffffe097          	auipc	ra,0xffffe
    80005abc:	990080e7          	jalr	-1648(ra) # 80003448 <_ZdlPv>
    80005ac0:	00090513          	mv	a0,s2
    80005ac4:	0000d097          	auipc	ra,0xd
    80005ac8:	c44080e7          	jalr	-956(ra) # 80012708 <_Unwind_Resume>
}
    80005acc:	03813083          	ld	ra,56(sp)
    80005ad0:	03013403          	ld	s0,48(sp)
    80005ad4:	02813483          	ld	s1,40(sp)
    80005ad8:	02013903          	ld	s2,32(sp)
    80005adc:	04010113          	addi	sp,sp,64
    80005ae0:	00008067          	ret

0000000080005ae4 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005ae4:	fd010113          	addi	sp,sp,-48
    80005ae8:	02113423          	sd	ra,40(sp)
    80005aec:	02813023          	sd	s0,32(sp)
    80005af0:	00913c23          	sd	s1,24(sp)
    80005af4:	01213823          	sd	s2,16(sp)
    80005af8:	01313423          	sd	s3,8(sp)
    80005afc:	03010413          	addi	s0,sp,48
    80005b00:	00050993          	mv	s3,a0
    80005b04:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80005b08:	00000913          	li	s2,0
    80005b0c:	00c0006f          	j	80005b18 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005b10:	ffffe097          	auipc	ra,0xffffe
    80005b14:	b54080e7          	jalr	-1196(ra) # 80003664 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80005b18:	ffffc097          	auipc	ra,0xffffc
    80005b1c:	468080e7          	jalr	1128(ra) # 80001f80 <_Z4getcv>
    80005b20:	0005059b          	sext.w	a1,a0
    80005b24:	01b00793          	li	a5,27
    80005b28:	02f58a63          	beq	a1,a5,80005b5c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80005b2c:	0084b503          	ld	a0,8(s1)
    80005b30:	fffff097          	auipc	ra,0xfffff
    80005b34:	580080e7          	jalr	1408(ra) # 800050b0 <_ZN9BufferCPP3putEi>
        i++;
    80005b38:	0019071b          	addiw	a4,s2,1
    80005b3c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005b40:	0004a683          	lw	a3,0(s1)
    80005b44:	0026979b          	slliw	a5,a3,0x2
    80005b48:	00d787bb          	addw	a5,a5,a3
    80005b4c:	0017979b          	slliw	a5,a5,0x1
    80005b50:	02f767bb          	remw	a5,a4,a5
    80005b54:	fc0792e3          	bnez	a5,80005b18 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80005b58:	fb9ff06f          	j	80005b10 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80005b5c:	00100793          	li	a5,1
    80005b60:	0000c717          	auipc	a4,0xc
    80005b64:	acf72423          	sw	a5,-1336(a4) # 80011628 <threadEnd>
    td->buffer->put('!');
    80005b68:	0109b783          	ld	a5,16(s3)
    80005b6c:	02100593          	li	a1,33
    80005b70:	0087b503          	ld	a0,8(a5)
    80005b74:	fffff097          	auipc	ra,0xfffff
    80005b78:	53c080e7          	jalr	1340(ra) # 800050b0 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80005b7c:	0104b503          	ld	a0,16(s1)
    80005b80:	ffffe097          	auipc	ra,0xffffe
    80005b84:	9d4080e7          	jalr	-1580(ra) # 80003554 <_ZN9Semaphore6signalEv>
}
    80005b88:	02813083          	ld	ra,40(sp)
    80005b8c:	02013403          	ld	s0,32(sp)
    80005b90:	01813483          	ld	s1,24(sp)
    80005b94:	01013903          	ld	s2,16(sp)
    80005b98:	00813983          	ld	s3,8(sp)
    80005b9c:	03010113          	addi	sp,sp,48
    80005ba0:	00008067          	ret

0000000080005ba4 <_ZN8Producer8producerEPv>:
    void run() override {
        producer(td);
    }
};

void Producer::producer(void *arg) {
    80005ba4:	fe010113          	addi	sp,sp,-32
    80005ba8:	00113c23          	sd	ra,24(sp)
    80005bac:	00813823          	sd	s0,16(sp)
    80005bb0:	00913423          	sd	s1,8(sp)
    80005bb4:	01213023          	sd	s2,0(sp)
    80005bb8:	02010413          	addi	s0,sp,32
    80005bbc:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005bc0:	00000913          	li	s2,0
    80005bc4:	00c0006f          	j	80005bd0 <_ZN8Producer8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005bc8:	ffffe097          	auipc	ra,0xffffe
    80005bcc:	a9c080e7          	jalr	-1380(ra) # 80003664 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80005bd0:	0000c797          	auipc	a5,0xc
    80005bd4:	a587a783          	lw	a5,-1448(a5) # 80011628 <threadEnd>
    80005bd8:	02079e63          	bnez	a5,80005c14 <_ZN8Producer8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80005bdc:	0004a583          	lw	a1,0(s1)
    80005be0:	0305859b          	addiw	a1,a1,48
    80005be4:	0084b503          	ld	a0,8(s1)
    80005be8:	fffff097          	auipc	ra,0xfffff
    80005bec:	4c8080e7          	jalr	1224(ra) # 800050b0 <_ZN9BufferCPP3putEi>
        i++;
    80005bf0:	0019071b          	addiw	a4,s2,1
    80005bf4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005bf8:	0004a683          	lw	a3,0(s1)
    80005bfc:	0026979b          	slliw	a5,a3,0x2
    80005c00:	00d787bb          	addw	a5,a5,a3
    80005c04:	0017979b          	slliw	a5,a5,0x1
    80005c08:	02f767bb          	remw	a5,a4,a5
    80005c0c:	fc0792e3          	bnez	a5,80005bd0 <_ZN8Producer8producerEPv+0x2c>
    80005c10:	fb9ff06f          	j	80005bc8 <_ZN8Producer8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005c14:	0104b503          	ld	a0,16(s1)
    80005c18:	ffffe097          	auipc	ra,0xffffe
    80005c1c:	93c080e7          	jalr	-1732(ra) # 80003554 <_ZN9Semaphore6signalEv>
}
    80005c20:	01813083          	ld	ra,24(sp)
    80005c24:	01013403          	ld	s0,16(sp)
    80005c28:	00813483          	ld	s1,8(sp)
    80005c2c:	00013903          	ld	s2,0(sp)
    80005c30:	02010113          	addi	sp,sp,32
    80005c34:	00008067          	ret

0000000080005c38 <_ZN8Consumer8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void Consumer::consumer(void *arg) {
    80005c38:	fd010113          	addi	sp,sp,-48
    80005c3c:	02113423          	sd	ra,40(sp)
    80005c40:	02813023          	sd	s0,32(sp)
    80005c44:	00913c23          	sd	s1,24(sp)
    80005c48:	01213823          	sd	s2,16(sp)
    80005c4c:	01313423          	sd	s3,8(sp)
    80005c50:	01413023          	sd	s4,0(sp)
    80005c54:	03010413          	addi	s0,sp,48
    80005c58:	00050993          	mv	s3,a0
    80005c5c:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005c60:	00000a13          	li	s4,0
    80005c64:	01c0006f          	j	80005c80 <_ZN8Consumer8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80005c68:	ffffe097          	auipc	ra,0xffffe
    80005c6c:	9fc080e7          	jalr	-1540(ra) # 80003664 <_ZN6Thread8dispatchEv>
    80005c70:	0500006f          	j	80005cc0 <_ZN8Consumer8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80005c74:	00a00513          	li	a0,10
    80005c78:	ffffc097          	auipc	ra,0xffffc
    80005c7c:	330080e7          	jalr	816(ra) # 80001fa8 <_Z4putcc>
    while (!threadEnd) {
    80005c80:	0000c797          	auipc	a5,0xc
    80005c84:	9a87a783          	lw	a5,-1624(a5) # 80011628 <threadEnd>
    80005c88:	06079263          	bnez	a5,80005cec <_ZN8Consumer8consumerEPv+0xb4>
        int key = data->buffer->get();
    80005c8c:	00893503          	ld	a0,8(s2)
    80005c90:	fffff097          	auipc	ra,0xfffff
    80005c94:	4b0080e7          	jalr	1200(ra) # 80005140 <_ZN9BufferCPP3getEv>
        i++;
    80005c98:	001a049b          	addiw	s1,s4,1
    80005c9c:	00048a1b          	sext.w	s4,s1
        putc(key);
    80005ca0:	0ff57513          	andi	a0,a0,255
    80005ca4:	ffffc097          	auipc	ra,0xffffc
    80005ca8:	304080e7          	jalr	772(ra) # 80001fa8 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80005cac:	00092703          	lw	a4,0(s2)
    80005cb0:	0027179b          	slliw	a5,a4,0x2
    80005cb4:	00e787bb          	addw	a5,a5,a4
    80005cb8:	02f4e7bb          	remw	a5,s1,a5
    80005cbc:	fa0786e3          	beqz	a5,80005c68 <_ZN8Consumer8consumerEPv+0x30>
        if (i % 80 == 0) {
    80005cc0:	05000793          	li	a5,80
    80005cc4:	02f4e4bb          	remw	s1,s1,a5
    80005cc8:	fa049ce3          	bnez	s1,80005c80 <_ZN8Consumer8consumerEPv+0x48>
    80005ccc:	fa9ff06f          	j	80005c74 <_ZN8Consumer8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80005cd0:	0109b783          	ld	a5,16(s3)
    80005cd4:	0087b503          	ld	a0,8(a5)
    80005cd8:	fffff097          	auipc	ra,0xfffff
    80005cdc:	468080e7          	jalr	1128(ra) # 80005140 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80005ce0:	0ff57513          	andi	a0,a0,255
    80005ce4:	ffffe097          	auipc	ra,0xffffe
    80005ce8:	a6c080e7          	jalr	-1428(ra) # 80003750 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80005cec:	0109b783          	ld	a5,16(s3)
    80005cf0:	0087b503          	ld	a0,8(a5)
    80005cf4:	fffff097          	auipc	ra,0xfffff
    80005cf8:	4d8080e7          	jalr	1240(ra) # 800051cc <_ZN9BufferCPP6getCntEv>
    80005cfc:	fca04ae3          	bgtz	a0,80005cd0 <_ZN8Consumer8consumerEPv+0x98>
    }

    data->wait->signal();
    80005d00:	01093503          	ld	a0,16(s2)
    80005d04:	ffffe097          	auipc	ra,0xffffe
    80005d08:	850080e7          	jalr	-1968(ra) # 80003554 <_ZN9Semaphore6signalEv>
}
    80005d0c:	02813083          	ld	ra,40(sp)
    80005d10:	02013403          	ld	s0,32(sp)
    80005d14:	01813483          	ld	s1,24(sp)
    80005d18:	01013903          	ld	s2,16(sp)
    80005d1c:	00813983          	ld	s3,8(sp)
    80005d20:	00013a03          	ld	s4,0(sp)
    80005d24:	03010113          	addi	sp,sp,48
    80005d28:	00008067          	ret

0000000080005d2c <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80005d2c:	f8010113          	addi	sp,sp,-128
    80005d30:	06113c23          	sd	ra,120(sp)
    80005d34:	06813823          	sd	s0,112(sp)
    80005d38:	06913423          	sd	s1,104(sp)
    80005d3c:	07213023          	sd	s2,96(sp)
    80005d40:	05313c23          	sd	s3,88(sp)
    80005d44:	05413823          	sd	s4,80(sp)
    80005d48:	05513423          	sd	s5,72(sp)
    80005d4c:	05613023          	sd	s6,64(sp)
    80005d50:	03713c23          	sd	s7,56(sp)
    80005d54:	03813823          	sd	s8,48(sp)
    80005d58:	03913423          	sd	s9,40(sp)
    80005d5c:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80005d60:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80005d64:	00005517          	auipc	a0,0x5
    80005d68:	8d450513          	addi	a0,a0,-1836 # 8000a638 <CONSOLE_STATUS+0x628>
    80005d6c:	ffffd097          	auipc	ra,0xffffd
    80005d70:	960080e7          	jalr	-1696(ra) # 800026cc <_Z11printStringPKc>
    getString(input, 30);
    80005d74:	01e00593          	li	a1,30
    80005d78:	f8040493          	addi	s1,s0,-128
    80005d7c:	00048513          	mv	a0,s1
    80005d80:	ffffd097          	auipc	ra,0xffffd
    80005d84:	9c8080e7          	jalr	-1592(ra) # 80002748 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005d88:	00048513          	mv	a0,s1
    80005d8c:	ffffd097          	auipc	ra,0xffffd
    80005d90:	a88080e7          	jalr	-1400(ra) # 80002814 <_Z11stringToIntPKc>
    80005d94:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80005d98:	00005517          	auipc	a0,0x5
    80005d9c:	8c050513          	addi	a0,a0,-1856 # 8000a658 <CONSOLE_STATUS+0x648>
    80005da0:	ffffd097          	auipc	ra,0xffffd
    80005da4:	92c080e7          	jalr	-1748(ra) # 800026cc <_Z11printStringPKc>
    getString(input, 30);
    80005da8:	01e00593          	li	a1,30
    80005dac:	00048513          	mv	a0,s1
    80005db0:	ffffd097          	auipc	ra,0xffffd
    80005db4:	998080e7          	jalr	-1640(ra) # 80002748 <_Z9getStringPci>
    n = stringToInt(input);
    80005db8:	00048513          	mv	a0,s1
    80005dbc:	ffffd097          	auipc	ra,0xffffd
    80005dc0:	a58080e7          	jalr	-1448(ra) # 80002814 <_Z11stringToIntPKc>
    80005dc4:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005dc8:	00005517          	auipc	a0,0x5
    80005dcc:	8b050513          	addi	a0,a0,-1872 # 8000a678 <CONSOLE_STATUS+0x668>
    80005dd0:	ffffd097          	auipc	ra,0xffffd
    80005dd4:	8fc080e7          	jalr	-1796(ra) # 800026cc <_Z11printStringPKc>
    80005dd8:	00000613          	li	a2,0
    80005ddc:	00a00593          	li	a1,10
    80005de0:	00090513          	mv	a0,s2
    80005de4:	ffffd097          	auipc	ra,0xffffd
    80005de8:	a80080e7          	jalr	-1408(ra) # 80002864 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005dec:	00005517          	auipc	a0,0x5
    80005df0:	8a450513          	addi	a0,a0,-1884 # 8000a690 <CONSOLE_STATUS+0x680>
    80005df4:	ffffd097          	auipc	ra,0xffffd
    80005df8:	8d8080e7          	jalr	-1832(ra) # 800026cc <_Z11printStringPKc>
    80005dfc:	00000613          	li	a2,0
    80005e00:	00a00593          	li	a1,10
    80005e04:	00048513          	mv	a0,s1
    80005e08:	ffffd097          	auipc	ra,0xffffd
    80005e0c:	a5c080e7          	jalr	-1444(ra) # 80002864 <_Z8printIntiii>
    printString(".\n");
    80005e10:	00004517          	auipc	a0,0x4
    80005e14:	55050513          	addi	a0,a0,1360 # 8000a360 <CONSOLE_STATUS+0x350>
    80005e18:	ffffd097          	auipc	ra,0xffffd
    80005e1c:	8b4080e7          	jalr	-1868(ra) # 800026cc <_Z11printStringPKc>
    if(threadNum > n) {
    80005e20:	0324c463          	blt	s1,s2,80005e48 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005e24:	03205c63          	blez	s2,80005e5c <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80005e28:	03800513          	li	a0,56
    80005e2c:	ffffd097          	auipc	ra,0xffffd
    80005e30:	5cc080e7          	jalr	1484(ra) # 800033f8 <_Znwm>
    80005e34:	00050a93          	mv	s5,a0
    80005e38:	00048593          	mv	a1,s1
    80005e3c:	fffff097          	auipc	ra,0xfffff
    80005e40:	120080e7          	jalr	288(ra) # 80004f5c <_ZN9BufferCPPC1Ei>
    80005e44:	0300006f          	j	80005e74 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005e48:	00005517          	auipc	a0,0x5
    80005e4c:	86050513          	addi	a0,a0,-1952 # 8000a6a8 <CONSOLE_STATUS+0x698>
    80005e50:	ffffd097          	auipc	ra,0xffffd
    80005e54:	87c080e7          	jalr	-1924(ra) # 800026cc <_Z11printStringPKc>
        return;
    80005e58:	0140006f          	j	80005e6c <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80005e5c:	00005517          	auipc	a0,0x5
    80005e60:	88c50513          	addi	a0,a0,-1908 # 8000a6e8 <CONSOLE_STATUS+0x6d8>
    80005e64:	ffffd097          	auipc	ra,0xffffd
    80005e68:	868080e7          	jalr	-1944(ra) # 800026cc <_Z11printStringPKc>
        return;
    80005e6c:	000b8113          	mv	sp,s7
    80005e70:	2400006f          	j	800060b0 <_Z29producerConsumer_CPP_Sync_APIv+0x384>
    waitForAll = new Semaphore(0);
    80005e74:	01000513          	li	a0,16
    80005e78:	ffffd097          	auipc	ra,0xffffd
    80005e7c:	580080e7          	jalr	1408(ra) # 800033f8 <_Znwm>
    80005e80:	00050493          	mv	s1,a0
    80005e84:	00000593          	li	a1,0
    80005e88:	ffffd097          	auipc	ra,0xffffd
    80005e8c:	668080e7          	jalr	1640(ra) # 800034f0 <_ZN9SemaphoreC1Ej>
    80005e90:	0000b717          	auipc	a4,0xb
    80005e94:	78870713          	addi	a4,a4,1928 # 80011618 <_ZN19ConsumerProducerCPP9threadEndE>
    80005e98:	00973c23          	sd	s1,24(a4)
    Thread* threads[threadNum];
    80005e9c:	00391793          	slli	a5,s2,0x3
    80005ea0:	00f78793          	addi	a5,a5,15
    80005ea4:	ff07f793          	andi	a5,a5,-16
    80005ea8:	40f10133          	sub	sp,sp,a5
    80005eac:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80005eb0:	0019069b          	addiw	a3,s2,1
    80005eb4:	00169793          	slli	a5,a3,0x1
    80005eb8:	00d787b3          	add	a5,a5,a3
    80005ebc:	00379793          	slli	a5,a5,0x3
    80005ec0:	00f78793          	addi	a5,a5,15
    80005ec4:	ff07f793          	andi	a5,a5,-16
    80005ec8:	40f10133          	sub	sp,sp,a5
    80005ecc:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80005ed0:	00191493          	slli	s1,s2,0x1
    80005ed4:	012487b3          	add	a5,s1,s2
    80005ed8:	00379793          	slli	a5,a5,0x3
    80005edc:	00fa07b3          	add	a5,s4,a5
    80005ee0:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005ee4:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005ee8:	01873703          	ld	a4,24(a4)
    80005eec:	00e7b823          	sd	a4,16(a5)
    consumerThread = new Consumer(data+threadNum);
    80005ef0:	01800513          	li	a0,24
    80005ef4:	ffffd097          	auipc	ra,0xffffd
    80005ef8:	504080e7          	jalr	1284(ra) # 800033f8 <_Znwm>
    80005efc:	00050b13          	mv	s6,a0
    80005f00:	012484b3          	add	s1,s1,s2
    80005f04:	00349493          	slli	s1,s1,0x3
    80005f08:	009a04b3          	add	s1,s4,s1
    Consumer(thread_data* _td):Thread(), td(_td) {}
    80005f0c:	ffffd097          	auipc	ra,0xffffd
    80005f10:	6ac080e7          	jalr	1708(ra) # 800035b8 <_ZN6ThreadC1Ev>
    80005f14:	00007797          	auipc	a5,0x7
    80005f18:	35478793          	addi	a5,a5,852 # 8000d268 <_ZTV8Consumer+0x10>
    80005f1c:	00fb3023          	sd	a5,0(s6)
    80005f20:	009b3823          	sd	s1,16(s6)
    consumerThread->start();
    80005f24:	000b0513          	mv	a0,s6
    80005f28:	ffffd097          	auipc	ra,0xffffd
    80005f2c:	764080e7          	jalr	1892(ra) # 8000368c <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005f30:	00000493          	li	s1,0
    80005f34:	0380006f          	j	80005f6c <_Z29producerConsumer_CPP_Sync_APIv+0x240>
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005f38:	00007797          	auipc	a5,0x7
    80005f3c:	30878793          	addi	a5,a5,776 # 8000d240 <_ZTV8Producer+0x10>
    80005f40:	00fcb023          	sd	a5,0(s9)
    80005f44:	018cb823          	sd	s8,16(s9)
            threads[i] = new Producer(data+i);
    80005f48:	00349793          	slli	a5,s1,0x3
    80005f4c:	00f987b3          	add	a5,s3,a5
    80005f50:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80005f54:	00349793          	slli	a5,s1,0x3
    80005f58:	00f987b3          	add	a5,s3,a5
    80005f5c:	0007b503          	ld	a0,0(a5)
    80005f60:	ffffd097          	auipc	ra,0xffffd
    80005f64:	72c080e7          	jalr	1836(ra) # 8000368c <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005f68:	0014849b          	addiw	s1,s1,1
    80005f6c:	0b24d063          	bge	s1,s2,8000600c <_Z29producerConsumer_CPP_Sync_APIv+0x2e0>
        data[i].id = i;
    80005f70:	00149793          	slli	a5,s1,0x1
    80005f74:	009787b3          	add	a5,a5,s1
    80005f78:	00379793          	slli	a5,a5,0x3
    80005f7c:	00fa07b3          	add	a5,s4,a5
    80005f80:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80005f84:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80005f88:	0000b717          	auipc	a4,0xb
    80005f8c:	6a873703          	ld	a4,1704(a4) # 80011630 <waitForAll>
    80005f90:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80005f94:	02905863          	blez	s1,80005fc4 <_Z29producerConsumer_CPP_Sync_APIv+0x298>
            threads[i] = new Producer(data+i);
    80005f98:	01800513          	li	a0,24
    80005f9c:	ffffd097          	auipc	ra,0xffffd
    80005fa0:	45c080e7          	jalr	1116(ra) # 800033f8 <_Znwm>
    80005fa4:	00050c93          	mv	s9,a0
    80005fa8:	00149c13          	slli	s8,s1,0x1
    80005fac:	009c0c33          	add	s8,s8,s1
    80005fb0:	003c1c13          	slli	s8,s8,0x3
    80005fb4:	018a0c33          	add	s8,s4,s8
    Producer(thread_data* _td):Thread(), td(_td) {}
    80005fb8:	ffffd097          	auipc	ra,0xffffd
    80005fbc:	600080e7          	jalr	1536(ra) # 800035b8 <_ZN6ThreadC1Ev>
    80005fc0:	f79ff06f          	j	80005f38 <_Z29producerConsumer_CPP_Sync_APIv+0x20c>
            threads[i] = new ProducerKeyboard(data+i);
    80005fc4:	01800513          	li	a0,24
    80005fc8:	ffffd097          	auipc	ra,0xffffd
    80005fcc:	430080e7          	jalr	1072(ra) # 800033f8 <_Znwm>
    80005fd0:	00050c93          	mv	s9,a0
    80005fd4:	00149c13          	slli	s8,s1,0x1
    80005fd8:	009c0c33          	add	s8,s8,s1
    80005fdc:	003c1c13          	slli	s8,s8,0x3
    80005fe0:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005fe4:	ffffd097          	auipc	ra,0xffffd
    80005fe8:	5d4080e7          	jalr	1492(ra) # 800035b8 <_ZN6ThreadC1Ev>
    80005fec:	00007797          	auipc	a5,0x7
    80005ff0:	22c78793          	addi	a5,a5,556 # 8000d218 <_ZTV16ProducerKeyboard+0x10>
    80005ff4:	00fcb023          	sd	a5,0(s9)
    80005ff8:	018cb823          	sd	s8,16(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005ffc:	00349793          	slli	a5,s1,0x3
    80006000:	00f987b3          	add	a5,s3,a5
    80006004:	0197b023          	sd	s9,0(a5)
    80006008:	f4dff06f          	j	80005f54 <_Z29producerConsumer_CPP_Sync_APIv+0x228>
    Thread::dispatch();
    8000600c:	ffffd097          	auipc	ra,0xffffd
    80006010:	658080e7          	jalr	1624(ra) # 80003664 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80006014:	00000493          	li	s1,0
    80006018:	00994e63          	blt	s2,s1,80006034 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
        waitForAll->wait();
    8000601c:	0000b517          	auipc	a0,0xb
    80006020:	61453503          	ld	a0,1556(a0) # 80011630 <waitForAll>
    80006024:	ffffd097          	auipc	ra,0xffffd
    80006028:	504080e7          	jalr	1284(ra) # 80003528 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    8000602c:	0014849b          	addiw	s1,s1,1
    80006030:	fe9ff06f          	j	80006018 <_Z29producerConsumer_CPP_Sync_APIv+0x2ec>
    for (int i = 0; i < threadNum; i++) {
    80006034:	00000493          	li	s1,0
    80006038:	0080006f          	j	80006040 <_Z29producerConsumer_CPP_Sync_APIv+0x314>
    8000603c:	0014849b          	addiw	s1,s1,1
    80006040:	0324d263          	bge	s1,s2,80006064 <_Z29producerConsumer_CPP_Sync_APIv+0x338>
        delete threads[i];
    80006044:	00349793          	slli	a5,s1,0x3
    80006048:	00f987b3          	add	a5,s3,a5
    8000604c:	0007b503          	ld	a0,0(a5)
    80006050:	fe0506e3          	beqz	a0,8000603c <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    80006054:	00053783          	ld	a5,0(a0)
    80006058:	0087b783          	ld	a5,8(a5)
    8000605c:	000780e7          	jalr	a5
    80006060:	fddff06f          	j	8000603c <_Z29producerConsumer_CPP_Sync_APIv+0x310>
    delete consumerThread;
    80006064:	000b0a63          	beqz	s6,80006078 <_Z29producerConsumer_CPP_Sync_APIv+0x34c>
    80006068:	000b3783          	ld	a5,0(s6)
    8000606c:	0087b783          	ld	a5,8(a5)
    80006070:	000b0513          	mv	a0,s6
    80006074:	000780e7          	jalr	a5
    delete waitForAll;
    80006078:	0000b517          	auipc	a0,0xb
    8000607c:	5b853503          	ld	a0,1464(a0) # 80011630 <waitForAll>
    80006080:	00050863          	beqz	a0,80006090 <_Z29producerConsumer_CPP_Sync_APIv+0x364>
    80006084:	00053783          	ld	a5,0(a0)
    80006088:	0087b783          	ld	a5,8(a5)
    8000608c:	000780e7          	jalr	a5
    delete buffer;
    80006090:	000a8e63          	beqz	s5,800060ac <_Z29producerConsumer_CPP_Sync_APIv+0x380>
    80006094:	000a8513          	mv	a0,s5
    80006098:	fffff097          	auipc	ra,0xfffff
    8000609c:	1bc080e7          	jalr	444(ra) # 80005254 <_ZN9BufferCPPD1Ev>
    800060a0:	000a8513          	mv	a0,s5
    800060a4:	ffffd097          	auipc	ra,0xffffd
    800060a8:	3a4080e7          	jalr	932(ra) # 80003448 <_ZdlPv>
    800060ac:	000b8113          	mv	sp,s7

}
    800060b0:	f8040113          	addi	sp,s0,-128
    800060b4:	07813083          	ld	ra,120(sp)
    800060b8:	07013403          	ld	s0,112(sp)
    800060bc:	06813483          	ld	s1,104(sp)
    800060c0:	06013903          	ld	s2,96(sp)
    800060c4:	05813983          	ld	s3,88(sp)
    800060c8:	05013a03          	ld	s4,80(sp)
    800060cc:	04813a83          	ld	s5,72(sp)
    800060d0:	04013b03          	ld	s6,64(sp)
    800060d4:	03813b83          	ld	s7,56(sp)
    800060d8:	03013c03          	ld	s8,48(sp)
    800060dc:	02813c83          	ld	s9,40(sp)
    800060e0:	08010113          	addi	sp,sp,128
    800060e4:	00008067          	ret
    800060e8:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800060ec:	000a8513          	mv	a0,s5
    800060f0:	ffffd097          	auipc	ra,0xffffd
    800060f4:	358080e7          	jalr	856(ra) # 80003448 <_ZdlPv>
    800060f8:	00048513          	mv	a0,s1
    800060fc:	0000c097          	auipc	ra,0xc
    80006100:	60c080e7          	jalr	1548(ra) # 80012708 <_Unwind_Resume>
    80006104:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80006108:	00048513          	mv	a0,s1
    8000610c:	ffffd097          	auipc	ra,0xffffd
    80006110:	33c080e7          	jalr	828(ra) # 80003448 <_ZdlPv>
    80006114:	00090513          	mv	a0,s2
    80006118:	0000c097          	auipc	ra,0xc
    8000611c:	5f0080e7          	jalr	1520(ra) # 80012708 <_Unwind_Resume>
    80006120:	00050493          	mv	s1,a0
    consumerThread = new Consumer(data+threadNum);
    80006124:	000b0513          	mv	a0,s6
    80006128:	ffffd097          	auipc	ra,0xffffd
    8000612c:	320080e7          	jalr	800(ra) # 80003448 <_ZdlPv>
    80006130:	00048513          	mv	a0,s1
    80006134:	0000c097          	auipc	ra,0xc
    80006138:	5d4080e7          	jalr	1492(ra) # 80012708 <_Unwind_Resume>
    8000613c:	00050493          	mv	s1,a0
            threads[i] = new Producer(data+i);
    80006140:	000c8513          	mv	a0,s9
    80006144:	ffffd097          	auipc	ra,0xffffd
    80006148:	304080e7          	jalr	772(ra) # 80003448 <_ZdlPv>
    8000614c:	00048513          	mv	a0,s1
    80006150:	0000c097          	auipc	ra,0xc
    80006154:	5b8080e7          	jalr	1464(ra) # 80012708 <_Unwind_Resume>
    80006158:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    8000615c:	000c8513          	mv	a0,s9
    80006160:	ffffd097          	auipc	ra,0xffffd
    80006164:	2e8080e7          	jalr	744(ra) # 80003448 <_ZdlPv>
    80006168:	00048513          	mv	a0,s1
    8000616c:	0000c097          	auipc	ra,0xc
    80006170:	59c080e7          	jalr	1436(ra) # 80012708 <_Unwind_Resume>

0000000080006174 <_Z12testSleepingv>:

void testSleeping() {
    80006174:	fc010113          	addi	sp,sp,-64
    80006178:	02113c23          	sd	ra,56(sp)
    8000617c:	02813823          	sd	s0,48(sp)
    80006180:	02913423          	sd	s1,40(sp)
    80006184:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80006188:	00a00793          	li	a5,10
    8000618c:	fcf43823          	sd	a5,-48(s0)
    80006190:	01400793          	li	a5,20
    80006194:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80006198:	00000493          	li	s1,0
    8000619c:	02c0006f          	j	800061c8 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    800061a0:	00349793          	slli	a5,s1,0x3
    800061a4:	fd040613          	addi	a2,s0,-48
    800061a8:	00f60633          	add	a2,a2,a5
    800061ac:	fffff597          	auipc	a1,0xfffff
    800061b0:	1a858593          	addi	a1,a1,424 # 80005354 <_Z9sleepyRunPv>
    800061b4:	fc040513          	addi	a0,s0,-64
    800061b8:	00f50533          	add	a0,a0,a5
    800061bc:	ffffc097          	auipc	ra,0xffffc
    800061c0:	b70080e7          	jalr	-1168(ra) # 80001d2c <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800061c4:	0014849b          	addiw	s1,s1,1
    800061c8:	00100793          	li	a5,1
    800061cc:	fc97dae3          	bge	a5,s1,800061a0 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800061d0:	0000b797          	auipc	a5,0xb
    800061d4:	4507c783          	lbu	a5,1104(a5) # 80011620 <finished>
    800061d8:	fe078ce3          	beqz	a5,800061d0 <_Z12testSleepingv+0x5c>
    800061dc:	0000b797          	auipc	a5,0xb
    800061e0:	4457c783          	lbu	a5,1093(a5) # 80011621 <finished+0x1>
    800061e4:	fe0786e3          	beqz	a5,800061d0 <_Z12testSleepingv+0x5c>
}
    800061e8:	03813083          	ld	ra,56(sp)
    800061ec:	03013403          	ld	s0,48(sp)
    800061f0:	02813483          	ld	s1,40(sp)
    800061f4:	04010113          	addi	sp,sp,64
    800061f8:	00008067          	ret

00000000800061fc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    800061fc:	f8010113          	addi	sp,sp,-128
    80006200:	06113c23          	sd	ra,120(sp)
    80006204:	06813823          	sd	s0,112(sp)
    80006208:	06913423          	sd	s1,104(sp)
    8000620c:	07213023          	sd	s2,96(sp)
    80006210:	05313c23          	sd	s3,88(sp)
    80006214:	05413823          	sd	s4,80(sp)
    80006218:	05513423          	sd	s5,72(sp)
    8000621c:	05613023          	sd	s6,64(sp)
    80006220:	03713c23          	sd	s7,56(sp)
    80006224:	03813823          	sd	s8,48(sp)
    80006228:	03913423          	sd	s9,40(sp)
    8000622c:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    80006230:	00010c13          	mv	s8,sp
        printString("Unesite broj proizvodjaca?\n");
    80006234:	00004517          	auipc	a0,0x4
    80006238:	40450513          	addi	a0,a0,1028 # 8000a638 <CONSOLE_STATUS+0x628>
    8000623c:	ffffc097          	auipc	ra,0xffffc
    80006240:	490080e7          	jalr	1168(ra) # 800026cc <_Z11printStringPKc>
        getString(input, 30);
    80006244:	01e00593          	li	a1,30
    80006248:	f8040493          	addi	s1,s0,-128
    8000624c:	00048513          	mv	a0,s1
    80006250:	ffffc097          	auipc	ra,0xffffc
    80006254:	4f8080e7          	jalr	1272(ra) # 80002748 <_Z9getStringPci>
        threadNum = stringToInt(input);
    80006258:	00048513          	mv	a0,s1
    8000625c:	ffffc097          	auipc	ra,0xffffc
    80006260:	5b8080e7          	jalr	1464(ra) # 80002814 <_Z11stringToIntPKc>
    80006264:	00050993          	mv	s3,a0
        printString("Unesite velicinu bafera?\n");
    80006268:	00004517          	auipc	a0,0x4
    8000626c:	3f050513          	addi	a0,a0,1008 # 8000a658 <CONSOLE_STATUS+0x648>
    80006270:	ffffc097          	auipc	ra,0xffffc
    80006274:	45c080e7          	jalr	1116(ra) # 800026cc <_Z11printStringPKc>
        getString(input, 30);
    80006278:	01e00593          	li	a1,30
    8000627c:	00048513          	mv	a0,s1
    80006280:	ffffc097          	auipc	ra,0xffffc
    80006284:	4c8080e7          	jalr	1224(ra) # 80002748 <_Z9getStringPci>
        n = stringToInt(input);
    80006288:	00048513          	mv	a0,s1
    8000628c:	ffffc097          	auipc	ra,0xffffc
    80006290:	588080e7          	jalr	1416(ra) # 80002814 <_Z11stringToIntPKc>
    80006294:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    80006298:	00004517          	auipc	a0,0x4
    8000629c:	3e050513          	addi	a0,a0,992 # 8000a678 <CONSOLE_STATUS+0x668>
    800062a0:	ffffc097          	auipc	ra,0xffffc
    800062a4:	42c080e7          	jalr	1068(ra) # 800026cc <_Z11printStringPKc>
    800062a8:	00000613          	li	a2,0
    800062ac:	00a00593          	li	a1,10
    800062b0:	00098513          	mv	a0,s3
    800062b4:	ffffc097          	auipc	ra,0xffffc
    800062b8:	5b0080e7          	jalr	1456(ra) # 80002864 <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    800062bc:	00004517          	auipc	a0,0x4
    800062c0:	3d450513          	addi	a0,a0,980 # 8000a690 <CONSOLE_STATUS+0x680>
    800062c4:	ffffc097          	auipc	ra,0xffffc
    800062c8:	408080e7          	jalr	1032(ra) # 800026cc <_Z11printStringPKc>
    800062cc:	00000613          	li	a2,0
    800062d0:	00a00593          	li	a1,10
    800062d4:	00048513          	mv	a0,s1
    800062d8:	ffffc097          	auipc	ra,0xffffc
    800062dc:	58c080e7          	jalr	1420(ra) # 80002864 <_Z8printIntiii>
        printString(".\n");
    800062e0:	00004517          	auipc	a0,0x4
    800062e4:	08050513          	addi	a0,a0,128 # 8000a360 <CONSOLE_STATUS+0x350>
    800062e8:	ffffc097          	auipc	ra,0xffffc
    800062ec:	3e4080e7          	jalr	996(ra) # 800026cc <_Z11printStringPKc>
        if(threadNum > n) {
    800062f0:	0334c463          	blt	s1,s3,80006318 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x11c>
        } else if (threadNum < 1) {
    800062f4:	03305c63          	blez	s3,8000632c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x130>
        BufferCPP *buffer = new BufferCPP(n);
    800062f8:	03800513          	li	a0,56
    800062fc:	ffffd097          	auipc	ra,0xffffd
    80006300:	0fc080e7          	jalr	252(ra) # 800033f8 <_Znwm>
    80006304:	00050a93          	mv	s5,a0
    80006308:	00048593          	mv	a1,s1
    8000630c:	fffff097          	auipc	ra,0xfffff
    80006310:	c50080e7          	jalr	-944(ra) # 80004f5c <_ZN9BufferCPPC1Ei>
    80006314:	0300006f          	j	80006344 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x148>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80006318:	00004517          	auipc	a0,0x4
    8000631c:	39050513          	addi	a0,a0,912 # 8000a6a8 <CONSOLE_STATUS+0x698>
    80006320:	ffffc097          	auipc	ra,0xffffc
    80006324:	3ac080e7          	jalr	940(ra) # 800026cc <_Z11printStringPKc>
            return;
    80006328:	0140006f          	j	8000633c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x140>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000632c:	00004517          	auipc	a0,0x4
    80006330:	3bc50513          	addi	a0,a0,956 # 8000a6e8 <CONSOLE_STATUS+0x6d8>
    80006334:	ffffc097          	auipc	ra,0xffffc
    80006338:	398080e7          	jalr	920(ra) # 800026cc <_Z11printStringPKc>
            return;
    8000633c:	000c0113          	mv	sp,s8
    80006340:	21c0006f          	j	8000655c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
        waitForAll = new Semaphore(0);
    80006344:	01000513          	li	a0,16
    80006348:	ffffd097          	auipc	ra,0xffffd
    8000634c:	0b0080e7          	jalr	176(ra) # 800033f8 <_Znwm>
    80006350:	00050493          	mv	s1,a0
    80006354:	00000593          	li	a1,0
    80006358:	ffffd097          	auipc	ra,0xffffd
    8000635c:	198080e7          	jalr	408(ra) # 800034f0 <_ZN9SemaphoreC1Ej>
    80006360:	0000b717          	auipc	a4,0xb
    80006364:	2b870713          	addi	a4,a4,696 # 80011618 <_ZN19ConsumerProducerCPP9threadEndE>
    80006368:	02973023          	sd	s1,32(a4)
        Thread *producers[threadNum];
    8000636c:	00399793          	slli	a5,s3,0x3
    80006370:	00f78793          	addi	a5,a5,15
    80006374:	ff07f793          	andi	a5,a5,-16
    80006378:	40f10133          	sub	sp,sp,a5
    8000637c:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    80006380:	0019869b          	addiw	a3,s3,1
    80006384:	00169793          	slli	a5,a3,0x1
    80006388:	00d787b3          	add	a5,a5,a3
    8000638c:	00379793          	slli	a5,a5,0x3
    80006390:	00f78793          	addi	a5,a5,15
    80006394:	ff07f793          	andi	a5,a5,-16
    80006398:	40f10133          	sub	sp,sp,a5
    8000639c:	00010b13          	mv	s6,sp
        threadData[threadNum].id = threadNum;
    800063a0:	00199493          	slli	s1,s3,0x1
    800063a4:	013484b3          	add	s1,s1,s3
    800063a8:	00349493          	slli	s1,s1,0x3
    800063ac:	009b04b3          	add	s1,s6,s1
    800063b0:	0134a023          	sw	s3,0(s1)
        threadData[threadNum].buffer = buffer;
    800063b4:	0154b423          	sd	s5,8(s1)
        threadData[threadNum].sem = waitForAll;
    800063b8:	02073783          	ld	a5,32(a4)
    800063bc:	00f4b823          	sd	a5,16(s1)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800063c0:	01800513          	li	a0,24
    800063c4:	ffffd097          	auipc	ra,0xffffd
    800063c8:	034080e7          	jalr	52(ra) # 800033f8 <_Znwm>
    800063cc:	00050b93          	mv	s7,a0
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    800063d0:	ffffd097          	auipc	ra,0xffffd
    800063d4:	1e8080e7          	jalr	488(ra) # 800035b8 <_ZN6ThreadC1Ev>
    800063d8:	00007797          	auipc	a5,0x7
    800063dc:	f0878793          	addi	a5,a5,-248 # 8000d2e0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800063e0:	00fbb023          	sd	a5,0(s7)
    800063e4:	009bb823          	sd	s1,16(s7)
        consumer->start();
    800063e8:	000b8513          	mv	a0,s7
    800063ec:	ffffd097          	auipc	ra,0xffffd
    800063f0:	2a0080e7          	jalr	672(ra) # 8000368c <_ZN6Thread5startEv>
        threadData[0].id = 0;
    800063f4:	000b2023          	sw	zero,0(s6)
        threadData[0].buffer = buffer;
    800063f8:	015b3423          	sd	s5,8(s6)
        threadData[0].sem = waitForAll;
    800063fc:	0000b797          	auipc	a5,0xb
    80006400:	23c7b783          	ld	a5,572(a5) # 80011638 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006404:	00fb3823          	sd	a5,16(s6)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006408:	01800513          	li	a0,24
    8000640c:	ffffd097          	auipc	ra,0xffffd
    80006410:	fec080e7          	jalr	-20(ra) # 800033f8 <_Znwm>
    80006414:	00050493          	mv	s1,a0
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80006418:	ffffd097          	auipc	ra,0xffffd
    8000641c:	1a0080e7          	jalr	416(ra) # 800035b8 <_ZN6ThreadC1Ev>
    80006420:	00007797          	auipc	a5,0x7
    80006424:	e7078793          	addi	a5,a5,-400 # 8000d290 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006428:	00f4b023          	sd	a5,0(s1)
    8000642c:	0164b823          	sd	s6,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80006430:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80006434:	00048513          	mv	a0,s1
    80006438:	ffffd097          	auipc	ra,0xffffd
    8000643c:	254080e7          	jalr	596(ra) # 8000368c <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006440:	00100913          	li	s2,1
    80006444:	0300006f          	j	80006474 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x278>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80006448:	00007797          	auipc	a5,0x7
    8000644c:	e7078793          	addi	a5,a5,-400 # 8000d2b8 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006450:	00fcb023          	sd	a5,0(s9)
    80006454:	009cb823          	sd	s1,16(s9)
            producers[i] = new Producer(&threadData[i]);
    80006458:	00391793          	slli	a5,s2,0x3
    8000645c:	00fa07b3          	add	a5,s4,a5
    80006460:	0197b023          	sd	s9,0(a5)
            producers[i]->start();
    80006464:	000c8513          	mv	a0,s9
    80006468:	ffffd097          	auipc	ra,0xffffd
    8000646c:	224080e7          	jalr	548(ra) # 8000368c <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80006470:	0019091b          	addiw	s2,s2,1
    80006474:	05395263          	bge	s2,s3,800064b8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2bc>
            threadData[i].id = i;
    80006478:	00191493          	slli	s1,s2,0x1
    8000647c:	012484b3          	add	s1,s1,s2
    80006480:	00349493          	slli	s1,s1,0x3
    80006484:	009b04b3          	add	s1,s6,s1
    80006488:	0124a023          	sw	s2,0(s1)
            threadData[i].buffer = buffer;
    8000648c:	0154b423          	sd	s5,8(s1)
            threadData[i].sem = waitForAll;
    80006490:	0000b797          	auipc	a5,0xb
    80006494:	1a87b783          	ld	a5,424(a5) # 80011638 <_ZN19ConsumerProducerCPP10waitForAllE>
    80006498:	00f4b823          	sd	a5,16(s1)
            producers[i] = new Producer(&threadData[i]);
    8000649c:	01800513          	li	a0,24
    800064a0:	ffffd097          	auipc	ra,0xffffd
    800064a4:	f58080e7          	jalr	-168(ra) # 800033f8 <_Znwm>
    800064a8:	00050c93          	mv	s9,a0
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800064ac:	ffffd097          	auipc	ra,0xffffd
    800064b0:	10c080e7          	jalr	268(ra) # 800035b8 <_ZN6ThreadC1Ev>
    800064b4:	f95ff06f          	j	80006448 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x24c>
        Thread::dispatch();
    800064b8:	ffffd097          	auipc	ra,0xffffd
    800064bc:	1ac080e7          	jalr	428(ra) # 80003664 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    800064c0:	00000493          	li	s1,0
    800064c4:	0099ce63          	blt	s3,s1,800064e0 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2e4>
            waitForAll->wait();
    800064c8:	0000b517          	auipc	a0,0xb
    800064cc:	17053503          	ld	a0,368(a0) # 80011638 <_ZN19ConsumerProducerCPP10waitForAllE>
    800064d0:	ffffd097          	auipc	ra,0xffffd
    800064d4:	058080e7          	jalr	88(ra) # 80003528 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    800064d8:	0014849b          	addiw	s1,s1,1
    800064dc:	fe9ff06f          	j	800064c4 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2c8>
        delete waitForAll;
    800064e0:	0000b517          	auipc	a0,0xb
    800064e4:	15853503          	ld	a0,344(a0) # 80011638 <_ZN19ConsumerProducerCPP10waitForAllE>
    800064e8:	00050863          	beqz	a0,800064f8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
    800064ec:	00053783          	ld	a5,0(a0)
    800064f0:	0087b783          	ld	a5,8(a5)
    800064f4:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    800064f8:	00000493          	li	s1,0
    800064fc:	0080006f          	j	80006504 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x308>
        for (int i = 0; i < threadNum; i++) {
    80006500:	0014849b          	addiw	s1,s1,1
    80006504:	0334d263          	bge	s1,s3,80006528 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x32c>
            delete producers[i];
    80006508:	00349793          	slli	a5,s1,0x3
    8000650c:	00fa07b3          	add	a5,s4,a5
    80006510:	0007b503          	ld	a0,0(a5)
    80006514:	fe0506e3          	beqz	a0,80006500 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
    80006518:	00053783          	ld	a5,0(a0)
    8000651c:	0087b783          	ld	a5,8(a5)
    80006520:	000780e7          	jalr	a5
    80006524:	fddff06f          	j	80006500 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x304>
        delete consumer;
    80006528:	000b8a63          	beqz	s7,8000653c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x340>
    8000652c:	000bb783          	ld	a5,0(s7)
    80006530:	0087b783          	ld	a5,8(a5)
    80006534:	000b8513          	mv	a0,s7
    80006538:	000780e7          	jalr	a5
        delete buffer;
    8000653c:	000a8e63          	beqz	s5,80006558 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x35c>
    80006540:	000a8513          	mv	a0,s5
    80006544:	fffff097          	auipc	ra,0xfffff
    80006548:	d10080e7          	jalr	-752(ra) # 80005254 <_ZN9BufferCPPD1Ev>
    8000654c:	000a8513          	mv	a0,s5
    80006550:	ffffd097          	auipc	ra,0xffffd
    80006554:	ef8080e7          	jalr	-264(ra) # 80003448 <_ZdlPv>
    80006558:	000c0113          	mv	sp,s8
    }
    8000655c:	f8040113          	addi	sp,s0,-128
    80006560:	07813083          	ld	ra,120(sp)
    80006564:	07013403          	ld	s0,112(sp)
    80006568:	06813483          	ld	s1,104(sp)
    8000656c:	06013903          	ld	s2,96(sp)
    80006570:	05813983          	ld	s3,88(sp)
    80006574:	05013a03          	ld	s4,80(sp)
    80006578:	04813a83          	ld	s5,72(sp)
    8000657c:	04013b03          	ld	s6,64(sp)
    80006580:	03813b83          	ld	s7,56(sp)
    80006584:	03013c03          	ld	s8,48(sp)
    80006588:	02813c83          	ld	s9,40(sp)
    8000658c:	08010113          	addi	sp,sp,128
    80006590:	00008067          	ret
    80006594:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    80006598:	000a8513          	mv	a0,s5
    8000659c:	ffffd097          	auipc	ra,0xffffd
    800065a0:	eac080e7          	jalr	-340(ra) # 80003448 <_ZdlPv>
    800065a4:	00048513          	mv	a0,s1
    800065a8:	0000c097          	auipc	ra,0xc
    800065ac:	160080e7          	jalr	352(ra) # 80012708 <_Unwind_Resume>
    800065b0:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    800065b4:	00048513          	mv	a0,s1
    800065b8:	ffffd097          	auipc	ra,0xffffd
    800065bc:	e90080e7          	jalr	-368(ra) # 80003448 <_ZdlPv>
    800065c0:	00090513          	mv	a0,s2
    800065c4:	0000c097          	auipc	ra,0xc
    800065c8:	144080e7          	jalr	324(ra) # 80012708 <_Unwind_Resume>
    800065cc:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    800065d0:	000b8513          	mv	a0,s7
    800065d4:	ffffd097          	auipc	ra,0xffffd
    800065d8:	e74080e7          	jalr	-396(ra) # 80003448 <_ZdlPv>
    800065dc:	00048513          	mv	a0,s1
    800065e0:	0000c097          	auipc	ra,0xc
    800065e4:	128080e7          	jalr	296(ra) # 80012708 <_Unwind_Resume>
    800065e8:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    800065ec:	00048513          	mv	a0,s1
    800065f0:	ffffd097          	auipc	ra,0xffffd
    800065f4:	e58080e7          	jalr	-424(ra) # 80003448 <_ZdlPv>
    800065f8:	00090513          	mv	a0,s2
    800065fc:	0000c097          	auipc	ra,0xc
    80006600:	10c080e7          	jalr	268(ra) # 80012708 <_Unwind_Resume>
    80006604:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    80006608:	000c8513          	mv	a0,s9
    8000660c:	ffffd097          	auipc	ra,0xffffd
    80006610:	e3c080e7          	jalr	-452(ra) # 80003448 <_ZdlPv>
    80006614:	00048513          	mv	a0,s1
    80006618:	0000c097          	auipc	ra,0xc
    8000661c:	0f0080e7          	jalr	240(ra) # 80012708 <_Unwind_Resume>

0000000080006620 <_Z8userMainv>:

#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80006620:	ff010113          	addi	sp,sp,-16
    80006624:	00813423          	sd	s0,8(sp)
    80006628:	01010413          	addi	s0,sp,16
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

    8000662c:	00813403          	ld	s0,8(sp)
    80006630:	01010113          	addi	sp,sp,16
    80006634:	00008067          	ret

0000000080006638 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80006638:	ff010113          	addi	sp,sp,-16
    8000663c:	00113423          	sd	ra,8(sp)
    80006640:	00813023          	sd	s0,0(sp)
    80006644:	01010413          	addi	s0,sp,16
    80006648:	00007797          	auipc	a5,0x7
    8000664c:	b3078793          	addi	a5,a5,-1232 # 8000d178 <_ZTV7WorkerA+0x10>
    80006650:	00f53023          	sd	a5,0(a0)
    80006654:	ffffd097          	auipc	ra,0xffffd
    80006658:	d64080e7          	jalr	-668(ra) # 800033b8 <_ZN6ThreadD1Ev>
    8000665c:	00813083          	ld	ra,8(sp)
    80006660:	00013403          	ld	s0,0(sp)
    80006664:	01010113          	addi	sp,sp,16
    80006668:	00008067          	ret

000000008000666c <_ZN7WorkerAD0Ev>:
    8000666c:	fe010113          	addi	sp,sp,-32
    80006670:	00113c23          	sd	ra,24(sp)
    80006674:	00813823          	sd	s0,16(sp)
    80006678:	00913423          	sd	s1,8(sp)
    8000667c:	02010413          	addi	s0,sp,32
    80006680:	00050493          	mv	s1,a0
    80006684:	00007797          	auipc	a5,0x7
    80006688:	af478793          	addi	a5,a5,-1292 # 8000d178 <_ZTV7WorkerA+0x10>
    8000668c:	00f53023          	sd	a5,0(a0)
    80006690:	ffffd097          	auipc	ra,0xffffd
    80006694:	d28080e7          	jalr	-728(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006698:	00048513          	mv	a0,s1
    8000669c:	ffffd097          	auipc	ra,0xffffd
    800066a0:	dac080e7          	jalr	-596(ra) # 80003448 <_ZdlPv>
    800066a4:	01813083          	ld	ra,24(sp)
    800066a8:	01013403          	ld	s0,16(sp)
    800066ac:	00813483          	ld	s1,8(sp)
    800066b0:	02010113          	addi	sp,sp,32
    800066b4:	00008067          	ret

00000000800066b8 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800066b8:	ff010113          	addi	sp,sp,-16
    800066bc:	00113423          	sd	ra,8(sp)
    800066c0:	00813023          	sd	s0,0(sp)
    800066c4:	01010413          	addi	s0,sp,16
    800066c8:	00007797          	auipc	a5,0x7
    800066cc:	ad878793          	addi	a5,a5,-1320 # 8000d1a0 <_ZTV7WorkerB+0x10>
    800066d0:	00f53023          	sd	a5,0(a0)
    800066d4:	ffffd097          	auipc	ra,0xffffd
    800066d8:	ce4080e7          	jalr	-796(ra) # 800033b8 <_ZN6ThreadD1Ev>
    800066dc:	00813083          	ld	ra,8(sp)
    800066e0:	00013403          	ld	s0,0(sp)
    800066e4:	01010113          	addi	sp,sp,16
    800066e8:	00008067          	ret

00000000800066ec <_ZN7WorkerBD0Ev>:
    800066ec:	fe010113          	addi	sp,sp,-32
    800066f0:	00113c23          	sd	ra,24(sp)
    800066f4:	00813823          	sd	s0,16(sp)
    800066f8:	00913423          	sd	s1,8(sp)
    800066fc:	02010413          	addi	s0,sp,32
    80006700:	00050493          	mv	s1,a0
    80006704:	00007797          	auipc	a5,0x7
    80006708:	a9c78793          	addi	a5,a5,-1380 # 8000d1a0 <_ZTV7WorkerB+0x10>
    8000670c:	00f53023          	sd	a5,0(a0)
    80006710:	ffffd097          	auipc	ra,0xffffd
    80006714:	ca8080e7          	jalr	-856(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006718:	00048513          	mv	a0,s1
    8000671c:	ffffd097          	auipc	ra,0xffffd
    80006720:	d2c080e7          	jalr	-724(ra) # 80003448 <_ZdlPv>
    80006724:	01813083          	ld	ra,24(sp)
    80006728:	01013403          	ld	s0,16(sp)
    8000672c:	00813483          	ld	s1,8(sp)
    80006730:	02010113          	addi	sp,sp,32
    80006734:	00008067          	ret

0000000080006738 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80006738:	ff010113          	addi	sp,sp,-16
    8000673c:	00113423          	sd	ra,8(sp)
    80006740:	00813023          	sd	s0,0(sp)
    80006744:	01010413          	addi	s0,sp,16
    80006748:	00007797          	auipc	a5,0x7
    8000674c:	a8078793          	addi	a5,a5,-1408 # 8000d1c8 <_ZTV7WorkerC+0x10>
    80006750:	00f53023          	sd	a5,0(a0)
    80006754:	ffffd097          	auipc	ra,0xffffd
    80006758:	c64080e7          	jalr	-924(ra) # 800033b8 <_ZN6ThreadD1Ev>
    8000675c:	00813083          	ld	ra,8(sp)
    80006760:	00013403          	ld	s0,0(sp)
    80006764:	01010113          	addi	sp,sp,16
    80006768:	00008067          	ret

000000008000676c <_ZN7WorkerCD0Ev>:
    8000676c:	fe010113          	addi	sp,sp,-32
    80006770:	00113c23          	sd	ra,24(sp)
    80006774:	00813823          	sd	s0,16(sp)
    80006778:	00913423          	sd	s1,8(sp)
    8000677c:	02010413          	addi	s0,sp,32
    80006780:	00050493          	mv	s1,a0
    80006784:	00007797          	auipc	a5,0x7
    80006788:	a4478793          	addi	a5,a5,-1468 # 8000d1c8 <_ZTV7WorkerC+0x10>
    8000678c:	00f53023          	sd	a5,0(a0)
    80006790:	ffffd097          	auipc	ra,0xffffd
    80006794:	c28080e7          	jalr	-984(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006798:	00048513          	mv	a0,s1
    8000679c:	ffffd097          	auipc	ra,0xffffd
    800067a0:	cac080e7          	jalr	-852(ra) # 80003448 <_ZdlPv>
    800067a4:	01813083          	ld	ra,24(sp)
    800067a8:	01013403          	ld	s0,16(sp)
    800067ac:	00813483          	ld	s1,8(sp)
    800067b0:	02010113          	addi	sp,sp,32
    800067b4:	00008067          	ret

00000000800067b8 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800067b8:	ff010113          	addi	sp,sp,-16
    800067bc:	00113423          	sd	ra,8(sp)
    800067c0:	00813023          	sd	s0,0(sp)
    800067c4:	01010413          	addi	s0,sp,16
    800067c8:	00007797          	auipc	a5,0x7
    800067cc:	a2878793          	addi	a5,a5,-1496 # 8000d1f0 <_ZTV7WorkerD+0x10>
    800067d0:	00f53023          	sd	a5,0(a0)
    800067d4:	ffffd097          	auipc	ra,0xffffd
    800067d8:	be4080e7          	jalr	-1052(ra) # 800033b8 <_ZN6ThreadD1Ev>
    800067dc:	00813083          	ld	ra,8(sp)
    800067e0:	00013403          	ld	s0,0(sp)
    800067e4:	01010113          	addi	sp,sp,16
    800067e8:	00008067          	ret

00000000800067ec <_ZN7WorkerDD0Ev>:
    800067ec:	fe010113          	addi	sp,sp,-32
    800067f0:	00113c23          	sd	ra,24(sp)
    800067f4:	00813823          	sd	s0,16(sp)
    800067f8:	00913423          	sd	s1,8(sp)
    800067fc:	02010413          	addi	s0,sp,32
    80006800:	00050493          	mv	s1,a0
    80006804:	00007797          	auipc	a5,0x7
    80006808:	9ec78793          	addi	a5,a5,-1556 # 8000d1f0 <_ZTV7WorkerD+0x10>
    8000680c:	00f53023          	sd	a5,0(a0)
    80006810:	ffffd097          	auipc	ra,0xffffd
    80006814:	ba8080e7          	jalr	-1112(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006818:	00048513          	mv	a0,s1
    8000681c:	ffffd097          	auipc	ra,0xffffd
    80006820:	c2c080e7          	jalr	-980(ra) # 80003448 <_ZdlPv>
    80006824:	01813083          	ld	ra,24(sp)
    80006828:	01013403          	ld	s0,16(sp)
    8000682c:	00813483          	ld	s1,8(sp)
    80006830:	02010113          	addi	sp,sp,32
    80006834:	00008067          	ret

0000000080006838 <_ZN8ConsumerD1Ev>:
class Consumer:public Thread {
    80006838:	ff010113          	addi	sp,sp,-16
    8000683c:	00113423          	sd	ra,8(sp)
    80006840:	00813023          	sd	s0,0(sp)
    80006844:	01010413          	addi	s0,sp,16
    80006848:	00007797          	auipc	a5,0x7
    8000684c:	a2078793          	addi	a5,a5,-1504 # 8000d268 <_ZTV8Consumer+0x10>
    80006850:	00f53023          	sd	a5,0(a0)
    80006854:	ffffd097          	auipc	ra,0xffffd
    80006858:	b64080e7          	jalr	-1180(ra) # 800033b8 <_ZN6ThreadD1Ev>
    8000685c:	00813083          	ld	ra,8(sp)
    80006860:	00013403          	ld	s0,0(sp)
    80006864:	01010113          	addi	sp,sp,16
    80006868:	00008067          	ret

000000008000686c <_ZN8ConsumerD0Ev>:
    8000686c:	fe010113          	addi	sp,sp,-32
    80006870:	00113c23          	sd	ra,24(sp)
    80006874:	00813823          	sd	s0,16(sp)
    80006878:	00913423          	sd	s1,8(sp)
    8000687c:	02010413          	addi	s0,sp,32
    80006880:	00050493          	mv	s1,a0
    80006884:	00007797          	auipc	a5,0x7
    80006888:	9e478793          	addi	a5,a5,-1564 # 8000d268 <_ZTV8Consumer+0x10>
    8000688c:	00f53023          	sd	a5,0(a0)
    80006890:	ffffd097          	auipc	ra,0xffffd
    80006894:	b28080e7          	jalr	-1240(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006898:	00048513          	mv	a0,s1
    8000689c:	ffffd097          	auipc	ra,0xffffd
    800068a0:	bac080e7          	jalr	-1108(ra) # 80003448 <_ZdlPv>
    800068a4:	01813083          	ld	ra,24(sp)
    800068a8:	01013403          	ld	s0,16(sp)
    800068ac:	00813483          	ld	s1,8(sp)
    800068b0:	02010113          	addi	sp,sp,32
    800068b4:	00008067          	ret

00000000800068b8 <_ZN8ProducerD1Ev>:
class Producer:public Thread {
    800068b8:	ff010113          	addi	sp,sp,-16
    800068bc:	00113423          	sd	ra,8(sp)
    800068c0:	00813023          	sd	s0,0(sp)
    800068c4:	01010413          	addi	s0,sp,16
    800068c8:	00007797          	auipc	a5,0x7
    800068cc:	97878793          	addi	a5,a5,-1672 # 8000d240 <_ZTV8Producer+0x10>
    800068d0:	00f53023          	sd	a5,0(a0)
    800068d4:	ffffd097          	auipc	ra,0xffffd
    800068d8:	ae4080e7          	jalr	-1308(ra) # 800033b8 <_ZN6ThreadD1Ev>
    800068dc:	00813083          	ld	ra,8(sp)
    800068e0:	00013403          	ld	s0,0(sp)
    800068e4:	01010113          	addi	sp,sp,16
    800068e8:	00008067          	ret

00000000800068ec <_ZN8ProducerD0Ev>:
    800068ec:	fe010113          	addi	sp,sp,-32
    800068f0:	00113c23          	sd	ra,24(sp)
    800068f4:	00813823          	sd	s0,16(sp)
    800068f8:	00913423          	sd	s1,8(sp)
    800068fc:	02010413          	addi	s0,sp,32
    80006900:	00050493          	mv	s1,a0
    80006904:	00007797          	auipc	a5,0x7
    80006908:	93c78793          	addi	a5,a5,-1732 # 8000d240 <_ZTV8Producer+0x10>
    8000690c:	00f53023          	sd	a5,0(a0)
    80006910:	ffffd097          	auipc	ra,0xffffd
    80006914:	aa8080e7          	jalr	-1368(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006918:	00048513          	mv	a0,s1
    8000691c:	ffffd097          	auipc	ra,0xffffd
    80006920:	b2c080e7          	jalr	-1236(ra) # 80003448 <_ZdlPv>
    80006924:	01813083          	ld	ra,24(sp)
    80006928:	01013403          	ld	s0,16(sp)
    8000692c:	00813483          	ld	s1,8(sp)
    80006930:	02010113          	addi	sp,sp,32
    80006934:	00008067          	ret

0000000080006938 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80006938:	ff010113          	addi	sp,sp,-16
    8000693c:	00113423          	sd	ra,8(sp)
    80006940:	00813023          	sd	s0,0(sp)
    80006944:	01010413          	addi	s0,sp,16
    80006948:	00007797          	auipc	a5,0x7
    8000694c:	8d078793          	addi	a5,a5,-1840 # 8000d218 <_ZTV16ProducerKeyboard+0x10>
    80006950:	00f53023          	sd	a5,0(a0)
    80006954:	ffffd097          	auipc	ra,0xffffd
    80006958:	a64080e7          	jalr	-1436(ra) # 800033b8 <_ZN6ThreadD1Ev>
    8000695c:	00813083          	ld	ra,8(sp)
    80006960:	00013403          	ld	s0,0(sp)
    80006964:	01010113          	addi	sp,sp,16
    80006968:	00008067          	ret

000000008000696c <_ZN16ProducerKeyboardD0Ev>:
    8000696c:	fe010113          	addi	sp,sp,-32
    80006970:	00113c23          	sd	ra,24(sp)
    80006974:	00813823          	sd	s0,16(sp)
    80006978:	00913423          	sd	s1,8(sp)
    8000697c:	02010413          	addi	s0,sp,32
    80006980:	00050493          	mv	s1,a0
    80006984:	00007797          	auipc	a5,0x7
    80006988:	89478793          	addi	a5,a5,-1900 # 8000d218 <_ZTV16ProducerKeyboard+0x10>
    8000698c:	00f53023          	sd	a5,0(a0)
    80006990:	ffffd097          	auipc	ra,0xffffd
    80006994:	a28080e7          	jalr	-1496(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006998:	00048513          	mv	a0,s1
    8000699c:	ffffd097          	auipc	ra,0xffffd
    800069a0:	aac080e7          	jalr	-1364(ra) # 80003448 <_ZdlPv>
    800069a4:	01813083          	ld	ra,24(sp)
    800069a8:	01013403          	ld	s0,16(sp)
    800069ac:	00813483          	ld	s1,8(sp)
    800069b0:	02010113          	addi	sp,sp,32
    800069b4:	00008067          	ret

00000000800069b8 <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    800069b8:	ff010113          	addi	sp,sp,-16
    800069bc:	00113423          	sd	ra,8(sp)
    800069c0:	00813023          	sd	s0,0(sp)
    800069c4:	01010413          	addi	s0,sp,16
    800069c8:	00007797          	auipc	a5,0x7
    800069cc:	91878793          	addi	a5,a5,-1768 # 8000d2e0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800069d0:	00f53023          	sd	a5,0(a0)
    800069d4:	ffffd097          	auipc	ra,0xffffd
    800069d8:	9e4080e7          	jalr	-1564(ra) # 800033b8 <_ZN6ThreadD1Ev>
    800069dc:	00813083          	ld	ra,8(sp)
    800069e0:	00013403          	ld	s0,0(sp)
    800069e4:	01010113          	addi	sp,sp,16
    800069e8:	00008067          	ret

00000000800069ec <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    800069ec:	fe010113          	addi	sp,sp,-32
    800069f0:	00113c23          	sd	ra,24(sp)
    800069f4:	00813823          	sd	s0,16(sp)
    800069f8:	00913423          	sd	s1,8(sp)
    800069fc:	02010413          	addi	s0,sp,32
    80006a00:	00050493          	mv	s1,a0
    80006a04:	00007797          	auipc	a5,0x7
    80006a08:	8dc78793          	addi	a5,a5,-1828 # 8000d2e0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80006a0c:	00f53023          	sd	a5,0(a0)
    80006a10:	ffffd097          	auipc	ra,0xffffd
    80006a14:	9a8080e7          	jalr	-1624(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006a18:	00048513          	mv	a0,s1
    80006a1c:	ffffd097          	auipc	ra,0xffffd
    80006a20:	a2c080e7          	jalr	-1492(ra) # 80003448 <_ZdlPv>
    80006a24:	01813083          	ld	ra,24(sp)
    80006a28:	01013403          	ld	s0,16(sp)
    80006a2c:	00813483          	ld	s1,8(sp)
    80006a30:	02010113          	addi	sp,sp,32
    80006a34:	00008067          	ret

0000000080006a38 <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    80006a38:	ff010113          	addi	sp,sp,-16
    80006a3c:	00113423          	sd	ra,8(sp)
    80006a40:	00813023          	sd	s0,0(sp)
    80006a44:	01010413          	addi	s0,sp,16
    80006a48:	00007797          	auipc	a5,0x7
    80006a4c:	84878793          	addi	a5,a5,-1976 # 8000d290 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006a50:	00f53023          	sd	a5,0(a0)
    80006a54:	ffffd097          	auipc	ra,0xffffd
    80006a58:	964080e7          	jalr	-1692(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006a5c:	00813083          	ld	ra,8(sp)
    80006a60:	00013403          	ld	s0,0(sp)
    80006a64:	01010113          	addi	sp,sp,16
    80006a68:	00008067          	ret

0000000080006a6c <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80006a6c:	fe010113          	addi	sp,sp,-32
    80006a70:	00113c23          	sd	ra,24(sp)
    80006a74:	00813823          	sd	s0,16(sp)
    80006a78:	00913423          	sd	s1,8(sp)
    80006a7c:	02010413          	addi	s0,sp,32
    80006a80:	00050493          	mv	s1,a0
    80006a84:	00007797          	auipc	a5,0x7
    80006a88:	80c78793          	addi	a5,a5,-2036 # 8000d290 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80006a8c:	00f53023          	sd	a5,0(a0)
    80006a90:	ffffd097          	auipc	ra,0xffffd
    80006a94:	928080e7          	jalr	-1752(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006a98:	00048513          	mv	a0,s1
    80006a9c:	ffffd097          	auipc	ra,0xffffd
    80006aa0:	9ac080e7          	jalr	-1620(ra) # 80003448 <_ZdlPv>
    80006aa4:	01813083          	ld	ra,24(sp)
    80006aa8:	01013403          	ld	s0,16(sp)
    80006aac:	00813483          	ld	s1,8(sp)
    80006ab0:	02010113          	addi	sp,sp,32
    80006ab4:	00008067          	ret

0000000080006ab8 <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    80006ab8:	ff010113          	addi	sp,sp,-16
    80006abc:	00113423          	sd	ra,8(sp)
    80006ac0:	00813023          	sd	s0,0(sp)
    80006ac4:	01010413          	addi	s0,sp,16
    80006ac8:	00006797          	auipc	a5,0x6
    80006acc:	7f078793          	addi	a5,a5,2032 # 8000d2b8 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006ad0:	00f53023          	sd	a5,0(a0)
    80006ad4:	ffffd097          	auipc	ra,0xffffd
    80006ad8:	8e4080e7          	jalr	-1820(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006adc:	00813083          	ld	ra,8(sp)
    80006ae0:	00013403          	ld	s0,0(sp)
    80006ae4:	01010113          	addi	sp,sp,16
    80006ae8:	00008067          	ret

0000000080006aec <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80006aec:	fe010113          	addi	sp,sp,-32
    80006af0:	00113c23          	sd	ra,24(sp)
    80006af4:	00813823          	sd	s0,16(sp)
    80006af8:	00913423          	sd	s1,8(sp)
    80006afc:	02010413          	addi	s0,sp,32
    80006b00:	00050493          	mv	s1,a0
    80006b04:	00006797          	auipc	a5,0x6
    80006b08:	7b478793          	addi	a5,a5,1972 # 8000d2b8 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80006b0c:	00f53023          	sd	a5,0(a0)
    80006b10:	ffffd097          	auipc	ra,0xffffd
    80006b14:	8a8080e7          	jalr	-1880(ra) # 800033b8 <_ZN6ThreadD1Ev>
    80006b18:	00048513          	mv	a0,s1
    80006b1c:	ffffd097          	auipc	ra,0xffffd
    80006b20:	92c080e7          	jalr	-1748(ra) # 80003448 <_ZdlPv>
    80006b24:	01813083          	ld	ra,24(sp)
    80006b28:	01013403          	ld	s0,16(sp)
    80006b2c:	00813483          	ld	s1,8(sp)
    80006b30:	02010113          	addi	sp,sp,32
    80006b34:	00008067          	ret

0000000080006b38 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    80006b38:	fe010113          	addi	sp,sp,-32
    80006b3c:	00113c23          	sd	ra,24(sp)
    80006b40:	00813823          	sd	s0,16(sp)
    80006b44:	00913423          	sd	s1,8(sp)
    80006b48:	02010413          	addi	s0,sp,32
    80006b4c:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    80006b50:	ffffb097          	auipc	ra,0xffffb
    80006b54:	430080e7          	jalr	1072(ra) # 80001f80 <_Z4getcv>
    80006b58:	0005059b          	sext.w	a1,a0
    80006b5c:	01b00793          	li	a5,27
    80006b60:	00f58c63          	beq	a1,a5,80006b78 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    80006b64:	0104b783          	ld	a5,16(s1)
    80006b68:	0087b503          	ld	a0,8(a5)
    80006b6c:	ffffe097          	auipc	ra,0xffffe
    80006b70:	544080e7          	jalr	1348(ra) # 800050b0 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80006b74:	fddff06f          	j	80006b50 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    80006b78:	00100793          	li	a5,1
    80006b7c:	0000b717          	auipc	a4,0xb
    80006b80:	a8f72e23          	sw	a5,-1380(a4) # 80011618 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80006b84:	0104b783          	ld	a5,16(s1)
    80006b88:	02100593          	li	a1,33
    80006b8c:	0087b503          	ld	a0,8(a5)
    80006b90:	ffffe097          	auipc	ra,0xffffe
    80006b94:	520080e7          	jalr	1312(ra) # 800050b0 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    80006b98:	0104b783          	ld	a5,16(s1)
    80006b9c:	0107b503          	ld	a0,16(a5)
    80006ba0:	ffffd097          	auipc	ra,0xffffd
    80006ba4:	9b4080e7          	jalr	-1612(ra) # 80003554 <_ZN9Semaphore6signalEv>
        }
    80006ba8:	01813083          	ld	ra,24(sp)
    80006bac:	01013403          	ld	s0,16(sp)
    80006bb0:	00813483          	ld	s1,8(sp)
    80006bb4:	02010113          	addi	sp,sp,32
    80006bb8:	00008067          	ret

0000000080006bbc <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    80006bbc:	fd010113          	addi	sp,sp,-48
    80006bc0:	02113423          	sd	ra,40(sp)
    80006bc4:	02813023          	sd	s0,32(sp)
    80006bc8:	00913c23          	sd	s1,24(sp)
    80006bcc:	01213823          	sd	s2,16(sp)
    80006bd0:	01313423          	sd	s3,8(sp)
    80006bd4:	03010413          	addi	s0,sp,48
    80006bd8:	00050913          	mv	s2,a0
            int i = 0;
    80006bdc:	00000993          	li	s3,0
    80006be0:	0100006f          	j	80006bf0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    80006be4:	00a00513          	li	a0,10
    80006be8:	ffffd097          	auipc	ra,0xffffd
    80006bec:	b68080e7          	jalr	-1176(ra) # 80003750 <_ZN7Console4putcEc>
            while (!threadEnd) {
    80006bf0:	0000b797          	auipc	a5,0xb
    80006bf4:	a287a783          	lw	a5,-1496(a5) # 80011618 <_ZN19ConsumerProducerCPP9threadEndE>
    80006bf8:	04079a63          	bnez	a5,80006c4c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    80006bfc:	01093783          	ld	a5,16(s2)
    80006c00:	0087b503          	ld	a0,8(a5)
    80006c04:	ffffe097          	auipc	ra,0xffffe
    80006c08:	53c080e7          	jalr	1340(ra) # 80005140 <_ZN9BufferCPP3getEv>
                i++;
    80006c0c:	0019849b          	addiw	s1,s3,1
    80006c10:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    80006c14:	0ff57513          	andi	a0,a0,255
    80006c18:	ffffd097          	auipc	ra,0xffffd
    80006c1c:	b38080e7          	jalr	-1224(ra) # 80003750 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    80006c20:	05000793          	li	a5,80
    80006c24:	02f4e4bb          	remw	s1,s1,a5
    80006c28:	fc0494e3          	bnez	s1,80006bf0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    80006c2c:	fb9ff06f          	j	80006be4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    80006c30:	01093783          	ld	a5,16(s2)
    80006c34:	0087b503          	ld	a0,8(a5)
    80006c38:	ffffe097          	auipc	ra,0xffffe
    80006c3c:	508080e7          	jalr	1288(ra) # 80005140 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80006c40:	0ff57513          	andi	a0,a0,255
    80006c44:	ffffd097          	auipc	ra,0xffffd
    80006c48:	b0c080e7          	jalr	-1268(ra) # 80003750 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    80006c4c:	01093783          	ld	a5,16(s2)
    80006c50:	0087b503          	ld	a0,8(a5)
    80006c54:	ffffe097          	auipc	ra,0xffffe
    80006c58:	578080e7          	jalr	1400(ra) # 800051cc <_ZN9BufferCPP6getCntEv>
    80006c5c:	fca04ae3          	bgtz	a0,80006c30 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80006c60:	01093783          	ld	a5,16(s2)
    80006c64:	0107b503          	ld	a0,16(a5)
    80006c68:	ffffd097          	auipc	ra,0xffffd
    80006c6c:	8ec080e7          	jalr	-1812(ra) # 80003554 <_ZN9Semaphore6signalEv>
        }
    80006c70:	02813083          	ld	ra,40(sp)
    80006c74:	02013403          	ld	s0,32(sp)
    80006c78:	01813483          	ld	s1,24(sp)
    80006c7c:	01013903          	ld	s2,16(sp)
    80006c80:	00813983          	ld	s3,8(sp)
    80006c84:	03010113          	addi	sp,sp,48
    80006c88:	00008067          	ret

0000000080006c8c <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80006c8c:	fe010113          	addi	sp,sp,-32
    80006c90:	00113c23          	sd	ra,24(sp)
    80006c94:	00813823          	sd	s0,16(sp)
    80006c98:	00913423          	sd	s1,8(sp)
    80006c9c:	01213023          	sd	s2,0(sp)
    80006ca0:	02010413          	addi	s0,sp,32
    80006ca4:	00050493          	mv	s1,a0
            int i = 0;
    80006ca8:	00000913          	li	s2,0
            while (!threadEnd) {
    80006cac:	0000b797          	auipc	a5,0xb
    80006cb0:	96c7a783          	lw	a5,-1684(a5) # 80011618 <_ZN19ConsumerProducerCPP9threadEndE>
    80006cb4:	04079263          	bnez	a5,80006cf8 <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    80006cb8:	0104b783          	ld	a5,16(s1)
    80006cbc:	0007a583          	lw	a1,0(a5)
    80006cc0:	0305859b          	addiw	a1,a1,48
    80006cc4:	0087b503          	ld	a0,8(a5)
    80006cc8:	ffffe097          	auipc	ra,0xffffe
    80006ccc:	3e8080e7          	jalr	1000(ra) # 800050b0 <_ZN9BufferCPP3putEi>
                i++;
    80006cd0:	0019071b          	addiw	a4,s2,1
    80006cd4:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    80006cd8:	0104b783          	ld	a5,16(s1)
    80006cdc:	0007a783          	lw	a5,0(a5)
    80006ce0:	00e787bb          	addw	a5,a5,a4
    80006ce4:	00500513          	li	a0,5
    80006ce8:	02a7e53b          	remw	a0,a5,a0
    80006cec:	ffffd097          	auipc	ra,0xffffd
    80006cf0:	910080e7          	jalr	-1776(ra) # 800035fc <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    80006cf4:	fb9ff06f          	j	80006cac <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    80006cf8:	0104b783          	ld	a5,16(s1)
    80006cfc:	0107b503          	ld	a0,16(a5)
    80006d00:	ffffd097          	auipc	ra,0xffffd
    80006d04:	854080e7          	jalr	-1964(ra) # 80003554 <_ZN9Semaphore6signalEv>
        }
    80006d08:	01813083          	ld	ra,24(sp)
    80006d0c:	01013403          	ld	s0,16(sp)
    80006d10:	00813483          	ld	s1,8(sp)
    80006d14:	00013903          	ld	s2,0(sp)
    80006d18:	02010113          	addi	sp,sp,32
    80006d1c:	00008067          	ret

0000000080006d20 <_ZN7WorkerA3runEv>:
    void run() override {
    80006d20:	ff010113          	addi	sp,sp,-16
    80006d24:	00113423          	sd	ra,8(sp)
    80006d28:	00813023          	sd	s0,0(sp)
    80006d2c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80006d30:	00000593          	li	a1,0
    80006d34:	ffffe097          	auipc	ra,0xffffe
    80006d38:	738080e7          	jalr	1848(ra) # 8000546c <_ZN7WorkerA11workerBodyAEPv>
    }
    80006d3c:	00813083          	ld	ra,8(sp)
    80006d40:	00013403          	ld	s0,0(sp)
    80006d44:	01010113          	addi	sp,sp,16
    80006d48:	00008067          	ret

0000000080006d4c <_ZN7WorkerB3runEv>:
    void run() override {
    80006d4c:	ff010113          	addi	sp,sp,-16
    80006d50:	00113423          	sd	ra,8(sp)
    80006d54:	00813023          	sd	s0,0(sp)
    80006d58:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80006d5c:	00000593          	li	a1,0
    80006d60:	ffffe097          	auipc	ra,0xffffe
    80006d64:	7d8080e7          	jalr	2008(ra) # 80005538 <_ZN7WorkerB11workerBodyBEPv>
    }
    80006d68:	00813083          	ld	ra,8(sp)
    80006d6c:	00013403          	ld	s0,0(sp)
    80006d70:	01010113          	addi	sp,sp,16
    80006d74:	00008067          	ret

0000000080006d78 <_ZN7WorkerC3runEv>:
    void run() override {
    80006d78:	ff010113          	addi	sp,sp,-16
    80006d7c:	00113423          	sd	ra,8(sp)
    80006d80:	00813023          	sd	s0,0(sp)
    80006d84:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80006d88:	00000593          	li	a1,0
    80006d8c:	fffff097          	auipc	ra,0xfffff
    80006d90:	880080e7          	jalr	-1920(ra) # 8000560c <_ZN7WorkerC11workerBodyCEPv>
    }
    80006d94:	00813083          	ld	ra,8(sp)
    80006d98:	00013403          	ld	s0,0(sp)
    80006d9c:	01010113          	addi	sp,sp,16
    80006da0:	00008067          	ret

0000000080006da4 <_ZN7WorkerD3runEv>:
    void run() override {
    80006da4:	ff010113          	addi	sp,sp,-16
    80006da8:	00113423          	sd	ra,8(sp)
    80006dac:	00813023          	sd	s0,0(sp)
    80006db0:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80006db4:	00000593          	li	a1,0
    80006db8:	fffff097          	auipc	ra,0xfffff
    80006dbc:	9d4080e7          	jalr	-1580(ra) # 8000578c <_ZN7WorkerD11workerBodyDEPv>
    }
    80006dc0:	00813083          	ld	ra,8(sp)
    80006dc4:	00013403          	ld	s0,0(sp)
    80006dc8:	01010113          	addi	sp,sp,16
    80006dcc:	00008067          	ret

0000000080006dd0 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80006dd0:	ff010113          	addi	sp,sp,-16
    80006dd4:	00113423          	sd	ra,8(sp)
    80006dd8:	00813023          	sd	s0,0(sp)
    80006ddc:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80006de0:	01053583          	ld	a1,16(a0)
    80006de4:	fffff097          	auipc	ra,0xfffff
    80006de8:	d00080e7          	jalr	-768(ra) # 80005ae4 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80006dec:	00813083          	ld	ra,8(sp)
    80006df0:	00013403          	ld	s0,0(sp)
    80006df4:	01010113          	addi	sp,sp,16
    80006df8:	00008067          	ret

0000000080006dfc <_ZN8Producer3runEv>:
    void run() override {
    80006dfc:	ff010113          	addi	sp,sp,-16
    80006e00:	00113423          	sd	ra,8(sp)
    80006e04:	00813023          	sd	s0,0(sp)
    80006e08:	01010413          	addi	s0,sp,16
        producer(td);
    80006e0c:	01053583          	ld	a1,16(a0)
    80006e10:	fffff097          	auipc	ra,0xfffff
    80006e14:	d94080e7          	jalr	-620(ra) # 80005ba4 <_ZN8Producer8producerEPv>
    }
    80006e18:	00813083          	ld	ra,8(sp)
    80006e1c:	00013403          	ld	s0,0(sp)
    80006e20:	01010113          	addi	sp,sp,16
    80006e24:	00008067          	ret

0000000080006e28 <_ZN8Consumer3runEv>:
    void run() override {
    80006e28:	ff010113          	addi	sp,sp,-16
    80006e2c:	00113423          	sd	ra,8(sp)
    80006e30:	00813023          	sd	s0,0(sp)
    80006e34:	01010413          	addi	s0,sp,16
        consumer(td);
    80006e38:	01053583          	ld	a1,16(a0)
    80006e3c:	fffff097          	auipc	ra,0xfffff
    80006e40:	dfc080e7          	jalr	-516(ra) # 80005c38 <_ZN8Consumer8consumerEPv>
    }
    80006e44:	00813083          	ld	ra,8(sp)
    80006e48:	00013403          	ld	s0,0(sp)
    80006e4c:	01010113          	addi	sp,sp,16
    80006e50:	00008067          	ret

0000000080006e54 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006e54:	fe010113          	addi	sp,sp,-32
    80006e58:	00113c23          	sd	ra,24(sp)
    80006e5c:	00813823          	sd	s0,16(sp)
    80006e60:	00913423          	sd	s1,8(sp)
    80006e64:	01213023          	sd	s2,0(sp)
    80006e68:	02010413          	addi	s0,sp,32
    80006e6c:	00050493          	mv	s1,a0
    80006e70:	00058913          	mv	s2,a1
    80006e74:	0015879b          	addiw	a5,a1,1
    80006e78:	0007851b          	sext.w	a0,a5
    80006e7c:	00f4a023          	sw	a5,0(s1)
    80006e80:	0004a823          	sw	zero,16(s1)
    80006e84:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006e88:	00251513          	slli	a0,a0,0x2
    80006e8c:	ffffb097          	auipc	ra,0xffffb
    80006e90:	e44080e7          	jalr	-444(ra) # 80001cd0 <_Z9mem_allocm>
    80006e94:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006e98:	00000593          	li	a1,0
    80006e9c:	02048513          	addi	a0,s1,32
    80006ea0:	ffffb097          	auipc	ra,0xffffb
    80006ea4:	ff8080e7          	jalr	-8(ra) # 80001e98 <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80006ea8:	00090593          	mv	a1,s2
    80006eac:	01848513          	addi	a0,s1,24
    80006eb0:	ffffb097          	auipc	ra,0xffffb
    80006eb4:	fe8080e7          	jalr	-24(ra) # 80001e98 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80006eb8:	00100593          	li	a1,1
    80006ebc:	02848513          	addi	a0,s1,40
    80006ec0:	ffffb097          	auipc	ra,0xffffb
    80006ec4:	fd8080e7          	jalr	-40(ra) # 80001e98 <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80006ec8:	00100593          	li	a1,1
    80006ecc:	03048513          	addi	a0,s1,48
    80006ed0:	ffffb097          	auipc	ra,0xffffb
    80006ed4:	fc8080e7          	jalr	-56(ra) # 80001e98 <_Z8sem_openPP10_semaphorej>
}
    80006ed8:	01813083          	ld	ra,24(sp)
    80006edc:	01013403          	ld	s0,16(sp)
    80006ee0:	00813483          	ld	s1,8(sp)
    80006ee4:	00013903          	ld	s2,0(sp)
    80006ee8:	02010113          	addi	sp,sp,32
    80006eec:	00008067          	ret

0000000080006ef0 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80006ef0:	fe010113          	addi	sp,sp,-32
    80006ef4:	00113c23          	sd	ra,24(sp)
    80006ef8:	00813823          	sd	s0,16(sp)
    80006efc:	00913423          	sd	s1,8(sp)
    80006f00:	01213023          	sd	s2,0(sp)
    80006f04:	02010413          	addi	s0,sp,32
    80006f08:	00050493          	mv	s1,a0
    80006f0c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80006f10:	01853503          	ld	a0,24(a0)
    80006f14:	ffffb097          	auipc	ra,0xffffb
    80006f18:	fe8080e7          	jalr	-24(ra) # 80001efc <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    80006f1c:	0304b503          	ld	a0,48(s1)
    80006f20:	ffffb097          	auipc	ra,0xffffb
    80006f24:	fdc080e7          	jalr	-36(ra) # 80001efc <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80006f28:	0084b783          	ld	a5,8(s1)
    80006f2c:	0144a703          	lw	a4,20(s1)
    80006f30:	00271713          	slli	a4,a4,0x2
    80006f34:	00e787b3          	add	a5,a5,a4
    80006f38:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006f3c:	0144a783          	lw	a5,20(s1)
    80006f40:	0017879b          	addiw	a5,a5,1
    80006f44:	0004a703          	lw	a4,0(s1)
    80006f48:	02e7e7bb          	remw	a5,a5,a4
    80006f4c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006f50:	0304b503          	ld	a0,48(s1)
    80006f54:	ffffb097          	auipc	ra,0xffffb
    80006f58:	fd4080e7          	jalr	-44(ra) # 80001f28 <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    80006f5c:	0204b503          	ld	a0,32(s1)
    80006f60:	ffffb097          	auipc	ra,0xffffb
    80006f64:	fc8080e7          	jalr	-56(ra) # 80001f28 <_Z10sem_signalP10_semaphore>

}
    80006f68:	01813083          	ld	ra,24(sp)
    80006f6c:	01013403          	ld	s0,16(sp)
    80006f70:	00813483          	ld	s1,8(sp)
    80006f74:	00013903          	ld	s2,0(sp)
    80006f78:	02010113          	addi	sp,sp,32
    80006f7c:	00008067          	ret

0000000080006f80 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006f80:	fe010113          	addi	sp,sp,-32
    80006f84:	00113c23          	sd	ra,24(sp)
    80006f88:	00813823          	sd	s0,16(sp)
    80006f8c:	00913423          	sd	s1,8(sp)
    80006f90:	01213023          	sd	s2,0(sp)
    80006f94:	02010413          	addi	s0,sp,32
    80006f98:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006f9c:	02053503          	ld	a0,32(a0)
    80006fa0:	ffffb097          	auipc	ra,0xffffb
    80006fa4:	f5c080e7          	jalr	-164(ra) # 80001efc <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80006fa8:	0284b503          	ld	a0,40(s1)
    80006fac:	ffffb097          	auipc	ra,0xffffb
    80006fb0:	f50080e7          	jalr	-176(ra) # 80001efc <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80006fb4:	0084b703          	ld	a4,8(s1)
    80006fb8:	0104a783          	lw	a5,16(s1)
    80006fbc:	00279693          	slli	a3,a5,0x2
    80006fc0:	00d70733          	add	a4,a4,a3
    80006fc4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006fc8:	0017879b          	addiw	a5,a5,1
    80006fcc:	0004a703          	lw	a4,0(s1)
    80006fd0:	02e7e7bb          	remw	a5,a5,a4
    80006fd4:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006fd8:	0284b503          	ld	a0,40(s1)
    80006fdc:	ffffb097          	auipc	ra,0xffffb
    80006fe0:	f4c080e7          	jalr	-180(ra) # 80001f28 <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80006fe4:	0184b503          	ld	a0,24(s1)
    80006fe8:	ffffb097          	auipc	ra,0xffffb
    80006fec:	f40080e7          	jalr	-192(ra) # 80001f28 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80006ff0:	00090513          	mv	a0,s2
    80006ff4:	01813083          	ld	ra,24(sp)
    80006ff8:	01013403          	ld	s0,16(sp)
    80006ffc:	00813483          	ld	s1,8(sp)
    80007000:	00013903          	ld	s2,0(sp)
    80007004:	02010113          	addi	sp,sp,32
    80007008:	00008067          	ret

000000008000700c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8000700c:	fe010113          	addi	sp,sp,-32
    80007010:	00113c23          	sd	ra,24(sp)
    80007014:	00813823          	sd	s0,16(sp)
    80007018:	00913423          	sd	s1,8(sp)
    8000701c:	01213023          	sd	s2,0(sp)
    80007020:	02010413          	addi	s0,sp,32
    80007024:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80007028:	02853503          	ld	a0,40(a0)
    8000702c:	ffffb097          	auipc	ra,0xffffb
    80007030:	ed0080e7          	jalr	-304(ra) # 80001efc <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80007034:	0304b503          	ld	a0,48(s1)
    80007038:	ffffb097          	auipc	ra,0xffffb
    8000703c:	ec4080e7          	jalr	-316(ra) # 80001efc <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80007040:	0144a783          	lw	a5,20(s1)
    80007044:	0104a903          	lw	s2,16(s1)
    80007048:	0327ce63          	blt	a5,s2,80007084 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8000704c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80007050:	0304b503          	ld	a0,48(s1)
    80007054:	ffffb097          	auipc	ra,0xffffb
    80007058:	ed4080e7          	jalr	-300(ra) # 80001f28 <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8000705c:	0284b503          	ld	a0,40(s1)
    80007060:	ffffb097          	auipc	ra,0xffffb
    80007064:	ec8080e7          	jalr	-312(ra) # 80001f28 <_Z10sem_signalP10_semaphore>

    return ret;
}
    80007068:	00090513          	mv	a0,s2
    8000706c:	01813083          	ld	ra,24(sp)
    80007070:	01013403          	ld	s0,16(sp)
    80007074:	00813483          	ld	s1,8(sp)
    80007078:	00013903          	ld	s2,0(sp)
    8000707c:	02010113          	addi	sp,sp,32
    80007080:	00008067          	ret
        ret = cap - head + tail;
    80007084:	0004a703          	lw	a4,0(s1)
    80007088:	4127093b          	subw	s2,a4,s2
    8000708c:	00f9093b          	addw	s2,s2,a5
    80007090:	fc1ff06f          	j	80007050 <_ZN6Buffer6getCntEv+0x44>

0000000080007094 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80007094:	fe010113          	addi	sp,sp,-32
    80007098:	00113c23          	sd	ra,24(sp)
    8000709c:	00813823          	sd	s0,16(sp)
    800070a0:	00913423          	sd	s1,8(sp)
    800070a4:	02010413          	addi	s0,sp,32
    800070a8:	00050493          	mv	s1,a0
    putc('\n');
    800070ac:	00a00513          	li	a0,10
    800070b0:	ffffb097          	auipc	ra,0xffffb
    800070b4:	ef8080e7          	jalr	-264(ra) # 80001fa8 <_Z4putcc>
    printString("Buffer deleted!\n");
    800070b8:	00003517          	auipc	a0,0x3
    800070bc:	45050513          	addi	a0,a0,1104 # 8000a508 <CONSOLE_STATUS+0x4f8>
    800070c0:	ffffb097          	auipc	ra,0xffffb
    800070c4:	60c080e7          	jalr	1548(ra) # 800026cc <_Z11printStringPKc>
    while (getCnt() > 0) {
    800070c8:	00048513          	mv	a0,s1
    800070cc:	00000097          	auipc	ra,0x0
    800070d0:	f40080e7          	jalr	-192(ra) # 8000700c <_ZN6Buffer6getCntEv>
    800070d4:	02a05c63          	blez	a0,8000710c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800070d8:	0084b783          	ld	a5,8(s1)
    800070dc:	0104a703          	lw	a4,16(s1)
    800070e0:	00271713          	slli	a4,a4,0x2
    800070e4:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800070e8:	0007c503          	lbu	a0,0(a5)
    800070ec:	ffffb097          	auipc	ra,0xffffb
    800070f0:	ebc080e7          	jalr	-324(ra) # 80001fa8 <_Z4putcc>
        head = (head + 1) % cap;
    800070f4:	0104a783          	lw	a5,16(s1)
    800070f8:	0017879b          	addiw	a5,a5,1
    800070fc:	0004a703          	lw	a4,0(s1)
    80007100:	02e7e7bb          	remw	a5,a5,a4
    80007104:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80007108:	fc1ff06f          	j	800070c8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8000710c:	02100513          	li	a0,33
    80007110:	ffffb097          	auipc	ra,0xffffb
    80007114:	e98080e7          	jalr	-360(ra) # 80001fa8 <_Z4putcc>
    putc('\n');
    80007118:	00a00513          	li	a0,10
    8000711c:	ffffb097          	auipc	ra,0xffffb
    80007120:	e8c080e7          	jalr	-372(ra) # 80001fa8 <_Z4putcc>
    mem_free(buffer);
    80007124:	0084b503          	ld	a0,8(s1)
    80007128:	ffffb097          	auipc	ra,0xffffb
    8000712c:	bd8080e7          	jalr	-1064(ra) # 80001d00 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80007130:	0204b503          	ld	a0,32(s1)
    80007134:	ffffb097          	auipc	ra,0xffffb
    80007138:	d9c080e7          	jalr	-612(ra) # 80001ed0 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8000713c:	0184b503          	ld	a0,24(s1)
    80007140:	ffffb097          	auipc	ra,0xffffb
    80007144:	d90080e7          	jalr	-624(ra) # 80001ed0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80007148:	0304b503          	ld	a0,48(s1)
    8000714c:	ffffb097          	auipc	ra,0xffffb
    80007150:	d84080e7          	jalr	-636(ra) # 80001ed0 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80007154:	0284b503          	ld	a0,40(s1)
    80007158:	ffffb097          	auipc	ra,0xffffb
    8000715c:	d78080e7          	jalr	-648(ra) # 80001ed0 <_Z9sem_closeP10_semaphore>
}
    80007160:	01813083          	ld	ra,24(sp)
    80007164:	01013403          	ld	s0,16(sp)
    80007168:	00813483          	ld	s1,8(sp)
    8000716c:	02010113          	addi	sp,sp,32
    80007170:	00008067          	ret

0000000080007174 <start>:
    80007174:	ff010113          	addi	sp,sp,-16
    80007178:	00813423          	sd	s0,8(sp)
    8000717c:	01010413          	addi	s0,sp,16
    80007180:	300027f3          	csrr	a5,mstatus
    80007184:	ffffe737          	lui	a4,0xffffe
    80007188:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffebf5f>
    8000718c:	00e7f7b3          	and	a5,a5,a4
    80007190:	00001737          	lui	a4,0x1
    80007194:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007198:	00e7e7b3          	or	a5,a5,a4
    8000719c:	30079073          	csrw	mstatus,a5
    800071a0:	00000797          	auipc	a5,0x0
    800071a4:	16078793          	addi	a5,a5,352 # 80007300 <system_main>
    800071a8:	34179073          	csrw	mepc,a5
    800071ac:	00000793          	li	a5,0
    800071b0:	18079073          	csrw	satp,a5
    800071b4:	000107b7          	lui	a5,0x10
    800071b8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800071bc:	30279073          	csrw	medeleg,a5
    800071c0:	30379073          	csrw	mideleg,a5
    800071c4:	104027f3          	csrr	a5,sie
    800071c8:	2227e793          	ori	a5,a5,546
    800071cc:	10479073          	csrw	sie,a5
    800071d0:	fff00793          	li	a5,-1
    800071d4:	00a7d793          	srli	a5,a5,0xa
    800071d8:	3b079073          	csrw	pmpaddr0,a5
    800071dc:	00f00793          	li	a5,15
    800071e0:	3a079073          	csrw	pmpcfg0,a5
    800071e4:	f14027f3          	csrr	a5,mhartid
    800071e8:	0200c737          	lui	a4,0x200c
    800071ec:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800071f0:	0007869b          	sext.w	a3,a5
    800071f4:	00269713          	slli	a4,a3,0x2
    800071f8:	000f4637          	lui	a2,0xf4
    800071fc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80007200:	00d70733          	add	a4,a4,a3
    80007204:	0037979b          	slliw	a5,a5,0x3
    80007208:	020046b7          	lui	a3,0x2004
    8000720c:	00d787b3          	add	a5,a5,a3
    80007210:	00c585b3          	add	a1,a1,a2
    80007214:	00371693          	slli	a3,a4,0x3
    80007218:	0000a717          	auipc	a4,0xa
    8000721c:	42870713          	addi	a4,a4,1064 # 80011640 <timer_scratch>
    80007220:	00b7b023          	sd	a1,0(a5)
    80007224:	00d70733          	add	a4,a4,a3
    80007228:	00f73c23          	sd	a5,24(a4)
    8000722c:	02c73023          	sd	a2,32(a4)
    80007230:	34071073          	csrw	mscratch,a4
    80007234:	00000797          	auipc	a5,0x0
    80007238:	6ec78793          	addi	a5,a5,1772 # 80007920 <timervec>
    8000723c:	30579073          	csrw	mtvec,a5
    80007240:	300027f3          	csrr	a5,mstatus
    80007244:	0087e793          	ori	a5,a5,8
    80007248:	30079073          	csrw	mstatus,a5
    8000724c:	304027f3          	csrr	a5,mie
    80007250:	0807e793          	ori	a5,a5,128
    80007254:	30479073          	csrw	mie,a5
    80007258:	f14027f3          	csrr	a5,mhartid
    8000725c:	0007879b          	sext.w	a5,a5
    80007260:	00078213          	mv	tp,a5
    80007264:	30200073          	mret
    80007268:	00813403          	ld	s0,8(sp)
    8000726c:	01010113          	addi	sp,sp,16
    80007270:	00008067          	ret

0000000080007274 <timerinit>:
    80007274:	ff010113          	addi	sp,sp,-16
    80007278:	00813423          	sd	s0,8(sp)
    8000727c:	01010413          	addi	s0,sp,16
    80007280:	f14027f3          	csrr	a5,mhartid
    80007284:	0200c737          	lui	a4,0x200c
    80007288:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000728c:	0007869b          	sext.w	a3,a5
    80007290:	00269713          	slli	a4,a3,0x2
    80007294:	000f4637          	lui	a2,0xf4
    80007298:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000729c:	00d70733          	add	a4,a4,a3
    800072a0:	0037979b          	slliw	a5,a5,0x3
    800072a4:	020046b7          	lui	a3,0x2004
    800072a8:	00d787b3          	add	a5,a5,a3
    800072ac:	00c585b3          	add	a1,a1,a2
    800072b0:	00371693          	slli	a3,a4,0x3
    800072b4:	0000a717          	auipc	a4,0xa
    800072b8:	38c70713          	addi	a4,a4,908 # 80011640 <timer_scratch>
    800072bc:	00b7b023          	sd	a1,0(a5)
    800072c0:	00d70733          	add	a4,a4,a3
    800072c4:	00f73c23          	sd	a5,24(a4)
    800072c8:	02c73023          	sd	a2,32(a4)
    800072cc:	34071073          	csrw	mscratch,a4
    800072d0:	00000797          	auipc	a5,0x0
    800072d4:	65078793          	addi	a5,a5,1616 # 80007920 <timervec>
    800072d8:	30579073          	csrw	mtvec,a5
    800072dc:	300027f3          	csrr	a5,mstatus
    800072e0:	0087e793          	ori	a5,a5,8
    800072e4:	30079073          	csrw	mstatus,a5
    800072e8:	304027f3          	csrr	a5,mie
    800072ec:	0807e793          	ori	a5,a5,128
    800072f0:	30479073          	csrw	mie,a5
    800072f4:	00813403          	ld	s0,8(sp)
    800072f8:	01010113          	addi	sp,sp,16
    800072fc:	00008067          	ret

0000000080007300 <system_main>:
    80007300:	fe010113          	addi	sp,sp,-32
    80007304:	00813823          	sd	s0,16(sp)
    80007308:	00913423          	sd	s1,8(sp)
    8000730c:	00113c23          	sd	ra,24(sp)
    80007310:	02010413          	addi	s0,sp,32
    80007314:	00000097          	auipc	ra,0x0
    80007318:	0c4080e7          	jalr	196(ra) # 800073d8 <cpuid>
    8000731c:	00006497          	auipc	s1,0x6
    80007320:	0a448493          	addi	s1,s1,164 # 8000d3c0 <started>
    80007324:	02050263          	beqz	a0,80007348 <system_main+0x48>
    80007328:	0004a783          	lw	a5,0(s1)
    8000732c:	0007879b          	sext.w	a5,a5
    80007330:	fe078ce3          	beqz	a5,80007328 <system_main+0x28>
    80007334:	0ff0000f          	fence
    80007338:	00003517          	auipc	a0,0x3
    8000733c:	41050513          	addi	a0,a0,1040 # 8000a748 <CONSOLE_STATUS+0x738>
    80007340:	00001097          	auipc	ra,0x1
    80007344:	a7c080e7          	jalr	-1412(ra) # 80007dbc <panic>
    80007348:	00001097          	auipc	ra,0x1
    8000734c:	9d0080e7          	jalr	-1584(ra) # 80007d18 <consoleinit>
    80007350:	00001097          	auipc	ra,0x1
    80007354:	15c080e7          	jalr	348(ra) # 800084ac <printfinit>
    80007358:	00003517          	auipc	a0,0x3
    8000735c:	fa050513          	addi	a0,a0,-96 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80007360:	00001097          	auipc	ra,0x1
    80007364:	ab8080e7          	jalr	-1352(ra) # 80007e18 <__printf>
    80007368:	00003517          	auipc	a0,0x3
    8000736c:	3b050513          	addi	a0,a0,944 # 8000a718 <CONSOLE_STATUS+0x708>
    80007370:	00001097          	auipc	ra,0x1
    80007374:	aa8080e7          	jalr	-1368(ra) # 80007e18 <__printf>
    80007378:	00003517          	auipc	a0,0x3
    8000737c:	f8050513          	addi	a0,a0,-128 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80007380:	00001097          	auipc	ra,0x1
    80007384:	a98080e7          	jalr	-1384(ra) # 80007e18 <__printf>
    80007388:	00001097          	auipc	ra,0x1
    8000738c:	4b0080e7          	jalr	1200(ra) # 80008838 <kinit>
    80007390:	00000097          	auipc	ra,0x0
    80007394:	148080e7          	jalr	328(ra) # 800074d8 <trapinit>
    80007398:	00000097          	auipc	ra,0x0
    8000739c:	16c080e7          	jalr	364(ra) # 80007504 <trapinithart>
    800073a0:	00000097          	auipc	ra,0x0
    800073a4:	5c0080e7          	jalr	1472(ra) # 80007960 <plicinit>
    800073a8:	00000097          	auipc	ra,0x0
    800073ac:	5e0080e7          	jalr	1504(ra) # 80007988 <plicinithart>
    800073b0:	00000097          	auipc	ra,0x0
    800073b4:	078080e7          	jalr	120(ra) # 80007428 <userinit>
    800073b8:	0ff0000f          	fence
    800073bc:	00100793          	li	a5,1
    800073c0:	00003517          	auipc	a0,0x3
    800073c4:	37050513          	addi	a0,a0,880 # 8000a730 <CONSOLE_STATUS+0x720>
    800073c8:	00f4a023          	sw	a5,0(s1)
    800073cc:	00001097          	auipc	ra,0x1
    800073d0:	a4c080e7          	jalr	-1460(ra) # 80007e18 <__printf>
    800073d4:	0000006f          	j	800073d4 <system_main+0xd4>

00000000800073d8 <cpuid>:
    800073d8:	ff010113          	addi	sp,sp,-16
    800073dc:	00813423          	sd	s0,8(sp)
    800073e0:	01010413          	addi	s0,sp,16
    800073e4:	00020513          	mv	a0,tp
    800073e8:	00813403          	ld	s0,8(sp)
    800073ec:	0005051b          	sext.w	a0,a0
    800073f0:	01010113          	addi	sp,sp,16
    800073f4:	00008067          	ret

00000000800073f8 <mycpu>:
    800073f8:	ff010113          	addi	sp,sp,-16
    800073fc:	00813423          	sd	s0,8(sp)
    80007400:	01010413          	addi	s0,sp,16
    80007404:	00020793          	mv	a5,tp
    80007408:	00813403          	ld	s0,8(sp)
    8000740c:	0007879b          	sext.w	a5,a5
    80007410:	00779793          	slli	a5,a5,0x7
    80007414:	0000b517          	auipc	a0,0xb
    80007418:	25c50513          	addi	a0,a0,604 # 80012670 <cpus>
    8000741c:	00f50533          	add	a0,a0,a5
    80007420:	01010113          	addi	sp,sp,16
    80007424:	00008067          	ret

0000000080007428 <userinit>:
    80007428:	ff010113          	addi	sp,sp,-16
    8000742c:	00813423          	sd	s0,8(sp)
    80007430:	01010413          	addi	s0,sp,16
    80007434:	00813403          	ld	s0,8(sp)
    80007438:	01010113          	addi	sp,sp,16
    8000743c:	ffffb317          	auipc	t1,0xffffb
    80007440:	77430067          	jr	1908(t1) # 80002bb0 <main>

0000000080007444 <either_copyout>:
    80007444:	ff010113          	addi	sp,sp,-16
    80007448:	00813023          	sd	s0,0(sp)
    8000744c:	00113423          	sd	ra,8(sp)
    80007450:	01010413          	addi	s0,sp,16
    80007454:	02051663          	bnez	a0,80007480 <either_copyout+0x3c>
    80007458:	00058513          	mv	a0,a1
    8000745c:	00060593          	mv	a1,a2
    80007460:	0006861b          	sext.w	a2,a3
    80007464:	00002097          	auipc	ra,0x2
    80007468:	c60080e7          	jalr	-928(ra) # 800090c4 <__memmove>
    8000746c:	00813083          	ld	ra,8(sp)
    80007470:	00013403          	ld	s0,0(sp)
    80007474:	00000513          	li	a0,0
    80007478:	01010113          	addi	sp,sp,16
    8000747c:	00008067          	ret
    80007480:	00003517          	auipc	a0,0x3
    80007484:	2f050513          	addi	a0,a0,752 # 8000a770 <CONSOLE_STATUS+0x760>
    80007488:	00001097          	auipc	ra,0x1
    8000748c:	934080e7          	jalr	-1740(ra) # 80007dbc <panic>

0000000080007490 <either_copyin>:
    80007490:	ff010113          	addi	sp,sp,-16
    80007494:	00813023          	sd	s0,0(sp)
    80007498:	00113423          	sd	ra,8(sp)
    8000749c:	01010413          	addi	s0,sp,16
    800074a0:	02059463          	bnez	a1,800074c8 <either_copyin+0x38>
    800074a4:	00060593          	mv	a1,a2
    800074a8:	0006861b          	sext.w	a2,a3
    800074ac:	00002097          	auipc	ra,0x2
    800074b0:	c18080e7          	jalr	-1000(ra) # 800090c4 <__memmove>
    800074b4:	00813083          	ld	ra,8(sp)
    800074b8:	00013403          	ld	s0,0(sp)
    800074bc:	00000513          	li	a0,0
    800074c0:	01010113          	addi	sp,sp,16
    800074c4:	00008067          	ret
    800074c8:	00003517          	auipc	a0,0x3
    800074cc:	2d050513          	addi	a0,a0,720 # 8000a798 <CONSOLE_STATUS+0x788>
    800074d0:	00001097          	auipc	ra,0x1
    800074d4:	8ec080e7          	jalr	-1812(ra) # 80007dbc <panic>

00000000800074d8 <trapinit>:
    800074d8:	ff010113          	addi	sp,sp,-16
    800074dc:	00813423          	sd	s0,8(sp)
    800074e0:	01010413          	addi	s0,sp,16
    800074e4:	00813403          	ld	s0,8(sp)
    800074e8:	00003597          	auipc	a1,0x3
    800074ec:	2d858593          	addi	a1,a1,728 # 8000a7c0 <CONSOLE_STATUS+0x7b0>
    800074f0:	0000b517          	auipc	a0,0xb
    800074f4:	20050513          	addi	a0,a0,512 # 800126f0 <tickslock>
    800074f8:	01010113          	addi	sp,sp,16
    800074fc:	00001317          	auipc	t1,0x1
    80007500:	5cc30067          	jr	1484(t1) # 80008ac8 <initlock>

0000000080007504 <trapinithart>:
    80007504:	ff010113          	addi	sp,sp,-16
    80007508:	00813423          	sd	s0,8(sp)
    8000750c:	01010413          	addi	s0,sp,16
    80007510:	00000797          	auipc	a5,0x0
    80007514:	30078793          	addi	a5,a5,768 # 80007810 <kernelvec>
    80007518:	10579073          	csrw	stvec,a5
    8000751c:	00813403          	ld	s0,8(sp)
    80007520:	01010113          	addi	sp,sp,16
    80007524:	00008067          	ret

0000000080007528 <usertrap>:
    80007528:	ff010113          	addi	sp,sp,-16
    8000752c:	00813423          	sd	s0,8(sp)
    80007530:	01010413          	addi	s0,sp,16
    80007534:	00813403          	ld	s0,8(sp)
    80007538:	01010113          	addi	sp,sp,16
    8000753c:	00008067          	ret

0000000080007540 <usertrapret>:
    80007540:	ff010113          	addi	sp,sp,-16
    80007544:	00813423          	sd	s0,8(sp)
    80007548:	01010413          	addi	s0,sp,16
    8000754c:	00813403          	ld	s0,8(sp)
    80007550:	01010113          	addi	sp,sp,16
    80007554:	00008067          	ret

0000000080007558 <kerneltrap>:
    80007558:	fe010113          	addi	sp,sp,-32
    8000755c:	00813823          	sd	s0,16(sp)
    80007560:	00113c23          	sd	ra,24(sp)
    80007564:	00913423          	sd	s1,8(sp)
    80007568:	02010413          	addi	s0,sp,32
    8000756c:	142025f3          	csrr	a1,scause
    80007570:	100027f3          	csrr	a5,sstatus
    80007574:	0027f793          	andi	a5,a5,2
    80007578:	10079c63          	bnez	a5,80007690 <kerneltrap+0x138>
    8000757c:	142027f3          	csrr	a5,scause
    80007580:	0207ce63          	bltz	a5,800075bc <kerneltrap+0x64>
    80007584:	00003517          	auipc	a0,0x3
    80007588:	28450513          	addi	a0,a0,644 # 8000a808 <CONSOLE_STATUS+0x7f8>
    8000758c:	00001097          	auipc	ra,0x1
    80007590:	88c080e7          	jalr	-1908(ra) # 80007e18 <__printf>
    80007594:	141025f3          	csrr	a1,sepc
    80007598:	14302673          	csrr	a2,stval
    8000759c:	00003517          	auipc	a0,0x3
    800075a0:	27c50513          	addi	a0,a0,636 # 8000a818 <CONSOLE_STATUS+0x808>
    800075a4:	00001097          	auipc	ra,0x1
    800075a8:	874080e7          	jalr	-1932(ra) # 80007e18 <__printf>
    800075ac:	00003517          	auipc	a0,0x3
    800075b0:	28450513          	addi	a0,a0,644 # 8000a830 <CONSOLE_STATUS+0x820>
    800075b4:	00001097          	auipc	ra,0x1
    800075b8:	808080e7          	jalr	-2040(ra) # 80007dbc <panic>
    800075bc:	0ff7f713          	andi	a4,a5,255
    800075c0:	00900693          	li	a3,9
    800075c4:	04d70063          	beq	a4,a3,80007604 <kerneltrap+0xac>
    800075c8:	fff00713          	li	a4,-1
    800075cc:	03f71713          	slli	a4,a4,0x3f
    800075d0:	00170713          	addi	a4,a4,1
    800075d4:	fae798e3          	bne	a5,a4,80007584 <kerneltrap+0x2c>
    800075d8:	00000097          	auipc	ra,0x0
    800075dc:	e00080e7          	jalr	-512(ra) # 800073d8 <cpuid>
    800075e0:	06050663          	beqz	a0,8000764c <kerneltrap+0xf4>
    800075e4:	144027f3          	csrr	a5,sip
    800075e8:	ffd7f793          	andi	a5,a5,-3
    800075ec:	14479073          	csrw	sip,a5
    800075f0:	01813083          	ld	ra,24(sp)
    800075f4:	01013403          	ld	s0,16(sp)
    800075f8:	00813483          	ld	s1,8(sp)
    800075fc:	02010113          	addi	sp,sp,32
    80007600:	00008067          	ret
    80007604:	00000097          	auipc	ra,0x0
    80007608:	3d0080e7          	jalr	976(ra) # 800079d4 <plic_claim>
    8000760c:	00a00793          	li	a5,10
    80007610:	00050493          	mv	s1,a0
    80007614:	06f50863          	beq	a0,a5,80007684 <kerneltrap+0x12c>
    80007618:	fc050ce3          	beqz	a0,800075f0 <kerneltrap+0x98>
    8000761c:	00050593          	mv	a1,a0
    80007620:	00003517          	auipc	a0,0x3
    80007624:	1c850513          	addi	a0,a0,456 # 8000a7e8 <CONSOLE_STATUS+0x7d8>
    80007628:	00000097          	auipc	ra,0x0
    8000762c:	7f0080e7          	jalr	2032(ra) # 80007e18 <__printf>
    80007630:	01013403          	ld	s0,16(sp)
    80007634:	01813083          	ld	ra,24(sp)
    80007638:	00048513          	mv	a0,s1
    8000763c:	00813483          	ld	s1,8(sp)
    80007640:	02010113          	addi	sp,sp,32
    80007644:	00000317          	auipc	t1,0x0
    80007648:	3c830067          	jr	968(t1) # 80007a0c <plic_complete>
    8000764c:	0000b517          	auipc	a0,0xb
    80007650:	0a450513          	addi	a0,a0,164 # 800126f0 <tickslock>
    80007654:	00001097          	auipc	ra,0x1
    80007658:	498080e7          	jalr	1176(ra) # 80008aec <acquire>
    8000765c:	00006717          	auipc	a4,0x6
    80007660:	d6870713          	addi	a4,a4,-664 # 8000d3c4 <ticks>
    80007664:	00072783          	lw	a5,0(a4)
    80007668:	0000b517          	auipc	a0,0xb
    8000766c:	08850513          	addi	a0,a0,136 # 800126f0 <tickslock>
    80007670:	0017879b          	addiw	a5,a5,1
    80007674:	00f72023          	sw	a5,0(a4)
    80007678:	00001097          	auipc	ra,0x1
    8000767c:	540080e7          	jalr	1344(ra) # 80008bb8 <release>
    80007680:	f65ff06f          	j	800075e4 <kerneltrap+0x8c>
    80007684:	00001097          	auipc	ra,0x1
    80007688:	09c080e7          	jalr	156(ra) # 80008720 <uartintr>
    8000768c:	fa5ff06f          	j	80007630 <kerneltrap+0xd8>
    80007690:	00003517          	auipc	a0,0x3
    80007694:	13850513          	addi	a0,a0,312 # 8000a7c8 <CONSOLE_STATUS+0x7b8>
    80007698:	00000097          	auipc	ra,0x0
    8000769c:	724080e7          	jalr	1828(ra) # 80007dbc <panic>

00000000800076a0 <clockintr>:
    800076a0:	fe010113          	addi	sp,sp,-32
    800076a4:	00813823          	sd	s0,16(sp)
    800076a8:	00913423          	sd	s1,8(sp)
    800076ac:	00113c23          	sd	ra,24(sp)
    800076b0:	02010413          	addi	s0,sp,32
    800076b4:	0000b497          	auipc	s1,0xb
    800076b8:	03c48493          	addi	s1,s1,60 # 800126f0 <tickslock>
    800076bc:	00048513          	mv	a0,s1
    800076c0:	00001097          	auipc	ra,0x1
    800076c4:	42c080e7          	jalr	1068(ra) # 80008aec <acquire>
    800076c8:	00006717          	auipc	a4,0x6
    800076cc:	cfc70713          	addi	a4,a4,-772 # 8000d3c4 <ticks>
    800076d0:	00072783          	lw	a5,0(a4)
    800076d4:	01013403          	ld	s0,16(sp)
    800076d8:	01813083          	ld	ra,24(sp)
    800076dc:	00048513          	mv	a0,s1
    800076e0:	0017879b          	addiw	a5,a5,1
    800076e4:	00813483          	ld	s1,8(sp)
    800076e8:	00f72023          	sw	a5,0(a4)
    800076ec:	02010113          	addi	sp,sp,32
    800076f0:	00001317          	auipc	t1,0x1
    800076f4:	4c830067          	jr	1224(t1) # 80008bb8 <release>

00000000800076f8 <devintr>:
    800076f8:	142027f3          	csrr	a5,scause
    800076fc:	00000513          	li	a0,0
    80007700:	0007c463          	bltz	a5,80007708 <devintr+0x10>
    80007704:	00008067          	ret
    80007708:	fe010113          	addi	sp,sp,-32
    8000770c:	00813823          	sd	s0,16(sp)
    80007710:	00113c23          	sd	ra,24(sp)
    80007714:	00913423          	sd	s1,8(sp)
    80007718:	02010413          	addi	s0,sp,32
    8000771c:	0ff7f713          	andi	a4,a5,255
    80007720:	00900693          	li	a3,9
    80007724:	04d70c63          	beq	a4,a3,8000777c <devintr+0x84>
    80007728:	fff00713          	li	a4,-1
    8000772c:	03f71713          	slli	a4,a4,0x3f
    80007730:	00170713          	addi	a4,a4,1
    80007734:	00e78c63          	beq	a5,a4,8000774c <devintr+0x54>
    80007738:	01813083          	ld	ra,24(sp)
    8000773c:	01013403          	ld	s0,16(sp)
    80007740:	00813483          	ld	s1,8(sp)
    80007744:	02010113          	addi	sp,sp,32
    80007748:	00008067          	ret
    8000774c:	00000097          	auipc	ra,0x0
    80007750:	c8c080e7          	jalr	-884(ra) # 800073d8 <cpuid>
    80007754:	06050663          	beqz	a0,800077c0 <devintr+0xc8>
    80007758:	144027f3          	csrr	a5,sip
    8000775c:	ffd7f793          	andi	a5,a5,-3
    80007760:	14479073          	csrw	sip,a5
    80007764:	01813083          	ld	ra,24(sp)
    80007768:	01013403          	ld	s0,16(sp)
    8000776c:	00813483          	ld	s1,8(sp)
    80007770:	00200513          	li	a0,2
    80007774:	02010113          	addi	sp,sp,32
    80007778:	00008067          	ret
    8000777c:	00000097          	auipc	ra,0x0
    80007780:	258080e7          	jalr	600(ra) # 800079d4 <plic_claim>
    80007784:	00a00793          	li	a5,10
    80007788:	00050493          	mv	s1,a0
    8000778c:	06f50663          	beq	a0,a5,800077f8 <devintr+0x100>
    80007790:	00100513          	li	a0,1
    80007794:	fa0482e3          	beqz	s1,80007738 <devintr+0x40>
    80007798:	00048593          	mv	a1,s1
    8000779c:	00003517          	auipc	a0,0x3
    800077a0:	04c50513          	addi	a0,a0,76 # 8000a7e8 <CONSOLE_STATUS+0x7d8>
    800077a4:	00000097          	auipc	ra,0x0
    800077a8:	674080e7          	jalr	1652(ra) # 80007e18 <__printf>
    800077ac:	00048513          	mv	a0,s1
    800077b0:	00000097          	auipc	ra,0x0
    800077b4:	25c080e7          	jalr	604(ra) # 80007a0c <plic_complete>
    800077b8:	00100513          	li	a0,1
    800077bc:	f7dff06f          	j	80007738 <devintr+0x40>
    800077c0:	0000b517          	auipc	a0,0xb
    800077c4:	f3050513          	addi	a0,a0,-208 # 800126f0 <tickslock>
    800077c8:	00001097          	auipc	ra,0x1
    800077cc:	324080e7          	jalr	804(ra) # 80008aec <acquire>
    800077d0:	00006717          	auipc	a4,0x6
    800077d4:	bf470713          	addi	a4,a4,-1036 # 8000d3c4 <ticks>
    800077d8:	00072783          	lw	a5,0(a4)
    800077dc:	0000b517          	auipc	a0,0xb
    800077e0:	f1450513          	addi	a0,a0,-236 # 800126f0 <tickslock>
    800077e4:	0017879b          	addiw	a5,a5,1
    800077e8:	00f72023          	sw	a5,0(a4)
    800077ec:	00001097          	auipc	ra,0x1
    800077f0:	3cc080e7          	jalr	972(ra) # 80008bb8 <release>
    800077f4:	f65ff06f          	j	80007758 <devintr+0x60>
    800077f8:	00001097          	auipc	ra,0x1
    800077fc:	f28080e7          	jalr	-216(ra) # 80008720 <uartintr>
    80007800:	fadff06f          	j	800077ac <devintr+0xb4>
	...

0000000080007810 <kernelvec>:
    80007810:	f0010113          	addi	sp,sp,-256
    80007814:	00113023          	sd	ra,0(sp)
    80007818:	00213423          	sd	sp,8(sp)
    8000781c:	00313823          	sd	gp,16(sp)
    80007820:	00413c23          	sd	tp,24(sp)
    80007824:	02513023          	sd	t0,32(sp)
    80007828:	02613423          	sd	t1,40(sp)
    8000782c:	02713823          	sd	t2,48(sp)
    80007830:	02813c23          	sd	s0,56(sp)
    80007834:	04913023          	sd	s1,64(sp)
    80007838:	04a13423          	sd	a0,72(sp)
    8000783c:	04b13823          	sd	a1,80(sp)
    80007840:	04c13c23          	sd	a2,88(sp)
    80007844:	06d13023          	sd	a3,96(sp)
    80007848:	06e13423          	sd	a4,104(sp)
    8000784c:	06f13823          	sd	a5,112(sp)
    80007850:	07013c23          	sd	a6,120(sp)
    80007854:	09113023          	sd	a7,128(sp)
    80007858:	09213423          	sd	s2,136(sp)
    8000785c:	09313823          	sd	s3,144(sp)
    80007860:	09413c23          	sd	s4,152(sp)
    80007864:	0b513023          	sd	s5,160(sp)
    80007868:	0b613423          	sd	s6,168(sp)
    8000786c:	0b713823          	sd	s7,176(sp)
    80007870:	0b813c23          	sd	s8,184(sp)
    80007874:	0d913023          	sd	s9,192(sp)
    80007878:	0da13423          	sd	s10,200(sp)
    8000787c:	0db13823          	sd	s11,208(sp)
    80007880:	0dc13c23          	sd	t3,216(sp)
    80007884:	0fd13023          	sd	t4,224(sp)
    80007888:	0fe13423          	sd	t5,232(sp)
    8000788c:	0ff13823          	sd	t6,240(sp)
    80007890:	cc9ff0ef          	jal	ra,80007558 <kerneltrap>
    80007894:	00013083          	ld	ra,0(sp)
    80007898:	00813103          	ld	sp,8(sp)
    8000789c:	01013183          	ld	gp,16(sp)
    800078a0:	02013283          	ld	t0,32(sp)
    800078a4:	02813303          	ld	t1,40(sp)
    800078a8:	03013383          	ld	t2,48(sp)
    800078ac:	03813403          	ld	s0,56(sp)
    800078b0:	04013483          	ld	s1,64(sp)
    800078b4:	04813503          	ld	a0,72(sp)
    800078b8:	05013583          	ld	a1,80(sp)
    800078bc:	05813603          	ld	a2,88(sp)
    800078c0:	06013683          	ld	a3,96(sp)
    800078c4:	06813703          	ld	a4,104(sp)
    800078c8:	07013783          	ld	a5,112(sp)
    800078cc:	07813803          	ld	a6,120(sp)
    800078d0:	08013883          	ld	a7,128(sp)
    800078d4:	08813903          	ld	s2,136(sp)
    800078d8:	09013983          	ld	s3,144(sp)
    800078dc:	09813a03          	ld	s4,152(sp)
    800078e0:	0a013a83          	ld	s5,160(sp)
    800078e4:	0a813b03          	ld	s6,168(sp)
    800078e8:	0b013b83          	ld	s7,176(sp)
    800078ec:	0b813c03          	ld	s8,184(sp)
    800078f0:	0c013c83          	ld	s9,192(sp)
    800078f4:	0c813d03          	ld	s10,200(sp)
    800078f8:	0d013d83          	ld	s11,208(sp)
    800078fc:	0d813e03          	ld	t3,216(sp)
    80007900:	0e013e83          	ld	t4,224(sp)
    80007904:	0e813f03          	ld	t5,232(sp)
    80007908:	0f013f83          	ld	t6,240(sp)
    8000790c:	10010113          	addi	sp,sp,256
    80007910:	10200073          	sret
    80007914:	00000013          	nop
    80007918:	00000013          	nop
    8000791c:	00000013          	nop

0000000080007920 <timervec>:
    80007920:	34051573          	csrrw	a0,mscratch,a0
    80007924:	00b53023          	sd	a1,0(a0)
    80007928:	00c53423          	sd	a2,8(a0)
    8000792c:	00d53823          	sd	a3,16(a0)
    80007930:	01853583          	ld	a1,24(a0)
    80007934:	02053603          	ld	a2,32(a0)
    80007938:	0005b683          	ld	a3,0(a1)
    8000793c:	00c686b3          	add	a3,a3,a2
    80007940:	00d5b023          	sd	a3,0(a1)
    80007944:	00200593          	li	a1,2
    80007948:	14459073          	csrw	sip,a1
    8000794c:	01053683          	ld	a3,16(a0)
    80007950:	00853603          	ld	a2,8(a0)
    80007954:	00053583          	ld	a1,0(a0)
    80007958:	34051573          	csrrw	a0,mscratch,a0
    8000795c:	30200073          	mret

0000000080007960 <plicinit>:
    80007960:	ff010113          	addi	sp,sp,-16
    80007964:	00813423          	sd	s0,8(sp)
    80007968:	01010413          	addi	s0,sp,16
    8000796c:	00813403          	ld	s0,8(sp)
    80007970:	0c0007b7          	lui	a5,0xc000
    80007974:	00100713          	li	a4,1
    80007978:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000797c:	00e7a223          	sw	a4,4(a5)
    80007980:	01010113          	addi	sp,sp,16
    80007984:	00008067          	ret

0000000080007988 <plicinithart>:
    80007988:	ff010113          	addi	sp,sp,-16
    8000798c:	00813023          	sd	s0,0(sp)
    80007990:	00113423          	sd	ra,8(sp)
    80007994:	01010413          	addi	s0,sp,16
    80007998:	00000097          	auipc	ra,0x0
    8000799c:	a40080e7          	jalr	-1472(ra) # 800073d8 <cpuid>
    800079a0:	0085171b          	slliw	a4,a0,0x8
    800079a4:	0c0027b7          	lui	a5,0xc002
    800079a8:	00e787b3          	add	a5,a5,a4
    800079ac:	40200713          	li	a4,1026
    800079b0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800079b4:	00813083          	ld	ra,8(sp)
    800079b8:	00013403          	ld	s0,0(sp)
    800079bc:	00d5151b          	slliw	a0,a0,0xd
    800079c0:	0c2017b7          	lui	a5,0xc201
    800079c4:	00a78533          	add	a0,a5,a0
    800079c8:	00052023          	sw	zero,0(a0)
    800079cc:	01010113          	addi	sp,sp,16
    800079d0:	00008067          	ret

00000000800079d4 <plic_claim>:
    800079d4:	ff010113          	addi	sp,sp,-16
    800079d8:	00813023          	sd	s0,0(sp)
    800079dc:	00113423          	sd	ra,8(sp)
    800079e0:	01010413          	addi	s0,sp,16
    800079e4:	00000097          	auipc	ra,0x0
    800079e8:	9f4080e7          	jalr	-1548(ra) # 800073d8 <cpuid>
    800079ec:	00813083          	ld	ra,8(sp)
    800079f0:	00013403          	ld	s0,0(sp)
    800079f4:	00d5151b          	slliw	a0,a0,0xd
    800079f8:	0c2017b7          	lui	a5,0xc201
    800079fc:	00a78533          	add	a0,a5,a0
    80007a00:	00452503          	lw	a0,4(a0)
    80007a04:	01010113          	addi	sp,sp,16
    80007a08:	00008067          	ret

0000000080007a0c <plic_complete>:
    80007a0c:	fe010113          	addi	sp,sp,-32
    80007a10:	00813823          	sd	s0,16(sp)
    80007a14:	00913423          	sd	s1,8(sp)
    80007a18:	00113c23          	sd	ra,24(sp)
    80007a1c:	02010413          	addi	s0,sp,32
    80007a20:	00050493          	mv	s1,a0
    80007a24:	00000097          	auipc	ra,0x0
    80007a28:	9b4080e7          	jalr	-1612(ra) # 800073d8 <cpuid>
    80007a2c:	01813083          	ld	ra,24(sp)
    80007a30:	01013403          	ld	s0,16(sp)
    80007a34:	00d5179b          	slliw	a5,a0,0xd
    80007a38:	0c201737          	lui	a4,0xc201
    80007a3c:	00f707b3          	add	a5,a4,a5
    80007a40:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007a44:	00813483          	ld	s1,8(sp)
    80007a48:	02010113          	addi	sp,sp,32
    80007a4c:	00008067          	ret

0000000080007a50 <consolewrite>:
    80007a50:	fb010113          	addi	sp,sp,-80
    80007a54:	04813023          	sd	s0,64(sp)
    80007a58:	04113423          	sd	ra,72(sp)
    80007a5c:	02913c23          	sd	s1,56(sp)
    80007a60:	03213823          	sd	s2,48(sp)
    80007a64:	03313423          	sd	s3,40(sp)
    80007a68:	03413023          	sd	s4,32(sp)
    80007a6c:	01513c23          	sd	s5,24(sp)
    80007a70:	05010413          	addi	s0,sp,80
    80007a74:	06c05c63          	blez	a2,80007aec <consolewrite+0x9c>
    80007a78:	00060993          	mv	s3,a2
    80007a7c:	00050a13          	mv	s4,a0
    80007a80:	00058493          	mv	s1,a1
    80007a84:	00000913          	li	s2,0
    80007a88:	fff00a93          	li	s5,-1
    80007a8c:	01c0006f          	j	80007aa8 <consolewrite+0x58>
    80007a90:	fbf44503          	lbu	a0,-65(s0)
    80007a94:	0019091b          	addiw	s2,s2,1
    80007a98:	00148493          	addi	s1,s1,1
    80007a9c:	00001097          	auipc	ra,0x1
    80007aa0:	a9c080e7          	jalr	-1380(ra) # 80008538 <uartputc>
    80007aa4:	03298063          	beq	s3,s2,80007ac4 <consolewrite+0x74>
    80007aa8:	00048613          	mv	a2,s1
    80007aac:	00100693          	li	a3,1
    80007ab0:	000a0593          	mv	a1,s4
    80007ab4:	fbf40513          	addi	a0,s0,-65
    80007ab8:	00000097          	auipc	ra,0x0
    80007abc:	9d8080e7          	jalr	-1576(ra) # 80007490 <either_copyin>
    80007ac0:	fd5518e3          	bne	a0,s5,80007a90 <consolewrite+0x40>
    80007ac4:	04813083          	ld	ra,72(sp)
    80007ac8:	04013403          	ld	s0,64(sp)
    80007acc:	03813483          	ld	s1,56(sp)
    80007ad0:	02813983          	ld	s3,40(sp)
    80007ad4:	02013a03          	ld	s4,32(sp)
    80007ad8:	01813a83          	ld	s5,24(sp)
    80007adc:	00090513          	mv	a0,s2
    80007ae0:	03013903          	ld	s2,48(sp)
    80007ae4:	05010113          	addi	sp,sp,80
    80007ae8:	00008067          	ret
    80007aec:	00000913          	li	s2,0
    80007af0:	fd5ff06f          	j	80007ac4 <consolewrite+0x74>

0000000080007af4 <consoleread>:
    80007af4:	f9010113          	addi	sp,sp,-112
    80007af8:	06813023          	sd	s0,96(sp)
    80007afc:	04913c23          	sd	s1,88(sp)
    80007b00:	05213823          	sd	s2,80(sp)
    80007b04:	05313423          	sd	s3,72(sp)
    80007b08:	05413023          	sd	s4,64(sp)
    80007b0c:	03513c23          	sd	s5,56(sp)
    80007b10:	03613823          	sd	s6,48(sp)
    80007b14:	03713423          	sd	s7,40(sp)
    80007b18:	03813023          	sd	s8,32(sp)
    80007b1c:	06113423          	sd	ra,104(sp)
    80007b20:	01913c23          	sd	s9,24(sp)
    80007b24:	07010413          	addi	s0,sp,112
    80007b28:	00060b93          	mv	s7,a2
    80007b2c:	00050913          	mv	s2,a0
    80007b30:	00058c13          	mv	s8,a1
    80007b34:	00060b1b          	sext.w	s6,a2
    80007b38:	0000b497          	auipc	s1,0xb
    80007b3c:	be048493          	addi	s1,s1,-1056 # 80012718 <cons>
    80007b40:	00400993          	li	s3,4
    80007b44:	fff00a13          	li	s4,-1
    80007b48:	00a00a93          	li	s5,10
    80007b4c:	05705e63          	blez	s7,80007ba8 <consoleread+0xb4>
    80007b50:	09c4a703          	lw	a4,156(s1)
    80007b54:	0984a783          	lw	a5,152(s1)
    80007b58:	0007071b          	sext.w	a4,a4
    80007b5c:	08e78463          	beq	a5,a4,80007be4 <consoleread+0xf0>
    80007b60:	07f7f713          	andi	a4,a5,127
    80007b64:	00e48733          	add	a4,s1,a4
    80007b68:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80007b6c:	0017869b          	addiw	a3,a5,1
    80007b70:	08d4ac23          	sw	a3,152(s1)
    80007b74:	00070c9b          	sext.w	s9,a4
    80007b78:	0b370663          	beq	a4,s3,80007c24 <consoleread+0x130>
    80007b7c:	00100693          	li	a3,1
    80007b80:	f9f40613          	addi	a2,s0,-97
    80007b84:	000c0593          	mv	a1,s8
    80007b88:	00090513          	mv	a0,s2
    80007b8c:	f8e40fa3          	sb	a4,-97(s0)
    80007b90:	00000097          	auipc	ra,0x0
    80007b94:	8b4080e7          	jalr	-1868(ra) # 80007444 <either_copyout>
    80007b98:	01450863          	beq	a0,s4,80007ba8 <consoleread+0xb4>
    80007b9c:	001c0c13          	addi	s8,s8,1
    80007ba0:	fffb8b9b          	addiw	s7,s7,-1
    80007ba4:	fb5c94e3          	bne	s9,s5,80007b4c <consoleread+0x58>
    80007ba8:	000b851b          	sext.w	a0,s7
    80007bac:	06813083          	ld	ra,104(sp)
    80007bb0:	06013403          	ld	s0,96(sp)
    80007bb4:	05813483          	ld	s1,88(sp)
    80007bb8:	05013903          	ld	s2,80(sp)
    80007bbc:	04813983          	ld	s3,72(sp)
    80007bc0:	04013a03          	ld	s4,64(sp)
    80007bc4:	03813a83          	ld	s5,56(sp)
    80007bc8:	02813b83          	ld	s7,40(sp)
    80007bcc:	02013c03          	ld	s8,32(sp)
    80007bd0:	01813c83          	ld	s9,24(sp)
    80007bd4:	40ab053b          	subw	a0,s6,a0
    80007bd8:	03013b03          	ld	s6,48(sp)
    80007bdc:	07010113          	addi	sp,sp,112
    80007be0:	00008067          	ret
    80007be4:	00001097          	auipc	ra,0x1
    80007be8:	1d8080e7          	jalr	472(ra) # 80008dbc <push_on>
    80007bec:	0984a703          	lw	a4,152(s1)
    80007bf0:	09c4a783          	lw	a5,156(s1)
    80007bf4:	0007879b          	sext.w	a5,a5
    80007bf8:	fef70ce3          	beq	a4,a5,80007bf0 <consoleread+0xfc>
    80007bfc:	00001097          	auipc	ra,0x1
    80007c00:	234080e7          	jalr	564(ra) # 80008e30 <pop_on>
    80007c04:	0984a783          	lw	a5,152(s1)
    80007c08:	07f7f713          	andi	a4,a5,127
    80007c0c:	00e48733          	add	a4,s1,a4
    80007c10:	01874703          	lbu	a4,24(a4)
    80007c14:	0017869b          	addiw	a3,a5,1
    80007c18:	08d4ac23          	sw	a3,152(s1)
    80007c1c:	00070c9b          	sext.w	s9,a4
    80007c20:	f5371ee3          	bne	a4,s3,80007b7c <consoleread+0x88>
    80007c24:	000b851b          	sext.w	a0,s7
    80007c28:	f96bf2e3          	bgeu	s7,s6,80007bac <consoleread+0xb8>
    80007c2c:	08f4ac23          	sw	a5,152(s1)
    80007c30:	f7dff06f          	j	80007bac <consoleread+0xb8>

0000000080007c34 <consputc>:
    80007c34:	10000793          	li	a5,256
    80007c38:	00f50663          	beq	a0,a5,80007c44 <consputc+0x10>
    80007c3c:	00001317          	auipc	t1,0x1
    80007c40:	9f430067          	jr	-1548(t1) # 80008630 <uartputc_sync>
    80007c44:	ff010113          	addi	sp,sp,-16
    80007c48:	00113423          	sd	ra,8(sp)
    80007c4c:	00813023          	sd	s0,0(sp)
    80007c50:	01010413          	addi	s0,sp,16
    80007c54:	00800513          	li	a0,8
    80007c58:	00001097          	auipc	ra,0x1
    80007c5c:	9d8080e7          	jalr	-1576(ra) # 80008630 <uartputc_sync>
    80007c60:	02000513          	li	a0,32
    80007c64:	00001097          	auipc	ra,0x1
    80007c68:	9cc080e7          	jalr	-1588(ra) # 80008630 <uartputc_sync>
    80007c6c:	00013403          	ld	s0,0(sp)
    80007c70:	00813083          	ld	ra,8(sp)
    80007c74:	00800513          	li	a0,8
    80007c78:	01010113          	addi	sp,sp,16
    80007c7c:	00001317          	auipc	t1,0x1
    80007c80:	9b430067          	jr	-1612(t1) # 80008630 <uartputc_sync>

0000000080007c84 <consoleintr>:
    80007c84:	fe010113          	addi	sp,sp,-32
    80007c88:	00813823          	sd	s0,16(sp)
    80007c8c:	00913423          	sd	s1,8(sp)
    80007c90:	01213023          	sd	s2,0(sp)
    80007c94:	00113c23          	sd	ra,24(sp)
    80007c98:	02010413          	addi	s0,sp,32
    80007c9c:	0000b917          	auipc	s2,0xb
    80007ca0:	a7c90913          	addi	s2,s2,-1412 # 80012718 <cons>
    80007ca4:	00050493          	mv	s1,a0
    80007ca8:	00090513          	mv	a0,s2
    80007cac:	00001097          	auipc	ra,0x1
    80007cb0:	e40080e7          	jalr	-448(ra) # 80008aec <acquire>
    80007cb4:	02048c63          	beqz	s1,80007cec <consoleintr+0x68>
    80007cb8:	0a092783          	lw	a5,160(s2)
    80007cbc:	09892703          	lw	a4,152(s2)
    80007cc0:	07f00693          	li	a3,127
    80007cc4:	40e7873b          	subw	a4,a5,a4
    80007cc8:	02e6e263          	bltu	a3,a4,80007cec <consoleintr+0x68>
    80007ccc:	00d00713          	li	a4,13
    80007cd0:	04e48063          	beq	s1,a4,80007d10 <consoleintr+0x8c>
    80007cd4:	07f7f713          	andi	a4,a5,127
    80007cd8:	00e90733          	add	a4,s2,a4
    80007cdc:	0017879b          	addiw	a5,a5,1
    80007ce0:	0af92023          	sw	a5,160(s2)
    80007ce4:	00970c23          	sb	s1,24(a4)
    80007ce8:	08f92e23          	sw	a5,156(s2)
    80007cec:	01013403          	ld	s0,16(sp)
    80007cf0:	01813083          	ld	ra,24(sp)
    80007cf4:	00813483          	ld	s1,8(sp)
    80007cf8:	00013903          	ld	s2,0(sp)
    80007cfc:	0000b517          	auipc	a0,0xb
    80007d00:	a1c50513          	addi	a0,a0,-1508 # 80012718 <cons>
    80007d04:	02010113          	addi	sp,sp,32
    80007d08:	00001317          	auipc	t1,0x1
    80007d0c:	eb030067          	jr	-336(t1) # 80008bb8 <release>
    80007d10:	00a00493          	li	s1,10
    80007d14:	fc1ff06f          	j	80007cd4 <consoleintr+0x50>

0000000080007d18 <consoleinit>:
    80007d18:	fe010113          	addi	sp,sp,-32
    80007d1c:	00113c23          	sd	ra,24(sp)
    80007d20:	00813823          	sd	s0,16(sp)
    80007d24:	00913423          	sd	s1,8(sp)
    80007d28:	02010413          	addi	s0,sp,32
    80007d2c:	0000b497          	auipc	s1,0xb
    80007d30:	9ec48493          	addi	s1,s1,-1556 # 80012718 <cons>
    80007d34:	00048513          	mv	a0,s1
    80007d38:	00003597          	auipc	a1,0x3
    80007d3c:	b0858593          	addi	a1,a1,-1272 # 8000a840 <CONSOLE_STATUS+0x830>
    80007d40:	00001097          	auipc	ra,0x1
    80007d44:	d88080e7          	jalr	-632(ra) # 80008ac8 <initlock>
    80007d48:	00000097          	auipc	ra,0x0
    80007d4c:	7ac080e7          	jalr	1964(ra) # 800084f4 <uartinit>
    80007d50:	01813083          	ld	ra,24(sp)
    80007d54:	01013403          	ld	s0,16(sp)
    80007d58:	00000797          	auipc	a5,0x0
    80007d5c:	d9c78793          	addi	a5,a5,-612 # 80007af4 <consoleread>
    80007d60:	0af4bc23          	sd	a5,184(s1)
    80007d64:	00000797          	auipc	a5,0x0
    80007d68:	cec78793          	addi	a5,a5,-788 # 80007a50 <consolewrite>
    80007d6c:	0cf4b023          	sd	a5,192(s1)
    80007d70:	00813483          	ld	s1,8(sp)
    80007d74:	02010113          	addi	sp,sp,32
    80007d78:	00008067          	ret

0000000080007d7c <console_read>:
    80007d7c:	ff010113          	addi	sp,sp,-16
    80007d80:	00813423          	sd	s0,8(sp)
    80007d84:	01010413          	addi	s0,sp,16
    80007d88:	00813403          	ld	s0,8(sp)
    80007d8c:	0000b317          	auipc	t1,0xb
    80007d90:	a4433303          	ld	t1,-1468(t1) # 800127d0 <devsw+0x10>
    80007d94:	01010113          	addi	sp,sp,16
    80007d98:	00030067          	jr	t1

0000000080007d9c <console_write>:
    80007d9c:	ff010113          	addi	sp,sp,-16
    80007da0:	00813423          	sd	s0,8(sp)
    80007da4:	01010413          	addi	s0,sp,16
    80007da8:	00813403          	ld	s0,8(sp)
    80007dac:	0000b317          	auipc	t1,0xb
    80007db0:	a2c33303          	ld	t1,-1492(t1) # 800127d8 <devsw+0x18>
    80007db4:	01010113          	addi	sp,sp,16
    80007db8:	00030067          	jr	t1

0000000080007dbc <panic>:
    80007dbc:	fe010113          	addi	sp,sp,-32
    80007dc0:	00113c23          	sd	ra,24(sp)
    80007dc4:	00813823          	sd	s0,16(sp)
    80007dc8:	00913423          	sd	s1,8(sp)
    80007dcc:	02010413          	addi	s0,sp,32
    80007dd0:	00050493          	mv	s1,a0
    80007dd4:	00003517          	auipc	a0,0x3
    80007dd8:	a7450513          	addi	a0,a0,-1420 # 8000a848 <CONSOLE_STATUS+0x838>
    80007ddc:	0000b797          	auipc	a5,0xb
    80007de0:	a807ae23          	sw	zero,-1380(a5) # 80012878 <pr+0x18>
    80007de4:	00000097          	auipc	ra,0x0
    80007de8:	034080e7          	jalr	52(ra) # 80007e18 <__printf>
    80007dec:	00048513          	mv	a0,s1
    80007df0:	00000097          	auipc	ra,0x0
    80007df4:	028080e7          	jalr	40(ra) # 80007e18 <__printf>
    80007df8:	00002517          	auipc	a0,0x2
    80007dfc:	50050513          	addi	a0,a0,1280 # 8000a2f8 <CONSOLE_STATUS+0x2e8>
    80007e00:	00000097          	auipc	ra,0x0
    80007e04:	018080e7          	jalr	24(ra) # 80007e18 <__printf>
    80007e08:	00100793          	li	a5,1
    80007e0c:	00005717          	auipc	a4,0x5
    80007e10:	5af72e23          	sw	a5,1468(a4) # 8000d3c8 <panicked>
    80007e14:	0000006f          	j	80007e14 <panic+0x58>

0000000080007e18 <__printf>:
    80007e18:	f3010113          	addi	sp,sp,-208
    80007e1c:	08813023          	sd	s0,128(sp)
    80007e20:	07313423          	sd	s3,104(sp)
    80007e24:	09010413          	addi	s0,sp,144
    80007e28:	05813023          	sd	s8,64(sp)
    80007e2c:	08113423          	sd	ra,136(sp)
    80007e30:	06913c23          	sd	s1,120(sp)
    80007e34:	07213823          	sd	s2,112(sp)
    80007e38:	07413023          	sd	s4,96(sp)
    80007e3c:	05513c23          	sd	s5,88(sp)
    80007e40:	05613823          	sd	s6,80(sp)
    80007e44:	05713423          	sd	s7,72(sp)
    80007e48:	03913c23          	sd	s9,56(sp)
    80007e4c:	03a13823          	sd	s10,48(sp)
    80007e50:	03b13423          	sd	s11,40(sp)
    80007e54:	0000b317          	auipc	t1,0xb
    80007e58:	a0c30313          	addi	t1,t1,-1524 # 80012860 <pr>
    80007e5c:	01832c03          	lw	s8,24(t1)
    80007e60:	00b43423          	sd	a1,8(s0)
    80007e64:	00c43823          	sd	a2,16(s0)
    80007e68:	00d43c23          	sd	a3,24(s0)
    80007e6c:	02e43023          	sd	a4,32(s0)
    80007e70:	02f43423          	sd	a5,40(s0)
    80007e74:	03043823          	sd	a6,48(s0)
    80007e78:	03143c23          	sd	a7,56(s0)
    80007e7c:	00050993          	mv	s3,a0
    80007e80:	4a0c1663          	bnez	s8,8000832c <__printf+0x514>
    80007e84:	60098c63          	beqz	s3,8000849c <__printf+0x684>
    80007e88:	0009c503          	lbu	a0,0(s3)
    80007e8c:	00840793          	addi	a5,s0,8
    80007e90:	f6f43c23          	sd	a5,-136(s0)
    80007e94:	00000493          	li	s1,0
    80007e98:	22050063          	beqz	a0,800080b8 <__printf+0x2a0>
    80007e9c:	00002a37          	lui	s4,0x2
    80007ea0:	00018ab7          	lui	s5,0x18
    80007ea4:	000f4b37          	lui	s6,0xf4
    80007ea8:	00989bb7          	lui	s7,0x989
    80007eac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007eb0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007eb4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007eb8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80007ebc:	00148c9b          	addiw	s9,s1,1
    80007ec0:	02500793          	li	a5,37
    80007ec4:	01998933          	add	s2,s3,s9
    80007ec8:	38f51263          	bne	a0,a5,8000824c <__printf+0x434>
    80007ecc:	00094783          	lbu	a5,0(s2)
    80007ed0:	00078c9b          	sext.w	s9,a5
    80007ed4:	1e078263          	beqz	a5,800080b8 <__printf+0x2a0>
    80007ed8:	0024849b          	addiw	s1,s1,2
    80007edc:	07000713          	li	a4,112
    80007ee0:	00998933          	add	s2,s3,s1
    80007ee4:	38e78a63          	beq	a5,a4,80008278 <__printf+0x460>
    80007ee8:	20f76863          	bltu	a4,a5,800080f8 <__printf+0x2e0>
    80007eec:	42a78863          	beq	a5,a0,8000831c <__printf+0x504>
    80007ef0:	06400713          	li	a4,100
    80007ef4:	40e79663          	bne	a5,a4,80008300 <__printf+0x4e8>
    80007ef8:	f7843783          	ld	a5,-136(s0)
    80007efc:	0007a603          	lw	a2,0(a5)
    80007f00:	00878793          	addi	a5,a5,8
    80007f04:	f6f43c23          	sd	a5,-136(s0)
    80007f08:	42064a63          	bltz	a2,8000833c <__printf+0x524>
    80007f0c:	00a00713          	li	a4,10
    80007f10:	02e677bb          	remuw	a5,a2,a4
    80007f14:	00003d97          	auipc	s11,0x3
    80007f18:	95cd8d93          	addi	s11,s11,-1700 # 8000a870 <digits>
    80007f1c:	00900593          	li	a1,9
    80007f20:	0006051b          	sext.w	a0,a2
    80007f24:	00000c93          	li	s9,0
    80007f28:	02079793          	slli	a5,a5,0x20
    80007f2c:	0207d793          	srli	a5,a5,0x20
    80007f30:	00fd87b3          	add	a5,s11,a5
    80007f34:	0007c783          	lbu	a5,0(a5)
    80007f38:	02e656bb          	divuw	a3,a2,a4
    80007f3c:	f8f40023          	sb	a5,-128(s0)
    80007f40:	14c5d863          	bge	a1,a2,80008090 <__printf+0x278>
    80007f44:	06300593          	li	a1,99
    80007f48:	00100c93          	li	s9,1
    80007f4c:	02e6f7bb          	remuw	a5,a3,a4
    80007f50:	02079793          	slli	a5,a5,0x20
    80007f54:	0207d793          	srli	a5,a5,0x20
    80007f58:	00fd87b3          	add	a5,s11,a5
    80007f5c:	0007c783          	lbu	a5,0(a5)
    80007f60:	02e6d73b          	divuw	a4,a3,a4
    80007f64:	f8f400a3          	sb	a5,-127(s0)
    80007f68:	12a5f463          	bgeu	a1,a0,80008090 <__printf+0x278>
    80007f6c:	00a00693          	li	a3,10
    80007f70:	00900593          	li	a1,9
    80007f74:	02d777bb          	remuw	a5,a4,a3
    80007f78:	02079793          	slli	a5,a5,0x20
    80007f7c:	0207d793          	srli	a5,a5,0x20
    80007f80:	00fd87b3          	add	a5,s11,a5
    80007f84:	0007c503          	lbu	a0,0(a5)
    80007f88:	02d757bb          	divuw	a5,a4,a3
    80007f8c:	f8a40123          	sb	a0,-126(s0)
    80007f90:	48e5f263          	bgeu	a1,a4,80008414 <__printf+0x5fc>
    80007f94:	06300513          	li	a0,99
    80007f98:	02d7f5bb          	remuw	a1,a5,a3
    80007f9c:	02059593          	slli	a1,a1,0x20
    80007fa0:	0205d593          	srli	a1,a1,0x20
    80007fa4:	00bd85b3          	add	a1,s11,a1
    80007fa8:	0005c583          	lbu	a1,0(a1)
    80007fac:	02d7d7bb          	divuw	a5,a5,a3
    80007fb0:	f8b401a3          	sb	a1,-125(s0)
    80007fb4:	48e57263          	bgeu	a0,a4,80008438 <__printf+0x620>
    80007fb8:	3e700513          	li	a0,999
    80007fbc:	02d7f5bb          	remuw	a1,a5,a3
    80007fc0:	02059593          	slli	a1,a1,0x20
    80007fc4:	0205d593          	srli	a1,a1,0x20
    80007fc8:	00bd85b3          	add	a1,s11,a1
    80007fcc:	0005c583          	lbu	a1,0(a1)
    80007fd0:	02d7d7bb          	divuw	a5,a5,a3
    80007fd4:	f8b40223          	sb	a1,-124(s0)
    80007fd8:	46e57663          	bgeu	a0,a4,80008444 <__printf+0x62c>
    80007fdc:	02d7f5bb          	remuw	a1,a5,a3
    80007fe0:	02059593          	slli	a1,a1,0x20
    80007fe4:	0205d593          	srli	a1,a1,0x20
    80007fe8:	00bd85b3          	add	a1,s11,a1
    80007fec:	0005c583          	lbu	a1,0(a1)
    80007ff0:	02d7d7bb          	divuw	a5,a5,a3
    80007ff4:	f8b402a3          	sb	a1,-123(s0)
    80007ff8:	46ea7863          	bgeu	s4,a4,80008468 <__printf+0x650>
    80007ffc:	02d7f5bb          	remuw	a1,a5,a3
    80008000:	02059593          	slli	a1,a1,0x20
    80008004:	0205d593          	srli	a1,a1,0x20
    80008008:	00bd85b3          	add	a1,s11,a1
    8000800c:	0005c583          	lbu	a1,0(a1)
    80008010:	02d7d7bb          	divuw	a5,a5,a3
    80008014:	f8b40323          	sb	a1,-122(s0)
    80008018:	3eeaf863          	bgeu	s5,a4,80008408 <__printf+0x5f0>
    8000801c:	02d7f5bb          	remuw	a1,a5,a3
    80008020:	02059593          	slli	a1,a1,0x20
    80008024:	0205d593          	srli	a1,a1,0x20
    80008028:	00bd85b3          	add	a1,s11,a1
    8000802c:	0005c583          	lbu	a1,0(a1)
    80008030:	02d7d7bb          	divuw	a5,a5,a3
    80008034:	f8b403a3          	sb	a1,-121(s0)
    80008038:	42eb7e63          	bgeu	s6,a4,80008474 <__printf+0x65c>
    8000803c:	02d7f5bb          	remuw	a1,a5,a3
    80008040:	02059593          	slli	a1,a1,0x20
    80008044:	0205d593          	srli	a1,a1,0x20
    80008048:	00bd85b3          	add	a1,s11,a1
    8000804c:	0005c583          	lbu	a1,0(a1)
    80008050:	02d7d7bb          	divuw	a5,a5,a3
    80008054:	f8b40423          	sb	a1,-120(s0)
    80008058:	42ebfc63          	bgeu	s7,a4,80008490 <__printf+0x678>
    8000805c:	02079793          	slli	a5,a5,0x20
    80008060:	0207d793          	srli	a5,a5,0x20
    80008064:	00fd8db3          	add	s11,s11,a5
    80008068:	000dc703          	lbu	a4,0(s11)
    8000806c:	00a00793          	li	a5,10
    80008070:	00900c93          	li	s9,9
    80008074:	f8e404a3          	sb	a4,-119(s0)
    80008078:	00065c63          	bgez	a2,80008090 <__printf+0x278>
    8000807c:	f9040713          	addi	a4,s0,-112
    80008080:	00f70733          	add	a4,a4,a5
    80008084:	02d00693          	li	a3,45
    80008088:	fed70823          	sb	a3,-16(a4)
    8000808c:	00078c93          	mv	s9,a5
    80008090:	f8040793          	addi	a5,s0,-128
    80008094:	01978cb3          	add	s9,a5,s9
    80008098:	f7f40d13          	addi	s10,s0,-129
    8000809c:	000cc503          	lbu	a0,0(s9)
    800080a0:	fffc8c93          	addi	s9,s9,-1
    800080a4:	00000097          	auipc	ra,0x0
    800080a8:	b90080e7          	jalr	-1136(ra) # 80007c34 <consputc>
    800080ac:	ffac98e3          	bne	s9,s10,8000809c <__printf+0x284>
    800080b0:	00094503          	lbu	a0,0(s2)
    800080b4:	e00514e3          	bnez	a0,80007ebc <__printf+0xa4>
    800080b8:	1a0c1663          	bnez	s8,80008264 <__printf+0x44c>
    800080bc:	08813083          	ld	ra,136(sp)
    800080c0:	08013403          	ld	s0,128(sp)
    800080c4:	07813483          	ld	s1,120(sp)
    800080c8:	07013903          	ld	s2,112(sp)
    800080cc:	06813983          	ld	s3,104(sp)
    800080d0:	06013a03          	ld	s4,96(sp)
    800080d4:	05813a83          	ld	s5,88(sp)
    800080d8:	05013b03          	ld	s6,80(sp)
    800080dc:	04813b83          	ld	s7,72(sp)
    800080e0:	04013c03          	ld	s8,64(sp)
    800080e4:	03813c83          	ld	s9,56(sp)
    800080e8:	03013d03          	ld	s10,48(sp)
    800080ec:	02813d83          	ld	s11,40(sp)
    800080f0:	0d010113          	addi	sp,sp,208
    800080f4:	00008067          	ret
    800080f8:	07300713          	li	a4,115
    800080fc:	1ce78a63          	beq	a5,a4,800082d0 <__printf+0x4b8>
    80008100:	07800713          	li	a4,120
    80008104:	1ee79e63          	bne	a5,a4,80008300 <__printf+0x4e8>
    80008108:	f7843783          	ld	a5,-136(s0)
    8000810c:	0007a703          	lw	a4,0(a5)
    80008110:	00878793          	addi	a5,a5,8
    80008114:	f6f43c23          	sd	a5,-136(s0)
    80008118:	28074263          	bltz	a4,8000839c <__printf+0x584>
    8000811c:	00002d97          	auipc	s11,0x2
    80008120:	754d8d93          	addi	s11,s11,1876 # 8000a870 <digits>
    80008124:	00f77793          	andi	a5,a4,15
    80008128:	00fd87b3          	add	a5,s11,a5
    8000812c:	0007c683          	lbu	a3,0(a5)
    80008130:	00f00613          	li	a2,15
    80008134:	0007079b          	sext.w	a5,a4
    80008138:	f8d40023          	sb	a3,-128(s0)
    8000813c:	0047559b          	srliw	a1,a4,0x4
    80008140:	0047569b          	srliw	a3,a4,0x4
    80008144:	00000c93          	li	s9,0
    80008148:	0ee65063          	bge	a2,a4,80008228 <__printf+0x410>
    8000814c:	00f6f693          	andi	a3,a3,15
    80008150:	00dd86b3          	add	a3,s11,a3
    80008154:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80008158:	0087d79b          	srliw	a5,a5,0x8
    8000815c:	00100c93          	li	s9,1
    80008160:	f8d400a3          	sb	a3,-127(s0)
    80008164:	0cb67263          	bgeu	a2,a1,80008228 <__printf+0x410>
    80008168:	00f7f693          	andi	a3,a5,15
    8000816c:	00dd86b3          	add	a3,s11,a3
    80008170:	0006c583          	lbu	a1,0(a3)
    80008174:	00f00613          	li	a2,15
    80008178:	0047d69b          	srliw	a3,a5,0x4
    8000817c:	f8b40123          	sb	a1,-126(s0)
    80008180:	0047d593          	srli	a1,a5,0x4
    80008184:	28f67e63          	bgeu	a2,a5,80008420 <__printf+0x608>
    80008188:	00f6f693          	andi	a3,a3,15
    8000818c:	00dd86b3          	add	a3,s11,a3
    80008190:	0006c503          	lbu	a0,0(a3)
    80008194:	0087d813          	srli	a6,a5,0x8
    80008198:	0087d69b          	srliw	a3,a5,0x8
    8000819c:	f8a401a3          	sb	a0,-125(s0)
    800081a0:	28b67663          	bgeu	a2,a1,8000842c <__printf+0x614>
    800081a4:	00f6f693          	andi	a3,a3,15
    800081a8:	00dd86b3          	add	a3,s11,a3
    800081ac:	0006c583          	lbu	a1,0(a3)
    800081b0:	00c7d513          	srli	a0,a5,0xc
    800081b4:	00c7d69b          	srliw	a3,a5,0xc
    800081b8:	f8b40223          	sb	a1,-124(s0)
    800081bc:	29067a63          	bgeu	a2,a6,80008450 <__printf+0x638>
    800081c0:	00f6f693          	andi	a3,a3,15
    800081c4:	00dd86b3          	add	a3,s11,a3
    800081c8:	0006c583          	lbu	a1,0(a3)
    800081cc:	0107d813          	srli	a6,a5,0x10
    800081d0:	0107d69b          	srliw	a3,a5,0x10
    800081d4:	f8b402a3          	sb	a1,-123(s0)
    800081d8:	28a67263          	bgeu	a2,a0,8000845c <__printf+0x644>
    800081dc:	00f6f693          	andi	a3,a3,15
    800081e0:	00dd86b3          	add	a3,s11,a3
    800081e4:	0006c683          	lbu	a3,0(a3)
    800081e8:	0147d79b          	srliw	a5,a5,0x14
    800081ec:	f8d40323          	sb	a3,-122(s0)
    800081f0:	21067663          	bgeu	a2,a6,800083fc <__printf+0x5e4>
    800081f4:	02079793          	slli	a5,a5,0x20
    800081f8:	0207d793          	srli	a5,a5,0x20
    800081fc:	00fd8db3          	add	s11,s11,a5
    80008200:	000dc683          	lbu	a3,0(s11)
    80008204:	00800793          	li	a5,8
    80008208:	00700c93          	li	s9,7
    8000820c:	f8d403a3          	sb	a3,-121(s0)
    80008210:	00075c63          	bgez	a4,80008228 <__printf+0x410>
    80008214:	f9040713          	addi	a4,s0,-112
    80008218:	00f70733          	add	a4,a4,a5
    8000821c:	02d00693          	li	a3,45
    80008220:	fed70823          	sb	a3,-16(a4)
    80008224:	00078c93          	mv	s9,a5
    80008228:	f8040793          	addi	a5,s0,-128
    8000822c:	01978cb3          	add	s9,a5,s9
    80008230:	f7f40d13          	addi	s10,s0,-129
    80008234:	000cc503          	lbu	a0,0(s9)
    80008238:	fffc8c93          	addi	s9,s9,-1
    8000823c:	00000097          	auipc	ra,0x0
    80008240:	9f8080e7          	jalr	-1544(ra) # 80007c34 <consputc>
    80008244:	ff9d18e3          	bne	s10,s9,80008234 <__printf+0x41c>
    80008248:	0100006f          	j	80008258 <__printf+0x440>
    8000824c:	00000097          	auipc	ra,0x0
    80008250:	9e8080e7          	jalr	-1560(ra) # 80007c34 <consputc>
    80008254:	000c8493          	mv	s1,s9
    80008258:	00094503          	lbu	a0,0(s2)
    8000825c:	c60510e3          	bnez	a0,80007ebc <__printf+0xa4>
    80008260:	e40c0ee3          	beqz	s8,800080bc <__printf+0x2a4>
    80008264:	0000a517          	auipc	a0,0xa
    80008268:	5fc50513          	addi	a0,a0,1532 # 80012860 <pr>
    8000826c:	00001097          	auipc	ra,0x1
    80008270:	94c080e7          	jalr	-1716(ra) # 80008bb8 <release>
    80008274:	e49ff06f          	j	800080bc <__printf+0x2a4>
    80008278:	f7843783          	ld	a5,-136(s0)
    8000827c:	03000513          	li	a0,48
    80008280:	01000d13          	li	s10,16
    80008284:	00878713          	addi	a4,a5,8
    80008288:	0007bc83          	ld	s9,0(a5)
    8000828c:	f6e43c23          	sd	a4,-136(s0)
    80008290:	00000097          	auipc	ra,0x0
    80008294:	9a4080e7          	jalr	-1628(ra) # 80007c34 <consputc>
    80008298:	07800513          	li	a0,120
    8000829c:	00000097          	auipc	ra,0x0
    800082a0:	998080e7          	jalr	-1640(ra) # 80007c34 <consputc>
    800082a4:	00002d97          	auipc	s11,0x2
    800082a8:	5ccd8d93          	addi	s11,s11,1484 # 8000a870 <digits>
    800082ac:	03ccd793          	srli	a5,s9,0x3c
    800082b0:	00fd87b3          	add	a5,s11,a5
    800082b4:	0007c503          	lbu	a0,0(a5)
    800082b8:	fffd0d1b          	addiw	s10,s10,-1
    800082bc:	004c9c93          	slli	s9,s9,0x4
    800082c0:	00000097          	auipc	ra,0x0
    800082c4:	974080e7          	jalr	-1676(ra) # 80007c34 <consputc>
    800082c8:	fe0d12e3          	bnez	s10,800082ac <__printf+0x494>
    800082cc:	f8dff06f          	j	80008258 <__printf+0x440>
    800082d0:	f7843783          	ld	a5,-136(s0)
    800082d4:	0007bc83          	ld	s9,0(a5)
    800082d8:	00878793          	addi	a5,a5,8
    800082dc:	f6f43c23          	sd	a5,-136(s0)
    800082e0:	000c9a63          	bnez	s9,800082f4 <__printf+0x4dc>
    800082e4:	1080006f          	j	800083ec <__printf+0x5d4>
    800082e8:	001c8c93          	addi	s9,s9,1
    800082ec:	00000097          	auipc	ra,0x0
    800082f0:	948080e7          	jalr	-1720(ra) # 80007c34 <consputc>
    800082f4:	000cc503          	lbu	a0,0(s9)
    800082f8:	fe0518e3          	bnez	a0,800082e8 <__printf+0x4d0>
    800082fc:	f5dff06f          	j	80008258 <__printf+0x440>
    80008300:	02500513          	li	a0,37
    80008304:	00000097          	auipc	ra,0x0
    80008308:	930080e7          	jalr	-1744(ra) # 80007c34 <consputc>
    8000830c:	000c8513          	mv	a0,s9
    80008310:	00000097          	auipc	ra,0x0
    80008314:	924080e7          	jalr	-1756(ra) # 80007c34 <consputc>
    80008318:	f41ff06f          	j	80008258 <__printf+0x440>
    8000831c:	02500513          	li	a0,37
    80008320:	00000097          	auipc	ra,0x0
    80008324:	914080e7          	jalr	-1772(ra) # 80007c34 <consputc>
    80008328:	f31ff06f          	j	80008258 <__printf+0x440>
    8000832c:	00030513          	mv	a0,t1
    80008330:	00000097          	auipc	ra,0x0
    80008334:	7bc080e7          	jalr	1980(ra) # 80008aec <acquire>
    80008338:	b4dff06f          	j	80007e84 <__printf+0x6c>
    8000833c:	40c0053b          	negw	a0,a2
    80008340:	00a00713          	li	a4,10
    80008344:	02e576bb          	remuw	a3,a0,a4
    80008348:	00002d97          	auipc	s11,0x2
    8000834c:	528d8d93          	addi	s11,s11,1320 # 8000a870 <digits>
    80008350:	ff700593          	li	a1,-9
    80008354:	02069693          	slli	a3,a3,0x20
    80008358:	0206d693          	srli	a3,a3,0x20
    8000835c:	00dd86b3          	add	a3,s11,a3
    80008360:	0006c683          	lbu	a3,0(a3)
    80008364:	02e557bb          	divuw	a5,a0,a4
    80008368:	f8d40023          	sb	a3,-128(s0)
    8000836c:	10b65e63          	bge	a2,a1,80008488 <__printf+0x670>
    80008370:	06300593          	li	a1,99
    80008374:	02e7f6bb          	remuw	a3,a5,a4
    80008378:	02069693          	slli	a3,a3,0x20
    8000837c:	0206d693          	srli	a3,a3,0x20
    80008380:	00dd86b3          	add	a3,s11,a3
    80008384:	0006c683          	lbu	a3,0(a3)
    80008388:	02e7d73b          	divuw	a4,a5,a4
    8000838c:	00200793          	li	a5,2
    80008390:	f8d400a3          	sb	a3,-127(s0)
    80008394:	bca5ece3          	bltu	a1,a0,80007f6c <__printf+0x154>
    80008398:	ce5ff06f          	j	8000807c <__printf+0x264>
    8000839c:	40e007bb          	negw	a5,a4
    800083a0:	00002d97          	auipc	s11,0x2
    800083a4:	4d0d8d93          	addi	s11,s11,1232 # 8000a870 <digits>
    800083a8:	00f7f693          	andi	a3,a5,15
    800083ac:	00dd86b3          	add	a3,s11,a3
    800083b0:	0006c583          	lbu	a1,0(a3)
    800083b4:	ff100613          	li	a2,-15
    800083b8:	0047d69b          	srliw	a3,a5,0x4
    800083bc:	f8b40023          	sb	a1,-128(s0)
    800083c0:	0047d59b          	srliw	a1,a5,0x4
    800083c4:	0ac75e63          	bge	a4,a2,80008480 <__printf+0x668>
    800083c8:	00f6f693          	andi	a3,a3,15
    800083cc:	00dd86b3          	add	a3,s11,a3
    800083d0:	0006c603          	lbu	a2,0(a3)
    800083d4:	00f00693          	li	a3,15
    800083d8:	0087d79b          	srliw	a5,a5,0x8
    800083dc:	f8c400a3          	sb	a2,-127(s0)
    800083e0:	d8b6e4e3          	bltu	a3,a1,80008168 <__printf+0x350>
    800083e4:	00200793          	li	a5,2
    800083e8:	e2dff06f          	j	80008214 <__printf+0x3fc>
    800083ec:	00002c97          	auipc	s9,0x2
    800083f0:	464c8c93          	addi	s9,s9,1124 # 8000a850 <CONSOLE_STATUS+0x840>
    800083f4:	02800513          	li	a0,40
    800083f8:	ef1ff06f          	j	800082e8 <__printf+0x4d0>
    800083fc:	00700793          	li	a5,7
    80008400:	00600c93          	li	s9,6
    80008404:	e0dff06f          	j	80008210 <__printf+0x3f8>
    80008408:	00700793          	li	a5,7
    8000840c:	00600c93          	li	s9,6
    80008410:	c69ff06f          	j	80008078 <__printf+0x260>
    80008414:	00300793          	li	a5,3
    80008418:	00200c93          	li	s9,2
    8000841c:	c5dff06f          	j	80008078 <__printf+0x260>
    80008420:	00300793          	li	a5,3
    80008424:	00200c93          	li	s9,2
    80008428:	de9ff06f          	j	80008210 <__printf+0x3f8>
    8000842c:	00400793          	li	a5,4
    80008430:	00300c93          	li	s9,3
    80008434:	dddff06f          	j	80008210 <__printf+0x3f8>
    80008438:	00400793          	li	a5,4
    8000843c:	00300c93          	li	s9,3
    80008440:	c39ff06f          	j	80008078 <__printf+0x260>
    80008444:	00500793          	li	a5,5
    80008448:	00400c93          	li	s9,4
    8000844c:	c2dff06f          	j	80008078 <__printf+0x260>
    80008450:	00500793          	li	a5,5
    80008454:	00400c93          	li	s9,4
    80008458:	db9ff06f          	j	80008210 <__printf+0x3f8>
    8000845c:	00600793          	li	a5,6
    80008460:	00500c93          	li	s9,5
    80008464:	dadff06f          	j	80008210 <__printf+0x3f8>
    80008468:	00600793          	li	a5,6
    8000846c:	00500c93          	li	s9,5
    80008470:	c09ff06f          	j	80008078 <__printf+0x260>
    80008474:	00800793          	li	a5,8
    80008478:	00700c93          	li	s9,7
    8000847c:	bfdff06f          	j	80008078 <__printf+0x260>
    80008480:	00100793          	li	a5,1
    80008484:	d91ff06f          	j	80008214 <__printf+0x3fc>
    80008488:	00100793          	li	a5,1
    8000848c:	bf1ff06f          	j	8000807c <__printf+0x264>
    80008490:	00900793          	li	a5,9
    80008494:	00800c93          	li	s9,8
    80008498:	be1ff06f          	j	80008078 <__printf+0x260>
    8000849c:	00002517          	auipc	a0,0x2
    800084a0:	3bc50513          	addi	a0,a0,956 # 8000a858 <CONSOLE_STATUS+0x848>
    800084a4:	00000097          	auipc	ra,0x0
    800084a8:	918080e7          	jalr	-1768(ra) # 80007dbc <panic>

00000000800084ac <printfinit>:
    800084ac:	fe010113          	addi	sp,sp,-32
    800084b0:	00813823          	sd	s0,16(sp)
    800084b4:	00913423          	sd	s1,8(sp)
    800084b8:	00113c23          	sd	ra,24(sp)
    800084bc:	02010413          	addi	s0,sp,32
    800084c0:	0000a497          	auipc	s1,0xa
    800084c4:	3a048493          	addi	s1,s1,928 # 80012860 <pr>
    800084c8:	00048513          	mv	a0,s1
    800084cc:	00002597          	auipc	a1,0x2
    800084d0:	39c58593          	addi	a1,a1,924 # 8000a868 <CONSOLE_STATUS+0x858>
    800084d4:	00000097          	auipc	ra,0x0
    800084d8:	5f4080e7          	jalr	1524(ra) # 80008ac8 <initlock>
    800084dc:	01813083          	ld	ra,24(sp)
    800084e0:	01013403          	ld	s0,16(sp)
    800084e4:	0004ac23          	sw	zero,24(s1)
    800084e8:	00813483          	ld	s1,8(sp)
    800084ec:	02010113          	addi	sp,sp,32
    800084f0:	00008067          	ret

00000000800084f4 <uartinit>:
    800084f4:	ff010113          	addi	sp,sp,-16
    800084f8:	00813423          	sd	s0,8(sp)
    800084fc:	01010413          	addi	s0,sp,16
    80008500:	100007b7          	lui	a5,0x10000
    80008504:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80008508:	f8000713          	li	a4,-128
    8000850c:	00e781a3          	sb	a4,3(a5)
    80008510:	00300713          	li	a4,3
    80008514:	00e78023          	sb	a4,0(a5)
    80008518:	000780a3          	sb	zero,1(a5)
    8000851c:	00e781a3          	sb	a4,3(a5)
    80008520:	00700693          	li	a3,7
    80008524:	00d78123          	sb	a3,2(a5)
    80008528:	00e780a3          	sb	a4,1(a5)
    8000852c:	00813403          	ld	s0,8(sp)
    80008530:	01010113          	addi	sp,sp,16
    80008534:	00008067          	ret

0000000080008538 <uartputc>:
    80008538:	00005797          	auipc	a5,0x5
    8000853c:	e907a783          	lw	a5,-368(a5) # 8000d3c8 <panicked>
    80008540:	00078463          	beqz	a5,80008548 <uartputc+0x10>
    80008544:	0000006f          	j	80008544 <uartputc+0xc>
    80008548:	fd010113          	addi	sp,sp,-48
    8000854c:	02813023          	sd	s0,32(sp)
    80008550:	00913c23          	sd	s1,24(sp)
    80008554:	01213823          	sd	s2,16(sp)
    80008558:	01313423          	sd	s3,8(sp)
    8000855c:	02113423          	sd	ra,40(sp)
    80008560:	03010413          	addi	s0,sp,48
    80008564:	00005917          	auipc	s2,0x5
    80008568:	e6c90913          	addi	s2,s2,-404 # 8000d3d0 <uart_tx_r>
    8000856c:	00093783          	ld	a5,0(s2)
    80008570:	00005497          	auipc	s1,0x5
    80008574:	e6848493          	addi	s1,s1,-408 # 8000d3d8 <uart_tx_w>
    80008578:	0004b703          	ld	a4,0(s1)
    8000857c:	02078693          	addi	a3,a5,32
    80008580:	00050993          	mv	s3,a0
    80008584:	02e69c63          	bne	a3,a4,800085bc <uartputc+0x84>
    80008588:	00001097          	auipc	ra,0x1
    8000858c:	834080e7          	jalr	-1996(ra) # 80008dbc <push_on>
    80008590:	00093783          	ld	a5,0(s2)
    80008594:	0004b703          	ld	a4,0(s1)
    80008598:	02078793          	addi	a5,a5,32
    8000859c:	00e79463          	bne	a5,a4,800085a4 <uartputc+0x6c>
    800085a0:	0000006f          	j	800085a0 <uartputc+0x68>
    800085a4:	00001097          	auipc	ra,0x1
    800085a8:	88c080e7          	jalr	-1908(ra) # 80008e30 <pop_on>
    800085ac:	00093783          	ld	a5,0(s2)
    800085b0:	0004b703          	ld	a4,0(s1)
    800085b4:	02078693          	addi	a3,a5,32
    800085b8:	fce688e3          	beq	a3,a4,80008588 <uartputc+0x50>
    800085bc:	01f77693          	andi	a3,a4,31
    800085c0:	0000a597          	auipc	a1,0xa
    800085c4:	2c058593          	addi	a1,a1,704 # 80012880 <uart_tx_buf>
    800085c8:	00d586b3          	add	a3,a1,a3
    800085cc:	00170713          	addi	a4,a4,1
    800085d0:	01368023          	sb	s3,0(a3)
    800085d4:	00e4b023          	sd	a4,0(s1)
    800085d8:	10000637          	lui	a2,0x10000
    800085dc:	02f71063          	bne	a4,a5,800085fc <uartputc+0xc4>
    800085e0:	0340006f          	j	80008614 <uartputc+0xdc>
    800085e4:	00074703          	lbu	a4,0(a4)
    800085e8:	00f93023          	sd	a5,0(s2)
    800085ec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800085f0:	00093783          	ld	a5,0(s2)
    800085f4:	0004b703          	ld	a4,0(s1)
    800085f8:	00f70e63          	beq	a4,a5,80008614 <uartputc+0xdc>
    800085fc:	00564683          	lbu	a3,5(a2)
    80008600:	01f7f713          	andi	a4,a5,31
    80008604:	00e58733          	add	a4,a1,a4
    80008608:	0206f693          	andi	a3,a3,32
    8000860c:	00178793          	addi	a5,a5,1
    80008610:	fc069ae3          	bnez	a3,800085e4 <uartputc+0xac>
    80008614:	02813083          	ld	ra,40(sp)
    80008618:	02013403          	ld	s0,32(sp)
    8000861c:	01813483          	ld	s1,24(sp)
    80008620:	01013903          	ld	s2,16(sp)
    80008624:	00813983          	ld	s3,8(sp)
    80008628:	03010113          	addi	sp,sp,48
    8000862c:	00008067          	ret

0000000080008630 <uartputc_sync>:
    80008630:	ff010113          	addi	sp,sp,-16
    80008634:	00813423          	sd	s0,8(sp)
    80008638:	01010413          	addi	s0,sp,16
    8000863c:	00005717          	auipc	a4,0x5
    80008640:	d8c72703          	lw	a4,-628(a4) # 8000d3c8 <panicked>
    80008644:	02071663          	bnez	a4,80008670 <uartputc_sync+0x40>
    80008648:	00050793          	mv	a5,a0
    8000864c:	100006b7          	lui	a3,0x10000
    80008650:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008654:	02077713          	andi	a4,a4,32
    80008658:	fe070ce3          	beqz	a4,80008650 <uartputc_sync+0x20>
    8000865c:	0ff7f793          	andi	a5,a5,255
    80008660:	00f68023          	sb	a5,0(a3)
    80008664:	00813403          	ld	s0,8(sp)
    80008668:	01010113          	addi	sp,sp,16
    8000866c:	00008067          	ret
    80008670:	0000006f          	j	80008670 <uartputc_sync+0x40>

0000000080008674 <uartstart>:
    80008674:	ff010113          	addi	sp,sp,-16
    80008678:	00813423          	sd	s0,8(sp)
    8000867c:	01010413          	addi	s0,sp,16
    80008680:	00005617          	auipc	a2,0x5
    80008684:	d5060613          	addi	a2,a2,-688 # 8000d3d0 <uart_tx_r>
    80008688:	00005517          	auipc	a0,0x5
    8000868c:	d5050513          	addi	a0,a0,-688 # 8000d3d8 <uart_tx_w>
    80008690:	00063783          	ld	a5,0(a2)
    80008694:	00053703          	ld	a4,0(a0)
    80008698:	04f70263          	beq	a4,a5,800086dc <uartstart+0x68>
    8000869c:	100005b7          	lui	a1,0x10000
    800086a0:	0000a817          	auipc	a6,0xa
    800086a4:	1e080813          	addi	a6,a6,480 # 80012880 <uart_tx_buf>
    800086a8:	01c0006f          	j	800086c4 <uartstart+0x50>
    800086ac:	0006c703          	lbu	a4,0(a3)
    800086b0:	00f63023          	sd	a5,0(a2)
    800086b4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800086b8:	00063783          	ld	a5,0(a2)
    800086bc:	00053703          	ld	a4,0(a0)
    800086c0:	00f70e63          	beq	a4,a5,800086dc <uartstart+0x68>
    800086c4:	01f7f713          	andi	a4,a5,31
    800086c8:	00e806b3          	add	a3,a6,a4
    800086cc:	0055c703          	lbu	a4,5(a1)
    800086d0:	00178793          	addi	a5,a5,1
    800086d4:	02077713          	andi	a4,a4,32
    800086d8:	fc071ae3          	bnez	a4,800086ac <uartstart+0x38>
    800086dc:	00813403          	ld	s0,8(sp)
    800086e0:	01010113          	addi	sp,sp,16
    800086e4:	00008067          	ret

00000000800086e8 <uartgetc>:
    800086e8:	ff010113          	addi	sp,sp,-16
    800086ec:	00813423          	sd	s0,8(sp)
    800086f0:	01010413          	addi	s0,sp,16
    800086f4:	10000737          	lui	a4,0x10000
    800086f8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800086fc:	0017f793          	andi	a5,a5,1
    80008700:	00078c63          	beqz	a5,80008718 <uartgetc+0x30>
    80008704:	00074503          	lbu	a0,0(a4)
    80008708:	0ff57513          	andi	a0,a0,255
    8000870c:	00813403          	ld	s0,8(sp)
    80008710:	01010113          	addi	sp,sp,16
    80008714:	00008067          	ret
    80008718:	fff00513          	li	a0,-1
    8000871c:	ff1ff06f          	j	8000870c <uartgetc+0x24>

0000000080008720 <uartintr>:
    80008720:	100007b7          	lui	a5,0x10000
    80008724:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80008728:	0017f793          	andi	a5,a5,1
    8000872c:	0a078463          	beqz	a5,800087d4 <uartintr+0xb4>
    80008730:	fe010113          	addi	sp,sp,-32
    80008734:	00813823          	sd	s0,16(sp)
    80008738:	00913423          	sd	s1,8(sp)
    8000873c:	00113c23          	sd	ra,24(sp)
    80008740:	02010413          	addi	s0,sp,32
    80008744:	100004b7          	lui	s1,0x10000
    80008748:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000874c:	0ff57513          	andi	a0,a0,255
    80008750:	fffff097          	auipc	ra,0xfffff
    80008754:	534080e7          	jalr	1332(ra) # 80007c84 <consoleintr>
    80008758:	0054c783          	lbu	a5,5(s1)
    8000875c:	0017f793          	andi	a5,a5,1
    80008760:	fe0794e3          	bnez	a5,80008748 <uartintr+0x28>
    80008764:	00005617          	auipc	a2,0x5
    80008768:	c6c60613          	addi	a2,a2,-916 # 8000d3d0 <uart_tx_r>
    8000876c:	00005517          	auipc	a0,0x5
    80008770:	c6c50513          	addi	a0,a0,-916 # 8000d3d8 <uart_tx_w>
    80008774:	00063783          	ld	a5,0(a2)
    80008778:	00053703          	ld	a4,0(a0)
    8000877c:	04f70263          	beq	a4,a5,800087c0 <uartintr+0xa0>
    80008780:	100005b7          	lui	a1,0x10000
    80008784:	0000a817          	auipc	a6,0xa
    80008788:	0fc80813          	addi	a6,a6,252 # 80012880 <uart_tx_buf>
    8000878c:	01c0006f          	j	800087a8 <uartintr+0x88>
    80008790:	0006c703          	lbu	a4,0(a3)
    80008794:	00f63023          	sd	a5,0(a2)
    80008798:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000879c:	00063783          	ld	a5,0(a2)
    800087a0:	00053703          	ld	a4,0(a0)
    800087a4:	00f70e63          	beq	a4,a5,800087c0 <uartintr+0xa0>
    800087a8:	01f7f713          	andi	a4,a5,31
    800087ac:	00e806b3          	add	a3,a6,a4
    800087b0:	0055c703          	lbu	a4,5(a1)
    800087b4:	00178793          	addi	a5,a5,1
    800087b8:	02077713          	andi	a4,a4,32
    800087bc:	fc071ae3          	bnez	a4,80008790 <uartintr+0x70>
    800087c0:	01813083          	ld	ra,24(sp)
    800087c4:	01013403          	ld	s0,16(sp)
    800087c8:	00813483          	ld	s1,8(sp)
    800087cc:	02010113          	addi	sp,sp,32
    800087d0:	00008067          	ret
    800087d4:	00005617          	auipc	a2,0x5
    800087d8:	bfc60613          	addi	a2,a2,-1028 # 8000d3d0 <uart_tx_r>
    800087dc:	00005517          	auipc	a0,0x5
    800087e0:	bfc50513          	addi	a0,a0,-1028 # 8000d3d8 <uart_tx_w>
    800087e4:	00063783          	ld	a5,0(a2)
    800087e8:	00053703          	ld	a4,0(a0)
    800087ec:	04f70263          	beq	a4,a5,80008830 <uartintr+0x110>
    800087f0:	100005b7          	lui	a1,0x10000
    800087f4:	0000a817          	auipc	a6,0xa
    800087f8:	08c80813          	addi	a6,a6,140 # 80012880 <uart_tx_buf>
    800087fc:	01c0006f          	j	80008818 <uartintr+0xf8>
    80008800:	0006c703          	lbu	a4,0(a3)
    80008804:	00f63023          	sd	a5,0(a2)
    80008808:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000880c:	00063783          	ld	a5,0(a2)
    80008810:	00053703          	ld	a4,0(a0)
    80008814:	02f70063          	beq	a4,a5,80008834 <uartintr+0x114>
    80008818:	01f7f713          	andi	a4,a5,31
    8000881c:	00e806b3          	add	a3,a6,a4
    80008820:	0055c703          	lbu	a4,5(a1)
    80008824:	00178793          	addi	a5,a5,1
    80008828:	02077713          	andi	a4,a4,32
    8000882c:	fc071ae3          	bnez	a4,80008800 <uartintr+0xe0>
    80008830:	00008067          	ret
    80008834:	00008067          	ret

0000000080008838 <kinit>:
    80008838:	fc010113          	addi	sp,sp,-64
    8000883c:	02913423          	sd	s1,40(sp)
    80008840:	fffff7b7          	lui	a5,0xfffff
    80008844:	0000b497          	auipc	s1,0xb
    80008848:	05b48493          	addi	s1,s1,91 # 8001389f <end+0xfff>
    8000884c:	02813823          	sd	s0,48(sp)
    80008850:	01313c23          	sd	s3,24(sp)
    80008854:	00f4f4b3          	and	s1,s1,a5
    80008858:	02113c23          	sd	ra,56(sp)
    8000885c:	03213023          	sd	s2,32(sp)
    80008860:	01413823          	sd	s4,16(sp)
    80008864:	01513423          	sd	s5,8(sp)
    80008868:	04010413          	addi	s0,sp,64
    8000886c:	000017b7          	lui	a5,0x1
    80008870:	01100993          	li	s3,17
    80008874:	00f487b3          	add	a5,s1,a5
    80008878:	01b99993          	slli	s3,s3,0x1b
    8000887c:	06f9e063          	bltu	s3,a5,800088dc <kinit+0xa4>
    80008880:	0000aa97          	auipc	s5,0xa
    80008884:	020a8a93          	addi	s5,s5,32 # 800128a0 <end>
    80008888:	0754ec63          	bltu	s1,s5,80008900 <kinit+0xc8>
    8000888c:	0734fa63          	bgeu	s1,s3,80008900 <kinit+0xc8>
    80008890:	00088a37          	lui	s4,0x88
    80008894:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008898:	00005917          	auipc	s2,0x5
    8000889c:	b4890913          	addi	s2,s2,-1208 # 8000d3e0 <kmem>
    800088a0:	00ca1a13          	slli	s4,s4,0xc
    800088a4:	0140006f          	j	800088b8 <kinit+0x80>
    800088a8:	000017b7          	lui	a5,0x1
    800088ac:	00f484b3          	add	s1,s1,a5
    800088b0:	0554e863          	bltu	s1,s5,80008900 <kinit+0xc8>
    800088b4:	0534f663          	bgeu	s1,s3,80008900 <kinit+0xc8>
    800088b8:	00001637          	lui	a2,0x1
    800088bc:	00100593          	li	a1,1
    800088c0:	00048513          	mv	a0,s1
    800088c4:	00000097          	auipc	ra,0x0
    800088c8:	5e4080e7          	jalr	1508(ra) # 80008ea8 <__memset>
    800088cc:	00093783          	ld	a5,0(s2)
    800088d0:	00f4b023          	sd	a5,0(s1)
    800088d4:	00993023          	sd	s1,0(s2)
    800088d8:	fd4498e3          	bne	s1,s4,800088a8 <kinit+0x70>
    800088dc:	03813083          	ld	ra,56(sp)
    800088e0:	03013403          	ld	s0,48(sp)
    800088e4:	02813483          	ld	s1,40(sp)
    800088e8:	02013903          	ld	s2,32(sp)
    800088ec:	01813983          	ld	s3,24(sp)
    800088f0:	01013a03          	ld	s4,16(sp)
    800088f4:	00813a83          	ld	s5,8(sp)
    800088f8:	04010113          	addi	sp,sp,64
    800088fc:	00008067          	ret
    80008900:	00002517          	auipc	a0,0x2
    80008904:	f8850513          	addi	a0,a0,-120 # 8000a888 <digits+0x18>
    80008908:	fffff097          	auipc	ra,0xfffff
    8000890c:	4b4080e7          	jalr	1204(ra) # 80007dbc <panic>

0000000080008910 <freerange>:
    80008910:	fc010113          	addi	sp,sp,-64
    80008914:	000017b7          	lui	a5,0x1
    80008918:	02913423          	sd	s1,40(sp)
    8000891c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80008920:	009504b3          	add	s1,a0,s1
    80008924:	fffff537          	lui	a0,0xfffff
    80008928:	02813823          	sd	s0,48(sp)
    8000892c:	02113c23          	sd	ra,56(sp)
    80008930:	03213023          	sd	s2,32(sp)
    80008934:	01313c23          	sd	s3,24(sp)
    80008938:	01413823          	sd	s4,16(sp)
    8000893c:	01513423          	sd	s5,8(sp)
    80008940:	01613023          	sd	s6,0(sp)
    80008944:	04010413          	addi	s0,sp,64
    80008948:	00a4f4b3          	and	s1,s1,a0
    8000894c:	00f487b3          	add	a5,s1,a5
    80008950:	06f5e463          	bltu	a1,a5,800089b8 <freerange+0xa8>
    80008954:	0000aa97          	auipc	s5,0xa
    80008958:	f4ca8a93          	addi	s5,s5,-180 # 800128a0 <end>
    8000895c:	0954e263          	bltu	s1,s5,800089e0 <freerange+0xd0>
    80008960:	01100993          	li	s3,17
    80008964:	01b99993          	slli	s3,s3,0x1b
    80008968:	0734fc63          	bgeu	s1,s3,800089e0 <freerange+0xd0>
    8000896c:	00058a13          	mv	s4,a1
    80008970:	00005917          	auipc	s2,0x5
    80008974:	a7090913          	addi	s2,s2,-1424 # 8000d3e0 <kmem>
    80008978:	00002b37          	lui	s6,0x2
    8000897c:	0140006f          	j	80008990 <freerange+0x80>
    80008980:	000017b7          	lui	a5,0x1
    80008984:	00f484b3          	add	s1,s1,a5
    80008988:	0554ec63          	bltu	s1,s5,800089e0 <freerange+0xd0>
    8000898c:	0534fa63          	bgeu	s1,s3,800089e0 <freerange+0xd0>
    80008990:	00001637          	lui	a2,0x1
    80008994:	00100593          	li	a1,1
    80008998:	00048513          	mv	a0,s1
    8000899c:	00000097          	auipc	ra,0x0
    800089a0:	50c080e7          	jalr	1292(ra) # 80008ea8 <__memset>
    800089a4:	00093703          	ld	a4,0(s2)
    800089a8:	016487b3          	add	a5,s1,s6
    800089ac:	00e4b023          	sd	a4,0(s1)
    800089b0:	00993023          	sd	s1,0(s2)
    800089b4:	fcfa76e3          	bgeu	s4,a5,80008980 <freerange+0x70>
    800089b8:	03813083          	ld	ra,56(sp)
    800089bc:	03013403          	ld	s0,48(sp)
    800089c0:	02813483          	ld	s1,40(sp)
    800089c4:	02013903          	ld	s2,32(sp)
    800089c8:	01813983          	ld	s3,24(sp)
    800089cc:	01013a03          	ld	s4,16(sp)
    800089d0:	00813a83          	ld	s5,8(sp)
    800089d4:	00013b03          	ld	s6,0(sp)
    800089d8:	04010113          	addi	sp,sp,64
    800089dc:	00008067          	ret
    800089e0:	00002517          	auipc	a0,0x2
    800089e4:	ea850513          	addi	a0,a0,-344 # 8000a888 <digits+0x18>
    800089e8:	fffff097          	auipc	ra,0xfffff
    800089ec:	3d4080e7          	jalr	980(ra) # 80007dbc <panic>

00000000800089f0 <kfree>:
    800089f0:	fe010113          	addi	sp,sp,-32
    800089f4:	00813823          	sd	s0,16(sp)
    800089f8:	00113c23          	sd	ra,24(sp)
    800089fc:	00913423          	sd	s1,8(sp)
    80008a00:	02010413          	addi	s0,sp,32
    80008a04:	03451793          	slli	a5,a0,0x34
    80008a08:	04079c63          	bnez	a5,80008a60 <kfree+0x70>
    80008a0c:	0000a797          	auipc	a5,0xa
    80008a10:	e9478793          	addi	a5,a5,-364 # 800128a0 <end>
    80008a14:	00050493          	mv	s1,a0
    80008a18:	04f56463          	bltu	a0,a5,80008a60 <kfree+0x70>
    80008a1c:	01100793          	li	a5,17
    80008a20:	01b79793          	slli	a5,a5,0x1b
    80008a24:	02f57e63          	bgeu	a0,a5,80008a60 <kfree+0x70>
    80008a28:	00001637          	lui	a2,0x1
    80008a2c:	00100593          	li	a1,1
    80008a30:	00000097          	auipc	ra,0x0
    80008a34:	478080e7          	jalr	1144(ra) # 80008ea8 <__memset>
    80008a38:	00005797          	auipc	a5,0x5
    80008a3c:	9a878793          	addi	a5,a5,-1624 # 8000d3e0 <kmem>
    80008a40:	0007b703          	ld	a4,0(a5)
    80008a44:	01813083          	ld	ra,24(sp)
    80008a48:	01013403          	ld	s0,16(sp)
    80008a4c:	00e4b023          	sd	a4,0(s1)
    80008a50:	0097b023          	sd	s1,0(a5)
    80008a54:	00813483          	ld	s1,8(sp)
    80008a58:	02010113          	addi	sp,sp,32
    80008a5c:	00008067          	ret
    80008a60:	00002517          	auipc	a0,0x2
    80008a64:	e2850513          	addi	a0,a0,-472 # 8000a888 <digits+0x18>
    80008a68:	fffff097          	auipc	ra,0xfffff
    80008a6c:	354080e7          	jalr	852(ra) # 80007dbc <panic>

0000000080008a70 <kalloc>:
    80008a70:	fe010113          	addi	sp,sp,-32
    80008a74:	00813823          	sd	s0,16(sp)
    80008a78:	00913423          	sd	s1,8(sp)
    80008a7c:	00113c23          	sd	ra,24(sp)
    80008a80:	02010413          	addi	s0,sp,32
    80008a84:	00005797          	auipc	a5,0x5
    80008a88:	95c78793          	addi	a5,a5,-1700 # 8000d3e0 <kmem>
    80008a8c:	0007b483          	ld	s1,0(a5)
    80008a90:	02048063          	beqz	s1,80008ab0 <kalloc+0x40>
    80008a94:	0004b703          	ld	a4,0(s1)
    80008a98:	00001637          	lui	a2,0x1
    80008a9c:	00500593          	li	a1,5
    80008aa0:	00048513          	mv	a0,s1
    80008aa4:	00e7b023          	sd	a4,0(a5)
    80008aa8:	00000097          	auipc	ra,0x0
    80008aac:	400080e7          	jalr	1024(ra) # 80008ea8 <__memset>
    80008ab0:	01813083          	ld	ra,24(sp)
    80008ab4:	01013403          	ld	s0,16(sp)
    80008ab8:	00048513          	mv	a0,s1
    80008abc:	00813483          	ld	s1,8(sp)
    80008ac0:	02010113          	addi	sp,sp,32
    80008ac4:	00008067          	ret

0000000080008ac8 <initlock>:
    80008ac8:	ff010113          	addi	sp,sp,-16
    80008acc:	00813423          	sd	s0,8(sp)
    80008ad0:	01010413          	addi	s0,sp,16
    80008ad4:	00813403          	ld	s0,8(sp)
    80008ad8:	00b53423          	sd	a1,8(a0)
    80008adc:	00052023          	sw	zero,0(a0)
    80008ae0:	00053823          	sd	zero,16(a0)
    80008ae4:	01010113          	addi	sp,sp,16
    80008ae8:	00008067          	ret

0000000080008aec <acquire>:
    80008aec:	fe010113          	addi	sp,sp,-32
    80008af0:	00813823          	sd	s0,16(sp)
    80008af4:	00913423          	sd	s1,8(sp)
    80008af8:	00113c23          	sd	ra,24(sp)
    80008afc:	01213023          	sd	s2,0(sp)
    80008b00:	02010413          	addi	s0,sp,32
    80008b04:	00050493          	mv	s1,a0
    80008b08:	10002973          	csrr	s2,sstatus
    80008b0c:	100027f3          	csrr	a5,sstatus
    80008b10:	ffd7f793          	andi	a5,a5,-3
    80008b14:	10079073          	csrw	sstatus,a5
    80008b18:	fffff097          	auipc	ra,0xfffff
    80008b1c:	8e0080e7          	jalr	-1824(ra) # 800073f8 <mycpu>
    80008b20:	07852783          	lw	a5,120(a0)
    80008b24:	06078e63          	beqz	a5,80008ba0 <acquire+0xb4>
    80008b28:	fffff097          	auipc	ra,0xfffff
    80008b2c:	8d0080e7          	jalr	-1840(ra) # 800073f8 <mycpu>
    80008b30:	07852783          	lw	a5,120(a0)
    80008b34:	0004a703          	lw	a4,0(s1)
    80008b38:	0017879b          	addiw	a5,a5,1
    80008b3c:	06f52c23          	sw	a5,120(a0)
    80008b40:	04071063          	bnez	a4,80008b80 <acquire+0x94>
    80008b44:	00100713          	li	a4,1
    80008b48:	00070793          	mv	a5,a4
    80008b4c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008b50:	0007879b          	sext.w	a5,a5
    80008b54:	fe079ae3          	bnez	a5,80008b48 <acquire+0x5c>
    80008b58:	0ff0000f          	fence
    80008b5c:	fffff097          	auipc	ra,0xfffff
    80008b60:	89c080e7          	jalr	-1892(ra) # 800073f8 <mycpu>
    80008b64:	01813083          	ld	ra,24(sp)
    80008b68:	01013403          	ld	s0,16(sp)
    80008b6c:	00a4b823          	sd	a0,16(s1)
    80008b70:	00013903          	ld	s2,0(sp)
    80008b74:	00813483          	ld	s1,8(sp)
    80008b78:	02010113          	addi	sp,sp,32
    80008b7c:	00008067          	ret
    80008b80:	0104b903          	ld	s2,16(s1)
    80008b84:	fffff097          	auipc	ra,0xfffff
    80008b88:	874080e7          	jalr	-1932(ra) # 800073f8 <mycpu>
    80008b8c:	faa91ce3          	bne	s2,a0,80008b44 <acquire+0x58>
    80008b90:	00002517          	auipc	a0,0x2
    80008b94:	d0050513          	addi	a0,a0,-768 # 8000a890 <digits+0x20>
    80008b98:	fffff097          	auipc	ra,0xfffff
    80008b9c:	224080e7          	jalr	548(ra) # 80007dbc <panic>
    80008ba0:	00195913          	srli	s2,s2,0x1
    80008ba4:	fffff097          	auipc	ra,0xfffff
    80008ba8:	854080e7          	jalr	-1964(ra) # 800073f8 <mycpu>
    80008bac:	00197913          	andi	s2,s2,1
    80008bb0:	07252e23          	sw	s2,124(a0)
    80008bb4:	f75ff06f          	j	80008b28 <acquire+0x3c>

0000000080008bb8 <release>:
    80008bb8:	fe010113          	addi	sp,sp,-32
    80008bbc:	00813823          	sd	s0,16(sp)
    80008bc0:	00113c23          	sd	ra,24(sp)
    80008bc4:	00913423          	sd	s1,8(sp)
    80008bc8:	01213023          	sd	s2,0(sp)
    80008bcc:	02010413          	addi	s0,sp,32
    80008bd0:	00052783          	lw	a5,0(a0)
    80008bd4:	00079a63          	bnez	a5,80008be8 <release+0x30>
    80008bd8:	00002517          	auipc	a0,0x2
    80008bdc:	cc050513          	addi	a0,a0,-832 # 8000a898 <digits+0x28>
    80008be0:	fffff097          	auipc	ra,0xfffff
    80008be4:	1dc080e7          	jalr	476(ra) # 80007dbc <panic>
    80008be8:	01053903          	ld	s2,16(a0)
    80008bec:	00050493          	mv	s1,a0
    80008bf0:	fffff097          	auipc	ra,0xfffff
    80008bf4:	808080e7          	jalr	-2040(ra) # 800073f8 <mycpu>
    80008bf8:	fea910e3          	bne	s2,a0,80008bd8 <release+0x20>
    80008bfc:	0004b823          	sd	zero,16(s1)
    80008c00:	0ff0000f          	fence
    80008c04:	0f50000f          	fence	iorw,ow
    80008c08:	0804a02f          	amoswap.w	zero,zero,(s1)
    80008c0c:	ffffe097          	auipc	ra,0xffffe
    80008c10:	7ec080e7          	jalr	2028(ra) # 800073f8 <mycpu>
    80008c14:	100027f3          	csrr	a5,sstatus
    80008c18:	0027f793          	andi	a5,a5,2
    80008c1c:	04079a63          	bnez	a5,80008c70 <release+0xb8>
    80008c20:	07852783          	lw	a5,120(a0)
    80008c24:	02f05e63          	blez	a5,80008c60 <release+0xa8>
    80008c28:	fff7871b          	addiw	a4,a5,-1
    80008c2c:	06e52c23          	sw	a4,120(a0)
    80008c30:	00071c63          	bnez	a4,80008c48 <release+0x90>
    80008c34:	07c52783          	lw	a5,124(a0)
    80008c38:	00078863          	beqz	a5,80008c48 <release+0x90>
    80008c3c:	100027f3          	csrr	a5,sstatus
    80008c40:	0027e793          	ori	a5,a5,2
    80008c44:	10079073          	csrw	sstatus,a5
    80008c48:	01813083          	ld	ra,24(sp)
    80008c4c:	01013403          	ld	s0,16(sp)
    80008c50:	00813483          	ld	s1,8(sp)
    80008c54:	00013903          	ld	s2,0(sp)
    80008c58:	02010113          	addi	sp,sp,32
    80008c5c:	00008067          	ret
    80008c60:	00002517          	auipc	a0,0x2
    80008c64:	c5850513          	addi	a0,a0,-936 # 8000a8b8 <digits+0x48>
    80008c68:	fffff097          	auipc	ra,0xfffff
    80008c6c:	154080e7          	jalr	340(ra) # 80007dbc <panic>
    80008c70:	00002517          	auipc	a0,0x2
    80008c74:	c3050513          	addi	a0,a0,-976 # 8000a8a0 <digits+0x30>
    80008c78:	fffff097          	auipc	ra,0xfffff
    80008c7c:	144080e7          	jalr	324(ra) # 80007dbc <panic>

0000000080008c80 <holding>:
    80008c80:	00052783          	lw	a5,0(a0)
    80008c84:	00079663          	bnez	a5,80008c90 <holding+0x10>
    80008c88:	00000513          	li	a0,0
    80008c8c:	00008067          	ret
    80008c90:	fe010113          	addi	sp,sp,-32
    80008c94:	00813823          	sd	s0,16(sp)
    80008c98:	00913423          	sd	s1,8(sp)
    80008c9c:	00113c23          	sd	ra,24(sp)
    80008ca0:	02010413          	addi	s0,sp,32
    80008ca4:	01053483          	ld	s1,16(a0)
    80008ca8:	ffffe097          	auipc	ra,0xffffe
    80008cac:	750080e7          	jalr	1872(ra) # 800073f8 <mycpu>
    80008cb0:	01813083          	ld	ra,24(sp)
    80008cb4:	01013403          	ld	s0,16(sp)
    80008cb8:	40a48533          	sub	a0,s1,a0
    80008cbc:	00153513          	seqz	a0,a0
    80008cc0:	00813483          	ld	s1,8(sp)
    80008cc4:	02010113          	addi	sp,sp,32
    80008cc8:	00008067          	ret

0000000080008ccc <push_off>:
    80008ccc:	fe010113          	addi	sp,sp,-32
    80008cd0:	00813823          	sd	s0,16(sp)
    80008cd4:	00113c23          	sd	ra,24(sp)
    80008cd8:	00913423          	sd	s1,8(sp)
    80008cdc:	02010413          	addi	s0,sp,32
    80008ce0:	100024f3          	csrr	s1,sstatus
    80008ce4:	100027f3          	csrr	a5,sstatus
    80008ce8:	ffd7f793          	andi	a5,a5,-3
    80008cec:	10079073          	csrw	sstatus,a5
    80008cf0:	ffffe097          	auipc	ra,0xffffe
    80008cf4:	708080e7          	jalr	1800(ra) # 800073f8 <mycpu>
    80008cf8:	07852783          	lw	a5,120(a0)
    80008cfc:	02078663          	beqz	a5,80008d28 <push_off+0x5c>
    80008d00:	ffffe097          	auipc	ra,0xffffe
    80008d04:	6f8080e7          	jalr	1784(ra) # 800073f8 <mycpu>
    80008d08:	07852783          	lw	a5,120(a0)
    80008d0c:	01813083          	ld	ra,24(sp)
    80008d10:	01013403          	ld	s0,16(sp)
    80008d14:	0017879b          	addiw	a5,a5,1
    80008d18:	06f52c23          	sw	a5,120(a0)
    80008d1c:	00813483          	ld	s1,8(sp)
    80008d20:	02010113          	addi	sp,sp,32
    80008d24:	00008067          	ret
    80008d28:	0014d493          	srli	s1,s1,0x1
    80008d2c:	ffffe097          	auipc	ra,0xffffe
    80008d30:	6cc080e7          	jalr	1740(ra) # 800073f8 <mycpu>
    80008d34:	0014f493          	andi	s1,s1,1
    80008d38:	06952e23          	sw	s1,124(a0)
    80008d3c:	fc5ff06f          	j	80008d00 <push_off+0x34>

0000000080008d40 <pop_off>:
    80008d40:	ff010113          	addi	sp,sp,-16
    80008d44:	00813023          	sd	s0,0(sp)
    80008d48:	00113423          	sd	ra,8(sp)
    80008d4c:	01010413          	addi	s0,sp,16
    80008d50:	ffffe097          	auipc	ra,0xffffe
    80008d54:	6a8080e7          	jalr	1704(ra) # 800073f8 <mycpu>
    80008d58:	100027f3          	csrr	a5,sstatus
    80008d5c:	0027f793          	andi	a5,a5,2
    80008d60:	04079663          	bnez	a5,80008dac <pop_off+0x6c>
    80008d64:	07852783          	lw	a5,120(a0)
    80008d68:	02f05a63          	blez	a5,80008d9c <pop_off+0x5c>
    80008d6c:	fff7871b          	addiw	a4,a5,-1
    80008d70:	06e52c23          	sw	a4,120(a0)
    80008d74:	00071c63          	bnez	a4,80008d8c <pop_off+0x4c>
    80008d78:	07c52783          	lw	a5,124(a0)
    80008d7c:	00078863          	beqz	a5,80008d8c <pop_off+0x4c>
    80008d80:	100027f3          	csrr	a5,sstatus
    80008d84:	0027e793          	ori	a5,a5,2
    80008d88:	10079073          	csrw	sstatus,a5
    80008d8c:	00813083          	ld	ra,8(sp)
    80008d90:	00013403          	ld	s0,0(sp)
    80008d94:	01010113          	addi	sp,sp,16
    80008d98:	00008067          	ret
    80008d9c:	00002517          	auipc	a0,0x2
    80008da0:	b1c50513          	addi	a0,a0,-1252 # 8000a8b8 <digits+0x48>
    80008da4:	fffff097          	auipc	ra,0xfffff
    80008da8:	018080e7          	jalr	24(ra) # 80007dbc <panic>
    80008dac:	00002517          	auipc	a0,0x2
    80008db0:	af450513          	addi	a0,a0,-1292 # 8000a8a0 <digits+0x30>
    80008db4:	fffff097          	auipc	ra,0xfffff
    80008db8:	008080e7          	jalr	8(ra) # 80007dbc <panic>

0000000080008dbc <push_on>:
    80008dbc:	fe010113          	addi	sp,sp,-32
    80008dc0:	00813823          	sd	s0,16(sp)
    80008dc4:	00113c23          	sd	ra,24(sp)
    80008dc8:	00913423          	sd	s1,8(sp)
    80008dcc:	02010413          	addi	s0,sp,32
    80008dd0:	100024f3          	csrr	s1,sstatus
    80008dd4:	100027f3          	csrr	a5,sstatus
    80008dd8:	0027e793          	ori	a5,a5,2
    80008ddc:	10079073          	csrw	sstatus,a5
    80008de0:	ffffe097          	auipc	ra,0xffffe
    80008de4:	618080e7          	jalr	1560(ra) # 800073f8 <mycpu>
    80008de8:	07852783          	lw	a5,120(a0)
    80008dec:	02078663          	beqz	a5,80008e18 <push_on+0x5c>
    80008df0:	ffffe097          	auipc	ra,0xffffe
    80008df4:	608080e7          	jalr	1544(ra) # 800073f8 <mycpu>
    80008df8:	07852783          	lw	a5,120(a0)
    80008dfc:	01813083          	ld	ra,24(sp)
    80008e00:	01013403          	ld	s0,16(sp)
    80008e04:	0017879b          	addiw	a5,a5,1
    80008e08:	06f52c23          	sw	a5,120(a0)
    80008e0c:	00813483          	ld	s1,8(sp)
    80008e10:	02010113          	addi	sp,sp,32
    80008e14:	00008067          	ret
    80008e18:	0014d493          	srli	s1,s1,0x1
    80008e1c:	ffffe097          	auipc	ra,0xffffe
    80008e20:	5dc080e7          	jalr	1500(ra) # 800073f8 <mycpu>
    80008e24:	0014f493          	andi	s1,s1,1
    80008e28:	06952e23          	sw	s1,124(a0)
    80008e2c:	fc5ff06f          	j	80008df0 <push_on+0x34>

0000000080008e30 <pop_on>:
    80008e30:	ff010113          	addi	sp,sp,-16
    80008e34:	00813023          	sd	s0,0(sp)
    80008e38:	00113423          	sd	ra,8(sp)
    80008e3c:	01010413          	addi	s0,sp,16
    80008e40:	ffffe097          	auipc	ra,0xffffe
    80008e44:	5b8080e7          	jalr	1464(ra) # 800073f8 <mycpu>
    80008e48:	100027f3          	csrr	a5,sstatus
    80008e4c:	0027f793          	andi	a5,a5,2
    80008e50:	04078463          	beqz	a5,80008e98 <pop_on+0x68>
    80008e54:	07852783          	lw	a5,120(a0)
    80008e58:	02f05863          	blez	a5,80008e88 <pop_on+0x58>
    80008e5c:	fff7879b          	addiw	a5,a5,-1
    80008e60:	06f52c23          	sw	a5,120(a0)
    80008e64:	07853783          	ld	a5,120(a0)
    80008e68:	00079863          	bnez	a5,80008e78 <pop_on+0x48>
    80008e6c:	100027f3          	csrr	a5,sstatus
    80008e70:	ffd7f793          	andi	a5,a5,-3
    80008e74:	10079073          	csrw	sstatus,a5
    80008e78:	00813083          	ld	ra,8(sp)
    80008e7c:	00013403          	ld	s0,0(sp)
    80008e80:	01010113          	addi	sp,sp,16
    80008e84:	00008067          	ret
    80008e88:	00002517          	auipc	a0,0x2
    80008e8c:	a5850513          	addi	a0,a0,-1448 # 8000a8e0 <digits+0x70>
    80008e90:	fffff097          	auipc	ra,0xfffff
    80008e94:	f2c080e7          	jalr	-212(ra) # 80007dbc <panic>
    80008e98:	00002517          	auipc	a0,0x2
    80008e9c:	a2850513          	addi	a0,a0,-1496 # 8000a8c0 <digits+0x50>
    80008ea0:	fffff097          	auipc	ra,0xfffff
    80008ea4:	f1c080e7          	jalr	-228(ra) # 80007dbc <panic>

0000000080008ea8 <__memset>:
    80008ea8:	ff010113          	addi	sp,sp,-16
    80008eac:	00813423          	sd	s0,8(sp)
    80008eb0:	01010413          	addi	s0,sp,16
    80008eb4:	1a060e63          	beqz	a2,80009070 <__memset+0x1c8>
    80008eb8:	40a007b3          	neg	a5,a0
    80008ebc:	0077f793          	andi	a5,a5,7
    80008ec0:	00778693          	addi	a3,a5,7
    80008ec4:	00b00813          	li	a6,11
    80008ec8:	0ff5f593          	andi	a1,a1,255
    80008ecc:	fff6071b          	addiw	a4,a2,-1
    80008ed0:	1b06e663          	bltu	a3,a6,8000907c <__memset+0x1d4>
    80008ed4:	1cd76463          	bltu	a4,a3,8000909c <__memset+0x1f4>
    80008ed8:	1a078e63          	beqz	a5,80009094 <__memset+0x1ec>
    80008edc:	00b50023          	sb	a1,0(a0)
    80008ee0:	00100713          	li	a4,1
    80008ee4:	1ae78463          	beq	a5,a4,8000908c <__memset+0x1e4>
    80008ee8:	00b500a3          	sb	a1,1(a0)
    80008eec:	00200713          	li	a4,2
    80008ef0:	1ae78a63          	beq	a5,a4,800090a4 <__memset+0x1fc>
    80008ef4:	00b50123          	sb	a1,2(a0)
    80008ef8:	00300713          	li	a4,3
    80008efc:	18e78463          	beq	a5,a4,80009084 <__memset+0x1dc>
    80008f00:	00b501a3          	sb	a1,3(a0)
    80008f04:	00400713          	li	a4,4
    80008f08:	1ae78263          	beq	a5,a4,800090ac <__memset+0x204>
    80008f0c:	00b50223          	sb	a1,4(a0)
    80008f10:	00500713          	li	a4,5
    80008f14:	1ae78063          	beq	a5,a4,800090b4 <__memset+0x20c>
    80008f18:	00b502a3          	sb	a1,5(a0)
    80008f1c:	00700713          	li	a4,7
    80008f20:	18e79e63          	bne	a5,a4,800090bc <__memset+0x214>
    80008f24:	00b50323          	sb	a1,6(a0)
    80008f28:	00700e93          	li	t4,7
    80008f2c:	00859713          	slli	a4,a1,0x8
    80008f30:	00e5e733          	or	a4,a1,a4
    80008f34:	01059e13          	slli	t3,a1,0x10
    80008f38:	01c76e33          	or	t3,a4,t3
    80008f3c:	01859313          	slli	t1,a1,0x18
    80008f40:	006e6333          	or	t1,t3,t1
    80008f44:	02059893          	slli	a7,a1,0x20
    80008f48:	40f60e3b          	subw	t3,a2,a5
    80008f4c:	011368b3          	or	a7,t1,a7
    80008f50:	02859813          	slli	a6,a1,0x28
    80008f54:	0108e833          	or	a6,a7,a6
    80008f58:	03059693          	slli	a3,a1,0x30
    80008f5c:	003e589b          	srliw	a7,t3,0x3
    80008f60:	00d866b3          	or	a3,a6,a3
    80008f64:	03859713          	slli	a4,a1,0x38
    80008f68:	00389813          	slli	a6,a7,0x3
    80008f6c:	00f507b3          	add	a5,a0,a5
    80008f70:	00e6e733          	or	a4,a3,a4
    80008f74:	000e089b          	sext.w	a7,t3
    80008f78:	00f806b3          	add	a3,a6,a5
    80008f7c:	00e7b023          	sd	a4,0(a5)
    80008f80:	00878793          	addi	a5,a5,8
    80008f84:	fed79ce3          	bne	a5,a3,80008f7c <__memset+0xd4>
    80008f88:	ff8e7793          	andi	a5,t3,-8
    80008f8c:	0007871b          	sext.w	a4,a5
    80008f90:	01d787bb          	addw	a5,a5,t4
    80008f94:	0ce88e63          	beq	a7,a4,80009070 <__memset+0x1c8>
    80008f98:	00f50733          	add	a4,a0,a5
    80008f9c:	00b70023          	sb	a1,0(a4)
    80008fa0:	0017871b          	addiw	a4,a5,1
    80008fa4:	0cc77663          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80008fa8:	00e50733          	add	a4,a0,a4
    80008fac:	00b70023          	sb	a1,0(a4)
    80008fb0:	0027871b          	addiw	a4,a5,2
    80008fb4:	0ac77e63          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80008fb8:	00e50733          	add	a4,a0,a4
    80008fbc:	00b70023          	sb	a1,0(a4)
    80008fc0:	0037871b          	addiw	a4,a5,3
    80008fc4:	0ac77663          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80008fc8:	00e50733          	add	a4,a0,a4
    80008fcc:	00b70023          	sb	a1,0(a4)
    80008fd0:	0047871b          	addiw	a4,a5,4
    80008fd4:	08c77e63          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80008fd8:	00e50733          	add	a4,a0,a4
    80008fdc:	00b70023          	sb	a1,0(a4)
    80008fe0:	0057871b          	addiw	a4,a5,5
    80008fe4:	08c77663          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80008fe8:	00e50733          	add	a4,a0,a4
    80008fec:	00b70023          	sb	a1,0(a4)
    80008ff0:	0067871b          	addiw	a4,a5,6
    80008ff4:	06c77e63          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80008ff8:	00e50733          	add	a4,a0,a4
    80008ffc:	00b70023          	sb	a1,0(a4)
    80009000:	0077871b          	addiw	a4,a5,7
    80009004:	06c77663          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80009008:	00e50733          	add	a4,a0,a4
    8000900c:	00b70023          	sb	a1,0(a4)
    80009010:	0087871b          	addiw	a4,a5,8
    80009014:	04c77e63          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80009018:	00e50733          	add	a4,a0,a4
    8000901c:	00b70023          	sb	a1,0(a4)
    80009020:	0097871b          	addiw	a4,a5,9
    80009024:	04c77663          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80009028:	00e50733          	add	a4,a0,a4
    8000902c:	00b70023          	sb	a1,0(a4)
    80009030:	00a7871b          	addiw	a4,a5,10
    80009034:	02c77e63          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80009038:	00e50733          	add	a4,a0,a4
    8000903c:	00b70023          	sb	a1,0(a4)
    80009040:	00b7871b          	addiw	a4,a5,11
    80009044:	02c77663          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80009048:	00e50733          	add	a4,a0,a4
    8000904c:	00b70023          	sb	a1,0(a4)
    80009050:	00c7871b          	addiw	a4,a5,12
    80009054:	00c77e63          	bgeu	a4,a2,80009070 <__memset+0x1c8>
    80009058:	00e50733          	add	a4,a0,a4
    8000905c:	00b70023          	sb	a1,0(a4)
    80009060:	00d7879b          	addiw	a5,a5,13
    80009064:	00c7f663          	bgeu	a5,a2,80009070 <__memset+0x1c8>
    80009068:	00f507b3          	add	a5,a0,a5
    8000906c:	00b78023          	sb	a1,0(a5)
    80009070:	00813403          	ld	s0,8(sp)
    80009074:	01010113          	addi	sp,sp,16
    80009078:	00008067          	ret
    8000907c:	00b00693          	li	a3,11
    80009080:	e55ff06f          	j	80008ed4 <__memset+0x2c>
    80009084:	00300e93          	li	t4,3
    80009088:	ea5ff06f          	j	80008f2c <__memset+0x84>
    8000908c:	00100e93          	li	t4,1
    80009090:	e9dff06f          	j	80008f2c <__memset+0x84>
    80009094:	00000e93          	li	t4,0
    80009098:	e95ff06f          	j	80008f2c <__memset+0x84>
    8000909c:	00000793          	li	a5,0
    800090a0:	ef9ff06f          	j	80008f98 <__memset+0xf0>
    800090a4:	00200e93          	li	t4,2
    800090a8:	e85ff06f          	j	80008f2c <__memset+0x84>
    800090ac:	00400e93          	li	t4,4
    800090b0:	e7dff06f          	j	80008f2c <__memset+0x84>
    800090b4:	00500e93          	li	t4,5
    800090b8:	e75ff06f          	j	80008f2c <__memset+0x84>
    800090bc:	00600e93          	li	t4,6
    800090c0:	e6dff06f          	j	80008f2c <__memset+0x84>

00000000800090c4 <__memmove>:
    800090c4:	ff010113          	addi	sp,sp,-16
    800090c8:	00813423          	sd	s0,8(sp)
    800090cc:	01010413          	addi	s0,sp,16
    800090d0:	0e060863          	beqz	a2,800091c0 <__memmove+0xfc>
    800090d4:	fff6069b          	addiw	a3,a2,-1
    800090d8:	0006881b          	sext.w	a6,a3
    800090dc:	0ea5e863          	bltu	a1,a0,800091cc <__memmove+0x108>
    800090e0:	00758713          	addi	a4,a1,7
    800090e4:	00a5e7b3          	or	a5,a1,a0
    800090e8:	40a70733          	sub	a4,a4,a0
    800090ec:	0077f793          	andi	a5,a5,7
    800090f0:	00f73713          	sltiu	a4,a4,15
    800090f4:	00174713          	xori	a4,a4,1
    800090f8:	0017b793          	seqz	a5,a5
    800090fc:	00e7f7b3          	and	a5,a5,a4
    80009100:	10078863          	beqz	a5,80009210 <__memmove+0x14c>
    80009104:	00900793          	li	a5,9
    80009108:	1107f463          	bgeu	a5,a6,80009210 <__memmove+0x14c>
    8000910c:	0036581b          	srliw	a6,a2,0x3
    80009110:	fff8081b          	addiw	a6,a6,-1
    80009114:	02081813          	slli	a6,a6,0x20
    80009118:	01d85893          	srli	a7,a6,0x1d
    8000911c:	00858813          	addi	a6,a1,8
    80009120:	00058793          	mv	a5,a1
    80009124:	00050713          	mv	a4,a0
    80009128:	01088833          	add	a6,a7,a6
    8000912c:	0007b883          	ld	a7,0(a5)
    80009130:	00878793          	addi	a5,a5,8
    80009134:	00870713          	addi	a4,a4,8
    80009138:	ff173c23          	sd	a7,-8(a4)
    8000913c:	ff0798e3          	bne	a5,a6,8000912c <__memmove+0x68>
    80009140:	ff867713          	andi	a4,a2,-8
    80009144:	02071793          	slli	a5,a4,0x20
    80009148:	0207d793          	srli	a5,a5,0x20
    8000914c:	00f585b3          	add	a1,a1,a5
    80009150:	40e686bb          	subw	a3,a3,a4
    80009154:	00f507b3          	add	a5,a0,a5
    80009158:	06e60463          	beq	a2,a4,800091c0 <__memmove+0xfc>
    8000915c:	0005c703          	lbu	a4,0(a1)
    80009160:	00e78023          	sb	a4,0(a5)
    80009164:	04068e63          	beqz	a3,800091c0 <__memmove+0xfc>
    80009168:	0015c603          	lbu	a2,1(a1)
    8000916c:	00100713          	li	a4,1
    80009170:	00c780a3          	sb	a2,1(a5)
    80009174:	04e68663          	beq	a3,a4,800091c0 <__memmove+0xfc>
    80009178:	0025c603          	lbu	a2,2(a1)
    8000917c:	00200713          	li	a4,2
    80009180:	00c78123          	sb	a2,2(a5)
    80009184:	02e68e63          	beq	a3,a4,800091c0 <__memmove+0xfc>
    80009188:	0035c603          	lbu	a2,3(a1)
    8000918c:	00300713          	li	a4,3
    80009190:	00c781a3          	sb	a2,3(a5)
    80009194:	02e68663          	beq	a3,a4,800091c0 <__memmove+0xfc>
    80009198:	0045c603          	lbu	a2,4(a1)
    8000919c:	00400713          	li	a4,4
    800091a0:	00c78223          	sb	a2,4(a5)
    800091a4:	00e68e63          	beq	a3,a4,800091c0 <__memmove+0xfc>
    800091a8:	0055c603          	lbu	a2,5(a1)
    800091ac:	00500713          	li	a4,5
    800091b0:	00c782a3          	sb	a2,5(a5)
    800091b4:	00e68663          	beq	a3,a4,800091c0 <__memmove+0xfc>
    800091b8:	0065c703          	lbu	a4,6(a1)
    800091bc:	00e78323          	sb	a4,6(a5)
    800091c0:	00813403          	ld	s0,8(sp)
    800091c4:	01010113          	addi	sp,sp,16
    800091c8:	00008067          	ret
    800091cc:	02061713          	slli	a4,a2,0x20
    800091d0:	02075713          	srli	a4,a4,0x20
    800091d4:	00e587b3          	add	a5,a1,a4
    800091d8:	f0f574e3          	bgeu	a0,a5,800090e0 <__memmove+0x1c>
    800091dc:	02069613          	slli	a2,a3,0x20
    800091e0:	02065613          	srli	a2,a2,0x20
    800091e4:	fff64613          	not	a2,a2
    800091e8:	00e50733          	add	a4,a0,a4
    800091ec:	00c78633          	add	a2,a5,a2
    800091f0:	fff7c683          	lbu	a3,-1(a5)
    800091f4:	fff78793          	addi	a5,a5,-1
    800091f8:	fff70713          	addi	a4,a4,-1
    800091fc:	00d70023          	sb	a3,0(a4)
    80009200:	fec798e3          	bne	a5,a2,800091f0 <__memmove+0x12c>
    80009204:	00813403          	ld	s0,8(sp)
    80009208:	01010113          	addi	sp,sp,16
    8000920c:	00008067          	ret
    80009210:	02069713          	slli	a4,a3,0x20
    80009214:	02075713          	srli	a4,a4,0x20
    80009218:	00170713          	addi	a4,a4,1
    8000921c:	00e50733          	add	a4,a0,a4
    80009220:	00050793          	mv	a5,a0
    80009224:	0005c683          	lbu	a3,0(a1)
    80009228:	00178793          	addi	a5,a5,1
    8000922c:	00158593          	addi	a1,a1,1
    80009230:	fed78fa3          	sb	a3,-1(a5)
    80009234:	fee798e3          	bne	a5,a4,80009224 <__memmove+0x160>
    80009238:	f89ff06f          	j	800091c0 <__memmove+0xfc>
	...
