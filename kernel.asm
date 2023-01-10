
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00008117          	auipc	sp,0x8
    80000004:	b3013103          	ld	sp,-1232(sp) # 80007b30 <_GLOBAL_OFFSET_TABLE_+0x70>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	3b5040ef          	jal	ra,80004bd0 <start>

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
    80001088:	549020ef          	jal	ra,80003dd0 <_ZN5RiscV20handleSupervisorTrapEv>

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
    80001164:	08c080e7          	jalr	140(ra) # 800021ec <_ZN5Buddy4freeEPvm>
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
    800011d4:	00003097          	auipc	ra,0x3
    800011d8:	7f8080e7          	jalr	2040(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of slots:", (uint64) slab->totalNumOfSlots, "\n");
    800011dc:	01000693          	li	a3,16
    800011e0:	00006617          	auipc	a2,0x6
    800011e4:	17060613          	addi	a2,a2,368 # 80007350 <CONSOLE_STATUS+0x340>
    800011e8:	01892583          	lw	a1,24(s2)
    800011ec:	00006517          	auipc	a0,0x6
    800011f0:	e4450513          	addi	a0,a0,-444 # 80007030 <CONSOLE_STATUS+0x20>
    800011f4:	00003097          	auipc	ra,0x3
    800011f8:	7d8080e7          	jalr	2008(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Number of free slots:", (uint64) slab->numOfFreeSlots, "\n");
    800011fc:	01000693          	li	a3,16
    80001200:	00006617          	auipc	a2,0x6
    80001204:	15060613          	addi	a2,a2,336 # 80007350 <CONSOLE_STATUS+0x340>
    80001208:	01092583          	lw	a1,16(s2)
    8000120c:	00006517          	auipc	a0,0x6
    80001210:	e3c50513          	addi	a0,a0,-452 # 80007048 <CONSOLE_STATUS+0x38>
    80001214:	00003097          	auipc	ra,0x3
    80001218:	7b8080e7          	jalr	1976(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab object size:", (uint64) sizeof(Slab), "\n");
    8000121c:	01000693          	li	a3,16
    80001220:	00006617          	auipc	a2,0x6
    80001224:	13060613          	addi	a2,a2,304 # 80007350 <CONSOLE_STATUS+0x340>
    80001228:	03800593          	li	a1,56
    8000122c:	00006517          	auipc	a0,0x6
    80001230:	e3450513          	addi	a0,a0,-460 # 80007060 <CONSOLE_STATUS+0x50>
    80001234:	00003097          	auipc	ra,0x3
    80001238:	798080e7          	jalr	1944(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Object offset:", (uint64) slab->objectOffset, "\n");
    8000123c:	01000693          	li	a3,16
    80001240:	00006617          	auipc	a2,0x6
    80001244:	11060613          	addi	a2,a2,272 # 80007350 <CONSOLE_STATUS+0x340>
    80001248:	02892583          	lw	a1,40(s2)
    8000124c:	00006517          	auipc	a0,0x6
    80001250:	e2c50513          	addi	a0,a0,-468 # 80007078 <CONSOLE_STATUS+0x68>
    80001254:	00003097          	auipc	ra,0x3
    80001258:	778080e7          	jalr	1912(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::print("Slab allocated array address:", (uint64) slab->allocated, "\n");
    8000125c:	01000693          	li	a3,16
    80001260:	00006617          	auipc	a2,0x6
    80001264:	0f060613          	addi	a2,a2,240 # 80007350 <CONSOLE_STATUS+0x340>
    80001268:	02092583          	lw	a1,32(s2)
    8000126c:	00006517          	auipc	a0,0x6
    80001270:	e1c50513          	addi	a0,a0,-484 # 80007088 <CONSOLE_STATUS+0x78>
    80001274:	00003097          	auipc	ra,0x3
    80001278:	758080e7          	jalr	1880(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        ConsoleUtil::printString("Allocated status array:\n");
    8000127c:	00006517          	auipc	a0,0x6
    80001280:	e2c50513          	addi	a0,a0,-468 # 800070a8 <CONSOLE_STATUS+0x98>
    80001284:	00003097          	auipc	ra,0x3
    80001288:	628080e7          	jalr	1576(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
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
    800012b4:	00003097          	auipc	ra,0x3
    800012b8:	718080e7          	jalr	1816(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
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
    800012dc:	5d4080e7          	jalr	1492(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
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
    80001324:	58c080e7          	jalr	1420(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString(cache->name);
    80001328:	00090513          	mv	a0,s2
    8000132c:	00003097          	auipc	ra,0x3
    80001330:	580080e7          	jalr	1408(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printString("\n");
    80001334:	00006517          	auipc	a0,0x6
    80001338:	01c50513          	addi	a0,a0,28 # 80007350 <CONSOLE_STATUS+0x340>
    8000133c:	00003097          	auipc	ra,0x3
    80001340:	570080e7          	jalr	1392(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::print("HEAP_START_ADDR: ", (uint64)HEAP_START_ADDR, "\n");
    80001344:	01000693          	li	a3,16
    80001348:	00006617          	auipc	a2,0x6
    8000134c:	00860613          	addi	a2,a2,8 # 80007350 <CONSOLE_STATUS+0x340>
    80001350:	00006797          	auipc	a5,0x6
    80001354:	7887b783          	ld	a5,1928(a5) # 80007ad8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001358:	0007a583          	lw	a1,0(a5)
    8000135c:	00006517          	auipc	a0,0x6
    80001360:	d7c50513          	addi	a0,a0,-644 # 800070d8 <CONSOLE_STATUS+0xc8>
    80001364:	00003097          	auipc	ra,0x3
    80001368:	668080e7          	jalr	1640(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache address: ", (uint64)cache, "\n");
    8000136c:	01000693          	li	a3,16
    80001370:	00006617          	auipc	a2,0x6
    80001374:	fe060613          	addi	a2,a2,-32 # 80007350 <CONSOLE_STATUS+0x340>
    80001378:	0009059b          	sext.w	a1,s2
    8000137c:	00006517          	auipc	a0,0x6
    80001380:	d7450513          	addi	a0,a0,-652 # 800070f0 <CONSOLE_STATUS+0xe0>
    80001384:	00003097          	auipc	ra,0x3
    80001388:	648080e7          	jalr	1608(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache slab size: ", (uint64)cache->slabSize, "\n");
    8000138c:	01000693          	li	a3,16
    80001390:	00006617          	auipc	a2,0x6
    80001394:	fc060613          	addi	a2,a2,-64 # 80007350 <CONSOLE_STATUS+0x340>
    80001398:	04892583          	lw	a1,72(s2)
    8000139c:	00006517          	auipc	a0,0x6
    800013a0:	d6450513          	addi	a0,a0,-668 # 80007100 <CONSOLE_STATUS+0xf0>
    800013a4:	00003097          	auipc	ra,0x3
    800013a8:	628080e7          	jalr	1576(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Cache object size: ", (uint64)cache->objectSize, "\n");
    800013ac:	01000693          	li	a3,16
    800013b0:	00006617          	auipc	a2,0x6
    800013b4:	fa060613          	addi	a2,a2,-96 # 80007350 <CONSOLE_STATUS+0x340>
    800013b8:	04092583          	lw	a1,64(s2)
    800013bc:	00006517          	auipc	a0,0x6
    800013c0:	d5c50513          	addi	a0,a0,-676 # 80007118 <CONSOLE_STATUS+0x108>
    800013c4:	00003097          	auipc	ra,0x3
    800013c8:	608080e7          	jalr	1544(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
    ConsoleUtil::print("Empty head: ", (uint64)cache->emptyHead, "\n");
    800013cc:	01000693          	li	a3,16
    800013d0:	00006617          	auipc	a2,0x6
    800013d4:	f8060613          	addi	a2,a2,-128 # 80007350 <CONSOLE_STATUS+0x340>
    800013d8:	06092583          	lw	a1,96(s2)
    800013dc:	00006517          	auipc	a0,0x6
    800013e0:	d5450513          	addi	a0,a0,-684 # 80007130 <CONSOLE_STATUS+0x120>
    800013e4:	00003097          	auipc	ra,0x3
    800013e8:	5e8080e7          	jalr	1512(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>

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
    80001410:	5c0080e7          	jalr	1472(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001414:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001418:	fd9ff06f          	j	800013f0 <_ZN13SlabAllocator10printCacheEP5Cache+0xf4>
    }
    ConsoleUtil::printString("\n");
    8000141c:	00006517          	auipc	a0,0x6
    80001420:	f3450513          	addi	a0,a0,-204 # 80007350 <CONSOLE_STATUS+0x340>
    80001424:	00003097          	auipc	ra,0x3
    80001428:	488080e7          	jalr	1160(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Partial head: ", (uint64)cache->partialHead, "\n");
    8000142c:	01000693          	li	a3,16
    80001430:	00006617          	auipc	a2,0x6
    80001434:	f2060613          	addi	a2,a2,-224 # 80007350 <CONSOLE_STATUS+0x340>
    80001438:	06892583          	lw	a1,104(s2)
    8000143c:	00006517          	auipc	a0,0x6
    80001440:	d0450513          	addi	a0,a0,-764 # 80007140 <CONSOLE_STATUS+0x130>
    80001444:	00003097          	auipc	ra,0x3
    80001448:	588080e7          	jalr	1416(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>

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
    80001470:	560080e7          	jalr	1376(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    80001474:	0084b483          	ld	s1,8(s1)
    while(iter){
    80001478:	fd9ff06f          	j	80001450 <_ZN13SlabAllocator10printCacheEP5Cache+0x154>
    }
    ConsoleUtil::printString("\n");
    8000147c:	00006517          	auipc	a0,0x6
    80001480:	ed450513          	addi	a0,a0,-300 # 80007350 <CONSOLE_STATUS+0x340>
    80001484:	00003097          	auipc	ra,0x3
    80001488:	428080e7          	jalr	1064(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>

    ConsoleUtil::print("Full head: ", (uint64)cache->fullHead, "\n");
    8000148c:	01000693          	li	a3,16
    80001490:	00006617          	auipc	a2,0x6
    80001494:	ec060613          	addi	a2,a2,-320 # 80007350 <CONSOLE_STATUS+0x340>
    80001498:	07092583          	lw	a1,112(s2)
    8000149c:	00006517          	auipc	a0,0x6
    800014a0:	cb450513          	addi	a0,a0,-844 # 80007150 <CONSOLE_STATUS+0x140>
    800014a4:	00003097          	auipc	ra,0x3
    800014a8:	528080e7          	jalr	1320(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>

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
    800014d0:	500080e7          	jalr	1280(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        iter = iter->next;
    800014d4:	0084b483          	ld	s1,8(s1)
    while(iter){
    800014d8:	fd9ff06f          	j	800014b0 <_ZN13SlabAllocator10printCacheEP5Cache+0x1b4>
    }
    ConsoleUtil::printString("\n");
    800014dc:	00006517          	auipc	a0,0x6
    800014e0:	e7450513          	addi	a0,a0,-396 # 80007350 <CONSOLE_STATUS+0x340>
    800014e4:	00003097          	auipc	ra,0x3
    800014e8:	3c8080e7          	jalr	968(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
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
    8000155c:	d6c080e7          	jalr	-660(ra) # 800022c4 <_ZN5Buddy5allocEm>
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
    800018e8:	30c78793          	addi	a5,a5,780 # 80007bf0 <_ZN13SlabAllocator5sizeNE>
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
    8000194c:	31053503          	ld	a0,784(a0) # 80007c58 <_ZN13SlabAllocator5cacheE>
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
    8000198c:	9ec080e7          	jalr	-1556(ra) # 80004374 <_Z6strcpyPKcPc>
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
    800019dc:	51c080e7          	jalr	1308(ra) # 80001ef4 <_ZN5Buddy10initializeEPvm>
    startAddr = space;
    800019e0:	00006797          	auipc	a5,0x6
    800019e4:	21078793          	addi	a5,a5,528 # 80007bf0 <_ZN13SlabAllocator5sizeNE>
    800019e8:	0727b823          	sd	s2,112(a5)
    blocksResponsibleFor = blockNum;
    800019ec:	0697bc23          	sd	s1,120(a5)
    cache = (Cache*)SLAB_META_ADDR_CONST;
    800019f0:	00006717          	auipc	a4,0x6
    800019f4:	0e873703          	ld	a4,232(a4) # 80007ad8 <_GLOBAL_OFFSET_TABLE_+0x18>
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
    80001a3c:	93c080e7          	jalr	-1732(ra) # 80004374 <_Z6strcpyPKcPc>
    for(int i=0;i<BUCKET_SIZE;i++){
    80001a40:	00000493          	li	s1,0
    80001a44:	0440006f          	j	80001a88 <_ZN13SlabAllocator10initializeEPvm+0xd0>
        sizeN[i] = SlabAllocator::createCache(names[i], 2<<i, nullptr, nullptr);
    80001a48:	00349913          	slli	s2,s1,0x3
    80001a4c:	00006797          	auipc	a5,0x6
    80001a50:	ff478793          	addi	a5,a5,-12 # 80007a40 <_ZN13SlabAllocator5namesE>
    80001a54:	012787b3          	add	a5,a5,s2
    80001a58:	00000693          	li	a3,0
    80001a5c:	00000613          	li	a2,0
    80001a60:	00200593          	li	a1,2
    80001a64:	009595bb          	sllw	a1,a1,s1
    80001a68:	0007b503          	ld	a0,0(a5)
    80001a6c:	00000097          	auipc	ra,0x0
    80001a70:	ea8080e7          	jalr	-344(ra) # 80001914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
    80001a74:	00006797          	auipc	a5,0x6
    80001a78:	17c78793          	addi	a5,a5,380 # 80007bf0 <_ZN13SlabAllocator5sizeNE>
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
    80001b84:	66c080e7          	jalr	1644(ra) # 800021ec <_ZN5Buddy4freeEPvm>
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
    80001cb4:	f4078793          	addi	a5,a5,-192 # 80007bf0 <_ZN13SlabAllocator5sizeNE>
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
    80001d28:	4c8080e7          	jalr	1224(ra) # 800021ec <_ZN5Buddy4freeEPvm>
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
    80001d58:	498080e7          	jalr	1176(ra) # 800021ec <_ZN5Buddy4freeEPvm>
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
    80001d88:	468080e7          	jalr	1128(ra) # 800021ec <_ZN5Buddy4freeEPvm>
            head = head->next;
    80001d8c:	00093783          	ld	a5,0(s2)
    80001d90:	0087b783          	ld	a5,8(a5)
    80001d94:	00f93023          	sd	a5,0(s2)
        while(head){
    80001d98:	fddff06f          	j	80001d74 <_ZN13SlabAllocator11deleteCacheERP5Cache+0x84>
    SlabAllocator::freeObject(SlabAllocator::cache, cache);
    80001d9c:	0004b583          	ld	a1,0(s1)
    80001da0:	00006517          	auipc	a0,0x6
    80001da4:	eb853503          	ld	a0,-328(a0) # 80007c58 <_ZN13SlabAllocator5cacheE>
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
    80001e00:	e747c783          	lbu	a5,-396(a5) # 80007c70 <_ZN6System11initializedE>
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
    80001e24:	e4f70823          	sb	a5,-432(a4) # 80007c70 <_ZN6System11initializedE>

        //initialize the machine
        RiscV::initialize();
    80001e28:	00001097          	auipc	ra,0x1
    80001e2c:	274080e7          	jalr	628(ra) # 8000309c <_ZN5RiscV10initializeEv>
        //creating a thread that will be executing user code
        //this is done as to separate user code execution from main kernel thread
        //also it provides kernel with an idle thread that will run itself if user code gets blocked (on getc syscall for example)

        thread_t userMainThread;
        RiscV::threadCreateUtil((TCB**)(&userMainThread), TCBWrapper::userMainWrapper, nullptr);
    80001e30:	00000613          	li	a2,0
    80001e34:	00006597          	auipc	a1,0x6
    80001e38:	d645b583          	ld	a1,-668(a1) # 80007b98 <_GLOBAL_OFFSET_TABLE_+0xd8>
    80001e3c:	fe840513          	addi	a0,s0,-24
    80001e40:	00002097          	auipc	ra,0x2
    80001e44:	3f0080e7          	jalr	1008(ra) # 80004230 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>


//        //return control to user code until it reaches the end
//        //exit only if user is finished and machine is ready to exit (in case there is something still left to print, wait for it to be done)
        while (( (TCB*)userMainThread)->status != TCB::Status::FINISHED) {
    80001e48:	fe843783          	ld	a5,-24(s0)
    80001e4c:	0107a703          	lw	a4,16(a5)
    80001e50:	00200793          	li	a5,2
    80001e54:	00f70863          	beq	a4,a5,80001e64 <_ZN6SystemC1Ev+0x68>
            RiscV::threadDispatchUtil();
    80001e58:	00002097          	auipc	ra,0x2
    80001e5c:	474080e7          	jalr	1140(ra) # 800042cc <_ZN5RiscV18threadDispatchUtilEv>
    80001e60:	fe9ff06f          	j	80001e48 <_ZN6SystemC1Ev+0x4c>
        }

        //finalize the machine
        RiscV::finalize();
    80001e64:	00001097          	auipc	ra,0x1
    80001e68:	680080e7          	jalr	1664(ra) # 800034e4 <_ZN5RiscV8finalizeEv>
    }
}
    80001e6c:	01813083          	ld	ra,24(sp)
    80001e70:	01013403          	ld	s0,16(sp)
    80001e74:	02010113          	addi	sp,sp,32
    80001e78:	00008067          	ret

0000000080001e7c <_ZN6System15userMainWrapperEPv>:

//wrapper function for userMain as per POSIX threads
void System::userMainWrapper(void *arg){
    80001e7c:	ff010113          	addi	sp,sp,-16
    80001e80:	00813423          	sd	s0,8(sp)
    80001e84:	01010413          	addi	s0,sp,16
//        printString("otac\n");
//        thread_dispatch();
//    }
//    MemoryAllocator::showMemory();
//    testUser();
    80001e88:	00813403          	ld	s0,8(sp)
    80001e8c:	01010113          	addi	sp,sp,16
    80001e90:	00008067          	ret

0000000080001e94 <_Z41__static_initialization_and_destruction_0ii>:
            ConsoleUtil::printString(" ");
            tmp = tmp->next;
        }
        ConsoleUtil::printString("\n");
    }
    80001e94:	ff010113          	addi	sp,sp,-16
    80001e98:	00813423          	sd	s0,8(sp)
    80001e9c:	01010413          	addi	s0,sp,16
    80001ea0:	00100793          	li	a5,1
    80001ea4:	00f50863          	beq	a0,a5,80001eb4 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001ea8:	00813403          	ld	s0,8(sp)
    80001eac:	01010113          	addi	sp,sp,16
    80001eb0:	00008067          	ret
    80001eb4:	000107b7          	lui	a5,0x10
    80001eb8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001ebc:	fef596e3          	bne	a1,a5,80001ea8 <_Z41__static_initialization_and_destruction_0ii+0x14>
void* Buddy::BUDDY_START_ADDR = BUDDY_START_ADDR_CONST;
    80001ec0:	00006797          	auipc	a5,0x6
    80001ec4:	c187b783          	ld	a5,-1000(a5) # 80007ad8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001ec8:	0007b703          	ld	a4,0(a5)
    80001ecc:	00c75793          	srli	a5,a4,0xc
    80001ed0:	00278793          	addi	a5,a5,2
    80001ed4:	00c79793          	slli	a5,a5,0xc
    80001ed8:	00006697          	auipc	a3,0x6
    80001edc:	da068693          	addi	a3,a3,-608 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001ee0:	00f6b023          	sd	a5,0(a3)
void* Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001ee4:	fffff7b7          	lui	a5,0xfffff
    80001ee8:	00f77733          	and	a4,a4,a5
    80001eec:	00e6b423          	sd	a4,8(a3)
    80001ef0:	fb9ff06f          	j	80001ea8 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001ef4 <_ZN5Buddy10initializeEPvm>:
void Buddy::initialize(void* addr, uint64 block_num){
    80001ef4:	ff010113          	addi	sp,sp,-16
    80001ef8:	00813423          	sd	s0,8(sp)
    80001efc:	01010413          	addi	s0,sp,16
    Buddy::BUDDY_START_ADDR = addr;
    80001f00:	00006717          	auipc	a4,0x6
    80001f04:	d7870713          	addi	a4,a4,-648 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f08:	00a73023          	sd	a0,0(a4)
    Buddy::BUDDY_META_DATA_ADDR = BUDDY_META_ADDR_CONST;
    80001f0c:	00006797          	auipc	a5,0x6
    80001f10:	bcc7b783          	ld	a5,-1076(a5) # 80007ad8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001f14:	0007b783          	ld	a5,0(a5)
    80001f18:	fffff6b7          	lui	a3,0xfffff
    80001f1c:	00d7f7b3          	and	a5,a5,a3
    80001f20:	00f73423          	sd	a5,8(a4)
    Buddy::BLOCKS_AVAILABLE = block_num;
    80001f24:	00006797          	auipc	a5,0x6
    80001f28:	b8b7b223          	sd	a1,-1148(a5) # 80007aa8 <_ZN5Buddy16BLOCKS_AVAILABLEE>
    80001f2c:	00058793          	mv	a5,a1
        num |= num>>32;
        return ++num;
    }

    static inline uint64 getDeg(uint64 num){
        uint64 deg = 0;
    80001f30:	00000713          	li	a4,0
        while(num>1){
    80001f34:	00100693          	li	a3,1
    80001f38:	00f6f863          	bgeu	a3,a5,80001f48 <_ZN5Buddy10initializeEPvm+0x54>
            num/=2;
    80001f3c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f40:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f44:	ff1ff06f          	j	80001f34 <_ZN5Buddy10initializeEPvm+0x40>
    head[getDeg(block_num)] = tail[getDeg(block_num)] = (Block*)BUDDY_START_ADDR;
    80001f48:	00371713          	slli	a4,a4,0x3
    80001f4c:	00006797          	auipc	a5,0x6
    80001f50:	d2c78793          	addi	a5,a5,-724 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f54:	00e78733          	add	a4,a5,a4
    80001f58:	00a73823          	sd	a0,16(a4)
    80001f5c:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001f60:	00000713          	li	a4,0
        while(num>1){
    80001f64:	00100693          	li	a3,1
    80001f68:	00f6f863          	bgeu	a3,a5,80001f78 <_ZN5Buddy10initializeEPvm+0x84>
            num/=2;
    80001f6c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001f70:	00170713          	addi	a4,a4,1
        while(num>1){
    80001f74:	ff1ff06f          	j	80001f64 <_ZN5Buddy10initializeEPvm+0x70>
    80001f78:	00371713          	slli	a4,a4,0x3
    80001f7c:	00006797          	auipc	a5,0x6
    80001f80:	cfc78793          	addi	a5,a5,-772 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001f84:	00e78733          	add	a4,a5,a4
    80001f88:	06a73c23          	sd	a0,120(a4)
    80001f8c:	00058793          	mv	a5,a1
        uint64 deg = 0;
    80001f90:	00000713          	li	a4,0
        while(num>1){
    80001f94:	00100693          	li	a3,1
    80001f98:	00f6f863          	bgeu	a3,a5,80001fa8 <_ZN5Buddy10initializeEPvm+0xb4>
            num/=2;
    80001f9c:	0017d793          	srli	a5,a5,0x1
            deg++;
    80001fa0:	00170713          	addi	a4,a4,1
        while(num>1){
    80001fa4:	ff1ff06f          	j	80001f94 <_ZN5Buddy10initializeEPvm+0xa0>
    head[getDeg(block_num)]->next = tail[getDeg(block_num)]->next = nullptr;
    80001fa8:	00371713          	slli	a4,a4,0x3
    80001fac:	00006797          	auipc	a5,0x6
    80001fb0:	ccc78793          	addi	a5,a5,-820 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001fb4:	00e78733          	add	a4,a5,a4
    80001fb8:	01073783          	ld	a5,16(a4)
    80001fbc:	0007b023          	sd	zero,0(a5)
        uint64 deg = 0;
    80001fc0:	00000793          	li	a5,0
    80001fc4:	00c0006f          	j	80001fd0 <_ZN5Buddy10initializeEPvm+0xdc>
            num/=2;
    80001fc8:	0015d593          	srli	a1,a1,0x1
            deg++;
    80001fcc:	00178793          	addi	a5,a5,1
        while(num>1){
    80001fd0:	00100713          	li	a4,1
    80001fd4:	feb76ae3          	bltu	a4,a1,80001fc8 <_ZN5Buddy10initializeEPvm+0xd4>
    80001fd8:	00379793          	slli	a5,a5,0x3
    80001fdc:	00006717          	auipc	a4,0x6
    80001fe0:	c9c70713          	addi	a4,a4,-868 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80001fe4:	00f707b3          	add	a5,a4,a5
    80001fe8:	0787b783          	ld	a5,120(a5)
    80001fec:	0007b023          	sd	zero,0(a5)
}
    80001ff0:	00813403          	ld	s0,8(sp)
    80001ff4:	01010113          	addi	sp,sp,16
    80001ff8:	00008067          	ret

0000000080001ffc <_ZN5Buddy8compressEm>:
    if(size == BUCKET_SIZE-1)
    80001ffc:	00c00793          	li	a5,12
    80002000:	10f50063          	beq	a0,a5,80002100 <_ZN5Buddy8compressEm+0x104>
void Buddy::compress(uint64 size) {
    80002004:	fd010113          	addi	sp,sp,-48
    80002008:	02113423          	sd	ra,40(sp)
    8000200c:	02813023          	sd	s0,32(sp)
    80002010:	00913c23          	sd	s1,24(sp)
    80002014:	01213823          	sd	s2,16(sp)
    80002018:	01313423          	sd	s3,8(sp)
    8000201c:	03010413          	addi	s0,sp,48
    80002020:	00050913          	mv	s2,a0
    Block *curr = head[size];
    80002024:	00351713          	slli	a4,a0,0x3
    80002028:	00006797          	auipc	a5,0x6
    8000202c:	c5078793          	addi	a5,a5,-944 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002030:	00e787b3          	add	a5,a5,a4
    80002034:	0787b483          	ld	s1,120(a5)
    Block *prev = nullptr;
    80002038:	00000993          	li	s3,0
    8000203c:	0180006f          	j	80002054 <_ZN5Buddy8compressEm+0x58>
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    80002040:	fff70713          	addi	a4,a4,-1
        if(blkNoNext == pair){
    80002044:	04f70463          	beq	a4,a5,8000208c <_ZN5Buddy8compressEm+0x90>
            prev = curr;
    80002048:	00048993          	mv	s3,s1
        if(blkNoNext == pair){
    8000204c:	08f70063          	beq	a4,a5,800020cc <_ZN5Buddy8compressEm+0xd0>
        curr = curr->next;
    80002050:	0004b483          	ld	s1,0(s1)
    while(curr && curr->next != nullptr){
    80002054:	08048863          	beqz	s1,800020e4 <_ZN5Buddy8compressEm+0xe8>
    80002058:	0004b683          	ld	a3,0(s1)
    8000205c:	08068463          	beqz	a3,800020e4 <_ZN5Buddy8compressEm+0xe8>
        uint64 blkNoCurr = ((uint64)(curr) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002060:	00006797          	auipc	a5,0x6
    80002064:	c187b783          	ld	a5,-1000(a5) # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002068:	40f48733          	sub	a4,s1,a5
    8000206c:	00c9061b          	addiw	a2,s2,12
    80002070:	00c75733          	srl	a4,a4,a2
        uint64 blkNoNext = ((uint64)(curr->next) - (uint64)Buddy::BUDDY_START_ADDR) >> (BUDDY_BLOCK_BITS+size);
    80002074:	40f687b3          	sub	a5,a3,a5
    80002078:	00c7d7b3          	srl	a5,a5,a2
        uint64 pair = (blkNoCurr % 2 == 0) ? blkNoCurr + 1 : blkNoCurr - 1;
    8000207c:	00177613          	andi	a2,a4,1
    80002080:	fc0610e3          	bnez	a2,80002040 <_ZN5Buddy8compressEm+0x44>
    80002084:	00170713          	addi	a4,a4,1
    80002088:	fbdff06f          	j	80002044 <_ZN5Buddy8compressEm+0x48>
            if(prev){
    8000208c:	00098863          	beqz	s3,8000209c <_ZN5Buddy8compressEm+0xa0>
                prev->next = curr->next->next;
    80002090:	0006b683          	ld	a3,0(a3) # fffffffffffff000 <end+0xffffffff7ffeb000>
    80002094:	00d9b023          	sd	a3,0(s3)
    80002098:	fb5ff06f          	j	8000204c <_ZN5Buddy8compressEm+0x50>
                head[size] = curr->next->next;
    8000209c:	0006b603          	ld	a2,0(a3)
    800020a0:	00391593          	slli	a1,s2,0x3
    800020a4:	00006697          	auipc	a3,0x6
    800020a8:	bd468693          	addi	a3,a3,-1068 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    800020ac:	00b686b3          	add	a3,a3,a1
    800020b0:	06c6bc23          	sd	a2,120(a3)
                if(!head[size])
    800020b4:	f8061ce3          	bnez	a2,8000204c <_ZN5Buddy8compressEm+0x50>
                    tail[size] = nullptr;
    800020b8:	00006697          	auipc	a3,0x6
    800020bc:	bc068693          	addi	a3,a3,-1088 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    800020c0:	00b686b3          	add	a3,a3,a1
    800020c4:	0006b823          	sd	zero,16(a3)
    800020c8:	f85ff06f          	j	8000204c <_ZN5Buddy8compressEm+0x50>
            blk->next = nullptr;
    800020cc:	0004b023          	sd	zero,0(s1)
            insert(blk, size+1);
    800020d0:	00190593          	addi	a1,s2,1
    800020d4:	00048513          	mv	a0,s1
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	02c080e7          	jalr	44(ra) # 80002104 <_ZN5Buddy6insertEPvm>
    800020e0:	f71ff06f          	j	80002050 <_ZN5Buddy8compressEm+0x54>
}
    800020e4:	02813083          	ld	ra,40(sp)
    800020e8:	02013403          	ld	s0,32(sp)
    800020ec:	01813483          	ld	s1,24(sp)
    800020f0:	01013903          	ld	s2,16(sp)
    800020f4:	00813983          	ld	s3,8(sp)
    800020f8:	03010113          	addi	sp,sp,48
    800020fc:	00008067          	ret
    80002100:	00008067          	ret

0000000080002104 <_ZN5Buddy6insertEPvm>:
void Buddy::insert(void *addr, uint64 size) {
    80002104:	00050693          	mv	a3,a0
    if(!head[size]){
    80002108:	00359713          	slli	a4,a1,0x3
    8000210c:	00006797          	auipc	a5,0x6
    80002110:	b6c78793          	addi	a5,a5,-1172 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002114:	00e787b3          	add	a5,a5,a4
    80002118:	0787b783          	ld	a5,120(a5)
    8000211c:	02078c63          	beqz	a5,80002154 <_ZN5Buddy6insertEPvm+0x50>
void Buddy::insert(void *addr, uint64 size) {
    80002120:	ff010113          	addi	sp,sp,-16
    80002124:	00113423          	sd	ra,8(sp)
    80002128:	00813023          	sd	s0,0(sp)
    8000212c:	01010413          	addi	s0,sp,16
    80002130:	00058513          	mv	a0,a1
        if ((uint64) addr < (uint64) head[size]) {
    80002134:	00068713          	mv	a4,a3
    80002138:	04f6e063          	bltu	a3,a5,80002178 <_ZN5Buddy6insertEPvm+0x74>
            Block *prev = nullptr, *iter = head[size];
    8000213c:	00000613          	li	a2,0
            while (iter != nullptr) {
    80002140:	06078863          	beqz	a5,800021b0 <_ZN5Buddy6insertEPvm+0xac>
                if ((uint64) addr < (uint64) iter) {
    80002144:	04f76c63          	bltu	a4,a5,8000219c <_ZN5Buddy6insertEPvm+0x98>
                    prev = iter;
    80002148:	00078613          	mv	a2,a5
                    iter = iter->next;
    8000214c:	0007b783          	ld	a5,0(a5)
            while (iter != nullptr) {
    80002150:	ff1ff06f          	j	80002140 <_ZN5Buddy6insertEPvm+0x3c>
        head[size] = tail[size] = (Block*)addr;
    80002154:	00006797          	auipc	a5,0x6
    80002158:	b2478793          	addi	a5,a5,-1244 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000215c:	00e78533          	add	a0,a5,a4
    80002160:	00d53823          	sd	a3,16(a0)
    80002164:	06d53c23          	sd	a3,120(a0)
        head[size]->next = tail[size]->next = nullptr;
    80002168:	0006b023          	sd	zero,0(a3)
    8000216c:	07853783          	ld	a5,120(a0)
    80002170:	0007b023          	sd	zero,0(a5)
        return;
    80002174:	00008067          	ret
            newHead->next = head[size];
    80002178:	00f6b023          	sd	a5,0(a3)
            head[size] = newHead;
    8000217c:	00359713          	slli	a4,a1,0x3
    80002180:	00006797          	auipc	a5,0x6
    80002184:	af878793          	addi	a5,a5,-1288 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002188:	00e787b3          	add	a5,a5,a4
    8000218c:	06d7bc23          	sd	a3,120(a5)
            compress(size);
    80002190:	00000097          	auipc	ra,0x0
    80002194:	e6c080e7          	jalr	-404(ra) # 80001ffc <_ZN5Buddy8compressEm>
            return;
    80002198:	0440006f          	j	800021dc <_ZN5Buddy6insertEPvm+0xd8>
                    newBlock->next = iter;
    8000219c:	00f6b023          	sd	a5,0(a3)
                    prev->next = newBlock;
    800021a0:	00d63023          	sd	a3,0(a2)
                    compress(size);
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	e58080e7          	jalr	-424(ra) # 80001ffc <_ZN5Buddy8compressEm>
                    return;
    800021ac:	0300006f          	j	800021dc <_ZN5Buddy6insertEPvm+0xd8>
    tail[size]->next = (Block*)addr;
    800021b0:	00351713          	slli	a4,a0,0x3
    800021b4:	00006797          	auipc	a5,0x6
    800021b8:	ac478793          	addi	a5,a5,-1340 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    800021bc:	00e787b3          	add	a5,a5,a4
    800021c0:	0107b703          	ld	a4,16(a5)
    800021c4:	00d73023          	sd	a3,0(a4)
    tail[size] = tail[size]->next;
    800021c8:	0107b703          	ld	a4,16(a5)
    800021cc:	00073703          	ld	a4,0(a4)
    800021d0:	00e7b823          	sd	a4,16(a5)
    compress(size);
    800021d4:	00000097          	auipc	ra,0x0
    800021d8:	e28080e7          	jalr	-472(ra) # 80001ffc <_ZN5Buddy8compressEm>
}
    800021dc:	00813083          	ld	ra,8(sp)
    800021e0:	00013403          	ld	s0,0(sp)
    800021e4:	01010113          	addi	sp,sp,16
    800021e8:	00008067          	ret

00000000800021ec <_ZN5Buddy4freeEPvm>:
    if(addr == nullptr)
    800021ec:	02050663          	beqz	a0,80002218 <_ZN5Buddy4freeEPvm+0x2c>
void Buddy::free(void *addr, uint64 size) {
    800021f0:	ff010113          	addi	sp,sp,-16
    800021f4:	00113423          	sd	ra,8(sp)
    800021f8:	00813023          	sd	s0,0(sp)
    800021fc:	01010413          	addi	s0,sp,16
    insert(addr,size);
    80002200:	00000097          	auipc	ra,0x0
    80002204:	f04080e7          	jalr	-252(ra) # 80002104 <_ZN5Buddy6insertEPvm>
}
    80002208:	00813083          	ld	ra,8(sp)
    8000220c:	00013403          	ld	s0,0(sp)
    80002210:	01010113          	addi	sp,sp,16
    80002214:	00008067          	ret
    80002218:	00008067          	ret

000000008000221c <_ZN5Buddy5splitEPNS_5BlockEii>:
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    8000221c:	ff010113          	addi	sp,sp,-16
    80002220:	00813423          	sd	s0,8(sp)
    80002224:	01010413          	addi	s0,sp,16
    80002228:	03c0006f          	j	80002264 <_ZN5Buddy5splitEPNS_5BlockEii+0x48>
            head[currentBucket] = tail[currentBucket] = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    8000222c:	00b5859b          	addiw	a1,a1,11
    80002230:	00100713          	li	a4,1
    80002234:	00b715bb          	sllw	a1,a4,a1
    80002238:	00b505b3          	add	a1,a0,a1
    8000223c:	00379693          	slli	a3,a5,0x3
    80002240:	00006717          	auipc	a4,0x6
    80002244:	a3870713          	addi	a4,a4,-1480 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002248:	00d70733          	add	a4,a4,a3
    8000224c:	00b73823          	sd	a1,16(a4)
    80002250:	06b73c23          	sd	a1,120(a4)
            head[currentBucket]->next = tail[currentBucket]->next = nullptr;
    80002254:	0005b023          	sd	zero,0(a1)
    80002258:	07873703          	ld	a4,120(a4)
    8000225c:	00073023          	sd	zero,0(a4)
void Buddy::split(Block *block, int currentBucket, int startBucket) {
    80002260:	00078593          	mv	a1,a5
    while(--currentBucket>=startBucket){
    80002264:	fff5879b          	addiw	a5,a1,-1
    80002268:	04c7c863          	blt	a5,a2,800022b8 <_ZN5Buddy5splitEPNS_5BlockEii+0x9c>
        if(tail[currentBucket]) {
    8000226c:	00379693          	slli	a3,a5,0x3
    80002270:	00006717          	auipc	a4,0x6
    80002274:	a0870713          	addi	a4,a4,-1528 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002278:	00d70733          	add	a4,a4,a3
    8000227c:	01073683          	ld	a3,16(a4)
    80002280:	fa0686e3          	beqz	a3,8000222c <_ZN5Buddy5splitEPNS_5BlockEii+0x10>
            tail[currentBucket]->next = (Block *) ((uint64) block + (1 << (currentBucket + BUDDY_BLOCK_BITS)));
    80002284:	00b5859b          	addiw	a1,a1,11
    80002288:	00100713          	li	a4,1
    8000228c:	00b715bb          	sllw	a1,a4,a1
    80002290:	00b505b3          	add	a1,a0,a1
    80002294:	00b6b023          	sd	a1,0(a3)
            tail[currentBucket] = tail[currentBucket]->next;
    80002298:	00379693          	slli	a3,a5,0x3
    8000229c:	00006717          	auipc	a4,0x6
    800022a0:	9dc70713          	addi	a4,a4,-1572 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022a4:	00d70733          	add	a4,a4,a3
    800022a8:	01073683          	ld	a3,16(a4)
    800022ac:	0006b683          	ld	a3,0(a3)
    800022b0:	00d73823          	sd	a3,16(a4)
    800022b4:	fadff06f          	j	80002260 <_ZN5Buddy5splitEPNS_5BlockEii+0x44>
}
    800022b8:	00813403          	ld	s0,8(sp)
    800022bc:	01010113          	addi	sp,sp,16
    800022c0:	00008067          	ret

00000000800022c4 <_ZN5Buddy5allocEm>:
void* Buddy::alloc(uint64 size) {
    800022c4:	fe010113          	addi	sp,sp,-32
    800022c8:	00113c23          	sd	ra,24(sp)
    800022cc:	00813823          	sd	s0,16(sp)
    800022d0:	00913423          	sd	s1,8(sp)
    800022d4:	02010413          	addi	s0,sp,32
    if(size<0 || size>=BUCKET_SIZE)
    800022d8:	00c00793          	li	a5,12
    800022dc:	06a7ec63          	bltu	a5,a0,80002354 <_ZN5Buddy5allocEm+0x90>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    800022e0:	00050593          	mv	a1,a0
    800022e4:	00c00793          	li	a5,12
    800022e8:	06b7ea63          	bltu	a5,a1,8000235c <_ZN5Buddy5allocEm+0x98>
        if(head[i] != nullptr){
    800022ec:	00359713          	slli	a4,a1,0x3
    800022f0:	00006797          	auipc	a5,0x6
    800022f4:	98878793          	addi	a5,a5,-1656 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    800022f8:	00e787b3          	add	a5,a5,a4
    800022fc:	0787b483          	ld	s1,120(a5)
    80002300:	00049663          	bnez	s1,8000230c <_ZN5Buddy5allocEm+0x48>
    for(uint64 i=size;i<BUCKET_SIZE;i++){
    80002304:	00158593          	addi	a1,a1,1
    80002308:	fddff06f          	j	800022e4 <_ZN5Buddy5allocEm+0x20>
            head[i] = head[i]->next;
    8000230c:	0004b703          	ld	a4,0(s1)
    80002310:	00359693          	slli	a3,a1,0x3
    80002314:	00006797          	auipc	a5,0x6
    80002318:	96478793          	addi	a5,a5,-1692 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    8000231c:	00d787b3          	add	a5,a5,a3
    80002320:	06e7bc23          	sd	a4,120(a5)
            if(!head[i])
    80002324:	00070e63          	beqz	a4,80002340 <_ZN5Buddy5allocEm+0x7c>
            split(blk, i, size);
    80002328:	0005061b          	sext.w	a2,a0
    8000232c:	0005859b          	sext.w	a1,a1
    80002330:	00048513          	mv	a0,s1
    80002334:	00000097          	auipc	ra,0x0
    80002338:	ee8080e7          	jalr	-280(ra) # 8000221c <_ZN5Buddy5splitEPNS_5BlockEii>
            break;
    8000233c:	0240006f          	j	80002360 <_ZN5Buddy5allocEm+0x9c>
                tail[i] = nullptr;
    80002340:	00006797          	auipc	a5,0x6
    80002344:	93878793          	addi	a5,a5,-1736 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    80002348:	00d787b3          	add	a5,a5,a3
    8000234c:	0007b823          	sd	zero,16(a5)
    80002350:	fd9ff06f          	j	80002328 <_ZN5Buddy5allocEm+0x64>
        return nullptr;
    80002354:	00000493          	li	s1,0
    80002358:	0080006f          	j	80002360 <_ZN5Buddy5allocEm+0x9c>
    Block* blk = nullptr;
    8000235c:	00000493          	li	s1,0
}
    80002360:	00048513          	mv	a0,s1
    80002364:	01813083          	ld	ra,24(sp)
    80002368:	01013403          	ld	s0,16(sp)
    8000236c:	00813483          	ld	s1,8(sp)
    80002370:	02010113          	addi	sp,sp,32
    80002374:	00008067          	ret

0000000080002378 <_ZN5Buddy9printListEv>:
void Buddy::printList() {
    80002378:	fe010113          	addi	sp,sp,-32
    8000237c:	00113c23          	sd	ra,24(sp)
    80002380:	00813823          	sd	s0,16(sp)
    80002384:	00913423          	sd	s1,8(sp)
    80002388:	01213023          	sd	s2,0(sp)
    8000238c:	02010413          	addi	s0,sp,32
    for(int i=0;i<BUCKET_SIZE;i++){
    80002390:	00000913          	li	s2,0
    80002394:	0180006f          	j	800023ac <_ZN5Buddy9printListEv+0x34>
        ConsoleUtil::printString("\n");
    80002398:	00005517          	auipc	a0,0x5
    8000239c:	fb850513          	addi	a0,a0,-72 # 80007350 <CONSOLE_STATUS+0x340>
    800023a0:	00002097          	auipc	ra,0x2
    800023a4:	50c080e7          	jalr	1292(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    for(int i=0;i<BUCKET_SIZE;i++){
    800023a8:	0019091b          	addiw	s2,s2,1
    800023ac:	00c00793          	li	a5,12
    800023b0:	0727c663          	blt	a5,s2,8000241c <_ZN5Buddy9printListEv+0xa4>
        ConsoleUtil::printInt(i,10);
    800023b4:	00000613          	li	a2,0
    800023b8:	00a00593          	li	a1,10
    800023bc:	00090513          	mv	a0,s2
    800023c0:	00002097          	auipc	ra,0x2
    800023c4:	530080e7          	jalr	1328(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString(": ");
    800023c8:	00005517          	auipc	a0,0x5
    800023cc:	ee050513          	addi	a0,a0,-288 # 800072a8 <CONSOLE_STATUS+0x298>
    800023d0:	00002097          	auipc	ra,0x2
    800023d4:	4dc080e7          	jalr	1244(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        Bucket *tmp = head[i];
    800023d8:	00391713          	slli	a4,s2,0x3
    800023dc:	00006797          	auipc	a5,0x6
    800023e0:	89c78793          	addi	a5,a5,-1892 # 80007c78 <_ZN5Buddy16BUDDY_START_ADDRE>
    800023e4:	00e787b3          	add	a5,a5,a4
    800023e8:	0787b483          	ld	s1,120(a5)
        while(tmp != nullptr){
    800023ec:	fa0486e3          	beqz	s1,80002398 <_ZN5Buddy9printListEv+0x20>
            ConsoleUtil::printInt((uint64)tmp,16);
    800023f0:	00000613          	li	a2,0
    800023f4:	01000593          	li	a1,16
    800023f8:	0004851b          	sext.w	a0,s1
    800023fc:	00002097          	auipc	ra,0x2
    80002400:	4f4080e7          	jalr	1268(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
            ConsoleUtil::printString(" ");
    80002404:	00005517          	auipc	a0,0x5
    80002408:	ce450513          	addi	a0,a0,-796 # 800070e8 <CONSOLE_STATUS+0xd8>
    8000240c:	00002097          	auipc	ra,0x2
    80002410:	4a0080e7          	jalr	1184(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
            tmp = tmp->next;
    80002414:	0004b483          	ld	s1,0(s1)
        while(tmp != nullptr){
    80002418:	fd5ff06f          	j	800023ec <_ZN5Buddy9printListEv+0x74>
    8000241c:	01813083          	ld	ra,24(sp)
    80002420:	01013403          	ld	s0,16(sp)
    80002424:	00813483          	ld	s1,8(sp)
    80002428:	00013903          	ld	s2,0(sp)
    8000242c:	02010113          	addi	sp,sp,32
    80002430:	00008067          	ret

0000000080002434 <_GLOBAL__sub_I__ZN5Buddy16BUDDY_START_ADDRE>:
    80002434:	ff010113          	addi	sp,sp,-16
    80002438:	00113423          	sd	ra,8(sp)
    8000243c:	00813023          	sd	s0,0(sp)
    80002440:	01010413          	addi	s0,sp,16
    80002444:	000105b7          	lui	a1,0x10
    80002448:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000244c:	00100513          	li	a0,1
    80002450:	00000097          	auipc	ra,0x0
    80002454:	a44080e7          	jalr	-1468(ra) # 80001e94 <_Z41__static_initialization_and_destruction_0ii>
    80002458:	00813083          	ld	ra,8(sp)
    8000245c:	00013403          	ld	s0,0(sp)
    80002460:	01010113          	addi	sp,sp,16
    80002464:	00008067          	ret

0000000080002468 <_ZN3SCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void SCB::ctor(void* scb){
    80002468:	ff010113          	addi	sp,sp,-16
    8000246c:	00813423          	sd	s0,8(sp)
    80002470:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002474:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002478:	00053823          	sd	zero,16(a0)
}
    8000247c:	00813403          	ld	s0,8(sp)
    80002480:	01010113          	addi	sp,sp,16
    80002484:	00008067          	ret

0000000080002488 <_ZN3SCB4dtorEPv>:

void SCB::dtor(void* scb){
    80002488:	ff010113          	addi	sp,sp,-16
    8000248c:	00813423          	sd	s0,8(sp)
    80002490:	01010413          	addi	s0,sp,16
    ((SCB*)scb)->blockedHead = nullptr;
    80002494:	00053423          	sd	zero,8(a0)
    ((SCB*)scb)->blockedTail = nullptr;
    80002498:	00053823          	sd	zero,16(a0)
    8000249c:	00813403          	ld	s0,8(sp)
    800024a0:	01010113          	addi	sp,sp,16
    800024a4:	00008067          	ret

00000000800024a8 <_ZN3SCB10initializeEv>:
void SCB::initialize() {
    800024a8:	ff010113          	addi	sp,sp,-16
    800024ac:	00113423          	sd	ra,8(sp)
    800024b0:	00813023          	sd	s0,0(sp)
    800024b4:	01010413          	addi	s0,sp,16
    SCB::scbCache = kmem_cache_create("SCB Cache", sizeof(SCB), SCB::ctor, SCB::dtor);
    800024b8:	00000697          	auipc	a3,0x0
    800024bc:	fd068693          	addi	a3,a3,-48 # 80002488 <_ZN3SCB4dtorEPv>
    800024c0:	00000617          	auipc	a2,0x0
    800024c4:	fa860613          	addi	a2,a2,-88 # 80002468 <_ZN3SCB4ctorEPv>
    800024c8:	01800593          	li	a1,24
    800024cc:	00005517          	auipc	a0,0x5
    800024d0:	de450513          	addi	a0,a0,-540 # 800072b0 <CONSOLE_STATUS+0x2a0>
    800024d4:	00002097          	auipc	ra,0x2
    800024d8:	5b4080e7          	jalr	1460(ra) # 80004a88 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800024dc:	00006797          	auipc	a5,0x6
    800024e0:	86a7be23          	sd	a0,-1924(a5) # 80007d58 <_ZN3SCB8scbCacheE>
}
    800024e4:	00813083          	ld	ra,8(sp)
    800024e8:	00013403          	ld	s0,0(sp)
    800024ec:	01010113          	addi	sp,sp,16
    800024f0:	00008067          	ret

00000000800024f4 <_ZN3SCBC1Em>:
SCB::SCB(uint64 init){
    800024f4:	ff010113          	addi	sp,sp,-16
    800024f8:	00813423          	sd	s0,8(sp)
    800024fc:	01010413          	addi	s0,sp,16
    val = init;
    80002500:	00b52023          	sw	a1,0(a0)
}
    80002504:	00813403          	ld	s0,8(sp)
    80002508:	01010113          	addi	sp,sp,16
    8000250c:	00008067          	ret

0000000080002510 <_ZN3SCBD1Ev>:
SCB::~SCB(){
    80002510:	fe010113          	addi	sp,sp,-32
    80002514:	00113c23          	sd	ra,24(sp)
    80002518:	00813823          	sd	s0,16(sp)
    8000251c:	00913423          	sd	s1,8(sp)
    80002520:	01213023          	sd	s2,0(sp)
    80002524:	02010413          	addi	s0,sp,32
    80002528:	00050913          	mv	s2,a0
    TCB* iter = blockedHead;
    8000252c:	00853503          	ld	a0,8(a0)
    while(iter !=nullptr) {
    80002530:	02050063          	beqz	a0,80002550 <_ZN3SCBD1Ev+0x40>
        iter = iter->next;
    80002534:	04853483          	ld	s1,72(a0)
        tmp->next = 0;
    80002538:	04053423          	sd	zero,72(a0)
        tmp->semError = this;
    8000253c:	07253023          	sd	s2,96(a0)
        Scheduler::put(tmp);
    80002540:	00002097          	auipc	ra,0x2
    80002544:	ed8080e7          	jalr	-296(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
        iter = iter->next;
    80002548:	00048513          	mv	a0,s1
    while(iter !=nullptr) {
    8000254c:	fe5ff06f          	j	80002530 <_ZN3SCBD1Ev+0x20>
}
    80002550:	01813083          	ld	ra,24(sp)
    80002554:	01013403          	ld	s0,16(sp)
    80002558:	00813483          	ld	s1,8(sp)
    8000255c:	00013903          	ld	s2,0(sp)
    80002560:	02010113          	addi	sp,sp,32
    80002564:	00008067          	ret

0000000080002568 <_ZN3SCB5blockEv>:
void SCB::block() {
    80002568:	ff010113          	addi	sp,sp,-16
    8000256c:	00113423          	sd	ra,8(sp)
    80002570:	00813023          	sd	s0,0(sp)
    80002574:	01010413          	addi	s0,sp,16
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    80002578:	00853783          	ld	a5,8(a0)
    8000257c:	04078063          	beqz	a5,800025bc <_ZN3SCB5blockEv+0x54>
    80002580:	01053703          	ld	a4,16(a0)
    80002584:	00005797          	auipc	a5,0x5
    80002588:	5ec7b783          	ld	a5,1516(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000258c:	0007b783          	ld	a5,0(a5)
    80002590:	04f73423          	sd	a5,72(a4)
    80002594:	00f53823          	sd	a5,16(a0)
    TCB::running->next = nullptr;
    80002598:	0407b423          	sd	zero,72(a5)
    TCB::running->status = TCB::BLOCKED;
    8000259c:	00300713          	li	a4,3
    800025a0:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    800025a4:	00000097          	auipc	ra,0x0
    800025a8:	314080e7          	jalr	788(ra) # 800028b8 <_ZN3TCB8dispatchEv>
}
    800025ac:	00813083          	ld	ra,8(sp)
    800025b0:	00013403          	ld	s0,0(sp)
    800025b4:	01010113          	addi	sp,sp,16
    800025b8:	00008067          	ret
    blockedTail = (!blockedHead ? blockedHead : blockedTail->next) = TCB::running;
    800025bc:	00005797          	auipc	a5,0x5
    800025c0:	5b47b783          	ld	a5,1460(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800025c4:	0007b783          	ld	a5,0(a5)
    800025c8:	00f53423          	sd	a5,8(a0)
    800025cc:	fc9ff06f          	j	80002594 <_ZN3SCB5blockEv+0x2c>

00000000800025d0 <_ZN3SCB7deblockEv>:
void SCB::deblock(){
    800025d0:	00050793          	mv	a5,a0
    TCB* tcb = blockedHead;
    800025d4:	00853503          	ld	a0,8(a0)
    blockedHead = blockedHead->next;
    800025d8:	04853703          	ld	a4,72(a0)
    800025dc:	00e7b423          	sd	a4,8(a5)
    tcb->next = nullptr;
    800025e0:	04053423          	sd	zero,72(a0)
    if(tcb) {
    800025e4:	02050a63          	beqz	a0,80002618 <_ZN3SCB7deblockEv+0x48>
void SCB::deblock(){
    800025e8:	ff010113          	addi	sp,sp,-16
    800025ec:	00113423          	sd	ra,8(sp)
    800025f0:	00813023          	sd	s0,0(sp)
    800025f4:	01010413          	addi	s0,sp,16
        tcb->status = TCB::READY;
    800025f8:	00100793          	li	a5,1
    800025fc:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80002600:	00002097          	auipc	ra,0x2
    80002604:	e18080e7          	jalr	-488(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
}
    80002608:	00813083          	ld	ra,8(sp)
    8000260c:	00013403          	ld	s0,0(sp)
    80002610:	01010113          	addi	sp,sp,16
    80002614:	00008067          	ret
    80002618:	00008067          	ret

000000008000261c <_ZN3SCB4waitEv>:
    TCB::running->semError = nullptr;
    8000261c:	00005797          	auipc	a5,0x5
    80002620:	5547b783          	ld	a5,1364(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80002624:	0007b783          	ld	a5,0(a5)
    80002628:	0607b023          	sd	zero,96(a5)
    if (--val < 0)
    8000262c:	00052783          	lw	a5,0(a0)
    80002630:	fff7879b          	addiw	a5,a5,-1
    80002634:	00f52023          	sw	a5,0(a0)
    80002638:	02079713          	slli	a4,a5,0x20
    8000263c:	00074463          	bltz	a4,80002644 <_ZN3SCB4waitEv+0x28>
    80002640:	00008067          	ret
void SCB::wait() {
    80002644:	ff010113          	addi	sp,sp,-16
    80002648:	00113423          	sd	ra,8(sp)
    8000264c:	00813023          	sd	s0,0(sp)
    80002650:	01010413          	addi	s0,sp,16
        block();
    80002654:	00000097          	auipc	ra,0x0
    80002658:	f14080e7          	jalr	-236(ra) # 80002568 <_ZN3SCB5blockEv>
}
    8000265c:	00813083          	ld	ra,8(sp)
    80002660:	00013403          	ld	s0,0(sp)
    80002664:	01010113          	addi	sp,sp,16
    80002668:	00008067          	ret

000000008000266c <_ZN3SCB6signalEv>:
    if(val++<0)
    8000266c:	00052783          	lw	a5,0(a0)
    80002670:	0017871b          	addiw	a4,a5,1
    80002674:	00e52023          	sw	a4,0(a0)
    80002678:	0007c463          	bltz	a5,80002680 <_ZN3SCB6signalEv+0x14>
    8000267c:	00008067          	ret
void SCB::signal(){
    80002680:	ff010113          	addi	sp,sp,-16
    80002684:	00113423          	sd	ra,8(sp)
    80002688:	00813023          	sd	s0,0(sp)
    8000268c:	01010413          	addi	s0,sp,16
        deblock();
    80002690:	00000097          	auipc	ra,0x0
    80002694:	f40080e7          	jalr	-192(ra) # 800025d0 <_ZN3SCB7deblockEv>
}
    80002698:	00813083          	ld	ra,8(sp)
    8000269c:	00013403          	ld	s0,0(sp)
    800026a0:	01010113          	addi	sp,sp,16
    800026a4:	00008067          	ret

00000000800026a8 <_ZN3SCBnwEm>:
void* SCB::operator new(size_t size){
    800026a8:	ff010113          	addi	sp,sp,-16
    800026ac:	00113423          	sd	ra,8(sp)
    800026b0:	00813023          	sd	s0,0(sp)
    800026b4:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(SCB::scbCache);
    800026b8:	00005517          	auipc	a0,0x5
    800026bc:	6a053503          	ld	a0,1696(a0) # 80007d58 <_ZN3SCB8scbCacheE>
    800026c0:	00002097          	auipc	ra,0x2
    800026c4:	3f0080e7          	jalr	1008(ra) # 80004ab0 <_Z16kmem_cache_allocP5Cache>
}
    800026c8:	00813083          	ld	ra,8(sp)
    800026cc:	00013403          	ld	s0,0(sp)
    800026d0:	01010113          	addi	sp,sp,16
    800026d4:	00008067          	ret

00000000800026d8 <_ZN3SCBdlEPv>:
void SCB::operator delete(void *addr){
    800026d8:	ff010113          	addi	sp,sp,-16
    800026dc:	00113423          	sd	ra,8(sp)
    800026e0:	00813023          	sd	s0,0(sp)
    800026e4:	01010413          	addi	s0,sp,16
    800026e8:	00050593          	mv	a1,a0
    kmem_cache_free(SCB::scbCache, addr);
    800026ec:	00005517          	auipc	a0,0x5
    800026f0:	66c53503          	ld	a0,1644(a0) # 80007d58 <_ZN3SCB8scbCacheE>
    800026f4:	00002097          	auipc	ra,0x2
    800026f8:	3e4080e7          	jalr	996(ra) # 80004ad8 <_Z15kmem_cache_freeP5CachePv>
}
    800026fc:	00813083          	ld	ra,8(sp)
    80002700:	00013403          	ld	s0,0(sp)
    80002704:	01010113          	addi	sp,sp,16
    80002708:	00008067          	ret

000000008000270c <_ZN3SCB14semaphore_freeEPv>:
int SCB::semaphore_free(void *addr) {
    8000270c:	ff010113          	addi	sp,sp,-16
    80002710:	00813423          	sd	s0,8(sp)
    80002714:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));  //put address in a1
    80002718:	00050593          	mv	a1,a0
    asm("li a0, 0x52");  //put number of syscall in a0
    8000271c:	05200513          	li	a0,82
    asm("ecall");
    80002720:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002724:	00050513          	mv	a0,a0
}
    80002728:	0005051b          	sext.w	a0,a0
    8000272c:	00813403          	ld	s0,8(sp)
    80002730:	01010113          	addi	sp,sp,16
    80002734:	00008067          	ret

0000000080002738 <main>:
//
// Created by os on 4/28/22.
//
#include "../../h/system.hpp"

int main() {
    80002738:	fe010113          	addi	sp,sp,-32
    8000273c:	00113c23          	sd	ra,24(sp)
    80002740:	00813823          	sd	s0,16(sp)
    80002744:	02010413          	addi	s0,sp,32

    //entry point for user code
    System();
    80002748:	fe840513          	addi	a0,s0,-24
    8000274c:	fffff097          	auipc	ra,0xfffff
    80002750:	6b0080e7          	jalr	1712(ra) # 80001dfc <_ZN6SystemC1Ev>

    return 0;
    80002754:	00000513          	li	a0,0
    80002758:	01813083          	ld	ra,24(sp)
    8000275c:	01013403          	ld	s0,16(sp)
    80002760:	02010113          	addi	sp,sp,32
    80002764:	00008067          	ret

0000000080002768 <_ZN3TCB4ctorEPv>:

    asm("mv %[status], a0" : [status] "=r" (status));
    return status;
}

void TCB::ctor(void* tcb){
    80002768:	ff010113          	addi	sp,sp,-16
    8000276c:	00813423          	sd	s0,8(sp)
    80002770:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    80002774:	00100793          	li	a5,1
    80002778:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    8000277c:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    80002780:	00052a23          	sw	zero,20(a0)
}
    80002784:	00813403          	ld	s0,8(sp)
    80002788:	01010113          	addi	sp,sp,16
    8000278c:	00008067          	ret

0000000080002790 <_ZN3TCB4dtorEPv>:

void TCB::dtor(void* tcb){
    80002790:	ff010113          	addi	sp,sp,-16
    80002794:	00813423          	sd	s0,8(sp)
    80002798:	01010413          	addi	s0,sp,16
    ((TCB*)tcb)->status = Status::READY;
    8000279c:	00100793          	li	a5,1
    800027a0:	00f52823          	sw	a5,16(a0)

    ((TCB*)tcb)->next = nullptr;
    800027a4:	04053423          	sd	zero,72(a0)

    ((TCB*)tcb)->mode = Mode::USER;
    800027a8:	00052a23          	sw	zero,20(a0)
    800027ac:	00813403          	ld	s0,8(sp)
    800027b0:	01010113          	addi	sp,sp,16
    800027b4:	00008067          	ret

00000000800027b8 <_ZN3TCB7wrapperEPv>:
void TCB::wrapper(void *args) {
    800027b8:	ff010113          	addi	sp,sp,-16
    800027bc:	00113423          	sd	ra,8(sp)
    800027c0:	00813023          	sd	s0,0(sp)
    800027c4:	01010413          	addi	s0,sp,16
    RiscV::popSppSpie();
    800027c8:	00001097          	auipc	ra,0x1
    800027cc:	bac080e7          	jalr	-1108(ra) # 80003374 <_ZN5RiscV10popSppSpieEv>
    running->body(running->args);
    800027d0:	00005797          	auipc	a5,0x5
    800027d4:	5907b783          	ld	a5,1424(a5) # 80007d60 <_ZN3TCB7runningE>
    800027d8:	0187b703          	ld	a4,24(a5)
    800027dc:	0207b503          	ld	a0,32(a5)
    800027e0:	000700e7          	jalr	a4
    RiscV::threadExitUtil();
    800027e4:	00002097          	auipc	ra,0x2
    800027e8:	ac8080e7          	jalr	-1336(ra) # 800042ac <_ZN5RiscV14threadExitUtilEv>
}
    800027ec:	00813083          	ld	ra,8(sp)
    800027f0:	00013403          	ld	s0,0(sp)
    800027f4:	01010113          	addi	sp,sp,16
    800027f8:	00008067          	ret

00000000800027fc <_ZN3TCBC1EPFvPvES0_Pmm>:
TCB::TCB(Body body, void* args, uint64* stack, uint64 timeSlice){
    800027fc:	ff010113          	addi	sp,sp,-16
    80002800:	00813423          	sd	s0,8(sp)
    80002804:	01010413          	addi	s0,sp,16
    80002808:	04053823          	sd	zero,80(a0)
    8000280c:	04053c23          	sd	zero,88(a0)
    80002810:	06053023          	sd	zero,96(a0)
    this->body = body;
    80002814:	00b53c23          	sd	a1,24(a0)
    this->args = args;
    80002818:	02c53023          	sd	a2,32(a0)
    this->timeSlice = timeSlice;
    8000281c:	02e53823          	sd	a4,48(a0)
    this->stack = (body == nullptr) ? nullptr : stack;
    80002820:	02058a63          	beqz	a1,80002854 <_ZN3TCBC1EPFvPvES0_Pmm+0x58>
    80002824:	00068793          	mv	a5,a3
    80002828:	02f53423          	sd	a5,40(a0)
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    8000282c:	02058863          	beqz	a1,8000285c <_ZN3TCBC1EPFvPvES0_Pmm+0x60>
    80002830:	000017b7          	lui	a5,0x1
    80002834:	00f686b3          	add	a3,a3,a5
    80002838:	00d53023          	sd	a3,0(a0)
    8000283c:	00000797          	auipc	a5,0x0
    80002840:	f7c78793          	addi	a5,a5,-132 # 800027b8 <_ZN3TCB7wrapperEPv>
    80002844:	00f53423          	sd	a5,8(a0)
}
    80002848:	00813403          	ld	s0,8(sp)
    8000284c:	01010113          	addi	sp,sp,16
    80002850:	00008067          	ret
    this->stack = (body == nullptr) ? nullptr : stack;
    80002854:	00000793          	li	a5,0
    80002858:	fd1ff06f          	j	80002828 <_ZN3TCBC1EPFvPvES0_Pmm+0x2c>
    this->context = {(body == nullptr) ? 0 : (uint64)((char*)stack + DEFAULT_STACK_SIZE),
    8000285c:	00000693          	li	a3,0
    80002860:	fd9ff06f          	j	80002838 <_ZN3TCBC1EPFvPvES0_Pmm+0x3c>

0000000080002864 <_ZN3TCB4freeEv>:
void TCB::free(){
    80002864:	ff010113          	addi	sp,sp,-16
    80002868:	00113423          	sd	ra,8(sp)
    8000286c:	00813023          	sd	s0,0(sp)
    80002870:	01010413          	addi	s0,sp,16
    kfree(stack);
    80002874:	02853503          	ld	a0,40(a0)
    80002878:	00002097          	auipc	ra,0x2
    8000287c:	330080e7          	jalr	816(ra) # 80004ba8 <_Z5kfreePKv>
}
    80002880:	00813083          	ld	ra,8(sp)
    80002884:	00013403          	ld	s0,0(sp)
    80002888:	01010113          	addi	sp,sp,16
    8000288c:	00008067          	ret

0000000080002890 <_ZN3TCBD1Ev>:
TCB::~TCB(){
    80002890:	ff010113          	addi	sp,sp,-16
    80002894:	00113423          	sd	ra,8(sp)
    80002898:	00813023          	sd	s0,0(sp)
    8000289c:	01010413          	addi	s0,sp,16
    free();
    800028a0:	00000097          	auipc	ra,0x0
    800028a4:	fc4080e7          	jalr	-60(ra) # 80002864 <_ZN3TCB4freeEv>
}
    800028a8:	00813083          	ld	ra,8(sp)
    800028ac:	00013403          	ld	s0,0(sp)
    800028b0:	01010113          	addi	sp,sp,16
    800028b4:	00008067          	ret

00000000800028b8 <_ZN3TCB8dispatchEv>:
void TCB::dispatch() {
    800028b8:	fe010113          	addi	sp,sp,-32
    800028bc:	00113c23          	sd	ra,24(sp)
    800028c0:	00813823          	sd	s0,16(sp)
    800028c4:	00913423          	sd	s1,8(sp)
    800028c8:	02010413          	addi	s0,sp,32
    TCB* old = running;
    800028cc:	00005497          	auipc	s1,0x5
    800028d0:	4944b483          	ld	s1,1172(s1) # 80007d60 <_ZN3TCB7runningE>
    if(old->status == Status::READY || old->status == Status::RUNNING) {
    800028d4:	0104a703          	lw	a4,16(s1)
    800028d8:	00100793          	li	a5,1
    800028dc:	04e7f663          	bgeu	a5,a4,80002928 <_ZN3TCB8dispatchEv+0x70>
    running = Scheduler::get();
    800028e0:	00002097          	auipc	ra,0x2
    800028e4:	b80080e7          	jalr	-1152(ra) # 80004460 <_ZN9Scheduler3getEv>
    800028e8:	00005797          	auipc	a5,0x5
    800028ec:	46a7bc23          	sd	a0,1144(a5) # 80007d60 <_ZN3TCB7runningE>
    if(running) {
    800028f0:	02050263          	beqz	a0,80002914 <_ZN3TCB8dispatchEv+0x5c>
        running->status = Status::RUNNING;
    800028f4:	00052823          	sw	zero,16(a0)
        RiscV::jumpToDesignatedPrivilegeMode();
    800028f8:	00001097          	auipc	ra,0x1
    800028fc:	ba8080e7          	jalr	-1112(ra) # 800034a0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
        contextSwitch(&old->context, &running->context);
    80002900:	00005597          	auipc	a1,0x5
    80002904:	4605b583          	ld	a1,1120(a1) # 80007d60 <_ZN3TCB7runningE>
    80002908:	00048513          	mv	a0,s1
    8000290c:	fffff097          	auipc	ra,0xfffff
    80002910:	814080e7          	jalr	-2028(ra) # 80001120 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
}
    80002914:	01813083          	ld	ra,24(sp)
    80002918:	01013403          	ld	s0,16(sp)
    8000291c:	00813483          	ld	s1,8(sp)
    80002920:	02010113          	addi	sp,sp,32
    80002924:	00008067          	ret
        Scheduler::put(old);
    80002928:	00048513          	mv	a0,s1
    8000292c:	00002097          	auipc	ra,0x2
    80002930:	aec080e7          	jalr	-1300(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
    80002934:	fadff06f          	j	800028e0 <_ZN3TCB8dispatchEv+0x28>

0000000080002938 <_ZN3TCBnwEm>:
void* TCB::operator new(size_t size){
    80002938:	ff010113          	addi	sp,sp,-16
    8000293c:	00113423          	sd	ra,8(sp)
    80002940:	00813023          	sd	s0,0(sp)
    80002944:	01010413          	addi	s0,sp,16
    return kmem_cache_alloc(TCB::tcbCache);
    80002948:	00005517          	auipc	a0,0x5
    8000294c:	42053503          	ld	a0,1056(a0) # 80007d68 <_ZN3TCB8tcbCacheE>
    80002950:	00002097          	auipc	ra,0x2
    80002954:	160080e7          	jalr	352(ra) # 80004ab0 <_Z16kmem_cache_allocP5Cache>
}
    80002958:	00813083          	ld	ra,8(sp)
    8000295c:	00013403          	ld	s0,0(sp)
    80002960:	01010113          	addi	sp,sp,16
    80002964:	00008067          	ret

0000000080002968 <_ZN3TCB10initializeEv>:
void TCB::initialize() {
    80002968:	fe010113          	addi	sp,sp,-32
    8000296c:	00113c23          	sd	ra,24(sp)
    80002970:	00813823          	sd	s0,16(sp)
    80002974:	00913423          	sd	s1,8(sp)
    80002978:	01213023          	sd	s2,0(sp)
    8000297c:	02010413          	addi	s0,sp,32
    TCB::tcbCache = kmem_cache_create("TCB Cache", sizeof(TCB), TCB::ctor, TCB::dtor);
    80002980:	00000697          	auipc	a3,0x0
    80002984:	e1068693          	addi	a3,a3,-496 # 80002790 <_ZN3TCB4dtorEPv>
    80002988:	00000617          	auipc	a2,0x0
    8000298c:	de060613          	addi	a2,a2,-544 # 80002768 <_ZN3TCB4ctorEPv>
    80002990:	07000593          	li	a1,112
    80002994:	00005517          	auipc	a0,0x5
    80002998:	92c50513          	addi	a0,a0,-1748 # 800072c0 <CONSOLE_STATUS+0x2b0>
    8000299c:	00002097          	auipc	ra,0x2
    800029a0:	0ec080e7          	jalr	236(ra) # 80004a88 <_Z17kmem_cache_createPKcmPFvPvES3_>
    800029a4:	00005797          	auipc	a5,0x5
    800029a8:	3ca7b223          	sd	a0,964(a5) # 80007d68 <_ZN3TCB8tcbCacheE>
    TCB::running = new TCB(nullptr, nullptr, nullptr, DEFAULT_TIME_SLICE);
    800029ac:	07000513          	li	a0,112
    800029b0:	00000097          	auipc	ra,0x0
    800029b4:	f88080e7          	jalr	-120(ra) # 80002938 <_ZN3TCBnwEm>
    800029b8:	00050493          	mv	s1,a0
    800029bc:	00050e63          	beqz	a0,800029d8 <_ZN3TCB10initializeEv+0x70>
    800029c0:	00200713          	li	a4,2
    800029c4:	00000693          	li	a3,0
    800029c8:	00000613          	li	a2,0
    800029cc:	00000593          	li	a1,0
    800029d0:	00000097          	auipc	ra,0x0
    800029d4:	e2c080e7          	jalr	-468(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>
    800029d8:	00005797          	auipc	a5,0x5
    800029dc:	3897b423          	sd	s1,904(a5) # 80007d60 <_ZN3TCB7runningE>
    TCB::running->mode = Mode::SUPERVISOR;
    800029e0:	00100793          	li	a5,1
    800029e4:	00f4aa23          	sw	a5,20(s1)
    uint64 *putcStack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    800029e8:	00001537          	lui	a0,0x1
    800029ec:	00002097          	auipc	ra,0x2
    800029f0:	194080e7          	jalr	404(ra) # 80004b80 <_Z7kmallocm>
    800029f4:	00050913          	mv	s2,a0
    putcThread = new TCB(RiscV::putcWrapper, nullptr, putcStack, DEFAULT_TIME_SLICE);
    800029f8:	07000513          	li	a0,112
    800029fc:	00000097          	auipc	ra,0x0
    80002a00:	f3c080e7          	jalr	-196(ra) # 80002938 <_ZN3TCBnwEm>
    80002a04:	00050493          	mv	s1,a0
    80002a08:	02050063          	beqz	a0,80002a28 <_ZN3TCB10initializeEv+0xc0>
    80002a0c:	00200713          	li	a4,2
    80002a10:	00090693          	mv	a3,s2
    80002a14:	00000613          	li	a2,0
    80002a18:	00005597          	auipc	a1,0x5
    80002a1c:	0f05b583          	ld	a1,240(a1) # 80007b08 <_GLOBAL_OFFSET_TABLE_+0x48>
    80002a20:	00000097          	auipc	ra,0x0
    80002a24:	ddc080e7          	jalr	-548(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>
    80002a28:	00005797          	auipc	a5,0x5
    80002a2c:	3497b423          	sd	s1,840(a5) # 80007d70 <_ZN3TCB10putcThreadE>
    putcThread->mode = Mode::SUPERVISOR;
    80002a30:	00100793          	li	a5,1
    80002a34:	00f4aa23          	sw	a5,20(s1)
    Scheduler::put(putcThread);
    80002a38:	00048513          	mv	a0,s1
    80002a3c:	00002097          	auipc	ra,0x2
    80002a40:	9dc080e7          	jalr	-1572(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
}
    80002a44:	01813083          	ld	ra,24(sp)
    80002a48:	01013403          	ld	s0,16(sp)
    80002a4c:	00813483          	ld	s1,8(sp)
    80002a50:	00013903          	ld	s2,0(sp)
    80002a54:	02010113          	addi	sp,sp,32
    80002a58:	00008067          	ret

0000000080002a5c <_ZN3TCBdlEPv>:
void TCB::operator delete(void *addr){
    80002a5c:	ff010113          	addi	sp,sp,-16
    80002a60:	00113423          	sd	ra,8(sp)
    80002a64:	00813023          	sd	s0,0(sp)
    80002a68:	01010413          	addi	s0,sp,16
    80002a6c:	00050593          	mv	a1,a0
    kmem_cache_free(TCB::tcbCache, addr);
    80002a70:	00005517          	auipc	a0,0x5
    80002a74:	2f853503          	ld	a0,760(a0) # 80007d68 <_ZN3TCB8tcbCacheE>
    80002a78:	00002097          	auipc	ra,0x2
    80002a7c:	060080e7          	jalr	96(ra) # 80004ad8 <_Z15kmem_cache_freeP5CachePv>
}
    80002a80:	00813083          	ld	ra,8(sp)
    80002a84:	00013403          	ld	s0,0(sp)
    80002a88:	01010113          	addi	sp,sp,16
    80002a8c:	00008067          	ret

0000000080002a90 <_ZN3TCB11thread_freeEPv>:
int TCB::thread_free(void *addr) {
    80002a90:	ff010113          	addi	sp,sp,-16
    80002a94:	00813423          	sd	s0,8(sp)
    80002a98:	01010413          	addi	s0,sp,16
    asm("mv a1, %[iptr]" : : [iptr] "r" (iptr));
    80002a9c:	00050593          	mv	a1,a0
    asm("li a0, 0x51");
    80002aa0:	05100513          	li	a0,81
    asm("ecall");
    80002aa4:	00000073          	ecall
    asm("mv %[status], a0" : [status] "=r" (status));
    80002aa8:	00050513          	mv	a0,a0
}
    80002aac:	0005051b          	sext.w	a0,a0
    80002ab0:	00813403          	ld	s0,8(sp)
    80002ab4:	01010113          	addi	sp,sp,16
    80002ab8:	00008067          	ret

0000000080002abc <_ZN15MemoryAllocator10initializeEv>:
bool MemoryAllocator::initialized = false;

//initialize MemoryAllocator class
//forbid multiple initializations
//initial size of free memory is freeMemHead->size
void MemoryAllocator::initialize() {
    80002abc:	ff010113          	addi	sp,sp,-16
    80002ac0:	00813423          	sd	s0,8(sp)
    80002ac4:	01010413          	addi	s0,sp,16
    freeMemHead = freeMemTail = (BlockHeader*)FREE_MEMORY_START_CONST;
    80002ac8:	00005797          	auipc	a5,0x5
    80002acc:	0107b783          	ld	a5,16(a5) # 80007ad8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002ad0:	0007b783          	ld	a5,0(a5)
    80002ad4:	00c7d793          	srli	a5,a5,0xc
    80002ad8:	00278793          	addi	a5,a5,2
    80002adc:	00c79793          	slli	a5,a5,0xc
    80002ae0:	01000737          	lui	a4,0x1000
    80002ae4:	00e787b3          	add	a5,a5,a4
    80002ae8:	00005717          	auipc	a4,0x5
    80002aec:	2a870713          	addi	a4,a4,680 # 80007d90 <_ZN15MemoryAllocator11freeMemTailE>
    80002af0:	00f73023          	sd	a5,0(a4)
    80002af4:	00f73423          	sd	a5,8(a4)

    freeMemHead->prev = freeMemHead->next = freeMemTail->prev = freeMemTail->next = nullptr;
    80002af8:	0007b823          	sd	zero,16(a5)
    80002afc:	0007b423          	sd	zero,8(a5)

    allocMemHead = allocMemTail = nullptr;
    80002b00:	00073823          	sd	zero,16(a4)
    80002b04:	00073c23          	sd	zero,24(a4)

    freeMemHead->size = (char*)HEAP_END_ADDR - (char*)FREE_MEMORY_START_CONST - sizeof(BlockHeader);
    80002b08:	00005697          	auipc	a3,0x5
    80002b0c:	0806b683          	ld	a3,128(a3) # 80007b88 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80002b10:	0006b683          	ld	a3,0(a3)
    80002b14:	40f686b3          	sub	a3,a3,a5
    80002b18:	fe868693          	addi	a3,a3,-24
    80002b1c:	00d7b023          	sd	a3,0(a5)

    freeMemHead->next = nullptr;
    80002b20:	00873783          	ld	a5,8(a4)
    80002b24:	0007b823          	sd	zero,16(a5)

    initialized = true;
    80002b28:	00100793          	li	a5,1
    80002b2c:	02f70023          	sb	a5,32(a4)
}
    80002b30:	00813403          	ld	s0,8(sp)
    80002b34:	01010113          	addi	sp,sp,16
    80002b38:	00008067          	ret

0000000080002b3c <_ZN15MemoryAllocator7kmallocEm>:

void* MemoryAllocator::kmalloc(size_t size){
    80002b3c:	ff010113          	addi	sp,sp,-16
    80002b40:	00813423          	sd	s0,8(sp)
    80002b44:	01010413          	addi	s0,sp,16
    if(size<=0 || freeMemHead == nullptr || freeMemHead->size < size)
    80002b48:	14050663          	beqz	a0,80002c94 <_ZN15MemoryAllocator7kmallocEm+0x158>
    80002b4c:	00050793          	mv	a5,a0
    80002b50:	00005517          	auipc	a0,0x5
    80002b54:	24853503          	ld	a0,584(a0) # 80007d98 <_ZN15MemoryAllocator11freeMemHeadE>
    80002b58:	0a050e63          	beqz	a0,80002c14 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002b5c:	00053703          	ld	a4,0(a0)
    80002b60:	12f76e63          	bltu	a4,a5,80002c9c <_ZN15MemoryAllocator7kmallocEm+0x160>
        return nullptr;

    size_t byteSize = size * MEM_BLOCK_SIZE; //size of requested chunk in bytes   //NOTE: argument of kmalloc is number of blocks requested
    80002b64:	00679793          	slli	a5,a5,0x6

    BlockHeader* blk = freeMemHead, *prev = nullptr;
    80002b68:	00000613          	li	a2,0
    80002b6c:	00c0006f          	j	80002b78 <_ZN15MemoryAllocator7kmallocEm+0x3c>

    for(; blk!=nullptr; prev = blk, blk = blk->next) {
    80002b70:	00050613          	mv	a2,a0
    80002b74:	01053503          	ld	a0,16(a0)
    80002b78:	00050863          	beqz	a0,80002b88 <_ZN15MemoryAllocator7kmallocEm+0x4c>
        if (blk->size >= byteSize + sizeof(BlockHeader))
    80002b7c:	00053683          	ld	a3,0(a0)
    80002b80:	01878713          	addi	a4,a5,24
    80002b84:	fee6e6e3          	bltu	a3,a4,80002b70 <_ZN15MemoryAllocator7kmallocEm+0x34>
            break;            //iterate through the list and find the first fitting block of free memory
    }

    if(blk != nullptr){
    80002b88:	08050663          	beqz	a0,80002c14 <_ZN15MemoryAllocator7kmallocEm+0xd8>
        BlockHeader* newBlk;
        BlockHeader *nextAllocated;

        if((char*)blk + blk->size + sizeof(BlockHeader) < HEAP_END_ADDR)
    80002b8c:	00053683          	ld	a3,0(a0)
    80002b90:	01868713          	addi	a4,a3,24
    80002b94:	00e50733          	add	a4,a0,a4
    80002b98:	00005597          	auipc	a1,0x5
    80002b9c:	ff05b583          	ld	a1,-16(a1) # 80007b88 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80002ba0:	0005b583          	ld	a1,0(a1)
    80002ba4:	00b76463          	bltu	a4,a1,80002bac <_ZN15MemoryAllocator7kmallocEm+0x70>
            nextAllocated = (BlockHeader*)((char*)blk + blk->size + sizeof(BlockHeader));
        else
            nextAllocated = nullptr;
    80002ba8:	00000713          	li	a4,0

        size_t remainingSize = blk->size - byteSize;
    80002bac:	40f686b3          	sub	a3,a3,a5

        if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE){    //check whether a large enough fragment will remain
    80002bb0:	05700593          	li	a1,87
    80002bb4:	08d5f063          	bgeu	a1,a3,80002c34 <_ZN15MemoryAllocator7kmallocEm+0xf8>

            blk->size = byteSize;
    80002bb8:	00f53023          	sd	a5,0(a0)
            size_t offset = sizeof(BlockHeader) + byteSize;   //offset for new freeMem chunk
    80002bbc:	01878793          	addi	a5,a5,24
            newBlk = (BlockHeader*)((char*)blk + offset);
    80002bc0:	00f507b3          	add	a5,a0,a5
            newBlk->next = blk->next;
    80002bc4:	01053583          	ld	a1,16(a0)
    80002bc8:	00b7b823          	sd	a1,16(a5)
            newBlk->prev = blk->prev;
    80002bcc:	00853583          	ld	a1,8(a0)
    80002bd0:	00b7b423          	sd	a1,8(a5)
            newBlk->size = remainingSize - sizeof(BlockHeader);
    80002bd4:	fe868693          	addi	a3,a3,-24
    80002bd8:	00d7b023          	sd	a3,0(a5)

            if(prev)
    80002bdc:	04060263          	beqz	a2,80002c20 <_ZN15MemoryAllocator7kmallocEm+0xe4>
                prev->next = newBlk;
    80002be0:	00f63823          	sd	a5,16(a2)
            // No remaining fragment, allocate the entire block
            if (prev) prev->next = blk->next;
            else freeMemHead = blk->next;
        }

        if(allocMemHead == nullptr){
    80002be4:	00005797          	auipc	a5,0x5
    80002be8:	1c47b783          	ld	a5,452(a5) # 80007da8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002bec:	06078463          	beqz	a5,80002c54 <_ZN15MemoryAllocator7kmallocEm+0x118>
            allocMemHead = allocMemTail = blk;
        }
        else{

            blk->next = nextAllocated;
    80002bf0:	00e53823          	sd	a4,16(a0)

            if(nextAllocated){
    80002bf4:	08070063          	beqz	a4,80002c74 <_ZN15MemoryAllocator7kmallocEm+0x138>
                blk->prev = nextAllocated->prev;
    80002bf8:	00873783          	ld	a5,8(a4)
    80002bfc:	00f53423          	sd	a5,8(a0)
                blk->prev->next = blk;
    80002c00:	00a7b823          	sd	a0,16(a5)
                if(nextAllocated->prev)
    80002c04:	00873783          	ld	a5,8(a4)
    80002c08:	06078063          	beqz	a5,80002c68 <_ZN15MemoryAllocator7kmallocEm+0x12c>
                    nextAllocated->prev = blk;
    80002c0c:	00a73423          	sd	a0,8(a4)
                blk->next = nullptr;
                allocMemTail = blk;
            }
        }

        return (char*)blk + sizeof(BlockHeader);    //return address of start of the data block, not start of the header
    80002c10:	01850513          	addi	a0,a0,24
    }

    return nullptr;
}
    80002c14:	00813403          	ld	s0,8(sp)
    80002c18:	01010113          	addi	sp,sp,16
    80002c1c:	00008067          	ret
                freeMemHead = freeMemTail = newBlk;
    80002c20:	00005697          	auipc	a3,0x5
    80002c24:	17068693          	addi	a3,a3,368 # 80007d90 <_ZN15MemoryAllocator11freeMemTailE>
    80002c28:	00f6b023          	sd	a5,0(a3)
    80002c2c:	00f6b423          	sd	a5,8(a3)
    80002c30:	fb5ff06f          	j	80002be4 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            if (prev) prev->next = blk->next;
    80002c34:	00060863          	beqz	a2,80002c44 <_ZN15MemoryAllocator7kmallocEm+0x108>
    80002c38:	01053783          	ld	a5,16(a0)
    80002c3c:	00f63823          	sd	a5,16(a2)
    80002c40:	fa5ff06f          	j	80002be4 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            else freeMemHead = blk->next;
    80002c44:	01053783          	ld	a5,16(a0)
    80002c48:	00005697          	auipc	a3,0x5
    80002c4c:	14f6b823          	sd	a5,336(a3) # 80007d98 <_ZN15MemoryAllocator11freeMemHeadE>
    80002c50:	f95ff06f          	j	80002be4 <_ZN15MemoryAllocator7kmallocEm+0xa8>
            allocMemHead = allocMemTail = blk;
    80002c54:	00005797          	auipc	a5,0x5
    80002c58:	13c78793          	addi	a5,a5,316 # 80007d90 <_ZN15MemoryAllocator11freeMemTailE>
    80002c5c:	00a7b823          	sd	a0,16(a5)
    80002c60:	00a7bc23          	sd	a0,24(a5)
    80002c64:	fadff06f          	j	80002c10 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                    allocMemHead = blk;
    80002c68:	00005797          	auipc	a5,0x5
    80002c6c:	14a7b023          	sd	a0,320(a5) # 80007da8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002c70:	fa1ff06f          	j	80002c10 <_ZN15MemoryAllocator7kmallocEm+0xd4>
                allocMemTail->next = blk;
    80002c74:	00005797          	auipc	a5,0x5
    80002c78:	11c78793          	addi	a5,a5,284 # 80007d90 <_ZN15MemoryAllocator11freeMemTailE>
    80002c7c:	0107b703          	ld	a4,16(a5)
    80002c80:	00a73823          	sd	a0,16(a4)
                blk->prev = allocMemTail;
    80002c84:	00e53423          	sd	a4,8(a0)
                blk->next = nullptr;
    80002c88:	00053823          	sd	zero,16(a0)
                allocMemTail = blk;
    80002c8c:	00a7b823          	sd	a0,16(a5)
    80002c90:	f81ff06f          	j	80002c10 <_ZN15MemoryAllocator7kmallocEm+0xd4>
        return nullptr;
    80002c94:	00000513          	li	a0,0
    80002c98:	f7dff06f          	j	80002c14 <_ZN15MemoryAllocator7kmallocEm+0xd8>
    80002c9c:	00000513          	li	a0,0
    80002ca0:	f75ff06f          	j	80002c14 <_ZN15MemoryAllocator7kmallocEm+0xd8>

0000000080002ca4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>:
        insertAndMerge(blk, &freeMemHead);
    }
    return 0;
}

void MemoryAllocator::insertAndMerge(void *addr, BlockHeader **head) {   //insert a fragment from given address and if the fragment is being freed, try to merge with other fragments
    80002ca4:	ff010113          	addi	sp,sp,-16
    80002ca8:	00813423          	sd	s0,8(sp)
    80002cac:	01010413          	addi	s0,sp,16
    BlockHeader* blk = (BlockHeader*)addr;
    BlockHeader* iter = *head, *prev=nullptr;
    80002cb0:	0005b783          	ld	a5,0(a1)

    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002cb4:	00000713          	li	a4,0
    80002cb8:	00078a63          	beqz	a5,80002ccc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
        if((uint64)iter >= (uint64)blk) break;
    80002cbc:	00a7f863          	bgeu	a5,a0,80002ccc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x28>
    for(prev = nullptr; iter != nullptr; prev = iter, iter = iter->next)
    80002cc0:	00078713          	mv	a4,a5
    80002cc4:	0107b783          	ld	a5,16(a5)
    80002cc8:	ff1ff06f          	j	80002cb8 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x14>

    blk->next = iter;
    80002ccc:	00f53823          	sd	a5,16(a0)
    blk->prev = prev;
    80002cd0:	00e53423          	sd	a4,8(a0)

    if(iter != nullptr)
    80002cd4:	00078463          	beqz	a5,80002cdc <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x38>
        iter->prev = blk;
    80002cd8:	00a7b423          	sd	a0,8(a5)

    if(prev == nullptr)
    80002cdc:	02070263          	beqz	a4,80002d00 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x5c>
        *head = blk;
    else
        prev->next = blk;
    80002ce0:	00a73823          	sd	a0,16(a4)

    if(*head == freeMemHead){
    80002ce4:	0005b703          	ld	a4,0(a1)
    80002ce8:	00005797          	auipc	a5,0x5
    80002cec:	0b07b783          	ld	a5,176(a5) # 80007d98 <_ZN15MemoryAllocator11freeMemHeadE>
    80002cf0:	00f70c63          	beq	a4,a5,80002d08 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x64>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
                blk->prev->next = blk->next;
            }
    }
}
    80002cf4:	00813403          	ld	s0,8(sp)
    80002cf8:	01010113          	addi	sp,sp,16
    80002cfc:	00008067          	ret
        *head = blk;
    80002d00:	00a5b023          	sd	a0,0(a1)
    80002d04:	fe1ff06f          	j	80002ce4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x40>
        if(blk->next)   //try to merge with next
    80002d08:	01053783          	ld	a5,16(a0)
    80002d0c:	00078a63          	beqz	a5,80002d20 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>
            if(((uint64)blk + blk->size + sizeof(BlockHeader)) == (uint64)blk->next){
    80002d10:	00053683          	ld	a3,0(a0)
    80002d14:	00d50733          	add	a4,a0,a3
    80002d18:	01870713          	addi	a4,a4,24
    80002d1c:	02f70e63          	beq	a4,a5,80002d58 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0xb4>
        if(blk->prev)   //try to merge with previous
    80002d20:	00853783          	ld	a5,8(a0)
    80002d24:	fc0788e3          	beqz	a5,80002cf4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
            if(((uint64)blk->prev + sizeof(BlockHeader) + blk->prev->size) == (uint64)blk){
    80002d28:	0007b683          	ld	a3,0(a5)
    80002d2c:	00d78733          	add	a4,a5,a3
    80002d30:	01870713          	addi	a4,a4,24
    80002d34:	fca710e3          	bne	a4,a0,80002cf4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->prev->size += (size_t)blk->size + sizeof(BlockHeader);
    80002d38:	00053703          	ld	a4,0(a0)
    80002d3c:	00e68733          	add	a4,a3,a4
    80002d40:	01870713          	addi	a4,a4,24
    80002d44:	00e7b023          	sd	a4,0(a5)
                blk->prev->next = blk->next;
    80002d48:	00853783          	ld	a5,8(a0)
    80002d4c:	01053703          	ld	a4,16(a0)
    80002d50:	00e7b823          	sd	a4,16(a5)
}
    80002d54:	fa1ff06f          	j	80002cf4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x50>
                blk->size += (uint64)blk->next->size + sizeof(BlockHeader);
    80002d58:	0007b703          	ld	a4,0(a5)
    80002d5c:	00e68733          	add	a4,a3,a4
    80002d60:	01870713          	addi	a4,a4,24
    80002d64:	00e53023          	sd	a4,0(a0)
                blk->next = blk->next->next;
    80002d68:	0107b783          	ld	a5,16(a5)
    80002d6c:	00f53823          	sd	a5,16(a0)
    80002d70:	fb1ff06f          	j	80002d20 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE+0x7c>

0000000080002d74 <_ZN15MemoryAllocator5kfreeEPv>:
uint64 MemoryAllocator::kfree(void* ptr){
    80002d74:	00050713          	mv	a4,a0
    BlockHeader *blk = allocMemHead;
    80002d78:	00005697          	auipc	a3,0x5
    80002d7c:	0306b683          	ld	a3,48(a3) # 80007da8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002d80:	00068513          	mv	a0,a3
    for(; blk != nullptr;blk = blk->next)
    80002d84:	00050a63          	beqz	a0,80002d98 <_ZN15MemoryAllocator5kfreeEPv+0x24>
        if((uint64)ptr - sizeof(BlockHeader) == (uint64)blk) break;
    80002d88:	fe870793          	addi	a5,a4,-24
    80002d8c:	00a78663          	beq	a5,a0,80002d98 <_ZN15MemoryAllocator5kfreeEPv+0x24>
    for(; blk != nullptr;blk = blk->next)
    80002d90:	01053503          	ld	a0,16(a0)
    80002d94:	ff1ff06f          	j	80002d84 <_ZN15MemoryAllocator5kfreeEPv+0x10>
    if(blk == nullptr)
    80002d98:	08050463          	beqz	a0,80002e20 <_ZN15MemoryAllocator5kfreeEPv+0xac>
uint64 MemoryAllocator::kfree(void* ptr){
    80002d9c:	ff010113          	addi	sp,sp,-16
    80002da0:	00113423          	sd	ra,8(sp)
    80002da4:	00813023          	sd	s0,0(sp)
    80002da8:	01010413          	addi	s0,sp,16
        if(blk == allocMemTail)
    80002dac:	00005797          	auipc	a5,0x5
    80002db0:	ff47b783          	ld	a5,-12(a5) # 80007da0 <_ZN15MemoryAllocator12allocMemTailE>
    80002db4:	04a78663          	beq	a5,a0,80002e00 <_ZN15MemoryAllocator5kfreeEPv+0x8c>
        if(blk == allocMemHead)
    80002db8:	04d50c63          	beq	a0,a3,80002e10 <_ZN15MemoryAllocator5kfreeEPv+0x9c>
        if(blk->next)
    80002dbc:	01053783          	ld	a5,16(a0)
    80002dc0:	00078663          	beqz	a5,80002dcc <_ZN15MemoryAllocator5kfreeEPv+0x58>
            blk->next->prev = blk->prev;
    80002dc4:	00853703          	ld	a4,8(a0)
    80002dc8:	00e7b423          	sd	a4,8(a5)
        if(blk->prev)
    80002dcc:	00853783          	ld	a5,8(a0)
    80002dd0:	00078663          	beqz	a5,80002ddc <_ZN15MemoryAllocator5kfreeEPv+0x68>
            blk->prev->next = blk->next;
    80002dd4:	01053703          	ld	a4,16(a0)
    80002dd8:	00e7b823          	sd	a4,16(a5)
        insertAndMerge(blk, &freeMemHead);
    80002ddc:	00005597          	auipc	a1,0x5
    80002de0:	fbc58593          	addi	a1,a1,-68 # 80007d98 <_ZN15MemoryAllocator11freeMemHeadE>
    80002de4:	00000097          	auipc	ra,0x0
    80002de8:	ec0080e7          	jalr	-320(ra) # 80002ca4 <_ZN15MemoryAllocator14insertAndMergeEPvPPNS_11BlockHeaderE>
    return 0;
    80002dec:	00000513          	li	a0,0
}
    80002df0:	00813083          	ld	ra,8(sp)
    80002df4:	00013403          	ld	s0,0(sp)
    80002df8:	01010113          	addi	sp,sp,16
    80002dfc:	00008067          	ret
            allocMemTail = blk->prev;
    80002e00:	00853783          	ld	a5,8(a0)
    80002e04:	00005717          	auipc	a4,0x5
    80002e08:	f8f73e23          	sd	a5,-100(a4) # 80007da0 <_ZN15MemoryAllocator12allocMemTailE>
    80002e0c:	fadff06f          	j	80002db8 <_ZN15MemoryAllocator5kfreeEPv+0x44>
            allocMemHead = blk->next;
    80002e10:	01053783          	ld	a5,16(a0)
    80002e14:	00005717          	auipc	a4,0x5
    80002e18:	f8f73a23          	sd	a5,-108(a4) # 80007da8 <_ZN15MemoryAllocator12allocMemHeadE>
    80002e1c:	fa1ff06f          	j	80002dbc <_ZN15MemoryAllocator5kfreeEPv+0x48>
        return -1;
    80002e20:	fff00513          	li	a0,-1
}
    80002e24:	00008067          	ret

0000000080002e28 <_ZN15MemoryAllocator10showMemoryEv>:

void MemoryAllocator::showMemory() {
    80002e28:	fe010113          	addi	sp,sp,-32
    80002e2c:	00113c23          	sd	ra,24(sp)
    80002e30:	00813823          	sd	s0,16(sp)
    80002e34:	00913423          	sd	s1,8(sp)
    80002e38:	02010413          	addi	s0,sp,32
    BlockHeader *iter = allocMemHead;
    80002e3c:	00005497          	auipc	s1,0x5
    80002e40:	f6c4b483          	ld	s1,-148(s1) # 80007da8 <_ZN15MemoryAllocator12allocMemHeadE>
    printString("NOW SHOWING ALLOCATED MEMORY\n");
    80002e44:	00004517          	auipc	a0,0x4
    80002e48:	48c50513          	addi	a0,a0,1164 # 800072d0 <CONSOLE_STATUS+0x2c0>
    80002e4c:	0000e097          	auipc	ra,0xe
    80002e50:	ab8080e7          	jalr	-1352(ra) # 80010904 <_Z11printStringPKc>
    while(iter!=nullptr){
    80002e54:	04048663          	beqz	s1,80002ea0 <_ZN15MemoryAllocator10showMemoryEv+0x78>
        printInt((uint64)iter);
    80002e58:	00000613          	li	a2,0
    80002e5c:	00a00593          	li	a1,10
    80002e60:	0004851b          	sext.w	a0,s1
    80002e64:	0000e097          	auipc	ra,0xe
    80002e68:	c38080e7          	jalr	-968(ra) # 80010a9c <_Z8printIntiii>
        putc(' ');
    80002e6c:	02000513          	li	a0,32
    80002e70:	0000c097          	auipc	ra,0xc
    80002e74:	4bc080e7          	jalr	1212(ra) # 8000f32c <_Z4putcc>
        printInt(iter->size);
    80002e78:	00000613          	li	a2,0
    80002e7c:	00a00593          	li	a1,10
    80002e80:	0004a503          	lw	a0,0(s1)
    80002e84:	0000e097          	auipc	ra,0xe
    80002e88:	c18080e7          	jalr	-1000(ra) # 80010a9c <_Z8printIntiii>
        putc('\n');
    80002e8c:	00a00513          	li	a0,10
    80002e90:	0000c097          	auipc	ra,0xc
    80002e94:	49c080e7          	jalr	1180(ra) # 8000f32c <_Z4putcc>
        iter=iter->next;
    80002e98:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002e9c:	fb9ff06f          	j	80002e54 <_ZN15MemoryAllocator10showMemoryEv+0x2c>
    }

    printString("NOW SHOWING FREE MEMORY\n");
    80002ea0:	00004517          	auipc	a0,0x4
    80002ea4:	45050513          	addi	a0,a0,1104 # 800072f0 <CONSOLE_STATUS+0x2e0>
    80002ea8:	0000e097          	auipc	ra,0xe
    80002eac:	a5c080e7          	jalr	-1444(ra) # 80010904 <_Z11printStringPKc>
    iter = freeMemHead;
    80002eb0:	00005497          	auipc	s1,0x5
    80002eb4:	ee84b483          	ld	s1,-280(s1) # 80007d98 <_ZN15MemoryAllocator11freeMemHeadE>
    while(iter!=nullptr){
    80002eb8:	04048663          	beqz	s1,80002f04 <_ZN15MemoryAllocator10showMemoryEv+0xdc>
        printInt((uint64)iter);
    80002ebc:	00000613          	li	a2,0
    80002ec0:	00a00593          	li	a1,10
    80002ec4:	0004851b          	sext.w	a0,s1
    80002ec8:	0000e097          	auipc	ra,0xe
    80002ecc:	bd4080e7          	jalr	-1068(ra) # 80010a9c <_Z8printIntiii>
        putc(' ');
    80002ed0:	02000513          	li	a0,32
    80002ed4:	0000c097          	auipc	ra,0xc
    80002ed8:	458080e7          	jalr	1112(ra) # 8000f32c <_Z4putcc>
        printInt(iter->size);
    80002edc:	00000613          	li	a2,0
    80002ee0:	00a00593          	li	a1,10
    80002ee4:	0004a503          	lw	a0,0(s1)
    80002ee8:	0000e097          	auipc	ra,0xe
    80002eec:	bb4080e7          	jalr	-1100(ra) # 80010a9c <_Z8printIntiii>
        putc('\n');
    80002ef0:	00a00513          	li	a0,10
    80002ef4:	0000c097          	auipc	ra,0xc
    80002ef8:	438080e7          	jalr	1080(ra) # 8000f32c <_Z4putcc>
        iter=iter->next;
    80002efc:	0104b483          	ld	s1,16(s1)
    while(iter!=nullptr){
    80002f00:	fb9ff06f          	j	80002eb8 <_ZN15MemoryAllocator10showMemoryEv+0x90>
    }
    printString("================================================================\n");
    80002f04:	00004517          	auipc	a0,0x4
    80002f08:	40c50513          	addi	a0,a0,1036 # 80007310 <CONSOLE_STATUS+0x300>
    80002f0c:	0000e097          	auipc	ra,0xe
    80002f10:	9f8080e7          	jalr	-1544(ra) # 80010904 <_Z11printStringPKc>
}
    80002f14:	01813083          	ld	ra,24(sp)
    80002f18:	01013403          	ld	s0,16(sp)
    80002f1c:	00813483          	ld	s1,8(sp)
    80002f20:	02010113          	addi	sp,sp,32
    80002f24:	00008067          	ret

0000000080002f28 <_ZN15MemoryAllocator6memcpyEPvS0_m>:


void* MemoryAllocator::memcpy(void *src, void *dst, uint64 len) {
    80002f28:	ff010113          	addi	sp,sp,-16
    80002f2c:	00813423          	sd	s0,8(sp)
    80002f30:	01010413          	addi	s0,sp,16
    80002f34:	00050813          	mv	a6,a0
    80002f38:	00058513          	mv	a0,a1
    char *csrc = (char*)src;
    char *cdst = (char*)dst;

    for(uint64 i=0;i<len;i++)
    80002f3c:	00000793          	li	a5,0
    80002f40:	00c7fe63          	bgeu	a5,a2,80002f5c <_ZN15MemoryAllocator6memcpyEPvS0_m+0x34>
        cdst[i] = csrc[i];
    80002f44:	00f50733          	add	a4,a0,a5
    80002f48:	00f806b3          	add	a3,a6,a5
    80002f4c:	0006c683          	lbu	a3,0(a3)
    80002f50:	00d70023          	sb	a3,0(a4)
    for(uint64 i=0;i<len;i++)
    80002f54:	00178793          	addi	a5,a5,1
    80002f58:	fe9ff06f          	j	80002f40 <_ZN15MemoryAllocator6memcpyEPvS0_m+0x18>

    return dst;
    80002f5c:	00813403          	ld	s0,8(sp)
    80002f60:	01010113          	addi	sp,sp,16
    80002f64:	00008067          	ret

0000000080002f68 <_ZN5RiscV6getPMTEv>:
extern char *userTextStart;
extern char *userDataStart;
extern char *userDataEnd;
extern char *kernelTextEnd;

void* RiscV::getPMT(){
    80002f68:	ff010113          	addi	sp,sp,-16
    80002f6c:	00113423          	sd	ra,8(sp)
    80002f70:	00813023          	sd	s0,0(sp)
    80002f74:	01010413          	addi	s0,sp,16
    void* ret = Buddy::alloc(1);
    80002f78:	00100513          	li	a0,1
    80002f7c:	fffff097          	auipc	ra,0xfffff
    80002f80:	348080e7          	jalr	840(ra) # 800022c4 <_ZN5Buddy5allocEm>
    uint64* arr = (uint64*)ret;
    for(int i=0;i<512;i++)
    80002f84:	00000793          	li	a5,0
    80002f88:	1ff00713          	li	a4,511
    80002f8c:	00f74c63          	blt	a4,a5,80002fa4 <_ZN5RiscV6getPMTEv+0x3c>
        arr[i] = 0;
    80002f90:	00379713          	slli	a4,a5,0x3
    80002f94:	00e50733          	add	a4,a0,a4
    80002f98:	00073023          	sd	zero,0(a4)
    for(int i=0;i<512;i++)
    80002f9c:	0017879b          	addiw	a5,a5,1
    80002fa0:	fe9ff06f          	j	80002f88 <_ZN5RiscV6getPMTEv+0x20>
    return ret;
}
    80002fa4:	00813083          	ld	ra,8(sp)
    80002fa8:	00013403          	ld	s0,0(sp)
    80002fac:	01010113          	addi	sp,sp,16
    80002fb0:	00008067          	ret

0000000080002fb4 <_ZN5RiscV15handlePageFaultEPvmm>:

void RiscV::handlePageFault(void* PMT, uint64 addr, uint64 mask){
    80002fb4:	fc010113          	addi	sp,sp,-64
    80002fb8:	02113c23          	sd	ra,56(sp)
    80002fbc:	02813823          	sd	s0,48(sp)
    80002fc0:	02913423          	sd	s1,40(sp)
    80002fc4:	03213023          	sd	s2,32(sp)
    80002fc8:	01313c23          	sd	s3,24(sp)
    80002fcc:	01413823          	sd	s4,16(sp)
    80002fd0:	01513423          	sd	s5,8(sp)
    80002fd4:	04010413          	addi	s0,sp,64
    80002fd8:	00060993          	mv	s3,a2
    uint64 pmt2Entry = (addr >> 30) & (0x1ff);;
    80002fdc:	01e5d793          	srli	a5,a1,0x1e
    80002fe0:	1ff7f793          	andi	a5,a5,511
    uint64 pmt1Entry = (addr >> 21) & (0x1ff);
    80002fe4:	0155d913          	srli	s2,a1,0x15
    80002fe8:	1ff97913          	andi	s2,s2,511
    uint64 pmt0Entry = (addr >> 12) & (0x1ff);
    80002fec:	00c5d493          	srli	s1,a1,0xc
    80002ff0:	1ff4fa13          	andi	s4,s1,511
    uint64 pmt2Desc = ((uint64*)PMT)[pmt2Entry];
    80002ff4:	00379793          	slli	a5,a5,0x3
    80002ff8:	00f50ab3          	add	s5,a0,a5
    80002ffc:	000ab783          	ld	a5,0(s5)
    void* pmt1 = nullptr;
    if(pmt2Desc == 0){
    80003000:	06078263          	beqz	a5,80003064 <_ZN5RiscV15handlePageFaultEPvmm+0xb0>
        pmt1 = RiscV::getPMT();
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    }
    else
        pmt1 = (void*)((pmt2Desc >> 10) << 12);
    80003004:	00a7d513          	srli	a0,a5,0xa
    80003008:	00c51513          	slli	a0,a0,0xc
    uint64 pmt1Desc = ((uint64*)pmt1)[pmt1Entry];
    8000300c:	00391913          	slli	s2,s2,0x3
    80003010:	01250933          	add	s2,a0,s2
    80003014:	00093503          	ld	a0,0(s2)
    void* pmt0 = nullptr;
    if(pmt1Desc == 0){
    80003018:	06050463          	beqz	a0,80003080 <_ZN5RiscV15handlePageFaultEPvmm+0xcc>
        pmt0 = RiscV::getPMT();
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    }
    else
        pmt0 = (void*)((pmt1Desc >> 10) << 12);
    8000301c:	00a55513          	srli	a0,a0,0xa
    80003020:	00c51513          	slli	a0,a0,0xc
    uint64 pmt0Desc = ((uint64*)pmt0)[pmt0Entry];
    80003024:	003a1a13          	slli	s4,s4,0x3
    80003028:	01450533          	add	a0,a0,s4
    8000302c:	00053783          	ld	a5,0(a0)
    if(pmt0Desc == 0) {
    80003030:	00079863          	bnez	a5,80003040 <_ZN5RiscV15handlePageFaultEPvmm+0x8c>
        ((uint64 *) pmt0)[pmt0Entry] = ((addr >> 12) << 10) | mask;
    80003034:	00a49493          	slli	s1,s1,0xa
    80003038:	0134e9b3          	or	s3,s1,s3
    8000303c:	01353023          	sd	s3,0(a0)
    }
}
    80003040:	03813083          	ld	ra,56(sp)
    80003044:	03013403          	ld	s0,48(sp)
    80003048:	02813483          	ld	s1,40(sp)
    8000304c:	02013903          	ld	s2,32(sp)
    80003050:	01813983          	ld	s3,24(sp)
    80003054:	01013a03          	ld	s4,16(sp)
    80003058:	00813a83          	ld	s5,8(sp)
    8000305c:	04010113          	addi	sp,sp,64
    80003060:	00008067          	ret
        pmt1 = RiscV::getPMT();
    80003064:	00000097          	auipc	ra,0x0
    80003068:	f04080e7          	jalr	-252(ra) # 80002f68 <_ZN5RiscV6getPMTEv>
        ((uint64*)PMT)[pmt2Entry] = (((uint64)pmt1 >> 12) << 10) | (uint64)1;
    8000306c:	00c55793          	srli	a5,a0,0xc
    80003070:	00a79793          	slli	a5,a5,0xa
    80003074:	0017e793          	ori	a5,a5,1
    80003078:	00fab023          	sd	a5,0(s5)
    8000307c:	f91ff06f          	j	8000300c <_ZN5RiscV15handlePageFaultEPvmm+0x58>
        pmt0 = RiscV::getPMT();
    80003080:	00000097          	auipc	ra,0x0
    80003084:	ee8080e7          	jalr	-280(ra) # 80002f68 <_ZN5RiscV6getPMTEv>
        ((uint64*)pmt1)[pmt1Entry] = (((uint64)pmt0 >> 12) << 10) | (uint64)1;
    80003088:	00c55793          	srli	a5,a0,0xc
    8000308c:	00a79793          	slli	a5,a5,0xa
    80003090:	0017e793          	ori	a5,a5,1
    80003094:	00f93023          	sd	a5,0(s2)
    80003098:	f8dff06f          	j	80003024 <_ZN5RiscV15handlePageFaultEPvmm+0x70>

000000008000309c <_ZN5RiscV10initializeEv>:
//initailize each of the key components and switch to user mode for user code execution
void RiscV::initialize(){
    8000309c:	fb010113          	addi	sp,sp,-80
    800030a0:	04113423          	sd	ra,72(sp)
    800030a4:	04813023          	sd	s0,64(sp)
    800030a8:	02913c23          	sd	s1,56(sp)
    800030ac:	03213823          	sd	s2,48(sp)
    800030b0:	03313423          	sd	s3,40(sp)
    800030b4:	03413023          	sd	s4,32(sp)
    800030b8:	01513c23          	sd	s5,24(sp)
    800030bc:	01613823          	sd	s6,16(sp)
    800030c0:	01713423          	sd	s7,8(sp)
    800030c4:	01813023          	sd	s8,0(sp)
    800030c8:	05010413          	addi	s0,sp,80
    RiscV::w_stvec((uint64) &RiscV::supervisorTrap);
    800030cc:	00005797          	auipc	a5,0x5
    800030d0:	a847b783          	ld	a5,-1404(a5) # 80007b50 <_GLOBAL_OFFSET_TABLE_+0x90>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    return sstatus;
}

inline void RiscV::w_stvec(uint64 stvec){
    asm("csrw stvec, %[stvec]" : : [stvec] "r" (stvec));
    800030d4:	10579073          	csrw	stvec,a5
    kmem_init(BUDDY_START_ADDR_CONST, 4096);
    800030d8:	00005497          	auipc	s1,0x5
    800030dc:	a004b483          	ld	s1,-1536(s1) # 80007ad8 <_GLOBAL_OFFSET_TABLE_+0x18>
    800030e0:	0004b503          	ld	a0,0(s1)
    800030e4:	00c55513          	srli	a0,a0,0xc
    800030e8:	00250513          	addi	a0,a0,2
    800030ec:	000015b7          	lui	a1,0x1
    800030f0:	00c51513          	slli	a0,a0,0xc
    800030f4:	00002097          	auipc	ra,0x2
    800030f8:	96c080e7          	jalr	-1684(ra) # 80004a60 <_Z9kmem_initPvi>
    MemoryAllocator::initialize();
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	9c0080e7          	jalr	-1600(ra) # 80002abc <_ZN15MemoryAllocator10initializeEv>
    Scheduler::initialize();
    80003104:	00001097          	auipc	ra,0x1
    80003108:	2fc080e7          	jalr	764(ra) # 80004400 <_ZN9Scheduler10initializeEv>
    TCB::initialize();
    8000310c:	00000097          	auipc	ra,0x0
    80003110:	85c080e7          	jalr	-1956(ra) # 80002968 <_ZN3TCB10initializeEv>
    SCB::initialize();
    80003114:	fffff097          	auipc	ra,0xfffff
    80003118:	394080e7          	jalr	916(ra) # 800024a8 <_ZN3SCB10initializeEv>
    ConsoleUtil::initialize();
    8000311c:	00001097          	auipc	ra,0x1
    80003120:	4f8080e7          	jalr	1272(ra) # 80004614 <_ZN11ConsoleUtil10initializeEv>
    RiscV::kPMT = RiscV::getPMT();
    80003124:	00000097          	auipc	ra,0x0
    80003128:	e44080e7          	jalr	-444(ra) # 80002f68 <_ZN5RiscV6getPMTEv>
    8000312c:	00005797          	auipc	a5,0x5
    80003130:	c8a7b623          	sd	a0,-884(a5) # 80007db8 <_ZN5RiscV4kPMTE>
    uint64 kTextEnd = ((uint64)(&kernelTextEnd));
    80003134:	00005b17          	auipc	s6,0x5
    80003138:	9acb3b03          	ld	s6,-1620(s6) # 80007ae0 <_GLOBAL_OFFSET_TABLE_+0x20>
    uint64 uTextStart = ((uint64)(&userTextStart));
    8000313c:	00005a97          	auipc	s5,0x5
    80003140:	a3caba83          	ld	s5,-1476(s5) # 80007b78 <_GLOBAL_OFFSET_TABLE_+0xb8>
    uint64 uDataStart = ((uint64)(&userDataStart));
    80003144:	00005a17          	auipc	s4,0x5
    80003148:	a5ca3a03          	ld	s4,-1444(s4) # 80007ba0 <_GLOBAL_OFFSET_TABLE_+0xe0>
    uint64 uDataEnd = ((uint64)(&userDataEnd));
    8000314c:	00005997          	auipc	s3,0x5
    80003150:	9a49b983          	ld	s3,-1628(s3) # 80007af0 <_GLOBAL_OFFSET_TABLE_+0x30>
    uint64 hStart = ((uint64)HEAP_START_ADDR);
    80003154:	0004b903          	ld	s2,0(s1)
    uint64 hEnd = ((uint64)HEAP_END_ADDR);
    80003158:	00005797          	auipc	a5,0x5
    8000315c:	a307b783          	ld	a5,-1488(a5) # 80007b88 <_GLOBAL_OFFSET_TABLE_+0xc8>
    80003160:	0007bc03          	ld	s8,0(a5)
    uint64 bEnd = ((uint64)Buddy::BUDDY_START_ADDR + (Buddy::BLOCKS_AVAILABLE<<12));
    80003164:	00005797          	auipc	a5,0x5
    80003168:	9947b783          	ld	a5,-1644(a5) # 80007af8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000316c:	0007b483          	ld	s1,0(a5)
    80003170:	00c49493          	slli	s1,s1,0xc
    80003174:	00005797          	auipc	a5,0x5
    80003178:	99c7b783          	ld	a5,-1636(a5) # 80007b10 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000317c:	0007b783          	ld	a5,0(a5)
    80003180:	00f484b3          	add	s1,s1,a5


    for(uint64 i=0x80000000;i< kTextEnd;i+=0x1000) {
    80003184:	00100b93          	li	s7,1
    80003188:	01fb9b93          	slli	s7,s7,0x1f
    8000318c:	036bf463          	bgeu	s7,s6,800031b4 <_ZN5RiscV10initializeEv+0x118>
        handlePageFault(kPMT,i, 0xb);
    80003190:	00b00613          	li	a2,11
    80003194:	000b8593          	mv	a1,s7
    80003198:	00005517          	auipc	a0,0x5
    8000319c:	c2053503          	ld	a0,-992(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    800031a0:	00000097          	auipc	ra,0x0
    800031a4:	e14080e7          	jalr	-492(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=0x80000000;i< kTextEnd;i+=0x1000) {
    800031a8:	000017b7          	lui	a5,0x1
    800031ac:	00fb8bb3          	add	s7,s7,a5
    800031b0:	fddff06f          	j	8000318c <_ZN5RiscV10initializeEv+0xf0>
    }

    for(uint64 i=kTextEnd;i<uTextStart;i+=0x1000) {
    800031b4:	035b7463          	bgeu	s6,s5,800031dc <_ZN5RiscV10initializeEv+0x140>
        handlePageFault(kPMT,i, 0x7);
    800031b8:	00700613          	li	a2,7
    800031bc:	000b0593          	mv	a1,s6
    800031c0:	00005517          	auipc	a0,0x5
    800031c4:	bf853503          	ld	a0,-1032(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    800031c8:	00000097          	auipc	ra,0x0
    800031cc:	dec080e7          	jalr	-532(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=kTextEnd;i<uTextStart;i+=0x1000) {
    800031d0:	000017b7          	lui	a5,0x1
    800031d4:	00fb0b33          	add	s6,s6,a5
    800031d8:	fddff06f          	j	800031b4 <_ZN5RiscV10initializeEv+0x118>
    }

    for (uint64 i = uTextStart; i < uDataStart; i+=0x1000) {
    800031dc:	034af463          	bgeu	s5,s4,80003204 <_ZN5RiscV10initializeEv+0x168>
        handlePageFault(kPMT, i, 0x1b);
    800031e0:	01b00613          	li	a2,27
    800031e4:	000a8593          	mv	a1,s5
    800031e8:	00005517          	auipc	a0,0x5
    800031ec:	bd053503          	ld	a0,-1072(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	dc4080e7          	jalr	-572(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for (uint64 i = uTextStart; i < uDataStart; i+=0x1000) {
    800031f8:	000017b7          	lui	a5,0x1
    800031fc:	00fa8ab3          	add	s5,s5,a5
    80003200:	fddff06f          	j	800031dc <_ZN5RiscV10initializeEv+0x140>
    }


    for(uint64 i=uDataStart;i<uDataEnd;i++) {
    80003204:	033a7263          	bgeu	s4,s3,80003228 <_ZN5RiscV10initializeEv+0x18c>
        handlePageFault(kPMT,i, 0x1f);
    80003208:	01f00613          	li	a2,31
    8000320c:	000a0593          	mv	a1,s4
    80003210:	00005517          	auipc	a0,0x5
    80003214:	ba853503          	ld	a0,-1112(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    80003218:	00000097          	auipc	ra,0x0
    8000321c:	d9c080e7          	jalr	-612(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=uDataStart;i<uDataEnd;i++) {
    80003220:	001a0a13          	addi	s4,s4,1
    80003224:	fe1ff06f          	j	80003204 <_ZN5RiscV10initializeEv+0x168>
    }

    for(uint64 i=uDataEnd;i<hStart;i+=0x1000) {
    80003228:	0329f463          	bgeu	s3,s2,80003250 <_ZN5RiscV10initializeEv+0x1b4>
        handlePageFault(kPMT,i, 0x7);
    8000322c:	00700613          	li	a2,7
    80003230:	00098593          	mv	a1,s3
    80003234:	00005517          	auipc	a0,0x5
    80003238:	b8453503          	ld	a0,-1148(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    8000323c:	00000097          	auipc	ra,0x0
    80003240:	d78080e7          	jalr	-648(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=uDataEnd;i<hStart;i+=0x1000) {
    80003244:	000017b7          	lui	a5,0x1
    80003248:	00f989b3          	add	s3,s3,a5
    8000324c:	fddff06f          	j	80003228 <_ZN5RiscV10initializeEv+0x18c>
    }

    for(uint64 i=hStart;i<bEnd;i+=0x1000) {
    80003250:	04997463          	bgeu	s2,s1,80003298 <_ZN5RiscV10initializeEv+0x1fc>
        handlePageFault(kPMT,i, 0x7);
    80003254:	00700613          	li	a2,7
    80003258:	00090593          	mv	a1,s2
    8000325c:	00005517          	auipc	a0,0x5
    80003260:	b5c53503          	ld	a0,-1188(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    80003264:	00000097          	auipc	ra,0x0
    80003268:	d50080e7          	jalr	-688(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i=hStart;i<bEnd;i+=0x1000) {
    8000326c:	000017b7          	lui	a5,0x1
    80003270:	00f90933          	add	s2,s2,a5
    80003274:	fddff06f          	j	80003250 <_ZN5RiscV10initializeEv+0x1b4>
    }

    for(uint64 i = bEnd;i<hEnd;i+=0x1000){
        handlePageFault(kPMT,i, 0x17);
    80003278:	01700613          	li	a2,23
    8000327c:	00048593          	mv	a1,s1
    80003280:	00005517          	auipc	a0,0x5
    80003284:	b3853503          	ld	a0,-1224(a0) # 80007db8 <_ZN5RiscV4kPMTE>
    80003288:	00000097          	auipc	ra,0x0
    8000328c:	d2c080e7          	jalr	-724(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    for(uint64 i = bEnd;i<hEnd;i+=0x1000){
    80003290:	000017b7          	lui	a5,0x1
    80003294:	00f484b3          	add	s1,s1,a5
    80003298:	ff84e0e3          	bltu	s1,s8,80003278 <_ZN5RiscV10initializeEv+0x1dc>
}

inline void  RiscV::ms_sstatus(uint64 mask) {
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    8000329c:	000407b7          	lui	a5,0x40
    800032a0:	1007a073          	csrs	sstatus,a5
    }


    RiscV::ms_sstatus(1<<18);
    handlePageFault(kPMT, (uint64)CONSOLE_RX_DATA,0xf);
    800032a4:	00005497          	auipc	s1,0x5
    800032a8:	b1448493          	addi	s1,s1,-1260 # 80007db8 <_ZN5RiscV4kPMTE>
    800032ac:	00f00613          	li	a2,15
    800032b0:	00005797          	auipc	a5,0x5
    800032b4:	8187b783          	ld	a5,-2024(a5) # 80007ac8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800032b8:	0007b583          	ld	a1,0(a5)
    800032bc:	0004b503          	ld	a0,0(s1)
    800032c0:	00000097          	auipc	ra,0x0
    800032c4:	cf4080e7          	jalr	-780(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)CONSOLE_TX_DATA,0xf);
    800032c8:	00f00613          	li	a2,15
    800032cc:	00005797          	auipc	a5,0x5
    800032d0:	84c7b783          	ld	a5,-1972(a5) # 80007b18 <_GLOBAL_OFFSET_TABLE_+0x58>
    800032d4:	0007b583          	ld	a1,0(a5)
    800032d8:	0004b503          	ld	a0,0(s1)
    800032dc:	00000097          	auipc	ra,0x0
    800032e0:	cd8080e7          	jalr	-808(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)CONSOLE_STATUS,0xf);
    800032e4:	00f00613          	li	a2,15
    800032e8:	00004797          	auipc	a5,0x4
    800032ec:	7e87b783          	ld	a5,2024(a5) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0x10>
    800032f0:	0007b583          	ld	a1,0(a5)
    800032f4:	0004b503          	ld	a0,0(s1)
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	cbc080e7          	jalr	-836(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
    handlePageFault(kPMT, (uint64)0xc201004,0xf);
    80003300:	00f00613          	li	a2,15
    80003304:	0c2015b7          	lui	a1,0xc201
    80003308:	00458593          	addi	a1,a1,4 # c201004 <_entry-0x73dfeffc>
    8000330c:	0004b503          	ld	a0,0(s1)
    80003310:	00000097          	auipc	ra,0x0
    80003314:	ca4080e7          	jalr	-860(ra) # 80002fb4 <_ZN5RiscV15handlePageFaultEPvmm>
//    ConsoleUtil::print("uDataEnd:", uDataEnd, "\n");
//    ConsoleUtil::print("hStart:", hStart, "\n");
//    ConsoleUtil::print("bEnd:", bEnd, "\n");
//    ConsoleUtil::print("hEnd:", hEnd, "\n");

    uint64 satp = ((uint64)1<<63) | ((uint64)(RiscV::kPMT)>>12);
    80003318:	0004b783          	ld	a5,0(s1)
    8000331c:	00c7d793          	srli	a5,a5,0xc
    80003320:	fff00713          	li	a4,-1
    80003324:	03f71713          	slli	a4,a4,0x3f
    80003328:	00e7e7b3          	or	a5,a5,a4
    asm("csrw satp, %[satp]" : : [satp] "r" (satp));
    8000332c:	18079073          	csrw	satp,a5
inline void  RiscV::mc_sip(uint64 mask) {
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
}

inline void  RiscV::ms_sie(uint64 mask) {
    asm("csrs sie, %[mask]" : : [mask] "r" (mask));
    80003330:	00200793          	li	a5,2
    80003334:	1047a073          	csrs	sie,a5
    80003338:	20000713          	li	a4,512
    8000333c:	10472073          	csrs	sie,a4
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    80003340:	1007a073          	csrs	sstatus,a5

    RiscV::enableInterrupts();
//    RiscV::enableHardwareInterrupts();
}
    80003344:	04813083          	ld	ra,72(sp)
    80003348:	04013403          	ld	s0,64(sp)
    8000334c:	03813483          	ld	s1,56(sp)
    80003350:	03013903          	ld	s2,48(sp)
    80003354:	02813983          	ld	s3,40(sp)
    80003358:	02013a03          	ld	s4,32(sp)
    8000335c:	01813a83          	ld	s5,24(sp)
    80003360:	01013b03          	ld	s6,16(sp)
    80003364:	00813b83          	ld	s7,8(sp)
    80003368:	00013c03          	ld	s8,0(sp)
    8000336c:	05010113          	addi	sp,sp,80
    80003370:	00008067          	ret

0000000080003374 <_ZN5RiscV10popSppSpieEv>:

//get previous privilege and previous interrupt status
void RiscV::popSppSpie() {
    80003374:	ff010113          	addi	sp,sp,-16
    80003378:	00813423          	sd	s0,8(sp)
    8000337c:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    80003380:	00004797          	auipc	a5,0x4
    80003384:	7f07b783          	ld	a5,2032(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003388:	0007b783          	ld	a5,0(a5)
    8000338c:	0147a683          	lw	a3,20(a5)
    80003390:	00100713          	li	a4,1
    80003394:	02e68863          	beq	a3,a4,800033c4 <_ZN5RiscV10popSppSpieEv+0x50>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)TCBWrapper::tcbWrap;
        asm("mv a0, %[iarg]" : : [iarg] "r" (TCB::running->body));
    80003398:	0187b703          	ld	a4,24(a5)
    8000339c:	00070513          	mv	a0,a4
        asm("mv a1, %[iarg]" : : [iarg] "r" (TCB::running->args));
    800033a0:	0207b783          	ld	a5,32(a5)
    800033a4:	00078593          	mv	a1,a5
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    800033a8:	00004797          	auipc	a5,0x4
    800033ac:	7587b783          	ld	a5,1880(a5) # 80007b00 <_GLOBAL_OFFSET_TABLE_+0x40>
    800033b0:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    800033b4:	10200073          	sret
}
    800033b8:	00813403          	ld	s0,8(sp)
    800033bc:	01010113          	addi	sp,sp,16
    800033c0:	00008067          	ret
        asm("csrw sepc, ra");
    800033c4:	14109073          	csrw	sepc,ra
    800033c8:	fedff06f          	j	800033b4 <_ZN5RiscV10popSppSpieEv+0x40>

00000000800033cc <_ZN5RiscV11popSppSpie2Ev>:

void RiscV::popSppSpie2() {
    800033cc:	ff010113          	addi	sp,sp,-16
    800033d0:	00813423          	sd	s0,8(sp)
    800033d4:	01010413          	addi	s0,sp,16
    uint64 ra = 0;
    if(TCB::running->mode == TCB::Mode::SUPERVISOR)
    800033d8:	00004797          	auipc	a5,0x4
    800033dc:	7987b783          	ld	a5,1944(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800033e0:	0007b783          	ld	a5,0(a5)
    800033e4:	0147a703          	lw	a4,20(a5)
    800033e8:	00100793          	li	a5,1
    800033ec:	02f70063          	beq	a4,a5,8000340c <_ZN5RiscV11popSppSpie2Ev+0x40>
        asm("csrw sepc, ra");
    else
    {
        ra = (uint64)TCBWrapper::tcbWrap;
    800033f0:	00004797          	auipc	a5,0x4
    800033f4:	7107b783          	ld	a5,1808(a5) # 80007b00 <_GLOBAL_OFFSET_TABLE_+0x40>
        asm("csrw sepc, %[ra]" : : [ra] "r" (ra));
    800033f8:	14179073          	csrw	sepc,a5
    }
    asm("sret");
    800033fc:	10200073          	sret
}
    80003400:	00813403          	ld	s0,8(sp)
    80003404:	01010113          	addi	sp,sp,16
    80003408:	00008067          	ret
        asm("csrw sepc, ra");
    8000340c:	14109073          	csrw	sepc,ra
    80003410:	fedff06f          	j	800033fc <_ZN5RiscV11popSppSpie2Ev+0x30>

0000000080003414 <_ZN5RiscV28executeThreadDispatchSyscallEv>:
    asm("mv a0, %[status]" : : [status] "r" (status));

    RiscV::saveA0toSscratch();
}

void RiscV::executeThreadDispatchSyscall(){
    80003414:	ff010113          	addi	sp,sp,-16
    80003418:	00113423          	sd	ra,8(sp)
    8000341c:	00813023          	sd	s0,0(sp)
    80003420:	01010413          	addi	s0,sp,16

    //dispatch current running thread
    TCB* old = TCB::running;
    80003424:	00004797          	auipc	a5,0x4
    80003428:	74c7b783          	ld	a5,1868(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    8000342c:	0007b783          	ld	a5,0(a5)
    old->status = TCB::Status::READY;
    80003430:	00100713          	li	a4,1
    80003434:	00e7a823          	sw	a4,16(a5)
    TCB::dispatch();
    80003438:	fffff097          	auipc	ra,0xfffff
    8000343c:	480080e7          	jalr	1152(ra) # 800028b8 <_ZN3TCB8dispatchEv>
}
    80003440:	00813083          	ld	ra,8(sp)
    80003444:	00013403          	ld	s0,0(sp)
    80003448:	01010113          	addi	sp,sp,16
    8000344c:	00008067          	ret

0000000080003450 <_ZN5RiscV18executePutcSyscallEv>:
    asm("mv a0, %[c]" : : [c] "r" (c));

    RiscV::saveA0toSscratch();
}

void RiscV::executePutcSyscall() {
    80003450:	ff010113          	addi	sp,sp,-16
    80003454:	00113423          	sd	ra,8(sp)
    80003458:	00813023          	sd	s0,0(sp)
    8000345c:	01010413          	addi	s0,sp,16

    //register a pending putc call
    if(!userMainFinished)
    80003460:	00005797          	auipc	a5,0x5
    80003464:	9607c783          	lbu	a5,-1696(a5) # 80007dc0 <_ZN5RiscV16userMainFinishedE>
    80003468:	00079c63          	bnez	a5,80003480 <_ZN5RiscV18executePutcSyscallEv+0x30>
        ConsoleUtil::pendingPutc++;
    8000346c:	00004717          	auipc	a4,0x4
    80003470:	6fc73703          	ld	a4,1788(a4) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003474:	00073783          	ld	a5,0(a4)
    80003478:	00178793          	addi	a5,a5,1
    8000347c:	00f73023          	sd	a5,0(a4)

    char c;

    asm("mv %[c], a1" : [c] "=r"(c));
    80003480:	00058513          	mv	a0,a1

    //put character in output buffer
    ConsoleUtil::putOutput(c);
    80003484:	0ff57513          	andi	a0,a0,255
    80003488:	00001097          	auipc	ra,0x1
    8000348c:	32c080e7          	jalr	812(ra) # 800047b4 <_ZN11ConsoleUtil9putOutputEc>
}
    80003490:	00813083          	ld	ra,8(sp)
    80003494:	00013403          	ld	s0,0(sp)
    80003498:	01010113          	addi	sp,sp,16
    8000349c:	00008067          	ret

00000000800034a0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>:

    RiscV::saveA0toSscratch();
}

//return to privilege that was given at creation
void RiscV::jumpToDesignatedPrivilegeMode() {
    800034a0:	ff010113          	addi	sp,sp,-16
    800034a4:	00813423          	sd	s0,8(sp)
    800034a8:	01010413          	addi	s0,sp,16
    if(TCB::running->mode == TCB::Mode::SUPERVISOR) {
    800034ac:	00004797          	auipc	a5,0x4
    800034b0:	6c47b783          	ld	a5,1732(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800034b4:	0007b783          	ld	a5,0(a5)
    800034b8:	0147a703          	lw	a4,20(a5)
    800034bc:	00100793          	li	a5,1
    800034c0:	00f70c63          	beq	a4,a5,800034d8 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x38>
    asm("csrc sstatus, %[mask]" : : [mask] "r" (mask));
    800034c4:	10000793          	li	a5,256
    800034c8:	1007b073          	csrc	sstatus,a5
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    }
    else {
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    }
}
    800034cc:	00813403          	ld	s0,8(sp)
    800034d0:	01010113          	addi	sp,sp,16
    800034d4:	00008067          	ret
    asm("csrs sstatus, %[mask]" : : [mask] "r" (mask));
    800034d8:	10000793          	li	a5,256
    800034dc:	1007a073          	csrs	sstatus,a5
}
    800034e0:	fedff06f          	j	800034cc <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv+0x2c>

00000000800034e4 <_ZN5RiscV8finalizeEv>:


//clear out the scheduler and let console finish remaining outputs if there are any
void RiscV::finalize() {
    800034e4:	ff010113          	addi	sp,sp,-16
    800034e8:	00113423          	sd	ra,8(sp)
    800034ec:	00813023          	sd	s0,0(sp)
    800034f0:	01010413          	addi	s0,sp,16
    userMainFinished = true;
    800034f4:	00100793          	li	a5,1
    800034f8:	00005717          	auipc	a4,0x5
    800034fc:	8cf70423          	sb	a5,-1848(a4) # 80007dc0 <_ZN5RiscV16userMainFinishedE>

    ConsoleUtil::pendingPutc = 0;
    80003500:	00004797          	auipc	a5,0x4
    80003504:	6687b783          	ld	a5,1640(a5) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80003508:	0007b023          	sd	zero,0(a5)
    ConsoleUtil::pendingGetc = 0;
    8000350c:	00004797          	auipc	a5,0x4
    80003510:	6147b783          	ld	a5,1556(a5) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003514:	0007b023          	sd	zero,0(a5)
}

inline void  RiscV::mc_sie(uint64 mask){
    asm("csrc sie, %[mask]" : : [mask] "r" (mask));
    80003518:	00200793          	li	a5,2
    8000351c:	1047b073          	csrc	sie,a5
    80003520:	20000793          	li	a5,512
    80003524:	1047b073          	csrc	sie,a5

    RiscV::disableInterrupts();

    while(Scheduler::readyHead != nullptr)
    80003528:	00004797          	auipc	a5,0x4
    8000352c:	6187b783          	ld	a5,1560(a5) # 80007b40 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003530:	0007b783          	ld	a5,0(a5)
    80003534:	00078c63          	beqz	a5,8000354c <_ZN5RiscV8finalizeEv+0x68>
        Scheduler::readyHead = Scheduler::readyHead->next;
    80003538:	0487b703          	ld	a4,72(a5)
    8000353c:	00004797          	auipc	a5,0x4
    80003540:	6047b783          	ld	a5,1540(a5) # 80007b40 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003544:	00e7b023          	sd	a4,0(a5)
    while(Scheduler::readyHead != nullptr)
    80003548:	fe1ff06f          	j	80003528 <_ZN5RiscV8finalizeEv+0x44>

    Scheduler::put(TCB::putcThread);
    8000354c:	00004797          	auipc	a5,0x4
    80003550:	5fc7b783          	ld	a5,1532(a5) # 80007b48 <_GLOBAL_OFFSET_TABLE_+0x88>
    80003554:	0007b503          	ld	a0,0(a5)
    80003558:	00001097          	auipc	ra,0x1
    8000355c:	ec0080e7          	jalr	-320(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>

    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003560:	00004797          	auipc	a5,0x4
    80003564:	5f87b783          	ld	a5,1528(a5) # 80007b58 <_GLOBAL_OFFSET_TABLE_+0x98>
    80003568:	0007b703          	ld	a4,0(a5)
    8000356c:	00004797          	auipc	a5,0x4
    80003570:	5f47b783          	ld	a5,1524(a5) # 80007b60 <_GLOBAL_OFFSET_TABLE_+0xa0>
    80003574:	0007b783          	ld	a5,0(a5)
    80003578:	00f70863          	beq	a4,a5,80003588 <_ZN5RiscV8finalizeEv+0xa4>
        TCB::dispatch();
    8000357c:	fffff097          	auipc	ra,0xfffff
    80003580:	33c080e7          	jalr	828(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    while(ConsoleUtil::outputHead != ConsoleUtil::outputTail)
    80003584:	fddff06f          	j	80003560 <_ZN5RiscV8finalizeEv+0x7c>
}
    80003588:	00813083          	ld	ra,8(sp)
    8000358c:	00013403          	ld	s0,0(sp)
    80003590:	01010113          	addi	sp,sp,16
    80003594:	00008067          	ret

0000000080003598 <_ZN5RiscV16saveA0toSscratchEv>:

//write value in a0 to a memory location where a0 is store on stack for currently running thread
void RiscV::saveA0toSscratch()
{
    80003598:	ff010113          	addi	sp,sp,-16
    8000359c:	00813423          	sd	s0,8(sp)
    800035a0:	01010413          	addi	s0,sp,16
    uint64 a1;
    asm("mv %[a1], a1": [a1] "=r"(a1));
    800035a4:	00058793          	mv	a5,a1
    asm("mv a1, %[a0]" : :  [a0] "r"(TCB::running->a0Location));
    800035a8:	00004717          	auipc	a4,0x4
    800035ac:	5c873703          	ld	a4,1480(a4) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800035b0:	00073703          	ld	a4,0(a4)
    800035b4:	06873703          	ld	a4,104(a4)
    800035b8:	00070593          	mv	a1,a4
    asm("sd a0, 80(a1)");
    800035bc:	04a5b823          	sd	a0,80(a1)
    asm("mv a1,%[a1]"::  [a1]"r"(a1));
    800035c0:	00078593          	mv	a1,a5
}
    800035c4:	00813403          	ld	s0,8(sp)
    800035c8:	01010113          	addi	sp,sp,16
    800035cc:	00008067          	ret

00000000800035d0 <_ZN5RiscV22executeMemAllocSyscallEv>:
void RiscV::executeMemAllocSyscall(){
    800035d0:	ff010113          	addi	sp,sp,-16
    800035d4:	00113423          	sd	ra,8(sp)
    800035d8:	00813023          	sd	s0,0(sp)
    800035dc:	01010413          	addi	s0,sp,16
    asm("mv %[size], a1" : [size] "=r" (size));
    800035e0:	00058513          	mv	a0,a1
    uint64 addr =(uint64)MemoryAllocator::kmalloc(size);
    800035e4:	fffff097          	auipc	ra,0xfffff
    800035e8:	558080e7          	jalr	1368(ra) # 80002b3c <_ZN15MemoryAllocator7kmallocEm>
    asm("mv a0, %[addr]" : : [addr] "r" (addr));
    800035ec:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    800035f0:	00000097          	auipc	ra,0x0
    800035f4:	fa8080e7          	jalr	-88(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    800035f8:	00813083          	ld	ra,8(sp)
    800035fc:	00013403          	ld	s0,0(sp)
    80003600:	01010113          	addi	sp,sp,16
    80003604:	00008067          	ret

0000000080003608 <_ZN5RiscV21executeMemFreeSyscallEv>:
void RiscV::executeMemFreeSyscall() {
    80003608:	ff010113          	addi	sp,sp,-16
    8000360c:	00113423          	sd	ra,8(sp)
    80003610:	00813023          	sd	s0,0(sp)
    80003614:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::initialized) {
    80003618:	00004797          	auipc	a5,0x4
    8000361c:	5687b783          	ld	a5,1384(a5) # 80007b80 <_GLOBAL_OFFSET_TABLE_+0xc0>
    80003620:	0007c783          	lbu	a5,0(a5)
    80003624:	02079263          	bnez	a5,80003648 <_ZN5RiscV21executeMemFreeSyscallEv+0x40>
        status = -1;
    80003628:	fff00513          	li	a0,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    8000362c:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003630:	00000097          	auipc	ra,0x0
    80003634:	f68080e7          	jalr	-152(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003638:	00813083          	ld	ra,8(sp)
    8000363c:	00013403          	ld	s0,0(sp)
    80003640:	01010113          	addi	sp,sp,16
    80003644:	00008067          	ret
        asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003648:	00058513          	mv	a0,a1
        status = MemoryAllocator::kfree((void *) iaddr);;
    8000364c:	fffff097          	auipc	ra,0xfffff
    80003650:	728080e7          	jalr	1832(ra) # 80002d74 <_ZN15MemoryAllocator5kfreeEPv>
    80003654:	fd9ff06f          	j	8000362c <_ZN5RiscV21executeMemFreeSyscallEv+0x24>

0000000080003658 <_ZN5RiscV26executeThreadCreateSyscallEv>:
void RiscV::executeThreadCreateSyscall(){
    80003658:	fc010113          	addi	sp,sp,-64
    8000365c:	02113c23          	sd	ra,56(sp)
    80003660:	02813823          	sd	s0,48(sp)
    80003664:	02913423          	sd	s1,40(sp)
    80003668:	03213023          	sd	s2,32(sp)
    8000366c:	01313c23          	sd	s3,24(sp)
    80003670:	01413823          	sd	s4,16(sp)
    80003674:	01513423          	sd	s5,8(sp)
    80003678:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    8000367c:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003680:	00058913          	mv	s2,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003684:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    80003688:	00068a13          	mv	s4,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    8000368c:	07000513          	li	a0,112
    80003690:	fffff097          	auipc	ra,0xfffff
    80003694:	2a8080e7          	jalr	680(ra) # 80002938 <_ZN3TCBnwEm>
    80003698:	00050493          	mv	s1,a0
    8000369c:	00050e63          	beqz	a0,800036b8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x60>
    800036a0:	00200713          	li	a4,2
    800036a4:	000a8693          	mv	a3,s5
    800036a8:	000a0613          	mv	a2,s4
    800036ac:	00098593          	mv	a1,s3
    800036b0:	fffff097          	auipc	ra,0xfffff
    800036b4:	14c080e7          	jalr	332(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    800036b8:	04048863          	beqz	s1,80003708 <_ZN5RiscV26executeThreadCreateSyscallEv+0xb0>
        if(tcb->body)
    800036bc:	0184b783          	ld	a5,24(s1)
    800036c0:	00078863          	beqz	a5,800036d0 <_ZN5RiscV26executeThreadCreateSyscallEv+0x78>
            Scheduler::put(tcb);
    800036c4:	00048513          	mv	a0,s1
    800036c8:	00001097          	auipc	ra,0x1
    800036cc:	d50080e7          	jalr	-688(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
        *((TCB**)ihandle) = tcb;
    800036d0:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800036d4:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800036d8:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800036dc:	00000097          	auipc	ra,0x0
    800036e0:	ebc080e7          	jalr	-324(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    800036e4:	03813083          	ld	ra,56(sp)
    800036e8:	03013403          	ld	s0,48(sp)
    800036ec:	02813483          	ld	s1,40(sp)
    800036f0:	02013903          	ld	s2,32(sp)
    800036f4:	01813983          	ld	s3,24(sp)
    800036f8:	01013a03          	ld	s4,16(sp)
    800036fc:	00813a83          	ld	s5,8(sp)
    80003700:	04010113          	addi	sp,sp,64
    80003704:	00008067          	ret
        status = -1;
    80003708:	fff00793          	li	a5,-1
    8000370c:	fcdff06f          	j	800036d8 <_ZN5RiscV26executeThreadCreateSyscallEv+0x80>
    80003710:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003714:	00048513          	mv	a0,s1
    80003718:	fffff097          	auipc	ra,0xfffff
    8000371c:	344080e7          	jalr	836(ra) # 80002a5c <_ZN3TCBdlEPv>
    80003720:	00090513          	mv	a0,s2
    80003724:	00009097          	auipc	ra,0x9
    80003728:	7d4080e7          	jalr	2004(ra) # 8000cef8 <_Unwind_Resume>

000000008000372c <_ZN5RiscV30executeThreadAttachBodySyscallEv>:
void RiscV::executeThreadAttachBodySyscall(){
    8000372c:	fc010113          	addi	sp,sp,-64
    80003730:	02113c23          	sd	ra,56(sp)
    80003734:	02813823          	sd	s0,48(sp)
    80003738:	02913423          	sd	s1,40(sp)
    8000373c:	03213023          	sd	s2,32(sp)
    80003740:	01313c23          	sd	s3,24(sp)
    80003744:	01413823          	sd	s4,16(sp)
    80003748:	01513423          	sd	s5,8(sp)
    8000374c:	04010413          	addi	s0,sp,64
    asm("mv %[istack], a7" : [istack] "=r"(istack));
    80003750:	00088a93          	mv	s5,a7
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003754:	00058a13          	mv	s4,a1
    asm("mv %[iroutine], a2" : [iroutine] "=r"(iroutine));
    80003758:	00060993          	mv	s3,a2
    asm("mv %[iargs], a3" : [iargs] "=r"(iargs));
    8000375c:	00068913          	mv	s2,a3
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    80003760:	07000513          	li	a0,112
    80003764:	fffff097          	auipc	ra,0xfffff
    80003768:	1d4080e7          	jalr	468(ra) # 80002938 <_ZN3TCBnwEm>
    8000376c:	00050493          	mv	s1,a0
    80003770:	00050e63          	beqz	a0,8000378c <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x60>
    80003774:	00200713          	li	a4,2
    80003778:	000a8693          	mv	a3,s5
    8000377c:	00090613          	mv	a2,s2
    80003780:	00098593          	mv	a1,s3
    80003784:	fffff097          	auipc	ra,0xfffff
    80003788:	078080e7          	jalr	120(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>
    if(tcb == nullptr){
    8000378c:	04048263          	beqz	s1,800037d0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0xa4>
        tcb->body = (TCB::Body)iroutine;
    80003790:	0134bc23          	sd	s3,24(s1)
        tcb->args = (void*)iargs;
    80003794:	0324b023          	sd	s2,32(s1)
        *((TCB**)ihandle) = tcb;
    80003798:	009a3023          	sd	s1,0(s4)
    uint64 status = 0;
    8000379c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800037a0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800037a4:	00000097          	auipc	ra,0x0
    800037a8:	df4080e7          	jalr	-524(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    800037ac:	03813083          	ld	ra,56(sp)
    800037b0:	03013403          	ld	s0,48(sp)
    800037b4:	02813483          	ld	s1,40(sp)
    800037b8:	02013903          	ld	s2,32(sp)
    800037bc:	01813983          	ld	s3,24(sp)
    800037c0:	01013a03          	ld	s4,16(sp)
    800037c4:	00813a83          	ld	s5,8(sp)
    800037c8:	04010113          	addi	sp,sp,64
    800037cc:	00008067          	ret
        status = -1;
    800037d0:	fff00793          	li	a5,-1
    800037d4:	fcdff06f          	j	800037a0 <_ZN5RiscV30executeThreadAttachBodySyscallEv+0x74>
    800037d8:	00050913          	mv	s2,a0
    TCB *tcb = new TCB((TCB::Body)iroutine, (void*)iargs, (uint64*)istack, DEFAULT_TIME_SLICE);
    800037dc:	00048513          	mv	a0,s1
    800037e0:	fffff097          	auipc	ra,0xfffff
    800037e4:	27c080e7          	jalr	636(ra) # 80002a5c <_ZN3TCBdlEPv>
    800037e8:	00090513          	mv	a0,s2
    800037ec:	00009097          	auipc	ra,0x9
    800037f0:	70c080e7          	jalr	1804(ra) # 8000cef8 <_Unwind_Resume>

00000000800037f4 <_ZN5RiscV25executeThreadStartSyscallEv>:
void RiscV::executeThreadStartSyscall(){
    800037f4:	ff010113          	addi	sp,sp,-16
    800037f8:	00113423          	sd	ra,8(sp)
    800037fc:	00813023          	sd	s0,0(sp)
    80003800:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003804:	00058513          	mv	a0,a1
    if(tcb == nullptr){
    80003808:	02051263          	bnez	a0,8000382c <_ZN5RiscV25executeThreadStartSyscallEv+0x38>
        status = -1;
    8000380c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003810:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003814:	00000097          	auipc	ra,0x0
    80003818:	d84080e7          	jalr	-636(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000381c:	00813083          	ld	ra,8(sp)
    80003820:	00013403          	ld	s0,0(sp)
    80003824:	01010113          	addi	sp,sp,16
    80003828:	00008067          	ret
        tcb->status = TCB::Status::READY;
    8000382c:	00100793          	li	a5,1
    80003830:	00f52823          	sw	a5,16(a0)
        Scheduler::put(tcb);
    80003834:	00001097          	auipc	ra,0x1
    80003838:	be4080e7          	jalr	-1052(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
        TCB::dispatch();
    8000383c:	fffff097          	auipc	ra,0xfffff
    80003840:	07c080e7          	jalr	124(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    80003844:	00000793          	li	a5,0
    80003848:	fc9ff06f          	j	80003810 <_ZN5RiscV25executeThreadStartSyscallEv+0x1c>

000000008000384c <_ZN5RiscV24executeThreadExitSyscallEv>:
void RiscV::executeThreadExitSyscall() {
    8000384c:	ff010113          	addi	sp,sp,-16
    80003850:	00113423          	sd	ra,8(sp)
    80003854:	00813023          	sd	s0,0(sp)
    80003858:	01010413          	addi	s0,sp,16
    if(TCB::running == nullptr){
    8000385c:	00004797          	auipc	a5,0x4
    80003860:	3147b783          	ld	a5,788(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003864:	0007b783          	ld	a5,0(a5)
    80003868:	02078a63          	beqz	a5,8000389c <_ZN5RiscV24executeThreadExitSyscallEv+0x50>
        old->status = TCB::Status::FINISHED;
    8000386c:	00200713          	li	a4,2
    80003870:	00e7a823          	sw	a4,16(a5)
        TCB::dispatch();
    80003874:	fffff097          	auipc	ra,0xfffff
    80003878:	044080e7          	jalr	68(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    uint64 status = 0;
    8000387c:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003880:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003884:	00000097          	auipc	ra,0x0
    80003888:	d14080e7          	jalr	-748(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000388c:	00813083          	ld	ra,8(sp)
    80003890:	00013403          	ld	s0,0(sp)
    80003894:	01010113          	addi	sp,sp,16
    80003898:	00008067          	ret
        status = -1;
    8000389c:	fff00793          	li	a5,-1
    800038a0:	fe1ff06f          	j	80003880 <_ZN5RiscV24executeThreadExitSyscallEv+0x34>

00000000800038a4 <_ZN5RiscV21executeSemOpenSyscallEv>:
void RiscV::executeSemOpenSyscall() {
    800038a4:	fd010113          	addi	sp,sp,-48
    800038a8:	02113423          	sd	ra,40(sp)
    800038ac:	02813023          	sd	s0,32(sp)
    800038b0:	00913c23          	sd	s1,24(sp)
    800038b4:	01213823          	sd	s2,16(sp)
    800038b8:	01313423          	sd	s3,8(sp)
    800038bc:	03010413          	addi	s0,sp,48
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800038c0:	00058913          	mv	s2,a1
    asm("mv %[iinit], a2" : [iinit] "=r"(iinit));
    800038c4:	00060993          	mv	s3,a2
    SCB *scb = new SCB(iinit);
    800038c8:	01800513          	li	a0,24
    800038cc:	fffff097          	auipc	ra,0xfffff
    800038d0:	ddc080e7          	jalr	-548(ra) # 800026a8 <_ZN3SCBnwEm>
    800038d4:	00050493          	mv	s1,a0
    800038d8:	00050863          	beqz	a0,800038e8 <_ZN5RiscV21executeSemOpenSyscallEv+0x44>
    800038dc:	00098593          	mv	a1,s3
    800038e0:	fffff097          	auipc	ra,0xfffff
    800038e4:	c14080e7          	jalr	-1004(ra) # 800024f4 <_ZN3SCBC1Em>
    if(scb == nullptr){
    800038e8:	02048a63          	beqz	s1,8000391c <_ZN5RiscV21executeSemOpenSyscallEv+0x78>
        *((SCB**)ihandle) = scb;
    800038ec:	00993023          	sd	s1,0(s2)
    uint64 status = 0;
    800038f0:	00000793          	li	a5,0
    asm("mv a0, %[status]" : : [status] "r" (status));
    800038f4:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800038f8:	00000097          	auipc	ra,0x0
    800038fc:	ca0080e7          	jalr	-864(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003900:	02813083          	ld	ra,40(sp)
    80003904:	02013403          	ld	s0,32(sp)
    80003908:	01813483          	ld	s1,24(sp)
    8000390c:	01013903          	ld	s2,16(sp)
    80003910:	00813983          	ld	s3,8(sp)
    80003914:	03010113          	addi	sp,sp,48
    80003918:	00008067          	ret
        status = -1;
    8000391c:	fff00793          	li	a5,-1
    80003920:	fd5ff06f          	j	800038f4 <_ZN5RiscV21executeSemOpenSyscallEv+0x50>
    80003924:	00050913          	mv	s2,a0
    SCB *scb = new SCB(iinit);
    80003928:	00048513          	mv	a0,s1
    8000392c:	fffff097          	auipc	ra,0xfffff
    80003930:	dac080e7          	jalr	-596(ra) # 800026d8 <_ZN3SCBdlEPv>
    80003934:	00090513          	mv	a0,s2
    80003938:	00009097          	auipc	ra,0x9
    8000393c:	5c0080e7          	jalr	1472(ra) # 8000cef8 <_Unwind_Resume>

0000000080003940 <_ZN5RiscV22executeSemCloseSyscallEv>:
void RiscV::executeSemCloseSyscall() {
    80003940:	fe010113          	addi	sp,sp,-32
    80003944:	00113c23          	sd	ra,24(sp)
    80003948:	00813823          	sd	s0,16(sp)
    8000394c:	00913423          	sd	s1,8(sp)
    80003950:	02010413          	addi	s0,sp,32
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003954:	00058493          	mv	s1,a1
    if(scb == nullptr){
    80003958:	02049463          	bnez	s1,80003980 <_ZN5RiscV22executeSemCloseSyscallEv+0x40>
        status = -1;
    8000395c:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003960:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003964:	00000097          	auipc	ra,0x0
    80003968:	c34080e7          	jalr	-972(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    8000396c:	01813083          	ld	ra,24(sp)
    80003970:	01013403          	ld	s0,16(sp)
    80003974:	00813483          	ld	s1,8(sp)
    80003978:	02010113          	addi	sp,sp,32
    8000397c:	00008067          	ret
        delete (SCB*)ihandle;
    80003980:	00048513          	mv	a0,s1
    80003984:	fffff097          	auipc	ra,0xfffff
    80003988:	b8c080e7          	jalr	-1140(ra) # 80002510 <_ZN3SCBD1Ev>
    8000398c:	00048513          	mv	a0,s1
    80003990:	fffff097          	auipc	ra,0xfffff
    80003994:	d48080e7          	jalr	-696(ra) # 800026d8 <_ZN3SCBdlEPv>
    uint64 status = 0;
    80003998:	00000793          	li	a5,0
    8000399c:	fc5ff06f          	j	80003960 <_ZN5RiscV22executeSemCloseSyscallEv+0x20>

00000000800039a0 <_ZN5RiscV21executeSemWaitSyscallEv>:
void RiscV::executeSemWaitSyscall() {
    800039a0:	ff010113          	addi	sp,sp,-16
    800039a4:	00113423          	sd	ra,8(sp)
    800039a8:	00813023          	sd	s0,0(sp)
    800039ac:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    800039b0:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    800039b4:	02051c63          	bnez	a0,800039ec <_ZN5RiscV21executeSemWaitSyscallEv+0x4c>
    if(TCB::running->semError != nullptr)
    800039b8:	00004797          	auipc	a5,0x4
    800039bc:	1b87b783          	ld	a5,440(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800039c0:	0007b783          	ld	a5,0(a5)
    800039c4:	0607b783          	ld	a5,96(a5)
    800039c8:	02078863          	beqz	a5,800039f8 <_ZN5RiscV21executeSemWaitSyscallEv+0x58>
        status = -1;
    800039cc:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    800039d0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    800039d4:	00000097          	auipc	ra,0x0
    800039d8:	bc4080e7          	jalr	-1084(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    800039dc:	00813083          	ld	ra,8(sp)
    800039e0:	00013403          	ld	s0,0(sp)
    800039e4:	01010113          	addi	sp,sp,16
    800039e8:	00008067          	ret
        ((SCB*)ihandle)->wait();
    800039ec:	fffff097          	auipc	ra,0xfffff
    800039f0:	c30080e7          	jalr	-976(ra) # 8000261c <_ZN3SCB4waitEv>
    800039f4:	fc5ff06f          	j	800039b8 <_ZN5RiscV21executeSemWaitSyscallEv+0x18>
        status = 0;
    800039f8:	00000793          	li	a5,0
    800039fc:	fd5ff06f          	j	800039d0 <_ZN5RiscV21executeSemWaitSyscallEv+0x30>

0000000080003a00 <_ZN5RiscV23executeSemSignalSyscallEv>:
void RiscV::executeSemSignalSyscall() {
    80003a00:	ff010113          	addi	sp,sp,-16
    80003a04:	00113423          	sd	ra,8(sp)
    80003a08:	00813023          	sd	s0,0(sp)
    80003a0c:	01010413          	addi	s0,sp,16
    asm("mv %[ihandle], a1" : [ihandle] "=r"(ihandle));
    80003a10:	00058513          	mv	a0,a1
    if(((SCB*)ihandle) != nullptr)
    80003a14:	02051263          	bnez	a0,80003a38 <_ZN5RiscV23executeSemSignalSyscallEv+0x38>
        status = -1;
    80003a18:	fff00793          	li	a5,-1
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a1c:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	b78080e7          	jalr	-1160(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003a28:	00813083          	ld	ra,8(sp)
    80003a2c:	00013403          	ld	s0,0(sp)
    80003a30:	01010113          	addi	sp,sp,16
    80003a34:	00008067          	ret
        ((SCB*)ihandle)->signal();
    80003a38:	fffff097          	auipc	ra,0xfffff
    80003a3c:	c34080e7          	jalr	-972(ra) # 8000266c <_ZN3SCB6signalEv>
    uint64 status = 0;
    80003a40:	00000793          	li	a5,0
    80003a44:	fd9ff06f          	j	80003a1c <_ZN5RiscV23executeSemSignalSyscallEv+0x1c>

0000000080003a48 <_ZN5RiscV23executeTimeSleepSyscallEv>:
void RiscV::executeTimeSleepSyscall() {
    80003a48:	fe010113          	addi	sp,sp,-32
    80003a4c:	00113c23          	sd	ra,24(sp)
    80003a50:	00813823          	sd	s0,16(sp)
    80003a54:	00913423          	sd	s1,8(sp)
    80003a58:	02010413          	addi	s0,sp,32
    asm("mv %[itime], a1" : [itime] "=r"(itime));
    80003a5c:	00058713          	mv	a4,a1
    TCB* tcb = TCB::running;
    80003a60:	00004797          	auipc	a5,0x4
    80003a64:	1107b783          	ld	a5,272(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003a68:	0007b483          	ld	s1,0(a5)
    tcb->sleepTime = globalTime;
    80003a6c:	00004797          	auipc	a5,0x4
    80003a70:	35c7b783          	ld	a5,860(a5) # 80007dc8 <_ZN5RiscV10globalTimeE>
    80003a74:	04f4b823          	sd	a5,80(s1)
    tcb->wakeTime = globalTime + itime;
    80003a78:	00e787b3          	add	a5,a5,a4
    80003a7c:	04f4bc23          	sd	a5,88(s1)
    Scheduler::sleep(tcb);
    80003a80:	00048513          	mv	a0,s1
    80003a84:	00001097          	auipc	ra,0x1
    80003a88:	a10080e7          	jalr	-1520(ra) # 80004494 <_ZN9Scheduler5sleepEP3TCB>
    tcb->status = TCB::Status::BLOCKED;
    80003a8c:	00300793          	li	a5,3
    80003a90:	00f4a823          	sw	a5,16(s1)
    TCB::dispatch();
    80003a94:	fffff097          	auipc	ra,0xfffff
    80003a98:	e24080e7          	jalr	-476(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003a9c:	00000793          	li	a5,0
    80003aa0:	00078513          	mv	a0,a5
    RiscV::saveA0toSscratch();
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	af4080e7          	jalr	-1292(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003aac:	01813083          	ld	ra,24(sp)
    80003ab0:	01013403          	ld	s0,16(sp)
    80003ab4:	00813483          	ld	s1,8(sp)
    80003ab8:	02010113          	addi	sp,sp,32
    80003abc:	00008067          	ret

0000000080003ac0 <_ZN5RiscV18executeGetcSyscallEv>:
void RiscV::executeGetcSyscall() {
    80003ac0:	fe010113          	addi	sp,sp,-32
    80003ac4:	00113c23          	sd	ra,24(sp)
    80003ac8:	00813823          	sd	s0,16(sp)
    80003acc:	00913423          	sd	s1,8(sp)
    80003ad0:	02010413          	addi	s0,sp,32
    if(!userMainFinished)
    80003ad4:	00004797          	auipc	a5,0x4
    80003ad8:	2ec7c783          	lbu	a5,748(a5) # 80007dc0 <_ZN5RiscV16userMainFinishedE>
    80003adc:	00079c63          	bnez	a5,80003af4 <_ZN5RiscV18executeGetcSyscallEv+0x34>
        ConsoleUtil::pendingGetc++;
    80003ae0:	00004717          	auipc	a4,0x4
    80003ae4:	04073703          	ld	a4,64(a4) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003ae8:	00073783          	ld	a5,0(a4)
    80003aec:	00178793          	addi	a5,a5,1
    80003af0:	00f73023          	sd	a5,0(a4)
    char c = ConsoleUtil::getInput();
    80003af4:	00001097          	auipc	ra,0x1
    80003af8:	c48080e7          	jalr	-952(ra) # 8000473c <_ZN11ConsoleUtil8getInputEv>
    80003afc:	00050493          	mv	s1,a0
    if(c==13) {
    80003b00:	00d00793          	li	a5,13
    80003b04:	02f50663          	beq	a0,a5,80003b30 <_ZN5RiscV18executeGetcSyscallEv+0x70>
    else if(c!=0x01b)
    80003b08:	01b00793          	li	a5,27
    80003b0c:	04f51063          	bne	a0,a5,80003b4c <_ZN5RiscV18executeGetcSyscallEv+0x8c>
    asm("mv a0, %[c]" : : [c] "r" (c));
    80003b10:	00048513          	mv	a0,s1
    RiscV::saveA0toSscratch();
    80003b14:	00000097          	auipc	ra,0x0
    80003b18:	a84080e7          	jalr	-1404(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b1c:	01813083          	ld	ra,24(sp)
    80003b20:	01013403          	ld	s0,16(sp)
    80003b24:	00813483          	ld	s1,8(sp)
    80003b28:	02010113          	addi	sp,sp,32
    80003b2c:	00008067          	ret
        ConsoleUtil::putOutput(13);
    80003b30:	00d00513          	li	a0,13
    80003b34:	00001097          	auipc	ra,0x1
    80003b38:	c80080e7          	jalr	-896(ra) # 800047b4 <_ZN11ConsoleUtil9putOutputEc>
        ConsoleUtil::putOutput(10);
    80003b3c:	00a00513          	li	a0,10
    80003b40:	00001097          	auipc	ra,0x1
    80003b44:	c74080e7          	jalr	-908(ra) # 800047b4 <_ZN11ConsoleUtil9putOutputEc>
    80003b48:	fc9ff06f          	j	80003b10 <_ZN5RiscV18executeGetcSyscallEv+0x50>
        ConsoleUtil::putOutput(c);
    80003b4c:	00001097          	auipc	ra,0x1
    80003b50:	c68080e7          	jalr	-920(ra) # 800047b4 <_ZN11ConsoleUtil9putOutputEc>
    80003b54:	fbdff06f          	j	80003b10 <_ZN5RiscV18executeGetcSyscallEv+0x50>

0000000080003b58 <_ZN5RiscV22executePutcUtilSyscallEv>:
void RiscV::executePutcUtilSyscall() {
    80003b58:	ff010113          	addi	sp,sp,-16
    80003b5c:	00113423          	sd	ra,8(sp)
    80003b60:	00813023          	sd	s0,0(sp)
    80003b64:	01010413          	addi	s0,sp,16
    char c = ConsoleUtil::getOutput();
    80003b68:	00001097          	auipc	ra,0x1
    80003b6c:	ccc080e7          	jalr	-820(ra) # 80004834 <_ZN11ConsoleUtil9getOutputEv>
    asm("mv a0, %[c]" : : [c] "r" ((uint64)(c)) );
    80003b70:	00050513          	mv	a0,a0
    RiscV::saveA0toSscratch();
    80003b74:	00000097          	auipc	ra,0x0
    80003b78:	a24080e7          	jalr	-1500(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003b7c:	00813083          	ld	ra,8(sp)
    80003b80:	00013403          	ld	s0,0(sp)
    80003b84:	01010113          	addi	sp,sp,16
    80003b88:	00008067          	ret

0000000080003b8c <_ZN5RiscV24executeThreadFreeSyscallEv>:

//syscall to free the space that is allocated for thread
void RiscV::executeThreadFreeSyscall() {
    80003b8c:	fe010113          	addi	sp,sp,-32
    80003b90:	00113c23          	sd	ra,24(sp)
    80003b94:	00813823          	sd	s0,16(sp)
    80003b98:	00913423          	sd	s1,8(sp)
    80003b9c:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003ba0:	00058493          	mv	s1,a1

    TCB *thr = (TCB*)iaddr;

    if(thr == nullptr)
    80003ba4:	02049463          	bnez	s1,80003bcc <_ZN5RiscV24executeThreadFreeSyscallEv+0x40>
        kfree(thr->stack);
        delete thr;
    }

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003ba8:	fff00793          	li	a5,-1
    80003bac:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003bb0:	00000097          	auipc	ra,0x0
    80003bb4:	9e8080e7          	jalr	-1560(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003bb8:	01813083          	ld	ra,24(sp)
    80003bbc:	01013403          	ld	s0,16(sp)
    80003bc0:	00813483          	ld	s1,8(sp)
    80003bc4:	02010113          	addi	sp,sp,32
    80003bc8:	00008067          	ret
        kfree(thr->stack);
    80003bcc:	0284b503          	ld	a0,40(s1)
    80003bd0:	00001097          	auipc	ra,0x1
    80003bd4:	fd8080e7          	jalr	-40(ra) # 80004ba8 <_Z5kfreePKv>
        delete thr;
    80003bd8:	00048513          	mv	a0,s1
    80003bdc:	fffff097          	auipc	ra,0xfffff
    80003be0:	cb4080e7          	jalr	-844(ra) # 80002890 <_ZN3TCBD1Ev>
    80003be4:	00048513          	mv	a0,s1
    80003be8:	fffff097          	auipc	ra,0xfffff
    80003bec:	e74080e7          	jalr	-396(ra) # 80002a5c <_ZN3TCBdlEPv>
    80003bf0:	fb9ff06f          	j	80003ba8 <_ZN5RiscV24executeThreadFreeSyscallEv+0x1c>

0000000080003bf4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>:

//syscall to free the space that is allocated for semaphore
void RiscV::executeSemaphoreFreeSyscall() {
    80003bf4:	fe010113          	addi	sp,sp,-32
    80003bf8:	00113c23          	sd	ra,24(sp)
    80003bfc:	00813823          	sd	s0,16(sp)
    80003c00:	00913423          	sd	s1,8(sp)
    80003c04:	02010413          	addi	s0,sp,32
    uint64 iaddr, status;

    //call internal allocator and free memory which iaddr points to
    asm("mv %[iaddr], a1" : [iaddr] "=r"(iaddr));
    80003c08:	00058493          	mv	s1,a1

    SCB *scb = (SCB*)iaddr;

    if(scb == nullptr){
    80003c0c:	02049463          	bnez	s1,80003c34 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x40>
    }
    else
        delete scb;

    //return status
    asm("mv a0, %[status]" : : [status] "r" (status));
    80003c10:	fff00793          	li	a5,-1
    80003c14:	00078513          	mv	a0,a5

    RiscV::saveA0toSscratch();
    80003c18:	00000097          	auipc	ra,0x0
    80003c1c:	980080e7          	jalr	-1664(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>
}
    80003c20:	01813083          	ld	ra,24(sp)
    80003c24:	01013403          	ld	s0,16(sp)
    80003c28:	00813483          	ld	s1,8(sp)
    80003c2c:	02010113          	addi	sp,sp,32
    80003c30:	00008067          	ret
        delete scb;
    80003c34:	00048513          	mv	a0,s1
    80003c38:	fffff097          	auipc	ra,0xfffff
    80003c3c:	8d8080e7          	jalr	-1832(ra) # 80002510 <_ZN3SCBD1Ev>
    80003c40:	00048513          	mv	a0,s1
    80003c44:	fffff097          	auipc	ra,0xfffff
    80003c48:	a94080e7          	jalr	-1388(ra) # 800026d8 <_ZN3SCBdlEPv>
    80003c4c:	fc5ff06f          	j	80003c10 <_ZN5RiscV27executeSemaphoreFreeSyscallEv+0x1c>

0000000080003c50 <_ZN5RiscV18executeForkSyscallEv>:

//fork syscall
void RiscV::executeForkSyscall() {
    80003c50:	fe010113          	addi	sp,sp,-32
    80003c54:	00113c23          	sd	ra,24(sp)
    80003c58:	00813823          	sd	s0,16(sp)
    80003c5c:	00913423          	sd	s1,8(sp)
    80003c60:	01213023          	sd	s2,0(sp)
    80003c64:	02010413          	addi	s0,sp,32

    //create new stack and copy stack from currently running stack into the new one
    uint64 *stack = (uint64*)kmalloc(DEFAULT_STACK_SIZE);
    80003c68:	00001537          	lui	a0,0x1
    80003c6c:	00001097          	auipc	ra,0x1
    80003c70:	f14080e7          	jalr	-236(ra) # 80004b80 <_Z7kmallocm>
    80003c74:	00050913          	mv	s2,a0

    MemoryAllocator::memcpy((void*)TCB::running->stack,(void*)stack,DEFAULT_STACK_SIZE);
    80003c78:	00004797          	auipc	a5,0x4
    80003c7c:	ef87b783          	ld	a5,-264(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003c80:	0007b783          	ld	a5,0(a5)
    80003c84:	00001637          	lui	a2,0x1
    80003c88:	00050593          	mv	a1,a0
    80003c8c:	0287b503          	ld	a0,40(a5)
    80003c90:	fffff097          	auipc	ra,0xfffff
    80003c94:	298080e7          	jalr	664(ra) # 80002f28 <_ZN15MemoryAllocator6memcpyEPvS0_m>

    //create new TCB for new thread
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003c98:	07000513          	li	a0,112
    80003c9c:	fffff097          	auipc	ra,0xfffff
    80003ca0:	c9c080e7          	jalr	-868(ra) # 80002938 <_ZN3TCBnwEm>
    80003ca4:	00050493          	mv	s1,a0
    80003ca8:	00050e63          	beqz	a0,80003cc4 <_ZN5RiscV18executeForkSyscallEv+0x74>
    80003cac:	00200713          	li	a4,2
    80003cb0:	00090693          	mv	a3,s2
    80003cb4:	00000613          	li	a2,0
    80003cb8:	00000593          	li	a1,0
    80003cbc:	fffff097          	auipc	ra,0xfffff
    80003cc0:	b40080e7          	jalr	-1216(ra) # 800027fc <_ZN3TCBC1EPFvPvES0_Pmm>

    uint64 status = 0;

    if(forked) {
    80003cc4:	0a048e63          	beqz	s1,80003d80 <_ZN5RiscV18executeForkSyscallEv+0x130>

        //set return address where forked thread should return
        forked->context.ra = TCB::currentPC;
    80003cc8:	00004797          	auipc	a5,0x4
    80003ccc:	e707b783          	ld	a5,-400(a5) # 80007b38 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003cd0:	0007b783          	ld	a5,0(a5)
    80003cd4:	00f4b423          	sd	a5,8(s1)

        //set SP value where forked thread's stack starts
        forked->context.sp = (uint64)((char*)stack + TCB::currentSP - (char*)TCB::running->stack);
    80003cd8:	00004797          	auipc	a5,0x4
    80003cdc:	e507b783          	ld	a5,-432(a5) # 80007b28 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003ce0:	0007b783          	ld	a5,0(a5)
    80003ce4:	00f907b3          	add	a5,s2,a5
    80003ce8:	00004717          	auipc	a4,0x4
    80003cec:	e8873703          	ld	a4,-376(a4) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003cf0:	00073683          	ld	a3,0(a4)
    80003cf4:	0286b683          	ld	a3,40(a3)
    80003cf8:	40d787b3          	sub	a5,a5,a3
    80003cfc:	00f4b023          	sd	a5,0(s1)

        //get memory location of where registers are stored from previous context switch
        uint64 registerStartSP = (uint64)((char*)TCB::running->a0Location - (char*)TCB::running->stack + (char*)stack);
    80003d00:	00073783          	ld	a5,0(a4)
    80003d04:	0687b503          	ld	a0,104(a5)
    80003d08:	0287b783          	ld	a5,40(a5)
    80003d0c:	40f50533          	sub	a0,a0,a5
    80003d10:	00a90933          	add	s2,s2,a0

        forked->a0Location = registerStartSP;
    80003d14:	0724b423          	sd	s2,104(s1)

        uint64 a1,a0;

        //write address of stored registers in SP of forked thread so that it can return regularly
        asm("mv %[a1], a1": [a1] "=r"(a1));
    80003d18:	00058693          	mv	a3,a1

        asm("mv %[a0], a0": [a0] "=r"(a0));
    80003d1c:	00050793          	mv	a5,a0

        asm("mv a0,%[a0]"::  [a0]"r"(registerStartSP));
    80003d20:	00090513          	mv	a0,s2

        asm("mv a1, %[a0]" : :  [a0] "r"(registerStartSP));
    80003d24:	00090593          	mv	a1,s2

        asm("sd a0, 16(a1)");
    80003d28:	00a5b823          	sd	a0,16(a1)

        //write 0 in a0 register of forked thread because fork should return 0 in context of child, and thread ID othrewise
        asm("li a0, 0");
    80003d2c:	00000513          	li	a0,0

        asm("sd a0, 80(a1)");
    80003d30:	04a5b823          	sd	a0,80(a1)

        asm("mv a1,%[a1]"::  [a1]"r"(a1));
    80003d34:	00068593          	mv	a1,a3

        asm("mv a0,%[a0]"::  [a0]"r"(a0));
    80003d38:	00078513          	mv	a0,a5

        forked->sepc = TCB::running->sepc;
    80003d3c:	00073783          	ld	a5,0(a4)
    80003d40:	0387b703          	ld	a4,56(a5)
    80003d44:	02e4bc23          	sd	a4,56(s1)

        forked->sstatus = TCB::running->sstatus;
    80003d48:	0407b783          	ld	a5,64(a5)
    80003d4c:	04f4b023          	sd	a5,64(s1)

        //put forked in scheduler
        Scheduler::put(forked);
    80003d50:	00048513          	mv	a0,s1
    80003d54:	00000097          	auipc	ra,0x0
    80003d58:	6c4080e7          	jalr	1732(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
        //return address of forked as thread ID
        status = (uint64)forked;
    }else
        status = -1;

    asm("mv a0, %[status]" : : [status] "r" (status));
    80003d5c:	00048513          	mv	a0,s1

    RiscV::saveA0toSscratch();
    80003d60:	00000097          	auipc	ra,0x0
    80003d64:	838080e7          	jalr	-1992(ra) # 80003598 <_ZN5RiscV16saveA0toSscratchEv>

}
    80003d68:	01813083          	ld	ra,24(sp)
    80003d6c:	01013403          	ld	s0,16(sp)
    80003d70:	00813483          	ld	s1,8(sp)
    80003d74:	00013903          	ld	s2,0(sp)
    80003d78:	02010113          	addi	sp,sp,32
    80003d7c:	00008067          	ret
        status = -1;
    80003d80:	fff00493          	li	s1,-1
    80003d84:	fd9ff06f          	j	80003d5c <_ZN5RiscV18executeForkSyscallEv+0x10c>
    80003d88:	00050913          	mv	s2,a0
    TCB *forked = new TCB(nullptr, nullptr, stack, DEFAULT_TIME_SLICE);
    80003d8c:	00048513          	mv	a0,s1
    80003d90:	fffff097          	auipc	ra,0xfffff
    80003d94:	ccc080e7          	jalr	-820(ra) # 80002a5c <_ZN3TCBdlEPv>
    80003d98:	00090513          	mv	a0,s2
    80003d9c:	00009097          	auipc	ra,0x9
    80003da0:	15c080e7          	jalr	348(ra) # 8000cef8 <_Unwind_Resume>

0000000080003da4 <_ZN5RiscV5getPCEv>:

void RiscV::getPC(){
    80003da4:	ff010113          	addi	sp,sp,-16
    80003da8:	00813423          	sd	s0,8(sp)
    80003dac:	01010413          	addi	s0,sp,16
    uint64 ra;

    asm("mv %[ra], ra" : [ra] "=r"(ra));
    80003db0:	00008793          	mv	a5,ra

    TCB::currentPC = ra + 8;
    80003db4:	00878793          	addi	a5,a5,8
    80003db8:	00004717          	auipc	a4,0x4
    80003dbc:	d8073703          	ld	a4,-640(a4) # 80007b38 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003dc0:	00f73023          	sd	a5,0(a4)
}
    80003dc4:	00813403          	ld	s0,8(sp)
    80003dc8:	01010113          	addi	sp,sp,16
    80003dcc:	00008067          	ret

0000000080003dd0 <_ZN5RiscV20handleSupervisorTrapEv>:
void RiscV::handleSupervisorTrap() {
    80003dd0:	f9010113          	addi	sp,sp,-112
    80003dd4:	06113423          	sd	ra,104(sp)
    80003dd8:	06813023          	sd	s0,96(sp)
    80003ddc:	04913c23          	sd	s1,88(sp)
    80003de0:	07010413          	addi	s0,sp,112
    asm("csrr %[stval], stval" : [stval] "=r" (stval));
    80003de4:	143024f3          	csrr	s1,stval
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003de8:	142027f3          	csrr	a5,scause
    80003dec:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80003df0:	fc843783          	ld	a5,-56(s0)
    uint64 volatile scause = RiscV::r_scause();
    80003df4:	fcf43c23          	sd	a5,-40(s0)
    asm("csrr %[sscratch], sscratch" : [sscratch] "=r" (TCB::running->a0Location));
    80003df8:	00004797          	auipc	a5,0x4
    80003dfc:	d787b783          	ld	a5,-648(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003e00:	0007b783          	ld	a5,0(a5)
    80003e04:	14002773          	csrr	a4,sscratch
    80003e08:	06e7b423          	sd	a4,104(a5)
    if(scause == 0x09 || scause == 0x08) {
    80003e0c:	fd843703          	ld	a4,-40(s0)
    80003e10:	00900793          	li	a5,9
    80003e14:	10f70663          	beq	a4,a5,80003f20 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    80003e18:	fd843703          	ld	a4,-40(s0)
    80003e1c:	00800793          	li	a5,8
    80003e20:	10f70063          	beq	a4,a5,80003f20 <_ZN5RiscV20handleSupervisorTrapEv+0x150>
    else if(scause == (0x01UL<<63 | 0x1)){
    80003e24:	fd843703          	ld	a4,-40(s0)
    80003e28:	fff00793          	li	a5,-1
    80003e2c:	03f79793          	slli	a5,a5,0x3f
    80003e30:	00178793          	addi	a5,a5,1
    80003e34:	26f70463          	beq	a4,a5,8000409c <_ZN5RiscV20handleSupervisorTrapEv+0x2cc>
    else if(scause == (0x01UL<<63 | 0x9)){
    80003e38:	fd843703          	ld	a4,-40(s0)
    80003e3c:	fff00793          	li	a5,-1
    80003e40:	03f79793          	slli	a5,a5,0x3f
    80003e44:	00978793          	addi	a5,a5,9
    80003e48:	2ef70263          	beq	a4,a5,8000412c <_ZN5RiscV20handleSupervisorTrapEv+0x35c>
    else if(scause == 0x02){
    80003e4c:	fd843703          	ld	a4,-40(s0)
    80003e50:	00200793          	li	a5,2
    80003e54:	36f70a63          	beq	a4,a5,800041c8 <_ZN5RiscV20handleSupervisorTrapEv+0x3f8>
        ConsoleUtil::printString("Error: \n");
    80003e58:	00003517          	auipc	a0,0x3
    80003e5c:	53050513          	addi	a0,a0,1328 # 80007388 <CONSOLE_STATUS+0x378>
    80003e60:	00001097          	auipc	ra,0x1
    80003e64:	a4c080e7          	jalr	-1460(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("scause: ");
    80003e68:	00003517          	auipc	a0,0x3
    80003e6c:	53050513          	addi	a0,a0,1328 # 80007398 <CONSOLE_STATUS+0x388>
    80003e70:	00001097          	auipc	ra,0x1
    80003e74:	a3c080e7          	jalr	-1476(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[scause], scause" : [scause] "=r" (scause));
    80003e78:	142027f3          	csrr	a5,scause
    80003e7c:	fcf43823          	sd	a5,-48(s0)
    return scause;
    80003e80:	fd043503          	ld	a0,-48(s0)
        ConsoleUtil::printInt(scause);
    80003e84:	00000613          	li	a2,0
    80003e88:	00a00593          	li	a1,10
    80003e8c:	0005051b          	sext.w	a0,a0
    80003e90:	00001097          	auipc	ra,0x1
    80003e94:	a60080e7          	jalr	-1440(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("sepc: ");
    80003e98:	00003517          	auipc	a0,0x3
    80003e9c:	4c050513          	addi	a0,a0,1216 # 80007358 <CONSOLE_STATUS+0x348>
    80003ea0:	00001097          	auipc	ra,0x1
    80003ea4:	a0c080e7          	jalr	-1524(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003ea8:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    80003eac:	00000613          	li	a2,0
    80003eb0:	01000593          	li	a1,16
    80003eb4:	0005051b          	sext.w	a0,a0
    80003eb8:	00001097          	auipc	ra,0x1
    80003ebc:	a38080e7          	jalr	-1480(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80003ec0:	00003517          	auipc	a0,0x3
    80003ec4:	49050513          	addi	a0,a0,1168 # 80007350 <CONSOLE_STATUS+0x340>
    80003ec8:	00001097          	auipc	ra,0x1
    80003ecc:	9e4080e7          	jalr	-1564(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::print("stvec: ",stval,"\n");
    80003ed0:	01000693          	li	a3,16
    80003ed4:	00003617          	auipc	a2,0x3
    80003ed8:	47c60613          	addi	a2,a2,1148 # 80007350 <CONSOLE_STATUS+0x340>
    80003edc:	0004859b          	sext.w	a1,s1
    80003ee0:	00003517          	auipc	a0,0x3
    80003ee4:	4c850513          	addi	a0,a0,1224 # 800073a8 <CONSOLE_STATUS+0x398>
    80003ee8:	00001097          	auipc	ra,0x1
    80003eec:	ae4080e7          	jalr	-1308(ra) # 800049cc <_ZN11ConsoleUtil5printEPKciS1_i>
        TCB* old = TCB::running;
    80003ef0:	00004797          	auipc	a5,0x4
    80003ef4:	c807b783          	ld	a5,-896(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003ef8:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    80003efc:	00200713          	li	a4,2
    80003f00:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("Exiting thread...\n");
    80003f04:	00003517          	auipc	a0,0x3
    80003f08:	4ac50513          	addi	a0,a0,1196 # 800073b0 <CONSOLE_STATUS+0x3a0>
    80003f0c:	00001097          	auipc	ra,0x1
    80003f10:	9a0080e7          	jalr	-1632(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80003f14:	fffff097          	auipc	ra,0xfffff
    80003f18:	9a4080e7          	jalr	-1628(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    80003f1c:	0800006f          	j	80003f9c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    80003f20:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80003f24:	f8f43c23          	sd	a5,-104(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80003f28:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc()+4;
    80003f2c:	00478793          	addi	a5,a5,4
    80003f30:	faf43023          	sd	a5,-96(s0)
        TCB::running->sepc = sepc;
    80003f34:	00004797          	auipc	a5,0x4
    80003f38:	c3c7b783          	ld	a5,-964(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003f3c:	0007b783          	ld	a5,0(a5)
    80003f40:	fa043703          	ld	a4,-96(s0)
    80003f44:	02e7bc23          	sd	a4,56(a5)
        TCB::running->sstatus = sstatus;
    80003f48:	f9843703          	ld	a4,-104(s0)
    80003f4c:	04e7b023          	sd	a4,64(a5)
        asm("mv %[syscallID], a0" : [syscallID] "=r" (syscallID));
    80003f50:	00050793          	mv	a5,a0
        switch(syscallID){
    80003f54:	06100713          	li	a4,97
    80003f58:	02f76463          	bltu	a4,a5,80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    80003f5c:	00279793          	slli	a5,a5,0x2
    80003f60:	00003717          	auipc	a4,0x3
    80003f64:	46470713          	addi	a4,a4,1124 # 800073c4 <CONSOLE_STATUS+0x3b4>
    80003f68:	00e787b3          	add	a5,a5,a4
    80003f6c:	0007a783          	lw	a5,0(a5)
    80003f70:	00e787b3          	add	a5,a5,a4
    80003f74:	00078067          	jr	a5
            case 0x01 : executeMemAllocSyscall();break;
    80003f78:	fffff097          	auipc	ra,0xfffff
    80003f7c:	658080e7          	jalr	1624(ra) # 800035d0 <_ZN5RiscV22executeMemAllocSyscallEv>
        RiscV::w_sstatus(TCB::running->sstatus);
    80003f80:	00004797          	auipc	a5,0x4
    80003f84:	bf07b783          	ld	a5,-1040(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    80003f88:	0007b783          	ld	a5,0(a5)
    80003f8c:	0407b703          	ld	a4,64(a5)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    80003f90:	10071073          	csrw	sstatus,a4
        RiscV::w_sepc(TCB::running->sepc);
    80003f94:	0387b783          	ld	a5,56(a5)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80003f98:	14179073          	csrw	sepc,a5
    RiscV::jumpToDesignatedPrivilegeMode();
    80003f9c:	fffff097          	auipc	ra,0xfffff
    80003fa0:	504080e7          	jalr	1284(ra) # 800034a0 <_ZN5RiscV29jumpToDesignatedPrivilegeModeEv>
}
    80003fa4:	06813083          	ld	ra,104(sp)
    80003fa8:	06013403          	ld	s0,96(sp)
    80003fac:	05813483          	ld	s1,88(sp)
    80003fb0:	07010113          	addi	sp,sp,112
    80003fb4:	00008067          	ret
            case 0x02 : executeMemFreeSyscall();break;
    80003fb8:	fffff097          	auipc	ra,0xfffff
    80003fbc:	650080e7          	jalr	1616(ra) # 80003608 <_ZN5RiscV21executeMemFreeSyscallEv>
    80003fc0:	fc1ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x11 : executeThreadCreateSyscall();break;
    80003fc4:	fffff097          	auipc	ra,0xfffff
    80003fc8:	694080e7          	jalr	1684(ra) # 80003658 <_ZN5RiscV26executeThreadCreateSyscallEv>
    80003fcc:	fb5ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x12 : executeThreadExitSyscall();break;
    80003fd0:	00000097          	auipc	ra,0x0
    80003fd4:	87c080e7          	jalr	-1924(ra) # 8000384c <_ZN5RiscV24executeThreadExitSyscallEv>
    80003fd8:	fa9ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x13 : executeThreadDispatchSyscall();break;
    80003fdc:	fffff097          	auipc	ra,0xfffff
    80003fe0:	438080e7          	jalr	1080(ra) # 80003414 <_ZN5RiscV28executeThreadDispatchSyscallEv>
    80003fe4:	f9dff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x14 : executeThreadAttachBodySyscall();break;
    80003fe8:	fffff097          	auipc	ra,0xfffff
    80003fec:	744080e7          	jalr	1860(ra) # 8000372c <_ZN5RiscV30executeThreadAttachBodySyscallEv>
    80003ff0:	f91ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x15 : executeThreadStartSyscall();break;
    80003ff4:	00000097          	auipc	ra,0x0
    80003ff8:	800080e7          	jalr	-2048(ra) # 800037f4 <_ZN5RiscV25executeThreadStartSyscallEv>
    80003ffc:	f85ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x21 : executeSemOpenSyscall();break;
    80004000:	00000097          	auipc	ra,0x0
    80004004:	8a4080e7          	jalr	-1884(ra) # 800038a4 <_ZN5RiscV21executeSemOpenSyscallEv>
    80004008:	f79ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x22 : executeSemCloseSyscall();break;
    8000400c:	00000097          	auipc	ra,0x0
    80004010:	934080e7          	jalr	-1740(ra) # 80003940 <_ZN5RiscV22executeSemCloseSyscallEv>
    80004014:	f6dff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x23 : executeSemWaitSyscall();break;
    80004018:	00000097          	auipc	ra,0x0
    8000401c:	988080e7          	jalr	-1656(ra) # 800039a0 <_ZN5RiscV21executeSemWaitSyscallEv>
    80004020:	f61ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x24 : executeSemSignalSyscall();break;
    80004024:	00000097          	auipc	ra,0x0
    80004028:	9dc080e7          	jalr	-1572(ra) # 80003a00 <_ZN5RiscV23executeSemSignalSyscallEv>
    8000402c:	f55ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x31 : executeTimeSleepSyscall();break;
    80004030:	00000097          	auipc	ra,0x0
    80004034:	a18080e7          	jalr	-1512(ra) # 80003a48 <_ZN5RiscV23executeTimeSleepSyscallEv>
    80004038:	f49ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x41 : executeGetcSyscall();break;
    8000403c:	00000097          	auipc	ra,0x0
    80004040:	a84080e7          	jalr	-1404(ra) # 80003ac0 <_ZN5RiscV18executeGetcSyscallEv>
    80004044:	f3dff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x42 : executePutcSyscall();break;
    80004048:	fffff097          	auipc	ra,0xfffff
    8000404c:	408080e7          	jalr	1032(ra) # 80003450 <_ZN5RiscV18executePutcSyscallEv>
    80004050:	f31ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x43 : executePutcUtilSyscall();break;
    80004054:	00000097          	auipc	ra,0x0
    80004058:	b04080e7          	jalr	-1276(ra) # 80003b58 <_ZN5RiscV22executePutcUtilSyscallEv>
    8000405c:	f25ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x51 : executeThreadFreeSyscall();break;
    80004060:	00000097          	auipc	ra,0x0
    80004064:	b2c080e7          	jalr	-1236(ra) # 80003b8c <_ZN5RiscV24executeThreadFreeSyscallEv>
    80004068:	f19ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x52 : executeSemaphoreFreeSyscall();break;
    8000406c:	00000097          	auipc	ra,0x0
    80004070:	b88080e7          	jalr	-1144(ra) # 80003bf4 <_ZN5RiscV27executeSemaphoreFreeSyscallEv>
    80004074:	f0dff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
            case 0x61 : asm("mv %[sp], sp" : [sp] "=r"(TCB::currentSP));
    80004078:	00010793          	mv	a5,sp
    8000407c:	00004717          	auipc	a4,0x4
    80004080:	aac73703          	ld	a4,-1364(a4) # 80007b28 <_GLOBAL_OFFSET_TABLE_+0x68>
    80004084:	00f73023          	sd	a5,0(a4)
                        RiscV::getPC();
    80004088:	00000097          	auipc	ra,0x0
    8000408c:	d1c080e7          	jalr	-740(ra) # 80003da4 <_ZN5RiscV5getPCEv>
                        executeForkSyscall();
    80004090:	00000097          	auipc	ra,0x0
    80004094:	bc0080e7          	jalr	-1088(ra) # 80003c50 <_ZN5RiscV18executeForkSyscallEv>
                        break;
    80004098:	ee9ff06f          	j	80003f80 <_ZN5RiscV20handleSupervisorTrapEv+0x1b0>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    8000409c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    800040a0:	faf43423          	sd	a5,-88(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800040a4:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    800040a8:	faf43823          	sd	a5,-80(s0)
    asm("csrc sip, %[mask]" : : [mask] "r" (mask));
    800040ac:	00200793          	li	a5,2
    800040b0:	1447b073          	csrc	sip,a5
        globalTime += 1;
    800040b4:	00004717          	auipc	a4,0x4
    800040b8:	d0470713          	addi	a4,a4,-764 # 80007db8 <_ZN5RiscV4kPMTE>
    800040bc:	01073783          	ld	a5,16(a4)
    800040c0:	00178793          	addi	a5,a5,1
    800040c4:	00f73823          	sd	a5,16(a4)
        Scheduler::awake();
    800040c8:	00000097          	auipc	ra,0x0
    800040cc:	424080e7          	jalr	1060(ra) # 800044ec <_ZN9Scheduler5awakeEv>
        TCB::timeSliceCounter++;
    800040d0:	00004717          	auipc	a4,0x4
    800040d4:	a1873703          	ld	a4,-1512(a4) # 80007ae8 <_GLOBAL_OFFSET_TABLE_+0x28>
    800040d8:	00073783          	ld	a5,0(a4)
    800040dc:	00178793          	addi	a5,a5,1
    800040e0:	00f73023          	sd	a5,0(a4)
        if(TCB::timeSliceCounter >= TCB::running->timeSlice) {
    800040e4:	00004717          	auipc	a4,0x4
    800040e8:	a8c73703          	ld	a4,-1396(a4) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800040ec:	00073703          	ld	a4,0(a4)
    800040f0:	03073683          	ld	a3,48(a4)
    800040f4:	00d7fc63          	bgeu	a5,a3,8000410c <_ZN5RiscV20handleSupervisorTrapEv+0x33c>
        RiscV::w_sstatus(sstatus);
    800040f8:	fa843783          	ld	a5,-88(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    800040fc:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    80004100:	fb043783          	ld	a5,-80(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    80004104:	14179073          	csrw	sepc,a5
}
    80004108:	e95ff06f          	j	80003f9c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
            TCB::timeSliceCounter = 0;
    8000410c:	00004797          	auipc	a5,0x4
    80004110:	9dc7b783          	ld	a5,-1572(a5) # 80007ae8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80004114:	0007b023          	sd	zero,0(a5)
            old->status = TCB::Status::READY;
    80004118:	00100793          	li	a5,1
    8000411c:	00f72823          	sw	a5,16(a4)
            TCB::dispatch();
    80004120:	ffffe097          	auipc	ra,0xffffe
    80004124:	798080e7          	jalr	1944(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    80004128:	fd1ff06f          	j	800040f8 <_ZN5RiscV20handleSupervisorTrapEv+0x328>
    asm("csrr %[sstatus], sstatus" : [sstatus] "=r" (sstatus));
    8000412c:	100027f3          	csrr	a5,sstatus
        uint64 volatile sstatus = RiscV::r_sstatus();
    80004130:	faf43c23          	sd	a5,-72(s0)
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    80004134:	141027f3          	csrr	a5,sepc
        uint64 volatile sepc = RiscV::r_sepc();
    80004138:	fcf43023          	sd	a5,-64(s0)
        uint64 status = CONSOLE_STATUS;
    8000413c:	00004797          	auipc	a5,0x4
    80004140:	9947b783          	ld	a5,-1644(a5) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004144:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004148:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    8000414c:	00050583          	lb	a1,0(a0)
        asm("mv %[status], a1" : [status] "=r" (status));
    80004150:	00058793          	mv	a5,a1
        if(status & 1UL)
    80004154:	0017f793          	andi	a5,a5,1
    80004158:	02078863          	beqz	a5,80004188 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
            data = CONSOLE_TX_DATA;
    8000415c:	00004797          	auipc	a5,0x4
    80004160:	9bc7b783          	ld	a5,-1604(a5) # 80007b18 <_GLOBAL_OFFSET_TABLE_+0x58>
    80004164:	0007b783          	ld	a5,0(a5)
            asm("mv a0, %[data]" : : [data] "r" (data));
    80004168:	00078513          	mv	a0,a5
            asm("lb a1, 0(a0)");
    8000416c:	00050583          	lb	a1,0(a0)
            asm("mv %[c], a1" : [c] "=r" (c));
    80004170:	00058513          	mv	a0,a1
    80004174:	0ff57513          	andi	a0,a0,255
            if(ConsoleUtil::pendingGetc!=0) {
    80004178:	00004797          	auipc	a5,0x4
    8000417c:	9a87b783          	ld	a5,-1624(a5) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    80004180:	0007b783          	ld	a5,0(a5)
    80004184:	02079463          	bnez	a5,800041ac <_ZN5RiscV20handleSupervisorTrapEv+0x3dc>
        plic_complete(plic_claim());
    80004188:	00001097          	auipc	ra,0x1
    8000418c:	29c080e7          	jalr	668(ra) # 80005424 <plic_claim>
    80004190:	00001097          	auipc	ra,0x1
    80004194:	2cc080e7          	jalr	716(ra) # 8000545c <plic_complete>
        RiscV::w_sstatus(sstatus);
    80004198:	fb843783          	ld	a5,-72(s0)
    asm("csrw sstatus, %[sstatus]" : : [sstatus] "r" (sstatus));
    8000419c:	10079073          	csrw	sstatus,a5
        RiscV::w_sepc(sepc);
    800041a0:	fc043783          	ld	a5,-64(s0)
    asm("csrw sepc, %[sepc]" : : [sepc] "r" (sepc));
    800041a4:	14179073          	csrw	sepc,a5
}
    800041a8:	df5ff06f          	j	80003f9c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>
                ConsoleUtil::pendingGetc--;
    800041ac:	fff78793          	addi	a5,a5,-1
    800041b0:	00004717          	auipc	a4,0x4
    800041b4:	97073703          	ld	a4,-1680(a4) # 80007b20 <_GLOBAL_OFFSET_TABLE_+0x60>
    800041b8:	00f73023          	sd	a5,0(a4)
                ConsoleUtil::putInput(c);
    800041bc:	00000097          	auipc	ra,0x0
    800041c0:	510080e7          	jalr	1296(ra) # 800046cc <_ZN11ConsoleUtil8putInputEc>
    800041c4:	fc5ff06f          	j	80004188 <_ZN5RiscV20handleSupervisorTrapEv+0x3b8>
        TCB* old = TCB::running;
    800041c8:	00004797          	auipc	a5,0x4
    800041cc:	9a87b783          	ld	a5,-1624(a5) # 80007b70 <_GLOBAL_OFFSET_TABLE_+0xb0>
    800041d0:	0007b783          	ld	a5,0(a5)
        old->status = TCB::Status::FINISHED;
    800041d4:	00200713          	li	a4,2
    800041d8:	00e7a823          	sw	a4,16(a5)
        ConsoleUtil::printString("sepc: ");
    800041dc:	00003517          	auipc	a0,0x3
    800041e0:	17c50513          	addi	a0,a0,380 # 80007358 <CONSOLE_STATUS+0x348>
    800041e4:	00000097          	auipc	ra,0x0
    800041e8:	6c8080e7          	jalr	1736(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    asm("csrr %[sepc], sepc" : [sepc] "=r" (sepc));
    800041ec:	14102573          	csrr	a0,sepc
        ConsoleUtil::printInt(sepc,16);
    800041f0:	00000613          	li	a2,0
    800041f4:	01000593          	li	a1,16
    800041f8:	0005051b          	sext.w	a0,a0
    800041fc:	00000097          	auipc	ra,0x0
    80004200:	6f4080e7          	jalr	1780(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004204:	00003517          	auipc	a0,0x3
    80004208:	14c50513          	addi	a0,a0,332 # 80007350 <CONSOLE_STATUS+0x340>
    8000420c:	00000097          	auipc	ra,0x0
    80004210:	6a0080e7          	jalr	1696(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        ConsoleUtil::printString("Illegal instruction\nExiting thread...\n");
    80004214:	00003517          	auipc	a0,0x3
    80004218:	14c50513          	addi	a0,a0,332 # 80007360 <CONSOLE_STATUS+0x350>
    8000421c:	00000097          	auipc	ra,0x0
    80004220:	690080e7          	jalr	1680(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        TCB::dispatch();
    80004224:	ffffe097          	auipc	ra,0xffffe
    80004228:	694080e7          	jalr	1684(ra) # 800028b8 <_ZN3TCB8dispatchEv>
    8000422c:	d71ff06f          	j	80003f9c <_ZN5RiscV20handleSupervisorTrapEv+0x1cc>

0000000080004230 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_>:

void RiscV::threadCreateUtil(TCB **handle, void (*start_routine)(void *), void *arg) {
    80004230:	fd010113          	addi	sp,sp,-48
    80004234:	02113423          	sd	ra,40(sp)
    80004238:	02813023          	sd	s0,32(sp)
    8000423c:	00913c23          	sd	s1,24(sp)
    80004240:	01213823          	sd	s2,16(sp)
    80004244:	01313423          	sd	s3,8(sp)
    80004248:	03010413          	addi	s0,sp,48
    8000424c:	00050913          	mv	s2,a0
    80004250:	00058493          	mv	s1,a1
    80004254:	00060993          	mv	s3,a2
    uint64 ihandle = (uint64)handle;
    uint64 iroutine = (uint64)start_routine;
    uint64 iarg = (uint64)arg;
    uint64 istack = 0;

    if(start_routine) {
    80004258:	00058e63          	beqz	a1,80004274 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x44>
        istack = (uint64) MemoryAllocator::kmalloc(DEFAULT_STACK_SIZE);
    8000425c:	00001537          	lui	a0,0x1
    80004260:	fffff097          	auipc	ra,0xfffff
    80004264:	8dc080e7          	jalr	-1828(ra) # 80002b3c <_ZN15MemoryAllocator7kmallocEm>
        if(istack == 0) {
    80004268:	00051863          	bnez	a0,80004278 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x48>
            *handle = nullptr;
    8000426c:	00093023          	sd	zero,0(s2)
            return;
    80004270:	0200006f          	j	80004290 <_ZN5RiscV16threadCreateUtilEPP3TCBPFvPvES3_+0x60>
    uint64 istack = 0;
    80004274:	00000513          	li	a0,0
        }
    }

    asm("mv a7, %[istack]" : : [istack] "r" (istack));
    80004278:	00050893          	mv	a7,a0
    asm("mv a3, %[iarg]" : : [iarg] "r" (iarg));
    8000427c:	00098693          	mv	a3,s3
    asm("mv a2, %[iroutine]" : : [iroutine] "r" (iroutine));
    80004280:	00048613          	mv	a2,s1
    asm("mv a1, %[ihandle]" : : [ihandle] "r" (ihandle));
    80004284:	00090593          	mv	a1,s2
    asm("li a0, 0x11");
    80004288:	01100513          	li	a0,17

    asm("ecall");
    8000428c:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));

}
    80004290:	02813083          	ld	ra,40(sp)
    80004294:	02013403          	ld	s0,32(sp)
    80004298:	01813483          	ld	s1,24(sp)
    8000429c:	01013903          	ld	s2,16(sp)
    800042a0:	00813983          	ld	s3,8(sp)
    800042a4:	03010113          	addi	sp,sp,48
    800042a8:	00008067          	ret

00000000800042ac <_ZN5RiscV14threadExitUtilEv>:

void RiscV::threadExitUtil() {
    800042ac:	ff010113          	addi	sp,sp,-16
    800042b0:	00813423          	sd	s0,8(sp)
    800042b4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x12");
    800042b8:	01200513          	li	a0,18

    asm("ecall");
    800042bc:	00000073          	ecall

    uint64 status;

    asm("mv %[status], a0" : [status] "=r" (status));
}
    800042c0:	00813403          	ld	s0,8(sp)
    800042c4:	01010113          	addi	sp,sp,16
    800042c8:	00008067          	ret

00000000800042cc <_ZN5RiscV18threadDispatchUtilEv>:

void RiscV::threadDispatchUtil() {
    800042cc:	ff010113          	addi	sp,sp,-16
    800042d0:	00813423          	sd	s0,8(sp)
    800042d4:	01010413          	addi	s0,sp,16
    asm("li a0, 0x13");
    800042d8:	01300513          	li	a0,19

    asm("ecall");
    800042dc:	00000073          	ecall
}
    800042e0:	00813403          	ld	s0,8(sp)
    800042e4:	01010113          	addi	sp,sp,16
    800042e8:	00008067          	ret

00000000800042ec <_ZN5RiscV11putcWrapperEPv>:
{
    800042ec:	fe010113          	addi	sp,sp,-32
    800042f0:	00113c23          	sd	ra,24(sp)
    800042f4:	00813823          	sd	s0,16(sp)
    800042f8:	02010413          	addi	s0,sp,32
    800042fc:	00c0006f          	j	80004308 <_ZN5RiscV11putcWrapperEPv+0x1c>
            RiscV::threadDispatchUtil();
    80004300:	00000097          	auipc	ra,0x0
    80004304:	fcc080e7          	jalr	-52(ra) # 800042cc <_ZN5RiscV18threadDispatchUtilEv>
        uint64 status = CONSOLE_STATUS;
    80004308:	00003797          	auipc	a5,0x3
    8000430c:	7c87b783          	ld	a5,1992(a5) # 80007ad0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80004310:	0007b783          	ld	a5,0(a5)
        asm("mv a0, %[status]" : : [status] "r" (status));
    80004314:	00078513          	mv	a0,a5
        asm("lb a1, 0(a0)");
    80004318:	00050583          	lb	a1,0(a0) # 1000 <_entry-0x7ffff000>
        asm("mv %[status], a1" : [status] "=r" (status));
    8000431c:	00058793          	mv	a5,a1
        if(status & 1UL<<5){
    80004320:	0207f793          	andi	a5,a5,32
    80004324:	fc078ee3          	beqz	a5,80004300 <_ZN5RiscV11putcWrapperEPv+0x14>
                char volatile c = ConsoleUtil::putcUtilSyscall();
    80004328:	00000097          	auipc	ra,0x0
    8000432c:	710080e7          	jalr	1808(ra) # 80004a38 <_ZN11ConsoleUtil15putcUtilSyscallEv>
    80004330:	fea407a3          	sb	a0,-17(s0)
                uint64 data = CONSOLE_RX_DATA;
    80004334:	00003797          	auipc	a5,0x3
    80004338:	7947b783          	ld	a5,1940(a5) # 80007ac8 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000433c:	0007b783          	ld	a5,0(a5)
                asm("mv a0, %[data]" : : [data] "r"(data));
    80004340:	00078513          	mv	a0,a5
                asm("mv a1, %[c]" : : [c] "r"(c));
    80004344:	fef44783          	lbu	a5,-17(s0)
    80004348:	00078593          	mv	a1,a5
                asm("sb a1,0(a0)");
    8000434c:	00b50023          	sb	a1,0(a0)
            if(ConsoleUtil::pendingPutc>0)
    80004350:	00004797          	auipc	a5,0x4
    80004354:	8187b783          	ld	a5,-2024(a5) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    80004358:	0007b783          	ld	a5,0(a5)
    8000435c:	fa0786e3          	beqz	a5,80004308 <_ZN5RiscV11putcWrapperEPv+0x1c>
                ConsoleUtil::pendingPutc--;
    80004360:	fff78793          	addi	a5,a5,-1
    80004364:	00004717          	auipc	a4,0x4
    80004368:	80473703          	ld	a4,-2044(a4) # 80007b68 <_GLOBAL_OFFSET_TABLE_+0xa8>
    8000436c:	00f73023          	sd	a5,0(a4)
    80004370:	f99ff06f          	j	80004308 <_ZN5RiscV11putcWrapperEPv+0x1c>

0000000080004374 <_Z6strcpyPKcPc>:
//
// Created by os on 1/8/23.
//
#include "../../h/utility.hpp"

char* strcpy(const char* src, char* dst){
    80004374:	ff010113          	addi	sp,sp,-16
    80004378:	00813423          	sd	s0,8(sp)
    8000437c:	01010413          	addi	s0,sp,16
    80004380:	00050793          	mv	a5,a0
    80004384:	00058513          	mv	a0,a1
    while(*src != '\0')
    80004388:	0007c703          	lbu	a4,0(a5)
    8000438c:	00070a63          	beqz	a4,800043a0 <_Z6strcpyPKcPc+0x2c>
        *dst++ = *src++;
    80004390:	00178793          	addi	a5,a5,1
    80004394:	00e50023          	sb	a4,0(a0)
    80004398:	00150513          	addi	a0,a0,1
    while(*src != '\0')
    8000439c:	fedff06f          	j	80004388 <_Z6strcpyPKcPc+0x14>
    *dst = *src;
    800043a0:	00e50023          	sb	a4,0(a0)
    return dst;
}
    800043a4:	00813403          	ld	s0,8(sp)
    800043a8:	01010113          	addi	sp,sp,16
    800043ac:	00008067          	ret

00000000800043b0 <_Z6strcatPcPKc>:

char* strcat(char* dst, const char* src){
    800043b0:	fe010113          	addi	sp,sp,-32
    800043b4:	00113c23          	sd	ra,24(sp)
    800043b8:	00813823          	sd	s0,16(sp)
    800043bc:	00913423          	sd	s1,8(sp)
    800043c0:	02010413          	addi	s0,sp,32
    800043c4:	00050493          	mv	s1,a0
    800043c8:	00058513          	mv	a0,a1
    char *dest = dst;
    800043cc:	00048593          	mv	a1,s1
    while(*dest != '\0')
    800043d0:	0005c783          	lbu	a5,0(a1)
    800043d4:	00078663          	beqz	a5,800043e0 <_Z6strcatPcPKc+0x30>
        dest++;
    800043d8:	00158593          	addi	a1,a1,1
    while(*dest != '\0')
    800043dc:	ff5ff06f          	j	800043d0 <_Z6strcatPcPKc+0x20>
    strcpy(src, dest);
    800043e0:	00000097          	auipc	ra,0x0
    800043e4:	f94080e7          	jalr	-108(ra) # 80004374 <_Z6strcpyPKcPc>
    return dst;
    800043e8:	00048513          	mv	a0,s1
    800043ec:	01813083          	ld	ra,24(sp)
    800043f0:	01013403          	ld	s0,16(sp)
    800043f4:	00813483          	ld	s1,8(sp)
    800043f8:	02010113          	addi	sp,sp,32
    800043fc:	00008067          	ret

0000000080004400 <_ZN9Scheduler10initializeEv>:
TCB* Scheduler::readyHead = nullptr;
TCB* Scheduler::readyTail = nullptr;
TCB* Scheduler::sleepingHead = nullptr;


void Scheduler::initialize(){
    80004400:	ff010113          	addi	sp,sp,-16
    80004404:	00813423          	sd	s0,8(sp)
    80004408:	01010413          	addi	s0,sp,16
}
    8000440c:	00813403          	ld	s0,8(sp)
    80004410:	01010113          	addi	sp,sp,16
    80004414:	00008067          	ret

0000000080004418 <_ZN9Scheduler3putEP3TCB>:

//put a TCB in scheduler
//each TCB has a pointer to next TCB, so no external list/queue structures needed
void Scheduler::put(TCB *tcb) {
    80004418:	ff010113          	addi	sp,sp,-16
    8000441c:	00813423          	sd	s0,8(sp)
    80004420:	01010413          	addi	s0,sp,16
    tcb->next = nullptr;
    80004424:	04053423          	sd	zero,72(a0)
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004428:	00004797          	auipc	a5,0x4
    8000442c:	9b07b783          	ld	a5,-1616(a5) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    80004430:	02078263          	beqz	a5,80004454 <_ZN9Scheduler3putEP3TCB+0x3c>
    80004434:	00004797          	auipc	a5,0x4
    80004438:	9ac7b783          	ld	a5,-1620(a5) # 80007de0 <_ZN9Scheduler9readyTailE>
    8000443c:	04a7b423          	sd	a0,72(a5)
    80004440:	00004797          	auipc	a5,0x4
    80004444:	9aa7b023          	sd	a0,-1632(a5) # 80007de0 <_ZN9Scheduler9readyTailE>
}
    80004448:	00813403          	ld	s0,8(sp)
    8000444c:	01010113          	addi	sp,sp,16
    80004450:	00008067          	ret
    readyTail = (!readyHead ? readyHead : readyTail->next) = tcb;
    80004454:	00004797          	auipc	a5,0x4
    80004458:	98a7b223          	sd	a0,-1660(a5) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    8000445c:	fe5ff06f          	j	80004440 <_ZN9Scheduler3putEP3TCB+0x28>

0000000080004460 <_ZN9Scheduler3getEv>:


//get new TCB from scheduler
TCB* Scheduler::get(){
    80004460:	ff010113          	addi	sp,sp,-16
    80004464:	00813423          	sd	s0,8(sp)
    80004468:	01010413          	addi	s0,sp,16
    if(readyHead == nullptr)
    8000446c:	00004517          	auipc	a0,0x4
    80004470:	96c53503          	ld	a0,-1684(a0) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    80004474:	00050a63          	beqz	a0,80004488 <_ZN9Scheduler3getEv+0x28>
        return nullptr;
    TCB* tmp = readyHead;
    readyHead = readyHead->next;
    80004478:	04853783          	ld	a5,72(a0)
    8000447c:	00004717          	auipc	a4,0x4
    80004480:	94f73e23          	sd	a5,-1700(a4) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    tmp->next = nullptr;
    80004484:	04053423          	sd	zero,72(a0)
    return tmp;
}
    80004488:	00813403          	ld	s0,8(sp)
    8000448c:	01010113          	addi	sp,sp,16
    80004490:	00008067          	ret

0000000080004494 <_ZN9Scheduler5sleepEP3TCB>:

//put a thread to sleep by linking it in sleeping queue (same thing as with ready threads, link by TCB->next field, no "real" queue needed)
void Scheduler::sleep(TCB *t) {
    80004494:	ff010113          	addi	sp,sp,-16
    80004498:	00813423          	sd	s0,8(sp)
    8000449c:	01010413          	addi	s0,sp,16
    TCB* iter = sleepingHead, *prev = nullptr;
    800044a0:	00004797          	auipc	a5,0x4
    800044a4:	9487b783          	ld	a5,-1720(a5) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
    800044a8:	00000613          	li	a2,0
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800044ac:	00078e63          	beqz	a5,800044c8 <_ZN9Scheduler5sleepEP3TCB+0x34>
        if(iter->wakeTime>t->wakeTime)
    800044b0:	0587b683          	ld	a3,88(a5)
    800044b4:	05853703          	ld	a4,88(a0)
    800044b8:	00d76863          	bltu	a4,a3,800044c8 <_ZN9Scheduler5sleepEP3TCB+0x34>
    for(; iter!= nullptr; prev = iter, iter=iter->next)
    800044bc:	00078613          	mv	a2,a5
    800044c0:	0487b783          	ld	a5,72(a5)
    800044c4:	fe9ff06f          	j	800044ac <_ZN9Scheduler5sleepEP3TCB+0x18>
            break;
    t->next = iter;
    800044c8:	04f53423          	sd	a5,72(a0)
    if(prev)
    800044cc:	00060a63          	beqz	a2,800044e0 <_ZN9Scheduler5sleepEP3TCB+0x4c>
        prev->next = t;
    800044d0:	04a63423          	sd	a0,72(a2)
    else
        sleepingHead = t;
}
    800044d4:	00813403          	ld	s0,8(sp)
    800044d8:	01010113          	addi	sp,sp,16
    800044dc:	00008067          	ret
        sleepingHead = t;
    800044e0:	00004797          	auipc	a5,0x4
    800044e4:	90a7b423          	sd	a0,-1784(a5) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
}
    800044e8:	fedff06f          	j	800044d4 <_ZN9Scheduler5sleepEP3TCB+0x40>

00000000800044ec <_ZN9Scheduler5awakeEv>:

//try and awake all threads whose awake time is less than global time
void Scheduler::awake(){
    800044ec:	fe010113          	addi	sp,sp,-32
    800044f0:	00113c23          	sd	ra,24(sp)
    800044f4:	00813823          	sd	s0,16(sp)
    800044f8:	00913423          	sd	s1,8(sp)
    800044fc:	02010413          	addi	s0,sp,32
    while(sleepingHead){
    80004500:	00004497          	auipc	s1,0x4
    80004504:	8e84b483          	ld	s1,-1816(s1) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
    80004508:	02048c63          	beqz	s1,80004540 <_ZN9Scheduler5awakeEv+0x54>
        TCB* tmp = sleepingHead;

        if(tmp->wakeTime <= RiscV::globalTime){
    8000450c:	0584b703          	ld	a4,88(s1)
    80004510:	00003797          	auipc	a5,0x3
    80004514:	6807b783          	ld	a5,1664(a5) # 80007b90 <_GLOBAL_OFFSET_TABLE_+0xd0>
    80004518:	0007b783          	ld	a5,0(a5)
    8000451c:	02e7e263          	bltu	a5,a4,80004540 <_ZN9Scheduler5awakeEv+0x54>
            sleepingHead = sleepingHead->next;
    80004520:	0484b783          	ld	a5,72(s1)
    80004524:	00004717          	auipc	a4,0x4
    80004528:	8cf73223          	sd	a5,-1852(a4) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
            put(tmp);
    8000452c:	00048513          	mv	a0,s1
    80004530:	00000097          	auipc	ra,0x0
    80004534:	ee8080e7          	jalr	-280(ra) # 80004418 <_ZN9Scheduler3putEP3TCB>
            tmp->next = nullptr;
    80004538:	0404b423          	sd	zero,72(s1)
    while(sleepingHead){
    8000453c:	fc5ff06f          	j	80004500 <_ZN9Scheduler5awakeEv+0x14>
        }
        else{
            break;
        }
    }
}
    80004540:	01813083          	ld	ra,24(sp)
    80004544:	01013403          	ld	s0,16(sp)
    80004548:	00813483          	ld	s1,8(sp)
    8000454c:	02010113          	addi	sp,sp,32
    80004550:	00008067          	ret

0000000080004554 <_ZN9Scheduler13showSchedulerEv>:

//utility function to print all threads currently in scheduler
void Scheduler::showScheduler() {
    80004554:	fe010113          	addi	sp,sp,-32
    80004558:	00113c23          	sd	ra,24(sp)
    8000455c:	00813823          	sd	s0,16(sp)
    80004560:	00913423          	sd	s1,8(sp)
    80004564:	02010413          	addi	s0,sp,32
    TCB* iter = readyHead;
    80004568:	00004497          	auipc	s1,0x4
    8000456c:	8704b483          	ld	s1,-1936(s1) # 80007dd8 <_ZN9Scheduler9readyHeadE>
    while(iter){
    80004570:	02048863          	beqz	s1,800045a0 <_ZN9Scheduler13showSchedulerEv+0x4c>
        ConsoleUtil::printInt((uint64)iter, 16);
    80004574:	00000613          	li	a2,0
    80004578:	01000593          	li	a1,16
    8000457c:	0004851b          	sext.w	a0,s1
    80004580:	00000097          	auipc	ra,0x0
    80004584:	370080e7          	jalr	880(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
        ConsoleUtil::printString("\n");
    80004588:	00003517          	auipc	a0,0x3
    8000458c:	dc850513          	addi	a0,a0,-568 # 80007350 <CONSOLE_STATUS+0x340>
    80004590:	00000097          	auipc	ra,0x0
    80004594:	31c080e7          	jalr	796(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
        iter = iter->next;
    80004598:	0484b483          	ld	s1,72(s1)
    while(iter){
    8000459c:	fd5ff06f          	j	80004570 <_ZN9Scheduler13showSchedulerEv+0x1c>
    }
}
    800045a0:	01813083          	ld	ra,24(sp)
    800045a4:	01013403          	ld	s0,16(sp)
    800045a8:	00813483          	ld	s1,8(sp)
    800045ac:	02010113          	addi	sp,sp,32
    800045b0:	00008067          	ret

00000000800045b4 <_ZN9Scheduler12showSleepingEv>:

//utility function to print all threads currently in sleep
void Scheduler::showSleeping(){
    800045b4:	fe010113          	addi	sp,sp,-32
    800045b8:	00113c23          	sd	ra,24(sp)
    800045bc:	00813823          	sd	s0,16(sp)
    800045c0:	00913423          	sd	s1,8(sp)
    800045c4:	02010413          	addi	s0,sp,32
    TCB* iter = sleepingHead;
    800045c8:	00004497          	auipc	s1,0x4
    800045cc:	8204b483          	ld	s1,-2016(s1) # 80007de8 <_ZN9Scheduler12sleepingHeadE>
    while(iter){
    800045d0:	02048863          	beqz	s1,80004600 <_ZN9Scheduler12showSleepingEv+0x4c>
        printInt((uint64)iter, 16);
    800045d4:	00000613          	li	a2,0
    800045d8:	01000593          	li	a1,16
    800045dc:	0004851b          	sext.w	a0,s1
    800045e0:	0000c097          	auipc	ra,0xc
    800045e4:	4bc080e7          	jalr	1212(ra) # 80010a9c <_Z8printIntiii>
        printString("\n");
    800045e8:	00003517          	auipc	a0,0x3
    800045ec:	d6850513          	addi	a0,a0,-664 # 80007350 <CONSOLE_STATUS+0x340>
    800045f0:	0000c097          	auipc	ra,0xc
    800045f4:	314080e7          	jalr	788(ra) # 80010904 <_Z11printStringPKc>
        iter = iter->next;
    800045f8:	0484b483          	ld	s1,72(s1)
    while(iter){
    800045fc:	fd5ff06f          	j	800045d0 <_ZN9Scheduler12showSleepingEv+0x1c>
    }
    80004600:	01813083          	ld	ra,24(sp)
    80004604:	01013403          	ld	s0,16(sp)
    80004608:	00813483          	ld	s1,8(sp)
    8000460c:	02010113          	addi	sp,sp,32
    80004610:	00008067          	ret

0000000080004614 <_ZN11ConsoleUtil10initializeEv>:
char ConsoleUtil::inputBuffer[8192];
char ConsoleUtil::outputBuffer[8192];

uint64 ConsoleUtil::bufferSize = 8192;

void ConsoleUtil::initialize() {
    80004614:	fe010113          	addi	sp,sp,-32
    80004618:	00113c23          	sd	ra,24(sp)
    8000461c:	00813823          	sd	s0,16(sp)
    80004620:	00913423          	sd	s1,8(sp)
    80004624:	01213023          	sd	s2,0(sp)
    80004628:	02010413          	addi	s0,sp,32
    inputSem = new SCB(0);
    8000462c:	01800513          	li	a0,24
    80004630:	ffffe097          	auipc	ra,0xffffe
    80004634:	078080e7          	jalr	120(ra) # 800026a8 <_ZN3SCBnwEm>
    80004638:	00050493          	mv	s1,a0
    8000463c:	00050863          	beqz	a0,8000464c <_ZN11ConsoleUtil10initializeEv+0x38>
    80004640:	00000593          	li	a1,0
    80004644:	ffffe097          	auipc	ra,0xffffe
    80004648:	eb0080e7          	jalr	-336(ra) # 800024f4 <_ZN3SCBC1Em>
    8000464c:	00003797          	auipc	a5,0x3
    80004650:	7a97b223          	sd	s1,1956(a5) # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    outputSem = new SCB(0);
    80004654:	01800513          	li	a0,24
    80004658:	ffffe097          	auipc	ra,0xffffe
    8000465c:	050080e7          	jalr	80(ra) # 800026a8 <_ZN3SCBnwEm>
    80004660:	00050493          	mv	s1,a0
    80004664:	00050863          	beqz	a0,80004674 <_ZN11ConsoleUtil10initializeEv+0x60>
    80004668:	00000593          	li	a1,0
    8000466c:	ffffe097          	auipc	ra,0xffffe
    80004670:	e88080e7          	jalr	-376(ra) # 800024f4 <_ZN3SCBC1Em>
    80004674:	00003797          	auipc	a5,0x3
    80004678:	7897b223          	sd	s1,1924(a5) # 80007df8 <_ZN11ConsoleUtil9outputSemE>
//    inputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
//    outputBuffer = (char*)kmalloc(ConsoleUtil::bufferSize);
}
    8000467c:	01813083          	ld	ra,24(sp)
    80004680:	01013403          	ld	s0,16(sp)
    80004684:	00813483          	ld	s1,8(sp)
    80004688:	00013903          	ld	s2,0(sp)
    8000468c:	02010113          	addi	sp,sp,32
    80004690:	00008067          	ret
    80004694:	00050913          	mv	s2,a0
    inputSem = new SCB(0);
    80004698:	00048513          	mv	a0,s1
    8000469c:	ffffe097          	auipc	ra,0xffffe
    800046a0:	03c080e7          	jalr	60(ra) # 800026d8 <_ZN3SCBdlEPv>
    800046a4:	00090513          	mv	a0,s2
    800046a8:	00009097          	auipc	ra,0x9
    800046ac:	850080e7          	jalr	-1968(ra) # 8000cef8 <_Unwind_Resume>
    800046b0:	00050913          	mv	s2,a0
    outputSem = new SCB(0);
    800046b4:	00048513          	mv	a0,s1
    800046b8:	ffffe097          	auipc	ra,0xffffe
    800046bc:	020080e7          	jalr	32(ra) # 800026d8 <_ZN3SCBdlEPv>
    800046c0:	00090513          	mv	a0,s2
    800046c4:	00009097          	auipc	ra,0x9
    800046c8:	834080e7          	jalr	-1996(ra) # 8000cef8 <_Unwind_Resume>

00000000800046cc <_ZN11ConsoleUtil8putInputEc>:

void ConsoleUtil::putInput(char c) {
    if((inputTail+1)%bufferSize == inputHead)
    800046cc:	00003717          	auipc	a4,0x3
    800046d0:	72470713          	addi	a4,a4,1828 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    800046d4:	01073683          	ld	a3,16(a4)
    800046d8:	00168793          	addi	a5,a3,1
    800046dc:	00003617          	auipc	a2,0x3
    800046e0:	3dc63603          	ld	a2,988(a2) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    800046e4:	02c7f7b3          	remu	a5,a5,a2
    800046e8:	01873703          	ld	a4,24(a4)
    800046ec:	04e78663          	beq	a5,a4,80004738 <_ZN11ConsoleUtil8putInputEc+0x6c>
void ConsoleUtil::putInput(char c) {
    800046f0:	ff010113          	addi	sp,sp,-16
    800046f4:	00113423          	sd	ra,8(sp)
    800046f8:	00813023          	sd	s0,0(sp)
    800046fc:	01010413          	addi	s0,sp,16
        return;
    inputBuffer[inputTail] = c;
    80004700:	00005717          	auipc	a4,0x5
    80004704:	72870713          	addi	a4,a4,1832 # 80009e28 <_ZN11ConsoleUtil11inputBufferE>
    80004708:	00d706b3          	add	a3,a4,a3
    8000470c:	00a68023          	sb	a0,0(a3)
    inputTail = (inputTail+1)%bufferSize;
    80004710:	00003717          	auipc	a4,0x3
    80004714:	6e070713          	addi	a4,a4,1760 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    80004718:	00f73823          	sd	a5,16(a4)
    inputSem->signal();
    8000471c:	00073503          	ld	a0,0(a4)
    80004720:	ffffe097          	auipc	ra,0xffffe
    80004724:	f4c080e7          	jalr	-180(ra) # 8000266c <_ZN3SCB6signalEv>
}
    80004728:	00813083          	ld	ra,8(sp)
    8000472c:	00013403          	ld	s0,0(sp)
    80004730:	01010113          	addi	sp,sp,16
    80004734:	00008067          	ret
    80004738:	00008067          	ret

000000008000473c <_ZN11ConsoleUtil8getInputEv>:

char ConsoleUtil::getInput() {
    8000473c:	fe010113          	addi	sp,sp,-32
    80004740:	00113c23          	sd	ra,24(sp)
    80004744:	00813823          	sd	s0,16(sp)
    80004748:	00913423          	sd	s1,8(sp)
    8000474c:	02010413          	addi	s0,sp,32
    inputSem->wait();
    80004750:	00003497          	auipc	s1,0x3
    80004754:	6a048493          	addi	s1,s1,1696 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    80004758:	0004b503          	ld	a0,0(s1)
    8000475c:	ffffe097          	auipc	ra,0xffffe
    80004760:	ec0080e7          	jalr	-320(ra) # 8000261c <_ZN3SCB4waitEv>

    if(inputHead == inputTail)
    80004764:	0184b783          	ld	a5,24(s1)
    80004768:	0104b703          	ld	a4,16(s1)
    8000476c:	04e78063          	beq	a5,a4,800047ac <_ZN11ConsoleUtil8getInputEv+0x70>
        return -1;
    char c = inputBuffer[inputHead];
    80004770:	00005717          	auipc	a4,0x5
    80004774:	6b870713          	addi	a4,a4,1720 # 80009e28 <_ZN11ConsoleUtil11inputBufferE>
    80004778:	00f70733          	add	a4,a4,a5
    8000477c:	00074503          	lbu	a0,0(a4)

    inputHead = (inputHead+1)%bufferSize;
    80004780:	00178793          	addi	a5,a5,1
    80004784:	00003717          	auipc	a4,0x3
    80004788:	33473703          	ld	a4,820(a4) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    8000478c:	02e7f7b3          	remu	a5,a5,a4
    80004790:	00003717          	auipc	a4,0x3
    80004794:	66f73c23          	sd	a5,1656(a4) # 80007e08 <_ZN11ConsoleUtil9inputHeadE>

    return c;
}
    80004798:	01813083          	ld	ra,24(sp)
    8000479c:	01013403          	ld	s0,16(sp)
    800047a0:	00813483          	ld	s1,8(sp)
    800047a4:	02010113          	addi	sp,sp,32
    800047a8:	00008067          	ret
        return -1;
    800047ac:	0ff00513          	li	a0,255
    800047b0:	fe9ff06f          	j	80004798 <_ZN11ConsoleUtil8getInputEv+0x5c>

00000000800047b4 <_ZN11ConsoleUtil9putOutputEc>:

void ConsoleUtil::putOutput(char c) {
    pendingPutc++;
    800047b4:	00003797          	auipc	a5,0x3
    800047b8:	63c78793          	addi	a5,a5,1596 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    800047bc:	0207b683          	ld	a3,32(a5)
    800047c0:	00168713          	addi	a4,a3,1
    800047c4:	02e7b023          	sd	a4,32(a5)

    if((outputTail+1)%bufferSize == outputHead)
    800047c8:	0287b603          	ld	a2,40(a5)
    800047cc:	00160713          	addi	a4,a2,1
    800047d0:	00003597          	auipc	a1,0x3
    800047d4:	2e85b583          	ld	a1,744(a1) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    800047d8:	02b77733          	remu	a4,a4,a1
    800047dc:	0307b783          	ld	a5,48(a5)
    800047e0:	04f70863          	beq	a4,a5,80004830 <_ZN11ConsoleUtil9putOutputEc+0x7c>
void ConsoleUtil::putOutput(char c) {
    800047e4:	ff010113          	addi	sp,sp,-16
    800047e8:	00113423          	sd	ra,8(sp)
    800047ec:	00813023          	sd	s0,0(sp)
    800047f0:	01010413          	addi	s0,sp,16
        return;

    outputBuffer[outputTail] = c;
    800047f4:	00003797          	auipc	a5,0x3
    800047f8:	63478793          	addi	a5,a5,1588 # 80007e28 <_ZN11ConsoleUtil12outputBufferE>
    800047fc:	00c78633          	add	a2,a5,a2
    80004800:	00a60023          	sb	a0,0(a2)

    outputTail = (outputTail+1)%bufferSize;
    80004804:	00003797          	auipc	a5,0x3
    80004808:	5ec78793          	addi	a5,a5,1516 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    8000480c:	02e7b423          	sd	a4,40(a5)

    pendingPutc--;
    80004810:	02d7b023          	sd	a3,32(a5)

    outputSem->signal();
    80004814:	0087b503          	ld	a0,8(a5)
    80004818:	ffffe097          	auipc	ra,0xffffe
    8000481c:	e54080e7          	jalr	-428(ra) # 8000266c <_ZN3SCB6signalEv>
}
    80004820:	00813083          	ld	ra,8(sp)
    80004824:	00013403          	ld	s0,0(sp)
    80004828:	01010113          	addi	sp,sp,16
    8000482c:	00008067          	ret
    80004830:	00008067          	ret

0000000080004834 <_ZN11ConsoleUtil9getOutputEv>:

char ConsoleUtil::getOutput() {
    80004834:	fe010113          	addi	sp,sp,-32
    80004838:	00113c23          	sd	ra,24(sp)
    8000483c:	00813823          	sd	s0,16(sp)
    80004840:	00913423          	sd	s1,8(sp)
    80004844:	02010413          	addi	s0,sp,32
    outputSem->wait();
    80004848:	00003497          	auipc	s1,0x3
    8000484c:	5a848493          	addi	s1,s1,1448 # 80007df0 <_ZN11ConsoleUtil8inputSemE>
    80004850:	0084b503          	ld	a0,8(s1)
    80004854:	ffffe097          	auipc	ra,0xffffe
    80004858:	dc8080e7          	jalr	-568(ra) # 8000261c <_ZN3SCB4waitEv>
    if(outputHead == outputTail)
    8000485c:	0304b783          	ld	a5,48(s1)
    80004860:	0284b703          	ld	a4,40(s1)
    80004864:	04e78063          	beq	a5,a4,800048a4 <_ZN11ConsoleUtil9getOutputEv+0x70>
        return -1;

    char c = outputBuffer[outputHead];
    80004868:	00003717          	auipc	a4,0x3
    8000486c:	5c070713          	addi	a4,a4,1472 # 80007e28 <_ZN11ConsoleUtil12outputBufferE>
    80004870:	00f70733          	add	a4,a4,a5
    80004874:	00074503          	lbu	a0,0(a4)

    outputHead = (outputHead+1)%bufferSize;
    80004878:	00178793          	addi	a5,a5,1
    8000487c:	00003717          	auipc	a4,0x3
    80004880:	23c73703          	ld	a4,572(a4) # 80007ab8 <_ZN11ConsoleUtil10bufferSizeE>
    80004884:	02e7f7b3          	remu	a5,a5,a4
    80004888:	00003717          	auipc	a4,0x3
    8000488c:	58f73c23          	sd	a5,1432(a4) # 80007e20 <_ZN11ConsoleUtil10outputHeadE>

    return c;
}
    80004890:	01813083          	ld	ra,24(sp)
    80004894:	01013403          	ld	s0,16(sp)
    80004898:	00813483          	ld	s1,8(sp)
    8000489c:	02010113          	addi	sp,sp,32
    800048a0:	00008067          	ret
        return -1;
    800048a4:	0ff00513          	li	a0,255
    800048a8:	fe9ff06f          	j	80004890 <_ZN11ConsoleUtil9getOutputEv+0x5c>

00000000800048ac <_ZN11ConsoleUtil11printStringEPKc>:

void ConsoleUtil::printString(const char *string) {
    800048ac:	fe010113          	addi	sp,sp,-32
    800048b0:	00113c23          	sd	ra,24(sp)
    800048b4:	00813823          	sd	s0,16(sp)
    800048b8:	00913423          	sd	s1,8(sp)
    800048bc:	02010413          	addi	s0,sp,32
    800048c0:	00050493          	mv	s1,a0
    while (*string != '\0')
    800048c4:	0004c503          	lbu	a0,0(s1)
    800048c8:	00050a63          	beqz	a0,800048dc <_ZN11ConsoleUtil11printStringEPKc+0x30>
    {
        ConsoleUtil::putOutput(*string);
    800048cc:	00000097          	auipc	ra,0x0
    800048d0:	ee8080e7          	jalr	-280(ra) # 800047b4 <_ZN11ConsoleUtil9putOutputEc>
        string++;
    800048d4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    800048d8:	fedff06f          	j	800048c4 <_ZN11ConsoleUtil11printStringEPKc+0x18>
    }
}
    800048dc:	01813083          	ld	ra,24(sp)
    800048e0:	01013403          	ld	s0,16(sp)
    800048e4:	00813483          	ld	s1,8(sp)
    800048e8:	02010113          	addi	sp,sp,32
    800048ec:	00008067          	ret

00000000800048f0 <_ZN11ConsoleUtil8printIntEiii>:

void ConsoleUtil::printInt(int xx, int base, int sgn)
{
    800048f0:	fb010113          	addi	sp,sp,-80
    800048f4:	04113423          	sd	ra,72(sp)
    800048f8:	04813023          	sd	s0,64(sp)
    800048fc:	02913c23          	sd	s1,56(sp)
    80004900:	05010413          	addi	s0,sp,80
    char digits[] = "0123456789ABCDEF";
    80004904:	00003797          	auipc	a5,0x3
    80004908:	c4c78793          	addi	a5,a5,-948 # 80007550 <CONSOLE_STATUS+0x540>
    8000490c:	0007b703          	ld	a4,0(a5)
    80004910:	fce43423          	sd	a4,-56(s0)
    80004914:	0087b703          	ld	a4,8(a5)
    80004918:	fce43823          	sd	a4,-48(s0)
    8000491c:	0107c783          	lbu	a5,16(a5)
    80004920:	fcf40c23          	sb	a5,-40(s0)
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004924:	00060463          	beqz	a2,8000492c <_ZN11ConsoleUtil8printIntEiii+0x3c>
    80004928:	08054263          	bltz	a0,800049ac <_ZN11ConsoleUtil8printIntEiii+0xbc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    8000492c:	0005051b          	sext.w	a0,a0
    neg = 0;
    80004930:	00000813          	li	a6,0
    }

    i = 0;
    80004934:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004938:	0005871b          	sext.w	a4,a1
    8000493c:	02b577bb          	remuw	a5,a0,a1
    80004940:	00048693          	mv	a3,s1
    80004944:	0014849b          	addiw	s1,s1,1
    80004948:	02079793          	slli	a5,a5,0x20
    8000494c:	0207d793          	srli	a5,a5,0x20
    80004950:	fe040613          	addi	a2,s0,-32
    80004954:	00f607b3          	add	a5,a2,a5
    80004958:	fe87c603          	lbu	a2,-24(a5)
    8000495c:	fe040793          	addi	a5,s0,-32
    80004960:	00d787b3          	add	a5,a5,a3
    80004964:	fcc78c23          	sb	a2,-40(a5)
    }while((x /= base) != 0);
    80004968:	0005061b          	sext.w	a2,a0
    8000496c:	02b5553b          	divuw	a0,a0,a1
    80004970:	fce674e3          	bgeu	a2,a4,80004938 <_ZN11ConsoleUtil8printIntEiii+0x48>
    if(neg)
    80004974:	00080c63          	beqz	a6,8000498c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        buf[i++] = '-';
    80004978:	fe040793          	addi	a5,s0,-32
    8000497c:	009784b3          	add	s1,a5,s1
    80004980:	02d00793          	li	a5,45
    80004984:	fcf48c23          	sb	a5,-40(s1)
    80004988:	0026849b          	addiw	s1,a3,2

    while(--i >= 0)
    8000498c:	fff4849b          	addiw	s1,s1,-1
    80004990:	0204c463          	bltz	s1,800049b8 <_ZN11ConsoleUtil8printIntEiii+0xc8>
        ConsoleUtil::putOutput(buf[i]);
    80004994:	fe040793          	addi	a5,s0,-32
    80004998:	009787b3          	add	a5,a5,s1
    8000499c:	fd87c503          	lbu	a0,-40(a5)
    800049a0:	00000097          	auipc	ra,0x0
    800049a4:	e14080e7          	jalr	-492(ra) # 800047b4 <_ZN11ConsoleUtil9putOutputEc>
    800049a8:	fe5ff06f          	j	8000498c <_ZN11ConsoleUtil8printIntEiii+0x9c>
        x = -xx;
    800049ac:	40a0053b          	negw	a0,a0
        neg = 1;
    800049b0:	00100813          	li	a6,1
        x = -xx;
    800049b4:	f81ff06f          	j	80004934 <_ZN11ConsoleUtil8printIntEiii+0x44>

}
    800049b8:	04813083          	ld	ra,72(sp)
    800049bc:	04013403          	ld	s0,64(sp)
    800049c0:	03813483          	ld	s1,56(sp)
    800049c4:	05010113          	addi	sp,sp,80
    800049c8:	00008067          	ret

00000000800049cc <_ZN11ConsoleUtil5printEPKciS1_i>:

void ConsoleUtil::print(const char *string, int xx, const char *sep, int base) {
    800049cc:	fd010113          	addi	sp,sp,-48
    800049d0:	02113423          	sd	ra,40(sp)
    800049d4:	02813023          	sd	s0,32(sp)
    800049d8:	00913c23          	sd	s1,24(sp)
    800049dc:	01213823          	sd	s2,16(sp)
    800049e0:	01313423          	sd	s3,8(sp)
    800049e4:	03010413          	addi	s0,sp,48
    800049e8:	00058913          	mv	s2,a1
    800049ec:	00060493          	mv	s1,a2
    800049f0:	00068993          	mv	s3,a3
    ConsoleUtil::printString(string);
    800049f4:	00000097          	auipc	ra,0x0
    800049f8:	eb8080e7          	jalr	-328(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
    ConsoleUtil::printInt(xx, base);
    800049fc:	00000613          	li	a2,0
    80004a00:	00098593          	mv	a1,s3
    80004a04:	00090513          	mv	a0,s2
    80004a08:	00000097          	auipc	ra,0x0
    80004a0c:	ee8080e7          	jalr	-280(ra) # 800048f0 <_ZN11ConsoleUtil8printIntEiii>
    ConsoleUtil::printString(sep);
    80004a10:	00048513          	mv	a0,s1
    80004a14:	00000097          	auipc	ra,0x0
    80004a18:	e98080e7          	jalr	-360(ra) # 800048ac <_ZN11ConsoleUtil11printStringEPKc>
}
    80004a1c:	02813083          	ld	ra,40(sp)
    80004a20:	02013403          	ld	s0,32(sp)
    80004a24:	01813483          	ld	s1,24(sp)
    80004a28:	01013903          	ld	s2,16(sp)
    80004a2c:	00813983          	ld	s3,8(sp)
    80004a30:	03010113          	addi	sp,sp,48
    80004a34:	00008067          	ret

0000000080004a38 <_ZN11ConsoleUtil15putcUtilSyscallEv>:

char ConsoleUtil::putcUtilSyscall()
{
    80004a38:	ff010113          	addi	sp,sp,-16
    80004a3c:	00813423          	sd	s0,8(sp)
    80004a40:	01010413          	addi	s0,sp,16
    asm("li a0, 0x43");
    80004a44:	04300513          	li	a0,67

    asm("ecall");
    80004a48:	00000073          	ecall

    uint64 status;

    asm("mv %0, a0" : [status] "=r" (status));
    80004a4c:	00050513          	mv	a0,a0

    return (char)status;
}
    80004a50:	0ff57513          	andi	a0,a0,255
    80004a54:	00813403          	ld	s0,8(sp)
    80004a58:	01010113          	addi	sp,sp,16
    80004a5c:	00008067          	ret

0000000080004a60 <_Z9kmem_initPvi>:
//
// Created by os on 1/2/23.
//
#include "../../h/slab.hpp"

void kmem_init(void* space, int block_num){
    80004a60:	ff010113          	addi	sp,sp,-16
    80004a64:	00113423          	sd	ra,8(sp)
    80004a68:	00813023          	sd	s0,0(sp)
    80004a6c:	01010413          	addi	s0,sp,16
    SlabAllocator::initialize(space, block_num);
    80004a70:	ffffd097          	auipc	ra,0xffffd
    80004a74:	f48080e7          	jalr	-184(ra) # 800019b8 <_ZN13SlabAllocator10initializeEPvm>
}
    80004a78:	00813083          	ld	ra,8(sp)
    80004a7c:	00013403          	ld	s0,0(sp)
    80004a80:	01010113          	addi	sp,sp,16
    80004a84:	00008067          	ret

0000000080004a88 <_Z17kmem_cache_createPKcmPFvPvES3_>:

kmem_cache_t* kmem_cache_create(const char* name, size_t size, void (*ctor)(void*), void (*dtor)(void*)){
    80004a88:	ff010113          	addi	sp,sp,-16
    80004a8c:	00113423          	sd	ra,8(sp)
    80004a90:	00813023          	sd	s0,0(sp)
    80004a94:	01010413          	addi	s0,sp,16
    return SlabAllocator::createCache(name, size, ctor, dtor);
    80004a98:	ffffd097          	auipc	ra,0xffffd
    80004a9c:	e7c080e7          	jalr	-388(ra) # 80001914 <_ZN13SlabAllocator11createCacheEPKcmPFvPvES4_>
}
    80004aa0:	00813083          	ld	ra,8(sp)
    80004aa4:	00013403          	ld	s0,0(sp)
    80004aa8:	01010113          	addi	sp,sp,16
    80004aac:	00008067          	ret

0000000080004ab0 <_Z16kmem_cache_allocP5Cache>:

void* kmem_cache_alloc(kmem_cache_t* cachep){
    80004ab0:	ff010113          	addi	sp,sp,-16
    80004ab4:	00113423          	sd	ra,8(sp)
    80004ab8:	00813023          	sd	s0,0(sp)
    80004abc:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateObject(cachep);
    80004ac0:	ffffd097          	auipc	ra,0xffffd
    80004ac4:	d18080e7          	jalr	-744(ra) # 800017d8 <_ZN13SlabAllocator14allocateObjectEP5Cache>
}
    80004ac8:	00813083          	ld	ra,8(sp)
    80004acc:	00013403          	ld	s0,0(sp)
    80004ad0:	01010113          	addi	sp,sp,16
    80004ad4:	00008067          	ret

0000000080004ad8 <_Z15kmem_cache_freeP5CachePv>:

void kmem_cache_free(kmem_cache_t* cachep, void* objp){
    80004ad8:	ff010113          	addi	sp,sp,-16
    80004adc:	00113423          	sd	ra,8(sp)
    80004ae0:	00813023          	sd	s0,0(sp)
    80004ae4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeObject(cachep, objp);
    80004ae8:	ffffd097          	auipc	ra,0xffffd
    80004aec:	0a8080e7          	jalr	168(ra) # 80001b90 <_ZN13SlabAllocator10freeObjectEP5CachePKv>
}
    80004af0:	00813083          	ld	ra,8(sp)
    80004af4:	00013403          	ld	s0,0(sp)
    80004af8:	01010113          	addi	sp,sp,16
    80004afc:	00008067          	ret

0000000080004b00 <_Z18kmem_cache_destroyP5Cache>:

void kmem_cache_destroy(kmem_cache_t* cachep){
    80004b00:	fe010113          	addi	sp,sp,-32
    80004b04:	00113c23          	sd	ra,24(sp)
    80004b08:	00813823          	sd	s0,16(sp)
    80004b0c:	02010413          	addi	s0,sp,32
    80004b10:	fea43423          	sd	a0,-24(s0)
    SlabAllocator::deleteCache(cachep);
    80004b14:	fe840513          	addi	a0,s0,-24
    80004b18:	ffffd097          	auipc	ra,0xffffd
    80004b1c:	1d8080e7          	jalr	472(ra) # 80001cf0 <_ZN13SlabAllocator11deleteCacheERP5Cache>
}
    80004b20:	01813083          	ld	ra,24(sp)
    80004b24:	01013403          	ld	s0,16(sp)
    80004b28:	02010113          	addi	sp,sp,32
    80004b2c:	00008067          	ret

0000000080004b30 <_Z15kmem_cache_infoP5Cache>:

void kmem_cache_info(kmem_cache_t* cachep){
    80004b30:	ff010113          	addi	sp,sp,-16
    80004b34:	00113423          	sd	ra,8(sp)
    80004b38:	00813023          	sd	s0,0(sp)
    80004b3c:	01010413          	addi	s0,sp,16
    SlabAllocator::printCache(cachep);
    80004b40:	ffffc097          	auipc	ra,0xffffc
    80004b44:	7bc080e7          	jalr	1980(ra) # 800012fc <_ZN13SlabAllocator10printCacheEP5Cache>
}
    80004b48:	00813083          	ld	ra,8(sp)
    80004b4c:	00013403          	ld	s0,0(sp)
    80004b50:	01010113          	addi	sp,sp,16
    80004b54:	00008067          	ret

0000000080004b58 <_Z17kmem_cache_shrinkP5Cache>:

int kmem_cache_shrink(kmem_cache_t* cachep){
    80004b58:	ff010113          	addi	sp,sp,-16
    80004b5c:	00113423          	sd	ra,8(sp)
    80004b60:	00813023          	sd	s0,0(sp)
    80004b64:	01010413          	addi	s0,sp,16
    return SlabAllocator::shrinkCache(cachep);
    80004b68:	ffffc097          	auipc	ra,0xffffc
    80004b6c:	5cc080e7          	jalr	1484(ra) # 80001134 <_ZN13SlabAllocator11shrinkCacheEP5Cache>
}
    80004b70:	00813083          	ld	ra,8(sp)
    80004b74:	00013403          	ld	s0,0(sp)
    80004b78:	01010113          	addi	sp,sp,16
    80004b7c:	00008067          	ret

0000000080004b80 <_Z7kmallocm>:
void* kmalloc(size_t size){
    80004b80:	ff010113          	addi	sp,sp,-16
    80004b84:	00113423          	sd	ra,8(sp)
    80004b88:	00813023          	sd	s0,0(sp)
    80004b8c:	01010413          	addi	s0,sp,16
    return SlabAllocator::allocateBuffer(size);
    80004b90:	ffffd097          	auipc	ra,0xffffd
    80004b94:	ce4080e7          	jalr	-796(ra) # 80001874 <_ZN13SlabAllocator14allocateBufferEm>
}
    80004b98:	00813083          	ld	ra,8(sp)
    80004b9c:	00013403          	ld	s0,0(sp)
    80004ba0:	01010113          	addi	sp,sp,16
    80004ba4:	00008067          	ret

0000000080004ba8 <_Z5kfreePKv>:

void kfree(const void* objp){
    80004ba8:	ff010113          	addi	sp,sp,-16
    80004bac:	00113423          	sd	ra,8(sp)
    80004bb0:	00813023          	sd	s0,0(sp)
    80004bb4:	01010413          	addi	s0,sp,16
    SlabAllocator::freeBuffer(objp);
    80004bb8:	ffffd097          	auipc	ra,0xffffd
    80004bbc:	0cc080e7          	jalr	204(ra) # 80001c84 <_ZN13SlabAllocator10freeBufferEPKv>
    80004bc0:	00813083          	ld	ra,8(sp)
    80004bc4:	00013403          	ld	s0,0(sp)
    80004bc8:	01010113          	addi	sp,sp,16
    80004bcc:	00008067          	ret

0000000080004bd0 <start>:
    80004bd0:	ff010113          	addi	sp,sp,-16
    80004bd4:	00813423          	sd	s0,8(sp)
    80004bd8:	01010413          	addi	s0,sp,16
    80004bdc:	300027f3          	csrr	a5,mstatus
    80004be0:	ffffe737          	lui	a4,0xffffe
    80004be4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffea7ff>
    80004be8:	00e7f7b3          	and	a5,a5,a4
    80004bec:	00001737          	lui	a4,0x1
    80004bf0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004bf4:	00e7e7b3          	or	a5,a5,a4
    80004bf8:	30079073          	csrw	mstatus,a5
    80004bfc:	00000797          	auipc	a5,0x0
    80004c00:	16078793          	addi	a5,a5,352 # 80004d5c <system_main>
    80004c04:	34179073          	csrw	mepc,a5
    80004c08:	00000793          	li	a5,0
    80004c0c:	18079073          	csrw	satp,a5
    80004c10:	000107b7          	lui	a5,0x10
    80004c14:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004c18:	30279073          	csrw	medeleg,a5
    80004c1c:	30379073          	csrw	mideleg,a5
    80004c20:	104027f3          	csrr	a5,sie
    80004c24:	2227e793          	ori	a5,a5,546
    80004c28:	10479073          	csrw	sie,a5
    80004c2c:	fff00793          	li	a5,-1
    80004c30:	00a7d793          	srli	a5,a5,0xa
    80004c34:	3b079073          	csrw	pmpaddr0,a5
    80004c38:	00f00793          	li	a5,15
    80004c3c:	3a079073          	csrw	pmpcfg0,a5
    80004c40:	f14027f3          	csrr	a5,mhartid
    80004c44:	0200c737          	lui	a4,0x200c
    80004c48:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004c4c:	0007869b          	sext.w	a3,a5
    80004c50:	00269713          	slli	a4,a3,0x2
    80004c54:	000f4637          	lui	a2,0xf4
    80004c58:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004c5c:	00d70733          	add	a4,a4,a3
    80004c60:	0037979b          	slliw	a5,a5,0x3
    80004c64:	020046b7          	lui	a3,0x2004
    80004c68:	00d787b3          	add	a5,a5,a3
    80004c6c:	00c585b3          	add	a1,a1,a2
    80004c70:	00371693          	slli	a3,a4,0x3
    80004c74:	00007717          	auipc	a4,0x7
    80004c78:	1bc70713          	addi	a4,a4,444 # 8000be30 <timer_scratch>
    80004c7c:	00b7b023          	sd	a1,0(a5)
    80004c80:	00d70733          	add	a4,a4,a3
    80004c84:	00f73c23          	sd	a5,24(a4)
    80004c88:	02c73023          	sd	a2,32(a4)
    80004c8c:	34071073          	csrw	mscratch,a4
    80004c90:	00000797          	auipc	a5,0x0
    80004c94:	6e078793          	addi	a5,a5,1760 # 80005370 <timervec>
    80004c98:	30579073          	csrw	mtvec,a5
    80004c9c:	300027f3          	csrr	a5,mstatus
    80004ca0:	0087e793          	ori	a5,a5,8
    80004ca4:	30079073          	csrw	mstatus,a5
    80004ca8:	304027f3          	csrr	a5,mie
    80004cac:	0807e793          	ori	a5,a5,128
    80004cb0:	30479073          	csrw	mie,a5
    80004cb4:	f14027f3          	csrr	a5,mhartid
    80004cb8:	0007879b          	sext.w	a5,a5
    80004cbc:	00078213          	mv	tp,a5
    80004cc0:	30200073          	mret
    80004cc4:	00813403          	ld	s0,8(sp)
    80004cc8:	01010113          	addi	sp,sp,16
    80004ccc:	00008067          	ret

0000000080004cd0 <timerinit>:
    80004cd0:	ff010113          	addi	sp,sp,-16
    80004cd4:	00813423          	sd	s0,8(sp)
    80004cd8:	01010413          	addi	s0,sp,16
    80004cdc:	f14027f3          	csrr	a5,mhartid
    80004ce0:	0200c737          	lui	a4,0x200c
    80004ce4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004ce8:	0007869b          	sext.w	a3,a5
    80004cec:	00269713          	slli	a4,a3,0x2
    80004cf0:	000f4637          	lui	a2,0xf4
    80004cf4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004cf8:	00d70733          	add	a4,a4,a3
    80004cfc:	0037979b          	slliw	a5,a5,0x3
    80004d00:	020046b7          	lui	a3,0x2004
    80004d04:	00d787b3          	add	a5,a5,a3
    80004d08:	00c585b3          	add	a1,a1,a2
    80004d0c:	00371693          	slli	a3,a4,0x3
    80004d10:	00007717          	auipc	a4,0x7
    80004d14:	12070713          	addi	a4,a4,288 # 8000be30 <timer_scratch>
    80004d18:	00b7b023          	sd	a1,0(a5)
    80004d1c:	00d70733          	add	a4,a4,a3
    80004d20:	00f73c23          	sd	a5,24(a4)
    80004d24:	02c73023          	sd	a2,32(a4)
    80004d28:	34071073          	csrw	mscratch,a4
    80004d2c:	00000797          	auipc	a5,0x0
    80004d30:	64478793          	addi	a5,a5,1604 # 80005370 <timervec>
    80004d34:	30579073          	csrw	mtvec,a5
    80004d38:	300027f3          	csrr	a5,mstatus
    80004d3c:	0087e793          	ori	a5,a5,8
    80004d40:	30079073          	csrw	mstatus,a5
    80004d44:	304027f3          	csrr	a5,mie
    80004d48:	0807e793          	ori	a5,a5,128
    80004d4c:	30479073          	csrw	mie,a5
    80004d50:	00813403          	ld	s0,8(sp)
    80004d54:	01010113          	addi	sp,sp,16
    80004d58:	00008067          	ret

0000000080004d5c <system_main>:
    80004d5c:	fe010113          	addi	sp,sp,-32
    80004d60:	00813823          	sd	s0,16(sp)
    80004d64:	00913423          	sd	s1,8(sp)
    80004d68:	00113c23          	sd	ra,24(sp)
    80004d6c:	02010413          	addi	s0,sp,32
    80004d70:	00000097          	auipc	ra,0x0
    80004d74:	0c4080e7          	jalr	196(ra) # 80004e34 <cpuid>
    80004d78:	00003497          	auipc	s1,0x3
    80004d7c:	e4848493          	addi	s1,s1,-440 # 80007bc0 <started>
    80004d80:	02050263          	beqz	a0,80004da4 <system_main+0x48>
    80004d84:	0004a783          	lw	a5,0(s1)
    80004d88:	0007879b          	sext.w	a5,a5
    80004d8c:	fe078ce3          	beqz	a5,80004d84 <system_main+0x28>
    80004d90:	0ff0000f          	fence
    80004d94:	00003517          	auipc	a0,0x3
    80004d98:	80450513          	addi	a0,a0,-2044 # 80007598 <CONSOLE_STATUS+0x588>
    80004d9c:	00001097          	auipc	ra,0x1
    80004da0:	a70080e7          	jalr	-1424(ra) # 8000580c <panic>
    80004da4:	00001097          	auipc	ra,0x1
    80004da8:	9c4080e7          	jalr	-1596(ra) # 80005768 <consoleinit>
    80004dac:	00001097          	auipc	ra,0x1
    80004db0:	150080e7          	jalr	336(ra) # 80005efc <printfinit>
    80004db4:	00002517          	auipc	a0,0x2
    80004db8:	59c50513          	addi	a0,a0,1436 # 80007350 <CONSOLE_STATUS+0x340>
    80004dbc:	00001097          	auipc	ra,0x1
    80004dc0:	aac080e7          	jalr	-1364(ra) # 80005868 <__printf>
    80004dc4:	00002517          	auipc	a0,0x2
    80004dc8:	7a450513          	addi	a0,a0,1956 # 80007568 <CONSOLE_STATUS+0x558>
    80004dcc:	00001097          	auipc	ra,0x1
    80004dd0:	a9c080e7          	jalr	-1380(ra) # 80005868 <__printf>
    80004dd4:	00002517          	auipc	a0,0x2
    80004dd8:	57c50513          	addi	a0,a0,1404 # 80007350 <CONSOLE_STATUS+0x340>
    80004ddc:	00001097          	auipc	ra,0x1
    80004de0:	a8c080e7          	jalr	-1396(ra) # 80005868 <__printf>
    80004de4:	00001097          	auipc	ra,0x1
    80004de8:	4a4080e7          	jalr	1188(ra) # 80006288 <kinit>
    80004dec:	00000097          	auipc	ra,0x0
    80004df0:	148080e7          	jalr	328(ra) # 80004f34 <trapinit>
    80004df4:	00000097          	auipc	ra,0x0
    80004df8:	16c080e7          	jalr	364(ra) # 80004f60 <trapinithart>
    80004dfc:	00000097          	auipc	ra,0x0
    80004e00:	5b4080e7          	jalr	1460(ra) # 800053b0 <plicinit>
    80004e04:	00000097          	auipc	ra,0x0
    80004e08:	5d4080e7          	jalr	1492(ra) # 800053d8 <plicinithart>
    80004e0c:	00000097          	auipc	ra,0x0
    80004e10:	078080e7          	jalr	120(ra) # 80004e84 <userinit>
    80004e14:	0ff0000f          	fence
    80004e18:	00100793          	li	a5,1
    80004e1c:	00002517          	auipc	a0,0x2
    80004e20:	76450513          	addi	a0,a0,1892 # 80007580 <CONSOLE_STATUS+0x570>
    80004e24:	00f4a023          	sw	a5,0(s1)
    80004e28:	00001097          	auipc	ra,0x1
    80004e2c:	a40080e7          	jalr	-1472(ra) # 80005868 <__printf>
    80004e30:	0000006f          	j	80004e30 <system_main+0xd4>

0000000080004e34 <cpuid>:
    80004e34:	ff010113          	addi	sp,sp,-16
    80004e38:	00813423          	sd	s0,8(sp)
    80004e3c:	01010413          	addi	s0,sp,16
    80004e40:	00020513          	mv	a0,tp
    80004e44:	00813403          	ld	s0,8(sp)
    80004e48:	0005051b          	sext.w	a0,a0
    80004e4c:	01010113          	addi	sp,sp,16
    80004e50:	00008067          	ret

0000000080004e54 <mycpu>:
    80004e54:	ff010113          	addi	sp,sp,-16
    80004e58:	00813423          	sd	s0,8(sp)
    80004e5c:	01010413          	addi	s0,sp,16
    80004e60:	00020793          	mv	a5,tp
    80004e64:	00813403          	ld	s0,8(sp)
    80004e68:	0007879b          	sext.w	a5,a5
    80004e6c:	00779793          	slli	a5,a5,0x7
    80004e70:	00008517          	auipc	a0,0x8
    80004e74:	ff050513          	addi	a0,a0,-16 # 8000ce60 <cpus>
    80004e78:	00f50533          	add	a0,a0,a5
    80004e7c:	01010113          	addi	sp,sp,16
    80004e80:	00008067          	ret

0000000080004e84 <userinit>:
    80004e84:	ff010113          	addi	sp,sp,-16
    80004e88:	00813423          	sd	s0,8(sp)
    80004e8c:	01010413          	addi	s0,sp,16
    80004e90:	00813403          	ld	s0,8(sp)
    80004e94:	01010113          	addi	sp,sp,16
    80004e98:	ffffe317          	auipc	t1,0xffffe
    80004e9c:	8a030067          	jr	-1888(t1) # 80002738 <main>

0000000080004ea0 <either_copyout>:
    80004ea0:	ff010113          	addi	sp,sp,-16
    80004ea4:	00813023          	sd	s0,0(sp)
    80004ea8:	00113423          	sd	ra,8(sp)
    80004eac:	01010413          	addi	s0,sp,16
    80004eb0:	02051663          	bnez	a0,80004edc <either_copyout+0x3c>
    80004eb4:	00058513          	mv	a0,a1
    80004eb8:	00060593          	mv	a1,a2
    80004ebc:	0006861b          	sext.w	a2,a3
    80004ec0:	00002097          	auipc	ra,0x2
    80004ec4:	c54080e7          	jalr	-940(ra) # 80006b14 <__memmove>
    80004ec8:	00813083          	ld	ra,8(sp)
    80004ecc:	00013403          	ld	s0,0(sp)
    80004ed0:	00000513          	li	a0,0
    80004ed4:	01010113          	addi	sp,sp,16
    80004ed8:	00008067          	ret
    80004edc:	00002517          	auipc	a0,0x2
    80004ee0:	6e450513          	addi	a0,a0,1764 # 800075c0 <CONSOLE_STATUS+0x5b0>
    80004ee4:	00001097          	auipc	ra,0x1
    80004ee8:	928080e7          	jalr	-1752(ra) # 8000580c <panic>

0000000080004eec <either_copyin>:
    80004eec:	ff010113          	addi	sp,sp,-16
    80004ef0:	00813023          	sd	s0,0(sp)
    80004ef4:	00113423          	sd	ra,8(sp)
    80004ef8:	01010413          	addi	s0,sp,16
    80004efc:	02059463          	bnez	a1,80004f24 <either_copyin+0x38>
    80004f00:	00060593          	mv	a1,a2
    80004f04:	0006861b          	sext.w	a2,a3
    80004f08:	00002097          	auipc	ra,0x2
    80004f0c:	c0c080e7          	jalr	-1012(ra) # 80006b14 <__memmove>
    80004f10:	00813083          	ld	ra,8(sp)
    80004f14:	00013403          	ld	s0,0(sp)
    80004f18:	00000513          	li	a0,0
    80004f1c:	01010113          	addi	sp,sp,16
    80004f20:	00008067          	ret
    80004f24:	00002517          	auipc	a0,0x2
    80004f28:	6c450513          	addi	a0,a0,1732 # 800075e8 <CONSOLE_STATUS+0x5d8>
    80004f2c:	00001097          	auipc	ra,0x1
    80004f30:	8e0080e7          	jalr	-1824(ra) # 8000580c <panic>

0000000080004f34 <trapinit>:
    80004f34:	ff010113          	addi	sp,sp,-16
    80004f38:	00813423          	sd	s0,8(sp)
    80004f3c:	01010413          	addi	s0,sp,16
    80004f40:	00813403          	ld	s0,8(sp)
    80004f44:	00002597          	auipc	a1,0x2
    80004f48:	6cc58593          	addi	a1,a1,1740 # 80007610 <CONSOLE_STATUS+0x600>
    80004f4c:	00008517          	auipc	a0,0x8
    80004f50:	f9450513          	addi	a0,a0,-108 # 8000cee0 <tickslock>
    80004f54:	01010113          	addi	sp,sp,16
    80004f58:	00001317          	auipc	t1,0x1
    80004f5c:	5c030067          	jr	1472(t1) # 80006518 <initlock>

0000000080004f60 <trapinithart>:
    80004f60:	ff010113          	addi	sp,sp,-16
    80004f64:	00813423          	sd	s0,8(sp)
    80004f68:	01010413          	addi	s0,sp,16
    80004f6c:	00000797          	auipc	a5,0x0
    80004f70:	2f478793          	addi	a5,a5,756 # 80005260 <kernelvec>
    80004f74:	10579073          	csrw	stvec,a5
    80004f78:	00813403          	ld	s0,8(sp)
    80004f7c:	01010113          	addi	sp,sp,16
    80004f80:	00008067          	ret

0000000080004f84 <usertrap>:
    80004f84:	ff010113          	addi	sp,sp,-16
    80004f88:	00813423          	sd	s0,8(sp)
    80004f8c:	01010413          	addi	s0,sp,16
    80004f90:	00813403          	ld	s0,8(sp)
    80004f94:	01010113          	addi	sp,sp,16
    80004f98:	00008067          	ret

0000000080004f9c <usertrapret>:
    80004f9c:	ff010113          	addi	sp,sp,-16
    80004fa0:	00813423          	sd	s0,8(sp)
    80004fa4:	01010413          	addi	s0,sp,16
    80004fa8:	00813403          	ld	s0,8(sp)
    80004fac:	01010113          	addi	sp,sp,16
    80004fb0:	00008067          	ret

0000000080004fb4 <kerneltrap>:
    80004fb4:	fe010113          	addi	sp,sp,-32
    80004fb8:	00813823          	sd	s0,16(sp)
    80004fbc:	00113c23          	sd	ra,24(sp)
    80004fc0:	00913423          	sd	s1,8(sp)
    80004fc4:	02010413          	addi	s0,sp,32
    80004fc8:	142025f3          	csrr	a1,scause
    80004fcc:	100027f3          	csrr	a5,sstatus
    80004fd0:	0027f793          	andi	a5,a5,2
    80004fd4:	10079c63          	bnez	a5,800050ec <kerneltrap+0x138>
    80004fd8:	142027f3          	csrr	a5,scause
    80004fdc:	0207ce63          	bltz	a5,80005018 <kerneltrap+0x64>
    80004fe0:	00002517          	auipc	a0,0x2
    80004fe4:	67850513          	addi	a0,a0,1656 # 80007658 <CONSOLE_STATUS+0x648>
    80004fe8:	00001097          	auipc	ra,0x1
    80004fec:	880080e7          	jalr	-1920(ra) # 80005868 <__printf>
    80004ff0:	141025f3          	csrr	a1,sepc
    80004ff4:	14302673          	csrr	a2,stval
    80004ff8:	00002517          	auipc	a0,0x2
    80004ffc:	67050513          	addi	a0,a0,1648 # 80007668 <CONSOLE_STATUS+0x658>
    80005000:	00001097          	auipc	ra,0x1
    80005004:	868080e7          	jalr	-1944(ra) # 80005868 <__printf>
    80005008:	00002517          	auipc	a0,0x2
    8000500c:	67850513          	addi	a0,a0,1656 # 80007680 <CONSOLE_STATUS+0x670>
    80005010:	00000097          	auipc	ra,0x0
    80005014:	7fc080e7          	jalr	2044(ra) # 8000580c <panic>
    80005018:	0ff7f713          	andi	a4,a5,255
    8000501c:	00900693          	li	a3,9
    80005020:	04d70063          	beq	a4,a3,80005060 <kerneltrap+0xac>
    80005024:	fff00713          	li	a4,-1
    80005028:	03f71713          	slli	a4,a4,0x3f
    8000502c:	00170713          	addi	a4,a4,1
    80005030:	fae798e3          	bne	a5,a4,80004fe0 <kerneltrap+0x2c>
    80005034:	00000097          	auipc	ra,0x0
    80005038:	e00080e7          	jalr	-512(ra) # 80004e34 <cpuid>
    8000503c:	06050663          	beqz	a0,800050a8 <kerneltrap+0xf4>
    80005040:	144027f3          	csrr	a5,sip
    80005044:	ffd7f793          	andi	a5,a5,-3
    80005048:	14479073          	csrw	sip,a5
    8000504c:	01813083          	ld	ra,24(sp)
    80005050:	01013403          	ld	s0,16(sp)
    80005054:	00813483          	ld	s1,8(sp)
    80005058:	02010113          	addi	sp,sp,32
    8000505c:	00008067          	ret
    80005060:	00000097          	auipc	ra,0x0
    80005064:	3c4080e7          	jalr	964(ra) # 80005424 <plic_claim>
    80005068:	00a00793          	li	a5,10
    8000506c:	00050493          	mv	s1,a0
    80005070:	06f50863          	beq	a0,a5,800050e0 <kerneltrap+0x12c>
    80005074:	fc050ce3          	beqz	a0,8000504c <kerneltrap+0x98>
    80005078:	00050593          	mv	a1,a0
    8000507c:	00002517          	auipc	a0,0x2
    80005080:	5bc50513          	addi	a0,a0,1468 # 80007638 <CONSOLE_STATUS+0x628>
    80005084:	00000097          	auipc	ra,0x0
    80005088:	7e4080e7          	jalr	2020(ra) # 80005868 <__printf>
    8000508c:	01013403          	ld	s0,16(sp)
    80005090:	01813083          	ld	ra,24(sp)
    80005094:	00048513          	mv	a0,s1
    80005098:	00813483          	ld	s1,8(sp)
    8000509c:	02010113          	addi	sp,sp,32
    800050a0:	00000317          	auipc	t1,0x0
    800050a4:	3bc30067          	jr	956(t1) # 8000545c <plic_complete>
    800050a8:	00008517          	auipc	a0,0x8
    800050ac:	e3850513          	addi	a0,a0,-456 # 8000cee0 <tickslock>
    800050b0:	00001097          	auipc	ra,0x1
    800050b4:	48c080e7          	jalr	1164(ra) # 8000653c <acquire>
    800050b8:	00003717          	auipc	a4,0x3
    800050bc:	b0c70713          	addi	a4,a4,-1268 # 80007bc4 <ticks>
    800050c0:	00072783          	lw	a5,0(a4)
    800050c4:	00008517          	auipc	a0,0x8
    800050c8:	e1c50513          	addi	a0,a0,-484 # 8000cee0 <tickslock>
    800050cc:	0017879b          	addiw	a5,a5,1
    800050d0:	00f72023          	sw	a5,0(a4)
    800050d4:	00001097          	auipc	ra,0x1
    800050d8:	534080e7          	jalr	1332(ra) # 80006608 <release>
    800050dc:	f65ff06f          	j	80005040 <kerneltrap+0x8c>
    800050e0:	00001097          	auipc	ra,0x1
    800050e4:	090080e7          	jalr	144(ra) # 80006170 <uartintr>
    800050e8:	fa5ff06f          	j	8000508c <kerneltrap+0xd8>
    800050ec:	00002517          	auipc	a0,0x2
    800050f0:	52c50513          	addi	a0,a0,1324 # 80007618 <CONSOLE_STATUS+0x608>
    800050f4:	00000097          	auipc	ra,0x0
    800050f8:	718080e7          	jalr	1816(ra) # 8000580c <panic>

00000000800050fc <clockintr>:
    800050fc:	fe010113          	addi	sp,sp,-32
    80005100:	00813823          	sd	s0,16(sp)
    80005104:	00913423          	sd	s1,8(sp)
    80005108:	00113c23          	sd	ra,24(sp)
    8000510c:	02010413          	addi	s0,sp,32
    80005110:	00008497          	auipc	s1,0x8
    80005114:	dd048493          	addi	s1,s1,-560 # 8000cee0 <tickslock>
    80005118:	00048513          	mv	a0,s1
    8000511c:	00001097          	auipc	ra,0x1
    80005120:	420080e7          	jalr	1056(ra) # 8000653c <acquire>
    80005124:	00003717          	auipc	a4,0x3
    80005128:	aa070713          	addi	a4,a4,-1376 # 80007bc4 <ticks>
    8000512c:	00072783          	lw	a5,0(a4)
    80005130:	01013403          	ld	s0,16(sp)
    80005134:	01813083          	ld	ra,24(sp)
    80005138:	00048513          	mv	a0,s1
    8000513c:	0017879b          	addiw	a5,a5,1
    80005140:	00813483          	ld	s1,8(sp)
    80005144:	00f72023          	sw	a5,0(a4)
    80005148:	02010113          	addi	sp,sp,32
    8000514c:	00001317          	auipc	t1,0x1
    80005150:	4bc30067          	jr	1212(t1) # 80006608 <release>

0000000080005154 <devintr>:
    80005154:	142027f3          	csrr	a5,scause
    80005158:	00000513          	li	a0,0
    8000515c:	0007c463          	bltz	a5,80005164 <devintr+0x10>
    80005160:	00008067          	ret
    80005164:	fe010113          	addi	sp,sp,-32
    80005168:	00813823          	sd	s0,16(sp)
    8000516c:	00113c23          	sd	ra,24(sp)
    80005170:	00913423          	sd	s1,8(sp)
    80005174:	02010413          	addi	s0,sp,32
    80005178:	0ff7f713          	andi	a4,a5,255
    8000517c:	00900693          	li	a3,9
    80005180:	04d70c63          	beq	a4,a3,800051d8 <devintr+0x84>
    80005184:	fff00713          	li	a4,-1
    80005188:	03f71713          	slli	a4,a4,0x3f
    8000518c:	00170713          	addi	a4,a4,1
    80005190:	00e78c63          	beq	a5,a4,800051a8 <devintr+0x54>
    80005194:	01813083          	ld	ra,24(sp)
    80005198:	01013403          	ld	s0,16(sp)
    8000519c:	00813483          	ld	s1,8(sp)
    800051a0:	02010113          	addi	sp,sp,32
    800051a4:	00008067          	ret
    800051a8:	00000097          	auipc	ra,0x0
    800051ac:	c8c080e7          	jalr	-884(ra) # 80004e34 <cpuid>
    800051b0:	06050663          	beqz	a0,8000521c <devintr+0xc8>
    800051b4:	144027f3          	csrr	a5,sip
    800051b8:	ffd7f793          	andi	a5,a5,-3
    800051bc:	14479073          	csrw	sip,a5
    800051c0:	01813083          	ld	ra,24(sp)
    800051c4:	01013403          	ld	s0,16(sp)
    800051c8:	00813483          	ld	s1,8(sp)
    800051cc:	00200513          	li	a0,2
    800051d0:	02010113          	addi	sp,sp,32
    800051d4:	00008067          	ret
    800051d8:	00000097          	auipc	ra,0x0
    800051dc:	24c080e7          	jalr	588(ra) # 80005424 <plic_claim>
    800051e0:	00a00793          	li	a5,10
    800051e4:	00050493          	mv	s1,a0
    800051e8:	06f50663          	beq	a0,a5,80005254 <devintr+0x100>
    800051ec:	00100513          	li	a0,1
    800051f0:	fa0482e3          	beqz	s1,80005194 <devintr+0x40>
    800051f4:	00048593          	mv	a1,s1
    800051f8:	00002517          	auipc	a0,0x2
    800051fc:	44050513          	addi	a0,a0,1088 # 80007638 <CONSOLE_STATUS+0x628>
    80005200:	00000097          	auipc	ra,0x0
    80005204:	668080e7          	jalr	1640(ra) # 80005868 <__printf>
    80005208:	00048513          	mv	a0,s1
    8000520c:	00000097          	auipc	ra,0x0
    80005210:	250080e7          	jalr	592(ra) # 8000545c <plic_complete>
    80005214:	00100513          	li	a0,1
    80005218:	f7dff06f          	j	80005194 <devintr+0x40>
    8000521c:	00008517          	auipc	a0,0x8
    80005220:	cc450513          	addi	a0,a0,-828 # 8000cee0 <tickslock>
    80005224:	00001097          	auipc	ra,0x1
    80005228:	318080e7          	jalr	792(ra) # 8000653c <acquire>
    8000522c:	00003717          	auipc	a4,0x3
    80005230:	99870713          	addi	a4,a4,-1640 # 80007bc4 <ticks>
    80005234:	00072783          	lw	a5,0(a4)
    80005238:	00008517          	auipc	a0,0x8
    8000523c:	ca850513          	addi	a0,a0,-856 # 8000cee0 <tickslock>
    80005240:	0017879b          	addiw	a5,a5,1
    80005244:	00f72023          	sw	a5,0(a4)
    80005248:	00001097          	auipc	ra,0x1
    8000524c:	3c0080e7          	jalr	960(ra) # 80006608 <release>
    80005250:	f65ff06f          	j	800051b4 <devintr+0x60>
    80005254:	00001097          	auipc	ra,0x1
    80005258:	f1c080e7          	jalr	-228(ra) # 80006170 <uartintr>
    8000525c:	fadff06f          	j	80005208 <devintr+0xb4>

0000000080005260 <kernelvec>:
    80005260:	f0010113          	addi	sp,sp,-256
    80005264:	00113023          	sd	ra,0(sp)
    80005268:	00213423          	sd	sp,8(sp)
    8000526c:	00313823          	sd	gp,16(sp)
    80005270:	00413c23          	sd	tp,24(sp)
    80005274:	02513023          	sd	t0,32(sp)
    80005278:	02613423          	sd	t1,40(sp)
    8000527c:	02713823          	sd	t2,48(sp)
    80005280:	02813c23          	sd	s0,56(sp)
    80005284:	04913023          	sd	s1,64(sp)
    80005288:	04a13423          	sd	a0,72(sp)
    8000528c:	04b13823          	sd	a1,80(sp)
    80005290:	04c13c23          	sd	a2,88(sp)
    80005294:	06d13023          	sd	a3,96(sp)
    80005298:	06e13423          	sd	a4,104(sp)
    8000529c:	06f13823          	sd	a5,112(sp)
    800052a0:	07013c23          	sd	a6,120(sp)
    800052a4:	09113023          	sd	a7,128(sp)
    800052a8:	09213423          	sd	s2,136(sp)
    800052ac:	09313823          	sd	s3,144(sp)
    800052b0:	09413c23          	sd	s4,152(sp)
    800052b4:	0b513023          	sd	s5,160(sp)
    800052b8:	0b613423          	sd	s6,168(sp)
    800052bc:	0b713823          	sd	s7,176(sp)
    800052c0:	0b813c23          	sd	s8,184(sp)
    800052c4:	0d913023          	sd	s9,192(sp)
    800052c8:	0da13423          	sd	s10,200(sp)
    800052cc:	0db13823          	sd	s11,208(sp)
    800052d0:	0dc13c23          	sd	t3,216(sp)
    800052d4:	0fd13023          	sd	t4,224(sp)
    800052d8:	0fe13423          	sd	t5,232(sp)
    800052dc:	0ff13823          	sd	t6,240(sp)
    800052e0:	cd5ff0ef          	jal	ra,80004fb4 <kerneltrap>
    800052e4:	00013083          	ld	ra,0(sp)
    800052e8:	00813103          	ld	sp,8(sp)
    800052ec:	01013183          	ld	gp,16(sp)
    800052f0:	02013283          	ld	t0,32(sp)
    800052f4:	02813303          	ld	t1,40(sp)
    800052f8:	03013383          	ld	t2,48(sp)
    800052fc:	03813403          	ld	s0,56(sp)
    80005300:	04013483          	ld	s1,64(sp)
    80005304:	04813503          	ld	a0,72(sp)
    80005308:	05013583          	ld	a1,80(sp)
    8000530c:	05813603          	ld	a2,88(sp)
    80005310:	06013683          	ld	a3,96(sp)
    80005314:	06813703          	ld	a4,104(sp)
    80005318:	07013783          	ld	a5,112(sp)
    8000531c:	07813803          	ld	a6,120(sp)
    80005320:	08013883          	ld	a7,128(sp)
    80005324:	08813903          	ld	s2,136(sp)
    80005328:	09013983          	ld	s3,144(sp)
    8000532c:	09813a03          	ld	s4,152(sp)
    80005330:	0a013a83          	ld	s5,160(sp)
    80005334:	0a813b03          	ld	s6,168(sp)
    80005338:	0b013b83          	ld	s7,176(sp)
    8000533c:	0b813c03          	ld	s8,184(sp)
    80005340:	0c013c83          	ld	s9,192(sp)
    80005344:	0c813d03          	ld	s10,200(sp)
    80005348:	0d013d83          	ld	s11,208(sp)
    8000534c:	0d813e03          	ld	t3,216(sp)
    80005350:	0e013e83          	ld	t4,224(sp)
    80005354:	0e813f03          	ld	t5,232(sp)
    80005358:	0f013f83          	ld	t6,240(sp)
    8000535c:	10010113          	addi	sp,sp,256
    80005360:	10200073          	sret
    80005364:	00000013          	nop
    80005368:	00000013          	nop
    8000536c:	00000013          	nop

0000000080005370 <timervec>:
    80005370:	34051573          	csrrw	a0,mscratch,a0
    80005374:	00b53023          	sd	a1,0(a0)
    80005378:	00c53423          	sd	a2,8(a0)
    8000537c:	00d53823          	sd	a3,16(a0)
    80005380:	01853583          	ld	a1,24(a0)
    80005384:	02053603          	ld	a2,32(a0)
    80005388:	0005b683          	ld	a3,0(a1)
    8000538c:	00c686b3          	add	a3,a3,a2
    80005390:	00d5b023          	sd	a3,0(a1)
    80005394:	00200593          	li	a1,2
    80005398:	14459073          	csrw	sip,a1
    8000539c:	01053683          	ld	a3,16(a0)
    800053a0:	00853603          	ld	a2,8(a0)
    800053a4:	00053583          	ld	a1,0(a0)
    800053a8:	34051573          	csrrw	a0,mscratch,a0
    800053ac:	30200073          	mret

00000000800053b0 <plicinit>:
    800053b0:	ff010113          	addi	sp,sp,-16
    800053b4:	00813423          	sd	s0,8(sp)
    800053b8:	01010413          	addi	s0,sp,16
    800053bc:	00813403          	ld	s0,8(sp)
    800053c0:	0c0007b7          	lui	a5,0xc000
    800053c4:	00100713          	li	a4,1
    800053c8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800053cc:	00e7a223          	sw	a4,4(a5)
    800053d0:	01010113          	addi	sp,sp,16
    800053d4:	00008067          	ret

00000000800053d8 <plicinithart>:
    800053d8:	ff010113          	addi	sp,sp,-16
    800053dc:	00813023          	sd	s0,0(sp)
    800053e0:	00113423          	sd	ra,8(sp)
    800053e4:	01010413          	addi	s0,sp,16
    800053e8:	00000097          	auipc	ra,0x0
    800053ec:	a4c080e7          	jalr	-1460(ra) # 80004e34 <cpuid>
    800053f0:	0085171b          	slliw	a4,a0,0x8
    800053f4:	0c0027b7          	lui	a5,0xc002
    800053f8:	00e787b3          	add	a5,a5,a4
    800053fc:	40200713          	li	a4,1026
    80005400:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005404:	00813083          	ld	ra,8(sp)
    80005408:	00013403          	ld	s0,0(sp)
    8000540c:	00d5151b          	slliw	a0,a0,0xd
    80005410:	0c2017b7          	lui	a5,0xc201
    80005414:	00a78533          	add	a0,a5,a0
    80005418:	00052023          	sw	zero,0(a0)
    8000541c:	01010113          	addi	sp,sp,16
    80005420:	00008067          	ret

0000000080005424 <plic_claim>:
    80005424:	ff010113          	addi	sp,sp,-16
    80005428:	00813023          	sd	s0,0(sp)
    8000542c:	00113423          	sd	ra,8(sp)
    80005430:	01010413          	addi	s0,sp,16
    80005434:	00000097          	auipc	ra,0x0
    80005438:	a00080e7          	jalr	-1536(ra) # 80004e34 <cpuid>
    8000543c:	00813083          	ld	ra,8(sp)
    80005440:	00013403          	ld	s0,0(sp)
    80005444:	00d5151b          	slliw	a0,a0,0xd
    80005448:	0c2017b7          	lui	a5,0xc201
    8000544c:	00a78533          	add	a0,a5,a0
    80005450:	00452503          	lw	a0,4(a0)
    80005454:	01010113          	addi	sp,sp,16
    80005458:	00008067          	ret

000000008000545c <plic_complete>:
    8000545c:	fe010113          	addi	sp,sp,-32
    80005460:	00813823          	sd	s0,16(sp)
    80005464:	00913423          	sd	s1,8(sp)
    80005468:	00113c23          	sd	ra,24(sp)
    8000546c:	02010413          	addi	s0,sp,32
    80005470:	00050493          	mv	s1,a0
    80005474:	00000097          	auipc	ra,0x0
    80005478:	9c0080e7          	jalr	-1600(ra) # 80004e34 <cpuid>
    8000547c:	01813083          	ld	ra,24(sp)
    80005480:	01013403          	ld	s0,16(sp)
    80005484:	00d5179b          	slliw	a5,a0,0xd
    80005488:	0c201737          	lui	a4,0xc201
    8000548c:	00f707b3          	add	a5,a4,a5
    80005490:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005494:	00813483          	ld	s1,8(sp)
    80005498:	02010113          	addi	sp,sp,32
    8000549c:	00008067          	ret

00000000800054a0 <consolewrite>:
    800054a0:	fb010113          	addi	sp,sp,-80
    800054a4:	04813023          	sd	s0,64(sp)
    800054a8:	04113423          	sd	ra,72(sp)
    800054ac:	02913c23          	sd	s1,56(sp)
    800054b0:	03213823          	sd	s2,48(sp)
    800054b4:	03313423          	sd	s3,40(sp)
    800054b8:	03413023          	sd	s4,32(sp)
    800054bc:	01513c23          	sd	s5,24(sp)
    800054c0:	05010413          	addi	s0,sp,80
    800054c4:	06c05c63          	blez	a2,8000553c <consolewrite+0x9c>
    800054c8:	00060993          	mv	s3,a2
    800054cc:	00050a13          	mv	s4,a0
    800054d0:	00058493          	mv	s1,a1
    800054d4:	00000913          	li	s2,0
    800054d8:	fff00a93          	li	s5,-1
    800054dc:	01c0006f          	j	800054f8 <consolewrite+0x58>
    800054e0:	fbf44503          	lbu	a0,-65(s0)
    800054e4:	0019091b          	addiw	s2,s2,1
    800054e8:	00148493          	addi	s1,s1,1
    800054ec:	00001097          	auipc	ra,0x1
    800054f0:	a9c080e7          	jalr	-1380(ra) # 80005f88 <uartputc>
    800054f4:	03298063          	beq	s3,s2,80005514 <consolewrite+0x74>
    800054f8:	00048613          	mv	a2,s1
    800054fc:	00100693          	li	a3,1
    80005500:	000a0593          	mv	a1,s4
    80005504:	fbf40513          	addi	a0,s0,-65
    80005508:	00000097          	auipc	ra,0x0
    8000550c:	9e4080e7          	jalr	-1564(ra) # 80004eec <either_copyin>
    80005510:	fd5518e3          	bne	a0,s5,800054e0 <consolewrite+0x40>
    80005514:	04813083          	ld	ra,72(sp)
    80005518:	04013403          	ld	s0,64(sp)
    8000551c:	03813483          	ld	s1,56(sp)
    80005520:	02813983          	ld	s3,40(sp)
    80005524:	02013a03          	ld	s4,32(sp)
    80005528:	01813a83          	ld	s5,24(sp)
    8000552c:	00090513          	mv	a0,s2
    80005530:	03013903          	ld	s2,48(sp)
    80005534:	05010113          	addi	sp,sp,80
    80005538:	00008067          	ret
    8000553c:	00000913          	li	s2,0
    80005540:	fd5ff06f          	j	80005514 <consolewrite+0x74>

0000000080005544 <consoleread>:
    80005544:	f9010113          	addi	sp,sp,-112
    80005548:	06813023          	sd	s0,96(sp)
    8000554c:	04913c23          	sd	s1,88(sp)
    80005550:	05213823          	sd	s2,80(sp)
    80005554:	05313423          	sd	s3,72(sp)
    80005558:	05413023          	sd	s4,64(sp)
    8000555c:	03513c23          	sd	s5,56(sp)
    80005560:	03613823          	sd	s6,48(sp)
    80005564:	03713423          	sd	s7,40(sp)
    80005568:	03813023          	sd	s8,32(sp)
    8000556c:	06113423          	sd	ra,104(sp)
    80005570:	01913c23          	sd	s9,24(sp)
    80005574:	07010413          	addi	s0,sp,112
    80005578:	00060b93          	mv	s7,a2
    8000557c:	00050913          	mv	s2,a0
    80005580:	00058c13          	mv	s8,a1
    80005584:	00060b1b          	sext.w	s6,a2
    80005588:	00008497          	auipc	s1,0x8
    8000558c:	98048493          	addi	s1,s1,-1664 # 8000cf08 <cons>
    80005590:	00400993          	li	s3,4
    80005594:	fff00a13          	li	s4,-1
    80005598:	00a00a93          	li	s5,10
    8000559c:	05705e63          	blez	s7,800055f8 <consoleread+0xb4>
    800055a0:	09c4a703          	lw	a4,156(s1)
    800055a4:	0984a783          	lw	a5,152(s1)
    800055a8:	0007071b          	sext.w	a4,a4
    800055ac:	08e78463          	beq	a5,a4,80005634 <consoleread+0xf0>
    800055b0:	07f7f713          	andi	a4,a5,127
    800055b4:	00e48733          	add	a4,s1,a4
    800055b8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800055bc:	0017869b          	addiw	a3,a5,1
    800055c0:	08d4ac23          	sw	a3,152(s1)
    800055c4:	00070c9b          	sext.w	s9,a4
    800055c8:	0b370663          	beq	a4,s3,80005674 <consoleread+0x130>
    800055cc:	00100693          	li	a3,1
    800055d0:	f9f40613          	addi	a2,s0,-97
    800055d4:	000c0593          	mv	a1,s8
    800055d8:	00090513          	mv	a0,s2
    800055dc:	f8e40fa3          	sb	a4,-97(s0)
    800055e0:	00000097          	auipc	ra,0x0
    800055e4:	8c0080e7          	jalr	-1856(ra) # 80004ea0 <either_copyout>
    800055e8:	01450863          	beq	a0,s4,800055f8 <consoleread+0xb4>
    800055ec:	001c0c13          	addi	s8,s8,1
    800055f0:	fffb8b9b          	addiw	s7,s7,-1
    800055f4:	fb5c94e3          	bne	s9,s5,8000559c <consoleread+0x58>
    800055f8:	000b851b          	sext.w	a0,s7
    800055fc:	06813083          	ld	ra,104(sp)
    80005600:	06013403          	ld	s0,96(sp)
    80005604:	05813483          	ld	s1,88(sp)
    80005608:	05013903          	ld	s2,80(sp)
    8000560c:	04813983          	ld	s3,72(sp)
    80005610:	04013a03          	ld	s4,64(sp)
    80005614:	03813a83          	ld	s5,56(sp)
    80005618:	02813b83          	ld	s7,40(sp)
    8000561c:	02013c03          	ld	s8,32(sp)
    80005620:	01813c83          	ld	s9,24(sp)
    80005624:	40ab053b          	subw	a0,s6,a0
    80005628:	03013b03          	ld	s6,48(sp)
    8000562c:	07010113          	addi	sp,sp,112
    80005630:	00008067          	ret
    80005634:	00001097          	auipc	ra,0x1
    80005638:	1d8080e7          	jalr	472(ra) # 8000680c <push_on>
    8000563c:	0984a703          	lw	a4,152(s1)
    80005640:	09c4a783          	lw	a5,156(s1)
    80005644:	0007879b          	sext.w	a5,a5
    80005648:	fef70ce3          	beq	a4,a5,80005640 <consoleread+0xfc>
    8000564c:	00001097          	auipc	ra,0x1
    80005650:	234080e7          	jalr	564(ra) # 80006880 <pop_on>
    80005654:	0984a783          	lw	a5,152(s1)
    80005658:	07f7f713          	andi	a4,a5,127
    8000565c:	00e48733          	add	a4,s1,a4
    80005660:	01874703          	lbu	a4,24(a4)
    80005664:	0017869b          	addiw	a3,a5,1
    80005668:	08d4ac23          	sw	a3,152(s1)
    8000566c:	00070c9b          	sext.w	s9,a4
    80005670:	f5371ee3          	bne	a4,s3,800055cc <consoleread+0x88>
    80005674:	000b851b          	sext.w	a0,s7
    80005678:	f96bf2e3          	bgeu	s7,s6,800055fc <consoleread+0xb8>
    8000567c:	08f4ac23          	sw	a5,152(s1)
    80005680:	f7dff06f          	j	800055fc <consoleread+0xb8>

0000000080005684 <consputc>:
    80005684:	10000793          	li	a5,256
    80005688:	00f50663          	beq	a0,a5,80005694 <consputc+0x10>
    8000568c:	00001317          	auipc	t1,0x1
    80005690:	9f430067          	jr	-1548(t1) # 80006080 <uartputc_sync>
    80005694:	ff010113          	addi	sp,sp,-16
    80005698:	00113423          	sd	ra,8(sp)
    8000569c:	00813023          	sd	s0,0(sp)
    800056a0:	01010413          	addi	s0,sp,16
    800056a4:	00800513          	li	a0,8
    800056a8:	00001097          	auipc	ra,0x1
    800056ac:	9d8080e7          	jalr	-1576(ra) # 80006080 <uartputc_sync>
    800056b0:	02000513          	li	a0,32
    800056b4:	00001097          	auipc	ra,0x1
    800056b8:	9cc080e7          	jalr	-1588(ra) # 80006080 <uartputc_sync>
    800056bc:	00013403          	ld	s0,0(sp)
    800056c0:	00813083          	ld	ra,8(sp)
    800056c4:	00800513          	li	a0,8
    800056c8:	01010113          	addi	sp,sp,16
    800056cc:	00001317          	auipc	t1,0x1
    800056d0:	9b430067          	jr	-1612(t1) # 80006080 <uartputc_sync>

00000000800056d4 <consoleintr>:
    800056d4:	fe010113          	addi	sp,sp,-32
    800056d8:	00813823          	sd	s0,16(sp)
    800056dc:	00913423          	sd	s1,8(sp)
    800056e0:	01213023          	sd	s2,0(sp)
    800056e4:	00113c23          	sd	ra,24(sp)
    800056e8:	02010413          	addi	s0,sp,32
    800056ec:	00008917          	auipc	s2,0x8
    800056f0:	81c90913          	addi	s2,s2,-2020 # 8000cf08 <cons>
    800056f4:	00050493          	mv	s1,a0
    800056f8:	00090513          	mv	a0,s2
    800056fc:	00001097          	auipc	ra,0x1
    80005700:	e40080e7          	jalr	-448(ra) # 8000653c <acquire>
    80005704:	02048c63          	beqz	s1,8000573c <consoleintr+0x68>
    80005708:	0a092783          	lw	a5,160(s2)
    8000570c:	09892703          	lw	a4,152(s2)
    80005710:	07f00693          	li	a3,127
    80005714:	40e7873b          	subw	a4,a5,a4
    80005718:	02e6e263          	bltu	a3,a4,8000573c <consoleintr+0x68>
    8000571c:	00d00713          	li	a4,13
    80005720:	04e48063          	beq	s1,a4,80005760 <consoleintr+0x8c>
    80005724:	07f7f713          	andi	a4,a5,127
    80005728:	00e90733          	add	a4,s2,a4
    8000572c:	0017879b          	addiw	a5,a5,1
    80005730:	0af92023          	sw	a5,160(s2)
    80005734:	00970c23          	sb	s1,24(a4)
    80005738:	08f92e23          	sw	a5,156(s2)
    8000573c:	01013403          	ld	s0,16(sp)
    80005740:	01813083          	ld	ra,24(sp)
    80005744:	00813483          	ld	s1,8(sp)
    80005748:	00013903          	ld	s2,0(sp)
    8000574c:	00007517          	auipc	a0,0x7
    80005750:	7bc50513          	addi	a0,a0,1980 # 8000cf08 <cons>
    80005754:	02010113          	addi	sp,sp,32
    80005758:	00001317          	auipc	t1,0x1
    8000575c:	eb030067          	jr	-336(t1) # 80006608 <release>
    80005760:	00a00493          	li	s1,10
    80005764:	fc1ff06f          	j	80005724 <consoleintr+0x50>

0000000080005768 <consoleinit>:
    80005768:	fe010113          	addi	sp,sp,-32
    8000576c:	00113c23          	sd	ra,24(sp)
    80005770:	00813823          	sd	s0,16(sp)
    80005774:	00913423          	sd	s1,8(sp)
    80005778:	02010413          	addi	s0,sp,32
    8000577c:	00007497          	auipc	s1,0x7
    80005780:	78c48493          	addi	s1,s1,1932 # 8000cf08 <cons>
    80005784:	00048513          	mv	a0,s1
    80005788:	00002597          	auipc	a1,0x2
    8000578c:	f0858593          	addi	a1,a1,-248 # 80007690 <CONSOLE_STATUS+0x680>
    80005790:	00001097          	auipc	ra,0x1
    80005794:	d88080e7          	jalr	-632(ra) # 80006518 <initlock>
    80005798:	00000097          	auipc	ra,0x0
    8000579c:	7ac080e7          	jalr	1964(ra) # 80005f44 <uartinit>
    800057a0:	01813083          	ld	ra,24(sp)
    800057a4:	01013403          	ld	s0,16(sp)
    800057a8:	00000797          	auipc	a5,0x0
    800057ac:	d9c78793          	addi	a5,a5,-612 # 80005544 <consoleread>
    800057b0:	0af4bc23          	sd	a5,184(s1)
    800057b4:	00000797          	auipc	a5,0x0
    800057b8:	cec78793          	addi	a5,a5,-788 # 800054a0 <consolewrite>
    800057bc:	0cf4b023          	sd	a5,192(s1)
    800057c0:	00813483          	ld	s1,8(sp)
    800057c4:	02010113          	addi	sp,sp,32
    800057c8:	00008067          	ret

00000000800057cc <console_read>:
    800057cc:	ff010113          	addi	sp,sp,-16
    800057d0:	00813423          	sd	s0,8(sp)
    800057d4:	01010413          	addi	s0,sp,16
    800057d8:	00813403          	ld	s0,8(sp)
    800057dc:	00007317          	auipc	t1,0x7
    800057e0:	7e433303          	ld	t1,2020(t1) # 8000cfc0 <devsw+0x10>
    800057e4:	01010113          	addi	sp,sp,16
    800057e8:	00030067          	jr	t1

00000000800057ec <console_write>:
    800057ec:	ff010113          	addi	sp,sp,-16
    800057f0:	00813423          	sd	s0,8(sp)
    800057f4:	01010413          	addi	s0,sp,16
    800057f8:	00813403          	ld	s0,8(sp)
    800057fc:	00007317          	auipc	t1,0x7
    80005800:	7cc33303          	ld	t1,1996(t1) # 8000cfc8 <devsw+0x18>
    80005804:	01010113          	addi	sp,sp,16
    80005808:	00030067          	jr	t1

000000008000580c <panic>:
    8000580c:	fe010113          	addi	sp,sp,-32
    80005810:	00113c23          	sd	ra,24(sp)
    80005814:	00813823          	sd	s0,16(sp)
    80005818:	00913423          	sd	s1,8(sp)
    8000581c:	02010413          	addi	s0,sp,32
    80005820:	00050493          	mv	s1,a0
    80005824:	00002517          	auipc	a0,0x2
    80005828:	e7450513          	addi	a0,a0,-396 # 80007698 <CONSOLE_STATUS+0x688>
    8000582c:	00008797          	auipc	a5,0x8
    80005830:	8207ae23          	sw	zero,-1988(a5) # 8000d068 <pr+0x18>
    80005834:	00000097          	auipc	ra,0x0
    80005838:	034080e7          	jalr	52(ra) # 80005868 <__printf>
    8000583c:	00048513          	mv	a0,s1
    80005840:	00000097          	auipc	ra,0x0
    80005844:	028080e7          	jalr	40(ra) # 80005868 <__printf>
    80005848:	00002517          	auipc	a0,0x2
    8000584c:	b0850513          	addi	a0,a0,-1272 # 80007350 <CONSOLE_STATUS+0x340>
    80005850:	00000097          	auipc	ra,0x0
    80005854:	018080e7          	jalr	24(ra) # 80005868 <__printf>
    80005858:	00100793          	li	a5,1
    8000585c:	00002717          	auipc	a4,0x2
    80005860:	36f72623          	sw	a5,876(a4) # 80007bc8 <panicked>
    80005864:	0000006f          	j	80005864 <panic+0x58>

0000000080005868 <__printf>:
    80005868:	f3010113          	addi	sp,sp,-208
    8000586c:	08813023          	sd	s0,128(sp)
    80005870:	07313423          	sd	s3,104(sp)
    80005874:	09010413          	addi	s0,sp,144
    80005878:	05813023          	sd	s8,64(sp)
    8000587c:	08113423          	sd	ra,136(sp)
    80005880:	06913c23          	sd	s1,120(sp)
    80005884:	07213823          	sd	s2,112(sp)
    80005888:	07413023          	sd	s4,96(sp)
    8000588c:	05513c23          	sd	s5,88(sp)
    80005890:	05613823          	sd	s6,80(sp)
    80005894:	05713423          	sd	s7,72(sp)
    80005898:	03913c23          	sd	s9,56(sp)
    8000589c:	03a13823          	sd	s10,48(sp)
    800058a0:	03b13423          	sd	s11,40(sp)
    800058a4:	00007317          	auipc	t1,0x7
    800058a8:	7ac30313          	addi	t1,t1,1964 # 8000d050 <pr>
    800058ac:	01832c03          	lw	s8,24(t1)
    800058b0:	00b43423          	sd	a1,8(s0)
    800058b4:	00c43823          	sd	a2,16(s0)
    800058b8:	00d43c23          	sd	a3,24(s0)
    800058bc:	02e43023          	sd	a4,32(s0)
    800058c0:	02f43423          	sd	a5,40(s0)
    800058c4:	03043823          	sd	a6,48(s0)
    800058c8:	03143c23          	sd	a7,56(s0)
    800058cc:	00050993          	mv	s3,a0
    800058d0:	4a0c1663          	bnez	s8,80005d7c <__printf+0x514>
    800058d4:	60098c63          	beqz	s3,80005eec <__printf+0x684>
    800058d8:	0009c503          	lbu	a0,0(s3)
    800058dc:	00840793          	addi	a5,s0,8
    800058e0:	f6f43c23          	sd	a5,-136(s0)
    800058e4:	00000493          	li	s1,0
    800058e8:	22050063          	beqz	a0,80005b08 <__printf+0x2a0>
    800058ec:	00002a37          	lui	s4,0x2
    800058f0:	00018ab7          	lui	s5,0x18
    800058f4:	000f4b37          	lui	s6,0xf4
    800058f8:	00989bb7          	lui	s7,0x989
    800058fc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005900:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005904:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005908:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000590c:	00148c9b          	addiw	s9,s1,1
    80005910:	02500793          	li	a5,37
    80005914:	01998933          	add	s2,s3,s9
    80005918:	38f51263          	bne	a0,a5,80005c9c <__printf+0x434>
    8000591c:	00094783          	lbu	a5,0(s2)
    80005920:	00078c9b          	sext.w	s9,a5
    80005924:	1e078263          	beqz	a5,80005b08 <__printf+0x2a0>
    80005928:	0024849b          	addiw	s1,s1,2
    8000592c:	07000713          	li	a4,112
    80005930:	00998933          	add	s2,s3,s1
    80005934:	38e78a63          	beq	a5,a4,80005cc8 <__printf+0x460>
    80005938:	20f76863          	bltu	a4,a5,80005b48 <__printf+0x2e0>
    8000593c:	42a78863          	beq	a5,a0,80005d6c <__printf+0x504>
    80005940:	06400713          	li	a4,100
    80005944:	40e79663          	bne	a5,a4,80005d50 <__printf+0x4e8>
    80005948:	f7843783          	ld	a5,-136(s0)
    8000594c:	0007a603          	lw	a2,0(a5)
    80005950:	00878793          	addi	a5,a5,8
    80005954:	f6f43c23          	sd	a5,-136(s0)
    80005958:	42064a63          	bltz	a2,80005d8c <__printf+0x524>
    8000595c:	00a00713          	li	a4,10
    80005960:	02e677bb          	remuw	a5,a2,a4
    80005964:	00002d97          	auipc	s11,0x2
    80005968:	d5cd8d93          	addi	s11,s11,-676 # 800076c0 <digits>
    8000596c:	00900593          	li	a1,9
    80005970:	0006051b          	sext.w	a0,a2
    80005974:	00000c93          	li	s9,0
    80005978:	02079793          	slli	a5,a5,0x20
    8000597c:	0207d793          	srli	a5,a5,0x20
    80005980:	00fd87b3          	add	a5,s11,a5
    80005984:	0007c783          	lbu	a5,0(a5)
    80005988:	02e656bb          	divuw	a3,a2,a4
    8000598c:	f8f40023          	sb	a5,-128(s0)
    80005990:	14c5d863          	bge	a1,a2,80005ae0 <__printf+0x278>
    80005994:	06300593          	li	a1,99
    80005998:	00100c93          	li	s9,1
    8000599c:	02e6f7bb          	remuw	a5,a3,a4
    800059a0:	02079793          	slli	a5,a5,0x20
    800059a4:	0207d793          	srli	a5,a5,0x20
    800059a8:	00fd87b3          	add	a5,s11,a5
    800059ac:	0007c783          	lbu	a5,0(a5)
    800059b0:	02e6d73b          	divuw	a4,a3,a4
    800059b4:	f8f400a3          	sb	a5,-127(s0)
    800059b8:	12a5f463          	bgeu	a1,a0,80005ae0 <__printf+0x278>
    800059bc:	00a00693          	li	a3,10
    800059c0:	00900593          	li	a1,9
    800059c4:	02d777bb          	remuw	a5,a4,a3
    800059c8:	02079793          	slli	a5,a5,0x20
    800059cc:	0207d793          	srli	a5,a5,0x20
    800059d0:	00fd87b3          	add	a5,s11,a5
    800059d4:	0007c503          	lbu	a0,0(a5)
    800059d8:	02d757bb          	divuw	a5,a4,a3
    800059dc:	f8a40123          	sb	a0,-126(s0)
    800059e0:	48e5f263          	bgeu	a1,a4,80005e64 <__printf+0x5fc>
    800059e4:	06300513          	li	a0,99
    800059e8:	02d7f5bb          	remuw	a1,a5,a3
    800059ec:	02059593          	slli	a1,a1,0x20
    800059f0:	0205d593          	srli	a1,a1,0x20
    800059f4:	00bd85b3          	add	a1,s11,a1
    800059f8:	0005c583          	lbu	a1,0(a1)
    800059fc:	02d7d7bb          	divuw	a5,a5,a3
    80005a00:	f8b401a3          	sb	a1,-125(s0)
    80005a04:	48e57263          	bgeu	a0,a4,80005e88 <__printf+0x620>
    80005a08:	3e700513          	li	a0,999
    80005a0c:	02d7f5bb          	remuw	a1,a5,a3
    80005a10:	02059593          	slli	a1,a1,0x20
    80005a14:	0205d593          	srli	a1,a1,0x20
    80005a18:	00bd85b3          	add	a1,s11,a1
    80005a1c:	0005c583          	lbu	a1,0(a1)
    80005a20:	02d7d7bb          	divuw	a5,a5,a3
    80005a24:	f8b40223          	sb	a1,-124(s0)
    80005a28:	46e57663          	bgeu	a0,a4,80005e94 <__printf+0x62c>
    80005a2c:	02d7f5bb          	remuw	a1,a5,a3
    80005a30:	02059593          	slli	a1,a1,0x20
    80005a34:	0205d593          	srli	a1,a1,0x20
    80005a38:	00bd85b3          	add	a1,s11,a1
    80005a3c:	0005c583          	lbu	a1,0(a1)
    80005a40:	02d7d7bb          	divuw	a5,a5,a3
    80005a44:	f8b402a3          	sb	a1,-123(s0)
    80005a48:	46ea7863          	bgeu	s4,a4,80005eb8 <__printf+0x650>
    80005a4c:	02d7f5bb          	remuw	a1,a5,a3
    80005a50:	02059593          	slli	a1,a1,0x20
    80005a54:	0205d593          	srli	a1,a1,0x20
    80005a58:	00bd85b3          	add	a1,s11,a1
    80005a5c:	0005c583          	lbu	a1,0(a1)
    80005a60:	02d7d7bb          	divuw	a5,a5,a3
    80005a64:	f8b40323          	sb	a1,-122(s0)
    80005a68:	3eeaf863          	bgeu	s5,a4,80005e58 <__printf+0x5f0>
    80005a6c:	02d7f5bb          	remuw	a1,a5,a3
    80005a70:	02059593          	slli	a1,a1,0x20
    80005a74:	0205d593          	srli	a1,a1,0x20
    80005a78:	00bd85b3          	add	a1,s11,a1
    80005a7c:	0005c583          	lbu	a1,0(a1)
    80005a80:	02d7d7bb          	divuw	a5,a5,a3
    80005a84:	f8b403a3          	sb	a1,-121(s0)
    80005a88:	42eb7e63          	bgeu	s6,a4,80005ec4 <__printf+0x65c>
    80005a8c:	02d7f5bb          	remuw	a1,a5,a3
    80005a90:	02059593          	slli	a1,a1,0x20
    80005a94:	0205d593          	srli	a1,a1,0x20
    80005a98:	00bd85b3          	add	a1,s11,a1
    80005a9c:	0005c583          	lbu	a1,0(a1)
    80005aa0:	02d7d7bb          	divuw	a5,a5,a3
    80005aa4:	f8b40423          	sb	a1,-120(s0)
    80005aa8:	42ebfc63          	bgeu	s7,a4,80005ee0 <__printf+0x678>
    80005aac:	02079793          	slli	a5,a5,0x20
    80005ab0:	0207d793          	srli	a5,a5,0x20
    80005ab4:	00fd8db3          	add	s11,s11,a5
    80005ab8:	000dc703          	lbu	a4,0(s11)
    80005abc:	00a00793          	li	a5,10
    80005ac0:	00900c93          	li	s9,9
    80005ac4:	f8e404a3          	sb	a4,-119(s0)
    80005ac8:	00065c63          	bgez	a2,80005ae0 <__printf+0x278>
    80005acc:	f9040713          	addi	a4,s0,-112
    80005ad0:	00f70733          	add	a4,a4,a5
    80005ad4:	02d00693          	li	a3,45
    80005ad8:	fed70823          	sb	a3,-16(a4)
    80005adc:	00078c93          	mv	s9,a5
    80005ae0:	f8040793          	addi	a5,s0,-128
    80005ae4:	01978cb3          	add	s9,a5,s9
    80005ae8:	f7f40d13          	addi	s10,s0,-129
    80005aec:	000cc503          	lbu	a0,0(s9)
    80005af0:	fffc8c93          	addi	s9,s9,-1
    80005af4:	00000097          	auipc	ra,0x0
    80005af8:	b90080e7          	jalr	-1136(ra) # 80005684 <consputc>
    80005afc:	ffac98e3          	bne	s9,s10,80005aec <__printf+0x284>
    80005b00:	00094503          	lbu	a0,0(s2)
    80005b04:	e00514e3          	bnez	a0,8000590c <__printf+0xa4>
    80005b08:	1a0c1663          	bnez	s8,80005cb4 <__printf+0x44c>
    80005b0c:	08813083          	ld	ra,136(sp)
    80005b10:	08013403          	ld	s0,128(sp)
    80005b14:	07813483          	ld	s1,120(sp)
    80005b18:	07013903          	ld	s2,112(sp)
    80005b1c:	06813983          	ld	s3,104(sp)
    80005b20:	06013a03          	ld	s4,96(sp)
    80005b24:	05813a83          	ld	s5,88(sp)
    80005b28:	05013b03          	ld	s6,80(sp)
    80005b2c:	04813b83          	ld	s7,72(sp)
    80005b30:	04013c03          	ld	s8,64(sp)
    80005b34:	03813c83          	ld	s9,56(sp)
    80005b38:	03013d03          	ld	s10,48(sp)
    80005b3c:	02813d83          	ld	s11,40(sp)
    80005b40:	0d010113          	addi	sp,sp,208
    80005b44:	00008067          	ret
    80005b48:	07300713          	li	a4,115
    80005b4c:	1ce78a63          	beq	a5,a4,80005d20 <__printf+0x4b8>
    80005b50:	07800713          	li	a4,120
    80005b54:	1ee79e63          	bne	a5,a4,80005d50 <__printf+0x4e8>
    80005b58:	f7843783          	ld	a5,-136(s0)
    80005b5c:	0007a703          	lw	a4,0(a5)
    80005b60:	00878793          	addi	a5,a5,8
    80005b64:	f6f43c23          	sd	a5,-136(s0)
    80005b68:	28074263          	bltz	a4,80005dec <__printf+0x584>
    80005b6c:	00002d97          	auipc	s11,0x2
    80005b70:	b54d8d93          	addi	s11,s11,-1196 # 800076c0 <digits>
    80005b74:	00f77793          	andi	a5,a4,15
    80005b78:	00fd87b3          	add	a5,s11,a5
    80005b7c:	0007c683          	lbu	a3,0(a5)
    80005b80:	00f00613          	li	a2,15
    80005b84:	0007079b          	sext.w	a5,a4
    80005b88:	f8d40023          	sb	a3,-128(s0)
    80005b8c:	0047559b          	srliw	a1,a4,0x4
    80005b90:	0047569b          	srliw	a3,a4,0x4
    80005b94:	00000c93          	li	s9,0
    80005b98:	0ee65063          	bge	a2,a4,80005c78 <__printf+0x410>
    80005b9c:	00f6f693          	andi	a3,a3,15
    80005ba0:	00dd86b3          	add	a3,s11,a3
    80005ba4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005ba8:	0087d79b          	srliw	a5,a5,0x8
    80005bac:	00100c93          	li	s9,1
    80005bb0:	f8d400a3          	sb	a3,-127(s0)
    80005bb4:	0cb67263          	bgeu	a2,a1,80005c78 <__printf+0x410>
    80005bb8:	00f7f693          	andi	a3,a5,15
    80005bbc:	00dd86b3          	add	a3,s11,a3
    80005bc0:	0006c583          	lbu	a1,0(a3)
    80005bc4:	00f00613          	li	a2,15
    80005bc8:	0047d69b          	srliw	a3,a5,0x4
    80005bcc:	f8b40123          	sb	a1,-126(s0)
    80005bd0:	0047d593          	srli	a1,a5,0x4
    80005bd4:	28f67e63          	bgeu	a2,a5,80005e70 <__printf+0x608>
    80005bd8:	00f6f693          	andi	a3,a3,15
    80005bdc:	00dd86b3          	add	a3,s11,a3
    80005be0:	0006c503          	lbu	a0,0(a3)
    80005be4:	0087d813          	srli	a6,a5,0x8
    80005be8:	0087d69b          	srliw	a3,a5,0x8
    80005bec:	f8a401a3          	sb	a0,-125(s0)
    80005bf0:	28b67663          	bgeu	a2,a1,80005e7c <__printf+0x614>
    80005bf4:	00f6f693          	andi	a3,a3,15
    80005bf8:	00dd86b3          	add	a3,s11,a3
    80005bfc:	0006c583          	lbu	a1,0(a3)
    80005c00:	00c7d513          	srli	a0,a5,0xc
    80005c04:	00c7d69b          	srliw	a3,a5,0xc
    80005c08:	f8b40223          	sb	a1,-124(s0)
    80005c0c:	29067a63          	bgeu	a2,a6,80005ea0 <__printf+0x638>
    80005c10:	00f6f693          	andi	a3,a3,15
    80005c14:	00dd86b3          	add	a3,s11,a3
    80005c18:	0006c583          	lbu	a1,0(a3)
    80005c1c:	0107d813          	srli	a6,a5,0x10
    80005c20:	0107d69b          	srliw	a3,a5,0x10
    80005c24:	f8b402a3          	sb	a1,-123(s0)
    80005c28:	28a67263          	bgeu	a2,a0,80005eac <__printf+0x644>
    80005c2c:	00f6f693          	andi	a3,a3,15
    80005c30:	00dd86b3          	add	a3,s11,a3
    80005c34:	0006c683          	lbu	a3,0(a3)
    80005c38:	0147d79b          	srliw	a5,a5,0x14
    80005c3c:	f8d40323          	sb	a3,-122(s0)
    80005c40:	21067663          	bgeu	a2,a6,80005e4c <__printf+0x5e4>
    80005c44:	02079793          	slli	a5,a5,0x20
    80005c48:	0207d793          	srli	a5,a5,0x20
    80005c4c:	00fd8db3          	add	s11,s11,a5
    80005c50:	000dc683          	lbu	a3,0(s11)
    80005c54:	00800793          	li	a5,8
    80005c58:	00700c93          	li	s9,7
    80005c5c:	f8d403a3          	sb	a3,-121(s0)
    80005c60:	00075c63          	bgez	a4,80005c78 <__printf+0x410>
    80005c64:	f9040713          	addi	a4,s0,-112
    80005c68:	00f70733          	add	a4,a4,a5
    80005c6c:	02d00693          	li	a3,45
    80005c70:	fed70823          	sb	a3,-16(a4)
    80005c74:	00078c93          	mv	s9,a5
    80005c78:	f8040793          	addi	a5,s0,-128
    80005c7c:	01978cb3          	add	s9,a5,s9
    80005c80:	f7f40d13          	addi	s10,s0,-129
    80005c84:	000cc503          	lbu	a0,0(s9)
    80005c88:	fffc8c93          	addi	s9,s9,-1
    80005c8c:	00000097          	auipc	ra,0x0
    80005c90:	9f8080e7          	jalr	-1544(ra) # 80005684 <consputc>
    80005c94:	ff9d18e3          	bne	s10,s9,80005c84 <__printf+0x41c>
    80005c98:	0100006f          	j	80005ca8 <__printf+0x440>
    80005c9c:	00000097          	auipc	ra,0x0
    80005ca0:	9e8080e7          	jalr	-1560(ra) # 80005684 <consputc>
    80005ca4:	000c8493          	mv	s1,s9
    80005ca8:	00094503          	lbu	a0,0(s2)
    80005cac:	c60510e3          	bnez	a0,8000590c <__printf+0xa4>
    80005cb0:	e40c0ee3          	beqz	s8,80005b0c <__printf+0x2a4>
    80005cb4:	00007517          	auipc	a0,0x7
    80005cb8:	39c50513          	addi	a0,a0,924 # 8000d050 <pr>
    80005cbc:	00001097          	auipc	ra,0x1
    80005cc0:	94c080e7          	jalr	-1716(ra) # 80006608 <release>
    80005cc4:	e49ff06f          	j	80005b0c <__printf+0x2a4>
    80005cc8:	f7843783          	ld	a5,-136(s0)
    80005ccc:	03000513          	li	a0,48
    80005cd0:	01000d13          	li	s10,16
    80005cd4:	00878713          	addi	a4,a5,8
    80005cd8:	0007bc83          	ld	s9,0(a5)
    80005cdc:	f6e43c23          	sd	a4,-136(s0)
    80005ce0:	00000097          	auipc	ra,0x0
    80005ce4:	9a4080e7          	jalr	-1628(ra) # 80005684 <consputc>
    80005ce8:	07800513          	li	a0,120
    80005cec:	00000097          	auipc	ra,0x0
    80005cf0:	998080e7          	jalr	-1640(ra) # 80005684 <consputc>
    80005cf4:	00002d97          	auipc	s11,0x2
    80005cf8:	9ccd8d93          	addi	s11,s11,-1588 # 800076c0 <digits>
    80005cfc:	03ccd793          	srli	a5,s9,0x3c
    80005d00:	00fd87b3          	add	a5,s11,a5
    80005d04:	0007c503          	lbu	a0,0(a5)
    80005d08:	fffd0d1b          	addiw	s10,s10,-1
    80005d0c:	004c9c93          	slli	s9,s9,0x4
    80005d10:	00000097          	auipc	ra,0x0
    80005d14:	974080e7          	jalr	-1676(ra) # 80005684 <consputc>
    80005d18:	fe0d12e3          	bnez	s10,80005cfc <__printf+0x494>
    80005d1c:	f8dff06f          	j	80005ca8 <__printf+0x440>
    80005d20:	f7843783          	ld	a5,-136(s0)
    80005d24:	0007bc83          	ld	s9,0(a5)
    80005d28:	00878793          	addi	a5,a5,8
    80005d2c:	f6f43c23          	sd	a5,-136(s0)
    80005d30:	000c9a63          	bnez	s9,80005d44 <__printf+0x4dc>
    80005d34:	1080006f          	j	80005e3c <__printf+0x5d4>
    80005d38:	001c8c93          	addi	s9,s9,1
    80005d3c:	00000097          	auipc	ra,0x0
    80005d40:	948080e7          	jalr	-1720(ra) # 80005684 <consputc>
    80005d44:	000cc503          	lbu	a0,0(s9)
    80005d48:	fe0518e3          	bnez	a0,80005d38 <__printf+0x4d0>
    80005d4c:	f5dff06f          	j	80005ca8 <__printf+0x440>
    80005d50:	02500513          	li	a0,37
    80005d54:	00000097          	auipc	ra,0x0
    80005d58:	930080e7          	jalr	-1744(ra) # 80005684 <consputc>
    80005d5c:	000c8513          	mv	a0,s9
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	924080e7          	jalr	-1756(ra) # 80005684 <consputc>
    80005d68:	f41ff06f          	j	80005ca8 <__printf+0x440>
    80005d6c:	02500513          	li	a0,37
    80005d70:	00000097          	auipc	ra,0x0
    80005d74:	914080e7          	jalr	-1772(ra) # 80005684 <consputc>
    80005d78:	f31ff06f          	j	80005ca8 <__printf+0x440>
    80005d7c:	00030513          	mv	a0,t1
    80005d80:	00000097          	auipc	ra,0x0
    80005d84:	7bc080e7          	jalr	1980(ra) # 8000653c <acquire>
    80005d88:	b4dff06f          	j	800058d4 <__printf+0x6c>
    80005d8c:	40c0053b          	negw	a0,a2
    80005d90:	00a00713          	li	a4,10
    80005d94:	02e576bb          	remuw	a3,a0,a4
    80005d98:	00002d97          	auipc	s11,0x2
    80005d9c:	928d8d93          	addi	s11,s11,-1752 # 800076c0 <digits>
    80005da0:	ff700593          	li	a1,-9
    80005da4:	02069693          	slli	a3,a3,0x20
    80005da8:	0206d693          	srli	a3,a3,0x20
    80005dac:	00dd86b3          	add	a3,s11,a3
    80005db0:	0006c683          	lbu	a3,0(a3)
    80005db4:	02e557bb          	divuw	a5,a0,a4
    80005db8:	f8d40023          	sb	a3,-128(s0)
    80005dbc:	10b65e63          	bge	a2,a1,80005ed8 <__printf+0x670>
    80005dc0:	06300593          	li	a1,99
    80005dc4:	02e7f6bb          	remuw	a3,a5,a4
    80005dc8:	02069693          	slli	a3,a3,0x20
    80005dcc:	0206d693          	srli	a3,a3,0x20
    80005dd0:	00dd86b3          	add	a3,s11,a3
    80005dd4:	0006c683          	lbu	a3,0(a3)
    80005dd8:	02e7d73b          	divuw	a4,a5,a4
    80005ddc:	00200793          	li	a5,2
    80005de0:	f8d400a3          	sb	a3,-127(s0)
    80005de4:	bca5ece3          	bltu	a1,a0,800059bc <__printf+0x154>
    80005de8:	ce5ff06f          	j	80005acc <__printf+0x264>
    80005dec:	40e007bb          	negw	a5,a4
    80005df0:	00002d97          	auipc	s11,0x2
    80005df4:	8d0d8d93          	addi	s11,s11,-1840 # 800076c0 <digits>
    80005df8:	00f7f693          	andi	a3,a5,15
    80005dfc:	00dd86b3          	add	a3,s11,a3
    80005e00:	0006c583          	lbu	a1,0(a3)
    80005e04:	ff100613          	li	a2,-15
    80005e08:	0047d69b          	srliw	a3,a5,0x4
    80005e0c:	f8b40023          	sb	a1,-128(s0)
    80005e10:	0047d59b          	srliw	a1,a5,0x4
    80005e14:	0ac75e63          	bge	a4,a2,80005ed0 <__printf+0x668>
    80005e18:	00f6f693          	andi	a3,a3,15
    80005e1c:	00dd86b3          	add	a3,s11,a3
    80005e20:	0006c603          	lbu	a2,0(a3)
    80005e24:	00f00693          	li	a3,15
    80005e28:	0087d79b          	srliw	a5,a5,0x8
    80005e2c:	f8c400a3          	sb	a2,-127(s0)
    80005e30:	d8b6e4e3          	bltu	a3,a1,80005bb8 <__printf+0x350>
    80005e34:	00200793          	li	a5,2
    80005e38:	e2dff06f          	j	80005c64 <__printf+0x3fc>
    80005e3c:	00002c97          	auipc	s9,0x2
    80005e40:	864c8c93          	addi	s9,s9,-1948 # 800076a0 <CONSOLE_STATUS+0x690>
    80005e44:	02800513          	li	a0,40
    80005e48:	ef1ff06f          	j	80005d38 <__printf+0x4d0>
    80005e4c:	00700793          	li	a5,7
    80005e50:	00600c93          	li	s9,6
    80005e54:	e0dff06f          	j	80005c60 <__printf+0x3f8>
    80005e58:	00700793          	li	a5,7
    80005e5c:	00600c93          	li	s9,6
    80005e60:	c69ff06f          	j	80005ac8 <__printf+0x260>
    80005e64:	00300793          	li	a5,3
    80005e68:	00200c93          	li	s9,2
    80005e6c:	c5dff06f          	j	80005ac8 <__printf+0x260>
    80005e70:	00300793          	li	a5,3
    80005e74:	00200c93          	li	s9,2
    80005e78:	de9ff06f          	j	80005c60 <__printf+0x3f8>
    80005e7c:	00400793          	li	a5,4
    80005e80:	00300c93          	li	s9,3
    80005e84:	dddff06f          	j	80005c60 <__printf+0x3f8>
    80005e88:	00400793          	li	a5,4
    80005e8c:	00300c93          	li	s9,3
    80005e90:	c39ff06f          	j	80005ac8 <__printf+0x260>
    80005e94:	00500793          	li	a5,5
    80005e98:	00400c93          	li	s9,4
    80005e9c:	c2dff06f          	j	80005ac8 <__printf+0x260>
    80005ea0:	00500793          	li	a5,5
    80005ea4:	00400c93          	li	s9,4
    80005ea8:	db9ff06f          	j	80005c60 <__printf+0x3f8>
    80005eac:	00600793          	li	a5,6
    80005eb0:	00500c93          	li	s9,5
    80005eb4:	dadff06f          	j	80005c60 <__printf+0x3f8>
    80005eb8:	00600793          	li	a5,6
    80005ebc:	00500c93          	li	s9,5
    80005ec0:	c09ff06f          	j	80005ac8 <__printf+0x260>
    80005ec4:	00800793          	li	a5,8
    80005ec8:	00700c93          	li	s9,7
    80005ecc:	bfdff06f          	j	80005ac8 <__printf+0x260>
    80005ed0:	00100793          	li	a5,1
    80005ed4:	d91ff06f          	j	80005c64 <__printf+0x3fc>
    80005ed8:	00100793          	li	a5,1
    80005edc:	bf1ff06f          	j	80005acc <__printf+0x264>
    80005ee0:	00900793          	li	a5,9
    80005ee4:	00800c93          	li	s9,8
    80005ee8:	be1ff06f          	j	80005ac8 <__printf+0x260>
    80005eec:	00001517          	auipc	a0,0x1
    80005ef0:	7bc50513          	addi	a0,a0,1980 # 800076a8 <CONSOLE_STATUS+0x698>
    80005ef4:	00000097          	auipc	ra,0x0
    80005ef8:	918080e7          	jalr	-1768(ra) # 8000580c <panic>

0000000080005efc <printfinit>:
    80005efc:	fe010113          	addi	sp,sp,-32
    80005f00:	00813823          	sd	s0,16(sp)
    80005f04:	00913423          	sd	s1,8(sp)
    80005f08:	00113c23          	sd	ra,24(sp)
    80005f0c:	02010413          	addi	s0,sp,32
    80005f10:	00007497          	auipc	s1,0x7
    80005f14:	14048493          	addi	s1,s1,320 # 8000d050 <pr>
    80005f18:	00048513          	mv	a0,s1
    80005f1c:	00001597          	auipc	a1,0x1
    80005f20:	79c58593          	addi	a1,a1,1948 # 800076b8 <CONSOLE_STATUS+0x6a8>
    80005f24:	00000097          	auipc	ra,0x0
    80005f28:	5f4080e7          	jalr	1524(ra) # 80006518 <initlock>
    80005f2c:	01813083          	ld	ra,24(sp)
    80005f30:	01013403          	ld	s0,16(sp)
    80005f34:	0004ac23          	sw	zero,24(s1)
    80005f38:	00813483          	ld	s1,8(sp)
    80005f3c:	02010113          	addi	sp,sp,32
    80005f40:	00008067          	ret

0000000080005f44 <uartinit>:
    80005f44:	ff010113          	addi	sp,sp,-16
    80005f48:	00813423          	sd	s0,8(sp)
    80005f4c:	01010413          	addi	s0,sp,16
    80005f50:	100007b7          	lui	a5,0x10000
    80005f54:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005f58:	f8000713          	li	a4,-128
    80005f5c:	00e781a3          	sb	a4,3(a5)
    80005f60:	00300713          	li	a4,3
    80005f64:	00e78023          	sb	a4,0(a5)
    80005f68:	000780a3          	sb	zero,1(a5)
    80005f6c:	00e781a3          	sb	a4,3(a5)
    80005f70:	00700693          	li	a3,7
    80005f74:	00d78123          	sb	a3,2(a5)
    80005f78:	00e780a3          	sb	a4,1(a5)
    80005f7c:	00813403          	ld	s0,8(sp)
    80005f80:	01010113          	addi	sp,sp,16
    80005f84:	00008067          	ret

0000000080005f88 <uartputc>:
    80005f88:	00002797          	auipc	a5,0x2
    80005f8c:	c407a783          	lw	a5,-960(a5) # 80007bc8 <panicked>
    80005f90:	00078463          	beqz	a5,80005f98 <uartputc+0x10>
    80005f94:	0000006f          	j	80005f94 <uartputc+0xc>
    80005f98:	fd010113          	addi	sp,sp,-48
    80005f9c:	02813023          	sd	s0,32(sp)
    80005fa0:	00913c23          	sd	s1,24(sp)
    80005fa4:	01213823          	sd	s2,16(sp)
    80005fa8:	01313423          	sd	s3,8(sp)
    80005fac:	02113423          	sd	ra,40(sp)
    80005fb0:	03010413          	addi	s0,sp,48
    80005fb4:	00002917          	auipc	s2,0x2
    80005fb8:	c1c90913          	addi	s2,s2,-996 # 80007bd0 <uart_tx_r>
    80005fbc:	00093783          	ld	a5,0(s2)
    80005fc0:	00002497          	auipc	s1,0x2
    80005fc4:	c1848493          	addi	s1,s1,-1000 # 80007bd8 <uart_tx_w>
    80005fc8:	0004b703          	ld	a4,0(s1)
    80005fcc:	02078693          	addi	a3,a5,32
    80005fd0:	00050993          	mv	s3,a0
    80005fd4:	02e69c63          	bne	a3,a4,8000600c <uartputc+0x84>
    80005fd8:	00001097          	auipc	ra,0x1
    80005fdc:	834080e7          	jalr	-1996(ra) # 8000680c <push_on>
    80005fe0:	00093783          	ld	a5,0(s2)
    80005fe4:	0004b703          	ld	a4,0(s1)
    80005fe8:	02078793          	addi	a5,a5,32
    80005fec:	00e79463          	bne	a5,a4,80005ff4 <uartputc+0x6c>
    80005ff0:	0000006f          	j	80005ff0 <uartputc+0x68>
    80005ff4:	00001097          	auipc	ra,0x1
    80005ff8:	88c080e7          	jalr	-1908(ra) # 80006880 <pop_on>
    80005ffc:	00093783          	ld	a5,0(s2)
    80006000:	0004b703          	ld	a4,0(s1)
    80006004:	02078693          	addi	a3,a5,32
    80006008:	fce688e3          	beq	a3,a4,80005fd8 <uartputc+0x50>
    8000600c:	01f77693          	andi	a3,a4,31
    80006010:	00007597          	auipc	a1,0x7
    80006014:	06058593          	addi	a1,a1,96 # 8000d070 <uart_tx_buf>
    80006018:	00d586b3          	add	a3,a1,a3
    8000601c:	00170713          	addi	a4,a4,1
    80006020:	01368023          	sb	s3,0(a3)
    80006024:	00e4b023          	sd	a4,0(s1)
    80006028:	10000637          	lui	a2,0x10000
    8000602c:	02f71063          	bne	a4,a5,8000604c <uartputc+0xc4>
    80006030:	0340006f          	j	80006064 <uartputc+0xdc>
    80006034:	00074703          	lbu	a4,0(a4)
    80006038:	00f93023          	sd	a5,0(s2)
    8000603c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006040:	00093783          	ld	a5,0(s2)
    80006044:	0004b703          	ld	a4,0(s1)
    80006048:	00f70e63          	beq	a4,a5,80006064 <uartputc+0xdc>
    8000604c:	00564683          	lbu	a3,5(a2)
    80006050:	01f7f713          	andi	a4,a5,31
    80006054:	00e58733          	add	a4,a1,a4
    80006058:	0206f693          	andi	a3,a3,32
    8000605c:	00178793          	addi	a5,a5,1
    80006060:	fc069ae3          	bnez	a3,80006034 <uartputc+0xac>
    80006064:	02813083          	ld	ra,40(sp)
    80006068:	02013403          	ld	s0,32(sp)
    8000606c:	01813483          	ld	s1,24(sp)
    80006070:	01013903          	ld	s2,16(sp)
    80006074:	00813983          	ld	s3,8(sp)
    80006078:	03010113          	addi	sp,sp,48
    8000607c:	00008067          	ret

0000000080006080 <uartputc_sync>:
    80006080:	ff010113          	addi	sp,sp,-16
    80006084:	00813423          	sd	s0,8(sp)
    80006088:	01010413          	addi	s0,sp,16
    8000608c:	00002717          	auipc	a4,0x2
    80006090:	b3c72703          	lw	a4,-1220(a4) # 80007bc8 <panicked>
    80006094:	02071663          	bnez	a4,800060c0 <uartputc_sync+0x40>
    80006098:	00050793          	mv	a5,a0
    8000609c:	100006b7          	lui	a3,0x10000
    800060a0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800060a4:	02077713          	andi	a4,a4,32
    800060a8:	fe070ce3          	beqz	a4,800060a0 <uartputc_sync+0x20>
    800060ac:	0ff7f793          	andi	a5,a5,255
    800060b0:	00f68023          	sb	a5,0(a3)
    800060b4:	00813403          	ld	s0,8(sp)
    800060b8:	01010113          	addi	sp,sp,16
    800060bc:	00008067          	ret
    800060c0:	0000006f          	j	800060c0 <uartputc_sync+0x40>

00000000800060c4 <uartstart>:
    800060c4:	ff010113          	addi	sp,sp,-16
    800060c8:	00813423          	sd	s0,8(sp)
    800060cc:	01010413          	addi	s0,sp,16
    800060d0:	00002617          	auipc	a2,0x2
    800060d4:	b0060613          	addi	a2,a2,-1280 # 80007bd0 <uart_tx_r>
    800060d8:	00002517          	auipc	a0,0x2
    800060dc:	b0050513          	addi	a0,a0,-1280 # 80007bd8 <uart_tx_w>
    800060e0:	00063783          	ld	a5,0(a2)
    800060e4:	00053703          	ld	a4,0(a0)
    800060e8:	04f70263          	beq	a4,a5,8000612c <uartstart+0x68>
    800060ec:	100005b7          	lui	a1,0x10000
    800060f0:	00007817          	auipc	a6,0x7
    800060f4:	f8080813          	addi	a6,a6,-128 # 8000d070 <uart_tx_buf>
    800060f8:	01c0006f          	j	80006114 <uartstart+0x50>
    800060fc:	0006c703          	lbu	a4,0(a3)
    80006100:	00f63023          	sd	a5,0(a2)
    80006104:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006108:	00063783          	ld	a5,0(a2)
    8000610c:	00053703          	ld	a4,0(a0)
    80006110:	00f70e63          	beq	a4,a5,8000612c <uartstart+0x68>
    80006114:	01f7f713          	andi	a4,a5,31
    80006118:	00e806b3          	add	a3,a6,a4
    8000611c:	0055c703          	lbu	a4,5(a1)
    80006120:	00178793          	addi	a5,a5,1
    80006124:	02077713          	andi	a4,a4,32
    80006128:	fc071ae3          	bnez	a4,800060fc <uartstart+0x38>
    8000612c:	00813403          	ld	s0,8(sp)
    80006130:	01010113          	addi	sp,sp,16
    80006134:	00008067          	ret

0000000080006138 <uartgetc>:
    80006138:	ff010113          	addi	sp,sp,-16
    8000613c:	00813423          	sd	s0,8(sp)
    80006140:	01010413          	addi	s0,sp,16
    80006144:	10000737          	lui	a4,0x10000
    80006148:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000614c:	0017f793          	andi	a5,a5,1
    80006150:	00078c63          	beqz	a5,80006168 <uartgetc+0x30>
    80006154:	00074503          	lbu	a0,0(a4)
    80006158:	0ff57513          	andi	a0,a0,255
    8000615c:	00813403          	ld	s0,8(sp)
    80006160:	01010113          	addi	sp,sp,16
    80006164:	00008067          	ret
    80006168:	fff00513          	li	a0,-1
    8000616c:	ff1ff06f          	j	8000615c <uartgetc+0x24>

0000000080006170 <uartintr>:
    80006170:	100007b7          	lui	a5,0x10000
    80006174:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006178:	0017f793          	andi	a5,a5,1
    8000617c:	0a078463          	beqz	a5,80006224 <uartintr+0xb4>
    80006180:	fe010113          	addi	sp,sp,-32
    80006184:	00813823          	sd	s0,16(sp)
    80006188:	00913423          	sd	s1,8(sp)
    8000618c:	00113c23          	sd	ra,24(sp)
    80006190:	02010413          	addi	s0,sp,32
    80006194:	100004b7          	lui	s1,0x10000
    80006198:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000619c:	0ff57513          	andi	a0,a0,255
    800061a0:	fffff097          	auipc	ra,0xfffff
    800061a4:	534080e7          	jalr	1332(ra) # 800056d4 <consoleintr>
    800061a8:	0054c783          	lbu	a5,5(s1)
    800061ac:	0017f793          	andi	a5,a5,1
    800061b0:	fe0794e3          	bnez	a5,80006198 <uartintr+0x28>
    800061b4:	00002617          	auipc	a2,0x2
    800061b8:	a1c60613          	addi	a2,a2,-1508 # 80007bd0 <uart_tx_r>
    800061bc:	00002517          	auipc	a0,0x2
    800061c0:	a1c50513          	addi	a0,a0,-1508 # 80007bd8 <uart_tx_w>
    800061c4:	00063783          	ld	a5,0(a2)
    800061c8:	00053703          	ld	a4,0(a0)
    800061cc:	04f70263          	beq	a4,a5,80006210 <uartintr+0xa0>
    800061d0:	100005b7          	lui	a1,0x10000
    800061d4:	00007817          	auipc	a6,0x7
    800061d8:	e9c80813          	addi	a6,a6,-356 # 8000d070 <uart_tx_buf>
    800061dc:	01c0006f          	j	800061f8 <uartintr+0x88>
    800061e0:	0006c703          	lbu	a4,0(a3)
    800061e4:	00f63023          	sd	a5,0(a2)
    800061e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800061ec:	00063783          	ld	a5,0(a2)
    800061f0:	00053703          	ld	a4,0(a0)
    800061f4:	00f70e63          	beq	a4,a5,80006210 <uartintr+0xa0>
    800061f8:	01f7f713          	andi	a4,a5,31
    800061fc:	00e806b3          	add	a3,a6,a4
    80006200:	0055c703          	lbu	a4,5(a1)
    80006204:	00178793          	addi	a5,a5,1
    80006208:	02077713          	andi	a4,a4,32
    8000620c:	fc071ae3          	bnez	a4,800061e0 <uartintr+0x70>
    80006210:	01813083          	ld	ra,24(sp)
    80006214:	01013403          	ld	s0,16(sp)
    80006218:	00813483          	ld	s1,8(sp)
    8000621c:	02010113          	addi	sp,sp,32
    80006220:	00008067          	ret
    80006224:	00002617          	auipc	a2,0x2
    80006228:	9ac60613          	addi	a2,a2,-1620 # 80007bd0 <uart_tx_r>
    8000622c:	00002517          	auipc	a0,0x2
    80006230:	9ac50513          	addi	a0,a0,-1620 # 80007bd8 <uart_tx_w>
    80006234:	00063783          	ld	a5,0(a2)
    80006238:	00053703          	ld	a4,0(a0)
    8000623c:	04f70263          	beq	a4,a5,80006280 <uartintr+0x110>
    80006240:	100005b7          	lui	a1,0x10000
    80006244:	00007817          	auipc	a6,0x7
    80006248:	e2c80813          	addi	a6,a6,-468 # 8000d070 <uart_tx_buf>
    8000624c:	01c0006f          	j	80006268 <uartintr+0xf8>
    80006250:	0006c703          	lbu	a4,0(a3)
    80006254:	00f63023          	sd	a5,0(a2)
    80006258:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000625c:	00063783          	ld	a5,0(a2)
    80006260:	00053703          	ld	a4,0(a0)
    80006264:	02f70063          	beq	a4,a5,80006284 <uartintr+0x114>
    80006268:	01f7f713          	andi	a4,a5,31
    8000626c:	00e806b3          	add	a3,a6,a4
    80006270:	0055c703          	lbu	a4,5(a1)
    80006274:	00178793          	addi	a5,a5,1
    80006278:	02077713          	andi	a4,a4,32
    8000627c:	fc071ae3          	bnez	a4,80006250 <uartintr+0xe0>
    80006280:	00008067          	ret
    80006284:	00008067          	ret

0000000080006288 <kinit>:
    80006288:	fc010113          	addi	sp,sp,-64
    8000628c:	02913423          	sd	s1,40(sp)
    80006290:	fffff7b7          	lui	a5,0xfffff
    80006294:	0000f497          	auipc	s1,0xf
    80006298:	d6b48493          	addi	s1,s1,-661 # 80014fff <end+0xfff>
    8000629c:	02813823          	sd	s0,48(sp)
    800062a0:	01313c23          	sd	s3,24(sp)
    800062a4:	00f4f4b3          	and	s1,s1,a5
    800062a8:	02113c23          	sd	ra,56(sp)
    800062ac:	03213023          	sd	s2,32(sp)
    800062b0:	01413823          	sd	s4,16(sp)
    800062b4:	01513423          	sd	s5,8(sp)
    800062b8:	04010413          	addi	s0,sp,64
    800062bc:	000017b7          	lui	a5,0x1
    800062c0:	01100993          	li	s3,17
    800062c4:	00f487b3          	add	a5,s1,a5
    800062c8:	01b99993          	slli	s3,s3,0x1b
    800062cc:	06f9e063          	bltu	s3,a5,8000632c <kinit+0xa4>
    800062d0:	0000ea97          	auipc	s5,0xe
    800062d4:	d30a8a93          	addi	s5,s5,-720 # 80014000 <end>
    800062d8:	0754ec63          	bltu	s1,s5,80006350 <kinit+0xc8>
    800062dc:	0734fa63          	bgeu	s1,s3,80006350 <kinit+0xc8>
    800062e0:	00088a37          	lui	s4,0x88
    800062e4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800062e8:	00002917          	auipc	s2,0x2
    800062ec:	8f890913          	addi	s2,s2,-1800 # 80007be0 <kmem>
    800062f0:	00ca1a13          	slli	s4,s4,0xc
    800062f4:	0140006f          	j	80006308 <kinit+0x80>
    800062f8:	000017b7          	lui	a5,0x1
    800062fc:	00f484b3          	add	s1,s1,a5
    80006300:	0554e863          	bltu	s1,s5,80006350 <kinit+0xc8>
    80006304:	0534f663          	bgeu	s1,s3,80006350 <kinit+0xc8>
    80006308:	00001637          	lui	a2,0x1
    8000630c:	00100593          	li	a1,1
    80006310:	00048513          	mv	a0,s1
    80006314:	00000097          	auipc	ra,0x0
    80006318:	5e4080e7          	jalr	1508(ra) # 800068f8 <__memset>
    8000631c:	00093783          	ld	a5,0(s2)
    80006320:	00f4b023          	sd	a5,0(s1)
    80006324:	00993023          	sd	s1,0(s2)
    80006328:	fd4498e3          	bne	s1,s4,800062f8 <kinit+0x70>
    8000632c:	03813083          	ld	ra,56(sp)
    80006330:	03013403          	ld	s0,48(sp)
    80006334:	02813483          	ld	s1,40(sp)
    80006338:	02013903          	ld	s2,32(sp)
    8000633c:	01813983          	ld	s3,24(sp)
    80006340:	01013a03          	ld	s4,16(sp)
    80006344:	00813a83          	ld	s5,8(sp)
    80006348:	04010113          	addi	sp,sp,64
    8000634c:	00008067          	ret
    80006350:	00001517          	auipc	a0,0x1
    80006354:	38850513          	addi	a0,a0,904 # 800076d8 <digits+0x18>
    80006358:	fffff097          	auipc	ra,0xfffff
    8000635c:	4b4080e7          	jalr	1204(ra) # 8000580c <panic>

0000000080006360 <freerange>:
    80006360:	fc010113          	addi	sp,sp,-64
    80006364:	000017b7          	lui	a5,0x1
    80006368:	02913423          	sd	s1,40(sp)
    8000636c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006370:	009504b3          	add	s1,a0,s1
    80006374:	fffff537          	lui	a0,0xfffff
    80006378:	02813823          	sd	s0,48(sp)
    8000637c:	02113c23          	sd	ra,56(sp)
    80006380:	03213023          	sd	s2,32(sp)
    80006384:	01313c23          	sd	s3,24(sp)
    80006388:	01413823          	sd	s4,16(sp)
    8000638c:	01513423          	sd	s5,8(sp)
    80006390:	01613023          	sd	s6,0(sp)
    80006394:	04010413          	addi	s0,sp,64
    80006398:	00a4f4b3          	and	s1,s1,a0
    8000639c:	00f487b3          	add	a5,s1,a5
    800063a0:	06f5e463          	bltu	a1,a5,80006408 <freerange+0xa8>
    800063a4:	0000ea97          	auipc	s5,0xe
    800063a8:	c5ca8a93          	addi	s5,s5,-932 # 80014000 <end>
    800063ac:	0954e263          	bltu	s1,s5,80006430 <freerange+0xd0>
    800063b0:	01100993          	li	s3,17
    800063b4:	01b99993          	slli	s3,s3,0x1b
    800063b8:	0734fc63          	bgeu	s1,s3,80006430 <freerange+0xd0>
    800063bc:	00058a13          	mv	s4,a1
    800063c0:	00002917          	auipc	s2,0x2
    800063c4:	82090913          	addi	s2,s2,-2016 # 80007be0 <kmem>
    800063c8:	00002b37          	lui	s6,0x2
    800063cc:	0140006f          	j	800063e0 <freerange+0x80>
    800063d0:	000017b7          	lui	a5,0x1
    800063d4:	00f484b3          	add	s1,s1,a5
    800063d8:	0554ec63          	bltu	s1,s5,80006430 <freerange+0xd0>
    800063dc:	0534fa63          	bgeu	s1,s3,80006430 <freerange+0xd0>
    800063e0:	00001637          	lui	a2,0x1
    800063e4:	00100593          	li	a1,1
    800063e8:	00048513          	mv	a0,s1
    800063ec:	00000097          	auipc	ra,0x0
    800063f0:	50c080e7          	jalr	1292(ra) # 800068f8 <__memset>
    800063f4:	00093703          	ld	a4,0(s2)
    800063f8:	016487b3          	add	a5,s1,s6
    800063fc:	00e4b023          	sd	a4,0(s1)
    80006400:	00993023          	sd	s1,0(s2)
    80006404:	fcfa76e3          	bgeu	s4,a5,800063d0 <freerange+0x70>
    80006408:	03813083          	ld	ra,56(sp)
    8000640c:	03013403          	ld	s0,48(sp)
    80006410:	02813483          	ld	s1,40(sp)
    80006414:	02013903          	ld	s2,32(sp)
    80006418:	01813983          	ld	s3,24(sp)
    8000641c:	01013a03          	ld	s4,16(sp)
    80006420:	00813a83          	ld	s5,8(sp)
    80006424:	00013b03          	ld	s6,0(sp)
    80006428:	04010113          	addi	sp,sp,64
    8000642c:	00008067          	ret
    80006430:	00001517          	auipc	a0,0x1
    80006434:	2a850513          	addi	a0,a0,680 # 800076d8 <digits+0x18>
    80006438:	fffff097          	auipc	ra,0xfffff
    8000643c:	3d4080e7          	jalr	980(ra) # 8000580c <panic>

0000000080006440 <kfree>:
    80006440:	fe010113          	addi	sp,sp,-32
    80006444:	00813823          	sd	s0,16(sp)
    80006448:	00113c23          	sd	ra,24(sp)
    8000644c:	00913423          	sd	s1,8(sp)
    80006450:	02010413          	addi	s0,sp,32
    80006454:	03451793          	slli	a5,a0,0x34
    80006458:	04079c63          	bnez	a5,800064b0 <kfree+0x70>
    8000645c:	0000e797          	auipc	a5,0xe
    80006460:	ba478793          	addi	a5,a5,-1116 # 80014000 <end>
    80006464:	00050493          	mv	s1,a0
    80006468:	04f56463          	bltu	a0,a5,800064b0 <kfree+0x70>
    8000646c:	01100793          	li	a5,17
    80006470:	01b79793          	slli	a5,a5,0x1b
    80006474:	02f57e63          	bgeu	a0,a5,800064b0 <kfree+0x70>
    80006478:	00001637          	lui	a2,0x1
    8000647c:	00100593          	li	a1,1
    80006480:	00000097          	auipc	ra,0x0
    80006484:	478080e7          	jalr	1144(ra) # 800068f8 <__memset>
    80006488:	00001797          	auipc	a5,0x1
    8000648c:	75878793          	addi	a5,a5,1880 # 80007be0 <kmem>
    80006490:	0007b703          	ld	a4,0(a5)
    80006494:	01813083          	ld	ra,24(sp)
    80006498:	01013403          	ld	s0,16(sp)
    8000649c:	00e4b023          	sd	a4,0(s1)
    800064a0:	0097b023          	sd	s1,0(a5)
    800064a4:	00813483          	ld	s1,8(sp)
    800064a8:	02010113          	addi	sp,sp,32
    800064ac:	00008067          	ret
    800064b0:	00001517          	auipc	a0,0x1
    800064b4:	22850513          	addi	a0,a0,552 # 800076d8 <digits+0x18>
    800064b8:	fffff097          	auipc	ra,0xfffff
    800064bc:	354080e7          	jalr	852(ra) # 8000580c <panic>

00000000800064c0 <kalloc>:
    800064c0:	fe010113          	addi	sp,sp,-32
    800064c4:	00813823          	sd	s0,16(sp)
    800064c8:	00913423          	sd	s1,8(sp)
    800064cc:	00113c23          	sd	ra,24(sp)
    800064d0:	02010413          	addi	s0,sp,32
    800064d4:	00001797          	auipc	a5,0x1
    800064d8:	70c78793          	addi	a5,a5,1804 # 80007be0 <kmem>
    800064dc:	0007b483          	ld	s1,0(a5)
    800064e0:	02048063          	beqz	s1,80006500 <kalloc+0x40>
    800064e4:	0004b703          	ld	a4,0(s1)
    800064e8:	00001637          	lui	a2,0x1
    800064ec:	00500593          	li	a1,5
    800064f0:	00048513          	mv	a0,s1
    800064f4:	00e7b023          	sd	a4,0(a5)
    800064f8:	00000097          	auipc	ra,0x0
    800064fc:	400080e7          	jalr	1024(ra) # 800068f8 <__memset>
    80006500:	01813083          	ld	ra,24(sp)
    80006504:	01013403          	ld	s0,16(sp)
    80006508:	00048513          	mv	a0,s1
    8000650c:	00813483          	ld	s1,8(sp)
    80006510:	02010113          	addi	sp,sp,32
    80006514:	00008067          	ret

0000000080006518 <initlock>:
    80006518:	ff010113          	addi	sp,sp,-16
    8000651c:	00813423          	sd	s0,8(sp)
    80006520:	01010413          	addi	s0,sp,16
    80006524:	00813403          	ld	s0,8(sp)
    80006528:	00b53423          	sd	a1,8(a0)
    8000652c:	00052023          	sw	zero,0(a0)
    80006530:	00053823          	sd	zero,16(a0)
    80006534:	01010113          	addi	sp,sp,16
    80006538:	00008067          	ret

000000008000653c <acquire>:
    8000653c:	fe010113          	addi	sp,sp,-32
    80006540:	00813823          	sd	s0,16(sp)
    80006544:	00913423          	sd	s1,8(sp)
    80006548:	00113c23          	sd	ra,24(sp)
    8000654c:	01213023          	sd	s2,0(sp)
    80006550:	02010413          	addi	s0,sp,32
    80006554:	00050493          	mv	s1,a0
    80006558:	10002973          	csrr	s2,sstatus
    8000655c:	100027f3          	csrr	a5,sstatus
    80006560:	ffd7f793          	andi	a5,a5,-3
    80006564:	10079073          	csrw	sstatus,a5
    80006568:	fffff097          	auipc	ra,0xfffff
    8000656c:	8ec080e7          	jalr	-1812(ra) # 80004e54 <mycpu>
    80006570:	07852783          	lw	a5,120(a0)
    80006574:	06078e63          	beqz	a5,800065f0 <acquire+0xb4>
    80006578:	fffff097          	auipc	ra,0xfffff
    8000657c:	8dc080e7          	jalr	-1828(ra) # 80004e54 <mycpu>
    80006580:	07852783          	lw	a5,120(a0)
    80006584:	0004a703          	lw	a4,0(s1)
    80006588:	0017879b          	addiw	a5,a5,1
    8000658c:	06f52c23          	sw	a5,120(a0)
    80006590:	04071063          	bnez	a4,800065d0 <acquire+0x94>
    80006594:	00100713          	li	a4,1
    80006598:	00070793          	mv	a5,a4
    8000659c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800065a0:	0007879b          	sext.w	a5,a5
    800065a4:	fe079ae3          	bnez	a5,80006598 <acquire+0x5c>
    800065a8:	0ff0000f          	fence
    800065ac:	fffff097          	auipc	ra,0xfffff
    800065b0:	8a8080e7          	jalr	-1880(ra) # 80004e54 <mycpu>
    800065b4:	01813083          	ld	ra,24(sp)
    800065b8:	01013403          	ld	s0,16(sp)
    800065bc:	00a4b823          	sd	a0,16(s1)
    800065c0:	00013903          	ld	s2,0(sp)
    800065c4:	00813483          	ld	s1,8(sp)
    800065c8:	02010113          	addi	sp,sp,32
    800065cc:	00008067          	ret
    800065d0:	0104b903          	ld	s2,16(s1)
    800065d4:	fffff097          	auipc	ra,0xfffff
    800065d8:	880080e7          	jalr	-1920(ra) # 80004e54 <mycpu>
    800065dc:	faa91ce3          	bne	s2,a0,80006594 <acquire+0x58>
    800065e0:	00001517          	auipc	a0,0x1
    800065e4:	10050513          	addi	a0,a0,256 # 800076e0 <digits+0x20>
    800065e8:	fffff097          	auipc	ra,0xfffff
    800065ec:	224080e7          	jalr	548(ra) # 8000580c <panic>
    800065f0:	00195913          	srli	s2,s2,0x1
    800065f4:	fffff097          	auipc	ra,0xfffff
    800065f8:	860080e7          	jalr	-1952(ra) # 80004e54 <mycpu>
    800065fc:	00197913          	andi	s2,s2,1
    80006600:	07252e23          	sw	s2,124(a0)
    80006604:	f75ff06f          	j	80006578 <acquire+0x3c>

0000000080006608 <release>:
    80006608:	fe010113          	addi	sp,sp,-32
    8000660c:	00813823          	sd	s0,16(sp)
    80006610:	00113c23          	sd	ra,24(sp)
    80006614:	00913423          	sd	s1,8(sp)
    80006618:	01213023          	sd	s2,0(sp)
    8000661c:	02010413          	addi	s0,sp,32
    80006620:	00052783          	lw	a5,0(a0)
    80006624:	00079a63          	bnez	a5,80006638 <release+0x30>
    80006628:	00001517          	auipc	a0,0x1
    8000662c:	0c050513          	addi	a0,a0,192 # 800076e8 <digits+0x28>
    80006630:	fffff097          	auipc	ra,0xfffff
    80006634:	1dc080e7          	jalr	476(ra) # 8000580c <panic>
    80006638:	01053903          	ld	s2,16(a0)
    8000663c:	00050493          	mv	s1,a0
    80006640:	fffff097          	auipc	ra,0xfffff
    80006644:	814080e7          	jalr	-2028(ra) # 80004e54 <mycpu>
    80006648:	fea910e3          	bne	s2,a0,80006628 <release+0x20>
    8000664c:	0004b823          	sd	zero,16(s1)
    80006650:	0ff0000f          	fence
    80006654:	0f50000f          	fence	iorw,ow
    80006658:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000665c:	ffffe097          	auipc	ra,0xffffe
    80006660:	7f8080e7          	jalr	2040(ra) # 80004e54 <mycpu>
    80006664:	100027f3          	csrr	a5,sstatus
    80006668:	0027f793          	andi	a5,a5,2
    8000666c:	04079a63          	bnez	a5,800066c0 <release+0xb8>
    80006670:	07852783          	lw	a5,120(a0)
    80006674:	02f05e63          	blez	a5,800066b0 <release+0xa8>
    80006678:	fff7871b          	addiw	a4,a5,-1
    8000667c:	06e52c23          	sw	a4,120(a0)
    80006680:	00071c63          	bnez	a4,80006698 <release+0x90>
    80006684:	07c52783          	lw	a5,124(a0)
    80006688:	00078863          	beqz	a5,80006698 <release+0x90>
    8000668c:	100027f3          	csrr	a5,sstatus
    80006690:	0027e793          	ori	a5,a5,2
    80006694:	10079073          	csrw	sstatus,a5
    80006698:	01813083          	ld	ra,24(sp)
    8000669c:	01013403          	ld	s0,16(sp)
    800066a0:	00813483          	ld	s1,8(sp)
    800066a4:	00013903          	ld	s2,0(sp)
    800066a8:	02010113          	addi	sp,sp,32
    800066ac:	00008067          	ret
    800066b0:	00001517          	auipc	a0,0x1
    800066b4:	05850513          	addi	a0,a0,88 # 80007708 <digits+0x48>
    800066b8:	fffff097          	auipc	ra,0xfffff
    800066bc:	154080e7          	jalr	340(ra) # 8000580c <panic>
    800066c0:	00001517          	auipc	a0,0x1
    800066c4:	03050513          	addi	a0,a0,48 # 800076f0 <digits+0x30>
    800066c8:	fffff097          	auipc	ra,0xfffff
    800066cc:	144080e7          	jalr	324(ra) # 8000580c <panic>

00000000800066d0 <holding>:
    800066d0:	00052783          	lw	a5,0(a0)
    800066d4:	00079663          	bnez	a5,800066e0 <holding+0x10>
    800066d8:	00000513          	li	a0,0
    800066dc:	00008067          	ret
    800066e0:	fe010113          	addi	sp,sp,-32
    800066e4:	00813823          	sd	s0,16(sp)
    800066e8:	00913423          	sd	s1,8(sp)
    800066ec:	00113c23          	sd	ra,24(sp)
    800066f0:	02010413          	addi	s0,sp,32
    800066f4:	01053483          	ld	s1,16(a0)
    800066f8:	ffffe097          	auipc	ra,0xffffe
    800066fc:	75c080e7          	jalr	1884(ra) # 80004e54 <mycpu>
    80006700:	01813083          	ld	ra,24(sp)
    80006704:	01013403          	ld	s0,16(sp)
    80006708:	40a48533          	sub	a0,s1,a0
    8000670c:	00153513          	seqz	a0,a0
    80006710:	00813483          	ld	s1,8(sp)
    80006714:	02010113          	addi	sp,sp,32
    80006718:	00008067          	ret

000000008000671c <push_off>:
    8000671c:	fe010113          	addi	sp,sp,-32
    80006720:	00813823          	sd	s0,16(sp)
    80006724:	00113c23          	sd	ra,24(sp)
    80006728:	00913423          	sd	s1,8(sp)
    8000672c:	02010413          	addi	s0,sp,32
    80006730:	100024f3          	csrr	s1,sstatus
    80006734:	100027f3          	csrr	a5,sstatus
    80006738:	ffd7f793          	andi	a5,a5,-3
    8000673c:	10079073          	csrw	sstatus,a5
    80006740:	ffffe097          	auipc	ra,0xffffe
    80006744:	714080e7          	jalr	1812(ra) # 80004e54 <mycpu>
    80006748:	07852783          	lw	a5,120(a0)
    8000674c:	02078663          	beqz	a5,80006778 <push_off+0x5c>
    80006750:	ffffe097          	auipc	ra,0xffffe
    80006754:	704080e7          	jalr	1796(ra) # 80004e54 <mycpu>
    80006758:	07852783          	lw	a5,120(a0)
    8000675c:	01813083          	ld	ra,24(sp)
    80006760:	01013403          	ld	s0,16(sp)
    80006764:	0017879b          	addiw	a5,a5,1
    80006768:	06f52c23          	sw	a5,120(a0)
    8000676c:	00813483          	ld	s1,8(sp)
    80006770:	02010113          	addi	sp,sp,32
    80006774:	00008067          	ret
    80006778:	0014d493          	srli	s1,s1,0x1
    8000677c:	ffffe097          	auipc	ra,0xffffe
    80006780:	6d8080e7          	jalr	1752(ra) # 80004e54 <mycpu>
    80006784:	0014f493          	andi	s1,s1,1
    80006788:	06952e23          	sw	s1,124(a0)
    8000678c:	fc5ff06f          	j	80006750 <push_off+0x34>

0000000080006790 <pop_off>:
    80006790:	ff010113          	addi	sp,sp,-16
    80006794:	00813023          	sd	s0,0(sp)
    80006798:	00113423          	sd	ra,8(sp)
    8000679c:	01010413          	addi	s0,sp,16
    800067a0:	ffffe097          	auipc	ra,0xffffe
    800067a4:	6b4080e7          	jalr	1716(ra) # 80004e54 <mycpu>
    800067a8:	100027f3          	csrr	a5,sstatus
    800067ac:	0027f793          	andi	a5,a5,2
    800067b0:	04079663          	bnez	a5,800067fc <pop_off+0x6c>
    800067b4:	07852783          	lw	a5,120(a0)
    800067b8:	02f05a63          	blez	a5,800067ec <pop_off+0x5c>
    800067bc:	fff7871b          	addiw	a4,a5,-1
    800067c0:	06e52c23          	sw	a4,120(a0)
    800067c4:	00071c63          	bnez	a4,800067dc <pop_off+0x4c>
    800067c8:	07c52783          	lw	a5,124(a0)
    800067cc:	00078863          	beqz	a5,800067dc <pop_off+0x4c>
    800067d0:	100027f3          	csrr	a5,sstatus
    800067d4:	0027e793          	ori	a5,a5,2
    800067d8:	10079073          	csrw	sstatus,a5
    800067dc:	00813083          	ld	ra,8(sp)
    800067e0:	00013403          	ld	s0,0(sp)
    800067e4:	01010113          	addi	sp,sp,16
    800067e8:	00008067          	ret
    800067ec:	00001517          	auipc	a0,0x1
    800067f0:	f1c50513          	addi	a0,a0,-228 # 80007708 <digits+0x48>
    800067f4:	fffff097          	auipc	ra,0xfffff
    800067f8:	018080e7          	jalr	24(ra) # 8000580c <panic>
    800067fc:	00001517          	auipc	a0,0x1
    80006800:	ef450513          	addi	a0,a0,-268 # 800076f0 <digits+0x30>
    80006804:	fffff097          	auipc	ra,0xfffff
    80006808:	008080e7          	jalr	8(ra) # 8000580c <panic>

000000008000680c <push_on>:
    8000680c:	fe010113          	addi	sp,sp,-32
    80006810:	00813823          	sd	s0,16(sp)
    80006814:	00113c23          	sd	ra,24(sp)
    80006818:	00913423          	sd	s1,8(sp)
    8000681c:	02010413          	addi	s0,sp,32
    80006820:	100024f3          	csrr	s1,sstatus
    80006824:	100027f3          	csrr	a5,sstatus
    80006828:	0027e793          	ori	a5,a5,2
    8000682c:	10079073          	csrw	sstatus,a5
    80006830:	ffffe097          	auipc	ra,0xffffe
    80006834:	624080e7          	jalr	1572(ra) # 80004e54 <mycpu>
    80006838:	07852783          	lw	a5,120(a0)
    8000683c:	02078663          	beqz	a5,80006868 <push_on+0x5c>
    80006840:	ffffe097          	auipc	ra,0xffffe
    80006844:	614080e7          	jalr	1556(ra) # 80004e54 <mycpu>
    80006848:	07852783          	lw	a5,120(a0)
    8000684c:	01813083          	ld	ra,24(sp)
    80006850:	01013403          	ld	s0,16(sp)
    80006854:	0017879b          	addiw	a5,a5,1
    80006858:	06f52c23          	sw	a5,120(a0)
    8000685c:	00813483          	ld	s1,8(sp)
    80006860:	02010113          	addi	sp,sp,32
    80006864:	00008067          	ret
    80006868:	0014d493          	srli	s1,s1,0x1
    8000686c:	ffffe097          	auipc	ra,0xffffe
    80006870:	5e8080e7          	jalr	1512(ra) # 80004e54 <mycpu>
    80006874:	0014f493          	andi	s1,s1,1
    80006878:	06952e23          	sw	s1,124(a0)
    8000687c:	fc5ff06f          	j	80006840 <push_on+0x34>

0000000080006880 <pop_on>:
    80006880:	ff010113          	addi	sp,sp,-16
    80006884:	00813023          	sd	s0,0(sp)
    80006888:	00113423          	sd	ra,8(sp)
    8000688c:	01010413          	addi	s0,sp,16
    80006890:	ffffe097          	auipc	ra,0xffffe
    80006894:	5c4080e7          	jalr	1476(ra) # 80004e54 <mycpu>
    80006898:	100027f3          	csrr	a5,sstatus
    8000689c:	0027f793          	andi	a5,a5,2
    800068a0:	04078463          	beqz	a5,800068e8 <pop_on+0x68>
    800068a4:	07852783          	lw	a5,120(a0)
    800068a8:	02f05863          	blez	a5,800068d8 <pop_on+0x58>
    800068ac:	fff7879b          	addiw	a5,a5,-1
    800068b0:	06f52c23          	sw	a5,120(a0)
    800068b4:	07853783          	ld	a5,120(a0)
    800068b8:	00079863          	bnez	a5,800068c8 <pop_on+0x48>
    800068bc:	100027f3          	csrr	a5,sstatus
    800068c0:	ffd7f793          	andi	a5,a5,-3
    800068c4:	10079073          	csrw	sstatus,a5
    800068c8:	00813083          	ld	ra,8(sp)
    800068cc:	00013403          	ld	s0,0(sp)
    800068d0:	01010113          	addi	sp,sp,16
    800068d4:	00008067          	ret
    800068d8:	00001517          	auipc	a0,0x1
    800068dc:	e5850513          	addi	a0,a0,-424 # 80007730 <digits+0x70>
    800068e0:	fffff097          	auipc	ra,0xfffff
    800068e4:	f2c080e7          	jalr	-212(ra) # 8000580c <panic>
    800068e8:	00001517          	auipc	a0,0x1
    800068ec:	e2850513          	addi	a0,a0,-472 # 80007710 <digits+0x50>
    800068f0:	fffff097          	auipc	ra,0xfffff
    800068f4:	f1c080e7          	jalr	-228(ra) # 8000580c <panic>

00000000800068f8 <__memset>:
    800068f8:	ff010113          	addi	sp,sp,-16
    800068fc:	00813423          	sd	s0,8(sp)
    80006900:	01010413          	addi	s0,sp,16
    80006904:	1a060e63          	beqz	a2,80006ac0 <__memset+0x1c8>
    80006908:	40a007b3          	neg	a5,a0
    8000690c:	0077f793          	andi	a5,a5,7
    80006910:	00778693          	addi	a3,a5,7
    80006914:	00b00813          	li	a6,11
    80006918:	0ff5f593          	andi	a1,a1,255
    8000691c:	fff6071b          	addiw	a4,a2,-1
    80006920:	1b06e663          	bltu	a3,a6,80006acc <__memset+0x1d4>
    80006924:	1cd76463          	bltu	a4,a3,80006aec <__memset+0x1f4>
    80006928:	1a078e63          	beqz	a5,80006ae4 <__memset+0x1ec>
    8000692c:	00b50023          	sb	a1,0(a0)
    80006930:	00100713          	li	a4,1
    80006934:	1ae78463          	beq	a5,a4,80006adc <__memset+0x1e4>
    80006938:	00b500a3          	sb	a1,1(a0)
    8000693c:	00200713          	li	a4,2
    80006940:	1ae78a63          	beq	a5,a4,80006af4 <__memset+0x1fc>
    80006944:	00b50123          	sb	a1,2(a0)
    80006948:	00300713          	li	a4,3
    8000694c:	18e78463          	beq	a5,a4,80006ad4 <__memset+0x1dc>
    80006950:	00b501a3          	sb	a1,3(a0)
    80006954:	00400713          	li	a4,4
    80006958:	1ae78263          	beq	a5,a4,80006afc <__memset+0x204>
    8000695c:	00b50223          	sb	a1,4(a0)
    80006960:	00500713          	li	a4,5
    80006964:	1ae78063          	beq	a5,a4,80006b04 <__memset+0x20c>
    80006968:	00b502a3          	sb	a1,5(a0)
    8000696c:	00700713          	li	a4,7
    80006970:	18e79e63          	bne	a5,a4,80006b0c <__memset+0x214>
    80006974:	00b50323          	sb	a1,6(a0)
    80006978:	00700e93          	li	t4,7
    8000697c:	00859713          	slli	a4,a1,0x8
    80006980:	00e5e733          	or	a4,a1,a4
    80006984:	01059e13          	slli	t3,a1,0x10
    80006988:	01c76e33          	or	t3,a4,t3
    8000698c:	01859313          	slli	t1,a1,0x18
    80006990:	006e6333          	or	t1,t3,t1
    80006994:	02059893          	slli	a7,a1,0x20
    80006998:	40f60e3b          	subw	t3,a2,a5
    8000699c:	011368b3          	or	a7,t1,a7
    800069a0:	02859813          	slli	a6,a1,0x28
    800069a4:	0108e833          	or	a6,a7,a6
    800069a8:	03059693          	slli	a3,a1,0x30
    800069ac:	003e589b          	srliw	a7,t3,0x3
    800069b0:	00d866b3          	or	a3,a6,a3
    800069b4:	03859713          	slli	a4,a1,0x38
    800069b8:	00389813          	slli	a6,a7,0x3
    800069bc:	00f507b3          	add	a5,a0,a5
    800069c0:	00e6e733          	or	a4,a3,a4
    800069c4:	000e089b          	sext.w	a7,t3
    800069c8:	00f806b3          	add	a3,a6,a5
    800069cc:	00e7b023          	sd	a4,0(a5)
    800069d0:	00878793          	addi	a5,a5,8
    800069d4:	fed79ce3          	bne	a5,a3,800069cc <__memset+0xd4>
    800069d8:	ff8e7793          	andi	a5,t3,-8
    800069dc:	0007871b          	sext.w	a4,a5
    800069e0:	01d787bb          	addw	a5,a5,t4
    800069e4:	0ce88e63          	beq	a7,a4,80006ac0 <__memset+0x1c8>
    800069e8:	00f50733          	add	a4,a0,a5
    800069ec:	00b70023          	sb	a1,0(a4)
    800069f0:	0017871b          	addiw	a4,a5,1
    800069f4:	0cc77663          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    800069f8:	00e50733          	add	a4,a0,a4
    800069fc:	00b70023          	sb	a1,0(a4)
    80006a00:	0027871b          	addiw	a4,a5,2
    80006a04:	0ac77e63          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a08:	00e50733          	add	a4,a0,a4
    80006a0c:	00b70023          	sb	a1,0(a4)
    80006a10:	0037871b          	addiw	a4,a5,3
    80006a14:	0ac77663          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a18:	00e50733          	add	a4,a0,a4
    80006a1c:	00b70023          	sb	a1,0(a4)
    80006a20:	0047871b          	addiw	a4,a5,4
    80006a24:	08c77e63          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a28:	00e50733          	add	a4,a0,a4
    80006a2c:	00b70023          	sb	a1,0(a4)
    80006a30:	0057871b          	addiw	a4,a5,5
    80006a34:	08c77663          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a38:	00e50733          	add	a4,a0,a4
    80006a3c:	00b70023          	sb	a1,0(a4)
    80006a40:	0067871b          	addiw	a4,a5,6
    80006a44:	06c77e63          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a48:	00e50733          	add	a4,a0,a4
    80006a4c:	00b70023          	sb	a1,0(a4)
    80006a50:	0077871b          	addiw	a4,a5,7
    80006a54:	06c77663          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a58:	00e50733          	add	a4,a0,a4
    80006a5c:	00b70023          	sb	a1,0(a4)
    80006a60:	0087871b          	addiw	a4,a5,8
    80006a64:	04c77e63          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a68:	00e50733          	add	a4,a0,a4
    80006a6c:	00b70023          	sb	a1,0(a4)
    80006a70:	0097871b          	addiw	a4,a5,9
    80006a74:	04c77663          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a78:	00e50733          	add	a4,a0,a4
    80006a7c:	00b70023          	sb	a1,0(a4)
    80006a80:	00a7871b          	addiw	a4,a5,10
    80006a84:	02c77e63          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a88:	00e50733          	add	a4,a0,a4
    80006a8c:	00b70023          	sb	a1,0(a4)
    80006a90:	00b7871b          	addiw	a4,a5,11
    80006a94:	02c77663          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006a98:	00e50733          	add	a4,a0,a4
    80006a9c:	00b70023          	sb	a1,0(a4)
    80006aa0:	00c7871b          	addiw	a4,a5,12
    80006aa4:	00c77e63          	bgeu	a4,a2,80006ac0 <__memset+0x1c8>
    80006aa8:	00e50733          	add	a4,a0,a4
    80006aac:	00b70023          	sb	a1,0(a4)
    80006ab0:	00d7879b          	addiw	a5,a5,13
    80006ab4:	00c7f663          	bgeu	a5,a2,80006ac0 <__memset+0x1c8>
    80006ab8:	00f507b3          	add	a5,a0,a5
    80006abc:	00b78023          	sb	a1,0(a5)
    80006ac0:	00813403          	ld	s0,8(sp)
    80006ac4:	01010113          	addi	sp,sp,16
    80006ac8:	00008067          	ret
    80006acc:	00b00693          	li	a3,11
    80006ad0:	e55ff06f          	j	80006924 <__memset+0x2c>
    80006ad4:	00300e93          	li	t4,3
    80006ad8:	ea5ff06f          	j	8000697c <__memset+0x84>
    80006adc:	00100e93          	li	t4,1
    80006ae0:	e9dff06f          	j	8000697c <__memset+0x84>
    80006ae4:	00000e93          	li	t4,0
    80006ae8:	e95ff06f          	j	8000697c <__memset+0x84>
    80006aec:	00000793          	li	a5,0
    80006af0:	ef9ff06f          	j	800069e8 <__memset+0xf0>
    80006af4:	00200e93          	li	t4,2
    80006af8:	e85ff06f          	j	8000697c <__memset+0x84>
    80006afc:	00400e93          	li	t4,4
    80006b00:	e7dff06f          	j	8000697c <__memset+0x84>
    80006b04:	00500e93          	li	t4,5
    80006b08:	e75ff06f          	j	8000697c <__memset+0x84>
    80006b0c:	00600e93          	li	t4,6
    80006b10:	e6dff06f          	j	8000697c <__memset+0x84>

0000000080006b14 <__memmove>:
    80006b14:	ff010113          	addi	sp,sp,-16
    80006b18:	00813423          	sd	s0,8(sp)
    80006b1c:	01010413          	addi	s0,sp,16
    80006b20:	0e060863          	beqz	a2,80006c10 <__memmove+0xfc>
    80006b24:	fff6069b          	addiw	a3,a2,-1
    80006b28:	0006881b          	sext.w	a6,a3
    80006b2c:	0ea5e863          	bltu	a1,a0,80006c1c <__memmove+0x108>
    80006b30:	00758713          	addi	a4,a1,7
    80006b34:	00a5e7b3          	or	a5,a1,a0
    80006b38:	40a70733          	sub	a4,a4,a0
    80006b3c:	0077f793          	andi	a5,a5,7
    80006b40:	00f73713          	sltiu	a4,a4,15
    80006b44:	00174713          	xori	a4,a4,1
    80006b48:	0017b793          	seqz	a5,a5
    80006b4c:	00e7f7b3          	and	a5,a5,a4
    80006b50:	10078863          	beqz	a5,80006c60 <__memmove+0x14c>
    80006b54:	00900793          	li	a5,9
    80006b58:	1107f463          	bgeu	a5,a6,80006c60 <__memmove+0x14c>
    80006b5c:	0036581b          	srliw	a6,a2,0x3
    80006b60:	fff8081b          	addiw	a6,a6,-1
    80006b64:	02081813          	slli	a6,a6,0x20
    80006b68:	01d85893          	srli	a7,a6,0x1d
    80006b6c:	00858813          	addi	a6,a1,8
    80006b70:	00058793          	mv	a5,a1
    80006b74:	00050713          	mv	a4,a0
    80006b78:	01088833          	add	a6,a7,a6
    80006b7c:	0007b883          	ld	a7,0(a5)
    80006b80:	00878793          	addi	a5,a5,8
    80006b84:	00870713          	addi	a4,a4,8
    80006b88:	ff173c23          	sd	a7,-8(a4)
    80006b8c:	ff0798e3          	bne	a5,a6,80006b7c <__memmove+0x68>
    80006b90:	ff867713          	andi	a4,a2,-8
    80006b94:	02071793          	slli	a5,a4,0x20
    80006b98:	0207d793          	srli	a5,a5,0x20
    80006b9c:	00f585b3          	add	a1,a1,a5
    80006ba0:	40e686bb          	subw	a3,a3,a4
    80006ba4:	00f507b3          	add	a5,a0,a5
    80006ba8:	06e60463          	beq	a2,a4,80006c10 <__memmove+0xfc>
    80006bac:	0005c703          	lbu	a4,0(a1)
    80006bb0:	00e78023          	sb	a4,0(a5)
    80006bb4:	04068e63          	beqz	a3,80006c10 <__memmove+0xfc>
    80006bb8:	0015c603          	lbu	a2,1(a1)
    80006bbc:	00100713          	li	a4,1
    80006bc0:	00c780a3          	sb	a2,1(a5)
    80006bc4:	04e68663          	beq	a3,a4,80006c10 <__memmove+0xfc>
    80006bc8:	0025c603          	lbu	a2,2(a1)
    80006bcc:	00200713          	li	a4,2
    80006bd0:	00c78123          	sb	a2,2(a5)
    80006bd4:	02e68e63          	beq	a3,a4,80006c10 <__memmove+0xfc>
    80006bd8:	0035c603          	lbu	a2,3(a1)
    80006bdc:	00300713          	li	a4,3
    80006be0:	00c781a3          	sb	a2,3(a5)
    80006be4:	02e68663          	beq	a3,a4,80006c10 <__memmove+0xfc>
    80006be8:	0045c603          	lbu	a2,4(a1)
    80006bec:	00400713          	li	a4,4
    80006bf0:	00c78223          	sb	a2,4(a5)
    80006bf4:	00e68e63          	beq	a3,a4,80006c10 <__memmove+0xfc>
    80006bf8:	0055c603          	lbu	a2,5(a1)
    80006bfc:	00500713          	li	a4,5
    80006c00:	00c782a3          	sb	a2,5(a5)
    80006c04:	00e68663          	beq	a3,a4,80006c10 <__memmove+0xfc>
    80006c08:	0065c703          	lbu	a4,6(a1)
    80006c0c:	00e78323          	sb	a4,6(a5)
    80006c10:	00813403          	ld	s0,8(sp)
    80006c14:	01010113          	addi	sp,sp,16
    80006c18:	00008067          	ret
    80006c1c:	02061713          	slli	a4,a2,0x20
    80006c20:	02075713          	srli	a4,a4,0x20
    80006c24:	00e587b3          	add	a5,a1,a4
    80006c28:	f0f574e3          	bgeu	a0,a5,80006b30 <__memmove+0x1c>
    80006c2c:	02069613          	slli	a2,a3,0x20
    80006c30:	02065613          	srli	a2,a2,0x20
    80006c34:	fff64613          	not	a2,a2
    80006c38:	00e50733          	add	a4,a0,a4
    80006c3c:	00c78633          	add	a2,a5,a2
    80006c40:	fff7c683          	lbu	a3,-1(a5)
    80006c44:	fff78793          	addi	a5,a5,-1
    80006c48:	fff70713          	addi	a4,a4,-1
    80006c4c:	00d70023          	sb	a3,0(a4)
    80006c50:	fec798e3          	bne	a5,a2,80006c40 <__memmove+0x12c>
    80006c54:	00813403          	ld	s0,8(sp)
    80006c58:	01010113          	addi	sp,sp,16
    80006c5c:	00008067          	ret
    80006c60:	02069713          	slli	a4,a3,0x20
    80006c64:	02075713          	srli	a4,a4,0x20
    80006c68:	00170713          	addi	a4,a4,1
    80006c6c:	00e50733          	add	a4,a0,a4
    80006c70:	00050793          	mv	a5,a0
    80006c74:	0005c683          	lbu	a3,0(a1)
    80006c78:	00178793          	addi	a5,a5,1
    80006c7c:	00158593          	addi	a1,a1,1
    80006c80:	fed78fa3          	sb	a3,-1(a5)
    80006c84:	fee798e3          	bne	a5,a4,80006c74 <__memmove+0x160>
    80006c88:	f89ff06f          	j	80006c10 <__memmove+0xfc>
	...

Disassembly of section .user:

000000008000e4c8 <copy_and_swap-0xb38>:
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
    8000f438:	00002097          	auipc	ra,0x2
    8000f43c:	81c080e7          	jalr	-2020(ra) # 80010c54 <_Znwm>
    8000f440:	00050913          	mv	s2,a0
    8000f444:	00050863          	beqz	a0,8000f454 <_ZN9BufferCPPC1Ei+0x68>
    8000f448:	00000593          	li	a1,0
    8000f44c:	00002097          	auipc	ra,0x2
    8000f450:	900080e7          	jalr	-1792(ra) # 80010d4c <_ZN9SemaphoreC1Ej>
    8000f454:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    8000f458:	01000513          	li	a0,16
    8000f45c:	00001097          	auipc	ra,0x1
    8000f460:	7f8080e7          	jalr	2040(ra) # 80010c54 <_Znwm>
    8000f464:	00050913          	mv	s2,a0
    8000f468:	00050863          	beqz	a0,8000f478 <_ZN9BufferCPPC1Ei+0x8c>
    8000f46c:	00098593          	mv	a1,s3
    8000f470:	00002097          	auipc	ra,0x2
    8000f474:	8dc080e7          	jalr	-1828(ra) # 80010d4c <_ZN9SemaphoreC1Ej>
    8000f478:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    8000f47c:	01000513          	li	a0,16
    8000f480:	00001097          	auipc	ra,0x1
    8000f484:	7d4080e7          	jalr	2004(ra) # 80010c54 <_Znwm>
    8000f488:	00050913          	mv	s2,a0
    8000f48c:	00050863          	beqz	a0,8000f49c <_ZN9BufferCPPC1Ei+0xb0>
    8000f490:	00100593          	li	a1,1
    8000f494:	00002097          	auipc	ra,0x2
    8000f498:	8b8080e7          	jalr	-1864(ra) # 80010d4c <_ZN9SemaphoreC1Ej>
    8000f49c:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    8000f4a0:	01000513          	li	a0,16
    8000f4a4:	00001097          	auipc	ra,0x1
    8000f4a8:	7b0080e7          	jalr	1968(ra) # 80010c54 <_Znwm>
    8000f4ac:	00050913          	mv	s2,a0
    8000f4b0:	00050863          	beqz	a0,8000f4c0 <_ZN9BufferCPPC1Ei+0xd4>
    8000f4b4:	00100593          	li	a1,1
    8000f4b8:	00002097          	auipc	ra,0x2
    8000f4bc:	894080e7          	jalr	-1900(ra) # 80010d4c <_ZN9SemaphoreC1Ej>
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
    8000f4ec:	7bc080e7          	jalr	1980(ra) # 80010ca4 <_ZdlPv>
    8000f4f0:	00048513          	mv	a0,s1
    8000f4f4:	ffffe097          	auipc	ra,0xffffe
    8000f4f8:	a04080e7          	jalr	-1532(ra) # 8000cef8 <_Unwind_Resume>
    8000f4fc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    8000f500:	00090513          	mv	a0,s2
    8000f504:	00001097          	auipc	ra,0x1
    8000f508:	7a0080e7          	jalr	1952(ra) # 80010ca4 <_ZdlPv>
    8000f50c:	00048513          	mv	a0,s1
    8000f510:	ffffe097          	auipc	ra,0xffffe
    8000f514:	9e8080e7          	jalr	-1560(ra) # 8000cef8 <_Unwind_Resume>
    8000f518:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000f51c:	00090513          	mv	a0,s2
    8000f520:	00001097          	auipc	ra,0x1
    8000f524:	784080e7          	jalr	1924(ra) # 80010ca4 <_ZdlPv>
    8000f528:	00048513          	mv	a0,s1
    8000f52c:	ffffe097          	auipc	ra,0xffffe
    8000f530:	9cc080e7          	jalr	-1588(ra) # 8000cef8 <_Unwind_Resume>
    8000f534:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000f538:	00090513          	mv	a0,s2
    8000f53c:	00001097          	auipc	ra,0x1
    8000f540:	768080e7          	jalr	1896(ra) # 80010ca4 <_ZdlPv>
    8000f544:	00048513          	mv	a0,s1
    8000f548:	ffffe097          	auipc	ra,0xffffe
    8000f54c:	9b0080e7          	jalr	-1616(ra) # 8000cef8 <_Unwind_Resume>

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
    8000f574:	00002097          	auipc	ra,0x2
    8000f578:	810080e7          	jalr	-2032(ra) # 80010d84 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    8000f57c:	0304b503          	ld	a0,48(s1)
    8000f580:	00002097          	auipc	ra,0x2
    8000f584:	804080e7          	jalr	-2044(ra) # 80010d84 <_ZN9Semaphore4waitEv>
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
    8000f5b8:	7fc080e7          	jalr	2044(ra) # 80010db0 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000f5bc:	0204b503          	ld	a0,32(s1)
    8000f5c0:	00001097          	auipc	ra,0x1
    8000f5c4:	7f0080e7          	jalr	2032(ra) # 80010db0 <_ZN9Semaphore6signalEv>

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
    8000f604:	784080e7          	jalr	1924(ra) # 80010d84 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000f608:	0284b503          	ld	a0,40(s1)
    8000f60c:	00001097          	auipc	ra,0x1
    8000f610:	778080e7          	jalr	1912(ra) # 80010d84 <_ZN9Semaphore4waitEv>

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
    8000f640:	774080e7          	jalr	1908(ra) # 80010db0 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000f644:	0184b503          	ld	a0,24(s1)
    8000f648:	00001097          	auipc	ra,0x1
    8000f64c:	768080e7          	jalr	1896(ra) # 80010db0 <_ZN9Semaphore6signalEv>

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
    8000f690:	6f8080e7          	jalr	1784(ra) # 80010d84 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    8000f694:	0304b503          	ld	a0,48(s1)
    8000f698:	00001097          	auipc	ra,0x1
    8000f69c:	6ec080e7          	jalr	1772(ra) # 80010d84 <_ZN9Semaphore4waitEv>

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
    8000f6b8:	6fc080e7          	jalr	1788(ra) # 80010db0 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000f6bc:	0284b503          	ld	a0,40(s1)
    8000f6c0:	00001097          	auipc	ra,0x1
    8000f6c4:	6f0080e7          	jalr	1776(ra) # 80010db0 <_ZN9Semaphore6signalEv>

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
    8000f710:	00002097          	auipc	ra,0x2
    8000f714:	8d8080e7          	jalr	-1832(ra) # 80010fe8 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000f718:	00003517          	auipc	a0,0x3
    8000f71c:	8e850513          	addi	a0,a0,-1816 # 80012000 <userDataStart>
    8000f720:	00001097          	auipc	ra,0x1
    8000f724:	1e4080e7          	jalr	484(ra) # 80010904 <_Z11printStringPKc>
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
    8000f74c:	00002097          	auipc	ra,0x2
    8000f750:	89c080e7          	jalr	-1892(ra) # 80010fe8 <_ZN7Console4putcEc>
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
    8000f770:	00002097          	auipc	ra,0x2
    8000f774:	878080e7          	jalr	-1928(ra) # 80010fe8 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000f778:	00a00513          	li	a0,10
    8000f77c:	00002097          	auipc	ra,0x2
    8000f780:	86c080e7          	jalr	-1940(ra) # 80010fe8 <_ZN7Console4putcEc>
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
    8000f850:	00002517          	auipc	a0,0x2
    8000f854:	7c850513          	addi	a0,a0,1992 # 80012018 <userDataStart+0x18>
    8000f858:	00001097          	auipc	ra,0x1
    8000f85c:	0ac080e7          	jalr	172(ra) # 80010904 <_Z11printStringPKc>
    8000f860:	00000613          	li	a2,0
    8000f864:	00a00593          	li	a1,10
    8000f868:	0009051b          	sext.w	a0,s2
    8000f86c:	00001097          	auipc	ra,0x1
    8000f870:	230080e7          	jalr	560(ra) # 80010a9c <_Z8printIntiii>
    8000f874:	00003517          	auipc	a0,0x3
    8000f878:	8d450513          	addi	a0,a0,-1836 # 80012148 <userDataStart+0x148>
    8000f87c:	00001097          	auipc	ra,0x1
    8000f880:	088080e7          	jalr	136(ra) # 80010904 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000f884:	00000493          	li	s1,0
    8000f888:	f99ff06f          	j	8000f820 <_Z11workerBodyAPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000f88c:	00002517          	auipc	a0,0x2
    8000f890:	79450513          	addi	a0,a0,1940 # 80012020 <userDataStart+0x20>
    8000f894:	00001097          	auipc	ra,0x1
    8000f898:	070080e7          	jalr	112(ra) # 80010904 <_Z11printStringPKc>
    finishedA = true;
    8000f89c:	00100793          	li	a5,1
    8000f8a0:	00003717          	auipc	a4,0x3
    8000f8a4:	acf70823          	sb	a5,-1328(a4) # 80012370 <finishedA>
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
    8000f91c:	00002517          	auipc	a0,0x2
    8000f920:	71450513          	addi	a0,a0,1812 # 80012030 <userDataStart+0x30>
    8000f924:	00001097          	auipc	ra,0x1
    8000f928:	fe0080e7          	jalr	-32(ra) # 80010904 <_Z11printStringPKc>
    8000f92c:	00000613          	li	a2,0
    8000f930:	00a00593          	li	a1,10
    8000f934:	0009051b          	sext.w	a0,s2
    8000f938:	00001097          	auipc	ra,0x1
    8000f93c:	164080e7          	jalr	356(ra) # 80010a9c <_Z8printIntiii>
    8000f940:	00003517          	auipc	a0,0x3
    8000f944:	80850513          	addi	a0,a0,-2040 # 80012148 <userDataStart+0x148>
    8000f948:	00001097          	auipc	ra,0x1
    8000f94c:	fbc080e7          	jalr	-68(ra) # 80010904 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000f950:	00000493          	li	s1,0
    8000f954:	f99ff06f          	j	8000f8ec <_Z11workerBodyBPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000f958:	00002517          	auipc	a0,0x2
    8000f95c:	6e050513          	addi	a0,a0,1760 # 80012038 <userDataStart+0x38>
    8000f960:	00001097          	auipc	ra,0x1
    8000f964:	fa4080e7          	jalr	-92(ra) # 80010904 <_Z11printStringPKc>
    finishedB = true;
    8000f968:	00100793          	li	a5,1
    8000f96c:	00003717          	auipc	a4,0x3
    8000f970:	a0f702a3          	sb	a5,-1531(a4) # 80012371 <finishedB>
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
    8000fa28:	00002517          	auipc	a0,0x2
    8000fa2c:	62050513          	addi	a0,a0,1568 # 80012048 <userDataStart+0x48>
    8000fa30:	00001097          	auipc	ra,0x1
    8000fa34:	ed4080e7          	jalr	-300(ra) # 80010904 <_Z11printStringPKc>
    8000fa38:	00000613          	li	a2,0
    8000fa3c:	00a00593          	li	a1,10
    8000fa40:	00048513          	mv	a0,s1
    8000fa44:	00001097          	auipc	ra,0x1
    8000fa48:	058080e7          	jalr	88(ra) # 80010a9c <_Z8printIntiii>
    8000fa4c:	00002517          	auipc	a0,0x2
    8000fa50:	6fc50513          	addi	a0,a0,1788 # 80012148 <userDataStart+0x148>
    8000fa54:	00001097          	auipc	ra,0x1
    8000fa58:	eb0080e7          	jalr	-336(ra) # 80010904 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000fa5c:	0014849b          	addiw	s1,s1,1
    8000fa60:	0ff4f493          	andi	s1,s1,255
    8000fa64:	00200793          	li	a5,2
    8000fa68:	fc97f0e3          	bgeu	a5,s1,8000fa28 <_Z11workerBodyCPv+0x20>
    }

    printString("C: dispatch\n");
    8000fa6c:	00002517          	auipc	a0,0x2
    8000fa70:	5e450513          	addi	a0,a0,1508 # 80012050 <userDataStart+0x50>
    8000fa74:	00001097          	auipc	ra,0x1
    8000fa78:	e90080e7          	jalr	-368(ra) # 80010904 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000fa7c:	00700313          	li	t1,7
    thread_dispatch();
    8000fa80:	fffff097          	auipc	ra,0xfffff
    8000fa84:	6b0080e7          	jalr	1712(ra) # 8000f130 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000fa88:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000fa8c:	00002517          	auipc	a0,0x2
    8000fa90:	5d450513          	addi	a0,a0,1492 # 80012060 <userDataStart+0x60>
    8000fa94:	00001097          	auipc	ra,0x1
    8000fa98:	e70080e7          	jalr	-400(ra) # 80010904 <_Z11printStringPKc>
    8000fa9c:	00000613          	li	a2,0
    8000faa0:	00a00593          	li	a1,10
    8000faa4:	0009051b          	sext.w	a0,s2
    8000faa8:	00001097          	auipc	ra,0x1
    8000faac:	ff4080e7          	jalr	-12(ra) # 80010a9c <_Z8printIntiii>
    8000fab0:	00002517          	auipc	a0,0x2
    8000fab4:	69850513          	addi	a0,a0,1688 # 80012148 <userDataStart+0x148>
    8000fab8:	00001097          	auipc	ra,0x1
    8000fabc:	e4c080e7          	jalr	-436(ra) # 80010904 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000fac0:	00c00513          	li	a0,12
    8000fac4:	00000097          	auipc	ra,0x0
    8000fac8:	ed0080e7          	jalr	-304(ra) # 8000f994 <_Z9fibonaccim>
    8000facc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000fad0:	00002517          	auipc	a0,0x2
    8000fad4:	59850513          	addi	a0,a0,1432 # 80012068 <userDataStart+0x68>
    8000fad8:	00001097          	auipc	ra,0x1
    8000fadc:	e2c080e7          	jalr	-468(ra) # 80010904 <_Z11printStringPKc>
    8000fae0:	00000613          	li	a2,0
    8000fae4:	00a00593          	li	a1,10
    8000fae8:	0009051b          	sext.w	a0,s2
    8000faec:	00001097          	auipc	ra,0x1
    8000faf0:	fb0080e7          	jalr	-80(ra) # 80010a9c <_Z8printIntiii>
    8000faf4:	00002517          	auipc	a0,0x2
    8000faf8:	65450513          	addi	a0,a0,1620 # 80012148 <userDataStart+0x148>
    8000fafc:	00001097          	auipc	ra,0x1
    8000fb00:	e08080e7          	jalr	-504(ra) # 80010904 <_Z11printStringPKc>
    8000fb04:	0400006f          	j	8000fb44 <_Z11workerBodyCPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000fb08:	00002517          	auipc	a0,0x2
    8000fb0c:	54050513          	addi	a0,a0,1344 # 80012048 <userDataStart+0x48>
    8000fb10:	00001097          	auipc	ra,0x1
    8000fb14:	df4080e7          	jalr	-524(ra) # 80010904 <_Z11printStringPKc>
    8000fb18:	00000613          	li	a2,0
    8000fb1c:	00a00593          	li	a1,10
    8000fb20:	00048513          	mv	a0,s1
    8000fb24:	00001097          	auipc	ra,0x1
    8000fb28:	f78080e7          	jalr	-136(ra) # 80010a9c <_Z8printIntiii>
    8000fb2c:	00002517          	auipc	a0,0x2
    8000fb30:	61c50513          	addi	a0,a0,1564 # 80012148 <userDataStart+0x148>
    8000fb34:	00001097          	auipc	ra,0x1
    8000fb38:	dd0080e7          	jalr	-560(ra) # 80010904 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000fb3c:	0014849b          	addiw	s1,s1,1
    8000fb40:	0ff4f493          	andi	s1,s1,255
    8000fb44:	00500793          	li	a5,5
    8000fb48:	fc97f0e3          	bgeu	a5,s1,8000fb08 <_Z11workerBodyCPv+0x100>
    }

    printString("A finished!\n");
    8000fb4c:	00002517          	auipc	a0,0x2
    8000fb50:	4d450513          	addi	a0,a0,1236 # 80012020 <userDataStart+0x20>
    8000fb54:	00001097          	auipc	ra,0x1
    8000fb58:	db0080e7          	jalr	-592(ra) # 80010904 <_Z11printStringPKc>
    finishedC = true;
    8000fb5c:	00100793          	li	a5,1
    8000fb60:	00003717          	auipc	a4,0x3
    8000fb64:	80f70c23          	sb	a5,-2024(a4) # 80012378 <finishedC>
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
    8000fba8:	00002517          	auipc	a0,0x2
    8000fbac:	4d050513          	addi	a0,a0,1232 # 80012078 <userDataStart+0x78>
    8000fbb0:	00001097          	auipc	ra,0x1
    8000fbb4:	d54080e7          	jalr	-684(ra) # 80010904 <_Z11printStringPKc>
    8000fbb8:	00000613          	li	a2,0
    8000fbbc:	00a00593          	li	a1,10
    8000fbc0:	00048513          	mv	a0,s1
    8000fbc4:	00001097          	auipc	ra,0x1
    8000fbc8:	ed8080e7          	jalr	-296(ra) # 80010a9c <_Z8printIntiii>
    8000fbcc:	00002517          	auipc	a0,0x2
    8000fbd0:	57c50513          	addi	a0,a0,1404 # 80012148 <userDataStart+0x148>
    8000fbd4:	00001097          	auipc	ra,0x1
    8000fbd8:	d30080e7          	jalr	-720(ra) # 80010904 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000fbdc:	0014849b          	addiw	s1,s1,1
    8000fbe0:	0ff4f493          	andi	s1,s1,255
    8000fbe4:	00c00793          	li	a5,12
    8000fbe8:	fc97f0e3          	bgeu	a5,s1,8000fba8 <_Z11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000fbec:	00002517          	auipc	a0,0x2
    8000fbf0:	49450513          	addi	a0,a0,1172 # 80012080 <userDataStart+0x80>
    8000fbf4:	00001097          	auipc	ra,0x1
    8000fbf8:	d10080e7          	jalr	-752(ra) # 80010904 <_Z11printStringPKc>
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
    8000fc18:	00002517          	auipc	a0,0x2
    8000fc1c:	47850513          	addi	a0,a0,1144 # 80012090 <userDataStart+0x90>
    8000fc20:	00001097          	auipc	ra,0x1
    8000fc24:	ce4080e7          	jalr	-796(ra) # 80010904 <_Z11printStringPKc>
    8000fc28:	00000613          	li	a2,0
    8000fc2c:	00a00593          	li	a1,10
    8000fc30:	0009051b          	sext.w	a0,s2
    8000fc34:	00001097          	auipc	ra,0x1
    8000fc38:	e68080e7          	jalr	-408(ra) # 80010a9c <_Z8printIntiii>
    8000fc3c:	00002517          	auipc	a0,0x2
    8000fc40:	50c50513          	addi	a0,a0,1292 # 80012148 <userDataStart+0x148>
    8000fc44:	00001097          	auipc	ra,0x1
    8000fc48:	cc0080e7          	jalr	-832(ra) # 80010904 <_Z11printStringPKc>
    8000fc4c:	0400006f          	j	8000fc8c <_Z11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000fc50:	00002517          	auipc	a0,0x2
    8000fc54:	42850513          	addi	a0,a0,1064 # 80012078 <userDataStart+0x78>
    8000fc58:	00001097          	auipc	ra,0x1
    8000fc5c:	cac080e7          	jalr	-852(ra) # 80010904 <_Z11printStringPKc>
    8000fc60:	00000613          	li	a2,0
    8000fc64:	00a00593          	li	a1,10
    8000fc68:	00048513          	mv	a0,s1
    8000fc6c:	00001097          	auipc	ra,0x1
    8000fc70:	e30080e7          	jalr	-464(ra) # 80010a9c <_Z8printIntiii>
    8000fc74:	00002517          	auipc	a0,0x2
    8000fc78:	4d450513          	addi	a0,a0,1236 # 80012148 <userDataStart+0x148>
    8000fc7c:	00001097          	auipc	ra,0x1
    8000fc80:	c88080e7          	jalr	-888(ra) # 80010904 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000fc84:	0014849b          	addiw	s1,s1,1
    8000fc88:	0ff4f493          	andi	s1,s1,255
    8000fc8c:	00f00793          	li	a5,15
    8000fc90:	fc97f0e3          	bgeu	a5,s1,8000fc50 <_Z11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000fc94:	00002517          	auipc	a0,0x2
    8000fc98:	40c50513          	addi	a0,a0,1036 # 800120a0 <userDataStart+0xa0>
    8000fc9c:	00001097          	auipc	ra,0x1
    8000fca0:	c68080e7          	jalr	-920(ra) # 80010904 <_Z11printStringPKc>
    finishedD = true;
    8000fca4:	00100793          	li	a5,1
    8000fca8:	00002717          	auipc	a4,0x2
    8000fcac:	6cf708a3          	sb	a5,1745(a4) # 80012379 <finishedD>
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
    8000fcfc:	00002517          	auipc	a0,0x2
    8000fd00:	3b450513          	addi	a0,a0,948 # 800120b0 <userDataStart+0xb0>
    8000fd04:	00001097          	auipc	ra,0x1
    8000fd08:	c00080e7          	jalr	-1024(ra) # 80010904 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000fd0c:	00000613          	li	a2,0
    8000fd10:	00000597          	auipc	a1,0x0
    8000fd14:	bb058593          	addi	a1,a1,-1104 # 8000f8c0 <_Z11workerBodyBPv>
    8000fd18:	fc840513          	addi	a0,s0,-56
    8000fd1c:	fffff097          	auipc	ra,0xfffff
    8000fd20:	360080e7          	jalr	864(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000fd24:	00002517          	auipc	a0,0x2
    8000fd28:	3a450513          	addi	a0,a0,932 # 800120c8 <userDataStart+0xc8>
    8000fd2c:	00001097          	auipc	ra,0x1
    8000fd30:	bd8080e7          	jalr	-1064(ra) # 80010904 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000fd34:	00000613          	li	a2,0
    8000fd38:	00000597          	auipc	a1,0x0
    8000fd3c:	cd058593          	addi	a1,a1,-816 # 8000fa08 <_Z11workerBodyCPv>
    8000fd40:	fd040513          	addi	a0,s0,-48
    8000fd44:	fffff097          	auipc	ra,0xfffff
    8000fd48:	338080e7          	jalr	824(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000fd4c:	00002517          	auipc	a0,0x2
    8000fd50:	39450513          	addi	a0,a0,916 # 800120e0 <userDataStart+0xe0>
    8000fd54:	00001097          	auipc	ra,0x1
    8000fd58:	bb0080e7          	jalr	-1104(ra) # 80010904 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000fd5c:	00000613          	li	a2,0
    8000fd60:	00000597          	auipc	a1,0x0
    8000fd64:	e2858593          	addi	a1,a1,-472 # 8000fb88 <_Z11workerBodyDPv>
    8000fd68:	fd840513          	addi	a0,s0,-40
    8000fd6c:	fffff097          	auipc	ra,0xfffff
    8000fd70:	310080e7          	jalr	784(ra) # 8000f07c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    8000fd74:	00002517          	auipc	a0,0x2
    8000fd78:	38450513          	addi	a0,a0,900 # 800120f8 <userDataStart+0xf8>
    8000fd7c:	00001097          	auipc	ra,0x1
    8000fd80:	b88080e7          	jalr	-1144(ra) # 80010904 <_Z11printStringPKc>
    8000fd84:	00c0006f          	j	8000fd90 <_Z18Threads_C_API_testv+0xc0>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000fd88:	fffff097          	auipc	ra,0xfffff
    8000fd8c:	3a8080e7          	jalr	936(ra) # 8000f130 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    8000fd90:	00002797          	auipc	a5,0x2
    8000fd94:	5e07c783          	lbu	a5,1504(a5) # 80012370 <finishedA>
    8000fd98:	fe0788e3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    8000fd9c:	00002797          	auipc	a5,0x2
    8000fda0:	5d57c783          	lbu	a5,1493(a5) # 80012371 <finishedB>
    8000fda4:	fe0782e3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    8000fda8:	00002797          	auipc	a5,0x2
    8000fdac:	5d07c783          	lbu	a5,1488(a5) # 80012378 <finishedC>
    8000fdb0:	fc078ce3          	beqz	a5,8000fd88 <_Z18Threads_C_API_testv+0xb8>
    8000fdb4:	00002797          	auipc	a5,0x2
    8000fdb8:	5c57c783          	lbu	a5,1477(a5) # 80012379 <finishedD>
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

000000008000fdfc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>:

            td->sem->signal();
        }
    };

    void testConsumerProducer() {
    8000fdfc:	f8010113          	addi	sp,sp,-128
    8000fe00:	06113c23          	sd	ra,120(sp)
    8000fe04:	06813823          	sd	s0,112(sp)
    8000fe08:	06913423          	sd	s1,104(sp)
    8000fe0c:	07213023          	sd	s2,96(sp)
    8000fe10:	05313c23          	sd	s3,88(sp)
    8000fe14:	05413823          	sd	s4,80(sp)
    8000fe18:	05513423          	sd	s5,72(sp)
    8000fe1c:	05613023          	sd	s6,64(sp)
    8000fe20:	03713c23          	sd	s7,56(sp)
    8000fe24:	03813823          	sd	s8,48(sp)
    8000fe28:	03913423          	sd	s9,40(sp)
    8000fe2c:	08010413          	addi	s0,sp,128
        delete waitForAll;
        for (int i = 0; i < threadNum; i++) {
            delete producers[i];
        }
        delete consumer;
        delete buffer;
    8000fe30:	00010b93          	mv	s7,sp
        printString("Unesite broj proizvodjaca?\n");
    8000fe34:	00002517          	auipc	a0,0x2
    8000fe38:	2dc50513          	addi	a0,a0,732 # 80012110 <userDataStart+0x110>
    8000fe3c:	00001097          	auipc	ra,0x1
    8000fe40:	ac8080e7          	jalr	-1336(ra) # 80010904 <_Z11printStringPKc>
        getString(input, 30);
    8000fe44:	01e00593          	li	a1,30
    8000fe48:	f8040493          	addi	s1,s0,-128
    8000fe4c:	00048513          	mv	a0,s1
    8000fe50:	00001097          	auipc	ra,0x1
    8000fe54:	b30080e7          	jalr	-1232(ra) # 80010980 <_Z9getStringPci>
        threadNum = stringToInt(input);
    8000fe58:	00048513          	mv	a0,s1
    8000fe5c:	00001097          	auipc	ra,0x1
    8000fe60:	bf0080e7          	jalr	-1040(ra) # 80010a4c <_Z11stringToIntPKc>
    8000fe64:	00050913          	mv	s2,a0
        printString("Unesite velicinu bafera?\n");
    8000fe68:	00002517          	auipc	a0,0x2
    8000fe6c:	2c850513          	addi	a0,a0,712 # 80012130 <userDataStart+0x130>
    8000fe70:	00001097          	auipc	ra,0x1
    8000fe74:	a94080e7          	jalr	-1388(ra) # 80010904 <_Z11printStringPKc>
        getString(input, 30);
    8000fe78:	01e00593          	li	a1,30
    8000fe7c:	00048513          	mv	a0,s1
    8000fe80:	00001097          	auipc	ra,0x1
    8000fe84:	b00080e7          	jalr	-1280(ra) # 80010980 <_Z9getStringPci>
        n = stringToInt(input);
    8000fe88:	00048513          	mv	a0,s1
    8000fe8c:	00001097          	auipc	ra,0x1
    8000fe90:	bc0080e7          	jalr	-1088(ra) # 80010a4c <_Z11stringToIntPKc>
    8000fe94:	00050493          	mv	s1,a0
        printString("Broj proizvodjaca "); printInt(threadNum);
    8000fe98:	00002517          	auipc	a0,0x2
    8000fe9c:	2b850513          	addi	a0,a0,696 # 80012150 <userDataStart+0x150>
    8000fea0:	00001097          	auipc	ra,0x1
    8000fea4:	a64080e7          	jalr	-1436(ra) # 80010904 <_Z11printStringPKc>
    8000fea8:	00000613          	li	a2,0
    8000feac:	00a00593          	li	a1,10
    8000feb0:	00090513          	mv	a0,s2
    8000feb4:	00001097          	auipc	ra,0x1
    8000feb8:	be8080e7          	jalr	-1048(ra) # 80010a9c <_Z8printIntiii>
        printString(" i velicina bafera "); printInt(n);
    8000febc:	00002517          	auipc	a0,0x2
    8000fec0:	2ac50513          	addi	a0,a0,684 # 80012168 <userDataStart+0x168>
    8000fec4:	00001097          	auipc	ra,0x1
    8000fec8:	a40080e7          	jalr	-1472(ra) # 80010904 <_Z11printStringPKc>
    8000fecc:	00000613          	li	a2,0
    8000fed0:	00a00593          	li	a1,10
    8000fed4:	00048513          	mv	a0,s1
    8000fed8:	00001097          	auipc	ra,0x1
    8000fedc:	bc4080e7          	jalr	-1084(ra) # 80010a9c <_Z8printIntiii>
        printString(".\n");
    8000fee0:	00002517          	auipc	a0,0x2
    8000fee4:	2a050513          	addi	a0,a0,672 # 80012180 <userDataStart+0x180>
    8000fee8:	00001097          	auipc	ra,0x1
    8000feec:	a1c080e7          	jalr	-1508(ra) # 80010904 <_Z11printStringPKc>
        if(threadNum > n) {
    8000fef0:	0324c663          	blt	s1,s2,8000ff1c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x120>
        } else if (threadNum < 1) {
    8000fef4:	03205e63          	blez	s2,8000ff30 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x134>
        BufferCPP *buffer = new BufferCPP(n);
    8000fef8:	03800513          	li	a0,56
    8000fefc:	00001097          	auipc	ra,0x1
    8000ff00:	d58080e7          	jalr	-680(ra) # 80010c54 <_Znwm>
    8000ff04:	00050a93          	mv	s5,a0
    8000ff08:	04050063          	beqz	a0,8000ff48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
    8000ff0c:	00048593          	mv	a1,s1
    8000ff10:	fffff097          	auipc	ra,0xfffff
    8000ff14:	4dc080e7          	jalr	1244(ra) # 8000f3ec <_ZN9BufferCPPC1Ei>
    8000ff18:	0300006f          	j	8000ff48 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x14c>
            printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000ff1c:	00002517          	auipc	a0,0x2
    8000ff20:	26c50513          	addi	a0,a0,620 # 80012188 <userDataStart+0x188>
    8000ff24:	00001097          	auipc	ra,0x1
    8000ff28:	9e0080e7          	jalr	-1568(ra) # 80010904 <_Z11printStringPKc>
            return;
    8000ff2c:	0140006f          	j	8000ff40 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x144>
            printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000ff30:	00002517          	auipc	a0,0x2
    8000ff34:	29850513          	addi	a0,a0,664 # 800121c8 <userDataStart+0x1c8>
    8000ff38:	00001097          	auipc	ra,0x1
    8000ff3c:	9cc080e7          	jalr	-1588(ra) # 80010904 <_Z11printStringPKc>
            return;
    8000ff40:	000b8113          	mv	sp,s7
    8000ff44:	24c0006f          	j	80010190 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x394>
        waitForAll = new Semaphore(0);
    8000ff48:	01000513          	li	a0,16
    8000ff4c:	00001097          	auipc	ra,0x1
    8000ff50:	d08080e7          	jalr	-760(ra) # 80010c54 <_Znwm>
    8000ff54:	00050493          	mv	s1,a0
    8000ff58:	00050863          	beqz	a0,8000ff68 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x16c>
    8000ff5c:	00000593          	li	a1,0
    8000ff60:	00001097          	auipc	ra,0x1
    8000ff64:	dec080e7          	jalr	-532(ra) # 80010d4c <_ZN9SemaphoreC1Ej>
    8000ff68:	00002717          	auipc	a4,0x2
    8000ff6c:	40870713          	addi	a4,a4,1032 # 80012370 <finishedA>
    8000ff70:	00973823          	sd	s1,16(a4)
        Thread *producers[threadNum];
    8000ff74:	00391793          	slli	a5,s2,0x3
    8000ff78:	00f78793          	addi	a5,a5,15
    8000ff7c:	ff07f793          	andi	a5,a5,-16
    8000ff80:	40f10133          	sub	sp,sp,a5
    8000ff84:	00010a13          	mv	s4,sp
        thread_data threadData[threadNum + 1];
    8000ff88:	0019069b          	addiw	a3,s2,1
    8000ff8c:	00169793          	slli	a5,a3,0x1
    8000ff90:	00d787b3          	add	a5,a5,a3
    8000ff94:	00379793          	slli	a5,a5,0x3
    8000ff98:	00f78793          	addi	a5,a5,15
    8000ff9c:	ff07f793          	andi	a5,a5,-16
    8000ffa0:	40f10133          	sub	sp,sp,a5
    8000ffa4:	00010993          	mv	s3,sp
        threadData[threadNum].id = threadNum;
    8000ffa8:	00191793          	slli	a5,s2,0x1
    8000ffac:	012787b3          	add	a5,a5,s2
    8000ffb0:	00379793          	slli	a5,a5,0x3
    8000ffb4:	00f987b3          	add	a5,s3,a5
    8000ffb8:	0127a023          	sw	s2,0(a5)
        threadData[threadNum].buffer = buffer;
    8000ffbc:	0157b423          	sd	s5,8(a5)
        threadData[threadNum].sem = waitForAll;
    8000ffc0:	01073703          	ld	a4,16(a4)
    8000ffc4:	00e7b823          	sd	a4,16(a5)
        Thread *consumer = new Consumer(&threadData[threadNum]);
    8000ffc8:	01800513          	li	a0,24
    8000ffcc:	00001097          	auipc	ra,0x1
    8000ffd0:	c88080e7          	jalr	-888(ra) # 80010c54 <_Znwm>
    8000ffd4:	00050b13          	mv	s6,a0
    8000ffd8:	02050663          	beqz	a0,80010004 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x208>
    8000ffdc:	00191493          	slli	s1,s2,0x1
    8000ffe0:	012484b3          	add	s1,s1,s2
    8000ffe4:	00349493          	slli	s1,s1,0x3
    8000ffe8:	009984b3          	add	s1,s3,s1
        Consumer(thread_data *_td) : Thread(), td(_td) {}
    8000ffec:	00001097          	auipc	ra,0x1
    8000fff0:	e44080e7          	jalr	-444(ra) # 80010e30 <_ZN6ThreadC1Ev>
    8000fff4:	00002797          	auipc	a5,0x2
    8000fff8:	2ac78793          	addi	a5,a5,684 # 800122a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    8000fffc:	00fb3023          	sd	a5,0(s6) # 2000 <_entry-0x7fffe000>
    80010000:	009b3823          	sd	s1,16(s6)
        consumer->start();
    80010004:	000b0513          	mv	a0,s6
    80010008:	00001097          	auipc	ra,0x1
    8001000c:	f18080e7          	jalr	-232(ra) # 80010f20 <_ZN6Thread5startEv>
        threadData[0].id = 0;
    80010010:	0009a023          	sw	zero,0(s3)
        threadData[0].buffer = buffer;
    80010014:	0159b423          	sd	s5,8(s3)
        threadData[0].sem = waitForAll;
    80010018:	00002797          	auipc	a5,0x2
    8001001c:	3687b783          	ld	a5,872(a5) # 80012380 <_ZN19ConsumerProducerCPP10waitForAllE>
    80010020:	00f9b823          	sd	a5,16(s3)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80010024:	01800513          	li	a0,24
    80010028:	00001097          	auipc	ra,0x1
    8001002c:	c2c080e7          	jalr	-980(ra) # 80010c54 <_Znwm>
    80010030:	00050493          	mv	s1,a0
    80010034:	00050e63          	beqz	a0,80010050 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x254>
        ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80010038:	00001097          	auipc	ra,0x1
    8001003c:	df8080e7          	jalr	-520(ra) # 80010e30 <_ZN6ThreadC1Ev>
    80010040:	00002797          	auipc	a5,0x2
    80010044:	21078793          	addi	a5,a5,528 # 80012250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80010048:	00f4b023          	sd	a5,0(s1)
    8001004c:	0134b823          	sd	s3,16(s1)
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80010050:	009a3023          	sd	s1,0(s4)
        producers[0]->start();
    80010054:	00048513          	mv	a0,s1
    80010058:	00001097          	auipc	ra,0x1
    8001005c:	ec8080e7          	jalr	-312(ra) # 80010f20 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80010060:	00100493          	li	s1,1
    80010064:	0300006f          	j	80010094 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x298>
        Producer(thread_data *_td) : Thread(), td(_td) {}
    80010068:	00002797          	auipc	a5,0x2
    8001006c:	21078793          	addi	a5,a5,528 # 80012278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80010070:	00fc3023          	sd	a5,0(s8)
    80010074:	019c3823          	sd	s9,16(s8)
            producers[i] = new Producer(&threadData[i]);
    80010078:	00349793          	slli	a5,s1,0x3
    8001007c:	00fa07b3          	add	a5,s4,a5
    80010080:	0187b023          	sd	s8,0(a5)
            producers[i]->start();
    80010084:	000c0513          	mv	a0,s8
    80010088:	00001097          	auipc	ra,0x1
    8001008c:	e98080e7          	jalr	-360(ra) # 80010f20 <_ZN6Thread5startEv>
        for (int i = 1; i < threadNum; i++) {
    80010090:	0014849b          	addiw	s1,s1,1
    80010094:	0524dc63          	bge	s1,s2,800100ec <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2f0>
            threadData[i].id = i;
    80010098:	00149793          	slli	a5,s1,0x1
    8001009c:	009787b3          	add	a5,a5,s1
    800100a0:	00379793          	slli	a5,a5,0x3
    800100a4:	00f987b3          	add	a5,s3,a5
    800100a8:	0097a023          	sw	s1,0(a5)
            threadData[i].buffer = buffer;
    800100ac:	0157b423          	sd	s5,8(a5)
            threadData[i].sem = waitForAll;
    800100b0:	00002717          	auipc	a4,0x2
    800100b4:	2d073703          	ld	a4,720(a4) # 80012380 <_ZN19ConsumerProducerCPP10waitForAllE>
    800100b8:	00e7b823          	sd	a4,16(a5)
            producers[i] = new Producer(&threadData[i]);
    800100bc:	01800513          	li	a0,24
    800100c0:	00001097          	auipc	ra,0x1
    800100c4:	b94080e7          	jalr	-1132(ra) # 80010c54 <_Znwm>
    800100c8:	00050c13          	mv	s8,a0
    800100cc:	fa0506e3          	beqz	a0,80010078 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x27c>
    800100d0:	00149c93          	slli	s9,s1,0x1
    800100d4:	009c8cb3          	add	s9,s9,s1
    800100d8:	003c9c93          	slli	s9,s9,0x3
    800100dc:	01998cb3          	add	s9,s3,s9
        Producer(thread_data *_td) : Thread(), td(_td) {}
    800100e0:	00001097          	auipc	ra,0x1
    800100e4:	d50080e7          	jalr	-688(ra) # 80010e30 <_ZN6ThreadC1Ev>
    800100e8:	f81ff06f          	j	80010068 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x26c>
        Thread::dispatch();
    800100ec:	00001097          	auipc	ra,0x1
    800100f0:	e0c080e7          	jalr	-500(ra) # 80010ef8 <_ZN6Thread8dispatchEv>
        for (int i = 0; i <= threadNum; i++) {
    800100f4:	00000493          	li	s1,0
    800100f8:	00994e63          	blt	s2,s1,80010114 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x318>
            waitForAll->wait();
    800100fc:	00002517          	auipc	a0,0x2
    80010100:	28453503          	ld	a0,644(a0) # 80012380 <_ZN19ConsumerProducerCPP10waitForAllE>
    80010104:	00001097          	auipc	ra,0x1
    80010108:	c80080e7          	jalr	-896(ra) # 80010d84 <_ZN9Semaphore4waitEv>
        for (int i = 0; i <= threadNum; i++) {
    8001010c:	0014849b          	addiw	s1,s1,1
    80010110:	fe9ff06f          	j	800100f8 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x2fc>
        delete waitForAll;
    80010114:	00002517          	auipc	a0,0x2
    80010118:	26c53503          	ld	a0,620(a0) # 80012380 <_ZN19ConsumerProducerCPP10waitForAllE>
    8001011c:	00050863          	beqz	a0,8001012c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x330>
    80010120:	00053783          	ld	a5,0(a0)
    80010124:	0087b783          	ld	a5,8(a5)
    80010128:	000780e7          	jalr	a5
        for (int i = 0; i <= threadNum; i++) {
    8001012c:	00000493          	li	s1,0
    80010130:	0080006f          	j	80010138 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x33c>
        for (int i = 0; i < threadNum; i++) {
    80010134:	0014849b          	addiw	s1,s1,1
    80010138:	0324d263          	bge	s1,s2,8001015c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x360>
            delete producers[i];
    8001013c:	00349793          	slli	a5,s1,0x3
    80010140:	00fa07b3          	add	a5,s4,a5
    80010144:	0007b503          	ld	a0,0(a5)
    80010148:	fe0506e3          	beqz	a0,80010134 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
    8001014c:	00053783          	ld	a5,0(a0)
    80010150:	0087b783          	ld	a5,8(a5)
    80010154:	000780e7          	jalr	a5
    80010158:	fddff06f          	j	80010134 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x338>
        delete consumer;
    8001015c:	000b0a63          	beqz	s6,80010170 <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x374>
    80010160:	000b3783          	ld	a5,0(s6)
    80010164:	0087b783          	ld	a5,8(a5)
    80010168:	000b0513          	mv	a0,s6
    8001016c:	000780e7          	jalr	a5
        delete buffer;
    80010170:	000a8e63          	beqz	s5,8001018c <_ZN19ConsumerProducerCPP20testConsumerProducerEv+0x390>
    80010174:	000a8513          	mv	a0,s5
    80010178:	fffff097          	auipc	ra,0xfffff
    8001017c:	57c080e7          	jalr	1404(ra) # 8000f6f4 <_ZN9BufferCPPD1Ev>
    80010180:	000a8513          	mv	a0,s5
    80010184:	00001097          	auipc	ra,0x1
    80010188:	b20080e7          	jalr	-1248(ra) # 80010ca4 <_ZdlPv>
    8001018c:	000b8113          	mv	sp,s7
    }
    80010190:	f8040113          	addi	sp,s0,-128
    80010194:	07813083          	ld	ra,120(sp)
    80010198:	07013403          	ld	s0,112(sp)
    8001019c:	06813483          	ld	s1,104(sp)
    800101a0:	06013903          	ld	s2,96(sp)
    800101a4:	05813983          	ld	s3,88(sp)
    800101a8:	05013a03          	ld	s4,80(sp)
    800101ac:	04813a83          	ld	s5,72(sp)
    800101b0:	04013b03          	ld	s6,64(sp)
    800101b4:	03813b83          	ld	s7,56(sp)
    800101b8:	03013c03          	ld	s8,48(sp)
    800101bc:	02813c83          	ld	s9,40(sp)
    800101c0:	08010113          	addi	sp,sp,128
    800101c4:	00008067          	ret
    800101c8:	00050493          	mv	s1,a0
        BufferCPP *buffer = new BufferCPP(n);
    800101cc:	000a8513          	mv	a0,s5
    800101d0:	00001097          	auipc	ra,0x1
    800101d4:	ad4080e7          	jalr	-1324(ra) # 80010ca4 <_ZdlPv>
    800101d8:	00048513          	mv	a0,s1
    800101dc:	ffffd097          	auipc	ra,0xffffd
    800101e0:	d1c080e7          	jalr	-740(ra) # 8000cef8 <_Unwind_Resume>
    800101e4:	00050913          	mv	s2,a0
        waitForAll = new Semaphore(0);
    800101e8:	00048513          	mv	a0,s1
    800101ec:	00001097          	auipc	ra,0x1
    800101f0:	ab8080e7          	jalr	-1352(ra) # 80010ca4 <_ZdlPv>
    800101f4:	00090513          	mv	a0,s2
    800101f8:	ffffd097          	auipc	ra,0xffffd
    800101fc:	d00080e7          	jalr	-768(ra) # 8000cef8 <_Unwind_Resume>
    80010200:	00050493          	mv	s1,a0
        Thread *consumer = new Consumer(&threadData[threadNum]);
    80010204:	000b0513          	mv	a0,s6
    80010208:	00001097          	auipc	ra,0x1
    8001020c:	a9c080e7          	jalr	-1380(ra) # 80010ca4 <_ZdlPv>
    80010210:	00048513          	mv	a0,s1
    80010214:	ffffd097          	auipc	ra,0xffffd
    80010218:	ce4080e7          	jalr	-796(ra) # 8000cef8 <_Unwind_Resume>
    8001021c:	00050913          	mv	s2,a0
        producers[0] = new ProducerKeyborad(&threadData[0]);
    80010220:	00048513          	mv	a0,s1
    80010224:	00001097          	auipc	ra,0x1
    80010228:	a80080e7          	jalr	-1408(ra) # 80010ca4 <_ZdlPv>
    8001022c:	00090513          	mv	a0,s2
    80010230:	ffffd097          	auipc	ra,0xffffd
    80010234:	cc8080e7          	jalr	-824(ra) # 8000cef8 <_Unwind_Resume>
    80010238:	00050493          	mv	s1,a0
            producers[i] = new Producer(&threadData[i]);
    8001023c:	000c0513          	mv	a0,s8
    80010240:	00001097          	auipc	ra,0x1
    80010244:	a64080e7          	jalr	-1436(ra) # 80010ca4 <_ZdlPv>
    80010248:	00048513          	mv	a0,s1
    8001024c:	ffffd097          	auipc	ra,0xffffd
    80010250:	cac080e7          	jalr	-852(ra) # 8000cef8 <_Unwind_Resume>

0000000080010254 <_Z8userMainv>:

//#include "ThreadSleep_C_API_test.hpp" // thread_sleep test C API
#include "ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void userMain() {
    80010254:	ff010113          	addi	sp,sp,-16
    80010258:	00113423          	sd	ra,8(sp)
    8001025c:	00813023          	sd	s0,0(sp)
    80010260:	01010413          	addi	s0,sp,16

//    producerConsumer_C_API(); // zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta
//    producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

//    testSleeping(); // thread_sleep test C API
    ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega
    80010264:	00000097          	auipc	ra,0x0
    80010268:	b98080e7          	jalr	-1128(ra) # 8000fdfc <_ZN19ConsumerProducerCPP20testConsumerProducerEv>

    8001026c:	00813083          	ld	ra,8(sp)
    80010270:	00013403          	ld	s0,0(sp)
    80010274:	01010113          	addi	sp,sp,16
    80010278:	00008067          	ret

000000008001027c <_ZN19ConsumerProducerCPP8Consumer3runEv>:
        void run() override {
    8001027c:	fd010113          	addi	sp,sp,-48
    80010280:	02113423          	sd	ra,40(sp)
    80010284:	02813023          	sd	s0,32(sp)
    80010288:	00913c23          	sd	s1,24(sp)
    8001028c:	01213823          	sd	s2,16(sp)
    80010290:	01313423          	sd	s3,8(sp)
    80010294:	03010413          	addi	s0,sp,48
    80010298:	00050913          	mv	s2,a0
            int i = 0;
    8001029c:	00000993          	li	s3,0
    800102a0:	0100006f          	j	800102b0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
                    Console::putc('\n');
    800102a4:	00a00513          	li	a0,10
    800102a8:	00001097          	auipc	ra,0x1
    800102ac:	d40080e7          	jalr	-704(ra) # 80010fe8 <_ZN7Console4putcEc>
            while (!threadEnd) {
    800102b0:	00002797          	auipc	a5,0x2
    800102b4:	0c47a783          	lw	a5,196(a5) # 80012374 <_ZN19ConsumerProducerCPP9threadEndE>
    800102b8:	04079a63          	bnez	a5,8001030c <_ZN19ConsumerProducerCPP8Consumer3runEv+0x90>
                int key = td->buffer->get();
    800102bc:	01093783          	ld	a5,16(s2)
    800102c0:	0087b503          	ld	a0,8(a5)
    800102c4:	fffff097          	auipc	ra,0xfffff
    800102c8:	31c080e7          	jalr	796(ra) # 8000f5e0 <_ZN9BufferCPP3getEv>
                i++;
    800102cc:	0019849b          	addiw	s1,s3,1
    800102d0:	0004899b          	sext.w	s3,s1
                Console::putc(key);
    800102d4:	0ff57513          	andi	a0,a0,255
    800102d8:	00001097          	auipc	ra,0x1
    800102dc:	d10080e7          	jalr	-752(ra) # 80010fe8 <_ZN7Console4putcEc>
                if (i % 80 == 0) {
    800102e0:	05000793          	li	a5,80
    800102e4:	02f4e4bb          	remw	s1,s1,a5
    800102e8:	fc0494e3          	bnez	s1,800102b0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x34>
    800102ec:	fb9ff06f          	j	800102a4 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x28>
                int key = td->buffer->get();
    800102f0:	01093783          	ld	a5,16(s2)
    800102f4:	0087b503          	ld	a0,8(a5)
    800102f8:	fffff097          	auipc	ra,0xfffff
    800102fc:	2e8080e7          	jalr	744(ra) # 8000f5e0 <_ZN9BufferCPP3getEv>
                Console::putc(key);
    80010300:	0ff57513          	andi	a0,a0,255
    80010304:	00001097          	auipc	ra,0x1
    80010308:	ce4080e7          	jalr	-796(ra) # 80010fe8 <_ZN7Console4putcEc>
            while (td->buffer->getCnt() > 0) {
    8001030c:	01093783          	ld	a5,16(s2)
    80010310:	0087b503          	ld	a0,8(a5)
    80010314:	fffff097          	auipc	ra,0xfffff
    80010318:	358080e7          	jalr	856(ra) # 8000f66c <_ZN9BufferCPP6getCntEv>
    8001031c:	fca04ae3          	bgtz	a0,800102f0 <_ZN19ConsumerProducerCPP8Consumer3runEv+0x74>
            td->sem->signal();
    80010320:	01093783          	ld	a5,16(s2)
    80010324:	0107b503          	ld	a0,16(a5)
    80010328:	00001097          	auipc	ra,0x1
    8001032c:	a88080e7          	jalr	-1400(ra) # 80010db0 <_ZN9Semaphore6signalEv>
        }
    80010330:	02813083          	ld	ra,40(sp)
    80010334:	02013403          	ld	s0,32(sp)
    80010338:	01813483          	ld	s1,24(sp)
    8001033c:	01013903          	ld	s2,16(sp)
    80010340:	00813983          	ld	s3,8(sp)
    80010344:	03010113          	addi	sp,sp,48
    80010348:	00008067          	ret

000000008001034c <_ZN19ConsumerProducerCPP8ConsumerD1Ev>:
    class Consumer : public Thread {
    8001034c:	ff010113          	addi	sp,sp,-16
    80010350:	00113423          	sd	ra,8(sp)
    80010354:	00813023          	sd	s0,0(sp)
    80010358:	01010413          	addi	s0,sp,16
    8001035c:	00002797          	auipc	a5,0x2
    80010360:	f4478793          	addi	a5,a5,-188 # 800122a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    80010364:	00f53023          	sd	a5,0(a0)
    80010368:	00001097          	auipc	ra,0x1
    8001036c:	8ac080e7          	jalr	-1876(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80010370:	00813083          	ld	ra,8(sp)
    80010374:	00013403          	ld	s0,0(sp)
    80010378:	01010113          	addi	sp,sp,16
    8001037c:	00008067          	ret

0000000080010380 <_ZN19ConsumerProducerCPP8ConsumerD0Ev>:
    80010380:	fe010113          	addi	sp,sp,-32
    80010384:	00113c23          	sd	ra,24(sp)
    80010388:	00813823          	sd	s0,16(sp)
    8001038c:	00913423          	sd	s1,8(sp)
    80010390:	02010413          	addi	s0,sp,32
    80010394:	00050493          	mv	s1,a0
    80010398:	00002797          	auipc	a5,0x2
    8001039c:	f0878793          	addi	a5,a5,-248 # 800122a0 <_ZTVN19ConsumerProducerCPP8ConsumerE+0x10>
    800103a0:	00f53023          	sd	a5,0(a0)
    800103a4:	00001097          	auipc	ra,0x1
    800103a8:	870080e7          	jalr	-1936(ra) # 80010c14 <_ZN6ThreadD1Ev>
    800103ac:	00048513          	mv	a0,s1
    800103b0:	00001097          	auipc	ra,0x1
    800103b4:	8f4080e7          	jalr	-1804(ra) # 80010ca4 <_ZdlPv>
    800103b8:	01813083          	ld	ra,24(sp)
    800103bc:	01013403          	ld	s0,16(sp)
    800103c0:	00813483          	ld	s1,8(sp)
    800103c4:	02010113          	addi	sp,sp,32
    800103c8:	00008067          	ret

00000000800103cc <_ZN19ConsumerProducerCPP16ProducerKeyboradD1Ev>:
    class ProducerKeyborad : public Thread {
    800103cc:	ff010113          	addi	sp,sp,-16
    800103d0:	00113423          	sd	ra,8(sp)
    800103d4:	00813023          	sd	s0,0(sp)
    800103d8:	01010413          	addi	s0,sp,16
    800103dc:	00002797          	auipc	a5,0x2
    800103e0:	e7478793          	addi	a5,a5,-396 # 80012250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    800103e4:	00f53023          	sd	a5,0(a0)
    800103e8:	00001097          	auipc	ra,0x1
    800103ec:	82c080e7          	jalr	-2004(ra) # 80010c14 <_ZN6ThreadD1Ev>
    800103f0:	00813083          	ld	ra,8(sp)
    800103f4:	00013403          	ld	s0,0(sp)
    800103f8:	01010113          	addi	sp,sp,16
    800103fc:	00008067          	ret

0000000080010400 <_ZN19ConsumerProducerCPP16ProducerKeyboradD0Ev>:
    80010400:	fe010113          	addi	sp,sp,-32
    80010404:	00113c23          	sd	ra,24(sp)
    80010408:	00813823          	sd	s0,16(sp)
    8001040c:	00913423          	sd	s1,8(sp)
    80010410:	02010413          	addi	s0,sp,32
    80010414:	00050493          	mv	s1,a0
    80010418:	00002797          	auipc	a5,0x2
    8001041c:	e3878793          	addi	a5,a5,-456 # 80012250 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE+0x10>
    80010420:	00f53023          	sd	a5,0(a0)
    80010424:	00000097          	auipc	ra,0x0
    80010428:	7f0080e7          	jalr	2032(ra) # 80010c14 <_ZN6ThreadD1Ev>
    8001042c:	00048513          	mv	a0,s1
    80010430:	00001097          	auipc	ra,0x1
    80010434:	874080e7          	jalr	-1932(ra) # 80010ca4 <_ZdlPv>
    80010438:	01813083          	ld	ra,24(sp)
    8001043c:	01013403          	ld	s0,16(sp)
    80010440:	00813483          	ld	s1,8(sp)
    80010444:	02010113          	addi	sp,sp,32
    80010448:	00008067          	ret

000000008001044c <_ZN19ConsumerProducerCPP8ProducerD1Ev>:
    class Producer : public Thread {
    8001044c:	ff010113          	addi	sp,sp,-16
    80010450:	00113423          	sd	ra,8(sp)
    80010454:	00813023          	sd	s0,0(sp)
    80010458:	01010413          	addi	s0,sp,16
    8001045c:	00002797          	auipc	a5,0x2
    80010460:	e1c78793          	addi	a5,a5,-484 # 80012278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    80010464:	00f53023          	sd	a5,0(a0)
    80010468:	00000097          	auipc	ra,0x0
    8001046c:	7ac080e7          	jalr	1964(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80010470:	00813083          	ld	ra,8(sp)
    80010474:	00013403          	ld	s0,0(sp)
    80010478:	01010113          	addi	sp,sp,16
    8001047c:	00008067          	ret

0000000080010480 <_ZN19ConsumerProducerCPP8ProducerD0Ev>:
    80010480:	fe010113          	addi	sp,sp,-32
    80010484:	00113c23          	sd	ra,24(sp)
    80010488:	00813823          	sd	s0,16(sp)
    8001048c:	00913423          	sd	s1,8(sp)
    80010490:	02010413          	addi	s0,sp,32
    80010494:	00050493          	mv	s1,a0
    80010498:	00002797          	auipc	a5,0x2
    8001049c:	de078793          	addi	a5,a5,-544 # 80012278 <_ZTVN19ConsumerProducerCPP8ProducerE+0x10>
    800104a0:	00f53023          	sd	a5,0(a0)
    800104a4:	00000097          	auipc	ra,0x0
    800104a8:	770080e7          	jalr	1904(ra) # 80010c14 <_ZN6ThreadD1Ev>
    800104ac:	00048513          	mv	a0,s1
    800104b0:	00000097          	auipc	ra,0x0
    800104b4:	7f4080e7          	jalr	2036(ra) # 80010ca4 <_ZdlPv>
    800104b8:	01813083          	ld	ra,24(sp)
    800104bc:	01013403          	ld	s0,16(sp)
    800104c0:	00813483          	ld	s1,8(sp)
    800104c4:	02010113          	addi	sp,sp,32
    800104c8:	00008067          	ret

00000000800104cc <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv>:
        void run() override {
    800104cc:	fe010113          	addi	sp,sp,-32
    800104d0:	00113c23          	sd	ra,24(sp)
    800104d4:	00813823          	sd	s0,16(sp)
    800104d8:	00913423          	sd	s1,8(sp)
    800104dc:	02010413          	addi	s0,sp,32
    800104e0:	00050493          	mv	s1,a0
            while ((key = getc()) != 0x1b) {
    800104e4:	fffff097          	auipc	ra,0xfffff
    800104e8:	e20080e7          	jalr	-480(ra) # 8000f304 <_Z4getcv>
    800104ec:	0005059b          	sext.w	a1,a0
    800104f0:	01b00793          	li	a5,27
    800104f4:	00f58c63          	beq	a1,a5,8001050c <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x40>
                td->buffer->put(key);
    800104f8:	0104b783          	ld	a5,16(s1)
    800104fc:	0087b503          	ld	a0,8(a5)
    80010500:	fffff097          	auipc	ra,0xfffff
    80010504:	050080e7          	jalr	80(ra) # 8000f550 <_ZN9BufferCPP3putEi>
            while ((key = getc()) != 0x1b) {
    80010508:	fddff06f          	j	800104e4 <_ZN19ConsumerProducerCPP16ProducerKeyborad3runEv+0x18>
            threadEnd = 1;
    8001050c:	00100793          	li	a5,1
    80010510:	00002717          	auipc	a4,0x2
    80010514:	e6f72223          	sw	a5,-412(a4) # 80012374 <_ZN19ConsumerProducerCPP9threadEndE>
            td->buffer->put('!');
    80010518:	0104b783          	ld	a5,16(s1)
    8001051c:	02100593          	li	a1,33
    80010520:	0087b503          	ld	a0,8(a5)
    80010524:	fffff097          	auipc	ra,0xfffff
    80010528:	02c080e7          	jalr	44(ra) # 8000f550 <_ZN9BufferCPP3putEi>
            td->sem->signal();
    8001052c:	0104b783          	ld	a5,16(s1)
    80010530:	0107b503          	ld	a0,16(a5)
    80010534:	00001097          	auipc	ra,0x1
    80010538:	87c080e7          	jalr	-1924(ra) # 80010db0 <_ZN9Semaphore6signalEv>
        }
    8001053c:	01813083          	ld	ra,24(sp)
    80010540:	01013403          	ld	s0,16(sp)
    80010544:	00813483          	ld	s1,8(sp)
    80010548:	02010113          	addi	sp,sp,32
    8001054c:	00008067          	ret

0000000080010550 <_ZN19ConsumerProducerCPP8Producer3runEv>:
        void run() override {
    80010550:	fe010113          	addi	sp,sp,-32
    80010554:	00113c23          	sd	ra,24(sp)
    80010558:	00813823          	sd	s0,16(sp)
    8001055c:	00913423          	sd	s1,8(sp)
    80010560:	01213023          	sd	s2,0(sp)
    80010564:	02010413          	addi	s0,sp,32
    80010568:	00050493          	mv	s1,a0
            int i = 0;
    8001056c:	00000913          	li	s2,0
            while (!threadEnd) {
    80010570:	00002797          	auipc	a5,0x2
    80010574:	e047a783          	lw	a5,-508(a5) # 80012374 <_ZN19ConsumerProducerCPP9threadEndE>
    80010578:	04079263          	bnez	a5,800105bc <_ZN19ConsumerProducerCPP8Producer3runEv+0x6c>
                td->buffer->put(td->id + '0');
    8001057c:	0104b783          	ld	a5,16(s1)
    80010580:	0007a583          	lw	a1,0(a5)
    80010584:	0305859b          	addiw	a1,a1,48
    80010588:	0087b503          	ld	a0,8(a5)
    8001058c:	fffff097          	auipc	ra,0xfffff
    80010590:	fc4080e7          	jalr	-60(ra) # 8000f550 <_ZN9BufferCPP3putEi>
                i++;
    80010594:	0019071b          	addiw	a4,s2,1
    80010598:	0007091b          	sext.w	s2,a4
                Thread::sleep((i+td->id)%5);
    8001059c:	0104b783          	ld	a5,16(s1)
    800105a0:	0007a783          	lw	a5,0(a5)
    800105a4:	00e787bb          	addw	a5,a5,a4
    800105a8:	00500513          	li	a0,5
    800105ac:	02a7e53b          	remw	a0,a5,a0
    800105b0:	00001097          	auipc	ra,0x1
    800105b4:	8e0080e7          	jalr	-1824(ra) # 80010e90 <_ZN6Thread5sleepEm>
            while (!threadEnd) {
    800105b8:	fb9ff06f          	j	80010570 <_ZN19ConsumerProducerCPP8Producer3runEv+0x20>
            td->sem->signal();
    800105bc:	0104b783          	ld	a5,16(s1)
    800105c0:	0107b503          	ld	a0,16(a5)
    800105c4:	00000097          	auipc	ra,0x0
    800105c8:	7ec080e7          	jalr	2028(ra) # 80010db0 <_ZN9Semaphore6signalEv>
        }
    800105cc:	01813083          	ld	ra,24(sp)
    800105d0:	01013403          	ld	s0,16(sp)
    800105d4:	00813483          	ld	s1,8(sp)
    800105d8:	00013903          	ld	s2,0(sp)
    800105dc:	02010113          	addi	sp,sp,32
    800105e0:	00008067          	ret

00000000800105e4 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800105e4:	fe010113          	addi	sp,sp,-32
    800105e8:	00113c23          	sd	ra,24(sp)
    800105ec:	00813823          	sd	s0,16(sp)
    800105f0:	00913423          	sd	s1,8(sp)
    800105f4:	01213023          	sd	s2,0(sp)
    800105f8:	02010413          	addi	s0,sp,32
    800105fc:	00050493          	mv	s1,a0
    80010600:	00058913          	mv	s2,a1
    80010604:	0015879b          	addiw	a5,a1,1
    80010608:	0007851b          	sext.w	a0,a5
    8001060c:	00f4a023          	sw	a5,0(s1)
    80010610:	0004a823          	sw	zero,16(s1)
    80010614:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80010618:	00251513          	slli	a0,a0,0x2
    8001061c:	fffff097          	auipc	ra,0xfffff
    80010620:	a04080e7          	jalr	-1532(ra) # 8000f020 <_Z9mem_allocm>
    80010624:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80010628:	00000593          	li	a1,0
    8001062c:	02048513          	addi	a0,s1,32
    80010630:	fffff097          	auipc	ra,0xfffff
    80010634:	bec080e7          	jalr	-1044(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&spaceAvailable, _cap);
    80010638:	00090593          	mv	a1,s2
    8001063c:	01848513          	addi	a0,s1,24
    80010640:	fffff097          	auipc	ra,0xfffff
    80010644:	bdc080e7          	jalr	-1060(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexHead, 1);
    80010648:	00100593          	li	a1,1
    8001064c:	02848513          	addi	a0,s1,40
    80010650:	fffff097          	auipc	ra,0xfffff
    80010654:	bcc080e7          	jalr	-1076(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
    sem_open(&mutexTail, 1);
    80010658:	00100593          	li	a1,1
    8001065c:	03048513          	addi	a0,s1,48
    80010660:	fffff097          	auipc	ra,0xfffff
    80010664:	bbc080e7          	jalr	-1092(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
}
    80010668:	01813083          	ld	ra,24(sp)
    8001066c:	01013403          	ld	s0,16(sp)
    80010670:	00813483          	ld	s1,8(sp)
    80010674:	00013903          	ld	s2,0(sp)
    80010678:	02010113          	addi	sp,sp,32
    8001067c:	00008067          	ret

0000000080010680 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80010680:	fe010113          	addi	sp,sp,-32
    80010684:	00113c23          	sd	ra,24(sp)
    80010688:	00813823          	sd	s0,16(sp)
    8001068c:	00913423          	sd	s1,8(sp)
    80010690:	01213023          	sd	s2,0(sp)
    80010694:	02010413          	addi	s0,sp,32
    80010698:	00050493          	mv	s1,a0
    8001069c:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800106a0:	01853503          	ld	a0,24(a0)
    800106a4:	fffff097          	auipc	ra,0xfffff
    800106a8:	bdc080e7          	jalr	-1060(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexTail);
    800106ac:	0304b503          	ld	a0,48(s1)
    800106b0:	fffff097          	auipc	ra,0xfffff
    800106b4:	bd0080e7          	jalr	-1072(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
    buffer[tail] = val;
    800106b8:	0084b783          	ld	a5,8(s1)
    800106bc:	0144a703          	lw	a4,20(s1)
    800106c0:	00271713          	slli	a4,a4,0x2
    800106c4:	00e787b3          	add	a5,a5,a4
    800106c8:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800106cc:	0144a783          	lw	a5,20(s1)
    800106d0:	0017879b          	addiw	a5,a5,1
    800106d4:	0004a703          	lw	a4,0(s1)
    800106d8:	02e7e7bb          	remw	a5,a5,a4
    800106dc:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800106e0:	0304b503          	ld	a0,48(s1)
    800106e4:	fffff097          	auipc	ra,0xfffff
    800106e8:	bc8080e7          	jalr	-1080(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    sem_signal(itemAvailable);
    800106ec:	0204b503          	ld	a0,32(s1)
    800106f0:	fffff097          	auipc	ra,0xfffff
    800106f4:	bbc080e7          	jalr	-1092(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

}
    800106f8:	01813083          	ld	ra,24(sp)
    800106fc:	01013403          	ld	s0,16(sp)
    80010700:	00813483          	ld	s1,8(sp)
    80010704:	00013903          	ld	s2,0(sp)
    80010708:	02010113          	addi	sp,sp,32
    8001070c:	00008067          	ret

0000000080010710 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80010710:	fe010113          	addi	sp,sp,-32
    80010714:	00113c23          	sd	ra,24(sp)
    80010718:	00813823          	sd	s0,16(sp)
    8001071c:	00913423          	sd	s1,8(sp)
    80010720:	01213023          	sd	s2,0(sp)
    80010724:	02010413          	addi	s0,sp,32
    80010728:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    8001072c:	02053503          	ld	a0,32(a0)
    80010730:	fffff097          	auipc	ra,0xfffff
    80010734:	b50080e7          	jalr	-1200(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    sem_wait(mutexHead);
    80010738:	0284b503          	ld	a0,40(s1)
    8001073c:	fffff097          	auipc	ra,0xfffff
    80010740:	b44080e7          	jalr	-1212(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    int ret = buffer[head];
    80010744:	0084b703          	ld	a4,8(s1)
    80010748:	0104a783          	lw	a5,16(s1)
    8001074c:	00279693          	slli	a3,a5,0x2
    80010750:	00d70733          	add	a4,a4,a3
    80010754:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80010758:	0017879b          	addiw	a5,a5,1
    8001075c:	0004a703          	lw	a4,0(s1)
    80010760:	02e7e7bb          	remw	a5,a5,a4
    80010764:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80010768:	0284b503          	ld	a0,40(s1)
    8001076c:	fffff097          	auipc	ra,0xfffff
    80010770:	b40080e7          	jalr	-1216(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    sem_signal(spaceAvailable);
    80010774:	0184b503          	ld	a0,24(s1)
    80010778:	fffff097          	auipc	ra,0xfffff
    8001077c:	b34080e7          	jalr	-1228(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    80010780:	00090513          	mv	a0,s2
    80010784:	01813083          	ld	ra,24(sp)
    80010788:	01013403          	ld	s0,16(sp)
    8001078c:	00813483          	ld	s1,8(sp)
    80010790:	00013903          	ld	s2,0(sp)
    80010794:	02010113          	addi	sp,sp,32
    80010798:	00008067          	ret

000000008001079c <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    8001079c:	fe010113          	addi	sp,sp,-32
    800107a0:	00113c23          	sd	ra,24(sp)
    800107a4:	00813823          	sd	s0,16(sp)
    800107a8:	00913423          	sd	s1,8(sp)
    800107ac:	01213023          	sd	s2,0(sp)
    800107b0:	02010413          	addi	s0,sp,32
    800107b4:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800107b8:	02853503          	ld	a0,40(a0)
    800107bc:	fffff097          	auipc	ra,0xfffff
    800107c0:	ac4080e7          	jalr	-1340(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
    sem_wait(mutexTail);
    800107c4:	0304b503          	ld	a0,48(s1)
    800107c8:	fffff097          	auipc	ra,0xfffff
    800107cc:	ab8080e7          	jalr	-1352(ra) # 8000f280 <_Z8sem_waitP10_semaphore>

    if (tail >= head) {
    800107d0:	0144a783          	lw	a5,20(s1)
    800107d4:	0104a903          	lw	s2,16(s1)
    800107d8:	0327ce63          	blt	a5,s2,80010814 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800107dc:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800107e0:	0304b503          	ld	a0,48(s1)
    800107e4:	fffff097          	auipc	ra,0xfffff
    800107e8:	ac8080e7          	jalr	-1336(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>
    sem_signal(mutexHead);
    800107ec:	0284b503          	ld	a0,40(s1)
    800107f0:	fffff097          	auipc	ra,0xfffff
    800107f4:	abc080e7          	jalr	-1348(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>

    return ret;
}
    800107f8:	00090513          	mv	a0,s2
    800107fc:	01813083          	ld	ra,24(sp)
    80010800:	01013403          	ld	s0,16(sp)
    80010804:	00813483          	ld	s1,8(sp)
    80010808:	00013903          	ld	s2,0(sp)
    8001080c:	02010113          	addi	sp,sp,32
    80010810:	00008067          	ret
        ret = cap - head + tail;
    80010814:	0004a703          	lw	a4,0(s1)
    80010818:	4127093b          	subw	s2,a4,s2
    8001081c:	00f9093b          	addw	s2,s2,a5
    80010820:	fc1ff06f          	j	800107e0 <_ZN6Buffer6getCntEv+0x44>

0000000080010824 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80010824:	fe010113          	addi	sp,sp,-32
    80010828:	00113c23          	sd	ra,24(sp)
    8001082c:	00813823          	sd	s0,16(sp)
    80010830:	00913423          	sd	s1,8(sp)
    80010834:	02010413          	addi	s0,sp,32
    80010838:	00050493          	mv	s1,a0
    putc('\n');
    8001083c:	00a00513          	li	a0,10
    80010840:	fffff097          	auipc	ra,0xfffff
    80010844:	aec080e7          	jalr	-1300(ra) # 8000f32c <_Z4putcc>
    printString("Buffer deleted!\n");
    80010848:	00001517          	auipc	a0,0x1
    8001084c:	7b850513          	addi	a0,a0,1976 # 80012000 <userDataStart>
    80010850:	00000097          	auipc	ra,0x0
    80010854:	0b4080e7          	jalr	180(ra) # 80010904 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80010858:	00048513          	mv	a0,s1
    8001085c:	00000097          	auipc	ra,0x0
    80010860:	f40080e7          	jalr	-192(ra) # 8001079c <_ZN6Buffer6getCntEv>
    80010864:	02a05c63          	blez	a0,8001089c <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80010868:	0084b783          	ld	a5,8(s1)
    8001086c:	0104a703          	lw	a4,16(s1)
    80010870:	00271713          	slli	a4,a4,0x2
    80010874:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80010878:	0007c503          	lbu	a0,0(a5)
    8001087c:	fffff097          	auipc	ra,0xfffff
    80010880:	ab0080e7          	jalr	-1360(ra) # 8000f32c <_Z4putcc>
        head = (head + 1) % cap;
    80010884:	0104a783          	lw	a5,16(s1)
    80010888:	0017879b          	addiw	a5,a5,1
    8001088c:	0004a703          	lw	a4,0(s1)
    80010890:	02e7e7bb          	remw	a5,a5,a4
    80010894:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80010898:	fc1ff06f          	j	80010858 <_ZN6BufferD1Ev+0x34>
    putc('!');
    8001089c:	02100513          	li	a0,33
    800108a0:	fffff097          	auipc	ra,0xfffff
    800108a4:	a8c080e7          	jalr	-1396(ra) # 8000f32c <_Z4putcc>
    putc('\n');
    800108a8:	00a00513          	li	a0,10
    800108ac:	fffff097          	auipc	ra,0xfffff
    800108b0:	a80080e7          	jalr	-1408(ra) # 8000f32c <_Z4putcc>
    mem_free(buffer);
    800108b4:	0084b503          	ld	a0,8(s1)
    800108b8:	ffffe097          	auipc	ra,0xffffe
    800108bc:	798080e7          	jalr	1944(ra) # 8000f050 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800108c0:	0204b503          	ld	a0,32(s1)
    800108c4:	fffff097          	auipc	ra,0xfffff
    800108c8:	990080e7          	jalr	-1648(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(spaceAvailable);
    800108cc:	0184b503          	ld	a0,24(s1)
    800108d0:	fffff097          	auipc	ra,0xfffff
    800108d4:	984080e7          	jalr	-1660(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexTail);
    800108d8:	0304b503          	ld	a0,48(s1)
    800108dc:	fffff097          	auipc	ra,0xfffff
    800108e0:	978080e7          	jalr	-1672(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
    sem_close(mutexHead);
    800108e4:	0284b503          	ld	a0,40(s1)
    800108e8:	fffff097          	auipc	ra,0xfffff
    800108ec:	96c080e7          	jalr	-1684(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
}
    800108f0:	01813083          	ld	ra,24(sp)
    800108f4:	01013403          	ld	s0,16(sp)
    800108f8:	00813483          	ld	s1,8(sp)
    800108fc:	02010113          	addi	sp,sp,32
    80010900:	00008067          	ret

0000000080010904 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80010904:	fe010113          	addi	sp,sp,-32
    80010908:	00113c23          	sd	ra,24(sp)
    8001090c:	00813823          	sd	s0,16(sp)
    80010910:	00913423          	sd	s1,8(sp)
    80010914:	02010413          	addi	s0,sp,32
    80010918:	00050493          	mv	s1,a0
    LOCK();
    8001091c:	00100613          	li	a2,1
    80010920:	00000593          	li	a1,0
    80010924:	00002517          	auipc	a0,0x2
    80010928:	a6450513          	addi	a0,a0,-1436 # 80012388 <lockPrint>
    8001092c:	ffffe097          	auipc	ra,0xffffe
    80010930:	6d4080e7          	jalr	1748(ra) # 8000f000 <copy_and_swap>
    80010934:	fe0514e3          	bnez	a0,8001091c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80010938:	0004c503          	lbu	a0,0(s1)
    8001093c:	00050a63          	beqz	a0,80010950 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80010940:	fffff097          	auipc	ra,0xfffff
    80010944:	9ec080e7          	jalr	-1556(ra) # 8000f32c <_Z4putcc>
        string++;
    80010948:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8001094c:	fedff06f          	j	80010938 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80010950:	00000613          	li	a2,0
    80010954:	00100593          	li	a1,1
    80010958:	00002517          	auipc	a0,0x2
    8001095c:	a3050513          	addi	a0,a0,-1488 # 80012388 <lockPrint>
    80010960:	ffffe097          	auipc	ra,0xffffe
    80010964:	6a0080e7          	jalr	1696(ra) # 8000f000 <copy_and_swap>
    80010968:	fe0514e3          	bnez	a0,80010950 <_Z11printStringPKc+0x4c>
}
    8001096c:	01813083          	ld	ra,24(sp)
    80010970:	01013403          	ld	s0,16(sp)
    80010974:	00813483          	ld	s1,8(sp)
    80010978:	02010113          	addi	sp,sp,32
    8001097c:	00008067          	ret

0000000080010980 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80010980:	fd010113          	addi	sp,sp,-48
    80010984:	02113423          	sd	ra,40(sp)
    80010988:	02813023          	sd	s0,32(sp)
    8001098c:	00913c23          	sd	s1,24(sp)
    80010990:	01213823          	sd	s2,16(sp)
    80010994:	01313423          	sd	s3,8(sp)
    80010998:	01413023          	sd	s4,0(sp)
    8001099c:	03010413          	addi	s0,sp,48
    800109a0:	00050993          	mv	s3,a0
    800109a4:	00058a13          	mv	s4,a1
    LOCK();
    800109a8:	00100613          	li	a2,1
    800109ac:	00000593          	li	a1,0
    800109b0:	00002517          	auipc	a0,0x2
    800109b4:	9d850513          	addi	a0,a0,-1576 # 80012388 <lockPrint>
    800109b8:	ffffe097          	auipc	ra,0xffffe
    800109bc:	648080e7          	jalr	1608(ra) # 8000f000 <copy_and_swap>
    800109c0:	fe0514e3          	bnez	a0,800109a8 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800109c4:	00000913          	li	s2,0
    800109c8:	00090493          	mv	s1,s2
    800109cc:	0019091b          	addiw	s2,s2,1
    800109d0:	03495a63          	bge	s2,s4,80010a04 <_Z9getStringPci+0x84>
        cc = getc();
    800109d4:	fffff097          	auipc	ra,0xfffff
    800109d8:	930080e7          	jalr	-1744(ra) # 8000f304 <_Z4getcv>
        if(cc < 1)
    800109dc:	02050463          	beqz	a0,80010a04 <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    800109e0:	009984b3          	add	s1,s3,s1
    800109e4:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800109e8:	00a00793          	li	a5,10
    800109ec:	00f50a63          	beq	a0,a5,80010a00 <_Z9getStringPci+0x80>
    800109f0:	00d00793          	li	a5,13
    800109f4:	fcf51ae3          	bne	a0,a5,800109c8 <_Z9getStringPci+0x48>
        buf[i++] = c;
    800109f8:	00090493          	mv	s1,s2
    800109fc:	0080006f          	j	80010a04 <_Z9getStringPci+0x84>
    80010a00:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80010a04:	009984b3          	add	s1,s3,s1
    80010a08:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80010a0c:	00000613          	li	a2,0
    80010a10:	00100593          	li	a1,1
    80010a14:	00002517          	auipc	a0,0x2
    80010a18:	97450513          	addi	a0,a0,-1676 # 80012388 <lockPrint>
    80010a1c:	ffffe097          	auipc	ra,0xffffe
    80010a20:	5e4080e7          	jalr	1508(ra) # 8000f000 <copy_and_swap>
    80010a24:	fe0514e3          	bnez	a0,80010a0c <_Z9getStringPci+0x8c>
    return buf;
}
    80010a28:	00098513          	mv	a0,s3
    80010a2c:	02813083          	ld	ra,40(sp)
    80010a30:	02013403          	ld	s0,32(sp)
    80010a34:	01813483          	ld	s1,24(sp)
    80010a38:	01013903          	ld	s2,16(sp)
    80010a3c:	00813983          	ld	s3,8(sp)
    80010a40:	00013a03          	ld	s4,0(sp)
    80010a44:	03010113          	addi	sp,sp,48
    80010a48:	00008067          	ret

0000000080010a4c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80010a4c:	ff010113          	addi	sp,sp,-16
    80010a50:	00813423          	sd	s0,8(sp)
    80010a54:	01010413          	addi	s0,sp,16
    80010a58:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80010a5c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80010a60:	0006c603          	lbu	a2,0(a3)
    80010a64:	fd06071b          	addiw	a4,a2,-48
    80010a68:	0ff77713          	andi	a4,a4,255
    80010a6c:	00900793          	li	a5,9
    80010a70:	02e7e063          	bltu	a5,a4,80010a90 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80010a74:	0025179b          	slliw	a5,a0,0x2
    80010a78:	00a787bb          	addw	a5,a5,a0
    80010a7c:	0017979b          	slliw	a5,a5,0x1
    80010a80:	00168693          	addi	a3,a3,1
    80010a84:	00c787bb          	addw	a5,a5,a2
    80010a88:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80010a8c:	fd5ff06f          	j	80010a60 <_Z11stringToIntPKc+0x14>
    return n;
}
    80010a90:	00813403          	ld	s0,8(sp)
    80010a94:	01010113          	addi	sp,sp,16
    80010a98:	00008067          	ret

0000000080010a9c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80010a9c:	fc010113          	addi	sp,sp,-64
    80010aa0:	02113c23          	sd	ra,56(sp)
    80010aa4:	02813823          	sd	s0,48(sp)
    80010aa8:	02913423          	sd	s1,40(sp)
    80010aac:	03213023          	sd	s2,32(sp)
    80010ab0:	01313c23          	sd	s3,24(sp)
    80010ab4:	04010413          	addi	s0,sp,64
    80010ab8:	00050493          	mv	s1,a0
    80010abc:	00058913          	mv	s2,a1
    80010ac0:	00060993          	mv	s3,a2
    LOCK();
    80010ac4:	00100613          	li	a2,1
    80010ac8:	00000593          	li	a1,0
    80010acc:	00002517          	auipc	a0,0x2
    80010ad0:	8bc50513          	addi	a0,a0,-1860 # 80012388 <lockPrint>
    80010ad4:	ffffe097          	auipc	ra,0xffffe
    80010ad8:	52c080e7          	jalr	1324(ra) # 8000f000 <copy_and_swap>
    80010adc:	fe0514e3          	bnez	a0,80010ac4 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80010ae0:	00098463          	beqz	s3,80010ae8 <_Z8printIntiii+0x4c>
    80010ae4:	0804c463          	bltz	s1,80010b6c <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80010ae8:	0004851b          	sext.w	a0,s1
    neg = 0;
    80010aec:	00000593          	li	a1,0
    }

    i = 0;
    80010af0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80010af4:	0009079b          	sext.w	a5,s2
    80010af8:	0325773b          	remuw	a4,a0,s2
    80010afc:	00048613          	mv	a2,s1
    80010b00:	0014849b          	addiw	s1,s1,1
    80010b04:	02071693          	slli	a3,a4,0x20
    80010b08:	0206d693          	srli	a3,a3,0x20
    80010b0c:	00001717          	auipc	a4,0x1
    80010b10:	7ac70713          	addi	a4,a4,1964 # 800122b8 <digits>
    80010b14:	00d70733          	add	a4,a4,a3
    80010b18:	00074683          	lbu	a3,0(a4)
    80010b1c:	fd040713          	addi	a4,s0,-48
    80010b20:	00c70733          	add	a4,a4,a2
    80010b24:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80010b28:	0005071b          	sext.w	a4,a0
    80010b2c:	0325553b          	divuw	a0,a0,s2
    80010b30:	fcf772e3          	bgeu	a4,a5,80010af4 <_Z8printIntiii+0x58>
    if(neg)
    80010b34:	00058c63          	beqz	a1,80010b4c <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80010b38:	fd040793          	addi	a5,s0,-48
    80010b3c:	009784b3          	add	s1,a5,s1
    80010b40:	02d00793          	li	a5,45
    80010b44:	fef48823          	sb	a5,-16(s1)
    80010b48:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80010b4c:	fff4849b          	addiw	s1,s1,-1
    80010b50:	0204c463          	bltz	s1,80010b78 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80010b54:	fd040793          	addi	a5,s0,-48
    80010b58:	009787b3          	add	a5,a5,s1
    80010b5c:	ff07c503          	lbu	a0,-16(a5)
    80010b60:	ffffe097          	auipc	ra,0xffffe
    80010b64:	7cc080e7          	jalr	1996(ra) # 8000f32c <_Z4putcc>
    80010b68:	fe5ff06f          	j	80010b4c <_Z8printIntiii+0xb0>
        x = -xx;
    80010b6c:	4090053b          	negw	a0,s1
        neg = 1;
    80010b70:	00100593          	li	a1,1
        x = -xx;
    80010b74:	f7dff06f          	j	80010af0 <_Z8printIntiii+0x54>

    UNLOCK();
    80010b78:	00000613          	li	a2,0
    80010b7c:	00100593          	li	a1,1
    80010b80:	00002517          	auipc	a0,0x2
    80010b84:	80850513          	addi	a0,a0,-2040 # 80012388 <lockPrint>
    80010b88:	ffffe097          	auipc	ra,0xffffe
    80010b8c:	478080e7          	jalr	1144(ra) # 8000f000 <copy_and_swap>
    80010b90:	fe0514e3          	bnez	a0,80010b78 <_Z8printIntiii+0xdc>
    80010b94:	03813083          	ld	ra,56(sp)
    80010b98:	03013403          	ld	s0,48(sp)
    80010b9c:	02813483          	ld	s1,40(sp)
    80010ba0:	02013903          	ld	s2,32(sp)
    80010ba4:	01813983          	ld	s3,24(sp)
    80010ba8:	04010113          	addi	sp,sp,64
    80010bac:	00008067          	ret

0000000080010bb0 <_ZN6Thread7wrapperEPv>:
    int status = thread_attach_body(&myHandle, body, arg);
    if(status == -1)
        myHandle = nullptr;
}

void Thread::wrapper(void *arg) {
    80010bb0:	ff010113          	addi	sp,sp,-16
    80010bb4:	00113423          	sd	ra,8(sp)
    80010bb8:	00813023          	sd	s0,0(sp)
    80010bbc:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)arg;
    thr->run();
    80010bc0:	00053783          	ld	a5,0(a0)
    80010bc4:	0107b783          	ld	a5,16(a5)
    80010bc8:	000780e7          	jalr	a5
}
    80010bcc:	00813083          	ld	ra,8(sp)
    80010bd0:	00013403          	ld	s0,0(sp)
    80010bd4:	01010113          	addi	sp,sp,16
    80010bd8:	00008067          	ret

0000000080010bdc <_ZN9SemaphoreD1Ev>:
Semaphore::~Semaphore(){
    80010bdc:	ff010113          	addi	sp,sp,-16
    80010be0:	00113423          	sd	ra,8(sp)
    80010be4:	00813023          	sd	s0,0(sp)
    80010be8:	01010413          	addi	s0,sp,16
    80010bec:	00001797          	auipc	a5,0x1
    80010bf0:	72478793          	addi	a5,a5,1828 # 80012310 <_ZTV9Semaphore+0x10>
    80010bf4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80010bf8:	00853503          	ld	a0,8(a0)
    80010bfc:	ffffe097          	auipc	ra,0xffffe
    80010c00:	658080e7          	jalr	1624(ra) # 8000f254 <_Z9sem_closeP10_semaphore>
};
    80010c04:	00813083          	ld	ra,8(sp)
    80010c08:	00013403          	ld	s0,0(sp)
    80010c0c:	01010113          	addi	sp,sp,16
    80010c10:	00008067          	ret

0000000080010c14 <_ZN6ThreadD1Ev>:

int Thread::start() {
    return thread_start(myHandle);
}

Thread::~Thread() {
    80010c14:	00001797          	auipc	a5,0x1
    80010c18:	71c78793          	addi	a5,a5,1820 # 80012330 <_ZTV6Thread+0x10>
    80010c1c:	00f53023          	sd	a5,0(a0)
    delete myHandle;
    80010c20:	00853503          	ld	a0,8(a0)
    80010c24:	02050663          	beqz	a0,80010c50 <_ZN6ThreadD1Ev+0x3c>
Thread::~Thread() {
    80010c28:	ff010113          	addi	sp,sp,-16
    80010c2c:	00113423          	sd	ra,8(sp)
    80010c30:	00813023          	sd	s0,0(sp)
    80010c34:	01010413          	addi	s0,sp,16
    delete myHandle;
    80010c38:	ffffe097          	auipc	ra,0xffffe
    80010c3c:	78c080e7          	jalr	1932(ra) # 8000f3c4 <_ZN7_threaddlEPv>
}
    80010c40:	00813083          	ld	ra,8(sp)
    80010c44:	00013403          	ld	s0,0(sp)
    80010c48:	01010113          	addi	sp,sp,16
    80010c4c:	00008067          	ret
    80010c50:	00008067          	ret

0000000080010c54 <_Znwm>:
void* operator new(size_t sz){
    80010c54:	ff010113          	addi	sp,sp,-16
    80010c58:	00113423          	sd	ra,8(sp)
    80010c5c:	00813023          	sd	s0,0(sp)
    80010c60:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80010c64:	ffffe097          	auipc	ra,0xffffe
    80010c68:	3bc080e7          	jalr	956(ra) # 8000f020 <_Z9mem_allocm>
}
    80010c6c:	00813083          	ld	ra,8(sp)
    80010c70:	00013403          	ld	s0,0(sp)
    80010c74:	01010113          	addi	sp,sp,16
    80010c78:	00008067          	ret

0000000080010c7c <_Znam>:
void* operator new[](size_t sz){
    80010c7c:	ff010113          	addi	sp,sp,-16
    80010c80:	00113423          	sd	ra,8(sp)
    80010c84:	00813023          	sd	s0,0(sp)
    80010c88:	01010413          	addi	s0,sp,16
    return mem_alloc(sz);
    80010c8c:	ffffe097          	auipc	ra,0xffffe
    80010c90:	394080e7          	jalr	916(ra) # 8000f020 <_Z9mem_allocm>
}
    80010c94:	00813083          	ld	ra,8(sp)
    80010c98:	00013403          	ld	s0,0(sp)
    80010c9c:	01010113          	addi	sp,sp,16
    80010ca0:	00008067          	ret

0000000080010ca4 <_ZdlPv>:
void operator delete(void *ptr){
    80010ca4:	ff010113          	addi	sp,sp,-16
    80010ca8:	00113423          	sd	ra,8(sp)
    80010cac:	00813023          	sd	s0,0(sp)
    80010cb0:	01010413          	addi	s0,sp,16
    mem_free(ptr);
    80010cb4:	ffffe097          	auipc	ra,0xffffe
    80010cb8:	39c080e7          	jalr	924(ra) # 8000f050 <_Z8mem_freePv>
}
    80010cbc:	00813083          	ld	ra,8(sp)
    80010cc0:	00013403          	ld	s0,0(sp)
    80010cc4:	01010113          	addi	sp,sp,16
    80010cc8:	00008067          	ret

0000000080010ccc <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore(){
    80010ccc:	fe010113          	addi	sp,sp,-32
    80010cd0:	00113c23          	sd	ra,24(sp)
    80010cd4:	00813823          	sd	s0,16(sp)
    80010cd8:	00913423          	sd	s1,8(sp)
    80010cdc:	02010413          	addi	s0,sp,32
    80010ce0:	00050493          	mv	s1,a0
};
    80010ce4:	00000097          	auipc	ra,0x0
    80010ce8:	ef8080e7          	jalr	-264(ra) # 80010bdc <_ZN9SemaphoreD1Ev>
    80010cec:	00048513          	mv	a0,s1
    80010cf0:	00000097          	auipc	ra,0x0
    80010cf4:	fb4080e7          	jalr	-76(ra) # 80010ca4 <_ZdlPv>
    80010cf8:	01813083          	ld	ra,24(sp)
    80010cfc:	01013403          	ld	s0,16(sp)
    80010d00:	00813483          	ld	s1,8(sp)
    80010d04:	02010113          	addi	sp,sp,32
    80010d08:	00008067          	ret

0000000080010d0c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80010d0c:	fe010113          	addi	sp,sp,-32
    80010d10:	00113c23          	sd	ra,24(sp)
    80010d14:	00813823          	sd	s0,16(sp)
    80010d18:	00913423          	sd	s1,8(sp)
    80010d1c:	02010413          	addi	s0,sp,32
    80010d20:	00050493          	mv	s1,a0
}
    80010d24:	00000097          	auipc	ra,0x0
    80010d28:	ef0080e7          	jalr	-272(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80010d2c:	00048513          	mv	a0,s1
    80010d30:	00000097          	auipc	ra,0x0
    80010d34:	f74080e7          	jalr	-140(ra) # 80010ca4 <_ZdlPv>
    80010d38:	01813083          	ld	ra,24(sp)
    80010d3c:	01013403          	ld	s0,16(sp)
    80010d40:	00813483          	ld	s1,8(sp)
    80010d44:	02010113          	addi	sp,sp,32
    80010d48:	00008067          	ret

0000000080010d4c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80010d4c:	ff010113          	addi	sp,sp,-16
    80010d50:	00113423          	sd	ra,8(sp)
    80010d54:	00813023          	sd	s0,0(sp)
    80010d58:	01010413          	addi	s0,sp,16
    80010d5c:	00001797          	auipc	a5,0x1
    80010d60:	5b478793          	addi	a5,a5,1460 # 80012310 <_ZTV9Semaphore+0x10>
    80010d64:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80010d68:	00850513          	addi	a0,a0,8
    80010d6c:	ffffe097          	auipc	ra,0xffffe
    80010d70:	4b0080e7          	jalr	1200(ra) # 8000f21c <_Z8sem_openPP10_semaphorej>
}
    80010d74:	00813083          	ld	ra,8(sp)
    80010d78:	00013403          	ld	s0,0(sp)
    80010d7c:	01010113          	addi	sp,sp,16
    80010d80:	00008067          	ret

0000000080010d84 <_ZN9Semaphore4waitEv>:
int Semaphore::wait(){
    80010d84:	ff010113          	addi	sp,sp,-16
    80010d88:	00113423          	sd	ra,8(sp)
    80010d8c:	00813023          	sd	s0,0(sp)
    80010d90:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80010d94:	00853503          	ld	a0,8(a0)
    80010d98:	ffffe097          	auipc	ra,0xffffe
    80010d9c:	4e8080e7          	jalr	1256(ra) # 8000f280 <_Z8sem_waitP10_semaphore>
}
    80010da0:	00813083          	ld	ra,8(sp)
    80010da4:	00013403          	ld	s0,0(sp)
    80010da8:	01010113          	addi	sp,sp,16
    80010dac:	00008067          	ret

0000000080010db0 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80010db0:	ff010113          	addi	sp,sp,-16
    80010db4:	00113423          	sd	ra,8(sp)
    80010db8:	00813023          	sd	s0,0(sp)
    80010dbc:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80010dc0:	00853503          	ld	a0,8(a0)
    80010dc4:	ffffe097          	auipc	ra,0xffffe
    80010dc8:	4e8080e7          	jalr	1256(ra) # 8000f2ac <_Z10sem_signalP10_semaphore>
}
    80010dcc:	00813083          	ld	ra,8(sp)
    80010dd0:	00013403          	ld	s0,0(sp)
    80010dd4:	01010113          	addi	sp,sp,16
    80010dd8:	00008067          	ret

0000000080010ddc <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void *arg) {
    80010ddc:	fe010113          	addi	sp,sp,-32
    80010de0:	00113c23          	sd	ra,24(sp)
    80010de4:	00813823          	sd	s0,16(sp)
    80010de8:	00913423          	sd	s1,8(sp)
    80010dec:	02010413          	addi	s0,sp,32
    80010df0:	00050493          	mv	s1,a0
    80010df4:	00001797          	auipc	a5,0x1
    80010df8:	53c78793          	addi	a5,a5,1340 # 80012330 <_ZTV6Thread+0x10>
    80010dfc:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, body, arg);
    80010e00:	00850513          	addi	a0,a0,8
    80010e04:	ffffe097          	auipc	ra,0xffffe
    80010e08:	34c080e7          	jalr	844(ra) # 8000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80010e0c:	fff00793          	li	a5,-1
    80010e10:	00f50c63          	beq	a0,a5,80010e28 <_ZN6ThreadC1EPFvPvES0_+0x4c>
}
    80010e14:	01813083          	ld	ra,24(sp)
    80010e18:	01013403          	ld	s0,16(sp)
    80010e1c:	00813483          	ld	s1,8(sp)
    80010e20:	02010113          	addi	sp,sp,32
    80010e24:	00008067          	ret
        myHandle = nullptr;
    80010e28:	0004b423          	sd	zero,8(s1)
}
    80010e2c:	fe9ff06f          	j	80010e14 <_ZN6ThreadC1EPFvPvES0_+0x38>

0000000080010e30 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80010e30:	fe010113          	addi	sp,sp,-32
    80010e34:	00113c23          	sd	ra,24(sp)
    80010e38:	00813823          	sd	s0,16(sp)
    80010e3c:	00913423          	sd	s1,8(sp)
    80010e40:	02010413          	addi	s0,sp,32
    80010e44:	00050493          	mv	s1,a0
    80010e48:	00001797          	auipc	a5,0x1
    80010e4c:	4e878793          	addi	a5,a5,1256 # 80012330 <_ZTV6Thread+0x10>
    80010e50:	00f53023          	sd	a5,0(a0)
    int status = thread_attach_body(&myHandle, &Thread::wrapper, this);
    80010e54:	00050613          	mv	a2,a0
    80010e58:	00000597          	auipc	a1,0x0
    80010e5c:	d5858593          	addi	a1,a1,-680 # 80010bb0 <_ZN6Thread7wrapperEPv>
    80010e60:	00850513          	addi	a0,a0,8
    80010e64:	ffffe097          	auipc	ra,0xffffe
    80010e68:	2ec080e7          	jalr	748(ra) # 8000f150 <_Z18thread_attach_bodyPP7_threadPFvPvES2_>
    if(status == -1)
    80010e6c:	fff00793          	li	a5,-1
    80010e70:	00f50c63          	beq	a0,a5,80010e88 <_ZN6ThreadC1Ev+0x58>
}
    80010e74:	01813083          	ld	ra,24(sp)
    80010e78:	01013403          	ld	s0,16(sp)
    80010e7c:	00813483          	ld	s1,8(sp)
    80010e80:	02010113          	addi	sp,sp,32
    80010e84:	00008067          	ret
        myHandle = nullptr;
    80010e88:	0004b423          	sd	zero,8(s1)
}
    80010e8c:	fe9ff06f          	j	80010e74 <_ZN6ThreadC1Ev+0x44>

0000000080010e90 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80010e90:	ff010113          	addi	sp,sp,-16
    80010e94:	00113423          	sd	ra,8(sp)
    80010e98:	00813023          	sd	s0,0(sp)
    80010e9c:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80010ea0:	ffffe097          	auipc	ra,0xffffe
    80010ea4:	438080e7          	jalr	1080(ra) # 8000f2d8 <_Z10time_sleepm>
}
    80010ea8:	00813083          	ld	ra,8(sp)
    80010eac:	00013403          	ld	s0,0(sp)
    80010eb0:	01010113          	addi	sp,sp,16
    80010eb4:	00008067          	ret

0000000080010eb8 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}

void PeriodicThread::wrapper(void *arg) {
    80010eb8:	fe010113          	addi	sp,sp,-32
    80010ebc:	00113c23          	sd	ra,24(sp)
    80010ec0:	00813823          	sd	s0,16(sp)
    80010ec4:	00913423          	sd	s1,8(sp)
    80010ec8:	01213023          	sd	s2,0(sp)
    80010ecc:	02010413          	addi	s0,sp,32
    PeriodicThread *pt =(PeriodicThread*) ((Args*)arg)->pt;
    80010ed0:	00053483          	ld	s1,0(a0)
    uint64 time = ((Args*)arg)->time;
    80010ed4:	00853903          	ld	s2,8(a0)

    while(true){
        pt->periodicActivation();
    80010ed8:	0004b783          	ld	a5,0(s1)
    80010edc:	0187b783          	ld	a5,24(a5)
    80010ee0:	00048513          	mv	a0,s1
    80010ee4:	000780e7          	jalr	a5
        pt->sleep(time);
    80010ee8:	00090513          	mv	a0,s2
    80010eec:	00000097          	auipc	ra,0x0
    80010ef0:	fa4080e7          	jalr	-92(ra) # 80010e90 <_ZN6Thread5sleepEm>
    while(true){
    80010ef4:	fe5ff06f          	j	80010ed8 <_ZN14PeriodicThread7wrapperEPv+0x20>

0000000080010ef8 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80010ef8:	ff010113          	addi	sp,sp,-16
    80010efc:	00113423          	sd	ra,8(sp)
    80010f00:	00813023          	sd	s0,0(sp)
    80010f04:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80010f08:	ffffe097          	auipc	ra,0xffffe
    80010f0c:	228080e7          	jalr	552(ra) # 8000f130 <_Z15thread_dispatchv>
}
    80010f10:	00813083          	ld	ra,8(sp)
    80010f14:	00013403          	ld	s0,0(sp)
    80010f18:	01010113          	addi	sp,sp,16
    80010f1c:	00008067          	ret

0000000080010f20 <_ZN6Thread5startEv>:
int Thread::start() {
    80010f20:	ff010113          	addi	sp,sp,-16
    80010f24:	00113423          	sd	ra,8(sp)
    80010f28:	00813023          	sd	s0,0(sp)
    80010f2c:	01010413          	addi	s0,sp,16
    return thread_start(myHandle);
    80010f30:	00853503          	ld	a0,8(a0)
    80010f34:	ffffe097          	auipc	ra,0xffffe
    80010f38:	2b0080e7          	jalr	688(ra) # 8000f1e4 <_Z12thread_startP7_thread>
}
    80010f3c:	00813083          	ld	ra,8(sp)
    80010f40:	00013403          	ld	s0,0(sp)
    80010f44:	01010113          	addi	sp,sp,16
    80010f48:	00008067          	ret

0000000080010f4c <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80010f4c:	fe010113          	addi	sp,sp,-32
    80010f50:	00113c23          	sd	ra,24(sp)
    80010f54:	00813823          	sd	s0,16(sp)
    80010f58:	00913423          	sd	s1,8(sp)
    80010f5c:	01213023          	sd	s2,0(sp)
    80010f60:	02010413          	addi	s0,sp,32
    80010f64:	00050493          	mv	s1,a0
    80010f68:	00058913          	mv	s2,a1
    80010f6c:	01000513          	li	a0,16
    80010f70:	00000097          	auipc	ra,0x0
    80010f74:	ce4080e7          	jalr	-796(ra) # 80010c54 <_Znwm>
    80010f78:	00050613          	mv	a2,a0
    80010f7c:	00050663          	beqz	a0,80010f88 <_ZN14PeriodicThreadC1Em+0x3c>
    Args(void *p, uint64 t) : pt(p), time(t){}
    80010f80:	00953023          	sd	s1,0(a0)
    80010f84:	01253423          	sd	s2,8(a0)
PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapper, new Args((void*)this, period)){}
    80010f88:	00000597          	auipc	a1,0x0
    80010f8c:	f3058593          	addi	a1,a1,-208 # 80010eb8 <_ZN14PeriodicThread7wrapperEPv>
    80010f90:	00048513          	mv	a0,s1
    80010f94:	00000097          	auipc	ra,0x0
    80010f98:	e48080e7          	jalr	-440(ra) # 80010ddc <_ZN6ThreadC1EPFvPvES0_>
    80010f9c:	00001797          	auipc	a5,0x1
    80010fa0:	34478793          	addi	a5,a5,836 # 800122e0 <_ZTV14PeriodicThread+0x10>
    80010fa4:	00f4b023          	sd	a5,0(s1)
    80010fa8:	01813083          	ld	ra,24(sp)
    80010fac:	01013403          	ld	s0,16(sp)
    80010fb0:	00813483          	ld	s1,8(sp)
    80010fb4:	00013903          	ld	s2,0(sp)
    80010fb8:	02010113          	addi	sp,sp,32
    80010fbc:	00008067          	ret

0000000080010fc0 <_ZN7Console4getcEv>:
    }
}

char Console::getc() {
    80010fc0:	ff010113          	addi	sp,sp,-16
    80010fc4:	00113423          	sd	ra,8(sp)
    80010fc8:	00813023          	sd	s0,0(sp)
    80010fcc:	01010413          	addi	s0,sp,16
    return ::getc();
    80010fd0:	ffffe097          	auipc	ra,0xffffe
    80010fd4:	334080e7          	jalr	820(ra) # 8000f304 <_Z4getcv>
}
    80010fd8:	00813083          	ld	ra,8(sp)
    80010fdc:	00013403          	ld	s0,0(sp)
    80010fe0:	01010113          	addi	sp,sp,16
    80010fe4:	00008067          	ret

0000000080010fe8 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80010fe8:	ff010113          	addi	sp,sp,-16
    80010fec:	00113423          	sd	ra,8(sp)
    80010ff0:	00813023          	sd	s0,0(sp)
    80010ff4:	01010413          	addi	s0,sp,16
    ::putc(c);
    80010ff8:	ffffe097          	auipc	ra,0xffffe
    80010ffc:	334080e7          	jalr	820(ra) # 8000f32c <_Z4putcc>
}
    80011000:	00813083          	ld	ra,8(sp)
    80011004:	00013403          	ld	s0,0(sp)
    80011008:	01010113          	addi	sp,sp,16
    8001100c:	00008067          	ret

0000000080011010 <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t time);

protected:
    Thread();
    virtual void run(){}
    80011010:	ff010113          	addi	sp,sp,-16
    80011014:	00813423          	sd	s0,8(sp)
    80011018:	01010413          	addi	s0,sp,16
    8001101c:	00813403          	ld	s0,8(sp)
    80011020:	01010113          	addi	sp,sp,16
    80011024:	00008067          	ret

0000000080011028 <_ZN14PeriodicThread18periodicActivationEv>:

class PeriodicThread : public Thread{
    static void wrapper(void *arg);
protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation(){}
    80011028:	ff010113          	addi	sp,sp,-16
    8001102c:	00813423          	sd	s0,8(sp)
    80011030:	01010413          	addi	s0,sp,16
    80011034:	00813403          	ld	s0,8(sp)
    80011038:	01010113          	addi	sp,sp,16
    8001103c:	00008067          	ret

0000000080011040 <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    80011040:	ff010113          	addi	sp,sp,-16
    80011044:	00113423          	sd	ra,8(sp)
    80011048:	00813023          	sd	s0,0(sp)
    8001104c:	01010413          	addi	s0,sp,16
    80011050:	00001797          	auipc	a5,0x1
    80011054:	29078793          	addi	a5,a5,656 # 800122e0 <_ZTV14PeriodicThread+0x10>
    80011058:	00f53023          	sd	a5,0(a0)
    8001105c:	00000097          	auipc	ra,0x0
    80011060:	bb8080e7          	jalr	-1096(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80011064:	00813083          	ld	ra,8(sp)
    80011068:	00013403          	ld	s0,0(sp)
    8001106c:	01010113          	addi	sp,sp,16
    80011070:	00008067          	ret

0000000080011074 <_ZN14PeriodicThreadD0Ev>:
    80011074:	fe010113          	addi	sp,sp,-32
    80011078:	00113c23          	sd	ra,24(sp)
    8001107c:	00813823          	sd	s0,16(sp)
    80011080:	00913423          	sd	s1,8(sp)
    80011084:	02010413          	addi	s0,sp,32
    80011088:	00050493          	mv	s1,a0
    8001108c:	00001797          	auipc	a5,0x1
    80011090:	25478793          	addi	a5,a5,596 # 800122e0 <_ZTV14PeriodicThread+0x10>
    80011094:	00f53023          	sd	a5,0(a0)
    80011098:	00000097          	auipc	ra,0x0
    8001109c:	b7c080e7          	jalr	-1156(ra) # 80010c14 <_ZN6ThreadD1Ev>
    800110a0:	00048513          	mv	a0,s1
    800110a4:	00000097          	auipc	ra,0x0
    800110a8:	c00080e7          	jalr	-1024(ra) # 80010ca4 <_ZdlPv>
    800110ac:	01813083          	ld	ra,24(sp)
    800110b0:	01013403          	ld	s0,16(sp)
    800110b4:	00813483          	ld	s1,8(sp)
    800110b8:	02010113          	addi	sp,sp,32
    800110bc:	00008067          	ret

00000000800110c0 <_Z8testUserv>:
    long id;
    bool finished;
};


void testUser() {
    800110c0:	fc010113          	addi	sp,sp,-64
    800110c4:	02113c23          	sd	ra,56(sp)
    800110c8:	02813823          	sd	s0,48(sp)
    800110cc:	02913423          	sd	s1,40(sp)
    800110d0:	04010413          	addi	s0,sp,64
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    800110d4:	fc040493          	addi	s1,s0,-64
    800110d8:	00048513          	mv	a0,s1
    800110dc:	00000097          	auipc	ra,0x0
    800110e0:	d54080e7          	jalr	-684(ra) # 80010e30 <_ZN6ThreadC1Ev>
    800110e4:	00001797          	auipc	a5,0x1
    800110e8:	27478793          	addi	a5,a5,628 # 80012358 <_ZTV10ForkThread+0x10>
    800110ec:	fcf43023          	sd	a5,-64(s0)
    800110f0:	00100793          	li	a5,1
    800110f4:	fcf43823          	sd	a5,-48(s0)
    800110f8:	fc040c23          	sb	zero,-40(s0)
    ForkThread thread(1);

    thread.start();
    800110fc:	00048513          	mv	a0,s1
    80011100:	00000097          	auipc	ra,0x0
    80011104:	e20080e7          	jalr	-480(ra) # 80010f20 <_ZN6Thread5startEv>
        return finished;
    80011108:	fd844783          	lbu	a5,-40(s0)

    while (!thread.isFinished()) {
    8001110c:	00079863          	bnez	a5,8001111c <_Z8testUserv+0x5c>
        thread_dispatch();
    80011110:	ffffe097          	auipc	ra,0xffffe
    80011114:	020080e7          	jalr	32(ra) # 8000f130 <_Z15thread_dispatchv>
    80011118:	ff1ff06f          	j	80011108 <_Z8testUserv+0x48>
    }

//    ConsoleUtil::printString("User main finished\n");
    printString("User main finished\n");
    8001111c:	00001517          	auipc	a0,0x1
    80011120:	10c50513          	addi	a0,a0,268 # 80012228 <userDataStart+0x228>
    80011124:	fffff097          	auipc	ra,0xfffff
    80011128:	7e0080e7          	jalr	2016(ra) # 80010904 <_Z11printStringPKc>
class ForkThread : public Thread {
    8001112c:	00001797          	auipc	a5,0x1
    80011130:	22c78793          	addi	a5,a5,556 # 80012358 <_ZTV10ForkThread+0x10>
    80011134:	fcf43023          	sd	a5,-64(s0)
    80011138:	fc040513          	addi	a0,s0,-64
    8001113c:	00000097          	auipc	ra,0x0
    80011140:	ad8080e7          	jalr	-1320(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80011144:	03813083          	ld	ra,56(sp)
    80011148:	03013403          	ld	s0,48(sp)
    8001114c:	02813483          	ld	s1,40(sp)
    80011150:	04010113          	addi	sp,sp,64
    80011154:	00008067          	ret
    80011158:	00050493          	mv	s1,a0
class ForkThread : public Thread {
    8001115c:	00001797          	auipc	a5,0x1
    80011160:	1fc78793          	addi	a5,a5,508 # 80012358 <_ZTV10ForkThread+0x10>
    80011164:	fcf43023          	sd	a5,-64(s0)
    80011168:	fc040513          	addi	a0,s0,-64
    8001116c:	00000097          	auipc	ra,0x0
    80011170:	aa8080e7          	jalr	-1368(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80011174:	00048513          	mv	a0,s1
    80011178:	ffffc097          	auipc	ra,0xffffc
    8001117c:	d80080e7          	jalr	-640(ra) # 8000cef8 <_Unwind_Resume>

0000000080011180 <_ZN10TCBWrapper7tcbWrapEPFvPvES0_>:
#include "../../h/syscall_c.h"
#include "../../src/user/tests/testUser.hpp"
#include "../../src/user/tests/userMain.hpp"

void TCBWrapper::tcbWrap(void (*body)(void*), void* args)
{
    80011180:	ff010113          	addi	sp,sp,-16
    80011184:	00113423          	sd	ra,8(sp)
    80011188:	00813023          	sd	s0,0(sp)
    8001118c:	01010413          	addi	s0,sp,16
    80011190:	00050793          	mv	a5,a0
    body(args);
    80011194:	00058513          	mv	a0,a1
    80011198:	000780e7          	jalr	a5
    thread_exit();
    8001119c:	ffffe097          	auipc	ra,0xffffe
    800111a0:	f6c080e7          	jalr	-148(ra) # 8000f108 <_Z11thread_exitv>
}
    800111a4:	00813083          	ld	ra,8(sp)
    800111a8:	00013403          	ld	s0,0(sp)
    800111ac:	01010113          	addi	sp,sp,16
    800111b0:	00008067          	ret

00000000800111b4 <_ZN10TCBWrapper15userMainWrapperEPv>:

void TCBWrapper::userMainWrapper(void* args) {
    800111b4:	ff010113          	addi	sp,sp,-16
    800111b8:	00113423          	sd	ra,8(sp)
    800111bc:	00813023          	sd	s0,0(sp)
    800111c0:	01010413          	addi	s0,sp,16
    userMain();
    800111c4:	fffff097          	auipc	ra,0xfffff
    800111c8:	090080e7          	jalr	144(ra) # 80010254 <_Z8userMainv>
//    testUser();
}
    800111cc:	00813083          	ld	ra,8(sp)
    800111d0:	00013403          	ld	s0,0(sp)
    800111d4:	01010113          	addi	sp,sp,16
    800111d8:	00008067          	ret

00000000800111dc <_ZN10ForkThread3runEv>:
    virtual void run() {
    800111dc:	fc010113          	addi	sp,sp,-64
    800111e0:	02113c23          	sd	ra,56(sp)
    800111e4:	02813823          	sd	s0,48(sp)
    800111e8:	02913423          	sd	s1,40(sp)
    800111ec:	03213023          	sd	s2,32(sp)
    800111f0:	01313c23          	sd	s3,24(sp)
    800111f4:	01413823          	sd	s4,16(sp)
    800111f8:	01513423          	sd	s5,8(sp)
    800111fc:	01613023          	sd	s6,0(sp)
    80011200:	04010413          	addi	s0,sp,64
    80011204:	00050a13          	mv	s4,a0
        printString("Started thread id: ");
    80011208:	00001517          	auipc	a0,0x1
    8001120c:	ff050513          	addi	a0,a0,-16 # 800121f8 <userDataStart+0x1f8>
    80011210:	fffff097          	auipc	ra,0xfffff
    80011214:	6f4080e7          	jalr	1780(ra) # 80010904 <_Z11printStringPKc>
        printInt(id,10);
    80011218:	00000613          	li	a2,0
    8001121c:	00a00593          	li	a1,10
    80011220:	010a2503          	lw	a0,16(s4)
    80011224:	00000097          	auipc	ra,0x0
    80011228:	878080e7          	jalr	-1928(ra) # 80010a9c <_Z8printIntiii>
        printString("\n");
    8001122c:	00001517          	auipc	a0,0x1
    80011230:	f1c50513          	addi	a0,a0,-228 # 80012148 <userDataStart+0x148>
    80011234:	fffff097          	auipc	ra,0xfffff
    80011238:	6d0080e7          	jalr	1744(ra) # 80010904 <_Z11printStringPKc>
        ForkThread* thread = new ForkThread(id + 1);
    8001123c:	02000513          	li	a0,32
    80011240:	00000097          	auipc	ra,0x0
    80011244:	a14080e7          	jalr	-1516(ra) # 80010c54 <_Znwm>
    80011248:	00050993          	mv	s3,a0
    8001124c:	02050463          	beqz	a0,80011274 <_ZN10ForkThread3runEv+0x98>
    80011250:	010a3483          	ld	s1,16(s4)
    80011254:	00148493          	addi	s1,s1,1
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    80011258:	00000097          	auipc	ra,0x0
    8001125c:	bd8080e7          	jalr	-1064(ra) # 80010e30 <_ZN6ThreadC1Ev>
    80011260:	00001797          	auipc	a5,0x1
    80011264:	0f878793          	addi	a5,a5,248 # 80012358 <_ZTV10ForkThread+0x10>
    80011268:	00f9b023          	sd	a5,0(s3)
    8001126c:	0099b823          	sd	s1,16(s3)
    80011270:	00098c23          	sb	zero,24(s3)
        ForkThread** threads = (ForkThread** ) mem_alloc(sizeof(ForkThread*) * id);
    80011274:	010a3503          	ld	a0,16(s4)
    80011278:	00351513          	slli	a0,a0,0x3
    8001127c:	ffffe097          	auipc	ra,0xffffe
    80011280:	da4080e7          	jalr	-604(ra) # 8000f020 <_Z9mem_allocm>
    80011284:	00050a93          	mv	s5,a0
        if (threads != nullptr) {
    80011288:	10050863          	beqz	a0,80011398 <_ZN10ForkThread3runEv+0x1bc>
            for (long i = 0; i < id; i++) {
    8001128c:	00000913          	li	s2,0
    80011290:	0140006f          	j	800112a4 <_ZN10ForkThread3runEv+0xc8>
                threads[i] = new ForkThread(id);
    80011294:	00391793          	slli	a5,s2,0x3
    80011298:	00fa87b3          	add	a5,s5,a5
    8001129c:	0097b023          	sd	s1,0(a5)
            for (long i = 0; i < id; i++) {
    800112a0:	00190913          	addi	s2,s2,1
    800112a4:	010a3783          	ld	a5,16(s4)
    800112a8:	02f95e63          	bge	s2,a5,800112e4 <_ZN10ForkThread3runEv+0x108>
                threads[i] = new ForkThread(id);
    800112ac:	02000513          	li	a0,32
    800112b0:	00000097          	auipc	ra,0x0
    800112b4:	9a4080e7          	jalr	-1628(ra) # 80010c54 <_Znwm>
    800112b8:	00050493          	mv	s1,a0
    800112bc:	fc050ce3          	beqz	a0,80011294 <_ZN10ForkThread3runEv+0xb8>
    800112c0:	010a3b03          	ld	s6,16(s4)
    ForkThread(long _id) noexcept : Thread(), id(_id), finished(false) {}
    800112c4:	00000097          	auipc	ra,0x0
    800112c8:	b6c080e7          	jalr	-1172(ra) # 80010e30 <_ZN6ThreadC1Ev>
    800112cc:	00001797          	auipc	a5,0x1
    800112d0:	08c78793          	addi	a5,a5,140 # 80012358 <_ZTV10ForkThread+0x10>
    800112d4:	00f4b023          	sd	a5,0(s1)
    800112d8:	0164b823          	sd	s6,16(s1)
    800112dc:	00048c23          	sb	zero,24(s1)
    800112e0:	fb5ff06f          	j	80011294 <_ZN10ForkThread3runEv+0xb8>
            if (thread != nullptr) {
    800112e4:	06098a63          	beqz	s3,80011358 <_ZN10ForkThread3runEv+0x17c>
                if (thread->start() == 0) {
    800112e8:	00098513          	mv	a0,s3
    800112ec:	00000097          	auipc	ra,0x0
    800112f0:	c34080e7          	jalr	-972(ra) # 80010f20 <_ZN6Thread5startEv>
    800112f4:	00050913          	mv	s2,a0
    800112f8:	04051863          	bnez	a0,80011348 <_ZN10ForkThread3runEv+0x16c>
                    for (int i = 0; i < 5000; i++) {
    800112fc:	00050493          	mv	s1,a0
    80011300:	0100006f          	j	80011310 <_ZN10ForkThread3runEv+0x134>
                        thread_dispatch();
    80011304:	ffffe097          	auipc	ra,0xffffe
    80011308:	e2c080e7          	jalr	-468(ra) # 8000f130 <_Z15thread_dispatchv>
                    for (int i = 0; i < 5000; i++) {
    8001130c:	0014849b          	addiw	s1,s1,1
    80011310:	000017b7          	lui	a5,0x1
    80011314:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80011318:	0097ce63          	blt	a5,s1,80011334 <_ZN10ForkThread3runEv+0x158>
                        for (int j = 0; j < 5000; j++) {
    8001131c:	00090713          	mv	a4,s2
    80011320:	000017b7          	lui	a5,0x1
    80011324:	38778793          	addi	a5,a5,903 # 1387 <_entry-0x7fffec79>
    80011328:	fce7cee3          	blt	a5,a4,80011304 <_ZN10ForkThread3runEv+0x128>
    8001132c:	0017071b          	addiw	a4,a4,1
    80011330:	ff1ff06f          	j	80011320 <_ZN10ForkThread3runEv+0x144>
        return finished;
    80011334:	0189c783          	lbu	a5,24(s3)
                    while (!thread->isFinished()) {
    80011338:	00079863          	bnez	a5,80011348 <_ZN10ForkThread3runEv+0x16c>
                        thread_dispatch();
    8001133c:	ffffe097          	auipc	ra,0xffffe
    80011340:	df4080e7          	jalr	-524(ra) # 8000f130 <_Z15thread_dispatchv>
                    while (!thread->isFinished()) {
    80011344:	ff1ff06f          	j	80011334 <_ZN10ForkThread3runEv+0x158>
                delete thread;
    80011348:	0009b783          	ld	a5,0(s3)
    8001134c:	0087b783          	ld	a5,8(a5)
    80011350:	00098513          	mv	a0,s3
    80011354:	000780e7          	jalr	a5
                        for (int j = 0; j < 5000; j++) {
    80011358:	00000493          	li	s1,0
    8001135c:	0080006f          	j	80011364 <_ZN10ForkThread3runEv+0x188>
            for (long i = 0; i < id; i++) {
    80011360:	00148493          	addi	s1,s1,1
    80011364:	010a3783          	ld	a5,16(s4)
    80011368:	02f4d263          	bge	s1,a5,8001138c <_ZN10ForkThread3runEv+0x1b0>
                delete threads[i];
    8001136c:	00349793          	slli	a5,s1,0x3
    80011370:	00fa87b3          	add	a5,s5,a5
    80011374:	0007b503          	ld	a0,0(a5)
    80011378:	fe0504e3          	beqz	a0,80011360 <_ZN10ForkThread3runEv+0x184>
    8001137c:	00053783          	ld	a5,0(a0)
    80011380:	0087b783          	ld	a5,8(a5)
    80011384:	000780e7          	jalr	a5
    80011388:	fd9ff06f          	j	80011360 <_ZN10ForkThread3runEv+0x184>
            mem_free(threads);
    8001138c:	000a8513          	mv	a0,s5
    80011390:	ffffe097          	auipc	ra,0xffffe
    80011394:	cc0080e7          	jalr	-832(ra) # 8000f050 <_Z8mem_freePv>
        printString("Finished thread id: ");
    80011398:	00001517          	auipc	a0,0x1
    8001139c:	e7850513          	addi	a0,a0,-392 # 80012210 <userDataStart+0x210>
    800113a0:	fffff097          	auipc	ra,0xfffff
    800113a4:	564080e7          	jalr	1380(ra) # 80010904 <_Z11printStringPKc>
        printInt(id,10);
    800113a8:	00000613          	li	a2,0
    800113ac:	00a00593          	li	a1,10
    800113b0:	010a2503          	lw	a0,16(s4)
    800113b4:	fffff097          	auipc	ra,0xfffff
    800113b8:	6e8080e7          	jalr	1768(ra) # 80010a9c <_Z8printIntiii>
        printString("\n");
    800113bc:	00001517          	auipc	a0,0x1
    800113c0:	d8c50513          	addi	a0,a0,-628 # 80012148 <userDataStart+0x148>
    800113c4:	fffff097          	auipc	ra,0xfffff
    800113c8:	540080e7          	jalr	1344(ra) # 80010904 <_Z11printStringPKc>
        finished = true;
    800113cc:	00100793          	li	a5,1
    800113d0:	00fa0c23          	sb	a5,24(s4)
    }
    800113d4:	03813083          	ld	ra,56(sp)
    800113d8:	03013403          	ld	s0,48(sp)
    800113dc:	02813483          	ld	s1,40(sp)
    800113e0:	02013903          	ld	s2,32(sp)
    800113e4:	01813983          	ld	s3,24(sp)
    800113e8:	01013a03          	ld	s4,16(sp)
    800113ec:	00813a83          	ld	s5,8(sp)
    800113f0:	00013b03          	ld	s6,0(sp)
    800113f4:	04010113          	addi	sp,sp,64
    800113f8:	00008067          	ret

00000000800113fc <_ZN10ForkThreadD1Ev>:
class ForkThread : public Thread {
    800113fc:	ff010113          	addi	sp,sp,-16
    80011400:	00113423          	sd	ra,8(sp)
    80011404:	00813023          	sd	s0,0(sp)
    80011408:	01010413          	addi	s0,sp,16
    8001140c:	00001797          	auipc	a5,0x1
    80011410:	f4c78793          	addi	a5,a5,-180 # 80012358 <_ZTV10ForkThread+0x10>
    80011414:	00f53023          	sd	a5,0(a0)
    80011418:	fffff097          	auipc	ra,0xfffff
    8001141c:	7fc080e7          	jalr	2044(ra) # 80010c14 <_ZN6ThreadD1Ev>
    80011420:	00813083          	ld	ra,8(sp)
    80011424:	00013403          	ld	s0,0(sp)
    80011428:	01010113          	addi	sp,sp,16
    8001142c:	00008067          	ret

0000000080011430 <_ZN10ForkThreadD0Ev>:
    80011430:	fe010113          	addi	sp,sp,-32
    80011434:	00113c23          	sd	ra,24(sp)
    80011438:	00813823          	sd	s0,16(sp)
    8001143c:	00913423          	sd	s1,8(sp)
    80011440:	02010413          	addi	s0,sp,32
    80011444:	00050493          	mv	s1,a0
    80011448:	00001797          	auipc	a5,0x1
    8001144c:	f1078793          	addi	a5,a5,-240 # 80012358 <_ZTV10ForkThread+0x10>
    80011450:	00f53023          	sd	a5,0(a0)
    80011454:	fffff097          	auipc	ra,0xfffff
    80011458:	7c0080e7          	jalr	1984(ra) # 80010c14 <_ZN6ThreadD1Ev>
    8001145c:	00048513          	mv	a0,s1
    80011460:	00000097          	auipc	ra,0x0
    80011464:	844080e7          	jalr	-1980(ra) # 80010ca4 <_ZdlPv>
    80011468:	01813083          	ld	ra,24(sp)
    8001146c:	01013403          	ld	s0,16(sp)
    80011470:	00813483          	ld	s1,8(sp)
    80011474:	02010113          	addi	sp,sp,32
    80011478:	00008067          	ret
	...

0000000080012000 <userDataStart>:
    80012000:	7542                	ld	a0,48(sp)
    80012002:	6666                	ld	a2,88(sp)
    80012004:	7265                	lui	tp,0xffff9
    80012006:	6420                	ld	s0,72(s0)
    80012008:	6c65                	lui	s8,0x19
    8001200a:	7465                	lui	s0,0xffff9
    8001200c:	6465                	lui	s0,0x19
    8001200e:	0a21                	addi	s4,s4,8
	...
    80012018:	3a41                	addiw	s4,s4,-16
    8001201a:	6920                	ld	s0,80(a0)
    8001201c:	003d                	c.nop	15
    8001201e:	0000                	unimp
    80012020:	2041                	0x2041
    80012022:	6966                	ld	s2,88(sp)
    80012024:	696e                	ld	s2,216(sp)
    80012026:	64656873          	csrrsi	a6,0x646,10
    8001202a:	0a21                	addi	s4,s4,8
    8001202c:	0000                	unimp
    8001202e:	0000                	unimp
    80012030:	3a42                	fld	fs4,48(sp)
    80012032:	6920                	ld	s0,80(a0)
    80012034:	003d                	c.nop	15
    80012036:	0000                	unimp
    80012038:	2042                	fld	ft0,16(sp)
    8001203a:	6966                	ld	s2,88(sp)
    8001203c:	696e                	ld	s2,216(sp)
    8001203e:	64656873          	csrrsi	a6,0x646,10
    80012042:	0a21                	addi	s4,s4,8
    80012044:	0000                	unimp
    80012046:	0000                	unimp
    80012048:	69203a43          	fmadd.s	fs4,ft0,fs2,fa3,rup
    8001204c:	003d                	c.nop	15
    8001204e:	0000                	unimp
    80012050:	64203a43          	0x64203a43
    80012054:	7369                	lui	t1,0xffffa
    80012056:	6170                	ld	a2,192(a0)
    80012058:	6374                	ld	a3,192(a4)
    8001205a:	0a68                	addi	a0,sp,284
    8001205c:	0000                	unimp
    8001205e:	0000                	unimp
    80012060:	74203a43          	0x74203a43
    80012064:	3d31                	addiw	s10,s10,-20
    80012066:	0000                	unimp
    80012068:	66203a43          	fmadd.q	fs4,ft0,ft2,fa2,rup
    8001206c:	6269                	lui	tp,0x1a
    8001206e:	63616e6f          	jal	t3,800286a4 <end+0x146a4>
    80012072:	3d69                	addiw	s10,s10,-6
    80012074:	0000                	unimp
    80012076:	0000                	unimp
    80012078:	3a44                	fld	fs1,176(a2)
    8001207a:	6920                	ld	s0,80(a0)
    8001207c:	003d                	c.nop	15
    8001207e:	0000                	unimp
    80012080:	3a44                	fld	fs1,176(a2)
    80012082:	6420                	ld	s0,72(s0)
    80012084:	7369                	lui	t1,0xffffa
    80012086:	6170                	ld	a2,192(a0)
    80012088:	6374                	ld	a3,192(a4)
    8001208a:	0a68                	addi	a0,sp,284
    8001208c:	0000                	unimp
    8001208e:	0000                	unimp
    80012090:	3a44                	fld	fs1,176(a2)
    80012092:	6620                	ld	s0,72(a2)
    80012094:	6269                	lui	tp,0x1a
    80012096:	63616e6f          	jal	t3,800286cc <end+0x146cc>
    8001209a:	3d69                	addiw	s10,s10,-6
    8001209c:	0000                	unimp
    8001209e:	0000                	unimp
    800120a0:	2044                	fld	fs1,128(s0)
    800120a2:	6966                	ld	s2,88(sp)
    800120a4:	696e                	ld	s2,216(sp)
    800120a6:	64656873          	csrrsi	a6,0x646,10
    800120aa:	0a21                	addi	s4,s4,8
    800120ac:	0000                	unimp
    800120ae:	0000                	unimp
    800120b0:	6854                	ld	a3,144(s0)
    800120b2:	6572                	ld	a0,280(sp)
    800120b4:	6461                	lui	s0,0x18
    800120b6:	2041                	0x2041
    800120b8:	61657263          	bgeu	a0,s6,800126bc <lockPrint+0x334>
    800120bc:	6574                	ld	a3,200(a0)
    800120be:	0a64                	addi	s1,sp,284
	...
    800120c8:	6854                	ld	a3,144(s0)
    800120ca:	6572                	ld	a0,280(sp)
    800120cc:	6461                	lui	s0,0x18
    800120ce:	2042                	fld	ft0,16(sp)
    800120d0:	61657263          	bgeu	a0,s6,800126d4 <lockPrint+0x34c>
    800120d4:	6574                	ld	a3,200(a0)
    800120d6:	0a64                	addi	s1,sp,284
	...
    800120e0:	6854                	ld	a3,144(s0)
    800120e2:	6572                	ld	a0,280(sp)
    800120e4:	6461                	lui	s0,0x18
    800120e6:	72632043          	fmadd.d	ft0,ft6,ft6,fa4,rdn
    800120ea:	6165                	addi	sp,sp,112
    800120ec:	6574                	ld	a3,200(a0)
    800120ee:	0a64                	addi	s1,sp,284
	...
    800120f8:	6854                	ld	a3,144(s0)
    800120fa:	6572                	ld	a0,280(sp)
    800120fc:	6461                	lui	s0,0x18
    800120fe:	2044                	fld	fs1,128(s0)
    80012100:	61657263          	bgeu	a0,s6,80012704 <lockPrint+0x37c>
    80012104:	6574                	ld	a3,200(a0)
    80012106:	0a64                	addi	s1,sp,284
	...
    80012110:	6e55                	lui	t3,0x15
    80012112:	7365                	lui	t1,0xffff9
    80012114:	7469                	lui	s0,0xffffa
    80012116:	2065                	0x2065
    80012118:	7262                	ld	tp,56(sp)
    8001211a:	70206a6f          	jal	s4,8001881c <end+0x481c>
    8001211e:	6f72                	ld	t5,280(sp)
    80012120:	7a69                	lui	s4,0xffffa
    80012122:	6f76                	ld	t5,344(sp)
    80012124:	6a64                	ld	s1,208(a2)
    80012126:	6361                	lui	t1,0x18
    80012128:	3f61                	addiw	t5,t5,-8
    8001212a:	000a                	c.slli	zero,0x2
    8001212c:	0000                	unimp
    8001212e:	0000                	unimp
    80012130:	6e55                	lui	t3,0x15
    80012132:	7365                	lui	t1,0xffff9
    80012134:	7469                	lui	s0,0xffffa
    80012136:	2065                	0x2065
    80012138:	6576                	ld	a0,344(sp)
    8001213a:	696c                	ld	a1,208(a0)
    8001213c:	756e6963          	bltu	t3,s6,8001288e <lockPrint+0x506>
    80012140:	6220                	ld	s0,64(a2)
    80012142:	6661                	lui	a2,0x18
    80012144:	7265                	lui	tp,0xffff9
    80012146:	3f61                	addiw	t5,t5,-8
    80012148:	000a                	c.slli	zero,0x2
    8001214a:	0000                	unimp
    8001214c:	0000                	unimp
    8001214e:	0000                	unimp
    80012150:	7242                	ld	tp,48(sp)
    80012152:	70206a6f          	jal	s4,80018854 <end+0x4854>
    80012156:	6f72                	ld	t5,280(sp)
    80012158:	7a69                	lui	s4,0xffffa
    8001215a:	6f76                	ld	t5,344(sp)
    8001215c:	6a64                	ld	s1,208(a2)
    8001215e:	6361                	lui	t1,0x18
    80012160:	2061                	0x2061
    80012162:	0000                	unimp
    80012164:	0000                	unimp
    80012166:	0000                	unimp
    80012168:	6920                	ld	s0,80(a0)
    8001216a:	7620                	ld	s0,104(a2)
    8001216c:	6c65                	lui	s8,0x19
    8001216e:	6369                	lui	t1,0x1a
    80012170:	6e69                	lui	t3,0x1a
    80012172:	2061                	0x2061
    80012174:	6162                	ld	sp,24(sp)
    80012176:	6566                	ld	a0,88(sp)
    80012178:	6172                	ld	sp,280(sp)
    8001217a:	0020                	addi	s0,sp,8
    8001217c:	0000                	unimp
    8001217e:	0000                	unimp
    80012180:	0a2e                	slli	s4,s4,0xb
    80012182:	0000                	unimp
    80012184:	0000                	unimp
    80012186:	0000                	unimp
    80012188:	7242                	ld	tp,48(sp)
    8001218a:	70206a6f          	jal	s4,8001888c <end+0x488c>
    8001218e:	6f72                	ld	t5,280(sp)
    80012190:	7a69                	lui	s4,0xffffa
    80012192:	6f76                	ld	t5,344(sp)
    80012194:	6a64                	ld	s1,208(a2)
    80012196:	6361                	lui	t1,0x18
    80012198:	2061                	0x2061
    8001219a:	656e                	ld	a0,216(sp)
    8001219c:	7320                	ld	s0,96(a4)
    8001219e:	656d                	lui	a0,0x1b
    800121a0:	6220                	ld	s0,64(a2)
    800121a2:	7469                	lui	s0,0xffffa
    800121a4:	2069                	0x2069
    800121a6:	616d                	addi	sp,sp,240
    800121a8:	6a6e                	ld	s4,216(sp)
    800121aa:	2069                	0x2069
    800121ac:	7620646f          	jal	s0,8001890e <end+0x490e>
    800121b0:	6c65                	lui	s8,0x19
    800121b2:	6369                	lui	t1,0x1a
    800121b4:	6e69                	lui	t3,0x1a
    800121b6:	2065                	0x2065
    800121b8:	6162                	ld	sp,24(sp)
    800121ba:	6566                	ld	a0,88(sp)
    800121bc:	6172                	ld	sp,280(sp)
    800121be:	0a21                	addi	s4,s4,8
	...
    800121c8:	7242                	ld	tp,48(sp)
    800121ca:	70206a6f          	jal	s4,800188cc <end+0x48cc>
    800121ce:	6f72                	ld	t5,280(sp)
    800121d0:	7a69                	lui	s4,0xffffa
    800121d2:	6f76                	ld	t5,344(sp)
    800121d4:	6a64                	ld	s1,208(a2)
    800121d6:	6361                	lui	t1,0x18
    800121d8:	2061                	0x2061
    800121da:	6f6d                	lui	t5,0x1b
    800121dc:	6172                	ld	sp,280(sp)
    800121de:	6220                	ld	s0,64(a2)
    800121e0:	7469                	lui	s0,0xffffa
    800121e2:	2069                	0x2069
    800121e4:	6576                	ld	a0,344(sp)
    800121e6:	6f206963          	bltu	zero,s2,800128d8 <lockPrint+0x550>
    800121ea:	2064                	fld	fs1,192(s0)
    800121ec:	756e                	ld	a0,248(sp)
    800121ee:	616c                	ld	a1,192(a0)
    800121f0:	0a21                	addi	s4,s4,8
    800121f2:	0000                	unimp
    800121f4:	0000                	unimp
    800121f6:	0000                	unimp
    800121f8:	72617453          	0x72617453
    800121fc:	6574                	ld	a3,200(a0)
    800121fe:	2064                	fld	fs1,192(s0)
    80012200:	6874                	ld	a3,208(s0)
    80012202:	6572                	ld	a0,280(sp)
    80012204:	6461                	lui	s0,0x18
    80012206:	6920                	ld	s0,80(a0)
    80012208:	3a64                	fld	fs1,240(a2)
    8001220a:	0020                	addi	s0,sp,8
    8001220c:	0000                	unimp
    8001220e:	0000                	unimp
    80012210:	6946                	ld	s2,80(sp)
    80012212:	696e                	ld	s2,216(sp)
    80012214:	64656873          	csrrsi	a6,0x646,10
    80012218:	7420                	ld	s0,104(s0)
    8001221a:	7268                	ld	a0,224(a2)
    8001221c:	6165                	addi	sp,sp,112
    8001221e:	2064                	fld	fs1,192(s0)
    80012220:	6469                	lui	s0,0x1a
    80012222:	203a                	fld	ft0,392(sp)
    80012224:	0000                	unimp
    80012226:	0000                	unimp
    80012228:	7355                	lui	t1,0xffff5
    8001222a:	7265                	lui	tp,0xffff9
    8001222c:	6d20                	ld	s0,88(a0)
    8001222e:	6961                	lui	s2,0x18
    80012230:	206e                	fld	ft0,216(sp)
    80012232:	6966                	ld	s2,88(sp)
    80012234:	696e                	ld	s2,216(sp)
    80012236:	64656873          	csrrsi	a6,0x646,10
    8001223a:	000a                	c.slli	zero,0x2
    8001223c:	0000                	unimp
	...

0000000080012240 <_ZTVN19ConsumerProducerCPP16ProducerKeyboradE>:
	...
    80012250:	03cc 8001 0000 0000 0400 8001 0000 0000     ................
    80012260:	04cc 8001 0000 0000                         ........

0000000080012268 <_ZTVN19ConsumerProducerCPP8ProducerE>:
	...
    80012278:	044c 8001 0000 0000 0480 8001 0000 0000     L...............
    80012288:	0550 8001 0000 0000                         P.......

0000000080012290 <_ZTVN19ConsumerProducerCPP8ConsumerE>:
	...
    800122a0:	034c 8001 0000 0000 0380 8001 0000 0000     L...............
    800122b0:	027c 8001 0000 0000                         |.......

00000000800122b8 <digits>:
    800122b8:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...

00000000800122d0 <_ZTV14PeriodicThread>:
	...
    800122e0:	1040 8001 0000 0000 1074 8001 0000 0000     @.......t.......
    800122f0:	1010 8001 0000 0000 1028 8001 0000 0000     ........(.......

0000000080012300 <_ZTV9Semaphore>:
	...
    80012310:	0bdc 8001 0000 0000 0ccc 8001 0000 0000     ................

0000000080012320 <_ZTV6Thread>:
	...
    80012330:	0c14 8001 0000 0000 0d0c 8001 0000 0000     ................
    80012340:	1010 8001 0000 0000                         ........

0000000080012348 <_ZTV10ForkThread>:
	...
    80012358:	13fc 8001 0000 0000 1430 8001 0000 0000     ........0.......
    80012368:	11dc 8001 0000 0000                         ........

0000000080012370 <finishedA>:
	...

0000000080012371 <finishedB>:
    80012371:	0000                                         ...

0000000080012374 <_ZN19ConsumerProducerCPP9threadEndE>:
    80012374:	0000 0000                                   ....

0000000080012378 <finishedC>:
	...

0000000080012379 <finishedD>:
    80012379:	0000 0000 0000                               .......

0000000080012380 <_ZN19ConsumerProducerCPP10waitForAllE>:
	...

0000000080012388 <lockPrint>:
	...
    80012390:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    800123a0:	0d1b 0002 0020 0000 0018 0000 cc74 ffff     .... .......t...
    800123b0:	0030 0000 4400 100e 8844 4402 000c 0000     0....D..D..D....
    800123c0:	0c00 1002 0e44 0000 0020 0000 003c 0000     ....D... ...<...
    800123d0:	cc80 ffff 002c 0000 4400 100e 8844 4402     ....,....D..D..D
    800123e0:	000c 0000 0c00 1002 0e44 0000 0034 0000     ........D...4...
    800123f0:	0060 0000 cc88 ffff 008c 0000 4400 000e     `............D..
	...
    80012408:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    80012418:	c944 d244 d344 0e44 4400 000b 0020 0000     D.D.D.D..D.. ...
    80012428:	0098 0000 ccdc ffff 0028 0000 4400 100e     ........(....D..
    80012438:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012448:	0020 0000 00bc 0000 cce0 ffff 0020 0000      ........... ...
    80012458:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012468:	0e44 0000 0034 0000 00e0 0000 ccdc ffff     D...4...........
    80012478:	0094 0000 4400 000e 0000 0000 0000 0000     .....D..........
    80012488:	9300 440a 080c 0000 0000 0000 0c00 3002     ...D...........0
    80012498:	c944 d244 d344 0e44 4400 000b 0024 0000     D.D.D.D..D..$...
    800124a8:	0118 0000 cd38 ffff 0038 0000 4400 100e     ....8...8....D..
    800124b8:	8844 4402 000c 0000 0000 020c 4410 000e     D..D.........D..
    800124c8:	0b44 0000 0020 0000 0140 0000 cd48 ffff     D... ...@...H...
    800124d8:	0038 0000 4400 100e 8844 4402 000c 0000     8....D..D..D....
    800124e8:	0c00 1002 0e44 0000 0020 0000 0164 0000     ....D... ...d...
    800124f8:	cd5c ffff 002c 0000 4400 100e 8844 4402     \...,....D..D..D
    80012508:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    80012518:	0188 0000 cd64 ffff 002c 0000 4400 100e     ....d...,....D..
    80012528:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012538:	0020 0000 01ac 0000 cd6c ffff 002c 0000      .......l...,...
    80012548:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    80012558:	0e44 0000 0020 0000 01d0 0000 cd74 ffff     D... .......t...
    80012568:	002c 0000 4400 100e 8844 4402 000c 0000     ,....D..D..D....
    80012578:	0c00 1002 0e44 0000 0020 0000 01f4 0000     ....D... .......
    80012588:	cd7c ffff 0028 0000 4400 100e 8844 4402     |...(....D..D..D
    80012598:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    800125a8:	0218 0000 cd80 ffff 0024 0000 4400 100e     ........$....D..
    800125b8:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    800125c8:	0020 0000 023c 0000 cd80 ffff 0028 0000      ...<.......(...
    800125d8:	4400 100e 8844 4402 000c 0000 0c00 1002     .D..D..D........
    800125e8:	0e44 0000 0020 0000 0260 0000 cd84 ffff     D... ...`.......
    800125f8:	0024 0000 4400 100e 8844 4402 000c 0000     $....D..D..D....
    80012608:	0c00 1002 0e44 0000 0010 0000 0000 0000     ....D...........
    80012618:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80012628:	0018 0000 cd70 ffff 0028 0000 4400 000e     ....p...(....D..
    80012638:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012648:	0e44 0000 0000 0000 0010 0000 0000 0000     D...............
    80012658:	7a03 0052 7c01 0101 0d1b 0002 0028 0000     .zR..|......(...
    80012668:	0018 0000 cd58 ffff 0028 0000 4400 000e     ....X...(....D..
    80012678:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012688:	0e44 0000 0000 0000 0018 0000 0000 0000     D...............
    80012698:	7a03 4c50 0052 7c01 0701 0d9b ff54 1bff     .zPLR..|....T...
    800126a8:	0d1b 0002 0038 0000 0020 0000 cd38 ffff     ....8... ...8...
    800126b8:	0164 0000 9a04 ff51 44ff 000e 0000 0000     d.....Q..D......
    800126c8:	0000 0000 9300 440a 080c 0000 0000 0000     .......D........
    800126d8:	0c00 3002 c944 d244 d344 0e44 4400 000b     ...0D.D.D.D..D..
    800126e8:	0010 0000 0000 0000 7a03 0052 7c01 0101     .........zR..|..
    800126f8:	0d1b 0002 002c 0000 0018 0000 ce4c ffff     ....,.......L...
    80012708:	0090 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012718:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012728:	44d2 000e 002c 0000 0048 0000 ceac ffff     .D..,...H.......
    80012738:	008c 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012748:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    80012758:	44d2 000e 0030 0000 0078 0000 cf08 ffff     .D..0...x.......
    80012768:	0088 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012778:	4408 080c 0000 0000 0000 0c00 2002 c944     .D........... D.
    80012788:	d244 0e44 4400 000b 002c 0000 0104 0000     D.D..D..,.......
    80012798:	cf5c ffff 0100 0000 5704 ff51 44ff 000e     \........WQ..D..
    800127a8:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    800127b8:	020c 4420 44c9 000e 0010 0000 0000 0000     .. D.D..........
    800127c8:	7a03 0052 7c01 0101 0d1b 0002 002c 0000     .zR..|......,...
    800127d8:	0018 0000 d018 ffff 00cc 0000 4400 000e     .............D..
    800127e8:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    800127f8:	0000 020c 4420 44c9 44d2 000e 002c 0000     .... D.D.D..,...
    80012808:	0048 0000 d0b4 ffff 00d4 0000 4400 000e     H............D..
    80012818:	0000 0000 0000 9200 4408 080c 0200 0000     .........D......
    80012828:	0000 020c 4420 44c9 44d2 000e 0030 0000     .... D.D.D..0...
    80012838:	0078 0000 da40 ffff 00d0 0000 4400 000e     x...@........D..
	...
    80012850:	9300 440a 080c 0200 0000 0000 020c 4430     ...D..........0D
    80012860:	44c9 44d2 44d3 000e 0024 0000 00ac 0000     .D.D.D..$.......
    80012870:	dadc ffff 0034 0000 4400 000e 0000 8800     ....4....D......
    80012880:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012890:	0028 0000 00d4 0000 dae8 ffff 004c 0000     (...........L...
    800128a0:	4400 000e 0000 0000 8900 4406 080c 0000     .D.........D....
    800128b0:	0000 0c00 2002 c944 0e44 0000 0024 0000     ..... D.D...$...
    800128c0:	0100 0000 db08 ffff 0034 0000 4400 000e     ........4....D..
    800128d0:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    800128e0:	0e44 0000 0028 0000 0128 0000 db14 ffff     D...(...(.......
    800128f0:	004c 0000 4400 000e 0000 0000 8900 4406     L....D.........D
    80012900:	080c 0000 0000 0c00 2002 c944 0e44 0000     ......... D.D...
    80012910:	0024 0000 0154 0000 db34 ffff 0034 0000     $...T...4...4...
    80012920:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012930:	0c00 1002 0e44 0000 0028 0000 017c 0000     ....D...(...|...
    80012940:	db40 ffff 004c 0000 4400 000e 0000 0000     @...L....D......
    80012950:	8900 4406 080c 0000 0000 0c00 2002 c944     ...D......... D.
    80012960:	0e44 0000 0028 0000 01a8 0000 db60 ffff     D...(.......`...
    80012970:	0084 0000 4400 000e 0000 0000 8900 4406     .....D.........D
    80012980:	080c 0200 0000 0000 020c 4420 44c9 000e     .......... D.D..
    80012990:	002c 0000 01d4 0000 dbb8 ffff 0094 0000     ,...............
    800129a0:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    800129b0:	0200 0000 0000 020c 4420 44c9 44d2 000e     ........ D.D.D..
    800129c0:	0030 0000 0204 0000 cfcc ffff 0074 0000     0...........t...
    800129d0:	4400 000e 0000 0000 0000 9200 4408 000c     .D...........D..
    800129e0:	0000 0000 0000 020c 4420 44c9 44d2 000e     ........ D.D.D..
    800129f0:	0b44 0000 0030 0000 0238 0000 d00c ffff     D...0...8.......
    80012a00:	0180 0000 4400 000e 0000 0000 0000 9200     .....D..........
    80012a10:	4408 080c 0300 0054 0000 0c00 2002 c944     .D....T...... D.
    80012a20:	d244 0e44 0000 0000 0030 0000 026c 0000     D.D.....0...l...
    80012a30:	d158 ffff 0148 0000 4400 000e 0000 0000     X...H....D......
    80012a40:	0000 9200 4408 080c 0300 001c 0000 0c00     .....D..........
    80012a50:	2002 c944 d244 0e44 0000 0000 002c 0000     . D.D.D.....,...
    80012a60:	02a0 0000 d26c ffff 012c 0000 4400 000e     ....l...,....D..
    80012a70:	0000 0000 8900 4406 080c 0300 0008 0000     .......D........
    80012a80:	0c00 4002 c944 0e44 0000 0000 0018 0000     ...@D.D.........
    80012a90:	0000 0000 7a03 4c50 0052 7c01 0701 119b     .....zPLR..|....
    80012aa0:	ff50 1bff 0d1b 0002 0054 0000 0020 0000     P.......T... ...
    80012ab0:	d34c ffff 0458 0000 4304 ff4e 44ff 800e     L...X....CN..D..
	...
    80012ad4:	0000 1699 0c44 0008 0000 0000 020c 0180     ....D...........
    80012ae4:	c144 c844 c944 d244 d344 d444 d544 d644     D.D.D.D.D.D.D.D.
    80012af4:	d744 d844 d944 0e44 4400 000b 0024 0000     D.D.D.D..D..$...
    80012b04:	0344 0000 d74c ffff 0028 0000 4400 000e     D...L...(....D..
    80012b14:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012b24:	0e44 0000 0010 0000 0000 0000 7a03 0052     D............zR.
    80012b34:	7c01 0101 0d1b 0002 002c 0000 0018 0000     .|......,.......
    80012b44:	daa0 ffff 009c 0000 4400 000e 0000 0000     .........D......
    80012b54:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    80012b64:	4420 44c9 44d2 000e 002c 0000 0048 0000      D.D.D..,...H...
    80012b74:	db0c ffff 0090 0000 4400 000e 0000 0000     .........D......
    80012b84:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    80012b94:	4420 44c9 44d2 000e 002c 0000 0078 0000      D.D.D..,...x...
    80012ba4:	db6c ffff 008c 0000 4400 000e 0000 0000     l........D......
    80012bb4:	0000 9200 4408 080c 0200 0000 0000 020c     .....D..........
    80012bc4:	4420 44c9 44d2 000e 0030 0000 00a8 0000      D.D.D..0.......
    80012bd4:	dbc8 ffff 0088 0000 4400 000e 0000 0000     .........D......
    80012be4:	0000 9200 4408 080c 0000 0000 0000 0c00     .....D..........
    80012bf4:	2002 c944 d244 0e44 4400 000b 0018 0000     . D.D.D..D......
    80012c04:	0000 0000 7a03 4c50 0052 7c01 0701 9d9b     .....zPLR..|....
    80012c14:	ff4e 1bff 0d1b 0002 0030 0000 0020 0000     N.......0... ...
    80012c24:	dc00 ffff 00e0 0000 a404 ff4d 44ff 000e     ..........M..D..
    80012c34:	0000 0000 8900 4406 080c 0200 0000 0000     .......D........
    80012c44:	020c 4420 44c9 000e 0000 0000 0010 0000     .. D.D..........
    80012c54:	0000 0000 7a03 0052 7c01 0101 0d1b 0002     .....zR..|......
    80012c64:	0028 0000 0018 0000 dc98 ffff 007c 0000     (...........|...
    80012c74:	4400 000e 0000 0000 8900 4406 080c 0200     .D.........D....
    80012c84:	0000 0000 020c 4420 44c9 000e 0034 0000     ...... D.D..4...
    80012c94:	0044 0000 dce8 ffff 00cc 0000 4400 000e     D............D..
	...
    80012cac:	0000 9400 440c 080c 0200 0000 0000 020c     .....D..........
    80012cbc:	4430 44c9 44d2 44d3 44d4 000e 0020 0000     0D.D.D.D.D.. ...
    80012ccc:	007c 0000 dd7c ffff 0050 0000 4400 100e     |...|...P....D..
    80012cdc:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012cec:	0030 0000 00a0 0000 dda8 ffff 0114 0000     0...............
    80012cfc:	4400 000e 0000 0000 0000 0000 9300 440a     .D.............D
    80012d0c:	080c 0200 0000 0000 020c 4440 44c9 44d2     ..........@D.D.D
    80012d1c:	44d3 000e 0010 0000 0000 0000 7a03 0052     .D...........zR.
    80012d2c:	7c01 0101 0d1b 0002 0020 0000 0018 0000     .|...... .......
    80012d3c:	e2d4 ffff 0018 0000 4400 100e 8844 4402     .........D..D..D
    80012d4c:	000c 0000 0c00 1002 0e44 0000 0020 0000     ........D... ...
    80012d5c:	003c 0000 e2c8 ffff 0018 0000 4400 100e     <............D..
    80012d6c:	8844 4402 000c 0000 0c00 1002 0e44 0000     D..D........D...
    80012d7c:	0024 0000 0060 0000 de2c ffff 002c 0000     $...`...,...,...
    80012d8c:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012d9c:	0c00 1002 0e44 0000 0018 0000 0000 0000     ....D...........
    80012dac:	7a03 4c50 0052 7c01 0701 f99b ff4c 1bff     .zPLR..|....L...
    80012dbc:	0d1b 0002 0028 0000 0020 0000 de14 ffff     ....(... .......
    80012dcc:	0038 0000 0404 ff4c 44ff 000e 0000 8800     8.....L..D......
    80012ddc:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012dec:	0028 0000 004c 0000 de20 ffff 0040 0000     (...L... ...@...
    80012dfc:	dc04 ff4b 58ff 000e 0000 8800 4404 080c     ..K..X.......D..
    80012e0c:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80012e1c:	00fc 0000 e220 ffff 0034 0000 4400 000e     .... ...4....D..
    80012e2c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012e3c:	0e44 0000 0024 0000 0124 0000 de0c ffff     D...$...$.......
    80012e4c:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    80012e5c:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    80012e6c:	014c 0000 de0c ffff 0028 0000 4400 000e     L.......(....D..
    80012e7c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    80012e8c:	0e44 0000 0024 0000 0174 0000 de0c ffff     D...$...t.......
    80012e9c:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    80012eac:	0000 0000 0c00 1002 0e44 0000 0028 0000     ........D...(...
    80012ebc:	019c 0000 de0c ffff 0040 0000 4400 000e     ........@....D..
    80012ecc:	0000 0000 8900 4406 080c 0000 0000 0c00     .......D........
    80012edc:	2002 c944 0e44 0000 0028 0000 01c8 0000     . D.D...(.......
    80012eec:	de20 ffff 0040 0000 4400 000e 0000 0000      ...@....D......
    80012efc:	8900 4406 080c 0000 0000 0c00 2002 c944     ...D......... D.
    80012f0c:	0e44 0000 0028 0000 01f4 0000 e15c ffff     D...(.......\...
    80012f1c:	004c 0000 4400 000e 0000 0000 8900 4406     L....D.........D
    80012f2c:	080c 0000 0000 0c00 2002 c944 0e44 0000     ......... D.D...
    80012f3c:	0024 0000 0220 0000 de08 ffff 0038 0000     $... .......8...
    80012f4c:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012f5c:	0c00 1002 0e44 0000 0024 0000 0248 0000     ....D...$...H...
    80012f6c:	de18 ffff 002c 0000 4400 000e 0000 8800     ....,....D......
    80012f7c:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    80012f8c:	0024 0000 0270 0000 de1c ffff 002c 0000     $...p.......,...
    80012f9c:	4400 000e 0000 8800 4404 080c 0000 0000     .D.......D......
    80012fac:	0c00 1002 0e44 0000 002c 0000 0298 0000     ....D...,.......
    80012fbc:	de20 ffff 0054 0000 4400 000e 0000 0000      ...T....D......
    80012fcc:	8900 4406 000c 0000 0000 0000 020c 4420     ...D.......... D
    80012fdc:	44c9 000e 0b44 0000 002c 0000 02c8 0000     .D..D...,.......
    80012fec:	de44 ffff 0060 0000 4400 000e 0000 0000     D...`....D......
    80012ffc:	8900 4406 000c 0000 0000 0000 020c 4420     ...D.......... D
    8001300c:	44c9 000e 0b44 0000 0024 0000 02f8 0000     .D..D...$.......
    8001301c:	de74 ffff 0028 0000 4400 000e 0000 8800     t...(....D......
    8001302c:	4404 080c 0000 0000 0c00 1002 0e44 0000     .D..........D...
    8001303c:	0020 0000 0320 0000 de74 ffff 0040 0000      ... ...t...@...
    8001304c:	4400 000e 0000 0000 0000 9200 4408 080c     .D...........D..
    8001305c:	0000 0000 0024 0000 0344 0000 de90 ffff     ....$...D.......
    8001306c:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    8001307c:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    8001308c:	036c 0000 de90 ffff 002c 0000 4400 000e     l.......,....D..
    8001309c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    800130ac:	0e44 0000 002c 0000 0394 0000 de94 ffff     D...,...........
    800130bc:	0074 0000 4400 000e 0000 0000 0000 9200     t....D..........
    800130cc:	4408 080c 0200 0000 0000 020c 4420 44c9     .D.......... D.D
    800130dc:	44d2 000e 0024 0000 03c4 0000 ded8 ffff     .D..$...........
    800130ec:	0028 0000 4400 000e 0000 8800 4404 080c     (....D.......D..
    800130fc:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    8001310c:	03ec 0000 ded8 ffff 0028 0000 4400 000e     ........(....D..
    8001311c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    8001312c:	0e44 0000 0018 0000 0000 0000 7a03 4c50     D............zPL
    8001313c:	0052 7c01 0701 6d9b ff49 1bff 0d1b 0002     R..|...mI.......
    8001314c:	0044 0000 0020 0000 e088 ffff 0220 0000     D... ....... ...
    8001315c:	9e04 ff48 44ff 000e 0000 0000 0000 0000     ..H..D..........
    8001316c:	0000 0000 0000 9600 4410 080c 0300 00d4     .........D......
    8001317c:	0000 0c00 4002 c944 d244 d344 d444 d544     .....@D.D.D.D.D.
    8001318c:	d644 0e44 0000 0000 0010 0000 0000 0000     D.D.............
    8001319c:	7a03 0052 7c01 0101 0d1b 0002 0024 0000     .zR..|......$...
    800131ac:	0018 0000 e24c ffff 0034 0000 4400 000e     ....L...4....D..
    800131bc:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    800131cc:	0e44 0000 0028 0000 0040 0000 e258 ffff     D...(...@...X...
    800131dc:	004c 0000 4400 000e 0000 0000 8900 4406     L....D.........D
    800131ec:	080c 0000 0000 0c00 2002 c944 0e44 0000     ......... D.D...
    800131fc:	0030 0000 00d0 0000 debc ffff 00c0 0000     0...............
    8001320c:	d004 ff47 44ff 000e 0000 0000 8900 4406     ..G..D.........D
    8001321c:	080c 0000 0000 0000 0c00 4002 c944 0e44     ...........@D.D.
    8001322c:	4400 000b 0024 0000 00a0 0000 df48 ffff     .D..$.......H...
    8001323c:	0034 0000 4400 000e 0000 8800 4404 080c     4....D.......D..
    8001324c:	0000 0000 0c00 1002 0e44 0000 0024 0000     ........D...$...
    8001325c:	00c8 0000 df54 ffff 0028 0000 4400 000e     ....T...(....D..
    8001326c:	0000 8800 4404 080c 0000 0000 0c00 1002     .....D..........
    8001327c:	0e44 0000 0000 0000 0000 0000 0000 0000     D...............
	...
