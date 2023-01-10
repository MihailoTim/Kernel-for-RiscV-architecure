
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00008117          	auipc	sp,0x8
    80000004:	a5813103          	ld	sp,-1448(sp) # 80007a58 <_GLOBAL_OFFSET_TABLE_+0x68>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	4f5040ef          	jal	ra,80004d10 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <_ZN5RiscV14supervisorTrapEv>:
.global _ZN5RiscV14supervisorTrapEv
_ZN5RiscV14supervisorTrapEv:

    #push all registers to stack

    addi sp, sp, -256
    80001000:	f0010113          	addi	sp,sp,-256
    csrw sscratch, sp
    80001004:	14011073          	csrw	sscratch,sp
    .irp index 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 //ommit x10 as it is reserved for return values from function
    sd x\index, \index * 8(sp)
    .endr
    80001008:	00013023          	sd	zero,0(sp)
    8000100c:	00113423          	sd	ra,8(sp)
    80001010:	00213823          	sd	sp,16(sp)
    80001014:	00313c23          	sd	gp,24(sp)
    80001018:	02413023          	sd	tp,32(sp)
    8000101c:	02513423          	sd	t0,40(sp)
    80001020:	02613823          	sd	t1,48(sp)
    80001024:	02713c23          	sd	t2,56(sp)
    80001028:	04813023          	sd	s0,64(sp)
    8000102c:	04913423          	sd	s1,72(sp)
    80001030:	04a13823          	sd	a0,80(sp)
    80001034:	04b13c23          	sd	a1,88(sp)
    80001038:	06c13023          	sd	a2,96(sp)
    8000103c:	06d13423          	sd	a3,104(sp)
    80001040:	06e13823          	sd	a4,112(sp)
    80001044:	06f13c23          	sd	a5,120(sp)
    80001048:	09013023          	sd	a6,128(sp)
    8000104c:	09113423          	sd	a7,136(sp)
    80001050:	09213823          	sd	s2,144(sp)
    80001054:	09313c23          	sd	s3,152(sp)
    80001058:	0b413023          	sd	s4,160(sp)
    8000105c:	0b513423          	sd	s5,168(sp)
    80001060:	0b613823          	sd	s6,176(sp)
    80001064:	0b713c23          	sd	s7,184(sp)
    80001068:	0d813023          	sd	s8,192(sp)
    8000106c:	0d913423          	sd	s9,200(sp)
    80001070:	0da13823          	sd	s10,208(sp)
    80001074:	0db13c23          	sd	s11,216(sp)
    80001078:	0fc13023          	sd	t3,224(sp)
    8000107c:	0fd13423          	sd	t4,232(sp)
    80001080:	0fe13823          	sd	t5,240(sp)
    80001084:	0ff13c23          	sd	t6,248(sp)

    #call trap handler
    call _ZN5RiscV20handleSupervisorTrapEv // call handleSupervisorTrap()
    80001088:	115020ef          	jal	ra,8000399c <_ZN5RiscV20handleSupervisorTrapEv>

    #pop all registers from stack

    .irp index 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    8000108c:	00013003          	ld	zero,0(sp)
    80001090:	00813083          	ld	ra,8(sp)
    80001094:	01013103          	ld	sp,16(sp)
    80001098:	01813183          	ld	gp,24(sp)
    8000109c:	02013203          	ld	tp,32(sp)
    800010a0:	02813283          	ld	t0,40(sp)
    800010a4:	03013303          	ld	t1,48(sp)
    800010a8:	03813383          	ld	t2,56(sp)
    800010ac:	04013403          	ld	s0,64(sp)
    800010b0:	04813483          	ld	s1,72(sp)
    800010b4:	05013503          	ld	a0,80(sp)
    800010b8:	05813583          	ld	a1,88(sp)
    800010bc:	06013603          	ld	a2,96(sp)
    800010c0:	06813683          	ld	a3,104(sp)
    800010c4:	07013703          	ld	a4,112(sp)
    800010c8:	07813783          	ld	a5,120(sp)
    800010cc:	08013803          	ld	a6,128(sp)
    800010d0:	08813883          	ld	a7,136(sp)
    800010d4:	09013903          	ld	s2,144(sp)
    800010d8:	09813983          	ld	s3,152(sp)
    800010dc:	0a013a03          	ld	s4,160(sp)
    800010e0:	0a813a83          	ld	s5,168(sp)
    800010e4:	0b013b03          	ld	s6,176(sp)
    800010e8:	0b813b83          	ld	s7,184(sp)
    800010ec:	0c013c03          	ld	s8,192(sp)
    800010f0:	0c813c83          	ld	s9,200(sp)
    800010f4:	0d013d03          	ld	s10,208(sp)
    800010f8:	0d813d83          	ld	s11,216(sp)
    800010fc:	0e013e03          	ld	t3,224(sp)
    80001100:	0e813e83          	ld	t4,232(sp)
    80001104:	0f013f03          	ld	t5,240(sp)
    80001108:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000110c:	10010113          	addi	sp,sp,256

    80001110:	10200073          	sret
	...

0000000080001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function

_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd sp, 0*8(a0)
    80001120:	00253023          	sd	sp,0(a0) # 1000 <_entry-0x7ffff000>
    sd ra, 1*8(a0)
    80001124:	00153423          	sd	ra,8(a0)

    ld sp, 0*8(a1)
    80001128:	0005b103          	ld	sp,0(a1)
    ld ra, 1*8(a1)
    8000112c:	0085b083          	ld	ra,8(a1)

    80001130:	00008067          	ret

0000000080001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>:
    deleteList(cache->emptyHead);
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    cache = nullptr;
}

int SlabAllocator::shrinkCache(Cache *cache) {
    80001134:	fe010113          	addi	sp,sp,-32
    80001138:	00113c23          	sd	ra,24(sp)
    8000113c:	00813823          	sd	s0,16(sp)
    80001140:	00913423          	sd	s1,8(sp)
    80001144:	01213023          	sd	s2,0(sp)
    80001148:	02010413          	addi	s0,sp,32
    8000114c:	00050493          	mv	s1,a0
    int ret = 0;
    80001150:	00000913          	li	s2,0
    while(cache->emptyHead){
    80001154:	0604b503          	ld	a0,96(s1)
    80001158:	02050463          	beqz	a0,80001180 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x4c>
        Buddy::free(cache->emptyHead, cache->slabSize);
    8000115c:	0484b583          	ld	a1,72(s1)
    80001160:	00001097          	auipc	ra,0x1
    80001164:	074080e7          	jalr	116(ra) # 800021d4 <_ZN5Buddy4freeEPvm>
        ret += cache->emptyHead->totalNumOfSlots;
    80001168:	0604b783          	ld	a5,96(s1)
    8000116c:	0187b703          	ld	a4,24(a5)
    80001170:	0127093b          	addw	s2,a4,s2
        cache->emptyHead = cache->emptyHead->next;
    80001174:	0087b783          	ld	a5,8(a5)
    80001178:	06f4b023          	sd	a5,96(s1)
    while(cache->emptyHead){
    8000117c:	fd9ff06f          	j	80001154 <_ZN13SlabAllocator11shrinkCacheEP5Cache+0x20>
    }
    return ret;
}
    80001180:	00090513          	mv	a0,s2
    80001184:	01813083          	ld	ra,24(sp)
    80001188:	01013403          	ld	s0,16(sp)
    8000118c:	00813483          	ld	s1,8(sp)
    80001190:	00013903          	ld	s2,0(sp)
    80001194:	02010113          	addi	sp,sp,32
    80001198:	00008067          	ret

000000008000119c <_ZN13SlabAllocator9printSlabEP4Slab>:

void SlabAllocator::printSlab(Slab *slab) {
    if(slab) {
    8000119c:	14050e63          	beqz	a0,800012f8 <_ZN13SlabAllocator9printSlabEP4Slab+0x15c>
void SlabAllocator::printSlab(Slab *slab) {
    800011a0:	fe010113          	addi	sp,sp,-32
    800011a4:	00113c23          	sd	ra,24(sp)
    800011a8:	00813823          	sd	s0,16(sp)
    800011ac:	00913423          	sd	s1,8(sp)
    800011b0:	01213023          	sd	s2,0(sp)
    800011b4:	02010413          	addi	s0,sp,32
    800011b8:	00050913          	mv	s2,a0
        ConsoleUtil::print("Slab address:", (uint64) slab, "\n");
    800011bc:	01000693          	li	a3,16
    800011c0:	00006617          	auipc	a2,0x6
    800011c4:	19060613          	addi	a2,a2,400 # 80007350 <CONSOLE_STATUS+0x340>
    800011c8:	0005059b          	sext.w	a1,a0
    800011cc:	00006517          	auipc	a0,0x6
    800011d0:	e5450513          	addi	a0,a0,-428 # 80007020 <CONSOLE_STATUS+0x10>
    800011d4:	00004097          	auipc	ra,0x4
    800011d8:	938080e7          	jalr	-1736(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011dc:	01000693          	li	a3,16
    800011e0:	00006617          	auipc	a2,0x6
    800011e4:	17060613          	addi	a2,a2,368 # 80007350 <CONSOLE_STATUS+0x340>
    800011e8:	01892583          	lw	a1,24(s2)
    800011ec:	00006517          	auipc	a0,0x6
    800011f0:	e4450513          	addi	a0,a0,-444 # 80007030 <CONSOLE_STATUS+0x20>
    800011f4:	00004097          	auipc	ra,0x4
    800011f8:	918080e7          	jalr	-1768(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    800011fc:	01000693          	li	a3,16
    80001200:	00006617          	auipc	a2,0x6
    80001204:	15060613          	addi	a2,a2,336 # 80007350 <CONSOLE_STATUS+0x340>
    80001208:	01092583          	lw	a1,16(s2)
    8000120c:	00006517          	auipc	a0,0x6
    80001210:	e3c50513          	addi	a0,a0,-452 # 80007048 <CONSOLE_STATUS+0x38>
    80001214:	00004097          	auipc	ra,0x4
    80001218:	8f8080e7          	jalr	-1800(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000121c:	01000693          	li	a3,16
    80001220:	00006617          	auipc	a2,0x6
    80001224:	13060613          	addi	a2,a2,304 # 80007350 <CONSOLE_STATUS+0x340>
    80001228:	03800593          	li	a1,56
    8000122c:	00006517          	auipc	a0,0x6
    80001230:	e3450513          	addi	a0,a0,-460 # 80007060 <CONSOLE_STATUS+0x50>
    80001234:	00004097          	auipc	ra,0x4
    80001238:	8d8080e7          	jalr	-1832(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00006617          	auipc	a2,0x6
    80001244:	11060613          	addi	a2,a2,272 # 80007350 <CONSOLE_STATUS+0x340>
    80001248:	02892583          	lw	a1,40(s2)
    8000124c:	00006517          	auipc	a0,0x6
    80001250:	e2c50513          	addi	a0,a0,-468 # 80007078 <CONSOLE_STATUS+0x68>
    80001254:	00004097          	auipc	ra,0x4
    80001258:	8b8080e7          	jalr	-1864(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00006617          	auipc	a2,0x6
    80001264:	0f060613          	addi	a2,a2,240 # 80007350 <CONSOLE_STATUS+0x340>
    80001268:	02092583          	lw	a1,32(s2)
    8000126c:	00006517          	auipc	a0,0x6
    80001270:	e1c50513          	addi	a0,a0,-484 # 80007088 <CONSOLE_STATUS+0x78>
    80001274:	00004097          	auipc	ra,0x4
    80001278:	898080e7          	jalr	-1896(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000127c:	00006517          	auipc	a0,0x6
    80001280:	e2c50513          	addi	a0,a0,-468 # 800070a8 <CONSOLE_STATUS+0x98>
    80001284:	00003097          	auipc	ra,0x3
    80001288:	768080e7          	jalr	1896(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    8000128c:	00000493          	li	s1,0
    80001290:	0300006f          	j	800012c0 <_ZN13SlabAllocator9printSlabEP4Slab+0x124>
            ConsoleUtil::print("", slab->allocated[i], " ");
    80001294:	02093783          	ld	a5,32(s2)
    80001298:	009787b3          	add	a5,a5,s1
    8000129c:	01000693          	li	a3,16
    800012a0:	00006617          	auipc	a2,0x6
    800012a4:	e4860613          	addi	a2,a2,-440 # 800070e8 <CONSOLE_STATUS+0xd8>
    800012a8:	0007c583          	lbu	a1,0(a5)
    800012ac:	00006517          	auipc	a0,0x6
    800012b0:	0e450513          	addi	a0,a0,228 # 80007390 <CONSOLE_STATUS+0x380>
    800012b4:	00004097          	auipc	ra,0x4
    800012b8:	858080e7          	jalr	-1960(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        for (uint64 i = 0; i < slab->totalNumOfSlots/8 + 1; i++) {
    800012bc:	00148493          	addi	s1,s1,1
    800012c0:	01893783          	ld	a5,24(s2)
    800012c4:	0037d793          	srli	a5,a5,0x3
    800012c8:	00178793          	addi	a5,a5,1
    800012cc:	fcf4e4e3          	bltu	s1,a5,80001294 <_ZN13SlabAllocator9printSlabEP4Slab+0xf8>
        }
        ConsoleUtil::printString("\n");
    800012d0:	00006517          	auipc	a0,0x6
    800012d4:	08050513          	addi	a0,a0,128 # 80007350 <CONSOLE_STATUS+0x340>
    800012d8:	00003097          	auipc	ra,0x3
    800012dc:	714080e7          	jalr	1812(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    }
}
    800012e0:	01813083          	ld	ra,24(sp)
    800012e4:	01013403          	ld	s0,16(sp)
    800012e8:	00813483          	ld	s1,8(sp)
    800012ec:	00013903          	ld	s2,0(sp)
    800012f0:	02010113          	addi	sp,sp,32
    800012f4:	00008067          	ret
    800012f8:	00008067          	ret

00000000800012fc <_ZN13SlabAllocator10printCacheEP5Cache>:

void SlabAllocator::printCache(Cache *cache) {
    800012fc:	fe010113          	addi	sp,sp,-32
    80001300:	00113c23          	sd	ra,24(sp)
    80001304:	00813823          	sd	s0,16(sp)
    80001308:	00913423          	sd	s1,8(sp)
    8000130c:	01213023          	sd	s2,0(sp)
    80001310:	02010413          	addi	s0,sp,32
    80001314:	00050913          	mv	s2,a0
    ConsoleUtil::printString("Cache name: ");
    80001318:	00006517          	auipc	a0,0x6
    8000131c:	db050513          	addi	a0,a0,-592 # 800070c8 <CONSOLE_STATUS+0xb8>
    80001320:	00003097          	auipc	ra,0x3
    80001324:	6cc080e7          	jalr	1740(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001328:	00090513          	mv	a0,s2
    8000132c:	00003097          	auipc	ra,0x3
    80001330:	6c0080e7          	jalr	1728(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001334:	00006517          	auipc	a0,0x6
    80001338:	01c50513          	addi	a0,a0,28 # 80007350 <CONSOLE_STATUS+0x340>
    8000133c:	00003097          	auipc	ra,0x3
    80001340:	6b0080e7          	jalr	1712(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001344:	01000693          	li	a3,16
    80001348:	00006617          	auipc	a2,0x6
    8000134c:	00860613          	addi	a2,a2,8 # 80007350 <CONSOLE_STATUS+0x340>
    80001350:	00006797          	auipc	a5,0x6
    80001354:	6b87b783          	ld	a5,1720(a5) # 80007a08 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001358:	0007a583          	lw	a1,0(a5)
    8000135c:	00006517          	auipc	a0,0x6
    80001360:	d7c50513          	addi	a0,a0,-644 # 800070d8 <CONSOLE_STATUS+0xc8>
    80001364:	00003097          	auipc	ra,0x3
    80001368:	7a8080e7          	jalr	1960(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	01000693          	li	a3,16
    80001370:	00006617          	auipc	a2,0x6
    80001374:	fe060613          	addi	a2,a2,-32 # 80007350 <CONSOLE_STATUS+0x340>
    80001378:	0009059b          	sext.w	a1,s2
    8000137c:	00006517          	auipc	a0,0x6
    80001380:	d7450513          	addi	a0,a0,-652 # 800070f0 <CONSOLE_STATUS+0xe0>
    80001384:	00003097          	auipc	ra,0x3
    80001388:	788080e7          	jalr	1928(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    8000138c:	01000693          	li	a3,16
    80001390:	00006617          	auipc	a2,0x6
    80001394:	fc060613          	addi	a2,a2,-64 # 80007350 <CONSOLE_STATUS+0x340>
    80001398:	04892583          	lw	a1,72(s2)
    8000139c:	00006517          	auipc	a0,0x6
    800013a0:	d6450513          	addi	a0,a0,-668 # 80007100 <CONSOLE_STATUS+0xf0>
    800013a4:	00003097          	auipc	ra,0x3
    800013a8:	768080e7          	jalr	1896(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013ac:	01000693          	li	a3,16
    800013b0:	00006617          	auipc	a2,0x6
    800013b4:	fa060613          	addi	a2,a2,-96 # 80007350 <CONSOLE_STATUS+0x340>
    800013b8:	04092583          	lw	a1,64(s2)
    800013bc:	00006517          	auipc	a0,0x6
    800013c0:	d5c50513          	addi	a0,a0,-676 # 80007118 <CONSOLE_STATUS+0x108>
    800013c4:	00003097          	auipc	ra,0x3
    800013c8:	748080e7          	jalr	1864(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013cc:	01000693          	li	a3,16
    800013d0:	00006617          	auipc	a2,0x6
    800013d4:	f8060613          	addi	a2,a2,-128 # 80007350 <CONSOLE_STATUS+0x340>
    800013d8:	06092583          	lw	a1,96(s2)
    800013dc:	00006517          	auipc	a0,0x6
    800013e0:	d5450513          	addi	a0,a0,-684 # 80007130 <CONSOLE_STATUS+0x120>
    800013e4:	00003097          	auipc	ra,0x3
    800013e8:	728080e7          	jalr	1832(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>

    Slab* iter = cache->emptyHead;
    800013ec:	06093483          	ld	s1,96(s2)
    while(iter){
    800013f0:	02048663          	beqz	s1,8000141c <_ZN13SlabAllocator10printCacheEP5Cache+0x120>
        ConsoleUtil::print("", (uint64)iter, " ");
    800013f4:	01000693          	li	a3,16
    800013f8:	00006617          	auipc	a2,0x6
    800013fc:	cf060613          	addi	a2,a2,-784 # 800070e8 <CONSOLE_STATUS+0xd8>
    80001400:	0004859b          	sext.w	a1,s1
    80001404:	00006517          	auipc	a0,0x6
    80001408:	f8c50513          	addi	a0,a0,-116 # 80007390 <CONSOLE_STATUS+0x380>
    8000140c:	00003097          	auipc	ra,0x3
    80001410:	700080e7          	jalr	1792(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001414:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001418:	fd9ff06f          	j	800013f0 <_ZN13SlabAllocator10printCacheEP5Cache+0xf4>
    }
    ConsoleUtil::printString("\n");
    8000141c:	00006517          	auipc	a0,0x6
    80001420:	f3450513          	addi	a0,a0,-204 # 80007350 <CONSOLE_STATUS+0x340>
    80001424:	00003097          	auipc	ra,0x3
    80001428:	5c8080e7          	jalr	1480(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    8000142c:	01000693          	li	a3,16
    80001430:	00006617          	auipc	a2,0x6
    80001434:	f2060613          	addi	a2,a2,-224 # 80007350 <CONSOLE_STATUS+0x340>
    80001438:	06892583          	lw	a1,104(s2)
    8000143c:	00006517          	auipc	a0,0x6
    80001440:	d0450513          	addi	a0,a0,-764 # 80007140 <CONSOLE_STATUS+0x130>
    80001444:	00003097          	auipc	ra,0x3
    80001448:	6c8080e7          	jalr	1736(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->partialHead;
    8000144c:	06893483          	ld	s1,104(s2)
    while(iter){
    80001450:	02048663          	beqz	s1,8000147c <_ZN13SlabAllocator10printCacheEP5Cache+0x180>
        ConsoleUtil::print("", (uint64)iter, " ");
    80001454:	01000693          	li	a3,16
    80001458:	00006617          	auipc	a2,0x6
    8000145c:	c9060613          	addi	a2,a2,-880 # 800070e8 <CONSOLE_STATUS+0xd8>
    80001460:	0004859b          	sext.w	a1,s1
    80001464:	00006517          	auipc	a0,0x6
    80001468:	f2c50513          	addi	a0,a0,-212 # 80007390 <CONSOLE_STATUS+0x380>
    8000146c:	00003097          	auipc	ra,0x3
    80001470:	6a0080e7          	jalr	1696(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001474:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001478:	fd9ff06f          	j	80001450 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
    }
    ConsoleUtil::printString("\n");
    8000147c:	00006517          	auipc	a0,0x6
    80001480:	ed450513          	addi	a0,a0,-300 # 80007350 <CONSOLE_STATUS+0x340>
    80001484:	00003097          	auipc	ra,0x3
    80001488:	568080e7          	jalr	1384(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    8000148c:	01000693          	li	a3,16
    80001490:	00006617          	auipc	a2,0x6
    80001494:	ec060613          	addi	a2,a2,-320 # 80007350 <CONSOLE_STATUS+0x340>
    80001498:	07092583          	lw	a1,112(s2)
    8000149c:	00006517          	auipc	a0,0x6
    800014a0:	cb450513          	addi	a0,a0,-844 # 80007150 <CONSOLE_STATUS+0x140>
    800014a4:	00003097          	auipc	ra,0x3
    800014a8:	668080e7          	jalr	1640(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>

    iter = cache->fullHead;
    800014ac:	07093483          	ld	s1,112(s2)
    while(iter){
    800014b0:	02048663          	beqz	s1,800014dc <_ZN13SlabAllocator10printCacheEP5Cache+0x1e0>
        ConsoleUtil::print("", (uint64)iter, " ");
    800014b4:	01000693          	li	a3,16
    800014b8:	00006617          	auipc	a2,0x6
    800014bc:	c3060613          	addi	a2,a2,-976 # 800070e8 <CONSOLE_STATUS+0xd8>
    800014c0:	0004859b          	sext.w	a1,s1
    800014c4:	00006517          	auipc	a0,0x6
    800014c8:	ecc50513          	addi	a0,a0,-308 # 80007390 <CONSOLE_STATUS+0x380>
    800014cc:	00003097          	auipc	ra,0x3
    800014d0:	640080e7          	jalr	1600(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014d4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014d8:	fd9ff06f          	j	800014b0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b4>
    }
    ConsoleUtil::printString("\n");
    800014dc:	00006517          	auipc	a0,0x6
    800014e0:	e7450513          	addi	a0,a0,-396 # 80007350 <CONSOLE_STATUS+0x340>
    800014e4:	00003097          	auipc	ra,0x3
    800014e8:	508080e7          	jalr	1288(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
}
    800014ec:	01813083          	ld	ra,24(sp)
    800014f0:	01013403          	ld	s0,16(sp)
    800014f4:	00813483          	ld	s1,8(sp)
    800014f8:	00013903          	ld	s2,0(sp)
    800014fc:	02010113          	addi	sp,sp,32
    80001500:	00008067          	ret

0000000080001504 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>:

void SlabAllocator::insertIntoList(Slab *&head, Slab *slab) {
    80001504:	ff010113          	addi	sp,sp,-16
    80001508:	00813423          	sd	s0,8(sp)
    8000150c:	01010413          	addi	s0,sp,16
    slab->next = head;
    80001510:	00053783          	ld	a5,0(a0)
    80001514:	00f5b423          	sd	a5,8(a1)
    if(head)
    80001518:	00078463          	beqz	a5,80001520 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_+0x1c>
        head->prev = slab;
    8000151c:	00b7b023          	sd	a1,0(a5)
    slab->prev = nullptr;
    80001520:	0005b023          	sd	zero,0(a1)
    head = slab;
    80001524:	00b53023          	sd	a1,0(a0)
}
    80001528:	00813403          	ld	s0,8(sp)
    8000152c:	01010113          	addi	sp,sp,16
    80001530:	00008067          	ret

0000000080001534 <_ZN13SlabAllocator12allocateSlabEP5Cache>:
bool SlabAllocator::allocateSlab(Cache *cache) {
    80001534:	fd010113          	addi	sp,sp,-48
    80001538:	02113423          	sd	ra,40(sp)
    8000153c:	02813023          	sd	s0,32(sp)
    80001540:	00913c23          	sd	s1,24(sp)
    80001544:	01213823          	sd	s2,16(sp)
    80001548:	01313423          	sd	s3,8(sp)
    8000154c:	03010413          	addi	s0,sp,48
    80001550:	00050993          	mv	s3,a0
    Slab* slab = (Slab*)Buddy::alloc(cache->slabSize);
    80001554:	04853503          	ld	a0,72(a0)
    80001558:	00001097          	auipc	ra,0x1
    8000155c:	d54080e7          	jalr	-684(ra) # 800022ac <_ZN5Buddy5allocEm>
    if(!slab)
    80001560:	0a050863          	beqz	a0,80001610 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xdc>
    80001564:	00050493          	mv	s1,a0
    SlabAllocator::insertIntoList(cache->emptyHead, slab);
    80001568:	00050593          	mv	a1,a0
    8000156c:	06098513          	addi	a0,s3,96
    80001570:	00000097          	auipc	ra,0x0
    80001574:	f94080e7          	jalr	-108(ra) # 80001504 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    slab->totalNumOfSlots = slab->numOfFreeSlots = ((cache->slabSize << BLOCK_SIZE_BITS) - sizeof(Slab)) / cache->objectSize;
    80001578:	0489b783          	ld	a5,72(s3)
    8000157c:	00c79793          	slli	a5,a5,0xc
    80001580:	fc878793          	addi	a5,a5,-56
    80001584:	0409b703          	ld	a4,64(s3)
    80001588:	02e7d7b3          	divu	a5,a5,a4
    8000158c:	00f4b823          	sd	a5,16(s1)
    80001590:	00f4bc23          	sd	a5,24(s1)
    slab->objectOffset = (void*)((uint64)slab + sizeof(Slab) + slab->totalNumOfSlots/8 + 1);
    80001594:	0037d793          	srli	a5,a5,0x3
    80001598:	009787b3          	add	a5,a5,s1
    8000159c:	03978793          	addi	a5,a5,57
    800015a0:	02f4b423          	sd	a5,40(s1)
    slab->allocated = (char*)((uint64)slab + sizeof(Slab));
    800015a4:	03848793          	addi	a5,s1,56
    800015a8:	02f4b023          	sd	a5,32(s1)
    slab->parent = cache;
    800015ac:	0334b823          	sd	s3,48(s1)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015b0:	00000713          	li	a4,0
    800015b4:	0184b783          	ld	a5,24(s1)
    800015b8:	0037d793          	srli	a5,a5,0x3
    800015bc:	00178793          	addi	a5,a5,1
    800015c0:	00f77c63          	bgeu	a4,a5,800015d8 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xa4>
        slab->allocated[i] = 0;
    800015c4:	0204b783          	ld	a5,32(s1)
    800015c8:	00e787b3          	add	a5,a5,a4
    800015cc:	00078023          	sb	zero,0(a5)
    for(uint64 i=0;i<slab->totalNumOfSlots/8 + 1;i++)
    800015d0:	00170713          	addi	a4,a4,1
    800015d4:	fe1ff06f          	j	800015b4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0x80>
    if(cache->ctor) {
    800015d8:	0509b783          	ld	a5,80(s3)
    800015dc:	02078e63          	beqz	a5,80001618 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xe4>
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    800015e0:	00000913          	li	s2,0
    800015e4:	0184b783          	ld	a5,24(s1)
    800015e8:	02f97c63          	bgeu	s2,a5,80001620 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xec>
            cache->ctor((void *) ((uint64) slab->objectOffset + i * slab->parent->objectSize));
    800015ec:	0509b703          	ld	a4,80(s3)
    800015f0:	0284b503          	ld	a0,40(s1)
    800015f4:	0304b783          	ld	a5,48(s1)
    800015f8:	0407b783          	ld	a5,64(a5)
    800015fc:	032787b3          	mul	a5,a5,s2
    80001600:	00f50533          	add	a0,a0,a5
    80001604:	000700e7          	jalr	a4
        for (uint64 i = 0; i < slab->totalNumOfSlots; i++) {
    80001608:	00190913          	addi	s2,s2,1
    8000160c:	fd9ff06f          	j	800015e4 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xb0>
        return false;
    80001610:	00000513          	li	a0,0
    80001614:	0100006f          	j	80001624 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    return true;
    80001618:	00100513          	li	a0,1
    8000161c:	0080006f          	j	80001624 <_ZN13SlabAllocator12allocateSlabEP5Cache+0xf0>
    80001620:	00100513          	li	a0,1
}
    80001624:	02813083          	ld	ra,40(sp)
    80001628:	02013403          	ld	s0,32(sp)
    8000162c:	01813483          	ld	s1,24(sp)
    80001630:	01013903          	ld	s2,16(sp)
    80001634:	00813983          	ld	s3,8(sp)
    80001638:	03010113          	addi	sp,sp,48
    8000163c:	00008067          	ret

0000000080001640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>:

void SlabAllocator::removeFromList(Slab* &head, Slab* slab) {
    80001640:	ff010113          	addi	sp,sp,-16
    80001644:	00813423          	sd	s0,8(sp)
    80001648:	01010413          	addi	s0,sp,16
    if(slab == head)
    8000164c:	00053783          	ld	a5,0(a0)
    80001650:	02b78c63          	beq	a5,a1,80001688 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x48>
        head = slab->next;
    if(slab->next)
    80001654:	0085b783          	ld	a5,8(a1)
    80001658:	00078663          	beqz	a5,80001664 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x24>
        slab->next->prev = slab->prev;
    8000165c:	0005b703          	ld	a4,0(a1)
    80001660:	00e7b023          	sd	a4,0(a5)
    if(slab->prev)
    80001664:	0005b783          	ld	a5,0(a1)
    80001668:	00078663          	beqz	a5,80001674 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x34>
        slab->prev->next = slab->next;
    8000166c:	0085b703          	ld	a4,8(a1)
    80001670:	00e7b423          	sd	a4,8(a5)
    slab->prev = nullptr;
    80001674:	0005b023          	sd	zero,0(a1)
    slab->next = nullptr;
    80001678:	0005b423          	sd	zero,8(a1)
}
    8000167c:	00813403          	ld	s0,8(sp)
    80001680:	01010113          	addi	sp,sp,16
    80001684:	00008067          	ret
        head = slab->next;
    80001688:	0085b783          	ld	a5,8(a1)
    8000168c:	00f53023          	sd	a5,0(a0)
    80001690:	fc5ff06f          	j	80001654 <_ZN13SlabAllocator14removeFromListERP4SlabS1_+0x14>

0000000080001694 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>:

void SlabAllocator::move(Slab* &headFrom, Slab* &headTo, Slab* slab) {
    80001694:	fe010113          	addi	sp,sp,-32
    80001698:	00113c23          	sd	ra,24(sp)
    8000169c:	00813823          	sd	s0,16(sp)
    800016a0:	00913423          	sd	s1,8(sp)
    800016a4:	01213023          	sd	s2,0(sp)
    800016a8:	02010413          	addi	s0,sp,32
    800016ac:	00058913          	mv	s2,a1
    800016b0:	00060493          	mv	s1,a2
    SlabAllocator::removeFromList(headFrom, slab);
    800016b4:	00060593          	mv	a1,a2
    800016b8:	00000097          	auipc	ra,0x0
    800016bc:	f88080e7          	jalr	-120(ra) # 80001640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
    SlabAllocator::insertIntoList(headTo, slab);
    800016c0:	00048593          	mv	a1,s1
    800016c4:	00090513          	mv	a0,s2
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	e3c080e7          	jalr	-452(ra) # 80001504 <_ZN13SlabAllocator14insertIntoListERP4SlabS1_>
    800016d0:	01813083          	ld	ra,24(sp)
    800016d4:	01013403          	ld	s0,16(sp)
    800016d8:	00813483          	ld	s1,8(sp)
    800016dc:	00013903          	ld	s2,0(sp)
    800016e0:	02010113          	addi	sp,sp,32
    800016e4:	00008067          	ret

00000000800016e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>:
void* SlabAllocator::allocateSlot(Slab *slab) {
    800016e8:	fe010113          	addi	sp,sp,-32
    800016ec:	00113c23          	sd	ra,24(sp)
    800016f0:	00813823          	sd	s0,16(sp)
    800016f4:	00913423          	sd	s1,8(sp)
    800016f8:	01213023          	sd	s2,0(sp)
    800016fc:	02010413          	addi	s0,sp,32
    80001700:	00050913          	mv	s2,a0
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001704:	00000493          	li	s1,0
    80001708:	01893783          	ld	a5,24(s2)
    8000170c:	0af4f863          	bgeu	s1,a5,800017bc <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd4>
        if(!(slab->allocated[i/8] & (1<<(7 - i%8)))){
    80001710:	02093783          	ld	a5,32(s2)
    80001714:	0034d713          	srli	a4,s1,0x3
    80001718:	00e787b3          	add	a5,a5,a4
    8000171c:	0007c603          	lbu	a2,0(a5)
    80001720:	fff4c713          	not	a4,s1
    80001724:	00777713          	andi	a4,a4,7
    80001728:	40e656bb          	sraw	a3,a2,a4
    8000172c:	0016f693          	andi	a3,a3,1
    80001730:	00068663          	beqz	a3,8000173c <_ZN13SlabAllocator12allocateSlotEP4Slab+0x54>
    for(uint64 i=0; i<slab->totalNumOfSlots; i++){
    80001734:	00148493          	addi	s1,s1,1
    80001738:	fd1ff06f          	j	80001708 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x20>
            slab->allocated[i/8] |= (1<<(7 - i%8));
    8000173c:	00100693          	li	a3,1
    80001740:	00e6973b          	sllw	a4,a3,a4
    80001744:	00e66633          	or	a2,a2,a4
    80001748:	00c78023          	sb	a2,0(a5)
typedef class Cache kmem_cache_t;

typedef class Slab{
public:
    inline bool isFull(){return numOfFreeSlots == 0;}
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    8000174c:	01093783          	ld	a5,16(s2)
    80001750:	01893703          	ld	a4,24(s2)
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001754:	04f70863          	beq	a4,a5,800017a4 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xbc>
    80001758:	03093503          	ld	a0,48(s2)
    8000175c:	06850513          	addi	a0,a0,104
            slab->numOfFreeSlots--;
    80001760:	fff78793          	addi	a5,a5,-1
    80001764:	00f93823          	sd	a5,16(s2)
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001768:	04079463          	bnez	a5,800017b0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xc8>
    8000176c:	03093583          	ld	a1,48(s2)
    80001770:	07058593          	addi	a1,a1,112
            if(headTo != headFrom)
    80001774:	0005b703          	ld	a4,0(a1)
    80001778:	00053783          	ld	a5,0(a0)
    8000177c:	00f70863          	beq	a4,a5,8000178c <_ZN13SlabAllocator12allocateSlotEP4Slab+0xa4>
                SlabAllocator::move(headFrom, headTo, slab);
    80001780:	00090613          	mv	a2,s2
    80001784:	00000097          	auipc	ra,0x0
    80001788:	f10080e7          	jalr	-240(ra) # 80001694 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
            return (void*)((uint64)slab->objectOffset + i*slab->parent->objectSize);
    8000178c:	02893503          	ld	a0,40(s2)
    80001790:	03093783          	ld	a5,48(s2)
    80001794:	0407b783          	ld	a5,64(a5)
    80001798:	029784b3          	mul	s1,a5,s1
    8000179c:	00950533          	add	a0,a0,s1
    800017a0:	0200006f          	j	800017c0 <_ZN13SlabAllocator12allocateSlotEP4Slab+0xd8>
            Slab* &headFrom = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    800017a4:	03093503          	ld	a0,48(s2)
    800017a8:	06050513          	addi	a0,a0,96
    800017ac:	fb5ff06f          	j	80001760 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x78>
            Slab* &headTo = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    800017b0:	03093583          	ld	a1,48(s2)
    800017b4:	06858593          	addi	a1,a1,104
    800017b8:	fbdff06f          	j	80001774 <_ZN13SlabAllocator12allocateSlotEP4Slab+0x8c>
    return nullptr;
    800017bc:	00000513          	li	a0,0
}
    800017c0:	01813083          	ld	ra,24(sp)
    800017c4:	01013403          	ld	s0,16(sp)
    800017c8:	00813483          	ld	s1,8(sp)
    800017cc:	00013903          	ld	s2,0(sp)
    800017d0:	02010113          	addi	sp,sp,32
    800017d4:	00008067          	ret

00000000800017d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>:
void* SlabAllocator::allocateObject(Cache *cache) {
    800017d8:	fe010113          	addi	sp,sp,-32
    800017dc:	00113c23          	sd	ra,24(sp)
    800017e0:	00813823          	sd	s0,16(sp)
    800017e4:	00913423          	sd	s1,8(sp)
    800017e8:	01213023          	sd	s2,0(sp)
    800017ec:	02010413          	addi	s0,sp,32
    800017f0:	00050913          	mv	s2,a0
    void* ret = SlabAllocator::allocateFromList(cache->partialHead);
    800017f4:	06853483          	ld	s1,104(a0)
    static void move(Slab* &headFrom, Slab* &headTo, Slab* slab);
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    static inline uint64 getLowerBound(Slab* slab){return (uint64)slab->objectOffset;}

    static inline void* allocateFromList(Slab* head){
        while(head != nullptr){
    800017f8:	00048c63          	beqz	s1,80001810 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x38>
            void* ret = allocateSlot(head);
    800017fc:	00048513          	mv	a0,s1
    80001800:	00000097          	auipc	ra,0x0
    80001804:	ee8080e7          	jalr	-280(ra) # 800016e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001808:	fe0508e3          	beqz	a0,800017f8 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x20>
                return ret;
    8000180c:	00050493          	mv	s1,a0
    if(ret){
    80001810:	02048063          	beqz	s1,80001830 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x58>
}
    80001814:	00048513          	mv	a0,s1
    80001818:	01813083          	ld	ra,24(sp)
    8000181c:	01013403          	ld	s0,16(sp)
    80001820:	00813483          	ld	s1,8(sp)
    80001824:	00013903          	ld	s2,0(sp)
    80001828:	02010113          	addi	sp,sp,32
    8000182c:	00008067          	ret
    ret = SlabAllocator::allocateFromList(cache->emptyHead);
    80001830:	06093483          	ld	s1,96(s2)
        while(head != nullptr){
    80001834:	00048c63          	beqz	s1,8000184c <_ZN13SlabAllocator14allocateObjectEP5Cache+0x74>
            void* ret = allocateSlot(head);
    80001838:	00048513          	mv	a0,s1
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	eac080e7          	jalr	-340(ra) # 800016e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
            if(ret != nullptr)
    80001844:	fe0508e3          	beqz	a0,80001834 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x5c>
                return ret;
    80001848:	00050493          	mv	s1,a0
    if(ret){
    8000184c:	fc0494e3          	bnez	s1,80001814 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    if(!SlabAllocator::allocateSlab(cache))
    80001850:	00090513          	mv	a0,s2
    80001854:	00000097          	auipc	ra,0x0
    80001858:	ce0080e7          	jalr	-800(ra) # 80001534 <_ZN13SlabAllocator12allocateSlabEP5Cache>
    8000185c:	fa050ce3          	beqz	a0,80001814 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>
    ret = SlabAllocator::allocateSlot(cache->emptyHead);
    80001860:	06093503          	ld	a0,96(s2)
    80001864:	00000097          	auipc	ra,0x0
    80001868:	e84080e7          	jalr	-380(ra) # 800016e8 <_ZN13SlabAllocator12allocateSlotEP4Slab>
    8000186c:	00050493          	mv	s1,a0
    return ret;
    80001870:	fa5ff06f          	j	80001814 <_ZN13SlabAllocator14allocateObjectEP5Cache+0x3c>

0000000080001874 <_ZN13SlabAllocator14allocateBufferEm>:
    static void* BUDDY_START_ADDR;
    static uint64 BLOCKS_AVAILABLE;
    static Bucket *head[BUCKET_SIZE], *tail[BUCKET_SIZE];

    static inline uint64 ceil(uint64 num){
        num--;
    80001874:	fff50793          	addi	a5,a0,-1
        num |= num>>1;
    80001878:	0017d513          	srli	a0,a5,0x1
    8000187c:	00a7e7b3          	or	a5,a5,a0
        num |= num>>2;
    80001880:	0027d713          	srli	a4,a5,0x2
    80001884:	00e7e7b3          	or	a5,a5,a4
        num |= num>>4;
    80001888:	0047d713          	srli	a4,a5,0x4
    8000188c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>8;
    80001890:	0087d713          	srli	a4,a5,0x8
    80001894:	00e7e7b3          	or	a5,a5,a4
        num |= num>>16;
    80001898:	0107d713          	srli	a4,a5,0x10
    8000189c:	00e7e7b3          	or	a5,a5,a4
        num |= num>>32;
    800018a0:	0207d713          	srli	a4,a5,0x20
    800018a4:	00e7e7b3          	or	a5,a5,a4
        return ++num;
    800018a8:	00178793          	addi	a5,a5,1
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    800018ac:	00000713          	li	a4,0
        while(num>1){
    800018b0:	00100693          	li	a3,1
    800018b4:	00f6f863          	bgeu	a3,a5,800018c4 <_ZN13SlabAllocator14allocateBufferEm+0x50>
            num/=2;
    800018b8:	0017d793          	srli	a5,a5,0x1
            deg++;
    800018bc:	00170713          	addi	a4,a4,1
        while(num>1){
    800018c0:	ff1ff06f          	j	800018b0 <_ZN13SlabAllocator14allocateBufferEm+0x3c>
    if(level < CACHE_LOWER_BOUND || level > CACHE_UPPER_BOUND)
    800018c4:	ffb70713          	addi	a4,a4,-5
    800018c8:	00c00793          	li	a5,12
    800018cc:	04e7e063          	bltu	a5,a4,8000190c <_ZN13SlabAllocator14allocateBufferEm+0x98>
void* SlabAllocator::allocateBuffer(size_t size) {
    800018d0:	ff010113          	addi	sp,sp,-16
    800018d4:	00113423          	sd	ra,8(sp)
    800018d8:	00813023          	sd	s0,0(sp)
    800018dc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(sizeN[level]);
    800018e0:	00371713          	slli	a4,a4,0x3
    800018e4:	00006797          	auipc	a5,0x6
    800018e8:	23c78793          	addi	a5,a5,572 # 80007b20 <_ZN13SlabAllocator5sizeNE>
    800018ec:	00e78733          	add	a4,a5,a4
    800018f0:	00073503          	ld	a0,0(a4)
    800018f4:	00000097          	auipc	ra,0x0
    800018f8:	ee4080e7          	jalr	-284(ra) # 800017d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    800018fc:	00813083          	ld	ra,8(sp)
    80001900:	00013403          	ld	s0,0(sp)
    80001904:	01010113          	addi	sp,sp,16
    80001908:	00008067          	ret
        return nullptr;
    8000190c:	00000513          	li	a0,0
}
    80001910:	00008067          	ret

0000000080001914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>:
Cache* SlabAllocator::createCache(const char *name, size_t size, void (*ctor)(void *), void (*dtor)(void *)) {
    80001914:	fc010113          	addi	sp,sp,-64
    80001918:	02113c23          	sd	ra,56(sp)
    8000191c:	02813823          	sd	s0,48(sp)
    80001920:	02913423          	sd	s1,40(sp)
    80001924:	03213023          	sd	s2,32(sp)
    80001928:	01313c23          	sd	s3,24(sp)
    8000192c:	01413823          	sd	s4,16(sp)
    80001930:	01513423          	sd	s5,8(sp)
    80001934:	04010413          	addi	s0,sp,64
    80001938:	00050913          	mv	s2,a0
    8000193c:	00058993          	mv	s3,a1
    80001940:	00060a93          	mv	s5,a2
    80001944:	00068a13          	mv	s4,a3
    Cache* ret = (Cache*)SlabAllocator::allocateObject(SlabAllocator::cache);
    80001948:	00006517          	auipc	a0,0x6
    8000194c:	24053503          	ld	a0,576(a0) # 80007b88 <_ZN13SlabAllocator5cacheE>
    80001950:	00000097          	auipc	ra,0x0
    80001954:	e88080e7          	jalr	-376(ra) # 800017d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
    80001958:	00050493          	mv	s1,a0
    if(ret == nullptr)
    8000195c:	02050a63          	beqz	a0,80001990 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_+0x7c>
    ret->ctor = ctor;
    80001960:	05553823          	sd	s5,80(a0)
    ret->dtor = dtor;
    80001964:	05453c23          	sd	s4,88(a0)
    ret->emptyHead = ret->partialHead = ret->fullHead = nullptr;
    80001968:	06053823          	sd	zero,112(a0)
    8000196c:	06053423          	sd	zero,104(a0)
    80001970:	06053023          	sd	zero,96(a0)
    ret->objectSize = size;
    80001974:	05353023          	sd	s3,64(a0)
    ret->slabSize = DEFAULT_SLAB_SIZE;
    80001978:	00200793          	li	a5,2
    8000197c:	04f53423          	sd	a5,72(a0)
    strcpy(name, ret->name);
    80001980:	00050593          	mv	a1,a0
    80001984:	00090513          	mv	a0,s2
    80001988:	00003097          	auipc	ra,0x3
    8000198c:	b2c080e7          	jalr	-1236(ra) # 800044b4 <_Z6strcpyPKcPc>
}
    80001990:	00048513          	mv	a0,s1
    80001994:	03813083          	ld	ra,56(sp)
    80001998:	03013403          	ld	s0,48(sp)
    8000199c:	02813483          	ld	s1,40(sp)
    800019a0:	02013903          	ld	s2,32(sp)
    800019a4:	01813983          	ld	s3,24(sp)
    800019a8:	01013a03          	ld	s4,16(sp)
    800019ac:	00813a83          	ld	s5,8(sp)
    800019b0:	04010113          	addi	sp,sp,64
    800019b4:	00008067          	ret

00000000800019b8 <_ZN13SlabAllocator10initializeEPvm>:
void SlabAllocator::initialize(void* space, uint64 blockNum) {
    800019b8:	fe010113          	addi	sp,sp,-32
    800019bc:	00113c23          	sd	ra,24(sp)
    800019c0:	00813823          	sd	s0,16(sp)
    800019c4:	00913423          	sd	s1,8(sp)
    800019c8:	01213023          	sd	s2,0(sp)
    800019cc:	02010413          	addi	s0,sp,32
    800019d0:	00050913          	mv	s2,a0
    800019d4:	00058493          	mv	s1,a1
    Buddy::initialize(space, blockNum);
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	504080e7          	jalr	1284(ra) # 80001edc <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    800019e0:	00006797          	auipc	a5,0x6
    800019e4:	14078793          	addi	a5,a5,320 # 80007b20 <_ZN13SlabAllocator5sizeNE>
    800019e8:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800019ec:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800019f0:	00006717          	auipc	a4,0x6
    800019f4:	01873703          	ld	a4,24(a4) # 80007a08 <_GLOBAL_OFFSET_TABLE_+0x18>
    800019f8:	00073583          	ld	a1,0(a4)
    800019fc:	00c5d593          	srli	a1,a1,0xc
    80001a00:	00158593          	addi	a1,a1,1
    80001a04:	00c59593          	slli	a1,a1,0xc
    80001a08:	06b7b423          	sd	a1,104(a5)
    cache->ctor = nullptr;
    80001a0c:	0405b823          	sd	zero,80(a1)
    cache->dtor = nullptr;
    80001a10:	0405bc23          	sd	zero,88(a1)
    cache->emptyHead = nullptr;
    80001a14:	0605b023          	sd	zero,96(a1)
    cache->partialHead = nullptr;
    80001a18:	0605b423          	sd	zero,104(a1)
    cache->fullHead = nullptr;
    80001a1c:	0605b823          	sd	zero,112(a1)
    cache->objectSize = sizeof(Cache);
    80001a20:	07800793          	li	a5,120
    80001a24:	04f5b023          	sd	a5,64(a1)
    cache->slabSize = DEFAULT_SLAB_SIZE;
    80001a28:	00200793          	li	a5,2
    80001a2c:	04f5b423          	sd	a5,72(a1)
    strcpy("Main Cache", cache->name);
    80001a30:	00005517          	auipc	a0,0x5
    80001a34:	73050513          	addi	a0,a0,1840 # 80007160 <CONSOLE_STATUS+0x150>
    80001a38:	00003097          	auipc	ra,0x3
    80001a3c:	a7c080e7          	jalr	-1412(ra) # 800044b4 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a40:	00000493          	li	s1,0
    80001a44:	0440006f          	j	80001a88 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a48:	00349913          	slli	s2,s1,0x3
    80001a4c:	00006797          	auipc	a5,0x6
    80001a50:	f2478793          	addi	a5,a5,-220 # 80007970 <_ZN13SlabAllocator5namesE>
    80001a54:	012787b3          	add	a5,a5,s2
    80001a58:	00000693          	li	a3,0
    80001a5c:	00000613          	li	a2,0
    80001a60:	00200593          	li	a1,2
    80001a64:	009595bb          	sllw	a1,a1,s1
    80001a68:	0007b503          	ld	a0,0(a5)
    80001a6c:	00000097          	auipc	ra,0x0
    80001a70:	ea8080e7          	jalr	-344(ra) # 80001914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a74:	00006797          	auipc	a5,0x6
    80001a78:	0ac78793          	addi	a5,a5,172 # 80007b20 <_ZN13SlabAllocator5sizeNE>
    80001a7c:	012787b3          	add	a5,a5,s2
    80001a80:	00a7b023          	sd	a0,0(a5)
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a84:	0014849b          	addiw	s1,s1,1
    80001a88:	00c00793          	li	a5,12
    80001a8c:	fa97dee3          	bge	a5,s1,80001a48 <_ZN13SlabAllocator10initializeEPvm+0x90>
}
    80001a90:	01813083          	ld	ra,24(sp)
    80001a94:	01013403          	ld	s0,16(sp)
    80001a98:	00813483          	ld	s1,8(sp)
    80001a9c:	00013903          	ld	s2,0(sp)
    80001aa0:	02010113          	addi	sp,sp,32
    80001aa4:	00008067          	ret

0000000080001aa8 <_ZN13SlabAllocator8freeSlotEP4Slabm>:
    if(slab->allocated[index/8] & (1<<(7 - index%8))) {
    80001aa8:	02053783          	ld	a5,32(a0)
    80001aac:	0035d713          	srli	a4,a1,0x3
    80001ab0:	00e787b3          	add	a5,a5,a4
    80001ab4:	0007c683          	lbu	a3,0(a5)
    80001ab8:	fff5c593          	not	a1,a1
    80001abc:	0075f593          	andi	a1,a1,7
    80001ac0:	40b6d73b          	sraw	a4,a3,a1
    80001ac4:	00177713          	andi	a4,a4,1
    80001ac8:	0c070263          	beqz	a4,80001b8c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xe4>
void SlabAllocator::freeSlot(Slab *slab, uint64 index) {
    80001acc:	fe010113          	addi	sp,sp,-32
    80001ad0:	00113c23          	sd	ra,24(sp)
    80001ad4:	00813823          	sd	s0,16(sp)
    80001ad8:	00913423          	sd	s1,8(sp)
    80001adc:	02010413          	addi	s0,sp,32
    80001ae0:	00050493          	mv	s1,a0
        slab->allocated[index/8] &= ~(1<<(7 - index%8));
    80001ae4:	00100713          	li	a4,1
    80001ae8:	00b715bb          	sllw	a1,a4,a1
    80001aec:	fff5c593          	not	a1,a1
    80001af0:	00d5f5b3          	and	a1,a1,a3
    80001af4:	00b78023          	sb	a1,0(a5)
    inline bool isFull(){return numOfFreeSlots == 0;}
    80001af8:	01053783          	ld	a5,16(a0)
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001afc:	04079a63          	bnez	a5,80001b50 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xa8>
    80001b00:	03053503          	ld	a0,48(a0)
    80001b04:	07050513          	addi	a0,a0,112
        slab->numOfFreeSlots++;
    80001b08:	00178793          	addi	a5,a5,1
    80001b0c:	00f4b823          	sd	a5,16(s1)
    inline bool isEmpty(){return numOfFreeSlots == totalNumOfSlots;}
    80001b10:	0184b703          	ld	a4,24(s1)
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b14:	04e78463          	beq	a5,a4,80001b5c <_ZN13SlabAllocator8freeSlotEP4Slabm+0xb4>
    80001b18:	0304b583          	ld	a1,48(s1)
    80001b1c:	06858593          	addi	a1,a1,104
        if(slab->isEmpty()) {
    80001b20:	04e78463          	beq	a5,a4,80001b68 <_ZN13SlabAllocator8freeSlotEP4Slabm+0xc0>
            if (headTo != headFrom)
    80001b24:	0005b703          	ld	a4,0(a1)
    80001b28:	00053783          	ld	a5,0(a0)
    80001b2c:	00f70863          	beq	a4,a5,80001b3c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
                SlabAllocator::move(headFrom, headTo, slab);
    80001b30:	00048613          	mv	a2,s1
    80001b34:	00000097          	auipc	ra,0x0
    80001b38:	b60080e7          	jalr	-1184(ra) # 80001694 <_ZN13SlabAllocator4moveERP4SlabS2_S1_>
}
    80001b3c:	01813083          	ld	ra,24(sp)
    80001b40:	01013403          	ld	s0,16(sp)
    80001b44:	00813483          	ld	s1,8(sp)
    80001b48:	02010113          	addi	sp,sp,32
    80001b4c:	00008067          	ret
        Slab *&headFrom = slab->isFull() ? slab->parent->fullHead : slab->parent->partialHead;
    80001b50:	03053503          	ld	a0,48(a0)
    80001b54:	06850513          	addi	a0,a0,104
    80001b58:	fb1ff06f          	j	80001b08 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x60>
        Slab *&headTo = slab->isEmpty() ? slab->parent->emptyHead : slab->parent->partialHead;
    80001b5c:	0304b583          	ld	a1,48(s1)
    80001b60:	06058593          	addi	a1,a1,96
    80001b64:	fbdff06f          	j	80001b20 <_ZN13SlabAllocator8freeSlotEP4Slabm+0x78>
            SlabAllocator::removeFromList(headFrom, slab);
    80001b68:	00048593          	mv	a1,s1
    80001b6c:	00000097          	auipc	ra,0x0
    80001b70:	ad4080e7          	jalr	-1324(ra) # 80001640 <_ZN13SlabAllocator14removeFromListERP4SlabS1_>
            Buddy::free(slab, slab->parent->slabSize);
    80001b74:	0304b783          	ld	a5,48(s1)
    80001b78:	0487b583          	ld	a1,72(a5)
    80001b7c:	00048513          	mv	a0,s1
    80001b80:	00000097          	auipc	ra,0x0
    80001b84:	654080e7          	jalr	1620(ra) # 800021d4 <_ZN5Buddy4freeEPvm>
    80001b88:	fb5ff06f          	j	80001b3c <_ZN13SlabAllocator8freeSlotEP4Slabm+0x94>
    80001b8c:	00008067          	ret

0000000080001b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>:
bool SlabAllocator::freeObject(Cache* cache, const void *addr) {
    80001b90:	fe010113          	addi	sp,sp,-32
    80001b94:	00113c23          	sd	ra,24(sp)
    80001b98:	00813823          	sd	s0,16(sp)
    80001b9c:	00913423          	sd	s1,8(sp)
    80001ba0:	01213023          	sd	s2,0(sp)
    80001ba4:	02010413          	addi	s0,sp,32
    80001ba8:	00050913          	mv	s2,a0
    80001bac:	00058493          	mv	s1,a1
    if(cache->dtor)
    80001bb0:	05853783          	ld	a5,88(a0)
    80001bb4:	00078663          	beqz	a5,80001bc0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x30>
        cache->dtor((void*)addr);
    80001bb8:	00058513          	mv	a0,a1
    80001bbc:	000780e7          	jalr	a5
    if(cache->ctor)
    80001bc0:	05093783          	ld	a5,80(s2)
    80001bc4:	00078663          	beqz	a5,80001bd0 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x40>
        cache->ctor((void*)addr);
    80001bc8:	00048513          	mv	a0,s1
    80001bcc:	000780e7          	jalr	a5
    bool deleted = SlabAllocator::freeFromList(cache->fullHead, addr);
    80001bd0:	07093503          	ld	a0,112(s2)
    80001bd4:	0080006f          	j	80001bdc <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x4c>
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
                freeSlot(head, index);
                return true;
            }
            head = head->next;
    80001bd8:	00853503          	ld	a0,8(a0)
        while(head){
    80001bdc:	02050e63          	beqz	a0,80001c18 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x88>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001be0:	02853703          	ld	a4,40(a0)
    80001be4:	01853783          	ld	a5,24(a0)
    80001be8:	03053683          	ld	a3,48(a0)
    80001bec:	0406b583          	ld	a1,64(a3)
    80001bf0:	02b787b3          	mul	a5,a5,a1
    80001bf4:	00f707b3          	add	a5,a4,a5
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001bf8:	fef4f0e3          	bgeu	s1,a5,80001bd8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
    80001bfc:	fce4eee3          	bltu	s1,a4,80001bd8 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x48>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c00:	40e48733          	sub	a4,s1,a4
                freeSlot(head, index);
    80001c04:	02b755b3          	divu	a1,a4,a1
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	ea0080e7          	jalr	-352(ra) # 80001aa8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c10:	00100513          	li	a0,1
    80001c14:	0080006f          	j	80001c1c <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x8c>
        }
        return false;
    80001c18:	00000513          	li	a0,0
    if(deleted)
    80001c1c:	00050e63          	beqz	a0,80001c38 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xa8>
}
    80001c20:	01813083          	ld	ra,24(sp)
    80001c24:	01013403          	ld	s0,16(sp)
    80001c28:	00813483          	ld	s1,8(sp)
    80001c2c:	00013903          	ld	s2,0(sp)
    80001c30:	02010113          	addi	sp,sp,32
    80001c34:	00008067          	ret
    deleted = SlabAllocator::freeFromList(cache->partialHead, addr);
    80001c38:	06893783          	ld	a5,104(s2)
    80001c3c:	0080006f          	j	80001c44 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb4>
            head = head->next;
    80001c40:	0087b783          	ld	a5,8(a5)
        while(head){
    80001c44:	fc078ee3          	beqz	a5,80001c20 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>
    static inline uint64 getUpperBound(Slab* slab){return (uint64)slab->objectOffset + slab->totalNumOfSlots*slab->parent->objectSize;}
    80001c48:	0287b683          	ld	a3,40(a5)
    80001c4c:	0187b703          	ld	a4,24(a5)
    80001c50:	0307b603          	ld	a2,48(a5)
    80001c54:	04063583          	ld	a1,64(a2)
    80001c58:	02b70733          	mul	a4,a4,a1
    80001c5c:	00e68733          	add	a4,a3,a4
            if((uint64)addr < upperBound && (uint64)addr >= lowerBound){
    80001c60:	fee4f0e3          	bgeu	s1,a4,80001c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
    80001c64:	fcd4eee3          	bltu	s1,a3,80001c40 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0xb0>
                uint64 index = ((uint64)addr - lowerBound) / head->parent->objectSize;
    80001c68:	40d486b3          	sub	a3,s1,a3
                freeSlot(head, index);
    80001c6c:	02b6d5b3          	divu	a1,a3,a1
    80001c70:	00078513          	mv	a0,a5
    80001c74:	00000097          	auipc	ra,0x0
    80001c78:	e34080e7          	jalr	-460(ra) # 80001aa8 <_ZN13SlabAllocator8freeSlotEP4Slabm>
                return true;
    80001c7c:	00100513          	li	a0,1
    80001c80:	fa1ff06f          	j	80001c20 <_ZN13SlabAllocator10freeObjectEP5CachePKv+0x90>

0000000080001c84 <_ZN13SlabAllocator10freeBufferEPKv>:
void SlabAllocator::freeBuffer(const void *addr) {
    80001c84:	fe010113          	addi	sp,sp,-32
    80001c88:	00113c23          	sd	ra,24(sp)
    80001c8c:	00813823          	sd	s0,16(sp)
    80001c90:	00913423          	sd	s1,8(sp)
    80001c94:	01213023          	sd	s2,0(sp)
    80001c98:	02010413          	addi	s0,sp,32
    80001c9c:	00050913          	mv	s2,a0
    for(int i=0;i<BUCKET_SIZE;i++)
    80001ca0:	00000493          	li	s1,0
    80001ca4:	00c00793          	li	a5,12
    80001ca8:	0297c863          	blt	a5,s1,80001cd8 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
        if(SlabAllocator::freeObject(sizeN[i], addr))
    80001cac:	00349713          	slli	a4,s1,0x3
    80001cb0:	00006797          	auipc	a5,0x6
    80001cb4:	e7078793          	addi	a5,a5,-400 # 80007b20 <_ZN13SlabAllocator5sizeNE>
    80001cb8:	00e787b3          	add	a5,a5,a4
    80001cbc:	00090593          	mv	a1,s2
    80001cc0:	0007b503          	ld	a0,0(a5)
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	ecc080e7          	jalr	-308(ra) # 80001b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    80001ccc:	00051663          	bnez	a0,80001cd8 <_ZN13SlabAllocator10freeBufferEPKv+0x54>
    for(int i=0;i<BUCKET_SIZE;i++)
    80001cd0:	0014849b          	addiw	s1,s1,1
    80001cd4:	fd1ff06f          	j	80001ca4 <_ZN13SlabAllocator10freeBufferEPKv+0x20>
}
    80001cd8:	01813083          	ld	ra,24(sp)
    80001cdc:	01013403          	ld	s0,16(sp)
    80001ce0:	00813483          	ld	s1,8(sp)
    80001ce4:	00013903          	ld	s2,0(sp)
    80001ce8:	02010113          	addi	sp,sp,32
    80001cec:	00008067          	ret

0000000080001cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache>:
void SlabAllocator::deleteCache(Cache* &cache) {
    80001cf0:	fe010113          	addi	sp,sp,-32
    80001cf4:	00113c23          	sd	ra,24(sp)
    80001cf8:	00813823          	sd	s0,16(sp)
    80001cfc:	00913423          	sd	s1,8(sp)
    80001d00:	01213023          	sd	s2,0(sp)
    80001d04:	02010413          	addi	s0,sp,32
    80001d08:	00050493          	mv	s1,a0
    deleteList(cache->fullHead);
    80001d0c:	00053903          	ld	s2,0(a0)
    80001d10:	07090913          	addi	s2,s2,112
    }

    static inline void deleteList(Slab* &head){
        while(head){
    80001d14:	00093503          	ld	a0,0(s2)
    80001d18:	02050263          	beqz	a0,80001d3c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x4c>
            Slab* tmp = head;
            Buddy::free(tmp, head->parent->slabSize);
    80001d1c:	03053783          	ld	a5,48(a0)
    80001d20:	0487b583          	ld	a1,72(a5)
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	4b0080e7          	jalr	1200(ra) # 800021d4 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d2c:	00093783          	ld	a5,0(s2)
    80001d30:	0087b783          	ld	a5,8(a5)
    80001d34:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d38:	fddff06f          	j	80001d14 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x24>
    deleteList(cache->partialHead);
    80001d3c:	0004b903          	ld	s2,0(s1)
    80001d40:	06890913          	addi	s2,s2,104
    80001d44:	00093503          	ld	a0,0(s2)
    80001d48:	02050263          	beqz	a0,80001d6c <_ZN13SlabAllocator11deleteCacheERP5Cache+0x7c>
            Buddy::free(tmp, head->parent->slabSize);
    80001d4c:	03053783          	ld	a5,48(a0)
    80001d50:	0487b583          	ld	a1,72(a5)
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	480080e7          	jalr	1152(ra) # 800021d4 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d5c:	00093783          	ld	a5,0(s2)
    80001d60:	0087b783          	ld	a5,8(a5)
    80001d64:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d68:	fddff06f          	j	80001d44 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x54>
    deleteList(cache->emptyHead);
    80001d6c:	0004b903          	ld	s2,0(s1)
    80001d70:	06090913          	addi	s2,s2,96
    80001d74:	00093503          	ld	a0,0(s2)
    80001d78:	02050263          	beqz	a0,80001d9c <_ZN13SlabAllocator11deleteCacheERP5Cache+0xac>
            Buddy::free(tmp, head->parent->slabSize);
    80001d7c:	03053783          	ld	a5,48(a0)
    80001d80:	0487b583          	ld	a1,72(a5)
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	450080e7          	jalr	1104(ra) # 800021d4 <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d8c:	00093783          	ld	a5,0(s2)
    80001d90:	0087b783          	ld	a5,8(a5)
    80001d94:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d98:	fddff06f          	j	80001d74 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001d9c:	0004b583          	ld	a1,0(s1)
    80001da0:	00006517          	auipc	a0,0x6
    80001da4:	de853503          	ld	a0,-536(a0) # 80007b88 <_ZN13SlabAllocator5cacheE>
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	de8080e7          	jalr	-536(ra) # 80001b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
    cache = nullptr;
    80001db0:	0004b023          	sd	zero,0(s1)
}
    80001db4:	01813083          	ld	ra,24(sp)
    80001db8:	01013403          	ld	s0,16(sp)
    80001dbc:	00813483          	ld	s1,8(sp)
    80001dc0:	00013903          	ld	s2,0(sp)
    80001dc4:	02010113          	addi	sp,sp,32
    80001dc8:	00008067          	ret

0000000080001dcc <_Z4ctorPv>:

struct Test{
    uint64 a,b,c,d,e,f;
};

void ctor(void* tst){
    80001dcc:	ff010113          	addi	sp,sp,-16
    80001dd0:	00813423          	sd	s0,8(sp)
    80001dd4:	01010413          	addi	s0,sp,16
    ((Test*)tst)->a = 17;
    80001dd8:	01100793          	li	a5,17
    80001ddc:	00f53023          	sd	a5,0(a0)
    ((Test*)tst)->b = 32;
    80001de0:	02000793          	li	a5,32
    80001de4:	00f53423          	sd	a5,8(a0)
    ((Test*)tst)->c = 13;
    80001de8:	00d00793          	li	a5,13
    80001dec:	00f53823          	sd	a5,16(a0)

}
    80001df0:	00813403          	ld	s0,8(sp)
    80001df4:	01010113          	addi	sp,sp,16
    80001df8:	00008067          	ret

0000000080001dfc <_ZN6SystemC1Ev>:
System::System() {
    //check whether system is already running to prevent user malicious access
    if (!initialized) {
    80001dfc:	00006797          	auipc	a5,0x6
    80001e00:	da47c783          	lbu	a5,-604(a5) # 80007ba0 <_ZN6System11initializedE>
    80001e04:	00078463          	beqz	a5,80001e0c <_ZN6SystemC1Ev+0x10>
    80001e08:	00008067          	ret
System::System() {
    80001e0c:	fe010113          	addi	sp,sp,-32
    80001e10:	00113c23          	sd	ra,24(sp)
    80001e14:	00813823          	sd	s0,16(sp)
    80001e18:	02010413          	addi	s0,sp,32
        initialized = true;
    80001e1c:	00100793          	li	a5,1
    80001e20:	00006717          	auipc	a4,0x6
    80001e24:	d8f70023          	sb	a5,-640(a4) # 80007ba0 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80001e28:	00002097          	auipc	ra,0x2
    80001e2c:	5d4080e7          	jalr	1492(ra) # 800043fc <_ZN5RiscV10initializeEv>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), userMainWrapper, nullptr);
    80001e30:	00000613          	li	a2,0
    80001e34:	00006597          	auipc	a1,0x6
    80001e38:	c2c5b583          	ld	a1,-980(a1) # 80007a60 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001e3c:	fe840513          	addi	a0,s0,-24
    80001e40:	00002097          	auipc	ra,0x2
    80001e44:	fbc080e7          	jalr	-68(ra) # 80003dfc <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001e48:	fe843783          	ld	a5,-24(s0)
    80001e4c:	0107a703          	lw	a4,16(a5)
    80001e50:	00200793          	li	a5,2
    80001e54:	00f70863          	beq	a4,a5,80001e64 <_ZN6SystemC1Ev+0x68>
            RiscV::threadDispatchUtil();
    80001e58:	00002097          	auipc	ra,0x2
    80001e5c:	040080e7          	jalr	64(ra) # 80003e98 <_ZN5RiscV18threadDispatchUtilEv>
    80001e60:	fe9ff06f          	j	80001e48 <_ZN6SystemC1Ev+0x4c>
        }

        //finalize the machine
        RiscV::finalize();
    80001e64:	00001097          	auipc	ra,0x1
    80001e68:	24c080e7          	jalr	588(ra) # 800030b0 <_ZN5RiscV8finalizeEv>
    }
    80001e6c:	01813083          	ld	ra,24(sp)
    80001e70:	01013403          	ld	s0,16(sp)
    80001e74:	02010113          	addi	sp,sp,32
    80001e78:	00008067          	ret

0000000080001e7c <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001e7c:	ff010113          	addi	sp,sp,-16
    80001e80:	00813423          	sd	s0,8(sp)
    80001e84:	01010413          	addi	s0,sp,16
    80001e88:	00100793          	li	a5,1
    80001e8c:	00f50863          	beq	a0,a5,80001e9c <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001e90:	00813403          	ld	s0,8(sp)
    80001e94:	01010113          	addi	sp,sp,16
    80001e98:	00008067          	ret
    80001e9c:	000107b7          	lui	a5,0x10
    80001ea0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001ea4:	fef596e3          	bne	a1,a5,80001e90 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80001ea8:	00006797          	auipc	a5,0x6
    80001eac:	b607b783          	ld	a5,-1184(a5) # 80007a08 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001eb0:	0007b703          	ld	a4,0(a5)
    80001eb4:	00c75793          	srli	a5,a4,0xc
    80001eb8:	00278793          	addi	a5,a5,2
    80001ebc:	00c79793          	slli	a5,a5,0xc
    80001ec0:	00006697          	auipc	a3,0x6
    80001ec4:	ce868693          	addi	a3,a3,-792 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ec8:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001ecc:	fffff7b7          	lui	a5,0xfffff
    80001ed0:	00f77733          	and	a4,a4,a5
    80001ed4:	00e6b423          	sd	a4,8(a3)
    80001ed8:	fb9ff06f          	j	80001e90 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001edc <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80001edc:	ff010113          	addi	sp,sp,-16
    80001ee0:	00813423          	sd	s0,8(sp)
    80001ee4:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80001ee8:	00006717          	auipc	a4,0x6
    80001eec:	cc070713          	addi	a4,a4,-832 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ef0:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001ef4:	00006797          	auipc	a5,0x6
    80001ef8:	b147b783          	ld	a5,-1260(a5) # 80007a08 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001efc:	0007b783          	ld	a5,0(a5)
    80001f00:	fffff6b7          	lui	a3,0xfffff
    80001f04:	00d7f7b3          	and	a5,a5,a3
    80001f08:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80001f0c:	00006797          	auipc	a5,0x6
    80001f10:	acb7b623          	sd	a1,-1332(a5) # 800079d8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80001f14:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001f18:	00000713          	li	a4,0
        while(num>1){
    80001f1c:	00100693          	li	a3,1
    80001f20:	00f6f863          	bgeu	a3,a5,80001f30 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80001f24:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f28:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f2c:	ff1ff06f          	j	80001f1c <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001f30:	00371713          	slli	a4,a4,0x3
    80001f34:	00006797          	auipc	a5,0x6
    80001f38:	c7478793          	addi	a5,a5,-908 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f3c:	00e78733          	add	a4,a5,a4
    80001f40:	00a73823          	sd	a0,16(a4)
    80001f44:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001f48:	00000713          	li	a4,0
        while(num>1){
    80001f4c:	00100693          	li	a3,1
    80001f50:	00f6f863          	bgeu	a3,a5,80001f60 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001f54:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f58:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f5c:	ff1ff06f          	j	80001f4c <_ZN5Buddy10initializeEPvm+0x70>
    80001f60:	00371713          	slli	a4,a4,0x3
    80001f64:	00006797          	auipc	a5,0x6
    80001f68:	c4478793          	addi	a5,a5,-956 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f6c:	00e78733          	add	a4,a5,a4
    80001f70:	06a73c23          	sd	a0,120(a4)
    80001f74:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001f78:	00000713          	li	a4,0
        while(num>1){
    80001f7c:	00100693          	li	a3,1
    80001f80:	00f6f863          	bgeu	a3,a5,80001f90 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001f84:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f88:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f8c:	ff1ff06f          	j	80001f7c <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001f90:	00371713          	slli	a4,a4,0x3
    80001f94:	00006797          	auipc	a5,0x6
    80001f98:	c1478793          	addi	a5,a5,-1004 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f9c:	00e78733          	add	a4,a5,a4
    80001fa0:	01073783          	ld	a5,16(a4)
    80001fa4:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001fa8:	00000793          	li	a5,0
    80001fac:	00c0006f          	j	80001fb8 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001fb0:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001fb4:	00178793          	addi	a5,a5,1
        while(num>1){
    80001fb8:	00100713          	li	a4,1
    80001fbc:	feb76ae3          	bltu	a4,a1,80001fb0 <_ZN5Buddy10initializeEPvm+0xd4>
    80001fc0:	00379793          	slli	a5,a5,0x3
    80001fc4:	00006717          	auipc	a4,0x6
    80001fc8:	be470713          	addi	a4,a4,-1052 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001fcc:	00f707b3          	add	a5,a4,a5
    80001fd0:	0787b783          	ld	a5,120(a5)
    80001fd4:	0007b023          	sd	zero,0(a5)
}
    80001fd8:	00813403          	ld	s0,8(sp)
    80001fdc:	01010113          	addi	sp,sp,16
    80001fe0:	00008067          	ret

0000000080001fe4 <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001fe4:	00c00793          	li	a5,12
    80001fe8:	10f50063          	beq	a0,a5,800020e8 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80001fec:	fd010113          	addi	sp,sp,-48
    80001ff0:	02113423          	sd	ra,40(sp)
    80001ff4:	02813023          	sd	s0,32(sp)
    80001ff8:	00913c23          	sd	s1,24(sp)
    80001ffc:	01213823          	sd	s2,16(sp)
    80002000:	01313423          	sd	s3,8(sp)
    80002004:	03010413          	addi	s0,sp,48
    80002008:	00050913          	mv	s2,a0
    Block *curr = head[size];
    8000200c:	00351713          	slli	a4,a0,0x3
    80002010:	00006797          	auipc	a5,0x6
    80002014:	b9878793          	addi	a5,a5,-1128 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002018:	00e787b3          	add	a5,a5,a4
    8000201c:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002020:	00000993          	li	s3,0
    80002024:	0180006f          	j	8000203c <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002028:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    8000202c:	04f70463          	beq	a4,a5,80002074 <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002030:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    80002034:	08f70063          	beq	a4,a5,800020b4 <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002038:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    8000203c:	08048863          	beqz	s1,800020cc <_ZN5Buddy8compressEm+0xe8>
    80002040:	0004b683          	ld	a3,0(s1)
    80002044:	08068463          	beqz	a3,800020cc <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002048:	00006797          	auipc	a5,0x6
    8000204c:	b607b783          	ld	a5,-1184(a5) # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002050:	40f48733          	sub	a4,s1,a5
    80002054:	00c9061b          	addiw	a2,s2,12
    80002058:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    8000205c:	40f687b3          	sub	a5,a3,a5
    80002060:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002064:	00177613          	andi	a2,a4,1
    80002068:	fc0610e3          	bnez	a2,80002028 <_ZN5Buddy8compressEm+0x44>
    8000206c:	00170713          	addi	a4,a4,1
    80002070:	fbdff06f          	j	8000202c <_ZN5Buddy8compressEm+0x48>
            if(prev){
    80002074:	00098863          	beqz	s3,80002084 <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80002078:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffed000>
    8000207c:	00d9b023          	sd	a3,0(s3)
    80002080:	fb5ff06f          	j	80002034 <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    80002084:	0006b603          	ld	a2,0(a3)
    80002088:	00391593          	slli	a1,s2,0x3
    8000208c:	00006697          	auipc	a3,0x6
    80002090:	b1c68693          	addi	a3,a3,-1252 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002094:	00b686b3          	add	a3,a3,a1
    80002098:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    8000209c:	f8061ce3          	bnez	a2,80002034 <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    800020a0:	00006697          	auipc	a3,0x6
    800020a4:	b0868693          	addi	a3,a3,-1272 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800020a8:	00b686b3          	add	a3,a3,a1
    800020ac:	0006b823          	sd	zero,16(a3)
    800020b0:	f85ff06f          	j	80002034 <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800020b4:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    800020b8:	00190593          	addi	a1,s2,1
    800020bc:	00048513          	mv	a0,s1
    800020c0:	00000097          	auipc	ra,0x0
    800020c4:	02c080e7          	jalr	44(ra) # 800020ec <_ZN5Buddy6insertEPvm>
    800020c8:	f71ff06f          	j	80002038 <_ZN5Buddy8compressEm+0x54>
}
    800020cc:	02813083          	ld	ra,40(sp)
    800020d0:	02013403          	ld	s0,32(sp)
    800020d4:	01813483          	ld	s1,24(sp)
    800020d8:	01013903          	ld	s2,16(sp)
    800020dc:	00813983          	ld	s3,8(sp)
    800020e0:	03010113          	addi	sp,sp,48
    800020e4:	00008067          	ret
    800020e8:	00008067          	ret

00000000800020ec <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    800020ec:	00050693          	mv	a3,a0
    if(!head[size]){
    800020f0:	00359713          	slli	a4,a1,0x3
    800020f4:	00006797          	auipc	a5,0x6
    800020f8:	ab478793          	addi	a5,a5,-1356 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800020fc:	00e787b3          	add	a5,a5,a4
    80002100:	0787b783          	ld	a5,120(a5)
    80002104:	02078c63          	beqz	a5,8000213c <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002108:	ff010113          	addi	sp,sp,-16
    8000210c:	00113423          	sd	ra,8(sp)
    80002110:	00813023          	sd	s0,0(sp)
    80002114:	01010413          	addi	s0,sp,16
    80002118:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    8000211c:	00068713          	mv	a4,a3
    80002120:	04f6e063          	bltu	a3,a5,80002160 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    80002124:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002128:	06078863          	beqz	a5,80002198 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    8000212c:	04f76c63          	bltu	a4,a5,80002184 <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002130:	00078613          	mv	a2,a5
                    iter = iter->next;
    80002134:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002138:	ff1ff06f          	j	80002128 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    8000213c:	00006797          	auipc	a5,0x6
    80002140:	a6c78793          	addi	a5,a5,-1428 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002144:	00e78533          	add	a0,a5,a4
    80002148:	00d53823          	sd	a3,16(a0)
    8000214c:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002150:	0006b023          	sd	zero,0(a3)
    80002154:	07853783          	ld	a5,120(a0)
    80002158:	0007b023          	sd	zero,0(a5)
        return;
    8000215c:	00008067          	ret
            newHead->next = head[size];
    80002160:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    80002164:	00359713          	slli	a4,a1,0x3
    80002168:	00006797          	auipc	a5,0x6
    8000216c:	a4078793          	addi	a5,a5,-1472 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002170:	00e787b3          	add	a5,a5,a4
    80002174:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80002178:	00000097          	auipc	ra,0x0
    8000217c:	e6c080e7          	jalr	-404(ra) # 80001fe4 <_ZN5Buddy8compressEm>
            return;
    80002180:	0440006f          	j	800021c4 <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    80002184:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    80002188:	00d63023          	sd	a3,0(a2)
                    compress(size);
    8000218c:	00000097          	auipc	ra,0x0
    80002190:	e58080e7          	jalr	-424(ra) # 80001fe4 <_ZN5Buddy8compressEm>
                    return;
    80002194:	0300006f          	j	800021c4 <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    80002198:	00351713          	slli	a4,a0,0x3
    8000219c:	00006797          	auipc	a5,0x6
    800021a0:	a0c78793          	addi	a5,a5,-1524 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800021a4:	00e787b3          	add	a5,a5,a4
    800021a8:	0107b703          	ld	a4,16(a5)
    800021ac:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800021b0:	0107b703          	ld	a4,16(a5)
    800021b4:	00073703          	ld	a4,0(a4)
    800021b8:	00e7b823          	sd	a4,16(a5)
    compress(size);
    800021bc:	00000097          	auipc	ra,0x0
    800021c0:	e28080e7          	jalr	-472(ra) # 80001fe4 <_ZN5Buddy8compressEm>
}
    800021c4:	00813083          	ld	ra,8(sp)
    800021c8:	00013403          	ld	s0,0(sp)
    800021cc:	01010113          	addi	sp,sp,16
    800021d0:	00008067          	ret

00000000800021d4 <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800021d4:	02050663          	beqz	a0,80002200 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800021d8:	ff010113          	addi	sp,sp,-16
    800021dc:	00113423          	sd	ra,8(sp)
    800021e0:	00813023          	sd	s0,0(sp)
    800021e4:	01010413          	addi	s0,sp,16
    insert(addr,size);
    800021e8:	00000097          	auipc	ra,0x0
    800021ec:	f04080e7          	jalr	-252(ra) # 800020ec <_ZN5Buddy6insertEPvm>
}
    800021f0:	00813083          	ld	ra,8(sp)
    800021f4:	00013403          	ld	s0,0(sp)
    800021f8:	01010113          	addi	sp,sp,16
    800021fc:	00008067          	ret
    80002200:	00008067          	ret

0000000080002204 <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002204:	ff010113          	addi	sp,sp,-16
    80002208:	00813423          	sd	s0,8(sp)
    8000220c:	01010413          	addi	s0,sp,16
    80002210:	03c0006f          	j	8000224c <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002214:	00b5859b          	addiw	a1,a1,11
    80002218:	00100713          	li	a4,1
    8000221c:	00b715bb          	sllw	a1,a4,a1
    80002220:	00b505b3          	add	a1,a0,a1
    80002224:	00379693          	slli	a3,a5,0x3
    80002228:	00006717          	auipc	a4,0x6
    8000222c:	98070713          	addi	a4,a4,-1664 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002230:	00d70733          	add	a4,a4,a3
    80002234:	00b73823          	sd	a1,16(a4)
    80002238:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    8000223c:	0005b023          	sd	zero,0(a1)
    80002240:	07873703          	ld	a4,120(a4)
    80002244:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002248:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    8000224c:	fff5879b          	addiw	a5,a1,-1
    80002250:	04c7c863          	blt	a5,a2,800022a0 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    80002254:	00379693          	slli	a3,a5,0x3
    80002258:	00006717          	auipc	a4,0x6
    8000225c:	95070713          	addi	a4,a4,-1712 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002260:	00d70733          	add	a4,a4,a3
    80002264:	01073683          	ld	a3,16(a4)
    80002268:	fa0686e3          	beqz	a3,80002214 <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000226c:	00b5859b          	addiw	a1,a1,11
    80002270:	00100713          	li	a4,1
    80002274:	00b715bb          	sllw	a1,a4,a1
    80002278:	00b505b3          	add	a1,a0,a1
    8000227c:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002280:	00379693          	slli	a3,a5,0x3
    80002284:	00006717          	auipc	a4,0x6
    80002288:	92470713          	addi	a4,a4,-1756 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000228c:	00d70733          	add	a4,a4,a3
    80002290:	01073683          	ld	a3,16(a4)
    80002294:	0006b683          	ld	a3,0(a3)
    80002298:	00d73823          	sd	a3,16(a4)
    8000229c:	fadff06f          	j	80002248 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800022a0:	00813403          	ld	s0,8(sp)
    800022a4:	01010113          	addi	sp,sp,16
    800022a8:	00008067          	ret

00000000800022ac <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800022ac:	fe010113          	addi	sp,sp,-32
    800022b0:	00113c23          	sd	ra,24(sp)
    800022b4:	00813823          	sd	s0,16(sp)
    800022b8:	00913423          	sd	s1,8(sp)
    800022bc:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800022c0:	00c00793          	li	a5,12
    800022c4:	06a7ec63          	bltu	a5,a0,8000233c <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800022c8:	00050593          	mv	a1,a0
    800022cc:	00c00793          	li	a5,12
    800022d0:	06b7ea63          	bltu	a5,a1,80002344 <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800022d4:	00359713          	slli	a4,a1,0x3
    800022d8:	00006797          	auipc	a5,0x6
    800022dc:	8d078793          	addi	a5,a5,-1840 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022e0:	00e787b3          	add	a5,a5,a4
    800022e4:	0787b483          	ld	s1,120(a5)
    800022e8:	00049663          	bnez	s1,800022f4 <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800022ec:	00158593          	addi	a1,a1,1
    800022f0:	fddff06f          	j	800022cc <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    800022f4:	0004b703          	ld	a4,0(s1)
    800022f8:	00359693          	slli	a3,a1,0x3
    800022fc:	00006797          	auipc	a5,0x6
    80002300:	8ac78793          	addi	a5,a5,-1876 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002304:	00d787b3          	add	a5,a5,a3
    80002308:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    8000230c:	00070e63          	beqz	a4,80002328 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002310:	0005061b          	sext.w	a2,a0
    80002314:	0005859b          	sext.w	a1,a1
    80002318:	00048513          	mv	a0,s1
    8000231c:	00000097          	auipc	ra,0x0
    80002320:	ee8080e7          	jalr	-280(ra) # 80002204 <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    80002324:	0240006f          	j	80002348 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002328:	00006797          	auipc	a5,0x6
    8000232c:	88078793          	addi	a5,a5,-1920 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002330:	00d787b3          	add	a5,a5,a3
    80002334:	0007b823          	sd	zero,16(a5)
    80002338:	fd9ff06f          	j	80002310 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    8000233c:	00000493          	li	s1,0
    80002340:	0080006f          	j	80002348 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    80002344:	00000493          	li	s1,0
}
    80002348:	00048513          	mv	a0,s1
    8000234c:	01813083          	ld	ra,24(sp)
    80002350:	01013403          	ld	s0,16(sp)
    80002354:	00813483          	ld	s1,8(sp)
    80002358:	02010113          	addi	sp,sp,32
    8000235c:	00008067          	ret

0000000080002360 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002360:	fe010113          	addi	sp,sp,-32
    80002364:	00113c23          	sd	ra,24(sp)
    80002368:	00813823          	sd	s0,16(sp)
    8000236c:	00913423          	sd	s1,8(sp)
    80002370:	01213023          	sd	s2,0(sp)
    80002374:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002378:	00000913          	li	s2,0
    8000237c:	0180006f          	j	80002394 <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002380:	00005517          	auipc	a0,0x5
    80002384:	fd050513          	addi	a0,a0,-48 # 80007350 <CONSOLE_STATUS+0x340>
    80002388:	00002097          	auipc	ra,0x2
    8000238c:	664080e7          	jalr	1636(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80002390:	0019091b          	addiw	s2,s2,1
    80002394:	00c00793          	li	a5,12
    80002398:	0727c663          	blt	a5,s2,80002404 <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    8000239c:	00000613          	li	a2,0
    800023a0:	00a00593          	li	a1,10
    800023a4:	00090513          	mv	a0,s2
    800023a8:	00002097          	auipc	ra,0x2
    800023ac:	688080e7          	jalr	1672(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800023b0:	00005517          	auipc	a0,0x5
    800023b4:	ef850513          	addi	a0,a0,-264 # 800072a8 <CONSOLE_STATUS+0x298>
    800023b8:	00002097          	auipc	ra,0x2
    800023bc:	634080e7          	jalr	1588(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    800023c0:	00391713          	slli	a4,s2,0x3
    800023c4:	00005797          	auipc	a5,0x5
    800023c8:	7e478793          	addi	a5,a5,2020 # 80007ba8 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023cc:	00e787b3          	add	a5,a5,a4
    800023d0:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    800023d4:	fa0486e3          	beqz	s1,80002380 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    800023d8:	00000613          	li	a2,0
    800023dc:	01000593          	li	a1,16
    800023e0:	0004851b          	sext.w	a0,s1
    800023e4:	00002097          	auipc	ra,0x2
    800023e8:	64c080e7          	jalr	1612(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    800023ec:	00005517          	auipc	a0,0x5
    800023f0:	cfc50513          	addi	a0,a0,-772 # 800070e8 <CONSOLE_STATUS+0xd8>
    800023f4:	00002097          	auipc	ra,0x2
    800023f8:	5f8080e7          	jalr	1528(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    800023fc:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002400:	fd5ff06f          	j	800023d4 <_ZN5Buddy9printListEv+0x74>
    80002404:	01813083          	ld	ra,24(sp)
    80002408:	01013403          	ld	s0,16(sp)
    8000240c:	00813483          	ld	s1,8(sp)
    80002410:	00013903          	ld	s2,0(sp)
    80002414:	02010113          	addi	sp,sp,32
    80002418:	00008067          	ret

000000008000241c <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    8000241c:	ff010113          	addi	sp,sp,-16
    80002420:	00113423          	sd	ra,8(sp)
    80002424:	00813023          	sd	s0,0(sp)
    80002428:	01010413          	addi	s0,sp,16
    8000242c:	000105b7          	lui	a1,0x10
    80002430:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002434:	00100513          	li	a0,1
    80002438:	00000097          	auipc	ra,0x0
    8000243c:	a44080e7          	jalr	-1468(ra) # 80001e7c <_Z41__static_initialization_and_destruction_0ii>
    80002440:	00813083          	ld	ra,8(sp)
    80002444:	00013403          	ld	s0,0(sp)
    80002448:	01010113          	addi	sp,sp,16
    8000244c:	00008067          	ret

0000000080002450 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002450:	ff010113          	addi	sp,sp,-16
    80002454:	00813423          	sd	s0,8(sp)
    80002458:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    8000245c:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002460:	00053823          	sd	zero,16(a0)
}
    80002464:	00813403          	ld	s0,8(sp)
    80002468:	01010113          	addi	sp,sp,16
    8000246c:	00008067          	ret

0000000080002470 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002470:	ff010113          	addi	sp,sp,-16
    80002474:	00813423          	sd	s0,8(sp)
    80002478:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    8000247c:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002480:	00053823          	sd	zero,16(a0)
    80002484:	00813403          	ld	s0,8(sp)
    80002488:	01010113          	addi	sp,sp,16
    8000248c:	00008067          	ret

0000000080002490 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    80002490:	ff010113          	addi	sp,sp,-16
    80002494:	00113423          	sd	ra,8(sp)
    80002498:	00813023          	sd	s0,0(sp)
    8000249c:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    800024a0:	00000697          	auipc	a3,0x0
    800024a4:	fd068693          	addi	a3,a3,-48 # 80002470 <_ZN3SCB4dtorEPv>
    800024a8:	00000617          	auipc	a2,0x0
    800024ac:	fa860613          	addi	a2,a2,-88 # 80002450 <_ZN3SCB4ctorEPv>
    800024b0:	01800593          	li	a1,24
    800024b4:	00005517          	auipc	a0,0x5
    800024b8:	dfc50513          	addi	a0,a0,-516 # 800072b0 <CONSOLE_STATUS+0x2a0>
    800024bc:	00002097          	auipc	ra,0x2
    800024c0:	70c080e7          	jalr	1804(ra) # 80004bc8 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800024c4:	00005797          	auipc	a5,0x5
    800024c8:	7ca7b223          	sd	a0,1988(a5) # 80007c88 <_ZN3SCB8scbCacheE>
}
    800024cc:	00813083          	ld	ra,8(sp)
    800024d0:	00013403          	ld	s0,0(sp)
    800024d4:	01010113          	addi	sp,sp,16
    800024d8:	00008067          	ret

00000000800024dc <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    800024dc:	ff010113          	addi	sp,sp,-16
    800024e0:	00813423          	sd	s0,8(sp)
    800024e4:	01010413          	addi	s0,sp,16
    val = init;
    800024e8:	00b52023          	sw	a1,0(a0)
}
    800024ec:	00813403          	ld	s0,8(sp)
    800024f0:	01010113          	addi	sp,sp,16
    800024f4:	00008067          	ret

00000000800024f8 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    800024f8:	fe010113          	addi	sp,sp,-32
    800024fc:	00113c23          	sd	ra,24(sp)
    80002500:	00813823          	sd	s0,16(sp)
    80002504:	00913423          	sd	s1,8(sp)
    80002508:	01213023          	sd	s2,0(sp)
    8000250c:	02010413          	addi	s0,sp,32
    80002510:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    80002514:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002518:	02050063          	beqz	a0,80002538 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    8000251c:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002520:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    80002524:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002528:	00002097          	auipc	ra,0x2
    8000252c:	030080e7          	jalr	48(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002530:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    80002534:	fe5ff06f          	j	80002518 <_ZN3SCBD1Ev+0x20>
}
    80002538:	01813083          	ld	ra,24(sp)
    8000253c:	01013403          	ld	s0,16(sp)
    80002540:	00813483          	ld	s1,8(sp)
    80002544:	00013903          	ld	s2,0(sp)
    80002548:	02010113          	addi	sp,sp,32
    8000254c:	00008067          	ret

0000000080002550 <_ZN3SCB5blockEv>:
void SCB::block() {
    80002550:	ff010113          	addi	sp,sp,-16
    80002554:	00113423          	sd	ra,8(sp)
    80002558:	00813023          	sd	s0,0(sp)
    8000255c:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002560:	00853783          	ld	a5,8(a0)
    80002564:	04078063          	beqz	a5,800025a4 <_ZN3SCB5blockEv+0x54>
    80002568:	01053703          	ld	a4,16(a0)
    8000256c:	00005797          	auipc	a5,0x5
    80002570:	53c7b783          	ld	a5,1340(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002574:	0007b783          	ld	a5,0(a5)
    80002578:	04f73423          	sd	a5,72(a4)
    8000257c:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002580:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    80002584:	00300713          	li	a4,3
    80002588:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    8000258c:	00000097          	auipc	ra,0x0
    80002590:	314080e7          	jalr	788(ra) # 800028a0 <_ZN3TCB8dispatchEv>
}
    80002594:	00813083          	ld	ra,8(sp)
    80002598:	00013403          	ld	s0,0(sp)
    8000259c:	01010113          	addi	sp,sp,16
    800025a0:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800025a4:	00005797          	auipc	a5,0x5
    800025a8:	5047b783          	ld	a5,1284(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800025ac:	0007b783          	ld	a5,0(a5)
    800025b0:	00f53423          	sd	a5,8(a0)
    800025b4:	fc9ff06f          	j	8000257c <_ZN3SCB5blockEv+0x2c>

00000000800025b8 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    800025b8:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    800025bc:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    800025c0:	04853703          	ld	a4,72(a0)
    800025c4:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    800025c8:	04053423          	sd	zero,72(a0)
    if(tcb) {
    800025cc:	02050a63          	beqz	a0,80002600 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    800025d0:	ff010113          	addi	sp,sp,-16
    800025d4:	00113423          	sd	ra,8(sp)
    800025d8:	00813023          	sd	s0,0(sp)
    800025dc:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    800025e0:	00100793          	li	a5,1
    800025e4:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    800025e8:	00002097          	auipc	ra,0x2
    800025ec:	f70080e7          	jalr	-144(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
}
    800025f0:	00813083          	ld	ra,8(sp)
    800025f4:	00013403          	ld	s0,0(sp)
    800025f8:	01010113          	addi	sp,sp,16
    800025fc:	00008067          	ret
    80002600:	00008067          	ret

0000000080002604 <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    80002604:	00005797          	auipc	a5,0x5
    80002608:	4a47b783          	ld	a5,1188(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000260c:	0007b783          	ld	a5,0(a5)
    80002610:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    80002614:	00052783          	lw	a5,0(a0)
    80002618:	fff7879b          	addiw	a5,a5,-1
    8000261c:	00f52023          	sw	a5,0(a0)
    80002620:	02079713          	slli	a4,a5,0x20
    80002624:	00074463          	bltz	a4,8000262c <_ZN3SCB4waitEv+0x28>
    80002628:	00008067          	ret
void SCB::wait() {
    8000262c:	ff010113          	addi	sp,sp,-16
    80002630:	00113423          	sd	ra,8(sp)
    80002634:	00813023          	sd	s0,0(sp)
    80002638:	01010413          	addi	s0,sp,16
        block();
    8000263c:	00000097          	auipc	ra,0x0
    80002640:	f14080e7          	jalr	-236(ra) # 80002550 <_ZN3SCB5blockEv>
}
    80002644:	00813083          	ld	ra,8(sp)
    80002648:	00013403          	ld	s0,0(sp)
    8000264c:	01010113          	addi	sp,sp,16
    80002650:	00008067          	ret

0000000080002654 <_ZN3SCB6signalEv>:
    if(val++<0)
    80002654:	00052783          	lw	a5,0(a0)
    80002658:	0017871b          	addiw	a4,a5,1
    8000265c:	00e52023          	sw	a4,0(a0)
    80002660:	0007c463          	bltz	a5,80002668 <_ZN3SCB6signalEv+0x14>
    80002664:	00008067          	ret
void SCB::signal(){
    80002668:	ff010113          	addi	sp,sp,-16
    8000266c:	00113423          	sd	ra,8(sp)
    80002670:	00813023          	sd	s0,0(sp)
    80002674:	01010413          	addi	s0,sp,16
        deblock();
    80002678:	00000097          	auipc	ra,0x0
    8000267c:	f40080e7          	jalr	-192(ra) # 800025b8 <_ZN3SCB7deblockEv>
}
    80002680:	00813083          	ld	ra,8(sp)
    80002684:	00013403          	ld	s0,0(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret

0000000080002690 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00113423          	sd	ra,8(sp)
    80002698:	00813023          	sd	s0,0(sp)
    8000269c:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    800026a0:	00005517          	auipc	a0,0x5
    800026a4:	5e853503          	ld	a0,1512(a0) # 80007c88 <_ZN3SCB8scbCacheE>
    800026a8:	00002097          	auipc	ra,0x2
    800026ac:	548080e7          	jalr	1352(ra) # 80004bf0 <_Z16kmem_cache_allocP5Cache>
}
    800026b0:	00813083          	ld	ra,8(sp)
    800026b4:	00013403          	ld	s0,0(sp)
    800026b8:	01010113          	addi	sp,sp,16
    800026bc:	00008067          	ret

00000000800026c0 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    800026c0:	ff010113          	addi	sp,sp,-16
    800026c4:	00113423          	sd	ra,8(sp)
    800026c8:	00813023          	sd	s0,0(sp)
    800026cc:	01010413          	addi	s0,sp,16
    800026d0:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    800026d4:	00005517          	auipc	a0,0x5
    800026d8:	5b453503          	ld	a0,1460(a0) # 80007c88 <_ZN3SCB8scbCacheE>
    800026dc:	00002097          	auipc	ra,0x2
    800026e0:	53c080e7          	jalr	1340(ra) # 80004c18 <_Z15kmem_cache_freeP5CachePv>
}
    800026e4:	00813083          	ld	ra,8(sp)
    800026e8:	00013403          	ld	s0,0(sp)
    800026ec:	01010113          	addi	sp,sp,16
    800026f0:	00008067          	ret

00000000800026f4 <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    800026f4:	ff010113          	addi	sp,sp,-16
    800026f8:	00813423          	sd	s0,8(sp)
    800026fc:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002700:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    80002704:	05200513          	li	a0,82
    asm("ecall");
    80002708:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    8000270c:	00050513          	mv	a0,a0
}
    80002710:	0005051b          	sext.w	a0,a0
    80002714:	00813403          	ld	s0,8(sp)
    80002718:	01010113          	addi	sp,sp,16
    8000271c:	00008067          	ret

0000000080002720 <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/system.hpp"

int main() {
    80002720:	fe010113          	addi	sp,sp,-32
    80002724:	00113c23          	sd	ra,24(sp)
    80002728:	00813823          	sd	s0,16(sp)
    8000272c:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002730:	fe840513          	addi	a0,s0,-24
    80002734:	fffff097          	auipc	ra,0xfffff
    80002738:	6c8080e7          	jalr	1736(ra) # 80001dfc <_ZN6SystemC1Ev>

    return 0;
    8000273c:	00000513          	li	a0,0
    80002740:	01813083          	ld	ra,24(sp)
    80002744:	01013403          	ld	s0,16(sp)
    80002748:	02010113          	addi	sp,sp,32
    8000274c:	00008067          	ret

0000000080002750 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002750:	ff010113          	addi	sp,sp,-16
    80002754:	00813423          	sd	s0,8(sp)
    80002758:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    8000275c:	00100793          	li	a5,1
    80002760:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    80002764:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002768:	00052a23          	sw	zero,20(a0)
}
    8000276c:	00813403          	ld	s0,8(sp)
    80002770:	01010113          	addi	sp,sp,16
    80002774:	00008067          	ret

0000000080002778 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002778:	ff010113          	addi	sp,sp,-16
    8000277c:	00813423          	sd	s0,8(sp)
    80002780:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002784:	00100793          	li	a5,1
    80002788:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    8000278c:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002790:	00052a23          	sw	zero,20(a0)
    80002794:	00813403          	ld	s0,8(sp)
    80002798:	01010113          	addi	sp,sp,16
    8000279c:	00008067          	ret

00000000800027a0 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    800027a0:	ff010113          	addi	sp,sp,-16
    800027a4:	00113423          	sd	ra,8(sp)
    800027a8:	00813023          	sd	s0,0(sp)
    800027ac:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    800027b0:	00000097          	auipc	ra,0x0
    800027b4:	7a0080e7          	jalr	1952(ra) # 80002f50 <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    800027b8:	00005797          	auipc	a5,0x5
    800027bc:	4d87b783          	ld	a5,1240(a5) # 80007c90 <_ZN3TCB7runningE>
    800027c0:	0187b703          	ld	a4,24(a5)
    800027c4:	0207b503          	ld	a0,32(a5)
    800027c8:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    800027cc:	00001097          	auipc	ra,0x1
    800027d0:	6ac080e7          	jalr	1708(ra) # 80003e78 <_ZN5RiscV14threadExitUtilEv>
}
    800027d4:	00813083          	ld	ra,8(sp)
    800027d8:	00013403          	ld	s0,0(sp)
    800027dc:	01010113          	addi	sp,sp,16
    800027e0:	00008067          	ret

00000000800027e4 <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    800027e4:	ff010113          	addi	sp,sp,-16
    800027e8:	00813423          	sd	s0,8(sp)
    800027ec:	01010413          	addi	s0,sp,16
    800027f0:	04053823          	sd	zero,80(a0)
    800027f4:	04053c23          	sd	zero,88(a0)
    800027f8:	06053023          	sd	zero,96(a0)
    this->body = body;
    800027fc:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002800:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    80002804:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002808:	02058a63          	beqz	a1,8000283c <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    8000280c:	00068793          	mv	a5,a3
    80002810:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002814:	02058863          	beqz	a1,80002844 <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002818:	000017b7          	lui	a5,0x1
    8000281c:	00f686b3          	add	a3,a3,a5
    80002820:	00d53023          	sd	a3,0(a0)
    80002824:	00000797          	auipc	a5,0x0
    80002828:	f7c78793          	addi	a5,a5,-132 # 800027a0 <_ZN3TCB7wrapperEPv>
    8000282c:	00f53423          	sd	a5,8(a0)
}
    80002830:	00813403          	ld	s0,8(sp)
    80002834:	01010113          	addi	sp,sp,16
    80002838:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    8000283c:	00000793          	li	a5,0
    80002840:	fd1ff06f          	j	80002810 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    80002844:	00000693          	li	a3,0
    80002848:	fd9ff06f          	j	80002820 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

000000008000284c <_ZN3TCB4freeEv>:
void TCB::free(){
    8000284c:	ff010113          	addi	sp,sp,-16
    80002850:	00113423          	sd	ra,8(sp)
    80002854:	00813023          	sd	s0,0(sp)
    80002858:	01010413          	addi	s0,sp,16
    kfree(stack);
    8000285c:	02853503          	ld	a0,40(a0)
    80002860:	00002097          	auipc	ra,0x2
    80002864:	488080e7          	jalr	1160(ra) # 80004ce8 <_Z5kfreePKv>
}
    80002868:	00813083          	ld	ra,8(sp)
    8000286c:	00013403          	ld	s0,0(sp)
    80002870:	01010113          	addi	sp,sp,16
    80002874:	00008067          	ret

0000000080002878 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002878:	ff010113          	addi	sp,sp,-16
    8000287c:	00113423          	sd	ra,8(sp)
    80002880:	00813023          	sd	s0,0(sp)
    80002884:	01010413          	addi	s0,sp,16
    free();
    80002888:	00000097          	auipc	ra,0x0
    8000288c:	fc4080e7          	jalr	-60(ra) # 8000284c <_ZN3TCB4freeEv>
}
    80002890:	00813083          	ld	ra,8(sp)
    80002894:	00013403          	ld	s0,0(sp)
    80002898:	01010113          	addi	sp,sp,16
    8000289c:	00008067          	ret

00000000800028a0 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800028a0:	fe010113          	addi	sp,sp,-32
    800028a4:	00113c23          	sd	ra,24(sp)
    800028a8:	00813823          	sd	s0,16(sp)
    800028ac:	00913423          	sd	s1,8(sp)
    800028b0:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800028b4:	00005497          	auipc	s1,0x5
    800028b8:	3dc4b483          	ld	s1,988(s1) # 80007c90 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800028bc:	0104a703          	lw	a4,16(s1)
    800028c0:	00100793          	li	a5,1
    800028c4:	04e7f663          	bgeu	a5,a4,80002910 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800028c8:	00002097          	auipc	ra,0x2
    800028cc:	cd8080e7          	jalr	-808(ra) # 800045a0 <_ZN9Scheduler3getEv>
    800028d0:	00005797          	auipc	a5,0x5
    800028d4:	3ca7b023          	sd	a0,960(a5) # 80007c90 <_ZN3TCB7runningE>
    if(running) {
    800028d8:	02050263          	beqz	a0,800028fc <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800028dc:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800028e0:	00000097          	auipc	ra,0x0
    800028e4:	754080e7          	jalr	1876(ra) # 80003034 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    800028e8:	00005597          	auipc	a1,0x5
    800028ec:	3a85b583          	ld	a1,936(a1) # 80007c90 <_ZN3TCB7runningE>
    800028f0:	00048513          	mv	a0,s1
    800028f4:	fffff097          	auipc	ra,0xfffff
    800028f8:	82c080e7          	jalr	-2004(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    800028fc:	01813083          	ld	ra,24(sp)
    80002900:	01013403          	ld	s0,16(sp)
    80002904:	00813483          	ld	s1,8(sp)
    80002908:	02010113          	addi	sp,sp,32
    8000290c:	00008067          	ret
        Scheduler::put(old);
    80002910:	00048513          	mv	a0,s1
    80002914:	00002097          	auipc	ra,0x2
    80002918:	c44080e7          	jalr	-956(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
    8000291c:	fadff06f          	j	800028c8 <_ZN3TCB8dispatchEv+0x28>

0000000080002920 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002920:	ff010113          	addi	sp,sp,-16
    80002924:	00113423          	sd	ra,8(sp)
    80002928:	00813023          	sd	s0,0(sp)
    8000292c:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002930:	00005517          	auipc	a0,0x5
    80002934:	36853503          	ld	a0,872(a0) # 80007c98 <_ZN3TCB8tcbCacheE>
    80002938:	00002097          	auipc	ra,0x2
    8000293c:	2b8080e7          	jalr	696(ra) # 80004bf0 <_Z16kmem_cache_allocP5Cache>
}
    80002940:	00813083          	ld	ra,8(sp)
    80002944:	00013403          	ld	s0,0(sp)
    80002948:	01010113          	addi	sp,sp,16
    8000294c:	00008067          	ret

0000000080002950 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002950:	fe010113          	addi	sp,sp,-32
    80002954:	00113c23          	sd	ra,24(sp)
    80002958:	00813823          	sd	s0,16(sp)
    8000295c:	00913423          	sd	s1,8(sp)
    80002960:	01213023          	sd	s2,0(sp)
    80002964:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80002968:	00000697          	auipc	a3,0x0
    8000296c:	e1068693          	addi	a3,a3,-496 # 80002778 <_ZN3TCB4dtorEPv>
    80002970:	00000617          	auipc	a2,0x0
    80002974:	de060613          	addi	a2,a2,-544 # 80002750 <_ZN3TCB4ctorEPv>
    80002978:	07000593          	li	a1,112
    8000297c:	00005517          	auipc	a0,0x5
    80002980:	94450513          	addi	a0,a0,-1724 # 800072c0 <CONSOLE_STATUS+0x2b0>
    80002984:	00002097          	auipc	ra,0x2
    80002988:	244080e7          	jalr	580(ra) # 80004bc8 <_Z17kmem_cache_createPKcmPFvPvES3_>
    8000298c:	00005797          	auipc	a5,0x5
    80002990:	30a7b623          	sd	a0,780(a5) # 80007c98 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    80002994:	07000513          	li	a0,112
    80002998:	00000097          	auipc	ra,0x0
    8000299c:	f88080e7          	jalr	-120(ra) # 80002920 <_ZN3TCBnwEm>
    800029a0:	00050493          	mv	s1,a0
    800029a4:	00050e63          	beqz	a0,800029c0 <_ZN3TCB10initializeEv+0x70>
    800029a8:	00200713          	li	a4,2
    800029ac:	00000693          	li	a3,0
    800029b0:	00000613          	li	a2,0
    800029b4:	00000593          	li	a1,0
    800029b8:	00000097          	auipc	ra,0x0
    800029bc:	e2c080e7          	jalr	-468(ra) # 800027e4 <_ZN3TCBC1EPFvPvES0_Pmm>
    800029c0:	00005797          	auipc	a5,0x5
    800029c4:	2c97b823          	sd	s1,720(a5) # 80007c90 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    800029c8:	00100793          	li	a5,1
    800029cc:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    800029d0:	00001537          	lui	a0,0x1
    800029d4:	00002097          	auipc	ra,0x2
    800029d8:	2ec080e7          	jalr	748(ra) # 80004cc0 <_Z7kmallocm>
    800029dc:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    800029e0:	07000513          	li	a0,112
    800029e4:	00000097          	auipc	ra,0x0
    800029e8:	f3c080e7          	jalr	-196(ra) # 80002920 <_ZN3TCBnwEm>
    800029ec:	00050493          	mv	s1,a0
    800029f0:	02050063          	beqz	a0,80002a10 <_ZN3TCB10initializeEv+0xc0>
    800029f4:	00200713          	li	a4,2
    800029f8:	00090693          	mv	a3,s2
    800029fc:	00000613          	li	a2,0
    80002a00:	00005597          	auipc	a1,0x5
    80002a04:	0305b583          	ld	a1,48(a1) # 80007a30 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002a08:	00000097          	auipc	ra,0x0
    80002a0c:	ddc080e7          	jalr	-548(ra) # 800027e4 <_ZN3TCBC1EPFvPvES0_Pmm>
    80002a10:	00005797          	auipc	a5,0x5
    80002a14:	2897b823          	sd	s1,656(a5) # 80007ca0 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80002a18:	00100793          	li	a5,1
    80002a1c:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80002a20:	00048513          	mv	a0,s1
    80002a24:	00002097          	auipc	ra,0x2
    80002a28:	b34080e7          	jalr	-1228(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
}
    80002a2c:	01813083          	ld	ra,24(sp)
    80002a30:	01013403          	ld	s0,16(sp)
    80002a34:	00813483          	ld	s1,8(sp)
    80002a38:	00013903          	ld	s2,0(sp)
    80002a3c:	02010113          	addi	sp,sp,32
    80002a40:	00008067          	ret

0000000080002a44 <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80002a44:	ff010113          	addi	sp,sp,-16
    80002a48:	00113423          	sd	ra,8(sp)
    80002a4c:	00813023          	sd	s0,0(sp)
    80002a50:	01010413          	addi	s0,sp,16
    80002a54:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80002a58:	00005517          	auipc	a0,0x5
    80002a5c:	24053503          	ld	a0,576(a0) # 80007c98 <_ZN3TCB8tcbCacheE>
    80002a60:	00002097          	auipc	ra,0x2
    80002a64:	1b8080e7          	jalr	440(ra) # 80004c18 <_Z15kmem_cache_freeP5CachePv>
}
    80002a68:	00813083          	ld	ra,8(sp)
    80002a6c:	00013403          	ld	s0,0(sp)
    80002a70:	01010113          	addi	sp,sp,16
    80002a74:	00008067          	ret

0000000080002a78 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80002a78:	ff010113          	addi	sp,sp,-16
    80002a7c:	00813423          	sd	s0,8(sp)
    80002a80:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002a84:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002a88:	05100513          	li	a0,81
    asm("ecall");
    80002a8c:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002a90:	00050513          	mv	a0,a0
}
    80002a94:	0005051b          	sext.w	a0,a0
    80002a98:	00813403          	ld	s0,8(sp)
    80002a9c:	01010113          	addi	sp,sp,16
    80002aa0:	00008067          	ret

0000000080002aa4 <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002aa4:	ff010113          	addi	sp,sp,-16
    80002aa8:	00813423          	sd	s0,8(sp)
    80002aac:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002ab0:	00005797          	auipc	a5,0x5
    80002ab4:	f587b783          	ld	a5,-168(a5) # 80007a08 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002ab8:	0007b783          	ld	a5,0(a5)
    80002abc:	00c7d793          	srli	a5,a5,0xc
    80002ac0:	00278793          	addi	a5,a5,2
    80002ac4:	00c79793          	slli	a5,a5,0xc
    80002ac8:	01000737          	lui	a4,0x1000
    80002acc:	00e787b3          	add	a5,a5,a4
    80002ad0:	00005717          	auipc	a4,0x5
    80002ad4:	1f070713          	addi	a4,a4,496 # 80007cc0 <_ZN15MemoryAllocator11freeMemTailE>
    80002ad8:	00f73023          	sd	a5,0(a4)
    80002adc:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002ae0:	0007b823          	sd	zero,16(a5)
    80002ae4:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002ae8:	00073823          	sd	zero,16(a4)
    80002aec:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80002af0:	00005697          	auipc	a3,0x5
    80002af4:	fd06b683          	ld	a3,-48(a3) # 80007ac0 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002af8:	0006b683          	ld	a3,0(a3)
    80002afc:	40f686b3          	sub	a3,a3,a5
    80002b00:	fe868693          	addi	a3,a3,-24
    80002b04:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002b08:	00873783          	ld	a5,8(a4)
    80002b0c:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002b10:	00100793          	li	a5,1
    80002b14:	02f70023          	sb	a5,32(a4)
}
    80002b18:	00813403          	ld	s0,8(sp)
    80002b1c:	01010113          	addi	sp,sp,16
    80002b20:	00008067          	ret

0000000080002b24 <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002b24:	ff010113          	addi	sp,sp,-16
    80002b28:	00813423          	sd	s0,8(sp)
    80002b2c:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80002b30:	14050663          	beqz	a0,80002c7c <_ZN15MemoryAllocator7kmallocEm+0x158>
    80002b34:	00050793          	mv	a5,a0
    80002b38:	00005517          	auipc	a0,0x5
    80002b3c:	19053503          	ld	a0,400(a0) # 80007cc8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002b40:	0a050e63          	beqz	a0,80002bfc <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002b44:	00053703          	ld	a4,0(a0)
    80002b48:	12f76e63          	bltu	a4,a5,80002c84 <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002b4c:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002b50:	00000613          	li	a2,0
    80002b54:	00c0006f          	j	80002b60 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002b58:	00050613          	mv	a2,a0
    80002b5c:	01053503          	ld	a0,16(a0)
    80002b60:	00050863          	beqz	a0,80002b70 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002b64:	00053683          	ld	a3,0(a0)
    80002b68:	01878713          	addi	a4,a5,24
    80002b6c:	fee6e6e3          	bltu	a3,a4,80002b58 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002b70:	08050663          	beqz	a0,80002bfc <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80002b74:	00053683          	ld	a3,0(a0)
    80002b78:	01868713          	addi	a4,a3,24
    80002b7c:	00e50733          	add	a4,a0,a4
    80002b80:	00005597          	auipc	a1,0x5
    80002b84:	f405b583          	ld	a1,-192(a1) # 80007ac0 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80002b88:	0005b583          	ld	a1,0(a1)
    80002b8c:	00b76463          	bltu	a4,a1,80002b94 <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002b90:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002b94:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002b98:	05700593          	li	a1,87
    80002b9c:	08d5f063          	bgeu	a1,a3,80002c1c <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    80002ba0:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002ba4:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002ba8:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002bac:	01053583          	ld	a1,16(a0)
    80002bb0:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002bb4:	00853583          	ld	a1,8(a0)
    80002bb8:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80002bbc:	fe868693          	addi	a3,a3,-24
    80002bc0:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002bc4:	04060263          	beqz	a2,80002c08 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80002bc8:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80002bcc:	00005797          	auipc	a5,0x5
    80002bd0:	10c7b783          	ld	a5,268(a5) # 80007cd8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002bd4:	06078463          	beqz	a5,80002c3c <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002bd8:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80002bdc:	08070063          	beqz	a4,80002c5c <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80002be0:	00873783          	ld	a5,8(a4)
    80002be4:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002be8:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80002bec:	00873783          	ld	a5,8(a4)
    80002bf0:	06078063          	beqz	a5,80002c50 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80002bf4:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80002bf8:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80002bfc:	00813403          	ld	s0,8(sp)
    80002c00:	01010113          	addi	sp,sp,16
    80002c04:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80002c08:	00005697          	auipc	a3,0x5
    80002c0c:	0b868693          	addi	a3,a3,184 # 80007cc0 <_ZN15MemoryAllocator11freeMemTailE>
    80002c10:	00f6b023          	sd	a5,0(a3)
    80002c14:	00f6b423          	sd	a5,8(a3)
    80002c18:	fb5ff06f          	j	80002bcc <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    80002c1c:	00060863          	beqz	a2,80002c2c <_ZN15MemoryAllocator7kmallocEm+0x108>
    80002c20:	01053783          	ld	a5,16(a0)
    80002c24:	00f63823          	sd	a5,16(a2)
    80002c28:	fa5ff06f          	j	80002bcc <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    80002c2c:	01053783          	ld	a5,16(a0)
    80002c30:	00005697          	auipc	a3,0x5
    80002c34:	08f6bc23          	sd	a5,152(a3) # 80007cc8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002c38:	f95ff06f          	j	80002bcc <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80002c3c:	00005797          	auipc	a5,0x5
    80002c40:	08478793          	addi	a5,a5,132 # 80007cc0 <_ZN15MemoryAllocator11freeMemTailE>
    80002c44:	00a7b823          	sd	a0,16(a5)
    80002c48:	00a7bc23          	sd	a0,24(a5)
    80002c4c:	fadff06f          	j	80002bf8 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    80002c50:	00005797          	auipc	a5,0x5
    80002c54:	08a7b423          	sd	a0,136(a5) # 80007cd8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002c58:	fa1ff06f          	j	80002bf8 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    80002c5c:	00005797          	auipc	a5,0x5
    80002c60:	06478793          	addi	a5,a5,100 # 80007cc0 <_ZN15MemoryAllocator11freeMemTailE>
    80002c64:	0107b703          	ld	a4,16(a5)
    80002c68:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002c6c:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002c70:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002c74:	00a7b823          	sd	a0,16(a5)
    80002c78:	f81ff06f          	j	80002bf8 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    80002c7c:	00000513          	li	a0,0
    80002c80:	f7dff06f          	j	80002bfc <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002c84:	00000513          	li	a0,0
    80002c88:	f75ff06f          	j	80002bfc <_ZN15MemoryAllocator7kmallocEm+0xd8>

0000000080002c8c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002c8c:	ff010113          	addi	sp,sp,-16
    80002c90:	00813423          	sd	s0,8(sp)
    80002c94:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002c98:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002c9c:	00000713          	li	a4,0
    80002ca0:	00078a63          	beqz	a5,80002cb4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002ca4:	00a7f863          	bgeu	a5,a0,80002cb4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002ca8:	00078713          	mv	a4,a5
    80002cac:	0107b783          	ld	a5,16(a5)
    80002cb0:	ff1ff06f          	j	80002ca0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80002cb4:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002cb8:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002cbc:	00078463          	beqz	a5,80002cc4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002cc0:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80002cc4:	02070263          	beqz	a4,80002ce8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002cc8:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002ccc:	0005b703          	ld	a4,0(a1)
    80002cd0:	00005797          	auipc	a5,0x5
    80002cd4:	ff87b783          	ld	a5,-8(a5) # 80007cc8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002cd8:	00f70c63          	beq	a4,a5,80002cf0 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002cdc:	00813403          	ld	s0,8(sp)
    80002ce0:	01010113          	addi	sp,sp,16
    80002ce4:	00008067          	ret
        *head = blk;
    80002ce8:	00a5b023          	sd	a0,0(a1)
    80002cec:	fe1ff06f          	j	80002ccc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002cf0:	01053783          	ld	a5,16(a0)
    80002cf4:	00078a63          	beqz	a5,80002d08 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002cf8:	00053683          	ld	a3,0(a0)
    80002cfc:	00d50733          	add	a4,a0,a3
    80002d00:	01870713          	addi	a4,a4,24
    80002d04:	02f70e63          	beq	a4,a5,80002d40 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80002d08:	00853783          	ld	a5,8(a0)
    80002d0c:	fc0788e3          	beqz	a5,80002cdc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002d10:	0007b683          	ld	a3,0(a5)
    80002d14:	00d78733          	add	a4,a5,a3
    80002d18:	01870713          	addi	a4,a4,24
    80002d1c:	fca710e3          	bne	a4,a0,80002cdc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002d20:	00053703          	ld	a4,0(a0)
    80002d24:	00e68733          	add	a4,a3,a4
    80002d28:	01870713          	addi	a4,a4,24
    80002d2c:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002d30:	00853783          	ld	a5,8(a0)
    80002d34:	01053703          	ld	a4,16(a0)
    80002d38:	00e7b823          	sd	a4,16(a5)
}
    80002d3c:	fa1ff06f          	j	80002cdc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80002d40:	0007b703          	ld	a4,0(a5)
    80002d44:	00e68733          	add	a4,a3,a4
    80002d48:	01870713          	addi	a4,a4,24
    80002d4c:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80002d50:	0107b783          	ld	a5,16(a5)
    80002d54:	00f53823          	sd	a5,16(a0)
    80002d58:	fb1ff06f          	j	80002d08 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002d5c <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002d5c:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002d60:	00005697          	auipc	a3,0x5
    80002d64:	f786b683          	ld	a3,-136(a3) # 80007cd8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002d68:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002d6c:	00050a63          	beqz	a0,80002d80 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002d70:	fe870793          	addi	a5,a4,-24
    80002d74:	00a78663          	beq	a5,a0,80002d80 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002d78:	01053503          	ld	a0,16(a0)
    80002d7c:	ff1ff06f          	j	80002d6c <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002d80:	08050463          	beqz	a0,80002e08 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80002d84:	ff010113          	addi	sp,sp,-16
    80002d88:	00113423          	sd	ra,8(sp)
    80002d8c:	00813023          	sd	s0,0(sp)
    80002d90:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80002d94:	00005797          	auipc	a5,0x5
    80002d98:	f3c7b783          	ld	a5,-196(a5) # 80007cd0 <_ZN15MemoryAllocator12allocMemTailE>
    80002d9c:	04a78663          	beq	a5,a0,80002de8 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002da0:	04d50c63          	beq	a0,a3,80002df8 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002da4:	01053783          	ld	a5,16(a0)
    80002da8:	00078663          	beqz	a5,80002db4 <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002dac:	00853703          	ld	a4,8(a0)
    80002db0:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80002db4:	00853783          	ld	a5,8(a0)
    80002db8:	00078663          	beqz	a5,80002dc4 <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002dbc:	01053703          	ld	a4,16(a0)
    80002dc0:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80002dc4:	00005597          	auipc	a1,0x5
    80002dc8:	f0458593          	addi	a1,a1,-252 # 80007cc8 <_ZN15MemoryAllocator11freeMemHeadE>
    80002dcc:	00000097          	auipc	ra,0x0
    80002dd0:	ec0080e7          	jalr	-320(ra) # 80002c8c <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80002dd4:	00000513          	li	a0,0
}
    80002dd8:	00813083          	ld	ra,8(sp)
    80002ddc:	00013403          	ld	s0,0(sp)
    80002de0:	01010113          	addi	sp,sp,16
    80002de4:	00008067          	ret
            allocMemTail = blk->prev;
    80002de8:	00853783          	ld	a5,8(a0)
    80002dec:	00005717          	auipc	a4,0x5
    80002df0:	eef73223          	sd	a5,-284(a4) # 80007cd0 <_ZN15MemoryAllocator12allocMemTailE>
    80002df4:	fadff06f          	j	80002da0 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002df8:	01053783          	ld	a5,16(a0)
    80002dfc:	00005717          	auipc	a4,0x5
    80002e00:	ecf73e23          	sd	a5,-292(a4) # 80007cd8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002e04:	fa1ff06f          	j	80002da4 <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80002e08:	fff00513          	li	a0,-1
}
    80002e0c:	00008067          	ret

0000000080002e10 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002e10:	fe010113          	addi	sp,sp,-32
    80002e14:	00113c23          	sd	ra,24(sp)
    80002e18:	00813823          	sd	s0,16(sp)
    80002e1c:	00913423          	sd	s1,8(sp)
    80002e20:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002e24:	00005497          	auipc	s1,0x5
    80002e28:	eb44b483          	ld	s1,-332(s1) # 80007cd8 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002e2c:	00004517          	auipc	a0,0x4
    80002e30:	4a450513          	addi	a0,a0,1188 # 800072d0 <CONSOLE_STATUS+0x2c0>
    80002e34:	0000d097          	auipc	ra,0xd
    80002e38:	670080e7          	jalr	1648(ra) # 800104a4 <_Z11printStringPKc>
    while(iter!=nullptr){
    80002e3c:	04048663          	beqz	s1,80002e88 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002e40:	00000613          	li	a2,0
    80002e44:	00a00593          	li	a1,10
    80002e48:	0004851b          	sext.w	a0,s1
    80002e4c:	0000d097          	auipc	ra,0xd
    80002e50:	7f0080e7          	jalr	2032(ra) # 8001063c <_Z8printIntiii>
        putc(' ');
    80002e54:	02000513          	li	a0,32
    80002e58:	0000c097          	auipc	ra,0xc
    80002e5c:	4d4080e7          	jalr	1236(ra) # 8000f32c <_Z4putcc>
        printInt(iter->size);
    80002e60:	00000613          	li	a2,0
    80002e64:	00a00593          	li	a1,10
    80002e68:	0004a503          	lw	a0,0(s1)
    80002e6c:	0000d097          	auipc	ra,0xd
    80002e70:	7d0080e7          	jalr	2000(ra) # 8001063c <_Z8printIntiii>
        putc('\n');
    80002e74:	00a00513          	li	a0,10
    80002e78:	0000c097          	auipc	ra,0xc
    80002e7c:	4b4080e7          	jalr	1204(ra) # 8000f32c <_Z4putcc>
        iter=iter->next;
    80002e80:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002e84:	fb9ff06f          	j	80002e3c <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002e88:	00004517          	auipc	a0,0x4
    80002e8c:	46850513          	addi	a0,a0,1128 # 800072f0 <CONSOLE_STATUS+0x2e0>
    80002e90:	0000d097          	auipc	ra,0xd
    80002e94:	614080e7          	jalr	1556(ra) # 800104a4 <_Z11printStringPKc>
    iter = freeMemHead;
    80002e98:	00005497          	auipc	s1,0x5
    80002e9c:	e304b483          	ld	s1,-464(s1) # 80007cc8 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002ea0:	04048663          	beqz	s1,80002eec <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002ea4:	00000613          	li	a2,0
    80002ea8:	00a00593          	li	a1,10
    80002eac:	0004851b          	sext.w	a0,s1
    80002eb0:	0000d097          	auipc	ra,0xd
    80002eb4:	78c080e7          	jalr	1932(ra) # 8001063c <_Z8printIntiii>
        putc(' ');
    80002eb8:	02000513          	li	a0,32
    80002ebc:	0000c097          	auipc	ra,0xc
    80002ec0:	470080e7          	jalr	1136(ra) # 8000f32c <_Z4putcc>
        printInt(iter->size);
    80002ec4:	00000613          	li	a2,0
    80002ec8:	00a00593          	li	a1,10
    80002ecc:	0004a503          	lw	a0,0(s1)
    80002ed0:	0000d097          	auipc	ra,0xd
    80002ed4:	76c080e7          	jalr	1900(ra) # 8001063c <_Z8printIntiii>
        putc('\n');
    80002ed8:	00a00513          	li	a0,10
    80002edc:	0000c097          	auipc	ra,0xc
    80002ee0:	450080e7          	jalr	1104(ra) # 8000f32c <_Z4putcc>
        iter=iter->next;
    80002ee4:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002ee8:	fb9ff06f          	j	80002ea0 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002eec:	00004517          	auipc	a0,0x4
    80002ef0:	42450513          	addi	a0,a0,1060 # 80007310 <CONSOLE_STATUS+0x300>
    80002ef4:	0000d097          	auipc	ra,0xd
    80002ef8:	5b0080e7          	jalr	1456(ra) # 800104a4 <_Z11printStringPKc>
}
    80002efc:	01813083          	ld	ra,24(sp)
    80002f00:	01013403          	ld	s0,16(sp)
    80002f04:	00813483          	ld	s1,8(sp)
    80002f08:	02010113          	addi	sp,sp,32
    80002f0c:	00008067          	ret

0000000080002f10 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80002f10:	ff010113          	addi	sp,sp,-16
    80002f14:	00813423          	sd	s0,8(sp)
    80002f18:	01010413          	addi	s0,sp,16
    80002f1c:	00050813          	mv	a6,a0
    80002f20:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002f24:	00000793          	li	a5,0
    80002f28:	00c7fe63          	bgeu	a5,a2,80002f44 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80002f2c:	00f50733          	add	a4,a0,a5
    80002f30:	00f806b3          	add	a3,a6,a5
    80002f34:	0006c683          	lbu	a3,0(a3)
    80002f38:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80002f3c:	00178793          	addi	a5,a5,1
    80002f40:	fe9ff06f          	j	80002f28 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80002f44:	00813403          	ld	s0,8(sp)
    80002f48:	01010113          	addi	sp,sp,16
    80002f4c:	00008067          	ret

0000000080002f50 <_ZN5RiscV10popSppSpieEv>:
    RiscV::startVirtualMemory(RiscV::kPMT);
    RiscV::enableInterrupts();
}

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80002f50:	ff010113          	addi	sp,sp,-16
    80002f54:	00813423          	sd	s0,8(sp)
    80002f58:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80002f5c:	00005797          	auipc	a5,0x5
    80002f60:	b4c7b783          	ld	a5,-1204(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002f64:	0007b783          	ld	a5,0(a5)
    80002f68:	0147a683          	lw	a3,20(a5)
    80002f6c:	00100713          	li	a4,1
    80002f70:	02e68863          	beq	a3,a4,80002fa0 <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)bodyWrapper;
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    80002f74:	0187b703          	ld	a4,24(a5)
    80002f78:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    80002f7c:	0207b783          	ld	a5,32(a5)
    80002f80:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    80002f84:	00005797          	auipc	a5,0x5
    80002f88:	b1c7b783          	ld	a5,-1252(a5) # 80007aa0 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002f8c:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    80002f90:	10200073          	sret
}
    80002f94:	00813403          	ld	s0,8(sp)
    80002f98:	01010113          	addi	sp,sp,16
    80002f9c:	00008067          	ret
        asm("csrw sepc, ra");
    80002fa0:	14109073          	csrw	sepc,ra
    80002fa4:	fedff06f          	j	80002f90 <_ZN5RiscV10popSppSpieEv+0x40>

0000000080002fa8 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80002fa8:	ff010113          	addi	sp,sp,-16
    80002fac:	00113423          	sd	ra,8(sp)
    80002fb0:	00813023          	sd	s0,0(sp)
    80002fb4:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80002fb8:	00005797          	auipc	a5,0x5
    80002fbc:	af07b783          	ld	a5,-1296(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80002fc0:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80002fc4:	00100713          	li	a4,1
    80002fc8:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80002fcc:	00000097          	auipc	ra,0x0
    80002fd0:	8d4080e7          	jalr	-1836(ra) # 800028a0 <_ZN3TCB8dispatchEv>
}
    80002fd4:	00813083          	ld	ra,8(sp)
    80002fd8:	00013403          	ld	s0,0(sp)
    80002fdc:	01010113          	addi	sp,sp,16
    80002fe0:	00008067          	ret

0000000080002fe4 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80002fe4:	ff010113          	addi	sp,sp,-16
    80002fe8:	00113423          	sd	ra,8(sp)
    80002fec:	00813023          	sd	s0,0(sp)
    80002ff0:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80002ff4:	00005797          	auipc	a5,0x5
    80002ff8:	cf47c783          	lbu	a5,-780(a5) # 80007ce8 <_ZN5RiscV16userMainFinishedE>
    80002ffc:	00079c63          	bnez	a5,80003014 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    80003000:	00005717          	auipc	a4,0x5
    80003004:	a9873703          	ld	a4,-1384(a4) # 80007a98 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003008:	00073783          	ld	a5,0(a4)
    8000300c:	00178793          	addi	a5,a5,1
    80003010:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003014:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003018:	0ff57513          	andi	a0,a0,255
    8000301c:	00002097          	auipc	ra,0x2
    80003020:	8d8080e7          	jalr	-1832(ra) # 800048f4 <_ZN11ConsoleUtil9putOutputEc>
}
    80003024:	00813083          	ld	ra,8(sp)
    80003028:	00013403          	ld	s0,0(sp)
    8000302c:	01010113          	addi	sp,sp,16
    80003030:	00008067          	ret

0000000080003034 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    80003034:	ff010113          	addi	sp,sp,-16
    80003038:	00813423          	sd	s0,8(sp)
    8000303c:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    80003040:	00005797          	auipc	a5,0x5
    80003044:	a687b783          	ld	a5,-1432(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003048:	0007b783          	ld	a5,0(a5)
    8000304c:	0147a703          	lw	a4,20(a5)
    80003050:	00100793          	li	a5,1
    80003054:	02f70a63          	beq	a4,a5,80003088 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x54>
inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::mc_sstatus(uint64 mask) {
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    80003058:	10000793          	li	a5,256
    8000305c:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::kPMT);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
        RiscV::startVirtualMemory(RiscV::uPMT);
    80003060:	00005797          	auipc	a5,0x5
    80003064:	c987b783          	ld	a5,-872(a5) # 80007cf8 <_ZN5RiscV4uPMTE>
inline void RiscV::disableTimerInterrupts(){
    RiscV::mc_sie(SIP_SSIE);
}

inline void RiscV::startVirtualMemory(void* PMT) {
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80003068:	00c7d793          	srli	a5,a5,0xc
    8000306c:	fff00713          	li	a4,-1
    80003070:	03f71713          	slli	a4,a4,0x3f
    80003074:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    80003078:	18079073          	csrw	satp,a5
    }
}
    8000307c:	00813403          	ld	s0,8(sp)
    80003080:	01010113          	addi	sp,sp,16
    80003084:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003088:	10000793          	li	a5,256
    8000308c:	1007a073          	csrs	sstatus,a5
        RiscV::startVirtualMemory(RiscV::kPMT);
    80003090:	00005797          	auipc	a5,0x5
    80003094:	c607b783          	ld	a5,-928(a5) # 80007cf0 <_ZN5RiscV4kPMTE>
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    80003098:	00c7d793          	srli	a5,a5,0xc
    8000309c:	fff00713          	li	a4,-1
    800030a0:	03f71713          	slli	a4,a4,0x3f
    800030a4:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    800030a8:	18079073          	csrw	satp,a5
}
    800030ac:	fd1ff06f          	j	8000307c <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x48>

00000000800030b0 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    800030b0:	ff010113          	addi	sp,sp,-16
    800030b4:	00113423          	sd	ra,8(sp)
    800030b8:	00813023          	sd	s0,0(sp)
    800030bc:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    800030c0:	00100793          	li	a5,1
    800030c4:	00005717          	auipc	a4,0x5
    800030c8:	c2f70223          	sb	a5,-988(a4) # 80007ce8 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    800030cc:	00005797          	auipc	a5,0x5
    800030d0:	9cc7b783          	ld	a5,-1588(a5) # 80007a98 <_GLOBAL_OFFSET_TABLE_+0xa8>
    800030d4:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    800030d8:	00005797          	auipc	a5,0x5
    800030dc:	9707b783          	ld	a5,-1680(a5) # 80007a48 <_GLOBAL_OFFSET_TABLE_+0x58>
    800030e0:	0007b023          	sd	zero,0(a5)
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    800030e4:	00200793          	li	a5,2
    800030e8:	1047b073          	csrc	sie,a5
    800030ec:	20000793          	li	a5,512
    800030f0:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    800030f4:	00005797          	auipc	a5,0x5
    800030f8:	97c7b783          	ld	a5,-1668(a5) # 80007a70 <_GLOBAL_OFFSET_TABLE_+0x80>
    800030fc:	0007b783          	ld	a5,0(a5)
    80003100:	00078c63          	beqz	a5,80003118 <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003104:	0487b703          	ld	a4,72(a5)
    80003108:	00005797          	auipc	a5,0x5
    8000310c:	9687b783          	ld	a5,-1688(a5) # 80007a70 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003110:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003114:	fe1ff06f          	j	800030f4 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    80003118:	00005797          	auipc	a5,0x5
    8000311c:	9607b783          	ld	a5,-1696(a5) # 80007a78 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003120:	0007b503          	ld	a0,0(a5)
    80003124:	00001097          	auipc	ra,0x1
    80003128:	434080e7          	jalr	1076(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    8000312c:	00005797          	auipc	a5,0x5
    80003130:	95c7b783          	ld	a5,-1700(a5) # 80007a88 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003134:	0007b703          	ld	a4,0(a5)
    80003138:	00005797          	auipc	a5,0x5
    8000313c:	9587b783          	ld	a5,-1704(a5) # 80007a90 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80003140:	0007b783          	ld	a5,0(a5)
    80003144:	00f70863          	beq	a4,a5,80003154 <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    80003148:	fffff097          	auipc	ra,0xfffff
    8000314c:	758080e7          	jalr	1880(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003150:	fddff06f          	j	8000312c <_ZN5RiscV8finalizeEv+0x7c>
}
    80003154:	00813083          	ld	ra,8(sp)
    80003158:	00013403          	ld	s0,0(sp)
    8000315c:	01010113          	addi	sp,sp,16
    80003160:	00008067          	ret

0000000080003164 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003164:	ff010113          	addi	sp,sp,-16
    80003168:	00813423          	sd	s0,8(sp)
    8000316c:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    80003170:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    80003174:	00005717          	auipc	a4,0x5
    80003178:	93473703          	ld	a4,-1740(a4) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000317c:	00073703          	ld	a4,0(a4)
    80003180:	06873703          	ld	a4,104(a4)
    80003184:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    80003188:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    8000318c:	00078593          	mv	a1,a5
}
    80003190:	00813403          	ld	s0,8(sp)
    80003194:	01010113          	addi	sp,sp,16
    80003198:	00008067          	ret

000000008000319c <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    8000319c:	ff010113          	addi	sp,sp,-16
    800031a0:	00113423          	sd	ra,8(sp)
    800031a4:	00813023          	sd	s0,0(sp)
    800031a8:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800031ac:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	974080e7          	jalr	-1676(ra) # 80002b24 <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800031b8:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800031bc:	00000097          	auipc	ra,0x0
    800031c0:	fa8080e7          	jalr	-88(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800031c4:	00813083          	ld	ra,8(sp)
    800031c8:	00013403          	ld	s0,0(sp)
    800031cc:	01010113          	addi	sp,sp,16
    800031d0:	00008067          	ret

00000000800031d4 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    800031d4:	ff010113          	addi	sp,sp,-16
    800031d8:	00113423          	sd	ra,8(sp)
    800031dc:	00813023          	sd	s0,0(sp)
    800031e0:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    800031e4:	00005797          	auipc	a5,0x5
    800031e8:	8d47b783          	ld	a5,-1836(a5) # 80007ab8 <_GLOBAL_OFFSET_TABLE_+0xc8>
    800031ec:	0007c783          	lbu	a5,0(a5)
    800031f0:	02079263          	bnez	a5,80003214 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    800031f4:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800031f8:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800031fc:	00000097          	auipc	ra,0x0
    80003200:	f68080e7          	jalr	-152(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003204:	00813083          	ld	ra,8(sp)
    80003208:	00013403          	ld	s0,0(sp)
    8000320c:	01010113          	addi	sp,sp,16
    80003210:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003214:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    80003218:	00000097          	auipc	ra,0x0
    8000321c:	b44080e7          	jalr	-1212(ra) # 80002d5c <_ZN15MemoryAllocator5kfreeEPv>
    80003220:	fd9ff06f          	j	800031f8 <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003224 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003224:	fc010113          	addi	sp,sp,-64
    80003228:	02113c23          	sd	ra,56(sp)
    8000322c:	02813823          	sd	s0,48(sp)
    80003230:	02913423          	sd	s1,40(sp)
    80003234:	03213023          	sd	s2,32(sp)
    80003238:	01313c23          	sd	s3,24(sp)
    8000323c:	01413823          	sd	s4,16(sp)
    80003240:	01513423          	sd	s5,8(sp)
    80003244:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003248:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000324c:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003250:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003254:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003258:	07000513          	li	a0,112
    8000325c:	fffff097          	auipc	ra,0xfffff
    80003260:	6c4080e7          	jalr	1732(ra) # 80002920 <_ZN3TCBnwEm>
    80003264:	00050493          	mv	s1,a0
    80003268:	00050e63          	beqz	a0,80003284 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    8000326c:	00200713          	li	a4,2
    80003270:	000a8693          	mv	a3,s5
    80003274:	000a0613          	mv	a2,s4
    80003278:	00098593          	mv	a1,s3
    8000327c:	fffff097          	auipc	ra,0xfffff
    80003280:	568080e7          	jalr	1384(ra) # 800027e4 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003284:	04048863          	beqz	s1,800032d4 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    80003288:	0184b783          	ld	a5,24(s1)
    8000328c:	00078863          	beqz	a5,8000329c <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    80003290:	00048513          	mv	a0,s1
    80003294:	00001097          	auipc	ra,0x1
    80003298:	2c4080e7          	jalr	708(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    8000329c:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800032a0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800032a4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800032a8:	00000097          	auipc	ra,0x0
    800032ac:	ebc080e7          	jalr	-324(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800032b0:	03813083          	ld	ra,56(sp)
    800032b4:	03013403          	ld	s0,48(sp)
    800032b8:	02813483          	ld	s1,40(sp)
    800032bc:	02013903          	ld	s2,32(sp)
    800032c0:	01813983          	ld	s3,24(sp)
    800032c4:	01013a03          	ld	s4,16(sp)
    800032c8:	00813a83          	ld	s5,8(sp)
    800032cc:	04010113          	addi	sp,sp,64
    800032d0:	00008067          	ret
        status = -1;
    800032d4:	fff00793          	li	a5,-1
    800032d8:	fcdff06f          	j	800032a4 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    800032dc:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800032e0:	00048513          	mv	a0,s1
    800032e4:	fffff097          	auipc	ra,0xfffff
    800032e8:	760080e7          	jalr	1888(ra) # 80002a44 <_ZN3TCBdlEPv>
    800032ec:	00090513          	mv	a0,s2
    800032f0:	0000a097          	auipc	ra,0xa
    800032f4:	b38080e7          	jalr	-1224(ra) # 8000ce28 <_Unwind_Resume>

00000000800032f8 <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    800032f8:	fc010113          	addi	sp,sp,-64
    800032fc:	02113c23          	sd	ra,56(sp)
    80003300:	02813823          	sd	s0,48(sp)
    80003304:	02913423          	sd	s1,40(sp)
    80003308:	03213023          	sd	s2,32(sp)
    8000330c:	01313c23          	sd	s3,24(sp)
    80003310:	01413823          	sd	s4,16(sp)
    80003314:	01513423          	sd	s5,8(sp)
    80003318:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000331c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003320:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003324:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003328:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000332c:	07000513          	li	a0,112
    80003330:	fffff097          	auipc	ra,0xfffff
    80003334:	5f0080e7          	jalr	1520(ra) # 80002920 <_ZN3TCBnwEm>
    80003338:	00050493          	mv	s1,a0
    8000333c:	00050e63          	beqz	a0,80003358 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80003340:	00200713          	li	a4,2
    80003344:	000a8693          	mv	a3,s5
    80003348:	00090613          	mv	a2,s2
    8000334c:	00098593          	mv	a1,s3
    80003350:	fffff097          	auipc	ra,0xfffff
    80003354:	494080e7          	jalr	1172(ra) # 800027e4 <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    80003358:	04048263          	beqz	s1,8000339c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    8000335c:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80003360:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80003364:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    80003368:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000336c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003370:	00000097          	auipc	ra,0x0
    80003374:	df4080e7          	jalr	-524(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003378:	03813083          	ld	ra,56(sp)
    8000337c:	03013403          	ld	s0,48(sp)
    80003380:	02813483          	ld	s1,40(sp)
    80003384:	02013903          	ld	s2,32(sp)
    80003388:	01813983          	ld	s3,24(sp)
    8000338c:	01013a03          	ld	s4,16(sp)
    80003390:	00813a83          	ld	s5,8(sp)
    80003394:	04010113          	addi	sp,sp,64
    80003398:	00008067          	ret
        status = -1;
    8000339c:	fff00793          	li	a5,-1
    800033a0:	fcdff06f          	j	8000336c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800033a4:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800033a8:	00048513          	mv	a0,s1
    800033ac:	fffff097          	auipc	ra,0xfffff
    800033b0:	698080e7          	jalr	1688(ra) # 80002a44 <_ZN3TCBdlEPv>
    800033b4:	00090513          	mv	a0,s2
    800033b8:	0000a097          	auipc	ra,0xa
    800033bc:	a70080e7          	jalr	-1424(ra) # 8000ce28 <_Unwind_Resume>

00000000800033c0 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800033c0:	ff010113          	addi	sp,sp,-16
    800033c4:	00113423          	sd	ra,8(sp)
    800033c8:	00813023          	sd	s0,0(sp)
    800033cc:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800033d0:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    800033d4:	02051263          	bnez	a0,800033f8 <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    800033d8:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800033dc:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800033e0:	00000097          	auipc	ra,0x0
    800033e4:	d84080e7          	jalr	-636(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800033e8:	00813083          	ld	ra,8(sp)
    800033ec:	00013403          	ld	s0,0(sp)
    800033f0:	01010113          	addi	sp,sp,16
    800033f4:	00008067          	ret
        tcb->status = TCB::Status::READY;
    800033f8:	00100793          	li	a5,1
    800033fc:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003400:	00001097          	auipc	ra,0x1
    80003404:	158080e7          	jalr	344(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    80003408:	fffff097          	auipc	ra,0xfffff
    8000340c:	498080e7          	jalr	1176(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003410:	00000793          	li	a5,0
    80003414:	fc9ff06f          	j	800033dc <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

0000000080003418 <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    80003418:	ff010113          	addi	sp,sp,-16
    8000341c:	00113423          	sd	ra,8(sp)
    80003420:	00813023          	sd	s0,0(sp)
    80003424:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    80003428:	00004797          	auipc	a5,0x4
    8000342c:	6807b783          	ld	a5,1664(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003430:	0007b783          	ld	a5,0(a5)
    80003434:	02078a63          	beqz	a5,80003468 <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    80003438:	00200713          	li	a4,2
    8000343c:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003440:	fffff097          	auipc	ra,0xfffff
    80003444:	460080e7          	jalr	1120(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003448:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000344c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003450:	00000097          	auipc	ra,0x0
    80003454:	d14080e7          	jalr	-748(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003458:	00813083          	ld	ra,8(sp)
    8000345c:	00013403          	ld	s0,0(sp)
    80003460:	01010113          	addi	sp,sp,16
    80003464:	00008067          	ret
        status = -1;
    80003468:	fff00793          	li	a5,-1
    8000346c:	fe1ff06f          	j	8000344c <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

0000000080003470 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    80003470:	fd010113          	addi	sp,sp,-48
    80003474:	02113423          	sd	ra,40(sp)
    80003478:	02813023          	sd	s0,32(sp)
    8000347c:	00913c23          	sd	s1,24(sp)
    80003480:	01213823          	sd	s2,16(sp)
    80003484:	01313423          	sd	s3,8(sp)
    80003488:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000348c:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    80003490:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    80003494:	01800513          	li	a0,24
    80003498:	fffff097          	auipc	ra,0xfffff
    8000349c:	1f8080e7          	jalr	504(ra) # 80002690 <_ZN3SCBnwEm>
    800034a0:	00050493          	mv	s1,a0
    800034a4:	00050863          	beqz	a0,800034b4 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800034a8:	00098593          	mv	a1,s3
    800034ac:	fffff097          	auipc	ra,0xfffff
    800034b0:	030080e7          	jalr	48(ra) # 800024dc <_ZN3SCBC1Em>
    if(scb == nullptr){
    800034b4:	02048a63          	beqz	s1,800034e8 <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    800034b8:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800034bc:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800034c0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800034c4:	00000097          	auipc	ra,0x0
    800034c8:	ca0080e7          	jalr	-864(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800034cc:	02813083          	ld	ra,40(sp)
    800034d0:	02013403          	ld	s0,32(sp)
    800034d4:	01813483          	ld	s1,24(sp)
    800034d8:	01013903          	ld	s2,16(sp)
    800034dc:	00813983          	ld	s3,8(sp)
    800034e0:	03010113          	addi	sp,sp,48
    800034e4:	00008067          	ret
        status = -1;
    800034e8:	fff00793          	li	a5,-1
    800034ec:	fd5ff06f          	j	800034c0 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    800034f0:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    800034f4:	00048513          	mv	a0,s1
    800034f8:	fffff097          	auipc	ra,0xfffff
    800034fc:	1c8080e7          	jalr	456(ra) # 800026c0 <_ZN3SCBdlEPv>
    80003500:	00090513          	mv	a0,s2
    80003504:	0000a097          	auipc	ra,0xa
    80003508:	924080e7          	jalr	-1756(ra) # 8000ce28 <_Unwind_Resume>

000000008000350c <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    8000350c:	fe010113          	addi	sp,sp,-32
    80003510:	00113c23          	sd	ra,24(sp)
    80003514:	00813823          	sd	s0,16(sp)
    80003518:	00913423          	sd	s1,8(sp)
    8000351c:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003520:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003524:	02049463          	bnez	s1,8000354c <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    80003528:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000352c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003530:	00000097          	auipc	ra,0x0
    80003534:	c34080e7          	jalr	-972(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003538:	01813083          	ld	ra,24(sp)
    8000353c:	01013403          	ld	s0,16(sp)
    80003540:	00813483          	ld	s1,8(sp)
    80003544:	02010113          	addi	sp,sp,32
    80003548:	00008067          	ret
        delete (SCB*)ihandle;
    8000354c:	00048513          	mv	a0,s1
    80003550:	fffff097          	auipc	ra,0xfffff
    80003554:	fa8080e7          	jalr	-88(ra) # 800024f8 <_ZN3SCBD1Ev>
    80003558:	00048513          	mv	a0,s1
    8000355c:	fffff097          	auipc	ra,0xfffff
    80003560:	164080e7          	jalr	356(ra) # 800026c0 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003564:	00000793          	li	a5,0
    80003568:	fc5ff06f          	j	8000352c <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

000000008000356c <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    8000356c:	ff010113          	addi	sp,sp,-16
    80003570:	00113423          	sd	ra,8(sp)
    80003574:	00813023          	sd	s0,0(sp)
    80003578:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    8000357c:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003580:	02051c63          	bnez	a0,800035b8 <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    80003584:	00004797          	auipc	a5,0x4
    80003588:	5247b783          	ld	a5,1316(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000358c:	0007b783          	ld	a5,0(a5)
    80003590:	0607b783          	ld	a5,96(a5)
    80003594:	02078863          	beqz	a5,800035c4 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    80003598:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000359c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800035a0:	00000097          	auipc	ra,0x0
    800035a4:	bc4080e7          	jalr	-1084(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800035a8:	00813083          	ld	ra,8(sp)
    800035ac:	00013403          	ld	s0,0(sp)
    800035b0:	01010113          	addi	sp,sp,16
    800035b4:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800035b8:	fffff097          	auipc	ra,0xfffff
    800035bc:	04c080e7          	jalr	76(ra) # 80002604 <_ZN3SCB4waitEv>
    800035c0:	fc5ff06f          	j	80003584 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800035c4:	00000793          	li	a5,0
    800035c8:	fd5ff06f          	j	8000359c <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

00000000800035cc <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    800035cc:	ff010113          	addi	sp,sp,-16
    800035d0:	00113423          	sd	ra,8(sp)
    800035d4:	00813023          	sd	s0,0(sp)
    800035d8:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800035dc:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800035e0:	02051263          	bnez	a0,80003604 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    800035e4:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800035e8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800035ec:	00000097          	auipc	ra,0x0
    800035f0:	b78080e7          	jalr	-1160(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800035f4:	00813083          	ld	ra,8(sp)
    800035f8:	00013403          	ld	s0,0(sp)
    800035fc:	01010113          	addi	sp,sp,16
    80003600:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003604:	fffff097          	auipc	ra,0xfffff
    80003608:	050080e7          	jalr	80(ra) # 80002654 <_ZN3SCB6signalEv>
    uint64 status = 0;
    8000360c:	00000793          	li	a5,0
    80003610:	fd9ff06f          	j	800035e8 <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003614 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003614:	fe010113          	addi	sp,sp,-32
    80003618:	00113c23          	sd	ra,24(sp)
    8000361c:	00813823          	sd	s0,16(sp)
    80003620:	00913423          	sd	s1,8(sp)
    80003624:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003628:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    8000362c:	00004797          	auipc	a5,0x4
    80003630:	47c7b783          	ld	a5,1148(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003634:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003638:	00004797          	auipc	a5,0x4
    8000363c:	6c87b783          	ld	a5,1736(a5) # 80007d00 <_ZN5RiscV10globalTimeE>
    80003640:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003644:	00e787b3          	add	a5,a5,a4
    80003648:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    8000364c:	00048513          	mv	a0,s1
    80003650:	00001097          	auipc	ra,0x1
    80003654:	f84080e7          	jalr	-124(ra) # 800045d4 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003658:	00300793          	li	a5,3
    8000365c:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003660:	fffff097          	auipc	ra,0xfffff
    80003664:	240080e7          	jalr	576(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003668:	00000793          	li	a5,0
    8000366c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003670:	00000097          	auipc	ra,0x0
    80003674:	af4080e7          	jalr	-1292(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003678:	01813083          	ld	ra,24(sp)
    8000367c:	01013403          	ld	s0,16(sp)
    80003680:	00813483          	ld	s1,8(sp)
    80003684:	02010113          	addi	sp,sp,32
    80003688:	00008067          	ret

000000008000368c <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    8000368c:	fe010113          	addi	sp,sp,-32
    80003690:	00113c23          	sd	ra,24(sp)
    80003694:	00813823          	sd	s0,16(sp)
    80003698:	00913423          	sd	s1,8(sp)
    8000369c:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    800036a0:	00004797          	auipc	a5,0x4
    800036a4:	6487c783          	lbu	a5,1608(a5) # 80007ce8 <_ZN5RiscV16userMainFinishedE>
    800036a8:	00079c63          	bnez	a5,800036c0 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    800036ac:	00004717          	auipc	a4,0x4
    800036b0:	39c73703          	ld	a4,924(a4) # 80007a48 <_GLOBAL_OFFSET_TABLE_+0x58>
    800036b4:	00073783          	ld	a5,0(a4)
    800036b8:	00178793          	addi	a5,a5,1
    800036bc:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    800036c0:	00001097          	auipc	ra,0x1
    800036c4:	1bc080e7          	jalr	444(ra) # 8000487c <_ZN11ConsoleUtil8getInputEv>
    800036c8:	00050493          	mv	s1,a0
    if(c==13) {
    800036cc:	00d00793          	li	a5,13
    800036d0:	02f50663          	beq	a0,a5,800036fc <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    800036d4:	01b00793          	li	a5,27
    800036d8:	04f51063          	bne	a0,a5,80003718 <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    800036dc:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	a84080e7          	jalr	-1404(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800036e8:	01813083          	ld	ra,24(sp)
    800036ec:	01013403          	ld	s0,16(sp)
    800036f0:	00813483          	ld	s1,8(sp)
    800036f4:	02010113          	addi	sp,sp,32
    800036f8:	00008067          	ret
        ConsoleUtil::putOutput(13);
    800036fc:	00d00513          	li	a0,13
    80003700:	00001097          	auipc	ra,0x1
    80003704:	1f4080e7          	jalr	500(ra) # 800048f4 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003708:	00a00513          	li	a0,10
    8000370c:	00001097          	auipc	ra,0x1
    80003710:	1e8080e7          	jalr	488(ra) # 800048f4 <_ZN11ConsoleUtil9putOutputEc>
    80003714:	fc9ff06f          	j	800036dc <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003718:	00001097          	auipc	ra,0x1
    8000371c:	1dc080e7          	jalr	476(ra) # 800048f4 <_ZN11ConsoleUtil9putOutputEc>
    80003720:	fbdff06f          	j	800036dc <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003724 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003724:	ff010113          	addi	sp,sp,-16
    80003728:	00113423          	sd	ra,8(sp)
    8000372c:	00813023          	sd	s0,0(sp)
    80003730:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003734:	00001097          	auipc	ra,0x1
    80003738:	240080e7          	jalr	576(ra) # 80004974 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    8000373c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003740:	00000097          	auipc	ra,0x0
    80003744:	a24080e7          	jalr	-1500(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003748:	00813083          	ld	ra,8(sp)
    8000374c:	00013403          	ld	s0,0(sp)
    80003750:	01010113          	addi	sp,sp,16
    80003754:	00008067          	ret

0000000080003758 <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003758:	fe010113          	addi	sp,sp,-32
    8000375c:	00113c23          	sd	ra,24(sp)
    80003760:	00813823          	sd	s0,16(sp)
    80003764:	00913423          	sd	s1,8(sp)
    80003768:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    8000376c:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003770:	02049463          	bnez	s1,80003798 <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003774:	fff00793          	li	a5,-1
    80003778:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    8000377c:	00000097          	auipc	ra,0x0
    80003780:	9e8080e7          	jalr	-1560(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003784:	01813083          	ld	ra,24(sp)
    80003788:	01013403          	ld	s0,16(sp)
    8000378c:	00813483          	ld	s1,8(sp)
    80003790:	02010113          	addi	sp,sp,32
    80003794:	00008067          	ret
        kfree(thr->stack);
    80003798:	0284b503          	ld	a0,40(s1)
    8000379c:	00001097          	auipc	ra,0x1
    800037a0:	54c080e7          	jalr	1356(ra) # 80004ce8 <_Z5kfreePKv>
        delete thr;
    800037a4:	00048513          	mv	a0,s1
    800037a8:	fffff097          	auipc	ra,0xfffff
    800037ac:	0d0080e7          	jalr	208(ra) # 80002878 <_ZN3TCBD1Ev>
    800037b0:	00048513          	mv	a0,s1
    800037b4:	fffff097          	auipc	ra,0xfffff
    800037b8:	290080e7          	jalr	656(ra) # 80002a44 <_ZN3TCBdlEPv>
    800037bc:	fb9ff06f          	j	80003774 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

00000000800037c0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    800037c0:	fe010113          	addi	sp,sp,-32
    800037c4:	00113c23          	sd	ra,24(sp)
    800037c8:	00813823          	sd	s0,16(sp)
    800037cc:	00913423          	sd	s1,8(sp)
    800037d0:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    800037d4:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    800037d8:	02049463          	bnez	s1,80003800 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    800037dc:	fff00793          	li	a5,-1
    800037e0:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	980080e7          	jalr	-1664(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>
}
    800037ec:	01813083          	ld	ra,24(sp)
    800037f0:	01013403          	ld	s0,16(sp)
    800037f4:	00813483          	ld	s1,8(sp)
    800037f8:	02010113          	addi	sp,sp,32
    800037fc:	00008067          	ret
        delete scb;
    80003800:	00048513          	mv	a0,s1
    80003804:	fffff097          	auipc	ra,0xfffff
    80003808:	cf4080e7          	jalr	-780(ra) # 800024f8 <_ZN3SCBD1Ev>
    8000380c:	00048513          	mv	a0,s1
    80003810:	fffff097          	auipc	ra,0xfffff
    80003814:	eb0080e7          	jalr	-336(ra) # 800026c0 <_ZN3SCBdlEPv>
    80003818:	fc5ff06f          	j	800037dc <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

000000008000381c <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    8000381c:	fe010113          	addi	sp,sp,-32
    80003820:	00113c23          	sd	ra,24(sp)
    80003824:	00813823          	sd	s0,16(sp)
    80003828:	00913423          	sd	s1,8(sp)
    8000382c:	01213023          	sd	s2,0(sp)
    80003830:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003834:	00001537          	lui	a0,0x1
    80003838:	00001097          	auipc	ra,0x1
    8000383c:	488080e7          	jalr	1160(ra) # 80004cc0 <_Z7kmallocm>
    80003840:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003844:	00004797          	auipc	a5,0x4
    80003848:	2647b783          	ld	a5,612(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    8000384c:	0007b783          	ld	a5,0(a5)
    80003850:	00001637          	lui	a2,0x1
    80003854:	00050593          	mv	a1,a0
    80003858:	0287b503          	ld	a0,40(a5)
    8000385c:	fffff097          	auipc	ra,0xfffff
    80003860:	6b4080e7          	jalr	1716(ra) # 80002f10 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003864:	07000513          	li	a0,112
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	0b8080e7          	jalr	184(ra) # 80002920 <_ZN3TCBnwEm>
    80003870:	00050493          	mv	s1,a0
    80003874:	00050e63          	beqz	a0,80003890 <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003878:	00200713          	li	a4,2
    8000387c:	00090693          	mv	a3,s2
    80003880:	00000613          	li	a2,0
    80003884:	00000593          	li	a1,0
    80003888:	fffff097          	auipc	ra,0xfffff
    8000388c:	f5c080e7          	jalr	-164(ra) # 800027e4 <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003890:	0a048e63          	beqz	s1,8000394c <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003894:	00004797          	auipc	a5,0x4
    80003898:	1d47b783          	ld	a5,468(a5) # 80007a68 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000389c:	0007b783          	ld	a5,0(a5)
    800038a0:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    800038a4:	00004797          	auipc	a5,0x4
    800038a8:	1ac7b783          	ld	a5,428(a5) # 80007a50 <_GLOBAL_OFFSET_TABLE_+0x60>
    800038ac:	0007b783          	ld	a5,0(a5)
    800038b0:	00f907b3          	add	a5,s2,a5
    800038b4:	00004717          	auipc	a4,0x4
    800038b8:	1f473703          	ld	a4,500(a4) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800038bc:	00073683          	ld	a3,0(a4)
    800038c0:	0286b683          	ld	a3,40(a3)
    800038c4:	40d787b3          	sub	a5,a5,a3
    800038c8:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    800038cc:	00073783          	ld	a5,0(a4)
    800038d0:	0687b503          	ld	a0,104(a5)
    800038d4:	0287b783          	ld	a5,40(a5)
    800038d8:	40f50533          	sub	a0,a0,a5
    800038dc:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    800038e0:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    800038e4:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    800038e8:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    800038ec:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    800038f0:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    800038f4:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    800038f8:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    800038fc:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003900:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003904:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003908:	00073783          	ld	a5,0(a4)
    8000390c:	0387b703          	ld	a4,56(a5)
    80003910:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003914:	0407b783          	ld	a5,64(a5)
    80003918:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    8000391c:	00048513          	mv	a0,s1
    80003920:	00001097          	auipc	ra,0x1
    80003924:	c38080e7          	jalr	-968(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003928:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    8000392c:	00000097          	auipc	ra,0x0
    80003930:	838080e7          	jalr	-1992(ra) # 80003164 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003934:	01813083          	ld	ra,24(sp)
    80003938:	01013403          	ld	s0,16(sp)
    8000393c:	00813483          	ld	s1,8(sp)
    80003940:	00013903          	ld	s2,0(sp)
    80003944:	02010113          	addi	sp,sp,32
    80003948:	00008067          	ret
        status = -1;
    8000394c:	fff00493          	li	s1,-1
    80003950:	fd9ff06f          	j	80003928 <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80003954:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003958:	00048513          	mv	a0,s1
    8000395c:	fffff097          	auipc	ra,0xfffff
    80003960:	0e8080e7          	jalr	232(ra) # 80002a44 <_ZN3TCBdlEPv>
    80003964:	00090513          	mv	a0,s2
    80003968:	00009097          	auipc	ra,0x9
    8000396c:	4c0080e7          	jalr	1216(ra) # 8000ce28 <_Unwind_Resume>

0000000080003970 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003970:	ff010113          	addi	sp,sp,-16
    80003974:	00813423          	sd	s0,8(sp)
    80003978:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    8000397c:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003980:	00878793          	addi	a5,a5,8
    80003984:	00004717          	auipc	a4,0x4
    80003988:	0e473703          	ld	a4,228(a4) # 80007a68 <_GLOBAL_OFFSET_TABLE_+0x78>
    8000398c:	00f73023          	sd	a5,0(a4)
}
    80003990:	00813403          	ld	s0,8(sp)
    80003994:	01010113          	addi	sp,sp,16
    80003998:	00008067          	ret

000000008000399c <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    8000399c:	f9010113          	addi	sp,sp,-112
    800039a0:	06113423          	sd	ra,104(sp)
    800039a4:	06813023          	sd	s0,96(sp)
    800039a8:	04913c23          	sd	s1,88(sp)
    800039ac:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    800039b0:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    800039b4:	142027f3          	csrr	a5,scause
    800039b8:	fcf43423          	sd	a5,-56(s0)
    return scause;
    800039bc:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    800039c0:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    800039c4:	00004797          	auipc	a5,0x4
    800039c8:	0e47b783          	ld	a5,228(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    800039cc:	0007b783          	ld	a5,0(a5)
    800039d0:	14002773          	csrr	a4,sscratch
    800039d4:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    800039d8:	fd843703          	ld	a4,-40(s0)
    800039dc:	00900793          	li	a5,9
    800039e0:	10f70663          	beq	a4,a5,80003aec <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    800039e4:	fd843703          	ld	a4,-40(s0)
    800039e8:	00800793          	li	a5,8
    800039ec:	10f70063          	beq	a4,a5,80003aec <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    800039f0:	fd843703          	ld	a4,-40(s0)
    800039f4:	fff00793          	li	a5,-1
    800039f8:	03f79793          	slli	a5,a5,0x3f
    800039fc:	00178793          	addi	a5,a5,1
    80003a00:	26f70463          	beq	a4,a5,80003c68 <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003a04:	fd843703          	ld	a4,-40(s0)
    80003a08:	fff00793          	li	a5,-1
    80003a0c:	03f79793          	slli	a5,a5,0x3f
    80003a10:	00978793          	addi	a5,a5,9
    80003a14:	2ef70263          	beq	a4,a5,80003cf8 <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    80003a18:	fd843703          	ld	a4,-40(s0)
    80003a1c:	00200793          	li	a5,2
    80003a20:	36f70a63          	beq	a4,a5,80003d94 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    80003a24:	00004517          	auipc	a0,0x4
    80003a28:	96450513          	addi	a0,a0,-1692 # 80007388 <CONSOLE_STATUS+0x378>
    80003a2c:	00001097          	auipc	ra,0x1
    80003a30:	fc0080e7          	jalr	-64(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003a34:	00004517          	auipc	a0,0x4
    80003a38:	96450513          	addi	a0,a0,-1692 # 80007398 <CONSOLE_STATUS+0x388>
    80003a3c:	00001097          	auipc	ra,0x1
    80003a40:	fb0080e7          	jalr	-80(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003a44:	142027f3          	csrr	a5,scause
    80003a48:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003a4c:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003a50:	00000613          	li	a2,0
    80003a54:	00a00593          	li	a1,10
    80003a58:	0005051b          	sext.w	a0,a0
    80003a5c:	00001097          	auipc	ra,0x1
    80003a60:	fd4080e7          	jalr	-44(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003a64:	00004517          	auipc	a0,0x4
    80003a68:	8f450513          	addi	a0,a0,-1804 # 80007358 <CONSOLE_STATUS+0x348>
    80003a6c:	00001097          	auipc	ra,0x1
    80003a70:	f80080e7          	jalr	-128(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003a74:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003a78:	00000613          	li	a2,0
    80003a7c:	01000593          	li	a1,16
    80003a80:	0005051b          	sext.w	a0,a0
    80003a84:	00001097          	auipc	ra,0x1
    80003a88:	fac080e7          	jalr	-84(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003a8c:	00004517          	auipc	a0,0x4
    80003a90:	8c450513          	addi	a0,a0,-1852 # 80007350 <CONSOLE_STATUS+0x340>
    80003a94:	00001097          	auipc	ra,0x1
    80003a98:	f58080e7          	jalr	-168(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80003a9c:	01000693          	li	a3,16
    80003aa0:	00004617          	auipc	a2,0x4
    80003aa4:	8b060613          	addi	a2,a2,-1872 # 80007350 <CONSOLE_STATUS+0x340>
    80003aa8:	0004859b          	sext.w	a1,s1
    80003aac:	00004517          	auipc	a0,0x4
    80003ab0:	8fc50513          	addi	a0,a0,-1796 # 800073a8 <CONSOLE_STATUS+0x398>
    80003ab4:	00001097          	auipc	ra,0x1
    80003ab8:	058080e7          	jalr	88(ra) # 80004b0c <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003abc:	00004797          	auipc	a5,0x4
    80003ac0:	fec7b783          	ld	a5,-20(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003ac4:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003ac8:	00200713          	li	a4,2
    80003acc:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003ad0:	00004517          	auipc	a0,0x4
    80003ad4:	8e050513          	addi	a0,a0,-1824 # 800073b0 <CONSOLE_STATUS+0x3a0>
    80003ad8:	00001097          	auipc	ra,0x1
    80003adc:	f14080e7          	jalr	-236(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003ae0:	fffff097          	auipc	ra,0xfffff
    80003ae4:	dc0080e7          	jalr	-576(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    80003ae8:	0800006f          	j	80003b68 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003aec:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003af0:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003af4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003af8:	00478793          	addi	a5,a5,4
    80003afc:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80003b00:	00004797          	auipc	a5,0x4
    80003b04:	fa87b783          	ld	a5,-88(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003b08:	0007b783          	ld	a5,0(a5)
    80003b0c:	fa043703          	ld	a4,-96(s0)
    80003b10:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003b14:	f9843703          	ld	a4,-104(s0)
    80003b18:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003b1c:	00050793          	mv	a5,a0
        switch(syscallID){
    80003b20:	06100713          	li	a4,97
    80003b24:	02f76463          	bltu	a4,a5,80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    80003b28:	00279793          	slli	a5,a5,0x2
    80003b2c:	00004717          	auipc	a4,0x4
    80003b30:	89870713          	addi	a4,a4,-1896 # 800073c4 <CONSOLE_STATUS+0x3b4>
    80003b34:	00e787b3          	add	a5,a5,a4
    80003b38:	0007a783          	lw	a5,0(a5)
    80003b3c:	00e787b3          	add	a5,a5,a4
    80003b40:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003b44:	fffff097          	auipc	ra,0xfffff
    80003b48:	658080e7          	jalr	1624(ra) # 8000319c <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003b4c:	00004797          	auipc	a5,0x4
    80003b50:	f5c7b783          	ld	a5,-164(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003b54:	0007b783          	ld	a5,0(a5)
    80003b58:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003b5c:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003b60:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003b64:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003b68:	fffff097          	auipc	ra,0xfffff
    80003b6c:	4cc080e7          	jalr	1228(ra) # 80003034 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003b70:	06813083          	ld	ra,104(sp)
    80003b74:	06013403          	ld	s0,96(sp)
    80003b78:	05813483          	ld	s1,88(sp)
    80003b7c:	07010113          	addi	sp,sp,112
    80003b80:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003b84:	fffff097          	auipc	ra,0xfffff
    80003b88:	650080e7          	jalr	1616(ra) # 800031d4 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003b8c:	fc1ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    80003b90:	fffff097          	auipc	ra,0xfffff
    80003b94:	694080e7          	jalr	1684(ra) # 80003224 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003b98:	fb5ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80003b9c:	00000097          	auipc	ra,0x0
    80003ba0:	87c080e7          	jalr	-1924(ra) # 80003418 <_ZN5RiscV24executeThreadExitSyscallEv>
    80003ba4:	fa9ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003ba8:	fffff097          	auipc	ra,0xfffff
    80003bac:	400080e7          	jalr	1024(ra) # 80002fa8 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003bb0:	f9dff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003bb4:	fffff097          	auipc	ra,0xfffff
    80003bb8:	744080e7          	jalr	1860(ra) # 800032f8 <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003bbc:	f91ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80003bc0:	00000097          	auipc	ra,0x0
    80003bc4:	800080e7          	jalr	-2048(ra) # 800033c0 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003bc8:	f85ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80003bcc:	00000097          	auipc	ra,0x0
    80003bd0:	8a4080e7          	jalr	-1884(ra) # 80003470 <_ZN5RiscV21executeSemOpenSyscallEv>
    80003bd4:	f79ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    80003bd8:	00000097          	auipc	ra,0x0
    80003bdc:	934080e7          	jalr	-1740(ra) # 8000350c <_ZN5RiscV22executeSemCloseSyscallEv>
    80003be0:	f6dff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    80003be4:	00000097          	auipc	ra,0x0
    80003be8:	988080e7          	jalr	-1656(ra) # 8000356c <_ZN5RiscV21executeSemWaitSyscallEv>
    80003bec:	f61ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    80003bf0:	00000097          	auipc	ra,0x0
    80003bf4:	9dc080e7          	jalr	-1572(ra) # 800035cc <_ZN5RiscV23executeSemSignalSyscallEv>
    80003bf8:	f55ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    80003bfc:	00000097          	auipc	ra,0x0
    80003c00:	a18080e7          	jalr	-1512(ra) # 80003614 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80003c04:	f49ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    80003c08:	00000097          	auipc	ra,0x0
    80003c0c:	a84080e7          	jalr	-1404(ra) # 8000368c <_ZN5RiscV18executeGetcSyscallEv>
    80003c10:	f3dff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    80003c14:	fffff097          	auipc	ra,0xfffff
    80003c18:	3d0080e7          	jalr	976(ra) # 80002fe4 <_ZN5RiscV18executePutcSyscallEv>
    80003c1c:	f31ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    80003c20:	00000097          	auipc	ra,0x0
    80003c24:	b04080e7          	jalr	-1276(ra) # 80003724 <_ZN5RiscV22executePutcUtilSyscallEv>
    80003c28:	f25ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    80003c2c:	00000097          	auipc	ra,0x0
    80003c30:	b2c080e7          	jalr	-1236(ra) # 80003758 <_ZN5RiscV24executeThreadFreeSyscallEv>
    80003c34:	f19ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    80003c38:	00000097          	auipc	ra,0x0
    80003c3c:	b88080e7          	jalr	-1144(ra) # 800037c0 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80003c40:	f0dff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80003c44:	00010793          	mv	a5,sp
    80003c48:	00004717          	auipc	a4,0x4
    80003c4c:	e0873703          	ld	a4,-504(a4) # 80007a50 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003c50:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80003c54:	00000097          	auipc	ra,0x0
    80003c58:	d1c080e7          	jalr	-740(ra) # 80003970 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80003c5c:	00000097          	auipc	ra,0x0
    80003c60:	bc0080e7          	jalr	-1088(ra) # 8000381c <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80003c64:	ee9ff06f          	j	80003b4c <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003c68:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003c6c:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003c70:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003c74:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    80003c78:	00200793          	li	a5,2
    80003c7c:	1447b073          	csrc	sip,a5
        globalTime += 1;
    80003c80:	00004717          	auipc	a4,0x4
    80003c84:	06870713          	addi	a4,a4,104 # 80007ce8 <_ZN5RiscV16userMainFinishedE>
    80003c88:	01873783          	ld	a5,24(a4)
    80003c8c:	00178793          	addi	a5,a5,1
    80003c90:	00f73c23          	sd	a5,24(a4)
        Scheduler::awake();
    80003c94:	00001097          	auipc	ra,0x1
    80003c98:	998080e7          	jalr	-1640(ra) # 8000462c <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    80003c9c:	00004717          	auipc	a4,0x4
    80003ca0:	d7c73703          	ld	a4,-644(a4) # 80007a18 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003ca4:	00073783          	ld	a5,0(a4)
    80003ca8:	00178793          	addi	a5,a5,1
    80003cac:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    80003cb0:	00004717          	auipc	a4,0x4
    80003cb4:	df873703          	ld	a4,-520(a4) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003cb8:	00073703          	ld	a4,0(a4)
    80003cbc:	03073683          	ld	a3,48(a4)
    80003cc0:	00d7fc63          	bgeu	a5,a3,80003cd8 <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    80003cc4:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003cc8:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003ccc:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003cd0:	14179073          	csrw	sepc,a5
}
    80003cd4:	e95ff06f          	j	80003b68 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    80003cd8:	00004797          	auipc	a5,0x4
    80003cdc:	d407b783          	ld	a5,-704(a5) # 80007a18 <_GLOBAL_OFFSET_TABLE_+0x28>
    80003ce0:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80003ce4:	00100793          	li	a5,1
    80003ce8:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80003cec:	fffff097          	auipc	ra,0xfffff
    80003cf0:	bb4080e7          	jalr	-1100(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    80003cf4:	fd1ff06f          	j	80003cc4 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003cf8:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003cfc:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003d00:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80003d04:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    80003d08:	00004797          	auipc	a5,0x4
    80003d0c:	cf87b783          	ld	a5,-776(a5) # 80007a00 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003d10:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003d14:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003d18:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80003d1c:	00058793          	mv	a5,a1
        if(status & 1UL)
    80003d20:	0017f793          	andi	a5,a5,1
    80003d24:	02078863          	beqz	a5,80003d54 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    80003d28:	00004797          	auipc	a5,0x4
    80003d2c:	d187b783          	ld	a5,-744(a5) # 80007a40 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003d30:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80003d34:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    80003d38:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80003d3c:	00058513          	mv	a0,a1
    80003d40:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80003d44:	00004797          	auipc	a5,0x4
    80003d48:	d047b783          	ld	a5,-764(a5) # 80007a48 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003d4c:	0007b783          	ld	a5,0(a5)
    80003d50:	02079463          	bnez	a5,80003d78 <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80003d54:	00002097          	auipc	ra,0x2
    80003d58:	810080e7          	jalr	-2032(ra) # 80005564 <plic_claim>
    80003d5c:	00002097          	auipc	ra,0x2
    80003d60:	840080e7          	jalr	-1984(ra) # 8000559c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80003d64:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003d68:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80003d6c:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003d70:	14179073          	csrw	sepc,a5
}
    80003d74:	df5ff06f          	j	80003b68 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    80003d78:	fff78793          	addi	a5,a5,-1
    80003d7c:	00004717          	auipc	a4,0x4
    80003d80:	ccc73703          	ld	a4,-820(a4) # 80007a48 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003d84:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    80003d88:	00001097          	auipc	ra,0x1
    80003d8c:	a84080e7          	jalr	-1404(ra) # 8000480c <_ZN11ConsoleUtil8putInputEc>
    80003d90:	fc5ff06f          	j	80003d54 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    80003d94:	00004797          	auipc	a5,0x4
    80003d98:	d147b783          	ld	a5,-748(a5) # 80007aa8 <_GLOBAL_OFFSET_TABLE_+0xb8>
    80003d9c:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003da0:	00200713          	li	a4,2
    80003da4:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    80003da8:	00003517          	auipc	a0,0x3
    80003dac:	5b050513          	addi	a0,a0,1456 # 80007358 <CONSOLE_STATUS+0x348>
    80003db0:	00001097          	auipc	ra,0x1
    80003db4:	c3c080e7          	jalr	-964(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003db8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003dbc:	00000613          	li	a2,0
    80003dc0:	01000593          	li	a1,16
    80003dc4:	0005051b          	sext.w	a0,a0
    80003dc8:	00001097          	auipc	ra,0x1
    80003dcc:	c68080e7          	jalr	-920(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003dd0:	00003517          	auipc	a0,0x3
    80003dd4:	58050513          	addi	a0,a0,1408 # 80007350 <CONSOLE_STATUS+0x340>
    80003dd8:	00001097          	auipc	ra,0x1
    80003ddc:	c14080e7          	jalr	-1004(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80003de0:	00003517          	auipc	a0,0x3
    80003de4:	58050513          	addi	a0,a0,1408 # 80007360 <CONSOLE_STATUS+0x350>
    80003de8:	00001097          	auipc	ra,0x1
    80003dec:	c04080e7          	jalr	-1020(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003df0:	fffff097          	auipc	ra,0xfffff
    80003df4:	ab0080e7          	jalr	-1360(ra) # 800028a0 <_ZN3TCB8dispatchEv>
    80003df8:	d71ff06f          	j	80003b68 <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

0000000080003dfc <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    80003dfc:	fd010113          	addi	sp,sp,-48
    80003e00:	02113423          	sd	ra,40(sp)
    80003e04:	02813023          	sd	s0,32(sp)
    80003e08:	00913c23          	sd	s1,24(sp)
    80003e0c:	01213823          	sd	s2,16(sp)
    80003e10:	01313423          	sd	s3,8(sp)
    80003e14:	03010413          	addi	s0,sp,48
    80003e18:	00050913          	mv	s2,a0
    80003e1c:	00058493          	mv	s1,a1
    80003e20:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    80003e24:	00058e63          	beqz	a1,80003e40 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc(DEFAULT_STACK_SIZE);
    80003e28:	00001537          	lui	a0,0x1
    80003e2c:	fffff097          	auipc	ra,0xfffff
    80003e30:	cf8080e7          	jalr	-776(ra) # 80002b24 <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    80003e34:	00051863          	bnez	a0,80003e44 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    80003e38:	00093023          	sd	zero,0(s2)
            return;
    80003e3c:	0200006f          	j	80003e5c <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    80003e40:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80003e44:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    80003e48:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80003e4c:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80003e50:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80003e54:	01100513          	li	a0,17

    asm("ecall");
    80003e58:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80003e5c:	02813083          	ld	ra,40(sp)
    80003e60:	02013403          	ld	s0,32(sp)
    80003e64:	01813483          	ld	s1,24(sp)
    80003e68:	01013903          	ld	s2,16(sp)
    80003e6c:	00813983          	ld	s3,8(sp)
    80003e70:	03010113          	addi	sp,sp,48
    80003e74:	00008067          	ret

0000000080003e78 <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    80003e78:	ff010113          	addi	sp,sp,-16
    80003e7c:	00813423          	sd	s0,8(sp)
    80003e80:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    80003e84:	01200513          	li	a0,18

    asm("ecall");
    80003e88:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    80003e8c:	00813403          	ld	s0,8(sp)
    80003e90:	01010113          	addi	sp,sp,16
    80003e94:	00008067          	ret

0000000080003e98 <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    80003e98:	ff010113          	addi	sp,sp,-16
    80003e9c:	00813423          	sd	s0,8(sp)
    80003ea0:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    80003ea4:	01300513          	li	a0,19

    asm("ecall");
    80003ea8:	00000073          	ecall
}
    80003eac:	00813403          	ld	s0,8(sp)
    80003eb0:	01010113          	addi	sp,sp,16
    80003eb4:	00008067          	ret

0000000080003eb8 <_ZN5RiscV11putcWrapperEPv>:
{
    80003eb8:	fe010113          	addi	sp,sp,-32
    80003ebc:	00113c23          	sd	ra,24(sp)
    80003ec0:	00813823          	sd	s0,16(sp)
    80003ec4:	02010413          	addi	s0,sp,32
    80003ec8:	00c0006f          	j	80003ed4 <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80003ecc:	00000097          	auipc	ra,0x0
    80003ed0:	fcc080e7          	jalr	-52(ra) # 80003e98 <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    80003ed4:	00004797          	auipc	a5,0x4
    80003ed8:	b2c7b783          	ld	a5,-1236(a5) # 80007a00 <_GLOBAL_OFFSET_TABLE_+0x10>
    80003edc:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80003ee0:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80003ee4:	00050583          	lb	a1,0(a0) # 1000 <_entry-0x7ffff000>
        asm("mv %[status], a1" : [status] "=r" (status));
    80003ee8:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80003eec:	0207f793          	andi	a5,a5,32
    80003ef0:	fc078ee3          	beqz	a5,80003ecc <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80003ef4:	00001097          	auipc	ra,0x1
    80003ef8:	c84080e7          	jalr	-892(ra) # 80004b78 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80003efc:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80003f00:	00004797          	auipc	a5,0x4
    80003f04:	af87b783          	ld	a5,-1288(a5) # 800079f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80003f08:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80003f0c:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80003f10:	fef44783          	lbu	a5,-17(s0)
    80003f14:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    80003f18:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80003f1c:	00004797          	auipc	a5,0x4
    80003f20:	b7c7b783          	ld	a5,-1156(a5) # 80007a98 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003f24:	0007b783          	ld	a5,0(a5)
    80003f28:	fa0786e3          	beqz	a5,80003ed4 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80003f2c:	fff78793          	addi	a5,a5,-1
    80003f30:	00004717          	auipc	a4,0x4
    80003f34:	b6873703          	ld	a4,-1176(a4) # 80007a98 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003f38:	00f73023          	sd	a5,0(a4)
    80003f3c:	f99ff06f          	j	80003ed4 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080003f40 <_ZN5RiscV6getPMTEv>:

    RiscV::mapConsoleRegisters(uPMT);
    RiscV::ms_sstatus(1<<18);
}

void* RiscV::getPMT(){
    80003f40:	ff010113          	addi	sp,sp,-16
    80003f44:	00113423          	sd	ra,8(sp)
    80003f48:	00813023          	sd	s0,0(sp)
    80003f4c:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80003f50:	00100513          	li	a0,1
    80003f54:	ffffe097          	auipc	ra,0xffffe
    80003f58:	358080e7          	jalr	856(ra) # 800022ac <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80003f5c:	00000793          	li	a5,0
    80003f60:	1ff00713          	li	a4,511
    80003f64:	00f74c63          	blt	a4,a5,80003f7c <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80003f68:	00379713          	slli	a4,a5,0x3
    80003f6c:	00e50733          	add	a4,a0,a4
    80003f70:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80003f74:	0017879b          	addiw	a5,a5,1
    80003f78:	fe9ff06f          	j	80003f60 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80003f7c:	00813083          	ld	ra,8(sp)
    80003f80:	00013403          	ld	s0,0(sp)
    80003f84:	01010113          	addi	sp,sp,16
    80003f88:	00008067          	ret

0000000080003f8c <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80003f8c:	fc010113          	addi	sp,sp,-64
    80003f90:	02113c23          	sd	ra,56(sp)
    80003f94:	02813823          	sd	s0,48(sp)
    80003f98:	02913423          	sd	s1,40(sp)
    80003f9c:	03213023          	sd	s2,32(sp)
    80003fa0:	01313c23          	sd	s3,24(sp)
    80003fa4:	01413823          	sd	s4,16(sp)
    80003fa8:	01513423          	sd	s5,8(sp)
    80003fac:	04010413          	addi	s0,sp,64
    80003fb0:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    80003fb4:	01e5d793          	srli	a5,a1,0x1e
    80003fb8:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80003fbc:	0155d913          	srli	s2,a1,0x15
    80003fc0:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80003fc4:	00c5d493          	srli	s1,a1,0xc
    80003fc8:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80003fcc:	00379793          	slli	a5,a5,0x3
    80003fd0:	00f50ab3          	add	s5,a0,a5
    80003fd4:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003fd8:	06078263          	beqz	a5,8000403c <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003fdc:	00a7d513          	srli	a0,a5,0xa
    80003fe0:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    80003fe4:	00391913          	slli	s2,s2,0x3
    80003fe8:	01250933          	add	s2,a0,s2
    80003fec:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003ff0:	06050463          	beqz	a0,80004058 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    80003ff4:	00a55513          	srli	a0,a0,0xa
    80003ff8:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80003ffc:	003a1a13          	slli	s4,s4,0x3
    80004000:	01450533          	add	a0,a0,s4
    80004004:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0) {
    80004008:	00079863          	bnez	a5,80004018 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    8000400c:	00a49493          	slli	s1,s1,0xa
    80004010:	0134e9b3          	or	s3,s1,s3
    80004014:	01353023          	sd	s3,0(a0)
    }
}
    80004018:	03813083          	ld	ra,56(sp)
    8000401c:	03013403          	ld	s0,48(sp)
    80004020:	02813483          	ld	s1,40(sp)
    80004024:	02013903          	ld	s2,32(sp)
    80004028:	01813983          	ld	s3,24(sp)
    8000402c:	01013a03          	ld	s4,16(sp)
    80004030:	00813a83          	ld	s5,8(sp)
    80004034:	04010113          	addi	sp,sp,64
    80004038:	00008067          	ret
        pmt1 = RiscV::getPMT();
    8000403c:	00000097          	auipc	ra,0x0
    80004040:	f04080e7          	jalr	-252(ra) # 80003f40 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    80004044:	00c55793          	srli	a5,a0,0xc
    80004048:	00a79793          	slli	a5,a5,0xa
    8000404c:	0017e793          	ori	a5,a5,1
    80004050:	00fab023          	sd	a5,0(s5)
    80004054:	f91ff06f          	j	80003fe4 <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80004058:	00000097          	auipc	ra,0x0
    8000405c:	ee8080e7          	jalr	-280(ra) # 80003f40 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    80004060:	00c55793          	srli	a5,a0,0xc
    80004064:	00a79793          	slli	a5,a5,0xa
    80004068:	0017e793          	ori	a5,a5,1
    8000406c:	00f93023          	sd	a5,0(s2)
    80004070:	f8dff06f          	j	80003ffc <_ZN5RiscV15handlePageFaultEPvmm+0x70>

0000000080004074 <_ZN5RiscV12buildSectionEPvmmm>:
void RiscV::buildSection(void *PMT, uint64 start, uint64 end, uint64 mask) {
    80004074:	fd010113          	addi	sp,sp,-48
    80004078:	02113423          	sd	ra,40(sp)
    8000407c:	02813023          	sd	s0,32(sp)
    80004080:	00913c23          	sd	s1,24(sp)
    80004084:	01213823          	sd	s2,16(sp)
    80004088:	01313423          	sd	s3,8(sp)
    8000408c:	01413023          	sd	s4,0(sp)
    80004090:	03010413          	addi	s0,sp,48
    80004094:	00050a13          	mv	s4,a0
    80004098:	00058493          	mv	s1,a1
    8000409c:	00060913          	mv	s2,a2
    800040a0:	00068993          	mv	s3,a3
    for(uint64 i=start;i< end;i+=0x1000) {
    800040a4:	0324f263          	bgeu	s1,s2,800040c8 <_ZN5RiscV12buildSectionEPvmmm+0x54>
        handlePageFault(PMT,i, mask);
    800040a8:	00098613          	mv	a2,s3
    800040ac:	00048593          	mv	a1,s1
    800040b0:	000a0513          	mv	a0,s4
    800040b4:	00000097          	auipc	ra,0x0
    800040b8:	ed8080e7          	jalr	-296(ra) # 80003f8c <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=start;i< end;i+=0x1000) {
    800040bc:	000017b7          	lui	a5,0x1
    800040c0:	00f484b3          	add	s1,s1,a5
    800040c4:	fe1ff06f          	j	800040a4 <_ZN5RiscV12buildSectionEPvmmm+0x30>
}
    800040c8:	02813083          	ld	ra,40(sp)
    800040cc:	02013403          	ld	s0,32(sp)
    800040d0:	01813483          	ld	s1,24(sp)
    800040d4:	01013903          	ld	s2,16(sp)
    800040d8:	00813983          	ld	s3,8(sp)
    800040dc:	00013a03          	ld	s4,0(sp)
    800040e0:	03010113          	addi	sp,sp,48
    800040e4:	00008067          	ret

00000000800040e8 <_ZN5RiscV19mapConsoleRegistersEPv>:

void RiscV::mapConsoleRegisters(void *PMT) {
    800040e8:	fe010113          	addi	sp,sp,-32
    800040ec:	00113c23          	sd	ra,24(sp)
    800040f0:	00813823          	sd	s0,16(sp)
    800040f4:	00913423          	sd	s1,8(sp)
    800040f8:	02010413          	addi	s0,sp,32
    800040fc:	00050493          	mv	s1,a0
    handlePageFault(PMT, (uint64)CONSOLE_RX_DATA,0xf);
    80004100:	00f00613          	li	a2,15
    80004104:	00004797          	auipc	a5,0x4
    80004108:	8f47b783          	ld	a5,-1804(a5) # 800079f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000410c:	0007b583          	ld	a1,0(a5)
    80004110:	00000097          	auipc	ra,0x0
    80004114:	e7c080e7          	jalr	-388(ra) # 80003f8c <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_TX_DATA,0xf);
    80004118:	00f00613          	li	a2,15
    8000411c:	00004797          	auipc	a5,0x4
    80004120:	9247b783          	ld	a5,-1756(a5) # 80007a40 <_GLOBAL_OFFSET_TABLE_+0x50>
    80004124:	0007b583          	ld	a1,0(a5)
    80004128:	00048513          	mv	a0,s1
    8000412c:	00000097          	auipc	ra,0x0
    80004130:	e60080e7          	jalr	-416(ra) # 80003f8c <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)CONSOLE_STATUS,0xf);
    80004134:	00f00613          	li	a2,15
    80004138:	00004797          	auipc	a5,0x4
    8000413c:	8c87b783          	ld	a5,-1848(a5) # 80007a00 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004140:	0007b583          	ld	a1,0(a5)
    80004144:	00048513          	mv	a0,s1
    80004148:	00000097          	auipc	ra,0x0
    8000414c:	e44080e7          	jalr	-444(ra) # 80003f8c <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(PMT, (uint64)0xc201004,0xf);
    80004150:	00f00613          	li	a2,15
    80004154:	0c2015b7          	lui	a1,0xc201
    80004158:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    8000415c:	00048513          	mv	a0,s1
    80004160:	00000097          	auipc	ra,0x0
    80004164:	e2c080e7          	jalr	-468(ra) # 80003f8c <_ZN5RiscV15handlePageFaultEPvmm>
    80004168:	01813083          	ld	ra,24(sp)
    8000416c:	01013403          	ld	s0,16(sp)
    80004170:	00813483          	ld	s1,8(sp)
    80004174:	02010113          	addi	sp,sp,32
    80004178:	00008067          	ret

000000008000417c <_ZN5RiscV14buildKernelPMTEv>:
void RiscV::buildKernelPMT() {
    8000417c:	fd010113          	addi	sp,sp,-48
    80004180:	02113423          	sd	ra,40(sp)
    80004184:	02813023          	sd	s0,32(sp)
    80004188:	00913c23          	sd	s1,24(sp)
    8000418c:	01213823          	sd	s2,16(sp)
    80004190:	01313423          	sd	s3,8(sp)
    80004194:	01413023          	sd	s4,0(sp)
    80004198:	03010413          	addi	s0,sp,48
    RiscV::kPMT = RiscV::getPMT();
    8000419c:	00000097          	auipc	ra,0x0
    800041a0:	da4080e7          	jalr	-604(ra) # 80003f40 <_ZN5RiscV6getPMTEv>
    800041a4:	00004497          	auipc	s1,0x4
    800041a8:	b4448493          	addi	s1,s1,-1212 # 80007ce8 <_ZN5RiscV16userMainFinishedE>
    800041ac:	00a4b423          	sd	a0,8(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    800041b0:	00004797          	auipc	a5,0x4
    800041b4:	8787b783          	ld	a5,-1928(a5) # 80007a28 <_GLOBAL_OFFSET_TABLE_+0x38>
    800041b8:	0007b903          	ld	s2,0(a5)
    800041bc:	00c91913          	slli	s2,s2,0xc
    800041c0:	00004797          	auipc	a5,0x4
    800041c4:	8787b783          	ld	a5,-1928(a5) # 80007a38 <_GLOBAL_OFFSET_TABLE_+0x48>
    800041c8:	0007b783          	ld	a5,0(a5)
    800041cc:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(kPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    800041d0:	00004a17          	auipc	s4,0x4
    800041d4:	840a3a03          	ld	s4,-1984(s4) # 80007a10 <_GLOBAL_OFFSET_TABLE_+0x20>
    800041d8:	00b00693          	li	a3,11
    800041dc:	000a0613          	mv	a2,s4
    800041e0:	00100593          	li	a1,1
    800041e4:	01f59593          	slli	a1,a1,0x1f
    800041e8:	00000097          	auipc	ra,0x0
    800041ec:	e8c080e7          	jalr	-372(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    800041f0:	00004997          	auipc	s3,0x4
    800041f4:	8c09b983          	ld	s3,-1856(s3) # 80007ab0 <_GLOBAL_OFFSET_TABLE_+0xc0>
    800041f8:	00700693          	li	a3,7
    800041fc:	00098613          	mv	a2,s3
    80004200:	000a0593          	mv	a1,s4
    80004204:	0084b503          	ld	a0,8(s1)
    80004208:	00000097          	auipc	ra,0x0
    8000420c:	e6c080e7          	jalr	-404(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80004210:	00004a17          	auipc	s4,0x4
    80004214:	8c0a3a03          	ld	s4,-1856(s4) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004218:	01b00693          	li	a3,27
    8000421c:	000a0613          	mv	a2,s4
    80004220:	00098593          	mv	a1,s3
    80004224:	0084b503          	ld	a0,8(s1)
    80004228:	00000097          	auipc	ra,0x0
    8000422c:	e4c080e7          	jalr	-436(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80004230:	00003997          	auipc	s3,0x3
    80004234:	7f09b983          	ld	s3,2032(s3) # 80007a20 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004238:	01700693          	li	a3,23
    8000423c:	00098613          	mv	a2,s3
    80004240:	000a0593          	mv	a1,s4
    80004244:	0084b503          	ld	a0,8(s1)
    80004248:	00000097          	auipc	ra,0x0
    8000424c:	e2c080e7          	jalr	-468(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, USER_DATA_END, bEnd, 0x7);
    80004250:	00700693          	li	a3,7
    80004254:	00090613          	mv	a2,s2
    80004258:	00098593          	mv	a1,s3
    8000425c:	0084b503          	ld	a0,8(s1)
    80004260:	00000097          	auipc	ra,0x0
    80004264:	e14080e7          	jalr	-492(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(kPMT, bEnd, HEAP_END, 0x17);
    80004268:	01700693          	li	a3,23
    8000426c:	00004797          	auipc	a5,0x4
    80004270:	8547b783          	ld	a5,-1964(a5) # 80007ac0 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80004274:	0007b603          	ld	a2,0(a5)
    80004278:	00090593          	mv	a1,s2
    8000427c:	0084b503          	ld	a0,8(s1)
    80004280:	00000097          	auipc	ra,0x0
    80004284:	df4080e7          	jalr	-524(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(kPMT);
    80004288:	0084b503          	ld	a0,8(s1)
    8000428c:	00000097          	auipc	ra,0x0
    80004290:	e5c080e7          	jalr	-420(ra) # 800040e8 <_ZN5RiscV19mapConsoleRegistersEPv>
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80004294:	000407b7          	lui	a5,0x40
    80004298:	1007a073          	csrs	sstatus,a5
}
    8000429c:	02813083          	ld	ra,40(sp)
    800042a0:	02013403          	ld	s0,32(sp)
    800042a4:	01813483          	ld	s1,24(sp)
    800042a8:	01013903          	ld	s2,16(sp)
    800042ac:	00813983          	ld	s3,8(sp)
    800042b0:	00013a03          	ld	s4,0(sp)
    800042b4:	03010113          	addi	sp,sp,48
    800042b8:	00008067          	ret

00000000800042bc <_ZN5RiscV12buildUserPMTEv>:
void RiscV::buildUserPMT() {
    800042bc:	fd010113          	addi	sp,sp,-48
    800042c0:	02113423          	sd	ra,40(sp)
    800042c4:	02813023          	sd	s0,32(sp)
    800042c8:	00913c23          	sd	s1,24(sp)
    800042cc:	01213823          	sd	s2,16(sp)
    800042d0:	01313423          	sd	s3,8(sp)
    800042d4:	01413023          	sd	s4,0(sp)
    800042d8:	03010413          	addi	s0,sp,48
    RiscV::uPMT = RiscV::getPMT();
    800042dc:	00000097          	auipc	ra,0x0
    800042e0:	c64080e7          	jalr	-924(ra) # 80003f40 <_ZN5RiscV6getPMTEv>
    800042e4:	00004497          	auipc	s1,0x4
    800042e8:	a0448493          	addi	s1,s1,-1532 # 80007ce8 <_ZN5RiscV16userMainFinishedE>
    800042ec:	00a4b823          	sd	a0,16(s1)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    800042f0:	00003797          	auipc	a5,0x3
    800042f4:	7387b783          	ld	a5,1848(a5) # 80007a28 <_GLOBAL_OFFSET_TABLE_+0x38>
    800042f8:	0007b903          	ld	s2,0(a5)
    800042fc:	00c91913          	slli	s2,s2,0xc
    80004300:	00003797          	auipc	a5,0x3
    80004304:	7387b783          	ld	a5,1848(a5) # 80007a38 <_GLOBAL_OFFSET_TABLE_+0x48>
    80004308:	0007b783          	ld	a5,0(a5)
    8000430c:	00f90933          	add	s2,s2,a5
    RiscV::buildSection(uPMT, OS_ENTRY, KERNEL_TEXT_END, 0xb);
    80004310:	00003a17          	auipc	s4,0x3
    80004314:	700a3a03          	ld	s4,1792(s4) # 80007a10 <_GLOBAL_OFFSET_TABLE_+0x20>
    80004318:	00b00693          	li	a3,11
    8000431c:	000a0613          	mv	a2,s4
    80004320:	00100593          	li	a1,1
    80004324:	01f59593          	slli	a1,a1,0x1f
    80004328:	00000097          	auipc	ra,0x0
    8000432c:	d4c080e7          	jalr	-692(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, KERNEL_TEXT_END, USER_TEXT_START, 0x7);
    80004330:	00003997          	auipc	s3,0x3
    80004334:	7809b983          	ld	s3,1920(s3) # 80007ab0 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80004338:	00700693          	li	a3,7
    8000433c:	00098613          	mv	a2,s3
    80004340:	000a0593          	mv	a1,s4
    80004344:	0104b503          	ld	a0,16(s1)
    80004348:	00000097          	auipc	ra,0x0
    8000434c:	d2c080e7          	jalr	-724(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_TEXT_START, USER_DATA_START, 0x1b);
    80004350:	00003a17          	auipc	s4,0x3
    80004354:	780a3a03          	ld	s4,1920(s4) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0xe0>
    80004358:	01b00693          	li	a3,27
    8000435c:	000a0613          	mv	a2,s4
    80004360:	00098593          	mv	a1,s3
    80004364:	0104b503          	ld	a0,16(s1)
    80004368:	00000097          	auipc	ra,0x0
    8000436c:	d0c080e7          	jalr	-756(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_START, USER_DATA_END, 0x17);
    80004370:	00003997          	auipc	s3,0x3
    80004374:	6b09b983          	ld	s3,1712(s3) # 80007a20 <_GLOBAL_OFFSET_TABLE_+0x30>
    80004378:	01700693          	li	a3,23
    8000437c:	00098613          	mv	a2,s3
    80004380:	000a0593          	mv	a1,s4
    80004384:	0104b503          	ld	a0,16(s1)
    80004388:	00000097          	auipc	ra,0x0
    8000438c:	cec080e7          	jalr	-788(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, USER_DATA_END, bEnd, 0x7);
    80004390:	00700693          	li	a3,7
    80004394:	00090613          	mv	a2,s2
    80004398:	00098593          	mv	a1,s3
    8000439c:	0104b503          	ld	a0,16(s1)
    800043a0:	00000097          	auipc	ra,0x0
    800043a4:	cd4080e7          	jalr	-812(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::buildSection(uPMT, bEnd, HEAP_END, 0x17);
    800043a8:	01700693          	li	a3,23
    800043ac:	00003797          	auipc	a5,0x3
    800043b0:	7147b783          	ld	a5,1812(a5) # 80007ac0 <_GLOBAL_OFFSET_TABLE_+0xd0>
    800043b4:	0007b603          	ld	a2,0(a5)
    800043b8:	00090593          	mv	a1,s2
    800043bc:	0104b503          	ld	a0,16(s1)
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	cb4080e7          	jalr	-844(ra) # 80004074 <_ZN5RiscV12buildSectionEPvmmm>
    RiscV::mapConsoleRegisters(uPMT);
    800043c8:	0104b503          	ld	a0,16(s1)
    800043cc:	00000097          	auipc	ra,0x0
    800043d0:	d1c080e7          	jalr	-740(ra) # 800040e8 <_ZN5RiscV19mapConsoleRegistersEPv>
    800043d4:	000407b7          	lui	a5,0x40
    800043d8:	1007a073          	csrs	sstatus,a5
}
    800043dc:	02813083          	ld	ra,40(sp)
    800043e0:	02013403          	ld	s0,32(sp)
    800043e4:	01813483          	ld	s1,24(sp)
    800043e8:	01013903          	ld	s2,16(sp)
    800043ec:	00813983          	ld	s3,8(sp)
    800043f0:	00013a03          	ld	s4,0(sp)
    800043f4:	03010113          	addi	sp,sp,48
    800043f8:	00008067          	ret

00000000800043fc <_ZN5RiscV10initializeEv>:
void RiscV::initialize(){
    800043fc:	ff010113          	addi	sp,sp,-16
    80004400:	00113423          	sd	ra,8(sp)
    80004404:	00813023          	sd	s0,0(sp)
    80004408:	01010413          	addi	s0,sp,16
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    8000440c:	00003797          	auipc	a5,0x3
    80004410:	6747b783          	ld	a5,1652(a5) # 80007a80 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    80004414:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    80004418:	00003797          	auipc	a5,0x3
    8000441c:	5f07b783          	ld	a5,1520(a5) # 80007a08 <_GLOBAL_OFFSET_TABLE_+0x18>
    80004420:	0007b503          	ld	a0,0(a5)
    80004424:	00c55513          	srli	a0,a0,0xc
    80004428:	00250513          	addi	a0,a0,2
    8000442c:	000015b7          	lui	a1,0x1
    80004430:	00c51513          	slli	a0,a0,0xc
    80004434:	00000097          	auipc	ra,0x0
    80004438:	76c080e7          	jalr	1900(ra) # 80004ba0 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    8000443c:	ffffe097          	auipc	ra,0xffffe
    80004440:	668080e7          	jalr	1640(ra) # 80002aa4 <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80004444:	00000097          	auipc	ra,0x0
    80004448:	0fc080e7          	jalr	252(ra) # 80004540 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000444c:	ffffe097          	auipc	ra,0xffffe
    80004450:	504080e7          	jalr	1284(ra) # 80002950 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80004454:	ffffe097          	auipc	ra,0xffffe
    80004458:	03c080e7          	jalr	60(ra) # 80002490 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    8000445c:	00000097          	auipc	ra,0x0
    80004460:	2f8080e7          	jalr	760(ra) # 80004754 <_ZN11ConsoleUtil10initializeEv>
    RiscV::buildKernelPMT();
    80004464:	00000097          	auipc	ra,0x0
    80004468:	d18080e7          	jalr	-744(ra) # 8000417c <_ZN5RiscV14buildKernelPMTEv>
    RiscV::buildUserPMT();
    8000446c:	00000097          	auipc	ra,0x0
    80004470:	e50080e7          	jalr	-432(ra) # 800042bc <_ZN5RiscV12buildUserPMTEv>
    RiscV::startVirtualMemory(RiscV::kPMT);
    80004474:	00004797          	auipc	a5,0x4
    80004478:	87c7b783          	ld	a5,-1924(a5) # 80007cf0 <_ZN5RiscV4kPMTE>
    uint64 satp = ((uint64)1<<63) | ((uint64)(PMT)>>12);
    8000447c:	00c7d793          	srli	a5,a5,0xc
    80004480:	fff00713          	li	a4,-1
    80004484:	03f71713          	slli	a4,a4,0x3f
    80004488:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    8000448c:	18079073          	csrw	satp,a5
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80004490:	00200793          	li	a5,2
    80004494:	1047a073          	csrs	sie,a5
    80004498:	20000713          	li	a4,512
    8000449c:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800044a0:	1007a073          	csrs	sstatus,a5
}
    800044a4:	00813083          	ld	ra,8(sp)
    800044a8:	00013403          	ld	s0,0(sp)
    800044ac:	01010113          	addi	sp,sp,16
    800044b0:	00008067          	ret

00000000800044b4 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    800044b4:	ff010113          	addi	sp,sp,-16
    800044b8:	00813423          	sd	s0,8(sp)
    800044bc:	01010413          	addi	s0,sp,16
    800044c0:	00050793          	mv	a5,a0
    800044c4:	00058513          	mv	a0,a1
    while(*src != '\0')
    800044c8:	0007c703          	lbu	a4,0(a5)
    800044cc:	00070a63          	beqz	a4,800044e0 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    800044d0:	00178793          	addi	a5,a5,1
    800044d4:	00e50023          	sb	a4,0(a0)
    800044d8:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    800044dc:	fedff06f          	j	800044c8 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800044e0:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800044e4:	00813403          	ld	s0,8(sp)
    800044e8:	01010113          	addi	sp,sp,16
    800044ec:	00008067          	ret

00000000800044f0 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    800044f0:	fe010113          	addi	sp,sp,-32
    800044f4:	00113c23          	sd	ra,24(sp)
    800044f8:	00813823          	sd	s0,16(sp)
    800044fc:	00913423          	sd	s1,8(sp)
    80004500:	02010413          	addi	s0,sp,32
    80004504:	00050493          	mv	s1,a0
    80004508:	00058513          	mv	a0,a1
    char *dest = dst;
    8000450c:	00048593          	mv	a1,s1
    while(*dest != '\0')
    80004510:	0005c783          	lbu	a5,0(a1) # 1000 <_entry-0x7ffff000>
    80004514:	00078663          	beqz	a5,80004520 <_Z6strcatPcPKc+0x30>
        dest++;
    80004518:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    8000451c:	ff5ff06f          	j	80004510 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    80004520:	00000097          	auipc	ra,0x0
    80004524:	f94080e7          	jalr	-108(ra) # 800044b4 <_Z6strcpyPKcPc>
    return dst;
    80004528:	00048513          	mv	a0,s1
    8000452c:	01813083          	ld	ra,24(sp)
    80004530:	01013403          	ld	s0,16(sp)
    80004534:	00813483          	ld	s1,8(sp)
    80004538:	02010113          	addi	sp,sp,32
    8000453c:	00008067          	ret

0000000080004540 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004540:	ff010113          	addi	sp,sp,-16
    80004544:	00813423          	sd	s0,8(sp)
    80004548:	01010413          	addi	s0,sp,16
}
    8000454c:	00813403          	ld	s0,8(sp)
    80004550:	01010113          	addi	sp,sp,16
    80004554:	00008067          	ret

0000000080004558 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004558:	ff010113          	addi	sp,sp,-16
    8000455c:	00813423          	sd	s0,8(sp)
    80004560:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004564:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004568:	00003797          	auipc	a5,0x3
    8000456c:	7a07b783          	ld	a5,1952(a5) # 80007d08 <_ZN9Scheduler9readyHeadE>
    80004570:	02078263          	beqz	a5,80004594 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004574:	00003797          	auipc	a5,0x3
    80004578:	79c7b783          	ld	a5,1948(a5) # 80007d10 <_ZN9Scheduler9readyTailE>
    8000457c:	04a7b423          	sd	a0,72(a5)
    80004580:	00003797          	auipc	a5,0x3
    80004584:	78a7b823          	sd	a0,1936(a5) # 80007d10 <_ZN9Scheduler9readyTailE>
}
    80004588:	00813403          	ld	s0,8(sp)
    8000458c:	01010113          	addi	sp,sp,16
    80004590:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004594:	00003797          	auipc	a5,0x3
    80004598:	76a7ba23          	sd	a0,1908(a5) # 80007d08 <_ZN9Scheduler9readyHeadE>
    8000459c:	fe5ff06f          	j	80004580 <_ZN9Scheduler3putEP3TCB+0x28>

00000000800045a0 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    800045a0:	ff010113          	addi	sp,sp,-16
    800045a4:	00813423          	sd	s0,8(sp)
    800045a8:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    800045ac:	00003517          	auipc	a0,0x3
    800045b0:	75c53503          	ld	a0,1884(a0) # 80007d08 <_ZN9Scheduler9readyHeadE>
    800045b4:	00050a63          	beqz	a0,800045c8 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    800045b8:	04853783          	ld	a5,72(a0)
    800045bc:	00003717          	auipc	a4,0x3
    800045c0:	74f73623          	sd	a5,1868(a4) # 80007d08 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    800045c4:	04053423          	sd	zero,72(a0)
    return tmp;
}
    800045c8:	00813403          	ld	s0,8(sp)
    800045cc:	01010113          	addi	sp,sp,16
    800045d0:	00008067          	ret

00000000800045d4 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    800045d4:	ff010113          	addi	sp,sp,-16
    800045d8:	00813423          	sd	s0,8(sp)
    800045dc:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800045e0:	00003797          	auipc	a5,0x3
    800045e4:	7387b783          	ld	a5,1848(a5) # 80007d18 <_ZN9Scheduler12sleepingHeadE>
    800045e8:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800045ec:	00078e63          	beqz	a5,80004608 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800045f0:	0587b683          	ld	a3,88(a5)
    800045f4:	05853703          	ld	a4,88(a0)
    800045f8:	00d76863          	bltu	a4,a3,80004608 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800045fc:	00078613          	mv	a2,a5
    80004600:	0487b783          	ld	a5,72(a5)
    80004604:	fe9ff06f          	j	800045ec <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    80004608:	04f53423          	sd	a5,72(a0)
    if(prev)
    8000460c:	00060a63          	beqz	a2,80004620 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    80004610:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    80004614:	00813403          	ld	s0,8(sp)
    80004618:	01010113          	addi	sp,sp,16
    8000461c:	00008067          	ret
        sleepingHead = t;
    80004620:	00003797          	auipc	a5,0x3
    80004624:	6ea7bc23          	sd	a0,1784(a5) # 80007d18 <_ZN9Scheduler12sleepingHeadE>
}
    80004628:	fedff06f          	j	80004614 <_ZN9Scheduler5sleepEP3TCB+0x40>

000000008000462c <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    8000462c:	fe010113          	addi	sp,sp,-32
    80004630:	00113c23          	sd	ra,24(sp)
    80004634:	00813823          	sd	s0,16(sp)
    80004638:	00913423          	sd	s1,8(sp)
    8000463c:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004640:	00003497          	auipc	s1,0x3
    80004644:	6d84b483          	ld	s1,1752(s1) # 80007d18 <_ZN9Scheduler12sleepingHeadE>
    80004648:	02048c63          	beqz	s1,80004680 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    8000464c:	0584b703          	ld	a4,88(s1)
    80004650:	00003797          	auipc	a5,0x3
    80004654:	4787b783          	ld	a5,1144(a5) # 80007ac8 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80004658:	0007b783          	ld	a5,0(a5)
    8000465c:	02e7e263          	bltu	a5,a4,80004680 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004660:	0484b783          	ld	a5,72(s1)
    80004664:	00003717          	auipc	a4,0x3
    80004668:	6af73a23          	sd	a5,1716(a4) # 80007d18 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    8000466c:	00048513          	mv	a0,s1
    80004670:	00000097          	auipc	ra,0x0
    80004674:	ee8080e7          	jalr	-280(ra) # 80004558 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004678:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    8000467c:	fc5ff06f          	j	80004640 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004680:	01813083          	ld	ra,24(sp)
    80004684:	01013403          	ld	s0,16(sp)
    80004688:	00813483          	ld	s1,8(sp)
    8000468c:	02010113          	addi	sp,sp,32
    80004690:	00008067          	ret

0000000080004694 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004694:	fe010113          	addi	sp,sp,-32
    80004698:	00113c23          	sd	ra,24(sp)
    8000469c:	00813823          	sd	s0,16(sp)
    800046a0:	00913423          	sd	s1,8(sp)
    800046a4:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    800046a8:	00003497          	auipc	s1,0x3
    800046ac:	6604b483          	ld	s1,1632(s1) # 80007d08 <_ZN9Scheduler9readyHeadE>
    while(iter){
    800046b0:	02048863          	beqz	s1,800046e0 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    800046b4:	00000613          	li	a2,0
    800046b8:	01000593          	li	a1,16
    800046bc:	0004851b          	sext.w	a0,s1
    800046c0:	00000097          	auipc	ra,0x0
    800046c4:	370080e7          	jalr	880(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    800046c8:	00003517          	auipc	a0,0x3
    800046cc:	c8850513          	addi	a0,a0,-888 # 80007350 <CONSOLE_STATUS+0x340>
    800046d0:	00000097          	auipc	ra,0x0
    800046d4:	31c080e7          	jalr	796(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    800046d8:	0484b483          	ld	s1,72(s1)
    while(iter){
    800046dc:	fd5ff06f          	j	800046b0 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    800046e0:	01813083          	ld	ra,24(sp)
    800046e4:	01013403          	ld	s0,16(sp)
    800046e8:	00813483          	ld	s1,8(sp)
    800046ec:	02010113          	addi	sp,sp,32
    800046f0:	00008067          	ret

00000000800046f4 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800046f4:	fe010113          	addi	sp,sp,-32
    800046f8:	00113c23          	sd	ra,24(sp)
    800046fc:	00813823          	sd	s0,16(sp)
    80004700:	00913423          	sd	s1,8(sp)
    80004704:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    80004708:	00003497          	auipc	s1,0x3
    8000470c:	6104b483          	ld	s1,1552(s1) # 80007d18 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    80004710:	02048863          	beqz	s1,80004740 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    80004714:	00000613          	li	a2,0
    80004718:	01000593          	li	a1,16
    8000471c:	0004851b          	sext.w	a0,s1
    80004720:	0000c097          	auipc	ra,0xc
    80004724:	f1c080e7          	jalr	-228(ra) # 8001063c <_Z8printIntiii>
        printString("\n");
    80004728:	00003517          	auipc	a0,0x3
    8000472c:	c2850513          	addi	a0,a0,-984 # 80007350 <CONSOLE_STATUS+0x340>
    80004730:	0000c097          	auipc	ra,0xc
    80004734:	d74080e7          	jalr	-652(ra) # 800104a4 <_Z11printStringPKc>
        iter = iter->next;
    80004738:	0484b483          	ld	s1,72(s1)
    while(iter){
    8000473c:	fd5ff06f          	j	80004710 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004740:	01813083          	ld	ra,24(sp)
    80004744:	01013403          	ld	s0,16(sp)
    80004748:	00813483          	ld	s1,8(sp)
    8000474c:	02010113          	addi	sp,sp,32
    80004750:	00008067          	ret

0000000080004754 <_ZN11ConsoleUtil10initializeEv>:
char ConsoleUtil::inputBuffer[8192];
char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80004754:	fe010113          	addi	sp,sp,-32
    80004758:	00113c23          	sd	ra,24(sp)
    8000475c:	00813823          	sd	s0,16(sp)
    80004760:	00913423          	sd	s1,8(sp)
    80004764:	01213023          	sd	s2,0(sp)
    80004768:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    8000476c:	01800513          	li	a0,24
    80004770:	ffffe097          	auipc	ra,0xffffe
    80004774:	f20080e7          	jalr	-224(ra) # 80002690 <_ZN3SCBnwEm>
    80004778:	00050493          	mv	s1,a0
    8000477c:	00050863          	beqz	a0,8000478c <_ZN11ConsoleUtil10initializeEv+0x38>
    80004780:	00000593          	li	a1,0
    80004784:	ffffe097          	auipc	ra,0xffffe
    80004788:	d58080e7          	jalr	-680(ra) # 800024dc <_ZN3SCBC1Em>
    8000478c:	00003797          	auipc	a5,0x3
    80004790:	5897ba23          	sd	s1,1428(a5) # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004794:	01800513          	li	a0,24
    80004798:	ffffe097          	auipc	ra,0xffffe
    8000479c:	ef8080e7          	jalr	-264(ra) # 80002690 <_ZN3SCBnwEm>
    800047a0:	00050493          	mv	s1,a0
    800047a4:	00050863          	beqz	a0,800047b4 <_ZN11ConsoleUtil10initializeEv+0x60>
    800047a8:	00000593          	li	a1,0
    800047ac:	ffffe097          	auipc	ra,0xffffe
    800047b0:	d30080e7          	jalr	-720(ra) # 800024dc <_ZN3SCBC1Em>
    800047b4:	00003797          	auipc	a5,0x3
    800047b8:	5697ba23          	sd	s1,1396(a5) # 80007d28 <_ZN11ConsoleUtil9outputSemE>
//    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
//    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
}
    800047bc:	01813083          	ld	ra,24(sp)
    800047c0:	01013403          	ld	s0,16(sp)
    800047c4:	00813483          	ld	s1,8(sp)
    800047c8:	00013903          	ld	s2,0(sp)
    800047cc:	02010113          	addi	sp,sp,32
    800047d0:	00008067          	ret
    800047d4:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    800047d8:	00048513          	mv	a0,s1
    800047dc:	ffffe097          	auipc	ra,0xffffe
    800047e0:	ee4080e7          	jalr	-284(ra) # 800026c0 <_ZN3SCBdlEPv>
    800047e4:	00090513          	mv	a0,s2
    800047e8:	00008097          	auipc	ra,0x8
    800047ec:	640080e7          	jalr	1600(ra) # 8000ce28 <_Unwind_Resume>
    800047f0:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    800047f4:	00048513          	mv	a0,s1
    800047f8:	ffffe097          	auipc	ra,0xffffe
    800047fc:	ec8080e7          	jalr	-312(ra) # 800026c0 <_ZN3SCBdlEPv>
    80004800:	00090513          	mv	a0,s2
    80004804:	00008097          	auipc	ra,0x8
    80004808:	624080e7          	jalr	1572(ra) # 8000ce28 <_Unwind_Resume>

000000008000480c <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    8000480c:	00003717          	auipc	a4,0x3
    80004810:	51470713          	addi	a4,a4,1300 # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    80004814:	01073683          	ld	a3,16(a4)
    80004818:	00168793          	addi	a5,a3,1
    8000481c:	00003617          	auipc	a2,0x3
    80004820:	1cc63603          	ld	a2,460(a2) # 800079e8 <_ZN11ConsoleUtil10bufferSizeE>
    80004824:	02c7f7b3          	remu	a5,a5,a2
    80004828:	01873703          	ld	a4,24(a4)
    8000482c:	04e78663          	beq	a5,a4,80004878 <_ZN11ConsoleUtil8putInputEc+0x6c>
void ConsoleUtil::putInput(char c) {
    80004830:	ff010113          	addi	sp,sp,-16
    80004834:	00113423          	sd	ra,8(sp)
    80004838:	00813023          	sd	s0,0(sp)
    8000483c:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004840:	00005717          	auipc	a4,0x5
    80004844:	51870713          	addi	a4,a4,1304 # 80009d58 <_ZN11ConsoleUtil11inputBufferE>
    80004848:	00d706b3          	add	a3,a4,a3
    8000484c:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    80004850:	00003717          	auipc	a4,0x3
    80004854:	4d070713          	addi	a4,a4,1232 # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    80004858:	00f73823          	sd	a5,16(a4)
    inputSem->signal();
    8000485c:	00073503          	ld	a0,0(a4)
    80004860:	ffffe097          	auipc	ra,0xffffe
    80004864:	df4080e7          	jalr	-524(ra) # 80002654 <_ZN3SCB6signalEv>
}
    80004868:	00813083          	ld	ra,8(sp)
    8000486c:	00013403          	ld	s0,0(sp)
    80004870:	01010113          	addi	sp,sp,16
    80004874:	00008067          	ret
    80004878:	00008067          	ret

000000008000487c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    8000487c:	fe010113          	addi	sp,sp,-32
    80004880:	00113c23          	sd	ra,24(sp)
    80004884:	00813823          	sd	s0,16(sp)
    80004888:	00913423          	sd	s1,8(sp)
    8000488c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004890:	00003497          	auipc	s1,0x3
    80004894:	49048493          	addi	s1,s1,1168 # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    80004898:	0004b503          	ld	a0,0(s1)
    8000489c:	ffffe097          	auipc	ra,0xffffe
    800048a0:	d68080e7          	jalr	-664(ra) # 80002604 <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    800048a4:	0184b783          	ld	a5,24(s1)
    800048a8:	0104b703          	ld	a4,16(s1)
    800048ac:	04e78063          	beq	a5,a4,800048ec <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    800048b0:	00005717          	auipc	a4,0x5
    800048b4:	4a870713          	addi	a4,a4,1192 # 80009d58 <_ZN11ConsoleUtil11inputBufferE>
    800048b8:	00f70733          	add	a4,a4,a5
    800048bc:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    800048c0:	00178793          	addi	a5,a5,1
    800048c4:	00003717          	auipc	a4,0x3
    800048c8:	12473703          	ld	a4,292(a4) # 800079e8 <_ZN11ConsoleUtil10bufferSizeE>
    800048cc:	02e7f7b3          	remu	a5,a5,a4
    800048d0:	00003717          	auipc	a4,0x3
    800048d4:	46f73423          	sd	a5,1128(a4) # 80007d38 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    800048d8:	01813083          	ld	ra,24(sp)
    800048dc:	01013403          	ld	s0,16(sp)
    800048e0:	00813483          	ld	s1,8(sp)
    800048e4:	02010113          	addi	sp,sp,32
    800048e8:	00008067          	ret
        return -1;
    800048ec:	0ff00513          	li	a0,255
    800048f0:	fe9ff06f          	j	800048d8 <_ZN11ConsoleUtil8getInputEv+0x5c>

00000000800048f4 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    800048f4:	00003797          	auipc	a5,0x3
    800048f8:	42c78793          	addi	a5,a5,1068 # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    800048fc:	0207b683          	ld	a3,32(a5)
    80004900:	00168713          	addi	a4,a3,1
    80004904:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    80004908:	0287b603          	ld	a2,40(a5)
    8000490c:	00160713          	addi	a4,a2,1
    80004910:	00003597          	auipc	a1,0x3
    80004914:	0d85b583          	ld	a1,216(a1) # 800079e8 <_ZN11ConsoleUtil10bufferSizeE>
    80004918:	02b77733          	remu	a4,a4,a1
    8000491c:	0307b783          	ld	a5,48(a5)
    80004920:	04f70863          	beq	a4,a5,80004970 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    80004924:	ff010113          	addi	sp,sp,-16
    80004928:	00113423          	sd	ra,8(sp)
    8000492c:	00813023          	sd	s0,0(sp)
    80004930:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    80004934:	00003797          	auipc	a5,0x3
    80004938:	42478793          	addi	a5,a5,1060 # 80007d58 <_ZN11ConsoleUtil12outputBufferE>
    8000493c:	00c78633          	add	a2,a5,a2
    80004940:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    80004944:	00003797          	auipc	a5,0x3
    80004948:	3dc78793          	addi	a5,a5,988 # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    8000494c:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004950:	02d7b023          	sd	a3,32(a5)

    outputSem->signal();
    80004954:	0087b503          	ld	a0,8(a5)
    80004958:	ffffe097          	auipc	ra,0xffffe
    8000495c:	cfc080e7          	jalr	-772(ra) # 80002654 <_ZN3SCB6signalEv>
}
    80004960:	00813083          	ld	ra,8(sp)
    80004964:	00013403          	ld	s0,0(sp)
    80004968:	01010113          	addi	sp,sp,16
    8000496c:	00008067          	ret
    80004970:	00008067          	ret

0000000080004974 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004974:	fe010113          	addi	sp,sp,-32
    80004978:	00113c23          	sd	ra,24(sp)
    8000497c:	00813823          	sd	s0,16(sp)
    80004980:	00913423          	sd	s1,8(sp)
    80004984:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004988:	00003497          	auipc	s1,0x3
    8000498c:	39848493          	addi	s1,s1,920 # 80007d20 <_ZN11ConsoleUtil8inputSemE>
    80004990:	0084b503          	ld	a0,8(s1)
    80004994:	ffffe097          	auipc	ra,0xffffe
    80004998:	c70080e7          	jalr	-912(ra) # 80002604 <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000499c:	0304b783          	ld	a5,48(s1)
    800049a0:	0284b703          	ld	a4,40(s1)
    800049a4:	04e78063          	beq	a5,a4,800049e4 <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    800049a8:	00003717          	auipc	a4,0x3
    800049ac:	3b070713          	addi	a4,a4,944 # 80007d58 <_ZN11ConsoleUtil12outputBufferE>
    800049b0:	00f70733          	add	a4,a4,a5
    800049b4:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    800049b8:	00178793          	addi	a5,a5,1
    800049bc:	00003717          	auipc	a4,0x3
    800049c0:	02c73703          	ld	a4,44(a4) # 800079e8 <_ZN11ConsoleUtil10bufferSizeE>
    800049c4:	02e7f7b3          	remu	a5,a5,a4
    800049c8:	00003717          	auipc	a4,0x3
    800049cc:	38f73423          	sd	a5,904(a4) # 80007d50 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    800049d0:	01813083          	ld	ra,24(sp)
    800049d4:	01013403          	ld	s0,16(sp)
    800049d8:	00813483          	ld	s1,8(sp)
    800049dc:	02010113          	addi	sp,sp,32
    800049e0:	00008067          	ret
        return -1;
    800049e4:	0ff00513          	li	a0,255
    800049e8:	fe9ff06f          	j	800049d0 <_ZN11ConsoleUtil9getOutputEv+0x5c>

00000000800049ec <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    800049ec:	fe010113          	addi	sp,sp,-32
    800049f0:	00113c23          	sd	ra,24(sp)
    800049f4:	00813823          	sd	s0,16(sp)
    800049f8:	00913423          	sd	s1,8(sp)
    800049fc:	02010413          	addi	s0,sp,32
    80004a00:	00050493          	mv	s1,a0
    while (*string != '\0')
    80004a04:	0004c503          	lbu	a0,0(s1)
    80004a08:	00050a63          	beqz	a0,80004a1c <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    80004a0c:	00000097          	auipc	ra,0x0
    80004a10:	ee8080e7          	jalr	-280(ra) # 800048f4 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    80004a14:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004a18:	fedff06f          	j	80004a04 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    80004a1c:	01813083          	ld	ra,24(sp)
    80004a20:	01013403          	ld	s0,16(sp)
    80004a24:	00813483          	ld	s1,8(sp)
    80004a28:	02010113          	addi	sp,sp,32
    80004a2c:	00008067          	ret

0000000080004a30 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    80004a30:	fb010113          	addi	sp,sp,-80
    80004a34:	04113423          	sd	ra,72(sp)
    80004a38:	04813023          	sd	s0,64(sp)
    80004a3c:	02913c23          	sd	s1,56(sp)
    80004a40:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004a44:	00003797          	auipc	a5,0x3
    80004a48:	b0c78793          	addi	a5,a5,-1268 # 80007550 <CONSOLE_STATUS+0x540>
    80004a4c:	0007b703          	ld	a4,0(a5)
    80004a50:	fce43423          	sd	a4,-56(s0)
    80004a54:	0087b703          	ld	a4,8(a5)
    80004a58:	fce43823          	sd	a4,-48(s0)
    80004a5c:	0107c783          	lbu	a5,16(a5)
    80004a60:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004a64:	00060463          	beqz	a2,80004a6c <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004a68:	08054263          	bltz	a0,80004aec <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004a6c:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004a70:	00000813          	li	a6,0
    }

    i = 0;
    80004a74:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004a78:	0005871b          	sext.w	a4,a1
    80004a7c:	02b577bb          	remuw	a5,a0,a1
    80004a80:	00048693          	mv	a3,s1
    80004a84:	0014849b          	addiw	s1,s1,1
    80004a88:	02079793          	slli	a5,a5,0x20
    80004a8c:	0207d793          	srli	a5,a5,0x20
    80004a90:	fe040613          	addi	a2,s0,-32
    80004a94:	00f607b3          	add	a5,a2,a5
    80004a98:	fe87c603          	lbu	a2,-24(a5)
    80004a9c:	fe040793          	addi	a5,s0,-32
    80004aa0:	00d787b3          	add	a5,a5,a3
    80004aa4:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004aa8:	0005061b          	sext.w	a2,a0
    80004aac:	02b5553b          	divuw	a0,a0,a1
    80004ab0:	fce674e3          	bgeu	a2,a4,80004a78 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004ab4:	00080c63          	beqz	a6,80004acc <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004ab8:	fe040793          	addi	a5,s0,-32
    80004abc:	009784b3          	add	s1,a5,s1
    80004ac0:	02d00793          	li	a5,45
    80004ac4:	fcf48c23          	sb	a5,-40(s1)
    80004ac8:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    80004acc:	fff4849b          	addiw	s1,s1,-1
    80004ad0:	0204c463          	bltz	s1,80004af8 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004ad4:	fe040793          	addi	a5,s0,-32
    80004ad8:	009787b3          	add	a5,a5,s1
    80004adc:	fd87c503          	lbu	a0,-40(a5)
    80004ae0:	00000097          	auipc	ra,0x0
    80004ae4:	e14080e7          	jalr	-492(ra) # 800048f4 <_ZN11ConsoleUtil9putOutputEc>
    80004ae8:	fe5ff06f          	j	80004acc <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    80004aec:	40a0053b          	negw	a0,a0
        neg = 1;
    80004af0:	00100813          	li	a6,1
        x = -xx;
    80004af4:	f81ff06f          	j	80004a74 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    80004af8:	04813083          	ld	ra,72(sp)
    80004afc:	04013403          	ld	s0,64(sp)
    80004b00:	03813483          	ld	s1,56(sp)
    80004b04:	05010113          	addi	sp,sp,80
    80004b08:	00008067          	ret

0000000080004b0c <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    80004b0c:	fd010113          	addi	sp,sp,-48
    80004b10:	02113423          	sd	ra,40(sp)
    80004b14:	02813023          	sd	s0,32(sp)
    80004b18:	00913c23          	sd	s1,24(sp)
    80004b1c:	01213823          	sd	s2,16(sp)
    80004b20:	01313423          	sd	s3,8(sp)
    80004b24:	03010413          	addi	s0,sp,48
    80004b28:	00058913          	mv	s2,a1
    80004b2c:	00060493          	mv	s1,a2
    80004b30:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    80004b34:	00000097          	auipc	ra,0x0
    80004b38:	eb8080e7          	jalr	-328(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    80004b3c:	00000613          	li	a2,0
    80004b40:	00098593          	mv	a1,s3
    80004b44:	00090513          	mv	a0,s2
    80004b48:	00000097          	auipc	ra,0x0
    80004b4c:	ee8080e7          	jalr	-280(ra) # 80004a30 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004b50:	00048513          	mv	a0,s1
    80004b54:	00000097          	auipc	ra,0x0
    80004b58:	e98080e7          	jalr	-360(ra) # 800049ec <_ZN11ConsoleUtil11printStringEPKc>
}
    80004b5c:	02813083          	ld	ra,40(sp)
    80004b60:	02013403          	ld	s0,32(sp)
    80004b64:	01813483          	ld	s1,24(sp)
    80004b68:	01013903          	ld	s2,16(sp)
    80004b6c:	00813983          	ld	s3,8(sp)
    80004b70:	03010113          	addi	sp,sp,48
    80004b74:	00008067          	ret

0000000080004b78 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004b78:	ff010113          	addi	sp,sp,-16
    80004b7c:	00813423          	sd	s0,8(sp)
    80004b80:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004b84:	04300513          	li	a0,67

    asm("ecall");
    80004b88:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004b8c:	00050513          	mv	a0,a0

    return (char)status;
}
    80004b90:	0ff57513          	andi	a0,a0,255
    80004b94:	00813403          	ld	s0,8(sp)
    80004b98:	01010113          	addi	sp,sp,16
    80004b9c:	00008067          	ret

0000000080004ba0 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004ba0:	ff010113          	addi	sp,sp,-16
    80004ba4:	00113423          	sd	ra,8(sp)
    80004ba8:	00813023          	sd	s0,0(sp)
    80004bac:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004bb0:	ffffd097          	auipc	ra,0xffffd
    80004bb4:	e08080e7          	jalr	-504(ra) # 800019b8 <_ZN13SlabAllocator10initializeEPvm>
}
    80004bb8:	00813083          	ld	ra,8(sp)
    80004bbc:	00013403          	ld	s0,0(sp)
    80004bc0:	01010113          	addi	sp,sp,16
    80004bc4:	00008067          	ret

0000000080004bc8 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004bc8:	ff010113          	addi	sp,sp,-16
    80004bcc:	00113423          	sd	ra,8(sp)
    80004bd0:	00813023          	sd	s0,0(sp)
    80004bd4:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004bd8:	ffffd097          	auipc	ra,0xffffd
    80004bdc:	d3c080e7          	jalr	-708(ra) # 80001914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004be0:	00813083          	ld	ra,8(sp)
    80004be4:	00013403          	ld	s0,0(sp)
    80004be8:	01010113          	addi	sp,sp,16
    80004bec:	00008067          	ret

0000000080004bf0 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004bf0:	ff010113          	addi	sp,sp,-16
    80004bf4:	00113423          	sd	ra,8(sp)
    80004bf8:	00813023          	sd	s0,0(sp)
    80004bfc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004c00:	ffffd097          	auipc	ra,0xffffd
    80004c04:	bd8080e7          	jalr	-1064(ra) # 800017d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004c08:	00813083          	ld	ra,8(sp)
    80004c0c:	00013403          	ld	s0,0(sp)
    80004c10:	01010113          	addi	sp,sp,16
    80004c14:	00008067          	ret

0000000080004c18 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004c18:	ff010113          	addi	sp,sp,-16
    80004c1c:	00113423          	sd	ra,8(sp)
    80004c20:	00813023          	sd	s0,0(sp)
    80004c24:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80004c28:	ffffd097          	auipc	ra,0xffffd
    80004c2c:	f68080e7          	jalr	-152(ra) # 80001b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80004c30:	00813083          	ld	ra,8(sp)
    80004c34:	00013403          	ld	s0,0(sp)
    80004c38:	01010113          	addi	sp,sp,16
    80004c3c:	00008067          	ret

0000000080004c40 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80004c40:	fe010113          	addi	sp,sp,-32
    80004c44:	00113c23          	sd	ra,24(sp)
    80004c48:	00813823          	sd	s0,16(sp)
    80004c4c:	02010413          	addi	s0,sp,32
    80004c50:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80004c54:	fe840513          	addi	a0,s0,-24
    80004c58:	ffffd097          	auipc	ra,0xffffd
    80004c5c:	098080e7          	jalr	152(ra) # 80001cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80004c60:	01813083          	ld	ra,24(sp)
    80004c64:	01013403          	ld	s0,16(sp)
    80004c68:	02010113          	addi	sp,sp,32
    80004c6c:	00008067          	ret

0000000080004c70 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80004c70:	ff010113          	addi	sp,sp,-16
    80004c74:	00113423          	sd	ra,8(sp)
    80004c78:	00813023          	sd	s0,0(sp)
    80004c7c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80004c80:	ffffc097          	auipc	ra,0xffffc
    80004c84:	67c080e7          	jalr	1660(ra) # 800012fc <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004c88:	00813083          	ld	ra,8(sp)
    80004c8c:	00013403          	ld	s0,0(sp)
    80004c90:	01010113          	addi	sp,sp,16
    80004c94:	00008067          	ret

0000000080004c98 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004c98:	ff010113          	addi	sp,sp,-16
    80004c9c:	00113423          	sd	ra,8(sp)
    80004ca0:	00813023          	sd	s0,0(sp)
    80004ca4:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004ca8:	ffffc097          	auipc	ra,0xffffc
    80004cac:	48c080e7          	jalr	1164(ra) # 80001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004cb0:	00813083          	ld	ra,8(sp)
    80004cb4:	00013403          	ld	s0,0(sp)
    80004cb8:	01010113          	addi	sp,sp,16
    80004cbc:	00008067          	ret

0000000080004cc0 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004cc0:	ff010113          	addi	sp,sp,-16
    80004cc4:	00113423          	sd	ra,8(sp)
    80004cc8:	00813023          	sd	s0,0(sp)
    80004ccc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004cd0:	ffffd097          	auipc	ra,0xffffd
    80004cd4:	ba4080e7          	jalr	-1116(ra) # 80001874 <_ZN13SlabAllocator14allocateBufferEm>
}
    80004cd8:	00813083          	ld	ra,8(sp)
    80004cdc:	00013403          	ld	s0,0(sp)
    80004ce0:	01010113          	addi	sp,sp,16
    80004ce4:	00008067          	ret

0000000080004ce8 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004ce8:	ff010113          	addi	sp,sp,-16
    80004cec:	00113423          	sd	ra,8(sp)
    80004cf0:	00813023          	sd	s0,0(sp)
    80004cf4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80004cf8:	ffffd097          	auipc	ra,0xffffd
    80004cfc:	f8c080e7          	jalr	-116(ra) # 80001c84 <_ZN13SlabAllocator10freeBufferEPKv>
    80004d00:	00813083          	ld	ra,8(sp)
    80004d04:	00013403          	ld	s0,0(sp)
    80004d08:	01010113          	addi	sp,sp,16
    80004d0c:	00008067          	ret

0000000080004d10 <start>:
    80004d10:	ff010113          	addi	sp,sp,-16
    80004d14:	00813423          	sd	s0,8(sp)
    80004d18:	01010413          	addi	s0,sp,16
    80004d1c:	300027f3          	csrr	a5,mstatus
    80004d20:	ffffe737          	lui	a4,0xffffe
    80004d24:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffec7ff>
    80004d28:	00e7f7b3          	and	a5,a5,a4
    80004d2c:	00001737          	lui	a4,0x1
    80004d30:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004d34:	00e7e7b3          	or	a5,a5,a4
    80004d38:	30079073          	csrw	mstatus,a5
    80004d3c:	00000797          	auipc	a5,0x0
    80004d40:	16078793          	addi	a5,a5,352 # 80004e9c <system_main>
    80004d44:	34179073          	csrw	mepc,a5
    80004d48:	00000793          	li	a5,0
    80004d4c:	18079073          	csrw	satp,a5
    80004d50:	000107b7          	lui	a5,0x10
    80004d54:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004d58:	30279073          	csrw	medeleg,a5
    80004d5c:	30379073          	csrw	mideleg,a5
    80004d60:	104027f3          	csrr	a5,sie
    80004d64:	2227e793          	ori	a5,a5,546
    80004d68:	10479073          	csrw	sie,a5
    80004d6c:	fff00793          	li	a5,-1
    80004d70:	00a7d793          	srli	a5,a5,0xa
    80004d74:	3b079073          	csrw	pmpaddr0,a5
    80004d78:	00f00793          	li	a5,15
    80004d7c:	3a079073          	csrw	pmpcfg0,a5
    80004d80:	f14027f3          	csrr	a5,mhartid
    80004d84:	0200c737          	lui	a4,0x200c
    80004d88:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004d8c:	0007869b          	sext.w	a3,a5
    80004d90:	00269713          	slli	a4,a3,0x2
    80004d94:	000f4637          	lui	a2,0xf4
    80004d98:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004d9c:	00d70733          	add	a4,a4,a3
    80004da0:	0037979b          	slliw	a5,a5,0x3
    80004da4:	020046b7          	lui	a3,0x2004
    80004da8:	00d787b3          	add	a5,a5,a3
    80004dac:	00c585b3          	add	a1,a1,a2
    80004db0:	00371693          	slli	a3,a4,0x3
    80004db4:	00007717          	auipc	a4,0x7
    80004db8:	fac70713          	addi	a4,a4,-84 # 8000bd60 <timer_scratch>
    80004dbc:	00b7b023          	sd	a1,0(a5)
    80004dc0:	00d70733          	add	a4,a4,a3
    80004dc4:	00f73c23          	sd	a5,24(a4)
    80004dc8:	02c73023          	sd	a2,32(a4)
    80004dcc:	34071073          	csrw	mscratch,a4
    80004dd0:	00000797          	auipc	a5,0x0
    80004dd4:	6e078793          	addi	a5,a5,1760 # 800054b0 <timervec>
    80004dd8:	30579073          	csrw	mtvec,a5
    80004ddc:	300027f3          	csrr	a5,mstatus
    80004de0:	0087e793          	ori	a5,a5,8
    80004de4:	30079073          	csrw	mstatus,a5
    80004de8:	304027f3          	csrr	a5,mie
    80004dec:	0807e793          	ori	a5,a5,128
    80004df0:	30479073          	csrw	mie,a5
    80004df4:	f14027f3          	csrr	a5,mhartid
    80004df8:	0007879b          	sext.w	a5,a5
    80004dfc:	00078213          	mv	tp,a5
    80004e00:	30200073          	mret
    80004e04:	00813403          	ld	s0,8(sp)
    80004e08:	01010113          	addi	sp,sp,16
    80004e0c:	00008067          	ret

0000000080004e10 <timerinit>:
    80004e10:	ff010113          	addi	sp,sp,-16
    80004e14:	00813423          	sd	s0,8(sp)
    80004e18:	01010413          	addi	s0,sp,16
    80004e1c:	f14027f3          	csrr	a5,mhartid
    80004e20:	0200c737          	lui	a4,0x200c
    80004e24:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004e28:	0007869b          	sext.w	a3,a5
    80004e2c:	00269713          	slli	a4,a3,0x2
    80004e30:	000f4637          	lui	a2,0xf4
    80004e34:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004e38:	00d70733          	add	a4,a4,a3
    80004e3c:	0037979b          	slliw	a5,a5,0x3
    80004e40:	020046b7          	lui	a3,0x2004
    80004e44:	00d787b3          	add	a5,a5,a3
    80004e48:	00c585b3          	add	a1,a1,a2
    80004e4c:	00371693          	slli	a3,a4,0x3
    80004e50:	00007717          	auipc	a4,0x7
    80004e54:	f1070713          	addi	a4,a4,-240 # 8000bd60 <timer_scratch>
    80004e58:	00b7b023          	sd	a1,0(a5)
    80004e5c:	00d70733          	add	a4,a4,a3
    80004e60:	00f73c23          	sd	a5,24(a4)
    80004e64:	02c73023          	sd	a2,32(a4)
    80004e68:	34071073          	csrw	mscratch,a4
    80004e6c:	00000797          	auipc	a5,0x0
    80004e70:	64478793          	addi	a5,a5,1604 # 800054b0 <timervec>
    80004e74:	30579073          	csrw	mtvec,a5
    80004e78:	300027f3          	csrr	a5,mstatus
    80004e7c:	0087e793          	ori	a5,a5,8
    80004e80:	30079073          	csrw	mstatus,a5
    80004e84:	304027f3          	csrr	a5,mie
    80004e88:	0807e793          	ori	a5,a5,128
    80004e8c:	30479073          	csrw	mie,a5
    80004e90:	00813403          	ld	s0,8(sp)
    80004e94:	01010113          	addi	sp,sp,16
    80004e98:	00008067          	ret

0000000080004e9c <system_main>:
    80004e9c:	fe010113          	addi	sp,sp,-32
    80004ea0:	00813823          	sd	s0,16(sp)
    80004ea4:	00913423          	sd	s1,8(sp)
    80004ea8:	00113c23          	sd	ra,24(sp)
    80004eac:	02010413          	addi	s0,sp,32
    80004eb0:	00000097          	auipc	ra,0x0
    80004eb4:	0c4080e7          	jalr	196(ra) # 80004f74 <cpuid>
    80004eb8:	00003497          	auipc	s1,0x3
    80004ebc:	c3848493          	addi	s1,s1,-968 # 80007af0 <started>
    80004ec0:	02050263          	beqz	a0,80004ee4 <system_main+0x48>
    80004ec4:	0004a783          	lw	a5,0(s1)
    80004ec8:	0007879b          	sext.w	a5,a5
    80004ecc:	fe078ce3          	beqz	a5,80004ec4 <system_main+0x28>
    80004ed0:	0ff0000f          	fence
    80004ed4:	00002517          	auipc	a0,0x2
    80004ed8:	6c450513          	addi	a0,a0,1732 # 80007598 <CONSOLE_STATUS+0x588>
    80004edc:	00001097          	auipc	ra,0x1
    80004ee0:	a70080e7          	jalr	-1424(ra) # 8000594c <panic>
    80004ee4:	00001097          	auipc	ra,0x1
    80004ee8:	9c4080e7          	jalr	-1596(ra) # 800058a8 <consoleinit>
    80004eec:	00001097          	auipc	ra,0x1
    80004ef0:	150080e7          	jalr	336(ra) # 8000603c <printfinit>
    80004ef4:	00002517          	auipc	a0,0x2
    80004ef8:	45c50513          	addi	a0,a0,1116 # 80007350 <CONSOLE_STATUS+0x340>
    80004efc:	00001097          	auipc	ra,0x1
    80004f00:	aac080e7          	jalr	-1364(ra) # 800059a8 <__printf>
    80004f04:	00002517          	auipc	a0,0x2
    80004f08:	66450513          	addi	a0,a0,1636 # 80007568 <CONSOLE_STATUS+0x558>
    80004f0c:	00001097          	auipc	ra,0x1
    80004f10:	a9c080e7          	jalr	-1380(ra) # 800059a8 <__printf>
    80004f14:	00002517          	auipc	a0,0x2
    80004f18:	43c50513          	addi	a0,a0,1084 # 80007350 <CONSOLE_STATUS+0x340>
    80004f1c:	00001097          	auipc	ra,0x1
    80004f20:	a8c080e7          	jalr	-1396(ra) # 800059a8 <__printf>
    80004f24:	00001097          	auipc	ra,0x1
    80004f28:	4a4080e7          	jalr	1188(ra) # 800063c8 <kinit>
    80004f2c:	00000097          	auipc	ra,0x0
    80004f30:	148080e7          	jalr	328(ra) # 80005074 <trapinit>
    80004f34:	00000097          	auipc	ra,0x0
    80004f38:	16c080e7          	jalr	364(ra) # 800050a0 <trapinithart>
    80004f3c:	00000097          	auipc	ra,0x0
    80004f40:	5b4080e7          	jalr	1460(ra) # 800054f0 <plicinit>
    80004f44:	00000097          	auipc	ra,0x0
    80004f48:	5d4080e7          	jalr	1492(ra) # 80005518 <plicinithart>
    80004f4c:	00000097          	auipc	ra,0x0
    80004f50:	078080e7          	jalr	120(ra) # 80004fc4 <userinit>
    80004f54:	0ff0000f          	fence
    80004f58:	00100793          	li	a5,1
    80004f5c:	00002517          	auipc	a0,0x2
    80004f60:	62450513          	addi	a0,a0,1572 # 80007580 <CONSOLE_STATUS+0x570>
    80004f64:	00f4a023          	sw	a5,0(s1)
    80004f68:	00001097          	auipc	ra,0x1
    80004f6c:	a40080e7          	jalr	-1472(ra) # 800059a8 <__printf>
    80004f70:	0000006f          	j	80004f70 <system_main+0xd4>

0000000080004f74 <cpuid>:
    80004f74:	ff010113          	addi	sp,sp,-16
    80004f78:	00813423          	sd	s0,8(sp)
    80004f7c:	01010413          	addi	s0,sp,16
    80004f80:	00020513          	mv	a0,tp
    80004f84:	00813403          	ld	s0,8(sp)
    80004f88:	0005051b          	sext.w	a0,a0
    80004f8c:	01010113          	addi	sp,sp,16
    80004f90:	00008067          	ret

0000000080004f94 <mycpu>:
    80004f94:	ff010113          	addi	sp,sp,-16
    80004f98:	00813423          	sd	s0,8(sp)
    80004f9c:	01010413          	addi	s0,sp,16
    80004fa0:	00020793          	mv	a5,tp
    80004fa4:	00813403          	ld	s0,8(sp)
    80004fa8:	0007879b          	sext.w	a5,a5
    80004fac:	00779793          	slli	a5,a5,0x7
    80004fb0:	00008517          	auipc	a0,0x8
    80004fb4:	de050513          	addi	a0,a0,-544 # 8000cd90 <cpus>
    80004fb8:	00f50533          	add	a0,a0,a5
    80004fbc:	01010113          	addi	sp,sp,16
    80004fc0:	00008067          	ret

0000000080004fc4 <userinit>:
    80004fc4:	ff010113          	addi	sp,sp,-16
    80004fc8:	00813423          	sd	s0,8(sp)
    80004fcc:	01010413          	addi	s0,sp,16
    80004fd0:	00813403          	ld	s0,8(sp)
    80004fd4:	01010113          	addi	sp,sp,16
    80004fd8:	ffffd317          	auipc	t1,0xffffd
    80004fdc:	74830067          	jr	1864(t1) # 80002720 <main>

0000000080004fe0 <either_copyout>:
    80004fe0:	ff010113          	addi	sp,sp,-16
    80004fe4:	00813023          	sd	s0,0(sp)
    80004fe8:	00113423          	sd	ra,8(sp)
    80004fec:	01010413          	addi	s0,sp,16
    80004ff0:	02051663          	bnez	a0,8000501c <either_copyout+0x3c>
    80004ff4:	00058513          	mv	a0,a1
    80004ff8:	00060593          	mv	a1,a2
    80004ffc:	0006861b          	sext.w	a2,a3
    80005000:	00002097          	auipc	ra,0x2
    80005004:	c54080e7          	jalr	-940(ra) # 80006c54 <__memmove>
    80005008:	00813083          	ld	ra,8(sp)
    8000500c:	00013403          	ld	s0,0(sp)
    80005010:	00000513          	li	a0,0
    80005014:	01010113          	addi	sp,sp,16
    80005018:	00008067          	ret
    8000501c:	00002517          	auipc	a0,0x2
    80005020:	5a450513          	addi	a0,a0,1444 # 800075c0 <CONSOLE_STATUS+0x5b0>
    80005024:	00001097          	auipc	ra,0x1
    80005028:	928080e7          	jalr	-1752(ra) # 8000594c <panic>

000000008000502c <either_copyin>:
    8000502c:	ff010113          	addi	sp,sp,-16
    80005030:	00813023          	sd	s0,0(sp)
    80005034:	00113423          	sd	ra,8(sp)
    80005038:	01010413          	addi	s0,sp,16
    8000503c:	02059463          	bnez	a1,80005064 <either_copyin+0x38>
    80005040:	00060593          	mv	a1,a2
    80005044:	0006861b          	sext.w	a2,a3
    80005048:	00002097          	auipc	ra,0x2
    8000504c:	c0c080e7          	jalr	-1012(ra) # 80006c54 <__memmove>
    80005050:	00813083          	ld	ra,8(sp)
    80005054:	00013403          	ld	s0,0(sp)
    80005058:	00000513          	li	a0,0
    8000505c:	01010113          	addi	sp,sp,16
    80005060:	00008067          	ret
    80005064:	00002517          	auipc	a0,0x2
    80005068:	58450513          	addi	a0,a0,1412 # 800075e8 <CONSOLE_STATUS+0x5d8>
    8000506c:	00001097          	auipc	ra,0x1
    80005070:	8e0080e7          	jalr	-1824(ra) # 8000594c <panic>

0000000080005074 <trapinit>:
    80005074:	ff010113          	addi	sp,sp,-16
    80005078:	00813423          	sd	s0,8(sp)
    8000507c:	01010413          	addi	s0,sp,16
    80005080:	00813403          	ld	s0,8(sp)
    80005084:	00002597          	auipc	a1,0x2
    80005088:	58c58593          	addi	a1,a1,1420 # 80007610 <CONSOLE_STATUS+0x600>
    8000508c:	00008517          	auipc	a0,0x8
    80005090:	d8450513          	addi	a0,a0,-636 # 8000ce10 <tickslock>
    80005094:	01010113          	addi	sp,sp,16
    80005098:	00001317          	auipc	t1,0x1
    8000509c:	5c030067          	jr	1472(t1) # 80006658 <initlock>

00000000800050a0 <trapinithart>:
    800050a0:	ff010113          	addi	sp,sp,-16
    800050a4:	00813423          	sd	s0,8(sp)
    800050a8:	01010413          	addi	s0,sp,16
    800050ac:	00000797          	auipc	a5,0x0
    800050b0:	2f478793          	addi	a5,a5,756 # 800053a0 <kernelvec>
    800050b4:	10579073          	csrw	stvec,a5
    800050b8:	00813403          	ld	s0,8(sp)
    800050bc:	01010113          	addi	sp,sp,16
    800050c0:	00008067          	ret

00000000800050c4 <usertrap>:
    800050c4:	ff010113          	addi	sp,sp,-16
    800050c8:	00813423          	sd	s0,8(sp)
    800050cc:	01010413          	addi	s0,sp,16
    800050d0:	00813403          	ld	s0,8(sp)
    800050d4:	01010113          	addi	sp,sp,16
    800050d8:	00008067          	ret

00000000800050dc <usertrapret>:
    800050dc:	ff010113          	addi	sp,sp,-16
    800050e0:	00813423          	sd	s0,8(sp)
    800050e4:	01010413          	addi	s0,sp,16
    800050e8:	00813403          	ld	s0,8(sp)
    800050ec:	01010113          	addi	sp,sp,16
    800050f0:	00008067          	ret

00000000800050f4 <kerneltrap>:
    800050f4:	fe010113          	addi	sp,sp,-32
    800050f8:	00813823          	sd	s0,16(sp)
    800050fc:	00113c23          	sd	ra,24(sp)
    80005100:	00913423          	sd	s1,8(sp)
    80005104:	02010413          	addi	s0,sp,32
    80005108:	142025f3          	csrr	a1,scause
    8000510c:	100027f3          	csrr	a5,sstatus
    80005110:	0027f793          	andi	a5,a5,2
    80005114:	10079c63          	bnez	a5,8000522c <kerneltrap+0x138>
    80005118:	142027f3          	csrr	a5,scause
    8000511c:	0207ce63          	bltz	a5,80005158 <kerneltrap+0x64>
    80005120:	00002517          	auipc	a0,0x2
    80005124:	53850513          	addi	a0,a0,1336 # 80007658 <CONSOLE_STATUS+0x648>
    80005128:	00001097          	auipc	ra,0x1
    8000512c:	880080e7          	jalr	-1920(ra) # 800059a8 <__printf>
    80005130:	141025f3          	csrr	a1,sepc
    80005134:	14302673          	csrr	a2,stval
    80005138:	00002517          	auipc	a0,0x2
    8000513c:	53050513          	addi	a0,a0,1328 # 80007668 <CONSOLE_STATUS+0x658>
    80005140:	00001097          	auipc	ra,0x1
    80005144:	868080e7          	jalr	-1944(ra) # 800059a8 <__printf>
    80005148:	00002517          	auipc	a0,0x2
    8000514c:	53850513          	addi	a0,a0,1336 # 80007680 <CONSOLE_STATUS+0x670>
    80005150:	00000097          	auipc	ra,0x0
    80005154:	7fc080e7          	jalr	2044(ra) # 8000594c <panic>
    80005158:	0ff7f713          	andi	a4,a5,255
    8000515c:	00900693          	li	a3,9
    80005160:	04d70063          	beq	a4,a3,800051a0 <kerneltrap+0xac>
    80005164:	fff00713          	li	a4,-1
    80005168:	03f71713          	slli	a4,a4,0x3f
    8000516c:	00170713          	addi	a4,a4,1
    80005170:	fae798e3          	bne	a5,a4,80005120 <kerneltrap+0x2c>
    80005174:	00000097          	auipc	ra,0x0
    80005178:	e00080e7          	jalr	-512(ra) # 80004f74 <cpuid>
    8000517c:	06050663          	beqz	a0,800051e8 <kerneltrap+0xf4>
    80005180:	144027f3          	csrr	a5,sip
    80005184:	ffd7f793          	andi	a5,a5,-3
    80005188:	14479073          	csrw	sip,a5
    8000518c:	01813083          	ld	ra,24(sp)
    80005190:	01013403          	ld	s0,16(sp)
    80005194:	00813483          	ld	s1,8(sp)
    80005198:	02010113          	addi	sp,sp,32
    8000519c:	00008067          	ret
    800051a0:	00000097          	auipc	ra,0x0
    800051a4:	3c4080e7          	jalr	964(ra) # 80005564 <plic_claim>
    800051a8:	00a00793          	li	a5,10
    800051ac:	00050493          	mv	s1,a0
    800051b0:	06f50863          	beq	a0,a5,80005220 <kerneltrap+0x12c>
    800051b4:	fc050ce3          	beqz	a0,8000518c <kerneltrap+0x98>
    800051b8:	00050593          	mv	a1,a0
    800051bc:	00002517          	auipc	a0,0x2
    800051c0:	47c50513          	addi	a0,a0,1148 # 80007638 <CONSOLE_STATUS+0x628>
    800051c4:	00000097          	auipc	ra,0x0
    800051c8:	7e4080e7          	jalr	2020(ra) # 800059a8 <__printf>
    800051cc:	01013403          	ld	s0,16(sp)
    800051d0:	01813083          	ld	ra,24(sp)
    800051d4:	00048513          	mv	a0,s1
    800051d8:	00813483          	ld	s1,8(sp)
    800051dc:	02010113          	addi	sp,sp,32
    800051e0:	00000317          	auipc	t1,0x0
    800051e4:	3bc30067          	jr	956(t1) # 8000559c <plic_complete>
    800051e8:	00008517          	auipc	a0,0x8
    800051ec:	c2850513          	addi	a0,a0,-984 # 8000ce10 <tickslock>
    800051f0:	00001097          	auipc	ra,0x1
    800051f4:	48c080e7          	jalr	1164(ra) # 8000667c <acquire>
    800051f8:	00003717          	auipc	a4,0x3
    800051fc:	8fc70713          	addi	a4,a4,-1796 # 80007af4 <ticks>
    80005200:	00072783          	lw	a5,0(a4)
    80005204:	00008517          	auipc	a0,0x8
    80005208:	c0c50513          	addi	a0,a0,-1012 # 8000ce10 <tickslock>
    8000520c:	0017879b          	addiw	a5,a5,1
    80005210:	00f72023          	sw	a5,0(a4)
    80005214:	00001097          	auipc	ra,0x1
    80005218:	534080e7          	jalr	1332(ra) # 80006748 <release>
    8000521c:	f65ff06f          	j	80005180 <kerneltrap+0x8c>
    80005220:	00001097          	auipc	ra,0x1
    80005224:	090080e7          	jalr	144(ra) # 800062b0 <uartintr>
    80005228:	fa5ff06f          	j	800051cc <kerneltrap+0xd8>
    8000522c:	00002517          	auipc	a0,0x2
    80005230:	3ec50513          	addi	a0,a0,1004 # 80007618 <CONSOLE_STATUS+0x608>
    80005234:	00000097          	auipc	ra,0x0
    80005238:	718080e7          	jalr	1816(ra) # 8000594c <panic>

000000008000523c <clockintr>:
    8000523c:	fe010113          	addi	sp,sp,-32
    80005240:	00813823          	sd	s0,16(sp)
    80005244:	00913423          	sd	s1,8(sp)
    80005248:	00113c23          	sd	ra,24(sp)
    8000524c:	02010413          	addi	s0,sp,32
    80005250:	00008497          	auipc	s1,0x8
    80005254:	bc048493          	addi	s1,s1,-1088 # 8000ce10 <tickslock>
    80005258:	00048513          	mv	a0,s1
    8000525c:	00001097          	auipc	ra,0x1
    80005260:	420080e7          	jalr	1056(ra) # 8000667c <acquire>
    80005264:	00003717          	auipc	a4,0x3
    80005268:	89070713          	addi	a4,a4,-1904 # 80007af4 <ticks>
    8000526c:	00072783          	lw	a5,0(a4)
    80005270:	01013403          	ld	s0,16(sp)
    80005274:	01813083          	ld	ra,24(sp)
    80005278:	00048513          	mv	a0,s1
    8000527c:	0017879b          	addiw	a5,a5,1
    80005280:	00813483          	ld	s1,8(sp)
    80005284:	00f72023          	sw	a5,0(a4)
    80005288:	02010113          	addi	sp,sp,32
    8000528c:	00001317          	auipc	t1,0x1
    80005290:	4bc30067          	jr	1212(t1) # 80006748 <release>

0000000080005294 <devintr>:
    80005294:	142027f3          	csrr	a5,scause
    80005298:	00000513          	li	a0,0
    8000529c:	0007c463          	bltz	a5,800052a4 <devintr+0x10>
    800052a0:	00008067          	ret
    800052a4:	fe010113          	addi	sp,sp,-32
    800052a8:	00813823          	sd	s0,16(sp)
    800052ac:	00113c23          	sd	ra,24(sp)
    800052b0:	00913423          	sd	s1,8(sp)
    800052b4:	02010413          	addi	s0,sp,32
    800052b8:	0ff7f713          	andi	a4,a5,255
    800052bc:	00900693          	li	a3,9
    800052c0:	04d70c63          	beq	a4,a3,80005318 <devintr+0x84>
    800052c4:	fff00713          	li	a4,-1
    800052c8:	03f71713          	slli	a4,a4,0x3f
    800052cc:	00170713          	addi	a4,a4,1
    800052d0:	00e78c63          	beq	a5,a4,800052e8 <devintr+0x54>
    800052d4:	01813083          	ld	ra,24(sp)
    800052d8:	01013403          	ld	s0,16(sp)
    800052dc:	00813483          	ld	s1,8(sp)
    800052e0:	02010113          	addi	sp,sp,32
    800052e4:	00008067          	ret
    800052e8:	00000097          	auipc	ra,0x0
    800052ec:	c8c080e7          	jalr	-884(ra) # 80004f74 <cpuid>
    800052f0:	06050663          	beqz	a0,8000535c <devintr+0xc8>
    800052f4:	144027f3          	csrr	a5,sip
    800052f8:	ffd7f793          	andi	a5,a5,-3
    800052fc:	14479073          	csrw	sip,a5
    80005300:	01813083          	ld	ra,24(sp)
    80005304:	01013403          	ld	s0,16(sp)
    80005308:	00813483          	ld	s1,8(sp)
    8000530c:	00200513          	li	a0,2
    80005310:	02010113          	addi	sp,sp,32
    80005314:	00008067          	ret
    80005318:	00000097          	auipc	ra,0x0
    8000531c:	24c080e7          	jalr	588(ra) # 80005564 <plic_claim>
    80005320:	00a00793          	li	a5,10
    80005324:	00050493          	mv	s1,a0
    80005328:	06f50663          	beq	a0,a5,80005394 <devintr+0x100>
    8000532c:	00100513          	li	a0,1
    80005330:	fa0482e3          	beqz	s1,800052d4 <devintr+0x40>
    80005334:	00048593          	mv	a1,s1
    80005338:	00002517          	auipc	a0,0x2
    8000533c:	30050513          	addi	a0,a0,768 # 80007638 <CONSOLE_STATUS+0x628>
    80005340:	00000097          	auipc	ra,0x0
    80005344:	668080e7          	jalr	1640(ra) # 800059a8 <__printf>
    80005348:	00048513          	mv	a0,s1
    8000534c:	00000097          	auipc	ra,0x0
    80005350:	250080e7          	jalr	592(ra) # 8000559c <plic_complete>
    80005354:	00100513          	li	a0,1
    80005358:	f7dff06f          	j	800052d4 <devintr+0x40>
    8000535c:	00008517          	auipc	a0,0x8
    80005360:	ab450513          	addi	a0,a0,-1356 # 8000ce10 <tickslock>
    80005364:	00001097          	auipc	ra,0x1
    80005368:	318080e7          	jalr	792(ra) # 8000667c <acquire>
    8000536c:	00002717          	auipc	a4,0x2
    80005370:	78870713          	addi	a4,a4,1928 # 80007af4 <ticks>
    80005374:	00072783          	lw	a5,0(a4)
    80005378:	00008517          	auipc	a0,0x8
    8000537c:	a9850513          	addi	a0,a0,-1384 # 8000ce10 <tickslock>
    80005380:	0017879b          	addiw	a5,a5,1
    80005384:	00f72023          	sw	a5,0(a4)
    80005388:	00001097          	auipc	ra,0x1
    8000538c:	3c0080e7          	jalr	960(ra) # 80006748 <release>
    80005390:	f65ff06f          	j	800052f4 <devintr+0x60>
    80005394:	00001097          	auipc	ra,0x1
    80005398:	f1c080e7          	jalr	-228(ra) # 800062b0 <uartintr>
    8000539c:	fadff06f          	j	80005348 <devintr+0xb4>

00000000800053a0 <kernelvec>:
    800053a0:	f0010113          	addi	sp,sp,-256
    800053a4:	00113023          	sd	ra,0(sp)
    800053a8:	00213423          	sd	sp,8(sp)
    800053ac:	00313823          	sd	gp,16(sp)
    800053b0:	00413c23          	sd	tp,24(sp)
    800053b4:	02513023          	sd	t0,32(sp)
    800053b8:	02613423          	sd	t1,40(sp)
    800053bc:	02713823          	sd	t2,48(sp)
    800053c0:	02813c23          	sd	s0,56(sp)
    800053c4:	04913023          	sd	s1,64(sp)
    800053c8:	04a13423          	sd	a0,72(sp)
    800053cc:	04b13823          	sd	a1,80(sp)
    800053d0:	04c13c23          	sd	a2,88(sp)
    800053d4:	06d13023          	sd	a3,96(sp)
    800053d8:	06e13423          	sd	a4,104(sp)
    800053dc:	06f13823          	sd	a5,112(sp)
    800053e0:	07013c23          	sd	a6,120(sp)
    800053e4:	09113023          	sd	a7,128(sp)
    800053e8:	09213423          	sd	s2,136(sp)
    800053ec:	09313823          	sd	s3,144(sp)
    800053f0:	09413c23          	sd	s4,152(sp)
    800053f4:	0b513023          	sd	s5,160(sp)
    800053f8:	0b613423          	sd	s6,168(sp)
    800053fc:	0b713823          	sd	s7,176(sp)
    80005400:	0b813c23          	sd	s8,184(sp)
    80005404:	0d913023          	sd	s9,192(sp)
    80005408:	0da13423          	sd	s10,200(sp)
    8000540c:	0db13823          	sd	s11,208(sp)
    80005410:	0dc13c23          	sd	t3,216(sp)
    80005414:	0fd13023          	sd	t4,224(sp)
    80005418:	0fe13423          	sd	t5,232(sp)
    8000541c:	0ff13823          	sd	t6,240(sp)
    80005420:	cd5ff0ef          	jal	ra,800050f4 <kerneltrap>
    80005424:	00013083          	ld	ra,0(sp)
    80005428:	00813103          	ld	sp,8(sp)
    8000542c:	01013183          	ld	gp,16(sp)
    80005430:	02013283          	ld	t0,32(sp)
    80005434:	02813303          	ld	t1,40(sp)
    80005438:	03013383          	ld	t2,48(sp)
    8000543c:	03813403          	ld	s0,56(sp)
    80005440:	04013483          	ld	s1,64(sp)
    80005444:	04813503          	ld	a0,72(sp)
    80005448:	05013583          	ld	a1,80(sp)
    8000544c:	05813603          	ld	a2,88(sp)
    80005450:	06013683          	ld	a3,96(sp)
    80005454:	06813703          	ld	a4,104(sp)
    80005458:	07013783          	ld	a5,112(sp)
    8000545c:	07813803          	ld	a6,120(sp)
    80005460:	08013883          	ld	a7,128(sp)
    80005464:	08813903          	ld	s2,136(sp)
    80005468:	09013983          	ld	s3,144(sp)
    8000546c:	09813a03          	ld	s4,152(sp)
    80005470:	0a013a83          	ld	s5,160(sp)
    80005474:	0a813b03          	ld	s6,168(sp)
    80005478:	0b013b83          	ld	s7,176(sp)
    8000547c:	0b813c03          	ld	s8,184(sp)
    80005480:	0c013c83          	ld	s9,192(sp)
    80005484:	0c813d03          	ld	s10,200(sp)
    80005488:	0d013d83          	ld	s11,208(sp)
    8000548c:	0d813e03          	ld	t3,216(sp)
    80005490:	0e013e83          	ld	t4,224(sp)
    80005494:	0e813f03          	ld	t5,232(sp)
    80005498:	0f013f83          	ld	t6,240(sp)
    8000549c:	10010113          	addi	sp,sp,256
    800054a0:	10200073          	sret
    800054a4:	00000013          	nop
    800054a8:	00000013          	nop
    800054ac:	00000013          	nop

00000000800054b0 <timervec>:
    800054b0:	34051573          	csrrw	a0,mscratch,a0
    800054b4:	00b53023          	sd	a1,0(a0)
    800054b8:	00c53423          	sd	a2,8(a0)
    800054bc:	00d53823          	sd	a3,16(a0)
    800054c0:	01853583          	ld	a1,24(a0)
    800054c4:	02053603          	ld	a2,32(a0)
    800054c8:	0005b683          	ld	a3,0(a1)
    800054cc:	00c686b3          	add	a3,a3,a2
    800054d0:	00d5b023          	sd	a3,0(a1)
    800054d4:	00200593          	li	a1,2
    800054d8:	14459073          	csrw	sip,a1
    800054dc:	01053683          	ld	a3,16(a0)
    800054e0:	00853603          	ld	a2,8(a0)
    800054e4:	00053583          	ld	a1,0(a0)
    800054e8:	34051573          	csrrw	a0,mscratch,a0
    800054ec:	30200073          	mret

00000000800054f0 <plicinit>:
    800054f0:	ff010113          	addi	sp,sp,-16
    800054f4:	00813423          	sd	s0,8(sp)
    800054f8:	01010413          	addi	s0,sp,16
    800054fc:	00813403          	ld	s0,8(sp)
    80005500:	0c0007b7          	lui	a5,0xc000
    80005504:	00100713          	li	a4,1
    80005508:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000550c:	00e7a223          	sw	a4,4(a5)
    80005510:	01010113          	addi	sp,sp,16
    80005514:	00008067          	ret

0000000080005518 <plicinithart>:
    80005518:	ff010113          	addi	sp,sp,-16
    8000551c:	00813023          	sd	s0,0(sp)
    80005520:	00113423          	sd	ra,8(sp)
    80005524:	01010413          	addi	s0,sp,16
    80005528:	00000097          	auipc	ra,0x0
    8000552c:	a4c080e7          	jalr	-1460(ra) # 80004f74 <cpuid>
    80005530:	0085171b          	slliw	a4,a0,0x8
    80005534:	0c0027b7          	lui	a5,0xc002
    80005538:	00e787b3          	add	a5,a5,a4
    8000553c:	40200713          	li	a4,1026
    80005540:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005544:	00813083          	ld	ra,8(sp)
    80005548:	00013403          	ld	s0,0(sp)
    8000554c:	00d5151b          	slliw	a0,a0,0xd
    80005550:	0c2017b7          	lui	a5,0xc201
    80005554:	00a78533          	add	a0,a5,a0
    80005558:	00052023          	sw	zero,0(a0)
    8000555c:	01010113          	addi	sp,sp,16
    80005560:	00008067          	ret

0000000080005564 <plic_claim>:
    80005564:	ff010113          	addi	sp,sp,-16
    80005568:	00813023          	sd	s0,0(sp)
    8000556c:	00113423          	sd	ra,8(sp)
    80005570:	01010413          	addi	s0,sp,16
    80005574:	00000097          	auipc	ra,0x0
    80005578:	a00080e7          	jalr	-1536(ra) # 80004f74 <cpuid>
    8000557c:	00813083          	ld	ra,8(sp)
    80005580:	00013403          	ld	s0,0(sp)
    80005584:	00d5151b          	slliw	a0,a0,0xd
    80005588:	0c2017b7          	lui	a5,0xc201
    8000558c:	00a78533          	add	a0,a5,a0
    80005590:	00452503          	lw	a0,4(a0)
    80005594:	01010113          	addi	sp,sp,16
    80005598:	00008067          	ret

000000008000559c <plic_complete>:
    8000559c:	fe010113          	addi	sp,sp,-32
    800055a0:	00813823          	sd	s0,16(sp)
    800055a4:	00913423          	sd	s1,8(sp)
    800055a8:	00113c23          	sd	ra,24(sp)
    800055ac:	02010413          	addi	s0,sp,32
    800055b0:	00050493          	mv	s1,a0
    800055b4:	00000097          	auipc	ra,0x0
    800055b8:	9c0080e7          	jalr	-1600(ra) # 80004f74 <cpuid>
    800055bc:	01813083          	ld	ra,24(sp)
    800055c0:	01013403          	ld	s0,16(sp)
    800055c4:	00d5179b          	slliw	a5,a0,0xd
    800055c8:	0c201737          	lui	a4,0xc201
    800055cc:	00f707b3          	add	a5,a4,a5
    800055d0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800055d4:	00813483          	ld	s1,8(sp)
    800055d8:	02010113          	addi	sp,sp,32
    800055dc:	00008067          	ret

00000000800055e0 <consolewrite>:
    800055e0:	fb010113          	addi	sp,sp,-80
    800055e4:	04813023          	sd	s0,64(sp)
    800055e8:	04113423          	sd	ra,72(sp)
    800055ec:	02913c23          	sd	s1,56(sp)
    800055f0:	03213823          	sd	s2,48(sp)
    800055f4:	03313423          	sd	s3,40(sp)
    800055f8:	03413023          	sd	s4,32(sp)
    800055fc:	01513c23          	sd	s5,24(sp)
    80005600:	05010413          	addi	s0,sp,80
    80005604:	06c05c63          	blez	a2,8000567c <consolewrite+0x9c>
    80005608:	00060993          	mv	s3,a2
    8000560c:	00050a13          	mv	s4,a0
    80005610:	00058493          	mv	s1,a1
    80005614:	00000913          	li	s2,0
    80005618:	fff00a93          	li	s5,-1
    8000561c:	01c0006f          	j	80005638 <consolewrite+0x58>
    80005620:	fbf44503          	lbu	a0,-65(s0)
    80005624:	0019091b          	addiw	s2,s2,1
    80005628:	00148493          	addi	s1,s1,1
    8000562c:	00001097          	auipc	ra,0x1
    80005630:	a9c080e7          	jalr	-1380(ra) # 800060c8 <uartputc>
    80005634:	03298063          	beq	s3,s2,80005654 <consolewrite+0x74>
    80005638:	00048613          	mv	a2,s1
    8000563c:	00100693          	li	a3,1
    80005640:	000a0593          	mv	a1,s4
    80005644:	fbf40513          	addi	a0,s0,-65
    80005648:	00000097          	auipc	ra,0x0
    8000564c:	9e4080e7          	jalr	-1564(ra) # 8000502c <either_copyin>
    80005650:	fd5518e3          	bne	a0,s5,80005620 <consolewrite+0x40>
    80005654:	04813083          	ld	ra,72(sp)
    80005658:	04013403          	ld	s0,64(sp)
    8000565c:	03813483          	ld	s1,56(sp)
    80005660:	02813983          	ld	s3,40(sp)
    80005664:	02013a03          	ld	s4,32(sp)
    80005668:	01813a83          	ld	s5,24(sp)
    8000566c:	00090513          	mv	a0,s2
    80005670:	03013903          	ld	s2,48(sp)
    80005674:	05010113          	addi	sp,sp,80
    80005678:	00008067          	ret
    8000567c:	00000913          	li	s2,0
    80005680:	fd5ff06f          	j	80005654 <consolewrite+0x74>

0000000080005684 <consoleread>:
    80005684:	f9010113          	addi	sp,sp,-112
    80005688:	06813023          	sd	s0,96(sp)
    8000568c:	04913c23          	sd	s1,88(sp)
    80005690:	05213823          	sd	s2,80(sp)
    80005694:	05313423          	sd	s3,72(sp)
    80005698:	05413023          	sd	s4,64(sp)
    8000569c:	03513c23          	sd	s5,56(sp)
    800056a0:	03613823          	sd	s6,48(sp)
    800056a4:	03713423          	sd	s7,40(sp)
    800056a8:	03813023          	sd	s8,32(sp)
    800056ac:	06113423          	sd	ra,104(sp)
    800056b0:	01913c23          	sd	s9,24(sp)
    800056b4:	07010413          	addi	s0,sp,112
    800056b8:	00060b93          	mv	s7,a2
    800056bc:	00050913          	mv	s2,a0
    800056c0:	00058c13          	mv	s8,a1
    800056c4:	00060b1b          	sext.w	s6,a2
    800056c8:	00007497          	auipc	s1,0x7
    800056cc:	77048493          	addi	s1,s1,1904 # 8000ce38 <cons>
    800056d0:	00400993          	li	s3,4
    800056d4:	fff00a13          	li	s4,-1
    800056d8:	00a00a93          	li	s5,10
    800056dc:	05705e63          	blez	s7,80005738 <consoleread+0xb4>
    800056e0:	09c4a703          	lw	a4,156(s1)
    800056e4:	0984a783          	lw	a5,152(s1)
    800056e8:	0007071b          	sext.w	a4,a4
    800056ec:	08e78463          	beq	a5,a4,80005774 <consoleread+0xf0>
    800056f0:	07f7f713          	andi	a4,a5,127
    800056f4:	00e48733          	add	a4,s1,a4
    800056f8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800056fc:	0017869b          	addiw	a3,a5,1
    80005700:	08d4ac23          	sw	a3,152(s1)
    80005704:	00070c9b          	sext.w	s9,a4
    80005708:	0b370663          	beq	a4,s3,800057b4 <consoleread+0x130>
    8000570c:	00100693          	li	a3,1
    80005710:	f9f40613          	addi	a2,s0,-97
    80005714:	000c0593          	mv	a1,s8
    80005718:	00090513          	mv	a0,s2
    8000571c:	f8e40fa3          	sb	a4,-97(s0)
    80005720:	00000097          	auipc	ra,0x0
    80005724:	8c0080e7          	jalr	-1856(ra) # 80004fe0 <either_copyout>
    80005728:	01450863          	beq	a0,s4,80005738 <consoleread+0xb4>
    8000572c:	001c0c13          	addi	s8,s8,1
    80005730:	fffb8b9b          	addiw	s7,s7,-1
    80005734:	fb5c94e3          	bne	s9,s5,800056dc <consoleread+0x58>
    80005738:	000b851b          	sext.w	a0,s7
    8000573c:	06813083          	ld	ra,104(sp)
    80005740:	06013403          	ld	s0,96(sp)
    80005744:	05813483          	ld	s1,88(sp)
    80005748:	05013903          	ld	s2,80(sp)
    8000574c:	04813983          	ld	s3,72(sp)
    80005750:	04013a03          	ld	s4,64(sp)
    80005754:	03813a83          	ld	s5,56(sp)
    80005758:	02813b83          	ld	s7,40(sp)
    8000575c:	02013c03          	ld	s8,32(sp)
    80005760:	01813c83          	ld	s9,24(sp)
    80005764:	40ab053b          	subw	a0,s6,a0
    80005768:	03013b03          	ld	s6,48(sp)
    8000576c:	07010113          	addi	sp,sp,112
    80005770:	00008067          	ret
    80005774:	00001097          	auipc	ra,0x1
    80005778:	1d8080e7          	jalr	472(ra) # 8000694c <push_on>
    8000577c:	0984a703          	lw	a4,152(s1)
    80005780:	09c4a783          	lw	a5,156(s1)
    80005784:	0007879b          	sext.w	a5,a5
    80005788:	fef70ce3          	beq	a4,a5,80005780 <consoleread+0xfc>
    8000578c:	00001097          	auipc	ra,0x1
    80005790:	234080e7          	jalr	564(ra) # 800069c0 <pop_on>
    80005794:	0984a783          	lw	a5,152(s1)
    80005798:	07f7f713          	andi	a4,a5,127
    8000579c:	00e48733          	add	a4,s1,a4
    800057a0:	01874703          	lbu	a4,24(a4)
    800057a4:	0017869b          	addiw	a3,a5,1
    800057a8:	08d4ac23          	sw	a3,152(s1)
    800057ac:	00070c9b          	sext.w	s9,a4
    800057b0:	f5371ee3          	bne	a4,s3,8000570c <consoleread+0x88>
    800057b4:	000b851b          	sext.w	a0,s7
    800057b8:	f96bf2e3          	bgeu	s7,s6,8000573c <consoleread+0xb8>
    800057bc:	08f4ac23          	sw	a5,152(s1)
    800057c0:	f7dff06f          	j	8000573c <consoleread+0xb8>

00000000800057c4 <consputc>:
    800057c4:	10000793          	li	a5,256
    800057c8:	00f50663          	beq	a0,a5,800057d4 <consputc+0x10>
    800057cc:	00001317          	auipc	t1,0x1
    800057d0:	9f430067          	jr	-1548(t1) # 800061c0 <uartputc_sync>
    800057d4:	ff010113          	addi	sp,sp,-16
    800057d8:	00113423          	sd	ra,8(sp)
    800057dc:	00813023          	sd	s0,0(sp)
    800057e0:	01010413          	addi	s0,sp,16
    800057e4:	00800513          	li	a0,8
    800057e8:	00001097          	auipc	ra,0x1
    800057ec:	9d8080e7          	jalr	-1576(ra) # 800061c0 <uartputc_sync>
    800057f0:	02000513          	li	a0,32
    800057f4:	00001097          	auipc	ra,0x1
    800057f8:	9cc080e7          	jalr	-1588(ra) # 800061c0 <uartputc_sync>
    800057fc:	00013403          	ld	s0,0(sp)
    80005800:	00813083          	ld	ra,8(sp)
    80005804:	00800513          	li	a0,8
    80005808:	01010113          	addi	sp,sp,16
    8000580c:	00001317          	auipc	t1,0x1
    80005810:	9b430067          	jr	-1612(t1) # 800061c0 <uartputc_sync>

0000000080005814 <consoleintr>:
    80005814:	fe010113          	addi	sp,sp,-32
    80005818:	00813823          	sd	s0,16(sp)
    8000581c:	00913423          	sd	s1,8(sp)
    80005820:	01213023          	sd	s2,0(sp)
    80005824:	00113c23          	sd	ra,24(sp)
    80005828:	02010413          	addi	s0,sp,32
    8000582c:	00007917          	auipc	s2,0x7
    80005830:	60c90913          	addi	s2,s2,1548 # 8000ce38 <cons>
    80005834:	00050493          	mv	s1,a0
    80005838:	00090513          	mv	a0,s2
    8000583c:	00001097          	auipc	ra,0x1
    80005840:	e40080e7          	jalr	-448(ra) # 8000667c <acquire>
    80005844:	02048c63          	beqz	s1,8000587c <consoleintr+0x68>
    80005848:	0a092783          	lw	a5,160(s2)
    8000584c:	09892703          	lw	a4,152(s2)
    80005850:	07f00693          	li	a3,127
    80005854:	40e7873b          	subw	a4,a5,a4
    80005858:	02e6e263          	bltu	a3,a4,8000587c <consoleintr+0x68>
    8000585c:	00d00713          	li	a4,13
    80005860:	04e48063          	beq	s1,a4,800058a0 <consoleintr+0x8c>
    80005864:	07f7f713          	andi	a4,a5,127
    80005868:	00e90733          	add	a4,s2,a4
    8000586c:	0017879b          	addiw	a5,a5,1
    80005870:	0af92023          	sw	a5,160(s2)
    80005874:	00970c23          	sb	s1,24(a4)
    80005878:	08f92e23          	sw	a5,156(s2)
    8000587c:	01013403          	ld	s0,16(sp)
    80005880:	01813083          	ld	ra,24(sp)
    80005884:	00813483          	ld	s1,8(sp)
    80005888:	00013903          	ld	s2,0(sp)
    8000588c:	00007517          	auipc	a0,0x7
    80005890:	5ac50513          	addi	a0,a0,1452 # 8000ce38 <cons>
    80005894:	02010113          	addi	sp,sp,32
    80005898:	00001317          	auipc	t1,0x1
    8000589c:	eb030067          	jr	-336(t1) # 80006748 <release>
    800058a0:	00a00493          	li	s1,10
    800058a4:	fc1ff06f          	j	80005864 <consoleintr+0x50>

00000000800058a8 <consoleinit>:
    800058a8:	fe010113          	addi	sp,sp,-32
    800058ac:	00113c23          	sd	ra,24(sp)
    800058b0:	00813823          	sd	s0,16(sp)
    800058b4:	00913423          	sd	s1,8(sp)
    800058b8:	02010413          	addi	s0,sp,32
    800058bc:	00007497          	auipc	s1,0x7
    800058c0:	57c48493          	addi	s1,s1,1404 # 8000ce38 <cons>
    800058c4:	00048513          	mv	a0,s1
    800058c8:	00002597          	auipc	a1,0x2
    800058cc:	dc858593          	addi	a1,a1,-568 # 80007690 <CONSOLE_STATUS+0x680>
    800058d0:	00001097          	auipc	ra,0x1
    800058d4:	d88080e7          	jalr	-632(ra) # 80006658 <initlock>
    800058d8:	00000097          	auipc	ra,0x0
    800058dc:	7ac080e7          	jalr	1964(ra) # 80006084 <uartinit>
    800058e0:	01813083          	ld	ra,24(sp)
    800058e4:	01013403          	ld	s0,16(sp)
    800058e8:	00000797          	auipc	a5,0x0
    800058ec:	d9c78793          	addi	a5,a5,-612 # 80005684 <consoleread>
    800058f0:	0af4bc23          	sd	a5,184(s1)
    800058f4:	00000797          	auipc	a5,0x0
    800058f8:	cec78793          	addi	a5,a5,-788 # 800055e0 <consolewrite>
    800058fc:	0cf4b023          	sd	a5,192(s1)
    80005900:	00813483          	ld	s1,8(sp)
    80005904:	02010113          	addi	sp,sp,32
    80005908:	00008067          	ret

000000008000590c <console_read>:
    8000590c:	ff010113          	addi	sp,sp,-16
    80005910:	00813423          	sd	s0,8(sp)
    80005914:	01010413          	addi	s0,sp,16
    80005918:	00813403          	ld	s0,8(sp)
    8000591c:	00007317          	auipc	t1,0x7
    80005920:	5d433303          	ld	t1,1492(t1) # 8000cef0 <devsw+0x10>
    80005924:	01010113          	addi	sp,sp,16
    80005928:	00030067          	jr	t1

000000008000592c <console_write>:
    8000592c:	ff010113          	addi	sp,sp,-16
    80005930:	00813423          	sd	s0,8(sp)
    80005934:	01010413          	addi	s0,sp,16
    80005938:	00813403          	ld	s0,8(sp)
    8000593c:	00007317          	auipc	t1,0x7
    80005940:	5bc33303          	ld	t1,1468(t1) # 8000cef8 <devsw+0x18>
    80005944:	01010113          	addi	sp,sp,16
    80005948:	00030067          	jr	t1

000000008000594c <panic>:
    8000594c:	fe010113          	addi	sp,sp,-32
    80005950:	00113c23          	sd	ra,24(sp)
    80005954:	00813823          	sd	s0,16(sp)
    80005958:	00913423          	sd	s1,8(sp)
    8000595c:	02010413          	addi	s0,sp,32
    80005960:	00050493          	mv	s1,a0
    80005964:	00002517          	auipc	a0,0x2
    80005968:	d3450513          	addi	a0,a0,-716 # 80007698 <CONSOLE_STATUS+0x688>
    8000596c:	00007797          	auipc	a5,0x7
    80005970:	6207a623          	sw	zero,1580(a5) # 8000cf98 <pr+0x18>
    80005974:	00000097          	auipc	ra,0x0
    80005978:	034080e7          	jalr	52(ra) # 800059a8 <__printf>
    8000597c:	00048513          	mv	a0,s1
    80005980:	00000097          	auipc	ra,0x0
    80005984:	028080e7          	jalr	40(ra) # 800059a8 <__printf>
    80005988:	00002517          	auipc	a0,0x2
    8000598c:	9c850513          	addi	a0,a0,-1592 # 80007350 <CONSOLE_STATUS+0x340>
    80005990:	00000097          	auipc	ra,0x0
    80005994:	018080e7          	jalr	24(ra) # 800059a8 <__printf>
    80005998:	00100793          	li	a5,1
    8000599c:	00002717          	auipc	a4,0x2
    800059a0:	14f72e23          	sw	a5,348(a4) # 80007af8 <panicked>
    800059a4:	0000006f          	j	800059a4 <panic+0x58>

00000000800059a8 <__printf>:
    800059a8:	f3010113          	addi	sp,sp,-208
    800059ac:	08813023          	sd	s0,128(sp)
    800059b0:	07313423          	sd	s3,104(sp)
    800059b4:	09010413          	addi	s0,sp,144
    800059b8:	05813023          	sd	s8,64(sp)
    800059bc:	08113423          	sd	ra,136(sp)
    800059c0:	06913c23          	sd	s1,120(sp)
    800059c4:	07213823          	sd	s2,112(sp)
    800059c8:	07413023          	sd	s4,96(sp)
    800059cc:	05513c23          	sd	s5,88(sp)
    800059d0:	05613823          	sd	s6,80(sp)
    800059d4:	05713423          	sd	s7,72(sp)
    800059d8:	03913c23          	sd	s9,56(sp)
    800059dc:	03a13823          	sd	s10,48(sp)
    800059e0:	03b13423          	sd	s11,40(sp)
    800059e4:	00007317          	auipc	t1,0x7
    800059e8:	59c30313          	addi	t1,t1,1436 # 8000cf80 <pr>
    800059ec:	01832c03          	lw	s8,24(t1)
    800059f0:	00b43423          	sd	a1,8(s0)
    800059f4:	00c43823          	sd	a2,16(s0)
    800059f8:	00d43c23          	sd	a3,24(s0)
    800059fc:	02e43023          	sd	a4,32(s0)
    80005a00:	02f43423          	sd	a5,40(s0)
    80005a04:	03043823          	sd	a6,48(s0)
    80005a08:	03143c23          	sd	a7,56(s0)
    80005a0c:	00050993          	mv	s3,a0
    80005a10:	4a0c1663          	bnez	s8,80005ebc <__printf+0x514>
    80005a14:	60098c63          	beqz	s3,8000602c <__printf+0x684>
    80005a18:	0009c503          	lbu	a0,0(s3)
    80005a1c:	00840793          	addi	a5,s0,8
    80005a20:	f6f43c23          	sd	a5,-136(s0)
    80005a24:	00000493          	li	s1,0
    80005a28:	22050063          	beqz	a0,80005c48 <__printf+0x2a0>
    80005a2c:	00002a37          	lui	s4,0x2
    80005a30:	00018ab7          	lui	s5,0x18
    80005a34:	000f4b37          	lui	s6,0xf4
    80005a38:	00989bb7          	lui	s7,0x989
    80005a3c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005a40:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005a44:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005a48:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005a4c:	00148c9b          	addiw	s9,s1,1
    80005a50:	02500793          	li	a5,37
    80005a54:	01998933          	add	s2,s3,s9
    80005a58:	38f51263          	bne	a0,a5,80005ddc <__printf+0x434>
    80005a5c:	00094783          	lbu	a5,0(s2)
    80005a60:	00078c9b          	sext.w	s9,a5
    80005a64:	1e078263          	beqz	a5,80005c48 <__printf+0x2a0>
    80005a68:	0024849b          	addiw	s1,s1,2
    80005a6c:	07000713          	li	a4,112
    80005a70:	00998933          	add	s2,s3,s1
    80005a74:	38e78a63          	beq	a5,a4,80005e08 <__printf+0x460>
    80005a78:	20f76863          	bltu	a4,a5,80005c88 <__printf+0x2e0>
    80005a7c:	42a78863          	beq	a5,a0,80005eac <__printf+0x504>
    80005a80:	06400713          	li	a4,100
    80005a84:	40e79663          	bne	a5,a4,80005e90 <__printf+0x4e8>
    80005a88:	f7843783          	ld	a5,-136(s0)
    80005a8c:	0007a603          	lw	a2,0(a5)
    80005a90:	00878793          	addi	a5,a5,8
    80005a94:	f6f43c23          	sd	a5,-136(s0)
    80005a98:	42064a63          	bltz	a2,80005ecc <__printf+0x524>
    80005a9c:	00a00713          	li	a4,10
    80005aa0:	02e677bb          	remuw	a5,a2,a4
    80005aa4:	00002d97          	auipc	s11,0x2
    80005aa8:	c1cd8d93          	addi	s11,s11,-996 # 800076c0 <digits>
    80005aac:	00900593          	li	a1,9
    80005ab0:	0006051b          	sext.w	a0,a2
    80005ab4:	00000c93          	li	s9,0
    80005ab8:	02079793          	slli	a5,a5,0x20
    80005abc:	0207d793          	srli	a5,a5,0x20
    80005ac0:	00fd87b3          	add	a5,s11,a5
    80005ac4:	0007c783          	lbu	a5,0(a5)
    80005ac8:	02e656bb          	divuw	a3,a2,a4
    80005acc:	f8f40023          	sb	a5,-128(s0)
    80005ad0:	14c5d863          	bge	a1,a2,80005c20 <__printf+0x278>
    80005ad4:	06300593          	li	a1,99
    80005ad8:	00100c93          	li	s9,1
    80005adc:	02e6f7bb          	remuw	a5,a3,a4
    80005ae0:	02079793          	slli	a5,a5,0x20
    80005ae4:	0207d793          	srli	a5,a5,0x20
    80005ae8:	00fd87b3          	add	a5,s11,a5
    80005aec:	0007c783          	lbu	a5,0(a5)
    80005af0:	02e6d73b          	divuw	a4,a3,a4
    80005af4:	f8f400a3          	sb	a5,-127(s0)
    80005af8:	12a5f463          	bgeu	a1,a0,80005c20 <__printf+0x278>
    80005afc:	00a00693          	li	a3,10
    80005b00:	00900593          	li	a1,9
    80005b04:	02d777bb          	remuw	a5,a4,a3
    80005b08:	02079793          	slli	a5,a5,0x20
    80005b0c:	0207d793          	srli	a5,a5,0x20
    80005b10:	00fd87b3          	add	a5,s11,a5
    80005b14:	0007c503          	lbu	a0,0(a5)
    80005b18:	02d757bb          	divuw	a5,a4,a3
    80005b1c:	f8a40123          	sb	a0,-126(s0)
    80005b20:	48e5f263          	bgeu	a1,a4,80005fa4 <__printf+0x5fc>
    80005b24:	06300513          	li	a0,99
    80005b28:	02d7f5bb          	remuw	a1,a5,a3
    80005b2c:	02059593          	slli	a1,a1,0x20
    80005b30:	0205d593          	srli	a1,a1,0x20
    80005b34:	00bd85b3          	add	a1,s11,a1
    80005b38:	0005c583          	lbu	a1,0(a1)
    80005b3c:	02d7d7bb          	divuw	a5,a5,a3
    80005b40:	f8b401a3          	sb	a1,-125(s0)
    80005b44:	48e57263          	bgeu	a0,a4,80005fc8 <__printf+0x620>
    80005b48:	3e700513          	li	a0,999
    80005b4c:	02d7f5bb          	remuw	a1,a5,a3
    80005b50:	02059593          	slli	a1,a1,0x20
    80005b54:	0205d593          	srli	a1,a1,0x20
    80005b58:	00bd85b3          	add	a1,s11,a1
    80005b5c:	0005c583          	lbu	a1,0(a1)
    80005b60:	02d7d7bb          	divuw	a5,a5,a3
    80005b64:	f8b40223          	sb	a1,-124(s0)
    80005b68:	46e57663          	bgeu	a0,a4,80005fd4 <__printf+0x62c>
    80005b6c:	02d7f5bb          	remuw	a1,a5,a3
    80005b70:	02059593          	slli	a1,a1,0x20
    80005b74:	0205d593          	srli	a1,a1,0x20
    80005b78:	00bd85b3          	add	a1,s11,a1
    80005b7c:	0005c583          	lbu	a1,0(a1)
    80005b80:	02d7d7bb          	divuw	a5,a5,a3
    80005b84:	f8b402a3          	sb	a1,-123(s0)
    80005b88:	46ea7863          	bgeu	s4,a4,80005ff8 <__printf+0x650>
    80005b8c:	02d7f5bb          	remuw	a1,a5,a3
    80005b90:	02059593          	slli	a1,a1,0x20
    80005b94:	0205d593          	srli	a1,a1,0x20
    80005b98:	00bd85b3          	add	a1,s11,a1
    80005b9c:	0005c583          	lbu	a1,0(a1)
    80005ba0:	02d7d7bb          	divuw	a5,a5,a3
    80005ba4:	f8b40323          	sb	a1,-122(s0)
    80005ba8:	3eeaf863          	bgeu	s5,a4,80005f98 <__printf+0x5f0>
    80005bac:	02d7f5bb          	remuw	a1,a5,a3
    80005bb0:	02059593          	slli	a1,a1,0x20
    80005bb4:	0205d593          	srli	a1,a1,0x20
    80005bb8:	00bd85b3          	add	a1,s11,a1
    80005bbc:	0005c583          	lbu	a1,0(a1)
    80005bc0:	02d7d7bb          	divuw	a5,a5,a3
    80005bc4:	f8b403a3          	sb	a1,-121(s0)
    80005bc8:	42eb7e63          	bgeu	s6,a4,80006004 <__printf+0x65c>
    80005bcc:	02d7f5bb          	remuw	a1,a5,a3
    80005bd0:	02059593          	slli	a1,a1,0x20
    80005bd4:	0205d593          	srli	a1,a1,0x20
    80005bd8:	00bd85b3          	add	a1,s11,a1
    80005bdc:	0005c583          	lbu	a1,0(a1)
    80005be0:	02d7d7bb          	divuw	a5,a5,a3
    80005be4:	f8b40423          	sb	a1,-120(s0)
    80005be8:	42ebfc63          	bgeu	s7,a4,80006020 <__printf+0x678>
    80005bec:	02079793          	slli	a5,a5,0x20
    80005bf0:	0207d793          	srli	a5,a5,0x20
    80005bf4:	00fd8db3          	add	s11,s11,a5
    80005bf8:	000dc703          	lbu	a4,0(s11)
    80005bfc:	00a00793          	li	a5,10
    80005c00:	00900c93          	li	s9,9
    80005c04:	f8e404a3          	sb	a4,-119(s0)
    80005c08:	00065c63          	bgez	a2,80005c20 <__printf+0x278>
    80005c0c:	f9040713          	addi	a4,s0,-112
    80005c10:	00f70733          	add	a4,a4,a5
    80005c14:	02d00693          	li	a3,45
    80005c18:	fed70823          	sb	a3,-16(a4)
    80005c1c:	00078c93          	mv	s9,a5
    80005c20:	f8040793          	addi	a5,s0,-128
    80005c24:	01978cb3          	add	s9,a5,s9
    80005c28:	f7f40d13          	addi	s10,s0,-129
    80005c2c:	000cc503          	lbu	a0,0(s9)
    80005c30:	fffc8c93          	addi	s9,s9,-1
    80005c34:	00000097          	auipc	ra,0x0
    80005c38:	b90080e7          	jalr	-1136(ra) # 800057c4 <consputc>
    80005c3c:	ffac98e3          	bne	s9,s10,80005c2c <__printf+0x284>
    80005c40:	00094503          	lbu	a0,0(s2)
    80005c44:	e00514e3          	bnez	a0,80005a4c <__printf+0xa4>
    80005c48:	1a0c1663          	bnez	s8,80005df4 <__printf+0x44c>
    80005c4c:	08813083          	ld	ra,136(sp)
    80005c50:	08013403          	ld	s0,128(sp)
    80005c54:	07813483          	ld	s1,120(sp)
    80005c58:	07013903          	ld	s2,112(sp)
    80005c5c:	06813983          	ld	s3,104(sp)
    80005c60:	06013a03          	ld	s4,96(sp)
    80005c64:	05813a83          	ld	s5,88(sp)
    80005c68:	05013b03          	ld	s6,80(sp)
    80005c6c:	04813b83          	ld	s7,72(sp)
    80005c70:	04013c03          	ld	s8,64(sp)
    80005c74:	03813c83          	ld	s9,56(sp)
    80005c78:	03013d03          	ld	s10,48(sp)
    80005c7c:	02813d83          	ld	s11,40(sp)
    80005c80:	0d010113          	addi	sp,sp,208
    80005c84:	00008067          	ret
    80005c88:	07300713          	li	a4,115
    80005c8c:	1ce78a63          	beq	a5,a4,80005e60 <__printf+0x4b8>
    80005c90:	07800713          	li	a4,120
    80005c94:	1ee79e63          	bne	a5,a4,80005e90 <__printf+0x4e8>
    80005c98:	f7843783          	ld	a5,-136(s0)
    80005c9c:	0007a703          	lw	a4,0(a5)
    80005ca0:	00878793          	addi	a5,a5,8
    80005ca4:	f6f43c23          	sd	a5,-136(s0)
    80005ca8:	28074263          	bltz	a4,80005f2c <__printf+0x584>
    80005cac:	00002d97          	auipc	s11,0x2
    80005cb0:	a14d8d93          	addi	s11,s11,-1516 # 800076c0 <digits>
    80005cb4:	00f77793          	andi	a5,a4,15
    80005cb8:	00fd87b3          	add	a5,s11,a5
    80005cbc:	0007c683          	lbu	a3,0(a5)
    80005cc0:	00f00613          	li	a2,15
    80005cc4:	0007079b          	sext.w	a5,a4
    80005cc8:	f8d40023          	sb	a3,-128(s0)
    80005ccc:	0047559b          	srliw	a1,a4,0x4
    80005cd0:	0047569b          	srliw	a3,a4,0x4
    80005cd4:	00000c93          	li	s9,0
    80005cd8:	0ee65063          	bge	a2,a4,80005db8 <__printf+0x410>
    80005cdc:	00f6f693          	andi	a3,a3,15
    80005ce0:	00dd86b3          	add	a3,s11,a3
    80005ce4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005ce8:	0087d79b          	srliw	a5,a5,0x8
    80005cec:	00100c93          	li	s9,1
    80005cf0:	f8d400a3          	sb	a3,-127(s0)
    80005cf4:	0cb67263          	bgeu	a2,a1,80005db8 <__printf+0x410>
    80005cf8:	00f7f693          	andi	a3,a5,15
    80005cfc:	00dd86b3          	add	a3,s11,a3
    80005d00:	0006c583          	lbu	a1,0(a3)
    80005d04:	00f00613          	li	a2,15
    80005d08:	0047d69b          	srliw	a3,a5,0x4
    80005d0c:	f8b40123          	sb	a1,-126(s0)
    80005d10:	0047d593          	srli	a1,a5,0x4
    80005d14:	28f67e63          	bgeu	a2,a5,80005fb0 <__printf+0x608>
    80005d18:	00f6f693          	andi	a3,a3,15
    80005d1c:	00dd86b3          	add	a3,s11,a3
    80005d20:	0006c503          	lbu	a0,0(a3)
    80005d24:	0087d813          	srli	a6,a5,0x8
    80005d28:	0087d69b          	srliw	a3,a5,0x8
    80005d2c:	f8a401a3          	sb	a0,-125(s0)
    80005d30:	28b67663          	bgeu	a2,a1,80005fbc <__printf+0x614>
    80005d34:	00f6f693          	andi	a3,a3,15
    80005d38:	00dd86b3          	add	a3,s11,a3
    80005d3c:	0006c583          	lbu	a1,0(a3)
    80005d40:	00c7d513          	srli	a0,a5,0xc
    80005d44:	00c7d69b          	srliw	a3,a5,0xc
    80005d48:	f8b40223          	sb	a1,-124(s0)
    80005d4c:	29067a63          	bgeu	a2,a6,80005fe0 <__printf+0x638>
    80005d50:	00f6f693          	andi	a3,a3,15
    80005d54:	00dd86b3          	add	a3,s11,a3
    80005d58:	0006c583          	lbu	a1,0(a3)
    80005d5c:	0107d813          	srli	a6,a5,0x10
    80005d60:	0107d69b          	srliw	a3,a5,0x10
    80005d64:	f8b402a3          	sb	a1,-123(s0)
    80005d68:	28a67263          	bgeu	a2,a0,80005fec <__printf+0x644>
    80005d6c:	00f6f693          	andi	a3,a3,15
    80005d70:	00dd86b3          	add	a3,s11,a3
    80005d74:	0006c683          	lbu	a3,0(a3)
    80005d78:	0147d79b          	srliw	a5,a5,0x14
    80005d7c:	f8d40323          	sb	a3,-122(s0)
    80005d80:	21067663          	bgeu	a2,a6,80005f8c <__printf+0x5e4>
    80005d84:	02079793          	slli	a5,a5,0x20
    80005d88:	0207d793          	srli	a5,a5,0x20
    80005d8c:	00fd8db3          	add	s11,s11,a5
    80005d90:	000dc683          	lbu	a3,0(s11)
    80005d94:	00800793          	li	a5,8
    80005d98:	00700c93          	li	s9,7
    80005d9c:	f8d403a3          	sb	a3,-121(s0)
    80005da0:	00075c63          	bgez	a4,80005db8 <__printf+0x410>
    80005da4:	f9040713          	addi	a4,s0,-112
    80005da8:	00f70733          	add	a4,a4,a5
    80005dac:	02d00693          	li	a3,45
    80005db0:	fed70823          	sb	a3,-16(a4)
    80005db4:	00078c93          	mv	s9,a5
    80005db8:	f8040793          	addi	a5,s0,-128
    80005dbc:	01978cb3          	add	s9,a5,s9
    80005dc0:	f7f40d13          	addi	s10,s0,-129
    80005dc4:	000cc503          	lbu	a0,0(s9)
    80005dc8:	fffc8c93          	addi	s9,s9,-1
    80005dcc:	00000097          	auipc	ra,0x0
    80005dd0:	9f8080e7          	jalr	-1544(ra) # 800057c4 <consputc>
    80005dd4:	ff9d18e3          	bne	s10,s9,80005dc4 <__printf+0x41c>
    80005dd8:	0100006f          	j	80005de8 <__printf+0x440>
    80005ddc:	00000097          	auipc	ra,0x0
    80005de0:	9e8080e7          	jalr	-1560(ra) # 800057c4 <consputc>
    80005de4:	000c8493          	mv	s1,s9
    80005de8:	00094503          	lbu	a0,0(s2)
    80005dec:	c60510e3          	bnez	a0,80005a4c <__printf+0xa4>
    80005df0:	e40c0ee3          	beqz	s8,80005c4c <__printf+0x2a4>
    80005df4:	00007517          	auipc	a0,0x7
    80005df8:	18c50513          	addi	a0,a0,396 # 8000cf80 <pr>
    80005dfc:	00001097          	auipc	ra,0x1
    80005e00:	94c080e7          	jalr	-1716(ra) # 80006748 <release>
    80005e04:	e49ff06f          	j	80005c4c <__printf+0x2a4>
    80005e08:	f7843783          	ld	a5,-136(s0)
    80005e0c:	03000513          	li	a0,48
    80005e10:	01000d13          	li	s10,16
    80005e14:	00878713          	addi	a4,a5,8
    80005e18:	0007bc83          	ld	s9,0(a5)
    80005e1c:	f6e43c23          	sd	a4,-136(s0)
    80005e20:	00000097          	auipc	ra,0x0
    80005e24:	9a4080e7          	jalr	-1628(ra) # 800057c4 <consputc>
    80005e28:	07800513          	li	a0,120
    80005e2c:	00000097          	auipc	ra,0x0
    80005e30:	998080e7          	jalr	-1640(ra) # 800057c4 <consputc>
    80005e34:	00002d97          	auipc	s11,0x2
    80005e38:	88cd8d93          	addi	s11,s11,-1908 # 800076c0 <digits>
    80005e3c:	03ccd793          	srli	a5,s9,0x3c
    80005e40:	00fd87b3          	add	a5,s11,a5
    80005e44:	0007c503          	lbu	a0,0(a5)
    80005e48:	fffd0d1b          	addiw	s10,s10,-1
    80005e4c:	004c9c93          	slli	s9,s9,0x4
    80005e50:	00000097          	auipc	ra,0x0
    80005e54:	974080e7          	jalr	-1676(ra) # 800057c4 <consputc>
    80005e58:	fe0d12e3          	bnez	s10,80005e3c <__printf+0x494>
    80005e5c:	f8dff06f          	j	80005de8 <__printf+0x440>
    80005e60:	f7843783          	ld	a5,-136(s0)
    80005e64:	0007bc83          	ld	s9,0(a5)
    80005e68:	00878793          	addi	a5,a5,8
    80005e6c:	f6f43c23          	sd	a5,-136(s0)
    80005e70:	000c9a63          	bnez	s9,80005e84 <__printf+0x4dc>
    80005e74:	1080006f          	j	80005f7c <__printf+0x5d4>
    80005e78:	001c8c93          	addi	s9,s9,1
    80005e7c:	00000097          	auipc	ra,0x0
    80005e80:	948080e7          	jalr	-1720(ra) # 800057c4 <consputc>
    80005e84:	000cc503          	lbu	a0,0(s9)
    80005e88:	fe0518e3          	bnez	a0,80005e78 <__printf+0x4d0>
    80005e8c:	f5dff06f          	j	80005de8 <__printf+0x440>
    80005e90:	02500513          	li	a0,37
    80005e94:	00000097          	auipc	ra,0x0
    80005e98:	930080e7          	jalr	-1744(ra) # 800057c4 <consputc>
    80005e9c:	000c8513          	mv	a0,s9
    80005ea0:	00000097          	auipc	ra,0x0
    80005ea4:	924080e7          	jalr	-1756(ra) # 800057c4 <consputc>
    80005ea8:	f41ff06f          	j	80005de8 <__printf+0x440>
    80005eac:	02500513          	li	a0,37
    80005eb0:	00000097          	auipc	ra,0x0
    80005eb4:	914080e7          	jalr	-1772(ra) # 800057c4 <consputc>
    80005eb8:	f31ff06f          	j	80005de8 <__printf+0x440>
    80005ebc:	00030513          	mv	a0,t1
    80005ec0:	00000097          	auipc	ra,0x0
    80005ec4:	7bc080e7          	jalr	1980(ra) # 8000667c <acquire>
    80005ec8:	b4dff06f          	j	80005a14 <__printf+0x6c>
    80005ecc:	40c0053b          	negw	a0,a2
    80005ed0:	00a00713          	li	a4,10
    80005ed4:	02e576bb          	remuw	a3,a0,a4
    80005ed8:	00001d97          	auipc	s11,0x1
    80005edc:	7e8d8d93          	addi	s11,s11,2024 # 800076c0 <digits>
    80005ee0:	ff700593          	li	a1,-9
    80005ee4:	02069693          	slli	a3,a3,0x20
    80005ee8:	0206d693          	srli	a3,a3,0x20
    80005eec:	00dd86b3          	add	a3,s11,a3
    80005ef0:	0006c683          	lbu	a3,0(a3)
    80005ef4:	02e557bb          	divuw	a5,a0,a4
    80005ef8:	f8d40023          	sb	a3,-128(s0)
    80005efc:	10b65e63          	bge	a2,a1,80006018 <__printf+0x670>
    80005f00:	06300593          	li	a1,99
    80005f04:	02e7f6bb          	remuw	a3,a5,a4
    80005f08:	02069693          	slli	a3,a3,0x20
    80005f0c:	0206d693          	srli	a3,a3,0x20
    80005f10:	00dd86b3          	add	a3,s11,a3
    80005f14:	0006c683          	lbu	a3,0(a3)
    80005f18:	02e7d73b          	divuw	a4,a5,a4
    80005f1c:	00200793          	li	a5,2
    80005f20:	f8d400a3          	sb	a3,-127(s0)
    80005f24:	bca5ece3          	bltu	a1,a0,80005afc <__printf+0x154>
    80005f28:	ce5ff06f          	j	80005c0c <__printf+0x264>
    80005f2c:	40e007bb          	negw	a5,a4
    80005f30:	00001d97          	auipc	s11,0x1
    80005f34:	790d8d93          	addi	s11,s11,1936 # 800076c0 <digits>
    80005f38:	00f7f693          	andi	a3,a5,15
    80005f3c:	00dd86b3          	add	a3,s11,a3
    80005f40:	0006c583          	lbu	a1,0(a3)
    80005f44:	ff100613          	li	a2,-15
    80005f48:	0047d69b          	srliw	a3,a5,0x4
    80005f4c:	f8b40023          	sb	a1,-128(s0)
    80005f50:	0047d59b          	srliw	a1,a5,0x4
    80005f54:	0ac75e63          	bge	a4,a2,80006010 <__printf+0x668>
    80005f58:	00f6f693          	andi	a3,a3,15
    80005f5c:	00dd86b3          	add	a3,s11,a3
    80005f60:	0006c603          	lbu	a2,0(a3)
    80005f64:	00f00693          	li	a3,15
    80005f68:	0087d79b          	srliw	a5,a5,0x8
    80005f6c:	f8c400a3          	sb	a2,-127(s0)
    80005f70:	d8b6e4e3          	bltu	a3,a1,80005cf8 <__printf+0x350>
    80005f74:	00200793          	li	a5,2
    80005f78:	e2dff06f          	j	80005da4 <__printf+0x3fc>
    80005f7c:	00001c97          	auipc	s9,0x1
    80005f80:	724c8c93          	addi	s9,s9,1828 # 800076a0 <CONSOLE_STATUS+0x690>
    80005f84:	02800513          	li	a0,40
    80005f88:	ef1ff06f          	j	80005e78 <__printf+0x4d0>
    80005f8c:	00700793          	li	a5,7
    80005f90:	00600c93          	li	s9,6
    80005f94:	e0dff06f          	j	80005da0 <__printf+0x3f8>
    80005f98:	00700793          	li	a5,7
    80005f9c:	00600c93          	li	s9,6
    80005fa0:	c69ff06f          	j	80005c08 <__printf+0x260>
    80005fa4:	00300793          	li	a5,3
    80005fa8:	00200c93          	li	s9,2
    80005fac:	c5dff06f          	j	80005c08 <__printf+0x260>
    80005fb0:	00300793          	li	a5,3
    80005fb4:	00200c93          	li	s9,2
    80005fb8:	de9ff06f          	j	80005da0 <__printf+0x3f8>
    80005fbc:	00400793          	li	a5,4
    80005fc0:	00300c93          	li	s9,3
    80005fc4:	dddff06f          	j	80005da0 <__printf+0x3f8>
    80005fc8:	00400793          	li	a5,4
    80005fcc:	00300c93          	li	s9,3
    80005fd0:	c39ff06f          	j	80005c08 <__printf+0x260>
    80005fd4:	00500793          	li	a5,5
    80005fd8:	00400c93          	li	s9,4
    80005fdc:	c2dff06f          	j	80005c08 <__printf+0x260>
    80005fe0:	00500793          	li	a5,5
    80005fe4:	00400c93          	li	s9,4
    80005fe8:	db9ff06f          	j	80005da0 <__printf+0x3f8>
    80005fec:	00600793          	li	a5,6
    80005ff0:	00500c93          	li	s9,5
    80005ff4:	dadff06f          	j	80005da0 <__printf+0x3f8>
    80005ff8:	00600793          	li	a5,6
    80005ffc:	00500c93          	li	s9,5
    80006000:	c09ff06f          	j	80005c08 <__printf+0x260>
    80006004:	00800793          	li	a5,8
    80006008:	00700c93          	li	s9,7
    8000600c:	bfdff06f          	j	80005c08 <__printf+0x260>
    80006010:	00100793          	li	a5,1
    80006014:	d91ff06f          	j	80005da4 <__printf+0x3fc>
    80006018:	00100793          	li	a5,1
    8000601c:	bf1ff06f          	j	80005c0c <__printf+0x264>
    80006020:	00900793          	li	a5,9
    80006024:	00800c93          	li	s9,8
    80006028:	be1ff06f          	j	80005c08 <__printf+0x260>
    8000602c:	00001517          	auipc	a0,0x1
    80006030:	67c50513          	addi	a0,a0,1660 # 800076a8 <CONSOLE_STATUS+0x698>
    80006034:	00000097          	auipc	ra,0x0
    80006038:	918080e7          	jalr	-1768(ra) # 8000594c <panic>

000000008000603c <printfinit>:
    8000603c:	fe010113          	addi	sp,sp,-32
    80006040:	00813823          	sd	s0,16(sp)
    80006044:	00913423          	sd	s1,8(sp)
    80006048:	00113c23          	sd	ra,24(sp)
    8000604c:	02010413          	addi	s0,sp,32
    80006050:	00007497          	auipc	s1,0x7
    80006054:	f3048493          	addi	s1,s1,-208 # 8000cf80 <pr>
    80006058:	00048513          	mv	a0,s1
    8000605c:	00001597          	auipc	a1,0x1
    80006060:	65c58593          	addi	a1,a1,1628 # 800076b8 <CONSOLE_STATUS+0x6a8>
    80006064:	00000097          	auipc	ra,0x0
    80006068:	5f4080e7          	jalr	1524(ra) # 80006658 <initlock>
    8000606c:	01813083          	ld	ra,24(sp)
    80006070:	01013403          	ld	s0,16(sp)
    80006074:	0004ac23          	sw	zero,24(s1)
    80006078:	00813483          	ld	s1,8(sp)
    8000607c:	02010113          	addi	sp,sp,32
    80006080:	00008067          	ret

0000000080006084 <uartinit>:
    80006084:	ff010113          	addi	sp,sp,-16
    80006088:	00813423          	sd	s0,8(sp)
    8000608c:	01010413          	addi	s0,sp,16
    80006090:	100007b7          	lui	a5,0x10000
    80006094:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006098:	f8000713          	li	a4,-128
    8000609c:	00e781a3          	sb	a4,3(a5)
    800060a0:	00300713          	li	a4,3
    800060a4:	00e78023          	sb	a4,0(a5)
    800060a8:	000780a3          	sb	zero,1(a5)
    800060ac:	00e781a3          	sb	a4,3(a5)
    800060b0:	00700693          	li	a3,7
    800060b4:	00d78123          	sb	a3,2(a5)
    800060b8:	00e780a3          	sb	a4,1(a5)
    800060bc:	00813403          	ld	s0,8(sp)
    800060c0:	01010113          	addi	sp,sp,16
    800060c4:	00008067          	ret

00000000800060c8 <uartputc>:
    800060c8:	00002797          	auipc	a5,0x2
    800060cc:	a307a783          	lw	a5,-1488(a5) # 80007af8 <panicked>
    800060d0:	00078463          	beqz	a5,800060d8 <uartputc+0x10>
    800060d4:	0000006f          	j	800060d4 <uartputc+0xc>
    800060d8:	fd010113          	addi	sp,sp,-48
    800060dc:	02813023          	sd	s0,32(sp)
    800060e0:	00913c23          	sd	s1,24(sp)
    800060e4:	01213823          	sd	s2,16(sp)
    800060e8:	01313423          	sd	s3,8(sp)
    800060ec:	02113423          	sd	ra,40(sp)
    800060f0:	03010413          	addi	s0,sp,48
    800060f4:	00002917          	auipc	s2,0x2
    800060f8:	a0c90913          	addi	s2,s2,-1524 # 80007b00 <uart_tx_r>
    800060fc:	00093783          	ld	a5,0(s2)
    80006100:	00002497          	auipc	s1,0x2
    80006104:	a0848493          	addi	s1,s1,-1528 # 80007b08 <uart_tx_w>
    80006108:	0004b703          	ld	a4,0(s1)
    8000610c:	02078693          	addi	a3,a5,32
    80006110:	00050993          	mv	s3,a0
    80006114:	02e69c63          	bne	a3,a4,8000614c <uartputc+0x84>
    80006118:	00001097          	auipc	ra,0x1
    8000611c:	834080e7          	jalr	-1996(ra) # 8000694c <push_on>
    80006120:	00093783          	ld	a5,0(s2)
    80006124:	0004b703          	ld	a4,0(s1)
    80006128:	02078793          	addi	a5,a5,32
    8000612c:	00e79463          	bne	a5,a4,80006134 <uartputc+0x6c>
    80006130:	0000006f          	j	80006130 <uartputc+0x68>
    80006134:	00001097          	auipc	ra,0x1
    80006138:	88c080e7          	jalr	-1908(ra) # 800069c0 <pop_on>
    8000613c:	00093783          	ld	a5,0(s2)
    80006140:	0004b703          	ld	a4,0(s1)
    80006144:	02078693          	addi	a3,a5,32
    80006148:	fce688e3          	beq	a3,a4,80006118 <uartputc+0x50>
    8000614c:	01f77693          	andi	a3,a4,31
    80006150:	00007597          	auipc	a1,0x7
    80006154:	e5058593          	addi	a1,a1,-432 # 8000cfa0 <uart_tx_buf>
    80006158:	00d586b3          	add	a3,a1,a3
    8000615c:	00170713          	addi	a4,a4,1
    80006160:	01368023          	sb	s3,0(a3)
    80006164:	00e4b023          	sd	a4,0(s1)
    80006168:	10000637          	lui	a2,0x10000
    8000616c:	02f71063          	bne	a4,a5,8000618c <uartputc+0xc4>
    80006170:	0340006f          	j	800061a4 <uartputc+0xdc>
    80006174:	00074703          	lbu	a4,0(a4)
    80006178:	00f93023          	sd	a5,0(s2)
    8000617c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006180:	00093783          	ld	a5,0(s2)
    80006184:	0004b703          	ld	a4,0(s1)
    80006188:	00f70e63          	beq	a4,a5,800061a4 <uartputc+0xdc>
    8000618c:	00564683          	lbu	a3,5(a2)
    80006190:	01f7f713          	andi	a4,a5,31
    80006194:	00e58733          	add	a4,a1,a4
    80006198:	0206f693          	andi	a3,a3,32
    8000619c:	00178793          	addi	a5,a5,1
    800061a0:	fc069ae3          	bnez	a3,80006174 <uartputc+0xac>
    800061a4:	02813083          	ld	ra,40(sp)
    800061a8:	02013403          	ld	s0,32(sp)
    800061ac:	01813483          	ld	s1,24(sp)
    800061b0:	01013903          	ld	s2,16(sp)
    800061b4:	00813983          	ld	s3,8(sp)
    800061b8:	03010113          	addi	sp,sp,48
    800061bc:	00008067          	ret

00000000800061c0 <uartputc_sync>:
    800061c0:	ff010113          	addi	sp,sp,-16
    800061c4:	00813423          	sd	s0,8(sp)
    800061c8:	01010413          	addi	s0,sp,16
    800061cc:	00002717          	auipc	a4,0x2
    800061d0:	92c72703          	lw	a4,-1748(a4) # 80007af8 <panicked>
    800061d4:	02071663          	bnez	a4,80006200 <uartputc_sync+0x40>
    800061d8:	00050793          	mv	a5,a0
    800061dc:	100006b7          	lui	a3,0x10000
    800061e0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800061e4:	02077713          	andi	a4,a4,32
    800061e8:	fe070ce3          	beqz	a4,800061e0 <uartputc_sync+0x20>
    800061ec:	0ff7f793          	andi	a5,a5,255
    800061f0:	00f68023          	sb	a5,0(a3)
    800061f4:	00813403          	ld	s0,8(sp)
    800061f8:	01010113          	addi	sp,sp,16
    800061fc:	00008067          	ret
    80006200:	0000006f          	j	80006200 <uartputc_sync+0x40>

0000000080006204 <uartstart>:
    80006204:	ff010113          	addi	sp,sp,-16
    80006208:	00813423          	sd	s0,8(sp)
    8000620c:	01010413          	addi	s0,sp,16
    80006210:	00002617          	auipc	a2,0x2
    80006214:	8f060613          	addi	a2,a2,-1808 # 80007b00 <uart_tx_r>
    80006218:	00002517          	auipc	a0,0x2
    8000621c:	8f050513          	addi	a0,a0,-1808 # 80007b08 <uart_tx_w>
    80006220:	00063783          	ld	a5,0(a2)
    80006224:	00053703          	ld	a4,0(a0)
    80006228:	04f70263          	beq	a4,a5,8000626c <uartstart+0x68>
    8000622c:	100005b7          	lui	a1,0x10000
    80006230:	00007817          	auipc	a6,0x7
    80006234:	d7080813          	addi	a6,a6,-656 # 8000cfa0 <uart_tx_buf>
    80006238:	01c0006f          	j	80006254 <uartstart+0x50>
    8000623c:	0006c703          	lbu	a4,0(a3)
    80006240:	00f63023          	sd	a5,0(a2)
    80006244:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006248:	00063783          	ld	a5,0(a2)
    8000624c:	00053703          	ld	a4,0(a0)
    80006250:	00f70e63          	beq	a4,a5,8000626c <uartstart+0x68>
    80006254:	01f7f713          	andi	a4,a5,31
    80006258:	00e806b3          	add	a3,a6,a4
    8000625c:	0055c703          	lbu	a4,5(a1)
    80006260:	00178793          	addi	a5,a5,1
    80006264:	02077713          	andi	a4,a4,32
    80006268:	fc071ae3          	bnez	a4,8000623c <uartstart+0x38>
    8000626c:	00813403          	ld	s0,8(sp)
    80006270:	01010113          	addi	sp,sp,16
    80006274:	00008067          	ret

0000000080006278 <uartgetc>:
    80006278:	ff010113          	addi	sp,sp,-16
    8000627c:	00813423          	sd	s0,8(sp)
    80006280:	01010413          	addi	s0,sp,16
    80006284:	10000737          	lui	a4,0x10000
    80006288:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000628c:	0017f793          	andi	a5,a5,1
    80006290:	00078c63          	beqz	a5,800062a8 <uartgetc+0x30>
    80006294:	00074503          	lbu	a0,0(a4)
    80006298:	0ff57513          	andi	a0,a0,255
    8000629c:	00813403          	ld	s0,8(sp)
    800062a0:	01010113          	addi	sp,sp,16
    800062a4:	00008067          	ret
    800062a8:	fff00513          	li	a0,-1
    800062ac:	ff1ff06f          	j	8000629c <uartgetc+0x24>

00000000800062b0 <uartintr>:
    800062b0:	100007b7          	lui	a5,0x10000
    800062b4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800062b8:	0017f793          	andi	a5,a5,1
    800062bc:	0a078463          	beqz	a5,80006364 <uartintr+0xb4>
    800062c0:	fe010113          	addi	sp,sp,-32
    800062c4:	00813823          	sd	s0,16(sp)
    800062c8:	00913423          	sd	s1,8(sp)
    800062cc:	00113c23          	sd	ra,24(sp)
    800062d0:	02010413          	addi	s0,sp,32
    800062d4:	100004b7          	lui	s1,0x10000
    800062d8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800062dc:	0ff57513          	andi	a0,a0,255
    800062e0:	fffff097          	auipc	ra,0xfffff
    800062e4:	534080e7          	jalr	1332(ra) # 80005814 <consoleintr>
    800062e8:	0054c783          	lbu	a5,5(s1)
    800062ec:	0017f793          	andi	a5,a5,1
    800062f0:	fe0794e3          	bnez	a5,800062d8 <uartintr+0x28>
    800062f4:	00002617          	auipc	a2,0x2
    800062f8:	80c60613          	addi	a2,a2,-2036 # 80007b00 <uart_tx_r>
    800062fc:	00002517          	auipc	a0,0x2
    80006300:	80c50513          	addi	a0,a0,-2036 # 80007b08 <uart_tx_w>
    80006304:	00063783          	ld	a5,0(a2)
    80006308:	00053703          	ld	a4,0(a0)
    8000630c:	04f70263          	beq	a4,a5,80006350 <uartintr+0xa0>
    80006310:	100005b7          	lui	a1,0x10000
    80006314:	00007817          	auipc	a6,0x7
    80006318:	c8c80813          	addi	a6,a6,-884 # 8000cfa0 <uart_tx_buf>
    8000631c:	01c0006f          	j	80006338 <uartintr+0x88>
    80006320:	0006c703          	lbu	a4,0(a3)
    80006324:	00f63023          	sd	a5,0(a2)
    80006328:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000632c:	00063783          	ld	a5,0(a2)
    80006330:	00053703          	ld	a4,0(a0)
    80006334:	00f70e63          	beq	a4,a5,80006350 <uartintr+0xa0>
    80006338:	01f7f713          	andi	a4,a5,31
    8000633c:	00e806b3          	add	a3,a6,a4
    80006340:	0055c703          	lbu	a4,5(a1)
    80006344:	00178793          	addi	a5,a5,1
    80006348:	02077713          	andi	a4,a4,32
    8000634c:	fc071ae3          	bnez	a4,80006320 <uartintr+0x70>
    80006350:	01813083          	ld	ra,24(sp)
    80006354:	01013403          	ld	s0,16(sp)
    80006358:	00813483          	ld	s1,8(sp)
    8000635c:	02010113          	addi	sp,sp,32
    80006360:	00008067          	ret
    80006364:	00001617          	auipc	a2,0x1
    80006368:	79c60613          	addi	a2,a2,1948 # 80007b00 <uart_tx_r>
    8000636c:	00001517          	auipc	a0,0x1
    80006370:	79c50513          	addi	a0,a0,1948 # 80007b08 <uart_tx_w>
    80006374:	00063783          	ld	a5,0(a2)
    80006378:	00053703          	ld	a4,0(a0)
    8000637c:	04f70263          	beq	a4,a5,800063c0 <uartintr+0x110>
    80006380:	100005b7          	lui	a1,0x10000
    80006384:	00007817          	auipc	a6,0x7
    80006388:	c1c80813          	addi	a6,a6,-996 # 8000cfa0 <uart_tx_buf>
    8000638c:	01c0006f          	j	800063a8 <uartintr+0xf8>
    80006390:	0006c703          	lbu	a4,0(a3)
    80006394:	00f63023          	sd	a5,0(a2)
    80006398:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000639c:	00063783          	ld	a5,0(a2)
    800063a0:	00053703          	ld	a4,0(a0)
    800063a4:	02f70063          	beq	a4,a5,800063c4 <uartintr+0x114>
    800063a8:	01f7f713          	andi	a4,a5,31
    800063ac:	00e806b3          	add	a3,a6,a4
    800063b0:	0055c703          	lbu	a4,5(a1)
    800063b4:	00178793          	addi	a5,a5,1
    800063b8:	02077713          	andi	a4,a4,32
    800063bc:	fc071ae3          	bnez	a4,80006390 <uartintr+0xe0>
    800063c0:	00008067          	ret
    800063c4:	00008067          	ret

00000000800063c8 <kinit>:
    800063c8:	fc010113          	addi	sp,sp,-64
    800063cc:	02913423          	sd	s1,40(sp)
    800063d0:	fffff7b7          	lui	a5,0xfffff
    800063d4:	0000d497          	auipc	s1,0xd
    800063d8:	c2b48493          	addi	s1,s1,-981 # 80012fff <end+0xfff>
    800063dc:	02813823          	sd	s0,48(sp)
    800063e0:	01313c23          	sd	s3,24(sp)
    800063e4:	00f4f4b3          	and	s1,s1,a5
    800063e8:	02113c23          	sd	ra,56(sp)
    800063ec:	03213023          	sd	s2,32(sp)
    800063f0:	01413823          	sd	s4,16(sp)
    800063f4:	01513423          	sd	s5,8(sp)
    800063f8:	04010413          	addi	s0,sp,64
    800063fc:	000017b7          	lui	a5,0x1
    80006400:	01100993          	li	s3,17
    80006404:	00f487b3          	add	a5,s1,a5
    80006408:	01b99993          	slli	s3,s3,0x1b
    8000640c:	06f9e063          	bltu	s3,a5,8000646c <kinit+0xa4>
    80006410:	0000ca97          	auipc	s5,0xc
    80006414:	bf0a8a93          	addi	s5,s5,-1040 # 80012000 <end>
    80006418:	0754ec63          	bltu	s1,s5,80006490 <kinit+0xc8>
    8000641c:	0734fa63          	bgeu	s1,s3,80006490 <kinit+0xc8>
    80006420:	00088a37          	lui	s4,0x88
    80006424:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006428:	00001917          	auipc	s2,0x1
    8000642c:	6e890913          	addi	s2,s2,1768 # 80007b10 <kmem>
    80006430:	00ca1a13          	slli	s4,s4,0xc
    80006434:	0140006f          	j	80006448 <kinit+0x80>
    80006438:	000017b7          	lui	a5,0x1
    8000643c:	00f484b3          	add	s1,s1,a5
    80006440:	0554e863          	bltu	s1,s5,80006490 <kinit+0xc8>
    80006444:	0534f663          	bgeu	s1,s3,80006490 <kinit+0xc8>
    80006448:	00001637          	lui	a2,0x1
    8000644c:	00100593          	li	a1,1
    80006450:	00048513          	mv	a0,s1
    80006454:	00000097          	auipc	ra,0x0
    80006458:	5e4080e7          	jalr	1508(ra) # 80006a38 <__memset>
    8000645c:	00093783          	ld	a5,0(s2)
    80006460:	00f4b023          	sd	a5,0(s1)
    80006464:	00993023          	sd	s1,0(s2)
    80006468:	fd4498e3          	bne	s1,s4,80006438 <kinit+0x70>
    8000646c:	03813083          	ld	ra,56(sp)
    80006470:	03013403          	ld	s0,48(sp)
    80006474:	02813483          	ld	s1,40(sp)
    80006478:	02013903          	ld	s2,32(sp)
    8000647c:	01813983          	ld	s3,24(sp)
    80006480:	01013a03          	ld	s4,16(sp)
    80006484:	00813a83          	ld	s5,8(sp)
    80006488:	04010113          	addi	sp,sp,64
    8000648c:	00008067          	ret
    80006490:	00001517          	auipc	a0,0x1
    80006494:	24850513          	addi	a0,a0,584 # 800076d8 <digits+0x18>
    80006498:	fffff097          	auipc	ra,0xfffff
    8000649c:	4b4080e7          	jalr	1204(ra) # 8000594c <panic>

00000000800064a0 <freerange>:
    800064a0:	fc010113          	addi	sp,sp,-64
    800064a4:	000017b7          	lui	a5,0x1
    800064a8:	02913423          	sd	s1,40(sp)
    800064ac:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800064b0:	009504b3          	add	s1,a0,s1
    800064b4:	fffff537          	lui	a0,0xfffff
    800064b8:	02813823          	sd	s0,48(sp)
    800064bc:	02113c23          	sd	ra,56(sp)
    800064c0:	03213023          	sd	s2,32(sp)
    800064c4:	01313c23          	sd	s3,24(sp)
    800064c8:	01413823          	sd	s4,16(sp)
    800064cc:	01513423          	sd	s5,8(sp)
    800064d0:	01613023          	sd	s6,0(sp)
    800064d4:	04010413          	addi	s0,sp,64
    800064d8:	00a4f4b3          	and	s1,s1,a0
    800064dc:	00f487b3          	add	a5,s1,a5
    800064e0:	06f5e463          	bltu	a1,a5,80006548 <freerange+0xa8>
    800064e4:	0000ca97          	auipc	s5,0xc
    800064e8:	b1ca8a93          	addi	s5,s5,-1252 # 80012000 <end>
    800064ec:	0954e263          	bltu	s1,s5,80006570 <freerange+0xd0>
    800064f0:	01100993          	li	s3,17
    800064f4:	01b99993          	slli	s3,s3,0x1b
    800064f8:	0734fc63          	bgeu	s1,s3,80006570 <freerange+0xd0>
    800064fc:	00058a13          	mv	s4,a1
    80006500:	00001917          	auipc	s2,0x1
    80006504:	61090913          	addi	s2,s2,1552 # 80007b10 <kmem>
    80006508:	00002b37          	lui	s6,0x2
    8000650c:	0140006f          	j	80006520 <freerange+0x80>
    80006510:	000017b7          	lui	a5,0x1
    80006514:	00f484b3          	add	s1,s1,a5
    80006518:	0554ec63          	bltu	s1,s5,80006570 <freerange+0xd0>
    8000651c:	0534fa63          	bgeu	s1,s3,80006570 <freerange+0xd0>
    80006520:	00001637          	lui	a2,0x1
    80006524:	00100593          	li	a1,1
    80006528:	00048513          	mv	a0,s1
    8000652c:	00000097          	auipc	ra,0x0
    80006530:	50c080e7          	jalr	1292(ra) # 80006a38 <__memset>
    80006534:	00093703          	ld	a4,0(s2)
    80006538:	016487b3          	add	a5,s1,s6
    8000653c:	00e4b023          	sd	a4,0(s1)
    80006540:	00993023          	sd	s1,0(s2)
    80006544:	fcfa76e3          	bgeu	s4,a5,80006510 <freerange+0x70>
    80006548:	03813083          	ld	ra,56(sp)
    8000654c:	03013403          	ld	s0,48(sp)
    80006550:	02813483          	ld	s1,40(sp)
    80006554:	02013903          	ld	s2,32(sp)
    80006558:	01813983          	ld	s3,24(sp)
    8000655c:	01013a03          	ld	s4,16(sp)
    80006560:	00813a83          	ld	s5,8(sp)
    80006564:	00013b03          	ld	s6,0(sp)
    80006568:	04010113          	addi	sp,sp,64
    8000656c:	00008067          	ret
    80006570:	00001517          	auipc	a0,0x1
    80006574:	16850513          	addi	a0,a0,360 # 800076d8 <digits+0x18>
    80006578:	fffff097          	auipc	ra,0xfffff
    8000657c:	3d4080e7          	jalr	980(ra) # 8000594c <panic>

0000000080006580 <kfree>:
    80006580:	fe010113          	addi	sp,sp,-32
    80006584:	00813823          	sd	s0,16(sp)
    80006588:	00113c23          	sd	ra,24(sp)
    8000658c:	00913423          	sd	s1,8(sp)
    80006590:	02010413          	addi	s0,sp,32
    80006594:	03451793          	slli	a5,a0,0x34
    80006598:	04079c63          	bnez	a5,800065f0 <kfree+0x70>
    8000659c:	0000c797          	auipc	a5,0xc
    800065a0:	a6478793          	addi	a5,a5,-1436 # 80012000 <end>
    800065a4:	00050493          	mv	s1,a0
    800065a8:	04f56463          	bltu	a0,a5,800065f0 <kfree+0x70>
    800065ac:	01100793          	li	a5,17
    800065b0:	01b79793          	slli	a5,a5,0x1b
    800065b4:	02f57e63          	bgeu	a0,a5,800065f0 <kfree+0x70>
    800065b8:	00001637          	lui	a2,0x1
    800065bc:	00100593          	li	a1,1
    800065c0:	00000097          	auipc	ra,0x0
    800065c4:	478080e7          	jalr	1144(ra) # 80006a38 <__memset>
    800065c8:	00001797          	auipc	a5,0x1
    800065cc:	54878793          	addi	a5,a5,1352 # 80007b10 <kmem>
    800065d0:	0007b703          	ld	a4,0(a5)
    800065d4:	01813083          	ld	ra,24(sp)
    800065d8:	01013403          	ld	s0,16(sp)
    800065dc:	00e4b023          	sd	a4,0(s1)
    800065e0:	0097b023          	sd	s1,0(a5)
    800065e4:	00813483          	ld	s1,8(sp)
    800065e8:	02010113          	addi	sp,sp,32
    800065ec:	00008067          	ret
    800065f0:	00001517          	auipc	a0,0x1
    800065f4:	0e850513          	addi	a0,a0,232 # 800076d8 <digits+0x18>
    800065f8:	fffff097          	auipc	ra,0xfffff
    800065fc:	354080e7          	jalr	852(ra) # 8000594c <panic>

0000000080006600 <kalloc>:
    80006600:	fe010113          	addi	sp,sp,-32
    80006604:	00813823          	sd	s0,16(sp)
    80006608:	00913423          	sd	s1,8(sp)
    8000660c:	00113c23          	sd	ra,24(sp)
    80006610:	02010413          	addi	s0,sp,32
    80006614:	00001797          	auipc	a5,0x1
    80006618:	4fc78793          	addi	a5,a5,1276 # 80007b10 <kmem>
    8000661c:	0007b483          	ld	s1,0(a5)
    80006620:	02048063          	beqz	s1,80006640 <kalloc+0x40>
    80006624:	0004b703          	ld	a4,0(s1)
    80006628:	00001637          	lui	a2,0x1
    8000662c:	00500593          	li	a1,5
    80006630:	00048513          	mv	a0,s1
    80006634:	00e7b023          	sd	a4,0(a5)
    80006638:	00000097          	auipc	ra,0x0
    8000663c:	400080e7          	jalr	1024(ra) # 80006a38 <__memset>
    80006640:	01813083          	ld	ra,24(sp)
    80006644:	01013403          	ld	s0,16(sp)
    80006648:	00048513          	mv	a0,s1
    8000664c:	00813483          	ld	s1,8(sp)
    80006650:	02010113          	addi	sp,sp,32
    80006654:	00008067          	ret

0000000080006658 <initlock>:
    80006658:	ff010113          	addi	sp,sp,-16
    8000665c:	00813423          	sd	s0,8(sp)
    80006660:	01010413          	addi	s0,sp,16
    80006664:	00813403          	ld	s0,8(sp)
    80006668:	00b53423          	sd	a1,8(a0)
    8000666c:	00052023          	sw	zero,0(a0)
    80006670:	00053823          	sd	zero,16(a0)
    80006674:	01010113          	addi	sp,sp,16
    80006678:	00008067          	ret

000000008000667c <acquire>:
    8000667c:	fe010113          	addi	sp,sp,-32
    80006680:	00813823          	sd	s0,16(sp)
    80006684:	00913423          	sd	s1,8(sp)
    80006688:	00113c23          	sd	ra,24(sp)
    8000668c:	01213023          	sd	s2,0(sp)
    80006690:	02010413          	addi	s0,sp,32
    80006694:	00050493          	mv	s1,a0
    80006698:	10002973          	csrr	s2,sstatus
    8000669c:	100027f3          	csrr	a5,sstatus
    800066a0:	ffd7f793          	andi	a5,a5,-3
    800066a4:	10079073          	csrw	sstatus,a5
    800066a8:	fffff097          	auipc	ra,0xfffff
    800066ac:	8ec080e7          	jalr	-1812(ra) # 80004f94 <mycpu>
    800066b0:	07852783          	lw	a5,120(a0)
    800066b4:	06078e63          	beqz	a5,80006730 <acquire+0xb4>
    800066b8:	fffff097          	auipc	ra,0xfffff
    800066bc:	8dc080e7          	jalr	-1828(ra) # 80004f94 <mycpu>
    800066c0:	07852783          	lw	a5,120(a0)
    800066c4:	0004a703          	lw	a4,0(s1)
    800066c8:	0017879b          	addiw	a5,a5,1
    800066cc:	06f52c23          	sw	a5,120(a0)
    800066d0:	04071063          	bnez	a4,80006710 <acquire+0x94>
    800066d4:	00100713          	li	a4,1
    800066d8:	00070793          	mv	a5,a4
    800066dc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800066e0:	0007879b          	sext.w	a5,a5
    800066e4:	fe079ae3          	bnez	a5,800066d8 <acquire+0x5c>
    800066e8:	0ff0000f          	fence
    800066ec:	fffff097          	auipc	ra,0xfffff
    800066f0:	8a8080e7          	jalr	-1880(ra) # 80004f94 <mycpu>
    800066f4:	01813083          	ld	ra,24(sp)
    800066f8:	01013403          	ld	s0,16(sp)
    800066fc:	00a4b823          	sd	a0,16(s1)
    80006700:	00013903          	ld	s2,0(sp)
    80006704:	00813483          	ld	s1,8(sp)
    80006708:	02010113          	addi	sp,sp,32
    8000670c:	00008067          	ret
    80006710:	0104b903          	ld	s2,16(s1)
    80006714:	fffff097          	auipc	ra,0xfffff
    80006718:	880080e7          	jalr	-1920(ra) # 80004f94 <mycpu>
    8000671c:	faa91ce3          	bne	s2,a0,800066d4 <acquire+0x58>
    80006720:	00001517          	auipc	a0,0x1
    80006724:	fc050513          	addi	a0,a0,-64 # 800076e0 <digits+0x20>
    80006728:	fffff097          	auipc	ra,0xfffff
    8000672c:	224080e7          	jalr	548(ra) # 8000594c <panic>
    80006730:	00195913          	srli	s2,s2,0x1
    80006734:	fffff097          	auipc	ra,0xfffff
    80006738:	860080e7          	jalr	-1952(ra) # 80004f94 <mycpu>
    8000673c:	00197913          	andi	s2,s2,1
    80006740:	07252e23          	sw	s2,124(a0)
    80006744:	f75ff06f          	j	800066b8 <acquire+0x3c>

0000000080006748 <release>:
    80006748:	fe010113          	addi	sp,sp,-32
    8000674c:	00813823          	sd	s0,16(sp)
    80006750:	00113c23          	sd	ra,24(sp)
    80006754:	00913423          	sd	s1,8(sp)
    80006758:	01213023          	sd	s2,0(sp)
    8000675c:	02010413          	addi	s0,sp,32
    80006760:	00052783          	lw	a5,0(a0)
    80006764:	00079a63          	bnez	a5,80006778 <release+0x30>
    80006768:	00001517          	auipc	a0,0x1
    8000676c:	f8050513          	addi	a0,a0,-128 # 800076e8 <digits+0x28>
    80006770:	fffff097          	auipc	ra,0xfffff
    80006774:	1dc080e7          	jalr	476(ra) # 8000594c <panic>
    80006778:	01053903          	ld	s2,16(a0)
    8000677c:	00050493          	mv	s1,a0
    80006780:	fffff097          	auipc	ra,0xfffff
    80006784:	814080e7          	jalr	-2028(ra) # 80004f94 <mycpu>
    80006788:	fea910e3          	bne	s2,a0,80006768 <release+0x20>
    8000678c:	0004b823          	sd	zero,16(s1)
    80006790:	0ff0000f          	fence
    80006794:	0f50000f          	fence	iorw,ow
    80006798:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000679c:	ffffe097          	auipc	ra,0xffffe
    800067a0:	7f8080e7          	jalr	2040(ra) # 80004f94 <mycpu>
    800067a4:	100027f3          	csrr	a5,sstatus
    800067a8:	0027f793          	andi	a5,a5,2
    800067ac:	04079a63          	bnez	a5,80006800 <release+0xb8>
    800067b0:	07852783          	lw	a5,120(a0)
    800067b4:	02f05e63          	blez	a5,800067f0 <release+0xa8>
    800067b8:	fff7871b          	addiw	a4,a5,-1
    800067bc:	06e52c23          	sw	a4,120(a0)
    800067c0:	00071c63          	bnez	a4,800067d8 <release+0x90>
    800067c4:	07c52783          	lw	a5,124(a0)
    800067c8:	00078863          	beqz	a5,800067d8 <release+0x90>
    800067cc:	100027f3          	csrr	a5,sstatus
    800067d0:	0027e793          	ori	a5,a5,2
    800067d4:	10079073          	csrw	sstatus,a5
    800067d8:	01813083          	ld	ra,24(sp)
    800067dc:	01013403          	ld	s0,16(sp)
    800067e0:	00813483          	ld	s1,8(sp)
    800067e4:	00013903          	ld	s2,0(sp)
    800067e8:	02010113          	addi	sp,sp,32
    800067ec:	00008067          	ret
    800067f0:	00001517          	auipc	a0,0x1
    800067f4:	f1850513          	addi	a0,a0,-232 # 80007708 <digits+0x48>
    800067f8:	fffff097          	auipc	ra,0xfffff
    800067fc:	154080e7          	jalr	340(ra) # 8000594c <panic>
    80006800:	00001517          	auipc	a0,0x1
    80006804:	ef050513          	addi	a0,a0,-272 # 800076f0 <digits+0x30>
    80006808:	fffff097          	auipc	ra,0xfffff
    8000680c:	144080e7          	jalr	324(ra) # 8000594c <panic>

0000000080006810 <holding>:
    80006810:	00052783          	lw	a5,0(a0)
    80006814:	00079663          	bnez	a5,80006820 <holding+0x10>
    80006818:	00000513          	li	a0,0
    8000681c:	00008067          	ret
    80006820:	fe010113          	addi	sp,sp,-32
    80006824:	00813823          	sd	s0,16(sp)
    80006828:	00913423          	sd	s1,8(sp)
    8000682c:	00113c23          	sd	ra,24(sp)
    80006830:	02010413          	addi	s0,sp,32
    80006834:	01053483          	ld	s1,16(a0)
    80006838:	ffffe097          	auipc	ra,0xffffe
    8000683c:	75c080e7          	jalr	1884(ra) # 80004f94 <mycpu>
    80006840:	01813083          	ld	ra,24(sp)
    80006844:	01013403          	ld	s0,16(sp)
    80006848:	40a48533          	sub	a0,s1,a0
    8000684c:	00153513          	seqz	a0,a0
    80006850:	00813483          	ld	s1,8(sp)
    80006854:	02010113          	addi	sp,sp,32
    80006858:	00008067          	ret

000000008000685c <push_off>:
    8000685c:	fe010113          	addi	sp,sp,-32
    80006860:	00813823          	sd	s0,16(sp)
    80006864:	00113c23          	sd	ra,24(sp)
    80006868:	00913423          	sd	s1,8(sp)
    8000686c:	02010413          	addi	s0,sp,32
    80006870:	100024f3          	csrr	s1,sstatus
    80006874:	100027f3          	csrr	a5,sstatus
    80006878:	ffd7f793          	andi	a5,a5,-3
    8000687c:	10079073          	csrw	sstatus,a5
    80006880:	ffffe097          	auipc	ra,0xffffe
    80006884:	714080e7          	jalr	1812(ra) # 80004f94 <mycpu>
    80006888:	07852783          	lw	a5,120(a0)
    8000688c:	02078663          	beqz	a5,800068b8 <push_off+0x5c>
    80006890:	ffffe097          	auipc	ra,0xffffe
    80006894:	704080e7          	jalr	1796(ra) # 80004f94 <mycpu>
    80006898:	07852783          	lw	a5,120(a0)
    8000689c:	01813083          	ld	ra,24(sp)
    800068a0:	01013403          	ld	s0,16(sp)
    800068a4:	0017879b          	addiw	a5,a5,1
    800068a8:	06f52c23          	sw	a5,120(a0)
    800068ac:	00813483          	ld	s1,8(sp)
    800068b0:	02010113          	addi	sp,sp,32
    800068b4:	00008067          	ret
    800068b8:	0014d493          	srli	s1,s1,0x1
    800068bc:	ffffe097          	auipc	ra,0xffffe
    800068c0:	6d8080e7          	jalr	1752(ra) # 80004f94 <mycpu>
    800068c4:	0014f493          	andi	s1,s1,1
    800068c8:	06952e23          	sw	s1,124(a0)
    800068cc:	fc5ff06f          	j	80006890 <push_off+0x34>

00000000800068d0 <pop_off>:
    800068d0:	ff010113          	addi	sp,sp,-16
    800068d4:	00813023          	sd	s0,0(sp)
    800068d8:	00113423          	sd	ra,8(sp)
    800068dc:	01010413          	addi	s0,sp,16
    800068e0:	ffffe097          	auipc	ra,0xffffe
    800068e4:	6b4080e7          	jalr	1716(ra) # 80004f94 <mycpu>
    800068e8:	100027f3          	csrr	a5,sstatus
    800068ec:	0027f793          	andi	a5,a5,2
    800068f0:	04079663          	bnez	a5,8000693c <pop_off+0x6c>
    800068f4:	07852783          	lw	a5,120(a0)
    800068f8:	02f05a63          	blez	a5,8000692c <pop_off+0x5c>
    800068fc:	fff7871b          	addiw	a4,a5,-1
    80006900:	06e52c23          	sw	a4,120(a0)
    80006904:	00071c63          	bnez	a4,8000691c <pop_off+0x4c>
    80006908:	07c52783          	lw	a5,124(a0)
    8000690c:	00078863          	beqz	a5,8000691c <pop_off+0x4c>
    80006910:	100027f3          	csrr	a5,sstatus
    80006914:	0027e793          	ori	a5,a5,2
    80006918:	10079073          	csrw	sstatus,a5
    8000691c:	00813083          	ld	ra,8(sp)
    80006920:	00013403          	ld	s0,0(sp)
    80006924:	01010113          	addi	sp,sp,16
    80006928:	00008067          	ret
    8000692c:	00001517          	auipc	a0,0x1
    80006930:	ddc50513          	addi	a0,a0,-548 # 80007708 <digits+0x48>
    80006934:	fffff097          	auipc	ra,0xfffff
    80006938:	018080e7          	jalr	24(ra) # 8000594c <panic>
    8000693c:	00001517          	auipc	a0,0x1
    80006940:	db450513          	addi	a0,a0,-588 # 800076f0 <digits+0x30>
    80006944:	fffff097          	auipc	ra,0xfffff
    80006948:	008080e7          	jalr	8(ra) # 8000594c <panic>

000000008000694c <push_on>:
    8000694c:	fe010113          	addi	sp,sp,-32
    80006950:	00813823          	sd	s0,16(sp)
    80006954:	00113c23          	sd	ra,24(sp)
    80006958:	00913423          	sd	s1,8(sp)
    8000695c:	02010413          	addi	s0,sp,32
    80006960:	100024f3          	csrr	s1,sstatus
    80006964:	100027f3          	csrr	a5,sstatus
    80006968:	0027e793          	ori	a5,a5,2
    8000696c:	10079073          	csrw	sstatus,a5
    80006970:	ffffe097          	auipc	ra,0xffffe
    80006974:	624080e7          	jalr	1572(ra) # 80004f94 <mycpu>
    80006978:	07852783          	lw	a5,120(a0)
    8000697c:	02078663          	beqz	a5,800069a8 <push_on+0x5c>
    80006980:	ffffe097          	auipc	ra,0xffffe
    80006984:	614080e7          	jalr	1556(ra) # 80004f94 <mycpu>
    80006988:	07852783          	lw	a5,120(a0)
    8000698c:	01813083          	ld	ra,24(sp)
    80006990:	01013403          	ld	s0,16(sp)
    80006994:	0017879b          	addiw	a5,a5,1
    80006998:	06f52c23          	sw	a5,120(a0)
    8000699c:	00813483          	ld	s1,8(sp)
    800069a0:	02010113          	addi	sp,sp,32
    800069a4:	00008067          	ret
    800069a8:	0014d493          	srli	s1,s1,0x1
    800069ac:	ffffe097          	auipc	ra,0xffffe
    800069b0:	5e8080e7          	jalr	1512(ra) # 80004f94 <mycpu>
    800069b4:	0014f493          	andi	s1,s1,1
    800069b8:	06952e23          	sw	s1,124(a0)
    800069bc:	fc5ff06f          	j	80006980 <push_on+0x34>

00000000800069c0 <pop_on>:
    800069c0:	ff010113          	addi	sp,sp,-16
    800069c4:	00813023          	sd	s0,0(sp)
    800069c8:	00113423          	sd	ra,8(sp)
    800069cc:	01010413          	addi	s0,sp,16
    800069d0:	ffffe097          	auipc	ra,0xffffe
    800069d4:	5c4080e7          	jalr	1476(ra) # 80004f94 <mycpu>
    800069d8:	100027f3          	csrr	a5,sstatus
    800069dc:	0027f793          	andi	a5,a5,2
    800069e0:	04078463          	beqz	a5,80006a28 <pop_on+0x68>
    800069e4:	07852783          	lw	a5,120(a0)
    800069e8:	02f05863          	blez	a5,80006a18 <pop_on+0x58>
    800069ec:	fff7879b          	addiw	a5,a5,-1
    800069f0:	06f52c23          	sw	a5,120(a0)
    800069f4:	07853783          	ld	a5,120(a0)
    800069f8:	00079863          	bnez	a5,80006a08 <pop_on+0x48>
    800069fc:	100027f3          	csrr	a5,sstatus
    80006a00:	ffd7f793          	andi	a5,a5,-3
    80006a04:	10079073          	csrw	sstatus,a5
    80006a08:	00813083          	ld	ra,8(sp)
    80006a0c:	00013403          	ld	s0,0(sp)
    80006a10:	01010113          	addi	sp,sp,16
    80006a14:	00008067          	ret
    80006a18:	00001517          	auipc	a0,0x1
    80006a1c:	d1850513          	addi	a0,a0,-744 # 80007730 <digits+0x70>
    80006a20:	fffff097          	auipc	ra,0xfffff
    80006a24:	f2c080e7          	jalr	-212(ra) # 8000594c <panic>
    80006a28:	00001517          	auipc	a0,0x1
    80006a2c:	ce850513          	addi	a0,a0,-792 # 80007710 <digits+0x50>
    80006a30:	fffff097          	auipc	ra,0xfffff
    80006a34:	f1c080e7          	jalr	-228(ra) # 8000594c <panic>

0000000080006a38 <__memset>:
    80006a38:	ff010113          	addi	sp,sp,-16
    80006a3c:	00813423          	sd	s0,8(sp)
    80006a40:	01010413          	addi	s0,sp,16
    80006a44:	1a060e63          	beqz	a2,80006c00 <__memset+0x1c8>
    80006a48:	40a007b3          	neg	a5,a0
    80006a4c:	0077f793          	andi	a5,a5,7
    80006a50:	00778693          	addi	a3,a5,7
    80006a54:	00b00813          	li	a6,11
    80006a58:	0ff5f593          	andi	a1,a1,255
    80006a5c:	fff6071b          	addiw	a4,a2,-1
    80006a60:	1b06e663          	bltu	a3,a6,80006c0c <__memset+0x1d4>
    80006a64:	1cd76463          	bltu	a4,a3,80006c2c <__memset+0x1f4>
    80006a68:	1a078e63          	beqz	a5,80006c24 <__memset+0x1ec>
    80006a6c:	00b50023          	sb	a1,0(a0)
    80006a70:	00100713          	li	a4,1
    80006a74:	1ae78463          	beq	a5,a4,80006c1c <__memset+0x1e4>
    80006a78:	00b500a3          	sb	a1,1(a0)
    80006a7c:	00200713          	li	a4,2
    80006a80:	1ae78a63          	beq	a5,a4,80006c34 <__memset+0x1fc>
    80006a84:	00b50123          	sb	a1,2(a0)
    80006a88:	00300713          	li	a4,3
    80006a8c:	18e78463          	beq	a5,a4,80006c14 <__memset+0x1dc>
    80006a90:	00b501a3          	sb	a1,3(a0)
    80006a94:	00400713          	li	a4,4
    80006a98:	1ae78263          	beq	a5,a4,80006c3c <__memset+0x204>
    80006a9c:	00b50223          	sb	a1,4(a0)
    80006aa0:	00500713          	li	a4,5
    80006aa4:	1ae78063          	beq	a5,a4,80006c44 <__memset+0x20c>
    80006aa8:	00b502a3          	sb	a1,5(a0)
    80006aac:	00700713          	li	a4,7
    80006ab0:	18e79e63          	bne	a5,a4,80006c4c <__memset+0x214>
    80006ab4:	00b50323          	sb	a1,6(a0)
    80006ab8:	00700e93          	li	t4,7
    80006abc:	00859713          	slli	a4,a1,0x8
    80006ac0:	00e5e733          	or	a4,a1,a4
    80006ac4:	01059e13          	slli	t3,a1,0x10
    80006ac8:	01c76e33          	or	t3,a4,t3
    80006acc:	01859313          	slli	t1,a1,0x18
    80006ad0:	006e6333          	or	t1,t3,t1
    80006ad4:	02059893          	slli	a7,a1,0x20
    80006ad8:	40f60e3b          	subw	t3,a2,a5
    80006adc:	011368b3          	or	a7,t1,a7
    80006ae0:	02859813          	slli	a6,a1,0x28
    80006ae4:	0108e833          	or	a6,a7,a6
    80006ae8:	03059693          	slli	a3,a1,0x30
    80006aec:	003e589b          	srliw	a7,t3,0x3
    80006af0:	00d866b3          	or	a3,a6,a3
    80006af4:	03859713          	slli	a4,a1,0x38
    80006af8:	00389813          	slli	a6,a7,0x3
    80006afc:	00f507b3          	add	a5,a0,a5
    80006b00:	00e6e733          	or	a4,a3,a4
    80006b04:	000e089b          	sext.w	a7,t3
    80006b08:	00f806b3          	add	a3,a6,a5
    80006b0c:	00e7b023          	sd	a4,0(a5)
    80006b10:	00878793          	addi	a5,a5,8
    80006b14:	fed79ce3          	bne	a5,a3,80006b0c <__memset+0xd4>
    80006b18:	ff8e7793          	andi	a5,t3,-8
    80006b1c:	0007871b          	sext.w	a4,a5
    80006b20:	01d787bb          	addw	a5,a5,t4
    80006b24:	0ce88e63          	beq	a7,a4,80006c00 <__memset+0x1c8>
    80006b28:	00f50733          	add	a4,a0,a5
    80006b2c:	00b70023          	sb	a1,0(a4)
    80006b30:	0017871b          	addiw	a4,a5,1
    80006b34:	0cc77663          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b38:	00e50733          	add	a4,a0,a4
    80006b3c:	00b70023          	sb	a1,0(a4)
    80006b40:	0027871b          	addiw	a4,a5,2
    80006b44:	0ac77e63          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b48:	00e50733          	add	a4,a0,a4
    80006b4c:	00b70023          	sb	a1,0(a4)
    80006b50:	0037871b          	addiw	a4,a5,3
    80006b54:	0ac77663          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b58:	00e50733          	add	a4,a0,a4
    80006b5c:	00b70023          	sb	a1,0(a4)
    80006b60:	0047871b          	addiw	a4,a5,4
    80006b64:	08c77e63          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b68:	00e50733          	add	a4,a0,a4
    80006b6c:	00b70023          	sb	a1,0(a4)
    80006b70:	0057871b          	addiw	a4,a5,5
    80006b74:	08c77663          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b78:	00e50733          	add	a4,a0,a4
    80006b7c:	00b70023          	sb	a1,0(a4)
    80006b80:	0067871b          	addiw	a4,a5,6
    80006b84:	06c77e63          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b88:	00e50733          	add	a4,a0,a4
    80006b8c:	00b70023          	sb	a1,0(a4)
    80006b90:	0077871b          	addiw	a4,a5,7
    80006b94:	06c77663          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006b98:	00e50733          	add	a4,a0,a4
    80006b9c:	00b70023          	sb	a1,0(a4)
    80006ba0:	0087871b          	addiw	a4,a5,8
    80006ba4:	04c77e63          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006ba8:	00e50733          	add	a4,a0,a4
    80006bac:	00b70023          	sb	a1,0(a4)
    80006bb0:	0097871b          	addiw	a4,a5,9
    80006bb4:	04c77663          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006bb8:	00e50733          	add	a4,a0,a4
    80006bbc:	00b70023          	sb	a1,0(a4)
    80006bc0:	00a7871b          	addiw	a4,a5,10
    80006bc4:	02c77e63          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006bc8:	00e50733          	add	a4,a0,a4
    80006bcc:	00b70023          	sb	a1,0(a4)
    80006bd0:	00b7871b          	addiw	a4,a5,11
    80006bd4:	02c77663          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006bd8:	00e50733          	add	a4,a0,a4
    80006bdc:	00b70023          	sb	a1,0(a4)
    80006be0:	00c7871b          	addiw	a4,a5,12
    80006be4:	00c77e63          	bgeu	a4,a2,80006c00 <__memset+0x1c8>
    80006be8:	00e50733          	add	a4,a0,a4
    80006bec:	00b70023          	sb	a1,0(a4)
    80006bf0:	00d7879b          	addiw	a5,a5,13
    80006bf4:	00c7f663          	bgeu	a5,a2,80006c00 <__memset+0x1c8>
    80006bf8:	00f507b3          	add	a5,a0,a5
    80006bfc:	00b78023          	sb	a1,0(a5)
    80006c00:	00813403          	ld	s0,8(sp)
    80006c04:	01010113          	addi	sp,sp,16
    80006c08:	00008067          	ret
    80006c0c:	00b00693          	li	a3,11
    80006c10:	e55ff06f          	j	80006a64 <__memset+0x2c>
    80006c14:	00300e93          	li	t4,3
    80006c18:	ea5ff06f          	j	80006abc <__memset+0x84>
    80006c1c:	00100e93          	li	t4,1
    80006c20:	e9dff06f          	j	80006abc <__memset+0x84>
    80006c24:	00000e93          	li	t4,0
    80006c28:	e95ff06f          	j	80006abc <__memset+0x84>
    80006c2c:	00000793          	li	a5,0
    80006c30:	ef9ff06f          	j	80006b28 <__memset+0xf0>
    80006c34:	00200e93          	li	t4,2
    80006c38:	e85ff06f          	j	80006abc <__memset+0x84>
    80006c3c:	00400e93          	li	t4,4
    80006c40:	e7dff06f          	j	80006abc <__memset+0x84>
    80006c44:	00500e93          	li	t4,5
    80006c48:	e75ff06f          	j	80006abc <__memset+0x84>
    80006c4c:	00600e93          	li	t4,6
    80006c50:	e6dff06f          	j	80006abc <__memset+0x84>

0000000080006c54 <__memmove>:
    80006c54:	ff010113          	addi	sp,sp,-16
    80006c58:	00813423          	sd	s0,8(sp)
    80006c5c:	01010413          	addi	s0,sp,16
    80006c60:	0e060863          	beqz	a2,80006d50 <__memmove+0xfc>
    80006c64:	fff6069b          	addiw	a3,a2,-1
    80006c68:	0006881b          	sext.w	a6,a3
    80006c6c:	0ea5e863          	bltu	a1,a0,80006d5c <__memmove+0x108>
    80006c70:	00758713          	addi	a4,a1,7
    80006c74:	00a5e7b3          	or	a5,a1,a0
    80006c78:	40a70733          	sub	a4,a4,a0
    80006c7c:	0077f793          	andi	a5,a5,7
    80006c80:	00f73713          	sltiu	a4,a4,15
    80006c84:	00174713          	xori	a4,a4,1
    80006c88:	0017b793          	seqz	a5,a5
    80006c8c:	00e7f7b3          	and	a5,a5,a4
    80006c90:	10078863          	beqz	a5,80006da0 <__memmove+0x14c>
    80006c94:	00900793          	li	a5,9
    80006c98:	1107f463          	bgeu	a5,a6,80006da0 <__memmove+0x14c>
    80006c9c:	0036581b          	srliw	a6,a2,0x3
    80006ca0:	fff8081b          	addiw	a6,a6,-1
    80006ca4:	02081813          	slli	a6,a6,0x20
    80006ca8:	01d85893          	srli	a7,a6,0x1d
    80006cac:	00858813          	addi	a6,a1,8
    80006cb0:	00058793          	mv	a5,a1
    80006cb4:	00050713          	mv	a4,a0
    80006cb8:	01088833          	add	a6,a7,a6
    80006cbc:	0007b883          	ld	a7,0(a5)
    80006cc0:	00878793          	addi	a5,a5,8
    80006cc4:	00870713          	addi	a4,a4,8
    80006cc8:	ff173c23          	sd	a7,-8(a4)
    80006ccc:	ff0798e3          	bne	a5,a6,80006cbc <__memmove+0x68>
    80006cd0:	ff867713          	andi	a4,a2,-8
    80006cd4:	02071793          	slli	a5,a4,0x20
    80006cd8:	0207d793          	srli	a5,a5,0x20
    80006cdc:	00f585b3          	add	a1,a1,a5
    80006ce0:	40e686bb          	subw	a3,a3,a4
    80006ce4:	00f507b3          	add	a5,a0,a5
    80006ce8:	06e60463          	beq	a2,a4,80006d50 <__memmove+0xfc>
    80006cec:	0005c703          	lbu	a4,0(a1)
    80006cf0:	00e78023          	sb	a4,0(a5)
    80006cf4:	04068e63          	beqz	a3,80006d50 <__memmove+0xfc>
    80006cf8:	0015c603          	lbu	a2,1(a1)
    80006cfc:	00100713          	li	a4,1
    80006d00:	00c780a3          	sb	a2,1(a5)
    80006d04:	04e68663          	beq	a3,a4,80006d50 <__memmove+0xfc>
    80006d08:	0025c603          	lbu	a2,2(a1)
    80006d0c:	00200713          	li	a4,2
    80006d10:	00c78123          	sb	a2,2(a5)
    80006d14:	02e68e63          	beq	a3,a4,80006d50 <__memmove+0xfc>
    80006d18:	0035c603          	lbu	a2,3(a1)
    80006d1c:	00300713          	li	a4,3
    80006d20:	00c781a3          	sb	a2,3(a5)
    80006d24:	02e68663          	beq	a3,a4,80006d50 <__memmove+0xfc>
    80006d28:	0045c603          	lbu	a2,4(a1)
    80006d2c:	00400713          	li	a4,4
    80006d30:	00c78223          	sb	a2,4(a5)
    80006d34:	00e68e63          	beq	a3,a4,80006d50 <__memmove+0xfc>
    80006d38:	0055c603          	lbu	a2,5(a1)
    80006d3c:	00500713          	li	a4,5
    80006d40:	00c782a3          	sb	a2,5(a5)
    80006d44:	00e68663          	beq	a3,a4,80006d50 <__memmove+0xfc>
    80006d48:	0065c703          	lbu	a4,6(a1)
    80006d4c:	00e78323          	sb	a4,6(a5)
    80006d50:	00813403          	ld	s0,8(sp)
    80006d54:	01010113          	addi	sp,sp,16
    80006d58:	00008067          	ret
    80006d5c:	02061713          	slli	a4,a2,0x20
    80006d60:	02075713          	srli	a4,a4,0x20
    80006d64:	00e587b3          	add	a5,a1,a4
    80006d68:	f0f574e3          	bgeu	a0,a5,80006c70 <__memmove+0x1c>
    80006d6c:	02069613          	slli	a2,a3,0x20
    80006d70:	02065613          	srli	a2,a2,0x20
    80006d74:	fff64613          	not	a2,a2
    80006d78:	00e50733          	add	a4,a0,a4
    80006d7c:	00c78633          	add	a2,a5,a2
    80006d80:	fff7c683          	lbu	a3,-1(a5)
    80006d84:	fff78793          	addi	a5,a5,-1
    80006d88:	fff70713          	addi	a4,a4,-1
    80006d8c:	00d70023          	sb	a3,0(a4)
    80006d90:	fec798e3          	bne	a5,a2,80006d80 <__memmove+0x12c>
    80006d94:	00813403          	ld	s0,8(sp)
    80006d98:	01010113          	addi	sp,sp,16
    80006d9c:	00008067          	ret
    80006da0:	02069713          	slli	a4,a3,0x20
    80006da4:	02075713          	srli	a4,a4,0x20
    80006da8:	00170713          	addi	a4,a4,1
    80006dac:	00e50733          	add	a4,a0,a4
    80006db0:	00050793          	mv	a5,a0
    80006db4:	0005c683          	lbu	a3,0(a1)
    80006db8:	00178793          	addi	a5,a5,1
    80006dbc:	00158593          	addi	a1,a1,1
    80006dc0:	fed78fa3          	sb	a3,-1(a5)
    80006dc4:	fee798e3          	bne	a5,a4,80006db4 <__memmove+0x160>
    80006dc8:	f89ff06f          	j	80006d50 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000e468 <copy_and_swap-0xb98>:
	...

000000008000f000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    8000f000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    8000f004:	00b29a63          	bne	t0,a1,8000f018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    8000f008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000f00c:	fe029ae3          	bnez	t0,8000f000 <copy_and_swap>
    li a0, 0               # Set return to success.
    8000f010:	00000513          	li	a0,0
    jr ra                  # Return.
    8000f014:	00008067          	ret

000000008000f018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    8000f018:	00100513          	li	a0,1
    8000f01c:	00008067          	ret

000000008000f020 <_Z9mem_allocm>:
//syscall parameters (if has any) are put into registers a1-a7
//syscall ID is put into a0
//"ecall" is called to jump into supervisor mode trap handler
//return value for syscall is returned by a0 register

void *mem_alloc(size_t size){
    8000f020:	ff010113          	addi	sp,sp,-16
    8000f024:	00813423          	sd	s0,8(sp)
    8000f028:	01010413          	addi	s0,sp,16
    size_t sz = (size + MEM_BLOCK_SIZE -1) / MEM_BLOCK_SIZE;
    8000f02c:	03f50513          	addi	a0,a0,63
    8000f030:	00655513          	srli	a0,a0,0x6

    asm("mv a1, %[sz]" : : [sz] "r" (sz));  //put number of blocks required in a1
    8000f034:	00050593          	mv	a1,a0
    asm("li a0, 0x01");  //put number of syscall in a0
    8000f038:	00100513          	li	a0,1
    asm("ecall");
    8000f03c:	00000073          	ecall

    uint64 addr = 0;    //return address of block allocated

    asm("mv %[addr], a0" : [addr] "=r" (addr));
    8000f040:	00050513          	mv	a0,a0

    return (void*)addr;
}
    8000f044:	00813403          	ld	s0,8(sp)
    8000f048:	01010113          	addi	sp,sp,16
    8000f04c:	00008067          	ret

000000008000f050 <_Z8mem_freePv>:

int mem_free(void *ptr){
    8000f050:	ff010113          	addi	sp,sp,-16
    8000f054:	00813423          	sd	s0,8(sp)
    8000f058:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)ptr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    8000f05c:	00050593          	mv	a1,a0
    asm("li a0, 0x02");  //put number of syscall in a0
    8000f060:	00200513          	li	a0,2
    asm("ecall");
    8000f064:	00000073          	ecall

    uint64 status; //return status of mem_free

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f068:	00050513          	mv	a0,a0
    return status;
}
    8000f06c:	0005051b          	sext.w	a0,a0
    8000f070:	00813403          	ld	s0,8(sp)
    8000f074:	01010113          	addi	sp,sp,16
    8000f078:	00008067          	ret

000000008000f07c <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void *arg){
    8000f07c:	fd010113          	addi	sp,sp,-48
    8000f080:	02113423          	sd	ra,40(sp)
    8000f084:	02813023          	sd	s0,32(sp)
    8000f088:	00913c23          	sd	s1,24(sp)
    8000f08c:	01213823          	sd	s2,16(sp)
    8000f090:	01313423          	sd	s3,8(sp)
    8000f094:	03010413          	addi	s0,sp,48
    8000f098:	00050913          	mv	s2,a0
    8000f09c:	00058493          	mv	s1,a1
    8000f0a0:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    8000f0a4:	04058e63          	beqz	a1,8000f100 <_Z13thread_createPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    8000f0a8:	00001537          	lui	a0,0x1
    8000f0ac:	00000097          	auipc	ra,0x0
    8000f0b0:	f74080e7          	jalr	-140(ra) # 8000f020 <_Z9mem_allocm>
        if(istack == 0) {
    8000f0b4:	04050063          	beqz	a0,8000f0f4 <_Z13thread_createPP7_threadPFvPvES2_+0x78>
            *handle = nullptr;
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    8000f0b8:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    8000f0bc:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    8000f0c0:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f0c4:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    8000f0c8:	01100513          	li	a0,17

    asm("ecall");
    8000f0cc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f0d0:	00050513          	mv	a0,a0

    return status;
    8000f0d4:	0005051b          	sext.w	a0,a0
}
    8000f0d8:	02813083          	ld	ra,40(sp)
    8000f0dc:	02013403          	ld	s0,32(sp)
    8000f0e0:	01813483          	ld	s1,24(sp)
    8000f0e4:	01013903          	ld	s2,16(sp)
    8000f0e8:	00813983          	ld	s3,8(sp)
    8000f0ec:	03010113          	addi	sp,sp,48
    8000f0f0:	00008067          	ret
            *handle = nullptr;
    8000f0f4:	00093023          	sd	zero,0(s2)
            return -1;
    8000f0f8:	fff00513          	li	a0,-1
    8000f0fc:	fddff06f          	j	8000f0d8 <_Z13thread_createPP7_threadPFvPvES2_+0x5c>
    uint64 istack = 0;
    8000f100:	00000513          	li	a0,0
    8000f104:	fb5ff06f          	j	8000f0b8 <_Z13thread_createPP7_threadPFvPvES2_+0x3c>

000000008000f108 <_Z11thread_exitv>:

int thread_exit(){
    8000f108:	ff010113          	addi	sp,sp,-16
    8000f10c:	00813423          	sd	s0,8(sp)
    8000f110:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    8000f114:	01200513          	li	a0,18

    asm("ecall");
    8000f118:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f11c:	00050513          	mv	a0,a0

    return status;
}
    8000f120:	0005051b          	sext.w	a0,a0
    8000f124:	00813403          	ld	s0,8(sp)
    8000f128:	01010113          	addi	sp,sp,16
    8000f12c:	00008067          	ret

000000008000f130 <_Z15thread_dispatchv>:

void thread_dispatch(){
    8000f130:	ff010113          	addi	sp,sp,-16
    8000f134:	00813423          	sd	s0,8(sp)
    8000f138:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    8000f13c:	01300513          	li	a0,19

    asm("ecall");
    8000f140:	00000073          	ecall
}
    8000f144:	00813403          	ld	s0,8(sp)
    8000f148:	01010113          	addi	sp,sp,16
    8000f14c:	00008067          	ret

000000008000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>:

int thread_attach_body(thread_t *handle, void(*start_routine)(void*), void *arg){
    8000f150:	fd010113          	addi	sp,sp,-48
    8000f154:	02113423          	sd	ra,40(sp)
    8000f158:	02813023          	sd	s0,32(sp)
    8000f15c:	00913c23          	sd	s1,24(sp)
    8000f160:	01213823          	sd	s2,16(sp)
    8000f164:	01313423          	sd	s3,8(sp)
    8000f168:	03010413          	addi	s0,sp,48
    8000f16c:	00050493          	mv	s1,a0
    8000f170:	00058913          	mv	s2,a1
    8000f174:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(handle && start_routine) {
    8000f178:	04050a63          	beqz	a0,8000f1cc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x7c>
    8000f17c:	04058c63          	beqz	a1,8000f1d4 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x84>
        istack = (uint64) mem_alloc(DEFAULT_STACK_SIZE);
    8000f180:	00001537          	lui	a0,0x1
    8000f184:	00000097          	auipc	ra,0x0
    8000f188:	e9c080e7          	jalr	-356(ra) # 8000f020 <_Z9mem_allocm>
        if(istack == 0) {
    8000f18c:	04050863          	beqz	a0,8000f1dc <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x8c>
            return -1;
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    8000f190:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    8000f194:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    8000f198:	00090613          	mv	a2,s2
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f19c:	00048593          	mv	a1,s1
    asm("li a0, 0x14");
    8000f1a0:	01400513          	li	a0,20

    asm("ecall");
    8000f1a4:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f1a8:	00050513          	mv	a0,a0

    return status;
    8000f1ac:	0005051b          	sext.w	a0,a0
}
    8000f1b0:	02813083          	ld	ra,40(sp)
    8000f1b4:	02013403          	ld	s0,32(sp)
    8000f1b8:	01813483          	ld	s1,24(sp)
    8000f1bc:	01013903          	ld	s2,16(sp)
    8000f1c0:	00813983          	ld	s3,8(sp)
    8000f1c4:	03010113          	addi	sp,sp,48
    8000f1c8:	00008067          	ret
    uint64 istack = 0;
    8000f1cc:	00000513          	li	a0,0
    8000f1d0:	fc1ff06f          	j	8000f190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
    8000f1d4:	00000513          	li	a0,0
    8000f1d8:	fb9ff06f          	j	8000f190 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x40>
            return -1;
    8000f1dc:	fff00513          	li	a0,-1
    8000f1e0:	fd1ff06f          	j	8000f1b0 <_Z18thread_attach_bodyPP7_threadPFvPvES2_+0x60>

000000008000f1e4 <_Z12thread_startP7_thread>:

int thread_start(thread_t handle){
    8000f1e4:	ff010113          	addi	sp,sp,-16
    8000f1e8:	00813423          	sd	s0,8(sp)
    8000f1ec:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;
    if(handle == nullptr)
    8000f1f0:	02050263          	beqz	a0,8000f214 <_Z12thread_startP7_thread+0x30>
        return -1;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f1f4:	00050593          	mv	a1,a0
    asm("li a0, 0x15");
    8000f1f8:	01500513          	li	a0,21

    asm("ecall");
    8000f1fc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f200:	00050513          	mv	a0,a0

    return status;
    8000f204:	0005051b          	sext.w	a0,a0
}
    8000f208:	00813403          	ld	s0,8(sp)
    8000f20c:	01010113          	addi	sp,sp,16
    8000f210:	00008067          	ret
        return -1;
    8000f214:	fff00513          	li	a0,-1
    8000f218:	ff1ff06f          	j	8000f208 <_Z12thread_startP7_thread+0x24>

000000008000f21c <_Z8sem_openPP10_semaphorej>:

int sem_open(sem_t *handle, unsigned init){
    8000f21c:	ff010113          	addi	sp,sp,-16
    8000f220:	00813423          	sd	s0,8(sp)
    8000f224:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;
    uint64 iinit = (uint64)init;
    8000f228:	02059593          	slli	a1,a1,0x20
    8000f22c:	0205d593          	srli	a1,a1,0x20

    asm("mv a2, %[iinit]" : : [iinit] "r" (iinit));
    8000f230:	00058613          	mv	a2,a1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f234:	00050593          	mv	a1,a0
    asm("li a0, 0x21");
    8000f238:	02100513          	li	a0,33


    asm("ecall");
    8000f23c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f240:	00050513          	mv	a0,a0

    return status;

}
    8000f244:	0005051b          	sext.w	a0,a0
    8000f248:	00813403          	ld	s0,8(sp)
    8000f24c:	01010113          	addi	sp,sp,16
    8000f250:	00008067          	ret

000000008000f254 <_Z9sem_closeP10_semaphore>:

int sem_close(sem_t handle){
    8000f254:	ff010113          	addi	sp,sp,-16
    8000f258:	00813423          	sd	s0,8(sp)
    8000f25c:	01010413          	addi	s0,sp,16

    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f260:	00050593          	mv	a1,a0
    asm("li a0, 0x22");
    8000f264:	02200513          	li	a0,34


    asm("ecall");
    8000f268:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f26c:	00050513          	mv	a0,a0

    return status;
}
    8000f270:	0005051b          	sext.w	a0,a0
    8000f274:	00813403          	ld	s0,8(sp)
    8000f278:	01010113          	addi	sp,sp,16
    8000f27c:	00008067          	ret

000000008000f280 <_Z8sem_waitP10_semaphore>:

int sem_wait(sem_t handle){
    8000f280:	ff010113          	addi	sp,sp,-16
    8000f284:	00813423          	sd	s0,8(sp)
    8000f288:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f28c:	00050593          	mv	a1,a0
    asm("li a0, 0x23");
    8000f290:	02300513          	li	a0,35


    asm("ecall");
    8000f294:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f298:	00050513          	mv	a0,a0

    return status;
}
    8000f29c:	0005051b          	sext.w	a0,a0
    8000f2a0:	00813403          	ld	s0,8(sp)
    8000f2a4:	01010113          	addi	sp,sp,16
    8000f2a8:	00008067          	ret

000000008000f2ac <_Z10sem_signalP10_semaphore>:

int sem_signal(sem_t handle){
    8000f2ac:	ff010113          	addi	sp,sp,-16
    8000f2b0:	00813423          	sd	s0,8(sp)
    8000f2b4:	01010413          	addi	s0,sp,16
    uint64 ihandle = (uint64)handle;

    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    8000f2b8:	00050593          	mv	a1,a0
    asm("li a0, 0x24");
    8000f2bc:	02400513          	li	a0,36


    asm("ecall");
    8000f2c0:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f2c4:	00050513          	mv	a0,a0

    return status;
}
    8000f2c8:	0005051b          	sext.w	a0,a0
    8000f2cc:	00813403          	ld	s0,8(sp)
    8000f2d0:	01010113          	addi	sp,sp,16
    8000f2d4:	00008067          	ret

000000008000f2d8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    8000f2d8:	ff010113          	addi	sp,sp,-16
    8000f2dc:	00813423          	sd	s0,8(sp)
    8000f2e0:	01010413          	addi	s0,sp,16
    uint64 itime = (uint64)time;

    asm("mv a1, %[itime]" : : [itime] "r" (itime));
    8000f2e4:	00050593          	mv	a1,a0
    asm("li a0, 0x31");
    8000f2e8:	03100513          	li	a0,49


    asm("ecall");
    8000f2ec:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f2f0:	00050513          	mv	a0,a0

    return status;
}
    8000f2f4:	0005051b          	sext.w	a0,a0
    8000f2f8:	00813403          	ld	s0,8(sp)
    8000f2fc:	01010113          	addi	sp,sp,16
    8000f300:	00008067          	ret

000000008000f304 <_Z4getcv>:

char getc(){
    8000f304:	ff010113          	addi	sp,sp,-16
    8000f308:	00813423          	sd	s0,8(sp)
    8000f30c:	01010413          	addi	s0,sp,16
    asm("li a0, 0x41");
    8000f310:	04100513          	li	a0,65

    asm("ecall");
    8000f314:	00000073          	ecall

    char c;

    asm("mv %[c], a0" : [c] "=r" (c));
    8000f318:	00050513          	mv	a0,a0

    return c;
}
    8000f31c:	0ff57513          	andi	a0,a0,255
    8000f320:	00813403          	ld	s0,8(sp)
    8000f324:	01010113          	addi	sp,sp,16
    8000f328:	00008067          	ret

000000008000f32c <_Z4putcc>:

void putc(char c){
    8000f32c:	ff010113          	addi	sp,sp,-16
    8000f330:	00813423          	sd	s0,8(sp)
    8000f334:	01010413          	addi	s0,sp,16
    asm("mv a1, %[c]" : : [c] "r" ((uint64)c));
    8000f338:	00050593          	mv	a1,a0

    asm("li a0, 0x42");
    8000f33c:	04200513          	li	a0,66

    asm("ecall");
    8000f340:	00000073          	ecall
}
    8000f344:	00813403          	ld	s0,8(sp)
    8000f348:	01010113          	addi	sp,sp,16
    8000f34c:	00008067          	ret

000000008000f350 <_Z4forkv>:


int fork(){
    8000f350:	ff010113          	addi	sp,sp,-16
    8000f354:	00813423          	sd	s0,8(sp)
    8000f358:	01010413          	addi	s0,sp,16
    asm("li a0, 0x61");
    8000f35c:	06100513          	li	a0,97

    asm("ecall");
    8000f360:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
    8000f364:	00050513          	mv	a0,a0

    return status;
}
    8000f368:	0005051b          	sext.w	a0,a0
    8000f36c:	00813403          	ld	s0,8(sp)
    8000f370:	01010113          	addi	sp,sp,16
    8000f374:	00008067          	ret

000000008000f378 <_Z8tcb_freePv>:

void tcb_free(void* addr){
    8000f378:	ff010113          	addi	sp,sp,-16
    8000f37c:	00813423          	sd	s0,8(sp)
    8000f380:	01010413          	addi	s0,sp,16
    uint64 iptr = (uint64)addr;

    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    8000f384:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    8000f388:	05100513          	li	a0,81
    asm("ecall");
    8000f38c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    8000f390:	00813403          	ld	s0,8(sp)
    8000f394:	01010113          	addi	sp,sp,16
    8000f398:	00008067          	ret

000000008000f39c <_ZN10_semaphoredlEPv>:
#include "../../h/_semaphore.hpp"
#include "../../h/printing.hpp"

//operator delete will now call sem_close instead of just deallocating the space
//sem_close will take care of any remaining threads that are blocked and release allocated memory
void _semaphore::operator delete(void *addr){
    8000f39c:	ff010113          	addi	sp,sp,-16
    8000f3a0:	00113423          	sd	ra,8(sp)
    8000f3a4:	00813023          	sd	s0,0(sp)
    8000f3a8:	01010413          	addi	s0,sp,16
    sem_close((sem_t)addr);
    8000f3ac:	00000097          	auipc	ra,0x0
    8000f3b0:	ea8080e7          	jalr	-344(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
}
    8000f3b4:	00813083          	ld	ra,8(sp)
    8000f3b8:	00013403          	ld	s0,0(sp)
    8000f3bc:	01010113          	addi	sp,sp,16
    8000f3c0:	00008067          	ret

000000008000f3c4 <_ZN7_threaddlEPv>:
#include "../../h/_thread.hpp"
#include "../../h/tcb.hpp"
#include "../../h/syscall_c.h"

//operator delete will now call thread_free to safely release all allocated memory
void _thread::operator delete(void *addr){
    8000f3c4:	ff010113          	addi	sp,sp,-16
    8000f3c8:	00113423          	sd	ra,8(sp)
    8000f3cc:	00813023          	sd	s0,0(sp)
    8000f3d0:	01010413          	addi	s0,sp,16
    tcb_free(addr);
    8000f3d4:	00000097          	auipc	ra,0x0
    8000f3d8:	fa4080e7          	jalr	-92(ra) # 8000f378 <_Z8tcb_freePv>
    8000f3dc:	00813083          	ld	ra,8(sp)
    8000f3e0:	00013403          	ld	s0,0(sp)
    8000f3e4:	01010113          	addi	sp,sp,16
    8000f3e8:	00008067          	ret

000000008000f3ec <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000f3ec:	fd010113          	addi	sp,sp,-48
    8000f3f0:	02113423          	sd	ra,40(sp)
    8000f3f4:	02813023          	sd	s0,32(sp)
    8000f3f8:	00913c23          	sd	s1,24(sp)
    8000f3fc:	01213823          	sd	s2,16(sp)
    8000f400:	01313423          	sd	s3,8(sp)
    8000f404:	03010413          	addi	s0,sp,48
    8000f408:	00050493          	mv	s1,a0
    8000f40c:	00058993          	mv	s3,a1
    8000f410:	0015879b          	addiw	a5,a1,1
    8000f414:	0007851b          	sext.w	a0,a5
    8000f418:	00f4a023          	sw	a5,0(s1)
    8000f41c:	0004a823          	sw	zero,16(s1)
    8000f420:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000f424:	00251513          	slli	a0,a0,0x2
    8000f428:	00000097          	auipc	ra,0x0
    8000f42c:	bf8080e7          	jalr	-1032(ra) # 8000f020 <_Z9mem_allocm>
    8000f430:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    8000f434:	01000513          	li	a0,16
    8000f438:	00001097          	auipc	ra,0x1
    8000f43c:	418080e7          	jalr	1048(ra) # 80010850 <_Znwm>
    8000f440:	00050913          	mv	s2,a0
    8000f444:	00050863          	beqz	a0,8000f454 <_ZN9BufferCPPC1Ei+0x68>
    8000f448:	00000593          	li	a1,0
    8000f44c:	00001097          	auipc	ra,0x1
    8000f450:	4fc080e7          	jalr	1276(ra) # 80010948 <_ZN9SemaphoreC1Ej>
    8000f454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000f458:	01000513          	li	a0,16
    8000f45c:	00001097          	auipc	ra,0x1
    8000f460:	3f4080e7          	jalr	1012(ra) # 80010850 <_Znwm>
    8000f464:	00050913          	mv	s2,a0
    8000f468:	00050863          	beqz	a0,8000f478 <_ZN9BufferCPPC1Ei+0x8c>
    8000f46c:	00098593          	mv	a1,s3
    8000f470:	00001097          	auipc	ra,0x1
    8000f474:	4d8080e7          	jalr	1240(ra) # 80010948 <_ZN9SemaphoreC1Ej>
    8000f478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000f47c:	01000513          	li	a0,16
    8000f480:	00001097          	auipc	ra,0x1
    8000f484:	3d0080e7          	jalr	976(ra) # 80010850 <_Znwm>
    8000f488:	00050913          	mv	s2,a0
    8000f48c:	00050863          	beqz	a0,8000f49c <_ZN9BufferCPPC1Ei+0xb0>
    8000f490:	00100593          	li	a1,1
    8000f494:	00001097          	auipc	ra,0x1
    8000f498:	4b4080e7          	jalr	1204(ra) # 80010948 <_ZN9SemaphoreC1Ej>
    8000f49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000f4a0:	01000513          	li	a0,16
    8000f4a4:	00001097          	auipc	ra,0x1
    8000f4a8:	3ac080e7          	jalr	940(ra) # 80010850 <_Znwm>
    8000f4ac:	00050913          	mv	s2,a0
    8000f4b0:	00050863          	beqz	a0,8000f4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000f4b4:	00100593          	li	a1,1
    8000f4b8:	00001097          	auipc	ra,0x1
    8000f4bc:	490080e7          	jalr	1168(ra) # 80010948 <_ZN9SemaphoreC1Ej>
    8000f4c0:	0324b823          	sd	s2,48(s1)
}
    8000f4c4:	02813083          	ld	ra,40(sp)
    8000f4c8:	02013403          	ld	s0,32(sp)
    8000f4cc:	01813483          	ld	s1,24(sp)
    8000f4d0:	01013903          	ld	s2,16(sp)
    8000f4d4:	00813983          	ld	s3,8(sp)
    8000f4d8:	03010113          	addi	sp,sp,48
    8000f4dc:	00008067          	ret
    8000f4e0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000f4e4:	00090513          	mv	a0,s2
    8000f4e8:	00001097          	auipc	ra,0x1
    8000f4ec:	3b8080e7          	jalr	952(ra) # 800108a0 <_ZdlPv>
    8000f4f0:	00048513          	mv	a0,s1
    8000f4f4:	ffffe097          	auipc	ra,0xffffe
    8000f4f8:	934080e7          	jalr	-1740(ra) # 8000ce28 <_Unwind_Resume>
    8000f4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000f500:	00090513          	mv	a0,s2
    8000f504:	00001097          	auipc	ra,0x1
    8000f508:	39c080e7          	jalr	924(ra) # 800108a0 <_ZdlPv>
    8000f50c:	00048513          	mv	a0,s1
    8000f510:	ffffe097          	auipc	ra,0xffffe
    8000f514:	918080e7          	jalr	-1768(ra) # 8000ce28 <_Unwind_Resume>
    8000f518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000f51c:	00090513          	mv	a0,s2
    8000f520:	00001097          	auipc	ra,0x1
    8000f524:	380080e7          	jalr	896(ra) # 800108a0 <_ZdlPv>
    8000f528:	00048513          	mv	a0,s1
    8000f52c:	ffffe097          	auipc	ra,0xffffe
    8000f530:	8fc080e7          	jalr	-1796(ra) # 8000ce28 <_Unwind_Resume>
    8000f534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000f538:	00090513          	mv	a0,s2
    8000f53c:	00001097          	auipc	ra,0x1
    8000f540:	364080e7          	jalr	868(ra) # 800108a0 <_ZdlPv>
    8000f544:	00048513          	mv	a0,s1
    8000f548:	ffffe097          	auipc	ra,0xffffe
    8000f54c:	8e0080e7          	jalr	-1824(ra) # 8000ce28 <_Unwind_Resume>

000000008000f550 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    8000f550:	fe010113          	addi	sp,sp,-32
    8000f554:	00113c23          	sd	ra,24(sp)
    8000f558:	00813823          	sd	s0,16(sp)
    8000f55c:	00913423          	sd	s1,8(sp)
    8000f560:	01213023          	sd	s2,0(sp)
    8000f564:	02010413          	addi	s0,sp,32
    8000f568:	00050493          	mv	s1,a0
    8000f56c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    8000f570:	01853503          	ld	a0,24(a0) # 1018 <_entry-0x7fffefe8>
    8000f574:	00001097          	auipc	ra,0x1
    8000f578:	40c080e7          	jalr	1036(ra) # 80010980 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000f57c:	0304b503          	ld	a0,48(s1)
    8000f580:	00001097          	auipc	ra,0x1
    8000f584:	400080e7          	jalr	1024(ra) # 80010980 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000f588:	0084b783          	ld	a5,8(s1)
    8000f58c:	0144a703          	lw	a4,20(s1)
    8000f590:	00271713          	slli	a4,a4,0x2
    8000f594:	00e787b3          	add	a5,a5,a4
    8000f598:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000f59c:	0144a783          	lw	a5,20(s1)
    8000f5a0:	0017879b          	addiw	a5,a5,1
    8000f5a4:	0004a703          	lw	a4,0(s1)
    8000f5a8:	02e7e7bb          	remw	a5,a5,a4
    8000f5ac:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    8000f5b0:	0304b503          	ld	a0,48(s1)
    8000f5b4:	00001097          	auipc	ra,0x1
    8000f5b8:	3f8080e7          	jalr	1016(ra) # 800109ac <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000f5bc:	0204b503          	ld	a0,32(s1)
    8000f5c0:	00001097          	auipc	ra,0x1
    8000f5c4:	3ec080e7          	jalr	1004(ra) # 800109ac <_ZN9Semaphore6signalEv>

}
    8000f5c8:	01813083          	ld	ra,24(sp)
    8000f5cc:	01013403          	ld	s0,16(sp)
    8000f5d0:	00813483          	ld	s1,8(sp)
    8000f5d4:	00013903          	ld	s2,0(sp)
    8000f5d8:	02010113          	addi	sp,sp,32
    8000f5dc:	00008067          	ret

000000008000f5e0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    8000f5e0:	fe010113          	addi	sp,sp,-32
    8000f5e4:	00113c23          	sd	ra,24(sp)
    8000f5e8:	00813823          	sd	s0,16(sp)
    8000f5ec:	00913423          	sd	s1,8(sp)
    8000f5f0:	01213023          	sd	s2,0(sp)
    8000f5f4:	02010413          	addi	s0,sp,32
    8000f5f8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000f5fc:	02053503          	ld	a0,32(a0)
    8000f600:	00001097          	auipc	ra,0x1
    8000f604:	380080e7          	jalr	896(ra) # 80010980 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000f608:	0284b503          	ld	a0,40(s1)
    8000f60c:	00001097          	auipc	ra,0x1
    8000f610:	374080e7          	jalr	884(ra) # 80010980 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000f614:	0084b703          	ld	a4,8(s1)
    8000f618:	0104a783          	lw	a5,16(s1)
    8000f61c:	00279693          	slli	a3,a5,0x2
    8000f620:	00d70733          	add	a4,a4,a3
    8000f624:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000f628:	0017879b          	addiw	a5,a5,1
    8000f62c:	0004a703          	lw	a4,0(s1)
    8000f630:	02e7e7bb          	remw	a5,a5,a4
    8000f634:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000f638:	0284b503          	ld	a0,40(s1)
    8000f63c:	00001097          	auipc	ra,0x1
    8000f640:	370080e7          	jalr	880(ra) # 800109ac <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000f644:	0184b503          	ld	a0,24(s1)
    8000f648:	00001097          	auipc	ra,0x1
    8000f64c:	364080e7          	jalr	868(ra) # 800109ac <_ZN9Semaphore6signalEv>

    return ret;
}
    8000f650:	00090513          	mv	a0,s2
    8000f654:	01813083          	ld	ra,24(sp)
    8000f658:	01013403          	ld	s0,16(sp)
    8000f65c:	00813483          	ld	s1,8(sp)
    8000f660:	00013903          	ld	s2,0(sp)
    8000f664:	02010113          	addi	sp,sp,32
    8000f668:	00008067          	ret

000000008000f66c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    8000f66c:	fe010113          	addi	sp,sp,-32
    8000f670:	00113c23          	sd	ra,24(sp)
    8000f674:	00813823          	sd	s0,16(sp)
    8000f678:	00913423          	sd	s1,8(sp)
    8000f67c:	01213023          	sd	s2,0(sp)
    8000f680:	02010413          	addi	s0,sp,32
    8000f684:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000f688:	02853503          	ld	a0,40(a0)
    8000f68c:	00001097          	auipc	ra,0x1
    8000f690:	2f4080e7          	jalr	756(ra) # 80010980 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000f694:	0304b503          	ld	a0,48(s1)
    8000f698:	00001097          	auipc	ra,0x1
    8000f69c:	2e8080e7          	jalr	744(ra) # 80010980 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    8000f6a0:	0144a783          	lw	a5,20(s1)
    8000f6a4:	0104a903          	lw	s2,16(s1)
    8000f6a8:	0327ce63          	blt	a5,s2,8000f6e4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000f6ac:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    8000f6b0:	0304b503          	ld	a0,48(s1)
    8000f6b4:	00001097          	auipc	ra,0x1
    8000f6b8:	2f8080e7          	jalr	760(ra) # 800109ac <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000f6bc:	0284b503          	ld	a0,40(s1)
    8000f6c0:	00001097          	auipc	ra,0x1
    8000f6c4:	2ec080e7          	jalr	748(ra) # 800109ac <_ZN9Semaphore6signalEv>

    return ret;
}
    8000f6c8:	00090513          	mv	a0,s2
    8000f6cc:	01813083          	ld	ra,24(sp)
    8000f6d0:	01013403          	ld	s0,16(sp)
    8000f6d4:	00813483          	ld	s1,8(sp)
    8000f6d8:	00013903          	ld	s2,0(sp)
    8000f6dc:	02010113          	addi	sp,sp,32
    8000f6e0:	00008067          	ret
        ret = cap - head + tail;
    8000f6e4:	0004a703          	lw	a4,0(s1)
    8000f6e8:	4127093b          	subw	s2,a4,s2
    8000f6ec:	00f9093b          	addw	s2,s2,a5
    8000f6f0:	fc1ff06f          	j	8000f6b0 <_ZN9BufferCPP6getCntEv+0x44>

000000008000f6f4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000f6f4:	fe010113          	addi	sp,sp,-32
    8000f6f8:	00113c23          	sd	ra,24(sp)
    8000f6fc:	00813823          	sd	s0,16(sp)
    8000f700:	00913423          	sd	s1,8(sp)
    8000f704:	02010413          	addi	s0,sp,32
    8000f708:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000f70c:	00a00513          	li	a0,10
    8000f710:	00001097          	auipc	ra,0x1
    8000f714:	4d4080e7          	jalr	1236(ra) # 80010be4 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000f718:	00002517          	auipc	a0,0x2
    8000f71c:	8e850513          	addi	a0,a0,-1816 # 80011000 <userDataStart>
    8000f720:	00001097          	auipc	ra,0x1
    8000f724:	d84080e7          	jalr	-636(ra) # 800104a4 <_Z11printStringPKc>
    while (getCnt()) {
    8000f728:	00048513          	mv	a0,s1
    8000f72c:	00000097          	auipc	ra,0x0
    8000f730:	f40080e7          	jalr	-192(ra) # 8000f66c <_ZN9BufferCPP6getCntEv>
    8000f734:	02050c63          	beqz	a0,8000f76c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000f738:	0084b783          	ld	a5,8(s1)
    8000f73c:	0104a703          	lw	a4,16(s1)
    8000f740:	00271713          	slli	a4,a4,0x2
    8000f744:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000f748:	0007c503          	lbu	a0,0(a5)
    8000f74c:	00001097          	auipc	ra,0x1
    8000f750:	498080e7          	jalr	1176(ra) # 80010be4 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000f754:	0104a783          	lw	a5,16(s1)
    8000f758:	0017879b          	addiw	a5,a5,1
    8000f75c:	0004a703          	lw	a4,0(s1)
    8000f760:	02e7e7bb          	remw	a5,a5,a4
    8000f764:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000f768:	fc1ff06f          	j	8000f728 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    8000f76c:	02100513          	li	a0,33
    8000f770:	00001097          	auipc	ra,0x1
    8000f774:	474080e7          	jalr	1140(ra) # 80010be4 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000f778:	00a00513          	li	a0,10
    8000f77c:	00001097          	auipc	ra,0x1
    8000f780:	468080e7          	jalr	1128(ra) # 80010be4 <_ZN7Console4putcEc>
    mem_free(buffer);
    8000f784:	0084b503          	ld	a0,8(s1)
    8000f788:	00000097          	auipc	ra,0x0
    8000f78c:	8c8080e7          	jalr	-1848(ra) # 8000f050 <_Z8mem_freePv>
    delete itemAvailable;
    8000f790:	0204b503          	ld	a0,32(s1)
    8000f794:	00050863          	beqz	a0,8000f7a4 <_ZN9BufferCPPD1Ev+0xb0>
    8000f798:	00053783          	ld	a5,0(a0)
    8000f79c:	0087b783          	ld	a5,8(a5)
    8000f7a0:	000780e7          	jalr	a5
    delete spaceAvailable;
    8000f7a4:	0184b503          	ld	a0,24(s1)
    8000f7a8:	00050863          	beqz	a0,8000f7b8 <_ZN9BufferCPPD1Ev+0xc4>
    8000f7ac:	00053783          	ld	a5,0(a0)
    8000f7b0:	0087b783          	ld	a5,8(a5)
    8000f7b4:	000780e7          	jalr	a5
    delete mutexTail;
    8000f7b8:	0304b503          	ld	a0,48(s1)
    8000f7bc:	00050863          	beqz	a0,8000f7cc <_ZN9BufferCPPD1Ev+0xd8>
    8000f7c0:	00053783          	ld	a5,0(a0)
    8000f7c4:	0087b783          	ld	a5,8(a5)
    8000f7c8:	000780e7          	jalr	a5
    delete mutexHead;
    8000f7cc:	0284b503          	ld	a0,40(s1)
    8000f7d0:	00050863          	beqz	a0,8000f7e0 <_ZN9BufferCPPD1Ev+0xec>
    8000f7d4:	00053783          	ld	a5,0(a0)
    8000f7d8:	0087b783          	ld	a5,8(a5)
    8000f7dc:	000780e7          	jalr	a5
}
    8000f7e0:	01813083          	ld	ra,24(sp)
    8000f7e4:	01013403          	ld	s0,16(sp)
    8000f7e8:	00813483          	ld	s1,8(sp)
    8000f7ec:	02010113          	addi	sp,sp,32
    8000f7f0:	00008067          	ret

000000008000f7f4 <_Z11workerBodyAPv>:
    if (n == 0 || n == 1) { return n; }
    if (n % 10 == 0) { thread_dispatch(); }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyA(void* arg) {
    8000f7f4:	fe010113          	addi	sp,sp,-32
    8000f7f8:	00113c23          	sd	ra,24(sp)
    8000f7fc:	00813823          	sd	s0,16(sp)
    8000f800:	00913423          	sd	s1,8(sp)
    8000f804:	01213023          	sd	s2,0(sp)
    8000f808:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000f80c:	00000913          	li	s2,0
    8000f810:	0380006f          	j	8000f848 <_Z11workerBodyAPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000f814:	00000097          	auipc	ra,0x0
    8000f818:	91c080e7          	jalr	-1764(ra) # 8000f130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000f81c:	00148493          	addi	s1,s1,1
    8000f820:	000027b7          	lui	a5,0x2
    8000f824:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000f828:	0097ee63          	bltu	a5,s1,8000f844 <_Z11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000f82c:	00000713          	li	a4,0
    8000f830:	000077b7          	lui	a5,0x7
    8000f834:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000f838:	fce7eee3          	bltu	a5,a4,8000f814 <_Z11workerBodyAPv+0x20>
    8000f83c:	00170713          	addi	a4,a4,1
    8000f840:	ff1ff06f          	j	8000f830 <_Z11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000f844:	00190913          	addi	s2,s2,1
    8000f848:	00900793          	li	a5,9
    8000f84c:	0527e063          	bltu	a5,s2,8000f88c <_Z11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000f850:	00001517          	auipc	a0,0x1
    8000f854:	7c850513          	addi	a0,a0,1992 # 80011018 <userDataStart+0x18>
    8000f858:	00001097          	auipc	ra,0x1
    8000f85c:	c4c080e7          	jalr	-948(ra) # 800104a4 <_Z11printStringPKc>
    8000f860:	00000613          	li	a2,0
    8000f864:	00a00593          	li	a1,10
    8000f868:	0009051b          	sext.w	a0,s2
    8000f86c:	00001097          	auipc	ra,0x1
    8000f870:	dd0080e7          	jalr	-560(ra) # 8001063c <_Z8printIntiii>
    8000f874:	00001517          	auipc	a0,0x1
    8000f878:	7ac50513          	addi	a0,a0,1964 # 80011020 <userDataStart+0x20>
    8000f87c:	00001097          	auipc	ra,0x1
    8000f880:	c28080e7          	jalr	-984(ra) # 800104a4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000f884:	00000493          	li	s1,0
    8000f888:	f99ff06f          	j	8000f820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000f88c:	00001517          	auipc	a0,0x1
    8000f890:	79c50513          	addi	a0,a0,1948 # 80011028 <userDataStart+0x28>
    8000f894:	00001097          	auipc	ra,0x1
    8000f898:	c10080e7          	jalr	-1008(ra) # 800104a4 <_Z11printStringPKc>
    finishedA = true;
    8000f89c:	00100793          	li	a5,1
    8000f8a0:	00002717          	auipc	a4,0x2
    8000f8a4:	96f70c23          	sb	a5,-1672(a4) # 80011218 <finishedA>
}
    8000f8a8:	01813083          	ld	ra,24(sp)
    8000f8ac:	01013403          	ld	s0,16(sp)
    8000f8b0:	00813483          	ld	s1,8(sp)
    8000f8b4:	00013903          	ld	s2,0(sp)
    8000f8b8:	02010113          	addi	sp,sp,32
    8000f8bc:	00008067          	ret

000000008000f8c0 <_Z11workerBodyBPv>:

void workerBodyB(void* arg) {
    8000f8c0:	fe010113          	addi	sp,sp,-32
    8000f8c4:	00113c23          	sd	ra,24(sp)
    8000f8c8:	00813823          	sd	s0,16(sp)
    8000f8cc:	00913423          	sd	s1,8(sp)
    8000f8d0:	01213023          	sd	s2,0(sp)
    8000f8d4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000f8d8:	00000913          	li	s2,0
    8000f8dc:	0380006f          	j	8000f914 <_Z11workerBodyBPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000f8e0:	00000097          	auipc	ra,0x0
    8000f8e4:	850080e7          	jalr	-1968(ra) # 8000f130 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000f8e8:	00148493          	addi	s1,s1,1
    8000f8ec:	000027b7          	lui	a5,0x2
    8000f8f0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000f8f4:	0097ee63          	bltu	a5,s1,8000f910 <_Z11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000f8f8:	00000713          	li	a4,0
    8000f8fc:	000077b7          	lui	a5,0x7
    8000f900:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000f904:	fce7eee3          	bltu	a5,a4,8000f8e0 <_Z11workerBodyBPv+0x20>
    8000f908:	00170713          	addi	a4,a4,1
    8000f90c:	ff1ff06f          	j	8000f8fc <_Z11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000f910:	00190913          	addi	s2,s2,1
    8000f914:	00f00793          	li	a5,15
    8000f918:	0527e063          	bltu	a5,s2,8000f958 <_Z11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000f91c:	00001517          	auipc	a0,0x1
    8000f920:	71c50513          	addi	a0,a0,1820 # 80011038 <userDataStart+0x38>
    8000f924:	00001097          	auipc	ra,0x1
    8000f928:	b80080e7          	jalr	-1152(ra) # 800104a4 <_Z11printStringPKc>
    8000f92c:	00000613          	li	a2,0
    8000f930:	00a00593          	li	a1,10
    8000f934:	0009051b          	sext.w	a0,s2
    8000f938:	00001097          	auipc	ra,0x1
    8000f93c:	d04080e7          	jalr	-764(ra) # 8001063c <_Z8printIntiii>
    8000f940:	00001517          	auipc	a0,0x1
    8000f944:	6e050513          	addi	a0,a0,1760 # 80011020 <userDataStart+0x20>
    8000f948:	00001097          	auipc	ra,0x1
    8000f94c:	b5c080e7          	jalr	-1188(ra) # 800104a4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000f950:	00000493          	li	s1,0
    8000f954:	f99ff06f          	j	8000f8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000f958:	00001517          	auipc	a0,0x1
    8000f95c:	6e850513          	addi	a0,a0,1768 # 80011040 <userDataStart+0x40>
    8000f960:	00001097          	auipc	ra,0x1
    8000f964:	b44080e7          	jalr	-1212(ra) # 800104a4 <_Z11printStringPKc>
    finishedB = true;
    8000f968:	00100793          	li	a5,1
    8000f96c:	00002717          	auipc	a4,0x2
    8000f970:	8af706a3          	sb	a5,-1875(a4) # 80011219 <finishedB>
    thread_dispatch();
    8000f974:	fffff097          	auipc	ra,0xfffff
    8000f978:	7bc080e7          	jalr	1980(ra) # 8000f130 <_Z15thread_dispatchv>
}
    8000f97c:	01813083          	ld	ra,24(sp)
    8000f980:	01013403          	ld	s0,16(sp)
    8000f984:	00813483          	ld	s1,8(sp)
    8000f988:	00013903          	ld	s2,0(sp)
    8000f98c:	02010113          	addi	sp,sp,32
    8000f990:	00008067          	ret

000000008000f994 <_Z9fibonaccim>:
uint64 fibonacci(uint64 n) {
    8000f994:	fe010113          	addi	sp,sp,-32
    8000f998:	00113c23          	sd	ra,24(sp)
    8000f99c:	00813823          	sd	s0,16(sp)
    8000f9a0:	00913423          	sd	s1,8(sp)
    8000f9a4:	01213023          	sd	s2,0(sp)
    8000f9a8:	02010413          	addi	s0,sp,32
    8000f9ac:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000f9b0:	00100793          	li	a5,1
    8000f9b4:	02a7f863          	bgeu	a5,a0,8000f9e4 <_Z9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000f9b8:	00a00793          	li	a5,10
    8000f9bc:	02f577b3          	remu	a5,a0,a5
    8000f9c0:	02078e63          	beqz	a5,8000f9fc <_Z9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000f9c4:	fff48513          	addi	a0,s1,-1
    8000f9c8:	00000097          	auipc	ra,0x0
    8000f9cc:	fcc080e7          	jalr	-52(ra) # 8000f994 <_Z9fibonaccim>
    8000f9d0:	00050913          	mv	s2,a0
    8000f9d4:	ffe48513          	addi	a0,s1,-2
    8000f9d8:	00000097          	auipc	ra,0x0
    8000f9dc:	fbc080e7          	jalr	-68(ra) # 8000f994 <_Z9fibonaccim>
    8000f9e0:	00a90533          	add	a0,s2,a0
}
    8000f9e4:	01813083          	ld	ra,24(sp)
    8000f9e8:	01013403          	ld	s0,16(sp)
    8000f9ec:	00813483          	ld	s1,8(sp)
    8000f9f0:	00013903          	ld	s2,0(sp)
    8000f9f4:	02010113          	addi	sp,sp,32
    8000f9f8:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000f9fc:	fffff097          	auipc	ra,0xfffff
    8000fa00:	734080e7          	jalr	1844(ra) # 8000f130 <_Z15thread_dispatchv>
    8000fa04:	fc1ff06f          	j	8000f9c4 <_Z9fibonaccim+0x30>

000000008000fa08 <_Z11workerBodyCPv>:

void workerBodyC(void* arg) {
    8000fa08:	fe010113          	addi	sp,sp,-32
    8000fa0c:	00113c23          	sd	ra,24(sp)
    8000fa10:	00813823          	sd	s0,16(sp)
    8000fa14:	00913423          	sd	s1,8(sp)
    8000fa18:	01213023          	sd	s2,0(sp)
    8000fa1c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000fa20:	00000493          	li	s1,0
    8000fa24:	0400006f          	j	8000fa64 <_Z11workerBodyCPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000fa28:	00001517          	auipc	a0,0x1
    8000fa2c:	62850513          	addi	a0,a0,1576 # 80011050 <userDataStart+0x50>
    8000fa30:	00001097          	auipc	ra,0x1
    8000fa34:	a74080e7          	jalr	-1420(ra) # 800104a4 <_Z11printStringPKc>
    8000fa38:	00000613          	li	a2,0
    8000fa3c:	00a00593          	li	a1,10
    8000fa40:	00048513          	mv	a0,s1
    8000fa44:	00001097          	auipc	ra,0x1
    8000fa48:	bf8080e7          	jalr	-1032(ra) # 8001063c <_Z8printIntiii>
    8000fa4c:	00001517          	auipc	a0,0x1
    8000fa50:	5d450513          	addi	a0,a0,1492 # 80011020 <userDataStart+0x20>
    8000fa54:	00001097          	auipc	ra,0x1
    8000fa58:	a50080e7          	jalr	-1456(ra) # 800104a4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000fa5c:	0014849b          	addiw	s1,s1,1
    8000fa60:	0ff4f493          	andi	s1,s1,255
    8000fa64:	00200793          	li	a5,2
    8000fa68:	fc97f0e3          	bgeu	a5,s1,8000fa28 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    8000fa6c:	00001517          	auipc	a0,0x1
    8000fa70:	5ec50513          	addi	a0,a0,1516 # 80011058 <userDataStart+0x58>
    8000fa74:	00001097          	auipc	ra,0x1
    8000fa78:	a30080e7          	jalr	-1488(ra) # 800104a4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000fa7c:	00700313          	li	t1,7
    thread_dispatch();
    8000fa80:	fffff097          	auipc	ra,0xfffff
    8000fa84:	6b0080e7          	jalr	1712(ra) # 8000f130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000fa88:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000fa8c:	00001517          	auipc	a0,0x1
    8000fa90:	5dc50513          	addi	a0,a0,1500 # 80011068 <userDataStart+0x68>
    8000fa94:	00001097          	auipc	ra,0x1
    8000fa98:	a10080e7          	jalr	-1520(ra) # 800104a4 <_Z11printStringPKc>
    8000fa9c:	00000613          	li	a2,0
    8000faa0:	00a00593          	li	a1,10
    8000faa4:	0009051b          	sext.w	a0,s2
    8000faa8:	00001097          	auipc	ra,0x1
    8000faac:	b94080e7          	jalr	-1132(ra) # 8001063c <_Z8printIntiii>
    8000fab0:	00001517          	auipc	a0,0x1
    8000fab4:	57050513          	addi	a0,a0,1392 # 80011020 <userDataStart+0x20>
    8000fab8:	00001097          	auipc	ra,0x1
    8000fabc:	9ec080e7          	jalr	-1556(ra) # 800104a4 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000fac0:	00c00513          	li	a0,12
    8000fac4:	00000097          	auipc	ra,0x0
    8000fac8:	ed0080e7          	jalr	-304(ra) # 8000f994 <_Z9fibonaccim>
    8000facc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000fad0:	00001517          	auipc	a0,0x1
    8000fad4:	5a050513          	addi	a0,a0,1440 # 80011070 <userDataStart+0x70>
    8000fad8:	00001097          	auipc	ra,0x1
    8000fadc:	9cc080e7          	jalr	-1588(ra) # 800104a4 <_Z11printStringPKc>
    8000fae0:	00000613          	li	a2,0
    8000fae4:	00a00593          	li	a1,10
    8000fae8:	0009051b          	sext.w	a0,s2
    8000faec:	00001097          	auipc	ra,0x1
    8000faf0:	b50080e7          	jalr	-1200(ra) # 8001063c <_Z8printIntiii>
    8000faf4:	00001517          	auipc	a0,0x1
    8000faf8:	52c50513          	addi	a0,a0,1324 # 80011020 <userDataStart+0x20>
    8000fafc:	00001097          	auipc	ra,0x1
    8000fb00:	9a8080e7          	jalr	-1624(ra) # 800104a4 <_Z11printStringPKc>
    8000fb04:	0400006f          	j	8000fb44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000fb08:	00001517          	auipc	a0,0x1
    8000fb0c:	54850513          	addi	a0,a0,1352 # 80011050 <userDataStart+0x50>
    8000fb10:	00001097          	auipc	ra,0x1
    8000fb14:	994080e7          	jalr	-1644(ra) # 800104a4 <_Z11printStringPKc>
    8000fb18:	00000613          	li	a2,0
    8000fb1c:	00a00593          	li	a1,10
    8000fb20:	00048513          	mv	a0,s1
    8000fb24:	00001097          	auipc	ra,0x1
    8000fb28:	b18080e7          	jalr	-1256(ra) # 8001063c <_Z8printIntiii>
    8000fb2c:	00001517          	auipc	a0,0x1
    8000fb30:	4f450513          	addi	a0,a0,1268 # 80011020 <userDataStart+0x20>
    8000fb34:	00001097          	auipc	ra,0x1
    8000fb38:	970080e7          	jalr	-1680(ra) # 800104a4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000fb3c:	0014849b          	addiw	s1,s1,1
    8000fb40:	0ff4f493          	andi	s1,s1,255
    8000fb44:	00500793          	li	a5,5
    8000fb48:	fc97f0e3          	bgeu	a5,s1,8000fb08 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    8000fb4c:	00001517          	auipc	a0,0x1
    8000fb50:	4dc50513          	addi	a0,a0,1244 # 80011028 <userDataStart+0x28>
    8000fb54:	00001097          	auipc	ra,0x1
    8000fb58:	950080e7          	jalr	-1712(ra) # 800104a4 <_Z11printStringPKc>
    finishedC = true;
    8000fb5c:	00100793          	li	a5,1
    8000fb60:	00001717          	auipc	a4,0x1
    8000fb64:	6af70d23          	sb	a5,1722(a4) # 8001121a <finishedC>
    thread_dispatch();
    8000fb68:	fffff097          	auipc	ra,0xfffff
    8000fb6c:	5c8080e7          	jalr	1480(ra) # 8000f130 <_Z15thread_dispatchv>
}
    8000fb70:	01813083          	ld	ra,24(sp)
    8000fb74:	01013403          	ld	s0,16(sp)
    8000fb78:	00813483          	ld	s1,8(sp)
    8000fb7c:	00013903          	ld	s2,0(sp)
    8000fb80:	02010113          	addi	sp,sp,32
    8000fb84:	00008067          	ret

000000008000fb88 <_Z11workerBodyDPv>:

void workerBodyD(void* arg) {
    8000fb88:	fe010113          	addi	sp,sp,-32
    8000fb8c:	00113c23          	sd	ra,24(sp)
    8000fb90:	00813823          	sd	s0,16(sp)
    8000fb94:	00913423          	sd	s1,8(sp)
    8000fb98:	01213023          	sd	s2,0(sp)
    8000fb9c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000fba0:	00a00493          	li	s1,10
    8000fba4:	0400006f          	j	8000fbe4 <_Z11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000fba8:	00001517          	auipc	a0,0x1
    8000fbac:	4d850513          	addi	a0,a0,1240 # 80011080 <userDataStart+0x80>
    8000fbb0:	00001097          	auipc	ra,0x1
    8000fbb4:	8f4080e7          	jalr	-1804(ra) # 800104a4 <_Z11printStringPKc>
    8000fbb8:	00000613          	li	a2,0
    8000fbbc:	00a00593          	li	a1,10
    8000fbc0:	00048513          	mv	a0,s1
    8000fbc4:	00001097          	auipc	ra,0x1
    8000fbc8:	a78080e7          	jalr	-1416(ra) # 8001063c <_Z8printIntiii>
    8000fbcc:	00001517          	auipc	a0,0x1
    8000fbd0:	45450513          	addi	a0,a0,1108 # 80011020 <userDataStart+0x20>
    8000fbd4:	00001097          	auipc	ra,0x1
    8000fbd8:	8d0080e7          	jalr	-1840(ra) # 800104a4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000fbdc:	0014849b          	addiw	s1,s1,1
    8000fbe0:	0ff4f493          	andi	s1,s1,255
    8000fbe4:	00c00793          	li	a5,12
    8000fbe8:	fc97f0e3          	bgeu	a5,s1,8000fba8 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000fbec:	00001517          	auipc	a0,0x1
    8000fbf0:	49c50513          	addi	a0,a0,1180 # 80011088 <userDataStart+0x88>
    8000fbf4:	00001097          	auipc	ra,0x1
    8000fbf8:	8b0080e7          	jalr	-1872(ra) # 800104a4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000fbfc:	00500313          	li	t1,5
    thread_dispatch();
    8000fc00:	fffff097          	auipc	ra,0xfffff
    8000fc04:	530080e7          	jalr	1328(ra) # 8000f130 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000fc08:	01000513          	li	a0,16
    8000fc0c:	00000097          	auipc	ra,0x0
    8000fc10:	d88080e7          	jalr	-632(ra) # 8000f994 <_Z9fibonaccim>
    8000fc14:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000fc18:	00001517          	auipc	a0,0x1
    8000fc1c:	48050513          	addi	a0,a0,1152 # 80011098 <userDataStart+0x98>
    8000fc20:	00001097          	auipc	ra,0x1
    8000fc24:	884080e7          	jalr	-1916(ra) # 800104a4 <_Z11printStringPKc>
    8000fc28:	00000613          	li	a2,0
    8000fc2c:	00a00593          	li	a1,10
    8000fc30:	0009051b          	sext.w	a0,s2
    8000fc34:	00001097          	auipc	ra,0x1
    8000fc38:	a08080e7          	jalr	-1528(ra) # 8001063c <_Z8printIntiii>
    8000fc3c:	00001517          	auipc	a0,0x1
    8000fc40:	3e450513          	addi	a0,a0,996 # 80011020 <userDataStart+0x20>
    8000fc44:	00001097          	auipc	ra,0x1
    8000fc48:	860080e7          	jalr	-1952(ra) # 800104a4 <_Z11printStringPKc>
    8000fc4c:	0400006f          	j	8000fc8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000fc50:	00001517          	auipc	a0,0x1
    8000fc54:	43050513          	addi	a0,a0,1072 # 80011080 <userDataStart+0x80>
    8000fc58:	00001097          	auipc	ra,0x1
    8000fc5c:	84c080e7          	jalr	-1972(ra) # 800104a4 <_Z11printStringPKc>
    8000fc60:	00000613          	li	a2,0
    8000fc64:	00a00593          	li	a1,10
    8000fc68:	00048513          	mv	a0,s1
    8000fc6c:	00001097          	auipc	ra,0x1
    8000fc70:	9d0080e7          	jalr	-1584(ra) # 8001063c <_Z8printIntiii>
    8000fc74:	00001517          	auipc	a0,0x1
    8000fc78:	3ac50513          	addi	a0,a0,940 # 80011020 <userDataStart+0x20>
    8000fc7c:	00001097          	auipc	ra,0x1
    8000fc80:	828080e7          	jalr	-2008(ra) # 800104a4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000fc84:	0014849b          	addiw	s1,s1,1
    8000fc88:	0ff4f493          	andi	s1,s1,255
    8000fc8c:	00f00793          	li	a5,15
    8000fc90:	fc97f0e3          	bgeu	a5,s1,8000fc50 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000fc94:	00001517          	auipc	a0,0x1
    8000fc98:	41450513          	addi	a0,a0,1044 # 800110a8 <userDataStart+0xa8>
    8000fc9c:	00001097          	auipc	ra,0x1
    8000fca0:	808080e7          	jalr	-2040(ra) # 800104a4 <_Z11printStringPKc>
    finishedD = true;
    8000fca4:	00100793          	li	a5,1
    8000fca8:	00001717          	auipc	a4,0x1
    8000fcac:	56f709a3          	sb	a5,1395(a4) # 8001121b <finishedD>
    thread_dispatch();
    8000fcb0:	fffff097          	auipc	ra,0xfffff
    8000fcb4:	480080e7          	jalr	1152(ra) # 8000f130 <_Z15thread_dispatchv>
}
    8000fcb8:	01813083          	ld	ra,24(sp)
    8000fcbc:	01013403          	ld	s0,16(sp)
    8000fcc0:	00813483          	ld	s1,8(sp)
    8000fcc4:	00013903          	ld	s2,0(sp)
    8000fcc8:	02010113          	addi	sp,sp,32
    8000fccc:	00008067          	ret

000000008000fcd0 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    8000fcd0:	fc010113          	addi	sp,sp,-64
    8000fcd4:	02113c23          	sd	ra,56(sp)
    8000fcd8:	02813823          	sd	s0,48(sp)
    8000fcdc:	02913423          	sd	s1,40(sp)
    8000fce0:	04010413          	addi	s0,sp,64
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000fce4:	00000613          	li	a2,0
    8000fce8:	00000597          	auipc	a1,0x0
    8000fcec:	b0c58593          	addi	a1,a1,-1268 # 8000f7f4 <_Z11workerBodyAPv>
    8000fcf0:	fc040513          	addi	a0,s0,-64
    8000fcf4:	fffff097          	auipc	ra,0xfffff
    8000fcf8:	388080e7          	jalr	904(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000fcfc:	00001517          	auipc	a0,0x1
    8000fd00:	3bc50513          	addi	a0,a0,956 # 800110b8 <userDataStart+0xb8>
    8000fd04:	00000097          	auipc	ra,0x0
    8000fd08:	7a0080e7          	jalr	1952(ra) # 800104a4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000fd0c:	00000613          	li	a2,0
    8000fd10:	00000597          	auipc	a1,0x0
    8000fd14:	bb058593          	addi	a1,a1,-1104 # 8000f8c0 <_Z11workerBodyBPv>
    8000fd18:	fc840513          	addi	a0,s0,-56
    8000fd1c:	fffff097          	auipc	ra,0xfffff
    8000fd20:	360080e7          	jalr	864(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000fd24:	00001517          	auipc	a0,0x1
    8000fd28:	3ac50513          	addi	a0,a0,940 # 800110d0 <userDataStart+0xd0>
    8000fd2c:	00000097          	auipc	ra,0x0
    8000fd30:	778080e7          	jalr	1912(ra) # 800104a4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000fd34:	00000613          	li	a2,0
    8000fd38:	00000597          	auipc	a1,0x0
    8000fd3c:	cd058593          	addi	a1,a1,-816 # 8000fa08 <_Z11workerBodyCPv>
    8000fd40:	fd040513          	addi	a0,s0,-48
    8000fd44:	fffff097          	auipc	ra,0xfffff
    8000fd48:	338080e7          	jalr	824(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000fd4c:	00001517          	auipc	a0,0x1
    8000fd50:	39c50513          	addi	a0,a0,924 # 800110e8 <userDataStart+0xe8>
    8000fd54:	00000097          	auipc	ra,0x0
    8000fd58:	750080e7          	jalr	1872(ra) # 800104a4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000fd5c:	00000613          	li	a2,0
    8000fd60:	00000597          	auipc	a1,0x0
    8000fd64:	e2858593          	addi	a1,a1,-472 # 8000fb88 <_Z11workerBodyDPv>
    8000fd68:	fd840513          	addi	a0,s0,-40
    8000fd6c:	fffff097          	auipc	ra,0xfffff
    8000fd70:	310080e7          	jalr	784(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    8000fd74:	00001517          	auipc	a0,0x1
    8000fd78:	38c50513          	addi	a0,a0,908 # 80011100 <userDataStart+0x100>
    8000fd7c:	00000097          	auipc	ra,0x0
    8000fd80:	728080e7          	jalr	1832(ra) # 800104a4 <_Z11printStringPKc>
    8000fd84:	00c0006f          	j	8000fd90 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000fd88:	fffff097          	auipc	ra,0xfffff
    8000fd8c:	3a8080e7          	jalr	936(ra) # 8000f130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000fd90:	00001797          	auipc	a5,0x1
    8000fd94:	4887c783          	lbu	a5,1160(a5) # 80011218 <finishedA>
    8000fd98:	fe0788e3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    8000fd9c:	00001797          	auipc	a5,0x1
    8000fda0:	47d7c783          	lbu	a5,1149(a5) # 80011219 <finishedB>
    8000fda4:	fe0782e3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    8000fda8:	00001797          	auipc	a5,0x1
    8000fdac:	4727c783          	lbu	a5,1138(a5) # 8001121a <finishedC>
    8000fdb0:	fc078ce3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    8000fdb4:	00001797          	auipc	a5,0x1
    8000fdb8:	4677c783          	lbu	a5,1127(a5) # 8001121b <finishedD>
    8000fdbc:	fc0786e3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    }

    for (auto &thread: threads) { delete thread; }
    8000fdc0:	fc040493          	addi	s1,s0,-64
    8000fdc4:	0080006f          	j	8000fdcc <_Z18Threads_C_API_testv+0xfc>
    8000fdc8:	00848493          	addi	s1,s1,8
    8000fdcc:	fe040793          	addi	a5,s0,-32
    8000fdd0:	00f48c63          	beq	s1,a5,8000fde8 <_Z18Threads_C_API_testv+0x118>
    8000fdd4:	0004b503          	ld	a0,0(s1)
    8000fdd8:	fe0508e3          	beqz	a0,8000fdc8 <_Z18Threads_C_API_testv+0xf8>
    8000fddc:	fffff097          	auipc	ra,0xfffff
    8000fde0:	5e8080e7          	jalr	1512(ra) # 8000f3c4 <_ZN7_threaddlEPv>
    8000fde4:	fe5ff06f          	j	8000fdc8 <_Z18Threads_C_API_testv+0xf8>
}
    8000fde8:	03813083          	ld	ra,56(sp)
    8000fdec:	03013403          	ld	s0,48(sp)
    8000fdf0:	02813483          	ld	s1,40(sp)
    8000fdf4:	04010113          	addi	sp,sp,64
    8000fdf8:	00008067          	ret

000000008000fdfc <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    8000fdfc:	fc010113          	addi	sp,sp,-64
    8000fe00:	02113c23          	sd	ra,56(sp)
    8000fe04:	02813823          	sd	s0,48(sp)
    8000fe08:	02913423          	sd	s1,40(sp)
    8000fe0c:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000fe10:	fc040493          	addi	s1,s0,-64
    8000fe14:	00048513          	mv	a0,s1
    8000fe18:	00001097          	auipc	ra,0x1
    8000fe1c:	c14080e7          	jalr	-1004(ra) # 80010a2c <_ZN6ThreadC1Ev>
    8000fe20:	00001797          	auipc	a5,0x1
    8000fe24:	35078793          	addi	a5,a5,848 # 80011170 <_ZTV10ForkThread+0x10>
    8000fe28:	fcf43023          	sd	a5,-64(s0)
    8000fe2c:	00100793          	li	a5,1
    8000fe30:	fcf43823          	sd	a5,-48(s0)
    8000fe34:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    8000fe38:	00048513          	mv	a0,s1
    8000fe3c:	00001097          	auipc	ra,0x1
    8000fe40:	ce0080e7          	jalr	-800(ra) # 80010b1c <_ZN6Thread5startEv>
        return finished;
    8000fe44:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    8000fe48:	00079863          	bnez	a5,8000fe58 <_Z8testUserv+0x5c>
        thread_dispatch();
    8000fe4c:	fffff097          	auipc	ra,0xfffff
    8000fe50:	2e4080e7          	jalr	740(ra) # 8000f130 <_Z15thread_dispatchv>
    8000fe54:	ff1ff06f          	j	8000fe44 <_Z8testUserv+0x48>
    }

//    ConsoleUtil::printString("User main finished\n");
    printString("User main finished\n");
    8000fe58:	00001517          	auipc	a0,0x1
    8000fe5c:	2c050513          	addi	a0,a0,704 # 80011118 <userDataStart+0x118>
    8000fe60:	00000097          	auipc	ra,0x0
    8000fe64:	644080e7          	jalr	1604(ra) # 800104a4 <_Z11printStringPKc>
class ForkThread : public Thread {
    8000fe68:	00001797          	auipc	a5,0x1
    8000fe6c:	30878793          	addi	a5,a5,776 # 80011170 <_ZTV10ForkThread+0x10>
    8000fe70:	fcf43023          	sd	a5,-64(s0)
    8000fe74:	fc040513          	addi	a0,s0,-64
    8000fe78:	00001097          	auipc	ra,0x1
    8000fe7c:	998080e7          	jalr	-1640(ra) # 80010810 <_ZN6ThreadD1Ev>
    8000fe80:	03813083          	ld	ra,56(sp)
    8000fe84:	03013403          	ld	s0,48(sp)
    8000fe88:	02813483          	ld	s1,40(sp)
    8000fe8c:	04010113          	addi	sp,sp,64
    8000fe90:	00008067          	ret
    8000fe94:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    8000fe98:	00001797          	auipc	a5,0x1
    8000fe9c:	2d878793          	addi	a5,a5,728 # 80011170 <_ZTV10ForkThread+0x10>
    8000fea0:	fcf43023          	sd	a5,-64(s0)
    8000fea4:	fc040513          	addi	a0,s0,-64
    8000fea8:	00001097          	auipc	ra,0x1
    8000feac:	968080e7          	jalr	-1688(ra) # 80010810 <_ZN6ThreadD1Ev>
    8000feb0:	00048513          	mv	a0,s1
    8000feb4:	ffffd097          	auipc	ra,0xffffd
    8000feb8:	f74080e7          	jalr	-140(ra) # 8000ce28 <_Unwind_Resume>

000000008000febc <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta
#include "testUser.hpp"

void userMain() {
    8000febc:	ff010113          	addi	sp,sp,-16
    8000fec0:	00113423          	sd	ra,8(sp)
    8000fec4:	00813023          	sd	s0,0(sp)
    8000fec8:	01010413          	addi	s0,sp,16
//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
//    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    testUser();
    8000fecc:	00000097          	auipc	ra,0x0
    8000fed0:	f30080e7          	jalr	-208(ra) # 8000fdfc <_Z8testUserv>
    8000fed4:	00813083          	ld	ra,8(sp)
    8000fed8:	00013403          	ld	s0,0(sp)
    8000fedc:	01010113          	addi	sp,sp,16
    8000fee0:	00008067          	ret

000000008000fee4 <_ZN10ForkThread3runEv>:
    virtual void run() {
    8000fee4:	fc010113          	addi	sp,sp,-64
    8000fee8:	02113c23          	sd	ra,56(sp)
    8000feec:	02813823          	sd	s0,48(sp)
    8000fef0:	02913423          	sd	s1,40(sp)
    8000fef4:	03213023          	sd	s2,32(sp)
    8000fef8:	01313c23          	sd	s3,24(sp)
    8000fefc:	01413823          	sd	s4,16(sp)
    8000ff00:	01513423          	sd	s5,8(sp)
    8000ff04:	01613023          	sd	s6,0(sp)
    8000ff08:	04010413          	addi	s0,sp,64
    8000ff0c:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    8000ff10:	00001517          	auipc	a0,0x1
    8000ff14:	22050513          	addi	a0,a0,544 # 80011130 <userDataStart+0x130>
    8000ff18:	00000097          	auipc	ra,0x0
    8000ff1c:	58c080e7          	jalr	1420(ra) # 800104a4 <_Z11printStringPKc>
        printInt(id,10);
    8000ff20:	00000613          	li	a2,0
    8000ff24:	00a00593          	li	a1,10
    8000ff28:	010a2503          	lw	a0,16(s4)
    8000ff2c:	00000097          	auipc	ra,0x0
    8000ff30:	710080e7          	jalr	1808(ra) # 8001063c <_Z8printIntiii>
        printString("\n");
    8000ff34:	00001517          	auipc	a0,0x1
    8000ff38:	0ec50513          	addi	a0,a0,236 # 80011020 <userDataStart+0x20>
    8000ff3c:	00000097          	auipc	ra,0x0
    8000ff40:	568080e7          	jalr	1384(ra) # 800104a4 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8000ff44:	02000513          	li	a0,32
    8000ff48:	00001097          	auipc	ra,0x1
    8000ff4c:	908080e7          	jalr	-1784(ra) # 80010850 <_Znwm>
    8000ff50:	00050993          	mv	s3,a0
    8000ff54:	02050463          	beqz	a0,8000ff7c <_ZN10ForkThread3runEv+0x98>
    8000ff58:	010a3483          	ld	s1,16(s4)
    8000ff5c:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000ff60:	00001097          	auipc	ra,0x1
    8000ff64:	acc080e7          	jalr	-1332(ra) # 80010a2c <_ZN6ThreadC1Ev>
    8000ff68:	00001797          	auipc	a5,0x1
    8000ff6c:	20878793          	addi	a5,a5,520 # 80011170 <_ZTV10ForkThread+0x10>
    8000ff70:	00f9b023          	sd	a5,0(s3)
    8000ff74:	0099b823          	sd	s1,16(s3)
    8000ff78:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    8000ff7c:	010a3503          	ld	a0,16(s4)
    8000ff80:	00351513          	slli	a0,a0,0x3
    8000ff84:	fffff097          	auipc	ra,0xfffff
    8000ff88:	09c080e7          	jalr	156(ra) # 8000f020 <_Z9mem_allocm>
    8000ff8c:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    8000ff90:	10050863          	beqz	a0,800100a0 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8000ff94:	00000913          	li	s2,0
    8000ff98:	0140006f          	j	8000ffac <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    8000ff9c:	00391793          	slli	a5,s2,0x3
    8000ffa0:	00fa87b3          	add	a5,s5,a5
    8000ffa4:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    8000ffa8:	00190913          	addi	s2,s2,1
    8000ffac:	010a3783          	ld	a5,16(s4)
    8000ffb0:	02f95e63          	bge	s2,a5,8000ffec <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    8000ffb4:	02000513          	li	a0,32
    8000ffb8:	00001097          	auipc	ra,0x1
    8000ffbc:	898080e7          	jalr	-1896(ra) # 80010850 <_Znwm>
    8000ffc0:	00050493          	mv	s1,a0
    8000ffc4:	fc050ce3          	beqz	a0,8000ff9c <_ZN10ForkThread3runEv+0xb8>
    8000ffc8:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    8000ffcc:	00001097          	auipc	ra,0x1
    8000ffd0:	a60080e7          	jalr	-1440(ra) # 80010a2c <_ZN6ThreadC1Ev>
    8000ffd4:	00001797          	auipc	a5,0x1
    8000ffd8:	19c78793          	addi	a5,a5,412 # 80011170 <_ZTV10ForkThread+0x10>
    8000ffdc:	00f4b023          	sd	a5,0(s1)
    8000ffe0:	0164b823          	sd	s6,16(s1)
    8000ffe4:	00048c23          	sb	zero,24(s1)
    8000ffe8:	fb5ff06f          	j	8000ff9c <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    8000ffec:	06098a63          	beqz	s3,80010060 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    8000fff0:	00098513          	mv	a0,s3
    8000fff4:	00001097          	auipc	ra,0x1
    8000fff8:	b28080e7          	jalr	-1240(ra) # 80010b1c <_ZN6Thread5startEv>
    8000fffc:	00050913          	mv	s2,a0
    80010000:	04051863          	bnez	a0,80010050 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    80010004:	00050493          	mv	s1,a0
    80010008:	0100006f          	j	80010018 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    8001000c:	fffff097          	auipc	ra,0xfffff
    80010010:	124080e7          	jalr	292(ra) # 8000f130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    80010014:	0014849b          	addiw	s1,s1,1
    80010018:	000017b7          	lui	a5,0x1
    8001001c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80010020:	0097ce63          	blt	a5,s1,8001003c <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    80010024:	00090713          	mv	a4,s2
    80010028:	000017b7          	lui	a5,0x1
    8001002c:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80010030:	fce7cee3          	blt	a5,a4,8001000c <_ZN10ForkThread3runEv+0x128>
    80010034:	0017071b          	addiw	a4,a4,1
    80010038:	ff1ff06f          	j	80010028 <_ZN10ForkThread3runEv+0x144>
        return finished;
    8001003c:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80010040:	00079863          	bnez	a5,80010050 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    80010044:	fffff097          	auipc	ra,0xfffff
    80010048:	0ec080e7          	jalr	236(ra) # 8000f130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    8001004c:	ff1ff06f          	j	8001003c <_ZN10ForkThread3runEv+0x158>
                delete thread;
    80010050:	0009b783          	ld	a5,0(s3)
    80010054:	0087b783          	ld	a5,8(a5)
    80010058:	00098513          	mv	a0,s3
    8001005c:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80010060:	00000493          	li	s1,0
    80010064:	0080006f          	j	8001006c <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    80010068:	00148493          	addi	s1,s1,1
    8001006c:	010a3783          	ld	a5,16(s4)
    80010070:	02f4d263          	bge	s1,a5,80010094 <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    80010074:	00349793          	slli	a5,s1,0x3
    80010078:	00fa87b3          	add	a5,s5,a5
    8001007c:	0007b503          	ld	a0,0(a5)
    80010080:	fe0504e3          	beqz	a0,80010068 <_ZN10ForkThread3runEv+0x184>
    80010084:	00053783          	ld	a5,0(a0)
    80010088:	0087b783          	ld	a5,8(a5)
    8001008c:	000780e7          	jalr	a5
    80010090:	fd9ff06f          	j	80010068 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    80010094:	000a8513          	mv	a0,s5
    80010098:	fffff097          	auipc	ra,0xfffff
    8001009c:	fb8080e7          	jalr	-72(ra) # 8000f050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    800100a0:	00001517          	auipc	a0,0x1
    800100a4:	0a850513          	addi	a0,a0,168 # 80011148 <userDataStart+0x148>
    800100a8:	00000097          	auipc	ra,0x0
    800100ac:	3fc080e7          	jalr	1020(ra) # 800104a4 <_Z11printStringPKc>
        printInt(id,10);
    800100b0:	00000613          	li	a2,0
    800100b4:	00a00593          	li	a1,10
    800100b8:	010a2503          	lw	a0,16(s4)
    800100bc:	00000097          	auipc	ra,0x0
    800100c0:	580080e7          	jalr	1408(ra) # 8001063c <_Z8printIntiii>
        printString("\n");
    800100c4:	00001517          	auipc	a0,0x1
    800100c8:	f5c50513          	addi	a0,a0,-164 # 80011020 <userDataStart+0x20>
    800100cc:	00000097          	auipc	ra,0x0
    800100d0:	3d8080e7          	jalr	984(ra) # 800104a4 <_Z11printStringPKc>
        finished = true;
    800100d4:	00100793          	li	a5,1
    800100d8:	00fa0c23          	sb	a5,24(s4)
    }
    800100dc:	03813083          	ld	ra,56(sp)
    800100e0:	03013403          	ld	s0,48(sp)
    800100e4:	02813483          	ld	s1,40(sp)
    800100e8:	02013903          	ld	s2,32(sp)
    800100ec:	01813983          	ld	s3,24(sp)
    800100f0:	01013a03          	ld	s4,16(sp)
    800100f4:	00813a83          	ld	s5,8(sp)
    800100f8:	00013b03          	ld	s6,0(sp)
    800100fc:	04010113          	addi	sp,sp,64
    80010100:	00008067          	ret

0000000080010104 <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    80010104:	ff010113          	addi	sp,sp,-16
    80010108:	00113423          	sd	ra,8(sp)
    8001010c:	00813023          	sd	s0,0(sp)
    80010110:	01010413          	addi	s0,sp,16
    80010114:	00001797          	auipc	a5,0x1
    80010118:	05c78793          	addi	a5,a5,92 # 80011170 <_ZTV10ForkThread+0x10>
    8001011c:	00f53023          	sd	a5,0(a0)
    80010120:	00000097          	auipc	ra,0x0
    80010124:	6f0080e7          	jalr	1776(ra) # 80010810 <_ZN6ThreadD1Ev>
    80010128:	00813083          	ld	ra,8(sp)
    8001012c:	00013403          	ld	s0,0(sp)
    80010130:	01010113          	addi	sp,sp,16
    80010134:	00008067          	ret

0000000080010138 <_ZN10ForkThreadD0Ev>:
    80010138:	fe010113          	addi	sp,sp,-32
    8001013c:	00113c23          	sd	ra,24(sp)
    80010140:	00813823          	sd	s0,16(sp)
    80010144:	00913423          	sd	s1,8(sp)
    80010148:	02010413          	addi	s0,sp,32
    8001014c:	00050493          	mv	s1,a0
    80010150:	00001797          	auipc	a5,0x1
    80010154:	02078793          	addi	a5,a5,32 # 80011170 <_ZTV10ForkThread+0x10>
    80010158:	00f53023          	sd	a5,0(a0)
    8001015c:	00000097          	auipc	ra,0x0
    80010160:	6b4080e7          	jalr	1716(ra) # 80010810 <_ZN6ThreadD1Ev>
    80010164:	00048513          	mv	a0,s1
    80010168:	00000097          	auipc	ra,0x0
    8001016c:	738080e7          	jalr	1848(ra) # 800108a0 <_ZdlPv>
    80010170:	01813083          	ld	ra,24(sp)
    80010174:	01013403          	ld	s0,16(sp)
    80010178:	00813483          	ld	s1,8(sp)
    8001017c:	02010113          	addi	sp,sp,32
    80010180:	00008067          	ret

0000000080010184 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80010184:	fe010113          	addi	sp,sp,-32
    80010188:	00113c23          	sd	ra,24(sp)
    8001018c:	00813823          	sd	s0,16(sp)
    80010190:	00913423          	sd	s1,8(sp)
    80010194:	01213023          	sd	s2,0(sp)
    80010198:	02010413          	addi	s0,sp,32
    8001019c:	00050493          	mv	s1,a0
    800101a0:	00058913          	mv	s2,a1
    800101a4:	0015879b          	addiw	a5,a1,1
    800101a8:	0007851b          	sext.w	a0,a5
    800101ac:	00f4a023          	sw	a5,0(s1)
    800101b0:	0004a823          	sw	zero,16(s1)
    800101b4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800101b8:	00251513          	slli	a0,a0,0x2
    800101bc:	fffff097          	auipc	ra,0xfffff
    800101c0:	e64080e7          	jalr	-412(ra) # 8000f020 <_Z9mem_allocm>
    800101c4:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    800101c8:	00000593          	li	a1,0
    800101cc:	02048513          	addi	a0,s1,32
    800101d0:	fffff097          	auipc	ra,0xfffff
    800101d4:	04c080e7          	jalr	76(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    800101d8:	00090593          	mv	a1,s2
    800101dc:	01848513          	addi	a0,s1,24
    800101e0:	fffff097          	auipc	ra,0xfffff
    800101e4:	03c080e7          	jalr	60(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    800101e8:	00100593          	li	a1,1
    800101ec:	02848513          	addi	a0,s1,40
    800101f0:	fffff097          	auipc	ra,0xfffff
    800101f4:	02c080e7          	jalr	44(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    800101f8:	00100593          	li	a1,1
    800101fc:	03048513          	addi	a0,s1,48
    80010200:	fffff097          	auipc	ra,0xfffff
    80010204:	01c080e7          	jalr	28(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
}
    80010208:	01813083          	ld	ra,24(sp)
    8001020c:	01013403          	ld	s0,16(sp)
    80010210:	00813483          	ld	s1,8(sp)
    80010214:	00013903          	ld	s2,0(sp)
    80010218:	02010113          	addi	sp,sp,32
    8001021c:	00008067          	ret

0000000080010220 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80010220:	fe010113          	addi	sp,sp,-32
    80010224:	00113c23          	sd	ra,24(sp)
    80010228:	00813823          	sd	s0,16(sp)
    8001022c:	00913423          	sd	s1,8(sp)
    80010230:	01213023          	sd	s2,0(sp)
    80010234:	02010413          	addi	s0,sp,32
    80010238:	00050493          	mv	s1,a0
    8001023c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80010240:	01853503          	ld	a0,24(a0)
    80010244:	fffff097          	auipc	ra,0xfffff
    80010248:	03c080e7          	jalr	60(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    8001024c:	0304b503          	ld	a0,48(s1)
    80010250:	fffff097          	auipc	ra,0xfffff
    80010254:	030080e7          	jalr	48(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    80010258:	0084b783          	ld	a5,8(s1)
    8001025c:	0144a703          	lw	a4,20(s1)
    80010260:	00271713          	slli	a4,a4,0x2
    80010264:	00e787b3          	add	a5,a5,a4
    80010268:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8001026c:	0144a783          	lw	a5,20(s1)
    80010270:	0017879b          	addiw	a5,a5,1
    80010274:	0004a703          	lw	a4,0(s1)
    80010278:	02e7e7bb          	remw	a5,a5,a4
    8001027c:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80010280:	0304b503          	ld	a0,48(s1)
    80010284:	fffff097          	auipc	ra,0xfffff
    80010288:	028080e7          	jalr	40(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    8001028c:	0204b503          	ld	a0,32(s1)
    80010290:	fffff097          	auipc	ra,0xfffff
    80010294:	01c080e7          	jalr	28(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

}
    80010298:	01813083          	ld	ra,24(sp)
    8001029c:	01013403          	ld	s0,16(sp)
    800102a0:	00813483          	ld	s1,8(sp)
    800102a4:	00013903          	ld	s2,0(sp)
    800102a8:	02010113          	addi	sp,sp,32
    800102ac:	00008067          	ret

00000000800102b0 <_ZN6Buffer3getEv>:

int Buffer::get() {
    800102b0:	fe010113          	addi	sp,sp,-32
    800102b4:	00113c23          	sd	ra,24(sp)
    800102b8:	00813823          	sd	s0,16(sp)
    800102bc:	00913423          	sd	s1,8(sp)
    800102c0:	01213023          	sd	s2,0(sp)
    800102c4:	02010413          	addi	s0,sp,32
    800102c8:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    800102cc:	02053503          	ld	a0,32(a0)
    800102d0:	fffff097          	auipc	ra,0xfffff
    800102d4:	fb0080e7          	jalr	-80(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    800102d8:	0284b503          	ld	a0,40(s1)
    800102dc:	fffff097          	auipc	ra,0xfffff
    800102e0:	fa4080e7          	jalr	-92(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    800102e4:	0084b703          	ld	a4,8(s1)
    800102e8:	0104a783          	lw	a5,16(s1)
    800102ec:	00279693          	slli	a3,a5,0x2
    800102f0:	00d70733          	add	a4,a4,a3
    800102f4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800102f8:	0017879b          	addiw	a5,a5,1
    800102fc:	0004a703          	lw	a4,0(s1)
    80010300:	02e7e7bb          	remw	a5,a5,a4
    80010304:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80010308:	0284b503          	ld	a0,40(s1)
    8001030c:	fffff097          	auipc	ra,0xfffff
    80010310:	fa0080e7          	jalr	-96(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80010314:	0184b503          	ld	a0,24(s1)
    80010318:	fffff097          	auipc	ra,0xfffff
    8001031c:	f94080e7          	jalr	-108(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80010320:	00090513          	mv	a0,s2
    80010324:	01813083          	ld	ra,24(sp)
    80010328:	01013403          	ld	s0,16(sp)
    8001032c:	00813483          	ld	s1,8(sp)
    80010330:	00013903          	ld	s2,0(sp)
    80010334:	02010113          	addi	sp,sp,32
    80010338:	00008067          	ret

000000008001033c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8001033c:	fe010113          	addi	sp,sp,-32
    80010340:	00113c23          	sd	ra,24(sp)
    80010344:	00813823          	sd	s0,16(sp)
    80010348:	00913423          	sd	s1,8(sp)
    8001034c:	01213023          	sd	s2,0(sp)
    80010350:	02010413          	addi	s0,sp,32
    80010354:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80010358:	02853503          	ld	a0,40(a0)
    8001035c:	fffff097          	auipc	ra,0xfffff
    80010360:	f24080e7          	jalr	-220(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    80010364:	0304b503          	ld	a0,48(s1)
    80010368:	fffff097          	auipc	ra,0xfffff
    8001036c:	f18080e7          	jalr	-232(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    80010370:	0144a783          	lw	a5,20(s1)
    80010374:	0104a903          	lw	s2,16(s1)
    80010378:	0327ce63          	blt	a5,s2,800103b4 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    8001037c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80010380:	0304b503          	ld	a0,48(s1)
    80010384:	fffff097          	auipc	ra,0xfffff
    80010388:	f28080e7          	jalr	-216(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    8001038c:	0284b503          	ld	a0,40(s1)
    80010390:	fffff097          	auipc	ra,0xfffff
    80010394:	f1c080e7          	jalr	-228(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80010398:	00090513          	mv	a0,s2
    8001039c:	01813083          	ld	ra,24(sp)
    800103a0:	01013403          	ld	s0,16(sp)
    800103a4:	00813483          	ld	s1,8(sp)
    800103a8:	00013903          	ld	s2,0(sp)
    800103ac:	02010113          	addi	sp,sp,32
    800103b0:	00008067          	ret
        ret = cap - head + tail;
    800103b4:	0004a703          	lw	a4,0(s1)
    800103b8:	4127093b          	subw	s2,a4,s2
    800103bc:	00f9093b          	addw	s2,s2,a5
    800103c0:	fc1ff06f          	j	80010380 <_ZN6Buffer6getCntEv+0x44>

00000000800103c4 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    800103c4:	fe010113          	addi	sp,sp,-32
    800103c8:	00113c23          	sd	ra,24(sp)
    800103cc:	00813823          	sd	s0,16(sp)
    800103d0:	00913423          	sd	s1,8(sp)
    800103d4:	02010413          	addi	s0,sp,32
    800103d8:	00050493          	mv	s1,a0
    putc('\n');
    800103dc:	00a00513          	li	a0,10
    800103e0:	fffff097          	auipc	ra,0xfffff
    800103e4:	f4c080e7          	jalr	-180(ra) # 8000f32c <_Z4putcc>
    printString("Buffer deleted!\n");
    800103e8:	00001517          	auipc	a0,0x1
    800103ec:	c1850513          	addi	a0,a0,-1000 # 80011000 <userDataStart>
    800103f0:	00000097          	auipc	ra,0x0
    800103f4:	0b4080e7          	jalr	180(ra) # 800104a4 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800103f8:	00048513          	mv	a0,s1
    800103fc:	00000097          	auipc	ra,0x0
    80010400:	f40080e7          	jalr	-192(ra) # 8001033c <_ZN6Buffer6getCntEv>
    80010404:	02a05c63          	blez	a0,8001043c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80010408:	0084b783          	ld	a5,8(s1)
    8001040c:	0104a703          	lw	a4,16(s1)
    80010410:	00271713          	slli	a4,a4,0x2
    80010414:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80010418:	0007c503          	lbu	a0,0(a5)
    8001041c:	fffff097          	auipc	ra,0xfffff
    80010420:	f10080e7          	jalr	-240(ra) # 8000f32c <_Z4putcc>
        head = (head + 1) % cap;
    80010424:	0104a783          	lw	a5,16(s1)
    80010428:	0017879b          	addiw	a5,a5,1
    8001042c:	0004a703          	lw	a4,0(s1)
    80010430:	02e7e7bb          	remw	a5,a5,a4
    80010434:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80010438:	fc1ff06f          	j	800103f8 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8001043c:	02100513          	li	a0,33
    80010440:	fffff097          	auipc	ra,0xfffff
    80010444:	eec080e7          	jalr	-276(ra) # 8000f32c <_Z4putcc>
    putc('\n');
    80010448:	00a00513          	li	a0,10
    8001044c:	fffff097          	auipc	ra,0xfffff
    80010450:	ee0080e7          	jalr	-288(ra) # 8000f32c <_Z4putcc>
    mem_free(buffer);
    80010454:	0084b503          	ld	a0,8(s1)
    80010458:	fffff097          	auipc	ra,0xfffff
    8001045c:	bf8080e7          	jalr	-1032(ra) # 8000f050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80010460:	0204b503          	ld	a0,32(s1)
    80010464:	fffff097          	auipc	ra,0xfffff
    80010468:	df0080e7          	jalr	-528(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    8001046c:	0184b503          	ld	a0,24(s1)
    80010470:	fffff097          	auipc	ra,0xfffff
    80010474:	de4080e7          	jalr	-540(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    80010478:	0304b503          	ld	a0,48(s1)
    8001047c:	fffff097          	auipc	ra,0xfffff
    80010480:	dd8080e7          	jalr	-552(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    80010484:	0284b503          	ld	a0,40(s1)
    80010488:	fffff097          	auipc	ra,0xfffff
    8001048c:	dcc080e7          	jalr	-564(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
}
    80010490:	01813083          	ld	ra,24(sp)
    80010494:	01013403          	ld	s0,16(sp)
    80010498:	00813483          	ld	s1,8(sp)
    8001049c:	02010113          	addi	sp,sp,32
    800104a0:	00008067          	ret

00000000800104a4 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800104a4:	fe010113          	addi	sp,sp,-32
    800104a8:	00113c23          	sd	ra,24(sp)
    800104ac:	00813823          	sd	s0,16(sp)
    800104b0:	00913423          	sd	s1,8(sp)
    800104b4:	02010413          	addi	s0,sp,32
    800104b8:	00050493          	mv	s1,a0
    LOCK();
    800104bc:	00100613          	li	a2,1
    800104c0:	00000593          	li	a1,0
    800104c4:	00001517          	auipc	a0,0x1
    800104c8:	d5c50513          	addi	a0,a0,-676 # 80011220 <lockPrint>
    800104cc:	fffff097          	auipc	ra,0xfffff
    800104d0:	b34080e7          	jalr	-1228(ra) # 8000f000 <copy_and_swap>
    800104d4:	fe0514e3          	bnez	a0,800104bc <_Z11printStringPKc+0x18>
    while (*string != '\0')
    800104d8:	0004c503          	lbu	a0,0(s1)
    800104dc:	00050a63          	beqz	a0,800104f0 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    800104e0:	fffff097          	auipc	ra,0xfffff
    800104e4:	e4c080e7          	jalr	-436(ra) # 8000f32c <_Z4putcc>
        string++;
    800104e8:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800104ec:	fedff06f          	j	800104d8 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    800104f0:	00000613          	li	a2,0
    800104f4:	00100593          	li	a1,1
    800104f8:	00001517          	auipc	a0,0x1
    800104fc:	d2850513          	addi	a0,a0,-728 # 80011220 <lockPrint>
    80010500:	fffff097          	auipc	ra,0xfffff
    80010504:	b00080e7          	jalr	-1280(ra) # 8000f000 <copy_and_swap>
    80010508:	fe0514e3          	bnez	a0,800104f0 <_Z11printStringPKc+0x4c>
}
    8001050c:	01813083          	ld	ra,24(sp)
    80010510:	01013403          	ld	s0,16(sp)
    80010514:	00813483          	ld	s1,8(sp)
    80010518:	02010113          	addi	sp,sp,32
    8001051c:	00008067          	ret

0000000080010520 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80010520:	fd010113          	addi	sp,sp,-48
    80010524:	02113423          	sd	ra,40(sp)
    80010528:	02813023          	sd	s0,32(sp)
    8001052c:	00913c23          	sd	s1,24(sp)
    80010530:	01213823          	sd	s2,16(sp)
    80010534:	01313423          	sd	s3,8(sp)
    80010538:	01413023          	sd	s4,0(sp)
    8001053c:	03010413          	addi	s0,sp,48
    80010540:	00050993          	mv	s3,a0
    80010544:	00058a13          	mv	s4,a1
    LOCK();
    80010548:	00100613          	li	a2,1
    8001054c:	00000593          	li	a1,0
    80010550:	00001517          	auipc	a0,0x1
    80010554:	cd050513          	addi	a0,a0,-816 # 80011220 <lockPrint>
    80010558:	fffff097          	auipc	ra,0xfffff
    8001055c:	aa8080e7          	jalr	-1368(ra) # 8000f000 <copy_and_swap>
    80010560:	fe0514e3          	bnez	a0,80010548 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80010564:	00000913          	li	s2,0
    80010568:	00090493          	mv	s1,s2
    8001056c:	0019091b          	addiw	s2,s2,1
    80010570:	03495a63          	bge	s2,s4,800105a4 <_Z9getStringPci+0x84>
        cc = getc();
    80010574:	fffff097          	auipc	ra,0xfffff
    80010578:	d90080e7          	jalr	-624(ra) # 8000f304 <_Z4getcv>
        if(cc < 1)
    8001057c:	02050463          	beqz	a0,800105a4 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80010580:	009984b3          	add	s1,s3,s1
    80010584:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80010588:	00a00793          	li	a5,10
    8001058c:	00f50a63          	beq	a0,a5,800105a0 <_Z9getStringPci+0x80>
    80010590:	00d00793          	li	a5,13
    80010594:	fcf51ae3          	bne	a0,a5,80010568 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80010598:	00090493          	mv	s1,s2
    8001059c:	0080006f          	j	800105a4 <_Z9getStringPci+0x84>
    800105a0:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800105a4:	009984b3          	add	s1,s3,s1
    800105a8:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800105ac:	00000613          	li	a2,0
    800105b0:	00100593          	li	a1,1
    800105b4:	00001517          	auipc	a0,0x1
    800105b8:	c6c50513          	addi	a0,a0,-916 # 80011220 <lockPrint>
    800105bc:	fffff097          	auipc	ra,0xfffff
    800105c0:	a44080e7          	jalr	-1468(ra) # 8000f000 <copy_and_swap>
    800105c4:	fe0514e3          	bnez	a0,800105ac <_Z9getStringPci+0x8c>
    return buf;
}
    800105c8:	00098513          	mv	a0,s3
    800105cc:	02813083          	ld	ra,40(sp)
    800105d0:	02013403          	ld	s0,32(sp)
    800105d4:	01813483          	ld	s1,24(sp)
    800105d8:	01013903          	ld	s2,16(sp)
    800105dc:	00813983          	ld	s3,8(sp)
    800105e0:	00013a03          	ld	s4,0(sp)
    800105e4:	03010113          	addi	sp,sp,48
    800105e8:	00008067          	ret

00000000800105ec <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800105ec:	ff010113          	addi	sp,sp,-16
    800105f0:	00813423          	sd	s0,8(sp)
    800105f4:	01010413          	addi	s0,sp,16
    800105f8:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800105fc:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80010600:	0006c603          	lbu	a2,0(a3)
    80010604:	fd06071b          	addiw	a4,a2,-48
    80010608:	0ff77713          	andi	a4,a4,255
    8001060c:	00900793          	li	a5,9
    80010610:	02e7e063          	bltu	a5,a4,80010630 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80010614:	0025179b          	slliw	a5,a0,0x2
    80010618:	00a787bb          	addw	a5,a5,a0
    8001061c:	0017979b          	slliw	a5,a5,0x1
    80010620:	00168693          	addi	a3,a3,1
    80010624:	00c787bb          	addw	a5,a5,a2
    80010628:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8001062c:	fd5ff06f          	j	80010600 <_Z11stringToIntPKc+0x14>
    return n;
}
    80010630:	00813403          	ld	s0,8(sp)
    80010634:	01010113          	addi	sp,sp,16
    80010638:	00008067          	ret

000000008001063c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8001063c:	fc010113          	addi	sp,sp,-64
    80010640:	02113c23          	sd	ra,56(sp)
    80010644:	02813823          	sd	s0,48(sp)
    80010648:	02913423          	sd	s1,40(sp)
    8001064c:	03213023          	sd	s2,32(sp)
    80010650:	01313c23          	sd	s3,24(sp)
    80010654:	04010413          	addi	s0,sp,64
    80010658:	00050493          	mv	s1,a0
    8001065c:	00058913          	mv	s2,a1
    80010660:	00060993          	mv	s3,a2
    LOCK();
    80010664:	00100613          	li	a2,1
    80010668:	00000593          	li	a1,0
    8001066c:	00001517          	auipc	a0,0x1
    80010670:	bb450513          	addi	a0,a0,-1100 # 80011220 <lockPrint>
    80010674:	fffff097          	auipc	ra,0xfffff
    80010678:	98c080e7          	jalr	-1652(ra) # 8000f000 <copy_and_swap>
    8001067c:	fe0514e3          	bnez	a0,80010664 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80010680:	00098463          	beqz	s3,80010688 <_Z8printIntiii+0x4c>
    80010684:	0804c463          	bltz	s1,8001070c <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80010688:	0004851b          	sext.w	a0,s1
    neg = 0;
    8001068c:	00000593          	li	a1,0
    }

    i = 0;
    80010690:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80010694:	0009079b          	sext.w	a5,s2
    80010698:	0325773b          	remuw	a4,a0,s2
    8001069c:	00048613          	mv	a2,s1
    800106a0:	0014849b          	addiw	s1,s1,1
    800106a4:	02071693          	slli	a3,a4,0x20
    800106a8:	0206d693          	srli	a3,a3,0x20
    800106ac:	00001717          	auipc	a4,0x1
    800106b0:	adc70713          	addi	a4,a4,-1316 # 80011188 <digits>
    800106b4:	00d70733          	add	a4,a4,a3
    800106b8:	00074683          	lbu	a3,0(a4)
    800106bc:	fd040713          	addi	a4,s0,-48
    800106c0:	00c70733          	add	a4,a4,a2
    800106c4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800106c8:	0005071b          	sext.w	a4,a0
    800106cc:	0325553b          	divuw	a0,a0,s2
    800106d0:	fcf772e3          	bgeu	a4,a5,80010694 <_Z8printIntiii+0x58>
    if(neg)
    800106d4:	00058c63          	beqz	a1,800106ec <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    800106d8:	fd040793          	addi	a5,s0,-48
    800106dc:	009784b3          	add	s1,a5,s1
    800106e0:	02d00793          	li	a5,45
    800106e4:	fef48823          	sb	a5,-16(s1)
    800106e8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800106ec:	fff4849b          	addiw	s1,s1,-1
    800106f0:	0204c463          	bltz	s1,80010718 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    800106f4:	fd040793          	addi	a5,s0,-48
    800106f8:	009787b3          	add	a5,a5,s1
    800106fc:	ff07c503          	lbu	a0,-16(a5)
    80010700:	fffff097          	auipc	ra,0xfffff
    80010704:	c2c080e7          	jalr	-980(ra) # 8000f32c <_Z4putcc>
    80010708:	fe5ff06f          	j	800106ec <_Z8printIntiii+0xb0>
        x = -xx;
    8001070c:	4090053b          	negw	a0,s1
        neg = 1;
    80010710:	00100593          	li	a1,1
        x = -xx;
    80010714:	f7dff06f          	j	80010690 <_Z8printIntiii+0x54>

    UNLOCK();
    80010718:	00000613          	li	a2,0
    8001071c:	00100593          	li	a1,1
    80010720:	00001517          	auipc	a0,0x1
    80010724:	b0050513          	addi	a0,a0,-1280 # 80011220 <lockPrint>
    80010728:	fffff097          	auipc	ra,0xfffff
    8001072c:	8d8080e7          	jalr	-1832(ra) # 8000f000 <copy_and_swap>
    80010730:	fe0514e3          	bnez	a0,80010718 <_Z8printIntiii+0xdc>
    80010734:	03813083          	ld	ra,56(sp)
    80010738:	03013403          	ld	s0,48(sp)
    8001073c:	02813483          	ld	s1,40(sp)
    80010740:	02013903          	ld	s2,32(sp)
    80010744:	01813983          	ld	s3,24(sp)
    80010748:	04010113          	addi	sp,sp,64
    8001074c:	00008067          	ret

0000000080010750 <_Z11bodyWrapperPFvPvES_>:
#include "../../h/userWrappers.hpp"
#include "../../h/syscall_c.h"
#include "../../src/user/tests/userMain.hpp"

void bodyWrapper(void (*body)(void*), void* args)
{
    80010750:	ff010113          	addi	sp,sp,-16
    80010754:	00113423          	sd	ra,8(sp)
    80010758:	00813023          	sd	s0,0(sp)
    8001075c:	01010413          	addi	s0,sp,16
    80010760:	00050793          	mv	a5,a0
    body(args);
    80010764:	00058513          	mv	a0,a1
    80010768:	000780e7          	jalr	a5
    thread_exit();
    8001076c:	fffff097          	auipc	ra,0xfffff
    80010770:	99c080e7          	jalr	-1636(ra) # 8000f108 <_Z11thread_exitv>
}
    80010774:	00813083          	ld	ra,8(sp)
    80010778:	00013403          	ld	s0,0(sp)
    8001077c:	01010113          	addi	sp,sp,16
    80010780:	00008067          	ret

0000000080010784 <_Z15userMainWrapperPv>:

void userMainWrapper(void* args) {
    80010784:	ff010113          	addi	sp,sp,-16
    80010788:	00113423          	sd	ra,8(sp)
    8001078c:	00813023          	sd	s0,0(sp)
    80010790:	01010413          	addi	s0,sp,16
    userMain();
    80010794:	fffff097          	auipc	ra,0xfffff
    80010798:	728080e7          	jalr	1832(ra) # 8000febc <_Z8userMainv>
    8001079c:	00813083          	ld	ra,8(sp)
    800107a0:	00013403          	ld	s0,0(sp)
    800107a4:	01010113          	addi	sp,sp,16
    800107a8:	00008067          	ret

00000000800107ac <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    800107ac:	ff010113          	addi	sp,sp,-16
    800107b0:	00113423          	sd	ra,8(sp)
    800107b4:	00813023          	sd	s0,0(sp)
    800107b8:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    800107bc:	00053783          	ld	a5,0(a0)
    800107c0:	0107b783          	ld	a5,16(a5)
    800107c4:	000780e7          	jalr	a5
}
    800107c8:	00813083          	ld	ra,8(sp)
    800107cc:	00013403          	ld	s0,0(sp)
    800107d0:	01010113          	addi	sp,sp,16
    800107d4:	00008067          	ret

00000000800107d8 <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    800107d8:	ff010113          	addi	sp,sp,-16
    800107dc:	00113423          	sd	ra,8(sp)
    800107e0:	00813023          	sd	s0,0(sp)
    800107e4:	01010413          	addi	s0,sp,16
    800107e8:	00001797          	auipc	a5,0x1
    800107ec:	9f878793          	addi	a5,a5,-1544 # 800111e0 <_ZTV9Semaphore+0x10>
    800107f0:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800107f4:	00853503          	ld	a0,8(a0)
    800107f8:	fffff097          	auipc	ra,0xfffff
    800107fc:	a5c080e7          	jalr	-1444(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
};
    80010800:	00813083          	ld	ra,8(sp)
    80010804:	00013403          	ld	s0,0(sp)
    80010808:	01010113          	addi	sp,sp,16
    8001080c:	00008067          	ret

0000000080010810 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80010810:	00001797          	auipc	a5,0x1
    80010814:	9f078793          	addi	a5,a5,-1552 # 80011200 <_ZTV6Thread+0x10>
    80010818:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    8001081c:	00853503          	ld	a0,8(a0)
    80010820:	02050663          	beqz	a0,8001084c <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80010824:	ff010113          	addi	sp,sp,-16
    80010828:	00113423          	sd	ra,8(sp)
    8001082c:	00813023          	sd	s0,0(sp)
    80010830:	01010413          	addi	s0,sp,16
    delete myHandle;
    80010834:	fffff097          	auipc	ra,0xfffff
    80010838:	b90080e7          	jalr	-1136(ra) # 8000f3c4 <_ZN7_threaddlEPv>
}
    8001083c:	00813083          	ld	ra,8(sp)
    80010840:	00013403          	ld	s0,0(sp)
    80010844:	01010113          	addi	sp,sp,16
    80010848:	00008067          	ret
    8001084c:	00008067          	ret

0000000080010850 <_Znwm>:
void* operator new(size_t sz){
    80010850:	ff010113          	addi	sp,sp,-16
    80010854:	00113423          	sd	ra,8(sp)
    80010858:	00813023          	sd	s0,0(sp)
    8001085c:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80010860:	ffffe097          	auipc	ra,0xffffe
    80010864:	7c0080e7          	jalr	1984(ra) # 8000f020 <_Z9mem_allocm>
}
    80010868:	00813083          	ld	ra,8(sp)
    8001086c:	00013403          	ld	s0,0(sp)
    80010870:	01010113          	addi	sp,sp,16
    80010874:	00008067          	ret

0000000080010878 <_Znam>:
void* operator new[](size_t sz){
    80010878:	ff010113          	addi	sp,sp,-16
    8001087c:	00113423          	sd	ra,8(sp)
    80010880:	00813023          	sd	s0,0(sp)
    80010884:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80010888:	ffffe097          	auipc	ra,0xffffe
    8001088c:	798080e7          	jalr	1944(ra) # 8000f020 <_Z9mem_allocm>
}
    80010890:	00813083          	ld	ra,8(sp)
    80010894:	00013403          	ld	s0,0(sp)
    80010898:	01010113          	addi	sp,sp,16
    8001089c:	00008067          	ret

00000000800108a0 <_ZdlPv>:
void operator delete(void *ptr){
    800108a0:	ff010113          	addi	sp,sp,-16
    800108a4:	00113423          	sd	ra,8(sp)
    800108a8:	00813023          	sd	s0,0(sp)
    800108ac:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    800108b0:	ffffe097          	auipc	ra,0xffffe
    800108b4:	7a0080e7          	jalr	1952(ra) # 8000f050 <_Z8mem_freePv>
}
    800108b8:	00813083          	ld	ra,8(sp)
    800108bc:	00013403          	ld	s0,0(sp)
    800108c0:	01010113          	addi	sp,sp,16
    800108c4:	00008067          	ret

00000000800108c8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    800108c8:	fe010113          	addi	sp,sp,-32
    800108cc:	00113c23          	sd	ra,24(sp)
    800108d0:	00813823          	sd	s0,16(sp)
    800108d4:	00913423          	sd	s1,8(sp)
    800108d8:	02010413          	addi	s0,sp,32
    800108dc:	00050493          	mv	s1,a0
};
    800108e0:	00000097          	auipc	ra,0x0
    800108e4:	ef8080e7          	jalr	-264(ra) # 800107d8 <_ZN9SemaphoreD1Ev>
    800108e8:	00048513          	mv	a0,s1
    800108ec:	00000097          	auipc	ra,0x0
    800108f0:	fb4080e7          	jalr	-76(ra) # 800108a0 <_ZdlPv>
    800108f4:	01813083          	ld	ra,24(sp)
    800108f8:	01013403          	ld	s0,16(sp)
    800108fc:	00813483          	ld	s1,8(sp)
    80010900:	02010113          	addi	sp,sp,32
    80010904:	00008067          	ret

0000000080010908 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80010908:	fe010113          	addi	sp,sp,-32
    8001090c:	00113c23          	sd	ra,24(sp)
    80010910:	00813823          	sd	s0,16(sp)
    80010914:	00913423          	sd	s1,8(sp)
    80010918:	02010413          	addi	s0,sp,32
    8001091c:	00050493          	mv	s1,a0
}
    80010920:	00000097          	auipc	ra,0x0
    80010924:	ef0080e7          	jalr	-272(ra) # 80010810 <_ZN6ThreadD1Ev>
    80010928:	00048513          	mv	a0,s1
    8001092c:	00000097          	auipc	ra,0x0
    80010930:	f74080e7          	jalr	-140(ra) # 800108a0 <_ZdlPv>
    80010934:	01813083          	ld	ra,24(sp)
    80010938:	01013403          	ld	s0,16(sp)
    8001093c:	00813483          	ld	s1,8(sp)
    80010940:	02010113          	addi	sp,sp,32
    80010944:	00008067          	ret

0000000080010948 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80010948:	ff010113          	addi	sp,sp,-16
    8001094c:	00113423          	sd	ra,8(sp)
    80010950:	00813023          	sd	s0,0(sp)
    80010954:	01010413          	addi	s0,sp,16
    80010958:	00001797          	auipc	a5,0x1
    8001095c:	88878793          	addi	a5,a5,-1912 # 800111e0 <_ZTV9Semaphore+0x10>
    80010960:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80010964:	00850513          	addi	a0,a0,8
    80010968:	fffff097          	auipc	ra,0xfffff
    8001096c:	8b4080e7          	jalr	-1868(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
}
    80010970:	00813083          	ld	ra,8(sp)
    80010974:	00013403          	ld	s0,0(sp)
    80010978:	01010113          	addi	sp,sp,16
    8001097c:	00008067          	ret

0000000080010980 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80010980:	ff010113          	addi	sp,sp,-16
    80010984:	00113423          	sd	ra,8(sp)
    80010988:	00813023          	sd	s0,0(sp)
    8001098c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80010990:	00853503          	ld	a0,8(a0)
    80010994:	fffff097          	auipc	ra,0xfffff
    80010998:	8ec080e7          	jalr	-1812(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
}
    8001099c:	00813083          	ld	ra,8(sp)
    800109a0:	00013403          	ld	s0,0(sp)
    800109a4:	01010113          	addi	sp,sp,16
    800109a8:	00008067          	ret

00000000800109ac <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800109ac:	ff010113          	addi	sp,sp,-16
    800109b0:	00113423          	sd	ra,8(sp)
    800109b4:	00813023          	sd	s0,0(sp)
    800109b8:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    800109bc:	00853503          	ld	a0,8(a0)
    800109c0:	fffff097          	auipc	ra,0xfffff
    800109c4:	8ec080e7          	jalr	-1812(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>
}
    800109c8:	00813083          	ld	ra,8(sp)
    800109cc:	00013403          	ld	s0,0(sp)
    800109d0:	01010113          	addi	sp,sp,16
    800109d4:	00008067          	ret

00000000800109d8 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    800109d8:	fe010113          	addi	sp,sp,-32
    800109dc:	00113c23          	sd	ra,24(sp)
    800109e0:	00813823          	sd	s0,16(sp)
    800109e4:	00913423          	sd	s1,8(sp)
    800109e8:	02010413          	addi	s0,sp,32
    800109ec:	00050493          	mv	s1,a0
    800109f0:	00001797          	auipc	a5,0x1
    800109f4:	81078793          	addi	a5,a5,-2032 # 80011200 <_ZTV6Thread+0x10>
    800109f8:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    800109fc:	00850513          	addi	a0,a0,8
    80010a00:	ffffe097          	auipc	ra,0xffffe
    80010a04:	750080e7          	jalr	1872(ra) # 8000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80010a08:	fff00793          	li	a5,-1
    80010a0c:	00f50c63          	beq	a0,a5,80010a24 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    80010a10:	01813083          	ld	ra,24(sp)
    80010a14:	01013403          	ld	s0,16(sp)
    80010a18:	00813483          	ld	s1,8(sp)
    80010a1c:	02010113          	addi	sp,sp,32
    80010a20:	00008067          	ret
        myHandle = nullptr;
    80010a24:	0004b423          	sd	zero,8(s1)
}
    80010a28:	fe9ff06f          	j	80010a10 <_ZN6ThreadC1EPFvPvES0_+0x38>

0000000080010a2c <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80010a2c:	fe010113          	addi	sp,sp,-32
    80010a30:	00113c23          	sd	ra,24(sp)
    80010a34:	00813823          	sd	s0,16(sp)
    80010a38:	00913423          	sd	s1,8(sp)
    80010a3c:	02010413          	addi	s0,sp,32
    80010a40:	00050493          	mv	s1,a0
    80010a44:	00000797          	auipc	a5,0x0
    80010a48:	7bc78793          	addi	a5,a5,1980 # 80011200 <_ZTV6Thread+0x10>
    80010a4c:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80010a50:	00050613          	mv	a2,a0
    80010a54:	00000597          	auipc	a1,0x0
    80010a58:	d5858593          	addi	a1,a1,-680 # 800107ac <_ZN6Thread7wrapperEPv>
    80010a5c:	00850513          	addi	a0,a0,8
    80010a60:	ffffe097          	auipc	ra,0xffffe
    80010a64:	6f0080e7          	jalr	1776(ra) # 8000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80010a68:	fff00793          	li	a5,-1
    80010a6c:	00f50c63          	beq	a0,a5,80010a84 <_ZN6ThreadC1Ev+0x58>
}
    80010a70:	01813083          	ld	ra,24(sp)
    80010a74:	01013403          	ld	s0,16(sp)
    80010a78:	00813483          	ld	s1,8(sp)
    80010a7c:	02010113          	addi	sp,sp,32
    80010a80:	00008067          	ret
        myHandle = nullptr;
    80010a84:	0004b423          	sd	zero,8(s1)
}
    80010a88:	fe9ff06f          	j	80010a70 <_ZN6ThreadC1Ev+0x44>

0000000080010a8c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80010a8c:	ff010113          	addi	sp,sp,-16
    80010a90:	00113423          	sd	ra,8(sp)
    80010a94:	00813023          	sd	s0,0(sp)
    80010a98:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80010a9c:	fffff097          	auipc	ra,0xfffff
    80010aa0:	83c080e7          	jalr	-1988(ra) # 8000f2d8 <_Z10time_sleepm>
}
    80010aa4:	00813083          	ld	ra,8(sp)
    80010aa8:	00013403          	ld	s0,0(sp)
    80010aac:	01010113          	addi	sp,sp,16
    80010ab0:	00008067          	ret

0000000080010ab4 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80010ab4:	fe010113          	addi	sp,sp,-32
    80010ab8:	00113c23          	sd	ra,24(sp)
    80010abc:	00813823          	sd	s0,16(sp)
    80010ac0:	00913423          	sd	s1,8(sp)
    80010ac4:	01213023          	sd	s2,0(sp)
    80010ac8:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80010acc:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80010ad0:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80010ad4:	0004b783          	ld	a5,0(s1)
    80010ad8:	0187b783          	ld	a5,24(a5)
    80010adc:	00048513          	mv	a0,s1
    80010ae0:	000780e7          	jalr	a5
        pt->sleep(time);
    80010ae4:	00090513          	mv	a0,s2
    80010ae8:	00000097          	auipc	ra,0x0
    80010aec:	fa4080e7          	jalr	-92(ra) # 80010a8c <_ZN6Thread5sleepEm>
    while(true){
    80010af0:	fe5ff06f          	j	80010ad4 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080010af4 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80010af4:	ff010113          	addi	sp,sp,-16
    80010af8:	00113423          	sd	ra,8(sp)
    80010afc:	00813023          	sd	s0,0(sp)
    80010b00:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80010b04:	ffffe097          	auipc	ra,0xffffe
    80010b08:	62c080e7          	jalr	1580(ra) # 8000f130 <_Z15thread_dispatchv>
}
    80010b0c:	00813083          	ld	ra,8(sp)
    80010b10:	00013403          	ld	s0,0(sp)
    80010b14:	01010113          	addi	sp,sp,16
    80010b18:	00008067          	ret

0000000080010b1c <_ZN6Thread5startEv>:
int Thread::start() {
    80010b1c:	ff010113          	addi	sp,sp,-16
    80010b20:	00113423          	sd	ra,8(sp)
    80010b24:	00813023          	sd	s0,0(sp)
    80010b28:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80010b2c:	00853503          	ld	a0,8(a0)
    80010b30:	ffffe097          	auipc	ra,0xffffe
    80010b34:	6b4080e7          	jalr	1716(ra) # 8000f1e4 <_Z12thread_startP7_thread>
}
    80010b38:	00813083          	ld	ra,8(sp)
    80010b3c:	00013403          	ld	s0,0(sp)
    80010b40:	01010113          	addi	sp,sp,16
    80010b44:	00008067          	ret

0000000080010b48 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80010b48:	fe010113          	addi	sp,sp,-32
    80010b4c:	00113c23          	sd	ra,24(sp)
    80010b50:	00813823          	sd	s0,16(sp)
    80010b54:	00913423          	sd	s1,8(sp)
    80010b58:	01213023          	sd	s2,0(sp)
    80010b5c:	02010413          	addi	s0,sp,32
    80010b60:	00050493          	mv	s1,a0
    80010b64:	00058913          	mv	s2,a1
    80010b68:	01000513          	li	a0,16
    80010b6c:	00000097          	auipc	ra,0x0
    80010b70:	ce4080e7          	jalr	-796(ra) # 80010850 <_Znwm>
    80010b74:	00050613          	mv	a2,a0
    80010b78:	00050663          	beqz	a0,80010b84 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80010b7c:	00953023          	sd	s1,0(a0)
    80010b80:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80010b84:	00000597          	auipc	a1,0x0
    80010b88:	f3058593          	addi	a1,a1,-208 # 80010ab4 <_ZN14PeriodicThread7wrapperEPv>
    80010b8c:	00048513          	mv	a0,s1
    80010b90:	00000097          	auipc	ra,0x0
    80010b94:	e48080e7          	jalr	-440(ra) # 800109d8 <_ZN6ThreadC1EPFvPvES0_>
    80010b98:	00000797          	auipc	a5,0x0
    80010b9c:	61878793          	addi	a5,a5,1560 # 800111b0 <_ZTV14PeriodicThread+0x10>
    80010ba0:	00f4b023          	sd	a5,0(s1)
    80010ba4:	01813083          	ld	ra,24(sp)
    80010ba8:	01013403          	ld	s0,16(sp)
    80010bac:	00813483          	ld	s1,8(sp)
    80010bb0:	00013903          	ld	s2,0(sp)
    80010bb4:	02010113          	addi	sp,sp,32
    80010bb8:	00008067          	ret

0000000080010bbc <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80010bbc:	ff010113          	addi	sp,sp,-16
    80010bc0:	00113423          	sd	ra,8(sp)
    80010bc4:	00813023          	sd	s0,0(sp)
    80010bc8:	01010413          	addi	s0,sp,16
    return ::getc();
    80010bcc:	ffffe097          	auipc	ra,0xffffe
    80010bd0:	738080e7          	jalr	1848(ra) # 8000f304 <_Z4getcv>
}
    80010bd4:	00813083          	ld	ra,8(sp)
    80010bd8:	00013403          	ld	s0,0(sp)
    80010bdc:	01010113          	addi	sp,sp,16
    80010be0:	00008067          	ret

0000000080010be4 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80010be4:	ff010113          	addi	sp,sp,-16
    80010be8:	00113423          	sd	ra,8(sp)
    80010bec:	00813023          	sd	s0,0(sp)
    80010bf0:	01010413          	addi	s0,sp,16
    ::putc(c);
    80010bf4:	ffffe097          	auipc	ra,0xffffe
    80010bf8:	738080e7          	jalr	1848(ra) # 8000f32c <_Z4putcc>
}
    80010bfc:	00813083          	ld	ra,8(sp)
    80010c00:	00013403          	ld	s0,0(sp)
    80010c04:	01010113          	addi	sp,sp,16
    80010c08:	00008067          	ret

0000000080010c0c <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80010c0c:	ff010113          	addi	sp,sp,-16
    80010c10:	00813423          	sd	s0,8(sp)
    80010c14:	01010413          	addi	s0,sp,16
    80010c18:	00813403          	ld	s0,8(sp)
    80010c1c:	01010113          	addi	sp,sp,16
    80010c20:	00008067          	ret

0000000080010c24 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80010c24:	ff010113          	addi	sp,sp,-16
    80010c28:	00813423          	sd	s0,8(sp)
    80010c2c:	01010413          	addi	s0,sp,16
    80010c30:	00813403          	ld	s0,8(sp)
    80010c34:	01010113          	addi	sp,sp,16
    80010c38:	00008067          	ret

0000000080010c3c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80010c3c:	ff010113          	addi	sp,sp,-16
    80010c40:	00113423          	sd	ra,8(sp)
    80010c44:	00813023          	sd	s0,0(sp)
    80010c48:	01010413          	addi	s0,sp,16
    80010c4c:	00000797          	auipc	a5,0x0
    80010c50:	56478793          	addi	a5,a5,1380 # 800111b0 <_ZTV14PeriodicThread+0x10>
    80010c54:	00f53023          	sd	a5,0(a0)
    80010c58:	00000097          	auipc	ra,0x0
    80010c5c:	bb8080e7          	jalr	-1096(ra) # 80010810 <_ZN6ThreadD1Ev>
    80010c60:	00813083          	ld	ra,8(sp)
    80010c64:	00013403          	ld	s0,0(sp)
    80010c68:	01010113          	addi	sp,sp,16
    80010c6c:	00008067          	ret

0000000080010c70 <_ZN14PeriodicThreadD0Ev>:
    80010c70:	fe010113          	addi	sp,sp,-32
    80010c74:	00113c23          	sd	ra,24(sp)
    80010c78:	00813823          	sd	s0,16(sp)
    80010c7c:	00913423          	sd	s1,8(sp)
    80010c80:	02010413          	addi	s0,sp,32
    80010c84:	00050493          	mv	s1,a0
    80010c88:	00000797          	auipc	a5,0x0
    80010c8c:	52878793          	addi	a5,a5,1320 # 800111b0 <_ZTV14PeriodicThread+0x10>
    80010c90:	00f53023          	sd	a5,0(a0)
    80010c94:	00000097          	auipc	ra,0x0
    80010c98:	b7c080e7          	jalr	-1156(ra) # 80010810 <_ZN6ThreadD1Ev>
    80010c9c:	00048513          	mv	a0,s1
    80010ca0:	00000097          	auipc	ra,0x0
    80010ca4:	c00080e7          	jalr	-1024(ra) # 800108a0 <_ZdlPv>
    80010ca8:	01813083          	ld	ra,24(sp)
    80010cac:	01013403          	ld	s0,16(sp)
    80010cb0:	00813483          	ld	s1,8(sp)
    80010cb4:	02010113          	addi	sp,sp,32
    80010cb8:	00008067          	ret
	...

0000000080011000 <userDataStart>:
    80011000:	7542                	ld	a0,48(sp)
    80011002:	6666                	ld	a2,88(sp)
    80011004:	7265                	lui	tp,0xffff9
    80011006:	6420                	ld	s0,72(s0)
    80011008:	6c65                	lui	s8,0x19
    8001100a:	7465                	lui	s0,0xffff9
    8001100c:	6465                	lui	s0,0x19
    8001100e:	0a21                	addi	s4,s4,8
	...
    80011018:	3a41                	addiw	s4,s4,-16
    8001101a:	6920                	ld	s0,80(a0)
    8001101c:	003d                	c.nop	15
    8001101e:	0000                	unimp
    80011020:	000a                	c.slli	zero,0x2
    80011022:	0000                	unimp
    80011024:	0000                	unimp
    80011026:	0000                	unimp
    80011028:	2041                	0x2041
    8001102a:	6966                	ld	s2,88(sp)
    8001102c:	696e                	ld	s2,216(sp)
    8001102e:	64656873          	csrrsi	a6,0x646,10
    80011032:	0a21                	addi	s4,s4,8
    80011034:	0000                	unimp
    80011036:	0000                	unimp
    80011038:	3a42                	fld	fs4,48(sp)
    8001103a:	6920                	ld	s0,80(a0)
    8001103c:	003d                	c.nop	15
    8001103e:	0000                	unimp
    80011040:	2042                	fld	ft0,16(sp)
    80011042:	6966                	ld	s2,88(sp)
    80011044:	696e                	ld	s2,216(sp)
    80011046:	64656873          	csrrsi	a6,0x646,10
    8001104a:	0a21                	addi	s4,s4,8
    8001104c:	0000                	unimp
    8001104e:	0000                	unimp
    80011050:	69203a43          	fmadd.s	fs4,ft0,fs2,fa3,rup
    80011054:	003d                	c.nop	15
    80011056:	0000                	unimp
    80011058:	64203a43          	0x64203a43
    8001105c:	7369                	lui	t1,0xffffa
    8001105e:	6170                	ld	a2,192(a0)
    80011060:	6374                	ld	a3,192(a4)
    80011062:	0a68                	addi	a0,sp,284
    80011064:	0000                	unimp
    80011066:	0000                	unimp
    80011068:	74203a43          	0x74203a43
    8001106c:	3d31                	addiw	s10,s10,-20
    8001106e:	0000                	unimp
    80011070:	66203a43          	fmadd.q	fs4,ft0,ft2,fa2,rup
    80011074:	6269                	lui	tp,0x1a
    80011076:	63616e6f          	jal	t3,800276ac <end+0x156ac>
    8001107a:	3d69                	addiw	s10,s10,-6
    8001107c:	0000                	unimp
    8001107e:	0000                	unimp
    80011080:	3a44                	fld	fs1,176(a2)
    80011082:	6920                	ld	s0,80(a0)
    80011084:	003d                	c.nop	15
    80011086:	0000                	unimp
    80011088:	3a44                	fld	fs1,176(a2)
    8001108a:	6420                	ld	s0,72(s0)
    8001108c:	7369                	lui	t1,0xffffa
    8001108e:	6170                	ld	a2,192(a0)
    80011090:	6374                	ld	a3,192(a4)
    80011092:	0a68                	addi	a0,sp,284
    80011094:	0000                	unimp
    80011096:	0000                	unimp
    80011098:	3a44                	fld	fs1,176(a2)
    8001109a:	6620                	ld	s0,72(a2)
    8001109c:	6269                	lui	tp,0x1a
    8001109e:	63616e6f          	jal	t3,800276d4 <end+0x156d4>
    800110a2:	3d69                	addiw	s10,s10,-6
    800110a4:	0000                	unimp
    800110a6:	0000                	unimp
    800110a8:	2044                	fld	fs1,128(s0)
    800110aa:	6966                	ld	s2,88(sp)
    800110ac:	696e                	ld	s2,216(sp)
    800110ae:	64656873          	csrrsi	a6,0x646,10
    800110b2:	0a21                	addi	s4,s4,8
    800110b4:	0000                	unimp
    800110b6:	0000                	unimp
    800110b8:	6854                	ld	a3,144(s0)
    800110ba:	6572                	ld	a0,280(sp)
    800110bc:	6461                	lui	s0,0x18
    800110be:	2041                	0x2041
    800110c0:	61657263          	bgeu	a0,s6,800116c4 <lockPrint+0x4a4>
    800110c4:	6574                	ld	a3,200(a0)
    800110c6:	0a64                	addi	s1,sp,284
	...
    800110d0:	6854                	ld	a3,144(s0)
    800110d2:	6572                	ld	a0,280(sp)
    800110d4:	6461                	lui	s0,0x18
    800110d6:	2042                	fld	ft0,16(sp)
    800110d8:	61657263          	bgeu	a0,s6,800116dc <lockPrint+0x4bc>
    800110dc:	6574                	ld	a3,200(a0)
    800110de:	0a64                	addi	s1,sp,284
	...
    800110e8:	6854                	ld	a3,144(s0)
    800110ea:	6572                	ld	a0,280(sp)
    800110ec:	6461                	lui	s0,0x18
    800110ee:	72632043          	fmadd.d	ft0,ft6,ft6,fa4,rdn
    800110f2:	6165                	addi	sp,sp,112
    800110f4:	6574                	ld	a3,200(a0)
    800110f6:	0a64                	addi	s1,sp,284
	...
    80011100:	6854                	ld	a3,144(s0)
    80011102:	6572                	ld	a0,280(sp)
    80011104:	6461                	lui	s0,0x18
    80011106:	2044                	fld	fs1,128(s0)
    80011108:	61657263          	bgeu	a0,s6,8001170c <lockPrint+0x4ec>
    8001110c:	6574                	ld	a3,200(a0)
    8001110e:	0a64                	addi	s1,sp,284
	...
    80011118:	7355                	lui	t1,0xffff5
    8001111a:	7265                	lui	tp,0xffff9
    8001111c:	6d20                	ld	s0,88(a0)
    8001111e:	6961                	lui	s2,0x18
    80011120:	206e                	fld	ft0,216(sp)
    80011122:	6966                	ld	s2,88(sp)
    80011124:	696e                	ld	s2,216(sp)
    80011126:	64656873          	csrrsi	a6,0x646,10
    8001112a:	000a                	c.slli	zero,0x2
    8001112c:	0000                	unimp
    8001112e:	0000                	unimp
    80011130:	72617453          	0x72617453
    80011134:	6574                	ld	a3,200(a0)
    80011136:	2064                	fld	fs1,192(s0)
    80011138:	6874                	ld	a3,208(s0)
    8001113a:	6572                	ld	a0,280(sp)
    8001113c:	6461                	lui	s0,0x18
    8001113e:	6920                	ld	s0,80(a0)
    80011140:	3a64                	fld	fs1,240(a2)
    80011142:	0020                	addi	s0,sp,8
    80011144:	0000                	unimp
    80011146:	0000                	unimp
    80011148:	6946                	ld	s2,80(sp)
    8001114a:	696e                	ld	s2,216(sp)
    8001114c:	64656873          	csrrsi	a6,0x646,10
    80011150:	7420                	ld	s0,104(s0)
    80011152:	7268                	ld	a0,224(a2)
    80011154:	6165                	addi	sp,sp,112
    80011156:	2064                	fld	fs1,192(s0)
    80011158:	6469                	lui	s0,0x1a
    8001115a:	203a                	fld	ft0,392(sp)
    8001115c:	0000                	unimp
	...

0000000080011160 <_ZTV10ForkThread>:
	...
    80011170:	0104 8001 0000 0000 0138 8001 0000 0000     ........8.......
    80011180:	fee4 8000 0000 0000                         ........

0000000080011188 <digits>:
    80011188:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800111a0 <_ZTV14PeriodicThread>:
	...
    800111b0:	0c3c 8001 0000 0000 0c70 8001 0000 0000     <.......p.......
    800111c0:	0c0c 8001 0000 0000 0c24 8001 0000 0000     ........$.......

00000000800111d0 <_ZTV9Semaphore>:
	...
    800111e0:	07d8 8001 0000 0000 08c8 8001 0000 0000     ................

00000000800111f0 <_ZTV6Thread>:
	...
    80011200:	0810 8001 0000 0000 0908 8001 0000 0000     ................
    80011210:	0c0c 8001 0000 0000                         ........

0000000080011218 <finishedA>:
	...

0000000080011219 <finishedB>:
	...

000000008001121a <finishedC>:
	...

000000008001121b <finishedD>:
    8001121b:	0000 0000                                    .....

0000000080011220 <lockPrint>:
	...
    80011228:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    80011238:	0d1b 0002 0020 0000 0018 0000 dddc ffff     .... ...........
    80011248:	0030 0000 4400 100e 8844 4402 000c 0000     0....D..D..D....
    80011258:	0c00 1002 0e44 0000 0020 0000 003c 0000     ....D... ...<...
    80011268:	dde8 ffff 002c 0000 4400 100e 8844 4402     ....,....D..D..D
    80011278:	000c 0000 0c00 1002 0e44 0000 0034 0000     ........D...4...
    80011288:	0060 0000 ddf0 ffff 008c 0000 4400 000e     `............D..
	...
    800112a0:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    800112b0:	c944 d244 d344 0e44 4400 000b 0020 0000     D.D.D.D..D.. ...
    800112c0:	0098 0000 de44 ffff 0028 0000 4400 100e     ....D...(....D..
    800112d0:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    800112e0:	0020 0000 00bc 0000 de48 ffff 0020 0000      .......H... ...
    800112f0:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80011300:	0e44 0000 0034 0000 00e0 0000 de44 ffff     D...4.......D...
    80011310:	0094 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80011320:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    80011330:	c944 d244 d344 0e44 4400 000b 0024 0000     D.D.D.D..D..$...
    80011340:	0118 0000 dea0 ffff 0038 0000 4400 100e     ........8....D..
    80011350:	8844 4402 000c 0000 0000 020c 4410 000e     D..D.........D..
    80011360:	0b44 0000 0020 0000 0140 0000 deb0 ffff     D... ...@.......
    80011370:	0038 0000 4400 100e 8844 4402 000c 0000     8....D..D..D....
    80011380:	0c00 1002 0e44 0000 0020 0000 0164 0000     ....D... ...d...
    80011390:	dec4 ffff 002c 0000 4400 100e 8844 4402     ....,....D..D..D
    800113a0:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    800113b0:	0188 0000 decc ffff 002c 0000 4400 100e     ........,....D..
    800113c0:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    800113d0:	0020 0000 01ac 0000 ded4 ffff 002c 0000      ...........,...
    800113e0:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    800113f0:	0e44 0000 0020 0000 01d0 0000 dedc ffff     D... ...........
    80011400:	002c 0000 4400 100e 8844 4402 000c 0000     ,....D..D..D....
    80011410:	0c00 1002 0e44 0000 0020 0000 01f4 0000     ....D... .......
    80011420:	dee4 ffff 0028 0000 4400 100e 8844 4402     ....(....D..D..D
    80011430:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    80011440:	0218 0000 dee8 ffff 0024 0000 4400 100e     ........$....D..
    80011450:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80011460:	0020 0000 023c 0000 dee8 ffff 0028 0000      ...<.......(...
    80011470:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80011480:	0e44 0000 0020 0000 0260 0000 deec ffff     D... ...`.......
    80011490:	0024 0000 4400 100e 8844 4402 000c 0000     $....D..D..D....
    800114a0:	0c00 1002 0e44 0000 0010 0000 0000 0000     ....D...........
    800114b0:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    800114c0:	0018 0000 ded8 ffff 0028 0000 4400 000e     ........(....D..
    800114d0:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    800114e0:	0e44 0000 0000 0000 0010 0000 0000 0000     D...............
    800114f0:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80011500:	0018 0000 dec0 ffff 0028 0000 4400 000e     ........(....D..
    80011510:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80011520:	0e44 0000 0000 0000 0018 0000 0000 0000     D...............
    80011530:	7a03 4c50 0052 7c01 0701 a59b ff64 1bff     .zPLR..|....d...
    80011540:	0d1b 0002 0038 0000 0020 0000 dea0 ffff     ....8... .......
    80011550:	0164 0000 0204 ff63 44ff 000e 0000 0000     d.....c..D......
    80011560:	0000 0000 9300 440a 080c 0000 0000 0000     .......D........
    80011570:	0c00 3002 c944 d244 d344 0e44 4400 000b     ...0D.D.D.D..D..
    80011580:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    80011590:	0d1b 0002 002c 0000 0018 0000 dfb4 ffff     ....,...........
    800115a0:	0090 0000 4400 000e 0000 0000 0000 9200     .....D..........
    800115b0:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    800115c0:	44d2 000e 002c 0000 0048 0000 e014 ffff     .D..,...H.......
    800115d0:	008c 0000 4400 000e 0000 0000 0000 9200     .....D..........
    800115e0:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    800115f0:	44d2 000e 0030 0000 0078 0000 e070 ffff     .D..0...x...p...
    80011600:	0088 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80011610:	4408 080c 0000 0000 0000 0c00 2002 c944     .D........... D.
    80011620:	d244 0e44 4400 000b 002c 0000 0104 0000     D.D..D..,.......
    80011630:	e0c4 ffff 0100 0000 bf04 ff62 44ff 000e     ..........b..D..
    80011640:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    80011650:	020c 4420 44c9 000e 0010 0000 0000 0000     .. D.D..........
    80011660:	7a03 0052 7c01 0101 0d1b 0002 002c 0000     .zR..|......,...
    80011670:	0018 0000 e180 ffff 00cc 0000 4400 000e     .............D..
    80011680:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80011690:	0000 020c 4420 44c9 44d2 000e 002c 0000     .... D.D.D..,...
    800116a0:	0048 0000 e21c ffff 00d4 0000 4400 000e     H............D..
    800116b0:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    800116c0:	0000 020c 4420 44c9 44d2 000e 0018 0000     .... D.D.D......
    800116d0:	0000 0000 7a03 4c50 0052 7c01 0701 019b     .....zPLR..|....
    800116e0:	ff63 1bff 0d1b 0002 0044 0000 0020 0000     c.......D... ...
    800116f0:	e7f4 ffff 0220 0000 2d04 ff62 44ff 000e     .... ....-b..D..
	...
    8001170c:	0000 9600 4410 080c 0300 00d4 0000 0c00     .....D..........
    8001171c:	4002 c944 d244 d344 d444 d544 d644 0e44     .@D.D.D.D.D.D.D.
    8001172c:	0000 0000 0024 0000 00dc 0000 e9cc ffff     ....$...........
    8001173c:	0034 0000 4400 000e 0000 8800 4404 080c     4....D.......D..
    8001174c:	0000 0000 0c00 1002 0e44 0000 0028 0000     ........D...(...
    8001175c:	0104 0000 e9d8 ffff 004c 0000 4400 000e     ........L....D..
    8001176c:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    8001177c:	2002 c944 0e44 0000 0030 0000 0130 0000     . D.D...0...0...
    8001178c:	e208 ffff 0074 0000 4400 000e 0000 0000     ....t....D......
    8001179c:	0000 9200 4408 000c 0000 0000 0000 020c     .....D..........
    800117ac:	4420 44c9 44d2 000e 0b44 0000 0030 0000      D.D.D..D...0...
    800117bc:	0164 0000 e248 ffff 0180 0000 4400 000e     d...H........D..
    800117cc:	0000 0000 0000 9200 4408 080c 0300 0054     .........D....T.
    800117dc:	0000 0c00 2002 c944 d244 0e44 0000 0000     ..... D.D.D.....
    800117ec:	0030 0000 0198 0000 e394 ffff 0148 0000     0...........H...
    800117fc:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    8001180c:	0300 001c 0000 0c00 2002 c944 d244 0e44     ......... D.D.D.
    8001181c:	0000 0000 002c 0000 01cc 0000 e4a8 ffff     ....,...........
    8001182c:	012c 0000 4400 000e 0000 0000 8900 4406     ,....D.........D
    8001183c:	080c 0300 0008 0000 0c00 4002 c944 0e44     ...........@D.D.
    8001184c:	0000 0000 0030 0000 0188 0000 e5a4 ffff     ....0...........
    8001185c:	00c0 0000 9b04 ff60 44ff 000e 0000 0000     ......`..D......
    8001186c:	8900 4406 080c 0000 0000 0000 0c00 4002     ...D...........@
    8001187c:	c944 0e44 4400 000b 0028 0000 0230 0000     D.D..D..(...0...
    8001188c:	e630 ffff 0028 0000 4400 000e 0000 8800     0...(....D......
    8001189c:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    800118ac:	0000 0000 0010 0000 0000 0000 7a03 0052     .............zR.
    800118bc:	7c01 0101 0d1b 0002 002c 0000 0018 0000     .|......,.......
    800118cc:	e8b8 ffff 009c 0000 4400 000e 0000 0000     .........D......
    800118dc:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    800118ec:	4420 44c9 44d2 000e 002c 0000 0048 0000      D.D.D..,...H...
    800118fc:	e924 ffff 0090 0000 4400 000e 0000 0000     $........D......
    8001190c:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    8001191c:	4420 44c9 44d2 000e 002c 0000 0078 0000      D.D.D..,...x...
    8001192c:	e984 ffff 008c 0000 4400 000e 0000 0000     .........D......
    8001193c:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    8001194c:	4420 44c9 44d2 000e 0030 0000 00a8 0000      D.D.D..0.......
    8001195c:	e9e0 ffff 0088 0000 4400 000e 0000 0000     .........D......
    8001196c:	0000 9200 4408 080c 0000 0000 0000 0c00     .....D..........
    8001197c:	2002 c944 d244 0e44 4400 000b 0018 0000     . D.D.D..D......
    8001198c:	0000 0000 7a03 4c50 0052 7c01 0701 459b     .....zPLR..|...E
    8001199c:	ff60 1bff 0d1b 0002 0030 0000 0020 0000     `.......0... ...
    800119ac:	ea18 ffff 00e0 0000 6504 ff5f 44ff 000e     .........e_..D..
    800119bc:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    800119cc:	020c 4420 44c9 000e 0000 0000 0010 0000     .. D.D..........
    800119dc:	0000 0000 7a03 0052 7c01 0101 0d1b 0002     .....zR..|......
    800119ec:	0028 0000 0018 0000 eab0 ffff 007c 0000     (...........|...
    800119fc:	4400 000e 0000 0000 8900 4406 080c 0200     .D.........D....
    80011a0c:	0000 0000 020c 4420 44c9 000e 0034 0000     ...... D.D..4...
    80011a1c:	0044 0000 eb00 ffff 00cc 0000 4400 000e     D............D..
	...
    80011a34:	0000 9400 440c 080c 0200 0000 0000 020c     .....D..........
    80011a44:	4430 44c9 44d2 44d3 44d4 000e 0020 0000     0D.D.D.D.D.. ...
    80011a54:	007c 0000 eb94 ffff 0050 0000 4400 100e     |.......P....D..
    80011a64:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80011a74:	0030 0000 00a0 0000 ebc0 ffff 0114 0000     0...............
    80011a84:	4400 000e 0000 0000 0000 0000 9300 440a     .D.............D
    80011a94:	080c 0200 0000 0000 020c 4440 44c9 44d2     ..........@D.D.D
    80011aa4:	44d3 000e 0010 0000 0000 0000 7a03 0052     .D...........zR.
    80011ab4:	7c01 0101 0d1b 0002 0024 0000 0018 0000     .|......$.......
    80011ac4:	ec8c ffff 0034 0000 4400 000e 0000 8800     ....4....D......
    80011ad4:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80011ae4:	0028 0000 0040 0000 ec98 ffff 0028 0000     (...@.......(...
    80011af4:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80011b04:	0c00 1002 0e44 0000 0000 0000 0010 0000     ....D...........
    80011b14:	0000 0000 7a03 0052 7c01 0101 0d1b 0002     .....zR..|......
    80011b24:	0020 0000 0018 0000 f0e0 ffff 0018 0000      ...............
    80011b34:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80011b44:	0e44 0000 0020 0000 003c 0000 f0d4 ffff     D... ...<.......
    80011b54:	0018 0000 4400 100e 8844 4402 000c 0000     .....D..D..D....
    80011b64:	0c00 1002 0e44 0000 0024 0000 0060 0000     ....D...$...`...
    80011b74:	ec38 ffff 002c 0000 4400 000e 0000 8800     8...,....D......
    80011b84:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80011b94:	0018 0000 0000 0000 7a03 4c50 0052 7c01     .........zPLR..|
    80011ba4:	0701 399b ff5e 1bff 0d1b 0002 0028 0000     ...9^.......(...
    80011bb4:	0020 0000 ec20 ffff 0038 0000 5d04 ff5d      ... ...8....]].
    80011bc4:	44ff 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80011bd4:	0c00 1002 0e44 0000 0028 0000 004c 0000     ....D...(...L...
    80011be4:	ec2c ffff 0040 0000 3504 ff5d 58ff 000e     ,...@....5]..X..
    80011bf4:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80011c04:	0e44 0000 0024 0000 00fc 0000 f02c ffff     D...$.......,...
    80011c14:	0034 0000 4400 000e 0000 8800 4404 080c     4....D.......D..
    80011c24:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80011c34:	0124 0000 ec18 ffff 0028 0000 4400 000e     $.......(....D..
    80011c44:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80011c54:	0e44 0000 0024 0000 014c 0000 ec18 ffff     D...$...L.......
    80011c64:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    80011c74:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80011c84:	0174 0000 ec18 ffff 0028 0000 4400 000e     t.......(....D..
    80011c94:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80011ca4:	0e44 0000 0028 0000 019c 0000 ec18 ffff     D...(...........
    80011cb4:	0040 0000 4400 000e 0000 0000 8900 4406     @....D.........D
    80011cc4:	080c 0000 0000 0c00 2002 c944 0e44 0000     ......... D.D...
    80011cd4:	0028 0000 01c8 0000 ec2c ffff 0040 0000     (.......,...@...
    80011ce4:	4400 000e 0000 0000 8900 4406 080c 0000     .D.........D....
    80011cf4:	0000 0c00 2002 c944 0e44 0000 0028 0000     ..... D.D...(...
    80011d04:	01f4 0000 ef68 ffff 004c 0000 4400 000e     ....h...L....D..
    80011d14:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    80011d24:	2002 c944 0e44 0000 0024 0000 0220 0000     . D.D...$... ...
    80011d34:	ec14 ffff 0038 0000 4400 000e 0000 8800     ....8....D......
    80011d44:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80011d54:	0024 0000 0248 0000 ec24 ffff 002c 0000     $...H...$...,...
    80011d64:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80011d74:	0c00 1002 0e44 0000 0024 0000 0270 0000     ....D...$...p...
    80011d84:	ec28 ffff 002c 0000 4400 000e 0000 8800     (...,....D......
    80011d94:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80011da4:	002c 0000 0298 0000 ec2c ffff 0054 0000     ,.......,...T...
    80011db4:	4400 000e 0000 0000 8900 4406 000c 0000     .D.........D....
    80011dc4:	0000 0000 020c 4420 44c9 000e 0b44 0000     ...... D.D..D...
    80011dd4:	002c 0000 02c8 0000 ec50 ffff 0060 0000     ,.......P...`...
    80011de4:	4400 000e 0000 0000 8900 4406 000c 0000     .D.........D....
    80011df4:	0000 0000 020c 4420 44c9 000e 0b44 0000     ...... D.D..D...
    80011e04:	0024 0000 02f8 0000 ec80 ffff 0028 0000     $...........(...
    80011e14:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80011e24:	0c00 1002 0e44 0000 0020 0000 0320 0000     ....D... ... ...
    80011e34:	ec80 ffff 0040 0000 4400 000e 0000 0000     ....@....D......
    80011e44:	0000 9200 4408 080c 0000 0000 0024 0000     .....D......$...
    80011e54:	0344 0000 ec9c ffff 0028 0000 4400 000e     D.......(....D..
    80011e64:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80011e74:	0e44 0000 0024 0000 036c 0000 ec9c ffff     D...$...l.......
    80011e84:	002c 0000 4400 000e 0000 8800 4404 080c     ,....D.......D..
    80011e94:	0000 0000 0c00 1002 0e44 0000 002c 0000     ........D...,...
    80011ea4:	0394 0000 eca0 ffff 0074 0000 4400 000e     ........t....D..
    80011eb4:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80011ec4:	0000 020c 4420 44c9 44d2 000e 0024 0000     .... D.D.D..$...
    80011ed4:	03c4 0000 ece4 ffff 0028 0000 4400 000e     ........(....D..
    80011ee4:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80011ef4:	0e44 0000 0024 0000 03ec 0000 ece4 ffff     D...$...........
    80011f04:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    80011f14:	0000 0000 0c00 1002 0e44 0000 0000 0000     ........D.......
	...
